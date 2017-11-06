///
//  Generated code. Do not modify.
///
library google.spanner.v1_transaction_pbjson;

const TransactionOptions$json = const {
  '1': 'TransactionOptions',
  '2': const [
    const {'1': 'read_write', '3': 1, '4': 1, '5': 11, '6': '.google.spanner.v1.TransactionOptions.ReadWrite'},
    const {'1': 'read_only', '3': 2, '4': 1, '5': 11, '6': '.google.spanner.v1.TransactionOptions.ReadOnly'},
  ],
  '3': const [TransactionOptions_ReadWrite$json, TransactionOptions_ReadOnly$json],
};

const TransactionOptions_ReadWrite$json = const {
  '1': 'ReadWrite',
};

const TransactionOptions_ReadOnly$json = const {
  '1': 'ReadOnly',
  '2': const [
    const {'1': 'strong', '3': 1, '4': 1, '5': 8},
    const {'1': 'min_read_timestamp', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'max_staleness', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'read_timestamp', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'exact_staleness', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'return_read_timestamp', '3': 6, '4': 1, '5': 8},
  ],
};

const Transaction$json = const {
  '1': 'Transaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 12},
    const {'1': 'read_timestamp', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const TransactionSelector$json = const {
  '1': 'TransactionSelector',
  '2': const [
    const {'1': 'single_use', '3': 1, '4': 1, '5': 11, '6': '.google.spanner.v1.TransactionOptions'},
    const {'1': 'id', '3': 2, '4': 1, '5': 12},
    const {'1': 'begin', '3': 3, '4': 1, '5': 11, '6': '.google.spanner.v1.TransactionOptions'},
  ],
};

