///
//  Generated code. Do not modify.
///
library google.cloud.runtimeconfig.v1beta1_runtimeconfig_pbjson;

import 'resources.pbjson.dart';
import '../../../protobuf/empty.pbjson.dart' as google$protobuf;
import '../../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../../protobuf/duration.pbjson.dart' as google$protobuf;
import '../../../rpc/status.pbjson.dart' as google$rpc;
import '../../../protobuf/any.pbjson.dart' as google$protobuf;
import '../../../longrunning/operations.pbjson.dart' as google$longrunning;

const ListConfigsRequest$json = const {
  '1': 'ListConfigsRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListConfigsResponse$json = const {
  '1': 'ListConfigsResponse',
  '2': const [
    const {'1': 'configs', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.runtimeconfig.v1beta1.RuntimeConfig'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const GetConfigRequest$json = const {
  '1': 'GetConfigRequest',
  '2': const [
    const {'1': 'name', '3': 2, '4': 1, '5': 9},
  ],
};

const CreateConfigRequest$json = const {
  '1': 'CreateConfigRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'config', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.runtimeconfig.v1beta1.RuntimeConfig'},
    const {'1': 'request_id', '3': 3, '4': 1, '5': 9},
  ],
};

const UpdateConfigRequest$json = const {
  '1': 'UpdateConfigRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'config', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.runtimeconfig.v1beta1.RuntimeConfig'},
  ],
};

const DeleteConfigRequest$json = const {
  '1': 'DeleteConfigRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ListVariablesRequest$json = const {
  '1': 'ListVariablesRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'filter', '3': 2, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 4, '4': 1, '5': 9},
  ],
};

const ListVariablesResponse$json = const {
  '1': 'ListVariablesResponse',
  '2': const [
    const {'1': 'variables', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.runtimeconfig.v1beta1.Variable'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const WatchVariableRequest$json = const {
  '1': 'WatchVariableRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'newer_than', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const GetVariableRequest$json = const {
  '1': 'GetVariableRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const CreateVariableRequest$json = const {
  '1': 'CreateVariableRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'variable', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.runtimeconfig.v1beta1.Variable'},
    const {'1': 'request_id', '3': 3, '4': 1, '5': 9},
  ],
};

const UpdateVariableRequest$json = const {
  '1': 'UpdateVariableRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'variable', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.runtimeconfig.v1beta1.Variable'},
  ],
};

const DeleteVariableRequest$json = const {
  '1': 'DeleteVariableRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'recursive', '3': 2, '4': 1, '5': 8},
  ],
};

const ListWaitersRequest$json = const {
  '1': 'ListWaitersRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListWaitersResponse$json = const {
  '1': 'ListWaitersResponse',
  '2': const [
    const {'1': 'waiters', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.runtimeconfig.v1beta1.Waiter'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const GetWaiterRequest$json = const {
  '1': 'GetWaiterRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const CreateWaiterRequest$json = const {
  '1': 'CreateWaiterRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'waiter', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.runtimeconfig.v1beta1.Waiter'},
    const {'1': 'request_id', '3': 3, '4': 1, '5': 9},
  ],
};

const DeleteWaiterRequest$json = const {
  '1': 'DeleteWaiterRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const RuntimeConfigManager$json = const {
  '1': 'RuntimeConfigManager',
  '2': const [
    const {'1': 'ListConfigs', '2': '.google.cloud.runtimeconfig.v1beta1.ListConfigsRequest', '3': '.google.cloud.runtimeconfig.v1beta1.ListConfigsResponse', '4': const {}},
    const {'1': 'GetConfig', '2': '.google.cloud.runtimeconfig.v1beta1.GetConfigRequest', '3': '.google.cloud.runtimeconfig.v1beta1.RuntimeConfig', '4': const {}},
    const {'1': 'CreateConfig', '2': '.google.cloud.runtimeconfig.v1beta1.CreateConfigRequest', '3': '.google.cloud.runtimeconfig.v1beta1.RuntimeConfig', '4': const {}},
    const {'1': 'UpdateConfig', '2': '.google.cloud.runtimeconfig.v1beta1.UpdateConfigRequest', '3': '.google.cloud.runtimeconfig.v1beta1.RuntimeConfig', '4': const {}},
    const {'1': 'DeleteConfig', '2': '.google.cloud.runtimeconfig.v1beta1.DeleteConfigRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'ListVariables', '2': '.google.cloud.runtimeconfig.v1beta1.ListVariablesRequest', '3': '.google.cloud.runtimeconfig.v1beta1.ListVariablesResponse', '4': const {}},
    const {'1': 'GetVariable', '2': '.google.cloud.runtimeconfig.v1beta1.GetVariableRequest', '3': '.google.cloud.runtimeconfig.v1beta1.Variable', '4': const {}},
    const {'1': 'WatchVariable', '2': '.google.cloud.runtimeconfig.v1beta1.WatchVariableRequest', '3': '.google.cloud.runtimeconfig.v1beta1.Variable', '4': const {}},
    const {'1': 'CreateVariable', '2': '.google.cloud.runtimeconfig.v1beta1.CreateVariableRequest', '3': '.google.cloud.runtimeconfig.v1beta1.Variable', '4': const {}},
    const {'1': 'UpdateVariable', '2': '.google.cloud.runtimeconfig.v1beta1.UpdateVariableRequest', '3': '.google.cloud.runtimeconfig.v1beta1.Variable', '4': const {}},
    const {'1': 'DeleteVariable', '2': '.google.cloud.runtimeconfig.v1beta1.DeleteVariableRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'ListWaiters', '2': '.google.cloud.runtimeconfig.v1beta1.ListWaitersRequest', '3': '.google.cloud.runtimeconfig.v1beta1.ListWaitersResponse', '4': const {}},
    const {'1': 'GetWaiter', '2': '.google.cloud.runtimeconfig.v1beta1.GetWaiterRequest', '3': '.google.cloud.runtimeconfig.v1beta1.Waiter', '4': const {}},
    const {'1': 'CreateWaiter', '2': '.google.cloud.runtimeconfig.v1beta1.CreateWaiterRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'DeleteWaiter', '2': '.google.cloud.runtimeconfig.v1beta1.DeleteWaiterRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const RuntimeConfigManager$messageJson = const {
  '.google.cloud.runtimeconfig.v1beta1.ListConfigsRequest': ListConfigsRequest$json,
  '.google.cloud.runtimeconfig.v1beta1.ListConfigsResponse': ListConfigsResponse$json,
  '.google.cloud.runtimeconfig.v1beta1.RuntimeConfig': RuntimeConfig$json,
  '.google.cloud.runtimeconfig.v1beta1.GetConfigRequest': GetConfigRequest$json,
  '.google.cloud.runtimeconfig.v1beta1.CreateConfigRequest': CreateConfigRequest$json,
  '.google.cloud.runtimeconfig.v1beta1.UpdateConfigRequest': UpdateConfigRequest$json,
  '.google.cloud.runtimeconfig.v1beta1.DeleteConfigRequest': DeleteConfigRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.cloud.runtimeconfig.v1beta1.ListVariablesRequest': ListVariablesRequest$json,
  '.google.cloud.runtimeconfig.v1beta1.ListVariablesResponse': ListVariablesResponse$json,
  '.google.cloud.runtimeconfig.v1beta1.Variable': Variable$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.cloud.runtimeconfig.v1beta1.GetVariableRequest': GetVariableRequest$json,
  '.google.cloud.runtimeconfig.v1beta1.WatchVariableRequest': WatchVariableRequest$json,
  '.google.cloud.runtimeconfig.v1beta1.CreateVariableRequest': CreateVariableRequest$json,
  '.google.cloud.runtimeconfig.v1beta1.UpdateVariableRequest': UpdateVariableRequest$json,
  '.google.cloud.runtimeconfig.v1beta1.DeleteVariableRequest': DeleteVariableRequest$json,
  '.google.cloud.runtimeconfig.v1beta1.ListWaitersRequest': ListWaitersRequest$json,
  '.google.cloud.runtimeconfig.v1beta1.ListWaitersResponse': ListWaitersResponse$json,
  '.google.cloud.runtimeconfig.v1beta1.Waiter': Waiter$json,
  '.google.protobuf.Duration': google$protobuf.Duration$json,
  '.google.cloud.runtimeconfig.v1beta1.EndCondition': EndCondition$json,
  '.google.cloud.runtimeconfig.v1beta1.EndCondition.Cardinality': EndCondition_Cardinality$json,
  '.google.rpc.Status': google$rpc.Status$json,
  '.google.protobuf.Any': google$protobuf.Any$json,
  '.google.cloud.runtimeconfig.v1beta1.GetWaiterRequest': GetWaiterRequest$json,
  '.google.cloud.runtimeconfig.v1beta1.CreateWaiterRequest': CreateWaiterRequest$json,
  '.google.longrunning.Operation': google$longrunning.Operation$json,
  '.google.cloud.runtimeconfig.v1beta1.DeleteWaiterRequest': DeleteWaiterRequest$json,
};

