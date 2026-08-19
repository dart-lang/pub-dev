//
//  Generated code. Do not modify.
//  source: google/type/dayofweek.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Represents a day of the week.
class DayOfWeek extends $pb.ProtobufEnum {
  static const DayOfWeek DAY_OF_WEEK_UNSPECIFIED =
      DayOfWeek._(0, _omitEnumNames ? '' : 'DAY_OF_WEEK_UNSPECIFIED');
  static const DayOfWeek MONDAY =
      DayOfWeek._(1, _omitEnumNames ? '' : 'MONDAY');
  static const DayOfWeek TUESDAY =
      DayOfWeek._(2, _omitEnumNames ? '' : 'TUESDAY');
  static const DayOfWeek WEDNESDAY =
      DayOfWeek._(3, _omitEnumNames ? '' : 'WEDNESDAY');
  static const DayOfWeek THURSDAY =
      DayOfWeek._(4, _omitEnumNames ? '' : 'THURSDAY');
  static const DayOfWeek FRIDAY =
      DayOfWeek._(5, _omitEnumNames ? '' : 'FRIDAY');
  static const DayOfWeek SATURDAY =
      DayOfWeek._(6, _omitEnumNames ? '' : 'SATURDAY');
  static const DayOfWeek SUNDAY =
      DayOfWeek._(7, _omitEnumNames ? '' : 'SUNDAY');

  static const $core.List<DayOfWeek> values = <DayOfWeek>[
    DAY_OF_WEEK_UNSPECIFIED,
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY,
    SUNDAY,
  ];

  static final $core.Map<$core.int, DayOfWeek> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static DayOfWeek? valueOf($core.int value) => _byValue[value];

  const DayOfWeek._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
