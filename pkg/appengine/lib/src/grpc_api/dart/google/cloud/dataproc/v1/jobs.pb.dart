///
//  Generated code. Do not modify.
///
library google.cloud.dataproc.v1_jobs;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../../protobuf/empty.pb.dart' as google$protobuf;

import 'jobs.pbenum.dart';

export 'jobs.pbenum.dart';

class LoggingConfig_DriverLogLevelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LoggingConfig_DriverLogLevelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..e/*<LoggingConfig_Level>*/(2, 'value', PbFieldType.OE, LoggingConfig_Level.LEVEL_UNSPECIFIED, LoggingConfig_Level.valueOf)
    ..hasRequiredFields = false
  ;

  LoggingConfig_DriverLogLevelsEntry() : super();
  LoggingConfig_DriverLogLevelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LoggingConfig_DriverLogLevelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LoggingConfig_DriverLogLevelsEntry clone() => new LoggingConfig_DriverLogLevelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LoggingConfig_DriverLogLevelsEntry create() => new LoggingConfig_DriverLogLevelsEntry();
  static PbList<LoggingConfig_DriverLogLevelsEntry> createRepeated() => new PbList<LoggingConfig_DriverLogLevelsEntry>();
  static LoggingConfig_DriverLogLevelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLoggingConfig_DriverLogLevelsEntry();
    return _defaultInstance;
  }
  static LoggingConfig_DriverLogLevelsEntry _defaultInstance;
  static void $checkItem(LoggingConfig_DriverLogLevelsEntry v) {
    if (v is !LoggingConfig_DriverLogLevelsEntry) checkItemFailed(v, 'LoggingConfig_DriverLogLevelsEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  LoggingConfig_Level get value => $_get(1, 2, null);
  void set value(LoggingConfig_Level v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyLoggingConfig_DriverLogLevelsEntry extends LoggingConfig_DriverLogLevelsEntry with ReadonlyMessageMixin {}

class LoggingConfig extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LoggingConfig')
    ..pp/*<LoggingConfig_DriverLogLevelsEntry>*/(2, 'driverLogLevels', PbFieldType.PM, LoggingConfig_DriverLogLevelsEntry.$checkItem, LoggingConfig_DriverLogLevelsEntry.create)
    ..hasRequiredFields = false
  ;

  LoggingConfig() : super();
  LoggingConfig.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LoggingConfig.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LoggingConfig clone() => new LoggingConfig()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LoggingConfig create() => new LoggingConfig();
  static PbList<LoggingConfig> createRepeated() => new PbList<LoggingConfig>();
  static LoggingConfig getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLoggingConfig();
    return _defaultInstance;
  }
  static LoggingConfig _defaultInstance;
  static void $checkItem(LoggingConfig v) {
    if (v is !LoggingConfig) checkItemFailed(v, 'LoggingConfig');
  }

  List<LoggingConfig_DriverLogLevelsEntry> get driverLogLevels => $_get(0, 2, null);
}

class _ReadonlyLoggingConfig extends LoggingConfig with ReadonlyMessageMixin {}

class HadoopJob_PropertiesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HadoopJob_PropertiesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  HadoopJob_PropertiesEntry() : super();
  HadoopJob_PropertiesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HadoopJob_PropertiesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HadoopJob_PropertiesEntry clone() => new HadoopJob_PropertiesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HadoopJob_PropertiesEntry create() => new HadoopJob_PropertiesEntry();
  static PbList<HadoopJob_PropertiesEntry> createRepeated() => new PbList<HadoopJob_PropertiesEntry>();
  static HadoopJob_PropertiesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHadoopJob_PropertiesEntry();
    return _defaultInstance;
  }
  static HadoopJob_PropertiesEntry _defaultInstance;
  static void $checkItem(HadoopJob_PropertiesEntry v) {
    if (v is !HadoopJob_PropertiesEntry) checkItemFailed(v, 'HadoopJob_PropertiesEntry');
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

class _ReadonlyHadoopJob_PropertiesEntry extends HadoopJob_PropertiesEntry with ReadonlyMessageMixin {}

class HadoopJob extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HadoopJob')
    ..a/*<String>*/(1, 'mainJarFileUri', PbFieldType.OS)
    ..a/*<String>*/(2, 'mainClass', PbFieldType.OS)
    ..p/*<String>*/(3, 'args', PbFieldType.PS)
    ..p/*<String>*/(4, 'jarFileUris', PbFieldType.PS)
    ..p/*<String>*/(5, 'fileUris', PbFieldType.PS)
    ..p/*<String>*/(6, 'archiveUris', PbFieldType.PS)
    ..pp/*<HadoopJob_PropertiesEntry>*/(7, 'properties', PbFieldType.PM, HadoopJob_PropertiesEntry.$checkItem, HadoopJob_PropertiesEntry.create)
    ..a/*<LoggingConfig>*/(8, 'loggingConfig', PbFieldType.OM, LoggingConfig.getDefault, LoggingConfig.create)
    ..hasRequiredFields = false
  ;

  HadoopJob() : super();
  HadoopJob.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HadoopJob.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HadoopJob clone() => new HadoopJob()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HadoopJob create() => new HadoopJob();
  static PbList<HadoopJob> createRepeated() => new PbList<HadoopJob>();
  static HadoopJob getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHadoopJob();
    return _defaultInstance;
  }
  static HadoopJob _defaultInstance;
  static void $checkItem(HadoopJob v) {
    if (v is !HadoopJob) checkItemFailed(v, 'HadoopJob');
  }

  String get mainJarFileUri => $_get(0, 1, '');
  void set mainJarFileUri(String v) { $_setString(0, 1, v); }
  bool hasMainJarFileUri() => $_has(0, 1);
  void clearMainJarFileUri() => clearField(1);

  String get mainClass => $_get(1, 2, '');
  void set mainClass(String v) { $_setString(1, 2, v); }
  bool hasMainClass() => $_has(1, 2);
  void clearMainClass() => clearField(2);

  List<String> get args => $_get(2, 3, null);

  List<String> get jarFileUris => $_get(3, 4, null);

  List<String> get fileUris => $_get(4, 5, null);

  List<String> get archiveUris => $_get(5, 6, null);

  List<HadoopJob_PropertiesEntry> get properties => $_get(6, 7, null);

  LoggingConfig get loggingConfig => $_get(7, 8, null);
  void set loggingConfig(LoggingConfig v) { setField(8, v); }
  bool hasLoggingConfig() => $_has(7, 8);
  void clearLoggingConfig() => clearField(8);
}

class _ReadonlyHadoopJob extends HadoopJob with ReadonlyMessageMixin {}

class SparkJob_PropertiesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SparkJob_PropertiesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SparkJob_PropertiesEntry() : super();
  SparkJob_PropertiesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SparkJob_PropertiesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SparkJob_PropertiesEntry clone() => new SparkJob_PropertiesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SparkJob_PropertiesEntry create() => new SparkJob_PropertiesEntry();
  static PbList<SparkJob_PropertiesEntry> createRepeated() => new PbList<SparkJob_PropertiesEntry>();
  static SparkJob_PropertiesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySparkJob_PropertiesEntry();
    return _defaultInstance;
  }
  static SparkJob_PropertiesEntry _defaultInstance;
  static void $checkItem(SparkJob_PropertiesEntry v) {
    if (v is !SparkJob_PropertiesEntry) checkItemFailed(v, 'SparkJob_PropertiesEntry');
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

class _ReadonlySparkJob_PropertiesEntry extends SparkJob_PropertiesEntry with ReadonlyMessageMixin {}

class SparkJob extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SparkJob')
    ..a/*<String>*/(1, 'mainJarFileUri', PbFieldType.OS)
    ..a/*<String>*/(2, 'mainClass', PbFieldType.OS)
    ..p/*<String>*/(3, 'args', PbFieldType.PS)
    ..p/*<String>*/(4, 'jarFileUris', PbFieldType.PS)
    ..p/*<String>*/(5, 'fileUris', PbFieldType.PS)
    ..p/*<String>*/(6, 'archiveUris', PbFieldType.PS)
    ..pp/*<SparkJob_PropertiesEntry>*/(7, 'properties', PbFieldType.PM, SparkJob_PropertiesEntry.$checkItem, SparkJob_PropertiesEntry.create)
    ..a/*<LoggingConfig>*/(8, 'loggingConfig', PbFieldType.OM, LoggingConfig.getDefault, LoggingConfig.create)
    ..hasRequiredFields = false
  ;

  SparkJob() : super();
  SparkJob.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SparkJob.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SparkJob clone() => new SparkJob()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SparkJob create() => new SparkJob();
  static PbList<SparkJob> createRepeated() => new PbList<SparkJob>();
  static SparkJob getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySparkJob();
    return _defaultInstance;
  }
  static SparkJob _defaultInstance;
  static void $checkItem(SparkJob v) {
    if (v is !SparkJob) checkItemFailed(v, 'SparkJob');
  }

  String get mainJarFileUri => $_get(0, 1, '');
  void set mainJarFileUri(String v) { $_setString(0, 1, v); }
  bool hasMainJarFileUri() => $_has(0, 1);
  void clearMainJarFileUri() => clearField(1);

  String get mainClass => $_get(1, 2, '');
  void set mainClass(String v) { $_setString(1, 2, v); }
  bool hasMainClass() => $_has(1, 2);
  void clearMainClass() => clearField(2);

  List<String> get args => $_get(2, 3, null);

  List<String> get jarFileUris => $_get(3, 4, null);

  List<String> get fileUris => $_get(4, 5, null);

  List<String> get archiveUris => $_get(5, 6, null);

  List<SparkJob_PropertiesEntry> get properties => $_get(6, 7, null);

  LoggingConfig get loggingConfig => $_get(7, 8, null);
  void set loggingConfig(LoggingConfig v) { setField(8, v); }
  bool hasLoggingConfig() => $_has(7, 8);
  void clearLoggingConfig() => clearField(8);
}

class _ReadonlySparkJob extends SparkJob with ReadonlyMessageMixin {}

class PySparkJob_PropertiesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PySparkJob_PropertiesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  PySparkJob_PropertiesEntry() : super();
  PySparkJob_PropertiesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PySparkJob_PropertiesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PySparkJob_PropertiesEntry clone() => new PySparkJob_PropertiesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PySparkJob_PropertiesEntry create() => new PySparkJob_PropertiesEntry();
  static PbList<PySparkJob_PropertiesEntry> createRepeated() => new PbList<PySparkJob_PropertiesEntry>();
  static PySparkJob_PropertiesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPySparkJob_PropertiesEntry();
    return _defaultInstance;
  }
  static PySparkJob_PropertiesEntry _defaultInstance;
  static void $checkItem(PySparkJob_PropertiesEntry v) {
    if (v is !PySparkJob_PropertiesEntry) checkItemFailed(v, 'PySparkJob_PropertiesEntry');
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

class _ReadonlyPySparkJob_PropertiesEntry extends PySparkJob_PropertiesEntry with ReadonlyMessageMixin {}

class PySparkJob extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PySparkJob')
    ..a/*<String>*/(1, 'mainPythonFileUri', PbFieldType.OS)
    ..p/*<String>*/(2, 'args', PbFieldType.PS)
    ..p/*<String>*/(3, 'pythonFileUris', PbFieldType.PS)
    ..p/*<String>*/(4, 'jarFileUris', PbFieldType.PS)
    ..p/*<String>*/(5, 'fileUris', PbFieldType.PS)
    ..p/*<String>*/(6, 'archiveUris', PbFieldType.PS)
    ..pp/*<PySparkJob_PropertiesEntry>*/(7, 'properties', PbFieldType.PM, PySparkJob_PropertiesEntry.$checkItem, PySparkJob_PropertiesEntry.create)
    ..a/*<LoggingConfig>*/(8, 'loggingConfig', PbFieldType.OM, LoggingConfig.getDefault, LoggingConfig.create)
    ..hasRequiredFields = false
  ;

  PySparkJob() : super();
  PySparkJob.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PySparkJob.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PySparkJob clone() => new PySparkJob()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PySparkJob create() => new PySparkJob();
  static PbList<PySparkJob> createRepeated() => new PbList<PySparkJob>();
  static PySparkJob getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPySparkJob();
    return _defaultInstance;
  }
  static PySparkJob _defaultInstance;
  static void $checkItem(PySparkJob v) {
    if (v is !PySparkJob) checkItemFailed(v, 'PySparkJob');
  }

  String get mainPythonFileUri => $_get(0, 1, '');
  void set mainPythonFileUri(String v) { $_setString(0, 1, v); }
  bool hasMainPythonFileUri() => $_has(0, 1);
  void clearMainPythonFileUri() => clearField(1);

  List<String> get args => $_get(1, 2, null);

  List<String> get pythonFileUris => $_get(2, 3, null);

  List<String> get jarFileUris => $_get(3, 4, null);

  List<String> get fileUris => $_get(4, 5, null);

  List<String> get archiveUris => $_get(5, 6, null);

  List<PySparkJob_PropertiesEntry> get properties => $_get(6, 7, null);

  LoggingConfig get loggingConfig => $_get(7, 8, null);
  void set loggingConfig(LoggingConfig v) { setField(8, v); }
  bool hasLoggingConfig() => $_has(7, 8);
  void clearLoggingConfig() => clearField(8);
}

class _ReadonlyPySparkJob extends PySparkJob with ReadonlyMessageMixin {}

class QueryList extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('QueryList')
    ..p/*<String>*/(1, 'queries', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  QueryList() : super();
  QueryList.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  QueryList.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  QueryList clone() => new QueryList()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static QueryList create() => new QueryList();
  static PbList<QueryList> createRepeated() => new PbList<QueryList>();
  static QueryList getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyQueryList();
    return _defaultInstance;
  }
  static QueryList _defaultInstance;
  static void $checkItem(QueryList v) {
    if (v is !QueryList) checkItemFailed(v, 'QueryList');
  }

  List<String> get queries => $_get(0, 1, null);
}

class _ReadonlyQueryList extends QueryList with ReadonlyMessageMixin {}

class HiveJob_ScriptVariablesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HiveJob_ScriptVariablesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  HiveJob_ScriptVariablesEntry() : super();
  HiveJob_ScriptVariablesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HiveJob_ScriptVariablesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HiveJob_ScriptVariablesEntry clone() => new HiveJob_ScriptVariablesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HiveJob_ScriptVariablesEntry create() => new HiveJob_ScriptVariablesEntry();
  static PbList<HiveJob_ScriptVariablesEntry> createRepeated() => new PbList<HiveJob_ScriptVariablesEntry>();
  static HiveJob_ScriptVariablesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHiveJob_ScriptVariablesEntry();
    return _defaultInstance;
  }
  static HiveJob_ScriptVariablesEntry _defaultInstance;
  static void $checkItem(HiveJob_ScriptVariablesEntry v) {
    if (v is !HiveJob_ScriptVariablesEntry) checkItemFailed(v, 'HiveJob_ScriptVariablesEntry');
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

class _ReadonlyHiveJob_ScriptVariablesEntry extends HiveJob_ScriptVariablesEntry with ReadonlyMessageMixin {}

class HiveJob_PropertiesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HiveJob_PropertiesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  HiveJob_PropertiesEntry() : super();
  HiveJob_PropertiesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HiveJob_PropertiesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HiveJob_PropertiesEntry clone() => new HiveJob_PropertiesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HiveJob_PropertiesEntry create() => new HiveJob_PropertiesEntry();
  static PbList<HiveJob_PropertiesEntry> createRepeated() => new PbList<HiveJob_PropertiesEntry>();
  static HiveJob_PropertiesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHiveJob_PropertiesEntry();
    return _defaultInstance;
  }
  static HiveJob_PropertiesEntry _defaultInstance;
  static void $checkItem(HiveJob_PropertiesEntry v) {
    if (v is !HiveJob_PropertiesEntry) checkItemFailed(v, 'HiveJob_PropertiesEntry');
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

class _ReadonlyHiveJob_PropertiesEntry extends HiveJob_PropertiesEntry with ReadonlyMessageMixin {}

class HiveJob extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HiveJob')
    ..a/*<String>*/(1, 'queryFileUri', PbFieldType.OS)
    ..a/*<QueryList>*/(2, 'queryList', PbFieldType.OM, QueryList.getDefault, QueryList.create)
    ..a/*<bool>*/(3, 'continueOnFailure', PbFieldType.OB)
    ..pp/*<HiveJob_ScriptVariablesEntry>*/(4, 'scriptVariables', PbFieldType.PM, HiveJob_ScriptVariablesEntry.$checkItem, HiveJob_ScriptVariablesEntry.create)
    ..pp/*<HiveJob_PropertiesEntry>*/(5, 'properties', PbFieldType.PM, HiveJob_PropertiesEntry.$checkItem, HiveJob_PropertiesEntry.create)
    ..p/*<String>*/(6, 'jarFileUris', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  HiveJob() : super();
  HiveJob.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HiveJob.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HiveJob clone() => new HiveJob()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HiveJob create() => new HiveJob();
  static PbList<HiveJob> createRepeated() => new PbList<HiveJob>();
  static HiveJob getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHiveJob();
    return _defaultInstance;
  }
  static HiveJob _defaultInstance;
  static void $checkItem(HiveJob v) {
    if (v is !HiveJob) checkItemFailed(v, 'HiveJob');
  }

  String get queryFileUri => $_get(0, 1, '');
  void set queryFileUri(String v) { $_setString(0, 1, v); }
  bool hasQueryFileUri() => $_has(0, 1);
  void clearQueryFileUri() => clearField(1);

  QueryList get queryList => $_get(1, 2, null);
  void set queryList(QueryList v) { setField(2, v); }
  bool hasQueryList() => $_has(1, 2);
  void clearQueryList() => clearField(2);

  bool get continueOnFailure => $_get(2, 3, false);
  void set continueOnFailure(bool v) { $_setBool(2, 3, v); }
  bool hasContinueOnFailure() => $_has(2, 3);
  void clearContinueOnFailure() => clearField(3);

  List<HiveJob_ScriptVariablesEntry> get scriptVariables => $_get(3, 4, null);

  List<HiveJob_PropertiesEntry> get properties => $_get(4, 5, null);

  List<String> get jarFileUris => $_get(5, 6, null);
}

class _ReadonlyHiveJob extends HiveJob with ReadonlyMessageMixin {}

class SparkSqlJob_ScriptVariablesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SparkSqlJob_ScriptVariablesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SparkSqlJob_ScriptVariablesEntry() : super();
  SparkSqlJob_ScriptVariablesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SparkSqlJob_ScriptVariablesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SparkSqlJob_ScriptVariablesEntry clone() => new SparkSqlJob_ScriptVariablesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SparkSqlJob_ScriptVariablesEntry create() => new SparkSqlJob_ScriptVariablesEntry();
  static PbList<SparkSqlJob_ScriptVariablesEntry> createRepeated() => new PbList<SparkSqlJob_ScriptVariablesEntry>();
  static SparkSqlJob_ScriptVariablesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySparkSqlJob_ScriptVariablesEntry();
    return _defaultInstance;
  }
  static SparkSqlJob_ScriptVariablesEntry _defaultInstance;
  static void $checkItem(SparkSqlJob_ScriptVariablesEntry v) {
    if (v is !SparkSqlJob_ScriptVariablesEntry) checkItemFailed(v, 'SparkSqlJob_ScriptVariablesEntry');
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

class _ReadonlySparkSqlJob_ScriptVariablesEntry extends SparkSqlJob_ScriptVariablesEntry with ReadonlyMessageMixin {}

class SparkSqlJob_PropertiesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SparkSqlJob_PropertiesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SparkSqlJob_PropertiesEntry() : super();
  SparkSqlJob_PropertiesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SparkSqlJob_PropertiesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SparkSqlJob_PropertiesEntry clone() => new SparkSqlJob_PropertiesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SparkSqlJob_PropertiesEntry create() => new SparkSqlJob_PropertiesEntry();
  static PbList<SparkSqlJob_PropertiesEntry> createRepeated() => new PbList<SparkSqlJob_PropertiesEntry>();
  static SparkSqlJob_PropertiesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySparkSqlJob_PropertiesEntry();
    return _defaultInstance;
  }
  static SparkSqlJob_PropertiesEntry _defaultInstance;
  static void $checkItem(SparkSqlJob_PropertiesEntry v) {
    if (v is !SparkSqlJob_PropertiesEntry) checkItemFailed(v, 'SparkSqlJob_PropertiesEntry');
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

class _ReadonlySparkSqlJob_PropertiesEntry extends SparkSqlJob_PropertiesEntry with ReadonlyMessageMixin {}

class SparkSqlJob extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SparkSqlJob')
    ..a/*<String>*/(1, 'queryFileUri', PbFieldType.OS)
    ..a/*<QueryList>*/(2, 'queryList', PbFieldType.OM, QueryList.getDefault, QueryList.create)
    ..pp/*<SparkSqlJob_ScriptVariablesEntry>*/(3, 'scriptVariables', PbFieldType.PM, SparkSqlJob_ScriptVariablesEntry.$checkItem, SparkSqlJob_ScriptVariablesEntry.create)
    ..pp/*<SparkSqlJob_PropertiesEntry>*/(4, 'properties', PbFieldType.PM, SparkSqlJob_PropertiesEntry.$checkItem, SparkSqlJob_PropertiesEntry.create)
    ..a/*<LoggingConfig>*/(6, 'loggingConfig', PbFieldType.OM, LoggingConfig.getDefault, LoggingConfig.create)
    ..p/*<String>*/(56, 'jarFileUris', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  SparkSqlJob() : super();
  SparkSqlJob.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SparkSqlJob.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SparkSqlJob clone() => new SparkSqlJob()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SparkSqlJob create() => new SparkSqlJob();
  static PbList<SparkSqlJob> createRepeated() => new PbList<SparkSqlJob>();
  static SparkSqlJob getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySparkSqlJob();
    return _defaultInstance;
  }
  static SparkSqlJob _defaultInstance;
  static void $checkItem(SparkSqlJob v) {
    if (v is !SparkSqlJob) checkItemFailed(v, 'SparkSqlJob');
  }

  String get queryFileUri => $_get(0, 1, '');
  void set queryFileUri(String v) { $_setString(0, 1, v); }
  bool hasQueryFileUri() => $_has(0, 1);
  void clearQueryFileUri() => clearField(1);

  QueryList get queryList => $_get(1, 2, null);
  void set queryList(QueryList v) { setField(2, v); }
  bool hasQueryList() => $_has(1, 2);
  void clearQueryList() => clearField(2);

  List<SparkSqlJob_ScriptVariablesEntry> get scriptVariables => $_get(2, 3, null);

  List<SparkSqlJob_PropertiesEntry> get properties => $_get(3, 4, null);

  LoggingConfig get loggingConfig => $_get(4, 6, null);
  void set loggingConfig(LoggingConfig v) { setField(6, v); }
  bool hasLoggingConfig() => $_has(4, 6);
  void clearLoggingConfig() => clearField(6);

  List<String> get jarFileUris => $_get(5, 56, null);
}

class _ReadonlySparkSqlJob extends SparkSqlJob with ReadonlyMessageMixin {}

class PigJob_ScriptVariablesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PigJob_ScriptVariablesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  PigJob_ScriptVariablesEntry() : super();
  PigJob_ScriptVariablesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PigJob_ScriptVariablesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PigJob_ScriptVariablesEntry clone() => new PigJob_ScriptVariablesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PigJob_ScriptVariablesEntry create() => new PigJob_ScriptVariablesEntry();
  static PbList<PigJob_ScriptVariablesEntry> createRepeated() => new PbList<PigJob_ScriptVariablesEntry>();
  static PigJob_ScriptVariablesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPigJob_ScriptVariablesEntry();
    return _defaultInstance;
  }
  static PigJob_ScriptVariablesEntry _defaultInstance;
  static void $checkItem(PigJob_ScriptVariablesEntry v) {
    if (v is !PigJob_ScriptVariablesEntry) checkItemFailed(v, 'PigJob_ScriptVariablesEntry');
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

class _ReadonlyPigJob_ScriptVariablesEntry extends PigJob_ScriptVariablesEntry with ReadonlyMessageMixin {}

class PigJob_PropertiesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PigJob_PropertiesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  PigJob_PropertiesEntry() : super();
  PigJob_PropertiesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PigJob_PropertiesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PigJob_PropertiesEntry clone() => new PigJob_PropertiesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PigJob_PropertiesEntry create() => new PigJob_PropertiesEntry();
  static PbList<PigJob_PropertiesEntry> createRepeated() => new PbList<PigJob_PropertiesEntry>();
  static PigJob_PropertiesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPigJob_PropertiesEntry();
    return _defaultInstance;
  }
  static PigJob_PropertiesEntry _defaultInstance;
  static void $checkItem(PigJob_PropertiesEntry v) {
    if (v is !PigJob_PropertiesEntry) checkItemFailed(v, 'PigJob_PropertiesEntry');
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

class _ReadonlyPigJob_PropertiesEntry extends PigJob_PropertiesEntry with ReadonlyMessageMixin {}

class PigJob extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PigJob')
    ..a/*<String>*/(1, 'queryFileUri', PbFieldType.OS)
    ..a/*<QueryList>*/(2, 'queryList', PbFieldType.OM, QueryList.getDefault, QueryList.create)
    ..a/*<bool>*/(3, 'continueOnFailure', PbFieldType.OB)
    ..pp/*<PigJob_ScriptVariablesEntry>*/(4, 'scriptVariables', PbFieldType.PM, PigJob_ScriptVariablesEntry.$checkItem, PigJob_ScriptVariablesEntry.create)
    ..pp/*<PigJob_PropertiesEntry>*/(5, 'properties', PbFieldType.PM, PigJob_PropertiesEntry.$checkItem, PigJob_PropertiesEntry.create)
    ..p/*<String>*/(6, 'jarFileUris', PbFieldType.PS)
    ..a/*<LoggingConfig>*/(7, 'loggingConfig', PbFieldType.OM, LoggingConfig.getDefault, LoggingConfig.create)
    ..hasRequiredFields = false
  ;

  PigJob() : super();
  PigJob.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PigJob.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PigJob clone() => new PigJob()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PigJob create() => new PigJob();
  static PbList<PigJob> createRepeated() => new PbList<PigJob>();
  static PigJob getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPigJob();
    return _defaultInstance;
  }
  static PigJob _defaultInstance;
  static void $checkItem(PigJob v) {
    if (v is !PigJob) checkItemFailed(v, 'PigJob');
  }

  String get queryFileUri => $_get(0, 1, '');
  void set queryFileUri(String v) { $_setString(0, 1, v); }
  bool hasQueryFileUri() => $_has(0, 1);
  void clearQueryFileUri() => clearField(1);

  QueryList get queryList => $_get(1, 2, null);
  void set queryList(QueryList v) { setField(2, v); }
  bool hasQueryList() => $_has(1, 2);
  void clearQueryList() => clearField(2);

  bool get continueOnFailure => $_get(2, 3, false);
  void set continueOnFailure(bool v) { $_setBool(2, 3, v); }
  bool hasContinueOnFailure() => $_has(2, 3);
  void clearContinueOnFailure() => clearField(3);

  List<PigJob_ScriptVariablesEntry> get scriptVariables => $_get(3, 4, null);

  List<PigJob_PropertiesEntry> get properties => $_get(4, 5, null);

  List<String> get jarFileUris => $_get(5, 6, null);

  LoggingConfig get loggingConfig => $_get(6, 7, null);
  void set loggingConfig(LoggingConfig v) { setField(7, v); }
  bool hasLoggingConfig() => $_has(6, 7);
  void clearLoggingConfig() => clearField(7);
}

class _ReadonlyPigJob extends PigJob with ReadonlyMessageMixin {}

class JobPlacement extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('JobPlacement')
    ..a/*<String>*/(1, 'clusterName', PbFieldType.OS)
    ..a/*<String>*/(2, 'clusterUuid', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  JobPlacement() : super();
  JobPlacement.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  JobPlacement.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  JobPlacement clone() => new JobPlacement()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static JobPlacement create() => new JobPlacement();
  static PbList<JobPlacement> createRepeated() => new PbList<JobPlacement>();
  static JobPlacement getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyJobPlacement();
    return _defaultInstance;
  }
  static JobPlacement _defaultInstance;
  static void $checkItem(JobPlacement v) {
    if (v is !JobPlacement) checkItemFailed(v, 'JobPlacement');
  }

  String get clusterName => $_get(0, 1, '');
  void set clusterName(String v) { $_setString(0, 1, v); }
  bool hasClusterName() => $_has(0, 1);
  void clearClusterName() => clearField(1);

  String get clusterUuid => $_get(1, 2, '');
  void set clusterUuid(String v) { $_setString(1, 2, v); }
  bool hasClusterUuid() => $_has(1, 2);
  void clearClusterUuid() => clearField(2);
}

class _ReadonlyJobPlacement extends JobPlacement with ReadonlyMessageMixin {}

class JobStatus extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('JobStatus')
    ..e/*<JobStatus_State>*/(1, 'state', PbFieldType.OE, JobStatus_State.STATE_UNSPECIFIED, JobStatus_State.valueOf)
    ..a/*<String>*/(2, 'details', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(6, 'stateStartTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  JobStatus() : super();
  JobStatus.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  JobStatus.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  JobStatus clone() => new JobStatus()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static JobStatus create() => new JobStatus();
  static PbList<JobStatus> createRepeated() => new PbList<JobStatus>();
  static JobStatus getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyJobStatus();
    return _defaultInstance;
  }
  static JobStatus _defaultInstance;
  static void $checkItem(JobStatus v) {
    if (v is !JobStatus) checkItemFailed(v, 'JobStatus');
  }

  JobStatus_State get state => $_get(0, 1, null);
  void set state(JobStatus_State v) { setField(1, v); }
  bool hasState() => $_has(0, 1);
  void clearState() => clearField(1);

  String get details => $_get(1, 2, '');
  void set details(String v) { $_setString(1, 2, v); }
  bool hasDetails() => $_has(1, 2);
  void clearDetails() => clearField(2);

  google$protobuf.Timestamp get stateStartTime => $_get(2, 6, null);
  void set stateStartTime(google$protobuf.Timestamp v) { setField(6, v); }
  bool hasStateStartTime() => $_has(2, 6);
  void clearStateStartTime() => clearField(6);
}

class _ReadonlyJobStatus extends JobStatus with ReadonlyMessageMixin {}

class JobReference extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('JobReference')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'jobId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  JobReference() : super();
  JobReference.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  JobReference.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  JobReference clone() => new JobReference()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static JobReference create() => new JobReference();
  static PbList<JobReference> createRepeated() => new PbList<JobReference>();
  static JobReference getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyJobReference();
    return _defaultInstance;
  }
  static JobReference _defaultInstance;
  static void $checkItem(JobReference v) {
    if (v is !JobReference) checkItemFailed(v, 'JobReference');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get jobId => $_get(1, 2, '');
  void set jobId(String v) { $_setString(1, 2, v); }
  bool hasJobId() => $_has(1, 2);
  void clearJobId() => clearField(2);
}

class _ReadonlyJobReference extends JobReference with ReadonlyMessageMixin {}

class Job extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Job')
    ..a/*<JobReference>*/(1, 'reference', PbFieldType.OM, JobReference.getDefault, JobReference.create)
    ..a/*<JobPlacement>*/(2, 'placement', PbFieldType.OM, JobPlacement.getDefault, JobPlacement.create)
    ..a/*<HadoopJob>*/(3, 'hadoopJob', PbFieldType.OM, HadoopJob.getDefault, HadoopJob.create)
    ..a/*<SparkJob>*/(4, 'sparkJob', PbFieldType.OM, SparkJob.getDefault, SparkJob.create)
    ..a/*<PySparkJob>*/(5, 'pysparkJob', PbFieldType.OM, PySparkJob.getDefault, PySparkJob.create)
    ..a/*<HiveJob>*/(6, 'hiveJob', PbFieldType.OM, HiveJob.getDefault, HiveJob.create)
    ..a/*<PigJob>*/(7, 'pigJob', PbFieldType.OM, PigJob.getDefault, PigJob.create)
    ..a/*<JobStatus>*/(8, 'status', PbFieldType.OM, JobStatus.getDefault, JobStatus.create)
    ..a/*<SparkSqlJob>*/(12, 'sparkSqlJob', PbFieldType.OM, SparkSqlJob.getDefault, SparkSqlJob.create)
    ..pp/*<JobStatus>*/(13, 'statusHistory', PbFieldType.PM, JobStatus.$checkItem, JobStatus.create)
    ..a/*<String>*/(15, 'driverControlFilesUri', PbFieldType.OS)
    ..a/*<String>*/(17, 'driverOutputResourceUri', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Job() : super();
  Job.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Job.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Job clone() => new Job()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Job create() => new Job();
  static PbList<Job> createRepeated() => new PbList<Job>();
  static Job getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyJob();
    return _defaultInstance;
  }
  static Job _defaultInstance;
  static void $checkItem(Job v) {
    if (v is !Job) checkItemFailed(v, 'Job');
  }

  JobReference get reference => $_get(0, 1, null);
  void set reference(JobReference v) { setField(1, v); }
  bool hasReference() => $_has(0, 1);
  void clearReference() => clearField(1);

  JobPlacement get placement => $_get(1, 2, null);
  void set placement(JobPlacement v) { setField(2, v); }
  bool hasPlacement() => $_has(1, 2);
  void clearPlacement() => clearField(2);

  HadoopJob get hadoopJob => $_get(2, 3, null);
  void set hadoopJob(HadoopJob v) { setField(3, v); }
  bool hasHadoopJob() => $_has(2, 3);
  void clearHadoopJob() => clearField(3);

  SparkJob get sparkJob => $_get(3, 4, null);
  void set sparkJob(SparkJob v) { setField(4, v); }
  bool hasSparkJob() => $_has(3, 4);
  void clearSparkJob() => clearField(4);

  PySparkJob get pysparkJob => $_get(4, 5, null);
  void set pysparkJob(PySparkJob v) { setField(5, v); }
  bool hasPysparkJob() => $_has(4, 5);
  void clearPysparkJob() => clearField(5);

  HiveJob get hiveJob => $_get(5, 6, null);
  void set hiveJob(HiveJob v) { setField(6, v); }
  bool hasHiveJob() => $_has(5, 6);
  void clearHiveJob() => clearField(6);

  PigJob get pigJob => $_get(6, 7, null);
  void set pigJob(PigJob v) { setField(7, v); }
  bool hasPigJob() => $_has(6, 7);
  void clearPigJob() => clearField(7);

  JobStatus get status => $_get(7, 8, null);
  void set status(JobStatus v) { setField(8, v); }
  bool hasStatus() => $_has(7, 8);
  void clearStatus() => clearField(8);

  SparkSqlJob get sparkSqlJob => $_get(8, 12, null);
  void set sparkSqlJob(SparkSqlJob v) { setField(12, v); }
  bool hasSparkSqlJob() => $_has(8, 12);
  void clearSparkSqlJob() => clearField(12);

  List<JobStatus> get statusHistory => $_get(9, 13, null);

  String get driverControlFilesUri => $_get(10, 15, '');
  void set driverControlFilesUri(String v) { $_setString(10, 15, v); }
  bool hasDriverControlFilesUri() => $_has(10, 15);
  void clearDriverControlFilesUri() => clearField(15);

  String get driverOutputResourceUri => $_get(11, 17, '');
  void set driverOutputResourceUri(String v) { $_setString(11, 17, v); }
  bool hasDriverOutputResourceUri() => $_has(11, 17);
  void clearDriverOutputResourceUri() => clearField(17);
}

class _ReadonlyJob extends Job with ReadonlyMessageMixin {}

class SubmitJobRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SubmitJobRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<Job>*/(2, 'job', PbFieldType.OM, Job.getDefault, Job.create)
    ..a/*<String>*/(3, 'region', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SubmitJobRequest() : super();
  SubmitJobRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SubmitJobRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SubmitJobRequest clone() => new SubmitJobRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SubmitJobRequest create() => new SubmitJobRequest();
  static PbList<SubmitJobRequest> createRepeated() => new PbList<SubmitJobRequest>();
  static SubmitJobRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySubmitJobRequest();
    return _defaultInstance;
  }
  static SubmitJobRequest _defaultInstance;
  static void $checkItem(SubmitJobRequest v) {
    if (v is !SubmitJobRequest) checkItemFailed(v, 'SubmitJobRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  Job get job => $_get(1, 2, null);
  void set job(Job v) { setField(2, v); }
  bool hasJob() => $_has(1, 2);
  void clearJob() => clearField(2);

  String get region => $_get(2, 3, '');
  void set region(String v) { $_setString(2, 3, v); }
  bool hasRegion() => $_has(2, 3);
  void clearRegion() => clearField(3);
}

class _ReadonlySubmitJobRequest extends SubmitJobRequest with ReadonlyMessageMixin {}

class GetJobRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetJobRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'jobId', PbFieldType.OS)
    ..a/*<String>*/(3, 'region', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetJobRequest() : super();
  GetJobRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetJobRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetJobRequest clone() => new GetJobRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetJobRequest create() => new GetJobRequest();
  static PbList<GetJobRequest> createRepeated() => new PbList<GetJobRequest>();
  static GetJobRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetJobRequest();
    return _defaultInstance;
  }
  static GetJobRequest _defaultInstance;
  static void $checkItem(GetJobRequest v) {
    if (v is !GetJobRequest) checkItemFailed(v, 'GetJobRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get jobId => $_get(1, 2, '');
  void set jobId(String v) { $_setString(1, 2, v); }
  bool hasJobId() => $_has(1, 2);
  void clearJobId() => clearField(2);

  String get region => $_get(2, 3, '');
  void set region(String v) { $_setString(2, 3, v); }
  bool hasRegion() => $_has(2, 3);
  void clearRegion() => clearField(3);
}

class _ReadonlyGetJobRequest extends GetJobRequest with ReadonlyMessageMixin {}

class ListJobsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListJobsRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<int>*/(2, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..a/*<String>*/(4, 'clusterName', PbFieldType.OS)
    ..e/*<ListJobsRequest_JobStateMatcher>*/(5, 'jobStateMatcher', PbFieldType.OE, ListJobsRequest_JobStateMatcher.ALL, ListJobsRequest_JobStateMatcher.valueOf)
    ..a/*<String>*/(6, 'region', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListJobsRequest() : super();
  ListJobsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListJobsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListJobsRequest clone() => new ListJobsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListJobsRequest create() => new ListJobsRequest();
  static PbList<ListJobsRequest> createRepeated() => new PbList<ListJobsRequest>();
  static ListJobsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListJobsRequest();
    return _defaultInstance;
  }
  static ListJobsRequest _defaultInstance;
  static void $checkItem(ListJobsRequest v) {
    if (v is !ListJobsRequest) checkItemFailed(v, 'ListJobsRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  int get pageSize => $_get(1, 2, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasPageSize() => $_has(1, 2);
  void clearPageSize() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);

  String get clusterName => $_get(3, 4, '');
  void set clusterName(String v) { $_setString(3, 4, v); }
  bool hasClusterName() => $_has(3, 4);
  void clearClusterName() => clearField(4);

  ListJobsRequest_JobStateMatcher get jobStateMatcher => $_get(4, 5, null);
  void set jobStateMatcher(ListJobsRequest_JobStateMatcher v) { setField(5, v); }
  bool hasJobStateMatcher() => $_has(4, 5);
  void clearJobStateMatcher() => clearField(5);

  String get region => $_get(5, 6, '');
  void set region(String v) { $_setString(5, 6, v); }
  bool hasRegion() => $_has(5, 6);
  void clearRegion() => clearField(6);
}

class _ReadonlyListJobsRequest extends ListJobsRequest with ReadonlyMessageMixin {}

class ListJobsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListJobsResponse')
    ..pp/*<Job>*/(1, 'jobs', PbFieldType.PM, Job.$checkItem, Job.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListJobsResponse() : super();
  ListJobsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListJobsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListJobsResponse clone() => new ListJobsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListJobsResponse create() => new ListJobsResponse();
  static PbList<ListJobsResponse> createRepeated() => new PbList<ListJobsResponse>();
  static ListJobsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListJobsResponse();
    return _defaultInstance;
  }
  static ListJobsResponse _defaultInstance;
  static void $checkItem(ListJobsResponse v) {
    if (v is !ListJobsResponse) checkItemFailed(v, 'ListJobsResponse');
  }

  List<Job> get jobs => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListJobsResponse extends ListJobsResponse with ReadonlyMessageMixin {}

class CancelJobRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CancelJobRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'jobId', PbFieldType.OS)
    ..a/*<String>*/(3, 'region', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CancelJobRequest() : super();
  CancelJobRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CancelJobRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CancelJobRequest clone() => new CancelJobRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CancelJobRequest create() => new CancelJobRequest();
  static PbList<CancelJobRequest> createRepeated() => new PbList<CancelJobRequest>();
  static CancelJobRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCancelJobRequest();
    return _defaultInstance;
  }
  static CancelJobRequest _defaultInstance;
  static void $checkItem(CancelJobRequest v) {
    if (v is !CancelJobRequest) checkItemFailed(v, 'CancelJobRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get jobId => $_get(1, 2, '');
  void set jobId(String v) { $_setString(1, 2, v); }
  bool hasJobId() => $_has(1, 2);
  void clearJobId() => clearField(2);

  String get region => $_get(2, 3, '');
  void set region(String v) { $_setString(2, 3, v); }
  bool hasRegion() => $_has(2, 3);
  void clearRegion() => clearField(3);
}

class _ReadonlyCancelJobRequest extends CancelJobRequest with ReadonlyMessageMixin {}

class DeleteJobRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteJobRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'jobId', PbFieldType.OS)
    ..a/*<String>*/(3, 'region', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteJobRequest() : super();
  DeleteJobRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteJobRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteJobRequest clone() => new DeleteJobRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteJobRequest create() => new DeleteJobRequest();
  static PbList<DeleteJobRequest> createRepeated() => new PbList<DeleteJobRequest>();
  static DeleteJobRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteJobRequest();
    return _defaultInstance;
  }
  static DeleteJobRequest _defaultInstance;
  static void $checkItem(DeleteJobRequest v) {
    if (v is !DeleteJobRequest) checkItemFailed(v, 'DeleteJobRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get jobId => $_get(1, 2, '');
  void set jobId(String v) { $_setString(1, 2, v); }
  bool hasJobId() => $_has(1, 2);
  void clearJobId() => clearField(2);

  String get region => $_get(2, 3, '');
  void set region(String v) { $_setString(2, 3, v); }
  bool hasRegion() => $_has(2, 3);
  void clearRegion() => clearField(3);
}

class _ReadonlyDeleteJobRequest extends DeleteJobRequest with ReadonlyMessageMixin {}

class JobControllerApi {
  RpcClient _client;
  JobControllerApi(this._client);

  Future<Job> submitJob(ClientContext ctx, SubmitJobRequest request) {
    var emptyResponse = new Job();
    return _client.invoke(ctx, 'JobController', 'SubmitJob', request, emptyResponse);
  }
  Future<Job> getJob(ClientContext ctx, GetJobRequest request) {
    var emptyResponse = new Job();
    return _client.invoke(ctx, 'JobController', 'GetJob', request, emptyResponse);
  }
  Future<ListJobsResponse> listJobs(ClientContext ctx, ListJobsRequest request) {
    var emptyResponse = new ListJobsResponse();
    return _client.invoke(ctx, 'JobController', 'ListJobs', request, emptyResponse);
  }
  Future<Job> cancelJob(ClientContext ctx, CancelJobRequest request) {
    var emptyResponse = new Job();
    return _client.invoke(ctx, 'JobController', 'CancelJob', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteJob(ClientContext ctx, DeleteJobRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'JobController', 'DeleteJob', request, emptyResponse);
  }
}

