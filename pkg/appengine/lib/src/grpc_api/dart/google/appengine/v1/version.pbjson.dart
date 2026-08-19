//
//  Generated code. Do not modify.
//  source: google/appengine/v1/version.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use inboundServiceTypeDescriptor instead')
const InboundServiceType$json = {
  '1': 'InboundServiceType',
  '2': [
    {'1': 'INBOUND_SERVICE_UNSPECIFIED', '2': 0},
    {'1': 'INBOUND_SERVICE_MAIL', '2': 1},
    {'1': 'INBOUND_SERVICE_MAIL_BOUNCE', '2': 2},
    {'1': 'INBOUND_SERVICE_XMPP_ERROR', '2': 3},
    {'1': 'INBOUND_SERVICE_XMPP_MESSAGE', '2': 4},
    {'1': 'INBOUND_SERVICE_XMPP_SUBSCRIBE', '2': 5},
    {'1': 'INBOUND_SERVICE_XMPP_PRESENCE', '2': 6},
    {'1': 'INBOUND_SERVICE_CHANNEL_PRESENCE', '2': 7},
    {'1': 'INBOUND_SERVICE_WARMUP', '2': 9},
  ],
};

/// Descriptor for `InboundServiceType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List inboundServiceTypeDescriptor = $convert.base64Decode(
    'ChJJbmJvdW5kU2VydmljZVR5cGUSHwobSU5CT1VORF9TRVJWSUNFX1VOU1BFQ0lGSUVEEAASGA'
    'oUSU5CT1VORF9TRVJWSUNFX01BSUwQARIfChtJTkJPVU5EX1NFUlZJQ0VfTUFJTF9CT1VOQ0UQ'
    'AhIeChpJTkJPVU5EX1NFUlZJQ0VfWE1QUF9FUlJPUhADEiAKHElOQk9VTkRfU0VSVklDRV9YTV'
    'BQX01FU1NBR0UQBBIiCh5JTkJPVU5EX1NFUlZJQ0VfWE1QUF9TVUJTQ1JJQkUQBRIhCh1JTkJP'
    'VU5EX1NFUlZJQ0VfWE1QUF9QUkVTRU5DRRAGEiQKIElOQk9VTkRfU0VSVklDRV9DSEFOTkVMX1'
    'BSRVNFTkNFEAcSGgoWSU5CT1VORF9TRVJWSUNFX1dBUk1VUBAJ');

@$core.Deprecated('Use servingStatusDescriptor instead')
const ServingStatus$json = {
  '1': 'ServingStatus',
  '2': [
    {'1': 'SERVING_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'SERVING', '2': 1},
    {'1': 'STOPPED', '2': 2},
  ],
};

/// Descriptor for `ServingStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List servingStatusDescriptor = $convert.base64Decode(
    'Cg1TZXJ2aW5nU3RhdHVzEh4KGlNFUlZJTkdfU1RBVFVTX1VOU1BFQ0lGSUVEEAASCwoHU0VSVk'
    'lORxABEgsKB1NUT1BQRUQQAg==');

@$core.Deprecated('Use versionDescriptor instead')
const Version$json = {
  '1': 'Version',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'automatic_scaling',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.AutomaticScaling',
      '9': 0,
      '10': 'automaticScaling'
    },
    {
      '1': 'basic_scaling',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.BasicScaling',
      '9': 0,
      '10': 'basicScaling'
    },
    {
      '1': 'manual_scaling',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.ManualScaling',
      '9': 0,
      '10': 'manualScaling'
    },
    {
      '1': 'inbound_services',
      '3': 6,
      '4': 3,
      '5': 14,
      '6': '.google.appengine.v1.InboundServiceType',
      '10': 'inboundServices'
    },
    {'1': 'instance_class', '3': 7, '4': 1, '5': 9, '10': 'instanceClass'},
    {
      '1': 'network',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.Network',
      '10': 'network'
    },
    {'1': 'zones', '3': 118, '4': 3, '5': 9, '10': 'zones'},
    {
      '1': 'resources',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.Resources',
      '10': 'resources'
    },
    {'1': 'runtime', '3': 10, '4': 1, '5': 9, '10': 'runtime'},
    {'1': 'runtime_channel', '3': 117, '4': 1, '5': 9, '10': 'runtimeChannel'},
    {'1': 'threadsafe', '3': 11, '4': 1, '5': 8, '10': 'threadsafe'},
    {'1': 'vm', '3': 12, '4': 1, '5': 8, '10': 'vm'},
    {'1': 'app_engine_apis', '3': 128, '4': 1, '5': 8, '10': 'appEngineApis'},
    {
      '1': 'beta_settings',
      '3': 13,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.Version.BetaSettingsEntry',
      '10': 'betaSettings'
    },
    {'1': 'env', '3': 14, '4': 1, '5': 9, '10': 'env'},
    {
      '1': 'serving_status',
      '3': 15,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1.ServingStatus',
      '10': 'servingStatus'
    },
    {'1': 'created_by', '3': 16, '4': 1, '5': 9, '10': 'createdBy'},
    {
      '1': 'create_time',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createTime'
    },
    {'1': 'disk_usage_bytes', '3': 18, '4': 1, '5': 3, '10': 'diskUsageBytes'},
    {
      '1': 'runtime_api_version',
      '3': 21,
      '4': 1,
      '5': 9,
      '10': 'runtimeApiVersion'
    },
    {
      '1': 'runtime_main_executable_path',
      '3': 22,
      '4': 1,
      '5': 9,
      '10': 'runtimeMainExecutablePath'
    },
    {'1': 'service_account', '3': 127, '4': 1, '5': 9, '10': 'serviceAccount'},
    {
      '1': 'handlers',
      '3': 100,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.UrlMap',
      '10': 'handlers'
    },
    {
      '1': 'error_handlers',
      '3': 101,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.ErrorHandler',
      '10': 'errorHandlers'
    },
    {
      '1': 'libraries',
      '3': 102,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.Library',
      '10': 'libraries'
    },
    {
      '1': 'api_config',
      '3': 103,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.ApiConfigHandler',
      '10': 'apiConfig'
    },
    {
      '1': 'env_variables',
      '3': 104,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.Version.EnvVariablesEntry',
      '10': 'envVariables'
    },
    {
      '1': 'build_env_variables',
      '3': 125,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.Version.BuildEnvVariablesEntry',
      '10': 'buildEnvVariables'
    },
    {
      '1': 'default_expiration',
      '3': 105,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'defaultExpiration'
    },
    {
      '1': 'health_check',
      '3': 106,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.HealthCheck',
      '10': 'healthCheck'
    },
    {
      '1': 'readiness_check',
      '3': 112,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.ReadinessCheck',
      '10': 'readinessCheck'
    },
    {
      '1': 'liveness_check',
      '3': 113,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.LivenessCheck',
      '10': 'livenessCheck'
    },
    {
      '1': 'nobuild_files_regex',
      '3': 107,
      '4': 1,
      '5': 9,
      '10': 'nobuildFilesRegex'
    },
    {
      '1': 'deployment',
      '3': 108,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.Deployment',
      '10': 'deployment'
    },
    {'1': 'version_url', '3': 109, '4': 1, '5': 9, '10': 'versionUrl'},
    {
      '1': 'endpoints_api_service',
      '3': 110,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.EndpointsApiService',
      '10': 'endpointsApiService'
    },
    {
      '1': 'entrypoint',
      '3': 122,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.Entrypoint',
      '10': 'entrypoint'
    },
    {
      '1': 'vpc_access_connector',
      '3': 121,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.VpcAccessConnector',
      '10': 'vpcAccessConnector'
    },
  ],
  '3': [
    Version_BetaSettingsEntry$json,
    Version_EnvVariablesEntry$json,
    Version_BuildEnvVariablesEntry$json
  ],
  '8': [
    {'1': 'scaling'},
  ],
};

@$core.Deprecated('Use versionDescriptor instead')
const Version_BetaSettingsEntry$json = {
  '1': 'BetaSettingsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use versionDescriptor instead')
const Version_EnvVariablesEntry$json = {
  '1': 'EnvVariablesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use versionDescriptor instead')
const Version_BuildEnvVariablesEntry$json = {
  '1': 'BuildEnvVariablesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Version`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionDescriptor = $convert.base64Decode(
    'CgdWZXJzaW9uEhIKBG5hbWUYASABKAlSBG5hbWUSDgoCaWQYAiABKAlSAmlkElQKEWF1dG9tYX'
    'RpY19zY2FsaW5nGAMgASgLMiUuZ29vZ2xlLmFwcGVuZ2luZS52MS5BdXRvbWF0aWNTY2FsaW5n'
    'SABSEGF1dG9tYXRpY1NjYWxpbmcSSAoNYmFzaWNfc2NhbGluZxgEIAEoCzIhLmdvb2dsZS5hcH'
    'BlbmdpbmUudjEuQmFzaWNTY2FsaW5nSABSDGJhc2ljU2NhbGluZxJLCg5tYW51YWxfc2NhbGlu'
    'ZxgFIAEoCzIiLmdvb2dsZS5hcHBlbmdpbmUudjEuTWFudWFsU2NhbGluZ0gAUg1tYW51YWxTY2'
    'FsaW5nElIKEGluYm91bmRfc2VydmljZXMYBiADKA4yJy5nb29nbGUuYXBwZW5naW5lLnYxLklu'
    'Ym91bmRTZXJ2aWNlVHlwZVIPaW5ib3VuZFNlcnZpY2VzEiUKDmluc3RhbmNlX2NsYXNzGAcgAS'
    'gJUg1pbnN0YW5jZUNsYXNzEjYKB25ldHdvcmsYCCABKAsyHC5nb29nbGUuYXBwZW5naW5lLnYx'
    'Lk5ldHdvcmtSB25ldHdvcmsSFAoFem9uZXMYdiADKAlSBXpvbmVzEjwKCXJlc291cmNlcxgJIA'
    'EoCzIeLmdvb2dsZS5hcHBlbmdpbmUudjEuUmVzb3VyY2VzUglyZXNvdXJjZXMSGAoHcnVudGlt'
    'ZRgKIAEoCVIHcnVudGltZRInCg9ydW50aW1lX2NoYW5uZWwYdSABKAlSDnJ1bnRpbWVDaGFubm'
    'VsEh4KCnRocmVhZHNhZmUYCyABKAhSCnRocmVhZHNhZmUSDgoCdm0YDCABKAhSAnZtEicKD2Fw'
    'cF9lbmdpbmVfYXBpcxiAASABKAhSDWFwcEVuZ2luZUFwaXMSUwoNYmV0YV9zZXR0aW5ncxgNIA'
    'MoCzIuLmdvb2dsZS5hcHBlbmdpbmUudjEuVmVyc2lvbi5CZXRhU2V0dGluZ3NFbnRyeVIMYmV0'
    'YVNldHRpbmdzEhAKA2VudhgOIAEoCVIDZW52EkkKDnNlcnZpbmdfc3RhdHVzGA8gASgOMiIuZ2'
    '9vZ2xlLmFwcGVuZ2luZS52MS5TZXJ2aW5nU3RhdHVzUg1zZXJ2aW5nU3RhdHVzEh0KCmNyZWF0'
    'ZWRfYnkYECABKAlSCWNyZWF0ZWRCeRI7CgtjcmVhdGVfdGltZRgRIAEoCzIaLmdvb2dsZS5wcm'
    '90b2J1Zi5UaW1lc3RhbXBSCmNyZWF0ZVRpbWUSKAoQZGlza191c2FnZV9ieXRlcxgSIAEoA1IO'
    'ZGlza1VzYWdlQnl0ZXMSLgoTcnVudGltZV9hcGlfdmVyc2lvbhgVIAEoCVIRcnVudGltZUFwaV'
    'ZlcnNpb24SPwoccnVudGltZV9tYWluX2V4ZWN1dGFibGVfcGF0aBgWIAEoCVIZcnVudGltZU1h'
    'aW5FeGVjdXRhYmxlUGF0aBInCg9zZXJ2aWNlX2FjY291bnQYfyABKAlSDnNlcnZpY2VBY2NvdW'
    '50EjcKCGhhbmRsZXJzGGQgAygLMhsuZ29vZ2xlLmFwcGVuZ2luZS52MS5VcmxNYXBSCGhhbmRs'
    'ZXJzEkgKDmVycm9yX2hhbmRsZXJzGGUgAygLMiEuZ29vZ2xlLmFwcGVuZ2luZS52MS5FcnJvck'
    'hhbmRsZXJSDWVycm9ySGFuZGxlcnMSOgoJbGlicmFyaWVzGGYgAygLMhwuZ29vZ2xlLmFwcGVu'
    'Z2luZS52MS5MaWJyYXJ5UglsaWJyYXJpZXMSRAoKYXBpX2NvbmZpZxhnIAEoCzIlLmdvb2dsZS'
    '5hcHBlbmdpbmUudjEuQXBpQ29uZmlnSGFuZGxlclIJYXBpQ29uZmlnElMKDWVudl92YXJpYWJs'
    'ZXMYaCADKAsyLi5nb29nbGUuYXBwZW5naW5lLnYxLlZlcnNpb24uRW52VmFyaWFibGVzRW50cn'
    'lSDGVudlZhcmlhYmxlcxJjChNidWlsZF9lbnZfdmFyaWFibGVzGH0gAygLMjMuZ29vZ2xlLmFw'
    'cGVuZ2luZS52MS5WZXJzaW9uLkJ1aWxkRW52VmFyaWFibGVzRW50cnlSEWJ1aWxkRW52VmFyaW'
    'FibGVzEkgKEmRlZmF1bHRfZXhwaXJhdGlvbhhpIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJh'
    'dGlvblIRZGVmYXVsdEV4cGlyYXRpb24SQwoMaGVhbHRoX2NoZWNrGGogASgLMiAuZ29vZ2xlLm'
    'FwcGVuZ2luZS52MS5IZWFsdGhDaGVja1ILaGVhbHRoQ2hlY2sSTAoPcmVhZGluZXNzX2NoZWNr'
    'GHAgASgLMiMuZ29vZ2xlLmFwcGVuZ2luZS52MS5SZWFkaW5lc3NDaGVja1IOcmVhZGluZXNzQ2'
    'hlY2sSSQoObGl2ZW5lc3NfY2hlY2sYcSABKAsyIi5nb29nbGUuYXBwZW5naW5lLnYxLkxpdmVu'
    'ZXNzQ2hlY2tSDWxpdmVuZXNzQ2hlY2sSLgoTbm9idWlsZF9maWxlc19yZWdleBhrIAEoCVIRbm'
    '9idWlsZEZpbGVzUmVnZXgSPwoKZGVwbG95bWVudBhsIAEoCzIfLmdvb2dsZS5hcHBlbmdpbmUu'
    'djEuRGVwbG95bWVudFIKZGVwbG95bWVudBIfCgt2ZXJzaW9uX3VybBhtIAEoCVIKdmVyc2lvbl'
    'VybBJcChVlbmRwb2ludHNfYXBpX3NlcnZpY2UYbiABKAsyKC5nb29nbGUuYXBwZW5naW5lLnYx'
    'LkVuZHBvaW50c0FwaVNlcnZpY2VSE2VuZHBvaW50c0FwaVNlcnZpY2USPwoKZW50cnlwb2ludB'
    'h6IAEoCzIfLmdvb2dsZS5hcHBlbmdpbmUudjEuRW50cnlwb2ludFIKZW50cnlwb2ludBJZChR2'
    'cGNfYWNjZXNzX2Nvbm5lY3Rvchh5IAEoCzInLmdvb2dsZS5hcHBlbmdpbmUudjEuVnBjQWNjZX'
    'NzQ29ubmVjdG9yUhJ2cGNBY2Nlc3NDb25uZWN0b3IaPwoRQmV0YVNldHRpbmdzRW50cnkSEAoD'
    'a2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo/ChFFbnZWYXJpYWJsZX'
    'NFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGkQKFkJ1'
    'aWxkRW52VmFyaWFibGVzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBX'
    'ZhbHVlOgI4AUIJCgdzY2FsaW5n');

@$core.Deprecated('Use endpointsApiServiceDescriptor instead')
const EndpointsApiService$json = {
  '1': 'EndpointsApiService',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'config_id', '3': 2, '4': 1, '5': 9, '10': 'configId'},
    {
      '1': 'rollout_strategy',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1.EndpointsApiService.RolloutStrategy',
      '10': 'rolloutStrategy'
    },
    {
      '1': 'disable_trace_sampling',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'disableTraceSampling'
    },
  ],
  '4': [EndpointsApiService_RolloutStrategy$json],
};

@$core.Deprecated('Use endpointsApiServiceDescriptor instead')
const EndpointsApiService_RolloutStrategy$json = {
  '1': 'RolloutStrategy',
  '2': [
    {'1': 'UNSPECIFIED_ROLLOUT_STRATEGY', '2': 0},
    {'1': 'FIXED', '2': 1},
    {'1': 'MANAGED', '2': 2},
  ],
};

/// Descriptor for `EndpointsApiService`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endpointsApiServiceDescriptor = $convert.base64Decode(
    'ChNFbmRwb2ludHNBcGlTZXJ2aWNlEhIKBG5hbWUYASABKAlSBG5hbWUSGwoJY29uZmlnX2lkGA'
    'IgASgJUghjb25maWdJZBJjChByb2xsb3V0X3N0cmF0ZWd5GAMgASgOMjguZ29vZ2xlLmFwcGVu'
    'Z2luZS52MS5FbmRwb2ludHNBcGlTZXJ2aWNlLlJvbGxvdXRTdHJhdGVneVIPcm9sbG91dFN0cm'
    'F0ZWd5EjQKFmRpc2FibGVfdHJhY2Vfc2FtcGxpbmcYBCABKAhSFGRpc2FibGVUcmFjZVNhbXBs'
    'aW5nIksKD1JvbGxvdXRTdHJhdGVneRIgChxVTlNQRUNJRklFRF9ST0xMT1VUX1NUUkFURUdZEA'
    'ASCQoFRklYRUQQARILCgdNQU5BR0VEEAI=');

@$core.Deprecated('Use automaticScalingDescriptor instead')
const AutomaticScaling$json = {
  '1': 'AutomaticScaling',
  '2': [
    {
      '1': 'cool_down_period',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'coolDownPeriod'
    },
    {
      '1': 'cpu_utilization',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.CpuUtilization',
      '10': 'cpuUtilization'
    },
    {
      '1': 'max_concurrent_requests',
      '3': 3,
      '4': 1,
      '5': 5,
      '10': 'maxConcurrentRequests'
    },
    {
      '1': 'max_idle_instances',
      '3': 4,
      '4': 1,
      '5': 5,
      '10': 'maxIdleInstances'
    },
    {
      '1': 'max_total_instances',
      '3': 5,
      '4': 1,
      '5': 5,
      '10': 'maxTotalInstances'
    },
    {
      '1': 'max_pending_latency',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'maxPendingLatency'
    },
    {
      '1': 'min_idle_instances',
      '3': 7,
      '4': 1,
      '5': 5,
      '10': 'minIdleInstances'
    },
    {
      '1': 'min_total_instances',
      '3': 8,
      '4': 1,
      '5': 5,
      '10': 'minTotalInstances'
    },
    {
      '1': 'min_pending_latency',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'minPendingLatency'
    },
    {
      '1': 'request_utilization',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.RequestUtilization',
      '10': 'requestUtilization'
    },
    {
      '1': 'disk_utilization',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.DiskUtilization',
      '10': 'diskUtilization'
    },
    {
      '1': 'network_utilization',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.NetworkUtilization',
      '10': 'networkUtilization'
    },
    {
      '1': 'standard_scheduler_settings',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.StandardSchedulerSettings',
      '10': 'standardSchedulerSettings'
    },
  ],
};

/// Descriptor for `AutomaticScaling`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List automaticScalingDescriptor = $convert.base64Decode(
    'ChBBdXRvbWF0aWNTY2FsaW5nEkMKEGNvb2xfZG93bl9wZXJpb2QYASABKAsyGS5nb29nbGUucH'
    'JvdG9idWYuRHVyYXRpb25SDmNvb2xEb3duUGVyaW9kEkwKD2NwdV91dGlsaXphdGlvbhgCIAEo'
    'CzIjLmdvb2dsZS5hcHBlbmdpbmUudjEuQ3B1VXRpbGl6YXRpb25SDmNwdVV0aWxpemF0aW9uEj'
    'YKF21heF9jb25jdXJyZW50X3JlcXVlc3RzGAMgASgFUhVtYXhDb25jdXJyZW50UmVxdWVzdHMS'
    'LAoSbWF4X2lkbGVfaW5zdGFuY2VzGAQgASgFUhBtYXhJZGxlSW5zdGFuY2VzEi4KE21heF90b3'
    'RhbF9pbnN0YW5jZXMYBSABKAVSEW1heFRvdGFsSW5zdGFuY2VzEkkKE21heF9wZW5kaW5nX2xh'
    'dGVuY3kYBiABKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25SEW1heFBlbmRpbmdMYXRlbm'
    'N5EiwKEm1pbl9pZGxlX2luc3RhbmNlcxgHIAEoBVIQbWluSWRsZUluc3RhbmNlcxIuChNtaW5f'
    'dG90YWxfaW5zdGFuY2VzGAggASgFUhFtaW5Ub3RhbEluc3RhbmNlcxJJChNtaW5fcGVuZGluZ1'
    '9sYXRlbmN5GAkgASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0aW9uUhFtaW5QZW5kaW5nTGF0'
    'ZW5jeRJYChNyZXF1ZXN0X3V0aWxpemF0aW9uGAogASgLMicuZ29vZ2xlLmFwcGVuZ2luZS52MS'
    '5SZXF1ZXN0VXRpbGl6YXRpb25SEnJlcXVlc3RVdGlsaXphdGlvbhJPChBkaXNrX3V0aWxpemF0'
    'aW9uGAsgASgLMiQuZ29vZ2xlLmFwcGVuZ2luZS52MS5EaXNrVXRpbGl6YXRpb25SD2Rpc2tVdG'
    'lsaXphdGlvbhJYChNuZXR3b3JrX3V0aWxpemF0aW9uGAwgASgLMicuZ29vZ2xlLmFwcGVuZ2lu'
    'ZS52MS5OZXR3b3JrVXRpbGl6YXRpb25SEm5ldHdvcmtVdGlsaXphdGlvbhJuChtzdGFuZGFyZF'
    '9zY2hlZHVsZXJfc2V0dGluZ3MYFCABKAsyLi5nb29nbGUuYXBwZW5naW5lLnYxLlN0YW5kYXJk'
    'U2NoZWR1bGVyU2V0dGluZ3NSGXN0YW5kYXJkU2NoZWR1bGVyU2V0dGluZ3M=');

@$core.Deprecated('Use basicScalingDescriptor instead')
const BasicScaling$json = {
  '1': 'BasicScaling',
  '2': [
    {
      '1': 'idle_timeout',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'idleTimeout'
    },
    {'1': 'max_instances', '3': 2, '4': 1, '5': 5, '10': 'maxInstances'},
  ],
};

/// Descriptor for `BasicScaling`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List basicScalingDescriptor = $convert.base64Decode(
    'CgxCYXNpY1NjYWxpbmcSPAoMaWRsZV90aW1lb3V0GAEgASgLMhkuZ29vZ2xlLnByb3RvYnVmLk'
    'R1cmF0aW9uUgtpZGxlVGltZW91dBIjCg1tYXhfaW5zdGFuY2VzGAIgASgFUgxtYXhJbnN0YW5j'
    'ZXM=');

@$core.Deprecated('Use manualScalingDescriptor instead')
const ManualScaling$json = {
  '1': 'ManualScaling',
  '2': [
    {'1': 'instances', '3': 1, '4': 1, '5': 5, '10': 'instances'},
  ],
};

/// Descriptor for `ManualScaling`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List manualScalingDescriptor = $convert.base64Decode(
    'Cg1NYW51YWxTY2FsaW5nEhwKCWluc3RhbmNlcxgBIAEoBVIJaW5zdGFuY2Vz');

@$core.Deprecated('Use cpuUtilizationDescriptor instead')
const CpuUtilization$json = {
  '1': 'CpuUtilization',
  '2': [
    {
      '1': 'aggregation_window_length',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'aggregationWindowLength'
    },
    {
      '1': 'target_utilization',
      '3': 2,
      '4': 1,
      '5': 1,
      '10': 'targetUtilization'
    },
  ],
};

/// Descriptor for `CpuUtilization`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cpuUtilizationDescriptor = $convert.base64Decode(
    'Cg5DcHVVdGlsaXphdGlvbhJVChlhZ2dyZWdhdGlvbl93aW5kb3dfbGVuZ3RoGAEgASgLMhkuZ2'
    '9vZ2xlLnByb3RvYnVmLkR1cmF0aW9uUhdhZ2dyZWdhdGlvbldpbmRvd0xlbmd0aBItChJ0YXJn'
    'ZXRfdXRpbGl6YXRpb24YAiABKAFSEXRhcmdldFV0aWxpemF0aW9u');

@$core.Deprecated('Use requestUtilizationDescriptor instead')
const RequestUtilization$json = {
  '1': 'RequestUtilization',
  '2': [
    {
      '1': 'target_request_count_per_second',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'targetRequestCountPerSecond'
    },
    {
      '1': 'target_concurrent_requests',
      '3': 2,
      '4': 1,
      '5': 5,
      '10': 'targetConcurrentRequests'
    },
  ],
};

/// Descriptor for `RequestUtilization`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestUtilizationDescriptor = $convert.base64Decode(
    'ChJSZXF1ZXN0VXRpbGl6YXRpb24SRAofdGFyZ2V0X3JlcXVlc3RfY291bnRfcGVyX3NlY29uZB'
    'gBIAEoBVIbdGFyZ2V0UmVxdWVzdENvdW50UGVyU2Vjb25kEjwKGnRhcmdldF9jb25jdXJyZW50'
    'X3JlcXVlc3RzGAIgASgFUhh0YXJnZXRDb25jdXJyZW50UmVxdWVzdHM=');

@$core.Deprecated('Use diskUtilizationDescriptor instead')
const DiskUtilization$json = {
  '1': 'DiskUtilization',
  '2': [
    {
      '1': 'target_write_bytes_per_second',
      '3': 14,
      '4': 1,
      '5': 5,
      '10': 'targetWriteBytesPerSecond'
    },
    {
      '1': 'target_write_ops_per_second',
      '3': 15,
      '4': 1,
      '5': 5,
      '10': 'targetWriteOpsPerSecond'
    },
    {
      '1': 'target_read_bytes_per_second',
      '3': 16,
      '4': 1,
      '5': 5,
      '10': 'targetReadBytesPerSecond'
    },
    {
      '1': 'target_read_ops_per_second',
      '3': 17,
      '4': 1,
      '5': 5,
      '10': 'targetReadOpsPerSecond'
    },
  ],
};

/// Descriptor for `DiskUtilization`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List diskUtilizationDescriptor = $convert.base64Decode(
    'Cg9EaXNrVXRpbGl6YXRpb24SQAoddGFyZ2V0X3dyaXRlX2J5dGVzX3Blcl9zZWNvbmQYDiABKA'
    'VSGXRhcmdldFdyaXRlQnl0ZXNQZXJTZWNvbmQSPAobdGFyZ2V0X3dyaXRlX29wc19wZXJfc2Vj'
    'b25kGA8gASgFUhd0YXJnZXRXcml0ZU9wc1BlclNlY29uZBI+Chx0YXJnZXRfcmVhZF9ieXRlc1'
    '9wZXJfc2Vjb25kGBAgASgFUhh0YXJnZXRSZWFkQnl0ZXNQZXJTZWNvbmQSOgoadGFyZ2V0X3Jl'
    'YWRfb3BzX3Blcl9zZWNvbmQYESABKAVSFnRhcmdldFJlYWRPcHNQZXJTZWNvbmQ=');

@$core.Deprecated('Use networkUtilizationDescriptor instead')
const NetworkUtilization$json = {
  '1': 'NetworkUtilization',
  '2': [
    {
      '1': 'target_sent_bytes_per_second',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'targetSentBytesPerSecond'
    },
    {
      '1': 'target_sent_packets_per_second',
      '3': 11,
      '4': 1,
      '5': 5,
      '10': 'targetSentPacketsPerSecond'
    },
    {
      '1': 'target_received_bytes_per_second',
      '3': 12,
      '4': 1,
      '5': 5,
      '10': 'targetReceivedBytesPerSecond'
    },
    {
      '1': 'target_received_packets_per_second',
      '3': 13,
      '4': 1,
      '5': 5,
      '10': 'targetReceivedPacketsPerSecond'
    },
  ],
};

/// Descriptor for `NetworkUtilization`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List networkUtilizationDescriptor = $convert.base64Decode(
    'ChJOZXR3b3JrVXRpbGl6YXRpb24SPgocdGFyZ2V0X3NlbnRfYnl0ZXNfcGVyX3NlY29uZBgBIA'
    'EoBVIYdGFyZ2V0U2VudEJ5dGVzUGVyU2Vjb25kEkIKHnRhcmdldF9zZW50X3BhY2tldHNfcGVy'
    'X3NlY29uZBgLIAEoBVIadGFyZ2V0U2VudFBhY2tldHNQZXJTZWNvbmQSRgogdGFyZ2V0X3JlY2'
    'VpdmVkX2J5dGVzX3Blcl9zZWNvbmQYDCABKAVSHHRhcmdldFJlY2VpdmVkQnl0ZXNQZXJTZWNv'
    'bmQSSgoidGFyZ2V0X3JlY2VpdmVkX3BhY2tldHNfcGVyX3NlY29uZBgNIAEoBVIedGFyZ2V0Um'
    'VjZWl2ZWRQYWNrZXRzUGVyU2Vjb25k');

@$core.Deprecated('Use standardSchedulerSettingsDescriptor instead')
const StandardSchedulerSettings$json = {
  '1': 'StandardSchedulerSettings',
  '2': [
    {
      '1': 'target_cpu_utilization',
      '3': 1,
      '4': 1,
      '5': 1,
      '10': 'targetCpuUtilization'
    },
    {
      '1': 'target_throughput_utilization',
      '3': 2,
      '4': 1,
      '5': 1,
      '10': 'targetThroughputUtilization'
    },
    {'1': 'min_instances', '3': 3, '4': 1, '5': 5, '10': 'minInstances'},
    {'1': 'max_instances', '3': 4, '4': 1, '5': 5, '10': 'maxInstances'},
  ],
};

/// Descriptor for `StandardSchedulerSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List standardSchedulerSettingsDescriptor = $convert.base64Decode(
    'ChlTdGFuZGFyZFNjaGVkdWxlclNldHRpbmdzEjQKFnRhcmdldF9jcHVfdXRpbGl6YXRpb24YAS'
    'ABKAFSFHRhcmdldENwdVV0aWxpemF0aW9uEkIKHXRhcmdldF90aHJvdWdocHV0X3V0aWxpemF0'
    'aW9uGAIgASgBUht0YXJnZXRUaHJvdWdocHV0VXRpbGl6YXRpb24SIwoNbWluX2luc3RhbmNlcx'
    'gDIAEoBVIMbWluSW5zdGFuY2VzEiMKDW1heF9pbnN0YW5jZXMYBCABKAVSDG1heEluc3RhbmNl'
    'cw==');

@$core.Deprecated('Use networkDescriptor instead')
const Network$json = {
  '1': 'Network',
  '2': [
    {'1': 'forwarded_ports', '3': 1, '4': 3, '5': 9, '10': 'forwardedPorts'},
    {'1': 'instance_tag', '3': 2, '4': 1, '5': 9, '10': 'instanceTag'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'subnetwork_name', '3': 4, '4': 1, '5': 9, '10': 'subnetworkName'},
    {'1': 'session_affinity', '3': 5, '4': 1, '5': 8, '10': 'sessionAffinity'},
  ],
};

/// Descriptor for `Network`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List networkDescriptor = $convert.base64Decode(
    'CgdOZXR3b3JrEicKD2ZvcndhcmRlZF9wb3J0cxgBIAMoCVIOZm9yd2FyZGVkUG9ydHMSIQoMaW'
    '5zdGFuY2VfdGFnGAIgASgJUgtpbnN0YW5jZVRhZxISCgRuYW1lGAMgASgJUgRuYW1lEicKD3N1'
    'Ym5ldHdvcmtfbmFtZRgEIAEoCVIOc3VibmV0d29ya05hbWUSKQoQc2Vzc2lvbl9hZmZpbml0eR'
    'gFIAEoCFIPc2Vzc2lvbkFmZmluaXR5');

@$core.Deprecated('Use volumeDescriptor instead')
const Volume$json = {
  '1': 'Volume',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'volume_type', '3': 2, '4': 1, '5': 9, '10': 'volumeType'},
    {'1': 'size_gb', '3': 3, '4': 1, '5': 1, '10': 'sizeGb'},
  ],
};

/// Descriptor for `Volume`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List volumeDescriptor = $convert.base64Decode(
    'CgZWb2x1bWUSEgoEbmFtZRgBIAEoCVIEbmFtZRIfCgt2b2x1bWVfdHlwZRgCIAEoCVIKdm9sdW'
    '1lVHlwZRIXCgdzaXplX2diGAMgASgBUgZzaXplR2I=');

@$core.Deprecated('Use resourcesDescriptor instead')
const Resources$json = {
  '1': 'Resources',
  '2': [
    {'1': 'cpu', '3': 1, '4': 1, '5': 1, '10': 'cpu'},
    {'1': 'disk_gb', '3': 2, '4': 1, '5': 1, '10': 'diskGb'},
    {'1': 'memory_gb', '3': 3, '4': 1, '5': 1, '10': 'memoryGb'},
    {
      '1': 'volumes',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.Volume',
      '10': 'volumes'
    },
    {'1': 'kms_key_reference', '3': 5, '4': 1, '5': 9, '10': 'kmsKeyReference'},
  ],
};

/// Descriptor for `Resources`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resourcesDescriptor = $convert.base64Decode(
    'CglSZXNvdXJjZXMSEAoDY3B1GAEgASgBUgNjcHUSFwoHZGlza19nYhgCIAEoAVIGZGlza0diEh'
    'sKCW1lbW9yeV9nYhgDIAEoAVIIbWVtb3J5R2ISNQoHdm9sdW1lcxgEIAMoCzIbLmdvb2dsZS5h'
    'cHBlbmdpbmUudjEuVm9sdW1lUgd2b2x1bWVzEioKEWttc19rZXlfcmVmZXJlbmNlGAUgASgJUg'
    '9rbXNLZXlSZWZlcmVuY2U=');

@$core.Deprecated('Use vpcAccessConnectorDescriptor instead')
const VpcAccessConnector$json = {
  '1': 'VpcAccessConnector',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'egress_setting',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1.VpcAccessConnector.EgressSetting',
      '10': 'egressSetting'
    },
  ],
  '4': [VpcAccessConnector_EgressSetting$json],
};

@$core.Deprecated('Use vpcAccessConnectorDescriptor instead')
const VpcAccessConnector_EgressSetting$json = {
  '1': 'EgressSetting',
  '2': [
    {'1': 'EGRESS_SETTING_UNSPECIFIED', '2': 0},
    {'1': 'ALL_TRAFFIC', '2': 1},
    {'1': 'PRIVATE_IP_RANGES', '2': 2},
  ],
};

/// Descriptor for `VpcAccessConnector`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vpcAccessConnectorDescriptor = $convert.base64Decode(
    'ChJWcGNBY2Nlc3NDb25uZWN0b3ISEgoEbmFtZRgBIAEoCVIEbmFtZRJcCg5lZ3Jlc3Nfc2V0dG'
    'luZxgCIAEoDjI1Lmdvb2dsZS5hcHBlbmdpbmUudjEuVnBjQWNjZXNzQ29ubmVjdG9yLkVncmVz'
    'c1NldHRpbmdSDWVncmVzc1NldHRpbmciVwoNRWdyZXNzU2V0dGluZxIeChpFR1JFU1NfU0VUVE'
    'lOR19VTlNQRUNJRklFRBAAEg8KC0FMTF9UUkFGRklDEAESFQoRUFJJVkFURV9JUF9SQU5HRVMQ'
    'Ag==');

@$core.Deprecated('Use entrypointDescriptor instead')
const Entrypoint$json = {
  '1': 'Entrypoint',
  '2': [
    {'1': 'shell', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'shell'},
  ],
  '8': [
    {'1': 'command'},
  ],
};

/// Descriptor for `Entrypoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entrypointDescriptor = $convert.base64Decode(
    'CgpFbnRyeXBvaW50EhYKBXNoZWxsGAEgASgJSABSBXNoZWxsQgkKB2NvbW1hbmQ=');
