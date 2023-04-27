// GENERATED CODE - DO NOT MODIFY BY HAND

part of pub_dartlang_org.appengine_repository.models;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestReleases _$LatestReleasesFromJson(Map<String, dynamic> json) =>
    LatestReleases(
      stable: Release.fromJson(json['stable'] as Map<String, dynamic>),
      prerelease: json['prerelease'] == null
          ? null
          : Release.fromJson(json['prerelease'] as Map<String, dynamic>),
      preview: json['preview'] == null
          ? null
          : Release.fromJson(json['preview'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LatestReleasesToJson(LatestReleases instance) =>
    <String, dynamic>{
      'stable': instance.stable,
      'prerelease': instance.prerelease,
      'preview': instance.preview,
    };

Release _$ReleaseFromJson(Map<String, dynamic> json) => Release(
      version: json['version'] as String,
      published: DateTime.parse(json['published'] as String),
    );

Map<String, dynamic> _$ReleaseToJson(Release instance) => <String, dynamic>{
      'version': instance.version,
      'published': instance.published.toIso8601String(),
    };

AutomatedPublishing _$AutomatedPublishingFromJson(Map<String, dynamic> json) =>
    AutomatedPublishing(
      githubConfig: json['githubConfig'] == null
          ? null
          : GithubPublishingConfig.fromJson(
              json['githubConfig'] as Map<String, dynamic>),
      githubLock: json['githubLock'] == null
          ? null
          : GithubPublishingLock.fromJson(
              json['githubLock'] as Map<String, dynamic>),
      gcpConfig: json['gcpConfig'] == null
          ? null
          : GcpPublishingConfig.fromJson(
              json['gcpConfig'] as Map<String, dynamic>),
      gcpLock: json['gcpLock'] == null
          ? null
          : GcpPublishingLock.fromJson(json['gcpLock'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AutomatedPublishingToJson(AutomatedPublishing instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('githubConfig', instance.githubConfig?.toJson());
  writeNotNull('githubLock', instance.githubLock?.toJson());
  writeNotNull('gcpConfig', instance.gcpConfig?.toJson());
  writeNotNull('gcpLock', instance.gcpLock?.toJson());
  return val;
}

GithubPublishingLock _$GithubPublishingLockFromJson(
        Map<String, dynamic> json) =>
    GithubPublishingLock(
      repositoryOwnerId: json['repositoryOwnerId'] as String,
      repositoryId: json['repositoryId'] as String,
    );

Map<String, dynamic> _$GithubPublishingLockToJson(
        GithubPublishingLock instance) =>
    <String, dynamic>{
      'repositoryOwnerId': instance.repositoryOwnerId,
      'repositoryId': instance.repositoryId,
    };

GcpPublishingLock _$GcpPublishingLockFromJson(Map<String, dynamic> json) =>
    GcpPublishingLock(
      oauthUserId: json['oauthUserId'] as String,
    );

Map<String, dynamic> _$GcpPublishingLockToJson(GcpPublishingLock instance) =>
    <String, dynamic>{
      'oauthUserId': instance.oauthUserId,
    };

PackageView _$PackageViewFromJson(Map<String, dynamic> json) => PackageView(
      screenshots: (json['screenshots'] as List<dynamic>?)
          ?.map((e) => ProcessedScreenshot.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      releases: json['releases'] == null
          ? null
          : LatestReleases.fromJson(json['releases'] as Map<String, dynamic>),
      ellipsizedDescription: json['ellipsizedDescription'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      publisherId: json['publisherId'] as String?,
      isPending: json['isPending'] as bool?,
      likes: json['likes'] as int?,
      grantedPubPoints: json['grantedPubPoints'] as int?,
      maxPubPoints: json['maxPubPoints'] as int?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      replacedBy: json['replacedBy'] as String?,
      spdxIdentifiers: (json['spdxIdentifiers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      apiPages: (json['apiPages'] as List<dynamic>?)
          ?.map((e) => ApiPageRef.fromJson(e as Map<String, dynamic>))
          .toList(),
      topics:
          (json['topics'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PackageViewToJson(PackageView instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('releases', instance.releases);
  writeNotNull('ellipsizedDescription', instance.ellipsizedDescription);
  writeNotNull('created', instance.created?.toIso8601String());
  writeNotNull('publisherId', instance.publisherId);
  val['isPending'] = instance.isPending;
  writeNotNull('likes', instance.likes);
  writeNotNull('grantedPubPoints', instance.grantedPubPoints);
  writeNotNull('maxPubPoints', instance.maxPubPoints);
  val['tags'] = instance.tags;
  writeNotNull('replacedBy', instance.replacedBy);
  writeNotNull('spdxIdentifiers', instance.spdxIdentifiers);
  writeNotNull('apiPages', instance.apiPages);
  writeNotNull('screenshots', instance.screenshots);
  writeNotNull('topics', instance.topics);
  return val;
}
