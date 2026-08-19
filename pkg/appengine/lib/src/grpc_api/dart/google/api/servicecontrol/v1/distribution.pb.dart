//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/distribution.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../distribution.pb.dart' as $70;

/// Describing buckets with constant width.
class Distribution_LinearBuckets extends $pb.GeneratedMessage {
  factory Distribution_LinearBuckets({
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
  Distribution_LinearBuckets._() : super();
  factory Distribution_LinearBuckets.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Distribution_LinearBuckets.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Distribution.LinearBuckets',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'numFiniteBuckets', $pb.PbFieldType.O3)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'width', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Distribution_LinearBuckets clone() =>
      Distribution_LinearBuckets()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Distribution_LinearBuckets copyWith(
          void Function(Distribution_LinearBuckets) updates) =>
      super.copyWith(
              (message) => updates(message as Distribution_LinearBuckets))
          as Distribution_LinearBuckets;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Distribution_LinearBuckets create() => Distribution_LinearBuckets._();
  Distribution_LinearBuckets createEmptyInstance() => create();
  static $pb.PbList<Distribution_LinearBuckets> createRepeated() =>
      $pb.PbList<Distribution_LinearBuckets>();
  @$core.pragma('dart2js:noInline')
  static Distribution_LinearBuckets getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Distribution_LinearBuckets>(create);
  static Distribution_LinearBuckets? _defaultInstance;

  /// The number of finite buckets. With the underflow and overflow buckets,
  /// the total number of buckets is `num_finite_buckets` + 2.
  /// See comments on `bucket_options` for details.
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

  /// The i'th linear bucket covers the interval
  ///   [offset + (i-1) * width, offset + i * width)
  /// where i ranges from 1 to num_finite_buckets, inclusive.
  /// Must be strictly positive.
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

  /// The i'th linear bucket covers the interval
  ///   [offset + (i-1) * width, offset + i * width)
  /// where i ranges from 1 to num_finite_buckets, inclusive.
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

/// Describing buckets with exponentially growing width.
class Distribution_ExponentialBuckets extends $pb.GeneratedMessage {
  factory Distribution_ExponentialBuckets({
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
  Distribution_ExponentialBuckets._() : super();
  factory Distribution_ExponentialBuckets.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Distribution_ExponentialBuckets.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Distribution.ExponentialBuckets',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
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
  Distribution_ExponentialBuckets clone() =>
      Distribution_ExponentialBuckets()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Distribution_ExponentialBuckets copyWith(
          void Function(Distribution_ExponentialBuckets) updates) =>
      super.copyWith(
              (message) => updates(message as Distribution_ExponentialBuckets))
          as Distribution_ExponentialBuckets;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Distribution_ExponentialBuckets create() =>
      Distribution_ExponentialBuckets._();
  Distribution_ExponentialBuckets createEmptyInstance() => create();
  static $pb.PbList<Distribution_ExponentialBuckets> createRepeated() =>
      $pb.PbList<Distribution_ExponentialBuckets>();
  @$core.pragma('dart2js:noInline')
  static Distribution_ExponentialBuckets getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Distribution_ExponentialBuckets>(
          create);
  static Distribution_ExponentialBuckets? _defaultInstance;

  /// The number of finite buckets. With the underflow and overflow buckets,
  /// the total number of buckets is `num_finite_buckets` + 2.
  /// See comments on `bucket_options` for details.
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

  /// The i'th exponential bucket covers the interval
  ///   [scale * growth_factor^(i-1), scale * growth_factor^i)
  /// where i ranges from 1 to num_finite_buckets inclusive.
  /// Must be larger than 1.0.
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

  /// The i'th exponential bucket covers the interval
  ///   [scale * growth_factor^(i-1), scale * growth_factor^i)
  /// where i ranges from 1 to num_finite_buckets inclusive.
  /// Must be > 0.
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

/// Describing buckets with arbitrary user-provided width.
class Distribution_ExplicitBuckets extends $pb.GeneratedMessage {
  factory Distribution_ExplicitBuckets({
    $core.Iterable<$core.double>? bounds,
  }) {
    final $result = create();
    if (bounds != null) {
      $result.bounds.addAll(bounds);
    }
    return $result;
  }
  Distribution_ExplicitBuckets._() : super();
  factory Distribution_ExplicitBuckets.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Distribution_ExplicitBuckets.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Distribution.ExplicitBuckets',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..p<$core.double>(1, _omitFieldNames ? '' : 'bounds', $pb.PbFieldType.KD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Distribution_ExplicitBuckets clone() =>
      Distribution_ExplicitBuckets()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Distribution_ExplicitBuckets copyWith(
          void Function(Distribution_ExplicitBuckets) updates) =>
      super.copyWith(
              (message) => updates(message as Distribution_ExplicitBuckets))
          as Distribution_ExplicitBuckets;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Distribution_ExplicitBuckets create() =>
      Distribution_ExplicitBuckets._();
  Distribution_ExplicitBuckets createEmptyInstance() => create();
  static $pb.PbList<Distribution_ExplicitBuckets> createRepeated() =>
      $pb.PbList<Distribution_ExplicitBuckets>();
  @$core.pragma('dart2js:noInline')
  static Distribution_ExplicitBuckets getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Distribution_ExplicitBuckets>(create);
  static Distribution_ExplicitBuckets? _defaultInstance;

  ///  'bound' is a list of strictly increasing boundaries between
  ///  buckets. Note that a list of length N-1 defines N buckets because
  ///  of fenceposting. See comments on `bucket_options` for details.
  ///
  ///  The i'th finite bucket covers the interval
  ///    [bound[i-1], bound[i])
  ///  where i ranges from 1 to bound_size() - 1. Note that there are no
  ///  finite buckets at all if 'bound' only contains a single element; in
  ///  that special case the single bound defines the boundary between the
  ///  underflow and overflow buckets.
  ///
  ///  bucket number                   lower bound    upper bound
  ///   i == 0 (underflow)              -inf           bound[i]
  ///   0 < i < bound_size()            bound[i-1]     bound[i]
  ///   i == bound_size() (overflow)    bound[i-1]     +inf
  @$pb.TagNumber(1)
  $core.List<$core.double> get bounds => $_getList(0);
}

enum Distribution_BucketOption {
  linearBuckets,
  exponentialBuckets,
  explicitBuckets,
  notSet
}

///  Distribution represents a frequency distribution of double-valued sample
///  points. It contains the size of the population of sample points plus
///  additional optional information:
///
///  * the arithmetic mean of the samples
///  * the minimum and maximum of the samples
///  * the sum-squared-deviation of the samples, used to compute variance
///  * a histogram of the values of the sample points
class Distribution extends $pb.GeneratedMessage {
  factory Distribution({
    $fixnum.Int64? count,
    $core.double? mean,
    $core.double? minimum,
    $core.double? maximum,
    $core.double? sumOfSquaredDeviation,
    $core.Iterable<$fixnum.Int64>? bucketCounts,
    Distribution_LinearBuckets? linearBuckets,
    Distribution_ExponentialBuckets? exponentialBuckets,
    Distribution_ExplicitBuckets? explicitBuckets,
    $core.Iterable<$70.Distribution_Exemplar>? exemplars,
  }) {
    final $result = create();
    if (count != null) {
      $result.count = count;
    }
    if (mean != null) {
      $result.mean = mean;
    }
    if (minimum != null) {
      $result.minimum = minimum;
    }
    if (maximum != null) {
      $result.maximum = maximum;
    }
    if (sumOfSquaredDeviation != null) {
      $result.sumOfSquaredDeviation = sumOfSquaredDeviation;
    }
    if (bucketCounts != null) {
      $result.bucketCounts.addAll(bucketCounts);
    }
    if (linearBuckets != null) {
      $result.linearBuckets = linearBuckets;
    }
    if (exponentialBuckets != null) {
      $result.exponentialBuckets = exponentialBuckets;
    }
    if (explicitBuckets != null) {
      $result.explicitBuckets = explicitBuckets;
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

  static const $core.Map<$core.int, Distribution_BucketOption>
      _Distribution_BucketOptionByTag = {
    7: Distribution_BucketOption.linearBuckets,
    8: Distribution_BucketOption.exponentialBuckets,
    9: Distribution_BucketOption.explicitBuckets,
    0: Distribution_BucketOption.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Distribution',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..oo(0, [7, 8, 9])
    ..aInt64(1, _omitFieldNames ? '' : 'count')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'mean', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'minimum', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'maximum', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'sumOfSquaredDeviation', $pb.PbFieldType.OD)
    ..p<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'bucketCounts', $pb.PbFieldType.K6)
    ..aOM<Distribution_LinearBuckets>(7, _omitFieldNames ? '' : 'linearBuckets',
        subBuilder: Distribution_LinearBuckets.create)
    ..aOM<Distribution_ExponentialBuckets>(
        8, _omitFieldNames ? '' : 'exponentialBuckets',
        subBuilder: Distribution_ExponentialBuckets.create)
    ..aOM<Distribution_ExplicitBuckets>(
        9, _omitFieldNames ? '' : 'explicitBuckets',
        subBuilder: Distribution_ExplicitBuckets.create)
    ..pc<$70.Distribution_Exemplar>(
        10, _omitFieldNames ? '' : 'exemplars', $pb.PbFieldType.PM,
        subBuilder: $70.Distribution_Exemplar.create)
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

  Distribution_BucketOption whichBucketOption() =>
      _Distribution_BucketOptionByTag[$_whichOneof(0)]!;
  void clearBucketOption() => clearField($_whichOneof(0));

  /// The total number of samples in the distribution. Must be >= 0.
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

  /// The arithmetic mean of the samples in the distribution. If `count` is
  /// zero then this field must be zero.
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

  /// The minimum of the population of values. Ignored if `count` is zero.
  @$pb.TagNumber(3)
  $core.double get minimum => $_getN(2);
  @$pb.TagNumber(3)
  set minimum($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMinimum() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinimum() => clearField(3);

  /// The maximum of the population of values. Ignored if `count` is zero.
  @$pb.TagNumber(4)
  $core.double get maximum => $_getN(3);
  @$pb.TagNumber(4)
  set maximum($core.double v) {
    $_setDouble(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMaximum() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaximum() => clearField(4);

  /// The sum of squared deviations from the mean:
  ///   Sum[i=1..count]((x_i - mean)^2)
  /// where each x_i is a sample values. If `count` is zero then this field
  /// must be zero, otherwise validation of the request fails.
  @$pb.TagNumber(5)
  $core.double get sumOfSquaredDeviation => $_getN(4);
  @$pb.TagNumber(5)
  set sumOfSquaredDeviation($core.double v) {
    $_setDouble(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSumOfSquaredDeviation() => $_has(4);
  @$pb.TagNumber(5)
  void clearSumOfSquaredDeviation() => clearField(5);

  ///  The number of samples in each histogram bucket. `bucket_counts` are
  ///  optional. If present, they must sum to the `count` value.
  ///
  ///  The buckets are defined below in `bucket_option`. There are N buckets.
  ///  `bucket_counts[0]` is the number of samples in the underflow bucket.
  ///  `bucket_counts[1]` to `bucket_counts[N-1]` are the numbers of samples
  ///  in each of the finite buckets. And `bucket_counts[N] is the number
  ///  of samples in the overflow bucket. See the comments of `bucket_option`
  ///  below for more details.
  ///
  ///  Any suffix of trailing zeros may be omitted.
  @$pb.TagNumber(6)
  $core.List<$fixnum.Int64> get bucketCounts => $_getList(5);

  /// Buckets with constant width.
  @$pb.TagNumber(7)
  Distribution_LinearBuckets get linearBuckets => $_getN(6);
  @$pb.TagNumber(7)
  set linearBuckets(Distribution_LinearBuckets v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasLinearBuckets() => $_has(6);
  @$pb.TagNumber(7)
  void clearLinearBuckets() => clearField(7);
  @$pb.TagNumber(7)
  Distribution_LinearBuckets ensureLinearBuckets() => $_ensure(6);

  /// Buckets with exponentially growing width.
  @$pb.TagNumber(8)
  Distribution_ExponentialBuckets get exponentialBuckets => $_getN(7);
  @$pb.TagNumber(8)
  set exponentialBuckets(Distribution_ExponentialBuckets v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasExponentialBuckets() => $_has(7);
  @$pb.TagNumber(8)
  void clearExponentialBuckets() => clearField(8);
  @$pb.TagNumber(8)
  Distribution_ExponentialBuckets ensureExponentialBuckets() => $_ensure(7);

  /// Buckets with arbitrary user-provided width.
  @$pb.TagNumber(9)
  Distribution_ExplicitBuckets get explicitBuckets => $_getN(8);
  @$pb.TagNumber(9)
  set explicitBuckets(Distribution_ExplicitBuckets v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasExplicitBuckets() => $_has(8);
  @$pb.TagNumber(9)
  void clearExplicitBuckets() => clearField(9);
  @$pb.TagNumber(9)
  Distribution_ExplicitBuckets ensureExplicitBuckets() => $_ensure(8);

  /// Example points. Must be in increasing order of `value` field.
  @$pb.TagNumber(10)
  $core.List<$70.Distribution_Exemplar> get exemplars => $_getList(9);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
