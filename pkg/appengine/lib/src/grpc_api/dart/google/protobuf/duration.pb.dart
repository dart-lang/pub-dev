///
//  Generated code. Do not modify.
///
library google.protobuf_duration;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class Duration extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Duration')
    ..a/*<Int64>*/(1, 'seconds', PbFieldType.O6, Int64.ZERO)
    ..a/*<int>*/(2, 'nanos', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Duration() : super();
  Duration.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Duration.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Duration clone() => new Duration()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Duration create() => new Duration();
  static PbList<Duration> createRepeated() => new PbList<Duration>();
  static Duration getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDuration();
    return _defaultInstance;
  }
  static Duration _defaultInstance;
  static void $checkItem(Duration v) {
    if (v is !Duration) checkItemFailed(v, 'Duration');
  }

  Int64 get seconds => $_get(0, 1, null);
  void set seconds(Int64 v) { $_setInt64(0, 1, v); }
  bool hasSeconds() => $_has(0, 1);
  void clearSeconds() => clearField(1);

  int get nanos => $_get(1, 2, 0);
  void set nanos(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasNanos() => $_has(1, 2);
  void clearNanos() => clearField(2);
}

class _ReadonlyDuration extends Duration with ReadonlyMessageMixin {}

