// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/attestation_verifier.dart';

/// An [AttestationVerifier] that does not verify Sigstore signatures.
///
/// Only the cryptographic step is replaced: the signer is taken from the
/// builder self-reported in the provenance statement (or defaults to the
/// `dart-lang/setup-dart` publishing workflow), so tests can use hand-crafted
/// bundles without a valid signature. Provenance parsing and the policy checks
/// are the real ones.
class FakeAttestationVerifier extends AttestationVerifier {
  static final _defaultSigner = GitHubWorkflowIdentity.tryParse(
    'https://github.com/dart-lang/setup-dart/'
    '.github/workflows/publish.yml@refs/tags/v2',
  )!;

  FakeAttestationVerifier({
    super.trustedSignerWorkflows,
    super.requireTaggedSignerRef,
  });

  /// The fake does not use the native library.
  @override
  void checkNativeLibrary() {}

  @override
  VerifiedSigner verifySignature({
    required List<int> archiveSha256,
    required String bundleJson,
  }) {
    GitHubWorkflowIdentity? builder;
    try {
      builder = BuildProvenance.parseBundle(bundleJson).builder;
    } on FormatException {
      // Not a provenance bundle: [AttestationVerifier.verify] parses it again
      // and reports the problem, the signer is irrelevant at that point.
    }
    return VerifiedSigner(
      identity: (builder ?? _defaultSigner).toString(),
      issuer: githubActionsOidcIssuer,
    );
  }
}
