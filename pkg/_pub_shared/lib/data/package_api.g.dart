// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadInfo _$UploadInfoFromJson(Map<String, dynamic> json) => UploadInfo(
  url: json['url'] as String,
  fields: (json['fields'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
);

Map<String, dynamic> _$UploadInfoToJson(UploadInfo instance) =>
    <String, dynamic>{'url': instance.url, 'fields': instance.fields};

PkgOptions _$PkgOptionsFromJson(Map<String, dynamic> json) => PkgOptions(
  isDiscontinued: json['isDiscontinued'] as bool?,
  replacedBy: json['replacedBy'] as String?,
  isUnlisted: json['isUnlisted'] as bool?,
);

Map<String, dynamic> _$PkgOptionsToJson(PkgOptions instance) =>
    <String, dynamic>{
      'isDiscontinued': instance.isDiscontinued,
      'replacedBy': instance.replacedBy,
      'isUnlisted': instance.isUnlisted,
    };

PkgPublishingConfig _$PkgPublishingConfigFromJson(
  Map<String, dynamic> json,
) => PkgPublishingConfig(
  github: json['github'] == null
      ? null
      : GitHubPublishingConfig.fromJson(json['github'] as Map<String, dynamic>),
  gcp: json['gcp'] == null
      ? null
      : GcpPublishingConfig.fromJson(json['gcp'] as Map<String, dynamic>),
  manual: json['manual'] == null
      ? null
      : ManualPublishingConfig.fromJson(json['manual'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PkgPublishingConfigToJson(
  PkgPublishingConfig instance,
) => <String, dynamic>{
  'github': ?instance.github?.toJson(),
  'gcp': ?instance.gcp?.toJson(),
  'manual': ?instance.manual?.toJson(),
};

GitHubPublishingConfig _$GitHubPublishingConfigFromJson(
  Map<String, dynamic> json,
) => GitHubPublishingConfig(
  isEnabled: json['isEnabled'] as bool? ?? false,
  repository: json['repository'] as String?,
  tagPattern: json['tagPattern'] as String?,
  requireEnvironment: json['requireEnvironment'] as bool? ?? false,
  environment: json['environment'] as String?,
  isPushEventEnabled: json['isPushEventEnabled'] as bool? ?? true,
  isWorkflowDispatchEventEnabled:
      json['isWorkflowDispatchEventEnabled'] as bool? ?? false,
);

Map<String, dynamic> _$GitHubPublishingConfigToJson(
  GitHubPublishingConfig instance,
) => <String, dynamic>{
  'isEnabled': instance.isEnabled,
  'repository': ?instance.repository,
  'tagPattern': ?instance.tagPattern,
  'requireEnvironment': instance.requireEnvironment,
  'environment': ?instance.environment,
  'isPushEventEnabled': instance.isPushEventEnabled,
  'isWorkflowDispatchEventEnabled': instance.isWorkflowDispatchEventEnabled,
};

GcpPublishingConfig _$GcpPublishingConfigFromJson(Map<String, dynamic> json) =>
    GcpPublishingConfig(
      isEnabled: json['isEnabled'] as bool? ?? false,
      serviceAccountEmail: json['serviceAccountEmail'] as String?,
    );

Map<String, dynamic> _$GcpPublishingConfigToJson(
  GcpPublishingConfig instance,
) => <String, dynamic>{
  'isEnabled': instance.isEnabled,
  'serviceAccountEmail': ?instance.serviceAccountEmail,
};

ManualPublishingConfig _$ManualPublishingConfigFromJson(
  Map<String, dynamic> json,
) => ManualPublishingConfig(isEnabled: json['isEnabled'] as bool? ?? true);

Map<String, dynamic> _$ManualPublishingConfigToJson(
  ManualPublishingConfig instance,
) => <String, dynamic>{'isEnabled': instance.isEnabled};

VersionOptions _$VersionOptionsFromJson(Map<String, dynamic> json) =>
    VersionOptions(isRetracted: json['isRetracted'] as bool?);

Map<String, dynamic> _$VersionOptionsToJson(VersionOptions instance) =>
    <String, dynamic>{'isRetracted': instance.isRetracted};

PackagePublisherInfo _$PackagePublisherInfoFromJson(
  Map<String, dynamic> json,
) => PackagePublisherInfo(publisherId: json['publisherId'] as String?);

Map<String, dynamic> _$PackagePublisherInfoToJson(
  PackagePublisherInfo instance,
) => <String, dynamic>{'publisherId': instance.publisherId};

SuccessMessage _$SuccessMessageFromJson(Map<String, dynamic> json) =>
    SuccessMessage(
      success: Message.fromJson(json['success'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuccessMessageToJson(SuccessMessage instance) =>
    <String, dynamic>{'success': instance.success};

Message _$MessageFromJson(Map<String, dynamic> json) =>
    Message(message: json['message'] as String);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'message': instance.message,
};

PackageData _$PackageDataFromJson(Map<String, dynamic> json) => PackageData(
  name: json['name'] as String,
  isDiscontinued: json['isDiscontinued'] as bool?,
  replacedBy: json['replacedBy'] as String?,
  latest: VersionInfo.fromJson(json['latest'] as Map<String, dynamic>),
  versions: (json['versions'] as List<dynamic>)
      .map((e) => VersionInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
  advisoriesUpdated: json['advisoriesUpdated'] == null
      ? null
      : DateTime.parse(json['advisoriesUpdated'] as String),
);

Map<String, dynamic> _$PackageDataToJson(PackageData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isDiscontinued': ?instance.isDiscontinued,
      'replacedBy': ?instance.replacedBy,
      'latest': instance.latest,
      'versions': instance.versions,
      'advisoriesUpdated': ?instance.advisoriesUpdated?.toIso8601String(),
    };

VersionInfo _$VersionInfoFromJson(Map<String, dynamic> json) => VersionInfo(
  version: json['version'] as String,
  retracted: json['retracted'] as bool?,
  pubspec: json['pubspec'] as Map<String, dynamic>,
  archiveUrl: json['archive_url'] as String?,
  archiveSha256: json['archive_sha256'] as String?,
  published: json['published'] == null
      ? null
      : DateTime.parse(json['published'] as String),
);

Map<String, dynamic> _$VersionInfoToJson(VersionInfo instance) =>
    <String, dynamic>{
      'version': instance.version,
      'retracted': ?instance.retracted,
      'pubspec': instance.pubspec,
      'archive_url': ?instance.archiveUrl,
      'archive_sha256': ?instance.archiveSha256,
      'published': ?instance.published?.toIso8601String(),
    };

VersionScore _$VersionScoreFromJson(Map<String, dynamic> json) => VersionScore(
  grantedPoints: (json['grantedPoints'] as num?)?.toInt(),
  maxPoints: (json['maxPoints'] as num?)?.toInt(),
  likeCount: (json['likeCount'] as num?)?.toInt(),
  downloadCount30Days: (json['downloadCount30Days'] as num?)?.toInt(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$VersionScoreToJson(VersionScore instance) =>
    <String, dynamic>{
      'grantedPoints': instance.grantedPoints,
      'maxPoints': instance.maxPoints,
      'likeCount': instance.likeCount,
      'downloadCount30Days': instance.downloadCount30Days,
      'tags': instance.tags,
    };

RemoveUploaderRequest _$RemoveUploaderRequestFromJson(
  Map<String, dynamic> json,
) => RemoveUploaderRequest(email: json['email'] as String);

Map<String, dynamic> _$RemoveUploaderRequestToJson(
  RemoveUploaderRequest instance,
) => <String, dynamic>{'email': instance.email};

InviteUploaderRequest _$InviteUploaderRequestFromJson(
  Map<String, dynamic> json,
) => InviteUploaderRequest(email: json['email'] as String);

Map<String, dynamic> _$InviteUploaderRequestToJson(
  InviteUploaderRequest instance,
) => <String, dynamic>{'email': instance.email};
