///
//  Generated code. Do not modify.
///
library google.devtools.clouderrorreporting.v1beta1_report_errors_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import 'common.pb.dart';

class ReportErrorEventRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReportErrorEventRequest')
    ..a/*<String>*/(1, 'projectName', PbFieldType.OS)
    ..a/*<ReportedErrorEvent>*/(2, 'event', PbFieldType.OM, ReportedErrorEvent.getDefault, ReportedErrorEvent.create)
    ..hasRequiredFields = false
  ;

  ReportErrorEventRequest() : super();
  ReportErrorEventRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReportErrorEventRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReportErrorEventRequest clone() => new ReportErrorEventRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReportErrorEventRequest create() => new ReportErrorEventRequest();
  static PbList<ReportErrorEventRequest> createRepeated() => new PbList<ReportErrorEventRequest>();
  static ReportErrorEventRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReportErrorEventRequest();
    return _defaultInstance;
  }
  static ReportErrorEventRequest _defaultInstance;
  static void $checkItem(ReportErrorEventRequest v) {
    if (v is !ReportErrorEventRequest) checkItemFailed(v, 'ReportErrorEventRequest');
  }

  String get projectName => $_get(0, 1, '');
  void set projectName(String v) { $_setString(0, 1, v); }
  bool hasProjectName() => $_has(0, 1);
  void clearProjectName() => clearField(1);

  ReportedErrorEvent get event => $_get(1, 2, null);
  void set event(ReportedErrorEvent v) { setField(2, v); }
  bool hasEvent() => $_has(1, 2);
  void clearEvent() => clearField(2);
}

class _ReadonlyReportErrorEventRequest extends ReportErrorEventRequest with ReadonlyMessageMixin {}

class ReportErrorEventResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReportErrorEventResponse')
    ..hasRequiredFields = false
  ;

  ReportErrorEventResponse() : super();
  ReportErrorEventResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReportErrorEventResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReportErrorEventResponse clone() => new ReportErrorEventResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReportErrorEventResponse create() => new ReportErrorEventResponse();
  static PbList<ReportErrorEventResponse> createRepeated() => new PbList<ReportErrorEventResponse>();
  static ReportErrorEventResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReportErrorEventResponse();
    return _defaultInstance;
  }
  static ReportErrorEventResponse _defaultInstance;
  static void $checkItem(ReportErrorEventResponse v) {
    if (v is !ReportErrorEventResponse) checkItemFailed(v, 'ReportErrorEventResponse');
  }
}

class _ReadonlyReportErrorEventResponse extends ReportErrorEventResponse with ReadonlyMessageMixin {}

class ReportedErrorEvent extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReportedErrorEvent')
    ..a/*<google$protobuf.Timestamp>*/(1, 'eventTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<ServiceContext>*/(2, 'serviceContext', PbFieldType.OM, ServiceContext.getDefault, ServiceContext.create)
    ..a/*<String>*/(3, 'message', PbFieldType.OS)
    ..a/*<ErrorContext>*/(4, 'context', PbFieldType.OM, ErrorContext.getDefault, ErrorContext.create)
    ..hasRequiredFields = false
  ;

  ReportedErrorEvent() : super();
  ReportedErrorEvent.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReportedErrorEvent.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReportedErrorEvent clone() => new ReportedErrorEvent()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReportedErrorEvent create() => new ReportedErrorEvent();
  static PbList<ReportedErrorEvent> createRepeated() => new PbList<ReportedErrorEvent>();
  static ReportedErrorEvent getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReportedErrorEvent();
    return _defaultInstance;
  }
  static ReportedErrorEvent _defaultInstance;
  static void $checkItem(ReportedErrorEvent v) {
    if (v is !ReportedErrorEvent) checkItemFailed(v, 'ReportedErrorEvent');
  }

  google$protobuf.Timestamp get eventTime => $_get(0, 1, null);
  void set eventTime(google$protobuf.Timestamp v) { setField(1, v); }
  bool hasEventTime() => $_has(0, 1);
  void clearEventTime() => clearField(1);

  ServiceContext get serviceContext => $_get(1, 2, null);
  void set serviceContext(ServiceContext v) { setField(2, v); }
  bool hasServiceContext() => $_has(1, 2);
  void clearServiceContext() => clearField(2);

  String get message => $_get(2, 3, '');
  void set message(String v) { $_setString(2, 3, v); }
  bool hasMessage() => $_has(2, 3);
  void clearMessage() => clearField(3);

  ErrorContext get context => $_get(3, 4, null);
  void set context(ErrorContext v) { setField(4, v); }
  bool hasContext() => $_has(3, 4);
  void clearContext() => clearField(4);
}

class _ReadonlyReportedErrorEvent extends ReportedErrorEvent with ReadonlyMessageMixin {}

class ReportErrorsServiceApi {
  RpcClient _client;
  ReportErrorsServiceApi(this._client);

  Future<ReportErrorEventResponse> reportErrorEvent(ClientContext ctx, ReportErrorEventRequest request) {
    var emptyResponse = new ReportErrorEventResponse();
    return _client.invoke(ctx, 'ReportErrorsService', 'ReportErrorEvent', request, emptyResponse);
  }
}

