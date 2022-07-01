// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// TODO: remove these utils when the features are implemented and these may not be used anymore.

import 'dart:io';
import 'dart:typed_data';

import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pem/pem.dart';
import 'package:pub_dev/service/openid/openssl_commands.dart';
import 'package:pub_dev/shared/utils.dart';

/// Randomly generated private and public RSA keypair.
class RsaKeyPair {
  final Uint8List privateKey;
  final Asn1RsaPublicKey publicKey;

  RsaKeyPair(this.privateKey, this.publicKey);
}

/// Generates a new RSA keypair using `openssl`.
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
      Asn1RsaPublicKey.fromDerEncodedBytes(publicKeyBytes),
    );
  });
}

/// Signs [input] text with the private RSA key and returns the signature bytes.
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
