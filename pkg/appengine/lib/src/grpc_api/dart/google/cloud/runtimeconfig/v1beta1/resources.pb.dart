///
//  Generated code. Do not modify.
///
library google.cloud.runtimeconfig.v1beta1_resources;

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../../protobuf/duration.pb.dart' as google$protobuf;
import '../../../rpc/status.pb.dart' as google$rpc;

import 'resources.pbenum.dart';

export 'resources.pbenum.dart';

class RuntimeConfig extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RuntimeConfig')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'description', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  RuntimeConfig() : super();
  RuntimeConfig.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RuntimeConfig.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RuntimeConfig clone() => new RuntimeConfig()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RuntimeConfig create() => new RuntimeConfig();
  static PbList<RuntimeConfig> createRepeated() => new PbList<RuntimeConfig>();
  static RuntimeConfig getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRuntimeConfig();
    return _defaultInstance;
  }
  static RuntimeConfig _defaultInstance;
  static void $checkItem(RuntimeConfig v) {
    if (v is !RuntimeConfig) checkItemFailed(v, 'RuntimeConfig');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get description => $_get(1, 2, '');
  void set description(String v) { $_setString(1, 2, v); }
  bool hasDescription() => $_has(1, 2);
  void clearDescription() => clearField(2);
}

class _ReadonlyRuntimeConfig extends RuntimeConfig with ReadonlyMessageMixin {}

class Variable extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Variable')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'value', PbFieldType.OY)
    ..a/*<google$protobuf.Timestamp>*/(3, 'updateTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..e/*<VariableState>*/(4, 'state', PbFieldType.OE, VariableState.VARIABLE_STATE_UNSPECIFIED, VariableState.valueOf)
    ..a/*<String>*/(5, 'text', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Variable() : super();
  Variable.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Variable.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Variable clone() => new Variable()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Variable create() => new Variable();
  static PbList<Variable> createRepeated() => new PbList<Variable>();
  static Variable getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyVariable();
    return _defaultInstance;
  }
  static Variable _defaultInstance;
  static void $checkItem(Variable v) {
    if (v is !Variable) checkItemFailed(v, 'Variable');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  List<int> get value => $_get(1, 2, null);
  void set value(List<int> v) { $_setBytes(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);

  google$protobuf.Timestamp get updateTime => $_get(2, 3, null);
  void set updateTime(google$protobuf.Timestamp v) { setField(3, v); }
  bool hasUpdateTime() => $_has(2, 3);
  void clearUpdateTime() => clearField(3);

  VariableState get state => $_get(3, 4, null);
  void set state(VariableState v) { setField(4, v); }
  bool hasState() => $_has(3, 4);
  void clearState() => clearField(4);

  String get text => $_get(4, 5, '');
  void set text(String v) { $_setString(4, 5, v); }
  bool hasText() => $_has(4, 5);
  void clearText() => clearField(5);
}

class _ReadonlyVariable extends Variable with ReadonlyMessageMixin {}

class EndCondition_Cardinality extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('EndCondition_Cardinality')
    ..a/*<String>*/(1, 'path', PbFieldType.OS)
    ..a/*<int>*/(2, 'number', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  EndCondition_Cardinality() : super();
  EndCondition_Cardinality.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EndCondition_Cardinality.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EndCondition_Cardinality clone() => new EndCondition_Cardinality()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static EndCondition_Cardinality create() => new EndCondition_Cardinality();
  static PbList<EndCondition_Cardinality> createRepeated() => new PbList<EndCondition_Cardinality>();
  static EndCondition_Cardinality getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEndCondition_Cardinality();
    return _defaultInstance;
  }
  static EndCondition_Cardinality _defaultInstance;
  static void $checkItem(EndCondition_Cardinality v) {
    if (v is !EndCondition_Cardinality) checkItemFailed(v, 'EndCondition_Cardinality');
  }

  String get path => $_get(0, 1, '');
  void set path(String v) { $_setString(0, 1, v); }
  bool hasPath() => $_has(0, 1);
  void clearPath() => clearField(1);

  int get number => $_get(1, 2, 0);
  void set number(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasNumber() => $_has(1, 2);
  void clearNumber() => clearField(2);
}

class _ReadonlyEndCondition_Cardinality extends EndCondition_Cardinality with ReadonlyMessageMixin {}

class EndCondition extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('EndCondition')
    ..a/*<EndCondition_Cardinality>*/(1, 'cardinality', PbFieldType.OM, EndCondition_Cardinality.getDefault, EndCondition_Cardinality.create)
    ..hasRequiredFields = false
  ;

  EndCondition() : super();
  EndCondition.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EndCondition.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EndCondition clone() => new EndCondition()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static EndCondition create() => new EndCondition();
  static PbList<EndCondition> createRepeated() => new PbList<EndCondition>();
  static EndCondition getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEndCondition();
    return _defaultInstance;
  }
  static EndCondition _defaultInstance;
  static void $checkItem(EndCondition v) {
    if (v is !EndCondition) checkItemFailed(v, 'EndCondition');
  }

  EndCondition_Cardinality get cardinality => $_get(0, 1, null);
  void set cardinality(EndCondition_Cardinality v) { setField(1, v); }
  bool hasCardinality() => $_has(0, 1);
  void clearCardinality() => clearField(1);
}

class _ReadonlyEndCondition extends EndCondition with ReadonlyMessageMixin {}

class Waiter extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Waiter')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<google$protobuf.Duration>*/(2, 'timeout', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<EndCondition>*/(3, 'failure', PbFieldType.OM, EndCondition.getDefault, EndCondition.create)
    ..a/*<EndCondition>*/(4, 'success', PbFieldType.OM, EndCondition.getDefault, EndCondition.create)
    ..a/*<google$protobuf.Timestamp>*/(5, 'createTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<bool>*/(6, 'done', PbFieldType.OB)
    ..a/*<google$rpc.Status>*/(7, 'error', PbFieldType.OM, google$rpc.Status.getDefault, google$rpc.Status.create)
    ..hasRequiredFields = false
  ;

  Waiter() : super();
  Waiter.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Waiter.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Waiter clone() => new Waiter()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Waiter create() => new Waiter();
  static PbList<Waiter> createRepeated() => new PbList<Waiter>();
  static Waiter getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyWaiter();
    return _defaultInstance;
  }
  static Waiter _defaultInstance;
  static void $checkItem(Waiter v) {
    if (v is !Waiter) checkItemFailed(v, 'Waiter');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  google$protobuf.Duration get timeout => $_get(1, 2, null);
  void set timeout(google$protobuf.Duration v) { setField(2, v); }
  bool hasTimeout() => $_has(1, 2);
  void clearTimeout() => clearField(2);

  EndCondition get failure => $_get(2, 3, null);
  void set failure(EndCondition v) { setField(3, v); }
  bool hasFailure() => $_has(2, 3);
  void clearFailure() => clearField(3);

  EndCondition get success => $_get(3, 4, null);
  void set success(EndCondition v) { setField(4, v); }
  bool hasSuccess() => $_has(3, 4);
  void clearSuccess() => clearField(4);

  google$protobuf.Timestamp get createTime => $_get(4, 5, null);
  void set createTime(google$protobuf.Timestamp v) { setField(5, v); }
  bool hasCreateTime() => $_has(4, 5);
  void clearCreateTime() => clearField(5);

  bool get done => $_get(5, 6, false);
  void set done(bool v) { $_setBool(5, 6, v); }
  bool hasDone() => $_has(5, 6);
  void clearDone() => clearField(6);

  google$rpc.Status get error => $_get(6, 7, null);
  void set error(google$rpc.Status v) { setField(7, v); }
  bool hasError() => $_has(6, 7);
  void clearError() => clearField(7);
}

class _ReadonlyWaiter extends Waiter with ReadonlyMessageMixin {}

