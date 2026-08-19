//
//  Generated code. Do not modify.
//  source: google/protobuf/cpp_features.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'cpp_features.pbenum.dart';

export 'cpp_features.pbenum.dart';

class CppFeatures extends $pb.GeneratedMessage {
  factory CppFeatures({
    $core.bool? legacyClosedEnum,
    CppFeatures_StringType? stringType,
    $core.bool? enumNameUsesStringView,
  }) {
    final $result = create();
    if (legacyClosedEnum != null) {
      $result.legacyClosedEnum = legacyClosedEnum;
    }
    if (stringType != null) {
      $result.stringType = stringType;
    }
    if (enumNameUsesStringView != null) {
      $result.enumNameUsesStringView = enumNameUsesStringView;
    }
    return $result;
  }
  CppFeatures._() : super();
  factory CppFeatures.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CppFeatures.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CppFeatures',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'legacyClosedEnum')
    ..e<CppFeatures_StringType>(
        2, _omitFieldNames ? '' : 'stringType', $pb.PbFieldType.OE,
        defaultOrMaker: CppFeatures_StringType.STRING_TYPE_UNKNOWN,
        valueOf: CppFeatures_StringType.valueOf,
        enumValues: CppFeatures_StringType.values)
    ..aOB(3, _omitFieldNames ? '' : 'enumNameUsesStringView')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CppFeatures clone() => CppFeatures()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CppFeatures copyWith(void Function(CppFeatures) updates) =>
      super.copyWith((message) => updates(message as CppFeatures))
          as CppFeatures;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CppFeatures create() => CppFeatures._();
  CppFeatures createEmptyInstance() => create();
  static $pb.PbList<CppFeatures> createRepeated() => $pb.PbList<CppFeatures>();
  @$core.pragma('dart2js:noInline')
  static CppFeatures getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CppFeatures>(create);
  static CppFeatures? _defaultInstance;

  /// Whether or not to treat an enum field as closed.  This option is only
  /// applicable to enum fields, and will be removed in the future.  It is
  /// consistent with the legacy behavior of using proto3 enum types for proto2
  /// fields.
  @$pb.TagNumber(1)
  $core.bool get legacyClosedEnum => $_getBF(0);
  @$pb.TagNumber(1)
  set legacyClosedEnum($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLegacyClosedEnum() => $_has(0);
  @$pb.TagNumber(1)
  void clearLegacyClosedEnum() => clearField(1);

  @$pb.TagNumber(2)
  CppFeatures_StringType get stringType => $_getN(1);
  @$pb.TagNumber(2)
  set stringType(CppFeatures_StringType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasStringType() => $_has(1);
  @$pb.TagNumber(2)
  void clearStringType() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get enumNameUsesStringView => $_getBF(2);
  @$pb.TagNumber(3)
  set enumNameUsesStringView($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEnumNameUsesStringView() => $_has(2);
  @$pb.TagNumber(3)
  void clearEnumNameUsesStringView() => clearField(3);
}

class Cpp_features {
  static final cpp = $pb.Extension<CppFeatures>(
      _omitMessageNames ? '' : 'google.protobuf.FeatureSet',
      _omitFieldNames ? '' : 'cpp',
      1000,
      $pb.PbFieldType.OM,
      defaultOrMaker: CppFeatures.getDefault,
      subBuilder: CppFeatures.create);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(cpp);
  }
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
