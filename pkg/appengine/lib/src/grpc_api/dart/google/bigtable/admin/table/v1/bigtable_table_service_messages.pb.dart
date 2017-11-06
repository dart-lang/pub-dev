///
//  Generated code. Do not modify.
///
library google.bigtable.admin.table.v1_bigtable_table_service_messages;

import 'package:protobuf/protobuf.dart';

import 'bigtable_table_data.pb.dart';

class CreateTableRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateTableRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'tableId', PbFieldType.OS)
    ..a/*<Table>*/(3, 'table', PbFieldType.OM, Table.getDefault, Table.create)
    ..p/*<String>*/(4, 'initialSplitKeys', PbFieldType.PS)
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

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get tableId => $_get(1, 2, '');
  void set tableId(String v) { $_setString(1, 2, v); }
  bool hasTableId() => $_has(1, 2);
  void clearTableId() => clearField(2);

  Table get table => $_get(2, 3, null);
  void set table(Table v) { setField(3, v); }
  bool hasTable() => $_has(2, 3);
  void clearTable() => clearField(3);

  List<String> get initialSplitKeys => $_get(3, 4, null);
}

class _ReadonlyCreateTableRequest extends CreateTableRequest with ReadonlyMessageMixin {}

class ListTablesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTablesRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
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

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyListTablesRequest extends ListTablesRequest with ReadonlyMessageMixin {}

class ListTablesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTablesResponse')
    ..pp/*<Table>*/(1, 'tables', PbFieldType.PM, Table.$checkItem, Table.create)
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
}

class _ReadonlyListTablesResponse extends ListTablesResponse with ReadonlyMessageMixin {}

class GetTableRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetTableRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
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

class RenameTableRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RenameTableRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'newId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  RenameTableRequest() : super();
  RenameTableRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RenameTableRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RenameTableRequest clone() => new RenameTableRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RenameTableRequest create() => new RenameTableRequest();
  static PbList<RenameTableRequest> createRepeated() => new PbList<RenameTableRequest>();
  static RenameTableRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRenameTableRequest();
    return _defaultInstance;
  }
  static RenameTableRequest _defaultInstance;
  static void $checkItem(RenameTableRequest v) {
    if (v is !RenameTableRequest) checkItemFailed(v, 'RenameTableRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get newId => $_get(1, 2, '');
  void set newId(String v) { $_setString(1, 2, v); }
  bool hasNewId() => $_has(1, 2);
  void clearNewId() => clearField(2);
}

class _ReadonlyRenameTableRequest extends RenameTableRequest with ReadonlyMessageMixin {}

class CreateColumnFamilyRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateColumnFamilyRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'columnFamilyId', PbFieldType.OS)
    ..a/*<ColumnFamily>*/(3, 'columnFamily', PbFieldType.OM, ColumnFamily.getDefault, ColumnFamily.create)
    ..hasRequiredFields = false
  ;

  CreateColumnFamilyRequest() : super();
  CreateColumnFamilyRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateColumnFamilyRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateColumnFamilyRequest clone() => new CreateColumnFamilyRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateColumnFamilyRequest create() => new CreateColumnFamilyRequest();
  static PbList<CreateColumnFamilyRequest> createRepeated() => new PbList<CreateColumnFamilyRequest>();
  static CreateColumnFamilyRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateColumnFamilyRequest();
    return _defaultInstance;
  }
  static CreateColumnFamilyRequest _defaultInstance;
  static void $checkItem(CreateColumnFamilyRequest v) {
    if (v is !CreateColumnFamilyRequest) checkItemFailed(v, 'CreateColumnFamilyRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get columnFamilyId => $_get(1, 2, '');
  void set columnFamilyId(String v) { $_setString(1, 2, v); }
  bool hasColumnFamilyId() => $_has(1, 2);
  void clearColumnFamilyId() => clearField(2);

  ColumnFamily get columnFamily => $_get(2, 3, null);
  void set columnFamily(ColumnFamily v) { setField(3, v); }
  bool hasColumnFamily() => $_has(2, 3);
  void clearColumnFamily() => clearField(3);
}

class _ReadonlyCreateColumnFamilyRequest extends CreateColumnFamilyRequest with ReadonlyMessageMixin {}

class DeleteColumnFamilyRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteColumnFamilyRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteColumnFamilyRequest() : super();
  DeleteColumnFamilyRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteColumnFamilyRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteColumnFamilyRequest clone() => new DeleteColumnFamilyRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteColumnFamilyRequest create() => new DeleteColumnFamilyRequest();
  static PbList<DeleteColumnFamilyRequest> createRepeated() => new PbList<DeleteColumnFamilyRequest>();
  static DeleteColumnFamilyRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteColumnFamilyRequest();
    return _defaultInstance;
  }
  static DeleteColumnFamilyRequest _defaultInstance;
  static void $checkItem(DeleteColumnFamilyRequest v) {
    if (v is !DeleteColumnFamilyRequest) checkItemFailed(v, 'DeleteColumnFamilyRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteColumnFamilyRequest extends DeleteColumnFamilyRequest with ReadonlyMessageMixin {}

class BulkDeleteRowsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BulkDeleteRowsRequest')
    ..a/*<String>*/(1, 'tableName', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'rowKeyPrefix', PbFieldType.OY)
    ..a/*<bool>*/(3, 'deleteAllDataFromTable', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  BulkDeleteRowsRequest() : super();
  BulkDeleteRowsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BulkDeleteRowsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BulkDeleteRowsRequest clone() => new BulkDeleteRowsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BulkDeleteRowsRequest create() => new BulkDeleteRowsRequest();
  static PbList<BulkDeleteRowsRequest> createRepeated() => new PbList<BulkDeleteRowsRequest>();
  static BulkDeleteRowsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBulkDeleteRowsRequest();
    return _defaultInstance;
  }
  static BulkDeleteRowsRequest _defaultInstance;
  static void $checkItem(BulkDeleteRowsRequest v) {
    if (v is !BulkDeleteRowsRequest) checkItemFailed(v, 'BulkDeleteRowsRequest');
  }

  String get tableName => $_get(0, 1, '');
  void set tableName(String v) { $_setString(0, 1, v); }
  bool hasTableName() => $_has(0, 1);
  void clearTableName() => clearField(1);

  List<int> get rowKeyPrefix => $_get(1, 2, null);
  void set rowKeyPrefix(List<int> v) { $_setBytes(1, 2, v); }
  bool hasRowKeyPrefix() => $_has(1, 2);
  void clearRowKeyPrefix() => clearField(2);

  bool get deleteAllDataFromTable => $_get(2, 3, false);
  void set deleteAllDataFromTable(bool v) { $_setBool(2, 3, v); }
  bool hasDeleteAllDataFromTable() => $_has(2, 3);
  void clearDeleteAllDataFromTable() => clearField(3);
}

class _ReadonlyBulkDeleteRowsRequest extends BulkDeleteRowsRequest with ReadonlyMessageMixin {}

