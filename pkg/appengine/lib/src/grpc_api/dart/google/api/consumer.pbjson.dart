//
//  Generated code. Do not modify.
//  source: google/api/consumer.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use projectPropertiesDescriptor instead')
const ProjectProperties$json = {
  '1': 'ProjectProperties',
  '2': [
    {
      '1': 'properties',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.Property',
      '10': 'properties'
    },
  ],
};

/// Descriptor for `ProjectProperties`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List projectPropertiesDescriptor = $convert.base64Decode(
    'ChFQcm9qZWN0UHJvcGVydGllcxI0Cgpwcm9wZXJ0aWVzGAEgAygLMhQuZ29vZ2xlLmFwaS5Qcm'
    '9wZXJ0eVIKcHJvcGVydGllcw==');

@$core.Deprecated('Use propertyDescriptor instead')
const Property$json = {
  '1': 'Property',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.api.Property.PropertyType',
      '10': 'type'
    },
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
  '4': [Property_PropertyType$json],
};

@$core.Deprecated('Use propertyDescriptor instead')
const Property_PropertyType$json = {
  '1': 'PropertyType',
  '2': [
    {'1': 'UNSPECIFIED', '2': 0},
    {'1': 'INT64', '2': 1},
    {'1': 'BOOL', '2': 2},
    {'1': 'STRING', '2': 3},
    {'1': 'DOUBLE', '2': 4},
  ],
};

/// Descriptor for `Property`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List propertyDescriptor = $convert.base64Decode(
    'CghQcm9wZXJ0eRISCgRuYW1lGAEgASgJUgRuYW1lEjUKBHR5cGUYAiABKA4yIS5nb29nbGUuYX'
    'BpLlByb3BlcnR5LlByb3BlcnR5VHlwZVIEdHlwZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVz'
    'Y3JpcHRpb24iTAoMUHJvcGVydHlUeXBlEg8KC1VOU1BFQ0lGSUVEEAASCQoFSU5UNjQQARIICg'
    'RCT09MEAISCgoGU1RSSU5HEAMSCgoGRE9VQkxFEAQ=');
