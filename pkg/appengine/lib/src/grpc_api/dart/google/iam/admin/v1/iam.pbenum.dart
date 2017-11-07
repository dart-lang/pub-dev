///
//  Generated code. Do not modify.
///
library google.iam.admin.v1_iam_pbenum;

import 'package:protobuf/protobuf.dart';

class ServiceAccountKeyAlgorithm extends ProtobufEnum {
  static const ServiceAccountKeyAlgorithm KEY_ALG_UNSPECIFIED = const ServiceAccountKeyAlgorithm._(0, 'KEY_ALG_UNSPECIFIED');
  static const ServiceAccountKeyAlgorithm KEY_ALG_RSA_1024 = const ServiceAccountKeyAlgorithm._(1, 'KEY_ALG_RSA_1024');
  static const ServiceAccountKeyAlgorithm KEY_ALG_RSA_2048 = const ServiceAccountKeyAlgorithm._(2, 'KEY_ALG_RSA_2048');

  static const List<ServiceAccountKeyAlgorithm> values = const <ServiceAccountKeyAlgorithm> [
    KEY_ALG_UNSPECIFIED,
    KEY_ALG_RSA_1024,
    KEY_ALG_RSA_2048,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ServiceAccountKeyAlgorithm valueOf(int value) => _byValue[value] as ServiceAccountKeyAlgorithm;
  static void $checkItem(ServiceAccountKeyAlgorithm v) {
    if (v is !ServiceAccountKeyAlgorithm) checkItemFailed(v, 'ServiceAccountKeyAlgorithm');
  }

  const ServiceAccountKeyAlgorithm._(int v, String n) : super(v, n);
}

class ServiceAccountPrivateKeyType extends ProtobufEnum {
  static const ServiceAccountPrivateKeyType TYPE_UNSPECIFIED = const ServiceAccountPrivateKeyType._(0, 'TYPE_UNSPECIFIED');
  static const ServiceAccountPrivateKeyType TYPE_PKCS12_FILE = const ServiceAccountPrivateKeyType._(1, 'TYPE_PKCS12_FILE');
  static const ServiceAccountPrivateKeyType TYPE_GOOGLE_CREDENTIALS_FILE = const ServiceAccountPrivateKeyType._(2, 'TYPE_GOOGLE_CREDENTIALS_FILE');

  static const List<ServiceAccountPrivateKeyType> values = const <ServiceAccountPrivateKeyType> [
    TYPE_UNSPECIFIED,
    TYPE_PKCS12_FILE,
    TYPE_GOOGLE_CREDENTIALS_FILE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ServiceAccountPrivateKeyType valueOf(int value) => _byValue[value] as ServiceAccountPrivateKeyType;
  static void $checkItem(ServiceAccountPrivateKeyType v) {
    if (v is !ServiceAccountPrivateKeyType) checkItemFailed(v, 'ServiceAccountPrivateKeyType');
  }

  const ServiceAccountPrivateKeyType._(int v, String n) : super(v, n);
}

class ServiceAccountPublicKeyType extends ProtobufEnum {
  static const ServiceAccountPublicKeyType TYPE_NONE = const ServiceAccountPublicKeyType._(0, 'TYPE_NONE');
  static const ServiceAccountPublicKeyType TYPE_X509_PEM_FILE = const ServiceAccountPublicKeyType._(1, 'TYPE_X509_PEM_FILE');
  static const ServiceAccountPublicKeyType TYPE_RAW_PUBLIC_KEY = const ServiceAccountPublicKeyType._(2, 'TYPE_RAW_PUBLIC_KEY');

  static const List<ServiceAccountPublicKeyType> values = const <ServiceAccountPublicKeyType> [
    TYPE_NONE,
    TYPE_X509_PEM_FILE,
    TYPE_RAW_PUBLIC_KEY,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ServiceAccountPublicKeyType valueOf(int value) => _byValue[value] as ServiceAccountPublicKeyType;
  static void $checkItem(ServiceAccountPublicKeyType v) {
    if (v is !ServiceAccountPublicKeyType) checkItemFailed(v, 'ServiceAccountPublicKeyType');
  }

  const ServiceAccountPublicKeyType._(int v, String n) : super(v, n);
}

class ListServiceAccountKeysRequest_KeyType extends ProtobufEnum {
  static const ListServiceAccountKeysRequest_KeyType KEY_TYPE_UNSPECIFIED = const ListServiceAccountKeysRequest_KeyType._(0, 'KEY_TYPE_UNSPECIFIED');
  static const ListServiceAccountKeysRequest_KeyType USER_MANAGED = const ListServiceAccountKeysRequest_KeyType._(1, 'USER_MANAGED');
  static const ListServiceAccountKeysRequest_KeyType SYSTEM_MANAGED = const ListServiceAccountKeysRequest_KeyType._(2, 'SYSTEM_MANAGED');

  static const List<ListServiceAccountKeysRequest_KeyType> values = const <ListServiceAccountKeysRequest_KeyType> [
    KEY_TYPE_UNSPECIFIED,
    USER_MANAGED,
    SYSTEM_MANAGED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ListServiceAccountKeysRequest_KeyType valueOf(int value) => _byValue[value] as ListServiceAccountKeysRequest_KeyType;
  static void $checkItem(ListServiceAccountKeysRequest_KeyType v) {
    if (v is !ListServiceAccountKeysRequest_KeyType) checkItemFailed(v, 'ListServiceAccountKeysRequest_KeyType');
  }

  const ListServiceAccountKeysRequest_KeyType._(int v, String n) : super(v, n);
}

