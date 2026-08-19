//
//  Generated code. Do not modify.
//  source: google/datastore/admin/v1/migration.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use migrationStateDescriptor instead')
const MigrationState$json = {
  '1': 'MigrationState',
  '2': [
    {'1': 'MIGRATION_STATE_UNSPECIFIED', '2': 0},
    {'1': 'RUNNING', '2': 1},
    {'1': 'PAUSED', '2': 2},
    {'1': 'COMPLETE', '2': 3},
  ],
};

/// Descriptor for `MigrationState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List migrationStateDescriptor = $convert.base64Decode(
    'Cg5NaWdyYXRpb25TdGF0ZRIfChtNSUdSQVRJT05fU1RBVEVfVU5TUEVDSUZJRUQQABILCgdSVU'
    '5OSU5HEAESCgoGUEFVU0VEEAISDAoIQ09NUExFVEUQAw==');

@$core.Deprecated('Use migrationStepDescriptor instead')
const MigrationStep$json = {
  '1': 'MigrationStep',
  '2': [
    {'1': 'MIGRATION_STEP_UNSPECIFIED', '2': 0},
    {'1': 'PREPARE', '2': 6},
    {'1': 'START', '2': 1},
    {'1': 'APPLY_WRITES_SYNCHRONOUSLY', '2': 7},
    {'1': 'COPY_AND_VERIFY', '2': 2},
    {'1': 'REDIRECT_EVENTUALLY_CONSISTENT_READS', '2': 3},
    {'1': 'REDIRECT_STRONGLY_CONSISTENT_READS', '2': 4},
    {'1': 'REDIRECT_WRITES', '2': 5},
  ],
};

/// Descriptor for `MigrationStep`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List migrationStepDescriptor = $convert.base64Decode(
    'Cg1NaWdyYXRpb25TdGVwEh4KGk1JR1JBVElPTl9TVEVQX1VOU1BFQ0lGSUVEEAASCwoHUFJFUE'
    'FSRRAGEgkKBVNUQVJUEAESHgoaQVBQTFlfV1JJVEVTX1NZTkNIUk9OT1VTTFkQBxITCg9DT1BZ'
    'X0FORF9WRVJJRlkQAhIoCiRSRURJUkVDVF9FVkVOVFVBTExZX0NPTlNJU1RFTlRfUkVBRFMQAx'
    'ImCiJSRURJUkVDVF9TVFJPTkdMWV9DT05TSVNURU5UX1JFQURTEAQSEwoPUkVESVJFQ1RfV1JJ'
    'VEVTEAU=');

@$core.Deprecated('Use migrationStateEventDescriptor instead')
const MigrationStateEvent$json = {
  '1': 'MigrationStateEvent',
  '2': [
    {
      '1': 'state',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.admin.v1.MigrationState',
      '10': 'state'
    },
  ],
};

/// Descriptor for `MigrationStateEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List migrationStateEventDescriptor = $convert.base64Decode(
    'ChNNaWdyYXRpb25TdGF0ZUV2ZW50Ej8KBXN0YXRlGAEgASgOMikuZ29vZ2xlLmRhdGFzdG9yZS'
    '5hZG1pbi52MS5NaWdyYXRpb25TdGF0ZVIFc3RhdGU=');

@$core.Deprecated('Use migrationProgressEventDescriptor instead')
const MigrationProgressEvent$json = {
  '1': 'MigrationProgressEvent',
  '2': [
    {
      '1': 'step',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.admin.v1.MigrationStep',
      '10': 'step'
    },
    {
      '1': 'prepare_step_details',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.google.datastore.admin.v1.MigrationProgressEvent.PrepareStepDetails',
      '9': 0,
      '10': 'prepareStepDetails'
    },
    {
      '1': 'redirect_writes_step_details',
      '3': 3,
      '4': 1,
      '5': 11,
      '6':
          '.google.datastore.admin.v1.MigrationProgressEvent.RedirectWritesStepDetails',
      '9': 0,
      '10': 'redirectWritesStepDetails'
    },
  ],
  '3': [
    MigrationProgressEvent_PrepareStepDetails$json,
    MigrationProgressEvent_RedirectWritesStepDetails$json
  ],
  '4': [MigrationProgressEvent_ConcurrencyMode$json],
  '8': [
    {'1': 'step_details'},
  ],
};

@$core.Deprecated('Use migrationProgressEventDescriptor instead')
const MigrationProgressEvent_PrepareStepDetails$json = {
  '1': 'PrepareStepDetails',
  '2': [
    {
      '1': 'concurrency_mode',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.admin.v1.MigrationProgressEvent.ConcurrencyMode',
      '10': 'concurrencyMode'
    },
  ],
};

@$core.Deprecated('Use migrationProgressEventDescriptor instead')
const MigrationProgressEvent_RedirectWritesStepDetails$json = {
  '1': 'RedirectWritesStepDetails',
  '2': [
    {
      '1': 'concurrency_mode',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.admin.v1.MigrationProgressEvent.ConcurrencyMode',
      '10': 'concurrencyMode'
    },
  ],
};

@$core.Deprecated('Use migrationProgressEventDescriptor instead')
const MigrationProgressEvent_ConcurrencyMode$json = {
  '1': 'ConcurrencyMode',
  '2': [
    {'1': 'CONCURRENCY_MODE_UNSPECIFIED', '2': 0},
    {'1': 'PESSIMISTIC', '2': 1},
    {'1': 'OPTIMISTIC', '2': 2},
    {'1': 'OPTIMISTIC_WITH_ENTITY_GROUPS', '2': 3},
  ],
};

/// Descriptor for `MigrationProgressEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List migrationProgressEventDescriptor = $convert.base64Decode(
    'ChZNaWdyYXRpb25Qcm9ncmVzc0V2ZW50EjwKBHN0ZXAYASABKA4yKC5nb29nbGUuZGF0YXN0b3'
    'JlLmFkbWluLnYxLk1pZ3JhdGlvblN0ZXBSBHN0ZXASeAoUcHJlcGFyZV9zdGVwX2RldGFpbHMY'
    'AiABKAsyRC5nb29nbGUuZGF0YXN0b3JlLmFkbWluLnYxLk1pZ3JhdGlvblByb2dyZXNzRXZlbn'
    'QuUHJlcGFyZVN0ZXBEZXRhaWxzSABSEnByZXBhcmVTdGVwRGV0YWlscxKOAQoccmVkaXJlY3Rf'
    'd3JpdGVzX3N0ZXBfZGV0YWlscxgDIAEoCzJLLmdvb2dsZS5kYXRhc3RvcmUuYWRtaW4udjEuTW'
    'lncmF0aW9uUHJvZ3Jlc3NFdmVudC5SZWRpcmVjdFdyaXRlc1N0ZXBEZXRhaWxzSABSGXJlZGly'
    'ZWN0V3JpdGVzU3RlcERldGFpbHMaggEKElByZXBhcmVTdGVwRGV0YWlscxJsChBjb25jdXJyZW'
    '5jeV9tb2RlGAEgASgOMkEuZ29vZ2xlLmRhdGFzdG9yZS5hZG1pbi52MS5NaWdyYXRpb25Qcm9n'
    'cmVzc0V2ZW50LkNvbmN1cnJlbmN5TW9kZVIPY29uY3VycmVuY3lNb2RlGokBChlSZWRpcmVjdF'
    'dyaXRlc1N0ZXBEZXRhaWxzEmwKEGNvbmN1cnJlbmN5X21vZGUYASABKA4yQS5nb29nbGUuZGF0'
    'YXN0b3JlLmFkbWluLnYxLk1pZ3JhdGlvblByb2dyZXNzRXZlbnQuQ29uY3VycmVuY3lNb2RlUg'
    '9jb25jdXJyZW5jeU1vZGUidwoPQ29uY3VycmVuY3lNb2RlEiAKHENPTkNVUlJFTkNZX01PREVf'
    'VU5TUEVDSUZJRUQQABIPCgtQRVNTSU1JU1RJQxABEg4KCk9QVElNSVNUSUMQAhIhCh1PUFRJTU'
    'lTVElDX1dJVEhfRU5USVRZX0dST1VQUxADQg4KDHN0ZXBfZGV0YWlscw==');
