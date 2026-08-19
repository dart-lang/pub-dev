//
//  Generated code. Do not modify.
//  source: google/logging/v2/log_entry.proto
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
    {'1': 'log_name', '3': 12, '4': 1, '5': 9, '8': {}, '10': 'logName'},
    {
      '1': 'resource',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.api.MonitoredResource',
      '8': {},
      '10': 'resource'
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
      '1': 'json_payload',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '9': 0,
      '10': 'jsonPayload'
    },
    {
      '1': 'timestamp',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'timestamp'
    },
    {
      '1': 'receive_timestamp',
      '3': 24,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'receiveTimestamp'
    },
    {
      '1': 'severity',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.google.logging.type.LogSeverity',
      '8': {},
      '10': 'severity'
    },
    {'1': 'insert_id', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'insertId'},
    {
      '1': 'http_request',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.logging.type.HttpRequest',
      '8': {},
      '10': 'httpRequest'
    },
    {
      '1': 'labels',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogEntry.LabelsEntry',
      '8': {},
      '10': 'labels'
    },
    {
      '1': 'operation',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogEntryOperation',
      '8': {},
      '10': 'operation'
    },
    {'1': 'trace', '3': 22, '4': 1, '5': 9, '8': {}, '10': 'trace'},
    {'1': 'span_id', '3': 27, '4': 1, '5': 9, '8': {}, '10': 'spanId'},
    {
      '1': 'trace_sampled',
      '3': 30,
      '4': 1,
      '5': 8,
      '8': {},
      '10': 'traceSampled'
    },
    {
      '1': 'source_location',
      '3': 23,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogEntrySourceLocation',
      '8': {},
      '10': 'sourceLocation'
    },
    {
      '1': 'split',
      '3': 35,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogSplit',
      '8': {},
      '10': 'split'
    },
  ],
  '3': [LogEntry_LabelsEntry$json],
  '7': {},
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
    'CghMb2dFbnRyeRIeCghsb2dfbmFtZRgMIAEoCUID4EECUgdsb2dOYW1lEj4KCHJlc291cmNlGA'
    'ggASgLMh0uZ29vZ2xlLmFwaS5Nb25pdG9yZWRSZXNvdXJjZUID4EECUghyZXNvdXJjZRI7Cg1w'
    'cm90b19wYXlsb2FkGAIgASgLMhQuZ29vZ2xlLnByb3RvYnVmLkFueUgAUgxwcm90b1BheWxvYW'
    'QSIwoMdGV4dF9wYXlsb2FkGAMgASgJSABSC3RleHRQYXlsb2FkEjwKDGpzb25fcGF5bG9hZBgG'
    'IAEoCzIXLmdvb2dsZS5wcm90b2J1Zi5TdHJ1Y3RIAFILanNvblBheWxvYWQSPQoJdGltZXN0YW'
    '1wGAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcEID4EEBUgl0aW1lc3RhbXASTAoR'
    'cmVjZWl2ZV90aW1lc3RhbXAYGCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wQgPgQQ'
    'NSEHJlY2VpdmVUaW1lc3RhbXASQQoIc2V2ZXJpdHkYCiABKA4yIC5nb29nbGUubG9nZ2luZy50'
    'eXBlLkxvZ1NldmVyaXR5QgPgQQFSCHNldmVyaXR5EiAKCWluc2VydF9pZBgEIAEoCUID4EEBUg'
    'hpbnNlcnRJZBJICgxodHRwX3JlcXVlc3QYByABKAsyIC5nb29nbGUubG9nZ2luZy50eXBlLkh0'
    'dHBSZXF1ZXN0QgPgQQFSC2h0dHBSZXF1ZXN0EkQKBmxhYmVscxgLIAMoCzInLmdvb2dsZS5sb2'
    'dnaW5nLnYyLkxvZ0VudHJ5LkxhYmVsc0VudHJ5QgPgQQFSBmxhYmVscxJHCglvcGVyYXRpb24Y'
    'DyABKAsyJC5nb29nbGUubG9nZ2luZy52Mi5Mb2dFbnRyeU9wZXJhdGlvbkID4EEBUglvcGVyYX'
    'Rpb24SGQoFdHJhY2UYFiABKAlCA+BBAVIFdHJhY2USHAoHc3Bhbl9pZBgbIAEoCUID4EEBUgZz'
    'cGFuSWQSKAoNdHJhY2Vfc2FtcGxlZBgeIAEoCEID4EEBUgx0cmFjZVNhbXBsZWQSVwoPc291cm'
    'NlX2xvY2F0aW9uGBcgASgLMikuZ29vZ2xlLmxvZ2dpbmcudjIuTG9nRW50cnlTb3VyY2VMb2Nh'
    'dGlvbkID4EEBUg5zb3VyY2VMb2NhdGlvbhI2CgVzcGxpdBgjIAEoCzIbLmdvb2dsZS5sb2dnaW'
    '5nLnYyLkxvZ1NwbGl0QgPgQQFSBXNwbGl0GjkKC0xhYmVsc0VudHJ5EhAKA2tleRgBIAEoCVID'
    'a2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE6vQHqQbkBChpsb2dnaW5nLmdvb2dsZWFwaX'
    'MuY29tL0xvZxIdcHJvamVjdHMve3Byb2plY3R9L2xvZ3Mve2xvZ30SJ29yZ2FuaXphdGlvbnMv'
    'e29yZ2FuaXphdGlvbn0vbG9ncy97bG9nfRIbZm9sZGVycy97Zm9sZGVyfS9sb2dzL3tsb2d9Ei'
    'xiaWxsaW5nQWNjb3VudHMve2JpbGxpbmdfYWNjb3VudH0vbG9ncy97bG9nfRoIbG9nX25hbWVC'
    'CQoHcGF5bG9hZA==');

@$core.Deprecated('Use logEntryOperationDescriptor instead')
const LogEntryOperation$json = {
  '1': 'LogEntryOperation',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {'1': 'producer', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'producer'},
    {'1': 'first', '3': 3, '4': 1, '5': 8, '8': {}, '10': 'first'},
    {'1': 'last', '3': 4, '4': 1, '5': 8, '8': {}, '10': 'last'},
  ],
};

/// Descriptor for `LogEntryOperation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEntryOperationDescriptor = $convert.base64Decode(
    'ChFMb2dFbnRyeU9wZXJhdGlvbhITCgJpZBgBIAEoCUID4EEBUgJpZBIfCghwcm9kdWNlchgCIA'
    'EoCUID4EEBUghwcm9kdWNlchIZCgVmaXJzdBgDIAEoCEID4EEBUgVmaXJzdBIXCgRsYXN0GAQg'
    'ASgIQgPgQQFSBGxhc3Q=');

@$core.Deprecated('Use logEntrySourceLocationDescriptor instead')
const LogEntrySourceLocation$json = {
  '1': 'LogEntrySourceLocation',
  '2': [
    {'1': 'file', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'file'},
    {'1': 'line', '3': 2, '4': 1, '5': 3, '8': {}, '10': 'line'},
    {'1': 'function', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'function'},
  ],
};

/// Descriptor for `LogEntrySourceLocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEntrySourceLocationDescriptor = $convert.base64Decode(
    'ChZMb2dFbnRyeVNvdXJjZUxvY2F0aW9uEhcKBGZpbGUYASABKAlCA+BBAVIEZmlsZRIXCgRsaW'
    '5lGAIgASgDQgPgQQFSBGxpbmUSHwoIZnVuY3Rpb24YAyABKAlCA+BBAVIIZnVuY3Rpb24=');

@$core.Deprecated('Use logSplitDescriptor instead')
const LogSplit$json = {
  '1': 'LogSplit',
  '2': [
    {'1': 'uid', '3': 1, '4': 1, '5': 9, '10': 'uid'},
    {'1': 'index', '3': 2, '4': 1, '5': 5, '10': 'index'},
    {'1': 'total_splits', '3': 3, '4': 1, '5': 5, '10': 'totalSplits'},
  ],
};

/// Descriptor for `LogSplit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logSplitDescriptor = $convert.base64Decode(
    'CghMb2dTcGxpdBIQCgN1aWQYASABKAlSA3VpZBIUCgVpbmRleBgCIAEoBVIFaW5kZXgSIQoMdG'
    '90YWxfc3BsaXRzGAMgASgFUgt0b3RhbFNwbGl0cw==');
