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
              json['current_release'] as Map<String, dynamic>),
      releases: (json['releases'] as List<dynamic>?)
          ?.map((e) => FlutterRelease.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FlutterArchiveToJson(FlutterArchive instance) =>
    <String, dynamic>{
      if (instance.baseUrl case final value?) 'baseUrl': value,
      if (instance.currentRelease?.toJson() case final value?)
        'current_release': value,
      if (instance.releases?.map((e) => e.toJson()).toList() case final value?)
        'releases': value,
    };

FlutterCurrentRelease _$FlutterCurrentReleaseFromJson(
        Map<String, dynamic> json) =>
    FlutterCurrentRelease(
      beta: json['beta'] as String?,
      dev: json['dev'] as String?,
      stable: json['stable'] as String?,
    );

Map<String, dynamic> _$FlutterCurrentReleaseToJson(
        FlutterCurrentRelease instance) =>
    <String, dynamic>{
      if (instance.beta case final value?) 'beta': value,
      if (instance.dev case final value?) 'dev': value,
      if (instance.stable case final value?) 'stable': value,
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
      if (instance.hash case final value?) 'hash': value,
      if (instance.channel case final value?) 'channel': value,
      if (instance.version case final value?) 'version': value,
      if (instance.releaseDate?.toIso8601String() case final value?)
        'release_date': value,
      if (instance.archive case final value?) 'archive': value,
      if (instance.sha256 case final value?) 'sha256': value,
      if (instance.dartSdkVersion case final value?) 'dart_sdk_version': value,
    };
