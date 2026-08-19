//
//  Generated code. Do not modify.
//  source: google/api/resource.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// A description of the historical or future-looking state of the
/// resource pattern.
class ResourceDescriptor_History extends $pb.ProtobufEnum {
  static const ResourceDescriptor_History HISTORY_UNSPECIFIED =
      ResourceDescriptor_History._(
          0, _omitEnumNames ? '' : 'HISTORY_UNSPECIFIED');
  static const ResourceDescriptor_History ORIGINALLY_SINGLE_PATTERN =
      ResourceDescriptor_History._(
          1, _omitEnumNames ? '' : 'ORIGINALLY_SINGLE_PATTERN');
  static const ResourceDescriptor_History FUTURE_MULTI_PATTERN =
      ResourceDescriptor_History._(
          2, _omitEnumNames ? '' : 'FUTURE_MULTI_PATTERN');

  static const $core.List<ResourceDescriptor_History> values =
      <ResourceDescriptor_History>[
    HISTORY_UNSPECIFIED,
    ORIGINALLY_SINGLE_PATTERN,
    FUTURE_MULTI_PATTERN,
  ];

  static final $core.Map<$core.int, ResourceDescriptor_History> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ResourceDescriptor_History? valueOf($core.int value) =>
      _byValue[value];

  const ResourceDescriptor_History._($core.int v, $core.String n) : super(v, n);
}

/// A flag representing a specific style that a resource claims to conform to.
class ResourceDescriptor_Style extends $pb.ProtobufEnum {
  static const ResourceDescriptor_Style STYLE_UNSPECIFIED =
      ResourceDescriptor_Style._(0, _omitEnumNames ? '' : 'STYLE_UNSPECIFIED');
  static const ResourceDescriptor_Style DECLARATIVE_FRIENDLY =
      ResourceDescriptor_Style._(
          1, _omitEnumNames ? '' : 'DECLARATIVE_FRIENDLY');

  static const $core.List<ResourceDescriptor_Style> values =
      <ResourceDescriptor_Style>[
    STYLE_UNSPECIFIED,
    DECLARATIVE_FRIENDLY,
  ];

  static final $core.Map<$core.int, ResourceDescriptor_Style> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ResourceDescriptor_Style? valueOf($core.int value) => _byValue[value];

  const ResourceDescriptor_Style._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
