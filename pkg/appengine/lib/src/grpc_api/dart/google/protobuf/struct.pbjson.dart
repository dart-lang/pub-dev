///
//  Generated code. Do not modify.
///
library google.protobuf_struct_pbjson;

const NullValue$json = const {
  '1': 'NullValue',
  '2': const [
    const {'1': 'NULL_VALUE', '2': 0},
  ],
};

const Struct$json = const {
  '1': 'Struct',
  '2': const [
    const {'1': 'fields', '3': 1, '4': 3, '5': 11, '6': '.google.protobuf.Struct.FieldsEntry'},
  ],
  '3': const [Struct_FieldsEntry$json],
};

const Struct_FieldsEntry$json = const {
  '1': 'FieldsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Value'},
  ],
  '7': const {},
};

const Value$json = const {
  '1': 'Value',
  '2': const [
    const {'1': 'null_value', '3': 1, '4': 1, '5': 14, '6': '.google.protobuf.NullValue'},
    const {'1': 'number_value', '3': 2, '4': 1, '5': 1},
    const {'1': 'string_value', '3': 3, '4': 1, '5': 9},
    const {'1': 'bool_value', '3': 4, '4': 1, '5': 8},
    const {'1': 'struct_value', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Struct'},
    const {'1': 'list_value', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.ListValue'},
  ],
};

const ListValue$json = const {
  '1': 'ListValue',
  '2': const [
    const {'1': 'values', '3': 1, '4': 3, '5': 11, '6': '.google.protobuf.Value'},
  ],
};

