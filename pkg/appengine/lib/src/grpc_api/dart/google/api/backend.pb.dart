///
//  Generated code. Do not modify.
///
library google.api_backend;

import 'package:protobuf/protobuf.dart';

class Backend extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Backend')
    ..pp/*<BackendRule>*/(1, 'rules', PbFieldType.PM, BackendRule.$checkItem, BackendRule.create)
    ..hasRequiredFields = false
  ;

  Backend() : super();
  Backend.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Backend.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Backend clone() => new Backend()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Backend create() => new Backend();
  static PbList<Backend> createRepeated() => new PbList<Backend>();
  static Backend getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBackend();
    return _defaultInstance;
  }
  static Backend _defaultInstance;
  static void $checkItem(Backend v) {
    if (v is !Backend) checkItemFailed(v, 'Backend');
  }

  List<BackendRule> get rules => $_get(0, 1, null);
}

class _ReadonlyBackend extends Backend with ReadonlyMessageMixin {}

class BackendRule extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BackendRule')
    ..a/*<String>*/(1, 'selector', PbFieldType.OS)
    ..a/*<String>*/(2, 'address', PbFieldType.OS)
    ..a/*<double>*/(3, 'deadline', PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  BackendRule() : super();
  BackendRule.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BackendRule.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BackendRule clone() => new BackendRule()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BackendRule create() => new BackendRule();
  static PbList<BackendRule> createRepeated() => new PbList<BackendRule>();
  static BackendRule getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBackendRule();
    return _defaultInstance;
  }
  static BackendRule _defaultInstance;
  static void $checkItem(BackendRule v) {
    if (v is !BackendRule) checkItemFailed(v, 'BackendRule');
  }

  String get selector => $_get(0, 1, '');
  void set selector(String v) { $_setString(0, 1, v); }
  bool hasSelector() => $_has(0, 1);
  void clearSelector() => clearField(1);

  String get address => $_get(1, 2, '');
  void set address(String v) { $_setString(1, 2, v); }
  bool hasAddress() => $_has(1, 2);
  void clearAddress() => clearField(2);

  double get deadline => $_get(2, 3, null);
  void set deadline(double v) { $_setDouble(2, 3, v); }
  bool hasDeadline() => $_has(2, 3);
  void clearDeadline() => clearField(3);
}

class _ReadonlyBackendRule extends BackendRule with ReadonlyMessageMixin {}

