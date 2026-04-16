// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/service/openid/crypto_helpers.dart';
import 'package:test/test.dart';

import 'crypto_test_utils.dart';

void main() {
  String? _signatureVerifierPath;

  setUpAll(() async {
    final binaryFile = await buildSignatureVerifierExecutable();
    _signatureVerifierPath = binaryFile.path;
  });

  group('openssl commands', () {
    test('sign and verify', () async {
      final inputText = 'inputText';
      final pair = await generateRsaKeyPair();
      final signature = await signTextWithRsa(
        input: inputText,
        privateKey: pair.privateKey,
      );
      final valid = await verifyTextWithRsaSignature(
        input: inputText,
        signature: signature,
        publicKey: pair.publicKey,
        signatureVerifierPath: _signatureVerifierPath,
      );
      expect(valid, isTrue);
      final invalid = await verifyTextWithRsaSignature(
        input: inputText,
        signature: signature.map((e) => e ~/ 2).toList(),
        publicKey: pair.publicKey,
        signatureVerifierPath: _signatureVerifierPath,
      );
      expect(invalid, isFalse);
    });
  });
}
