//
//  Generated code. Do not modify.
//  source: google/type/fraction.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

/// Represents a fraction in terms of a numerator divided by a denominator.
class Fraction extends $pb.GeneratedMessage {
  factory Fraction({
    $fixnum.Int64? numerator,
    $fixnum.Int64? denominator,
  }) {
    final $result = create();
    if (numerator != null) {
      $result.numerator = numerator;
    }
    if (denominator != null) {
      $result.denominator = denominator;
    }
    return $result;
  }
  Fraction._() : super();
  factory Fraction.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Fraction.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Fraction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.type'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'numerator')
    ..aInt64(2, _omitFieldNames ? '' : 'denominator')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Fraction clone() => Fraction()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Fraction copyWith(void Function(Fraction) updates) =>
      super.copyWith((message) => updates(message as Fraction)) as Fraction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Fraction create() => Fraction._();
  Fraction createEmptyInstance() => create();
  static $pb.PbList<Fraction> createRepeated() => $pb.PbList<Fraction>();
  @$core.pragma('dart2js:noInline')
  static Fraction getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Fraction>(create);
  static Fraction? _defaultInstance;

  /// The numerator in the fraction, e.g. 2 in 2/3.
  @$pb.TagNumber(1)
  $fixnum.Int64 get numerator => $_getI64(0);
  @$pb.TagNumber(1)
  set numerator($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNumerator() => $_has(0);
  @$pb.TagNumber(1)
  void clearNumerator() => clearField(1);

  /// The value by which the numerator is divided, e.g. 3 in 2/3. Must be
  /// positive.
  @$pb.TagNumber(2)
  $fixnum.Int64 get denominator => $_getI64(1);
  @$pb.TagNumber(2)
  set denominator($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDenominator() => $_has(1);
  @$pb.TagNumber(2)
  void clearDenominator() => clearField(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
