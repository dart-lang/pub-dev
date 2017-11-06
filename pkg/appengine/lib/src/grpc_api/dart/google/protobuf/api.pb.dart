///
//  Generated code. Do not modify.
///
library google.protobuf_api;

import 'package:protobuf/protobuf.dart';

import 'type.pb.dart';
import 'source_context.pb.dart';

import 'type.pbenum.dart';

class Api extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Api')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..pp/*<Method>*/(2, 'methods', PbFieldType.PM, Method.$checkItem, Method.create)
    ..pp/*<Option>*/(3, 'options', PbFieldType.PM, Option.$checkItem, Option.create)
    ..a/*<String>*/(4, 'version', PbFieldType.OS)
    ..a/*<SourceContext>*/(5, 'sourceContext', PbFieldType.OM, SourceContext.getDefault, SourceContext.create)
    ..pp/*<Mixin>*/(6, 'mixins', PbFieldType.PM, Mixin.$checkItem, Mixin.create)
    ..e/*<Syntax>*/(7, 'syntax', PbFieldType.OE, Syntax.SYNTAX_PROTO2, Syntax.valueOf)
    ..hasRequiredFields = false
  ;

  Api() : super();
  Api.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Api.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Api clone() => new Api()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Api create() => new Api();
  static PbList<Api> createRepeated() => new PbList<Api>();
  static Api getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyApi();
    return _defaultInstance;
  }
  static Api _defaultInstance;
  static void $checkItem(Api v) {
    if (v is !Api) checkItemFailed(v, 'Api');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  List<Method> get methods => $_get(1, 2, null);

  List<Option> get options => $_get(2, 3, null);

  String get version => $_get(3, 4, '');
  void set version(String v) { $_setString(3, 4, v); }
  bool hasVersion() => $_has(3, 4);
  void clearVersion() => clearField(4);

  SourceContext get sourceContext => $_get(4, 5, null);
  void set sourceContext(SourceContext v) { setField(5, v); }
  bool hasSourceContext() => $_has(4, 5);
  void clearSourceContext() => clearField(5);

  List<Mixin> get mixins => $_get(5, 6, null);

  Syntax get syntax => $_get(6, 7, null);
  void set syntax(Syntax v) { setField(7, v); }
  bool hasSyntax() => $_has(6, 7);
  void clearSyntax() => clearField(7);
}

class _ReadonlyApi extends Api with ReadonlyMessageMixin {}

class Method extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Method')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'requestTypeUrl', PbFieldType.OS)
    ..a/*<bool>*/(3, 'requestStreaming', PbFieldType.OB)
    ..a/*<String>*/(4, 'responseTypeUrl', PbFieldType.OS)
    ..a/*<bool>*/(5, 'responseStreaming', PbFieldType.OB)
    ..pp/*<Option>*/(6, 'options', PbFieldType.PM, Option.$checkItem, Option.create)
    ..e/*<Syntax>*/(7, 'syntax', PbFieldType.OE, Syntax.SYNTAX_PROTO2, Syntax.valueOf)
    ..hasRequiredFields = false
  ;

  Method() : super();
  Method.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Method.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Method clone() => new Method()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Method create() => new Method();
  static PbList<Method> createRepeated() => new PbList<Method>();
  static Method getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMethod();
    return _defaultInstance;
  }
  static Method _defaultInstance;
  static void $checkItem(Method v) {
    if (v is !Method) checkItemFailed(v, 'Method');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get requestTypeUrl => $_get(1, 2, '');
  void set requestTypeUrl(String v) { $_setString(1, 2, v); }
  bool hasRequestTypeUrl() => $_has(1, 2);
  void clearRequestTypeUrl() => clearField(2);

  bool get requestStreaming => $_get(2, 3, false);
  void set requestStreaming(bool v) { $_setBool(2, 3, v); }
  bool hasRequestStreaming() => $_has(2, 3);
  void clearRequestStreaming() => clearField(3);

  String get responseTypeUrl => $_get(3, 4, '');
  void set responseTypeUrl(String v) { $_setString(3, 4, v); }
  bool hasResponseTypeUrl() => $_has(3, 4);
  void clearResponseTypeUrl() => clearField(4);

  bool get responseStreaming => $_get(4, 5, false);
  void set responseStreaming(bool v) { $_setBool(4, 5, v); }
  bool hasResponseStreaming() => $_has(4, 5);
  void clearResponseStreaming() => clearField(5);

  List<Option> get options => $_get(5, 6, null);

  Syntax get syntax => $_get(6, 7, null);
  void set syntax(Syntax v) { setField(7, v); }
  bool hasSyntax() => $_has(6, 7);
  void clearSyntax() => clearField(7);
}

class _ReadonlyMethod extends Method with ReadonlyMessageMixin {}

class Mixin extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Mixin')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'root', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Mixin() : super();
  Mixin.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Mixin.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Mixin clone() => new Mixin()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Mixin create() => new Mixin();
  static PbList<Mixin> createRepeated() => new PbList<Mixin>();
  static Mixin getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMixin();
    return _defaultInstance;
  }
  static Mixin _defaultInstance;
  static void $checkItem(Mixin v) {
    if (v is !Mixin) checkItemFailed(v, 'Mixin');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get root => $_get(1, 2, '');
  void set root(String v) { $_setString(1, 2, v); }
  bool hasRoot() => $_has(1, 2);
  void clearRoot() => clearField(2);
}

class _ReadonlyMixin extends Mixin with ReadonlyMessageMixin {}

