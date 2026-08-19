//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/log_entry.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use logEntryDescriptor instead')
const LogEntry$json = {
  '1': 'LogEntry',
  '2': [
    {'1': 'name', '3': 10, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'timestamp',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'timestamp'
    },
    {
      '1': 'severity',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.google.logging.type.LogSeverity',
      '10': 'severity'
    },
    {
      '1': 'http_request',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.HttpRequest',
      '10': 'httpRequest'
    },
    {'1': 'trace', '3': 15, '4': 1, '5': 9, '10': 'trace'},
    {'1': 'insert_id', '3': 4, '4': 1, '5': 9, '10': 'insertId'},
    {
      '1': 'labels',
      '3': 13,
      '4': 3,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.LogEntry.LabelsEntry',
      '10': 'labels'
    },
    {
      '1': 'proto_payload',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '9': 0,
      '10': 'protoPayload'
    },
    {'1': 'text_payload', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'textPayload'},
    {
      '1': 'struct_payload',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '9': 0,
      '10': 'structPayload'
    },
    {
      '1': 'operation',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.LogEntryOperation',
      '10': 'operation'
    },
    {
      '1': 'source_location',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.google.api.servicecontrol.v1.LogEntrySourceLocation',
      '10': 'sourceLocation'
    },
  ],
  '3': [LogEntry_LabelsEntry$json],
  '8': [
    {'1': 'payload'},
  ],
};

@$core.Deprecated('Use logEntryDescriptor instead')
const LogEntry_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `LogEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEntryDescriptor = $convert.base64Decode(
    'CghMb2dFbnRyeRISCgRuYW1lGAogASgJUgRuYW1lEjgKCXRpbWVzdGFtcBgLIAEoCzIaLmdvb2'
    'dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcBI8CghzZXZlcml0eRgMIAEoDjIgLmdv'
    'b2dsZS5sb2dnaW5nLnR5cGUuTG9nU2V2ZXJpdHlSCHNldmVyaXR5EkwKDGh0dHBfcmVxdWVzdB'
    'gOIAEoCzIpLmdvb2dsZS5hcGkuc2VydmljZWNvbnRyb2wudjEuSHR0cFJlcXVlc3RSC2h0dHBS'
    'ZXF1ZXN0EhQKBXRyYWNlGA8gASgJUgV0cmFjZRIbCglpbnNlcnRfaWQYBCABKAlSCGluc2VydE'
    'lkEkoKBmxhYmVscxgNIAMoCzIyLmdvb2dsZS5hcGkuc2VydmljZWNvbnRyb2wudjEuTG9nRW50'
    'cnkuTGFiZWxzRW50cnlSBmxhYmVscxI7Cg1wcm90b19wYXlsb2FkGAIgASgLMhQuZ29vZ2xlLn'
    'Byb3RvYnVmLkFueUgAUgxwcm90b1BheWxvYWQSIwoMdGV4dF9wYXlsb2FkGAMgASgJSABSC3Rl'
    'eHRQYXlsb2FkEkAKDnN0cnVjdF9wYXlsb2FkGAYgASgLMhcuZ29vZ2xlLnByb3RvYnVmLlN0cn'
    'VjdEgAUg1zdHJ1Y3RQYXlsb2FkEk0KCW9wZXJhdGlvbhgQIAEoCzIvLmdvb2dsZS5hcGkuc2Vy'
    'dmljZWNvbnRyb2wudjEuTG9nRW50cnlPcGVyYXRpb25SCW9wZXJhdGlvbhJdCg9zb3VyY2VfbG'
    '9jYXRpb24YESABKAsyNC5nb29nbGUuYXBpLnNlcnZpY2Vjb250cm9sLnYxLkxvZ0VudHJ5U291'
    'cmNlTG9jYXRpb25SDnNvdXJjZUxvY2F0aW9uGjkKC0xhYmVsc0VudHJ5EhAKA2tleRgBIAEoCV'
    'IDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAFCCQoHcGF5bG9hZA==');

@$core.Deprecated('Use logEntryOperationDescriptor instead')
const LogEntryOperation$json = {
  '1': 'LogEntryOperation',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'producer', '3': 2, '4': 1, '5': 9, '10': 'producer'},
    {'1': 'first', '3': 3, '4': 1, '5': 8, '10': 'first'},
    {'1': 'last', '3': 4, '4': 1, '5': 8, '10': 'last'},
  ],
};

/// Descriptor for `LogEntryOperation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEntryOperationDescriptor = $convert.base64Decode(
    'ChFMb2dFbnRyeU9wZXJhdGlvbhIOCgJpZBgBIAEoCVICaWQSGgoIcHJvZHVjZXIYAiABKAlSCH'
    'Byb2R1Y2VyEhQKBWZpcnN0GAMgASgIUgVmaXJzdBISCgRsYXN0GAQgASgIUgRsYXN0');

@$core.Deprecated('Use logEntrySourceLocationDescriptor instead')
const LogEntrySourceLocation$json = {
  '1': 'LogEntrySourceLocation',
  '2': [
    {'1': 'file', '3': 1, '4': 1, '5': 9, '10': 'file'},
    {'1': 'line', '3': 2, '4': 1, '5': 3, '10': 'line'},
    {'1': 'function', '3': 3, '4': 1, '5': 9, '10': 'function'},
  ],
};

/// Descriptor for `LogEntrySourceLocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEntrySourceLocationDescriptor =
    $convert.base64Decode(
        'ChZMb2dFbnRyeVNvdXJjZUxvY2F0aW9uEhIKBGZpbGUYASABKAlSBGZpbGUSEgoEbGluZRgCIA'
        'EoA1IEbGluZRIaCghmdW5jdGlvbhgDIAEoCVIIZnVuY3Rpb24=');
