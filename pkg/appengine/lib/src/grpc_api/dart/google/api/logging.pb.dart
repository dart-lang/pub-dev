///
//  Generated code. Do not modify.
///
library google.api_logging;

import 'package:protobuf/protobuf.dart';

class Logging_LoggingDestination extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Logging_LoggingDestination')
    ..p/*<String>*/(1, 'logs', PbFieldType.PS)
    ..a/*<String>*/(3, 'monitoredResource', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Logging_LoggingDestination() : super();
  Logging_LoggingDestination.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Logging_LoggingDestination.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Logging_LoggingDestination clone() => new Logging_LoggingDestination()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Logging_LoggingDestination create() => new Logging_LoggingDestination();
  static PbList<Logging_LoggingDestination> createRepeated() => new PbList<Logging_LoggingDestination>();
  static Logging_LoggingDestination getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLogging_LoggingDestination();
    return _defaultInstance;
  }
  static Logging_LoggingDestination _defaultInstance;
  static void $checkItem(Logging_LoggingDestination v) {
    if (v is !Logging_LoggingDestination) checkItemFailed(v, 'Logging_LoggingDestination');
  }

  List<String> get logs => $_get(0, 1, null);

  String get monitoredResource => $_get(1, 3, '');
  void set monitoredResource(String v) { $_setString(1, 3, v); }
  bool hasMonitoredResource() => $_has(1, 3);
  void clearMonitoredResource() => clearField(3);
}

class _ReadonlyLogging_LoggingDestination extends Logging_LoggingDestination with ReadonlyMessageMixin {}

class Logging extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Logging')
    ..pp/*<Logging_LoggingDestination>*/(1, 'producerDestinations', PbFieldType.PM, Logging_LoggingDestination.$checkItem, Logging_LoggingDestination.create)
    ..pp/*<Logging_LoggingDestination>*/(2, 'consumerDestinations', PbFieldType.PM, Logging_LoggingDestination.$checkItem, Logging_LoggingDestination.create)
    ..hasRequiredFields = false
  ;

  Logging() : super();
  Logging.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Logging.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Logging clone() => new Logging()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Logging create() => new Logging();
  static PbList<Logging> createRepeated() => new PbList<Logging>();
  static Logging getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLogging();
    return _defaultInstance;
  }
  static Logging _defaultInstance;
  static void $checkItem(Logging v) {
    if (v is !Logging) checkItemFailed(v, 'Logging');
  }

  List<Logging_LoggingDestination> get producerDestinations => $_get(0, 1, null);

  List<Logging_LoggingDestination> get consumerDestinations => $_get(1, 2, null);
}

class _ReadonlyLogging extends Logging with ReadonlyMessageMixin {}

