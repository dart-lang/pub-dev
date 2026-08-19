//
//  Generated code. Do not modify.
//  source: google/api/billing.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use billingDescriptor instead')
const Billing$json = {
  '1': 'Billing',
  '2': [
    {
      '1': 'consumer_destinations',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.google.api.Billing.BillingDestination',
      '10': 'consumerDestinations'
    },
  ],
  '3': [Billing_BillingDestination$json],
};

@$core.Deprecated('Use billingDescriptor instead')
const Billing_BillingDestination$json = {
  '1': 'BillingDestination',
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

/// Descriptor for `Billing`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billingDescriptor = $convert.base64Decode(
    'CgdCaWxsaW5nElsKFWNvbnN1bWVyX2Rlc3RpbmF0aW9ucxgIIAMoCzImLmdvb2dsZS5hcGkuQm'
    'lsbGluZy5CaWxsaW5nRGVzdGluYXRpb25SFGNvbnN1bWVyRGVzdGluYXRpb25zGl0KEkJpbGxp'
    'bmdEZXN0aW5hdGlvbhItChJtb25pdG9yZWRfcmVzb3VyY2UYASABKAlSEW1vbml0b3JlZFJlc2'
    '91cmNlEhgKB21ldHJpY3MYAiADKAlSB21ldHJpY3M=');
