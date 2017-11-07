// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library googleapis_auth.pem;

import 'dart:convert';
import 'dart:typed_data';

import 'asn1.dart';
import 'rsa.dart';

/// Decode a [RSAPrivateKey] from the string content of a PEM file.
///
/// A PEM file can be extracted from a .p12 cryptostore with
/// $ openssl pkcs12 -nocerts -nodes -passin pass:notasecret \
///       -in *-privatekey.p12 -out *-privatekey.pem
RSAPrivateKey keyFromString(String pemFileString) {
  if (pemFileString == null) {
    throw new ArgumentError('Argument must not be null.');
  }
  var bytes = _getBytesFromPEMString(pemFileString);
  return _extractRSAKeyFromDERBytes(bytes);
}

/// Helper function for decoding the base64 in [pemString].
Uint8List _getBytesFromPEMString(String pemString) {
  var lines = pemString
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.length > 0)
      .toList();

  if (lines.length < 2 ||
      !lines.first.startsWith('-----BEGIN') ||
      !lines.last.startsWith('-----END')) {
    throw new ArgumentError('The given string does not have the correct '
        'begin/end markers expected in a PEM file.');
  }
  var base64 = lines.sublist(1, lines.length - 1).join('');
  return new Uint8List.fromList(BASE64.decode(base64));
}

/// Helper to decode the ASN.1/DER bytes in [bytes] into an [RSAPrivateKey].
RSAPrivateKey _extractRSAKeyFromDERBytes(Uint8List bytes) {
  // We recognize two formats:
  // Real format:
  //
  // PrivateKey := seq[int/version=0, int/n, int/e, int/d, int/p,
  //                   int/q, int/dmp1, int/dmq1, int/coeff]
  //
  // Or the above `PrivateKey` embeddded inside another ASN object:
  // Encapsulated := seq[int/version=0,
  //                     seq[obj-id/rsa-id, null-obj],
  //                     octet-string/PrivateKey]
  //

  RSAPrivateKey privateKeyFromSequence(asnSequence) {
    var objects = asnSequence.objects;
    var version = objects[0];
    if (version.integer != 0) {
      throw new ArgumentError('Expected version 0, got: ${version.integer}.');
    }

    var key = new RSAPrivateKey(
        objects[1].integer,
        objects[2].integer,
        objects[3].integer,
        objects[4].integer,
        objects[5].integer,
        objects[6].integer,
        objects[7].integer,
        objects[8].integer);

    var bitLength = key.bitLength;
    if (bitLength != 1024 && bitLength != 2048 && bitLength != 4096) {
      throw new ArgumentError('The RSA modulus has a bit length of $bitLength. '
          'Only 1024, 2048 and 4096 are supported.');
    }
    return key;
  }

  try {
    var asn = ASN1Parser.parse(bytes);
    if (asn is ASN1Sequence) {
      var objects = asn.objects;
      if (objects.length == 3 && objects[2] is ASN1OctetString) {
        ASN1OctetString string = objects[2];
        // Seems like the embedded form.
        // TODO: Validate that rsa identifier matches!
        return privateKeyFromSequence(ASN1Parser.parse(string.bytes));
      }
    }
    return privateKeyFromSequence(asn);
  } catch (error) {
    throw new ArgumentError(
        'Error while extracting private key from DER bytes: $error');
  }
}

/*
 * Example of generating a public/private RSA keypair with 2048 bits and dumping
 * the structure of the resulting private key.

    $ openssl genrsa -out key.pem 2048
      Generating RSA private key, 2048 bit long modulus
      ..................................................+++
      ..................................................+++
      e is 65537 (0x10001)

    $ cat key.pem
      -----BEGIN RSA PRIVATE KEY-----
      MIIEowIBAAKCAQEAuDOwXO14ltE1j2O0iDSuqtbw/1kMKjeiki3oehk2zNoUte42
      /s2rX15nYCkKtYG/r8WYvKzb31P4Uow1S4fFydKNWxgX4VtEjHgeqfPxeCL9wiJc
      9KkEt4fyhj1Jo7193gCLtovLAFwPzAMbFLiXWkfqalJ5Z77fOE4Mo7u4pEgxNPgL
      VFGe0cEOAsHsKlsze+m1pmPHwWNVTcoKe5o0hOzy6hCPgVc6me6Y7aO8Fb4OVg0l
      XQdQpWn2ikVBpzBcZ6InnYyJ/CJNa3WL1LJ65mmYnfHtKGoMqhLK48OReguwRwwF
      e9/2+8UcdZcN5rsvt7yg3ZrKNH8rx+wZ36sRewIDAQABAoIBAQCn1HCcOsHkqDlk
      rDOQ5m8+uRhbj4bF8GrvRWTL2q1TeF/mY2U4Q6wg+KK3uq1HMzCzthWz0suCb7+R
      dq4YY1ySxoSEuy8G5WFPmyJVNy6Lh1Yty6FmSZlCn1sZdD3kMoK8A0NIz5Xmffrm
      pu3Fs2ozl9K9jOeQ3xgC9RoPFLrm8lHJ45Vn+SnTxZnsXT6pwpg3TnFIx5ZinU8k
      l0Um1n80qD2QQDakQ5jyr2odAELLBDlyCkxAglBXAVt4nk9Kl6nxb4snd9dnrL70
      WjLynWQsDczaV9TZIl2hYkMud+9OLVlUUtB+0c5b0p2t2P0sLltDaq3H6pT6yu2G
      8E86J9IBAoGBAPJaTNV5ysVOFn+YwWwRztzrvNArUJkVq8abN0gGp3gUvDEZnvzK
      weF7+lfZzcwVRmQkL3mWLzzZvCx77RfulAzLi5iFuRBPhhhxAPDiDuyL9B7O81G/
      M/W5DPctGOyD/9cnLuh72oij0unc5MLSfzJf8wblpcjJnPBDqIVh6Qt9AoGBAMKT
      Gacf4iSj1xW+0wrnbZlDuyCl6Msptj8ePcvLQrFqQmBwsXmWgVR+gFc/1G3lRft0
      QC6chsmafQHIIPpaDjq3sQ01/tUu7LXL+g/Hw9XtUHbkg3sZIQBtC26rKdStfHNS
      KTvuCgn/dAJNjiohfhWMt9R4Q6E5FV6PqQHJzPJXAoGAC41qZDKuC8GxKNvrPG+M
      4NML6RBngySZT5pOhExs5zh10BFclshDfbAfOtjTCotpE5T1/mG+VrQ6WBSANMfW
      ntWFDfwx2ikwRzH7zX+5HmV9eYp75sWqgGgVyiKIMZ4JMARaJBLjU+gbQbKZ5P+L
      uKcCOq3vvSZ/KKTQ/6qvJTECgYBiWgbCgoxF5wdmd4Gn5llw+lqRYyur3hbACuJD
      rCe3FDYfF3euNRSEiDkJYTtYnWbldtqmdPpw14VOrEF3KqQ8q/Nz8RIx4jlGn6dz
      6I8mCIH+xv1q8MXMuFHqC9zmIxdgF2y+XVF3wkd6jodI5oscC3g0juHokbkqhkVw
      oPfWmwKBgBfR6jv0gWWeWTfkNwj+cMLHQV1uvz6JyLH5K4iISEDFxYkd37jrHB8A
      9hz9UDfmCbSs2j8CXDg7zCayM6tfu4Vtx+8S5g3oN6sa1JXFY1Os7SoXhTfX9M+7
      QpYYDJZwkgZrVQoKMIdCs9xfyVhZERq945NYLekwE1t2W+tOVBgR
      -----END RSA PRIVATE KEY-----

    $ openssl enc -d -base64 -in key.pem -out key.bin

    $ dumpasn1 key.bin
         0 1187: SEQUENCE {
         4    1:   INTEGER 0
         7  257:   INTEGER
               :     00 B8 33 B0 5C ED 78 96 D1 35 8F 63 B4 88 34 AE
               :     AA D6 F0 FF 59 0C 2A 37 A2 92 2D E8 7A 19 36 CC
               :     DA 14 B5 EE 36 FE CD AB 5F 5E 67 60 29 0A B5 81
               :     BF AF C5 98 BC AC DB DF 53 F8 52 8C 35 4B 87 C5
               :     C9 D2 8D 5B 18 17 E1 5B 44 8C 78 1E A9 F3 F1 78
               :     22 FD C2 22 5C F4 A9 04 B7 87 F2 86 3D 49 A3 BD
               :     7D DE 00 8B B6 8B CB 00 5C 0F CC 03 1B 14 B8 97
               :     5A 47 EA 6A 52 79 67 BE DF 38 4E 0C A3 BB B8 A4
               :             [ Another 129 bytes skipped ]
       268    3:   INTEGER 65537
       273  257:   INTEGER
               :     00 A7 D4 70 9C 3A C1 E4 A8 39 64 AC 33 90 E6 6F
               :     3E B9 18 5B 8F 86 C5 F0 6A EF 45 64 CB DA AD 53
               :     78 5F E6 63 65 38 43 AC 20 F8 A2 B7 BA AD 47 33
               :     30 B3 B6 15 B3 D2 CB 82 6F BF 91 76 AE 18 63 5C
               :     92 C6 84 84 BB 2F 06 E5 61 4F 9B 22 55 37 2E 8B
               :     87 56 2D CB A1 66 49 99 42 9F 5B 19 74 3D E4 32
               :     82 BC 03 43 48 CF 95 E6 7D FA E6 A6 ED C5 B3 6A
               :     33 97 D2 BD 8C E7 90 DF 18 02 F5 1A 0F 14 BA E6
               :             [ Another 129 bytes skipped ]
       534  129:   INTEGER
               :     00 F2 5A 4C D5 79 CA C5 4E 16 7F 98 C1 6C 11 CE
               :     DC EB BC D0 2B 50 99 15 AB C6 9B 37 48 06 A7 78
               :     14 BC 31 19 9E FC CA C1 E1 7B FA 57 D9 CD CC 15
               :     46 64 24 2F 79 96 2F 3C D9 BC 2C 7B ED 17 EE 94
               :     0C CB 8B 98 85 B9 10 4F 86 18 71 00 F0 E2 0E EC
               :     8B F4 1E CE F3 51 BF 33 F5 B9 0C F7 2D 18 EC 83
               :     FF D7 27 2E E8 7B DA 88 A3 D2 E9 DC E4 C2 D2 7F
               :     32 5F F3 06 E5 A5 C8 C9 9C F0 43 A8 85 61 E9 0B
               :             [ Another 1 bytes skipped ]
       666  129:   INTEGER
               :     00 C2 93 19 A7 1F E2 24 A3 D7 15 BE D3 0A E7 6D
               :     99 43 BB 20 A5 E8 CB 29 B6 3F 1E 3D CB CB 42 B1
               :     6A 42 60 70 B1 79 96 81 54 7E 80 57 3F D4 6D E5
               :     45 FB 74 40 2E 9C 86 C9 9A 7D 01 C8 20 FA 5A 0E
               :     3A B7 B1 0D 35 FE D5 2E EC B5 CB FA 0F C7 C3 D5
               :     ED 50 76 E4 83 7B 19 21 00 6D 0B 6E AB 29 D4 AD
               :     7C 73 52 29 3B EE 0A 09 FF 74 02 4D 8E 2A 21 7E
               :     15 8C B7 D4 78 43 A1 39 15 5E 8F A9 01 C9 CC F2
               :             [ Another 1 bytes skipped ]
       798  128:   INTEGER
               :     0B 8D 6A 64 32 AE 0B C1 B1 28 DB EB 3C 6F 8C E0
               :     D3 0B E9 10 67 83 24 99 4F 9A 4E 84 4C 6C E7 38
               :     75 D0 11 5C 96 C8 43 7D B0 1F 3A D8 D3 0A 8B 69
               :     13 94 F5 FE 61 BE 56 B4 3A 58 14 80 34 C7 D6 9E
               :     D5 85 0D FC 31 DA 29 30 47 31 FB CD 7F B9 1E 65
               :     7D 79 8A 7B E6 C5 AA 80 68 15 CA 22 88 31 9E 09
               :     30 04 5A 24 12 E3 53 E8 1B 41 B2 99 E4 FF 8B B8
               :     A7 02 3A AD EF BD 26 7F 28 A4 D0 FF AA AF 25 31
       929  128:   INTEGER
               :     62 5A 06 C2 82 8C 45 E7 07 66 77 81 A7 E6 59 70
               :     FA 5A 91 63 2B AB DE 16 C0 0A E2 43 AC 27 B7 14
               :     36 1F 17 77 AE 35 14 84 88 39 09 61 3B 58 9D 66
               :     E5 76 DA A6 74 FA 70 D7 85 4E AC 41 77 2A A4 3C
               :     AB F3 73 F1 12 31 E2 39 46 9F A7 73 E8 8F 26 08
               :     81 FE C6 FD 6A F0 C5 CC B8 51 EA 0B DC E6 23 17
               :     60 17 6C BE 5D 51 77 C2 47 7A 8E 87 48 E6 8B 1C
               :     0B 78 34 8E E1 E8 91 B9 2A 86 45 70 A0 F7 D6 9B
      1060  128:   INTEGER
               :     17 D1 EA 3B F4 81 65 9E 59 37 E4 37 08 FE 70 C2
               :     C7 41 5D 6E BF 3E 89 C8 B1 F9 2B 88 88 48 40 C5
               :     C5 89 1D DF B8 EB 1C 1F 00 F6 1C FD 50 37 E6 09
               :     B4 AC DA 3F 02 5C 38 3B CC 26 B2 33 AB 5F BB 85
               :     6D C7 EF 12 E6 0D E8 37 AB 1A D4 95 C5 63 53 AC
               :     ED 2A 17 85 37 D7 F4 CF BB 42 96 18 0C 96 70 92
               :     06 6B 55 0A 0A 30 87 42 B3 DC 5F C9 58 59 11 1A
               :     BD E3 93 58 2D E9 30 13 5B 76 5B EB 4E 54 18 11
               :   }
 */
