//
//  Generated code. Do not modify.
//  source: google/protobuf/test_messages_proto2.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use foreignEnumProto2Descriptor instead')
const ForeignEnumProto2$json = {
  '1': 'ForeignEnumProto2',
  '2': [
    {'1': 'FOREIGN_FOO', '2': 0},
    {'1': 'FOREIGN_BAR', '2': 1},
    {'1': 'FOREIGN_BAZ', '2': 2},
  ],
};

/// Descriptor for `ForeignEnumProto2`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List foreignEnumProto2Descriptor = $convert.base64Decode(
    'ChFGb3JlaWduRW51bVByb3RvMhIPCgtGT1JFSUdOX0ZPTxAAEg8KC0ZPUkVJR05fQkFSEAESDw'
    'oLRk9SRUlHTl9CQVoQAg==');

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2$json = {
  '1': 'TestAllTypesProto2',
  '2': [
    {'1': 'optional_int32', '3': 1, '4': 1, '5': 5, '10': 'optionalInt32'},
    {'1': 'optional_int64', '3': 2, '4': 1, '5': 3, '10': 'optionalInt64'},
    {'1': 'optional_uint32', '3': 3, '4': 1, '5': 13, '10': 'optionalUint32'},
    {'1': 'optional_uint64', '3': 4, '4': 1, '5': 4, '10': 'optionalUint64'},
    {'1': 'optional_sint32', '3': 5, '4': 1, '5': 17, '10': 'optionalSint32'},
    {'1': 'optional_sint64', '3': 6, '4': 1, '5': 18, '10': 'optionalSint64'},
    {'1': 'optional_fixed32', '3': 7, '4': 1, '5': 7, '10': 'optionalFixed32'},
    {'1': 'optional_fixed64', '3': 8, '4': 1, '5': 6, '10': 'optionalFixed64'},
    {
      '1': 'optional_sfixed32',
      '3': 9,
      '4': 1,
      '5': 15,
      '10': 'optionalSfixed32'
    },
    {
      '1': 'optional_sfixed64',
      '3': 10,
      '4': 1,
      '5': 16,
      '10': 'optionalSfixed64'
    },
    {'1': 'optional_float', '3': 11, '4': 1, '5': 2, '10': 'optionalFloat'},
    {'1': 'optional_double', '3': 12, '4': 1, '5': 1, '10': 'optionalDouble'},
    {'1': 'optional_bool', '3': 13, '4': 1, '5': 8, '10': 'optionalBool'},
    {'1': 'optional_string', '3': 14, '4': 1, '5': 9, '10': 'optionalString'},
    {'1': 'optional_bytes', '3': 15, '4': 1, '5': 12, '10': 'optionalBytes'},
    {
      '1': 'optional_nested_message',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2.NestedMessage',
      '10': 'optionalNestedMessage'
    },
    {
      '1': 'optional_foreign_message',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.ForeignMessageProto2',
      '10': 'optionalForeignMessage'
    },
    {
      '1': 'optional_nested_enum',
      '3': 21,
      '4': 1,
      '5': 14,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2.NestedEnum',
      '10': 'optionalNestedEnum'
    },
    {
      '1': 'optional_foreign_enum',
      '3': 22,
      '4': 1,
      '5': 14,
      '6': '.protobuf_test_messages.proto2.ForeignEnumProto2',
      '10': 'optionalForeignEnum'
    },
    {
      '1': 'optional_string_piece',
      '3': 24,
      '4': 1,
      '5': 9,
      '8': {'1': 2},
      '10': 'optionalStringPiece',
    },
    {
      '1': 'optional_cord',
      '3': 25,
      '4': 1,
      '5': 9,
      '8': {'1': 1},
      '10': 'optionalCord',
    },
    {
      '1': 'recursive_message',
      '3': 27,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2',
      '10': 'recursiveMessage'
    },
    {'1': 'repeated_int32', '3': 31, '4': 3, '5': 5, '10': 'repeatedInt32'},
    {'1': 'repeated_int64', '3': 32, '4': 3, '5': 3, '10': 'repeatedInt64'},
    {'1': 'repeated_uint32', '3': 33, '4': 3, '5': 13, '10': 'repeatedUint32'},
    {'1': 'repeated_uint64', '3': 34, '4': 3, '5': 4, '10': 'repeatedUint64'},
    {'1': 'repeated_sint32', '3': 35, '4': 3, '5': 17, '10': 'repeatedSint32'},
    {'1': 'repeated_sint64', '3': 36, '4': 3, '5': 18, '10': 'repeatedSint64'},
    {'1': 'repeated_fixed32', '3': 37, '4': 3, '5': 7, '10': 'repeatedFixed32'},
    {'1': 'repeated_fixed64', '3': 38, '4': 3, '5': 6, '10': 'repeatedFixed64'},
    {
      '1': 'repeated_sfixed32',
      '3': 39,
      '4': 3,
      '5': 15,
      '10': 'repeatedSfixed32'
    },
    {
      '1': 'repeated_sfixed64',
      '3': 40,
      '4': 3,
      '5': 16,
      '10': 'repeatedSfixed64'
    },
    {'1': 'repeated_float', '3': 41, '4': 3, '5': 2, '10': 'repeatedFloat'},
    {'1': 'repeated_double', '3': 42, '4': 3, '5': 1, '10': 'repeatedDouble'},
    {'1': 'repeated_bool', '3': 43, '4': 3, '5': 8, '10': 'repeatedBool'},
    {'1': 'repeated_string', '3': 44, '4': 3, '5': 9, '10': 'repeatedString'},
    {'1': 'repeated_bytes', '3': 45, '4': 3, '5': 12, '10': 'repeatedBytes'},
    {
      '1': 'repeated_nested_message',
      '3': 48,
      '4': 3,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2.NestedMessage',
      '10': 'repeatedNestedMessage'
    },
    {
      '1': 'repeated_foreign_message',
      '3': 49,
      '4': 3,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.ForeignMessageProto2',
      '10': 'repeatedForeignMessage'
    },
    {
      '1': 'repeated_nested_enum',
      '3': 51,
      '4': 3,
      '5': 14,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2.NestedEnum',
      '10': 'repeatedNestedEnum'
    },
    {
      '1': 'repeated_foreign_enum',
      '3': 52,
      '4': 3,
      '5': 14,
      '6': '.protobuf_test_messages.proto2.ForeignEnumProto2',
      '10': 'repeatedForeignEnum'
    },
    {
      '1': 'repeated_string_piece',
      '3': 54,
      '4': 3,
      '5': 9,
      '8': {'1': 2},
      '10': 'repeatedStringPiece',
    },
    {
      '1': 'repeated_cord',
      '3': 55,
      '4': 3,
      '5': 9,
      '8': {'1': 1},
      '10': 'repeatedCord',
    },
    {
      '1': 'packed_int32',
      '3': 75,
      '4': 3,
      '5': 5,
      '8': {'2': true},
      '10': 'packedInt32',
    },
    {
      '1': 'packed_int64',
      '3': 76,
      '4': 3,
      '5': 3,
      '8': {'2': true},
      '10': 'packedInt64',
    },
    {
      '1': 'packed_uint32',
      '3': 77,
      '4': 3,
      '5': 13,
      '8': {'2': true},
      '10': 'packedUint32',
    },
    {
      '1': 'packed_uint64',
      '3': 78,
      '4': 3,
      '5': 4,
      '8': {'2': true},
      '10': 'packedUint64',
    },
    {
      '1': 'packed_sint32',
      '3': 79,
      '4': 3,
      '5': 17,
      '8': {'2': true},
      '10': 'packedSint32',
    },
    {
      '1': 'packed_sint64',
      '3': 80,
      '4': 3,
      '5': 18,
      '8': {'2': true},
      '10': 'packedSint64',
    },
    {
      '1': 'packed_fixed32',
      '3': 81,
      '4': 3,
      '5': 7,
      '8': {'2': true},
      '10': 'packedFixed32',
    },
    {
      '1': 'packed_fixed64',
      '3': 82,
      '4': 3,
      '5': 6,
      '8': {'2': true},
      '10': 'packedFixed64',
    },
    {
      '1': 'packed_sfixed32',
      '3': 83,
      '4': 3,
      '5': 15,
      '8': {'2': true},
      '10': 'packedSfixed32',
    },
    {
      '1': 'packed_sfixed64',
      '3': 84,
      '4': 3,
      '5': 16,
      '8': {'2': true},
      '10': 'packedSfixed64',
    },
    {
      '1': 'packed_float',
      '3': 85,
      '4': 3,
      '5': 2,
      '8': {'2': true},
      '10': 'packedFloat',
    },
    {
      '1': 'packed_double',
      '3': 86,
      '4': 3,
      '5': 1,
      '8': {'2': true},
      '10': 'packedDouble',
    },
    {
      '1': 'packed_bool',
      '3': 87,
      '4': 3,
      '5': 8,
      '8': {'2': true},
      '10': 'packedBool',
    },
    {
      '1': 'packed_nested_enum',
      '3': 88,
      '4': 3,
      '5': 14,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2.NestedEnum',
      '8': {'2': true},
      '10': 'packedNestedEnum',
    },
    {
      '1': 'unpacked_int32',
      '3': 89,
      '4': 3,
      '5': 5,
      '8': {'2': false},
      '10': 'unpackedInt32',
    },
    {
      '1': 'unpacked_int64',
      '3': 90,
      '4': 3,
      '5': 3,
      '8': {'2': false},
      '10': 'unpackedInt64',
    },
    {
      '1': 'unpacked_uint32',
      '3': 91,
      '4': 3,
      '5': 13,
      '8': {'2': false},
      '10': 'unpackedUint32',
    },
    {
      '1': 'unpacked_uint64',
      '3': 92,
      '4': 3,
      '5': 4,
      '8': {'2': false},
      '10': 'unpackedUint64',
    },
    {
      '1': 'unpacked_sint32',
      '3': 93,
      '4': 3,
      '5': 17,
      '8': {'2': false},
      '10': 'unpackedSint32',
    },
    {
      '1': 'unpacked_sint64',
      '3': 94,
      '4': 3,
      '5': 18,
      '8': {'2': false},
      '10': 'unpackedSint64',
    },
    {
      '1': 'unpacked_fixed32',
      '3': 95,
      '4': 3,
      '5': 7,
      '8': {'2': false},
      '10': 'unpackedFixed32',
    },
    {
      '1': 'unpacked_fixed64',
      '3': 96,
      '4': 3,
      '5': 6,
      '8': {'2': false},
      '10': 'unpackedFixed64',
    },
    {
      '1': 'unpacked_sfixed32',
      '3': 97,
      '4': 3,
      '5': 15,
      '8': {'2': false},
      '10': 'unpackedSfixed32',
    },
    {
      '1': 'unpacked_sfixed64',
      '3': 98,
      '4': 3,
      '5': 16,
      '8': {'2': false},
      '10': 'unpackedSfixed64',
    },
    {
      '1': 'unpacked_float',
      '3': 99,
      '4': 3,
      '5': 2,
      '8': {'2': false},
      '10': 'unpackedFloat',
    },
    {
      '1': 'unpacked_double',
      '3': 100,
      '4': 3,
      '5': 1,
      '8': {'2': false},
      '10': 'unpackedDouble',
    },
    {
      '1': 'unpacked_bool',
      '3': 101,
      '4': 3,
      '5': 8,
      '8': {'2': false},
      '10': 'unpackedBool',
    },
    {
      '1': 'unpacked_nested_enum',
      '3': 102,
      '4': 3,
      '5': 14,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2.NestedEnum',
      '8': {'2': false},
      '10': 'unpackedNestedEnum',
    },
    {
      '1': 'map_int32_int32',
      '3': 56,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapInt32Int32Entry',
      '10': 'mapInt32Int32'
    },
    {
      '1': 'map_int64_int64',
      '3': 57,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapInt64Int64Entry',
      '10': 'mapInt64Int64'
    },
    {
      '1': 'map_uint32_uint32',
      '3': 58,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapUint32Uint32Entry',
      '10': 'mapUint32Uint32'
    },
    {
      '1': 'map_uint64_uint64',
      '3': 59,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapUint64Uint64Entry',
      '10': 'mapUint64Uint64'
    },
    {
      '1': 'map_sint32_sint32',
      '3': 60,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapSint32Sint32Entry',
      '10': 'mapSint32Sint32'
    },
    {
      '1': 'map_sint64_sint64',
      '3': 61,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapSint64Sint64Entry',
      '10': 'mapSint64Sint64'
    },
    {
      '1': 'map_fixed32_fixed32',
      '3': 62,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapFixed32Fixed32Entry',
      '10': 'mapFixed32Fixed32'
    },
    {
      '1': 'map_fixed64_fixed64',
      '3': 63,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapFixed64Fixed64Entry',
      '10': 'mapFixed64Fixed64'
    },
    {
      '1': 'map_sfixed32_sfixed32',
      '3': 64,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapSfixed32Sfixed32Entry',
      '10': 'mapSfixed32Sfixed32'
    },
    {
      '1': 'map_sfixed64_sfixed64',
      '3': 65,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapSfixed64Sfixed64Entry',
      '10': 'mapSfixed64Sfixed64'
    },
    {
      '1': 'map_int32_float',
      '3': 66,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapInt32FloatEntry',
      '10': 'mapInt32Float'
    },
    {
      '1': 'map_int32_double',
      '3': 67,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapInt32DoubleEntry',
      '10': 'mapInt32Double'
    },
    {
      '1': 'map_bool_bool',
      '3': 68,
      '4': 3,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2.MapBoolBoolEntry',
      '10': 'mapBoolBool'
    },
    {
      '1': 'map_string_string',
      '3': 69,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapStringStringEntry',
      '10': 'mapStringString'
    },
    {
      '1': 'map_string_bytes',
      '3': 70,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapStringBytesEntry',
      '10': 'mapStringBytes'
    },
    {
      '1': 'map_string_nested_message',
      '3': 71,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapStringNestedMessageEntry',
      '10': 'mapStringNestedMessage'
    },
    {
      '1': 'map_string_foreign_message',
      '3': 72,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapStringForeignMessageEntry',
      '10': 'mapStringForeignMessage'
    },
    {
      '1': 'map_string_nested_enum',
      '3': 73,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapStringNestedEnumEntry',
      '10': 'mapStringNestedEnum'
    },
    {
      '1': 'map_string_foreign_enum',
      '3': 74,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MapStringForeignEnumEntry',
      '10': 'mapStringForeignEnum'
    },
    {
      '1': 'oneof_uint32',
      '3': 111,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'oneofUint32'
    },
    {
      '1': 'oneof_nested_message',
      '3': 112,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2.NestedMessage',
      '9': 0,
      '10': 'oneofNestedMessage'
    },
    {
      '1': 'oneof_string',
      '3': 113,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'oneofString'
    },
    {'1': 'oneof_bytes', '3': 114, '4': 1, '5': 12, '9': 0, '10': 'oneofBytes'},
    {'1': 'oneof_bool', '3': 115, '4': 1, '5': 8, '9': 0, '10': 'oneofBool'},
    {
      '1': 'oneof_uint64',
      '3': 116,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'oneofUint64'
    },
    {'1': 'oneof_float', '3': 117, '4': 1, '5': 2, '9': 0, '10': 'oneofFloat'},
    {
      '1': 'oneof_double',
      '3': 118,
      '4': 1,
      '5': 1,
      '9': 0,
      '10': 'oneofDouble'
    },
    {
      '1': 'oneof_enum',
      '3': 119,
      '4': 1,
      '5': 14,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2.NestedEnum',
      '9': 0,
      '10': 'oneofEnum'
    },
    {
      '1': 'data',
      '3': 201,
      '4': 1,
      '5': 10,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2.Data',
      '10': 'data'
    },
    {
      '1': 'multiwordgroupfield',
      '3': 204,
      '4': 1,
      '5': 10,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MultiWordGroupField',
      '10': 'multiwordgroupfield'
    },
    {
      '1': 'default_int32',
      '3': 241,
      '4': 1,
      '5': 5,
      '7': '-123456789',
      '10': 'defaultInt32'
    },
    {
      '1': 'default_int64',
      '3': 242,
      '4': 1,
      '5': 3,
      '7': '-9123456789123456789',
      '10': 'defaultInt64'
    },
    {
      '1': 'default_uint32',
      '3': 243,
      '4': 1,
      '5': 13,
      '7': '2123456789',
      '10': 'defaultUint32'
    },
    {
      '1': 'default_uint64',
      '3': 244,
      '4': 1,
      '5': 4,
      '7': '10123456789123456789',
      '10': 'defaultUint64'
    },
    {
      '1': 'default_sint32',
      '3': 245,
      '4': 1,
      '5': 17,
      '7': '-123456789',
      '10': 'defaultSint32'
    },
    {
      '1': 'default_sint64',
      '3': 246,
      '4': 1,
      '5': 18,
      '7': '-9123456789123456789',
      '10': 'defaultSint64'
    },
    {
      '1': 'default_fixed32',
      '3': 247,
      '4': 1,
      '5': 7,
      '7': '2123456789',
      '10': 'defaultFixed32'
    },
    {
      '1': 'default_fixed64',
      '3': 248,
      '4': 1,
      '5': 6,
      '7': '10123456789123456789',
      '10': 'defaultFixed64'
    },
    {
      '1': 'default_sfixed32',
      '3': 249,
      '4': 1,
      '5': 15,
      '7': '-123456789',
      '10': 'defaultSfixed32'
    },
    {
      '1': 'default_sfixed64',
      '3': 250,
      '4': 1,
      '5': 16,
      '7': '-9123456789123456789',
      '10': 'defaultSfixed64'
    },
    {
      '1': 'default_float',
      '3': 251,
      '4': 1,
      '5': 2,
      '7': '9e+09',
      '10': 'defaultFloat'
    },
    {
      '1': 'default_double',
      '3': 252,
      '4': 1,
      '5': 1,
      '7': '7e+22',
      '10': 'defaultDouble'
    },
    {
      '1': 'default_bool',
      '3': 253,
      '4': 1,
      '5': 8,
      '7': 'true',
      '10': 'defaultBool'
    },
    {
      '1': 'default_string',
      '3': 254,
      '4': 1,
      '5': 9,
      '7': 'Rosebud',
      '10': 'defaultString'
    },
    {
      '1': 'default_bytes',
      '3': 255,
      '4': 1,
      '5': 12,
      '7': 'joshua',
      '10': 'defaultBytes'
    },
    {'1': 'fieldname1', '3': 401, '4': 1, '5': 5, '10': 'fieldname1'},
    {'1': 'field_name2', '3': 402, '4': 1, '5': 5, '10': 'fieldName2'},
    {'1': '_field_name3', '3': 403, '4': 1, '5': 5, '10': 'FieldName3'},
    {'1': 'field__name4_', '3': 404, '4': 1, '5': 5, '10': 'fieldName4'},
    {'1': 'field0name5', '3': 405, '4': 1, '5': 5, '10': 'field0name5'},
    {'1': 'field_0_name6', '3': 406, '4': 1, '5': 5, '10': 'field0Name6'},
    {'1': 'fieldName7', '3': 407, '4': 1, '5': 5, '10': 'fieldName7'},
    {'1': 'FieldName8', '3': 408, '4': 1, '5': 5, '10': 'FieldName8'},
    {'1': 'field_Name9', '3': 409, '4': 1, '5': 5, '10': 'fieldName9'},
    {'1': 'Field_Name10', '3': 410, '4': 1, '5': 5, '10': 'FieldName10'},
    {'1': 'FIELD_NAME11', '3': 411, '4': 1, '5': 5, '10': 'FIELDNAME11'},
    {'1': 'FIELD_name12', '3': 412, '4': 1, '5': 5, '10': 'FIELDName12'},
    {'1': '__field_name13', '3': 413, '4': 1, '5': 5, '10': 'FieldName13'},
    {'1': '__Field_name14', '3': 414, '4': 1, '5': 5, '10': 'FieldName14'},
    {'1': 'field__name15', '3': 415, '4': 1, '5': 5, '10': 'fieldName15'},
    {'1': 'field__Name16', '3': 416, '4': 1, '5': 5, '10': 'fieldName16'},
    {'1': 'field_name17__', '3': 417, '4': 1, '5': 5, '10': 'fieldName17'},
    {'1': 'Field_name18__', '3': 418, '4': 1, '5': 5, '10': 'FieldName18'},
  ],
  '3': [
    TestAllTypesProto2_NestedMessage$json,
    TestAllTypesProto2_MapInt32Int32Entry$json,
    TestAllTypesProto2_MapInt64Int64Entry$json,
    TestAllTypesProto2_MapUint32Uint32Entry$json,
    TestAllTypesProto2_MapUint64Uint64Entry$json,
    TestAllTypesProto2_MapSint32Sint32Entry$json,
    TestAllTypesProto2_MapSint64Sint64Entry$json,
    TestAllTypesProto2_MapFixed32Fixed32Entry$json,
    TestAllTypesProto2_MapFixed64Fixed64Entry$json,
    TestAllTypesProto2_MapSfixed32Sfixed32Entry$json,
    TestAllTypesProto2_MapSfixed64Sfixed64Entry$json,
    TestAllTypesProto2_MapInt32FloatEntry$json,
    TestAllTypesProto2_MapInt32DoubleEntry$json,
    TestAllTypesProto2_MapBoolBoolEntry$json,
    TestAllTypesProto2_MapStringStringEntry$json,
    TestAllTypesProto2_MapStringBytesEntry$json,
    TestAllTypesProto2_MapStringNestedMessageEntry$json,
    TestAllTypesProto2_MapStringForeignMessageEntry$json,
    TestAllTypesProto2_MapStringNestedEnumEntry$json,
    TestAllTypesProto2_MapStringForeignEnumEntry$json,
    TestAllTypesProto2_Data$json,
    TestAllTypesProto2_MultiWordGroupField$json,
    TestAllTypesProto2_MessageSetCorrect$json,
    TestAllTypesProto2_MessageSetCorrectExtension1$json,
    TestAllTypesProto2_MessageSetCorrectExtension2$json
  ],
  '4': [TestAllTypesProto2_NestedEnum$json],
  '5': [
    {'1': 120, '2': 201},
  ],
  '8': [
    {'1': 'oneof_field'},
  ],
  '9': [
    {'1': 1000, '2': 10000},
  ],
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_NestedMessage$json = {
  '1': 'NestedMessage',
  '2': [
    {'1': 'a', '3': 1, '4': 1, '5': 5, '10': 'a'},
    {
      '1': 'corecursive',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2',
      '10': 'corecursive'
    },
  ],
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapInt32Int32Entry$json = {
  '1': 'MapInt32Int32Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapInt64Int64Entry$json = {
  '1': 'MapInt64Int64Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 3, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 3, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapUint32Uint32Entry$json = {
  '1': 'MapUint32Uint32Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 13, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapUint64Uint64Entry$json = {
  '1': 'MapUint64Uint64Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 4, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapSint32Sint32Entry$json = {
  '1': 'MapSint32Sint32Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 17, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 17, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapSint64Sint64Entry$json = {
  '1': 'MapSint64Sint64Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 18, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 18, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapFixed32Fixed32Entry$json = {
  '1': 'MapFixed32Fixed32Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 7, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 7, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapFixed64Fixed64Entry$json = {
  '1': 'MapFixed64Fixed64Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 6, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 6, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapSfixed32Sfixed32Entry$json = {
  '1': 'MapSfixed32Sfixed32Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 15, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 15, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapSfixed64Sfixed64Entry$json = {
  '1': 'MapSfixed64Sfixed64Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 16, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 16, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapInt32FloatEntry$json = {
  '1': 'MapInt32FloatEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 2, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapInt32DoubleEntry$json = {
  '1': 'MapInt32DoubleEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapBoolBoolEntry$json = {
  '1': 'MapBoolBoolEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 8, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 8, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapStringStringEntry$json = {
  '1': 'MapStringStringEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapStringBytesEntry$json = {
  '1': 'MapStringBytesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapStringNestedMessageEntry$json = {
  '1': 'MapStringNestedMessageEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2.NestedMessage',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapStringForeignMessageEntry$json = {
  '1': 'MapStringForeignMessageEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.ForeignMessageProto2',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapStringNestedEnumEntry$json = {
  '1': 'MapStringNestedEnumEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.protobuf_test_messages.proto2.TestAllTypesProto2.NestedEnum',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MapStringForeignEnumEntry$json = {
  '1': 'MapStringForeignEnumEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.protobuf_test_messages.proto2.ForeignEnumProto2',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_Data$json = {
  '1': 'Data',
  '2': [
    {'1': 'group_int32', '3': 202, '4': 1, '5': 5, '10': 'groupInt32'},
    {'1': 'group_uint32', '3': 203, '4': 1, '5': 13, '10': 'groupUint32'},
  ],
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MultiWordGroupField$json = {
  '1': 'MultiWordGroupField',
  '2': [
    {'1': 'group_int32', '3': 205, '4': 1, '5': 5, '10': 'groupInt32'},
    {'1': 'group_uint32', '3': 206, '4': 1, '5': 13, '10': 'groupUint32'},
  ],
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MessageSetCorrect$json = {
  '1': 'MessageSetCorrect',
  '5': [
    {'1': 4, '2': 2147483647},
  ],
  '7': {'1': true},
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MessageSetCorrectExtension1$json = {
  '1': 'MessageSetCorrectExtension1',
  '2': [
    {'1': 'str', '3': 25, '4': 1, '5': 9, '10': 'str'},
  ],
  '6': [
    {
      '1': 'message_set_extension',
      '2':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MessageSetCorrect',
      '3': 1547769,
      '4': 1,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MessageSetCorrectExtension1',
      '10': 'messageSetExtension'
    },
  ],
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_MessageSetCorrectExtension2$json = {
  '1': 'MessageSetCorrectExtension2',
  '2': [
    {'1': 'i', '3': 9, '4': 1, '5': 5, '10': 'i'},
  ],
  '6': [
    {
      '1': 'message_set_extension',
      '2':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MessageSetCorrect',
      '3': 4135312,
      '4': 1,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllTypesProto2.MessageSetCorrectExtension2',
      '10': 'messageSetExtension'
    },
  ],
};

@$core.Deprecated('Use testAllTypesProto2Descriptor instead')
const TestAllTypesProto2_NestedEnum$json = {
  '1': 'NestedEnum',
  '2': [
    {'1': 'FOO', '2': 0},
    {'1': 'BAR', '2': 1},
    {'1': 'BAZ', '2': 2},
    {'1': 'NEG', '2': -1},
  ],
};

/// Descriptor for `TestAllTypesProto2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testAllTypesProto2Descriptor = $convert.base64Decode(
    'ChJUZXN0QWxsVHlwZXNQcm90bzISJQoOb3B0aW9uYWxfaW50MzIYASABKAVSDW9wdGlvbmFsSW'
    '50MzISJQoOb3B0aW9uYWxfaW50NjQYAiABKANSDW9wdGlvbmFsSW50NjQSJwoPb3B0aW9uYWxf'
    'dWludDMyGAMgASgNUg5vcHRpb25hbFVpbnQzMhInCg9vcHRpb25hbF91aW50NjQYBCABKARSDm'
    '9wdGlvbmFsVWludDY0EicKD29wdGlvbmFsX3NpbnQzMhgFIAEoEVIOb3B0aW9uYWxTaW50MzIS'
    'JwoPb3B0aW9uYWxfc2ludDY0GAYgASgSUg5vcHRpb25hbFNpbnQ2NBIpChBvcHRpb25hbF9maX'
    'hlZDMyGAcgASgHUg9vcHRpb25hbEZpeGVkMzISKQoQb3B0aW9uYWxfZml4ZWQ2NBgIIAEoBlIP'
    'b3B0aW9uYWxGaXhlZDY0EisKEW9wdGlvbmFsX3NmaXhlZDMyGAkgASgPUhBvcHRpb25hbFNmaX'
    'hlZDMyEisKEW9wdGlvbmFsX3NmaXhlZDY0GAogASgQUhBvcHRpb25hbFNmaXhlZDY0EiUKDm9w'
    'dGlvbmFsX2Zsb2F0GAsgASgCUg1vcHRpb25hbEZsb2F0EicKD29wdGlvbmFsX2RvdWJsZRgMIA'
    'EoAVIOb3B0aW9uYWxEb3VibGUSIwoNb3B0aW9uYWxfYm9vbBgNIAEoCFIMb3B0aW9uYWxCb29s'
    'EicKD29wdGlvbmFsX3N0cmluZxgOIAEoCVIOb3B0aW9uYWxTdHJpbmcSJQoOb3B0aW9uYWxfYn'
    'l0ZXMYDyABKAxSDW9wdGlvbmFsQnl0ZXMSdwoXb3B0aW9uYWxfbmVzdGVkX21lc3NhZ2UYEiAB'
    'KAsyPy5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi5UZXN0QWxsVHlwZXNQcm90bzIuTm'
    'VzdGVkTWVzc2FnZVIVb3B0aW9uYWxOZXN0ZWRNZXNzYWdlEm0KGG9wdGlvbmFsX2ZvcmVpZ25f'
    'bWVzc2FnZRgTIAEoCzIzLnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8yLkZvcmVpZ25NZX'
    'NzYWdlUHJvdG8yUhZvcHRpb25hbEZvcmVpZ25NZXNzYWdlEm4KFG9wdGlvbmFsX25lc3RlZF9l'
    'bnVtGBUgASgOMjwucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzIuVGVzdEFsbFR5cGVzUH'
    'JvdG8yLk5lc3RlZEVudW1SEm9wdGlvbmFsTmVzdGVkRW51bRJkChVvcHRpb25hbF9mb3JlaWdu'
    'X2VudW0YFiABKA4yMC5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi5Gb3JlaWduRW51bV'
    'Byb3RvMlITb3B0aW9uYWxGb3JlaWduRW51bRI2ChVvcHRpb25hbF9zdHJpbmdfcGllY2UYGCAB'
    'KAlCAggCUhNvcHRpb25hbFN0cmluZ1BpZWNlEicKDW9wdGlvbmFsX2NvcmQYGSABKAlCAggBUg'
    'xvcHRpb25hbENvcmQSXgoRcmVjdXJzaXZlX21lc3NhZ2UYGyABKAsyMS5wcm90b2J1Zl90ZXN0'
    'X21lc3NhZ2VzLnByb3RvMi5UZXN0QWxsVHlwZXNQcm90bzJSEHJlY3Vyc2l2ZU1lc3NhZ2USJQ'
    'oOcmVwZWF0ZWRfaW50MzIYHyADKAVSDXJlcGVhdGVkSW50MzISJQoOcmVwZWF0ZWRfaW50NjQY'
    'ICADKANSDXJlcGVhdGVkSW50NjQSJwoPcmVwZWF0ZWRfdWludDMyGCEgAygNUg5yZXBlYXRlZF'
    'VpbnQzMhInCg9yZXBlYXRlZF91aW50NjQYIiADKARSDnJlcGVhdGVkVWludDY0EicKD3JlcGVh'
    'dGVkX3NpbnQzMhgjIAMoEVIOcmVwZWF0ZWRTaW50MzISJwoPcmVwZWF0ZWRfc2ludDY0GCQgAy'
    'gSUg5yZXBlYXRlZFNpbnQ2NBIpChByZXBlYXRlZF9maXhlZDMyGCUgAygHUg9yZXBlYXRlZEZp'
    'eGVkMzISKQoQcmVwZWF0ZWRfZml4ZWQ2NBgmIAMoBlIPcmVwZWF0ZWRGaXhlZDY0EisKEXJlcG'
    'VhdGVkX3NmaXhlZDMyGCcgAygPUhByZXBlYXRlZFNmaXhlZDMyEisKEXJlcGVhdGVkX3NmaXhl'
    'ZDY0GCggAygQUhByZXBlYXRlZFNmaXhlZDY0EiUKDnJlcGVhdGVkX2Zsb2F0GCkgAygCUg1yZX'
    'BlYXRlZEZsb2F0EicKD3JlcGVhdGVkX2RvdWJsZRgqIAMoAVIOcmVwZWF0ZWREb3VibGUSIwoN'
    'cmVwZWF0ZWRfYm9vbBgrIAMoCFIMcmVwZWF0ZWRCb29sEicKD3JlcGVhdGVkX3N0cmluZxgsIA'
    'MoCVIOcmVwZWF0ZWRTdHJpbmcSJQoOcmVwZWF0ZWRfYnl0ZXMYLSADKAxSDXJlcGVhdGVkQnl0'
    'ZXMSdwoXcmVwZWF0ZWRfbmVzdGVkX21lc3NhZ2UYMCADKAsyPy5wcm90b2J1Zl90ZXN0X21lc3'
    'NhZ2VzLnByb3RvMi5UZXN0QWxsVHlwZXNQcm90bzIuTmVzdGVkTWVzc2FnZVIVcmVwZWF0ZWRO'
    'ZXN0ZWRNZXNzYWdlEm0KGHJlcGVhdGVkX2ZvcmVpZ25fbWVzc2FnZRgxIAMoCzIzLnByb3RvYn'
    'VmX3Rlc3RfbWVzc2FnZXMucHJvdG8yLkZvcmVpZ25NZXNzYWdlUHJvdG8yUhZyZXBlYXRlZEZv'
    'cmVpZ25NZXNzYWdlEm4KFHJlcGVhdGVkX25lc3RlZF9lbnVtGDMgAygOMjwucHJvdG9idWZfdG'
    'VzdF9tZXNzYWdlcy5wcm90bzIuVGVzdEFsbFR5cGVzUHJvdG8yLk5lc3RlZEVudW1SEnJlcGVh'
    'dGVkTmVzdGVkRW51bRJkChVyZXBlYXRlZF9mb3JlaWduX2VudW0YNCADKA4yMC5wcm90b2J1Zl'
    '90ZXN0X21lc3NhZ2VzLnByb3RvMi5Gb3JlaWduRW51bVByb3RvMlITcmVwZWF0ZWRGb3JlaWdu'
    'RW51bRI2ChVyZXBlYXRlZF9zdHJpbmdfcGllY2UYNiADKAlCAggCUhNyZXBlYXRlZFN0cmluZ1'
    'BpZWNlEicKDXJlcGVhdGVkX2NvcmQYNyADKAlCAggBUgxyZXBlYXRlZENvcmQSJQoMcGFja2Vk'
    'X2ludDMyGEsgAygFQgIQAVILcGFja2VkSW50MzISJQoMcGFja2VkX2ludDY0GEwgAygDQgIQAV'
    'ILcGFja2VkSW50NjQSJwoNcGFja2VkX3VpbnQzMhhNIAMoDUICEAFSDHBhY2tlZFVpbnQzMhIn'
    'Cg1wYWNrZWRfdWludDY0GE4gAygEQgIQAVIMcGFja2VkVWludDY0EicKDXBhY2tlZF9zaW50Mz'
    'IYTyADKBFCAhABUgxwYWNrZWRTaW50MzISJwoNcGFja2VkX3NpbnQ2NBhQIAMoEkICEAFSDHBh'
    'Y2tlZFNpbnQ2NBIpCg5wYWNrZWRfZml4ZWQzMhhRIAMoB0ICEAFSDXBhY2tlZEZpeGVkMzISKQ'
    'oOcGFja2VkX2ZpeGVkNjQYUiADKAZCAhABUg1wYWNrZWRGaXhlZDY0EisKD3BhY2tlZF9zZml4'
    'ZWQzMhhTIAMoD0ICEAFSDnBhY2tlZFNmaXhlZDMyEisKD3BhY2tlZF9zZml4ZWQ2NBhUIAMoEE'
    'ICEAFSDnBhY2tlZFNmaXhlZDY0EiUKDHBhY2tlZF9mbG9hdBhVIAMoAkICEAFSC3BhY2tlZEZs'
    'b2F0EicKDXBhY2tlZF9kb3VibGUYViADKAFCAhABUgxwYWNrZWREb3VibGUSIwoLcGFja2VkX2'
    'Jvb2wYVyADKAhCAhABUgpwYWNrZWRCb29sEm4KEnBhY2tlZF9uZXN0ZWRfZW51bRhYIAMoDjI8'
    'LnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8yLlRlc3RBbGxUeXBlc1Byb3RvMi5OZXN0ZW'
    'RFbnVtQgIQAVIQcGFja2VkTmVzdGVkRW51bRIpCg51bnBhY2tlZF9pbnQzMhhZIAMoBUICEABS'
    'DXVucGFja2VkSW50MzISKQoOdW5wYWNrZWRfaW50NjQYWiADKANCAhAAUg11bnBhY2tlZEludD'
    'Y0EisKD3VucGFja2VkX3VpbnQzMhhbIAMoDUICEABSDnVucGFja2VkVWludDMyEisKD3VucGFj'
    'a2VkX3VpbnQ2NBhcIAMoBEICEABSDnVucGFja2VkVWludDY0EisKD3VucGFja2VkX3NpbnQzMh'
    'hdIAMoEUICEABSDnVucGFja2VkU2ludDMyEisKD3VucGFja2VkX3NpbnQ2NBheIAMoEkICEABS'
    'DnVucGFja2VkU2ludDY0Ei0KEHVucGFja2VkX2ZpeGVkMzIYXyADKAdCAhAAUg91bnBhY2tlZE'
    'ZpeGVkMzISLQoQdW5wYWNrZWRfZml4ZWQ2NBhgIAMoBkICEABSD3VucGFja2VkRml4ZWQ2NBIv'
    'ChF1bnBhY2tlZF9zZml4ZWQzMhhhIAMoD0ICEABSEHVucGFja2VkU2ZpeGVkMzISLwoRdW5wYW'
    'NrZWRfc2ZpeGVkNjQYYiADKBBCAhAAUhB1bnBhY2tlZFNmaXhlZDY0EikKDnVucGFja2VkX2Zs'
    'b2F0GGMgAygCQgIQAFINdW5wYWNrZWRGbG9hdBIrCg91bnBhY2tlZF9kb3VibGUYZCADKAFCAh'
    'AAUg51bnBhY2tlZERvdWJsZRInCg11bnBhY2tlZF9ib29sGGUgAygIQgIQAFIMdW5wYWNrZWRC'
    'b29sEnIKFHVucGFja2VkX25lc3RlZF9lbnVtGGYgAygOMjwucHJvdG9idWZfdGVzdF9tZXNzYW'
    'dlcy5wcm90bzIuVGVzdEFsbFR5cGVzUHJvdG8yLk5lc3RlZEVudW1CAhAAUhJ1bnBhY2tlZE5l'
    'c3RlZEVudW0SbAoPbWFwX2ludDMyX2ludDMyGDggAygLMkQucHJvdG9idWZfdGVzdF9tZXNzYW'
    'dlcy5wcm90bzIuVGVzdEFsbFR5cGVzUHJvdG8yLk1hcEludDMySW50MzJFbnRyeVINbWFwSW50'
    'MzJJbnQzMhJsCg9tYXBfaW50NjRfaW50NjQYOSADKAsyRC5wcm90b2J1Zl90ZXN0X21lc3NhZ2'
    'VzLnByb3RvMi5UZXN0QWxsVHlwZXNQcm90bzIuTWFwSW50NjRJbnQ2NEVudHJ5Ug1tYXBJbnQ2'
    'NEludDY0EnIKEW1hcF91aW50MzJfdWludDMyGDogAygLMkYucHJvdG9idWZfdGVzdF9tZXNzYW'
    'dlcy5wcm90bzIuVGVzdEFsbFR5cGVzUHJvdG8yLk1hcFVpbnQzMlVpbnQzMkVudHJ5Ug9tYXBV'
    'aW50MzJVaW50MzIScgoRbWFwX3VpbnQ2NF91aW50NjQYOyADKAsyRi5wcm90b2J1Zl90ZXN0X2'
    '1lc3NhZ2VzLnByb3RvMi5UZXN0QWxsVHlwZXNQcm90bzIuTWFwVWludDY0VWludDY0RW50cnlS'
    'D21hcFVpbnQ2NFVpbnQ2NBJyChFtYXBfc2ludDMyX3NpbnQzMhg8IAMoCzJGLnByb3RvYnVmX3'
    'Rlc3RfbWVzc2FnZXMucHJvdG8yLlRlc3RBbGxUeXBlc1Byb3RvMi5NYXBTaW50MzJTaW50MzJF'
    'bnRyeVIPbWFwU2ludDMyU2ludDMyEnIKEW1hcF9zaW50NjRfc2ludDY0GD0gAygLMkYucHJvdG'
    '9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzIuVGVzdEFsbFR5cGVzUHJvdG8yLk1hcFNpbnQ2NFNp'
    'bnQ2NEVudHJ5Ug9tYXBTaW50NjRTaW50NjQSeAoTbWFwX2ZpeGVkMzJfZml4ZWQzMhg+IAMoCz'
    'JILnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8yLlRlc3RBbGxUeXBlc1Byb3RvMi5NYXBG'
    'aXhlZDMyRml4ZWQzMkVudHJ5UhFtYXBGaXhlZDMyRml4ZWQzMhJ4ChNtYXBfZml4ZWQ2NF9maX'
    'hlZDY0GD8gAygLMkgucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzIuVGVzdEFsbFR5cGVz'
    'UHJvdG8yLk1hcEZpeGVkNjRGaXhlZDY0RW50cnlSEW1hcEZpeGVkNjRGaXhlZDY0En4KFW1hcF'
    '9zZml4ZWQzMl9zZml4ZWQzMhhAIAMoCzJKLnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8y'
    'LlRlc3RBbGxUeXBlc1Byb3RvMi5NYXBTZml4ZWQzMlNmaXhlZDMyRW50cnlSE21hcFNmaXhlZD'
    'MyU2ZpeGVkMzISfgoVbWFwX3NmaXhlZDY0X3NmaXhlZDY0GEEgAygLMkoucHJvdG9idWZfdGVz'
    'dF9tZXNzYWdlcy5wcm90bzIuVGVzdEFsbFR5cGVzUHJvdG8yLk1hcFNmaXhlZDY0U2ZpeGVkNj'
    'RFbnRyeVITbWFwU2ZpeGVkNjRTZml4ZWQ2NBJsCg9tYXBfaW50MzJfZmxvYXQYQiADKAsyRC5w'
    'cm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi5UZXN0QWxsVHlwZXNQcm90bzIuTWFwSW50Mz'
    'JGbG9hdEVudHJ5Ug1tYXBJbnQzMkZsb2F0Em8KEG1hcF9pbnQzMl9kb3VibGUYQyADKAsyRS5w'
    'cm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi5UZXN0QWxsVHlwZXNQcm90bzIuTWFwSW50Mz'
    'JEb3VibGVFbnRyeVIObWFwSW50MzJEb3VibGUSZgoNbWFwX2Jvb2xfYm9vbBhEIAMoCzJCLnBy'
    'b3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8yLlRlc3RBbGxUeXBlc1Byb3RvMi5NYXBCb29sQm'
    '9vbEVudHJ5UgttYXBCb29sQm9vbBJyChFtYXBfc3RyaW5nX3N0cmluZxhFIAMoCzJGLnByb3Rv'
    'YnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8yLlRlc3RBbGxUeXBlc1Byb3RvMi5NYXBTdHJpbmdTdH'
    'JpbmdFbnRyeVIPbWFwU3RyaW5nU3RyaW5nEm8KEG1hcF9zdHJpbmdfYnl0ZXMYRiADKAsyRS5w'
    'cm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi5UZXN0QWxsVHlwZXNQcm90bzIuTWFwU3RyaW'
    '5nQnl0ZXNFbnRyeVIObWFwU3RyaW5nQnl0ZXMSiAEKGW1hcF9zdHJpbmdfbmVzdGVkX21lc3Nh'
    'Z2UYRyADKAsyTS5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi5UZXN0QWxsVHlwZXNQcm'
    '90bzIuTWFwU3RyaW5nTmVzdGVkTWVzc2FnZUVudHJ5UhZtYXBTdHJpbmdOZXN0ZWRNZXNzYWdl'
    'EosBChptYXBfc3RyaW5nX2ZvcmVpZ25fbWVzc2FnZRhIIAMoCzJOLnByb3RvYnVmX3Rlc3RfbW'
    'Vzc2FnZXMucHJvdG8yLlRlc3RBbGxUeXBlc1Byb3RvMi5NYXBTdHJpbmdGb3JlaWduTWVzc2Fn'
    'ZUVudHJ5UhdtYXBTdHJpbmdGb3JlaWduTWVzc2FnZRJ/ChZtYXBfc3RyaW5nX25lc3RlZF9lbn'
    'VtGEkgAygLMkoucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzIuVGVzdEFsbFR5cGVzUHJv'
    'dG8yLk1hcFN0cmluZ05lc3RlZEVudW1FbnRyeVITbWFwU3RyaW5nTmVzdGVkRW51bRKCAQoXbW'
    'FwX3N0cmluZ19mb3JlaWduX2VudW0YSiADKAsySy5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnBy'
    'b3RvMi5UZXN0QWxsVHlwZXNQcm90bzIuTWFwU3RyaW5nRm9yZWlnbkVudW1FbnRyeVIUbWFwU3'
    'RyaW5nRm9yZWlnbkVudW0SIwoMb25lb2ZfdWludDMyGG8gASgNSABSC29uZW9mVWludDMyEnMK'
    'FG9uZW9mX25lc3RlZF9tZXNzYWdlGHAgASgLMj8ucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm'
    '90bzIuVGVzdEFsbFR5cGVzUHJvdG8yLk5lc3RlZE1lc3NhZ2VIAFISb25lb2ZOZXN0ZWRNZXNz'
    'YWdlEiMKDG9uZW9mX3N0cmluZxhxIAEoCUgAUgtvbmVvZlN0cmluZxIhCgtvbmVvZl9ieXRlcx'
    'hyIAEoDEgAUgpvbmVvZkJ5dGVzEh8KCm9uZW9mX2Jvb2wYcyABKAhIAFIJb25lb2ZCb29sEiMK'
    'DG9uZW9mX3VpbnQ2NBh0IAEoBEgAUgtvbmVvZlVpbnQ2NBIhCgtvbmVvZl9mbG9hdBh1IAEoAk'
    'gAUgpvbmVvZkZsb2F0EiMKDG9uZW9mX2RvdWJsZRh2IAEoAUgAUgtvbmVvZkRvdWJsZRJdCgpv'
    'bmVvZl9lbnVtGHcgASgOMjwucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzIuVGVzdEFsbF'
    'R5cGVzUHJvdG8yLk5lc3RlZEVudW1IAFIJb25lb2ZFbnVtEksKBGRhdGEYyQEgASgKMjYucHJv'
    'dG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzIuVGVzdEFsbFR5cGVzUHJvdG8yLkRhdGFSBGRhdG'
    'ESeAoTbXVsdGl3b3JkZ3JvdXBmaWVsZBjMASABKAoyRS5wcm90b2J1Zl90ZXN0X21lc3NhZ2Vz'
    'LnByb3RvMi5UZXN0QWxsVHlwZXNQcm90bzIuTXVsdGlXb3JkR3JvdXBGaWVsZFITbXVsdGl3b3'
    'JkZ3JvdXBmaWVsZBIwCg1kZWZhdWx0X2ludDMyGPEBIAEoBToKLTEyMzQ1Njc4OVIMZGVmYXVs'
    'dEludDMyEjoKDWRlZmF1bHRfaW50NjQY8gEgASgDOhQtOTEyMzQ1Njc4OTEyMzQ1Njc4OVIMZG'
    'VmYXVsdEludDY0EjIKDmRlZmF1bHRfdWludDMyGPMBIAEoDToKMjEyMzQ1Njc4OVINZGVmYXVs'
    'dFVpbnQzMhI8Cg5kZWZhdWx0X3VpbnQ2NBj0ASABKAQ6FDEwMTIzNDU2Nzg5MTIzNDU2Nzg5Ug'
    '1kZWZhdWx0VWludDY0EjIKDmRlZmF1bHRfc2ludDMyGPUBIAEoEToKLTEyMzQ1Njc4OVINZGVm'
    'YXVsdFNpbnQzMhI8Cg5kZWZhdWx0X3NpbnQ2NBj2ASABKBI6FC05MTIzNDU2Nzg5MTIzNDU2Nz'
    'g5Ug1kZWZhdWx0U2ludDY0EjQKD2RlZmF1bHRfZml4ZWQzMhj3ASABKAc6CjIxMjM0NTY3ODlS'
    'DmRlZmF1bHRGaXhlZDMyEj4KD2RlZmF1bHRfZml4ZWQ2NBj4ASABKAY6FDEwMTIzNDU2Nzg5MT'
    'IzNDU2Nzg5Ug5kZWZhdWx0Rml4ZWQ2NBI2ChBkZWZhdWx0X3NmaXhlZDMyGPkBIAEoDzoKLTEy'
    'MzQ1Njc4OVIPZGVmYXVsdFNmaXhlZDMyEkAKEGRlZmF1bHRfc2ZpeGVkNjQY+gEgASgQOhQtOT'
    'EyMzQ1Njc4OTEyMzQ1Njc4OVIPZGVmYXVsdFNmaXhlZDY0EisKDWRlZmF1bHRfZmxvYXQY+wEg'
    'ASgCOgU5ZSswOVIMZGVmYXVsdEZsb2F0Ei0KDmRlZmF1bHRfZG91YmxlGPwBIAEoAToFN2UrMj'
    'JSDWRlZmF1bHREb3VibGUSKAoMZGVmYXVsdF9ib29sGP0BIAEoCDoEdHJ1ZVILZGVmYXVsdEJv'
    'b2wSLwoOZGVmYXVsdF9zdHJpbmcY/gEgASgJOgdSb3NlYnVkUg1kZWZhdWx0U3RyaW5nEiwKDW'
    'RlZmF1bHRfYnl0ZXMY/wEgASgMOgZqb3NodWFSDGRlZmF1bHRCeXRlcxIfCgpmaWVsZG5hbWUx'
    'GJEDIAEoBVIKZmllbGRuYW1lMRIgCgtmaWVsZF9uYW1lMhiSAyABKAVSCmZpZWxkTmFtZTISIQ'
    'oMX2ZpZWxkX25hbWUzGJMDIAEoBVIKRmllbGROYW1lMxIiCg1maWVsZF9fbmFtZTRfGJQDIAEo'
    'BVIKZmllbGROYW1lNBIhCgtmaWVsZDBuYW1lNRiVAyABKAVSC2ZpZWxkMG5hbWU1EiMKDWZpZW'
    'xkXzBfbmFtZTYYlgMgASgFUgtmaWVsZDBOYW1lNhIfCgpmaWVsZE5hbWU3GJcDIAEoBVIKZmll'
    'bGROYW1lNxIfCgpGaWVsZE5hbWU4GJgDIAEoBVIKRmllbGROYW1lOBIgCgtmaWVsZF9OYW1lOR'
    'iZAyABKAVSCmZpZWxkTmFtZTkSIgoMRmllbGRfTmFtZTEwGJoDIAEoBVILRmllbGROYW1lMTAS'
    'IgoMRklFTERfTkFNRTExGJsDIAEoBVILRklFTEROQU1FMTESIgoMRklFTERfbmFtZTEyGJwDIA'
    'EoBVILRklFTEROYW1lMTISJAoOX19maWVsZF9uYW1lMTMYnQMgASgFUgtGaWVsZE5hbWUxMxIk'
    'Cg5fX0ZpZWxkX25hbWUxNBieAyABKAVSC0ZpZWxkTmFtZTE0EiMKDWZpZWxkX19uYW1lMTUYnw'
    'MgASgFUgtmaWVsZE5hbWUxNRIjCg1maWVsZF9fTmFtZTE2GKADIAEoBVILZmllbGROYW1lMTYS'
    'JAoOZmllbGRfbmFtZTE3X18YoQMgASgFUgtmaWVsZE5hbWUxNxIkCg5GaWVsZF9uYW1lMThfXx'
    'iiAyABKAVSC0ZpZWxkTmFtZTE4GnIKDU5lc3RlZE1lc3NhZ2USDAoBYRgBIAEoBVIBYRJTCgtj'
    'b3JlY3Vyc2l2ZRgCIAEoCzIxLnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8yLlRlc3RBbG'
    'xUeXBlc1Byb3RvMlILY29yZWN1cnNpdmUaQAoSTWFwSW50MzJJbnQzMkVudHJ5EhAKA2tleRgB'
    'IAEoBVIDa2V5EhQKBXZhbHVlGAIgASgFUgV2YWx1ZToCOAEaQAoSTWFwSW50NjRJbnQ2NEVudH'
    'J5EhAKA2tleRgBIAEoA1IDa2V5EhQKBXZhbHVlGAIgASgDUgV2YWx1ZToCOAEaQgoUTWFwVWlu'
    'dDMyVWludDMyRW50cnkSEAoDa2V5GAEgASgNUgNrZXkSFAoFdmFsdWUYAiABKA1SBXZhbHVlOg'
    'I4ARpCChRNYXBVaW50NjRVaW50NjRFbnRyeRIQCgNrZXkYASABKARSA2tleRIUCgV2YWx1ZRgC'
    'IAEoBFIFdmFsdWU6AjgBGkIKFE1hcFNpbnQzMlNpbnQzMkVudHJ5EhAKA2tleRgBIAEoEVIDa2'
    'V5EhQKBXZhbHVlGAIgASgRUgV2YWx1ZToCOAEaQgoUTWFwU2ludDY0U2ludDY0RW50cnkSEAoD'
    'a2V5GAEgASgSUgNrZXkSFAoFdmFsdWUYAiABKBJSBXZhbHVlOgI4ARpEChZNYXBGaXhlZDMyRm'
    'l4ZWQzMkVudHJ5EhAKA2tleRgBIAEoB1IDa2V5EhQKBXZhbHVlGAIgASgHUgV2YWx1ZToCOAEa'
    'RAoWTWFwRml4ZWQ2NEZpeGVkNjRFbnRyeRIQCgNrZXkYASABKAZSA2tleRIUCgV2YWx1ZRgCIA'
    'EoBlIFdmFsdWU6AjgBGkYKGE1hcFNmaXhlZDMyU2ZpeGVkMzJFbnRyeRIQCgNrZXkYASABKA9S'
    'A2tleRIUCgV2YWx1ZRgCIAEoD1IFdmFsdWU6AjgBGkYKGE1hcFNmaXhlZDY0U2ZpeGVkNjRFbn'
    'RyeRIQCgNrZXkYASABKBBSA2tleRIUCgV2YWx1ZRgCIAEoEFIFdmFsdWU6AjgBGkAKEk1hcElu'
    'dDMyRmxvYXRFbnRyeRIQCgNrZXkYASABKAVSA2tleRIUCgV2YWx1ZRgCIAEoAlIFdmFsdWU6Aj'
    'gBGkEKE01hcEludDMyRG91YmxlRW50cnkSEAoDa2V5GAEgASgFUgNrZXkSFAoFdmFsdWUYAiAB'
    'KAFSBXZhbHVlOgI4ARo+ChBNYXBCb29sQm9vbEVudHJ5EhAKA2tleRgBIAEoCFIDa2V5EhQKBX'
    'ZhbHVlGAIgASgIUgV2YWx1ZToCOAEaQgoUTWFwU3RyaW5nU3RyaW5nRW50cnkSEAoDa2V5GAEg'
    'ASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARpBChNNYXBTdHJpbmdCeXRlc0VudH'
    'J5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgMUgV2YWx1ZToCOAEaigEKG01hcFN0'
    'cmluZ05lc3RlZE1lc3NhZ2VFbnRyeRIQCgNrZXkYASABKAlSA2tleRJVCgV2YWx1ZRgCIAEoCz'
    'I/LnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8yLlRlc3RBbGxUeXBlc1Byb3RvMi5OZXN0'
    'ZWRNZXNzYWdlUgV2YWx1ZToCOAEafwocTWFwU3RyaW5nRm9yZWlnbk1lc3NhZ2VFbnRyeRIQCg'
    'NrZXkYASABKAlSA2tleRJJCgV2YWx1ZRgCIAEoCzIzLnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMu'
    'cHJvdG8yLkZvcmVpZ25NZXNzYWdlUHJvdG8yUgV2YWx1ZToCOAEahAEKGE1hcFN0cmluZ05lc3'
    'RlZEVudW1FbnRyeRIQCgNrZXkYASABKAlSA2tleRJSCgV2YWx1ZRgCIAEoDjI8LnByb3RvYnVm'
    'X3Rlc3RfbWVzc2FnZXMucHJvdG8yLlRlc3RBbGxUeXBlc1Byb3RvMi5OZXN0ZWRFbnVtUgV2YW'
    'x1ZToCOAEaeQoZTWFwU3RyaW5nRm9yZWlnbkVudW1FbnRyeRIQCgNrZXkYASABKAlSA2tleRJG'
    'CgV2YWx1ZRgCIAEoDjIwLnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8yLkZvcmVpZ25Fbn'
    'VtUHJvdG8yUgV2YWx1ZToCOAEaTAoERGF0YRIgCgtncm91cF9pbnQzMhjKASABKAVSCmdyb3Vw'
    'SW50MzISIgoMZ3JvdXBfdWludDMyGMsBIAEoDVILZ3JvdXBVaW50MzIaWwoTTXVsdGlXb3JkR3'
    'JvdXBGaWVsZBIgCgtncm91cF9pbnQzMhjNASABKAVSCmdyb3VwSW50MzISIgoMZ3JvdXBfdWlu'
    'dDMyGM4BIAEoDVILZ3JvdXBVaW50MzIaIQoRTWVzc2FnZVNldENvcnJlY3QqCAgEEP////8HOg'
    'IIARr6AQobTWVzc2FnZVNldENvcnJlY3RFeHRlbnNpb24xEhAKA3N0chgZIAEoCVIDc3RyMsgB'
    'ChVtZXNzYWdlX3NldF9leHRlbnNpb24SQy5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi'
    '5UZXN0QWxsVHlwZXNQcm90bzIuTWVzc2FnZVNldENvcnJlY3QY+bteIAEoCzJNLnByb3RvYnVm'
    'X3Rlc3RfbWVzc2FnZXMucHJvdG8yLlRlc3RBbGxUeXBlc1Byb3RvMi5NZXNzYWdlU2V0Q29ycm'
    'VjdEV4dGVuc2lvbjFSE21lc3NhZ2VTZXRFeHRlbnNpb24a9wEKG01lc3NhZ2VTZXRDb3JyZWN0'
    'RXh0ZW5zaW9uMhIMCgFpGAkgASgFUgFpMskBChVtZXNzYWdlX3NldF9leHRlbnNpb24SQy5wcm'
    '90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi5UZXN0QWxsVHlwZXNQcm90bzIuTWVzc2FnZVNl'
    'dENvcnJlY3QYkLP8ASABKAsyTS5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi5UZXN0QW'
    'xsVHlwZXNQcm90bzIuTWVzc2FnZVNldENvcnJlY3RFeHRlbnNpb24yUhNtZXNzYWdlU2V0RXh0'
    'ZW5zaW9uIjkKCk5lc3RlZEVudW0SBwoDRk9PEAASBwoDQkFSEAESBwoDQkFaEAISEAoDTkVHEP'
    '///////////wEqBQh4EMkBQg0KC29uZW9mX2ZpZWxkSgYI6AcQkE4=');

@$core.Deprecated('Use foreignMessageProto2Descriptor instead')
const ForeignMessageProto2$json = {
  '1': 'ForeignMessageProto2',
  '2': [
    {'1': 'c', '3': 1, '4': 1, '5': 5, '10': 'c'},
  ],
};

/// Descriptor for `ForeignMessageProto2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List foreignMessageProto2Descriptor =
    $convert.base64Decode('ChRGb3JlaWduTWVzc2FnZVByb3RvMhIMCgFjGAEgASgFUgFj');

@$core.Deprecated('Use groupFieldDescriptor instead')
const GroupField$json = {
  '1': 'GroupField',
  '2': [
    {'1': 'group_int32', '3': 122, '4': 1, '5': 5, '10': 'groupInt32'},
    {'1': 'group_uint32', '3': 123, '4': 1, '5': 13, '10': 'groupUint32'},
  ],
};

/// Descriptor for `GroupField`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupFieldDescriptor = $convert.base64Decode(
    'CgpHcm91cEZpZWxkEh8KC2dyb3VwX2ludDMyGHogASgFUgpncm91cEludDMyEiEKDGdyb3VwX3'
    'VpbnQzMhh7IAEoDVILZ3JvdXBVaW50MzI=');

@$core.Deprecated('Use unknownToTestAllTypesDescriptor instead')
const UnknownToTestAllTypes$json = {
  '1': 'UnknownToTestAllTypes',
  '2': [
    {'1': 'optional_int32', '3': 1001, '4': 1, '5': 5, '10': 'optionalInt32'},
    {'1': 'optional_string', '3': 1002, '4': 1, '5': 9, '10': 'optionalString'},
    {
      '1': 'nested_message',
      '3': 1003,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.ForeignMessageProto2',
      '10': 'nestedMessage'
    },
    {
      '1': 'optionalgroup',
      '3': 1004,
      '4': 1,
      '5': 10,
      '6': '.protobuf_test_messages.proto2.UnknownToTestAllTypes.OptionalGroup',
      '10': 'optionalgroup'
    },
    {'1': 'optional_bool', '3': 1006, '4': 1, '5': 8, '10': 'optionalBool'},
    {'1': 'repeated_int32', '3': 1011, '4': 3, '5': 5, '10': 'repeatedInt32'},
  ],
  '3': [UnknownToTestAllTypes_OptionalGroup$json],
};

@$core.Deprecated('Use unknownToTestAllTypesDescriptor instead')
const UnknownToTestAllTypes_OptionalGroup$json = {
  '1': 'OptionalGroup',
  '2': [
    {'1': 'a', '3': 1, '4': 1, '5': 5, '10': 'a'},
  ],
};

/// Descriptor for `UnknownToTestAllTypes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unknownToTestAllTypesDescriptor = $convert.base64Decode(
    'ChVVbmtub3duVG9UZXN0QWxsVHlwZXMSJgoOb3B0aW9uYWxfaW50MzIY6QcgASgFUg1vcHRpb2'
    '5hbEludDMyEigKD29wdGlvbmFsX3N0cmluZxjqByABKAlSDm9wdGlvbmFsU3RyaW5nElsKDm5l'
    'c3RlZF9tZXNzYWdlGOsHIAEoCzIzLnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8yLkZvcm'
    'VpZ25NZXNzYWdlUHJvdG8yUg1uZXN0ZWRNZXNzYWdlEmkKDW9wdGlvbmFsZ3JvdXAY7AcgASgK'
    'MkIucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzIuVW5rbm93blRvVGVzdEFsbFR5cGVzLk'
    '9wdGlvbmFsR3JvdXBSDW9wdGlvbmFsZ3JvdXASJAoNb3B0aW9uYWxfYm9vbBjuByABKAhSDG9w'
    'dGlvbmFsQm9vbBImCg5yZXBlYXRlZF9pbnQzMhjzByADKAVSDXJlcGVhdGVkSW50MzIaHQoNT3'
    'B0aW9uYWxHcm91cBIMCgFhGAEgASgFUgFh');

@$core.Deprecated('Use nullHypothesisProto2Descriptor instead')
const NullHypothesisProto2$json = {
  '1': 'NullHypothesisProto2',
};

/// Descriptor for `NullHypothesisProto2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nullHypothesisProto2Descriptor =
    $convert.base64Decode('ChROdWxsSHlwb3RoZXNpc1Byb3RvMg==');

@$core.Deprecated('Use enumOnlyProto2Descriptor instead')
const EnumOnlyProto2$json = {
  '1': 'EnumOnlyProto2',
  '4': [EnumOnlyProto2_Bool$json],
};

@$core.Deprecated('Use enumOnlyProto2Descriptor instead')
const EnumOnlyProto2_Bool$json = {
  '1': 'Bool',
  '2': [
    {'1': 'kFalse', '2': 0},
    {'1': 'kTrue', '2': 1},
  ],
};

/// Descriptor for `EnumOnlyProto2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enumOnlyProto2Descriptor = $convert.base64Decode(
    'Cg5FbnVtT25seVByb3RvMiIdCgRCb29sEgoKBmtGYWxzZRAAEgkKBWtUcnVlEAE=');

@$core.Deprecated('Use oneStringProto2Descriptor instead')
const OneStringProto2$json = {
  '1': 'OneStringProto2',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `OneStringProto2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oneStringProto2Descriptor = $convert
    .base64Decode('Cg9PbmVTdHJpbmdQcm90bzISEgoEZGF0YRgBIAEoCVIEZGF0YQ==');

@$core.Deprecated('Use protoWithKeywordsDescriptor instead')
const ProtoWithKeywords$json = {
  '1': 'ProtoWithKeywords',
  '2': [
    {'1': 'inline', '3': 1, '4': 1, '5': 5, '10': 'inline'},
    {'1': 'concept', '3': 2, '4': 1, '5': 9, '10': 'concept'},
    {'1': 'requires', '3': 3, '4': 3, '5': 9, '10': 'requires'},
  ],
};

/// Descriptor for `ProtoWithKeywords`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoWithKeywordsDescriptor = $convert.base64Decode(
    'ChFQcm90b1dpdGhLZXl3b3JkcxIWCgZpbmxpbmUYASABKAVSBmlubGluZRIYCgdjb25jZXB0GA'
    'IgASgJUgdjb25jZXB0EhoKCHJlcXVpcmVzGAMgAygJUghyZXF1aXJlcw==');

@$core.Deprecated('Use testAllRequiredTypesProto2Descriptor instead')
const TestAllRequiredTypesProto2$json = {
  '1': 'TestAllRequiredTypesProto2',
  '2': [
    {'1': 'required_int32', '3': 1, '4': 2, '5': 5, '10': 'requiredInt32'},
    {'1': 'required_int64', '3': 2, '4': 2, '5': 3, '10': 'requiredInt64'},
    {'1': 'required_uint32', '3': 3, '4': 2, '5': 13, '10': 'requiredUint32'},
    {'1': 'required_uint64', '3': 4, '4': 2, '5': 4, '10': 'requiredUint64'},
    {'1': 'required_sint32', '3': 5, '4': 2, '5': 17, '10': 'requiredSint32'},
    {'1': 'required_sint64', '3': 6, '4': 2, '5': 18, '10': 'requiredSint64'},
    {'1': 'required_fixed32', '3': 7, '4': 2, '5': 7, '10': 'requiredFixed32'},
    {'1': 'required_fixed64', '3': 8, '4': 2, '5': 6, '10': 'requiredFixed64'},
    {
      '1': 'required_sfixed32',
      '3': 9,
      '4': 2,
      '5': 15,
      '10': 'requiredSfixed32'
    },
    {
      '1': 'required_sfixed64',
      '3': 10,
      '4': 2,
      '5': 16,
      '10': 'requiredSfixed64'
    },
    {'1': 'required_float', '3': 11, '4': 2, '5': 2, '10': 'requiredFloat'},
    {'1': 'required_double', '3': 12, '4': 2, '5': 1, '10': 'requiredDouble'},
    {'1': 'required_bool', '3': 13, '4': 2, '5': 8, '10': 'requiredBool'},
    {'1': 'required_string', '3': 14, '4': 2, '5': 9, '10': 'requiredString'},
    {'1': 'required_bytes', '3': 15, '4': 2, '5': 12, '10': 'requiredBytes'},
    {
      '1': 'required_nested_message',
      '3': 18,
      '4': 2,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllRequiredTypesProto2.NestedMessage',
      '10': 'requiredNestedMessage'
    },
    {
      '1': 'required_foreign_message',
      '3': 19,
      '4': 2,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.ForeignMessageProto2',
      '10': 'requiredForeignMessage'
    },
    {
      '1': 'required_nested_enum',
      '3': 21,
      '4': 2,
      '5': 14,
      '6':
          '.protobuf_test_messages.proto2.TestAllRequiredTypesProto2.NestedEnum',
      '10': 'requiredNestedEnum'
    },
    {
      '1': 'required_foreign_enum',
      '3': 22,
      '4': 2,
      '5': 14,
      '6': '.protobuf_test_messages.proto2.ForeignEnumProto2',
      '10': 'requiredForeignEnum'
    },
    {
      '1': 'required_string_piece',
      '3': 24,
      '4': 2,
      '5': 9,
      '8': {'1': 2},
      '10': 'requiredStringPiece',
    },
    {
      '1': 'required_cord',
      '3': 25,
      '4': 2,
      '5': 9,
      '8': {'1': 1},
      '10': 'requiredCord',
    },
    {
      '1': 'recursive_message',
      '3': 27,
      '4': 2,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.TestAllRequiredTypesProto2',
      '10': 'recursiveMessage'
    },
    {
      '1': 'optional_recursive_message',
      '3': 28,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.TestAllRequiredTypesProto2',
      '10': 'optionalRecursiveMessage'
    },
    {
      '1': 'data',
      '3': 201,
      '4': 2,
      '5': 10,
      '6': '.protobuf_test_messages.proto2.TestAllRequiredTypesProto2.Data',
      '10': 'data'
    },
    {
      '1': 'default_int32',
      '3': 241,
      '4': 2,
      '5': 5,
      '7': '-123456789',
      '10': 'defaultInt32'
    },
    {
      '1': 'default_int64',
      '3': 242,
      '4': 2,
      '5': 3,
      '7': '-9123456789123456789',
      '10': 'defaultInt64'
    },
    {
      '1': 'default_uint32',
      '3': 243,
      '4': 2,
      '5': 13,
      '7': '2123456789',
      '10': 'defaultUint32'
    },
    {
      '1': 'default_uint64',
      '3': 244,
      '4': 2,
      '5': 4,
      '7': '10123456789123456789',
      '10': 'defaultUint64'
    },
    {
      '1': 'default_sint32',
      '3': 245,
      '4': 2,
      '5': 17,
      '7': '-123456789',
      '10': 'defaultSint32'
    },
    {
      '1': 'default_sint64',
      '3': 246,
      '4': 2,
      '5': 18,
      '7': '-9123456789123456789',
      '10': 'defaultSint64'
    },
    {
      '1': 'default_fixed32',
      '3': 247,
      '4': 2,
      '5': 7,
      '7': '2123456789',
      '10': 'defaultFixed32'
    },
    {
      '1': 'default_fixed64',
      '3': 248,
      '4': 2,
      '5': 6,
      '7': '10123456789123456789',
      '10': 'defaultFixed64'
    },
    {
      '1': 'default_sfixed32',
      '3': 249,
      '4': 2,
      '5': 15,
      '7': '-123456789',
      '10': 'defaultSfixed32'
    },
    {
      '1': 'default_sfixed64',
      '3': 250,
      '4': 2,
      '5': 16,
      '7': '-9123456789123456789',
      '10': 'defaultSfixed64'
    },
    {
      '1': 'default_float',
      '3': 251,
      '4': 2,
      '5': 2,
      '7': '9e+09',
      '10': 'defaultFloat'
    },
    {
      '1': 'default_double',
      '3': 252,
      '4': 2,
      '5': 1,
      '7': '7e+22',
      '10': 'defaultDouble'
    },
    {
      '1': 'default_bool',
      '3': 253,
      '4': 2,
      '5': 8,
      '7': 'true',
      '10': 'defaultBool'
    },
    {
      '1': 'default_string',
      '3': 254,
      '4': 2,
      '5': 9,
      '7': 'Rosebud',
      '10': 'defaultString'
    },
    {
      '1': 'default_bytes',
      '3': 255,
      '4': 2,
      '5': 12,
      '7': 'joshua',
      '10': 'defaultBytes'
    },
  ],
  '3': [
    TestAllRequiredTypesProto2_NestedMessage$json,
    TestAllRequiredTypesProto2_Data$json,
    TestAllRequiredTypesProto2_MessageSetCorrect$json,
    TestAllRequiredTypesProto2_MessageSetCorrectExtension1$json,
    TestAllRequiredTypesProto2_MessageSetCorrectExtension2$json
  ],
  '4': [TestAllRequiredTypesProto2_NestedEnum$json],
  '5': [
    {'1': 120, '2': 201},
  ],
  '9': [
    {'1': 1000, '2': 10000},
  ],
};

@$core.Deprecated('Use testAllRequiredTypesProto2Descriptor instead')
const TestAllRequiredTypesProto2_NestedMessage$json = {
  '1': 'NestedMessage',
  '2': [
    {'1': 'a', '3': 1, '4': 2, '5': 5, '10': 'a'},
    {
      '1': 'corecursive',
      '3': 2,
      '4': 2,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.TestAllRequiredTypesProto2',
      '10': 'corecursive'
    },
    {
      '1': 'optional_corecursive',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto2.TestAllRequiredTypesProto2',
      '10': 'optionalCorecursive'
    },
  ],
};

@$core.Deprecated('Use testAllRequiredTypesProto2Descriptor instead')
const TestAllRequiredTypesProto2_Data$json = {
  '1': 'Data',
  '2': [
    {'1': 'group_int32', '3': 202, '4': 2, '5': 5, '10': 'groupInt32'},
    {'1': 'group_uint32', '3': 203, '4': 2, '5': 13, '10': 'groupUint32'},
  ],
};

@$core.Deprecated('Use testAllRequiredTypesProto2Descriptor instead')
const TestAllRequiredTypesProto2_MessageSetCorrect$json = {
  '1': 'MessageSetCorrect',
  '5': [
    {'1': 4, '2': 2147483647},
  ],
  '7': {'1': true},
};

@$core.Deprecated('Use testAllRequiredTypesProto2Descriptor instead')
const TestAllRequiredTypesProto2_MessageSetCorrectExtension1$json = {
  '1': 'MessageSetCorrectExtension1',
  '2': [
    {'1': 'str', '3': 25, '4': 2, '5': 9, '10': 'str'},
  ],
  '6': [
    {
      '1': 'message_set_extension',
      '2':
          '.protobuf_test_messages.proto2.TestAllRequiredTypesProto2.MessageSetCorrect',
      '3': 1547769,
      '4': 1,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllRequiredTypesProto2.MessageSetCorrectExtension1',
      '10': 'messageSetExtension'
    },
  ],
};

@$core.Deprecated('Use testAllRequiredTypesProto2Descriptor instead')
const TestAllRequiredTypesProto2_MessageSetCorrectExtension2$json = {
  '1': 'MessageSetCorrectExtension2',
  '2': [
    {'1': 'i', '3': 9, '4': 2, '5': 5, '10': 'i'},
  ],
  '6': [
    {
      '1': 'message_set_extension',
      '2':
          '.protobuf_test_messages.proto2.TestAllRequiredTypesProto2.MessageSetCorrect',
      '3': 4135312,
      '4': 1,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto2.TestAllRequiredTypesProto2.MessageSetCorrectExtension2',
      '10': 'messageSetExtension'
    },
  ],
};

@$core.Deprecated('Use testAllRequiredTypesProto2Descriptor instead')
const TestAllRequiredTypesProto2_NestedEnum$json = {
  '1': 'NestedEnum',
  '2': [
    {'1': 'FOO', '2': 0},
    {'1': 'BAR', '2': 1},
    {'1': 'BAZ', '2': 2},
    {'1': 'NEG', '2': -1},
  ],
};

/// Descriptor for `TestAllRequiredTypesProto2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testAllRequiredTypesProto2Descriptor = $convert.base64Decode(
    'ChpUZXN0QWxsUmVxdWlyZWRUeXBlc1Byb3RvMhIlCg5yZXF1aXJlZF9pbnQzMhgBIAIoBVINcm'
    'VxdWlyZWRJbnQzMhIlCg5yZXF1aXJlZF9pbnQ2NBgCIAIoA1INcmVxdWlyZWRJbnQ2NBInCg9y'
    'ZXF1aXJlZF91aW50MzIYAyACKA1SDnJlcXVpcmVkVWludDMyEicKD3JlcXVpcmVkX3VpbnQ2NB'
    'gEIAIoBFIOcmVxdWlyZWRVaW50NjQSJwoPcmVxdWlyZWRfc2ludDMyGAUgAigRUg5yZXF1aXJl'
    'ZFNpbnQzMhInCg9yZXF1aXJlZF9zaW50NjQYBiACKBJSDnJlcXVpcmVkU2ludDY0EikKEHJlcX'
    'VpcmVkX2ZpeGVkMzIYByACKAdSD3JlcXVpcmVkRml4ZWQzMhIpChByZXF1aXJlZF9maXhlZDY0'
    'GAggAigGUg9yZXF1aXJlZEZpeGVkNjQSKwoRcmVxdWlyZWRfc2ZpeGVkMzIYCSACKA9SEHJlcX'
    'VpcmVkU2ZpeGVkMzISKwoRcmVxdWlyZWRfc2ZpeGVkNjQYCiACKBBSEHJlcXVpcmVkU2ZpeGVk'
    'NjQSJQoOcmVxdWlyZWRfZmxvYXQYCyACKAJSDXJlcXVpcmVkRmxvYXQSJwoPcmVxdWlyZWRfZG'
    '91YmxlGAwgAigBUg5yZXF1aXJlZERvdWJsZRIjCg1yZXF1aXJlZF9ib29sGA0gAigIUgxyZXF1'
    'aXJlZEJvb2wSJwoPcmVxdWlyZWRfc3RyaW5nGA4gAigJUg5yZXF1aXJlZFN0cmluZxIlCg5yZX'
    'F1aXJlZF9ieXRlcxgPIAIoDFINcmVxdWlyZWRCeXRlcxJ/ChdyZXF1aXJlZF9uZXN0ZWRfbWVz'
    'c2FnZRgSIAIoCzJHLnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8yLlRlc3RBbGxSZXF1aX'
    'JlZFR5cGVzUHJvdG8yLk5lc3RlZE1lc3NhZ2VSFXJlcXVpcmVkTmVzdGVkTWVzc2FnZRJtChhy'
    'ZXF1aXJlZF9mb3JlaWduX21lc3NhZ2UYEyACKAsyMy5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLn'
    'Byb3RvMi5Gb3JlaWduTWVzc2FnZVByb3RvMlIWcmVxdWlyZWRGb3JlaWduTWVzc2FnZRJ2ChRy'
    'ZXF1aXJlZF9uZXN0ZWRfZW51bRgVIAIoDjJELnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG'
    '8yLlRlc3RBbGxSZXF1aXJlZFR5cGVzUHJvdG8yLk5lc3RlZEVudW1SEnJlcXVpcmVkTmVzdGVk'
    'RW51bRJkChVyZXF1aXJlZF9mb3JlaWduX2VudW0YFiACKA4yMC5wcm90b2J1Zl90ZXN0X21lc3'
    'NhZ2VzLnByb3RvMi5Gb3JlaWduRW51bVByb3RvMlITcmVxdWlyZWRGb3JlaWduRW51bRI2ChVy'
    'ZXF1aXJlZF9zdHJpbmdfcGllY2UYGCACKAlCAggCUhNyZXF1aXJlZFN0cmluZ1BpZWNlEicKDX'
    'JlcXVpcmVkX2NvcmQYGSACKAlCAggBUgxyZXF1aXJlZENvcmQSZgoRcmVjdXJzaXZlX21lc3Nh'
    'Z2UYGyACKAsyOS5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi5UZXN0QWxsUmVxdWlyZW'
    'RUeXBlc1Byb3RvMlIQcmVjdXJzaXZlTWVzc2FnZRJ3ChpvcHRpb25hbF9yZWN1cnNpdmVfbWVz'
    'c2FnZRgcIAEoCzI5LnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8yLlRlc3RBbGxSZXF1aX'
    'JlZFR5cGVzUHJvdG8yUhhvcHRpb25hbFJlY3Vyc2l2ZU1lc3NhZ2USUwoEZGF0YRjJASACKAoy'
    'Pi5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi5UZXN0QWxsUmVxdWlyZWRUeXBlc1Byb3'
    'RvMi5EYXRhUgRkYXRhEjAKDWRlZmF1bHRfaW50MzIY8QEgAigFOgotMTIzNDU2Nzg5UgxkZWZh'
    'dWx0SW50MzISOgoNZGVmYXVsdF9pbnQ2NBjyASACKAM6FC05MTIzNDU2Nzg5MTIzNDU2Nzg5Ug'
    'xkZWZhdWx0SW50NjQSMgoOZGVmYXVsdF91aW50MzIY8wEgAigNOgoyMTIzNDU2Nzg5Ug1kZWZh'
    'dWx0VWludDMyEjwKDmRlZmF1bHRfdWludDY0GPQBIAIoBDoUMTAxMjM0NTY3ODkxMjM0NTY3OD'
    'lSDWRlZmF1bHRVaW50NjQSMgoOZGVmYXVsdF9zaW50MzIY9QEgAigROgotMTIzNDU2Nzg5Ug1k'
    'ZWZhdWx0U2ludDMyEjwKDmRlZmF1bHRfc2ludDY0GPYBIAIoEjoULTkxMjM0NTY3ODkxMjM0NT'
    'Y3ODlSDWRlZmF1bHRTaW50NjQSNAoPZGVmYXVsdF9maXhlZDMyGPcBIAIoBzoKMjEyMzQ1Njc4'
    'OVIOZGVmYXVsdEZpeGVkMzISPgoPZGVmYXVsdF9maXhlZDY0GPgBIAIoBjoUMTAxMjM0NTY3OD'
    'kxMjM0NTY3ODlSDmRlZmF1bHRGaXhlZDY0EjYKEGRlZmF1bHRfc2ZpeGVkMzIY+QEgAigPOgot'
    'MTIzNDU2Nzg5Ug9kZWZhdWx0U2ZpeGVkMzISQAoQZGVmYXVsdF9zZml4ZWQ2NBj6ASACKBA6FC'
    '05MTIzNDU2Nzg5MTIzNDU2Nzg5Ug9kZWZhdWx0U2ZpeGVkNjQSKwoNZGVmYXVsdF9mbG9hdBj7'
    'ASACKAI6BTllKzA5UgxkZWZhdWx0RmxvYXQSLQoOZGVmYXVsdF9kb3VibGUY/AEgAigBOgU3ZS'
    'syMlINZGVmYXVsdERvdWJsZRIoCgxkZWZhdWx0X2Jvb2wY/QEgAigIOgR0cnVlUgtkZWZhdWx0'
    'Qm9vbBIvCg5kZWZhdWx0X3N0cmluZxj+ASACKAk6B1Jvc2VidWRSDWRlZmF1bHRTdHJpbmcSLA'
    'oNZGVmYXVsdF9ieXRlcxj/ASACKAw6Bmpvc2h1YVIMZGVmYXVsdEJ5dGVzGugBCg1OZXN0ZWRN'
    'ZXNzYWdlEgwKAWEYASACKAVSAWESWwoLY29yZWN1cnNpdmUYAiACKAsyOS5wcm90b2J1Zl90ZX'
    'N0X21lc3NhZ2VzLnByb3RvMi5UZXN0QWxsUmVxdWlyZWRUeXBlc1Byb3RvMlILY29yZWN1cnNp'
    'dmUSbAoUb3B0aW9uYWxfY29yZWN1cnNpdmUYAyABKAsyOS5wcm90b2J1Zl90ZXN0X21lc3NhZ2'
    'VzLnByb3RvMi5UZXN0QWxsUmVxdWlyZWRUeXBlc1Byb3RvMlITb3B0aW9uYWxDb3JlY3Vyc2l2'
    'ZRpMCgREYXRhEiAKC2dyb3VwX2ludDMyGMoBIAIoBVIKZ3JvdXBJbnQzMhIiCgxncm91cF91aW'
    '50MzIYywEgAigNUgtncm91cFVpbnQzMhohChFNZXNzYWdlU2V0Q29ycmVjdCoICAQQ/////wc6'
    'AggBGooCChtNZXNzYWdlU2V0Q29ycmVjdEV4dGVuc2lvbjESEAoDc3RyGBkgAigJUgNzdHIy2A'
    'EKFW1lc3NhZ2Vfc2V0X2V4dGVuc2lvbhJLLnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8y'
    'LlRlc3RBbGxSZXF1aXJlZFR5cGVzUHJvdG8yLk1lc3NhZ2VTZXRDb3JyZWN0GPm7XiABKAsyVS'
    '5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi5UZXN0QWxsUmVxdWlyZWRUeXBlc1Byb3Rv'
    'Mi5NZXNzYWdlU2V0Q29ycmVjdEV4dGVuc2lvbjFSE21lc3NhZ2VTZXRFeHRlbnNpb24ahwIKG0'
    '1lc3NhZ2VTZXRDb3JyZWN0RXh0ZW5zaW9uMhIMCgFpGAkgAigFUgFpMtkBChVtZXNzYWdlX3Nl'
    'dF9leHRlbnNpb24SSy5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMi5UZXN0QWxsUmVxdW'
    'lyZWRUeXBlc1Byb3RvMi5NZXNzYWdlU2V0Q29ycmVjdBiQs/wBIAEoCzJVLnByb3RvYnVmX3Rl'
    'c3RfbWVzc2FnZXMucHJvdG8yLlRlc3RBbGxSZXF1aXJlZFR5cGVzUHJvdG8yLk1lc3NhZ2VTZX'
    'RDb3JyZWN0RXh0ZW5zaW9uMlITbWVzc2FnZVNldEV4dGVuc2lvbiI5CgpOZXN0ZWRFbnVtEgcK'
    'A0ZPTxAAEgcKA0JBUhABEgcKA0JBWhACEhAKA05FRxD///////////8BKgUIeBDJAUoGCOgHEJ'
    'BO');
