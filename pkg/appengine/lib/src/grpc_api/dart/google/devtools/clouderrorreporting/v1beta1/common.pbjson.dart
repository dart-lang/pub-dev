///
//  Generated code. Do not modify.
///
library google.devtools.clouderrorreporting.v1beta1_common_pbjson;

const ErrorGroup$json = const {
  '1': 'ErrorGroup',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'tracking_issues', '3': 3, '4': 3, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.TrackingIssue'},
  ],
};

const TrackingIssue$json = const {
  '1': 'TrackingIssue',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9},
  ],
};

const ErrorEvent$json = const {
  '1': 'ErrorEvent',
  '2': const [
    const {'1': 'event_time', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'service_context', '3': 2, '4': 1, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.ServiceContext'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9},
    const {'1': 'context', '3': 5, '4': 1, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.ErrorContext'},
  ],
};

const ServiceContext$json = const {
  '1': 'ServiceContext',
  '2': const [
    const {'1': 'service', '3': 2, '4': 1, '5': 9},
    const {'1': 'version', '3': 3, '4': 1, '5': 9},
    const {'1': 'resource_type', '3': 4, '4': 1, '5': 9},
  ],
};

const ErrorContext$json = const {
  '1': 'ErrorContext',
  '2': const [
    const {'1': 'http_request', '3': 1, '4': 1, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.HttpRequestContext'},
    const {'1': 'user', '3': 2, '4': 1, '5': 9},
    const {'1': 'report_location', '3': 3, '4': 1, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.SourceLocation'},
  ],
};

const HttpRequestContext$json = const {
  '1': 'HttpRequestContext',
  '2': const [
    const {'1': 'method', '3': 1, '4': 1, '5': 9},
    const {'1': 'url', '3': 2, '4': 1, '5': 9},
    const {'1': 'user_agent', '3': 3, '4': 1, '5': 9},
    const {'1': 'referrer', '3': 4, '4': 1, '5': 9},
    const {'1': 'response_status_code', '3': 5, '4': 1, '5': 5},
    const {'1': 'remote_ip', '3': 6, '4': 1, '5': 9},
  ],
};

const SourceLocation$json = const {
  '1': 'SourceLocation',
  '2': const [
    const {'1': 'file_path', '3': 1, '4': 1, '5': 9},
    const {'1': 'line_number', '3': 2, '4': 1, '5': 5},
    const {'1': 'function_name', '3': 4, '4': 1, '5': 9},
  ],
};

