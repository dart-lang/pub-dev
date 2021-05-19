// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

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

DartdocIndexEntry _$DartdocIndexEntryFromJson(Map<String, dynamic> json) {
  return DartdocIndexEntry(
    name: json['name'] as String,
    qualifiedName: json['qualifiedName'] as String,
    href: json['href'] as String,
    type: json['type'] as String,
    overriddenDepth: json['overriddenDepth'] as int,
    packageName: json['packageName'] as String,
    enclosedBy: json['enclosedBy'] == null
        ? null
        : DartdocIndexEntryEnclosedBy.fromJson(
            json['enclosedBy'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DartdocIndexEntryToJson(DartdocIndexEntry instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('qualifiedName', instance.qualifiedName);
  writeNotNull('href', instance.href);
  writeNotNull('type', instance.type);
  writeNotNull('overriddenDepth', instance.overriddenDepth);
  writeNotNull('packageName', instance.packageName);
  writeNotNull('enclosedBy', instance.enclosedBy);
  return val;
}

DartdocIndexEntryEnclosedBy _$DartdocIndexEntryEnclosedByFromJson(
    Map<String, dynamic> json) {
  return DartdocIndexEntryEnclosedBy(
    name: json['name'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$DartdocIndexEntryEnclosedByToJson(
    DartdocIndexEntryEnclosedBy instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('type', instance.type);
  return val;
}
