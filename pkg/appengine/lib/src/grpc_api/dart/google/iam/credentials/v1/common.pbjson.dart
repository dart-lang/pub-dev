//
//  Generated code. Do not modify.
//  source: google/iam/credentials/v1/common.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use generateAccessTokenRequestDescriptor instead')
const GenerateAccessTokenRequest$json = {
  '1': 'GenerateAccessTokenRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'delegates', '3': 2, '4': 3, '5': 9, '10': 'delegates'},
    {'1': 'scope', '3': 4, '4': 3, '5': 9, '8': {}, '10': 'scope'},
    {
      '1': 'lifetime',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'lifetime'
    },
  ],
};

/// Descriptor for `GenerateAccessTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateAccessTokenRequestDescriptor = $convert.base64Decode(
    'ChpHZW5lcmF0ZUFjY2Vzc1Rva2VuUmVxdWVzdBI9CgRuYW1lGAEgASgJQingQQL6QSMKIWlhbS'
    '5nb29nbGVhcGlzLmNvbS9TZXJ2aWNlQWNjb3VudFIEbmFtZRIcCglkZWxlZ2F0ZXMYAiADKAlS'
    'CWRlbGVnYXRlcxIZCgVzY29wZRgEIAMoCUID4EECUgVzY29wZRI1CghsaWZldGltZRgHIAEoCz'
    'IZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblIIbGlmZXRpbWU=');

@$core.Deprecated('Use generateAccessTokenResponseDescriptor instead')
const GenerateAccessTokenResponse$json = {
  '1': 'GenerateAccessTokenResponse',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {
      '1': 'expire_time',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'expireTime'
    },
  ],
};

/// Descriptor for `GenerateAccessTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateAccessTokenResponseDescriptor =
    $convert.base64Decode(
        'ChtHZW5lcmF0ZUFjY2Vzc1Rva2VuUmVzcG9uc2USIQoMYWNjZXNzX3Rva2VuGAEgASgJUgthY2'
        'Nlc3NUb2tlbhI7CgtleHBpcmVfdGltZRgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3Rh'
        'bXBSCmV4cGlyZVRpbWU=');

@$core.Deprecated('Use signBlobRequestDescriptor instead')
const SignBlobRequest$json = {
  '1': 'SignBlobRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'delegates', '3': 3, '4': 3, '5': 9, '10': 'delegates'},
    {'1': 'payload', '3': 5, '4': 1, '5': 12, '8': {}, '10': 'payload'},
  ],
};

/// Descriptor for `SignBlobRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signBlobRequestDescriptor = $convert.base64Decode(
    'Cg9TaWduQmxvYlJlcXVlc3QSPQoEbmFtZRgBIAEoCUIp4EEC+kEjCiFpYW0uZ29vZ2xlYXBpcy'
    '5jb20vU2VydmljZUFjY291bnRSBG5hbWUSHAoJZGVsZWdhdGVzGAMgAygJUglkZWxlZ2F0ZXMS'
    'HQoHcGF5bG9hZBgFIAEoDEID4EECUgdwYXlsb2Fk');

@$core.Deprecated('Use signBlobResponseDescriptor instead')
const SignBlobResponse$json = {
  '1': 'SignBlobResponse',
  '2': [
    {'1': 'key_id', '3': 1, '4': 1, '5': 9, '10': 'keyId'},
    {'1': 'signed_blob', '3': 4, '4': 1, '5': 12, '10': 'signedBlob'},
  ],
};

/// Descriptor for `SignBlobResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signBlobResponseDescriptor = $convert.base64Decode(
    'ChBTaWduQmxvYlJlc3BvbnNlEhUKBmtleV9pZBgBIAEoCVIFa2V5SWQSHwoLc2lnbmVkX2Jsb2'
    'IYBCABKAxSCnNpZ25lZEJsb2I=');

@$core.Deprecated('Use signJwtRequestDescriptor instead')
const SignJwtRequest$json = {
  '1': 'SignJwtRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'delegates', '3': 3, '4': 3, '5': 9, '10': 'delegates'},
    {'1': 'payload', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'payload'},
  ],
};

/// Descriptor for `SignJwtRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signJwtRequestDescriptor = $convert.base64Decode(
    'Cg5TaWduSnd0UmVxdWVzdBI9CgRuYW1lGAEgASgJQingQQL6QSMKIWlhbS5nb29nbGVhcGlzLm'
    'NvbS9TZXJ2aWNlQWNjb3VudFIEbmFtZRIcCglkZWxlZ2F0ZXMYAyADKAlSCWRlbGVnYXRlcxId'
    'CgdwYXlsb2FkGAUgASgJQgPgQQJSB3BheWxvYWQ=');

@$core.Deprecated('Use signJwtResponseDescriptor instead')
const SignJwtResponse$json = {
  '1': 'SignJwtResponse',
  '2': [
    {'1': 'key_id', '3': 1, '4': 1, '5': 9, '10': 'keyId'},
    {'1': 'signed_jwt', '3': 2, '4': 1, '5': 9, '10': 'signedJwt'},
  ],
};

/// Descriptor for `SignJwtResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signJwtResponseDescriptor = $convert.base64Decode(
    'Cg9TaWduSnd0UmVzcG9uc2USFQoGa2V5X2lkGAEgASgJUgVrZXlJZBIdCgpzaWduZWRfand0GA'
    'IgASgJUglzaWduZWRKd3Q=');

@$core.Deprecated('Use generateIdTokenRequestDescriptor instead')
const GenerateIdTokenRequest$json = {
  '1': 'GenerateIdTokenRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'delegates', '3': 2, '4': 3, '5': 9, '10': 'delegates'},
    {'1': 'audience', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'audience'},
    {'1': 'include_email', '3': 4, '4': 1, '5': 8, '10': 'includeEmail'},
  ],
};

/// Descriptor for `GenerateIdTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateIdTokenRequestDescriptor = $convert.base64Decode(
    'ChZHZW5lcmF0ZUlkVG9rZW5SZXF1ZXN0Ej0KBG5hbWUYASABKAlCKeBBAvpBIwohaWFtLmdvb2'
    'dsZWFwaXMuY29tL1NlcnZpY2VBY2NvdW50UgRuYW1lEhwKCWRlbGVnYXRlcxgCIAMoCVIJZGVs'
    'ZWdhdGVzEh8KCGF1ZGllbmNlGAMgASgJQgPgQQJSCGF1ZGllbmNlEiMKDWluY2x1ZGVfZW1haW'
    'wYBCABKAhSDGluY2x1ZGVFbWFpbA==');

@$core.Deprecated('Use generateIdTokenResponseDescriptor instead')
const GenerateIdTokenResponse$json = {
  '1': 'GenerateIdTokenResponse',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `GenerateIdTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateIdTokenResponseDescriptor =
    $convert.base64Decode(
        'ChdHZW5lcmF0ZUlkVG9rZW5SZXNwb25zZRIUCgV0b2tlbhgBIAEoCVIFdG9rZW4=');
