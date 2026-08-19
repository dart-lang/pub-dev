//
//  Generated code. Do not modify.
//  source: google/api/control.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use controlDescriptor instead')
const Control$json = {
  '1': 'Control',
  '2': [
    {'1': 'environment', '3': 1, '4': 1, '5': 9, '10': 'environment'},
    {
      '1': 'method_policies',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.api.MethodPolicy',
      '10': 'methodPolicies'
    },
  ],
};

/// Descriptor for `Control`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlDescriptor = $convert.base64Decode(
    'CgdDb250cm9sEiAKC2Vudmlyb25tZW50GAEgASgJUgtlbnZpcm9ubWVudBJBCg9tZXRob2RfcG'
    '9saWNpZXMYBCADKAsyGC5nb29nbGUuYXBpLk1ldGhvZFBvbGljeVIObWV0aG9kUG9saWNpZXM=');
