///
//  Generated code. Do not modify.
///
library google.genomics.v1_readgroup_pbjson;

const ReadGroup$json = const {
  '1': 'ReadGroup',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9},
    const {'1': 'dataset_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'name', '3': 3, '4': 1, '5': 9},
    const {'1': 'description', '3': 4, '4': 1, '5': 9},
    const {'1': 'sample_id', '3': 5, '4': 1, '5': 9},
    const {'1': 'experiment', '3': 6, '4': 1, '5': 11, '6': '.google.genomics.v1.ReadGroup.Experiment'},
    const {'1': 'predicted_insert_size', '3': 7, '4': 1, '5': 5},
    const {'1': 'programs', '3': 10, '4': 3, '5': 11, '6': '.google.genomics.v1.ReadGroup.Program'},
    const {'1': 'reference_set_id', '3': 11, '4': 1, '5': 9},
    const {'1': 'info', '3': 12, '4': 3, '5': 11, '6': '.google.genomics.v1.ReadGroup.InfoEntry'},
  ],
  '3': const [ReadGroup_Experiment$json, ReadGroup_Program$json, ReadGroup_InfoEntry$json],
};

const ReadGroup_Experiment$json = const {
  '1': 'Experiment',
  '2': const [
    const {'1': 'library_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'platform_unit', '3': 2, '4': 1, '5': 9},
    const {'1': 'sequencing_center', '3': 3, '4': 1, '5': 9},
    const {'1': 'instrument_model', '3': 4, '4': 1, '5': 9},
  ],
};

const ReadGroup_Program$json = const {
  '1': 'Program',
  '2': const [
    const {'1': 'command_line', '3': 1, '4': 1, '5': 9},
    const {'1': 'id', '3': 2, '4': 1, '5': 9},
    const {'1': 'name', '3': 3, '4': 1, '5': 9},
    const {'1': 'prev_program_id', '3': 4, '4': 1, '5': 9},
    const {'1': 'version', '3': 5, '4': 1, '5': 9},
  ],
};

const ReadGroup_InfoEntry$json = const {
  '1': 'InfoEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.ListValue'},
  ],
  '7': const {},
};

