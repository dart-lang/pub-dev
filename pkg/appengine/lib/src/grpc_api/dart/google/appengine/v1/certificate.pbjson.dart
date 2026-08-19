//
//  Generated code. Do not modify.
//  source: google/appengine/v1/certificate.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use managementStatusDescriptor instead')
const ManagementStatus$json = {
  '1': 'ManagementStatus',
  '2': [
    {'1': 'MANAGEMENT_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'OK', '2': 1},
    {'1': 'PENDING', '2': 2},
    {'1': 'FAILED_RETRYING_NOT_VISIBLE', '2': 4},
    {'1': 'FAILED_PERMANENT', '2': 6},
    {'1': 'FAILED_RETRYING_CAA_FORBIDDEN', '2': 7},
    {'1': 'FAILED_RETRYING_CAA_CHECKING', '2': 8},
  ],
};

/// Descriptor for `ManagementStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List managementStatusDescriptor = $convert.base64Decode(
    'ChBNYW5hZ2VtZW50U3RhdHVzEiEKHU1BTkFHRU1FTlRfU1RBVFVTX1VOU1BFQ0lGSUVEEAASBg'
    'oCT0sQARILCgdQRU5ESU5HEAISHwobRkFJTEVEX1JFVFJZSU5HX05PVF9WSVNJQkxFEAQSFAoQ'
    'RkFJTEVEX1BFUk1BTkVOVBAGEiEKHUZBSUxFRF9SRVRSWUlOR19DQUFfRk9SQklEREVOEAcSIA'
    'ocRkFJTEVEX1JFVFJZSU5HX0NBQV9DSEVDS0lORxAI');

@$core.Deprecated('Use authorizedCertificateDescriptor instead')
const AuthorizedCertificate$json = {
  '1': 'AuthorizedCertificate',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'domain_names', '3': 4, '4': 3, '5': 9, '10': 'domainNames'},
    {
      '1': 'expire_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'expireTime'
    },
    {
      '1': 'certificate_raw_data',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.CertificateRawData',
      '10': 'certificateRawData'
    },
    {
      '1': 'managed_certificate',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1.ManagedCertificate',
      '10': 'managedCertificate'
    },
    {
      '1': 'visible_domain_mappings',
      '3': 8,
      '4': 3,
      '5': 9,
      '10': 'visibleDomainMappings'
    },
    {
      '1': 'domain_mappings_count',
      '3': 9,
      '4': 1,
      '5': 5,
      '10': 'domainMappingsCount'
    },
  ],
};

/// Descriptor for `AuthorizedCertificate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authorizedCertificateDescriptor = $convert.base64Decode(
    'ChVBdXRob3JpemVkQ2VydGlmaWNhdGUSEgoEbmFtZRgBIAEoCVIEbmFtZRIOCgJpZBgCIAEoCV'
    'ICaWQSIQoMZGlzcGxheV9uYW1lGAMgASgJUgtkaXNwbGF5TmFtZRIhCgxkb21haW5fbmFtZXMY'
    'BCADKAlSC2RvbWFpbk5hbWVzEjsKC2V4cGlyZV90aW1lGAUgASgLMhouZ29vZ2xlLnByb3RvYn'
    'VmLlRpbWVzdGFtcFIKZXhwaXJlVGltZRJZChRjZXJ0aWZpY2F0ZV9yYXdfZGF0YRgGIAEoCzIn'
    'Lmdvb2dsZS5hcHBlbmdpbmUudjEuQ2VydGlmaWNhdGVSYXdEYXRhUhJjZXJ0aWZpY2F0ZVJhd0'
    'RhdGESWAoTbWFuYWdlZF9jZXJ0aWZpY2F0ZRgHIAEoCzInLmdvb2dsZS5hcHBlbmdpbmUudjEu'
    'TWFuYWdlZENlcnRpZmljYXRlUhJtYW5hZ2VkQ2VydGlmaWNhdGUSNgoXdmlzaWJsZV9kb21haW'
    '5fbWFwcGluZ3MYCCADKAlSFXZpc2libGVEb21haW5NYXBwaW5ncxIyChVkb21haW5fbWFwcGlu'
    'Z3NfY291bnQYCSABKAVSE2RvbWFpbk1hcHBpbmdzQ291bnQ=');

@$core.Deprecated('Use certificateRawDataDescriptor instead')
const CertificateRawData$json = {
  '1': 'CertificateRawData',
  '2': [
    {
      '1': 'public_certificate',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'publicCertificate'
    },
    {'1': 'private_key', '3': 2, '4': 1, '5': 9, '10': 'privateKey'},
  ],
};

/// Descriptor for `CertificateRawData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List certificateRawDataDescriptor = $convert.base64Decode(
    'ChJDZXJ0aWZpY2F0ZVJhd0RhdGESLQoScHVibGljX2NlcnRpZmljYXRlGAEgASgJUhFwdWJsaW'
    'NDZXJ0aWZpY2F0ZRIfCgtwcml2YXRlX2tleRgCIAEoCVIKcHJpdmF0ZUtleQ==');

@$core.Deprecated('Use managedCertificateDescriptor instead')
const ManagedCertificate$json = {
  '1': 'ManagedCertificate',
  '2': [
    {
      '1': 'last_renewal_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastRenewalTime'
    },
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1.ManagementStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `ManagedCertificate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List managedCertificateDescriptor = $convert.base64Decode(
    'ChJNYW5hZ2VkQ2VydGlmaWNhdGUSRgoRbGFzdF9yZW5ld2FsX3RpbWUYASABKAsyGi5nb29nbG'
    'UucHJvdG9idWYuVGltZXN0YW1wUg9sYXN0UmVuZXdhbFRpbWUSPQoGc3RhdHVzGAIgASgOMiUu'
    'Z29vZ2xlLmFwcGVuZ2luZS52MS5NYW5hZ2VtZW50U3RhdHVzUgZzdGF0dXM=');
