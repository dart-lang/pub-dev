//
//  Generated code. Do not modify.
//  source: google/datastore/admin/v1/index.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// For an ordered index, specifies whether each of the entity's ancestors
/// will be included.
class Index_AncestorMode extends $pb.ProtobufEnum {
  static const Index_AncestorMode ANCESTOR_MODE_UNSPECIFIED =
      Index_AncestorMode._(
          0, _omitEnumNames ? '' : 'ANCESTOR_MODE_UNSPECIFIED');
  static const Index_AncestorMode NONE =
      Index_AncestorMode._(1, _omitEnumNames ? '' : 'NONE');
  static const Index_AncestorMode ALL_ANCESTORS =
      Index_AncestorMode._(2, _omitEnumNames ? '' : 'ALL_ANCESTORS');

  static const $core.List<Index_AncestorMode> values = <Index_AncestorMode>[
    ANCESTOR_MODE_UNSPECIFIED,
    NONE,
    ALL_ANCESTORS,
  ];

  static final $core.Map<$core.int, Index_AncestorMode> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Index_AncestorMode? valueOf($core.int value) => _byValue[value];

  const Index_AncestorMode._($core.int v, $core.String n) : super(v, n);
}

/// The direction determines how a property is indexed.
class Index_Direction extends $pb.ProtobufEnum {
  static const Index_Direction DIRECTION_UNSPECIFIED =
      Index_Direction._(0, _omitEnumNames ? '' : 'DIRECTION_UNSPECIFIED');
  static const Index_Direction ASCENDING =
      Index_Direction._(1, _omitEnumNames ? '' : 'ASCENDING');
  static const Index_Direction DESCENDING =
      Index_Direction._(2, _omitEnumNames ? '' : 'DESCENDING');

  static const $core.List<Index_Direction> values = <Index_Direction>[
    DIRECTION_UNSPECIFIED,
    ASCENDING,
    DESCENDING,
  ];

  static final $core.Map<$core.int, Index_Direction> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Index_Direction? valueOf($core.int value) => _byValue[value];

  const Index_Direction._($core.int v, $core.String n) : super(v, n);
}

/// The possible set of states of an index.
class Index_State extends $pb.ProtobufEnum {
  static const Index_State STATE_UNSPECIFIED =
      Index_State._(0, _omitEnumNames ? '' : 'STATE_UNSPECIFIED');
  static const Index_State CREATING =
      Index_State._(1, _omitEnumNames ? '' : 'CREATING');
  static const Index_State READY =
      Index_State._(2, _omitEnumNames ? '' : 'READY');
  static const Index_State DELETING =
      Index_State._(3, _omitEnumNames ? '' : 'DELETING');
  static const Index_State ERROR =
      Index_State._(4, _omitEnumNames ? '' : 'ERROR');

  static const $core.List<Index_State> values = <Index_State>[
    STATE_UNSPECIFIED,
    CREATING,
    READY,
    DELETING,
    ERROR,
  ];

  static final $core.Map<$core.int, Index_State> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Index_State? valueOf($core.int value) => _byValue[value];

  const Index_State._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
