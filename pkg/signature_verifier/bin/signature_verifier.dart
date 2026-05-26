// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:signature_verifier/signature_verifier.dart';

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

void _printUsageAndExit() {
  stderr.writeln(
    'Usage: signature_verifier dgst -sha256 -verify <pubKey.pem> -signature <sig.sign> <input.txt>',
  );
  exit(1);
}
