//
//  Generated code. Do not modify.
//  source: google/datastore/v1beta3/datastore.proto
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
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '10': 'projectId'},
    {
      '1': 'read_options',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.ReadOptions',
      '10': 'readOptions'
    },
    {
      '1': 'keys',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.Key',
      '10': 'keys'
    },
  ],
};

/// Descriptor for `LookupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupRequestDescriptor = $convert.base64Decode(
    'Cg1Mb29rdXBSZXF1ZXN0Eh0KCnByb2plY3RfaWQYCCABKAlSCXByb2plY3RJZBJICgxyZWFkX2'
    '9wdGlvbnMYASABKAsyJS5nb29nbGUuZGF0YXN0b3JlLnYxYmV0YTMuUmVhZE9wdGlvbnNSC3Jl'
    'YWRPcHRpb25zEjEKBGtleXMYAyADKAsyHS5nb29nbGUuZGF0YXN0b3JlLnYxYmV0YTMuS2V5Ug'
    'RrZXlz');

@$core.Deprecated('Use lookupResponseDescriptor instead')
const LookupResponse$json = {
  '1': 'LookupResponse',
  '2': [
    {
      '1': 'found',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.EntityResult',
      '10': 'found'
    },
    {
      '1': 'missing',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.EntityResult',
      '10': 'missing'
    },
    {
      '1': 'deferred',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.Key',
      '10': 'deferred'
    },
  ],
};

/// Descriptor for `LookupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupResponseDescriptor = $convert.base64Decode(
    'Cg5Mb29rdXBSZXNwb25zZRI8CgVmb3VuZBgBIAMoCzImLmdvb2dsZS5kYXRhc3RvcmUudjFiZX'
    'RhMy5FbnRpdHlSZXN1bHRSBWZvdW5kEkAKB21pc3NpbmcYAiADKAsyJi5nb29nbGUuZGF0YXN0'
    'b3JlLnYxYmV0YTMuRW50aXR5UmVzdWx0UgdtaXNzaW5nEjkKCGRlZmVycmVkGAMgAygLMh0uZ2'
    '9vZ2xlLmRhdGFzdG9yZS52MWJldGEzLktleVIIZGVmZXJyZWQ=');

@$core.Deprecated('Use runQueryRequestDescriptor instead')
const RunQueryRequest$json = {
  '1': 'RunQueryRequest',
  '2': [
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '10': 'projectId'},
    {
      '1': 'partition_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.PartitionId',
      '10': 'partitionId'
    },
    {
      '1': 'read_options',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.ReadOptions',
      '10': 'readOptions'
    },
    {
      '1': 'query',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.Query',
      '9': 0,
      '10': 'query'
    },
    {
      '1': 'gql_query',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.GqlQuery',
      '9': 0,
      '10': 'gqlQuery'
    },
  ],
  '8': [
    {'1': 'query_type'},
  ],
};

/// Descriptor for `RunQueryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runQueryRequestDescriptor = $convert.base64Decode(
    'Cg9SdW5RdWVyeVJlcXVlc3QSHQoKcHJvamVjdF9pZBgIIAEoCVIJcHJvamVjdElkEkgKDHBhcn'
    'RpdGlvbl9pZBgCIAEoCzIlLmdvb2dsZS5kYXRhc3RvcmUudjFiZXRhMy5QYXJ0aXRpb25JZFIL'
    'cGFydGl0aW9uSWQSSAoMcmVhZF9vcHRpb25zGAEgASgLMiUuZ29vZ2xlLmRhdGFzdG9yZS52MW'
    'JldGEzLlJlYWRPcHRpb25zUgtyZWFkT3B0aW9ucxI3CgVxdWVyeRgDIAEoCzIfLmdvb2dsZS5k'
    'YXRhc3RvcmUudjFiZXRhMy5RdWVyeUgAUgVxdWVyeRJBCglncWxfcXVlcnkYByABKAsyIi5nb2'
    '9nbGUuZGF0YXN0b3JlLnYxYmV0YTMuR3FsUXVlcnlIAFIIZ3FsUXVlcnlCDAoKcXVlcnlfdHlw'
    'ZQ==');

@$core.Deprecated('Use runQueryResponseDescriptor instead')
const RunQueryResponse$json = {
  '1': 'RunQueryResponse',
  '2': [
    {
      '1': 'batch',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.QueryResultBatch',
      '10': 'batch'
    },
    {
      '1': 'query',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.Query',
      '10': 'query'
    },
  ],
};

/// Descriptor for `RunQueryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runQueryResponseDescriptor = $convert.base64Decode(
    'ChBSdW5RdWVyeVJlc3BvbnNlEkAKBWJhdGNoGAEgASgLMiouZ29vZ2xlLmRhdGFzdG9yZS52MW'
    'JldGEzLlF1ZXJ5UmVzdWx0QmF0Y2hSBWJhdGNoEjUKBXF1ZXJ5GAIgASgLMh8uZ29vZ2xlLmRh'
    'dGFzdG9yZS52MWJldGEzLlF1ZXJ5UgVxdWVyeQ==');

@$core.Deprecated('Use beginTransactionRequestDescriptor instead')
const BeginTransactionRequest$json = {
  '1': 'BeginTransactionRequest',
  '2': [
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '10': 'projectId'},
    {
      '1': 'transaction_options',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.TransactionOptions',
      '10': 'transactionOptions'
    },
  ],
};

/// Descriptor for `BeginTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List beginTransactionRequestDescriptor = $convert.base64Decode(
    'ChdCZWdpblRyYW5zYWN0aW9uUmVxdWVzdBIdCgpwcm9qZWN0X2lkGAggASgJUglwcm9qZWN0SW'
    'QSXQoTdHJhbnNhY3Rpb25fb3B0aW9ucxgKIAEoCzIsLmdvb2dsZS5kYXRhc3RvcmUudjFiZXRh'
    'My5UcmFuc2FjdGlvbk9wdGlvbnNSEnRyYW5zYWN0aW9uT3B0aW9ucw==');

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
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '10': 'projectId'},
    {'1': 'transaction', '3': 1, '4': 1, '5': 12, '10': 'transaction'},
  ],
};

/// Descriptor for `RollbackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rollbackRequestDescriptor = $convert.base64Decode(
    'Cg9Sb2xsYmFja1JlcXVlc3QSHQoKcHJvamVjdF9pZBgIIAEoCVIJcHJvamVjdElkEiAKC3RyYW'
    '5zYWN0aW9uGAEgASgMUgt0cmFuc2FjdGlvbg==');

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
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '10': 'projectId'},
    {
      '1': 'mode',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1beta3.CommitRequest.Mode',
      '10': 'mode'
    },
    {'1': 'transaction', '3': 1, '4': 1, '5': 12, '9': 0, '10': 'transaction'},
    {
      '1': 'mutations',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.Mutation',
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
    'Cg1Db21taXRSZXF1ZXN0Eh0KCnByb2plY3RfaWQYCCABKAlSCXByb2plY3RJZBJACgRtb2RlGA'
    'UgASgOMiwuZ29vZ2xlLmRhdGFzdG9yZS52MWJldGEzLkNvbW1pdFJlcXVlc3QuTW9kZVIEbW9k'
    'ZRIiCgt0cmFuc2FjdGlvbhgBIAEoDEgAUgt0cmFuc2FjdGlvbhJACgltdXRhdGlvbnMYBiADKA'
    'syIi5nb29nbGUuZGF0YXN0b3JlLnYxYmV0YTMuTXV0YXRpb25SCW11dGF0aW9ucyJGCgRNb2Rl'
    'EhQKEE1PREVfVU5TUEVDSUZJRUQQABIRCg1UUkFOU0FDVElPTkFMEAESFQoRTk9OX1RSQU5TQU'
    'NUSU9OQUwQAkIWChR0cmFuc2FjdGlvbl9zZWxlY3Rvcg==');

@$core.Deprecated('Use commitResponseDescriptor instead')
const CommitResponse$json = {
  '1': 'CommitResponse',
  '2': [
    {
      '1': 'mutation_results',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.MutationResult',
      '10': 'mutationResults'
    },
    {'1': 'index_updates', '3': 4, '4': 1, '5': 5, '10': 'indexUpdates'},
  ],
};

/// Descriptor for `CommitResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commitResponseDescriptor = $convert.base64Decode(
    'Cg5Db21taXRSZXNwb25zZRJTChBtdXRhdGlvbl9yZXN1bHRzGAMgAygLMiguZ29vZ2xlLmRhdG'
    'FzdG9yZS52MWJldGEzLk11dGF0aW9uUmVzdWx0Ug9tdXRhdGlvblJlc3VsdHMSIwoNaW5kZXhf'
    'dXBkYXRlcxgEIAEoBVIMaW5kZXhVcGRhdGVz');

@$core.Deprecated('Use allocateIdsRequestDescriptor instead')
const AllocateIdsRequest$json = {
  '1': 'AllocateIdsRequest',
  '2': [
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '10': 'projectId'},
    {
      '1': 'keys',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.Key',
      '10': 'keys'
    },
  ],
};

/// Descriptor for `AllocateIdsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allocateIdsRequestDescriptor = $convert.base64Decode(
    'ChJBbGxvY2F0ZUlkc1JlcXVlc3QSHQoKcHJvamVjdF9pZBgIIAEoCVIJcHJvamVjdElkEjEKBG'
    'tleXMYASADKAsyHS5nb29nbGUuZGF0YXN0b3JlLnYxYmV0YTMuS2V5UgRrZXlz');

@$core.Deprecated('Use allocateIdsResponseDescriptor instead')
const AllocateIdsResponse$json = {
  '1': 'AllocateIdsResponse',
  '2': [
    {
      '1': 'keys',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.Key',
      '10': 'keys'
    },
  ],
};

/// Descriptor for `AllocateIdsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allocateIdsResponseDescriptor = $convert.base64Decode(
    'ChNBbGxvY2F0ZUlkc1Jlc3BvbnNlEjEKBGtleXMYASADKAsyHS5nb29nbGUuZGF0YXN0b3JlLn'
    'YxYmV0YTMuS2V5UgRrZXlz');

@$core.Deprecated('Use reserveIdsRequestDescriptor instead')
const ReserveIdsRequest$json = {
  '1': 'ReserveIdsRequest',
  '2': [
    {'1': 'project_id', '3': 8, '4': 1, '5': 9, '10': 'projectId'},
    {'1': 'database_id', '3': 9, '4': 1, '5': 9, '10': 'databaseId'},
    {
      '1': 'keys',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.v1beta3.Key',
      '10': 'keys'
    },
  ],
};

/// Descriptor for `ReserveIdsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reserveIdsRequestDescriptor = $convert.base64Decode(
    'ChFSZXNlcnZlSWRzUmVxdWVzdBIdCgpwcm9qZWN0X2lkGAggASgJUglwcm9qZWN0SWQSHwoLZG'
    'F0YWJhc2VfaWQYCSABKAlSCmRhdGFiYXNlSWQSMQoEa2V5cxgBIAMoCzIdLmdvb2dsZS5kYXRh'
    'c3RvcmUudjFiZXRhMy5LZXlSBGtleXM=');

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
      '6': '.google.datastore.v1beta3.Entity',
      '9': 0,
      '10': 'insert'
    },
    {
      '1': 'update',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.Entity',
      '9': 0,
      '10': 'update'
    },
    {
      '1': 'upsert',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.Entity',
      '9': 0,
      '10': 'upsert'
    },
    {
      '1': 'delete',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.Key',
      '9': 0,
      '10': 'delete'
    },
    {'1': 'base_version', '3': 8, '4': 1, '5': 3, '9': 1, '10': 'baseVersion'},
  ],
  '8': [
    {'1': 'operation'},
    {'1': 'conflict_detection_strategy'},
  ],
};

/// Descriptor for `Mutation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mutationDescriptor = $convert.base64Decode(
    'CghNdXRhdGlvbhI6CgZpbnNlcnQYBCABKAsyIC5nb29nbGUuZGF0YXN0b3JlLnYxYmV0YTMuRW'
    '50aXR5SABSBmluc2VydBI6CgZ1cGRhdGUYBSABKAsyIC5nb29nbGUuZGF0YXN0b3JlLnYxYmV0'
    'YTMuRW50aXR5SABSBnVwZGF0ZRI6CgZ1cHNlcnQYBiABKAsyIC5nb29nbGUuZGF0YXN0b3JlLn'
    'YxYmV0YTMuRW50aXR5SABSBnVwc2VydBI3CgZkZWxldGUYByABKAsyHS5nb29nbGUuZGF0YXN0'
    'b3JlLnYxYmV0YTMuS2V5SABSBmRlbGV0ZRIjCgxiYXNlX3ZlcnNpb24YCCABKANIAVILYmFzZV'
    'ZlcnNpb25CCwoJb3BlcmF0aW9uQh0KG2NvbmZsaWN0X2RldGVjdGlvbl9zdHJhdGVneQ==');

@$core.Deprecated('Use mutationResultDescriptor instead')
const MutationResult$json = {
  '1': 'MutationResult',
  '2': [
    {
      '1': 'key',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.Key',
      '10': 'key'
    },
    {'1': 'version', '3': 4, '4': 1, '5': 3, '10': 'version'},
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
    'Cg5NdXRhdGlvblJlc3VsdBIvCgNrZXkYAyABKAsyHS5nb29nbGUuZGF0YXN0b3JlLnYxYmV0YT'
    'MuS2V5UgNrZXkSGAoHdmVyc2lvbhgEIAEoA1IHdmVyc2lvbhIrChFjb25mbGljdF9kZXRlY3Rl'
    'ZBgFIAEoCFIQY29uZmxpY3REZXRlY3RlZA==');

@$core.Deprecated('Use readOptionsDescriptor instead')
const ReadOptions$json = {
  '1': 'ReadOptions',
  '2': [
    {
      '1': 'read_consistency',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.v1beta3.ReadOptions.ReadConsistency',
      '9': 0,
      '10': 'readConsistency'
    },
    {'1': 'transaction', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'transaction'},
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
    'CgtSZWFkT3B0aW9ucxJiChByZWFkX2NvbnNpc3RlbmN5GAEgASgOMjUuZ29vZ2xlLmRhdGFzdG'
    '9yZS52MWJldGEzLlJlYWRPcHRpb25zLlJlYWRDb25zaXN0ZW5jeUgAUg9yZWFkQ29uc2lzdGVu'
    'Y3kSIgoLdHJhbnNhY3Rpb24YAiABKAxIAFILdHJhbnNhY3Rpb24iTQoPUmVhZENvbnNpc3Rlbm'
    'N5EiAKHFJFQURfQ09OU0lTVEVOQ1lfVU5TUEVDSUZJRUQQABIKCgZTVFJPTkcQARIMCghFVkVO'
    'VFVBTBACQhIKEGNvbnNpc3RlbmN5X3R5cGU=');

@$core.Deprecated('Use transactionOptionsDescriptor instead')
const TransactionOptions$json = {
  '1': 'TransactionOptions',
  '2': [
    {
      '1': 'read_write',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.TransactionOptions.ReadWrite',
      '9': 0,
      '10': 'readWrite'
    },
    {
      '1': 'read_only',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.v1beta3.TransactionOptions.ReadOnly',
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
};

/// Descriptor for `TransactionOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionOptionsDescriptor = $convert.base64Decode(
    'ChJUcmFuc2FjdGlvbk9wdGlvbnMSVwoKcmVhZF93cml0ZRgBIAEoCzI2Lmdvb2dsZS5kYXRhc3'
    'RvcmUudjFiZXRhMy5UcmFuc2FjdGlvbk9wdGlvbnMuUmVhZFdyaXRlSABSCXJlYWRXcml0ZRJU'
    'CglyZWFkX29ubHkYAiABKAsyNS5nb29nbGUuZGF0YXN0b3JlLnYxYmV0YTMuVHJhbnNhY3Rpb2'
    '5PcHRpb25zLlJlYWRPbmx5SABSCHJlYWRPbmx5Gj4KCVJlYWRXcml0ZRIxChRwcmV2aW91c190'
    'cmFuc2FjdGlvbhgBIAEoDFITcHJldmlvdXNUcmFuc2FjdGlvbhoKCghSZWFkT25seUIGCgRtb2'
    'Rl');
