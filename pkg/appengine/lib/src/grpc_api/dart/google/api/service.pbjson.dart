//
//  Generated code. Do not modify.
//  source: google/api/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use serviceDescriptor instead')
const Service$json = {
  '1': 'Service',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {
      '1': 'producer_project_id',
      '3': 22,
      '4': 1,
      '5': 9,
      '10': 'producerProjectId'
    },
    {'1': 'id', '3': 33, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'apis',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Api',
      '10': 'apis'
    },
    {
      '1': 'types',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Type',
      '10': 'types'
    },
    {
      '1': 'enums',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Enum',
      '10': 'enums'
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
      '1': 'backend',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.api.Backend',
      '10': 'backend'
    },
    {
      '1': 'http',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.api.Http',
      '10': 'http'
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
      '1': 'context',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.api.Context',
      '10': 'context'
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
      '1': 'control',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.google.api.Control',
      '10': 'control'
    },
    {
      '1': 'logs',
      '3': 23,
      '4': 3,
      '5': 11,
      '6': '.google.api.LogDescriptor',
      '10': 'logs'
    },
    {
      '1': 'metrics',
      '3': 24,
      '4': 3,
      '5': 11,
      '6': '.google.api.MetricDescriptor',
      '10': 'metrics'
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
      '1': 'billing',
      '3': 26,
      '4': 1,
      '5': 11,
      '6': '.google.api.Billing',
      '10': 'billing'
    },
    {
      '1': 'logging',
      '3': 27,
      '4': 1,
      '5': 11,
      '6': '.google.api.Logging',
      '10': 'logging'
    },
    {
      '1': 'monitoring',
      '3': 28,
      '4': 1,
      '5': 11,
      '6': '.google.api.Monitoring',
      '10': 'monitoring'
    },
    {
      '1': 'system_parameters',
      '3': 29,
      '4': 1,
      '5': 11,
      '6': '.google.api.SystemParameters',
      '10': 'systemParameters'
    },
    {
      '1': 'source_info',
      '3': 37,
      '4': 1,
      '5': 11,
      '6': '.google.api.SourceInfo',
      '10': 'sourceInfo'
    },
    {
      '1': 'publishing',
      '3': 45,
      '4': 1,
      '5': 11,
      '6': '.google.api.Publishing',
      '10': 'publishing'
    },
    {
      '1': 'config_version',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'configVersion'
    },
  ],
};

/// Descriptor for `Service`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceDescriptor = $convert.base64Decode(
    'CgdTZXJ2aWNlEhIKBG5hbWUYASABKAlSBG5hbWUSFAoFdGl0bGUYAiABKAlSBXRpdGxlEi4KE3'
    'Byb2R1Y2VyX3Byb2plY3RfaWQYFiABKAlSEXByb2R1Y2VyUHJvamVjdElkEg4KAmlkGCEgASgJ'
    'UgJpZBIoCgRhcGlzGAMgAygLMhQuZ29vZ2xlLnByb3RvYnVmLkFwaVIEYXBpcxIrCgV0eXBlcx'
    'gEIAMoCzIVLmdvb2dsZS5wcm90b2J1Zi5UeXBlUgV0eXBlcxIrCgVlbnVtcxgFIAMoCzIVLmdv'
    'b2dsZS5wcm90b2J1Zi5FbnVtUgVlbnVtcxI/Cg1kb2N1bWVudGF0aW9uGAYgASgLMhkuZ29vZ2'
    'xlLmFwaS5Eb2N1bWVudGF0aW9uUg1kb2N1bWVudGF0aW9uEi0KB2JhY2tlbmQYCCABKAsyEy5n'
    'b29nbGUuYXBpLkJhY2tlbmRSB2JhY2tlbmQSJAoEaHR0cBgJIAEoCzIQLmdvb2dsZS5hcGkuSH'
    'R0cFIEaHR0cBInCgVxdW90YRgKIAEoCzIRLmdvb2dsZS5hcGkuUXVvdGFSBXF1b3RhEkIKDmF1'
    'dGhlbnRpY2F0aW9uGAsgASgLMhouZ29vZ2xlLmFwaS5BdXRoZW50aWNhdGlvblIOYXV0aGVudG'
    'ljYXRpb24SLQoHY29udGV4dBgMIAEoCzITLmdvb2dsZS5hcGkuQ29udGV4dFIHY29udGV4dBIn'
    'CgV1c2FnZRgPIAEoCzIRLmdvb2dsZS5hcGkuVXNhZ2VSBXVzYWdlEjIKCWVuZHBvaW50cxgSIA'
    'MoCzIULmdvb2dsZS5hcGkuRW5kcG9pbnRSCWVuZHBvaW50cxItCgdjb250cm9sGBUgASgLMhMu'
    'Z29vZ2xlLmFwaS5Db250cm9sUgdjb250cm9sEi0KBGxvZ3MYFyADKAsyGS5nb29nbGUuYXBpLk'
    'xvZ0Rlc2NyaXB0b3JSBGxvZ3MSNgoHbWV0cmljcxgYIAMoCzIcLmdvb2dsZS5hcGkuTWV0cmlj'
    'RGVzY3JpcHRvclIHbWV0cmljcxJYChNtb25pdG9yZWRfcmVzb3VyY2VzGBkgAygLMicuZ29vZ2'
    'xlLmFwaS5Nb25pdG9yZWRSZXNvdXJjZURlc2NyaXB0b3JSEm1vbml0b3JlZFJlc291cmNlcxIt'
    'CgdiaWxsaW5nGBogASgLMhMuZ29vZ2xlLmFwaS5CaWxsaW5nUgdiaWxsaW5nEi0KB2xvZ2dpbm'
    'cYGyABKAsyEy5nb29nbGUuYXBpLkxvZ2dpbmdSB2xvZ2dpbmcSNgoKbW9uaXRvcmluZxgcIAEo'
    'CzIWLmdvb2dsZS5hcGkuTW9uaXRvcmluZ1IKbW9uaXRvcmluZxJJChFzeXN0ZW1fcGFyYW1ldG'
    'VycxgdIAEoCzIcLmdvb2dsZS5hcGkuU3lzdGVtUGFyYW1ldGVyc1IQc3lzdGVtUGFyYW1ldGVy'
    'cxI3Cgtzb3VyY2VfaW5mbxglIAEoCzIWLmdvb2dsZS5hcGkuU291cmNlSW5mb1IKc291cmNlSW'
    '5mbxI2CgpwdWJsaXNoaW5nGC0gASgLMhYuZ29vZ2xlLmFwaS5QdWJsaXNoaW5nUgpwdWJsaXNo'
    'aW5nEkMKDmNvbmZpZ192ZXJzaW9uGBQgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlVJbnQzMlZhbH'
    'VlUg1jb25maWdWZXJzaW9u');
