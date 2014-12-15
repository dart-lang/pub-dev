///
//  Generated code. Do not modify.
///
library api.services.datastore;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class PartitionId extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PartitionId')
    ..a(3, 'datasetId', GeneratedMessage.OS)
    ..a(4, 'namespace', GeneratedMessage.OS)
    ..hasRequiredFields = false
  ;

  PartitionId() : super();
  PartitionId.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PartitionId.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PartitionId clone() => new PartitionId()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get datasetId => getField(3);
  void set datasetId(String v) { setField(3, v); }
  bool hasDatasetId() => hasField(3);
  void clearDatasetId() => clearField(3);

  String get namespace => getField(4);
  void set namespace(String v) { setField(4, v); }
  bool hasNamespace() => hasField(4);
  void clearNamespace() => clearField(4);
}

class Key_PathElement extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Key_PathElement')
    ..a(1, 'kind', GeneratedMessage.QS)
    ..a(2, 'id', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(3, 'name', GeneratedMessage.OS)
  ;

  Key_PathElement() : super();
  Key_PathElement.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Key_PathElement.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Key_PathElement clone() => new Key_PathElement()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get kind => getField(1);
  void set kind(String v) { setField(1, v); }
  bool hasKind() => hasField(1);
  void clearKind() => clearField(1);

  Int64 get id => getField(2);
  void set id(Int64 v) { setField(2, v); }
  bool hasId() => hasField(2);
  void clearId() => clearField(2);

  String get name => getField(3);
  void set name(String v) { setField(3, v); }
  bool hasName() => hasField(3);
  void clearName() => clearField(3);
}

class Key extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Key')
    ..a(1, 'partitionId', GeneratedMessage.OM, () => new PartitionId(), () => new PartitionId())
    ..m(2, 'pathElement', () => new Key_PathElement(), () => new PbList<Key_PathElement>())
  ;

  Key() : super();
  Key.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Key.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Key clone() => new Key()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  PartitionId get partitionId => getField(1);
  void set partitionId(PartitionId v) { setField(1, v); }
  bool hasPartitionId() => hasField(1);
  void clearPartitionId() => clearField(1);

  List<Key_PathElement> get pathElement => getField(2);
}

class Value extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Value')
    ..a(1, 'booleanValue', GeneratedMessage.OB)
    ..a(2, 'integerValue', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(3, 'doubleValue', GeneratedMessage.OD)
    ..a(4, 'timestampMicrosecondsValue', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(5, 'keyValue', GeneratedMessage.OM, () => new Key(), () => new Key())
    ..a(16, 'blobKeyValue', GeneratedMessage.OS)
    ..a(17, 'stringValue', GeneratedMessage.OS)
    ..a(18, 'blobValue', GeneratedMessage.OY)
    ..a(6, 'entityValue', GeneratedMessage.OM, () => new Entity(), () => new Entity())
    ..m(7, 'listValue', () => new Value(), () => new PbList<Value>())
    ..a(14, 'meaning', GeneratedMessage.O3)
    ..a(15, 'indexed', GeneratedMessage.OB, () => true)
  ;

  Value() : super();
  Value.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Value.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Value clone() => new Value()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  bool get booleanValue => getField(1);
  void set booleanValue(bool v) { setField(1, v); }
  bool hasBooleanValue() => hasField(1);
  void clearBooleanValue() => clearField(1);

  Int64 get integerValue => getField(2);
  void set integerValue(Int64 v) { setField(2, v); }
  bool hasIntegerValue() => hasField(2);
  void clearIntegerValue() => clearField(2);

  double get doubleValue => getField(3);
  void set doubleValue(double v) { setField(3, v); }
  bool hasDoubleValue() => hasField(3);
  void clearDoubleValue() => clearField(3);

  Int64 get timestampMicrosecondsValue => getField(4);
  void set timestampMicrosecondsValue(Int64 v) { setField(4, v); }
  bool hasTimestampMicrosecondsValue() => hasField(4);
  void clearTimestampMicrosecondsValue() => clearField(4);

  Key get keyValue => getField(5);
  void set keyValue(Key v) { setField(5, v); }
  bool hasKeyValue() => hasField(5);
  void clearKeyValue() => clearField(5);

  String get blobKeyValue => getField(16);
  void set blobKeyValue(String v) { setField(16, v); }
  bool hasBlobKeyValue() => hasField(16);
  void clearBlobKeyValue() => clearField(16);

  String get stringValue => getField(17);
  void set stringValue(String v) { setField(17, v); }
  bool hasStringValue() => hasField(17);
  void clearStringValue() => clearField(17);

  List<int> get blobValue => getField(18);
  void set blobValue(List<int> v) { setField(18, v); }
  bool hasBlobValue() => hasField(18);
  void clearBlobValue() => clearField(18);

  Entity get entityValue => getField(6);
  void set entityValue(Entity v) { setField(6, v); }
  bool hasEntityValue() => hasField(6);
  void clearEntityValue() => clearField(6);

  List<Value> get listValue => getField(7);

  int get meaning => getField(14);
  void set meaning(int v) { setField(14, v); }
  bool hasMeaning() => hasField(14);
  void clearMeaning() => clearField(14);

  bool get indexed => getField(15);
  void set indexed(bool v) { setField(15, v); }
  bool hasIndexed() => hasField(15);
  void clearIndexed() => clearField(15);
}

class Property extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Property')
    ..a(1, 'name', GeneratedMessage.QS)
    ..a(4, 'value', GeneratedMessage.QM, () => new Value(), () => new Value())
  ;

  Property() : super();
  Property.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Property.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Property clone() => new Property()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get name => getField(1);
  void set name(String v) { setField(1, v); }
  bool hasName() => hasField(1);
  void clearName() => clearField(1);

  Value get value => getField(4);
  void set value(Value v) { setField(4, v); }
  bool hasValue() => hasField(4);
  void clearValue() => clearField(4);
}

class Entity extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Entity')
    ..a(1, 'key', GeneratedMessage.OM, () => new Key(), () => new Key())
    ..m(2, 'property', () => new Property(), () => new PbList<Property>())
  ;

  Entity() : super();
  Entity.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Entity.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Entity clone() => new Entity()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Key get key => getField(1);
  void set key(Key v) { setField(1, v); }
  bool hasKey() => hasField(1);
  void clearKey() => clearField(1);

  List<Property> get property => getField(2);
}

class EntityResult_ResultType extends ProtobufEnum {
  static const EntityResult_ResultType FULL = const EntityResult_ResultType._(1, 'FULL');
  static const EntityResult_ResultType PROJECTION = const EntityResult_ResultType._(2, 'PROJECTION');
  static const EntityResult_ResultType KEY_ONLY = const EntityResult_ResultType._(3, 'KEY_ONLY');

  static const List<EntityResult_ResultType> values = const <EntityResult_ResultType> [
    FULL,
    PROJECTION,
    KEY_ONLY,
  ];

  static final Map<int, EntityResult_ResultType> _byValue = ProtobufEnum.initByValue(values);
  static EntityResult_ResultType valueOf(int value) => _byValue[value];

  const EntityResult_ResultType._(int v, String n) : super(v, n);
}

class EntityResult extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('EntityResult')
    ..a(1, 'entity', GeneratedMessage.QM, () => new Entity(), () => new Entity())
  ;

  EntityResult() : super();
  EntityResult.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EntityResult.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EntityResult clone() => new EntityResult()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Entity get entity => getField(1);
  void set entity(Entity v) { setField(1, v); }
  bool hasEntity() => hasField(1);
  void clearEntity() => clearField(1);
}

class Query extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Query')
    ..m(2, 'projection', () => new PropertyExpression(), () => new PbList<PropertyExpression>())
    ..m(3, 'kind', () => new KindExpression(), () => new PbList<KindExpression>())
    ..a(4, 'filter', GeneratedMessage.OM, () => new Filter(), () => new Filter())
    ..m(5, 'order', () => new PropertyOrder(), () => new PbList<PropertyOrder>())
    ..m(6, 'groupBy', () => new PropertyReference(), () => new PbList<PropertyReference>())
    ..a(7, 'startCursor', GeneratedMessage.OY)
    ..a(8, 'endCursor', GeneratedMessage.OY)
    ..a(10, 'offset', GeneratedMessage.O3)
    ..a(11, 'limit', GeneratedMessage.O3)
  ;

  Query() : super();
  Query.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Query.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Query clone() => new Query()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<PropertyExpression> get projection => getField(2);

  List<KindExpression> get kind => getField(3);

  Filter get filter => getField(4);
  void set filter(Filter v) { setField(4, v); }
  bool hasFilter() => hasField(4);
  void clearFilter() => clearField(4);

  List<PropertyOrder> get order => getField(5);

  List<PropertyReference> get groupBy => getField(6);

  List<int> get startCursor => getField(7);
  void set startCursor(List<int> v) { setField(7, v); }
  bool hasStartCursor() => hasField(7);
  void clearStartCursor() => clearField(7);

  List<int> get endCursor => getField(8);
  void set endCursor(List<int> v) { setField(8, v); }
  bool hasEndCursor() => hasField(8);
  void clearEndCursor() => clearField(8);

  int get offset => getField(10);
  void set offset(int v) { setField(10, v); }
  bool hasOffset() => hasField(10);
  void clearOffset() => clearField(10);

  int get limit => getField(11);
  void set limit(int v) { setField(11, v); }
  bool hasLimit() => hasField(11);
  void clearLimit() => clearField(11);
}

class KindExpression extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('KindExpression')
    ..a(1, 'name', GeneratedMessage.QS)
  ;

  KindExpression() : super();
  KindExpression.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  KindExpression.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  KindExpression clone() => new KindExpression()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get name => getField(1);
  void set name(String v) { setField(1, v); }
  bool hasName() => hasField(1);
  void clearName() => clearField(1);
}

class PropertyReference extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PropertyReference')
    ..a(2, 'name', GeneratedMessage.QS)
  ;

  PropertyReference() : super();
  PropertyReference.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PropertyReference.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PropertyReference clone() => new PropertyReference()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get name => getField(2);
  void set name(String v) { setField(2, v); }
  bool hasName() => hasField(2);
  void clearName() => clearField(2);
}

class PropertyExpression_AggregationFunction extends ProtobufEnum {
  static const PropertyExpression_AggregationFunction FIRST = const PropertyExpression_AggregationFunction._(1, 'FIRST');

  static const List<PropertyExpression_AggregationFunction> values = const <PropertyExpression_AggregationFunction> [
    FIRST,
  ];

  static final Map<int, PropertyExpression_AggregationFunction> _byValue = ProtobufEnum.initByValue(values);
  static PropertyExpression_AggregationFunction valueOf(int value) => _byValue[value];

  const PropertyExpression_AggregationFunction._(int v, String n) : super(v, n);
}

class PropertyExpression extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PropertyExpression')
    ..a(1, 'property', GeneratedMessage.QM, () => new PropertyReference(), () => new PropertyReference())
    ..e(2, 'aggregationFunction', GeneratedMessage.OE, () => PropertyExpression_AggregationFunction.FIRST, (var v) => PropertyExpression_AggregationFunction.valueOf(v))
  ;

  PropertyExpression() : super();
  PropertyExpression.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PropertyExpression.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PropertyExpression clone() => new PropertyExpression()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  PropertyReference get property => getField(1);
  void set property(PropertyReference v) { setField(1, v); }
  bool hasProperty() => hasField(1);
  void clearProperty() => clearField(1);

  PropertyExpression_AggregationFunction get aggregationFunction => getField(2);
  void set aggregationFunction(PropertyExpression_AggregationFunction v) { setField(2, v); }
  bool hasAggregationFunction() => hasField(2);
  void clearAggregationFunction() => clearField(2);
}

class PropertyOrder_Direction extends ProtobufEnum {
  static const PropertyOrder_Direction ASCENDING = const PropertyOrder_Direction._(1, 'ASCENDING');
  static const PropertyOrder_Direction DESCENDING = const PropertyOrder_Direction._(2, 'DESCENDING');

  static const List<PropertyOrder_Direction> values = const <PropertyOrder_Direction> [
    ASCENDING,
    DESCENDING,
  ];

  static final Map<int, PropertyOrder_Direction> _byValue = ProtobufEnum.initByValue(values);
  static PropertyOrder_Direction valueOf(int value) => _byValue[value];

  const PropertyOrder_Direction._(int v, String n) : super(v, n);
}

class PropertyOrder extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PropertyOrder')
    ..a(1, 'property', GeneratedMessage.QM, () => new PropertyReference(), () => new PropertyReference())
    ..e(2, 'direction', GeneratedMessage.OE, () => PropertyOrder_Direction.ASCENDING, (var v) => PropertyOrder_Direction.valueOf(v))
  ;

  PropertyOrder() : super();
  PropertyOrder.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PropertyOrder.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PropertyOrder clone() => new PropertyOrder()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  PropertyReference get property => getField(1);
  void set property(PropertyReference v) { setField(1, v); }
  bool hasProperty() => hasField(1);
  void clearProperty() => clearField(1);

  PropertyOrder_Direction get direction => getField(2);
  void set direction(PropertyOrder_Direction v) { setField(2, v); }
  bool hasDirection() => hasField(2);
  void clearDirection() => clearField(2);
}

class Filter extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Filter')
    ..a(1, 'compositeFilter', GeneratedMessage.OM, () => new CompositeFilter(), () => new CompositeFilter())
    ..a(2, 'propertyFilter', GeneratedMessage.OM, () => new PropertyFilter(), () => new PropertyFilter())
  ;

  Filter() : super();
  Filter.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Filter.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Filter clone() => new Filter()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  CompositeFilter get compositeFilter => getField(1);
  void set compositeFilter(CompositeFilter v) { setField(1, v); }
  bool hasCompositeFilter() => hasField(1);
  void clearCompositeFilter() => clearField(1);

  PropertyFilter get propertyFilter => getField(2);
  void set propertyFilter(PropertyFilter v) { setField(2, v); }
  bool hasPropertyFilter() => hasField(2);
  void clearPropertyFilter() => clearField(2);
}

class CompositeFilter_Operator extends ProtobufEnum {
  static const CompositeFilter_Operator AND = const CompositeFilter_Operator._(1, 'AND');

  static const List<CompositeFilter_Operator> values = const <CompositeFilter_Operator> [
    AND,
  ];

  static final Map<int, CompositeFilter_Operator> _byValue = ProtobufEnum.initByValue(values);
  static CompositeFilter_Operator valueOf(int value) => _byValue[value];

  const CompositeFilter_Operator._(int v, String n) : super(v, n);
}

class CompositeFilter extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CompositeFilter')
    ..e(1, 'operator', GeneratedMessage.QE, () => CompositeFilter_Operator.AND, (var v) => CompositeFilter_Operator.valueOf(v))
    ..m(2, 'filter', () => new Filter(), () => new PbList<Filter>())
  ;

  CompositeFilter() : super();
  CompositeFilter.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CompositeFilter.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CompositeFilter clone() => new CompositeFilter()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  CompositeFilter_Operator get operator => getField(1);
  void set operator(CompositeFilter_Operator v) { setField(1, v); }
  bool hasOperator() => hasField(1);
  void clearOperator() => clearField(1);

  List<Filter> get filter => getField(2);
}

class PropertyFilter_Operator extends ProtobufEnum {
  static const PropertyFilter_Operator LESS_THAN = const PropertyFilter_Operator._(1, 'LESS_THAN');
  static const PropertyFilter_Operator LESS_THAN_OR_EQUAL = const PropertyFilter_Operator._(2, 'LESS_THAN_OR_EQUAL');
  static const PropertyFilter_Operator GREATER_THAN = const PropertyFilter_Operator._(3, 'GREATER_THAN');
  static const PropertyFilter_Operator GREATER_THAN_OR_EQUAL = const PropertyFilter_Operator._(4, 'GREATER_THAN_OR_EQUAL');
  static const PropertyFilter_Operator EQUAL = const PropertyFilter_Operator._(5, 'EQUAL');
  static const PropertyFilter_Operator HAS_ANCESTOR = const PropertyFilter_Operator._(11, 'HAS_ANCESTOR');

  static const List<PropertyFilter_Operator> values = const <PropertyFilter_Operator> [
    LESS_THAN,
    LESS_THAN_OR_EQUAL,
    GREATER_THAN,
    GREATER_THAN_OR_EQUAL,
    EQUAL,
    HAS_ANCESTOR,
  ];

  static final Map<int, PropertyFilter_Operator> _byValue = ProtobufEnum.initByValue(values);
  static PropertyFilter_Operator valueOf(int value) => _byValue[value];

  const PropertyFilter_Operator._(int v, String n) : super(v, n);
}

class PropertyFilter extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PropertyFilter')
    ..a(1, 'property', GeneratedMessage.QM, () => new PropertyReference(), () => new PropertyReference())
    ..e(2, 'operator', GeneratedMessage.QE, () => PropertyFilter_Operator.LESS_THAN, (var v) => PropertyFilter_Operator.valueOf(v))
    ..a(3, 'value', GeneratedMessage.QM, () => new Value(), () => new Value())
  ;

  PropertyFilter() : super();
  PropertyFilter.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PropertyFilter.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PropertyFilter clone() => new PropertyFilter()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  PropertyReference get property => getField(1);
  void set property(PropertyReference v) { setField(1, v); }
  bool hasProperty() => hasField(1);
  void clearProperty() => clearField(1);

  PropertyFilter_Operator get operator => getField(2);
  void set operator(PropertyFilter_Operator v) { setField(2, v); }
  bool hasOperator() => hasField(2);
  void clearOperator() => clearField(2);

  Value get value => getField(3);
  void set value(Value v) { setField(3, v); }
  bool hasValue() => hasField(3);
  void clearValue() => clearField(3);
}

class GqlQuery extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GqlQuery')
    ..a(1, 'queryString', GeneratedMessage.QS)
    ..a(2, 'allowLiteral', GeneratedMessage.OB)
    ..m(3, 'nameArg', () => new GqlQueryArg(), () => new PbList<GqlQueryArg>())
    ..m(4, 'numberArg', () => new GqlQueryArg(), () => new PbList<GqlQueryArg>())
  ;

  GqlQuery() : super();
  GqlQuery.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GqlQuery.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GqlQuery clone() => new GqlQuery()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get queryString => getField(1);
  void set queryString(String v) { setField(1, v); }
  bool hasQueryString() => hasField(1);
  void clearQueryString() => clearField(1);

  bool get allowLiteral => getField(2);
  void set allowLiteral(bool v) { setField(2, v); }
  bool hasAllowLiteral() => hasField(2);
  void clearAllowLiteral() => clearField(2);

  List<GqlQueryArg> get nameArg => getField(3);

  List<GqlQueryArg> get numberArg => getField(4);
}

class GqlQueryArg extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GqlQueryArg')
    ..a(1, 'name', GeneratedMessage.OS)
    ..a(2, 'value', GeneratedMessage.OM, () => new Value(), () => new Value())
    ..a(3, 'cursor', GeneratedMessage.OY)
  ;

  GqlQueryArg() : super();
  GqlQueryArg.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GqlQueryArg.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GqlQueryArg clone() => new GqlQueryArg()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get name => getField(1);
  void set name(String v) { setField(1, v); }
  bool hasName() => hasField(1);
  void clearName() => clearField(1);

  Value get value => getField(2);
  void set value(Value v) { setField(2, v); }
  bool hasValue() => hasField(2);
  void clearValue() => clearField(2);

  List<int> get cursor => getField(3);
  void set cursor(List<int> v) { setField(3, v); }
  bool hasCursor() => hasField(3);
  void clearCursor() => clearField(3);
}

class QueryResultBatch_MoreResultsType extends ProtobufEnum {
  static const QueryResultBatch_MoreResultsType NOT_FINISHED = const QueryResultBatch_MoreResultsType._(1, 'NOT_FINISHED');
  static const QueryResultBatch_MoreResultsType MORE_RESULTS_AFTER_LIMIT = const QueryResultBatch_MoreResultsType._(2, 'MORE_RESULTS_AFTER_LIMIT');
  static const QueryResultBatch_MoreResultsType NO_MORE_RESULTS = const QueryResultBatch_MoreResultsType._(3, 'NO_MORE_RESULTS');

  static const List<QueryResultBatch_MoreResultsType> values = const <QueryResultBatch_MoreResultsType> [
    NOT_FINISHED,
    MORE_RESULTS_AFTER_LIMIT,
    NO_MORE_RESULTS,
  ];

  static final Map<int, QueryResultBatch_MoreResultsType> _byValue = ProtobufEnum.initByValue(values);
  static QueryResultBatch_MoreResultsType valueOf(int value) => _byValue[value];

  const QueryResultBatch_MoreResultsType._(int v, String n) : super(v, n);
}

class QueryResultBatch extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('QueryResultBatch')
    ..e(1, 'entityResultType', GeneratedMessage.QE, () => EntityResult_ResultType.FULL, (var v) => EntityResult_ResultType.valueOf(v))
    ..m(2, 'entityResult', () => new EntityResult(), () => new PbList<EntityResult>())
    ..a(4, 'endCursor', GeneratedMessage.OY)
    ..e(5, 'moreResults', GeneratedMessage.QE, () => QueryResultBatch_MoreResultsType.NOT_FINISHED, (var v) => QueryResultBatch_MoreResultsType.valueOf(v))
    ..a(6, 'skippedResults', GeneratedMessage.O3)
  ;

  QueryResultBatch() : super();
  QueryResultBatch.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  QueryResultBatch.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  QueryResultBatch clone() => new QueryResultBatch()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  EntityResult_ResultType get entityResultType => getField(1);
  void set entityResultType(EntityResult_ResultType v) { setField(1, v); }
  bool hasEntityResultType() => hasField(1);
  void clearEntityResultType() => clearField(1);

  List<EntityResult> get entityResult => getField(2);

  List<int> get endCursor => getField(4);
  void set endCursor(List<int> v) { setField(4, v); }
  bool hasEndCursor() => hasField(4);
  void clearEndCursor() => clearField(4);

  QueryResultBatch_MoreResultsType get moreResults => getField(5);
  void set moreResults(QueryResultBatch_MoreResultsType v) { setField(5, v); }
  bool hasMoreResults() => hasField(5);
  void clearMoreResults() => clearField(5);

  int get skippedResults => getField(6);
  void set skippedResults(int v) { setField(6, v); }
  bool hasSkippedResults() => hasField(6);
  void clearSkippedResults() => clearField(6);
}

class Mutation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Mutation')
    ..m(1, 'upsert', () => new Entity(), () => new PbList<Entity>())
    ..m(2, 'update', () => new Entity(), () => new PbList<Entity>())
    ..m(3, 'insert', () => new Entity(), () => new PbList<Entity>())
    ..m(4, 'insertAutoId', () => new Entity(), () => new PbList<Entity>())
    ..m(5, 'delete', () => new Key(), () => new PbList<Key>())
    ..a(6, 'force', GeneratedMessage.OB)
  ;

  Mutation() : super();
  Mutation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Mutation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Mutation clone() => new Mutation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<Entity> get upsert => getField(1);

  List<Entity> get update => getField(2);

  List<Entity> get insert => getField(3);

  List<Entity> get insertAutoId => getField(4);

  List<Key> get delete => getField(5);

  bool get force => getField(6);
  void set force(bool v) { setField(6, v); }
  bool hasForce() => hasField(6);
  void clearForce() => clearField(6);
}

class MutationResult extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MutationResult')
    ..a(1, 'indexUpdates', GeneratedMessage.Q3)
    ..m(2, 'insertAutoIdKey', () => new Key(), () => new PbList<Key>())
  ;

  MutationResult() : super();
  MutationResult.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MutationResult.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MutationResult clone() => new MutationResult()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  int get indexUpdates => getField(1);
  void set indexUpdates(int v) { setField(1, v); }
  bool hasIndexUpdates() => hasField(1);
  void clearIndexUpdates() => clearField(1);

  List<Key> get insertAutoIdKey => getField(2);
}

class ReadOptions_ReadConsistency extends ProtobufEnum {
  static const ReadOptions_ReadConsistency DEFAULT = const ReadOptions_ReadConsistency._(0, 'DEFAULT');
  static const ReadOptions_ReadConsistency STRONG = const ReadOptions_ReadConsistency._(1, 'STRONG');
  static const ReadOptions_ReadConsistency EVENTUAL = const ReadOptions_ReadConsistency._(2, 'EVENTUAL');

  static const List<ReadOptions_ReadConsistency> values = const <ReadOptions_ReadConsistency> [
    DEFAULT,
    STRONG,
    EVENTUAL,
  ];

  static final Map<int, ReadOptions_ReadConsistency> _byValue = ProtobufEnum.initByValue(values);
  static ReadOptions_ReadConsistency valueOf(int value) => _byValue[value];

  const ReadOptions_ReadConsistency._(int v, String n) : super(v, n);
}

class ReadOptions extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadOptions')
    ..e(1, 'readConsistency', GeneratedMessage.OE, () => ReadOptions_ReadConsistency.DEFAULT, (var v) => ReadOptions_ReadConsistency.valueOf(v))
    ..a(2, 'transaction', GeneratedMessage.OY)
    ..hasRequiredFields = false
  ;

  ReadOptions() : super();
  ReadOptions.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadOptions.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadOptions clone() => new ReadOptions()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  ReadOptions_ReadConsistency get readConsistency => getField(1);
  void set readConsistency(ReadOptions_ReadConsistency v) { setField(1, v); }
  bool hasReadConsistency() => hasField(1);
  void clearReadConsistency() => clearField(1);

  List<int> get transaction => getField(2);
  void set transaction(List<int> v) { setField(2, v); }
  bool hasTransaction() => hasField(2);
  void clearTransaction() => clearField(2);
}

class LookupRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LookupRequest')
    ..a(1, 'readOptions', GeneratedMessage.OM, () => new ReadOptions(), () => new ReadOptions())
    ..m(3, 'key', () => new Key(), () => new PbList<Key>())
  ;

  LookupRequest() : super();
  LookupRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LookupRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LookupRequest clone() => new LookupRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  ReadOptions get readOptions => getField(1);
  void set readOptions(ReadOptions v) { setField(1, v); }
  bool hasReadOptions() => hasField(1);
  void clearReadOptions() => clearField(1);

  List<Key> get key => getField(3);
}

class LookupResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LookupResponse')
    ..m(1, 'found', () => new EntityResult(), () => new PbList<EntityResult>())
    ..m(2, 'missing', () => new EntityResult(), () => new PbList<EntityResult>())
    ..m(3, 'deferred', () => new Key(), () => new PbList<Key>())
  ;

  LookupResponse() : super();
  LookupResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LookupResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LookupResponse clone() => new LookupResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<EntityResult> get found => getField(1);

  List<EntityResult> get missing => getField(2);

  List<Key> get deferred => getField(3);
}

class RunQueryRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RunQueryRequest')
    ..a(1, 'readOptions', GeneratedMessage.OM, () => new ReadOptions(), () => new ReadOptions())
    ..a(2, 'partitionId', GeneratedMessage.OM, () => new PartitionId(), () => new PartitionId())
    ..a(3, 'query', GeneratedMessage.OM, () => new Query(), () => new Query())
    ..a(7, 'gqlQuery', GeneratedMessage.OM, () => new GqlQuery(), () => new GqlQuery())
  ;

  RunQueryRequest() : super();
  RunQueryRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RunQueryRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RunQueryRequest clone() => new RunQueryRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  ReadOptions get readOptions => getField(1);
  void set readOptions(ReadOptions v) { setField(1, v); }
  bool hasReadOptions() => hasField(1);
  void clearReadOptions() => clearField(1);

  PartitionId get partitionId => getField(2);
  void set partitionId(PartitionId v) { setField(2, v); }
  bool hasPartitionId() => hasField(2);
  void clearPartitionId() => clearField(2);

  Query get query => getField(3);
  void set query(Query v) { setField(3, v); }
  bool hasQuery() => hasField(3);
  void clearQuery() => clearField(3);

  GqlQuery get gqlQuery => getField(7);
  void set gqlQuery(GqlQuery v) { setField(7, v); }
  bool hasGqlQuery() => hasField(7);
  void clearGqlQuery() => clearField(7);
}

class RunQueryResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RunQueryResponse')
    ..a(1, 'batch', GeneratedMessage.OM, () => new QueryResultBatch(), () => new QueryResultBatch())
  ;

  RunQueryResponse() : super();
  RunQueryResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RunQueryResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RunQueryResponse clone() => new RunQueryResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  QueryResultBatch get batch => getField(1);
  void set batch(QueryResultBatch v) { setField(1, v); }
  bool hasBatch() => hasField(1);
  void clearBatch() => clearField(1);
}

class BeginTransactionRequest_IsolationLevel extends ProtobufEnum {
  static const BeginTransactionRequest_IsolationLevel SNAPSHOT = const BeginTransactionRequest_IsolationLevel._(0, 'SNAPSHOT');
  static const BeginTransactionRequest_IsolationLevel SERIALIZABLE = const BeginTransactionRequest_IsolationLevel._(1, 'SERIALIZABLE');

  static const List<BeginTransactionRequest_IsolationLevel> values = const <BeginTransactionRequest_IsolationLevel> [
    SNAPSHOT,
    SERIALIZABLE,
  ];

  static final Map<int, BeginTransactionRequest_IsolationLevel> _byValue = ProtobufEnum.initByValue(values);
  static BeginTransactionRequest_IsolationLevel valueOf(int value) => _byValue[value];

  const BeginTransactionRequest_IsolationLevel._(int v, String n) : super(v, n);
}

class BeginTransactionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BeginTransactionRequest')
    ..e(1, 'isolationLevel', GeneratedMessage.OE, () => BeginTransactionRequest_IsolationLevel.SNAPSHOT, (var v) => BeginTransactionRequest_IsolationLevel.valueOf(v))
    ..hasRequiredFields = false
  ;

  BeginTransactionRequest() : super();
  BeginTransactionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BeginTransactionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BeginTransactionRequest clone() => new BeginTransactionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  BeginTransactionRequest_IsolationLevel get isolationLevel => getField(1);
  void set isolationLevel(BeginTransactionRequest_IsolationLevel v) { setField(1, v); }
  bool hasIsolationLevel() => hasField(1);
  void clearIsolationLevel() => clearField(1);
}

class BeginTransactionResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BeginTransactionResponse')
    ..a(1, 'transaction', GeneratedMessage.OY)
    ..hasRequiredFields = false
  ;

  BeginTransactionResponse() : super();
  BeginTransactionResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BeginTransactionResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BeginTransactionResponse clone() => new BeginTransactionResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<int> get transaction => getField(1);
  void set transaction(List<int> v) { setField(1, v); }
  bool hasTransaction() => hasField(1);
  void clearTransaction() => clearField(1);
}

class RollbackRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RollbackRequest')
    ..a(1, 'transaction', GeneratedMessage.QY)
  ;

  RollbackRequest() : super();
  RollbackRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RollbackRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RollbackRequest clone() => new RollbackRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<int> get transaction => getField(1);
  void set transaction(List<int> v) { setField(1, v); }
  bool hasTransaction() => hasField(1);
  void clearTransaction() => clearField(1);
}

class RollbackResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RollbackResponse')
    ..hasRequiredFields = false
  ;

  RollbackResponse() : super();
  RollbackResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RollbackResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RollbackResponse clone() => new RollbackResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class CommitRequest_Mode extends ProtobufEnum {
  static const CommitRequest_Mode TRANSACTIONAL = const CommitRequest_Mode._(1, 'TRANSACTIONAL');
  static const CommitRequest_Mode NON_TRANSACTIONAL = const CommitRequest_Mode._(2, 'NON_TRANSACTIONAL');

  static const List<CommitRequest_Mode> values = const <CommitRequest_Mode> [
    TRANSACTIONAL,
    NON_TRANSACTIONAL,
  ];

  static final Map<int, CommitRequest_Mode> _byValue = ProtobufEnum.initByValue(values);
  static CommitRequest_Mode valueOf(int value) => _byValue[value];

  const CommitRequest_Mode._(int v, String n) : super(v, n);
}

class CommitRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CommitRequest')
    ..a(1, 'transaction', GeneratedMessage.OY)
    ..a(2, 'mutation', GeneratedMessage.OM, () => new Mutation(), () => new Mutation())
    ..e(5, 'mode', GeneratedMessage.OE, () => CommitRequest_Mode.TRANSACTIONAL, (var v) => CommitRequest_Mode.valueOf(v))
  ;

  CommitRequest() : super();
  CommitRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CommitRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CommitRequest clone() => new CommitRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<int> get transaction => getField(1);
  void set transaction(List<int> v) { setField(1, v); }
  bool hasTransaction() => hasField(1);
  void clearTransaction() => clearField(1);

  Mutation get mutation => getField(2);
  void set mutation(Mutation v) { setField(2, v); }
  bool hasMutation() => hasField(2);
  void clearMutation() => clearField(2);

  CommitRequest_Mode get mode => getField(5);
  void set mode(CommitRequest_Mode v) { setField(5, v); }
  bool hasMode() => hasField(5);
  void clearMode() => clearField(5);
}

class CommitResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CommitResponse')
    ..a(1, 'mutationResult', GeneratedMessage.OM, () => new MutationResult(), () => new MutationResult())
  ;

  CommitResponse() : super();
  CommitResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CommitResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CommitResponse clone() => new CommitResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  MutationResult get mutationResult => getField(1);
  void set mutationResult(MutationResult v) { setField(1, v); }
  bool hasMutationResult() => hasField(1);
  void clearMutationResult() => clearField(1);
}

class AllocateIdsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AllocateIdsRequest')
    ..m(1, 'key', () => new Key(), () => new PbList<Key>())
  ;

  AllocateIdsRequest() : super();
  AllocateIdsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AllocateIdsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AllocateIdsRequest clone() => new AllocateIdsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<Key> get key => getField(1);
}

class AllocateIdsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AllocateIdsResponse')
    ..m(1, 'key', () => new Key(), () => new PbList<Key>())
  ;

  AllocateIdsResponse() : super();
  AllocateIdsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AllocateIdsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AllocateIdsResponse clone() => new AllocateIdsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<Key> get key => getField(1);
}

