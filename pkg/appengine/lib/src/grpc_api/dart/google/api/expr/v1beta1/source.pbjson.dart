//
//  Generated code. Do not modify.
//  source: google/api/expr/v1beta1/source.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use sourceInfoDescriptor instead')
const SourceInfo$json = {
  '1': 'SourceInfo',
  '2': [
    {'1': 'location', '3': 2, '4': 1, '5': 9, '10': 'location'},
    {'1': 'line_offsets', '3': 3, '4': 3, '5': 5, '10': 'lineOffsets'},
    {
      '1': 'positions',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.v1beta1.SourceInfo.PositionsEntry',
      '10': 'positions'
    },
  ],
  '3': [SourceInfo_PositionsEntry$json],
};

@$core.Deprecated('Use sourceInfoDescriptor instead')
const SourceInfo_PositionsEntry$json = {
  '1': 'PositionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `SourceInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sourceInfoDescriptor = $convert.base64Decode(
    'CgpTb3VyY2VJbmZvEhoKCGxvY2F0aW9uGAIgASgJUghsb2NhdGlvbhIhCgxsaW5lX29mZnNldH'
    'MYAyADKAVSC2xpbmVPZmZzZXRzElAKCXBvc2l0aW9ucxgEIAMoCzIyLmdvb2dsZS5hcGkuZXhw'
    'ci52MWJldGExLlNvdXJjZUluZm8uUG9zaXRpb25zRW50cnlSCXBvc2l0aW9ucxo8Cg5Qb3NpdG'
    'lvbnNFbnRyeRIQCgNrZXkYASABKAVSA2tleRIUCgV2YWx1ZRgCIAEoBVIFdmFsdWU6AjgB');

@$core.Deprecated('Use sourcePositionDescriptor instead')
const SourcePosition$json = {
  '1': 'SourcePosition',
  '2': [
    {'1': 'location', '3': 1, '4': 1, '5': 9, '10': 'location'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'line', '3': 3, '4': 1, '5': 5, '10': 'line'},
    {'1': 'column', '3': 4, '4': 1, '5': 5, '10': 'column'},
  ],
};

/// Descriptor for `SourcePosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sourcePositionDescriptor = $convert.base64Decode(
    'Cg5Tb3VyY2VQb3NpdGlvbhIaCghsb2NhdGlvbhgBIAEoCVIIbG9jYXRpb24SFgoGb2Zmc2V0GA'
    'IgASgFUgZvZmZzZXQSEgoEbGluZRgDIAEoBVIEbGluZRIWCgZjb2x1bW4YBCABKAVSBmNvbHVt'
    'bg==');
