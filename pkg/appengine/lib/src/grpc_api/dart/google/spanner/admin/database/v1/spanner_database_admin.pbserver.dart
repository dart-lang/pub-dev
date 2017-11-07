///
//  Generated code. Do not modify.
///
library google.spanner.admin.database.v1_spanner_database_admin_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'spanner_database_admin.pb.dart';
import '../../../../longrunning/operations.pb.dart' as google$longrunning;
import '../../../../protobuf/empty.pb.dart' as google$protobuf;
import '../../../../iam/v1/iam_policy.pb.dart' as google$iam$v1;
import '../../../../iam/v1/policy.pb.dart' as google$iam$v1;
import 'spanner_database_admin.pbjson.dart';

export 'spanner_database_admin.pb.dart';

abstract class DatabaseAdminServiceBase extends GeneratedService {
  Future<ListDatabasesResponse> listDatabases(ServerContext ctx, ListDatabasesRequest request);
  Future<google$longrunning.Operation> createDatabase(ServerContext ctx, CreateDatabaseRequest request);
  Future<Database> getDatabase(ServerContext ctx, GetDatabaseRequest request);
  Future<google$longrunning.Operation> updateDatabaseDdl(ServerContext ctx, UpdateDatabaseDdlRequest request);
  Future<google$protobuf.Empty> dropDatabase(ServerContext ctx, DropDatabaseRequest request);
  Future<GetDatabaseDdlResponse> getDatabaseDdl(ServerContext ctx, GetDatabaseDdlRequest request);
  Future<google$iam$v1.Policy> setIamPolicy(ServerContext ctx, google$iam$v1.SetIamPolicyRequest request);
  Future<google$iam$v1.Policy> getIamPolicy(ServerContext ctx, google$iam$v1.GetIamPolicyRequest request);
  Future<google$iam$v1.TestIamPermissionsResponse> testIamPermissions(ServerContext ctx, google$iam$v1.TestIamPermissionsRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListDatabases': return new ListDatabasesRequest();
      case 'CreateDatabase': return new CreateDatabaseRequest();
      case 'GetDatabase': return new GetDatabaseRequest();
      case 'UpdateDatabaseDdl': return new UpdateDatabaseDdlRequest();
      case 'DropDatabase': return new DropDatabaseRequest();
      case 'GetDatabaseDdl': return new GetDatabaseDdlRequest();
      case 'SetIamPolicy': return new google$iam$v1.SetIamPolicyRequest();
      case 'GetIamPolicy': return new google$iam$v1.GetIamPolicyRequest();
      case 'TestIamPermissions': return new google$iam$v1.TestIamPermissionsRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListDatabases': return this.listDatabases(ctx, request);
      case 'CreateDatabase': return this.createDatabase(ctx, request);
      case 'GetDatabase': return this.getDatabase(ctx, request);
      case 'UpdateDatabaseDdl': return this.updateDatabaseDdl(ctx, request);
      case 'DropDatabase': return this.dropDatabase(ctx, request);
      case 'GetDatabaseDdl': return this.getDatabaseDdl(ctx, request);
      case 'SetIamPolicy': return this.setIamPolicy(ctx, request);
      case 'GetIamPolicy': return this.getIamPolicy(ctx, request);
      case 'TestIamPermissions': return this.testIamPermissions(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => DatabaseAdmin$json;
  Map<String, dynamic> get $messageJson => DatabaseAdmin$messageJson;
}

