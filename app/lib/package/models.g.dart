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
    prereleaseVersion: json['prereleaseVersion'] as String,
    ellipsizedDescription: json['ellipsizedDescription'] as String,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    shortUpdated: json['shortUpdated'] as String,
    flags: (json['flags'] as List)?.map((e) => e as String)?.toList(),
    publisherId: json['publisherId'] as String,
    isAwaiting: json['isAwaiting'] as bool,
    likes: json['likes'] as int,
    grantedPubPoints: json['grantedPubPoints'] as int,
    maxPubPoints: json['maxPubPoints'] as int,
    popularity: json['popularity'] as int,
    tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
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
  writeNotNull('prereleaseVersion', instance.prereleaseVersion);
  writeNotNull('ellipsizedDescription', instance.ellipsizedDescription);
  writeNotNull('created', instance.created?.toIso8601String());
  writeNotNull('shortUpdated', instance.shortUpdated);
  writeNotNull('flags', instance.flags);
  writeNotNull('publisherId', instance.publisherId);
  writeNotNull('isAwaiting', instance.isAwaiting);
  writeNotNull('likes', instance.likes);
  writeNotNull('grantedPubPoints', instance.grantedPubPoints);
  writeNotNull('maxPubPoints', instance.maxPubPoints);
  writeNotNull('popularity', instance.popularity);
  writeNotNull('tags', instance.tags);
  writeNotNull('apiPages', instance.apiPages);
  return val;
}
