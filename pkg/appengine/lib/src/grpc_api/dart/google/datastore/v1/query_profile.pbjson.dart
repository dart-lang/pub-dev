//
//  Generated code. Do not modify.
//  source: google/datastore/v1/query_profile.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use explainOptionsDescriptor instead')
const ExplainOptions$json = {
  '1': 'ExplainOptions',
  '2': [
    {'1': 'analyze', '3': 1, '4': 1, '5': 8, '8': {}, '10': 'analyze'},
  ],
};

/// Descriptor for `ExplainOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List explainOptionsDescriptor = $convert.base64Decode(
    'Cg5FeHBsYWluT3B0aW9ucxIdCgdhbmFseXplGAEgASgIQgPgQQFSB2FuYWx5emU=');

@$core.Deprecated('Use explainMetricsDescriptor instead')
const ExplainMetrics$json = {
  '1': 'ExplainMetrics',
  '2': [
    {
      '1': 'plan_summary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PlanSummary',
      '10': 'planSummary'
    },
    {
      '1': 'execution_stats',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.ExecutionStats',
      '10': 'executionStats'
    },
  ],
};

/// Descriptor for `ExplainMetrics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List explainMetricsDescriptor = $convert.base64Decode(
    'Cg5FeHBsYWluTWV0cmljcxJDCgxwbGFuX3N1bW1hcnkYASABKAsyIC5nb29nbGUuZGF0YXN0b3'
    'JlLnYxLlBsYW5TdW1tYXJ5UgtwbGFuU3VtbWFyeRJMCg9leGVjdXRpb25fc3RhdHMYAiABKAsy'
    'Iy5nb29nbGUuZGF0YXN0b3JlLnYxLkV4ZWN1dGlvblN0YXRzUg5leGVjdXRpb25TdGF0cw==');

@$core.Deprecated('Use planSummaryDescriptor instead')
const PlanSummary$json = {
  '1': 'PlanSummary',
  '2': [
    {
      '1': 'indexes_used',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'indexesUsed'
    },
  ],
};

/// Descriptor for `PlanSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planSummaryDescriptor = $convert.base64Decode(
    'CgtQbGFuU3VtbWFyeRI6CgxpbmRleGVzX3VzZWQYASADKAsyFy5nb29nbGUucHJvdG9idWYuU3'
    'RydWN0UgtpbmRleGVzVXNlZA==');

@$core.Deprecated('Use executionStatsDescriptor instead')
const ExecutionStats$json = {
  '1': 'ExecutionStats',
  '2': [
    {'1': 'results_returned', '3': 1, '4': 1, '5': 3, '10': 'resultsReturned'},
    {
      '1': 'execution_duration',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'executionDuration'
    },
    {'1': 'read_operations', '3': 4, '4': 1, '5': 3, '10': 'readOperations'},
    {
      '1': 'debug_stats',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'debugStats'
    },
  ],
};

/// Descriptor for `ExecutionStats`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executionStatsDescriptor = $convert.base64Decode(
    'Cg5FeGVjdXRpb25TdGF0cxIpChByZXN1bHRzX3JldHVybmVkGAEgASgDUg9yZXN1bHRzUmV0dX'
    'JuZWQSSAoSZXhlY3V0aW9uX2R1cmF0aW9uGAMgASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0'
    'aW9uUhFleGVjdXRpb25EdXJhdGlvbhInCg9yZWFkX29wZXJhdGlvbnMYBCABKANSDnJlYWRPcG'
    'VyYXRpb25zEjgKC2RlYnVnX3N0YXRzGAUgASgLMhcuZ29vZ2xlLnByb3RvYnVmLlN0cnVjdFIK'
    'ZGVidWdTdGF0cw==');
