///
//  Generated code. Do not modify.
///
library protobuf_test_messages.proto3_test_messages_proto3_pbjson;

const ForeignEnum$json = const {
  '1': 'ForeignEnum',
  '2': const [
    const {'1': 'FOREIGN_FOO', '2': 0},
    const {'1': 'FOREIGN_BAR', '2': 1},
    const {'1': 'FOREIGN_BAZ', '2': 2},
  ],
};

const TestAllTypes$json = const {
  '1': 'TestAllTypes',
  '2': const [
    const {'1': 'optional_int32', '3': 1, '4': 1, '5': 5},
    const {'1': 'optional_int64', '3': 2, '4': 1, '5': 3},
    const {'1': 'optional_uint32', '3': 3, '4': 1, '5': 13},
    const {'1': 'optional_uint64', '3': 4, '4': 1, '5': 4},
    const {'1': 'optional_sint32', '3': 5, '4': 1, '5': 17},
    const {'1': 'optional_sint64', '3': 6, '4': 1, '5': 18},
    const {'1': 'optional_fixed32', '3': 7, '4': 1, '5': 7},
    const {'1': 'optional_fixed64', '3': 8, '4': 1, '5': 6},
    const {'1': 'optional_sfixed32', '3': 9, '4': 1, '5': 15},
    const {'1': 'optional_sfixed64', '3': 10, '4': 1, '5': 16},
    const {'1': 'optional_float', '3': 11, '4': 1, '5': 2},
    const {'1': 'optional_double', '3': 12, '4': 1, '5': 1},
    const {'1': 'optional_bool', '3': 13, '4': 1, '5': 8},
    const {'1': 'optional_string', '3': 14, '4': 1, '5': 9},
    const {'1': 'optional_bytes', '3': 15, '4': 1, '5': 12},
    const {'1': 'optional_nested_message', '3': 18, '4': 1, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.NestedMessage'},
    const {'1': 'optional_foreign_message', '3': 19, '4': 1, '5': 11, '6': '.protobuf_test_messages.proto3.ForeignMessage'},
    const {'1': 'optional_nested_enum', '3': 21, '4': 1, '5': 14, '6': '.protobuf_test_messages.proto3.TestAllTypes.NestedEnum'},
    const {'1': 'optional_foreign_enum', '3': 22, '4': 1, '5': 14, '6': '.protobuf_test_messages.proto3.ForeignEnum'},
    const {'1': 'optional_string_piece', '3': 24, '4': 1, '5': 9, '8': const {}},
    const {'1': 'optional_cord', '3': 25, '4': 1, '5': 9, '8': const {}},
    const {'1': 'recursive_message', '3': 27, '4': 1, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes'},
    const {'1': 'repeated_int32', '3': 31, '4': 3, '5': 5},
    const {'1': 'repeated_int64', '3': 32, '4': 3, '5': 3},
    const {'1': 'repeated_uint32', '3': 33, '4': 3, '5': 13},
    const {'1': 'repeated_uint64', '3': 34, '4': 3, '5': 4},
    const {'1': 'repeated_sint32', '3': 35, '4': 3, '5': 17},
    const {'1': 'repeated_sint64', '3': 36, '4': 3, '5': 18},
    const {'1': 'repeated_fixed32', '3': 37, '4': 3, '5': 7},
    const {'1': 'repeated_fixed64', '3': 38, '4': 3, '5': 6},
    const {'1': 'repeated_sfixed32', '3': 39, '4': 3, '5': 15},
    const {'1': 'repeated_sfixed64', '3': 40, '4': 3, '5': 16},
    const {'1': 'repeated_float', '3': 41, '4': 3, '5': 2},
    const {'1': 'repeated_double', '3': 42, '4': 3, '5': 1},
    const {'1': 'repeated_bool', '3': 43, '4': 3, '5': 8},
    const {'1': 'repeated_string', '3': 44, '4': 3, '5': 9},
    const {'1': 'repeated_bytes', '3': 45, '4': 3, '5': 12},
    const {'1': 'repeated_nested_message', '3': 48, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.NestedMessage'},
    const {'1': 'repeated_foreign_message', '3': 49, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.ForeignMessage'},
    const {'1': 'repeated_nested_enum', '3': 51, '4': 3, '5': 14, '6': '.protobuf_test_messages.proto3.TestAllTypes.NestedEnum'},
    const {'1': 'repeated_foreign_enum', '3': 52, '4': 3, '5': 14, '6': '.protobuf_test_messages.proto3.ForeignEnum'},
    const {'1': 'repeated_string_piece', '3': 54, '4': 3, '5': 9, '8': const {}},
    const {'1': 'repeated_cord', '3': 55, '4': 3, '5': 9, '8': const {}},
    const {'1': 'map_int32_int32', '3': 56, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapInt32Int32Entry'},
    const {'1': 'map_int64_int64', '3': 57, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapInt64Int64Entry'},
    const {'1': 'map_uint32_uint32', '3': 58, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapUint32Uint32Entry'},
    const {'1': 'map_uint64_uint64', '3': 59, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapUint64Uint64Entry'},
    const {'1': 'map_sint32_sint32', '3': 60, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapSint32Sint32Entry'},
    const {'1': 'map_sint64_sint64', '3': 61, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapSint64Sint64Entry'},
    const {'1': 'map_fixed32_fixed32', '3': 62, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapFixed32Fixed32Entry'},
    const {'1': 'map_fixed64_fixed64', '3': 63, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapFixed64Fixed64Entry'},
    const {'1': 'map_sfixed32_sfixed32', '3': 64, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapSfixed32Sfixed32Entry'},
    const {'1': 'map_sfixed64_sfixed64', '3': 65, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapSfixed64Sfixed64Entry'},
    const {'1': 'map_int32_float', '3': 66, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapInt32FloatEntry'},
    const {'1': 'map_int32_double', '3': 67, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapInt32DoubleEntry'},
    const {'1': 'map_bool_bool', '3': 68, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapBoolBoolEntry'},
    const {'1': 'map_string_string', '3': 69, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapStringStringEntry'},
    const {'1': 'map_string_bytes', '3': 70, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapStringBytesEntry'},
    const {'1': 'map_string_nested_message', '3': 71, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapStringNestedMessageEntry'},
    const {'1': 'map_string_foreign_message', '3': 72, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapStringForeignMessageEntry'},
    const {'1': 'map_string_nested_enum', '3': 73, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapStringNestedEnumEntry'},
    const {'1': 'map_string_foreign_enum', '3': 74, '4': 3, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.MapStringForeignEnumEntry'},
    const {'1': 'oneof_uint32', '3': 111, '4': 1, '5': 13},
    const {'1': 'oneof_nested_message', '3': 112, '4': 1, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.NestedMessage'},
    const {'1': 'oneof_string', '3': 113, '4': 1, '5': 9},
    const {'1': 'oneof_bytes', '3': 114, '4': 1, '5': 12},
    const {'1': 'oneof_bool', '3': 115, '4': 1, '5': 8},
    const {'1': 'oneof_uint64', '3': 116, '4': 1, '5': 4},
    const {'1': 'oneof_float', '3': 117, '4': 1, '5': 2},
    const {'1': 'oneof_double', '3': 118, '4': 1, '5': 1},
    const {'1': 'oneof_enum', '3': 119, '4': 1, '5': 14, '6': '.protobuf_test_messages.proto3.TestAllTypes.NestedEnum'},
    const {'1': 'optional_bool_wrapper', '3': 201, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue'},
    const {'1': 'optional_int32_wrapper', '3': 202, '4': 1, '5': 11, '6': '.google.protobuf.Int32Value'},
    const {'1': 'optional_int64_wrapper', '3': 203, '4': 1, '5': 11, '6': '.google.protobuf.Int64Value'},
    const {'1': 'optional_uint32_wrapper', '3': 204, '4': 1, '5': 11, '6': '.google.protobuf.UInt32Value'},
    const {'1': 'optional_uint64_wrapper', '3': 205, '4': 1, '5': 11, '6': '.google.protobuf.UInt64Value'},
    const {'1': 'optional_float_wrapper', '3': 206, '4': 1, '5': 11, '6': '.google.protobuf.FloatValue'},
    const {'1': 'optional_double_wrapper', '3': 207, '4': 1, '5': 11, '6': '.google.protobuf.DoubleValue'},
    const {'1': 'optional_string_wrapper', '3': 208, '4': 1, '5': 11, '6': '.google.protobuf.StringValue'},
    const {'1': 'optional_bytes_wrapper', '3': 209, '4': 1, '5': 11, '6': '.google.protobuf.BytesValue'},
    const {'1': 'repeated_bool_wrapper', '3': 211, '4': 3, '5': 11, '6': '.google.protobuf.BoolValue'},
    const {'1': 'repeated_int32_wrapper', '3': 212, '4': 3, '5': 11, '6': '.google.protobuf.Int32Value'},
    const {'1': 'repeated_int64_wrapper', '3': 213, '4': 3, '5': 11, '6': '.google.protobuf.Int64Value'},
    const {'1': 'repeated_uint32_wrapper', '3': 214, '4': 3, '5': 11, '6': '.google.protobuf.UInt32Value'},
    const {'1': 'repeated_uint64_wrapper', '3': 215, '4': 3, '5': 11, '6': '.google.protobuf.UInt64Value'},
    const {'1': 'repeated_float_wrapper', '3': 216, '4': 3, '5': 11, '6': '.google.protobuf.FloatValue'},
    const {'1': 'repeated_double_wrapper', '3': 217, '4': 3, '5': 11, '6': '.google.protobuf.DoubleValue'},
    const {'1': 'repeated_string_wrapper', '3': 218, '4': 3, '5': 11, '6': '.google.protobuf.StringValue'},
    const {'1': 'repeated_bytes_wrapper', '3': 219, '4': 3, '5': 11, '6': '.google.protobuf.BytesValue'},
    const {'1': 'optional_duration', '3': 301, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'optional_timestamp', '3': 302, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'optional_field_mask', '3': 303, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask'},
    const {'1': 'optional_struct', '3': 304, '4': 1, '5': 11, '6': '.google.protobuf.Struct'},
    const {'1': 'optional_any', '3': 305, '4': 1, '5': 11, '6': '.google.protobuf.Any'},
    const {'1': 'optional_value', '3': 306, '4': 1, '5': 11, '6': '.google.protobuf.Value'},
    const {'1': 'repeated_duration', '3': 311, '4': 3, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'repeated_timestamp', '3': 312, '4': 3, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'repeated_fieldmask', '3': 313, '4': 3, '5': 11, '6': '.google.protobuf.FieldMask'},
    const {'1': 'repeated_struct', '3': 324, '4': 3, '5': 11, '6': '.google.protobuf.Struct'},
    const {'1': 'repeated_any', '3': 315, '4': 3, '5': 11, '6': '.google.protobuf.Any'},
    const {'1': 'repeated_value', '3': 316, '4': 3, '5': 11, '6': '.google.protobuf.Value'},
    const {'1': 'fieldname1', '3': 401, '4': 1, '5': 5},
    const {'1': 'field_name2', '3': 402, '4': 1, '5': 5},
    const {'1': '_field_name3', '3': 403, '4': 1, '5': 5},
    const {'1': 'field__name4_', '3': 404, '4': 1, '5': 5},
    const {'1': 'field0name5', '3': 405, '4': 1, '5': 5},
    const {'1': 'field_0_name6', '3': 406, '4': 1, '5': 5},
    const {'1': 'fieldName7', '3': 407, '4': 1, '5': 5},
    const {'1': 'FieldName8', '3': 408, '4': 1, '5': 5},
    const {'1': 'field_Name9', '3': 409, '4': 1, '5': 5},
    const {'1': 'Field_Name10', '3': 410, '4': 1, '5': 5},
    const {'1': 'FIELD_NAME11', '3': 411, '4': 1, '5': 5},
    const {'1': 'FIELD_name12', '3': 412, '4': 1, '5': 5},
    const {'1': '__field_name13', '3': 413, '4': 1, '5': 5},
    const {'1': '__Field_name14', '3': 414, '4': 1, '5': 5},
    const {'1': 'field__name15', '3': 415, '4': 1, '5': 5},
    const {'1': 'field__Name16', '3': 416, '4': 1, '5': 5},
    const {'1': 'field_name17__', '3': 417, '4': 1, '5': 5},
    const {'1': 'Field_name18__', '3': 418, '4': 1, '5': 5},
  ],
  '3': const [TestAllTypes_NestedMessage$json, TestAllTypes_MapInt32Int32Entry$json, TestAllTypes_MapInt64Int64Entry$json, TestAllTypes_MapUint32Uint32Entry$json, TestAllTypes_MapUint64Uint64Entry$json, TestAllTypes_MapSint32Sint32Entry$json, TestAllTypes_MapSint64Sint64Entry$json, TestAllTypes_MapFixed32Fixed32Entry$json, TestAllTypes_MapFixed64Fixed64Entry$json, TestAllTypes_MapSfixed32Sfixed32Entry$json, TestAllTypes_MapSfixed64Sfixed64Entry$json, TestAllTypes_MapInt32FloatEntry$json, TestAllTypes_MapInt32DoubleEntry$json, TestAllTypes_MapBoolBoolEntry$json, TestAllTypes_MapStringStringEntry$json, TestAllTypes_MapStringBytesEntry$json, TestAllTypes_MapStringNestedMessageEntry$json, TestAllTypes_MapStringForeignMessageEntry$json, TestAllTypes_MapStringNestedEnumEntry$json, TestAllTypes_MapStringForeignEnumEntry$json],
  '4': const [TestAllTypes_NestedEnum$json],
};

const TestAllTypes_NestedMessage$json = const {
  '1': 'NestedMessage',
  '2': const [
    const {'1': 'a', '3': 1, '4': 1, '5': 5},
    const {'1': 'corecursive', '3': 2, '4': 1, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes'},
  ],
};

const TestAllTypes_MapInt32Int32Entry$json = const {
  '1': 'MapInt32Int32Entry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 5},
    const {'1': 'value', '3': 2, '4': 1, '5': 5},
  ],
  '7': const {},
};

const TestAllTypes_MapInt64Int64Entry$json = const {
  '1': 'MapInt64Int64Entry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 3},
    const {'1': 'value', '3': 2, '4': 1, '5': 3},
  ],
  '7': const {},
};

const TestAllTypes_MapUint32Uint32Entry$json = const {
  '1': 'MapUint32Uint32Entry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 13},
    const {'1': 'value', '3': 2, '4': 1, '5': 13},
  ],
  '7': const {},
};

const TestAllTypes_MapUint64Uint64Entry$json = const {
  '1': 'MapUint64Uint64Entry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 4},
    const {'1': 'value', '3': 2, '4': 1, '5': 4},
  ],
  '7': const {},
};

const TestAllTypes_MapSint32Sint32Entry$json = const {
  '1': 'MapSint32Sint32Entry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 17},
    const {'1': 'value', '3': 2, '4': 1, '5': 17},
  ],
  '7': const {},
};

const TestAllTypes_MapSint64Sint64Entry$json = const {
  '1': 'MapSint64Sint64Entry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 18},
    const {'1': 'value', '3': 2, '4': 1, '5': 18},
  ],
  '7': const {},
};

const TestAllTypes_MapFixed32Fixed32Entry$json = const {
  '1': 'MapFixed32Fixed32Entry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 7},
    const {'1': 'value', '3': 2, '4': 1, '5': 7},
  ],
  '7': const {},
};

const TestAllTypes_MapFixed64Fixed64Entry$json = const {
  '1': 'MapFixed64Fixed64Entry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 6},
    const {'1': 'value', '3': 2, '4': 1, '5': 6},
  ],
  '7': const {},
};

const TestAllTypes_MapSfixed32Sfixed32Entry$json = const {
  '1': 'MapSfixed32Sfixed32Entry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 15},
    const {'1': 'value', '3': 2, '4': 1, '5': 15},
  ],
  '7': const {},
};

const TestAllTypes_MapSfixed64Sfixed64Entry$json = const {
  '1': 'MapSfixed64Sfixed64Entry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 16},
    const {'1': 'value', '3': 2, '4': 1, '5': 16},
  ],
  '7': const {},
};

const TestAllTypes_MapInt32FloatEntry$json = const {
  '1': 'MapInt32FloatEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 5},
    const {'1': 'value', '3': 2, '4': 1, '5': 2},
  ],
  '7': const {},
};

const TestAllTypes_MapInt32DoubleEntry$json = const {
  '1': 'MapInt32DoubleEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 5},
    const {'1': 'value', '3': 2, '4': 1, '5': 1},
  ],
  '7': const {},
};

const TestAllTypes_MapBoolBoolEntry$json = const {
  '1': 'MapBoolBoolEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 8},
    const {'1': 'value', '3': 2, '4': 1, '5': 8},
  ],
  '7': const {},
};

const TestAllTypes_MapStringStringEntry$json = const {
  '1': 'MapStringStringEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const TestAllTypes_MapStringBytesEntry$json = const {
  '1': 'MapStringBytesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 12},
  ],
  '7': const {},
};

const TestAllTypes_MapStringNestedMessageEntry$json = const {
  '1': 'MapStringNestedMessageEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.protobuf_test_messages.proto3.TestAllTypes.NestedMessage'},
  ],
  '7': const {},
};

const TestAllTypes_MapStringForeignMessageEntry$json = const {
  '1': 'MapStringForeignMessageEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.protobuf_test_messages.proto3.ForeignMessage'},
  ],
  '7': const {},
};

const TestAllTypes_MapStringNestedEnumEntry$json = const {
  '1': 'MapStringNestedEnumEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 14, '6': '.protobuf_test_messages.proto3.TestAllTypes.NestedEnum'},
  ],
  '7': const {},
};

const TestAllTypes_MapStringForeignEnumEntry$json = const {
  '1': 'MapStringForeignEnumEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 14, '6': '.protobuf_test_messages.proto3.ForeignEnum'},
  ],
  '7': const {},
};

const TestAllTypes_NestedEnum$json = const {
  '1': 'NestedEnum',
  '2': const [
    const {'1': 'FOO', '2': 0},
    const {'1': 'BAR', '2': 1},
    const {'1': 'BAZ', '2': 2},
    const {'1': 'NEG', '2': -1},
  ],
};

const ForeignMessage$json = const {
  '1': 'ForeignMessage',
  '2': const [
    const {'1': 'c', '3': 1, '4': 1, '5': 5},
  ],
};

