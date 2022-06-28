// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pem/pem.dart';
import 'package:pub_dev/shared/utils.dart';

/// Randomly generated private and public RSA keypair.
@visibleForTesting
class RsaKeyPair {
  final Uint8List privateKey;
  final Uint8List publicKey;

  RsaKeyPair(this.privateKey, this.publicKey);
}

/// Generates a new RSA keypair using `openssl`.
@visibleForTesting
Future<RsaKeyPair> generateRsaKeyPair({
  int keySize = 2048,
}) async {
  return withTempDirectory((dir) async {
    final privateKeyPath = p.join(dir.path, 'private.pem');
    final publicKeyPath = p.join(dir.path, 'public.pem');
    final pr1 = await runProc(
      [
        'openssl',
        'genrsa',
        '-out',
        privateKeyPath,
        '$keySize',
      ],
      timeout: Duration(seconds: 10),
    );
    if (pr1.exitCode != 0) {
      throw Exception('Unable to run openssl:\n${pr1.asJoinedOutput}');
    }
    final privateContent = await File(privateKeyPath).readAsString();
    final privateKeyBytes = decodePemBlocks(PemLabel.privateKey,
            privateContent.replaceAll(' RSA PRIVATE KEY', ' PRIVATE KEY'))
        .single;

    final pr2 = await runProc(
      [
        'openssl',
        'rsa',
        '-in',
        privateKeyPath,
        '-pubout',
        '-out',
        publicKeyPath,
      ],
      timeout: Duration(seconds: 10),
    );
    if (pr2.exitCode != 0) {
      throw Exception('Unable to run openssl:\n${pr1.asJoinedOutput}');
    }
    final publicContent = await File(publicKeyPath).readAsString();
    final publicKeyBytes =
        decodePemBlocks(PemLabel.publicKey, publicContent).single;
    return RsaKeyPair(
      Uint8List.fromList(privateKeyBytes),
      Uint8List.fromList(publicKeyBytes),
    );
  });
}

/// Signs [input] text with the private RSA key and returns the signature bytes.
@visibleForTesting
Future<Uint8List> signTextWithRsa({
  required String input,
  required List<int> privateKey,
}) async {
  return await withTempDirectory((dir) async {
    final outputFile = File(p.join(dir.path, 'output.sign'));
    final inputFile = File(p.join(dir.path, 'input.txt'));
    await inputFile.writeAsString(input);
    final privateKeyFile = File(p.join(dir.path, 'private.pem'));
    await privateKeyFile.writeAsString(
        encodePemBlock(PemLabel.privateKey, privateKey)
            .replaceAll(' PRIVATE KEY', ' RSA PRIVATE KEY'));
    final pr = await runProc(
      [
        'openssl',
        'dgst',
        '-sha256',
        '-binary',
        '-sign',
        privateKeyFile.path,
        '-out',
        outputFile.path,
        inputFile.path,
      ],
      timeout: Duration(seconds: 10),
    );
    if (pr.exitCode != 0) {
      throw Exception('Unable to run openssl:\n${pr.asJoinedOutput}');
    }
    return await outputFile.readAsBytes();
  });
}

/// Verifies if [signature] is valid for [input], using the RSA public key.
///
/// The [publicKey] is expected to be in DER-encoded ASN.1 binary format, following
/// - https://datatracker.ietf.org/doc/html/rfc3447#appendix-A
/// - https://datatracker.ietf.org/doc/html/rfc7468#section-4
/// - https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.7
Future<bool> verifyTextWithRsaSignature({
  required String input,
  required List<int> signature,
  required List<int> publicKey,
}) async {
  return await withTempDirectory((dir) async {
    final inputFile = File(p.join(dir.path, 'input.txt'));
    await inputFile.writeAsString(input);
    final signatureFile = File(p.join(dir.path, 'input.sign'));
    await signatureFile.writeAsBytes(signature);
    final publicKeyFile = File(p.join(dir.path, 'public.pem'));
    final publicPemContent = encodePemBlock(PemLabel.publicKey, publicKey);
    await publicKeyFile.writeAsString(publicPemContent);
    final pr = await runProc(
      [
        'openssl',
        'dgst',
        '-sha256',
        '-verify',
        publicKeyFile.path,
        '-signature',
        signatureFile.path,
        inputFile.path,
      ],
      timeout: Duration(seconds: 10),
    );
    final output = pr.stdout.toString().trim();
    if (pr.exitCode != 0) {
      if (output == 'Verification Failure') {
        return false;
      }
      throw Exception('Unable to run openssl:\n${pr.asJoinedOutput}');
    }
    return output == 'Verified OK';
  });
}
