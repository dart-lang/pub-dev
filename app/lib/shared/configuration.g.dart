// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) {
  return Configuration(
      projectId: json['projectId'] as String,
      packageBucketName: json['packageBucketName'] as String,
      dartdocStorageBucketName: json['dartdocStorageBucketName'] as String,
      popularityDumpBucketName: json['popularityDumpBucketName'] as String,
      searchSnapshotBucketName: json['searchSnapshotBucketName'] as String,
      backupSnapshotBucketName: json['backupSnapshotBucketName'] as String,
      searchServicePrefix: json['searchServicePrefix'] as String,
      storageBaseUrl: json['storageBaseUrl'] as String,
      pubClientAudience: json['pubClientAudience'] as String,
      pubSiteAudience: json['pubSiteAudience'] as String,
      adminAudience: json['adminAudience'] as String,
      gmailRelayServiceAccount: json['gmailRelayServiceAccount'] as String,
      gmailRelayImpersonatedGSuiteUser:
          json['gmailRelayImpersonatedGSuiteUser'] as String,
      uploadSignerServiceAccount: json['uploadSignerServiceAccount'] as String,
      blockRobots: json['blockRobots'] as bool,
      productionHosts:
          (json['productionHosts'] as List)?.map((e) => e as String)?.toList(),
      primaryApiUri: json['primaryApiUri'] == null
          ? null
          : Uri.parse(json['primaryApiUri'] as String),
      primarySiteUri: json['primarySiteUri'] == null
          ? null
          : Uri.parse(json['primarySiteUri'] as String),
      admins: (json['admins'] as List<AdminId>));
}

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'packageBucketName': instance.packageBucketName,
      'projectId': instance.projectId,
      'searchServicePrefix': instance.searchServicePrefix,
      'dartdocStorageBucketName': instance.dartdocStorageBucketName,
      'popularityDumpBucketName': instance.popularityDumpBucketName,
      'searchSnapshotBucketName': instance.searchSnapshotBucketName,
      'backupSnapshotBucketName': instance.backupSnapshotBucketName,
      'storageBaseUrl': instance.storageBaseUrl,
      'pubClientAudience': instance.pubClientAudience,
      'pubSiteAudience': instance.pubSiteAudience,
      'adminAudience': instance.adminAudience,
      'gmailRelayServiceAccount': instance.gmailRelayServiceAccount,
      'gmailRelayImpersonatedGSuiteUser':
          instance.gmailRelayImpersonatedGSuiteUser,
      'uploadSignerServiceAccount': instance.uploadSignerServiceAccount,
      'blockRobots': instance.blockRobots,
      'productionHosts': instance.productionHosts,
      'primaryApiUri': instance.primaryApiUri?.toString(),
      'primarySiteUri': instance.primarySiteUri?.toString(),
      'admins': instance.admins,
    };

AdminId _$AdminIdFromJson(Map<String, dynamic> json) {
  return AdminId(
    oauthUserId: json['oauthUserId'] as String,
    email: json['email'] as String,
    permissions: (json['permissions'] as List)
        ?.map((e) => _$enumDecodeNullable(_$AdminPermissionEnumMap, e)),
  );
}

Map<String, dynamic> _$AdminIdToJson(AdminId instance) => <String, dynamic>{
      'oauthUserId': instance.oauthUserId,
      'email': instance.email,
      'permissions': instance.permissions
          ?.map((e) => _$AdminPermissionEnumMap[e])
          ?.toList(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$AdminPermissionEnumMap = {
  AdminPermission.listUsers: 'listUsers',
  AdminPermission.removeUsers: 'removeUsers',
  AdminPermission.manageAssignedTags: 'manageAssignedTags',
  AdminPermission.removePackage: 'removePackage',
};
