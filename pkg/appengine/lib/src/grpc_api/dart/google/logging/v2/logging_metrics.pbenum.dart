///
//  Generated code. Do not modify.
///
library google.logging.v2_logging_metrics_pbenum;

import 'package:protobuf/protobuf.dart';

class LogMetric_ApiVersion extends ProtobufEnum {
  static const LogMetric_ApiVersion V2 = const LogMetric_ApiVersion._(0, 'V2');
  static const LogMetric_ApiVersion V1 = const LogMetric_ApiVersion._(1, 'V1');

  static const List<LogMetric_ApiVersion> values = const <LogMetric_ApiVersion> [
    V2,
    V1,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static LogMetric_ApiVersion valueOf(int value) => _byValue[value] as LogMetric_ApiVersion;
  static void $checkItem(LogMetric_ApiVersion v) {
    if (v is !LogMetric_ApiVersion) checkItemFailed(v, 'LogMetric_ApiVersion');
  }

  const LogMetric_ApiVersion._(int v, String n) : super(v, n);
}

