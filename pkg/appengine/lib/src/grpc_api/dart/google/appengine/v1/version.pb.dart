///
//  Generated code. Do not modify.
///
library google.appengine.v1_version;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../../protobuf/timestamp.pb.dart' as google$protobuf;
import 'app_yaml.pb.dart';
import '../../protobuf/duration.pb.dart' as google$protobuf;
import 'deploy.pb.dart';

import 'version.pbenum.dart';

export 'version.pbenum.dart';

class Version_BetaSettingsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Version_BetaSettingsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Version_BetaSettingsEntry() : super();
  Version_BetaSettingsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Version_BetaSettingsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Version_BetaSettingsEntry clone() => new Version_BetaSettingsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Version_BetaSettingsEntry create() => new Version_BetaSettingsEntry();
  static PbList<Version_BetaSettingsEntry> createRepeated() => new PbList<Version_BetaSettingsEntry>();
  static Version_BetaSettingsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyVersion_BetaSettingsEntry();
    return _defaultInstance;
  }
  static Version_BetaSettingsEntry _defaultInstance;
  static void $checkItem(Version_BetaSettingsEntry v) {
    if (v is !Version_BetaSettingsEntry) checkItemFailed(v, 'Version_BetaSettingsEntry');
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

class _ReadonlyVersion_BetaSettingsEntry extends Version_BetaSettingsEntry with ReadonlyMessageMixin {}

class Version_EnvVariablesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Version_EnvVariablesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Version_EnvVariablesEntry() : super();
  Version_EnvVariablesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Version_EnvVariablesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Version_EnvVariablesEntry clone() => new Version_EnvVariablesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Version_EnvVariablesEntry create() => new Version_EnvVariablesEntry();
  static PbList<Version_EnvVariablesEntry> createRepeated() => new PbList<Version_EnvVariablesEntry>();
  static Version_EnvVariablesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyVersion_EnvVariablesEntry();
    return _defaultInstance;
  }
  static Version_EnvVariablesEntry _defaultInstance;
  static void $checkItem(Version_EnvVariablesEntry v) {
    if (v is !Version_EnvVariablesEntry) checkItemFailed(v, 'Version_EnvVariablesEntry');
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

class _ReadonlyVersion_EnvVariablesEntry extends Version_EnvVariablesEntry with ReadonlyMessageMixin {}

class Version extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Version')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'id', PbFieldType.OS)
    ..a/*<AutomaticScaling>*/(3, 'automaticScaling', PbFieldType.OM, AutomaticScaling.getDefault, AutomaticScaling.create)
    ..a/*<BasicScaling>*/(4, 'basicScaling', PbFieldType.OM, BasicScaling.getDefault, BasicScaling.create)
    ..a/*<ManualScaling>*/(5, 'manualScaling', PbFieldType.OM, ManualScaling.getDefault, ManualScaling.create)
    ..pp/*<InboundServiceType>*/(6, 'inboundServices', PbFieldType.PE, InboundServiceType.$checkItem, null, InboundServiceType.valueOf)
    ..a/*<String>*/(7, 'instanceClass', PbFieldType.OS)
    ..a/*<Network>*/(8, 'network', PbFieldType.OM, Network.getDefault, Network.create)
    ..a/*<Resources>*/(9, 'resources', PbFieldType.OM, Resources.getDefault, Resources.create)
    ..a/*<String>*/(10, 'runtime', PbFieldType.OS)
    ..a/*<bool>*/(11, 'threadsafe', PbFieldType.OB)
    ..a/*<bool>*/(12, 'vm', PbFieldType.OB)
    ..pp/*<Version_BetaSettingsEntry>*/(13, 'betaSettings', PbFieldType.PM, Version_BetaSettingsEntry.$checkItem, Version_BetaSettingsEntry.create)
    ..a/*<String>*/(14, 'env', PbFieldType.OS)
    ..e/*<ServingStatus>*/(15, 'servingStatus', PbFieldType.OE, ServingStatus.SERVING_STATUS_UNSPECIFIED, ServingStatus.valueOf)
    ..a/*<String>*/(16, 'createdBy', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(17, 'createTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<Int64>*/(18, 'diskUsageBytes', PbFieldType.O6, Int64.ZERO)
    ..pp/*<UrlMap>*/(100, 'handlers', PbFieldType.PM, UrlMap.$checkItem, UrlMap.create)
    ..pp/*<ErrorHandler>*/(101, 'errorHandlers', PbFieldType.PM, ErrorHandler.$checkItem, ErrorHandler.create)
    ..pp/*<Library>*/(102, 'libraries', PbFieldType.PM, Library.$checkItem, Library.create)
    ..a/*<ApiConfigHandler>*/(103, 'apiConfig', PbFieldType.OM, ApiConfigHandler.getDefault, ApiConfigHandler.create)
    ..pp/*<Version_EnvVariablesEntry>*/(104, 'envVariables', PbFieldType.PM, Version_EnvVariablesEntry.$checkItem, Version_EnvVariablesEntry.create)
    ..a/*<google$protobuf.Duration>*/(105, 'defaultExpiration', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<HealthCheck>*/(106, 'healthCheck', PbFieldType.OM, HealthCheck.getDefault, HealthCheck.create)
    ..a/*<String>*/(107, 'nobuildFilesRegex', PbFieldType.OS)
    ..a/*<Deployment>*/(108, 'deployment', PbFieldType.OM, Deployment.getDefault, Deployment.create)
    ..a/*<String>*/(109, 'versionUrl', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Version() : super();
  Version.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Version.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Version clone() => new Version()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Version create() => new Version();
  static PbList<Version> createRepeated() => new PbList<Version>();
  static Version getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyVersion();
    return _defaultInstance;
  }
  static Version _defaultInstance;
  static void $checkItem(Version v) {
    if (v is !Version) checkItemFailed(v, 'Version');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get id => $_get(1, 2, '');
  void set id(String v) { $_setString(1, 2, v); }
  bool hasId() => $_has(1, 2);
  void clearId() => clearField(2);

  AutomaticScaling get automaticScaling => $_get(2, 3, null);
  void set automaticScaling(AutomaticScaling v) { setField(3, v); }
  bool hasAutomaticScaling() => $_has(2, 3);
  void clearAutomaticScaling() => clearField(3);

  BasicScaling get basicScaling => $_get(3, 4, null);
  void set basicScaling(BasicScaling v) { setField(4, v); }
  bool hasBasicScaling() => $_has(3, 4);
  void clearBasicScaling() => clearField(4);

  ManualScaling get manualScaling => $_get(4, 5, null);
  void set manualScaling(ManualScaling v) { setField(5, v); }
  bool hasManualScaling() => $_has(4, 5);
  void clearManualScaling() => clearField(5);

  List<InboundServiceType> get inboundServices => $_get(5, 6, null);

  String get instanceClass => $_get(6, 7, '');
  void set instanceClass(String v) { $_setString(6, 7, v); }
  bool hasInstanceClass() => $_has(6, 7);
  void clearInstanceClass() => clearField(7);

  Network get network => $_get(7, 8, null);
  void set network(Network v) { setField(8, v); }
  bool hasNetwork() => $_has(7, 8);
  void clearNetwork() => clearField(8);

  Resources get resources => $_get(8, 9, null);
  void set resources(Resources v) { setField(9, v); }
  bool hasResources() => $_has(8, 9);
  void clearResources() => clearField(9);

  String get runtime => $_get(9, 10, '');
  void set runtime(String v) { $_setString(9, 10, v); }
  bool hasRuntime() => $_has(9, 10);
  void clearRuntime() => clearField(10);

  bool get threadsafe => $_get(10, 11, false);
  void set threadsafe(bool v) { $_setBool(10, 11, v); }
  bool hasThreadsafe() => $_has(10, 11);
  void clearThreadsafe() => clearField(11);

  bool get vm => $_get(11, 12, false);
  void set vm(bool v) { $_setBool(11, 12, v); }
  bool hasVm() => $_has(11, 12);
  void clearVm() => clearField(12);

  List<Version_BetaSettingsEntry> get betaSettings => $_get(12, 13, null);

  String get env => $_get(13, 14, '');
  void set env(String v) { $_setString(13, 14, v); }
  bool hasEnv() => $_has(13, 14);
  void clearEnv() => clearField(14);

  ServingStatus get servingStatus => $_get(14, 15, null);
  void set servingStatus(ServingStatus v) { setField(15, v); }
  bool hasServingStatus() => $_has(14, 15);
  void clearServingStatus() => clearField(15);

  String get createdBy => $_get(15, 16, '');
  void set createdBy(String v) { $_setString(15, 16, v); }
  bool hasCreatedBy() => $_has(15, 16);
  void clearCreatedBy() => clearField(16);

  google$protobuf.Timestamp get createTime => $_get(16, 17, null);
  void set createTime(google$protobuf.Timestamp v) { setField(17, v); }
  bool hasCreateTime() => $_has(16, 17);
  void clearCreateTime() => clearField(17);

  Int64 get diskUsageBytes => $_get(17, 18, null);
  void set diskUsageBytes(Int64 v) { $_setInt64(17, 18, v); }
  bool hasDiskUsageBytes() => $_has(17, 18);
  void clearDiskUsageBytes() => clearField(18);

  List<UrlMap> get handlers => $_get(18, 100, null);

  List<ErrorHandler> get errorHandlers => $_get(19, 101, null);

  List<Library> get libraries => $_get(20, 102, null);

  ApiConfigHandler get apiConfig => $_get(21, 103, null);
  void set apiConfig(ApiConfigHandler v) { setField(103, v); }
  bool hasApiConfig() => $_has(21, 103);
  void clearApiConfig() => clearField(103);

  List<Version_EnvVariablesEntry> get envVariables => $_get(22, 104, null);

  google$protobuf.Duration get defaultExpiration => $_get(23, 105, null);
  void set defaultExpiration(google$protobuf.Duration v) { setField(105, v); }
  bool hasDefaultExpiration() => $_has(23, 105);
  void clearDefaultExpiration() => clearField(105);

  HealthCheck get healthCheck => $_get(24, 106, null);
  void set healthCheck(HealthCheck v) { setField(106, v); }
  bool hasHealthCheck() => $_has(24, 106);
  void clearHealthCheck() => clearField(106);

  String get nobuildFilesRegex => $_get(25, 107, '');
  void set nobuildFilesRegex(String v) { $_setString(25, 107, v); }
  bool hasNobuildFilesRegex() => $_has(25, 107);
  void clearNobuildFilesRegex() => clearField(107);

  Deployment get deployment => $_get(26, 108, null);
  void set deployment(Deployment v) { setField(108, v); }
  bool hasDeployment() => $_has(26, 108);
  void clearDeployment() => clearField(108);

  String get versionUrl => $_get(27, 109, '');
  void set versionUrl(String v) { $_setString(27, 109, v); }
  bool hasVersionUrl() => $_has(27, 109);
  void clearVersionUrl() => clearField(109);
}

class _ReadonlyVersion extends Version with ReadonlyMessageMixin {}

class AutomaticScaling extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AutomaticScaling')
    ..a/*<google$protobuf.Duration>*/(1, 'coolDownPeriod', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<CpuUtilization>*/(2, 'cpuUtilization', PbFieldType.OM, CpuUtilization.getDefault, CpuUtilization.create)
    ..a/*<int>*/(3, 'maxConcurrentRequests', PbFieldType.O3)
    ..a/*<int>*/(4, 'maxIdleInstances', PbFieldType.O3)
    ..a/*<int>*/(5, 'maxTotalInstances', PbFieldType.O3)
    ..a/*<google$protobuf.Duration>*/(6, 'maxPendingLatency', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<int>*/(7, 'minIdleInstances', PbFieldType.O3)
    ..a/*<int>*/(8, 'minTotalInstances', PbFieldType.O3)
    ..a/*<google$protobuf.Duration>*/(9, 'minPendingLatency', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<RequestUtilization>*/(10, 'requestUtilization', PbFieldType.OM, RequestUtilization.getDefault, RequestUtilization.create)
    ..a/*<DiskUtilization>*/(11, 'diskUtilization', PbFieldType.OM, DiskUtilization.getDefault, DiskUtilization.create)
    ..a/*<NetworkUtilization>*/(12, 'networkUtilization', PbFieldType.OM, NetworkUtilization.getDefault, NetworkUtilization.create)
    ..hasRequiredFields = false
  ;

  AutomaticScaling() : super();
  AutomaticScaling.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AutomaticScaling.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AutomaticScaling clone() => new AutomaticScaling()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AutomaticScaling create() => new AutomaticScaling();
  static PbList<AutomaticScaling> createRepeated() => new PbList<AutomaticScaling>();
  static AutomaticScaling getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAutomaticScaling();
    return _defaultInstance;
  }
  static AutomaticScaling _defaultInstance;
  static void $checkItem(AutomaticScaling v) {
    if (v is !AutomaticScaling) checkItemFailed(v, 'AutomaticScaling');
  }

  google$protobuf.Duration get coolDownPeriod => $_get(0, 1, null);
  void set coolDownPeriod(google$protobuf.Duration v) { setField(1, v); }
  bool hasCoolDownPeriod() => $_has(0, 1);
  void clearCoolDownPeriod() => clearField(1);

  CpuUtilization get cpuUtilization => $_get(1, 2, null);
  void set cpuUtilization(CpuUtilization v) { setField(2, v); }
  bool hasCpuUtilization() => $_has(1, 2);
  void clearCpuUtilization() => clearField(2);

  int get maxConcurrentRequests => $_get(2, 3, 0);
  void set maxConcurrentRequests(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasMaxConcurrentRequests() => $_has(2, 3);
  void clearMaxConcurrentRequests() => clearField(3);

  int get maxIdleInstances => $_get(3, 4, 0);
  void set maxIdleInstances(int v) { $_setUnsignedInt32(3, 4, v); }
  bool hasMaxIdleInstances() => $_has(3, 4);
  void clearMaxIdleInstances() => clearField(4);

  int get maxTotalInstances => $_get(4, 5, 0);
  void set maxTotalInstances(int v) { $_setUnsignedInt32(4, 5, v); }
  bool hasMaxTotalInstances() => $_has(4, 5);
  void clearMaxTotalInstances() => clearField(5);

  google$protobuf.Duration get maxPendingLatency => $_get(5, 6, null);
  void set maxPendingLatency(google$protobuf.Duration v) { setField(6, v); }
  bool hasMaxPendingLatency() => $_has(5, 6);
  void clearMaxPendingLatency() => clearField(6);

  int get minIdleInstances => $_get(6, 7, 0);
  void set minIdleInstances(int v) { $_setUnsignedInt32(6, 7, v); }
  bool hasMinIdleInstances() => $_has(6, 7);
  void clearMinIdleInstances() => clearField(7);

  int get minTotalInstances => $_get(7, 8, 0);
  void set minTotalInstances(int v) { $_setUnsignedInt32(7, 8, v); }
  bool hasMinTotalInstances() => $_has(7, 8);
  void clearMinTotalInstances() => clearField(8);

  google$protobuf.Duration get minPendingLatency => $_get(8, 9, null);
  void set minPendingLatency(google$protobuf.Duration v) { setField(9, v); }
  bool hasMinPendingLatency() => $_has(8, 9);
  void clearMinPendingLatency() => clearField(9);

  RequestUtilization get requestUtilization => $_get(9, 10, null);
  void set requestUtilization(RequestUtilization v) { setField(10, v); }
  bool hasRequestUtilization() => $_has(9, 10);
  void clearRequestUtilization() => clearField(10);

  DiskUtilization get diskUtilization => $_get(10, 11, null);
  void set diskUtilization(DiskUtilization v) { setField(11, v); }
  bool hasDiskUtilization() => $_has(10, 11);
  void clearDiskUtilization() => clearField(11);

  NetworkUtilization get networkUtilization => $_get(11, 12, null);
  void set networkUtilization(NetworkUtilization v) { setField(12, v); }
  bool hasNetworkUtilization() => $_has(11, 12);
  void clearNetworkUtilization() => clearField(12);
}

class _ReadonlyAutomaticScaling extends AutomaticScaling with ReadonlyMessageMixin {}

class BasicScaling extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BasicScaling')
    ..a/*<google$protobuf.Duration>*/(1, 'idleTimeout', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<int>*/(2, 'maxInstances', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  BasicScaling() : super();
  BasicScaling.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BasicScaling.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BasicScaling clone() => new BasicScaling()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BasicScaling create() => new BasicScaling();
  static PbList<BasicScaling> createRepeated() => new PbList<BasicScaling>();
  static BasicScaling getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBasicScaling();
    return _defaultInstance;
  }
  static BasicScaling _defaultInstance;
  static void $checkItem(BasicScaling v) {
    if (v is !BasicScaling) checkItemFailed(v, 'BasicScaling');
  }

  google$protobuf.Duration get idleTimeout => $_get(0, 1, null);
  void set idleTimeout(google$protobuf.Duration v) { setField(1, v); }
  bool hasIdleTimeout() => $_has(0, 1);
  void clearIdleTimeout() => clearField(1);

  int get maxInstances => $_get(1, 2, 0);
  void set maxInstances(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasMaxInstances() => $_has(1, 2);
  void clearMaxInstances() => clearField(2);
}

class _ReadonlyBasicScaling extends BasicScaling with ReadonlyMessageMixin {}

class ManualScaling extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ManualScaling')
    ..a/*<int>*/(1, 'instances', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ManualScaling() : super();
  ManualScaling.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ManualScaling.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ManualScaling clone() => new ManualScaling()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ManualScaling create() => new ManualScaling();
  static PbList<ManualScaling> createRepeated() => new PbList<ManualScaling>();
  static ManualScaling getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyManualScaling();
    return _defaultInstance;
  }
  static ManualScaling _defaultInstance;
  static void $checkItem(ManualScaling v) {
    if (v is !ManualScaling) checkItemFailed(v, 'ManualScaling');
  }

  int get instances => $_get(0, 1, 0);
  void set instances(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasInstances() => $_has(0, 1);
  void clearInstances() => clearField(1);
}

class _ReadonlyManualScaling extends ManualScaling with ReadonlyMessageMixin {}

class CpuUtilization extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CpuUtilization')
    ..a/*<google$protobuf.Duration>*/(1, 'aggregationWindowLength', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<double>*/(2, 'targetUtilization', PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CpuUtilization() : super();
  CpuUtilization.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CpuUtilization.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CpuUtilization clone() => new CpuUtilization()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CpuUtilization create() => new CpuUtilization();
  static PbList<CpuUtilization> createRepeated() => new PbList<CpuUtilization>();
  static CpuUtilization getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCpuUtilization();
    return _defaultInstance;
  }
  static CpuUtilization _defaultInstance;
  static void $checkItem(CpuUtilization v) {
    if (v is !CpuUtilization) checkItemFailed(v, 'CpuUtilization');
  }

  google$protobuf.Duration get aggregationWindowLength => $_get(0, 1, null);
  void set aggregationWindowLength(google$protobuf.Duration v) { setField(1, v); }
  bool hasAggregationWindowLength() => $_has(0, 1);
  void clearAggregationWindowLength() => clearField(1);

  double get targetUtilization => $_get(1, 2, null);
  void set targetUtilization(double v) { $_setDouble(1, 2, v); }
  bool hasTargetUtilization() => $_has(1, 2);
  void clearTargetUtilization() => clearField(2);
}

class _ReadonlyCpuUtilization extends CpuUtilization with ReadonlyMessageMixin {}

class RequestUtilization extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RequestUtilization')
    ..a/*<int>*/(1, 'targetRequestCountPerSecond', PbFieldType.O3)
    ..a/*<int>*/(2, 'targetConcurrentRequests', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  RequestUtilization() : super();
  RequestUtilization.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RequestUtilization.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RequestUtilization clone() => new RequestUtilization()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RequestUtilization create() => new RequestUtilization();
  static PbList<RequestUtilization> createRepeated() => new PbList<RequestUtilization>();
  static RequestUtilization getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRequestUtilization();
    return _defaultInstance;
  }
  static RequestUtilization _defaultInstance;
  static void $checkItem(RequestUtilization v) {
    if (v is !RequestUtilization) checkItemFailed(v, 'RequestUtilization');
  }

  int get targetRequestCountPerSecond => $_get(0, 1, 0);
  void set targetRequestCountPerSecond(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasTargetRequestCountPerSecond() => $_has(0, 1);
  void clearTargetRequestCountPerSecond() => clearField(1);

  int get targetConcurrentRequests => $_get(1, 2, 0);
  void set targetConcurrentRequests(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasTargetConcurrentRequests() => $_has(1, 2);
  void clearTargetConcurrentRequests() => clearField(2);
}

class _ReadonlyRequestUtilization extends RequestUtilization with ReadonlyMessageMixin {}

class DiskUtilization extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DiskUtilization')
    ..a/*<int>*/(14, 'targetWriteBytesPerSecond', PbFieldType.O3)
    ..a/*<int>*/(15, 'targetWriteOpsPerSecond', PbFieldType.O3)
    ..a/*<int>*/(16, 'targetReadBytesPerSecond', PbFieldType.O3)
    ..a/*<int>*/(17, 'targetReadOpsPerSecond', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  DiskUtilization() : super();
  DiskUtilization.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DiskUtilization.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DiskUtilization clone() => new DiskUtilization()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DiskUtilization create() => new DiskUtilization();
  static PbList<DiskUtilization> createRepeated() => new PbList<DiskUtilization>();
  static DiskUtilization getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDiskUtilization();
    return _defaultInstance;
  }
  static DiskUtilization _defaultInstance;
  static void $checkItem(DiskUtilization v) {
    if (v is !DiskUtilization) checkItemFailed(v, 'DiskUtilization');
  }

  int get targetWriteBytesPerSecond => $_get(0, 14, 0);
  void set targetWriteBytesPerSecond(int v) { $_setUnsignedInt32(0, 14, v); }
  bool hasTargetWriteBytesPerSecond() => $_has(0, 14);
  void clearTargetWriteBytesPerSecond() => clearField(14);

  int get targetWriteOpsPerSecond => $_get(1, 15, 0);
  void set targetWriteOpsPerSecond(int v) { $_setUnsignedInt32(1, 15, v); }
  bool hasTargetWriteOpsPerSecond() => $_has(1, 15);
  void clearTargetWriteOpsPerSecond() => clearField(15);

  int get targetReadBytesPerSecond => $_get(2, 16, 0);
  void set targetReadBytesPerSecond(int v) { $_setUnsignedInt32(2, 16, v); }
  bool hasTargetReadBytesPerSecond() => $_has(2, 16);
  void clearTargetReadBytesPerSecond() => clearField(16);

  int get targetReadOpsPerSecond => $_get(3, 17, 0);
  void set targetReadOpsPerSecond(int v) { $_setUnsignedInt32(3, 17, v); }
  bool hasTargetReadOpsPerSecond() => $_has(3, 17);
  void clearTargetReadOpsPerSecond() => clearField(17);
}

class _ReadonlyDiskUtilization extends DiskUtilization with ReadonlyMessageMixin {}

class NetworkUtilization extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('NetworkUtilization')
    ..a/*<int>*/(1, 'targetSentBytesPerSecond', PbFieldType.O3)
    ..a/*<int>*/(11, 'targetSentPacketsPerSecond', PbFieldType.O3)
    ..a/*<int>*/(12, 'targetReceivedBytesPerSecond', PbFieldType.O3)
    ..a/*<int>*/(13, 'targetReceivedPacketsPerSecond', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  NetworkUtilization() : super();
  NetworkUtilization.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NetworkUtilization.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NetworkUtilization clone() => new NetworkUtilization()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static NetworkUtilization create() => new NetworkUtilization();
  static PbList<NetworkUtilization> createRepeated() => new PbList<NetworkUtilization>();
  static NetworkUtilization getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyNetworkUtilization();
    return _defaultInstance;
  }
  static NetworkUtilization _defaultInstance;
  static void $checkItem(NetworkUtilization v) {
    if (v is !NetworkUtilization) checkItemFailed(v, 'NetworkUtilization');
  }

  int get targetSentBytesPerSecond => $_get(0, 1, 0);
  void set targetSentBytesPerSecond(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasTargetSentBytesPerSecond() => $_has(0, 1);
  void clearTargetSentBytesPerSecond() => clearField(1);

  int get targetSentPacketsPerSecond => $_get(1, 11, 0);
  void set targetSentPacketsPerSecond(int v) { $_setUnsignedInt32(1, 11, v); }
  bool hasTargetSentPacketsPerSecond() => $_has(1, 11);
  void clearTargetSentPacketsPerSecond() => clearField(11);

  int get targetReceivedBytesPerSecond => $_get(2, 12, 0);
  void set targetReceivedBytesPerSecond(int v) { $_setUnsignedInt32(2, 12, v); }
  bool hasTargetReceivedBytesPerSecond() => $_has(2, 12);
  void clearTargetReceivedBytesPerSecond() => clearField(12);

  int get targetReceivedPacketsPerSecond => $_get(3, 13, 0);
  void set targetReceivedPacketsPerSecond(int v) { $_setUnsignedInt32(3, 13, v); }
  bool hasTargetReceivedPacketsPerSecond() => $_has(3, 13);
  void clearTargetReceivedPacketsPerSecond() => clearField(13);
}

class _ReadonlyNetworkUtilization extends NetworkUtilization with ReadonlyMessageMixin {}

class Network extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Network')
    ..p/*<String>*/(1, 'forwardedPorts', PbFieldType.PS)
    ..a/*<String>*/(2, 'instanceTag', PbFieldType.OS)
    ..a/*<String>*/(3, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Network() : super();
  Network.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Network.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Network clone() => new Network()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Network create() => new Network();
  static PbList<Network> createRepeated() => new PbList<Network>();
  static Network getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyNetwork();
    return _defaultInstance;
  }
  static Network _defaultInstance;
  static void $checkItem(Network v) {
    if (v is !Network) checkItemFailed(v, 'Network');
  }

  List<String> get forwardedPorts => $_get(0, 1, null);

  String get instanceTag => $_get(1, 2, '');
  void set instanceTag(String v) { $_setString(1, 2, v); }
  bool hasInstanceTag() => $_has(1, 2);
  void clearInstanceTag() => clearField(2);

  String get name => $_get(2, 3, '');
  void set name(String v) { $_setString(2, 3, v); }
  bool hasName() => $_has(2, 3);
  void clearName() => clearField(3);
}

class _ReadonlyNetwork extends Network with ReadonlyMessageMixin {}

class Resources extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Resources')
    ..a/*<double>*/(1, 'cpu', PbFieldType.OD)
    ..a/*<double>*/(2, 'diskGb', PbFieldType.OD)
    ..a/*<double>*/(3, 'memoryGb', PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Resources() : super();
  Resources.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Resources.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Resources clone() => new Resources()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Resources create() => new Resources();
  static PbList<Resources> createRepeated() => new PbList<Resources>();
  static Resources getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyResources();
    return _defaultInstance;
  }
  static Resources _defaultInstance;
  static void $checkItem(Resources v) {
    if (v is !Resources) checkItemFailed(v, 'Resources');
  }

  double get cpu => $_get(0, 1, null);
  void set cpu(double v) { $_setDouble(0, 1, v); }
  bool hasCpu() => $_has(0, 1);
  void clearCpu() => clearField(1);

  double get diskGb => $_get(1, 2, null);
  void set diskGb(double v) { $_setDouble(1, 2, v); }
  bool hasDiskGb() => $_has(1, 2);
  void clearDiskGb() => clearField(2);

  double get memoryGb => $_get(2, 3, null);
  void set memoryGb(double v) { $_setDouble(2, 3, v); }
  bool hasMemoryGb() => $_has(2, 3);
  void clearMemoryGb() => clearField(3);
}

class _ReadonlyResources extends Resources with ReadonlyMessageMixin {}

