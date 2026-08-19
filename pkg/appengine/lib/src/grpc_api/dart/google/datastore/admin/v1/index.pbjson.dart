//
//  Generated code. Do not modify.
//  source: google/datastore/admin/v1/index.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use indexDescriptor instead')
const Index$json = {
  '1': 'Index',
  '2': [
    {'1': 'project_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'projectId'},
    {'1': 'index_id', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'indexId'},
    {'1': 'kind', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'kind'},
    {
      '1': 'ancestor',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.admin.v1.Index.AncestorMode',
      '8': {},
      '10': 'ancestor'
    },
    {
      '1': 'properties',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.google.datastore.admin.v1.Index.IndexedProperty',
      '8': {},
      '10': 'properties'
    },
    {
      '1': 'state',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.admin.v1.Index.State',
      '8': {},
      '10': 'state'
    },
  ],
  '3': [Index_IndexedProperty$json],
  '4': [Index_AncestorMode$json, Index_Direction$json, Index_State$json],
};

@$core.Deprecated('Use indexDescriptor instead')
const Index_IndexedProperty$json = {
  '1': 'IndexedProperty',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {
      '1': 'direction',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.datastore.admin.v1.Index.Direction',
      '8': {},
      '10': 'direction'
    },
  ],
};

@$core.Deprecated('Use indexDescriptor instead')
const Index_AncestorMode$json = {
  '1': 'AncestorMode',
  '2': [
    {'1': 'ANCESTOR_MODE_UNSPECIFIED', '2': 0},
    {'1': 'NONE', '2': 1},
    {'1': 'ALL_ANCESTORS', '2': 2},
  ],
};

@$core.Deprecated('Use indexDescriptor instead')
const Index_Direction$json = {
  '1': 'Direction',
  '2': [
    {'1': 'DIRECTION_UNSPECIFIED', '2': 0},
    {'1': 'ASCENDING', '2': 1},
    {'1': 'DESCENDING', '2': 2},
  ],
};

@$core.Deprecated('Use indexDescriptor instead')
const Index_State$json = {
  '1': 'State',
  '2': [
    {'1': 'STATE_UNSPECIFIED', '2': 0},
    {'1': 'CREATING', '2': 1},
    {'1': 'READY', '2': 2},
    {'1': 'DELETING', '2': 3},
    {'1': 'ERROR', '2': 4},
  ],
};

/// Descriptor for `Index`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexDescriptor = $convert.base64Decode(
    'CgVJbmRleBIiCgpwcm9qZWN0X2lkGAEgASgJQgPgQQNSCXByb2plY3RJZBIeCghpbmRleF9pZB'
    'gDIAEoCUID4EEDUgdpbmRleElkEhcKBGtpbmQYBCABKAlCA+BBAlIEa2luZBJOCghhbmNlc3Rv'
    'chgFIAEoDjItLmdvb2dsZS5kYXRhc3RvcmUuYWRtaW4udjEuSW5kZXguQW5jZXN0b3JNb2RlQg'
    'PgQQJSCGFuY2VzdG9yElUKCnByb3BlcnRpZXMYBiADKAsyMC5nb29nbGUuZGF0YXN0b3JlLmFk'
    'bWluLnYxLkluZGV4LkluZGV4ZWRQcm9wZXJ0eUID4EECUgpwcm9wZXJ0aWVzEkEKBXN0YXRlGA'
    'cgASgOMiYuZ29vZ2xlLmRhdGFzdG9yZS5hZG1pbi52MS5JbmRleC5TdGF0ZUID4EEDUgVzdGF0'
    'ZRp5Cg9JbmRleGVkUHJvcGVydHkSFwoEbmFtZRgBIAEoCUID4EECUgRuYW1lEk0KCWRpcmVjdG'
    'lvbhgCIAEoDjIqLmdvb2dsZS5kYXRhc3RvcmUuYWRtaW4udjEuSW5kZXguRGlyZWN0aW9uQgPg'
    'QQJSCWRpcmVjdGlvbiJKCgxBbmNlc3Rvck1vZGUSHQoZQU5DRVNUT1JfTU9ERV9VTlNQRUNJRk'
    'lFRBAAEggKBE5PTkUQARIRCg1BTExfQU5DRVNUT1JTEAIiRQoJRGlyZWN0aW9uEhkKFURJUkVD'
    'VElPTl9VTlNQRUNJRklFRBAAEg0KCUFTQ0VORElORxABEg4KCkRFU0NFTkRJTkcQAiJQCgVTdG'
    'F0ZRIVChFTVEFURV9VTlNQRUNJRklFRBAAEgwKCENSRUFUSU5HEAESCQoFUkVBRFkQAhIMCghE'
    'RUxFVElORxADEgkKBUVSUk9SEAQ=');
