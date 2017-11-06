library googleapis.appstate.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/appstate/v1.dart' as api;

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

core.int buildCounterGetResponse = 0;
buildGetResponse() {
  var o = new api.GetResponse();
  buildCounterGetResponse++;
  if (buildCounterGetResponse < 3) {
    o.currentStateVersion = "foo";
    o.data = "foo";
    o.kind = "foo";
    o.stateKey = 42;
  }
  buildCounterGetResponse--;
  return o;
}

checkGetResponse(api.GetResponse o) {
  buildCounterGetResponse++;
  if (buildCounterGetResponse < 3) {
    unittest.expect(o.currentStateVersion, unittest.equals('foo'));
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.stateKey, unittest.equals(42));
  }
  buildCounterGetResponse--;
}

buildUnnamed2696() {
  var o = new core.List<api.GetResponse>();
  o.add(buildGetResponse());
  o.add(buildGetResponse());
  return o;
}

checkUnnamed2696(core.List<api.GetResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGetResponse(o[0]);
  checkGetResponse(o[1]);
}

core.int buildCounterListResponse = 0;
buildListResponse() {
  var o = new api.ListResponse();
  buildCounterListResponse++;
  if (buildCounterListResponse < 3) {
    o.items = buildUnnamed2696();
    o.kind = "foo";
    o.maximumKeyCount = 42;
  }
  buildCounterListResponse--;
  return o;
}

checkListResponse(api.ListResponse o) {
  buildCounterListResponse++;
  if (buildCounterListResponse < 3) {
    checkUnnamed2696(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.maximumKeyCount, unittest.equals(42));
  }
  buildCounterListResponse--;
}

core.int buildCounterUpdateRequest = 0;
buildUpdateRequest() {
  var o = new api.UpdateRequest();
  buildCounterUpdateRequest++;
  if (buildCounterUpdateRequest < 3) {
    o.data = "foo";
    o.kind = "foo";
  }
  buildCounterUpdateRequest--;
  return o;
}

checkUpdateRequest(api.UpdateRequest o) {
  buildCounterUpdateRequest++;
  if (buildCounterUpdateRequest < 3) {
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterUpdateRequest--;
}

core.int buildCounterWriteResult = 0;
buildWriteResult() {
  var o = new api.WriteResult();
  buildCounterWriteResult++;
  if (buildCounterWriteResult < 3) {
    o.currentStateVersion = "foo";
    o.kind = "foo";
    o.stateKey = 42;
  }
  buildCounterWriteResult--;
  return o;
}

checkWriteResult(api.WriteResult o) {
  buildCounterWriteResult++;
  if (buildCounterWriteResult < 3) {
    unittest.expect(o.currentStateVersion, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.stateKey, unittest.equals(42));
  }
  buildCounterWriteResult--;
}


main() {
  unittest.group("obj-schema-GetResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildGetResponse();
      var od = new api.GetResponse.fromJson(o.toJson());
      checkGetResponse(od);
    });
  });


  unittest.group("obj-schema-ListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListResponse();
      var od = new api.ListResponse.fromJson(o.toJson());
      checkListResponse(od);
    });
  });


  unittest.group("obj-schema-UpdateRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateRequest();
      var od = new api.UpdateRequest.fromJson(o.toJson());
      checkUpdateRequest(od);
    });
  });


  unittest.group("obj-schema-WriteResult", () {
    unittest.test("to-json--from-json", () {
      var o = buildWriteResult();
      var od = new api.WriteResult.fromJson(o.toJson());
      checkWriteResult(od);
    });
  });


  unittest.group("resource-StatesResourceApi", () {
    unittest.test("method--clear", () {

      var mock = new HttpServerMock();
      api.StatesResourceApi res = new api.AppstateApi(mock).states;
      var arg_stateKey = 42;
      var arg_currentDataVersion = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("appstate/v1/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("states/"));
        pathOffset += 7;
        index = path.indexOf("/clear", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_stateKey"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/clear"));
        pathOffset += 6;

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
        unittest.expect(queryMap["currentDataVersion"].first, unittest.equals(arg_currentDataVersion));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildWriteResult());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.clear(arg_stateKey, currentDataVersion: arg_currentDataVersion).then(unittest.expectAsync(((api.WriteResult response) {
        checkWriteResult(response);
      })));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.StatesResourceApi res = new api.AppstateApi(mock).states;
      var arg_stateKey = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("appstate/v1/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("states/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_stateKey"));

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
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_stateKey).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.StatesResourceApi res = new api.AppstateApi(mock).states;
      var arg_stateKey = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("appstate/v1/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("states/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_stateKey"));

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
        var resp = convert.JSON.encode(buildGetResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_stateKey).then(unittest.expectAsync(((api.GetResponse response) {
        checkGetResponse(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.StatesResourceApi res = new api.AppstateApi(mock).states;
      var arg_includeData = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("appstate/v1/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("states"));
        pathOffset += 6;

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
        unittest.expect(queryMap["includeData"].first, unittest.equals("$arg_includeData"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(includeData: arg_includeData).then(unittest.expectAsync(((api.ListResponse response) {
        checkListResponse(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.StatesResourceApi res = new api.AppstateApi(mock).states;
      var arg_request = buildUpdateRequest();
      var arg_stateKey = 42;
      var arg_currentStateVersion = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.UpdateRequest.fromJson(json);
        checkUpdateRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("appstate/v1/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("states/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_stateKey"));

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
        unittest.expect(queryMap["currentStateVersion"].first, unittest.equals(arg_currentStateVersion));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildWriteResult());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_stateKey, currentStateVersion: arg_currentStateVersion).then(unittest.expectAsync(((api.WriteResult response) {
        checkWriteResult(response);
      })));
    });

  });


}

