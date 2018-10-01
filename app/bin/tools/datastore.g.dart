// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datastore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArchiveLine _$ArchiveLineFromJson(Map<String, dynamic> json) {
  return ArchiveLine(
      package: json['package'] == null
          ? null
          : PackageArchive.fromJson(json['package'] as Map<String, dynamic>),
      versions: (json['versions'] as List)
          ?.map((e) => e == null
              ? null
              : PackageVersionArchive.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ArchiveLineToJson(ArchiveLine instance) =>
    <String, dynamic>{
      'package': instance.package,
      'versions': instance.versions
    };

PackageArchive _$PackageArchiveFromJson(Map<String, dynamic> json) {
  return PackageArchive(
      name: json['name'] as String,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
      downloads: json['downloads'] as int,
      latestVersion: json['latestVersion'] as String,
      latestDevVersion: json['latestDevVersion'] as String,
      uploaderEmails:
          (json['uploaderEmails'] as List)?.map((e) => e as String)?.toList(),
      isDiscontinued: json['isDiscontinued'] as bool,
      doNotAdvertise: json['doNotAdvertise'] as bool);
}

Map<String, dynamic> _$PackageArchiveToJson(PackageArchive instance) =>
    <String, dynamic>{
      'name': instance.name,
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
      'downloads': instance.downloads,
      'latestVersion': instance.latestVersion,
      'latestDevVersion': instance.latestDevVersion,
      'uploaderEmails': instance.uploaderEmails,
      'isDiscontinued': instance.isDiscontinued,
      'doNotAdvertise': instance.doNotAdvertise
    };

PackageVersionArchive _$PackageVersionArchiveFromJson(
    Map<String, dynamic> json) {
  return PackageVersionArchive(
      version: json['version'] as String,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      pubspecJson: json['pubspecJson'] as String,
      readmeFilename: json['readmeFilename'] as String,
      readmeContent: json['readmeContent'] as String,
      changelogFilename: json['changelogFilename'] as String,
      changelogContent: json['changelogContent'] as String,
      exampleFilename: json['exampleFilename'] as String,
      exampleContent: json['exampleContent'] as String,
      libraries: (json['libraries'] as List)?.map((e) => e as String)?.toList(),
      downloads: json['downloads'] as int,
      sortOrder: json['sortOrder'] as int,
      uploaderEmail: json['uploaderEmail'] as String);
}

Map<String, dynamic> _$PackageVersionArchiveToJson(
        PackageVersionArchive instance) =>
    <String, dynamic>{
      'version': instance.version,
      'created': instance.created?.toIso8601String(),
      'pubspecJson': instance.pubspecJson,
      'readmeFilename': instance.readmeFilename,
      'readmeContent': instance.readmeContent,
      'changelogFilename': instance.changelogFilename,
      'changelogContent': instance.changelogContent,
      'exampleFilename': instance.exampleFilename,
      'exampleContent': instance.exampleContent,
      'libraries': instance.libraries,
      'downloads': instance.downloads,
      'sortOrder': instance.sortOrder,
      'uploaderEmail': instance.uploaderEmail
    };
