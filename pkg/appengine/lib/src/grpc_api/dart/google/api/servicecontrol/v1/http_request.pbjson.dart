//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/http_request.proto
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
    {'1': 'request_method', '3': 1, '4': 1, '5': 9, '10': 'requestMethod'},
    {'1': 'request_url', '3': 2, '4': 1, '5': 9, '10': 'requestUrl'},
    {'1': 'request_size', '3': 3, '4': 1, '5': 3, '10': 'requestSize'},
    {'1': 'status', '3': 4, '4': 1, '5': 5, '10': 'status'},
    {'1': 'response_size', '3': 5, '4': 1, '5': 3, '10': 'responseSize'},
    {'1': 'user_agent', '3': 6, '4': 1, '5': 9, '10': 'userAgent'},
    {'1': 'remote_ip', '3': 7, '4': 1, '5': 9, '10': 'remoteIp'},
    {'1': 'server_ip', '3': 13, '4': 1, '5': 9, '10': 'serverIp'},
    {'1': 'referer', '3': 8, '4': 1, '5': 9, '10': 'referer'},
    {
      '1': 'latency',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'latency'
    },
    {'1': 'cache_lookup', '3': 11, '4': 1, '5': 8, '10': 'cacheLookup'},
    {'1': 'cache_hit', '3': 9, '4': 1, '5': 8, '10': 'cacheHit'},
    {
      '1': 'cache_validated_with_origin_server',
      '3': 10,
      '4': 1,
      '5': 8,
      '10': 'cacheValidatedWithOriginServer'
    },
    {'1': 'cache_fill_bytes', '3': 12, '4': 1, '5': 3, '10': 'cacheFillBytes'},
    {'1': 'protocol', '3': 15, '4': 1, '5': 9, '10': 'protocol'},
  ],
};

/// Descriptor for `HttpRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List httpRequestDescriptor = $convert.base64Decode(
    'CgtIdHRwUmVxdWVzdBIlCg5yZXF1ZXN0X21ldGhvZBgBIAEoCVINcmVxdWVzdE1ldGhvZBIfCg'
    'tyZXF1ZXN0X3VybBgCIAEoCVIKcmVxdWVzdFVybBIhCgxyZXF1ZXN0X3NpemUYAyABKANSC3Jl'
    'cXVlc3RTaXplEhYKBnN0YXR1cxgEIAEoBVIGc3RhdHVzEiMKDXJlc3BvbnNlX3NpemUYBSABKA'
    'NSDHJlc3BvbnNlU2l6ZRIdCgp1c2VyX2FnZW50GAYgASgJUgl1c2VyQWdlbnQSGwoJcmVtb3Rl'
    'X2lwGAcgASgJUghyZW1vdGVJcBIbCglzZXJ2ZXJfaXAYDSABKAlSCHNlcnZlcklwEhgKB3JlZm'
    'VyZXIYCCABKAlSB3JlZmVyZXISMwoHbGF0ZW5jeRgOIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5E'
    'dXJhdGlvblIHbGF0ZW5jeRIhCgxjYWNoZV9sb29rdXAYCyABKAhSC2NhY2hlTG9va3VwEhsKCW'
    'NhY2hlX2hpdBgJIAEoCFIIY2FjaGVIaXQSSgoiY2FjaGVfdmFsaWRhdGVkX3dpdGhfb3JpZ2lu'
    'X3NlcnZlchgKIAEoCFIeY2FjaGVWYWxpZGF0ZWRXaXRoT3JpZ2luU2VydmVyEigKEGNhY2hlX2'
    'ZpbGxfYnl0ZXMYDCABKANSDmNhY2hlRmlsbEJ5dGVzEhoKCHByb3RvY29sGA8gASgJUghwcm90'
    'b2NvbA==');
