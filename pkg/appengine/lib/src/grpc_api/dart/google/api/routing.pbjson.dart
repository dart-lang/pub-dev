//
//  Generated code. Do not modify.
//  source: google/api/routing.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use routingRuleDescriptor instead')
const RoutingRule$json = {
  '1': 'RoutingRule',
  '2': [
    {
      '1': 'routing_parameters',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.RoutingParameter',
      '10': 'routingParameters'
    },
  ],
};

/// Descriptor for `RoutingRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routingRuleDescriptor = $convert.base64Decode(
    'CgtSb3V0aW5nUnVsZRJLChJyb3V0aW5nX3BhcmFtZXRlcnMYAiADKAsyHC5nb29nbGUuYXBpLl'
    'JvdXRpbmdQYXJhbWV0ZXJSEXJvdXRpbmdQYXJhbWV0ZXJz');

@$core.Deprecated('Use routingParameterDescriptor instead')
const RoutingParameter$json = {
  '1': 'RoutingParameter',
  '2': [
    {'1': 'field', '3': 1, '4': 1, '5': 9, '10': 'field'},
    {'1': 'path_template', '3': 2, '4': 1, '5': 9, '10': 'pathTemplate'},
  ],
};

/// Descriptor for `RoutingParameter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routingParameterDescriptor = $convert.base64Decode(
    'ChBSb3V0aW5nUGFyYW1ldGVyEhQKBWZpZWxkGAEgASgJUgVmaWVsZBIjCg1wYXRoX3RlbXBsYX'
    'RlGAIgASgJUgxwYXRoVGVtcGxhdGU=');
