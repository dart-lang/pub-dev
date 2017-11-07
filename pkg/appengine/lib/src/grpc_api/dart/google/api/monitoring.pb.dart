///
//  Generated code. Do not modify.
///
library google.api_monitoring;

import 'package:protobuf/protobuf.dart';

class Monitoring_MonitoringDestination extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Monitoring_MonitoringDestination')
    ..a/*<String>*/(1, 'monitoredResource', PbFieldType.OS)
    ..p/*<String>*/(2, 'metrics', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  Monitoring_MonitoringDestination() : super();
  Monitoring_MonitoringDestination.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Monitoring_MonitoringDestination.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Monitoring_MonitoringDestination clone() => new Monitoring_MonitoringDestination()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Monitoring_MonitoringDestination create() => new Monitoring_MonitoringDestination();
  static PbList<Monitoring_MonitoringDestination> createRepeated() => new PbList<Monitoring_MonitoringDestination>();
  static Monitoring_MonitoringDestination getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMonitoring_MonitoringDestination();
    return _defaultInstance;
  }
  static Monitoring_MonitoringDestination _defaultInstance;
  static void $checkItem(Monitoring_MonitoringDestination v) {
    if (v is !Monitoring_MonitoringDestination) checkItemFailed(v, 'Monitoring_MonitoringDestination');
  }

  String get monitoredResource => $_get(0, 1, '');
  void set monitoredResource(String v) { $_setString(0, 1, v); }
  bool hasMonitoredResource() => $_has(0, 1);
  void clearMonitoredResource() => clearField(1);

  List<String> get metrics => $_get(1, 2, null);
}

class _ReadonlyMonitoring_MonitoringDestination extends Monitoring_MonitoringDestination with ReadonlyMessageMixin {}

class Monitoring extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Monitoring')
    ..pp/*<Monitoring_MonitoringDestination>*/(1, 'producerDestinations', PbFieldType.PM, Monitoring_MonitoringDestination.$checkItem, Monitoring_MonitoringDestination.create)
    ..pp/*<Monitoring_MonitoringDestination>*/(2, 'consumerDestinations', PbFieldType.PM, Monitoring_MonitoringDestination.$checkItem, Monitoring_MonitoringDestination.create)
    ..hasRequiredFields = false
  ;

  Monitoring() : super();
  Monitoring.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Monitoring.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Monitoring clone() => new Monitoring()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Monitoring create() => new Monitoring();
  static PbList<Monitoring> createRepeated() => new PbList<Monitoring>();
  static Monitoring getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMonitoring();
    return _defaultInstance;
  }
  static Monitoring _defaultInstance;
  static void $checkItem(Monitoring v) {
    if (v is !Monitoring) checkItemFailed(v, 'Monitoring');
  }

  List<Monitoring_MonitoringDestination> get producerDestinations => $_get(0, 1, null);

  List<Monitoring_MonitoringDestination> get consumerDestinations => $_get(1, 2, null);
}

class _ReadonlyMonitoring extends Monitoring with ReadonlyMessageMixin {}

