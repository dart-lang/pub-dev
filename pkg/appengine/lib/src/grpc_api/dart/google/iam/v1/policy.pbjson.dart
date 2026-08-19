//
//  Generated code. Do not modify.
//  source: google/iam/v1/policy.proto
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
    {'1': 'version', '3': 1, '4': 1, '5': 5, '10': 'version'},
    {
      '1': 'bindings',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.iam.v1.Binding',
      '10': 'bindings'
    },
    {
      '1': 'audit_configs',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.google.iam.v1.AuditConfig',
      '10': 'auditConfigs'
    },
    {'1': 'etag', '3': 3, '4': 1, '5': 12, '10': 'etag'},
  ],
};

/// Descriptor for `Policy`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List policyDescriptor = $convert.base64Decode(
    'CgZQb2xpY3kSGAoHdmVyc2lvbhgBIAEoBVIHdmVyc2lvbhIyCghiaW5kaW5ncxgEIAMoCzIWLm'
    'dvb2dsZS5pYW0udjEuQmluZGluZ1IIYmluZGluZ3MSPwoNYXVkaXRfY29uZmlncxgGIAMoCzIa'
    'Lmdvb2dsZS5pYW0udjEuQXVkaXRDb25maWdSDGF1ZGl0Q29uZmlncxISCgRldGFnGAMgASgMUg'
    'RldGFn');

@$core.Deprecated('Use bindingDescriptor instead')
const Binding$json = {
  '1': 'Binding',
  '2': [
    {'1': 'role', '3': 1, '4': 1, '5': 9, '10': 'role'},
    {'1': 'members', '3': 2, '4': 3, '5': 9, '10': 'members'},
    {
      '1': 'condition',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.type.Expr',
      '10': 'condition'
    },
  ],
};

/// Descriptor for `Binding`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bindingDescriptor = $convert.base64Decode(
    'CgdCaW5kaW5nEhIKBHJvbGUYASABKAlSBHJvbGUSGAoHbWVtYmVycxgCIAMoCVIHbWVtYmVycx'
    'IvCgljb25kaXRpb24YAyABKAsyES5nb29nbGUudHlwZS5FeHByUgljb25kaXRpb24=');

@$core.Deprecated('Use auditConfigDescriptor instead')
const AuditConfig$json = {
  '1': 'AuditConfig',
  '2': [
    {'1': 'service', '3': 1, '4': 1, '5': 9, '10': 'service'},
    {
      '1': 'audit_log_configs',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.iam.v1.AuditLogConfig',
      '10': 'auditLogConfigs'
    },
  ],
};

/// Descriptor for `AuditConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List auditConfigDescriptor = $convert.base64Decode(
    'CgtBdWRpdENvbmZpZxIYCgdzZXJ2aWNlGAEgASgJUgdzZXJ2aWNlEkkKEWF1ZGl0X2xvZ19jb2'
    '5maWdzGAMgAygLMh0uZ29vZ2xlLmlhbS52MS5BdWRpdExvZ0NvbmZpZ1IPYXVkaXRMb2dDb25m'
    'aWdz');

@$core.Deprecated('Use auditLogConfigDescriptor instead')
const AuditLogConfig$json = {
  '1': 'AuditLogConfig',
  '2': [
    {
      '1': 'log_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.iam.v1.AuditLogConfig.LogType',
      '10': 'logType'
    },
    {'1': 'exempted_members', '3': 2, '4': 3, '5': 9, '10': 'exemptedMembers'},
  ],
  '4': [AuditLogConfig_LogType$json],
};

@$core.Deprecated('Use auditLogConfigDescriptor instead')
const AuditLogConfig_LogType$json = {
  '1': 'LogType',
  '2': [
    {'1': 'LOG_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'ADMIN_READ', '2': 1},
    {'1': 'DATA_WRITE', '2': 2},
    {'1': 'DATA_READ', '2': 3},
  ],
};

/// Descriptor for `AuditLogConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List auditLogConfigDescriptor = $convert.base64Decode(
    'Cg5BdWRpdExvZ0NvbmZpZxJACghsb2dfdHlwZRgBIAEoDjIlLmdvb2dsZS5pYW0udjEuQXVkaX'
    'RMb2dDb25maWcuTG9nVHlwZVIHbG9nVHlwZRIpChBleGVtcHRlZF9tZW1iZXJzGAIgAygJUg9l'
    'eGVtcHRlZE1lbWJlcnMiUgoHTG9nVHlwZRIYChRMT0dfVFlQRV9VTlNQRUNJRklFRBAAEg4KCk'
    'FETUlOX1JFQUQQARIOCgpEQVRBX1dSSVRFEAISDQoJREFUQV9SRUFEEAM=');

@$core.Deprecated('Use policyDeltaDescriptor instead')
const PolicyDelta$json = {
  '1': 'PolicyDelta',
  '2': [
    {
      '1': 'binding_deltas',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.iam.v1.BindingDelta',
      '10': 'bindingDeltas'
    },
    {
      '1': 'audit_config_deltas',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.iam.v1.AuditConfigDelta',
      '10': 'auditConfigDeltas'
    },
  ],
};

/// Descriptor for `PolicyDelta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List policyDeltaDescriptor = $convert.base64Decode(
    'CgtQb2xpY3lEZWx0YRJCCg5iaW5kaW5nX2RlbHRhcxgBIAMoCzIbLmdvb2dsZS5pYW0udjEuQm'
    'luZGluZ0RlbHRhUg1iaW5kaW5nRGVsdGFzEk8KE2F1ZGl0X2NvbmZpZ19kZWx0YXMYAiADKAsy'
    'Hy5nb29nbGUuaWFtLnYxLkF1ZGl0Q29uZmlnRGVsdGFSEWF1ZGl0Q29uZmlnRGVsdGFz');

@$core.Deprecated('Use bindingDeltaDescriptor instead')
const BindingDelta$json = {
  '1': 'BindingDelta',
  '2': [
    {
      '1': 'action',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.iam.v1.BindingDelta.Action',
      '10': 'action'
    },
    {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
    {'1': 'member', '3': 3, '4': 1, '5': 9, '10': 'member'},
    {
      '1': 'condition',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.type.Expr',
      '10': 'condition'
    },
  ],
  '4': [BindingDelta_Action$json],
};

@$core.Deprecated('Use bindingDeltaDescriptor instead')
const BindingDelta_Action$json = {
  '1': 'Action',
  '2': [
    {'1': 'ACTION_UNSPECIFIED', '2': 0},
    {'1': 'ADD', '2': 1},
    {'1': 'REMOVE', '2': 2},
  ],
};

/// Descriptor for `BindingDelta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bindingDeltaDescriptor = $convert.base64Decode(
    'CgxCaW5kaW5nRGVsdGESOgoGYWN0aW9uGAEgASgOMiIuZ29vZ2xlLmlhbS52MS5CaW5kaW5nRG'
    'VsdGEuQWN0aW9uUgZhY3Rpb24SEgoEcm9sZRgCIAEoCVIEcm9sZRIWCgZtZW1iZXIYAyABKAlS'
    'Bm1lbWJlchIvCgljb25kaXRpb24YBCABKAsyES5nb29nbGUudHlwZS5FeHByUgljb25kaXRpb2'
    '4iNQoGQWN0aW9uEhYKEkFDVElPTl9VTlNQRUNJRklFRBAAEgcKA0FERBABEgoKBlJFTU9WRRAC');

@$core.Deprecated('Use auditConfigDeltaDescriptor instead')
const AuditConfigDelta$json = {
  '1': 'AuditConfigDelta',
  '2': [
    {
      '1': 'action',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.iam.v1.AuditConfigDelta.Action',
      '10': 'action'
    },
    {'1': 'service', '3': 2, '4': 1, '5': 9, '10': 'service'},
    {'1': 'exempted_member', '3': 3, '4': 1, '5': 9, '10': 'exemptedMember'},
    {'1': 'log_type', '3': 4, '4': 1, '5': 9, '10': 'logType'},
  ],
  '4': [AuditConfigDelta_Action$json],
};

@$core.Deprecated('Use auditConfigDeltaDescriptor instead')
const AuditConfigDelta_Action$json = {
  '1': 'Action',
  '2': [
    {'1': 'ACTION_UNSPECIFIED', '2': 0},
    {'1': 'ADD', '2': 1},
    {'1': 'REMOVE', '2': 2},
  ],
};

/// Descriptor for `AuditConfigDelta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List auditConfigDeltaDescriptor = $convert.base64Decode(
    'ChBBdWRpdENvbmZpZ0RlbHRhEj4KBmFjdGlvbhgBIAEoDjImLmdvb2dsZS5pYW0udjEuQXVkaX'
    'RDb25maWdEZWx0YS5BY3Rpb25SBmFjdGlvbhIYCgdzZXJ2aWNlGAIgASgJUgdzZXJ2aWNlEicK'
    'D2V4ZW1wdGVkX21lbWJlchgDIAEoCVIOZXhlbXB0ZWRNZW1iZXISGQoIbG9nX3R5cGUYBCABKA'
    'lSB2xvZ1R5cGUiNQoGQWN0aW9uEhYKEkFDVElPTl9VTlNQRUNJRklFRBAAEgcKA0FERBABEgoK'
    'BlJFTU9WRRAC');
