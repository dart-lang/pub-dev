//
//  Generated code. Do not modify.
//  source: google/api/quota.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use quotaDescriptor instead')
const Quota$json = {
  '1': 'Quota',
  '2': [
    {
      '1': 'limits',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.api.QuotaLimit',
      '10': 'limits'
    },
    {
      '1': 'metric_rules',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.api.MetricRule',
      '10': 'metricRules'
    },
  ],
};

/// Descriptor for `Quota`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quotaDescriptor = $convert.base64Decode(
    'CgVRdW90YRIuCgZsaW1pdHMYAyADKAsyFi5nb29nbGUuYXBpLlF1b3RhTGltaXRSBmxpbWl0cx'
    'I5CgxtZXRyaWNfcnVsZXMYBCADKAsyFi5nb29nbGUuYXBpLk1ldHJpY1J1bGVSC21ldHJpY1J1'
    'bGVz');

@$core.Deprecated('Use metricRuleDescriptor instead')
const MetricRule$json = {
  '1': 'MetricRule',
  '2': [
    {'1': 'selector', '3': 1, '4': 1, '5': 9, '10': 'selector'},
    {
      '1': 'metric_costs',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.MetricRule.MetricCostsEntry',
      '10': 'metricCosts'
    },
  ],
  '3': [MetricRule_MetricCostsEntry$json],
};

@$core.Deprecated('Use metricRuleDescriptor instead')
const MetricRule_MetricCostsEntry$json = {
  '1': 'MetricCostsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 3, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `MetricRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metricRuleDescriptor = $convert.base64Decode(
    'CgpNZXRyaWNSdWxlEhoKCHNlbGVjdG9yGAEgASgJUghzZWxlY3RvchJKCgxtZXRyaWNfY29zdH'
    'MYAiADKAsyJy5nb29nbGUuYXBpLk1ldHJpY1J1bGUuTWV0cmljQ29zdHNFbnRyeVILbWV0cmlj'
    'Q29zdHMaPgoQTWV0cmljQ29zdHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIA'
    'EoA1IFdmFsdWU6AjgB');

@$core.Deprecated('Use quotaLimitDescriptor instead')
const QuotaLimit$json = {
  '1': 'QuotaLimit',
  '2': [
    {'1': 'name', '3': 6, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'default_limit', '3': 3, '4': 1, '5': 3, '10': 'defaultLimit'},
    {'1': 'max_limit', '3': 4, '4': 1, '5': 3, '10': 'maxLimit'},
    {'1': 'free_tier', '3': 7, '4': 1, '5': 3, '10': 'freeTier'},
    {'1': 'duration', '3': 5, '4': 1, '5': 9, '10': 'duration'},
    {'1': 'metric', '3': 8, '4': 1, '5': 9, '10': 'metric'},
    {'1': 'unit', '3': 9, '4': 1, '5': 9, '10': 'unit'},
    {
      '1': 'values',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.google.api.QuotaLimit.ValuesEntry',
      '10': 'values'
    },
    {'1': 'display_name', '3': 12, '4': 1, '5': 9, '10': 'displayName'},
  ],
  '3': [QuotaLimit_ValuesEntry$json],
};

@$core.Deprecated('Use quotaLimitDescriptor instead')
const QuotaLimit_ValuesEntry$json = {
  '1': 'ValuesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 3, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `QuotaLimit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quotaLimitDescriptor = $convert.base64Decode(
    'CgpRdW90YUxpbWl0EhIKBG5hbWUYBiABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAiABKAlSC2'
    'Rlc2NyaXB0aW9uEiMKDWRlZmF1bHRfbGltaXQYAyABKANSDGRlZmF1bHRMaW1pdBIbCgltYXhf'
    'bGltaXQYBCABKANSCG1heExpbWl0EhsKCWZyZWVfdGllchgHIAEoA1IIZnJlZVRpZXISGgoIZH'
    'VyYXRpb24YBSABKAlSCGR1cmF0aW9uEhYKBm1ldHJpYxgIIAEoCVIGbWV0cmljEhIKBHVuaXQY'
    'CSABKAlSBHVuaXQSOgoGdmFsdWVzGAogAygLMiIuZ29vZ2xlLmFwaS5RdW90YUxpbWl0LlZhbH'
    'Vlc0VudHJ5UgZ2YWx1ZXMSIQoMZGlzcGxheV9uYW1lGAwgASgJUgtkaXNwbGF5TmFtZRo5CgtW'
    'YWx1ZXNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoA1IFdmFsdWU6AjgB');
