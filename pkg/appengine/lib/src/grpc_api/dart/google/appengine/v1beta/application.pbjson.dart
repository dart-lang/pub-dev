//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/application.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use applicationDescriptor instead')
const Application$json = {
  '1': 'Application',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'dispatch_rules',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1beta.UrlDispatchRule',
      '10': 'dispatchRules'
    },
    {'1': 'auth_domain', '3': 6, '4': 1, '5': 9, '10': 'authDomain'},
    {'1': 'location_id', '3': 7, '4': 1, '5': 9, '10': 'locationId'},
    {'1': 'code_bucket', '3': 8, '4': 1, '5': 9, '10': 'codeBucket'},
    {
      '1': 'default_cookie_expiration',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'defaultCookieExpiration'
    },
    {
      '1': 'serving_status',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.Application.ServingStatus',
      '10': 'servingStatus'
    },
    {'1': 'default_hostname', '3': 11, '4': 1, '5': 9, '10': 'defaultHostname'},
    {'1': 'default_bucket', '3': 12, '4': 1, '5': 9, '10': 'defaultBucket'},
    {
      '1': 'iap',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.Application.IdentityAwareProxy',
      '10': 'iap'
    },
    {'1': 'gcr_domain', '3': 16, '4': 1, '5': 9, '10': 'gcrDomain'},
    {
      '1': 'database_type',
      '3': 17,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.Application.DatabaseType',
      '10': 'databaseType'
    },
    {
      '1': 'feature_settings',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.Application.FeatureSettings',
      '10': 'featureSettings'
    },
  ],
  '3': [Application_IdentityAwareProxy$json, Application_FeatureSettings$json],
  '4': [Application_ServingStatus$json, Application_DatabaseType$json],
};

@$core.Deprecated('Use applicationDescriptor instead')
const Application_IdentityAwareProxy$json = {
  '1': 'IdentityAwareProxy',
  '2': [
    {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
    {'1': 'oauth2_client_id', '3': 2, '4': 1, '5': 9, '10': 'oauth2ClientId'},
    {
      '1': 'oauth2_client_secret',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'oauth2ClientSecret'
    },
    {
      '1': 'oauth2_client_secret_sha256',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'oauth2ClientSecretSha256'
    },
  ],
};

@$core.Deprecated('Use applicationDescriptor instead')
const Application_FeatureSettings$json = {
  '1': 'FeatureSettings',
  '2': [
    {
      '1': 'split_health_checks',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'splitHealthChecks'
    },
    {
      '1': 'use_container_optimized_os',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'useContainerOptimizedOs'
    },
  ],
};

@$core.Deprecated('Use applicationDescriptor instead')
const Application_ServingStatus$json = {
  '1': 'ServingStatus',
  '2': [
    {'1': 'UNSPECIFIED', '2': 0},
    {'1': 'SERVING', '2': 1},
    {'1': 'USER_DISABLED', '2': 2},
    {'1': 'SYSTEM_DISABLED', '2': 3},
  ],
};

@$core.Deprecated('Use applicationDescriptor instead')
const Application_DatabaseType$json = {
  '1': 'DatabaseType',
  '2': [
    {'1': 'DATABASE_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'CLOUD_DATASTORE', '2': 1},
    {'1': 'CLOUD_FIRESTORE', '2': 2},
    {'1': 'CLOUD_DATASTORE_COMPATIBILITY', '2': 3},
  ],
};

/// Descriptor for `Application`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List applicationDescriptor = $convert.base64Decode(
    'CgtBcHBsaWNhdGlvbhISCgRuYW1lGAEgASgJUgRuYW1lEg4KAmlkGAIgASgJUgJpZBJPCg5kaX'
    'NwYXRjaF9ydWxlcxgDIAMoCzIoLmdvb2dsZS5hcHBlbmdpbmUudjFiZXRhLlVybERpc3BhdGNo'
    'UnVsZVINZGlzcGF0Y2hSdWxlcxIfCgthdXRoX2RvbWFpbhgGIAEoCVIKYXV0aERvbWFpbhIfCg'
    'tsb2NhdGlvbl9pZBgHIAEoCVIKbG9jYXRpb25JZBIfCgtjb2RlX2J1Y2tldBgIIAEoCVIKY29k'
    'ZUJ1Y2tldBJVChlkZWZhdWx0X2Nvb2tpZV9leHBpcmF0aW9uGAkgASgLMhkuZ29vZ2xlLnByb3'
    'RvYnVmLkR1cmF0aW9uUhdkZWZhdWx0Q29va2llRXhwaXJhdGlvbhJZCg5zZXJ2aW5nX3N0YXR1'
    'cxgKIAEoDjIyLmdvb2dsZS5hcHBlbmdpbmUudjFiZXRhLkFwcGxpY2F0aW9uLlNlcnZpbmdTdG'
    'F0dXNSDXNlcnZpbmdTdGF0dXMSKQoQZGVmYXVsdF9ob3N0bmFtZRgLIAEoCVIPZGVmYXVsdEhv'
    'c3RuYW1lEiUKDmRlZmF1bHRfYnVja2V0GAwgASgJUg1kZWZhdWx0QnVja2V0EkkKA2lhcBgOIA'
    'EoCzI3Lmdvb2dsZS5hcHBlbmdpbmUudjFiZXRhLkFwcGxpY2F0aW9uLklkZW50aXR5QXdhcmVQ'
    'cm94eVIDaWFwEh0KCmdjcl9kb21haW4YECABKAlSCWdjckRvbWFpbhJWCg1kYXRhYmFzZV90eX'
    'BlGBEgASgOMjEuZ29vZ2xlLmFwcGVuZ2luZS52MWJldGEuQXBwbGljYXRpb24uRGF0YWJhc2VU'
    'eXBlUgxkYXRhYmFzZVR5cGUSXwoQZmVhdHVyZV9zZXR0aW5ncxgSIAEoCzI0Lmdvb2dsZS5hcH'
    'BlbmdpbmUudjFiZXRhLkFwcGxpY2F0aW9uLkZlYXR1cmVTZXR0aW5nc1IPZmVhdHVyZVNldHRp'
    'bmdzGskBChJJZGVudGl0eUF3YXJlUHJveHkSGAoHZW5hYmxlZBgBIAEoCFIHZW5hYmxlZBIoCh'
    'BvYXV0aDJfY2xpZW50X2lkGAIgASgJUg5vYXV0aDJDbGllbnRJZBIwChRvYXV0aDJfY2xpZW50'
    'X3NlY3JldBgDIAEoCVISb2F1dGgyQ2xpZW50U2VjcmV0Ej0KG29hdXRoMl9jbGllbnRfc2Vjcm'
    'V0X3NoYTI1NhgEIAEoCVIYb2F1dGgyQ2xpZW50U2VjcmV0U2hhMjU2Gn4KD0ZlYXR1cmVTZXR0'
    'aW5ncxIuChNzcGxpdF9oZWFsdGhfY2hlY2tzGAEgASgIUhFzcGxpdEhlYWx0aENoZWNrcxI7Ch'
    'p1c2VfY29udGFpbmVyX29wdGltaXplZF9vcxgCIAEoCFIXdXNlQ29udGFpbmVyT3B0aW1pemVk'
    'T3MiVQoNU2VydmluZ1N0YXR1cxIPCgtVTlNQRUNJRklFRBAAEgsKB1NFUlZJTkcQARIRCg1VU0'
    'VSX0RJU0FCTEVEEAISEwoPU1lTVEVNX0RJU0FCTEVEEAMiegoMRGF0YWJhc2VUeXBlEh0KGURB'
    'VEFCQVNFX1RZUEVfVU5TUEVDSUZJRUQQABITCg9DTE9VRF9EQVRBU1RPUkUQARITCg9DTE9VRF'
    '9GSVJFU1RPUkUQAhIhCh1DTE9VRF9EQVRBU1RPUkVfQ09NUEFUSUJJTElUWRAD');

@$core.Deprecated('Use urlDispatchRuleDescriptor instead')
const UrlDispatchRule$json = {
  '1': 'UrlDispatchRule',
  '2': [
    {'1': 'domain', '3': 1, '4': 1, '5': 9, '10': 'domain'},
    {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    {'1': 'service', '3': 3, '4': 1, '5': 9, '10': 'service'},
  ],
};

/// Descriptor for `UrlDispatchRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List urlDispatchRuleDescriptor = $convert.base64Decode(
    'Cg9VcmxEaXNwYXRjaFJ1bGUSFgoGZG9tYWluGAEgASgJUgZkb21haW4SEgoEcGF0aBgCIAEoCV'
    'IEcGF0aBIYCgdzZXJ2aWNlGAMgASgJUgdzZXJ2aWNl');
