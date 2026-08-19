//
//  Generated code. Do not modify.
//  source: google/datastore/v1beta3/query.proto
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
      '6': '.google.datastore.v1beta3.Entity',
      '10': 'entity'
    },
    {'1': 'version', '3': 4, '4': 1, '5': 3, '10': 'version'},
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
    'CgxFbnRpdHlSZXN1bHQSOAoGZW50aXR5GAEgASgLMiAuZ29vZ2xlLmRhdGFzdG9yZS52MWJldG'
    'EzLkVudGl0eVIGZW50aXR5EhgKB3ZlcnNpb24YBCABKANSB3ZlcnNpb24SFgoGY3Vyc29yGAMg'
    'ASgMUgZjdXJzb3IiUQoKUmVzdWx0VHlwZRIbChdSRVNVTFRfVFlQRV9VTlNQRUNJRklFRBAAEg'
    'gKBEZVTEwQARIOCgpQUk9KRUNUSU9OEAISDAoIS0VZX09OTFkQAw==');

@$core.Deprecated('Use queryDescriptor instead')
const Query$json = {
  '1': 'Query',
  '2': [
    {
      '1': 'projection',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.Projection',
      '10': 'projection'
    },
    {
      '1': 'kind',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.KindExpression',
      '10': 'kind'
    },
    {
      '1': 'filter',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.Filter',
      '10': 'filter'
    },
    {
      '1': 'order',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.PropertyOrder',
      '10': 'order'
    },
    {
      '1': 'distinct_on',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.PropertyReference',
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
    'CgVRdWVyeRJECgpwcm9qZWN0aW9uGAIgAygLMiQuZ29vZ2xlLmRhdGFzdG9yZS52MWJldGEzLl'
    'Byb2plY3Rpb25SCnByb2plY3Rpb24SPAoEa2luZBgDIAMoCzIoLmdvb2dsZS5kYXRhc3RvcmUu'
    'djFiZXRhMy5LaW5kRXhwcmVzc2lvblIEa2luZBI4CgZmaWx0ZXIYBCABKAsyIC5nb29nbGUuZG'
    'F0YXN0b3JlLnYxYmV0YTMuRmlsdGVyUgZmaWx0ZXISPQoFb3JkZXIYBSADKAsyJy5nb29nbGUu'
    'ZGF0YXN0b3JlLnYxYmV0YTMuUHJvcGVydHlPcmRlclIFb3JkZXISTAoLZGlzdGluY3Rfb24YBi'
    'ADKAsyKy5nb29nbGUuZGF0YXN0b3JlLnYxYmV0YTMuUHJvcGVydHlSZWZlcmVuY2VSCmRpc3Rp'
    'bmN0T24SIQoMc3RhcnRfY3Vyc29yGAcgASgMUgtzdGFydEN1cnNvchIdCgplbmRfY3Vyc29yGA'
    'ggASgMUgllbmRDdXJzb3ISFgoGb2Zmc2V0GAogASgFUgZvZmZzZXQSMQoFbGltaXQYDCABKAsy'
    'Gy5nb29nbGUucHJvdG9idWYuSW50MzJWYWx1ZVIFbGltaXQ=');

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
      '6': '.google.datastore.v1beta3.PropertyReference',
      '10': 'property'
    },
  ],
};

/// Descriptor for `Projection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List projectionDescriptor = $convert.base64Decode(
    'CgpQcm9qZWN0aW9uEkcKCHByb3BlcnR5GAEgASgLMisuZ29vZ2xlLmRhdGFzdG9yZS52MWJldG'
    'EzLlByb3BlcnR5UmVmZXJlbmNlUghwcm9wZXJ0eQ==');

@$core.Deprecated('Use propertyOrderDescriptor instead')
const PropertyOrder$json = {
  '1': 'PropertyOrder',
  '2': [
    {
      '1': 'property',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.PropertyReference',
      '10': 'property'
    },
    {
      '1': 'direction',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1beta3.PropertyOrder.Direction',
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
    'Cg1Qcm9wZXJ0eU9yZGVyEkcKCHByb3BlcnR5GAEgASgLMisuZ29vZ2xlLmRhdGFzdG9yZS52MW'
    'JldGEzLlByb3BlcnR5UmVmZXJlbmNlUghwcm9wZXJ0eRJPCglkaXJlY3Rpb24YAiABKA4yMS5n'
    'b29nbGUuZGF0YXN0b3JlLnYxYmV0YTMuUHJvcGVydHlPcmRlci5EaXJlY3Rpb25SCWRpcmVjdG'
    'lvbiJFCglEaXJlY3Rpb24SGQoVRElSRUNUSU9OX1VOU1BFQ0lGSUVEEAASDQoJQVNDRU5ESU5H'
    'EAESDgoKREVTQ0VORElORxAC');

@$core.Deprecated('Use filterDescriptor instead')
const Filter$json = {
  '1': 'Filter',
  '2': [
    {
      '1': 'composite_filter',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.CompositeFilter',
      '9': 0,
      '10': 'compositeFilter'
    },
    {
      '1': 'property_filter',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.PropertyFilter',
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
    'CgZGaWx0ZXISVgoQY29tcG9zaXRlX2ZpbHRlchgBIAEoCzIpLmdvb2dsZS5kYXRhc3RvcmUudj'
    'FiZXRhMy5Db21wb3NpdGVGaWx0ZXJIAFIPY29tcG9zaXRlRmlsdGVyElMKD3Byb3BlcnR5X2Zp'
    'bHRlchgCIAEoCzIoLmdvb2dsZS5kYXRhc3RvcmUudjFiZXRhMy5Qcm9wZXJ0eUZpbHRlckgAUg'
    '5wcm9wZXJ0eUZpbHRlckINCgtmaWx0ZXJfdHlwZQ==');

@$core.Deprecated('Use compositeFilterDescriptor instead')
const CompositeFilter$json = {
  '1': 'CompositeFilter',
  '2': [
    {
      '1': 'op',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1beta3.CompositeFilter.Operator',
      '10': 'op'
    },
    {
      '1': 'filters',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.Filter',
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
  ],
};

/// Descriptor for `CompositeFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List compositeFilterDescriptor = $convert.base64Decode(
    'Cg9Db21wb3NpdGVGaWx0ZXISQgoCb3AYASABKA4yMi5nb29nbGUuZGF0YXN0b3JlLnYxYmV0YT'
    'MuQ29tcG9zaXRlRmlsdGVyLk9wZXJhdG9yUgJvcBI6CgdmaWx0ZXJzGAIgAygLMiAuZ29vZ2xl'
    'LmRhdGFzdG9yZS52MWJldGEzLkZpbHRlclIHZmlsdGVycyItCghPcGVyYXRvchIYChRPUEVSQV'
    'RPUl9VTlNQRUNJRklFRBAAEgcKA0FORBAB');

@$core.Deprecated('Use propertyFilterDescriptor instead')
const PropertyFilter$json = {
  '1': 'PropertyFilter',
  '2': [
    {
      '1': 'property',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.PropertyReference',
      '10': 'property'
    },
    {
      '1': 'op',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1beta3.PropertyFilter.Operator',
      '10': 'op'
    },
    {
      '1': 'value',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.Value',
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
    {'1': 'HAS_ANCESTOR', '2': 11},
  ],
};

/// Descriptor for `PropertyFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List propertyFilterDescriptor = $convert.base64Decode(
    'Cg5Qcm9wZXJ0eUZpbHRlchJHCghwcm9wZXJ0eRgBIAEoCzIrLmdvb2dsZS5kYXRhc3RvcmUudj'
    'FiZXRhMy5Qcm9wZXJ0eVJlZmVyZW5jZVIIcHJvcGVydHkSQQoCb3AYAiABKA4yMS5nb29nbGUu'
    'ZGF0YXN0b3JlLnYxYmV0YTMuUHJvcGVydHlGaWx0ZXIuT3BlcmF0b3JSAm9wEjUKBXZhbHVlGA'
    'MgASgLMh8uZ29vZ2xlLmRhdGFzdG9yZS52MWJldGEzLlZhbHVlUgV2YWx1ZSKVAQoIT3BlcmF0'
    'b3ISGAoUT1BFUkFUT1JfVU5TUEVDSUZJRUQQABINCglMRVNTX1RIQU4QARIWChJMRVNTX1RIQU'
    '5fT1JfRVFVQUwQAhIQCgxHUkVBVEVSX1RIQU4QAxIZChVHUkVBVEVSX1RIQU5fT1JfRVFVQUwQ'
    'BBIJCgVFUVVBTBAFEhAKDEhBU19BTkNFU1RPUhAL');

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
      '6': '.google.datastore.v1beta3.GqlQuery.NamedBindingsEntry',
      '10': 'namedBindings'
    },
    {
      '1': 'positional_bindings',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.GqlQueryParameter',
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
      '6': '.google.datastore.v1beta3.GqlQueryParameter',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

/// Descriptor for `GqlQuery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gqlQueryDescriptor = $convert.base64Decode(
    'CghHcWxRdWVyeRIhCgxxdWVyeV9zdHJpbmcYASABKAlSC3F1ZXJ5U3RyaW5nEiUKDmFsbG93X2'
    'xpdGVyYWxzGAIgASgIUg1hbGxvd0xpdGVyYWxzElwKDm5hbWVkX2JpbmRpbmdzGAUgAygLMjUu'
    'Z29vZ2xlLmRhdGFzdG9yZS52MWJldGEzLkdxbFF1ZXJ5Lk5hbWVkQmluZGluZ3NFbnRyeVINbm'
    'FtZWRCaW5kaW5ncxJcChNwb3NpdGlvbmFsX2JpbmRpbmdzGAQgAygLMisuZ29vZ2xlLmRhdGFz'
    'dG9yZS52MWJldGEzLkdxbFF1ZXJ5UGFyYW1ldGVyUhJwb3NpdGlvbmFsQmluZGluZ3MabQoSTm'
    'FtZWRCaW5kaW5nc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EkEKBXZhbHVlGAIgASgLMisuZ29v'
    'Z2xlLmRhdGFzdG9yZS52MWJldGEzLkdxbFF1ZXJ5UGFyYW1ldGVyUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use gqlQueryParameterDescriptor instead')
const GqlQueryParameter$json = {
  '1': 'GqlQueryParameter',
  '2': [
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.Value',
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
    'ChFHcWxRdWVyeVBhcmFtZXRlchI3CgV2YWx1ZRgCIAEoCzIfLmdvb2dsZS5kYXRhc3RvcmUudj'
    'FiZXRhMy5WYWx1ZUgAUgV2YWx1ZRIYCgZjdXJzb3IYAyABKAxIAFIGY3Vyc29yQhAKDnBhcmFt'
    'ZXRlcl90eXBl');

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
      '6': '.google.datastore.v1beta3.EntityResult.ResultType',
      '10': 'entityResultType'
    },
    {
      '1': 'entity_results',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.EntityResult',
      '10': 'entityResults'
    },
    {'1': 'end_cursor', '3': 4, '4': 1, '5': 12, '10': 'endCursor'},
    {
      '1': 'more_results',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1beta3.QueryResultBatch.MoreResultsType',
      '10': 'moreResults'
    },
    {'1': 'snapshot_version', '3': 7, '4': 1, '5': 3, '10': 'snapshotVersion'},
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
    'VsdHMSJQoOc2tpcHBlZF9jdXJzb3IYAyABKAxSDXNraXBwZWRDdXJzb3ISXwoSZW50aXR5X3Jl'
    'c3VsdF90eXBlGAEgASgOMjEuZ29vZ2xlLmRhdGFzdG9yZS52MWJldGEzLkVudGl0eVJlc3VsdC'
    '5SZXN1bHRUeXBlUhBlbnRpdHlSZXN1bHRUeXBlEk0KDmVudGl0eV9yZXN1bHRzGAIgAygLMiYu'
    'Z29vZ2xlLmRhdGFzdG9yZS52MWJldGEzLkVudGl0eVJlc3VsdFINZW50aXR5UmVzdWx0cxIdCg'
    'plbmRfY3Vyc29yGAQgASgMUgllbmRDdXJzb3ISXQoMbW9yZV9yZXN1bHRzGAUgASgOMjouZ29v'
    'Z2xlLmRhdGFzdG9yZS52MWJldGEzLlF1ZXJ5UmVzdWx0QmF0Y2guTW9yZVJlc3VsdHNUeXBlUg'
    'ttb3JlUmVzdWx0cxIpChBzbmFwc2hvdF92ZXJzaW9uGAcgASgDUg9zbmFwc2hvdFZlcnNpb24i'
    'mAEKD01vcmVSZXN1bHRzVHlwZRIhCh1NT1JFX1JFU1VMVFNfVFlQRV9VTlNQRUNJRklFRBAAEh'
    'AKDE5PVF9GSU5JU0hFRBABEhwKGE1PUkVfUkVTVUxUU19BRlRFUl9MSU1JVBACEh0KGU1PUkVf'
    'UkVTVUxUU19BRlRFUl9DVVJTT1IQBBITCg9OT19NT1JFX1JFU1VMVFMQAw==');
