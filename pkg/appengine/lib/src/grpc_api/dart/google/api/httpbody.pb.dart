///
//  Generated code. Do not modify.
///
library google.api_httpbody;

import 'package:protobuf/protobuf.dart';

class HttpBody extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HttpBody')
    ..a/*<String>*/(1, 'contentType', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'data', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  HttpBody() : super();
  HttpBody.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HttpBody.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HttpBody clone() => new HttpBody()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HttpBody create() => new HttpBody();
  static PbList<HttpBody> createRepeated() => new PbList<HttpBody>();
  static HttpBody getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHttpBody();
    return _defaultInstance;
  }
  static HttpBody _defaultInstance;
  static void $checkItem(HttpBody v) {
    if (v is !HttpBody) checkItemFailed(v, 'HttpBody');
  }

  String get contentType => $_get(0, 1, '');
  void set contentType(String v) { $_setString(0, 1, v); }
  bool hasContentType() => $_has(0, 1);
  void clearContentType() => clearField(1);

  List<int> get data => $_get(1, 2, null);
  void set data(List<int> v) { $_setBytes(1, 2, v); }
  bool hasData() => $_has(1, 2);
  void clearData() => clearField(2);
}

class _ReadonlyHttpBody extends HttpBody with ReadonlyMessageMixin {}

