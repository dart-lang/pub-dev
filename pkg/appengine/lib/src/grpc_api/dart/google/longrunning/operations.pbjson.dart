///
//  Generated code. Do not modify.
///
library google.longrunning_operations_pbjson;

import '../protobuf/any.pbjson.dart' as google$protobuf;
import '../rpc/status.pbjson.dart' as google$rpc;
import '../protobuf/empty.pbjson.dart' as google$protobuf;

const Operation$json = const {
  '1': 'Operation',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'metadata', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Any'},
    const {'1': 'done', '3': 3, '4': 1, '5': 8},
    const {'1': 'error', '3': 4, '4': 1, '5': 11, '6': '.google.rpc.Status'},
    const {'1': 'response', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Any'},
  ],
};

const GetOperationRequest$json = const {
  '1': 'GetOperationRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ListOperationsRequest$json = const {
  '1': 'ListOperationsRequest',
  '2': const [
    const {'1': 'name', '3': 4, '4': 1, '5': 9},
    const {'1': 'filter', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListOperationsResponse$json = const {
  '1': 'ListOperationsResponse',
  '2': const [
    const {'1': 'operations', '3': 1, '4': 3, '5': 11, '6': '.google.longrunning.Operation'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const CancelOperationRequest$json = const {
  '1': 'CancelOperationRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const DeleteOperationRequest$json = const {
  '1': 'DeleteOperationRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const Operations$json = const {
  '1': 'Operations',
  '2': const [
    const {'1': 'ListOperations', '2': '.google.longrunning.ListOperationsRequest', '3': '.google.longrunning.ListOperationsResponse', '4': const {}},
    const {'1': 'GetOperation', '2': '.google.longrunning.GetOperationRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'DeleteOperation', '2': '.google.longrunning.DeleteOperationRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'CancelOperation', '2': '.google.longrunning.CancelOperationRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const Operations$messageJson = const {
  '.google.longrunning.ListOperationsRequest': ListOperationsRequest$json,
  '.google.longrunning.ListOperationsResponse': ListOperationsResponse$json,
  '.google.longrunning.Operation': Operation$json,
  '.google.protobuf.Any': google$protobuf.Any$json,
  '.google.rpc.Status': google$rpc.Status$json,
  '.google.longrunning.GetOperationRequest': GetOperationRequest$json,
  '.google.longrunning.DeleteOperationRequest': DeleteOperationRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.longrunning.CancelOperationRequest': CancelOperationRequest$json,
};

