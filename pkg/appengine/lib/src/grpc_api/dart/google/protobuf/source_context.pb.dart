///
//  Generated code. Do not modify.
///
library google.protobuf_source_context;

import 'package:protobuf/protobuf.dart';

class SourceContext extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SourceContext')
    ..a/*<String>*/(1, 'fileName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SourceContext() : super();
  SourceContext.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SourceContext.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SourceContext clone() => new SourceContext()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SourceContext create() => new SourceContext();
  static PbList<SourceContext> createRepeated() => new PbList<SourceContext>();
  static SourceContext getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySourceContext();
    return _defaultInstance;
  }
  static SourceContext _defaultInstance;
  static void $checkItem(SourceContext v) {
    if (v is !SourceContext) checkItemFailed(v, 'SourceContext');
  }

  String get fileName => $_get(0, 1, '');
  void set fileName(String v) { $_setString(0, 1, v); }
  bool hasFileName() => $_has(0, 1);
  void clearFileName() => clearField(1);
}

class _ReadonlySourceContext extends SourceContext with ReadonlyMessageMixin {}

