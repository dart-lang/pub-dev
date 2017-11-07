///
//  Generated code. Do not modify.
///
library google.devtools.clouddebugger.v2_controller;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'data.pb.dart';

class RegisterDebuggeeRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RegisterDebuggeeRequest')
    ..a/*<Debuggee>*/(1, 'debuggee', PbFieldType.OM, Debuggee.getDefault, Debuggee.create)
    ..hasRequiredFields = false
  ;

  RegisterDebuggeeRequest() : super();
  RegisterDebuggeeRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RegisterDebuggeeRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RegisterDebuggeeRequest clone() => new RegisterDebuggeeRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RegisterDebuggeeRequest create() => new RegisterDebuggeeRequest();
  static PbList<RegisterDebuggeeRequest> createRepeated() => new PbList<RegisterDebuggeeRequest>();
  static RegisterDebuggeeRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRegisterDebuggeeRequest();
    return _defaultInstance;
  }
  static RegisterDebuggeeRequest _defaultInstance;
  static void $checkItem(RegisterDebuggeeRequest v) {
    if (v is !RegisterDebuggeeRequest) checkItemFailed(v, 'RegisterDebuggeeRequest');
  }

  Debuggee get debuggee => $_get(0, 1, null);
  void set debuggee(Debuggee v) { setField(1, v); }
  bool hasDebuggee() => $_has(0, 1);
  void clearDebuggee() => clearField(1);
}

class _ReadonlyRegisterDebuggeeRequest extends RegisterDebuggeeRequest with ReadonlyMessageMixin {}

class RegisterDebuggeeResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RegisterDebuggeeResponse')
    ..a/*<Debuggee>*/(1, 'debuggee', PbFieldType.OM, Debuggee.getDefault, Debuggee.create)
    ..hasRequiredFields = false
  ;

  RegisterDebuggeeResponse() : super();
  RegisterDebuggeeResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RegisterDebuggeeResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RegisterDebuggeeResponse clone() => new RegisterDebuggeeResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RegisterDebuggeeResponse create() => new RegisterDebuggeeResponse();
  static PbList<RegisterDebuggeeResponse> createRepeated() => new PbList<RegisterDebuggeeResponse>();
  static RegisterDebuggeeResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRegisterDebuggeeResponse();
    return _defaultInstance;
  }
  static RegisterDebuggeeResponse _defaultInstance;
  static void $checkItem(RegisterDebuggeeResponse v) {
    if (v is !RegisterDebuggeeResponse) checkItemFailed(v, 'RegisterDebuggeeResponse');
  }

  Debuggee get debuggee => $_get(0, 1, null);
  void set debuggee(Debuggee v) { setField(1, v); }
  bool hasDebuggee() => $_has(0, 1);
  void clearDebuggee() => clearField(1);
}

class _ReadonlyRegisterDebuggeeResponse extends RegisterDebuggeeResponse with ReadonlyMessageMixin {}

class ListActiveBreakpointsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListActiveBreakpointsRequest')
    ..a/*<String>*/(1, 'debuggeeId', PbFieldType.OS)
    ..a/*<String>*/(2, 'waitToken', PbFieldType.OS)
    ..a/*<bool>*/(3, 'successOnTimeout', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  ListActiveBreakpointsRequest() : super();
  ListActiveBreakpointsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListActiveBreakpointsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListActiveBreakpointsRequest clone() => new ListActiveBreakpointsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListActiveBreakpointsRequest create() => new ListActiveBreakpointsRequest();
  static PbList<ListActiveBreakpointsRequest> createRepeated() => new PbList<ListActiveBreakpointsRequest>();
  static ListActiveBreakpointsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListActiveBreakpointsRequest();
    return _defaultInstance;
  }
  static ListActiveBreakpointsRequest _defaultInstance;
  static void $checkItem(ListActiveBreakpointsRequest v) {
    if (v is !ListActiveBreakpointsRequest) checkItemFailed(v, 'ListActiveBreakpointsRequest');
  }

  String get debuggeeId => $_get(0, 1, '');
  void set debuggeeId(String v) { $_setString(0, 1, v); }
  bool hasDebuggeeId() => $_has(0, 1);
  void clearDebuggeeId() => clearField(1);

  String get waitToken => $_get(1, 2, '');
  void set waitToken(String v) { $_setString(1, 2, v); }
  bool hasWaitToken() => $_has(1, 2);
  void clearWaitToken() => clearField(2);

  bool get successOnTimeout => $_get(2, 3, false);
  void set successOnTimeout(bool v) { $_setBool(2, 3, v); }
  bool hasSuccessOnTimeout() => $_has(2, 3);
  void clearSuccessOnTimeout() => clearField(3);
}

class _ReadonlyListActiveBreakpointsRequest extends ListActiveBreakpointsRequest with ReadonlyMessageMixin {}

class ListActiveBreakpointsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListActiveBreakpointsResponse')
    ..pp/*<Breakpoint>*/(1, 'breakpoints', PbFieldType.PM, Breakpoint.$checkItem, Breakpoint.create)
    ..a/*<String>*/(2, 'nextWaitToken', PbFieldType.OS)
    ..a/*<bool>*/(3, 'waitExpired', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  ListActiveBreakpointsResponse() : super();
  ListActiveBreakpointsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListActiveBreakpointsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListActiveBreakpointsResponse clone() => new ListActiveBreakpointsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListActiveBreakpointsResponse create() => new ListActiveBreakpointsResponse();
  static PbList<ListActiveBreakpointsResponse> createRepeated() => new PbList<ListActiveBreakpointsResponse>();
  static ListActiveBreakpointsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListActiveBreakpointsResponse();
    return _defaultInstance;
  }
  static ListActiveBreakpointsResponse _defaultInstance;
  static void $checkItem(ListActiveBreakpointsResponse v) {
    if (v is !ListActiveBreakpointsResponse) checkItemFailed(v, 'ListActiveBreakpointsResponse');
  }

  List<Breakpoint> get breakpoints => $_get(0, 1, null);

  String get nextWaitToken => $_get(1, 2, '');
  void set nextWaitToken(String v) { $_setString(1, 2, v); }
  bool hasNextWaitToken() => $_has(1, 2);
  void clearNextWaitToken() => clearField(2);

  bool get waitExpired => $_get(2, 3, false);
  void set waitExpired(bool v) { $_setBool(2, 3, v); }
  bool hasWaitExpired() => $_has(2, 3);
  void clearWaitExpired() => clearField(3);
}

class _ReadonlyListActiveBreakpointsResponse extends ListActiveBreakpointsResponse with ReadonlyMessageMixin {}

class UpdateActiveBreakpointRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateActiveBreakpointRequest')
    ..a/*<String>*/(1, 'debuggeeId', PbFieldType.OS)
    ..a/*<Breakpoint>*/(2, 'breakpoint', PbFieldType.OM, Breakpoint.getDefault, Breakpoint.create)
    ..hasRequiredFields = false
  ;

  UpdateActiveBreakpointRequest() : super();
  UpdateActiveBreakpointRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateActiveBreakpointRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateActiveBreakpointRequest clone() => new UpdateActiveBreakpointRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateActiveBreakpointRequest create() => new UpdateActiveBreakpointRequest();
  static PbList<UpdateActiveBreakpointRequest> createRepeated() => new PbList<UpdateActiveBreakpointRequest>();
  static UpdateActiveBreakpointRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateActiveBreakpointRequest();
    return _defaultInstance;
  }
  static UpdateActiveBreakpointRequest _defaultInstance;
  static void $checkItem(UpdateActiveBreakpointRequest v) {
    if (v is !UpdateActiveBreakpointRequest) checkItemFailed(v, 'UpdateActiveBreakpointRequest');
  }

  String get debuggeeId => $_get(0, 1, '');
  void set debuggeeId(String v) { $_setString(0, 1, v); }
  bool hasDebuggeeId() => $_has(0, 1);
  void clearDebuggeeId() => clearField(1);

  Breakpoint get breakpoint => $_get(1, 2, null);
  void set breakpoint(Breakpoint v) { setField(2, v); }
  bool hasBreakpoint() => $_has(1, 2);
  void clearBreakpoint() => clearField(2);
}

class _ReadonlyUpdateActiveBreakpointRequest extends UpdateActiveBreakpointRequest with ReadonlyMessageMixin {}

class UpdateActiveBreakpointResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateActiveBreakpointResponse')
    ..hasRequiredFields = false
  ;

  UpdateActiveBreakpointResponse() : super();
  UpdateActiveBreakpointResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateActiveBreakpointResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateActiveBreakpointResponse clone() => new UpdateActiveBreakpointResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateActiveBreakpointResponse create() => new UpdateActiveBreakpointResponse();
  static PbList<UpdateActiveBreakpointResponse> createRepeated() => new PbList<UpdateActiveBreakpointResponse>();
  static UpdateActiveBreakpointResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateActiveBreakpointResponse();
    return _defaultInstance;
  }
  static UpdateActiveBreakpointResponse _defaultInstance;
  static void $checkItem(UpdateActiveBreakpointResponse v) {
    if (v is !UpdateActiveBreakpointResponse) checkItemFailed(v, 'UpdateActiveBreakpointResponse');
  }
}

class _ReadonlyUpdateActiveBreakpointResponse extends UpdateActiveBreakpointResponse with ReadonlyMessageMixin {}

class Controller2Api {
  RpcClient _client;
  Controller2Api(this._client);

  Future<RegisterDebuggeeResponse> registerDebuggee(ClientContext ctx, RegisterDebuggeeRequest request) {
    var emptyResponse = new RegisterDebuggeeResponse();
    return _client.invoke(ctx, 'Controller2', 'RegisterDebuggee', request, emptyResponse);
  }
  Future<ListActiveBreakpointsResponse> listActiveBreakpoints(ClientContext ctx, ListActiveBreakpointsRequest request) {
    var emptyResponse = new ListActiveBreakpointsResponse();
    return _client.invoke(ctx, 'Controller2', 'ListActiveBreakpoints', request, emptyResponse);
  }
  Future<UpdateActiveBreakpointResponse> updateActiveBreakpoint(ClientContext ctx, UpdateActiveBreakpointRequest request) {
    var emptyResponse = new UpdateActiveBreakpointResponse();
    return _client.invoke(ctx, 'Controller2', 'UpdateActiveBreakpoint', request, emptyResponse);
  }
}

