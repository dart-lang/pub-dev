///
//  Generated code. Do not modify.
///
library google.api.servicecontrol.v1_log_entry_pbjson;

const LogEntry$json = const {
  '1': 'LogEntry',
  '2': const [
    const {'1': 'name', '3': 10, '4': 1, '5': 9},
    const {'1': 'timestamp', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'severity', '3': 12, '4': 1, '5': 14, '6': '.google.logging.type.LogSeverity'},
    const {'1': 'insert_id', '3': 4, '4': 1, '5': 9},
    const {'1': 'labels', '3': 13, '4': 3, '5': 11, '6': '.google.api.servicecontrol.v1.LogEntry.LabelsEntry'},
    const {'1': 'proto_payload', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Any'},
    const {'1': 'text_payload', '3': 3, '4': 1, '5': 9},
    const {'1': 'struct_payload', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Struct'},
  ],
  '3': const [LogEntry_LabelsEntry$json],
};

const LogEntry_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

