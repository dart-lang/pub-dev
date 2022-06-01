// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

/// Pattern for a valid JWT, these must 3 base64 segments separated by dots.
final _jwtPattern = RegExp(
    r'^[a-zA-Z0-9+/=_-]{4,}\.[a-zA-Z0-9+/=_-]{4,}\.[a-zA-Z0-9+/=_-]{4,}$');

/// Returns true if the format of the [token] could be a JWT based on the pattern.
bool looksLikeJWT(String token) {
  return _jwtPattern.hasMatch(token);
}

/// The decoded JWT token.
class JWT {
  final Map<String, dynamic> header;
  final Map<String, dynamic> payload;
  final Uint8List signature;

  JWT(this.header, this.payload, this.signature);

  /// Parses [token] and returns [JWT].
  ///
  /// Throws [FormatException] when the parsing fails.
  factory JWT.parse(String token) {
    if (!looksLikeJWT(token)) {
      throw FormatException('Token does not looks like a JWT.');
    }
    final parts = token.split('.');
    if (parts.length != 3) {
      throw FormatException('Token does not looks like a JWT.');
    }
    final header =
        json.decode(utf8.decode(base64.decode(base64.normalize(parts[0]))))
            as Map<String, dynamic>;
    final payload =
        json.decode(utf8.decode(base64.decode(base64.normalize(parts[1]))))
            as Map<String, dynamic>;
    final signature = base64.decode(base64.normalize(parts[2]));
    return JWT(header, payload, signature);
  }

  static JWT? tryParse(String token) {
    try {
      return JWT.parse(token);
    } on FormatException catch (_) {
      return null;
    }
  }

  // header fields
  late final algorithm = header['alg'] as String?;
  late final type = header['typ'] as String?;

  // payload fields
  late final issuedAt = _tryParseFromSeconds(payload['iat'] as int?);
  late final expires = _tryParseFromSeconds(payload['exp'] as int?);
}

DateTime? _tryParseFromSeconds(int? value) {
  if (value == null) return null;
  return DateTime.fromMillisecondsSinceEpoch(value * 1000);
}
