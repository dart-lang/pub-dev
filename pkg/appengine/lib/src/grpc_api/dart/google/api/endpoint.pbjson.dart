//
//  Generated code. Do not modify.
//  source: google/api/endpoint.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use endpointDescriptor instead')
const Endpoint$json = {
  '1': 'Endpoint',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'aliases', '3': 2, '4': 3, '5': 9, '10': 'aliases'},
    {'1': 'target', '3': 101, '4': 1, '5': 9, '10': 'target'},
    {'1': 'allow_cors', '3': 5, '4': 1, '5': 8, '10': 'allowCors'},
  ],
};

/// Descriptor for `Endpoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endpointDescriptor = $convert.base64Decode(
    'CghFbmRwb2ludBISCgRuYW1lGAEgASgJUgRuYW1lEhgKB2FsaWFzZXMYAiADKAlSB2FsaWFzZX'
    'MSFgoGdGFyZ2V0GGUgASgJUgZ0YXJnZXQSHQoKYWxsb3dfY29ycxgFIAEoCFIJYWxsb3dDb3Jz');
