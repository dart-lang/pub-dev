//
//  Generated code. Do not modify.
//  source: google/api/policy.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use fieldPolicyDescriptor instead')
const FieldPolicy$json = {
  '1': 'FieldPolicy',
  '2': [
    {'1': 'selector', '3': 1, '4': 1, '5': 9, '10': 'selector'},
    {
      '1': 'resource_permission',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'resourcePermission'
    },
    {'1': 'resource_type', '3': 3, '4': 1, '5': 9, '10': 'resourceType'},
  ],
};

/// Descriptor for `FieldPolicy`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fieldPolicyDescriptor = $convert.base64Decode(
    'CgtGaWVsZFBvbGljeRIaCghzZWxlY3RvchgBIAEoCVIIc2VsZWN0b3ISLwoTcmVzb3VyY2VfcG'
    'VybWlzc2lvbhgCIAEoCVIScmVzb3VyY2VQZXJtaXNzaW9uEiMKDXJlc291cmNlX3R5cGUYAyAB'
    'KAlSDHJlc291cmNlVHlwZQ==');

@$core.Deprecated('Use methodPolicyDescriptor instead')
const MethodPolicy$json = {
  '1': 'MethodPolicy',
  '2': [
    {'1': 'selector', '3': 9, '4': 1, '5': 9, '10': 'selector'},
    {
      '1': 'request_policies',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.FieldPolicy',
      '10': 'requestPolicies'
    },
  ],
};

/// Descriptor for `MethodPolicy`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List methodPolicyDescriptor = $convert.base64Decode(
    'CgxNZXRob2RQb2xpY3kSGgoIc2VsZWN0b3IYCSABKAlSCHNlbGVjdG9yEkIKEHJlcXVlc3RfcG'
    '9saWNpZXMYAiADKAsyFy5nb29nbGUuYXBpLkZpZWxkUG9saWN5Ug9yZXF1ZXN0UG9saWNpZXM=');
