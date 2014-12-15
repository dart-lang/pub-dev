///
//  Generated code. Do not modify.
///
library appengine.memcache;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class MemcacheServiceError_ErrorCode extends ProtobufEnum {
  static const MemcacheServiceError_ErrorCode OK = const MemcacheServiceError_ErrorCode._(0, 'OK');
  static const MemcacheServiceError_ErrorCode UNSPECIFIED_ERROR = const MemcacheServiceError_ErrorCode._(1, 'UNSPECIFIED_ERROR');
  static const MemcacheServiceError_ErrorCode NAMESPACE_NOT_SET = const MemcacheServiceError_ErrorCode._(2, 'NAMESPACE_NOT_SET');
  static const MemcacheServiceError_ErrorCode PERMISSION_DENIED = const MemcacheServiceError_ErrorCode._(3, 'PERMISSION_DENIED');
  static const MemcacheServiceError_ErrorCode INVALID_VALUE = const MemcacheServiceError_ErrorCode._(6, 'INVALID_VALUE');

  static const List<MemcacheServiceError_ErrorCode> values = const <MemcacheServiceError_ErrorCode> [
    OK,
    UNSPECIFIED_ERROR,
    NAMESPACE_NOT_SET,
    PERMISSION_DENIED,
    INVALID_VALUE,
  ];

  static final Map<int, MemcacheServiceError_ErrorCode> _byValue = ProtobufEnum.initByValue(values);
  static MemcacheServiceError_ErrorCode valueOf(int value) => _byValue[value];

  const MemcacheServiceError_ErrorCode._(int v, String n) : super(v, n);
}

class MemcacheServiceError extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheServiceError')
    ..hasRequiredFields = false
  ;

  MemcacheServiceError() : super();
  MemcacheServiceError.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheServiceError.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheServiceError clone() => new MemcacheServiceError()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class AppOverride extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AppOverride')
    ..a(1, 'appId', GeneratedMessage.QS)
    ..a(2, 'numMemcachegBackends', GeneratedMessage.O3)
    ..a(3, 'ignoreShardlock', GeneratedMessage.OB)
    ..a(4, 'memcachePoolHint', GeneratedMessage.OS)
    ..a(5, 'memcacheShardingStrategy', GeneratedMessage.OY)
  ;

  AppOverride() : super();
  AppOverride.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AppOverride.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AppOverride clone() => new AppOverride()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get appId => getField(1);
  void set appId(String v) { setField(1, v); }
  bool hasAppId() => hasField(1);
  void clearAppId() => clearField(1);

  int get numMemcachegBackends => getField(2);
  void set numMemcachegBackends(int v) { setField(2, v); }
  bool hasNumMemcachegBackends() => hasField(2);
  void clearNumMemcachegBackends() => clearField(2);

  bool get ignoreShardlock => getField(3);
  void set ignoreShardlock(bool v) { setField(3, v); }
  bool hasIgnoreShardlock() => hasField(3);
  void clearIgnoreShardlock() => clearField(3);

  String get memcachePoolHint => getField(4);
  void set memcachePoolHint(String v) { setField(4, v); }
  bool hasMemcachePoolHint() => hasField(4);
  void clearMemcachePoolHint() => clearField(4);

  List<int> get memcacheShardingStrategy => getField(5);
  void set memcacheShardingStrategy(List<int> v) { setField(5, v); }
  bool hasMemcacheShardingStrategy() => hasField(5);
  void clearMemcacheShardingStrategy() => clearField(5);
}

class MemcacheGetRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheGetRequest')
    ..p(1, 'key', GeneratedMessage.PY)
    ..a(2, 'nameSpace', GeneratedMessage.OS)
    ..a(4, 'forCas', GeneratedMessage.OB)
    ..a(5, 'override', GeneratedMessage.OM, () => new AppOverride(), () => new AppOverride())
  ;

  MemcacheGetRequest() : super();
  MemcacheGetRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheGetRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheGetRequest clone() => new MemcacheGetRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<List<int>> get key => getField(1);

  String get nameSpace => getField(2);
  void set nameSpace(String v) { setField(2, v); }
  bool hasNameSpace() => hasField(2);
  void clearNameSpace() => clearField(2);

  bool get forCas => getField(4);
  void set forCas(bool v) { setField(4, v); }
  bool hasForCas() => hasField(4);
  void clearForCas() => clearField(4);

  AppOverride get override => getField(5);
  void set override(AppOverride v) { setField(5, v); }
  bool hasOverride() => hasField(5);
  void clearOverride() => clearField(5);
}

class MemcacheGetResponse_Item extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheGetResponse_Item')
    ..a(2, 'key', GeneratedMessage.QY)
    ..a(3, 'value', GeneratedMessage.QY)
    ..a(4, 'flags', GeneratedMessage.OF3)
    ..a(5, 'casId', GeneratedMessage.OF6, () => makeLongInt(0))
    ..a(6, 'expiresInSeconds', GeneratedMessage.O3)
  ;

  MemcacheGetResponse_Item() : super();
  MemcacheGetResponse_Item.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheGetResponse_Item.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheGetResponse_Item clone() => new MemcacheGetResponse_Item()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<int> get key => getField(2);
  void set key(List<int> v) { setField(2, v); }
  bool hasKey() => hasField(2);
  void clearKey() => clearField(2);

  List<int> get value => getField(3);
  void set value(List<int> v) { setField(3, v); }
  bool hasValue() => hasField(3);
  void clearValue() => clearField(3);

  int get flags => getField(4);
  void set flags(int v) { setField(4, v); }
  bool hasFlags() => hasField(4);
  void clearFlags() => clearField(4);

  Int64 get casId => getField(5);
  void set casId(Int64 v) { setField(5, v); }
  bool hasCasId() => hasField(5);
  void clearCasId() => clearField(5);

  int get expiresInSeconds => getField(6);
  void set expiresInSeconds(int v) { setField(6, v); }
  bool hasExpiresInSeconds() => hasField(6);
  void clearExpiresInSeconds() => clearField(6);
}

class MemcacheGetResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheGetResponse')
    ..a(1, 'item', GeneratedMessage.PG, () => new PbList(), () => new MemcacheGetResponse_Item())
    ..hasRequiredFields = false
  ;

  MemcacheGetResponse() : super();
  MemcacheGetResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheGetResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheGetResponse clone() => new MemcacheGetResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<MemcacheGetResponse_Item> get item => getField(1);
}

class MemcacheSetRequest_SetPolicy extends ProtobufEnum {
  static const MemcacheSetRequest_SetPolicy SET = const MemcacheSetRequest_SetPolicy._(1, 'SET');
  static const MemcacheSetRequest_SetPolicy ADD = const MemcacheSetRequest_SetPolicy._(2, 'ADD');
  static const MemcacheSetRequest_SetPolicy REPLACE = const MemcacheSetRequest_SetPolicy._(3, 'REPLACE');
  static const MemcacheSetRequest_SetPolicy CAS = const MemcacheSetRequest_SetPolicy._(4, 'CAS');

  static const List<MemcacheSetRequest_SetPolicy> values = const <MemcacheSetRequest_SetPolicy> [
    SET,
    ADD,
    REPLACE,
    CAS,
  ];

  static final Map<int, MemcacheSetRequest_SetPolicy> _byValue = ProtobufEnum.initByValue(values);
  static MemcacheSetRequest_SetPolicy valueOf(int value) => _byValue[value];

  const MemcacheSetRequest_SetPolicy._(int v, String n) : super(v, n);
}

class MemcacheSetRequest_Item extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheSetRequest_Item')
    ..a(2, 'key', GeneratedMessage.QY)
    ..a(3, 'value', GeneratedMessage.QY)
    ..a(4, 'flags', GeneratedMessage.OF3)
    ..e(5, 'setPolicy', GeneratedMessage.OE, () => MemcacheSetRequest_SetPolicy.SET, (var v) => MemcacheSetRequest_SetPolicy.valueOf(v))
    ..a(6, 'expirationTime', GeneratedMessage.OF3)
    ..a(8, 'casId', GeneratedMessage.OF6, () => makeLongInt(0))
    ..a(9, 'forCas', GeneratedMessage.OB)
  ;

  MemcacheSetRequest_Item() : super();
  MemcacheSetRequest_Item.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheSetRequest_Item.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheSetRequest_Item clone() => new MemcacheSetRequest_Item()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<int> get key => getField(2);
  void set key(List<int> v) { setField(2, v); }
  bool hasKey() => hasField(2);
  void clearKey() => clearField(2);

  List<int> get value => getField(3);
  void set value(List<int> v) { setField(3, v); }
  bool hasValue() => hasField(3);
  void clearValue() => clearField(3);

  int get flags => getField(4);
  void set flags(int v) { setField(4, v); }
  bool hasFlags() => hasField(4);
  void clearFlags() => clearField(4);

  MemcacheSetRequest_SetPolicy get setPolicy => getField(5);
  void set setPolicy(MemcacheSetRequest_SetPolicy v) { setField(5, v); }
  bool hasSetPolicy() => hasField(5);
  void clearSetPolicy() => clearField(5);

  int get expirationTime => getField(6);
  void set expirationTime(int v) { setField(6, v); }
  bool hasExpirationTime() => hasField(6);
  void clearExpirationTime() => clearField(6);

  Int64 get casId => getField(8);
  void set casId(Int64 v) { setField(8, v); }
  bool hasCasId() => hasField(8);
  void clearCasId() => clearField(8);

  bool get forCas => getField(9);
  void set forCas(bool v) { setField(9, v); }
  bool hasForCas() => hasField(9);
  void clearForCas() => clearField(9);
}

class MemcacheSetRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheSetRequest')
    ..a(1, 'item', GeneratedMessage.PG, () => new PbList(), () => new MemcacheSetRequest_Item())
    ..a(7, 'nameSpace', GeneratedMessage.OS)
    ..a(10, 'override', GeneratedMessage.OM, () => new AppOverride(), () => new AppOverride())
  ;

  MemcacheSetRequest() : super();
  MemcacheSetRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheSetRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheSetRequest clone() => new MemcacheSetRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<MemcacheSetRequest_Item> get item => getField(1);

  String get nameSpace => getField(7);
  void set nameSpace(String v) { setField(7, v); }
  bool hasNameSpace() => hasField(7);
  void clearNameSpace() => clearField(7);

  AppOverride get override => getField(10);
  void set override(AppOverride v) { setField(10, v); }
  bool hasOverride() => hasField(10);
  void clearOverride() => clearField(10);
}

class MemcacheSetResponse_SetStatusCode extends ProtobufEnum {
  static const MemcacheSetResponse_SetStatusCode STORED = const MemcacheSetResponse_SetStatusCode._(1, 'STORED');
  static const MemcacheSetResponse_SetStatusCode NOT_STORED = const MemcacheSetResponse_SetStatusCode._(2, 'NOT_STORED');
  static const MemcacheSetResponse_SetStatusCode ERROR = const MemcacheSetResponse_SetStatusCode._(3, 'ERROR');
  static const MemcacheSetResponse_SetStatusCode EXISTS = const MemcacheSetResponse_SetStatusCode._(4, 'EXISTS');

  static const List<MemcacheSetResponse_SetStatusCode> values = const <MemcacheSetResponse_SetStatusCode> [
    STORED,
    NOT_STORED,
    ERROR,
    EXISTS,
  ];

  static final Map<int, MemcacheSetResponse_SetStatusCode> _byValue = ProtobufEnum.initByValue(values);
  static MemcacheSetResponse_SetStatusCode valueOf(int value) => _byValue[value];

  const MemcacheSetResponse_SetStatusCode._(int v, String n) : super(v, n);
}

class MemcacheSetResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheSetResponse')
    ..a(1, 'setStatus', GeneratedMessage.PE, () => new PbList(), null, (var v) => MemcacheSetResponse_SetStatusCode.valueOf(v))
    ..hasRequiredFields = false
  ;

  MemcacheSetResponse() : super();
  MemcacheSetResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheSetResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheSetResponse clone() => new MemcacheSetResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<MemcacheSetResponse_SetStatusCode> get setStatus => getField(1);
}

class MemcacheDeleteRequest_Item extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheDeleteRequest_Item')
    ..a(2, 'key', GeneratedMessage.QY)
    ..a(3, 'deleteTime', GeneratedMessage.OF3)
  ;

  MemcacheDeleteRequest_Item() : super();
  MemcacheDeleteRequest_Item.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheDeleteRequest_Item.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheDeleteRequest_Item clone() => new MemcacheDeleteRequest_Item()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<int> get key => getField(2);
  void set key(List<int> v) { setField(2, v); }
  bool hasKey() => hasField(2);
  void clearKey() => clearField(2);

  int get deleteTime => getField(3);
  void set deleteTime(int v) { setField(3, v); }
  bool hasDeleteTime() => hasField(3);
  void clearDeleteTime() => clearField(3);
}

class MemcacheDeleteRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheDeleteRequest')
    ..a(1, 'item', GeneratedMessage.PG, () => new PbList(), () => new MemcacheDeleteRequest_Item())
    ..a(4, 'nameSpace', GeneratedMessage.OS)
    ..a(5, 'override', GeneratedMessage.OM, () => new AppOverride(), () => new AppOverride())
  ;

  MemcacheDeleteRequest() : super();
  MemcacheDeleteRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheDeleteRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheDeleteRequest clone() => new MemcacheDeleteRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<MemcacheDeleteRequest_Item> get item => getField(1);

  String get nameSpace => getField(4);
  void set nameSpace(String v) { setField(4, v); }
  bool hasNameSpace() => hasField(4);
  void clearNameSpace() => clearField(4);

  AppOverride get override => getField(5);
  void set override(AppOverride v) { setField(5, v); }
  bool hasOverride() => hasField(5);
  void clearOverride() => clearField(5);
}

class MemcacheDeleteResponse_DeleteStatusCode extends ProtobufEnum {
  static const MemcacheDeleteResponse_DeleteStatusCode DELETED = const MemcacheDeleteResponse_DeleteStatusCode._(1, 'DELETED');
  static const MemcacheDeleteResponse_DeleteStatusCode NOT_FOUND = const MemcacheDeleteResponse_DeleteStatusCode._(2, 'NOT_FOUND');

  static const List<MemcacheDeleteResponse_DeleteStatusCode> values = const <MemcacheDeleteResponse_DeleteStatusCode> [
    DELETED,
    NOT_FOUND,
  ];

  static final Map<int, MemcacheDeleteResponse_DeleteStatusCode> _byValue = ProtobufEnum.initByValue(values);
  static MemcacheDeleteResponse_DeleteStatusCode valueOf(int value) => _byValue[value];

  const MemcacheDeleteResponse_DeleteStatusCode._(int v, String n) : super(v, n);
}

class MemcacheDeleteResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheDeleteResponse')
    ..a(1, 'deleteStatus', GeneratedMessage.PE, () => new PbList(), null, (var v) => MemcacheDeleteResponse_DeleteStatusCode.valueOf(v))
    ..hasRequiredFields = false
  ;

  MemcacheDeleteResponse() : super();
  MemcacheDeleteResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheDeleteResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheDeleteResponse clone() => new MemcacheDeleteResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<MemcacheDeleteResponse_DeleteStatusCode> get deleteStatus => getField(1);
}

class MemcacheIncrementRequest_Direction extends ProtobufEnum {
  static const MemcacheIncrementRequest_Direction INCREMENT = const MemcacheIncrementRequest_Direction._(1, 'INCREMENT');
  static const MemcacheIncrementRequest_Direction DECREMENT = const MemcacheIncrementRequest_Direction._(2, 'DECREMENT');

  static const List<MemcacheIncrementRequest_Direction> values = const <MemcacheIncrementRequest_Direction> [
    INCREMENT,
    DECREMENT,
  ];

  static final Map<int, MemcacheIncrementRequest_Direction> _byValue = ProtobufEnum.initByValue(values);
  static MemcacheIncrementRequest_Direction valueOf(int value) => _byValue[value];

  const MemcacheIncrementRequest_Direction._(int v, String n) : super(v, n);
}

class MemcacheIncrementRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheIncrementRequest')
    ..a(1, 'key', GeneratedMessage.QY)
    ..a(4, 'nameSpace', GeneratedMessage.OS)
    ..a(2, 'delta', GeneratedMessage.OU6, () => makeLongInt(1))
    ..e(3, 'direction', GeneratedMessage.OE, () => MemcacheIncrementRequest_Direction.INCREMENT, (var v) => MemcacheIncrementRequest_Direction.valueOf(v))
    ..a(5, 'initialValue', GeneratedMessage.OU6, () => makeLongInt(0))
    ..a(6, 'initialFlags', GeneratedMessage.OF3)
    ..a(7, 'override', GeneratedMessage.OM, () => new AppOverride(), () => new AppOverride())
  ;

  MemcacheIncrementRequest() : super();
  MemcacheIncrementRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheIncrementRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheIncrementRequest clone() => new MemcacheIncrementRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<int> get key => getField(1);
  void set key(List<int> v) { setField(1, v); }
  bool hasKey() => hasField(1);
  void clearKey() => clearField(1);

  String get nameSpace => getField(4);
  void set nameSpace(String v) { setField(4, v); }
  bool hasNameSpace() => hasField(4);
  void clearNameSpace() => clearField(4);

  Int64 get delta => getField(2);
  void set delta(Int64 v) { setField(2, v); }
  bool hasDelta() => hasField(2);
  void clearDelta() => clearField(2);

  MemcacheIncrementRequest_Direction get direction => getField(3);
  void set direction(MemcacheIncrementRequest_Direction v) { setField(3, v); }
  bool hasDirection() => hasField(3);
  void clearDirection() => clearField(3);

  Int64 get initialValue => getField(5);
  void set initialValue(Int64 v) { setField(5, v); }
  bool hasInitialValue() => hasField(5);
  void clearInitialValue() => clearField(5);

  int get initialFlags => getField(6);
  void set initialFlags(int v) { setField(6, v); }
  bool hasInitialFlags() => hasField(6);
  void clearInitialFlags() => clearField(6);

  AppOverride get override => getField(7);
  void set override(AppOverride v) { setField(7, v); }
  bool hasOverride() => hasField(7);
  void clearOverride() => clearField(7);
}

class MemcacheIncrementResponse_IncrementStatusCode extends ProtobufEnum {
  static const MemcacheIncrementResponse_IncrementStatusCode OK = const MemcacheIncrementResponse_IncrementStatusCode._(1, 'OK');
  static const MemcacheIncrementResponse_IncrementStatusCode NOT_CHANGED = const MemcacheIncrementResponse_IncrementStatusCode._(2, 'NOT_CHANGED');
  static const MemcacheIncrementResponse_IncrementStatusCode ERROR = const MemcacheIncrementResponse_IncrementStatusCode._(3, 'ERROR');

  static const List<MemcacheIncrementResponse_IncrementStatusCode> values = const <MemcacheIncrementResponse_IncrementStatusCode> [
    OK,
    NOT_CHANGED,
    ERROR,
  ];

  static final Map<int, MemcacheIncrementResponse_IncrementStatusCode> _byValue = ProtobufEnum.initByValue(values);
  static MemcacheIncrementResponse_IncrementStatusCode valueOf(int value) => _byValue[value];

  const MemcacheIncrementResponse_IncrementStatusCode._(int v, String n) : super(v, n);
}

class MemcacheIncrementResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheIncrementResponse')
    ..a(1, 'newValue', GeneratedMessage.OU6, () => makeLongInt(0))
    ..e(2, 'incrementStatus', GeneratedMessage.OE, () => MemcacheIncrementResponse_IncrementStatusCode.OK, (var v) => MemcacheIncrementResponse_IncrementStatusCode.valueOf(v))
    ..hasRequiredFields = false
  ;

  MemcacheIncrementResponse() : super();
  MemcacheIncrementResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheIncrementResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheIncrementResponse clone() => new MemcacheIncrementResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Int64 get newValue => getField(1);
  void set newValue(Int64 v) { setField(1, v); }
  bool hasNewValue() => hasField(1);
  void clearNewValue() => clearField(1);

  MemcacheIncrementResponse_IncrementStatusCode get incrementStatus => getField(2);
  void set incrementStatus(MemcacheIncrementResponse_IncrementStatusCode v) { setField(2, v); }
  bool hasIncrementStatus() => hasField(2);
  void clearIncrementStatus() => clearField(2);
}

class MemcacheBatchIncrementRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheBatchIncrementRequest')
    ..a(1, 'nameSpace', GeneratedMessage.OS)
    ..m(2, 'item', () => new MemcacheIncrementRequest(), () => new PbList<MemcacheIncrementRequest>())
    ..a(3, 'override', GeneratedMessage.OM, () => new AppOverride(), () => new AppOverride())
  ;

  MemcacheBatchIncrementRequest() : super();
  MemcacheBatchIncrementRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheBatchIncrementRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheBatchIncrementRequest clone() => new MemcacheBatchIncrementRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get nameSpace => getField(1);
  void set nameSpace(String v) { setField(1, v); }
  bool hasNameSpace() => hasField(1);
  void clearNameSpace() => clearField(1);

  List<MemcacheIncrementRequest> get item => getField(2);

  AppOverride get override => getField(3);
  void set override(AppOverride v) { setField(3, v); }
  bool hasOverride() => hasField(3);
  void clearOverride() => clearField(3);
}

class MemcacheBatchIncrementResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheBatchIncrementResponse')
    ..m(1, 'item', () => new MemcacheIncrementResponse(), () => new PbList<MemcacheIncrementResponse>())
    ..hasRequiredFields = false
  ;

  MemcacheBatchIncrementResponse() : super();
  MemcacheBatchIncrementResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheBatchIncrementResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheBatchIncrementResponse clone() => new MemcacheBatchIncrementResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<MemcacheIncrementResponse> get item => getField(1);
}

class MemcacheFlushRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheFlushRequest')
    ..a(1, 'override', GeneratedMessage.OM, () => new AppOverride(), () => new AppOverride())
  ;

  MemcacheFlushRequest() : super();
  MemcacheFlushRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheFlushRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheFlushRequest clone() => new MemcacheFlushRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  AppOverride get override => getField(1);
  void set override(AppOverride v) { setField(1, v); }
  bool hasOverride() => hasField(1);
  void clearOverride() => clearField(1);
}

class MemcacheFlushResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheFlushResponse')
    ..hasRequiredFields = false
  ;

  MemcacheFlushResponse() : super();
  MemcacheFlushResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheFlushResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheFlushResponse clone() => new MemcacheFlushResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class MemcacheStatsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheStatsRequest')
    ..a(1, 'override', GeneratedMessage.OM, () => new AppOverride(), () => new AppOverride())
  ;

  MemcacheStatsRequest() : super();
  MemcacheStatsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheStatsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheStatsRequest clone() => new MemcacheStatsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  AppOverride get override => getField(1);
  void set override(AppOverride v) { setField(1, v); }
  bool hasOverride() => hasField(1);
  void clearOverride() => clearField(1);
}

class MergedNamespaceStats extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MergedNamespaceStats')
    ..a(1, 'hits', GeneratedMessage.QU6, () => makeLongInt(0))
    ..a(2, 'misses', GeneratedMessage.QU6, () => makeLongInt(0))
    ..a(3, 'byteHits', GeneratedMessage.QU6, () => makeLongInt(0))
    ..a(4, 'items', GeneratedMessage.QU6, () => makeLongInt(0))
    ..a(5, 'bytes', GeneratedMessage.QU6, () => makeLongInt(0))
    ..a(6, 'oldestItemAge', GeneratedMessage.QF3)
  ;

  MergedNamespaceStats() : super();
  MergedNamespaceStats.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MergedNamespaceStats.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MergedNamespaceStats clone() => new MergedNamespaceStats()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Int64 get hits => getField(1);
  void set hits(Int64 v) { setField(1, v); }
  bool hasHits() => hasField(1);
  void clearHits() => clearField(1);

  Int64 get misses => getField(2);
  void set misses(Int64 v) { setField(2, v); }
  bool hasMisses() => hasField(2);
  void clearMisses() => clearField(2);

  Int64 get byteHits => getField(3);
  void set byteHits(Int64 v) { setField(3, v); }
  bool hasByteHits() => hasField(3);
  void clearByteHits() => clearField(3);

  Int64 get items => getField(4);
  void set items(Int64 v) { setField(4, v); }
  bool hasItems() => hasField(4);
  void clearItems() => clearField(4);

  Int64 get bytes => getField(5);
  void set bytes(Int64 v) { setField(5, v); }
  bool hasBytes() => hasField(5);
  void clearBytes() => clearField(5);

  int get oldestItemAge => getField(6);
  void set oldestItemAge(int v) { setField(6, v); }
  bool hasOldestItemAge() => hasField(6);
  void clearOldestItemAge() => clearField(6);
}

class MemcacheStatsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheStatsResponse')
    ..a(1, 'stats', GeneratedMessage.OM, () => new MergedNamespaceStats(), () => new MergedNamespaceStats())
  ;

  MemcacheStatsResponse() : super();
  MemcacheStatsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheStatsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheStatsResponse clone() => new MemcacheStatsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  MergedNamespaceStats get stats => getField(1);
  void set stats(MergedNamespaceStats v) { setField(1, v); }
  bool hasStats() => hasField(1);
  void clearStats() => clearField(1);
}

class MemcacheGrabTailRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheGrabTailRequest')
    ..a(1, 'itemCount', GeneratedMessage.Q3)
    ..a(2, 'nameSpace', GeneratedMessage.OS)
    ..a(3, 'override', GeneratedMessage.OM, () => new AppOverride(), () => new AppOverride())
  ;

  MemcacheGrabTailRequest() : super();
  MemcacheGrabTailRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheGrabTailRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheGrabTailRequest clone() => new MemcacheGrabTailRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  int get itemCount => getField(1);
  void set itemCount(int v) { setField(1, v); }
  bool hasItemCount() => hasField(1);
  void clearItemCount() => clearField(1);

  String get nameSpace => getField(2);
  void set nameSpace(String v) { setField(2, v); }
  bool hasNameSpace() => hasField(2);
  void clearNameSpace() => clearField(2);

  AppOverride get override => getField(3);
  void set override(AppOverride v) { setField(3, v); }
  bool hasOverride() => hasField(3);
  void clearOverride() => clearField(3);
}

class MemcacheGrabTailResponse_Item extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheGrabTailResponse_Item')
    ..a(2, 'value', GeneratedMessage.QY)
    ..a(3, 'flags', GeneratedMessage.OF3)
  ;

  MemcacheGrabTailResponse_Item() : super();
  MemcacheGrabTailResponse_Item.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheGrabTailResponse_Item.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheGrabTailResponse_Item clone() => new MemcacheGrabTailResponse_Item()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<int> get value => getField(2);
  void set value(List<int> v) { setField(2, v); }
  bool hasValue() => hasField(2);
  void clearValue() => clearField(2);

  int get flags => getField(3);
  void set flags(int v) { setField(3, v); }
  bool hasFlags() => hasField(3);
  void clearFlags() => clearField(3);
}

class MemcacheGrabTailResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MemcacheGrabTailResponse')
    ..a(1, 'item', GeneratedMessage.PG, () => new PbList(), () => new MemcacheGrabTailResponse_Item())
    ..hasRequiredFields = false
  ;

  MemcacheGrabTailResponse() : super();
  MemcacheGrabTailResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MemcacheGrabTailResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MemcacheGrabTailResponse clone() => new MemcacheGrabTailResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<MemcacheGrabTailResponse_Item> get item => getField(1);
}

