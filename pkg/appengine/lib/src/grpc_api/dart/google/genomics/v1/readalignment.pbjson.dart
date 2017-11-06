///
//  Generated code. Do not modify.
///
library google.genomics.v1_readalignment_pbjson;

const LinearAlignment$json = const {
  '1': 'LinearAlignment',
  '2': const [
    const {'1': 'position', '3': 1, '4': 1, '5': 11, '6': '.google.genomics.v1.Position'},
    const {'1': 'mapping_quality', '3': 2, '4': 1, '5': 5},
    const {'1': 'cigar', '3': 3, '4': 3, '5': 11, '6': '.google.genomics.v1.CigarUnit'},
  ],
};

const Read$json = const {
  '1': 'Read',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9},
    const {'1': 'read_group_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'read_group_set_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'fragment_name', '3': 4, '4': 1, '5': 9},
    const {'1': 'proper_placement', '3': 5, '4': 1, '5': 8},
    const {'1': 'duplicate_fragment', '3': 6, '4': 1, '5': 8},
    const {'1': 'fragment_length', '3': 7, '4': 1, '5': 5},
    const {'1': 'read_number', '3': 8, '4': 1, '5': 5},
    const {'1': 'number_reads', '3': 9, '4': 1, '5': 5},
    const {'1': 'failed_vendor_quality_checks', '3': 10, '4': 1, '5': 8},
    const {'1': 'alignment', '3': 11, '4': 1, '5': 11, '6': '.google.genomics.v1.LinearAlignment'},
    const {'1': 'secondary_alignment', '3': 12, '4': 1, '5': 8},
    const {'1': 'supplementary_alignment', '3': 13, '4': 1, '5': 8},
    const {'1': 'aligned_sequence', '3': 14, '4': 1, '5': 9},
    const {'1': 'aligned_quality', '3': 15, '4': 3, '5': 5},
    const {'1': 'next_mate_position', '3': 16, '4': 1, '5': 11, '6': '.google.genomics.v1.Position'},
    const {'1': 'info', '3': 17, '4': 3, '5': 11, '6': '.google.genomics.v1.Read.InfoEntry'},
  ],
  '3': const [Read_InfoEntry$json],
};

const Read_InfoEntry$json = const {
  '1': 'InfoEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.ListValue'},
  ],
  '7': const {},
};

