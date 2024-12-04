// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

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
          : GitHubPublishingConfig.fromJson(
              json['githubConfig'] as Map<String, dynamic>),
      githubLock: json['githubLock'] == null
          ? null
          : GitHubPublishingLock.fromJson(
              json['githubLock'] as Map<String, dynamic>),
      gcpConfig: json['gcpConfig'] == null
          ? null
          : GcpPublishingConfig.fromJson(
              json['gcpConfig'] as Map<String, dynamic>),
      gcpLock: json['gcpLock'] == null
          ? null
          : GcpPublishingLock.fromJson(json['gcpLock'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AutomatedPublishingToJson(
        AutomatedPublishing instance) =>
    <String, dynamic>{
      if (instance.githubConfig?.toJson() case final value?)
        'githubConfig': value,
      if (instance.githubLock?.toJson() case final value?) 'githubLock': value,
      if (instance.gcpConfig?.toJson() case final value?) 'gcpConfig': value,
      if (instance.gcpLock?.toJson() case final value?) 'gcpLock': value,
    };

GitHubPublishingLock _$GitHubPublishingLockFromJson(
        Map<String, dynamic> json) =>
    GitHubPublishingLock(
      repositoryOwnerId: json['repositoryOwnerId'] as String,
      repositoryId: json['repositoryId'] as String,
    );

Map<String, dynamic> _$GitHubPublishingLockToJson(
        GitHubPublishingLock instance) =>
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
      name: json['name'] as String,
      releases:
          LatestReleases.fromJson(json['releases'] as Map<String, dynamic>),
      ellipsizedDescription: json['ellipsizedDescription'] as String?,
      created: DateTime.parse(json['created'] as String),
      publisherId: json['publisherId'] as String?,
      isPending: json['isPending'] as bool?,
      likes: (json['likes'] as num).toInt(),
      grantedPubPoints: (json['grantedPubPoints'] as num?)?.toInt(),
      maxPubPoints: (json['maxPubPoints'] as num?)?.toInt(),
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
      popularity: (json['popularity'] as num).toInt(),
      thirtyDaysDownloadCounts:
          (json['thirtyDaysDownloadCounts'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PackageViewToJson(PackageView instance) =>
    <String, dynamic>{
      'name': instance.name,
      'releases': instance.releases,
      if (instance.ellipsizedDescription case final value?)
        'ellipsizedDescription': value,
      'created': instance.created.toIso8601String(),
      if (instance.publisherId case final value?) 'publisherId': value,
      'isPending': instance.isPending,
      'likes': instance.likes,
      if (instance.grantedPubPoints case final value?)
        'grantedPubPoints': value,
      if (instance.maxPubPoints case final value?) 'maxPubPoints': value,
      'tags': instance.tags,
      if (instance.replacedBy case final value?) 'replacedBy': value,
      if (instance.spdxIdentifiers case final value?) 'spdxIdentifiers': value,
      if (instance.apiPages case final value?) 'apiPages': value,
      if (instance.screenshots case final value?) 'screenshots': value,
      if (instance.topics case final value?) 'topics': value,
      'popularity': instance.popularity,
      if (instance.thirtyDaysDownloadCounts case final value?)
        'thirtyDaysDownloadCounts': value,
    };
