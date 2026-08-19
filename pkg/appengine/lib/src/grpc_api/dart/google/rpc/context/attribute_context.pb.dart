//
//  Generated code. Do not modify.
//  source: google/rpc/context/attribute_context.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/any.pb.dart' as $49;
import '../../protobuf/duration.pb.dart' as $51;
import '../../protobuf/struct.pb.dart' as $48;
import '../../protobuf/timestamp.pb.dart' as $50;

/// This message defines attributes for a node that handles a network request.
/// The node can be either a service or an application that sends, forwards,
/// or receives the request. Service peers should fill in
/// `principal` and `labels` as appropriate.
class AttributeContext_Peer extends $pb.GeneratedMessage {
  factory AttributeContext_Peer({
    $core.String? ip,
    $fixnum.Int64? port,
    $core.Map<$core.String, $core.String>? labels,
    $core.String? principal,
    $core.String? regionCode,
  }) {
    final $result = create();
    if (ip != null) {
      $result.ip = ip;
    }
    if (port != null) {
      $result.port = port;
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (principal != null) {
      $result.principal = principal;
    }
    if (regionCode != null) {
      $result.regionCode = regionCode;
    }
    return $result;
  }
  AttributeContext_Peer._() : super();
  factory AttributeContext_Peer.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AttributeContext_Peer.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AttributeContext.Peer',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc.context'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ip')
    ..aInt64(2, _omitFieldNames ? '' : 'port')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'labels',
        entryClassName: 'AttributeContext.Peer.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.rpc.context'))
    ..aOS(7, _omitFieldNames ? '' : 'principal')
    ..aOS(8, _omitFieldNames ? '' : 'regionCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AttributeContext_Peer clone() =>
      AttributeContext_Peer()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AttributeContext_Peer copyWith(
          void Function(AttributeContext_Peer) updates) =>
      super.copyWith((message) => updates(message as AttributeContext_Peer))
          as AttributeContext_Peer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AttributeContext_Peer create() => AttributeContext_Peer._();
  AttributeContext_Peer createEmptyInstance() => create();
  static $pb.PbList<AttributeContext_Peer> createRepeated() =>
      $pb.PbList<AttributeContext_Peer>();
  @$core.pragma('dart2js:noInline')
  static AttributeContext_Peer getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AttributeContext_Peer>(create);
  static AttributeContext_Peer? _defaultInstance;

  /// The IP address of the peer.
  @$pb.TagNumber(1)
  $core.String get ip => $_getSZ(0);
  @$pb.TagNumber(1)
  set ip($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasIp() => $_has(0);
  @$pb.TagNumber(1)
  void clearIp() => clearField(1);

  /// The network port of the peer.
  @$pb.TagNumber(2)
  $fixnum.Int64 get port => $_getI64(1);
  @$pb.TagNumber(2)
  set port($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearPort() => clearField(2);

  /// The labels associated with the peer.
  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get labels => $_getMap(2);

  /// The identity of this peer. Similar to `Request.auth.principal`, but
  /// relative to the peer instead of the request. For example, the
  /// identity associated with a load balancer that forwarded the request.
  @$pb.TagNumber(7)
  $core.String get principal => $_getSZ(3);
  @$pb.TagNumber(7)
  set principal($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasPrincipal() => $_has(3);
  @$pb.TagNumber(7)
  void clearPrincipal() => clearField(7);

  /// The CLDR country/region code associated with the above IP address.
  /// If the IP address is private, the `region_code` should reflect the
  /// physical location where this peer is running.
  @$pb.TagNumber(8)
  $core.String get regionCode => $_getSZ(4);
  @$pb.TagNumber(8)
  set regionCode($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasRegionCode() => $_has(4);
  @$pb.TagNumber(8)
  void clearRegionCode() => clearField(8);
}

/// This message defines attributes associated with API operations, such as
/// a network API request. The terminology is based on the conventions used
/// by Google APIs, Istio, and OpenAPI.
class AttributeContext_Api extends $pb.GeneratedMessage {
  factory AttributeContext_Api({
    $core.String? service,
    $core.String? operation,
    $core.String? protocol,
    $core.String? version,
  }) {
    final $result = create();
    if (service != null) {
      $result.service = service;
    }
    if (operation != null) {
      $result.operation = operation;
    }
    if (protocol != null) {
      $result.protocol = protocol;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  AttributeContext_Api._() : super();
  factory AttributeContext_Api.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AttributeContext_Api.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AttributeContext.Api',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc.context'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'service')
    ..aOS(2, _omitFieldNames ? '' : 'operation')
    ..aOS(3, _omitFieldNames ? '' : 'protocol')
    ..aOS(4, _omitFieldNames ? '' : 'version')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AttributeContext_Api clone() =>
      AttributeContext_Api()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AttributeContext_Api copyWith(void Function(AttributeContext_Api) updates) =>
      super.copyWith((message) => updates(message as AttributeContext_Api))
          as AttributeContext_Api;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AttributeContext_Api create() => AttributeContext_Api._();
  AttributeContext_Api createEmptyInstance() => create();
  static $pb.PbList<AttributeContext_Api> createRepeated() =>
      $pb.PbList<AttributeContext_Api>();
  @$core.pragma('dart2js:noInline')
  static AttributeContext_Api getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AttributeContext_Api>(create);
  static AttributeContext_Api? _defaultInstance;

  /// The API service name. It is a logical identifier for a networked API,
  /// such as "pubsub.googleapis.com". The naming syntax depends on the
  /// API management system being used for handling the request.
  @$pb.TagNumber(1)
  $core.String get service => $_getSZ(0);
  @$pb.TagNumber(1)
  set service($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasService() => $_has(0);
  @$pb.TagNumber(1)
  void clearService() => clearField(1);

  /// The API operation name. For gRPC requests, it is the fully qualified API
  /// method name, such as "google.pubsub.v1.Publisher.Publish". For OpenAPI
  /// requests, it is the `operationId`, such as "getPet".
  @$pb.TagNumber(2)
  $core.String get operation => $_getSZ(1);
  @$pb.TagNumber(2)
  set operation($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOperation() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperation() => clearField(2);

  /// The API protocol used for sending the request, such as "http", "https",
  /// "grpc", or "internal".
  @$pb.TagNumber(3)
  $core.String get protocol => $_getSZ(2);
  @$pb.TagNumber(3)
  set protocol($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasProtocol() => $_has(2);
  @$pb.TagNumber(3)
  void clearProtocol() => clearField(3);

  /// The API version associated with the API operation above, such as "v1" or
  /// "v1alpha1".
  @$pb.TagNumber(4)
  $core.String get version => $_getSZ(3);
  @$pb.TagNumber(4)
  set version($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearVersion() => clearField(4);
}

/// This message defines request authentication attributes. Terminology is
/// based on the JSON Web Token (JWT) standard, but the terms also
/// correlate to concepts in other standards.
class AttributeContext_Auth extends $pb.GeneratedMessage {
  factory AttributeContext_Auth({
    $core.String? principal,
    $core.Iterable<$core.String>? audiences,
    $core.String? presenter,
    $48.Struct? claims,
    $core.Iterable<$core.String>? accessLevels,
  }) {
    final $result = create();
    if (principal != null) {
      $result.principal = principal;
    }
    if (audiences != null) {
      $result.audiences.addAll(audiences);
    }
    if (presenter != null) {
      $result.presenter = presenter;
    }
    if (claims != null) {
      $result.claims = claims;
    }
    if (accessLevels != null) {
      $result.accessLevels.addAll(accessLevels);
    }
    return $result;
  }
  AttributeContext_Auth._() : super();
  factory AttributeContext_Auth.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AttributeContext_Auth.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AttributeContext.Auth',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc.context'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'principal')
    ..pPS(2, _omitFieldNames ? '' : 'audiences')
    ..aOS(3, _omitFieldNames ? '' : 'presenter')
    ..aOM<$48.Struct>(4, _omitFieldNames ? '' : 'claims',
        subBuilder: $48.Struct.create)
    ..pPS(5, _omitFieldNames ? '' : 'accessLevels')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AttributeContext_Auth clone() =>
      AttributeContext_Auth()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AttributeContext_Auth copyWith(
          void Function(AttributeContext_Auth) updates) =>
      super.copyWith((message) => updates(message as AttributeContext_Auth))
          as AttributeContext_Auth;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AttributeContext_Auth create() => AttributeContext_Auth._();
  AttributeContext_Auth createEmptyInstance() => create();
  static $pb.PbList<AttributeContext_Auth> createRepeated() =>
      $pb.PbList<AttributeContext_Auth>();
  @$core.pragma('dart2js:noInline')
  static AttributeContext_Auth getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AttributeContext_Auth>(create);
  static AttributeContext_Auth? _defaultInstance;

  /// The authenticated principal. Reflects the issuer (`iss`) and subject
  /// (`sub`) claims within a JWT. The issuer and subject should be `/`
  /// delimited, with `/` percent-encoded within the subject fragment. For
  /// Google accounts, the principal format is:
  /// "https://accounts.google.com/{id}"
  @$pb.TagNumber(1)
  $core.String get principal => $_getSZ(0);
  @$pb.TagNumber(1)
  set principal($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPrincipal() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrincipal() => clearField(1);

  ///  The intended audience(s) for this authentication information. Reflects
  ///  the audience (`aud`) claim within a JWT. The audience
  ///  value(s) depends on the `issuer`, but typically include one or more of
  ///  the following pieces of information:
  ///
  ///  *  The services intended to receive the credential. For example,
  ///     ["https://pubsub.googleapis.com/", "https://storage.googleapis.com/"].
  ///  *  A set of service-based scopes. For example,
  ///     ["https://www.googleapis.com/auth/cloud-platform"].
  ///  *  The client id of an app, such as the Firebase project id for JWTs
  ///     from Firebase Auth.
  ///
  ///  Consult the documentation for the credential issuer to determine the
  ///  information provided.
  @$pb.TagNumber(2)
  $core.List<$core.String> get audiences => $_getList(1);

  /// The authorized presenter of the credential. Reflects the optional
  /// Authorized Presenter (`azp`) claim within a JWT or the
  /// OAuth client id. For example, a Google Cloud Platform client id looks
  /// as follows: "123456789012.apps.googleusercontent.com".
  @$pb.TagNumber(3)
  $core.String get presenter => $_getSZ(2);
  @$pb.TagNumber(3)
  set presenter($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPresenter() => $_has(2);
  @$pb.TagNumber(3)
  void clearPresenter() => clearField(3);

  ///  Structured claims presented with the credential. JWTs include
  ///  `{key: value}` pairs for standard and private claims. The following
  ///  is a subset of the standard required and optional claims that would
  ///  typically be presented for a Google-based JWT:
  ///
  ///     {'iss': 'accounts.google.com',
  ///      'sub': '113289723416554971153',
  ///      'aud': ['123456789012', 'pubsub.googleapis.com'],
  ///      'azp': '123456789012.apps.googleusercontent.com',
  ///      'email': 'jsmith@example.com',
  ///      'iat': 1353601026,
  ///      'exp': 1353604926}
  ///
  ///  SAML assertions are similarly specified, but with an identity provider
  ///  dependent structure.
  @$pb.TagNumber(4)
  $48.Struct get claims => $_getN(3);
  @$pb.TagNumber(4)
  set claims($48.Struct v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasClaims() => $_has(3);
  @$pb.TagNumber(4)
  void clearClaims() => clearField(4);
  @$pb.TagNumber(4)
  $48.Struct ensureClaims() => $_ensure(3);

  ///  A list of access level resource names that allow resources to be
  ///  accessed by authenticated requester. It is part of Secure GCP processing
  ///  for the incoming request. An access level string has the format:
  ///  "//{api_service_name}/accessPolicies/{policy_id}/accessLevels/{short_name}"
  ///
  ///  Example:
  ///  "//accesscontextmanager.googleapis.com/accessPolicies/MY_POLICY_ID/accessLevels/MY_LEVEL"
  @$pb.TagNumber(5)
  $core.List<$core.String> get accessLevels => $_getList(4);
}

/// This message defines attributes for an HTTP request. If the actual
/// request is not an HTTP request, the runtime system should try to map
/// the actual request to an equivalent HTTP request.
class AttributeContext_Request extends $pb.GeneratedMessage {
  factory AttributeContext_Request({
    $core.String? id,
    $core.String? method,
    $core.Map<$core.String, $core.String>? headers,
    $core.String? path,
    $core.String? host,
    $core.String? scheme,
    $core.String? query,
    $50.Timestamp? time,
    $fixnum.Int64? size,
    $core.String? protocol,
    $core.String? reason,
    AttributeContext_Auth? auth,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (method != null) {
      $result.method = method;
    }
    if (headers != null) {
      $result.headers.addAll(headers);
    }
    if (path != null) {
      $result.path = path;
    }
    if (host != null) {
      $result.host = host;
    }
    if (scheme != null) {
      $result.scheme = scheme;
    }
    if (query != null) {
      $result.query = query;
    }
    if (time != null) {
      $result.time = time;
    }
    if (size != null) {
      $result.size = size;
    }
    if (protocol != null) {
      $result.protocol = protocol;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (auth != null) {
      $result.auth = auth;
    }
    return $result;
  }
  AttributeContext_Request._() : super();
  factory AttributeContext_Request.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AttributeContext_Request.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AttributeContext.Request',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc.context'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'method')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'headers',
        entryClassName: 'AttributeContext.Request.HeadersEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.rpc.context'))
    ..aOS(4, _omitFieldNames ? '' : 'path')
    ..aOS(5, _omitFieldNames ? '' : 'host')
    ..aOS(6, _omitFieldNames ? '' : 'scheme')
    ..aOS(7, _omitFieldNames ? '' : 'query')
    ..aOM<$50.Timestamp>(9, _omitFieldNames ? '' : 'time',
        subBuilder: $50.Timestamp.create)
    ..aInt64(10, _omitFieldNames ? '' : 'size')
    ..aOS(11, _omitFieldNames ? '' : 'protocol')
    ..aOS(12, _omitFieldNames ? '' : 'reason')
    ..aOM<AttributeContext_Auth>(13, _omitFieldNames ? '' : 'auth',
        subBuilder: AttributeContext_Auth.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AttributeContext_Request clone() =>
      AttributeContext_Request()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AttributeContext_Request copyWith(
          void Function(AttributeContext_Request) updates) =>
      super.copyWith((message) => updates(message as AttributeContext_Request))
          as AttributeContext_Request;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AttributeContext_Request create() => AttributeContext_Request._();
  AttributeContext_Request createEmptyInstance() => create();
  static $pb.PbList<AttributeContext_Request> createRepeated() =>
      $pb.PbList<AttributeContext_Request>();
  @$core.pragma('dart2js:noInline')
  static AttributeContext_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AttributeContext_Request>(create);
  static AttributeContext_Request? _defaultInstance;

  /// The unique ID for a request, which can be propagated to downstream
  /// systems. The ID should have low probability of collision
  /// within a single day for a specific service.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  /// The HTTP request method, such as `GET`, `POST`.
  @$pb.TagNumber(2)
  $core.String get method => $_getSZ(1);
  @$pb.TagNumber(2)
  set method($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearMethod() => clearField(2);

  /// The HTTP request headers. If multiple headers share the same key, they
  /// must be merged according to the HTTP spec. All header keys must be
  /// lowercased, because HTTP header keys are case-insensitive.
  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get headers => $_getMap(2);

  /// The HTTP URL path, excluding the query parameters.
  @$pb.TagNumber(4)
  $core.String get path => $_getSZ(3);
  @$pb.TagNumber(4)
  set path($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPath() => $_has(3);
  @$pb.TagNumber(4)
  void clearPath() => clearField(4);

  /// The HTTP request `Host` header value.
  @$pb.TagNumber(5)
  $core.String get host => $_getSZ(4);
  @$pb.TagNumber(5)
  set host($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasHost() => $_has(4);
  @$pb.TagNumber(5)
  void clearHost() => clearField(5);

  /// The HTTP URL scheme, such as `http` and `https`.
  @$pb.TagNumber(6)
  $core.String get scheme => $_getSZ(5);
  @$pb.TagNumber(6)
  set scheme($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasScheme() => $_has(5);
  @$pb.TagNumber(6)
  void clearScheme() => clearField(6);

  /// The HTTP URL query in the format of `name1=value1&name2=value2`, as it
  /// appears in the first line of the HTTP request. No decoding is performed.
  @$pb.TagNumber(7)
  $core.String get query => $_getSZ(6);
  @$pb.TagNumber(7)
  set query($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasQuery() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuery() => clearField(7);

  /// The timestamp when the `destination` service receives the last byte of
  /// the request.
  @$pb.TagNumber(9)
  $50.Timestamp get time => $_getN(7);
  @$pb.TagNumber(9)
  set time($50.Timestamp v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasTime() => $_has(7);
  @$pb.TagNumber(9)
  void clearTime() => clearField(9);
  @$pb.TagNumber(9)
  $50.Timestamp ensureTime() => $_ensure(7);

  /// The HTTP request size in bytes. If unknown, it must be -1.
  @$pb.TagNumber(10)
  $fixnum.Int64 get size => $_getI64(8);
  @$pb.TagNumber(10)
  set size($fixnum.Int64 v) {
    $_setInt64(8, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasSize() => $_has(8);
  @$pb.TagNumber(10)
  void clearSize() => clearField(10);

  /// The network protocol used with the request, such as "http/1.1",
  /// "spdy/3", "h2", "h2c", "webrtc", "tcp", "udp", "quic". See
  /// https://www.iana.org/assignments/tls-extensiontype-values/tls-extensiontype-values.xhtml#alpn-protocol-ids
  /// for details.
  @$pb.TagNumber(11)
  $core.String get protocol => $_getSZ(9);
  @$pb.TagNumber(11)
  set protocol($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasProtocol() => $_has(9);
  @$pb.TagNumber(11)
  void clearProtocol() => clearField(11);

  /// A special parameter for request reason. It is used by security systems
  /// to associate auditing information with a request.
  @$pb.TagNumber(12)
  $core.String get reason => $_getSZ(10);
  @$pb.TagNumber(12)
  set reason($core.String v) {
    $_setString(10, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasReason() => $_has(10);
  @$pb.TagNumber(12)
  void clearReason() => clearField(12);

  /// The request authentication. May be absent for unauthenticated requests.
  /// Derived from the HTTP request `Authorization` header or equivalent.
  @$pb.TagNumber(13)
  AttributeContext_Auth get auth => $_getN(11);
  @$pb.TagNumber(13)
  set auth(AttributeContext_Auth v) {
    setField(13, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasAuth() => $_has(11);
  @$pb.TagNumber(13)
  void clearAuth() => clearField(13);
  @$pb.TagNumber(13)
  AttributeContext_Auth ensureAuth() => $_ensure(11);
}

/// This message defines attributes for a typical network response. It
/// generally models semantics of an HTTP response.
class AttributeContext_Response extends $pb.GeneratedMessage {
  factory AttributeContext_Response({
    $fixnum.Int64? code,
    $fixnum.Int64? size,
    $core.Map<$core.String, $core.String>? headers,
    $50.Timestamp? time,
    $51.Duration? backendLatency,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (size != null) {
      $result.size = size;
    }
    if (headers != null) {
      $result.headers.addAll(headers);
    }
    if (time != null) {
      $result.time = time;
    }
    if (backendLatency != null) {
      $result.backendLatency = backendLatency;
    }
    return $result;
  }
  AttributeContext_Response._() : super();
  factory AttributeContext_Response.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AttributeContext_Response.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AttributeContext.Response',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc.context'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'code')
    ..aInt64(2, _omitFieldNames ? '' : 'size')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'headers',
        entryClassName: 'AttributeContext.Response.HeadersEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.rpc.context'))
    ..aOM<$50.Timestamp>(4, _omitFieldNames ? '' : 'time',
        subBuilder: $50.Timestamp.create)
    ..aOM<$51.Duration>(5, _omitFieldNames ? '' : 'backendLatency',
        subBuilder: $51.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AttributeContext_Response clone() =>
      AttributeContext_Response()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AttributeContext_Response copyWith(
          void Function(AttributeContext_Response) updates) =>
      super.copyWith((message) => updates(message as AttributeContext_Response))
          as AttributeContext_Response;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AttributeContext_Response create() => AttributeContext_Response._();
  AttributeContext_Response createEmptyInstance() => create();
  static $pb.PbList<AttributeContext_Response> createRepeated() =>
      $pb.PbList<AttributeContext_Response>();
  @$core.pragma('dart2js:noInline')
  static AttributeContext_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AttributeContext_Response>(create);
  static AttributeContext_Response? _defaultInstance;

  /// The HTTP response status code, such as `200` and `404`.
  @$pb.TagNumber(1)
  $fixnum.Int64 get code => $_getI64(0);
  @$pb.TagNumber(1)
  set code($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  /// The HTTP response size in bytes. If unknown, it must be -1.
  @$pb.TagNumber(2)
  $fixnum.Int64 get size => $_getI64(1);
  @$pb.TagNumber(2)
  set size($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearSize() => clearField(2);

  /// The HTTP response headers. If multiple headers share the same key, they
  /// must be merged according to HTTP spec. All header keys must be
  /// lowercased, because HTTP header keys are case-insensitive.
  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get headers => $_getMap(2);

  /// The timestamp when the `destination` service sends the last byte of
  /// the response.
  @$pb.TagNumber(4)
  $50.Timestamp get time => $_getN(3);
  @$pb.TagNumber(4)
  set time($50.Timestamp v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearTime() => clearField(4);
  @$pb.TagNumber(4)
  $50.Timestamp ensureTime() => $_ensure(3);

  /// The amount of time it takes the backend service to fully respond to a
  /// request. Measured from when the destination service starts to send the
  /// request to the backend until when the destination service receives the
  /// complete response from the backend.
  @$pb.TagNumber(5)
  $51.Duration get backendLatency => $_getN(4);
  @$pb.TagNumber(5)
  set backendLatency($51.Duration v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasBackendLatency() => $_has(4);
  @$pb.TagNumber(5)
  void clearBackendLatency() => clearField(5);
  @$pb.TagNumber(5)
  $51.Duration ensureBackendLatency() => $_ensure(4);
}

/// This message defines core attributes for a resource. A resource is an
/// addressable (named) entity provided by the destination service. For
/// example, a file stored on a network storage service.
class AttributeContext_Resource extends $pb.GeneratedMessage {
  factory AttributeContext_Resource({
    $core.String? service,
    $core.String? name,
    $core.String? type,
    $core.Map<$core.String, $core.String>? labels,
    $core.String? uid,
    $core.Map<$core.String, $core.String>? annotations,
    $core.String? displayName,
    $50.Timestamp? createTime,
    $50.Timestamp? updateTime,
    $50.Timestamp? deleteTime,
    $core.String? etag,
    $core.String? location,
  }) {
    final $result = create();
    if (service != null) {
      $result.service = service;
    }
    if (name != null) {
      $result.name = name;
    }
    if (type != null) {
      $result.type = type;
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (uid != null) {
      $result.uid = uid;
    }
    if (annotations != null) {
      $result.annotations.addAll(annotations);
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (createTime != null) {
      $result.createTime = createTime;
    }
    if (updateTime != null) {
      $result.updateTime = updateTime;
    }
    if (deleteTime != null) {
      $result.deleteTime = deleteTime;
    }
    if (etag != null) {
      $result.etag = etag;
    }
    if (location != null) {
      $result.location = location;
    }
    return $result;
  }
  AttributeContext_Resource._() : super();
  factory AttributeContext_Resource.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AttributeContext_Resource.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AttributeContext.Resource',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc.context'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'service')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'labels',
        entryClassName: 'AttributeContext.Resource.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.rpc.context'))
    ..aOS(5, _omitFieldNames ? '' : 'uid')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'annotations',
        entryClassName: 'AttributeContext.Resource.AnnotationsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.rpc.context'))
    ..aOS(7, _omitFieldNames ? '' : 'displayName')
    ..aOM<$50.Timestamp>(8, _omitFieldNames ? '' : 'createTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(9, _omitFieldNames ? '' : 'updateTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(10, _omitFieldNames ? '' : 'deleteTime',
        subBuilder: $50.Timestamp.create)
    ..aOS(11, _omitFieldNames ? '' : 'etag')
    ..aOS(12, _omitFieldNames ? '' : 'location')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AttributeContext_Resource clone() =>
      AttributeContext_Resource()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AttributeContext_Resource copyWith(
          void Function(AttributeContext_Resource) updates) =>
      super.copyWith((message) => updates(message as AttributeContext_Resource))
          as AttributeContext_Resource;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AttributeContext_Resource create() => AttributeContext_Resource._();
  AttributeContext_Resource createEmptyInstance() => create();
  static $pb.PbList<AttributeContext_Resource> createRepeated() =>
      $pb.PbList<AttributeContext_Resource>();
  @$core.pragma('dart2js:noInline')
  static AttributeContext_Resource getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AttributeContext_Resource>(create);
  static AttributeContext_Resource? _defaultInstance;

  /// The name of the service that this resource belongs to, such as
  /// `pubsub.googleapis.com`. The service may be different from the DNS
  /// hostname that actually serves the request.
  @$pb.TagNumber(1)
  $core.String get service => $_getSZ(0);
  @$pb.TagNumber(1)
  set service($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasService() => $_has(0);
  @$pb.TagNumber(1)
  void clearService() => clearField(1);

  ///  The stable identifier (name) of a resource on the `service`. A resource
  ///  can be logically identified as "//{resource.service}/{resource.name}".
  ///  The differences between a resource name and a URI are:
  ///
  ///  *   Resource name is a logical identifier, independent of network
  ///      protocol and API version. For example,
  ///      `//pubsub.googleapis.com/projects/123/topics/news-feed`.
  ///  *   URI often includes protocol and version information, so it can
  ///      be used directly by applications. For example,
  ///      `https://pubsub.googleapis.com/v1/projects/123/topics/news-feed`.
  ///
  ///  See https://cloud.google.com/apis/design/resource_names for details.
  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  ///  The type of the resource. The syntax is platform-specific because
  ///  different platforms define their resources differently.
  ///
  ///  For Google APIs, the type format must be "{service}/{kind}", such as
  ///  "pubsub.googleapis.com/Topic".
  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  /// The labels or tags on the resource, such as AWS resource tags and
  /// Kubernetes resource labels.
  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get labels => $_getMap(3);

  /// The unique identifier of the resource. UID is unique in the time
  /// and space for this resource within the scope of the service. It is
  /// typically generated by the server on successful creation of a resource
  /// and must not be changed. UID is used to uniquely identify resources
  /// with resource name reuses. This should be a UUID4.
  @$pb.TagNumber(5)
  $core.String get uid => $_getSZ(4);
  @$pb.TagNumber(5)
  set uid($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasUid() => $_has(4);
  @$pb.TagNumber(5)
  void clearUid() => clearField(5);

  ///  Annotations is an unstructured key-value map stored with a resource that
  ///  may be set by external tools to store and retrieve arbitrary metadata.
  ///  They are not queryable and should be preserved when modifying objects.
  ///
  ///  More info: https://kubernetes.io/docs/user-guide/annotations
  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get annotations => $_getMap(5);

  /// Mutable. The display name set by clients. Must be <= 63 characters.
  @$pb.TagNumber(7)
  $core.String get displayName => $_getSZ(6);
  @$pb.TagNumber(7)
  set displayName($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasDisplayName() => $_has(6);
  @$pb.TagNumber(7)
  void clearDisplayName() => clearField(7);

  /// Output only. The timestamp when the resource was created. This may
  /// be either the time creation was initiated or when it was completed.
  @$pb.TagNumber(8)
  $50.Timestamp get createTime => $_getN(7);
  @$pb.TagNumber(8)
  set createTime($50.Timestamp v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasCreateTime() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreateTime() => clearField(8);
  @$pb.TagNumber(8)
  $50.Timestamp ensureCreateTime() => $_ensure(7);

  /// Output only. The timestamp when the resource was last updated. Any
  /// change to the resource made by users must refresh this value.
  /// Changes to a resource made by the service should refresh this value.
  @$pb.TagNumber(9)
  $50.Timestamp get updateTime => $_getN(8);
  @$pb.TagNumber(9)
  set updateTime($50.Timestamp v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasUpdateTime() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdateTime() => clearField(9);
  @$pb.TagNumber(9)
  $50.Timestamp ensureUpdateTime() => $_ensure(8);

  /// Output only. The timestamp when the resource was deleted.
  /// If the resource is not deleted, this must be empty.
  @$pb.TagNumber(10)
  $50.Timestamp get deleteTime => $_getN(9);
  @$pb.TagNumber(10)
  set deleteTime($50.Timestamp v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasDeleteTime() => $_has(9);
  @$pb.TagNumber(10)
  void clearDeleteTime() => clearField(10);
  @$pb.TagNumber(10)
  $50.Timestamp ensureDeleteTime() => $_ensure(9);

  /// Output only. An opaque value that uniquely identifies a version or
  /// generation of a resource. It can be used to confirm that the client
  /// and server agree on the ordering of a resource being written.
  @$pb.TagNumber(11)
  $core.String get etag => $_getSZ(10);
  @$pb.TagNumber(11)
  set etag($core.String v) {
    $_setString(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasEtag() => $_has(10);
  @$pb.TagNumber(11)
  void clearEtag() => clearField(11);

  ///  Immutable. The location of the resource. The location encoding is
  ///  specific to the service provider, and new encoding may be introduced
  ///  as the service evolves.
  ///
  ///  For Google Cloud products, the encoding is what is used by Google Cloud
  ///  APIs, such as `us-east1`, `aws-us-east-1`, and `azure-eastus2`. The
  ///  semantics of `location` is identical to the
  ///  `cloud.googleapis.com/location` label used by some Google Cloud APIs.
  @$pb.TagNumber(12)
  $core.String get location => $_getSZ(11);
  @$pb.TagNumber(12)
  set location($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasLocation() => $_has(11);
  @$pb.TagNumber(12)
  void clearLocation() => clearField(12);
}

///  This message defines the standard attribute vocabulary for Google APIs.
///
///  An attribute is a piece of metadata that describes an activity on a network
///  service. For example, the size of an HTTP request, or the status code of
///  an HTTP response.
///
///  Each attribute has a type and a name, which is logically defined as
///  a proto message field in `AttributeContext`. The field type becomes the
///  attribute type, and the field path becomes the attribute name. For example,
///  the attribute `source.ip` maps to field `AttributeContext.source.ip`.
///
///  This message definition is guaranteed not to have any wire breaking change.
///  So you can use it directly for passing attributes across different systems.
///
///  NOTE: Different system may generate different subset of attributes. Please
///  verify the system specification before relying on an attribute generated
///  a system.
class AttributeContext extends $pb.GeneratedMessage {
  factory AttributeContext({
    AttributeContext_Peer? source,
    AttributeContext_Peer? destination,
    AttributeContext_Request? request,
    AttributeContext_Response? response,
    AttributeContext_Resource? resource,
    AttributeContext_Api? api,
    AttributeContext_Peer? origin,
    $core.Iterable<$49.Any>? extensions,
  }) {
    final $result = create();
    if (source != null) {
      $result.source = source;
    }
    if (destination != null) {
      $result.destination = destination;
    }
    if (request != null) {
      $result.request = request;
    }
    if (response != null) {
      $result.response = response;
    }
    if (resource != null) {
      $result.resource = resource;
    }
    if (api != null) {
      $result.api = api;
    }
    if (origin != null) {
      $result.origin = origin;
    }
    if (extensions != null) {
      $result.extensions.addAll(extensions);
    }
    return $result;
  }
  AttributeContext._() : super();
  factory AttributeContext.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AttributeContext.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AttributeContext',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc.context'),
      createEmptyInstance: create)
    ..aOM<AttributeContext_Peer>(1, _omitFieldNames ? '' : 'source',
        subBuilder: AttributeContext_Peer.create)
    ..aOM<AttributeContext_Peer>(2, _omitFieldNames ? '' : 'destination',
        subBuilder: AttributeContext_Peer.create)
    ..aOM<AttributeContext_Request>(3, _omitFieldNames ? '' : 'request',
        subBuilder: AttributeContext_Request.create)
    ..aOM<AttributeContext_Response>(4, _omitFieldNames ? '' : 'response',
        subBuilder: AttributeContext_Response.create)
    ..aOM<AttributeContext_Resource>(5, _omitFieldNames ? '' : 'resource',
        subBuilder: AttributeContext_Resource.create)
    ..aOM<AttributeContext_Api>(6, _omitFieldNames ? '' : 'api',
        subBuilder: AttributeContext_Api.create)
    ..aOM<AttributeContext_Peer>(7, _omitFieldNames ? '' : 'origin',
        subBuilder: AttributeContext_Peer.create)
    ..pc<$49.Any>(8, _omitFieldNames ? '' : 'extensions', $pb.PbFieldType.PM,
        subBuilder: $49.Any.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AttributeContext clone() => AttributeContext()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AttributeContext copyWith(void Function(AttributeContext) updates) =>
      super.copyWith((message) => updates(message as AttributeContext))
          as AttributeContext;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AttributeContext create() => AttributeContext._();
  AttributeContext createEmptyInstance() => create();
  static $pb.PbList<AttributeContext> createRepeated() =>
      $pb.PbList<AttributeContext>();
  @$core.pragma('dart2js:noInline')
  static AttributeContext getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AttributeContext>(create);
  static AttributeContext? _defaultInstance;

  /// The source of a network activity, such as starting a TCP connection.
  /// In a multi hop network activity, the source represents the sender of the
  /// last hop.
  @$pb.TagNumber(1)
  AttributeContext_Peer get source => $_getN(0);
  @$pb.TagNumber(1)
  set source(AttributeContext_Peer v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearSource() => clearField(1);
  @$pb.TagNumber(1)
  AttributeContext_Peer ensureSource() => $_ensure(0);

  /// The destination of a network activity, such as accepting a TCP connection.
  /// In a multi hop network activity, the destination represents the receiver of
  /// the last hop.
  @$pb.TagNumber(2)
  AttributeContext_Peer get destination => $_getN(1);
  @$pb.TagNumber(2)
  set destination(AttributeContext_Peer v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDestination() => $_has(1);
  @$pb.TagNumber(2)
  void clearDestination() => clearField(2);
  @$pb.TagNumber(2)
  AttributeContext_Peer ensureDestination() => $_ensure(1);

  /// Represents a network request, such as an HTTP request.
  @$pb.TagNumber(3)
  AttributeContext_Request get request => $_getN(2);
  @$pb.TagNumber(3)
  set request(AttributeContext_Request v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRequest() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequest() => clearField(3);
  @$pb.TagNumber(3)
  AttributeContext_Request ensureRequest() => $_ensure(2);

  /// Represents a network response, such as an HTTP response.
  @$pb.TagNumber(4)
  AttributeContext_Response get response => $_getN(3);
  @$pb.TagNumber(4)
  set response(AttributeContext_Response v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasResponse() => $_has(3);
  @$pb.TagNumber(4)
  void clearResponse() => clearField(4);
  @$pb.TagNumber(4)
  AttributeContext_Response ensureResponse() => $_ensure(3);

  /// Represents a target resource that is involved with a network activity.
  /// If multiple resources are involved with an activity, this must be the
  /// primary one.
  @$pb.TagNumber(5)
  AttributeContext_Resource get resource => $_getN(4);
  @$pb.TagNumber(5)
  set resource(AttributeContext_Resource v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasResource() => $_has(4);
  @$pb.TagNumber(5)
  void clearResource() => clearField(5);
  @$pb.TagNumber(5)
  AttributeContext_Resource ensureResource() => $_ensure(4);

  /// Represents an API operation that is involved to a network activity.
  @$pb.TagNumber(6)
  AttributeContext_Api get api => $_getN(5);
  @$pb.TagNumber(6)
  set api(AttributeContext_Api v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasApi() => $_has(5);
  @$pb.TagNumber(6)
  void clearApi() => clearField(6);
  @$pb.TagNumber(6)
  AttributeContext_Api ensureApi() => $_ensure(5);

  /// The origin of a network activity. In a multi hop network activity,
  /// the origin represents the sender of the first hop. For the first hop,
  /// the `source` and the `origin` must have the same content.
  @$pb.TagNumber(7)
  AttributeContext_Peer get origin => $_getN(6);
  @$pb.TagNumber(7)
  set origin(AttributeContext_Peer v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasOrigin() => $_has(6);
  @$pb.TagNumber(7)
  void clearOrigin() => clearField(7);
  @$pb.TagNumber(7)
  AttributeContext_Peer ensureOrigin() => $_ensure(6);

  /// Supports extensions for advanced use cases, such as logs and metrics.
  @$pb.TagNumber(8)
  $core.List<$49.Any> get extensions => $_getList(7);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
