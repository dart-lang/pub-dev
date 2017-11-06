library googleapis.cloudtrace.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/cloudtrace/v1.dart' as api;

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

buildUnnamed134() {
  var o = new core.List<api.Trace>();
  o.add(buildTrace());
  o.add(buildTrace());
  return o;
}

checkUnnamed134(core.List<api.Trace> o) {
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
    o.traces = buildUnnamed134();
  }
  buildCounterListTracesResponse--;
  return o;
}

checkListTracesResponse(api.ListTracesResponse o) {
  buildCounterListTracesResponse++;
  if (buildCounterListTracesResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed134(o.traces);
  }
  buildCounterListTracesResponse--;
}

buildUnnamed135() {
  var o = new core.List<api.TraceSpan>();
  o.add(buildTraceSpan());
  o.add(buildTraceSpan());
  return o;
}

checkUnnamed135(core.List<api.TraceSpan> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTraceSpan(o[0]);
  checkTraceSpan(o[1]);
}

core.int buildCounterTrace = 0;
buildTrace() {
  var o = new api.Trace();
  buildCounterTrace++;
  if (buildCounterTrace < 3) {
    o.projectId = "foo";
    o.spans = buildUnnamed135();
    o.traceId = "foo";
  }
  buildCounterTrace--;
  return o;
}

checkTrace(api.Trace o) {
  buildCounterTrace++;
  if (buildCounterTrace < 3) {
    unittest.expect(o.projectId, unittest.equals('foo'));
    checkUnnamed135(o.spans);
    unittest.expect(o.traceId, unittest.equals('foo'));
  }
  buildCounterTrace--;
}

buildUnnamed136() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed136(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterTraceSpan = 0;
buildTraceSpan() {
  var o = new api.TraceSpan();
  buildCounterTraceSpan++;
  if (buildCounterTraceSpan < 3) {
    o.endTime = "foo";
    o.kind = "foo";
    o.labels = buildUnnamed136();
    o.name = "foo";
    o.parentSpanId = "foo";
    o.spanId = "foo";
    o.startTime = "foo";
  }
  buildCounterTraceSpan--;
  return o;
}

checkTraceSpan(api.TraceSpan o) {
  buildCounterTraceSpan++;
  if (buildCounterTraceSpan < 3) {
    unittest.expect(o.endTime, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed136(o.labels);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.parentSpanId, unittest.equals('foo'));
    unittest.expect(o.spanId, unittest.equals('foo'));
    unittest.expect(o.startTime, unittest.equals('foo'));
  }
  buildCounterTraceSpan--;
}

buildUnnamed137() {
  var o = new core.List<api.Trace>();
  o.add(buildTrace());
  o.add(buildTrace());
  return o;
}

checkUnnamed137(core.List<api.Trace> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTrace(o[0]);
  checkTrace(o[1]);
}

core.int buildCounterTraces = 0;
buildTraces() {
  var o = new api.Traces();
  buildCounterTraces++;
  if (buildCounterTraces < 3) {
    o.traces = buildUnnamed137();
  }
  buildCounterTraces--;
  return o;
}

checkTraces(api.Traces o) {
  buildCounterTraces++;
  if (buildCounterTraces < 3) {
    checkUnnamed137(o.traces);
  }
  buildCounterTraces--;
}


main() {
  unittest.group("obj-schema-Empty", () {
    unittest.test("to-json--from-json", () {
      var o = buildEmpty();
      var od = new api.Empty.fromJson(o.toJson());
      checkEmpty(od);
    });
  });


  unittest.group("obj-schema-ListTracesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListTracesResponse();
      var od = new api.ListTracesResponse.fromJson(o.toJson());
      checkListTracesResponse(od);
    });
  });


  unittest.group("obj-schema-Trace", () {
    unittest.test("to-json--from-json", () {
      var o = buildTrace();
      var od = new api.Trace.fromJson(o.toJson());
      checkTrace(od);
    });
  });


  unittest.group("obj-schema-TraceSpan", () {
    unittest.test("to-json--from-json", () {
      var o = buildTraceSpan();
      var od = new api.TraceSpan.fromJson(o.toJson());
      checkTraceSpan(od);
    });
  });


  unittest.group("obj-schema-Traces", () {
    unittest.test("to-json--from-json", () {
      var o = buildTraces();
      var od = new api.Traces.fromJson(o.toJson());
      checkTraces(od);
    });
  });


  unittest.group("resource-ProjectsResourceApi", () {
    unittest.test("method--patchTraces", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudtraceApi(mock).projects;
      var arg_request = buildTraces();
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Traces.fromJson(json);
        checkTraces(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("v1/projects/"));
        pathOffset += 12;
        index = path.indexOf("/traces", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_projectId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/traces"));
        pathOffset += 7;

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
      res.patchTraces(arg_request, arg_projectId).then(unittest.expectAsync(((api.Empty response) {
        checkEmpty(response);
      })));
    });

  });


  unittest.group("resource-ProjectsTracesResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.ProjectsTracesResourceApi res = new api.CloudtraceApi(mock).projects.traces;
      var arg_projectId = "foo";
      var arg_traceId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("v1/projects/"));
        pathOffset += 12;
        index = path.indexOf("/traces/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_projectId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/traces/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_traceId"));

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
      res.get(arg_projectId, arg_traceId).then(unittest.expectAsync(((api.Trace response) {
        checkTrace(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.ProjectsTracesResourceApi res = new api.CloudtraceApi(mock).projects.traces;
      var arg_projectId = "foo";
      var arg_orderBy = "foo";
      var arg_filter = "foo";
      var arg_endTime = "foo";
      var arg_pageToken = "foo";
      var arg_startTime = "foo";
      var arg_pageSize = 42;
      var arg_view = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("v1/projects/"));
        pathOffset += 12;
        index = path.indexOf("/traces", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_projectId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/traces"));
        pathOffset += 7;

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
        unittest.expect(queryMap["orderBy"].first, unittest.equals(arg_orderBy));
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
        unittest.expect(queryMap["endTime"].first, unittest.equals(arg_endTime));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["startTime"].first, unittest.equals(arg_startTime));
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListTracesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_projectId, orderBy: arg_orderBy, filter: arg_filter, endTime: arg_endTime, pageToken: arg_pageToken, startTime: arg_startTime, pageSize: arg_pageSize, view: arg_view).then(unittest.expectAsync(((api.ListTracesResponse response) {
        checkListTracesResponse(response);
      })));
    });

  });


}

