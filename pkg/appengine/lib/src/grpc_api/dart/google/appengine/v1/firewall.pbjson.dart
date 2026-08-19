//
//  Generated code. Do not modify.
//  source: google/appengine/v1/firewall.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use firewallRuleDescriptor instead')
const FirewallRule$json = {
  '1': 'FirewallRule',
  '2': [
    {'1': 'priority', '3': 1, '4': 1, '5': 5, '10': 'priority'},
    {
      '1': 'action',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1.FirewallRule.Action',
      '10': 'action'
    },
    {'1': 'source_range', '3': 3, '4': 1, '5': 9, '10': 'sourceRange'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
  ],
  '4': [FirewallRule_Action$json],
};

@$core.Deprecated('Use firewallRuleDescriptor instead')
const FirewallRule_Action$json = {
  '1': 'Action',
  '2': [
    {'1': 'UNSPECIFIED_ACTION', '2': 0},
    {'1': 'ALLOW', '2': 1},
    {'1': 'DENY', '2': 2},
  ],
};

/// Descriptor for `FirewallRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List firewallRuleDescriptor = $convert.base64Decode(
    'CgxGaXJld2FsbFJ1bGUSGgoIcHJpb3JpdHkYASABKAVSCHByaW9yaXR5EkAKBmFjdGlvbhgCIA'
    'EoDjIoLmdvb2dsZS5hcHBlbmdpbmUudjEuRmlyZXdhbGxSdWxlLkFjdGlvblIGYWN0aW9uEiEK'
    'DHNvdXJjZV9yYW5nZRgDIAEoCVILc291cmNlUmFuZ2USIAoLZGVzY3JpcHRpb24YBCABKAlSC2'
    'Rlc2NyaXB0aW9uIjUKBkFjdGlvbhIWChJVTlNQRUNJRklFRF9BQ1RJT04QABIJCgVBTExPVxAB'
    'EggKBERFTlkQAg==');
