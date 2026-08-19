//
//  Generated code. Do not modify.
//  source: google/type/datetime.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/duration.pb.dart' as $51;

enum DateTime_TimeOffset { utcOffset, timeZone, notSet }

///  Represents civil time (or occasionally physical time).
///
///  This type can represent a civil time in one of a few possible ways:
///
///   * When utc_offset is set and time_zone is unset: a civil time on a calendar
///     day with a particular offset from UTC.
///   * When time_zone is set and utc_offset is unset: a civil time on a calendar
///     day in a particular time zone.
///   * When neither time_zone nor utc_offset is set: a civil time on a calendar
///     day in local time.
///
///  The date is relative to the Proleptic Gregorian Calendar.
///
///  If year is 0, the DateTime is considered not to have a specific year. month
///  and day must have valid, non-zero values.
///
///  This type may also be used to represent a physical time if all the date and
///  time fields are set and either case of the `time_offset` oneof is set.
///  Consider using `Timestamp` message for physical time instead. If your use
///  case also would like to store the user's timezone, that can be done in
///  another field.
///
///  This type is more flexible than some applications may want. Make sure to
///  document and validate your application's limitations.
class DateTime extends $pb.GeneratedMessage {
  factory DateTime({
    $core.int? year,
    $core.int? month,
    $core.int? day,
    $core.int? hours,
    $core.int? minutes,
    $core.int? seconds,
    $core.int? nanos,
    $51.Duration? utcOffset,
    TimeZone? timeZone,
  }) {
    final $result = create();
    if (year != null) {
      $result.year = year;
    }
    if (month != null) {
      $result.month = month;
    }
    if (day != null) {
      $result.day = day;
    }
    if (hours != null) {
      $result.hours = hours;
    }
    if (minutes != null) {
      $result.minutes = minutes;
    }
    if (seconds != null) {
      $result.seconds = seconds;
    }
    if (nanos != null) {
      $result.nanos = nanos;
    }
    if (utcOffset != null) {
      $result.utcOffset = utcOffset;
    }
    if (timeZone != null) {
      $result.timeZone = timeZone;
    }
    return $result;
  }
  DateTime._() : super();
  factory DateTime.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DateTime.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, DateTime_TimeOffset>
      _DateTime_TimeOffsetByTag = {
    8: DateTime_TimeOffset.utcOffset,
    9: DateTime_TimeOffset.timeZone,
    0: DateTime_TimeOffset.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DateTime',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.type'),
      createEmptyInstance: create)
    ..oo(0, [8, 9])
    ..a<$core.int>(1, _omitFieldNames ? '' : 'year', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'month', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'day', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'hours', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'minutes', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'seconds', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'nanos', $pb.PbFieldType.O3)
    ..aOM<$51.Duration>(8, _omitFieldNames ? '' : 'utcOffset',
        subBuilder: $51.Duration.create)
    ..aOM<TimeZone>(9, _omitFieldNames ? '' : 'timeZone',
        subBuilder: TimeZone.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DateTime clone() => DateTime()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DateTime copyWith(void Function(DateTime) updates) =>
      super.copyWith((message) => updates(message as DateTime)) as DateTime;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DateTime create() => DateTime._();
  DateTime createEmptyInstance() => create();
  static $pb.PbList<DateTime> createRepeated() => $pb.PbList<DateTime>();
  @$core.pragma('dart2js:noInline')
  static DateTime getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DateTime>(create);
  static DateTime? _defaultInstance;

  DateTime_TimeOffset whichTimeOffset() =>
      _DateTime_TimeOffsetByTag[$_whichOneof(0)]!;
  void clearTimeOffset() => clearField($_whichOneof(0));

  /// Optional. Year of date. Must be from 1 to 9999, or 0 if specifying a
  /// datetime without a year.
  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => clearField(1);

  /// Required. Month of year. Must be from 1 to 12.
  @$pb.TagNumber(2)
  $core.int get month => $_getIZ(1);
  @$pb.TagNumber(2)
  set month($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonth() => clearField(2);

  /// Required. Day of month. Must be from 1 to 31 and valid for the year and
  /// month.
  @$pb.TagNumber(3)
  $core.int get day => $_getIZ(2);
  @$pb.TagNumber(3)
  set day($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDay() => $_has(2);
  @$pb.TagNumber(3)
  void clearDay() => clearField(3);

  /// Required. Hours of day in 24 hour format. Should be from 0 to 23. An API
  /// may choose to allow the value "24:00:00" for scenarios like business
  /// closing time.
  @$pb.TagNumber(4)
  $core.int get hours => $_getIZ(3);
  @$pb.TagNumber(4)
  set hours($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasHours() => $_has(3);
  @$pb.TagNumber(4)
  void clearHours() => clearField(4);

  /// Required. Minutes of hour of day. Must be from 0 to 59.
  @$pb.TagNumber(5)
  $core.int get minutes => $_getIZ(4);
  @$pb.TagNumber(5)
  set minutes($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasMinutes() => $_has(4);
  @$pb.TagNumber(5)
  void clearMinutes() => clearField(5);

  /// Required. Seconds of minutes of the time. Must normally be from 0 to 59. An
  /// API may allow the value 60 if it allows leap-seconds.
  @$pb.TagNumber(6)
  $core.int get seconds => $_getIZ(5);
  @$pb.TagNumber(6)
  set seconds($core.int v) {
    $_setSignedInt32(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasSeconds() => $_has(5);
  @$pb.TagNumber(6)
  void clearSeconds() => clearField(6);

  /// Required. Fractions of seconds in nanoseconds. Must be from 0 to
  /// 999,999,999.
  @$pb.TagNumber(7)
  $core.int get nanos => $_getIZ(6);
  @$pb.TagNumber(7)
  set nanos($core.int v) {
    $_setSignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasNanos() => $_has(6);
  @$pb.TagNumber(7)
  void clearNanos() => clearField(7);

  /// UTC offset. Must be whole seconds, between -18 hours and +18 hours.
  /// For example, a UTC offset of -4:00 would be represented as
  /// { seconds: -14400 }.
  @$pb.TagNumber(8)
  $51.Duration get utcOffset => $_getN(7);
  @$pb.TagNumber(8)
  set utcOffset($51.Duration v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasUtcOffset() => $_has(7);
  @$pb.TagNumber(8)
  void clearUtcOffset() => clearField(8);
  @$pb.TagNumber(8)
  $51.Duration ensureUtcOffset() => $_ensure(7);

  /// Time zone.
  @$pb.TagNumber(9)
  TimeZone get timeZone => $_getN(8);
  @$pb.TagNumber(9)
  set timeZone(TimeZone v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasTimeZone() => $_has(8);
  @$pb.TagNumber(9)
  void clearTimeZone() => clearField(9);
  @$pb.TagNumber(9)
  TimeZone ensureTimeZone() => $_ensure(8);
}

/// Represents a time zone from the
/// [IANA Time Zone Database](https://www.iana.org/time-zones).
class TimeZone extends $pb.GeneratedMessage {
  factory TimeZone({
    $core.String? id,
    $core.String? version,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  TimeZone._() : super();
  factory TimeZone.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TimeZone.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TimeZone',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.type'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'version')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TimeZone clone() => TimeZone()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TimeZone copyWith(void Function(TimeZone) updates) =>
      super.copyWith((message) => updates(message as TimeZone)) as TimeZone;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimeZone create() => TimeZone._();
  TimeZone createEmptyInstance() => create();
  static $pb.PbList<TimeZone> createRepeated() => $pb.PbList<TimeZone>();
  @$core.pragma('dart2js:noInline')
  static TimeZone getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimeZone>(create);
  static TimeZone? _defaultInstance;

  /// IANA Time Zone Database time zone, e.g. "America/New_York".
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  /// Optional. IANA Time Zone Database version number, e.g. "2019a".
  @$pb.TagNumber(2)
  $core.String get version => $_getSZ(1);
  @$pb.TagNumber(2)
  set version($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
