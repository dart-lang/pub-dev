///
//  Generated code. Do not modify.
///
library google.bytestream_bytestream_pbjson;

const ReadRequest$json = const {
  '1': 'ReadRequest',
  '2': const [
    const {'1': 'resource_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'read_offset', '3': 2, '4': 1, '5': 3},
    const {'1': 'read_limit', '3': 3, '4': 1, '5': 3},
  ],
};

const ReadResponse$json = const {
  '1': 'ReadResponse',
  '2': const [
    const {'1': 'data', '3': 10, '4': 1, '5': 12},
  ],
};

const WriteRequest$json = const {
  '1': 'WriteRequest',
  '2': const [
    const {'1': 'resource_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'write_offset', '3': 2, '4': 1, '5': 3},
    const {'1': 'finish_write', '3': 3, '4': 1, '5': 8},
    const {'1': 'data', '3': 10, '4': 1, '5': 12},
  ],
};

const WriteResponse$json = const {
  '1': 'WriteResponse',
  '2': const [
    const {'1': 'committed_size', '3': 1, '4': 1, '5': 3},
  ],
};

const QueryWriteStatusRequest$json = const {
  '1': 'QueryWriteStatusRequest',
  '2': const [
    const {'1': 'resource_name', '3': 1, '4': 1, '5': 9},
  ],
};

const QueryWriteStatusResponse$json = const {
  '1': 'QueryWriteStatusResponse',
  '2': const [
    const {'1': 'committed_size', '3': 1, '4': 1, '5': 3},
    const {'1': 'complete', '3': 2, '4': 1, '5': 8},
  ],
};

const ByteStream$json = const {
  '1': 'ByteStream',
  '2': const [
    const {'1': 'Read', '2': '.google.bytestream.ReadRequest', '3': '.google.bytestream.ReadResponse'},
    const {'1': 'Write', '2': '.google.bytestream.WriteRequest', '3': '.google.bytestream.WriteResponse'},
    const {'1': 'QueryWriteStatus', '2': '.google.bytestream.QueryWriteStatusRequest', '3': '.google.bytestream.QueryWriteStatusResponse'},
  ],
};

const ByteStream$messageJson = const {
  '.google.bytestream.ReadRequest': ReadRequest$json,
  '.google.bytestream.ReadResponse': ReadResponse$json,
  '.google.bytestream.WriteRequest': WriteRequest$json,
  '.google.bytestream.WriteResponse': WriteResponse$json,
  '.google.bytestream.QueryWriteStatusRequest': QueryWriteStatusRequest$json,
  '.google.bytestream.QueryWriteStatusResponse': QueryWriteStatusResponse$json,
};

