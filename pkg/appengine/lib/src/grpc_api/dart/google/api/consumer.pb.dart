//
//  Generated code. Do not modify.
//  source: google/api/consumer.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'consumer.pbenum.dart';

export 'consumer.pbenum.dart';

///  A descriptor for defining project properties for a service. One service may
///  have many consumer projects, and the service may want to behave differently
///  depending on some properties on the project. For example, a project may be
///  associated with a school, or a business, or a government agency, a business
///  type property on the project may affect how a service responds to the client.
///  This descriptor defines which properties are allowed to be set on a project.
///
///  Example:
///
///     project_properties:
///       properties:
///       - name: NO_WATERMARK
///         type: BOOL
///         description: Allows usage of the API without watermarks.
///       - name: EXTENDED_TILE_CACHE_PERIOD
///         type: INT64
class ProjectProperties extends $pb.GeneratedMessage {
  factory ProjectProperties({
    $core.Iterable<Property>? properties,
  }) {
    final $result = create();
    if (properties != null) {
      $result.properties.addAll(properties);
    }
    return $result;
  }
  ProjectProperties._() : super();
  factory ProjectProperties.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ProjectProperties.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProjectProperties',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pc<Property>(1, _omitFieldNames ? '' : 'properties', $pb.PbFieldType.PM,
        subBuilder: Property.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ProjectProperties clone() => ProjectProperties()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ProjectProperties copyWith(void Function(ProjectProperties) updates) =>
      super.copyWith((message) => updates(message as ProjectProperties))
          as ProjectProperties;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProjectProperties create() => ProjectProperties._();
  ProjectProperties createEmptyInstance() => create();
  static $pb.PbList<ProjectProperties> createRepeated() =>
      $pb.PbList<ProjectProperties>();
  @$core.pragma('dart2js:noInline')
  static ProjectProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProjectProperties>(create);
  static ProjectProperties? _defaultInstance;

  /// List of per consumer project-specific properties.
  @$pb.TagNumber(1)
  $core.List<Property> get properties => $_getList(0);
}

///  Defines project properties.
///
///  API services can define properties that can be assigned to consumer projects
///  so that backends can perform response customization without having to make
///  additional calls or maintain additional storage. For example, Maps API
///  defines properties that controls map tile cache period, or whether to embed a
///  watermark in a result.
///
///  These values can be set via API producer console. Only API providers can
///  define and set these properties.
class Property extends $pb.GeneratedMessage {
  factory Property({
    $core.String? name,
    Property_PropertyType? type,
    $core.String? description,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (type != null) {
      $result.type = type;
    }
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  Property._() : super();
  factory Property.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Property.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Property',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<Property_PropertyType>(
        2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: Property_PropertyType.UNSPECIFIED,
        valueOf: Property_PropertyType.valueOf,
        enumValues: Property_PropertyType.values)
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Property clone() => Property()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Property copyWith(void Function(Property) updates) =>
      super.copyWith((message) => updates(message as Property)) as Property;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Property create() => Property._();
  Property createEmptyInstance() => create();
  static $pb.PbList<Property> createRepeated() => $pb.PbList<Property>();
  @$core.pragma('dart2js:noInline')
  static Property getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Property>(create);
  static Property? _defaultInstance;

  /// The name of the property (a.k.a key).
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

  /// The type of this property.
  @$pb.TagNumber(2)
  Property_PropertyType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(Property_PropertyType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  /// The description of the property
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
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
