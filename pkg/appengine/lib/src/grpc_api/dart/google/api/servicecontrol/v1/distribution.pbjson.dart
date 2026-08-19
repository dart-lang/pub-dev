//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/distribution.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use distributionDescriptor instead')
const Distribution$json = {
  '1': 'Distribution',
  '2': [
    {'1': 'count', '3': 1, '4': 1, '5': 3, '10': 'count'},
    {'1': 'mean', '3': 2, '4': 1, '5': 1, '10': 'mean'},
    {'1': 'minimum', '3': 3, '4': 1, '5': 1, '10': 'minimum'},
    {'1': 'maximum', '3': 4, '4': 1, '5': 1, '10': 'maximum'},
    {
      '1': 'sum_of_squared_deviation',
      '3': 5,
      '4': 1,
      '5': 1,
      '10': 'sumOfSquaredDeviation'
    },
    {'1': 'bucket_counts', '3': 6, '4': 3, '5': 3, '10': 'bucketCounts'},
    {
      '1': 'linear_buckets',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.Distribution.LinearBuckets',
      '9': 0,
      '10': 'linearBuckets'
    },
    {
      '1': 'exponential_buckets',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.Distribution.ExponentialBuckets',
      '9': 0,
      '10': 'exponentialBuckets'
    },
    {
      '1': 'explicit_buckets',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.Distribution.ExplicitBuckets',
      '9': 0,
      '10': 'explicitBuckets'
    },
    {
      '1': 'exemplars',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.google.api.Distribution.Exemplar',
      '10': 'exemplars'
    },
  ],
  '3': [
    Distribution_LinearBuckets$json,
    Distribution_ExponentialBuckets$json,
    Distribution_ExplicitBuckets$json
  ],
  '8': [
    {'1': 'bucket_option'},
  ],
};

@$core.Deprecated('Use distributionDescriptor instead')
const Distribution_LinearBuckets$json = {
  '1': 'LinearBuckets',
  '2': [
    {
      '1': 'num_finite_buckets',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'numFiniteBuckets'
    },
    {'1': 'width', '3': 2, '4': 1, '5': 1, '10': 'width'},
    {'1': 'offset', '3': 3, '4': 1, '5': 1, '10': 'offset'},
  ],
};

@$core.Deprecated('Use distributionDescriptor instead')
const Distribution_ExponentialBuckets$json = {
  '1': 'ExponentialBuckets',
  '2': [
    {
      '1': 'num_finite_buckets',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'numFiniteBuckets'
    },
    {'1': 'growth_factor', '3': 2, '4': 1, '5': 1, '10': 'growthFactor'},
    {'1': 'scale', '3': 3, '4': 1, '5': 1, '10': 'scale'},
  ],
};

@$core.Deprecated('Use distributionDescriptor instead')
const Distribution_ExplicitBuckets$json = {
  '1': 'ExplicitBuckets',
  '2': [
    {'1': 'bounds', '3': 1, '4': 3, '5': 1, '10': 'bounds'},
  ],
};

/// Descriptor for `Distribution`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List distributionDescriptor = $convert.base64Decode(
    'CgxEaXN0cmlidXRpb24SFAoFY291bnQYASABKANSBWNvdW50EhIKBG1lYW4YAiABKAFSBG1lYW'
    '4SGAoHbWluaW11bRgDIAEoAVIHbWluaW11bRIYCgdtYXhpbXVtGAQgASgBUgdtYXhpbXVtEjcK'
    'GHN1bV9vZl9zcXVhcmVkX2RldmlhdGlvbhgFIAEoAVIVc3VtT2ZTcXVhcmVkRGV2aWF0aW9uEi'
    'MKDWJ1Y2tldF9jb3VudHMYBiADKANSDGJ1Y2tldENvdW50cxJhCg5saW5lYXJfYnVja2V0cxgH'
    'IAEoCzI4Lmdvb2dsZS5hcGkuc2VydmljZWNvbnRyb2wudjEuRGlzdHJpYnV0aW9uLkxpbmVhck'
    'J1Y2tldHNIAFINbGluZWFyQnVja2V0cxJwChNleHBvbmVudGlhbF9idWNrZXRzGAggASgLMj0u'
    'Z29vZ2xlLmFwaS5zZXJ2aWNlY29udHJvbC52MS5EaXN0cmlidXRpb24uRXhwb25lbnRpYWxCdW'
    'NrZXRzSABSEmV4cG9uZW50aWFsQnVja2V0cxJnChBleHBsaWNpdF9idWNrZXRzGAkgASgLMjou'
    'Z29vZ2xlLmFwaS5zZXJ2aWNlY29udHJvbC52MS5EaXN0cmlidXRpb24uRXhwbGljaXRCdWNrZX'
    'RzSABSD2V4cGxpY2l0QnVja2V0cxI/CglleGVtcGxhcnMYCiADKAsyIS5nb29nbGUuYXBpLkRp'
    'c3RyaWJ1dGlvbi5FeGVtcGxhclIJZXhlbXBsYXJzGmsKDUxpbmVhckJ1Y2tldHMSLAoSbnVtX2'
    'Zpbml0ZV9idWNrZXRzGAEgASgFUhBudW1GaW5pdGVCdWNrZXRzEhQKBXdpZHRoGAIgASgBUgV3'
    'aWR0aBIWCgZvZmZzZXQYAyABKAFSBm9mZnNldBp9ChJFeHBvbmVudGlhbEJ1Y2tldHMSLAoSbn'
    'VtX2Zpbml0ZV9idWNrZXRzGAEgASgFUhBudW1GaW5pdGVCdWNrZXRzEiMKDWdyb3d0aF9mYWN0'
    'b3IYAiABKAFSDGdyb3d0aEZhY3RvchIUCgVzY2FsZRgDIAEoAVIFc2NhbGUaKQoPRXhwbGljaX'
    'RCdWNrZXRzEhYKBmJvdW5kcxgBIAMoAVIGYm91bmRzQg8KDWJ1Y2tldF9vcHRpb24=');
