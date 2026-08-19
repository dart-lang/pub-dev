//
//  Generated code. Do not modify.
//  source: google/datastore/admin/v1/datastore_admin.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use operationTypeDescriptor instead')
const OperationType$json = {
  '1': 'OperationType',
  '2': [
    {'1': 'OPERATION_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'EXPORT_ENTITIES', '2': 1},
    {'1': 'IMPORT_ENTITIES', '2': 2},
    {'1': 'CREATE_INDEX', '2': 3},
    {'1': 'DELETE_INDEX', '2': 4},
  ],
};

/// Descriptor for `OperationType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List operationTypeDescriptor = $convert.base64Decode(
    'Cg1PcGVyYXRpb25UeXBlEh4KGk9QRVJBVElPTl9UWVBFX1VOU1BFQ0lGSUVEEAASEwoPRVhQT1'
    'JUX0VOVElUSUVTEAESEwoPSU1QT1JUX0VOVElUSUVTEAISEAoMQ1JFQVRFX0lOREVYEAMSEAoM'
    'REVMRVRFX0lOREVYEAQ=');

@$core.Deprecated('Use commonMetadataDescriptor instead')
const CommonMetadata$json = {
  '1': 'CommonMetadata',
  '2': [
    {
      '1': 'start_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startTime'
    },
    {
      '1': 'end_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'endTime'
    },
    {
      '1': 'operation_type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.admin.v1.OperationType',
      '10': 'operationType'
    },
    {
      '1': 'labels',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.admin.v1.CommonMetadata.LabelsEntry',
      '10': 'labels'
    },
    {
      '1': 'state',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.admin.v1.CommonMetadata.State',
      '10': 'state'
    },
  ],
  '3': [CommonMetadata_LabelsEntry$json],
  '4': [CommonMetadata_State$json],
};

@$core.Deprecated('Use commonMetadataDescriptor instead')
const CommonMetadata_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use commonMetadataDescriptor instead')
const CommonMetadata_State$json = {
  '1': 'State',
  '2': [
    {'1': 'STATE_UNSPECIFIED', '2': 0},
    {'1': 'INITIALIZING', '2': 1},
    {'1': 'PROCESSING', '2': 2},
    {'1': 'CANCELLING', '2': 3},
    {'1': 'FINALIZING', '2': 4},
    {'1': 'SUCCESSFUL', '2': 5},
    {'1': 'FAILED', '2': 6},
    {'1': 'CANCELLED', '2': 7},
  ],
};

/// Descriptor for `CommonMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commonMetadataDescriptor = $convert.base64Decode(
    'Cg5Db21tb25NZXRhZGF0YRI5CgpzdGFydF90aW1lGAEgASgLMhouZ29vZ2xlLnByb3RvYnVmLl'
    'RpbWVzdGFtcFIJc3RhcnRUaW1lEjUKCGVuZF90aW1lGAIgASgLMhouZ29vZ2xlLnByb3RvYnVm'
    'LlRpbWVzdGFtcFIHZW5kVGltZRJPCg5vcGVyYXRpb25fdHlwZRgDIAEoDjIoLmdvb2dsZS5kYX'
    'Rhc3RvcmUuYWRtaW4udjEuT3BlcmF0aW9uVHlwZVINb3BlcmF0aW9uVHlwZRJNCgZsYWJlbHMY'
    'BCADKAsyNS5nb29nbGUuZGF0YXN0b3JlLmFkbWluLnYxLkNvbW1vbk1ldGFkYXRhLkxhYmVsc0'
    'VudHJ5UgZsYWJlbHMSRQoFc3RhdGUYBSABKA4yLy5nb29nbGUuZGF0YXN0b3JlLmFkbWluLnYx'
    'LkNvbW1vbk1ldGFkYXRhLlN0YXRlUgVzdGF0ZRo5CgtMYWJlbHNFbnRyeRIQCgNrZXkYASABKA'
    'lSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBIosBCgVTdGF0ZRIVChFTVEFURV9VTlNQ'
    'RUNJRklFRBAAEhAKDElOSVRJQUxJWklORxABEg4KClBST0NFU1NJTkcQAhIOCgpDQU5DRUxMSU'
    '5HEAMSDgoKRklOQUxJWklORxAEEg4KClNVQ0NFU1NGVUwQBRIKCgZGQUlMRUQQBhINCglDQU5D'
    'RUxMRUQQBw==');

@$core.Deprecated('Use progressDescriptor instead')
const Progress$json = {
  '1': 'Progress',
  '2': [
    {'1': 'work_completed', '3': 1, '4': 1, '5': 3, '10': 'workCompleted'},
    {'1': 'work_estimated', '3': 2, '4': 1, '5': 3, '10': 'workEstimated'},
  ],
};

/// Descriptor for `Progress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List progressDescriptor = $convert.base64Decode(
    'CghQcm9ncmVzcxIlCg53b3JrX2NvbXBsZXRlZBgBIAEoA1INd29ya0NvbXBsZXRlZBIlCg53b3'
    'JrX2VzdGltYXRlZBgCIAEoA1INd29ya0VzdGltYXRlZA==');

@$core.Deprecated('Use exportEntitiesRequestDescriptor instead')
const ExportEntitiesRequest$json = {
  '1': 'ExportEntitiesRequest',
  '2': [
    {'1': 'project_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'projectId'},
    {
      '1': 'labels',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.admin.v1.ExportEntitiesRequest.LabelsEntry',
      '10': 'labels'
    },
    {
      '1': 'entity_filter',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.EntityFilter',
      '10': 'entityFilter'
    },
    {
      '1': 'output_url_prefix',
      '3': 4,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'outputUrlPrefix'
    },
  ],
  '3': [ExportEntitiesRequest_LabelsEntry$json],
};

@$core.Deprecated('Use exportEntitiesRequestDescriptor instead')
const ExportEntitiesRequest_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ExportEntitiesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportEntitiesRequestDescriptor = $convert.base64Decode(
    'ChVFeHBvcnRFbnRpdGllc1JlcXVlc3QSIgoKcHJvamVjdF9pZBgBIAEoCUID4EECUglwcm9qZW'
    'N0SWQSVAoGbGFiZWxzGAIgAygLMjwuZ29vZ2xlLmRhdGFzdG9yZS5hZG1pbi52MS5FeHBvcnRF'
    'bnRpdGllc1JlcXVlc3QuTGFiZWxzRW50cnlSBmxhYmVscxJMCg1lbnRpdHlfZmlsdGVyGAMgAS'
    'gLMicuZ29vZ2xlLmRhdGFzdG9yZS5hZG1pbi52MS5FbnRpdHlGaWx0ZXJSDGVudGl0eUZpbHRl'
    'chIvChFvdXRwdXRfdXJsX3ByZWZpeBgEIAEoCUID4EECUg9vdXRwdXRVcmxQcmVmaXgaOQoLTG'
    'FiZWxzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use importEntitiesRequestDescriptor instead')
const ImportEntitiesRequest$json = {
  '1': 'ImportEntitiesRequest',
  '2': [
    {'1': 'project_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'projectId'},
    {
      '1': 'labels',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.admin.v1.ImportEntitiesRequest.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'input_url', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'inputUrl'},
    {
      '1': 'entity_filter',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.EntityFilter',
      '10': 'entityFilter'
    },
  ],
  '3': [ImportEntitiesRequest_LabelsEntry$json],
};

@$core.Deprecated('Use importEntitiesRequestDescriptor instead')
const ImportEntitiesRequest_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ImportEntitiesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importEntitiesRequestDescriptor = $convert.base64Decode(
    'ChVJbXBvcnRFbnRpdGllc1JlcXVlc3QSIgoKcHJvamVjdF9pZBgBIAEoCUID4EECUglwcm9qZW'
    'N0SWQSVAoGbGFiZWxzGAIgAygLMjwuZ29vZ2xlLmRhdGFzdG9yZS5hZG1pbi52MS5JbXBvcnRF'
    'bnRpdGllc1JlcXVlc3QuTGFiZWxzRW50cnlSBmxhYmVscxIgCglpbnB1dF91cmwYAyABKAlCA+'
    'BBAlIIaW5wdXRVcmwSTAoNZW50aXR5X2ZpbHRlchgEIAEoCzInLmdvb2dsZS5kYXRhc3RvcmUu'
    'YWRtaW4udjEuRW50aXR5RmlsdGVyUgxlbnRpdHlGaWx0ZXIaOQoLTGFiZWxzRW50cnkSEAoDa2'
    'V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use exportEntitiesResponseDescriptor instead')
const ExportEntitiesResponse$json = {
  '1': 'ExportEntitiesResponse',
  '2': [
    {'1': 'output_url', '3': 1, '4': 1, '5': 9, '10': 'outputUrl'},
  ],
};

/// Descriptor for `ExportEntitiesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportEntitiesResponseDescriptor =
    $convert.base64Decode(
        'ChZFeHBvcnRFbnRpdGllc1Jlc3BvbnNlEh0KCm91dHB1dF91cmwYASABKAlSCW91dHB1dFVybA'
        '==');

@$core.Deprecated('Use exportEntitiesMetadataDescriptor instead')
const ExportEntitiesMetadata$json = {
  '1': 'ExportEntitiesMetadata',
  '2': [
    {
      '1': 'common',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.CommonMetadata',
      '10': 'common'
    },
    {
      '1': 'progress_entities',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.Progress',
      '10': 'progressEntities'
    },
    {
      '1': 'progress_bytes',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.Progress',
      '10': 'progressBytes'
    },
    {
      '1': 'entity_filter',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.EntityFilter',
      '10': 'entityFilter'
    },
    {'1': 'output_url_prefix', '3': 5, '4': 1, '5': 9, '10': 'outputUrlPrefix'},
  ],
};

/// Descriptor for `ExportEntitiesMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportEntitiesMetadataDescriptor = $convert.base64Decode(
    'ChZFeHBvcnRFbnRpdGllc01ldGFkYXRhEkEKBmNvbW1vbhgBIAEoCzIpLmdvb2dsZS5kYXRhc3'
    'RvcmUuYWRtaW4udjEuQ29tbW9uTWV0YWRhdGFSBmNvbW1vbhJQChFwcm9ncmVzc19lbnRpdGll'
    'cxgCIAEoCzIjLmdvb2dsZS5kYXRhc3RvcmUuYWRtaW4udjEuUHJvZ3Jlc3NSEHByb2dyZXNzRW'
    '50aXRpZXMSSgoOcHJvZ3Jlc3NfYnl0ZXMYAyABKAsyIy5nb29nbGUuZGF0YXN0b3JlLmFkbWlu'
    'LnYxLlByb2dyZXNzUg1wcm9ncmVzc0J5dGVzEkwKDWVudGl0eV9maWx0ZXIYBCABKAsyJy5nb2'
    '9nbGUuZGF0YXN0b3JlLmFkbWluLnYxLkVudGl0eUZpbHRlclIMZW50aXR5RmlsdGVyEioKEW91'
    'dHB1dF91cmxfcHJlZml4GAUgASgJUg9vdXRwdXRVcmxQcmVmaXg=');

@$core.Deprecated('Use importEntitiesMetadataDescriptor instead')
const ImportEntitiesMetadata$json = {
  '1': 'ImportEntitiesMetadata',
  '2': [
    {
      '1': 'common',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.CommonMetadata',
      '10': 'common'
    },
    {
      '1': 'progress_entities',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.Progress',
      '10': 'progressEntities'
    },
    {
      '1': 'progress_bytes',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.Progress',
      '10': 'progressBytes'
    },
    {
      '1': 'entity_filter',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.EntityFilter',
      '10': 'entityFilter'
    },
    {'1': 'input_url', '3': 5, '4': 1, '5': 9, '10': 'inputUrl'},
  ],
};

/// Descriptor for `ImportEntitiesMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importEntitiesMetadataDescriptor = $convert.base64Decode(
    'ChZJbXBvcnRFbnRpdGllc01ldGFkYXRhEkEKBmNvbW1vbhgBIAEoCzIpLmdvb2dsZS5kYXRhc3'
    'RvcmUuYWRtaW4udjEuQ29tbW9uTWV0YWRhdGFSBmNvbW1vbhJQChFwcm9ncmVzc19lbnRpdGll'
    'cxgCIAEoCzIjLmdvb2dsZS5kYXRhc3RvcmUuYWRtaW4udjEuUHJvZ3Jlc3NSEHByb2dyZXNzRW'
    '50aXRpZXMSSgoOcHJvZ3Jlc3NfYnl0ZXMYAyABKAsyIy5nb29nbGUuZGF0YXN0b3JlLmFkbWlu'
    'LnYxLlByb2dyZXNzUg1wcm9ncmVzc0J5dGVzEkwKDWVudGl0eV9maWx0ZXIYBCABKAsyJy5nb2'
    '9nbGUuZGF0YXN0b3JlLmFkbWluLnYxLkVudGl0eUZpbHRlclIMZW50aXR5RmlsdGVyEhsKCWlu'
    'cHV0X3VybBgFIAEoCVIIaW5wdXRVcmw=');

@$core.Deprecated('Use entityFilterDescriptor instead')
const EntityFilter$json = {
  '1': 'EntityFilter',
  '2': [
    {'1': 'kinds', '3': 1, '4': 3, '5': 9, '10': 'kinds'},
    {'1': 'namespace_ids', '3': 2, '4': 3, '5': 9, '10': 'namespaceIds'},
  ],
};

/// Descriptor for `EntityFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entityFilterDescriptor = $convert.base64Decode(
    'CgxFbnRpdHlGaWx0ZXISFAoFa2luZHMYASADKAlSBWtpbmRzEiMKDW5hbWVzcGFjZV9pZHMYAi'
    'ADKAlSDG5hbWVzcGFjZUlkcw==');

@$core.Deprecated('Use createIndexRequestDescriptor instead')
const CreateIndexRequest$json = {
  '1': 'CreateIndexRequest',
  '2': [
    {'1': 'project_id', '3': 1, '4': 1, '5': 9, '10': 'projectId'},
    {
      '1': 'index',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.Index',
      '10': 'index'
    },
  ],
};

/// Descriptor for `CreateIndexRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createIndexRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVJbmRleFJlcXVlc3QSHQoKcHJvamVjdF9pZBgBIAEoCVIJcHJvamVjdElkEjYKBW'
    'luZGV4GAMgASgLMiAuZ29vZ2xlLmRhdGFzdG9yZS5hZG1pbi52MS5JbmRleFIFaW5kZXg=');

@$core.Deprecated('Use deleteIndexRequestDescriptor instead')
const DeleteIndexRequest$json = {
  '1': 'DeleteIndexRequest',
  '2': [
    {'1': 'project_id', '3': 1, '4': 1, '5': 9, '10': 'projectId'},
    {'1': 'index_id', '3': 3, '4': 1, '5': 9, '10': 'indexId'},
  ],
};

/// Descriptor for `DeleteIndexRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteIndexRequestDescriptor = $convert.base64Decode(
    'ChJEZWxldGVJbmRleFJlcXVlc3QSHQoKcHJvamVjdF9pZBgBIAEoCVIJcHJvamVjdElkEhkKCG'
    'luZGV4X2lkGAMgASgJUgdpbmRleElk');

@$core.Deprecated('Use getIndexRequestDescriptor instead')
const GetIndexRequest$json = {
  '1': 'GetIndexRequest',
  '2': [
    {'1': 'project_id', '3': 1, '4': 1, '5': 9, '10': 'projectId'},
    {'1': 'index_id', '3': 3, '4': 1, '5': 9, '10': 'indexId'},
  ],
};

/// Descriptor for `GetIndexRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIndexRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRJbmRleFJlcXVlc3QSHQoKcHJvamVjdF9pZBgBIAEoCVIJcHJvamVjdElkEhkKCGluZG'
    'V4X2lkGAMgASgJUgdpbmRleElk');

@$core.Deprecated('Use listIndexesRequestDescriptor instead')
const ListIndexesRequest$json = {
  '1': 'ListIndexesRequest',
  '2': [
    {'1': 'project_id', '3': 1, '4': 1, '5': 9, '10': 'projectId'},
    {'1': 'filter', '3': 3, '4': 1, '5': 9, '10': 'filter'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 5, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListIndexesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listIndexesRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0SW5kZXhlc1JlcXVlc3QSHQoKcHJvamVjdF9pZBgBIAEoCVIJcHJvamVjdElkEhYKBm'
    'ZpbHRlchgDIAEoCVIGZmlsdGVyEhsKCXBhZ2Vfc2l6ZRgEIAEoBVIIcGFnZVNpemUSHQoKcGFn'
    'ZV90b2tlbhgFIAEoCVIJcGFnZVRva2Vu');

@$core.Deprecated('Use listIndexesResponseDescriptor instead')
const ListIndexesResponse$json = {
  '1': 'ListIndexesResponse',
  '2': [
    {
      '1': 'indexes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.admin.v1.Index',
      '10': 'indexes'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListIndexesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listIndexesResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0SW5kZXhlc1Jlc3BvbnNlEjoKB2luZGV4ZXMYASADKAsyIC5nb29nbGUuZGF0YXN0b3'
    'JlLmFkbWluLnYxLkluZGV4UgdpbmRleGVzEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4'
    'dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use indexOperationMetadataDescriptor instead')
const IndexOperationMetadata$json = {
  '1': 'IndexOperationMetadata',
  '2': [
    {
      '1': 'common',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.CommonMetadata',
      '10': 'common'
    },
    {
      '1': 'progress_entities',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.datastore.admin.v1.Progress',
      '10': 'progressEntities'
    },
    {'1': 'index_id', '3': 3, '4': 1, '5': 9, '10': 'indexId'},
  ],
};

/// Descriptor for `IndexOperationMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexOperationMetadataDescriptor = $convert.base64Decode(
    'ChZJbmRleE9wZXJhdGlvbk1ldGFkYXRhEkEKBmNvbW1vbhgBIAEoCzIpLmdvb2dsZS5kYXRhc3'
    'RvcmUuYWRtaW4udjEuQ29tbW9uTWV0YWRhdGFSBmNvbW1vbhJQChFwcm9ncmVzc19lbnRpdGll'
    'cxgCIAEoCzIjLmdvb2dsZS5kYXRhc3RvcmUuYWRtaW4udjEuUHJvZ3Jlc3NSEHByb2dyZXNzRW'
    '50aXRpZXMSGQoIaW5kZXhfaWQYAyABKAlSB2luZGV4SWQ=');

@$core.Deprecated('Use datastoreFirestoreMigrationMetadataDescriptor instead')
const DatastoreFirestoreMigrationMetadata$json = {
  '1': 'DatastoreFirestoreMigrationMetadata',
  '2': [
    {
      '1': 'migration_state',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.admin.v1.MigrationState',
      '10': 'migrationState'
    },
    {
      '1': 'migration_step',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.admin.v1.MigrationStep',
      '10': 'migrationStep'
    },
  ],
};

/// Descriptor for `DatastoreFirestoreMigrationMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List datastoreFirestoreMigrationMetadataDescriptor =
    $convert.base64Decode(
        'CiNEYXRhc3RvcmVGaXJlc3RvcmVNaWdyYXRpb25NZXRhZGF0YRJSCg9taWdyYXRpb25fc3RhdG'
        'UYASABKA4yKS5nb29nbGUuZGF0YXN0b3JlLmFkbWluLnYxLk1pZ3JhdGlvblN0YXRlUg5taWdy'
        'YXRpb25TdGF0ZRJPCg5taWdyYXRpb25fc3RlcBgCIAEoDjIoLmdvb2dsZS5kYXRhc3RvcmUuYW'
        'RtaW4udjEuTWlncmF0aW9uU3RlcFINbWlncmF0aW9uU3RlcA==');
