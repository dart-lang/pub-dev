///
//  Generated code. Do not modify.
///
library google.logging.type_log_severity_pbenum;

import 'package:protobuf/protobuf.dart';

class LogSeverity extends ProtobufEnum {
  static const LogSeverity DEFAULT = const LogSeverity._(0, 'DEFAULT');
  static const LogSeverity DEBUG = const LogSeverity._(100, 'DEBUG');
  static const LogSeverity INFO = const LogSeverity._(200, 'INFO');
  static const LogSeverity NOTICE = const LogSeverity._(300, 'NOTICE');
  static const LogSeverity WARNING = const LogSeverity._(400, 'WARNING');
  static const LogSeverity ERROR = const LogSeverity._(500, 'ERROR');
  static const LogSeverity CRITICAL = const LogSeverity._(600, 'CRITICAL');
  static const LogSeverity ALERT = const LogSeverity._(700, 'ALERT');
  static const LogSeverity EMERGENCY = const LogSeverity._(800, 'EMERGENCY');

  static const List<LogSeverity> values = const <LogSeverity> [
    DEFAULT,
    DEBUG,
    INFO,
    NOTICE,
    WARNING,
    ERROR,
    CRITICAL,
    ALERT,
    EMERGENCY,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static LogSeverity valueOf(int value) => _byValue[value] as LogSeverity;
  static void $checkItem(LogSeverity v) {
    if (v is !LogSeverity) checkItemFailed(v, 'LogSeverity');
  }

  const LogSeverity._(int v, String n) : super(v, n);
}

