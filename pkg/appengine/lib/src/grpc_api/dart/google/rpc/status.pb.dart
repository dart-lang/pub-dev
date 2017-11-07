///
//  Generated code. Do not modify.
///
library google.rpc_status;

import 'package:protobuf/protobuf.dart';

import '../protobuf/any.pb.dart' as google$protobuf;

class Status extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Status')
    ..a/*<int>*/(1, 'code', PbFieldType.O3)
    ..a/*<String>*/(2, 'message', PbFieldType.OS)
    ..pp/*<google$protobuf.Any>*/(3, 'details', PbFieldType.PM, google$protobuf.Any.$checkItem, google$protobuf.Any.create)
    ..hasRequiredFields = false
  ;

  Status() : super();
  Status.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Status.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Status clone() => new Status()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Status create() => new Status();
  static PbList<Status> createRepeated() => new PbList<Status>();
  static Status getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStatus();
    return _defaultInstance;
  }
  static Status _defaultInstance;
  static void $checkItem(Status v) {
    if (v is !Status) checkItemFailed(v, 'Status');
  }

  int get code => $_get(0, 1, 0);
  void set code(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasCode() => $_has(0, 1);
  void clearCode() => clearField(1);

  String get message => $_get(1, 2, '');
  void set message(String v) { $_setString(1, 2, v); }
  bool hasMessage() => $_has(1, 2);
  void clearMessage() => clearField(2);

  List<google$protobuf.Any> get details => $_get(2, 3, null);
}

class _ReadonlyStatus extends Status with ReadonlyMessageMixin {}

