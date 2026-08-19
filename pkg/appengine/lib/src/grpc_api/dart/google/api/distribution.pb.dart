//
//  Generated code. Do not modify.
//  source: google/api/distribution.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/any.pb.dart' as $49;
import '../protobuf/timestamp.pb.dart' as $50;

/// The range of the population values.
class Distribution_Range extends $pb.GeneratedMessage {
  factory Distribution_Range({
    $core.double? min,
    $core.double? max,
  }) {
    final $result = create();
    if (min != null) {
      $result.min = min;
    }
    if (max != null) {
      $result.max = max;
    }
    return $result;
  }
  Distribution_Range._() : super();
  factory Distribution_Range.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Distribution_Range.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Distribution.Range',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'min', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'max', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Distribution_Range clone() => Distribution_Range()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Distribution_Range copyWith(void Function(Distribution_Range) updates) =>
      super.copyWith((message) => updates(message as Distribution_Range))
          as Distribution_Range;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Distribution_Range create() => Distribution_Range._();
  Distribution_Range createEmptyInstance() => create();
  static $pb.PbList<Distribution_Range> createRepeated() =>
      $pb.PbList<Distribution_Range>();
  @$core.pragma('dart2js:noInline')
  static Distribution_Range getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Distribution_Range>(create);
  static Distribution_Range? _defaultInstance;

  /// The minimum of the population values.
  @$pb.TagNumber(1)
  $core.double get min => $_getN(0);
  @$pb.TagNumber(1)
  set min($core.double v) {
    $_setDouble(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMin() => $_has(0);
  @$pb.TagNumber(1)
  void clearMin() => clearField(1);

  /// The maximum of the population values.
  @$pb.TagNumber(2)
  $core.double get max => $_getN(1);
  @$pb.TagNumber(2)
  set max($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMax() => $_has(1);
  @$pb.TagNumber(2)
  void clearMax() => clearField(2);
}

///  Specifies a linear sequence of buckets that all have the same width
///  (except overflow and underflow). Each bucket represents a constant
///  absolute uncertainty on the specific value in the bucket.
///
///  There are `num_finite_buckets + 2` (= N) buckets. Bucket `i` has the
///  following boundaries:
///
///     Upper bound (0 <= i < N-1):     offset + (width * i).
///
///     Lower bound (1 <= i < N):       offset + (width * (i - 1)).
class Distribution_BucketOptions_Linear extends $pb.GeneratedMessage {
  factory Distribution_BucketOptions_Linear({
    $core.int? numFiniteBuckets,
    $core.double? width,
    $core.double? offset,
  }) {
    final $result = create();
    if (numFiniteBuckets != null) {
      $result.numFiniteBuckets = numFiniteBuckets;
    }
    if (width != null) {
      $result.width = width;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  Distribution_BucketOptions_Linear._() : super();
  factory Distribution_BucketOptions_Linear.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Distribution_BucketOptions_Linear.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Distribution.BucketOptions.Linear',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'numFiniteBuckets', $pb.PbFieldType.O3)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'width', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Distribution_BucketOptions_Linear clone() =>
      Distribution_BucketOptions_Linear()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Distribution_BucketOptions_Linear copyWith(
          void Function(Distribution_BucketOptions_Linear) updates) =>
      super.copyWith((message) =>
              updates(message as Distribution_BucketOptions_Linear))
          as Distribution_BucketOptions_Linear;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Distribution_BucketOptions_Linear create() =>
      Distribution_BucketOptions_Linear._();
  Distribution_BucketOptions_Linear createEmptyInstance() => create();
  static $pb.PbList<Distribution_BucketOptions_Linear> createRepeated() =>
      $pb.PbList<Distribution_BucketOptions_Linear>();
  @$core.pragma('dart2js:noInline')
  static Distribution_BucketOptions_Linear getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Distribution_BucketOptions_Linear>(
          create);
  static Distribution_BucketOptions_Linear? _defaultInstance;

  /// Must be greater than 0.
  @$pb.TagNumber(1)
  $core.int get numFiniteBuckets => $_getIZ(0);
  @$pb.TagNumber(1)
  set numFiniteBuckets($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNumFiniteBuckets() => $_has(0);
  @$pb.TagNumber(1)
  void clearNumFiniteBuckets() => clearField(1);

  /// Must be greater than 0.
  @$pb.TagNumber(2)
  $core.double get width => $_getN(1);
  @$pb.TagNumber(2)
  set width($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasWidth() => $_has(1);
  @$pb.TagNumber(2)
  void clearWidth() => clearField(2);

  /// Lower bound of the first bucket.
  @$pb.TagNumber(3)
  $core.double get offset => $_getN(2);
  @$pb.TagNumber(3)
  set offset($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => clearField(3);
}

///  Specifies an exponential sequence of buckets that have a width that is
///  proportional to the value of the lower bound. Each bucket represents a
///  constant relative uncertainty on a specific value in the bucket.
///
///  There are `num_finite_buckets + 2` (= N) buckets. Bucket `i` has the
///  following boundaries:
///
///     Upper bound (0 <= i < N-1):     scale * (growth_factor ^ i).
///
///     Lower bound (1 <= i < N):       scale * (growth_factor ^ (i - 1)).
class Distribution_BucketOptions_Exponential extends $pb.GeneratedMessage {
  factory Distribution_BucketOptions_Exponential({
    $core.int? numFiniteBuckets,
    $core.double? growthFactor,
    $core.double? scale,
  }) {
    final $result = create();
    if (numFiniteBuckets != null) {
      $result.numFiniteBuckets = numFiniteBuckets;
    }
    if (growthFactor != null) {
      $result.growthFactor = growthFactor;
    }
    if (scale != null) {
      $result.scale = scale;
    }
    return $result;
  }
  Distribution_BucketOptions_Exponential._() : super();
  factory Distribution_BucketOptions_Exponential.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Distribution_BucketOptions_Exponential.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Distribution.BucketOptions.Exponential',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'numFiniteBuckets', $pb.PbFieldType.O3)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'growthFactor', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'scale', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Distribution_BucketOptions_Exponential clone() =>
      Distribution_BucketOptions_Exponential()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Distribution_BucketOptions_Exponential copyWith(
          void Function(Distribution_BucketOptions_Exponential) updates) =>
      super.copyWith((message) =>
              updates(message as Distribution_BucketOptions_Exponential))
          as Distribution_BucketOptions_Exponential;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Distribution_BucketOptions_Exponential create() =>
      Distribution_BucketOptions_Exponential._();
  Distribution_BucketOptions_Exponential createEmptyInstance() => create();
  static $pb.PbList<Distribution_BucketOptions_Exponential> createRepeated() =>
      $pb.PbList<Distribution_BucketOptions_Exponential>();
  @$core.pragma('dart2js:noInline')
  static Distribution_BucketOptions_Exponential getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          Distribution_BucketOptions_Exponential>(create);
  static Distribution_BucketOptions_Exponential? _defaultInstance;

  /// Must be greater than 0.
  @$pb.TagNumber(1)
  $core.int get numFiniteBuckets => $_getIZ(0);
  @$pb.TagNumber(1)
  set numFiniteBuckets($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNumFiniteBuckets() => $_has(0);
  @$pb.TagNumber(1)
  void clearNumFiniteBuckets() => clearField(1);

  /// Must be greater than 1.
  @$pb.TagNumber(2)
  $core.double get growthFactor => $_getN(1);
  @$pb.TagNumber(2)
  set growthFactor($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasGrowthFactor() => $_has(1);
  @$pb.TagNumber(2)
  void clearGrowthFactor() => clearField(2);

  /// Must be greater than 0.
  @$pb.TagNumber(3)
  $core.double get scale => $_getN(2);
  @$pb.TagNumber(3)
  set scale($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasScale() => $_has(2);
  @$pb.TagNumber(3)
  void clearScale() => clearField(3);
}

///  Specifies a set of buckets with arbitrary widths.
///
///  There are `size(bounds) + 1` (= N) buckets. Bucket `i` has the following
///  boundaries:
///
///     Upper bound (0 <= i < N-1):     bounds[i]
///     Lower bound (1 <= i < N);       bounds[i - 1]
///
///  The `bounds` field must contain at least one element. If `bounds` has
///  only one element, then there are no finite buckets, and that single
///  element is the common boundary of the overflow and underflow buckets.
class Distribution_BucketOptions_Explicit extends $pb.GeneratedMessage {
  factory Distribution_BucketOptions_Explicit({
    $core.Iterable<$core.double>? bounds,
  }) {
    final $result = create();
    if (bounds != null) {
      $result.bounds.addAll(bounds);
    }
    return $result;
  }
  Distribution_BucketOptions_Explicit._() : super();
  factory Distribution_BucketOptions_Explicit.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Distribution_BucketOptions_Explicit.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Distribution.BucketOptions.Explicit',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..p<$core.double>(1, _omitFieldNames ? '' : 'bounds', $pb.PbFieldType.KD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Distribution_BucketOptions_Explicit clone() =>
      Distribution_BucketOptions_Explicit()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Distribution_BucketOptions_Explicit copyWith(
          void Function(Distribution_BucketOptions_Explicit) updates) =>
      super.copyWith((message) =>
              updates(message as Distribution_BucketOptions_Explicit))
          as Distribution_BucketOptions_Explicit;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Distribution_BucketOptions_Explicit create() =>
      Distribution_BucketOptions_Explicit._();
  Distribution_BucketOptions_Explicit createEmptyInstance() => create();
  static $pb.PbList<Distribution_BucketOptions_Explicit> createRepeated() =>
      $pb.PbList<Distribution_BucketOptions_Explicit>();
  @$core.pragma('dart2js:noInline')
  static Distribution_BucketOptions_Explicit getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          Distribution_BucketOptions_Explicit>(create);
  static Distribution_BucketOptions_Explicit? _defaultInstance;

  /// The values must be monotonically increasing.
  @$pb.TagNumber(1)
  $core.List<$core.double> get bounds => $_getList(0);
}

enum Distribution_BucketOptions_Options {
  linearBuckets,
  exponentialBuckets,
  explicitBuckets,
  notSet
}

///  `BucketOptions` describes the bucket boundaries used to create a histogram
///  for the distribution. The buckets can be in a linear sequence, an
///  exponential sequence, or each bucket can be specified explicitly.
///  `BucketOptions` does not include the number of values in each bucket.
///
///  A bucket has an inclusive lower bound and exclusive upper bound for the
///  values that are counted for that bucket. The upper bound of a bucket must
///  be strictly greater than the lower bound. The sequence of N buckets for a
///  distribution consists of an underflow bucket (number 0), zero or more
///  finite buckets (number 1 through N - 2) and an overflow bucket (number N -
///  1). The buckets are contiguous: the lower bound of bucket i (i > 0) is the
///  same as the upper bound of bucket i - 1. The buckets span the whole range
///  of finite values: lower bound of the underflow bucket is -infinity and the
///  upper bound of the overflow bucket is +infinity. The finite buckets are
///  so-called because both bounds are finite.
class Distribution_BucketOptions extends $pb.GeneratedMessage {
  factory Distribution_BucketOptions({
    Distribution_BucketOptions_Linear? linearBuckets,
    Distribution_BucketOptions_Exponential? exponentialBuckets,
    Distribution_BucketOptions_Explicit? explicitBuckets,
  }) {
    final $result = create();
    if (linearBuckets != null) {
      $result.linearBuckets = linearBuckets;
    }
    if (exponentialBuckets != null) {
      $result.exponentialBuckets = exponentialBuckets;
    }
    if (explicitBuckets != null) {
      $result.explicitBuckets = explicitBuckets;
    }
    return $result;
  }
  Distribution_BucketOptions._() : super();
  factory Distribution_BucketOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Distribution_BucketOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Distribution_BucketOptions_Options>
      _Distribution_BucketOptions_OptionsByTag = {
    1: Distribution_BucketOptions_Options.linearBuckets,
    2: Distribution_BucketOptions_Options.exponentialBuckets,
    3: Distribution_BucketOptions_Options.explicitBuckets,
    0: Distribution_BucketOptions_Options.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Distribution.BucketOptions',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<Distribution_BucketOptions_Linear>(
        1, _omitFieldNames ? '' : 'linearBuckets',
        subBuilder: Distribution_BucketOptions_Linear.create)
    ..aOM<Distribution_BucketOptions_Exponential>(
        2, _omitFieldNames ? '' : 'exponentialBuckets',
        subBuilder: Distribution_BucketOptions_Exponential.create)
    ..aOM<Distribution_BucketOptions_Explicit>(
        3, _omitFieldNames ? '' : 'explicitBuckets',
        subBuilder: Distribution_BucketOptions_Explicit.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Distribution_BucketOptions clone() =>
      Distribution_BucketOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Distribution_BucketOptions copyWith(
          void Function(Distribution_BucketOptions) updates) =>
      super.copyWith(
              (message) => updates(message as Distribution_BucketOptions))
          as Distribution_BucketOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Distribution_BucketOptions create() => Distribution_BucketOptions._();
  Distribution_BucketOptions createEmptyInstance() => create();
  static $pb.PbList<Distribution_BucketOptions> createRepeated() =>
      $pb.PbList<Distribution_BucketOptions>();
  @$core.pragma('dart2js:noInline')
  static Distribution_BucketOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Distribution_BucketOptions>(create);
  static Distribution_BucketOptions? _defaultInstance;

  Distribution_BucketOptions_Options whichOptions() =>
      _Distribution_BucketOptions_OptionsByTag[$_whichOneof(0)]!;
  void clearOptions() => clearField($_whichOneof(0));

  /// The linear bucket.
  @$pb.TagNumber(1)
  Distribution_BucketOptions_Linear get linearBuckets => $_getN(0);
  @$pb.TagNumber(1)
  set linearBuckets(Distribution_BucketOptions_Linear v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLinearBuckets() => $_has(0);
  @$pb.TagNumber(1)
  void clearLinearBuckets() => clearField(1);
  @$pb.TagNumber(1)
  Distribution_BucketOptions_Linear ensureLinearBuckets() => $_ensure(0);

  /// The exponential buckets.
  @$pb.TagNumber(2)
  Distribution_BucketOptions_Exponential get exponentialBuckets => $_getN(1);
  @$pb.TagNumber(2)
  set exponentialBuckets(Distribution_BucketOptions_Exponential v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasExponentialBuckets() => $_has(1);
  @$pb.TagNumber(2)
  void clearExponentialBuckets() => clearField(2);
  @$pb.TagNumber(2)
  Distribution_BucketOptions_Exponential ensureExponentialBuckets() =>
      $_ensure(1);

  /// The explicit buckets.
  @$pb.TagNumber(3)
  Distribution_BucketOptions_Explicit get explicitBuckets => $_getN(2);
  @$pb.TagNumber(3)
  set explicitBuckets(Distribution_BucketOptions_Explicit v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasExplicitBuckets() => $_has(2);
  @$pb.TagNumber(3)
  void clearExplicitBuckets() => clearField(3);
  @$pb.TagNumber(3)
  Distribution_BucketOptions_Explicit ensureExplicitBuckets() => $_ensure(2);
}

/// Exemplars are example points that may be used to annotate aggregated
/// distribution values. They are metadata that gives information about a
/// particular value added to a Distribution bucket, such as a trace ID that
/// was active when a value was added. They may contain further information,
/// such as a example values and timestamps, origin, etc.
class Distribution_Exemplar extends $pb.GeneratedMessage {
  factory Distribution_Exemplar({
    $core.double? value,
    $50.Timestamp? timestamp,
    $core.Iterable<$49.Any>? attachments,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (attachments != null) {
      $result.attachments.addAll(attachments);
    }
    return $result;
  }
  Distribution_Exemplar._() : super();
  factory Distribution_Exemplar.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Distribution_Exemplar.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Distribution.Exemplar',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OD)
    ..aOM<$50.Timestamp>(2, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $50.Timestamp.create)
    ..pc<$49.Any>(3, _omitFieldNames ? '' : 'attachments', $pb.PbFieldType.PM,
        subBuilder: $49.Any.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Distribution_Exemplar clone() =>
      Distribution_Exemplar()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Distribution_Exemplar copyWith(
          void Function(Distribution_Exemplar) updates) =>
      super.copyWith((message) => updates(message as Distribution_Exemplar))
          as Distribution_Exemplar;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Distribution_Exemplar create() => Distribution_Exemplar._();
  Distribution_Exemplar createEmptyInstance() => create();
  static $pb.PbList<Distribution_Exemplar> createRepeated() =>
      $pb.PbList<Distribution_Exemplar>();
  @$core.pragma('dart2js:noInline')
  static Distribution_Exemplar getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Distribution_Exemplar>(create);
  static Distribution_Exemplar? _defaultInstance;

  /// Value of the exemplar point. This value determines to which bucket the
  /// exemplar belongs.
  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double v) {
    $_setDouble(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  /// The observation (sampling) time of the above value.
  @$pb.TagNumber(2)
  $50.Timestamp get timestamp => $_getN(1);
  @$pb.TagNumber(2)
  set timestamp($50.Timestamp v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => clearField(2);
  @$pb.TagNumber(2)
  $50.Timestamp ensureTimestamp() => $_ensure(1);

  ///  Contextual information about the example value. Examples are:
  ///
  ///    Trace: type.googleapis.com/google.monitoring.v3.SpanContext
  ///
  ///    Literal string: type.googleapis.com/google.protobuf.StringValue
  ///
  ///    Labels dropped during aggregation:
  ///      type.googleapis.com/google.monitoring.v3.DroppedLabels
  ///
  ///  There may be only a single attachment of any given message type in a
  ///  single exemplar, and this is enforced by the system.
  @$pb.TagNumber(3)
  $core.List<$49.Any> get attachments => $_getList(2);
}

///  `Distribution` contains summary statistics for a population of values. It
///  optionally contains a histogram representing the distribution of those values
///  across a set of buckets.
///
///  The summary statistics are the count, mean, sum of the squared deviation from
///  the mean, the minimum, and the maximum of the set of population of values.
///  The histogram is based on a sequence of buckets and gives a count of values
///  that fall into each bucket. The boundaries of the buckets are given either
///  explicitly or by formulas for buckets of fixed or exponentially increasing
///  widths.
///
///  Although it is not forbidden, it is generally a bad idea to include
///  non-finite values (infinities or NaNs) in the population of values, as this
///  will render the `mean` and `sum_of_squared_deviation` fields meaningless.
class Distribution extends $pb.GeneratedMessage {
  factory Distribution({
    $fixnum.Int64? count,
    $core.double? mean,
    $core.double? sumOfSquaredDeviation,
    Distribution_Range? range,
    Distribution_BucketOptions? bucketOptions,
    $core.Iterable<$fixnum.Int64>? bucketCounts,
    $core.Iterable<Distribution_Exemplar>? exemplars,
  }) {
    final $result = create();
    if (count != null) {
      $result.count = count;
    }
    if (mean != null) {
      $result.mean = mean;
    }
    if (sumOfSquaredDeviation != null) {
      $result.sumOfSquaredDeviation = sumOfSquaredDeviation;
    }
    if (range != null) {
      $result.range = range;
    }
    if (bucketOptions != null) {
      $result.bucketOptions = bucketOptions;
    }
    if (bucketCounts != null) {
      $result.bucketCounts.addAll(bucketCounts);
    }
    if (exemplars != null) {
      $result.exemplars.addAll(exemplars);
    }
    return $result;
  }
  Distribution._() : super();
  factory Distribution.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Distribution.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Distribution',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'count')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'mean', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'sumOfSquaredDeviation', $pb.PbFieldType.OD)
    ..aOM<Distribution_Range>(4, _omitFieldNames ? '' : 'range',
        subBuilder: Distribution_Range.create)
    ..aOM<Distribution_BucketOptions>(6, _omitFieldNames ? '' : 'bucketOptions',
        subBuilder: Distribution_BucketOptions.create)
    ..p<$fixnum.Int64>(
        7, _omitFieldNames ? '' : 'bucketCounts', $pb.PbFieldType.K6)
    ..pc<Distribution_Exemplar>(
        10, _omitFieldNames ? '' : 'exemplars', $pb.PbFieldType.PM,
        subBuilder: Distribution_Exemplar.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Distribution clone() => Distribution()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Distribution copyWith(void Function(Distribution) updates) =>
      super.copyWith((message) => updates(message as Distribution))
          as Distribution;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Distribution create() => Distribution._();
  Distribution createEmptyInstance() => create();
  static $pb.PbList<Distribution> createRepeated() =>
      $pb.PbList<Distribution>();
  @$core.pragma('dart2js:noInline')
  static Distribution getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Distribution>(create);
  static Distribution? _defaultInstance;

  /// The number of values in the population. Must be non-negative. This value
  /// must equal the sum of the values in `bucket_counts` if a histogram is
  /// provided.
  @$pb.TagNumber(1)
  $fixnum.Int64 get count => $_getI64(0);
  @$pb.TagNumber(1)
  set count($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearCount() => clearField(1);

  /// The arithmetic mean of the values in the population. If `count` is zero
  /// then this field must be zero.
  @$pb.TagNumber(2)
  $core.double get mean => $_getN(1);
  @$pb.TagNumber(2)
  set mean($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMean() => $_has(1);
  @$pb.TagNumber(2)
  void clearMean() => clearField(2);

  ///  The sum of squared deviations from the mean of the values in the
  ///  population. For values x_i this is:
  ///
  ///      Sum[i=1..n]((x_i - mean)^2)
  ///
  ///  Knuth, "The Art of Computer Programming", Vol. 2, page 232, 3rd edition
  ///  describes Welford's method for accumulating this sum in one pass.
  ///
  ///  If `count` is zero then this field must be zero.
  @$pb.TagNumber(3)
  $core.double get sumOfSquaredDeviation => $_getN(2);
  @$pb.TagNumber(3)
  set sumOfSquaredDeviation($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSumOfSquaredDeviation() => $_has(2);
  @$pb.TagNumber(3)
  void clearSumOfSquaredDeviation() => clearField(3);

  /// If specified, contains the range of the population values. The field
  /// must not be present if the `count` is zero.
  @$pb.TagNumber(4)
  Distribution_Range get range => $_getN(3);
  @$pb.TagNumber(4)
  set range(Distribution_Range v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasRange() => $_has(3);
  @$pb.TagNumber(4)
  void clearRange() => clearField(4);
  @$pb.TagNumber(4)
  Distribution_Range ensureRange() => $_ensure(3);

  /// Defines the histogram bucket boundaries. If the distribution does not
  /// contain a histogram, then omit this field.
  @$pb.TagNumber(6)
  Distribution_BucketOptions get bucketOptions => $_getN(4);
  @$pb.TagNumber(6)
  set bucketOptions(Distribution_BucketOptions v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasBucketOptions() => $_has(4);
  @$pb.TagNumber(6)
  void clearBucketOptions() => clearField(6);
  @$pb.TagNumber(6)
  Distribution_BucketOptions ensureBucketOptions() => $_ensure(4);

  ///  The number of values in each bucket of the histogram, as described in
  ///  `bucket_options`. If the distribution does not have a histogram, then omit
  ///  this field. If there is a histogram, then the sum of the values in
  ///  `bucket_counts` must equal the value in the `count` field of the
  ///  distribution.
  ///
  ///  If present, `bucket_counts` should contain N values, where N is the number
  ///  of buckets specified in `bucket_options`. If you supply fewer than N
  ///  values, the remaining values are assumed to be 0.
  ///
  ///  The order of the values in `bucket_counts` follows the bucket numbering
  ///  schemes described for the three bucket types. The first value must be the
  ///  count for the underflow bucket (number 0). The next N-2 values are the
  ///  counts for the finite buckets (number 1 through N-2). The N'th value in
  ///  `bucket_counts` is the count for the overflow bucket (number N-1).
  @$pb.TagNumber(7)
  $core.List<$fixnum.Int64> get bucketCounts => $_getList(5);

  /// Must be in increasing order of `value` field.
  @$pb.TagNumber(10)
  $core.List<Distribution_Exemplar> get exemplars => $_getList(6);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
