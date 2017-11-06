///
//  Generated code. Do not modify.
///
library google.datastore.v1beta3_entity_pbjson;

const PartitionId$json = const {
  '1': 'PartitionId',
  '2': const [
    const {'1': 'project_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'namespace_id', '3': 4, '4': 1, '5': 9},
  ],
};

const Key$json = const {
  '1': 'Key',
  '2': const [
    const {'1': 'partition_id', '3': 1, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.PartitionId'},
    const {'1': 'path', '3': 2, '4': 3, '5': 11, '6': '.google.datastore.v1beta3.Key.PathElement'},
  ],
  '3': const [Key_PathElement$json],
};

const Key_PathElement$json = const {
  '1': 'PathElement',
  '2': const [
    const {'1': 'kind', '3': 1, '4': 1, '5': 9},
    const {'1': 'id', '3': 2, '4': 1, '5': 3},
    const {'1': 'name', '3': 3, '4': 1, '5': 9},
  ],
};

const ArrayValue$json = const {
  '1': 'ArrayValue',
  '2': const [
    const {'1': 'values', '3': 1, '4': 3, '5': 11, '6': '.google.datastore.v1beta3.Value'},
  ],
};

const Value$json = const {
  '1': 'Value',
  '2': const [
    const {'1': 'null_value', '3': 11, '4': 1, '5': 14, '6': '.google.protobuf.NullValue'},
    const {'1': 'boolean_value', '3': 1, '4': 1, '5': 8},
    const {'1': 'integer_value', '3': 2, '4': 1, '5': 3},
    const {'1': 'double_value', '3': 3, '4': 1, '5': 1},
    const {'1': 'timestamp_value', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'key_value', '3': 5, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.Key'},
    const {'1': 'string_value', '3': 17, '4': 1, '5': 9},
    const {'1': 'blob_value', '3': 18, '4': 1, '5': 12},
    const {'1': 'geo_point_value', '3': 8, '4': 1, '5': 11, '6': '.google.type.LatLng'},
    const {'1': 'entity_value', '3': 6, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.Entity'},
    const {'1': 'array_value', '3': 9, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.ArrayValue'},
    const {'1': 'meaning', '3': 14, '4': 1, '5': 5},
    const {'1': 'exclude_from_indexes', '3': 19, '4': 1, '5': 8},
  ],
};

const Entity$json = const {
  '1': 'Entity',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.Key'},
    const {'1': 'properties', '3': 3, '4': 3, '5': 11, '6': '.google.datastore.v1beta3.Entity.PropertiesEntry'},
  ],
  '3': const [Entity_PropertiesEntry$json],
};

const Entity_PropertiesEntry$json = const {
  '1': 'PropertiesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.Value'},
  ],
  '7': const {},
};

