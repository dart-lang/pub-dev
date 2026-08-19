//
//  Generated code. Do not modify.
//  source: google/api/http.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Defines the HTTP configuration for an API service. It contains a list of
/// [HttpRule][google.api.HttpRule], each specifying the mapping of an RPC method
/// to one or more HTTP REST API methods.
class Http extends $pb.GeneratedMessage {
  factory Http({
    $core.Iterable<HttpRule>? rules,
    $core.bool? fullyDecodeReservedExpansion,
  }) {
    final $result = create();
    if (rules != null) {
      $result.rules.addAll(rules);
    }
    if (fullyDecodeReservedExpansion != null) {
      $result.fullyDecodeReservedExpansion = fullyDecodeReservedExpansion;
    }
    return $result;
  }
  Http._() : super();
  factory Http.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Http.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Http',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pc<HttpRule>(1, _omitFieldNames ? '' : 'rules', $pb.PbFieldType.PM,
        subBuilder: HttpRule.create)
    ..aOB(2, _omitFieldNames ? '' : 'fullyDecodeReservedExpansion')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Http clone() => Http()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Http copyWith(void Function(Http) updates) =>
      super.copyWith((message) => updates(message as Http)) as Http;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Http create() => Http._();
  Http createEmptyInstance() => create();
  static $pb.PbList<Http> createRepeated() => $pb.PbList<Http>();
  @$core.pragma('dart2js:noInline')
  static Http getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Http>(create);
  static Http? _defaultInstance;

  ///  A list of HTTP configuration rules that apply to individual API methods.
  ///
  ///  **NOTE:** All service configuration rules follow "last one wins" order.
  @$pb.TagNumber(1)
  $core.List<HttpRule> get rules => $_getList(0);

  ///  When set to true, URL path parameters will be fully URI-decoded except in
  ///  cases of single segment matches in reserved expansion, where "%2F" will be
  ///  left encoded.
  ///
  ///  The default behavior is to not decode RFC 6570 reserved characters in multi
  ///  segment matches.
  @$pb.TagNumber(2)
  $core.bool get fullyDecodeReservedExpansion => $_getBF(1);
  @$pb.TagNumber(2)
  set fullyDecodeReservedExpansion($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFullyDecodeReservedExpansion() => $_has(1);
  @$pb.TagNumber(2)
  void clearFullyDecodeReservedExpansion() => clearField(2);
}

enum HttpRule_Pattern { get, put, post, delete, patch, custom, notSet }

///  gRPC Transcoding
///
///  gRPC Transcoding is a feature for mapping between a gRPC method and one or
///  more HTTP REST endpoints. It allows developers to build a single API service
///  that supports both gRPC APIs and REST APIs. Many systems, including [Google
///  APIs](https://github.com/googleapis/googleapis),
///  [Cloud Endpoints](https://cloud.google.com/endpoints), [gRPC
///  Gateway](https://github.com/grpc-ecosystem/grpc-gateway),
///  and [Envoy](https://github.com/envoyproxy/envoy) proxy support this feature
///  and use it for large scale production services.
///
///  `HttpRule` defines the schema of the gRPC/REST mapping. The mapping specifies
///  how different portions of the gRPC request message are mapped to the URL
///  path, URL query parameters, and HTTP request body. It also controls how the
///  gRPC response message is mapped to the HTTP response body. `HttpRule` is
///  typically specified as an `google.api.http` annotation on the gRPC method.
///
///  Each mapping specifies a URL path template and an HTTP method. The path
///  template may refer to one or more fields in the gRPC request message, as long
///  as each field is a non-repeated field with a primitive (non-message) type.
///  The path template controls how fields of the request message are mapped to
///  the URL path.
///
///  Example:
///
///      service Messaging {
///        rpc GetMessage(GetMessageRequest) returns (Message) {
///          option (google.api.http) = {
///              get: "/v1/{name=messages/*}"
///          };
///        }
///      }
///      message GetMessageRequest {
///        string name = 1; // Mapped to URL path.
///      }
///      message Message {
///        string text = 1; // The resource content.
///      }
///
///  This enables an HTTP REST to gRPC mapping as below:
///
///  - HTTP: `GET /v1/messages/123456`
///  - gRPC: `GetMessage(name: "messages/123456")`
///
///  Any fields in the request message which are not bound by the path template
///  automatically become HTTP query parameters if there is no HTTP request body.
///  For example:
///
///      service Messaging {
///        rpc GetMessage(GetMessageRequest) returns (Message) {
///          option (google.api.http) = {
///              get:"/v1/messages/{message_id}"
///          };
///        }
///      }
///      message GetMessageRequest {
///        message SubMessage {
///          string subfield = 1;
///        }
///        string message_id = 1; // Mapped to URL path.
///        int64 revision = 2;    // Mapped to URL query parameter `revision`.
///        SubMessage sub = 3;    // Mapped to URL query parameter `sub.subfield`.
///      }
///
///  This enables a HTTP JSON to RPC mapping as below:
///
///  - HTTP: `GET /v1/messages/123456?revision=2&sub.subfield=foo`
///  - gRPC: `GetMessage(message_id: "123456" revision: 2 sub:
///  SubMessage(subfield: "foo"))`
///
///  Note that fields which are mapped to URL query parameters must have a
///  primitive type or a repeated primitive type or a non-repeated message type.
///  In the case of a repeated type, the parameter can be repeated in the URL
///  as `...?param=A&param=B`. In the case of a message type, each field of the
///  message is mapped to a separate parameter, such as
///  `...?foo.a=A&foo.b=B&foo.c=C`.
///
///  For HTTP methods that allow a request body, the `body` field
///  specifies the mapping. Consider a REST update method on the
///  message resource collection:
///
///      service Messaging {
///        rpc UpdateMessage(UpdateMessageRequest) returns (Message) {
///          option (google.api.http) = {
///            patch: "/v1/messages/{message_id}"
///            body: "message"
///          };
///        }
///      }
///      message UpdateMessageRequest {
///        string message_id = 1; // mapped to the URL
///        Message message = 2;   // mapped to the body
///      }
///
///  The following HTTP JSON to RPC mapping is enabled, where the
///  representation of the JSON in the request body is determined by
///  protos JSON encoding:
///
///  - HTTP: `PATCH /v1/messages/123456 { "text": "Hi!" }`
///  - gRPC: `UpdateMessage(message_id: "123456" message { text: "Hi!" })`
///
///  The special name `*` can be used in the body mapping to define that
///  every field not bound by the path template should be mapped to the
///  request body.  This enables the following alternative definition of
///  the update method:
///
///      service Messaging {
///        rpc UpdateMessage(Message) returns (Message) {
///          option (google.api.http) = {
///            patch: "/v1/messages/{message_id}"
///            body: "*"
///          };
///        }
///      }
///      message Message {
///        string message_id = 1;
///        string text = 2;
///      }
///
///
///  The following HTTP JSON to RPC mapping is enabled:
///
///  - HTTP: `PATCH /v1/messages/123456 { "text": "Hi!" }`
///  - gRPC: `UpdateMessage(message_id: "123456" text: "Hi!")`
///
///  Note that when using `*` in the body mapping, it is not possible to
///  have HTTP parameters, as all fields not bound by the path end in
///  the body. This makes this option more rarely used in practice when
///  defining REST APIs. The common usage of `*` is in custom methods
///  which don't use the URL at all for transferring data.
///
///  It is possible to define multiple HTTP methods for one RPC by using
///  the `additional_bindings` option. Example:
///
///      service Messaging {
///        rpc GetMessage(GetMessageRequest) returns (Message) {
///          option (google.api.http) = {
///            get: "/v1/messages/{message_id}"
///            additional_bindings {
///              get: "/v1/users/{user_id}/messages/{message_id}"
///            }
///          };
///        }
///      }
///      message GetMessageRequest {
///        string message_id = 1;
///        string user_id = 2;
///      }
///
///  This enables the following two alternative HTTP JSON to RPC mappings:
///
///  - HTTP: `GET /v1/messages/123456`
///  - gRPC: `GetMessage(message_id: "123456")`
///
///  - HTTP: `GET /v1/users/me/messages/123456`
///  - gRPC: `GetMessage(user_id: "me" message_id: "123456")`
///
///  Rules for HTTP mapping
///
///  1. Leaf request fields (recursive expansion nested messages in the request
///     message) are classified into three categories:
///     - Fields referred by the path template. They are passed via the URL path.
///     - Fields referred by the [HttpRule.body][google.api.HttpRule.body]. They
///     are passed via the HTTP
///       request body.
///     - All other fields are passed via the URL query parameters, and the
///       parameter name is the field path in the request message. A repeated
///       field can be represented as multiple query parameters under the same
///       name.
///   2. If [HttpRule.body][google.api.HttpRule.body] is "*", there is no URL
///   query parameter, all fields
///      are passed via URL path and HTTP request body.
///   3. If [HttpRule.body][google.api.HttpRule.body] is omitted, there is no HTTP
///   request body, all
///      fields are passed via URL path and URL query parameters.
///
///  Path template syntax
///
///      Template = "/" Segments [ Verb ] ;
///      Segments = Segment { "/" Segment } ;
///      Segment  = "*" | "**" | LITERAL | Variable ;
///      Variable = "{" FieldPath [ "=" Segments ] "}" ;
///      FieldPath = IDENT { "." IDENT } ;
///      Verb     = ":" LITERAL ;
///
///  The syntax `*` matches a single URL path segment. The syntax `**` matches
///  zero or more URL path segments, which must be the last part of the URL path
///  except the `Verb`.
///
///  The syntax `Variable` matches part of the URL path as specified by its
///  template. A variable template must not contain other variables. If a variable
///  matches a single path segment, its template may be omitted, e.g. `{var}`
///  is equivalent to `{var=*}`.
///
///  The syntax `LITERAL` matches literal text in the URL path. If the `LITERAL`
///  contains any reserved character, such characters should be percent-encoded
///  before the matching.
///
///  If a variable contains exactly one path segment, such as `"{var}"` or
///  `"{var=*}"`, when such a variable is expanded into a URL path on the client
///  side, all characters except `[-_.~0-9a-zA-Z]` are percent-encoded. The
///  server side does the reverse decoding. Such variables show up in the
///  [Discovery
///  Document](https://developers.google.com/discovery/v1/reference/apis) as
///  `{var}`.
///
///  If a variable contains multiple path segments, such as `"{var=foo/*}"`
///  or `"{var=**}"`, when such a variable is expanded into a URL path on the
///  client side, all characters except `[-_.~/0-9a-zA-Z]` are percent-encoded.
///  The server side does the reverse decoding, except "%2F" and "%2f" are left
///  unchanged. Such variables show up in the
///  [Discovery
///  Document](https://developers.google.com/discovery/v1/reference/apis) as
///  `{+var}`.
///
///  Using gRPC API Service Configuration
///
///  gRPC API Service Configuration (service config) is a configuration language
///  for configuring a gRPC service to become a user-facing product. The
///  service config is simply the YAML representation of the `google.api.Service`
///  proto message.
///
///  As an alternative to annotating your proto file, you can configure gRPC
///  transcoding in your service config YAML files. You do this by specifying a
///  `HttpRule` that maps the gRPC method to a REST endpoint, achieving the same
///  effect as the proto annotation. This can be particularly useful if you
///  have a proto that is reused in multiple services. Note that any transcoding
///  specified in the service config will override any matching transcoding
///  configuration in the proto.
///
///  The following example selects a gRPC method and applies an `HttpRule` to it:
///
///      http:
///        rules:
///          - selector: example.v1.Messaging.GetMessage
///            get: /v1/messages/{message_id}/{sub.subfield}
///
///  Special notes
///
///  When gRPC Transcoding is used to map a gRPC to JSON REST endpoints, the
///  proto to JSON conversion must follow the [proto3
///  specification](https://developers.google.com/protocol-buffers/docs/proto3#json).
///
///  While the single segment variable follows the semantics of
///  [RFC 6570](https://tools.ietf.org/html/rfc6570) Section 3.2.2 Simple String
///  Expansion, the multi segment variable **does not** follow RFC 6570 Section
///  3.2.3 Reserved Expansion. The reason is that the Reserved Expansion
///  does not expand special characters like `?` and `#`, which would lead
///  to invalid URLs. As the result, gRPC Transcoding uses a custom encoding
///  for multi segment variables.
///
///  The path variables **must not** refer to any repeated or mapped field,
///  because client libraries are not capable of handling such variable expansion.
///
///  The path variables **must not** capture the leading "/" character. The reason
///  is that the most common use case "{var}" does not capture the leading "/"
///  character. For consistency, all path variables must share the same behavior.
///
///  Repeated message fields must not be mapped to URL query parameters, because
///  no client library can support such complicated mapping.
///
///  If an API needs to use a JSON array for request or response body, it can map
///  the request or response body to a repeated field. However, some gRPC
///  Transcoding implementations may not support this feature.
class HttpRule extends $pb.GeneratedMessage {
  factory HttpRule({
    $core.String? selector,
    $core.String? get,
    $core.String? put,
    $core.String? post,
    $core.String? delete,
    $core.String? patch,
    $core.String? body,
    CustomHttpPattern? custom,
    $core.Iterable<HttpRule>? additionalBindings,
    $core.String? responseBody,
  }) {
    final $result = create();
    if (selector != null) {
      $result.selector = selector;
    }
    if (get != null) {
      $result.get = get;
    }
    if (put != null) {
      $result.put = put;
    }
    if (post != null) {
      $result.post = post;
    }
    if (delete != null) {
      $result.delete = delete;
    }
    if (patch != null) {
      $result.patch = patch;
    }
    if (body != null) {
      $result.body = body;
    }
    if (custom != null) {
      $result.custom = custom;
    }
    if (additionalBindings != null) {
      $result.additionalBindings.addAll(additionalBindings);
    }
    if (responseBody != null) {
      $result.responseBody = responseBody;
    }
    return $result;
  }
  HttpRule._() : super();
  factory HttpRule.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory HttpRule.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, HttpRule_Pattern> _HttpRule_PatternByTag = {
    2: HttpRule_Pattern.get,
    3: HttpRule_Pattern.put,
    4: HttpRule_Pattern.post,
    5: HttpRule_Pattern.delete,
    6: HttpRule_Pattern.patch,
    8: HttpRule_Pattern.custom,
    0: HttpRule_Pattern.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HttpRule',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5, 6, 8])
    ..aOS(1, _omitFieldNames ? '' : 'selector')
    ..aOS(2, _omitFieldNames ? '' : 'get')
    ..aOS(3, _omitFieldNames ? '' : 'put')
    ..aOS(4, _omitFieldNames ? '' : 'post')
    ..aOS(5, _omitFieldNames ? '' : 'delete')
    ..aOS(6, _omitFieldNames ? '' : 'patch')
    ..aOS(7, _omitFieldNames ? '' : 'body')
    ..aOM<CustomHttpPattern>(8, _omitFieldNames ? '' : 'custom',
        subBuilder: CustomHttpPattern.create)
    ..pc<HttpRule>(
        11, _omitFieldNames ? '' : 'additionalBindings', $pb.PbFieldType.PM,
        subBuilder: HttpRule.create)
    ..aOS(12, _omitFieldNames ? '' : 'responseBody')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  HttpRule clone() => HttpRule()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  HttpRule copyWith(void Function(HttpRule) updates) =>
      super.copyWith((message) => updates(message as HttpRule)) as HttpRule;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HttpRule create() => HttpRule._();
  HttpRule createEmptyInstance() => create();
  static $pb.PbList<HttpRule> createRepeated() => $pb.PbList<HttpRule>();
  @$core.pragma('dart2js:noInline')
  static HttpRule getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HttpRule>(create);
  static HttpRule? _defaultInstance;

  HttpRule_Pattern whichPattern() => _HttpRule_PatternByTag[$_whichOneof(0)]!;
  void clearPattern() => clearField($_whichOneof(0));

  ///  Selects a method to which this rule applies.
  ///
  ///  Refer to [selector][google.api.DocumentationRule.selector] for syntax
  ///  details.
  @$pb.TagNumber(1)
  $core.String get selector => $_getSZ(0);
  @$pb.TagNumber(1)
  set selector($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSelector() => $_has(0);
  @$pb.TagNumber(1)
  void clearSelector() => clearField(1);

  /// Maps to HTTP GET. Used for listing and getting information about
  /// resources.
  @$pb.TagNumber(2)
  $core.String get get => $_getSZ(1);
  @$pb.TagNumber(2)
  set get($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasGet() => $_has(1);
  @$pb.TagNumber(2)
  void clearGet() => clearField(2);

  /// Maps to HTTP PUT. Used for replacing a resource.
  @$pb.TagNumber(3)
  $core.String get put => $_getSZ(2);
  @$pb.TagNumber(3)
  set put($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPut() => $_has(2);
  @$pb.TagNumber(3)
  void clearPut() => clearField(3);

  /// Maps to HTTP POST. Used for creating a resource or performing an action.
  @$pb.TagNumber(4)
  $core.String get post => $_getSZ(3);
  @$pb.TagNumber(4)
  set post($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPost() => $_has(3);
  @$pb.TagNumber(4)
  void clearPost() => clearField(4);

  /// Maps to HTTP DELETE. Used for deleting a resource.
  @$pb.TagNumber(5)
  $core.String get delete => $_getSZ(4);
  @$pb.TagNumber(5)
  set delete($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDelete() => $_has(4);
  @$pb.TagNumber(5)
  void clearDelete() => clearField(5);

  /// Maps to HTTP PATCH. Used for updating a resource.
  @$pb.TagNumber(6)
  $core.String get patch => $_getSZ(5);
  @$pb.TagNumber(6)
  set patch($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasPatch() => $_has(5);
  @$pb.TagNumber(6)
  void clearPatch() => clearField(6);

  ///  The name of the request field whose value is mapped to the HTTP request
  ///  body, or `*` for mapping all request fields not captured by the path
  ///  pattern to the HTTP body, or omitted for not having any HTTP request body.
  ///
  ///  NOTE: the referred field must be present at the top-level of the request
  ///  message type.
  @$pb.TagNumber(7)
  $core.String get body => $_getSZ(6);
  @$pb.TagNumber(7)
  set body($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasBody() => $_has(6);
  @$pb.TagNumber(7)
  void clearBody() => clearField(7);

  /// The custom pattern is used for specifying an HTTP method that is not
  /// included in the `pattern` field, such as HEAD, or "*" to leave the
  /// HTTP method unspecified for this rule. The wild-card rule is useful
  /// for services that provide content to Web (HTML) clients.
  @$pb.TagNumber(8)
  CustomHttpPattern get custom => $_getN(7);
  @$pb.TagNumber(8)
  set custom(CustomHttpPattern v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasCustom() => $_has(7);
  @$pb.TagNumber(8)
  void clearCustom() => clearField(8);
  @$pb.TagNumber(8)
  CustomHttpPattern ensureCustom() => $_ensure(7);

  /// Additional HTTP bindings for the selector. Nested bindings must
  /// not contain an `additional_bindings` field themselves (that is,
  /// the nesting may only be one level deep).
  @$pb.TagNumber(11)
  $core.List<HttpRule> get additionalBindings => $_getList(8);

  ///  Optional. The name of the response field whose value is mapped to the HTTP
  ///  response body. When omitted, the entire response message will be used
  ///  as the HTTP response body.
  ///
  ///  NOTE: The referred field must be present at the top-level of the response
  ///  message type.
  @$pb.TagNumber(12)
  $core.String get responseBody => $_getSZ(9);
  @$pb.TagNumber(12)
  set responseBody($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasResponseBody() => $_has(9);
  @$pb.TagNumber(12)
  void clearResponseBody() => clearField(12);
}

/// A custom pattern is used for defining custom HTTP verb.
class CustomHttpPattern extends $pb.GeneratedMessage {
  factory CustomHttpPattern({
    $core.String? kind,
    $core.String? path,
  }) {
    final $result = create();
    if (kind != null) {
      $result.kind = kind;
    }
    if (path != null) {
      $result.path = path;
    }
    return $result;
  }
  CustomHttpPattern._() : super();
  factory CustomHttpPattern.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CustomHttpPattern.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CustomHttpPattern',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'kind')
    ..aOS(2, _omitFieldNames ? '' : 'path')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CustomHttpPattern clone() => CustomHttpPattern()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CustomHttpPattern copyWith(void Function(CustomHttpPattern) updates) =>
      super.copyWith((message) => updates(message as CustomHttpPattern))
          as CustomHttpPattern;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomHttpPattern create() => CustomHttpPattern._();
  CustomHttpPattern createEmptyInstance() => create();
  static $pb.PbList<CustomHttpPattern> createRepeated() =>
      $pb.PbList<CustomHttpPattern>();
  @$core.pragma('dart2js:noInline')
  static CustomHttpPattern getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CustomHttpPattern>(create);
  static CustomHttpPattern? _defaultInstance;

  /// The name of this custom HTTP verb.
  @$pb.TagNumber(1)
  $core.String get kind => $_getSZ(0);
  @$pb.TagNumber(1)
  set kind($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => clearField(1);

  /// The path matched by this custom verb.
  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
