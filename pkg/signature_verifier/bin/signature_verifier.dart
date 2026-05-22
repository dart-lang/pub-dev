// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';

import 'package:pem/pem.dart';
import 'package:webcrypto/webcrypto.dart';

/// Main entrypoint for the `signature_verifier` CLI tool.
///
/// Mimics the command-line flags of OpenSSL dgst:
/// `signature_verifier dgst -sha256 -verify <pubKey.pem> -signature <sig.sign> <input.txt>`
Future<void> main(List<String> args) async {
  if (args.isEmpty || args[0] != 'dgst') {
    _printUsageAndExit();
  }

  if (!args.contains('-sha256')) {
    _printUsageAndExit();
  }

  String? pubKeyPath;
  String? sigPath;
  String? inPath;

  for (var i = 1; i < args.length; i++) {
    final arg = args[i];
    switch (arg) {
      case '-sha256':
        continue;
      case '-verify':
        i++;
        if (i < args.length) {
          pubKeyPath = args[i];
        }
      case '-signature':
        i++;
        if (i < args.length) {
          sigPath = args[i];
        }
      default:
        inPath = arg;
    }
  }

  if (pubKeyPath == null || sigPath == null || inPath == null) {
    _printUsageAndExit();
  }

  try {
    final pubKeyPem = await File(pubKeyPath!).readAsString();
    final signatureBytes = await File(sigPath!).readAsBytes();
    final inputBytes = await File(inPath!).readAsBytes();

    final isValid = await verifyRsaSignature(
      publicKeyPem: pubKeyPem,
      signature: signatureBytes,
      input: inputBytes,
    );

    if (isValid) {
      print('Verified OK');
      exit(0);
    } else {
      print('Verification Failure');
      exit(1);
    }
  } catch (e) {
    stderr.writeln('Error: $e');
    exit(1);
  }
}

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
  final List<int> derBytes;
  try {
    derBytes = decodePemBlocks(PemLabel.publicKey, publicKeyPem).single;
  } catch (e) {
    throw FormatException('Failed to parse PEM block: $e');
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

void _printUsageAndExit() {
  stderr.writeln(
    'Usage: signature_verifier dgst -sha256 -verify <pubKey.pem> -signature <sig.sign> <input.txt>',
  );
  exit(1);
}
