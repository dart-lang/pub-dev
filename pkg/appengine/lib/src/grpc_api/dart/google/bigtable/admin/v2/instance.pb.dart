///
//  Generated code. Do not modify.
///
library google.bigtable.admin.v2_instance;

import 'package:protobuf/protobuf.dart';

import 'instance.pbenum.dart';
import 'common.pbenum.dart';

export 'instance.pbenum.dart';

class Instance extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Instance')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'displayName', PbFieldType.OS)
    ..e/*<Instance_State>*/(3, 'state', PbFieldType.OE, Instance_State.STATE_NOT_KNOWN, Instance_State.valueOf)
    ..e/*<Instance_Type>*/(4, 'type', PbFieldType.OE, Instance_Type.TYPE_UNSPECIFIED, Instance_Type.valueOf)
    ..hasRequiredFields = false
  ;

  Instance() : super();
  Instance.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Instance.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Instance clone() => new Instance()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Instance create() => new Instance();
  static PbList<Instance> createRepeated() => new PbList<Instance>();
  static Instance getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyInstance();
    return _defaultInstance;
  }
  static Instance _defaultInstance;
  static void $checkItem(Instance v) {
    if (v is !Instance) checkItemFailed(v, 'Instance');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get displayName => $_get(1, 2, '');
  void set displayName(String v) { $_setString(1, 2, v); }
  bool hasDisplayName() => $_has(1, 2);
  void clearDisplayName() => clearField(2);

  Instance_State get state => $_get(2, 3, null);
  void set state(Instance_State v) { setField(3, v); }
  bool hasState() => $_has(2, 3);
  void clearState() => clearField(3);

  Instance_Type get type => $_get(3, 4, null);
  void set type(Instance_Type v) { setField(4, v); }
  bool hasType() => $_has(3, 4);
  void clearType() => clearField(4);
}

class _ReadonlyInstance extends Instance with ReadonlyMessageMixin {}

class Cluster extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Cluster')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'location', PbFieldType.OS)
    ..e/*<Cluster_State>*/(3, 'state', PbFieldType.OE, Cluster_State.STATE_NOT_KNOWN, Cluster_State.valueOf)
    ..a/*<int>*/(4, 'serveNodes', PbFieldType.O3)
    ..e/*<StorageType>*/(5, 'defaultStorageType', PbFieldType.OE, StorageType.STORAGE_TYPE_UNSPECIFIED, StorageType.valueOf)
    ..hasRequiredFields = false
  ;

  Cluster() : super();
  Cluster.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Cluster.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Cluster clone() => new Cluster()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Cluster create() => new Cluster();
  static PbList<Cluster> createRepeated() => new PbList<Cluster>();
  static Cluster getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCluster();
    return _defaultInstance;
  }
  static Cluster _defaultInstance;
  static void $checkItem(Cluster v) {
    if (v is !Cluster) checkItemFailed(v, 'Cluster');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get location => $_get(1, 2, '');
  void set location(String v) { $_setString(1, 2, v); }
  bool hasLocation() => $_has(1, 2);
  void clearLocation() => clearField(2);

  Cluster_State get state => $_get(2, 3, null);
  void set state(Cluster_State v) { setField(3, v); }
  bool hasState() => $_has(2, 3);
  void clearState() => clearField(3);

  int get serveNodes => $_get(3, 4, 0);
  void set serveNodes(int v) { $_setUnsignedInt32(3, 4, v); }
  bool hasServeNodes() => $_has(3, 4);
  void clearServeNodes() => clearField(4);

  StorageType get defaultStorageType => $_get(4, 5, null);
  void set defaultStorageType(StorageType v) { setField(5, v); }
  bool hasDefaultStorageType() => $_has(4, 5);
  void clearDefaultStorageType() => clearField(5);
}

class _ReadonlyCluster extends Cluster with ReadonlyMessageMixin {}

