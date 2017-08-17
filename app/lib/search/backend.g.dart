// GENERATED CODE - DO NOT MODIFY BY HAND

part of pub_dartlang_org.search.backend;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

SearchSnapshot _$SearchSnapshotFromJson(Map<String, dynamic> json) =>
    new SearchSnapshot()
      ..updated = DateTime.parse(json['updated'] as String)
      ..documents = new Map<String, PackageDocument>.fromIterables(
          (json['documents'] as Map<String, dynamic>).keys,
          (json['documents'] as Map).values.map(
              (e) => new PackageDocument.fromJson(e as Map<String, dynamic>)));

abstract class _$SearchSnapshotSerializerMixin {
  DateTime get updated;
  Map<String, PackageDocument> get documents;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'updated': updated.toIso8601String(),
        'documents': documents
      };
}
