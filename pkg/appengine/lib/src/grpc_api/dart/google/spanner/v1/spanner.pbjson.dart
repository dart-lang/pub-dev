///
//  Generated code. Do not modify.
///
library google.spanner.v1_spanner_pbjson;

import '../../protobuf/empty.pbjson.dart' as google$protobuf;
import 'transaction.pbjson.dart';
import '../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../protobuf/duration.pbjson.dart' as google$protobuf;
import '../../protobuf/struct.pbjson.dart' as google$protobuf;
import 'type.pbjson.dart';
import 'result_set.pbjson.dart';
import 'query_plan.pbjson.dart';
import 'keys.pbjson.dart';
import 'mutation.pbjson.dart';

const CreateSessionRequest$json = const {
  '1': 'CreateSessionRequest',
  '2': const [
    const {'1': 'database', '3': 1, '4': 1, '5': 9},
  ],
};

const Session$json = const {
  '1': 'Session',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const GetSessionRequest$json = const {
  '1': 'GetSessionRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const DeleteSessionRequest$json = const {
  '1': 'DeleteSessionRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ExecuteSqlRequest$json = const {
  '1': 'ExecuteSqlRequest',
  '2': const [
    const {'1': 'session', '3': 1, '4': 1, '5': 9},
    const {'1': 'transaction', '3': 2, '4': 1, '5': 11, '6': '.google.spanner.v1.TransactionSelector'},
    const {'1': 'sql', '3': 3, '4': 1, '5': 9},
    const {'1': 'params', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Struct'},
    const {'1': 'param_types', '3': 5, '4': 3, '5': 11, '6': '.google.spanner.v1.ExecuteSqlRequest.ParamTypesEntry'},
    const {'1': 'resume_token', '3': 6, '4': 1, '5': 12},
    const {'1': 'query_mode', '3': 7, '4': 1, '5': 14, '6': '.google.spanner.v1.ExecuteSqlRequest.QueryMode'},
  ],
  '3': const [ExecuteSqlRequest_ParamTypesEntry$json],
  '4': const [ExecuteSqlRequest_QueryMode$json],
};

const ExecuteSqlRequest_ParamTypesEntry$json = const {
  '1': 'ParamTypesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.spanner.v1.Type'},
  ],
  '7': const {},
};

const ExecuteSqlRequest_QueryMode$json = const {
  '1': 'QueryMode',
  '2': const [
    const {'1': 'NORMAL', '2': 0},
    const {'1': 'PLAN', '2': 1},
    const {'1': 'PROFILE', '2': 2},
  ],
};

const ReadRequest$json = const {
  '1': 'ReadRequest',
  '2': const [
    const {'1': 'session', '3': 1, '4': 1, '5': 9},
    const {'1': 'transaction', '3': 2, '4': 1, '5': 11, '6': '.google.spanner.v1.TransactionSelector'},
    const {'1': 'table', '3': 3, '4': 1, '5': 9},
    const {'1': 'index', '3': 4, '4': 1, '5': 9},
    const {'1': 'columns', '3': 5, '4': 3, '5': 9},
    const {'1': 'key_set', '3': 6, '4': 1, '5': 11, '6': '.google.spanner.v1.KeySet'},
    const {'1': 'limit', '3': 8, '4': 1, '5': 3},
    const {'1': 'resume_token', '3': 9, '4': 1, '5': 12},
  ],
};

const BeginTransactionRequest$json = const {
  '1': 'BeginTransactionRequest',
  '2': const [
    const {'1': 'session', '3': 1, '4': 1, '5': 9},
    const {'1': 'options', '3': 2, '4': 1, '5': 11, '6': '.google.spanner.v1.TransactionOptions'},
  ],
};

const CommitRequest$json = const {
  '1': 'CommitRequest',
  '2': const [
    const {'1': 'session', '3': 1, '4': 1, '5': 9},
    const {'1': 'transaction_id', '3': 2, '4': 1, '5': 12},
    const {'1': 'single_use_transaction', '3': 3, '4': 1, '5': 11, '6': '.google.spanner.v1.TransactionOptions'},
    const {'1': 'mutations', '3': 4, '4': 3, '5': 11, '6': '.google.spanner.v1.Mutation'},
  ],
};

const CommitResponse$json = const {
  '1': 'CommitResponse',
  '2': const [
    const {'1': 'commit_timestamp', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const RollbackRequest$json = const {
  '1': 'RollbackRequest',
  '2': const [
    const {'1': 'session', '3': 1, '4': 1, '5': 9},
    const {'1': 'transaction_id', '3': 2, '4': 1, '5': 12},
  ],
};

const Spanner$json = const {
  '1': 'Spanner',
  '2': const [
    const {'1': 'CreateSession', '2': '.google.spanner.v1.CreateSessionRequest', '3': '.google.spanner.v1.Session', '4': const {}},
    const {'1': 'GetSession', '2': '.google.spanner.v1.GetSessionRequest', '3': '.google.spanner.v1.Session', '4': const {}},
    const {'1': 'DeleteSession', '2': '.google.spanner.v1.DeleteSessionRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'ExecuteSql', '2': '.google.spanner.v1.ExecuteSqlRequest', '3': '.google.spanner.v1.ResultSet', '4': const {}},
    const {'1': 'ExecuteStreamingSql', '2': '.google.spanner.v1.ExecuteSqlRequest', '3': '.google.spanner.v1.PartialResultSet', '4': const {}},
    const {'1': 'Read', '2': '.google.spanner.v1.ReadRequest', '3': '.google.spanner.v1.ResultSet', '4': const {}},
    const {'1': 'StreamingRead', '2': '.google.spanner.v1.ReadRequest', '3': '.google.spanner.v1.PartialResultSet', '4': const {}},
    const {'1': 'BeginTransaction', '2': '.google.spanner.v1.BeginTransactionRequest', '3': '.google.spanner.v1.Transaction', '4': const {}},
    const {'1': 'Commit', '2': '.google.spanner.v1.CommitRequest', '3': '.google.spanner.v1.CommitResponse', '4': const {}},
    const {'1': 'Rollback', '2': '.google.spanner.v1.RollbackRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const Spanner$messageJson = const {
  '.google.spanner.v1.CreateSessionRequest': CreateSessionRequest$json,
  '.google.spanner.v1.Session': Session$json,
  '.google.spanner.v1.GetSessionRequest': GetSessionRequest$json,
  '.google.spanner.v1.DeleteSessionRequest': DeleteSessionRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.spanner.v1.ExecuteSqlRequest': ExecuteSqlRequest$json,
  '.google.spanner.v1.TransactionSelector': TransactionSelector$json,
  '.google.spanner.v1.TransactionOptions': TransactionOptions$json,
  '.google.spanner.v1.TransactionOptions.ReadWrite': TransactionOptions_ReadWrite$json,
  '.google.spanner.v1.TransactionOptions.ReadOnly': TransactionOptions_ReadOnly$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.protobuf.Duration': google$protobuf.Duration$json,
  '.google.protobuf.Struct': google$protobuf.Struct$json,
  '.google.protobuf.Struct.FieldsEntry': google$protobuf.Struct_FieldsEntry$json,
  '.google.protobuf.Value': google$protobuf.Value$json,
  '.google.protobuf.ListValue': google$protobuf.ListValue$json,
  '.google.spanner.v1.ExecuteSqlRequest.ParamTypesEntry': ExecuteSqlRequest_ParamTypesEntry$json,
  '.google.spanner.v1.Type': Type$json,
  '.google.spanner.v1.StructType': StructType$json,
  '.google.spanner.v1.StructType.Field': StructType_Field$json,
  '.google.spanner.v1.ResultSet': ResultSet$json,
  '.google.spanner.v1.ResultSetMetadata': ResultSetMetadata$json,
  '.google.spanner.v1.Transaction': Transaction$json,
  '.google.spanner.v1.ResultSetStats': ResultSetStats$json,
  '.google.spanner.v1.QueryPlan': QueryPlan$json,
  '.google.spanner.v1.PlanNode': PlanNode$json,
  '.google.spanner.v1.PlanNode.ChildLink': PlanNode_ChildLink$json,
  '.google.spanner.v1.PlanNode.ShortRepresentation': PlanNode_ShortRepresentation$json,
  '.google.spanner.v1.PlanNode.ShortRepresentation.SubqueriesEntry': PlanNode_ShortRepresentation_SubqueriesEntry$json,
  '.google.spanner.v1.PartialResultSet': PartialResultSet$json,
  '.google.spanner.v1.ReadRequest': ReadRequest$json,
  '.google.spanner.v1.KeySet': KeySet$json,
  '.google.spanner.v1.KeyRange': KeyRange$json,
  '.google.spanner.v1.BeginTransactionRequest': BeginTransactionRequest$json,
  '.google.spanner.v1.CommitRequest': CommitRequest$json,
  '.google.spanner.v1.Mutation': Mutation$json,
  '.google.spanner.v1.Mutation.Write': Mutation_Write$json,
  '.google.spanner.v1.Mutation.Delete': Mutation_Delete$json,
  '.google.spanner.v1.CommitResponse': CommitResponse$json,
  '.google.spanner.v1.RollbackRequest': RollbackRequest$json,
};

