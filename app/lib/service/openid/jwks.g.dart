// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
      n: const NullableUint8ListBase64Converter()
          .fromJson(json['n'] as String?),
      e: const NullableUint8ListBase64Converter()
          .fromJson(json['e'] as String?),
    );

Map<String, dynamic> _$JsonWebKeyToJson(JsonWebKey instance) {
  final val = <String, dynamic>{
    'alg': instance.alg,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('use', instance.use);
  writeNotNull('kid', instance.kid);
  writeNotNull('kty', instance.kty);
  writeNotNull('x5c', instance.x5c);
  writeNotNull('x5t', instance.x5t);
  writeNotNull(
      'n', const NullableUint8ListBase64Converter().toJson(instance.n));
  writeNotNull(
      'e', const NullableUint8ListBase64Converter().toJson(instance.e));
  return val;
}
