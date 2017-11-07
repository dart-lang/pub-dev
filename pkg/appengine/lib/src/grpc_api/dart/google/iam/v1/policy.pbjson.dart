///
//  Generated code. Do not modify.
///
library google.iam.v1_policy_pbjson;

const Policy$json = const {
  '1': 'Policy',
  '2': const [
    const {'1': 'version', '3': 1, '4': 1, '5': 5},
    const {'1': 'bindings', '3': 4, '4': 3, '5': 11, '6': '.google.iam.v1.Binding'},
    const {'1': 'etag', '3': 3, '4': 1, '5': 12},
  ],
};

const Binding$json = const {
  '1': 'Binding',
  '2': const [
    const {'1': 'role', '3': 1, '4': 1, '5': 9},
    const {'1': 'members', '3': 2, '4': 3, '5': 9},
  ],
};

const PolicyDelta$json = const {
  '1': 'PolicyDelta',
  '2': const [
    const {'1': 'binding_deltas', '3': 1, '4': 3, '5': 11, '6': '.google.iam.v1.BindingDelta'},
  ],
};

const BindingDelta$json = const {
  '1': 'BindingDelta',
  '2': const [
    const {'1': 'action', '3': 1, '4': 1, '5': 14, '6': '.google.iam.v1.BindingDelta.Action'},
    const {'1': 'role', '3': 2, '4': 1, '5': 9},
    const {'1': 'member', '3': 3, '4': 1, '5': 9},
  ],
  '4': const [BindingDelta_Action$json],
};

const BindingDelta_Action$json = const {
  '1': 'Action',
  '2': const [
    const {'1': 'ACTION_UNSPECIFIED', '2': 0},
    const {'1': 'ADD', '2': 1},
    const {'1': 'REMOVE', '2': 2},
  ],
};

