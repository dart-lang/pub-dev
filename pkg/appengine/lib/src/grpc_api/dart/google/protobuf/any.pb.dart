///
//  Generated code. Do not modify.
///
library google.protobuf_any;

import 'package:protobuf/protobuf.dart';

class Any extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Any')
    ..a/*<String>*/(1, 'typeUrl', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'value', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Any() : super();
  Any.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Any.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Any clone() => new Any()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Any create() => new Any();
  static PbList<Any> createRepeated() => new PbList<Any>();
  static Any getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAny();
    return _defaultInstance;
  }
  static Any _defaultInstance;
  static void $checkItem(Any v) {
    if (v is !Any) checkItemFailed(v, 'Any');
  }

  String get typeUrl => $_get(0, 1, '');
  void set typeUrl(String v) { $_setString(0, 1, v); }
  bool hasTypeUrl() => $_has(0, 1);
  void clearTypeUrl() => clearField(1);

  List<int> get value => $_get(1, 2, null);
  void set value(List<int> v) { $_setBytes(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyAny extends Any with ReadonlyMessageMixin {}

