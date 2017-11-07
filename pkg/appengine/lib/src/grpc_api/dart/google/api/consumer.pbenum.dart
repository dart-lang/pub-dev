///
//  Generated code. Do not modify.
///
library google.api_consumer_pbenum;

import 'package:protobuf/protobuf.dart';

class Property_PropertyType extends ProtobufEnum {
  static const Property_PropertyType UNSPECIFIED = const Property_PropertyType._(0, 'UNSPECIFIED');
  static const Property_PropertyType INT64 = const Property_PropertyType._(1, 'INT64');
  static const Property_PropertyType BOOL = const Property_PropertyType._(2, 'BOOL');
  static const Property_PropertyType STRING = const Property_PropertyType._(3, 'STRING');
  static const Property_PropertyType DOUBLE = const Property_PropertyType._(4, 'DOUBLE');

  static const List<Property_PropertyType> values = const <Property_PropertyType> [
    UNSPECIFIED,
    INT64,
    BOOL,
    STRING,
    DOUBLE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Property_PropertyType valueOf(int value) => _byValue[value] as Property_PropertyType;
  static void $checkItem(Property_PropertyType v) {
    if (v is !Property_PropertyType) checkItemFailed(v, 'Property_PropertyType');
  }

  const Property_PropertyType._(int v, String n) : super(v, n);
}

