// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'jwks.g.dart';

/// The list of JSON Web Key records.
@JsonSerializable(includeIfNull: false, explicitToJson: true)
class JsonWebKeyList {
  final List<JsonWebKey> keys;

  JsonWebKeyList({
    required this.keys,
  });

  factory JsonWebKeyList.fromJson(Map<String, dynamic> json) =>
      _$JsonWebKeyListFromJson(json);

  Map<String, dynamic> toJson() => _$JsonWebKeyListToJson(this);
}

/// The JSON Web Key record.
@JsonSerializable(includeIfNull: false, explicitToJson: true)
class JsonWebKey {
  /// The specific cryptographic algorithm used with the key.
  final String alg;

  /// How the key was meant to be used; sig represents the signature.
  final String? use;

  // The unique identifier for the key.
  final String? kid;

  /// The family of cryptographic algorithms used with the key.
  final String? kty;

  /// The x.509 certificate chain. The first entry in the array is the certificate to use for token verification; the other certificates can be used to verify this first certificate.
  final List<String>? x5c;

  /// The thumbprint of the x.509 cert (SHA-1 thumbprint).
  final String? x5t;

  /// The modulus for the RSA public key.
  @NullableUint8ListUnpaddedBase64UrlConverter()
  final Uint8List? n;

  /// The exponent for the RSA public key.
  @NullableUint8ListUnpaddedBase64UrlConverter()
  final Uint8List? e;

  JsonWebKey({
    required this.alg,
    required this.use,
    required this.kid,
    required this.kty,
    required this.x5c,
    required this.x5t,
    required this.n,
    required this.e,
  });

  factory JsonWebKey.fromJson(Map<String, dynamic> json) =>
      _$JsonWebKeyFromJson(json);

  Map<String, dynamic> toJson() => _$JsonWebKeyToJson(this);
}

/// Converts bytes to unpadded, URL-safe BASE64-encoded String (nullable values).
class NullableUint8ListUnpaddedBase64UrlConverter
    implements JsonConverter<Uint8List?, String?> {
  const NullableUint8ListUnpaddedBase64UrlConverter();

  @override
  Uint8List? fromJson(String? json) {
    if (json != null) {
      final missingPadding = json.length % 4;
      if (missingPadding != 0) {
        json = '$json${'=' * missingPadding}';
      }
      return base64.decode(json);
    }
    return null;
  }

  @override
  String? toJson(Uint8List? object) {
    if (object != null) {
      final value = base64.encode(object);
      return value.endsWith('=') ? value.split('=').first : value;
    }
    return null;
  }
}
