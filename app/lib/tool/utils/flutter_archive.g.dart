// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_archive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlutterArchive _$FlutterArchiveFromJson(Map<String, dynamic> json) {
  return FlutterArchive(
    baseUrl: json['baseUrl'] as String,
    currentRelease: json['current_release'] == null
        ? null
        : FlutterCurrentRelease.fromJson(
            json['current_release'] as Map<String, dynamic>),
    releases: (json['releases'] as List)
        ?.map((e) => e == null
            ? null
            : FlutterRelease.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FlutterArchiveToJson(FlutterArchive instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('baseUrl', instance.baseUrl);
  writeNotNull('current_release', instance.currentRelease?.toJson());
  writeNotNull(
      'releases', instance.releases?.map((e) => e?.toJson())?.toList());
  return val;
}

FlutterCurrentRelease _$FlutterCurrentReleaseFromJson(
    Map<String, dynamic> json) {
  return FlutterCurrentRelease(
    beta: json['beta'] as String,
    dev: json['dev'] as String,
    stable: json['stable'] as String,
  );
}

Map<String, dynamic> _$FlutterCurrentReleaseToJson(
    FlutterCurrentRelease instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('beta', instance.beta);
  writeNotNull('dev', instance.dev);
  writeNotNull('stable', instance.stable);
  return val;
}

FlutterRelease _$FlutterReleaseFromJson(Map<String, dynamic> json) {
  return FlutterRelease(
    hash: json['hash'] as String,
    channel: json['channel'] as String,
    version: json['version'] as String,
    releaseDate: json['release_date'] == null
        ? null
        : DateTime.parse(json['release_date'] as String),
    archive: json['archive'] as String,
    sha256: json['sha256'] as String,
  );
}

Map<String, dynamic> _$FlutterReleaseToJson(FlutterRelease instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('hash', instance.hash);
  writeNotNull('channel', instance.channel);
  writeNotNull('version', instance.version);
  writeNotNull('release_date', instance.releaseDate?.toIso8601String());
  writeNotNull('archive', instance.archive);
  writeNotNull('sha256', instance.sha256);
  return val;
}
