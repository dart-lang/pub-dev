//
//  Generated code. Do not modify.
//  source: google/api/expr/v1alpha1/value.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use valueDescriptor instead')
const Value$json = {
  '1': 'Value',
  '2': [
    {
      '1': 'null_value',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.NullValue',
      '9': 0,
      '10': 'nullValue'
    },
    {'1': 'bool_value', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'boolValue'},
    {'1': 'int64_value', '3': 3, '4': 1, '5': 3, '9': 0, '10': 'int64Value'},
    {'1': 'uint64_value', '3': 4, '4': 1, '5': 4, '9': 0, '10': 'uint64Value'},
    {'1': 'double_value', '3': 5, '4': 1, '5': 1, '9': 0, '10': 'doubleValue'},
    {'1': 'string_value', '3': 6, '4': 1, '5': 9, '9': 0, '10': 'stringValue'},
    {'1': 'bytes_value', '3': 7, '4': 1, '5': 12, '9': 0, '10': 'bytesValue'},
    {
      '1': 'enum_value',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.EnumValue',
      '9': 0,
      '10': 'enumValue'
    },
    {
      '1': 'object_value',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '9': 0,
      '10': 'objectValue'
    },
    {
      '1': 'map_value',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.MapValue',
      '9': 0,
      '10': 'mapValue'
    },
    {
      '1': 'list_value',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.ListValue',
      '9': 0,
      '10': 'listValue'
    },
    {'1': 'type_value', '3': 15, '4': 1, '5': 9, '9': 0, '10': 'typeValue'},
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `Value`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List valueDescriptor = $convert.base64Decode(
    'CgVWYWx1ZRI7CgpudWxsX3ZhbHVlGAEgASgOMhouZ29vZ2xlLnByb3RvYnVmLk51bGxWYWx1ZU'
    'gAUgludWxsVmFsdWUSHwoKYm9vbF92YWx1ZRgCIAEoCEgAUglib29sVmFsdWUSIQoLaW50NjRf'
    'dmFsdWUYAyABKANIAFIKaW50NjRWYWx1ZRIjCgx1aW50NjRfdmFsdWUYBCABKARIAFILdWludD'
    'Y0VmFsdWUSIwoMZG91YmxlX3ZhbHVlGAUgASgBSABSC2RvdWJsZVZhbHVlEiMKDHN0cmluZ192'
    'YWx1ZRgGIAEoCUgAUgtzdHJpbmdWYWx1ZRIhCgtieXRlc192YWx1ZRgHIAEoDEgAUgpieXRlc1'
    'ZhbHVlEkQKCmVudW1fdmFsdWUYCSABKAsyIy5nb29nbGUuYXBpLmV4cHIudjFhbHBoYTEuRW51'
    'bVZhbHVlSABSCWVudW1WYWx1ZRI5CgxvYmplY3RfdmFsdWUYCiABKAsyFC5nb29nbGUucHJvdG'
    '9idWYuQW55SABSC29iamVjdFZhbHVlEkEKCW1hcF92YWx1ZRgLIAEoCzIiLmdvb2dsZS5hcGku'
    'ZXhwci52MWFscGhhMS5NYXBWYWx1ZUgAUghtYXBWYWx1ZRJECgpsaXN0X3ZhbHVlGAwgASgLMi'
    'MuZ29vZ2xlLmFwaS5leHByLnYxYWxwaGExLkxpc3RWYWx1ZUgAUglsaXN0VmFsdWUSHwoKdHlw'
    'ZV92YWx1ZRgPIAEoCUgAUgl0eXBlVmFsdWVCBgoEa2luZA==');

@$core.Deprecated('Use enumValueDescriptor instead')
const EnumValue$json = {
  '1': 'EnumValue',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
};

/// Descriptor for `EnumValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enumValueDescriptor = $convert.base64Decode(
    'CglFbnVtVmFsdWUSEgoEdHlwZRgBIAEoCVIEdHlwZRIUCgV2YWx1ZRgCIAEoBVIFdmFsdWU=');

@$core.Deprecated('Use listValueDescriptor instead')
const ListValue$json = {
  '1': 'ListValue',
  '2': [
    {
      '1': 'values',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.Value',
      '10': 'values'
    },
  ],
};

/// Descriptor for `ListValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listValueDescriptor = $convert.base64Decode(
    'CglMaXN0VmFsdWUSNwoGdmFsdWVzGAEgAygLMh8uZ29vZ2xlLmFwaS5leHByLnYxYWxwaGExLl'
    'ZhbHVlUgZ2YWx1ZXM=');

@$core.Deprecated('Use mapValueDescriptor instead')
const MapValue$json = {
  '1': 'MapValue',
  '2': [
    {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.MapValue.Entry',
      '10': 'entries'
    },
  ],
  '3': [MapValue_Entry$json],
};

@$core.Deprecated('Use mapValueDescriptor instead')
const MapValue_Entry$json = {
  '1': 'Entry',
  '2': [
    {
      '1': 'key',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.Value',
      '10': 'key'
    },
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.Value',
      '10': 'value'
    },
  ],
};

/// Descriptor for `MapValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mapValueDescriptor = $convert.base64Decode(
    'CghNYXBWYWx1ZRJCCgdlbnRyaWVzGAEgAygLMiguZ29vZ2xlLmFwaS5leHByLnYxYWxwaGExLk'
    '1hcFZhbHVlLkVudHJ5UgdlbnRyaWVzGnEKBUVudHJ5EjEKA2tleRgBIAEoCzIfLmdvb2dsZS5h'
    'cGkuZXhwci52MWFscGhhMS5WYWx1ZVIDa2V5EjUKBXZhbHVlGAIgASgLMh8uZ29vZ2xlLmFwaS'
    '5leHByLnYxYWxwaGExLlZhbHVlUgV2YWx1ZQ==');
