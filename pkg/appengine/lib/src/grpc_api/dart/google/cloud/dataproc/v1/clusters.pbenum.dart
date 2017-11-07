///
//  Generated code. Do not modify.
///
library google.cloud.dataproc.v1_clusters_pbenum;

import 'package:protobuf/protobuf.dart';

class ClusterStatus_State extends ProtobufEnum {
  static const ClusterStatus_State UNKNOWN = const ClusterStatus_State._(0, 'UNKNOWN');
  static const ClusterStatus_State CREATING = const ClusterStatus_State._(1, 'CREATING');
  static const ClusterStatus_State RUNNING = const ClusterStatus_State._(2, 'RUNNING');
  static const ClusterStatus_State ERROR = const ClusterStatus_State._(3, 'ERROR');
  static const ClusterStatus_State DELETING = const ClusterStatus_State._(4, 'DELETING');
  static const ClusterStatus_State UPDATING = const ClusterStatus_State._(5, 'UPDATING');

  static const List<ClusterStatus_State> values = const <ClusterStatus_State> [
    UNKNOWN,
    CREATING,
    RUNNING,
    ERROR,
    DELETING,
    UPDATING,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ClusterStatus_State valueOf(int value) => _byValue[value] as ClusterStatus_State;
  static void $checkItem(ClusterStatus_State v) {
    if (v is !ClusterStatus_State) checkItemFailed(v, 'ClusterStatus_State');
  }

  const ClusterStatus_State._(int v, String n) : super(v, n);
}

