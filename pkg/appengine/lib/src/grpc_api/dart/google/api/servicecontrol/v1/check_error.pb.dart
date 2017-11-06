///
//  Generated code. Do not modify.
///
library google.api.servicecontrol.v1_check_error;

import 'package:protobuf/protobuf.dart';

import 'check_error.pbenum.dart';

export 'check_error.pbenum.dart';

class CheckError extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CheckError')
    ..e/*<CheckError_Code>*/(1, 'code', PbFieldType.OE, CheckError_Code.ERROR_CODE_UNSPECIFIED, CheckError_Code.valueOf)
    ..a/*<String>*/(2, 'detail', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CheckError() : super();
  CheckError.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CheckError.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CheckError clone() => new CheckError()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CheckError create() => new CheckError();
  static PbList<CheckError> createRepeated() => new PbList<CheckError>();
  static CheckError getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCheckError();
    return _defaultInstance;
  }
  static CheckError _defaultInstance;
  static void $checkItem(CheckError v) {
    if (v is !CheckError) checkItemFailed(v, 'CheckError');
  }

  CheckError_Code get code => $_get(0, 1, null);
  void set code(CheckError_Code v) { setField(1, v); }
  bool hasCode() => $_has(0, 1);
  void clearCode() => clearField(1);

  String get detail => $_get(1, 2, '');
  void set detail(String v) { $_setString(1, 2, v); }
  bool hasDetail() => $_has(1, 2);
  void clearDetail() => clearField(2);
}

class _ReadonlyCheckError extends CheckError with ReadonlyMessageMixin {}

