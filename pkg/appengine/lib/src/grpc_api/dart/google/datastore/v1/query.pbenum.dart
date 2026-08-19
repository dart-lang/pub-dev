//
//  Generated code. Do not modify.
//  source: google/datastore/v1/query.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Specifies what data the 'entity' field contains.
/// A `ResultType` is either implied (for example, in `LookupResponse.missing`
/// from `datastore.proto`, it is always `KEY_ONLY`) or specified by context
/// (for example, in message `QueryResultBatch`, field `entity_result_type`
/// specifies a `ResultType` for all the values in field `entity_results`).
class EntityResult_ResultType extends $pb.ProtobufEnum {
  static const EntityResult_ResultType RESULT_TYPE_UNSPECIFIED =
      EntityResult_ResultType._(
          0, _omitEnumNames ? '' : 'RESULT_TYPE_UNSPECIFIED');
  static const EntityResult_ResultType FULL =
      EntityResult_ResultType._(1, _omitEnumNames ? '' : 'FULL');
  static const EntityResult_ResultType PROJECTION =
      EntityResult_ResultType._(2, _omitEnumNames ? '' : 'PROJECTION');
  static const EntityResult_ResultType KEY_ONLY =
      EntityResult_ResultType._(3, _omitEnumNames ? '' : 'KEY_ONLY');

  static const $core.List<EntityResult_ResultType> values =
      <EntityResult_ResultType>[
    RESULT_TYPE_UNSPECIFIED,
    FULL,
    PROJECTION,
    KEY_ONLY,
  ];

  static final $core.Map<$core.int, EntityResult_ResultType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static EntityResult_ResultType? valueOf($core.int value) => _byValue[value];

  const EntityResult_ResultType._($core.int v, $core.String n) : super(v, n);
}

/// The sort direction.
class PropertyOrder_Direction extends $pb.ProtobufEnum {
  static const PropertyOrder_Direction DIRECTION_UNSPECIFIED =
      PropertyOrder_Direction._(
          0, _omitEnumNames ? '' : 'DIRECTION_UNSPECIFIED');
  static const PropertyOrder_Direction ASCENDING =
      PropertyOrder_Direction._(1, _omitEnumNames ? '' : 'ASCENDING');
  static const PropertyOrder_Direction DESCENDING =
      PropertyOrder_Direction._(2, _omitEnumNames ? '' : 'DESCENDING');

  static const $core.List<PropertyOrder_Direction> values =
      <PropertyOrder_Direction>[
    DIRECTION_UNSPECIFIED,
    ASCENDING,
    DESCENDING,
  ];

  static final $core.Map<$core.int, PropertyOrder_Direction> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static PropertyOrder_Direction? valueOf($core.int value) => _byValue[value];

  const PropertyOrder_Direction._($core.int v, $core.String n) : super(v, n);
}

/// A composite filter operator.
class CompositeFilter_Operator extends $pb.ProtobufEnum {
  static const CompositeFilter_Operator OPERATOR_UNSPECIFIED =
      CompositeFilter_Operator._(
          0, _omitEnumNames ? '' : 'OPERATOR_UNSPECIFIED');
  static const CompositeFilter_Operator AND =
      CompositeFilter_Operator._(1, _omitEnumNames ? '' : 'AND');
  static const CompositeFilter_Operator OR =
      CompositeFilter_Operator._(2, _omitEnumNames ? '' : 'OR');

  static const $core.List<CompositeFilter_Operator> values =
      <CompositeFilter_Operator>[
    OPERATOR_UNSPECIFIED,
    AND,
    OR,
  ];

  static final $core.Map<$core.int, CompositeFilter_Operator> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static CompositeFilter_Operator? valueOf($core.int value) => _byValue[value];

  const CompositeFilter_Operator._($core.int v, $core.String n) : super(v, n);
}

/// A property filter operator.
class PropertyFilter_Operator extends $pb.ProtobufEnum {
  static const PropertyFilter_Operator OPERATOR_UNSPECIFIED =
      PropertyFilter_Operator._(
          0, _omitEnumNames ? '' : 'OPERATOR_UNSPECIFIED');
  static const PropertyFilter_Operator LESS_THAN =
      PropertyFilter_Operator._(1, _omitEnumNames ? '' : 'LESS_THAN');
  static const PropertyFilter_Operator LESS_THAN_OR_EQUAL =
      PropertyFilter_Operator._(2, _omitEnumNames ? '' : 'LESS_THAN_OR_EQUAL');
  static const PropertyFilter_Operator GREATER_THAN =
      PropertyFilter_Operator._(3, _omitEnumNames ? '' : 'GREATER_THAN');
  static const PropertyFilter_Operator GREATER_THAN_OR_EQUAL =
      PropertyFilter_Operator._(
          4, _omitEnumNames ? '' : 'GREATER_THAN_OR_EQUAL');
  static const PropertyFilter_Operator EQUAL =
      PropertyFilter_Operator._(5, _omitEnumNames ? '' : 'EQUAL');
  static const PropertyFilter_Operator IN =
      PropertyFilter_Operator._(6, _omitEnumNames ? '' : 'IN');
  static const PropertyFilter_Operator NOT_EQUAL =
      PropertyFilter_Operator._(9, _omitEnumNames ? '' : 'NOT_EQUAL');
  static const PropertyFilter_Operator HAS_ANCESTOR =
      PropertyFilter_Operator._(11, _omitEnumNames ? '' : 'HAS_ANCESTOR');
  static const PropertyFilter_Operator NOT_IN =
      PropertyFilter_Operator._(13, _omitEnumNames ? '' : 'NOT_IN');

  static const $core.List<PropertyFilter_Operator> values =
      <PropertyFilter_Operator>[
    OPERATOR_UNSPECIFIED,
    LESS_THAN,
    LESS_THAN_OR_EQUAL,
    GREATER_THAN,
    GREATER_THAN_OR_EQUAL,
    EQUAL,
    IN,
    NOT_EQUAL,
    HAS_ANCESTOR,
    NOT_IN,
  ];

  static final $core.Map<$core.int, PropertyFilter_Operator> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static PropertyFilter_Operator? valueOf($core.int value) => _byValue[value];

  const PropertyFilter_Operator._($core.int v, $core.String n) : super(v, n);
}

/// The possible values for the `more_results` field.
class QueryResultBatch_MoreResultsType extends $pb.ProtobufEnum {
  static const QueryResultBatch_MoreResultsType MORE_RESULTS_TYPE_UNSPECIFIED =
      QueryResultBatch_MoreResultsType._(
          0, _omitEnumNames ? '' : 'MORE_RESULTS_TYPE_UNSPECIFIED');
  static const QueryResultBatch_MoreResultsType NOT_FINISHED =
      QueryResultBatch_MoreResultsType._(
          1, _omitEnumNames ? '' : 'NOT_FINISHED');
  static const QueryResultBatch_MoreResultsType MORE_RESULTS_AFTER_LIMIT =
      QueryResultBatch_MoreResultsType._(
          2, _omitEnumNames ? '' : 'MORE_RESULTS_AFTER_LIMIT');
  static const QueryResultBatch_MoreResultsType MORE_RESULTS_AFTER_CURSOR =
      QueryResultBatch_MoreResultsType._(
          4, _omitEnumNames ? '' : 'MORE_RESULTS_AFTER_CURSOR');
  static const QueryResultBatch_MoreResultsType NO_MORE_RESULTS =
      QueryResultBatch_MoreResultsType._(
          3, _omitEnumNames ? '' : 'NO_MORE_RESULTS');

  static const $core.List<QueryResultBatch_MoreResultsType> values =
      <QueryResultBatch_MoreResultsType>[
    MORE_RESULTS_TYPE_UNSPECIFIED,
    NOT_FINISHED,
    MORE_RESULTS_AFTER_LIMIT,
    MORE_RESULTS_AFTER_CURSOR,
    NO_MORE_RESULTS,
  ];

  static final $core.Map<$core.int, QueryResultBatch_MoreResultsType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static QueryResultBatch_MoreResultsType? valueOf($core.int value) =>
      _byValue[value];

  const QueryResultBatch_MoreResultsType._($core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
