//
//  Generated code. Do not modify.
//  source: google/rpc/http.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use httpRequestDescriptor instead')
const HttpRequest$json = {
  '1': 'HttpRequest',
  '2': [
    {'1': 'method', '3': 1, '4': 1, '5': 9, '10': 'method'},
    {'1': 'uri', '3': 2, '4': 1, '5': 9, '10': 'uri'},
    {
      '1': 'headers',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.rpc.HttpHeader',
      '10': 'headers'
    },
    {'1': 'body', '3': 4, '4': 1, '5': 12, '10': 'body'},
  ],
};

/// Descriptor for `HttpRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List httpRequestDescriptor = $convert.base64Decode(
    'CgtIdHRwUmVxdWVzdBIWCgZtZXRob2QYASABKAlSBm1ldGhvZBIQCgN1cmkYAiABKAlSA3VyaR'
    'IwCgdoZWFkZXJzGAMgAygLMhYuZ29vZ2xlLnJwYy5IdHRwSGVhZGVyUgdoZWFkZXJzEhIKBGJv'
    'ZHkYBCABKAxSBGJvZHk=');

@$core.Deprecated('Use httpResponseDescriptor instead')
const HttpResponse$json = {
  '1': 'HttpResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 5, '10': 'status'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    {
      '1': 'headers',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.rpc.HttpHeader',
      '10': 'headers'
    },
    {'1': 'body', '3': 4, '4': 1, '5': 12, '10': 'body'},
  ],
};

/// Descriptor for `HttpResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List httpResponseDescriptor = $convert.base64Decode(
    'CgxIdHRwUmVzcG9uc2USFgoGc3RhdHVzGAEgASgFUgZzdGF0dXMSFgoGcmVhc29uGAIgASgJUg'
    'ZyZWFzb24SMAoHaGVhZGVycxgDIAMoCzIWLmdvb2dsZS5ycGMuSHR0cEhlYWRlclIHaGVhZGVy'
    'cxISCgRib2R5GAQgASgMUgRib2R5');

@$core.Deprecated('Use httpHeaderDescriptor instead')
const HttpHeader$json = {
  '1': 'HttpHeader',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `HttpHeader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List httpHeaderDescriptor = $convert.base64Decode(
    'CgpIdHRwSGVhZGVyEhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZQ==');
