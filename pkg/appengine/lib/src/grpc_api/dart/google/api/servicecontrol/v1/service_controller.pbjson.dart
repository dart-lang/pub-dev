//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/service_controller.proto
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
    {
      '1': 'operation',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.Operation',
      '10': 'operation'
    },
    {'1': 'service_config_id', '3': 4, '4': 1, '5': 9, '10': 'serviceConfigId'},
  ],
};

/// Descriptor for `CheckRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkRequestDescriptor = $convert.base64Decode(
    'CgxDaGVja1JlcXVlc3QSIQoMc2VydmljZV9uYW1lGAEgASgJUgtzZXJ2aWNlTmFtZRJFCglvcG'
    'VyYXRpb24YAiABKAsyJy5nb29nbGUuYXBpLnNlcnZpY2Vjb250cm9sLnYxLk9wZXJhdGlvblIJ'
    'b3BlcmF0aW9uEioKEXNlcnZpY2VfY29uZmlnX2lkGAQgASgJUg9zZXJ2aWNlQ29uZmlnSWQ=');

@$core.Deprecated('Use checkResponseDescriptor instead')
const CheckResponse$json = {
  '1': 'CheckResponse',
  '2': [
    {'1': 'operation_id', '3': 1, '4': 1, '5': 9, '10': 'operationId'},
    {
      '1': 'check_errors',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.CheckError',
      '10': 'checkErrors'
    },
    {'1': 'service_config_id', '3': 5, '4': 1, '5': 9, '10': 'serviceConfigId'},
    {
      '1': 'service_rollout_id',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'serviceRolloutId'
    },
    {
      '1': 'check_info',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.CheckResponse.CheckInfo',
      '10': 'checkInfo'
    },
  ],
  '3': [CheckResponse_CheckInfo$json, CheckResponse_ConsumerInfo$json],
};

@$core.Deprecated('Use checkResponseDescriptor instead')
const CheckResponse_CheckInfo$json = {
  '1': 'CheckInfo',
  '2': [
    {'1': 'unused_arguments', '3': 1, '4': 3, '5': 9, '10': 'unusedArguments'},
    {
      '1': 'consumer_info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.CheckResponse.ConsumerInfo',
      '10': 'consumerInfo'
    },
    {'1': 'api_key_uid', '3': 5, '4': 1, '5': 9, '10': 'apiKeyUid'},
  ],
};

@$core.Deprecated('Use checkResponseDescriptor instead')
const CheckResponse_ConsumerInfo$json = {
  '1': 'ConsumerInfo',
  '2': [
    {'1': 'project_number', '3': 1, '4': 1, '5': 3, '10': 'projectNumber'},
    {
      '1': 'type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6':
          '.google.api.servicecontrol.v1.CheckResponse.ConsumerInfo.ConsumerType',
      '10': 'type'
    },
    {'1': 'consumer_number', '3': 3, '4': 1, '5': 3, '10': 'consumerNumber'},
  ],
  '4': [CheckResponse_ConsumerInfo_ConsumerType$json],
};

@$core.Deprecated('Use checkResponseDescriptor instead')
const CheckResponse_ConsumerInfo_ConsumerType$json = {
  '1': 'ConsumerType',
  '2': [
    {'1': 'CONSUMER_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'PROJECT', '2': 1},
    {'1': 'FOLDER', '2': 2},
    {'1': 'ORGANIZATION', '2': 3},
    {'1': 'SERVICE_SPECIFIC', '2': 4},
  ],
};

/// Descriptor for `CheckResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkResponseDescriptor = $convert.base64Decode(
    'Cg1DaGVja1Jlc3BvbnNlEiEKDG9wZXJhdGlvbl9pZBgBIAEoCVILb3BlcmF0aW9uSWQSSwoMY2'
    'hlY2tfZXJyb3JzGAIgAygLMiguZ29vZ2xlLmFwaS5zZXJ2aWNlY29udHJvbC52MS5DaGVja0Vy'
    'cm9yUgtjaGVja0Vycm9ycxIqChFzZXJ2aWNlX2NvbmZpZ19pZBgFIAEoCVIPc2VydmljZUNvbm'
    'ZpZ0lkEiwKEnNlcnZpY2Vfcm9sbG91dF9pZBgLIAEoCVIQc2VydmljZVJvbGxvdXRJZBJUCgpj'
    'aGVja19pbmZvGAYgASgLMjUuZ29vZ2xlLmFwaS5zZXJ2aWNlY29udHJvbC52MS5DaGVja1Jlc3'
    'BvbnNlLkNoZWNrSW5mb1IJY2hlY2tJbmZvGrUBCglDaGVja0luZm8SKQoQdW51c2VkX2FyZ3Vt'
    'ZW50cxgBIAMoCVIPdW51c2VkQXJndW1lbnRzEl0KDWNvbnN1bWVyX2luZm8YAiABKAsyOC5nb2'
    '9nbGUuYXBpLnNlcnZpY2Vjb250cm9sLnYxLkNoZWNrUmVzcG9uc2UuQ29uc3VtZXJJbmZvUgxj'
    'b25zdW1lckluZm8SHgoLYXBpX2tleV91aWQYBSABKAlSCWFwaUtleVVpZBqpAgoMQ29uc3VtZX'
    'JJbmZvEiUKDnByb2plY3RfbnVtYmVyGAEgASgDUg1wcm9qZWN0TnVtYmVyElkKBHR5cGUYAiAB'
    'KA4yRS5nb29nbGUuYXBpLnNlcnZpY2Vjb250cm9sLnYxLkNoZWNrUmVzcG9uc2UuQ29uc3VtZX'
    'JJbmZvLkNvbnN1bWVyVHlwZVIEdHlwZRInCg9jb25zdW1lcl9udW1iZXIYAyABKANSDmNvbnN1'
    'bWVyTnVtYmVyIm4KDENvbnN1bWVyVHlwZRIdChlDT05TVU1FUl9UWVBFX1VOU1BFQ0lGSUVEEA'
    'ASCwoHUFJPSkVDVBABEgoKBkZPTERFUhACEhAKDE9SR0FOSVpBVElPThADEhQKEFNFUlZJQ0Vf'
    'U1BFQ0lGSUMQBA==');

@$core.Deprecated('Use reportRequestDescriptor instead')
const ReportRequest$json = {
  '1': 'ReportRequest',
  '2': [
    {'1': 'service_name', '3': 1, '4': 1, '5': 9, '10': 'serviceName'},
    {
      '1': 'operations',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.Operation',
      '10': 'operations'
    },
    {'1': 'service_config_id', '3': 3, '4': 1, '5': 9, '10': 'serviceConfigId'},
  ],
};

/// Descriptor for `ReportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reportRequestDescriptor = $convert.base64Decode(
    'Cg1SZXBvcnRSZXF1ZXN0EiEKDHNlcnZpY2VfbmFtZRgBIAEoCVILc2VydmljZU5hbWUSRwoKb3'
    'BlcmF0aW9ucxgCIAMoCzInLmdvb2dsZS5hcGkuc2VydmljZWNvbnRyb2wudjEuT3BlcmF0aW9u'
    'UgpvcGVyYXRpb25zEioKEXNlcnZpY2VfY29uZmlnX2lkGAMgASgJUg9zZXJ2aWNlQ29uZmlnSW'
    'Q=');

@$core.Deprecated('Use reportResponseDescriptor instead')
const ReportResponse$json = {
  '1': 'ReportResponse',
  '2': [
    {
      '1': 'report_errors',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.ReportResponse.ReportError',
      '10': 'reportErrors'
    },
    {'1': 'service_config_id', '3': 2, '4': 1, '5': 9, '10': 'serviceConfigId'},
    {
      '1': 'service_rollout_id',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'serviceRolloutId'
    },
  ],
  '3': [ReportResponse_ReportError$json],
};

@$core.Deprecated('Use reportResponseDescriptor instead')
const ReportResponse_ReportError$json = {
  '1': 'ReportError',
  '2': [
    {'1': 'operation_id', '3': 1, '4': 1, '5': 9, '10': 'operationId'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.rpc.Status',
      '10': 'status'
    },
  ],
};

/// Descriptor for `ReportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reportResponseDescriptor = $convert.base64Decode(
    'Cg5SZXBvcnRSZXNwb25zZRJdCg1yZXBvcnRfZXJyb3JzGAEgAygLMjguZ29vZ2xlLmFwaS5zZX'
    'J2aWNlY29udHJvbC52MS5SZXBvcnRSZXNwb25zZS5SZXBvcnRFcnJvclIMcmVwb3J0RXJyb3Jz'
    'EioKEXNlcnZpY2VfY29uZmlnX2lkGAIgASgJUg9zZXJ2aWNlQ29uZmlnSWQSLAoSc2VydmljZV'
    '9yb2xsb3V0X2lkGAQgASgJUhBzZXJ2aWNlUm9sbG91dElkGlwKC1JlcG9ydEVycm9yEiEKDG9w'
    'ZXJhdGlvbl9pZBgBIAEoCVILb3BlcmF0aW9uSWQSKgoGc3RhdHVzGAIgASgLMhIuZ29vZ2xlLn'
    'JwYy5TdGF0dXNSBnN0YXR1cw==');
