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
    <String, dynamic>{
      'url': instance.url,
      'fields': instance.fields,
    };

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

AutomatedPublishingConfig _$AutomatedPublishingConfigFromJson(
        Map<String, dynamic> json) =>
    AutomatedPublishingConfig(
      github: json['github'] == null
          ? null
          : GitHubPublishingConfig.fromJson(
              json['github'] as Map<String, dynamic>),
      gcp: json['gcp'] == null
          ? null
          : GcpPublishingConfig.fromJson(json['gcp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AutomatedPublishingConfigToJson(
        AutomatedPublishingConfig instance) =>
    <String, dynamic>{
      if (instance.github?.toJson() case final value?) 'github': value,
      if (instance.gcp?.toJson() case final value?) 'gcp': value,
    };

GitHubPublishingConfig _$GitHubPublishingConfigFromJson(
        Map<String, dynamic> json) =>
    GitHubPublishingConfig(
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
        GitHubPublishingConfig instance) =>
    <String, dynamic>{
      'isEnabled': instance.isEnabled,
      if (instance.repository case final value?) 'repository': value,
      if (instance.tagPattern case final value?) 'tagPattern': value,
      'requireEnvironment': instance.requireEnvironment,
      if (instance.environment case final value?) 'environment': value,
      'isPushEventEnabled': instance.isPushEventEnabled,
      'isWorkflowDispatchEventEnabled': instance.isWorkflowDispatchEventEnabled,
    };

GcpPublishingConfig _$GcpPublishingConfigFromJson(Map<String, dynamic> json) =>
    GcpPublishingConfig(
      isEnabled: json['isEnabled'] as bool? ?? false,
      serviceAccountEmail: json['serviceAccountEmail'] as String?,
    );

Map<String, dynamic> _$GcpPublishingConfigToJson(
        GcpPublishingConfig instance) =>
    <String, dynamic>{
      'isEnabled': instance.isEnabled,
      if (instance.serviceAccountEmail case final value?)
        'serviceAccountEmail': value,
    };

VersionOptions _$VersionOptionsFromJson(Map<String, dynamic> json) =>
    VersionOptions(
      isRetracted: json['isRetracted'] as bool?,
    );

Map<String, dynamic> _$VersionOptionsToJson(VersionOptions instance) =>
    <String, dynamic>{
      'isRetracted': instance.isRetracted,
    };

PackagePublisherInfo _$PackagePublisherInfoFromJson(
        Map<String, dynamic> json) =>
    PackagePublisherInfo(
      publisherId: json['publisherId'] as String?,
    );

Map<String, dynamic> _$PackagePublisherInfoToJson(
        PackagePublisherInfo instance) =>
    <String, dynamic>{
      'publisherId': instance.publisherId,
    };

SuccessMessage _$SuccessMessageFromJson(Map<String, dynamic> json) =>
    SuccessMessage(
      success: Message.fromJson(json['success'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuccessMessageToJson(SuccessMessage instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      message: json['message'] as String,
    );

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
      if (instance.isDiscontinued case final value?) 'isDiscontinued': value,
      if (instance.replacedBy case final value?) 'replacedBy': value,
      'latest': instance.latest,
      'versions': instance.versions,
      if (instance.advisoriesUpdated?.toIso8601String() case final value?)
        'advisoriesUpdated': value,
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
      if (instance.retracted case final value?) 'retracted': value,
      'pubspec': instance.pubspec,
      if (instance.archiveUrl case final value?) 'archive_url': value,
      if (instance.archiveSha256 case final value?) 'archive_sha256': value,
      if (instance.published?.toIso8601String() case final value?)
        'published': value,
    };

VersionScore _$VersionScoreFromJson(Map<String, dynamic> json) => VersionScore(
      grantedPoints: (json['grantedPoints'] as num?)?.toInt(),
      maxPoints: (json['maxPoints'] as num?)?.toInt(),
      likeCount: (json['likeCount'] as num?)?.toInt(),
      downloadCount30Days: (json['downloadCount30Days'] as num?)?.toInt(),
      popularityScore: (json['popularityScore'] as num?)?.toDouble(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$VersionScoreToJson(VersionScore instance) =>
    <String, dynamic>{
      if (instance.grantedPoints case final value?) 'grantedPoints': value,
      if (instance.maxPoints case final value?) 'maxPoints': value,
      if (instance.likeCount case final value?) 'likeCount': value,
      if (instance.downloadCount30Days case final value?)
        'downloadCount30Days': value,
      if (instance.popularityScore case final value?) 'popularityScore': value,
      if (instance.tags case final value?) 'tags': value,
      if (instance.lastUpdated?.toIso8601String() case final value?)
        'lastUpdated': value,
    };

RemoveUploaderRequest _$RemoveUploaderRequestFromJson(
        Map<String, dynamic> json) =>
    RemoveUploaderRequest(
      email: json['email'] as String,
    );

Map<String, dynamic> _$RemoveUploaderRequestToJson(
        RemoveUploaderRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

InviteUploaderRequest _$InviteUploaderRequestFromJson(
        Map<String, dynamic> json) =>
    InviteUploaderRequest(
      email: json['email'] as String,
    );

Map<String, dynamic> _$InviteUploaderRequestToJson(
        InviteUploaderRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };
