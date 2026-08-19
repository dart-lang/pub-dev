//
//  Generated code. Do not modify.
//  source: google/api/monitored_resource.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/struct.pb.dart' as $48;
import 'label.pb.dart' as $65;
import 'launch_stage.pbenum.dart' as $56;

///  An object that describes the schema of a
///  [MonitoredResource][google.api.MonitoredResource] object using a type name
///  and a set of labels.  For example, the monitored resource descriptor for
///  Google Compute Engine VM instances has a type of
///  `"gce_instance"` and specifies the use of the labels `"instance_id"` and
///  `"zone"` to identify particular VM instances.
///
///  Different APIs can support different monitored resource types. APIs generally
///  provide a `list` method that returns the monitored resource descriptors used
///  by the API.
class MonitoredResourceDescriptor extends $pb.GeneratedMessage {
  factory MonitoredResourceDescriptor({
    $core.String? type,
    $core.String? displayName,
    $core.String? description,
    $core.Iterable<$65.LabelDescriptor>? labels,
    $core.String? name,
    $56.LaunchStage? launchStage,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (description != null) {
      $result.description = description;
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (name != null) {
      $result.name = name;
    }
    if (launchStage != null) {
      $result.launchStage = launchStage;
    }
    return $result;
  }
  MonitoredResourceDescriptor._() : super();
  factory MonitoredResourceDescriptor.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MonitoredResourceDescriptor.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MonitoredResourceDescriptor',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..pc<$65.LabelDescriptor>(
        4, _omitFieldNames ? '' : 'labels', $pb.PbFieldType.PM,
        subBuilder: $65.LabelDescriptor.create)
    ..aOS(5, _omitFieldNames ? '' : 'name')
    ..e<$56.LaunchStage>(
        7, _omitFieldNames ? '' : 'launchStage', $pb.PbFieldType.OE,
        defaultOrMaker: $56.LaunchStage.LAUNCH_STAGE_UNSPECIFIED,
        valueOf: $56.LaunchStage.valueOf,
        enumValues: $56.LaunchStage.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MonitoredResourceDescriptor clone() =>
      MonitoredResourceDescriptor()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MonitoredResourceDescriptor copyWith(
          void Function(MonitoredResourceDescriptor) updates) =>
      super.copyWith(
              (message) => updates(message as MonitoredResourceDescriptor))
          as MonitoredResourceDescriptor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitoredResourceDescriptor create() =>
      MonitoredResourceDescriptor._();
  MonitoredResourceDescriptor createEmptyInstance() => create();
  static $pb.PbList<MonitoredResourceDescriptor> createRepeated() =>
      $pb.PbList<MonitoredResourceDescriptor>();
  @$core.pragma('dart2js:noInline')
  static MonitoredResourceDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonitoredResourceDescriptor>(create);
  static MonitoredResourceDescriptor? _defaultInstance;

  /// Required. The monitored resource type. For example, the type
  /// `"cloudsql_database"` represents databases in Google Cloud SQL.
  ///  For a list of types, see [Monitored resource
  ///  types](https://cloud.google.com/monitoring/api/resources)
  /// and [Logging resource
  /// types](https://cloud.google.com/logging/docs/api/v2/resource-list).
  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  /// Optional. A concise name for the monitored resource type that might be
  /// displayed in user interfaces. It should be a Title Cased Noun Phrase,
  /// without any article or other determiners. For example,
  /// `"Google Cloud SQL Database"`.
  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  /// Optional. A detailed description of the monitored resource type that might
  /// be used in documentation.
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

  /// Required. A set of labels used to describe instances of this monitored
  /// resource type. For example, an individual Google Cloud SQL database is
  /// identified by values for the labels `"database_id"` and `"zone"`.
  @$pb.TagNumber(4)
  $core.List<$65.LabelDescriptor> get labels => $_getList(3);

  /// Optional. The resource name of the monitored resource descriptor:
  /// `"projects/{project_id}/monitoredResourceDescriptors/{type}"` where
  /// {type} is the value of the `type` field in this object and
  /// {project_id} is a project ID that provides API-specific context for
  /// accessing the type.  APIs that do not use project information can use the
  /// resource name format `"monitoredResourceDescriptors/{type}"`.
  @$pb.TagNumber(5)
  $core.String get name => $_getSZ(4);
  @$pb.TagNumber(5)
  set name($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(5)
  void clearName() => clearField(5);

  /// Optional. The launch stage of the monitored resource definition.
  @$pb.TagNumber(7)
  $56.LaunchStage get launchStage => $_getN(5);
  @$pb.TagNumber(7)
  set launchStage($56.LaunchStage v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasLaunchStage() => $_has(5);
  @$pb.TagNumber(7)
  void clearLaunchStage() => clearField(7);
}

///  An object representing a resource that can be used for monitoring, logging,
///  billing, or other purposes. Examples include virtual machine instances,
///  databases, and storage devices such as disks. The `type` field identifies a
///  [MonitoredResourceDescriptor][google.api.MonitoredResourceDescriptor] object
///  that describes the resource's schema. Information in the `labels` field
///  identifies the actual resource and its attributes according to the schema.
///  For example, a particular Compute Engine VM instance could be represented by
///  the following object, because the
///  [MonitoredResourceDescriptor][google.api.MonitoredResourceDescriptor] for
///  `"gce_instance"` has labels
///  `"project_id"`, `"instance_id"` and `"zone"`:
///
///      { "type": "gce_instance",
///        "labels": { "project_id": "my-project",
///                    "instance_id": "12345678901234",
///                    "zone": "us-central1-a" }}
class MonitoredResource extends $pb.GeneratedMessage {
  factory MonitoredResource({
    $core.String? type,
    $core.Map<$core.String, $core.String>? labels,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    return $result;
  }
  MonitoredResource._() : super();
  factory MonitoredResource.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MonitoredResource.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MonitoredResource',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'labels',
        entryClassName: 'MonitoredResource.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api'))
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MonitoredResource clone() => MonitoredResource()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MonitoredResource copyWith(void Function(MonitoredResource) updates) =>
      super.copyWith((message) => updates(message as MonitoredResource))
          as MonitoredResource;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitoredResource create() => MonitoredResource._();
  MonitoredResource createEmptyInstance() => create();
  static $pb.PbList<MonitoredResource> createRepeated() =>
      $pb.PbList<MonitoredResource>();
  @$core.pragma('dart2js:noInline')
  static MonitoredResource getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonitoredResource>(create);
  static MonitoredResource? _defaultInstance;

  /// Required. The monitored resource type. This field must match
  /// the `type` field of a
  /// [MonitoredResourceDescriptor][google.api.MonitoredResourceDescriptor]
  /// object. For example, the type of a Compute Engine VM instance is
  /// `gce_instance`. Some descriptors include the service name in the type; for
  /// example, the type of a Datastream stream is
  /// `datastream.googleapis.com/Stream`.
  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  /// Required. Values for all of the labels listed in the associated monitored
  /// resource descriptor. For example, Compute Engine VM instances use the
  /// labels `"project_id"`, `"instance_id"`, and `"zone"`.
  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get labels => $_getMap(1);
}

/// Auxiliary metadata for a [MonitoredResource][google.api.MonitoredResource]
/// object. [MonitoredResource][google.api.MonitoredResource] objects contain the
/// minimum set of information to uniquely identify a monitored resource
/// instance. There is some other useful auxiliary metadata. Monitoring and
/// Logging use an ingestion pipeline to extract metadata for cloud resources of
/// all types, and store the metadata in this message.
class MonitoredResourceMetadata extends $pb.GeneratedMessage {
  factory MonitoredResourceMetadata({
    $48.Struct? systemLabels,
    $core.Map<$core.String, $core.String>? userLabels,
  }) {
    final $result = create();
    if (systemLabels != null) {
      $result.systemLabels = systemLabels;
    }
    if (userLabels != null) {
      $result.userLabels.addAll(userLabels);
    }
    return $result;
  }
  MonitoredResourceMetadata._() : super();
  factory MonitoredResourceMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MonitoredResourceMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MonitoredResourceMetadata',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOM<$48.Struct>(1, _omitFieldNames ? '' : 'systemLabels',
        subBuilder: $48.Struct.create)
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'userLabels',
        entryClassName: 'MonitoredResourceMetadata.UserLabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api'))
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MonitoredResourceMetadata clone() =>
      MonitoredResourceMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MonitoredResourceMetadata copyWith(
          void Function(MonitoredResourceMetadata) updates) =>
      super.copyWith((message) => updates(message as MonitoredResourceMetadata))
          as MonitoredResourceMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitoredResourceMetadata create() => MonitoredResourceMetadata._();
  MonitoredResourceMetadata createEmptyInstance() => create();
  static $pb.PbList<MonitoredResourceMetadata> createRepeated() =>
      $pb.PbList<MonitoredResourceMetadata>();
  @$core.pragma('dart2js:noInline')
  static MonitoredResourceMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonitoredResourceMetadata>(create);
  static MonitoredResourceMetadata? _defaultInstance;

  ///  Output only. Values for predefined system metadata labels.
  ///  System labels are a kind of metadata extracted by Google, including
  ///  "machine_image", "vpc", "subnet_id",
  ///  "security_group", "name", etc.
  ///  System label values can be only strings, Boolean values, or a list of
  ///  strings. For example:
  ///
  ///      { "name": "my-test-instance",
  ///        "security_group": ["a", "b", "c"],
  ///        "spot_instance": false }
  @$pb.TagNumber(1)
  $48.Struct get systemLabels => $_getN(0);
  @$pb.TagNumber(1)
  set systemLabels($48.Struct v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSystemLabels() => $_has(0);
  @$pb.TagNumber(1)
  void clearSystemLabels() => clearField(1);
  @$pb.TagNumber(1)
  $48.Struct ensureSystemLabels() => $_ensure(0);

  /// Output only. A map of user-defined metadata labels.
  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get userLabels => $_getMap(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
