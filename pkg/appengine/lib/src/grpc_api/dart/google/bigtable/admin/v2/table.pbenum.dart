///
//  Generated code. Do not modify.
///
library google.bigtable.admin.v2_table_pbenum;

import 'package:protobuf/protobuf.dart';

class Table_TimestampGranularity extends ProtobufEnum {
  static const Table_TimestampGranularity TIMESTAMP_GRANULARITY_UNSPECIFIED = const Table_TimestampGranularity._(0, 'TIMESTAMP_GRANULARITY_UNSPECIFIED');
  static const Table_TimestampGranularity MILLIS = const Table_TimestampGranularity._(1, 'MILLIS');

  static const List<Table_TimestampGranularity> values = const <Table_TimestampGranularity> [
    TIMESTAMP_GRANULARITY_UNSPECIFIED,
    MILLIS,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Table_TimestampGranularity valueOf(int value) => _byValue[value] as Table_TimestampGranularity;
  static void $checkItem(Table_TimestampGranularity v) {
    if (v is !Table_TimestampGranularity) checkItemFailed(v, 'Table_TimestampGranularity');
  }

  const Table_TimestampGranularity._(int v, String n) : super(v, n);
}

class Table_View extends ProtobufEnum {
  static const Table_View VIEW_UNSPECIFIED = const Table_View._(0, 'VIEW_UNSPECIFIED');
  static const Table_View NAME_ONLY = const Table_View._(1, 'NAME_ONLY');
  static const Table_View SCHEMA_VIEW = const Table_View._(2, 'SCHEMA_VIEW');
  static const Table_View FULL = const Table_View._(4, 'FULL');

  static const List<Table_View> values = const <Table_View> [
    VIEW_UNSPECIFIED,
    NAME_ONLY,
    SCHEMA_VIEW,
    FULL,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Table_View valueOf(int value) => _byValue[value] as Table_View;
  static void $checkItem(Table_View v) {
    if (v is !Table_View) checkItemFailed(v, 'Table_View');
  }

  const Table_View._(int v, String n) : super(v, n);
}

