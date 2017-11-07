library googleapis.pagespeedonline.v2.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/pagespeedonline/v2.dart' as api;

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

core.int buildCounterPagespeedApiFormatStringV2ArgsRects = 0;
buildPagespeedApiFormatStringV2ArgsRects() {
  var o = new api.PagespeedApiFormatStringV2ArgsRects();
  buildCounterPagespeedApiFormatStringV2ArgsRects++;
  if (buildCounterPagespeedApiFormatStringV2ArgsRects < 3) {
    o.height = 42;
    o.left = 42;
    o.top = 42;
    o.width = 42;
  }
  buildCounterPagespeedApiFormatStringV2ArgsRects--;
  return o;
}

checkPagespeedApiFormatStringV2ArgsRects(api.PagespeedApiFormatStringV2ArgsRects o) {
  buildCounterPagespeedApiFormatStringV2ArgsRects++;
  if (buildCounterPagespeedApiFormatStringV2ArgsRects < 3) {
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.left, unittest.equals(42));
    unittest.expect(o.top, unittest.equals(42));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterPagespeedApiFormatStringV2ArgsRects--;
}

buildUnnamed1118() {
  var o = new core.List<api.PagespeedApiFormatStringV2ArgsRects>();
  o.add(buildPagespeedApiFormatStringV2ArgsRects());
  o.add(buildPagespeedApiFormatStringV2ArgsRects());
  return o;
}

checkUnnamed1118(core.List<api.PagespeedApiFormatStringV2ArgsRects> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPagespeedApiFormatStringV2ArgsRects(o[0]);
  checkPagespeedApiFormatStringV2ArgsRects(o[1]);
}

core.int buildCounterPagespeedApiFormatStringV2ArgsSecondaryRects = 0;
buildPagespeedApiFormatStringV2ArgsSecondaryRects() {
  var o = new api.PagespeedApiFormatStringV2ArgsSecondaryRects();
  buildCounterPagespeedApiFormatStringV2ArgsSecondaryRects++;
  if (buildCounterPagespeedApiFormatStringV2ArgsSecondaryRects < 3) {
    o.height = 42;
    o.left = 42;
    o.top = 42;
    o.width = 42;
  }
  buildCounterPagespeedApiFormatStringV2ArgsSecondaryRects--;
  return o;
}

checkPagespeedApiFormatStringV2ArgsSecondaryRects(api.PagespeedApiFormatStringV2ArgsSecondaryRects o) {
  buildCounterPagespeedApiFormatStringV2ArgsSecondaryRects++;
  if (buildCounterPagespeedApiFormatStringV2ArgsSecondaryRects < 3) {
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.left, unittest.equals(42));
    unittest.expect(o.top, unittest.equals(42));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterPagespeedApiFormatStringV2ArgsSecondaryRects--;
}

buildUnnamed1119() {
  var o = new core.List<api.PagespeedApiFormatStringV2ArgsSecondaryRects>();
  o.add(buildPagespeedApiFormatStringV2ArgsSecondaryRects());
  o.add(buildPagespeedApiFormatStringV2ArgsSecondaryRects());
  return o;
}

checkUnnamed1119(core.List<api.PagespeedApiFormatStringV2ArgsSecondaryRects> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPagespeedApiFormatStringV2ArgsSecondaryRects(o[0]);
  checkPagespeedApiFormatStringV2ArgsSecondaryRects(o[1]);
}

core.int buildCounterPagespeedApiFormatStringV2Args = 0;
buildPagespeedApiFormatStringV2Args() {
  var o = new api.PagespeedApiFormatStringV2Args();
  buildCounterPagespeedApiFormatStringV2Args++;
  if (buildCounterPagespeedApiFormatStringV2Args < 3) {
    o.key = "foo";
    o.rects = buildUnnamed1118();
    o.secondaryRects = buildUnnamed1119();
    o.type = "foo";
    o.value = "foo";
  }
  buildCounterPagespeedApiFormatStringV2Args--;
  return o;
}

checkPagespeedApiFormatStringV2Args(api.PagespeedApiFormatStringV2Args o) {
  buildCounterPagespeedApiFormatStringV2Args++;
  if (buildCounterPagespeedApiFormatStringV2Args < 3) {
    unittest.expect(o.key, unittest.equals('foo'));
    checkUnnamed1118(o.rects);
    checkUnnamed1119(o.secondaryRects);
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterPagespeedApiFormatStringV2Args--;
}

buildUnnamed1120() {
  var o = new core.List<api.PagespeedApiFormatStringV2Args>();
  o.add(buildPagespeedApiFormatStringV2Args());
  o.add(buildPagespeedApiFormatStringV2Args());
  return o;
}

checkUnnamed1120(core.List<api.PagespeedApiFormatStringV2Args> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPagespeedApiFormatStringV2Args(o[0]);
  checkPagespeedApiFormatStringV2Args(o[1]);
}

core.int buildCounterPagespeedApiFormatStringV2 = 0;
buildPagespeedApiFormatStringV2() {
  var o = new api.PagespeedApiFormatStringV2();
  buildCounterPagespeedApiFormatStringV2++;
  if (buildCounterPagespeedApiFormatStringV2 < 3) {
    o.args = buildUnnamed1120();
    o.format = "foo";
  }
  buildCounterPagespeedApiFormatStringV2--;
  return o;
}

checkPagespeedApiFormatStringV2(api.PagespeedApiFormatStringV2 o) {
  buildCounterPagespeedApiFormatStringV2++;
  if (buildCounterPagespeedApiFormatStringV2 < 3) {
    checkUnnamed1120(o.args);
    unittest.expect(o.format, unittest.equals('foo'));
  }
  buildCounterPagespeedApiFormatStringV2--;
}

core.int buildCounterPagespeedApiImageV2PageRect = 0;
buildPagespeedApiImageV2PageRect() {
  var o = new api.PagespeedApiImageV2PageRect();
  buildCounterPagespeedApiImageV2PageRect++;
  if (buildCounterPagespeedApiImageV2PageRect < 3) {
    o.height = 42;
    o.left = 42;
    o.top = 42;
    o.width = 42;
  }
  buildCounterPagespeedApiImageV2PageRect--;
  return o;
}

checkPagespeedApiImageV2PageRect(api.PagespeedApiImageV2PageRect o) {
  buildCounterPagespeedApiImageV2PageRect++;
  if (buildCounterPagespeedApiImageV2PageRect < 3) {
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.left, unittest.equals(42));
    unittest.expect(o.top, unittest.equals(42));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterPagespeedApiImageV2PageRect--;
}

core.int buildCounterPagespeedApiImageV2 = 0;
buildPagespeedApiImageV2() {
  var o = new api.PagespeedApiImageV2();
  buildCounterPagespeedApiImageV2++;
  if (buildCounterPagespeedApiImageV2 < 3) {
    o.data = "foo";
    o.height = 42;
    o.key = "foo";
    o.mimeType = "foo";
    o.pageRect = buildPagespeedApiImageV2PageRect();
    o.width = 42;
  }
  buildCounterPagespeedApiImageV2--;
  return o;
}

checkPagespeedApiImageV2(api.PagespeedApiImageV2 o) {
  buildCounterPagespeedApiImageV2++;
  if (buildCounterPagespeedApiImageV2 < 3) {
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.key, unittest.equals('foo'));
    unittest.expect(o.mimeType, unittest.equals('foo'));
    checkPagespeedApiImageV2PageRect(o.pageRect);
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterPagespeedApiImageV2--;
}

buildUnnamed1121() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1121(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1122() {
  var o = new core.List<api.PagespeedApiFormatStringV2>();
  o.add(buildPagespeedApiFormatStringV2());
  o.add(buildPagespeedApiFormatStringV2());
  return o;
}

checkUnnamed1122(core.List<api.PagespeedApiFormatStringV2> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPagespeedApiFormatStringV2(o[0]);
  checkPagespeedApiFormatStringV2(o[1]);
}

core.int buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls = 0;
buildResultFormattedResultsRuleResultsValueUrlBlocksUrls() {
  var o = new api.ResultFormattedResultsRuleResultsValueUrlBlocksUrls();
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls < 3) {
    o.details = buildUnnamed1122();
    o.result = buildPagespeedApiFormatStringV2();
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls--;
  return o;
}

checkResultFormattedResultsRuleResultsValueUrlBlocksUrls(api.ResultFormattedResultsRuleResultsValueUrlBlocksUrls o) {
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls < 3) {
    checkUnnamed1122(o.details);
    checkPagespeedApiFormatStringV2(o.result);
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocksUrls--;
}

buildUnnamed1123() {
  var o = new core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocksUrls>();
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocksUrls());
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocksUrls());
  return o;
}

checkUnnamed1123(core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocksUrls> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResultFormattedResultsRuleResultsValueUrlBlocksUrls(o[0]);
  checkResultFormattedResultsRuleResultsValueUrlBlocksUrls(o[1]);
}

core.int buildCounterResultFormattedResultsRuleResultsValueUrlBlocks = 0;
buildResultFormattedResultsRuleResultsValueUrlBlocks() {
  var o = new api.ResultFormattedResultsRuleResultsValueUrlBlocks();
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocks++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocks < 3) {
    o.header = buildPagespeedApiFormatStringV2();
    o.urls = buildUnnamed1123();
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocks--;
  return o;
}

checkResultFormattedResultsRuleResultsValueUrlBlocks(api.ResultFormattedResultsRuleResultsValueUrlBlocks o) {
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocks++;
  if (buildCounterResultFormattedResultsRuleResultsValueUrlBlocks < 3) {
    checkPagespeedApiFormatStringV2(o.header);
    checkUnnamed1123(o.urls);
  }
  buildCounterResultFormattedResultsRuleResultsValueUrlBlocks--;
}

buildUnnamed1124() {
  var o = new core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocks>();
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocks());
  o.add(buildResultFormattedResultsRuleResultsValueUrlBlocks());
  return o;
}

checkUnnamed1124(core.List<api.ResultFormattedResultsRuleResultsValueUrlBlocks> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResultFormattedResultsRuleResultsValueUrlBlocks(o[0]);
  checkResultFormattedResultsRuleResultsValueUrlBlocks(o[1]);
}

core.int buildCounterResultFormattedResultsRuleResultsValue = 0;
buildResultFormattedResultsRuleResultsValue() {
  var o = new api.ResultFormattedResultsRuleResultsValue();
  buildCounterResultFormattedResultsRuleResultsValue++;
  if (buildCounterResultFormattedResultsRuleResultsValue < 3) {
    o.groups = buildUnnamed1121();
    o.localizedRuleName = "foo";
    o.ruleImpact = 42.0;
    o.summary = buildPagespeedApiFormatStringV2();
    o.urlBlocks = buildUnnamed1124();
  }
  buildCounterResultFormattedResultsRuleResultsValue--;
  return o;
}

checkResultFormattedResultsRuleResultsValue(api.ResultFormattedResultsRuleResultsValue o) {
  buildCounterResultFormattedResultsRuleResultsValue++;
  if (buildCounterResultFormattedResultsRuleResultsValue < 3) {
    checkUnnamed1121(o.groups);
    unittest.expect(o.localizedRuleName, unittest.equals('foo'));
    unittest.expect(o.ruleImpact, unittest.equals(42.0));
    checkPagespeedApiFormatStringV2(o.summary);
    checkUnnamed1124(o.urlBlocks);
  }
  buildCounterResultFormattedResultsRuleResultsValue--;
}

buildUnnamed1125() {
  var o = new core.Map<core.String, api.ResultFormattedResultsRuleResultsValue>();
  o["x"] = buildResultFormattedResultsRuleResultsValue();
  o["y"] = buildResultFormattedResultsRuleResultsValue();
  return o;
}

checkUnnamed1125(core.Map<core.String, api.ResultFormattedResultsRuleResultsValue> o) {
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
    o.ruleResults = buildUnnamed1125();
  }
  buildCounterResultFormattedResults--;
  return o;
}

checkResultFormattedResults(api.ResultFormattedResults o) {
  buildCounterResultFormattedResults++;
  if (buildCounterResultFormattedResults < 3) {
    unittest.expect(o.locale, unittest.equals('foo'));
    checkUnnamed1125(o.ruleResults);
  }
  buildCounterResultFormattedResults--;
}

buildUnnamed1126() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1126(core.List<core.String> o) {
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

core.int buildCounterResultRuleGroupsValue = 0;
buildResultRuleGroupsValue() {
  var o = new api.ResultRuleGroupsValue();
  buildCounterResultRuleGroupsValue++;
  if (buildCounterResultRuleGroupsValue < 3) {
    o.score = 42;
  }
  buildCounterResultRuleGroupsValue--;
  return o;
}

checkResultRuleGroupsValue(api.ResultRuleGroupsValue o) {
  buildCounterResultRuleGroupsValue++;
  if (buildCounterResultRuleGroupsValue < 3) {
    unittest.expect(o.score, unittest.equals(42));
  }
  buildCounterResultRuleGroupsValue--;
}

buildUnnamed1127() {
  var o = new core.Map<core.String, api.ResultRuleGroupsValue>();
  o["x"] = buildResultRuleGroupsValue();
  o["y"] = buildResultRuleGroupsValue();
  return o;
}

checkUnnamed1127(core.Map<core.String, api.ResultRuleGroupsValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResultRuleGroupsValue(o["x"]);
  checkResultRuleGroupsValue(o["y"]);
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
    o.invalidRules = buildUnnamed1126();
    o.kind = "foo";
    o.pageStats = buildResultPageStats();
    o.responseCode = 42;
    o.ruleGroups = buildUnnamed1127();
    o.screenshot = buildPagespeedApiImageV2();
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
    checkUnnamed1126(o.invalidRules);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkResultPageStats(o.pageStats);
    unittest.expect(o.responseCode, unittest.equals(42));
    checkUnnamed1127(o.ruleGroups);
    checkPagespeedApiImageV2(o.screenshot);
    unittest.expect(o.title, unittest.equals('foo'));
    checkResultVersion(o.version);
  }
  buildCounterResult--;
}

buildUnnamed1128() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1128(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}


main() {
  unittest.group("obj-schema-PagespeedApiFormatStringV2ArgsRects", () {
    unittest.test("to-json--from-json", () {
      var o = buildPagespeedApiFormatStringV2ArgsRects();
      var od = new api.PagespeedApiFormatStringV2ArgsRects.fromJson(o.toJson());
      checkPagespeedApiFormatStringV2ArgsRects(od);
    });
  });


  unittest.group("obj-schema-PagespeedApiFormatStringV2ArgsSecondaryRects", () {
    unittest.test("to-json--from-json", () {
      var o = buildPagespeedApiFormatStringV2ArgsSecondaryRects();
      var od = new api.PagespeedApiFormatStringV2ArgsSecondaryRects.fromJson(o.toJson());
      checkPagespeedApiFormatStringV2ArgsSecondaryRects(od);
    });
  });


  unittest.group("obj-schema-PagespeedApiFormatStringV2Args", () {
    unittest.test("to-json--from-json", () {
      var o = buildPagespeedApiFormatStringV2Args();
      var od = new api.PagespeedApiFormatStringV2Args.fromJson(o.toJson());
      checkPagespeedApiFormatStringV2Args(od);
    });
  });


  unittest.group("obj-schema-PagespeedApiFormatStringV2", () {
    unittest.test("to-json--from-json", () {
      var o = buildPagespeedApiFormatStringV2();
      var od = new api.PagespeedApiFormatStringV2.fromJson(o.toJson());
      checkPagespeedApiFormatStringV2(od);
    });
  });


  unittest.group("obj-schema-PagespeedApiImageV2PageRect", () {
    unittest.test("to-json--from-json", () {
      var o = buildPagespeedApiImageV2PageRect();
      var od = new api.PagespeedApiImageV2PageRect.fromJson(o.toJson());
      checkPagespeedApiImageV2PageRect(od);
    });
  });


  unittest.group("obj-schema-PagespeedApiImageV2", () {
    unittest.test("to-json--from-json", () {
      var o = buildPagespeedApiImageV2();
      var od = new api.PagespeedApiImageV2.fromJson(o.toJson());
      checkPagespeedApiImageV2(od);
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


  unittest.group("obj-schema-ResultRuleGroupsValue", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultRuleGroupsValue();
      var od = new api.ResultRuleGroupsValue.fromJson(o.toJson());
      checkResultRuleGroupsValue(od);
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
      var arg_rule = buildUnnamed1128();
      var arg_screenshot = true;
      var arg_strategy = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 19), unittest.equals("pagespeedonline/v2/"));
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

