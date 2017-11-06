///
//  Generated code. Do not modify.
///
library google.genomics.v1_datasets_pbjson;

import '../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../protobuf/field_mask.pbjson.dart' as google$protobuf;
import '../../protobuf/empty.pbjson.dart' as google$protobuf;
import '../../iam/v1/iam_policy.pbjson.dart' as google$iam$v1;
import '../../iam/v1/policy.pbjson.dart' as google$iam$v1;

const Dataset$json = const {
  '1': 'Dataset',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9},
    const {'1': 'project_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'name', '3': 3, '4': 1, '5': 9},
    const {'1': 'create_time', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const ListDatasetsRequest$json = const {
  '1': 'ListDatasetsRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListDatasetsResponse$json = const {
  '1': 'ListDatasetsResponse',
  '2': const [
    const {'1': 'datasets', '3': 1, '4': 3, '5': 11, '6': '.google.genomics.v1.Dataset'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const CreateDatasetRequest$json = const {
  '1': 'CreateDatasetRequest',
  '2': const [
    const {'1': 'dataset', '3': 1, '4': 1, '5': 11, '6': '.google.genomics.v1.Dataset'},
  ],
};

const UpdateDatasetRequest$json = const {
  '1': 'UpdateDatasetRequest',
  '2': const [
    const {'1': 'dataset_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'dataset', '3': 2, '4': 1, '5': 11, '6': '.google.genomics.v1.Dataset'},
    const {'1': 'update_mask', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask'},
  ],
};

const DeleteDatasetRequest$json = const {
  '1': 'DeleteDatasetRequest',
  '2': const [
    const {'1': 'dataset_id', '3': 1, '4': 1, '5': 9},
  ],
};

const UndeleteDatasetRequest$json = const {
  '1': 'UndeleteDatasetRequest',
  '2': const [
    const {'1': 'dataset_id', '3': 1, '4': 1, '5': 9},
  ],
};

const GetDatasetRequest$json = const {
  '1': 'GetDatasetRequest',
  '2': const [
    const {'1': 'dataset_id', '3': 1, '4': 1, '5': 9},
  ],
};

const DatasetServiceV1$json = const {
  '1': 'DatasetServiceV1',
  '2': const [
    const {'1': 'ListDatasets', '2': '.google.genomics.v1.ListDatasetsRequest', '3': '.google.genomics.v1.ListDatasetsResponse', '4': const {}},
    const {'1': 'CreateDataset', '2': '.google.genomics.v1.CreateDatasetRequest', '3': '.google.genomics.v1.Dataset', '4': const {}},
    const {'1': 'GetDataset', '2': '.google.genomics.v1.GetDatasetRequest', '3': '.google.genomics.v1.Dataset', '4': const {}},
    const {'1': 'UpdateDataset', '2': '.google.genomics.v1.UpdateDatasetRequest', '3': '.google.genomics.v1.Dataset', '4': const {}},
    const {'1': 'DeleteDataset', '2': '.google.genomics.v1.DeleteDatasetRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'UndeleteDataset', '2': '.google.genomics.v1.UndeleteDatasetRequest', '3': '.google.genomics.v1.Dataset', '4': const {}},
    const {'1': 'SetIamPolicy', '2': '.google.iam.v1.SetIamPolicyRequest', '3': '.google.iam.v1.Policy', '4': const {}},
    const {'1': 'GetIamPolicy', '2': '.google.iam.v1.GetIamPolicyRequest', '3': '.google.iam.v1.Policy', '4': const {}},
    const {'1': 'TestIamPermissions', '2': '.google.iam.v1.TestIamPermissionsRequest', '3': '.google.iam.v1.TestIamPermissionsResponse', '4': const {}},
  ],
};

const DatasetServiceV1$messageJson = const {
  '.google.genomics.v1.ListDatasetsRequest': ListDatasetsRequest$json,
  '.google.genomics.v1.ListDatasetsResponse': ListDatasetsResponse$json,
  '.google.genomics.v1.Dataset': Dataset$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.genomics.v1.CreateDatasetRequest': CreateDatasetRequest$json,
  '.google.genomics.v1.GetDatasetRequest': GetDatasetRequest$json,
  '.google.genomics.v1.UpdateDatasetRequest': UpdateDatasetRequest$json,
  '.google.protobuf.FieldMask': google$protobuf.FieldMask$json,
  '.google.genomics.v1.DeleteDatasetRequest': DeleteDatasetRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.genomics.v1.UndeleteDatasetRequest': UndeleteDatasetRequest$json,
  '.google.iam.v1.SetIamPolicyRequest': google$iam$v1.SetIamPolicyRequest$json,
  '.google.iam.v1.Policy': google$iam$v1.Policy$json,
  '.google.iam.v1.Binding': google$iam$v1.Binding$json,
  '.google.iam.v1.GetIamPolicyRequest': google$iam$v1.GetIamPolicyRequest$json,
  '.google.iam.v1.TestIamPermissionsRequest': google$iam$v1.TestIamPermissionsRequest$json,
  '.google.iam.v1.TestIamPermissionsResponse': google$iam$v1.TestIamPermissionsResponse$json,
};

