//
//  Generated code. Do not modify.
//  source: google/iam/v1/logging/audit_data.proto
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
      '1': 'policy_delta',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.iam.v1.PolicyDelta',
      '10': 'policyDelta'
    },
  ],
};

/// Descriptor for `AuditData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List auditDataDescriptor = $convert.base64Decode(
    'CglBdWRpdERhdGESPQoMcG9saWN5X2RlbHRhGAIgASgLMhouZ29vZ2xlLmlhbS52MS5Qb2xpY3'
    'lEZWx0YVILcG9saWN5RGVsdGE=');
