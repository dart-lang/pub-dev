///
//  Generated code. Do not modify.
///
library google.api_log;

import 'package:protobuf/protobuf.dart';

import 'label.pb.dart';

class LogDescriptor extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogDescriptor')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..pp/*<LabelDescriptor>*/(2, 'labels', PbFieldType.PM, LabelDescriptor.$checkItem, LabelDescriptor.create)
    ..a/*<String>*/(3, 'description', PbFieldType.OS)
    ..a/*<String>*/(4, 'displayName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  LogDescriptor() : super();
  LogDescriptor.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogDescriptor.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogDescriptor clone() => new LogDescriptor()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LogDescriptor create() => new LogDescriptor();
  static PbList<LogDescriptor> createRepeated() => new PbList<LogDescriptor>();
  static LogDescriptor getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLogDescriptor();
    return _defaultInstance;
  }
  static LogDescriptor _defaultInstance;
  static void $checkItem(LogDescriptor v) {
    if (v is !LogDescriptor) checkItemFailed(v, 'LogDescriptor');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  List<LabelDescriptor> get labels => $_get(1, 2, null);

  String get description => $_get(2, 3, '');
  void set description(String v) { $_setString(2, 3, v); }
  bool hasDescription() => $_has(2, 3);
  void clearDescription() => clearField(3);

  String get displayName => $_get(3, 4, '');
  void set displayName(String v) { $_setString(3, 4, v); }
  bool hasDisplayName() => $_has(3, 4);
  void clearDisplayName() => clearField(4);
}

class _ReadonlyLogDescriptor extends LogDescriptor with ReadonlyMessageMixin {}

