//
//  Generated code. Do not modify.
//  source: google/type/calendar_period.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// A `CalendarPeriod` represents the abstract concept of a time period that has
/// a canonical start. Grammatically, "the start of the current
/// `CalendarPeriod`." All calendar times begin at midnight UTC.
class CalendarPeriod extends $pb.ProtobufEnum {
  static const CalendarPeriod CALENDAR_PERIOD_UNSPECIFIED =
      CalendarPeriod._(0, _omitEnumNames ? '' : 'CALENDAR_PERIOD_UNSPECIFIED');
  static const CalendarPeriod DAY =
      CalendarPeriod._(1, _omitEnumNames ? '' : 'DAY');
  static const CalendarPeriod WEEK =
      CalendarPeriod._(2, _omitEnumNames ? '' : 'WEEK');
  static const CalendarPeriod FORTNIGHT =
      CalendarPeriod._(3, _omitEnumNames ? '' : 'FORTNIGHT');
  static const CalendarPeriod MONTH =
      CalendarPeriod._(4, _omitEnumNames ? '' : 'MONTH');
  static const CalendarPeriod QUARTER =
      CalendarPeriod._(5, _omitEnumNames ? '' : 'QUARTER');
  static const CalendarPeriod HALF =
      CalendarPeriod._(6, _omitEnumNames ? '' : 'HALF');
  static const CalendarPeriod YEAR =
      CalendarPeriod._(7, _omitEnumNames ? '' : 'YEAR');

  static const $core.List<CalendarPeriod> values = <CalendarPeriod>[
    CALENDAR_PERIOD_UNSPECIFIED,
    DAY,
    WEEK,
    FORTNIGHT,
    MONTH,
    QUARTER,
    HALF,
    YEAR,
  ];

  static final $core.Map<$core.int, CalendarPeriod> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static CalendarPeriod? valueOf($core.int value) => _byValue[value];

  const CalendarPeriod._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
