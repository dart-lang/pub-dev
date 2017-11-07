///
//  Generated code. Do not modify.
///
library google.api_config_change_pbenum;

import 'package:protobuf/protobuf.dart';

class ChangeType extends ProtobufEnum {
  static const ChangeType CHANGE_TYPE_UNSPECIFIED = const ChangeType._(0, 'CHANGE_TYPE_UNSPECIFIED');
  static const ChangeType ADDED = const ChangeType._(1, 'ADDED');
  static const ChangeType REMOVED = const ChangeType._(2, 'REMOVED');
  static const ChangeType MODIFIED = const ChangeType._(3, 'MODIFIED');

  static const List<ChangeType> values = const <ChangeType> [
    CHANGE_TYPE_UNSPECIFIED,
    ADDED,
    REMOVED,
    MODIFIED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ChangeType valueOf(int value) => _byValue[value] as ChangeType;
  static void $checkItem(ChangeType v) {
    if (v is !ChangeType) checkItemFailed(v, 'ChangeType');
  }

  const ChangeType._(int v, String n) : super(v, n);
}

