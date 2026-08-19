//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/operation.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use operationDescriptor instead')
const Operation$json = {
  '1': 'Operation',
  '2': [
    {'1': 'operation_id', '3': 1, '4': 1, '5': 9, '10': 'operationId'},
    {'1': 'operation_name', '3': 2, '4': 1, '5': 9, '10': 'operationName'},
    {'1': 'consumer_id', '3': 3, '4': 1, '5': 9, '10': 'consumerId'},
    {
      '1': 'start_time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startTime'
    },
    {
      '1': 'end_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'endTime'
    },
    {
      '1': 'labels',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.Operation.LabelsEntry',
      '10': 'labels'
    },
    {
      '1': 'metric_value_sets',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.MetricValueSet',
      '10': 'metricValueSets'
    },
    {
      '1': 'log_entries',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.LogEntry',
      '10': 'logEntries'
    },
    {
      '1': 'importance',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.google.api.servicecontrol.v1.Operation.Importance',
      '10': 'importance'
    },
    {
      '1': 'extensions',
      '3': 16,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'extensions'
    },
  ],
  '3': [Operation_LabelsEntry$json],
  '4': [Operation_Importance$json],
};

@$core.Deprecated('Use operationDescriptor instead')
const Operation_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use operationDescriptor instead')
const Operation_Importance$json = {
  '1': 'Importance',
  '2': [
    {'1': 'LOW', '2': 0},
    {'1': 'HIGH', '2': 1},
  ],
};

/// Descriptor for `Operation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List operationDescriptor = $convert.base64Decode(
    'CglPcGVyYXRpb24SIQoMb3BlcmF0aW9uX2lkGAEgASgJUgtvcGVyYXRpb25JZBIlCg5vcGVyYX'
    'Rpb25fbmFtZRgCIAEoCVINb3BlcmF0aW9uTmFtZRIfCgtjb25zdW1lcl9pZBgDIAEoCVIKY29u'
    'c3VtZXJJZBI5CgpzdGFydF90aW1lGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcF'
    'IJc3RhcnRUaW1lEjUKCGVuZF90aW1lGAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cFIHZW5kVGltZRJLCgZsYWJlbHMYBiADKAsyMy5nb29nbGUuYXBpLnNlcnZpY2Vjb250cm9sLn'
    'YxLk9wZXJhdGlvbi5MYWJlbHNFbnRyeVIGbGFiZWxzElgKEW1ldHJpY192YWx1ZV9zZXRzGAcg'
    'AygLMiwuZ29vZ2xlLmFwaS5zZXJ2aWNlY29udHJvbC52MS5NZXRyaWNWYWx1ZVNldFIPbWV0cm'
    'ljVmFsdWVTZXRzEkcKC2xvZ19lbnRyaWVzGAggAygLMiYuZ29vZ2xlLmFwaS5zZXJ2aWNlY29u'
    'dHJvbC52MS5Mb2dFbnRyeVIKbG9nRW50cmllcxJSCgppbXBvcnRhbmNlGAsgASgOMjIuZ29vZ2'
    'xlLmFwaS5zZXJ2aWNlY29udHJvbC52MS5PcGVyYXRpb24uSW1wb3J0YW5jZVIKaW1wb3J0YW5j'
    'ZRI0CgpleHRlbnNpb25zGBAgAygLMhQuZ29vZ2xlLnByb3RvYnVmLkFueVIKZXh0ZW5zaW9ucx'
    'o5CgtMYWJlbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6'
    'AjgBIh8KCkltcG9ydGFuY2USBwoDTE9XEAASCAoESElHSBAB');
