//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/domain_mapping.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// The SSL management type for this domain.
class SslSettings_SslManagementType extends $pb.ProtobufEnum {
  static const SslSettings_SslManagementType AUTOMATIC =
      SslSettings_SslManagementType._(0, _omitEnumNames ? '' : 'AUTOMATIC');
  static const SslSettings_SslManagementType MANUAL =
      SslSettings_SslManagementType._(1, _omitEnumNames ? '' : 'MANUAL');

  static const $core.List<SslSettings_SslManagementType> values =
      <SslSettings_SslManagementType>[
    AUTOMATIC,
    MANUAL,
  ];

  static final $core.Map<$core.int, SslSettings_SslManagementType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static SslSettings_SslManagementType? valueOf($core.int value) =>
      _byValue[value];

  const SslSettings_SslManagementType._($core.int v, $core.String n)
      : super(v, n);
}

/// A resource record type.
class ResourceRecord_RecordType extends $pb.ProtobufEnum {
  static const ResourceRecord_RecordType A =
      ResourceRecord_RecordType._(0, _omitEnumNames ? '' : 'A');
  static const ResourceRecord_RecordType AAAA =
      ResourceRecord_RecordType._(1, _omitEnumNames ? '' : 'AAAA');
  static const ResourceRecord_RecordType CNAME =
      ResourceRecord_RecordType._(2, _omitEnumNames ? '' : 'CNAME');

  static const $core.List<ResourceRecord_RecordType> values =
      <ResourceRecord_RecordType>[
    A,
    AAAA,
    CNAME,
  ];

  static final $core.Map<$core.int, ResourceRecord_RecordType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ResourceRecord_RecordType? valueOf($core.int value) => _byValue[value];

  const ResourceRecord_RecordType._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
