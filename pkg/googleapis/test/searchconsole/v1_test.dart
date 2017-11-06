library googleapis.searchconsole.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/searchconsole/v1.dart' as api;

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

core.int buildCounterBlockedResource = 0;
buildBlockedResource() {
  var o = new api.BlockedResource();
  buildCounterBlockedResource++;
  if (buildCounterBlockedResource < 3) {
    o.url = "foo";
  }
  buildCounterBlockedResource--;
  return o;
}

checkBlockedResource(api.BlockedResource o) {
  buildCounterBlockedResource++;
  if (buildCounterBlockedResource < 3) {
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterBlockedResource--;
}

core.int buildCounterImage = 0;
buildImage() {
  var o = new api.Image();
  buildCounterImage++;
  if (buildCounterImage < 3) {
    o.data = "foo";
    o.mimeType = "foo";
  }
  buildCounterImage--;
  return o;
}

checkImage(api.Image o) {
  buildCounterImage++;
  if (buildCounterImage < 3) {
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.mimeType, unittest.equals('foo'));
  }
  buildCounterImage--;
}

core.int buildCounterMobileFriendlyIssue = 0;
buildMobileFriendlyIssue() {
  var o = new api.MobileFriendlyIssue();
  buildCounterMobileFriendlyIssue++;
  if (buildCounterMobileFriendlyIssue < 3) {
    o.rule = "foo";
  }
  buildCounterMobileFriendlyIssue--;
  return o;
}

checkMobileFriendlyIssue(api.MobileFriendlyIssue o) {
  buildCounterMobileFriendlyIssue++;
  if (buildCounterMobileFriendlyIssue < 3) {
    unittest.expect(o.rule, unittest.equals('foo'));
  }
  buildCounterMobileFriendlyIssue--;
}

core.int buildCounterResourceIssue = 0;
buildResourceIssue() {
  var o = new api.ResourceIssue();
  buildCounterResourceIssue++;
  if (buildCounterResourceIssue < 3) {
    o.blockedResource = buildBlockedResource();
  }
  buildCounterResourceIssue--;
  return o;
}

checkResourceIssue(api.ResourceIssue o) {
  buildCounterResourceIssue++;
  if (buildCounterResourceIssue < 3) {
    checkBlockedResource(o.blockedResource);
  }
  buildCounterResourceIssue--;
}

core.int buildCounterRunMobileFriendlyTestRequest = 0;
buildRunMobileFriendlyTestRequest() {
  var o = new api.RunMobileFriendlyTestRequest();
  buildCounterRunMobileFriendlyTestRequest++;
  if (buildCounterRunMobileFriendlyTestRequest < 3) {
    o.requestScreenshot = true;
    o.url = "foo";
  }
  buildCounterRunMobileFriendlyTestRequest--;
  return o;
}

checkRunMobileFriendlyTestRequest(api.RunMobileFriendlyTestRequest o) {
  buildCounterRunMobileFriendlyTestRequest++;
  if (buildCounterRunMobileFriendlyTestRequest < 3) {
    unittest.expect(o.requestScreenshot, unittest.isTrue);
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterRunMobileFriendlyTestRequest--;
}

buildUnnamed1107() {
  var o = new core.List<api.MobileFriendlyIssue>();
  o.add(buildMobileFriendlyIssue());
  o.add(buildMobileFriendlyIssue());
  return o;
}

checkUnnamed1107(core.List<api.MobileFriendlyIssue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMobileFriendlyIssue(o[0]);
  checkMobileFriendlyIssue(o[1]);
}

buildUnnamed1108() {
  var o = new core.List<api.ResourceIssue>();
  o.add(buildResourceIssue());
  o.add(buildResourceIssue());
  return o;
}

checkUnnamed1108(core.List<api.ResourceIssue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResourceIssue(o[0]);
  checkResourceIssue(o[1]);
}

core.int buildCounterRunMobileFriendlyTestResponse = 0;
buildRunMobileFriendlyTestResponse() {
  var o = new api.RunMobileFriendlyTestResponse();
  buildCounterRunMobileFriendlyTestResponse++;
  if (buildCounterRunMobileFriendlyTestResponse < 3) {
    o.mobileFriendliness = "foo";
    o.mobileFriendlyIssues = buildUnnamed1107();
    o.resourceIssues = buildUnnamed1108();
    o.screenshot = buildImage();
    o.testStatus = buildTestStatus();
  }
  buildCounterRunMobileFriendlyTestResponse--;
  return o;
}

checkRunMobileFriendlyTestResponse(api.RunMobileFriendlyTestResponse o) {
  buildCounterRunMobileFriendlyTestResponse++;
  if (buildCounterRunMobileFriendlyTestResponse < 3) {
    unittest.expect(o.mobileFriendliness, unittest.equals('foo'));
    checkUnnamed1107(o.mobileFriendlyIssues);
    checkUnnamed1108(o.resourceIssues);
    checkImage(o.screenshot);
    checkTestStatus(o.testStatus);
  }
  buildCounterRunMobileFriendlyTestResponse--;
}

core.int buildCounterTestStatus = 0;
buildTestStatus() {
  var o = new api.TestStatus();
  buildCounterTestStatus++;
  if (buildCounterTestStatus < 3) {
    o.details = "foo";
    o.status = "foo";
  }
  buildCounterTestStatus--;
  return o;
}

checkTestStatus(api.TestStatus o) {
  buildCounterTestStatus++;
  if (buildCounterTestStatus < 3) {
    unittest.expect(o.details, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterTestStatus--;
}


main() {
  unittest.group("obj-schema-BlockedResource", () {
    unittest.test("to-json--from-json", () {
      var o = buildBlockedResource();
      var od = new api.BlockedResource.fromJson(o.toJson());
      checkBlockedResource(od);
    });
  });


  unittest.group("obj-schema-Image", () {
    unittest.test("to-json--from-json", () {
      var o = buildImage();
      var od = new api.Image.fromJson(o.toJson());
      checkImage(od);
    });
  });


  unittest.group("obj-schema-MobileFriendlyIssue", () {
    unittest.test("to-json--from-json", () {
      var o = buildMobileFriendlyIssue();
      var od = new api.MobileFriendlyIssue.fromJson(o.toJson());
      checkMobileFriendlyIssue(od);
    });
  });


  unittest.group("obj-schema-ResourceIssue", () {
    unittest.test("to-json--from-json", () {
      var o = buildResourceIssue();
      var od = new api.ResourceIssue.fromJson(o.toJson());
      checkResourceIssue(od);
    });
  });


  unittest.group("obj-schema-RunMobileFriendlyTestRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildRunMobileFriendlyTestRequest();
      var od = new api.RunMobileFriendlyTestRequest.fromJson(o.toJson());
      checkRunMobileFriendlyTestRequest(od);
    });
  });


  unittest.group("obj-schema-RunMobileFriendlyTestResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildRunMobileFriendlyTestResponse();
      var od = new api.RunMobileFriendlyTestResponse.fromJson(o.toJson());
      checkRunMobileFriendlyTestResponse(od);
    });
  });


  unittest.group("obj-schema-TestStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildTestStatus();
      var od = new api.TestStatus.fromJson(o.toJson());
      checkTestStatus(od);
    });
  });


  unittest.group("resource-UrlTestingToolsMobileFriendlyTestResourceApi", () {
    unittest.test("method--run", () {

      var mock = new HttpServerMock();
      api.UrlTestingToolsMobileFriendlyTestResourceApi res = new api.SearchconsoleApi(mock).urlTestingTools.mobileFriendlyTest;
      var arg_request = buildRunMobileFriendlyTestRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.RunMobileFriendlyTestRequest.fromJson(json);
        checkRunMobileFriendlyTestRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 41), unittest.equals("v1/urlTestingTools/mobileFriendlyTest:run"));
        pathOffset += 41;

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
        var resp = convert.JSON.encode(buildRunMobileFriendlyTestResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.run(arg_request).then(unittest.expectAsync(((api.RunMobileFriendlyTestResponse response) {
        checkRunMobileFriendlyTestResponse(response);
      })));
    });

  });


}

