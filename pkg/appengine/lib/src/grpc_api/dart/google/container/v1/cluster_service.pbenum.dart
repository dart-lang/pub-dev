///
//  Generated code. Do not modify.
///
library google.container.v1_cluster_service_pbenum;

import 'package:protobuf/protobuf.dart';

class Cluster_Status extends ProtobufEnum {
  static const Cluster_Status STATUS_UNSPECIFIED = const Cluster_Status._(0, 'STATUS_UNSPECIFIED');
  static const Cluster_Status PROVISIONING = const Cluster_Status._(1, 'PROVISIONING');
  static const Cluster_Status RUNNING = const Cluster_Status._(2, 'RUNNING');
  static const Cluster_Status RECONCILING = const Cluster_Status._(3, 'RECONCILING');
  static const Cluster_Status STOPPING = const Cluster_Status._(4, 'STOPPING');
  static const Cluster_Status ERROR = const Cluster_Status._(5, 'ERROR');

  static const List<Cluster_Status> values = const <Cluster_Status> [
    STATUS_UNSPECIFIED,
    PROVISIONING,
    RUNNING,
    RECONCILING,
    STOPPING,
    ERROR,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Cluster_Status valueOf(int value) => _byValue[value] as Cluster_Status;
  static void $checkItem(Cluster_Status v) {
    if (v is !Cluster_Status) checkItemFailed(v, 'Cluster_Status');
  }

  const Cluster_Status._(int v, String n) : super(v, n);
}

class Operation_Status extends ProtobufEnum {
  static const Operation_Status STATUS_UNSPECIFIED = const Operation_Status._(0, 'STATUS_UNSPECIFIED');
  static const Operation_Status PENDING = const Operation_Status._(1, 'PENDING');
  static const Operation_Status RUNNING = const Operation_Status._(2, 'RUNNING');
  static const Operation_Status DONE = const Operation_Status._(3, 'DONE');
  static const Operation_Status ABORTING = const Operation_Status._(4, 'ABORTING');

  static const List<Operation_Status> values = const <Operation_Status> [
    STATUS_UNSPECIFIED,
    PENDING,
    RUNNING,
    DONE,
    ABORTING,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Operation_Status valueOf(int value) => _byValue[value] as Operation_Status;
  static void $checkItem(Operation_Status v) {
    if (v is !Operation_Status) checkItemFailed(v, 'Operation_Status');
  }

  const Operation_Status._(int v, String n) : super(v, n);
}

class Operation_Type extends ProtobufEnum {
  static const Operation_Type TYPE_UNSPECIFIED = const Operation_Type._(0, 'TYPE_UNSPECIFIED');
  static const Operation_Type CREATE_CLUSTER = const Operation_Type._(1, 'CREATE_CLUSTER');
  static const Operation_Type DELETE_CLUSTER = const Operation_Type._(2, 'DELETE_CLUSTER');
  static const Operation_Type UPGRADE_MASTER = const Operation_Type._(3, 'UPGRADE_MASTER');
  static const Operation_Type UPGRADE_NODES = const Operation_Type._(4, 'UPGRADE_NODES');
  static const Operation_Type REPAIR_CLUSTER = const Operation_Type._(5, 'REPAIR_CLUSTER');
  static const Operation_Type UPDATE_CLUSTER = const Operation_Type._(6, 'UPDATE_CLUSTER');
  static const Operation_Type CREATE_NODE_POOL = const Operation_Type._(7, 'CREATE_NODE_POOL');
  static const Operation_Type DELETE_NODE_POOL = const Operation_Type._(8, 'DELETE_NODE_POOL');
  static const Operation_Type SET_NODE_POOL_MANAGEMENT = const Operation_Type._(9, 'SET_NODE_POOL_MANAGEMENT');

  static const List<Operation_Type> values = const <Operation_Type> [
    TYPE_UNSPECIFIED,
    CREATE_CLUSTER,
    DELETE_CLUSTER,
    UPGRADE_MASTER,
    UPGRADE_NODES,
    REPAIR_CLUSTER,
    UPDATE_CLUSTER,
    CREATE_NODE_POOL,
    DELETE_NODE_POOL,
    SET_NODE_POOL_MANAGEMENT,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Operation_Type valueOf(int value) => _byValue[value] as Operation_Type;
  static void $checkItem(Operation_Type v) {
    if (v is !Operation_Type) checkItemFailed(v, 'Operation_Type');
  }

  const Operation_Type._(int v, String n) : super(v, n);
}

class NodePool_Status extends ProtobufEnum {
  static const NodePool_Status STATUS_UNSPECIFIED = const NodePool_Status._(0, 'STATUS_UNSPECIFIED');
  static const NodePool_Status PROVISIONING = const NodePool_Status._(1, 'PROVISIONING');
  static const NodePool_Status RUNNING = const NodePool_Status._(2, 'RUNNING');
  static const NodePool_Status RUNNING_WITH_ERROR = const NodePool_Status._(3, 'RUNNING_WITH_ERROR');
  static const NodePool_Status RECONCILING = const NodePool_Status._(4, 'RECONCILING');
  static const NodePool_Status STOPPING = const NodePool_Status._(5, 'STOPPING');
  static const NodePool_Status ERROR = const NodePool_Status._(6, 'ERROR');

  static const List<NodePool_Status> values = const <NodePool_Status> [
    STATUS_UNSPECIFIED,
    PROVISIONING,
    RUNNING,
    RUNNING_WITH_ERROR,
    RECONCILING,
    STOPPING,
    ERROR,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static NodePool_Status valueOf(int value) => _byValue[value] as NodePool_Status;
  static void $checkItem(NodePool_Status v) {
    if (v is !NodePool_Status) checkItemFailed(v, 'NodePool_Status');
  }

  const NodePool_Status._(int v, String n) : super(v, n);
}

