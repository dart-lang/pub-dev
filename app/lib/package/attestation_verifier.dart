// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:meta/meta.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:sigstore/sigstore.dart';

export 'package:sigstore/sigstore.dart';

/// The OIDC issuer of tokens minted by GitHub Actions.
const githubActionsOidcIssuer = 'https://token.actions.githubusercontent.com';

const _inTotoStatementType = 'https://in-toto.io/Statement/v1';
const _inTotoPayloadType = 'application/vnd.in-toto+json';
const _slsaProvenancePredicateType = 'https://slsa.dev/provenance/v1';

/// The workflows trusted to sign attestations for packages on pub.dev, as
/// `<owner>/<repo>/<path>`.
///
/// This is the *signer* of an attestation - the reusable workflow that ran the
/// signing step - and not the repository a package was published from. All
/// packages are signed by the same small set of workflows, which is why the
/// signer identity says nothing about which package was built. That binding
/// comes from the provenance statement, see
/// [BuildProvenance.sourceRepository].
const defaultTrustedSignerWorkflows = <String>{
  'dart-lang/setup-dart/.github/workflows/publish.yml',
};

/// A GitHub repository, identified by its [owner] and [name].
///
/// GitHub treats owner and repository names case-insensitively, and so does
/// [operator ==].
class GitHubRepository {
  final String owner;
  final String name;

  GitHubRepository(this.owner, this.name);

  /// Parses a reference to a GitHub repository URL, or returns `null` if
  /// [source] does not denote one.
  ///
  /// Accepts the forms used in `pubspec.yaml`'s `repository:` field and in
  /// SLSA provenance statements:
  ///
  /// * `https://github.com/<owner>/<repo>`
  /// * `https://github.com/<owner>/<repo>.git`
  /// * `git+https://github.com/<owner>/<repo>@<ref>`
  /// * `https://github.com/<owner>/<repo>/tree/<ref>/<dir>` (monorepos)
  static GitHubRepository? tryParse(String source) {
    var s = source.trim();
    if (s.isEmpty) return null;
    if (s.startsWith('git+')) {
      s = s.substring('git+'.length);
      final at = s.lastIndexOf('@');
      if (at > 0) s = s.substring(0, at);
    }
    final uri = Uri.tryParse(s);
    if (uri == null) return null;
    if (uri.scheme != 'http' && uri.scheme != 'https') return null;
    final host = uri.host.toLowerCase();
    if (host != 'github.com' && host != 'www.github.com') return null;
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    if (segments.length < 2) return null;
    final owner = segments[0];
    var name = segments[1];
    if (name.endsWith('.git')) {
      name = name.substring(0, name.length - '.git'.length);
    }
    if (owner.isEmpty || name.isEmpty) return null;
    return GitHubRepository(owner, name);
  }

  /// Parses an `<owner>/<repo>` slug (as stored in
  /// `GitHubPublishingConfig.repository`) or a GitHub repository URL.
  static GitHubRepository? tryParseSlug(String source) {
    final fromUrl = tryParse(source);
    if (fromUrl != null) return fromUrl;
    final trimmed = source.trim();
    if (trimmed.isEmpty || trimmed.contains(':')) return null;
    final parts = trimmed.split('/');
    if (parts.length != 2) return null;
    final owner = parts[0];
    var name = parts[1];
    if (name.endsWith('.git')) {
      name = name.substring(0, name.length - '.git'.length);
    }
    if (owner.isEmpty || name.isEmpty) return null;
    return GitHubRepository(owner, name);
  }

  /// `<owner>/<name>`, as used by the GitHub API and in OIDC claims.
  String get slug => '$owner/$name';

  /// The canonical url of this repository.
  String get url => 'https://github.com/$owner/$name';

  @override
  bool operator ==(Object other) =>
      other is GitHubRepository &&
      owner.toLowerCase() == other.owner.toLowerCase() &&
      name.toLowerCase() == other.name.toLowerCase();

  @override
  int get hashCode => Object.hash(owner.toLowerCase(), name.toLowerCase());

  @override
  String toString() => url;
}

/// The identity of the workflow that signed an attestation.
///
/// This is the `job_workflow_ref` claim of the GitHub Actions OIDC token,
/// which Fulcio puts in the subject alternative name of the signing
/// certificate. For a reusable workflow it identifies the *reusable* workflow
/// - the trusted builder - and not the repository that called it.
class GitHubWorkflowIdentity {
  final GitHubRepository repository;

  /// The path of the workflow file within [repository], e.g.
  /// `.github/workflows/publish.yml`.
  final String path;

  /// The git ref the workflow ran at, e.g. `refs/tags/v2`.
  final String ref;

  GitHubWorkflowIdentity({
    required this.repository,
    required this.path,
    required this.ref,
  });

  /// Parses an identity of the form
  /// `https://github.com/<owner>/<repo>/<path>@<ref>`.
  static GitHubWorkflowIdentity? tryParse(String identity) {
    final at = identity.lastIndexOf('@');
    if (at <= 0) return null;
    final url = identity.substring(0, at);
    final ref = identity.substring(at + 1);
    if (ref.isEmpty) return null;
    final repository = GitHubRepository.tryParse(url);
    if (repository == null) return null;
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    if (segments.length < 3) return null;
    return GitHubWorkflowIdentity(
      repository: repository,
      path: segments.sublist(2).join('/'),
      ref: ref,
    );
  }

  /// `<owner>/<repo>/<path>` - the workflow without the ref it ran at.
  String get workflow => '${repository.slug}/$path';

  @override
  String toString() => '${repository.url}/$path@$ref';
}

/// An entry of the `subject` list of an in-toto statement.
class ProvenanceSubject {
  final String name;

  /// The lowercase hex-encoded sha256 digest, or `null` if the subject is not
  /// identified by a sha256.
  final String? sha256;

  ProvenanceSubject(this.name, this.sha256);
}

/// The SLSA build provenance of an artifact, as carried in the DSSE envelope
/// of a Sigstore bundle.
class BuildProvenance {
  /// The repository the build ran for.
  ///
  /// This is `github.repository` of the workflow run - for a reusable
  /// workflow, the repository that *called* the trusted builder. It is filled
  /// in by GitHub from the run context and cannot be set by the caller.
  final GitHubRepository sourceRepository;

  /// The ref of [sourceRepository] the build ran at, e.g. `refs/tags/v1.0.0`.
  final String? sourceRef;

  /// The path of the caller's workflow file.
  final String? workflowPath;

  /// The commit the build ran at, if recorded.
  final String? commitSha;

  /// The builder as self-reported in the statement.
  ///
  /// Note that the authoritative statement about who signed is the certificate
  /// identity, not this field.
  final GitHubWorkflowIdentity? builder;

  final List<ProvenanceSubject> subjects;

  BuildProvenance({
    required this.sourceRepository,
    required this.sourceRef,
    required this.workflowPath,
    required this.commitSha,
    required this.builder,
    required this.subjects,
  });

  /// Extracts the build provenance from the DSSE envelope of the Sigstore
  /// bundle in [bundleJson].
  ///
  /// Throws a [FormatException] if [bundleJson] is not a bundle carrying a
  /// SLSA build provenance statement.
  ///
  /// This does not validate any signature. Only use the result if
  /// `package:sigstore` has verified the very same [bundleJson].
  factory BuildProvenance.parseBundle(String bundleJson) {
    final Object? decoded;
    try {
      decoded = json.decode(bundleJson);
    } on FormatException catch (e) {
      throw FormatException('Attestation is not valid JSON: ${e.message}');
    }
    final bundle = _expectMap(decoded, 'bundle');
    final envelope = bundle['dsseEnvelope'];
    if (envelope == null) {
      throw const FormatException(
        'Attestation does not contain a `dsseEnvelope`, so it carries no '
        'build provenance.',
      );
    }
    final dsse = _expectMap(envelope, 'dsseEnvelope');
    final payloadType = dsse['payloadType'];
    if (payloadType != _inTotoPayloadType) {
      throw FormatException(
        'Attestation payload has type `$payloadType`, '
        'expected `$_inTotoPayloadType`.',
      );
    }
    final encodedPayload = dsse['payload'];
    if (encodedPayload is! String) {
      throw const FormatException('Attestation has no `payload`.');
    }
    final Object? decodedStatement;
    try {
      decodedStatement = json.decode(
        utf8.decode(base64.decode(encodedPayload)),
      );
    } on FormatException catch (e) {
      throw FormatException(
        'Attestation payload is not valid base64-encoded JSON: ${e.message}',
      );
    }
    final statement = _expectMap(decodedStatement, 'statement');

    final type = statement['_type'];
    if (type != _inTotoStatementType) {
      throw FormatException(
        'Attestation statement has type `$type`, '
        'expected `$_inTotoStatementType`.',
      );
    }
    final predicateType = statement['predicateType'];
    if (predicateType != _slsaProvenancePredicateType) {
      throw FormatException(
        'Attestation has predicate type `$predicateType`, '
        'expected `$_slsaProvenancePredicateType`.',
      );
    }

    final subjects = <ProvenanceSubject>[];
    final subjectList = statement['subject'];
    if (subjectList is! List || subjectList.isEmpty) {
      throw const FormatException('Attestation statement has no `subject`.');
    }
    for (final subject in subjectList) {
      final s = _expectMap(subject, 'subject');
      final name = s['name'];
      if (name is! String) {
        throw const FormatException('Attestation subject has no `name`.');
      }
      final digest = s['digest'];
      final sha256 = digest is Map ? digest['sha256'] : null;
      subjects.add(
        ProvenanceSubject(name, sha256 is String ? sha256.toLowerCase() : null),
      );
    }

    final predicate = _expectMap(statement['predicate'], 'predicate');
    final buildDefinition = _expectMap(
      predicate['buildDefinition'],
      'buildDefinition',
    );
    final externalParameters = _expectMap(
      buildDefinition['externalParameters'],
      'externalParameters',
    );
    final workflow = _expectMap(externalParameters['workflow'], 'workflow');

    final repositoryField = workflow['repository'];
    if (repositoryField is! String) {
      throw const FormatException(
        'Attestation does not state the repository it was built from.',
      );
    }
    final sourceRepository = GitHubRepository.tryParse(repositoryField);
    if (sourceRepository == null) {
      throw FormatException(
        'Attestation was built from `$repositoryField`, which is not a GitHub '
        'repository. Only GitHub is supported for now.',
      );
    }

    String? commitSha;
    final resolvedDependencies = buildDefinition['resolvedDependencies'];
    if (resolvedDependencies is List) {
      for (final dependency in resolvedDependencies) {
        if (dependency is! Map) continue;
        final uri = dependency['uri'];
        if (uri is! String) continue;
        if (GitHubRepository.tryParse(uri) != sourceRepository) continue;
        final digest = dependency['digest'];
        final gitCommit = digest is Map ? digest['gitCommit'] : null;
        if (gitCommit is String) {
          commitSha = gitCommit;
          break;
        }
      }
    }

    GitHubWorkflowIdentity? builder;
    final runDetails = predicate['runDetails'];
    if (runDetails is Map) {
      final builderField = runDetails['builder'];
      final id = builderField is Map ? builderField['id'] : null;
      if (id is String) builder = GitHubWorkflowIdentity.tryParse(id);
    }

    final ref = workflow['ref'];
    final path = workflow['path'];
    return BuildProvenance(
      sourceRepository: sourceRepository,
      sourceRef: ref is String ? ref : null,
      workflowPath: path is String ? path : null,
      commitSha: commitSha,
      builder: builder,
      subjects: subjects,
    );
  }
}

Map<String, dynamic> _expectMap(Object? value, String what) {
  if (value is! Map<String, dynamic>) {
    throw FormatException('Attestation `$what` is not a JSON object.');
  }
  return value;
}

/// Result of verifying a package attestation bundle.
class AttestationVerificationResult {
  final bool isValid;
  final String? repository;
  final BuildProvenance? provenance;
  final String? signerIdentity;
  final String? oidcIssuer;
  final List<String> errors;

  AttestationVerificationResult({
    required this.isValid,
    this.repository,
    this.provenance,
    this.signerIdentity,
    this.oidcIssuer,
    this.errors = const [],
  });

  AttestationVerificationResult.failure({
    this.signerIdentity,
    this.oidcIssuer,
    required this.errors,
  }) : isValid = false,
       repository = null,
       provenance = null;
}

/// Verifies package attestation bundles using Sigstore and SLSA build
/// provenance policy.
class AttestationVerifier {
  final String? _trustedRootJson;
  final bool _offline;
  final Set<String> _trustedSignerWorkflows;
  final bool _requireTaggedSignerRef;

  @visibleForTesting
  static bool skipSignatureCheckInTest = false;

  AttestationVerifier({
    String? trustedRootJson,
    bool offline = true,
    Set<String> trustedSignerWorkflows = defaultTrustedSignerWorkflows,
    bool requireTaggedSignerRef = false,
  }) : _trustedRootJson = trustedRootJson,
       _offline = offline,
       _trustedSignerWorkflows = trustedSignerWorkflows,
       _requireTaggedSignerRef = requireTaggedSignerRef;

  /// Verifies that [archiveBytes] is the archive of [packageName] at
  /// [packageVersion], built by a trusted workflow from [pubspecRepository]
  /// (and [configuredGitHubRepository] when automated publishing is enabled).
  ///
  /// [bundleJson] is passed as a raw JSON string so that signature verification
  /// and DSSE provenance parsing operate on the exact same bytes.
  AttestationVerificationResult verify({
    required String packageName,
    required Version packageVersion,
    required List<int> archiveBytes,
    required String bundleJson,
    String? pubspecRepository,
    String? configuredGitHubRepository,
    bool requireRepository = true,
  }) {
    String? identity;
    String? issuer;
    try {
      final GitHubWorkflowIdentity signer;
      if (skipSignatureCheckInTest) {
        final BuildProvenance provenance;
        try {
          provenance = BuildProvenance.parseBundle(bundleJson);
        } on FormatException catch (e) {
          return AttestationVerificationResult.failure(errors: [e.message]);
        }
        signer =
            provenance.builder ??
            GitHubWorkflowIdentity.tryParse(
              'https://github.com/dart-lang/setup-dart/'
              '.github/workflows/publish.yml@refs/tags/v2',
            )!;
        identity = signer.toString();
        issuer = githubActionsOidcIssuer;
      } else {
        final bundle = SigstoreBundle.fromJson(bundleJson);
        final client = SigstoreClient.create();
        // The expected identity is left unrestricted here and enforced below
        // against [_trustedSignerWorkflows]: we accept a set of workflows, and
        // the ref they ran at varies.
        final policy = SigstoreVerificationPolicy.create(
          '',
          githubActionsOidcIssuer,
          _offline,
          false,
          _trustedRootJson ?? '',
          '',
        );

        final result = client.verify(archiveBytes, false, bundle, policy);
        if (!result.isValid()) {
          return AttestationVerificationResult.failure(
            errors: ['Attestation signature verification failed'],
          );
        }

        identity = result.verifiedIdentity();
        issuer = result.verifiedIssuer();

        final parsedSigner = GitHubWorkflowIdentity.tryParse(identity);
        if (parsedSigner == null) {
          return AttestationVerificationResult.failure(
            signerIdentity: identity,
            oidcIssuer: issuer,
            errors: [
              'Package attestation verification is currently only supported '
                  'for GitHub Actions workflows (signer identity: "$identity").',
            ],
          );
        }
        signer = parsedSigner;
      }

      final BuildProvenance provenance;
      try {
        provenance = BuildProvenance.parseBundle(bundleJson);
      } on FormatException catch (e) {
        return AttestationVerificationResult.failure(
          signerIdentity: identity,
          oidcIssuer: issuer,
          errors: [e.message],
        );
      }

      final errors = checkProvenancePolicy(
        packageName: packageName,
        packageVersion: packageVersion,
        archiveSha256: sha256.convert(archiveBytes).toString(),
        provenance: provenance,
        signer: signer,
        oidcIssuer: issuer,
        pubspecRepository: pubspecRepository,
        configuredGitHubRepository: configuredGitHubRepository,
        requireRepository: requireRepository,
        trustedSignerWorkflows: _trustedSignerWorkflows,
        requireTaggedSignerRef: _requireTaggedSignerRef,
      );
      if (errors.isNotEmpty) {
        return AttestationVerificationResult.failure(
          signerIdentity: identity,
          oidcIssuer: issuer,
          errors: errors,
        );
      }

      return AttestationVerificationResult(
        isValid: true,
        repository: provenance.sourceRepository.url,
        provenance: provenance,
        signerIdentity: identity,
        oidcIssuer: issuer,
      );
    } on SigstoreError catch (e) {
      return AttestationVerificationResult.failure(
        signerIdentity: identity,
        oidcIssuer: issuer,
        errors: [
          switch (e) {
            SigstoreError.invalidBundle =>
              'Attestation is not a valid Sigstore bundle.',
            SigstoreError.verificationFailed =>
              'Attestation signature verification failed.',
            SigstoreError.internalError =>
              'Internal error while verifying the attestation.',
          },
        ],
      );
    } on UnsupportedError catch (e) {
      return AttestationVerificationResult.failure(
        signerIdentity: identity,
        oidcIssuer: issuer,
        errors: [
          'Attestations cannot be verified on this platform: ${e.message}',
        ],
      );
    } catch (e) {
      return AttestationVerificationResult.failure(
        signerIdentity: identity,
        oidcIssuer: issuer,
        errors: [e.toString()],
      );
    }
  }
}

/// Checks a cryptographically verified attestation against pub.dev's policy,
/// and returns the list of violations - empty if the attestation is acceptable.
List<String> checkProvenancePolicy({
  required String packageName,
  required Version packageVersion,
  required String archiveSha256,
  required BuildProvenance provenance,
  required GitHubWorkflowIdentity signer,
  String? oidcIssuer,
  String? pubspecRepository,
  String? configuredGitHubRepository,
  bool requireRepository = true,
  Set<String> trustedSignerWorkflows = defaultTrustedSignerWorkflows,
  bool requireTaggedSignerRef = false,
}) {
  final errors = <String>[];

  if (oidcIssuer != null && oidcIssuer != githubActionsOidcIssuer) {
    errors.add(
      'Attestation was issued by "$oidcIssuer", '
      'expected "$githubActionsOidcIssuer".',
    );
  }

  // Who signed? Only a small set of workflows may sign packages for pub.dev.
  final trusted = trustedSignerWorkflows.map((w) => w.toLowerCase()).toSet();
  if (!trusted.contains(signer.workflow.toLowerCase())) {
    errors.add(
      'Attestation was signed by "${signer.workflow}", which is not a '
      'workflow trusted to publish packages. Trusted workflows: '
      '${(trustedSignerWorkflows.toList()..sort()).join(', ')}.',
    );
  } else if (requireTaggedSignerRef && !signer.ref.startsWith('refs/tags/')) {
    errors.add(
      'Attestation was signed by "${signer.workflow}" at "${signer.ref}", '
      'but only tagged releases of the publishing workflow are trusted.',
    );
  } else if (!signer.ref.startsWith('refs/tags/') &&
      !signer.ref.startsWith('refs/heads/')) {
    errors.add(
      'Attestation was signed by "${signer.workflow}" at "${signer.ref}", '
      'which is not a branch or tag ref.',
    );
  }
  final builder = provenance.builder;
  if (builder != null &&
      builder.workflow.toLowerCase() != signer.workflow.toLowerCase()) {
    errors.add(
      'Attestation states it was built by "${builder.workflow}" but was '
      'signed by "${signer.workflow}".',
    );
  }

  // What was signed?
  final expectedSubject = '$packageName-$packageVersion.tar.gz';
  final subject = provenance.subjects
      .where((s) => s.name == expectedSubject || s.name == 'package.tar.gz')
      .firstOrNull;
  if (subject == null) {
    errors.add(
      'Attestation is for '
      '${provenance.subjects.map((s) => '"${s.name}"').join(', ')}, '
      'not for "$expectedSubject".',
    );
  } else if (subject.sha256 != archiveSha256.toLowerCase()) {
    errors.add(
      'Attestation is for an archive with sha256 "${subject.sha256}", '
      'but the uploaded archive has sha256 "$archiveSha256".',
    );
  }

  // Where was it built? Verify against the pubspec.yaml `repository` inside the
  // uploaded tarball.
  if (pubspecRepository == null || pubspecRepository.trim().isEmpty) {
    if (requireRepository) {
      errors.add(
        'The pubspec.yaml of $packageName $packageVersion does not have a '
        '`repository` field, so the attestation cannot be bound to the '
        'repository it claims to come from '
        '("${provenance.sourceRepository.url}").',
      );
    }
  } else {
    final expected = GitHubRepository.tryParse(pubspecRepository);
    if (expected == null) {
      errors.add(
        'Package attestation verification is currently only supported for '
        'GitHub repositories, but the pubspec.yaml of $packageName '
        '$packageVersion declares `repository: $pubspecRepository`.',
      );
    } else if (expected != provenance.sourceRepository) {
      errors.add(
        'Attestation states the package was built from '
        '"${provenance.sourceRepository.url}", but the pubspec.yaml of '
        '$packageName $packageVersion declares `repository: '
        '$pubspecRepository`.',
      );
    }
  }

  // When GitHub Actions automated publishing is configured on pub.dev for this
  // package, also verify that the provenance source repository matches the
  // stored automated publishing repository configuration (and not just the
  // self-asserted `repository:` field inside the uploaded tarball's
  // pubspec.yaml).
  if (configuredGitHubRepository != null &&
      configuredGitHubRepository.trim().isNotEmpty) {
    final configuredRepo = GitHubRepository.tryParseSlug(
      configuredGitHubRepository,
    );
    if (configuredRepo == null ||
        configuredRepo != provenance.sourceRepository) {
      errors.add(
        'Attestation states the package was built from '
        '"${provenance.sourceRepository.url}", which does not match the '
        'configured GitHub Actions automated publishing repository '
        '"$configuredGitHubRepository".',
      );
    }
  }

  return errors;
}
