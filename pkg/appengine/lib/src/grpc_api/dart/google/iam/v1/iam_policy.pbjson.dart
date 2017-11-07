///
//  Generated code. Do not modify.
///
library google.iam.v1_iam_policy_pbjson;

import 'policy.pbjson.dart';

const SetIamPolicyRequest$json = const {
  '1': 'SetIamPolicyRequest',
  '2': const [
    const {'1': 'resource', '3': 1, '4': 1, '5': 9},
    const {'1': 'policy', '3': 2, '4': 1, '5': 11, '6': '.google.iam.v1.Policy'},
  ],
};

const GetIamPolicyRequest$json = const {
  '1': 'GetIamPolicyRequest',
  '2': const [
    const {'1': 'resource', '3': 1, '4': 1, '5': 9},
  ],
};

const TestIamPermissionsRequest$json = const {
  '1': 'TestIamPermissionsRequest',
  '2': const [
    const {'1': 'resource', '3': 1, '4': 1, '5': 9},
    const {'1': 'permissions', '3': 2, '4': 3, '5': 9},
  ],
};

const TestIamPermissionsResponse$json = const {
  '1': 'TestIamPermissionsResponse',
  '2': const [
    const {'1': 'permissions', '3': 1, '4': 3, '5': 9},
  ],
};

const IAMPolicy$json = const {
  '1': 'IAMPolicy',
  '2': const [
    const {'1': 'SetIamPolicy', '2': '.google.iam.v1.SetIamPolicyRequest', '3': '.google.iam.v1.Policy', '4': const {}},
    const {'1': 'GetIamPolicy', '2': '.google.iam.v1.GetIamPolicyRequest', '3': '.google.iam.v1.Policy', '4': const {}},
    const {'1': 'TestIamPermissions', '2': '.google.iam.v1.TestIamPermissionsRequest', '3': '.google.iam.v1.TestIamPermissionsResponse', '4': const {}},
  ],
};

const IAMPolicy$messageJson = const {
  '.google.iam.v1.SetIamPolicyRequest': SetIamPolicyRequest$json,
  '.google.iam.v1.Policy': Policy$json,
  '.google.iam.v1.Binding': Binding$json,
  '.google.iam.v1.GetIamPolicyRequest': GetIamPolicyRequest$json,
  '.google.iam.v1.TestIamPermissionsRequest': TestIamPermissionsRequest$json,
  '.google.iam.v1.TestIamPermissionsResponse': TestIamPermissionsResponse$json,
};

