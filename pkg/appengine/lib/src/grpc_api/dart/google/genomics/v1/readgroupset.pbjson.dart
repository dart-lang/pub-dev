///
//  Generated code. Do not modify.
///
library google.genomics.v1_readgroupset_pbjson;

const ReadGroupSet$json = const {
  '1': 'ReadGroupSet',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9},
    const {'1': 'dataset_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'reference_set_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'name', '3': 4, '4': 1, '5': 9},
    const {'1': 'filename', '3': 5, '4': 1, '5': 9},
    const {'1': 'read_groups', '3': 6, '4': 3, '5': 11, '6': '.google.genomics.v1.ReadGroup'},
    const {'1': 'info', '3': 7, '4': 3, '5': 11, '6': '.google.genomics.v1.ReadGroupSet.InfoEntry'},
  ],
  '3': const [ReadGroupSet_InfoEntry$json],
};

const ReadGroupSet_InfoEntry$json = const {
  '1': 'InfoEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.ListValue'},
  ],
  '7': const {},
};

