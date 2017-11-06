///
//  Generated code. Do not modify.
///
library google.protobuf_descriptor_pbjson;

const FileDescriptorSet$json = const {
  '1': 'FileDescriptorSet',
  '2': const [
    const {'1': 'file', '3': 1, '4': 3, '5': 11, '6': '.google.protobuf.FileDescriptorProto'},
  ],
};

const FileDescriptorProto$json = const {
  '1': 'FileDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'package', '3': 2, '4': 1, '5': 9},
    const {'1': 'dependency', '3': 3, '4': 3, '5': 9},
    const {'1': 'public_dependency', '3': 10, '4': 3, '5': 5},
    const {'1': 'weak_dependency', '3': 11, '4': 3, '5': 5},
    const {'1': 'message_type', '3': 4, '4': 3, '5': 11, '6': '.google.protobuf.DescriptorProto'},
    const {'1': 'enum_type', '3': 5, '4': 3, '5': 11, '6': '.google.protobuf.EnumDescriptorProto'},
    const {'1': 'service', '3': 6, '4': 3, '5': 11, '6': '.google.protobuf.ServiceDescriptorProto'},
    const {'1': 'extension', '3': 7, '4': 3, '5': 11, '6': '.google.protobuf.FieldDescriptorProto'},
    const {'1': 'options', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.FileOptions'},
    const {'1': 'source_code_info', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.SourceCodeInfo'},
    const {'1': 'syntax', '3': 12, '4': 1, '5': 9},
  ],
};

const DescriptorProto$json = const {
  '1': 'DescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'field', '3': 2, '4': 3, '5': 11, '6': '.google.protobuf.FieldDescriptorProto'},
    const {'1': 'extension', '3': 6, '4': 3, '5': 11, '6': '.google.protobuf.FieldDescriptorProto'},
    const {'1': 'nested_type', '3': 3, '4': 3, '5': 11, '6': '.google.protobuf.DescriptorProto'},
    const {'1': 'enum_type', '3': 4, '4': 3, '5': 11, '6': '.google.protobuf.EnumDescriptorProto'},
    const {'1': 'extension_range', '3': 5, '4': 3, '5': 11, '6': '.google.protobuf.DescriptorProto.ExtensionRange'},
    const {'1': 'oneof_decl', '3': 8, '4': 3, '5': 11, '6': '.google.protobuf.OneofDescriptorProto'},
    const {'1': 'options', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.MessageOptions'},
    const {'1': 'reserved_range', '3': 9, '4': 3, '5': 11, '6': '.google.protobuf.DescriptorProto.ReservedRange'},
    const {'1': 'reserved_name', '3': 10, '4': 3, '5': 9},
  ],
  '3': const [DescriptorProto_ExtensionRange$json, DescriptorProto_ReservedRange$json],
};

const DescriptorProto_ExtensionRange$json = const {
  '1': 'ExtensionRange',
  '2': const [
    const {'1': 'start', '3': 1, '4': 1, '5': 5},
    const {'1': 'end', '3': 2, '4': 1, '5': 5},
  ],
};

const DescriptorProto_ReservedRange$json = const {
  '1': 'ReservedRange',
  '2': const [
    const {'1': 'start', '3': 1, '4': 1, '5': 5},
    const {'1': 'end', '3': 2, '4': 1, '5': 5},
  ],
};

const FieldDescriptorProto$json = const {
  '1': 'FieldDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'number', '3': 3, '4': 1, '5': 5},
    const {'1': 'label', '3': 4, '4': 1, '5': 14, '6': '.google.protobuf.FieldDescriptorProto.Label'},
    const {'1': 'type', '3': 5, '4': 1, '5': 14, '6': '.google.protobuf.FieldDescriptorProto.Type'},
    const {'1': 'type_name', '3': 6, '4': 1, '5': 9},
    const {'1': 'extendee', '3': 2, '4': 1, '5': 9},
    const {'1': 'default_value', '3': 7, '4': 1, '5': 9},
    const {'1': 'oneof_index', '3': 9, '4': 1, '5': 5},
    const {'1': 'json_name', '3': 10, '4': 1, '5': 9},
    const {'1': 'options', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.FieldOptions'},
  ],
  '4': const [FieldDescriptorProto_Type$json, FieldDescriptorProto_Label$json],
};

const FieldDescriptorProto_Type$json = const {
  '1': 'Type',
  '2': const [
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

const FieldDescriptorProto_Label$json = const {
  '1': 'Label',
  '2': const [
    const {'1': 'LABEL_OPTIONAL', '2': 1},
    const {'1': 'LABEL_REQUIRED', '2': 2},
    const {'1': 'LABEL_REPEATED', '2': 3},
  ],
};

const OneofDescriptorProto$json = const {
  '1': 'OneofDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'options', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.OneofOptions'},
  ],
};

const EnumDescriptorProto$json = const {
  '1': 'EnumDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 3, '5': 11, '6': '.google.protobuf.EnumValueDescriptorProto'},
    const {'1': 'options', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.EnumOptions'},
  ],
};

const EnumValueDescriptorProto$json = const {
  '1': 'EnumValueDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'number', '3': 2, '4': 1, '5': 5},
    const {'1': 'options', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.EnumValueOptions'},
  ],
};

const ServiceDescriptorProto$json = const {
  '1': 'ServiceDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'method', '3': 2, '4': 3, '5': 11, '6': '.google.protobuf.MethodDescriptorProto'},
    const {'1': 'options', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.ServiceOptions'},
  ],
};

const MethodDescriptorProto$json = const {
  '1': 'MethodDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'input_type', '3': 2, '4': 1, '5': 9},
    const {'1': 'output_type', '3': 3, '4': 1, '5': 9},
    const {'1': 'options', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.MethodOptions'},
    const {'1': 'client_streaming', '3': 5, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'server_streaming', '3': 6, '4': 1, '5': 8, '7': 'false'},
  ],
};

const FileOptions$json = const {
  '1': 'FileOptions',
  '2': const [
    const {'1': 'java_package', '3': 1, '4': 1, '5': 9},
    const {'1': 'java_outer_classname', '3': 8, '4': 1, '5': 9},
    const {'1': 'java_multiple_files', '3': 10, '4': 1, '5': 8, '7': 'false'},
    const {
      '1': 'java_generate_equals_and_hash',
      '3': 20,
      '4': 1,
      '5': 8,
      '8': const {'3': true},
    },
    const {'1': 'java_string_check_utf8', '3': 27, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'optimize_for', '3': 9, '4': 1, '5': 14, '6': '.google.protobuf.FileOptions.OptimizeMode', '7': 'SPEED'},
    const {'1': 'go_package', '3': 11, '4': 1, '5': 9},
    const {'1': 'cc_generic_services', '3': 16, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'java_generic_services', '3': 17, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'py_generic_services', '3': 18, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'deprecated', '3': 23, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'cc_enable_arenas', '3': 31, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'objc_class_prefix', '3': 36, '4': 1, '5': 9},
    const {'1': 'csharp_namespace', '3': 37, '4': 1, '5': 9},
    const {'1': 'swift_prefix', '3': 39, '4': 1, '5': 9},
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.google.protobuf.UninterpretedOption'},
  ],
  '4': const [FileOptions_OptimizeMode$json],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const FileOptions_OptimizeMode$json = const {
  '1': 'OptimizeMode',
  '2': const [
    const {'1': 'SPEED', '2': 1},
    const {'1': 'CODE_SIZE', '2': 2},
    const {'1': 'LITE_RUNTIME', '2': 3},
  ],
};

const MessageOptions$json = const {
  '1': 'MessageOptions',
  '2': const [
    const {'1': 'message_set_wire_format', '3': 1, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'no_standard_descriptor_accessor', '3': 2, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'deprecated', '3': 3, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'map_entry', '3': 7, '4': 1, '5': 8},
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.google.protobuf.UninterpretedOption'},
  ],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const FieldOptions$json = const {
  '1': 'FieldOptions',
  '2': const [
    const {'1': 'ctype', '3': 1, '4': 1, '5': 14, '6': '.google.protobuf.FieldOptions.CType', '7': 'STRING'},
    const {'1': 'packed', '3': 2, '4': 1, '5': 8},
    const {'1': 'jstype', '3': 6, '4': 1, '5': 14, '6': '.google.protobuf.FieldOptions.JSType', '7': 'JS_NORMAL'},
    const {'1': 'lazy', '3': 5, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'deprecated', '3': 3, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'weak', '3': 10, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.google.protobuf.UninterpretedOption'},
  ],
  '4': const [FieldOptions_CType$json, FieldOptions_JSType$json],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const FieldOptions_CType$json = const {
  '1': 'CType',
  '2': const [
    const {'1': 'STRING', '2': 0},
    const {'1': 'CORD', '2': 1},
    const {'1': 'STRING_PIECE', '2': 2},
  ],
};

const FieldOptions_JSType$json = const {
  '1': 'JSType',
  '2': const [
    const {'1': 'JS_NORMAL', '2': 0},
    const {'1': 'JS_STRING', '2': 1},
    const {'1': 'JS_NUMBER', '2': 2},
  ],
};

const OneofOptions$json = const {
  '1': 'OneofOptions',
  '2': const [
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.google.protobuf.UninterpretedOption'},
  ],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const EnumOptions$json = const {
  '1': 'EnumOptions',
  '2': const [
    const {'1': 'allow_alias', '3': 2, '4': 1, '5': 8},
    const {'1': 'deprecated', '3': 3, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.google.protobuf.UninterpretedOption'},
  ],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const EnumValueOptions$json = const {
  '1': 'EnumValueOptions',
  '2': const [
    const {'1': 'deprecated', '3': 1, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.google.protobuf.UninterpretedOption'},
  ],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const ServiceOptions$json = const {
  '1': 'ServiceOptions',
  '2': const [
    const {'1': 'deprecated', '3': 33, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.google.protobuf.UninterpretedOption'},
  ],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const MethodOptions$json = const {
  '1': 'MethodOptions',
  '2': const [
    const {'1': 'deprecated', '3': 33, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'idempotency_level', '3': 34, '4': 1, '5': 14, '6': '.google.protobuf.MethodOptions.IdempotencyLevel', '7': 'IDEMPOTENCY_UNKNOWN'},
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.google.protobuf.UninterpretedOption'},
  ],
  '4': const [MethodOptions_IdempotencyLevel$json],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const MethodOptions_IdempotencyLevel$json = const {
  '1': 'IdempotencyLevel',
  '2': const [
    const {'1': 'IDEMPOTENCY_UNKNOWN', '2': 0},
    const {'1': 'NO_SIDE_EFFECTS', '2': 1},
    const {'1': 'IDEMPOTENT', '2': 2},
  ],
};

const UninterpretedOption$json = const {
  '1': 'UninterpretedOption',
  '2': const [
    const {'1': 'name', '3': 2, '4': 3, '5': 11, '6': '.google.protobuf.UninterpretedOption.NamePart'},
    const {'1': 'identifier_value', '3': 3, '4': 1, '5': 9},
    const {'1': 'positive_int_value', '3': 4, '4': 1, '5': 4},
    const {'1': 'negative_int_value', '3': 5, '4': 1, '5': 3},
    const {'1': 'double_value', '3': 6, '4': 1, '5': 1},
    const {'1': 'string_value', '3': 7, '4': 1, '5': 12},
    const {'1': 'aggregate_value', '3': 8, '4': 1, '5': 9},
  ],
  '3': const [UninterpretedOption_NamePart$json],
};

const UninterpretedOption_NamePart$json = const {
  '1': 'NamePart',
  '2': const [
    const {'1': 'name_part', '3': 1, '4': 2, '5': 9},
    const {'1': 'is_extension', '3': 2, '4': 2, '5': 8},
  ],
};

const SourceCodeInfo$json = const {
  '1': 'SourceCodeInfo',
  '2': const [
    const {'1': 'location', '3': 1, '4': 3, '5': 11, '6': '.google.protobuf.SourceCodeInfo.Location'},
  ],
  '3': const [SourceCodeInfo_Location$json],
};

const SourceCodeInfo_Location$json = const {
  '1': 'Location',
  '2': const [
    const {
      '1': 'path',
      '3': 1,
      '4': 3,
      '5': 5,
      '8': const {'2': true},
    },
    const {
      '1': 'span',
      '3': 2,
      '4': 3,
      '5': 5,
      '8': const {'2': true},
    },
    const {'1': 'leading_comments', '3': 3, '4': 1, '5': 9},
    const {'1': 'trailing_comments', '3': 4, '4': 1, '5': 9},
    const {'1': 'leading_detached_comments', '3': 6, '4': 3, '5': 9},
  ],
};

const GeneratedCodeInfo$json = const {
  '1': 'GeneratedCodeInfo',
  '2': const [
    const {'1': 'annotation', '3': 1, '4': 3, '5': 11, '6': '.google.protobuf.GeneratedCodeInfo.Annotation'},
  ],
  '3': const [GeneratedCodeInfo_Annotation$json],
};

const GeneratedCodeInfo_Annotation$json = const {
  '1': 'Annotation',
  '2': const [
    const {
      '1': 'path',
      '3': 1,
      '4': 3,
      '5': 5,
      '8': const {'2': true},
    },
    const {'1': 'source_file', '3': 2, '4': 1, '5': 9},
    const {'1': 'begin', '3': 3, '4': 1, '5': 5},
    const {'1': 'end', '3': 4, '4': 1, '5': 5},
  ],
};

