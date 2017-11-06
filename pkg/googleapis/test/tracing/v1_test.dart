library googleapis.tracing.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/tracing/v1.dart' as api;

class HttpServerMock extends http.BaseClient {
  core.Function _callback;
  core.bool _expectJson;

  void register(core.Function callback, core.bool expectJson) {
    _callback = callback;
    _expectJson = expectJson;
  }

  async.Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (_expectJson) {
      return request.finalize()
          .transform(convert.UTF8.decoder)
          .join('')
          .then((core.String jsonString) {
        if (jsonString.isEmpty) {
          return _callback(request, null);
        } else {
          return _callback(request, convert.JSON.decode(jsonString));
        }
      });
    } else {
      var stream = request.finalize();
      if (stream == null) {
        return _callback(request, []);
      } else {
        return stream.toBytes().then((data) {
          return _callback(request, data);
        });
      }
    }
  }
}

http.StreamedResponse stringResponse(
    core.int status, core.Map headers, core.String body) {
  var stream = new async.Stream.fromIterable([convert.UTF8.encode(body)]);
  return new http.StreamedResponse(stream, status, headers: headers);
}

buildUnnamed2958() {
  var o = new core.Map<core.String, api.AttributeValue>();
  o["x"] = buildAttributeValue();
  o["y"] = buildAttributeValue();
  return o;
}

checkUnnamed2958(core.Map<core.String, api.AttributeValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAttributeValue(o["x"]);
  checkAttributeValue(o["y"]);
}

core.int buildCounterAnnotation = 0;
buildAnnotation() {
  var o = new api.Annotation();
  buildCounterAnnotation++;
  if (buildCounterAnnotation < 3) {
    o.attributes = buildUnnamed2958();
    o.description = "foo";
  }
  buildCounterAnnotation--;
  return o;
}

checkAnnotation(api.Annotation o) {
  buildCounterAnnotation++;
  if (buildCounterAnnotation < 3) {
    checkUnnamed2958(o.attributes);
    unittest.expect(o.description, unittest.equals('foo'));
  }
  buildCounterAnnotation--;
}

core.int buildCounterAttributeValue = 0;
buildAttributeValue() {
  var o = new api.AttributeValue();
  buildCounterAttributeValue++;
  if (buildCounterAttributeValue < 3) {
    o.boolValue = true;
    o.intValue = "foo";
    o.stringValue = "foo";
  }
  buildCounterAttributeValue--;
  return o;
}

checkAttributeValue(api.AttributeValue o) {
  buildCounterAttributeValue++;
  if (buildCounterAttributeValue < 3) {
    unittest.expect(o.boolValue, unittest.isTrue);
    unittest.expect(o.intValue, unittest.equals('foo'));
    unittest.expect(o.stringValue, unittest.equals('foo'));
  }
  buildCounterAttributeValue--;
}

buildUnnamed2959() {
  var o = new core.Map<core.String, api.SpanUpdates>();
  o["x"] = buildSpanUpdates();
  o["y"] = buildSpanUpdates();
  return o;
}

checkUnnamed2959(core.Map<core.String, api.SpanUpdates> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSpanUpdates(o["x"]);
  checkSpanUpdates(o["y"]);
}

core.int buildCounterBatchUpdateSpansRequest = 0;
buildBatchUpdateSpansRequest() {
  var o = new api.BatchUpdateSpansRequest();
  buildCounterBatchUpdateSpansRequest++;
  if (buildCounterBatchUpdateSpansRequest < 3) {
    o.spanUpdates = buildUnnamed2959();
  }
  buildCounterBatchUpdateSpansRequest--;
  return o;
}

checkBatchUpdateSpansRequest(api.BatchUpdateSpansRequest o) {
  buildCounterBatchUpdateSpansRequest++;
  if (buildCounterBatchUpdateSpansRequest < 3) {
    checkUnnamed2959(o.spanUpdates);
  }
  buildCounterBatchUpdateSpansRequest--;
}

core.int buildCounterEmpty = 0;
buildEmpty() {
  var o = new api.Empty();
  buildCounterEmpty++;
  if (buildCounterEmpty < 3) {
  }
  buildCounterEmpty--;
  return o;
}

checkEmpty(api.Empty o) {
  buildCounterEmpty++;
  if (buildCounterEmpty < 3) {
  }
  buildCounterEmpty--;
}

core.int buildCounterLink = 0;
buildLink() {
  var o = new api.Link();
  buildCounterLink++;
  if (buildCounterLink < 3) {
    o.spanId = "foo";
    o.traceId = "foo";
    o.type = "foo";
  }
  buildCounterLink--;
  return o;
}

checkLink(api.Link o) {
  buildCounterLink++;
  if (buildCounterLink < 3) {
    unittest.expect(o.spanId, unittest.equals('foo'));
    unittest.expect(o.traceId, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterLink--;
}

buildUnnamed2960() {
  var o = new core.List<api.Span>();
  o.add(buildSpan());
  o.add(buildSpan());
  return o;
}

checkUnnamed2960(core.List<api.Span> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSpan(o[0]);
  checkSpan(o[1]);
}

core.int buildCounterListSpansResponse = 0;
buildListSpansResponse() {
  var o = new api.ListSpansResponse();
  buildCounterListSpansResponse++;
  if (buildCounterListSpansResponse < 3) {
    o.nextPageToken = "foo";
    o.spans = buildUnnamed2960();
  }
  buildCounterListSpansResponse--;
  return o;
}

checkListSpansResponse(api.ListSpansResponse o) {
  buildCounterListSpansResponse++;
  if (buildCounterListSpansResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed2960(o.spans);
  }
  buildCounterListSpansResponse--;
}

buildUnnamed2961() {
  var o = new core.List<api.Trace>();
  o.add(buildTrace());
  o.add(buildTrace());
  return o;
}

checkUnnamed2961(core.List<api.Trace> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTrace(o[0]);
  checkTrace(o[1]);
}

core.int buildCounterListTracesResponse = 0;
buildListTracesResponse() {
  var o = new api.ListTracesResponse();
  buildCounterListTracesResponse++;
  if (buildCounterListTracesResponse < 3) {
    o.nextPageToken = "foo";
    o.traces = buildUnnamed2961();
  }
  buildCounterListTracesResponse--;
  return o;
}

checkListTracesResponse(api.ListTracesResponse o) {
  buildCounterListTracesResponse++;
  if (buildCounterListTracesResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed2961(o.traces);
  }
  buildCounterListTracesResponse--;
}

core.int buildCounterModule = 0;
buildModule() {
  var o = new api.Module();
  buildCounterModule++;
  if (buildCounterModule < 3) {
    o.buildId = "foo";
    o.module = "foo";
  }
  buildCounterModule--;
  return o;
}

checkModule(api.Module o) {
  buildCounterModule++;
  if (buildCounterModule < 3) {
    unittest.expect(o.buildId, unittest.equals('foo'));
    unittest.expect(o.module, unittest.equals('foo'));
  }
  buildCounterModule--;
}

core.int buildCounterNetworkEvent = 0;
buildNetworkEvent() {
  var o = new api.NetworkEvent();
  buildCounterNetworkEvent++;
  if (buildCounterNetworkEvent < 3) {
    o.kernelTime = "foo";
    o.messageId = "foo";
    o.messageSize = "foo";
    o.type = "foo";
  }
  buildCounterNetworkEvent--;
  return o;
}

checkNetworkEvent(api.NetworkEvent o) {
  buildCounterNetworkEvent++;
  if (buildCounterNetworkEvent < 3) {
    unittest.expect(o.kernelTime, unittest.equals('foo'));
    unittest.expect(o.messageId, unittest.equals('foo'));
    unittest.expect(o.messageSize, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterNetworkEvent--;
}

buildUnnamed2962() {
  var o = new core.Map<core.String, api.AttributeValue>();
  o["x"] = buildAttributeValue();
  o["y"] = buildAttributeValue();
  return o;
}

checkUnnamed2962(core.Map<core.String, api.AttributeValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAttributeValue(o["x"]);
  checkAttributeValue(o["y"]);
}

buildUnnamed2963() {
  var o = new core.List<api.Link>();
  o.add(buildLink());
  o.add(buildLink());
  return o;
}

checkUnnamed2963(core.List<api.Link> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLink(o[0]);
  checkLink(o[1]);
}

buildUnnamed2964() {
  var o = new core.List<api.TimeEvent>();
  o.add(buildTimeEvent());
  o.add(buildTimeEvent());
  return o;
}

checkUnnamed2964(core.List<api.TimeEvent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTimeEvent(o[0]);
  checkTimeEvent(o[1]);
}

core.int buildCounterSpan = 0;
buildSpan() {
  var o = new api.Span();
  buildCounterSpan++;
  if (buildCounterSpan < 3) {
    o.attributes = buildUnnamed2962();
    o.hasRemoteParent = true;
    o.id = "foo";
    o.links = buildUnnamed2963();
    o.localEndTime = "foo";
    o.localStartTime = "foo";
    o.name = "foo";
    o.parentId = "foo";
    o.stackTrace = buildStackTrace();
    o.status = buildStatus();
    o.timeEvents = buildUnnamed2964();
  }
  buildCounterSpan--;
  return o;
}

checkSpan(api.Span o) {
  buildCounterSpan++;
  if (buildCounterSpan < 3) {
    checkUnnamed2962(o.attributes);
    unittest.expect(o.hasRemoteParent, unittest.isTrue);
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed2963(o.links);
    unittest.expect(o.localEndTime, unittest.equals('foo'));
    unittest.expect(o.localStartTime, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.parentId, unittest.equals('foo'));
    checkStackTrace(o.stackTrace);
    checkStatus(o.status);
    checkUnnamed2964(o.timeEvents);
  }
  buildCounterSpan--;
}

buildUnnamed2965() {
  var o = new core.List<api.Span>();
  o.add(buildSpan());
  o.add(buildSpan());
  return o;
}

checkUnnamed2965(core.List<api.Span> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSpan(o[0]);
  checkSpan(o[1]);
}

core.int buildCounterSpanUpdates = 0;
buildSpanUpdates() {
  var o = new api.SpanUpdates();
  buildCounterSpanUpdates++;
  if (buildCounterSpanUpdates < 3) {
    o.spans = buildUnnamed2965();
  }
  buildCounterSpanUpdates--;
  return o;
}

checkSpanUpdates(api.SpanUpdates o) {
  buildCounterSpanUpdates++;
  if (buildCounterSpanUpdates < 3) {
    checkUnnamed2965(o.spans);
  }
  buildCounterSpanUpdates--;
}

core.int buildCounterStackFrame = 0;
buildStackFrame() {
  var o = new api.StackFrame();
  buildCounterStackFrame++;
  if (buildCounterStackFrame < 3) {
    o.columnNumber = "foo";
    o.fileName = "foo";
    o.functionName = "foo";
    o.lineNumber = "foo";
    o.loadModule = buildModule();
    o.originalFunctionName = "foo";
    o.sourceVersion = "foo";
  }
  buildCounterStackFrame--;
  return o;
}

checkStackFrame(api.StackFrame o) {
  buildCounterStackFrame++;
  if (buildCounterStackFrame < 3) {
    unittest.expect(o.columnNumber, unittest.equals('foo'));
    unittest.expect(o.fileName, unittest.equals('foo'));
    unittest.expect(o.functionName, unittest.equals('foo'));
    unittest.expect(o.lineNumber, unittest.equals('foo'));
    checkModule(o.loadModule);
    unittest.expect(o.originalFunctionName, unittest.equals('foo'));
    unittest.expect(o.sourceVersion, unittest.equals('foo'));
  }
  buildCounterStackFrame--;
}

buildUnnamed2966() {
  var o = new core.List<api.StackFrame>();
  o.add(buildStackFrame());
  o.add(buildStackFrame());
  return o;
}

checkUnnamed2966(core.List<api.StackFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkStackFrame(o[0]);
  checkStackFrame(o[1]);
}

core.int buildCounterStackTrace = 0;
buildStackTrace() {
  var o = new api.StackTrace();
  buildCounterStackTrace++;
  if (buildCounterStackTrace < 3) {
    o.stackFrame = buildUnnamed2966();
    o.stackTraceHashId = "foo";
  }
  buildCounterStackTrace--;
  return o;
}

checkStackTrace(api.StackTrace o) {
  buildCounterStackTrace++;
  if (buildCounterStackTrace < 3) {
    checkUnnamed2966(o.stackFrame);
    unittest.expect(o.stackTraceHashId, unittest.equals('foo'));
  }
  buildCounterStackTrace--;
}

buildUnnamed2967() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  o["y"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  return o;
}

checkUnnamed2967(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o["x"]) as core.Map; unittest.expect(casted1, unittest.hasLength(3)); unittest.expect(casted1["list"], unittest.equals([1, 2, 3])); unittest.expect(casted1["bool"], unittest.equals(true)); unittest.expect(casted1["string"], unittest.equals('foo')); 
  var casted2 = (o["y"]) as core.Map; unittest.expect(casted2, unittest.hasLength(3)); unittest.expect(casted2["list"], unittest.equals([1, 2, 3])); unittest.expect(casted2["bool"], unittest.equals(true)); unittest.expect(casted2["string"], unittest.equals('foo')); 
}

buildUnnamed2968() {
  var o = new core.List<core.Map<core.String, core.Object>>();
  o.add(buildUnnamed2967());
  o.add(buildUnnamed2967());
  return o;
}

checkUnnamed2968(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed2967(o[0]);
  checkUnnamed2967(o[1]);
}

core.int buildCounterStatus = 0;
buildStatus() {
  var o = new api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed2968();
    o.message = "foo";
  }
  buildCounterStatus--;
  return o;
}

checkStatus(api.Status o) {
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    unittest.expect(o.code, unittest.equals(42));
    checkUnnamed2968(o.details);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterStatus--;
}

core.int buildCounterTimeEvent = 0;
buildTimeEvent() {
  var o = new api.TimeEvent();
  buildCounterTimeEvent++;
  if (buildCounterTimeEvent < 3) {
    o.annotation = buildAnnotation();
    o.localTime = "foo";
    o.networkEvent = buildNetworkEvent();
  }
  buildCounterTimeEvent--;
  return o;
}

checkTimeEvent(api.TimeEvent o) {
  buildCounterTimeEvent++;
  if (buildCounterTimeEvent < 3) {
    checkAnnotation(o.annotation);
    unittest.expect(o.localTime, unittest.equals('foo'));
    checkNetworkEvent(o.networkEvent);
  }
  buildCounterTimeEvent--;
}

core.int buildCounterTrace = 0;
buildTrace() {
  var o = new api.Trace();
  buildCounterTrace++;
  if (buildCounterTrace < 3) {
    o.name = "foo";
  }
  buildCounterTrace--;
  return o;
}

checkTrace(api.Trace o) {
  buildCounterTrace++;
  if (buildCounterTrace < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterTrace--;
}


main() {
  unittest.group("obj-schema-Annotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotation();
      var od = new api.Annotation.fromJson(o.toJson());
      checkAnnotation(od);
    });
  });


  unittest.group("obj-schema-AttributeValue", () {
    unittest.test("to-json--from-json", () {
      var o = buildAttributeValue();
      var od = new api.AttributeValue.fromJson(o.toJson());
      checkAttributeValue(od);
    });
  });


  unittest.group("obj-schema-BatchUpdateSpansRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchUpdateSpansRequest();
      var od = new api.BatchUpdateSpansRequest.fromJson(o.toJson());
      checkBatchUpdateSpansRequest(od);
    });
  });


  unittest.group("obj-schema-Empty", () {
    unittest.test("to-json--from-json", () {
      var o = buildEmpty();
      var od = new api.Empty.fromJson(o.toJson());
      checkEmpty(od);
    });
  });


  unittest.group("obj-schema-Link", () {
    unittest.test("to-json--from-json", () {
      var o = buildLink();
      var od = new api.Link.fromJson(o.toJson());
      checkLink(od);
    });
  });


  unittest.group("obj-schema-ListSpansResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListSpansResponse();
      var od = new api.ListSpansResponse.fromJson(o.toJson());
      checkListSpansResponse(od);
    });
  });


  unittest.group("obj-schema-ListTracesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListTracesResponse();
      var od = new api.ListTracesResponse.fromJson(o.toJson());
      checkListTracesResponse(od);
    });
  });


  unittest.group("obj-schema-Module", () {
    unittest.test("to-json--from-json", () {
      var o = buildModule();
      var od = new api.Module.fromJson(o.toJson());
      checkModule(od);
    });
  });


  unittest.group("obj-schema-NetworkEvent", () {
    unittest.test("to-json--from-json", () {
      var o = buildNetworkEvent();
      var od = new api.NetworkEvent.fromJson(o.toJson());
      checkNetworkEvent(od);
    });
  });


  unittest.group("obj-schema-Span", () {
    unittest.test("to-json--from-json", () {
      var o = buildSpan();
      var od = new api.Span.fromJson(o.toJson());
      checkSpan(od);
    });
  });


  unittest.group("obj-schema-SpanUpdates", () {
    unittest.test("to-json--from-json", () {
      var o = buildSpanUpdates();
      var od = new api.SpanUpdates.fromJson(o.toJson());
      checkSpanUpdates(od);
    });
  });


  unittest.group("obj-schema-StackFrame", () {
    unittest.test("to-json--from-json", () {
      var o = buildStackFrame();
      var od = new api.StackFrame.fromJson(o.toJson());
      checkStackFrame(od);
    });
  });


  unittest.group("obj-schema-StackTrace", () {
    unittest.test("to-json--from-json", () {
      var o = buildStackTrace();
      var od = new api.StackTrace.fromJson(o.toJson());
      checkStackTrace(od);
    });
  });


  unittest.group("obj-schema-Status", () {
    unittest.test("to-json--from-json", () {
      var o = buildStatus();
      var od = new api.Status.fromJson(o.toJson());
      checkStatus(od);
    });
  });


  unittest.group("obj-schema-TimeEvent", () {
    unittest.test("to-json--from-json", () {
      var o = buildTimeEvent();
      var od = new api.TimeEvent.fromJson(o.toJson());
      checkTimeEvent(od);
    });
  });


  unittest.group("obj-schema-Trace", () {
    unittest.test("to-json--from-json", () {
      var o = buildTrace();
      var od = new api.Trace.fromJson(o.toJson());
      checkTrace(od);
    });
  });


  unittest.group("resource-ProjectsTracesResourceApi", () {
    unittest.test("method--batchUpdate", () {

      var mock = new HttpServerMock();
      api.ProjectsTracesResourceApi res = new api.TracingApi(mock).projects.traces;
      var arg_request = buildBatchUpdateSpansRequest();
      var arg_parent = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.BatchUpdateSpansRequest.fromJson(json);
        checkBatchUpdateSpansRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.batchUpdate(arg_request, arg_parent).then(unittest.expectAsync(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.ProjectsTracesResourceApi res = new api.TracingApi(mock).projects.traces;
      var arg_name = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTrace());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_name).then(unittest.expectAsync(((api.Trace response) {
        checkTrace(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.ProjectsTracesResourceApi res = new api.TracingApi(mock).projects.traces;
      var arg_parent = "foo";
      var arg_pageSize = 42;
      var arg_orderBy = "foo";
      var arg_filter = "foo";
      var arg_endTime = "foo";
      var arg_pageToken = "foo";
      var arg_startTime = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));
        unittest.expect(queryMap["orderBy"].first, unittest.equals(arg_orderBy));
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
        unittest.expect(queryMap["endTime"].first, unittest.equals(arg_endTime));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["startTime"].first, unittest.equals(arg_startTime));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListTracesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_parent, pageSize: arg_pageSize, orderBy: arg_orderBy, filter: arg_filter, endTime: arg_endTime, pageToken: arg_pageToken, startTime: arg_startTime).then(unittest.expectAsync(((api.ListTracesResponse response) {
        checkListTracesResponse(response);
      })));
    });

    unittest.test("method--listSpans", () {

      var mock = new HttpServerMock();
      api.ProjectsTracesResourceApi res = new api.TracingApi(mock).projects.traces;
      var arg_name = "foo";
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListSpansResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.listSpans(arg_name, pageToken: arg_pageToken).then(unittest.expectAsync(((api.ListSpansResponse response) {
        checkListSpansResponse(response);
      })));
    });

  });


}

