///
//  Generated code. Do not modify.
///
library google.type_money;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class Money extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Money')
    ..a/*<String>*/(1, 'currencyCode', PbFieldType.OS)
    ..a/*<Int64>*/(2, 'units', PbFieldType.O6, Int64.ZERO)
    ..a/*<int>*/(3, 'nanos', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Money() : super();
  Money.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Money.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Money clone() => new Money()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Money create() => new Money();
  static PbList<Money> createRepeated() => new PbList<Money>();
  static Money getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMoney();
    return _defaultInstance;
  }
  static Money _defaultInstance;
  static void $checkItem(Money v) {
    if (v is !Money) checkItemFailed(v, 'Money');
  }

  String get currencyCode => $_get(0, 1, '');
  void set currencyCode(String v) { $_setString(0, 1, v); }
  bool hasCurrencyCode() => $_has(0, 1);
  void clearCurrencyCode() => clearField(1);

  Int64 get units => $_get(1, 2, null);
  void set units(Int64 v) { $_setInt64(1, 2, v); }
  bool hasUnits() => $_has(1, 2);
  void clearUnits() => clearField(2);

  int get nanos => $_get(2, 3, 0);
  void set nanos(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasNanos() => $_has(2, 3);
  void clearNanos() => clearField(3);
}

class _ReadonlyMoney extends Money with ReadonlyMessageMixin {}

