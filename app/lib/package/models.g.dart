// GENERATED CODE - DO NOT MODIFY BY HAND

part of pub_dartlang_org.appengine_repository.models;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageView _$PackageViewFromJson(Map<String, dynamic> json) {
  return PackageView(
    isExternal: json['isExternal'] as bool,
    url: json['url'] as String,
    name: json['name'] as String,
    version: json['version'] as String,
    devVersion: json['devVersion'] as String,
    ellipsizedDescription: json['ellipsizedDescription'] as String,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    shortUpdated: json['shortUpdated'] as String,
    flags: (json['flags'] as List)?.map((e) => e as String)?.toList(),
    publisherId: json['publisherId'] as String,
    isAwaiting: json['isAwaiting'] as bool,
    likes: json['likes'] as int,
    health: json['health'] as int,
    popularity: json['popularity'] as int,
    overallScore: (json['overallScore'] as num)?.toDouble(),
    tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
    isNewPackage: json['isNewPackage'] as bool,
    apiPages: (json['apiPages'] as List)
        ?.map((e) =>
            e == null ? null : ApiPageRef.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PackageViewToJson(PackageView instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isExternal', instance.isExternal);
  writeNotNull('url', instance.url);
  writeNotNull('name', instance.name);
  writeNotNull('version', instance.version);
  writeNotNull('devVersion', instance.devVersion);
  writeNotNull('ellipsizedDescription', instance.ellipsizedDescription);
  writeNotNull('created', instance.created?.toIso8601String());
  writeNotNull('shortUpdated', instance.shortUpdated);
  writeNotNull('flags', instance.flags);
  writeNotNull('publisherId', instance.publisherId);
  writeNotNull('isAwaiting', instance.isAwaiting);
  writeNotNull('likes', instance.likes);
  writeNotNull('health', instance.health);
  writeNotNull('popularity', instance.popularity);
  writeNotNull('overallScore', instance.overallScore);
  writeNotNull('tags', instance.tags);
  writeNotNull('isNewPackage', instance.isNewPackage);
  writeNotNull('apiPages', instance.apiPages);
  return val;
}
