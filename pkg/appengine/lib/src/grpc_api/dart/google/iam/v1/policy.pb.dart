///
//  Generated code. Do not modify.
///
library google.iam.v1_policy;

import 'package:protobuf/protobuf.dart';

import 'policy.pbenum.dart';

export 'policy.pbenum.dart';

class Policy extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Policy')
    ..a/*<int>*/(1, 'version', PbFieldType.O3)
    ..a/*<List<int>>*/(3, 'etag', PbFieldType.OY)
    ..pp/*<Binding>*/(4, 'bindings', PbFieldType.PM, Binding.$checkItem, Binding.create)
    ..hasRequiredFields = false
  ;

  Policy() : super();
  Policy.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Policy.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Policy clone() => new Policy()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Policy create() => new Policy();
  static PbList<Policy> createRepeated() => new PbList<Policy>();
  static Policy getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPolicy();
    return _defaultInstance;
  }
  static Policy _defaultInstance;
  static void $checkItem(Policy v) {
    if (v is !Policy) checkItemFailed(v, 'Policy');
  }

  int get version => $_get(0, 1, 0);
  void set version(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasVersion() => $_has(0, 1);
  void clearVersion() => clearField(1);

  List<int> get etag => $_get(1, 3, null);
  void set etag(List<int> v) { $_setBytes(1, 3, v); }
  bool hasEtag() => $_has(1, 3);
  void clearEtag() => clearField(3);

  List<Binding> get bindings => $_get(2, 4, null);
}

class _ReadonlyPolicy extends Policy with ReadonlyMessageMixin {}

class Binding extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Binding')
    ..a/*<String>*/(1, 'role', PbFieldType.OS)
    ..p/*<String>*/(2, 'members', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  Binding() : super();
  Binding.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Binding.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Binding clone() => new Binding()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Binding create() => new Binding();
  static PbList<Binding> createRepeated() => new PbList<Binding>();
  static Binding getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBinding();
    return _defaultInstance;
  }
  static Binding _defaultInstance;
  static void $checkItem(Binding v) {
    if (v is !Binding) checkItemFailed(v, 'Binding');
  }

  String get role => $_get(0, 1, '');
  void set role(String v) { $_setString(0, 1, v); }
  bool hasRole() => $_has(0, 1);
  void clearRole() => clearField(1);

  List<String> get members => $_get(1, 2, null);
}

class _ReadonlyBinding extends Binding with ReadonlyMessageMixin {}

class PolicyDelta extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PolicyDelta')
    ..pp/*<BindingDelta>*/(1, 'bindingDeltas', PbFieldType.PM, BindingDelta.$checkItem, BindingDelta.create)
    ..hasRequiredFields = false
  ;

  PolicyDelta() : super();
  PolicyDelta.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PolicyDelta.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PolicyDelta clone() => new PolicyDelta()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PolicyDelta create() => new PolicyDelta();
  static PbList<PolicyDelta> createRepeated() => new PbList<PolicyDelta>();
  static PolicyDelta getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPolicyDelta();
    return _defaultInstance;
  }
  static PolicyDelta _defaultInstance;
  static void $checkItem(PolicyDelta v) {
    if (v is !PolicyDelta) checkItemFailed(v, 'PolicyDelta');
  }

  List<BindingDelta> get bindingDeltas => $_get(0, 1, null);
}

class _ReadonlyPolicyDelta extends PolicyDelta with ReadonlyMessageMixin {}

class BindingDelta extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BindingDelta')
    ..e/*<BindingDelta_Action>*/(1, 'action', PbFieldType.OE, BindingDelta_Action.ACTION_UNSPECIFIED, BindingDelta_Action.valueOf)
    ..a/*<String>*/(2, 'role', PbFieldType.OS)
    ..a/*<String>*/(3, 'member', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  BindingDelta() : super();
  BindingDelta.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BindingDelta.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BindingDelta clone() => new BindingDelta()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BindingDelta create() => new BindingDelta();
  static PbList<BindingDelta> createRepeated() => new PbList<BindingDelta>();
  static BindingDelta getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBindingDelta();
    return _defaultInstance;
  }
  static BindingDelta _defaultInstance;
  static void $checkItem(BindingDelta v) {
    if (v is !BindingDelta) checkItemFailed(v, 'BindingDelta');
  }

  BindingDelta_Action get action => $_get(0, 1, null);
  void set action(BindingDelta_Action v) { setField(1, v); }
  bool hasAction() => $_has(0, 1);
  void clearAction() => clearField(1);

  String get role => $_get(1, 2, '');
  void set role(String v) { $_setString(1, 2, v); }
  bool hasRole() => $_has(1, 2);
  void clearRole() => clearField(2);

  String get member => $_get(2, 3, '');
  void set member(String v) { $_setString(2, 3, v); }
  bool hasMember() => $_has(2, 3);
  void clearMember() => clearField(3);
}

class _ReadonlyBindingDelta extends BindingDelta with ReadonlyMessageMixin {}

