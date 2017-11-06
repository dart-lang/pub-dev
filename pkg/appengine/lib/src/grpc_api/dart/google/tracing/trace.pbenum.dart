///
//  Generated code. Do not modify.
///
library google.tracing.v1_trace_pbenum;

import 'package:protobuf/protobuf.dart';

class Span_TimeEvent_NetworkEvent_Type extends ProtobufEnum {
  static const Span_TimeEvent_NetworkEvent_Type UNSPECIFIED = const Span_TimeEvent_NetworkEvent_Type._(0, 'UNSPECIFIED');
  static const Span_TimeEvent_NetworkEvent_Type SENT = const Span_TimeEvent_NetworkEvent_Type._(1, 'SENT');
  static const Span_TimeEvent_NetworkEvent_Type RECV = const Span_TimeEvent_NetworkEvent_Type._(2, 'RECV');

  static const List<Span_TimeEvent_NetworkEvent_Type> values = const <Span_TimeEvent_NetworkEvent_Type> [
    UNSPECIFIED,
    SENT,
    RECV,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Span_TimeEvent_NetworkEvent_Type valueOf(int value) => _byValue[value] as Span_TimeEvent_NetworkEvent_Type;
  static void $checkItem(Span_TimeEvent_NetworkEvent_Type v) {
    if (v is !Span_TimeEvent_NetworkEvent_Type) checkItemFailed(v, 'Span_TimeEvent_NetworkEvent_Type');
  }

  const Span_TimeEvent_NetworkEvent_Type._(int v, String n) : super(v, n);
}

class Span_Link_Type extends ProtobufEnum {
  static const Span_Link_Type UNSPECIFIED = const Span_Link_Type._(0, 'UNSPECIFIED');
  static const Span_Link_Type CHILD = const Span_Link_Type._(1, 'CHILD');
  static const Span_Link_Type PARENT = const Span_Link_Type._(2, 'PARENT');

  static const List<Span_Link_Type> values = const <Span_Link_Type> [
    UNSPECIFIED,
    CHILD,
    PARENT,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Span_Link_Type valueOf(int value) => _byValue[value] as Span_Link_Type;
  static void $checkItem(Span_Link_Type v) {
    if (v is !Span_Link_Type) checkItemFailed(v, 'Span_Link_Type');
  }

  const Span_Link_Type._(int v, String n) : super(v, n);
}

