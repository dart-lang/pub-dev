//
//  Generated code. Do not modify.
//  source: google/api/config_change.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use changeTypeDescriptor instead')
const ChangeType$json = {
  '1': 'ChangeType',
  '2': [
    {'1': 'CHANGE_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'ADDED', '2': 1},
    {'1': 'REMOVED', '2': 2},
    {'1': 'MODIFIED', '2': 3},
  ],
};

/// Descriptor for `ChangeType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List changeTypeDescriptor = $convert.base64Decode(
    'CgpDaGFuZ2VUeXBlEhsKF0NIQU5HRV9UWVBFX1VOU1BFQ0lGSUVEEAASCQoFQURERUQQARILCg'
    'dSRU1PVkVEEAISDAoITU9ESUZJRUQQAw==');

@$core.Deprecated('Use configChangeDescriptor instead')
const ConfigChange$json = {
  '1': 'ConfigChange',
  '2': [
    {'1': 'element', '3': 1, '4': 1, '5': 9, '10': 'element'},
    {'1': 'old_value', '3': 2, '4': 1, '5': 9, '10': 'oldValue'},
    {'1': 'new_value', '3': 3, '4': 1, '5': 9, '10': 'newValue'},
    {
      '1': 'change_type',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.api.ChangeType',
      '10': 'changeType'
    },
    {
      '1': 'advices',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.google.api.Advice',
      '10': 'advices'
    },
  ],
};

/// Descriptor for `ConfigChange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List configChangeDescriptor = $convert.base64Decode(
    'CgxDb25maWdDaGFuZ2USGAoHZWxlbWVudBgBIAEoCVIHZWxlbWVudBIbCglvbGRfdmFsdWUYAi'
    'ABKAlSCG9sZFZhbHVlEhsKCW5ld192YWx1ZRgDIAEoCVIIbmV3VmFsdWUSNwoLY2hhbmdlX3R5'
    'cGUYBCABKA4yFi5nb29nbGUuYXBpLkNoYW5nZVR5cGVSCmNoYW5nZVR5cGUSLAoHYWR2aWNlcx'
    'gFIAMoCzISLmdvb2dsZS5hcGkuQWR2aWNlUgdhZHZpY2Vz');

@$core.Deprecated('Use adviceDescriptor instead')
const Advice$json = {
  '1': 'Advice',
  '2': [
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `Advice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adviceDescriptor = $convert
    .base64Decode('CgZBZHZpY2USIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9u');
