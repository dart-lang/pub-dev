///
//  Generated code. Do not modify.
///
library google.spanner.v1_query_plan_pbenum;

import 'package:protobuf/protobuf.dart';

class PlanNode_Kind extends ProtobufEnum {
  static const PlanNode_Kind KIND_UNSPECIFIED = const PlanNode_Kind._(0, 'KIND_UNSPECIFIED');
  static const PlanNode_Kind RELATIONAL = const PlanNode_Kind._(1, 'RELATIONAL');
  static const PlanNode_Kind SCALAR = const PlanNode_Kind._(2, 'SCALAR');

  static const List<PlanNode_Kind> values = const <PlanNode_Kind> [
    KIND_UNSPECIFIED,
    RELATIONAL,
    SCALAR,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PlanNode_Kind valueOf(int value) => _byValue[value] as PlanNode_Kind;
  static void $checkItem(PlanNode_Kind v) {
    if (v is !PlanNode_Kind) checkItemFailed(v, 'PlanNode_Kind');
  }

  const PlanNode_Kind._(int v, String n) : super(v, n);
}

