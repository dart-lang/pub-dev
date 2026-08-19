//
//  Generated code. Do not modify.
//  source: google/appengine/v1/appengine.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use versionViewDescriptor instead')
const VersionView$json = {
  '1': 'VersionView',
  '2': [
    {'1': 'BASIC', '2': 0},
    {'1': 'FULL', '2': 1},
  ],
};

/// Descriptor for `VersionView`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List versionViewDescriptor =
    $convert.base64Decode('CgtWZXJzaW9uVmlldxIJCgVCQVNJQxAAEggKBEZVTEwQAQ==');

@$core.Deprecated('Use authorizedCertificateViewDescriptor instead')
const AuthorizedCertificateView$json = {
  '1': 'AuthorizedCertificateView',
  '2': [
    {'1': 'BASIC_CERTIFICATE', '2': 0},
    {'1': 'FULL_CERTIFICATE', '2': 1},
  ],
};

/// Descriptor for `AuthorizedCertificateView`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List authorizedCertificateViewDescriptor =
    $convert.base64Decode(
        'ChlBdXRob3JpemVkQ2VydGlmaWNhdGVWaWV3EhUKEUJBU0lDX0NFUlRJRklDQVRFEAASFAoQRl'
        'VMTF9DRVJUSUZJQ0FURRAB');

@$core.Deprecated('Use domainOverrideStrategyDescriptor instead')
const DomainOverrideStrategy$json = {
  '1': 'DomainOverrideStrategy',
  '2': [
    {'1': 'UNSPECIFIED_DOMAIN_OVERRIDE_STRATEGY', '2': 0},
    {'1': 'STRICT', '2': 1},
    {'1': 'OVERRIDE', '2': 2},
  ],
};

/// Descriptor for `DomainOverrideStrategy`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List domainOverrideStrategyDescriptor =
    $convert.base64Decode(
        'ChZEb21haW5PdmVycmlkZVN0cmF0ZWd5EigKJFVOU1BFQ0lGSUVEX0RPTUFJTl9PVkVSUklERV'
        '9TVFJBVEVHWRAAEgoKBlNUUklDVBABEgwKCE9WRVJSSURFEAI=');

@$core.Deprecated('Use getApplicationRequestDescriptor instead')
const GetApplicationRequest$json = {
  '1': 'GetApplicationRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GetApplicationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getApplicationRequestDescriptor =
    $convert.base64Decode(
        'ChVHZXRBcHBsaWNhdGlvblJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use createApplicationRequestDescriptor instead')
const CreateApplicationRequest$json = {
  '1': 'CreateApplicationRequest',
  '2': [
    {
      '1': 'application',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.Application',
      '10': 'application'
    },
  ],
};

/// Descriptor for `CreateApplicationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createApplicationRequestDescriptor =
    $convert.base64Decode(
        'ChhDcmVhdGVBcHBsaWNhdGlvblJlcXVlc3QSQgoLYXBwbGljYXRpb24YAiABKAsyIC5nb29nbG'
        'UuYXBwZW5naW5lLnYxLkFwcGxpY2F0aW9uUgthcHBsaWNhdGlvbg==');

@$core.Deprecated('Use updateApplicationRequestDescriptor instead')
const UpdateApplicationRequest$json = {
  '1': 'UpdateApplicationRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'application',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.Application',
      '10': 'application'
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

/// Descriptor for `UpdateApplicationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateApplicationRequestDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVBcHBsaWNhdGlvblJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRJCCgthcHBsaW'
    'NhdGlvbhgCIAEoCzIgLmdvb2dsZS5hcHBlbmdpbmUudjEuQXBwbGljYXRpb25SC2FwcGxpY2F0'
    'aW9uEjsKC3VwZGF0ZV9tYXNrGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza1IKdX'
    'BkYXRlTWFzaw==');

@$core.Deprecated('Use repairApplicationRequestDescriptor instead')
const RepairApplicationRequest$json = {
  '1': 'RepairApplicationRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `RepairApplicationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repairApplicationRequestDescriptor =
    $convert.base64Decode(
        'ChhSZXBhaXJBcHBsaWNhdGlvblJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use listServicesRequestDescriptor instead')
const ListServicesRequest$json = {
  '1': 'ListServicesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListServicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listServicesRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0U2VydmljZXNSZXF1ZXN0EhYKBnBhcmVudBgBIAEoCVIGcGFyZW50EhsKCXBhZ2Vfc2'
    'l6ZRgCIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgDIAEoCVIJcGFnZVRva2Vu');

@$core.Deprecated('Use listServicesResponseDescriptor instead')
const ListServicesResponse$json = {
  '1': 'ListServicesResponse',
  '2': [
    {
      '1': 'services',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.Service',
      '10': 'services'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListServicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listServicesResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0U2VydmljZXNSZXNwb25zZRI4CghzZXJ2aWNlcxgBIAMoCzIcLmdvb2dsZS5hcHBlbm'
    'dpbmUudjEuU2VydmljZVIIc2VydmljZXMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0'
    'UGFnZVRva2Vu');

@$core.Deprecated('Use getServiceRequestDescriptor instead')
const GetServiceRequest$json = {
  '1': 'GetServiceRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GetServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getServiceRequestDescriptor = $convert
    .base64Decode('ChFHZXRTZXJ2aWNlUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use updateServiceRequestDescriptor instead')
const UpdateServiceRequest$json = {
  '1': 'UpdateServiceRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'service',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.Service',
      '10': 'service'
    },
    {
      '1': 'update_mask',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
    {'1': 'migrate_traffic', '3': 4, '4': 1, '5': 8, '10': 'migrateTraffic'},
  ],
};

/// Descriptor for `UpdateServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateServiceRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVTZXJ2aWNlUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEjYKB3NlcnZpY2UYAi'
    'ABKAsyHC5nb29nbGUuYXBwZW5naW5lLnYxLlNlcnZpY2VSB3NlcnZpY2USOwoLdXBkYXRlX21h'
    'c2sYAyABKAsyGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrUgp1cGRhdGVNYXNrEicKD21pZ3'
    'JhdGVfdHJhZmZpYxgEIAEoCFIObWlncmF0ZVRyYWZmaWM=');

@$core.Deprecated('Use deleteServiceRequestDescriptor instead')
const DeleteServiceRequest$json = {
  '1': 'DeleteServiceRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DeleteServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteServiceRequestDescriptor = $convert
    .base64Decode('ChREZWxldGVTZXJ2aWNlUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use listVersionsRequestDescriptor instead')
const ListVersionsRequest$json = {
  '1': 'ListVersionsRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {
      '1': 'view',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1.VersionView',
      '10': 'view'
    },
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 4, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListVersionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listVersionsRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0VmVyc2lvbnNSZXF1ZXN0EhYKBnBhcmVudBgBIAEoCVIGcGFyZW50EjQKBHZpZXcYAi'
    'ABKA4yIC5nb29nbGUuYXBwZW5naW5lLnYxLlZlcnNpb25WaWV3UgR2aWV3EhsKCXBhZ2Vfc2l6'
    'ZRgDIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgEIAEoCVIJcGFnZVRva2Vu');

@$core.Deprecated('Use listVersionsResponseDescriptor instead')
const ListVersionsResponse$json = {
  '1': 'ListVersionsResponse',
  '2': [
    {
      '1': 'versions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.Version',
      '10': 'versions'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListVersionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listVersionsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0VmVyc2lvbnNSZXNwb25zZRI4Cgh2ZXJzaW9ucxgBIAMoCzIcLmdvb2dsZS5hcHBlbm'
    'dpbmUudjEuVmVyc2lvblIIdmVyc2lvbnMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0'
    'UGFnZVRva2Vu');

@$core.Deprecated('Use getVersionRequestDescriptor instead')
const GetVersionRequest$json = {
  '1': 'GetVersionRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'view',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1.VersionView',
      '10': 'view'
    },
  ],
};

/// Descriptor for `GetVersionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVersionRequestDescriptor = $convert.base64Decode(
    'ChFHZXRWZXJzaW9uUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEjQKBHZpZXcYAiABKA4yIC'
    '5nb29nbGUuYXBwZW5naW5lLnYxLlZlcnNpb25WaWV3UgR2aWV3');

@$core.Deprecated('Use createVersionRequestDescriptor instead')
const CreateVersionRequest$json = {
  '1': 'CreateVersionRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {
      '1': 'version',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.Version',
      '10': 'version'
    },
  ],
};

/// Descriptor for `CreateVersionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVersionRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVWZXJzaW9uUmVxdWVzdBIWCgZwYXJlbnQYASABKAlSBnBhcmVudBI2Cgd2ZXJzaW'
    '9uGAIgASgLMhwuZ29vZ2xlLmFwcGVuZ2luZS52MS5WZXJzaW9uUgd2ZXJzaW9u');

@$core.Deprecated('Use updateVersionRequestDescriptor instead')
const UpdateVersionRequest$json = {
  '1': 'UpdateVersionRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'version',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.Version',
      '10': 'version'
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

/// Descriptor for `UpdateVersionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateVersionRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVWZXJzaW9uUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEjYKB3ZlcnNpb24YAi'
    'ABKAsyHC5nb29nbGUuYXBwZW5naW5lLnYxLlZlcnNpb25SB3ZlcnNpb24SOwoLdXBkYXRlX21h'
    'c2sYAyABKAsyGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrUgp1cGRhdGVNYXNr');

@$core.Deprecated('Use deleteVersionRequestDescriptor instead')
const DeleteVersionRequest$json = {
  '1': 'DeleteVersionRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DeleteVersionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteVersionRequestDescriptor = $convert
    .base64Decode('ChREZWxldGVWZXJzaW9uUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use listInstancesRequestDescriptor instead')
const ListInstancesRequest$json = {
  '1': 'ListInstancesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListInstancesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listInstancesRequestDescriptor = $convert.base64Decode(
    'ChRMaXN0SW5zdGFuY2VzUmVxdWVzdBIWCgZwYXJlbnQYASABKAlSBnBhcmVudBIbCglwYWdlX3'
    'NpemUYAiABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4YAyABKAlSCXBhZ2VUb2tlbg==');

@$core.Deprecated('Use listInstancesResponseDescriptor instead')
const ListInstancesResponse$json = {
  '1': 'ListInstancesResponse',
  '2': [
    {
      '1': 'instances',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.Instance',
      '10': 'instances'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListInstancesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listInstancesResponseDescriptor = $convert.base64Decode(
    'ChVMaXN0SW5zdGFuY2VzUmVzcG9uc2USOwoJaW5zdGFuY2VzGAEgAygLMh0uZ29vZ2xlLmFwcG'
    'VuZ2luZS52MS5JbnN0YW5jZVIJaW5zdGFuY2VzEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVIN'
    'bmV4dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use getInstanceRequestDescriptor instead')
const GetInstanceRequest$json = {
  '1': 'GetInstanceRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GetInstanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstanceRequestDescriptor = $convert
    .base64Decode('ChJHZXRJbnN0YW5jZVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use deleteInstanceRequestDescriptor instead')
const DeleteInstanceRequest$json = {
  '1': 'DeleteInstanceRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DeleteInstanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInstanceRequestDescriptor =
    $convert.base64Decode(
        'ChVEZWxldGVJbnN0YW5jZVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use debugInstanceRequestDescriptor instead')
const DebugInstanceRequest$json = {
  '1': 'DebugInstanceRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'ssh_key', '3': 2, '4': 1, '5': 9, '10': 'sshKey'},
  ],
};

/// Descriptor for `DebugInstanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debugInstanceRequestDescriptor = $convert.base64Decode(
    'ChREZWJ1Z0luc3RhbmNlUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEhcKB3NzaF9rZXkYAi'
    'ABKAlSBnNzaEtleQ==');

@$core.Deprecated('Use listIngressRulesRequestDescriptor instead')
const ListIngressRulesRequest$json = {
  '1': 'ListIngressRulesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
    {'1': 'matching_address', '3': 4, '4': 1, '5': 9, '10': 'matchingAddress'},
  ],
};

/// Descriptor for `ListIngressRulesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listIngressRulesRequestDescriptor = $convert.base64Decode(
    'ChdMaXN0SW5ncmVzc1J1bGVzUmVxdWVzdBIWCgZwYXJlbnQYASABKAlSBnBhcmVudBIbCglwYW'
    'dlX3NpemUYAiABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4YAyABKAlSCXBhZ2VUb2tlbhIp'
    'ChBtYXRjaGluZ19hZGRyZXNzGAQgASgJUg9tYXRjaGluZ0FkZHJlc3M=');

@$core.Deprecated('Use listIngressRulesResponseDescriptor instead')
const ListIngressRulesResponse$json = {
  '1': 'ListIngressRulesResponse',
  '2': [
    {
      '1': 'ingress_rules',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.FirewallRule',
      '10': 'ingressRules'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListIngressRulesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listIngressRulesResponseDescriptor = $convert.base64Decode(
    'ChhMaXN0SW5ncmVzc1J1bGVzUmVzcG9uc2USRgoNaW5ncmVzc19ydWxlcxgBIAMoCzIhLmdvb2'
    'dsZS5hcHBlbmdpbmUudjEuRmlyZXdhbGxSdWxlUgxpbmdyZXNzUnVsZXMSJgoPbmV4dF9wYWdl'
    'X3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2Vu');

@$core.Deprecated('Use batchUpdateIngressRulesRequestDescriptor instead')
const BatchUpdateIngressRulesRequest$json = {
  '1': 'BatchUpdateIngressRulesRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'ingress_rules',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.FirewallRule',
      '10': 'ingressRules'
    },
  ],
};

/// Descriptor for `BatchUpdateIngressRulesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchUpdateIngressRulesRequestDescriptor =
    $convert.base64Decode(
        'Ch5CYXRjaFVwZGF0ZUluZ3Jlc3NSdWxlc1JlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRJGCg'
        '1pbmdyZXNzX3J1bGVzGAIgAygLMiEuZ29vZ2xlLmFwcGVuZ2luZS52MS5GaXJld2FsbFJ1bGVS'
        'DGluZ3Jlc3NSdWxlcw==');

@$core.Deprecated('Use batchUpdateIngressRulesResponseDescriptor instead')
const BatchUpdateIngressRulesResponse$json = {
  '1': 'BatchUpdateIngressRulesResponse',
  '2': [
    {
      '1': 'ingress_rules',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.FirewallRule',
      '10': 'ingressRules'
    },
  ],
};

/// Descriptor for `BatchUpdateIngressRulesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchUpdateIngressRulesResponseDescriptor =
    $convert.base64Decode(
        'Ch9CYXRjaFVwZGF0ZUluZ3Jlc3NSdWxlc1Jlc3BvbnNlEkYKDWluZ3Jlc3NfcnVsZXMYASADKA'
        'syIS5nb29nbGUuYXBwZW5naW5lLnYxLkZpcmV3YWxsUnVsZVIMaW5ncmVzc1J1bGVz');

@$core.Deprecated('Use createIngressRuleRequestDescriptor instead')
const CreateIngressRuleRequest$json = {
  '1': 'CreateIngressRuleRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {
      '1': 'rule',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.FirewallRule',
      '10': 'rule'
    },
  ],
};

/// Descriptor for `CreateIngressRuleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createIngressRuleRequestDescriptor =
    $convert.base64Decode(
        'ChhDcmVhdGVJbmdyZXNzUnVsZVJlcXVlc3QSFgoGcGFyZW50GAEgASgJUgZwYXJlbnQSNQoEcn'
        'VsZRgCIAEoCzIhLmdvb2dsZS5hcHBlbmdpbmUudjEuRmlyZXdhbGxSdWxlUgRydWxl');

@$core.Deprecated('Use getIngressRuleRequestDescriptor instead')
const GetIngressRuleRequest$json = {
  '1': 'GetIngressRuleRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GetIngressRuleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIngressRuleRequestDescriptor =
    $convert.base64Decode(
        'ChVHZXRJbmdyZXNzUnVsZVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use updateIngressRuleRequestDescriptor instead')
const UpdateIngressRuleRequest$json = {
  '1': 'UpdateIngressRuleRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'rule',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.FirewallRule',
      '10': 'rule'
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

/// Descriptor for `UpdateIngressRuleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateIngressRuleRequestDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVJbmdyZXNzUnVsZVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRI1CgRydWxlGA'
    'IgASgLMiEuZ29vZ2xlLmFwcGVuZ2luZS52MS5GaXJld2FsbFJ1bGVSBHJ1bGUSOwoLdXBkYXRl'
    'X21hc2sYAyABKAsyGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrUgp1cGRhdGVNYXNr');

@$core.Deprecated('Use deleteIngressRuleRequestDescriptor instead')
const DeleteIngressRuleRequest$json = {
  '1': 'DeleteIngressRuleRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DeleteIngressRuleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteIngressRuleRequestDescriptor =
    $convert.base64Decode(
        'ChhEZWxldGVJbmdyZXNzUnVsZVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use listAuthorizedDomainsRequestDescriptor instead')
const ListAuthorizedDomainsRequest$json = {
  '1': 'ListAuthorizedDomainsRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListAuthorizedDomainsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAuthorizedDomainsRequestDescriptor =
    $convert.base64Decode(
        'ChxMaXN0QXV0aG9yaXplZERvbWFpbnNSZXF1ZXN0EhYKBnBhcmVudBgBIAEoCVIGcGFyZW50Eh'
        'sKCXBhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgDIAEoCVIJcGFnZVRv'
        'a2Vu');

@$core.Deprecated('Use listAuthorizedDomainsResponseDescriptor instead')
const ListAuthorizedDomainsResponse$json = {
  '1': 'ListAuthorizedDomainsResponse',
  '2': [
    {
      '1': 'domains',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.AuthorizedDomain',
      '10': 'domains'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListAuthorizedDomainsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAuthorizedDomainsResponseDescriptor =
    $convert.base64Decode(
        'Ch1MaXN0QXV0aG9yaXplZERvbWFpbnNSZXNwb25zZRI/Cgdkb21haW5zGAEgAygLMiUuZ29vZ2'
        'xlLmFwcGVuZ2luZS52MS5BdXRob3JpemVkRG9tYWluUgdkb21haW5zEiYKD25leHRfcGFnZV90'
        'b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use listAuthorizedCertificatesRequestDescriptor instead')
const ListAuthorizedCertificatesRequest$json = {
  '1': 'ListAuthorizedCertificatesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {
      '1': 'view',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1.AuthorizedCertificateView',
      '10': 'view'
    },
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListAuthorizedCertificatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAuthorizedCertificatesRequestDescriptor =
    $convert.base64Decode(
        'CiFMaXN0QXV0aG9yaXplZENlcnRpZmljYXRlc1JlcXVlc3QSFgoGcGFyZW50GAEgASgJUgZwYX'
        'JlbnQSQgoEdmlldxgEIAEoDjIuLmdvb2dsZS5hcHBlbmdpbmUudjEuQXV0aG9yaXplZENlcnRp'
        'ZmljYXRlVmlld1IEdmlldxIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG'
        '9rZW4YAyABKAlSCXBhZ2VUb2tlbg==');

@$core.Deprecated('Use listAuthorizedCertificatesResponseDescriptor instead')
const ListAuthorizedCertificatesResponse$json = {
  '1': 'ListAuthorizedCertificatesResponse',
  '2': [
    {
      '1': 'certificates',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.AuthorizedCertificate',
      '10': 'certificates'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListAuthorizedCertificatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAuthorizedCertificatesResponseDescriptor =
    $convert.base64Decode(
        'CiJMaXN0QXV0aG9yaXplZENlcnRpZmljYXRlc1Jlc3BvbnNlEk4KDGNlcnRpZmljYXRlcxgBIA'
        'MoCzIqLmdvb2dsZS5hcHBlbmdpbmUudjEuQXV0aG9yaXplZENlcnRpZmljYXRlUgxjZXJ0aWZp'
        'Y2F0ZXMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2Vu');

@$core.Deprecated('Use getAuthorizedCertificateRequestDescriptor instead')
const GetAuthorizedCertificateRequest$json = {
  '1': 'GetAuthorizedCertificateRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'view',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1.AuthorizedCertificateView',
      '10': 'view'
    },
  ],
};

/// Descriptor for `GetAuthorizedCertificateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAuthorizedCertificateRequestDescriptor =
    $convert.base64Decode(
        'Ch9HZXRBdXRob3JpemVkQ2VydGlmaWNhdGVSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSQg'
        'oEdmlldxgCIAEoDjIuLmdvb2dsZS5hcHBlbmdpbmUudjEuQXV0aG9yaXplZENlcnRpZmljYXRl'
        'Vmlld1IEdmlldw==');

@$core.Deprecated('Use createAuthorizedCertificateRequestDescriptor instead')
const CreateAuthorizedCertificateRequest$json = {
  '1': 'CreateAuthorizedCertificateRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {
      '1': 'certificate',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.AuthorizedCertificate',
      '10': 'certificate'
    },
  ],
};

/// Descriptor for `CreateAuthorizedCertificateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAuthorizedCertificateRequestDescriptor =
    $convert.base64Decode(
        'CiJDcmVhdGVBdXRob3JpemVkQ2VydGlmaWNhdGVSZXF1ZXN0EhYKBnBhcmVudBgBIAEoCVIGcG'
        'FyZW50EkwKC2NlcnRpZmljYXRlGAIgASgLMiouZ29vZ2xlLmFwcGVuZ2luZS52MS5BdXRob3Jp'
        'emVkQ2VydGlmaWNhdGVSC2NlcnRpZmljYXRl');

@$core.Deprecated('Use updateAuthorizedCertificateRequestDescriptor instead')
const UpdateAuthorizedCertificateRequest$json = {
  '1': 'UpdateAuthorizedCertificateRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'certificate',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.AuthorizedCertificate',
      '10': 'certificate'
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

/// Descriptor for `UpdateAuthorizedCertificateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAuthorizedCertificateRequestDescriptor =
    $convert.base64Decode(
        'CiJVcGRhdGVBdXRob3JpemVkQ2VydGlmaWNhdGVSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbW'
        'USTAoLY2VydGlmaWNhdGUYAiABKAsyKi5nb29nbGUuYXBwZW5naW5lLnYxLkF1dGhvcml6ZWRD'
        'ZXJ0aWZpY2F0ZVILY2VydGlmaWNhdGUSOwoLdXBkYXRlX21hc2sYAyABKAsyGi5nb29nbGUucH'
        'JvdG9idWYuRmllbGRNYXNrUgp1cGRhdGVNYXNr');

@$core.Deprecated('Use deleteAuthorizedCertificateRequestDescriptor instead')
const DeleteAuthorizedCertificateRequest$json = {
  '1': 'DeleteAuthorizedCertificateRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DeleteAuthorizedCertificateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAuthorizedCertificateRequestDescriptor =
    $convert.base64Decode(
        'CiJEZWxldGVBdXRob3JpemVkQ2VydGlmaWNhdGVSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbW'
        'U=');

@$core.Deprecated('Use listDomainMappingsRequestDescriptor instead')
const ListDomainMappingsRequest$json = {
  '1': 'ListDomainMappingsRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListDomainMappingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDomainMappingsRequestDescriptor = $convert.base64Decode(
    'ChlMaXN0RG9tYWluTWFwcGluZ3NSZXF1ZXN0EhYKBnBhcmVudBgBIAEoCVIGcGFyZW50EhsKCX'
    'BhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgDIAEoCVIJcGFnZVRva2Vu');

@$core.Deprecated('Use listDomainMappingsResponseDescriptor instead')
const ListDomainMappingsResponse$json = {
  '1': 'ListDomainMappingsResponse',
  '2': [
    {
      '1': 'domain_mappings',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.DomainMapping',
      '10': 'domainMappings'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListDomainMappingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDomainMappingsResponseDescriptor =
    $convert.base64Decode(
        'ChpMaXN0RG9tYWluTWFwcGluZ3NSZXNwb25zZRJLCg9kb21haW5fbWFwcGluZ3MYASADKAsyIi'
        '5nb29nbGUuYXBwZW5naW5lLnYxLkRvbWFpbk1hcHBpbmdSDmRvbWFpbk1hcHBpbmdzEiYKD25l'
        'eHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use getDomainMappingRequestDescriptor instead')
const GetDomainMappingRequest$json = {
  '1': 'GetDomainMappingRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GetDomainMappingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDomainMappingRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXREb21haW5NYXBwaW5nUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use createDomainMappingRequestDescriptor instead')
const CreateDomainMappingRequest$json = {
  '1': 'CreateDomainMappingRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {
      '1': 'domain_mapping',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.DomainMapping',
      '10': 'domainMapping'
    },
    {
      '1': 'override_strategy',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1.DomainOverrideStrategy',
      '10': 'overrideStrategy'
    },
  ],
};

/// Descriptor for `CreateDomainMappingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDomainMappingRequestDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVEb21haW5NYXBwaW5nUmVxdWVzdBIWCgZwYXJlbnQYASABKAlSBnBhcmVudBJJCg'
    '5kb21haW5fbWFwcGluZxgCIAEoCzIiLmdvb2dsZS5hcHBlbmdpbmUudjEuRG9tYWluTWFwcGlu'
    'Z1INZG9tYWluTWFwcGluZxJYChFvdmVycmlkZV9zdHJhdGVneRgEIAEoDjIrLmdvb2dsZS5hcH'
    'BlbmdpbmUudjEuRG9tYWluT3ZlcnJpZGVTdHJhdGVneVIQb3ZlcnJpZGVTdHJhdGVneQ==');

@$core.Deprecated('Use updateDomainMappingRequestDescriptor instead')
const UpdateDomainMappingRequest$json = {
  '1': 'UpdateDomainMappingRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'domain_mapping',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.DomainMapping',
      '10': 'domainMapping'
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

/// Descriptor for `UpdateDomainMappingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDomainMappingRequestDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVEb21haW5NYXBwaW5nUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEkkKDmRvbW'
    'Fpbl9tYXBwaW5nGAIgASgLMiIuZ29vZ2xlLmFwcGVuZ2luZS52MS5Eb21haW5NYXBwaW5nUg1k'
    'b21haW5NYXBwaW5nEjsKC3VwZGF0ZV9tYXNrGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZW'
    'xkTWFza1IKdXBkYXRlTWFzaw==');

@$core.Deprecated('Use deleteDomainMappingRequestDescriptor instead')
const DeleteDomainMappingRequest$json = {
  '1': 'DeleteDomainMappingRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DeleteDomainMappingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDomainMappingRequestDescriptor =
    $convert.base64Decode(
        'ChpEZWxldGVEb21haW5NYXBwaW5nUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');
