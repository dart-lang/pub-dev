//
//  Generated code. Do not modify.
//  source: google/logging/v2/logging_metrics.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use logMetricDescriptor instead')
const LogMetric$json = {
  '1': 'LogMetric',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'description'},
    {'1': 'filter', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'filter'},
    {'1': 'bucket_name', '3': 13, '4': 1, '5': 9, '8': {}, '10': 'bucketName'},
    {'1': 'disabled', '3': 12, '4': 1, '5': 8, '8': {}, '10': 'disabled'},
    {
      '1': 'metric_descriptor',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.api.MetricDescriptor',
      '8': {},
      '10': 'metricDescriptor'
    },
    {
      '1': 'value_extractor',
      '3': 6,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'valueExtractor'
    },
    {
      '1': 'label_extractors',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogMetric.LabelExtractorsEntry',
      '8': {},
      '10': 'labelExtractors'
    },
    {
      '1': 'bucket_options',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.api.Distribution.BucketOptions',
      '8': {},
      '10': 'bucketOptions'
    },
    {
      '1': 'create_time',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'createTime'
    },
    {
      '1': 'update_time',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'updateTime'
    },
    {
      '1': 'version',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.logging.v2.LogMetric.ApiVersion',
      '8': {'3': true},
      '10': 'version',
    },
  ],
  '3': [LogMetric_LabelExtractorsEntry$json],
  '4': [LogMetric_ApiVersion$json],
  '7': {},
};

@$core.Deprecated('Use logMetricDescriptor instead')
const LogMetric_LabelExtractorsEntry$json = {
  '1': 'LabelExtractorsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use logMetricDescriptor instead')
const LogMetric_ApiVersion$json = {
  '1': 'ApiVersion',
  '2': [
    {'1': 'V2', '2': 0},
    {'1': 'V1', '2': 1},
  ],
};

/// Descriptor for `LogMetric`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logMetricDescriptor = $convert.base64Decode(
    'CglMb2dNZXRyaWMSFwoEbmFtZRgBIAEoCUID4EECUgRuYW1lEiUKC2Rlc2NyaXB0aW9uGAIgAS'
    'gJQgPgQQFSC2Rlc2NyaXB0aW9uEhsKBmZpbHRlchgDIAEoCUID4EECUgZmaWx0ZXISJAoLYnVj'
    'a2V0X25hbWUYDSABKAlCA+BBAVIKYnVja2V0TmFtZRIfCghkaXNhYmxlZBgMIAEoCEID4EEBUg'
    'hkaXNhYmxlZBJOChFtZXRyaWNfZGVzY3JpcHRvchgFIAEoCzIcLmdvb2dsZS5hcGkuTWV0cmlj'
    'RGVzY3JpcHRvckID4EEBUhBtZXRyaWNEZXNjcmlwdG9yEiwKD3ZhbHVlX2V4dHJhY3RvchgGIA'
    'EoCUID4EEBUg52YWx1ZUV4dHJhY3RvchJhChBsYWJlbF9leHRyYWN0b3JzGAcgAygLMjEuZ29v'
    'Z2xlLmxvZ2dpbmcudjIuTG9nTWV0cmljLkxhYmVsRXh0cmFjdG9yc0VudHJ5QgPgQQFSD2xhYm'
    'VsRXh0cmFjdG9ycxJSCg5idWNrZXRfb3B0aW9ucxgIIAEoCzImLmdvb2dsZS5hcGkuRGlzdHJp'
    'YnV0aW9uLkJ1Y2tldE9wdGlvbnNCA+BBAVINYnVja2V0T3B0aW9ucxJACgtjcmVhdGVfdGltZR'
    'gJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCA+BBA1IKY3JlYXRlVGltZRJACgt1'
    'cGRhdGVfdGltZRgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCA+BBA1IKdXBkYX'
    'RlVGltZRJFCgd2ZXJzaW9uGAQgASgOMicuZ29vZ2xlLmxvZ2dpbmcudjIuTG9nTWV0cmljLkFw'
    'aVZlcnNpb25CAhgBUgd2ZXJzaW9uGkIKFExhYmVsRXh0cmFjdG9yc0VudHJ5EhAKA2tleRgBIA'
    'EoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEiHAoKQXBpVmVyc2lvbhIGCgJWMhAA'
    'EgYKAlYxEAE6SupBRwogbG9nZ2luZy5nb29nbGVhcGlzLmNvbS9Mb2dNZXRyaWMSI3Byb2plY3'
    'RzL3twcm9qZWN0fS9tZXRyaWNzL3ttZXRyaWN9');

@$core.Deprecated('Use listLogMetricsRequestDescriptor instead')
const ListLogMetricsRequest$json = {
  '1': 'ListLogMetricsRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'page_token', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'pageToken'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '8': {}, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListLogMetricsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLogMetricsRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0TG9nTWV0cmljc1JlcXVlc3QSSwoGcGFyZW50GAEgASgJQjPgQQL6QS0KK2Nsb3Vkcm'
    'Vzb3VyY2VtYW5hZ2VyLmdvb2dsZWFwaXMuY29tL1Byb2plY3RSBnBhcmVudBIiCgpwYWdlX3Rv'
    'a2VuGAIgASgJQgPgQQFSCXBhZ2VUb2tlbhIgCglwYWdlX3NpemUYAyABKAVCA+BBAVIIcGFnZV'
    'NpemU=');

@$core.Deprecated('Use listLogMetricsResponseDescriptor instead')
const ListLogMetricsResponse$json = {
  '1': 'ListLogMetricsResponse',
  '2': [
    {
      '1': 'metrics',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogMetric',
      '10': 'metrics'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListLogMetricsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLogMetricsResponseDescriptor = $convert.base64Decode(
    'ChZMaXN0TG9nTWV0cmljc1Jlc3BvbnNlEjYKB21ldHJpY3MYASADKAsyHC5nb29nbGUubG9nZ2'
    'luZy52Mi5Mb2dNZXRyaWNSB21ldHJpY3MSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0'
    'UGFnZVRva2Vu');

@$core.Deprecated('Use getLogMetricRequestDescriptor instead')
const GetLogMetricRequest$json = {
  '1': 'GetLogMetricRequest',
  '2': [
    {'1': 'metric_name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'metricName'},
  ],
};

/// Descriptor for `GetLogMetricRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLogMetricRequestDescriptor = $convert.base64Decode(
    'ChNHZXRMb2dNZXRyaWNSZXF1ZXN0EkkKC21ldHJpY19uYW1lGAEgASgJQijgQQL6QSIKIGxvZ2'
    'dpbmcuZ29vZ2xlYXBpcy5jb20vTG9nTWV0cmljUgptZXRyaWNOYW1l');

@$core.Deprecated('Use createLogMetricRequestDescriptor instead')
const CreateLogMetricRequest$json = {
  '1': 'CreateLogMetricRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {
      '1': 'metric',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogMetric',
      '8': {},
      '10': 'metric'
    },
  ],
};

/// Descriptor for `CreateLogMetricRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLogMetricRequestDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVMb2dNZXRyaWNSZXF1ZXN0EkAKBnBhcmVudBgBIAEoCUIo4EEC+kEiEiBsb2dnaW'
    '5nLmdvb2dsZWFwaXMuY29tL0xvZ01ldHJpY1IGcGFyZW50EjkKBm1ldHJpYxgCIAEoCzIcLmdv'
    'b2dsZS5sb2dnaW5nLnYyLkxvZ01ldHJpY0ID4EECUgZtZXRyaWM=');

@$core.Deprecated('Use updateLogMetricRequestDescriptor instead')
const UpdateLogMetricRequest$json = {
  '1': 'UpdateLogMetricRequest',
  '2': [
    {'1': 'metric_name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'metricName'},
    {
      '1': 'metric',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogMetric',
      '8': {},
      '10': 'metric'
    },
  ],
};

/// Descriptor for `UpdateLogMetricRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateLogMetricRequestDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVMb2dNZXRyaWNSZXF1ZXN0EkkKC21ldHJpY19uYW1lGAEgASgJQijgQQL6QSIKIG'
    'xvZ2dpbmcuZ29vZ2xlYXBpcy5jb20vTG9nTWV0cmljUgptZXRyaWNOYW1lEjkKBm1ldHJpYxgC'
    'IAEoCzIcLmdvb2dsZS5sb2dnaW5nLnYyLkxvZ01ldHJpY0ID4EECUgZtZXRyaWM=');

@$core.Deprecated('Use deleteLogMetricRequestDescriptor instead')
const DeleteLogMetricRequest$json = {
  '1': 'DeleteLogMetricRequest',
  '2': [
    {'1': 'metric_name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'metricName'},
  ],
};

/// Descriptor for `DeleteLogMetricRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteLogMetricRequestDescriptor =
    $convert.base64Decode(
        'ChZEZWxldGVMb2dNZXRyaWNSZXF1ZXN0EkkKC21ldHJpY19uYW1lGAEgASgJQijgQQL6QSIKIG'
        'xvZ2dpbmcuZ29vZ2xlYXBpcy5jb20vTG9nTWV0cmljUgptZXRyaWNOYW1l');
