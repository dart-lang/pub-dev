//
//  Generated code. Do not modify.
//  source: google/api/expr/v1alpha1/eval.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use evalStateDescriptor instead')
const EvalState$json = {
  '1': 'EvalState',
  '2': [
    {
      '1': 'values',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.ExprValue',
      '10': 'values'
    },
    {
      '1': 'results',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.EvalState.Result',
      '10': 'results'
    },
  ],
  '3': [EvalState_Result$json],
};

@$core.Deprecated('Use evalStateDescriptor instead')
const EvalState_Result$json = {
  '1': 'Result',
  '2': [
    {'1': 'expr', '3': 1, '4': 1, '5': 3, '10': 'expr'},
    {'1': 'value', '3': 2, '4': 1, '5': 3, '10': 'value'},
  ],
};

/// Descriptor for `EvalState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List evalStateDescriptor = $convert.base64Decode(
    'CglFdmFsU3RhdGUSOwoGdmFsdWVzGAEgAygLMiMuZ29vZ2xlLmFwaS5leHByLnYxYWxwaGExLk'
    'V4cHJWYWx1ZVIGdmFsdWVzEkQKB3Jlc3VsdHMYAyADKAsyKi5nb29nbGUuYXBpLmV4cHIudjFh'
    'bHBoYTEuRXZhbFN0YXRlLlJlc3VsdFIHcmVzdWx0cxoyCgZSZXN1bHQSEgoEZXhwchgBIAEoA1'
    'IEZXhwchIUCgV2YWx1ZRgCIAEoA1IFdmFsdWU=');

@$core.Deprecated('Use exprValueDescriptor instead')
const ExprValue$json = {
  '1': 'ExprValue',
  '2': [
    {
      '1': 'value',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.Value',
      '9': 0,
      '10': 'value'
    },
    {
      '1': 'error',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.ErrorSet',
      '9': 0,
      '10': 'error'
    },
    {
      '1': 'unknown',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.UnknownSet',
      '9': 0,
      '10': 'unknown'
    },
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `ExprValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exprValueDescriptor = $convert.base64Decode(
    'CglFeHByVmFsdWUSNwoFdmFsdWUYASABKAsyHy5nb29nbGUuYXBpLmV4cHIudjFhbHBoYTEuVm'
    'FsdWVIAFIFdmFsdWUSOgoFZXJyb3IYAiABKAsyIi5nb29nbGUuYXBpLmV4cHIudjFhbHBoYTEu'
    'RXJyb3JTZXRIAFIFZXJyb3ISQAoHdW5rbm93bhgDIAEoCzIkLmdvb2dsZS5hcGkuZXhwci52MW'
    'FscGhhMS5Vbmtub3duU2V0SABSB3Vua25vd25CBgoEa2luZA==');

@$core.Deprecated('Use errorSetDescriptor instead')
const ErrorSet$json = {
  '1': 'ErrorSet',
  '2': [
    {
      '1': 'errors',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.rpc.Status',
      '10': 'errors'
    },
  ],
};

/// Descriptor for `ErrorSet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorSetDescriptor = $convert.base64Decode(
    'CghFcnJvclNldBIqCgZlcnJvcnMYASADKAsyEi5nb29nbGUucnBjLlN0YXR1c1IGZXJyb3Jz');

@$core.Deprecated('Use unknownSetDescriptor instead')
const UnknownSet$json = {
  '1': 'UnknownSet',
  '2': [
    {'1': 'exprs', '3': 1, '4': 3, '5': 3, '10': 'exprs'},
  ],
};

/// Descriptor for `UnknownSet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unknownSetDescriptor =
    $convert.base64Decode('CgpVbmtub3duU2V0EhQKBWV4cHJzGAEgAygDUgVleHBycw==');
