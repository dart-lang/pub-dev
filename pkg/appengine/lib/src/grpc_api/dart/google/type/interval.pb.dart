//
//  Generated code. Do not modify.
//  source: google/type/interval.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/timestamp.pb.dart' as $50;

///  Represents a time interval, encoded as a Timestamp start (inclusive) and a
///  Timestamp end (exclusive).
///
///  The start must be less than or equal to the end.
///  When the start equals the end, the interval is empty (matches no time).
///  When both start and end are unspecified, the interval matches any time.
class Interval extends $pb.GeneratedMessage {
  factory Interval({
    $50.Timestamp? startTime,
    $50.Timestamp? endTime,
  }) {
    final $result = create();
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (endTime != null) {
      $result.endTime = endTime;
    }
    return $result;
  }
  Interval._() : super();
  factory Interval.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Interval.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Interval',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.type'),
      createEmptyInstance: create)
    ..aOM<$50.Timestamp>(1, _omitFieldNames ? '' : 'startTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(2, _omitFieldNames ? '' : 'endTime',
        subBuilder: $50.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Interval clone() => Interval()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Interval copyWith(void Function(Interval) updates) =>
      super.copyWith((message) => updates(message as Interval)) as Interval;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Interval create() => Interval._();
  Interval createEmptyInstance() => create();
  static $pb.PbList<Interval> createRepeated() => $pb.PbList<Interval>();
  @$core.pragma('dart2js:noInline')
  static Interval getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Interval>(create);
  static Interval? _defaultInstance;

  ///  Optional. Inclusive start of the interval.
  ///
  ///  If specified, a Timestamp matching this interval will have to be the same
  ///  or after the start.
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

  ///  Optional. Exclusive end of the interval.
  ///
  ///  If specified, a Timestamp matching this interval will have to be before the
  ///  end.
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
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
