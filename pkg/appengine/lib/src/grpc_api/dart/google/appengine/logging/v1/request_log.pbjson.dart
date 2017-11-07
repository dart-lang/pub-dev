///
//  Generated code. Do not modify.
///
library google.appengine.logging.v1_request_log_pbjson;

const LogLine$json = const {
  '1': 'LogLine',
  '2': const [
    const {'1': 'time', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'severity', '3': 2, '4': 1, '5': 14, '6': '.google.logging.type.LogSeverity'},
    const {'1': 'log_message', '3': 3, '4': 1, '5': 9},
    const {'1': 'source_location', '3': 4, '4': 1, '5': 11, '6': '.google.appengine.logging.v1.SourceLocation'},
  ],
};

const SourceLocation$json = const {
  '1': 'SourceLocation',
  '2': const [
    const {'1': 'file', '3': 1, '4': 1, '5': 9},
    const {'1': 'line', '3': 2, '4': 1, '5': 3},
    const {'1': 'function_name', '3': 3, '4': 1, '5': 9},
  ],
};

const SourceReference$json = const {
  '1': 'SourceReference',
  '2': const [
    const {'1': 'repository', '3': 1, '4': 1, '5': 9},
    const {'1': 'revision_id', '3': 2, '4': 1, '5': 9},
  ],
};

const RequestLog$json = const {
  '1': 'RequestLog',
  '2': const [
    const {'1': 'app_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'module_id', '3': 37, '4': 1, '5': 9},
    const {'1': 'version_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'request_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'ip', '3': 4, '4': 1, '5': 9},
    const {'1': 'start_time', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'end_time', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'latency', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'mega_cycles', '3': 9, '4': 1, '5': 3},
    const {'1': 'method', '3': 10, '4': 1, '5': 9},
    const {'1': 'resource', '3': 11, '4': 1, '5': 9},
    const {'1': 'http_version', '3': 12, '4': 1, '5': 9},
    const {'1': 'status', '3': 13, '4': 1, '5': 5},
    const {'1': 'response_size', '3': 14, '4': 1, '5': 3},
    const {'1': 'referrer', '3': 15, '4': 1, '5': 9},
    const {'1': 'user_agent', '3': 16, '4': 1, '5': 9},
    const {'1': 'nickname', '3': 40, '4': 1, '5': 9},
    const {'1': 'url_map_entry', '3': 17, '4': 1, '5': 9},
    const {'1': 'host', '3': 20, '4': 1, '5': 9},
    const {'1': 'cost', '3': 21, '4': 1, '5': 1},
    const {'1': 'task_queue_name', '3': 22, '4': 1, '5': 9},
    const {'1': 'task_name', '3': 23, '4': 1, '5': 9},
    const {'1': 'was_loading_request', '3': 24, '4': 1, '5': 8},
    const {'1': 'pending_time', '3': 25, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'instance_index', '3': 26, '4': 1, '5': 5},
    const {'1': 'finished', '3': 27, '4': 1, '5': 8},
    const {'1': 'first', '3': 42, '4': 1, '5': 8},
    const {'1': 'instance_id', '3': 28, '4': 1, '5': 9},
    const {'1': 'line', '3': 29, '4': 3, '5': 11, '6': '.google.appengine.logging.v1.LogLine'},
    const {'1': 'app_engine_release', '3': 38, '4': 1, '5': 9},
    const {'1': 'trace_id', '3': 39, '4': 1, '5': 9},
    const {'1': 'source_reference', '3': 41, '4': 3, '5': 11, '6': '.google.appengine.logging.v1.SourceReference'},
  ],
};

