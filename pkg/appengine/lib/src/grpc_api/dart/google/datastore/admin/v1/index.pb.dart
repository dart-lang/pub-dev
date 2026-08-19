//
//  Generated code. Do not modify.
//  source: google/datastore/admin/v1/index.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'index.pbenum.dart';

export 'index.pbenum.dart';

/// A property of an index.
class Index_IndexedProperty extends $pb.GeneratedMessage {
  factory Index_IndexedProperty({
    $core.String? name,
    Index_Direction? direction,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (direction != null) {
      $result.direction = direction;
    }
    return $result;
  }
  Index_IndexedProperty._() : super();
  factory Index_IndexedProperty.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Index_IndexedProperty.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Index.IndexedProperty',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<Index_Direction>(
        2, _omitFieldNames ? '' : 'direction', $pb.PbFieldType.OE,
        defaultOrMaker: Index_Direction.DIRECTION_UNSPECIFIED,
        valueOf: Index_Direction.valueOf,
        enumValues: Index_Direction.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Index_IndexedProperty clone() =>
      Index_IndexedProperty()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Index_IndexedProperty copyWith(
          void Function(Index_IndexedProperty) updates) =>
      super.copyWith((message) => updates(message as Index_IndexedProperty))
          as Index_IndexedProperty;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Index_IndexedProperty create() => Index_IndexedProperty._();
  Index_IndexedProperty createEmptyInstance() => create();
  static $pb.PbList<Index_IndexedProperty> createRepeated() =>
      $pb.PbList<Index_IndexedProperty>();
  @$core.pragma('dart2js:noInline')
  static Index_IndexedProperty getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Index_IndexedProperty>(create);
  static Index_IndexedProperty? _defaultInstance;

  /// Required. The property name to index.
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

  /// Required. The indexed property's direction.  Must not be
  /// DIRECTION_UNSPECIFIED.
  @$pb.TagNumber(2)
  Index_Direction get direction => $_getN(1);
  @$pb.TagNumber(2)
  set direction(Index_Direction v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDirection() => $_has(1);
  @$pb.TagNumber(2)
  void clearDirection() => clearField(2);
}

/// Datastore composite index definition.
class Index extends $pb.GeneratedMessage {
  factory Index({
    $core.String? projectId,
    $core.String? indexId,
    $core.String? kind,
    Index_AncestorMode? ancestor,
    $core.Iterable<Index_IndexedProperty>? properties,
    Index_State? state,
  }) {
    final $result = create();
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (indexId != null) {
      $result.indexId = indexId;
    }
    if (kind != null) {
      $result.kind = kind;
    }
    if (ancestor != null) {
      $result.ancestor = ancestor;
    }
    if (properties != null) {
      $result.properties.addAll(properties);
    }
    if (state != null) {
      $result.state = state;
    }
    return $result;
  }
  Index._() : super();
  factory Index.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Index.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Index',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.datastore.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'projectId')
    ..aOS(3, _omitFieldNames ? '' : 'indexId')
    ..aOS(4, _omitFieldNames ? '' : 'kind')
    ..e<Index_AncestorMode>(
        5, _omitFieldNames ? '' : 'ancestor', $pb.PbFieldType.OE,
        defaultOrMaker: Index_AncestorMode.ANCESTOR_MODE_UNSPECIFIED,
        valueOf: Index_AncestorMode.valueOf,
        enumValues: Index_AncestorMode.values)
    ..pc<Index_IndexedProperty>(
        6, _omitFieldNames ? '' : 'properties', $pb.PbFieldType.PM,
        subBuilder: Index_IndexedProperty.create)
    ..e<Index_State>(7, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE,
        defaultOrMaker: Index_State.STATE_UNSPECIFIED,
        valueOf: Index_State.valueOf,
        enumValues: Index_State.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Index clone() => Index()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Index copyWith(void Function(Index) updates) =>
      super.copyWith((message) => updates(message as Index)) as Index;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Index create() => Index._();
  Index createEmptyInstance() => create();
  static $pb.PbList<Index> createRepeated() => $pb.PbList<Index>();
  @$core.pragma('dart2js:noInline')
  static Index getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Index>(create);
  static Index? _defaultInstance;

  /// Output only. Project ID.
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

  /// Output only. The resource ID of the index.
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

  /// Required. The entity kind to which this index applies.
  @$pb.TagNumber(4)
  $core.String get kind => $_getSZ(2);
  @$pb.TagNumber(4)
  set kind($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasKind() => $_has(2);
  @$pb.TagNumber(4)
  void clearKind() => clearField(4);

  /// Required. The index's ancestor mode.  Must not be
  /// ANCESTOR_MODE_UNSPECIFIED.
  @$pb.TagNumber(5)
  Index_AncestorMode get ancestor => $_getN(3);
  @$pb.TagNumber(5)
  set ancestor(Index_AncestorMode v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasAncestor() => $_has(3);
  @$pb.TagNumber(5)
  void clearAncestor() => clearField(5);

  ///  Required. An ordered sequence of property names and their index attributes.
  ///
  ///  Requires:
  ///
  ///  * A maximum of 100 properties.
  @$pb.TagNumber(6)
  $core.List<Index_IndexedProperty> get properties => $_getList(4);

  /// Output only. The state of the index.
  @$pb.TagNumber(7)
  Index_State get state => $_getN(5);
  @$pb.TagNumber(7)
  set state(Index_State v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasState() => $_has(5);
  @$pb.TagNumber(7)
  void clearState() => clearField(7);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
