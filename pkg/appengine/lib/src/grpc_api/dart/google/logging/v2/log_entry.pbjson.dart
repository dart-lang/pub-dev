///
//  Generated code. Do not modify.
///
library google.logging.v2_log_entry_pbjson;

const LogEntry$json = const {
  '1': 'LogEntry',
  '2': const [
    const {'1': 'log_name', '3': 12, '4': 1, '5': 9},
    const {'1': 'resource', '3': 8, '4': 1, '5': 11, '6': '.google.api.MonitoredResource'},
    const {'1': 'proto_payload', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Any'},
    const {'1': 'text_payload', '3': 3, '4': 1, '5': 9},
    const {'1': 'json_payload', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Struct'},
    const {'1': 'timestamp', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'severity', '3': 10, '4': 1, '5': 14, '6': '.google.logging.type.LogSeverity'},
    const {'1': 'insert_id', '3': 4, '4': 1, '5': 9},
    const {'1': 'http_request', '3': 7, '4': 1, '5': 11, '6': '.google.logging.type.HttpRequest'},
    const {'1': 'labels', '3': 11, '4': 3, '5': 11, '6': '.google.logging.v2.LogEntry.LabelsEntry'},
    const {'1': 'operation', '3': 15, '4': 1, '5': 11, '6': '.google.logging.v2.LogEntryOperation'},
    const {'1': 'trace', '3': 22, '4': 1, '5': 9},
    const {'1': 'source_location', '3': 23, '4': 1, '5': 11, '6': '.google.logging.v2.LogEntrySourceLocation'},
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

const LogEntryOperation$json = const {
  '1': 'LogEntryOperation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9},
    const {'1': 'producer', '3': 2, '4': 1, '5': 9},
    const {'1': 'first', '3': 3, '4': 1, '5': 8},
    const {'1': 'last', '3': 4, '4': 1, '5': 8},
  ],
};

const LogEntrySourceLocation$json = const {
  '1': 'LogEntrySourceLocation',
  '2': const [
    const {'1': 'file', '3': 1, '4': 1, '5': 9},
    const {'1': 'line', '3': 2, '4': 1, '5': 3},
    const {'1': 'function', '3': 3, '4': 1, '5': 9},
  ],
};

