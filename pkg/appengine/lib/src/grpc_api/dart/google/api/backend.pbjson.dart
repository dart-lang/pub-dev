//
//  Generated code. Do not modify.
//  source: google/api/backend.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use backendDescriptor instead')
const Backend$json = {
  '1': 'Backend',
  '2': [
    {
      '1': 'rules',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.BackendRule',
      '10': 'rules'
    },
  ],
};

/// Descriptor for `Backend`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List backendDescriptor = $convert.base64Decode(
    'CgdCYWNrZW5kEi0KBXJ1bGVzGAEgAygLMhcuZ29vZ2xlLmFwaS5CYWNrZW5kUnVsZVIFcnVsZX'
    'M=');

@$core.Deprecated('Use backendRuleDescriptor instead')
const BackendRule$json = {
  '1': 'BackendRule',
  '2': [
    {'1': 'selector', '3': 1, '4': 1, '5': 9, '10': 'selector'},
    {'1': 'address', '3': 2, '4': 1, '5': 9, '10': 'address'},
    {'1': 'deadline', '3': 3, '4': 1, '5': 1, '10': 'deadline'},
    {
      '1': 'min_deadline',
      '3': 4,
      '4': 1,
      '5': 1,
      '8': {'3': true},
      '10': 'minDeadline',
    },
    {
      '1': 'operation_deadline',
      '3': 5,
      '4': 1,
      '5': 1,
      '10': 'operationDeadline'
    },
    {
      '1': 'path_translation',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.google.api.BackendRule.PathTranslation',
      '10': 'pathTranslation'
    },
    {'1': 'jwt_audience', '3': 7, '4': 1, '5': 9, '9': 0, '10': 'jwtAudience'},
    {'1': 'disable_auth', '3': 8, '4': 1, '5': 8, '9': 0, '10': 'disableAuth'},
    {'1': 'protocol', '3': 9, '4': 1, '5': 9, '10': 'protocol'},
    {
      '1': 'overrides_by_request_protocol',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.google.api.BackendRule.OverridesByRequestProtocolEntry',
      '10': 'overridesByRequestProtocol'
    },
  ],
  '3': [BackendRule_OverridesByRequestProtocolEntry$json],
  '4': [BackendRule_PathTranslation$json],
  '8': [
    {'1': 'authentication'},
  ],
};

@$core.Deprecated('Use backendRuleDescriptor instead')
const BackendRule_OverridesByRequestProtocolEntry$json = {
  '1': 'OverridesByRequestProtocolEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.BackendRule',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use backendRuleDescriptor instead')
const BackendRule_PathTranslation$json = {
  '1': 'PathTranslation',
  '2': [
    {'1': 'PATH_TRANSLATION_UNSPECIFIED', '2': 0},
    {'1': 'CONSTANT_ADDRESS', '2': 1},
    {'1': 'APPEND_PATH_TO_ADDRESS', '2': 2},
  ],
};

/// Descriptor for `BackendRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List backendRuleDescriptor = $convert.base64Decode(
    'CgtCYWNrZW5kUnVsZRIaCghzZWxlY3RvchgBIAEoCVIIc2VsZWN0b3ISGAoHYWRkcmVzcxgCIA'
    'EoCVIHYWRkcmVzcxIaCghkZWFkbGluZRgDIAEoAVIIZGVhZGxpbmUSJQoMbWluX2RlYWRsaW5l'
    'GAQgASgBQgIYAVILbWluRGVhZGxpbmUSLQoSb3BlcmF0aW9uX2RlYWRsaW5lGAUgASgBUhFvcG'
    'VyYXRpb25EZWFkbGluZRJSChBwYXRoX3RyYW5zbGF0aW9uGAYgASgOMicuZ29vZ2xlLmFwaS5C'
    'YWNrZW5kUnVsZS5QYXRoVHJhbnNsYXRpb25SD3BhdGhUcmFuc2xhdGlvbhIjCgxqd3RfYXVkaW'
    'VuY2UYByABKAlIAFILand0QXVkaWVuY2USIwoMZGlzYWJsZV9hdXRoGAggASgISABSC2Rpc2Fi'
    'bGVBdXRoEhoKCHByb3RvY29sGAkgASgJUghwcm90b2NvbBJ6Ch1vdmVycmlkZXNfYnlfcmVxdW'
    'VzdF9wcm90b2NvbBgKIAMoCzI3Lmdvb2dsZS5hcGkuQmFja2VuZFJ1bGUuT3ZlcnJpZGVzQnlS'
    'ZXF1ZXN0UHJvdG9jb2xFbnRyeVIab3ZlcnJpZGVzQnlSZXF1ZXN0UHJvdG9jb2waZgofT3Zlcn'
    'JpZGVzQnlSZXF1ZXN0UHJvdG9jb2xFbnRyeRIQCgNrZXkYASABKAlSA2tleRItCgV2YWx1ZRgC'
    'IAEoCzIXLmdvb2dsZS5hcGkuQmFja2VuZFJ1bGVSBXZhbHVlOgI4ASJlCg9QYXRoVHJhbnNsYX'
    'Rpb24SIAocUEFUSF9UUkFOU0xBVElPTl9VTlNQRUNJRklFRBAAEhQKEENPTlNUQU5UX0FERFJF'
    'U1MQARIaChZBUFBFTkRfUEFUSF9UT19BRERSRVNTEAJCEAoOYXV0aGVudGljYXRpb24=');
