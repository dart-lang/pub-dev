///
//  Generated code. Do not modify.
///
library google.cloud.dataproc.v1_operations_pbenum;

import 'package:protobuf/protobuf.dart';

class ClusterOperationStatus_State extends ProtobufEnum {
  static const ClusterOperationStatus_State UNKNOWN = const ClusterOperationStatus_State._(0, 'UNKNOWN');
  static const ClusterOperationStatus_State PENDING = const ClusterOperationStatus_State._(1, 'PENDING');
  static const ClusterOperationStatus_State RUNNING = const ClusterOperationStatus_State._(2, 'RUNNING');
  static const ClusterOperationStatus_State DONE = const ClusterOperationStatus_State._(3, 'DONE');

  static const List<ClusterOperationStatus_State> values = const <ClusterOperationStatus_State> [
    UNKNOWN,
    PENDING,
    RUNNING,
    DONE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ClusterOperationStatus_State valueOf(int value) => _byValue[value] as ClusterOperationStatus_State;
  static void $checkItem(ClusterOperationStatus_State v) {
    if (v is !ClusterOperationStatus_State) checkItemFailed(v, 'ClusterOperationStatus_State');
  }

  const ClusterOperationStatus_State._(int v, String n) : super(v, n);
}

