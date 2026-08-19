//
//  Generated code. Do not modify.
//  source: google/api/httpbody.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/any.pb.dart' as $49;

///  Message that represents an arbitrary HTTP body. It should only be used for
///  payload formats that can't be represented as JSON, such as raw binary or
///  an HTML page.
///
///
///  This message can be used both in streaming and non-streaming API methods in
///  the request as well as the response.
///
///  It can be used as a top-level request field, which is convenient if one
///  wants to extract parameters from either the URL or HTTP template into the
///  request fields and also want access to the raw HTTP body.
///
///  Example:
///
///      message GetResourceRequest {
///        // A unique request id.
///        string request_id = 1;
///
///        // The raw HTTP body is bound to this field.
///        google.api.HttpBody http_body = 2;
///
///      }
///
///      service ResourceService {
///        rpc GetResource(GetResourceRequest)
///          returns (google.api.HttpBody);
///        rpc UpdateResource(google.api.HttpBody)
///          returns (google.protobuf.Empty);
///
///      }
///
///  Example with streaming methods:
///
///      service CaldavService {
///        rpc GetCalendar(stream google.api.HttpBody)
///          returns (stream google.api.HttpBody);
///        rpc UpdateCalendar(stream google.api.HttpBody)
///          returns (stream google.api.HttpBody);
///
///      }
///
///  Use of this type only changes how the request and response bodies are
///  handled, all other features will continue to work unchanged.
class HttpBody extends $pb.GeneratedMessage {
  factory HttpBody({
    $core.String? contentType,
    $core.List<$core.int>? data,
    $core.Iterable<$49.Any>? extensions,
  }) {
    final $result = create();
    if (contentType != null) {
      $result.contentType = contentType;
    }
    if (data != null) {
      $result.data = data;
    }
    if (extensions != null) {
      $result.extensions.addAll(extensions);
    }
    return $result;
  }
  HttpBody._() : super();
  factory HttpBody.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory HttpBody.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HttpBody',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contentType')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..pc<$49.Any>(3, _omitFieldNames ? '' : 'extensions', $pb.PbFieldType.PM,
        subBuilder: $49.Any.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  HttpBody clone() => HttpBody()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  HttpBody copyWith(void Function(HttpBody) updates) =>
      super.copyWith((message) => updates(message as HttpBody)) as HttpBody;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HttpBody create() => HttpBody._();
  HttpBody createEmptyInstance() => create();
  static $pb.PbList<HttpBody> createRepeated() => $pb.PbList<HttpBody>();
  @$core.pragma('dart2js:noInline')
  static HttpBody getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HttpBody>(create);
  static HttpBody? _defaultInstance;

  /// The HTTP Content-Type header value specifying the content type of the body.
  @$pb.TagNumber(1)
  $core.String get contentType => $_getSZ(0);
  @$pb.TagNumber(1)
  set contentType($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasContentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearContentType() => clearField(1);

  /// The HTTP request/response body as raw binary.
  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);

  /// Application specific response metadata. Must be set in the first response
  /// for streaming APIs.
  @$pb.TagNumber(3)
  $core.List<$49.Any> get extensions => $_getList(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
