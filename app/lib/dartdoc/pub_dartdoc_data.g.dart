// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pub_dartdoc_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PubDartdocData _$PubDartdocDataFromJson(Map<String, dynamic> json) {
  return PubDartdocData(
      apiElements: (json['apiElements'] as List)
          ?.map((e) =>
              e == null ? null : ApiElement.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PubDartdocDataToJson(PubDartdocData instance) =>
    <String, dynamic>{'apiElements': instance.apiElements};

ApiElement _$ApiElementFromJson(Map<String, dynamic> json) {
  return ApiElement(
      name: json['name'] as String,
      kind: json['kind'] as String,
      parent: json['parent'] as String,
      source: json['source'] as String,
      href: json['href'] as String,
      documentation: json['documentation'] as String);
}

Map<String, dynamic> _$ApiElementToJson(ApiElement instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'kind': instance.kind,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('parent', instance.parent);
  val['source'] = instance.source;
  writeNotNull('href', instance.href);
  writeNotNull('documentation', instance.documentation);
  return val;
}
