//
//  Generated code. Do not modify.
//  source: google/api/expr/v1beta1/source.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Source information collected at parse time.
class SourceInfo extends $pb.GeneratedMessage {
  factory SourceInfo({
    $core.String? location,
    $core.Iterable<$core.int>? lineOffsets,
    $core.Map<$core.int, $core.int>? positions,
  }) {
    final $result = create();
    if (location != null) {
      $result.location = location;
    }
    if (lineOffsets != null) {
      $result.lineOffsets.addAll(lineOffsets);
    }
    if (positions != null) {
      $result.positions.addAll(positions);
    }
    return $result;
  }
  SourceInfo._() : super();
  factory SourceInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SourceInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourceInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'location')
    ..p<$core.int>(3, _omitFieldNames ? '' : 'lineOffsets', $pb.PbFieldType.K3)
    ..m<$core.int, $core.int>(4, _omitFieldNames ? '' : 'positions',
        entryClassName: 'SourceInfo.PositionsEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('google.api.expr.v1beta1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SourceInfo clone() => SourceInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SourceInfo copyWith(void Function(SourceInfo) updates) =>
      super.copyWith((message) => updates(message as SourceInfo)) as SourceInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourceInfo create() => SourceInfo._();
  SourceInfo createEmptyInstance() => create();
  static $pb.PbList<SourceInfo> createRepeated() => $pb.PbList<SourceInfo>();
  @$core.pragma('dart2js:noInline')
  static SourceInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourceInfo>(create);
  static SourceInfo? _defaultInstance;

  ///  The location name. All position information attached to an expression is
  ///  relative to this location.
  ///
  ///  The location could be a file, UI element, or similar. For example,
  ///  `acme/app/AnvilPolicy.cel`.
  @$pb.TagNumber(2)
  $core.String get location => $_getSZ(0);
  @$pb.TagNumber(2)
  set location($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLocation() => $_has(0);
  @$pb.TagNumber(2)
  void clearLocation() => clearField(2);

  ///  Monotonically increasing list of character offsets where newlines appear.
  ///
  ///  The line number of a given position is the index `i` where for a given
  ///  `id` the `line_offsets[i] < id_positions[id] < line_offsets[i+1]`. The
  ///  column may be derivd from `id_positions[id] - line_offsets[i]`.
  @$pb.TagNumber(3)
  $core.List<$core.int> get lineOffsets => $_getList(1);

  /// A map from the parse node id (e.g. `Expr.id`) to the character offset
  /// within source.
  @$pb.TagNumber(4)
  $core.Map<$core.int, $core.int> get positions => $_getMap(2);
}

/// A specific position in source.
class SourcePosition extends $pb.GeneratedMessage {
  factory SourcePosition({
    $core.String? location,
    $core.int? offset,
    $core.int? line,
    $core.int? column,
  }) {
    final $result = create();
    if (location != null) {
      $result.location = location;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    if (line != null) {
      $result.line = line;
    }
    if (column != null) {
      $result.column = column;
    }
    return $result;
  }
  SourcePosition._() : super();
  factory SourcePosition.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SourcePosition.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourcePosition',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'location')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'line', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'column', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SourcePosition clone() => SourcePosition()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SourcePosition copyWith(void Function(SourcePosition) updates) =>
      super.copyWith((message) => updates(message as SourcePosition))
          as SourcePosition;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourcePosition create() => SourcePosition._();
  SourcePosition createEmptyInstance() => create();
  static $pb.PbList<SourcePosition> createRepeated() =>
      $pb.PbList<SourcePosition>();
  @$core.pragma('dart2js:noInline')
  static SourcePosition getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourcePosition>(create);
  static SourcePosition? _defaultInstance;

  /// The soucre location name (e.g. file name).
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

  /// The character offset.
  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);

  /// The 1-based index of the starting line in the source text
  /// where the issue occurs, or 0 if unknown.
  @$pb.TagNumber(3)
  $core.int get line => $_getIZ(2);
  @$pb.TagNumber(3)
  set line($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLine() => $_has(2);
  @$pb.TagNumber(3)
  void clearLine() => clearField(3);

  /// The 0-based index of the starting position within the line of source text
  /// where the issue occurs.  Only meaningful if line is nonzer..
  @$pb.TagNumber(4)
  $core.int get column => $_getIZ(3);
  @$pb.TagNumber(4)
  set column($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasColumn() => $_has(3);
  @$pb.TagNumber(4)
  void clearColumn() => clearField(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
