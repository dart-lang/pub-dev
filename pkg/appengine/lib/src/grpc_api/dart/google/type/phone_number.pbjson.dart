//
//  Generated code. Do not modify.
//  source: google/type/phone_number.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use phoneNumberDescriptor instead')
const PhoneNumber$json = {
  '1': 'PhoneNumber',
  '2': [
    {'1': 'e164_number', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'e164Number'},
    {
      '1': 'short_code',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.type.PhoneNumber.ShortCode',
      '9': 0,
      '10': 'shortCode'
    },
    {'1': 'extension', '3': 3, '4': 1, '5': 9, '10': 'extension'},
  ],
  '3': [PhoneNumber_ShortCode$json],
  '8': [
    {'1': 'kind'},
  ],
};

@$core.Deprecated('Use phoneNumberDescriptor instead')
const PhoneNumber_ShortCode$json = {
  '1': 'ShortCode',
  '2': [
    {'1': 'region_code', '3': 1, '4': 1, '5': 9, '10': 'regionCode'},
    {'1': 'number', '3': 2, '4': 1, '5': 9, '10': 'number'},
  ],
};

/// Descriptor for `PhoneNumber`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List phoneNumberDescriptor = $convert.base64Decode(
    'CgtQaG9uZU51bWJlchIhCgtlMTY0X251bWJlchgBIAEoCUgAUgplMTY0TnVtYmVyEkMKCnNob3'
    'J0X2NvZGUYAiABKAsyIi5nb29nbGUudHlwZS5QaG9uZU51bWJlci5TaG9ydENvZGVIAFIJc2hv'
    'cnRDb2RlEhwKCWV4dGVuc2lvbhgDIAEoCVIJZXh0ZW5zaW9uGkQKCVNob3J0Q29kZRIfCgtyZW'
    'dpb25fY29kZRgBIAEoCVIKcmVnaW9uQ29kZRIWCgZudW1iZXIYAiABKAlSBm51bWJlckIGCgRr'
    'aW5k');
