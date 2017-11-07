///
//  Generated code. Do not modify.
///
library google.api_metric;

import 'package:protobuf/protobuf.dart';

import 'label.pb.dart';

import 'metric.pbenum.dart';

export 'metric.pbenum.dart';

class MetricDescriptor extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MetricDescriptor')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..pp/*<LabelDescriptor>*/(2, 'labels', PbFieldType.PM, LabelDescriptor.$checkItem, LabelDescriptor.create)
    ..e/*<MetricDescriptor_MetricKind>*/(3, 'metricKind', PbFieldType.OE, MetricDescriptor_MetricKind.METRIC_KIND_UNSPECIFIED, MetricDescriptor_MetricKind.valueOf)
    ..e/*<MetricDescriptor_ValueType>*/(4, 'valueType', PbFieldType.OE, MetricDescriptor_ValueType.VALUE_TYPE_UNSPECIFIED, MetricDescriptor_ValueType.valueOf)
    ..a/*<String>*/(5, 'unit', PbFieldType.OS)
    ..a/*<String>*/(6, 'description', PbFieldType.OS)
    ..a/*<String>*/(7, 'displayName', PbFieldType.OS)
    ..a/*<String>*/(8, 'type', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  MetricDescriptor() : super();
  MetricDescriptor.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MetricDescriptor.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MetricDescriptor clone() => new MetricDescriptor()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MetricDescriptor create() => new MetricDescriptor();
  static PbList<MetricDescriptor> createRepeated() => new PbList<MetricDescriptor>();
  static MetricDescriptor getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMetricDescriptor();
    return _defaultInstance;
  }
  static MetricDescriptor _defaultInstance;
  static void $checkItem(MetricDescriptor v) {
    if (v is !MetricDescriptor) checkItemFailed(v, 'MetricDescriptor');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  List<LabelDescriptor> get labels => $_get(1, 2, null);

  MetricDescriptor_MetricKind get metricKind => $_get(2, 3, null);
  void set metricKind(MetricDescriptor_MetricKind v) { setField(3, v); }
  bool hasMetricKind() => $_has(2, 3);
  void clearMetricKind() => clearField(3);

  MetricDescriptor_ValueType get valueType => $_get(3, 4, null);
  void set valueType(MetricDescriptor_ValueType v) { setField(4, v); }
  bool hasValueType() => $_has(3, 4);
  void clearValueType() => clearField(4);

  String get unit => $_get(4, 5, '');
  void set unit(String v) { $_setString(4, 5, v); }
  bool hasUnit() => $_has(4, 5);
  void clearUnit() => clearField(5);

  String get description => $_get(5, 6, '');
  void set description(String v) { $_setString(5, 6, v); }
  bool hasDescription() => $_has(5, 6);
  void clearDescription() => clearField(6);

  String get displayName => $_get(6, 7, '');
  void set displayName(String v) { $_setString(6, 7, v); }
  bool hasDisplayName() => $_has(6, 7);
  void clearDisplayName() => clearField(7);

  String get type => $_get(7, 8, '');
  void set type(String v) { $_setString(7, 8, v); }
  bool hasType() => $_has(7, 8);
  void clearType() => clearField(8);
}

class _ReadonlyMetricDescriptor extends MetricDescriptor with ReadonlyMessageMixin {}

class Metric_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Metric_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Metric_LabelsEntry() : super();
  Metric_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Metric_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Metric_LabelsEntry clone() => new Metric_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Metric_LabelsEntry create() => new Metric_LabelsEntry();
  static PbList<Metric_LabelsEntry> createRepeated() => new PbList<Metric_LabelsEntry>();
  static Metric_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMetric_LabelsEntry();
    return _defaultInstance;
  }
  static Metric_LabelsEntry _defaultInstance;
  static void $checkItem(Metric_LabelsEntry v) {
    if (v is !Metric_LabelsEntry) checkItemFailed(v, 'Metric_LabelsEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  String get value => $_get(1, 2, '');
  void set value(String v) { $_setString(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyMetric_LabelsEntry extends Metric_LabelsEntry with ReadonlyMessageMixin {}

class Metric extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Metric')
    ..pp/*<Metric_LabelsEntry>*/(2, 'labels', PbFieldType.PM, Metric_LabelsEntry.$checkItem, Metric_LabelsEntry.create)
    ..a/*<String>*/(3, 'type', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Metric() : super();
  Metric.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Metric.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Metric clone() => new Metric()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Metric create() => new Metric();
  static PbList<Metric> createRepeated() => new PbList<Metric>();
  static Metric getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMetric();
    return _defaultInstance;
  }
  static Metric _defaultInstance;
  static void $checkItem(Metric v) {
    if (v is !Metric) checkItemFailed(v, 'Metric');
  }

  List<Metric_LabelsEntry> get labels => $_get(0, 2, null);

  String get type => $_get(1, 3, '');
  void set type(String v) { $_setString(1, 3, v); }
  bool hasType() => $_has(1, 3);
  void clearType() => clearField(3);
}

class _ReadonlyMetric extends Metric with ReadonlyMessageMixin {}

