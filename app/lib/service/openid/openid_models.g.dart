// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openid_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenIdData _$OpenIdDataFromJson(Map<String, dynamic> json) => OpenIdData(
      provider:
          OpenIdProvider.fromJson(json['provider'] as Map<String, dynamic>),
      jwks: JsonWebKeyList.fromJson(json['jwks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OpenIdDataToJson(OpenIdData instance) =>
    <String, dynamic>{
      'provider': instance.provider.toJson(),
      'jwks': instance.jwks.toJson(),
    };

OpenIdProvider _$OpenIdProviderFromJson(Map<String, dynamic> json) =>
    OpenIdProvider(
      issuer: json['issuer'] as String,
      jwksUri: json['jwks_uri'] as String,
      claimsSupported: (json['claims_supported'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      idTokenSigningAlgValuesSupported:
          (json['id_token_signing_alg_values_supported'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$OpenIdProviderToJson(OpenIdProvider instance) =>
    <String, dynamic>{
      'issuer': instance.issuer,
      'jwks_uri': instance.jwksUri,
      'claims_supported': instance.claimsSupported,
      'id_token_signing_alg_values_supported':
          instance.idTokenSigningAlgValuesSupported,
    };

JsonWebKeyList _$JsonWebKeyListFromJson(Map<String, dynamic> json) =>
    JsonWebKeyList(
      keys: (json['keys'] as List<dynamic>)
          .map((e) => JsonWebKey.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JsonWebKeyListToJson(JsonWebKeyList instance) =>
    <String, dynamic>{
      'keys': instance.keys.map((e) => e.toJson()).toList(),
    };

JsonWebKey _$JsonWebKeyFromJson(Map<String, dynamic> json) => JsonWebKey(
      alg: json['alg'] as String,
      use: json['use'] as String?,
      kid: json['kid'] as String?,
      kty: json['kty'] as String?,
      x5c: (json['x5c'] as List<dynamic>?)?.map((e) => e as String).toList(),
      x5t: json['x5t'] as String?,
      n: const NullableUint8ListUnpaddedBase64UrlConverter()
          .fromJson(json['n'] as String?),
      e: const NullableUint8ListUnpaddedBase64UrlConverter()
          .fromJson(json['e'] as String?),
    );

Map<String, dynamic> _$JsonWebKeyToJson(JsonWebKey instance) =>
    <String, dynamic>{
      'alg': instance.alg,
      if (instance.use case final value?) 'use': value,
      if (instance.kid case final value?) 'kid': value,
      if (instance.kty case final value?) 'kty': value,
      if (instance.x5c case final value?) 'x5c': value,
      if (instance.x5t case final value?) 'x5t': value,
      if (const NullableUint8ListUnpaddedBase64UrlConverter().toJson(instance.n)
          case final value?)
        'n': value,
      if (const NullableUint8ListUnpaddedBase64UrlConverter().toJson(instance.e)
          case final value?)
        'e': value,
    };
