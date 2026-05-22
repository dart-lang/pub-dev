// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert' show base64;
import 'dart:typed_data';
import 'package:pem/pem.dart';
import 'package:webcrypto/webcrypto.dart';

/// Verifies if [signature] is a valid PKCS1 v1.5 SHA-256 signature for [input],
/// using the RSA public key provided in [publicKeyPem].
///
/// The [publicKeyPem] is expected to be a PEM-encoded SubjectPublicKeyInfo (SPKI)
/// or PKCS1 public key string.
///
/// Preconditions:
/// * [publicKeyPem] must not be empty.
/// * [signature] must not be empty.
///
/// Throws a [FormatException] if [publicKeyPem] is not a valid PEM format or is empty.
/// Throws an [ArgumentError] if [signature] is empty.
Future<bool> verifyRsaSignature({
  required String publicKeyPem,
  required List<int> signature,
  required List<int> input,
}) async {
  if (publicKeyPem.isEmpty) {
    throw FormatException('Public key PEM string cannot be empty.');
  }
  if (signature.isEmpty) {
    throw ArgumentError.value(
      signature,
      'signature',
      'Signature cannot be empty.',
    );
  }

  // Parse and decode the PEM Public Key.
  List<int> derBytes;
  try {
    derBytes = decodePemBlocks(PemLabel.publicKey, publicKeyPem).single;
  } catch (_) {
    // Fallback: manually decode base64 from PEM lines, allowing other labels
    // like "RSA PUBLIC KEY".
    try {
      final lines = publicKeyPem.split('\n');
      final base64Lines = lines.where((line) {
        final trimmed = line.trim();
        return trimmed.isNotEmpty && !trimmed.startsWith('-----');
      });
      derBytes = base64.decode(base64Lines.join(''));
    } catch (e) {
      throw FormatException('Failed to parse PEM block: $e');
    }
  }

  // Import the RSA public key.
  final RsassaPkcs1V15PublicKey pubKey;
  try {
    pubKey = await RsassaPkcs1V15PublicKey.importSpkiKey(
      Uint8List.fromList(derBytes),
      Hash.sha256,
    );
  } catch (e) {
    throw FormatException('Failed to import public key: $e');
  }

  // Verify the signature of the input data.
  return await pubKey.verifyBytes(
    Uint8List.fromList(signature),
    Uint8List.fromList(input),
  );
}
