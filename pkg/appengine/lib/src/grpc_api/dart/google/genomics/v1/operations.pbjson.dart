///
//  Generated code. Do not modify.
///
library google.genomics.v1_operations_pbjson;

const OperationMetadata$json = const {
  '1': 'OperationMetadata',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'create_time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'start_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'end_time', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'request', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Any'},
    const {'1': 'events', '3': 6, '4': 3, '5': 11, '6': '.google.genomics.v1.OperationEvent'},
    const {'1': 'client_id', '3': 7, '4': 1, '5': 9},
    const {'1': 'runtime_metadata', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Any'},
    const {'1': 'labels', '3': 9, '4': 3, '5': 11, '6': '.google.genomics.v1.OperationMetadata.LabelsEntry'},
  ],
  '3': const [OperationMetadata_LabelsEntry$json],
};

const OperationMetadata_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const OperationEvent$json = const {
  '1': 'OperationEvent',
  '2': const [
    const {'1': 'start_time', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'end_time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9},
  ],
};

