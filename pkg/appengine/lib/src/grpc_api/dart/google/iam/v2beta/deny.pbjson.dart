//
//  Generated code. Do not modify.
//  source: google/iam/v2beta/deny.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use denyRuleDescriptor instead')
const DenyRule$json = {
  '1': 'DenyRule',
  '2': [
    {
      '1': 'denied_principals',
      '3': 1,
      '4': 3,
      '5': 9,
      '10': 'deniedPrincipals'
    },
    {
      '1': 'exception_principals',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'exceptionPrincipals'
    },
    {
      '1': 'denied_permissions',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'deniedPermissions'
    },
    {
      '1': 'exception_permissions',
      '3': 4,
      '4': 3,
      '5': 9,
      '10': 'exceptionPermissions'
    },
    {
      '1': 'denial_condition',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.type.Expr',
      '10': 'denialCondition'
    },
  ],
};

/// Descriptor for `DenyRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List denyRuleDescriptor = $convert.base64Decode(
    'CghEZW55UnVsZRIrChFkZW5pZWRfcHJpbmNpcGFscxgBIAMoCVIQZGVuaWVkUHJpbmNpcGFscx'
    'IxChRleGNlcHRpb25fcHJpbmNpcGFscxgCIAMoCVITZXhjZXB0aW9uUHJpbmNpcGFscxItChJk'
    'ZW5pZWRfcGVybWlzc2lvbnMYAyADKAlSEWRlbmllZFBlcm1pc3Npb25zEjMKFWV4Y2VwdGlvbl'
    '9wZXJtaXNzaW9ucxgEIAMoCVIUZXhjZXB0aW9uUGVybWlzc2lvbnMSPAoQZGVuaWFsX2NvbmRp'
    'dGlvbhgFIAEoCzIRLmdvb2dsZS50eXBlLkV4cHJSD2RlbmlhbENvbmRpdGlvbg==');
