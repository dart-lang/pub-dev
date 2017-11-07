///
//  Generated code. Do not modify.
///
library google.api_config_change_pbjson;

const ChangeType$json = const {
  '1': 'ChangeType',
  '2': const [
    const {'1': 'CHANGE_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'ADDED', '2': 1},
    const {'1': 'REMOVED', '2': 2},
    const {'1': 'MODIFIED', '2': 3},
  ],
};

const ConfigChange$json = const {
  '1': 'ConfigChange',
  '2': const [
    const {'1': 'element', '3': 1, '4': 1, '5': 9},
    const {'1': 'old_value', '3': 2, '4': 1, '5': 9},
    const {'1': 'new_value', '3': 3, '4': 1, '5': 9},
    const {'1': 'change_type', '3': 4, '4': 1, '5': 14, '6': '.google.api.ChangeType'},
    const {'1': 'advices', '3': 5, '4': 3, '5': 11, '6': '.google.api.Advice'},
  ],
};

const Advice$json = const {
  '1': 'Advice',
  '2': const [
    const {'1': 'description', '3': 2, '4': 1, '5': 9},
  ],
};

