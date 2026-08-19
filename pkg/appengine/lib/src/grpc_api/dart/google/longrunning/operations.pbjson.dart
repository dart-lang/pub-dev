//
//  Generated code. Do not modify.
//  source: google/longrunning/operations.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use operationDescriptor instead')
const Operation$json = {
  '1': 'Operation',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'metadata',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'metadata'
    },
    {'1': 'done', '3': 3, '4': 1, '5': 8, '10': 'done'},
    {
      '1': 'error',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.rpc.Status',
      '9': 0,
      '10': 'error'
    },
    {
      '1': 'response',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '9': 0,
      '10': 'response'
    },
  ],
  '8': [
    {'1': 'result'},
  ],
};

/// Descriptor for `Operation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List operationDescriptor = $convert.base64Decode(
    'CglPcGVyYXRpb24SEgoEbmFtZRgBIAEoCVIEbmFtZRIwCghtZXRhZGF0YRgCIAEoCzIULmdvb2'
    'dsZS5wcm90b2J1Zi5BbnlSCG1ldGFkYXRhEhIKBGRvbmUYAyABKAhSBGRvbmUSKgoFZXJyb3IY'
    'BCABKAsyEi5nb29nbGUucnBjLlN0YXR1c0gAUgVlcnJvchIyCghyZXNwb25zZRgFIAEoCzIULm'
    'dvb2dsZS5wcm90b2J1Zi5BbnlIAFIIcmVzcG9uc2VCCAoGcmVzdWx0');

@$core.Deprecated('Use getOperationRequestDescriptor instead')
const GetOperationRequest$json = {
  '1': 'GetOperationRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GetOperationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOperationRequestDescriptor = $convert
    .base64Decode('ChNHZXRPcGVyYXRpb25SZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWU=');

@$core.Deprecated('Use listOperationsRequestDescriptor instead')
const ListOperationsRequest$json = {
  '1': 'ListOperationsRequest',
  '2': [
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'filter', '3': 1, '4': 1, '5': 9, '10': 'filter'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListOperationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listOperationsRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0T3BlcmF0aW9uc1JlcXVlc3QSEgoEbmFtZRgEIAEoCVIEbmFtZRIWCgZmaWx0ZXIYAS'
    'ABKAlSBmZpbHRlchIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4Y'
    'AyABKAlSCXBhZ2VUb2tlbg==');

@$core.Deprecated('Use listOperationsResponseDescriptor instead')
const ListOperationsResponse$json = {
  '1': 'ListOperationsResponse',
  '2': [
    {
      '1': 'operations',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.longrunning.Operation',
      '10': 'operations'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListOperationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listOperationsResponseDescriptor = $convert.base64Decode(
    'ChZMaXN0T3BlcmF0aW9uc1Jlc3BvbnNlEj0KCm9wZXJhdGlvbnMYASADKAsyHS5nb29nbGUubG'
    '9uZ3J1bm5pbmcuT3BlcmF0aW9uUgpvcGVyYXRpb25zEiYKD25leHRfcGFnZV90b2tlbhgCIAEo'
    'CVINbmV4dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use cancelOperationRequestDescriptor instead')
const CancelOperationRequest$json = {
  '1': 'CancelOperationRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `CancelOperationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelOperationRequestDescriptor =
    $convert.base64Decode(
        'ChZDYW5jZWxPcGVyYXRpb25SZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWU=');

@$core.Deprecated('Use deleteOperationRequestDescriptor instead')
const DeleteOperationRequest$json = {
  '1': 'DeleteOperationRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DeleteOperationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteOperationRequestDescriptor =
    $convert.base64Decode(
        'ChZEZWxldGVPcGVyYXRpb25SZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWU=');

@$core.Deprecated('Use waitOperationRequestDescriptor instead')
const WaitOperationRequest$json = {
  '1': 'WaitOperationRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'timeout',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'timeout'
    },
  ],
};

/// Descriptor for `WaitOperationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waitOperationRequestDescriptor = $convert.base64Decode(
    'ChRXYWl0T3BlcmF0aW9uUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEjMKB3RpbWVvdXQYAi'
    'ABKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25SB3RpbWVvdXQ=');

@$core.Deprecated('Use operationInfoDescriptor instead')
const OperationInfo$json = {
  '1': 'OperationInfo',
  '2': [
    {'1': 'response_type', '3': 1, '4': 1, '5': 9, '10': 'responseType'},
    {'1': 'metadata_type', '3': 2, '4': 1, '5': 9, '10': 'metadataType'},
  ],
};

/// Descriptor for `OperationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List operationInfoDescriptor = $convert.base64Decode(
    'Cg1PcGVyYXRpb25JbmZvEiMKDXJlc3BvbnNlX3R5cGUYASABKAlSDHJlc3BvbnNlVHlwZRIjCg'
    '1tZXRhZGF0YV90eXBlGAIgASgJUgxtZXRhZGF0YVR5cGU=');
