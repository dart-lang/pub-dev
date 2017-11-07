///
//  Generated code. Do not modify.
///
library google.container.v1_cluster_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../protobuf/empty.pb.dart' as google$protobuf;

import 'cluster_service.pbenum.dart';

export 'cluster_service.pbenum.dart';

class NodeConfig_MetadataEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('NodeConfig_MetadataEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  NodeConfig_MetadataEntry() : super();
  NodeConfig_MetadataEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NodeConfig_MetadataEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NodeConfig_MetadataEntry clone() => new NodeConfig_MetadataEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static NodeConfig_MetadataEntry create() => new NodeConfig_MetadataEntry();
  static PbList<NodeConfig_MetadataEntry> createRepeated() => new PbList<NodeConfig_MetadataEntry>();
  static NodeConfig_MetadataEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyNodeConfig_MetadataEntry();
    return _defaultInstance;
  }
  static NodeConfig_MetadataEntry _defaultInstance;
  static void $checkItem(NodeConfig_MetadataEntry v) {
    if (v is !NodeConfig_MetadataEntry) checkItemFailed(v, 'NodeConfig_MetadataEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  String get value => $_get(1, 2, '');
  void set value(String v) { $_setString(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyNodeConfig_MetadataEntry extends NodeConfig_MetadataEntry with ReadonlyMessageMixin {}

class NodeConfig_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('NodeConfig_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  NodeConfig_LabelsEntry() : super();
  NodeConfig_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NodeConfig_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NodeConfig_LabelsEntry clone() => new NodeConfig_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static NodeConfig_LabelsEntry create() => new NodeConfig_LabelsEntry();
  static PbList<NodeConfig_LabelsEntry> createRepeated() => new PbList<NodeConfig_LabelsEntry>();
  static NodeConfig_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyNodeConfig_LabelsEntry();
    return _defaultInstance;
  }
  static NodeConfig_LabelsEntry _defaultInstance;
  static void $checkItem(NodeConfig_LabelsEntry v) {
    if (v is !NodeConfig_LabelsEntry) checkItemFailed(v, 'NodeConfig_LabelsEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  String get value => $_get(1, 2, '');
  void set value(String v) { $_setString(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyNodeConfig_LabelsEntry extends NodeConfig_LabelsEntry with ReadonlyMessageMixin {}

class NodeConfig extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('NodeConfig')
    ..a/*<String>*/(1, 'machineType', PbFieldType.OS)
    ..a/*<int>*/(2, 'diskSizeGb', PbFieldType.O3)
    ..p/*<String>*/(3, 'oauthScopes', PbFieldType.PS)
    ..pp/*<NodeConfig_MetadataEntry>*/(4, 'metadata', PbFieldType.PM, NodeConfig_MetadataEntry.$checkItem, NodeConfig_MetadataEntry.create)
    ..a/*<String>*/(5, 'imageType', PbFieldType.OS)
    ..pp/*<NodeConfig_LabelsEntry>*/(6, 'labels', PbFieldType.PM, NodeConfig_LabelsEntry.$checkItem, NodeConfig_LabelsEntry.create)
    ..a/*<int>*/(7, 'localSsdCount', PbFieldType.O3)
    ..p/*<String>*/(8, 'tags', PbFieldType.PS)
    ..a/*<String>*/(9, 'serviceAccount', PbFieldType.OS)
    ..a/*<bool>*/(10, 'preemptible', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  NodeConfig() : super();
  NodeConfig.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NodeConfig.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NodeConfig clone() => new NodeConfig()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static NodeConfig create() => new NodeConfig();
  static PbList<NodeConfig> createRepeated() => new PbList<NodeConfig>();
  static NodeConfig getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyNodeConfig();
    return _defaultInstance;
  }
  static NodeConfig _defaultInstance;
  static void $checkItem(NodeConfig v) {
    if (v is !NodeConfig) checkItemFailed(v, 'NodeConfig');
  }

  String get machineType => $_get(0, 1, '');
  void set machineType(String v) { $_setString(0, 1, v); }
  bool hasMachineType() => $_has(0, 1);
  void clearMachineType() => clearField(1);

  int get diskSizeGb => $_get(1, 2, 0);
  void set diskSizeGb(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasDiskSizeGb() => $_has(1, 2);
  void clearDiskSizeGb() => clearField(2);

  List<String> get oauthScopes => $_get(2, 3, null);

  List<NodeConfig_MetadataEntry> get metadata => $_get(3, 4, null);

  String get imageType => $_get(4, 5, '');
  void set imageType(String v) { $_setString(4, 5, v); }
  bool hasImageType() => $_has(4, 5);
  void clearImageType() => clearField(5);

  List<NodeConfig_LabelsEntry> get labels => $_get(5, 6, null);

  int get localSsdCount => $_get(6, 7, 0);
  void set localSsdCount(int v) { $_setUnsignedInt32(6, 7, v); }
  bool hasLocalSsdCount() => $_has(6, 7);
  void clearLocalSsdCount() => clearField(7);

  List<String> get tags => $_get(7, 8, null);

  String get serviceAccount => $_get(8, 9, '');
  void set serviceAccount(String v) { $_setString(8, 9, v); }
  bool hasServiceAccount() => $_has(8, 9);
  void clearServiceAccount() => clearField(9);

  bool get preemptible => $_get(9, 10, false);
  void set preemptible(bool v) { $_setBool(9, 10, v); }
  bool hasPreemptible() => $_has(9, 10);
  void clearPreemptible() => clearField(10);
}

class _ReadonlyNodeConfig extends NodeConfig with ReadonlyMessageMixin {}

class MasterAuth extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MasterAuth')
    ..a/*<String>*/(1, 'username', PbFieldType.OS)
    ..a/*<String>*/(2, 'password', PbFieldType.OS)
    ..a/*<String>*/(100, 'clusterCaCertificate', PbFieldType.OS)
    ..a/*<String>*/(101, 'clientCertificate', PbFieldType.OS)
    ..a/*<String>*/(102, 'clientKey', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  MasterAuth() : super();
  MasterAuth.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MasterAuth.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MasterAuth clone() => new MasterAuth()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MasterAuth create() => new MasterAuth();
  static PbList<MasterAuth> createRepeated() => new PbList<MasterAuth>();
  static MasterAuth getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMasterAuth();
    return _defaultInstance;
  }
  static MasterAuth _defaultInstance;
  static void $checkItem(MasterAuth v) {
    if (v is !MasterAuth) checkItemFailed(v, 'MasterAuth');
  }

  String get username => $_get(0, 1, '');
  void set username(String v) { $_setString(0, 1, v); }
  bool hasUsername() => $_has(0, 1);
  void clearUsername() => clearField(1);

  String get password => $_get(1, 2, '');
  void set password(String v) { $_setString(1, 2, v); }
  bool hasPassword() => $_has(1, 2);
  void clearPassword() => clearField(2);

  String get clusterCaCertificate => $_get(2, 100, '');
  void set clusterCaCertificate(String v) { $_setString(2, 100, v); }
  bool hasClusterCaCertificate() => $_has(2, 100);
  void clearClusterCaCertificate() => clearField(100);

  String get clientCertificate => $_get(3, 101, '');
  void set clientCertificate(String v) { $_setString(3, 101, v); }
  bool hasClientCertificate() => $_has(3, 101);
  void clearClientCertificate() => clearField(101);

  String get clientKey => $_get(4, 102, '');
  void set clientKey(String v) { $_setString(4, 102, v); }
  bool hasClientKey() => $_has(4, 102);
  void clearClientKey() => clearField(102);
}

class _ReadonlyMasterAuth extends MasterAuth with ReadonlyMessageMixin {}

class AddonsConfig extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AddonsConfig')
    ..a/*<HttpLoadBalancing>*/(1, 'httpLoadBalancing', PbFieldType.OM, HttpLoadBalancing.getDefault, HttpLoadBalancing.create)
    ..a/*<HorizontalPodAutoscaling>*/(2, 'horizontalPodAutoscaling', PbFieldType.OM, HorizontalPodAutoscaling.getDefault, HorizontalPodAutoscaling.create)
    ..hasRequiredFields = false
  ;

  AddonsConfig() : super();
  AddonsConfig.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AddonsConfig.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AddonsConfig clone() => new AddonsConfig()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AddonsConfig create() => new AddonsConfig();
  static PbList<AddonsConfig> createRepeated() => new PbList<AddonsConfig>();
  static AddonsConfig getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAddonsConfig();
    return _defaultInstance;
  }
  static AddonsConfig _defaultInstance;
  static void $checkItem(AddonsConfig v) {
    if (v is !AddonsConfig) checkItemFailed(v, 'AddonsConfig');
  }

  HttpLoadBalancing get httpLoadBalancing => $_get(0, 1, null);
  void set httpLoadBalancing(HttpLoadBalancing v) { setField(1, v); }
  bool hasHttpLoadBalancing() => $_has(0, 1);
  void clearHttpLoadBalancing() => clearField(1);

  HorizontalPodAutoscaling get horizontalPodAutoscaling => $_get(1, 2, null);
  void set horizontalPodAutoscaling(HorizontalPodAutoscaling v) { setField(2, v); }
  bool hasHorizontalPodAutoscaling() => $_has(1, 2);
  void clearHorizontalPodAutoscaling() => clearField(2);
}

class _ReadonlyAddonsConfig extends AddonsConfig with ReadonlyMessageMixin {}

class HttpLoadBalancing extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HttpLoadBalancing')
    ..a/*<bool>*/(1, 'disabled', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  HttpLoadBalancing() : super();
  HttpLoadBalancing.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HttpLoadBalancing.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HttpLoadBalancing clone() => new HttpLoadBalancing()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HttpLoadBalancing create() => new HttpLoadBalancing();
  static PbList<HttpLoadBalancing> createRepeated() => new PbList<HttpLoadBalancing>();
  static HttpLoadBalancing getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHttpLoadBalancing();
    return _defaultInstance;
  }
  static HttpLoadBalancing _defaultInstance;
  static void $checkItem(HttpLoadBalancing v) {
    if (v is !HttpLoadBalancing) checkItemFailed(v, 'HttpLoadBalancing');
  }

  bool get disabled => $_get(0, 1, false);
  void set disabled(bool v) { $_setBool(0, 1, v); }
  bool hasDisabled() => $_has(0, 1);
  void clearDisabled() => clearField(1);
}

class _ReadonlyHttpLoadBalancing extends HttpLoadBalancing with ReadonlyMessageMixin {}

class HorizontalPodAutoscaling extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HorizontalPodAutoscaling')
    ..a/*<bool>*/(1, 'disabled', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  HorizontalPodAutoscaling() : super();
  HorizontalPodAutoscaling.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HorizontalPodAutoscaling.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HorizontalPodAutoscaling clone() => new HorizontalPodAutoscaling()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HorizontalPodAutoscaling create() => new HorizontalPodAutoscaling();
  static PbList<HorizontalPodAutoscaling> createRepeated() => new PbList<HorizontalPodAutoscaling>();
  static HorizontalPodAutoscaling getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHorizontalPodAutoscaling();
    return _defaultInstance;
  }
  static HorizontalPodAutoscaling _defaultInstance;
  static void $checkItem(HorizontalPodAutoscaling v) {
    if (v is !HorizontalPodAutoscaling) checkItemFailed(v, 'HorizontalPodAutoscaling');
  }

  bool get disabled => $_get(0, 1, false);
  void set disabled(bool v) { $_setBool(0, 1, v); }
  bool hasDisabled() => $_has(0, 1);
  void clearDisabled() => clearField(1);
}

class _ReadonlyHorizontalPodAutoscaling extends HorizontalPodAutoscaling with ReadonlyMessageMixin {}

class Cluster extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Cluster')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'description', PbFieldType.OS)
    ..a/*<int>*/(3, 'initialNodeCount', PbFieldType.O3)
    ..a/*<NodeConfig>*/(4, 'nodeConfig', PbFieldType.OM, NodeConfig.getDefault, NodeConfig.create)
    ..a/*<MasterAuth>*/(5, 'masterAuth', PbFieldType.OM, MasterAuth.getDefault, MasterAuth.create)
    ..a/*<String>*/(6, 'loggingService', PbFieldType.OS)
    ..a/*<String>*/(7, 'monitoringService', PbFieldType.OS)
    ..a/*<String>*/(8, 'network', PbFieldType.OS)
    ..a/*<String>*/(9, 'clusterIpv4Cidr', PbFieldType.OS)
    ..a/*<AddonsConfig>*/(10, 'addonsConfig', PbFieldType.OM, AddonsConfig.getDefault, AddonsConfig.create)
    ..a/*<String>*/(11, 'subnetwork', PbFieldType.OS)
    ..pp/*<NodePool>*/(12, 'nodePools', PbFieldType.PM, NodePool.$checkItem, NodePool.create)
    ..p/*<String>*/(13, 'locations', PbFieldType.PS)
    ..a/*<bool>*/(14, 'enableKubernetesAlpha', PbFieldType.OB)
    ..a/*<String>*/(100, 'selfLink', PbFieldType.OS)
    ..a/*<String>*/(101, 'zone', PbFieldType.OS)
    ..a/*<String>*/(102, 'endpoint', PbFieldType.OS)
    ..a/*<String>*/(103, 'initialClusterVersion', PbFieldType.OS)
    ..a/*<String>*/(104, 'currentMasterVersion', PbFieldType.OS)
    ..a/*<String>*/(105, 'currentNodeVersion', PbFieldType.OS)
    ..a/*<String>*/(106, 'createTime', PbFieldType.OS)
    ..e/*<Cluster_Status>*/(107, 'status', PbFieldType.OE, Cluster_Status.STATUS_UNSPECIFIED, Cluster_Status.valueOf)
    ..a/*<String>*/(108, 'statusMessage', PbFieldType.OS)
    ..a/*<int>*/(109, 'nodeIpv4CidrSize', PbFieldType.O3)
    ..a/*<String>*/(110, 'servicesIpv4Cidr', PbFieldType.OS)
    ..p/*<String>*/(111, 'instanceGroupUrls', PbFieldType.PS)
    ..a/*<int>*/(112, 'currentNodeCount', PbFieldType.O3)
    ..a/*<String>*/(113, 'expireTime', PbFieldType.OS)
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

  String get description => $_get(1, 2, '');
  void set description(String v) { $_setString(1, 2, v); }
  bool hasDescription() => $_has(1, 2);
  void clearDescription() => clearField(2);

  int get initialNodeCount => $_get(2, 3, 0);
  void set initialNodeCount(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasInitialNodeCount() => $_has(2, 3);
  void clearInitialNodeCount() => clearField(3);

  NodeConfig get nodeConfig => $_get(3, 4, null);
  void set nodeConfig(NodeConfig v) { setField(4, v); }
  bool hasNodeConfig() => $_has(3, 4);
  void clearNodeConfig() => clearField(4);

  MasterAuth get masterAuth => $_get(4, 5, null);
  void set masterAuth(MasterAuth v) { setField(5, v); }
  bool hasMasterAuth() => $_has(4, 5);
  void clearMasterAuth() => clearField(5);

  String get loggingService => $_get(5, 6, '');
  void set loggingService(String v) { $_setString(5, 6, v); }
  bool hasLoggingService() => $_has(5, 6);
  void clearLoggingService() => clearField(6);

  String get monitoringService => $_get(6, 7, '');
  void set monitoringService(String v) { $_setString(6, 7, v); }
  bool hasMonitoringService() => $_has(6, 7);
  void clearMonitoringService() => clearField(7);

  String get network => $_get(7, 8, '');
  void set network(String v) { $_setString(7, 8, v); }
  bool hasNetwork() => $_has(7, 8);
  void clearNetwork() => clearField(8);

  String get clusterIpv4Cidr => $_get(8, 9, '');
  void set clusterIpv4Cidr(String v) { $_setString(8, 9, v); }
  bool hasClusterIpv4Cidr() => $_has(8, 9);
  void clearClusterIpv4Cidr() => clearField(9);

  AddonsConfig get addonsConfig => $_get(9, 10, null);
  void set addonsConfig(AddonsConfig v) { setField(10, v); }
  bool hasAddonsConfig() => $_has(9, 10);
  void clearAddonsConfig() => clearField(10);

  String get subnetwork => $_get(10, 11, '');
  void set subnetwork(String v) { $_setString(10, 11, v); }
  bool hasSubnetwork() => $_has(10, 11);
  void clearSubnetwork() => clearField(11);

  List<NodePool> get nodePools => $_get(11, 12, null);

  List<String> get locations => $_get(12, 13, null);

  bool get enableKubernetesAlpha => $_get(13, 14, false);
  void set enableKubernetesAlpha(bool v) { $_setBool(13, 14, v); }
  bool hasEnableKubernetesAlpha() => $_has(13, 14);
  void clearEnableKubernetesAlpha() => clearField(14);

  String get selfLink => $_get(14, 100, '');
  void set selfLink(String v) { $_setString(14, 100, v); }
  bool hasSelfLink() => $_has(14, 100);
  void clearSelfLink() => clearField(100);

  String get zone => $_get(15, 101, '');
  void set zone(String v) { $_setString(15, 101, v); }
  bool hasZone() => $_has(15, 101);
  void clearZone() => clearField(101);

  String get endpoint => $_get(16, 102, '');
  void set endpoint(String v) { $_setString(16, 102, v); }
  bool hasEndpoint() => $_has(16, 102);
  void clearEndpoint() => clearField(102);

  String get initialClusterVersion => $_get(17, 103, '');
  void set initialClusterVersion(String v) { $_setString(17, 103, v); }
  bool hasInitialClusterVersion() => $_has(17, 103);
  void clearInitialClusterVersion() => clearField(103);

  String get currentMasterVersion => $_get(18, 104, '');
  void set currentMasterVersion(String v) { $_setString(18, 104, v); }
  bool hasCurrentMasterVersion() => $_has(18, 104);
  void clearCurrentMasterVersion() => clearField(104);

  String get currentNodeVersion => $_get(19, 105, '');
  void set currentNodeVersion(String v) { $_setString(19, 105, v); }
  bool hasCurrentNodeVersion() => $_has(19, 105);
  void clearCurrentNodeVersion() => clearField(105);

  String get createTime => $_get(20, 106, '');
  void set createTime(String v) { $_setString(20, 106, v); }
  bool hasCreateTime() => $_has(20, 106);
  void clearCreateTime() => clearField(106);

  Cluster_Status get status => $_get(21, 107, null);
  void set status(Cluster_Status v) { setField(107, v); }
  bool hasStatus() => $_has(21, 107);
  void clearStatus() => clearField(107);

  String get statusMessage => $_get(22, 108, '');
  void set statusMessage(String v) { $_setString(22, 108, v); }
  bool hasStatusMessage() => $_has(22, 108);
  void clearStatusMessage() => clearField(108);

  int get nodeIpv4CidrSize => $_get(23, 109, 0);
  void set nodeIpv4CidrSize(int v) { $_setUnsignedInt32(23, 109, v); }
  bool hasNodeIpv4CidrSize() => $_has(23, 109);
  void clearNodeIpv4CidrSize() => clearField(109);

  String get servicesIpv4Cidr => $_get(24, 110, '');
  void set servicesIpv4Cidr(String v) { $_setString(24, 110, v); }
  bool hasServicesIpv4Cidr() => $_has(24, 110);
  void clearServicesIpv4Cidr() => clearField(110);

  List<String> get instanceGroupUrls => $_get(25, 111, null);

  int get currentNodeCount => $_get(26, 112, 0);
  void set currentNodeCount(int v) { $_setUnsignedInt32(26, 112, v); }
  bool hasCurrentNodeCount() => $_has(26, 112);
  void clearCurrentNodeCount() => clearField(112);

  String get expireTime => $_get(27, 113, '');
  void set expireTime(String v) { $_setString(27, 113, v); }
  bool hasExpireTime() => $_has(27, 113);
  void clearExpireTime() => clearField(113);
}

class _ReadonlyCluster extends Cluster with ReadonlyMessageMixin {}

class ClusterUpdate extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ClusterUpdate')
    ..a/*<String>*/(4, 'desiredNodeVersion', PbFieldType.OS)
    ..a/*<String>*/(5, 'desiredMonitoringService', PbFieldType.OS)
    ..a/*<AddonsConfig>*/(6, 'desiredAddonsConfig', PbFieldType.OM, AddonsConfig.getDefault, AddonsConfig.create)
    ..a/*<String>*/(7, 'desiredNodePoolId', PbFieldType.OS)
    ..a/*<String>*/(8, 'desiredImageType', PbFieldType.OS)
    ..a/*<NodePoolAutoscaling>*/(9, 'desiredNodePoolAutoscaling', PbFieldType.OM, NodePoolAutoscaling.getDefault, NodePoolAutoscaling.create)
    ..p/*<String>*/(10, 'desiredLocations', PbFieldType.PS)
    ..a/*<String>*/(100, 'desiredMasterVersion', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ClusterUpdate() : super();
  ClusterUpdate.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ClusterUpdate.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ClusterUpdate clone() => new ClusterUpdate()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ClusterUpdate create() => new ClusterUpdate();
  static PbList<ClusterUpdate> createRepeated() => new PbList<ClusterUpdate>();
  static ClusterUpdate getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyClusterUpdate();
    return _defaultInstance;
  }
  static ClusterUpdate _defaultInstance;
  static void $checkItem(ClusterUpdate v) {
    if (v is !ClusterUpdate) checkItemFailed(v, 'ClusterUpdate');
  }

  String get desiredNodeVersion => $_get(0, 4, '');
  void set desiredNodeVersion(String v) { $_setString(0, 4, v); }
  bool hasDesiredNodeVersion() => $_has(0, 4);
  void clearDesiredNodeVersion() => clearField(4);

  String get desiredMonitoringService => $_get(1, 5, '');
  void set desiredMonitoringService(String v) { $_setString(1, 5, v); }
  bool hasDesiredMonitoringService() => $_has(1, 5);
  void clearDesiredMonitoringService() => clearField(5);

  AddonsConfig get desiredAddonsConfig => $_get(2, 6, null);
  void set desiredAddonsConfig(AddonsConfig v) { setField(6, v); }
  bool hasDesiredAddonsConfig() => $_has(2, 6);
  void clearDesiredAddonsConfig() => clearField(6);

  String get desiredNodePoolId => $_get(3, 7, '');
  void set desiredNodePoolId(String v) { $_setString(3, 7, v); }
  bool hasDesiredNodePoolId() => $_has(3, 7);
  void clearDesiredNodePoolId() => clearField(7);

  String get desiredImageType => $_get(4, 8, '');
  void set desiredImageType(String v) { $_setString(4, 8, v); }
  bool hasDesiredImageType() => $_has(4, 8);
  void clearDesiredImageType() => clearField(8);

  NodePoolAutoscaling get desiredNodePoolAutoscaling => $_get(5, 9, null);
  void set desiredNodePoolAutoscaling(NodePoolAutoscaling v) { setField(9, v); }
  bool hasDesiredNodePoolAutoscaling() => $_has(5, 9);
  void clearDesiredNodePoolAutoscaling() => clearField(9);

  List<String> get desiredLocations => $_get(6, 10, null);

  String get desiredMasterVersion => $_get(7, 100, '');
  void set desiredMasterVersion(String v) { $_setString(7, 100, v); }
  bool hasDesiredMasterVersion() => $_has(7, 100);
  void clearDesiredMasterVersion() => clearField(100);
}

class _ReadonlyClusterUpdate extends ClusterUpdate with ReadonlyMessageMixin {}

class Operation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Operation')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..e/*<Operation_Type>*/(3, 'operationType', PbFieldType.OE, Operation_Type.TYPE_UNSPECIFIED, Operation_Type.valueOf)
    ..e/*<Operation_Status>*/(4, 'status', PbFieldType.OE, Operation_Status.STATUS_UNSPECIFIED, Operation_Status.valueOf)
    ..a/*<String>*/(5, 'statusMessage', PbFieldType.OS)
    ..a/*<String>*/(6, 'selfLink', PbFieldType.OS)
    ..a/*<String>*/(7, 'targetLink', PbFieldType.OS)
    ..a/*<String>*/(8, 'detail', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Operation() : super();
  Operation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Operation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Operation clone() => new Operation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Operation create() => new Operation();
  static PbList<Operation> createRepeated() => new PbList<Operation>();
  static Operation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOperation();
    return _defaultInstance;
  }
  static Operation _defaultInstance;
  static void $checkItem(Operation v) {
    if (v is !Operation) checkItemFailed(v, 'Operation');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  Operation_Type get operationType => $_get(2, 3, null);
  void set operationType(Operation_Type v) { setField(3, v); }
  bool hasOperationType() => $_has(2, 3);
  void clearOperationType() => clearField(3);

  Operation_Status get status => $_get(3, 4, null);
  void set status(Operation_Status v) { setField(4, v); }
  bool hasStatus() => $_has(3, 4);
  void clearStatus() => clearField(4);

  String get statusMessage => $_get(4, 5, '');
  void set statusMessage(String v) { $_setString(4, 5, v); }
  bool hasStatusMessage() => $_has(4, 5);
  void clearStatusMessage() => clearField(5);

  String get selfLink => $_get(5, 6, '');
  void set selfLink(String v) { $_setString(5, 6, v); }
  bool hasSelfLink() => $_has(5, 6);
  void clearSelfLink() => clearField(6);

  String get targetLink => $_get(6, 7, '');
  void set targetLink(String v) { $_setString(6, 7, v); }
  bool hasTargetLink() => $_has(6, 7);
  void clearTargetLink() => clearField(7);

  String get detail => $_get(7, 8, '');
  void set detail(String v) { $_setString(7, 8, v); }
  bool hasDetail() => $_has(7, 8);
  void clearDetail() => clearField(8);
}

class _ReadonlyOperation extends Operation with ReadonlyMessageMixin {}

class CreateClusterRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateClusterRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..a/*<Cluster>*/(3, 'cluster', PbFieldType.OM, Cluster.getDefault, Cluster.create)
    ..hasRequiredFields = false
  ;

  CreateClusterRequest() : super();
  CreateClusterRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateClusterRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateClusterRequest clone() => new CreateClusterRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateClusterRequest create() => new CreateClusterRequest();
  static PbList<CreateClusterRequest> createRepeated() => new PbList<CreateClusterRequest>();
  static CreateClusterRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateClusterRequest();
    return _defaultInstance;
  }
  static CreateClusterRequest _defaultInstance;
  static void $checkItem(CreateClusterRequest v) {
    if (v is !CreateClusterRequest) checkItemFailed(v, 'CreateClusterRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  Cluster get cluster => $_get(2, 3, null);
  void set cluster(Cluster v) { setField(3, v); }
  bool hasCluster() => $_has(2, 3);
  void clearCluster() => clearField(3);
}

class _ReadonlyCreateClusterRequest extends CreateClusterRequest with ReadonlyMessageMixin {}

class GetClusterRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetClusterRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..a/*<String>*/(3, 'clusterId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetClusterRequest() : super();
  GetClusterRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetClusterRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetClusterRequest clone() => new GetClusterRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetClusterRequest create() => new GetClusterRequest();
  static PbList<GetClusterRequest> createRepeated() => new PbList<GetClusterRequest>();
  static GetClusterRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetClusterRequest();
    return _defaultInstance;
  }
  static GetClusterRequest _defaultInstance;
  static void $checkItem(GetClusterRequest v) {
    if (v is !GetClusterRequest) checkItemFailed(v, 'GetClusterRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  String get clusterId => $_get(2, 3, '');
  void set clusterId(String v) { $_setString(2, 3, v); }
  bool hasClusterId() => $_has(2, 3);
  void clearClusterId() => clearField(3);
}

class _ReadonlyGetClusterRequest extends GetClusterRequest with ReadonlyMessageMixin {}

class UpdateClusterRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateClusterRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..a/*<String>*/(3, 'clusterId', PbFieldType.OS)
    ..a/*<ClusterUpdate>*/(4, 'update', PbFieldType.OM, ClusterUpdate.getDefault, ClusterUpdate.create)
    ..hasRequiredFields = false
  ;

  UpdateClusterRequest() : super();
  UpdateClusterRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateClusterRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateClusterRequest clone() => new UpdateClusterRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateClusterRequest create() => new UpdateClusterRequest();
  static PbList<UpdateClusterRequest> createRepeated() => new PbList<UpdateClusterRequest>();
  static UpdateClusterRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateClusterRequest();
    return _defaultInstance;
  }
  static UpdateClusterRequest _defaultInstance;
  static void $checkItem(UpdateClusterRequest v) {
    if (v is !UpdateClusterRequest) checkItemFailed(v, 'UpdateClusterRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  String get clusterId => $_get(2, 3, '');
  void set clusterId(String v) { $_setString(2, 3, v); }
  bool hasClusterId() => $_has(2, 3);
  void clearClusterId() => clearField(3);

  ClusterUpdate get update => $_get(3, 4, null);
  void set update(ClusterUpdate v) { setField(4, v); }
  bool hasUpdate() => $_has(3, 4);
  void clearUpdate() => clearField(4);
}

class _ReadonlyUpdateClusterRequest extends UpdateClusterRequest with ReadonlyMessageMixin {}

class DeleteClusterRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteClusterRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..a/*<String>*/(3, 'clusterId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteClusterRequest() : super();
  DeleteClusterRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteClusterRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteClusterRequest clone() => new DeleteClusterRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteClusterRequest create() => new DeleteClusterRequest();
  static PbList<DeleteClusterRequest> createRepeated() => new PbList<DeleteClusterRequest>();
  static DeleteClusterRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteClusterRequest();
    return _defaultInstance;
  }
  static DeleteClusterRequest _defaultInstance;
  static void $checkItem(DeleteClusterRequest v) {
    if (v is !DeleteClusterRequest) checkItemFailed(v, 'DeleteClusterRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  String get clusterId => $_get(2, 3, '');
  void set clusterId(String v) { $_setString(2, 3, v); }
  bool hasClusterId() => $_has(2, 3);
  void clearClusterId() => clearField(3);
}

class _ReadonlyDeleteClusterRequest extends DeleteClusterRequest with ReadonlyMessageMixin {}

class ListClustersRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListClustersRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListClustersRequest() : super();
  ListClustersRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListClustersRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListClustersRequest clone() => new ListClustersRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListClustersRequest create() => new ListClustersRequest();
  static PbList<ListClustersRequest> createRepeated() => new PbList<ListClustersRequest>();
  static ListClustersRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListClustersRequest();
    return _defaultInstance;
  }
  static ListClustersRequest _defaultInstance;
  static void $checkItem(ListClustersRequest v) {
    if (v is !ListClustersRequest) checkItemFailed(v, 'ListClustersRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);
}

class _ReadonlyListClustersRequest extends ListClustersRequest with ReadonlyMessageMixin {}

class ListClustersResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListClustersResponse')
    ..pp/*<Cluster>*/(1, 'clusters', PbFieldType.PM, Cluster.$checkItem, Cluster.create)
    ..p/*<String>*/(2, 'missingZones', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  ListClustersResponse() : super();
  ListClustersResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListClustersResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListClustersResponse clone() => new ListClustersResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListClustersResponse create() => new ListClustersResponse();
  static PbList<ListClustersResponse> createRepeated() => new PbList<ListClustersResponse>();
  static ListClustersResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListClustersResponse();
    return _defaultInstance;
  }
  static ListClustersResponse _defaultInstance;
  static void $checkItem(ListClustersResponse v) {
    if (v is !ListClustersResponse) checkItemFailed(v, 'ListClustersResponse');
  }

  List<Cluster> get clusters => $_get(0, 1, null);

  List<String> get missingZones => $_get(1, 2, null);
}

class _ReadonlyListClustersResponse extends ListClustersResponse with ReadonlyMessageMixin {}

class GetOperationRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetOperationRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..a/*<String>*/(3, 'operationId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetOperationRequest() : super();
  GetOperationRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetOperationRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetOperationRequest clone() => new GetOperationRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetOperationRequest create() => new GetOperationRequest();
  static PbList<GetOperationRequest> createRepeated() => new PbList<GetOperationRequest>();
  static GetOperationRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetOperationRequest();
    return _defaultInstance;
  }
  static GetOperationRequest _defaultInstance;
  static void $checkItem(GetOperationRequest v) {
    if (v is !GetOperationRequest) checkItemFailed(v, 'GetOperationRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  String get operationId => $_get(2, 3, '');
  void set operationId(String v) { $_setString(2, 3, v); }
  bool hasOperationId() => $_has(2, 3);
  void clearOperationId() => clearField(3);
}

class _ReadonlyGetOperationRequest extends GetOperationRequest with ReadonlyMessageMixin {}

class ListOperationsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListOperationsRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListOperationsRequest() : super();
  ListOperationsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListOperationsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListOperationsRequest clone() => new ListOperationsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListOperationsRequest create() => new ListOperationsRequest();
  static PbList<ListOperationsRequest> createRepeated() => new PbList<ListOperationsRequest>();
  static ListOperationsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListOperationsRequest();
    return _defaultInstance;
  }
  static ListOperationsRequest _defaultInstance;
  static void $checkItem(ListOperationsRequest v) {
    if (v is !ListOperationsRequest) checkItemFailed(v, 'ListOperationsRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);
}

class _ReadonlyListOperationsRequest extends ListOperationsRequest with ReadonlyMessageMixin {}

class CancelOperationRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CancelOperationRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..a/*<String>*/(3, 'operationId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CancelOperationRequest() : super();
  CancelOperationRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CancelOperationRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CancelOperationRequest clone() => new CancelOperationRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CancelOperationRequest create() => new CancelOperationRequest();
  static PbList<CancelOperationRequest> createRepeated() => new PbList<CancelOperationRequest>();
  static CancelOperationRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCancelOperationRequest();
    return _defaultInstance;
  }
  static CancelOperationRequest _defaultInstance;
  static void $checkItem(CancelOperationRequest v) {
    if (v is !CancelOperationRequest) checkItemFailed(v, 'CancelOperationRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  String get operationId => $_get(2, 3, '');
  void set operationId(String v) { $_setString(2, 3, v); }
  bool hasOperationId() => $_has(2, 3);
  void clearOperationId() => clearField(3);
}

class _ReadonlyCancelOperationRequest extends CancelOperationRequest with ReadonlyMessageMixin {}

class ListOperationsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListOperationsResponse')
    ..pp/*<Operation>*/(1, 'operations', PbFieldType.PM, Operation.$checkItem, Operation.create)
    ..p/*<String>*/(2, 'missingZones', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  ListOperationsResponse() : super();
  ListOperationsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListOperationsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListOperationsResponse clone() => new ListOperationsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListOperationsResponse create() => new ListOperationsResponse();
  static PbList<ListOperationsResponse> createRepeated() => new PbList<ListOperationsResponse>();
  static ListOperationsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListOperationsResponse();
    return _defaultInstance;
  }
  static ListOperationsResponse _defaultInstance;
  static void $checkItem(ListOperationsResponse v) {
    if (v is !ListOperationsResponse) checkItemFailed(v, 'ListOperationsResponse');
  }

  List<Operation> get operations => $_get(0, 1, null);

  List<String> get missingZones => $_get(1, 2, null);
}

class _ReadonlyListOperationsResponse extends ListOperationsResponse with ReadonlyMessageMixin {}

class GetServerConfigRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetServerConfigRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetServerConfigRequest() : super();
  GetServerConfigRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetServerConfigRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetServerConfigRequest clone() => new GetServerConfigRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetServerConfigRequest create() => new GetServerConfigRequest();
  static PbList<GetServerConfigRequest> createRepeated() => new PbList<GetServerConfigRequest>();
  static GetServerConfigRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetServerConfigRequest();
    return _defaultInstance;
  }
  static GetServerConfigRequest _defaultInstance;
  static void $checkItem(GetServerConfigRequest v) {
    if (v is !GetServerConfigRequest) checkItemFailed(v, 'GetServerConfigRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);
}

class _ReadonlyGetServerConfigRequest extends GetServerConfigRequest with ReadonlyMessageMixin {}

class ServerConfig extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ServerConfig')
    ..a/*<String>*/(1, 'defaultClusterVersion', PbFieldType.OS)
    ..p/*<String>*/(3, 'validNodeVersions', PbFieldType.PS)
    ..a/*<String>*/(4, 'defaultImageType', PbFieldType.OS)
    ..p/*<String>*/(5, 'validImageTypes', PbFieldType.PS)
    ..p/*<String>*/(6, 'validMasterVersions', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  ServerConfig() : super();
  ServerConfig.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ServerConfig.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ServerConfig clone() => new ServerConfig()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ServerConfig create() => new ServerConfig();
  static PbList<ServerConfig> createRepeated() => new PbList<ServerConfig>();
  static ServerConfig getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyServerConfig();
    return _defaultInstance;
  }
  static ServerConfig _defaultInstance;
  static void $checkItem(ServerConfig v) {
    if (v is !ServerConfig) checkItemFailed(v, 'ServerConfig');
  }

  String get defaultClusterVersion => $_get(0, 1, '');
  void set defaultClusterVersion(String v) { $_setString(0, 1, v); }
  bool hasDefaultClusterVersion() => $_has(0, 1);
  void clearDefaultClusterVersion() => clearField(1);

  List<String> get validNodeVersions => $_get(1, 3, null);

  String get defaultImageType => $_get(2, 4, '');
  void set defaultImageType(String v) { $_setString(2, 4, v); }
  bool hasDefaultImageType() => $_has(2, 4);
  void clearDefaultImageType() => clearField(4);

  List<String> get validImageTypes => $_get(3, 5, null);

  List<String> get validMasterVersions => $_get(4, 6, null);
}

class _ReadonlyServerConfig extends ServerConfig with ReadonlyMessageMixin {}

class CreateNodePoolRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateNodePoolRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..a/*<String>*/(3, 'clusterId', PbFieldType.OS)
    ..a/*<NodePool>*/(4, 'nodePool', PbFieldType.OM, NodePool.getDefault, NodePool.create)
    ..hasRequiredFields = false
  ;

  CreateNodePoolRequest() : super();
  CreateNodePoolRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateNodePoolRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateNodePoolRequest clone() => new CreateNodePoolRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateNodePoolRequest create() => new CreateNodePoolRequest();
  static PbList<CreateNodePoolRequest> createRepeated() => new PbList<CreateNodePoolRequest>();
  static CreateNodePoolRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateNodePoolRequest();
    return _defaultInstance;
  }
  static CreateNodePoolRequest _defaultInstance;
  static void $checkItem(CreateNodePoolRequest v) {
    if (v is !CreateNodePoolRequest) checkItemFailed(v, 'CreateNodePoolRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  String get clusterId => $_get(2, 3, '');
  void set clusterId(String v) { $_setString(2, 3, v); }
  bool hasClusterId() => $_has(2, 3);
  void clearClusterId() => clearField(3);

  NodePool get nodePool => $_get(3, 4, null);
  void set nodePool(NodePool v) { setField(4, v); }
  bool hasNodePool() => $_has(3, 4);
  void clearNodePool() => clearField(4);
}

class _ReadonlyCreateNodePoolRequest extends CreateNodePoolRequest with ReadonlyMessageMixin {}

class DeleteNodePoolRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteNodePoolRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..a/*<String>*/(3, 'clusterId', PbFieldType.OS)
    ..a/*<String>*/(4, 'nodePoolId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteNodePoolRequest() : super();
  DeleteNodePoolRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteNodePoolRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteNodePoolRequest clone() => new DeleteNodePoolRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteNodePoolRequest create() => new DeleteNodePoolRequest();
  static PbList<DeleteNodePoolRequest> createRepeated() => new PbList<DeleteNodePoolRequest>();
  static DeleteNodePoolRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteNodePoolRequest();
    return _defaultInstance;
  }
  static DeleteNodePoolRequest _defaultInstance;
  static void $checkItem(DeleteNodePoolRequest v) {
    if (v is !DeleteNodePoolRequest) checkItemFailed(v, 'DeleteNodePoolRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  String get clusterId => $_get(2, 3, '');
  void set clusterId(String v) { $_setString(2, 3, v); }
  bool hasClusterId() => $_has(2, 3);
  void clearClusterId() => clearField(3);

  String get nodePoolId => $_get(3, 4, '');
  void set nodePoolId(String v) { $_setString(3, 4, v); }
  bool hasNodePoolId() => $_has(3, 4);
  void clearNodePoolId() => clearField(4);
}

class _ReadonlyDeleteNodePoolRequest extends DeleteNodePoolRequest with ReadonlyMessageMixin {}

class ListNodePoolsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListNodePoolsRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..a/*<String>*/(3, 'clusterId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListNodePoolsRequest() : super();
  ListNodePoolsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListNodePoolsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListNodePoolsRequest clone() => new ListNodePoolsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListNodePoolsRequest create() => new ListNodePoolsRequest();
  static PbList<ListNodePoolsRequest> createRepeated() => new PbList<ListNodePoolsRequest>();
  static ListNodePoolsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListNodePoolsRequest();
    return _defaultInstance;
  }
  static ListNodePoolsRequest _defaultInstance;
  static void $checkItem(ListNodePoolsRequest v) {
    if (v is !ListNodePoolsRequest) checkItemFailed(v, 'ListNodePoolsRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  String get clusterId => $_get(2, 3, '');
  void set clusterId(String v) { $_setString(2, 3, v); }
  bool hasClusterId() => $_has(2, 3);
  void clearClusterId() => clearField(3);
}

class _ReadonlyListNodePoolsRequest extends ListNodePoolsRequest with ReadonlyMessageMixin {}

class GetNodePoolRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetNodePoolRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..a/*<String>*/(3, 'clusterId', PbFieldType.OS)
    ..a/*<String>*/(4, 'nodePoolId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetNodePoolRequest() : super();
  GetNodePoolRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetNodePoolRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetNodePoolRequest clone() => new GetNodePoolRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetNodePoolRequest create() => new GetNodePoolRequest();
  static PbList<GetNodePoolRequest> createRepeated() => new PbList<GetNodePoolRequest>();
  static GetNodePoolRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetNodePoolRequest();
    return _defaultInstance;
  }
  static GetNodePoolRequest _defaultInstance;
  static void $checkItem(GetNodePoolRequest v) {
    if (v is !GetNodePoolRequest) checkItemFailed(v, 'GetNodePoolRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  String get clusterId => $_get(2, 3, '');
  void set clusterId(String v) { $_setString(2, 3, v); }
  bool hasClusterId() => $_has(2, 3);
  void clearClusterId() => clearField(3);

  String get nodePoolId => $_get(3, 4, '');
  void set nodePoolId(String v) { $_setString(3, 4, v); }
  bool hasNodePoolId() => $_has(3, 4);
  void clearNodePoolId() => clearField(4);
}

class _ReadonlyGetNodePoolRequest extends GetNodePoolRequest with ReadonlyMessageMixin {}

class NodePool extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('NodePool')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<NodeConfig>*/(2, 'config', PbFieldType.OM, NodeConfig.getDefault, NodeConfig.create)
    ..a/*<int>*/(3, 'initialNodeCount', PbFieldType.O3)
    ..a/*<NodePoolAutoscaling>*/(4, 'autoscaling', PbFieldType.OM, NodePoolAutoscaling.getDefault, NodePoolAutoscaling.create)
    ..a/*<NodeManagement>*/(5, 'management', PbFieldType.OM, NodeManagement.getDefault, NodeManagement.create)
    ..a/*<String>*/(100, 'selfLink', PbFieldType.OS)
    ..a/*<String>*/(101, 'version', PbFieldType.OS)
    ..p/*<String>*/(102, 'instanceGroupUrls', PbFieldType.PS)
    ..e/*<NodePool_Status>*/(103, 'status', PbFieldType.OE, NodePool_Status.STATUS_UNSPECIFIED, NodePool_Status.valueOf)
    ..a/*<String>*/(104, 'statusMessage', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  NodePool() : super();
  NodePool.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NodePool.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NodePool clone() => new NodePool()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static NodePool create() => new NodePool();
  static PbList<NodePool> createRepeated() => new PbList<NodePool>();
  static NodePool getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyNodePool();
    return _defaultInstance;
  }
  static NodePool _defaultInstance;
  static void $checkItem(NodePool v) {
    if (v is !NodePool) checkItemFailed(v, 'NodePool');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  NodeConfig get config => $_get(1, 2, null);
  void set config(NodeConfig v) { setField(2, v); }
  bool hasConfig() => $_has(1, 2);
  void clearConfig() => clearField(2);

  int get initialNodeCount => $_get(2, 3, 0);
  void set initialNodeCount(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasInitialNodeCount() => $_has(2, 3);
  void clearInitialNodeCount() => clearField(3);

  NodePoolAutoscaling get autoscaling => $_get(3, 4, null);
  void set autoscaling(NodePoolAutoscaling v) { setField(4, v); }
  bool hasAutoscaling() => $_has(3, 4);
  void clearAutoscaling() => clearField(4);

  NodeManagement get management => $_get(4, 5, null);
  void set management(NodeManagement v) { setField(5, v); }
  bool hasManagement() => $_has(4, 5);
  void clearManagement() => clearField(5);

  String get selfLink => $_get(5, 100, '');
  void set selfLink(String v) { $_setString(5, 100, v); }
  bool hasSelfLink() => $_has(5, 100);
  void clearSelfLink() => clearField(100);

  String get version => $_get(6, 101, '');
  void set version(String v) { $_setString(6, 101, v); }
  bool hasVersion() => $_has(6, 101);
  void clearVersion() => clearField(101);

  List<String> get instanceGroupUrls => $_get(7, 102, null);

  NodePool_Status get status => $_get(8, 103, null);
  void set status(NodePool_Status v) { setField(103, v); }
  bool hasStatus() => $_has(8, 103);
  void clearStatus() => clearField(103);

  String get statusMessage => $_get(9, 104, '');
  void set statusMessage(String v) { $_setString(9, 104, v); }
  bool hasStatusMessage() => $_has(9, 104);
  void clearStatusMessage() => clearField(104);
}

class _ReadonlyNodePool extends NodePool with ReadonlyMessageMixin {}

class NodeManagement extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('NodeManagement')
    ..a/*<bool>*/(1, 'autoUpgrade', PbFieldType.OB)
    ..a/*<AutoUpgradeOptions>*/(10, 'upgradeOptions', PbFieldType.OM, AutoUpgradeOptions.getDefault, AutoUpgradeOptions.create)
    ..hasRequiredFields = false
  ;

  NodeManagement() : super();
  NodeManagement.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NodeManagement.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NodeManagement clone() => new NodeManagement()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static NodeManagement create() => new NodeManagement();
  static PbList<NodeManagement> createRepeated() => new PbList<NodeManagement>();
  static NodeManagement getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyNodeManagement();
    return _defaultInstance;
  }
  static NodeManagement _defaultInstance;
  static void $checkItem(NodeManagement v) {
    if (v is !NodeManagement) checkItemFailed(v, 'NodeManagement');
  }

  bool get autoUpgrade => $_get(0, 1, false);
  void set autoUpgrade(bool v) { $_setBool(0, 1, v); }
  bool hasAutoUpgrade() => $_has(0, 1);
  void clearAutoUpgrade() => clearField(1);

  AutoUpgradeOptions get upgradeOptions => $_get(1, 10, null);
  void set upgradeOptions(AutoUpgradeOptions v) { setField(10, v); }
  bool hasUpgradeOptions() => $_has(1, 10);
  void clearUpgradeOptions() => clearField(10);
}

class _ReadonlyNodeManagement extends NodeManagement with ReadonlyMessageMixin {}

class AutoUpgradeOptions extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AutoUpgradeOptions')
    ..a/*<String>*/(1, 'autoUpgradeStartTime', PbFieldType.OS)
    ..a/*<String>*/(2, 'description', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  AutoUpgradeOptions() : super();
  AutoUpgradeOptions.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AutoUpgradeOptions.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AutoUpgradeOptions clone() => new AutoUpgradeOptions()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AutoUpgradeOptions create() => new AutoUpgradeOptions();
  static PbList<AutoUpgradeOptions> createRepeated() => new PbList<AutoUpgradeOptions>();
  static AutoUpgradeOptions getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAutoUpgradeOptions();
    return _defaultInstance;
  }
  static AutoUpgradeOptions _defaultInstance;
  static void $checkItem(AutoUpgradeOptions v) {
    if (v is !AutoUpgradeOptions) checkItemFailed(v, 'AutoUpgradeOptions');
  }

  String get autoUpgradeStartTime => $_get(0, 1, '');
  void set autoUpgradeStartTime(String v) { $_setString(0, 1, v); }
  bool hasAutoUpgradeStartTime() => $_has(0, 1);
  void clearAutoUpgradeStartTime() => clearField(1);

  String get description => $_get(1, 2, '');
  void set description(String v) { $_setString(1, 2, v); }
  bool hasDescription() => $_has(1, 2);
  void clearDescription() => clearField(2);
}

class _ReadonlyAutoUpgradeOptions extends AutoUpgradeOptions with ReadonlyMessageMixin {}

class SetNodePoolManagementRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SetNodePoolManagementRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..a/*<String>*/(3, 'clusterId', PbFieldType.OS)
    ..a/*<String>*/(4, 'nodePoolId', PbFieldType.OS)
    ..a/*<NodeManagement>*/(5, 'management', PbFieldType.OM, NodeManagement.getDefault, NodeManagement.create)
    ..hasRequiredFields = false
  ;

  SetNodePoolManagementRequest() : super();
  SetNodePoolManagementRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SetNodePoolManagementRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SetNodePoolManagementRequest clone() => new SetNodePoolManagementRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SetNodePoolManagementRequest create() => new SetNodePoolManagementRequest();
  static PbList<SetNodePoolManagementRequest> createRepeated() => new PbList<SetNodePoolManagementRequest>();
  static SetNodePoolManagementRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySetNodePoolManagementRequest();
    return _defaultInstance;
  }
  static SetNodePoolManagementRequest _defaultInstance;
  static void $checkItem(SetNodePoolManagementRequest v) {
    if (v is !SetNodePoolManagementRequest) checkItemFailed(v, 'SetNodePoolManagementRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  String get clusterId => $_get(2, 3, '');
  void set clusterId(String v) { $_setString(2, 3, v); }
  bool hasClusterId() => $_has(2, 3);
  void clearClusterId() => clearField(3);

  String get nodePoolId => $_get(3, 4, '');
  void set nodePoolId(String v) { $_setString(3, 4, v); }
  bool hasNodePoolId() => $_has(3, 4);
  void clearNodePoolId() => clearField(4);

  NodeManagement get management => $_get(4, 5, null);
  void set management(NodeManagement v) { setField(5, v); }
  bool hasManagement() => $_has(4, 5);
  void clearManagement() => clearField(5);
}

class _ReadonlySetNodePoolManagementRequest extends SetNodePoolManagementRequest with ReadonlyMessageMixin {}

class RollbackNodePoolUpgradeRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RollbackNodePoolUpgradeRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'zone', PbFieldType.OS)
    ..a/*<String>*/(3, 'clusterId', PbFieldType.OS)
    ..a/*<String>*/(4, 'nodePoolId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  RollbackNodePoolUpgradeRequest() : super();
  RollbackNodePoolUpgradeRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RollbackNodePoolUpgradeRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RollbackNodePoolUpgradeRequest clone() => new RollbackNodePoolUpgradeRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RollbackNodePoolUpgradeRequest create() => new RollbackNodePoolUpgradeRequest();
  static PbList<RollbackNodePoolUpgradeRequest> createRepeated() => new PbList<RollbackNodePoolUpgradeRequest>();
  static RollbackNodePoolUpgradeRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRollbackNodePoolUpgradeRequest();
    return _defaultInstance;
  }
  static RollbackNodePoolUpgradeRequest _defaultInstance;
  static void $checkItem(RollbackNodePoolUpgradeRequest v) {
    if (v is !RollbackNodePoolUpgradeRequest) checkItemFailed(v, 'RollbackNodePoolUpgradeRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get zone => $_get(1, 2, '');
  void set zone(String v) { $_setString(1, 2, v); }
  bool hasZone() => $_has(1, 2);
  void clearZone() => clearField(2);

  String get clusterId => $_get(2, 3, '');
  void set clusterId(String v) { $_setString(2, 3, v); }
  bool hasClusterId() => $_has(2, 3);
  void clearClusterId() => clearField(3);

  String get nodePoolId => $_get(3, 4, '');
  void set nodePoolId(String v) { $_setString(3, 4, v); }
  bool hasNodePoolId() => $_has(3, 4);
  void clearNodePoolId() => clearField(4);
}

class _ReadonlyRollbackNodePoolUpgradeRequest extends RollbackNodePoolUpgradeRequest with ReadonlyMessageMixin {}

class ListNodePoolsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListNodePoolsResponse')
    ..pp/*<NodePool>*/(1, 'nodePools', PbFieldType.PM, NodePool.$checkItem, NodePool.create)
    ..hasRequiredFields = false
  ;

  ListNodePoolsResponse() : super();
  ListNodePoolsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListNodePoolsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListNodePoolsResponse clone() => new ListNodePoolsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListNodePoolsResponse create() => new ListNodePoolsResponse();
  static PbList<ListNodePoolsResponse> createRepeated() => new PbList<ListNodePoolsResponse>();
  static ListNodePoolsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListNodePoolsResponse();
    return _defaultInstance;
  }
  static ListNodePoolsResponse _defaultInstance;
  static void $checkItem(ListNodePoolsResponse v) {
    if (v is !ListNodePoolsResponse) checkItemFailed(v, 'ListNodePoolsResponse');
  }

  List<NodePool> get nodePools => $_get(0, 1, null);
}

class _ReadonlyListNodePoolsResponse extends ListNodePoolsResponse with ReadonlyMessageMixin {}

class NodePoolAutoscaling extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('NodePoolAutoscaling')
    ..a/*<bool>*/(1, 'enabled', PbFieldType.OB)
    ..a/*<int>*/(2, 'minNodeCount', PbFieldType.O3)
    ..a/*<int>*/(3, 'maxNodeCount', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  NodePoolAutoscaling() : super();
  NodePoolAutoscaling.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NodePoolAutoscaling.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NodePoolAutoscaling clone() => new NodePoolAutoscaling()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static NodePoolAutoscaling create() => new NodePoolAutoscaling();
  static PbList<NodePoolAutoscaling> createRepeated() => new PbList<NodePoolAutoscaling>();
  static NodePoolAutoscaling getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyNodePoolAutoscaling();
    return _defaultInstance;
  }
  static NodePoolAutoscaling _defaultInstance;
  static void $checkItem(NodePoolAutoscaling v) {
    if (v is !NodePoolAutoscaling) checkItemFailed(v, 'NodePoolAutoscaling');
  }

  bool get enabled => $_get(0, 1, false);
  void set enabled(bool v) { $_setBool(0, 1, v); }
  bool hasEnabled() => $_has(0, 1);
  void clearEnabled() => clearField(1);

  int get minNodeCount => $_get(1, 2, 0);
  void set minNodeCount(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasMinNodeCount() => $_has(1, 2);
  void clearMinNodeCount() => clearField(2);

  int get maxNodeCount => $_get(2, 3, 0);
  void set maxNodeCount(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasMaxNodeCount() => $_has(2, 3);
  void clearMaxNodeCount() => clearField(3);
}

class _ReadonlyNodePoolAutoscaling extends NodePoolAutoscaling with ReadonlyMessageMixin {}

class ClusterManagerApi {
  RpcClient _client;
  ClusterManagerApi(this._client);

  Future<ListClustersResponse> listClusters(ClientContext ctx, ListClustersRequest request) {
    var emptyResponse = new ListClustersResponse();
    return _client.invoke(ctx, 'ClusterManager', 'ListClusters', request, emptyResponse);
  }
  Future<Cluster> getCluster(ClientContext ctx, GetClusterRequest request) {
    var emptyResponse = new Cluster();
    return _client.invoke(ctx, 'ClusterManager', 'GetCluster', request, emptyResponse);
  }
  Future<Operation> createCluster(ClientContext ctx, CreateClusterRequest request) {
    var emptyResponse = new Operation();
    return _client.invoke(ctx, 'ClusterManager', 'CreateCluster', request, emptyResponse);
  }
  Future<Operation> updateCluster(ClientContext ctx, UpdateClusterRequest request) {
    var emptyResponse = new Operation();
    return _client.invoke(ctx, 'ClusterManager', 'UpdateCluster', request, emptyResponse);
  }
  Future<Operation> deleteCluster(ClientContext ctx, DeleteClusterRequest request) {
    var emptyResponse = new Operation();
    return _client.invoke(ctx, 'ClusterManager', 'DeleteCluster', request, emptyResponse);
  }
  Future<ListOperationsResponse> listOperations(ClientContext ctx, ListOperationsRequest request) {
    var emptyResponse = new ListOperationsResponse();
    return _client.invoke(ctx, 'ClusterManager', 'ListOperations', request, emptyResponse);
  }
  Future<Operation> getOperation(ClientContext ctx, GetOperationRequest request) {
    var emptyResponse = new Operation();
    return _client.invoke(ctx, 'ClusterManager', 'GetOperation', request, emptyResponse);
  }
  Future<google$protobuf.Empty> cancelOperation(ClientContext ctx, CancelOperationRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'ClusterManager', 'CancelOperation', request, emptyResponse);
  }
  Future<ServerConfig> getServerConfig(ClientContext ctx, GetServerConfigRequest request) {
    var emptyResponse = new ServerConfig();
    return _client.invoke(ctx, 'ClusterManager', 'GetServerConfig', request, emptyResponse);
  }
  Future<ListNodePoolsResponse> listNodePools(ClientContext ctx, ListNodePoolsRequest request) {
    var emptyResponse = new ListNodePoolsResponse();
    return _client.invoke(ctx, 'ClusterManager', 'ListNodePools', request, emptyResponse);
  }
  Future<NodePool> getNodePool(ClientContext ctx, GetNodePoolRequest request) {
    var emptyResponse = new NodePool();
    return _client.invoke(ctx, 'ClusterManager', 'GetNodePool', request, emptyResponse);
  }
  Future<Operation> createNodePool(ClientContext ctx, CreateNodePoolRequest request) {
    var emptyResponse = new Operation();
    return _client.invoke(ctx, 'ClusterManager', 'CreateNodePool', request, emptyResponse);
  }
  Future<Operation> deleteNodePool(ClientContext ctx, DeleteNodePoolRequest request) {
    var emptyResponse = new Operation();
    return _client.invoke(ctx, 'ClusterManager', 'DeleteNodePool', request, emptyResponse);
  }
  Future<Operation> rollbackNodePoolUpgrade(ClientContext ctx, RollbackNodePoolUpgradeRequest request) {
    var emptyResponse = new Operation();
    return _client.invoke(ctx, 'ClusterManager', 'RollbackNodePoolUpgrade', request, emptyResponse);
  }
  Future<Operation> setNodePoolManagement(ClientContext ctx, SetNodePoolManagementRequest request) {
    var emptyResponse = new Operation();
    return _client.invoke(ctx, 'ClusterManager', 'SetNodePoolManagement', request, emptyResponse);
  }
}

