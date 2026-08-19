//
//  Generated code. Do not modify.
//  source: google/datastore/v1/entity.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use partitionIdDescriptor instead')
const PartitionId$json = {
  '1': 'PartitionId',
  '2': [
    {'1': 'project_id', '3': 2, '4': 1, '5': 9, '10': 'projectId'},
    {'1': 'database_id', '3': 3, '4': 1, '5': 9, '10': 'databaseId'},
    {'1': 'namespace_id', '3': 4, '4': 1, '5': 9, '10': 'namespaceId'},
  ],
};

/// Descriptor for `PartitionId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List partitionIdDescriptor = $convert.base64Decode(
    'CgtQYXJ0aXRpb25JZBIdCgpwcm9qZWN0X2lkGAIgASgJUglwcm9qZWN0SWQSHwoLZGF0YWJhc2'
    'VfaWQYAyABKAlSCmRhdGFiYXNlSWQSIQoMbmFtZXNwYWNlX2lkGAQgASgJUgtuYW1lc3BhY2VJ'
    'ZA==');

@$core.Deprecated('Use keyDescriptor instead')
const Key$json = {
  '1': 'Key',
  '2': [
    {
      '1': 'partition_id',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PartitionId',
      '10': 'partitionId'
    },
    {
      '1': 'path',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.Key.PathElement',
      '10': 'path'
    },
  ],
  '3': [Key_PathElement$json],
};

@$core.Deprecated('Use keyDescriptor instead')
const Key_PathElement$json = {
  '1': 'PathElement',
  '2': [
    {'1': 'kind', '3': 1, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'id', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'id'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'name'},
  ],
  '8': [
    {'1': 'id_type'},
  ],
};

/// Descriptor for `Key`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyDescriptor = $convert.base64Decode(
    'CgNLZXkSQwoMcGFydGl0aW9uX2lkGAEgASgLMiAuZ29vZ2xlLmRhdGFzdG9yZS52MS5QYXJ0aX'
    'Rpb25JZFILcGFydGl0aW9uSWQSOAoEcGF0aBgCIAMoCzIkLmdvb2dsZS5kYXRhc3RvcmUudjEu'
    'S2V5LlBhdGhFbGVtZW50UgRwYXRoGlQKC1BhdGhFbGVtZW50EhIKBGtpbmQYASABKAlSBGtpbm'
    'QSEAoCaWQYAiABKANIAFICaWQSFAoEbmFtZRgDIAEoCUgAUgRuYW1lQgkKB2lkX3R5cGU=');

@$core.Deprecated('Use arrayValueDescriptor instead')
const ArrayValue$json = {
  '1': 'ArrayValue',
  '2': [
    {
      '1': 'values',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.Value',
      '10': 'values'
    },
  ],
};

/// Descriptor for `ArrayValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List arrayValueDescriptor = $convert.base64Decode(
    'CgpBcnJheVZhbHVlEjIKBnZhbHVlcxgBIAMoCzIaLmdvb2dsZS5kYXRhc3RvcmUudjEuVmFsdW'
    'VSBnZhbHVlcw==');

@$core.Deprecated('Use valueDescriptor instead')
const Value$json = {
  '1': 'Value',
  '2': [
    {
      '1': 'null_value',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.NullValue',
      '9': 0,
      '10': 'nullValue'
    },
    {
      '1': 'boolean_value',
      '3': 1,
      '4': 1,
      '5': 8,
      '9': 0,
      '10': 'booleanValue'
    },
    {
      '1': 'integer_value',
      '3': 2,
      '4': 1,
      '5': 3,
      '9': 0,
      '10': 'integerValue'
    },
    {'1': 'double_value', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'doubleValue'},
    {
      '1': 'timestamp_value',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 0,
      '10': 'timestampValue'
    },
    {
      '1': 'key_value',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Key',
      '9': 0,
      '10': 'keyValue'
    },
    {'1': 'string_value', '3': 17, '4': 1, '5': 9, '9': 0, '10': 'stringValue'},
    {'1': 'blob_value', '3': 18, '4': 1, '5': 12, '9': 0, '10': 'blobValue'},
    {
      '1': 'geo_point_value',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.type.LatLng',
      '9': 0,
      '10': 'geoPointValue'
    },
    {
      '1': 'entity_value',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Entity',
      '9': 0,
      '10': 'entityValue'
    },
    {
      '1': 'array_value',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.ArrayValue',
      '9': 0,
      '10': 'arrayValue'
    },
    {'1': 'meaning', '3': 14, '4': 1, '5': 5, '10': 'meaning'},
    {
      '1': 'exclude_from_indexes',
      '3': 19,
      '4': 1,
      '5': 8,
      '10': 'excludeFromIndexes'
    },
  ],
  '8': [
    {'1': 'value_type'},
  ],
};

/// Descriptor for `Value`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List valueDescriptor = $convert.base64Decode(
    'CgVWYWx1ZRI7CgpudWxsX3ZhbHVlGAsgASgOMhouZ29vZ2xlLnByb3RvYnVmLk51bGxWYWx1ZU'
    'gAUgludWxsVmFsdWUSJQoNYm9vbGVhbl92YWx1ZRgBIAEoCEgAUgxib29sZWFuVmFsdWUSJQoN'
    'aW50ZWdlcl92YWx1ZRgCIAEoA0gAUgxpbnRlZ2VyVmFsdWUSIwoMZG91YmxlX3ZhbHVlGAMgAS'
    'gBSABSC2RvdWJsZVZhbHVlEkUKD3RpbWVzdGFtcF92YWx1ZRgKIAEoCzIaLmdvb2dsZS5wcm90'
    'b2J1Zi5UaW1lc3RhbXBIAFIOdGltZXN0YW1wVmFsdWUSNwoJa2V5X3ZhbHVlGAUgASgLMhguZ2'
    '9vZ2xlLmRhdGFzdG9yZS52MS5LZXlIAFIIa2V5VmFsdWUSIwoMc3RyaW5nX3ZhbHVlGBEgASgJ'
    'SABSC3N0cmluZ1ZhbHVlEh8KCmJsb2JfdmFsdWUYEiABKAxIAFIJYmxvYlZhbHVlEj0KD2dlb1'
    '9wb2ludF92YWx1ZRgIIAEoCzITLmdvb2dsZS50eXBlLkxhdExuZ0gAUg1nZW9Qb2ludFZhbHVl'
    'EkAKDGVudGl0eV92YWx1ZRgGIAEoCzIbLmdvb2dsZS5kYXRhc3RvcmUudjEuRW50aXR5SABSC2'
    'VudGl0eVZhbHVlEkIKC2FycmF5X3ZhbHVlGAkgASgLMh8uZ29vZ2xlLmRhdGFzdG9yZS52MS5B'
    'cnJheVZhbHVlSABSCmFycmF5VmFsdWUSGAoHbWVhbmluZxgOIAEoBVIHbWVhbmluZxIwChRleG'
    'NsdWRlX2Zyb21faW5kZXhlcxgTIAEoCFISZXhjbHVkZUZyb21JbmRleGVzQgwKCnZhbHVlX3R5'
    'cGU=');

@$core.Deprecated('Use entityDescriptor instead')
const Entity$json = {
  '1': 'Entity',
  '2': [
    {
      '1': 'key',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Key',
      '10': 'key'
    },
    {
      '1': 'properties',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.Entity.PropertiesEntry',
      '10': 'properties'
    },
  ],
  '3': [Entity_PropertiesEntry$json],
};

@$core.Deprecated('Use entityDescriptor instead')
const Entity_PropertiesEntry$json = {
  '1': 'PropertiesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Value',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

/// Descriptor for `Entity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entityDescriptor = $convert.base64Decode(
    'CgZFbnRpdHkSKgoDa2V5GAEgASgLMhguZ29vZ2xlLmRhdGFzdG9yZS52MS5LZXlSA2tleRJLCg'
    'pwcm9wZXJ0aWVzGAMgAygLMisuZ29vZ2xlLmRhdGFzdG9yZS52MS5FbnRpdHkuUHJvcGVydGll'
    'c0VudHJ5Ugpwcm9wZXJ0aWVzGlkKD1Byb3BlcnRpZXNFbnRyeRIQCgNrZXkYASABKAlSA2tleR'
    'IwCgV2YWx1ZRgCIAEoCzIaLmdvb2dsZS5kYXRhc3RvcmUudjEuVmFsdWVSBXZhbHVlOgI4AQ==');
