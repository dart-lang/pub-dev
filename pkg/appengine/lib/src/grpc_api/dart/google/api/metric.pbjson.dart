//
//  Generated code. Do not modify.
//  source: google/api/metric.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use metricDescriptorDescriptor instead')
const MetricDescriptor$json = {
  '1': 'MetricDescriptor',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'type', '3': 8, '4': 1, '5': 9, '10': 'type'},
    {
      '1': 'labels',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.LabelDescriptor',
      '10': 'labels'
    },
    {
      '1': 'metric_kind',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.google.api.MetricDescriptor.MetricKind',
      '10': 'metricKind'
    },
    {
      '1': 'value_type',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.api.MetricDescriptor.ValueType',
      '10': 'valueType'
    },
    {'1': 'unit', '3': 5, '4': 1, '5': 9, '10': 'unit'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'display_name', '3': 7, '4': 1, '5': 9, '10': 'displayName'},
    {
      '1': 'metadata',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.api.MetricDescriptor.MetricDescriptorMetadata',
      '10': 'metadata'
    },
    {
      '1': 'launch_stage',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.google.api.LaunchStage',
      '10': 'launchStage'
    },
    {
      '1': 'monitored_resource_types',
      '3': 13,
      '4': 3,
      '5': 9,
      '10': 'monitoredResourceTypes'
    },
  ],
  '3': [MetricDescriptor_MetricDescriptorMetadata$json],
  '4': [MetricDescriptor_MetricKind$json, MetricDescriptor_ValueType$json],
};

@$core.Deprecated('Use metricDescriptorDescriptor instead')
const MetricDescriptor_MetricDescriptorMetadata$json = {
  '1': 'MetricDescriptorMetadata',
  '2': [
    {
      '1': 'launch_stage',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.api.LaunchStage',
      '8': {'3': true},
      '10': 'launchStage',
    },
    {
      '1': 'sample_period',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'samplePeriod'
    },
    {
      '1': 'ingest_delay',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'ingestDelay'
    },
  ],
};

@$core.Deprecated('Use metricDescriptorDescriptor instead')
const MetricDescriptor_MetricKind$json = {
  '1': 'MetricKind',
  '2': [
    {'1': 'METRIC_KIND_UNSPECIFIED', '2': 0},
    {'1': 'GAUGE', '2': 1},
    {'1': 'DELTA', '2': 2},
    {'1': 'CUMULATIVE', '2': 3},
  ],
};

@$core.Deprecated('Use metricDescriptorDescriptor instead')
const MetricDescriptor_ValueType$json = {
  '1': 'ValueType',
  '2': [
    {'1': 'VALUE_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'BOOL', '2': 1},
    {'1': 'INT64', '2': 2},
    {'1': 'DOUBLE', '2': 3},
    {'1': 'STRING', '2': 4},
    {'1': 'DISTRIBUTION', '2': 5},
    {'1': 'MONEY', '2': 6},
  ],
};

/// Descriptor for `MetricDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metricDescriptorDescriptor = $convert.base64Decode(
    'ChBNZXRyaWNEZXNjcmlwdG9yEhIKBG5hbWUYASABKAlSBG5hbWUSEgoEdHlwZRgIIAEoCVIEdH'
    'lwZRIzCgZsYWJlbHMYAiADKAsyGy5nb29nbGUuYXBpLkxhYmVsRGVzY3JpcHRvclIGbGFiZWxz'
    'EkgKC21ldHJpY19raW5kGAMgASgOMicuZ29vZ2xlLmFwaS5NZXRyaWNEZXNjcmlwdG9yLk1ldH'
    'JpY0tpbmRSCm1ldHJpY0tpbmQSRQoKdmFsdWVfdHlwZRgEIAEoDjImLmdvb2dsZS5hcGkuTWV0'
    'cmljRGVzY3JpcHRvci5WYWx1ZVR5cGVSCXZhbHVlVHlwZRISCgR1bml0GAUgASgJUgR1bml0Ei'
    'AKC2Rlc2NyaXB0aW9uGAYgASgJUgtkZXNjcmlwdGlvbhIhCgxkaXNwbGF5X25hbWUYByABKAlS'
    'C2Rpc3BsYXlOYW1lElEKCG1ldGFkYXRhGAogASgLMjUuZ29vZ2xlLmFwaS5NZXRyaWNEZXNjcm'
    'lwdG9yLk1ldHJpY0Rlc2NyaXB0b3JNZXRhZGF0YVIIbWV0YWRhdGESOgoMbGF1bmNoX3N0YWdl'
    'GAwgASgOMhcuZ29vZ2xlLmFwaS5MYXVuY2hTdGFnZVILbGF1bmNoU3RhZ2USOAoYbW9uaXRvcm'
    'VkX3Jlc291cmNlX3R5cGVzGA0gAygJUhZtb25pdG9yZWRSZXNvdXJjZVR5cGVzGtgBChhNZXRy'
    'aWNEZXNjcmlwdG9yTWV0YWRhdGESPgoMbGF1bmNoX3N0YWdlGAEgASgOMhcuZ29vZ2xlLmFwaS'
    '5MYXVuY2hTdGFnZUICGAFSC2xhdW5jaFN0YWdlEj4KDXNhbXBsZV9wZXJpb2QYAiABKAsyGS5n'
    'b29nbGUucHJvdG9idWYuRHVyYXRpb25SDHNhbXBsZVBlcmlvZBI8Cgxpbmdlc3RfZGVsYXkYAy'
    'ABKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25SC2luZ2VzdERlbGF5Ik8KCk1ldHJpY0tp'
    'bmQSGwoXTUVUUklDX0tJTkRfVU5TUEVDSUZJRUQQABIJCgVHQVVHRRABEgkKBURFTFRBEAISDg'
    'oKQ1VNVUxBVElWRRADInEKCVZhbHVlVHlwZRIaChZWQUxVRV9UWVBFX1VOU1BFQ0lGSUVEEAAS'
    'CAoEQk9PTBABEgkKBUlOVDY0EAISCgoGRE9VQkxFEAMSCgoGU1RSSU5HEAQSEAoMRElTVFJJQl'
    'VUSU9OEAUSCQoFTU9ORVkQBg==');

@$core.Deprecated('Use metricDescriptor instead')
const Metric$json = {
  '1': 'Metric',
  '2': [
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    {
      '1': 'labels',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.Metric.LabelsEntry',
      '10': 'labels'
    },
  ],
  '3': [Metric_LabelsEntry$json],
};

@$core.Deprecated('Use metricDescriptor instead')
const Metric_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Metric`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metricDescriptor = $convert.base64Decode(
    'CgZNZXRyaWMSEgoEdHlwZRgDIAEoCVIEdHlwZRI2CgZsYWJlbHMYAiADKAsyHi5nb29nbGUuYX'
    'BpLk1ldHJpYy5MYWJlbHNFbnRyeVIGbGFiZWxzGjkKC0xhYmVsc0VudHJ5EhAKA2tleRgBIAEo'
    'CVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
