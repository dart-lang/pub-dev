///
//  Generated code. Do not modify.
///
library google.spanner.v1_mutation_pbjson;

const Mutation$json = const {
  '1': 'Mutation',
  '2': const [
    const {'1': 'insert', '3': 1, '4': 1, '5': 11, '6': '.google.spanner.v1.Mutation.Write'},
    const {'1': 'update', '3': 2, '4': 1, '5': 11, '6': '.google.spanner.v1.Mutation.Write'},
    const {'1': 'insert_or_update', '3': 3, '4': 1, '5': 11, '6': '.google.spanner.v1.Mutation.Write'},
    const {'1': 'replace', '3': 4, '4': 1, '5': 11, '6': '.google.spanner.v1.Mutation.Write'},
    const {'1': 'delete', '3': 5, '4': 1, '5': 11, '6': '.google.spanner.v1.Mutation.Delete'},
  ],
  '3': const [Mutation_Write$json, Mutation_Delete$json],
};

const Mutation_Write$json = const {
  '1': 'Write',
  '2': const [
    const {'1': 'table', '3': 1, '4': 1, '5': 9},
    const {'1': 'columns', '3': 2, '4': 3, '5': 9},
    const {'1': 'values', '3': 3, '4': 3, '5': 11, '6': '.google.protobuf.ListValue'},
  ],
};

const Mutation_Delete$json = const {
  '1': 'Delete',
  '2': const [
    const {'1': 'table', '3': 1, '4': 1, '5': 9},
    const {'1': 'key_set', '3': 2, '4': 1, '5': 11, '6': '.google.spanner.v1.KeySet'},
  ],
};

