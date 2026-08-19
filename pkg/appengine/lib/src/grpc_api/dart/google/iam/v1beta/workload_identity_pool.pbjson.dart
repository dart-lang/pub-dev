//
//  Generated code. Do not modify.
//  source: google/iam/v1beta/workload_identity_pool.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use workloadIdentityPoolDescriptor instead')
const WorkloadIdentityPool$json = {
  '1': 'WorkloadIdentityPool',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'state',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.iam.v1beta.WorkloadIdentityPool.State',
      '8': {},
      '10': 'state'
    },
    {'1': 'disabled', '3': 5, '4': 1, '5': 8, '10': 'disabled'},
  ],
  '4': [WorkloadIdentityPool_State$json],
  '7': {},
};

@$core.Deprecated('Use workloadIdentityPoolDescriptor instead')
const WorkloadIdentityPool_State$json = {
  '1': 'State',
  '2': [
    {'1': 'STATE_UNSPECIFIED', '2': 0},
    {'1': 'ACTIVE', '2': 1},
    {'1': 'DELETED', '2': 2},
  ],
};

/// Descriptor for `WorkloadIdentityPool`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List workloadIdentityPoolDescriptor = $convert.base64Decode(
    'ChRXb3JrbG9hZElkZW50aXR5UG9vbBIXCgRuYW1lGAEgASgJQgPgQQNSBG5hbWUSIQoMZGlzcG'
    'xheV9uYW1lGAIgASgJUgtkaXNwbGF5TmFtZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3Jp'
    'cHRpb24SSAoFc3RhdGUYBCABKA4yLS5nb29nbGUuaWFtLnYxYmV0YS5Xb3JrbG9hZElkZW50aX'
    'R5UG9vbC5TdGF0ZUID4EEDUgVzdGF0ZRIaCghkaXNhYmxlZBgFIAEoCFIIZGlzYWJsZWQiNwoF'
    'U3RhdGUSFQoRU1RBVEVfVU5TUEVDSUZJRUQQABIKCgZBQ1RJVkUQARILCgdERUxFVEVEEAI6hQ'
    'HqQYEBCidpYW0uZ29vZ2xlYXBpcy5jb20vV29ya2xvYWRJZGVudGl0eVBvb2wSVnByb2plY3Rz'
    'L3twcm9qZWN0fS9sb2NhdGlvbnMve2xvY2F0aW9ufS93b3JrbG9hZElkZW50aXR5UG9vbHMve3'
    'dvcmtsb2FkX2lkZW50aXR5X3Bvb2x9');

@$core.Deprecated('Use workloadIdentityPoolProviderDescriptor instead')
const WorkloadIdentityPoolProvider$json = {
  '1': 'WorkloadIdentityPoolProvider',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'state',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.iam.v1beta.WorkloadIdentityPoolProvider.State',
      '8': {},
      '10': 'state'
    },
    {'1': 'disabled', '3': 5, '4': 1, '5': 8, '10': 'disabled'},
    {
      '1': 'attribute_mapping',
      '3': 6,
      '4': 3,
      '5': 11,
      '6':
          '.google.iam.v1beta.WorkloadIdentityPoolProvider.AttributeMappingEntry',
      '10': 'attributeMapping'
    },
    {
      '1': 'attribute_condition',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'attributeCondition'
    },
    {
      '1': 'aws',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.iam.v1beta.WorkloadIdentityPoolProvider.Aws',
      '9': 0,
      '10': 'aws'
    },
    {
      '1': 'oidc',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.iam.v1beta.WorkloadIdentityPoolProvider.Oidc',
      '9': 0,
      '10': 'oidc'
    },
  ],
  '3': [
    WorkloadIdentityPoolProvider_Aws$json,
    WorkloadIdentityPoolProvider_Oidc$json,
    WorkloadIdentityPoolProvider_AttributeMappingEntry$json
  ],
  '4': [WorkloadIdentityPoolProvider_State$json],
  '7': {},
  '8': [
    {'1': 'provider_config'},
  ],
};

@$core.Deprecated('Use workloadIdentityPoolProviderDescriptor instead')
const WorkloadIdentityPoolProvider_Aws$json = {
  '1': 'Aws',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'accountId'},
  ],
};

@$core.Deprecated('Use workloadIdentityPoolProviderDescriptor instead')
const WorkloadIdentityPoolProvider_Oidc$json = {
  '1': 'Oidc',
  '2': [
    {'1': 'issuer_uri', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'issuerUri'},
    {
      '1': 'allowed_audiences',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'allowedAudiences'
    },
  ],
};

@$core.Deprecated('Use workloadIdentityPoolProviderDescriptor instead')
const WorkloadIdentityPoolProvider_AttributeMappingEntry$json = {
  '1': 'AttributeMappingEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use workloadIdentityPoolProviderDescriptor instead')
const WorkloadIdentityPoolProvider_State$json = {
  '1': 'State',
  '2': [
    {'1': 'STATE_UNSPECIFIED', '2': 0},
    {'1': 'ACTIVE', '2': 1},
    {'1': 'DELETED', '2': 2},
  ],
};

/// Descriptor for `WorkloadIdentityPoolProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List workloadIdentityPoolProviderDescriptor = $convert.base64Decode(
    'ChxXb3JrbG9hZElkZW50aXR5UG9vbFByb3ZpZGVyEhcKBG5hbWUYASABKAlCA+BBA1IEbmFtZR'
    'IhCgxkaXNwbGF5X25hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEiAKC2Rlc2NyaXB0aW9uGAMgASgJ'
    'UgtkZXNjcmlwdGlvbhJQCgVzdGF0ZRgEIAEoDjI1Lmdvb2dsZS5pYW0udjFiZXRhLldvcmtsb2'
    'FkSWRlbnRpdHlQb29sUHJvdmlkZXIuU3RhdGVCA+BBA1IFc3RhdGUSGgoIZGlzYWJsZWQYBSAB'
    'KAhSCGRpc2FibGVkEnIKEWF0dHJpYnV0ZV9tYXBwaW5nGAYgAygLMkUuZ29vZ2xlLmlhbS52MW'
    'JldGEuV29ya2xvYWRJZGVudGl0eVBvb2xQcm92aWRlci5BdHRyaWJ1dGVNYXBwaW5nRW50cnlS'
    'EGF0dHJpYnV0ZU1hcHBpbmcSLwoTYXR0cmlidXRlX2NvbmRpdGlvbhgHIAEoCVISYXR0cmlidX'
    'RlQ29uZGl0aW9uEkcKA2F3cxgIIAEoCzIzLmdvb2dsZS5pYW0udjFiZXRhLldvcmtsb2FkSWRl'
    'bnRpdHlQb29sUHJvdmlkZXIuQXdzSABSA2F3cxJKCgRvaWRjGAkgASgLMjQuZ29vZ2xlLmlhbS'
    '52MWJldGEuV29ya2xvYWRJZGVudGl0eVBvb2xQcm92aWRlci5PaWRjSABSBG9pZGMaKQoDQXdz'
    'EiIKCmFjY291bnRfaWQYASABKAlCA+BBAlIJYWNjb3VudElkGlcKBE9pZGMSIgoKaXNzdWVyX3'
    'VyaRgBIAEoCUID4EECUglpc3N1ZXJVcmkSKwoRYWxsb3dlZF9hdWRpZW5jZXMYAiADKAlSEGFs'
    'bG93ZWRBdWRpZW5jZXMaQwoVQXR0cmlidXRlTWFwcGluZ0VudHJ5EhAKA2tleRgBIAEoCVIDa2'
    'V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEiNwoFU3RhdGUSFQoRU1RBVEVfVU5TUEVDSUZJ'
    'RUQQABIKCgZBQ1RJVkUQARILCgdERUxFVEVEEAI6ugHqQbYBCi9pYW0uZ29vZ2xlYXBpcy5jb2'
    '0vV29ya2xvYWRJZGVudGl0eVBvb2xQcm92aWRlchKCAXByb2plY3RzL3twcm9qZWN0fS9sb2Nh'
    'dGlvbnMve2xvY2F0aW9ufS93b3JrbG9hZElkZW50aXR5UG9vbHMve3dvcmtsb2FkX2lkZW50aX'
    'R5X3Bvb2x9L3Byb3ZpZGVycy97d29ya2xvYWRfaWRlbnRpdHlfcG9vbF9wcm92aWRlcn1CEQoP'
    'cHJvdmlkZXJfY29uZmln');

@$core.Deprecated('Use listWorkloadIdentityPoolsRequestDescriptor instead')
const ListWorkloadIdentityPoolsRequest$json = {
  '1': 'ListWorkloadIdentityPoolsRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
    {'1': 'show_deleted', '3': 4, '4': 1, '5': 8, '10': 'showDeleted'},
  ],
};

/// Descriptor for `ListWorkloadIdentityPoolsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listWorkloadIdentityPoolsRequestDescriptor =
    $convert.base64Decode(
        'CiBMaXN0V29ya2xvYWRJZGVudGl0eVBvb2xzUmVxdWVzdBJLCgZwYXJlbnQYASABKAlCM+BBAv'
        'pBLQorY2xvdWRyZXNvdXJjZW1hbmFnZXIuZ29vZ2xlYXBpcy5jb20vUHJvamVjdFIGcGFyZW50'
        'EhsKCXBhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgDIAEoCVIJcGFnZV'
        'Rva2VuEiEKDHNob3dfZGVsZXRlZBgEIAEoCFILc2hvd0RlbGV0ZWQ=');

@$core.Deprecated('Use listWorkloadIdentityPoolsResponseDescriptor instead')
const ListWorkloadIdentityPoolsResponse$json = {
  '1': 'ListWorkloadIdentityPoolsResponse',
  '2': [
    {
      '1': 'workload_identity_pools',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.iam.v1beta.WorkloadIdentityPool',
      '10': 'workloadIdentityPools'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListWorkloadIdentityPoolsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listWorkloadIdentityPoolsResponseDescriptor =
    $convert.base64Decode(
        'CiFMaXN0V29ya2xvYWRJZGVudGl0eVBvb2xzUmVzcG9uc2USXwoXd29ya2xvYWRfaWRlbnRpdH'
        'lfcG9vbHMYASADKAsyJy5nb29nbGUuaWFtLnYxYmV0YS5Xb3JrbG9hZElkZW50aXR5UG9vbFIV'
        'd29ya2xvYWRJZGVudGl0eVBvb2xzEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2'
        'VUb2tlbg==');

@$core.Deprecated('Use getWorkloadIdentityPoolRequestDescriptor instead')
const GetWorkloadIdentityPoolRequest$json = {
  '1': 'GetWorkloadIdentityPoolRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetWorkloadIdentityPoolRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWorkloadIdentityPoolRequestDescriptor =
    $convert.base64Decode(
        'Ch5HZXRXb3JrbG9hZElkZW50aXR5UG9vbFJlcXVlc3QSQwoEbmFtZRgBIAEoCUIv4EEC+kEpCi'
        'dpYW0uZ29vZ2xlYXBpcy5jb20vV29ya2xvYWRJZGVudGl0eVBvb2xSBG5hbWU=');

@$core.Deprecated('Use createWorkloadIdentityPoolRequestDescriptor instead')
const CreateWorkloadIdentityPoolRequest$json = {
  '1': 'CreateWorkloadIdentityPoolRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {
      '1': 'workload_identity_pool',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.iam.v1beta.WorkloadIdentityPool',
      '8': {},
      '10': 'workloadIdentityPool'
    },
    {
      '1': 'workload_identity_pool_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'workloadIdentityPoolId'
    },
  ],
};

/// Descriptor for `CreateWorkloadIdentityPoolRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWorkloadIdentityPoolRequestDescriptor = $convert.base64Decode(
    'CiFDcmVhdGVXb3JrbG9hZElkZW50aXR5UG9vbFJlcXVlc3QSSwoGcGFyZW50GAEgASgJQjPgQQ'
    'L6QS0KK2Nsb3VkcmVzb3VyY2VtYW5hZ2VyLmdvb2dsZWFwaXMuY29tL1Byb2plY3RSBnBhcmVu'
    'dBJiChZ3b3JrbG9hZF9pZGVudGl0eV9wb29sGAIgASgLMicuZ29vZ2xlLmlhbS52MWJldGEuV2'
    '9ya2xvYWRJZGVudGl0eVBvb2xCA+BBAlIUd29ya2xvYWRJZGVudGl0eVBvb2wSPgoZd29ya2xv'
    'YWRfaWRlbnRpdHlfcG9vbF9pZBgDIAEoCUID4EECUhZ3b3JrbG9hZElkZW50aXR5UG9vbElk');

@$core.Deprecated('Use updateWorkloadIdentityPoolRequestDescriptor instead')
const UpdateWorkloadIdentityPoolRequest$json = {
  '1': 'UpdateWorkloadIdentityPoolRequest',
  '2': [
    {
      '1': 'workload_identity_pool',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.iam.v1beta.WorkloadIdentityPool',
      '8': {},
      '10': 'workloadIdentityPool'
    },
    {
      '1': 'update_mask',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '8': {},
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `UpdateWorkloadIdentityPoolRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWorkloadIdentityPoolRequestDescriptor =
    $convert.base64Decode(
        'CiFVcGRhdGVXb3JrbG9hZElkZW50aXR5UG9vbFJlcXVlc3QSYgoWd29ya2xvYWRfaWRlbnRpdH'
        'lfcG9vbBgBIAEoCzInLmdvb2dsZS5pYW0udjFiZXRhLldvcmtsb2FkSWRlbnRpdHlQb29sQgPg'
        'QQJSFHdvcmtsb2FkSWRlbnRpdHlQb29sEkAKC3VwZGF0ZV9tYXNrGAIgASgLMhouZ29vZ2xlLn'
        'Byb3RvYnVmLkZpZWxkTWFza0ID4EECUgp1cGRhdGVNYXNr');

@$core.Deprecated('Use deleteWorkloadIdentityPoolRequestDescriptor instead')
const DeleteWorkloadIdentityPoolRequest$json = {
  '1': 'DeleteWorkloadIdentityPoolRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `DeleteWorkloadIdentityPoolRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWorkloadIdentityPoolRequestDescriptor =
    $convert.base64Decode(
        'CiFEZWxldGVXb3JrbG9hZElkZW50aXR5UG9vbFJlcXVlc3QSQwoEbmFtZRgBIAEoCUIv4EEC+k'
        'EpCidpYW0uZ29vZ2xlYXBpcy5jb20vV29ya2xvYWRJZGVudGl0eVBvb2xSBG5hbWU=');

@$core.Deprecated('Use undeleteWorkloadIdentityPoolRequestDescriptor instead')
const UndeleteWorkloadIdentityPoolRequest$json = {
  '1': 'UndeleteWorkloadIdentityPoolRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `UndeleteWorkloadIdentityPoolRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List undeleteWorkloadIdentityPoolRequestDescriptor =
    $convert.base64Decode(
        'CiNVbmRlbGV0ZVdvcmtsb2FkSWRlbnRpdHlQb29sUmVxdWVzdBJDCgRuYW1lGAEgASgJQi/gQQ'
        'L6QSkKJ2lhbS5nb29nbGVhcGlzLmNvbS9Xb3JrbG9hZElkZW50aXR5UG9vbFIEbmFtZQ==');

@$core.Deprecated(
    'Use listWorkloadIdentityPoolProvidersRequestDescriptor instead')
const ListWorkloadIdentityPoolProvidersRequest$json = {
  '1': 'ListWorkloadIdentityPoolProvidersRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
    {'1': 'show_deleted', '3': 4, '4': 1, '5': 8, '10': 'showDeleted'},
  ],
};

/// Descriptor for `ListWorkloadIdentityPoolProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listWorkloadIdentityPoolProvidersRequestDescriptor =
    $convert.base64Decode(
        'CihMaXN0V29ya2xvYWRJZGVudGl0eVBvb2xQcm92aWRlcnNSZXF1ZXN0EkcKBnBhcmVudBgBIA'
        'EoCUIv4EEC+kEpCidpYW0uZ29vZ2xlYXBpcy5jb20vV29ya2xvYWRJZGVudGl0eVBvb2xSBnBh'
        'cmVudBIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4YAyABKAlSCX'
        'BhZ2VUb2tlbhIhCgxzaG93X2RlbGV0ZWQYBCABKAhSC3Nob3dEZWxldGVk');

@$core.Deprecated(
    'Use listWorkloadIdentityPoolProvidersResponseDescriptor instead')
const ListWorkloadIdentityPoolProvidersResponse$json = {
  '1': 'ListWorkloadIdentityPoolProvidersResponse',
  '2': [
    {
      '1': 'workload_identity_pool_providers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.iam.v1beta.WorkloadIdentityPoolProvider',
      '10': 'workloadIdentityPoolProviders'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListWorkloadIdentityPoolProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List
    listWorkloadIdentityPoolProvidersResponseDescriptor = $convert.base64Decode(
        'CilMaXN0V29ya2xvYWRJZGVudGl0eVBvb2xQcm92aWRlcnNSZXNwb25zZRJ4CiB3b3JrbG9hZF'
        '9pZGVudGl0eV9wb29sX3Byb3ZpZGVycxgBIAMoCzIvLmdvb2dsZS5pYW0udjFiZXRhLldvcmts'
        'b2FkSWRlbnRpdHlQb29sUHJvdmlkZXJSHXdvcmtsb2FkSWRlbnRpdHlQb29sUHJvdmlkZXJzEi'
        'YKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbg==');

@$core
    .Deprecated('Use getWorkloadIdentityPoolProviderRequestDescriptor instead')
const GetWorkloadIdentityPoolProviderRequest$json = {
  '1': 'GetWorkloadIdentityPoolProviderRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetWorkloadIdentityPoolProviderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWorkloadIdentityPoolProviderRequestDescriptor =
    $convert.base64Decode(
        'CiZHZXRXb3JrbG9hZElkZW50aXR5UG9vbFByb3ZpZGVyUmVxdWVzdBJLCgRuYW1lGAEgASgJQj'
        'fgQQL6QTEKL2lhbS5nb29nbGVhcGlzLmNvbS9Xb3JrbG9hZElkZW50aXR5UG9vbFByb3ZpZGVy'
        'UgRuYW1l');

@$core.Deprecated(
    'Use createWorkloadIdentityPoolProviderRequestDescriptor instead')
const CreateWorkloadIdentityPoolProviderRequest$json = {
  '1': 'CreateWorkloadIdentityPoolProviderRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {
      '1': 'workload_identity_pool_provider',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.iam.v1beta.WorkloadIdentityPoolProvider',
      '8': {},
      '10': 'workloadIdentityPoolProvider'
    },
    {
      '1': 'workload_identity_pool_provider_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'workloadIdentityPoolProviderId'
    },
  ],
};

/// Descriptor for `CreateWorkloadIdentityPoolProviderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List
    createWorkloadIdentityPoolProviderRequestDescriptor = $convert.base64Decode(
        'CilDcmVhdGVXb3JrbG9hZElkZW50aXR5UG9vbFByb3ZpZGVyUmVxdWVzdBJHCgZwYXJlbnQYAS'
        'ABKAlCL+BBAvpBKQonaWFtLmdvb2dsZWFwaXMuY29tL1dvcmtsb2FkSWRlbnRpdHlQb29sUgZw'
        'YXJlbnQSewofd29ya2xvYWRfaWRlbnRpdHlfcG9vbF9wcm92aWRlchgCIAEoCzIvLmdvb2dsZS'
        '5pYW0udjFiZXRhLldvcmtsb2FkSWRlbnRpdHlQb29sUHJvdmlkZXJCA+BBAlIcd29ya2xvYWRJ'
        'ZGVudGl0eVBvb2xQcm92aWRlchJPCiJ3b3JrbG9hZF9pZGVudGl0eV9wb29sX3Byb3ZpZGVyX2'
        'lkGAMgASgJQgPgQQJSHndvcmtsb2FkSWRlbnRpdHlQb29sUHJvdmlkZXJJZA==');

@$core.Deprecated(
    'Use updateWorkloadIdentityPoolProviderRequestDescriptor instead')
const UpdateWorkloadIdentityPoolProviderRequest$json = {
  '1': 'UpdateWorkloadIdentityPoolProviderRequest',
  '2': [
    {
      '1': 'workload_identity_pool_provider',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.iam.v1beta.WorkloadIdentityPoolProvider',
      '8': {},
      '10': 'workloadIdentityPoolProvider'
    },
    {
      '1': 'update_mask',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '8': {},
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `UpdateWorkloadIdentityPoolProviderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List
    updateWorkloadIdentityPoolProviderRequestDescriptor = $convert.base64Decode(
        'CilVcGRhdGVXb3JrbG9hZElkZW50aXR5UG9vbFByb3ZpZGVyUmVxdWVzdBJ7Ch93b3JrbG9hZF'
        '9pZGVudGl0eV9wb29sX3Byb3ZpZGVyGAEgASgLMi8uZ29vZ2xlLmlhbS52MWJldGEuV29ya2xv'
        'YWRJZGVudGl0eVBvb2xQcm92aWRlckID4EECUhx3b3JrbG9hZElkZW50aXR5UG9vbFByb3ZpZG'
        'VyEkAKC3VwZGF0ZV9tYXNrGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza0ID4EEC'
        'Ugp1cGRhdGVNYXNr');

@$core.Deprecated(
    'Use deleteWorkloadIdentityPoolProviderRequestDescriptor instead')
const DeleteWorkloadIdentityPoolProviderRequest$json = {
  '1': 'DeleteWorkloadIdentityPoolProviderRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `DeleteWorkloadIdentityPoolProviderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List
    deleteWorkloadIdentityPoolProviderRequestDescriptor = $convert.base64Decode(
        'CilEZWxldGVXb3JrbG9hZElkZW50aXR5UG9vbFByb3ZpZGVyUmVxdWVzdBJLCgRuYW1lGAEgAS'
        'gJQjfgQQL6QTEKL2lhbS5nb29nbGVhcGlzLmNvbS9Xb3JrbG9hZElkZW50aXR5UG9vbFByb3Zp'
        'ZGVyUgRuYW1l');

@$core.Deprecated(
    'Use undeleteWorkloadIdentityPoolProviderRequestDescriptor instead')
const UndeleteWorkloadIdentityPoolProviderRequest$json = {
  '1': 'UndeleteWorkloadIdentityPoolProviderRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `UndeleteWorkloadIdentityPoolProviderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List
    undeleteWorkloadIdentityPoolProviderRequestDescriptor =
    $convert.base64Decode(
        'CitVbmRlbGV0ZVdvcmtsb2FkSWRlbnRpdHlQb29sUHJvdmlkZXJSZXF1ZXN0EksKBG5hbWUYAS'
        'ABKAlCN+BBAvpBMQovaWFtLmdvb2dsZWFwaXMuY29tL1dvcmtsb2FkSWRlbnRpdHlQb29sUHJv'
        'dmlkZXJSBG5hbWU=');

@$core.Deprecated('Use workloadIdentityPoolOperationMetadataDescriptor instead')
const WorkloadIdentityPoolOperationMetadata$json = {
  '1': 'WorkloadIdentityPoolOperationMetadata',
};

/// Descriptor for `WorkloadIdentityPoolOperationMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List workloadIdentityPoolOperationMetadataDescriptor =
    $convert
        .base64Decode('CiVXb3JrbG9hZElkZW50aXR5UG9vbE9wZXJhdGlvbk1ldGFkYXRh');

@$core.Deprecated(
    'Use workloadIdentityPoolProviderOperationMetadataDescriptor instead')
const WorkloadIdentityPoolProviderOperationMetadata$json = {
  '1': 'WorkloadIdentityPoolProviderOperationMetadata',
};

/// Descriptor for `WorkloadIdentityPoolProviderOperationMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List
    workloadIdentityPoolProviderOperationMetadataDescriptor =
    $convert.base64Decode(
        'Ci1Xb3JrbG9hZElkZW50aXR5UG9vbFByb3ZpZGVyT3BlcmF0aW9uTWV0YWRhdGE=');
