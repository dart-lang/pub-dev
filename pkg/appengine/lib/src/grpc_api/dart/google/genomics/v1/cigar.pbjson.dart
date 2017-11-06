///
//  Generated code. Do not modify.
///
library google.genomics.v1_cigar_pbjson;

const CigarUnit$json = const {
  '1': 'CigarUnit',
  '2': const [
    const {'1': 'operation', '3': 1, '4': 1, '5': 14, '6': '.google.genomics.v1.CigarUnit.Operation'},
    const {'1': 'operation_length', '3': 2, '4': 1, '5': 3},
    const {'1': 'reference_sequence', '3': 3, '4': 1, '5': 9},
  ],
  '4': const [CigarUnit_Operation$json],
};

const CigarUnit_Operation$json = const {
  '1': 'Operation',
  '2': const [
    const {'1': 'OPERATION_UNSPECIFIED', '2': 0},
    const {'1': 'ALIGNMENT_MATCH', '2': 1},
    const {'1': 'INSERT', '2': 2},
    const {'1': 'DELETE', '2': 3},
    const {'1': 'SKIP', '2': 4},
    const {'1': 'CLIP_SOFT', '2': 5},
    const {'1': 'CLIP_HARD', '2': 6},
    const {'1': 'PAD', '2': 7},
    const {'1': 'SEQUENCE_MATCH', '2': 8},
    const {'1': 'SEQUENCE_MISMATCH', '2': 9},
  ],
};

