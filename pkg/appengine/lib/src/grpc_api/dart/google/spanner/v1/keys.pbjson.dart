///
//  Generated code. Do not modify.
///
library google.spanner.v1_keys_pbjson;

const KeyRange$json = const {
  '1': 'KeyRange',
  '2': const [
    const {'1': 'start_closed', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.ListValue'},
    const {'1': 'start_open', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.ListValue'},
    const {'1': 'end_closed', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.ListValue'},
    const {'1': 'end_open', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.ListValue'},
  ],
};

const KeySet$json = const {
  '1': 'KeySet',
  '2': const [
    const {'1': 'keys', '3': 1, '4': 3, '5': 11, '6': '.google.protobuf.ListValue'},
    const {'1': 'ranges', '3': 2, '4': 3, '5': 11, '6': '.google.spanner.v1.KeyRange'},
    const {'1': 'all', '3': 3, '4': 1, '5': 8},
  ],
};

