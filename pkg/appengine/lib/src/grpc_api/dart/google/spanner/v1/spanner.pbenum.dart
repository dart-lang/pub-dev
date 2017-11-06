///
//  Generated code. Do not modify.
///
library google.spanner.v1_spanner_pbenum;

import 'package:protobuf/protobuf.dart';

class ExecuteSqlRequest_QueryMode extends ProtobufEnum {
  static const ExecuteSqlRequest_QueryMode NORMAL = const ExecuteSqlRequest_QueryMode._(0, 'NORMAL');
  static const ExecuteSqlRequest_QueryMode PLAN = const ExecuteSqlRequest_QueryMode._(1, 'PLAN');
  static const ExecuteSqlRequest_QueryMode PROFILE = const ExecuteSqlRequest_QueryMode._(2, 'PROFILE');

  static const List<ExecuteSqlRequest_QueryMode> values = const <ExecuteSqlRequest_QueryMode> [
    NORMAL,
    PLAN,
    PROFILE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ExecuteSqlRequest_QueryMode valueOf(int value) => _byValue[value] as ExecuteSqlRequest_QueryMode;
  static void $checkItem(ExecuteSqlRequest_QueryMode v) {
    if (v is !ExecuteSqlRequest_QueryMode) checkItemFailed(v, 'ExecuteSqlRequest_QueryMode');
  }

  const ExecuteSqlRequest_QueryMode._(int v, String n) : super(v, n);
}

