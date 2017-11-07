///
//  Generated code. Do not modify.
///
library google.spanner.v1_query_plan_pbjson;

const PlanNode$json = const {
  '1': 'PlanNode',
  '2': const [
    const {'1': 'index', '3': 1, '4': 1, '5': 5},
    const {'1': 'kind', '3': 2, '4': 1, '5': 14, '6': '.google.spanner.v1.PlanNode.Kind'},
    const {'1': 'display_name', '3': 3, '4': 1, '5': 9},
    const {'1': 'child_links', '3': 4, '4': 3, '5': 11, '6': '.google.spanner.v1.PlanNode.ChildLink'},
    const {'1': 'short_representation', '3': 5, '4': 1, '5': 11, '6': '.google.spanner.v1.PlanNode.ShortRepresentation'},
    const {'1': 'metadata', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Struct'},
    const {'1': 'execution_stats', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Struct'},
  ],
  '3': const [PlanNode_ChildLink$json, PlanNode_ShortRepresentation$json],
  '4': const [PlanNode_Kind$json],
};

const PlanNode_ChildLink$json = const {
  '1': 'ChildLink',
  '2': const [
    const {'1': 'child_index', '3': 1, '4': 1, '5': 5},
    const {'1': 'type', '3': 2, '4': 1, '5': 9},
    const {'1': 'variable', '3': 3, '4': 1, '5': 9},
  ],
};

const PlanNode_ShortRepresentation$json = const {
  '1': 'ShortRepresentation',
  '2': const [
    const {'1': 'description', '3': 1, '4': 1, '5': 9},
    const {'1': 'subqueries', '3': 2, '4': 3, '5': 11, '6': '.google.spanner.v1.PlanNode.ShortRepresentation.SubqueriesEntry'},
  ],
  '3': const [PlanNode_ShortRepresentation_SubqueriesEntry$json],
};

const PlanNode_ShortRepresentation_SubqueriesEntry$json = const {
  '1': 'SubqueriesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 5},
  ],
  '7': const {},
};

const PlanNode_Kind$json = const {
  '1': 'Kind',
  '2': const [
    const {'1': 'KIND_UNSPECIFIED', '2': 0},
    const {'1': 'RELATIONAL', '2': 1},
    const {'1': 'SCALAR', '2': 2},
  ],
};

const QueryPlan$json = const {
  '1': 'QueryPlan',
  '2': const [
    const {'1': 'plan_nodes', '3': 1, '4': 3, '5': 11, '6': '.google.spanner.v1.PlanNode'},
  ],
};

