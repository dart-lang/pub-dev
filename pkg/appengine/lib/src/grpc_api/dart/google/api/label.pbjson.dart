//
//  Generated code. Do not modify.
//  source: google/api/label.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use labelDescriptorDescriptor instead')
const LabelDescriptor$json = {
  '1': 'LabelDescriptor',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.api.LabelDescriptor.ValueType',
      '10': 'valueType'
    },
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
  '4': [LabelDescriptor_ValueType$json],
};

@$core.Deprecated('Use labelDescriptorDescriptor instead')
const LabelDescriptor_ValueType$json = {
  '1': 'ValueType',
  '2': [
    {'1': 'STRING', '2': 0},
    {'1': 'BOOL', '2': 1},
    {'1': 'INT64', '2': 2},
  ],
};

/// Descriptor for `LabelDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List labelDescriptorDescriptor = $convert.base64Decode(
    'Cg9MYWJlbERlc2NyaXB0b3ISEAoDa2V5GAEgASgJUgNrZXkSRAoKdmFsdWVfdHlwZRgCIAEoDj'
    'IlLmdvb2dsZS5hcGkuTGFiZWxEZXNjcmlwdG9yLlZhbHVlVHlwZVIJdmFsdWVUeXBlEiAKC2Rl'
    'c2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbiIsCglWYWx1ZVR5cGUSCgoGU1RSSU5HEAASCA'
    'oEQk9PTBABEgkKBUlOVDY0EAI=');
