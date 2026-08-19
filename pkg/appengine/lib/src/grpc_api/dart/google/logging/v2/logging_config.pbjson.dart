//
//  Generated code. Do not modify.
//  source: google/logging/v2/logging_config.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use operationStateDescriptor instead')
const OperationState$json = {
  '1': 'OperationState',
  '2': [
    {'1': 'OPERATION_STATE_UNSPECIFIED', '2': 0},
    {'1': 'OPERATION_STATE_SCHEDULED', '2': 1},
    {'1': 'OPERATION_STATE_WAITING_FOR_PERMISSIONS', '2': 2},
    {'1': 'OPERATION_STATE_RUNNING', '2': 3},
    {'1': 'OPERATION_STATE_SUCCEEDED', '2': 4},
    {'1': 'OPERATION_STATE_FAILED', '2': 5},
    {'1': 'OPERATION_STATE_CANCELLED', '2': 6},
  ],
};

/// Descriptor for `OperationState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List operationStateDescriptor = $convert.base64Decode(
    'Cg5PcGVyYXRpb25TdGF0ZRIfChtPUEVSQVRJT05fU1RBVEVfVU5TUEVDSUZJRUQQABIdChlPUE'
    'VSQVRJT05fU1RBVEVfU0NIRURVTEVEEAESKwonT1BFUkFUSU9OX1NUQVRFX1dBSVRJTkdfRk9S'
    'X1BFUk1JU1NJT05TEAISGwoXT1BFUkFUSU9OX1NUQVRFX1JVTk5JTkcQAxIdChlPUEVSQVRJT0'
    '5fU1RBVEVfU1VDQ0VFREVEEAQSGgoWT1BFUkFUSU9OX1NUQVRFX0ZBSUxFRBAFEh0KGU9QRVJB'
    'VElPTl9TVEFURV9DQU5DRUxMRUQQBg==');

@$core.Deprecated('Use lifecycleStateDescriptor instead')
const LifecycleState$json = {
  '1': 'LifecycleState',
  '2': [
    {'1': 'LIFECYCLE_STATE_UNSPECIFIED', '2': 0},
    {'1': 'ACTIVE', '2': 1},
    {'1': 'DELETE_REQUESTED', '2': 2},
    {'1': 'UPDATING', '2': 3},
    {'1': 'CREATING', '2': 4},
    {'1': 'FAILED', '2': 5},
  ],
};

/// Descriptor for `LifecycleState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List lifecycleStateDescriptor = $convert.base64Decode(
    'Cg5MaWZlY3ljbGVTdGF0ZRIfChtMSUZFQ1lDTEVfU1RBVEVfVU5TUEVDSUZJRUQQABIKCgZBQ1'
    'RJVkUQARIUChBERUxFVEVfUkVRVUVTVEVEEAISDAoIVVBEQVRJTkcQAxIMCghDUkVBVElORxAE'
    'EgoKBkZBSUxFRBAF');

@$core.Deprecated('Use indexTypeDescriptor instead')
const IndexType$json = {
  '1': 'IndexType',
  '2': [
    {'1': 'INDEX_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'INDEX_TYPE_STRING', '2': 1},
    {'1': 'INDEX_TYPE_INTEGER', '2': 2},
  ],
};

/// Descriptor for `IndexType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List indexTypeDescriptor = $convert.base64Decode(
    'CglJbmRleFR5cGUSGgoWSU5ERVhfVFlQRV9VTlNQRUNJRklFRBAAEhUKEUlOREVYX1RZUEVfU1'
    'RSSU5HEAESFgoSSU5ERVhfVFlQRV9JTlRFR0VSEAI=');

@$core.Deprecated('Use indexConfigDescriptor instead')
const IndexConfig$json = {
  '1': 'IndexConfig',
  '2': [
    {'1': 'field_path', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'fieldPath'},
    {
      '1': 'type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.logging.v2.IndexType',
      '8': {},
      '10': 'type'
    },
    {
      '1': 'create_time',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'createTime'
    },
  ],
};

/// Descriptor for `IndexConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexConfigDescriptor = $convert.base64Decode(
    'CgtJbmRleENvbmZpZxIiCgpmaWVsZF9wYXRoGAEgASgJQgPgQQJSCWZpZWxkUGF0aBI1CgR0eX'
    'BlGAIgASgOMhwuZ29vZ2xlLmxvZ2dpbmcudjIuSW5kZXhUeXBlQgPgQQJSBHR5cGUSQAoLY3Jl'
    'YXRlX3RpbWUYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wQgPgQQNSCmNyZWF0ZV'
    'RpbWU=');

@$core.Deprecated('Use logBucketDescriptor instead')
const LogBucket$json = {
  '1': 'LogBucket',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'create_time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'createTime'
    },
    {
      '1': 'update_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'updateTime'
    },
    {'1': 'retention_days', '3': 11, '4': 1, '5': 5, '10': 'retentionDays'},
    {'1': 'locked', '3': 9, '4': 1, '5': 8, '10': 'locked'},
    {
      '1': 'lifecycle_state',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.google.logging.v2.LifecycleState',
      '8': {},
      '10': 'lifecycleState'
    },
    {
      '1': 'analytics_enabled',
      '3': 14,
      '4': 1,
      '5': 8,
      '10': 'analyticsEnabled'
    },
    {
      '1': 'restricted_fields',
      '3': 15,
      '4': 3,
      '5': 9,
      '10': 'restrictedFields'
    },
    {
      '1': 'index_configs',
      '3': 17,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.IndexConfig',
      '10': 'indexConfigs'
    },
    {
      '1': 'cmek_settings',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.CmekSettings',
      '10': 'cmekSettings'
    },
  ],
  '7': {},
};

/// Descriptor for `LogBucket`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logBucketDescriptor = $convert.base64Decode(
    'CglMb2dCdWNrZXQSFwoEbmFtZRgBIAEoCUID4EEDUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAMgAS'
    'gJUgtkZXNjcmlwdGlvbhJACgtjcmVhdGVfdGltZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5U'
    'aW1lc3RhbXBCA+BBA1IKY3JlYXRlVGltZRJACgt1cGRhdGVfdGltZRgFIAEoCzIaLmdvb2dsZS'
    '5wcm90b2J1Zi5UaW1lc3RhbXBCA+BBA1IKdXBkYXRlVGltZRIlCg5yZXRlbnRpb25fZGF5cxgL'
    'IAEoBVINcmV0ZW50aW9uRGF5cxIWCgZsb2NrZWQYCSABKAhSBmxvY2tlZBJPCg9saWZlY3ljbG'
    'Vfc3RhdGUYDCABKA4yIS5nb29nbGUubG9nZ2luZy52Mi5MaWZlY3ljbGVTdGF0ZUID4EEDUg5s'
    'aWZlY3ljbGVTdGF0ZRIrChFhbmFseXRpY3NfZW5hYmxlZBgOIAEoCFIQYW5hbHl0aWNzRW5hYm'
    'xlZBIrChFyZXN0cmljdGVkX2ZpZWxkcxgPIAMoCVIQcmVzdHJpY3RlZEZpZWxkcxJDCg1pbmRl'
    'eF9jb25maWdzGBEgAygLMh4uZ29vZ2xlLmxvZ2dpbmcudjIuSW5kZXhDb25maWdSDGluZGV4Q2'
    '9uZmlncxJECg1jbWVrX3NldHRpbmdzGBMgASgLMh8uZ29vZ2xlLmxvZ2dpbmcudjIuQ21la1Nl'
    'dHRpbmdzUgxjbWVrU2V0dGluZ3M6pQLqQaECCiBsb2dnaW5nLmdvb2dsZWFwaXMuY29tL0xvZ0'
    'J1Y2tldBI4cHJvamVjdHMve3Byb2plY3R9L2xvY2F0aW9ucy97bG9jYXRpb259L2J1Y2tldHMv'
    'e2J1Y2tldH0SQm9yZ2FuaXphdGlvbnMve29yZ2FuaXphdGlvbn0vbG9jYXRpb25zL3tsb2NhdG'
    'lvbn0vYnVja2V0cy97YnVja2V0fRI2Zm9sZGVycy97Zm9sZGVyfS9sb2NhdGlvbnMve2xvY2F0'
    'aW9ufS9idWNrZXRzL3tidWNrZXR9EkdiaWxsaW5nQWNjb3VudHMve2JpbGxpbmdfYWNjb3VudH'
    '0vbG9jYXRpb25zL3tsb2NhdGlvbn0vYnVja2V0cy97YnVja2V0fQ==');

@$core.Deprecated('Use logViewDescriptor instead')
const LogView$json = {
  '1': 'LogView',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'create_time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'createTime'
    },
    {
      '1': 'update_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'updateTime'
    },
    {'1': 'filter', '3': 7, '4': 1, '5': 9, '10': 'filter'},
  ],
  '7': {},
};

/// Descriptor for `LogView`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logViewDescriptor = $convert.base64Decode(
    'CgdMb2dWaWV3EhIKBG5hbWUYASABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2'
    'NyaXB0aW9uEkAKC2NyZWF0ZV90aW1lGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cEID4EEDUgpjcmVhdGVUaW1lEkAKC3VwZGF0ZV90aW1lGAUgASgLMhouZ29vZ2xlLnByb3RvYn'
    'VmLlRpbWVzdGFtcEID4EEDUgp1cGRhdGVUaW1lEhYKBmZpbHRlchgHIAEoCVIGZmlsdGVyOtcC'
    '6kHTAgoebG9nZ2luZy5nb29nbGVhcGlzLmNvbS9Mb2dWaWV3EkVwcm9qZWN0cy97cHJvamVjdH'
    '0vbG9jYXRpb25zL3tsb2NhdGlvbn0vYnVja2V0cy97YnVja2V0fS92aWV3cy97dmlld30ST29y'
    'Z2FuaXphdGlvbnMve29yZ2FuaXphdGlvbn0vbG9jYXRpb25zL3tsb2NhdGlvbn0vYnVja2V0cy'
    '97YnVja2V0fS92aWV3cy97dmlld30SQ2ZvbGRlcnMve2ZvbGRlcn0vbG9jYXRpb25zL3tsb2Nh'
    'dGlvbn0vYnVja2V0cy97YnVja2V0fS92aWV3cy97dmlld30SVGJpbGxpbmdBY2NvdW50cy97Ym'
    'lsbGluZ19hY2NvdW50fS9sb2NhdGlvbnMve2xvY2F0aW9ufS9idWNrZXRzL3tidWNrZXR9L3Zp'
    'ZXdzL3t2aWV3fQ==');

@$core.Deprecated('Use logSinkDescriptor instead')
const LogSink$json = {
  '1': 'LogSink',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'destination', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'destination'},
    {'1': 'filter', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'filter'},
    {'1': 'description', '3': 18, '4': 1, '5': 9, '8': {}, '10': 'description'},
    {'1': 'disabled', '3': 19, '4': 1, '5': 8, '8': {}, '10': 'disabled'},
    {
      '1': 'exclusions',
      '3': 16,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogExclusion',
      '8': {},
      '10': 'exclusions'
    },
    {
      '1': 'output_version_format',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.google.logging.v2.LogSink.VersionFormat',
      '8': {'3': true},
      '10': 'outputVersionFormat',
    },
    {
      '1': 'writer_identity',
      '3': 8,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'writerIdentity'
    },
    {
      '1': 'include_children',
      '3': 9,
      '4': 1,
      '5': 8,
      '8': {},
      '10': 'includeChildren'
    },
    {
      '1': 'bigquery_options',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.BigQueryOptions',
      '8': {},
      '9': 0,
      '10': 'bigqueryOptions'
    },
    {
      '1': 'create_time',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'createTime'
    },
    {
      '1': 'update_time',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'updateTime'
    },
  ],
  '4': [LogSink_VersionFormat$json],
  '7': {},
  '8': [
    {'1': 'options'},
  ],
};

@$core.Deprecated('Use logSinkDescriptor instead')
const LogSink_VersionFormat$json = {
  '1': 'VersionFormat',
  '2': [
    {'1': 'VERSION_FORMAT_UNSPECIFIED', '2': 0},
    {'1': 'V2', '2': 1},
    {'1': 'V1', '2': 2},
  ],
};

/// Descriptor for `LogSink`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logSinkDescriptor = $convert.base64Decode(
    'CgdMb2dTaW5rEhcKBG5hbWUYASABKAlCA+BBAlIEbmFtZRIrCgtkZXN0aW5hdGlvbhgDIAEoCU'
    'IJ4EEC+kEDCgEqUgtkZXN0aW5hdGlvbhIbCgZmaWx0ZXIYBSABKAlCA+BBAVIGZmlsdGVyEiUK'
    'C2Rlc2NyaXB0aW9uGBIgASgJQgPgQQFSC2Rlc2NyaXB0aW9uEh8KCGRpc2FibGVkGBMgASgIQg'
    'PgQQFSCGRpc2FibGVkEkQKCmV4Y2x1c2lvbnMYECADKAsyHy5nb29nbGUubG9nZ2luZy52Mi5M'
    'b2dFeGNsdXNpb25CA+BBAVIKZXhjbHVzaW9ucxJgChVvdXRwdXRfdmVyc2lvbl9mb3JtYXQYBi'
    'ABKA4yKC5nb29nbGUubG9nZ2luZy52Mi5Mb2dTaW5rLlZlcnNpb25Gb3JtYXRCAhgBUhNvdXRw'
    'dXRWZXJzaW9uRm9ybWF0EiwKD3dyaXRlcl9pZGVudGl0eRgIIAEoCUID4EEDUg53cml0ZXJJZG'
    'VudGl0eRIuChBpbmNsdWRlX2NoaWxkcmVuGAkgASgIQgPgQQFSD2luY2x1ZGVDaGlsZHJlbhJU'
    'ChBiaWdxdWVyeV9vcHRpb25zGAwgASgLMiIuZ29vZ2xlLmxvZ2dpbmcudjIuQmlnUXVlcnlPcH'
    'Rpb25zQgPgQQFIAFIPYmlncXVlcnlPcHRpb25zEkAKC2NyZWF0ZV90aW1lGA0gASgLMhouZ29v'
    'Z2xlLnByb3RvYnVmLlRpbWVzdGFtcEID4EEDUgpjcmVhdGVUaW1lEkAKC3VwZGF0ZV90aW1lGA'
    '4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcEID4EEDUgp1cGRhdGVUaW1lIj8KDVZl'
    'cnNpb25Gb3JtYXQSHgoaVkVSU0lPTl9GT1JNQVRfVU5TUEVDSUZJRUQQABIGCgJWMhABEgYKAl'
    'YxEAI6vwHqQbsBCh5sb2dnaW5nLmdvb2dsZWFwaXMuY29tL0xvZ1NpbmsSH3Byb2plY3RzL3tw'
    'cm9qZWN0fS9zaW5rcy97c2lua30SKW9yZ2FuaXphdGlvbnMve29yZ2FuaXphdGlvbn0vc2lua3'
    'Mve3Npbmt9Eh1mb2xkZXJzL3tmb2xkZXJ9L3NpbmtzL3tzaW5rfRIuYmlsbGluZ0FjY291bnRz'
    'L3tiaWxsaW5nX2FjY291bnR9L3NpbmtzL3tzaW5rfUIJCgdvcHRpb25z');

@$core.Deprecated('Use bigQueryDatasetDescriptor instead')
const BigQueryDataset$json = {
  '1': 'BigQueryDataset',
  '2': [
    {'1': 'dataset_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'datasetId'},
  ],
};

/// Descriptor for `BigQueryDataset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bigQueryDatasetDescriptor = $convert.base64Decode(
    'Cg9CaWdRdWVyeURhdGFzZXQSIgoKZGF0YXNldF9pZBgBIAEoCUID4EEDUglkYXRhc2V0SWQ=');

@$core.Deprecated('Use linkDescriptor instead')
const Link$json = {
  '1': 'Link',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'create_time',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'createTime'
    },
    {
      '1': 'lifecycle_state',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.logging.v2.LifecycleState',
      '8': {},
      '10': 'lifecycleState'
    },
    {
      '1': 'bigquery_dataset',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.BigQueryDataset',
      '10': 'bigqueryDataset'
    },
  ],
  '7': {},
};

/// Descriptor for `Link`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkDescriptor = $convert.base64Decode(
    'CgRMaW5rEhIKBG5hbWUYASABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaX'
    'B0aW9uEkAKC2NyZWF0ZV90aW1lGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcEID'
    '4EEDUgpjcmVhdGVUaW1lEk8KD2xpZmVjeWNsZV9zdGF0ZRgEIAEoDjIhLmdvb2dsZS5sb2dnaW'
    '5nLnYyLkxpZmVjeWNsZVN0YXRlQgPgQQNSDmxpZmVjeWNsZVN0YXRlEk0KEGJpZ3F1ZXJ5X2Rh'
    'dGFzZXQYBSABKAsyIi5nb29nbGUubG9nZ2luZy52Mi5CaWdRdWVyeURhdGFzZXRSD2JpZ3F1ZX'
    'J5RGF0YXNldDrUAupB0AIKG2xvZ2dpbmcuZ29vZ2xlYXBpcy5jb20vTGluaxJFcHJvamVjdHMv'
    'e3Byb2plY3R9L2xvY2F0aW9ucy97bG9jYXRpb259L2J1Y2tldHMve2J1Y2tldH0vbGlua3Mve2'
    'xpbmt9Ek9vcmdhbml6YXRpb25zL3tvcmdhbml6YXRpb259L2xvY2F0aW9ucy97bG9jYXRpb259'
    'L2J1Y2tldHMve2J1Y2tldH0vbGlua3Mve2xpbmt9EkNmb2xkZXJzL3tmb2xkZXJ9L2xvY2F0aW'
    '9ucy97bG9jYXRpb259L2J1Y2tldHMve2J1Y2tldH0vbGlua3Mve2xpbmt9ElRiaWxsaW5nQWNj'
    'b3VudHMve2JpbGxpbmdfYWNjb3VudH0vbG9jYXRpb25zL3tsb2NhdGlvbn0vYnVja2V0cy97Yn'
    'Vja2V0fS9saW5rcy97bGlua30=');

@$core.Deprecated('Use bigQueryOptionsDescriptor instead')
const BigQueryOptions$json = {
  '1': 'BigQueryOptions',
  '2': [
    {
      '1': 'use_partitioned_tables',
      '3': 1,
      '4': 1,
      '5': 8,
      '8': {},
      '10': 'usePartitionedTables'
    },
    {
      '1': 'uses_timestamp_column_partitioning',
      '3': 3,
      '4': 1,
      '5': 8,
      '8': {},
      '10': 'usesTimestampColumnPartitioning'
    },
  ],
};

/// Descriptor for `BigQueryOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bigQueryOptionsDescriptor = $convert.base64Decode(
    'Cg9CaWdRdWVyeU9wdGlvbnMSOQoWdXNlX3BhcnRpdGlvbmVkX3RhYmxlcxgBIAEoCEID4EEBUh'
    'R1c2VQYXJ0aXRpb25lZFRhYmxlcxJQCiJ1c2VzX3RpbWVzdGFtcF9jb2x1bW5fcGFydGl0aW9u'
    'aW5nGAMgASgIQgPgQQNSH3VzZXNUaW1lc3RhbXBDb2x1bW5QYXJ0aXRpb25pbmc=');

@$core.Deprecated('Use listBucketsRequestDescriptor instead')
const ListBucketsRequest$json = {
  '1': 'ListBucketsRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'page_token', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'pageToken'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '8': {}, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListBucketsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBucketsRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0QnVja2V0c1JlcXVlc3QSQAoGcGFyZW50GAEgASgJQijgQQL6QSISIGxvZ2dpbmcuZ2'
    '9vZ2xlYXBpcy5jb20vTG9nQnVja2V0UgZwYXJlbnQSIgoKcGFnZV90b2tlbhgCIAEoCUID4EEB'
    'UglwYWdlVG9rZW4SIAoJcGFnZV9zaXplGAMgASgFQgPgQQFSCHBhZ2VTaXpl');

@$core.Deprecated('Use listBucketsResponseDescriptor instead')
const ListBucketsResponse$json = {
  '1': 'ListBucketsResponse',
  '2': [
    {
      '1': 'buckets',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogBucket',
      '10': 'buckets'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListBucketsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBucketsResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0QnVja2V0c1Jlc3BvbnNlEjYKB2J1Y2tldHMYASADKAsyHC5nb29nbGUubG9nZ2luZy'
    '52Mi5Mb2dCdWNrZXRSB2J1Y2tldHMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFn'
    'ZVRva2Vu');

@$core.Deprecated('Use createBucketRequestDescriptor instead')
const CreateBucketRequest$json = {
  '1': 'CreateBucketRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'bucket_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'bucketId'},
    {
      '1': 'bucket',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogBucket',
      '8': {},
      '10': 'bucket'
    },
  ],
};

/// Descriptor for `CreateBucketRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBucketRequestDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVCdWNrZXRSZXF1ZXN0EkAKBnBhcmVudBgBIAEoCUIo4EEC+kEiEiBsb2dnaW5nLm'
    'dvb2dsZWFwaXMuY29tL0xvZ0J1Y2tldFIGcGFyZW50EiAKCWJ1Y2tldF9pZBgCIAEoCUID4EEC'
    'UghidWNrZXRJZBI5CgZidWNrZXQYAyABKAsyHC5nb29nbGUubG9nZ2luZy52Mi5Mb2dCdWNrZX'
    'RCA+BBAlIGYnVja2V0');

@$core.Deprecated('Use updateBucketRequestDescriptor instead')
const UpdateBucketRequest$json = {
  '1': 'UpdateBucketRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {
      '1': 'bucket',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogBucket',
      '8': {},
      '10': 'bucket'
    },
    {
      '1': 'update_mask',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '8': {},
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `UpdateBucketRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBucketRequestDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVCdWNrZXRSZXF1ZXN0EjwKBG5hbWUYASABKAlCKOBBAvpBIgogbG9nZ2luZy5nb2'
    '9nbGVhcGlzLmNvbS9Mb2dCdWNrZXRSBG5hbWUSOQoGYnVja2V0GAIgASgLMhwuZ29vZ2xlLmxv'
    'Z2dpbmcudjIuTG9nQnVja2V0QgPgQQJSBmJ1Y2tldBJACgt1cGRhdGVfbWFzaxgEIAEoCzIaLm'
    'dvb2dsZS5wcm90b2J1Zi5GaWVsZE1hc2tCA+BBAlIKdXBkYXRlTWFzaw==');

@$core.Deprecated('Use getBucketRequestDescriptor instead')
const GetBucketRequest$json = {
  '1': 'GetBucketRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetBucketRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBucketRequestDescriptor = $convert.base64Decode(
    'ChBHZXRCdWNrZXRSZXF1ZXN0EjwKBG5hbWUYASABKAlCKOBBAvpBIgogbG9nZ2luZy5nb29nbG'
    'VhcGlzLmNvbS9Mb2dCdWNrZXRSBG5hbWU=');

@$core.Deprecated('Use deleteBucketRequestDescriptor instead')
const DeleteBucketRequest$json = {
  '1': 'DeleteBucketRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `DeleteBucketRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBucketRequestDescriptor = $convert.base64Decode(
    'ChNEZWxldGVCdWNrZXRSZXF1ZXN0EjwKBG5hbWUYASABKAlCKOBBAvpBIgogbG9nZ2luZy5nb2'
    '9nbGVhcGlzLmNvbS9Mb2dCdWNrZXRSBG5hbWU=');

@$core.Deprecated('Use undeleteBucketRequestDescriptor instead')
const UndeleteBucketRequest$json = {
  '1': 'UndeleteBucketRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `UndeleteBucketRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List undeleteBucketRequestDescriptor = $convert.base64Decode(
    'ChVVbmRlbGV0ZUJ1Y2tldFJlcXVlc3QSPAoEbmFtZRgBIAEoCUIo4EEC+kEiCiBsb2dnaW5nLm'
    'dvb2dsZWFwaXMuY29tL0xvZ0J1Y2tldFIEbmFtZQ==');

@$core.Deprecated('Use listViewsRequestDescriptor instead')
const ListViewsRequest$json = {
  '1': 'ListViewsRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'page_token', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'pageToken'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '8': {}, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListViewsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listViewsRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0Vmlld3NSZXF1ZXN0EhsKBnBhcmVudBgBIAEoCUID4EECUgZwYXJlbnQSIgoKcGFnZV'
    '90b2tlbhgCIAEoCUID4EEBUglwYWdlVG9rZW4SIAoJcGFnZV9zaXplGAMgASgFQgPgQQFSCHBh'
    'Z2VTaXpl');

@$core.Deprecated('Use listViewsResponseDescriptor instead')
const ListViewsResponse$json = {
  '1': 'ListViewsResponse',
  '2': [
    {
      '1': 'views',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogView',
      '10': 'views'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListViewsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listViewsResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0Vmlld3NSZXNwb25zZRIwCgV2aWV3cxgBIAMoCzIaLmdvb2dsZS5sb2dnaW5nLnYyLk'
    'xvZ1ZpZXdSBXZpZXdzEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use createViewRequestDescriptor instead')
const CreateViewRequest$json = {
  '1': 'CreateViewRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'view_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'viewId'},
    {
      '1': 'view',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogView',
      '8': {},
      '10': 'view'
    },
  ],
};

/// Descriptor for `CreateViewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createViewRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVWaWV3UmVxdWVzdBIbCgZwYXJlbnQYASABKAlCA+BBAlIGcGFyZW50EhwKB3ZpZX'
    'dfaWQYAiABKAlCA+BBAlIGdmlld0lkEjMKBHZpZXcYAyABKAsyGi5nb29nbGUubG9nZ2luZy52'
    'Mi5Mb2dWaWV3QgPgQQJSBHZpZXc=');

@$core.Deprecated('Use updateViewRequestDescriptor instead')
const UpdateViewRequest$json = {
  '1': 'UpdateViewRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {
      '1': 'view',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogView',
      '8': {},
      '10': 'view'
    },
    {
      '1': 'update_mask',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '8': {},
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `UpdateViewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateViewRequestDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVWaWV3UmVxdWVzdBIXCgRuYW1lGAEgASgJQgPgQQJSBG5hbWUSMwoEdmlldxgCIA'
    'EoCzIaLmdvb2dsZS5sb2dnaW5nLnYyLkxvZ1ZpZXdCA+BBAlIEdmlldxJACgt1cGRhdGVfbWFz'
    'axgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5GaWVsZE1hc2tCA+BBAVIKdXBkYXRlTWFzaw==');

@$core.Deprecated('Use getViewRequestDescriptor instead')
const GetViewRequest$json = {
  '1': 'GetViewRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetViewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getViewRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRWaWV3UmVxdWVzdBI6CgRuYW1lGAEgASgJQibgQQL6QSAKHmxvZ2dpbmcuZ29vZ2xlYX'
    'Bpcy5jb20vTG9nVmlld1IEbmFtZQ==');

@$core.Deprecated('Use deleteViewRequestDescriptor instead')
const DeleteViewRequest$json = {
  '1': 'DeleteViewRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `DeleteViewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteViewRequestDescriptor = $convert.base64Decode(
    'ChFEZWxldGVWaWV3UmVxdWVzdBI6CgRuYW1lGAEgASgJQibgQQL6QSAKHmxvZ2dpbmcuZ29vZ2'
    'xlYXBpcy5jb20vTG9nVmlld1IEbmFtZQ==');

@$core.Deprecated('Use listSinksRequestDescriptor instead')
const ListSinksRequest$json = {
  '1': 'ListSinksRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'page_token', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'pageToken'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '8': {}, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListSinksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSinksRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0U2lua3NSZXF1ZXN0Ej4KBnBhcmVudBgBIAEoCUIm4EEC+kEgEh5sb2dnaW5nLmdvb2'
    'dsZWFwaXMuY29tL0xvZ1NpbmtSBnBhcmVudBIiCgpwYWdlX3Rva2VuGAIgASgJQgPgQQFSCXBh'
    'Z2VUb2tlbhIgCglwYWdlX3NpemUYAyABKAVCA+BBAVIIcGFnZVNpemU=');

@$core.Deprecated('Use listSinksResponseDescriptor instead')
const ListSinksResponse$json = {
  '1': 'ListSinksResponse',
  '2': [
    {
      '1': 'sinks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogSink',
      '10': 'sinks'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListSinksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSinksResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0U2lua3NSZXNwb25zZRIwCgVzaW5rcxgBIAMoCzIaLmdvb2dsZS5sb2dnaW5nLnYyLk'
    'xvZ1NpbmtSBXNpbmtzEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use getSinkRequestDescriptor instead')
const GetSinkRequest$json = {
  '1': 'GetSinkRequest',
  '2': [
    {'1': 'sink_name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'sinkName'},
  ],
};

/// Descriptor for `GetSinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSinkRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRTaW5rUmVxdWVzdBJDCglzaW5rX25hbWUYASABKAlCJuBBAvpBIAoebG9nZ2luZy5nb2'
    '9nbGVhcGlzLmNvbS9Mb2dTaW5rUghzaW5rTmFtZQ==');

@$core.Deprecated('Use createSinkRequestDescriptor instead')
const CreateSinkRequest$json = {
  '1': 'CreateSinkRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {
      '1': 'sink',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogSink',
      '8': {},
      '10': 'sink'
    },
    {
      '1': 'unique_writer_identity',
      '3': 3,
      '4': 1,
      '5': 8,
      '8': {},
      '10': 'uniqueWriterIdentity'
    },
  ],
};

/// Descriptor for `CreateSinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSinkRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVTaW5rUmVxdWVzdBI+CgZwYXJlbnQYASABKAlCJuBBAvpBIBIebG9nZ2luZy5nb2'
    '9nbGVhcGlzLmNvbS9Mb2dTaW5rUgZwYXJlbnQSMwoEc2luaxgCIAEoCzIaLmdvb2dsZS5sb2dn'
    'aW5nLnYyLkxvZ1NpbmtCA+BBAlIEc2luaxI5ChZ1bmlxdWVfd3JpdGVyX2lkZW50aXR5GAMgAS'
    'gIQgPgQQFSFHVuaXF1ZVdyaXRlcklkZW50aXR5');

@$core.Deprecated('Use updateSinkRequestDescriptor instead')
const UpdateSinkRequest$json = {
  '1': 'UpdateSinkRequest',
  '2': [
    {'1': 'sink_name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'sinkName'},
    {
      '1': 'sink',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogSink',
      '8': {},
      '10': 'sink'
    },
    {
      '1': 'unique_writer_identity',
      '3': 3,
      '4': 1,
      '5': 8,
      '8': {},
      '10': 'uniqueWriterIdentity'
    },
    {
      '1': 'update_mask',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '8': {},
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `UpdateSinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSinkRequestDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVTaW5rUmVxdWVzdBJDCglzaW5rX25hbWUYASABKAlCJuBBAvpBIAoebG9nZ2luZy'
    '5nb29nbGVhcGlzLmNvbS9Mb2dTaW5rUghzaW5rTmFtZRIzCgRzaW5rGAIgASgLMhouZ29vZ2xl'
    'LmxvZ2dpbmcudjIuTG9nU2lua0ID4EECUgRzaW5rEjkKFnVuaXF1ZV93cml0ZXJfaWRlbnRpdH'
    'kYAyABKAhCA+BBAVIUdW5pcXVlV3JpdGVySWRlbnRpdHkSQAoLdXBkYXRlX21hc2sYBCABKAsy'
    'Gi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrQgPgQQFSCnVwZGF0ZU1hc2s=');

@$core.Deprecated('Use deleteSinkRequestDescriptor instead')
const DeleteSinkRequest$json = {
  '1': 'DeleteSinkRequest',
  '2': [
    {'1': 'sink_name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'sinkName'},
  ],
};

/// Descriptor for `DeleteSinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteSinkRequestDescriptor = $convert.base64Decode(
    'ChFEZWxldGVTaW5rUmVxdWVzdBJDCglzaW5rX25hbWUYASABKAlCJuBBAvpBIAoebG9nZ2luZy'
    '5nb29nbGVhcGlzLmNvbS9Mb2dTaW5rUghzaW5rTmFtZQ==');

@$core.Deprecated('Use createLinkRequestDescriptor instead')
const CreateLinkRequest$json = {
  '1': 'CreateLinkRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {
      '1': 'link',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.Link',
      '8': {},
      '10': 'link'
    },
    {'1': 'link_id', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'linkId'},
  ],
};

/// Descriptor for `CreateLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLinkRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVMaW5rUmVxdWVzdBI7CgZwYXJlbnQYASABKAlCI+BBAvpBHRIbbG9nZ2luZy5nb2'
    '9nbGVhcGlzLmNvbS9MaW5rUgZwYXJlbnQSMAoEbGluaxgCIAEoCzIXLmdvb2dsZS5sb2dnaW5n'
    'LnYyLkxpbmtCA+BBAlIEbGluaxIcCgdsaW5rX2lkGAMgASgJQgPgQQJSBmxpbmtJZA==');

@$core.Deprecated('Use deleteLinkRequestDescriptor instead')
const DeleteLinkRequest$json = {
  '1': 'DeleteLinkRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `DeleteLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteLinkRequestDescriptor = $convert.base64Decode(
    'ChFEZWxldGVMaW5rUmVxdWVzdBI3CgRuYW1lGAEgASgJQiPgQQL6QR0KG2xvZ2dpbmcuZ29vZ2'
    'xlYXBpcy5jb20vTGlua1IEbmFtZQ==');

@$core.Deprecated('Use listLinksRequestDescriptor instead')
const ListLinksRequest$json = {
  '1': 'ListLinksRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'page_token', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'pageToken'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '8': {}, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListLinksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLinksRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0TGlua3NSZXF1ZXN0EjsKBnBhcmVudBgBIAEoCUIj4EEC+kEdEhtsb2dnaW5nLmdvb2'
    'dsZWFwaXMuY29tL0xpbmtSBnBhcmVudBIiCgpwYWdlX3Rva2VuGAIgASgJQgPgQQFSCXBhZ2VU'
    'b2tlbhIgCglwYWdlX3NpemUYAyABKAVCA+BBAVIIcGFnZVNpemU=');

@$core.Deprecated('Use listLinksResponseDescriptor instead')
const ListLinksResponse$json = {
  '1': 'ListLinksResponse',
  '2': [
    {
      '1': 'links',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.Link',
      '10': 'links'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListLinksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLinksResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0TGlua3NSZXNwb25zZRItCgVsaW5rcxgBIAMoCzIXLmdvb2dsZS5sb2dnaW5nLnYyLk'
    'xpbmtSBWxpbmtzEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use getLinkRequestDescriptor instead')
const GetLinkRequest$json = {
  '1': 'GetLinkRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRMaW5rUmVxdWVzdBI3CgRuYW1lGAEgASgJQiPgQQL6QR0KG2xvZ2dpbmcuZ29vZ2xlYX'
    'Bpcy5jb20vTGlua1IEbmFtZQ==');

@$core.Deprecated('Use logExclusionDescriptor instead')
const LogExclusion$json = {
  '1': 'LogExclusion',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'description'},
    {'1': 'filter', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'filter'},
    {'1': 'disabled', '3': 4, '4': 1, '5': 8, '8': {}, '10': 'disabled'},
    {
      '1': 'create_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'createTime'
    },
    {
      '1': 'update_time',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'updateTime'
    },
  ],
  '7': {},
};

/// Descriptor for `LogExclusion`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logExclusionDescriptor = $convert.base64Decode(
    'CgxMb2dFeGNsdXNpb24SFwoEbmFtZRgBIAEoCUID4EECUgRuYW1lEiUKC2Rlc2NyaXB0aW9uGA'
    'IgASgJQgPgQQFSC2Rlc2NyaXB0aW9uEhsKBmZpbHRlchgDIAEoCUID4EECUgZmaWx0ZXISHwoI'
    'ZGlzYWJsZWQYBCABKAhCA+BBAVIIZGlzYWJsZWQSQAoLY3JlYXRlX3RpbWUYBSABKAsyGi5nb2'
    '9nbGUucHJvdG9idWYuVGltZXN0YW1wQgPgQQNSCmNyZWF0ZVRpbWUSQAoLdXBkYXRlX3RpbWUY'
    'BiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wQgPgQQNSCnVwZGF0ZVRpbWU67AHqQe'
    'gBCiNsb2dnaW5nLmdvb2dsZWFwaXMuY29tL0xvZ0V4Y2x1c2lvbhIpcHJvamVjdHMve3Byb2pl'
    'Y3R9L2V4Y2x1c2lvbnMve2V4Y2x1c2lvbn0SM29yZ2FuaXphdGlvbnMve29yZ2FuaXphdGlvbn'
    '0vZXhjbHVzaW9ucy97ZXhjbHVzaW9ufRInZm9sZGVycy97Zm9sZGVyfS9leGNsdXNpb25zL3tl'
    'eGNsdXNpb259EjhiaWxsaW5nQWNjb3VudHMve2JpbGxpbmdfYWNjb3VudH0vZXhjbHVzaW9ucy'
    '97ZXhjbHVzaW9ufQ==');

@$core.Deprecated('Use listExclusionsRequestDescriptor instead')
const ListExclusionsRequest$json = {
  '1': 'ListExclusionsRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'page_token', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'pageToken'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '8': {}, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListExclusionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listExclusionsRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0RXhjbHVzaW9uc1JlcXVlc3QSQwoGcGFyZW50GAEgASgJQivgQQL6QSUSI2xvZ2dpbm'
    'cuZ29vZ2xlYXBpcy5jb20vTG9nRXhjbHVzaW9uUgZwYXJlbnQSIgoKcGFnZV90b2tlbhgCIAEo'
    'CUID4EEBUglwYWdlVG9rZW4SIAoJcGFnZV9zaXplGAMgASgFQgPgQQFSCHBhZ2VTaXpl');

@$core.Deprecated('Use listExclusionsResponseDescriptor instead')
const ListExclusionsResponse$json = {
  '1': 'ListExclusionsResponse',
  '2': [
    {
      '1': 'exclusions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogExclusion',
      '10': 'exclusions'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListExclusionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listExclusionsResponseDescriptor = $convert.base64Decode(
    'ChZMaXN0RXhjbHVzaW9uc1Jlc3BvbnNlEj8KCmV4Y2x1c2lvbnMYASADKAsyHy5nb29nbGUubG'
    '9nZ2luZy52Mi5Mb2dFeGNsdXNpb25SCmV4Y2x1c2lvbnMSJgoPbmV4dF9wYWdlX3Rva2VuGAIg'
    'ASgJUg1uZXh0UGFnZVRva2Vu');

@$core.Deprecated('Use getExclusionRequestDescriptor instead')
const GetExclusionRequest$json = {
  '1': 'GetExclusionRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetExclusionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExclusionRequestDescriptor = $convert.base64Decode(
    'ChNHZXRFeGNsdXNpb25SZXF1ZXN0Ej8KBG5hbWUYASABKAlCK+BBAvpBJQojbG9nZ2luZy5nb2'
    '9nbGVhcGlzLmNvbS9Mb2dFeGNsdXNpb25SBG5hbWU=');

@$core.Deprecated('Use createExclusionRequestDescriptor instead')
const CreateExclusionRequest$json = {
  '1': 'CreateExclusionRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {
      '1': 'exclusion',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogExclusion',
      '8': {},
      '10': 'exclusion'
    },
  ],
};

/// Descriptor for `CreateExclusionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createExclusionRequestDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVFeGNsdXNpb25SZXF1ZXN0EkMKBnBhcmVudBgBIAEoCUIr4EEC+kElEiNsb2dnaW'
    '5nLmdvb2dsZWFwaXMuY29tL0xvZ0V4Y2x1c2lvblIGcGFyZW50EkIKCWV4Y2x1c2lvbhgCIAEo'
    'CzIfLmdvb2dsZS5sb2dnaW5nLnYyLkxvZ0V4Y2x1c2lvbkID4EECUglleGNsdXNpb24=');

@$core.Deprecated('Use updateExclusionRequestDescriptor instead')
const UpdateExclusionRequest$json = {
  '1': 'UpdateExclusionRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {
      '1': 'exclusion',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogExclusion',
      '8': {},
      '10': 'exclusion'
    },
    {
      '1': 'update_mask',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '8': {},
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `UpdateExclusionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateExclusionRequestDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVFeGNsdXNpb25SZXF1ZXN0Ej8KBG5hbWUYASABKAlCK+BBAvpBJQojbG9nZ2luZy'
    '5nb29nbGVhcGlzLmNvbS9Mb2dFeGNsdXNpb25SBG5hbWUSQgoJZXhjbHVzaW9uGAIgASgLMh8u'
    'Z29vZ2xlLmxvZ2dpbmcudjIuTG9nRXhjbHVzaW9uQgPgQQJSCWV4Y2x1c2lvbhJACgt1cGRhdG'
    'VfbWFzaxgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5GaWVsZE1hc2tCA+BBAlIKdXBkYXRlTWFz'
    'aw==');

@$core.Deprecated('Use deleteExclusionRequestDescriptor instead')
const DeleteExclusionRequest$json = {
  '1': 'DeleteExclusionRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `DeleteExclusionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteExclusionRequestDescriptor =
    $convert.base64Decode(
        'ChZEZWxldGVFeGNsdXNpb25SZXF1ZXN0Ej8KBG5hbWUYASABKAlCK+BBAvpBJQojbG9nZ2luZy'
        '5nb29nbGVhcGlzLmNvbS9Mb2dFeGNsdXNpb25SBG5hbWU=');

@$core.Deprecated('Use getCmekSettingsRequestDescriptor instead')
const GetCmekSettingsRequest$json = {
  '1': 'GetCmekSettingsRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetCmekSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCmekSettingsRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRDbWVrU2V0dGluZ3NSZXF1ZXN0Ej8KBG5hbWUYASABKAlCK+BBAvpBJQojbG9nZ2luZy'
        '5nb29nbGVhcGlzLmNvbS9DbWVrU2V0dGluZ3NSBG5hbWU=');

@$core.Deprecated('Use updateCmekSettingsRequestDescriptor instead')
const UpdateCmekSettingsRequest$json = {
  '1': 'UpdateCmekSettingsRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {
      '1': 'cmek_settings',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.CmekSettings',
      '8': {},
      '10': 'cmekSettings'
    },
    {
      '1': 'update_mask',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '8': {},
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `UpdateCmekSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCmekSettingsRequestDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVDbWVrU2V0dGluZ3NSZXF1ZXN0EhcKBG5hbWUYASABKAlCA+BBAlIEbmFtZRJJCg'
    '1jbWVrX3NldHRpbmdzGAIgASgLMh8uZ29vZ2xlLmxvZ2dpbmcudjIuQ21la1NldHRpbmdzQgPg'
    'QQJSDGNtZWtTZXR0aW5ncxJACgt1cGRhdGVfbWFzaxgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi'
    '5GaWVsZE1hc2tCA+BBAVIKdXBkYXRlTWFzaw==');

@$core.Deprecated('Use cmekSettingsDescriptor instead')
const CmekSettings$json = {
  '1': 'CmekSettings',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'kms_key_name', '3': 2, '4': 1, '5': 9, '10': 'kmsKeyName'},
    {
      '1': 'kms_key_version_name',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'kmsKeyVersionName'
    },
    {
      '1': 'service_account_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'serviceAccountId'
    },
  ],
  '7': {},
};

/// Descriptor for `CmekSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cmekSettingsDescriptor = $convert.base64Decode(
    'CgxDbWVrU2V0dGluZ3MSFwoEbmFtZRgBIAEoCUID4EEDUgRuYW1lEiAKDGttc19rZXlfbmFtZR'
    'gCIAEoCVIKa21zS2V5TmFtZRIvChRrbXNfa2V5X3ZlcnNpb25fbmFtZRgEIAEoCVIRa21zS2V5'
    'VmVyc2lvbk5hbWUSMQoSc2VydmljZV9hY2NvdW50X2lkGAMgASgJQgPgQQNSEHNlcnZpY2VBY2'
    'NvdW50SWQ6xAHqQcABCiNsb2dnaW5nLmdvb2dsZWFwaXMuY29tL0NtZWtTZXR0aW5ncxIfcHJv'
    'amVjdHMve3Byb2plY3R9L2NtZWtTZXR0aW5ncxIpb3JnYW5pemF0aW9ucy97b3JnYW5pemF0aW'
    '9ufS9jbWVrU2V0dGluZ3MSHWZvbGRlcnMve2ZvbGRlcn0vY21la1NldHRpbmdzEi5iaWxsaW5n'
    'QWNjb3VudHMve2JpbGxpbmdfYWNjb3VudH0vY21la1NldHRpbmdz');

@$core.Deprecated('Use getSettingsRequestDescriptor instead')
const GetSettingsRequest$json = {
  '1': 'GetSettingsRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSettingsRequestDescriptor = $convert.base64Decode(
    'ChJHZXRTZXR0aW5nc1JlcXVlc3QSOwoEbmFtZRgBIAEoCUIn4EEC+kEhCh9sb2dnaW5nLmdvb2'
    'dsZWFwaXMuY29tL1NldHRpbmdzUgRuYW1l');

@$core.Deprecated('Use updateSettingsRequestDescriptor instead')
const UpdateSettingsRequest$json = {
  '1': 'UpdateSettingsRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {
      '1': 'settings',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.Settings',
      '8': {},
      '10': 'settings'
    },
    {
      '1': 'update_mask',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '8': {},
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `UpdateSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSettingsRequestDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVTZXR0aW5nc1JlcXVlc3QSFwoEbmFtZRgBIAEoCUID4EECUgRuYW1lEjwKCHNldH'
    'RpbmdzGAIgASgLMhsuZ29vZ2xlLmxvZ2dpbmcudjIuU2V0dGluZ3NCA+BBAlIIc2V0dGluZ3MS'
    'QAoLdXBkYXRlX21hc2sYAyABKAsyGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrQgPgQQFSCn'
    'VwZGF0ZU1hc2s=');

@$core.Deprecated('Use settingsDescriptor instead')
const Settings$json = {
  '1': 'Settings',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'kms_key_name', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'kmsKeyName'},
    {
      '1': 'kms_service_account_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'kmsServiceAccountId'
    },
    {
      '1': 'storage_location',
      '3': 4,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'storageLocation'
    },
    {
      '1': 'disable_default_sink',
      '3': 5,
      '4': 1,
      '5': 8,
      '8': {},
      '10': 'disableDefaultSink'
    },
  ],
  '7': {},
};

/// Descriptor for `Settings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingsDescriptor = $convert.base64Decode(
    'CghTZXR0aW5ncxIXCgRuYW1lGAEgASgJQgPgQQNSBG5hbWUSJQoMa21zX2tleV9uYW1lGAIgAS'
    'gJQgPgQQFSCmttc0tleU5hbWUSOAoWa21zX3NlcnZpY2VfYWNjb3VudF9pZBgDIAEoCUID4EED'
    'UhNrbXNTZXJ2aWNlQWNjb3VudElkEi4KEHN0b3JhZ2VfbG9jYXRpb24YBCABKAlCA+BBAVIPc3'
    'RvcmFnZUxvY2F0aW9uEjUKFGRpc2FibGVfZGVmYXVsdF9zaW5rGAUgASgIQgPgQQFSEmRpc2Fi'
    'bGVEZWZhdWx0U2luazqwAepBrAEKH2xvZ2dpbmcuZ29vZ2xlYXBpcy5jb20vU2V0dGluZ3MSG3'
    'Byb2plY3RzL3twcm9qZWN0fS9zZXR0aW5ncxIlb3JnYW5pemF0aW9ucy97b3JnYW5pemF0aW9u'
    'fS9zZXR0aW5ncxIZZm9sZGVycy97Zm9sZGVyfS9zZXR0aW5ncxIqYmlsbGluZ0FjY291bnRzL3'
    'tiaWxsaW5nX2FjY291bnR9L3NldHRpbmdz');

@$core.Deprecated('Use copyLogEntriesRequestDescriptor instead')
const CopyLogEntriesRequest$json = {
  '1': 'CopyLogEntriesRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'filter', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'filter'},
    {'1': 'destination', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'destination'},
  ],
};

/// Descriptor for `CopyLogEntriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List copyLogEntriesRequestDescriptor = $convert.base64Decode(
    'ChVDb3B5TG9nRW50cmllc1JlcXVlc3QSFwoEbmFtZRgBIAEoCUID4EECUgRuYW1lEhsKBmZpbH'
    'RlchgDIAEoCUID4EEBUgZmaWx0ZXISJQoLZGVzdGluYXRpb24YBCABKAlCA+BBAlILZGVzdGlu'
    'YXRpb24=');

@$core.Deprecated('Use copyLogEntriesMetadataDescriptor instead')
const CopyLogEntriesMetadata$json = {
  '1': 'CopyLogEntriesMetadata',
  '2': [
    {
      '1': 'start_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startTime'
    },
    {
      '1': 'end_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'endTime'
    },
    {
      '1': 'state',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.google.logging.v2.OperationState',
      '10': 'state'
    },
    {
      '1': 'cancellation_requested',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'cancellationRequested'
    },
    {
      '1': 'request',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.CopyLogEntriesRequest',
      '10': 'request'
    },
    {'1': 'progress', '3': 6, '4': 1, '5': 5, '10': 'progress'},
    {'1': 'writer_identity', '3': 7, '4': 1, '5': 9, '10': 'writerIdentity'},
  ],
};

/// Descriptor for `CopyLogEntriesMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List copyLogEntriesMetadataDescriptor = $convert.base64Decode(
    'ChZDb3B5TG9nRW50cmllc01ldGFkYXRhEjkKCnN0YXJ0X3RpbWUYASABKAsyGi5nb29nbGUucH'
    'JvdG9idWYuVGltZXN0YW1wUglzdGFydFRpbWUSNQoIZW5kX3RpbWUYAiABKAsyGi5nb29nbGUu'
    'cHJvdG9idWYuVGltZXN0YW1wUgdlbmRUaW1lEjcKBXN0YXRlGAMgASgOMiEuZ29vZ2xlLmxvZ2'
    'dpbmcudjIuT3BlcmF0aW9uU3RhdGVSBXN0YXRlEjUKFmNhbmNlbGxhdGlvbl9yZXF1ZXN0ZWQY'
    'BCABKAhSFWNhbmNlbGxhdGlvblJlcXVlc3RlZBJCCgdyZXF1ZXN0GAUgASgLMiguZ29vZ2xlLm'
    'xvZ2dpbmcudjIuQ29weUxvZ0VudHJpZXNSZXF1ZXN0UgdyZXF1ZXN0EhoKCHByb2dyZXNzGAYg'
    'ASgFUghwcm9ncmVzcxInCg93cml0ZXJfaWRlbnRpdHkYByABKAlSDndyaXRlcklkZW50aXR5');

@$core.Deprecated('Use copyLogEntriesResponseDescriptor instead')
const CopyLogEntriesResponse$json = {
  '1': 'CopyLogEntriesResponse',
  '2': [
    {
      '1': 'log_entries_copied_count',
      '3': 1,
      '4': 1,
      '5': 3,
      '10': 'logEntriesCopiedCount'
    },
  ],
};

/// Descriptor for `CopyLogEntriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List copyLogEntriesResponseDescriptor =
    $convert.base64Decode(
        'ChZDb3B5TG9nRW50cmllc1Jlc3BvbnNlEjcKGGxvZ19lbnRyaWVzX2NvcGllZF9jb3VudBgBIA'
        'EoA1IVbG9nRW50cmllc0NvcGllZENvdW50');

@$core.Deprecated('Use bucketMetadataDescriptor instead')
const BucketMetadata$json = {
  '1': 'BucketMetadata',
  '2': [
    {
      '1': 'start_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startTime'
    },
    {
      '1': 'end_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'endTime'
    },
    {
      '1': 'state',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.google.logging.v2.OperationState',
      '10': 'state'
    },
    {
      '1': 'create_bucket_request',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.CreateBucketRequest',
      '9': 0,
      '10': 'createBucketRequest'
    },
    {
      '1': 'update_bucket_request',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.UpdateBucketRequest',
      '9': 0,
      '10': 'updateBucketRequest'
    },
  ],
  '8': [
    {'1': 'request'},
  ],
};

/// Descriptor for `BucketMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bucketMetadataDescriptor = $convert.base64Decode(
    'Cg5CdWNrZXRNZXRhZGF0YRI5CgpzdGFydF90aW1lGAEgASgLMhouZ29vZ2xlLnByb3RvYnVmLl'
    'RpbWVzdGFtcFIJc3RhcnRUaW1lEjUKCGVuZF90aW1lGAIgASgLMhouZ29vZ2xlLnByb3RvYnVm'
    'LlRpbWVzdGFtcFIHZW5kVGltZRI3CgVzdGF0ZRgDIAEoDjIhLmdvb2dsZS5sb2dnaW5nLnYyLk'
    '9wZXJhdGlvblN0YXRlUgVzdGF0ZRJcChVjcmVhdGVfYnVja2V0X3JlcXVlc3QYBCABKAsyJi5n'
    'b29nbGUubG9nZ2luZy52Mi5DcmVhdGVCdWNrZXRSZXF1ZXN0SABSE2NyZWF0ZUJ1Y2tldFJlcX'
    'Vlc3QSXAoVdXBkYXRlX2J1Y2tldF9yZXF1ZXN0GAUgASgLMiYuZ29vZ2xlLmxvZ2dpbmcudjIu'
    'VXBkYXRlQnVja2V0UmVxdWVzdEgAUhN1cGRhdGVCdWNrZXRSZXF1ZXN0QgkKB3JlcXVlc3Q=');

@$core.Deprecated('Use linkMetadataDescriptor instead')
const LinkMetadata$json = {
  '1': 'LinkMetadata',
  '2': [
    {
      '1': 'start_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startTime'
    },
    {
      '1': 'end_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'endTime'
    },
    {
      '1': 'state',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.google.logging.v2.OperationState',
      '10': 'state'
    },
    {
      '1': 'create_link_request',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.CreateLinkRequest',
      '9': 0,
      '10': 'createLinkRequest'
    },
    {
      '1': 'delete_link_request',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.DeleteLinkRequest',
      '9': 0,
      '10': 'deleteLinkRequest'
    },
  ],
  '8': [
    {'1': 'request'},
  ],
};

/// Descriptor for `LinkMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkMetadataDescriptor = $convert.base64Decode(
    'CgxMaW5rTWV0YWRhdGESOQoKc3RhcnRfdGltZRgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW'
    '1lc3RhbXBSCXN0YXJ0VGltZRI1CghlbmRfdGltZRgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5U'
    'aW1lc3RhbXBSB2VuZFRpbWUSNwoFc3RhdGUYAyABKA4yIS5nb29nbGUubG9nZ2luZy52Mi5PcG'
    'VyYXRpb25TdGF0ZVIFc3RhdGUSVgoTY3JlYXRlX2xpbmtfcmVxdWVzdBgEIAEoCzIkLmdvb2ds'
    'ZS5sb2dnaW5nLnYyLkNyZWF0ZUxpbmtSZXF1ZXN0SABSEWNyZWF0ZUxpbmtSZXF1ZXN0ElYKE2'
    'RlbGV0ZV9saW5rX3JlcXVlc3QYBSABKAsyJC5nb29nbGUubG9nZ2luZy52Mi5EZWxldGVMaW5r'
    'UmVxdWVzdEgAUhFkZWxldGVMaW5rUmVxdWVzdEIJCgdyZXF1ZXN0');

@$core.Deprecated('Use locationMetadataDescriptor instead')
const LocationMetadata$json = {
  '1': 'LocationMetadata',
  '2': [
    {
      '1': 'log_analytics_enabled',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'logAnalyticsEnabled'
    },
  ],
};

/// Descriptor for `LocationMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List locationMetadataDescriptor = $convert.base64Decode(
    'ChBMb2NhdGlvbk1ldGFkYXRhEjIKFWxvZ19hbmFseXRpY3NfZW5hYmxlZBgBIAEoCFITbG9nQW'
    '5hbHl0aWNzRW5hYmxlZA==');
