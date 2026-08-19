//
//  Generated code. Do not modify.
//  source: google/api/field_behavior.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use fieldBehaviorDescriptor instead')
const FieldBehavior$json = {
  '1': 'FieldBehavior',
  '2': [
    {'1': 'FIELD_BEHAVIOR_UNSPECIFIED', '2': 0},
    {'1': 'OPTIONAL', '2': 1},
    {'1': 'REQUIRED', '2': 2},
    {'1': 'OUTPUT_ONLY', '2': 3},
    {'1': 'INPUT_ONLY', '2': 4},
    {'1': 'IMMUTABLE', '2': 5},
    {'1': 'UNORDERED_LIST', '2': 6},
    {'1': 'NON_EMPTY_DEFAULT', '2': 7},
    {'1': 'IDENTIFIER', '2': 8},
  ],
};

/// Descriptor for `FieldBehavior`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fieldBehaviorDescriptor = $convert.base64Decode(
    'Cg1GaWVsZEJlaGF2aW9yEh4KGkZJRUxEX0JFSEFWSU9SX1VOU1BFQ0lGSUVEEAASDAoIT1BUSU'
    '9OQUwQARIMCghSRVFVSVJFRBACEg8KC09VVFBVVF9PTkxZEAMSDgoKSU5QVVRfT05MWRAEEg0K'
    'CUlNTVVUQUJMRRAFEhIKDlVOT1JERVJFRF9MSVNUEAYSFQoRTk9OX0VNUFRZX0RFRkFVTFQQBx'
    'IOCgpJREVOVElGSUVSEAg=');
