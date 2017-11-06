library googleapis.customsearch.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/customsearch/v1.dart' as api;

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

core.int buildCounterContextFacets = 0;
buildContextFacets() {
  var o = new api.ContextFacets();
  buildCounterContextFacets++;
  if (buildCounterContextFacets < 3) {
    o.anchor = "foo";
    o.label = "foo";
    o.labelWithOp = "foo";
  }
  buildCounterContextFacets--;
  return o;
}

checkContextFacets(api.ContextFacets o) {
  buildCounterContextFacets++;
  if (buildCounterContextFacets < 3) {
    unittest.expect(o.anchor, unittest.equals('foo'));
    unittest.expect(o.label, unittest.equals('foo'));
    unittest.expect(o.labelWithOp, unittest.equals('foo'));
  }
  buildCounterContextFacets--;
}

buildUnnamed223() {
  var o = new core.List<api.ContextFacets>();
  o.add(buildContextFacets());
  o.add(buildContextFacets());
  return o;
}

checkUnnamed223(core.List<api.ContextFacets> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkContextFacets(o[0]);
  checkContextFacets(o[1]);
}

buildUnnamed224() {
  var o = new core.List<core.List<api.ContextFacets>>();
  o.add(buildUnnamed223());
  o.add(buildUnnamed223());
  return o;
}

checkUnnamed224(core.List<core.List<api.ContextFacets>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed223(o[0]);
  checkUnnamed223(o[1]);
}

core.int buildCounterContext = 0;
buildContext() {
  var o = new api.Context();
  buildCounterContext++;
  if (buildCounterContext < 3) {
    o.facets = buildUnnamed224();
    o.title = "foo";
  }
  buildCounterContext--;
  return o;
}

checkContext(api.Context o) {
  buildCounterContext++;
  if (buildCounterContext < 3) {
    checkUnnamed224(o.facets);
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterContext--;
}

core.int buildCounterPromotionBodyLines = 0;
buildPromotionBodyLines() {
  var o = new api.PromotionBodyLines();
  buildCounterPromotionBodyLines++;
  if (buildCounterPromotionBodyLines < 3) {
    o.htmlTitle = "foo";
    o.link = "foo";
    o.title = "foo";
    o.url = "foo";
  }
  buildCounterPromotionBodyLines--;
  return o;
}

checkPromotionBodyLines(api.PromotionBodyLines o) {
  buildCounterPromotionBodyLines++;
  if (buildCounterPromotionBodyLines < 3) {
    unittest.expect(o.htmlTitle, unittest.equals('foo'));
    unittest.expect(o.link, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterPromotionBodyLines--;
}

buildUnnamed225() {
  var o = new core.List<api.PromotionBodyLines>();
  o.add(buildPromotionBodyLines());
  o.add(buildPromotionBodyLines());
  return o;
}

checkUnnamed225(core.List<api.PromotionBodyLines> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPromotionBodyLines(o[0]);
  checkPromotionBodyLines(o[1]);
}

core.int buildCounterPromotionImage = 0;
buildPromotionImage() {
  var o = new api.PromotionImage();
  buildCounterPromotionImage++;
  if (buildCounterPromotionImage < 3) {
    o.height = 42;
    o.source = "foo";
    o.width = 42;
  }
  buildCounterPromotionImage--;
  return o;
}

checkPromotionImage(api.PromotionImage o) {
  buildCounterPromotionImage++;
  if (buildCounterPromotionImage < 3) {
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.source, unittest.equals('foo'));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterPromotionImage--;
}

core.int buildCounterPromotion = 0;
buildPromotion() {
  var o = new api.Promotion();
  buildCounterPromotion++;
  if (buildCounterPromotion < 3) {
    o.bodyLines = buildUnnamed225();
    o.displayLink = "foo";
    o.htmlTitle = "foo";
    o.image = buildPromotionImage();
    o.link = "foo";
    o.title = "foo";
  }
  buildCounterPromotion--;
  return o;
}

checkPromotion(api.Promotion o) {
  buildCounterPromotion++;
  if (buildCounterPromotion < 3) {
    checkUnnamed225(o.bodyLines);
    unittest.expect(o.displayLink, unittest.equals('foo'));
    unittest.expect(o.htmlTitle, unittest.equals('foo'));
    checkPromotionImage(o.image);
    unittest.expect(o.link, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterPromotion--;
}

core.int buildCounterQuery = 0;
buildQuery() {
  var o = new api.Query();
  buildCounterQuery++;
  if (buildCounterQuery < 3) {
    o.count = 42;
    o.cr = "foo";
    o.cref = "foo";
    o.cx = "foo";
    o.dateRestrict = "foo";
    o.disableCnTwTranslation = "foo";
    o.exactTerms = "foo";
    o.excludeTerms = "foo";
    o.fileType = "foo";
    o.filter = "foo";
    o.gl = "foo";
    o.googleHost = "foo";
    o.highRange = "foo";
    o.hl = "foo";
    o.hq = "foo";
    o.imgColorType = "foo";
    o.imgDominantColor = "foo";
    o.imgSize = "foo";
    o.imgType = "foo";
    o.inputEncoding = "foo";
    o.language = "foo";
    o.linkSite = "foo";
    o.lowRange = "foo";
    o.orTerms = "foo";
    o.outputEncoding = "foo";
    o.relatedSite = "foo";
    o.rights = "foo";
    o.safe = "foo";
    o.searchTerms = "foo";
    o.searchType = "foo";
    o.siteSearch = "foo";
    o.siteSearchFilter = "foo";
    o.sort = "foo";
    o.startIndex = 42;
    o.startPage = 42;
    o.title = "foo";
    o.totalResults = "foo";
  }
  buildCounterQuery--;
  return o;
}

checkQuery(api.Query o) {
  buildCounterQuery++;
  if (buildCounterQuery < 3) {
    unittest.expect(o.count, unittest.equals(42));
    unittest.expect(o.cr, unittest.equals('foo'));
    unittest.expect(o.cref, unittest.equals('foo'));
    unittest.expect(o.cx, unittest.equals('foo'));
    unittest.expect(o.dateRestrict, unittest.equals('foo'));
    unittest.expect(o.disableCnTwTranslation, unittest.equals('foo'));
    unittest.expect(o.exactTerms, unittest.equals('foo'));
    unittest.expect(o.excludeTerms, unittest.equals('foo'));
    unittest.expect(o.fileType, unittest.equals('foo'));
    unittest.expect(o.filter, unittest.equals('foo'));
    unittest.expect(o.gl, unittest.equals('foo'));
    unittest.expect(o.googleHost, unittest.equals('foo'));
    unittest.expect(o.highRange, unittest.equals('foo'));
    unittest.expect(o.hl, unittest.equals('foo'));
    unittest.expect(o.hq, unittest.equals('foo'));
    unittest.expect(o.imgColorType, unittest.equals('foo'));
    unittest.expect(o.imgDominantColor, unittest.equals('foo'));
    unittest.expect(o.imgSize, unittest.equals('foo'));
    unittest.expect(o.imgType, unittest.equals('foo'));
    unittest.expect(o.inputEncoding, unittest.equals('foo'));
    unittest.expect(o.language, unittest.equals('foo'));
    unittest.expect(o.linkSite, unittest.equals('foo'));
    unittest.expect(o.lowRange, unittest.equals('foo'));
    unittest.expect(o.orTerms, unittest.equals('foo'));
    unittest.expect(o.outputEncoding, unittest.equals('foo'));
    unittest.expect(o.relatedSite, unittest.equals('foo'));
    unittest.expect(o.rights, unittest.equals('foo'));
    unittest.expect(o.safe, unittest.equals('foo'));
    unittest.expect(o.searchTerms, unittest.equals('foo'));
    unittest.expect(o.searchType, unittest.equals('foo'));
    unittest.expect(o.siteSearch, unittest.equals('foo'));
    unittest.expect(o.siteSearchFilter, unittest.equals('foo'));
    unittest.expect(o.sort, unittest.equals('foo'));
    unittest.expect(o.startIndex, unittest.equals(42));
    unittest.expect(o.startPage, unittest.equals(42));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.totalResults, unittest.equals('foo'));
  }
  buildCounterQuery--;
}

core.int buildCounterResultImage = 0;
buildResultImage() {
  var o = new api.ResultImage();
  buildCounterResultImage++;
  if (buildCounterResultImage < 3) {
    o.byteSize = 42;
    o.contextLink = "foo";
    o.height = 42;
    o.thumbnailHeight = 42;
    o.thumbnailLink = "foo";
    o.thumbnailWidth = 42;
    o.width = 42;
  }
  buildCounterResultImage--;
  return o;
}

checkResultImage(api.ResultImage o) {
  buildCounterResultImage++;
  if (buildCounterResultImage < 3) {
    unittest.expect(o.byteSize, unittest.equals(42));
    unittest.expect(o.contextLink, unittest.equals('foo'));
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.thumbnailHeight, unittest.equals(42));
    unittest.expect(o.thumbnailLink, unittest.equals('foo'));
    unittest.expect(o.thumbnailWidth, unittest.equals(42));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterResultImage--;
}

core.int buildCounterResultLabels = 0;
buildResultLabels() {
  var o = new api.ResultLabels();
  buildCounterResultLabels++;
  if (buildCounterResultLabels < 3) {
    o.displayName = "foo";
    o.labelWithOp = "foo";
    o.name = "foo";
  }
  buildCounterResultLabels--;
  return o;
}

checkResultLabels(api.ResultLabels o) {
  buildCounterResultLabels++;
  if (buildCounterResultLabels < 3) {
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.labelWithOp, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterResultLabels--;
}

buildUnnamed226() {
  var o = new core.List<api.ResultLabels>();
  o.add(buildResultLabels());
  o.add(buildResultLabels());
  return o;
}

checkUnnamed226(core.List<api.ResultLabels> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResultLabels(o[0]);
  checkResultLabels(o[1]);
}

buildUnnamed227() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  o["y"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  return o;
}

checkUnnamed227(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o["x"]) as core.Map; unittest.expect(casted1, unittest.hasLength(3)); unittest.expect(casted1["list"], unittest.equals([1, 2, 3])); unittest.expect(casted1["bool"], unittest.equals(true)); unittest.expect(casted1["string"], unittest.equals('foo')); 
  var casted2 = (o["y"]) as core.Map; unittest.expect(casted2, unittest.hasLength(3)); unittest.expect(casted2["list"], unittest.equals([1, 2, 3])); unittest.expect(casted2["bool"], unittest.equals(true)); unittest.expect(casted2["string"], unittest.equals('foo')); 
}

buildUnnamed228() {
  var o = new core.List<core.Map<core.String, core.Object>>();
  o.add(buildUnnamed227());
  o.add(buildUnnamed227());
  return o;
}

checkUnnamed228(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed227(o[0]);
  checkUnnamed227(o[1]);
}

buildUnnamed229() {
  var o = new core.Map<core.String, core.List<core.Map<core.String, core.Object>>>();
  o["x"] = buildUnnamed228();
  o["y"] = buildUnnamed228();
  return o;
}

checkUnnamed229(core.Map<core.String, core.List<core.Map<core.String, core.Object>>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed228(o["x"]);
  checkUnnamed228(o["y"]);
}

core.int buildCounterResult = 0;
buildResult() {
  var o = new api.Result();
  buildCounterResult++;
  if (buildCounterResult < 3) {
    o.cacheId = "foo";
    o.displayLink = "foo";
    o.fileFormat = "foo";
    o.formattedUrl = "foo";
    o.htmlFormattedUrl = "foo";
    o.htmlSnippet = "foo";
    o.htmlTitle = "foo";
    o.image = buildResultImage();
    o.kind = "foo";
    o.labels = buildUnnamed226();
    o.link = "foo";
    o.mime = "foo";
    o.pagemap = buildUnnamed229();
    o.snippet = "foo";
    o.title = "foo";
  }
  buildCounterResult--;
  return o;
}

checkResult(api.Result o) {
  buildCounterResult++;
  if (buildCounterResult < 3) {
    unittest.expect(o.cacheId, unittest.equals('foo'));
    unittest.expect(o.displayLink, unittest.equals('foo'));
    unittest.expect(o.fileFormat, unittest.equals('foo'));
    unittest.expect(o.formattedUrl, unittest.equals('foo'));
    unittest.expect(o.htmlFormattedUrl, unittest.equals('foo'));
    unittest.expect(o.htmlSnippet, unittest.equals('foo'));
    unittest.expect(o.htmlTitle, unittest.equals('foo'));
    checkResultImage(o.image);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed226(o.labels);
    unittest.expect(o.link, unittest.equals('foo'));
    unittest.expect(o.mime, unittest.equals('foo'));
    checkUnnamed229(o.pagemap);
    unittest.expect(o.snippet, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterResult--;
}

buildUnnamed230() {
  var o = new core.List<api.Result>();
  o.add(buildResult());
  o.add(buildResult());
  return o;
}

checkUnnamed230(core.List<api.Result> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResult(o[0]);
  checkResult(o[1]);
}

buildUnnamed231() {
  var o = new core.List<api.Promotion>();
  o.add(buildPromotion());
  o.add(buildPromotion());
  return o;
}

checkUnnamed231(core.List<api.Promotion> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPromotion(o[0]);
  checkPromotion(o[1]);
}

buildUnnamed232() {
  var o = new core.List<api.Query>();
  o.add(buildQuery());
  o.add(buildQuery());
  return o;
}

checkUnnamed232(core.List<api.Query> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkQuery(o[0]);
  checkQuery(o[1]);
}

buildUnnamed233() {
  var o = new core.Map<core.String, core.List<api.Query>>();
  o["x"] = buildUnnamed232();
  o["y"] = buildUnnamed232();
  return o;
}

checkUnnamed233(core.Map<core.String, core.List<api.Query>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed232(o["x"]);
  checkUnnamed232(o["y"]);
}

core.int buildCounterSearchSearchInformation = 0;
buildSearchSearchInformation() {
  var o = new api.SearchSearchInformation();
  buildCounterSearchSearchInformation++;
  if (buildCounterSearchSearchInformation < 3) {
    o.formattedSearchTime = "foo";
    o.formattedTotalResults = "foo";
    o.searchTime = 42.0;
    o.totalResults = "foo";
  }
  buildCounterSearchSearchInformation--;
  return o;
}

checkSearchSearchInformation(api.SearchSearchInformation o) {
  buildCounterSearchSearchInformation++;
  if (buildCounterSearchSearchInformation < 3) {
    unittest.expect(o.formattedSearchTime, unittest.equals('foo'));
    unittest.expect(o.formattedTotalResults, unittest.equals('foo'));
    unittest.expect(o.searchTime, unittest.equals(42.0));
    unittest.expect(o.totalResults, unittest.equals('foo'));
  }
  buildCounterSearchSearchInformation--;
}

core.int buildCounterSearchSpelling = 0;
buildSearchSpelling() {
  var o = new api.SearchSpelling();
  buildCounterSearchSpelling++;
  if (buildCounterSearchSpelling < 3) {
    o.correctedQuery = "foo";
    o.htmlCorrectedQuery = "foo";
  }
  buildCounterSearchSpelling--;
  return o;
}

checkSearchSpelling(api.SearchSpelling o) {
  buildCounterSearchSpelling++;
  if (buildCounterSearchSpelling < 3) {
    unittest.expect(o.correctedQuery, unittest.equals('foo'));
    unittest.expect(o.htmlCorrectedQuery, unittest.equals('foo'));
  }
  buildCounterSearchSpelling--;
}

core.int buildCounterSearchUrl = 0;
buildSearchUrl() {
  var o = new api.SearchUrl();
  buildCounterSearchUrl++;
  if (buildCounterSearchUrl < 3) {
    o.template = "foo";
    o.type = "foo";
  }
  buildCounterSearchUrl--;
  return o;
}

checkSearchUrl(api.SearchUrl o) {
  buildCounterSearchUrl++;
  if (buildCounterSearchUrl < 3) {
    unittest.expect(o.template, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterSearchUrl--;
}

core.int buildCounterSearch = 0;
buildSearch() {
  var o = new api.Search();
  buildCounterSearch++;
  if (buildCounterSearch < 3) {
    o.context = buildContext();
    o.items = buildUnnamed230();
    o.kind = "foo";
    o.promotions = buildUnnamed231();
    o.queries = buildUnnamed233();
    o.searchInformation = buildSearchSearchInformation();
    o.spelling = buildSearchSpelling();
    o.url = buildSearchUrl();
  }
  buildCounterSearch--;
  return o;
}

checkSearch(api.Search o) {
  buildCounterSearch++;
  if (buildCounterSearch < 3) {
    checkContext(o.context);
    checkUnnamed230(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed231(o.promotions);
    checkUnnamed233(o.queries);
    checkSearchSearchInformation(o.searchInformation);
    checkSearchSpelling(o.spelling);
    checkSearchUrl(o.url);
  }
  buildCounterSearch--;
}


main() {
  unittest.group("obj-schema-ContextFacets", () {
    unittest.test("to-json--from-json", () {
      var o = buildContextFacets();
      var od = new api.ContextFacets.fromJson(o.toJson());
      checkContextFacets(od);
    });
  });


  unittest.group("obj-schema-Context", () {
    unittest.test("to-json--from-json", () {
      var o = buildContext();
      var od = new api.Context.fromJson(o.toJson());
      checkContext(od);
    });
  });


  unittest.group("obj-schema-PromotionBodyLines", () {
    unittest.test("to-json--from-json", () {
      var o = buildPromotionBodyLines();
      var od = new api.PromotionBodyLines.fromJson(o.toJson());
      checkPromotionBodyLines(od);
    });
  });


  unittest.group("obj-schema-PromotionImage", () {
    unittest.test("to-json--from-json", () {
      var o = buildPromotionImage();
      var od = new api.PromotionImage.fromJson(o.toJson());
      checkPromotionImage(od);
    });
  });


  unittest.group("obj-schema-Promotion", () {
    unittest.test("to-json--from-json", () {
      var o = buildPromotion();
      var od = new api.Promotion.fromJson(o.toJson());
      checkPromotion(od);
    });
  });


  unittest.group("obj-schema-Query", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuery();
      var od = new api.Query.fromJson(o.toJson());
      checkQuery(od);
    });
  });


  unittest.group("obj-schema-ResultImage", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultImage();
      var od = new api.ResultImage.fromJson(o.toJson());
      checkResultImage(od);
    });
  });


  unittest.group("obj-schema-ResultLabels", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultLabels();
      var od = new api.ResultLabels.fromJson(o.toJson());
      checkResultLabels(od);
    });
  });


  unittest.group("obj-schema-Result", () {
    unittest.test("to-json--from-json", () {
      var o = buildResult();
      var od = new api.Result.fromJson(o.toJson());
      checkResult(od);
    });
  });


  unittest.group("obj-schema-SearchSearchInformation", () {
    unittest.test("to-json--from-json", () {
      var o = buildSearchSearchInformation();
      var od = new api.SearchSearchInformation.fromJson(o.toJson());
      checkSearchSearchInformation(od);
    });
  });


  unittest.group("obj-schema-SearchSpelling", () {
    unittest.test("to-json--from-json", () {
      var o = buildSearchSpelling();
      var od = new api.SearchSpelling.fromJson(o.toJson());
      checkSearchSpelling(od);
    });
  });


  unittest.group("obj-schema-SearchUrl", () {
    unittest.test("to-json--from-json", () {
      var o = buildSearchUrl();
      var od = new api.SearchUrl.fromJson(o.toJson());
      checkSearchUrl(od);
    });
  });


  unittest.group("obj-schema-Search", () {
    unittest.test("to-json--from-json", () {
      var o = buildSearch();
      var od = new api.Search.fromJson(o.toJson());
      checkSearch(od);
    });
  });


  unittest.group("resource-CseResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.CseResourceApi res = new api.CustomsearchApi(mock).cse;
      var arg_q = "foo";
      var arg_c2coff = "foo";
      var arg_cr = "foo";
      var arg_cref = "foo";
      var arg_cx = "foo";
      var arg_dateRestrict = "foo";
      var arg_exactTerms = "foo";
      var arg_excludeTerms = "foo";
      var arg_fileType = "foo";
      var arg_filter = "foo";
      var arg_gl = "foo";
      var arg_googlehost = "foo";
      var arg_highRange = "foo";
      var arg_hl = "foo";
      var arg_hq = "foo";
      var arg_imgColorType = "foo";
      var arg_imgDominantColor = "foo";
      var arg_imgSize = "foo";
      var arg_imgType = "foo";
      var arg_linkSite = "foo";
      var arg_lowRange = "foo";
      var arg_lr = "foo";
      var arg_num = 42;
      var arg_orTerms = "foo";
      var arg_relatedSite = "foo";
      var arg_rights = "foo";
      var arg_safe = "foo";
      var arg_searchType = "foo";
      var arg_siteSearch = "foo";
      var arg_siteSearchFilter = "foo";
      var arg_sort = "foo";
      var arg_start = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("customsearch/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 2), unittest.equals("v1"));
        pathOffset += 2;

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
        unittest.expect(queryMap["q"].first, unittest.equals(arg_q));
        unittest.expect(queryMap["c2coff"].first, unittest.equals(arg_c2coff));
        unittest.expect(queryMap["cr"].first, unittest.equals(arg_cr));
        unittest.expect(queryMap["cref"].first, unittest.equals(arg_cref));
        unittest.expect(queryMap["cx"].first, unittest.equals(arg_cx));
        unittest.expect(queryMap["dateRestrict"].first, unittest.equals(arg_dateRestrict));
        unittest.expect(queryMap["exactTerms"].first, unittest.equals(arg_exactTerms));
        unittest.expect(queryMap["excludeTerms"].first, unittest.equals(arg_excludeTerms));
        unittest.expect(queryMap["fileType"].first, unittest.equals(arg_fileType));
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
        unittest.expect(queryMap["gl"].first, unittest.equals(arg_gl));
        unittest.expect(queryMap["googlehost"].first, unittest.equals(arg_googlehost));
        unittest.expect(queryMap["highRange"].first, unittest.equals(arg_highRange));
        unittest.expect(queryMap["hl"].first, unittest.equals(arg_hl));
        unittest.expect(queryMap["hq"].first, unittest.equals(arg_hq));
        unittest.expect(queryMap["imgColorType"].first, unittest.equals(arg_imgColorType));
        unittest.expect(queryMap["imgDominantColor"].first, unittest.equals(arg_imgDominantColor));
        unittest.expect(queryMap["imgSize"].first, unittest.equals(arg_imgSize));
        unittest.expect(queryMap["imgType"].first, unittest.equals(arg_imgType));
        unittest.expect(queryMap["linkSite"].first, unittest.equals(arg_linkSite));
        unittest.expect(queryMap["lowRange"].first, unittest.equals(arg_lowRange));
        unittest.expect(queryMap["lr"].first, unittest.equals(arg_lr));
        unittest.expect(core.int.parse(queryMap["num"].first), unittest.equals(arg_num));
        unittest.expect(queryMap["orTerms"].first, unittest.equals(arg_orTerms));
        unittest.expect(queryMap["relatedSite"].first, unittest.equals(arg_relatedSite));
        unittest.expect(queryMap["rights"].first, unittest.equals(arg_rights));
        unittest.expect(queryMap["safe"].first, unittest.equals(arg_safe));
        unittest.expect(queryMap["searchType"].first, unittest.equals(arg_searchType));
        unittest.expect(queryMap["siteSearch"].first, unittest.equals(arg_siteSearch));
        unittest.expect(queryMap["siteSearchFilter"].first, unittest.equals(arg_siteSearchFilter));
        unittest.expect(queryMap["sort"].first, unittest.equals(arg_sort));
        unittest.expect(core.int.parse(queryMap["start"].first), unittest.equals(arg_start));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSearch());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_q, c2coff: arg_c2coff, cr: arg_cr, cref: arg_cref, cx: arg_cx, dateRestrict: arg_dateRestrict, exactTerms: arg_exactTerms, excludeTerms: arg_excludeTerms, fileType: arg_fileType, filter: arg_filter, gl: arg_gl, googlehost: arg_googlehost, highRange: arg_highRange, hl: arg_hl, hq: arg_hq, imgColorType: arg_imgColorType, imgDominantColor: arg_imgDominantColor, imgSize: arg_imgSize, imgType: arg_imgType, linkSite: arg_linkSite, lowRange: arg_lowRange, lr: arg_lr, num: arg_num, orTerms: arg_orTerms, relatedSite: arg_relatedSite, rights: arg_rights, safe: arg_safe, searchType: arg_searchType, siteSearch: arg_siteSearch, siteSearchFilter: arg_siteSearchFilter, sort: arg_sort, start: arg_start).then(unittest.expectAsync(((api.Search response) {
        checkSearch(response);
      })));
    });

  });


}

