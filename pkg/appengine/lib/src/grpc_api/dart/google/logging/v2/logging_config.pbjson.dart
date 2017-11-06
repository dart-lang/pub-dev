///
//  Generated code. Do not modify.
///
library google.logging.v2_logging_config_pbjson;

import '../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../protobuf/empty.pbjson.dart' as google$protobuf;

const LogSink$json = const {
  '1': 'LogSink',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'destination', '3': 3, '4': 1, '5': 9},
    const {'1': 'filter', '3': 5, '4': 1, '5': 9},
    const {'1': 'output_version_format', '3': 6, '4': 1, '5': 14, '6': '.google.logging.v2.LogSink.VersionFormat'},
    const {'1': 'writer_identity', '3': 8, '4': 1, '5': 9},
    const {'1': 'start_time', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'end_time', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
  '4': const [LogSink_VersionFormat$json],
};

const LogSink_VersionFormat$json = const {
  '1': 'VersionFormat',
  '2': const [
    const {'1': 'VERSION_FORMAT_UNSPECIFIED', '2': 0},
    const {'1': 'V2', '2': 1},
    const {'1': 'V1', '2': 2},
  ],
};

const ListSinksRequest$json = const {
  '1': 'ListSinksRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5},
  ],
};

const ListSinksResponse$json = const {
  '1': 'ListSinksResponse',
  '2': const [
    const {'1': 'sinks', '3': 1, '4': 3, '5': 11, '6': '.google.logging.v2.LogSink'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const GetSinkRequest$json = const {
  '1': 'GetSinkRequest',
  '2': const [
    const {'1': 'sink_name', '3': 1, '4': 1, '5': 9},
  ],
};

const CreateSinkRequest$json = const {
  '1': 'CreateSinkRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'sink', '3': 2, '4': 1, '5': 11, '6': '.google.logging.v2.LogSink'},
    const {'1': 'unique_writer_identity', '3': 3, '4': 1, '5': 8},
  ],
};

const UpdateSinkRequest$json = const {
  '1': 'UpdateSinkRequest',
  '2': const [
    const {'1': 'sink_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'sink', '3': 2, '4': 1, '5': 11, '6': '.google.logging.v2.LogSink'},
    const {'1': 'unique_writer_identity', '3': 3, '4': 1, '5': 8},
  ],
};

const DeleteSinkRequest$json = const {
  '1': 'DeleteSinkRequest',
  '2': const [
    const {'1': 'sink_name', '3': 1, '4': 1, '5': 9},
  ],
};

const ConfigServiceV2$json = const {
  '1': 'ConfigServiceV2',
  '2': const [
    const {'1': 'ListSinks', '2': '.google.logging.v2.ListSinksRequest', '3': '.google.logging.v2.ListSinksResponse', '4': const {}},
    const {'1': 'GetSink', '2': '.google.logging.v2.GetSinkRequest', '3': '.google.logging.v2.LogSink', '4': const {}},
    const {'1': 'CreateSink', '2': '.google.logging.v2.CreateSinkRequest', '3': '.google.logging.v2.LogSink', '4': const {}},
    const {'1': 'UpdateSink', '2': '.google.logging.v2.UpdateSinkRequest', '3': '.google.logging.v2.LogSink', '4': const {}},
    const {'1': 'DeleteSink', '2': '.google.logging.v2.DeleteSinkRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const ConfigServiceV2$messageJson = const {
  '.google.logging.v2.ListSinksRequest': ListSinksRequest$json,
  '.google.logging.v2.ListSinksResponse': ListSinksResponse$json,
  '.google.logging.v2.LogSink': LogSink$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.logging.v2.GetSinkRequest': GetSinkRequest$json,
  '.google.logging.v2.CreateSinkRequest': CreateSinkRequest$json,
  '.google.logging.v2.UpdateSinkRequest': UpdateSinkRequest$json,
  '.google.logging.v2.DeleteSinkRequest': DeleteSinkRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
};

