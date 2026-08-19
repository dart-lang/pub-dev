//
//  Generated code. Do not modify.
//  source: google/api/cloudquotas/v1/resources.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use quotaSafetyCheckDescriptor instead')
const QuotaSafetyCheck$json = {
  '1': 'QuotaSafetyCheck',
  '2': [
    {'1': 'QUOTA_SAFETY_CHECK_UNSPECIFIED', '2': 0},
    {'1': 'QUOTA_DECREASE_BELOW_USAGE', '2': 1},
    {'1': 'QUOTA_DECREASE_PERCENTAGE_TOO_HIGH', '2': 2},
  ],
};

/// Descriptor for `QuotaSafetyCheck`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List quotaSafetyCheckDescriptor = $convert.base64Decode(
    'ChBRdW90YVNhZmV0eUNoZWNrEiIKHlFVT1RBX1NBRkVUWV9DSEVDS19VTlNQRUNJRklFRBAAEh'
    '4KGlFVT1RBX0RFQ1JFQVNFX0JFTE9XX1VTQUdFEAESJgoiUVVPVEFfREVDUkVBU0VfUEVSQ0VO'
    'VEFHRV9UT09fSElHSBAC');

@$core.Deprecated('Use quotaInfoDescriptor instead')
const QuotaInfo$json = {
  '1': 'QuotaInfo',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'quota_id', '3': 2, '4': 1, '5': 9, '10': 'quotaId'},
    {'1': 'metric', '3': 3, '4': 1, '5': 9, '10': 'metric'},
    {'1': 'service', '3': 4, '4': 1, '5': 9, '10': 'service'},
    {'1': 'is_precise', '3': 5, '4': 1, '5': 8, '10': 'isPrecise'},
    {'1': 'refresh_interval', '3': 6, '4': 1, '5': 9, '10': 'refreshInterval'},
    {
      '1': 'container_type',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.google.api.cloudquotas.v1.QuotaInfo.ContainerType',
      '10': 'containerType'
    },
    {'1': 'dimensions', '3': 8, '4': 3, '5': 9, '10': 'dimensions'},
    {
      '1': 'metric_display_name',
      '3': 9,
      '4': 1,
      '5': 9,
      '10': 'metricDisplayName'
    },
    {
      '1': 'quota_display_name',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'quotaDisplayName'
    },
    {'1': 'metric_unit', '3': 11, '4': 1, '5': 9, '10': 'metricUnit'},
    {
      '1': 'quota_increase_eligibility',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.api.cloudquotas.v1.QuotaIncreaseEligibility',
      '10': 'quotaIncreaseEligibility'
    },
    {'1': 'is_fixed', '3': 13, '4': 1, '5': 8, '10': 'isFixed'},
    {
      '1': 'dimensions_infos',
      '3': 14,
      '4': 3,
      '5': 11,
      '6': '.google.api.cloudquotas.v1.DimensionsInfo',
      '10': 'dimensionsInfos'
    },
    {'1': 'is_concurrent', '3': 15, '4': 1, '5': 8, '10': 'isConcurrent'},
    {
      '1': 'service_request_quota_uri',
      '3': 17,
      '4': 1,
      '5': 9,
      '10': 'serviceRequestQuotaUri'
    },
  ],
  '4': [QuotaInfo_ContainerType$json],
  '7': {},
};

@$core.Deprecated('Use quotaInfoDescriptor instead')
const QuotaInfo_ContainerType$json = {
  '1': 'ContainerType',
  '2': [
    {'1': 'CONTAINER_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'PROJECT', '2': 1},
    {'1': 'FOLDER', '2': 2},
    {'1': 'ORGANIZATION', '2': 3},
  ],
};

/// Descriptor for `QuotaInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quotaInfoDescriptor = $convert.base64Decode(
    'CglRdW90YUluZm8SEgoEbmFtZRgBIAEoCVIEbmFtZRIZCghxdW90YV9pZBgCIAEoCVIHcXVvdG'
    'FJZBIWCgZtZXRyaWMYAyABKAlSBm1ldHJpYxIYCgdzZXJ2aWNlGAQgASgJUgdzZXJ2aWNlEh0K'
    'CmlzX3ByZWNpc2UYBSABKAhSCWlzUHJlY2lzZRIpChByZWZyZXNoX2ludGVydmFsGAYgASgJUg'
    '9yZWZyZXNoSW50ZXJ2YWwSWQoOY29udGFpbmVyX3R5cGUYByABKA4yMi5nb29nbGUuYXBpLmNs'
    'b3VkcXVvdGFzLnYxLlF1b3RhSW5mby5Db250YWluZXJUeXBlUg1jb250YWluZXJUeXBlEh4KCm'
    'RpbWVuc2lvbnMYCCADKAlSCmRpbWVuc2lvbnMSLgoTbWV0cmljX2Rpc3BsYXlfbmFtZRgJIAEo'
    'CVIRbWV0cmljRGlzcGxheU5hbWUSLAoScXVvdGFfZGlzcGxheV9uYW1lGAogASgJUhBxdW90YU'
    'Rpc3BsYXlOYW1lEh8KC21ldHJpY191bml0GAsgASgJUgptZXRyaWNVbml0EnEKGnF1b3RhX2lu'
    'Y3JlYXNlX2VsaWdpYmlsaXR5GAwgASgLMjMuZ29vZ2xlLmFwaS5jbG91ZHF1b3Rhcy52MS5RdW'
    '90YUluY3JlYXNlRWxpZ2liaWxpdHlSGHF1b3RhSW5jcmVhc2VFbGlnaWJpbGl0eRIZCghpc19m'
    'aXhlZBgNIAEoCFIHaXNGaXhlZBJUChBkaW1lbnNpb25zX2luZm9zGA4gAygLMikuZ29vZ2xlLm'
    'FwaS5jbG91ZHF1b3Rhcy52MS5EaW1lbnNpb25zSW5mb1IPZGltZW5zaW9uc0luZm9zEiMKDWlz'
    'X2NvbmN1cnJlbnQYDyABKAhSDGlzQ29uY3VycmVudBI5ChlzZXJ2aWNlX3JlcXVlc3RfcXVvdG'
    'FfdXJpGBEgASgJUhZzZXJ2aWNlUmVxdWVzdFF1b3RhVXJpIloKDUNvbnRhaW5lclR5cGUSHgoa'
    'Q09OVEFJTkVSX1RZUEVfVU5TUEVDSUZJRUQQABILCgdQUk9KRUNUEAESCgoGRk9MREVSEAISEA'
    'oMT1JHQU5JWkFUSU9OEAM6rgLqQaoCCiRjbG91ZHF1b3Rhcy5nb29nbGVhcGlzLmNvbS9RdW90'
    'YUluZm8SUnByb2plY3RzL3twcm9qZWN0fS9sb2NhdGlvbnMve2xvY2F0aW9ufS9zZXJ2aWNlcy'
    '97c2VydmljZX0vcXVvdGFJbmZvcy97cXVvdGFfaW5mb30SUGZvbGRlcnMve2ZvbGRlcn0vbG9j'
    'YXRpb25zL3tsb2NhdGlvbn0vc2VydmljZXMve3NlcnZpY2V9L3F1b3RhSW5mb3Mve3F1b3RhX2'
    'luZm99Elxvcmdhbml6YXRpb25zL3tvcmdhbml6YXRpb259L2xvY2F0aW9ucy97bG9jYXRpb259'
    'L3NlcnZpY2VzL3tzZXJ2aWNlfS9xdW90YUluZm9zL3txdW90YV9pbmZvfQ==');

@$core.Deprecated('Use quotaIncreaseEligibilityDescriptor instead')
const QuotaIncreaseEligibility$json = {
  '1': 'QuotaIncreaseEligibility',
  '2': [
    {'1': 'is_eligible', '3': 1, '4': 1, '5': 8, '10': 'isEligible'},
    {
      '1': 'ineligibility_reason',
      '3': 2,
      '4': 1,
      '5': 14,
      '6':
          '.google.api.cloudquotas.v1.QuotaIncreaseEligibility.IneligibilityReason',
      '10': 'ineligibilityReason'
    },
  ],
  '4': [QuotaIncreaseEligibility_IneligibilityReason$json],
};

@$core.Deprecated('Use quotaIncreaseEligibilityDescriptor instead')
const QuotaIncreaseEligibility_IneligibilityReason$json = {
  '1': 'IneligibilityReason',
  '2': [
    {'1': 'INELIGIBILITY_REASON_UNSPECIFIED', '2': 0},
    {'1': 'NO_VALID_BILLING_ACCOUNT', '2': 1},
    {'1': 'OTHER', '2': 2},
  ],
};

/// Descriptor for `QuotaIncreaseEligibility`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quotaIncreaseEligibilityDescriptor = $convert.base64Decode(
    'ChhRdW90YUluY3JlYXNlRWxpZ2liaWxpdHkSHwoLaXNfZWxpZ2libGUYASABKAhSCmlzRWxpZ2'
    'libGUSegoUaW5lbGlnaWJpbGl0eV9yZWFzb24YAiABKA4yRy5nb29nbGUuYXBpLmNsb3VkcXVv'
    'dGFzLnYxLlF1b3RhSW5jcmVhc2VFbGlnaWJpbGl0eS5JbmVsaWdpYmlsaXR5UmVhc29uUhNpbm'
    'VsaWdpYmlsaXR5UmVhc29uImQKE0luZWxpZ2liaWxpdHlSZWFzb24SJAogSU5FTElHSUJJTElU'
    'WV9SRUFTT05fVU5TUEVDSUZJRUQQABIcChhOT19WQUxJRF9CSUxMSU5HX0FDQ09VTlQQARIJCg'
    'VPVEhFUhAC');

@$core.Deprecated('Use quotaPreferenceDescriptor instead')
const QuotaPreference$json = {
  '1': 'QuotaPreference',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'dimensions',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.cloudquotas.v1.QuotaPreference.DimensionsEntry',
      '8': {},
      '10': 'dimensions'
    },
    {
      '1': 'quota_config',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.api.cloudquotas.v1.QuotaConfig',
      '8': {},
      '10': 'quotaConfig'
    },
    {'1': 'etag', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'etag'},
    {
      '1': 'create_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'createTime'
    },
    {
      '1': 'update_time',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'updateTime'
    },
    {'1': 'service', '3': 7, '4': 1, '5': 9, '8': {}, '10': 'service'},
    {'1': 'quota_id', '3': 8, '4': 1, '5': 9, '8': {}, '10': 'quotaId'},
    {'1': 'reconciling', '3': 10, '4': 1, '5': 8, '8': {}, '10': 'reconciling'},
    {'1': 'justification', '3': 11, '4': 1, '5': 9, '10': 'justification'},
    {
      '1': 'contact_email',
      '3': 12,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'contactEmail'
    },
  ],
  '3': [QuotaPreference_DimensionsEntry$json],
  '7': {},
};

@$core.Deprecated('Use quotaPreferenceDescriptor instead')
const QuotaPreference_DimensionsEntry$json = {
  '1': 'DimensionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `QuotaPreference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quotaPreferenceDescriptor = $convert.base64Decode(
    'Cg9RdW90YVByZWZlcmVuY2USEgoEbmFtZRgBIAEoCVIEbmFtZRJfCgpkaW1lbnNpb25zGAIgAy'
    'gLMjouZ29vZ2xlLmFwaS5jbG91ZHF1b3Rhcy52MS5RdW90YVByZWZlcmVuY2UuRGltZW5zaW9u'
    'c0VudHJ5QgPgQQVSCmRpbWVuc2lvbnMSTgoMcXVvdGFfY29uZmlnGAMgASgLMiYuZ29vZ2xlLm'
    'FwaS5jbG91ZHF1b3Rhcy52MS5RdW90YUNvbmZpZ0ID4EECUgtxdW90YUNvbmZpZxIXCgRldGFn'
    'GAQgASgJQgPgQQFSBGV0YWcSQAoLY3JlYXRlX3RpbWUYBSABKAsyGi5nb29nbGUucHJvdG9idW'
    'YuVGltZXN0YW1wQgPgQQNSCmNyZWF0ZVRpbWUSQAoLdXBkYXRlX3RpbWUYBiABKAsyGi5nb29n'
    'bGUucHJvdG9idWYuVGltZXN0YW1wQgPgQQNSCnVwZGF0ZVRpbWUSHQoHc2VydmljZRgHIAEoCU'
    'ID4EECUgdzZXJ2aWNlEh4KCHF1b3RhX2lkGAggASgJQgPgQQJSB3F1b3RhSWQSJQoLcmVjb25j'
    'aWxpbmcYCiABKAhCA+BBA1ILcmVjb25jaWxpbmcSJAoNanVzdGlmaWNhdGlvbhgLIAEoCVINan'
    'VzdGlmaWNhdGlvbhIoCg1jb250YWN0X2VtYWlsGAwgASgJQgPgQQRSDGNvbnRhY3RFbWFpbBo9'
    'Cg9EaW1lbnNpb25zRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbH'
    'VlOgI4ATqfAupBmwIKKmNsb3VkcXVvdGFzLmdvb2dsZWFwaXMuY29tL1F1b3RhUHJlZmVyZW5j'
    'ZRJLcHJvamVjdHMve3Byb2plY3R9L2xvY2F0aW9ucy97bG9jYXRpb259L3F1b3RhUHJlZmVyZW'
    '5jZXMve3F1b3RhX3ByZWZlcmVuY2V9Eklmb2xkZXJzL3tmb2xkZXJ9L2xvY2F0aW9ucy97bG9j'
    'YXRpb259L3F1b3RhUHJlZmVyZW5jZXMve3F1b3RhX3ByZWZlcmVuY2V9ElVvcmdhbml6YXRpb2'
    '5zL3tvcmdhbml6YXRpb259L2xvY2F0aW9ucy97bG9jYXRpb259L3F1b3RhUHJlZmVyZW5jZXMv'
    'e3F1b3RhX3ByZWZlcmVuY2V9');

@$core.Deprecated('Use quotaConfigDescriptor instead')
const QuotaConfig$json = {
  '1': 'QuotaConfig',
  '2': [
    {
      '1': 'preferred_value',
      '3': 1,
      '4': 1,
      '5': 3,
      '8': {},
      '10': 'preferredValue'
    },
    {'1': 'state_detail', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'stateDetail'},
    {
      '1': 'granted_value',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Int64Value',
      '8': {},
      '10': 'grantedValue'
    },
    {'1': 'trace_id', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'traceId'},
    {
      '1': 'annotations',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.google.api.cloudquotas.v1.QuotaConfig.AnnotationsEntry',
      '8': {},
      '10': 'annotations'
    },
    {
      '1': 'request_origin',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.google.api.cloudquotas.v1.QuotaConfig.Origin',
      '8': {},
      '10': 'requestOrigin'
    },
  ],
  '3': [QuotaConfig_AnnotationsEntry$json],
  '4': [QuotaConfig_Origin$json],
};

@$core.Deprecated('Use quotaConfigDescriptor instead')
const QuotaConfig_AnnotationsEntry$json = {
  '1': 'AnnotationsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use quotaConfigDescriptor instead')
const QuotaConfig_Origin$json = {
  '1': 'Origin',
  '2': [
    {'1': 'ORIGIN_UNSPECIFIED', '2': 0},
    {'1': 'CLOUD_CONSOLE', '2': 1},
    {'1': 'AUTO_ADJUSTER', '2': 2},
  ],
};

/// Descriptor for `QuotaConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quotaConfigDescriptor = $convert.base64Decode(
    'CgtRdW90YUNvbmZpZxIsCg9wcmVmZXJyZWRfdmFsdWUYASABKANCA+BBAlIOcHJlZmVycmVkVm'
    'FsdWUSJgoMc3RhdGVfZGV0YWlsGAIgASgJQgPgQQNSC3N0YXRlRGV0YWlsEkUKDWdyYW50ZWRf'
    'dmFsdWUYAyABKAsyGy5nb29nbGUucHJvdG9idWYuSW50NjRWYWx1ZUID4EEDUgxncmFudGVkVm'
    'FsdWUSHgoIdHJhY2VfaWQYBCABKAlCA+BBA1IHdHJhY2VJZBJeCgthbm5vdGF0aW9ucxgFIAMo'
    'CzI3Lmdvb2dsZS5hcGkuY2xvdWRxdW90YXMudjEuUXVvdGFDb25maWcuQW5ub3RhdGlvbnNFbn'
    'RyeUID4EEBUgthbm5vdGF0aW9ucxJZCg5yZXF1ZXN0X29yaWdpbhgGIAEoDjItLmdvb2dsZS5h'
    'cGkuY2xvdWRxdW90YXMudjEuUXVvdGFDb25maWcuT3JpZ2luQgPgQQNSDXJlcXVlc3RPcmlnaW'
    '4aPgoQQW5ub3RhdGlvbnNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIF'
    'dmFsdWU6AjgBIkYKBk9yaWdpbhIWChJPUklHSU5fVU5TUEVDSUZJRUQQABIRCg1DTE9VRF9DT0'
    '5TT0xFEAESEQoNQVVUT19BREpVU1RFUhAC');

@$core.Deprecated('Use dimensionsInfoDescriptor instead')
const DimensionsInfo$json = {
  '1': 'DimensionsInfo',
  '2': [
    {
      '1': 'dimensions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.cloudquotas.v1.DimensionsInfo.DimensionsEntry',
      '10': 'dimensions'
    },
    {
      '1': 'details',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.cloudquotas.v1.QuotaDetails',
      '10': 'details'
    },
    {
      '1': 'applicable_locations',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'applicableLocations'
    },
  ],
  '3': [DimensionsInfo_DimensionsEntry$json],
};

@$core.Deprecated('Use dimensionsInfoDescriptor instead')
const DimensionsInfo_DimensionsEntry$json = {
  '1': 'DimensionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `DimensionsInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dimensionsInfoDescriptor = $convert.base64Decode(
    'Cg5EaW1lbnNpb25zSW5mbxJZCgpkaW1lbnNpb25zGAEgAygLMjkuZ29vZ2xlLmFwaS5jbG91ZH'
    'F1b3Rhcy52MS5EaW1lbnNpb25zSW5mby5EaW1lbnNpb25zRW50cnlSCmRpbWVuc2lvbnMSQQoH'
    'ZGV0YWlscxgCIAEoCzInLmdvb2dsZS5hcGkuY2xvdWRxdW90YXMudjEuUXVvdGFEZXRhaWxzUg'
    'dkZXRhaWxzEjEKFGFwcGxpY2FibGVfbG9jYXRpb25zGAMgAygJUhNhcHBsaWNhYmxlTG9jYXRp'
    'b25zGj0KD0RpbWVuc2lvbnNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCV'
    'IFdmFsdWU6AjgB');

@$core.Deprecated('Use quotaDetailsDescriptor instead')
const QuotaDetails$json = {
  '1': 'QuotaDetails',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 3, '10': 'value'},
    {
      '1': 'rollout_info',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.api.cloudquotas.v1.RolloutInfo',
      '10': 'rolloutInfo'
    },
  ],
};

/// Descriptor for `QuotaDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quotaDetailsDescriptor = $convert.base64Decode(
    'CgxRdW90YURldGFpbHMSFAoFdmFsdWUYASABKANSBXZhbHVlEkkKDHJvbGxvdXRfaW5mbxgDIA'
    'EoCzImLmdvb2dsZS5hcGkuY2xvdWRxdW90YXMudjEuUm9sbG91dEluZm9SC3JvbGxvdXRJbmZv');

@$core.Deprecated('Use rolloutInfoDescriptor instead')
const RolloutInfo$json = {
  '1': 'RolloutInfo',
  '2': [
    {'1': 'ongoing_rollout', '3': 1, '4': 1, '5': 8, '10': 'ongoingRollout'},
  ],
};

/// Descriptor for `RolloutInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rolloutInfoDescriptor = $convert.base64Decode(
    'CgtSb2xsb3V0SW5mbxInCg9vbmdvaW5nX3JvbGxvdXQYASABKAhSDm9uZ29pbmdSb2xsb3V0');
