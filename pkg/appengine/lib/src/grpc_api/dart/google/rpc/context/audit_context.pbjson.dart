//
//  Generated code. Do not modify.
//  source: google/rpc/context/audit_context.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use auditContextDescriptor instead')
const AuditContext$json = {
  '1': 'AuditContext',
  '2': [
    {'1': 'audit_log', '3': 1, '4': 1, '5': 12, '10': 'auditLog'},
    {
      '1': 'scrubbed_request',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'scrubbedRequest'
    },
    {
      '1': 'scrubbed_response',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'scrubbedResponse'
    },
    {
      '1': 'scrubbed_response_item_count',
      '3': 4,
      '4': 1,
      '5': 5,
      '10': 'scrubbedResponseItemCount'
    },
    {'1': 'target_resource', '3': 5, '4': 1, '5': 9, '10': 'targetResource'},
  ],
};

/// Descriptor for `AuditContext`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List auditContextDescriptor = $convert.base64Decode(
    'CgxBdWRpdENvbnRleHQSGwoJYXVkaXRfbG9nGAEgASgMUghhdWRpdExvZxJCChBzY3J1YmJlZF'
    '9yZXF1ZXN0GAIgASgLMhcuZ29vZ2xlLnByb3RvYnVmLlN0cnVjdFIPc2NydWJiZWRSZXF1ZXN0'
    'EkQKEXNjcnViYmVkX3Jlc3BvbnNlGAMgASgLMhcuZ29vZ2xlLnByb3RvYnVmLlN0cnVjdFIQc2'
    'NydWJiZWRSZXNwb25zZRI/ChxzY3J1YmJlZF9yZXNwb25zZV9pdGVtX2NvdW50GAQgASgFUhlz'
    'Y3J1YmJlZFJlc3BvbnNlSXRlbUNvdW50EicKD3RhcmdldF9yZXNvdXJjZRgFIAEoCVIOdGFyZ2'
    'V0UmVzb3VyY2U=');
