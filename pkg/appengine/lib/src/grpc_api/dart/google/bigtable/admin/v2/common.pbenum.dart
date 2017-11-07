///
//  Generated code. Do not modify.
///
library google.bigtable.admin.v2_common_pbenum;

import 'package:protobuf/protobuf.dart';

class StorageType extends ProtobufEnum {
  static const StorageType STORAGE_TYPE_UNSPECIFIED = const StorageType._(0, 'STORAGE_TYPE_UNSPECIFIED');
  static const StorageType SSD = const StorageType._(1, 'SSD');
  static const StorageType HDD = const StorageType._(2, 'HDD');

  static const List<StorageType> values = const <StorageType> [
    STORAGE_TYPE_UNSPECIFIED,
    SSD,
    HDD,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static StorageType valueOf(int value) => _byValue[value] as StorageType;
  static void $checkItem(StorageType v) {
    if (v is !StorageType) checkItemFailed(v, 'StorageType');
  }

  const StorageType._(int v, String n) : super(v, n);
}

