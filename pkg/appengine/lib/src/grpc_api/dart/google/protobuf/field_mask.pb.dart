///
//  Generated code. Do not modify.
///
library google.protobuf_field_mask;

import 'package:protobuf/protobuf.dart';

class FieldMask extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('FieldMask')
    ..p/*<String>*/(1, 'paths', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  FieldMask() : super();
  FieldMask.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  FieldMask.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  FieldMask clone() => new FieldMask()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static FieldMask create() => new FieldMask();
  static PbList<FieldMask> createRepeated() => new PbList<FieldMask>();
  static FieldMask getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyFieldMask();
    return _defaultInstance;
  }
  static FieldMask _defaultInstance;
  static void $checkItem(FieldMask v) {
    if (v is !FieldMask) checkItemFailed(v, 'FieldMask');
  }

  List<String> get paths => $_get(0, 1, null);
}

class _ReadonlyFieldMask extends FieldMask with ReadonlyMessageMixin {}

