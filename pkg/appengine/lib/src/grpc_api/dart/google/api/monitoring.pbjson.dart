//
//  Generated code. Do not modify.
//  source: google/api/monitoring.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use monitoringDescriptor instead')
const Monitoring$json = {
  '1': 'Monitoring',
  '2': [
    {
      '1': 'producer_destinations',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.Monitoring.MonitoringDestination',
      '10': 'producerDestinations'
    },
    {
      '1': 'consumer_destinations',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.Monitoring.MonitoringDestination',
      '10': 'consumerDestinations'
    },
  ],
  '3': [Monitoring_MonitoringDestination$json],
};

@$core.Deprecated('Use monitoringDescriptor instead')
const Monitoring_MonitoringDestination$json = {
  '1': 'MonitoringDestination',
  '2': [
    {
      '1': 'monitored_resource',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'monitoredResource'
    },
    {'1': 'metrics', '3': 2, '4': 3, '5': 9, '10': 'metrics'},
  ],
};

/// Descriptor for `Monitoring`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitoringDescriptor = $convert.base64Decode(
    'CgpNb25pdG9yaW5nEmEKFXByb2R1Y2VyX2Rlc3RpbmF0aW9ucxgBIAMoCzIsLmdvb2dsZS5hcG'
    'kuTW9uaXRvcmluZy5Nb25pdG9yaW5nRGVzdGluYXRpb25SFHByb2R1Y2VyRGVzdGluYXRpb25z'
    'EmEKFWNvbnN1bWVyX2Rlc3RpbmF0aW9ucxgCIAMoCzIsLmdvb2dsZS5hcGkuTW9uaXRvcmluZy'
    '5Nb25pdG9yaW5nRGVzdGluYXRpb25SFGNvbnN1bWVyRGVzdGluYXRpb25zGmAKFU1vbml0b3Jp'
    'bmdEZXN0aW5hdGlvbhItChJtb25pdG9yZWRfcmVzb3VyY2UYASABKAlSEW1vbml0b3JlZFJlc2'
    '91cmNlEhgKB21ldHJpY3MYAiADKAlSB21ldHJpY3M=');
