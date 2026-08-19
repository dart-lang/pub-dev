//
//  Generated code. Do not modify.
//  source: google/api/httpbody.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use httpBodyDescriptor instead')
const HttpBody$json = {
  '1': 'HttpBody',
  '2': [
    {'1': 'content_type', '3': 1, '4': 1, '5': 9, '10': 'contentType'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
    {
      '1': 'extensions',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'extensions'
    },
  ],
};

/// Descriptor for `HttpBody`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List httpBodyDescriptor = $convert.base64Decode(
    'CghIdHRwQm9keRIhCgxjb250ZW50X3R5cGUYASABKAlSC2NvbnRlbnRUeXBlEhIKBGRhdGEYAi'
    'ABKAxSBGRhdGESNAoKZXh0ZW5zaW9ucxgDIAMoCzIULmdvb2dsZS5wcm90b2J1Zi5BbnlSCmV4'
    'dGVuc2lvbnM=');
