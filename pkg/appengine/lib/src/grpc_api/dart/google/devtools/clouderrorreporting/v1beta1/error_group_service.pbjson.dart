///
//  Generated code. Do not modify.
///
library google.devtools.clouderrorreporting.v1beta1_error_group_service_pbjson;

import 'common.pbjson.dart';

const GetGroupRequest$json = const {
  '1': 'GetGroupRequest',
  '2': const [
    const {'1': 'group_name', '3': 1, '4': 1, '5': 9},
  ],
};

const UpdateGroupRequest$json = const {
  '1': 'UpdateGroupRequest',
  '2': const [
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.ErrorGroup'},
  ],
};

const ErrorGroupService$json = const {
  '1': 'ErrorGroupService',
  '2': const [
    const {'1': 'GetGroup', '2': '.google.devtools.clouderrorreporting.v1beta1.GetGroupRequest', '3': '.google.devtools.clouderrorreporting.v1beta1.ErrorGroup', '4': const {}},
    const {'1': 'UpdateGroup', '2': '.google.devtools.clouderrorreporting.v1beta1.UpdateGroupRequest', '3': '.google.devtools.clouderrorreporting.v1beta1.ErrorGroup', '4': const {}},
  ],
};

const ErrorGroupService$messageJson = const {
  '.google.devtools.clouderrorreporting.v1beta1.GetGroupRequest': GetGroupRequest$json,
  '.google.devtools.clouderrorreporting.v1beta1.ErrorGroup': ErrorGroup$json,
  '.google.devtools.clouderrorreporting.v1beta1.TrackingIssue': TrackingIssue$json,
  '.google.devtools.clouderrorreporting.v1beta1.UpdateGroupRequest': UpdateGroupRequest$json,
};

