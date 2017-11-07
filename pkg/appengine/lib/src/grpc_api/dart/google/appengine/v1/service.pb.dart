///
//  Generated code. Do not modify.
///
library google.appengine.v1_service;

import 'package:protobuf/protobuf.dart';

import 'service.pbenum.dart';

export 'service.pbenum.dart';

class Service extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Service')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'id', PbFieldType.OS)
    ..a/*<TrafficSplit>*/(3, 'split', PbFieldType.OM, TrafficSplit.getDefault, TrafficSplit.create)
    ..hasRequiredFields = false
  ;

  Service() : super();
  Service.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Service.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Service clone() => new Service()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Service create() => new Service();
  static PbList<Service> createRepeated() => new PbList<Service>();
  static Service getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyService();
    return _defaultInstance;
  }
  static Service _defaultInstance;
  static void $checkItem(Service v) {
    if (v is !Service) checkItemFailed(v, 'Service');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get id => $_get(1, 2, '');
  void set id(String v) { $_setString(1, 2, v); }
  bool hasId() => $_has(1, 2);
  void clearId() => clearField(2);

  TrafficSplit get split => $_get(2, 3, null);
  void set split(TrafficSplit v) { setField(3, v); }
  bool hasSplit() => $_has(2, 3);
  void clearSplit() => clearField(3);
}

class _ReadonlyService extends Service with ReadonlyMessageMixin {}

class TrafficSplit_AllocationsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TrafficSplit_AllocationsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<double>*/(2, 'value', PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  TrafficSplit_AllocationsEntry() : super();
  TrafficSplit_AllocationsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TrafficSplit_AllocationsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TrafficSplit_AllocationsEntry clone() => new TrafficSplit_AllocationsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TrafficSplit_AllocationsEntry create() => new TrafficSplit_AllocationsEntry();
  static PbList<TrafficSplit_AllocationsEntry> createRepeated() => new PbList<TrafficSplit_AllocationsEntry>();
  static TrafficSplit_AllocationsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTrafficSplit_AllocationsEntry();
    return _defaultInstance;
  }
  static TrafficSplit_AllocationsEntry _defaultInstance;
  static void $checkItem(TrafficSplit_AllocationsEntry v) {
    if (v is !TrafficSplit_AllocationsEntry) checkItemFailed(v, 'TrafficSplit_AllocationsEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  double get value => $_get(1, 2, null);
  void set value(double v) { $_setDouble(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTrafficSplit_AllocationsEntry extends TrafficSplit_AllocationsEntry with ReadonlyMessageMixin {}

class TrafficSplit extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TrafficSplit')
    ..e/*<TrafficSplit_ShardBy>*/(1, 'shardBy', PbFieldType.OE, TrafficSplit_ShardBy.UNSPECIFIED, TrafficSplit_ShardBy.valueOf)
    ..pp/*<TrafficSplit_AllocationsEntry>*/(2, 'allocations', PbFieldType.PM, TrafficSplit_AllocationsEntry.$checkItem, TrafficSplit_AllocationsEntry.create)
    ..hasRequiredFields = false
  ;

  TrafficSplit() : super();
  TrafficSplit.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TrafficSplit.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TrafficSplit clone() => new TrafficSplit()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TrafficSplit create() => new TrafficSplit();
  static PbList<TrafficSplit> createRepeated() => new PbList<TrafficSplit>();
  static TrafficSplit getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTrafficSplit();
    return _defaultInstance;
  }
  static TrafficSplit _defaultInstance;
  static void $checkItem(TrafficSplit v) {
    if (v is !TrafficSplit) checkItemFailed(v, 'TrafficSplit');
  }

  TrafficSplit_ShardBy get shardBy => $_get(0, 1, null);
  void set shardBy(TrafficSplit_ShardBy v) { setField(1, v); }
  bool hasShardBy() => $_has(0, 1);
  void clearShardBy() => clearField(1);

  List<TrafficSplit_AllocationsEntry> get allocations => $_get(1, 2, null);
}

class _ReadonlyTrafficSplit extends TrafficSplit with ReadonlyMessageMixin {}

