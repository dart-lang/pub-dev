///
//  Generated code. Do not modify.
///
library google.datastore.v1_query_pbenum;

import 'package:protobuf/protobuf.dart';

class EntityResult_ResultType extends ProtobufEnum {
  static const EntityResult_ResultType RESULT_TYPE_UNSPECIFIED = const EntityResult_ResultType._(0, 'RESULT_TYPE_UNSPECIFIED');
  static const EntityResult_ResultType FULL = const EntityResult_ResultType._(1, 'FULL');
  static const EntityResult_ResultType PROJECTION = const EntityResult_ResultType._(2, 'PROJECTION');
  static const EntityResult_ResultType KEY_ONLY = const EntityResult_ResultType._(3, 'KEY_ONLY');

  static const List<EntityResult_ResultType> values = const <EntityResult_ResultType> [
    RESULT_TYPE_UNSPECIFIED,
    FULL,
    PROJECTION,
    KEY_ONLY,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static EntityResult_ResultType valueOf(int value) => _byValue[value] as EntityResult_ResultType;
  static void $checkItem(EntityResult_ResultType v) {
    if (v is !EntityResult_ResultType) checkItemFailed(v, 'EntityResult_ResultType');
  }

  const EntityResult_ResultType._(int v, String n) : super(v, n);
}

class PropertyOrder_Direction extends ProtobufEnum {
  static const PropertyOrder_Direction DIRECTION_UNSPECIFIED = const PropertyOrder_Direction._(0, 'DIRECTION_UNSPECIFIED');
  static const PropertyOrder_Direction ASCENDING = const PropertyOrder_Direction._(1, 'ASCENDING');
  static const PropertyOrder_Direction DESCENDING = const PropertyOrder_Direction._(2, 'DESCENDING');

  static const List<PropertyOrder_Direction> values = const <PropertyOrder_Direction> [
    DIRECTION_UNSPECIFIED,
    ASCENDING,
    DESCENDING,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PropertyOrder_Direction valueOf(int value) => _byValue[value] as PropertyOrder_Direction;
  static void $checkItem(PropertyOrder_Direction v) {
    if (v is !PropertyOrder_Direction) checkItemFailed(v, 'PropertyOrder_Direction');
  }

  const PropertyOrder_Direction._(int v, String n) : super(v, n);
}

class CompositeFilter_Operator extends ProtobufEnum {
  static const CompositeFilter_Operator OPERATOR_UNSPECIFIED = const CompositeFilter_Operator._(0, 'OPERATOR_UNSPECIFIED');
  static const CompositeFilter_Operator AND = const CompositeFilter_Operator._(1, 'AND');

  static const List<CompositeFilter_Operator> values = const <CompositeFilter_Operator> [
    OPERATOR_UNSPECIFIED,
    AND,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static CompositeFilter_Operator valueOf(int value) => _byValue[value] as CompositeFilter_Operator;
  static void $checkItem(CompositeFilter_Operator v) {
    if (v is !CompositeFilter_Operator) checkItemFailed(v, 'CompositeFilter_Operator');
  }

  const CompositeFilter_Operator._(int v, String n) : super(v, n);
}

class PropertyFilter_Operator extends ProtobufEnum {
  static const PropertyFilter_Operator OPERATOR_UNSPECIFIED = const PropertyFilter_Operator._(0, 'OPERATOR_UNSPECIFIED');
  static const PropertyFilter_Operator LESS_THAN = const PropertyFilter_Operator._(1, 'LESS_THAN');
  static const PropertyFilter_Operator LESS_THAN_OR_EQUAL = const PropertyFilter_Operator._(2, 'LESS_THAN_OR_EQUAL');
  static const PropertyFilter_Operator GREATER_THAN = const PropertyFilter_Operator._(3, 'GREATER_THAN');
  static const PropertyFilter_Operator GREATER_THAN_OR_EQUAL = const PropertyFilter_Operator._(4, 'GREATER_THAN_OR_EQUAL');
  static const PropertyFilter_Operator EQUAL = const PropertyFilter_Operator._(5, 'EQUAL');
  static const PropertyFilter_Operator HAS_ANCESTOR = const PropertyFilter_Operator._(11, 'HAS_ANCESTOR');

  static const List<PropertyFilter_Operator> values = const <PropertyFilter_Operator> [
    OPERATOR_UNSPECIFIED,
    LESS_THAN,
    LESS_THAN_OR_EQUAL,
    GREATER_THAN,
    GREATER_THAN_OR_EQUAL,
    EQUAL,
    HAS_ANCESTOR,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PropertyFilter_Operator valueOf(int value) => _byValue[value] as PropertyFilter_Operator;
  static void $checkItem(PropertyFilter_Operator v) {
    if (v is !PropertyFilter_Operator) checkItemFailed(v, 'PropertyFilter_Operator');
  }

  const PropertyFilter_Operator._(int v, String n) : super(v, n);
}

class QueryResultBatch_MoreResultsType extends ProtobufEnum {
  static const QueryResultBatch_MoreResultsType MORE_RESULTS_TYPE_UNSPECIFIED = const QueryResultBatch_MoreResultsType._(0, 'MORE_RESULTS_TYPE_UNSPECIFIED');
  static const QueryResultBatch_MoreResultsType NOT_FINISHED = const QueryResultBatch_MoreResultsType._(1, 'NOT_FINISHED');
  static const QueryResultBatch_MoreResultsType MORE_RESULTS_AFTER_LIMIT = const QueryResultBatch_MoreResultsType._(2, 'MORE_RESULTS_AFTER_LIMIT');
  static const QueryResultBatch_MoreResultsType MORE_RESULTS_AFTER_CURSOR = const QueryResultBatch_MoreResultsType._(4, 'MORE_RESULTS_AFTER_CURSOR');
  static const QueryResultBatch_MoreResultsType NO_MORE_RESULTS = const QueryResultBatch_MoreResultsType._(3, 'NO_MORE_RESULTS');

  static const List<QueryResultBatch_MoreResultsType> values = const <QueryResultBatch_MoreResultsType> [
    MORE_RESULTS_TYPE_UNSPECIFIED,
    NOT_FINISHED,
    MORE_RESULTS_AFTER_LIMIT,
    MORE_RESULTS_AFTER_CURSOR,
    NO_MORE_RESULTS,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static QueryResultBatch_MoreResultsType valueOf(int value) => _byValue[value] as QueryResultBatch_MoreResultsType;
  static void $checkItem(QueryResultBatch_MoreResultsType v) {
    if (v is !QueryResultBatch_MoreResultsType) checkItemFailed(v, 'QueryResultBatch_MoreResultsType');
  }

  const QueryResultBatch_MoreResultsType._(int v, String n) : super(v, n);
}

