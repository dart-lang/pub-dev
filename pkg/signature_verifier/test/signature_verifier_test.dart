// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:signature_verifier/signature_verifier.dart';
import 'package:test/test.dart';
import 'package:webcrypto/webcrypto.dart';

void main() {
  group('verifyRsaSignature', () {
    late String publicKeyPem;
    late Uint8List validSignature;
    final input = utf8.encode('test-data');

    setUpAll(() async {
      // Generate a key pair for testing
      final keyPair = await RsassaPkcs1V15PrivateKey.generateKey(
        2048,
        BigInt.from(65537),
        Hash.sha256,
      );

      // Export public key as SPKI PEM
      final spki = await keyPair.publicKey.exportSpkiKey();
      final base64Spki = base64.encode(spki);
      publicKeyPem =
          '-----BEGIN PUBLIC KEY-----\n$base64Spki\n-----END PUBLIC KEY-----';

      // Sign the test data
      validSignature = await keyPair.privateKey.signBytes(input);
    });

    test('verifies valid signature', () async {
      final isValid = await verifyRsaSignature(
        publicKeyPem: publicKeyPem,
        signature: validSignature,
        input: input,
      );
      expect(isValid, isTrue);
    });

    test('fails on modified input', () async {
      final isValid = await verifyRsaSignature(
        publicKeyPem: publicKeyPem,
        signature: validSignature,
        input: utf8.encode('wrong-data'),
      );
      expect(isValid, isFalse);
    });

    test('fails on modified signature', () async {
      final modifiedSignature = Uint8List.fromList(validSignature);
      modifiedSignature[0] ^= 0xFF;

      final isValid = await verifyRsaSignature(
        publicKeyPem: publicKeyPem,
        signature: modifiedSignature,
        input: input,
      );
      expect(isValid, isFalse);
    });

    test('throws on empty public key', () {
      expect(
        () => verifyRsaSignature(
          publicKeyPem: '',
          signature: validSignature,
          input: input,
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('throws on invalid PEM format', () {
      expect(
        () => verifyRsaSignature(
          publicKeyPem: 'not-a-pem',
          signature: validSignature,
          input: input,
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('CLI integration', () {
    test(
      'binary can be executed and reports failure on non-existent files',
      () async {
        final process = await Process.start('./bin/signature_verifier', [
          'dgst',
          '-sha256',
          '-verify',
          'non-existent',
          '-signature',
          'non-existent',
          'non-existent',
        ]);
        final exitCode = await process.exitCode;
        expect(exitCode, equals(1));
        final stderrOutput = await process.stderr
            .transform(utf8.decoder)
            .join();
        expect(stderrOutput, contains('PathNotFoundException'));
      },
    );
  });
}
