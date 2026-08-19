//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/operation.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use operationMetadataV1BetaDescriptor instead')
const OperationMetadataV1Beta$json = {
  '1': 'OperationMetadataV1Beta',
  '2': [
    {'1': 'method', '3': 1, '4': 1, '5': 9, '10': 'method'},
    {
      '1': 'insert_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'insertTime'
    },
    {
      '1': 'end_time',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'endTime'
    },
    {'1': 'user', '3': 4, '4': 1, '5': 9, '10': 'user'},
    {'1': 'target', '3': 5, '4': 1, '5': 9, '10': 'target'},
    {
      '1': 'ephemeral_message',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'ephemeralMessage'
    },
    {'1': 'warning', '3': 7, '4': 3, '5': 9, '10': 'warning'},
    {
      '1': 'create_version_metadata',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.CreateVersionMetadataV1Beta',
      '9': 0,
      '10': 'createVersionMetadata'
    },
  ],
  '8': [
    {'1': 'method_metadata'},
  ],
};

/// Descriptor for `OperationMetadataV1Beta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List operationMetadataV1BetaDescriptor = $convert.base64Decode(
    'ChdPcGVyYXRpb25NZXRhZGF0YVYxQmV0YRIWCgZtZXRob2QYASABKAlSBm1ldGhvZBI7Cgtpbn'
    'NlcnRfdGltZRgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCmluc2VydFRpbWUS'
    'NQoIZW5kX3RpbWUYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmRUaW1lEh'
    'IKBHVzZXIYBCABKAlSBHVzZXISFgoGdGFyZ2V0GAUgASgJUgZ0YXJnZXQSKwoRZXBoZW1lcmFs'
    'X21lc3NhZ2UYBiABKAlSEGVwaGVtZXJhbE1lc3NhZ2USGAoHd2FybmluZxgHIAMoCVIHd2Fybm'
    'luZxJuChdjcmVhdGVfdmVyc2lvbl9tZXRhZGF0YRgIIAEoCzI0Lmdvb2dsZS5hcHBlbmdpbmUu'
    'djFiZXRhLkNyZWF0ZVZlcnNpb25NZXRhZGF0YVYxQmV0YUgAUhVjcmVhdGVWZXJzaW9uTWV0YW'
    'RhdGFCEQoPbWV0aG9kX21ldGFkYXRh');

@$core.Deprecated('Use createVersionMetadataV1BetaDescriptor instead')
const CreateVersionMetadataV1Beta$json = {
  '1': 'CreateVersionMetadataV1Beta',
  '2': [
    {'1': 'cloud_build_id', '3': 1, '4': 1, '5': 9, '10': 'cloudBuildId'},
  ],
};

/// Descriptor for `CreateVersionMetadataV1Beta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVersionMetadataV1BetaDescriptor =
    $convert.base64Decode(
        'ChtDcmVhdGVWZXJzaW9uTWV0YWRhdGFWMUJldGESJAoOY2xvdWRfYnVpbGRfaWQYASABKAlSDG'
        'Nsb3VkQnVpbGRJZA==');
