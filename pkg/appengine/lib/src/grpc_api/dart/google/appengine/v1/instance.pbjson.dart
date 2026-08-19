//
//  Generated code. Do not modify.
//  source: google/appengine/v1/instance.proto
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
      '6': '.google.appengine.v1.Instance.Availability',
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
      '6': '.google.appengine.v1.Instance.Liveness.LivenessState',
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
    'QSMQoSYXBwX2VuZ2luZV9yZWxlYXNlGAMgASgJQgPgQQNSEGFwcEVuZ2luZVJlbGVhc2USUwoM'
    'YXZhaWxhYmlsaXR5GAQgASgOMiouZ29vZ2xlLmFwcGVuZ2luZS52MS5JbnN0YW5jZS5BdmFpbG'
    'FiaWxpdHlCA+BBA1IMYXZhaWxhYmlsaXR5EhwKB3ZtX25hbWUYBSABKAlCA+BBA1IGdm1OYW1l'
    'EiUKDHZtX3pvbmVfbmFtZRgGIAEoCUID4EEDUgp2bVpvbmVOYW1lEhgKBXZtX2lkGAcgASgJQg'
    'PgQQNSBHZtSWQSPgoKc3RhcnRfdGltZRgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3Rh'
    'bXBCA+BBA1IJc3RhcnRUaW1lEh8KCHJlcXVlc3RzGAkgASgFQgPgQQNSCHJlcXVlc3RzEhsKBm'
    'Vycm9ycxgKIAEoBUID4EEDUgZlcnJvcnMSFQoDcXBzGAsgASgCQgPgQQNSA3FwcxIsCg9hdmVy'
    'YWdlX2xhdGVuY3kYDCABKAVCA+BBA1IOYXZlcmFnZUxhdGVuY3kSJgoMbWVtb3J5X3VzYWdlGA'
    '0gASgDQgPgQQNSC21lbW9yeVVzYWdlEiAKCXZtX3N0YXR1cxgOIAEoCUID4EEDUgh2bVN0YXR1'
    'cxItChB2bV9kZWJ1Z19lbmFibGVkGA8gASgIQgPgQQNSDnZtRGVidWdFbmFibGVkEhgKBXZtX2'
    'lwGBAgASgJQgPgQQNSBHZtSXASWgoLdm1fbGl2ZW5lc3MYESABKA4yNC5nb29nbGUuYXBwZW5n'
    'aW5lLnYxLkluc3RhbmNlLkxpdmVuZXNzLkxpdmVuZXNzU3RhdGVCA+BBA1IKdm1MaXZlbmVzcx'
    'p/CghMaXZlbmVzcyJzCg1MaXZlbmVzc1N0YXRlEh4KGkxJVkVORVNTX1NUQVRFX1VOU1BFQ0lG'
    'SUVEEAASCwoHVU5LTk9XThABEgsKB0hFQUxUSFkQAhINCglVTkhFQUxUSFkQAxIMCghEUkFJTk'
    'lORxAEEgsKB1RJTUVPVVQQBSI6CgxBdmFpbGFiaWxpdHkSDwoLVU5TUEVDSUZJRUQQABIMCghS'
    'RVNJREVOVBABEgsKB0RZTkFNSUMQAjpt6kFqCiFhcHBlbmdpbmUuZ29vZ2xlYXBpcy5jb20vSW'
    '5zdGFuY2USRWFwcHMve2FwcH0vc2VydmljZXMve3NlcnZpY2V9L3ZlcnNpb25zL3t2ZXJzaW9u'
    'fS9pbnN0YW5jZXMve2luc3RhbmNlfQ==');
