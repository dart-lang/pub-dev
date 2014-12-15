///
//  Generated code. Do not modify.
///
library remote_api;

import 'package:protobuf/protobuf.dart';

class Request extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Request')
    ..a(2, 'serviceName', GeneratedMessage.QS)
    ..a(3, 'method', GeneratedMessage.QS)
    ..a(4, 'request', GeneratedMessage.QY)
    ..a(5, 'requestId', GeneratedMessage.OS)
  ;

  Request() : super();
  Request.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Request.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Request clone() => new Request()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get serviceName => getField(2);
  void set serviceName(String v) { setField(2, v); }
  bool hasServiceName() => hasField(2);
  void clearServiceName() => clearField(2);

  String get method => getField(3);
  void set method(String v) { setField(3, v); }
  bool hasMethod() => hasField(3);
  void clearMethod() => clearField(3);

  List<int> get request => getField(4);
  void set request(List<int> v) { setField(4, v); }
  bool hasRequest() => hasField(4);
  void clearRequest() => clearField(4);

  String get requestId => getField(5);
  void set requestId(String v) { setField(5, v); }
  bool hasRequestId() => hasField(5);
  void clearRequestId() => clearField(5);
}

class ApplicationError extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ApplicationError')
    ..a(1, 'code', GeneratedMessage.Q3)
    ..a(2, 'detail', GeneratedMessage.QS)
  ;

  ApplicationError() : super();
  ApplicationError.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ApplicationError.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ApplicationError clone() => new ApplicationError()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  int get code => getField(1);
  void set code(int v) { setField(1, v); }
  bool hasCode() => hasField(1);
  void clearCode() => clearField(1);

  String get detail => getField(2);
  void set detail(String v) { setField(2, v); }
  bool hasDetail() => hasField(2);
  void clearDetail() => clearField(2);
}

class RpcError_ErrorCode extends ProtobufEnum {
  static const RpcError_ErrorCode UNKNOWN = const RpcError_ErrorCode._(0, 'UNKNOWN');
  static const RpcError_ErrorCode CALL_NOT_FOUND = const RpcError_ErrorCode._(1, 'CALL_NOT_FOUND');
  static const RpcError_ErrorCode PARSE_ERROR = const RpcError_ErrorCode._(2, 'PARSE_ERROR');
  static const RpcError_ErrorCode SECURITY_VIOLATION = const RpcError_ErrorCode._(3, 'SECURITY_VIOLATION');
  static const RpcError_ErrorCode OVER_QUOTA = const RpcError_ErrorCode._(4, 'OVER_QUOTA');
  static const RpcError_ErrorCode REQUEST_TOO_LARGE = const RpcError_ErrorCode._(5, 'REQUEST_TOO_LARGE');
  static const RpcError_ErrorCode CAPABILITY_DISABLED = const RpcError_ErrorCode._(6, 'CAPABILITY_DISABLED');
  static const RpcError_ErrorCode FEATURE_DISABLED = const RpcError_ErrorCode._(7, 'FEATURE_DISABLED');
  static const RpcError_ErrorCode BAD_REQUEST = const RpcError_ErrorCode._(8, 'BAD_REQUEST');
  static const RpcError_ErrorCode RESPONSE_TOO_LARGE = const RpcError_ErrorCode._(9, 'RESPONSE_TOO_LARGE');
  static const RpcError_ErrorCode CANCELLED = const RpcError_ErrorCode._(10, 'CANCELLED');
  static const RpcError_ErrorCode REPLAY_ERROR = const RpcError_ErrorCode._(11, 'REPLAY_ERROR');
  static const RpcError_ErrorCode DEADLINE_EXCEEDED = const RpcError_ErrorCode._(12, 'DEADLINE_EXCEEDED');

  static const List<RpcError_ErrorCode> values = const <RpcError_ErrorCode> [
    UNKNOWN,
    CALL_NOT_FOUND,
    PARSE_ERROR,
    SECURITY_VIOLATION,
    OVER_QUOTA,
    REQUEST_TOO_LARGE,
    CAPABILITY_DISABLED,
    FEATURE_DISABLED,
    BAD_REQUEST,
    RESPONSE_TOO_LARGE,
    CANCELLED,
    REPLAY_ERROR,
    DEADLINE_EXCEEDED,
  ];

  static final Map<int, RpcError_ErrorCode> _byValue = ProtobufEnum.initByValue(values);
  static RpcError_ErrorCode valueOf(int value) => _byValue[value];

  const RpcError_ErrorCode._(int v, String n) : super(v, n);
}

class RpcError extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RpcError')
    ..a(1, 'code', GeneratedMessage.Q3)
    ..a(2, 'detail', GeneratedMessage.OS)
  ;

  RpcError() : super();
  RpcError.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RpcError.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RpcError clone() => new RpcError()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  int get code => getField(1);
  void set code(int v) { setField(1, v); }
  bool hasCode() => hasField(1);
  void clearCode() => clearField(1);

  String get detail => getField(2);
  void set detail(String v) { setField(2, v); }
  bool hasDetail() => hasField(2);
  void clearDetail() => clearField(2);
}

class Response extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Response')
    ..a(1, 'response', GeneratedMessage.OY)
    ..a(2, 'exception', GeneratedMessage.OY)
    ..a(3, 'applicationError', GeneratedMessage.OM, () => new ApplicationError(), () => new ApplicationError())
    ..a(4, 'javaException', GeneratedMessage.OY)
    ..a(5, 'rpcError', GeneratedMessage.OM, () => new RpcError(), () => new RpcError())
  ;

  Response() : super();
  Response.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Response.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Response clone() => new Response()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<int> get response => getField(1);
  void set response(List<int> v) { setField(1, v); }
  bool hasResponse() => hasField(1);
  void clearResponse() => clearField(1);

  List<int> get exception => getField(2);
  void set exception(List<int> v) { setField(2, v); }
  bool hasException() => hasField(2);
  void clearException() => clearField(2);

  ApplicationError get applicationError => getField(3);
  void set applicationError(ApplicationError v) { setField(3, v); }
  bool hasApplicationError() => hasField(3);
  void clearApplicationError() => clearField(3);

  List<int> get javaException => getField(4);
  void set javaException(List<int> v) { setField(4, v); }
  bool hasJavaException() => hasField(4);
  void clearJavaException() => clearField(4);

  RpcError get rpcError => getField(5);
  void set rpcError(RpcError v) { setField(5, v); }
  bool hasRpcError() => hasField(5);
  void clearRpcError() => clearField(5);
}

