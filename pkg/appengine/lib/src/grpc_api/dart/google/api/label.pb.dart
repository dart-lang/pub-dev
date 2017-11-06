///
//  Generated code. Do not modify.
///
library google.api_label;

import 'package:protobuf/protobuf.dart';

import 'label.pbenum.dart';

export 'label.pbenum.dart';

class LabelDescriptor extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LabelDescriptor')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..e/*<LabelDescriptor_ValueType>*/(2, 'valueType', PbFieldType.OE, LabelDescriptor_ValueType.STRING, LabelDescriptor_ValueType.valueOf)
    ..a/*<String>*/(3, 'description', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  LabelDescriptor() : super();
  LabelDescriptor.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LabelDescriptor.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LabelDescriptor clone() => new LabelDescriptor()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LabelDescriptor create() => new LabelDescriptor();
  static PbList<LabelDescriptor> createRepeated() => new PbList<LabelDescriptor>();
  static LabelDescriptor getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLabelDescriptor();
    return _defaultInstance;
  }
  static LabelDescriptor _defaultInstance;
  static void $checkItem(LabelDescriptor v) {
    if (v is !LabelDescriptor) checkItemFailed(v, 'LabelDescriptor');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  LabelDescriptor_ValueType get valueType => $_get(1, 2, null);
  void set valueType(LabelDescriptor_ValueType v) { setField(2, v); }
  bool hasValueType() => $_has(1, 2);
  void clearValueType() => clearField(2);

  String get description => $_get(2, 3, '');
  void set description(String v) { $_setString(2, 3, v); }
  bool hasDescription() => $_has(2, 3);
  void clearDescription() => clearField(3);
}

class _ReadonlyLabelDescriptor extends LabelDescriptor with ReadonlyMessageMixin {}

