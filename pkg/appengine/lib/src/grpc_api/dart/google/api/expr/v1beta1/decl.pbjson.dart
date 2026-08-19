//
//  Generated code. Do not modify.
//  source: google/api/expr/v1beta1/decl.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use declDescriptor instead')
const Decl$json = {
  '1': 'Decl',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'doc', '3': 3, '4': 1, '5': 9, '10': 'doc'},
    {
      '1': 'ident',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.IdentDecl',
      '9': 0,
      '10': 'ident'
    },
    {
      '1': 'function',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.FunctionDecl',
      '9': 0,
      '10': 'function'
    },
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `Decl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declDescriptor = $convert.base64Decode(
    'CgREZWNsEg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhAKA2RvYxgDIAEoCV'
    'IDZG9jEjoKBWlkZW50GAQgASgLMiIuZ29vZ2xlLmFwaS5leHByLnYxYmV0YTEuSWRlbnREZWNs'
    'SABSBWlkZW50EkMKCGZ1bmN0aW9uGAUgASgLMiUuZ29vZ2xlLmFwaS5leHByLnYxYmV0YTEuRn'
    'VuY3Rpb25EZWNsSABSCGZ1bmN0aW9uQgYKBGtpbmQ=');

@$core.Deprecated('Use declTypeDescriptor instead')
const DeclType$json = {
  '1': 'DeclType',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {
      '1': 'type_params',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.v1beta1.DeclType',
      '10': 'typeParams'
    },
  ],
};

/// Descriptor for `DeclType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declTypeDescriptor = $convert.base64Decode(
    'CghEZWNsVHlwZRIOCgJpZBgBIAEoBVICaWQSEgoEdHlwZRgCIAEoCVIEdHlwZRJCCgt0eXBlX3'
    'BhcmFtcxgEIAMoCzIhLmdvb2dsZS5hcGkuZXhwci52MWJldGExLkRlY2xUeXBlUgp0eXBlUGFy'
    'YW1z');

@$core.Deprecated('Use identDeclDescriptor instead')
const IdentDecl$json = {
  '1': 'IdentDecl',
  '2': [
    {
      '1': 'type',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.DeclType',
      '10': 'type'
    },
    {
      '1': 'value',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '10': 'value'
    },
  ],
};

/// Descriptor for `IdentDecl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List identDeclDescriptor = $convert.base64Decode(
    'CglJZGVudERlY2wSNQoEdHlwZRgDIAEoCzIhLmdvb2dsZS5hcGkuZXhwci52MWJldGExLkRlY2'
    'xUeXBlUgR0eXBlEjMKBXZhbHVlGAQgASgLMh0uZ29vZ2xlLmFwaS5leHByLnYxYmV0YTEuRXhw'
    'clIFdmFsdWU=');

@$core.Deprecated('Use functionDeclDescriptor instead')
const FunctionDecl$json = {
  '1': 'FunctionDecl',
  '2': [
    {
      '1': 'args',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.v1beta1.IdentDecl',
      '10': 'args'
    },
    {
      '1': 'return_type',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.DeclType',
      '10': 'returnType'
    },
    {
      '1': 'receiver_function',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'receiverFunction'
    },
  ],
};

/// Descriptor for `FunctionDecl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List functionDeclDescriptor = $convert.base64Decode(
    'CgxGdW5jdGlvbkRlY2wSNgoEYXJncxgBIAMoCzIiLmdvb2dsZS5hcGkuZXhwci52MWJldGExLk'
    'lkZW50RGVjbFIEYXJncxJCCgtyZXR1cm5fdHlwZRgCIAEoCzIhLmdvb2dsZS5hcGkuZXhwci52'
    'MWJldGExLkRlY2xUeXBlUgpyZXR1cm5UeXBlEisKEXJlY2VpdmVyX2Z1bmN0aW9uGAMgASgIUh'
    'ByZWNlaXZlckZ1bmN0aW9u');
