// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import 'openid_models.dart';

final _logger = Logger('jwt');
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
  final JwtHeader header;

  /// The decoded payload Map.
  final JwtPayload payload;

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
      JwtHeader(_decodePart(headerPart)),
      JwtPayload(_decodePart(payloadPart)),
      signature,
    );
  }

  static JsonWebToken? tryParse(String token) {
    try {
      return JsonWebToken.parse(token);
    } on FormatException {
      return null;
    } catch (e, st) {
      _logger.warning('Unexpected JWT parser exception.', e, st);
      return null;
    }
  }

  /// Returns true if the format of the [token] could be a JWT based on the pattern.
  static bool looksLikeJWT(String token) {
    return _jwtPattern.hasMatch(token);
  }

  /// Verifies the token with the provided JSON Web Keys and
  /// returns `true` if the signature is valid.
  Future<bool> verifySignature(JsonWebKeyList jwks) async {
    final candidates = jwks.selectKeyForSignature(
      kid: header.kid,
      alg: header.alg,
    );
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

DateTime? _parseIntAsSecondsOrNull(Map<String, dynamic> map, String key) {
  final value = map[key];
  if (value == null) return null;
  if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(value * 1000, isUtc: true);
  }
  throw FormatException('Unexpected value for `$key`: `$value`.');
}

String? _parseAsStringOrNull(Map<String, dynamic> map, String key) {
  final value = map[key];
  if (value == null) {
    return null;
  }
  if (value is String) {
    return value;
  }
  throw FormatException('Unexpected value for `$key`: `$value`.');
}

String _parseAsString(Map<String, dynamic> map, String key) {
  final value = _parseAsStringOrNull(map, key);
  if (value == null) {
    throw FormatException('Missing value for `$key`.');
  } else {
    return value;
  }
}

/// The parsed JWT header.
class JwtHeader extends UnmodifiableMapView<String, dynamic> {
  /// algorithm
  final String? alg;

  /// type
  final String? typ;

  /// key identifier
  final String? kid;

  JwtHeader._(super.map)
      : alg = _parseAsStringOrNull(map, 'alg'),
        typ = _parseAsStringOrNull(map, 'typ'),
        kid = _parseAsStringOrNull(map, 'kid');

  factory JwtHeader(Map<String, dynamic> values) {
    try {
      return JwtHeader._(values);
    } on FormatException {
      rethrow;
    } catch (e, st) {
      _logger.warning('Unexpected JWT parser exception.', e, st);
      throw FormatException('Unexpected value in JWT header.');
    }
  }
}

/// The parsed JWT payload.
class JwtPayload extends UnmodifiableMapView<String, dynamic> {
  /// timestamp when token was issued
  final DateTime? iat;

  /// timestamp before which the token is not valid
  final DateTime? nbf;

  /// timestamp at which the token expires
  final DateTime? exp;

  /// The "iss" (issuer) claim identifies the principal that issued the JWT.
  final String? iss;

  JwtPayload._(super.map)
      : iat = _parseIntAsSecondsOrNull(map, 'iat'),
        nbf = _parseIntAsSecondsOrNull(map, 'nbf'),
        exp = _parseIntAsSecondsOrNull(map, 'exp'),
        iss = _parseAsStringOrNull(map, 'iss');

  factory JwtPayload(Map<String, dynamic> map) {
    try {
      return JwtPayload._(map);
    } on FormatException {
      rethrow;
    } catch (e, st) {
      _logger.warning('Unexpected JWT parser exception.', e, st);
      throw FormatException('Unexpected value in JWT payload.');
    }
  }

  /// Verifies the timestamps with to the provided [now]:
  /// - [iat] <= [now]
  /// - [nbf] <= [now]
  /// - [now] <= [exp]
  ///
  /// Returns `false` if the current timestamp is outside of the allowed range.
  /// If the timestamp is missing, we treat it as if it were expired/invalid.
  bool verifyTimestamps([DateTime? now]) {
    now ??= clock.now();

    bool isABeforeB(String name, DateTime? a, DateTime? b) {
      if (a == null || b == null) {
        // TODO: remove debug message after the appropriate difference threshold is selected.
        print('$name is missing.');
        return false;
      }
      if (a.isBefore(b) || a == b) {
        return true;
      }
      // TODO: remove debug message after the appropriate difference threshold is selected.
      print('$name has a time difference of ${a.difference(b)}.');
      return false;
    }

    // NOTE: The list ensures that each timestamp is evaluated, all differences will be printed.
    // TODO: switch to a simple `&&` after the appropriate difference threshold is selected.
    return [
      isABeforeB('iat', iat, now),
      isABeforeB('nbf', nbf, now),
      isABeforeB('exp', now, exp),
    ].every((b) => b);
  }
}

/// Parsed payload with the payload values GitHub sends with the token.
/// TODO: group GitHub-specific data classes into a single location
class GitHubJwtPayload {
  /// user controllable URL identifying the intended audience
  final String aud;

  /// repository for which the action is running
  final String repository;

  /// owner of the repository
  final String repositoryOwner;

  /// name of the event that triggered the workflow
  final String eventName;

  /// git reference (e.g. branch name or tag name)
  final String ref;

  /// the kind of git reference given (e.g. "branch")
  final String refType;

  /// The URL used as the `iss` property of JWT payloads.
  static const _githubIssuerUrl = 'https://token.actions.githubusercontent.com';

  static const _requiredClaims = <String>{
    // generic claims
    'iat',
    'nbf',
    'exp',
    'iss',
    'aud',
    // github-specific claims
    'repository',
    'repository_owner',
    'event_name',
    'ref',
    'ref_type',
  };

  GitHubJwtPayload._(Map<String, dynamic> map)
      : aud = _parseAsString(map, 'aud'),
        repository = _parseAsString(map, 'repository'),
        repositoryOwner = _parseAsString(map, 'repository_owner'),
        eventName = _parseAsString(map, 'event_name'),
        ref = _parseAsString(map, 'ref'),
        refType = _parseAsString(map, 'ref_type');

  factory GitHubJwtPayload(JwtPayload payload) {
    final missing = _requiredClaims.difference(payload.keys.toSet()).sorted();
    if (missing.isNotEmpty) {
      throw FormatException(
          'JWT from Github is missing following claims: ${missing.map((k) => '`$k`').join(', ')}.');
    }
    if (payload.iss != _githubIssuerUrl) {
      throw FormatException(
          'Unexpected value in payload: `iss`: `${payload.iss}`.');
    }
    return GitHubJwtPayload._(payload);
  }

  static GitHubJwtPayload? tryParse(JwtPayload payload) {
    try {
      return GitHubJwtPayload(payload);
    } on FormatException {
      return null;
    } catch (e, st) {
      _logger.warning('Unexpected JWT parser exception.', e, st);
      return null;
    }
  }
}
