///
//  Generated code. Do not modify.
///
library google.api_control;

import 'package:protobuf/protobuf.dart';

class Control extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Control')
    ..a/*<String>*/(1, 'environment', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Control() : super();
  Control.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Control.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Control clone() => new Control()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Control create() => new Control();
  static PbList<Control> createRepeated() => new PbList<Control>();
  static Control getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyControl();
    return _defaultInstance;
  }
  static Control _defaultInstance;
  static void $checkItem(Control v) {
    if (v is !Control) checkItemFailed(v, 'Control');
  }

  String get environment => $_get(0, 1, '');
  void set environment(String v) { $_setString(0, 1, v); }
  bool hasEnvironment() => $_has(0, 1);
  void clearEnvironment() => clearField(1);
}

class _ReadonlyControl extends Control with ReadonlyMessageMixin {}

