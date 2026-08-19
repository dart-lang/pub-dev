//
//  Generated code. Do not modify.
//  source: google/api/visibility.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use visibilityDescriptor instead')
const Visibility$json = {
  '1': 'Visibility',
  '2': [
    {
      '1': 'rules',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.VisibilityRule',
      '10': 'rules'
    },
  ],
};

/// Descriptor for `Visibility`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List visibilityDescriptor = $convert.base64Decode(
    'CgpWaXNpYmlsaXR5EjAKBXJ1bGVzGAEgAygLMhouZ29vZ2xlLmFwaS5WaXNpYmlsaXR5UnVsZV'
    'IFcnVsZXM=');

@$core.Deprecated('Use visibilityRuleDescriptor instead')
const VisibilityRule$json = {
  '1': 'VisibilityRule',
  '2': [
    {'1': 'selector', '3': 1, '4': 1, '5': 9, '10': 'selector'},
    {'1': 'restriction', '3': 2, '4': 1, '5': 9, '10': 'restriction'},
  ],
};

/// Descriptor for `VisibilityRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List visibilityRuleDescriptor = $convert.base64Decode(
    'Cg5WaXNpYmlsaXR5UnVsZRIaCghzZWxlY3RvchgBIAEoCVIIc2VsZWN0b3ISIAoLcmVzdHJpY3'
    'Rpb24YAiABKAlSC3Jlc3RyaWN0aW9u');
