///
//  Generated code. Do not modify.
///
library google.protobuf_type_pbjson;

const Syntax$json = const {
  '1': 'Syntax',
  '2': const [
    const {'1': 'SYNTAX_PROTO2', '2': 0},
    const {'1': 'SYNTAX_PROTO3', '2': 1},
  ],
};

const Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'fields', '3': 2, '4': 3, '5': 11, '6': '.google.protobuf.Field'},
    const {'1': 'oneofs', '3': 3, '4': 3, '5': 9},
    const {'1': 'options', '3': 4, '4': 3, '5': 11, '6': '.google.protobuf.Option'},
    const {'1': 'source_context', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.SourceContext'},
    const {'1': 'syntax', '3': 6, '4': 1, '5': 14, '6': '.google.protobuf.Syntax'},
  ],
};

const Field$json = const {
  '1': 'Field',
  '2': const [
    const {'1': 'kind', '3': 1, '4': 1, '5': 14, '6': '.google.protobuf.Field.Kind'},
    const {'1': 'cardinality', '3': 2, '4': 1, '5': 14, '6': '.google.protobuf.Field.Cardinality'},
    const {'1': 'number', '3': 3, '4': 1, '5': 5},
    const {'1': 'name', '3': 4, '4': 1, '5': 9},
    const {'1': 'type_url', '3': 6, '4': 1, '5': 9},
    const {'1': 'oneof_index', '3': 7, '4': 1, '5': 5},
    const {'1': 'packed', '3': 8, '4': 1, '5': 8},
    const {'1': 'options', '3': 9, '4': 3, '5': 11, '6': '.google.protobuf.Option'},
    const {'1': 'json_name', '3': 10, '4': 1, '5': 9},
    const {'1': 'default_value', '3': 11, '4': 1, '5': 9},
  ],
  '4': const [Field_Kind$json, Field_Cardinality$json],
};

const Field_Kind$json = const {
  '1': 'Kind',
  '2': const [
    const {'1': 'TYPE_UNKNOWN', '2': 0},
    const {'1': 'TYPE_DOUBLE', '2': 1},
    const {'1': 'TYPE_FLOAT', '2': 2},
    const {'1': 'TYPE_INT64', '2': 3},
    const {'1': 'TYPE_UINT64', '2': 4},
    const {'1': 'TYPE_INT32', '2': 5},
    const {'1': 'TYPE_FIXED64', '2': 6},
    const {'1': 'TYPE_FIXED32', '2': 7},
    const {'1': 'TYPE_BOOL', '2': 8},
    const {'1': 'TYPE_STRING', '2': 9},
    const {'1': 'TYPE_GROUP', '2': 10},
    const {'1': 'TYPE_MESSAGE', '2': 11},
    const {'1': 'TYPE_BYTES', '2': 12},
    const {'1': 'TYPE_UINT32', '2': 13},
    const {'1': 'TYPE_ENUM', '2': 14},
    const {'1': 'TYPE_SFIXED32', '2': 15},
    const {'1': 'TYPE_SFIXED64', '2': 16},
    const {'1': 'TYPE_SINT32', '2': 17},
    const {'1': 'TYPE_SINT64', '2': 18},
  ],
};

const Field_Cardinality$json = const {
  '1': 'Cardinality',
  '2': const [
    const {'1': 'CARDINALITY_UNKNOWN', '2': 0},
    const {'1': 'CARDINALITY_OPTIONAL', '2': 1},
    const {'1': 'CARDINALITY_REQUIRED', '2': 2},
    const {'1': 'CARDINALITY_REPEATED', '2': 3},
  ],
};

const Enum$json = const {
  '1': 'Enum',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'enumvalue', '3': 2, '4': 3, '5': 11, '6': '.google.protobuf.EnumValue'},
    const {'1': 'options', '3': 3, '4': 3, '5': 11, '6': '.google.protobuf.Option'},
    const {'1': 'source_context', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.SourceContext'},
    const {'1': 'syntax', '3': 5, '4': 1, '5': 14, '6': '.google.protobuf.Syntax'},
  ],
};

const EnumValue$json = const {
  '1': 'EnumValue',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'number', '3': 2, '4': 1, '5': 5},
    const {'1': 'options', '3': 3, '4': 3, '5': 11, '6': '.google.protobuf.Option'},
  ],
};

const Option$json = const {
  '1': 'Option',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Any'},
  ],
};

