///
//  Generated code. Do not modify.
///
library google.api_service;

import 'package:protobuf/protobuf.dart';

import '../protobuf/api.pb.dart' as google$protobuf;
import '../protobuf/type.pb.dart' as google$protobuf;
import 'documentation.pb.dart';
import 'backend.pb.dart';
import 'http.pb.dart';
import 'auth.pb.dart';
import 'context.pb.dart';
import 'usage.pb.dart';
import 'endpoint.pb.dart';
import '../protobuf/wrappers.pb.dart' as google$protobuf;
import 'control.pb.dart';
import 'log.pb.dart';
import 'metric.pb.dart';
import 'monitored_resource.pb.dart';
import 'logging.pb.dart';
import 'monitoring.pb.dart';
import 'system_parameter.pb.dart';
import 'experimental/experimental.pb.dart';

class Service extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Service')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'title', PbFieldType.OS)
    ..pp/*<google$protobuf.Api>*/(3, 'apis', PbFieldType.PM, google$protobuf.Api.$checkItem, google$protobuf.Api.create)
    ..pp/*<google$protobuf.Type>*/(4, 'types', PbFieldType.PM, google$protobuf.Type.$checkItem, google$protobuf.Type.create)
    ..pp/*<google$protobuf.Enum>*/(5, 'enums', PbFieldType.PM, google$protobuf.Enum.$checkItem, google$protobuf.Enum.create)
    ..a/*<Documentation>*/(6, 'documentation', PbFieldType.OM, Documentation.getDefault, Documentation.create)
    ..a/*<Backend>*/(8, 'backend', PbFieldType.OM, Backend.getDefault, Backend.create)
    ..a/*<Http>*/(9, 'http', PbFieldType.OM, Http.getDefault, Http.create)
    ..a/*<Authentication>*/(11, 'authentication', PbFieldType.OM, Authentication.getDefault, Authentication.create)
    ..a/*<Context>*/(12, 'context', PbFieldType.OM, Context.getDefault, Context.create)
    ..a/*<Usage>*/(15, 'usage', PbFieldType.OM, Usage.getDefault, Usage.create)
    ..pp/*<Endpoint>*/(18, 'endpoints', PbFieldType.PM, Endpoint.$checkItem, Endpoint.create)
    ..a/*<google$protobuf.UInt32Value>*/(20, 'configVersion', PbFieldType.OM, google$protobuf.UInt32Value.getDefault, google$protobuf.UInt32Value.create)
    ..a/*<Control>*/(21, 'control', PbFieldType.OM, Control.getDefault, Control.create)
    ..a/*<String>*/(22, 'producerProjectId', PbFieldType.OS)
    ..pp/*<LogDescriptor>*/(23, 'logs', PbFieldType.PM, LogDescriptor.$checkItem, LogDescriptor.create)
    ..pp/*<MetricDescriptor>*/(24, 'metrics', PbFieldType.PM, MetricDescriptor.$checkItem, MetricDescriptor.create)
    ..pp/*<MonitoredResourceDescriptor>*/(25, 'monitoredResources', PbFieldType.PM, MonitoredResourceDescriptor.$checkItem, MonitoredResourceDescriptor.create)
    ..a/*<Logging>*/(27, 'logging', PbFieldType.OM, Logging.getDefault, Logging.create)
    ..a/*<Monitoring>*/(28, 'monitoring', PbFieldType.OM, Monitoring.getDefault, Monitoring.create)
    ..a/*<SystemParameters>*/(29, 'systemParameters', PbFieldType.OM, SystemParameters.getDefault, SystemParameters.create)
    ..a/*<String>*/(33, 'id', PbFieldType.OS)
    ..a/*<Experimental>*/(101, 'experimental', PbFieldType.OM, Experimental.getDefault, Experimental.create)
    ..hasRequiredFields = false
  ;

  Service() : super();
  Service.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Service.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Service clone() => new Service()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Service create() => new Service();
  static PbList<Service> createRepeated() => new PbList<Service>();
  static Service getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyService();
    return _defaultInstance;
  }
  static Service _defaultInstance;
  static void $checkItem(Service v) {
    if (v is !Service) checkItemFailed(v, 'Service');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get title => $_get(1, 2, '');
  void set title(String v) { $_setString(1, 2, v); }
  bool hasTitle() => $_has(1, 2);
  void clearTitle() => clearField(2);

  List<google$protobuf.Api> get apis => $_get(2, 3, null);

  List<google$protobuf.Type> get types => $_get(3, 4, null);

  List<google$protobuf.Enum> get enums => $_get(4, 5, null);

  Documentation get documentation => $_get(5, 6, null);
  void set documentation(Documentation v) { setField(6, v); }
  bool hasDocumentation() => $_has(5, 6);
  void clearDocumentation() => clearField(6);

  Backend get backend => $_get(6, 8, null);
  void set backend(Backend v) { setField(8, v); }
  bool hasBackend() => $_has(6, 8);
  void clearBackend() => clearField(8);

  Http get http => $_get(7, 9, null);
  void set http(Http v) { setField(9, v); }
  bool hasHttp() => $_has(7, 9);
  void clearHttp() => clearField(9);

  Authentication get authentication => $_get(8, 11, null);
  void set authentication(Authentication v) { setField(11, v); }
  bool hasAuthentication() => $_has(8, 11);
  void clearAuthentication() => clearField(11);

  Context get context => $_get(9, 12, null);
  void set context(Context v) { setField(12, v); }
  bool hasContext() => $_has(9, 12);
  void clearContext() => clearField(12);

  Usage get usage => $_get(10, 15, null);
  void set usage(Usage v) { setField(15, v); }
  bool hasUsage() => $_has(10, 15);
  void clearUsage() => clearField(15);

  List<Endpoint> get endpoints => $_get(11, 18, null);

  google$protobuf.UInt32Value get configVersion => $_get(12, 20, null);
  void set configVersion(google$protobuf.UInt32Value v) { setField(20, v); }
  bool hasConfigVersion() => $_has(12, 20);
  void clearConfigVersion() => clearField(20);

  Control get control => $_get(13, 21, null);
  void set control(Control v) { setField(21, v); }
  bool hasControl() => $_has(13, 21);
  void clearControl() => clearField(21);

  String get producerProjectId => $_get(14, 22, '');
  void set producerProjectId(String v) { $_setString(14, 22, v); }
  bool hasProducerProjectId() => $_has(14, 22);
  void clearProducerProjectId() => clearField(22);

  List<LogDescriptor> get logs => $_get(15, 23, null);

  List<MetricDescriptor> get metrics => $_get(16, 24, null);

  List<MonitoredResourceDescriptor> get monitoredResources => $_get(17, 25, null);

  Logging get logging => $_get(18, 27, null);
  void set logging(Logging v) { setField(27, v); }
  bool hasLogging() => $_has(18, 27);
  void clearLogging() => clearField(27);

  Monitoring get monitoring => $_get(19, 28, null);
  void set monitoring(Monitoring v) { setField(28, v); }
  bool hasMonitoring() => $_has(19, 28);
  void clearMonitoring() => clearField(28);

  SystemParameters get systemParameters => $_get(20, 29, null);
  void set systemParameters(SystemParameters v) { setField(29, v); }
  bool hasSystemParameters() => $_has(20, 29);
  void clearSystemParameters() => clearField(29);

  String get id => $_get(21, 33, '');
  void set id(String v) { $_setString(21, 33, v); }
  bool hasId() => $_has(21, 33);
  void clearId() => clearField(33);

  Experimental get experimental => $_get(22, 101, null);
  void set experimental(Experimental v) { setField(101, v); }
  bool hasExperimental() => $_has(22, 101);
  void clearExperimental() => clearField(101);
}

class _ReadonlyService extends Service with ReadonlyMessageMixin {}

