///
//  Generated code. Do not modify.
///
library google.api_billing;

import 'package:protobuf/protobuf.dart';

class Billing extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Billing')
    ..p/*<String>*/(1, 'metrics', PbFieldType.PS)
    ..pp/*<BillingStatusRule>*/(5, 'rules', PbFieldType.PM, BillingStatusRule.$checkItem, BillingStatusRule.create)
    ..hasRequiredFields = false
  ;

  Billing() : super();
  Billing.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Billing.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Billing clone() => new Billing()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Billing create() => new Billing();
  static PbList<Billing> createRepeated() => new PbList<Billing>();
  static Billing getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBilling();
    return _defaultInstance;
  }
  static Billing _defaultInstance;
  static void $checkItem(Billing v) {
    if (v is !Billing) checkItemFailed(v, 'Billing');
  }

  List<String> get metrics => $_get(0, 1, null);

  List<BillingStatusRule> get rules => $_get(1, 5, null);
}

class _ReadonlyBilling extends Billing with ReadonlyMessageMixin {}

class BillingStatusRule extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BillingStatusRule')
    ..a/*<String>*/(1, 'selector', PbFieldType.OS)
    ..p/*<String>*/(2, 'allowedStatuses', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  BillingStatusRule() : super();
  BillingStatusRule.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BillingStatusRule.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BillingStatusRule clone() => new BillingStatusRule()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BillingStatusRule create() => new BillingStatusRule();
  static PbList<BillingStatusRule> createRepeated() => new PbList<BillingStatusRule>();
  static BillingStatusRule getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBillingStatusRule();
    return _defaultInstance;
  }
  static BillingStatusRule _defaultInstance;
  static void $checkItem(BillingStatusRule v) {
    if (v is !BillingStatusRule) checkItemFailed(v, 'BillingStatusRule');
  }

  String get selector => $_get(0, 1, '');
  void set selector(String v) { $_setString(0, 1, v); }
  bool hasSelector() => $_has(0, 1);
  void clearSelector() => clearField(1);

  List<String> get allowedStatuses => $_get(1, 2, null);
}

class _ReadonlyBillingStatusRule extends BillingStatusRule with ReadonlyMessageMixin {}

