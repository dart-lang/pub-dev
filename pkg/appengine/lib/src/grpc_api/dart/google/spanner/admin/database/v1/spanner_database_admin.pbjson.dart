///
//  Generated code. Do not modify.
///
library google.spanner.admin.database.v1_spanner_database_admin_pbjson;

import '../../../../longrunning/operations.pbjson.dart' as google$longrunning;
import '../../../../protobuf/any.pbjson.dart' as google$protobuf;
import '../../../../rpc/status.pbjson.dart' as google$rpc;
import '../../../../protobuf/empty.pbjson.dart' as google$protobuf;
import '../../../../iam/v1/iam_policy.pbjson.dart' as google$iam$v1;
import '../../../../iam/v1/policy.pbjson.dart' as google$iam$v1;

const Database$json = const {
  '1': 'Database',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'state', '3': 2, '4': 1, '5': 14, '6': '.google.spanner.admin.database.v1.Database.State'},
  ],
  '4': const [Database_State$json],
};

const Database_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'STATE_UNSPECIFIED', '2': 0},
    const {'1': 'CREATING', '2': 1},
    const {'1': 'READY', '2': 2},
  ],
};

const ListDatabasesRequest$json = const {
  '1': 'ListDatabasesRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 4, '4': 1, '5': 9},
  ],
};

const ListDatabasesResponse$json = const {
  '1': 'ListDatabasesResponse',
  '2': const [
    const {'1': 'databases', '3': 1, '4': 3, '5': 11, '6': '.google.spanner.admin.database.v1.Database'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const CreateDatabaseRequest$json = const {
  '1': 'CreateDatabaseRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'create_statement', '3': 2, '4': 1, '5': 9},
    const {'1': 'extra_statements', '3': 3, '4': 3, '5': 9},
  ],
};

const CreateDatabaseMetadata$json = const {
  '1': 'CreateDatabaseMetadata',
  '2': const [
    const {'1': 'database', '3': 1, '4': 1, '5': 9},
  ],
};

const GetDatabaseRequest$json = const {
  '1': 'GetDatabaseRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const UpdateDatabaseDdlRequest$json = const {
  '1': 'UpdateDatabaseDdlRequest',
  '2': const [
    const {'1': 'database', '3': 1, '4': 1, '5': 9},
    const {'1': 'statements', '3': 2, '4': 3, '5': 9},
    const {'1': 'operation_id', '3': 3, '4': 1, '5': 9},
  ],
};

const UpdateDatabaseDdlMetadata$json = const {
  '1': 'UpdateDatabaseDdlMetadata',
  '2': const [
    const {'1': 'database', '3': 1, '4': 1, '5': 9},
    const {'1': 'statements', '3': 2, '4': 3, '5': 9},
    const {'1': 'commit_timestamps', '3': 3, '4': 3, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const DropDatabaseRequest$json = const {
  '1': 'DropDatabaseRequest',
  '2': const [
    const {'1': 'database', '3': 1, '4': 1, '5': 9},
  ],
};

const GetDatabaseDdlRequest$json = const {
  '1': 'GetDatabaseDdlRequest',
  '2': const [
    const {'1': 'database', '3': 1, '4': 1, '5': 9},
  ],
};

const GetDatabaseDdlResponse$json = const {
  '1': 'GetDatabaseDdlResponse',
  '2': const [
    const {'1': 'statements', '3': 1, '4': 3, '5': 9},
  ],
};

const DatabaseAdmin$json = const {
  '1': 'DatabaseAdmin',
  '2': const [
    const {'1': 'ListDatabases', '2': '.google.spanner.admin.database.v1.ListDatabasesRequest', '3': '.google.spanner.admin.database.v1.ListDatabasesResponse', '4': const {}},
    const {'1': 'CreateDatabase', '2': '.google.spanner.admin.database.v1.CreateDatabaseRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'GetDatabase', '2': '.google.spanner.admin.database.v1.GetDatabaseRequest', '3': '.google.spanner.admin.database.v1.Database', '4': const {}},
    const {'1': 'UpdateDatabaseDdl', '2': '.google.spanner.admin.database.v1.UpdateDatabaseDdlRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'DropDatabase', '2': '.google.spanner.admin.database.v1.DropDatabaseRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'GetDatabaseDdl', '2': '.google.spanner.admin.database.v1.GetDatabaseDdlRequest', '3': '.google.spanner.admin.database.v1.GetDatabaseDdlResponse', '4': const {}},
    const {'1': 'SetIamPolicy', '2': '.google.iam.v1.SetIamPolicyRequest', '3': '.google.iam.v1.Policy', '4': const {}},
    const {'1': 'GetIamPolicy', '2': '.google.iam.v1.GetIamPolicyRequest', '3': '.google.iam.v1.Policy', '4': const {}},
    const {'1': 'TestIamPermissions', '2': '.google.iam.v1.TestIamPermissionsRequest', '3': '.google.iam.v1.TestIamPermissionsResponse', '4': const {}},
  ],
};

const DatabaseAdmin$messageJson = const {
  '.google.spanner.admin.database.v1.ListDatabasesRequest': ListDatabasesRequest$json,
  '.google.spanner.admin.database.v1.ListDatabasesResponse': ListDatabasesResponse$json,
  '.google.spanner.admin.database.v1.Database': Database$json,
  '.google.spanner.admin.database.v1.CreateDatabaseRequest': CreateDatabaseRequest$json,
  '.google.longrunning.Operation': google$longrunning.Operation$json,
  '.google.protobuf.Any': google$protobuf.Any$json,
  '.google.rpc.Status': google$rpc.Status$json,
  '.google.spanner.admin.database.v1.GetDatabaseRequest': GetDatabaseRequest$json,
  '.google.spanner.admin.database.v1.UpdateDatabaseDdlRequest': UpdateDatabaseDdlRequest$json,
  '.google.spanner.admin.database.v1.DropDatabaseRequest': DropDatabaseRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.spanner.admin.database.v1.GetDatabaseDdlRequest': GetDatabaseDdlRequest$json,
  '.google.spanner.admin.database.v1.GetDatabaseDdlResponse': GetDatabaseDdlResponse$json,
  '.google.iam.v1.SetIamPolicyRequest': google$iam$v1.SetIamPolicyRequest$json,
  '.google.iam.v1.Policy': google$iam$v1.Policy$json,
  '.google.iam.v1.Binding': google$iam$v1.Binding$json,
  '.google.iam.v1.GetIamPolicyRequest': google$iam$v1.GetIamPolicyRequest$json,
  '.google.iam.v1.TestIamPermissionsRequest': google$iam$v1.TestIamPermissionsRequest$json,
  '.google.iam.v1.TestIamPermissionsResponse': google$iam$v1.TestIamPermissionsResponse$json,
};

