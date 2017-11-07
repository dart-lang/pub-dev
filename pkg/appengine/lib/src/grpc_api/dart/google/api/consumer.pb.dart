///
//  Generated code. Do not modify.
///
library google.api_consumer;

import 'package:protobuf/protobuf.dart';

import 'consumer.pbenum.dart';

export 'consumer.pbenum.dart';

class ProjectProperties extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ProjectProperties')
    ..pp/*<Property>*/(1, 'properties', PbFieldType.PM, Property.$checkItem, Property.create)
    ..hasRequiredFields = false
  ;

  ProjectProperties() : super();
  ProjectProperties.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ProjectProperties.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ProjectProperties clone() => new ProjectProperties()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ProjectProperties create() => new ProjectProperties();
  static PbList<ProjectProperties> createRepeated() => new PbList<ProjectProperties>();
  static ProjectProperties getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyProjectProperties();
    return _defaultInstance;
  }
  static ProjectProperties _defaultInstance;
  static void $checkItem(ProjectProperties v) {
    if (v is !ProjectProperties) checkItemFailed(v, 'ProjectProperties');
  }

  List<Property> get properties => $_get(0, 1, null);
}

class _ReadonlyProjectProperties extends ProjectProperties with ReadonlyMessageMixin {}

class Property extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Property')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..e/*<Property_PropertyType>*/(2, 'type', PbFieldType.OE, Property_PropertyType.UNSPECIFIED, Property_PropertyType.valueOf)
    ..a/*<String>*/(3, 'description', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Property() : super();
  Property.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Property.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Property clone() => new Property()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Property create() => new Property();
  static PbList<Property> createRepeated() => new PbList<Property>();
  static Property getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyProperty();
    return _defaultInstance;
  }
  static Property _defaultInstance;
  static void $checkItem(Property v) {
    if (v is !Property) checkItemFailed(v, 'Property');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  Property_PropertyType get type => $_get(1, 2, null);
  void set type(Property_PropertyType v) { setField(2, v); }
  bool hasType() => $_has(1, 2);
  void clearType() => clearField(2);

  String get description => $_get(2, 3, '');
  void set description(String v) { $_setString(2, 3, v); }
  bool hasDescription() => $_has(2, 3);
  void clearDescription() => clearField(3);
}

class _ReadonlyProperty extends Property with ReadonlyMessageMixin {}

