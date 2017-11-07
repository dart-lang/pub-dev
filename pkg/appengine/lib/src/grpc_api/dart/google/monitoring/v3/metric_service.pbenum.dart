///
//  Generated code. Do not modify.
///
library google.monitoring.v3_metric_service_pbenum;

import 'package:protobuf/protobuf.dart';

class ListTimeSeriesRequest_TimeSeriesView extends ProtobufEnum {
  static const ListTimeSeriesRequest_TimeSeriesView FULL = const ListTimeSeriesRequest_TimeSeriesView._(0, 'FULL');
  static const ListTimeSeriesRequest_TimeSeriesView HEADERS = const ListTimeSeriesRequest_TimeSeriesView._(1, 'HEADERS');

  static const List<ListTimeSeriesRequest_TimeSeriesView> values = const <ListTimeSeriesRequest_TimeSeriesView> [
    FULL,
    HEADERS,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ListTimeSeriesRequest_TimeSeriesView valueOf(int value) => _byValue[value] as ListTimeSeriesRequest_TimeSeriesView;
  static void $checkItem(ListTimeSeriesRequest_TimeSeriesView v) {
    if (v is !ListTimeSeriesRequest_TimeSeriesView) checkItemFailed(v, 'ListTimeSeriesRequest_TimeSeriesView');
  }

  const ListTimeSeriesRequest_TimeSeriesView._(int v, String n) : super(v, n);
}

