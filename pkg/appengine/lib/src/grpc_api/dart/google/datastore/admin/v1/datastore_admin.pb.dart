//
//  Generated code. Do not modify.
//  source: google/datastore/admin/v1/datastore_admin.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/timestamp.pb.dart' as $50;
import 'datastore_admin.pbenum.dart';
import 'index.pb.dart' as $24;
import 'migration.pbenum.dart' as $79;

export 'datastore_admin.pbenum.dart';

/// Metadata common to all Datastore Admin operations.
class CommonMetadata extends $pb.GeneratedMessage {
  factory CommonMetadata({
    $50.Timestamp? startTime,
    $50.Timestamp? endTime,
    OperationType? operationType,
    $core.Map<$core.String, $core.String>? labels,
    CommonMetadata_State? state,
  }) {
    final $result = create();
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (endTime != null) {
      $result.endTime = endTime;
    }
    if (operationType != null) {
      $result.operationType = operationType;
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (state != null) {
      $result.state = state;
    }
    return $result;
  }
  CommonMetadata._() : super();
  factory CommonMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CommonMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommonMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOM<$50.Timestamp>(1, _omitFieldNames ? '' : 'startTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(2, _omitFieldNames ? '' : 'endTime',
        subBuilder: $50.Timestamp.create)
    ..e<OperationType>(
        3, _omitFieldNames ? '' : 'operationType', $pb.PbFieldType.OE,
        defaultOrMaker: OperationType.OPERATION_TYPE_UNSPECIFIED,
        valueOf: OperationType.valueOf,
        enumValues: OperationType.values)
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'labels',
        entryClassName: 'CommonMetadata.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.datastore.admin.v1'))
    ..e<CommonMetadata_State>(
        5, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE,
        defaultOrMaker: CommonMetadata_State.STATE_UNSPECIFIED,
        valueOf: CommonMetadata_State.valueOf,
        enumValues: CommonMetadata_State.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CommonMetadata clone() => CommonMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CommonMetadata copyWith(void Function(CommonMetadata) updates) =>
      super.copyWith((message) => updates(message as CommonMetadata))
          as CommonMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommonMetadata create() => CommonMetadata._();
  CommonMetadata createEmptyInstance() => create();
  static $pb.PbList<CommonMetadata> createRepeated() =>
      $pb.PbList<CommonMetadata>();
  @$core.pragma('dart2js:noInline')
  static CommonMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommonMetadata>(create);
  static CommonMetadata? _defaultInstance;

  /// The time that work began on the operation.
  @$pb.TagNumber(1)
  $50.Timestamp get startTime => $_getN(0);
  @$pb.TagNumber(1)
  set startTime($50.Timestamp v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStartTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartTime() => clearField(1);
  @$pb.TagNumber(1)
  $50.Timestamp ensureStartTime() => $_ensure(0);

  /// The time the operation ended, either successfully or otherwise.
  @$pb.TagNumber(2)
  $50.Timestamp get endTime => $_getN(1);
  @$pb.TagNumber(2)
  set endTime($50.Timestamp v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEndTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndTime() => clearField(2);
  @$pb.TagNumber(2)
  $50.Timestamp ensureEndTime() => $_ensure(1);

  /// The type of the operation. Can be used as a filter in
  /// ListOperationsRequest.
  @$pb.TagNumber(3)
  OperationType get operationType => $_getN(2);
  @$pb.TagNumber(3)
  set operationType(OperationType v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOperationType() => $_has(2);
  @$pb.TagNumber(3)
  void clearOperationType() => clearField(3);

  /// The client-assigned labels which were provided when the operation was
  /// created. May also include additional labels.
  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get labels => $_getMap(3);

  /// The current state of the Operation.
  @$pb.TagNumber(5)
  CommonMetadata_State get state => $_getN(4);
  @$pb.TagNumber(5)
  set state(CommonMetadata_State v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasState() => $_has(4);
  @$pb.TagNumber(5)
  void clearState() => clearField(5);
}

/// Measures the progress of a particular metric.
class Progress extends $pb.GeneratedMessage {
  factory Progress({
    $fixnum.Int64? workCompleted,
    $fixnum.Int64? workEstimated,
  }) {
    final $result = create();
    if (workCompleted != null) {
      $result.workCompleted = workCompleted;
    }
    if (workEstimated != null) {
      $result.workEstimated = workEstimated;
    }
    return $result;
  }
  Progress._() : super();
  factory Progress.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Progress.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Progress',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'workCompleted')
    ..aInt64(2, _omitFieldNames ? '' : 'workEstimated')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Progress clone() => Progress()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Progress copyWith(void Function(Progress) updates) =>
      super.copyWith((message) => updates(message as Progress)) as Progress;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Progress create() => Progress._();
  Progress createEmptyInstance() => create();
  static $pb.PbList<Progress> createRepeated() => $pb.PbList<Progress>();
  @$core.pragma('dart2js:noInline')
  static Progress getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Progress>(create);
  static Progress? _defaultInstance;

  /// The amount of work that has been completed. Note that this may be greater
  /// than work_estimated.
  @$pb.TagNumber(1)
  $fixnum.Int64 get workCompleted => $_getI64(0);
  @$pb.TagNumber(1)
  set workCompleted($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasWorkCompleted() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkCompleted() => clearField(1);

  /// An estimate of how much work needs to be performed. May be zero if the
  /// work estimate is unavailable.
  @$pb.TagNumber(2)
  $fixnum.Int64 get workEstimated => $_getI64(1);
  @$pb.TagNumber(2)
  set workEstimated($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasWorkEstimated() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkEstimated() => clearField(2);
}

/// The request for
/// [google.datastore.admin.v1.DatastoreAdmin.ExportEntities][google.datastore.admin.v1.DatastoreAdmin.ExportEntities].
class ExportEntitiesRequest extends $pb.GeneratedMessage {
  factory ExportEntitiesRequest({
    $core.String? projectId,
    $core.Map<$core.String, $core.String>? labels,
    EntityFilter? entityFilter,
    $core.String? outputUrlPrefix,
  }) {
    final $result = create();
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (entityFilter != null) {
      $result.entityFilter = entityFilter;
    }
    if (outputUrlPrefix != null) {
      $result.outputUrlPrefix = outputUrlPrefix;
    }
    return $result;
  }
  ExportEntitiesRequest._() : super();
  factory ExportEntitiesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ExportEntitiesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportEntitiesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'projectId')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'labels',
        entryClassName: 'ExportEntitiesRequest.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.datastore.admin.v1'))
    ..aOM<EntityFilter>(3, _omitFieldNames ? '' : 'entityFilter',
        subBuilder: EntityFilter.create)
    ..aOS(4, _omitFieldNames ? '' : 'outputUrlPrefix')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ExportEntitiesRequest clone() =>
      ExportEntitiesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ExportEntitiesRequest copyWith(
          void Function(ExportEntitiesRequest) updates) =>
      super.copyWith((message) => updates(message as ExportEntitiesRequest))
          as ExportEntitiesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportEntitiesRequest create() => ExportEntitiesRequest._();
  ExportEntitiesRequest createEmptyInstance() => create();
  static $pb.PbList<ExportEntitiesRequest> createRepeated() =>
      $pb.PbList<ExportEntitiesRequest>();
  @$core.pragma('dart2js:noInline')
  static ExportEntitiesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExportEntitiesRequest>(create);
  static ExportEntitiesRequest? _defaultInstance;

  /// Required. Project ID against which to make the request.
  @$pb.TagNumber(1)
  $core.String get projectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectId() => clearField(1);

  /// Client-assigned labels.
  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get labels => $_getMap(1);

  /// Description of what data from the project is included in the export.
  @$pb.TagNumber(3)
  EntityFilter get entityFilter => $_getN(2);
  @$pb.TagNumber(3)
  set entityFilter(EntityFilter v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEntityFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearEntityFilter() => clearField(3);
  @$pb.TagNumber(3)
  EntityFilter ensureEntityFilter() => $_ensure(2);

  ///  Required. Location for the export metadata and data files.
  ///
  ///  The full resource URL of the external storage location. Currently, only
  ///  Google Cloud Storage is supported. So output_url_prefix should be of the
  ///  form: `gs://BUCKET_NAME[/NAMESPACE_PATH]`, where `BUCKET_NAME` is the
  ///  name of the Cloud Storage bucket and `NAMESPACE_PATH` is an optional Cloud
  ///  Storage namespace path (this is not a Cloud Datastore namespace). For more
  ///  information about Cloud Storage namespace paths, see
  ///  [Object name
  ///  considerations](https://cloud.google.com/storage/docs/naming#object-considerations).
  ///
  ///  The resulting files will be nested deeper than the specified URL prefix.
  ///  The final output URL will be provided in the
  ///  [google.datastore.admin.v1.ExportEntitiesResponse.output_url][google.datastore.admin.v1.ExportEntitiesResponse.output_url]
  ///  field. That value should be used for subsequent ImportEntities operations.
  ///
  ///  By nesting the data files deeper, the same Cloud Storage bucket can be used
  ///  in multiple ExportEntities operations without conflict.
  @$pb.TagNumber(4)
  $core.String get outputUrlPrefix => $_getSZ(3);
  @$pb.TagNumber(4)
  set outputUrlPrefix($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasOutputUrlPrefix() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutputUrlPrefix() => clearField(4);
}

/// The request for
/// [google.datastore.admin.v1.DatastoreAdmin.ImportEntities][google.datastore.admin.v1.DatastoreAdmin.ImportEntities].
class ImportEntitiesRequest extends $pb.GeneratedMessage {
  factory ImportEntitiesRequest({
    $core.String? projectId,
    $core.Map<$core.String, $core.String>? labels,
    $core.String? inputUrl,
    EntityFilter? entityFilter,
  }) {
    final $result = create();
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (inputUrl != null) {
      $result.inputUrl = inputUrl;
    }
    if (entityFilter != null) {
      $result.entityFilter = entityFilter;
    }
    return $result;
  }
  ImportEntitiesRequest._() : super();
  factory ImportEntitiesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ImportEntitiesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportEntitiesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'projectId')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'labels',
        entryClassName: 'ImportEntitiesRequest.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.datastore.admin.v1'))
    ..aOS(3, _omitFieldNames ? '' : 'inputUrl')
    ..aOM<EntityFilter>(4, _omitFieldNames ? '' : 'entityFilter',
        subBuilder: EntityFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ImportEntitiesRequest clone() =>
      ImportEntitiesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ImportEntitiesRequest copyWith(
          void Function(ImportEntitiesRequest) updates) =>
      super.copyWith((message) => updates(message as ImportEntitiesRequest))
          as ImportEntitiesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImportEntitiesRequest create() => ImportEntitiesRequest._();
  ImportEntitiesRequest createEmptyInstance() => create();
  static $pb.PbList<ImportEntitiesRequest> createRepeated() =>
      $pb.PbList<ImportEntitiesRequest>();
  @$core.pragma('dart2js:noInline')
  static ImportEntitiesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportEntitiesRequest>(create);
  static ImportEntitiesRequest? _defaultInstance;

  /// Required. Project ID against which to make the request.
  @$pb.TagNumber(1)
  $core.String get projectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectId() => clearField(1);

  /// Client-assigned labels.
  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get labels => $_getMap(1);

  ///  Required. The full resource URL of the external storage location.
  ///  Currently, only Google Cloud Storage is supported. So input_url should be
  ///  of the form:
  ///  `gs://BUCKET_NAME[/NAMESPACE_PATH]/OVERALL_EXPORT_METADATA_FILE`, where
  ///  `BUCKET_NAME` is the name of the Cloud Storage bucket, `NAMESPACE_PATH` is
  ///  an optional Cloud Storage namespace path (this is not a Cloud Datastore
  ///  namespace), and `OVERALL_EXPORT_METADATA_FILE` is the metadata file written
  ///  by the ExportEntities operation. For more information about Cloud Storage
  ///  namespace paths, see
  ///  [Object name
  ///  considerations](https://cloud.google.com/storage/docs/naming#object-considerations).
  ///
  ///  For more information, see
  ///  [google.datastore.admin.v1.ExportEntitiesResponse.output_url][google.datastore.admin.v1.ExportEntitiesResponse.output_url].
  @$pb.TagNumber(3)
  $core.String get inputUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set inputUrl($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasInputUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearInputUrl() => clearField(3);

  /// Optionally specify which kinds/namespaces are to be imported. If provided,
  /// the list must be a subset of the EntityFilter used in creating the export,
  /// otherwise a FAILED_PRECONDITION error will be returned. If no filter is
  /// specified then all entities from the export are imported.
  @$pb.TagNumber(4)
  EntityFilter get entityFilter => $_getN(3);
  @$pb.TagNumber(4)
  set entityFilter(EntityFilter v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasEntityFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearEntityFilter() => clearField(4);
  @$pb.TagNumber(4)
  EntityFilter ensureEntityFilter() => $_ensure(3);
}

/// The response for
/// [google.datastore.admin.v1.DatastoreAdmin.ExportEntities][google.datastore.admin.v1.DatastoreAdmin.ExportEntities].
class ExportEntitiesResponse extends $pb.GeneratedMessage {
  factory ExportEntitiesResponse({
    $core.String? outputUrl,
  }) {
    final $result = create();
    if (outputUrl != null) {
      $result.outputUrl = outputUrl;
    }
    return $result;
  }
  ExportEntitiesResponse._() : super();
  factory ExportEntitiesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ExportEntitiesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportEntitiesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'outputUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ExportEntitiesResponse clone() =>
      ExportEntitiesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ExportEntitiesResponse copyWith(
          void Function(ExportEntitiesResponse) updates) =>
      super.copyWith((message) => updates(message as ExportEntitiesResponse))
          as ExportEntitiesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportEntitiesResponse create() => ExportEntitiesResponse._();
  ExportEntitiesResponse createEmptyInstance() => create();
  static $pb.PbList<ExportEntitiesResponse> createRepeated() =>
      $pb.PbList<ExportEntitiesResponse>();
  @$core.pragma('dart2js:noInline')
  static ExportEntitiesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExportEntitiesResponse>(create);
  static ExportEntitiesResponse? _defaultInstance;

  /// Location of the output metadata file. This can be used to begin an import
  /// into Cloud Datastore (this project or another project). See
  /// [google.datastore.admin.v1.ImportEntitiesRequest.input_url][google.datastore.admin.v1.ImportEntitiesRequest.input_url].
  /// Only present if the operation completed successfully.
  @$pb.TagNumber(1)
  $core.String get outputUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set outputUrl($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasOutputUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutputUrl() => clearField(1);
}

/// Metadata for ExportEntities operations.
class ExportEntitiesMetadata extends $pb.GeneratedMessage {
  factory ExportEntitiesMetadata({
    CommonMetadata? common,
    Progress? progressEntities,
    Progress? progressBytes,
    EntityFilter? entityFilter,
    $core.String? outputUrlPrefix,
  }) {
    final $result = create();
    if (common != null) {
      $result.common = common;
    }
    if (progressEntities != null) {
      $result.progressEntities = progressEntities;
    }
    if (progressBytes != null) {
      $result.progressBytes = progressBytes;
    }
    if (entityFilter != null) {
      $result.entityFilter = entityFilter;
    }
    if (outputUrlPrefix != null) {
      $result.outputUrlPrefix = outputUrlPrefix;
    }
    return $result;
  }
  ExportEntitiesMetadata._() : super();
  factory ExportEntitiesMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ExportEntitiesMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportEntitiesMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOM<CommonMetadata>(1, _omitFieldNames ? '' : 'common',
        subBuilder: CommonMetadata.create)
    ..aOM<Progress>(2, _omitFieldNames ? '' : 'progressEntities',
        subBuilder: Progress.create)
    ..aOM<Progress>(3, _omitFieldNames ? '' : 'progressBytes',
        subBuilder: Progress.create)
    ..aOM<EntityFilter>(4, _omitFieldNames ? '' : 'entityFilter',
        subBuilder: EntityFilter.create)
    ..aOS(5, _omitFieldNames ? '' : 'outputUrlPrefix')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ExportEntitiesMetadata clone() =>
      ExportEntitiesMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ExportEntitiesMetadata copyWith(
          void Function(ExportEntitiesMetadata) updates) =>
      super.copyWith((message) => updates(message as ExportEntitiesMetadata))
          as ExportEntitiesMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportEntitiesMetadata create() => ExportEntitiesMetadata._();
  ExportEntitiesMetadata createEmptyInstance() => create();
  static $pb.PbList<ExportEntitiesMetadata> createRepeated() =>
      $pb.PbList<ExportEntitiesMetadata>();
  @$core.pragma('dart2js:noInline')
  static ExportEntitiesMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExportEntitiesMetadata>(create);
  static ExportEntitiesMetadata? _defaultInstance;

  /// Metadata common to all Datastore Admin operations.
  @$pb.TagNumber(1)
  CommonMetadata get common => $_getN(0);
  @$pb.TagNumber(1)
  set common(CommonMetadata v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommon() => clearField(1);
  @$pb.TagNumber(1)
  CommonMetadata ensureCommon() => $_ensure(0);

  /// An estimate of the number of entities processed.
  @$pb.TagNumber(2)
  Progress get progressEntities => $_getN(1);
  @$pb.TagNumber(2)
  set progressEntities(Progress v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProgressEntities() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgressEntities() => clearField(2);
  @$pb.TagNumber(2)
  Progress ensureProgressEntities() => $_ensure(1);

  /// An estimate of the number of bytes processed.
  @$pb.TagNumber(3)
  Progress get progressBytes => $_getN(2);
  @$pb.TagNumber(3)
  set progressBytes(Progress v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasProgressBytes() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgressBytes() => clearField(3);
  @$pb.TagNumber(3)
  Progress ensureProgressBytes() => $_ensure(2);

  /// Description of which entities are being exported.
  @$pb.TagNumber(4)
  EntityFilter get entityFilter => $_getN(3);
  @$pb.TagNumber(4)
  set entityFilter(EntityFilter v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasEntityFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearEntityFilter() => clearField(4);
  @$pb.TagNumber(4)
  EntityFilter ensureEntityFilter() => $_ensure(3);

  /// Location for the export metadata and data files. This will be the same
  /// value as the
  /// [google.datastore.admin.v1.ExportEntitiesRequest.output_url_prefix][google.datastore.admin.v1.ExportEntitiesRequest.output_url_prefix]
  /// field. The final output location is provided in
  /// [google.datastore.admin.v1.ExportEntitiesResponse.output_url][google.datastore.admin.v1.ExportEntitiesResponse.output_url].
  @$pb.TagNumber(5)
  $core.String get outputUrlPrefix => $_getSZ(4);
  @$pb.TagNumber(5)
  set outputUrlPrefix($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasOutputUrlPrefix() => $_has(4);
  @$pb.TagNumber(5)
  void clearOutputUrlPrefix() => clearField(5);
}

/// Metadata for ImportEntities operations.
class ImportEntitiesMetadata extends $pb.GeneratedMessage {
  factory ImportEntitiesMetadata({
    CommonMetadata? common,
    Progress? progressEntities,
    Progress? progressBytes,
    EntityFilter? entityFilter,
    $core.String? inputUrl,
  }) {
    final $result = create();
    if (common != null) {
      $result.common = common;
    }
    if (progressEntities != null) {
      $result.progressEntities = progressEntities;
    }
    if (progressBytes != null) {
      $result.progressBytes = progressBytes;
    }
    if (entityFilter != null) {
      $result.entityFilter = entityFilter;
    }
    if (inputUrl != null) {
      $result.inputUrl = inputUrl;
    }
    return $result;
  }
  ImportEntitiesMetadata._() : super();
  factory ImportEntitiesMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ImportEntitiesMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportEntitiesMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOM<CommonMetadata>(1, _omitFieldNames ? '' : 'common',
        subBuilder: CommonMetadata.create)
    ..aOM<Progress>(2, _omitFieldNames ? '' : 'progressEntities',
        subBuilder: Progress.create)
    ..aOM<Progress>(3, _omitFieldNames ? '' : 'progressBytes',
        subBuilder: Progress.create)
    ..aOM<EntityFilter>(4, _omitFieldNames ? '' : 'entityFilter',
        subBuilder: EntityFilter.create)
    ..aOS(5, _omitFieldNames ? '' : 'inputUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ImportEntitiesMetadata clone() =>
      ImportEntitiesMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ImportEntitiesMetadata copyWith(
          void Function(ImportEntitiesMetadata) updates) =>
      super.copyWith((message) => updates(message as ImportEntitiesMetadata))
          as ImportEntitiesMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImportEntitiesMetadata create() => ImportEntitiesMetadata._();
  ImportEntitiesMetadata createEmptyInstance() => create();
  static $pb.PbList<ImportEntitiesMetadata> createRepeated() =>
      $pb.PbList<ImportEntitiesMetadata>();
  @$core.pragma('dart2js:noInline')
  static ImportEntitiesMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportEntitiesMetadata>(create);
  static ImportEntitiesMetadata? _defaultInstance;

  /// Metadata common to all Datastore Admin operations.
  @$pb.TagNumber(1)
  CommonMetadata get common => $_getN(0);
  @$pb.TagNumber(1)
  set common(CommonMetadata v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommon() => clearField(1);
  @$pb.TagNumber(1)
  CommonMetadata ensureCommon() => $_ensure(0);

  /// An estimate of the number of entities processed.
  @$pb.TagNumber(2)
  Progress get progressEntities => $_getN(1);
  @$pb.TagNumber(2)
  set progressEntities(Progress v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProgressEntities() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgressEntities() => clearField(2);
  @$pb.TagNumber(2)
  Progress ensureProgressEntities() => $_ensure(1);

  /// An estimate of the number of bytes processed.
  @$pb.TagNumber(3)
  Progress get progressBytes => $_getN(2);
  @$pb.TagNumber(3)
  set progressBytes(Progress v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasProgressBytes() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgressBytes() => clearField(3);
  @$pb.TagNumber(3)
  Progress ensureProgressBytes() => $_ensure(2);

  /// Description of which entities are being imported.
  @$pb.TagNumber(4)
  EntityFilter get entityFilter => $_getN(3);
  @$pb.TagNumber(4)
  set entityFilter(EntityFilter v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasEntityFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearEntityFilter() => clearField(4);
  @$pb.TagNumber(4)
  EntityFilter ensureEntityFilter() => $_ensure(3);

  /// The location of the import metadata file. This will be the same value as
  /// the
  /// [google.datastore.admin.v1.ExportEntitiesResponse.output_url][google.datastore.admin.v1.ExportEntitiesResponse.output_url]
  /// field.
  @$pb.TagNumber(5)
  $core.String get inputUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set inputUrl($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasInputUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearInputUrl() => clearField(5);
}

///  Identifies a subset of entities in a project. This is specified as
///  combinations of kinds and namespaces (either or both of which may be all, as
///  described in the following examples).
///  Example usage:
///
///  Entire project:
///    kinds=[], namespace_ids=[]
///
///  Kinds Foo and Bar in all namespaces:
///    kinds=['Foo', 'Bar'], namespace_ids=[]
///
///  Kinds Foo and Bar only in the default namespace:
///    kinds=['Foo', 'Bar'], namespace_ids=['']
///
///  Kinds Foo and Bar in both the default and Baz namespaces:
///    kinds=['Foo', 'Bar'], namespace_ids=['', 'Baz']
///
///  The entire Baz namespace:
///    kinds=[], namespace_ids=['Baz']
class EntityFilter extends $pb.GeneratedMessage {
  factory EntityFilter({
    $core.Iterable<$core.String>? kinds,
    $core.Iterable<$core.String>? namespaceIds,
  }) {
    final $result = create();
    if (kinds != null) {
      $result.kinds.addAll(kinds);
    }
    if (namespaceIds != null) {
      $result.namespaceIds.addAll(namespaceIds);
    }
    return $result;
  }
  EntityFilter._() : super();
  factory EntityFilter.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EntityFilter.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EntityFilter',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'kinds')
    ..pPS(2, _omitFieldNames ? '' : 'namespaceIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EntityFilter clone() => EntityFilter()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EntityFilter copyWith(void Function(EntityFilter) updates) =>
      super.copyWith((message) => updates(message as EntityFilter))
          as EntityFilter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EntityFilter create() => EntityFilter._();
  EntityFilter createEmptyInstance() => create();
  static $pb.PbList<EntityFilter> createRepeated() =>
      $pb.PbList<EntityFilter>();
  @$core.pragma('dart2js:noInline')
  static EntityFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EntityFilter>(create);
  static EntityFilter? _defaultInstance;

  /// If empty, then this represents all kinds.
  @$pb.TagNumber(1)
  $core.List<$core.String> get kinds => $_getList(0);

  ///  An empty list represents all namespaces. This is the preferred
  ///  usage for projects that don't use namespaces.
  ///
  ///  An empty string element represents the default namespace. This should be
  ///  used if the project has data in non-default namespaces, but doesn't want to
  ///  include them.
  ///  Each namespace in this list must be unique.
  @$pb.TagNumber(2)
  $core.List<$core.String> get namespaceIds => $_getList(1);
}

/// The request for
/// [google.datastore.admin.v1.DatastoreAdmin.CreateIndex][google.datastore.admin.v1.DatastoreAdmin.CreateIndex].
class CreateIndexRequest extends $pb.GeneratedMessage {
  factory CreateIndexRequest({
    $core.String? projectId,
    $24.Index? index,
  }) {
    final $result = create();
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (index != null) {
      $result.index = index;
    }
    return $result;
  }
  CreateIndexRequest._() : super();
  factory CreateIndexRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateIndexRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateIndexRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'projectId')
    ..aOM<$24.Index>(3, _omitFieldNames ? '' : 'index',
        subBuilder: $24.Index.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateIndexRequest clone() => CreateIndexRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateIndexRequest copyWith(void Function(CreateIndexRequest) updates) =>
      super.copyWith((message) => updates(message as CreateIndexRequest))
          as CreateIndexRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateIndexRequest create() => CreateIndexRequest._();
  CreateIndexRequest createEmptyInstance() => create();
  static $pb.PbList<CreateIndexRequest> createRepeated() =>
      $pb.PbList<CreateIndexRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateIndexRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateIndexRequest>(create);
  static CreateIndexRequest? _defaultInstance;

  /// Project ID against which to make the request.
  @$pb.TagNumber(1)
  $core.String get projectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectId() => clearField(1);

  /// The index to create. The name and state fields are output only and will be
  /// ignored. Single property indexes cannot be created or deleted.
  @$pb.TagNumber(3)
  $24.Index get index => $_getN(1);
  @$pb.TagNumber(3)
  set index($24.Index v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasIndex() => $_has(1);
  @$pb.TagNumber(3)
  void clearIndex() => clearField(3);
  @$pb.TagNumber(3)
  $24.Index ensureIndex() => $_ensure(1);
}

/// The request for
/// [google.datastore.admin.v1.DatastoreAdmin.DeleteIndex][google.datastore.admin.v1.DatastoreAdmin.DeleteIndex].
class DeleteIndexRequest extends $pb.GeneratedMessage {
  factory DeleteIndexRequest({
    $core.String? projectId,
    $core.String? indexId,
  }) {
    final $result = create();
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (indexId != null) {
      $result.indexId = indexId;
    }
    return $result;
  }
  DeleteIndexRequest._() : super();
  factory DeleteIndexRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteIndexRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteIndexRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'projectId')
    ..aOS(3, _omitFieldNames ? '' : 'indexId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteIndexRequest clone() => DeleteIndexRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteIndexRequest copyWith(void Function(DeleteIndexRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteIndexRequest))
          as DeleteIndexRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteIndexRequest create() => DeleteIndexRequest._();
  DeleteIndexRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteIndexRequest> createRepeated() =>
      $pb.PbList<DeleteIndexRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteIndexRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteIndexRequest>(create);
  static DeleteIndexRequest? _defaultInstance;

  /// Project ID against which to make the request.
  @$pb.TagNumber(1)
  $core.String get projectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectId() => clearField(1);

  /// The resource ID of the index to delete.
  @$pb.TagNumber(3)
  $core.String get indexId => $_getSZ(1);
  @$pb.TagNumber(3)
  set indexId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasIndexId() => $_has(1);
  @$pb.TagNumber(3)
  void clearIndexId() => clearField(3);
}

/// The request for
/// [google.datastore.admin.v1.DatastoreAdmin.GetIndex][google.datastore.admin.v1.DatastoreAdmin.GetIndex].
class GetIndexRequest extends $pb.GeneratedMessage {
  factory GetIndexRequest({
    $core.String? projectId,
    $core.String? indexId,
  }) {
    final $result = create();
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (indexId != null) {
      $result.indexId = indexId;
    }
    return $result;
  }
  GetIndexRequest._() : super();
  factory GetIndexRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetIndexRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIndexRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'projectId')
    ..aOS(3, _omitFieldNames ? '' : 'indexId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetIndexRequest clone() => GetIndexRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetIndexRequest copyWith(void Function(GetIndexRequest) updates) =>
      super.copyWith((message) => updates(message as GetIndexRequest))
          as GetIndexRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIndexRequest create() => GetIndexRequest._();
  GetIndexRequest createEmptyInstance() => create();
  static $pb.PbList<GetIndexRequest> createRepeated() =>
      $pb.PbList<GetIndexRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIndexRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIndexRequest>(create);
  static GetIndexRequest? _defaultInstance;

  /// Project ID against which to make the request.
  @$pb.TagNumber(1)
  $core.String get projectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectId() => clearField(1);

  /// The resource ID of the index to get.
  @$pb.TagNumber(3)
  $core.String get indexId => $_getSZ(1);
  @$pb.TagNumber(3)
  set indexId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasIndexId() => $_has(1);
  @$pb.TagNumber(3)
  void clearIndexId() => clearField(3);
}

/// The request for
/// [google.datastore.admin.v1.DatastoreAdmin.ListIndexes][google.datastore.admin.v1.DatastoreAdmin.ListIndexes].
class ListIndexesRequest extends $pb.GeneratedMessage {
  factory ListIndexesRequest({
    $core.String? projectId,
    $core.String? filter,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (filter != null) {
      $result.filter = filter;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  ListIndexesRequest._() : super();
  factory ListIndexesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListIndexesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListIndexesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'projectId')
    ..aOS(3, _omitFieldNames ? '' : 'filter')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListIndexesRequest clone() => ListIndexesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListIndexesRequest copyWith(void Function(ListIndexesRequest) updates) =>
      super.copyWith((message) => updates(message as ListIndexesRequest))
          as ListIndexesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListIndexesRequest create() => ListIndexesRequest._();
  ListIndexesRequest createEmptyInstance() => create();
  static $pb.PbList<ListIndexesRequest> createRepeated() =>
      $pb.PbList<ListIndexesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListIndexesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListIndexesRequest>(create);
  static ListIndexesRequest? _defaultInstance;

  /// Project ID against which to make the request.
  @$pb.TagNumber(1)
  $core.String get projectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectId() => clearField(1);

  @$pb.TagNumber(3)
  $core.String get filter => $_getSZ(1);
  @$pb.TagNumber(3)
  set filter($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFilter() => $_has(1);
  @$pb.TagNumber(3)
  void clearFilter() => clearField(3);

  /// The maximum number of items to return.  If zero, then all results will be
  /// returned.
  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(4)
  set pageSize($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(4)
  void clearPageSize() => clearField(4);

  /// The next_page_token value returned from a previous List request, if any.
  @$pb.TagNumber(5)
  $core.String get pageToken => $_getSZ(3);
  @$pb.TagNumber(5)
  set pageToken($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasPageToken() => $_has(3);
  @$pb.TagNumber(5)
  void clearPageToken() => clearField(5);
}

/// The response for
/// [google.datastore.admin.v1.DatastoreAdmin.ListIndexes][google.datastore.admin.v1.DatastoreAdmin.ListIndexes].
class ListIndexesResponse extends $pb.GeneratedMessage {
  factory ListIndexesResponse({
    $core.Iterable<$24.Index>? indexes,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (indexes != null) {
      $result.indexes.addAll(indexes);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListIndexesResponse._() : super();
  factory ListIndexesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListIndexesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListIndexesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..pc<$24.Index>(1, _omitFieldNames ? '' : 'indexes', $pb.PbFieldType.PM,
        subBuilder: $24.Index.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListIndexesResponse clone() => ListIndexesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListIndexesResponse copyWith(void Function(ListIndexesResponse) updates) =>
      super.copyWith((message) => updates(message as ListIndexesResponse))
          as ListIndexesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListIndexesResponse create() => ListIndexesResponse._();
  ListIndexesResponse createEmptyInstance() => create();
  static $pb.PbList<ListIndexesResponse> createRepeated() =>
      $pb.PbList<ListIndexesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListIndexesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListIndexesResponse>(create);
  static ListIndexesResponse? _defaultInstance;

  /// The indexes.
  @$pb.TagNumber(1)
  $core.List<$24.Index> get indexes => $_getList(0);

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

/// Metadata for Index operations.
class IndexOperationMetadata extends $pb.GeneratedMessage {
  factory IndexOperationMetadata({
    CommonMetadata? common,
    Progress? progressEntities,
    $core.String? indexId,
  }) {
    final $result = create();
    if (common != null) {
      $result.common = common;
    }
    if (progressEntities != null) {
      $result.progressEntities = progressEntities;
    }
    if (indexId != null) {
      $result.indexId = indexId;
    }
    return $result;
  }
  IndexOperationMetadata._() : super();
  factory IndexOperationMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory IndexOperationMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IndexOperationMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOM<CommonMetadata>(1, _omitFieldNames ? '' : 'common',
        subBuilder: CommonMetadata.create)
    ..aOM<Progress>(2, _omitFieldNames ? '' : 'progressEntities',
        subBuilder: Progress.create)
    ..aOS(3, _omitFieldNames ? '' : 'indexId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  IndexOperationMetadata clone() =>
      IndexOperationMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  IndexOperationMetadata copyWith(
          void Function(IndexOperationMetadata) updates) =>
      super.copyWith((message) => updates(message as IndexOperationMetadata))
          as IndexOperationMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IndexOperationMetadata create() => IndexOperationMetadata._();
  IndexOperationMetadata createEmptyInstance() => create();
  static $pb.PbList<IndexOperationMetadata> createRepeated() =>
      $pb.PbList<IndexOperationMetadata>();
  @$core.pragma('dart2js:noInline')
  static IndexOperationMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IndexOperationMetadata>(create);
  static IndexOperationMetadata? _defaultInstance;

  /// Metadata common to all Datastore Admin operations.
  @$pb.TagNumber(1)
  CommonMetadata get common => $_getN(0);
  @$pb.TagNumber(1)
  set common(CommonMetadata v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommon() => clearField(1);
  @$pb.TagNumber(1)
  CommonMetadata ensureCommon() => $_ensure(0);

  /// An estimate of the number of entities processed.
  @$pb.TagNumber(2)
  Progress get progressEntities => $_getN(1);
  @$pb.TagNumber(2)
  set progressEntities(Progress v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProgressEntities() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgressEntities() => clearField(2);
  @$pb.TagNumber(2)
  Progress ensureProgressEntities() => $_ensure(1);

  /// The index resource ID that this operation is acting on.
  @$pb.TagNumber(3)
  $core.String get indexId => $_getSZ(2);
  @$pb.TagNumber(3)
  set indexId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasIndexId() => $_has(2);
  @$pb.TagNumber(3)
  void clearIndexId() => clearField(3);
}

///  Metadata for Datastore to Firestore migration operations.
///
///  The DatastoreFirestoreMigration operation is not started by the end-user via
///  an explicit "creation" method. This is an intentional deviation from the LRO
///  design pattern.
///
///  This singleton resource can be accessed at:
///  "projects/{project_id}/operations/datastore-firestore-migration"
class DatastoreFirestoreMigrationMetadata extends $pb.GeneratedMessage {
  factory DatastoreFirestoreMigrationMetadata({
    $79.MigrationState? migrationState,
    $79.MigrationStep? migrationStep,
  }) {
    final $result = create();
    if (migrationState != null) {
      $result.migrationState = migrationState;
    }
    if (migrationStep != null) {
      $result.migrationStep = migrationStep;
    }
    return $result;
  }
  DatastoreFirestoreMigrationMetadata._() : super();
  factory DatastoreFirestoreMigrationMetadata.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DatastoreFirestoreMigrationMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DatastoreFirestoreMigrationMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..e<$79.MigrationState>(
        1, _omitFieldNames ? '' : 'migrationState', $pb.PbFieldType.OE,
        defaultOrMaker: $79.MigrationState.MIGRATION_STATE_UNSPECIFIED,
        valueOf: $79.MigrationState.valueOf,
        enumValues: $79.MigrationState.values)
    ..e<$79.MigrationStep>(
        2, _omitFieldNames ? '' : 'migrationStep', $pb.PbFieldType.OE,
        defaultOrMaker: $79.MigrationStep.MIGRATION_STEP_UNSPECIFIED,
        valueOf: $79.MigrationStep.valueOf,
        enumValues: $79.MigrationStep.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DatastoreFirestoreMigrationMetadata clone() =>
      DatastoreFirestoreMigrationMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DatastoreFirestoreMigrationMetadata copyWith(
          void Function(DatastoreFirestoreMigrationMetadata) updates) =>
      super.copyWith((message) =>
              updates(message as DatastoreFirestoreMigrationMetadata))
          as DatastoreFirestoreMigrationMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DatastoreFirestoreMigrationMetadata create() =>
      DatastoreFirestoreMigrationMetadata._();
  DatastoreFirestoreMigrationMetadata createEmptyInstance() => create();
  static $pb.PbList<DatastoreFirestoreMigrationMetadata> createRepeated() =>
      $pb.PbList<DatastoreFirestoreMigrationMetadata>();
  @$core.pragma('dart2js:noInline')
  static DatastoreFirestoreMigrationMetadata getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          DatastoreFirestoreMigrationMetadata>(create);
  static DatastoreFirestoreMigrationMetadata? _defaultInstance;

  /// The current state of migration from Cloud Datastore to Cloud Firestore in
  /// Datastore mode.
  @$pb.TagNumber(1)
  $79.MigrationState get migrationState => $_getN(0);
  @$pb.TagNumber(1)
  set migrationState($79.MigrationState v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMigrationState() => $_has(0);
  @$pb.TagNumber(1)
  void clearMigrationState() => clearField(1);

  /// The current step of migration from Cloud Datastore to Cloud Firestore in
  /// Datastore mode.
  @$pb.TagNumber(2)
  $79.MigrationStep get migrationStep => $_getN(1);
  @$pb.TagNumber(2)
  set migrationStep($79.MigrationStep v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMigrationStep() => $_has(1);
  @$pb.TagNumber(2)
  void clearMigrationStep() => clearField(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
