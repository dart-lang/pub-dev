// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_archive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlutterArchive _$FlutterArchiveFromJson(Map<String, dynamic> json) =>
    FlutterArchive(
      baseUrl: json['baseUrl'] as String?,
      currentRelease: json['current_release'] == null
          ? null
          : FlutterCurrentRelease.fromJson(
              json['current_release'] as Map<String, dynamic>,
            ),
      releases: (json['releases'] as List<dynamic>?)
          ?.map((e) => FlutterRelease.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FlutterArchiveToJson(FlutterArchive instance) =>
    <String, dynamic>{
      'baseUrl': ?instance.baseUrl,
      'current_release': ?instance.currentRelease?.toJson(),
      'releases': ?instance.releases?.map((e) => e.toJson()).toList(),
    };

FlutterCurrentRelease _$FlutterCurrentReleaseFromJson(
  Map<String, dynamic> json,
) => FlutterCurrentRelease(
  beta: json['beta'] as String?,
  dev: json['dev'] as String?,
  stable: json['stable'] as String?,
);

Map<String, dynamic> _$FlutterCurrentReleaseToJson(
  FlutterCurrentRelease instance,
) => <String, dynamic>{
  'beta': ?instance.beta,
  'dev': ?instance.dev,
  'stable': ?instance.stable,
};

FlutterRelease _$FlutterReleaseFromJson(Map<String, dynamic> json) =>
    FlutterRelease(
      hash: json['hash'] as String?,
      channel: json['channel'] as String?,
      version: json['version'] as String?,
      releaseDate: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
      archive: json['archive'] as String?,
      sha256: json['sha256'] as String?,
      dartSdkVersion: json['dart_sdk_version'] as String?,
    );

Map<String, dynamic> _$FlutterReleaseToJson(FlutterRelease instance) =>
    <String, dynamic>{
      'hash': ?instance.hash,
      'channel': ?instance.channel,
      'version': ?instance.version,
      'release_date': ?instance.releaseDate?.toIso8601String(),
      'archive': ?instance.archive,
      'sha256': ?instance.sha256,
      'dart_sdk_version': ?instance.dartSdkVersion,
    };
