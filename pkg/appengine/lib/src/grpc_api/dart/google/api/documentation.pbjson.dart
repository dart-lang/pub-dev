//
//  Generated code. Do not modify.
//  source: google/api/documentation.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use documentationDescriptor instead')
const Documentation$json = {
  '1': 'Documentation',
  '2': [
    {'1': 'summary', '3': 1, '4': 1, '5': 9, '10': 'summary'},
    {
      '1': 'pages',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.google.api.Page',
      '10': 'pages'
    },
    {
      '1': 'rules',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.api.DocumentationRule',
      '10': 'rules'
    },
    {
      '1': 'documentation_root_url',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'documentationRootUrl'
    },
    {'1': 'service_root_url', '3': 6, '4': 1, '5': 9, '10': 'serviceRootUrl'},
    {'1': 'overview', '3': 2, '4': 1, '5': 9, '10': 'overview'},
  ],
};

/// Descriptor for `Documentation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List documentationDescriptor = $convert.base64Decode(
    'Cg1Eb2N1bWVudGF0aW9uEhgKB3N1bW1hcnkYASABKAlSB3N1bW1hcnkSJgoFcGFnZXMYBSADKA'
    'syEC5nb29nbGUuYXBpLlBhZ2VSBXBhZ2VzEjMKBXJ1bGVzGAMgAygLMh0uZ29vZ2xlLmFwaS5E'
    'b2N1bWVudGF0aW9uUnVsZVIFcnVsZXMSNAoWZG9jdW1lbnRhdGlvbl9yb290X3VybBgEIAEoCV'
    'IUZG9jdW1lbnRhdGlvblJvb3RVcmwSKAoQc2VydmljZV9yb290X3VybBgGIAEoCVIOc2Vydmlj'
    'ZVJvb3RVcmwSGgoIb3ZlcnZpZXcYAiABKAlSCG92ZXJ2aWV3');

@$core.Deprecated('Use documentationRuleDescriptor instead')
const DocumentationRule$json = {
  '1': 'DocumentationRule',
  '2': [
    {'1': 'selector', '3': 1, '4': 1, '5': 9, '10': 'selector'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'deprecation_description',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'deprecationDescription'
    },
  ],
};

/// Descriptor for `DocumentationRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List documentationRuleDescriptor = $convert.base64Decode(
    'ChFEb2N1bWVudGF0aW9uUnVsZRIaCghzZWxlY3RvchgBIAEoCVIIc2VsZWN0b3ISIAoLZGVzY3'
    'JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEjcKF2RlcHJlY2F0aW9uX2Rlc2NyaXB0aW9uGAMg'
    'ASgJUhZkZXByZWNhdGlvbkRlc2NyaXB0aW9u');

@$core.Deprecated('Use pageDescriptor instead')
const Page$json = {
  '1': 'Page',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    {
      '1': 'subpages',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.api.Page',
      '10': 'subpages'
    },
  ],
};

/// Descriptor for `Page`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pageDescriptor = $convert.base64Decode(
    'CgRQYWdlEhIKBG5hbWUYASABKAlSBG5hbWUSGAoHY29udGVudBgCIAEoCVIHY29udGVudBIsCg'
    'hzdWJwYWdlcxgDIAMoCzIQLmdvb2dsZS5hcGkuUGFnZVIIc3VicGFnZXM=');
