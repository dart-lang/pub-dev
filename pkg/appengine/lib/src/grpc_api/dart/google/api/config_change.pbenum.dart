//
//  Generated code. Do not modify.
//  source: google/api/config_change.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Classifies set of possible modifications to an object in the service
/// configuration.
class ChangeType extends $pb.ProtobufEnum {
  static const ChangeType CHANGE_TYPE_UNSPECIFIED =
      ChangeType._(0, _omitEnumNames ? '' : 'CHANGE_TYPE_UNSPECIFIED');
  static const ChangeType ADDED =
      ChangeType._(1, _omitEnumNames ? '' : 'ADDED');
  static const ChangeType REMOVED =
      ChangeType._(2, _omitEnumNames ? '' : 'REMOVED');
  static const ChangeType MODIFIED =
      ChangeType._(3, _omitEnumNames ? '' : 'MODIFIED');

  static const $core.List<ChangeType> values = <ChangeType>[
    CHANGE_TYPE_UNSPECIFIED,
    ADDED,
    REMOVED,
    MODIFIED,
  ];

  static final $core.Map<$core.int, ChangeType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ChangeType? valueOf($core.int value) => _byValue[value];

  const ChangeType._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
