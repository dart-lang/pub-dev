///
//  Generated code. Do not modify.
///
library appengine.modules;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class ModulesServiceError_ErrorCode extends ProtobufEnum {
  static const ModulesServiceError_ErrorCode OK = const ModulesServiceError_ErrorCode._(0, 'OK');
  static const ModulesServiceError_ErrorCode INVALID_MODULE = const ModulesServiceError_ErrorCode._(1, 'INVALID_MODULE');
  static const ModulesServiceError_ErrorCode INVALID_VERSION = const ModulesServiceError_ErrorCode._(2, 'INVALID_VERSION');
  static const ModulesServiceError_ErrorCode INVALID_INSTANCES = const ModulesServiceError_ErrorCode._(3, 'INVALID_INSTANCES');
  static const ModulesServiceError_ErrorCode TRANSIENT_ERROR = const ModulesServiceError_ErrorCode._(4, 'TRANSIENT_ERROR');
  static const ModulesServiceError_ErrorCode UNEXPECTED_STATE = const ModulesServiceError_ErrorCode._(5, 'UNEXPECTED_STATE');

  static const List<ModulesServiceError_ErrorCode> values = const <ModulesServiceError_ErrorCode> [
    OK,
    INVALID_MODULE,
    INVALID_VERSION,
    INVALID_INSTANCES,
    TRANSIENT_ERROR,
    UNEXPECTED_STATE,
  ];

  static final Map<int, ModulesServiceError_ErrorCode> _byValue = ProtobufEnum.initByValue(values);
  static ModulesServiceError_ErrorCode valueOf(int value) => _byValue[value];

  const ModulesServiceError_ErrorCode._(int v, String n) : super(v, n);
}

class ModulesServiceError extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ModulesServiceError')
    ..hasRequiredFields = false
  ;

  ModulesServiceError() : super();
  ModulesServiceError.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ModulesServiceError.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ModulesServiceError clone() => new ModulesServiceError()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class GetModulesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetModulesRequest')
    ..hasRequiredFields = false
  ;

  GetModulesRequest() : super();
  GetModulesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetModulesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetModulesRequest clone() => new GetModulesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class GetModulesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetModulesResponse')
    ..p(1, 'module', GeneratedMessage.PS)
    ..hasRequiredFields = false
  ;

  GetModulesResponse() : super();
  GetModulesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetModulesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetModulesResponse clone() => new GetModulesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<String> get module => getField(1);
}

class GetVersionsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetVersionsRequest')
    ..a(1, 'module', GeneratedMessage.OS)
    ..hasRequiredFields = false
  ;

  GetVersionsRequest() : super();
  GetVersionsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetVersionsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetVersionsRequest clone() => new GetVersionsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get module => getField(1);
  void set module(String v) { setField(1, v); }
  bool hasModule() => hasField(1);
  void clearModule() => clearField(1);
}

class GetVersionsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetVersionsResponse')
    ..p(1, 'version', GeneratedMessage.PS)
    ..hasRequiredFields = false
  ;

  GetVersionsResponse() : super();
  GetVersionsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetVersionsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetVersionsResponse clone() => new GetVersionsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<String> get version => getField(1);
}

class GetDefaultVersionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetDefaultVersionRequest')
    ..a(1, 'module', GeneratedMessage.OS)
    ..hasRequiredFields = false
  ;

  GetDefaultVersionRequest() : super();
  GetDefaultVersionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetDefaultVersionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetDefaultVersionRequest clone() => new GetDefaultVersionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get module => getField(1);
  void set module(String v) { setField(1, v); }
  bool hasModule() => hasField(1);
  void clearModule() => clearField(1);
}

class GetDefaultVersionResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetDefaultVersionResponse')
    ..a(1, 'version', GeneratedMessage.QS)
  ;

  GetDefaultVersionResponse() : super();
  GetDefaultVersionResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetDefaultVersionResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetDefaultVersionResponse clone() => new GetDefaultVersionResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get version => getField(1);
  void set version(String v) { setField(1, v); }
  bool hasVersion() => hasField(1);
  void clearVersion() => clearField(1);
}

class GetNumInstancesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetNumInstancesRequest')
    ..a(1, 'module', GeneratedMessage.OS)
    ..a(2, 'version', GeneratedMessage.OS)
    ..hasRequiredFields = false
  ;

  GetNumInstancesRequest() : super();
  GetNumInstancesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetNumInstancesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetNumInstancesRequest clone() => new GetNumInstancesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get module => getField(1);
  void set module(String v) { setField(1, v); }
  bool hasModule() => hasField(1);
  void clearModule() => clearField(1);

  String get version => getField(2);
  void set version(String v) { setField(2, v); }
  bool hasVersion() => hasField(2);
  void clearVersion() => clearField(2);
}

class GetNumInstancesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetNumInstancesResponse')
    ..a(1, 'instances', GeneratedMessage.Q6, () => makeLongInt(0))
  ;

  GetNumInstancesResponse() : super();
  GetNumInstancesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetNumInstancesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetNumInstancesResponse clone() => new GetNumInstancesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Int64 get instances => getField(1);
  void set instances(Int64 v) { setField(1, v); }
  bool hasInstances() => hasField(1);
  void clearInstances() => clearField(1);
}

class SetNumInstancesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SetNumInstancesRequest')
    ..a(1, 'module', GeneratedMessage.OS)
    ..a(2, 'version', GeneratedMessage.OS)
    ..a(3, 'instances', GeneratedMessage.Q6, () => makeLongInt(0))
  ;

  SetNumInstancesRequest() : super();
  SetNumInstancesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SetNumInstancesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SetNumInstancesRequest clone() => new SetNumInstancesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get module => getField(1);
  void set module(String v) { setField(1, v); }
  bool hasModule() => hasField(1);
  void clearModule() => clearField(1);

  String get version => getField(2);
  void set version(String v) { setField(2, v); }
  bool hasVersion() => hasField(2);
  void clearVersion() => clearField(2);

  Int64 get instances => getField(3);
  void set instances(Int64 v) { setField(3, v); }
  bool hasInstances() => hasField(3);
  void clearInstances() => clearField(3);
}

class SetNumInstancesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SetNumInstancesResponse')
    ..hasRequiredFields = false
  ;

  SetNumInstancesResponse() : super();
  SetNumInstancesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SetNumInstancesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SetNumInstancesResponse clone() => new SetNumInstancesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class StartModuleRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StartModuleRequest')
    ..a(1, 'module', GeneratedMessage.QS)
    ..a(2, 'version', GeneratedMessage.QS)
  ;

  StartModuleRequest() : super();
  StartModuleRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StartModuleRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StartModuleRequest clone() => new StartModuleRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get module => getField(1);
  void set module(String v) { setField(1, v); }
  bool hasModule() => hasField(1);
  void clearModule() => clearField(1);

  String get version => getField(2);
  void set version(String v) { setField(2, v); }
  bool hasVersion() => hasField(2);
  void clearVersion() => clearField(2);
}

class StartModuleResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StartModuleResponse')
    ..hasRequiredFields = false
  ;

  StartModuleResponse() : super();
  StartModuleResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StartModuleResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StartModuleResponse clone() => new StartModuleResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class StopModuleRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StopModuleRequest')
    ..a(1, 'module', GeneratedMessage.OS)
    ..a(2, 'version', GeneratedMessage.OS)
    ..hasRequiredFields = false
  ;

  StopModuleRequest() : super();
  StopModuleRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StopModuleRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StopModuleRequest clone() => new StopModuleRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get module => getField(1);
  void set module(String v) { setField(1, v); }
  bool hasModule() => hasField(1);
  void clearModule() => clearField(1);

  String get version => getField(2);
  void set version(String v) { setField(2, v); }
  bool hasVersion() => hasField(2);
  void clearVersion() => clearField(2);
}

class StopModuleResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StopModuleResponse')
    ..hasRequiredFields = false
  ;

  StopModuleResponse() : super();
  StopModuleResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StopModuleResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StopModuleResponse clone() => new StopModuleResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class GetHostnameRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetHostnameRequest')
    ..a(1, 'module', GeneratedMessage.OS)
    ..a(2, 'version', GeneratedMessage.OS)
    ..a(3, 'instance', GeneratedMessage.OS)
    ..hasRequiredFields = false
  ;

  GetHostnameRequest() : super();
  GetHostnameRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetHostnameRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetHostnameRequest clone() => new GetHostnameRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get module => getField(1);
  void set module(String v) { setField(1, v); }
  bool hasModule() => hasField(1);
  void clearModule() => clearField(1);

  String get version => getField(2);
  void set version(String v) { setField(2, v); }
  bool hasVersion() => hasField(2);
  void clearVersion() => clearField(2);

  String get instance => getField(3);
  void set instance(String v) { setField(3, v); }
  bool hasInstance() => hasField(3);
  void clearInstance() => clearField(3);
}

class GetHostnameResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetHostnameResponse')
    ..a(1, 'hostname', GeneratedMessage.QS)
  ;

  GetHostnameResponse() : super();
  GetHostnameResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetHostnameResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetHostnameResponse clone() => new GetHostnameResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get hostname => getField(1);
  void set hostname(String v) { setField(1, v); }
  bool hasHostname() => hasField(1);
  void clearHostname() => clearField(1);
}

