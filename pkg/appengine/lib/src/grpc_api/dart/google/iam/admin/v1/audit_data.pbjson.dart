//
//  Generated code. Do not modify.
//  source: google/iam/admin/v1/audit_data.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use auditDataDescriptor instead')
const AuditData$json = {
  '1': 'AuditData',
  '2': [
    {
      '1': 'permission_delta',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.iam.admin.v1.AuditData.PermissionDelta',
      '10': 'permissionDelta'
    },
  ],
  '3': [AuditData_PermissionDelta$json],
};

@$core.Deprecated('Use auditDataDescriptor instead')
const AuditData_PermissionDelta$json = {
  '1': 'PermissionDelta',
  '2': [
    {
      '1': 'added_permissions',
      '3': 1,
      '4': 3,
      '5': 9,
      '10': 'addedPermissions'
    },
    {
      '1': 'removed_permissions',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'removedPermissions'
    },
  ],
};

/// Descriptor for `AuditData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List auditDataDescriptor = $convert.base64Decode(
    'CglBdWRpdERhdGESWQoQcGVybWlzc2lvbl9kZWx0YRgBIAEoCzIuLmdvb2dsZS5pYW0uYWRtaW'
    '4udjEuQXVkaXREYXRhLlBlcm1pc3Npb25EZWx0YVIPcGVybWlzc2lvbkRlbHRhGm8KD1Blcm1p'
    'c3Npb25EZWx0YRIrChFhZGRlZF9wZXJtaXNzaW9ucxgBIAMoCVIQYWRkZWRQZXJtaXNzaW9ucx'
    'IvChNyZW1vdmVkX3Blcm1pc3Npb25zGAIgAygJUhJyZW1vdmVkUGVybWlzc2lvbnM=');
