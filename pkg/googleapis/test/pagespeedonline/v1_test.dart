library googleapis.pagespeedonline.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/pagespeedonline/v1.dart' as api;

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

core.int buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs = 0;
buildResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs() {
  var o = new api.ResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs();
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs < 3) {
    o.type = "foo";
    o.value = "foo";
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs--;
  return o;
}

checkResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs(api.ResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs o) {
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs < 3) {
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs--;
}

buildUnnamed2698() {
  var o = new core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs>();
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs());
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs());
  return o;
}

checkUnnamed2698(core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs(o[0]);
  checkResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs(o[1]);
}

core.int buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeader = 0;
buildResultFormattedResultsRuleResultsValueUrlBlocksHeader() {
  var o = new api.ResultFormattedResultsRuleResultsValueUrlBlocksHeader();
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeader++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeader < 3) {
    o.args = buildUnnamed2698();
    o.format = "foo";
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeader--;
  return o;
}

checkResultFormattedResultsRuleResultsValueUrlBlocksHeader(api.ResultFormattedResultsRuleResultsValueUrlBlocksHeader o) {
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeader++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeader < 3) {
    checkUnnamed2698(o.args);
    unittest.expect(o.format, unittest.equals('foo'));
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksHeader--;
}

core.int buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs = 0;
buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs() {
  var o = new api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs();
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs < 3) {
    o.type = "foo";
    o.value = "foo";
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs--;
  return o;
}

checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs(api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs o) {
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs < 3) {
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs--;
}

buildUnnamed2699() {
  var o = new core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs>();
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs());
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs());
  return o;
}

checkUnnamed2699(core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs(o[0]);
  checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs(o[1]);
}

core.int buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails = 0;
buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails() {
  var o = new api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails();
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails < 3) {
    o.args = buildUnnamed2699();
    o.format = "foo";
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails--;
  return o;
}

checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails(api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails o) {
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails < 3) {
    checkUnnamed2699(o.args);
    unittest.expect(o.format, unittest.equals('foo'));
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails--;
}

buildUnnamed2700() {
  var o = new core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails>();
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails());
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails());
  return o;
}

checkUnnamed2700(core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails(o[0]);
  checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails(o[1]);
}

core.int buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs = 0;
buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs() {
  var o = new api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs();
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs < 3) {
    o.type = "foo";
    o.value = "foo";
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs--;
  return o;
}

checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs(api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs o) {
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs < 3) {
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs--;
}

buildUnnamed2701() {
  var o = new core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs>();
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs());
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs());
  return o;
}

checkUnnamed2701(core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs(o[0]);
  checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs(o[1]);
}

core.int buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult = 0;
buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult() {
  var o = new api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult();
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult < 3) {
    o.args = buildUnnamed2701();
    o.format = "foo";
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult--;
  return o;
}

checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult(api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult o) {
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult < 3) {
    checkUnnamed2701(o.args);
    unittest.expect(o.format, unittest.equals('foo'));
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult--;
}

core.int buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls = 0;
buildResultFormattedResultsRuleResultsValueUrlBlocksUrls() {
  var o = new api.ResultFormattedResultsRuleResultsValueUrlBlocksUrls();
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls < 3) {
    o.details = buildUnnamed2700();
    o.result = buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult();
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls--;
  return o;
}

checkResultFormattedResultsRuleResultsValueUrlBlocksUrls(api.ResultFormattedResultsRuleResultsValueUrlBlocksUrls o) {
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls < 3) {
    checkUnnamed2700(o.details);
    checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult(o.result);
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls--;
}

buildUnnamed2702() {
  var o = new core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocksUrls>();
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocksUrls());
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocksUrls());
  return o;
}

checkUnnamed2702(core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocksUrls> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResultFormattedResultsRuleResultsValueUrlBlocksUrls(o[0]);
  checkResultFormattedResultsRuleResultsValueUrlBlocksUrls(o[1]);
}

core.int buildCounterResultFormattedResultsRuleResultsValueUrlBlocks = 0;
buildResultFormattedResultsRuleResultsValueUrlBlocks() {
  var o = new api.ResultFormattedResultsRuleResultsValueUrlBlocks();
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocks++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocks < 3) {
    o.header = buildResultFormattedResultsRuleResultsValueUrlBlocksHeader();
    o.urls = buildUnnamed2702();
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocks--;
  return o;
}

checkResultFormattedResultsRuleResultsValueUrlBlocks(api.ResultFormattedResultsRuleResultsValueUrlBlocks o) {
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocks++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocks < 3) {
    checkResultFormattedResultsRuleResultsValueUrlBlocksHeader(o.header);
    checkUnnamed2702(o.urls);
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocks--;
}

buildUnnamed2703() {
  var o = new core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocks>();
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocks());
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocks());
  return o;
}

checkUnnamed2703(core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocks> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResultFormattedResultsRuleResultsValueUrlBlocks(o[0]);
  checkResultFormattedResultsRuleResultsValueUrlBlocks(o[1]);
}

core.int buildCounterResultFormattedResultsRuleResultsValue = 0;
buildResultFormattedResultsRuleResultsValue() {
  var o = new api.ResultFormattedResultsRuleResultsValue();
  buildCounterResultFormattedResultsRuleResultsValue++;
  if (buildCounterResultFormattedResultsRuleResultsValue < 3) {
    o.localizedRuleName = "foo";
    o.ruleImpact = 42.0;
    o.urlBlocks = buildUnnamed2703();
  }
  buildCounterResultFormattedResultsRuleResultsValue--;
  return o;
}

checkResultFormattedResultsRuleResultsValue(api.ResultFormattedResultsRuleResultsValue o) {
  buildCounterResultFormattedResultsRuleResultsValue++;
  if (buildCounterResultFormattedResultsRuleResultsValue < 3) {
    unittest.expect(o.localizedRuleName, unittest.equals('foo'));
    unittest.expect(o.ruleImpact, unittest.equals(42.0));
    checkUnnamed2703(o.urlBlocks);
  }
  buildCounterResultFormattedResultsRuleResultsValue--;
}

buildUnnamed2704() {
  var o = new core.Map<core.String, api.ResultFormattedResultsRuleResultsValue>();
  o["x"] = buildResultFormattedResultsRuleResultsValue();
  o["y"] = buildResultFormattedResultsRuleResultsValue();
  return o;
}

checkUnnamed2704(core.Map<core.String, api.ResultFormattedResultsRuleResultsValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResultFormattedResultsRuleResultsValue(o["x"]);
  checkResultFormattedResultsRuleResultsValue(o["y"]);
}

core.int buildCounterResultFormattedResults = 0;
buildResultFormattedResults() {
  var o = new api.ResultFormattedResults();
  buildCounterResultFormattedResults++;
  if (buildCounterResultFormattedResults < 3) {
    o.locale = "foo";
    o.ruleResults = buildUnnamed2704();
  }
  buildCounterResultFormattedResults--;
  return o;
}

checkResultFormattedResults(api.ResultFormattedResults o) {
  buildCounterResultFormattedResults++;
  if (buildCounterResultFormattedResults < 3) {
    unittest.expect(o.locale, unittest.equals('foo'));
    checkUnnamed2704(o.ruleResults);
  }
  buildCounterResultFormattedResults--;
}

buildUnnamed2705() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2705(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterResultPageStats = 0;
buildResultPageStats() {
  var o = new api.ResultPageStats();
  buildCounterResultPageStats++;
  if (buildCounterResultPageStats < 3) {
    o.cssResponseBytes = "foo";
    o.flashResponseBytes = "foo";
    o.htmlResponseBytes = "foo";
    o.imageResponseBytes = "foo";
    o.javascriptResponseBytes = "foo";
    o.numberCssResources = 42;
    o.numberHosts = 42;
    o.numberJsResources = 42;
    o.numberResources = 42;
    o.numberStaticResources = 42;
    o.otherResponseBytes = "foo";
    o.textResponseBytes = "foo";
    o.totalRequestBytes = "foo";
  }
  buildCounterResultPageStats--;
  return o;
}

checkResultPageStats(api.ResultPageStats o) {
  buildCounterResultPageStats++;
  if (buildCounterResultPageStats < 3) {
    unittest.expect(o.cssResponseBytes, unittest.equals('foo'));
    unittest.expect(o.flashResponseBytes, unittest.equals('foo'));
    unittest.expect(o.htmlResponseBytes, unittest.equals('foo'));
    unittest.expect(o.imageResponseBytes, unittest.equals('foo'));
    unittest.expect(o.javascriptResponseBytes, unittest.equals('foo'));
    unittest.expect(o.numberCssResources, unittest.equals(42));
    unittest.expect(o.numberHosts, unittest.equals(42));
    unittest.expect(o.numberJsResources, unittest.equals(42));
    unittest.expect(o.numberResources, unittest.equals(42));
    unittest.expect(o.numberStaticResources, unittest.equals(42));
    unittest.expect(o.otherResponseBytes, unittest.equals('foo'));
    unittest.expect(o.textResponseBytes, unittest.equals('foo'));
    unittest.expect(o.totalRequestBytes, unittest.equals('foo'));
  }
  buildCounterResultPageStats--;
}

core.int buildCounterResultScreenshot = 0;
buildResultScreenshot() {
  var o = new api.ResultScreenshot();
  buildCounterResultScreenshot++;
  if (buildCounterResultScreenshot < 3) {
    o.data = "foo";
    o.height = 42;
    o.mimeType = "foo";
    o.width = 42;
  }
  buildCounterResultScreenshot--;
  return o;
}

checkResultScreenshot(api.ResultScreenshot o) {
  buildCounterResultScreenshot++;
  if (buildCounterResultScreenshot < 3) {
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.mimeType, unittest.equals('foo'));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterResultScreenshot--;
}

core.int buildCounterResultVersion = 0;
buildResultVersion() {
  var o = new api.ResultVersion();
  buildCounterResultVersion++;
  if (buildCounterResultVersion < 3) {
    o.major = 42;
    o.minor = 42;
  }
  buildCounterResultVersion--;
  return o;
}

checkResultVersion(api.ResultVersion o) {
  buildCounterResultVersion++;
  if (buildCounterResultVersion < 3) {
    unittest.expect(o.major, unittest.equals(42));
    unittest.expect(o.minor, unittest.equals(42));
  }
  buildCounterResultVersion--;
}

core.int buildCounterResult = 0;
buildResult() {
  var o = new api.Result();
  buildCounterResult++;
  if (buildCounterResult < 3) {
    o.formattedResults = buildResultFormattedResults();
    o.id = "foo";
    o.invalidRules = buildUnnamed2705();
    o.kind = "foo";
    o.pageStats = buildResultPageStats();
    o.responseCode = 42;
    o.score = 42;
    o.screenshot = buildResultScreenshot();
    o.title = "foo";
    o.version = buildResultVersion();
  }
  buildCounterResult--;
  return o;
}

checkResult(api.Result o) {
  buildCounterResult++;
  if (buildCounterResult < 3) {
    checkResultFormattedResults(o.formattedResults);
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed2705(o.invalidRules);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkResultPageStats(o.pageStats);
    unittest.expect(o.responseCode, unittest.equals(42));
    unittest.expect(o.score, unittest.equals(42));
    checkResultScreenshot(o.screenshot);
    unittest.expect(o.title, unittest.equals('foo'));
    checkResultVersion(o.version);
  }
  buildCounterResult--;
}

buildUnnamed2706() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2706(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}


main() {
  unittest.group("obj-schema-ResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs();
      var od = new api.ResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs.fromJson(o.toJson());
      checkResultFormattedResultsRuleResultsValueUrlBlocksHeaderArgs(od);
    });
  });


  unittest.group("obj-schema-ResultFormattedResultsRuleResultsValueUrlBlocksHeader", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultFormattedResultsRuleResultsValueUrlBlocksHeader();
      var od = new api.ResultFormattedResultsRuleResultsValueUrlBlocksHeader.fromJson(o.toJson());
      checkResultFormattedResultsRuleResultsValueUrlBlocksHeader(od);
    });
  });


  unittest.group("obj-schema-ResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs();
      var od = new api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs.fromJson(o.toJson());
      checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetailsArgs(od);
    });
  });


  unittest.group("obj-schema-ResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails();
      var od = new api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails.fromJson(o.toJson());
      checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsDetails(od);
    });
  });


  unittest.group("obj-schema-ResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs();
      var od = new api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs.fromJson(o.toJson());
      checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsResultArgs(od);
    });
  });


  unittest.group("obj-schema-ResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult();
      var od = new api.ResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult.fromJson(o.toJson());
      checkResultFormattedResultsRuleResultsValueUrlBlocksUrlsResult(od);
    });
  });


  unittest.group("obj-schema-ResultFormattedResultsRuleResultsValueUrlBlocksUrls", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultFormattedResultsRuleResultsValueUrlBlocksUrls();
      var od = new api.ResultFormattedResultsRuleResultsValueUrlBlocksUrls.fromJson(o.toJson());
      checkResultFormattedResultsRuleResultsValueUrlBlocksUrls(od);
    });
  });


  unittest.group("obj-schema-ResultFormattedResultsRuleResultsValueUrlBlocks", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultFormattedResultsRuleResultsValueUrlBlocks();
      var od = new api.ResultFormattedResultsRuleResultsValueUrlBlocks.fromJson(o.toJson());
      checkResultFormattedResultsRuleResultsValueUrlBlocks(od);
    });
  });


  unittest.group("obj-schema-ResultFormattedResultsRuleResultsValue", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultFormattedResultsRuleResultsValue();
      var od = new api.ResultFormattedResultsRuleResultsValue.fromJson(o.toJson());
      checkResultFormattedResultsRuleResultsValue(od);
    });
  });


  unittest.group("obj-schema-ResultFormattedResults", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultFormattedResults();
      var od = new api.ResultFormattedResults.fromJson(o.toJson());
      checkResultFormattedResults(od);
    });
  });


  unittest.group("obj-schema-ResultPageStats", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultPageStats();
      var od = new api.ResultPageStats.fromJson(o.toJson());
      checkResultPageStats(od);
    });
  });


  unittest.group("obj-schema-ResultScreenshot", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultScreenshot();
      var od = new api.ResultScreenshot.fromJson(o.toJson());
      checkResultScreenshot(od);
    });
  });


  unittest.group("obj-schema-ResultVersion", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultVersion();
      var od = new api.ResultVersion.fromJson(o.toJson());
      checkResultVersion(od);
    });
  });


  unittest.group("obj-schema-Result", () {
    unittest.test("to-json--from-json", () {
      var o = buildResult();
      var od = new api.Result.fromJson(o.toJson());
      checkResult(od);
    });
  });


  unittest.group("resource-PagespeedapiResourceApi", () {
    unittest.test("method--runpagespeed", () {

      var mock = new HttpServerMock();
      api.PagespeedapiResourceApi res = new api.PagespeedonlineApi(mock).pagespeedapi;
      var arg_url = "foo";
      var arg_filterThirdPartyResources = true;
      var arg_locale = "foo";
      var arg_rule = buildUnnamed2706();
      var arg_screenshot = true;
      var arg_strategy = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 19), unittest.equals("pagespeedonline/v1/"));
        pathOffset += 19;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("runPagespeed"));
        pathOffset += 12;

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
        unittest.expect(queryMap["url"].first, unittest.equals(arg_url));
        unittest.expect(queryMap["filter_third_party_resources"].first, unittest.equals("$arg_filterThirdPartyResources"));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(queryMap["rule"], unittest.equals(arg_rule));
        unittest.expect(queryMap["screenshot"].first, unittest.equals("$arg_screenshot"));
        unittest.expect(queryMap["strategy"].first, unittest.equals(arg_strategy));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildResult());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.runpagespeed(arg_url, filterThirdPartyResources: arg_filterThirdPartyResources, locale: arg_locale, rule: arg_rule, screenshot: arg_screenshot, strategy: arg_strategy).then(unittest.expectAsync(((api.Result response) {
        checkResult(response);
      })));
    });

  });


}

