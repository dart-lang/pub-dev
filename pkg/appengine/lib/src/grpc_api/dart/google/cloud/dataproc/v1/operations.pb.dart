///
//  Generated code. Do not modify.
///
library google.cloud.dataproc.v1_operations;

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;

import 'operations.pbenum.dart';

export 'operations.pbenum.dart';

class ClusterOperationStatus extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ClusterOperationStatus')
    ..e/*<ClusterOperationStatus_State>*/(1, 'state', PbFieldType.OE, ClusterOperationStatus_State.UNKNOWN, ClusterOperationStatus_State.valueOf)
    ..a/*<String>*/(2, 'innerState', PbFieldType.OS)
    ..a/*<String>*/(3, 'details', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(4, 'stateStartTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ClusterOperationStatus() : super();
  ClusterOperationStatus.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ClusterOperationStatus.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ClusterOperationStatus clone() => new ClusterOperationStatus()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ClusterOperationStatus create() => new ClusterOperationStatus();
  static PbList<ClusterOperationStatus> createRepeated() => new PbList<ClusterOperationStatus>();
  static ClusterOperationStatus getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyClusterOperationStatus();
    return _defaultInstance;
  }
  static ClusterOperationStatus _defaultInstance;
  static void $checkItem(ClusterOperationStatus v) {
    if (v is !ClusterOperationStatus) checkItemFailed(v, 'ClusterOperationStatus');
  }

  ClusterOperationStatus_State get state => $_get(0, 1, null);
  void set state(ClusterOperationStatus_State v) { setField(1, v); }
  bool hasState() => $_has(0, 1);
  void clearState() => clearField(1);

  String get innerState => $_get(1, 2, '');
  void set innerState(String v) { $_setString(1, 2, v); }
  bool hasInnerState() => $_has(1, 2);
  void clearInnerState() => clearField(2);

  String get details => $_get(2, 3, '');
  void set details(String v) { $_setString(2, 3, v); }
  bool hasDetails() => $_has(2, 3);
  void clearDetails() => clearField(3);

  google$protobuf.Timestamp get stateStartTime => $_get(3, 4, null);
  void set stateStartTime(google$protobuf.Timestamp v) { setField(4, v); }
  bool hasStateStartTime() => $_has(3, 4);
  void clearStateStartTime() => clearField(4);
}

class _ReadonlyClusterOperationStatus extends ClusterOperationStatus with ReadonlyMessageMixin {}

class ClusterOperationMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ClusterOperationMetadata')
    ..a/*<String>*/(7, 'clusterName', PbFieldType.OS)
    ..a/*<String>*/(8, 'clusterUuid', PbFieldType.OS)
    ..a/*<ClusterOperationStatus>*/(9, 'status', PbFieldType.OM, ClusterOperationStatus.getDefault, ClusterOperationStatus.create)
    ..pp/*<ClusterOperationStatus>*/(10, 'statusHistory', PbFieldType.PM, ClusterOperationStatus.$checkItem, ClusterOperationStatus.create)
    ..a/*<String>*/(11, 'operationType', PbFieldType.OS)
    ..a/*<String>*/(12, 'description', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ClusterOperationMetadata() : super();
  ClusterOperationMetadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ClusterOperationMetadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ClusterOperationMetadata clone() => new ClusterOperationMetadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ClusterOperationMetadata create() => new ClusterOperationMetadata();
  static PbList<ClusterOperationMetadata> createRepeated() => new PbList<ClusterOperationMetadata>();
  static ClusterOperationMetadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyClusterOperationMetadata();
    return _defaultInstance;
  }
  static ClusterOperationMetadata _defaultInstance;
  static void $checkItem(ClusterOperationMetadata v) {
    if (v is !ClusterOperationMetadata) checkItemFailed(v, 'ClusterOperationMetadata');
  }

  String get clusterName => $_get(0, 7, '');
  void set clusterName(String v) { $_setString(0, 7, v); }
  bool hasClusterName() => $_has(0, 7);
  void clearClusterName() => clearField(7);

  String get clusterUuid => $_get(1, 8, '');
  void set clusterUuid(String v) { $_setString(1, 8, v); }
  bool hasClusterUuid() => $_has(1, 8);
  void clearClusterUuid() => clearField(8);

  ClusterOperationStatus get status => $_get(2, 9, null);
  void set status(ClusterOperationStatus v) { setField(9, v); }
  bool hasStatus() => $_has(2, 9);
  void clearStatus() => clearField(9);

  List<ClusterOperationStatus> get statusHistory => $_get(3, 10, null);

  String get operationType => $_get(4, 11, '');
  void set operationType(String v) { $_setString(4, 11, v); }
  bool hasOperationType() => $_has(4, 11);
  void clearOperationType() => clearField(11);

  String get description => $_get(5, 12, '');
  void set description(String v) { $_setString(5, 12, v); }
  bool hasDescription() => $_has(5, 12);
  void clearDescription() => clearField(12);
}

class _ReadonlyClusterOperationMetadata extends ClusterOperationMetadata with ReadonlyMessageMixin {}

