///
//  Generated code. Do not modify.
///
library google.api.servicemanagement.v1_resources;

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../config_change.pb.dart' as google$api;

import 'resources.pbenum.dart';

export 'resources.pbenum.dart';

class ManagedService extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ManagedService')
    ..a/*<String>*/(2, 'serviceName', PbFieldType.OS)
    ..a/*<String>*/(3, 'producerProjectId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ManagedService() : super();
  ManagedService.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ManagedService.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ManagedService clone() => new ManagedService()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ManagedService create() => new ManagedService();
  static PbList<ManagedService> createRepeated() => new PbList<ManagedService>();
  static ManagedService getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyManagedService();
    return _defaultInstance;
  }
  static ManagedService _defaultInstance;
  static void $checkItem(ManagedService v) {
    if (v is !ManagedService) checkItemFailed(v, 'ManagedService');
  }

  String get serviceName => $_get(0, 2, '');
  void set serviceName(String v) { $_setString(0, 2, v); }
  bool hasServiceName() => $_has(0, 2);
  void clearServiceName() => clearField(2);

  String get producerProjectId => $_get(1, 3, '');
  void set producerProjectId(String v) { $_setString(1, 3, v); }
  bool hasProducerProjectId() => $_has(1, 3);
  void clearProducerProjectId() => clearField(3);
}

class _ReadonlyManagedService extends ManagedService with ReadonlyMessageMixin {}

class OperationMetadata_Step extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('OperationMetadata_Step')
    ..a/*<String>*/(2, 'description', PbFieldType.OS)
    ..e/*<OperationMetadata_Status>*/(4, 'status', PbFieldType.OE, OperationMetadata_Status.STATUS_UNSPECIFIED, OperationMetadata_Status.valueOf)
    ..hasRequiredFields = false
  ;

  OperationMetadata_Step() : super();
  OperationMetadata_Step.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  OperationMetadata_Step.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  OperationMetadata_Step clone() => new OperationMetadata_Step()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static OperationMetadata_Step create() => new OperationMetadata_Step();
  static PbList<OperationMetadata_Step> createRepeated() => new PbList<OperationMetadata_Step>();
  static OperationMetadata_Step getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOperationMetadata_Step();
    return _defaultInstance;
  }
  static OperationMetadata_Step _defaultInstance;
  static void $checkItem(OperationMetadata_Step v) {
    if (v is !OperationMetadata_Step) checkItemFailed(v, 'OperationMetadata_Step');
  }

  String get description => $_get(0, 2, '');
  void set description(String v) { $_setString(0, 2, v); }
  bool hasDescription() => $_has(0, 2);
  void clearDescription() => clearField(2);

  OperationMetadata_Status get status => $_get(1, 4, null);
  void set status(OperationMetadata_Status v) { setField(4, v); }
  bool hasStatus() => $_has(1, 4);
  void clearStatus() => clearField(4);
}

class _ReadonlyOperationMetadata_Step extends OperationMetadata_Step with ReadonlyMessageMixin {}

class OperationMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('OperationMetadata')
    ..p/*<String>*/(1, 'resourceNames', PbFieldType.PS)
    ..pp/*<OperationMetadata_Step>*/(2, 'steps', PbFieldType.PM, OperationMetadata_Step.$checkItem, OperationMetadata_Step.create)
    ..a/*<int>*/(3, 'progressPercentage', PbFieldType.O3)
    ..a/*<google$protobuf.Timestamp>*/(4, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  OperationMetadata() : super();
  OperationMetadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  OperationMetadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  OperationMetadata clone() => new OperationMetadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static OperationMetadata create() => new OperationMetadata();
  static PbList<OperationMetadata> createRepeated() => new PbList<OperationMetadata>();
  static OperationMetadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOperationMetadata();
    return _defaultInstance;
  }
  static OperationMetadata _defaultInstance;
  static void $checkItem(OperationMetadata v) {
    if (v is !OperationMetadata) checkItemFailed(v, 'OperationMetadata');
  }

  List<String> get resourceNames => $_get(0, 1, null);

  List<OperationMetadata_Step> get steps => $_get(1, 2, null);

  int get progressPercentage => $_get(2, 3, 0);
  void set progressPercentage(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasProgressPercentage() => $_has(2, 3);
  void clearProgressPercentage() => clearField(3);

  google$protobuf.Timestamp get startTime => $_get(3, 4, null);
  void set startTime(google$protobuf.Timestamp v) { setField(4, v); }
  bool hasStartTime() => $_has(3, 4);
  void clearStartTime() => clearField(4);
}

class _ReadonlyOperationMetadata extends OperationMetadata with ReadonlyMessageMixin {}

class Diagnostic extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Diagnostic')
    ..a/*<String>*/(1, 'location', PbFieldType.OS)
    ..e/*<Diagnostic_Kind>*/(2, 'kind', PbFieldType.OE, Diagnostic_Kind.WARNING, Diagnostic_Kind.valueOf)
    ..a/*<String>*/(3, 'message', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Diagnostic() : super();
  Diagnostic.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Diagnostic.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Diagnostic clone() => new Diagnostic()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Diagnostic create() => new Diagnostic();
  static PbList<Diagnostic> createRepeated() => new PbList<Diagnostic>();
  static Diagnostic getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDiagnostic();
    return _defaultInstance;
  }
  static Diagnostic _defaultInstance;
  static void $checkItem(Diagnostic v) {
    if (v is !Diagnostic) checkItemFailed(v, 'Diagnostic');
  }

  String get location => $_get(0, 1, '');
  void set location(String v) { $_setString(0, 1, v); }
  bool hasLocation() => $_has(0, 1);
  void clearLocation() => clearField(1);

  Diagnostic_Kind get kind => $_get(1, 2, null);
  void set kind(Diagnostic_Kind v) { setField(2, v); }
  bool hasKind() => $_has(1, 2);
  void clearKind() => clearField(2);

  String get message => $_get(2, 3, '');
  void set message(String v) { $_setString(2, 3, v); }
  bool hasMessage() => $_has(2, 3);
  void clearMessage() => clearField(3);
}

class _ReadonlyDiagnostic extends Diagnostic with ReadonlyMessageMixin {}

class ConfigSource extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ConfigSource')
    ..pp/*<ConfigFile>*/(2, 'files', PbFieldType.PM, ConfigFile.$checkItem, ConfigFile.create)
    ..a/*<String>*/(5, 'id', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ConfigSource() : super();
  ConfigSource.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ConfigSource.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ConfigSource clone() => new ConfigSource()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ConfigSource create() => new ConfigSource();
  static PbList<ConfigSource> createRepeated() => new PbList<ConfigSource>();
  static ConfigSource getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyConfigSource();
    return _defaultInstance;
  }
  static ConfigSource _defaultInstance;
  static void $checkItem(ConfigSource v) {
    if (v is !ConfigSource) checkItemFailed(v, 'ConfigSource');
  }

  List<ConfigFile> get files => $_get(0, 2, null);

  String get id => $_get(1, 5, '');
  void set id(String v) { $_setString(1, 5, v); }
  bool hasId() => $_has(1, 5);
  void clearId() => clearField(5);
}

class _ReadonlyConfigSource extends ConfigSource with ReadonlyMessageMixin {}

class ConfigFile extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ConfigFile')
    ..a/*<String>*/(1, 'filePath', PbFieldType.OS)
    ..a/*<List<int>>*/(3, 'fileContents', PbFieldType.OY)
    ..e/*<ConfigFile_FileType>*/(4, 'fileType', PbFieldType.OE, ConfigFile_FileType.FILE_TYPE_UNSPECIFIED, ConfigFile_FileType.valueOf)
    ..hasRequiredFields = false
  ;

  ConfigFile() : super();
  ConfigFile.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ConfigFile.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ConfigFile clone() => new ConfigFile()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ConfigFile create() => new ConfigFile();
  static PbList<ConfigFile> createRepeated() => new PbList<ConfigFile>();
  static ConfigFile getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyConfigFile();
    return _defaultInstance;
  }
  static ConfigFile _defaultInstance;
  static void $checkItem(ConfigFile v) {
    if (v is !ConfigFile) checkItemFailed(v, 'ConfigFile');
  }

  String get filePath => $_get(0, 1, '');
  void set filePath(String v) { $_setString(0, 1, v); }
  bool hasFilePath() => $_has(0, 1);
  void clearFilePath() => clearField(1);

  List<int> get fileContents => $_get(1, 3, null);
  void set fileContents(List<int> v) { $_setBytes(1, 3, v); }
  bool hasFileContents() => $_has(1, 3);
  void clearFileContents() => clearField(3);

  ConfigFile_FileType get fileType => $_get(2, 4, null);
  void set fileType(ConfigFile_FileType v) { setField(4, v); }
  bool hasFileType() => $_has(2, 4);
  void clearFileType() => clearField(4);
}

class _ReadonlyConfigFile extends ConfigFile with ReadonlyMessageMixin {}

class ConfigRef extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ConfigRef')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ConfigRef() : super();
  ConfigRef.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ConfigRef.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ConfigRef clone() => new ConfigRef()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ConfigRef create() => new ConfigRef();
  static PbList<ConfigRef> createRepeated() => new PbList<ConfigRef>();
  static ConfigRef getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyConfigRef();
    return _defaultInstance;
  }
  static ConfigRef _defaultInstance;
  static void $checkItem(ConfigRef v) {
    if (v is !ConfigRef) checkItemFailed(v, 'ConfigRef');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyConfigRef extends ConfigRef with ReadonlyMessageMixin {}

class ChangeReport extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ChangeReport')
    ..pp/*<google$api.ConfigChange>*/(1, 'configChanges', PbFieldType.PM, google$api.ConfigChange.$checkItem, google$api.ConfigChange.create)
    ..hasRequiredFields = false
  ;

  ChangeReport() : super();
  ChangeReport.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ChangeReport.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ChangeReport clone() => new ChangeReport()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ChangeReport create() => new ChangeReport();
  static PbList<ChangeReport> createRepeated() => new PbList<ChangeReport>();
  static ChangeReport getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyChangeReport();
    return _defaultInstance;
  }
  static ChangeReport _defaultInstance;
  static void $checkItem(ChangeReport v) {
    if (v is !ChangeReport) checkItemFailed(v, 'ChangeReport');
  }

  List<google$api.ConfigChange> get configChanges => $_get(0, 1, null);
}

class _ReadonlyChangeReport extends ChangeReport with ReadonlyMessageMixin {}

class Rollout_TrafficPercentStrategy_PercentagesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Rollout_TrafficPercentStrategy_PercentagesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<double>*/(2, 'value', PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Rollout_TrafficPercentStrategy_PercentagesEntry() : super();
  Rollout_TrafficPercentStrategy_PercentagesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Rollout_TrafficPercentStrategy_PercentagesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Rollout_TrafficPercentStrategy_PercentagesEntry clone() => new Rollout_TrafficPercentStrategy_PercentagesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Rollout_TrafficPercentStrategy_PercentagesEntry create() => new Rollout_TrafficPercentStrategy_PercentagesEntry();
  static PbList<Rollout_TrafficPercentStrategy_PercentagesEntry> createRepeated() => new PbList<Rollout_TrafficPercentStrategy_PercentagesEntry>();
  static Rollout_TrafficPercentStrategy_PercentagesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRollout_TrafficPercentStrategy_PercentagesEntry();
    return _defaultInstance;
  }
  static Rollout_TrafficPercentStrategy_PercentagesEntry _defaultInstance;
  static void $checkItem(Rollout_TrafficPercentStrategy_PercentagesEntry v) {
    if (v is !Rollout_TrafficPercentStrategy_PercentagesEntry) checkItemFailed(v, 'Rollout_TrafficPercentStrategy_PercentagesEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  double get value => $_get(1, 2, null);
  void set value(double v) { $_setDouble(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyRollout_TrafficPercentStrategy_PercentagesEntry extends Rollout_TrafficPercentStrategy_PercentagesEntry with ReadonlyMessageMixin {}

class Rollout_TrafficPercentStrategy extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Rollout_TrafficPercentStrategy')
    ..pp/*<Rollout_TrafficPercentStrategy_PercentagesEntry>*/(1, 'percentages', PbFieldType.PM, Rollout_TrafficPercentStrategy_PercentagesEntry.$checkItem, Rollout_TrafficPercentStrategy_PercentagesEntry.create)
    ..hasRequiredFields = false
  ;

  Rollout_TrafficPercentStrategy() : super();
  Rollout_TrafficPercentStrategy.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Rollout_TrafficPercentStrategy.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Rollout_TrafficPercentStrategy clone() => new Rollout_TrafficPercentStrategy()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Rollout_TrafficPercentStrategy create() => new Rollout_TrafficPercentStrategy();
  static PbList<Rollout_TrafficPercentStrategy> createRepeated() => new PbList<Rollout_TrafficPercentStrategy>();
  static Rollout_TrafficPercentStrategy getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRollout_TrafficPercentStrategy();
    return _defaultInstance;
  }
  static Rollout_TrafficPercentStrategy _defaultInstance;
  static void $checkItem(Rollout_TrafficPercentStrategy v) {
    if (v is !Rollout_TrafficPercentStrategy) checkItemFailed(v, 'Rollout_TrafficPercentStrategy');
  }

  List<Rollout_TrafficPercentStrategy_PercentagesEntry> get percentages => $_get(0, 1, null);
}

class _ReadonlyRollout_TrafficPercentStrategy extends Rollout_TrafficPercentStrategy with ReadonlyMessageMixin {}

class Rollout_DeleteServiceStrategy extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Rollout_DeleteServiceStrategy')
    ..hasRequiredFields = false
  ;

  Rollout_DeleteServiceStrategy() : super();
  Rollout_DeleteServiceStrategy.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Rollout_DeleteServiceStrategy.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Rollout_DeleteServiceStrategy clone() => new Rollout_DeleteServiceStrategy()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Rollout_DeleteServiceStrategy create() => new Rollout_DeleteServiceStrategy();
  static PbList<Rollout_DeleteServiceStrategy> createRepeated() => new PbList<Rollout_DeleteServiceStrategy>();
  static Rollout_DeleteServiceStrategy getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRollout_DeleteServiceStrategy();
    return _defaultInstance;
  }
  static Rollout_DeleteServiceStrategy _defaultInstance;
  static void $checkItem(Rollout_DeleteServiceStrategy v) {
    if (v is !Rollout_DeleteServiceStrategy) checkItemFailed(v, 'Rollout_DeleteServiceStrategy');
  }
}

class _ReadonlyRollout_DeleteServiceStrategy extends Rollout_DeleteServiceStrategy with ReadonlyMessageMixin {}

class Rollout extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Rollout')
    ..a/*<String>*/(1, 'rolloutId', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(2, 'createTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<String>*/(3, 'createdBy', PbFieldType.OS)
    ..e/*<Rollout_RolloutStatus>*/(4, 'status', PbFieldType.OE, Rollout_RolloutStatus.ROLLOUT_STATUS_UNSPECIFIED, Rollout_RolloutStatus.valueOf)
    ..a/*<Rollout_TrafficPercentStrategy>*/(5, 'trafficPercentStrategy', PbFieldType.OM, Rollout_TrafficPercentStrategy.getDefault, Rollout_TrafficPercentStrategy.create)
    ..a/*<String>*/(8, 'serviceName', PbFieldType.OS)
    ..a/*<Rollout_DeleteServiceStrategy>*/(200, 'deleteServiceStrategy', PbFieldType.OM, Rollout_DeleteServiceStrategy.getDefault, Rollout_DeleteServiceStrategy.create)
    ..hasRequiredFields = false
  ;

  Rollout() : super();
  Rollout.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Rollout.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Rollout clone() => new Rollout()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Rollout create() => new Rollout();
  static PbList<Rollout> createRepeated() => new PbList<Rollout>();
  static Rollout getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRollout();
    return _defaultInstance;
  }
  static Rollout _defaultInstance;
  static void $checkItem(Rollout v) {
    if (v is !Rollout) checkItemFailed(v, 'Rollout');
  }

  String get rolloutId => $_get(0, 1, '');
  void set rolloutId(String v) { $_setString(0, 1, v); }
  bool hasRolloutId() => $_has(0, 1);
  void clearRolloutId() => clearField(1);

  google$protobuf.Timestamp get createTime => $_get(1, 2, null);
  void set createTime(google$protobuf.Timestamp v) { setField(2, v); }
  bool hasCreateTime() => $_has(1, 2);
  void clearCreateTime() => clearField(2);

  String get createdBy => $_get(2, 3, '');
  void set createdBy(String v) { $_setString(2, 3, v); }
  bool hasCreatedBy() => $_has(2, 3);
  void clearCreatedBy() => clearField(3);

  Rollout_RolloutStatus get status => $_get(3, 4, null);
  void set status(Rollout_RolloutStatus v) { setField(4, v); }
  bool hasStatus() => $_has(3, 4);
  void clearStatus() => clearField(4);

  Rollout_TrafficPercentStrategy get trafficPercentStrategy => $_get(4, 5, null);
  void set trafficPercentStrategy(Rollout_TrafficPercentStrategy v) { setField(5, v); }
  bool hasTrafficPercentStrategy() => $_has(4, 5);
  void clearTrafficPercentStrategy() => clearField(5);

  String get serviceName => $_get(5, 8, '');
  void set serviceName(String v) { $_setString(5, 8, v); }
  bool hasServiceName() => $_has(5, 8);
  void clearServiceName() => clearField(8);

  Rollout_DeleteServiceStrategy get deleteServiceStrategy => $_get(6, 200, null);
  void set deleteServiceStrategy(Rollout_DeleteServiceStrategy v) { setField(200, v); }
  bool hasDeleteServiceStrategy() => $_has(6, 200);
  void clearDeleteServiceStrategy() => clearField(200);
}

class _ReadonlyRollout extends Rollout with ReadonlyMessageMixin {}

