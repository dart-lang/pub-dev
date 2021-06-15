// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map json) {
  return $checkedNew('Configuration', json, () {
    $checkKeys(json, allowedKeys: const [
      'packageBucketName',
      'projectId',
      'searchServicePrefix',
      'dartdocStorageBucketName',
      'popularityDumpBucketName',
      'searchSnapshotBucketName',
      'storageBaseUrl',
      'pubClientAudience',
      'pubSiteAudience',
      'adminAudience',
      'gmailRelayServiceAccount',
      'gmailRelayImpersonatedGSuiteUser',
      'uploadSignerServiceAccount',
      'blockRobots',
      'productionHosts',
      'primaryApiUri',
      'primarySiteUri',
      'admins'
    ]);
    final val = Configuration(
      projectId: $checkedConvert(json, 'projectId', (v) => v as String),
      packageBucketName:
          $checkedConvert(json, 'packageBucketName', (v) => v as String),
      dartdocStorageBucketName:
          $checkedConvert(json, 'dartdocStorageBucketName', (v) => v as String),
      popularityDumpBucketName:
          $checkedConvert(json, 'popularityDumpBucketName', (v) => v as String),
      searchSnapshotBucketName:
          $checkedConvert(json, 'searchSnapshotBucketName', (v) => v as String),
      searchServicePrefix:
          $checkedConvert(json, 'searchServicePrefix', (v) => v as String),
      storageBaseUrl:
          $checkedConvert(json, 'storageBaseUrl', (v) => v as String),
      pubClientAudience:
          $checkedConvert(json, 'pubClientAudience', (v) => v as String),
      pubSiteAudience:
          $checkedConvert(json, 'pubSiteAudience', (v) => v as String),
      adminAudience: $checkedConvert(json, 'adminAudience', (v) => v as String),
      gmailRelayServiceAccount:
          $checkedConvert(json, 'gmailRelayServiceAccount', (v) => v as String),
      gmailRelayImpersonatedGSuiteUser: $checkedConvert(
          json, 'gmailRelayImpersonatedGSuiteUser', (v) => v as String),
      uploadSignerServiceAccount: $checkedConvert(
          json, 'uploadSignerServiceAccount', (v) => v as String),
      blockRobots: $checkedConvert(json, 'blockRobots', (v) => v as bool),
      productionHosts: $checkedConvert(json, 'productionHosts',
          (v) => (v as List)?.map((e) => e as String)?.toList()),
      primaryApiUri: $checkedConvert(json, 'primaryApiUri',
          (v) => v == null ? null : Uri.parse(v as String)),
      primarySiteUri: $checkedConvert(json, 'primarySiteUri',
          (v) => v == null ? null : Uri.parse(v as String)),
      admins: $checkedConvert(
          json,
          'admins',
          (v) => (v as List)
              ?.map((e) => e == null
                  ? null
                  : AdminId.fromJson((e as Map)?.map(
                      (k, e) => MapEntry(k as String, e),
                    )))
              ?.toList()),
    );
    return val;
  });
}

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'packageBucketName': instance.packageBucketName,
      'projectId': instance.projectId,
      'searchServicePrefix': instance.searchServicePrefix,
      'dartdocStorageBucketName': instance.dartdocStorageBucketName,
      'popularityDumpBucketName': instance.popularityDumpBucketName,
      'searchSnapshotBucketName': instance.searchSnapshotBucketName,
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
      'admins': instance.admins?.map((e) => e?.toJson())?.toList(),
    };

AdminId _$AdminIdFromJson(Map json) {
  return $checkedNew('AdminId', json, () {
    $checkKeys(json,
        allowedKeys: const ['oauthUserId', 'email', 'permissions']);
    final val = AdminId(
      oauthUserId: $checkedConvert(json, 'oauthUserId', (v) => v as String),
      email: $checkedConvert(json, 'email', (v) => v as String),
      permissions: $checkedConvert(
          json,
          'permissions',
          (v) => (v as List)
              ?.map((e) => _$enumDecodeNullable(_$AdminPermissionEnumMap, e))),
    );
    return val;
  });
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
