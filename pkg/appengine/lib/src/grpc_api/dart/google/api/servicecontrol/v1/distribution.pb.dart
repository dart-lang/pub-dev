///
//  Generated code. Do not modify.
///
library google.api.servicecontrol.v1_distribution;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class Distribution_LinearBuckets extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Distribution_LinearBuckets')
    ..a/*<int>*/(1, 'numFiniteBuckets', PbFieldType.O3)
    ..a/*<double>*/(2, 'width', PbFieldType.OD)
    ..a/*<double>*/(3, 'offset', PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Distribution_LinearBuckets() : super();
  Distribution_LinearBuckets.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Distribution_LinearBuckets.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Distribution_LinearBuckets clone() => new Distribution_LinearBuckets()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Distribution_LinearBuckets create() => new Distribution_LinearBuckets();
  static PbList<Distribution_LinearBuckets> createRepeated() => new PbList<Distribution_LinearBuckets>();
  static Distribution_LinearBuckets getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDistribution_LinearBuckets();
    return _defaultInstance;
  }
  static Distribution_LinearBuckets _defaultInstance;
  static void $checkItem(Distribution_LinearBuckets v) {
    if (v is !Distribution_LinearBuckets) checkItemFailed(v, 'Distribution_LinearBuckets');
  }

  int get numFiniteBuckets => $_get(0, 1, 0);
  void set numFiniteBuckets(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasNumFiniteBuckets() => $_has(0, 1);
  void clearNumFiniteBuckets() => clearField(1);

  double get width => $_get(1, 2, null);
  void set width(double v) { $_setDouble(1, 2, v); }
  bool hasWidth() => $_has(1, 2);
  void clearWidth() => clearField(2);

  double get offset => $_get(2, 3, null);
  void set offset(double v) { $_setDouble(2, 3, v); }
  bool hasOffset() => $_has(2, 3);
  void clearOffset() => clearField(3);
}

class _ReadonlyDistribution_LinearBuckets extends Distribution_LinearBuckets with ReadonlyMessageMixin {}

class Distribution_ExponentialBuckets extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Distribution_ExponentialBuckets')
    ..a/*<int>*/(1, 'numFiniteBuckets', PbFieldType.O3)
    ..a/*<double>*/(2, 'growthFactor', PbFieldType.OD)
    ..a/*<double>*/(3, 'scale', PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Distribution_ExponentialBuckets() : super();
  Distribution_ExponentialBuckets.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Distribution_ExponentialBuckets.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Distribution_ExponentialBuckets clone() => new Distribution_ExponentialBuckets()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Distribution_ExponentialBuckets create() => new Distribution_ExponentialBuckets();
  static PbList<Distribution_ExponentialBuckets> createRepeated() => new PbList<Distribution_ExponentialBuckets>();
  static Distribution_ExponentialBuckets getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDistribution_ExponentialBuckets();
    return _defaultInstance;
  }
  static Distribution_ExponentialBuckets _defaultInstance;
  static void $checkItem(Distribution_ExponentialBuckets v) {
    if (v is !Distribution_ExponentialBuckets) checkItemFailed(v, 'Distribution_ExponentialBuckets');
  }

  int get numFiniteBuckets => $_get(0, 1, 0);
  void set numFiniteBuckets(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasNumFiniteBuckets() => $_has(0, 1);
  void clearNumFiniteBuckets() => clearField(1);

  double get growthFactor => $_get(1, 2, null);
  void set growthFactor(double v) { $_setDouble(1, 2, v); }
  bool hasGrowthFactor() => $_has(1, 2);
  void clearGrowthFactor() => clearField(2);

  double get scale => $_get(2, 3, null);
  void set scale(double v) { $_setDouble(2, 3, v); }
  bool hasScale() => $_has(2, 3);
  void clearScale() => clearField(3);
}

class _ReadonlyDistribution_ExponentialBuckets extends Distribution_ExponentialBuckets with ReadonlyMessageMixin {}

class Distribution_ExplicitBuckets extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Distribution_ExplicitBuckets')
    ..p/*<double>*/(1, 'bounds', PbFieldType.PD)
    ..hasRequiredFields = false
  ;

  Distribution_ExplicitBuckets() : super();
  Distribution_ExplicitBuckets.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Distribution_ExplicitBuckets.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Distribution_ExplicitBuckets clone() => new Distribution_ExplicitBuckets()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Distribution_ExplicitBuckets create() => new Distribution_ExplicitBuckets();
  static PbList<Distribution_ExplicitBuckets> createRepeated() => new PbList<Distribution_ExplicitBuckets>();
  static Distribution_ExplicitBuckets getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDistribution_ExplicitBuckets();
    return _defaultInstance;
  }
  static Distribution_ExplicitBuckets _defaultInstance;
  static void $checkItem(Distribution_ExplicitBuckets v) {
    if (v is !Distribution_ExplicitBuckets) checkItemFailed(v, 'Distribution_ExplicitBuckets');
  }

  List<double> get bounds => $_get(0, 1, null);
}

class _ReadonlyDistribution_ExplicitBuckets extends Distribution_ExplicitBuckets with ReadonlyMessageMixin {}

class Distribution extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Distribution')
    ..a/*<Int64>*/(1, 'count', PbFieldType.O6, Int64.ZERO)
    ..a/*<double>*/(2, 'mean', PbFieldType.OD)
    ..a/*<double>*/(3, 'minimum', PbFieldType.OD)
    ..a/*<double>*/(4, 'maximum', PbFieldType.OD)
    ..a/*<double>*/(5, 'sumOfSquaredDeviation', PbFieldType.OD)
    ..p/*<Int64>*/(6, 'bucketCounts', PbFieldType.P6)
    ..a/*<Distribution_LinearBuckets>*/(7, 'linearBuckets', PbFieldType.OM, Distribution_LinearBuckets.getDefault, Distribution_LinearBuckets.create)
    ..a/*<Distribution_ExponentialBuckets>*/(8, 'exponentialBuckets', PbFieldType.OM, Distribution_ExponentialBuckets.getDefault, Distribution_ExponentialBuckets.create)
    ..a/*<Distribution_ExplicitBuckets>*/(9, 'explicitBuckets', PbFieldType.OM, Distribution_ExplicitBuckets.getDefault, Distribution_ExplicitBuckets.create)
    ..hasRequiredFields = false
  ;

  Distribution() : super();
  Distribution.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Distribution.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Distribution clone() => new Distribution()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Distribution create() => new Distribution();
  static PbList<Distribution> createRepeated() => new PbList<Distribution>();
  static Distribution getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDistribution();
    return _defaultInstance;
  }
  static Distribution _defaultInstance;
  static void $checkItem(Distribution v) {
    if (v is !Distribution) checkItemFailed(v, 'Distribution');
  }

  Int64 get count => $_get(0, 1, null);
  void set count(Int64 v) { $_setInt64(0, 1, v); }
  bool hasCount() => $_has(0, 1);
  void clearCount() => clearField(1);

  double get mean => $_get(1, 2, null);
  void set mean(double v) { $_setDouble(1, 2, v); }
  bool hasMean() => $_has(1, 2);
  void clearMean() => clearField(2);

  double get minimum => $_get(2, 3, null);
  void set minimum(double v) { $_setDouble(2, 3, v); }
  bool hasMinimum() => $_has(2, 3);
  void clearMinimum() => clearField(3);

  double get maximum => $_get(3, 4, null);
  void set maximum(double v) { $_setDouble(3, 4, v); }
  bool hasMaximum() => $_has(3, 4);
  void clearMaximum() => clearField(4);

  double get sumOfSquaredDeviation => $_get(4, 5, null);
  void set sumOfSquaredDeviation(double v) { $_setDouble(4, 5, v); }
  bool hasSumOfSquaredDeviation() => $_has(4, 5);
  void clearSumOfSquaredDeviation() => clearField(5);

  List<Int64> get bucketCounts => $_get(5, 6, null);

  Distribution_LinearBuckets get linearBuckets => $_get(6, 7, null);
  void set linearBuckets(Distribution_LinearBuckets v) { setField(7, v); }
  bool hasLinearBuckets() => $_has(6, 7);
  void clearLinearBuckets() => clearField(7);

  Distribution_ExponentialBuckets get exponentialBuckets => $_get(7, 8, null);
  void set exponentialBuckets(Distribution_ExponentialBuckets v) { setField(8, v); }
  bool hasExponentialBuckets() => $_has(7, 8);
  void clearExponentialBuckets() => clearField(8);

  Distribution_ExplicitBuckets get explicitBuckets => $_get(8, 9, null);
  void set explicitBuckets(Distribution_ExplicitBuckets v) { setField(9, v); }
  bool hasExplicitBuckets() => $_has(8, 9);
  void clearExplicitBuckets() => clearField(9);
}

class _ReadonlyDistribution extends Distribution with ReadonlyMessageMixin {}

