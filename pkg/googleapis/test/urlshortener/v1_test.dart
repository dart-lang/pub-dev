library googleapis.urlshortener.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/urlshortener/v1.dart' as api;

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

buildUnnamed690() {
  var o = new core.List<api.StringCount>();
  o.add(buildStringCount());
  o.add(buildStringCount());
  return o;
}

checkUnnamed690(core.List<api.StringCount> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkStringCount(o[0]);
  checkStringCount(o[1]);
}

buildUnnamed691() {
  var o = new core.List<api.StringCount>();
  o.add(buildStringCount());
  o.add(buildStringCount());
  return o;
}

checkUnnamed691(core.List<api.StringCount> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkStringCount(o[0]);
  checkStringCount(o[1]);
}

buildUnnamed692() {
  var o = new core.List<api.StringCount>();
  o.add(buildStringCount());
  o.add(buildStringCount());
  return o;
}

checkUnnamed692(core.List<api.StringCount> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkStringCount(o[0]);
  checkStringCount(o[1]);
}

buildUnnamed693() {
  var o = new core.List<api.StringCount>();
  o.add(buildStringCount());
  o.add(buildStringCount());
  return o;
}

checkUnnamed693(core.List<api.StringCount> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkStringCount(o[0]);
  checkStringCount(o[1]);
}

core.int buildCounterAnalyticsSnapshot = 0;
buildAnalyticsSnapshot() {
  var o = new api.AnalyticsSnapshot();
  buildCounterAnalyticsSnapshot++;
  if (buildCounterAnalyticsSnapshot < 3) {
    o.browsers = buildUnnamed690();
    o.countries = buildUnnamed691();
    o.longUrlClicks = "foo";
    o.platforms = buildUnnamed692();
    o.referrers = buildUnnamed693();
    o.shortUrlClicks = "foo";
  }
  buildCounterAnalyticsSnapshot--;
  return o;
}

checkAnalyticsSnapshot(api.AnalyticsSnapshot o) {
  buildCounterAnalyticsSnapshot++;
  if (buildCounterAnalyticsSnapshot < 3) {
    checkUnnamed690(o.browsers);
    checkUnnamed691(o.countries);
    unittest.expect(o.longUrlClicks, unittest.equals('foo'));
    checkUnnamed692(o.platforms);
    checkUnnamed693(o.referrers);
    unittest.expect(o.shortUrlClicks, unittest.equals('foo'));
  }
  buildCounterAnalyticsSnapshot--;
}

core.int buildCounterAnalyticsSummary = 0;
buildAnalyticsSummary() {
  var o = new api.AnalyticsSummary();
  buildCounterAnalyticsSummary++;
  if (buildCounterAnalyticsSummary < 3) {
    o.allTime = buildAnalyticsSnapshot();
    o.day = buildAnalyticsSnapshot();
    o.month = buildAnalyticsSnapshot();
    o.twoHours = buildAnalyticsSnapshot();
    o.week = buildAnalyticsSnapshot();
  }
  buildCounterAnalyticsSummary--;
  return o;
}

checkAnalyticsSummary(api.AnalyticsSummary o) {
  buildCounterAnalyticsSummary++;
  if (buildCounterAnalyticsSummary < 3) {
    checkAnalyticsSnapshot(o.allTime);
    checkAnalyticsSnapshot(o.day);
    checkAnalyticsSnapshot(o.month);
    checkAnalyticsSnapshot(o.twoHours);
    checkAnalyticsSnapshot(o.week);
  }
  buildCounterAnalyticsSummary--;
}

core.int buildCounterStringCount = 0;
buildStringCount() {
  var o = new api.StringCount();
  buildCounterStringCount++;
  if (buildCounterStringCount < 3) {
    o.count = "foo";
    o.id = "foo";
  }
  buildCounterStringCount--;
  return o;
}

checkStringCount(api.StringCount o) {
  buildCounterStringCount++;
  if (buildCounterStringCount < 3) {
    unittest.expect(o.count, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
  }
  buildCounterStringCount--;
}

core.int buildCounterUrl = 0;
buildUrl() {
  var o = new api.Url();
  buildCounterUrl++;
  if (buildCounterUrl < 3) {
    o.analytics = buildAnalyticsSummary();
    o.created = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.longUrl = "foo";
    o.status = "foo";
  }
  buildCounterUrl--;
  return o;
}

checkUrl(api.Url o) {
  buildCounterUrl++;
  if (buildCounterUrl < 3) {
    checkAnalyticsSummary(o.analytics);
    unittest.expect(o.created, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.longUrl, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterUrl--;
}

buildUnnamed694() {
  var o = new core.List<api.Url>();
  o.add(buildUrl());
  o.add(buildUrl());
  return o;
}

checkUnnamed694(core.List<api.Url> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUrl(o[0]);
  checkUrl(o[1]);
}

core.int buildCounterUrlHistory = 0;
buildUrlHistory() {
  var o = new api.UrlHistory();
  buildCounterUrlHistory++;
  if (buildCounterUrlHistory < 3) {
    o.items = buildUnnamed694();
    o.itemsPerPage = 42;
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.totalItems = 42;
  }
  buildCounterUrlHistory--;
  return o;
}

checkUrlHistory(api.UrlHistory o) {
  buildCounterUrlHistory++;
  if (buildCounterUrlHistory < 3) {
    checkUnnamed694(o.items);
    unittest.expect(o.itemsPerPage, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals(42));
  }
  buildCounterUrlHistory--;
}


main() {
  unittest.group("obj-schema-AnalyticsSnapshot", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyticsSnapshot();
      var od = new api.AnalyticsSnapshot.fromJson(o.toJson());
      checkAnalyticsSnapshot(od);
    });
  });


  unittest.group("obj-schema-AnalyticsSummary", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyticsSummary();
      var od = new api.AnalyticsSummary.fromJson(o.toJson());
      checkAnalyticsSummary(od);
    });
  });


  unittest.group("obj-schema-StringCount", () {
    unittest.test("to-json--from-json", () {
      var o = buildStringCount();
      var od = new api.StringCount.fromJson(o.toJson());
      checkStringCount(od);
    });
  });


  unittest.group("obj-schema-Url", () {
    unittest.test("to-json--from-json", () {
      var o = buildUrl();
      var od = new api.Url.fromJson(o.toJson());
      checkUrl(od);
    });
  });


  unittest.group("obj-schema-UrlHistory", () {
    unittest.test("to-json--from-json", () {
      var o = buildUrlHistory();
      var od = new api.UrlHistory.fromJson(o.toJson());
      checkUrlHistory(od);
    });
  });


  unittest.group("resource-UrlResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.UrlResourceApi res = new api.UrlshortenerApi(mock).url;
      var arg_shortUrl = "foo";
      var arg_projection = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("urlshortener/v1/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 3), unittest.equals("url"));
        pathOffset += 3;

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
        unittest.expect(queryMap["shortUrl"].first, unittest.equals(arg_shortUrl));
        unittest.expect(queryMap["projection"].first, unittest.equals(arg_projection));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildUrl());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_shortUrl, projection: arg_projection).then(unittest.expectAsync(((api.Url response) {
        checkUrl(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.UrlResourceApi res = new api.UrlshortenerApi(mock).url;
      var arg_request = buildUrl();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Url.fromJson(json);
        checkUrl(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("urlshortener/v1/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 3), unittest.equals("url"));
        pathOffset += 3;

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
        var resp = convert.JSON.encode(buildUrl());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request).then(unittest.expectAsync(((api.Url response) {
        checkUrl(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.UrlResourceApi res = new api.UrlshortenerApi(mock).url;
      var arg_projection = "foo";
      var arg_start_token = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("urlshortener/v1/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("url/history"));
        pathOffset += 11;

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
        unittest.expect(queryMap["projection"].first, unittest.equals(arg_projection));
        unittest.expect(queryMap["start-token"].first, unittest.equals(arg_start_token));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildUrlHistory());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(projection: arg_projection, start_token: arg_start_token).then(unittest.expectAsync(((api.UrlHistory response) {
        checkUrlHistory(response);
      })));
    });

  });


}

