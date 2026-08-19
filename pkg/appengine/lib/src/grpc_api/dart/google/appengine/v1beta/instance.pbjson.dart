//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/instance.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use instanceDescriptor instead')
const Instance$json = {
  '1': 'Instance',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {
      '1': 'app_engine_release',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'appEngineRelease'
    },
    {
      '1': 'availability',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.Instance.Availability',
      '8': {},
      '10': 'availability'
    },
    {'1': 'vm_name', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'vmName'},
    {'1': 'vm_zone_name', '3': 6, '4': 1, '5': 9, '8': {}, '10': 'vmZoneName'},
    {'1': 'vm_id', '3': 7, '4': 1, '5': 9, '8': {}, '10': 'vmId'},
    {
      '1': 'start_time',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'startTime'
    },
    {'1': 'requests', '3': 9, '4': 1, '5': 5, '8': {}, '10': 'requests'},
    {'1': 'errors', '3': 10, '4': 1, '5': 5, '8': {}, '10': 'errors'},
    {'1': 'qps', '3': 11, '4': 1, '5': 2, '8': {}, '10': 'qps'},
    {
      '1': 'average_latency',
      '3': 12,
      '4': 1,
      '5': 5,
      '8': {},
      '10': 'averageLatency'
    },
    {
      '1': 'memory_usage',
      '3': 13,
      '4': 1,
      '5': 3,
      '8': {},
      '10': 'memoryUsage'
    },
    {'1': 'vm_status', '3': 14, '4': 1, '5': 9, '8': {}, '10': 'vmStatus'},
    {
      '1': 'vm_debug_enabled',
      '3': 15,
      '4': 1,
      '5': 8,
      '8': {},
      '10': 'vmDebugEnabled'
    },
    {'1': 'vm_ip', '3': 16, '4': 1, '5': 9, '8': {}, '10': 'vmIp'},
    {
      '1': 'vm_liveness',
      '3': 17,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.Instance.Liveness.LivenessState',
      '8': {},
      '10': 'vmLiveness'
    },
  ],
  '3': [Instance_Liveness$json],
  '4': [Instance_Availability$json],
  '7': {},
};

@$core.Deprecated('Use instanceDescriptor instead')
const Instance_Liveness$json = {
  '1': 'Liveness',
  '4': [Instance_Liveness_LivenessState$json],
};

@$core.Deprecated('Use instanceDescriptor instead')
const Instance_Liveness_LivenessState$json = {
  '1': 'LivenessState',
  '2': [
    {'1': 'LIVENESS_STATE_UNSPECIFIED', '2': 0},
    {'1': 'UNKNOWN', '2': 1},
    {'1': 'HEALTHY', '2': 2},
    {'1': 'UNHEALTHY', '2': 3},
    {'1': 'DRAINING', '2': 4},
    {'1': 'TIMEOUT', '2': 5},
  ],
};

@$core.Deprecated('Use instanceDescriptor instead')
const Instance_Availability$json = {
  '1': 'Availability',
  '2': [
    {'1': 'UNSPECIFIED', '2': 0},
    {'1': 'RESIDENT', '2': 1},
    {'1': 'DYNAMIC', '2': 2},
  ],
};

/// Descriptor for `Instance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instanceDescriptor = $convert.base64Decode(
    'CghJbnN0YW5jZRIXCgRuYW1lGAEgASgJQgPgQQNSBG5hbWUSEwoCaWQYAiABKAlCA+BBA1ICaW'
    'QSMQoSYXBwX2VuZ2luZV9yZWxlYXNlGAMgASgJQgPgQQNSEGFwcEVuZ2luZVJlbGVhc2USVwoM'
    'YXZhaWxhYmlsaXR5GAQgASgOMi4uZ29vZ2xlLmFwcGVuZ2luZS52MWJldGEuSW5zdGFuY2UuQX'
    'ZhaWxhYmlsaXR5QgPgQQNSDGF2YWlsYWJpbGl0eRIcCgd2bV9uYW1lGAUgASgJQgPgQQNSBnZt'
    'TmFtZRIlCgx2bV96b25lX25hbWUYBiABKAlCA+BBA1IKdm1ab25lTmFtZRIYCgV2bV9pZBgHIA'
    'EoCUID4EEDUgR2bUlkEj4KCnN0YXJ0X3RpbWUYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGlt'
    'ZXN0YW1wQgPgQQNSCXN0YXJ0VGltZRIfCghyZXF1ZXN0cxgJIAEoBUID4EEDUghyZXF1ZXN0cx'
    'IbCgZlcnJvcnMYCiABKAVCA+BBA1IGZXJyb3JzEhUKA3FwcxgLIAEoAkID4EEDUgNxcHMSLAoP'
    'YXZlcmFnZV9sYXRlbmN5GAwgASgFQgPgQQNSDmF2ZXJhZ2VMYXRlbmN5EiYKDG1lbW9yeV91c2'
    'FnZRgNIAEoA0ID4EEDUgttZW1vcnlVc2FnZRIgCgl2bV9zdGF0dXMYDiABKAlCA+BBA1IIdm1T'
    'dGF0dXMSLQoQdm1fZGVidWdfZW5hYmxlZBgPIAEoCEID4EEDUg52bURlYnVnRW5hYmxlZBIYCg'
    'V2bV9pcBgQIAEoCUID4EEDUgR2bUlwEl4KC3ZtX2xpdmVuZXNzGBEgASgOMjguZ29vZ2xlLmFw'
    'cGVuZ2luZS52MWJldGEuSW5zdGFuY2UuTGl2ZW5lc3MuTGl2ZW5lc3NTdGF0ZUID4EEDUgp2bU'
    'xpdmVuZXNzGn8KCExpdmVuZXNzInMKDUxpdmVuZXNzU3RhdGUSHgoaTElWRU5FU1NfU1RBVEVf'
    'VU5TUEVDSUZJRUQQABILCgdVTktOT1dOEAESCwoHSEVBTFRIWRACEg0KCVVOSEVBTFRIWRADEg'
    'wKCERSQUlOSU5HEAQSCwoHVElNRU9VVBAFIjoKDEF2YWlsYWJpbGl0eRIPCgtVTlNQRUNJRklF'
    'RBAAEgwKCFJFU0lERU5UEAESCwoHRFlOQU1JQxACOm3qQWoKIWFwcGVuZ2luZS5nb29nbGVhcG'
    'lzLmNvbS9JbnN0YW5jZRJFYXBwcy97YXBwfS9zZXJ2aWNlcy97c2VydmljZX0vdmVyc2lvbnMv'
    'e3ZlcnNpb259L2luc3RhbmNlcy97aW5zdGFuY2V9');
