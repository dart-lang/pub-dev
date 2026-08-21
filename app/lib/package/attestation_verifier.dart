// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_semver/pub_semver.dart';
import 'package:sigstore/sigstore.dart';

export 'package:sigstore/sigstore.dart';

/// Result of verifying a package attestation bundle.
class AttestationVerificationResult {
  final bool isValid;
  final String? repository;
  final String? signerIdentity;
  final String? oidcIssuer;
  final List<String> errors;

  AttestationVerificationResult({
    required this.isValid,
    this.repository,
    this.signerIdentity,
    this.oidcIssuer,
    this.errors = const [],
  });
}

/// Verifies package attestation bundles using Sigstore.
class AttestationVerifier {
  final String? _trustedRootJson;
  final bool _offline;

  AttestationVerifier({
    String? trustedRootJson,
    bool offline = true,
  })  : _trustedRootJson = trustedRootJson,
        _offline = offline;

  AttestationVerificationResult verify({
    required String packageName,
    required Version packageVersion,
    required List<int> archiveBytes,
    required SigstoreBundle bundle,
    String? pubspecRepository,
  }) {
    try {
      final client = SigstoreClient.create();
      final policy = SigstoreVerificationPolicy.create(
        pubspecRepository ?? '',
        'https://token.actions.githubusercontent.com',
        _offline,
        false,
        _trustedRootJson ?? '',
        '',
      );

      final result = client.verify(archiveBytes, false, bundle, policy);
      if (!result.isValid()) {
        return AttestationVerificationResult(
          isValid: false,
          errors: ['Attestation signature verification failed'],
        );
      }

      final identity = result.verifiedIdentity();
      final issuer = result.verifiedIssuer();
      String? repo;
      if (identity.startsWith('https://github.com/')) {
        final parts =
            identity.substring('https://github.com/'.length).split('/');
        if (parts.length >= 2) {
          repo = 'https://github.com/${parts[0]}/${parts[1]}';
        }
      }

      return AttestationVerificationResult(
        isValid: true,
        repository: repo ?? pubspecRepository,
        signerIdentity: identity,
        oidcIssuer: issuer,
      );
    } catch (e) {
      return AttestationVerificationResult(
        isValid: false,
        errors: [e.toString()],
      );
    }
  }
}
