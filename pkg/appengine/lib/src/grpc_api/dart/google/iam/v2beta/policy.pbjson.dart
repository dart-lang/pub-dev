//
//  Generated code. Do not modify.
//  source: google/iam/v2beta/policy.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use policyDescriptor instead')
const Policy$json = {
  '1': 'Policy',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'uid', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'uid'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'kind'},
    {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    {
      '1': 'annotations',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.google.iam.v2beta.Policy.AnnotationsEntry',
      '10': 'annotations'
    },
    {'1': 'etag', '3': 6, '4': 1, '5': 9, '10': 'etag'},
    {
      '1': 'create_time',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'createTime'
    },
    {
      '1': 'update_time',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'updateTime'
    },
    {
      '1': 'delete_time',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'deleteTime'
    },
    {
      '1': 'rules',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.google.iam.v2beta.PolicyRule',
      '10': 'rules'
    },
  ],
  '3': [Policy_AnnotationsEntry$json],
};

@$core.Deprecated('Use policyDescriptor instead')
const Policy_AnnotationsEntry$json = {
  '1': 'AnnotationsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Policy`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List policyDescriptor = $convert.base64Decode(
    'CgZQb2xpY3kSFwoEbmFtZRgBIAEoCUID4EEFUgRuYW1lEhUKA3VpZBgCIAEoCUID4EEFUgN1aW'
    'QSFwoEa2luZBgDIAEoCUID4EEDUgRraW5kEiEKDGRpc3BsYXlfbmFtZRgEIAEoCVILZGlzcGxh'
    'eU5hbWUSTAoLYW5ub3RhdGlvbnMYBSADKAsyKi5nb29nbGUuaWFtLnYyYmV0YS5Qb2xpY3kuQW'
    '5ub3RhdGlvbnNFbnRyeVILYW5ub3RhdGlvbnMSEgoEZXRhZxgGIAEoCVIEZXRhZxJACgtjcmVh'
    'dGVfdGltZRgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCA+BBA1IKY3JlYXRlVG'
    'ltZRJACgt1cGRhdGVfdGltZRgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCA+BB'
    'A1IKdXBkYXRlVGltZRJACgtkZWxldGVfdGltZRgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW'
    '1lc3RhbXBCA+BBA1IKZGVsZXRlVGltZRIzCgVydWxlcxgKIAMoCzIdLmdvb2dsZS5pYW0udjJi'
    'ZXRhLlBvbGljeVJ1bGVSBXJ1bGVzGj4KEEFubm90YXRpb25zRW50cnkSEAoDa2V5GAEgASgJUg'
    'NrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use policyRuleDescriptor instead')
const PolicyRule$json = {
  '1': 'PolicyRule',
  '2': [
    {
      '1': 'deny_rule',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.iam.v2beta.DenyRule',
      '9': 0,
      '10': 'denyRule'
    },
    {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `PolicyRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List policyRuleDescriptor = $convert.base64Decode(
    'CgpQb2xpY3lSdWxlEjoKCWRlbnlfcnVsZRgCIAEoCzIbLmdvb2dsZS5pYW0udjJiZXRhLkRlbn'
    'lSdWxlSABSCGRlbnlSdWxlEiAKC2Rlc2NyaXB0aW9uGAEgASgJUgtkZXNjcmlwdGlvbkIGCgRr'
    'aW5k');

@$core.Deprecated('Use listPoliciesRequestDescriptor instead')
const ListPoliciesRequest$json = {
  '1': 'ListPoliciesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListPoliciesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPoliciesRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0UG9saWNpZXNSZXF1ZXN0EhsKBnBhcmVudBgBIAEoCUID4EECUgZwYXJlbnQSGwoJcG'
    'FnZV9zaXplGAIgASgFUghwYWdlU2l6ZRIdCgpwYWdlX3Rva2VuGAMgASgJUglwYWdlVG9rZW4=');

@$core.Deprecated('Use listPoliciesResponseDescriptor instead')
const ListPoliciesResponse$json = {
  '1': 'ListPoliciesResponse',
  '2': [
    {
      '1': 'policies',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.iam.v2beta.Policy',
      '10': 'policies'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListPoliciesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPoliciesResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0UG9saWNpZXNSZXNwb25zZRI1Cghwb2xpY2llcxgBIAMoCzIZLmdvb2dsZS5pYW0udj'
    'JiZXRhLlBvbGljeVIIcG9saWNpZXMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFn'
    'ZVRva2Vu');

@$core.Deprecated('Use getPolicyRequestDescriptor instead')
const GetPolicyRequest$json = {
  '1': 'GetPolicyRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetPolicyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPolicyRequestDescriptor = $convert.base64Decode(
    'ChBHZXRQb2xpY3lSZXF1ZXN0EhcKBG5hbWUYASABKAlCA+BBAlIEbmFtZQ==');

@$core.Deprecated('Use createPolicyRequestDescriptor instead')
const CreatePolicyRequest$json = {
  '1': 'CreatePolicyRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {
      '1': 'policy',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.iam.v2beta.Policy',
      '8': {},
      '10': 'policy'
    },
    {'1': 'policy_id', '3': 3, '4': 1, '5': 9, '10': 'policyId'},
  ],
};

/// Descriptor for `CreatePolicyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPolicyRequestDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVQb2xpY3lSZXF1ZXN0EhsKBnBhcmVudBgBIAEoCUID4EECUgZwYXJlbnQSNgoGcG'
    '9saWN5GAIgASgLMhkuZ29vZ2xlLmlhbS52MmJldGEuUG9saWN5QgPgQQJSBnBvbGljeRIbCglw'
    'b2xpY3lfaWQYAyABKAlSCHBvbGljeUlk');

@$core.Deprecated('Use updatePolicyRequestDescriptor instead')
const UpdatePolicyRequest$json = {
  '1': 'UpdatePolicyRequest',
  '2': [
    {
      '1': 'policy',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.iam.v2beta.Policy',
      '8': {},
      '10': 'policy'
    },
  ],
};

/// Descriptor for `UpdatePolicyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePolicyRequestDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVQb2xpY3lSZXF1ZXN0EjYKBnBvbGljeRgBIAEoCzIZLmdvb2dsZS5pYW0udjJiZX'
    'RhLlBvbGljeUID4EECUgZwb2xpY3k=');

@$core.Deprecated('Use deletePolicyRequestDescriptor instead')
const DeletePolicyRequest$json = {
  '1': 'DeletePolicyRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'etag'},
  ],
};

/// Descriptor for `DeletePolicyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletePolicyRequestDescriptor = $convert.base64Decode(
    'ChNEZWxldGVQb2xpY3lSZXF1ZXN0EhcKBG5hbWUYASABKAlCA+BBAlIEbmFtZRIXCgRldGFnGA'
    'IgASgJQgPgQQFSBGV0YWc=');

@$core.Deprecated('Use policyOperationMetadataDescriptor instead')
const PolicyOperationMetadata$json = {
  '1': 'PolicyOperationMetadata',
  '2': [
    {
      '1': 'create_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createTime'
    },
  ],
};

/// Descriptor for `PolicyOperationMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List policyOperationMetadataDescriptor =
    $convert.base64Decode(
        'ChdQb2xpY3lPcGVyYXRpb25NZXRhZGF0YRI7CgtjcmVhdGVfdGltZRgBIAEoCzIaLmdvb2dsZS'
        '5wcm90b2J1Zi5UaW1lc3RhbXBSCmNyZWF0ZVRpbWU=');
