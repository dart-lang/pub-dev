// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

import 'openssl_commands.dart';

part 'openid_models.g.dart';

/// The combined data from the OpenID provider, including their signing keys.
@JsonSerializable(includeIfNull: false, explicitToJson: true)
class OpenIdData {
  final OpenIdProvider provider;
  final JsonWebKeyList jwks;

  OpenIdData({
    required this.provider,
    required this.jwks,
  });

  factory OpenIdData.fromJson(Map<String, dynamic> json) =>
      _$OpenIdDataFromJson(json);

  Map<String, dynamic> toJson() => _$OpenIdDataToJson(this);
}

/// The (partial) data structure of the `.well-known/openid-configuration` endpoint.
///
/// https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata
///
/// TODO: add all fields required for token verification, as described in:
///       https://github.com/dart-lang/pub-dev/pull/5795#discussion_r884877050
@JsonSerializable(includeIfNull: false, explicitToJson: true)
class OpenIdProvider {
  /// The identifier of the provider.
  /// This also MUST be identical to the iss Claim value in ID Tokens issued from this Issuer.
  final String issuer;

  /// URL of the provider's JSON Web Key Set `JWK` document.
  /// This contains the signing key(s) the RP uses to validate signatures from the OP.
  @JsonKey(name: 'jwks_uri')
  final String jwksUri;

  /// JSON array containing a list of the Claim Names of the Claims that the
  /// OpenID Provider MAY be able to supply values for. Note that for privacy
  /// or other reasons, this might not be an exhaustive list.
  @JsonKey(name: 'claims_supported')
  final List<String> claimsSupported;

  /// JSON array containing a list of the JWS signing algorithms (alg values)
  /// supported by the OP for the ID Token to encode the Claims in a JWT. The
  /// algorithm RS256 MUST be included.
  @JsonKey(name: 'id_token_signing_alg_values_supported')
  final List<String> idTokenSigningAlgValuesSupported;

  OpenIdProvider({
    required this.issuer,
    required this.jwksUri,
    required this.claimsSupported,
    required this.idTokenSigningAlgValuesSupported,
  });

  factory OpenIdProvider.fromJson(Map<String, dynamic> json) =>
      _$OpenIdProviderFromJson(json);

  Map<String, dynamic> toJson() => _$OpenIdProviderToJson(this);
}

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

  /// Selects the keys that match the provided parameters and can
  /// be used for signature verification.
  List<JsonWebKey> selectKeyForSignature({
    String? kid,
    String? alg,
  }) {
    return keys
        .where((k) => k.use == null || k.use == 'sig')
        .where((k) => kid == null || k.kid == kid)
        .where((k) => alg == null || k.alg == alg)
        .toList();
  }
}

/// The JSON Web Key record.
///
/// See the specification for more details about the content:
/// https://datatracker.ietf.org/doc/html/rfc7517
/// https://www.iana.org/assignments/jose/jose.xhtml#web-key-parameters
@JsonSerializable(includeIfNull: false, explicitToJson: true)
class JsonWebKey {
  /// The specific cryptographic algorithm used with the key.
  final String alg;

  /// How the key was meant to be used; `sig` represents the signature.
  final String? use;

  // The unique identifier for the key.
  final String? kid;

  /// The family of cryptographic algorithms used with the key.
  final String? kty;

  /// The x.509 certificate chain containing BASE64-encoded PKIX certificates.
  /// The first entry in the array is the certificate to use for token verification; the other certificates can be used to verify this first certificate.
  /// https://datatracker.ietf.org/doc/html/rfc7517#section-4.7
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

  /// Returns `true` if [input] and [signature] matches.
  Future<bool> verifySignature({
    required String input,
    required Uint8List signature,
  }) async {
    switch (kty ?? '') {
      case 'RSA':
        return await _verifyRsaSignature(input, signature);
      default:
        return false;
    }
  }

  Future<bool> _verifyRsaSignature(String input, Uint8List signature) async {
    final modulus = n;
    final exponent = e;
    if (modulus == null ||
        modulus.isEmpty ||
        exponent == null ||
        exponent.isEmpty) {
      return false;
    }
    return await verifyTextWithRsaSignature(
      input: input,
      signature: signature,
      publicKey: Asn1RsaPublicKey(modulus: modulus, exponent: exponent),
    );
  }
}

/// Converts bytes to unpadded, URL-safe BASE64-encoded String (nullable values).
class NullableUint8ListUnpaddedBase64UrlConverter
    implements JsonConverter<Uint8List?, String?> {
  const NullableUint8ListUnpaddedBase64UrlConverter();

  @override
  Uint8List? fromJson(String? json) {
    if (json != null) {
      return base64Url.decode(base64Url.normalize(json));
    }
    return null;
  }

  @override
  String? toJson(Uint8List? object) {
    if (object != null) {
      final value = base64Url.encode(object);
      return value.endsWith('=') ? value.split('=').first : value;
    }
    return null;
  }
}
