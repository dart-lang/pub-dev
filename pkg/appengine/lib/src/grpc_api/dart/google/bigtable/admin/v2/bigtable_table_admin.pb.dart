///
//  Generated code. Do not modify.
///
library google.bigtable.admin.v2_bigtable_table_admin;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'table.pb.dart';
import '../../../protobuf/empty.pb.dart' as google$protobuf;

import 'table.pbenum.dart';

class CreateTableRequest_Split extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateTableRequest_Split')
    ..a/*<List<int>>*/(1, 'key', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  CreateTableRequest_Split() : super();
  CreateTableRequest_Split.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateTableRequest_Split.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateTableRequest_Split clone() => new CreateTableRequest_Split()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateTableRequest_Split create() => new CreateTableRequest_Split();
  static PbList<CreateTableRequest_Split> createRepeated() => new PbList<CreateTableRequest_Split>();
  static CreateTableRequest_Split getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateTableRequest_Split();
    return _defaultInstance;
  }
  static CreateTableRequest_Split _defaultInstance;
  static void $checkItem(CreateTableRequest_Split v) {
    if (v is !CreateTableRequest_Split) checkItemFailed(v, 'CreateTableRequest_Split');
  }

  List<int> get key => $_get(0, 1, null);
  void set key(List<int> v) { $_setBytes(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);
}

class _ReadonlyCreateTableRequest_Split extends CreateTableRequest_Split with ReadonlyMessageMixin {}

class CreateTableRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateTableRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<String>*/(2, 'tableId', PbFieldType.OS)
    ..a/*<Table>*/(3, 'table', PbFieldType.OM, Table.getDefault, Table.create)
    ..pp/*<CreateTableRequest_Split>*/(4, 'initialSplits', PbFieldType.PM, CreateTableRequest_Split.$checkItem, CreateTableRequest_Split.create)
    ..hasRequiredFields = false
  ;

  CreateTableRequest() : super();
  CreateTableRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateTableRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateTableRequest clone() => new CreateTableRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateTableRequest create() => new CreateTableRequest();
  static PbList<CreateTableRequest> createRepeated() => new PbList<CreateTableRequest>();
  static CreateTableRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateTableRequest();
    return _defaultInstance;
  }
  static CreateTableRequest _defaultInstance;
  static void $checkItem(CreateTableRequest v) {
    if (v is !CreateTableRequest) checkItemFailed(v, 'CreateTableRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  String get tableId => $_get(1, 2, '');
  void set tableId(String v) { $_setString(1, 2, v); }
  bool hasTableId() => $_has(1, 2);
  void clearTableId() => clearField(2);

  Table get table => $_get(2, 3, null);
  void set table(Table v) { setField(3, v); }
  bool hasTable() => $_has(2, 3);
  void clearTable() => clearField(3);

  List<CreateTableRequest_Split> get initialSplits => $_get(3, 4, null);
}

class _ReadonlyCreateTableRequest extends CreateTableRequest with ReadonlyMessageMixin {}

class DropRowRangeRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DropRowRangeRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'rowKeyPrefix', PbFieldType.OY)
    ..a/*<bool>*/(3, 'deleteAllDataFromTable', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  DropRowRangeRequest() : super();
  DropRowRangeRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DropRowRangeRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DropRowRangeRequest clone() => new DropRowRangeRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DropRowRangeRequest create() => new DropRowRangeRequest();
  static PbList<DropRowRangeRequest> createRepeated() => new PbList<DropRowRangeRequest>();
  static DropRowRangeRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDropRowRangeRequest();
    return _defaultInstance;
  }
  static DropRowRangeRequest _defaultInstance;
  static void $checkItem(DropRowRangeRequest v) {
    if (v is !DropRowRangeRequest) checkItemFailed(v, 'DropRowRangeRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  List<int> get rowKeyPrefix => $_get(1, 2, null);
  void set rowKeyPrefix(List<int> v) { $_setBytes(1, 2, v); }
  bool hasRowKeyPrefix() => $_has(1, 2);
  void clearRowKeyPrefix() => clearField(2);

  bool get deleteAllDataFromTable => $_get(2, 3, false);
  void set deleteAllDataFromTable(bool v) { $_setBool(2, 3, v); }
  bool hasDeleteAllDataFromTable() => $_has(2, 3);
  void clearDeleteAllDataFromTable() => clearField(3);
}

class _ReadonlyDropRowRangeRequest extends DropRowRangeRequest with ReadonlyMessageMixin {}

class ListTablesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTablesRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..e/*<Table_View>*/(2, 'view', PbFieldType.OE, Table_View.VIEW_UNSPECIFIED, Table_View.valueOf)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListTablesRequest() : super();
  ListTablesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListTablesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListTablesRequest clone() => new ListTablesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListTablesRequest create() => new ListTablesRequest();
  static PbList<ListTablesRequest> createRepeated() => new PbList<ListTablesRequest>();
  static ListTablesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListTablesRequest();
    return _defaultInstance;
  }
  static ListTablesRequest _defaultInstance;
  static void $checkItem(ListTablesRequest v) {
    if (v is !ListTablesRequest) checkItemFailed(v, 'ListTablesRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  Table_View get view => $_get(1, 2, null);
  void set view(Table_View v) { setField(2, v); }
  bool hasView() => $_has(1, 2);
  void clearView() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);
}

class _ReadonlyListTablesRequest extends ListTablesRequest with ReadonlyMessageMixin {}

class ListTablesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTablesResponse')
    ..pp/*<Table>*/(1, 'tables', PbFieldType.PM, Table.$checkItem, Table.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListTablesResponse() : super();
  ListTablesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListTablesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListTablesResponse clone() => new ListTablesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListTablesResponse create() => new ListTablesResponse();
  static PbList<ListTablesResponse> createRepeated() => new PbList<ListTablesResponse>();
  static ListTablesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListTablesResponse();
    return _defaultInstance;
  }
  static ListTablesResponse _defaultInstance;
  static void $checkItem(ListTablesResponse v) {
    if (v is !ListTablesResponse) checkItemFailed(v, 'ListTablesResponse');
  }

  List<Table> get tables => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListTablesResponse extends ListTablesResponse with ReadonlyMessageMixin {}

class GetTableRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetTableRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..e/*<Table_View>*/(2, 'view', PbFieldType.OE, Table_View.VIEW_UNSPECIFIED, Table_View.valueOf)
    ..hasRequiredFields = false
  ;

  GetTableRequest() : super();
  GetTableRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetTableRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetTableRequest clone() => new GetTableRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetTableRequest create() => new GetTableRequest();
  static PbList<GetTableRequest> createRepeated() => new PbList<GetTableRequest>();
  static GetTableRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetTableRequest();
    return _defaultInstance;
  }
  static GetTableRequest _defaultInstance;
  static void $checkItem(GetTableRequest v) {
    if (v is !GetTableRequest) checkItemFailed(v, 'GetTableRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  Table_View get view => $_get(1, 2, null);
  void set view(Table_View v) { setField(2, v); }
  bool hasView() => $_has(1, 2);
  void clearView() => clearField(2);
}

class _ReadonlyGetTableRequest extends GetTableRequest with ReadonlyMessageMixin {}

class DeleteTableRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteTableRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteTableRequest() : super();
  DeleteTableRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteTableRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteTableRequest clone() => new DeleteTableRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteTableRequest create() => new DeleteTableRequest();
  static PbList<DeleteTableRequest> createRepeated() => new PbList<DeleteTableRequest>();
  static DeleteTableRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteTableRequest();
    return _defaultInstance;
  }
  static DeleteTableRequest _defaultInstance;
  static void $checkItem(DeleteTableRequest v) {
    if (v is !DeleteTableRequest) checkItemFailed(v, 'DeleteTableRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteTableRequest extends DeleteTableRequest with ReadonlyMessageMixin {}

class ModifyColumnFamiliesRequest_Modification extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ModifyColumnFamiliesRequest_Modification')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..a/*<ColumnFamily>*/(2, 'create_2', PbFieldType.OM, ColumnFamily.getDefault, ColumnFamily.create)
    ..a/*<ColumnFamily>*/(3, 'update', PbFieldType.OM, ColumnFamily.getDefault, ColumnFamily.create)
    ..a/*<bool>*/(4, 'drop', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  ModifyColumnFamiliesRequest_Modification() : super();
  ModifyColumnFamiliesRequest_Modification.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ModifyColumnFamiliesRequest_Modification.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ModifyColumnFamiliesRequest_Modification clone() => new ModifyColumnFamiliesRequest_Modification()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ModifyColumnFamiliesRequest_Modification create() => new ModifyColumnFamiliesRequest_Modification();
  static PbList<ModifyColumnFamiliesRequest_Modification> createRepeated() => new PbList<ModifyColumnFamiliesRequest_Modification>();
  static ModifyColumnFamiliesRequest_Modification getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyModifyColumnFamiliesRequest_Modification();
    return _defaultInstance;
  }
  static ModifyColumnFamiliesRequest_Modification _defaultInstance;
  static void $checkItem(ModifyColumnFamiliesRequest_Modification v) {
    if (v is !ModifyColumnFamiliesRequest_Modification) checkItemFailed(v, 'ModifyColumnFamiliesRequest_Modification');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  ColumnFamily get create_2 => $_get(1, 2, null);
  void set create_2(ColumnFamily v) { setField(2, v); }
  bool hasCreate_2() => $_has(1, 2);
  void clearCreate_2() => clearField(2);

  ColumnFamily get update => $_get(2, 3, null);
  void set update(ColumnFamily v) { setField(3, v); }
  bool hasUpdate() => $_has(2, 3);
  void clearUpdate() => clearField(3);

  bool get drop => $_get(3, 4, false);
  void set drop(bool v) { $_setBool(3, 4, v); }
  bool hasDrop() => $_has(3, 4);
  void clearDrop() => clearField(4);
}

class _ReadonlyModifyColumnFamiliesRequest_Modification extends ModifyColumnFamiliesRequest_Modification with ReadonlyMessageMixin {}

class ModifyColumnFamiliesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ModifyColumnFamiliesRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..pp/*<ModifyColumnFamiliesRequest_Modification>*/(2, 'modifications', PbFieldType.PM, ModifyColumnFamiliesRequest_Modification.$checkItem, ModifyColumnFamiliesRequest_Modification.create)
    ..hasRequiredFields = false
  ;

  ModifyColumnFamiliesRequest() : super();
  ModifyColumnFamiliesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ModifyColumnFamiliesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ModifyColumnFamiliesRequest clone() => new ModifyColumnFamiliesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ModifyColumnFamiliesRequest create() => new ModifyColumnFamiliesRequest();
  static PbList<ModifyColumnFamiliesRequest> createRepeated() => new PbList<ModifyColumnFamiliesRequest>();
  static ModifyColumnFamiliesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyModifyColumnFamiliesRequest();
    return _defaultInstance;
  }
  static ModifyColumnFamiliesRequest _defaultInstance;
  static void $checkItem(ModifyColumnFamiliesRequest v) {
    if (v is !ModifyColumnFamiliesRequest) checkItemFailed(v, 'ModifyColumnFamiliesRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  List<ModifyColumnFamiliesRequest_Modification> get modifications => $_get(1, 2, null);
}

class _ReadonlyModifyColumnFamiliesRequest extends ModifyColumnFamiliesRequest with ReadonlyMessageMixin {}

class BigtableTableAdminApi {
  RpcClient _client;
  BigtableTableAdminApi(this._client);

  Future<Table> createTable(ClientContext ctx, CreateTableRequest request) {
    var emptyResponse = new Table();
    return _client.invoke(ctx, 'BigtableTableAdmin', 'CreateTable', request, emptyResponse);
  }
  Future<ListTablesResponse> listTables(ClientContext ctx, ListTablesRequest request) {
    var emptyResponse = new ListTablesResponse();
    return _client.invoke(ctx, 'BigtableTableAdmin', 'ListTables', request, emptyResponse);
  }
  Future<Table> getTable(ClientContext ctx, GetTableRequest request) {
    var emptyResponse = new Table();
    return _client.invoke(ctx, 'BigtableTableAdmin', 'GetTable', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteTable(ClientContext ctx, DeleteTableRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'BigtableTableAdmin', 'DeleteTable', request, emptyResponse);
  }
  Future<Table> modifyColumnFamilies(ClientContext ctx, ModifyColumnFamiliesRequest request) {
    var emptyResponse = new Table();
    return _client.invoke(ctx, 'BigtableTableAdmin', 'ModifyColumnFamilies', request, emptyResponse);
  }
  Future<google$protobuf.Empty> dropRowRange(ClientContext ctx, DropRowRangeRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'BigtableTableAdmin', 'DropRowRange', request, emptyResponse);
  }
}

