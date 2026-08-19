//
//  Generated code. Do not modify.
//  source: google/longrunning/operations.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/any.pb.dart' as $49;
import '../protobuf/duration.pb.dart' as $51;
import '../rpc/status.pb.dart' as $57;

enum Operation_Result { error, response, notSet }

/// This resource represents a long-running operation that is the result of a
/// network API call.
class Operation extends $pb.GeneratedMessage {
  factory Operation({
    $core.String? name,
    $49.Any? metadata,
    $core.bool? done,
    $57.Status? error,
    $49.Any? response,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (done != null) {
      $result.done = done;
    }
    if (error != null) {
      $result.error = error;
    }
    if (response != null) {
      $result.response = response;
    }
    return $result;
  }
  Operation._() : super();
  factory Operation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Operation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Operation_Result> _Operation_ResultByTag = {
    4: Operation_Result.error,
    5: Operation_Result.response,
    0: Operation_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Operation',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.longrunning'),
      createEmptyInstance: create)
    ..oo(0, [4, 5])
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<$49.Any>(2, _omitFieldNames ? '' : 'metadata',
        subBuilder: $49.Any.create)
    ..aOB(3, _omitFieldNames ? '' : 'done')
    ..aOM<$57.Status>(4, _omitFieldNames ? '' : 'error',
        subBuilder: $57.Status.create)
    ..aOM<$49.Any>(5, _omitFieldNames ? '' : 'response',
        subBuilder: $49.Any.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Operation clone() => Operation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Operation copyWith(void Function(Operation) updates) =>
      super.copyWith((message) => updates(message as Operation)) as Operation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Operation create() => Operation._();
  Operation createEmptyInstance() => create();
  static $pb.PbList<Operation> createRepeated() => $pb.PbList<Operation>();
  @$core.pragma('dart2js:noInline')
  static Operation getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Operation>(create);
  static Operation? _defaultInstance;

  Operation_Result whichResult() => _Operation_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  /// The server-assigned name, which is only unique within the same service that
  /// originally returns it. If you use the default HTTP mapping, the
  /// `name` should be a resource name ending with `operations/{unique_id}`.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  /// Service-specific metadata associated with the operation.  It typically
  /// contains progress information and common metadata such as create time.
  /// Some services might not provide such metadata.  Any method that returns a
  /// long-running operation should document the metadata type, if any.
  @$pb.TagNumber(2)
  $49.Any get metadata => $_getN(1);
  @$pb.TagNumber(2)
  set metadata($49.Any v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => clearField(2);
  @$pb.TagNumber(2)
  $49.Any ensureMetadata() => $_ensure(1);

  /// If the value is `false`, it means the operation is still in progress.
  /// If `true`, the operation is completed, and either `error` or `response` is
  /// available.
  @$pb.TagNumber(3)
  $core.bool get done => $_getBF(2);
  @$pb.TagNumber(3)
  set done($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDone() => $_has(2);
  @$pb.TagNumber(3)
  void clearDone() => clearField(3);

  /// The error result of the operation in case of failure or cancellation.
  @$pb.TagNumber(4)
  $57.Status get error => $_getN(3);
  @$pb.TagNumber(4)
  set error($57.Status v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasError() => $_has(3);
  @$pb.TagNumber(4)
  void clearError() => clearField(4);
  @$pb.TagNumber(4)
  $57.Status ensureError() => $_ensure(3);

  /// The normal response of the operation in case of success.  If the original
  /// method returns no data on success, such as `Delete`, the response is
  /// `google.protobuf.Empty`.  If the original method is standard
  /// `Get`/`Create`/`Update`, the response should be the resource.  For other
  /// methods, the response should have the type `XxxResponse`, where `Xxx`
  /// is the original method name.  For example, if the original method name
  /// is `TakeSnapshot()`, the inferred response type is
  /// `TakeSnapshotResponse`.
  @$pb.TagNumber(5)
  $49.Any get response => $_getN(4);
  @$pb.TagNumber(5)
  set response($49.Any v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasResponse() => $_has(4);
  @$pb.TagNumber(5)
  void clearResponse() => clearField(5);
  @$pb.TagNumber(5)
  $49.Any ensureResponse() => $_ensure(4);
}

/// The request message for [Operations.GetOperation][google.longrunning.Operations.GetOperation].
class GetOperationRequest extends $pb.GeneratedMessage {
  factory GetOperationRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetOperationRequest._() : super();
  factory GetOperationRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetOperationRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOperationRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.longrunning'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetOperationRequest clone() => GetOperationRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetOperationRequest copyWith(void Function(GetOperationRequest) updates) =>
      super.copyWith((message) => updates(message as GetOperationRequest))
          as GetOperationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOperationRequest create() => GetOperationRequest._();
  GetOperationRequest createEmptyInstance() => create();
  static $pb.PbList<GetOperationRequest> createRepeated() =>
      $pb.PbList<GetOperationRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOperationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOperationRequest>(create);
  static GetOperationRequest? _defaultInstance;

  /// The name of the operation resource.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

/// The request message for [Operations.ListOperations][google.longrunning.Operations.ListOperations].
class ListOperationsRequest extends $pb.GeneratedMessage {
  factory ListOperationsRequest({
    $core.String? filter,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.String? name,
  }) {
    final $result = create();
    if (filter != null) {
      $result.filter = filter;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  ListOperationsRequest._() : super();
  factory ListOperationsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListOperationsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListOperationsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.longrunning'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'filter')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListOperationsRequest clone() =>
      ListOperationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListOperationsRequest copyWith(
          void Function(ListOperationsRequest) updates) =>
      super.copyWith((message) => updates(message as ListOperationsRequest))
          as ListOperationsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListOperationsRequest create() => ListOperationsRequest._();
  ListOperationsRequest createEmptyInstance() => create();
  static $pb.PbList<ListOperationsRequest> createRepeated() =>
      $pb.PbList<ListOperationsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListOperationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListOperationsRequest>(create);
  static ListOperationsRequest? _defaultInstance;

  /// The standard list filter.
  @$pb.TagNumber(1)
  $core.String get filter => $_getSZ(0);
  @$pb.TagNumber(1)
  set filter($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);

  /// The standard list page size.
  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  /// The standard list page token.
  @$pb.TagNumber(3)
  $core.String get pageToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set pageToken($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPageToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageToken() => clearField(3);

  /// The name of the operation's parent resource.
  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => clearField(4);
}

/// The response message for [Operations.ListOperations][google.longrunning.Operations.ListOperations].
class ListOperationsResponse extends $pb.GeneratedMessage {
  factory ListOperationsResponse({
    $core.Iterable<Operation>? operations,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (operations != null) {
      $result.operations.addAll(operations);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListOperationsResponse._() : super();
  factory ListOperationsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListOperationsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListOperationsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.longrunning'),
      createEmptyInstance: create)
    ..pc<Operation>(1, _omitFieldNames ? '' : 'operations', $pb.PbFieldType.PM,
        subBuilder: Operation.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListOperationsResponse clone() =>
      ListOperationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListOperationsResponse copyWith(
          void Function(ListOperationsResponse) updates) =>
      super.copyWith((message) => updates(message as ListOperationsResponse))
          as ListOperationsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListOperationsResponse create() => ListOperationsResponse._();
  ListOperationsResponse createEmptyInstance() => create();
  static $pb.PbList<ListOperationsResponse> createRepeated() =>
      $pb.PbList<ListOperationsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListOperationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListOperationsResponse>(create);
  static ListOperationsResponse? _defaultInstance;

  /// A list of operations that matches the specified filter in the request.
  @$pb.TagNumber(1)
  $core.List<Operation> get operations => $_getList(0);

  /// The standard List next-page token.
  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);
}

/// The request message for [Operations.CancelOperation][google.longrunning.Operations.CancelOperation].
class CancelOperationRequest extends $pb.GeneratedMessage {
  factory CancelOperationRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  CancelOperationRequest._() : super();
  factory CancelOperationRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CancelOperationRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelOperationRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.longrunning'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CancelOperationRequest clone() =>
      CancelOperationRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CancelOperationRequest copyWith(
          void Function(CancelOperationRequest) updates) =>
      super.copyWith((message) => updates(message as CancelOperationRequest))
          as CancelOperationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelOperationRequest create() => CancelOperationRequest._();
  CancelOperationRequest createEmptyInstance() => create();
  static $pb.PbList<CancelOperationRequest> createRepeated() =>
      $pb.PbList<CancelOperationRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelOperationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelOperationRequest>(create);
  static CancelOperationRequest? _defaultInstance;

  /// The name of the operation resource to be cancelled.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

/// The request message for [Operations.DeleteOperation][google.longrunning.Operations.DeleteOperation].
class DeleteOperationRequest extends $pb.GeneratedMessage {
  factory DeleteOperationRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DeleteOperationRequest._() : super();
  factory DeleteOperationRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteOperationRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteOperationRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.longrunning'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteOperationRequest clone() =>
      DeleteOperationRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteOperationRequest copyWith(
          void Function(DeleteOperationRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteOperationRequest))
          as DeleteOperationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteOperationRequest create() => DeleteOperationRequest._();
  DeleteOperationRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteOperationRequest> createRepeated() =>
      $pb.PbList<DeleteOperationRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteOperationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteOperationRequest>(create);
  static DeleteOperationRequest? _defaultInstance;

  /// The name of the operation resource to be deleted.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

/// The request message for [Operations.WaitOperation][google.longrunning.Operations.WaitOperation].
class WaitOperationRequest extends $pb.GeneratedMessage {
  factory WaitOperationRequest({
    $core.String? name,
    $51.Duration? timeout,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (timeout != null) {
      $result.timeout = timeout;
    }
    return $result;
  }
  WaitOperationRequest._() : super();
  factory WaitOperationRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WaitOperationRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WaitOperationRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.longrunning'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<$51.Duration>(2, _omitFieldNames ? '' : 'timeout',
        subBuilder: $51.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  WaitOperationRequest clone() =>
      WaitOperationRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  WaitOperationRequest copyWith(void Function(WaitOperationRequest) updates) =>
      super.copyWith((message) => updates(message as WaitOperationRequest))
          as WaitOperationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WaitOperationRequest create() => WaitOperationRequest._();
  WaitOperationRequest createEmptyInstance() => create();
  static $pb.PbList<WaitOperationRequest> createRepeated() =>
      $pb.PbList<WaitOperationRequest>();
  @$core.pragma('dart2js:noInline')
  static WaitOperationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WaitOperationRequest>(create);
  static WaitOperationRequest? _defaultInstance;

  /// The name of the operation resource to wait on.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  /// The maximum duration to wait before timing out. If left blank, the wait
  /// will be at most the time permitted by the underlying HTTP/RPC protocol.
  /// If RPC context deadline is also specified, the shorter one will be used.
  @$pb.TagNumber(2)
  $51.Duration get timeout => $_getN(1);
  @$pb.TagNumber(2)
  set timeout($51.Duration v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTimeout() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimeout() => clearField(2);
  @$pb.TagNumber(2)
  $51.Duration ensureTimeout() => $_ensure(1);
}

///  A message representing the message types used by a long-running operation.
///
///  Example:
///
///    rpc LongRunningRecognize(LongRunningRecognizeRequest)
///        returns (google.longrunning.Operation) {
///      option (google.longrunning.operation_info) = {
///        response_type: "LongRunningRecognizeResponse"
///        metadata_type: "LongRunningRecognizeMetadata"
///      };
///    }
class OperationInfo extends $pb.GeneratedMessage {
  factory OperationInfo({
    $core.String? responseType,
    $core.String? metadataType,
  }) {
    final $result = create();
    if (responseType != null) {
      $result.responseType = responseType;
    }
    if (metadataType != null) {
      $result.metadataType = metadataType;
    }
    return $result;
  }
  OperationInfo._() : super();
  factory OperationInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OperationInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OperationInfo',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.longrunning'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'responseType')
    ..aOS(2, _omitFieldNames ? '' : 'metadataType')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OperationInfo clone() => OperationInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OperationInfo copyWith(void Function(OperationInfo) updates) =>
      super.copyWith((message) => updates(message as OperationInfo))
          as OperationInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OperationInfo create() => OperationInfo._();
  OperationInfo createEmptyInstance() => create();
  static $pb.PbList<OperationInfo> createRepeated() =>
      $pb.PbList<OperationInfo>();
  @$core.pragma('dart2js:noInline')
  static OperationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OperationInfo>(create);
  static OperationInfo? _defaultInstance;

  ///  Required. The message name of the primary return type for this
  ///  long-running operation.
  ///  This type will be used to deserialize the LRO's response.
  ///
  ///  If the response is in a different package from the rpc, a fully-qualified
  ///  message name must be used (e.g. `google.protobuf.Struct`).
  ///
  ///  Note: Altering this value constitutes a breaking change.
  @$pb.TagNumber(1)
  $core.String get responseType => $_getSZ(0);
  @$pb.TagNumber(1)
  set responseType($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResponseType() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseType() => clearField(1);

  ///  Required. The message name of the metadata type for this long-running
  ///  operation.
  ///
  ///  If the response is in a different package from the rpc, a fully-qualified
  ///  message name must be used (e.g. `google.protobuf.Struct`).
  ///
  ///  Note: Altering this value constitutes a breaking change.
  @$pb.TagNumber(2)
  $core.String get metadataType => $_getSZ(1);
  @$pb.TagNumber(2)
  set metadataType($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMetadataType() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadataType() => clearField(2);
}

class Operations {
  static final operationInfo = $pb.Extension<OperationInfo>(
      _omitMessageNames ? '' : 'google.protobuf.MethodOptions',
      _omitFieldNames ? '' : 'operationInfo',
      1049,
      $pb.PbFieldType.OM,
      defaultOrMaker: OperationInfo.getDefault,
      subBuilder: OperationInfo.create);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(operationInfo);
  }
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
