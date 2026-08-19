//
//  Generated code. Do not modify.
//  source: google/type/postal_address.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use postalAddressDescriptor instead')
const PostalAddress$json = {
  '1': 'PostalAddress',
  '2': [
    {'1': 'revision', '3': 1, '4': 1, '5': 5, '10': 'revision'},
    {'1': 'region_code', '3': 2, '4': 1, '5': 9, '10': 'regionCode'},
    {'1': 'language_code', '3': 3, '4': 1, '5': 9, '10': 'languageCode'},
    {'1': 'postal_code', '3': 4, '4': 1, '5': 9, '10': 'postalCode'},
    {'1': 'sorting_code', '3': 5, '4': 1, '5': 9, '10': 'sortingCode'},
    {
      '1': 'administrative_area',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'administrativeArea'
    },
    {'1': 'locality', '3': 7, '4': 1, '5': 9, '10': 'locality'},
    {'1': 'sublocality', '3': 8, '4': 1, '5': 9, '10': 'sublocality'},
    {'1': 'address_lines', '3': 9, '4': 3, '5': 9, '10': 'addressLines'},
    {'1': 'recipients', '3': 10, '4': 3, '5': 9, '10': 'recipients'},
    {'1': 'organization', '3': 11, '4': 1, '5': 9, '10': 'organization'},
  ],
};

/// Descriptor for `PostalAddress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List postalAddressDescriptor = $convert.base64Decode(
    'Cg1Qb3N0YWxBZGRyZXNzEhoKCHJldmlzaW9uGAEgASgFUghyZXZpc2lvbhIfCgtyZWdpb25fY2'
    '9kZRgCIAEoCVIKcmVnaW9uQ29kZRIjCg1sYW5ndWFnZV9jb2RlGAMgASgJUgxsYW5ndWFnZUNv'
    'ZGUSHwoLcG9zdGFsX2NvZGUYBCABKAlSCnBvc3RhbENvZGUSIQoMc29ydGluZ19jb2RlGAUgAS'
    'gJUgtzb3J0aW5nQ29kZRIvChNhZG1pbmlzdHJhdGl2ZV9hcmVhGAYgASgJUhJhZG1pbmlzdHJh'
    'dGl2ZUFyZWESGgoIbG9jYWxpdHkYByABKAlSCGxvY2FsaXR5EiAKC3N1YmxvY2FsaXR5GAggAS'
    'gJUgtzdWJsb2NhbGl0eRIjCg1hZGRyZXNzX2xpbmVzGAkgAygJUgxhZGRyZXNzTGluZXMSHgoK'
    'cmVjaXBpZW50cxgKIAMoCVIKcmVjaXBpZW50cxIiCgxvcmdhbml6YXRpb24YCyABKAlSDG9yZ2'
    'FuaXphdGlvbg==');
