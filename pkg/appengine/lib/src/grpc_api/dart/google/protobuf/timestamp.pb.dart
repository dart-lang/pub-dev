///
//  Generated code. Do not modify.
///
library google.protobuf_timestamp;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class Timestamp extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Timestamp')
    ..a/*<Int64>*/(1, 'seconds', PbFieldType.O6, Int64.ZERO)
    ..a/*<int>*/(2, 'nanos', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Timestamp() : super();
  Timestamp.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Timestamp.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Timestamp clone() => new Timestamp()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Timestamp create() => new Timestamp();
  static PbList<Timestamp> createRepeated() => new PbList<Timestamp>();
  static Timestamp getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTimestamp();
    return _defaultInstance;
  }
  static Timestamp _defaultInstance;
  static void $checkItem(Timestamp v) {
    if (v is !Timestamp) checkItemFailed(v, 'Timestamp');
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

class _ReadonlyTimestamp extends Timestamp with ReadonlyMessageMixin {}

