///
//  Generated code. Do not modify.
///
library google.devtools.clouddebugger.v2_debugger;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'data.pb.dart';
import '../../../protobuf/empty.pb.dart' as google$protobuf;

import 'data.pbenum.dart';

class SetBreakpointRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SetBreakpointRequest')
    ..a/*<String>*/(1, 'debuggeeId', PbFieldType.OS)
    ..a/*<Breakpoint>*/(2, 'breakpoint', PbFieldType.OM, Breakpoint.getDefault, Breakpoint.create)
    ..a/*<String>*/(4, 'clientVersion', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SetBreakpointRequest() : super();
  SetBreakpointRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SetBreakpointRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SetBreakpointRequest clone() => new SetBreakpointRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SetBreakpointRequest create() => new SetBreakpointRequest();
  static PbList<SetBreakpointRequest> createRepeated() => new PbList<SetBreakpointRequest>();
  static SetBreakpointRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySetBreakpointRequest();
    return _defaultInstance;
  }
  static SetBreakpointRequest _defaultInstance;
  static void $checkItem(SetBreakpointRequest v) {
    if (v is !SetBreakpointRequest) checkItemFailed(v, 'SetBreakpointRequest');
  }

  String get debuggeeId => $_get(0, 1, '');
  void set debuggeeId(String v) { $_setString(0, 1, v); }
  bool hasDebuggeeId() => $_has(0, 1);
  void clearDebuggeeId() => clearField(1);

  Breakpoint get breakpoint => $_get(1, 2, null);
  void set breakpoint(Breakpoint v) { setField(2, v); }
  bool hasBreakpoint() => $_has(1, 2);
  void clearBreakpoint() => clearField(2);

  String get clientVersion => $_get(2, 4, '');
  void set clientVersion(String v) { $_setString(2, 4, v); }
  bool hasClientVersion() => $_has(2, 4);
  void clearClientVersion() => clearField(4);
}

class _ReadonlySetBreakpointRequest extends SetBreakpointRequest with ReadonlyMessageMixin {}

class SetBreakpointResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SetBreakpointResponse')
    ..a/*<Breakpoint>*/(1, 'breakpoint', PbFieldType.OM, Breakpoint.getDefault, Breakpoint.create)
    ..hasRequiredFields = false
  ;

  SetBreakpointResponse() : super();
  SetBreakpointResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SetBreakpointResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SetBreakpointResponse clone() => new SetBreakpointResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SetBreakpointResponse create() => new SetBreakpointResponse();
  static PbList<SetBreakpointResponse> createRepeated() => new PbList<SetBreakpointResponse>();
  static SetBreakpointResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySetBreakpointResponse();
    return _defaultInstance;
  }
  static SetBreakpointResponse _defaultInstance;
  static void $checkItem(SetBreakpointResponse v) {
    if (v is !SetBreakpointResponse) checkItemFailed(v, 'SetBreakpointResponse');
  }

  Breakpoint get breakpoint => $_get(0, 1, null);
  void set breakpoint(Breakpoint v) { setField(1, v); }
  bool hasBreakpoint() => $_has(0, 1);
  void clearBreakpoint() => clearField(1);
}

class _ReadonlySetBreakpointResponse extends SetBreakpointResponse with ReadonlyMessageMixin {}

class GetBreakpointRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetBreakpointRequest')
    ..a/*<String>*/(1, 'debuggeeId', PbFieldType.OS)
    ..a/*<String>*/(2, 'breakpointId', PbFieldType.OS)
    ..a/*<String>*/(4, 'clientVersion', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetBreakpointRequest() : super();
  GetBreakpointRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetBreakpointRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetBreakpointRequest clone() => new GetBreakpointRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetBreakpointRequest create() => new GetBreakpointRequest();
  static PbList<GetBreakpointRequest> createRepeated() => new PbList<GetBreakpointRequest>();
  static GetBreakpointRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetBreakpointRequest();
    return _defaultInstance;
  }
  static GetBreakpointRequest _defaultInstance;
  static void $checkItem(GetBreakpointRequest v) {
    if (v is !GetBreakpointRequest) checkItemFailed(v, 'GetBreakpointRequest');
  }

  String get debuggeeId => $_get(0, 1, '');
  void set debuggeeId(String v) { $_setString(0, 1, v); }
  bool hasDebuggeeId() => $_has(0, 1);
  void clearDebuggeeId() => clearField(1);

  String get breakpointId => $_get(1, 2, '');
  void set breakpointId(String v) { $_setString(1, 2, v); }
  bool hasBreakpointId() => $_has(1, 2);
  void clearBreakpointId() => clearField(2);

  String get clientVersion => $_get(2, 4, '');
  void set clientVersion(String v) { $_setString(2, 4, v); }
  bool hasClientVersion() => $_has(2, 4);
  void clearClientVersion() => clearField(4);
}

class _ReadonlyGetBreakpointRequest extends GetBreakpointRequest with ReadonlyMessageMixin {}

class GetBreakpointResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetBreakpointResponse')
    ..a/*<Breakpoint>*/(1, 'breakpoint', PbFieldType.OM, Breakpoint.getDefault, Breakpoint.create)
    ..hasRequiredFields = false
  ;

  GetBreakpointResponse() : super();
  GetBreakpointResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetBreakpointResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetBreakpointResponse clone() => new GetBreakpointResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetBreakpointResponse create() => new GetBreakpointResponse();
  static PbList<GetBreakpointResponse> createRepeated() => new PbList<GetBreakpointResponse>();
  static GetBreakpointResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetBreakpointResponse();
    return _defaultInstance;
  }
  static GetBreakpointResponse _defaultInstance;
  static void $checkItem(GetBreakpointResponse v) {
    if (v is !GetBreakpointResponse) checkItemFailed(v, 'GetBreakpointResponse');
  }

  Breakpoint get breakpoint => $_get(0, 1, null);
  void set breakpoint(Breakpoint v) { setField(1, v); }
  bool hasBreakpoint() => $_has(0, 1);
  void clearBreakpoint() => clearField(1);
}

class _ReadonlyGetBreakpointResponse extends GetBreakpointResponse with ReadonlyMessageMixin {}

class DeleteBreakpointRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteBreakpointRequest')
    ..a/*<String>*/(1, 'debuggeeId', PbFieldType.OS)
    ..a/*<String>*/(2, 'breakpointId', PbFieldType.OS)
    ..a/*<String>*/(3, 'clientVersion', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteBreakpointRequest() : super();
  DeleteBreakpointRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteBreakpointRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteBreakpointRequest clone() => new DeleteBreakpointRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteBreakpointRequest create() => new DeleteBreakpointRequest();
  static PbList<DeleteBreakpointRequest> createRepeated() => new PbList<DeleteBreakpointRequest>();
  static DeleteBreakpointRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteBreakpointRequest();
    return _defaultInstance;
  }
  static DeleteBreakpointRequest _defaultInstance;
  static void $checkItem(DeleteBreakpointRequest v) {
    if (v is !DeleteBreakpointRequest) checkItemFailed(v, 'DeleteBreakpointRequest');
  }

  String get debuggeeId => $_get(0, 1, '');
  void set debuggeeId(String v) { $_setString(0, 1, v); }
  bool hasDebuggeeId() => $_has(0, 1);
  void clearDebuggeeId() => clearField(1);

  String get breakpointId => $_get(1, 2, '');
  void set breakpointId(String v) { $_setString(1, 2, v); }
  bool hasBreakpointId() => $_has(1, 2);
  void clearBreakpointId() => clearField(2);

  String get clientVersion => $_get(2, 3, '');
  void set clientVersion(String v) { $_setString(2, 3, v); }
  bool hasClientVersion() => $_has(2, 3);
  void clearClientVersion() => clearField(3);
}

class _ReadonlyDeleteBreakpointRequest extends DeleteBreakpointRequest with ReadonlyMessageMixin {}

class ListBreakpointsRequest_BreakpointActionValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListBreakpointsRequest_BreakpointActionValue')
    ..e/*<Breakpoint_Action>*/(1, 'value', PbFieldType.OE, Breakpoint_Action.CAPTURE, Breakpoint_Action.valueOf)
    ..hasRequiredFields = false
  ;

  ListBreakpointsRequest_BreakpointActionValue() : super();
  ListBreakpointsRequest_BreakpointActionValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListBreakpointsRequest_BreakpointActionValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListBreakpointsRequest_BreakpointActionValue clone() => new ListBreakpointsRequest_BreakpointActionValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListBreakpointsRequest_BreakpointActionValue create() => new ListBreakpointsRequest_BreakpointActionValue();
  static PbList<ListBreakpointsRequest_BreakpointActionValue> createRepeated() => new PbList<ListBreakpointsRequest_BreakpointActionValue>();
  static ListBreakpointsRequest_BreakpointActionValue getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListBreakpointsRequest_BreakpointActionValue();
    return _defaultInstance;
  }
  static ListBreakpointsRequest_BreakpointActionValue _defaultInstance;
  static void $checkItem(ListBreakpointsRequest_BreakpointActionValue v) {
    if (v is !ListBreakpointsRequest_BreakpointActionValue) checkItemFailed(v, 'ListBreakpointsRequest_BreakpointActionValue');
  }

  Breakpoint_Action get value => $_get(0, 1, null);
  void set value(Breakpoint_Action v) { setField(1, v); }
  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyListBreakpointsRequest_BreakpointActionValue extends ListBreakpointsRequest_BreakpointActionValue with ReadonlyMessageMixin {}

class ListBreakpointsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListBreakpointsRequest')
    ..a/*<String>*/(1, 'debuggeeId', PbFieldType.OS)
    ..a/*<bool>*/(2, 'includeAllUsers', PbFieldType.OB)
    ..a/*<bool>*/(3, 'includeInactive', PbFieldType.OB)
    ..a/*<ListBreakpointsRequest_BreakpointActionValue>*/(4, 'action', PbFieldType.OM, ListBreakpointsRequest_BreakpointActionValue.getDefault, ListBreakpointsRequest_BreakpointActionValue.create)
    ..a/*<bool>*/(5, 'stripResults', PbFieldType.OB)
    ..a/*<String>*/(6, 'waitToken', PbFieldType.OS)
    ..a/*<String>*/(8, 'clientVersion', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListBreakpointsRequest() : super();
  ListBreakpointsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListBreakpointsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListBreakpointsRequest clone() => new ListBreakpointsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListBreakpointsRequest create() => new ListBreakpointsRequest();
  static PbList<ListBreakpointsRequest> createRepeated() => new PbList<ListBreakpointsRequest>();
  static ListBreakpointsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListBreakpointsRequest();
    return _defaultInstance;
  }
  static ListBreakpointsRequest _defaultInstance;
  static void $checkItem(ListBreakpointsRequest v) {
    if (v is !ListBreakpointsRequest) checkItemFailed(v, 'ListBreakpointsRequest');
  }

  String get debuggeeId => $_get(0, 1, '');
  void set debuggeeId(String v) { $_setString(0, 1, v); }
  bool hasDebuggeeId() => $_has(0, 1);
  void clearDebuggeeId() => clearField(1);

  bool get includeAllUsers => $_get(1, 2, false);
  void set includeAllUsers(bool v) { $_setBool(1, 2, v); }
  bool hasIncludeAllUsers() => $_has(1, 2);
  void clearIncludeAllUsers() => clearField(2);

  bool get includeInactive => $_get(2, 3, false);
  void set includeInactive(bool v) { $_setBool(2, 3, v); }
  bool hasIncludeInactive() => $_has(2, 3);
  void clearIncludeInactive() => clearField(3);

  ListBreakpointsRequest_BreakpointActionValue get action => $_get(3, 4, null);
  void set action(ListBreakpointsRequest_BreakpointActionValue v) { setField(4, v); }
  bool hasAction() => $_has(3, 4);
  void clearAction() => clearField(4);

  bool get stripResults => $_get(4, 5, false);
  void set stripResults(bool v) { $_setBool(4, 5, v); }
  bool hasStripResults() => $_has(4, 5);
  void clearStripResults() => clearField(5);

  String get waitToken => $_get(5, 6, '');
  void set waitToken(String v) { $_setString(5, 6, v); }
  bool hasWaitToken() => $_has(5, 6);
  void clearWaitToken() => clearField(6);

  String get clientVersion => $_get(6, 8, '');
  void set clientVersion(String v) { $_setString(6, 8, v); }
  bool hasClientVersion() => $_has(6, 8);
  void clearClientVersion() => clearField(8);
}

class _ReadonlyListBreakpointsRequest extends ListBreakpointsRequest with ReadonlyMessageMixin {}

class ListBreakpointsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListBreakpointsResponse')
    ..pp/*<Breakpoint>*/(1, 'breakpoints', PbFieldType.PM, Breakpoint.$checkItem, Breakpoint.create)
    ..a/*<String>*/(2, 'nextWaitToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListBreakpointsResponse() : super();
  ListBreakpointsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListBreakpointsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListBreakpointsResponse clone() => new ListBreakpointsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListBreakpointsResponse create() => new ListBreakpointsResponse();
  static PbList<ListBreakpointsResponse> createRepeated() => new PbList<ListBreakpointsResponse>();
  static ListBreakpointsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListBreakpointsResponse();
    return _defaultInstance;
  }
  static ListBreakpointsResponse _defaultInstance;
  static void $checkItem(ListBreakpointsResponse v) {
    if (v is !ListBreakpointsResponse) checkItemFailed(v, 'ListBreakpointsResponse');
  }

  List<Breakpoint> get breakpoints => $_get(0, 1, null);

  String get nextWaitToken => $_get(1, 2, '');
  void set nextWaitToken(String v) { $_setString(1, 2, v); }
  bool hasNextWaitToken() => $_has(1, 2);
  void clearNextWaitToken() => clearField(2);
}

class _ReadonlyListBreakpointsResponse extends ListBreakpointsResponse with ReadonlyMessageMixin {}

class ListDebuggeesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListDebuggeesRequest')
    ..a/*<String>*/(2, 'project', PbFieldType.OS)
    ..a/*<bool>*/(3, 'includeInactive', PbFieldType.OB)
    ..a/*<String>*/(4, 'clientVersion', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListDebuggeesRequest() : super();
  ListDebuggeesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListDebuggeesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListDebuggeesRequest clone() => new ListDebuggeesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListDebuggeesRequest create() => new ListDebuggeesRequest();
  static PbList<ListDebuggeesRequest> createRepeated() => new PbList<ListDebuggeesRequest>();
  static ListDebuggeesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListDebuggeesRequest();
    return _defaultInstance;
  }
  static ListDebuggeesRequest _defaultInstance;
  static void $checkItem(ListDebuggeesRequest v) {
    if (v is !ListDebuggeesRequest) checkItemFailed(v, 'ListDebuggeesRequest');
  }

  String get project => $_get(0, 2, '');
  void set project(String v) { $_setString(0, 2, v); }
  bool hasProject() => $_has(0, 2);
  void clearProject() => clearField(2);

  bool get includeInactive => $_get(1, 3, false);
  void set includeInactive(bool v) { $_setBool(1, 3, v); }
  bool hasIncludeInactive() => $_has(1, 3);
  void clearIncludeInactive() => clearField(3);

  String get clientVersion => $_get(2, 4, '');
  void set clientVersion(String v) { $_setString(2, 4, v); }
  bool hasClientVersion() => $_has(2, 4);
  void clearClientVersion() => clearField(4);
}

class _ReadonlyListDebuggeesRequest extends ListDebuggeesRequest with ReadonlyMessageMixin {}

class ListDebuggeesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListDebuggeesResponse')
    ..pp/*<Debuggee>*/(1, 'debuggees', PbFieldType.PM, Debuggee.$checkItem, Debuggee.create)
    ..hasRequiredFields = false
  ;

  ListDebuggeesResponse() : super();
  ListDebuggeesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListDebuggeesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListDebuggeesResponse clone() => new ListDebuggeesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListDebuggeesResponse create() => new ListDebuggeesResponse();
  static PbList<ListDebuggeesResponse> createRepeated() => new PbList<ListDebuggeesResponse>();
  static ListDebuggeesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListDebuggeesResponse();
    return _defaultInstance;
  }
  static ListDebuggeesResponse _defaultInstance;
  static void $checkItem(ListDebuggeesResponse v) {
    if (v is !ListDebuggeesResponse) checkItemFailed(v, 'ListDebuggeesResponse');
  }

  List<Debuggee> get debuggees => $_get(0, 1, null);
}

class _ReadonlyListDebuggeesResponse extends ListDebuggeesResponse with ReadonlyMessageMixin {}

class Debugger2Api {
  RpcClient _client;
  Debugger2Api(this._client);

  Future<SetBreakpointResponse> setBreakpoint(ClientContext ctx, SetBreakpointRequest request) {
    var emptyResponse = new SetBreakpointResponse();
    return _client.invoke(ctx, 'Debugger2', 'SetBreakpoint', request, emptyResponse);
  }
  Future<GetBreakpointResponse> getBreakpoint(ClientContext ctx, GetBreakpointRequest request) {
    var emptyResponse = new GetBreakpointResponse();
    return _client.invoke(ctx, 'Debugger2', 'GetBreakpoint', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteBreakpoint(ClientContext ctx, DeleteBreakpointRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'Debugger2', 'DeleteBreakpoint', request, emptyResponse);
  }
  Future<ListBreakpointsResponse> listBreakpoints(ClientContext ctx, ListBreakpointsRequest request) {
    var emptyResponse = new ListBreakpointsResponse();
    return _client.invoke(ctx, 'Debugger2', 'ListBreakpoints', request, emptyResponse);
  }
  Future<ListDebuggeesResponse> listDebuggees(ClientContext ctx, ListDebuggeesRequest request) {
    var emptyResponse = new ListDebuggeesResponse();
    return _client.invoke(ctx, 'Debugger2', 'ListDebuggees', request, emptyResponse);
  }
}

