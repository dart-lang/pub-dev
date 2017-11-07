///
//  Generated code. Do not modify.
///
library google.monitoring.v3_metric;

import 'package:protobuf/protobuf.dart';

import 'common.pb.dart';
import '../../api/metric.pb.dart' as google$api;
import '../../api/monitored_resource.pb.dart' as google$api;

import '../../api/metric.pbenum.dart' as google$api;

class Point extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Point')
    ..a/*<TimeInterval>*/(1, 'interval', PbFieldType.OM, TimeInterval.getDefault, TimeInterval.create)
    ..a/*<TypedValue>*/(2, 'value', PbFieldType.OM, TypedValue.getDefault, TypedValue.create)
    ..hasRequiredFields = false
  ;

  Point() : super();
  Point.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Point.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Point clone() => new Point()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Point create() => new Point();
  static PbList<Point> createRepeated() => new PbList<Point>();
  static Point getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPoint();
    return _defaultInstance;
  }
  static Point _defaultInstance;
  static void $checkItem(Point v) {
    if (v is !Point) checkItemFailed(v, 'Point');
  }

  TimeInterval get interval => $_get(0, 1, null);
  void set interval(TimeInterval v) { setField(1, v); }
  bool hasInterval() => $_has(0, 1);
  void clearInterval() => clearField(1);

  TypedValue get value => $_get(1, 2, null);
  void set value(TypedValue v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyPoint extends Point with ReadonlyMessageMixin {}

class TimeSeries extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TimeSeries')
    ..a/*<google$api.Metric>*/(1, 'metric', PbFieldType.OM, google$api.Metric.getDefault, google$api.Metric.create)
    ..a/*<google$api.MonitoredResource>*/(2, 'resource', PbFieldType.OM, google$api.MonitoredResource.getDefault, google$api.MonitoredResource.create)
    ..e/*<google$api.MetricDescriptor_MetricKind>*/(3, 'metricKind', PbFieldType.OE, google$api.MetricDescriptor_MetricKind.METRIC_KIND_UNSPECIFIED, google$api.MetricDescriptor_MetricKind.valueOf)
    ..e/*<google$api.MetricDescriptor_ValueType>*/(4, 'valueType', PbFieldType.OE, google$api.MetricDescriptor_ValueType.VALUE_TYPE_UNSPECIFIED, google$api.MetricDescriptor_ValueType.valueOf)
    ..pp/*<Point>*/(5, 'points', PbFieldType.PM, Point.$checkItem, Point.create)
    ..hasRequiredFields = false
  ;

  TimeSeries() : super();
  TimeSeries.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TimeSeries.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TimeSeries clone() => new TimeSeries()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TimeSeries create() => new TimeSeries();
  static PbList<TimeSeries> createRepeated() => new PbList<TimeSeries>();
  static TimeSeries getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTimeSeries();
    return _defaultInstance;
  }
  static TimeSeries _defaultInstance;
  static void $checkItem(TimeSeries v) {
    if (v is !TimeSeries) checkItemFailed(v, 'TimeSeries');
  }

  google$api.Metric get metric => $_get(0, 1, null);
  void set metric(google$api.Metric v) { setField(1, v); }
  bool hasMetric() => $_has(0, 1);
  void clearMetric() => clearField(1);

  google$api.MonitoredResource get resource => $_get(1, 2, null);
  void set resource(google$api.MonitoredResource v) { setField(2, v); }
  bool hasResource() => $_has(1, 2);
  void clearResource() => clearField(2);

  google$api.MetricDescriptor_MetricKind get metricKind => $_get(2, 3, null);
  void set metricKind(google$api.MetricDescriptor_MetricKind v) { setField(3, v); }
  bool hasMetricKind() => $_has(2, 3);
  void clearMetricKind() => clearField(3);

  google$api.MetricDescriptor_ValueType get valueType => $_get(3, 4, null);
  void set valueType(google$api.MetricDescriptor_ValueType v) { setField(4, v); }
  bool hasValueType() => $_has(3, 4);
  void clearValueType() => clearField(4);

  List<Point> get points => $_get(4, 5, null);
}

class _ReadonlyTimeSeries extends TimeSeries with ReadonlyMessageMixin {}

