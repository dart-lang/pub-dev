//
//  Generated code. Do not modify.
//  source: google/iam/admin/v1/iam.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use serviceAccountKeyAlgorithmDescriptor instead')
const ServiceAccountKeyAlgorithm$json = {
  '1': 'ServiceAccountKeyAlgorithm',
  '2': [
    {'1': 'KEY_ALG_UNSPECIFIED', '2': 0},
    {'1': 'KEY_ALG_RSA_1024', '2': 1},
    {'1': 'KEY_ALG_RSA_2048', '2': 2},
  ],
};

/// Descriptor for `ServiceAccountKeyAlgorithm`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List serviceAccountKeyAlgorithmDescriptor =
    $convert.base64Decode(
        'ChpTZXJ2aWNlQWNjb3VudEtleUFsZ29yaXRobRIXChNLRVlfQUxHX1VOU1BFQ0lGSUVEEAASFA'
        'oQS0VZX0FMR19SU0FfMTAyNBABEhQKEEtFWV9BTEdfUlNBXzIwNDgQAg==');

@$core.Deprecated('Use serviceAccountPrivateKeyTypeDescriptor instead')
const ServiceAccountPrivateKeyType$json = {
  '1': 'ServiceAccountPrivateKeyType',
  '2': [
    {'1': 'TYPE_UNSPECIFIED', '2': 0},
    {'1': 'TYPE_PKCS12_FILE', '2': 1},
    {'1': 'TYPE_GOOGLE_CREDENTIALS_FILE', '2': 2},
  ],
};

/// Descriptor for `ServiceAccountPrivateKeyType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List serviceAccountPrivateKeyTypeDescriptor =
    $convert.base64Decode(
        'ChxTZXJ2aWNlQWNjb3VudFByaXZhdGVLZXlUeXBlEhQKEFRZUEVfVU5TUEVDSUZJRUQQABIUCh'
        'BUWVBFX1BLQ1MxMl9GSUxFEAESIAocVFlQRV9HT09HTEVfQ1JFREVOVElBTFNfRklMRRAC');

@$core.Deprecated('Use serviceAccountPublicKeyTypeDescriptor instead')
const ServiceAccountPublicKeyType$json = {
  '1': 'ServiceAccountPublicKeyType',
  '2': [
    {'1': 'TYPE_NONE', '2': 0},
    {'1': 'TYPE_X509_PEM_FILE', '2': 1},
    {'1': 'TYPE_RAW_PUBLIC_KEY', '2': 2},
  ],
};

/// Descriptor for `ServiceAccountPublicKeyType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List serviceAccountPublicKeyTypeDescriptor =
    $convert.base64Decode(
        'ChtTZXJ2aWNlQWNjb3VudFB1YmxpY0tleVR5cGUSDQoJVFlQRV9OT05FEAASFgoSVFlQRV9YNT'
        'A5X1BFTV9GSUxFEAESFwoTVFlQRV9SQVdfUFVCTElDX0tFWRAC');

@$core.Deprecated('Use serviceAccountKeyOriginDescriptor instead')
const ServiceAccountKeyOrigin$json = {
  '1': 'ServiceAccountKeyOrigin',
  '2': [
    {'1': 'ORIGIN_UNSPECIFIED', '2': 0},
    {'1': 'USER_PROVIDED', '2': 1},
    {'1': 'GOOGLE_PROVIDED', '2': 2},
  ],
};

/// Descriptor for `ServiceAccountKeyOrigin`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List serviceAccountKeyOriginDescriptor =
    $convert.base64Decode(
        'ChdTZXJ2aWNlQWNjb3VudEtleU9yaWdpbhIWChJPUklHSU5fVU5TUEVDSUZJRUQQABIRCg1VU0'
        'VSX1BST1ZJREVEEAESEwoPR09PR0xFX1BST1ZJREVEEAI=');

@$core.Deprecated('Use roleViewDescriptor instead')
const RoleView$json = {
  '1': 'RoleView',
  '2': [
    {'1': 'BASIC', '2': 0},
    {'1': 'FULL', '2': 1},
  ],
};

/// Descriptor for `RoleView`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roleViewDescriptor =
    $convert.base64Decode('CghSb2xlVmlldxIJCgVCQVNJQxAAEggKBEZVTEwQAQ==');

@$core.Deprecated('Use serviceAccountDescriptor instead')
const ServiceAccount$json = {
  '1': 'ServiceAccount',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'project_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'projectId'},
    {'1': 'unique_id', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'uniqueId'},
    {'1': 'email', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'email'},
    {'1': 'display_name', '3': 6, '4': 1, '5': 9, '8': {}, '10': 'displayName'},
    {
      '1': 'etag',
      '3': 7,
      '4': 1,
      '5': 12,
      '8': {'3': true},
      '10': 'etag',
    },
    {'1': 'description', '3': 8, '4': 1, '5': 9, '8': {}, '10': 'description'},
    {
      '1': 'oauth2_client_id',
      '3': 9,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'oauth2ClientId'
    },
    {'1': 'disabled', '3': 11, '4': 1, '5': 8, '8': {}, '10': 'disabled'},
  ],
  '7': {},
};

/// Descriptor for `ServiceAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceAccountDescriptor = $convert.base64Decode(
    'Cg5TZXJ2aWNlQWNjb3VudBISCgRuYW1lGAEgASgJUgRuYW1lEiIKCnByb2plY3RfaWQYAiABKA'
    'lCA+BBA1IJcHJvamVjdElkEiAKCXVuaXF1ZV9pZBgEIAEoCUID4EEDUgh1bmlxdWVJZBIZCgVl'
    'bWFpbBgFIAEoCUID4EEDUgVlbWFpbBImCgxkaXNwbGF5X25hbWUYBiABKAlCA+BBAVILZGlzcG'
    'xheU5hbWUSFgoEZXRhZxgHIAEoDEICGAFSBGV0YWcSJQoLZGVzY3JpcHRpb24YCCABKAlCA+BB'
    'AVILZGVzY3JpcHRpb24SLQoQb2F1dGgyX2NsaWVudF9pZBgJIAEoCUID4EEDUg5vYXV0aDJDbG'
    'llbnRJZBIfCghkaXNhYmxlZBgLIAEoCEID4EEDUghkaXNhYmxlZDpc6kFZCiFpYW0uZ29vZ2xl'
    'YXBpcy5jb20vU2VydmljZUFjY291bnQSNHByb2plY3RzL3twcm9qZWN0fS9zZXJ2aWNlQWNjb3'
    'VudHMve3NlcnZpY2VfYWNjb3VudH0=');

@$core.Deprecated('Use createServiceAccountRequestDescriptor instead')
const CreateServiceAccountRequest$json = {
  '1': 'CreateServiceAccountRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'accountId'},
    {
      '1': 'service_account',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.iam.admin.v1.ServiceAccount',
      '10': 'serviceAccount'
    },
  ],
};

/// Descriptor for `CreateServiceAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createServiceAccountRequestDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVTZXJ2aWNlQWNjb3VudFJlcXVlc3QSRwoEbmFtZRgBIAEoCUIz4EEC+kEtCitjbG'
    '91ZHJlc291cmNlbWFuYWdlci5nb29nbGVhcGlzLmNvbS9Qcm9qZWN0UgRuYW1lEiIKCmFjY291'
    'bnRfaWQYAiABKAlCA+BBAlIJYWNjb3VudElkEkwKD3NlcnZpY2VfYWNjb3VudBgDIAEoCzIjLm'
    'dvb2dsZS5pYW0uYWRtaW4udjEuU2VydmljZUFjY291bnRSDnNlcnZpY2VBY2NvdW50');

@$core.Deprecated('Use listServiceAccountsRequestDescriptor instead')
const ListServiceAccountsRequest$json = {
  '1': 'ListServiceAccountsRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListServiceAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listServiceAccountsRequestDescriptor =
    $convert.base64Decode(
        'ChpMaXN0U2VydmljZUFjY291bnRzUmVxdWVzdBJHCgRuYW1lGAEgASgJQjPgQQL6QS0KK2Nsb3'
        'VkcmVzb3VyY2VtYW5hZ2VyLmdvb2dsZWFwaXMuY29tL1Byb2plY3RSBG5hbWUSGwoJcGFnZV9z'
        'aXplGAIgASgFUghwYWdlU2l6ZRIdCgpwYWdlX3Rva2VuGAMgASgJUglwYWdlVG9rZW4=');

@$core.Deprecated('Use listServiceAccountsResponseDescriptor instead')
const ListServiceAccountsResponse$json = {
  '1': 'ListServiceAccountsResponse',
  '2': [
    {
      '1': 'accounts',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.iam.admin.v1.ServiceAccount',
      '10': 'accounts'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListServiceAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listServiceAccountsResponseDescriptor =
    $convert.base64Decode(
        'ChtMaXN0U2VydmljZUFjY291bnRzUmVzcG9uc2USPwoIYWNjb3VudHMYASADKAsyIy5nb29nbG'
        'UuaWFtLmFkbWluLnYxLlNlcnZpY2VBY2NvdW50UghhY2NvdW50cxImCg9uZXh0X3BhZ2VfdG9r'
        'ZW4YAiABKAlSDW5leHRQYWdlVG9rZW4=');

@$core.Deprecated('Use getServiceAccountRequestDescriptor instead')
const GetServiceAccountRequest$json = {
  '1': 'GetServiceAccountRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetServiceAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getServiceAccountRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRTZXJ2aWNlQWNjb3VudFJlcXVlc3QSPQoEbmFtZRgBIAEoCUIp4EEC+kEjCiFpYW0uZ2'
        '9vZ2xlYXBpcy5jb20vU2VydmljZUFjY291bnRSBG5hbWU=');

@$core.Deprecated('Use deleteServiceAccountRequestDescriptor instead')
const DeleteServiceAccountRequest$json = {
  '1': 'DeleteServiceAccountRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `DeleteServiceAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteServiceAccountRequestDescriptor =
    $convert.base64Decode(
        'ChtEZWxldGVTZXJ2aWNlQWNjb3VudFJlcXVlc3QSPQoEbmFtZRgBIAEoCUIp4EEC+kEjCiFpYW'
        '0uZ29vZ2xlYXBpcy5jb20vU2VydmljZUFjY291bnRSBG5hbWU=');

@$core.Deprecated('Use patchServiceAccountRequestDescriptor instead')
const PatchServiceAccountRequest$json = {
  '1': 'PatchServiceAccountRequest',
  '2': [
    {
      '1': 'service_account',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.iam.admin.v1.ServiceAccount',
      '10': 'serviceAccount'
    },
    {
      '1': 'update_mask',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `PatchServiceAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List patchServiceAccountRequestDescriptor = $convert.base64Decode(
    'ChpQYXRjaFNlcnZpY2VBY2NvdW50UmVxdWVzdBJMCg9zZXJ2aWNlX2FjY291bnQYASABKAsyIy'
    '5nb29nbGUuaWFtLmFkbWluLnYxLlNlcnZpY2VBY2NvdW50Ug5zZXJ2aWNlQWNjb3VudBI7Cgt1'
    'cGRhdGVfbWFzaxgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5GaWVsZE1hc2tSCnVwZGF0ZU1hc2'
    's=');

@$core.Deprecated('Use undeleteServiceAccountRequestDescriptor instead')
const UndeleteServiceAccountRequest$json = {
  '1': 'UndeleteServiceAccountRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `UndeleteServiceAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List undeleteServiceAccountRequestDescriptor =
    $convert.base64Decode(
        'Ch1VbmRlbGV0ZVNlcnZpY2VBY2NvdW50UmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use undeleteServiceAccountResponseDescriptor instead')
const UndeleteServiceAccountResponse$json = {
  '1': 'UndeleteServiceAccountResponse',
  '2': [
    {
      '1': 'restored_account',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.iam.admin.v1.ServiceAccount',
      '10': 'restoredAccount'
    },
  ],
};

/// Descriptor for `UndeleteServiceAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List undeleteServiceAccountResponseDescriptor =
    $convert.base64Decode(
        'Ch5VbmRlbGV0ZVNlcnZpY2VBY2NvdW50UmVzcG9uc2USTgoQcmVzdG9yZWRfYWNjb3VudBgBIA'
        'EoCzIjLmdvb2dsZS5pYW0uYWRtaW4udjEuU2VydmljZUFjY291bnRSD3Jlc3RvcmVkQWNjb3Vu'
        'dA==');

@$core.Deprecated('Use enableServiceAccountRequestDescriptor instead')
const EnableServiceAccountRequest$json = {
  '1': 'EnableServiceAccountRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `EnableServiceAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableServiceAccountRequestDescriptor =
    $convert.base64Decode(
        'ChtFbmFibGVTZXJ2aWNlQWNjb3VudFJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use disableServiceAccountRequestDescriptor instead')
const DisableServiceAccountRequest$json = {
  '1': 'DisableServiceAccountRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DisableServiceAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableServiceAccountRequestDescriptor =
    $convert.base64Decode(
        'ChxEaXNhYmxlU2VydmljZUFjY291bnRSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWU=');

@$core.Deprecated('Use listServiceAccountKeysRequestDescriptor instead')
const ListServiceAccountKeysRequest$json = {
  '1': 'ListServiceAccountKeysRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {
      '1': 'key_types',
      '3': 2,
      '4': 3,
      '5': 14,
      '6': '.google.iam.admin.v1.ListServiceAccountKeysRequest.KeyType',
      '10': 'keyTypes'
    },
  ],
  '4': [ListServiceAccountKeysRequest_KeyType$json],
};

@$core.Deprecated('Use listServiceAccountKeysRequestDescriptor instead')
const ListServiceAccountKeysRequest_KeyType$json = {
  '1': 'KeyType',
  '2': [
    {'1': 'KEY_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'USER_MANAGED', '2': 1},
    {'1': 'SYSTEM_MANAGED', '2': 2},
  ],
};

/// Descriptor for `ListServiceAccountKeysRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listServiceAccountKeysRequestDescriptor = $convert.base64Decode(
    'Ch1MaXN0U2VydmljZUFjY291bnRLZXlzUmVxdWVzdBI9CgRuYW1lGAEgASgJQingQQL6QSMKIW'
    'lhbS5nb29nbGVhcGlzLmNvbS9TZXJ2aWNlQWNjb3VudFIEbmFtZRJXCglrZXlfdHlwZXMYAiAD'
    'KA4yOi5nb29nbGUuaWFtLmFkbWluLnYxLkxpc3RTZXJ2aWNlQWNjb3VudEtleXNSZXF1ZXN0Lk'
    'tleVR5cGVSCGtleVR5cGVzIkkKB0tleVR5cGUSGAoUS0VZX1RZUEVfVU5TUEVDSUZJRUQQABIQ'
    'CgxVU0VSX01BTkFHRUQQARISCg5TWVNURU1fTUFOQUdFRBAC');

@$core.Deprecated('Use listServiceAccountKeysResponseDescriptor instead')
const ListServiceAccountKeysResponse$json = {
  '1': 'ListServiceAccountKeysResponse',
  '2': [
    {
      '1': 'keys',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.iam.admin.v1.ServiceAccountKey',
      '10': 'keys'
    },
  ],
};

/// Descriptor for `ListServiceAccountKeysResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listServiceAccountKeysResponseDescriptor =
    $convert.base64Decode(
        'Ch5MaXN0U2VydmljZUFjY291bnRLZXlzUmVzcG9uc2USOgoEa2V5cxgBIAMoCzImLmdvb2dsZS'
        '5pYW0uYWRtaW4udjEuU2VydmljZUFjY291bnRLZXlSBGtleXM=');

@$core.Deprecated('Use getServiceAccountKeyRequestDescriptor instead')
const GetServiceAccountKeyRequest$json = {
  '1': 'GetServiceAccountKeyRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {
      '1': 'public_key_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.ServiceAccountPublicKeyType',
      '8': {},
      '10': 'publicKeyType'
    },
  ],
};

/// Descriptor for `GetServiceAccountKeyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getServiceAccountKeyRequestDescriptor = $convert.base64Decode(
    'ChtHZXRTZXJ2aWNlQWNjb3VudEtleVJlcXVlc3QSMgoEbmFtZRgBIAEoCUIe4EEC+kEYChZpYW'
    '0uZ29vZ2xlYXBpcy5jb20vS2V5UgRuYW1lEl0KD3B1YmxpY19rZXlfdHlwZRgCIAEoDjIwLmdv'
    'b2dsZS5pYW0uYWRtaW4udjEuU2VydmljZUFjY291bnRQdWJsaWNLZXlUeXBlQgPgQQFSDXB1Ym'
    'xpY0tleVR5cGU=');

@$core.Deprecated('Use serviceAccountKeyDescriptor instead')
const ServiceAccountKey$json = {
  '1': 'ServiceAccountKey',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'private_key_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.ServiceAccountPrivateKeyType',
      '10': 'privateKeyType'
    },
    {
      '1': 'key_algorithm',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.ServiceAccountKeyAlgorithm',
      '10': 'keyAlgorithm'
    },
    {'1': 'private_key_data', '3': 3, '4': 1, '5': 12, '10': 'privateKeyData'},
    {'1': 'public_key_data', '3': 7, '4': 1, '5': 12, '10': 'publicKeyData'},
    {
      '1': 'valid_after_time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'validAfterTime'
    },
    {
      '1': 'valid_before_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'validBeforeTime'
    },
    {
      '1': 'key_origin',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.ServiceAccountKeyOrigin',
      '10': 'keyOrigin'
    },
    {
      '1': 'key_type',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.ListServiceAccountKeysRequest.KeyType',
      '10': 'keyType'
    },
    {'1': 'disabled', '3': 11, '4': 1, '5': 8, '10': 'disabled'},
  ],
  '7': {},
};

/// Descriptor for `ServiceAccountKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceAccountKeyDescriptor = $convert.base64Decode(
    'ChFTZXJ2aWNlQWNjb3VudEtleRISCgRuYW1lGAEgASgJUgRuYW1lElsKEHByaXZhdGVfa2V5X3'
    'R5cGUYAiABKA4yMS5nb29nbGUuaWFtLmFkbWluLnYxLlNlcnZpY2VBY2NvdW50UHJpdmF0ZUtl'
    'eVR5cGVSDnByaXZhdGVLZXlUeXBlElQKDWtleV9hbGdvcml0aG0YCCABKA4yLy5nb29nbGUuaW'
    'FtLmFkbWluLnYxLlNlcnZpY2VBY2NvdW50S2V5QWxnb3JpdGhtUgxrZXlBbGdvcml0aG0SKAoQ'
    'cHJpdmF0ZV9rZXlfZGF0YRgDIAEoDFIOcHJpdmF0ZUtleURhdGESJgoPcHVibGljX2tleV9kYX'
    'RhGAcgASgMUg1wdWJsaWNLZXlEYXRhEkQKEHZhbGlkX2FmdGVyX3RpbWUYBCABKAsyGi5nb29n'
    'bGUucHJvdG9idWYuVGltZXN0YW1wUg52YWxpZEFmdGVyVGltZRJGChF2YWxpZF9iZWZvcmVfdG'
    'ltZRgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSD3ZhbGlkQmVmb3JlVGltZRJL'
    'CgprZXlfb3JpZ2luGAkgASgOMiwuZ29vZ2xlLmlhbS5hZG1pbi52MS5TZXJ2aWNlQWNjb3VudE'
    'tleU9yaWdpblIJa2V5T3JpZ2luElUKCGtleV90eXBlGAogASgOMjouZ29vZ2xlLmlhbS5hZG1p'
    'bi52MS5MaXN0U2VydmljZUFjY291bnRLZXlzUmVxdWVzdC5LZXlUeXBlUgdrZXlUeXBlEhoKCG'
    'Rpc2FibGVkGAsgASgIUghkaXNhYmxlZDpc6kFZChZpYW0uZ29vZ2xlYXBpcy5jb20vS2V5Ej9w'
    'cm9qZWN0cy97cHJvamVjdH0vc2VydmljZUFjY291bnRzL3tzZXJ2aWNlX2FjY291bnR9L2tleX'
    'Mve2tleX0=');

@$core.Deprecated('Use createServiceAccountKeyRequestDescriptor instead')
const CreateServiceAccountKeyRequest$json = {
  '1': 'CreateServiceAccountKeyRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {
      '1': 'private_key_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.ServiceAccountPrivateKeyType',
      '10': 'privateKeyType'
    },
    {
      '1': 'key_algorithm',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.ServiceAccountKeyAlgorithm',
      '10': 'keyAlgorithm'
    },
  ],
};

/// Descriptor for `CreateServiceAccountKeyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createServiceAccountKeyRequestDescriptor = $convert.base64Decode(
    'Ch5DcmVhdGVTZXJ2aWNlQWNjb3VudEtleVJlcXVlc3QSPQoEbmFtZRgBIAEoCUIp4EEC+kEjCi'
    'FpYW0uZ29vZ2xlYXBpcy5jb20vU2VydmljZUFjY291bnRSBG5hbWUSWwoQcHJpdmF0ZV9rZXlf'
    'dHlwZRgCIAEoDjIxLmdvb2dsZS5pYW0uYWRtaW4udjEuU2VydmljZUFjY291bnRQcml2YXRlS2'
    'V5VHlwZVIOcHJpdmF0ZUtleVR5cGUSVAoNa2V5X2FsZ29yaXRobRgDIAEoDjIvLmdvb2dsZS5p'
    'YW0uYWRtaW4udjEuU2VydmljZUFjY291bnRLZXlBbGdvcml0aG1SDGtleUFsZ29yaXRobQ==');

@$core.Deprecated('Use uploadServiceAccountKeyRequestDescriptor instead')
const UploadServiceAccountKeyRequest$json = {
  '1': 'UploadServiceAccountKeyRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'public_key_data', '3': 2, '4': 1, '5': 12, '10': 'publicKeyData'},
  ],
};

/// Descriptor for `UploadServiceAccountKeyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadServiceAccountKeyRequestDescriptor =
    $convert.base64Decode(
        'Ch5VcGxvYWRTZXJ2aWNlQWNjb3VudEtleVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRImCg'
        '9wdWJsaWNfa2V5X2RhdGEYAiABKAxSDXB1YmxpY0tleURhdGE=');

@$core.Deprecated('Use deleteServiceAccountKeyRequestDescriptor instead')
const DeleteServiceAccountKeyRequest$json = {
  '1': 'DeleteServiceAccountKeyRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `DeleteServiceAccountKeyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteServiceAccountKeyRequestDescriptor =
    $convert.base64Decode(
        'Ch5EZWxldGVTZXJ2aWNlQWNjb3VudEtleVJlcXVlc3QSMgoEbmFtZRgBIAEoCUIe4EEC+kEYCh'
        'ZpYW0uZ29vZ2xlYXBpcy5jb20vS2V5UgRuYW1l');

@$core.Deprecated('Use disableServiceAccountKeyRequestDescriptor instead')
const DisableServiceAccountKeyRequest$json = {
  '1': 'DisableServiceAccountKeyRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `DisableServiceAccountKeyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableServiceAccountKeyRequestDescriptor =
    $convert.base64Decode(
        'Ch9EaXNhYmxlU2VydmljZUFjY291bnRLZXlSZXF1ZXN0EjIKBG5hbWUYASABKAlCHuBBAvpBGA'
        'oWaWFtLmdvb2dsZWFwaXMuY29tL0tleVIEbmFtZQ==');

@$core.Deprecated('Use enableServiceAccountKeyRequestDescriptor instead')
const EnableServiceAccountKeyRequest$json = {
  '1': 'EnableServiceAccountKeyRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `EnableServiceAccountKeyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableServiceAccountKeyRequestDescriptor =
    $convert.base64Decode(
        'Ch5FbmFibGVTZXJ2aWNlQWNjb3VudEtleVJlcXVlc3QSMgoEbmFtZRgBIAEoCUIe4EEC+kEYCh'
        'ZpYW0uZ29vZ2xlYXBpcy5jb20vS2V5UgRuYW1l');

@$core.Deprecated('Use signBlobRequestDescriptor instead')
const SignBlobRequest$json = {
  '1': 'SignBlobRequest',
  '2': [
    {
      '1': 'name',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'name',
    },
    {
      '1': 'bytes_to_sign',
      '3': 2,
      '4': 1,
      '5': 12,
      '8': {'3': true},
      '10': 'bytesToSign',
    },
  ],
};

/// Descriptor for `SignBlobRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signBlobRequestDescriptor = $convert.base64Decode(
    'Cg9TaWduQmxvYlJlcXVlc3QSPwoEbmFtZRgBIAEoCUIrGAHgQQL6QSMKIWlhbS5nb29nbGVhcG'
    'lzLmNvbS9TZXJ2aWNlQWNjb3VudFIEbmFtZRIpCg1ieXRlc190b19zaWduGAIgASgMQgUYAeBB'
    'AlILYnl0ZXNUb1NpZ24=');

@$core.Deprecated('Use signBlobResponseDescriptor instead')
const SignBlobResponse$json = {
  '1': 'SignBlobResponse',
  '2': [
    {
      '1': 'key_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'keyId',
    },
    {
      '1': 'signature',
      '3': 2,
      '4': 1,
      '5': 12,
      '8': {'3': true},
      '10': 'signature',
    },
  ],
};

/// Descriptor for `SignBlobResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signBlobResponseDescriptor = $convert.base64Decode(
    'ChBTaWduQmxvYlJlc3BvbnNlEhkKBmtleV9pZBgBIAEoCUICGAFSBWtleUlkEiAKCXNpZ25hdH'
    'VyZRgCIAEoDEICGAFSCXNpZ25hdHVyZQ==');

@$core.Deprecated('Use signJwtRequestDescriptor instead')
const SignJwtRequest$json = {
  '1': 'SignJwtRequest',
  '2': [
    {
      '1': 'name',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'name',
    },
    {
      '1': 'payload',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'payload',
    },
  ],
};

/// Descriptor for `SignJwtRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signJwtRequestDescriptor = $convert.base64Decode(
    'Cg5TaWduSnd0UmVxdWVzdBI/CgRuYW1lGAEgASgJQisYAeBBAvpBIwohaWFtLmdvb2dsZWFwaX'
    'MuY29tL1NlcnZpY2VBY2NvdW50UgRuYW1lEh8KB3BheWxvYWQYAiABKAlCBRgB4EECUgdwYXls'
    'b2Fk');

@$core.Deprecated('Use signJwtResponseDescriptor instead')
const SignJwtResponse$json = {
  '1': 'SignJwtResponse',
  '2': [
    {
      '1': 'key_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'keyId',
    },
    {
      '1': 'signed_jwt',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'signedJwt',
    },
  ],
};

/// Descriptor for `SignJwtResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signJwtResponseDescriptor = $convert.base64Decode(
    'Cg9TaWduSnd0UmVzcG9uc2USGQoGa2V5X2lkGAEgASgJQgIYAVIFa2V5SWQSIQoKc2lnbmVkX2'
    'p3dBgCIAEoCUICGAFSCXNpZ25lZEp3dA==');

@$core.Deprecated('Use roleDescriptor instead')
const Role$json = {
  '1': 'Role',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'included_permissions',
      '3': 7,
      '4': 3,
      '5': 9,
      '10': 'includedPermissions'
    },
    {
      '1': 'stage',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.Role.RoleLaunchStage',
      '10': 'stage'
    },
    {'1': 'etag', '3': 9, '4': 1, '5': 12, '10': 'etag'},
    {'1': 'deleted', '3': 11, '4': 1, '5': 8, '10': 'deleted'},
  ],
  '4': [Role_RoleLaunchStage$json],
};

@$core.Deprecated('Use roleDescriptor instead')
const Role_RoleLaunchStage$json = {
  '1': 'RoleLaunchStage',
  '2': [
    {'1': 'ALPHA', '2': 0},
    {'1': 'BETA', '2': 1},
    {'1': 'GA', '2': 2},
    {'1': 'DEPRECATED', '2': 4},
    {'1': 'DISABLED', '2': 5},
    {'1': 'EAP', '2': 6},
  ],
};

/// Descriptor for `Role`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roleDescriptor = $convert.base64Decode(
    'CgRSb2xlEhIKBG5hbWUYASABKAlSBG5hbWUSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2'
    'NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIxChRpbmNsdWRlZF9wZXJtaXNzaW9ucxgHIAMo'
    'CVITaW5jbHVkZWRQZXJtaXNzaW9ucxI/CgVzdGFnZRgIIAEoDjIpLmdvb2dsZS5pYW0uYWRtaW'
    '4udjEuUm9sZS5Sb2xlTGF1bmNoU3RhZ2VSBXN0YWdlEhIKBGV0YWcYCSABKAxSBGV0YWcSGAoH'
    'ZGVsZXRlZBgLIAEoCFIHZGVsZXRlZCJVCg9Sb2xlTGF1bmNoU3RhZ2USCQoFQUxQSEEQABIICg'
    'RCRVRBEAESBgoCR0EQAhIOCgpERVBSRUNBVEVEEAQSDAoIRElTQUJMRUQQBRIHCgNFQVAQBg==');

@$core.Deprecated('Use queryGrantableRolesRequestDescriptor instead')
const QueryGrantableRolesRequest$json = {
  '1': 'QueryGrantableRolesRequest',
  '2': [
    {
      '1': 'full_resource_name',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'fullResourceName'
    },
    {
      '1': 'view',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.RoleView',
      '10': 'view'
    },
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 4, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `QueryGrantableRolesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryGrantableRolesRequestDescriptor = $convert.base64Decode(
    'ChpRdWVyeUdyYW50YWJsZVJvbGVzUmVxdWVzdBIxChJmdWxsX3Jlc291cmNlX25hbWUYASABKA'
    'lCA+BBAlIQZnVsbFJlc291cmNlTmFtZRIxCgR2aWV3GAIgASgOMh0uZ29vZ2xlLmlhbS5hZG1p'
    'bi52MS5Sb2xlVmlld1IEdmlldxIbCglwYWdlX3NpemUYAyABKAVSCHBhZ2VTaXplEh0KCnBhZ2'
    'VfdG9rZW4YBCABKAlSCXBhZ2VUb2tlbg==');

@$core.Deprecated('Use queryGrantableRolesResponseDescriptor instead')
const QueryGrantableRolesResponse$json = {
  '1': 'QueryGrantableRolesResponse',
  '2': [
    {
      '1': 'roles',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.iam.admin.v1.Role',
      '10': 'roles'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `QueryGrantableRolesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryGrantableRolesResponseDescriptor =
    $convert.base64Decode(
        'ChtRdWVyeUdyYW50YWJsZVJvbGVzUmVzcG9uc2USLwoFcm9sZXMYASADKAsyGS5nb29nbGUuaW'
        'FtLmFkbWluLnYxLlJvbGVSBXJvbGVzEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBh'
        'Z2VUb2tlbg==');

@$core.Deprecated('Use listRolesRequestDescriptor instead')
const ListRolesRequest$json = {
  '1': 'ListRolesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
    {
      '1': 'view',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.RoleView',
      '10': 'view'
    },
    {'1': 'show_deleted', '3': 6, '4': 1, '5': 8, '10': 'showDeleted'},
  ],
};

/// Descriptor for `ListRolesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRolesRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0Um9sZXNSZXF1ZXN0Eh4KBnBhcmVudBgBIAEoCUIG+kEDCgEqUgZwYXJlbnQSGwoJcG'
    'FnZV9zaXplGAIgASgFUghwYWdlU2l6ZRIdCgpwYWdlX3Rva2VuGAMgASgJUglwYWdlVG9rZW4S'
    'MQoEdmlldxgEIAEoDjIdLmdvb2dsZS5pYW0uYWRtaW4udjEuUm9sZVZpZXdSBHZpZXcSIQoMc2'
    'hvd19kZWxldGVkGAYgASgIUgtzaG93RGVsZXRlZA==');

@$core.Deprecated('Use listRolesResponseDescriptor instead')
const ListRolesResponse$json = {
  '1': 'ListRolesResponse',
  '2': [
    {
      '1': 'roles',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.iam.admin.v1.Role',
      '10': 'roles'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListRolesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRolesResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0Um9sZXNSZXNwb25zZRIvCgVyb2xlcxgBIAMoCzIZLmdvb2dsZS5pYW0uYWRtaW4udj'
    'EuUm9sZVIFcm9sZXMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2Vu');

@$core.Deprecated('Use getRoleRequestDescriptor instead')
const GetRoleRequest$json = {
  '1': 'GetRoleRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
  ],
};

/// Descriptor for `GetRoleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRoleRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRSb2xlUmVxdWVzdBIaCgRuYW1lGAEgASgJQgb6QQMKASpSBG5hbWU=');

@$core.Deprecated('Use createRoleRequestDescriptor instead')
const CreateRoleRequest$json = {
  '1': 'CreateRoleRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'parent'},
    {'1': 'role_id', '3': 2, '4': 1, '5': 9, '10': 'roleId'},
    {
      '1': 'role',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.iam.admin.v1.Role',
      '10': 'role'
    },
  ],
};

/// Descriptor for `CreateRoleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRoleRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVSb2xlUmVxdWVzdBIeCgZwYXJlbnQYASABKAlCBvpBAwoBKlIGcGFyZW50EhcKB3'
    'JvbGVfaWQYAiABKAlSBnJvbGVJZBItCgRyb2xlGAMgASgLMhkuZ29vZ2xlLmlhbS5hZG1pbi52'
    'MS5Sb2xlUgRyb2xl');

@$core.Deprecated('Use updateRoleRequestDescriptor instead')
const UpdateRoleRequest$json = {
  '1': 'UpdateRoleRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {
      '1': 'role',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.iam.admin.v1.Role',
      '10': 'role'
    },
    {
      '1': 'update_mask',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `UpdateRoleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRoleRequestDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVSb2xlUmVxdWVzdBIaCgRuYW1lGAEgASgJQgb6QQMKASpSBG5hbWUSLQoEcm9sZR'
    'gCIAEoCzIZLmdvb2dsZS5pYW0uYWRtaW4udjEuUm9sZVIEcm9sZRI7Cgt1cGRhdGVfbWFzaxgD'
    'IAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5GaWVsZE1hc2tSCnVwZGF0ZU1hc2s=');

@$core.Deprecated('Use deleteRoleRequestDescriptor instead')
const DeleteRoleRequest$json = {
  '1': 'DeleteRoleRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'etag', '3': 2, '4': 1, '5': 12, '10': 'etag'},
  ],
};

/// Descriptor for `DeleteRoleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRoleRequestDescriptor = $convert.base64Decode(
    'ChFEZWxldGVSb2xlUmVxdWVzdBIaCgRuYW1lGAEgASgJQgb6QQMKASpSBG5hbWUSEgoEZXRhZx'
    'gCIAEoDFIEZXRhZw==');

@$core.Deprecated('Use undeleteRoleRequestDescriptor instead')
const UndeleteRoleRequest$json = {
  '1': 'UndeleteRoleRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'etag', '3': 2, '4': 1, '5': 12, '10': 'etag'},
  ],
};

/// Descriptor for `UndeleteRoleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List undeleteRoleRequestDescriptor = $convert.base64Decode(
    'ChNVbmRlbGV0ZVJvbGVSZXF1ZXN0EhoKBG5hbWUYASABKAlCBvpBAwoBKlIEbmFtZRISCgRldG'
    'FnGAIgASgMUgRldGFn');

@$core.Deprecated('Use permissionDescriptor instead')
const Permission$json = {
  '1': 'Permission',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'only_in_predefined_roles',
      '3': 4,
      '4': 1,
      '5': 8,
      '8': {'3': true},
      '10': 'onlyInPredefinedRoles',
    },
    {
      '1': 'stage',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.Permission.PermissionLaunchStage',
      '10': 'stage'
    },
    {
      '1': 'custom_roles_support_level',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.Permission.CustomRolesSupportLevel',
      '10': 'customRolesSupportLevel'
    },
    {'1': 'api_disabled', '3': 7, '4': 1, '5': 8, '10': 'apiDisabled'},
    {
      '1': 'primary_permission',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'primaryPermission'
    },
  ],
  '4': [
    Permission_PermissionLaunchStage$json,
    Permission_CustomRolesSupportLevel$json
  ],
};

@$core.Deprecated('Use permissionDescriptor instead')
const Permission_PermissionLaunchStage$json = {
  '1': 'PermissionLaunchStage',
  '2': [
    {'1': 'ALPHA', '2': 0},
    {'1': 'BETA', '2': 1},
    {'1': 'GA', '2': 2},
    {'1': 'DEPRECATED', '2': 3},
  ],
};

@$core.Deprecated('Use permissionDescriptor instead')
const Permission_CustomRolesSupportLevel$json = {
  '1': 'CustomRolesSupportLevel',
  '2': [
    {'1': 'SUPPORTED', '2': 0},
    {'1': 'TESTING', '2': 1},
    {'1': 'NOT_SUPPORTED', '2': 2},
  ],
};

/// Descriptor for `Permission`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List permissionDescriptor = $convert.base64Decode(
    'CgpQZXJtaXNzaW9uEhIKBG5hbWUYASABKAlSBG5hbWUSFAoFdGl0bGUYAiABKAlSBXRpdGxlEi'
    'AKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhI7Chhvbmx5X2luX3ByZWRlZmluZWRf'
    'cm9sZXMYBCABKAhCAhgBUhVvbmx5SW5QcmVkZWZpbmVkUm9sZXMSSwoFc3RhZ2UYBSABKA4yNS'
    '5nb29nbGUuaWFtLmFkbWluLnYxLlBlcm1pc3Npb24uUGVybWlzc2lvbkxhdW5jaFN0YWdlUgVz'
    'dGFnZRJ0ChpjdXN0b21fcm9sZXNfc3VwcG9ydF9sZXZlbBgGIAEoDjI3Lmdvb2dsZS5pYW0uYW'
    'RtaW4udjEuUGVybWlzc2lvbi5DdXN0b21Sb2xlc1N1cHBvcnRMZXZlbFIXY3VzdG9tUm9sZXNT'
    'dXBwb3J0TGV2ZWwSIQoMYXBpX2Rpc2FibGVkGAcgASgIUgthcGlEaXNhYmxlZBItChJwcmltYX'
    'J5X3Blcm1pc3Npb24YCCABKAlSEXByaW1hcnlQZXJtaXNzaW9uIkQKFVBlcm1pc3Npb25MYXVu'
    'Y2hTdGFnZRIJCgVBTFBIQRAAEggKBEJFVEEQARIGCgJHQRACEg4KCkRFUFJFQ0FURUQQAyJICh'
    'dDdXN0b21Sb2xlc1N1cHBvcnRMZXZlbBINCglTVVBQT1JURUQQABILCgdURVNUSU5HEAESEQoN'
    'Tk9UX1NVUFBPUlRFRBAC');

@$core.Deprecated('Use queryTestablePermissionsRequestDescriptor instead')
const QueryTestablePermissionsRequest$json = {
  '1': 'QueryTestablePermissionsRequest',
  '2': [
    {
      '1': 'full_resource_name',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'fullResourceName'
    },
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `QueryTestablePermissionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryTestablePermissionsRequestDescriptor =
    $convert.base64Decode(
        'Ch9RdWVyeVRlc3RhYmxlUGVybWlzc2lvbnNSZXF1ZXN0EiwKEmZ1bGxfcmVzb3VyY2VfbmFtZR'
        'gBIAEoCVIQZnVsbFJlc291cmNlTmFtZRIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEh0K'
        'CnBhZ2VfdG9rZW4YAyABKAlSCXBhZ2VUb2tlbg==');

@$core.Deprecated('Use queryTestablePermissionsResponseDescriptor instead')
const QueryTestablePermissionsResponse$json = {
  '1': 'QueryTestablePermissionsResponse',
  '2': [
    {
      '1': 'permissions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.iam.admin.v1.Permission',
      '10': 'permissions'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `QueryTestablePermissionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryTestablePermissionsResponseDescriptor =
    $convert.base64Decode(
        'CiBRdWVyeVRlc3RhYmxlUGVybWlzc2lvbnNSZXNwb25zZRJBCgtwZXJtaXNzaW9ucxgBIAMoCz'
        'IfLmdvb2dsZS5pYW0uYWRtaW4udjEuUGVybWlzc2lvblILcGVybWlzc2lvbnMSJgoPbmV4dF9w'
        'YWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2Vu');

@$core.Deprecated('Use queryAuditableServicesRequestDescriptor instead')
const QueryAuditableServicesRequest$json = {
  '1': 'QueryAuditableServicesRequest',
  '2': [
    {
      '1': 'full_resource_name',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'fullResourceName'
    },
  ],
};

/// Descriptor for `QueryAuditableServicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryAuditableServicesRequestDescriptor =
    $convert.base64Decode(
        'Ch1RdWVyeUF1ZGl0YWJsZVNlcnZpY2VzUmVxdWVzdBIsChJmdWxsX3Jlc291cmNlX25hbWUYAS'
        'ABKAlSEGZ1bGxSZXNvdXJjZU5hbWU=');

@$core.Deprecated('Use queryAuditableServicesResponseDescriptor instead')
const QueryAuditableServicesResponse$json = {
  '1': 'QueryAuditableServicesResponse',
  '2': [
    {
      '1': 'services',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.google.iam.admin.v1.QueryAuditableServicesResponse.AuditableService',
      '10': 'services'
    },
  ],
  '3': [QueryAuditableServicesResponse_AuditableService$json],
};

@$core.Deprecated('Use queryAuditableServicesResponseDescriptor instead')
const QueryAuditableServicesResponse_AuditableService$json = {
  '1': 'AuditableService',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `QueryAuditableServicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryAuditableServicesResponseDescriptor =
    $convert.base64Decode(
        'Ch5RdWVyeUF1ZGl0YWJsZVNlcnZpY2VzUmVzcG9uc2USYAoIc2VydmljZXMYASADKAsyRC5nb2'
        '9nbGUuaWFtLmFkbWluLnYxLlF1ZXJ5QXVkaXRhYmxlU2VydmljZXNSZXNwb25zZS5BdWRpdGFi'
        'bGVTZXJ2aWNlUghzZXJ2aWNlcxomChBBdWRpdGFibGVTZXJ2aWNlEhIKBG5hbWUYASABKAlSBG'
        '5hbWU=');

@$core.Deprecated('Use lintPolicyRequestDescriptor instead')
const LintPolicyRequest$json = {
  '1': 'LintPolicyRequest',
  '2': [
    {
      '1': 'full_resource_name',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'fullResourceName'
    },
    {
      '1': 'condition',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.type.Expr',
      '9': 0,
      '10': 'condition'
    },
  ],
  '8': [
    {'1': 'lint_object'},
  ],
};

/// Descriptor for `LintPolicyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lintPolicyRequestDescriptor = $convert.base64Decode(
    'ChFMaW50UG9saWN5UmVxdWVzdBIsChJmdWxsX3Jlc291cmNlX25hbWUYASABKAlSEGZ1bGxSZX'
    'NvdXJjZU5hbWUSMQoJY29uZGl0aW9uGAUgASgLMhEuZ29vZ2xlLnR5cGUuRXhwckgAUgljb25k'
    'aXRpb25CDQoLbGludF9vYmplY3Q=');

@$core.Deprecated('Use lintResultDescriptor instead')
const LintResult$json = {
  '1': 'LintResult',
  '2': [
    {
      '1': 'level',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.LintResult.Level',
      '10': 'level'
    },
    {
      '1': 'validation_unit_name',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'validationUnitName'
    },
    {
      '1': 'severity',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.google.iam.admin.v1.LintResult.Severity',
      '10': 'severity'
    },
    {'1': 'field_name', '3': 5, '4': 1, '5': 9, '10': 'fieldName'},
    {'1': 'location_offset', '3': 6, '4': 1, '5': 5, '10': 'locationOffset'},
    {'1': 'debug_message', '3': 7, '4': 1, '5': 9, '10': 'debugMessage'},
  ],
  '4': [LintResult_Level$json, LintResult_Severity$json],
};

@$core.Deprecated('Use lintResultDescriptor instead')
const LintResult_Level$json = {
  '1': 'Level',
  '2': [
    {'1': 'LEVEL_UNSPECIFIED', '2': 0},
    {'1': 'CONDITION', '2': 3},
  ],
};

@$core.Deprecated('Use lintResultDescriptor instead')
const LintResult_Severity$json = {
  '1': 'Severity',
  '2': [
    {'1': 'SEVERITY_UNSPECIFIED', '2': 0},
    {'1': 'ERROR', '2': 1},
    {'1': 'WARNING', '2': 2},
    {'1': 'NOTICE', '2': 3},
    {'1': 'INFO', '2': 4},
    {'1': 'DEPRECATED', '2': 5},
  ],
};

/// Descriptor for `LintResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lintResultDescriptor = $convert.base64Decode(
    'CgpMaW50UmVzdWx0EjsKBWxldmVsGAEgASgOMiUuZ29vZ2xlLmlhbS5hZG1pbi52MS5MaW50Um'
    'VzdWx0LkxldmVsUgVsZXZlbBIwChR2YWxpZGF0aW9uX3VuaXRfbmFtZRgCIAEoCVISdmFsaWRh'
    'dGlvblVuaXROYW1lEkQKCHNldmVyaXR5GAMgASgOMiguZ29vZ2xlLmlhbS5hZG1pbi52MS5MaW'
    '50UmVzdWx0LlNldmVyaXR5UghzZXZlcml0eRIdCgpmaWVsZF9uYW1lGAUgASgJUglmaWVsZE5h'
    'bWUSJwoPbG9jYXRpb25fb2Zmc2V0GAYgASgFUg5sb2NhdGlvbk9mZnNldBIjCg1kZWJ1Z19tZX'
    'NzYWdlGAcgASgJUgxkZWJ1Z01lc3NhZ2UiLQoFTGV2ZWwSFQoRTEVWRUxfVU5TUEVDSUZJRUQQ'
    'ABINCglDT05ESVRJT04QAyJiCghTZXZlcml0eRIYChRTRVZFUklUWV9VTlNQRUNJRklFRBAAEg'
    'kKBUVSUk9SEAESCwoHV0FSTklORxACEgoKBk5PVElDRRADEggKBElORk8QBBIOCgpERVBSRUNB'
    'VEVEEAU=');

@$core.Deprecated('Use lintPolicyResponseDescriptor instead')
const LintPolicyResponse$json = {
  '1': 'LintPolicyResponse',
  '2': [
    {
      '1': 'lint_results',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.iam.admin.v1.LintResult',
      '10': 'lintResults'
    },
  ],
};

/// Descriptor for `LintPolicyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lintPolicyResponseDescriptor = $convert.base64Decode(
    'ChJMaW50UG9saWN5UmVzcG9uc2USQgoMbGludF9yZXN1bHRzGAEgAygLMh8uZ29vZ2xlLmlhbS'
    '5hZG1pbi52MS5MaW50UmVzdWx0UgtsaW50UmVzdWx0cw==');
