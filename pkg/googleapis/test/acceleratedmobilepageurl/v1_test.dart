library googleapis.acceleratedmobilepageurl.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/acceleratedmobilepageurl/v1.dart' as api;

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

core.int buildCounterAmpUrl = 0;
buildAmpUrl() {
  var o = new api.AmpUrl();
  buildCounterAmpUrl++;
  if (buildCounterAmpUrl < 3) {
    o.ampUrl = "foo";
    o.cdnAmpUrl = "foo";
    o.originalUrl = "foo";
  }
  buildCounterAmpUrl--;
  return o;
}

checkAmpUrl(api.AmpUrl o) {
  buildCounterAmpUrl++;
  if (buildCounterAmpUrl < 3) {
    unittest.expect(o.ampUrl, unittest.equals('foo'));
    unittest.expect(o.cdnAmpUrl, unittest.equals('foo'));
    unittest.expect(o.originalUrl, unittest.equals('foo'));
  }
  buildCounterAmpUrl--;
}

core.int buildCounterAmpUrlError = 0;
buildAmpUrlError() {
  var o = new api.AmpUrlError();
  buildCounterAmpUrlError++;
  if (buildCounterAmpUrlError < 3) {
    o.errorCode = "foo";
    o.errorMessage = "foo";
    o.originalUrl = "foo";
  }
  buildCounterAmpUrlError--;
  return o;
}

checkAmpUrlError(api.AmpUrlError o) {
  buildCounterAmpUrlError++;
  if (buildCounterAmpUrlError < 3) {
    unittest.expect(o.errorCode, unittest.equals('foo'));
    unittest.expect(o.errorMessage, unittest.equals('foo'));
    unittest.expect(o.originalUrl, unittest.equals('foo'));
  }
  buildCounterAmpUrlError--;
}

buildUnnamed1129() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1129(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterBatchGetAmpUrlsRequest = 0;
buildBatchGetAmpUrlsRequest() {
  var o = new api.BatchGetAmpUrlsRequest();
  buildCounterBatchGetAmpUrlsRequest++;
  if (buildCounterBatchGetAmpUrlsRequest < 3) {
    o.lookupStrategy = "foo";
    o.urls = buildUnnamed1129();
  }
  buildCounterBatchGetAmpUrlsRequest--;
  return o;
}

checkBatchGetAmpUrlsRequest(api.BatchGetAmpUrlsRequest o) {
  buildCounterBatchGetAmpUrlsRequest++;
  if (buildCounterBatchGetAmpUrlsRequest < 3) {
    unittest.expect(o.lookupStrategy, unittest.equals('foo'));
    checkUnnamed1129(o.urls);
  }
  buildCounterBatchGetAmpUrlsRequest--;
}

buildUnnamed1130() {
  var o = new core.List<api.AmpUrl>();
  o.add(buildAmpUrl());
  o.add(buildAmpUrl());
  return o;
}

checkUnnamed1130(core.List<api.AmpUrl> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAmpUrl(o[0]);
  checkAmpUrl(o[1]);
}

buildUnnamed1131() {
  var o = new core.List<api.AmpUrlError>();
  o.add(buildAmpUrlError());
  o.add(buildAmpUrlError());
  return o;
}

checkUnnamed1131(core.List<api.AmpUrlError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAmpUrlError(o[0]);
  checkAmpUrlError(o[1]);
}

core.int buildCounterBatchGetAmpUrlsResponse = 0;
buildBatchGetAmpUrlsResponse() {
  var o = new api.BatchGetAmpUrlsResponse();
  buildCounterBatchGetAmpUrlsResponse++;
  if (buildCounterBatchGetAmpUrlsResponse < 3) {
    o.ampUrls = buildUnnamed1130();
    o.urlErrors = buildUnnamed1131();
  }
  buildCounterBatchGetAmpUrlsResponse--;
  return o;
}

checkBatchGetAmpUrlsResponse(api.BatchGetAmpUrlsResponse o) {
  buildCounterBatchGetAmpUrlsResponse++;
  if (buildCounterBatchGetAmpUrlsResponse < 3) {
    checkUnnamed1130(o.ampUrls);
    checkUnnamed1131(o.urlErrors);
  }
  buildCounterBatchGetAmpUrlsResponse--;
}


main() {
  unittest.group("obj-schema-AmpUrl", () {
    unittest.test("to-json--from-json", () {
      var o = buildAmpUrl();
      var od = new api.AmpUrl.fromJson(o.toJson());
      checkAmpUrl(od);
    });
  });


  unittest.group("obj-schema-AmpUrlError", () {
    unittest.test("to-json--from-json", () {
      var o = buildAmpUrlError();
      var od = new api.AmpUrlError.fromJson(o.toJson());
      checkAmpUrlError(od);
    });
  });


  unittest.group("obj-schema-BatchGetAmpUrlsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchGetAmpUrlsRequest();
      var od = new api.BatchGetAmpUrlsRequest.fromJson(o.toJson());
      checkBatchGetAmpUrlsRequest(od);
    });
  });


  unittest.group("obj-schema-BatchGetAmpUrlsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchGetAmpUrlsResponse();
      var od = new api.BatchGetAmpUrlsResponse.fromJson(o.toJson());
      checkBatchGetAmpUrlsResponse(od);
    });
  });


  unittest.group("resource-AmpUrlsResourceApi", () {
    unittest.test("method--batchGet", () {

      var mock = new HttpServerMock();
      api.AmpUrlsResourceApi res = new api.AcceleratedmobilepageurlApi(mock).ampUrls;
      var arg_request = buildBatchGetAmpUrlsRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.BatchGetAmpUrlsRequest.fromJson(json);
        checkBatchGetAmpUrlsRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 19), unittest.equals("v1/ampUrls:batchGet"));
        pathOffset += 19;

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
        var resp = convert.JSON.encode(buildBatchGetAmpUrlsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.batchGet(arg_request).then(unittest.expectAsync(((api.BatchGetAmpUrlsResponse response) {
        checkBatchGetAmpUrlsResponse(response);
      })));
    });

  });


}

