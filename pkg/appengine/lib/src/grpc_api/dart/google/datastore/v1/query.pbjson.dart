///
//  Generated code. Do not modify.
///
library google.datastore.v1_query_pbjson;

const EntityResult$json = const {
  '1': 'EntityResult',
  '2': const [
    const {'1': 'entity', '3': 1, '4': 1, '5': 11, '6': '.google.datastore.v1.Entity'},
    const {'1': 'version', '3': 4, '4': 1, '5': 3},
    const {'1': 'cursor', '3': 3, '4': 1, '5': 12},
  ],
  '4': const [EntityResult_ResultType$json],
};

const EntityResult_ResultType$json = const {
  '1': 'ResultType',
  '2': const [
    const {'1': 'RESULT_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'FULL', '2': 1},
    const {'1': 'PROJECTION', '2': 2},
    const {'1': 'KEY_ONLY', '2': 3},
  ],
};

const Query$json = const {
  '1': 'Query',
  '2': const [
    const {'1': 'projection', '3': 2, '4': 3, '5': 11, '6': '.google.datastore.v1.Projection'},
    const {'1': 'kind', '3': 3, '4': 3, '5': 11, '6': '.google.datastore.v1.KindExpression'},
    const {'1': 'filter', '3': 4, '4': 1, '5': 11, '6': '.google.datastore.v1.Filter'},
    const {'1': 'order', '3': 5, '4': 3, '5': 11, '6': '.google.datastore.v1.PropertyOrder'},
    const {'1': 'distinct_on', '3': 6, '4': 3, '5': 11, '6': '.google.datastore.v1.PropertyReference'},
    const {'1': 'start_cursor', '3': 7, '4': 1, '5': 12},
    const {'1': 'end_cursor', '3': 8, '4': 1, '5': 12},
    const {'1': 'offset', '3': 10, '4': 1, '5': 5},
    const {'1': 'limit', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Int32Value'},
  ],
};

const KindExpression$json = const {
  '1': 'KindExpression',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const PropertyReference$json = const {
  '1': 'PropertyReference',
  '2': const [
    const {'1': 'name', '3': 2, '4': 1, '5': 9},
  ],
};

const Projection$json = const {
  '1': 'Projection',
  '2': const [
    const {'1': 'property', '3': 1, '4': 1, '5': 11, '6': '.google.datastore.v1.PropertyReference'},
  ],
};

const PropertyOrder$json = const {
  '1': 'PropertyOrder',
  '2': const [
    const {'1': 'property', '3': 1, '4': 1, '5': 11, '6': '.google.datastore.v1.PropertyReference'},
    const {'1': 'direction', '3': 2, '4': 1, '5': 14, '6': '.google.datastore.v1.PropertyOrder.Direction'},
  ],
  '4': const [PropertyOrder_Direction$json],
};

const PropertyOrder_Direction$json = const {
  '1': 'Direction',
  '2': const [
    const {'1': 'DIRECTION_UNSPECIFIED', '2': 0},
    const {'1': 'ASCENDING', '2': 1},
    const {'1': 'DESCENDING', '2': 2},
  ],
};

const Filter$json = const {
  '1': 'Filter',
  '2': const [
    const {'1': 'composite_filter', '3': 1, '4': 1, '5': 11, '6': '.google.datastore.v1.CompositeFilter'},
    const {'1': 'property_filter', '3': 2, '4': 1, '5': 11, '6': '.google.datastore.v1.PropertyFilter'},
  ],
};

const CompositeFilter$json = const {
  '1': 'CompositeFilter',
  '2': const [
    const {'1': 'op', '3': 1, '4': 1, '5': 14, '6': '.google.datastore.v1.CompositeFilter.Operator'},
    const {'1': 'filters', '3': 2, '4': 3, '5': 11, '6': '.google.datastore.v1.Filter'},
  ],
  '4': const [CompositeFilter_Operator$json],
};

const CompositeFilter_Operator$json = const {
  '1': 'Operator',
  '2': const [
    const {'1': 'OPERATOR_UNSPECIFIED', '2': 0},
    const {'1': 'AND', '2': 1},
  ],
};

const PropertyFilter$json = const {
  '1': 'PropertyFilter',
  '2': const [
    const {'1': 'property', '3': 1, '4': 1, '5': 11, '6': '.google.datastore.v1.PropertyReference'},
    const {'1': 'op', '3': 2, '4': 1, '5': 14, '6': '.google.datastore.v1.PropertyFilter.Operator'},
    const {'1': 'value', '3': 3, '4': 1, '5': 11, '6': '.google.datastore.v1.Value'},
  ],
  '4': const [PropertyFilter_Operator$json],
};

const PropertyFilter_Operator$json = const {
  '1': 'Operator',
  '2': const [
    const {'1': 'OPERATOR_UNSPECIFIED', '2': 0},
    const {'1': 'LESS_THAN', '2': 1},
    const {'1': 'LESS_THAN_OR_EQUAL', '2': 2},
    const {'1': 'GREATER_THAN', '2': 3},
    const {'1': 'GREATER_THAN_OR_EQUAL', '2': 4},
    const {'1': 'EQUAL', '2': 5},
    const {'1': 'HAS_ANCESTOR', '2': 11},
  ],
};

const GqlQuery$json = const {
  '1': 'GqlQuery',
  '2': const [
    const {'1': 'query_string', '3': 1, '4': 1, '5': 9},
    const {'1': 'allow_literals', '3': 2, '4': 1, '5': 8},
    const {'1': 'named_bindings', '3': 5, '4': 3, '5': 11, '6': '.google.datastore.v1.GqlQuery.NamedBindingsEntry'},
    const {'1': 'positional_bindings', '3': 4, '4': 3, '5': 11, '6': '.google.datastore.v1.GqlQueryParameter'},
  ],
  '3': const [GqlQuery_NamedBindingsEntry$json],
};

const GqlQuery_NamedBindingsEntry$json = const {
  '1': 'NamedBindingsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.datastore.v1.GqlQueryParameter'},
  ],
  '7': const {},
};

const GqlQueryParameter$json = const {
  '1': 'GqlQueryParameter',
  '2': const [
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.datastore.v1.Value'},
    const {'1': 'cursor', '3': 3, '4': 1, '5': 12},
  ],
};

const QueryResultBatch$json = const {
  '1': 'QueryResultBatch',
  '2': const [
    const {'1': 'skipped_results', '3': 6, '4': 1, '5': 5},
    const {'1': 'skipped_cursor', '3': 3, '4': 1, '5': 12},
    const {'1': 'entity_result_type', '3': 1, '4': 1, '5': 14, '6': '.google.datastore.v1.EntityResult.ResultType'},
    const {'1': 'entity_results', '3': 2, '4': 3, '5': 11, '6': '.google.datastore.v1.EntityResult'},
    const {'1': 'end_cursor', '3': 4, '4': 1, '5': 12},
    const {'1': 'more_results', '3': 5, '4': 1, '5': 14, '6': '.google.datastore.v1.QueryResultBatch.MoreResultsType'},
    const {'1': 'snapshot_version', '3': 7, '4': 1, '5': 3},
  ],
  '4': const [QueryResultBatch_MoreResultsType$json],
};

const QueryResultBatch_MoreResultsType$json = const {
  '1': 'MoreResultsType',
  '2': const [
    const {'1': 'MORE_RESULTS_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'NOT_FINISHED', '2': 1},
    const {'1': 'MORE_RESULTS_AFTER_LIMIT', '2': 2},
    const {'1': 'MORE_RESULTS_AFTER_CURSOR', '2': 4},
    const {'1': 'NO_MORE_RESULTS', '2': 3},
  ],
};

