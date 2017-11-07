///
//  Generated code. Do not modify.
///
library google.rpc_code_pbenum;

import 'package:protobuf/protobuf.dart';

class Code extends ProtobufEnum {
  static const Code OK = const Code._(0, 'OK');
  static const Code CANCELLED = const Code._(1, 'CANCELLED');
  static const Code UNKNOWN = const Code._(2, 'UNKNOWN');
  static const Code INVALID_ARGUMENT = const Code._(3, 'INVALID_ARGUMENT');
  static const Code DEADLINE_EXCEEDED = const Code._(4, 'DEADLINE_EXCEEDED');
  static const Code NOT_FOUND = const Code._(5, 'NOT_FOUND');
  static const Code ALREADY_EXISTS = const Code._(6, 'ALREADY_EXISTS');
  static const Code PERMISSION_DENIED = const Code._(7, 'PERMISSION_DENIED');
  static const Code UNAUTHENTICATED = const Code._(16, 'UNAUTHENTICATED');
  static const Code RESOURCE_EXHAUSTED = const Code._(8, 'RESOURCE_EXHAUSTED');
  static const Code FAILED_PRECONDITION = const Code._(9, 'FAILED_PRECONDITION');
  static const Code ABORTED = const Code._(10, 'ABORTED');
  static const Code OUT_OF_RANGE = const Code._(11, 'OUT_OF_RANGE');
  static const Code UNIMPLEMENTED = const Code._(12, 'UNIMPLEMENTED');
  static const Code INTERNAL = const Code._(13, 'INTERNAL');
  static const Code UNAVAILABLE = const Code._(14, 'UNAVAILABLE');
  static const Code DATA_LOSS = const Code._(15, 'DATA_LOSS');

  static const List<Code> values = const <Code> [
    OK,
    CANCELLED,
    UNKNOWN,
    INVALID_ARGUMENT,
    DEADLINE_EXCEEDED,
    NOT_FOUND,
    ALREADY_EXISTS,
    PERMISSION_DENIED,
    UNAUTHENTICATED,
    RESOURCE_EXHAUSTED,
    FAILED_PRECONDITION,
    ABORTED,
    OUT_OF_RANGE,
    UNIMPLEMENTED,
    INTERNAL,
    UNAVAILABLE,
    DATA_LOSS,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Code valueOf(int value) => _byValue[value] as Code;
  static void $checkItem(Code v) {
    if (v is !Code) checkItemFailed(v, 'Code');
  }

  const Code._(int v, String n) : super(v, n);
}

