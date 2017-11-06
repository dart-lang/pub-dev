///
//  Generated code. Do not modify.
///
library google.devtools.clouddebugger.v2_data_pbenum;

import 'package:protobuf/protobuf.dart';

class StatusMessage_Reference extends ProtobufEnum {
  static const StatusMessage_Reference UNSPECIFIED = const StatusMessage_Reference._(0, 'UNSPECIFIED');
  static const StatusMessage_Reference BREAKPOINT_SOURCE_LOCATION = const StatusMessage_Reference._(3, 'BREAKPOINT_SOURCE_LOCATION');
  static const StatusMessage_Reference BREAKPOINT_CONDITION = const StatusMessage_Reference._(4, 'BREAKPOINT_CONDITION');
  static const StatusMessage_Reference BREAKPOINT_EXPRESSION = const StatusMessage_Reference._(7, 'BREAKPOINT_EXPRESSION');
  static const StatusMessage_Reference VARIABLE_NAME = const StatusMessage_Reference._(5, 'VARIABLE_NAME');
  static const StatusMessage_Reference VARIABLE_VALUE = const StatusMessage_Reference._(6, 'VARIABLE_VALUE');

  static const List<StatusMessage_Reference> values = const <StatusMessage_Reference> [
    UNSPECIFIED,
    BREAKPOINT_SOURCE_LOCATION,
    BREAKPOINT_CONDITION,
    BREAKPOINT_EXPRESSION,
    VARIABLE_NAME,
    VARIABLE_VALUE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static StatusMessage_Reference valueOf(int value) => _byValue[value] as StatusMessage_Reference;
  static void $checkItem(StatusMessage_Reference v) {
    if (v is !StatusMessage_Reference) checkItemFailed(v, 'StatusMessage_Reference');
  }

  const StatusMessage_Reference._(int v, String n) : super(v, n);
}

class Breakpoint_Action extends ProtobufEnum {
  static const Breakpoint_Action CAPTURE = const Breakpoint_Action._(0, 'CAPTURE');
  static const Breakpoint_Action LOG = const Breakpoint_Action._(1, 'LOG');

  static const List<Breakpoint_Action> values = const <Breakpoint_Action> [
    CAPTURE,
    LOG,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Breakpoint_Action valueOf(int value) => _byValue[value] as Breakpoint_Action;
  static void $checkItem(Breakpoint_Action v) {
    if (v is !Breakpoint_Action) checkItemFailed(v, 'Breakpoint_Action');
  }

  const Breakpoint_Action._(int v, String n) : super(v, n);
}

class Breakpoint_LogLevel extends ProtobufEnum {
  static const Breakpoint_LogLevel INFO = const Breakpoint_LogLevel._(0, 'INFO');
  static const Breakpoint_LogLevel WARNING = const Breakpoint_LogLevel._(1, 'WARNING');
  static const Breakpoint_LogLevel ERROR = const Breakpoint_LogLevel._(2, 'ERROR');

  static const List<Breakpoint_LogLevel> values = const <Breakpoint_LogLevel> [
    INFO,
    WARNING,
    ERROR,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Breakpoint_LogLevel valueOf(int value) => _byValue[value] as Breakpoint_LogLevel;
  static void $checkItem(Breakpoint_LogLevel v) {
    if (v is !Breakpoint_LogLevel) checkItemFailed(v, 'Breakpoint_LogLevel');
  }

  const Breakpoint_LogLevel._(int v, String n) : super(v, n);
}

