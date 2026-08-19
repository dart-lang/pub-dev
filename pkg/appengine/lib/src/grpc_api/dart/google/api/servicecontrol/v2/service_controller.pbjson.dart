//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v2/service_controller.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use checkRequestDescriptor instead')
const CheckRequest$json = {
  '1': 'CheckRequest',
  '2': [
    {'1': 'service_name', '3': 1, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'service_config_id', '3': 2, '4': 1, '5': 9, '10': 'serviceConfigId'},
    {
      '1': 'attributes',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.rpc.context.AttributeContext',
      '10': 'attributes'
    },
    {
      '1': 'resources',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.api.servicecontrol.v2.ResourceInfo',
      '10': 'resources'
    },
    {'1': 'flags', '3': 5, '4': 1, '5': 9, '10': 'flags'},
  ],
};

/// Descriptor for `CheckRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkRequestDescriptor = $convert.base64Decode(
    'CgxDaGVja1JlcXVlc3QSIQoMc2VydmljZV9uYW1lGAEgASgJUgtzZXJ2aWNlTmFtZRIqChFzZX'
    'J2aWNlX2NvbmZpZ19pZBgCIAEoCVIPc2VydmljZUNvbmZpZ0lkEkQKCmF0dHJpYnV0ZXMYAyAB'
    'KAsyJC5nb29nbGUucnBjLmNvbnRleHQuQXR0cmlidXRlQ29udGV4dFIKYXR0cmlidXRlcxJICg'
    'lyZXNvdXJjZXMYBCADKAsyKi5nb29nbGUuYXBpLnNlcnZpY2Vjb250cm9sLnYyLlJlc291cmNl'
    'SW5mb1IJcmVzb3VyY2VzEhQKBWZsYWdzGAUgASgJUgVmbGFncw==');

@$core.Deprecated('Use resourceInfoDescriptor instead')
const ResourceInfo$json = {
  '1': 'ResourceInfo',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {'1': 'permission', '3': 3, '4': 1, '5': 9, '10': 'permission'},
    {'1': 'container', '3': 4, '4': 1, '5': 9, '10': 'container'},
    {'1': 'location', '3': 5, '4': 1, '5': 9, '10': 'location'},
  ],
};

/// Descriptor for `ResourceInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resourceInfoDescriptor = $convert.base64Decode(
    'CgxSZXNvdXJjZUluZm8SEgoEbmFtZRgBIAEoCVIEbmFtZRISCgR0eXBlGAIgASgJUgR0eXBlEh'
    '4KCnBlcm1pc3Npb24YAyABKAlSCnBlcm1pc3Npb24SHAoJY29udGFpbmVyGAQgASgJUgljb250'
    'YWluZXISGgoIbG9jYXRpb24YBSABKAlSCGxvY2F0aW9u');

@$core.Deprecated('Use checkResponseDescriptor instead')
const CheckResponse$json = {
  '1': 'CheckResponse',
  '2': [
    {
      '1': 'status',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.rpc.Status',
      '10': 'status'
    },
    {
      '1': 'headers',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.servicecontrol.v2.CheckResponse.HeadersEntry',
      '10': 'headers'
    },
  ],
  '3': [CheckResponse_HeadersEntry$json],
};

@$core.Deprecated('Use checkResponseDescriptor instead')
const CheckResponse_HeadersEntry$json = {
  '1': 'HeadersEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `CheckResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkResponseDescriptor = $convert.base64Decode(
    'Cg1DaGVja1Jlc3BvbnNlEioKBnN0YXR1cxgBIAEoCzISLmdvb2dsZS5ycGMuU3RhdHVzUgZzdG'
    'F0dXMSUgoHaGVhZGVycxgCIAMoCzI4Lmdvb2dsZS5hcGkuc2VydmljZWNvbnRyb2wudjIuQ2hl'
    'Y2tSZXNwb25zZS5IZWFkZXJzRW50cnlSB2hlYWRlcnMaOgoMSGVhZGVyc0VudHJ5EhAKA2tleR'
    'gBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use reportRequestDescriptor instead')
const ReportRequest$json = {
  '1': 'ReportRequest',
  '2': [
    {'1': 'service_name', '3': 1, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'service_config_id', '3': 2, '4': 1, '5': 9, '10': 'serviceConfigId'},
    {
      '1': 'operations',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.rpc.context.AttributeContext',
      '10': 'operations'
    },
  ],
};

/// Descriptor for `ReportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reportRequestDescriptor = $convert.base64Decode(
    'Cg1SZXBvcnRSZXF1ZXN0EiEKDHNlcnZpY2VfbmFtZRgBIAEoCVILc2VydmljZU5hbWUSKgoRc2'
    'VydmljZV9jb25maWdfaWQYAiABKAlSD3NlcnZpY2VDb25maWdJZBJECgpvcGVyYXRpb25zGAMg'
    'AygLMiQuZ29vZ2xlLnJwYy5jb250ZXh0LkF0dHJpYnV0ZUNvbnRleHRSCm9wZXJhdGlvbnM=');

@$core.Deprecated('Use reportResponseDescriptor instead')
const ReportResponse$json = {
  '1': 'ReportResponse',
};

/// Descriptor for `ReportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reportResponseDescriptor =
    $convert.base64Decode('Cg5SZXBvcnRSZXNwb25zZQ==');

@$core.Deprecated('Use resourceInfoListDescriptor instead')
const ResourceInfoList$json = {
  '1': 'ResourceInfoList',
  '2': [
    {
      '1': 'resources',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.servicecontrol.v2.ResourceInfo',
      '10': 'resources'
    },
  ],
};

/// Descriptor for `ResourceInfoList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resourceInfoListDescriptor = $convert.base64Decode(
    'ChBSZXNvdXJjZUluZm9MaXN0EkgKCXJlc291cmNlcxgBIAMoCzIqLmdvb2dsZS5hcGkuc2Vydm'
    'ljZWNvbnRyb2wudjIuUmVzb3VyY2VJbmZvUglyZXNvdXJjZXM=');
