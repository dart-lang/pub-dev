//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/quota_controller.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../rpc/status.pb.dart' as $57;
import 'metric_value.pb.dart' as $109;
import 'quota_controller.pbenum.dart';

export 'quota_controller.pbenum.dart';

/// Request message for the AllocateQuota method.
class AllocateQuotaRequest extends $pb.GeneratedMessage {
  factory AllocateQuotaRequest({
    $core.String? serviceName,
    QuotaOperation? allocateOperation,
    $core.String? serviceConfigId,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (allocateOperation != null) {
      $result.allocateOperation = allocateOperation;
    }
    if (serviceConfigId != null) {
      $result.serviceConfigId = serviceConfigId;
    }
    return $result;
  }
  AllocateQuotaRequest._() : super();
  factory AllocateQuotaRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AllocateQuotaRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AllocateQuotaRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOM<QuotaOperation>(2, _omitFieldNames ? '' : 'allocateOperation',
        subBuilder: QuotaOperation.create)
    ..aOS(4, _omitFieldNames ? '' : 'serviceConfigId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AllocateQuotaRequest clone() =>
      AllocateQuotaRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AllocateQuotaRequest copyWith(void Function(AllocateQuotaRequest) updates) =>
      super.copyWith((message) => updates(message as AllocateQuotaRequest))
          as AllocateQuotaRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AllocateQuotaRequest create() => AllocateQuotaRequest._();
  AllocateQuotaRequest createEmptyInstance() => create();
  static $pb.PbList<AllocateQuotaRequest> createRepeated() =>
      $pb.PbList<AllocateQuotaRequest>();
  @$core.pragma('dart2js:noInline')
  static AllocateQuotaRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AllocateQuotaRequest>(create);
  static AllocateQuotaRequest? _defaultInstance;

  ///  Name of the service as specified in the service configuration. For example,
  ///  `"pubsub.googleapis.com"`.
  ///
  ///  See [google.api.Service][google.api.Service] for the definition of a service name.
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);

  /// Operation that describes the quota allocation.
  @$pb.TagNumber(2)
  QuotaOperation get allocateOperation => $_getN(1);
  @$pb.TagNumber(2)
  set allocateOperation(QuotaOperation v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasAllocateOperation() => $_has(1);
  @$pb.TagNumber(2)
  void clearAllocateOperation() => clearField(2);
  @$pb.TagNumber(2)
  QuotaOperation ensureAllocateOperation() => $_ensure(1);

  /// Specifies which version of service configuration should be used to process
  /// the request. If unspecified or no matching version can be found, the latest
  /// one will be used.
  @$pb.TagNumber(4)
  $core.String get serviceConfigId => $_getSZ(2);
  @$pb.TagNumber(4)
  set serviceConfigId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasServiceConfigId() => $_has(2);
  @$pb.TagNumber(4)
  void clearServiceConfigId() => clearField(4);
}

/// Represents information regarding a quota operation.
class QuotaOperation extends $pb.GeneratedMessage {
  factory QuotaOperation({
    $core.String? operationId,
    $core.String? methodName,
    $core.String? consumerId,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$109.MetricValueSet>? quotaMetrics,
    QuotaOperation_QuotaMode? quotaMode,
  }) {
    final $result = create();
    if (operationId != null) {
      $result.operationId = operationId;
    }
    if (methodName != null) {
      $result.methodName = methodName;
    }
    if (consumerId != null) {
      $result.consumerId = consumerId;
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (quotaMetrics != null) {
      $result.quotaMetrics.addAll(quotaMetrics);
    }
    if (quotaMode != null) {
      $result.quotaMode = quotaMode;
    }
    return $result;
  }
  QuotaOperation._() : super();
  factory QuotaOperation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaOperation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuotaOperation',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'operationId')
    ..aOS(2, _omitFieldNames ? '' : 'methodName')
    ..aOS(3, _omitFieldNames ? '' : 'consumerId')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'labels',
        entryClassName: 'QuotaOperation.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api.servicecontrol.v1'))
    ..pc<$109.MetricValueSet>(
        5, _omitFieldNames ? '' : 'quotaMetrics', $pb.PbFieldType.PM,
        subBuilder: $109.MetricValueSet.create)
    ..e<QuotaOperation_QuotaMode>(
        6, _omitFieldNames ? '' : 'quotaMode', $pb.PbFieldType.OE,
        defaultOrMaker: QuotaOperation_QuotaMode.UNSPECIFIED,
        valueOf: QuotaOperation_QuotaMode.valueOf,
        enumValues: QuotaOperation_QuotaMode.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaOperation clone() => QuotaOperation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaOperation copyWith(void Function(QuotaOperation) updates) =>
      super.copyWith((message) => updates(message as QuotaOperation))
          as QuotaOperation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuotaOperation create() => QuotaOperation._();
  QuotaOperation createEmptyInstance() => create();
  static $pb.PbList<QuotaOperation> createRepeated() =>
      $pb.PbList<QuotaOperation>();
  @$core.pragma('dart2js:noInline')
  static QuotaOperation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaOperation>(create);
  static QuotaOperation? _defaultInstance;

  ///  Identity of the operation. This is expected to be unique within the scope
  ///  of the service that generated the operation, and guarantees idempotency in
  ///  case of retries.
  ///
  ///  In order to ensure best performance and latency in the Quota backends,
  ///  operation_ids are optimally associated with time, so that related
  ///  operations can be accessed fast in storage. For this reason, the
  ///  recommended token for services that intend to operate at a high QPS is
  ///  Unix time in nanos + UUID
  @$pb.TagNumber(1)
  $core.String get operationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set operationId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasOperationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOperationId() => clearField(1);

  ///  Fully qualified name of the API method for which this quota operation is
  ///  requested. This name is used for matching quota rules or metric rules and
  ///  billing status rules defined in service configuration.
  ///
  ///  This field should not be set if any of the following is true:
  ///  (1) the quota operation is performed on non-API resources.
  ///  (2) quota_metrics is set because the caller is doing quota override.
  ///
  ///
  ///  Example of an RPC method name:
  ///      google.example.library.v1.LibraryService.CreateShelf
  @$pb.TagNumber(2)
  $core.String get methodName => $_getSZ(1);
  @$pb.TagNumber(2)
  set methodName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMethodName() => $_has(1);
  @$pb.TagNumber(2)
  void clearMethodName() => clearField(2);

  ///  Identity of the consumer for whom this quota operation is being performed.
  ///
  ///  This can be in one of the following formats:
  ///    project:<project_id>,
  ///    project_number:<project_number>,
  ///    api_key:<api_key>.
  @$pb.TagNumber(3)
  $core.String get consumerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set consumerId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasConsumerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearConsumerId() => clearField(3);

  /// Labels describing the operation.
  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get labels => $_getMap(3);

  ///  Represents information about this operation. Each MetricValueSet
  ///  corresponds to a metric defined in the service configuration.
  ///  The data type used in the MetricValueSet must agree with
  ///  the data type specified in the metric definition.
  ///
  ///  Within a single operation, it is not allowed to have more than one
  ///  MetricValue instances that have the same metric names and identical
  ///  label value combinations. If a request has such duplicated MetricValue
  ///  instances, the entire request is rejected with
  ///  an invalid argument error.
  ///
  ///  This field is mutually exclusive with method_name.
  @$pb.TagNumber(5)
  $core.List<$109.MetricValueSet> get quotaMetrics => $_getList(4);

  /// Quota mode for this operation.
  @$pb.TagNumber(6)
  QuotaOperation_QuotaMode get quotaMode => $_getN(5);
  @$pb.TagNumber(6)
  set quotaMode(QuotaOperation_QuotaMode v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasQuotaMode() => $_has(5);
  @$pb.TagNumber(6)
  void clearQuotaMode() => clearField(6);
}

/// Response message for the AllocateQuota method.
class AllocateQuotaResponse extends $pb.GeneratedMessage {
  factory AllocateQuotaResponse({
    $core.String? operationId,
    $core.Iterable<QuotaError>? allocateErrors,
    $core.Iterable<$109.MetricValueSet>? quotaMetrics,
    $core.String? serviceConfigId,
  }) {
    final $result = create();
    if (operationId != null) {
      $result.operationId = operationId;
    }
    if (allocateErrors != null) {
      $result.allocateErrors.addAll(allocateErrors);
    }
    if (quotaMetrics != null) {
      $result.quotaMetrics.addAll(quotaMetrics);
    }
    if (serviceConfigId != null) {
      $result.serviceConfigId = serviceConfigId;
    }
    return $result;
  }
  AllocateQuotaResponse._() : super();
  factory AllocateQuotaResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AllocateQuotaResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AllocateQuotaResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'operationId')
    ..pc<QuotaError>(
        2, _omitFieldNames ? '' : 'allocateErrors', $pb.PbFieldType.PM,
        subBuilder: QuotaError.create)
    ..pc<$109.MetricValueSet>(
        3, _omitFieldNames ? '' : 'quotaMetrics', $pb.PbFieldType.PM,
        subBuilder: $109.MetricValueSet.create)
    ..aOS(4, _omitFieldNames ? '' : 'serviceConfigId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AllocateQuotaResponse clone() =>
      AllocateQuotaResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AllocateQuotaResponse copyWith(
          void Function(AllocateQuotaResponse) updates) =>
      super.copyWith((message) => updates(message as AllocateQuotaResponse))
          as AllocateQuotaResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AllocateQuotaResponse create() => AllocateQuotaResponse._();
  AllocateQuotaResponse createEmptyInstance() => create();
  static $pb.PbList<AllocateQuotaResponse> createRepeated() =>
      $pb.PbList<AllocateQuotaResponse>();
  @$core.pragma('dart2js:noInline')
  static AllocateQuotaResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AllocateQuotaResponse>(create);
  static AllocateQuotaResponse? _defaultInstance;

  /// The same operation_id value used in the AllocateQuotaRequest. Used for
  /// logging and diagnostics purposes.
  @$pb.TagNumber(1)
  $core.String get operationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set operationId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasOperationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOperationId() => clearField(1);

  /// Indicates the decision of the allocate.
  @$pb.TagNumber(2)
  $core.List<QuotaError> get allocateErrors => $_getList(1);

  ///  Quota metrics to indicate the result of allocation. Depending on the
  ///  request, one or more of the following metrics will be included:
  ///
  ///  1. Per quota group or per quota metric incremental usage will be specified
  ///  using the following delta metric :
  ///    "serviceruntime.googleapis.com/api/consumer/quota_used_count"
  ///
  ///  2. The quota limit reached condition will be specified using the following
  ///  boolean metric :
  ///    "serviceruntime.googleapis.com/quota/exceeded"
  @$pb.TagNumber(3)
  $core.List<$109.MetricValueSet> get quotaMetrics => $_getList(2);

  /// ID of the actual config used to process the request.
  @$pb.TagNumber(4)
  $core.String get serviceConfigId => $_getSZ(3);
  @$pb.TagNumber(4)
  set serviceConfigId($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasServiceConfigId() => $_has(3);
  @$pb.TagNumber(4)
  void clearServiceConfigId() => clearField(4);
}

/// Represents error information for [QuotaOperation][google.api.servicecontrol.v1.QuotaOperation].
class QuotaError extends $pb.GeneratedMessage {
  factory QuotaError({
    QuotaError_Code? code,
    $core.String? subject,
    $core.String? description,
    $57.Status? status,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (subject != null) {
      $result.subject = subject;
    }
    if (description != null) {
      $result.description = description;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  QuotaError._() : super();
  factory QuotaError.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaError.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuotaError',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..e<QuotaError_Code>(1, _omitFieldNames ? '' : 'code', $pb.PbFieldType.OE,
        defaultOrMaker: QuotaError_Code.UNSPECIFIED,
        valueOf: QuotaError_Code.valueOf,
        enumValues: QuotaError_Code.values)
    ..aOS(2, _omitFieldNames ? '' : 'subject')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOM<$57.Status>(4, _omitFieldNames ? '' : 'status',
        subBuilder: $57.Status.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaError clone() => QuotaError()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaError copyWith(void Function(QuotaError) updates) =>
      super.copyWith((message) => updates(message as QuotaError)) as QuotaError;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuotaError create() => QuotaError._();
  QuotaError createEmptyInstance() => create();
  static $pb.PbList<QuotaError> createRepeated() => $pb.PbList<QuotaError>();
  @$core.pragma('dart2js:noInline')
  static QuotaError getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaError>(create);
  static QuotaError? _defaultInstance;

  /// Error code.
  @$pb.TagNumber(1)
  QuotaError_Code get code => $_getN(0);
  @$pb.TagNumber(1)
  set code(QuotaError_Code v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  /// Subject to whom this error applies. See the specific enum for more details
  /// on this field. For example, "clientip:<ip address of client>" or
  /// "project:<Google developer project id>".
  @$pb.TagNumber(2)
  $core.String get subject => $_getSZ(1);
  @$pb.TagNumber(2)
  set subject($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSubject() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubject() => clearField(2);

  /// Free-form text that provides details on the cause of the error.
  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  /// Contains additional information about the quota error.
  /// If available, `status.code` will be non zero.
  @$pb.TagNumber(4)
  $57.Status get status => $_getN(3);
  @$pb.TagNumber(4)
  set status($57.Status v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);
  @$pb.TagNumber(4)
  $57.Status ensureStatus() => $_ensure(3);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
