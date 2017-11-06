///
//  Generated code. Do not modify.
///
library google.monitoring.v3_group_service_pbjson;

import 'group.pbjson.dart';
import '../../protobuf/empty.pbjson.dart' as google$protobuf;
import 'common.pbjson.dart';
import '../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../api/monitored_resource.pbjson.dart' as google$api;

const ListGroupsRequest$json = const {
  '1': 'ListGroupsRequest',
  '2': const [
    const {'1': 'name', '3': 7, '4': 1, '5': 9},
    const {'1': 'children_of_group', '3': 2, '4': 1, '5': 9},
    const {'1': 'ancestors_of_group', '3': 3, '4': 1, '5': 9},
    const {'1': 'descendants_of_group', '3': 4, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 5, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 6, '4': 1, '5': 9},
  ],
};

const ListGroupsResponse$json = const {
  '1': 'ListGroupsResponse',
  '2': const [
    const {'1': 'group', '3': 1, '4': 3, '5': 11, '6': '.google.monitoring.v3.Group'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const GetGroupRequest$json = const {
  '1': 'GetGroupRequest',
  '2': const [
    const {'1': 'name', '3': 3, '4': 1, '5': 9},
  ],
};

const CreateGroupRequest$json = const {
  '1': 'CreateGroupRequest',
  '2': const [
    const {'1': 'name', '3': 4, '4': 1, '5': 9},
    const {'1': 'group', '3': 2, '4': 1, '5': 11, '6': '.google.monitoring.v3.Group'},
    const {'1': 'validate_only', '3': 3, '4': 1, '5': 8},
  ],
};

const UpdateGroupRequest$json = const {
  '1': 'UpdateGroupRequest',
  '2': const [
    const {'1': 'group', '3': 2, '4': 1, '5': 11, '6': '.google.monitoring.v3.Group'},
    const {'1': 'validate_only', '3': 3, '4': 1, '5': 8},
  ],
};

const DeleteGroupRequest$json = const {
  '1': 'DeleteGroupRequest',
  '2': const [
    const {'1': 'name', '3': 3, '4': 1, '5': 9},
  ],
};

const ListGroupMembersRequest$json = const {
  '1': 'ListGroupMembersRequest',
  '2': const [
    const {'1': 'name', '3': 7, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 4, '4': 1, '5': 9},
    const {'1': 'filter', '3': 5, '4': 1, '5': 9},
    const {'1': 'interval', '3': 6, '4': 1, '5': 11, '6': '.google.monitoring.v3.TimeInterval'},
  ],
};

const ListGroupMembersResponse$json = const {
  '1': 'ListGroupMembersResponse',
  '2': const [
    const {'1': 'members', '3': 1, '4': 3, '5': 11, '6': '.google.api.MonitoredResource'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
    const {'1': 'total_size', '3': 3, '4': 1, '5': 5},
  ],
};

const GroupService$json = const {
  '1': 'GroupService',
  '2': const [
    const {'1': 'ListGroups', '2': '.google.monitoring.v3.ListGroupsRequest', '3': '.google.monitoring.v3.ListGroupsResponse', '4': const {}},
    const {'1': 'GetGroup', '2': '.google.monitoring.v3.GetGroupRequest', '3': '.google.monitoring.v3.Group', '4': const {}},
    const {'1': 'CreateGroup', '2': '.google.monitoring.v3.CreateGroupRequest', '3': '.google.monitoring.v3.Group', '4': const {}},
    const {'1': 'UpdateGroup', '2': '.google.monitoring.v3.UpdateGroupRequest', '3': '.google.monitoring.v3.Group', '4': const {}},
    const {'1': 'DeleteGroup', '2': '.google.monitoring.v3.DeleteGroupRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'ListGroupMembers', '2': '.google.monitoring.v3.ListGroupMembersRequest', '3': '.google.monitoring.v3.ListGroupMembersResponse', '4': const {}},
  ],
};

const GroupService$messageJson = const {
  '.google.monitoring.v3.ListGroupsRequest': ListGroupsRequest$json,
  '.google.monitoring.v3.ListGroupsResponse': ListGroupsResponse$json,
  '.google.monitoring.v3.Group': Group$json,
  '.google.monitoring.v3.GetGroupRequest': GetGroupRequest$json,
  '.google.monitoring.v3.CreateGroupRequest': CreateGroupRequest$json,
  '.google.monitoring.v3.UpdateGroupRequest': UpdateGroupRequest$json,
  '.google.monitoring.v3.DeleteGroupRequest': DeleteGroupRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.monitoring.v3.ListGroupMembersRequest': ListGroupMembersRequest$json,
  '.google.monitoring.v3.TimeInterval': TimeInterval$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.monitoring.v3.ListGroupMembersResponse': ListGroupMembersResponse$json,
  '.google.api.MonitoredResource': google$api.MonitoredResource$json,
  '.google.api.MonitoredResource.LabelsEntry': google$api.MonitoredResource_LabelsEntry$json,
};

