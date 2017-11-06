///
//  Generated code. Do not modify.
///
library google.monitoring.v3_group;

import 'package:protobuf/protobuf.dart';

class Group extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Group')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'displayName', PbFieldType.OS)
    ..a/*<String>*/(3, 'parentName', PbFieldType.OS)
    ..a/*<String>*/(5, 'filter', PbFieldType.OS)
    ..a/*<bool>*/(6, 'isCluster', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  Group() : super();
  Group.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Group.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Group clone() => new Group()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Group create() => new Group();
  static PbList<Group> createRepeated() => new PbList<Group>();
  static Group getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGroup();
    return _defaultInstance;
  }
  static Group _defaultInstance;
  static void $checkItem(Group v) {
    if (v is !Group) checkItemFailed(v, 'Group');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get displayName => $_get(1, 2, '');
  void set displayName(String v) { $_setString(1, 2, v); }
  bool hasDisplayName() => $_has(1, 2);
  void clearDisplayName() => clearField(2);

  String get parentName => $_get(2, 3, '');
  void set parentName(String v) { $_setString(2, 3, v); }
  bool hasParentName() => $_has(2, 3);
  void clearParentName() => clearField(3);

  String get filter => $_get(3, 5, '');
  void set filter(String v) { $_setString(3, 5, v); }
  bool hasFilter() => $_has(3, 5);
  void clearFilter() => clearField(5);

  bool get isCluster => $_get(4, 6, false);
  void set isCluster(bool v) { $_setBool(4, 6, v); }
  bool hasIsCluster() => $_has(4, 6);
  void clearIsCluster() => clearField(6);
}

class _ReadonlyGroup extends Group with ReadonlyMessageMixin {}

