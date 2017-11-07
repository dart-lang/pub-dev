///
//  Generated code. Do not modify.
///
library google.cloud.ml.v1beta1_project_service_pbjson;

const GetConfigRequest$json = const {
  '1': 'GetConfigRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const GetConfigResponse$json = const {
  '1': 'GetConfigResponse',
  '2': const [
    const {'1': 'service_account', '3': 1, '4': 1, '5': 9},
    const {'1': 'service_account_project', '3': 2, '4': 1, '5': 3},
  ],
};

const ProjectManagementService$json = const {
  '1': 'ProjectManagementService',
  '2': const [
    const {'1': 'GetConfig', '2': '.google.cloud.ml.v1beta1.GetConfigRequest', '3': '.google.cloud.ml.v1beta1.GetConfigResponse', '4': const {}},
  ],
};

const ProjectManagementService$messageJson = const {
  '.google.cloud.ml.v1beta1.GetConfigRequest': GetConfigRequest$json,
  '.google.cloud.ml.v1beta1.GetConfigResponse': GetConfigResponse$json,
};

