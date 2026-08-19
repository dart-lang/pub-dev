//
//  Generated code. Do not modify.
//  source: google/api/apikeys/v2/resources.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use keyDescriptor instead')
const Key$json = {
  '1': 'Key',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'uid', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'uid'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'key_string', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'keyString'},
    {
      '1': 'create_time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'createTime'
    },
    {
      '1': 'update_time',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'updateTime'
    },
    {
      '1': 'delete_time',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'deleteTime'
    },
    {
      '1': 'annotations',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.google.api.apikeys.v2.Key.AnnotationsEntry',
      '10': 'annotations'
    },
    {
      '1': 'restrictions',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.api.apikeys.v2.Restrictions',
      '10': 'restrictions'
    },
    {'1': 'etag', '3': 11, '4': 1, '5': 9, '8': {}, '10': 'etag'},
  ],
  '3': [Key_AnnotationsEntry$json],
  '7': {},
};

@$core.Deprecated('Use keyDescriptor instead')
const Key_AnnotationsEntry$json = {
  '1': 'AnnotationsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Key`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyDescriptor = $convert.base64Decode(
    'CgNLZXkSFwoEbmFtZRgBIAEoCUID4EEDUgRuYW1lEhUKA3VpZBgFIAEoCUID4EEDUgN1aWQSIQ'
    'oMZGlzcGxheV9uYW1lGAIgASgJUgtkaXNwbGF5TmFtZRIiCgprZXlfc3RyaW5nGAMgASgJQgPg'
    'QQNSCWtleVN0cmluZxJACgtjcmVhdGVfdGltZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW'
    '1lc3RhbXBCA+BBA1IKY3JlYXRlVGltZRJACgt1cGRhdGVfdGltZRgGIAEoCzIaLmdvb2dsZS5w'
    'cm90b2J1Zi5UaW1lc3RhbXBCA+BBA1IKdXBkYXRlVGltZRJACgtkZWxldGVfdGltZRgHIAEoCz'
    'IaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCA+BBA1IKZGVsZXRlVGltZRJNCgthbm5vdGF0'
    'aW9ucxgIIAMoCzIrLmdvb2dsZS5hcGkuYXBpa2V5cy52Mi5LZXkuQW5ub3RhdGlvbnNFbnRyeV'
    'ILYW5ub3RhdGlvbnMSRwoMcmVzdHJpY3Rpb25zGAkgASgLMiMuZ29vZ2xlLmFwaS5hcGlrZXlz'
    'LnYyLlJlc3RyaWN0aW9uc1IMcmVzdHJpY3Rpb25zEhcKBGV0YWcYCyABKAlCA+BBA1IEZXRhZx'
    'o+ChBBbm5vdGF0aW9uc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2'
    'YWx1ZToCOAE6YepBXgoaYXBpa2V5cy5nb29nbGVhcGlzLmNvbS9LZXkSMnByb2plY3RzL3twcm'
    '9qZWN0fS9sb2NhdGlvbnMve2xvY2F0aW9ufS9rZXlzL3trZXl9KgRrZXlzMgNrZXlSAQE=');

@$core.Deprecated('Use restrictionsDescriptor instead')
const Restrictions$json = {
  '1': 'Restrictions',
  '2': [
    {
      '1': 'browser_key_restrictions',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.apikeys.v2.BrowserKeyRestrictions',
      '9': 0,
      '10': 'browserKeyRestrictions'
    },
    {
      '1': 'server_key_restrictions',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.apikeys.v2.ServerKeyRestrictions',
      '9': 0,
      '10': 'serverKeyRestrictions'
    },
    {
      '1': 'android_key_restrictions',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.api.apikeys.v2.AndroidKeyRestrictions',
      '9': 0,
      '10': 'androidKeyRestrictions'
    },
    {
      '1': 'ios_key_restrictions',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.api.apikeys.v2.IosKeyRestrictions',
      '9': 0,
      '10': 'iosKeyRestrictions'
    },
    {
      '1': 'api_targets',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.google.api.apikeys.v2.ApiTarget',
      '10': 'apiTargets'
    },
  ],
  '8': [
    {'1': 'client_restrictions'},
  ],
};

/// Descriptor for `Restrictions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List restrictionsDescriptor = $convert.base64Decode(
    'CgxSZXN0cmljdGlvbnMSaQoYYnJvd3Nlcl9rZXlfcmVzdHJpY3Rpb25zGAEgASgLMi0uZ29vZ2'
    'xlLmFwaS5hcGlrZXlzLnYyLkJyb3dzZXJLZXlSZXN0cmljdGlvbnNIAFIWYnJvd3NlcktleVJl'
    'c3RyaWN0aW9ucxJmChdzZXJ2ZXJfa2V5X3Jlc3RyaWN0aW9ucxgCIAEoCzIsLmdvb2dsZS5hcG'
    'kuYXBpa2V5cy52Mi5TZXJ2ZXJLZXlSZXN0cmljdGlvbnNIAFIVc2VydmVyS2V5UmVzdHJpY3Rp'
    'b25zEmkKGGFuZHJvaWRfa2V5X3Jlc3RyaWN0aW9ucxgDIAEoCzItLmdvb2dsZS5hcGkuYXBpa2'
    'V5cy52Mi5BbmRyb2lkS2V5UmVzdHJpY3Rpb25zSABSFmFuZHJvaWRLZXlSZXN0cmljdGlvbnMS'
    'XQoUaW9zX2tleV9yZXN0cmljdGlvbnMYBCABKAsyKS5nb29nbGUuYXBpLmFwaWtleXMudjIuSW'
    '9zS2V5UmVzdHJpY3Rpb25zSABSEmlvc0tleVJlc3RyaWN0aW9ucxJBCgthcGlfdGFyZ2V0cxgF'
    'IAMoCzIgLmdvb2dsZS5hcGkuYXBpa2V5cy52Mi5BcGlUYXJnZXRSCmFwaVRhcmdldHNCFQoTY2'
    'xpZW50X3Jlc3RyaWN0aW9ucw==');

@$core.Deprecated('Use browserKeyRestrictionsDescriptor instead')
const BrowserKeyRestrictions$json = {
  '1': 'BrowserKeyRestrictions',
  '2': [
    {
      '1': 'allowed_referrers',
      '3': 1,
      '4': 3,
      '5': 9,
      '10': 'allowedReferrers'
    },
  ],
};

/// Descriptor for `BrowserKeyRestrictions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List browserKeyRestrictionsDescriptor =
    $convert.base64Decode(
        'ChZCcm93c2VyS2V5UmVzdHJpY3Rpb25zEisKEWFsbG93ZWRfcmVmZXJyZXJzGAEgAygJUhBhbG'
        'xvd2VkUmVmZXJyZXJz');

@$core.Deprecated('Use serverKeyRestrictionsDescriptor instead')
const ServerKeyRestrictions$json = {
  '1': 'ServerKeyRestrictions',
  '2': [
    {'1': 'allowed_ips', '3': 1, '4': 3, '5': 9, '10': 'allowedIps'},
  ],
};

/// Descriptor for `ServerKeyRestrictions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverKeyRestrictionsDescriptor = $convert.base64Decode(
    'ChVTZXJ2ZXJLZXlSZXN0cmljdGlvbnMSHwoLYWxsb3dlZF9pcHMYASADKAlSCmFsbG93ZWRJcH'
    'M=');

@$core.Deprecated('Use androidKeyRestrictionsDescriptor instead')
const AndroidKeyRestrictions$json = {
  '1': 'AndroidKeyRestrictions',
  '2': [
    {
      '1': 'allowed_applications',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.apikeys.v2.AndroidApplication',
      '10': 'allowedApplications'
    },
  ],
};

/// Descriptor for `AndroidKeyRestrictions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List androidKeyRestrictionsDescriptor = $convert.base64Decode(
    'ChZBbmRyb2lkS2V5UmVzdHJpY3Rpb25zElwKFGFsbG93ZWRfYXBwbGljYXRpb25zGAEgAygLMi'
    'kuZ29vZ2xlLmFwaS5hcGlrZXlzLnYyLkFuZHJvaWRBcHBsaWNhdGlvblITYWxsb3dlZEFwcGxp'
    'Y2F0aW9ucw==');

@$core.Deprecated('Use androidApplicationDescriptor instead')
const AndroidApplication$json = {
  '1': 'AndroidApplication',
  '2': [
    {'1': 'sha1_fingerprint', '3': 1, '4': 1, '5': 9, '10': 'sha1Fingerprint'},
    {'1': 'package_name', '3': 2, '4': 1, '5': 9, '10': 'packageName'},
  ],
};

/// Descriptor for `AndroidApplication`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List androidApplicationDescriptor = $convert.base64Decode(
    'ChJBbmRyb2lkQXBwbGljYXRpb24SKQoQc2hhMV9maW5nZXJwcmludBgBIAEoCVIPc2hhMUZpbm'
    'dlcnByaW50EiEKDHBhY2thZ2VfbmFtZRgCIAEoCVILcGFja2FnZU5hbWU=');

@$core.Deprecated('Use iosKeyRestrictionsDescriptor instead')
const IosKeyRestrictions$json = {
  '1': 'IosKeyRestrictions',
  '2': [
    {
      '1': 'allowed_bundle_ids',
      '3': 1,
      '4': 3,
      '5': 9,
      '10': 'allowedBundleIds'
    },
  ],
};

/// Descriptor for `IosKeyRestrictions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List iosKeyRestrictionsDescriptor = $convert.base64Decode(
    'ChJJb3NLZXlSZXN0cmljdGlvbnMSLAoSYWxsb3dlZF9idW5kbGVfaWRzGAEgAygJUhBhbGxvd2'
    'VkQnVuZGxlSWRz');

@$core.Deprecated('Use apiTargetDescriptor instead')
const ApiTarget$json = {
  '1': 'ApiTarget',
  '2': [
    {'1': 'service', '3': 1, '4': 1, '5': 9, '10': 'service'},
    {'1': 'methods', '3': 2, '4': 3, '5': 9, '8': {}, '10': 'methods'},
  ],
};

/// Descriptor for `ApiTarget`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List apiTargetDescriptor = $convert.base64Decode(
    'CglBcGlUYXJnZXQSGAoHc2VydmljZRgBIAEoCVIHc2VydmljZRIdCgdtZXRob2RzGAIgAygJQg'
    'PgQQFSB21ldGhvZHM=');
