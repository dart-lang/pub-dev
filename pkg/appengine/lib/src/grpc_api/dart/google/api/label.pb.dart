//
//  Generated code. Do not modify.
//  source: google/api/label.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'label.pbenum.dart';

export 'label.pbenum.dart';

/// A description of a label.
class LabelDescriptor extends $pb.GeneratedMessage {
  factory LabelDescriptor({
    $core.String? key,
    LabelDescriptor_ValueType? valueType,
    $core.String? description,
  }) {
    final $result = create();
    if (key != null) {
      $result.key = key;
    }
    if (valueType != null) {
      $result.valueType = valueType;
    }
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  LabelDescriptor._() : super();
  factory LabelDescriptor.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LabelDescriptor.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LabelDescriptor',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..e<LabelDescriptor_ValueType>(
        2, _omitFieldNames ? '' : 'valueType', $pb.PbFieldType.OE,
        defaultOrMaker: LabelDescriptor_ValueType.STRING,
        valueOf: LabelDescriptor_ValueType.valueOf,
        enumValues: LabelDescriptor_ValueType.values)
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LabelDescriptor clone() => LabelDescriptor()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LabelDescriptor copyWith(void Function(LabelDescriptor) updates) =>
      super.copyWith((message) => updates(message as LabelDescriptor))
          as LabelDescriptor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LabelDescriptor create() => LabelDescriptor._();
  LabelDescriptor createEmptyInstance() => create();
  static $pb.PbList<LabelDescriptor> createRepeated() =>
      $pb.PbList<LabelDescriptor>();
  @$core.pragma('dart2js:noInline')
  static LabelDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LabelDescriptor>(create);
  static LabelDescriptor? _defaultInstance;

  /// The label key.
  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  /// The type of data that can be assigned to the label.
  @$pb.TagNumber(2)
  LabelDescriptor_ValueType get valueType => $_getN(1);
  @$pb.TagNumber(2)
  set valueType(LabelDescriptor_ValueType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValueType() => $_has(1);
  @$pb.TagNumber(2)
  void clearValueType() => clearField(2);

  /// A human-readable description for the label.
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
