//
//  Generated code. Do not modify.
//  source: google/api/serviceusage/v1beta1/serviceusage.proto
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

@$core.Deprecated('Use disableServiceRequestDescriptor instead')
const DisableServiceRequest$json = {
  '1': 'DisableServiceRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DisableServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableServiceRequestDescriptor =
    $convert.base64Decode(
        'ChVEaXNhYmxlU2VydmljZVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

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
      '6': '.google.api.serviceusage.v1beta1.Service',
      '10': 'services'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListServicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listServicesResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0U2VydmljZXNSZXNwb25zZRJECghzZXJ2aWNlcxgBIAMoCzIoLmdvb2dsZS5hcGkuc2'
    'VydmljZXVzYWdlLnYxYmV0YTEuU2VydmljZVIIc2VydmljZXMSJgoPbmV4dF9wYWdlX3Rva2Vu'
    'GAIgASgJUg1uZXh0UGFnZVRva2Vu');

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

@$core.Deprecated('Use listConsumerQuotaMetricsRequestDescriptor instead')
const ListConsumerQuotaMetricsRequest$json = {
  '1': 'ListConsumerQuotaMetricsRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
    {
      '1': 'view',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.api.serviceusage.v1beta1.QuotaView',
      '10': 'view'
    },
  ],
};

/// Descriptor for `ListConsumerQuotaMetricsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listConsumerQuotaMetricsRequestDescriptor =
    $convert.base64Decode(
        'Ch9MaXN0Q29uc3VtZXJRdW90YU1ldHJpY3NSZXF1ZXN0EhYKBnBhcmVudBgBIAEoCVIGcGFyZW'
        '50EhsKCXBhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgDIAEoCVIJcGFn'
        'ZVRva2VuEj4KBHZpZXcYBCABKA4yKi5nb29nbGUuYXBpLnNlcnZpY2V1c2FnZS52MWJldGExLl'
        'F1b3RhVmlld1IEdmlldw==');

@$core.Deprecated('Use listConsumerQuotaMetricsResponseDescriptor instead')
const ListConsumerQuotaMetricsResponse$json = {
  '1': 'ListConsumerQuotaMetricsResponse',
  '2': [
    {
      '1': 'metrics',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.ConsumerQuotaMetric',
      '10': 'metrics'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListConsumerQuotaMetricsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listConsumerQuotaMetricsResponseDescriptor =
    $convert.base64Decode(
        'CiBMaXN0Q29uc3VtZXJRdW90YU1ldHJpY3NSZXNwb25zZRJOCgdtZXRyaWNzGAEgAygLMjQuZ2'
        '9vZ2xlLmFwaS5zZXJ2aWNldXNhZ2UudjFiZXRhMS5Db25zdW1lclF1b3RhTWV0cmljUgdtZXRy'
        'aWNzEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use getConsumerQuotaMetricRequestDescriptor instead')
const GetConsumerQuotaMetricRequest$json = {
  '1': 'GetConsumerQuotaMetricRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'view',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.api.serviceusage.v1beta1.QuotaView',
      '10': 'view'
    },
  ],
};

/// Descriptor for `GetConsumerQuotaMetricRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getConsumerQuotaMetricRequestDescriptor =
    $convert.base64Decode(
        'Ch1HZXRDb25zdW1lclF1b3RhTWV0cmljUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEj4KBH'
        'ZpZXcYAiABKA4yKi5nb29nbGUuYXBpLnNlcnZpY2V1c2FnZS52MWJldGExLlF1b3RhVmlld1IE'
        'dmlldw==');

@$core.Deprecated('Use getConsumerQuotaLimitRequestDescriptor instead')
const GetConsumerQuotaLimitRequest$json = {
  '1': 'GetConsumerQuotaLimitRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'view',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.api.serviceusage.v1beta1.QuotaView',
      '10': 'view'
    },
  ],
};

/// Descriptor for `GetConsumerQuotaLimitRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getConsumerQuotaLimitRequestDescriptor =
    $convert.base64Decode(
        'ChxHZXRDb25zdW1lclF1b3RhTGltaXRSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSPgoEdm'
        'lldxgCIAEoDjIqLmdvb2dsZS5hcGkuc2VydmljZXVzYWdlLnYxYmV0YTEuUXVvdGFWaWV3UgR2'
        'aWV3');

@$core.Deprecated('Use createAdminOverrideRequestDescriptor instead')
const CreateAdminOverrideRequest$json = {
  '1': 'CreateAdminOverrideRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {
      '1': 'override',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.QuotaOverride',
      '10': 'override'
    },
    {'1': 'force', '3': 3, '4': 1, '5': 8, '10': 'force'},
    {
      '1': 'force_only',
      '3': 4,
      '4': 3,
      '5': 14,
      '6': '.google.api.serviceusage.v1beta1.QuotaSafetyCheck',
      '10': 'forceOnly'
    },
  ],
};

/// Descriptor for `CreateAdminOverrideRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAdminOverrideRequestDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVBZG1pbk92ZXJyaWRlUmVxdWVzdBIWCgZwYXJlbnQYASABKAlSBnBhcmVudBJKCg'
    'hvdmVycmlkZRgCIAEoCzIuLmdvb2dsZS5hcGkuc2VydmljZXVzYWdlLnYxYmV0YTEuUXVvdGFP'
    'dmVycmlkZVIIb3ZlcnJpZGUSFAoFZm9yY2UYAyABKAhSBWZvcmNlElAKCmZvcmNlX29ubHkYBC'
    'ADKA4yMS5nb29nbGUuYXBpLnNlcnZpY2V1c2FnZS52MWJldGExLlF1b3RhU2FmZXR5Q2hlY2tS'
    'CWZvcmNlT25seQ==');

@$core.Deprecated('Use updateAdminOverrideRequestDescriptor instead')
const UpdateAdminOverrideRequest$json = {
  '1': 'UpdateAdminOverrideRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'override',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.QuotaOverride',
      '10': 'override'
    },
    {'1': 'force', '3': 3, '4': 1, '5': 8, '10': 'force'},
    {
      '1': 'update_mask',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
    {
      '1': 'force_only',
      '3': 5,
      '4': 3,
      '5': 14,
      '6': '.google.api.serviceusage.v1beta1.QuotaSafetyCheck',
      '10': 'forceOnly'
    },
  ],
};

/// Descriptor for `UpdateAdminOverrideRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAdminOverrideRequestDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVBZG1pbk92ZXJyaWRlUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEkoKCG92ZX'
    'JyaWRlGAIgASgLMi4uZ29vZ2xlLmFwaS5zZXJ2aWNldXNhZ2UudjFiZXRhMS5RdW90YU92ZXJy'
    'aWRlUghvdmVycmlkZRIUCgVmb3JjZRgDIAEoCFIFZm9yY2USOwoLdXBkYXRlX21hc2sYBCABKA'
    'syGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrUgp1cGRhdGVNYXNrElAKCmZvcmNlX29ubHkY'
    'BSADKA4yMS5nb29nbGUuYXBpLnNlcnZpY2V1c2FnZS52MWJldGExLlF1b3RhU2FmZXR5Q2hlY2'
    'tSCWZvcmNlT25seQ==');

@$core.Deprecated('Use deleteAdminOverrideRequestDescriptor instead')
const DeleteAdminOverrideRequest$json = {
  '1': 'DeleteAdminOverrideRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'force', '3': 2, '4': 1, '5': 8, '10': 'force'},
    {
      '1': 'force_only',
      '3': 3,
      '4': 3,
      '5': 14,
      '6': '.google.api.serviceusage.v1beta1.QuotaSafetyCheck',
      '10': 'forceOnly'
    },
  ],
};

/// Descriptor for `DeleteAdminOverrideRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAdminOverrideRequestDescriptor =
    $convert.base64Decode(
        'ChpEZWxldGVBZG1pbk92ZXJyaWRlUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEhQKBWZvcm'
        'NlGAIgASgIUgVmb3JjZRJQCgpmb3JjZV9vbmx5GAMgAygOMjEuZ29vZ2xlLmFwaS5zZXJ2aWNl'
        'dXNhZ2UudjFiZXRhMS5RdW90YVNhZmV0eUNoZWNrUglmb3JjZU9ubHk=');

@$core.Deprecated('Use listAdminOverridesRequestDescriptor instead')
const ListAdminOverridesRequest$json = {
  '1': 'ListAdminOverridesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListAdminOverridesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAdminOverridesRequestDescriptor = $convert.base64Decode(
    'ChlMaXN0QWRtaW5PdmVycmlkZXNSZXF1ZXN0EhYKBnBhcmVudBgBIAEoCVIGcGFyZW50EhsKCX'
    'BhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgDIAEoCVIJcGFnZVRva2Vu');

@$core.Deprecated('Use listAdminOverridesResponseDescriptor instead')
const ListAdminOverridesResponse$json = {
  '1': 'ListAdminOverridesResponse',
  '2': [
    {
      '1': 'overrides',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.QuotaOverride',
      '10': 'overrides'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListAdminOverridesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAdminOverridesResponseDescriptor =
    $convert.base64Decode(
        'ChpMaXN0QWRtaW5PdmVycmlkZXNSZXNwb25zZRJMCglvdmVycmlkZXMYASADKAsyLi5nb29nbG'
        'UuYXBpLnNlcnZpY2V1c2FnZS52MWJldGExLlF1b3RhT3ZlcnJpZGVSCW92ZXJyaWRlcxImCg9u'
        'ZXh0X3BhZ2VfdG9rZW4YAiABKAlSDW5leHRQYWdlVG9rZW4=');

@$core.Deprecated('Use batchCreateAdminOverridesResponseDescriptor instead')
const BatchCreateAdminOverridesResponse$json = {
  '1': 'BatchCreateAdminOverridesResponse',
  '2': [
    {
      '1': 'overrides',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.QuotaOverride',
      '10': 'overrides'
    },
  ],
};

/// Descriptor for `BatchCreateAdminOverridesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchCreateAdminOverridesResponseDescriptor =
    $convert.base64Decode(
        'CiFCYXRjaENyZWF0ZUFkbWluT3ZlcnJpZGVzUmVzcG9uc2USTAoJb3ZlcnJpZGVzGAEgAygLMi'
        '4uZ29vZ2xlLmFwaS5zZXJ2aWNldXNhZ2UudjFiZXRhMS5RdW90YU92ZXJyaWRlUglvdmVycmlk'
        'ZXM=');

@$core.Deprecated('Use importAdminOverridesRequestDescriptor instead')
const ImportAdminOverridesRequest$json = {
  '1': 'ImportAdminOverridesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {
      '1': 'inline_source',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.OverrideInlineSource',
      '9': 0,
      '10': 'inlineSource'
    },
    {'1': 'force', '3': 3, '4': 1, '5': 8, '10': 'force'},
    {
      '1': 'force_only',
      '3': 4,
      '4': 3,
      '5': 14,
      '6': '.google.api.serviceusage.v1beta1.QuotaSafetyCheck',
      '10': 'forceOnly'
    },
  ],
  '8': [
    {'1': 'source'},
  ],
};

/// Descriptor for `ImportAdminOverridesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importAdminOverridesRequestDescriptor = $convert.base64Decode(
    'ChtJbXBvcnRBZG1pbk92ZXJyaWRlc1JlcXVlc3QSFgoGcGFyZW50GAEgASgJUgZwYXJlbnQSXA'
    'oNaW5saW5lX3NvdXJjZRgCIAEoCzI1Lmdvb2dsZS5hcGkuc2VydmljZXVzYWdlLnYxYmV0YTEu'
    'T3ZlcnJpZGVJbmxpbmVTb3VyY2VIAFIMaW5saW5lU291cmNlEhQKBWZvcmNlGAMgASgIUgVmb3'
    'JjZRJQCgpmb3JjZV9vbmx5GAQgAygOMjEuZ29vZ2xlLmFwaS5zZXJ2aWNldXNhZ2UudjFiZXRh'
    'MS5RdW90YVNhZmV0eUNoZWNrUglmb3JjZU9ubHlCCAoGc291cmNl');

@$core.Deprecated('Use importAdminOverridesResponseDescriptor instead')
const ImportAdminOverridesResponse$json = {
  '1': 'ImportAdminOverridesResponse',
  '2': [
    {
      '1': 'overrides',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.QuotaOverride',
      '10': 'overrides'
    },
  ],
};

/// Descriptor for `ImportAdminOverridesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importAdminOverridesResponseDescriptor =
    $convert.base64Decode(
        'ChxJbXBvcnRBZG1pbk92ZXJyaWRlc1Jlc3BvbnNlEkwKCW92ZXJyaWRlcxgBIAMoCzIuLmdvb2'
        'dsZS5hcGkuc2VydmljZXVzYWdlLnYxYmV0YTEuUXVvdGFPdmVycmlkZVIJb3ZlcnJpZGVz');

@$core.Deprecated('Use importAdminOverridesMetadataDescriptor instead')
const ImportAdminOverridesMetadata$json = {
  '1': 'ImportAdminOverridesMetadata',
};

/// Descriptor for `ImportAdminOverridesMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importAdminOverridesMetadataDescriptor =
    $convert.base64Decode('ChxJbXBvcnRBZG1pbk92ZXJyaWRlc01ldGFkYXRh');

@$core.Deprecated('Use createConsumerOverrideRequestDescriptor instead')
const CreateConsumerOverrideRequest$json = {
  '1': 'CreateConsumerOverrideRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {
      '1': 'override',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.QuotaOverride',
      '10': 'override'
    },
    {'1': 'force', '3': 3, '4': 1, '5': 8, '10': 'force'},
    {
      '1': 'force_only',
      '3': 4,
      '4': 3,
      '5': 14,
      '6': '.google.api.serviceusage.v1beta1.QuotaSafetyCheck',
      '10': 'forceOnly'
    },
  ],
};

/// Descriptor for `CreateConsumerOverrideRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createConsumerOverrideRequestDescriptor = $convert.base64Decode(
    'Ch1DcmVhdGVDb25zdW1lck92ZXJyaWRlUmVxdWVzdBIWCgZwYXJlbnQYASABKAlSBnBhcmVudB'
    'JKCghvdmVycmlkZRgCIAEoCzIuLmdvb2dsZS5hcGkuc2VydmljZXVzYWdlLnYxYmV0YTEuUXVv'
    'dGFPdmVycmlkZVIIb3ZlcnJpZGUSFAoFZm9yY2UYAyABKAhSBWZvcmNlElAKCmZvcmNlX29ubH'
    'kYBCADKA4yMS5nb29nbGUuYXBpLnNlcnZpY2V1c2FnZS52MWJldGExLlF1b3RhU2FmZXR5Q2hl'
    'Y2tSCWZvcmNlT25seQ==');

@$core.Deprecated('Use updateConsumerOverrideRequestDescriptor instead')
const UpdateConsumerOverrideRequest$json = {
  '1': 'UpdateConsumerOverrideRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'override',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.QuotaOverride',
      '10': 'override'
    },
    {'1': 'force', '3': 3, '4': 1, '5': 8, '10': 'force'},
    {
      '1': 'update_mask',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
    {
      '1': 'force_only',
      '3': 5,
      '4': 3,
      '5': 14,
      '6': '.google.api.serviceusage.v1beta1.QuotaSafetyCheck',
      '10': 'forceOnly'
    },
  ],
};

/// Descriptor for `UpdateConsumerOverrideRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateConsumerOverrideRequestDescriptor = $convert.base64Decode(
    'Ch1VcGRhdGVDb25zdW1lck92ZXJyaWRlUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEkoKCG'
    '92ZXJyaWRlGAIgASgLMi4uZ29vZ2xlLmFwaS5zZXJ2aWNldXNhZ2UudjFiZXRhMS5RdW90YU92'
    'ZXJyaWRlUghvdmVycmlkZRIUCgVmb3JjZRgDIAEoCFIFZm9yY2USOwoLdXBkYXRlX21hc2sYBC'
    'ABKAsyGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrUgp1cGRhdGVNYXNrElAKCmZvcmNlX29u'
    'bHkYBSADKA4yMS5nb29nbGUuYXBpLnNlcnZpY2V1c2FnZS52MWJldGExLlF1b3RhU2FmZXR5Q2'
    'hlY2tSCWZvcmNlT25seQ==');

@$core.Deprecated('Use deleteConsumerOverrideRequestDescriptor instead')
const DeleteConsumerOverrideRequest$json = {
  '1': 'DeleteConsumerOverrideRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'force', '3': 2, '4': 1, '5': 8, '10': 'force'},
    {
      '1': 'force_only',
      '3': 3,
      '4': 3,
      '5': 14,
      '6': '.google.api.serviceusage.v1beta1.QuotaSafetyCheck',
      '10': 'forceOnly'
    },
  ],
};

/// Descriptor for `DeleteConsumerOverrideRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteConsumerOverrideRequestDescriptor =
    $convert.base64Decode(
        'Ch1EZWxldGVDb25zdW1lck92ZXJyaWRlUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEhQKBW'
        'ZvcmNlGAIgASgIUgVmb3JjZRJQCgpmb3JjZV9vbmx5GAMgAygOMjEuZ29vZ2xlLmFwaS5zZXJ2'
        'aWNldXNhZ2UudjFiZXRhMS5RdW90YVNhZmV0eUNoZWNrUglmb3JjZU9ubHk=');

@$core.Deprecated('Use listConsumerOverridesRequestDescriptor instead')
const ListConsumerOverridesRequest$json = {
  '1': 'ListConsumerOverridesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListConsumerOverridesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listConsumerOverridesRequestDescriptor =
    $convert.base64Decode(
        'ChxMaXN0Q29uc3VtZXJPdmVycmlkZXNSZXF1ZXN0EhYKBnBhcmVudBgBIAEoCVIGcGFyZW50Eh'
        'sKCXBhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgDIAEoCVIJcGFnZVRv'
        'a2Vu');

@$core.Deprecated('Use listConsumerOverridesResponseDescriptor instead')
const ListConsumerOverridesResponse$json = {
  '1': 'ListConsumerOverridesResponse',
  '2': [
    {
      '1': 'overrides',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.QuotaOverride',
      '10': 'overrides'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListConsumerOverridesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listConsumerOverridesResponseDescriptor =
    $convert.base64Decode(
        'Ch1MaXN0Q29uc3VtZXJPdmVycmlkZXNSZXNwb25zZRJMCglvdmVycmlkZXMYASADKAsyLi5nb2'
        '9nbGUuYXBpLnNlcnZpY2V1c2FnZS52MWJldGExLlF1b3RhT3ZlcnJpZGVSCW92ZXJyaWRlcxIm'
        'Cg9uZXh0X3BhZ2VfdG9rZW4YAiABKAlSDW5leHRQYWdlVG9rZW4=');

@$core.Deprecated('Use batchCreateConsumerOverridesResponseDescriptor instead')
const BatchCreateConsumerOverridesResponse$json = {
  '1': 'BatchCreateConsumerOverridesResponse',
  '2': [
    {
      '1': 'overrides',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.QuotaOverride',
      '10': 'overrides'
    },
  ],
};

/// Descriptor for `BatchCreateConsumerOverridesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchCreateConsumerOverridesResponseDescriptor =
    $convert.base64Decode(
        'CiRCYXRjaENyZWF0ZUNvbnN1bWVyT3ZlcnJpZGVzUmVzcG9uc2USTAoJb3ZlcnJpZGVzGAEgAy'
        'gLMi4uZ29vZ2xlLmFwaS5zZXJ2aWNldXNhZ2UudjFiZXRhMS5RdW90YU92ZXJyaWRlUglvdmVy'
        'cmlkZXM=');

@$core.Deprecated('Use importConsumerOverridesRequestDescriptor instead')
const ImportConsumerOverridesRequest$json = {
  '1': 'ImportConsumerOverridesRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    {
      '1': 'inline_source',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.OverrideInlineSource',
      '9': 0,
      '10': 'inlineSource'
    },
    {'1': 'force', '3': 3, '4': 1, '5': 8, '10': 'force'},
    {
      '1': 'force_only',
      '3': 4,
      '4': 3,
      '5': 14,
      '6': '.google.api.serviceusage.v1beta1.QuotaSafetyCheck',
      '10': 'forceOnly'
    },
  ],
  '8': [
    {'1': 'source'},
  ],
};

/// Descriptor for `ImportConsumerOverridesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importConsumerOverridesRequestDescriptor = $convert.base64Decode(
    'Ch5JbXBvcnRDb25zdW1lck92ZXJyaWRlc1JlcXVlc3QSFgoGcGFyZW50GAEgASgJUgZwYXJlbn'
    'QSXAoNaW5saW5lX3NvdXJjZRgCIAEoCzI1Lmdvb2dsZS5hcGkuc2VydmljZXVzYWdlLnYxYmV0'
    'YTEuT3ZlcnJpZGVJbmxpbmVTb3VyY2VIAFIMaW5saW5lU291cmNlEhQKBWZvcmNlGAMgASgIUg'
    'Vmb3JjZRJQCgpmb3JjZV9vbmx5GAQgAygOMjEuZ29vZ2xlLmFwaS5zZXJ2aWNldXNhZ2UudjFi'
    'ZXRhMS5RdW90YVNhZmV0eUNoZWNrUglmb3JjZU9ubHlCCAoGc291cmNl');

@$core.Deprecated('Use importConsumerOverridesResponseDescriptor instead')
const ImportConsumerOverridesResponse$json = {
  '1': 'ImportConsumerOverridesResponse',
  '2': [
    {
      '1': 'overrides',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.QuotaOverride',
      '10': 'overrides'
    },
  ],
};

/// Descriptor for `ImportConsumerOverridesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importConsumerOverridesResponseDescriptor =
    $convert.base64Decode(
        'Ch9JbXBvcnRDb25zdW1lck92ZXJyaWRlc1Jlc3BvbnNlEkwKCW92ZXJyaWRlcxgBIAMoCzIuLm'
        'dvb2dsZS5hcGkuc2VydmljZXVzYWdlLnYxYmV0YTEuUXVvdGFPdmVycmlkZVIJb3ZlcnJpZGVz');

@$core.Deprecated('Use importConsumerOverridesMetadataDescriptor instead')
const ImportConsumerOverridesMetadata$json = {
  '1': 'ImportConsumerOverridesMetadata',
};

/// Descriptor for `ImportConsumerOverridesMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importConsumerOverridesMetadataDescriptor =
    $convert.base64Decode('Ch9JbXBvcnRDb25zdW1lck92ZXJyaWRlc01ldGFkYXRh');

@$core.Deprecated('Use importAdminQuotaPoliciesResponseDescriptor instead')
const ImportAdminQuotaPoliciesResponse$json = {
  '1': 'ImportAdminQuotaPoliciesResponse',
  '2': [
    {
      '1': 'policies',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.AdminQuotaPolicy',
      '10': 'policies'
    },
  ],
};

/// Descriptor for `ImportAdminQuotaPoliciesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importAdminQuotaPoliciesResponseDescriptor =
    $convert.base64Decode(
        'CiBJbXBvcnRBZG1pblF1b3RhUG9saWNpZXNSZXNwb25zZRJNCghwb2xpY2llcxgBIAMoCzIxLm'
        'dvb2dsZS5hcGkuc2VydmljZXVzYWdlLnYxYmV0YTEuQWRtaW5RdW90YVBvbGljeVIIcG9saWNp'
        'ZXM=');

@$core.Deprecated('Use importAdminQuotaPoliciesMetadataDescriptor instead')
const ImportAdminQuotaPoliciesMetadata$json = {
  '1': 'ImportAdminQuotaPoliciesMetadata',
};

/// Descriptor for `ImportAdminQuotaPoliciesMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importAdminQuotaPoliciesMetadataDescriptor =
    $convert.base64Decode('CiBJbXBvcnRBZG1pblF1b3RhUG9saWNpZXNNZXRhZGF0YQ==');

@$core.Deprecated('Use createAdminQuotaPolicyMetadataDescriptor instead')
const CreateAdminQuotaPolicyMetadata$json = {
  '1': 'CreateAdminQuotaPolicyMetadata',
};

/// Descriptor for `CreateAdminQuotaPolicyMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAdminQuotaPolicyMetadataDescriptor =
    $convert.base64Decode('Ch5DcmVhdGVBZG1pblF1b3RhUG9saWN5TWV0YWRhdGE=');

@$core.Deprecated('Use updateAdminQuotaPolicyMetadataDescriptor instead')
const UpdateAdminQuotaPolicyMetadata$json = {
  '1': 'UpdateAdminQuotaPolicyMetadata',
};

/// Descriptor for `UpdateAdminQuotaPolicyMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAdminQuotaPolicyMetadataDescriptor =
    $convert.base64Decode('Ch5VcGRhdGVBZG1pblF1b3RhUG9saWN5TWV0YWRhdGE=');

@$core.Deprecated('Use deleteAdminQuotaPolicyMetadataDescriptor instead')
const DeleteAdminQuotaPolicyMetadata$json = {
  '1': 'DeleteAdminQuotaPolicyMetadata',
};

/// Descriptor for `DeleteAdminQuotaPolicyMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAdminQuotaPolicyMetadataDescriptor =
    $convert.base64Decode('Ch5EZWxldGVBZG1pblF1b3RhUG9saWN5TWV0YWRhdGE=');

@$core.Deprecated('Use generateServiceIdentityRequestDescriptor instead')
const GenerateServiceIdentityRequest$json = {
  '1': 'GenerateServiceIdentityRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
  ],
};

/// Descriptor for `GenerateServiceIdentityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateServiceIdentityRequestDescriptor =
    $convert.base64Decode(
        'Ch5HZW5lcmF0ZVNlcnZpY2VJZGVudGl0eVJlcXVlc3QSFgoGcGFyZW50GAEgASgJUgZwYXJlbn'
        'Q=');

@$core.Deprecated('Use getServiceIdentityResponseDescriptor instead')
const GetServiceIdentityResponse$json = {
  '1': 'GetServiceIdentityResponse',
  '2': [
    {
      '1': 'identity',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.serviceusage.v1beta1.ServiceIdentity',
      '10': 'identity'
    },
    {
      '1': 'state',
      '3': 2,
      '4': 1,
      '5': 14,
      '6':
          '.google.api.serviceusage.v1beta1.GetServiceIdentityResponse.IdentityState',
      '10': 'state'
    },
  ],
  '4': [GetServiceIdentityResponse_IdentityState$json],
};

@$core.Deprecated('Use getServiceIdentityResponseDescriptor instead')
const GetServiceIdentityResponse_IdentityState$json = {
  '1': 'IdentityState',
  '2': [
    {'1': 'IDENTITY_STATE_UNSPECIFIED', '2': 0},
    {'1': 'ACTIVE', '2': 1},
  ],
};

/// Descriptor for `GetServiceIdentityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getServiceIdentityResponseDescriptor = $convert.base64Decode(
    'ChpHZXRTZXJ2aWNlSWRlbnRpdHlSZXNwb25zZRJMCghpZGVudGl0eRgBIAEoCzIwLmdvb2dsZS'
    '5hcGkuc2VydmljZXVzYWdlLnYxYmV0YTEuU2VydmljZUlkZW50aXR5UghpZGVudGl0eRJfCgVz'
    'dGF0ZRgCIAEoDjJJLmdvb2dsZS5hcGkuc2VydmljZXVzYWdlLnYxYmV0YTEuR2V0U2VydmljZU'
    'lkZW50aXR5UmVzcG9uc2UuSWRlbnRpdHlTdGF0ZVIFc3RhdGUiOwoNSWRlbnRpdHlTdGF0ZRIe'
    'ChpJREVOVElUWV9TVEFURV9VTlNQRUNJRklFRBAAEgoKBkFDVElWRRAB');

@$core.Deprecated('Use getServiceIdentityMetadataDescriptor instead')
const GetServiceIdentityMetadata$json = {
  '1': 'GetServiceIdentityMetadata',
};

/// Descriptor for `GetServiceIdentityMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getServiceIdentityMetadataDescriptor =
    $convert.base64Decode('ChpHZXRTZXJ2aWNlSWRlbnRpdHlNZXRhZGF0YQ==');
