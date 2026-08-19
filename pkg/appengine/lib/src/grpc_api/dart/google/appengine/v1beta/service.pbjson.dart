//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use serviceDescriptor instead')
const Service$json = {
  '1': 'Service',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'split',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.TrafficSplit',
      '10': 'split'
    },
    {
      '1': 'network_settings',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.NetworkSettings',
      '10': 'networkSettings'
    },
  ],
};

/// Descriptor for `Service`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceDescriptor = $convert.base64Decode(
    'CgdTZXJ2aWNlEhIKBG5hbWUYASABKAlSBG5hbWUSDgoCaWQYAiABKAlSAmlkEjsKBXNwbGl0GA'
    'MgASgLMiUuZ29vZ2xlLmFwcGVuZ2luZS52MWJldGEuVHJhZmZpY1NwbGl0UgVzcGxpdBJTChBu'
    'ZXR3b3JrX3NldHRpbmdzGAYgASgLMiguZ29vZ2xlLmFwcGVuZ2luZS52MWJldGEuTmV0d29ya1'
    'NldHRpbmdzUg9uZXR3b3JrU2V0dGluZ3M=');

@$core.Deprecated('Use trafficSplitDescriptor instead')
const TrafficSplit$json = {
  '1': 'TrafficSplit',
  '2': [
    {
      '1': 'shard_by',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.TrafficSplit.ShardBy',
      '10': 'shardBy'
    },
    {
      '1': 'allocations',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1beta.TrafficSplit.AllocationsEntry',
      '10': 'allocations'
    },
  ],
  '3': [TrafficSplit_AllocationsEntry$json],
  '4': [TrafficSplit_ShardBy$json],
};

@$core.Deprecated('Use trafficSplitDescriptor instead')
const TrafficSplit_AllocationsEntry$json = {
  '1': 'AllocationsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use trafficSplitDescriptor instead')
const TrafficSplit_ShardBy$json = {
  '1': 'ShardBy',
  '2': [
    {'1': 'UNSPECIFIED', '2': 0},
    {'1': 'COOKIE', '2': 1},
    {'1': 'IP', '2': 2},
    {'1': 'RANDOM', '2': 3},
  ],
};

/// Descriptor for `TrafficSplit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trafficSplitDescriptor = $convert.base64Decode(
    'CgxUcmFmZmljU3BsaXQSSAoIc2hhcmRfYnkYASABKA4yLS5nb29nbGUuYXBwZW5naW5lLnYxYm'
    'V0YS5UcmFmZmljU3BsaXQuU2hhcmRCeVIHc2hhcmRCeRJYCgthbGxvY2F0aW9ucxgCIAMoCzI2'
    'Lmdvb2dsZS5hcHBlbmdpbmUudjFiZXRhLlRyYWZmaWNTcGxpdC5BbGxvY2F0aW9uc0VudHJ5Ug'
    'thbGxvY2F0aW9ucxo+ChBBbGxvY2F0aW9uc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZh'
    'bHVlGAIgASgBUgV2YWx1ZToCOAEiOgoHU2hhcmRCeRIPCgtVTlNQRUNJRklFRBAAEgoKBkNPT0'
    'tJRRABEgYKAklQEAISCgoGUkFORE9NEAM=');
