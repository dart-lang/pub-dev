//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/deploy.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use deploymentDescriptor instead')
const Deployment$json = {
  '1': 'Deployment',
  '2': [
    {
      '1': 'files',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1beta.Deployment.FilesEntry',
      '10': 'files'
    },
    {
      '1': 'container',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.ContainerInfo',
      '10': 'container'
    },
    {
      '1': 'zip',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.ZipInfo',
      '10': 'zip'
    },
    {
      '1': 'build',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.BuildInfo',
      '10': 'build'
    },
    {
      '1': 'cloud_build_options',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.CloudBuildOptions',
      '10': 'cloudBuildOptions'
    },
  ],
  '3': [Deployment_FilesEntry$json],
};

@$core.Deprecated('Use deploymentDescriptor instead')
const Deployment_FilesEntry$json = {
  '1': 'FilesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.FileInfo',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

/// Descriptor for `Deployment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deploymentDescriptor = $convert.base64Decode(
    'CgpEZXBsb3ltZW50EkQKBWZpbGVzGAEgAygLMi4uZ29vZ2xlLmFwcGVuZ2luZS52MWJldGEuRG'
    'VwbG95bWVudC5GaWxlc0VudHJ5UgVmaWxlcxJECgljb250YWluZXIYAiABKAsyJi5nb29nbGUu'
    'YXBwZW5naW5lLnYxYmV0YS5Db250YWluZXJJbmZvUgljb250YWluZXISMgoDemlwGAMgASgLMi'
    'AuZ29vZ2xlLmFwcGVuZ2luZS52MWJldGEuWmlwSW5mb1IDemlwEjgKBWJ1aWxkGAUgASgLMiIu'
    'Z29vZ2xlLmFwcGVuZ2luZS52MWJldGEuQnVpbGRJbmZvUgVidWlsZBJaChNjbG91ZF9idWlsZF'
    '9vcHRpb25zGAYgASgLMiouZ29vZ2xlLmFwcGVuZ2luZS52MWJldGEuQ2xvdWRCdWlsZE9wdGlv'
    'bnNSEWNsb3VkQnVpbGRPcHRpb25zGlsKCkZpbGVzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSNw'
    'oFdmFsdWUYAiABKAsyIS5nb29nbGUuYXBwZW5naW5lLnYxYmV0YS5GaWxlSW5mb1IFdmFsdWU6'
    'AjgB');

@$core.Deprecated('Use fileInfoDescriptor instead')
const FileInfo$json = {
  '1': 'FileInfo',
  '2': [
    {'1': 'source_url', '3': 1, '4': 1, '5': 9, '10': 'sourceUrl'},
    {'1': 'sha1_sum', '3': 2, '4': 1, '5': 9, '10': 'sha1Sum'},
    {'1': 'mime_type', '3': 3, '4': 1, '5': 9, '10': 'mimeType'},
  ],
};

/// Descriptor for `FileInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileInfoDescriptor = $convert.base64Decode(
    'CghGaWxlSW5mbxIdCgpzb3VyY2VfdXJsGAEgASgJUglzb3VyY2VVcmwSGQoIc2hhMV9zdW0YAi'
    'ABKAlSB3NoYTFTdW0SGwoJbWltZV90eXBlGAMgASgJUghtaW1lVHlwZQ==');

@$core.Deprecated('Use containerInfoDescriptor instead')
const ContainerInfo$json = {
  '1': 'ContainerInfo',
  '2': [
    {'1': 'image', '3': 1, '4': 1, '5': 9, '10': 'image'},
  ],
};

/// Descriptor for `ContainerInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List containerInfoDescriptor = $convert
    .base64Decode('Cg1Db250YWluZXJJbmZvEhQKBWltYWdlGAEgASgJUgVpbWFnZQ==');

@$core.Deprecated('Use buildInfoDescriptor instead')
const BuildInfo$json = {
  '1': 'BuildInfo',
  '2': [
    {'1': 'cloud_build_id', '3': 1, '4': 1, '5': 9, '10': 'cloudBuildId'},
  ],
};

/// Descriptor for `BuildInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buildInfoDescriptor = $convert.base64Decode(
    'CglCdWlsZEluZm8SJAoOY2xvdWRfYnVpbGRfaWQYASABKAlSDGNsb3VkQnVpbGRJZA==');

@$core.Deprecated('Use cloudBuildOptionsDescriptor instead')
const CloudBuildOptions$json = {
  '1': 'CloudBuildOptions',
  '2': [
    {'1': 'app_yaml_path', '3': 1, '4': 1, '5': 9, '10': 'appYamlPath'},
    {
      '1': 'cloud_build_timeout',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'cloudBuildTimeout'
    },
  ],
};

/// Descriptor for `CloudBuildOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cloudBuildOptionsDescriptor = $convert.base64Decode(
    'ChFDbG91ZEJ1aWxkT3B0aW9ucxIiCg1hcHBfeWFtbF9wYXRoGAEgASgJUgthcHBZYW1sUGF0aB'
    'JJChNjbG91ZF9idWlsZF90aW1lb3V0GAIgASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0aW9u'
    'UhFjbG91ZEJ1aWxkVGltZW91dA==');

@$core.Deprecated('Use zipInfoDescriptor instead')
const ZipInfo$json = {
  '1': 'ZipInfo',
  '2': [
    {'1': 'source_url', '3': 3, '4': 1, '5': 9, '10': 'sourceUrl'},
    {'1': 'files_count', '3': 4, '4': 1, '5': 5, '10': 'filesCount'},
  ],
};

/// Descriptor for `ZipInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zipInfoDescriptor = $convert.base64Decode(
    'CgdaaXBJbmZvEh0KCnNvdXJjZV91cmwYAyABKAlSCXNvdXJjZVVybBIfCgtmaWxlc19jb3VudB'
    'gEIAEoBVIKZmlsZXNDb3VudA==');
