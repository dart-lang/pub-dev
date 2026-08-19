//
//  Generated code. Do not modify.
//  source: google/datastore/v1/query.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use entityResultDescriptor instead')
const EntityResult$json = {
  '1': 'EntityResult',
  '2': [
    {
      '1': 'entity',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Entity',
      '10': 'entity'
    },
    {'1': 'version', '3': 4, '4': 1, '5': 3, '10': 'version'},
    {
      '1': 'create_time',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createTime'
    },
    {
      '1': 'update_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updateTime'
    },
    {'1': 'cursor', '3': 3, '4': 1, '5': 12, '10': 'cursor'},
  ],
  '4': [EntityResult_ResultType$json],
};

@$core.Deprecated('Use entityResultDescriptor instead')
const EntityResult_ResultType$json = {
  '1': 'ResultType',
  '2': [
    {'1': 'RESULT_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'FULL', '2': 1},
    {'1': 'PROJECTION', '2': 2},
    {'1': 'KEY_ONLY', '2': 3},
  ],
};

/// Descriptor for `EntityResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entityResultDescriptor = $convert.base64Decode(
    'CgxFbnRpdHlSZXN1bHQSMwoGZW50aXR5GAEgASgLMhsuZ29vZ2xlLmRhdGFzdG9yZS52MS5Fbn'
    'RpdHlSBmVudGl0eRIYCgd2ZXJzaW9uGAQgASgDUgd2ZXJzaW9uEjsKC2NyZWF0ZV90aW1lGAYg'
    'ASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKY3JlYXRlVGltZRI7Cgt1cGRhdGVfdG'
    'ltZRgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCnVwZGF0ZVRpbWUSFgoGY3Vy'
    'c29yGAMgASgMUgZjdXJzb3IiUQoKUmVzdWx0VHlwZRIbChdSRVNVTFRfVFlQRV9VTlNQRUNJRk'
    'lFRBAAEggKBEZVTEwQARIOCgpQUk9KRUNUSU9OEAISDAoIS0VZX09OTFkQAw==');

@$core.Deprecated('Use queryDescriptor instead')
const Query$json = {
  '1': 'Query',
  '2': [
    {
      '1': 'projection',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.Projection',
      '10': 'projection'
    },
    {
      '1': 'kind',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.KindExpression',
      '10': 'kind'
    },
    {
      '1': 'filter',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Filter',
      '10': 'filter'
    },
    {
      '1': 'order',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.PropertyOrder',
      '10': 'order'
    },
    {
      '1': 'distinct_on',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.PropertyReference',
      '10': 'distinctOn'
    },
    {'1': 'start_cursor', '3': 7, '4': 1, '5': 12, '10': 'startCursor'},
    {'1': 'end_cursor', '3': 8, '4': 1, '5': 12, '10': 'endCursor'},
    {'1': 'offset', '3': 10, '4': 1, '5': 5, '10': 'offset'},
    {
      '1': 'limit',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Int32Value',
      '10': 'limit'
    },
  ],
};

/// Descriptor for `Query`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryDescriptor = $convert.base64Decode(
    'CgVRdWVyeRI/Cgpwcm9qZWN0aW9uGAIgAygLMh8uZ29vZ2xlLmRhdGFzdG9yZS52MS5Qcm9qZW'
    'N0aW9uUgpwcm9qZWN0aW9uEjcKBGtpbmQYAyADKAsyIy5nb29nbGUuZGF0YXN0b3JlLnYxLktp'
    'bmRFeHByZXNzaW9uUgRraW5kEjMKBmZpbHRlchgEIAEoCzIbLmdvb2dsZS5kYXRhc3RvcmUudj'
    'EuRmlsdGVyUgZmaWx0ZXISOAoFb3JkZXIYBSADKAsyIi5nb29nbGUuZGF0YXN0b3JlLnYxLlBy'
    'b3BlcnR5T3JkZXJSBW9yZGVyEkcKC2Rpc3RpbmN0X29uGAYgAygLMiYuZ29vZ2xlLmRhdGFzdG'
    '9yZS52MS5Qcm9wZXJ0eVJlZmVyZW5jZVIKZGlzdGluY3RPbhIhCgxzdGFydF9jdXJzb3IYByAB'
    'KAxSC3N0YXJ0Q3Vyc29yEh0KCmVuZF9jdXJzb3IYCCABKAxSCWVuZEN1cnNvchIWCgZvZmZzZX'
    'QYCiABKAVSBm9mZnNldBIxCgVsaW1pdBgMIAEoCzIbLmdvb2dsZS5wcm90b2J1Zi5JbnQzMlZh'
    'bHVlUgVsaW1pdA==');

@$core.Deprecated('Use aggregationQueryDescriptor instead')
const AggregationQuery$json = {
  '1': 'AggregationQuery',
  '2': [
    {
      '1': 'nested_query',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Query',
      '9': 0,
      '10': 'nestedQuery'
    },
    {
      '1': 'aggregations',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.AggregationQuery.Aggregation',
      '8': {},
      '10': 'aggregations'
    },
  ],
  '3': [AggregationQuery_Aggregation$json],
  '8': [
    {'1': 'query_type'},
  ],
};

@$core.Deprecated('Use aggregationQueryDescriptor instead')
const AggregationQuery_Aggregation$json = {
  '1': 'Aggregation',
  '2': [
    {
      '1': 'count',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.AggregationQuery.Aggregation.Count',
      '9': 0,
      '10': 'count'
    },
    {
      '1': 'sum',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.AggregationQuery.Aggregation.Sum',
      '9': 0,
      '10': 'sum'
    },
    {
      '1': 'avg',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.AggregationQuery.Aggregation.Avg',
      '9': 0,
      '10': 'avg'
    },
    {'1': 'alias', '3': 7, '4': 1, '5': 9, '8': {}, '10': 'alias'},
  ],
  '3': [
    AggregationQuery_Aggregation_Count$json,
    AggregationQuery_Aggregation_Sum$json,
    AggregationQuery_Aggregation_Avg$json
  ],
  '8': [
    {'1': 'operator'},
  ],
};

@$core.Deprecated('Use aggregationQueryDescriptor instead')
const AggregationQuery_Aggregation_Count$json = {
  '1': 'Count',
  '2': [
    {
      '1': 'up_to',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Int64Value',
      '8': {},
      '10': 'upTo'
    },
  ],
};

@$core.Deprecated('Use aggregationQueryDescriptor instead')
const AggregationQuery_Aggregation_Sum$json = {
  '1': 'Sum',
  '2': [
    {
      '1': 'property',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PropertyReference',
      '10': 'property'
    },
  ],
};

@$core.Deprecated('Use aggregationQueryDescriptor instead')
const AggregationQuery_Aggregation_Avg$json = {
  '1': 'Avg',
  '2': [
    {
      '1': 'property',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PropertyReference',
      '10': 'property'
    },
  ],
};

/// Descriptor for `AggregationQuery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aggregationQueryDescriptor = $convert.base64Decode(
    'ChBBZ2dyZWdhdGlvblF1ZXJ5Ej8KDG5lc3RlZF9xdWVyeRgBIAEoCzIaLmdvb2dsZS5kYXRhc3'
    'RvcmUudjEuUXVlcnlIAFILbmVzdGVkUXVlcnkSWgoMYWdncmVnYXRpb25zGAMgAygLMjEuZ29v'
    'Z2xlLmRhdGFzdG9yZS52MS5BZ2dyZWdhdGlvblF1ZXJ5LkFnZ3JlZ2F0aW9uQgPgQQFSDGFnZ3'
    'JlZ2F0aW9ucxrxAwoLQWdncmVnYXRpb24STwoFY291bnQYASABKAsyNy5nb29nbGUuZGF0YXN0'
    'b3JlLnYxLkFnZ3JlZ2F0aW9uUXVlcnkuQWdncmVnYXRpb24uQ291bnRIAFIFY291bnQSSQoDc3'
    'VtGAIgASgLMjUuZ29vZ2xlLmRhdGFzdG9yZS52MS5BZ2dyZWdhdGlvblF1ZXJ5LkFnZ3JlZ2F0'
    'aW9uLlN1bUgAUgNzdW0SSQoDYXZnGAMgASgLMjUuZ29vZ2xlLmRhdGFzdG9yZS52MS5BZ2dyZW'
    'dhdGlvblF1ZXJ5LkFnZ3JlZ2F0aW9uLkF2Z0gAUgNhdmcSGQoFYWxpYXMYByABKAlCA+BBAVIF'
    'YWxpYXMaPgoFQ291bnQSNQoFdXBfdG8YASABKAsyGy5nb29nbGUucHJvdG9idWYuSW50NjRWYW'
    'x1ZUID4EEBUgR1cFRvGkkKA1N1bRJCCghwcm9wZXJ0eRgBIAEoCzImLmdvb2dsZS5kYXRhc3Rv'
    'cmUudjEuUHJvcGVydHlSZWZlcmVuY2VSCHByb3BlcnR5GkkKA0F2ZxJCCghwcm9wZXJ0eRgBIA'
    'EoCzImLmdvb2dsZS5kYXRhc3RvcmUudjEuUHJvcGVydHlSZWZlcmVuY2VSCHByb3BlcnR5QgoK'
    'CG9wZXJhdG9yQgwKCnF1ZXJ5X3R5cGU=');

@$core.Deprecated('Use kindExpressionDescriptor instead')
const KindExpression$json = {
  '1': 'KindExpression',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `KindExpression`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kindExpressionDescriptor =
    $convert.base64Decode('Cg5LaW5kRXhwcmVzc2lvbhISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use propertyReferenceDescriptor instead')
const PropertyReference$json = {
  '1': 'PropertyReference',
  '2': [
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `PropertyReference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List propertyReferenceDescriptor = $convert
    .base64Decode('ChFQcm9wZXJ0eVJlZmVyZW5jZRISCgRuYW1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use projectionDescriptor instead')
const Projection$json = {
  '1': 'Projection',
  '2': [
    {
      '1': 'property',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PropertyReference',
      '10': 'property'
    },
  ],
};

/// Descriptor for `Projection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List projectionDescriptor = $convert.base64Decode(
    'CgpQcm9qZWN0aW9uEkIKCHByb3BlcnR5GAEgASgLMiYuZ29vZ2xlLmRhdGFzdG9yZS52MS5Qcm'
    '9wZXJ0eVJlZmVyZW5jZVIIcHJvcGVydHk=');

@$core.Deprecated('Use propertyOrderDescriptor instead')
const PropertyOrder$json = {
  '1': 'PropertyOrder',
  '2': [
    {
      '1': 'property',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PropertyReference',
      '10': 'property'
    },
    {
      '1': 'direction',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1.PropertyOrder.Direction',
      '10': 'direction'
    },
  ],
  '4': [PropertyOrder_Direction$json],
};

@$core.Deprecated('Use propertyOrderDescriptor instead')
const PropertyOrder_Direction$json = {
  '1': 'Direction',
  '2': [
    {'1': 'DIRECTION_UNSPECIFIED', '2': 0},
    {'1': 'ASCENDING', '2': 1},
    {'1': 'DESCENDING', '2': 2},
  ],
};

/// Descriptor for `PropertyOrder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List propertyOrderDescriptor = $convert.base64Decode(
    'Cg1Qcm9wZXJ0eU9yZGVyEkIKCHByb3BlcnR5GAEgASgLMiYuZ29vZ2xlLmRhdGFzdG9yZS52MS'
    '5Qcm9wZXJ0eVJlZmVyZW5jZVIIcHJvcGVydHkSSgoJZGlyZWN0aW9uGAIgASgOMiwuZ29vZ2xl'
    'LmRhdGFzdG9yZS52MS5Qcm9wZXJ0eU9yZGVyLkRpcmVjdGlvblIJZGlyZWN0aW9uIkUKCURpcm'
    'VjdGlvbhIZChVESVJFQ1RJT05fVU5TUEVDSUZJRUQQABINCglBU0NFTkRJTkcQARIOCgpERVND'
    'RU5ESU5HEAI=');

@$core.Deprecated('Use filterDescriptor instead')
const Filter$json = {
  '1': 'Filter',
  '2': [
    {
      '1': 'composite_filter',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.CompositeFilter',
      '9': 0,
      '10': 'compositeFilter'
    },
    {
      '1': 'property_filter',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PropertyFilter',
      '9': 0,
      '10': 'propertyFilter'
    },
  ],
  '8': [
    {'1': 'filter_type'},
  ],
};

/// Descriptor for `Filter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List filterDescriptor = $convert.base64Decode(
    'CgZGaWx0ZXISUQoQY29tcG9zaXRlX2ZpbHRlchgBIAEoCzIkLmdvb2dsZS5kYXRhc3RvcmUudj'
    'EuQ29tcG9zaXRlRmlsdGVySABSD2NvbXBvc2l0ZUZpbHRlchJOCg9wcm9wZXJ0eV9maWx0ZXIY'
    'AiABKAsyIy5nb29nbGUuZGF0YXN0b3JlLnYxLlByb3BlcnR5RmlsdGVySABSDnByb3BlcnR5Rm'
    'lsdGVyQg0KC2ZpbHRlcl90eXBl');

@$core.Deprecated('Use compositeFilterDescriptor instead')
const CompositeFilter$json = {
  '1': 'CompositeFilter',
  '2': [
    {
      '1': 'op',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1.CompositeFilter.Operator',
      '10': 'op'
    },
    {
      '1': 'filters',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.Filter',
      '10': 'filters'
    },
  ],
  '4': [CompositeFilter_Operator$json],
};

@$core.Deprecated('Use compositeFilterDescriptor instead')
const CompositeFilter_Operator$json = {
  '1': 'Operator',
  '2': [
    {'1': 'OPERATOR_UNSPECIFIED', '2': 0},
    {'1': 'AND', '2': 1},
    {'1': 'OR', '2': 2},
  ],
};

/// Descriptor for `CompositeFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List compositeFilterDescriptor = $convert.base64Decode(
    'Cg9Db21wb3NpdGVGaWx0ZXISPQoCb3AYASABKA4yLS5nb29nbGUuZGF0YXN0b3JlLnYxLkNvbX'
    'Bvc2l0ZUZpbHRlci5PcGVyYXRvclICb3ASNQoHZmlsdGVycxgCIAMoCzIbLmdvb2dsZS5kYXRh'
    'c3RvcmUudjEuRmlsdGVyUgdmaWx0ZXJzIjUKCE9wZXJhdG9yEhgKFE9QRVJBVE9SX1VOU1BFQ0'
    'lGSUVEEAASBwoDQU5EEAESBgoCT1IQAg==');

@$core.Deprecated('Use propertyFilterDescriptor instead')
const PropertyFilter$json = {
  '1': 'PropertyFilter',
  '2': [
    {
      '1': 'property',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PropertyReference',
      '10': 'property'
    },
    {
      '1': 'op',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1.PropertyFilter.Operator',
      '10': 'op'
    },
    {
      '1': 'value',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Value',
      '10': 'value'
    },
  ],
  '4': [PropertyFilter_Operator$json],
};

@$core.Deprecated('Use propertyFilterDescriptor instead')
const PropertyFilter_Operator$json = {
  '1': 'Operator',
  '2': [
    {'1': 'OPERATOR_UNSPECIFIED', '2': 0},
    {'1': 'LESS_THAN', '2': 1},
    {'1': 'LESS_THAN_OR_EQUAL', '2': 2},
    {'1': 'GREATER_THAN', '2': 3},
    {'1': 'GREATER_THAN_OR_EQUAL', '2': 4},
    {'1': 'EQUAL', '2': 5},
    {'1': 'IN', '2': 6},
    {'1': 'NOT_EQUAL', '2': 9},
    {'1': 'HAS_ANCESTOR', '2': 11},
    {'1': 'NOT_IN', '2': 13},
  ],
};

/// Descriptor for `PropertyFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List propertyFilterDescriptor = $convert.base64Decode(
    'Cg5Qcm9wZXJ0eUZpbHRlchJCCghwcm9wZXJ0eRgBIAEoCzImLmdvb2dsZS5kYXRhc3RvcmUudj'
    'EuUHJvcGVydHlSZWZlcmVuY2VSCHByb3BlcnR5EjwKAm9wGAIgASgOMiwuZ29vZ2xlLmRhdGFz'
    'dG9yZS52MS5Qcm9wZXJ0eUZpbHRlci5PcGVyYXRvclICb3ASMAoFdmFsdWUYAyABKAsyGi5nb2'
    '9nbGUuZGF0YXN0b3JlLnYxLlZhbHVlUgV2YWx1ZSK4AQoIT3BlcmF0b3ISGAoUT1BFUkFUT1Jf'
    'VU5TUEVDSUZJRUQQABINCglMRVNTX1RIQU4QARIWChJMRVNTX1RIQU5fT1JfRVFVQUwQAhIQCg'
    'xHUkVBVEVSX1RIQU4QAxIZChVHUkVBVEVSX1RIQU5fT1JfRVFVQUwQBBIJCgVFUVVBTBAFEgYK'
    'AklOEAYSDQoJTk9UX0VRVUFMEAkSEAoMSEFTX0FOQ0VTVE9SEAsSCgoGTk9UX0lOEA0=');

@$core.Deprecated('Use gqlQueryDescriptor instead')
const GqlQuery$json = {
  '1': 'GqlQuery',
  '2': [
    {'1': 'query_string', '3': 1, '4': 1, '5': 9, '10': 'queryString'},
    {'1': 'allow_literals', '3': 2, '4': 1, '5': 8, '10': 'allowLiterals'},
    {
      '1': 'named_bindings',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.GqlQuery.NamedBindingsEntry',
      '10': 'namedBindings'
    },
    {
      '1': 'positional_bindings',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.GqlQueryParameter',
      '10': 'positionalBindings'
    },
  ],
  '3': [GqlQuery_NamedBindingsEntry$json],
};

@$core.Deprecated('Use gqlQueryDescriptor instead')
const GqlQuery_NamedBindingsEntry$json = {
  '1': 'NamedBindingsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.GqlQueryParameter',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

/// Descriptor for `GqlQuery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gqlQueryDescriptor = $convert.base64Decode(
    'CghHcWxRdWVyeRIhCgxxdWVyeV9zdHJpbmcYASABKAlSC3F1ZXJ5U3RyaW5nEiUKDmFsbG93X2'
    'xpdGVyYWxzGAIgASgIUg1hbGxvd0xpdGVyYWxzElcKDm5hbWVkX2JpbmRpbmdzGAUgAygLMjAu'
    'Z29vZ2xlLmRhdGFzdG9yZS52MS5HcWxRdWVyeS5OYW1lZEJpbmRpbmdzRW50cnlSDW5hbWVkQm'
    'luZGluZ3MSVwoTcG9zaXRpb25hbF9iaW5kaW5ncxgEIAMoCzImLmdvb2dsZS5kYXRhc3RvcmUu'
    'djEuR3FsUXVlcnlQYXJhbWV0ZXJSEnBvc2l0aW9uYWxCaW5kaW5ncxpoChJOYW1lZEJpbmRpbm'
    'dzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSPAoFdmFsdWUYAiABKAsyJi5nb29nbGUuZGF0YXN0'
    'b3JlLnYxLkdxbFF1ZXJ5UGFyYW1ldGVyUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use gqlQueryParameterDescriptor instead')
const GqlQueryParameter$json = {
  '1': 'GqlQueryParameter',
  '2': [
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Value',
      '9': 0,
      '10': 'value'
    },
    {'1': 'cursor', '3': 3, '4': 1, '5': 12, '9': 0, '10': 'cursor'},
  ],
  '8': [
    {'1': 'parameter_type'},
  ],
};

/// Descriptor for `GqlQueryParameter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gqlQueryParameterDescriptor = $convert.base64Decode(
    'ChFHcWxRdWVyeVBhcmFtZXRlchIyCgV2YWx1ZRgCIAEoCzIaLmdvb2dsZS5kYXRhc3RvcmUudj'
    'EuVmFsdWVIAFIFdmFsdWUSGAoGY3Vyc29yGAMgASgMSABSBmN1cnNvckIQCg5wYXJhbWV0ZXJf'
    'dHlwZQ==');

@$core.Deprecated('Use queryResultBatchDescriptor instead')
const QueryResultBatch$json = {
  '1': 'QueryResultBatch',
  '2': [
    {'1': 'skipped_results', '3': 6, '4': 1, '5': 5, '10': 'skippedResults'},
    {'1': 'skipped_cursor', '3': 3, '4': 1, '5': 12, '10': 'skippedCursor'},
    {
      '1': 'entity_result_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1.EntityResult.ResultType',
      '10': 'entityResultType'
    },
    {
      '1': 'entity_results',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.EntityResult',
      '10': 'entityResults'
    },
    {'1': 'end_cursor', '3': 4, '4': 1, '5': 12, '10': 'endCursor'},
    {
      '1': 'more_results',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1.QueryResultBatch.MoreResultsType',
      '10': 'moreResults'
    },
    {'1': 'snapshot_version', '3': 7, '4': 1, '5': 3, '10': 'snapshotVersion'},
    {
      '1': 'read_time',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'readTime'
    },
  ],
  '4': [QueryResultBatch_MoreResultsType$json],
};

@$core.Deprecated('Use queryResultBatchDescriptor instead')
const QueryResultBatch_MoreResultsType$json = {
  '1': 'MoreResultsType',
  '2': [
    {'1': 'MORE_RESULTS_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'NOT_FINISHED', '2': 1},
    {'1': 'MORE_RESULTS_AFTER_LIMIT', '2': 2},
    {'1': 'MORE_RESULTS_AFTER_CURSOR', '2': 4},
    {'1': 'NO_MORE_RESULTS', '2': 3},
  ],
};

/// Descriptor for `QueryResultBatch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryResultBatchDescriptor = $convert.base64Decode(
    'ChBRdWVyeVJlc3VsdEJhdGNoEicKD3NraXBwZWRfcmVzdWx0cxgGIAEoBVIOc2tpcHBlZFJlc3'
    'VsdHMSJQoOc2tpcHBlZF9jdXJzb3IYAyABKAxSDXNraXBwZWRDdXJzb3ISWgoSZW50aXR5X3Jl'
    'c3VsdF90eXBlGAEgASgOMiwuZ29vZ2xlLmRhdGFzdG9yZS52MS5FbnRpdHlSZXN1bHQuUmVzdW'
    'x0VHlwZVIQZW50aXR5UmVzdWx0VHlwZRJICg5lbnRpdHlfcmVzdWx0cxgCIAMoCzIhLmdvb2ds'
    'ZS5kYXRhc3RvcmUudjEuRW50aXR5UmVzdWx0Ug1lbnRpdHlSZXN1bHRzEh0KCmVuZF9jdXJzb3'
    'IYBCABKAxSCWVuZEN1cnNvchJYCgxtb3JlX3Jlc3VsdHMYBSABKA4yNS5nb29nbGUuZGF0YXN0'
    'b3JlLnYxLlF1ZXJ5UmVzdWx0QmF0Y2guTW9yZVJlc3VsdHNUeXBlUgttb3JlUmVzdWx0cxIpCh'
    'BzbmFwc2hvdF92ZXJzaW9uGAcgASgDUg9zbmFwc2hvdFZlcnNpb24SNwoJcmVhZF90aW1lGAgg'
    'ASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIcmVhZFRpbWUimAEKD01vcmVSZXN1bH'
    'RzVHlwZRIhCh1NT1JFX1JFU1VMVFNfVFlQRV9VTlNQRUNJRklFRBAAEhAKDE5PVF9GSU5JU0hF'
    'RBABEhwKGE1PUkVfUkVTVUxUU19BRlRFUl9MSU1JVBACEh0KGU1PUkVfUkVTVUxUU19BRlRFUl'
    '9DVVJTT1IQBBITCg9OT19NT1JFX1JFU1VMVFMQAw==');
