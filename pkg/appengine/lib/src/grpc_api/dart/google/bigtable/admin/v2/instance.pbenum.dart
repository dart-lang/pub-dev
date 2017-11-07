///
//  Generated code. Do not modify.
///
library google.bigtable.admin.v2_instance_pbenum;

import 'package:protobuf/protobuf.dart';

class Instance_State extends ProtobufEnum {
  static const Instance_State STATE_NOT_KNOWN = const Instance_State._(0, 'STATE_NOT_KNOWN');
  static const Instance_State READY = const Instance_State._(1, 'READY');
  static const Instance_State CREATING = const Instance_State._(2, 'CREATING');

  static const List<Instance_State> values = const <Instance_State> [
    STATE_NOT_KNOWN,
    READY,
    CREATING,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Instance_State valueOf(int value) => _byValue[value] as Instance_State;
  static void $checkItem(Instance_State v) {
    if (v is !Instance_State) checkItemFailed(v, 'Instance_State');
  }

  const Instance_State._(int v, String n) : super(v, n);
}

class Instance_Type extends ProtobufEnum {
  static const Instance_Type TYPE_UNSPECIFIED = const Instance_Type._(0, 'TYPE_UNSPECIFIED');
  static const Instance_Type PRODUCTION = const Instance_Type._(1, 'PRODUCTION');

  static const List<Instance_Type> values = const <Instance_Type> [
    TYPE_UNSPECIFIED,
    PRODUCTION,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Instance_Type valueOf(int value) => _byValue[value] as Instance_Type;
  static void $checkItem(Instance_Type v) {
    if (v is !Instance_Type) checkItemFailed(v, 'Instance_Type');
  }

  const Instance_Type._(int v, String n) : super(v, n);
}

class Cluster_State extends ProtobufEnum {
  static const Cluster_State STATE_NOT_KNOWN = const Cluster_State._(0, 'STATE_NOT_KNOWN');
  static const Cluster_State READY = const Cluster_State._(1, 'READY');
  static const Cluster_State CREATING = const Cluster_State._(2, 'CREATING');
  static const Cluster_State RESIZING = const Cluster_State._(3, 'RESIZING');
  static const Cluster_State DISABLED = const Cluster_State._(4, 'DISABLED');

  static const List<Cluster_State> values = const <Cluster_State> [
    STATE_NOT_KNOWN,
    READY,
    CREATING,
    RESIZING,
    DISABLED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Cluster_State valueOf(int value) => _byValue[value] as Cluster_State;
  static void $checkItem(Cluster_State v) {
    if (v is !Cluster_State) checkItemFailed(v, 'Cluster_State');
  }

  const Cluster_State._(int v, String n) : super(v, n);
}

