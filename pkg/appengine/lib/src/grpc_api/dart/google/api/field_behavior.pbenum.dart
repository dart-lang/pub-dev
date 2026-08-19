//
//  Generated code. Do not modify.
//  source: google/api/field_behavior.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///  An indicator of the behavior of a given field (for example, that a field
///  is required in requests, or given as output but ignored as input).
///  This **does not** change the behavior in protocol buffers itself; it only
///  denotes the behavior and may affect how API tooling handles the field.
///
///  Note: This enum **may** receive new values in the future.
class FieldBehavior extends $pb.ProtobufEnum {
  static const FieldBehavior FIELD_BEHAVIOR_UNSPECIFIED =
      FieldBehavior._(0, _omitEnumNames ? '' : 'FIELD_BEHAVIOR_UNSPECIFIED');
  static const FieldBehavior OPTIONAL =
      FieldBehavior._(1, _omitEnumNames ? '' : 'OPTIONAL');
  static const FieldBehavior REQUIRED =
      FieldBehavior._(2, _omitEnumNames ? '' : 'REQUIRED');
  static const FieldBehavior OUTPUT_ONLY =
      FieldBehavior._(3, _omitEnumNames ? '' : 'OUTPUT_ONLY');
  static const FieldBehavior INPUT_ONLY =
      FieldBehavior._(4, _omitEnumNames ? '' : 'INPUT_ONLY');
  static const FieldBehavior IMMUTABLE =
      FieldBehavior._(5, _omitEnumNames ? '' : 'IMMUTABLE');
  static const FieldBehavior UNORDERED_LIST =
      FieldBehavior._(6, _omitEnumNames ? '' : 'UNORDERED_LIST');
  static const FieldBehavior NON_EMPTY_DEFAULT =
      FieldBehavior._(7, _omitEnumNames ? '' : 'NON_EMPTY_DEFAULT');
  static const FieldBehavior IDENTIFIER =
      FieldBehavior._(8, _omitEnumNames ? '' : 'IDENTIFIER');

  static const $core.List<FieldBehavior> values = <FieldBehavior>[
    FIELD_BEHAVIOR_UNSPECIFIED,
    OPTIONAL,
    REQUIRED,
    OUTPUT_ONLY,
    INPUT_ONLY,
    IMMUTABLE,
    UNORDERED_LIST,
    NON_EMPTY_DEFAULT,
    IDENTIFIER,
  ];

  static final $core.Map<$core.int, FieldBehavior> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FieldBehavior? valueOf($core.int value) => _byValue[value];

  const FieldBehavior._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
