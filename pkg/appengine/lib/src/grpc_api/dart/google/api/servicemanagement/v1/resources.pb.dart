//
//  Generated code. Do not modify.
//  source: google/api/servicemanagement/v1/resources.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/timestamp.pb.dart' as $50;
import '../../config_change.pb.dart' as $80;
import 'resources.pbenum.dart';

export 'resources.pbenum.dart';

/// The full representation of a Service that is managed by
/// Google Service Management.
class ManagedService extends $pb.GeneratedMessage {
  factory ManagedService({
    $core.String? serviceName,
    $core.String? producerProjectId,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (producerProjectId != null) {
      $result.producerProjectId = producerProjectId;
    }
    return $result;
  }
  ManagedService._() : super();
  factory ManagedService.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ManagedService.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ManagedService',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'serviceName')
    ..aOS(3, _omitFieldNames ? '' : 'producerProjectId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ManagedService clone() => ManagedService()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ManagedService copyWith(void Function(ManagedService) updates) =>
      super.copyWith((message) => updates(message as ManagedService))
          as ManagedService;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ManagedService create() => ManagedService._();
  ManagedService createEmptyInstance() => create();
  static $pb.PbList<ManagedService> createRepeated() =>
      $pb.PbList<ManagedService>();
  @$core.pragma('dart2js:noInline')
  static ManagedService getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ManagedService>(create);
  static ManagedService? _defaultInstance;

  /// The name of the service. See the
  /// [overview](https://cloud.google.com/service-infrastructure/docs/overview)
  /// for naming requirements.
  @$pb.TagNumber(2)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(2)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(2)
  void clearServiceName() => clearField(2);

  /// ID of the project that produces and owns this service.
  @$pb.TagNumber(3)
  $core.String get producerProjectId => $_getSZ(1);
  @$pb.TagNumber(3)
  set producerProjectId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasProducerProjectId() => $_has(1);
  @$pb.TagNumber(3)
  void clearProducerProjectId() => clearField(3);
}

/// Represents the status of one operation step.
class OperationMetadata_Step extends $pb.GeneratedMessage {
  factory OperationMetadata_Step({
    $core.String? description,
    OperationMetadata_Status? status,
  }) {
    final $result = create();
    if (description != null) {
      $result.description = description;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  OperationMetadata_Step._() : super();
  factory OperationMetadata_Step.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OperationMetadata_Step.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OperationMetadata.Step',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..e<OperationMetadata_Status>(
        4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: OperationMetadata_Status.STATUS_UNSPECIFIED,
        valueOf: OperationMetadata_Status.valueOf,
        enumValues: OperationMetadata_Status.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OperationMetadata_Step clone() =>
      OperationMetadata_Step()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OperationMetadata_Step copyWith(
          void Function(OperationMetadata_Step) updates) =>
      super.copyWith((message) => updates(message as OperationMetadata_Step))
          as OperationMetadata_Step;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OperationMetadata_Step create() => OperationMetadata_Step._();
  OperationMetadata_Step createEmptyInstance() => create();
  static $pb.PbList<OperationMetadata_Step> createRepeated() =>
      $pb.PbList<OperationMetadata_Step>();
  @$core.pragma('dart2js:noInline')
  static OperationMetadata_Step getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OperationMetadata_Step>(create);
  static OperationMetadata_Step? _defaultInstance;

  /// The short description of the step.
  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(2)
  set description($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  /// The status code.
  @$pb.TagNumber(4)
  OperationMetadata_Status get status => $_getN(1);
  @$pb.TagNumber(4)
  set status(OperationMetadata_Status v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);
}

/// The metadata associated with a long running operation resource.
class OperationMetadata extends $pb.GeneratedMessage {
  factory OperationMetadata({
    $core.Iterable<$core.String>? resourceNames,
    $core.Iterable<OperationMetadata_Step>? steps,
    $core.int? progressPercentage,
    $50.Timestamp? startTime,
  }) {
    final $result = create();
    if (resourceNames != null) {
      $result.resourceNames.addAll(resourceNames);
    }
    if (steps != null) {
      $result.steps.addAll(steps);
    }
    if (progressPercentage != null) {
      $result.progressPercentage = progressPercentage;
    }
    if (startTime != null) {
      $result.startTime = startTime;
    }
    return $result;
  }
  OperationMetadata._() : super();
  factory OperationMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OperationMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OperationMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'resourceNames')
    ..pc<OperationMetadata_Step>(
        2, _omitFieldNames ? '' : 'steps', $pb.PbFieldType.PM,
        subBuilder: OperationMetadata_Step.create)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'progressPercentage', $pb.PbFieldType.O3)
    ..aOM<$50.Timestamp>(4, _omitFieldNames ? '' : 'startTime',
        subBuilder: $50.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OperationMetadata clone() => OperationMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OperationMetadata copyWith(void Function(OperationMetadata) updates) =>
      super.copyWith((message) => updates(message as OperationMetadata))
          as OperationMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OperationMetadata create() => OperationMetadata._();
  OperationMetadata createEmptyInstance() => create();
  static $pb.PbList<OperationMetadata> createRepeated() =>
      $pb.PbList<OperationMetadata>();
  @$core.pragma('dart2js:noInline')
  static OperationMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OperationMetadata>(create);
  static OperationMetadata? _defaultInstance;

  /// The full name of the resources that this operation is directly
  /// associated with.
  @$pb.TagNumber(1)
  $core.List<$core.String> get resourceNames => $_getList(0);

  /// Detailed status information for each step. The order is undetermined.
  @$pb.TagNumber(2)
  $core.List<OperationMetadata_Step> get steps => $_getList(1);

  /// Percentage of completion of this operation, ranging from 0 to 100.
  @$pb.TagNumber(3)
  $core.int get progressPercentage => $_getIZ(2);
  @$pb.TagNumber(3)
  set progressPercentage($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasProgressPercentage() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgressPercentage() => clearField(3);

  /// The start time of the operation.
  @$pb.TagNumber(4)
  $50.Timestamp get startTime => $_getN(3);
  @$pb.TagNumber(4)
  set startTime($50.Timestamp v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasStartTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartTime() => clearField(4);
  @$pb.TagNumber(4)
  $50.Timestamp ensureStartTime() => $_ensure(3);
}

/// Represents a diagnostic message (error or warning)
class Diagnostic extends $pb.GeneratedMessage {
  factory Diagnostic({
    $core.String? location,
    Diagnostic_Kind? kind,
    $core.String? message,
  }) {
    final $result = create();
    if (location != null) {
      $result.location = location;
    }
    if (kind != null) {
      $result.kind = kind;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  Diagnostic._() : super();
  factory Diagnostic.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Diagnostic.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Diagnostic',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'location')
    ..e<Diagnostic_Kind>(2, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE,
        defaultOrMaker: Diagnostic_Kind.WARNING,
        valueOf: Diagnostic_Kind.valueOf,
        enumValues: Diagnostic_Kind.values)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Diagnostic clone() => Diagnostic()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Diagnostic copyWith(void Function(Diagnostic) updates) =>
      super.copyWith((message) => updates(message as Diagnostic)) as Diagnostic;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Diagnostic create() => Diagnostic._();
  Diagnostic createEmptyInstance() => create();
  static $pb.PbList<Diagnostic> createRepeated() => $pb.PbList<Diagnostic>();
  @$core.pragma('dart2js:noInline')
  static Diagnostic getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Diagnostic>(create);
  static Diagnostic? _defaultInstance;

  /// File name and line number of the error or warning.
  @$pb.TagNumber(1)
  $core.String get location => $_getSZ(0);
  @$pb.TagNumber(1)
  set location($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLocation() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocation() => clearField(1);

  /// The kind of diagnostic information provided.
  @$pb.TagNumber(2)
  Diagnostic_Kind get kind => $_getN(1);
  @$pb.TagNumber(2)
  set kind(Diagnostic_Kind v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => clearField(2);

  /// Message describing the error or warning.
  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

/// Represents a source file which is used to generate the service configuration
/// defined by `google.api.Service`.
class ConfigSource extends $pb.GeneratedMessage {
  factory ConfigSource({
    $core.Iterable<ConfigFile>? files,
    $core.String? id,
  }) {
    final $result = create();
    if (files != null) {
      $result.files.addAll(files);
    }
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  ConfigSource._() : super();
  factory ConfigSource.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ConfigSource.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfigSource',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..pc<ConfigFile>(2, _omitFieldNames ? '' : 'files', $pb.PbFieldType.PM,
        subBuilder: ConfigFile.create)
    ..aOS(5, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ConfigSource clone() => ConfigSource()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ConfigSource copyWith(void Function(ConfigSource) updates) =>
      super.copyWith((message) => updates(message as ConfigSource))
          as ConfigSource;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfigSource create() => ConfigSource._();
  ConfigSource createEmptyInstance() => create();
  static $pb.PbList<ConfigSource> createRepeated() =>
      $pb.PbList<ConfigSource>();
  @$core.pragma('dart2js:noInline')
  static ConfigSource getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfigSource>(create);
  static ConfigSource? _defaultInstance;

  /// Set of source configuration files that are used to generate a service
  /// configuration (`google.api.Service`).
  @$pb.TagNumber(2)
  $core.List<ConfigFile> get files => $_getList(0);

  /// A unique ID for a specific instance of this message, typically assigned
  /// by the client for tracking purpose. If empty, the server may choose to
  /// generate one instead.
  @$pb.TagNumber(5)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(5)
  set id($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(5)
  void clearId() => clearField(5);
}

/// Generic specification of a source configuration file
class ConfigFile extends $pb.GeneratedMessage {
  factory ConfigFile({
    $core.String? filePath,
    $core.List<$core.int>? fileContents,
    ConfigFile_FileType? fileType,
  }) {
    final $result = create();
    if (filePath != null) {
      $result.filePath = filePath;
    }
    if (fileContents != null) {
      $result.fileContents = fileContents;
    }
    if (fileType != null) {
      $result.fileType = fileType;
    }
    return $result;
  }
  ConfigFile._() : super();
  factory ConfigFile.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ConfigFile.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfigFile',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'filePath')
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'fileContents', $pb.PbFieldType.OY)
    ..e<ConfigFile_FileType>(
        4, _omitFieldNames ? '' : 'fileType', $pb.PbFieldType.OE,
        defaultOrMaker: ConfigFile_FileType.FILE_TYPE_UNSPECIFIED,
        valueOf: ConfigFile_FileType.valueOf,
        enumValues: ConfigFile_FileType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ConfigFile clone() => ConfigFile()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ConfigFile copyWith(void Function(ConfigFile) updates) =>
      super.copyWith((message) => updates(message as ConfigFile)) as ConfigFile;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfigFile create() => ConfigFile._();
  ConfigFile createEmptyInstance() => create();
  static $pb.PbList<ConfigFile> createRepeated() => $pb.PbList<ConfigFile>();
  @$core.pragma('dart2js:noInline')
  static ConfigFile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfigFile>(create);
  static ConfigFile? _defaultInstance;

  /// The file name of the configuration file (full or relative path).
  @$pb.TagNumber(1)
  $core.String get filePath => $_getSZ(0);
  @$pb.TagNumber(1)
  set filePath($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFilePath() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilePath() => clearField(1);

  /// The bytes that constitute the file.
  @$pb.TagNumber(3)
  $core.List<$core.int> get fileContents => $_getN(1);
  @$pb.TagNumber(3)
  set fileContents($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFileContents() => $_has(1);
  @$pb.TagNumber(3)
  void clearFileContents() => clearField(3);

  /// The type of configuration file this represents.
  @$pb.TagNumber(4)
  ConfigFile_FileType get fileType => $_getN(2);
  @$pb.TagNumber(4)
  set fileType(ConfigFile_FileType v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasFileType() => $_has(2);
  @$pb.TagNumber(4)
  void clearFileType() => clearField(4);
}

/// Represents a service configuration with its name and id.
class ConfigRef extends $pb.GeneratedMessage {
  factory ConfigRef({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  ConfigRef._() : super();
  factory ConfigRef.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ConfigRef.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfigRef',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ConfigRef clone() => ConfigRef()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ConfigRef copyWith(void Function(ConfigRef) updates) =>
      super.copyWith((message) => updates(message as ConfigRef)) as ConfigRef;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfigRef create() => ConfigRef._();
  ConfigRef createEmptyInstance() => create();
  static $pb.PbList<ConfigRef> createRepeated() => $pb.PbList<ConfigRef>();
  @$core.pragma('dart2js:noInline')
  static ConfigRef getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConfigRef>(create);
  static ConfigRef? _defaultInstance;

  /// Resource name of a service config. It must have the following
  /// format: "services/{service name}/configs/{config id}".
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

///  Change report associated with a particular service configuration.
///
///  It contains a list of ConfigChanges based on the comparison between
///  two service configurations.
class ChangeReport extends $pb.GeneratedMessage {
  factory ChangeReport({
    $core.Iterable<$80.ConfigChange>? configChanges,
  }) {
    final $result = create();
    if (configChanges != null) {
      $result.configChanges.addAll(configChanges);
    }
    return $result;
  }
  ChangeReport._() : super();
  factory ChangeReport.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ChangeReport.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChangeReport',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..pc<$80.ConfigChange>(
        1, _omitFieldNames ? '' : 'configChanges', $pb.PbFieldType.PM,
        subBuilder: $80.ConfigChange.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ChangeReport clone() => ChangeReport()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ChangeReport copyWith(void Function(ChangeReport) updates) =>
      super.copyWith((message) => updates(message as ChangeReport))
          as ChangeReport;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangeReport create() => ChangeReport._();
  ChangeReport createEmptyInstance() => create();
  static $pb.PbList<ChangeReport> createRepeated() =>
      $pb.PbList<ChangeReport>();
  @$core.pragma('dart2js:noInline')
  static ChangeReport getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChangeReport>(create);
  static ChangeReport? _defaultInstance;

  /// List of changes between two service configurations.
  /// The changes will be alphabetically sorted based on the identifier
  /// of each change.
  /// A ConfigChange identifier is a dot separated path to the configuration.
  /// Example: visibility.rules[selector='LibraryService.CreateBook'].restriction
  @$pb.TagNumber(1)
  $core.List<$80.ConfigChange> get configChanges => $_getList(0);
}

///  Strategy that specifies how clients of Google Service Controller want to
///  send traffic to use different config versions. This is generally
///  used by API proxy to split traffic based on your configured percentage for
///  each config version.
///
///  One example of how to gradually rollout a new service configuration using
///  this
///  strategy:
///  Day 1
///
///      Rollout {
///        id: "example.googleapis.com/rollout_20160206"
///        traffic_percent_strategy {
///          percentages: {
///            "example.googleapis.com/20160201": 70.00
///            "example.googleapis.com/20160206": 30.00
///          }
///        }
///      }
///
///  Day 2
///
///      Rollout {
///        id: "example.googleapis.com/rollout_20160207"
///        traffic_percent_strategy: {
///          percentages: {
///            "example.googleapis.com/20160206": 100.00
///          }
///        }
///      }
class Rollout_TrafficPercentStrategy extends $pb.GeneratedMessage {
  factory Rollout_TrafficPercentStrategy({
    $core.Map<$core.String, $core.double>? percentages,
  }) {
    final $result = create();
    if (percentages != null) {
      $result.percentages.addAll(percentages);
    }
    return $result;
  }
  Rollout_TrafficPercentStrategy._() : super();
  factory Rollout_TrafficPercentStrategy.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Rollout_TrafficPercentStrategy.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Rollout.TrafficPercentStrategy',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..m<$core.String, $core.double>(1, _omitFieldNames ? '' : 'percentages',
        entryClassName: 'Rollout.TrafficPercentStrategy.PercentagesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('google.api.servicemanagement.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Rollout_TrafficPercentStrategy clone() =>
      Rollout_TrafficPercentStrategy()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Rollout_TrafficPercentStrategy copyWith(
          void Function(Rollout_TrafficPercentStrategy) updates) =>
      super.copyWith(
              (message) => updates(message as Rollout_TrafficPercentStrategy))
          as Rollout_TrafficPercentStrategy;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Rollout_TrafficPercentStrategy create() =>
      Rollout_TrafficPercentStrategy._();
  Rollout_TrafficPercentStrategy createEmptyInstance() => create();
  static $pb.PbList<Rollout_TrafficPercentStrategy> createRepeated() =>
      $pb.PbList<Rollout_TrafficPercentStrategy>();
  @$core.pragma('dart2js:noInline')
  static Rollout_TrafficPercentStrategy getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Rollout_TrafficPercentStrategy>(create);
  static Rollout_TrafficPercentStrategy? _defaultInstance;

  /// Maps service configuration IDs to their corresponding traffic percentage.
  /// Key is the service configuration ID, Value is the traffic percentage
  /// which must be greater than 0.0 and the sum must equal to 100.0.
  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.double> get percentages => $_getMap(0);
}

/// Strategy used to delete a service. This strategy is a placeholder only
/// used by the system generated rollout to delete a service.
class Rollout_DeleteServiceStrategy extends $pb.GeneratedMessage {
  factory Rollout_DeleteServiceStrategy() => create();
  Rollout_DeleteServiceStrategy._() : super();
  factory Rollout_DeleteServiceStrategy.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Rollout_DeleteServiceStrategy.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Rollout.DeleteServiceStrategy',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Rollout_DeleteServiceStrategy clone() =>
      Rollout_DeleteServiceStrategy()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Rollout_DeleteServiceStrategy copyWith(
          void Function(Rollout_DeleteServiceStrategy) updates) =>
      super.copyWith(
              (message) => updates(message as Rollout_DeleteServiceStrategy))
          as Rollout_DeleteServiceStrategy;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Rollout_DeleteServiceStrategy create() =>
      Rollout_DeleteServiceStrategy._();
  Rollout_DeleteServiceStrategy createEmptyInstance() => create();
  static $pb.PbList<Rollout_DeleteServiceStrategy> createRepeated() =>
      $pb.PbList<Rollout_DeleteServiceStrategy>();
  @$core.pragma('dart2js:noInline')
  static Rollout_DeleteServiceStrategy getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Rollout_DeleteServiceStrategy>(create);
  static Rollout_DeleteServiceStrategy? _defaultInstance;
}

enum Rollout_Strategy { trafficPercentStrategy, deleteServiceStrategy, notSet }

/// A rollout resource that defines how service configuration versions are pushed
/// to control plane systems. Typically, you create a new version of the
/// service config, and then create a Rollout to push the service config.
class Rollout extends $pb.GeneratedMessage {
  factory Rollout({
    $core.String? rolloutId,
    $50.Timestamp? createTime,
    $core.String? createdBy,
    Rollout_RolloutStatus? status,
    Rollout_TrafficPercentStrategy? trafficPercentStrategy,
    $core.String? serviceName,
    Rollout_DeleteServiceStrategy? deleteServiceStrategy,
  }) {
    final $result = create();
    if (rolloutId != null) {
      $result.rolloutId = rolloutId;
    }
    if (createTime != null) {
      $result.createTime = createTime;
    }
    if (createdBy != null) {
      $result.createdBy = createdBy;
    }
    if (status != null) {
      $result.status = status;
    }
    if (trafficPercentStrategy != null) {
      $result.trafficPercentStrategy = trafficPercentStrategy;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (deleteServiceStrategy != null) {
      $result.deleteServiceStrategy = deleteServiceStrategy;
    }
    return $result;
  }
  Rollout._() : super();
  factory Rollout.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Rollout.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Rollout_Strategy> _Rollout_StrategyByTag = {
    5: Rollout_Strategy.trafficPercentStrategy,
    200: Rollout_Strategy.deleteServiceStrategy,
    0: Rollout_Strategy.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Rollout',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..oo(0, [5, 200])
    ..aOS(1, _omitFieldNames ? '' : 'rolloutId')
    ..aOM<$50.Timestamp>(2, _omitFieldNames ? '' : 'createTime',
        subBuilder: $50.Timestamp.create)
    ..aOS(3, _omitFieldNames ? '' : 'createdBy')
    ..e<Rollout_RolloutStatus>(
        4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: Rollout_RolloutStatus.ROLLOUT_STATUS_UNSPECIFIED,
        valueOf: Rollout_RolloutStatus.valueOf,
        enumValues: Rollout_RolloutStatus.values)
    ..aOM<Rollout_TrafficPercentStrategy>(
        5, _omitFieldNames ? '' : 'trafficPercentStrategy',
        subBuilder: Rollout_TrafficPercentStrategy.create)
    ..aOS(8, _omitFieldNames ? '' : 'serviceName')
    ..aOM<Rollout_DeleteServiceStrategy>(
        200, _omitFieldNames ? '' : 'deleteServiceStrategy',
        subBuilder: Rollout_DeleteServiceStrategy.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Rollout clone() => Rollout()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Rollout copyWith(void Function(Rollout) updates) =>
      super.copyWith((message) => updates(message as Rollout)) as Rollout;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Rollout create() => Rollout._();
  Rollout createEmptyInstance() => create();
  static $pb.PbList<Rollout> createRepeated() => $pb.PbList<Rollout>();
  @$core.pragma('dart2js:noInline')
  static Rollout getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Rollout>(create);
  static Rollout? _defaultInstance;

  Rollout_Strategy whichStrategy() => _Rollout_StrategyByTag[$_whichOneof(0)]!;
  void clearStrategy() => clearField($_whichOneof(0));

  ///  Optional. Unique identifier of this Rollout. Must be no longer than 63
  ///  characters and only lower case letters, digits, '.', '_' and '-' are
  ///  allowed.
  ///
  ///  If not specified by client, the server will generate one. The generated id
  ///  will have the form of <date><revision number>, where "date" is the create
  ///  date in ISO 8601 format.  "revision number" is a monotonically increasing
  ///  positive number that is reset every day for each service.
  ///  An example of the generated rollout_id is '2016-02-16r1'
  @$pb.TagNumber(1)
  $core.String get rolloutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set rolloutId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRolloutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRolloutId() => clearField(1);

  /// Creation time of the rollout. Readonly.
  @$pb.TagNumber(2)
  $50.Timestamp get createTime => $_getN(1);
  @$pb.TagNumber(2)
  set createTime($50.Timestamp v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCreateTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreateTime() => clearField(2);
  @$pb.TagNumber(2)
  $50.Timestamp ensureCreateTime() => $_ensure(1);

  /// The user who created the Rollout. Readonly.
  @$pb.TagNumber(3)
  $core.String get createdBy => $_getSZ(2);
  @$pb.TagNumber(3)
  set createdBy($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCreatedBy() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedBy() => clearField(3);

  /// The status of this rollout. Readonly. In case of a failed rollout,
  /// the system will automatically rollback to the current Rollout
  /// version. Readonly.
  @$pb.TagNumber(4)
  Rollout_RolloutStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(Rollout_RolloutStatus v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  /// Google Service Control selects service configurations based on
  /// traffic percentage.
  @$pb.TagNumber(5)
  Rollout_TrafficPercentStrategy get trafficPercentStrategy => $_getN(4);
  @$pb.TagNumber(5)
  set trafficPercentStrategy(Rollout_TrafficPercentStrategy v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasTrafficPercentStrategy() => $_has(4);
  @$pb.TagNumber(5)
  void clearTrafficPercentStrategy() => clearField(5);
  @$pb.TagNumber(5)
  Rollout_TrafficPercentStrategy ensureTrafficPercentStrategy() => $_ensure(4);

  /// The name of the service associated with this Rollout.
  @$pb.TagNumber(8)
  $core.String get serviceName => $_getSZ(5);
  @$pb.TagNumber(8)
  set serviceName($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasServiceName() => $_has(5);
  @$pb.TagNumber(8)
  void clearServiceName() => clearField(8);

  /// The strategy associated with a rollout to delete a `ManagedService`.
  /// Readonly.
  @$pb.TagNumber(200)
  Rollout_DeleteServiceStrategy get deleteServiceStrategy => $_getN(6);
  @$pb.TagNumber(200)
  set deleteServiceStrategy(Rollout_DeleteServiceStrategy v) {
    setField(200, v);
  }

  @$pb.TagNumber(200)
  $core.bool hasDeleteServiceStrategy() => $_has(6);
  @$pb.TagNumber(200)
  void clearDeleteServiceStrategy() => clearField(200);
  @$pb.TagNumber(200)
  Rollout_DeleteServiceStrategy ensureDeleteServiceStrategy() => $_ensure(6);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
