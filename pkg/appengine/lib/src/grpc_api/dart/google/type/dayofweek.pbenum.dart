///
//  Generated code. Do not modify.
///
library google.type_dayofweek_pbenum;

import 'package:protobuf/protobuf.dart';

class DayOfWeek extends ProtobufEnum {
  static const DayOfWeek DAY_OF_WEEK_UNSPECIFIED = const DayOfWeek._(0, 'DAY_OF_WEEK_UNSPECIFIED');
  static const DayOfWeek MONDAY = const DayOfWeek._(1, 'MONDAY');
  static const DayOfWeek TUESDAY = const DayOfWeek._(2, 'TUESDAY');
  static const DayOfWeek WEDNESDAY = const DayOfWeek._(3, 'WEDNESDAY');
  static const DayOfWeek THURSDAY = const DayOfWeek._(4, 'THURSDAY');
  static const DayOfWeek FRIDAY = const DayOfWeek._(5, 'FRIDAY');
  static const DayOfWeek SATURDAY = const DayOfWeek._(6, 'SATURDAY');
  static const DayOfWeek SUNDAY = const DayOfWeek._(7, 'SUNDAY');

  static const List<DayOfWeek> values = const <DayOfWeek> [
    DAY_OF_WEEK_UNSPECIFIED,
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY,
    SUNDAY,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static DayOfWeek valueOf(int value) => _byValue[value] as DayOfWeek;
  static void $checkItem(DayOfWeek v) {
    if (v is !DayOfWeek) checkItemFailed(v, 'DayOfWeek');
  }

  const DayOfWeek._(int v, String n) : super(v, n);
}

