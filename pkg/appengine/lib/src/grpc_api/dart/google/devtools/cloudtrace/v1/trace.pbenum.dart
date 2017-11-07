///
//  Generated code. Do not modify.
///
library google.devtools.cloudtrace.v1_trace_pbenum;

import 'package:protobuf/protobuf.dart';

class TraceSpan_SpanKind extends ProtobufEnum {
  static const TraceSpan_SpanKind SPAN_KIND_UNSPECIFIED = const TraceSpan_SpanKind._(0, 'SPAN_KIND_UNSPECIFIED');
  static const TraceSpan_SpanKind RPC_SERVER = const TraceSpan_SpanKind._(1, 'RPC_SERVER');
  static const TraceSpan_SpanKind RPC_CLIENT = const TraceSpan_SpanKind._(2, 'RPC_CLIENT');

  static const List<TraceSpan_SpanKind> values = const <TraceSpan_SpanKind> [
    SPAN_KIND_UNSPECIFIED,
    RPC_SERVER,
    RPC_CLIENT,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static TraceSpan_SpanKind valueOf(int value) => _byValue[value] as TraceSpan_SpanKind;
  static void $checkItem(TraceSpan_SpanKind v) {
    if (v is !TraceSpan_SpanKind) checkItemFailed(v, 'TraceSpan_SpanKind');
  }

  const TraceSpan_SpanKind._(int v, String n) : super(v, n);
}

class ListTracesRequest_ViewType extends ProtobufEnum {
  static const ListTracesRequest_ViewType VIEW_TYPE_UNSPECIFIED = const ListTracesRequest_ViewType._(0, 'VIEW_TYPE_UNSPECIFIED');
  static const ListTracesRequest_ViewType MINIMAL = const ListTracesRequest_ViewType._(1, 'MINIMAL');
  static const ListTracesRequest_ViewType ROOTSPAN = const ListTracesRequest_ViewType._(2, 'ROOTSPAN');
  static const ListTracesRequest_ViewType COMPLETE = const ListTracesRequest_ViewType._(3, 'COMPLETE');

  static const List<ListTracesRequest_ViewType> values = const <ListTracesRequest_ViewType> [
    VIEW_TYPE_UNSPECIFIED,
    MINIMAL,
    ROOTSPAN,
    COMPLETE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ListTracesRequest_ViewType valueOf(int value) => _byValue[value] as ListTracesRequest_ViewType;
  static void $checkItem(ListTracesRequest_ViewType v) {
    if (v is !ListTracesRequest_ViewType) checkItemFailed(v, 'ListTracesRequest_ViewType');
  }

  const ListTracesRequest_ViewType._(int v, String n) : super(v, n);
}

