///
//  Generated code. Do not modify.
///
library google.bigtable.v1_bigtable_service_pbjson;

import 'bigtable_service_messages.pbjson.dart';
import 'bigtable_data.pbjson.dart';
import '../../protobuf/empty.pbjson.dart' as google$protobuf;
import '../../rpc/status.pbjson.dart' as google$rpc;
import '../../protobuf/any.pbjson.dart' as google$protobuf;

const BigtableService$json = const {
  '1': 'BigtableService',
  '2': const [
    const {'1': 'ReadRows', '2': '.google.bigtable.v1.ReadRowsRequest', '3': '.google.bigtable.v1.ReadRowsResponse', '4': const {}},
    const {'1': 'SampleRowKeys', '2': '.google.bigtable.v1.SampleRowKeysRequest', '3': '.google.bigtable.v1.SampleRowKeysResponse', '4': const {}},
    const {'1': 'MutateRow', '2': '.google.bigtable.v1.MutateRowRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'MutateRows', '2': '.google.bigtable.v1.MutateRowsRequest', '3': '.google.bigtable.v1.MutateRowsResponse', '4': const {}},
    const {'1': 'CheckAndMutateRow', '2': '.google.bigtable.v1.CheckAndMutateRowRequest', '3': '.google.bigtable.v1.CheckAndMutateRowResponse', '4': const {}},
    const {'1': 'ReadModifyWriteRow', '2': '.google.bigtable.v1.ReadModifyWriteRowRequest', '3': '.google.bigtable.v1.Row', '4': const {}},
  ],
};

const BigtableService$messageJson = const {
  '.google.bigtable.v1.ReadRowsRequest': ReadRowsRequest$json,
  '.google.bigtable.v1.RowRange': RowRange$json,
  '.google.bigtable.v1.RowFilter': RowFilter$json,
  '.google.bigtable.v1.RowFilter.Chain': RowFilter_Chain$json,
  '.google.bigtable.v1.RowFilter.Interleave': RowFilter_Interleave$json,
  '.google.bigtable.v1.RowFilter.Condition': RowFilter_Condition$json,
  '.google.bigtable.v1.ColumnRange': ColumnRange$json,
  '.google.bigtable.v1.TimestampRange': TimestampRange$json,
  '.google.bigtable.v1.ValueRange': ValueRange$json,
  '.google.bigtable.v1.RowSet': RowSet$json,
  '.google.bigtable.v1.ReadRowsResponse': ReadRowsResponse$json,
  '.google.bigtable.v1.ReadRowsResponse.Chunk': ReadRowsResponse_Chunk$json,
  '.google.bigtable.v1.Family': Family$json,
  '.google.bigtable.v1.Column': Column$json,
  '.google.bigtable.v1.Cell': Cell$json,
  '.google.bigtable.v1.SampleRowKeysRequest': SampleRowKeysRequest$json,
  '.google.bigtable.v1.SampleRowKeysResponse': SampleRowKeysResponse$json,
  '.google.bigtable.v1.MutateRowRequest': MutateRowRequest$json,
  '.google.bigtable.v1.Mutation': Mutation$json,
  '.google.bigtable.v1.Mutation.SetCell': Mutation_SetCell$json,
  '.google.bigtable.v1.Mutation.DeleteFromColumn': Mutation_DeleteFromColumn$json,
  '.google.bigtable.v1.Mutation.DeleteFromFamily': Mutation_DeleteFromFamily$json,
  '.google.bigtable.v1.Mutation.DeleteFromRow': Mutation_DeleteFromRow$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.bigtable.v1.MutateRowsRequest': MutateRowsRequest$json,
  '.google.bigtable.v1.MutateRowsRequest.Entry': MutateRowsRequest_Entry$json,
  '.google.bigtable.v1.MutateRowsResponse': MutateRowsResponse$json,
  '.google.rpc.Status': google$rpc.Status$json,
  '.google.protobuf.Any': google$protobuf.Any$json,
  '.google.bigtable.v1.CheckAndMutateRowRequest': CheckAndMutateRowRequest$json,
  '.google.bigtable.v1.CheckAndMutateRowResponse': CheckAndMutateRowResponse$json,
  '.google.bigtable.v1.ReadModifyWriteRowRequest': ReadModifyWriteRowRequest$json,
  '.google.bigtable.v1.ReadModifyWriteRule': ReadModifyWriteRule$json,
  '.google.bigtable.v1.Row': Row$json,
};

