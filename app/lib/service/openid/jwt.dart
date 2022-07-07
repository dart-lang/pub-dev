// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

import 'openid_models.dart';

final _jsonUtf8Base64 = json.fuse(utf8).fuse(base64Url);

/// Pattern for a valid JWT, these must 3 base64 segments separated by dots.
///
/// The current pattern is permissive:
/// https://datatracker.ietf.org/doc/html/rfc7519#section-2 says:
///
///     The terms "JSON Web Signature (JWS)", "Base64url Encoding", "Header
///     Parameter", "JOSE Header", "JWS Compact Serialization", "JWS
///     Payload", "JWS Signature", and "Unsecured JWS" are defined by the JWS
///     specification `JWS`.
///
/// JWS, RFC7515 Appendix C specifies:
///
///     This appendix describes how to implement base64url encoding and
///     decoding functions without padding based upon standard base64
///     encoding and decoding functions that do use padding.
///
/// TODO: use a strict pattern to only allow Base64Url encoding without padding.
final _jwtPattern = RegExp(
    r'^[a-zA-Z0-9+/=_-]{4,}\.[a-zA-Z0-9+/=_-]{4,}\.[a-zA-Z0-9+/=_-]{4,}$');

/// Representation of a JWT as defined by [RFC7519][1].
///
/// [1]: https://datatracker.ietf.org/doc/html/rfc7519
class JsonWebToken {
  /// The concatenated parts that will be used for the signature check.
  final String headerAndPayloadEncoded;

  /// The decoded header Map.
  final Map<String, dynamic> header;

  /// The decoded payload Map.
  final Map<String, dynamic> payload;

  /// The bytes of the signature hash.
  final Uint8List signature;

  JsonWebToken._(
    this.headerAndPayloadEncoded,
    this.header,
    this.payload,
    this.signature,
  );

  /// Parses [token] and returns [JsonWebToken].
  ///
  /// Throws [FormatException] when the parsing fails.
  factory JsonWebToken.parse(String token) {
    if (!looksLikeJWT(token)) {
      throw FormatException('Token does not looks like a JWT.');
    }
    final parts = token.split('.');
    if (parts.length != 3) {
      throw FormatException('Token does not looks like a JWT.');
    }
    final headerPart = parts[0];
    final payloadPart = parts[1];
    final signature = base64.decode(base64.normalize(parts[2]));
    return JsonWebToken._(
      '$headerPart.$payloadPart',
      _decodePart(headerPart),
      _decodePart(payloadPart),
      signature,
    );
  }

  static JsonWebToken? tryParse(String token) {
    try {
      return JsonWebToken.parse(token);
    } on FormatException catch (_) {
      return null;
    }
  }

  /// Returns true if the format of the [token] could be a JWT based on the pattern.
  static bool looksLikeJWT(String token) {
    return _jwtPattern.hasMatch(token);
  }

  /// algorithm
  late final alg = header['alg'] as String?;

  /// type
  late final typ = header['typ'] as String?;

  /// key identifier
  late final kid = header['kid'] as String?;

  /// issued at
  late final iat = _tryParseFromSeconds(payload['iat'] as int?);

  /// expires
  late final exp = _tryParseFromSeconds(payload['exp'] as int?);

  /// Verifies the token with the provided JSON Web Keys and
  /// returns `true` if the signature is valid.
  Future<bool> verifySignature(JsonWebKeyList jwks) async {
    final candidates = jwks.selectKeyForSignature(kid: kid, alg: alg);
    for (final key in candidates) {
      final isValid = await key.verifySignature(
        input: headerAndPayloadEncoded,
        signature: signature,
      );
      if (isValid) {
        return true;
      }
    }
    return false;
  }
}

Map<String, dynamic> _decodePart(String part) {
  return _jsonUtf8Base64.decode(base64.normalize(part)) as Map<String, dynamic>;
}

DateTime? _tryParseFromSeconds(int? value) {
  if (value == null) return null;
  return DateTime.fromMillisecondsSinceEpoch(value * 1000);
}
