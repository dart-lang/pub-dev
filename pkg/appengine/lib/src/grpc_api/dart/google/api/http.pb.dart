///
//  Generated code. Do not modify.
///
library google.api_http;

import 'package:protobuf/protobuf.dart';

class Http extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Http')
    ..pp/*<HttpRule>*/(1, 'rules', PbFieldType.PM, HttpRule.$checkItem, HttpRule.create)
    ..hasRequiredFields = false
  ;

  Http() : super();
  Http.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Http.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Http clone() => new Http()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Http create() => new Http();
  static PbList<Http> createRepeated() => new PbList<Http>();
  static Http getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHttp();
    return _defaultInstance;
  }
  static Http _defaultInstance;
  static void $checkItem(Http v) {
    if (v is !Http) checkItemFailed(v, 'Http');
  }

  List<HttpRule> get rules => $_get(0, 1, null);
}

class _ReadonlyHttp extends Http with ReadonlyMessageMixin {}

class HttpRule extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HttpRule')
    ..a/*<String>*/(1, 'selector', PbFieldType.OS)
    ..a/*<String>*/(2, 'get', PbFieldType.OS)
    ..a/*<String>*/(3, 'put', PbFieldType.OS)
    ..a/*<String>*/(4, 'post', PbFieldType.OS)
    ..a/*<String>*/(5, 'delete', PbFieldType.OS)
    ..a/*<String>*/(6, 'patch', PbFieldType.OS)
    ..a/*<String>*/(7, 'body', PbFieldType.OS)
    ..a/*<CustomHttpPattern>*/(8, 'custom', PbFieldType.OM, CustomHttpPattern.getDefault, CustomHttpPattern.create)
    ..pp/*<HttpRule>*/(11, 'additionalBindings', PbFieldType.PM, HttpRule.$checkItem, HttpRule.create)
    ..hasRequiredFields = false
  ;

  HttpRule() : super();
  HttpRule.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HttpRule.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HttpRule clone() => new HttpRule()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HttpRule create() => new HttpRule();
  static PbList<HttpRule> createRepeated() => new PbList<HttpRule>();
  static HttpRule getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHttpRule();
    return _defaultInstance;
  }
  static HttpRule _defaultInstance;
  static void $checkItem(HttpRule v) {
    if (v is !HttpRule) checkItemFailed(v, 'HttpRule');
  }

  String get selector => $_get(0, 1, '');
  void set selector(String v) { $_setString(0, 1, v); }
  bool hasSelector() => $_has(0, 1);
  void clearSelector() => clearField(1);

  String get get => $_get(1, 2, '');
  void set get(String v) { $_setString(1, 2, v); }
  bool hasGet() => $_has(1, 2);
  void clearGet() => clearField(2);

  String get put => $_get(2, 3, '');
  void set put(String v) { $_setString(2, 3, v); }
  bool hasPut() => $_has(2, 3);
  void clearPut() => clearField(3);

  String get post => $_get(3, 4, '');
  void set post(String v) { $_setString(3, 4, v); }
  bool hasPost() => $_has(3, 4);
  void clearPost() => clearField(4);

  String get delete => $_get(4, 5, '');
  void set delete(String v) { $_setString(4, 5, v); }
  bool hasDelete() => $_has(4, 5);
  void clearDelete() => clearField(5);

  String get patch => $_get(5, 6, '');
  void set patch(String v) { $_setString(5, 6, v); }
  bool hasPatch() => $_has(5, 6);
  void clearPatch() => clearField(6);

  String get body => $_get(6, 7, '');
  void set body(String v) { $_setString(6, 7, v); }
  bool hasBody() => $_has(6, 7);
  void clearBody() => clearField(7);

  CustomHttpPattern get custom => $_get(7, 8, null);
  void set custom(CustomHttpPattern v) { setField(8, v); }
  bool hasCustom() => $_has(7, 8);
  void clearCustom() => clearField(8);

  List<HttpRule> get additionalBindings => $_get(8, 11, null);
}

class _ReadonlyHttpRule extends HttpRule with ReadonlyMessageMixin {}

class CustomHttpPattern extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CustomHttpPattern')
    ..a/*<String>*/(1, 'kind', PbFieldType.OS)
    ..a/*<String>*/(2, 'path', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CustomHttpPattern() : super();
  CustomHttpPattern.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CustomHttpPattern.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CustomHttpPattern clone() => new CustomHttpPattern()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CustomHttpPattern create() => new CustomHttpPattern();
  static PbList<CustomHttpPattern> createRepeated() => new PbList<CustomHttpPattern>();
  static CustomHttpPattern getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCustomHttpPattern();
    return _defaultInstance;
  }
  static CustomHttpPattern _defaultInstance;
  static void $checkItem(CustomHttpPattern v) {
    if (v is !CustomHttpPattern) checkItemFailed(v, 'CustomHttpPattern');
  }

  String get kind => $_get(0, 1, '');
  void set kind(String v) { $_setString(0, 1, v); }
  bool hasKind() => $_has(0, 1);
  void clearKind() => clearField(1);

  String get path => $_get(1, 2, '');
  void set path(String v) { $_setString(1, 2, v); }
  bool hasPath() => $_has(1, 2);
  void clearPath() => clearField(2);
}

class _ReadonlyCustomHttpPattern extends CustomHttpPattern with ReadonlyMessageMixin {}

