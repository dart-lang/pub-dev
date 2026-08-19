//
//  Generated code. Do not modify.
//  source: google/api/log.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use logDescriptorDescriptor instead')
const LogDescriptor$json = {
  '1': 'LogDescriptor',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'labels',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.LabelDescriptor',
      '10': 'labels'
    },
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
  ],
};

/// Descriptor for `LogDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logDescriptorDescriptor = $convert.base64Decode(
    'Cg1Mb2dEZXNjcmlwdG9yEhIKBG5hbWUYASABKAlSBG5hbWUSMwoGbGFiZWxzGAIgAygLMhsuZ2'
    '9vZ2xlLmFwaS5MYWJlbERlc2NyaXB0b3JSBmxhYmVscxIgCgtkZXNjcmlwdGlvbhgDIAEoCVIL'
    'ZGVzY3JpcHRpb24SIQoMZGlzcGxheV9uYW1lGAQgASgJUgtkaXNwbGF5TmFtZQ==');
