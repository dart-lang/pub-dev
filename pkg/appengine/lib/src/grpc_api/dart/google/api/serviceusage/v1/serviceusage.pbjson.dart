//
//  Generated code. Do not modify.
//  source: google/api/serviceusage/v1/serviceusage.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use enableServiceRequestDescriptor instead')
const EnableServiceRequest$json = {
  '1': 'EnableServiceRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `EnableServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableServiceRequestDescriptor = $convert
    .base64Decode('ChRFbmFibGVTZXJ2aWNlUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use enableServiceResponseDescriptor instead')
const EnableServiceResponse$json = {
  '1': 'EnableServiceResponse',
  '2': [
    {
      '1': 'service',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.serviceusage.v1.Service',
      '10': 'service'
    },
  ],
};

/// Descriptor for `EnableServiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableServiceResponseDescriptor = $convert.base64Decode(
    'ChVFbmFibGVTZXJ2aWNlUmVzcG9uc2USPQoHc2VydmljZRgBIAEoCzIjLmdvb2dsZS5hcGkuc2'
    'VydmljZXVzYWdlLnYxLlNlcnZpY2VSB3NlcnZpY2U=');

@$core.Deprecated('Use disableServiceRequestDescriptor instead')
const DisableServiceRequest$json = {
  '1': 'DisableServiceRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'disable_dependent_services',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'disableDependentServices'
    },
    {
      '1': 'check_if_service_has_usage',
      '3': 3,
      '4': 1,
      '5': 14,
      '6':
          '.google.api.serviceusage.v1.DisableServiceRequest.CheckIfServiceHasUsage',
      '10': 'checkIfServiceHasUsage'
    },
  ],
  '4': [DisableServiceRequest_CheckIfServiceHasUsage$json],
};

@$core.Deprecated('Use disableServiceRequestDescriptor instead')
const DisableServiceRequest_CheckIfServiceHasUsage$json = {
  '1': 'CheckIfServiceHasUsage',
  '2': [
    {'1': 'CHECK_IF_SERVICE_HAS_USAGE_UNSPECIFIED', '2': 0},
    {'1': 'SKIP', '2': 1},
    {'1': 'CHECK', '2': 2},
  ],
};

/// Descriptor for `DisableServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableServiceRequestDescriptor = $convert.base64Decode(
    'ChVEaXNhYmxlU2VydmljZVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRI8ChpkaXNhYmxlX2'
    'RlcGVuZGVudF9zZXJ2aWNlcxgCIAEoCFIYZGlzYWJsZURlcGVuZGVudFNlcnZpY2VzEoQBChpj'
    'aGVja19pZl9zZXJ2aWNlX2hhc191c2FnZRgDIAEoDjJILmdvb2dsZS5hcGkuc2VydmljZXVzYW'
    'dlLnYxLkRpc2FibGVTZXJ2aWNlUmVxdWVzdC5DaGVja0lmU2VydmljZUhhc1VzYWdlUhZjaGVj'
    'a0lmU2VydmljZUhhc1VzYWdlIlkKFkNoZWNrSWZTZXJ2aWNlSGFzVXNhZ2USKgomQ0hFQ0tfSU'
    'ZfU0VSVklDRV9IQVNfVVNBR0VfVU5TUEVDSUZJRUQQABIICgRTS0lQEAESCQoFQ0hFQ0sQAg==');

@$core.Deprecated('Use disableServiceResponseDescriptor instead')
const DisableServiceResponse$json = {
  '1': 'DisableServiceResponse',
  '2': [
    {
      '1': 'service',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.serviceusage.v1.Service',
      '10': 'service'
    },
  ],
};

/// Descriptor for `DisableServiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableServiceResponseDescriptor =
    $convert.base64Decode(
        'ChZEaXNhYmxlU2VydmljZVJlc3BvbnNlEj0KB3NlcnZpY2UYASABKAsyIy5nb29nbGUuYXBpLn'
        'NlcnZpY2V1c2FnZS52MS5TZXJ2aWNlUgdzZXJ2aWNl');

@$core.Deprecated('Use getServiceRequestDescriptor instead')
const GetServiceRequest$json = {
  '1': 'GetServiceRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GetServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getServiceRequestDescriptor = $convert
    .base64Decode('ChFHZXRTZXJ2aWNlUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use listServicesRequestDescriptor instead')
const ListServicesRequest$json = {
  '1': 'ListServicesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
    {'1': 'filter', '3': 4, '4': 1, '5': 9, '10': 'filter'},
  ],
};

/// Descriptor for `ListServicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listServicesRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0U2VydmljZXNSZXF1ZXN0EhYKBnBhcmVudBgBIAEoCVIGcGFyZW50EhsKCXBhZ2Vfc2'
    'l6ZRgCIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgDIAEoCVIJcGFnZVRva2VuEhYKBmZp'
    'bHRlchgEIAEoCVIGZmlsdGVy');

@$core.Deprecated('Use listServicesResponseDescriptor instead')
const ListServicesResponse$json = {
  '1': 'ListServicesResponse',
  '2': [
    {
      '1': 'services',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.serviceusage.v1.Service',
      '10': 'services'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListServicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listServicesResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0U2VydmljZXNSZXNwb25zZRI/CghzZXJ2aWNlcxgBIAMoCzIjLmdvb2dsZS5hcGkuc2'
    'VydmljZXVzYWdlLnYxLlNlcnZpY2VSCHNlcnZpY2VzEiYKD25leHRfcGFnZV90b2tlbhgCIAEo'
    'CVINbmV4dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use batchEnableServicesRequestDescriptor instead')
const BatchEnableServicesRequest$json = {
  '1': 'BatchEnableServicesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {'1': 'service_ids', '3': 2, '4': 3, '5': 9, '10': 'serviceIds'},
  ],
};

/// Descriptor for `BatchEnableServicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchEnableServicesRequestDescriptor =
    $convert.base64Decode(
        'ChpCYXRjaEVuYWJsZVNlcnZpY2VzUmVxdWVzdBIWCgZwYXJlbnQYASABKAlSBnBhcmVudBIfCg'
        'tzZXJ2aWNlX2lkcxgCIAMoCVIKc2VydmljZUlkcw==');

@$core.Deprecated('Use batchEnableServicesResponseDescriptor instead')
const BatchEnableServicesResponse$json = {
  '1': 'BatchEnableServicesResponse',
  '2': [
    {
      '1': 'services',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.serviceusage.v1.Service',
      '10': 'services'
    },
    {
      '1': 'failures',
      '3': 2,
      '4': 3,
      '5': 11,
      '6':
          '.google.api.serviceusage.v1.BatchEnableServicesResponse.EnableFailure',
      '10': 'failures'
    },
  ],
  '3': [BatchEnableServicesResponse_EnableFailure$json],
};

@$core.Deprecated('Use batchEnableServicesResponseDescriptor instead')
const BatchEnableServicesResponse_EnableFailure$json = {
  '1': 'EnableFailure',
  '2': [
    {'1': 'service_id', '3': 1, '4': 1, '5': 9, '10': 'serviceId'},
    {'1': 'error_message', '3': 2, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `BatchEnableServicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchEnableServicesResponseDescriptor = $convert.base64Decode(
    'ChtCYXRjaEVuYWJsZVNlcnZpY2VzUmVzcG9uc2USPwoIc2VydmljZXMYASADKAsyIy5nb29nbG'
    'UuYXBpLnNlcnZpY2V1c2FnZS52MS5TZXJ2aWNlUghzZXJ2aWNlcxJhCghmYWlsdXJlcxgCIAMo'
    'CzJFLmdvb2dsZS5hcGkuc2VydmljZXVzYWdlLnYxLkJhdGNoRW5hYmxlU2VydmljZXNSZXNwb2'
    '5zZS5FbmFibGVGYWlsdXJlUghmYWlsdXJlcxpTCg1FbmFibGVGYWlsdXJlEh0KCnNlcnZpY2Vf'
    'aWQYASABKAlSCXNlcnZpY2VJZBIjCg1lcnJvcl9tZXNzYWdlGAIgASgJUgxlcnJvck1lc3NhZ2'
    'U=');

@$core.Deprecated('Use batchGetServicesRequestDescriptor instead')
const BatchGetServicesRequest$json = {
  '1': 'BatchGetServicesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {'1': 'names', '3': 2, '4': 3, '5': 9, '10': 'names'},
  ],
};

/// Descriptor for `BatchGetServicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchGetServicesRequestDescriptor =
    $convert.base64Decode(
        'ChdCYXRjaEdldFNlcnZpY2VzUmVxdWVzdBIWCgZwYXJlbnQYASABKAlSBnBhcmVudBIUCgVuYW'
        '1lcxgCIAMoCVIFbmFtZXM=');

@$core.Deprecated('Use batchGetServicesResponseDescriptor instead')
const BatchGetServicesResponse$json = {
  '1': 'BatchGetServicesResponse',
  '2': [
    {
      '1': 'services',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.serviceusage.v1.Service',
      '10': 'services'
    },
  ],
};

/// Descriptor for `BatchGetServicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchGetServicesResponseDescriptor =
    $convert.base64Decode(
        'ChhCYXRjaEdldFNlcnZpY2VzUmVzcG9uc2USPwoIc2VydmljZXMYASADKAsyIy5nb29nbGUuYX'
        'BpLnNlcnZpY2V1c2FnZS52MS5TZXJ2aWNlUghzZXJ2aWNlcw==');
