// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map json) => $checkedCreate(
      'Configuration',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'canonicalPackagesBucketName',
            'publicPackagesBucketName',
            'incomingPackagesBucketName',
            'imageBucketName',
            'reportsBucketName',
            'exportedApiBucketName',
            'projectId',
            'searchServicePrefix',
            'fallbackSearchServicePrefix',
            'defaultServiceBaseUrl',
            'dartdocStorageBucketName',
            'popularityDumpBucketName',
            'searchSnapshotBucketName',
            'maxTaskInstances',
            'maxTaskRunHours',
            'taskResultBucketName',
            'taskWorkerImage',
            'taskWorkerProject',
            'taskWorkerNetwork',
            'cosImage',
            'taskWorkerServiceAccount',
            'storageBaseUrl',
            'pubClientAudience',
            'pubServerAudience',
            'externalServiceAudience',
            'gmailRelayServiceAccount',
            'uploadSignerServiceAccount',
            'blockRobots',
            'productionHosts',
            'primaryApiUri',
            'primarySiteUri',
            'admins',
            'tools',
            'rateLimits'
          ],
        );
        final val = Configuration(
          canonicalPackagesBucketName: $checkedConvert(
              'canonicalPackagesBucketName', (v) => v as String?),
          publicPackagesBucketName:
              $checkedConvert('publicPackagesBucketName', (v) => v as String?),
          incomingPackagesBucketName: $checkedConvert(
              'incomingPackagesBucketName', (v) => v as String?),
          projectId: $checkedConvert('projectId', (v) => v as String),
          imageBucketName:
              $checkedConvert('imageBucketName', (v) => v as String?),
          reportsBucketName:
              $checkedConvert('reportsBucketName', (v) => v as String?),
          dartdocStorageBucketName:
              $checkedConvert('dartdocStorageBucketName', (v) => v as String?),
          popularityDumpBucketName:
              $checkedConvert('popularityDumpBucketName', (v) => v as String?),
          searchSnapshotBucketName:
              $checkedConvert('searchSnapshotBucketName', (v) => v as String?),
          exportedApiBucketName:
              $checkedConvert('exportedApiBucketName', (v) => v as String?),
          maxTaskInstances:
              $checkedConvert('maxTaskInstances', (v) => v as int),
          maxTaskRunHours: $checkedConvert('maxTaskRunHours', (v) => v as int),
          taskResultBucketName:
              $checkedConvert('taskResultBucketName', (v) => v as String?),
          taskWorkerImage:
              $checkedConvert('taskWorkerImage', (v) => v as String?),
          taskWorkerProject:
              $checkedConvert('taskWorkerProject', (v) => v as String?),
          taskWorkerNetwork:
              $checkedConvert('taskWorkerNetwork', (v) => v as String?),
          cosImage: $checkedConvert('cosImage', (v) => v as String?),
          taskWorkerServiceAccount:
              $checkedConvert('taskWorkerServiceAccount', (v) => v as String?),
          searchServicePrefix:
              $checkedConvert('searchServicePrefix', (v) => v as String),
          fallbackSearchServicePrefix: $checkedConvert(
              'fallbackSearchServicePrefix', (v) => v as String?),
          storageBaseUrl:
              $checkedConvert('storageBaseUrl', (v) => v as String?),
          pubClientAudience:
              $checkedConvert('pubClientAudience', (v) => v as String?),
          pubServerAudience:
              $checkedConvert('pubServerAudience', (v) => v as String?),
          externalServiceAudience:
              $checkedConvert('externalServiceAudience', (v) => v as String?),
          gmailRelayServiceAccount:
              $checkedConvert('gmailRelayServiceAccount', (v) => v as String?),
          uploadSignerServiceAccount: $checkedConvert(
              'uploadSignerServiceAccount', (v) => v as String?),
          blockRobots: $checkedConvert('blockRobots', (v) => v as bool),
          productionHosts: $checkedConvert('productionHosts',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          primaryApiUri: $checkedConvert('primaryApiUri',
              (v) => v == null ? null : Uri.parse(v as String)),
          primarySiteUri:
              $checkedConvert('primarySiteUri', (v) => Uri.parse(v as String)),
          admins: $checkedConvert(
              'admins',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      AdminId.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
          defaultServiceBaseUrl:
              $checkedConvert('defaultServiceBaseUrl', (v) => v as String),
          tools: $checkedConvert(
              'tools',
              (v) => v == null
                  ? null
                  : ToolsConfiguration.fromJson(
                      Map<String, dynamic>.from(v as Map))),
          rateLimits: $checkedConvert(
              'rateLimits',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      RateLimit.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'canonicalPackagesBucketName': instance.canonicalPackagesBucketName,
      'publicPackagesBucketName': instance.publicPackagesBucketName,
      'incomingPackagesBucketName': instance.incomingPackagesBucketName,
      'imageBucketName': instance.imageBucketName,
      'reportsBucketName': instance.reportsBucketName,
      'exportedApiBucketName': instance.exportedApiBucketName,
      'projectId': instance.projectId,
      'searchServicePrefix': instance.searchServicePrefix,
      'fallbackSearchServicePrefix': instance.fallbackSearchServicePrefix,
      'defaultServiceBaseUrl': instance.defaultServiceBaseUrl,
      'dartdocStorageBucketName': instance.dartdocStorageBucketName,
      'popularityDumpBucketName': instance.popularityDumpBucketName,
      'searchSnapshotBucketName': instance.searchSnapshotBucketName,
      'maxTaskInstances': instance.maxTaskInstances,
      'maxTaskRunHours': instance.maxTaskRunHours,
      'taskResultBucketName': instance.taskResultBucketName,
      'taskWorkerImage': instance.taskWorkerImage,
      'taskWorkerProject': instance.taskWorkerProject,
      'taskWorkerNetwork': instance.taskWorkerNetwork,
      'cosImage': instance.cosImage,
      'taskWorkerServiceAccount': instance.taskWorkerServiceAccount,
      'storageBaseUrl': instance.storageBaseUrl,
      'pubClientAudience': instance.pubClientAudience,
      'pubServerAudience': instance.pubServerAudience,
      'externalServiceAudience': instance.externalServiceAudience,
      'gmailRelayServiceAccount': instance.gmailRelayServiceAccount,
      'uploadSignerServiceAccount': instance.uploadSignerServiceAccount,
      'blockRobots': instance.blockRobots,
      'productionHosts': instance.productionHosts,
      'primaryApiUri': instance.primaryApiUri?.toString(),
      'primarySiteUri': instance.primarySiteUri.toString(),
      'admins': instance.admins?.map((e) => e.toJson()).toList(),
      'tools': instance.tools?.toJson(),
      'rateLimits': instance.rateLimits?.map((e) => e.toJson()).toList(),
    };

AdminId _$AdminIdFromJson(Map json) => $checkedCreate(
      'AdminId',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['oauthUserId', 'email', 'permissions'],
        );
        final val = AdminId(
          oauthUserId: $checkedConvert('oauthUserId', (v) => v as String?),
          email: $checkedConvert('email', (v) => v as String?),
          permissions: $checkedConvert(
              'permissions',
              (v) => (v as List<dynamic>).map(
                  (e) => $enumDecodeNullable(_$AdminPermissionEnumMap, e))),
        );
        return val;
      },
    );

Map<String, dynamic> _$AdminIdToJson(AdminId instance) => <String, dynamic>{
      'oauthUserId': instance.oauthUserId,
      'email': instance.email,
      'permissions': instance.permissions
          .map((e) => _$AdminPermissionEnumMap[e]!)
          .toList(),
    };

const _$AdminPermissionEnumMap = {
  AdminPermission.executeTool: 'executeTool',
  AdminPermission.invokeAction: 'invokeAction',
  AdminPermission.listUsers: 'listUsers',
  AdminPermission.manageAssignedTags: 'manageAssignedTags',
  AdminPermission.managePackageOwnership: 'managePackageOwnership',
  AdminPermission.manageRetraction: 'manageRetraction',
  AdminPermission.removePackage: 'removePackage',
  AdminPermission.removeUsers: 'removeUsers',
};

ToolsConfiguration _$ToolsConfigurationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ToolsConfiguration',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'stableDartSdkPath',
            'stableFlutterSdkPath',
            'previewDartSdkPath',
            'previewFlutterSdkPath'
          ],
        );
        final val = ToolsConfiguration(
          stableDartSdkPath:
              $checkedConvert('stableDartSdkPath', (v) => v as String?),
          stableFlutterSdkPath:
              $checkedConvert('stableFlutterSdkPath', (v) => v as String?),
          previewDartSdkPath:
              $checkedConvert('previewDartSdkPath', (v) => v as String?),
          previewFlutterSdkPath:
              $checkedConvert('previewFlutterSdkPath', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$ToolsConfigurationToJson(ToolsConfiguration instance) =>
    <String, dynamic>{
      'stableDartSdkPath': instance.stableDartSdkPath,
      'stableFlutterSdkPath': instance.stableFlutterSdkPath,
      'previewDartSdkPath': instance.previewDartSdkPath,
      'previewFlutterSdkPath': instance.previewFlutterSdkPath,
    };

RateLimit _$RateLimitFromJson(Map<String, dynamic> json) => $checkedCreate(
      'RateLimit',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['operation', 'scope', 'burst', 'hourly', 'daily'],
        );
        final val = RateLimit(
          operation: $checkedConvert('operation', (v) => v as String),
          scope: $checkedConvert(
              'scope', (v) => $enumDecode(_$RateLimitScopeEnumMap, v)),
          burst: $checkedConvert('burst', (v) => v as int?),
          hourly: $checkedConvert('hourly', (v) => v as int?),
          daily: $checkedConvert('daily', (v) => v as int?),
        );
        return val;
      },
    );

Map<String, dynamic> _$RateLimitToJson(RateLimit instance) {
  final val = <String, dynamic>{
    'operation': instance.operation,
    'scope': _$RateLimitScopeEnumMap[instance.scope]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('burst', instance.burst);
  writeNotNull('hourly', instance.hourly);
  writeNotNull('daily', instance.daily);
  return val;
}

const _$RateLimitScopeEnumMap = {
  RateLimitScope.package: 'package',
  RateLimitScope.user: 'user',
};
