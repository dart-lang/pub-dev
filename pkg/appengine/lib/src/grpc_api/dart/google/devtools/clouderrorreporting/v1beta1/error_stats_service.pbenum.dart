///
//  Generated code. Do not modify.
///
library google.devtools.clouderrorreporting.v1beta1_error_stats_service_pbenum;

import 'package:protobuf/protobuf.dart';

class TimedCountAlignment extends ProtobufEnum {
  static const TimedCountAlignment ERROR_COUNT_ALIGNMENT_UNSPECIFIED = const TimedCountAlignment._(0, 'ERROR_COUNT_ALIGNMENT_UNSPECIFIED');
  static const TimedCountAlignment ALIGNMENT_EQUAL_ROUNDED = const TimedCountAlignment._(1, 'ALIGNMENT_EQUAL_ROUNDED');
  static const TimedCountAlignment ALIGNMENT_EQUAL_AT_END = const TimedCountAlignment._(2, 'ALIGNMENT_EQUAL_AT_END');

  static const List<TimedCountAlignment> values = const <TimedCountAlignment> [
    ERROR_COUNT_ALIGNMENT_UNSPECIFIED,
    ALIGNMENT_EQUAL_ROUNDED,
    ALIGNMENT_EQUAL_AT_END,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static TimedCountAlignment valueOf(int value) => _byValue[value] as TimedCountAlignment;
  static void $checkItem(TimedCountAlignment v) {
    if (v is !TimedCountAlignment) checkItemFailed(v, 'TimedCountAlignment');
  }

  const TimedCountAlignment._(int v, String n) : super(v, n);
}

class ErrorGroupOrder extends ProtobufEnum {
  static const ErrorGroupOrder GROUP_ORDER_UNSPECIFIED = const ErrorGroupOrder._(0, 'GROUP_ORDER_UNSPECIFIED');
  static const ErrorGroupOrder COUNT_DESC = const ErrorGroupOrder._(1, 'COUNT_DESC');
  static const ErrorGroupOrder LAST_SEEN_DESC = const ErrorGroupOrder._(2, 'LAST_SEEN_DESC');
  static const ErrorGroupOrder CREATED_DESC = const ErrorGroupOrder._(3, 'CREATED_DESC');
  static const ErrorGroupOrder AFFECTED_USERS_DESC = const ErrorGroupOrder._(4, 'AFFECTED_USERS_DESC');

  static const List<ErrorGroupOrder> values = const <ErrorGroupOrder> [
    GROUP_ORDER_UNSPECIFIED,
    COUNT_DESC,
    LAST_SEEN_DESC,
    CREATED_DESC,
    AFFECTED_USERS_DESC,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ErrorGroupOrder valueOf(int value) => _byValue[value] as ErrorGroupOrder;
  static void $checkItem(ErrorGroupOrder v) {
    if (v is !ErrorGroupOrder) checkItemFailed(v, 'ErrorGroupOrder');
  }

  const ErrorGroupOrder._(int v, String n) : super(v, n);
}

class QueryTimeRange_Period extends ProtobufEnum {
  static const QueryTimeRange_Period PERIOD_UNSPECIFIED = const QueryTimeRange_Period._(0, 'PERIOD_UNSPECIFIED');
  static const QueryTimeRange_Period PERIOD_1_HOUR = const QueryTimeRange_Period._(1, 'PERIOD_1_HOUR');
  static const QueryTimeRange_Period PERIOD_6_HOURS = const QueryTimeRange_Period._(2, 'PERIOD_6_HOURS');
  static const QueryTimeRange_Period PERIOD_1_DAY = const QueryTimeRange_Period._(3, 'PERIOD_1_DAY');
  static const QueryTimeRange_Period PERIOD_1_WEEK = const QueryTimeRange_Period._(4, 'PERIOD_1_WEEK');
  static const QueryTimeRange_Period PERIOD_30_DAYS = const QueryTimeRange_Period._(5, 'PERIOD_30_DAYS');

  static const List<QueryTimeRange_Period> values = const <QueryTimeRange_Period> [
    PERIOD_UNSPECIFIED,
    PERIOD_1_HOUR,
    PERIOD_6_HOURS,
    PERIOD_1_DAY,
    PERIOD_1_WEEK,
    PERIOD_30_DAYS,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static QueryTimeRange_Period valueOf(int value) => _byValue[value] as QueryTimeRange_Period;
  static void $checkItem(QueryTimeRange_Period v) {
    if (v is !QueryTimeRange_Period) checkItemFailed(v, 'QueryTimeRange_Period');
  }

  const QueryTimeRange_Period._(int v, String n) : super(v, n);
}

