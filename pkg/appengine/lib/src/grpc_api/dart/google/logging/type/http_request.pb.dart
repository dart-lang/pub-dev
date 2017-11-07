///
//  Generated code. Do not modify.
///
library google.logging.type_http_request;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../../protobuf/duration.pb.dart' as google$protobuf;

class HttpRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HttpRequest')
    ..a/*<String>*/(1, 'requestMethod', PbFieldType.OS)
    ..a/*<String>*/(2, 'requestUrl', PbFieldType.OS)
    ..a/*<Int64>*/(3, 'requestSize', PbFieldType.O6, Int64.ZERO)
    ..a/*<int>*/(4, 'status', PbFieldType.O3)
    ..a/*<Int64>*/(5, 'responseSize', PbFieldType.O6, Int64.ZERO)
    ..a/*<String>*/(6, 'userAgent', PbFieldType.OS)
    ..a/*<String>*/(7, 'remoteIp', PbFieldType.OS)
    ..a/*<String>*/(8, 'referer', PbFieldType.OS)
    ..a/*<bool>*/(9, 'cacheHit', PbFieldType.OB)
    ..a/*<bool>*/(10, 'cacheValidatedWithOriginServer', PbFieldType.OB)
    ..a/*<bool>*/(11, 'cacheLookup', PbFieldType.OB)
    ..a/*<Int64>*/(12, 'cacheFillBytes', PbFieldType.O6, Int64.ZERO)
    ..a/*<String>*/(13, 'serverIp', PbFieldType.OS)
    ..a/*<google$protobuf.Duration>*/(14, 'latency', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..hasRequiredFields = false
  ;

  HttpRequest() : super();
  HttpRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HttpRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HttpRequest clone() => new HttpRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HttpRequest create() => new HttpRequest();
  static PbList<HttpRequest> createRepeated() => new PbList<HttpRequest>();
  static HttpRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHttpRequest();
    return _defaultInstance;
  }
  static HttpRequest _defaultInstance;
  static void $checkItem(HttpRequest v) {
    if (v is !HttpRequest) checkItemFailed(v, 'HttpRequest');
  }

  String get requestMethod => $_get(0, 1, '');
  void set requestMethod(String v) { $_setString(0, 1, v); }
  bool hasRequestMethod() => $_has(0, 1);
  void clearRequestMethod() => clearField(1);

  String get requestUrl => $_get(1, 2, '');
  void set requestUrl(String v) { $_setString(1, 2, v); }
  bool hasRequestUrl() => $_has(1, 2);
  void clearRequestUrl() => clearField(2);

  Int64 get requestSize => $_get(2, 3, null);
  void set requestSize(Int64 v) { $_setInt64(2, 3, v); }
  bool hasRequestSize() => $_has(2, 3);
  void clearRequestSize() => clearField(3);

  int get status => $_get(3, 4, 0);
  void set status(int v) { $_setUnsignedInt32(3, 4, v); }
  bool hasStatus() => $_has(3, 4);
  void clearStatus() => clearField(4);

  Int64 get responseSize => $_get(4, 5, null);
  void set responseSize(Int64 v) { $_setInt64(4, 5, v); }
  bool hasResponseSize() => $_has(4, 5);
  void clearResponseSize() => clearField(5);

  String get userAgent => $_get(5, 6, '');
  void set userAgent(String v) { $_setString(5, 6, v); }
  bool hasUserAgent() => $_has(5, 6);
  void clearUserAgent() => clearField(6);

  String get remoteIp => $_get(6, 7, '');
  void set remoteIp(String v) { $_setString(6, 7, v); }
  bool hasRemoteIp() => $_has(6, 7);
  void clearRemoteIp() => clearField(7);

  String get referer => $_get(7, 8, '');
  void set referer(String v) { $_setString(7, 8, v); }
  bool hasReferer() => $_has(7, 8);
  void clearReferer() => clearField(8);

  bool get cacheHit => $_get(8, 9, false);
  void set cacheHit(bool v) { $_setBool(8, 9, v); }
  bool hasCacheHit() => $_has(8, 9);
  void clearCacheHit() => clearField(9);

  bool get cacheValidatedWithOriginServer => $_get(9, 10, false);
  void set cacheValidatedWithOriginServer(bool v) { $_setBool(9, 10, v); }
  bool hasCacheValidatedWithOriginServer() => $_has(9, 10);
  void clearCacheValidatedWithOriginServer() => clearField(10);

  bool get cacheLookup => $_get(10, 11, false);
  void set cacheLookup(bool v) { $_setBool(10, 11, v); }
  bool hasCacheLookup() => $_has(10, 11);
  void clearCacheLookup() => clearField(11);

  Int64 get cacheFillBytes => $_get(11, 12, null);
  void set cacheFillBytes(Int64 v) { $_setInt64(11, 12, v); }
  bool hasCacheFillBytes() => $_has(11, 12);
  void clearCacheFillBytes() => clearField(12);

  String get serverIp => $_get(12, 13, '');
  void set serverIp(String v) { $_setString(12, 13, v); }
  bool hasServerIp() => $_has(12, 13);
  void clearServerIp() => clearField(13);

  google$protobuf.Duration get latency => $_get(13, 14, null);
  void set latency(google$protobuf.Duration v) { setField(14, v); }
  bool hasLatency() => $_has(13, 14);
  void clearLatency() => clearField(14);
}

class _ReadonlyHttpRequest extends HttpRequest with ReadonlyMessageMixin {}

