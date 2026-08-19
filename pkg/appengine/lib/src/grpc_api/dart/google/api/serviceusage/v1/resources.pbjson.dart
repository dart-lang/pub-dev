//
//  Generated code. Do not modify.
//  source: google/api/serviceusage/v1/resources.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use stateDescriptor instead')
const State$json = {
  '1': 'State',
  '2': [
    {'1': 'STATE_UNSPECIFIED', '2': 0},
    {'1': 'DISABLED', '2': 1},
    {'1': 'ENABLED', '2': 2},
  ],
};

/// Descriptor for `State`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List stateDescriptor = $convert.base64Decode(
    'CgVTdGF0ZRIVChFTVEFURV9VTlNQRUNJRklFRBAAEgwKCERJU0FCTEVEEAESCwoHRU5BQkxFRB'
    'AC');

@$core.Deprecated('Use serviceDescriptor instead')
const Service$json = {
  '1': 'Service',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'parent', '3': 5, '4': 1, '5': 9, '10': 'parent'},
    {
      '1': 'config',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.serviceusage.v1.ServiceConfig',
      '10': 'config'
    },
    {
      '1': 'state',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.api.serviceusage.v1.State',
      '10': 'state'
    },
  ],
  '7': {},
};

/// Descriptor for `Service`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceDescriptor = $convert.base64Decode(
    'CgdTZXJ2aWNlEhIKBG5hbWUYASABKAlSBG5hbWUSFgoGcGFyZW50GAUgASgJUgZwYXJlbnQSQQ'
    'oGY29uZmlnGAIgASgLMikuZ29vZ2xlLmFwaS5zZXJ2aWNldXNhZ2UudjEuU2VydmljZUNvbmZp'
    'Z1IGY29uZmlnEjcKBXN0YXRlGAQgASgOMiEuZ29vZ2xlLmFwaS5zZXJ2aWNldXNhZ2UudjEuU3'
    'RhdGVSBXN0YXRlOqYB6kGiAQojc2VydmljZXVzYWdlLmdvb2dsZWFwaXMuY29tL1NlcnZpY2US'
    'JXByb2plY3RzL3twcm9qZWN0fS9zZXJ2aWNlcy97c2VydmljZX0SI2ZvbGRlcnMve2ZvbGRlcn'
    '0vc2VydmljZXMve3NlcnZpY2V9Ei9vcmdhbml6YXRpb25zL3tvcmdhbml6YXRpb259L3NlcnZp'
    'Y2VzL3tzZXJ2aWNlfQ==');

@$core.Deprecated('Use serviceConfigDescriptor instead')
const ServiceConfig$json = {
  '1': 'ServiceConfig',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {
      '1': 'apis',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Api',
      '10': 'apis'
    },
    {
      '1': 'documentation',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.api.Documentation',
      '10': 'documentation'
    },
    {
      '1': 'quota',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.api.Quota',
      '10': 'quota'
    },
    {
      '1': 'authentication',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.api.Authentication',
      '10': 'authentication'
    },
    {
      '1': 'usage',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.api.Usage',
      '10': 'usage'
    },
    {
      '1': 'endpoints',
      '3': 18,
      '4': 3,
      '5': 11,
      '6': '.google.api.Endpoint',
      '10': 'endpoints'
    },
    {
      '1': 'monitored_resources',
      '3': 25,
      '4': 3,
      '5': 11,
      '6': '.google.api.MonitoredResourceDescriptor',
      '10': 'monitoredResources'
    },
    {
      '1': 'monitoring',
      '3': 28,
      '4': 1,
      '5': 11,
      '6': '.google.api.Monitoring',
      '10': 'monitoring'
    },
  ],
};

/// Descriptor for `ServiceConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceConfigDescriptor = $convert.base64Decode(
    'Cg1TZXJ2aWNlQ29uZmlnEhIKBG5hbWUYASABKAlSBG5hbWUSFAoFdGl0bGUYAiABKAlSBXRpdG'
    'xlEigKBGFwaXMYAyADKAsyFC5nb29nbGUucHJvdG9idWYuQXBpUgRhcGlzEj8KDWRvY3VtZW50'
    'YXRpb24YBiABKAsyGS5nb29nbGUuYXBpLkRvY3VtZW50YXRpb25SDWRvY3VtZW50YXRpb24SJw'
    'oFcXVvdGEYCiABKAsyES5nb29nbGUuYXBpLlF1b3RhUgVxdW90YRJCCg5hdXRoZW50aWNhdGlv'
    'bhgLIAEoCzIaLmdvb2dsZS5hcGkuQXV0aGVudGljYXRpb25SDmF1dGhlbnRpY2F0aW9uEicKBX'
    'VzYWdlGA8gASgLMhEuZ29vZ2xlLmFwaS5Vc2FnZVIFdXNhZ2USMgoJZW5kcG9pbnRzGBIgAygL'
    'MhQuZ29vZ2xlLmFwaS5FbmRwb2ludFIJZW5kcG9pbnRzElgKE21vbml0b3JlZF9yZXNvdXJjZX'
    'MYGSADKAsyJy5nb29nbGUuYXBpLk1vbml0b3JlZFJlc291cmNlRGVzY3JpcHRvclISbW9uaXRv'
    'cmVkUmVzb3VyY2VzEjYKCm1vbml0b3JpbmcYHCABKAsyFi5nb29nbGUuYXBpLk1vbml0b3Jpbm'
    'dSCm1vbml0b3Jpbmc=');

@$core.Deprecated('Use operationMetadataDescriptor instead')
const OperationMetadata$json = {
  '1': 'OperationMetadata',
  '2': [
    {'1': 'resource_names', '3': 2, '4': 3, '5': 9, '10': 'resourceNames'},
  ],
};

/// Descriptor for `OperationMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List operationMetadataDescriptor = $convert.base64Decode(
    'ChFPcGVyYXRpb25NZXRhZGF0YRIlCg5yZXNvdXJjZV9uYW1lcxgCIAMoCVINcmVzb3VyY2VOYW'
    '1lcw==');
