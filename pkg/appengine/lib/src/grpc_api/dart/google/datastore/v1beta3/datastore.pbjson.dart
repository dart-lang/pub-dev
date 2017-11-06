///
//  Generated code. Do not modify.
///
library google.datastore.v1beta3_datastore_pbjson;

import 'entity.pbjson.dart';
import 'query.pbjson.dart';
import '../../type/latlng.pbjson.dart' as google$type;
import '../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../protobuf/wrappers.pbjson.dart' as google$protobuf;

const LookupRequest$json = const {
  '1': 'LookupRequest',
  '2': const [
    const {'1': 'project_id', '3': 8, '4': 1, '5': 9},
    const {'1': 'read_options', '3': 1, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.ReadOptions'},
    const {'1': 'keys', '3': 3, '4': 3, '5': 11, '6': '.google.datastore.v1beta3.Key'},
  ],
};

const LookupResponse$json = const {
  '1': 'LookupResponse',
  '2': const [
    const {'1': 'found', '3': 1, '4': 3, '5': 11, '6': '.google.datastore.v1beta3.EntityResult'},
    const {'1': 'missing', '3': 2, '4': 3, '5': 11, '6': '.google.datastore.v1beta3.EntityResult'},
    const {'1': 'deferred', '3': 3, '4': 3, '5': 11, '6': '.google.datastore.v1beta3.Key'},
  ],
};

const RunQueryRequest$json = const {
  '1': 'RunQueryRequest',
  '2': const [
    const {'1': 'project_id', '3': 8, '4': 1, '5': 9},
    const {'1': 'partition_id', '3': 2, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.PartitionId'},
    const {'1': 'read_options', '3': 1, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.ReadOptions'},
    const {'1': 'query', '3': 3, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.Query'},
    const {'1': 'gql_query', '3': 7, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.GqlQuery'},
  ],
};

const RunQueryResponse$json = const {
  '1': 'RunQueryResponse',
  '2': const [
    const {'1': 'batch', '3': 1, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.QueryResultBatch'},
    const {'1': 'query', '3': 2, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.Query'},
  ],
};

const BeginTransactionRequest$json = const {
  '1': 'BeginTransactionRequest',
  '2': const [
    const {'1': 'project_id', '3': 8, '4': 1, '5': 9},
  ],
};

const BeginTransactionResponse$json = const {
  '1': 'BeginTransactionResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 12},
  ],
};

const RollbackRequest$json = const {
  '1': 'RollbackRequest',
  '2': const [
    const {'1': 'project_id', '3': 8, '4': 1, '5': 9},
    const {'1': 'transaction', '3': 1, '4': 1, '5': 12},
  ],
};

const RollbackResponse$json = const {
  '1': 'RollbackResponse',
};

const CommitRequest$json = const {
  '1': 'CommitRequest',
  '2': const [
    const {'1': 'project_id', '3': 8, '4': 1, '5': 9},
    const {'1': 'mode', '3': 5, '4': 1, '5': 14, '6': '.google.datastore.v1beta3.CommitRequest.Mode'},
    const {'1': 'transaction', '3': 1, '4': 1, '5': 12},
    const {'1': 'mutations', '3': 6, '4': 3, '5': 11, '6': '.google.datastore.v1beta3.Mutation'},
  ],
  '4': const [CommitRequest_Mode$json],
};

const CommitRequest_Mode$json = const {
  '1': 'Mode',
  '2': const [
    const {'1': 'MODE_UNSPECIFIED', '2': 0},
    const {'1': 'TRANSACTIONAL', '2': 1},
    const {'1': 'NON_TRANSACTIONAL', '2': 2},
  ],
};

const CommitResponse$json = const {
  '1': 'CommitResponse',
  '2': const [
    const {'1': 'mutation_results', '3': 3, '4': 3, '5': 11, '6': '.google.datastore.v1beta3.MutationResult'},
    const {'1': 'index_updates', '3': 4, '4': 1, '5': 5},
  ],
};

const AllocateIdsRequest$json = const {
  '1': 'AllocateIdsRequest',
  '2': const [
    const {'1': 'project_id', '3': 8, '4': 1, '5': 9},
    const {'1': 'keys', '3': 1, '4': 3, '5': 11, '6': '.google.datastore.v1beta3.Key'},
  ],
};

const AllocateIdsResponse$json = const {
  '1': 'AllocateIdsResponse',
  '2': const [
    const {'1': 'keys', '3': 1, '4': 3, '5': 11, '6': '.google.datastore.v1beta3.Key'},
  ],
};

const Mutation$json = const {
  '1': 'Mutation',
  '2': const [
    const {'1': 'insert', '3': 4, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.Entity'},
    const {'1': 'update', '3': 5, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.Entity'},
    const {'1': 'upsert', '3': 6, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.Entity'},
    const {'1': 'delete', '3': 7, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.Key'},
    const {'1': 'base_version', '3': 8, '4': 1, '5': 3},
  ],
};

const MutationResult$json = const {
  '1': 'MutationResult',
  '2': const [
    const {'1': 'key', '3': 3, '4': 1, '5': 11, '6': '.google.datastore.v1beta3.Key'},
    const {'1': 'version', '3': 4, '4': 1, '5': 3},
    const {'1': 'conflict_detected', '3': 5, '4': 1, '5': 8},
  ],
};

const ReadOptions$json = const {
  '1': 'ReadOptions',
  '2': const [
    const {'1': 'read_consistency', '3': 1, '4': 1, '5': 14, '6': '.google.datastore.v1beta3.ReadOptions.ReadConsistency'},
    const {'1': 'transaction', '3': 2, '4': 1, '5': 12},
  ],
  '4': const [ReadOptions_ReadConsistency$json],
};

const ReadOptions_ReadConsistency$json = const {
  '1': 'ReadConsistency',
  '2': const [
    const {'1': 'READ_CONSISTENCY_UNSPECIFIED', '2': 0},
    const {'1': 'STRONG', '2': 1},
    const {'1': 'EVENTUAL', '2': 2},
  ],
};

const Datastore$json = const {
  '1': 'Datastore',
  '2': const [
    const {'1': 'Lookup', '2': '.google.datastore.v1beta3.LookupRequest', '3': '.google.datastore.v1beta3.LookupResponse', '4': const {}},
    const {'1': 'RunQuery', '2': '.google.datastore.v1beta3.RunQueryRequest', '3': '.google.datastore.v1beta3.RunQueryResponse', '4': const {}},
    const {'1': 'BeginTransaction', '2': '.google.datastore.v1beta3.BeginTransactionRequest', '3': '.google.datastore.v1beta3.BeginTransactionResponse', '4': const {}},
    const {'1': 'Commit', '2': '.google.datastore.v1beta3.CommitRequest', '3': '.google.datastore.v1beta3.CommitResponse', '4': const {}},
    const {'1': 'Rollback', '2': '.google.datastore.v1beta3.RollbackRequest', '3': '.google.datastore.v1beta3.RollbackResponse', '4': const {}},
    const {'1': 'AllocateIds', '2': '.google.datastore.v1beta3.AllocateIdsRequest', '3': '.google.datastore.v1beta3.AllocateIdsResponse', '4': const {}},
  ],
};

const Datastore$messageJson = const {
  '.google.datastore.v1beta3.LookupRequest': LookupRequest$json,
  '.google.datastore.v1beta3.ReadOptions': ReadOptions$json,
  '.google.datastore.v1beta3.Key': Key$json,
  '.google.datastore.v1beta3.PartitionId': PartitionId$json,
  '.google.datastore.v1beta3.Key.PathElement': Key_PathElement$json,
  '.google.datastore.v1beta3.LookupResponse': LookupResponse$json,
  '.google.datastore.v1beta3.EntityResult': EntityResult$json,
  '.google.datastore.v1beta3.Entity': Entity$json,
  '.google.datastore.v1beta3.Entity.PropertiesEntry': Entity_PropertiesEntry$json,
  '.google.datastore.v1beta3.Value': Value$json,
  '.google.type.LatLng': google$type.LatLng$json,
  '.google.datastore.v1beta3.ArrayValue': ArrayValue$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.datastore.v1beta3.RunQueryRequest': RunQueryRequest$json,
  '.google.datastore.v1beta3.Query': Query$json,
  '.google.datastore.v1beta3.Projection': Projection$json,
  '.google.datastore.v1beta3.PropertyReference': PropertyReference$json,
  '.google.datastore.v1beta3.KindExpression': KindExpression$json,
  '.google.datastore.v1beta3.Filter': Filter$json,
  '.google.datastore.v1beta3.CompositeFilter': CompositeFilter$json,
  '.google.datastore.v1beta3.PropertyFilter': PropertyFilter$json,
  '.google.datastore.v1beta3.PropertyOrder': PropertyOrder$json,
  '.google.protobuf.Int32Value': google$protobuf.Int32Value$json,
  '.google.datastore.v1beta3.GqlQuery': GqlQuery$json,
  '.google.datastore.v1beta3.GqlQueryParameter': GqlQueryParameter$json,
  '.google.datastore.v1beta3.GqlQuery.NamedBindingsEntry': GqlQuery_NamedBindingsEntry$json,
  '.google.datastore.v1beta3.RunQueryResponse': RunQueryResponse$json,
  '.google.datastore.v1beta3.QueryResultBatch': QueryResultBatch$json,
  '.google.datastore.v1beta3.BeginTransactionRequest': BeginTransactionRequest$json,
  '.google.datastore.v1beta3.BeginTransactionResponse': BeginTransactionResponse$json,
  '.google.datastore.v1beta3.CommitRequest': CommitRequest$json,
  '.google.datastore.v1beta3.Mutation': Mutation$json,
  '.google.datastore.v1beta3.CommitResponse': CommitResponse$json,
  '.google.datastore.v1beta3.MutationResult': MutationResult$json,
  '.google.datastore.v1beta3.RollbackRequest': RollbackRequest$json,
  '.google.datastore.v1beta3.RollbackResponse': RollbackResponse$json,
  '.google.datastore.v1beta3.AllocateIdsRequest': AllocateIdsRequest$json,
  '.google.datastore.v1beta3.AllocateIdsResponse': AllocateIdsResponse$json,
};

