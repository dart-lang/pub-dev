//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/domain_mapping.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use domainMappingDescriptor instead')
const DomainMapping$json = {
  '1': 'DomainMapping',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'ssl_settings',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.SslSettings',
      '10': 'sslSettings'
    },
    {
      '1': 'resource_records',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1beta.ResourceRecord',
      '10': 'resourceRecords'
    },
  ],
};

/// Descriptor for `DomainMapping`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List domainMappingDescriptor = $convert.base64Decode(
    'Cg1Eb21haW5NYXBwaW5nEhIKBG5hbWUYASABKAlSBG5hbWUSDgoCaWQYAiABKAlSAmlkEkcKDH'
    'NzbF9zZXR0aW5ncxgDIAEoCzIkLmdvb2dsZS5hcHBlbmdpbmUudjFiZXRhLlNzbFNldHRpbmdz'
    'Ugtzc2xTZXR0aW5ncxJSChByZXNvdXJjZV9yZWNvcmRzGAQgAygLMicuZ29vZ2xlLmFwcGVuZ2'
    'luZS52MWJldGEuUmVzb3VyY2VSZWNvcmRSD3Jlc291cmNlUmVjb3Jkcw==');

@$core.Deprecated('Use sslSettingsDescriptor instead')
const SslSettings$json = {
  '1': 'SslSettings',
  '2': [
    {'1': 'certificate_id', '3': 1, '4': 1, '5': 9, '10': 'certificateId'},
    {
      '1': 'ssl_management_type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.SslSettings.SslManagementType',
      '10': 'sslManagementType'
    },
    {
      '1': 'pending_managed_certificate_id',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'pendingManagedCertificateId'
    },
  ],
  '4': [SslSettings_SslManagementType$json],
};

@$core.Deprecated('Use sslSettingsDescriptor instead')
const SslSettings_SslManagementType$json = {
  '1': 'SslManagementType',
  '2': [
    {'1': 'AUTOMATIC', '2': 0},
    {'1': 'MANUAL', '2': 1},
  ],
};

/// Descriptor for `SslSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sslSettingsDescriptor = $convert.base64Decode(
    'CgtTc2xTZXR0aW5ncxIlCg5jZXJ0aWZpY2F0ZV9pZBgBIAEoCVINY2VydGlmaWNhdGVJZBJmCh'
    'Nzc2xfbWFuYWdlbWVudF90eXBlGAMgASgOMjYuZ29vZ2xlLmFwcGVuZ2luZS52MWJldGEuU3Ns'
    'U2V0dGluZ3MuU3NsTWFuYWdlbWVudFR5cGVSEXNzbE1hbmFnZW1lbnRUeXBlEkMKHnBlbmRpbm'
    'dfbWFuYWdlZF9jZXJ0aWZpY2F0ZV9pZBgEIAEoCVIbcGVuZGluZ01hbmFnZWRDZXJ0aWZpY2F0'
    'ZUlkIi4KEVNzbE1hbmFnZW1lbnRUeXBlEg0KCUFVVE9NQVRJQxAAEgoKBk1BTlVBTBAB');

@$core.Deprecated('Use resourceRecordDescriptor instead')
const ResourceRecord$json = {
  '1': 'ResourceRecord',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'rrdata', '3': 2, '4': 1, '5': 9, '10': 'rrdata'},
    {
      '1': 'type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.ResourceRecord.RecordType',
      '10': 'type'
    },
  ],
  '4': [ResourceRecord_RecordType$json],
};

@$core.Deprecated('Use resourceRecordDescriptor instead')
const ResourceRecord_RecordType$json = {
  '1': 'RecordType',
  '2': [
    {'1': 'A', '2': 0},
    {'1': 'AAAA', '2': 1},
    {'1': 'CNAME', '2': 2},
  ],
};

/// Descriptor for `ResourceRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resourceRecordDescriptor = $convert.base64Decode(
    'Cg5SZXNvdXJjZVJlY29yZBISCgRuYW1lGAEgASgJUgRuYW1lEhYKBnJyZGF0YRgCIAEoCVIGcn'
    'JkYXRhEkYKBHR5cGUYAyABKA4yMi5nb29nbGUuYXBwZW5naW5lLnYxYmV0YS5SZXNvdXJjZVJl'
    'Y29yZC5SZWNvcmRUeXBlUgR0eXBlIigKClJlY29yZFR5cGUSBQoBQRAAEggKBEFBQUEQARIJCg'
    'VDTkFNRRAC');
