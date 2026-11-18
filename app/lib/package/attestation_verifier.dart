// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:crypto/crypto.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:sigstore/provenance.dart';
import 'package:sigstore/sigstore.dart';

import 'models.dart' show VersionProvenance;

export 'package:sigstore/provenance.dart';
export 'package:sigstore/sigstore.dart';

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

/// Result of verifying a package attestation bundle.
class AttestationVerificationResult {
  final bool isValid;
  final String? repository;
  final BuildProvenance? provenance;
  final String? signerIdentity;
  final String? oidcIssuer;
  final TransparencyLogEntry? transparencyLogEntry;
  final List<String> errors;

  AttestationVerificationResult({
    required this.isValid,
    this.repository,
    this.provenance,
    this.signerIdentity,
    this.oidcIssuer,
    this.transparencyLogEntry,
    this.errors = const [],
  });

  AttestationVerificationResult.failure({
    this.signerIdentity,
    this.oidcIssuer,
    required this.errors,
  }) : isValid = false,
       repository = null,
       provenance = null,
       transparencyLogEntry = null;

  /// The verified facts to persist with the package version.
  ///
  /// Throws a [StateError] if the verification was not successful.
  VersionProvenance toVersionProvenance() {
    if (!isValid) {
      throw StateError('The attestation did not verify: $errors');
    }
    final provenance = this.provenance!;
    return VersionProvenance(
      repository: provenance.sourceRepository.slug,
      repositoryId: provenance.repositoryId,
      repositoryOwnerId: provenance.repositoryOwnerId,
      workflowPath: provenance.workflowPath,
      ref: provenance.sourceRef,
      commitSha: provenance.commitSha,
      runUrl: provenance.runUrl,
      signer: signerIdentity!,
      issuer: oidcIssuer!,
      transparencyLogIndex: transparencyLogEntry?.logIndex,
      transparencyLogIntegratedTime: transparencyLogEntry?.integratedTime,
    );
  }
}

/// The identity of the signer of an attestation, as verified by Sigstore.
class VerifiedSigner {
  /// The subject alternative name of the signing certificate - for GitHub
  /// Actions the `job_workflow_ref` of the signing workflow.
  final String identity;

  /// The OIDC issuer that authenticated the signer.
  final String issuer;

  VerifiedSigner({required this.identity, required this.issuer});
}

/// Sets the attestation verifier service.
void registerAttestationVerifier(AttestationVerifier value) =>
    ss.register(#_attestationVerifier, value);

/// The active attestation verifier service.
AttestationVerifier get attestationVerifier =>
    ss.lookup(#_attestationVerifier) as AttestationVerifier;

/// Verifies package attestation bundles using Sigstore and SLSA build
/// provenance policy.
class AttestationVerifier {
  final String? _trustedRootJson;
  final bool _offline;
  final Set<String> _trustedSignerWorkflows;
  final bool _requireTaggedSignerRef;

  AttestationVerifier({
    String? trustedRootJson,
    bool offline = true,
    Set<String> trustedSignerWorkflows = defaultTrustedSignerWorkflows,
    bool requireTaggedSignerRef = false,
  }) : _trustedRootJson = trustedRootJson,
       _offline = offline,
       _trustedSignerWorkflows = trustedSignerWorkflows,
       _requireTaggedSignerRef = requireTaggedSignerRef;

  /// Checks that the native libraries of `package:sigstore` and of
  /// `package:boring`, which it routes its cryptography through, can be loaded
  /// and called.
  ///
  /// Throws (an [ArgumentError] from `dart:ffi`) when the `@Native` bindings
  /// cannot be resolved - e.g. when the native assets mapping is missing from
  /// the snapshot the server runs from, see `tool/build-server-snapshot.sh`.
  /// Meant to be called at startup, so that a broken deployment fails loud
  /// instead of failing every attested upload.
  void checkNativeLibrary() {
    SigstoreClient.create();
  }

  /// Verifies that the archive with the sha256 digest [archiveSha256] is the
  /// archive of [packageName] at [packageVersion], built by a trusted workflow
  /// from [pubspecRepository] (and [configuredGitHubRepository] when automated
  /// publishing is enabled).
  ///
  /// [bundleJson] is passed as a raw JSON string so that signature verification
  /// and DSSE provenance parsing operate on the exact same bytes.
  ///
  /// Returns a failed [AttestationVerificationResult] when the bundle or the
  /// attestation it carries is not acceptable. Throws when the verification
  /// itself cannot be carried out (e.g. [SigstoreError.internalError] or a
  /// missing native library): such failures are not the uploader's fault and
  /// must not be reported as one.
  AttestationVerificationResult verify({
    required String packageName,
    required Version packageVersion,
    required List<int> archiveSha256,
    required String bundleJson,
    String? pubspecRepository,
    String? configuredGitHubRepository,
    bool requireRepository = true,
  }) {
    if (archiveSha256.length != 32) {
      throw ArgumentError.value(
        archiveSha256,
        'archiveSha256',
        'must be a 32-byte sha256 digest',
      );
    }

    // Who signed? Cryptographically verify the bundle over the archive digest.
    final VerifiedSigner verified;
    try {
      verified = verifySignature(
        archiveSha256: archiveSha256,
        bundleJson: bundleJson,
      );
    } on SigstoreError catch (e) {
      switch (e) {
        case SigstoreError.invalidBundle:
          return AttestationVerificationResult.failure(
            errors: ['Attestation is not a valid Sigstore bundle.'],
          );
        case SigstoreError.verificationFailed:
          return AttestationVerificationResult.failure(
            errors: ['Attestation signature verification failed.'],
          );
        case SigstoreError.internalError:
          rethrow;
      }
    }
    final identity = verified.identity;
    final issuer = verified.issuer;

    final signer = GitHubWorkflowIdentity.tryParse(identity);
    if (signer == null) {
      return AttestationVerificationResult.failure(
        signerIdentity: identity,
        oidcIssuer: issuer,
        errors: [
          'Package attestation verification is currently only supported '
              'for GitHub Actions workflows (signer identity: "$identity").',
        ],
      );
    }

    // What does the signed statement say?
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
      packageVersion: packageVersion.toString(),
      archiveSha256: Digest(archiveSha256).toString(),
      provenance: provenance,
      signer: signer,
      trustedSignerWorkflows: _trustedSignerWorkflows,
      oidcIssuer: issuer,
      expectedRepository: pubspecRepository,
      configuredRepository: configuredGitHubRepository,
      requireRepository: requireRepository,
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
      transparencyLogEntry: TransparencyLogEntry.tryParseBundle(bundleJson),
    );
  }

  /// Verifies the Sigstore signature of [bundleJson] over the artifact with
  /// the sha256 digest [archiveSha256], and returns the verified signer.
  ///
  /// Throws [SigstoreError.invalidBundle] if [bundleJson] is not a Sigstore
  /// bundle, [SigstoreError.verificationFailed] if the signature, certificate
  /// chain or transparency log entry do not verify, and other errors when the
  /// verification cannot be carried out.
  ///
  /// Only the cryptographic part lives here, so that tests can replace it
  /// (see `FakeAttestationVerifier`) while exercising the real provenance
  /// parsing and policy.
  @visibleForOverriding
  VerifiedSigner verifySignature({
    required List<int> archiveSha256,
    required String bundleJson,
  }) {
    final bundle = SigstoreBundle.fromJson(bundleJson);
    final client = SigstoreClient.create();
    // The expected identity is left unrestricted here and enforced by
    // [checkProvenancePolicy] against the trusted signer workflows: we accept
    // a set of workflows, and the ref they ran at varies.
    final policy = SigstoreVerificationPolicy.create(
      '',
      githubActionsOidcIssuer,
      _offline,
      false,
      _trustedRootJson ?? '',
      '',
    );
    // Verifying against the digest (`isDigest: true`) avoids reading and
    // hashing the archive again; the subject digest of the in-toto statement
    // is compared against it.
    final result = client.verify(archiveSha256, true, bundle, policy);
    if (!result.isValid()) {
      // `package:sigstore` reports failures by throwing this enum, keep the
      // defensive check consistent with it.
      // ignore: only_throw_errors
      throw SigstoreError.verificationFailed;
    }
    return VerifiedSigner(
      identity: result.verifiedIdentity(),
      issuer: result.verifiedIssuer(),
    );
  }
}
