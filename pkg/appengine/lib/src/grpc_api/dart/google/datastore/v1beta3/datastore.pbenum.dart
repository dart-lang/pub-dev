///
//  Generated code. Do not modify.
///
library google.datastore.v1beta3_datastore_pbenum;

import 'package:protobuf/protobuf.dart';

class CommitRequest_Mode extends ProtobufEnum {
  static const CommitRequest_Mode MODE_UNSPECIFIED = const CommitRequest_Mode._(0, 'MODE_UNSPECIFIED');
  static const CommitRequest_Mode TRANSACTIONAL = const CommitRequest_Mode._(1, 'TRANSACTIONAL');
  static const CommitRequest_Mode NON_TRANSACTIONAL = const CommitRequest_Mode._(2, 'NON_TRANSACTIONAL');

  static const List<CommitRequest_Mode> values = const <CommitRequest_Mode> [
    MODE_UNSPECIFIED,
    TRANSACTIONAL,
    NON_TRANSACTIONAL,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static CommitRequest_Mode valueOf(int value) => _byValue[value] as CommitRequest_Mode;
  static void $checkItem(CommitRequest_Mode v) {
    if (v is !CommitRequest_Mode) checkItemFailed(v, 'CommitRequest_Mode');
  }

  const CommitRequest_Mode._(int v, String n) : super(v, n);
}

class ReadOptions_ReadConsistency extends ProtobufEnum {
  static const ReadOptions_ReadConsistency READ_CONSISTENCY_UNSPECIFIED = const ReadOptions_ReadConsistency._(0, 'READ_CONSISTENCY_UNSPECIFIED');
  static const ReadOptions_ReadConsistency STRONG = const ReadOptions_ReadConsistency._(1, 'STRONG');
  static const ReadOptions_ReadConsistency EVENTUAL = const ReadOptions_ReadConsistency._(2, 'EVENTUAL');

  static const List<ReadOptions_ReadConsistency> values = const <ReadOptions_ReadConsistency> [
    READ_CONSISTENCY_UNSPECIFIED,
    STRONG,
    EVENTUAL,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ReadOptions_ReadConsistency valueOf(int value) => _byValue[value] as ReadOptions_ReadConsistency;
  static void $checkItem(ReadOptions_ReadConsistency v) {
    if (v is !ReadOptions_ReadConsistency) checkItemFailed(v, 'ReadOptions_ReadConsistency');
  }

  const ReadOptions_ReadConsistency._(int v, String n) : super(v, n);
}

