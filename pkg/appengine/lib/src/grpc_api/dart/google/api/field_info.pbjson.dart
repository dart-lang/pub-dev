//
//  Generated code. Do not modify.
//  source: google/api/field_info.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use fieldInfoDescriptor instead')
const FieldInfo$json = {
  '1': 'FieldInfo',
  '2': [
    {
      '1': 'format',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.api.FieldInfo.Format',
      '10': 'format'
    },
    {
      '1': 'referenced_types',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.TypeReference',
      '10': 'referencedTypes'
    },
  ],
  '4': [FieldInfo_Format$json],
};

@$core.Deprecated('Use fieldInfoDescriptor instead')
const FieldInfo_Format$json = {
  '1': 'Format',
  '2': [
    {'1': 'FORMAT_UNSPECIFIED', '2': 0},
    {'1': 'UUID4', '2': 1},
    {'1': 'IPV4', '2': 2},
    {'1': 'IPV6', '2': 3},
    {'1': 'IPV4_OR_IPV6', '2': 4},
  ],
};

/// Descriptor for `FieldInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fieldInfoDescriptor = $convert.base64Decode(
    'CglGaWVsZEluZm8SNAoGZm9ybWF0GAEgASgOMhwuZ29vZ2xlLmFwaS5GaWVsZEluZm8uRm9ybW'
    'F0UgZmb3JtYXQSRAoQcmVmZXJlbmNlZF90eXBlcxgCIAMoCzIZLmdvb2dsZS5hcGkuVHlwZVJl'
    'ZmVyZW5jZVIPcmVmZXJlbmNlZFR5cGVzIlEKBkZvcm1hdBIWChJGT1JNQVRfVU5TUEVDSUZJRU'
    'QQABIJCgVVVUlENBABEggKBElQVjQQAhIICgRJUFY2EAMSEAoMSVBWNF9PUl9JUFY2EAQ=');

@$core.Deprecated('Use typeReferenceDescriptor instead')
const TypeReference$json = {
  '1': 'TypeReference',
  '2': [
    {'1': 'type_name', '3': 1, '4': 1, '5': 9, '10': 'typeName'},
  ],
};

/// Descriptor for `TypeReference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typeReferenceDescriptor = $convert.base64Decode(
    'Cg1UeXBlUmVmZXJlbmNlEhsKCXR5cGVfbmFtZRgBIAEoCVIIdHlwZU5hbWU=');
