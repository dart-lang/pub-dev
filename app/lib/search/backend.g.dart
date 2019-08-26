// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSnapshot _$SearchSnapshotFromJson(Map<String, dynamic> json) {
  return SearchSnapshot()
    ..updated = DateTime.parse(json['updated'] as String)
    ..documents = (json['documents'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(k, PackageDocument.fromJson(e as Map<String, dynamic>)),
    );
}

Map<String, dynamic> _$SearchSnapshotToJson(SearchSnapshot instance) =>
    <String, dynamic>{
      'updated': instance.updated.toIso8601String(),
      'documents': instance.documents,
    };
