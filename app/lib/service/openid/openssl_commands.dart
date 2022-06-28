// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pem/pem.dart';
import 'package:pub_dev/shared/utils.dart';

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
