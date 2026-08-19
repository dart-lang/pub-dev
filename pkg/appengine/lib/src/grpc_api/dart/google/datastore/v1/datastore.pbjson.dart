//
//  Generated code. Do not modify.
//  source: google/datastore/v1/datastore.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use lookupRequestDescriptor instead')
const LookupRequest$json = {
  '1': 'LookupRequest',
  '2': [
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '8': {}, '10': 'projectId'},
    {'1': 'database_id', '3': 9, '4': 1, '5': 9, '10': 'databaseId'},
    {
      '1': 'read_options',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.ReadOptions',
      '10': 'readOptions'
    },
    {
      '1': 'keys',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.Key',
      '8': {},
      '10': 'keys'
    },
    {
      '1': 'property_mask',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PropertyMask',
      '10': 'propertyMask'
    },
  ],
};

/// Descriptor for `LookupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupRequestDescriptor = $convert.base64Decode(
    'Cg1Mb29rdXBSZXF1ZXN0EiIKCnByb2plY3RfaWQYCCABKAlCA+BBAlIJcHJvamVjdElkEh8KC2'
    'RhdGFiYXNlX2lkGAkgASgJUgpkYXRhYmFzZUlkEkMKDHJlYWRfb3B0aW9ucxgBIAEoCzIgLmdv'
    'b2dsZS5kYXRhc3RvcmUudjEuUmVhZE9wdGlvbnNSC3JlYWRPcHRpb25zEjEKBGtleXMYAyADKA'
    'syGC5nb29nbGUuZGF0YXN0b3JlLnYxLktleUID4EECUgRrZXlzEkYKDXByb3BlcnR5X21hc2sY'
    'BSABKAsyIS5nb29nbGUuZGF0YXN0b3JlLnYxLlByb3BlcnR5TWFza1IMcHJvcGVydHlNYXNr');

@$core.Deprecated('Use lookupResponseDescriptor instead')
const LookupResponse$json = {
  '1': 'LookupResponse',
  '2': [
    {
      '1': 'found',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.EntityResult',
      '10': 'found'
    },
    {
      '1': 'missing',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.EntityResult',
      '10': 'missing'
    },
    {
      '1': 'deferred',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.Key',
      '10': 'deferred'
    },
    {'1': 'transaction', '3': 5, '4': 1, '5': 12, '10': 'transaction'},
    {
      '1': 'read_time',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'readTime'
    },
  ],
};

/// Descriptor for `LookupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupResponseDescriptor = $convert.base64Decode(
    'Cg5Mb29rdXBSZXNwb25zZRI3CgVmb3VuZBgBIAMoCzIhLmdvb2dsZS5kYXRhc3RvcmUudjEuRW'
    '50aXR5UmVzdWx0UgVmb3VuZBI7CgdtaXNzaW5nGAIgAygLMiEuZ29vZ2xlLmRhdGFzdG9yZS52'
    'MS5FbnRpdHlSZXN1bHRSB21pc3NpbmcSNAoIZGVmZXJyZWQYAyADKAsyGC5nb29nbGUuZGF0YX'
    'N0b3JlLnYxLktleVIIZGVmZXJyZWQSIAoLdHJhbnNhY3Rpb24YBSABKAxSC3RyYW5zYWN0aW9u'
    'EjcKCXJlYWRfdGltZRgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCHJlYWRUaW'
    '1l');

@$core.Deprecated('Use runQueryRequestDescriptor instead')
const RunQueryRequest$json = {
  '1': 'RunQueryRequest',
  '2': [
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '8': {}, '10': 'projectId'},
    {'1': 'database_id', '3': 9, '4': 1, '5': 9, '10': 'databaseId'},
    {
      '1': 'partition_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PartitionId',
      '10': 'partitionId'
    },
    {
      '1': 'read_options',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.ReadOptions',
      '10': 'readOptions'
    },
    {
      '1': 'query',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Query',
      '9': 0,
      '10': 'query'
    },
    {
      '1': 'gql_query',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.GqlQuery',
      '9': 0,
      '10': 'gqlQuery'
    },
    {
      '1': 'property_mask',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PropertyMask',
      '10': 'propertyMask'
    },
    {
      '1': 'explain_options',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.ExplainOptions',
      '8': {},
      '10': 'explainOptions'
    },
  ],
  '8': [
    {'1': 'query_type'},
  ],
};

/// Descriptor for `RunQueryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runQueryRequestDescriptor = $convert.base64Decode(
    'Cg9SdW5RdWVyeVJlcXVlc3QSIgoKcHJvamVjdF9pZBgIIAEoCUID4EECUglwcm9qZWN0SWQSHw'
    'oLZGF0YWJhc2VfaWQYCSABKAlSCmRhdGFiYXNlSWQSQwoMcGFydGl0aW9uX2lkGAIgASgLMiAu'
    'Z29vZ2xlLmRhdGFzdG9yZS52MS5QYXJ0aXRpb25JZFILcGFydGl0aW9uSWQSQwoMcmVhZF9vcH'
    'Rpb25zGAEgASgLMiAuZ29vZ2xlLmRhdGFzdG9yZS52MS5SZWFkT3B0aW9uc1ILcmVhZE9wdGlv'
    'bnMSMgoFcXVlcnkYAyABKAsyGi5nb29nbGUuZGF0YXN0b3JlLnYxLlF1ZXJ5SABSBXF1ZXJ5Ej'
    'wKCWdxbF9xdWVyeRgHIAEoCzIdLmdvb2dsZS5kYXRhc3RvcmUudjEuR3FsUXVlcnlIAFIIZ3Fs'
    'UXVlcnkSRgoNcHJvcGVydHlfbWFzaxgKIAEoCzIhLmdvb2dsZS5kYXRhc3RvcmUudjEuUHJvcG'
    'VydHlNYXNrUgxwcm9wZXJ0eU1hc2sSUQoPZXhwbGFpbl9vcHRpb25zGAwgASgLMiMuZ29vZ2xl'
    'LmRhdGFzdG9yZS52MS5FeHBsYWluT3B0aW9uc0ID4EEBUg5leHBsYWluT3B0aW9uc0IMCgpxdW'
    'VyeV90eXBl');

@$core.Deprecated('Use runQueryResponseDescriptor instead')
const RunQueryResponse$json = {
  '1': 'RunQueryResponse',
  '2': [
    {
      '1': 'batch',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.QueryResultBatch',
      '10': 'batch'
    },
    {
      '1': 'query',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Query',
      '10': 'query'
    },
    {'1': 'transaction', '3': 5, '4': 1, '5': 12, '10': 'transaction'},
    {
      '1': 'explain_metrics',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.ExplainMetrics',
      '10': 'explainMetrics'
    },
  ],
};

/// Descriptor for `RunQueryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runQueryResponseDescriptor = $convert.base64Decode(
    'ChBSdW5RdWVyeVJlc3BvbnNlEjsKBWJhdGNoGAEgASgLMiUuZ29vZ2xlLmRhdGFzdG9yZS52MS'
    '5RdWVyeVJlc3VsdEJhdGNoUgViYXRjaBIwCgVxdWVyeRgCIAEoCzIaLmdvb2dsZS5kYXRhc3Rv'
    'cmUudjEuUXVlcnlSBXF1ZXJ5EiAKC3RyYW5zYWN0aW9uGAUgASgMUgt0cmFuc2FjdGlvbhJMCg'
    '9leHBsYWluX21ldHJpY3MYCSABKAsyIy5nb29nbGUuZGF0YXN0b3JlLnYxLkV4cGxhaW5NZXRy'
    'aWNzUg5leHBsYWluTWV0cmljcw==');

@$core.Deprecated('Use runAggregationQueryRequestDescriptor instead')
const RunAggregationQueryRequest$json = {
  '1': 'RunAggregationQueryRequest',
  '2': [
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '8': {}, '10': 'projectId'},
    {'1': 'database_id', '3': 9, '4': 1, '5': 9, '10': 'databaseId'},
    {
      '1': 'partition_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PartitionId',
      '10': 'partitionId'
    },
    {
      '1': 'read_options',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.ReadOptions',
      '10': 'readOptions'
    },
    {
      '1': 'aggregation_query',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.AggregationQuery',
      '9': 0,
      '10': 'aggregationQuery'
    },
    {
      '1': 'gql_query',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.GqlQuery',
      '9': 0,
      '10': 'gqlQuery'
    },
    {
      '1': 'explain_options',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.ExplainOptions',
      '8': {},
      '10': 'explainOptions'
    },
  ],
  '8': [
    {'1': 'query_type'},
  ],
};

/// Descriptor for `RunAggregationQueryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runAggregationQueryRequestDescriptor = $convert.base64Decode(
    'ChpSdW5BZ2dyZWdhdGlvblF1ZXJ5UmVxdWVzdBIiCgpwcm9qZWN0X2lkGAggASgJQgPgQQJSCX'
    'Byb2plY3RJZBIfCgtkYXRhYmFzZV9pZBgJIAEoCVIKZGF0YWJhc2VJZBJDCgxwYXJ0aXRpb25f'
    'aWQYAiABKAsyIC5nb29nbGUuZGF0YXN0b3JlLnYxLlBhcnRpdGlvbklkUgtwYXJ0aXRpb25JZB'
    'JDCgxyZWFkX29wdGlvbnMYASABKAsyIC5nb29nbGUuZGF0YXN0b3JlLnYxLlJlYWRPcHRpb25z'
    'UgtyZWFkT3B0aW9ucxJUChFhZ2dyZWdhdGlvbl9xdWVyeRgDIAEoCzIlLmdvb2dsZS5kYXRhc3'
    'RvcmUudjEuQWdncmVnYXRpb25RdWVyeUgAUhBhZ2dyZWdhdGlvblF1ZXJ5EjwKCWdxbF9xdWVy'
    'eRgHIAEoCzIdLmdvb2dsZS5kYXRhc3RvcmUudjEuR3FsUXVlcnlIAFIIZ3FsUXVlcnkSUQoPZX'
    'hwbGFpbl9vcHRpb25zGAsgASgLMiMuZ29vZ2xlLmRhdGFzdG9yZS52MS5FeHBsYWluT3B0aW9u'
    'c0ID4EEBUg5leHBsYWluT3B0aW9uc0IMCgpxdWVyeV90eXBl');

@$core.Deprecated('Use runAggregationQueryResponseDescriptor instead')
const RunAggregationQueryResponse$json = {
  '1': 'RunAggregationQueryResponse',
  '2': [
    {
      '1': 'batch',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.AggregationResultBatch',
      '10': 'batch'
    },
    {
      '1': 'query',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.AggregationQuery',
      '10': 'query'
    },
    {'1': 'transaction', '3': 5, '4': 1, '5': 12, '10': 'transaction'},
    {
      '1': 'explain_metrics',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.ExplainMetrics',
      '10': 'explainMetrics'
    },
  ],
};

/// Descriptor for `RunAggregationQueryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runAggregationQueryResponseDescriptor = $convert.base64Decode(
    'ChtSdW5BZ2dyZWdhdGlvblF1ZXJ5UmVzcG9uc2USQQoFYmF0Y2gYASABKAsyKy5nb29nbGUuZG'
    'F0YXN0b3JlLnYxLkFnZ3JlZ2F0aW9uUmVzdWx0QmF0Y2hSBWJhdGNoEjsKBXF1ZXJ5GAIgASgL'
    'MiUuZ29vZ2xlLmRhdGFzdG9yZS52MS5BZ2dyZWdhdGlvblF1ZXJ5UgVxdWVyeRIgCgt0cmFuc2'
    'FjdGlvbhgFIAEoDFILdHJhbnNhY3Rpb24STAoPZXhwbGFpbl9tZXRyaWNzGAkgASgLMiMuZ29v'
    'Z2xlLmRhdGFzdG9yZS52MS5FeHBsYWluTWV0cmljc1IOZXhwbGFpbk1ldHJpY3M=');

@$core.Deprecated('Use beginTransactionRequestDescriptor instead')
const BeginTransactionRequest$json = {
  '1': 'BeginTransactionRequest',
  '2': [
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '8': {}, '10': 'projectId'},
    {'1': 'database_id', '3': 9, '4': 1, '5': 9, '10': 'databaseId'},
    {
      '1': 'transaction_options',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.TransactionOptions',
      '10': 'transactionOptions'
    },
  ],
};

/// Descriptor for `BeginTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List beginTransactionRequestDescriptor = $convert.base64Decode(
    'ChdCZWdpblRyYW5zYWN0aW9uUmVxdWVzdBIiCgpwcm9qZWN0X2lkGAggASgJQgPgQQJSCXByb2'
    'plY3RJZBIfCgtkYXRhYmFzZV9pZBgJIAEoCVIKZGF0YWJhc2VJZBJYChN0cmFuc2FjdGlvbl9v'
    'cHRpb25zGAogASgLMicuZ29vZ2xlLmRhdGFzdG9yZS52MS5UcmFuc2FjdGlvbk9wdGlvbnNSEn'
    'RyYW5zYWN0aW9uT3B0aW9ucw==');

@$core.Deprecated('Use beginTransactionResponseDescriptor instead')
const BeginTransactionResponse$json = {
  '1': 'BeginTransactionResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 12, '10': 'transaction'},
  ],
};

/// Descriptor for `BeginTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List beginTransactionResponseDescriptor =
    $convert.base64Decode(
        'ChhCZWdpblRyYW5zYWN0aW9uUmVzcG9uc2USIAoLdHJhbnNhY3Rpb24YASABKAxSC3RyYW5zYW'
        'N0aW9u');

@$core.Deprecated('Use rollbackRequestDescriptor instead')
const RollbackRequest$json = {
  '1': 'RollbackRequest',
  '2': [
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '8': {}, '10': 'projectId'},
    {'1': 'database_id', '3': 9, '4': 1, '5': 9, '10': 'databaseId'},
    {'1': 'transaction', '3': 1, '4': 1, '5': 12, '8': {}, '10': 'transaction'},
  ],
};

/// Descriptor for `RollbackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rollbackRequestDescriptor = $convert.base64Decode(
    'Cg9Sb2xsYmFja1JlcXVlc3QSIgoKcHJvamVjdF9pZBgIIAEoCUID4EECUglwcm9qZWN0SWQSHw'
    'oLZGF0YWJhc2VfaWQYCSABKAlSCmRhdGFiYXNlSWQSJQoLdHJhbnNhY3Rpb24YASABKAxCA+BB'
    'AlILdHJhbnNhY3Rpb24=');

@$core.Deprecated('Use rollbackResponseDescriptor instead')
const RollbackResponse$json = {
  '1': 'RollbackResponse',
};

/// Descriptor for `RollbackResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rollbackResponseDescriptor =
    $convert.base64Decode('ChBSb2xsYmFja1Jlc3BvbnNl');

@$core.Deprecated('Use commitRequestDescriptor instead')
const CommitRequest$json = {
  '1': 'CommitRequest',
  '2': [
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '8': {}, '10': 'projectId'},
    {'1': 'database_id', '3': 9, '4': 1, '5': 9, '10': 'databaseId'},
    {
      '1': 'mode',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1.CommitRequest.Mode',
      '10': 'mode'
    },
    {'1': 'transaction', '3': 1, '4': 1, '5': 12, '9': 0, '10': 'transaction'},
    {
      '1': 'single_use_transaction',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.TransactionOptions',
      '9': 0,
      '10': 'singleUseTransaction'
    },
    {
      '1': 'mutations',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.Mutation',
      '10': 'mutations'
    },
  ],
  '4': [CommitRequest_Mode$json],
  '8': [
    {'1': 'transaction_selector'},
  ],
};

@$core.Deprecated('Use commitRequestDescriptor instead')
const CommitRequest_Mode$json = {
  '1': 'Mode',
  '2': [
    {'1': 'MODE_UNSPECIFIED', '2': 0},
    {'1': 'TRANSACTIONAL', '2': 1},
    {'1': 'NON_TRANSACTIONAL', '2': 2},
  ],
};

/// Descriptor for `CommitRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commitRequestDescriptor = $convert.base64Decode(
    'Cg1Db21taXRSZXF1ZXN0EiIKCnByb2plY3RfaWQYCCABKAlCA+BBAlIJcHJvamVjdElkEh8KC2'
    'RhdGFiYXNlX2lkGAkgASgJUgpkYXRhYmFzZUlkEjsKBG1vZGUYBSABKA4yJy5nb29nbGUuZGF0'
    'YXN0b3JlLnYxLkNvbW1pdFJlcXVlc3QuTW9kZVIEbW9kZRIiCgt0cmFuc2FjdGlvbhgBIAEoDE'
    'gAUgt0cmFuc2FjdGlvbhJfChZzaW5nbGVfdXNlX3RyYW5zYWN0aW9uGAogASgLMicuZ29vZ2xl'
    'LmRhdGFzdG9yZS52MS5UcmFuc2FjdGlvbk9wdGlvbnNIAFIUc2luZ2xlVXNlVHJhbnNhY3Rpb2'
    '4SOwoJbXV0YXRpb25zGAYgAygLMh0uZ29vZ2xlLmRhdGFzdG9yZS52MS5NdXRhdGlvblIJbXV0'
    'YXRpb25zIkYKBE1vZGUSFAoQTU9ERV9VTlNQRUNJRklFRBAAEhEKDVRSQU5TQUNUSU9OQUwQAR'
    'IVChFOT05fVFJBTlNBQ1RJT05BTBACQhYKFHRyYW5zYWN0aW9uX3NlbGVjdG9y');

@$core.Deprecated('Use commitResponseDescriptor instead')
const CommitResponse$json = {
  '1': 'CommitResponse',
  '2': [
    {
      '1': 'mutation_results',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.MutationResult',
      '10': 'mutationResults'
    },
    {'1': 'index_updates', '3': 4, '4': 1, '5': 5, '10': 'indexUpdates'},
    {
      '1': 'commit_time',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'commitTime'
    },
  ],
};

/// Descriptor for `CommitResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commitResponseDescriptor = $convert.base64Decode(
    'Cg5Db21taXRSZXNwb25zZRJOChBtdXRhdGlvbl9yZXN1bHRzGAMgAygLMiMuZ29vZ2xlLmRhdG'
    'FzdG9yZS52MS5NdXRhdGlvblJlc3VsdFIPbXV0YXRpb25SZXN1bHRzEiMKDWluZGV4X3VwZGF0'
    'ZXMYBCABKAVSDGluZGV4VXBkYXRlcxI7Cgtjb21taXRfdGltZRgIIAEoCzIaLmdvb2dsZS5wcm'
    '90b2J1Zi5UaW1lc3RhbXBSCmNvbW1pdFRpbWU=');

@$core.Deprecated('Use allocateIdsRequestDescriptor instead')
const AllocateIdsRequest$json = {
  '1': 'AllocateIdsRequest',
  '2': [
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '8': {}, '10': 'projectId'},
    {'1': 'database_id', '3': 9, '4': 1, '5': 9, '10': 'databaseId'},
    {
      '1': 'keys',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.Key',
      '8': {},
      '10': 'keys'
    },
  ],
};

/// Descriptor for `AllocateIdsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allocateIdsRequestDescriptor = $convert.base64Decode(
    'ChJBbGxvY2F0ZUlkc1JlcXVlc3QSIgoKcHJvamVjdF9pZBgIIAEoCUID4EECUglwcm9qZWN0SW'
    'QSHwoLZGF0YWJhc2VfaWQYCSABKAlSCmRhdGFiYXNlSWQSMQoEa2V5cxgBIAMoCzIYLmdvb2ds'
    'ZS5kYXRhc3RvcmUudjEuS2V5QgPgQQJSBGtleXM=');

@$core.Deprecated('Use allocateIdsResponseDescriptor instead')
const AllocateIdsResponse$json = {
  '1': 'AllocateIdsResponse',
  '2': [
    {
      '1': 'keys',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.Key',
      '10': 'keys'
    },
  ],
};

/// Descriptor for `AllocateIdsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allocateIdsResponseDescriptor = $convert.base64Decode(
    'ChNBbGxvY2F0ZUlkc1Jlc3BvbnNlEiwKBGtleXMYASADKAsyGC5nb29nbGUuZGF0YXN0b3JlLn'
    'YxLktleVIEa2V5cw==');

@$core.Deprecated('Use reserveIdsRequestDescriptor instead')
const ReserveIdsRequest$json = {
  '1': 'ReserveIdsRequest',
  '2': [
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '8': {}, '10': 'projectId'},
    {'1': 'database_id', '3': 9, '4': 1, '5': 9, '10': 'databaseId'},
    {
      '1': 'keys',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1.Key',
      '8': {},
      '10': 'keys'
    },
  ],
};

/// Descriptor for `ReserveIdsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reserveIdsRequestDescriptor = $convert.base64Decode(
    'ChFSZXNlcnZlSWRzUmVxdWVzdBIiCgpwcm9qZWN0X2lkGAggASgJQgPgQQJSCXByb2plY3RJZB'
    'IfCgtkYXRhYmFzZV9pZBgJIAEoCVIKZGF0YWJhc2VJZBIxCgRrZXlzGAEgAygLMhguZ29vZ2xl'
    'LmRhdGFzdG9yZS52MS5LZXlCA+BBAlIEa2V5cw==');

@$core.Deprecated('Use reserveIdsResponseDescriptor instead')
const ReserveIdsResponse$json = {
  '1': 'ReserveIdsResponse',
};

/// Descriptor for `ReserveIdsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reserveIdsResponseDescriptor =
    $convert.base64Decode('ChJSZXNlcnZlSWRzUmVzcG9uc2U=');

@$core.Deprecated('Use mutationDescriptor instead')
const Mutation$json = {
  '1': 'Mutation',
  '2': [
    {
      '1': 'insert',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Entity',
      '9': 0,
      '10': 'insert'
    },
    {
      '1': 'update',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Entity',
      '9': 0,
      '10': 'update'
    },
    {
      '1': 'upsert',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Entity',
      '9': 0,
      '10': 'upsert'
    },
    {
      '1': 'delete',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Key',
      '9': 0,
      '10': 'delete'
    },
    {'1': 'base_version', '3': 8, '4': 1, '5': 3, '9': 1, '10': 'baseVersion'},
    {
      '1': 'update_time',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 1,
      '10': 'updateTime'
    },
    {
      '1': 'property_mask',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.PropertyMask',
      '10': 'propertyMask'
    },
  ],
  '8': [
    {'1': 'operation'},
    {'1': 'conflict_detection_strategy'},
  ],
};

/// Descriptor for `Mutation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mutationDescriptor = $convert.base64Decode(
    'CghNdXRhdGlvbhI1CgZpbnNlcnQYBCABKAsyGy5nb29nbGUuZGF0YXN0b3JlLnYxLkVudGl0eU'
    'gAUgZpbnNlcnQSNQoGdXBkYXRlGAUgASgLMhsuZ29vZ2xlLmRhdGFzdG9yZS52MS5FbnRpdHlI'
    'AFIGdXBkYXRlEjUKBnVwc2VydBgGIAEoCzIbLmdvb2dsZS5kYXRhc3RvcmUudjEuRW50aXR5SA'
    'BSBnVwc2VydBIyCgZkZWxldGUYByABKAsyGC5nb29nbGUuZGF0YXN0b3JlLnYxLktleUgAUgZk'
    'ZWxldGUSIwoMYmFzZV92ZXJzaW9uGAggASgDSAFSC2Jhc2VWZXJzaW9uEj0KC3VwZGF0ZV90aW'
    '1lGAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcEgBUgp1cGRhdGVUaW1lEkYKDXBy'
    'b3BlcnR5X21hc2sYCSABKAsyIS5nb29nbGUuZGF0YXN0b3JlLnYxLlByb3BlcnR5TWFza1IMcH'
    'JvcGVydHlNYXNrQgsKCW9wZXJhdGlvbkIdChtjb25mbGljdF9kZXRlY3Rpb25fc3RyYXRlZ3k=');

@$core.Deprecated('Use mutationResultDescriptor instead')
const MutationResult$json = {
  '1': 'MutationResult',
  '2': [
    {
      '1': 'key',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.Key',
      '10': 'key'
    },
    {'1': 'version', '3': 4, '4': 1, '5': 3, '10': 'version'},
    {
      '1': 'create_time',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createTime'
    },
    {
      '1': 'update_time',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updateTime'
    },
    {
      '1': 'conflict_detected',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'conflictDetected'
    },
  ],
};

/// Descriptor for `MutationResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mutationResultDescriptor = $convert.base64Decode(
    'Cg5NdXRhdGlvblJlc3VsdBIqCgNrZXkYAyABKAsyGC5nb29nbGUuZGF0YXN0b3JlLnYxLktleV'
    'IDa2V5EhgKB3ZlcnNpb24YBCABKANSB3ZlcnNpb24SOwoLY3JlYXRlX3RpbWUYByABKAsyGi5n'
    'b29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpjcmVhdGVUaW1lEjsKC3VwZGF0ZV90aW1lGAYgAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKdXBkYXRlVGltZRIrChFjb25mbGljdF9k'
    'ZXRlY3RlZBgFIAEoCFIQY29uZmxpY3REZXRlY3RlZA==');

@$core.Deprecated('Use propertyMaskDescriptor instead')
const PropertyMask$json = {
  '1': 'PropertyMask',
  '2': [
    {'1': 'paths', '3': 1, '4': 3, '5': 9, '10': 'paths'},
  ],
};

/// Descriptor for `PropertyMask`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List propertyMaskDescriptor =
    $convert.base64Decode('CgxQcm9wZXJ0eU1hc2sSFAoFcGF0aHMYASADKAlSBXBhdGhz');

@$core.Deprecated('Use readOptionsDescriptor instead')
const ReadOptions$json = {
  '1': 'ReadOptions',
  '2': [
    {
      '1': 'read_consistency',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1.ReadOptions.ReadConsistency',
      '9': 0,
      '10': 'readConsistency'
    },
    {'1': 'transaction', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'transaction'},
    {
      '1': 'new_transaction',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.TransactionOptions',
      '9': 0,
      '10': 'newTransaction'
    },
    {
      '1': 'read_time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 0,
      '10': 'readTime'
    },
  ],
  '4': [ReadOptions_ReadConsistency$json],
  '8': [
    {'1': 'consistency_type'},
  ],
};

@$core.Deprecated('Use readOptionsDescriptor instead')
const ReadOptions_ReadConsistency$json = {
  '1': 'ReadConsistency',
  '2': [
    {'1': 'READ_CONSISTENCY_UNSPECIFIED', '2': 0},
    {'1': 'STRONG', '2': 1},
    {'1': 'EVENTUAL', '2': 2},
  ],
};

/// Descriptor for `ReadOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readOptionsDescriptor = $convert.base64Decode(
    'CgtSZWFkT3B0aW9ucxJdChByZWFkX2NvbnNpc3RlbmN5GAEgASgOMjAuZ29vZ2xlLmRhdGFzdG'
    '9yZS52MS5SZWFkT3B0aW9ucy5SZWFkQ29uc2lzdGVuY3lIAFIPcmVhZENvbnNpc3RlbmN5EiIK'
    'C3RyYW5zYWN0aW9uGAIgASgMSABSC3RyYW5zYWN0aW9uElIKD25ld190cmFuc2FjdGlvbhgDIA'
    'EoCzInLmdvb2dsZS5kYXRhc3RvcmUudjEuVHJhbnNhY3Rpb25PcHRpb25zSABSDm5ld1RyYW5z'
    'YWN0aW9uEjkKCXJlYWRfdGltZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBIAF'
    'IIcmVhZFRpbWUiTQoPUmVhZENvbnNpc3RlbmN5EiAKHFJFQURfQ09OU0lTVEVOQ1lfVU5TUEVD'
    'SUZJRUQQABIKCgZTVFJPTkcQARIMCghFVkVOVFVBTBACQhIKEGNvbnNpc3RlbmN5X3R5cGU=');

@$core.Deprecated('Use transactionOptionsDescriptor instead')
const TransactionOptions$json = {
  '1': 'TransactionOptions',
  '2': [
    {
      '1': 'read_write',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.TransactionOptions.ReadWrite',
      '9': 0,
      '10': 'readWrite'
    },
    {
      '1': 'read_only',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1.TransactionOptions.ReadOnly',
      '9': 0,
      '10': 'readOnly'
    },
  ],
  '3': [TransactionOptions_ReadWrite$json, TransactionOptions_ReadOnly$json],
  '8': [
    {'1': 'mode'},
  ],
};

@$core.Deprecated('Use transactionOptionsDescriptor instead')
const TransactionOptions_ReadWrite$json = {
  '1': 'ReadWrite',
  '2': [
    {
      '1': 'previous_transaction',
      '3': 1,
      '4': 1,
      '5': 12,
      '10': 'previousTransaction'
    },
  ],
};

@$core.Deprecated('Use transactionOptionsDescriptor instead')
const TransactionOptions_ReadOnly$json = {
  '1': 'ReadOnly',
  '2': [
    {
      '1': 'read_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'readTime'
    },
  ],
};

/// Descriptor for `TransactionOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionOptionsDescriptor = $convert.base64Decode(
    'ChJUcmFuc2FjdGlvbk9wdGlvbnMSUgoKcmVhZF93cml0ZRgBIAEoCzIxLmdvb2dsZS5kYXRhc3'
    'RvcmUudjEuVHJhbnNhY3Rpb25PcHRpb25zLlJlYWRXcml0ZUgAUglyZWFkV3JpdGUSTwoJcmVh'
    'ZF9vbmx5GAIgASgLMjAuZ29vZ2xlLmRhdGFzdG9yZS52MS5UcmFuc2FjdGlvbk9wdGlvbnMuUm'
    'VhZE9ubHlIAFIIcmVhZE9ubHkaPgoJUmVhZFdyaXRlEjEKFHByZXZpb3VzX3RyYW5zYWN0aW9u'
    'GAEgASgMUhNwcmV2aW91c1RyYW5zYWN0aW9uGkMKCFJlYWRPbmx5EjcKCXJlYWRfdGltZRgBIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCHJlYWRUaW1lQgYKBG1vZGU=');
