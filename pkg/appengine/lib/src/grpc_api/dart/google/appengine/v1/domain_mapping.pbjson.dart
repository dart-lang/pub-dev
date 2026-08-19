//
//  Generated code. Do not modify.
//  source: google/appengine/v1/domain_mapping.proto
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
      '6': '.google.appengine.v1.SslSettings',
      '10': 'sslSettings'
    },
    {
      '1': 'resource_records',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1.ResourceRecord',
      '10': 'resourceRecords'
    },
  ],
};

/// Descriptor for `DomainMapping`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List domainMappingDescriptor = $convert.base64Decode(
    'Cg1Eb21haW5NYXBwaW5nEhIKBG5hbWUYASABKAlSBG5hbWUSDgoCaWQYAiABKAlSAmlkEkMKDH'
    'NzbF9zZXR0aW5ncxgDIAEoCzIgLmdvb2dsZS5hcHBlbmdpbmUudjEuU3NsU2V0dGluZ3NSC3Nz'
    'bFNldHRpbmdzEk4KEHJlc291cmNlX3JlY29yZHMYBCADKAsyIy5nb29nbGUuYXBwZW5naW5lLn'
    'YxLlJlc291cmNlUmVjb3JkUg9yZXNvdXJjZVJlY29yZHM=');

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
      '6': '.google.appengine.v1.SslSettings.SslManagementType',
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
    {'1': 'SSL_MANAGEMENT_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'AUTOMATIC', '2': 1},
    {'1': 'MANUAL', '2': 2},
  ],
};

/// Descriptor for `SslSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sslSettingsDescriptor = $convert.base64Decode(
    'CgtTc2xTZXR0aW5ncxIlCg5jZXJ0aWZpY2F0ZV9pZBgBIAEoCVINY2VydGlmaWNhdGVJZBJiCh'
    'Nzc2xfbWFuYWdlbWVudF90eXBlGAMgASgOMjIuZ29vZ2xlLmFwcGVuZ2luZS52MS5Tc2xTZXR0'
    'aW5ncy5Tc2xNYW5hZ2VtZW50VHlwZVIRc3NsTWFuYWdlbWVudFR5cGUSQwoecGVuZGluZ19tYW'
    '5hZ2VkX2NlcnRpZmljYXRlX2lkGAQgASgJUhtwZW5kaW5nTWFuYWdlZENlcnRpZmljYXRlSWQi'
    'UwoRU3NsTWFuYWdlbWVudFR5cGUSIwofU1NMX01BTkFHRU1FTlRfVFlQRV9VTlNQRUNJRklFRB'
    'AAEg0KCUFVVE9NQVRJQxABEgoKBk1BTlVBTBAC');

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
      '6': '.google.appengine.v1.ResourceRecord.RecordType',
      '10': 'type'
    },
  ],
  '4': [ResourceRecord_RecordType$json],
};

@$core.Deprecated('Use resourceRecordDescriptor instead')
const ResourceRecord_RecordType$json = {
  '1': 'RecordType',
  '2': [
    {'1': 'RECORD_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'A', '2': 1},
    {'1': 'AAAA', '2': 2},
    {'1': 'CNAME', '2': 3},
  ],
};

/// Descriptor for `ResourceRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resourceRecordDescriptor = $convert.base64Decode(
    'Cg5SZXNvdXJjZVJlY29yZBISCgRuYW1lGAEgASgJUgRuYW1lEhYKBnJyZGF0YRgCIAEoCVIGcn'
    'JkYXRhEkIKBHR5cGUYAyABKA4yLi5nb29nbGUuYXBwZW5naW5lLnYxLlJlc291cmNlUmVjb3Jk'
    'LlJlY29yZFR5cGVSBHR5cGUiRQoKUmVjb3JkVHlwZRIbChdSRUNPUkRfVFlQRV9VTlNQRUNJRk'
    'lFRBAAEgUKAUEQARIICgRBQUFBEAISCQoFQ05BTUUQAw==');
