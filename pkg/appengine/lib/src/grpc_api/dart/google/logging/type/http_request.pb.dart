//
//  Generated code. Do not modify.
//  source: google/logging/type/http_request.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/duration.pb.dart' as $51;

/// A common proto for logging HTTP requests. Only contains semantics
/// defined by the HTTP specification. Product-specific logging
/// information MUST be defined in a separate message.
class HttpRequest extends $pb.GeneratedMessage {
  factory HttpRequest({
    $core.String? requestMethod,
    $core.String? requestUrl,
    $fixnum.Int64? requestSize,
    $core.int? status,
    $fixnum.Int64? responseSize,
    $core.String? userAgent,
    $core.String? remoteIp,
    $core.String? referer,
    $core.bool? cacheHit,
    $core.bool? cacheValidatedWithOriginServer,
    $core.bool? cacheLookup,
    $fixnum.Int64? cacheFillBytes,
    $core.String? serverIp,
    $51.Duration? latency,
    $core.String? protocol,
  }) {
    final $result = create();
    if (requestMethod != null) {
      $result.requestMethod = requestMethod;
    }
    if (requestUrl != null) {
      $result.requestUrl = requestUrl;
    }
    if (requestSize != null) {
      $result.requestSize = requestSize;
    }
    if (status != null) {
      $result.status = status;
    }
    if (responseSize != null) {
      $result.responseSize = responseSize;
    }
    if (userAgent != null) {
      $result.userAgent = userAgent;
    }
    if (remoteIp != null) {
      $result.remoteIp = remoteIp;
    }
    if (referer != null) {
      $result.referer = referer;
    }
    if (cacheHit != null) {
      $result.cacheHit = cacheHit;
    }
    if (cacheValidatedWithOriginServer != null) {
      $result.cacheValidatedWithOriginServer = cacheValidatedWithOriginServer;
    }
    if (cacheLookup != null) {
      $result.cacheLookup = cacheLookup;
    }
    if (cacheFillBytes != null) {
      $result.cacheFillBytes = cacheFillBytes;
    }
    if (serverIp != null) {
      $result.serverIp = serverIp;
    }
    if (latency != null) {
      $result.latency = latency;
    }
    if (protocol != null) {
      $result.protocol = protocol;
    }
    return $result;
  }
  HttpRequest._() : super();
  factory HttpRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory HttpRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HttpRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.type'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestMethod')
    ..aOS(2, _omitFieldNames ? '' : 'requestUrl')
    ..aInt64(3, _omitFieldNames ? '' : 'requestSize')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.O3)
    ..aInt64(5, _omitFieldNames ? '' : 'responseSize')
    ..aOS(6, _omitFieldNames ? '' : 'userAgent')
    ..aOS(7, _omitFieldNames ? '' : 'remoteIp')
    ..aOS(8, _omitFieldNames ? '' : 'referer')
    ..aOB(9, _omitFieldNames ? '' : 'cacheHit')
    ..aOB(10, _omitFieldNames ? '' : 'cacheValidatedWithOriginServer')
    ..aOB(11, _omitFieldNames ? '' : 'cacheLookup')
    ..aInt64(12, _omitFieldNames ? '' : 'cacheFillBytes')
    ..aOS(13, _omitFieldNames ? '' : 'serverIp')
    ..aOM<$51.Duration>(14, _omitFieldNames ? '' : 'latency',
        subBuilder: $51.Duration.create)
    ..aOS(15, _omitFieldNames ? '' : 'protocol')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  HttpRequest clone() => HttpRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  HttpRequest copyWith(void Function(HttpRequest) updates) =>
      super.copyWith((message) => updates(message as HttpRequest))
          as HttpRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HttpRequest create() => HttpRequest._();
  HttpRequest createEmptyInstance() => create();
  static $pb.PbList<HttpRequest> createRepeated() => $pb.PbList<HttpRequest>();
  @$core.pragma('dart2js:noInline')
  static HttpRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HttpRequest>(create);
  static HttpRequest? _defaultInstance;

  /// The request method. Examples: `"GET"`, `"HEAD"`, `"PUT"`, `"POST"`.
  @$pb.TagNumber(1)
  $core.String get requestMethod => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestMethod($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRequestMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestMethod() => clearField(1);

  /// The scheme (http, https), the host name, the path and the query
  /// portion of the URL that was requested.
  /// Example: `"http://example.com/some/info?color=red"`.
  @$pb.TagNumber(2)
  $core.String get requestUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set requestUrl($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRequestUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequestUrl() => clearField(2);

  /// The size of the HTTP request message in bytes, including the request
  /// headers and the request body.
  @$pb.TagNumber(3)
  $fixnum.Int64 get requestSize => $_getI64(2);
  @$pb.TagNumber(3)
  set requestSize($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRequestSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestSize() => clearField(3);

  /// The response code indicating the status of response.
  /// Examples: 200, 404.
  @$pb.TagNumber(4)
  $core.int get status => $_getIZ(3);
  @$pb.TagNumber(4)
  set status($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  /// The size of the HTTP response message sent back to the client, in bytes,
  /// including the response headers and the response body.
  @$pb.TagNumber(5)
  $fixnum.Int64 get responseSize => $_getI64(4);
  @$pb.TagNumber(5)
  set responseSize($fixnum.Int64 v) {
    $_setInt64(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasResponseSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearResponseSize() => clearField(5);

  /// The user agent sent by the client. Example:
  /// `"Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; Q312461; .NET
  /// CLR 1.0.3705)"`.
  @$pb.TagNumber(6)
  $core.String get userAgent => $_getSZ(5);
  @$pb.TagNumber(6)
  set userAgent($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasUserAgent() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserAgent() => clearField(6);

  /// The IP address (IPv4 or IPv6) of the client that issued the HTTP
  /// request. This field can include port information. Examples:
  /// `"192.168.1.1"`, `"10.0.0.1:80"`, `"FE80::0202:B3FF:FE1E:8329"`.
  @$pb.TagNumber(7)
  $core.String get remoteIp => $_getSZ(6);
  @$pb.TagNumber(7)
  set remoteIp($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasRemoteIp() => $_has(6);
  @$pb.TagNumber(7)
  void clearRemoteIp() => clearField(7);

  /// The referer URL of the request, as defined in
  /// [HTTP/1.1 Header Field
  /// Definitions](https://datatracker.ietf.org/doc/html/rfc2616#section-14.36).
  @$pb.TagNumber(8)
  $core.String get referer => $_getSZ(7);
  @$pb.TagNumber(8)
  set referer($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasReferer() => $_has(7);
  @$pb.TagNumber(8)
  void clearReferer() => clearField(8);

  /// Whether or not an entity was served from cache
  /// (with or without validation).
  @$pb.TagNumber(9)
  $core.bool get cacheHit => $_getBF(8);
  @$pb.TagNumber(9)
  set cacheHit($core.bool v) {
    $_setBool(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasCacheHit() => $_has(8);
  @$pb.TagNumber(9)
  void clearCacheHit() => clearField(9);

  /// Whether or not the response was validated with the origin server before
  /// being served from cache. This field is only meaningful if `cache_hit` is
  /// True.
  @$pb.TagNumber(10)
  $core.bool get cacheValidatedWithOriginServer => $_getBF(9);
  @$pb.TagNumber(10)
  set cacheValidatedWithOriginServer($core.bool v) {
    $_setBool(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasCacheValidatedWithOriginServer() => $_has(9);
  @$pb.TagNumber(10)
  void clearCacheValidatedWithOriginServer() => clearField(10);

  /// Whether or not a cache lookup was attempted.
  @$pb.TagNumber(11)
  $core.bool get cacheLookup => $_getBF(10);
  @$pb.TagNumber(11)
  set cacheLookup($core.bool v) {
    $_setBool(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasCacheLookup() => $_has(10);
  @$pb.TagNumber(11)
  void clearCacheLookup() => clearField(11);

  /// The number of HTTP response bytes inserted into cache. Set only when a
  /// cache fill was attempted.
  @$pb.TagNumber(12)
  $fixnum.Int64 get cacheFillBytes => $_getI64(11);
  @$pb.TagNumber(12)
  set cacheFillBytes($fixnum.Int64 v) {
    $_setInt64(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasCacheFillBytes() => $_has(11);
  @$pb.TagNumber(12)
  void clearCacheFillBytes() => clearField(12);

  /// The IP address (IPv4 or IPv6) of the origin server that the request was
  /// sent to. This field can include port information. Examples:
  /// `"192.168.1.1"`, `"10.0.0.1:80"`, `"FE80::0202:B3FF:FE1E:8329"`.
  @$pb.TagNumber(13)
  $core.String get serverIp => $_getSZ(12);
  @$pb.TagNumber(13)
  set serverIp($core.String v) {
    $_setString(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasServerIp() => $_has(12);
  @$pb.TagNumber(13)
  void clearServerIp() => clearField(13);

  /// The request processing latency on the server, from the time the request was
  /// received until the response was sent.
  @$pb.TagNumber(14)
  $51.Duration get latency => $_getN(13);
  @$pb.TagNumber(14)
  set latency($51.Duration v) {
    setField(14, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasLatency() => $_has(13);
  @$pb.TagNumber(14)
  void clearLatency() => clearField(14);
  @$pb.TagNumber(14)
  $51.Duration ensureLatency() => $_ensure(13);

  /// Protocol used for the request. Examples: "HTTP/1.1", "HTTP/2", "websocket"
  @$pb.TagNumber(15)
  $core.String get protocol => $_getSZ(14);
  @$pb.TagNumber(15)
  set protocol($core.String v) {
    $_setString(14, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasProtocol() => $_has(14);
  @$pb.TagNumber(15)
  void clearProtocol() => clearField(15);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
