///
//  Generated code. Do not modify.
///
library appengine.datastore.v3;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class Action extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Action')
    ..hasRequiredFields = false
  ;

  Action() : super();
  Action.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Action.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Action clone() => new Action()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class PropertyValue_PointValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PropertyValue_PointValue')
    ..a(6, 'x', GeneratedMessage.QD)
    ..a(7, 'y', GeneratedMessage.QD)
  ;

  PropertyValue_PointValue() : super();
  PropertyValue_PointValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PropertyValue_PointValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PropertyValue_PointValue clone() => new PropertyValue_PointValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  double get x => getField(6);
  void set x(double v) { setField(6, v); }
  bool hasX() => hasField(6);
  void clearX() => clearField(6);

  double get y => getField(7);
  void set y(double v) { setField(7, v); }
  bool hasY() => hasField(7);
  void clearY() => clearField(7);
}

class PropertyValue_UserValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PropertyValue_UserValue')
    ..a(9, 'email', GeneratedMessage.QS)
    ..a(10, 'authDomain', GeneratedMessage.QS)
    ..a(11, 'nickname', GeneratedMessage.OS)
    ..a(21, 'federatedIdentity', GeneratedMessage.OS)
    ..a(22, 'federatedProvider', GeneratedMessage.OS)
  ;

  PropertyValue_UserValue() : super();
  PropertyValue_UserValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PropertyValue_UserValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PropertyValue_UserValue clone() => new PropertyValue_UserValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get email => getField(9);
  void set email(String v) { setField(9, v); }
  bool hasEmail() => hasField(9);
  void clearEmail() => clearField(9);

  String get authDomain => getField(10);
  void set authDomain(String v) { setField(10, v); }
  bool hasAuthDomain() => hasField(10);
  void clearAuthDomain() => clearField(10);

  String get nickname => getField(11);
  void set nickname(String v) { setField(11, v); }
  bool hasNickname() => hasField(11);
  void clearNickname() => clearField(11);

  String get federatedIdentity => getField(21);
  void set federatedIdentity(String v) { setField(21, v); }
  bool hasFederatedIdentity() => hasField(21);
  void clearFederatedIdentity() => clearField(21);

  String get federatedProvider => getField(22);
  void set federatedProvider(String v) { setField(22, v); }
  bool hasFederatedProvider() => hasField(22);
  void clearFederatedProvider() => clearField(22);
}

class PropertyValue_ReferenceValue_PathElement extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PropertyValue_ReferenceValue_PathElement')
    ..a(15, 'type', GeneratedMessage.QS)
    ..a(16, 'id', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(17, 'name', GeneratedMessage.OS)
  ;

  PropertyValue_ReferenceValue_PathElement() : super();
  PropertyValue_ReferenceValue_PathElement.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PropertyValue_ReferenceValue_PathElement.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PropertyValue_ReferenceValue_PathElement clone() => new PropertyValue_ReferenceValue_PathElement()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get type => getField(15);
  void set type(String v) { setField(15, v); }
  bool hasType() => hasField(15);
  void clearType() => clearField(15);

  Int64 get id => getField(16);
  void set id(Int64 v) { setField(16, v); }
  bool hasId() => hasField(16);
  void clearId() => clearField(16);

  String get name => getField(17);
  void set name(String v) { setField(17, v); }
  bool hasName() => hasField(17);
  void clearName() => clearField(17);
}

class PropertyValue_ReferenceValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PropertyValue_ReferenceValue')
    ..a(13, 'app', GeneratedMessage.QS)
    ..a(20, 'nameSpace', GeneratedMessage.OS)
    ..a(14, 'pathElement', GeneratedMessage.PG, () => new PbList(), () => new PropertyValue_ReferenceValue_PathElement())
  ;

  PropertyValue_ReferenceValue() : super();
  PropertyValue_ReferenceValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PropertyValue_ReferenceValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PropertyValue_ReferenceValue clone() => new PropertyValue_ReferenceValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get app => getField(13);
  void set app(String v) { setField(13, v); }
  bool hasApp() => hasField(13);
  void clearApp() => clearField(13);

  String get nameSpace => getField(20);
  void set nameSpace(String v) { setField(20, v); }
  bool hasNameSpace() => hasField(20);
  void clearNameSpace() => clearField(20);

  List<PropertyValue_ReferenceValue_PathElement> get pathElement => getField(14);
}

class PropertyValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PropertyValue')
    ..a(1, 'int64Value', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(2, 'booleanValue', GeneratedMessage.OB)
    ..a(3, 'bytesValue', GeneratedMessage.OY)
    ..a(4, 'doubleValue', GeneratedMessage.OD)
    ..a(5, 'pointValue', GeneratedMessage.OG, () => new PropertyValue_PointValue(), () => new PropertyValue_PointValue())
    ..a(8, 'userValue', GeneratedMessage.OG, () => new PropertyValue_UserValue(), () => new PropertyValue_UserValue())
    ..a(12, 'referenceValue', GeneratedMessage.OG, () => new PropertyValue_ReferenceValue(), () => new PropertyValue_ReferenceValue())
    ..hasRequiredFields = false
  ;

  PropertyValue() : super();
  PropertyValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PropertyValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PropertyValue clone() => new PropertyValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Int64 get int64Value => getField(1);
  void set int64Value(Int64 v) { setField(1, v); }
  bool hasInt64Value() => hasField(1);
  void clearInt64Value() => clearField(1);

  bool get booleanValue => getField(2);
  void set booleanValue(bool v) { setField(2, v); }
  bool hasBooleanValue() => hasField(2);
  void clearBooleanValue() => clearField(2);

  List<int> get bytesValue => getField(3);
  void set bytesValue(List<int> v) { setField(3, v); }
  bool hasBytesValue() => hasField(3);
  void clearBytesValue() => clearField(3);

  double get doubleValue => getField(4);
  void set doubleValue(double v) { setField(4, v); }
  bool hasDoubleValue() => hasField(4);
  void clearDoubleValue() => clearField(4);

  PropertyValue_PointValue get pointValue => getField(5);
  void set pointValue(PropertyValue_PointValue v) { setField(5, v); }
  bool hasPointValue() => hasField(5);
  void clearPointValue() => clearField(5);

  PropertyValue_UserValue get userValue => getField(8);
  void set userValue(PropertyValue_UserValue v) { setField(8, v); }
  bool hasUserValue() => hasField(8);
  void clearUserValue() => clearField(8);

  PropertyValue_ReferenceValue get referenceValue => getField(12);
  void set referenceValue(PropertyValue_ReferenceValue v) { setField(12, v); }
  bool hasReferenceValue() => hasField(12);
  void clearReferenceValue() => clearField(12);
}

class Property_Meaning extends ProtobufEnum {
  static const Property_Meaning NO_MEANING = const Property_Meaning._(0, 'NO_MEANING');
  static const Property_Meaning BLOB = const Property_Meaning._(14, 'BLOB');
  static const Property_Meaning TEXT = const Property_Meaning._(15, 'TEXT');
  static const Property_Meaning BYTESTRING = const Property_Meaning._(16, 'BYTESTRING');
  static const Property_Meaning ATOM_CATEGORY = const Property_Meaning._(1, 'ATOM_CATEGORY');
  static const Property_Meaning ATOM_LINK = const Property_Meaning._(2, 'ATOM_LINK');
  static const Property_Meaning ATOM_TITLE = const Property_Meaning._(3, 'ATOM_TITLE');
  static const Property_Meaning ATOM_CONTENT = const Property_Meaning._(4, 'ATOM_CONTENT');
  static const Property_Meaning ATOM_SUMMARY = const Property_Meaning._(5, 'ATOM_SUMMARY');
  static const Property_Meaning ATOM_AUTHOR = const Property_Meaning._(6, 'ATOM_AUTHOR');
  static const Property_Meaning GD_WHEN = const Property_Meaning._(7, 'GD_WHEN');
  static const Property_Meaning GD_EMAIL = const Property_Meaning._(8, 'GD_EMAIL');
  static const Property_Meaning GEORSS_POINT = const Property_Meaning._(9, 'GEORSS_POINT');
  static const Property_Meaning GD_IM = const Property_Meaning._(10, 'GD_IM');
  static const Property_Meaning GD_PHONENUMBER = const Property_Meaning._(11, 'GD_PHONENUMBER');
  static const Property_Meaning GD_POSTALADDRESS = const Property_Meaning._(12, 'GD_POSTALADDRESS');
  static const Property_Meaning GD_RATING = const Property_Meaning._(13, 'GD_RATING');
  static const Property_Meaning BLOBKEY = const Property_Meaning._(17, 'BLOBKEY');
  static const Property_Meaning ENTITY_PROTO = const Property_Meaning._(19, 'ENTITY_PROTO');
  static const Property_Meaning INDEX_VALUE = const Property_Meaning._(18, 'INDEX_VALUE');

  static const List<Property_Meaning> values = const <Property_Meaning> [
    NO_MEANING,
    BLOB,
    TEXT,
    BYTESTRING,
    ATOM_CATEGORY,
    ATOM_LINK,
    ATOM_TITLE,
    ATOM_CONTENT,
    ATOM_SUMMARY,
    ATOM_AUTHOR,
    GD_WHEN,
    GD_EMAIL,
    GEORSS_POINT,
    GD_IM,
    GD_PHONENUMBER,
    GD_POSTALADDRESS,
    GD_RATING,
    BLOBKEY,
    ENTITY_PROTO,
    INDEX_VALUE,
  ];

  static final Map<int, Property_Meaning> _byValue = ProtobufEnum.initByValue(values);
  static Property_Meaning valueOf(int value) => _byValue[value];

  const Property_Meaning._(int v, String n) : super(v, n);
}

class Property_FtsTokenizationOption extends ProtobufEnum {
  static const Property_FtsTokenizationOption HTML = const Property_FtsTokenizationOption._(1, 'HTML');
  static const Property_FtsTokenizationOption ATOM = const Property_FtsTokenizationOption._(2, 'ATOM');

  static const List<Property_FtsTokenizationOption> values = const <Property_FtsTokenizationOption> [
    HTML,
    ATOM,
  ];

  static final Map<int, Property_FtsTokenizationOption> _byValue = ProtobufEnum.initByValue(values);
  static Property_FtsTokenizationOption valueOf(int value) => _byValue[value];

  const Property_FtsTokenizationOption._(int v, String n) : super(v, n);
}

class Property extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Property')
    ..e(1, 'meaning', GeneratedMessage.OE, () => Property_Meaning.NO_MEANING, (var v) => Property_Meaning.valueOf(v))
    ..a(2, 'meaningUri', GeneratedMessage.OS)
    ..a(3, 'name', GeneratedMessage.QS)
    ..a(5, 'value', GeneratedMessage.QM, () => new PropertyValue(), () => new PropertyValue())
    ..a(4, 'multiple', GeneratedMessage.QB)
    ..a(6, 'searchable', GeneratedMessage.OB)
    ..e(8, 'ftsTokenizationOption', GeneratedMessage.OE, () => Property_FtsTokenizationOption.HTML, (var v) => Property_FtsTokenizationOption.valueOf(v))
    ..a(9, 'locale', GeneratedMessage.OS, () => 'en')
  ;

  Property() : super();
  Property.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Property.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Property clone() => new Property()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Property_Meaning get meaning => getField(1);
  void set meaning(Property_Meaning v) { setField(1, v); }
  bool hasMeaning() => hasField(1);
  void clearMeaning() => clearField(1);

  String get meaningUri => getField(2);
  void set meaningUri(String v) { setField(2, v); }
  bool hasMeaningUri() => hasField(2);
  void clearMeaningUri() => clearField(2);

  String get name => getField(3);
  void set name(String v) { setField(3, v); }
  bool hasName() => hasField(3);
  void clearName() => clearField(3);

  PropertyValue get value => getField(5);
  void set value(PropertyValue v) { setField(5, v); }
  bool hasValue() => hasField(5);
  void clearValue() => clearField(5);

  bool get multiple => getField(4);
  void set multiple(bool v) { setField(4, v); }
  bool hasMultiple() => hasField(4);
  void clearMultiple() => clearField(4);

  bool get searchable => getField(6);
  void set searchable(bool v) { setField(6, v); }
  bool hasSearchable() => hasField(6);
  void clearSearchable() => clearField(6);

  Property_FtsTokenizationOption get ftsTokenizationOption => getField(8);
  void set ftsTokenizationOption(Property_FtsTokenizationOption v) { setField(8, v); }
  bool hasFtsTokenizationOption() => hasField(8);
  void clearFtsTokenizationOption() => clearField(8);

  String get locale => getField(9);
  void set locale(String v) { setField(9, v); }
  bool hasLocale() => hasField(9);
  void clearLocale() => clearField(9);
}

class Path_Element extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Path_Element')
    ..a(2, 'type', GeneratedMessage.QS)
    ..a(3, 'id', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(4, 'name', GeneratedMessage.OS)
  ;

  Path_Element() : super();
  Path_Element.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Path_Element.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Path_Element clone() => new Path_Element()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get type => getField(2);
  void set type(String v) { setField(2, v); }
  bool hasType() => hasField(2);
  void clearType() => clearField(2);

  Int64 get id => getField(3);
  void set id(Int64 v) { setField(3, v); }
  bool hasId() => hasField(3);
  void clearId() => clearField(3);

  String get name => getField(4);
  void set name(String v) { setField(4, v); }
  bool hasName() => hasField(4);
  void clearName() => clearField(4);
}

class Path extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Path')
    ..a(1, 'element', GeneratedMessage.PG, () => new PbList(), () => new Path_Element())
    ..hasRequiredFields = false
  ;

  Path() : super();
  Path.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Path.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Path clone() => new Path()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<Path_Element> get element => getField(1);
}

class Reference extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Reference')
    ..a(13, 'app', GeneratedMessage.QS)
    ..a(20, 'nameSpace', GeneratedMessage.OS)
    ..a(14, 'path', GeneratedMessage.QM, () => new Path(), () => new Path())
  ;

  Reference() : super();
  Reference.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Reference.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Reference clone() => new Reference()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get app => getField(13);
  void set app(String v) { setField(13, v); }
  bool hasApp() => hasField(13);
  void clearApp() => clearField(13);

  String get nameSpace => getField(20);
  void set nameSpace(String v) { setField(20, v); }
  bool hasNameSpace() => hasField(20);
  void clearNameSpace() => clearField(20);

  Path get path => getField(14);
  void set path(Path v) { setField(14, v); }
  bool hasPath() => hasField(14);
  void clearPath() => clearField(14);
}

class User extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('User')
    ..a(1, 'email', GeneratedMessage.QS)
    ..a(2, 'authDomain', GeneratedMessage.QS)
    ..a(3, 'nickname', GeneratedMessage.OS)
    ..a(6, 'federatedIdentity', GeneratedMessage.OS)
    ..a(7, 'federatedProvider', GeneratedMessage.OS)
  ;

  User() : super();
  User.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  User.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  User clone() => new User()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get email => getField(1);
  void set email(String v) { setField(1, v); }
  bool hasEmail() => hasField(1);
  void clearEmail() => clearField(1);

  String get authDomain => getField(2);
  void set authDomain(String v) { setField(2, v); }
  bool hasAuthDomain() => hasField(2);
  void clearAuthDomain() => clearField(2);

  String get nickname => getField(3);
  void set nickname(String v) { setField(3, v); }
  bool hasNickname() => hasField(3);
  void clearNickname() => clearField(3);

  String get federatedIdentity => getField(6);
  void set federatedIdentity(String v) { setField(6, v); }
  bool hasFederatedIdentity() => hasField(6);
  void clearFederatedIdentity() => clearField(6);

  String get federatedProvider => getField(7);
  void set federatedProvider(String v) { setField(7, v); }
  bool hasFederatedProvider() => hasField(7);
  void clearFederatedProvider() => clearField(7);
}

class EntityProto_Kind extends ProtobufEnum {
  static const EntityProto_Kind GD_CONTACT = const EntityProto_Kind._(1, 'GD_CONTACT');
  static const EntityProto_Kind GD_EVENT = const EntityProto_Kind._(2, 'GD_EVENT');
  static const EntityProto_Kind GD_MESSAGE = const EntityProto_Kind._(3, 'GD_MESSAGE');

  static const List<EntityProto_Kind> values = const <EntityProto_Kind> [
    GD_CONTACT,
    GD_EVENT,
    GD_MESSAGE,
  ];

  static final Map<int, EntityProto_Kind> _byValue = ProtobufEnum.initByValue(values);
  static EntityProto_Kind valueOf(int value) => _byValue[value];

  const EntityProto_Kind._(int v, String n) : super(v, n);
}

class EntityProto extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('EntityProto')
    ..a(13, 'key', GeneratedMessage.QM, () => new Reference(), () => new Reference())
    ..a(16, 'entityGroup', GeneratedMessage.QM, () => new Path(), () => new Path())
    ..a(17, 'owner', GeneratedMessage.OM, () => new User(), () => new User())
    ..e(4, 'kind', GeneratedMessage.OE, () => EntityProto_Kind.GD_CONTACT, (var v) => EntityProto_Kind.valueOf(v))
    ..a(5, 'kindUri', GeneratedMessage.OS)
    ..m(14, 'property', () => new Property(), () => new PbList<Property>())
    ..m(15, 'rawProperty', () => new Property(), () => new PbList<Property>())
    ..a(18, 'rank', GeneratedMessage.O3)
  ;

  EntityProto() : super();
  EntityProto.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EntityProto.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EntityProto clone() => new EntityProto()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Reference get key => getField(13);
  void set key(Reference v) { setField(13, v); }
  bool hasKey() => hasField(13);
  void clearKey() => clearField(13);

  Path get entityGroup => getField(16);
  void set entityGroup(Path v) { setField(16, v); }
  bool hasEntityGroup() => hasField(16);
  void clearEntityGroup() => clearField(16);

  User get owner => getField(17);
  void set owner(User v) { setField(17, v); }
  bool hasOwner() => hasField(17);
  void clearOwner() => clearField(17);

  EntityProto_Kind get kind => getField(4);
  void set kind(EntityProto_Kind v) { setField(4, v); }
  bool hasKind() => hasField(4);
  void clearKind() => clearField(4);

  String get kindUri => getField(5);
  void set kindUri(String v) { setField(5, v); }
  bool hasKindUri() => hasField(5);
  void clearKindUri() => clearField(5);

  List<Property> get property => getField(14);

  List<Property> get rawProperty => getField(15);

  int get rank => getField(18);
  void set rank(int v) { setField(18, v); }
  bool hasRank() => hasField(18);
  void clearRank() => clearField(18);
}

class CompositeProperty extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CompositeProperty')
    ..a(1, 'indexId', GeneratedMessage.Q6, () => makeLongInt(0))
    ..p(2, 'value', GeneratedMessage.PS)
  ;

  CompositeProperty() : super();
  CompositeProperty.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CompositeProperty.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CompositeProperty clone() => new CompositeProperty()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Int64 get indexId => getField(1);
  void set indexId(Int64 v) { setField(1, v); }
  bool hasIndexId() => hasField(1);
  void clearIndexId() => clearField(1);

  List<String> get value => getField(2);
}

class Index_Property_Direction extends ProtobufEnum {
  static const Index_Property_Direction ASCENDING = const Index_Property_Direction._(1, 'ASCENDING');
  static const Index_Property_Direction DESCENDING = const Index_Property_Direction._(2, 'DESCENDING');

  static const List<Index_Property_Direction> values = const <Index_Property_Direction> [
    ASCENDING,
    DESCENDING,
  ];

  static final Map<int, Index_Property_Direction> _byValue = ProtobufEnum.initByValue(values);
  static Index_Property_Direction valueOf(int value) => _byValue[value];

  const Index_Property_Direction._(int v, String n) : super(v, n);
}

class Index_Property extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Index_Property')
    ..a(3, 'name', GeneratedMessage.QS)
    ..e(4, 'direction', GeneratedMessage.OE, () => Index_Property_Direction.ASCENDING, (var v) => Index_Property_Direction.valueOf(v))
  ;

  Index_Property() : super();
  Index_Property.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Index_Property.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Index_Property clone() => new Index_Property()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get name => getField(3);
  void set name(String v) { setField(3, v); }
  bool hasName() => hasField(3);
  void clearName() => clearField(3);

  Index_Property_Direction get direction => getField(4);
  void set direction(Index_Property_Direction v) { setField(4, v); }
  bool hasDirection() => hasField(4);
  void clearDirection() => clearField(4);
}

class Index extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Index')
    ..a(1, 'entityType', GeneratedMessage.QS)
    ..a(5, 'ancestor', GeneratedMessage.QB)
    ..a(2, 'property', GeneratedMessage.PG, () => new PbList(), () => new Index_Property())
  ;

  Index() : super();
  Index.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Index.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Index clone() => new Index()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get entityType => getField(1);
  void set entityType(String v) { setField(1, v); }
  bool hasEntityType() => hasField(1);
  void clearEntityType() => clearField(1);

  bool get ancestor => getField(5);
  void set ancestor(bool v) { setField(5, v); }
  bool hasAncestor() => hasField(5);
  void clearAncestor() => clearField(5);

  List<Index_Property> get property => getField(2);
}

class CompositeIndex_State extends ProtobufEnum {
  static const CompositeIndex_State WRITE_ONLY = const CompositeIndex_State._(1, 'WRITE_ONLY');
  static const CompositeIndex_State READ_WRITE = const CompositeIndex_State._(2, 'READ_WRITE');
  static const CompositeIndex_State DELETED = const CompositeIndex_State._(3, 'DELETED');
  static const CompositeIndex_State ERROR = const CompositeIndex_State._(4, 'ERROR');

  static const List<CompositeIndex_State> values = const <CompositeIndex_State> [
    WRITE_ONLY,
    READ_WRITE,
    DELETED,
    ERROR,
  ];

  static final Map<int, CompositeIndex_State> _byValue = ProtobufEnum.initByValue(values);
  static CompositeIndex_State valueOf(int value) => _byValue[value];

  const CompositeIndex_State._(int v, String n) : super(v, n);
}

class CompositeIndex extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CompositeIndex')
    ..a(1, 'appId', GeneratedMessage.QS)
    ..a(2, 'id', GeneratedMessage.Q6, () => makeLongInt(0))
    ..a(3, 'definition', GeneratedMessage.QM, () => new Index(), () => new Index())
    ..e(4, 'state', GeneratedMessage.QE, () => CompositeIndex_State.WRITE_ONLY, (var v) => CompositeIndex_State.valueOf(v))
    ..a(6, 'onlyUseIfRequired', GeneratedMessage.OB)
  ;

  CompositeIndex() : super();
  CompositeIndex.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CompositeIndex.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CompositeIndex clone() => new CompositeIndex()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get appId => getField(1);
  void set appId(String v) { setField(1, v); }
  bool hasAppId() => hasField(1);
  void clearAppId() => clearField(1);

  Int64 get id => getField(2);
  void set id(Int64 v) { setField(2, v); }
  bool hasId() => hasField(2);
  void clearId() => clearField(2);

  Index get definition => getField(3);
  void set definition(Index v) { setField(3, v); }
  bool hasDefinition() => hasField(3);
  void clearDefinition() => clearField(3);

  CompositeIndex_State get state => getField(4);
  void set state(CompositeIndex_State v) { setField(4, v); }
  bool hasState() => hasField(4);
  void clearState() => clearField(4);

  bool get onlyUseIfRequired => getField(6);
  void set onlyUseIfRequired(bool v) { setField(6, v); }
  bool hasOnlyUseIfRequired() => hasField(6);
  void clearOnlyUseIfRequired() => clearField(6);
}

class IndexPostfix_IndexValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('IndexPostfix_IndexValue')
    ..a(1, 'propertyName', GeneratedMessage.QS)
    ..a(2, 'value', GeneratedMessage.QM, () => new PropertyValue(), () => new PropertyValue())
  ;

  IndexPostfix_IndexValue() : super();
  IndexPostfix_IndexValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  IndexPostfix_IndexValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  IndexPostfix_IndexValue clone() => new IndexPostfix_IndexValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get propertyName => getField(1);
  void set propertyName(String v) { setField(1, v); }
  bool hasPropertyName() => hasField(1);
  void clearPropertyName() => clearField(1);

  PropertyValue get value => getField(2);
  void set value(PropertyValue v) { setField(2, v); }
  bool hasValue() => hasField(2);
  void clearValue() => clearField(2);
}

class IndexPostfix extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('IndexPostfix')
    ..m(1, 'indexValue', () => new IndexPostfix_IndexValue(), () => new PbList<IndexPostfix_IndexValue>())
    ..a(2, 'key', GeneratedMessage.OM, () => new Reference(), () => new Reference())
    ..a(3, 'before', GeneratedMessage.OB, () => true)
  ;

  IndexPostfix() : super();
  IndexPostfix.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  IndexPostfix.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  IndexPostfix clone() => new IndexPostfix()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<IndexPostfix_IndexValue> get indexValue => getField(1);

  Reference get key => getField(2);
  void set key(Reference v) { setField(2, v); }
  bool hasKey() => hasField(2);
  void clearKey() => clearField(2);

  bool get before => getField(3);
  void set before(bool v) { setField(3, v); }
  bool hasBefore() => hasField(3);
  void clearBefore() => clearField(3);
}

class IndexPosition extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('IndexPosition')
    ..a(1, 'key', GeneratedMessage.OS)
    ..a(2, 'before', GeneratedMessage.OB, () => true)
    ..hasRequiredFields = false
  ;

  IndexPosition() : super();
  IndexPosition.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  IndexPosition.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  IndexPosition clone() => new IndexPosition()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get key => getField(1);
  void set key(String v) { setField(1, v); }
  bool hasKey() => hasField(1);
  void clearKey() => clearField(1);

  bool get before => getField(2);
  void set before(bool v) { setField(2, v); }
  bool hasBefore() => hasField(2);
  void clearBefore() => clearField(2);
}

class Snapshot_Status extends ProtobufEnum {
  static const Snapshot_Status INACTIVE = const Snapshot_Status._(0, 'INACTIVE');
  static const Snapshot_Status ACTIVE = const Snapshot_Status._(1, 'ACTIVE');

  static const List<Snapshot_Status> values = const <Snapshot_Status> [
    INACTIVE,
    ACTIVE,
  ];

  static final Map<int, Snapshot_Status> _byValue = ProtobufEnum.initByValue(values);
  static Snapshot_Status valueOf(int value) => _byValue[value];

  const Snapshot_Status._(int v, String n) : super(v, n);
}

class Snapshot extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Snapshot')
    ..a(1, 'ts', GeneratedMessage.Q6, () => makeLongInt(0))
  ;

  Snapshot() : super();
  Snapshot.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Snapshot.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Snapshot clone() => new Snapshot()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Int64 get ts => getField(1);
  void set ts(Int64 v) { setField(1, v); }
  bool hasTs() => hasField(1);
  void clearTs() => clearField(1);
}

class InternalHeader extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('InternalHeader')
    ..a(1, 'qos', GeneratedMessage.OS)
    ..hasRequiredFields = false
  ;

  InternalHeader() : super();
  InternalHeader.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  InternalHeader.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  InternalHeader clone() => new InternalHeader()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get qos => getField(1);
  void set qos(String v) { setField(1, v); }
  bool hasQos() => hasField(1);
  void clearQos() => clearField(1);
}

class Transaction extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Transaction')
    ..a(4, 'header', GeneratedMessage.OM, () => new InternalHeader(), () => new InternalHeader())
    ..a(1, 'handle', GeneratedMessage.QF6, () => makeLongInt(0))
    ..a(2, 'app', GeneratedMessage.QS)
    ..a(3, 'markChanges', GeneratedMessage.OB)
  ;

  Transaction() : super();
  Transaction.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Transaction.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Transaction clone() => new Transaction()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  InternalHeader get header => getField(4);
  void set header(InternalHeader v) { setField(4, v); }
  bool hasHeader() => hasField(4);
  void clearHeader() => clearField(4);

  Int64 get handle => getField(1);
  void set handle(Int64 v) { setField(1, v); }
  bool hasHandle() => hasField(1);
  void clearHandle() => clearField(1);

  String get app => getField(2);
  void set app(String v) { setField(2, v); }
  bool hasApp() => hasField(2);
  void clearApp() => clearField(2);

  bool get markChanges => getField(3);
  void set markChanges(bool v) { setField(3, v); }
  bool hasMarkChanges() => hasField(3);
  void clearMarkChanges() => clearField(3);
}

class Query_Hint extends ProtobufEnum {
  static const Query_Hint ORDER_FIRST = const Query_Hint._(1, 'ORDER_FIRST');
  static const Query_Hint ANCESTOR_FIRST = const Query_Hint._(2, 'ANCESTOR_FIRST');
  static const Query_Hint FILTER_FIRST = const Query_Hint._(3, 'FILTER_FIRST');

  static const List<Query_Hint> values = const <Query_Hint> [
    ORDER_FIRST,
    ANCESTOR_FIRST,
    FILTER_FIRST,
  ];

  static final Map<int, Query_Hint> _byValue = ProtobufEnum.initByValue(values);
  static Query_Hint valueOf(int value) => _byValue[value];

  const Query_Hint._(int v, String n) : super(v, n);
}

class Query_Filter_Operator extends ProtobufEnum {
  static const Query_Filter_Operator LESS_THAN = const Query_Filter_Operator._(1, 'LESS_THAN');
  static const Query_Filter_Operator LESS_THAN_OR_EQUAL = const Query_Filter_Operator._(2, 'LESS_THAN_OR_EQUAL');
  static const Query_Filter_Operator GREATER_THAN = const Query_Filter_Operator._(3, 'GREATER_THAN');
  static const Query_Filter_Operator GREATER_THAN_OR_EQUAL = const Query_Filter_Operator._(4, 'GREATER_THAN_OR_EQUAL');
  static const Query_Filter_Operator EQUAL = const Query_Filter_Operator._(5, 'EQUAL');
  static const Query_Filter_Operator IN = const Query_Filter_Operator._(6, 'IN');
  static const Query_Filter_Operator EXISTS = const Query_Filter_Operator._(7, 'EXISTS');

  static const List<Query_Filter_Operator> values = const <Query_Filter_Operator> [
    LESS_THAN,
    LESS_THAN_OR_EQUAL,
    GREATER_THAN,
    GREATER_THAN_OR_EQUAL,
    EQUAL,
    IN,
    EXISTS,
  ];

  static final Map<int, Query_Filter_Operator> _byValue = ProtobufEnum.initByValue(values);
  static Query_Filter_Operator valueOf(int value) => _byValue[value];

  const Query_Filter_Operator._(int v, String n) : super(v, n);
}

class Query_Filter extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Query_Filter')
    ..e(6, 'op', GeneratedMessage.QE, () => Query_Filter_Operator.LESS_THAN, (var v) => Query_Filter_Operator.valueOf(v))
    ..m(14, 'property', () => new Property(), () => new PbList<Property>())
  ;

  Query_Filter() : super();
  Query_Filter.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Query_Filter.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Query_Filter clone() => new Query_Filter()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Query_Filter_Operator get op => getField(6);
  void set op(Query_Filter_Operator v) { setField(6, v); }
  bool hasOp() => hasField(6);
  void clearOp() => clearField(6);

  List<Property> get property => getField(14);
}

class Query_Order_Direction extends ProtobufEnum {
  static const Query_Order_Direction ASCENDING = const Query_Order_Direction._(1, 'ASCENDING');
  static const Query_Order_Direction DESCENDING = const Query_Order_Direction._(2, 'DESCENDING');

  static const List<Query_Order_Direction> values = const <Query_Order_Direction> [
    ASCENDING,
    DESCENDING,
  ];

  static final Map<int, Query_Order_Direction> _byValue = ProtobufEnum.initByValue(values);
  static Query_Order_Direction valueOf(int value) => _byValue[value];

  const Query_Order_Direction._(int v, String n) : super(v, n);
}

class Query_Order extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Query_Order')
    ..a(10, 'property', GeneratedMessage.QS)
    ..e(11, 'direction', GeneratedMessage.OE, () => Query_Order_Direction.ASCENDING, (var v) => Query_Order_Direction.valueOf(v))
  ;

  Query_Order() : super();
  Query_Order.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Query_Order.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Query_Order clone() => new Query_Order()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get property => getField(10);
  void set property(String v) { setField(10, v); }
  bool hasProperty() => hasField(10);
  void clearProperty() => clearField(10);

  Query_Order_Direction get direction => getField(11);
  void set direction(Query_Order_Direction v) { setField(11, v); }
  bool hasDirection() => hasField(11);
  void clearDirection() => clearField(11);
}

class Query extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Query')
    ..a(39, 'header', GeneratedMessage.OM, () => new InternalHeader(), () => new InternalHeader())
    ..a(1, 'app', GeneratedMessage.QS)
    ..a(29, 'nameSpace', GeneratedMessage.OS)
    ..a(3, 'kind', GeneratedMessage.OS)
    ..a(17, 'ancestor', GeneratedMessage.OM, () => new Reference(), () => new Reference())
    ..a(4, 'filter', GeneratedMessage.PG, () => new PbList(), () => new Query_Filter())
    ..a(8, 'searchQuery', GeneratedMessage.OS)
    ..a(9, 'order', GeneratedMessage.PG, () => new PbList(), () => new Query_Order())
    ..e(18, 'hint', GeneratedMessage.OE, () => Query_Hint.ORDER_FIRST, (var v) => Query_Hint.valueOf(v))
    ..a(23, 'count', GeneratedMessage.O3)
    ..a(12, 'offset', GeneratedMessage.O3)
    ..a(16, 'limit', GeneratedMessage.O3)
    ..a(30, 'compiledCursor', GeneratedMessage.OM, () => new CompiledCursor(), () => new CompiledCursor())
    ..a(31, 'endCompiledCursor', GeneratedMessage.OM, () => new CompiledCursor(), () => new CompiledCursor())
    ..m(19, 'compositeIndex', () => new CompositeIndex(), () => new PbList<CompositeIndex>())
    ..a(20, 'requirePerfectPlan', GeneratedMessage.OB)
    ..a(21, 'keysOnly', GeneratedMessage.OB)
    ..a(22, 'transaction', GeneratedMessage.OM, () => new Transaction(), () => new Transaction())
    ..a(25, 'compile', GeneratedMessage.OB)
    ..a(26, 'failoverMs', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(32, 'strong', GeneratedMessage.OB)
    ..p(33, 'propertyName', GeneratedMessage.PS)
    ..p(34, 'groupByPropertyName', GeneratedMessage.PS)
    ..a(24, 'distinct', GeneratedMessage.OB)
    ..a(35, 'minSafeTimeSeconds', GeneratedMessage.O6, () => makeLongInt(0))
    ..p(36, 'safeReplicaName', GeneratedMessage.PS)
    ..a(37, 'persistOffset', GeneratedMessage.OB)
  ;

  Query() : super();
  Query.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Query.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Query clone() => new Query()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  InternalHeader get header => getField(39);
  void set header(InternalHeader v) { setField(39, v); }
  bool hasHeader() => hasField(39);
  void clearHeader() => clearField(39);

  String get app => getField(1);
  void set app(String v) { setField(1, v); }
  bool hasApp() => hasField(1);
  void clearApp() => clearField(1);

  String get nameSpace => getField(29);
  void set nameSpace(String v) { setField(29, v); }
  bool hasNameSpace() => hasField(29);
  void clearNameSpace() => clearField(29);

  String get kind => getField(3);
  void set kind(String v) { setField(3, v); }
  bool hasKind() => hasField(3);
  void clearKind() => clearField(3);

  Reference get ancestor => getField(17);
  void set ancestor(Reference v) { setField(17, v); }
  bool hasAncestor() => hasField(17);
  void clearAncestor() => clearField(17);

  List<Query_Filter> get filter => getField(4);

  String get searchQuery => getField(8);
  void set searchQuery(String v) { setField(8, v); }
  bool hasSearchQuery() => hasField(8);
  void clearSearchQuery() => clearField(8);

  List<Query_Order> get order => getField(9);

  Query_Hint get hint => getField(18);
  void set hint(Query_Hint v) { setField(18, v); }
  bool hasHint() => hasField(18);
  void clearHint() => clearField(18);

  int get count => getField(23);
  void set count(int v) { setField(23, v); }
  bool hasCount() => hasField(23);
  void clearCount() => clearField(23);

  int get offset => getField(12);
  void set offset(int v) { setField(12, v); }
  bool hasOffset() => hasField(12);
  void clearOffset() => clearField(12);

  int get limit => getField(16);
  void set limit(int v) { setField(16, v); }
  bool hasLimit() => hasField(16);
  void clearLimit() => clearField(16);

  CompiledCursor get compiledCursor => getField(30);
  void set compiledCursor(CompiledCursor v) { setField(30, v); }
  bool hasCompiledCursor() => hasField(30);
  void clearCompiledCursor() => clearField(30);

  CompiledCursor get endCompiledCursor => getField(31);
  void set endCompiledCursor(CompiledCursor v) { setField(31, v); }
  bool hasEndCompiledCursor() => hasField(31);
  void clearEndCompiledCursor() => clearField(31);

  List<CompositeIndex> get compositeIndex => getField(19);

  bool get requirePerfectPlan => getField(20);
  void set requirePerfectPlan(bool v) { setField(20, v); }
  bool hasRequirePerfectPlan() => hasField(20);
  void clearRequirePerfectPlan() => clearField(20);

  bool get keysOnly => getField(21);
  void set keysOnly(bool v) { setField(21, v); }
  bool hasKeysOnly() => hasField(21);
  void clearKeysOnly() => clearField(21);

  Transaction get transaction => getField(22);
  void set transaction(Transaction v) { setField(22, v); }
  bool hasTransaction() => hasField(22);
  void clearTransaction() => clearField(22);

  bool get compile => getField(25);
  void set compile(bool v) { setField(25, v); }
  bool hasCompile() => hasField(25);
  void clearCompile() => clearField(25);

  Int64 get failoverMs => getField(26);
  void set failoverMs(Int64 v) { setField(26, v); }
  bool hasFailoverMs() => hasField(26);
  void clearFailoverMs() => clearField(26);

  bool get strong => getField(32);
  void set strong(bool v) { setField(32, v); }
  bool hasStrong() => hasField(32);
  void clearStrong() => clearField(32);

  List<String> get propertyName => getField(33);

  List<String> get groupByPropertyName => getField(34);

  bool get distinct => getField(24);
  void set distinct(bool v) { setField(24, v); }
  bool hasDistinct() => hasField(24);
  void clearDistinct() => clearField(24);

  Int64 get minSafeTimeSeconds => getField(35);
  void set minSafeTimeSeconds(Int64 v) { setField(35, v); }
  bool hasMinSafeTimeSeconds() => hasField(35);
  void clearMinSafeTimeSeconds() => clearField(35);

  List<String> get safeReplicaName => getField(36);

  bool get persistOffset => getField(37);
  void set persistOffset(bool v) { setField(37, v); }
  bool hasPersistOffset() => hasField(37);
  void clearPersistOffset() => clearField(37);
}

class CompiledQuery_PrimaryScan extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CompiledQuery_PrimaryScan')
    ..a(2, 'indexName', GeneratedMessage.OS)
    ..a(3, 'startKey', GeneratedMessage.OS)
    ..a(4, 'startInclusive', GeneratedMessage.OB)
    ..a(5, 'endKey', GeneratedMessage.OS)
    ..a(6, 'endInclusive', GeneratedMessage.OB)
    ..p(22, 'startPostfixValue', GeneratedMessage.PS)
    ..p(23, 'endPostfixValue', GeneratedMessage.PS)
    ..a(19, 'endUnappliedLogTimestampUs', GeneratedMessage.O6, () => makeLongInt(0))
    ..hasRequiredFields = false
  ;

  CompiledQuery_PrimaryScan() : super();
  CompiledQuery_PrimaryScan.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CompiledQuery_PrimaryScan.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CompiledQuery_PrimaryScan clone() => new CompiledQuery_PrimaryScan()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get indexName => getField(2);
  void set indexName(String v) { setField(2, v); }
  bool hasIndexName() => hasField(2);
  void clearIndexName() => clearField(2);

  String get startKey => getField(3);
  void set startKey(String v) { setField(3, v); }
  bool hasStartKey() => hasField(3);
  void clearStartKey() => clearField(3);

  bool get startInclusive => getField(4);
  void set startInclusive(bool v) { setField(4, v); }
  bool hasStartInclusive() => hasField(4);
  void clearStartInclusive() => clearField(4);

  String get endKey => getField(5);
  void set endKey(String v) { setField(5, v); }
  bool hasEndKey() => hasField(5);
  void clearEndKey() => clearField(5);

  bool get endInclusive => getField(6);
  void set endInclusive(bool v) { setField(6, v); }
  bool hasEndInclusive() => hasField(6);
  void clearEndInclusive() => clearField(6);

  List<String> get startPostfixValue => getField(22);

  List<String> get endPostfixValue => getField(23);

  Int64 get endUnappliedLogTimestampUs => getField(19);
  void set endUnappliedLogTimestampUs(Int64 v) { setField(19, v); }
  bool hasEndUnappliedLogTimestampUs() => hasField(19);
  void clearEndUnappliedLogTimestampUs() => clearField(19);
}

class CompiledQuery_MergeJoinScan extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CompiledQuery_MergeJoinScan')
    ..a(8, 'indexName', GeneratedMessage.QS)
    ..p(9, 'prefixValue', GeneratedMessage.PS)
    ..a(20, 'valuePrefix', GeneratedMessage.OB)
  ;

  CompiledQuery_MergeJoinScan() : super();
  CompiledQuery_MergeJoinScan.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CompiledQuery_MergeJoinScan.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CompiledQuery_MergeJoinScan clone() => new CompiledQuery_MergeJoinScan()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get indexName => getField(8);
  void set indexName(String v) { setField(8, v); }
  bool hasIndexName() => hasField(8);
  void clearIndexName() => clearField(8);

  List<String> get prefixValue => getField(9);

  bool get valuePrefix => getField(20);
  void set valuePrefix(bool v) { setField(20, v); }
  bool hasValuePrefix() => hasField(20);
  void clearValuePrefix() => clearField(20);
}

class CompiledQuery_EntityFilter extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CompiledQuery_EntityFilter')
    ..a(14, 'distinct', GeneratedMessage.OB)
    ..a(17, 'kind', GeneratedMessage.OS)
    ..a(18, 'ancestor', GeneratedMessage.OM, () => new Reference(), () => new Reference())
  ;

  CompiledQuery_EntityFilter() : super();
  CompiledQuery_EntityFilter.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CompiledQuery_EntityFilter.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CompiledQuery_EntityFilter clone() => new CompiledQuery_EntityFilter()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  bool get distinct => getField(14);
  void set distinct(bool v) { setField(14, v); }
  bool hasDistinct() => hasField(14);
  void clearDistinct() => clearField(14);

  String get kind => getField(17);
  void set kind(String v) { setField(17, v); }
  bool hasKind() => hasField(17);
  void clearKind() => clearField(17);

  Reference get ancestor => getField(18);
  void set ancestor(Reference v) { setField(18, v); }
  bool hasAncestor() => hasField(18);
  void clearAncestor() => clearField(18);
}

class CompiledQuery extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CompiledQuery')
    ..a(1, 'primaryScan', GeneratedMessage.QG, () => new CompiledQuery_PrimaryScan(), () => new CompiledQuery_PrimaryScan())
    ..a(7, 'mergeJoinScan', GeneratedMessage.PG, () => new PbList(), () => new CompiledQuery_MergeJoinScan())
    ..a(21, 'indexDef', GeneratedMessage.OM, () => new Index(), () => new Index())
    ..a(10, 'offset', GeneratedMessage.O3)
    ..a(11, 'limit', GeneratedMessage.O3)
    ..a(12, 'keysOnly', GeneratedMessage.QB)
    ..p(24, 'propertyName', GeneratedMessage.PS)
    ..a(25, 'distinctInfixSize', GeneratedMessage.O3)
    ..a(13, 'entityFilter', GeneratedMessage.OG, () => new CompiledQuery_EntityFilter(), () => new CompiledQuery_EntityFilter())
  ;

  CompiledQuery() : super();
  CompiledQuery.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CompiledQuery.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CompiledQuery clone() => new CompiledQuery()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  CompiledQuery_PrimaryScan get primaryScan => getField(1);
  void set primaryScan(CompiledQuery_PrimaryScan v) { setField(1, v); }
  bool hasPrimaryScan() => hasField(1);
  void clearPrimaryScan() => clearField(1);

  List<CompiledQuery_MergeJoinScan> get mergeJoinScan => getField(7);

  Index get indexDef => getField(21);
  void set indexDef(Index v) { setField(21, v); }
  bool hasIndexDef() => hasField(21);
  void clearIndexDef() => clearField(21);

  int get offset => getField(10);
  void set offset(int v) { setField(10, v); }
  bool hasOffset() => hasField(10);
  void clearOffset() => clearField(10);

  int get limit => getField(11);
  void set limit(int v) { setField(11, v); }
  bool hasLimit() => hasField(11);
  void clearLimit() => clearField(11);

  bool get keysOnly => getField(12);
  void set keysOnly(bool v) { setField(12, v); }
  bool hasKeysOnly() => hasField(12);
  void clearKeysOnly() => clearField(12);

  List<String> get propertyName => getField(24);

  int get distinctInfixSize => getField(25);
  void set distinctInfixSize(int v) { setField(25, v); }
  bool hasDistinctInfixSize() => hasField(25);
  void clearDistinctInfixSize() => clearField(25);

  CompiledQuery_EntityFilter get entityFilter => getField(13);
  void set entityFilter(CompiledQuery_EntityFilter v) { setField(13, v); }
  bool hasEntityFilter() => hasField(13);
  void clearEntityFilter() => clearField(13);
}

class CompiledCursor_Position_IndexValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CompiledCursor_Position_IndexValue')
    ..a(30, 'property', GeneratedMessage.OS)
    ..a(31, 'value', GeneratedMessage.QM, () => new PropertyValue(), () => new PropertyValue())
  ;

  CompiledCursor_Position_IndexValue() : super();
  CompiledCursor_Position_IndexValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CompiledCursor_Position_IndexValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CompiledCursor_Position_IndexValue clone() => new CompiledCursor_Position_IndexValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get property => getField(30);
  void set property(String v) { setField(30, v); }
  bool hasProperty() => hasField(30);
  void clearProperty() => clearField(30);

  PropertyValue get value => getField(31);
  void set value(PropertyValue v) { setField(31, v); }
  bool hasValue() => hasField(31);
  void clearValue() => clearField(31);
}

class CompiledCursor_Position extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CompiledCursor_Position')
    ..a(27, 'startKey', GeneratedMessage.OS)
    ..a(29, 'indexValue', GeneratedMessage.PG, () => new PbList(), () => new CompiledCursor_Position_IndexValue())
    ..a(32, 'key', GeneratedMessage.OM, () => new Reference(), () => new Reference())
    ..a(28, 'startInclusive', GeneratedMessage.OB, () => true)
  ;

  CompiledCursor_Position() : super();
  CompiledCursor_Position.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CompiledCursor_Position.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CompiledCursor_Position clone() => new CompiledCursor_Position()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get startKey => getField(27);
  void set startKey(String v) { setField(27, v); }
  bool hasStartKey() => hasField(27);
  void clearStartKey() => clearField(27);

  List<CompiledCursor_Position_IndexValue> get indexValue => getField(29);

  Reference get key => getField(32);
  void set key(Reference v) { setField(32, v); }
  bool hasKey() => hasField(32);
  void clearKey() => clearField(32);

  bool get startInclusive => getField(28);
  void set startInclusive(bool v) { setField(28, v); }
  bool hasStartInclusive() => hasField(28);
  void clearStartInclusive() => clearField(28);
}

class CompiledCursor extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CompiledCursor')
    ..a(2, 'position', GeneratedMessage.OG, () => new CompiledCursor_Position(), () => new CompiledCursor_Position())
    ..hasRequiredFields = false
  ;

  CompiledCursor() : super();
  CompiledCursor.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CompiledCursor.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CompiledCursor clone() => new CompiledCursor()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  CompiledCursor_Position get position => getField(2);
  void set position(CompiledCursor_Position v) { setField(2, v); }
  bool hasPosition() => hasField(2);
  void clearPosition() => clearField(2);
}

class Cursor extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Cursor')
    ..a(1, 'cursor', GeneratedMessage.QF6, () => makeLongInt(0))
    ..a(2, 'app', GeneratedMessage.OS)
  ;

  Cursor() : super();
  Cursor.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Cursor.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Cursor clone() => new Cursor()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Int64 get cursor => getField(1);
  void set cursor(Int64 v) { setField(1, v); }
  bool hasCursor() => hasField(1);
  void clearCursor() => clearField(1);

  String get app => getField(2);
  void set app(String v) { setField(2, v); }
  bool hasApp() => hasField(2);
  void clearApp() => clearField(2);
}

class Error_ErrorCode extends ProtobufEnum {
  static const Error_ErrorCode BAD_REQUEST = const Error_ErrorCode._(1, 'BAD_REQUEST');
  static const Error_ErrorCode CONCURRENT_TRANSACTION = const Error_ErrorCode._(2, 'CONCURRENT_TRANSACTION');
  static const Error_ErrorCode INTERNAL_ERROR = const Error_ErrorCode._(3, 'INTERNAL_ERROR');
  static const Error_ErrorCode NEED_INDEX = const Error_ErrorCode._(4, 'NEED_INDEX');
  static const Error_ErrorCode TIMEOUT = const Error_ErrorCode._(5, 'TIMEOUT');
  static const Error_ErrorCode PERMISSION_DENIED = const Error_ErrorCode._(6, 'PERMISSION_DENIED');
  static const Error_ErrorCode BIGTABLE_ERROR = const Error_ErrorCode._(7, 'BIGTABLE_ERROR');
  static const Error_ErrorCode COMMITTED_BUT_STILL_APPLYING = const Error_ErrorCode._(8, 'COMMITTED_BUT_STILL_APPLYING');
  static const Error_ErrorCode CAPABILITY_DISABLED = const Error_ErrorCode._(9, 'CAPABILITY_DISABLED');
  static const Error_ErrorCode TRY_ALTERNATE_BACKEND = const Error_ErrorCode._(10, 'TRY_ALTERNATE_BACKEND');
  static const Error_ErrorCode SAFE_TIME_TOO_OLD = const Error_ErrorCode._(11, 'SAFE_TIME_TOO_OLD');

  static const List<Error_ErrorCode> values = const <Error_ErrorCode> [
    BAD_REQUEST,
    CONCURRENT_TRANSACTION,
    INTERNAL_ERROR,
    NEED_INDEX,
    TIMEOUT,
    PERMISSION_DENIED,
    BIGTABLE_ERROR,
    COMMITTED_BUT_STILL_APPLYING,
    CAPABILITY_DISABLED,
    TRY_ALTERNATE_BACKEND,
    SAFE_TIME_TOO_OLD,
  ];

  static final Map<int, Error_ErrorCode> _byValue = ProtobufEnum.initByValue(values);
  static Error_ErrorCode valueOf(int value) => _byValue[value];

  const Error_ErrorCode._(int v, String n) : super(v, n);
}

class Error extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Error')
    ..hasRequiredFields = false
  ;

  Error() : super();
  Error.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Error.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Error clone() => new Error()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class Cost_CommitCost extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Cost_CommitCost')
    ..a(6, 'requestedEntityPuts', GeneratedMessage.O3)
    ..a(7, 'requestedEntityDeletes', GeneratedMessage.O3)
    ..hasRequiredFields = false
  ;

  Cost_CommitCost() : super();
  Cost_CommitCost.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Cost_CommitCost.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Cost_CommitCost clone() => new Cost_CommitCost()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  int get requestedEntityPuts => getField(6);
  void set requestedEntityPuts(int v) { setField(6, v); }
  bool hasRequestedEntityPuts() => hasField(6);
  void clearRequestedEntityPuts() => clearField(6);

  int get requestedEntityDeletes => getField(7);
  void set requestedEntityDeletes(int v) { setField(7, v); }
  bool hasRequestedEntityDeletes() => hasField(7);
  void clearRequestedEntityDeletes() => clearField(7);
}

class Cost extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Cost')
    ..a(1, 'indexWrites', GeneratedMessage.O3)
    ..a(2, 'indexWriteBytes', GeneratedMessage.O3)
    ..a(3, 'entityWrites', GeneratedMessage.O3)
    ..a(4, 'entityWriteBytes', GeneratedMessage.O3)
    ..a(5, 'commitCost', GeneratedMessage.OG, () => new Cost_CommitCost(), () => new Cost_CommitCost())
    ..a(8, 'approximateStorageDelta', GeneratedMessage.O3)
    ..a(9, 'idSequenceUpdates', GeneratedMessage.O3)
    ..hasRequiredFields = false
  ;

  Cost() : super();
  Cost.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Cost.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Cost clone() => new Cost()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  int get indexWrites => getField(1);
  void set indexWrites(int v) { setField(1, v); }
  bool hasIndexWrites() => hasField(1);
  void clearIndexWrites() => clearField(1);

  int get indexWriteBytes => getField(2);
  void set indexWriteBytes(int v) { setField(2, v); }
  bool hasIndexWriteBytes() => hasField(2);
  void clearIndexWriteBytes() => clearField(2);

  int get entityWrites => getField(3);
  void set entityWrites(int v) { setField(3, v); }
  bool hasEntityWrites() => hasField(3);
  void clearEntityWrites() => clearField(3);

  int get entityWriteBytes => getField(4);
  void set entityWriteBytes(int v) { setField(4, v); }
  bool hasEntityWriteBytes() => hasField(4);
  void clearEntityWriteBytes() => clearField(4);

  Cost_CommitCost get commitCost => getField(5);
  void set commitCost(Cost_CommitCost v) { setField(5, v); }
  bool hasCommitCost() => hasField(5);
  void clearCommitCost() => clearField(5);

  int get approximateStorageDelta => getField(8);
  void set approximateStorageDelta(int v) { setField(8, v); }
  bool hasApproximateStorageDelta() => hasField(8);
  void clearApproximateStorageDelta() => clearField(8);

  int get idSequenceUpdates => getField(9);
  void set idSequenceUpdates(int v) { setField(9, v); }
  bool hasIdSequenceUpdates() => hasField(9);
  void clearIdSequenceUpdates() => clearField(9);
}

class GetRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetRequest')
    ..a(6, 'header', GeneratedMessage.OM, () => new InternalHeader(), () => new InternalHeader())
    ..m(1, 'key', () => new Reference(), () => new PbList<Reference>())
    ..a(2, 'transaction', GeneratedMessage.OM, () => new Transaction(), () => new Transaction())
    ..a(3, 'failoverMs', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(4, 'strong', GeneratedMessage.OB)
    ..a(5, 'allowDeferred', GeneratedMessage.OB)
  ;

  GetRequest() : super();
  GetRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetRequest clone() => new GetRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  InternalHeader get header => getField(6);
  void set header(InternalHeader v) { setField(6, v); }
  bool hasHeader() => hasField(6);
  void clearHeader() => clearField(6);

  List<Reference> get key => getField(1);

  Transaction get transaction => getField(2);
  void set transaction(Transaction v) { setField(2, v); }
  bool hasTransaction() => hasField(2);
  void clearTransaction() => clearField(2);

  Int64 get failoverMs => getField(3);
  void set failoverMs(Int64 v) { setField(3, v); }
  bool hasFailoverMs() => hasField(3);
  void clearFailoverMs() => clearField(3);

  bool get strong => getField(4);
  void set strong(bool v) { setField(4, v); }
  bool hasStrong() => hasField(4);
  void clearStrong() => clearField(4);

  bool get allowDeferred => getField(5);
  void set allowDeferred(bool v) { setField(5, v); }
  bool hasAllowDeferred() => hasField(5);
  void clearAllowDeferred() => clearField(5);
}

class GetResponse_Entity extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetResponse_Entity')
    ..a(2, 'entity', GeneratedMessage.OM, () => new EntityProto(), () => new EntityProto())
    ..a(4, 'key', GeneratedMessage.OM, () => new Reference(), () => new Reference())
    ..a(3, 'version', GeneratedMessage.O6, () => makeLongInt(0))
  ;

  GetResponse_Entity() : super();
  GetResponse_Entity.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetResponse_Entity.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetResponse_Entity clone() => new GetResponse_Entity()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  EntityProto get entity => getField(2);
  void set entity(EntityProto v) { setField(2, v); }
  bool hasEntity() => hasField(2);
  void clearEntity() => clearField(2);

  Reference get key => getField(4);
  void set key(Reference v) { setField(4, v); }
  bool hasKey() => hasField(4);
  void clearKey() => clearField(4);

  Int64 get version => getField(3);
  void set version(Int64 v) { setField(3, v); }
  bool hasVersion() => hasField(3);
  void clearVersion() => clearField(3);
}

class GetResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetResponse')
    ..a(1, 'entity', GeneratedMessage.PG, () => new PbList(), () => new GetResponse_Entity())
    ..m(5, 'deferred', () => new Reference(), () => new PbList<Reference>())
    ..a(6, 'inOrder', GeneratedMessage.OB, () => true)
  ;

  GetResponse() : super();
  GetResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetResponse clone() => new GetResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<GetResponse_Entity> get entity => getField(1);

  List<Reference> get deferred => getField(5);

  bool get inOrder => getField(6);
  void set inOrder(bool v) { setField(6, v); }
  bool hasInOrder() => hasField(6);
  void clearInOrder() => clearField(6);
}

class PutRequest_AutoIdPolicy extends ProtobufEnum {
  static const PutRequest_AutoIdPolicy CURRENT = const PutRequest_AutoIdPolicy._(0, 'CURRENT');
  static const PutRequest_AutoIdPolicy SEQUENTIAL = const PutRequest_AutoIdPolicy._(1, 'SEQUENTIAL');

  static const List<PutRequest_AutoIdPolicy> values = const <PutRequest_AutoIdPolicy> [
    CURRENT,
    SEQUENTIAL,
  ];

  static final Map<int, PutRequest_AutoIdPolicy> _byValue = ProtobufEnum.initByValue(values);
  static PutRequest_AutoIdPolicy valueOf(int value) => _byValue[value];

  const PutRequest_AutoIdPolicy._(int v, String n) : super(v, n);
}

class PutRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PutRequest')
    ..a(11, 'header', GeneratedMessage.OM, () => new InternalHeader(), () => new InternalHeader())
    ..m(1, 'entity', () => new EntityProto(), () => new PbList<EntityProto>())
    ..a(2, 'transaction', GeneratedMessage.OM, () => new Transaction(), () => new Transaction())
    ..m(3, 'compositeIndex', () => new CompositeIndex(), () => new PbList<CompositeIndex>())
    ..a(4, 'trusted', GeneratedMessage.OB)
    ..a(7, 'force', GeneratedMessage.OB)
    ..a(8, 'markChanges', GeneratedMessage.OB)
    ..m(9, 'snapshot', () => new Snapshot(), () => new PbList<Snapshot>())
    ..e(10, 'autoIdPolicy', GeneratedMessage.OE, () => PutRequest_AutoIdPolicy.CURRENT, (var v) => PutRequest_AutoIdPolicy.valueOf(v))
  ;

  PutRequest() : super();
  PutRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PutRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PutRequest clone() => new PutRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  InternalHeader get header => getField(11);
  void set header(InternalHeader v) { setField(11, v); }
  bool hasHeader() => hasField(11);
  void clearHeader() => clearField(11);

  List<EntityProto> get entity => getField(1);

  Transaction get transaction => getField(2);
  void set transaction(Transaction v) { setField(2, v); }
  bool hasTransaction() => hasField(2);
  void clearTransaction() => clearField(2);

  List<CompositeIndex> get compositeIndex => getField(3);

  bool get trusted => getField(4);
  void set trusted(bool v) { setField(4, v); }
  bool hasTrusted() => hasField(4);
  void clearTrusted() => clearField(4);

  bool get force => getField(7);
  void set force(bool v) { setField(7, v); }
  bool hasForce() => hasField(7);
  void clearForce() => clearField(7);

  bool get markChanges => getField(8);
  void set markChanges(bool v) { setField(8, v); }
  bool hasMarkChanges() => hasField(8);
  void clearMarkChanges() => clearField(8);

  List<Snapshot> get snapshot => getField(9);

  PutRequest_AutoIdPolicy get autoIdPolicy => getField(10);
  void set autoIdPolicy(PutRequest_AutoIdPolicy v) { setField(10, v); }
  bool hasAutoIdPolicy() => hasField(10);
  void clearAutoIdPolicy() => clearField(10);
}

class PutResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PutResponse')
    ..m(1, 'key', () => new Reference(), () => new PbList<Reference>())
    ..a(2, 'cost', GeneratedMessage.OM, () => new Cost(), () => new Cost())
    ..p(3, 'version', GeneratedMessage.P6)
  ;

  PutResponse() : super();
  PutResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PutResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PutResponse clone() => new PutResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<Reference> get key => getField(1);

  Cost get cost => getField(2);
  void set cost(Cost v) { setField(2, v); }
  bool hasCost() => hasField(2);
  void clearCost() => clearField(2);

  List<Int64> get version => getField(3);
}

class TouchRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TouchRequest')
    ..a(10, 'header', GeneratedMessage.OM, () => new InternalHeader(), () => new InternalHeader())
    ..m(1, 'key', () => new Reference(), () => new PbList<Reference>())
    ..m(2, 'compositeIndex', () => new CompositeIndex(), () => new PbList<CompositeIndex>())
    ..a(3, 'force', GeneratedMessage.OB)
    ..m(9, 'snapshot', () => new Snapshot(), () => new PbList<Snapshot>())
  ;

  TouchRequest() : super();
  TouchRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TouchRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TouchRequest clone() => new TouchRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  InternalHeader get header => getField(10);
  void set header(InternalHeader v) { setField(10, v); }
  bool hasHeader() => hasField(10);
  void clearHeader() => clearField(10);

  List<Reference> get key => getField(1);

  List<CompositeIndex> get compositeIndex => getField(2);

  bool get force => getField(3);
  void set force(bool v) { setField(3, v); }
  bool hasForce() => hasField(3);
  void clearForce() => clearField(3);

  List<Snapshot> get snapshot => getField(9);
}

class TouchResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TouchResponse')
    ..a(1, 'cost', GeneratedMessage.OM, () => new Cost(), () => new Cost())
    ..hasRequiredFields = false
  ;

  TouchResponse() : super();
  TouchResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TouchResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TouchResponse clone() => new TouchResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Cost get cost => getField(1);
  void set cost(Cost v) { setField(1, v); }
  bool hasCost() => hasField(1);
  void clearCost() => clearField(1);
}

class DeleteRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteRequest')
    ..a(10, 'header', GeneratedMessage.OM, () => new InternalHeader(), () => new InternalHeader())
    ..m(6, 'key', () => new Reference(), () => new PbList<Reference>())
    ..a(5, 'transaction', GeneratedMessage.OM, () => new Transaction(), () => new Transaction())
    ..a(4, 'trusted', GeneratedMessage.OB)
    ..a(7, 'force', GeneratedMessage.OB)
    ..a(8, 'markChanges', GeneratedMessage.OB)
    ..m(9, 'snapshot', () => new Snapshot(), () => new PbList<Snapshot>())
  ;

  DeleteRequest() : super();
  DeleteRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteRequest clone() => new DeleteRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  InternalHeader get header => getField(10);
  void set header(InternalHeader v) { setField(10, v); }
  bool hasHeader() => hasField(10);
  void clearHeader() => clearField(10);

  List<Reference> get key => getField(6);

  Transaction get transaction => getField(5);
  void set transaction(Transaction v) { setField(5, v); }
  bool hasTransaction() => hasField(5);
  void clearTransaction() => clearField(5);

  bool get trusted => getField(4);
  void set trusted(bool v) { setField(4, v); }
  bool hasTrusted() => hasField(4);
  void clearTrusted() => clearField(4);

  bool get force => getField(7);
  void set force(bool v) { setField(7, v); }
  bool hasForce() => hasField(7);
  void clearForce() => clearField(7);

  bool get markChanges => getField(8);
  void set markChanges(bool v) { setField(8, v); }
  bool hasMarkChanges() => hasField(8);
  void clearMarkChanges() => clearField(8);

  List<Snapshot> get snapshot => getField(9);
}

class DeleteResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteResponse')
    ..a(1, 'cost', GeneratedMessage.OM, () => new Cost(), () => new Cost())
    ..p(3, 'version', GeneratedMessage.P6)
    ..hasRequiredFields = false
  ;

  DeleteResponse() : super();
  DeleteResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteResponse clone() => new DeleteResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Cost get cost => getField(1);
  void set cost(Cost v) { setField(1, v); }
  bool hasCost() => hasField(1);
  void clearCost() => clearField(1);

  List<Int64> get version => getField(3);
}

class NextRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('NextRequest')
    ..a(5, 'header', GeneratedMessage.OM, () => new InternalHeader(), () => new InternalHeader())
    ..a(1, 'cursor', GeneratedMessage.QM, () => new Cursor(), () => new Cursor())
    ..a(2, 'count', GeneratedMessage.O3)
    ..a(4, 'offset', GeneratedMessage.O3)
    ..a(3, 'compile', GeneratedMessage.OB)
  ;

  NextRequest() : super();
  NextRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NextRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NextRequest clone() => new NextRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  InternalHeader get header => getField(5);
  void set header(InternalHeader v) { setField(5, v); }
  bool hasHeader() => hasField(5);
  void clearHeader() => clearField(5);

  Cursor get cursor => getField(1);
  void set cursor(Cursor v) { setField(1, v); }
  bool hasCursor() => hasField(1);
  void clearCursor() => clearField(1);

  int get count => getField(2);
  void set count(int v) { setField(2, v); }
  bool hasCount() => hasField(2);
  void clearCount() => clearField(2);

  int get offset => getField(4);
  void set offset(int v) { setField(4, v); }
  bool hasOffset() => hasField(4);
  void clearOffset() => clearField(4);

  bool get compile => getField(3);
  void set compile(bool v) { setField(3, v); }
  bool hasCompile() => hasField(3);
  void clearCompile() => clearField(3);
}

class QueryResult extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('QueryResult')
    ..a(1, 'cursor', GeneratedMessage.OM, () => new Cursor(), () => new Cursor())
    ..m(2, 'result', () => new EntityProto(), () => new PbList<EntityProto>())
    ..a(7, 'skippedResults', GeneratedMessage.O3)
    ..a(3, 'moreResults', GeneratedMessage.QB)
    ..a(4, 'keysOnly', GeneratedMessage.OB)
    ..a(9, 'indexOnly', GeneratedMessage.OB)
    ..a(10, 'smallOps', GeneratedMessage.OB)
    ..a(5, 'compiledQuery', GeneratedMessage.OM, () => new CompiledQuery(), () => new CompiledQuery())
    ..a(6, 'compiledCursor', GeneratedMessage.OM, () => new CompiledCursor(), () => new CompiledCursor())
    ..m(8, 'index', () => new CompositeIndex(), () => new PbList<CompositeIndex>())
    ..p(11, 'version', GeneratedMessage.P6)
  ;

  QueryResult() : super();
  QueryResult.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  QueryResult.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  QueryResult clone() => new QueryResult()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Cursor get cursor => getField(1);
  void set cursor(Cursor v) { setField(1, v); }
  bool hasCursor() => hasField(1);
  void clearCursor() => clearField(1);

  List<EntityProto> get result => getField(2);

  int get skippedResults => getField(7);
  void set skippedResults(int v) { setField(7, v); }
  bool hasSkippedResults() => hasField(7);
  void clearSkippedResults() => clearField(7);

  bool get moreResults => getField(3);
  void set moreResults(bool v) { setField(3, v); }
  bool hasMoreResults() => hasField(3);
  void clearMoreResults() => clearField(3);

  bool get keysOnly => getField(4);
  void set keysOnly(bool v) { setField(4, v); }
  bool hasKeysOnly() => hasField(4);
  void clearKeysOnly() => clearField(4);

  bool get indexOnly => getField(9);
  void set indexOnly(bool v) { setField(9, v); }
  bool hasIndexOnly() => hasField(9);
  void clearIndexOnly() => clearField(9);

  bool get smallOps => getField(10);
  void set smallOps(bool v) { setField(10, v); }
  bool hasSmallOps() => hasField(10);
  void clearSmallOps() => clearField(10);

  CompiledQuery get compiledQuery => getField(5);
  void set compiledQuery(CompiledQuery v) { setField(5, v); }
  bool hasCompiledQuery() => hasField(5);
  void clearCompiledQuery() => clearField(5);

  CompiledCursor get compiledCursor => getField(6);
  void set compiledCursor(CompiledCursor v) { setField(6, v); }
  bool hasCompiledCursor() => hasField(6);
  void clearCompiledCursor() => clearField(6);

  List<CompositeIndex> get index => getField(8);

  List<Int64> get version => getField(11);
}

class AllocateIdsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AllocateIdsRequest')
    ..a(4, 'header', GeneratedMessage.OM, () => new InternalHeader(), () => new InternalHeader())
    ..a(1, 'modelKey', GeneratedMessage.OM, () => new Reference(), () => new Reference())
    ..a(2, 'size', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(3, 'max', GeneratedMessage.O6, () => makeLongInt(0))
    ..m(5, 'reserve', () => new Reference(), () => new PbList<Reference>())
  ;

  AllocateIdsRequest() : super();
  AllocateIdsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AllocateIdsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AllocateIdsRequest clone() => new AllocateIdsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  InternalHeader get header => getField(4);
  void set header(InternalHeader v) { setField(4, v); }
  bool hasHeader() => hasField(4);
  void clearHeader() => clearField(4);

  Reference get modelKey => getField(1);
  void set modelKey(Reference v) { setField(1, v); }
  bool hasModelKey() => hasField(1);
  void clearModelKey() => clearField(1);

  Int64 get size => getField(2);
  void set size(Int64 v) { setField(2, v); }
  bool hasSize() => hasField(2);
  void clearSize() => clearField(2);

  Int64 get max => getField(3);
  void set max(Int64 v) { setField(3, v); }
  bool hasMax() => hasField(3);
  void clearMax() => clearField(3);

  List<Reference> get reserve => getField(5);
}

class AllocateIdsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AllocateIdsResponse')
    ..a(1, 'start', GeneratedMessage.Q6, () => makeLongInt(0))
    ..a(2, 'end', GeneratedMessage.Q6, () => makeLongInt(0))
    ..a(3, 'cost', GeneratedMessage.OM, () => new Cost(), () => new Cost())
  ;

  AllocateIdsResponse() : super();
  AllocateIdsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AllocateIdsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AllocateIdsResponse clone() => new AllocateIdsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Int64 get start => getField(1);
  void set start(Int64 v) { setField(1, v); }
  bool hasStart() => hasField(1);
  void clearStart() => clearField(1);

  Int64 get end => getField(2);
  void set end(Int64 v) { setField(2, v); }
  bool hasEnd() => hasField(2);
  void clearEnd() => clearField(2);

  Cost get cost => getField(3);
  void set cost(Cost v) { setField(3, v); }
  bool hasCost() => hasField(3);
  void clearCost() => clearField(3);
}

class CompositeIndices extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CompositeIndices')
    ..m(1, 'index', () => new CompositeIndex(), () => new PbList<CompositeIndex>())
  ;

  CompositeIndices() : super();
  CompositeIndices.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CompositeIndices.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CompositeIndices clone() => new CompositeIndices()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<CompositeIndex> get index => getField(1);
}

class AddActionsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AddActionsRequest')
    ..a(3, 'header', GeneratedMessage.OM, () => new InternalHeader(), () => new InternalHeader())
    ..a(1, 'transaction', GeneratedMessage.QM, () => new Transaction(), () => new Transaction())
    ..m(2, 'action', () => new Action(), () => new PbList<Action>())
  ;

  AddActionsRequest() : super();
  AddActionsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AddActionsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AddActionsRequest clone() => new AddActionsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  InternalHeader get header => getField(3);
  void set header(InternalHeader v) { setField(3, v); }
  bool hasHeader() => hasField(3);
  void clearHeader() => clearField(3);

  Transaction get transaction => getField(1);
  void set transaction(Transaction v) { setField(1, v); }
  bool hasTransaction() => hasField(1);
  void clearTransaction() => clearField(1);

  List<Action> get action => getField(2);
}

class AddActionsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AddActionsResponse')
    ..hasRequiredFields = false
  ;

  AddActionsResponse() : super();
  AddActionsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AddActionsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AddActionsResponse clone() => new AddActionsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class BeginTransactionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BeginTransactionRequest')
    ..a(3, 'header', GeneratedMessage.OM, () => new InternalHeader(), () => new InternalHeader())
    ..a(1, 'app', GeneratedMessage.QS)
    ..a(2, 'allowMultipleEg', GeneratedMessage.OB)
  ;

  BeginTransactionRequest() : super();
  BeginTransactionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BeginTransactionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BeginTransactionRequest clone() => new BeginTransactionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  InternalHeader get header => getField(3);
  void set header(InternalHeader v) { setField(3, v); }
  bool hasHeader() => hasField(3);
  void clearHeader() => clearField(3);

  String get app => getField(1);
  void set app(String v) { setField(1, v); }
  bool hasApp() => hasField(1);
  void clearApp() => clearField(1);

  bool get allowMultipleEg => getField(2);
  void set allowMultipleEg(bool v) { setField(2, v); }
  bool hasAllowMultipleEg() => hasField(2);
  void clearAllowMultipleEg() => clearField(2);
}

class CommitResponse_Version extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CommitResponse_Version')
    ..a(4, 'rootEntityKey', GeneratedMessage.QM, () => new Reference(), () => new Reference())
    ..a(5, 'version', GeneratedMessage.Q6, () => makeLongInt(0))
  ;

  CommitResponse_Version() : super();
  CommitResponse_Version.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CommitResponse_Version.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CommitResponse_Version clone() => new CommitResponse_Version()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Reference get rootEntityKey => getField(4);
  void set rootEntityKey(Reference v) { setField(4, v); }
  bool hasRootEntityKey() => hasField(4);
  void clearRootEntityKey() => clearField(4);

  Int64 get version => getField(5);
  void set version(Int64 v) { setField(5, v); }
  bool hasVersion() => hasField(5);
  void clearVersion() => clearField(5);
}

class CommitResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CommitResponse')
    ..a(1, 'cost', GeneratedMessage.OM, () => new Cost(), () => new Cost())
    ..a(3, 'version', GeneratedMessage.PG, () => new PbList(), () => new CommitResponse_Version())
    ..hasRequiredFields = false
  ;

  CommitResponse() : super();
  CommitResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CommitResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CommitResponse clone() => new CommitResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Cost get cost => getField(1);
  void set cost(Cost v) { setField(1, v); }
  bool hasCost() => hasField(1);
  void clearCost() => clearField(1);

  List<CommitResponse_Version> get version => getField(3);
}

