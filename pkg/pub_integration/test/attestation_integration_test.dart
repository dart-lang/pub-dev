// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/pub_http_client.dart';
import 'package:tar/tar.dart';
import 'package:test/test.dart';

Future<List<int>> _createArchiveBytes({required String pubspecContent}) async {
  final entries = [
    TarEntry.data(
      TarHeader(name: 'pubspec.yaml', mode: 420),
      utf8.encode(pubspecContent),
    ),
    TarEntry.data(
      TarHeader(name: 'LICENSE', mode: 420),
      utf8.encode('BSD-3-Clause'),
    ),
    TarEntry.data(
      TarHeader(name: 'README.md', mode: 420),
      utf8.encode('# Attested Package\n'),
    ),
    TarEntry.data(
      TarHeader(name: 'lib/attested.dart', mode: 420),
      utf8.encode('void hello() => print("hello");\n'),
    ),
  ];

  final stream = Stream.fromIterable(
    entries,
  ).cast<TarEntry>().transform(tarWriter).transform(gzip.encoder);
  return await stream.expand((chunk) => chunk).toList();
}

Map<String, dynamic> _createAttestationBundle({
  required String packageName,
  required String version,
  required String repository,
  required String archiveSha256,
}) {
  final statement = {
    '_type': 'https://in-toto.io/Statement/v1',
    'subject': [
      {
        'name': '$packageName-$version.tar.gz',
        'digest': {'sha256': archiveSha256},
      },
    ],
    'predicateType': 'https://slsa.dev/provenance/v1',
    'predicate': {
      'buildDefinition': {
        'buildType': 'https://actions.github.io/buildtypes/workflow/v1',
        'externalParameters': {
          'workflow': {
            'ref': 'refs/tags/v$version',
            'repository': repository,
            'path': '.github/workflows/publish.yaml',
          },
        },
        'resolvedDependencies': [
          {
            'uri': 'git+$repository@refs/tags/v$version',
            'digest': {'gitCommit': '7891abbe3dab159e9d0187fc1042d5e0cd82cfad'},
          },
        ],
      },
      'runDetails': {
        'builder': {
          'id':
              'https://github.com/dart-lang/ecosystem/.github/workflows/publish.yaml@refs/heads/main',
        },
      },
    },
  };

  final derBytes = <int>[
    0x30,
    0x82,
    0x01,
    0x00,
    ...utf8.encode(repository),
    ...utf8.encode('https://token.actions.githubusercontent.com'),
  ];

  return {
    'mediaType': 'application/vnd.dev.sigstore.bundle.v0.3+json',
    'verificationMaterial': {
      'certificate': {'rawBytes': base64Encode(derBytes)},
      'tlogEntries': [
        {
          'logIndex': '123456',
          'inclusionProof': {
            'rootHash': 'test-root-hash',
            'hashes': ['hash1', 'hash2'],
          },
        },
      ],
    },
    'dsseEnvelope': {
      'payloadType': 'application/vnd.in-toto+json',
      'payload': base64Encode(utf8.encode(jsonEncode(statement))),
      'signatures': [
        {'sig': base64Encode(utf8.encode('test-signature'))},
      ],
    },
  };
}

void main() {
  group('Package attestation integration', () {
    late final TestContextProvider fakeTestScenario;
    late final PubHttpClient pubHttpClient;
    late final String adminAuthToken;

    setUpAll(() async {
      fakeTestScenario = await TestContextProvider.start();
      pubHttpClient = PubHttpClient(fakeTestScenario.pubHostedUrl);
      final adminUser = await fakeTestScenario.createTestUser(
        email: 'admin@pub.dev',
      );
      final creds = await adminUser.createCredentials();
      adminAuthToken =
          (creds['accessToken'] ??
                  creds['token'] ??
                  creds['idToken'] ??
                  'fake-admin-token')
              as String;
    });

    tearDownAll(() async {
      await pubHttpClient.close();
      await fakeTestScenario.close();
    });

    test(
      'upload valid package with attestation and retrieve via API',
      () async {
        const pkgName = 'attested_integration_pkg';
        const version = '1.0.0';
        const repo = 'https://github.com/dart-lang/attested_integration_pkg';

        final pubspecContent =
            '''
name: $pkgName
version: $version
description: Integration tested package with Sigstore attestation.
repository: $repo
environment:
  sdk: '>=3.0.0 <4.0.0'
''';

        final archiveBytes = await _createArchiveBytes(
          pubspecContent: pubspecContent,
        );
        final archiveSha = sha256.convert(archiveBytes).toString();

        final bundleJson = _createAttestationBundle(
          packageName: pkgName,
          version: version,
          repository: repo,
          archiveSha256: archiveSha,
        );
        final attestationBytes = utf8.encode(jsonEncode(bundleJson));

        final uploadRs = await pubHttpClient.uploadPackage(
          authToken: adminAuthToken,
          packageBytes: archiveBytes,
          attestationBytes: attestationBytes,
        );
        expect(uploadRs.statusCode, 200);
        expect(uploadRs.body, contains('Successfully uploaded'));

        // Retrieve via GET /api/packages/<pkg>/versions/<ver>/attestation
        final retrievedContent = await pubHttpClient.getAttestation(
          pkgName,
          version,
        );
        expect(retrievedContent, isNotNull);
        final retrievedJson =
            jsonDecode(retrievedContent!) as Map<String, dynamic>;
        expect(
          retrievedJson['mediaType'],
          equals('application/vnd.dev.sigstore.bundle.v0.3+json'),
        );
        expect(retrievedJson['dsseEnvelope'], isNotNull);

        // Non-existent version returns null (404)
        final notFound = await pubHttpClient.getAttestation(pkgName, '2.0.0');
        expect(notFound, isNull);
      },
    );

    test(
      'upload fails when attestation digest does not match archive',
      () async {
        const pkgName = 'tampered_integration_pkg';
        const version = '1.0.0';
        const repo = 'https://github.com/dart-lang/tampered_integration_pkg';

        final pubspecContent =
            '''
name: $pkgName
version: $version
description: Package with tampered attestation.
repository: $repo
environment:
  sdk: '>=3.0.0 <4.0.0'
''';

        final archiveBytes = await _createArchiveBytes(
          pubspecContent: pubspecContent,
        );

        // Intentionally wrong sha
        const fakeSha =
            '0000000000000000000000000000000000000000000000000000000000000000';

        final bundleJson = _createAttestationBundle(
          packageName: pkgName,
          version: version,
          repository: repo,
          archiveSha256: fakeSha,
        );
        final attestationBytes = utf8.encode(jsonEncode(bundleJson));

        final uploadRs = await pubHttpClient.uploadPackage(
          authToken: adminAuthToken,
          packageBytes: archiveBytes,
          attestationBytes: attestationBytes,
        );

        expect(uploadRs.statusCode, 400);
        expect(uploadRs.body, contains('Invalid package attestation'));
      },
    );
  }, timeout: Timeout.factor(testTimeoutFactor));
}
