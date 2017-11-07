///
//  Generated code. Do not modify.
///
library google.api_metric_pbenum;

import 'package:protobuf/protobuf.dart';

class MetricDescriptor_MetricKind extends ProtobufEnum {
  static const MetricDescriptor_MetricKind METRIC_KIND_UNSPECIFIED = const MetricDescriptor_MetricKind._(0, 'METRIC_KIND_UNSPECIFIED');
  static const MetricDescriptor_MetricKind GAUGE = const MetricDescriptor_MetricKind._(1, 'GAUGE');
  static const MetricDescriptor_MetricKind DELTA = const MetricDescriptor_MetricKind._(2, 'DELTA');
  static const MetricDescriptor_MetricKind CUMULATIVE = const MetricDescriptor_MetricKind._(3, 'CUMULATIVE');

  static const List<MetricDescriptor_MetricKind> values = const <MetricDescriptor_MetricKind> [
    METRIC_KIND_UNSPECIFIED,
    GAUGE,
    DELTA,
    CUMULATIVE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static MetricDescriptor_MetricKind valueOf(int value) => _byValue[value] as MetricDescriptor_MetricKind;
  static void $checkItem(MetricDescriptor_MetricKind v) {
    if (v is !MetricDescriptor_MetricKind) checkItemFailed(v, 'MetricDescriptor_MetricKind');
  }

  const MetricDescriptor_MetricKind._(int v, String n) : super(v, n);
}

class MetricDescriptor_ValueType extends ProtobufEnum {
  static const MetricDescriptor_ValueType VALUE_TYPE_UNSPECIFIED = const MetricDescriptor_ValueType._(0, 'VALUE_TYPE_UNSPECIFIED');
  static const MetricDescriptor_ValueType BOOL = const MetricDescriptor_ValueType._(1, 'BOOL');
  static const MetricDescriptor_ValueType INT64 = const MetricDescriptor_ValueType._(2, 'INT64');
  static const MetricDescriptor_ValueType DOUBLE = const MetricDescriptor_ValueType._(3, 'DOUBLE');
  static const MetricDescriptor_ValueType STRING = const MetricDescriptor_ValueType._(4, 'STRING');
  static const MetricDescriptor_ValueType DISTRIBUTION = const MetricDescriptor_ValueType._(5, 'DISTRIBUTION');
  static const MetricDescriptor_ValueType MONEY = const MetricDescriptor_ValueType._(6, 'MONEY');

  static const List<MetricDescriptor_ValueType> values = const <MetricDescriptor_ValueType> [
    VALUE_TYPE_UNSPECIFIED,
    BOOL,
    INT64,
    DOUBLE,
    STRING,
    DISTRIBUTION,
    MONEY,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static MetricDescriptor_ValueType valueOf(int value) => _byValue[value] as MetricDescriptor_ValueType;
  static void $checkItem(MetricDescriptor_ValueType v) {
    if (v is !MetricDescriptor_ValueType) checkItemFailed(v, 'MetricDescriptor_ValueType');
  }

  const MetricDescriptor_ValueType._(int v, String n) : super(v, n);
}

