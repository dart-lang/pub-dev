///
//  Generated code. Do not modify.
///
library google.spanner.v1_mutation;

import 'package:protobuf/protobuf.dart';

import '../../protobuf/struct.pb.dart' as google$protobuf;
import 'keys.pb.dart';

class Mutation_Write extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Mutation_Write')
    ..a/*<String>*/(1, 'table', PbFieldType.OS)
    ..p/*<String>*/(2, 'columns', PbFieldType.PS)
    ..pp/*<google$protobuf.ListValue>*/(3, 'values', PbFieldType.PM, google$protobuf.ListValue.$checkItem, google$protobuf.ListValue.create)
    ..hasRequiredFields = false
  ;

  Mutation_Write() : super();
  Mutation_Write.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Mutation_Write.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Mutation_Write clone() => new Mutation_Write()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Mutation_Write create() => new Mutation_Write();
  static PbList<Mutation_Write> createRepeated() => new PbList<Mutation_Write>();
  static Mutation_Write getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMutation_Write();
    return _defaultInstance;
  }
  static Mutation_Write _defaultInstance;
  static void $checkItem(Mutation_Write v) {
    if (v is !Mutation_Write) checkItemFailed(v, 'Mutation_Write');
  }

  String get table => $_get(0, 1, '');
  void set table(String v) { $_setString(0, 1, v); }
  bool hasTable() => $_has(0, 1);
  void clearTable() => clearField(1);

  List<String> get columns => $_get(1, 2, null);

  List<google$protobuf.ListValue> get values => $_get(2, 3, null);
}

class _ReadonlyMutation_Write extends Mutation_Write with ReadonlyMessageMixin {}

class Mutation_Delete extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Mutation_Delete')
    ..a/*<String>*/(1, 'table', PbFieldType.OS)
    ..a/*<KeySet>*/(2, 'keySet', PbFieldType.OM, KeySet.getDefault, KeySet.create)
    ..hasRequiredFields = false
  ;

  Mutation_Delete() : super();
  Mutation_Delete.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Mutation_Delete.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Mutation_Delete clone() => new Mutation_Delete()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Mutation_Delete create() => new Mutation_Delete();
  static PbList<Mutation_Delete> createRepeated() => new PbList<Mutation_Delete>();
  static Mutation_Delete getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMutation_Delete();
    return _defaultInstance;
  }
  static Mutation_Delete _defaultInstance;
  static void $checkItem(Mutation_Delete v) {
    if (v is !Mutation_Delete) checkItemFailed(v, 'Mutation_Delete');
  }

  String get table => $_get(0, 1, '');
  void set table(String v) { $_setString(0, 1, v); }
  bool hasTable() => $_has(0, 1);
  void clearTable() => clearField(1);

  KeySet get keySet => $_get(1, 2, null);
  void set keySet(KeySet v) { setField(2, v); }
  bool hasKeySet() => $_has(1, 2);
  void clearKeySet() => clearField(2);
}

class _ReadonlyMutation_Delete extends Mutation_Delete with ReadonlyMessageMixin {}

class Mutation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Mutation')
    ..a/*<Mutation_Write>*/(1, 'insert', PbFieldType.OM, Mutation_Write.getDefault, Mutation_Write.create)
    ..a/*<Mutation_Write>*/(2, 'update', PbFieldType.OM, Mutation_Write.getDefault, Mutation_Write.create)
    ..a/*<Mutation_Write>*/(3, 'insertOrUpdate', PbFieldType.OM, Mutation_Write.getDefault, Mutation_Write.create)
    ..a/*<Mutation_Write>*/(4, 'replace', PbFieldType.OM, Mutation_Write.getDefault, Mutation_Write.create)
    ..a/*<Mutation_Delete>*/(5, 'delete', PbFieldType.OM, Mutation_Delete.getDefault, Mutation_Delete.create)
    ..hasRequiredFields = false
  ;

  Mutation() : super();
  Mutation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Mutation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Mutation clone() => new Mutation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Mutation create() => new Mutation();
  static PbList<Mutation> createRepeated() => new PbList<Mutation>();
  static Mutation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMutation();
    return _defaultInstance;
  }
  static Mutation _defaultInstance;
  static void $checkItem(Mutation v) {
    if (v is !Mutation) checkItemFailed(v, 'Mutation');
  }

  Mutation_Write get insert => $_get(0, 1, null);
  void set insert(Mutation_Write v) { setField(1, v); }
  bool hasInsert() => $_has(0, 1);
  void clearInsert() => clearField(1);

  Mutation_Write get update => $_get(1, 2, null);
  void set update(Mutation_Write v) { setField(2, v); }
  bool hasUpdate() => $_has(1, 2);
  void clearUpdate() => clearField(2);

  Mutation_Write get insertOrUpdate => $_get(2, 3, null);
  void set insertOrUpdate(Mutation_Write v) { setField(3, v); }
  bool hasInsertOrUpdate() => $_has(2, 3);
  void clearInsertOrUpdate() => clearField(3);

  Mutation_Write get replace => $_get(3, 4, null);
  void set replace(Mutation_Write v) { setField(4, v); }
  bool hasReplace() => $_has(3, 4);
  void clearReplace() => clearField(4);

  Mutation_Delete get delete => $_get(4, 5, null);
  void set delete(Mutation_Delete v) { setField(5, v); }
  bool hasDelete() => $_has(4, 5);
  void clearDelete() => clearField(5);
}

class _ReadonlyMutation extends Mutation with ReadonlyMessageMixin {}

