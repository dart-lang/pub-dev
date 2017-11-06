///
//  Generated code. Do not modify.
///
library protobuf_test_messages.proto3_test_messages_proto3_pbenum;

import 'package:protobuf/protobuf.dart';

class ForeignEnum extends ProtobufEnum {
  static const ForeignEnum FOREIGN_FOO = const ForeignEnum._(0, 'FOREIGN_FOO');
  static const ForeignEnum FOREIGN_BAR = const ForeignEnum._(1, 'FOREIGN_BAR');
  static const ForeignEnum FOREIGN_BAZ = const ForeignEnum._(2, 'FOREIGN_BAZ');

  static const List<ForeignEnum> values = const <ForeignEnum> [
    FOREIGN_FOO,
    FOREIGN_BAR,
    FOREIGN_BAZ,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ForeignEnum valueOf(int value) => _byValue[value] as ForeignEnum;
  static void $checkItem(ForeignEnum v) {
    if (v is !ForeignEnum) checkItemFailed(v, 'ForeignEnum');
  }

  const ForeignEnum._(int v, String n) : super(v, n);
}

class TestAllTypes_NestedEnum extends ProtobufEnum {
  static const TestAllTypes_NestedEnum FOO = const TestAllTypes_NestedEnum._(0, 'FOO');
  static const TestAllTypes_NestedEnum BAR = const TestAllTypes_NestedEnum._(1, 'BAR');
  static const TestAllTypes_NestedEnum BAZ = const TestAllTypes_NestedEnum._(2, 'BAZ');
  static const TestAllTypes_NestedEnum NEG = const TestAllTypes_NestedEnum._(-1, 'NEG');

  static const List<TestAllTypes_NestedEnum> values = const <TestAllTypes_NestedEnum> [
    FOO,
    BAR,
    BAZ,
    NEG,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static TestAllTypes_NestedEnum valueOf(int value) => _byValue[value] as TestAllTypes_NestedEnum;
  static void $checkItem(TestAllTypes_NestedEnum v) {
    if (v is !TestAllTypes_NestedEnum) checkItemFailed(v, 'TestAllTypes_NestedEnum');
  }

  const TestAllTypes_NestedEnum._(int v, String n) : super(v, n);
}

