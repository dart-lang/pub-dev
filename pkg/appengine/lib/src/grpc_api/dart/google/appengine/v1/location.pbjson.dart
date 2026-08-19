//
//  Generated code. Do not modify.
//  source: google/appengine/v1/location.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use locationMetadataDescriptor instead')
const LocationMetadata$json = {
  '1': 'LocationMetadata',
  '2': [
    {
      '1': 'standard_environment_available',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'standardEnvironmentAvailable'
    },
    {
      '1': 'flexible_environment_available',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'flexibleEnvironmentAvailable'
    },
    {
      '1': 'search_api_available',
      '3': 6,
      '4': 1,
      '5': 8,
      '8': {},
      '10': 'searchApiAvailable'
    },
  ],
};

/// Descriptor for `LocationMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List locationMetadataDescriptor = $convert.base64Decode(
    'ChBMb2NhdGlvbk1ldGFkYXRhEkQKHnN0YW5kYXJkX2Vudmlyb25tZW50X2F2YWlsYWJsZRgCIA'
    'EoCFIcc3RhbmRhcmRFbnZpcm9ubWVudEF2YWlsYWJsZRJECh5mbGV4aWJsZV9lbnZpcm9ubWVu'
    'dF9hdmFpbGFibGUYBCABKAhSHGZsZXhpYmxlRW52aXJvbm1lbnRBdmFpbGFibGUSNQoUc2Vhcm'
    'NoX2FwaV9hdmFpbGFibGUYBiABKAhCA+BBA1ISc2VhcmNoQXBpQXZhaWxhYmxl');
