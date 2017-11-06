///
//  Generated code. Do not modify.
///
library google.devtools.cloudbuild.v1_cloudbuild_pbenum;

import 'package:protobuf/protobuf.dart';

class Build_Status extends ProtobufEnum {
  static const Build_Status STATUS_UNKNOWN = const Build_Status._(0, 'STATUS_UNKNOWN');
  static const Build_Status QUEUED = const Build_Status._(1, 'QUEUED');
  static const Build_Status WORKING = const Build_Status._(2, 'WORKING');
  static const Build_Status SUCCESS = const Build_Status._(3, 'SUCCESS');
  static const Build_Status FAILURE = const Build_Status._(4, 'FAILURE');
  static const Build_Status INTERNAL_ERROR = const Build_Status._(5, 'INTERNAL_ERROR');
  static const Build_Status TIMEOUT = const Build_Status._(6, 'TIMEOUT');
  static const Build_Status CANCELLED = const Build_Status._(7, 'CANCELLED');

  static const List<Build_Status> values = const <Build_Status> [
    STATUS_UNKNOWN,
    QUEUED,
    WORKING,
    SUCCESS,
    FAILURE,
    INTERNAL_ERROR,
    TIMEOUT,
    CANCELLED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Build_Status valueOf(int value) => _byValue[value] as Build_Status;
  static void $checkItem(Build_Status v) {
    if (v is !Build_Status) checkItemFailed(v, 'Build_Status');
  }

  const Build_Status._(int v, String n) : super(v, n);
}

class Hash_HashType extends ProtobufEnum {
  static const Hash_HashType NONE = const Hash_HashType._(0, 'NONE');
  static const Hash_HashType SHA256 = const Hash_HashType._(1, 'SHA256');

  static const List<Hash_HashType> values = const <Hash_HashType> [
    NONE,
    SHA256,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Hash_HashType valueOf(int value) => _byValue[value] as Hash_HashType;
  static void $checkItem(Hash_HashType v) {
    if (v is !Hash_HashType) checkItemFailed(v, 'Hash_HashType');
  }

  const Hash_HashType._(int v, String n) : super(v, n);
}

class BuildOptions_VerifyOption extends ProtobufEnum {
  static const BuildOptions_VerifyOption NOT_VERIFIED = const BuildOptions_VerifyOption._(0, 'NOT_VERIFIED');
  static const BuildOptions_VerifyOption VERIFIED = const BuildOptions_VerifyOption._(1, 'VERIFIED');

  static const List<BuildOptions_VerifyOption> values = const <BuildOptions_VerifyOption> [
    NOT_VERIFIED,
    VERIFIED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static BuildOptions_VerifyOption valueOf(int value) => _byValue[value] as BuildOptions_VerifyOption;
  static void $checkItem(BuildOptions_VerifyOption v) {
    if (v is !BuildOptions_VerifyOption) checkItemFailed(v, 'BuildOptions_VerifyOption');
  }

  const BuildOptions_VerifyOption._(int v, String n) : super(v, n);
}

