///
//  Generated code. Do not modify.
///
library google.rpc_error_details_pbjson;

const RetryInfo$json = const {
  '1': 'RetryInfo',
  '2': const [
    const {'1': 'retry_delay', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
  ],
};

const DebugInfo$json = const {
  '1': 'DebugInfo',
  '2': const [
    const {'1': 'stack_entries', '3': 1, '4': 3, '5': 9},
    const {'1': 'detail', '3': 2, '4': 1, '5': 9},
  ],
};

const QuotaFailure$json = const {
  '1': 'QuotaFailure',
  '2': const [
    const {'1': 'violations', '3': 1, '4': 3, '5': 11, '6': '.google.rpc.QuotaFailure.Violation'},
  ],
  '3': const [QuotaFailure_Violation$json],
};

const QuotaFailure_Violation$json = const {
  '1': 'Violation',
  '2': const [
    const {'1': 'subject', '3': 1, '4': 1, '5': 9},
    const {'1': 'description', '3': 2, '4': 1, '5': 9},
  ],
};

const BadRequest$json = const {
  '1': 'BadRequest',
  '2': const [
    const {'1': 'field_violations', '3': 1, '4': 3, '5': 11, '6': '.google.rpc.BadRequest.FieldViolation'},
  ],
  '3': const [BadRequest_FieldViolation$json],
};

const BadRequest_FieldViolation$json = const {
  '1': 'FieldViolation',
  '2': const [
    const {'1': 'field', '3': 1, '4': 1, '5': 9},
    const {'1': 'description', '3': 2, '4': 1, '5': 9},
  ],
};

const RequestInfo$json = const {
  '1': 'RequestInfo',
  '2': const [
    const {'1': 'request_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'serving_data', '3': 2, '4': 1, '5': 9},
  ],
};

const ResourceInfo$json = const {
  '1': 'ResourceInfo',
  '2': const [
    const {'1': 'resource_type', '3': 1, '4': 1, '5': 9},
    const {'1': 'resource_name', '3': 2, '4': 1, '5': 9},
    const {'1': 'owner', '3': 3, '4': 1, '5': 9},
    const {'1': 'description', '3': 4, '4': 1, '5': 9},
  ],
};

const Help$json = const {
  '1': 'Help',
  '2': const [
    const {'1': 'links', '3': 1, '4': 3, '5': 11, '6': '.google.rpc.Help.Link'},
  ],
  '3': const [Help_Link$json],
};

const Help_Link$json = const {
  '1': 'Link',
  '2': const [
    const {'1': 'description', '3': 1, '4': 1, '5': 9},
    const {'1': 'url', '3': 2, '4': 1, '5': 9},
  ],
};

const LocalizedMessage$json = const {
  '1': 'LocalizedMessage',
  '2': const [
    const {'1': 'locale', '3': 1, '4': 1, '5': 9},
    const {'1': 'message', '3': 2, '4': 1, '5': 9},
  ],
};

