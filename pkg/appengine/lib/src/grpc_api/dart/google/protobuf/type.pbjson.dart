//
//  Generated code. Do not modify.
//  source: google/protobuf/type.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use syntaxDescriptor instead')
const Syntax$json = {
  '1': 'Syntax',
  '2': [
    {'1': 'SYNTAX_PROTO2', '2': 0},
    {'1': 'SYNTAX_PROTO3', '2': 1},
    {'1': 'SYNTAX_EDITIONS', '2': 2},
  ],
};

/// Descriptor for `Syntax`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List syntaxDescriptor = $convert.base64Decode(
    'CgZTeW50YXgSEQoNU1lOVEFYX1BST1RPMhAAEhEKDVNZTlRBWF9QUk9UTzMQARITCg9TWU5UQV'
    'hfRURJVElPTlMQAg==');

@$core.Deprecated('Use typeDescriptor instead')
const Type$json = {
  '1': 'Type',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'fields',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Field',
      '10': 'fields'
    },
    {'1': 'oneofs', '3': 3, '4': 3, '5': 9, '10': 'oneofs'},
    {
      '1': 'options',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Option',
      '10': 'options'
    },
    {
      '1': 'source_context',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.SourceContext',
      '10': 'sourceContext'
    },
    {
      '1': 'syntax',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.Syntax',
      '10': 'syntax'
    },
    {'1': 'edition', '3': 7, '4': 1, '5': 9, '10': 'edition'},
  ],
};

/// Descriptor for `Type`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typeDescriptor = $convert.base64Decode(
    'CgRUeXBlEhIKBG5hbWUYASABKAlSBG5hbWUSLgoGZmllbGRzGAIgAygLMhYuZ29vZ2xlLnByb3'
    'RvYnVmLkZpZWxkUgZmaWVsZHMSFgoGb25lb2ZzGAMgAygJUgZvbmVvZnMSMQoHb3B0aW9ucxgE'
    'IAMoCzIXLmdvb2dsZS5wcm90b2J1Zi5PcHRpb25SB29wdGlvbnMSRQoOc291cmNlX2NvbnRleH'
    'QYBSABKAsyHi5nb29nbGUucHJvdG9idWYuU291cmNlQ29udGV4dFINc291cmNlQ29udGV4dBIv'
    'CgZzeW50YXgYBiABKA4yFy5nb29nbGUucHJvdG9idWYuU3ludGF4UgZzeW50YXgSGAoHZWRpdG'
    'lvbhgHIAEoCVIHZWRpdGlvbg==');

@$core.Deprecated('Use fieldDescriptor instead')
const Field$json = {
  '1': 'Field',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.Field.Kind',
      '10': 'kind'
    },
    {
      '1': 'cardinality',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.Field.Cardinality',
      '10': 'cardinality'
    },
    {'1': 'number', '3': 3, '4': 1, '5': 5, '10': 'number'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'type_url', '3': 6, '4': 1, '5': 9, '10': 'typeUrl'},
    {'1': 'oneof_index', '3': 7, '4': 1, '5': 5, '10': 'oneofIndex'},
    {'1': 'packed', '3': 8, '4': 1, '5': 8, '10': 'packed'},
    {
      '1': 'options',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Option',
      '10': 'options'
    },
    {'1': 'json_name', '3': 10, '4': 1, '5': 9, '10': 'jsonName'},
    {'1': 'default_value', '3': 11, '4': 1, '5': 9, '10': 'defaultValue'},
  ],
  '4': [Field_Kind$json, Field_Cardinality$json],
};

@$core.Deprecated('Use fieldDescriptor instead')
const Field_Kind$json = {
  '1': 'Kind',
  '2': [
    {'1': 'TYPE_UNKNOWN', '2': 0},
    {'1': 'TYPE_DOUBLE', '2': 1},
    {'1': 'TYPE_FLOAT', '2': 2},
    {'1': 'TYPE_INT64', '2': 3},
    {'1': 'TYPE_UINT64', '2': 4},
    {'1': 'TYPE_INT32', '2': 5},
    {'1': 'TYPE_FIXED64', '2': 6},
    {'1': 'TYPE_FIXED32', '2': 7},
    {'1': 'TYPE_BOOL', '2': 8},
    {'1': 'TYPE_STRING', '2': 9},
    {'1': 'TYPE_GROUP', '2': 10},
    {'1': 'TYPE_MESSAGE', '2': 11},
    {'1': 'TYPE_BYTES', '2': 12},
    {'1': 'TYPE_UINT32', '2': 13},
    {'1': 'TYPE_ENUM', '2': 14},
    {'1': 'TYPE_SFIXED32', '2': 15},
    {'1': 'TYPE_SFIXED64', '2': 16},
    {'1': 'TYPE_SINT32', '2': 17},
    {'1': 'TYPE_SINT64', '2': 18},
  ],
};

@$core.Deprecated('Use fieldDescriptor instead')
const Field_Cardinality$json = {
  '1': 'Cardinality',
  '2': [
    {'1': 'CARDINALITY_UNKNOWN', '2': 0},
    {'1': 'CARDINALITY_OPTIONAL', '2': 1},
    {'1': 'CARDINALITY_REQUIRED', '2': 2},
    {'1': 'CARDINALITY_REPEATED', '2': 3},
  ],
};

/// Descriptor for `Field`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fieldDescriptor = $convert.base64Decode(
    'CgVGaWVsZBIvCgRraW5kGAEgASgOMhsuZ29vZ2xlLnByb3RvYnVmLkZpZWxkLktpbmRSBGtpbm'
    'QSRAoLY2FyZGluYWxpdHkYAiABKA4yIi5nb29nbGUucHJvdG9idWYuRmllbGQuQ2FyZGluYWxp'
    'dHlSC2NhcmRpbmFsaXR5EhYKBm51bWJlchgDIAEoBVIGbnVtYmVyEhIKBG5hbWUYBCABKAlSBG'
    '5hbWUSGQoIdHlwZV91cmwYBiABKAlSB3R5cGVVcmwSHwoLb25lb2ZfaW5kZXgYByABKAVSCm9u'
    'ZW9mSW5kZXgSFgoGcGFja2VkGAggASgIUgZwYWNrZWQSMQoHb3B0aW9ucxgJIAMoCzIXLmdvb2'
    'dsZS5wcm90b2J1Zi5PcHRpb25SB29wdGlvbnMSGwoJanNvbl9uYW1lGAogASgJUghqc29uTmFt'
    'ZRIjCg1kZWZhdWx0X3ZhbHVlGAsgASgJUgxkZWZhdWx0VmFsdWUiyAIKBEtpbmQSEAoMVFlQRV'
    '9VTktOT1dOEAASDwoLVFlQRV9ET1VCTEUQARIOCgpUWVBFX0ZMT0FUEAISDgoKVFlQRV9JTlQ2'
    'NBADEg8KC1RZUEVfVUlOVDY0EAQSDgoKVFlQRV9JTlQzMhAFEhAKDFRZUEVfRklYRUQ2NBAGEh'
    'AKDFRZUEVfRklYRUQzMhAHEg0KCVRZUEVfQk9PTBAIEg8KC1RZUEVfU1RSSU5HEAkSDgoKVFlQ'
    'RV9HUk9VUBAKEhAKDFRZUEVfTUVTU0FHRRALEg4KClRZUEVfQllURVMQDBIPCgtUWVBFX1VJTl'
    'QzMhANEg0KCVRZUEVfRU5VTRAOEhEKDVRZUEVfU0ZJWEVEMzIQDxIRCg1UWVBFX1NGSVhFRDY0'
    'EBASDwoLVFlQRV9TSU5UMzIQERIPCgtUWVBFX1NJTlQ2NBASInQKC0NhcmRpbmFsaXR5EhcKE0'
    'NBUkRJTkFMSVRZX1VOS05PV04QABIYChRDQVJESU5BTElUWV9PUFRJT05BTBABEhgKFENBUkRJ'
    'TkFMSVRZX1JFUVVJUkVEEAISGAoUQ0FSRElOQUxJVFlfUkVQRUFURUQQAw==');

@$core.Deprecated('Use enumDescriptor instead')
const Enum$json = {
  '1': 'Enum',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'enumvalue',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.EnumValue',
      '10': 'enumvalue'
    },
    {
      '1': 'options',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Option',
      '10': 'options'
    },
    {
      '1': 'source_context',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.SourceContext',
      '10': 'sourceContext'
    },
    {
      '1': 'syntax',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.Syntax',
      '10': 'syntax'
    },
    {'1': 'edition', '3': 6, '4': 1, '5': 9, '10': 'edition'},
  ],
};

/// Descriptor for `Enum`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enumDescriptor = $convert.base64Decode(
    'CgRFbnVtEhIKBG5hbWUYASABKAlSBG5hbWUSOAoJZW51bXZhbHVlGAIgAygLMhouZ29vZ2xlLn'
    'Byb3RvYnVmLkVudW1WYWx1ZVIJZW51bXZhbHVlEjEKB29wdGlvbnMYAyADKAsyFy5nb29nbGUu'
    'cHJvdG9idWYuT3B0aW9uUgdvcHRpb25zEkUKDnNvdXJjZV9jb250ZXh0GAQgASgLMh4uZ29vZ2'
    'xlLnByb3RvYnVmLlNvdXJjZUNvbnRleHRSDXNvdXJjZUNvbnRleHQSLwoGc3ludGF4GAUgASgO'
    'MhcuZ29vZ2xlLnByb3RvYnVmLlN5bnRheFIGc3ludGF4EhgKB2VkaXRpb24YBiABKAlSB2VkaX'
    'Rpb24=');

@$core.Deprecated('Use enumValueDescriptor instead')
const EnumValue$json = {
  '1': 'EnumValue',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'number', '3': 2, '4': 1, '5': 5, '10': 'number'},
    {
      '1': 'options',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Option',
      '10': 'options'
    },
  ],
};

/// Descriptor for `EnumValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enumValueDescriptor = $convert.base64Decode(
    'CglFbnVtVmFsdWUSEgoEbmFtZRgBIAEoCVIEbmFtZRIWCgZudW1iZXIYAiABKAVSBm51bWJlch'
    'IxCgdvcHRpb25zGAMgAygLMhcuZ29vZ2xlLnByb3RvYnVmLk9wdGlvblIHb3B0aW9ucw==');

@$core.Deprecated('Use optionDescriptor instead')
const Option$json = {
  '1': 'Option',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'value'
    },
  ],
};

/// Descriptor for `Option`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List optionDescriptor = $convert.base64Decode(
    'CgZPcHRpb24SEgoEbmFtZRgBIAEoCVIEbmFtZRIqCgV2YWx1ZRgCIAEoCzIULmdvb2dsZS5wcm'
    '90b2J1Zi5BbnlSBXZhbHVl');
