//
//  Generated code. Do not modify.
//  source: google/protobuf/api.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use apiDescriptor instead')
const Api$json = {
  '1': 'Api',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'methods',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Method',
      '10': 'methods'
    },
    {
      '1': 'options',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Option',
      '10': 'options'
    },
    {'1': 'version', '3': 4, '4': 1, '5': 9, '10': 'version'},
    {
      '1': 'source_context',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.SourceContext',
      '10': 'sourceContext'
    },
    {
      '1': 'mixins',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Mixin',
      '10': 'mixins'
    },
    {
      '1': 'syntax',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.Syntax',
      '10': 'syntax'
    },
  ],
};

/// Descriptor for `Api`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List apiDescriptor = $convert.base64Decode(
    'CgNBcGkSEgoEbmFtZRgBIAEoCVIEbmFtZRIxCgdtZXRob2RzGAIgAygLMhcuZ29vZ2xlLnByb3'
    'RvYnVmLk1ldGhvZFIHbWV0aG9kcxIxCgdvcHRpb25zGAMgAygLMhcuZ29vZ2xlLnByb3RvYnVm'
    'Lk9wdGlvblIHb3B0aW9ucxIYCgd2ZXJzaW9uGAQgASgJUgd2ZXJzaW9uEkUKDnNvdXJjZV9jb2'
    '50ZXh0GAUgASgLMh4uZ29vZ2xlLnByb3RvYnVmLlNvdXJjZUNvbnRleHRSDXNvdXJjZUNvbnRl'
    'eHQSLgoGbWl4aW5zGAYgAygLMhYuZ29vZ2xlLnByb3RvYnVmLk1peGluUgZtaXhpbnMSLwoGc3'
    'ludGF4GAcgASgOMhcuZ29vZ2xlLnByb3RvYnVmLlN5bnRheFIGc3ludGF4');

@$core.Deprecated('Use methodDescriptor instead')
const Method$json = {
  '1': 'Method',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'request_type_url', '3': 2, '4': 1, '5': 9, '10': 'requestTypeUrl'},
    {
      '1': 'request_streaming',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'requestStreaming'
    },
    {'1': 'response_type_url', '3': 4, '4': 1, '5': 9, '10': 'responseTypeUrl'},
    {
      '1': 'response_streaming',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'responseStreaming'
    },
    {
      '1': 'options',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Option',
      '10': 'options'
    },
    {
      '1': 'syntax',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.Syntax',
      '10': 'syntax'
    },
  ],
};

/// Descriptor for `Method`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List methodDescriptor = $convert.base64Decode(
    'CgZNZXRob2QSEgoEbmFtZRgBIAEoCVIEbmFtZRIoChByZXF1ZXN0X3R5cGVfdXJsGAIgASgJUg'
    '5yZXF1ZXN0VHlwZVVybBIrChFyZXF1ZXN0X3N0cmVhbWluZxgDIAEoCFIQcmVxdWVzdFN0cmVh'
    'bWluZxIqChFyZXNwb25zZV90eXBlX3VybBgEIAEoCVIPcmVzcG9uc2VUeXBlVXJsEi0KEnJlc3'
    'BvbnNlX3N0cmVhbWluZxgFIAEoCFIRcmVzcG9uc2VTdHJlYW1pbmcSMQoHb3B0aW9ucxgGIAMo'
    'CzIXLmdvb2dsZS5wcm90b2J1Zi5PcHRpb25SB29wdGlvbnMSLwoGc3ludGF4GAcgASgOMhcuZ2'
    '9vZ2xlLnByb3RvYnVmLlN5bnRheFIGc3ludGF4');

@$core.Deprecated('Use mixinDescriptor instead')
const Mixin$json = {
  '1': 'Mixin',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'root', '3': 2, '4': 1, '5': 9, '10': 'root'},
  ],
};

/// Descriptor for `Mixin`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mixinDescriptor = $convert.base64Decode(
    'CgVNaXhpbhISCgRuYW1lGAEgASgJUgRuYW1lEhIKBHJvb3QYAiABKAlSBHJvb3Q=');
