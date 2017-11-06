///
//  Generated code. Do not modify.
///
library google.iam.admin.v1_iam_pbjson;

import '../../../protobuf/empty.pbjson.dart' as google$protobuf;
import '../../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../v1/iam_policy.pbjson.dart' as google$iam$v1;
import '../../v1/policy.pbjson.dart' as google$iam$v1;

const ServiceAccountKeyAlgorithm$json = const {
  '1': 'ServiceAccountKeyAlgorithm',
  '2': const [
    const {'1': 'KEY_ALG_UNSPECIFIED', '2': 0},
    const {'1': 'KEY_ALG_RSA_1024', '2': 1},
    const {'1': 'KEY_ALG_RSA_2048', '2': 2},
  ],
};

const ServiceAccountPrivateKeyType$json = const {
  '1': 'ServiceAccountPrivateKeyType',
  '2': const [
    const {'1': 'TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'TYPE_PKCS12_FILE', '2': 1},
    const {'1': 'TYPE_GOOGLE_CREDENTIALS_FILE', '2': 2},
  ],
};

const ServiceAccountPublicKeyType$json = const {
  '1': 'ServiceAccountPublicKeyType',
  '2': const [
    const {'1': 'TYPE_NONE', '2': 0},
    const {'1': 'TYPE_X509_PEM_FILE', '2': 1},
    const {'1': 'TYPE_RAW_PUBLIC_KEY', '2': 2},
  ],
};

const ServiceAccount$json = const {
  '1': 'ServiceAccount',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'project_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'unique_id', '3': 4, '4': 1, '5': 9},
    const {'1': 'email', '3': 5, '4': 1, '5': 9},
    const {'1': 'display_name', '3': 6, '4': 1, '5': 9},
    const {'1': 'etag', '3': 7, '4': 1, '5': 12},
    const {'1': 'oauth2_client_id', '3': 9, '4': 1, '5': 9},
  ],
};

const CreateServiceAccountRequest$json = const {
  '1': 'CreateServiceAccountRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'service_account', '3': 3, '4': 1, '5': 11, '6': '.google.iam.admin.v1.ServiceAccount'},
  ],
};

const ListServiceAccountsRequest$json = const {
  '1': 'ListServiceAccountsRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListServiceAccountsResponse$json = const {
  '1': 'ListServiceAccountsResponse',
  '2': const [
    const {'1': 'accounts', '3': 1, '4': 3, '5': 11, '6': '.google.iam.admin.v1.ServiceAccount'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const GetServiceAccountRequest$json = const {
  '1': 'GetServiceAccountRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const DeleteServiceAccountRequest$json = const {
  '1': 'DeleteServiceAccountRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ListServiceAccountKeysRequest$json = const {
  '1': 'ListServiceAccountKeysRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'key_types', '3': 2, '4': 3, '5': 14, '6': '.google.iam.admin.v1.ListServiceAccountKeysRequest.KeyType'},
  ],
  '4': const [ListServiceAccountKeysRequest_KeyType$json],
};

const ListServiceAccountKeysRequest_KeyType$json = const {
  '1': 'KeyType',
  '2': const [
    const {'1': 'KEY_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'USER_MANAGED', '2': 1},
    const {'1': 'SYSTEM_MANAGED', '2': 2},
  ],
};

const ListServiceAccountKeysResponse$json = const {
  '1': 'ListServiceAccountKeysResponse',
  '2': const [
    const {'1': 'keys', '3': 1, '4': 3, '5': 11, '6': '.google.iam.admin.v1.ServiceAccountKey'},
  ],
};

const GetServiceAccountKeyRequest$json = const {
  '1': 'GetServiceAccountKeyRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'public_key_type', '3': 2, '4': 1, '5': 14, '6': '.google.iam.admin.v1.ServiceAccountPublicKeyType'},
  ],
};

const ServiceAccountKey$json = const {
  '1': 'ServiceAccountKey',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'private_key_type', '3': 2, '4': 1, '5': 14, '6': '.google.iam.admin.v1.ServiceAccountPrivateKeyType'},
    const {'1': 'key_algorithm', '3': 8, '4': 1, '5': 14, '6': '.google.iam.admin.v1.ServiceAccountKeyAlgorithm'},
    const {'1': 'private_key_data', '3': 3, '4': 1, '5': 12},
    const {'1': 'public_key_data', '3': 7, '4': 1, '5': 12},
    const {'1': 'valid_after_time', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'valid_before_time', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const CreateServiceAccountKeyRequest$json = const {
  '1': 'CreateServiceAccountKeyRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'private_key_type', '3': 2, '4': 1, '5': 14, '6': '.google.iam.admin.v1.ServiceAccountPrivateKeyType'},
    const {'1': 'key_algorithm', '3': 3, '4': 1, '5': 14, '6': '.google.iam.admin.v1.ServiceAccountKeyAlgorithm'},
  ],
};

const DeleteServiceAccountKeyRequest$json = const {
  '1': 'DeleteServiceAccountKeyRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const SignBlobRequest$json = const {
  '1': 'SignBlobRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'bytes_to_sign', '3': 2, '4': 1, '5': 12},
  ],
};

const SignBlobResponse$json = const {
  '1': 'SignBlobResponse',
  '2': const [
    const {'1': 'key_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12},
  ],
};

const Role$json = const {
  '1': 'Role',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'title', '3': 2, '4': 1, '5': 9},
    const {'1': 'description', '3': 3, '4': 1, '5': 9},
  ],
};

const QueryGrantableRolesRequest$json = const {
  '1': 'QueryGrantableRolesRequest',
  '2': const [
    const {'1': 'full_resource_name', '3': 1, '4': 1, '5': 9},
  ],
};

const QueryGrantableRolesResponse$json = const {
  '1': 'QueryGrantableRolesResponse',
  '2': const [
    const {'1': 'roles', '3': 1, '4': 3, '5': 11, '6': '.google.iam.admin.v1.Role'},
  ],
};

const IAM$json = const {
  '1': 'IAM',
  '2': const [
    const {'1': 'ListServiceAccounts', '2': '.google.iam.admin.v1.ListServiceAccountsRequest', '3': '.google.iam.admin.v1.ListServiceAccountsResponse', '4': const {}},
    const {'1': 'GetServiceAccount', '2': '.google.iam.admin.v1.GetServiceAccountRequest', '3': '.google.iam.admin.v1.ServiceAccount', '4': const {}},
    const {'1': 'CreateServiceAccount', '2': '.google.iam.admin.v1.CreateServiceAccountRequest', '3': '.google.iam.admin.v1.ServiceAccount', '4': const {}},
    const {'1': 'UpdateServiceAccount', '2': '.google.iam.admin.v1.ServiceAccount', '3': '.google.iam.admin.v1.ServiceAccount', '4': const {}},
    const {'1': 'DeleteServiceAccount', '2': '.google.iam.admin.v1.DeleteServiceAccountRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'ListServiceAccountKeys', '2': '.google.iam.admin.v1.ListServiceAccountKeysRequest', '3': '.google.iam.admin.v1.ListServiceAccountKeysResponse', '4': const {}},
    const {'1': 'GetServiceAccountKey', '2': '.google.iam.admin.v1.GetServiceAccountKeyRequest', '3': '.google.iam.admin.v1.ServiceAccountKey', '4': const {}},
    const {'1': 'CreateServiceAccountKey', '2': '.google.iam.admin.v1.CreateServiceAccountKeyRequest', '3': '.google.iam.admin.v1.ServiceAccountKey', '4': const {}},
    const {'1': 'DeleteServiceAccountKey', '2': '.google.iam.admin.v1.DeleteServiceAccountKeyRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'SignBlob', '2': '.google.iam.admin.v1.SignBlobRequest', '3': '.google.iam.admin.v1.SignBlobResponse', '4': const {}},
    const {'1': 'GetIamPolicy', '2': '.google.iam.v1.GetIamPolicyRequest', '3': '.google.iam.v1.Policy', '4': const {}},
    const {'1': 'SetIamPolicy', '2': '.google.iam.v1.SetIamPolicyRequest', '3': '.google.iam.v1.Policy', '4': const {}},
    const {'1': 'TestIamPermissions', '2': '.google.iam.v1.TestIamPermissionsRequest', '3': '.google.iam.v1.TestIamPermissionsResponse', '4': const {}},
    const {'1': 'QueryGrantableRoles', '2': '.google.iam.admin.v1.QueryGrantableRolesRequest', '3': '.google.iam.admin.v1.QueryGrantableRolesResponse', '4': const {}},
  ],
};

const IAM$messageJson = const {
  '.google.iam.admin.v1.ListServiceAccountsRequest': ListServiceAccountsRequest$json,
  '.google.iam.admin.v1.ListServiceAccountsResponse': ListServiceAccountsResponse$json,
  '.google.iam.admin.v1.ServiceAccount': ServiceAccount$json,
  '.google.iam.admin.v1.GetServiceAccountRequest': GetServiceAccountRequest$json,
  '.google.iam.admin.v1.CreateServiceAccountRequest': CreateServiceAccountRequest$json,
  '.google.iam.admin.v1.DeleteServiceAccountRequest': DeleteServiceAccountRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.iam.admin.v1.ListServiceAccountKeysRequest': ListServiceAccountKeysRequest$json,
  '.google.iam.admin.v1.ListServiceAccountKeysResponse': ListServiceAccountKeysResponse$json,
  '.google.iam.admin.v1.ServiceAccountKey': ServiceAccountKey$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.iam.admin.v1.GetServiceAccountKeyRequest': GetServiceAccountKeyRequest$json,
  '.google.iam.admin.v1.CreateServiceAccountKeyRequest': CreateServiceAccountKeyRequest$json,
  '.google.iam.admin.v1.DeleteServiceAccountKeyRequest': DeleteServiceAccountKeyRequest$json,
  '.google.iam.admin.v1.SignBlobRequest': SignBlobRequest$json,
  '.google.iam.admin.v1.SignBlobResponse': SignBlobResponse$json,
  '.google.iam.v1.GetIamPolicyRequest': google$iam$v1.GetIamPolicyRequest$json,
  '.google.iam.v1.Policy': google$iam$v1.Policy$json,
  '.google.iam.v1.Binding': google$iam$v1.Binding$json,
  '.google.iam.v1.SetIamPolicyRequest': google$iam$v1.SetIamPolicyRequest$json,
  '.google.iam.v1.TestIamPermissionsRequest': google$iam$v1.TestIamPermissionsRequest$json,
  '.google.iam.v1.TestIamPermissionsResponse': google$iam$v1.TestIamPermissionsResponse$json,
  '.google.iam.admin.v1.QueryGrantableRolesRequest': QueryGrantableRolesRequest$json,
  '.google.iam.admin.v1.QueryGrantableRolesResponse': QueryGrantableRolesResponse$json,
  '.google.iam.admin.v1.Role': Role$json,
};

