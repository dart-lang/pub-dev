///
//  Generated code. Do not modify.
///
library google.api_usage;

import 'package:protobuf/protobuf.dart';

class Usage extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Usage')
    ..p/*<String>*/(1, 'requirements', PbFieldType.PS)
    ..pp/*<UsageRule>*/(6, 'rules', PbFieldType.PM, UsageRule.$checkItem, UsageRule.create)
    ..a/*<String>*/(7, 'producerNotificationChannel', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Usage() : super();
  Usage.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Usage.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Usage clone() => new Usage()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Usage create() => new Usage();
  static PbList<Usage> createRepeated() => new PbList<Usage>();
  static Usage getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUsage();
    return _defaultInstance;
  }
  static Usage _defaultInstance;
  static void $checkItem(Usage v) {
    if (v is !Usage) checkItemFailed(v, 'Usage');
  }

  List<String> get requirements => $_get(0, 1, null);

  List<UsageRule> get rules => $_get(1, 6, null);

  String get producerNotificationChannel => $_get(2, 7, '');
  void set producerNotificationChannel(String v) { $_setString(2, 7, v); }
  bool hasProducerNotificationChannel() => $_has(2, 7);
  void clearProducerNotificationChannel() => clearField(7);
}

class _ReadonlyUsage extends Usage with ReadonlyMessageMixin {}

class UsageRule extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UsageRule')
    ..a/*<String>*/(1, 'selector', PbFieldType.OS)
    ..a/*<bool>*/(2, 'allowUnregisteredCalls', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  UsageRule() : super();
  UsageRule.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UsageRule.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UsageRule clone() => new UsageRule()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UsageRule create() => new UsageRule();
  static PbList<UsageRule> createRepeated() => new PbList<UsageRule>();
  static UsageRule getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUsageRule();
    return _defaultInstance;
  }
  static UsageRule _defaultInstance;
  static void $checkItem(UsageRule v) {
    if (v is !UsageRule) checkItemFailed(v, 'UsageRule');
  }

  String get selector => $_get(0, 1, '');
  void set selector(String v) { $_setString(0, 1, v); }
  bool hasSelector() => $_has(0, 1);
  void clearSelector() => clearField(1);

  bool get allowUnregisteredCalls => $_get(1, 2, false);
  void set allowUnregisteredCalls(bool v) { $_setBool(1, 2, v); }
  bool hasAllowUnregisteredCalls() => $_has(1, 2);
  void clearAllowUnregisteredCalls() => clearField(2);
}

class _ReadonlyUsageRule extends UsageRule with ReadonlyMessageMixin {}

