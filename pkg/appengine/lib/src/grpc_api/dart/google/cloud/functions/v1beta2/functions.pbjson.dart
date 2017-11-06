///
//  Generated code. Do not modify.
///
library google.cloud.functions.v1beta2_functions_pbjson;

import '../../../protobuf/duration.pbjson.dart' as google$protobuf;
import '../../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../../longrunning/operations.pbjson.dart' as google$longrunning;
import '../../../protobuf/any.pbjson.dart' as google$protobuf;
import '../../../rpc/status.pbjson.dart' as google$rpc;

const CloudFunctionStatus$json = const {
  '1': 'CloudFunctionStatus',
  '2': const [
    const {'1': 'STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'READY', '2': 1},
    const {'1': 'FAILED', '2': 2},
    const {'1': 'DEPLOYING', '2': 3},
    const {'1': 'DELETING', '2': 4},
  ],
};

const CloudFunction$json = const {
  '1': 'CloudFunction',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'source_archive_url', '3': 14, '4': 1, '5': 9},
    const {'1': 'source_repository', '3': 3, '4': 1, '5': 11, '6': '.google.cloud.functions.v1beta2.SourceRepository'},
    const {'1': 'https_trigger', '3': 6, '4': 1, '5': 11, '6': '.google.cloud.functions.v1beta2.HTTPSTrigger'},
    const {'1': 'event_trigger', '3': 12, '4': 1, '5': 11, '6': '.google.cloud.functions.v1beta2.EventTrigger'},
    const {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.google.cloud.functions.v1beta2.CloudFunctionStatus'},
    const {'1': 'latest_operation', '3': 8, '4': 1, '5': 9},
    const {'1': 'entry_point', '3': 9, '4': 1, '5': 9},
    const {'1': 'timeout', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'available_memory_mb', '3': 11, '4': 1, '5': 5},
    const {'1': 'service_account', '3': 13, '4': 1, '5': 9},
    const {'1': 'update_time', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const HTTPSTrigger$json = const {
  '1': 'HTTPSTrigger',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9},
  ],
};

const EventTrigger$json = const {
  '1': 'EventTrigger',
  '2': const [
    const {'1': 'event_type', '3': 1, '4': 1, '5': 9},
    const {'1': 'resource', '3': 2, '4': 1, '5': 9},
  ],
};

const SourceRepository$json = const {
  '1': 'SourceRepository',
  '2': const [
    const {'1': 'repository_url', '3': 1, '4': 1, '5': 9},
    const {'1': 'source_path', '3': 2, '4': 1, '5': 9},
    const {'1': 'branch', '3': 3, '4': 1, '5': 9},
    const {'1': 'tag', '3': 4, '4': 1, '5': 9},
    const {'1': 'revision', '3': 5, '4': 1, '5': 9},
    const {'1': 'deployed_revision', '3': 6, '4': 1, '5': 9},
  ],
};

const CreateFunctionRequest$json = const {
  '1': 'CreateFunctionRequest',
  '2': const [
    const {'1': 'location', '3': 1, '4': 1, '5': 9},
    const {'1': 'function', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.functions.v1beta2.CloudFunction'},
  ],
};

const UpdateFunctionRequest$json = const {
  '1': 'UpdateFunctionRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'function', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.functions.v1beta2.CloudFunction'},
  ],
};

const GetFunctionRequest$json = const {
  '1': 'GetFunctionRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ListFunctionsRequest$json = const {
  '1': 'ListFunctionsRequest',
  '2': const [
    const {'1': 'location', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListFunctionsResponse$json = const {
  '1': 'ListFunctionsResponse',
  '2': const [
    const {'1': 'functions', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.functions.v1beta2.CloudFunction'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const DeleteFunctionRequest$json = const {
  '1': 'DeleteFunctionRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const CallFunctionRequest$json = const {
  '1': 'CallFunctionRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'data', '3': 2, '4': 1, '5': 9},
  ],
};

const CallFunctionResponse$json = const {
  '1': 'CallFunctionResponse',
  '2': const [
    const {'1': 'execution_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'result', '3': 2, '4': 1, '5': 9},
    const {'1': 'error', '3': 3, '4': 1, '5': 9},
  ],
};

const CloudFunctionsService$json = const {
  '1': 'CloudFunctionsService',
  '2': const [
    const {'1': 'ListFunctions', '2': '.google.cloud.functions.v1beta2.ListFunctionsRequest', '3': '.google.cloud.functions.v1beta2.ListFunctionsResponse', '4': const {}},
    const {'1': 'GetFunction', '2': '.google.cloud.functions.v1beta2.GetFunctionRequest', '3': '.google.cloud.functions.v1beta2.CloudFunction', '4': const {}},
    const {'1': 'CreateFunction', '2': '.google.cloud.functions.v1beta2.CreateFunctionRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'UpdateFunction', '2': '.google.cloud.functions.v1beta2.UpdateFunctionRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'DeleteFunction', '2': '.google.cloud.functions.v1beta2.DeleteFunctionRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'CallFunction', '2': '.google.cloud.functions.v1beta2.CallFunctionRequest', '3': '.google.cloud.functions.v1beta2.CallFunctionResponse', '4': const {}},
  ],
};

const CloudFunctionsService$messageJson = const {
  '.google.cloud.functions.v1beta2.ListFunctionsRequest': ListFunctionsRequest$json,
  '.google.cloud.functions.v1beta2.ListFunctionsResponse': ListFunctionsResponse$json,
  '.google.cloud.functions.v1beta2.CloudFunction': CloudFunction$json,
  '.google.cloud.functions.v1beta2.SourceRepository': SourceRepository$json,
  '.google.cloud.functions.v1beta2.HTTPSTrigger': HTTPSTrigger$json,
  '.google.protobuf.Duration': google$protobuf.Duration$json,
  '.google.cloud.functions.v1beta2.EventTrigger': EventTrigger$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.cloud.functions.v1beta2.GetFunctionRequest': GetFunctionRequest$json,
  '.google.cloud.functions.v1beta2.CreateFunctionRequest': CreateFunctionRequest$json,
  '.google.longrunning.Operation': google$longrunning.Operation$json,
  '.google.protobuf.Any': google$protobuf.Any$json,
  '.google.rpc.Status': google$rpc.Status$json,
  '.google.cloud.functions.v1beta2.UpdateFunctionRequest': UpdateFunctionRequest$json,
  '.google.cloud.functions.v1beta2.DeleteFunctionRequest': DeleteFunctionRequest$json,
  '.google.cloud.functions.v1beta2.CallFunctionRequest': CallFunctionRequest$json,
  '.google.cloud.functions.v1beta2.CallFunctionResponse': CallFunctionResponse$json,
};

