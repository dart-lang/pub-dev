//
//  Generated code. Do not modify.
//  source: google/appengine/v1/service.proto
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
      '6': '.google.appengine.v1.TrafficSplit',
      '10': 'split'
    },
    {
      '1': 'labels',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.Service.LabelsEntry',
      '10': 'labels'
    },
    {
      '1': 'network_settings',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.NetworkSettings',
      '10': 'networkSettings'
    },
  ],
  '3': [Service_LabelsEntry$json],
};

@$core.Deprecated('Use serviceDescriptor instead')
const Service_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Service`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceDescriptor = $convert.base64Decode(
    'CgdTZXJ2aWNlEhIKBG5hbWUYASABKAlSBG5hbWUSDgoCaWQYAiABKAlSAmlkEjcKBXNwbGl0GA'
    'MgASgLMiEuZ29vZ2xlLmFwcGVuZ2luZS52MS5UcmFmZmljU3BsaXRSBXNwbGl0EkAKBmxhYmVs'
    'cxgEIAMoCzIoLmdvb2dsZS5hcHBlbmdpbmUudjEuU2VydmljZS5MYWJlbHNFbnRyeVIGbGFiZW'
    'xzEk8KEG5ldHdvcmtfc2V0dGluZ3MYBiABKAsyJC5nb29nbGUuYXBwZW5naW5lLnYxLk5ldHdv'
    'cmtTZXR0aW5nc1IPbmV0d29ya1NldHRpbmdzGjkKC0xhYmVsc0VudHJ5EhAKA2tleRgBIAEoCV'
    'IDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use trafficSplitDescriptor instead')
const TrafficSplit$json = {
  '1': 'TrafficSplit',
  '2': [
    {
      '1': 'shard_by',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1.TrafficSplit.ShardBy',
      '10': 'shardBy'
    },
    {
      '1': 'allocations',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.TrafficSplit.AllocationsEntry',
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
    'CgxUcmFmZmljU3BsaXQSRAoIc2hhcmRfYnkYASABKA4yKS5nb29nbGUuYXBwZW5naW5lLnYxLl'
    'RyYWZmaWNTcGxpdC5TaGFyZEJ5UgdzaGFyZEJ5ElQKC2FsbG9jYXRpb25zGAIgAygLMjIuZ29v'
    'Z2xlLmFwcGVuZ2luZS52MS5UcmFmZmljU3BsaXQuQWxsb2NhdGlvbnNFbnRyeVILYWxsb2NhdG'
    'lvbnMaPgoQQWxsb2NhdGlvbnNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEo'
    'AVIFdmFsdWU6AjgBIjoKB1NoYXJkQnkSDwoLVU5TUEVDSUZJRUQQABIKCgZDT09LSUUQARIGCg'
    'JJUBACEgoKBlJBTkRPTRAD');
