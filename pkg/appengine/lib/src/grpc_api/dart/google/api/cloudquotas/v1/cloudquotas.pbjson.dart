//
//  Generated code. Do not modify.
//  source: google/api/cloudquotas/v1/cloudquotas.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use listQuotaInfosRequestDescriptor instead')
const ListQuotaInfosRequest$json = {
  '1': 'ListQuotaInfosRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '8': {}, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListQuotaInfosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listQuotaInfosRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0UXVvdGFJbmZvc1JlcXVlc3QSRAoGcGFyZW50GAEgASgJQizgQQL6QSYSJGNsb3VkcX'
    'VvdGFzLmdvb2dsZWFwaXMuY29tL1F1b3RhSW5mb1IGcGFyZW50EiAKCXBhZ2Vfc2l6ZRgCIAEo'
    'BUID4EEBUghwYWdlU2l6ZRIiCgpwYWdlX3Rva2VuGAMgASgJQgPgQQFSCXBhZ2VUb2tlbg==');

@$core.Deprecated('Use listQuotaInfosResponseDescriptor instead')
const ListQuotaInfosResponse$json = {
  '1': 'ListQuotaInfosResponse',
  '2': [
    {
      '1': 'quota_infos',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.cloudquotas.v1.QuotaInfo',
      '10': 'quotaInfos'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListQuotaInfosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listQuotaInfosResponseDescriptor = $convert.base64Decode(
    'ChZMaXN0UXVvdGFJbmZvc1Jlc3BvbnNlEkUKC3F1b3RhX2luZm9zGAEgAygLMiQuZ29vZ2xlLm'
    'FwaS5jbG91ZHF1b3Rhcy52MS5RdW90YUluZm9SCnF1b3RhSW5mb3MSJgoPbmV4dF9wYWdlX3Rv'
    'a2VuGAIgASgJUg1uZXh0UGFnZVRva2Vu');

@$core.Deprecated('Use getQuotaInfoRequestDescriptor instead')
const GetQuotaInfoRequest$json = {
  '1': 'GetQuotaInfoRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetQuotaInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQuotaInfoRequestDescriptor = $convert.base64Decode(
    'ChNHZXRRdW90YUluZm9SZXF1ZXN0EkAKBG5hbWUYASABKAlCLOBBAvpBJgokY2xvdWRxdW90YX'
    'MuZ29vZ2xlYXBpcy5jb20vUXVvdGFJbmZvUgRuYW1l');

@$core.Deprecated('Use listQuotaPreferencesRequestDescriptor instead')
const ListQuotaPreferencesRequest$json = {
  '1': 'ListQuotaPreferencesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '8': {}, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'pageToken'},
    {'1': 'filter', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'filter'},
    {'1': 'order_by', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'orderBy'},
  ],
};

/// Descriptor for `ListQuotaPreferencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listQuotaPreferencesRequestDescriptor = $convert.base64Decode(
    'ChtMaXN0UXVvdGFQcmVmZXJlbmNlc1JlcXVlc3QSSgoGcGFyZW50GAEgASgJQjLgQQL6QSwSKm'
    'Nsb3VkcXVvdGFzLmdvb2dsZWFwaXMuY29tL1F1b3RhUHJlZmVyZW5jZVIGcGFyZW50EiAKCXBh'
    'Z2Vfc2l6ZRgCIAEoBUID4EEBUghwYWdlU2l6ZRIiCgpwYWdlX3Rva2VuGAMgASgJQgPgQQFSCX'
    'BhZ2VUb2tlbhIbCgZmaWx0ZXIYBCABKAlCA+BBAVIGZmlsdGVyEh4KCG9yZGVyX2J5GAUgASgJ'
    'QgPgQQFSB29yZGVyQnk=');

@$core.Deprecated('Use listQuotaPreferencesResponseDescriptor instead')
const ListQuotaPreferencesResponse$json = {
  '1': 'ListQuotaPreferencesResponse',
  '2': [
    {
      '1': 'quota_preferences',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.cloudquotas.v1.QuotaPreference',
      '10': 'quotaPreferences'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
    {'1': 'unreachable', '3': 3, '4': 3, '5': 9, '10': 'unreachable'},
  ],
};

/// Descriptor for `ListQuotaPreferencesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listQuotaPreferencesResponseDescriptor = $convert.base64Decode(
    'ChxMaXN0UXVvdGFQcmVmZXJlbmNlc1Jlc3BvbnNlElcKEXF1b3RhX3ByZWZlcmVuY2VzGAEgAy'
    'gLMiouZ29vZ2xlLmFwaS5jbG91ZHF1b3Rhcy52MS5RdW90YVByZWZlcmVuY2VSEHF1b3RhUHJl'
    'ZmVyZW5jZXMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2VuEiAKC3Vucm'
    'VhY2hhYmxlGAMgAygJUgt1bnJlYWNoYWJsZQ==');

@$core.Deprecated('Use getQuotaPreferenceRequestDescriptor instead')
const GetQuotaPreferenceRequest$json = {
  '1': 'GetQuotaPreferenceRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetQuotaPreferenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQuotaPreferenceRequestDescriptor =
    $convert.base64Decode(
        'ChlHZXRRdW90YVByZWZlcmVuY2VSZXF1ZXN0EkYKBG5hbWUYASABKAlCMuBBAvpBLAoqY2xvdW'
        'RxdW90YXMuZ29vZ2xlYXBpcy5jb20vUXVvdGFQcmVmZXJlbmNlUgRuYW1l');

@$core.Deprecated('Use createQuotaPreferenceRequestDescriptor instead')
const CreateQuotaPreferenceRequest$json = {
  '1': 'CreateQuotaPreferenceRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {
      '1': 'quota_preference_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'quotaPreferenceId'
    },
    {
      '1': 'quota_preference',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.api.cloudquotas.v1.QuotaPreference',
      '8': {},
      '10': 'quotaPreference'
    },
    {
      '1': 'ignore_safety_checks',
      '3': 4,
      '4': 3,
      '5': 14,
      '6': '.google.api.cloudquotas.v1.QuotaSafetyCheck',
      '10': 'ignoreSafetyChecks'
    },
  ],
};

/// Descriptor for `CreateQuotaPreferenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createQuotaPreferenceRequestDescriptor = $convert.base64Decode(
    'ChxDcmVhdGVRdW90YVByZWZlcmVuY2VSZXF1ZXN0EkoKBnBhcmVudBgBIAEoCUIy4EEC+kEsEi'
    'pjbG91ZHF1b3Rhcy5nb29nbGVhcGlzLmNvbS9RdW90YVByZWZlcmVuY2VSBnBhcmVudBIzChNx'
    'dW90YV9wcmVmZXJlbmNlX2lkGAIgASgJQgPgQQFSEXF1b3RhUHJlZmVyZW5jZUlkEloKEHF1b3'
    'RhX3ByZWZlcmVuY2UYAyABKAsyKi5nb29nbGUuYXBpLmNsb3VkcXVvdGFzLnYxLlF1b3RhUHJl'
    'ZmVyZW5jZUID4EECUg9xdW90YVByZWZlcmVuY2USXQoUaWdub3JlX3NhZmV0eV9jaGVja3MYBC'
    'ADKA4yKy5nb29nbGUuYXBpLmNsb3VkcXVvdGFzLnYxLlF1b3RhU2FmZXR5Q2hlY2tSEmlnbm9y'
    'ZVNhZmV0eUNoZWNrcw==');

@$core.Deprecated('Use updateQuotaPreferenceRequestDescriptor instead')
const UpdateQuotaPreferenceRequest$json = {
  '1': 'UpdateQuotaPreferenceRequest',
  '2': [
    {
      '1': 'update_mask',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '8': {},
      '10': 'updateMask'
    },
    {
      '1': 'quota_preference',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.cloudquotas.v1.QuotaPreference',
      '8': {},
      '10': 'quotaPreference'
    },
    {
      '1': 'allow_missing',
      '3': 3,
      '4': 1,
      '5': 8,
      '8': {},
      '10': 'allowMissing'
    },
    {
      '1': 'validate_only',
      '3': 4,
      '4': 1,
      '5': 8,
      '8': {},
      '10': 'validateOnly'
    },
    {
      '1': 'ignore_safety_checks',
      '3': 5,
      '4': 3,
      '5': 14,
      '6': '.google.api.cloudquotas.v1.QuotaSafetyCheck',
      '10': 'ignoreSafetyChecks'
    },
  ],
};

/// Descriptor for `UpdateQuotaPreferenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateQuotaPreferenceRequestDescriptor = $convert.base64Decode(
    'ChxVcGRhdGVRdW90YVByZWZlcmVuY2VSZXF1ZXN0EkAKC3VwZGF0ZV9tYXNrGAEgASgLMhouZ2'
    '9vZ2xlLnByb3RvYnVmLkZpZWxkTWFza0ID4EEBUgp1cGRhdGVNYXNrEloKEHF1b3RhX3ByZWZl'
    'cmVuY2UYAiABKAsyKi5nb29nbGUuYXBpLmNsb3VkcXVvdGFzLnYxLlF1b3RhUHJlZmVyZW5jZU'
    'ID4EECUg9xdW90YVByZWZlcmVuY2USKAoNYWxsb3dfbWlzc2luZxgDIAEoCEID4EEBUgxhbGxv'
    'd01pc3NpbmcSKAoNdmFsaWRhdGVfb25seRgEIAEoCEID4EEBUgx2YWxpZGF0ZU9ubHkSXQoUaW'
    'dub3JlX3NhZmV0eV9jaGVja3MYBSADKA4yKy5nb29nbGUuYXBpLmNsb3VkcXVvdGFzLnYxLlF1'
    'b3RhU2FmZXR5Q2hlY2tSEmlnbm9yZVNhZmV0eUNoZWNrcw==');
