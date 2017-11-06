///
//  Generated code. Do not modify.
///
library google.spanner.admin.database.v1_spanner_database_admin;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../../../longrunning/operations.pb.dart' as google$longrunning;
import '../../../../protobuf/empty.pb.dart' as google$protobuf;
import '../../../../iam/v1/iam_policy.pb.dart' as google$iam$v1;
import '../../../../iam/v1/policy.pb.dart' as google$iam$v1;

import 'spanner_database_admin.pbenum.dart';

export 'spanner_database_admin.pbenum.dart';

class Database extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Database')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..e/*<Database_State>*/(2, 'state', PbFieldType.OE, Database_State.STATE_UNSPECIFIED, Database_State.valueOf)
    ..hasRequiredFields = false
  ;

  Database() : super();
  Database.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Database.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Database clone() => new Database()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Database create() => new Database();
  static PbList<Database> createRepeated() => new PbList<Database>();
  static Database getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDatabase();
    return _defaultInstance;
  }
  static Database _defaultInstance;
  static void $checkItem(Database v) {
    if (v is !Database) checkItemFailed(v, 'Database');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  Database_State get state => $_get(1, 2, null);
  void set state(Database_State v) { setField(2, v); }
  bool hasState() => $_has(1, 2);
  void clearState() => clearField(2);
}

class _ReadonlyDatabase extends Database with ReadonlyMessageMixin {}

class ListDatabasesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListDatabasesRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<int>*/(3, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(4, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListDatabasesRequest() : super();
  ListDatabasesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListDatabasesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListDatabasesRequest clone() => new ListDatabasesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListDatabasesRequest create() => new ListDatabasesRequest();
  static PbList<ListDatabasesRequest> createRepeated() => new PbList<ListDatabasesRequest>();
  static ListDatabasesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListDatabasesRequest();
    return _defaultInstance;
  }
  static ListDatabasesRequest _defaultInstance;
  static void $checkItem(ListDatabasesRequest v) {
    if (v is !ListDatabasesRequest) checkItemFailed(v, 'ListDatabasesRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  int get pageSize => $_get(1, 3, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 3, v); }
  bool hasPageSize() => $_has(1, 3);
  void clearPageSize() => clearField(3);

  String get pageToken => $_get(2, 4, '');
  void set pageToken(String v) { $_setString(2, 4, v); }
  bool hasPageToken() => $_has(2, 4);
  void clearPageToken() => clearField(4);
}

class _ReadonlyListDatabasesRequest extends ListDatabasesRequest with ReadonlyMessageMixin {}

class ListDatabasesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListDatabasesResponse')
    ..pp/*<Database>*/(1, 'databases', PbFieldType.PM, Database.$checkItem, Database.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListDatabasesResponse() : super();
  ListDatabasesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListDatabasesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListDatabasesResponse clone() => new ListDatabasesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListDatabasesResponse create() => new ListDatabasesResponse();
  static PbList<ListDatabasesResponse> createRepeated() => new PbList<ListDatabasesResponse>();
  static ListDatabasesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListDatabasesResponse();
    return _defaultInstance;
  }
  static ListDatabasesResponse _defaultInstance;
  static void $checkItem(ListDatabasesResponse v) {
    if (v is !ListDatabasesResponse) checkItemFailed(v, 'ListDatabasesResponse');
  }

  List<Database> get databases => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListDatabasesResponse extends ListDatabasesResponse with ReadonlyMessageMixin {}

class CreateDatabaseRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateDatabaseRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<String>*/(2, 'createStatement', PbFieldType.OS)
    ..p/*<String>*/(3, 'extraStatements', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  CreateDatabaseRequest() : super();
  CreateDatabaseRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateDatabaseRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateDatabaseRequest clone() => new CreateDatabaseRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateDatabaseRequest create() => new CreateDatabaseRequest();
  static PbList<CreateDatabaseRequest> createRepeated() => new PbList<CreateDatabaseRequest>();
  static CreateDatabaseRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateDatabaseRequest();
    return _defaultInstance;
  }
  static CreateDatabaseRequest _defaultInstance;
  static void $checkItem(CreateDatabaseRequest v) {
    if (v is !CreateDatabaseRequest) checkItemFailed(v, 'CreateDatabaseRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  String get createStatement => $_get(1, 2, '');
  void set createStatement(String v) { $_setString(1, 2, v); }
  bool hasCreateStatement() => $_has(1, 2);
  void clearCreateStatement() => clearField(2);

  List<String> get extraStatements => $_get(2, 3, null);
}

class _ReadonlyCreateDatabaseRequest extends CreateDatabaseRequest with ReadonlyMessageMixin {}

class CreateDatabaseMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateDatabaseMetadata')
    ..a/*<String>*/(1, 'database', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CreateDatabaseMetadata() : super();
  CreateDatabaseMetadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateDatabaseMetadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateDatabaseMetadata clone() => new CreateDatabaseMetadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateDatabaseMetadata create() => new CreateDatabaseMetadata();
  static PbList<CreateDatabaseMetadata> createRepeated() => new PbList<CreateDatabaseMetadata>();
  static CreateDatabaseMetadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateDatabaseMetadata();
    return _defaultInstance;
  }
  static CreateDatabaseMetadata _defaultInstance;
  static void $checkItem(CreateDatabaseMetadata v) {
    if (v is !CreateDatabaseMetadata) checkItemFailed(v, 'CreateDatabaseMetadata');
  }

  String get database => $_get(0, 1, '');
  void set database(String v) { $_setString(0, 1, v); }
  bool hasDatabase() => $_has(0, 1);
  void clearDatabase() => clearField(1);
}

class _ReadonlyCreateDatabaseMetadata extends CreateDatabaseMetadata with ReadonlyMessageMixin {}

class GetDatabaseRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetDatabaseRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetDatabaseRequest() : super();
  GetDatabaseRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetDatabaseRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetDatabaseRequest clone() => new GetDatabaseRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetDatabaseRequest create() => new GetDatabaseRequest();
  static PbList<GetDatabaseRequest> createRepeated() => new PbList<GetDatabaseRequest>();
  static GetDatabaseRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetDatabaseRequest();
    return _defaultInstance;
  }
  static GetDatabaseRequest _defaultInstance;
  static void $checkItem(GetDatabaseRequest v) {
    if (v is !GetDatabaseRequest) checkItemFailed(v, 'GetDatabaseRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetDatabaseRequest extends GetDatabaseRequest with ReadonlyMessageMixin {}

class UpdateDatabaseDdlRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateDatabaseDdlRequest')
    ..a/*<String>*/(1, 'database', PbFieldType.OS)
    ..p/*<String>*/(2, 'statements', PbFieldType.PS)
    ..a/*<String>*/(3, 'operationId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  UpdateDatabaseDdlRequest() : super();
  UpdateDatabaseDdlRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateDatabaseDdlRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateDatabaseDdlRequest clone() => new UpdateDatabaseDdlRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateDatabaseDdlRequest create() => new UpdateDatabaseDdlRequest();
  static PbList<UpdateDatabaseDdlRequest> createRepeated() => new PbList<UpdateDatabaseDdlRequest>();
  static UpdateDatabaseDdlRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateDatabaseDdlRequest();
    return _defaultInstance;
  }
  static UpdateDatabaseDdlRequest _defaultInstance;
  static void $checkItem(UpdateDatabaseDdlRequest v) {
    if (v is !UpdateDatabaseDdlRequest) checkItemFailed(v, 'UpdateDatabaseDdlRequest');
  }

  String get database => $_get(0, 1, '');
  void set database(String v) { $_setString(0, 1, v); }
  bool hasDatabase() => $_has(0, 1);
  void clearDatabase() => clearField(1);

  List<String> get statements => $_get(1, 2, null);

  String get operationId => $_get(2, 3, '');
  void set operationId(String v) { $_setString(2, 3, v); }
  bool hasOperationId() => $_has(2, 3);
  void clearOperationId() => clearField(3);
}

class _ReadonlyUpdateDatabaseDdlRequest extends UpdateDatabaseDdlRequest with ReadonlyMessageMixin {}

class UpdateDatabaseDdlMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateDatabaseDdlMetadata')
    ..a/*<String>*/(1, 'database', PbFieldType.OS)
    ..p/*<String>*/(2, 'statements', PbFieldType.PS)
    ..pp/*<google$protobuf.Timestamp>*/(3, 'commitTimestamps', PbFieldType.PM, google$protobuf.Timestamp.$checkItem, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  UpdateDatabaseDdlMetadata() : super();
  UpdateDatabaseDdlMetadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateDatabaseDdlMetadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateDatabaseDdlMetadata clone() => new UpdateDatabaseDdlMetadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateDatabaseDdlMetadata create() => new UpdateDatabaseDdlMetadata();
  static PbList<UpdateDatabaseDdlMetadata> createRepeated() => new PbList<UpdateDatabaseDdlMetadata>();
  static UpdateDatabaseDdlMetadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateDatabaseDdlMetadata();
    return _defaultInstance;
  }
  static UpdateDatabaseDdlMetadata _defaultInstance;
  static void $checkItem(UpdateDatabaseDdlMetadata v) {
    if (v is !UpdateDatabaseDdlMetadata) checkItemFailed(v, 'UpdateDatabaseDdlMetadata');
  }

  String get database => $_get(0, 1, '');
  void set database(String v) { $_setString(0, 1, v); }
  bool hasDatabase() => $_has(0, 1);
  void clearDatabase() => clearField(1);

  List<String> get statements => $_get(1, 2, null);

  List<google$protobuf.Timestamp> get commitTimestamps => $_get(2, 3, null);
}

class _ReadonlyUpdateDatabaseDdlMetadata extends UpdateDatabaseDdlMetadata with ReadonlyMessageMixin {}

class DropDatabaseRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DropDatabaseRequest')
    ..a/*<String>*/(1, 'database', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DropDatabaseRequest() : super();
  DropDatabaseRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DropDatabaseRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DropDatabaseRequest clone() => new DropDatabaseRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DropDatabaseRequest create() => new DropDatabaseRequest();
  static PbList<DropDatabaseRequest> createRepeated() => new PbList<DropDatabaseRequest>();
  static DropDatabaseRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDropDatabaseRequest();
    return _defaultInstance;
  }
  static DropDatabaseRequest _defaultInstance;
  static void $checkItem(DropDatabaseRequest v) {
    if (v is !DropDatabaseRequest) checkItemFailed(v, 'DropDatabaseRequest');
  }

  String get database => $_get(0, 1, '');
  void set database(String v) { $_setString(0, 1, v); }
  bool hasDatabase() => $_has(0, 1);
  void clearDatabase() => clearField(1);
}

class _ReadonlyDropDatabaseRequest extends DropDatabaseRequest with ReadonlyMessageMixin {}

class GetDatabaseDdlRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetDatabaseDdlRequest')
    ..a/*<String>*/(1, 'database', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetDatabaseDdlRequest() : super();
  GetDatabaseDdlRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetDatabaseDdlRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetDatabaseDdlRequest clone() => new GetDatabaseDdlRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetDatabaseDdlRequest create() => new GetDatabaseDdlRequest();
  static PbList<GetDatabaseDdlRequest> createRepeated() => new PbList<GetDatabaseDdlRequest>();
  static GetDatabaseDdlRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetDatabaseDdlRequest();
    return _defaultInstance;
  }
  static GetDatabaseDdlRequest _defaultInstance;
  static void $checkItem(GetDatabaseDdlRequest v) {
    if (v is !GetDatabaseDdlRequest) checkItemFailed(v, 'GetDatabaseDdlRequest');
  }

  String get database => $_get(0, 1, '');
  void set database(String v) { $_setString(0, 1, v); }
  bool hasDatabase() => $_has(0, 1);
  void clearDatabase() => clearField(1);
}

class _ReadonlyGetDatabaseDdlRequest extends GetDatabaseDdlRequest with ReadonlyMessageMixin {}

class GetDatabaseDdlResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetDatabaseDdlResponse')
    ..p/*<String>*/(1, 'statements', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  GetDatabaseDdlResponse() : super();
  GetDatabaseDdlResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetDatabaseDdlResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetDatabaseDdlResponse clone() => new GetDatabaseDdlResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetDatabaseDdlResponse create() => new GetDatabaseDdlResponse();
  static PbList<GetDatabaseDdlResponse> createRepeated() => new PbList<GetDatabaseDdlResponse>();
  static GetDatabaseDdlResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetDatabaseDdlResponse();
    return _defaultInstance;
  }
  static GetDatabaseDdlResponse _defaultInstance;
  static void $checkItem(GetDatabaseDdlResponse v) {
    if (v is !GetDatabaseDdlResponse) checkItemFailed(v, 'GetDatabaseDdlResponse');
  }

  List<String> get statements => $_get(0, 1, null);
}

class _ReadonlyGetDatabaseDdlResponse extends GetDatabaseDdlResponse with ReadonlyMessageMixin {}

class DatabaseAdminApi {
  RpcClient _client;
  DatabaseAdminApi(this._client);

  Future<ListDatabasesResponse> listDatabases(ClientContext ctx, ListDatabasesRequest request) {
    var emptyResponse = new ListDatabasesResponse();
    return _client.invoke(ctx, 'DatabaseAdmin', 'ListDatabases', request, emptyResponse);
  }
  Future<google$longrunning.Operation> createDatabase(ClientContext ctx, CreateDatabaseRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'DatabaseAdmin', 'CreateDatabase', request, emptyResponse);
  }
  Future<Database> getDatabase(ClientContext ctx, GetDatabaseRequest request) {
    var emptyResponse = new Database();
    return _client.invoke(ctx, 'DatabaseAdmin', 'GetDatabase', request, emptyResponse);
  }
  Future<google$longrunning.Operation> updateDatabaseDdl(ClientContext ctx, UpdateDatabaseDdlRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'DatabaseAdmin', 'UpdateDatabaseDdl', request, emptyResponse);
  }
  Future<google$protobuf.Empty> dropDatabase(ClientContext ctx, DropDatabaseRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'DatabaseAdmin', 'DropDatabase', request, emptyResponse);
  }
  Future<GetDatabaseDdlResponse> getDatabaseDdl(ClientContext ctx, GetDatabaseDdlRequest request) {
    var emptyResponse = new GetDatabaseDdlResponse();
    return _client.invoke(ctx, 'DatabaseAdmin', 'GetDatabaseDdl', request, emptyResponse);
  }
  Future<google$iam$v1.Policy> setIamPolicy(ClientContext ctx, google$iam$v1.SetIamPolicyRequest request) {
    var emptyResponse = new google$iam$v1.Policy();
    return _client.invoke(ctx, 'DatabaseAdmin', 'SetIamPolicy', request, emptyResponse);
  }
  Future<google$iam$v1.Policy> getIamPolicy(ClientContext ctx, google$iam$v1.GetIamPolicyRequest request) {
    var emptyResponse = new google$iam$v1.Policy();
    return _client.invoke(ctx, 'DatabaseAdmin', 'GetIamPolicy', request, emptyResponse);
  }
  Future<google$iam$v1.TestIamPermissionsResponse> testIamPermissions(ClientContext ctx, google$iam$v1.TestIamPermissionsRequest request) {
    var emptyResponse = new google$iam$v1.TestIamPermissionsResponse();
    return _client.invoke(ctx, 'DatabaseAdmin', 'TestIamPermissions', request, emptyResponse);
  }
}

