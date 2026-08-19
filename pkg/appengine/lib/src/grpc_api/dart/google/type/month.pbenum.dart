//
//  Generated code. Do not modify.
//  source: google/type/month.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Represents a month in the Gregorian calendar.
class Month extends $pb.ProtobufEnum {
  static const Month MONTH_UNSPECIFIED =
      Month._(0, _omitEnumNames ? '' : 'MONTH_UNSPECIFIED');
  static const Month JANUARY = Month._(1, _omitEnumNames ? '' : 'JANUARY');
  static const Month FEBRUARY = Month._(2, _omitEnumNames ? '' : 'FEBRUARY');
  static const Month MARCH = Month._(3, _omitEnumNames ? '' : 'MARCH');
  static const Month APRIL = Month._(4, _omitEnumNames ? '' : 'APRIL');
  static const Month MAY = Month._(5, _omitEnumNames ? '' : 'MAY');
  static const Month JUNE = Month._(6, _omitEnumNames ? '' : 'JUNE');
  static const Month JULY = Month._(7, _omitEnumNames ? '' : 'JULY');
  static const Month AUGUST = Month._(8, _omitEnumNames ? '' : 'AUGUST');
  static const Month SEPTEMBER = Month._(9, _omitEnumNames ? '' : 'SEPTEMBER');
  static const Month OCTOBER = Month._(10, _omitEnumNames ? '' : 'OCTOBER');
  static const Month NOVEMBER = Month._(11, _omitEnumNames ? '' : 'NOVEMBER');
  static const Month DECEMBER = Month._(12, _omitEnumNames ? '' : 'DECEMBER');

  static const $core.List<Month> values = <Month>[
    MONTH_UNSPECIFIED,
    JANUARY,
    FEBRUARY,
    MARCH,
    APRIL,
    MAY,
    JUNE,
    JULY,
    AUGUST,
    SEPTEMBER,
    OCTOBER,
    NOVEMBER,
    DECEMBER,
  ];

  static final $core.Map<$core.int, Month> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Month? valueOf($core.int value) => _byValue[value];

  const Month._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
