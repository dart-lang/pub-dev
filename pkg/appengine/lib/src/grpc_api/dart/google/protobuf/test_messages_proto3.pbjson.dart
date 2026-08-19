//
//  Generated code. Do not modify.
//  source: google/protobuf/test_messages_proto3.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use foreignEnumDescriptor instead')
const ForeignEnum$json = {
  '1': 'ForeignEnum',
  '2': [
    {'1': 'FOREIGN_FOO', '2': 0},
    {'1': 'FOREIGN_BAR', '2': 1},
    {'1': 'FOREIGN_BAZ', '2': 2},
  ],
};

/// Descriptor for `ForeignEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List foreignEnumDescriptor = $convert.base64Decode(
    'CgtGb3JlaWduRW51bRIPCgtGT1JFSUdOX0ZPTxAAEg8KC0ZPUkVJR05fQkFSEAESDwoLRk9SRU'
    'lHTl9CQVoQAg==');

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3$json = {
  '1': 'TestAllTypesProto3',
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
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3.NestedMessage',
      '10': 'optionalNestedMessage'
    },
    {
      '1': 'optional_foreign_message',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto3.ForeignMessage',
      '10': 'optionalForeignMessage'
    },
    {
      '1': 'optional_nested_enum',
      '3': 21,
      '4': 1,
      '5': 14,
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3.NestedEnum',
      '10': 'optionalNestedEnum'
    },
    {
      '1': 'optional_foreign_enum',
      '3': 22,
      '4': 1,
      '5': 14,
      '6': '.protobuf_test_messages.proto3.ForeignEnum',
      '10': 'optionalForeignEnum'
    },
    {
      '1': 'optional_aliased_enum',
      '3': 23,
      '4': 1,
      '5': 14,
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3.AliasedEnum',
      '10': 'optionalAliasedEnum'
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
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3',
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
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3.NestedMessage',
      '10': 'repeatedNestedMessage'
    },
    {
      '1': 'repeated_foreign_message',
      '3': 49,
      '4': 3,
      '5': 11,
      '6': '.protobuf_test_messages.proto3.ForeignMessage',
      '10': 'repeatedForeignMessage'
    },
    {
      '1': 'repeated_nested_enum',
      '3': 51,
      '4': 3,
      '5': 14,
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3.NestedEnum',
      '10': 'repeatedNestedEnum'
    },
    {
      '1': 'repeated_foreign_enum',
      '3': 52,
      '4': 3,
      '5': 14,
      '6': '.protobuf_test_messages.proto3.ForeignEnum',
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
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3.NestedEnum',
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
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3.NestedEnum',
      '8': {'2': false},
      '10': 'unpackedNestedEnum',
    },
    {
      '1': 'map_int32_int32',
      '3': 56,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapInt32Int32Entry',
      '10': 'mapInt32Int32'
    },
    {
      '1': 'map_int64_int64',
      '3': 57,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapInt64Int64Entry',
      '10': 'mapInt64Int64'
    },
    {
      '1': 'map_uint32_uint32',
      '3': 58,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapUint32Uint32Entry',
      '10': 'mapUint32Uint32'
    },
    {
      '1': 'map_uint64_uint64',
      '3': 59,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapUint64Uint64Entry',
      '10': 'mapUint64Uint64'
    },
    {
      '1': 'map_sint32_sint32',
      '3': 60,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapSint32Sint32Entry',
      '10': 'mapSint32Sint32'
    },
    {
      '1': 'map_sint64_sint64',
      '3': 61,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapSint64Sint64Entry',
      '10': 'mapSint64Sint64'
    },
    {
      '1': 'map_fixed32_fixed32',
      '3': 62,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapFixed32Fixed32Entry',
      '10': 'mapFixed32Fixed32'
    },
    {
      '1': 'map_fixed64_fixed64',
      '3': 63,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapFixed64Fixed64Entry',
      '10': 'mapFixed64Fixed64'
    },
    {
      '1': 'map_sfixed32_sfixed32',
      '3': 64,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapSfixed32Sfixed32Entry',
      '10': 'mapSfixed32Sfixed32'
    },
    {
      '1': 'map_sfixed64_sfixed64',
      '3': 65,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapSfixed64Sfixed64Entry',
      '10': 'mapSfixed64Sfixed64'
    },
    {
      '1': 'map_int32_float',
      '3': 66,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapInt32FloatEntry',
      '10': 'mapInt32Float'
    },
    {
      '1': 'map_int32_double',
      '3': 67,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapInt32DoubleEntry',
      '10': 'mapInt32Double'
    },
    {
      '1': 'map_bool_bool',
      '3': 68,
      '4': 3,
      '5': 11,
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3.MapBoolBoolEntry',
      '10': 'mapBoolBool'
    },
    {
      '1': 'map_string_string',
      '3': 69,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapStringStringEntry',
      '10': 'mapStringString'
    },
    {
      '1': 'map_string_bytes',
      '3': 70,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapStringBytesEntry',
      '10': 'mapStringBytes'
    },
    {
      '1': 'map_string_nested_message',
      '3': 71,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapStringNestedMessageEntry',
      '10': 'mapStringNestedMessage'
    },
    {
      '1': 'map_string_foreign_message',
      '3': 72,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapStringForeignMessageEntry',
      '10': 'mapStringForeignMessage'
    },
    {
      '1': 'map_string_nested_enum',
      '3': 73,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapStringNestedEnumEntry',
      '10': 'mapStringNestedEnum'
    },
    {
      '1': 'map_string_foreign_enum',
      '3': 74,
      '4': 3,
      '5': 11,
      '6':
          '.protobuf_test_messages.proto3.TestAllTypesProto3.MapStringForeignEnumEntry',
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
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3.NestedMessage',
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
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3.NestedEnum',
      '9': 0,
      '10': 'oneofEnum'
    },
    {
      '1': 'oneof_null_value',
      '3': 120,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.NullValue',
      '9': 0,
      '10': 'oneofNullValue'
    },
    {
      '1': 'optional_bool_wrapper',
      '3': 201,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'optionalBoolWrapper'
    },
    {
      '1': 'optional_int32_wrapper',
      '3': 202,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Int32Value',
      '10': 'optionalInt32Wrapper'
    },
    {
      '1': 'optional_int64_wrapper',
      '3': 203,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Int64Value',
      '10': 'optionalInt64Wrapper'
    },
    {
      '1': 'optional_uint32_wrapper',
      '3': 204,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'optionalUint32Wrapper'
    },
    {
      '1': 'optional_uint64_wrapper',
      '3': 205,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt64Value',
      '10': 'optionalUint64Wrapper'
    },
    {
      '1': 'optional_float_wrapper',
      '3': 206,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FloatValue',
      '10': 'optionalFloatWrapper'
    },
    {
      '1': 'optional_double_wrapper',
      '3': 207,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.DoubleValue',
      '10': 'optionalDoubleWrapper'
    },
    {
      '1': 'optional_string_wrapper',
      '3': 208,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'optionalStringWrapper'
    },
    {
      '1': 'optional_bytes_wrapper',
      '3': 209,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'optionalBytesWrapper'
    },
    {
      '1': 'repeated_bool_wrapper',
      '3': 211,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'repeatedBoolWrapper'
    },
    {
      '1': 'repeated_int32_wrapper',
      '3': 212,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Int32Value',
      '10': 'repeatedInt32Wrapper'
    },
    {
      '1': 'repeated_int64_wrapper',
      '3': 213,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Int64Value',
      '10': 'repeatedInt64Wrapper'
    },
    {
      '1': 'repeated_uint32_wrapper',
      '3': 214,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'repeatedUint32Wrapper'
    },
    {
      '1': 'repeated_uint64_wrapper',
      '3': 215,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.UInt64Value',
      '10': 'repeatedUint64Wrapper'
    },
    {
      '1': 'repeated_float_wrapper',
      '3': 216,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.FloatValue',
      '10': 'repeatedFloatWrapper'
    },
    {
      '1': 'repeated_double_wrapper',
      '3': 217,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.DoubleValue',
      '10': 'repeatedDoubleWrapper'
    },
    {
      '1': 'repeated_string_wrapper',
      '3': 218,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'repeatedStringWrapper'
    },
    {
      '1': 'repeated_bytes_wrapper',
      '3': 219,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'repeatedBytesWrapper'
    },
    {
      '1': 'optional_duration',
      '3': 301,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'optionalDuration'
    },
    {
      '1': 'optional_timestamp',
      '3': 302,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'optionalTimestamp'
    },
    {
      '1': 'optional_field_mask',
      '3': 303,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'optionalFieldMask'
    },
    {
      '1': 'optional_struct',
      '3': 304,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'optionalStruct'
    },
    {
      '1': 'optional_any',
      '3': 305,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'optionalAny'
    },
    {
      '1': 'optional_value',
      '3': 306,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Value',
      '10': 'optionalValue'
    },
    {
      '1': 'optional_null_value',
      '3': 307,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.NullValue',
      '10': 'optionalNullValue'
    },
    {
      '1': 'repeated_duration',
      '3': 311,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'repeatedDuration'
    },
    {
      '1': 'repeated_timestamp',
      '3': 312,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'repeatedTimestamp'
    },
    {
      '1': 'repeated_fieldmask',
      '3': 313,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'repeatedFieldmask'
    },
    {
      '1': 'repeated_struct',
      '3': 324,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'repeatedStruct'
    },
    {
      '1': 'repeated_any',
      '3': 315,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'repeatedAny'
    },
    {
      '1': 'repeated_value',
      '3': 316,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Value',
      '10': 'repeatedValue'
    },
    {
      '1': 'repeated_list_value',
      '3': 317,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.ListValue',
      '10': 'repeatedListValue'
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
    TestAllTypesProto3_NestedMessage$json,
    TestAllTypesProto3_MapInt32Int32Entry$json,
    TestAllTypesProto3_MapInt64Int64Entry$json,
    TestAllTypesProto3_MapUint32Uint32Entry$json,
    TestAllTypesProto3_MapUint64Uint64Entry$json,
    TestAllTypesProto3_MapSint32Sint32Entry$json,
    TestAllTypesProto3_MapSint64Sint64Entry$json,
    TestAllTypesProto3_MapFixed32Fixed32Entry$json,
    TestAllTypesProto3_MapFixed64Fixed64Entry$json,
    TestAllTypesProto3_MapSfixed32Sfixed32Entry$json,
    TestAllTypesProto3_MapSfixed64Sfixed64Entry$json,
    TestAllTypesProto3_MapInt32FloatEntry$json,
    TestAllTypesProto3_MapInt32DoubleEntry$json,
    TestAllTypesProto3_MapBoolBoolEntry$json,
    TestAllTypesProto3_MapStringStringEntry$json,
    TestAllTypesProto3_MapStringBytesEntry$json,
    TestAllTypesProto3_MapStringNestedMessageEntry$json,
    TestAllTypesProto3_MapStringForeignMessageEntry$json,
    TestAllTypesProto3_MapStringNestedEnumEntry$json,
    TestAllTypesProto3_MapStringForeignEnumEntry$json
  ],
  '4': [
    TestAllTypesProto3_NestedEnum$json,
    TestAllTypesProto3_AliasedEnum$json
  ],
  '8': [
    {'1': 'oneof_field'},
  ],
  '9': [
    {'1': 501, '2': 511},
  ],
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_NestedMessage$json = {
  '1': 'NestedMessage',
  '2': [
    {'1': 'a', '3': 1, '4': 1, '5': 5, '10': 'a'},
    {
      '1': 'corecursive',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3',
      '10': 'corecursive'
    },
  ],
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapInt32Int32Entry$json = {
  '1': 'MapInt32Int32Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapInt64Int64Entry$json = {
  '1': 'MapInt64Int64Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 3, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 3, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapUint32Uint32Entry$json = {
  '1': 'MapUint32Uint32Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 13, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapUint64Uint64Entry$json = {
  '1': 'MapUint64Uint64Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 4, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapSint32Sint32Entry$json = {
  '1': 'MapSint32Sint32Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 17, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 17, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapSint64Sint64Entry$json = {
  '1': 'MapSint64Sint64Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 18, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 18, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapFixed32Fixed32Entry$json = {
  '1': 'MapFixed32Fixed32Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 7, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 7, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapFixed64Fixed64Entry$json = {
  '1': 'MapFixed64Fixed64Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 6, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 6, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapSfixed32Sfixed32Entry$json = {
  '1': 'MapSfixed32Sfixed32Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 15, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 15, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapSfixed64Sfixed64Entry$json = {
  '1': 'MapSfixed64Sfixed64Entry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 16, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 16, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapInt32FloatEntry$json = {
  '1': 'MapInt32FloatEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 2, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapInt32DoubleEntry$json = {
  '1': 'MapInt32DoubleEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapBoolBoolEntry$json = {
  '1': 'MapBoolBoolEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 8, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 8, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapStringStringEntry$json = {
  '1': 'MapStringStringEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapStringBytesEntry$json = {
  '1': 'MapStringBytesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapStringNestedMessageEntry$json = {
  '1': 'MapStringNestedMessageEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3.NestedMessage',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapStringForeignMessageEntry$json = {
  '1': 'MapStringForeignMessageEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.protobuf_test_messages.proto3.ForeignMessage',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapStringNestedEnumEntry$json = {
  '1': 'MapStringNestedEnumEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.protobuf_test_messages.proto3.TestAllTypesProto3.NestedEnum',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_MapStringForeignEnumEntry$json = {
  '1': 'MapStringForeignEnumEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.protobuf_test_messages.proto3.ForeignEnum',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_NestedEnum$json = {
  '1': 'NestedEnum',
  '2': [
    {'1': 'FOO', '2': 0},
    {'1': 'BAR', '2': 1},
    {'1': 'BAZ', '2': 2},
    {'1': 'NEG', '2': -1},
  ],
};

@$core.Deprecated('Use testAllTypesProto3Descriptor instead')
const TestAllTypesProto3_AliasedEnum$json = {
  '1': 'AliasedEnum',
  '2': [
    {'1': 'ALIAS_FOO', '2': 0},
    {'1': 'ALIAS_BAR', '2': 1},
    {'1': 'ALIAS_BAZ', '2': 2},
    {'1': 'MOO', '2': 2},
    {'1': 'moo', '2': 2},
    {'1': 'bAz', '2': 2},
  ],
  '3': {'2': true},
};

/// Descriptor for `TestAllTypesProto3`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testAllTypesProto3Descriptor = $convert.base64Decode(
    'ChJUZXN0QWxsVHlwZXNQcm90bzMSJQoOb3B0aW9uYWxfaW50MzIYASABKAVSDW9wdGlvbmFsSW'
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
    'KAsyPy5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMy5UZXN0QWxsVHlwZXNQcm90bzMuTm'
    'VzdGVkTWVzc2FnZVIVb3B0aW9uYWxOZXN0ZWRNZXNzYWdlEmcKGG9wdGlvbmFsX2ZvcmVpZ25f'
    'bWVzc2FnZRgTIAEoCzItLnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8zLkZvcmVpZ25NZX'
    'NzYWdlUhZvcHRpb25hbEZvcmVpZ25NZXNzYWdlEm4KFG9wdGlvbmFsX25lc3RlZF9lbnVtGBUg'
    'ASgOMjwucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzMuVGVzdEFsbFR5cGVzUHJvdG8zLk'
    '5lc3RlZEVudW1SEm9wdGlvbmFsTmVzdGVkRW51bRJeChVvcHRpb25hbF9mb3JlaWduX2VudW0Y'
    'FiABKA4yKi5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMy5Gb3JlaWduRW51bVITb3B0aW'
    '9uYWxGb3JlaWduRW51bRJxChVvcHRpb25hbF9hbGlhc2VkX2VudW0YFyABKA4yPS5wcm90b2J1'
    'Zl90ZXN0X21lc3NhZ2VzLnByb3RvMy5UZXN0QWxsVHlwZXNQcm90bzMuQWxpYXNlZEVudW1SE2'
    '9wdGlvbmFsQWxpYXNlZEVudW0SNgoVb3B0aW9uYWxfc3RyaW5nX3BpZWNlGBggASgJQgIIAlIT'
    'b3B0aW9uYWxTdHJpbmdQaWVjZRInCg1vcHRpb25hbF9jb3JkGBkgASgJQgIIAVIMb3B0aW9uYW'
    'xDb3JkEl4KEXJlY3Vyc2l2ZV9tZXNzYWdlGBsgASgLMjEucHJvdG9idWZfdGVzdF9tZXNzYWdl'
    'cy5wcm90bzMuVGVzdEFsbFR5cGVzUHJvdG8zUhByZWN1cnNpdmVNZXNzYWdlEiUKDnJlcGVhdG'
    'VkX2ludDMyGB8gAygFUg1yZXBlYXRlZEludDMyEiUKDnJlcGVhdGVkX2ludDY0GCAgAygDUg1y'
    'ZXBlYXRlZEludDY0EicKD3JlcGVhdGVkX3VpbnQzMhghIAMoDVIOcmVwZWF0ZWRVaW50MzISJw'
    'oPcmVwZWF0ZWRfdWludDY0GCIgAygEUg5yZXBlYXRlZFVpbnQ2NBInCg9yZXBlYXRlZF9zaW50'
    'MzIYIyADKBFSDnJlcGVhdGVkU2ludDMyEicKD3JlcGVhdGVkX3NpbnQ2NBgkIAMoElIOcmVwZW'
    'F0ZWRTaW50NjQSKQoQcmVwZWF0ZWRfZml4ZWQzMhglIAMoB1IPcmVwZWF0ZWRGaXhlZDMyEikK'
    'EHJlcGVhdGVkX2ZpeGVkNjQYJiADKAZSD3JlcGVhdGVkRml4ZWQ2NBIrChFyZXBlYXRlZF9zZm'
    'l4ZWQzMhgnIAMoD1IQcmVwZWF0ZWRTZml4ZWQzMhIrChFyZXBlYXRlZF9zZml4ZWQ2NBgoIAMo'
    'EFIQcmVwZWF0ZWRTZml4ZWQ2NBIlCg5yZXBlYXRlZF9mbG9hdBgpIAMoAlINcmVwZWF0ZWRGbG'
    '9hdBInCg9yZXBlYXRlZF9kb3VibGUYKiADKAFSDnJlcGVhdGVkRG91YmxlEiMKDXJlcGVhdGVk'
    'X2Jvb2wYKyADKAhSDHJlcGVhdGVkQm9vbBInCg9yZXBlYXRlZF9zdHJpbmcYLCADKAlSDnJlcG'
    'VhdGVkU3RyaW5nEiUKDnJlcGVhdGVkX2J5dGVzGC0gAygMUg1yZXBlYXRlZEJ5dGVzEncKF3Jl'
    'cGVhdGVkX25lc3RlZF9tZXNzYWdlGDAgAygLMj8ucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm'
    '90bzMuVGVzdEFsbFR5cGVzUHJvdG8zLk5lc3RlZE1lc3NhZ2VSFXJlcGVhdGVkTmVzdGVkTWVz'
    'c2FnZRJnChhyZXBlYXRlZF9mb3JlaWduX21lc3NhZ2UYMSADKAsyLS5wcm90b2J1Zl90ZXN0X2'
    '1lc3NhZ2VzLnByb3RvMy5Gb3JlaWduTWVzc2FnZVIWcmVwZWF0ZWRGb3JlaWduTWVzc2FnZRJu'
    'ChRyZXBlYXRlZF9uZXN0ZWRfZW51bRgzIAMoDjI8LnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucH'
    'JvdG8zLlRlc3RBbGxUeXBlc1Byb3RvMy5OZXN0ZWRFbnVtUhJyZXBlYXRlZE5lc3RlZEVudW0S'
    'XgoVcmVwZWF0ZWRfZm9yZWlnbl9lbnVtGDQgAygOMioucHJvdG9idWZfdGVzdF9tZXNzYWdlcy'
    '5wcm90bzMuRm9yZWlnbkVudW1SE3JlcGVhdGVkRm9yZWlnbkVudW0SNgoVcmVwZWF0ZWRfc3Ry'
    'aW5nX3BpZWNlGDYgAygJQgIIAlITcmVwZWF0ZWRTdHJpbmdQaWVjZRInCg1yZXBlYXRlZF9jb3'
    'JkGDcgAygJQgIIAVIMcmVwZWF0ZWRDb3JkEiUKDHBhY2tlZF9pbnQzMhhLIAMoBUICEAFSC3Bh'
    'Y2tlZEludDMyEiUKDHBhY2tlZF9pbnQ2NBhMIAMoA0ICEAFSC3BhY2tlZEludDY0EicKDXBhY2'
    'tlZF91aW50MzIYTSADKA1CAhABUgxwYWNrZWRVaW50MzISJwoNcGFja2VkX3VpbnQ2NBhOIAMo'
    'BEICEAFSDHBhY2tlZFVpbnQ2NBInCg1wYWNrZWRfc2ludDMyGE8gAygRQgIQAVIMcGFja2VkU2'
    'ludDMyEicKDXBhY2tlZF9zaW50NjQYUCADKBJCAhABUgxwYWNrZWRTaW50NjQSKQoOcGFja2Vk'
    'X2ZpeGVkMzIYUSADKAdCAhABUg1wYWNrZWRGaXhlZDMyEikKDnBhY2tlZF9maXhlZDY0GFIgAy'
    'gGQgIQAVINcGFja2VkRml4ZWQ2NBIrCg9wYWNrZWRfc2ZpeGVkMzIYUyADKA9CAhABUg5wYWNr'
    'ZWRTZml4ZWQzMhIrCg9wYWNrZWRfc2ZpeGVkNjQYVCADKBBCAhABUg5wYWNrZWRTZml4ZWQ2NB'
    'IlCgxwYWNrZWRfZmxvYXQYVSADKAJCAhABUgtwYWNrZWRGbG9hdBInCg1wYWNrZWRfZG91Ymxl'
    'GFYgAygBQgIQAVIMcGFja2VkRG91YmxlEiMKC3BhY2tlZF9ib29sGFcgAygIQgIQAVIKcGFja2'
    'VkQm9vbBJuChJwYWNrZWRfbmVzdGVkX2VudW0YWCADKA4yPC5wcm90b2J1Zl90ZXN0X21lc3Nh'
    'Z2VzLnByb3RvMy5UZXN0QWxsVHlwZXNQcm90bzMuTmVzdGVkRW51bUICEAFSEHBhY2tlZE5lc3'
    'RlZEVudW0SKQoOdW5wYWNrZWRfaW50MzIYWSADKAVCAhAAUg11bnBhY2tlZEludDMyEikKDnVu'
    'cGFja2VkX2ludDY0GFogAygDQgIQAFINdW5wYWNrZWRJbnQ2NBIrCg91bnBhY2tlZF91aW50Mz'
    'IYWyADKA1CAhAAUg51bnBhY2tlZFVpbnQzMhIrCg91bnBhY2tlZF91aW50NjQYXCADKARCAhAA'
    'Ug51bnBhY2tlZFVpbnQ2NBIrCg91bnBhY2tlZF9zaW50MzIYXSADKBFCAhAAUg51bnBhY2tlZF'
    'NpbnQzMhIrCg91bnBhY2tlZF9zaW50NjQYXiADKBJCAhAAUg51bnBhY2tlZFNpbnQ2NBItChB1'
    'bnBhY2tlZF9maXhlZDMyGF8gAygHQgIQAFIPdW5wYWNrZWRGaXhlZDMyEi0KEHVucGFja2VkX2'
    'ZpeGVkNjQYYCADKAZCAhAAUg91bnBhY2tlZEZpeGVkNjQSLwoRdW5wYWNrZWRfc2ZpeGVkMzIY'
    'YSADKA9CAhAAUhB1bnBhY2tlZFNmaXhlZDMyEi8KEXVucGFja2VkX3NmaXhlZDY0GGIgAygQQg'
    'IQAFIQdW5wYWNrZWRTZml4ZWQ2NBIpCg51bnBhY2tlZF9mbG9hdBhjIAMoAkICEABSDXVucGFj'
    'a2VkRmxvYXQSKwoPdW5wYWNrZWRfZG91YmxlGGQgAygBQgIQAFIOdW5wYWNrZWREb3VibGUSJw'
    'oNdW5wYWNrZWRfYm9vbBhlIAMoCEICEABSDHVucGFja2VkQm9vbBJyChR1bnBhY2tlZF9uZXN0'
    'ZWRfZW51bRhmIAMoDjI8LnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8zLlRlc3RBbGxUeX'
    'Blc1Byb3RvMy5OZXN0ZWRFbnVtQgIQAFISdW5wYWNrZWROZXN0ZWRFbnVtEmwKD21hcF9pbnQz'
    'Ml9pbnQzMhg4IAMoCzJELnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8zLlRlc3RBbGxUeX'
    'Blc1Byb3RvMy5NYXBJbnQzMkludDMyRW50cnlSDW1hcEludDMySW50MzISbAoPbWFwX2ludDY0'
    'X2ludDY0GDkgAygLMkQucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzMuVGVzdEFsbFR5cG'
    'VzUHJvdG8zLk1hcEludDY0SW50NjRFbnRyeVINbWFwSW50NjRJbnQ2NBJyChFtYXBfdWludDMy'
    'X3VpbnQzMhg6IAMoCzJGLnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8zLlRlc3RBbGxUeX'
    'Blc1Byb3RvMy5NYXBVaW50MzJVaW50MzJFbnRyeVIPbWFwVWludDMyVWludDMyEnIKEW1hcF91'
    'aW50NjRfdWludDY0GDsgAygLMkYucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzMuVGVzdE'
    'FsbFR5cGVzUHJvdG8zLk1hcFVpbnQ2NFVpbnQ2NEVudHJ5Ug9tYXBVaW50NjRVaW50NjQScgoR'
    'bWFwX3NpbnQzMl9zaW50MzIYPCADKAsyRi5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMy'
    '5UZXN0QWxsVHlwZXNQcm90bzMuTWFwU2ludDMyU2ludDMyRW50cnlSD21hcFNpbnQzMlNpbnQz'
    'MhJyChFtYXBfc2ludDY0X3NpbnQ2NBg9IAMoCzJGLnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucH'
    'JvdG8zLlRlc3RBbGxUeXBlc1Byb3RvMy5NYXBTaW50NjRTaW50NjRFbnRyeVIPbWFwU2ludDY0'
    'U2ludDY0EngKE21hcF9maXhlZDMyX2ZpeGVkMzIYPiADKAsySC5wcm90b2J1Zl90ZXN0X21lc3'
    'NhZ2VzLnByb3RvMy5UZXN0QWxsVHlwZXNQcm90bzMuTWFwRml4ZWQzMkZpeGVkMzJFbnRyeVIR'
    'bWFwRml4ZWQzMkZpeGVkMzISeAoTbWFwX2ZpeGVkNjRfZml4ZWQ2NBg/IAMoCzJILnByb3RvYn'
    'VmX3Rlc3RfbWVzc2FnZXMucHJvdG8zLlRlc3RBbGxUeXBlc1Byb3RvMy5NYXBGaXhlZDY0Rml4'
    'ZWQ2NEVudHJ5UhFtYXBGaXhlZDY0Rml4ZWQ2NBJ+ChVtYXBfc2ZpeGVkMzJfc2ZpeGVkMzIYQC'
    'ADKAsySi5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMy5UZXN0QWxsVHlwZXNQcm90bzMu'
    'TWFwU2ZpeGVkMzJTZml4ZWQzMkVudHJ5UhNtYXBTZml4ZWQzMlNmaXhlZDMyEn4KFW1hcF9zZm'
    'l4ZWQ2NF9zZml4ZWQ2NBhBIAMoCzJKLnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8zLlRl'
    'c3RBbGxUeXBlc1Byb3RvMy5NYXBTZml4ZWQ2NFNmaXhlZDY0RW50cnlSE21hcFNmaXhlZDY0U2'
    'ZpeGVkNjQSbAoPbWFwX2ludDMyX2Zsb2F0GEIgAygLMkQucHJvdG9idWZfdGVzdF9tZXNzYWdl'
    'cy5wcm90bzMuVGVzdEFsbFR5cGVzUHJvdG8zLk1hcEludDMyRmxvYXRFbnRyeVINbWFwSW50Mz'
    'JGbG9hdBJvChBtYXBfaW50MzJfZG91YmxlGEMgAygLMkUucHJvdG9idWZfdGVzdF9tZXNzYWdl'
    'cy5wcm90bzMuVGVzdEFsbFR5cGVzUHJvdG8zLk1hcEludDMyRG91YmxlRW50cnlSDm1hcEludD'
    'MyRG91YmxlEmYKDW1hcF9ib29sX2Jvb2wYRCADKAsyQi5wcm90b2J1Zl90ZXN0X21lc3NhZ2Vz'
    'LnByb3RvMy5UZXN0QWxsVHlwZXNQcm90bzMuTWFwQm9vbEJvb2xFbnRyeVILbWFwQm9vbEJvb2'
    'wScgoRbWFwX3N0cmluZ19zdHJpbmcYRSADKAsyRi5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnBy'
    'b3RvMy5UZXN0QWxsVHlwZXNQcm90bzMuTWFwU3RyaW5nU3RyaW5nRW50cnlSD21hcFN0cmluZ1'
    'N0cmluZxJvChBtYXBfc3RyaW5nX2J5dGVzGEYgAygLMkUucHJvdG9idWZfdGVzdF9tZXNzYWdl'
    'cy5wcm90bzMuVGVzdEFsbFR5cGVzUHJvdG8zLk1hcFN0cmluZ0J5dGVzRW50cnlSDm1hcFN0cm'
    'luZ0J5dGVzEogBChltYXBfc3RyaW5nX25lc3RlZF9tZXNzYWdlGEcgAygLMk0ucHJvdG9idWZf'
    'dGVzdF9tZXNzYWdlcy5wcm90bzMuVGVzdEFsbFR5cGVzUHJvdG8zLk1hcFN0cmluZ05lc3RlZE'
    '1lc3NhZ2VFbnRyeVIWbWFwU3RyaW5nTmVzdGVkTWVzc2FnZRKLAQoabWFwX3N0cmluZ19mb3Jl'
    'aWduX21lc3NhZ2UYSCADKAsyTi5wcm90b2J1Zl90ZXN0X21lc3NhZ2VzLnByb3RvMy5UZXN0QW'
    'xsVHlwZXNQcm90bzMuTWFwU3RyaW5nRm9yZWlnbk1lc3NhZ2VFbnRyeVIXbWFwU3RyaW5nRm9y'
    'ZWlnbk1lc3NhZ2USfwoWbWFwX3N0cmluZ19uZXN0ZWRfZW51bRhJIAMoCzJKLnByb3RvYnVmX3'
    'Rlc3RfbWVzc2FnZXMucHJvdG8zLlRlc3RBbGxUeXBlc1Byb3RvMy5NYXBTdHJpbmdOZXN0ZWRF'
    'bnVtRW50cnlSE21hcFN0cmluZ05lc3RlZEVudW0SggEKF21hcF9zdHJpbmdfZm9yZWlnbl9lbn'
    'VtGEogAygLMksucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzMuVGVzdEFsbFR5cGVzUHJv'
    'dG8zLk1hcFN0cmluZ0ZvcmVpZ25FbnVtRW50cnlSFG1hcFN0cmluZ0ZvcmVpZ25FbnVtEiMKDG'
    '9uZW9mX3VpbnQzMhhvIAEoDUgAUgtvbmVvZlVpbnQzMhJzChRvbmVvZl9uZXN0ZWRfbWVzc2Fn'
    'ZRhwIAEoCzI/LnByb3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8zLlRlc3RBbGxUeXBlc1Byb3'
    'RvMy5OZXN0ZWRNZXNzYWdlSABSEm9uZW9mTmVzdGVkTWVzc2FnZRIjCgxvbmVvZl9zdHJpbmcY'
    'cSABKAlIAFILb25lb2ZTdHJpbmcSIQoLb25lb2ZfYnl0ZXMYciABKAxIAFIKb25lb2ZCeXRlcx'
    'IfCgpvbmVvZl9ib29sGHMgASgISABSCW9uZW9mQm9vbBIjCgxvbmVvZl91aW50NjQYdCABKARI'
    'AFILb25lb2ZVaW50NjQSIQoLb25lb2ZfZmxvYXQYdSABKAJIAFIKb25lb2ZGbG9hdBIjCgxvbm'
    'VvZl9kb3VibGUYdiABKAFIAFILb25lb2ZEb3VibGUSXQoKb25lb2ZfZW51bRh3IAEoDjI8LnBy'
    'b3RvYnVmX3Rlc3RfbWVzc2FnZXMucHJvdG8zLlRlc3RBbGxUeXBlc1Byb3RvMy5OZXN0ZWRFbn'
    'VtSABSCW9uZW9mRW51bRJGChBvbmVvZl9udWxsX3ZhbHVlGHggASgOMhouZ29vZ2xlLnByb3Rv'
    'YnVmLk51bGxWYWx1ZUgAUg5vbmVvZk51bGxWYWx1ZRJPChVvcHRpb25hbF9ib29sX3dyYXBwZX'
    'IYyQEgASgLMhouZ29vZ2xlLnByb3RvYnVmLkJvb2xWYWx1ZVITb3B0aW9uYWxCb29sV3JhcHBl'
    'chJSChZvcHRpb25hbF9pbnQzMl93cmFwcGVyGMoBIAEoCzIbLmdvb2dsZS5wcm90b2J1Zi5Jbn'
    'QzMlZhbHVlUhRvcHRpb25hbEludDMyV3JhcHBlchJSChZvcHRpb25hbF9pbnQ2NF93cmFwcGVy'
    'GMsBIAEoCzIbLmdvb2dsZS5wcm90b2J1Zi5JbnQ2NFZhbHVlUhRvcHRpb25hbEludDY0V3JhcH'
    'BlchJVChdvcHRpb25hbF91aW50MzJfd3JhcHBlchjMASABKAsyHC5nb29nbGUucHJvdG9idWYu'
    'VUludDMyVmFsdWVSFW9wdGlvbmFsVWludDMyV3JhcHBlchJVChdvcHRpb25hbF91aW50NjRfd3'
    'JhcHBlchjNASABKAsyHC5nb29nbGUucHJvdG9idWYuVUludDY0VmFsdWVSFW9wdGlvbmFsVWlu'
    'dDY0V3JhcHBlchJSChZvcHRpb25hbF9mbG9hdF93cmFwcGVyGM4BIAEoCzIbLmdvb2dsZS5wcm'
    '90b2J1Zi5GbG9hdFZhbHVlUhRvcHRpb25hbEZsb2F0V3JhcHBlchJVChdvcHRpb25hbF9kb3Vi'
    'bGVfd3JhcHBlchjPASABKAsyHC5nb29nbGUucHJvdG9idWYuRG91YmxlVmFsdWVSFW9wdGlvbm'
    'FsRG91YmxlV3JhcHBlchJVChdvcHRpb25hbF9zdHJpbmdfd3JhcHBlchjQASABKAsyHC5nb29n'
    'bGUucHJvdG9idWYuU3RyaW5nVmFsdWVSFW9wdGlvbmFsU3RyaW5nV3JhcHBlchJSChZvcHRpb2'
    '5hbF9ieXRlc193cmFwcGVyGNEBIAEoCzIbLmdvb2dsZS5wcm90b2J1Zi5CeXRlc1ZhbHVlUhRv'
    'cHRpb25hbEJ5dGVzV3JhcHBlchJPChVyZXBlYXRlZF9ib29sX3dyYXBwZXIY0wEgAygLMhouZ2'
    '9vZ2xlLnByb3RvYnVmLkJvb2xWYWx1ZVITcmVwZWF0ZWRCb29sV3JhcHBlchJSChZyZXBlYXRl'
    'ZF9pbnQzMl93cmFwcGVyGNQBIAMoCzIbLmdvb2dsZS5wcm90b2J1Zi5JbnQzMlZhbHVlUhRyZX'
    'BlYXRlZEludDMyV3JhcHBlchJSChZyZXBlYXRlZF9pbnQ2NF93cmFwcGVyGNUBIAMoCzIbLmdv'
    'b2dsZS5wcm90b2J1Zi5JbnQ2NFZhbHVlUhRyZXBlYXRlZEludDY0V3JhcHBlchJVChdyZXBlYX'
    'RlZF91aW50MzJfd3JhcHBlchjWASADKAsyHC5nb29nbGUucHJvdG9idWYuVUludDMyVmFsdWVS'
    'FXJlcGVhdGVkVWludDMyV3JhcHBlchJVChdyZXBlYXRlZF91aW50NjRfd3JhcHBlchjXASADKA'
    'syHC5nb29nbGUucHJvdG9idWYuVUludDY0VmFsdWVSFXJlcGVhdGVkVWludDY0V3JhcHBlchJS'
    'ChZyZXBlYXRlZF9mbG9hdF93cmFwcGVyGNgBIAMoCzIbLmdvb2dsZS5wcm90b2J1Zi5GbG9hdF'
    'ZhbHVlUhRyZXBlYXRlZEZsb2F0V3JhcHBlchJVChdyZXBlYXRlZF9kb3VibGVfd3JhcHBlchjZ'
    'ASADKAsyHC5nb29nbGUucHJvdG9idWYuRG91YmxlVmFsdWVSFXJlcGVhdGVkRG91YmxlV3JhcH'
    'BlchJVChdyZXBlYXRlZF9zdHJpbmdfd3JhcHBlchjaASADKAsyHC5nb29nbGUucHJvdG9idWYu'
    'U3RyaW5nVmFsdWVSFXJlcGVhdGVkU3RyaW5nV3JhcHBlchJSChZyZXBlYXRlZF9ieXRlc193cm'
    'FwcGVyGNsBIAMoCzIbLmdvb2dsZS5wcm90b2J1Zi5CeXRlc1ZhbHVlUhRyZXBlYXRlZEJ5dGVz'
    'V3JhcHBlchJHChFvcHRpb25hbF9kdXJhdGlvbhitAiABKAsyGS5nb29nbGUucHJvdG9idWYuRH'
    'VyYXRpb25SEG9wdGlvbmFsRHVyYXRpb24SSgoSb3B0aW9uYWxfdGltZXN0YW1wGK4CIAEoCzIa'
    'Lmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEW9wdGlvbmFsVGltZXN0YW1wEksKE29wdGlvbm'
    'FsX2ZpZWxkX21hc2sYrwIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza1IRb3B0aW9u'
    'YWxGaWVsZE1hc2sSQQoPb3B0aW9uYWxfc3RydWN0GLACIAEoCzIXLmdvb2dsZS5wcm90b2J1Zi'
    '5TdHJ1Y3RSDm9wdGlvbmFsU3RydWN0EjgKDG9wdGlvbmFsX2FueRixAiABKAsyFC5nb29nbGUu'
    'cHJvdG9idWYuQW55UgtvcHRpb25hbEFueRI+Cg5vcHRpb25hbF92YWx1ZRiyAiABKAsyFi5nb2'
    '9nbGUucHJvdG9idWYuVmFsdWVSDW9wdGlvbmFsVmFsdWUSSwoTb3B0aW9uYWxfbnVsbF92YWx1'
    'ZRizAiABKA4yGi5nb29nbGUucHJvdG9idWYuTnVsbFZhbHVlUhFvcHRpb25hbE51bGxWYWx1ZR'
    'JHChFyZXBlYXRlZF9kdXJhdGlvbhi3AiADKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25S'
    'EHJlcGVhdGVkRHVyYXRpb24SSgoScmVwZWF0ZWRfdGltZXN0YW1wGLgCIAMoCzIaLmdvb2dsZS'
    '5wcm90b2J1Zi5UaW1lc3RhbXBSEXJlcGVhdGVkVGltZXN0YW1wEkoKEnJlcGVhdGVkX2ZpZWxk'
    'bWFzaxi5AiADKAsyGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrUhFyZXBlYXRlZEZpZWxkbW'
    'FzaxJBCg9yZXBlYXRlZF9zdHJ1Y3QYxAIgAygLMhcuZ29vZ2xlLnByb3RvYnVmLlN0cnVjdFIO'
    'cmVwZWF0ZWRTdHJ1Y3QSOAoMcmVwZWF0ZWRfYW55GLsCIAMoCzIULmdvb2dsZS5wcm90b2J1Zi'
    '5BbnlSC3JlcGVhdGVkQW55Ej4KDnJlcGVhdGVkX3ZhbHVlGLwCIAMoCzIWLmdvb2dsZS5wcm90'
    'b2J1Zi5WYWx1ZVINcmVwZWF0ZWRWYWx1ZRJLChNyZXBlYXRlZF9saXN0X3ZhbHVlGL0CIAMoCz'
    'IaLmdvb2dsZS5wcm90b2J1Zi5MaXN0VmFsdWVSEXJlcGVhdGVkTGlzdFZhbHVlEh8KCmZpZWxk'
    'bmFtZTEYkQMgASgFUgpmaWVsZG5hbWUxEiAKC2ZpZWxkX25hbWUyGJIDIAEoBVIKZmllbGROYW'
    '1lMhIhCgxfZmllbGRfbmFtZTMYkwMgASgFUgpGaWVsZE5hbWUzEiIKDWZpZWxkX19uYW1lNF8Y'
    'lAMgASgFUgpmaWVsZE5hbWU0EiEKC2ZpZWxkMG5hbWU1GJUDIAEoBVILZmllbGQwbmFtZTUSIw'
    'oNZmllbGRfMF9uYW1lNhiWAyABKAVSC2ZpZWxkME5hbWU2Eh8KCmZpZWxkTmFtZTcYlwMgASgF'
    'UgpmaWVsZE5hbWU3Eh8KCkZpZWxkTmFtZTgYmAMgASgFUgpGaWVsZE5hbWU4EiAKC2ZpZWxkX0'
    '5hbWU5GJkDIAEoBVIKZmllbGROYW1lORIiCgxGaWVsZF9OYW1lMTAYmgMgASgFUgtGaWVsZE5h'
    'bWUxMBIiCgxGSUVMRF9OQU1FMTEYmwMgASgFUgtGSUVMRE5BTUUxMRIiCgxGSUVMRF9uYW1lMT'
    'IYnAMgASgFUgtGSUVMRE5hbWUxMhIkCg5fX2ZpZWxkX25hbWUxMxidAyABKAVSC0ZpZWxkTmFt'
    'ZTEzEiQKDl9fRmllbGRfbmFtZTE0GJ4DIAEoBVILRmllbGROYW1lMTQSIwoNZmllbGRfX25hbW'
    'UxNRifAyABKAVSC2ZpZWxkTmFtZTE1EiMKDWZpZWxkX19OYW1lMTYYoAMgASgFUgtmaWVsZE5h'
    'bWUxNhIkCg5maWVsZF9uYW1lMTdfXxihAyABKAVSC2ZpZWxkTmFtZTE3EiQKDkZpZWxkX25hbW'
    'UxOF9fGKIDIAEoBVILRmllbGROYW1lMTgacgoNTmVzdGVkTWVzc2FnZRIMCgFhGAEgASgFUgFh'
    'ElMKC2NvcmVjdXJzaXZlGAIgASgLMjEucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzMuVG'
    'VzdEFsbFR5cGVzUHJvdG8zUgtjb3JlY3Vyc2l2ZRpAChJNYXBJbnQzMkludDMyRW50cnkSEAoD'
    'a2V5GAEgASgFUgNrZXkSFAoFdmFsdWUYAiABKAVSBXZhbHVlOgI4ARpAChJNYXBJbnQ2NEludD'
    'Y0RW50cnkSEAoDa2V5GAEgASgDUgNrZXkSFAoFdmFsdWUYAiABKANSBXZhbHVlOgI4ARpCChRN'
    'YXBVaW50MzJVaW50MzJFbnRyeRIQCgNrZXkYASABKA1SA2tleRIUCgV2YWx1ZRgCIAEoDVIFdm'
    'FsdWU6AjgBGkIKFE1hcFVpbnQ2NFVpbnQ2NEVudHJ5EhAKA2tleRgBIAEoBFIDa2V5EhQKBXZh'
    'bHVlGAIgASgEUgV2YWx1ZToCOAEaQgoUTWFwU2ludDMyU2ludDMyRW50cnkSEAoDa2V5GAEgAS'
    'gRUgNrZXkSFAoFdmFsdWUYAiABKBFSBXZhbHVlOgI4ARpCChRNYXBTaW50NjRTaW50NjRFbnRy'
    'eRIQCgNrZXkYASABKBJSA2tleRIUCgV2YWx1ZRgCIAEoElIFdmFsdWU6AjgBGkQKFk1hcEZpeG'
    'VkMzJGaXhlZDMyRW50cnkSEAoDa2V5GAEgASgHUgNrZXkSFAoFdmFsdWUYAiABKAdSBXZhbHVl'
    'OgI4ARpEChZNYXBGaXhlZDY0Rml4ZWQ2NEVudHJ5EhAKA2tleRgBIAEoBlIDa2V5EhQKBXZhbH'
    'VlGAIgASgGUgV2YWx1ZToCOAEaRgoYTWFwU2ZpeGVkMzJTZml4ZWQzMkVudHJ5EhAKA2tleRgB'
    'IAEoD1IDa2V5EhQKBXZhbHVlGAIgASgPUgV2YWx1ZToCOAEaRgoYTWFwU2ZpeGVkNjRTZml4ZW'
    'Q2NEVudHJ5EhAKA2tleRgBIAEoEFIDa2V5EhQKBXZhbHVlGAIgASgQUgV2YWx1ZToCOAEaQAoS'
    'TWFwSW50MzJGbG9hdEVudHJ5EhAKA2tleRgBIAEoBVIDa2V5EhQKBXZhbHVlGAIgASgCUgV2YW'
    'x1ZToCOAEaQQoTTWFwSW50MzJEb3VibGVFbnRyeRIQCgNrZXkYASABKAVSA2tleRIUCgV2YWx1'
    'ZRgCIAEoAVIFdmFsdWU6AjgBGj4KEE1hcEJvb2xCb29sRW50cnkSEAoDa2V5GAEgASgIUgNrZX'
    'kSFAoFdmFsdWUYAiABKAhSBXZhbHVlOgI4ARpCChRNYXBTdHJpbmdTdHJpbmdFbnRyeRIQCgNr'
    'ZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGkEKE01hcFN0cmluZ0J5dG'
    'VzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAxSBXZhbHVlOgI4ARqKAQob'
    'TWFwU3RyaW5nTmVzdGVkTWVzc2FnZUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5ElUKBXZhbHVlGA'
    'IgASgLMj8ucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzMuVGVzdEFsbFR5cGVzUHJvdG8z'
    'Lk5lc3RlZE1lc3NhZ2VSBXZhbHVlOgI4ARp5ChxNYXBTdHJpbmdGb3JlaWduTWVzc2FnZUVudH'
    'J5EhAKA2tleRgBIAEoCVIDa2V5EkMKBXZhbHVlGAIgASgLMi0ucHJvdG9idWZfdGVzdF9tZXNz'
    'YWdlcy5wcm90bzMuRm9yZWlnbk1lc3NhZ2VSBXZhbHVlOgI4ARqEAQoYTWFwU3RyaW5nTmVzdG'
    'VkRW51bUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5ElIKBXZhbHVlGAIgASgOMjwucHJvdG9idWZf'
    'dGVzdF9tZXNzYWdlcy5wcm90bzMuVGVzdEFsbFR5cGVzUHJvdG8zLk5lc3RlZEVudW1SBXZhbH'
    'VlOgI4ARpzChlNYXBTdHJpbmdGb3JlaWduRW51bUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EkAK'
    'BXZhbHVlGAIgASgOMioucHJvdG9idWZfdGVzdF9tZXNzYWdlcy5wcm90bzMuRm9yZWlnbkVudW'
    '1SBXZhbHVlOgI4ASI5CgpOZXN0ZWRFbnVtEgcKA0ZPTxAAEgcKA0JBUhABEgcKA0JBWhACEhAK'
    'A05FRxD///////////8BIlkKC0FsaWFzZWRFbnVtEg0KCUFMSUFTX0ZPTxAAEg0KCUFMSUFTX0'
    'JBUhABEg0KCUFMSUFTX0JBWhACEgcKA01PTxACEgcKA21vbxACEgcKA2JBehACGgIQAUINCgtv'
    'bmVvZl9maWVsZEoGCPUDEP8D');

@$core.Deprecated('Use foreignMessageDescriptor instead')
const ForeignMessage$json = {
  '1': 'ForeignMessage',
  '2': [
    {'1': 'c', '3': 1, '4': 1, '5': 5, '10': 'c'},
  ],
};

/// Descriptor for `ForeignMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List foreignMessageDescriptor =
    $convert.base64Decode('Cg5Gb3JlaWduTWVzc2FnZRIMCgFjGAEgASgFUgFj');

@$core.Deprecated('Use nullHypothesisProto3Descriptor instead')
const NullHypothesisProto3$json = {
  '1': 'NullHypothesisProto3',
};

/// Descriptor for `NullHypothesisProto3`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nullHypothesisProto3Descriptor =
    $convert.base64Decode('ChROdWxsSHlwb3RoZXNpc1Byb3RvMw==');

@$core.Deprecated('Use enumOnlyProto3Descriptor instead')
const EnumOnlyProto3$json = {
  '1': 'EnumOnlyProto3',
  '4': [EnumOnlyProto3_Bool$json],
};

@$core.Deprecated('Use enumOnlyProto3Descriptor instead')
const EnumOnlyProto3_Bool$json = {
  '1': 'Bool',
  '2': [
    {'1': 'kFalse', '2': 0},
    {'1': 'kTrue', '2': 1},
  ],
};

/// Descriptor for `EnumOnlyProto3`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enumOnlyProto3Descriptor = $convert.base64Decode(
    'Cg5FbnVtT25seVByb3RvMyIdCgRCb29sEgoKBmtGYWxzZRAAEgkKBWtUcnVlEAE=');
