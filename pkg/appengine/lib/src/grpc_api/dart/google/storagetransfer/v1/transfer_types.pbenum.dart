///
//  Generated code. Do not modify.
///
library google.storagetransfer.v1_transfer_types_pbenum;

import 'package:protobuf/protobuf.dart';

class TransferJob_Status extends ProtobufEnum {
  static const TransferJob_Status STATUS_UNSPECIFIED = const TransferJob_Status._(0, 'STATUS_UNSPECIFIED');
  static const TransferJob_Status ENABLED = const TransferJob_Status._(1, 'ENABLED');
  static const TransferJob_Status DISABLED = const TransferJob_Status._(2, 'DISABLED');
  static const TransferJob_Status DELETED = const TransferJob_Status._(3, 'DELETED');

  static const List<TransferJob_Status> values = const <TransferJob_Status> [
    STATUS_UNSPECIFIED,
    ENABLED,
    DISABLED,
    DELETED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static TransferJob_Status valueOf(int value) => _byValue[value] as TransferJob_Status;
  static void $checkItem(TransferJob_Status v) {
    if (v is !TransferJob_Status) checkItemFailed(v, 'TransferJob_Status');
  }

  const TransferJob_Status._(int v, String n) : super(v, n);
}

class TransferOperation_Status extends ProtobufEnum {
  static const TransferOperation_Status STATUS_UNSPECIFIED = const TransferOperation_Status._(0, 'STATUS_UNSPECIFIED');
  static const TransferOperation_Status IN_PROGRESS = const TransferOperation_Status._(1, 'IN_PROGRESS');
  static const TransferOperation_Status PAUSED = const TransferOperation_Status._(2, 'PAUSED');
  static const TransferOperation_Status SUCCESS = const TransferOperation_Status._(3, 'SUCCESS');
  static const TransferOperation_Status FAILED = const TransferOperation_Status._(4, 'FAILED');
  static const TransferOperation_Status ABORTED = const TransferOperation_Status._(5, 'ABORTED');

  static const List<TransferOperation_Status> values = const <TransferOperation_Status> [
    STATUS_UNSPECIFIED,
    IN_PROGRESS,
    PAUSED,
    SUCCESS,
    FAILED,
    ABORTED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static TransferOperation_Status valueOf(int value) => _byValue[value] as TransferOperation_Status;
  static void $checkItem(TransferOperation_Status v) {
    if (v is !TransferOperation_Status) checkItemFailed(v, 'TransferOperation_Status');
  }

  const TransferOperation_Status._(int v, String n) : super(v, n);
}

