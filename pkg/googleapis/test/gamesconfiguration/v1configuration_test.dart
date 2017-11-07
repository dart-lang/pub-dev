library googleapis.gamesConfiguration.v1configuration.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/gamesconfiguration/v1configuration.dart' as api;

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

core.int buildCounterAchievementConfiguration = 0;
buildAchievementConfiguration() {
  var o = new api.AchievementConfiguration();
  buildCounterAchievementConfiguration++;
  if (buildCounterAchievementConfiguration < 3) {
    o.achievementType = "foo";
    o.draft = buildAchievementConfigurationDetail();
    o.id = "foo";
    o.initialState = "foo";
    o.kind = "foo";
    o.published = buildAchievementConfigurationDetail();
    o.stepsToUnlock = 42;
    o.token = "foo";
  }
  buildCounterAchievementConfiguration--;
  return o;
}

checkAchievementConfiguration(api.AchievementConfiguration o) {
  buildCounterAchievementConfiguration++;
  if (buildCounterAchievementConfiguration < 3) {
    unittest.expect(o.achievementType, unittest.equals('foo'));
    checkAchievementConfigurationDetail(o.draft);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.initialState, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkAchievementConfigurationDetail(o.published);
    unittest.expect(o.stepsToUnlock, unittest.equals(42));
    unittest.expect(o.token, unittest.equals('foo'));
  }
  buildCounterAchievementConfiguration--;
}

core.int buildCounterAchievementConfigurationDetail = 0;
buildAchievementConfigurationDetail() {
  var o = new api.AchievementConfigurationDetail();
  buildCounterAchievementConfigurationDetail++;
  if (buildCounterAchievementConfigurationDetail < 3) {
    o.description = buildLocalizedStringBundle();
    o.iconUrl = "foo";
    o.kind = "foo";
    o.name = buildLocalizedStringBundle();
    o.pointValue = 42;
    o.sortRank = 42;
  }
  buildCounterAchievementConfigurationDetail--;
  return o;
}

checkAchievementConfigurationDetail(api.AchievementConfigurationDetail o) {
  buildCounterAchievementConfigurationDetail++;
  if (buildCounterAchievementConfigurationDetail < 3) {
    checkLocalizedStringBundle(o.description);
    unittest.expect(o.iconUrl, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkLocalizedStringBundle(o.name);
    unittest.expect(o.pointValue, unittest.equals(42));
    unittest.expect(o.sortRank, unittest.equals(42));
  }
  buildCounterAchievementConfigurationDetail--;
}

buildUnnamed661() {
  var o = new core.List<api.AchievementConfiguration>();
  o.add(buildAchievementConfiguration());
  o.add(buildAchievementConfiguration());
  return o;
}

checkUnnamed661(core.List<api.AchievementConfiguration> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAchievementConfiguration(o[0]);
  checkAchievementConfiguration(o[1]);
}

core.int buildCounterAchievementConfigurationListResponse = 0;
buildAchievementConfigurationListResponse() {
  var o = new api.AchievementConfigurationListResponse();
  buildCounterAchievementConfigurationListResponse++;
  if (buildCounterAchievementConfigurationListResponse < 3) {
    o.items = buildUnnamed661();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterAchievementConfigurationListResponse--;
  return o;
}

checkAchievementConfigurationListResponse(api.AchievementConfigurationListResponse o) {
  buildCounterAchievementConfigurationListResponse++;
  if (buildCounterAchievementConfigurationListResponse < 3) {
    checkUnnamed661(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterAchievementConfigurationListResponse--;
}

core.int buildCounterGamesNumberAffixConfiguration = 0;
buildGamesNumberAffixConfiguration() {
  var o = new api.GamesNumberAffixConfiguration();
  buildCounterGamesNumberAffixConfiguration++;
  if (buildCounterGamesNumberAffixConfiguration < 3) {
    o.few = buildLocalizedStringBundle();
    o.many = buildLocalizedStringBundle();
    o.one = buildLocalizedStringBundle();
    o.other = buildLocalizedStringBundle();
    o.two = buildLocalizedStringBundle();
    o.zero = buildLocalizedStringBundle();
  }
  buildCounterGamesNumberAffixConfiguration--;
  return o;
}

checkGamesNumberAffixConfiguration(api.GamesNumberAffixConfiguration o) {
  buildCounterGamesNumberAffixConfiguration++;
  if (buildCounterGamesNumberAffixConfiguration < 3) {
    checkLocalizedStringBundle(o.few);
    checkLocalizedStringBundle(o.many);
    checkLocalizedStringBundle(o.one);
    checkLocalizedStringBundle(o.other);
    checkLocalizedStringBundle(o.two);
    checkLocalizedStringBundle(o.zero);
  }
  buildCounterGamesNumberAffixConfiguration--;
}

core.int buildCounterGamesNumberFormatConfiguration = 0;
buildGamesNumberFormatConfiguration() {
  var o = new api.GamesNumberFormatConfiguration();
  buildCounterGamesNumberFormatConfiguration++;
  if (buildCounterGamesNumberFormatConfiguration < 3) {
    o.currencyCode = "foo";
    o.numDecimalPlaces = 42;
    o.numberFormatType = "foo";
    o.suffix = buildGamesNumberAffixConfiguration();
  }
  buildCounterGamesNumberFormatConfiguration--;
  return o;
}

checkGamesNumberFormatConfiguration(api.GamesNumberFormatConfiguration o) {
  buildCounterGamesNumberFormatConfiguration++;
  if (buildCounterGamesNumberFormatConfiguration < 3) {
    unittest.expect(o.currencyCode, unittest.equals('foo'));
    unittest.expect(o.numDecimalPlaces, unittest.equals(42));
    unittest.expect(o.numberFormatType, unittest.equals('foo'));
    checkGamesNumberAffixConfiguration(o.suffix);
  }
  buildCounterGamesNumberFormatConfiguration--;
}

core.int buildCounterImageConfiguration = 0;
buildImageConfiguration() {
  var o = new api.ImageConfiguration();
  buildCounterImageConfiguration++;
  if (buildCounterImageConfiguration < 3) {
    o.imageType = "foo";
    o.kind = "foo";
    o.resourceId = "foo";
    o.url = "foo";
  }
  buildCounterImageConfiguration--;
  return o;
}

checkImageConfiguration(api.ImageConfiguration o) {
  buildCounterImageConfiguration++;
  if (buildCounterImageConfiguration < 3) {
    unittest.expect(o.imageType, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.resourceId, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterImageConfiguration--;
}

core.int buildCounterLeaderboardConfiguration = 0;
buildLeaderboardConfiguration() {
  var o = new api.LeaderboardConfiguration();
  buildCounterLeaderboardConfiguration++;
  if (buildCounterLeaderboardConfiguration < 3) {
    o.draft = buildLeaderboardConfigurationDetail();
    o.id = "foo";
    o.kind = "foo";
    o.published = buildLeaderboardConfigurationDetail();
    o.scoreMax = "foo";
    o.scoreMin = "foo";
    o.scoreOrder = "foo";
    o.token = "foo";
  }
  buildCounterLeaderboardConfiguration--;
  return o;
}

checkLeaderboardConfiguration(api.LeaderboardConfiguration o) {
  buildCounterLeaderboardConfiguration++;
  if (buildCounterLeaderboardConfiguration < 3) {
    checkLeaderboardConfigurationDetail(o.draft);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkLeaderboardConfigurationDetail(o.published);
    unittest.expect(o.scoreMax, unittest.equals('foo'));
    unittest.expect(o.scoreMin, unittest.equals('foo'));
    unittest.expect(o.scoreOrder, unittest.equals('foo'));
    unittest.expect(o.token, unittest.equals('foo'));
  }
  buildCounterLeaderboardConfiguration--;
}

core.int buildCounterLeaderboardConfigurationDetail = 0;
buildLeaderboardConfigurationDetail() {
  var o = new api.LeaderboardConfigurationDetail();
  buildCounterLeaderboardConfigurationDetail++;
  if (buildCounterLeaderboardConfigurationDetail < 3) {
    o.iconUrl = "foo";
    o.kind = "foo";
    o.name = buildLocalizedStringBundle();
    o.scoreFormat = buildGamesNumberFormatConfiguration();
    o.sortRank = 42;
  }
  buildCounterLeaderboardConfigurationDetail--;
  return o;
}

checkLeaderboardConfigurationDetail(api.LeaderboardConfigurationDetail o) {
  buildCounterLeaderboardConfigurationDetail++;
  if (buildCounterLeaderboardConfigurationDetail < 3) {
    unittest.expect(o.iconUrl, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkLocalizedStringBundle(o.name);
    checkGamesNumberFormatConfiguration(o.scoreFormat);
    unittest.expect(o.sortRank, unittest.equals(42));
  }
  buildCounterLeaderboardConfigurationDetail--;
}

buildUnnamed662() {
  var o = new core.List<api.LeaderboardConfiguration>();
  o.add(buildLeaderboardConfiguration());
  o.add(buildLeaderboardConfiguration());
  return o;
}

checkUnnamed662(core.List<api.LeaderboardConfiguration> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLeaderboardConfiguration(o[0]);
  checkLeaderboardConfiguration(o[1]);
}

core.int buildCounterLeaderboardConfigurationListResponse = 0;
buildLeaderboardConfigurationListResponse() {
  var o = new api.LeaderboardConfigurationListResponse();
  buildCounterLeaderboardConfigurationListResponse++;
  if (buildCounterLeaderboardConfigurationListResponse < 3) {
    o.items = buildUnnamed662();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterLeaderboardConfigurationListResponse--;
  return o;
}

checkLeaderboardConfigurationListResponse(api.LeaderboardConfigurationListResponse o) {
  buildCounterLeaderboardConfigurationListResponse++;
  if (buildCounterLeaderboardConfigurationListResponse < 3) {
    checkUnnamed662(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterLeaderboardConfigurationListResponse--;
}

core.int buildCounterLocalizedString = 0;
buildLocalizedString() {
  var o = new api.LocalizedString();
  buildCounterLocalizedString++;
  if (buildCounterLocalizedString < 3) {
    o.kind = "foo";
    o.locale = "foo";
    o.value = "foo";
  }
  buildCounterLocalizedString--;
  return o;
}

checkLocalizedString(api.LocalizedString o) {
  buildCounterLocalizedString++;
  if (buildCounterLocalizedString < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.locale, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterLocalizedString--;
}

buildUnnamed663() {
  var o = new core.List<api.LocalizedString>();
  o.add(buildLocalizedString());
  o.add(buildLocalizedString());
  return o;
}

checkUnnamed663(core.List<api.LocalizedString> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLocalizedString(o[0]);
  checkLocalizedString(o[1]);
}

core.int buildCounterLocalizedStringBundle = 0;
buildLocalizedStringBundle() {
  var o = new api.LocalizedStringBundle();
  buildCounterLocalizedStringBundle++;
  if (buildCounterLocalizedStringBundle < 3) {
    o.kind = "foo";
    o.translations = buildUnnamed663();
  }
  buildCounterLocalizedStringBundle--;
  return o;
}

checkLocalizedStringBundle(api.LocalizedStringBundle o) {
  buildCounterLocalizedStringBundle++;
  if (buildCounterLocalizedStringBundle < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed663(o.translations);
  }
  buildCounterLocalizedStringBundle--;
}


main() {
  unittest.group("obj-schema-AchievementConfiguration", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementConfiguration();
      var od = new api.AchievementConfiguration.fromJson(o.toJson());
      checkAchievementConfiguration(od);
    });
  });


  unittest.group("obj-schema-AchievementConfigurationDetail", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementConfigurationDetail();
      var od = new api.AchievementConfigurationDetail.fromJson(o.toJson());
      checkAchievementConfigurationDetail(od);
    });
  });


  unittest.group("obj-schema-AchievementConfigurationListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementConfigurationListResponse();
      var od = new api.AchievementConfigurationListResponse.fromJson(o.toJson());
      checkAchievementConfigurationListResponse(od);
    });
  });


  unittest.group("obj-schema-GamesNumberAffixConfiguration", () {
    unittest.test("to-json--from-json", () {
      var o = buildGamesNumberAffixConfiguration();
      var od = new api.GamesNumberAffixConfiguration.fromJson(o.toJson());
      checkGamesNumberAffixConfiguration(od);
    });
  });


  unittest.group("obj-schema-GamesNumberFormatConfiguration", () {
    unittest.test("to-json--from-json", () {
      var o = buildGamesNumberFormatConfiguration();
      var od = new api.GamesNumberFormatConfiguration.fromJson(o.toJson());
      checkGamesNumberFormatConfiguration(od);
    });
  });


  unittest.group("obj-schema-ImageConfiguration", () {
    unittest.test("to-json--from-json", () {
      var o = buildImageConfiguration();
      var od = new api.ImageConfiguration.fromJson(o.toJson());
      checkImageConfiguration(od);
    });
  });


  unittest.group("obj-schema-LeaderboardConfiguration", () {
    unittest.test("to-json--from-json", () {
      var o = buildLeaderboardConfiguration();
      var od = new api.LeaderboardConfiguration.fromJson(o.toJson());
      checkLeaderboardConfiguration(od);
    });
  });


  unittest.group("obj-schema-LeaderboardConfigurationDetail", () {
    unittest.test("to-json--from-json", () {
      var o = buildLeaderboardConfigurationDetail();
      var od = new api.LeaderboardConfigurationDetail.fromJson(o.toJson());
      checkLeaderboardConfigurationDetail(od);
    });
  });


  unittest.group("obj-schema-LeaderboardConfigurationListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildLeaderboardConfigurationListResponse();
      var od = new api.LeaderboardConfigurationListResponse.fromJson(o.toJson());
      checkLeaderboardConfigurationListResponse(od);
    });
  });


  unittest.group("obj-schema-LocalizedString", () {
    unittest.test("to-json--from-json", () {
      var o = buildLocalizedString();
      var od = new api.LocalizedString.fromJson(o.toJson());
      checkLocalizedString(od);
    });
  });


  unittest.group("obj-schema-LocalizedStringBundle", () {
    unittest.test("to-json--from-json", () {
      var o = buildLocalizedStringBundle();
      var od = new api.LocalizedStringBundle.fromJson(o.toJson());
      checkLocalizedStringBundle(od);
    });
  });


  unittest.group("resource-AchievementConfigurationsResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.AchievementConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).achievementConfigurations;
      var arg_achievementId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("achievements/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_achievementId"));

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
      res.delete(arg_achievementId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.AchievementConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).achievementConfigurations;
      var arg_achievementId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("achievements/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_achievementId"));

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
        var resp = convert.JSON.encode(buildAchievementConfiguration());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_achievementId).then(unittest.expectAsync(((api.AchievementConfiguration response) {
        checkAchievementConfiguration(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.AchievementConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).achievementConfigurations;
      var arg_request = buildAchievementConfiguration();
      var arg_applicationId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AchievementConfiguration.fromJson(json);
        checkAchievementConfiguration(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("applications/"));
        pathOffset += 13;
        index = path.indexOf("/achievements", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_applicationId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/achievements"));
        pathOffset += 13;

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
        var resp = convert.JSON.encode(buildAchievementConfiguration());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_applicationId).then(unittest.expectAsync(((api.AchievementConfiguration response) {
        checkAchievementConfiguration(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.AchievementConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).achievementConfigurations;
      var arg_applicationId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("applications/"));
        pathOffset += 13;
        index = path.indexOf("/achievements", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_applicationId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/achievements"));
        pathOffset += 13;

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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAchievementConfigurationListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_applicationId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.AchievementConfigurationListResponse response) {
        checkAchievementConfigurationListResponse(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.AchievementConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).achievementConfigurations;
      var arg_request = buildAchievementConfiguration();
      var arg_achievementId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AchievementConfiguration.fromJson(json);
        checkAchievementConfiguration(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("achievements/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_achievementId"));

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
        var resp = convert.JSON.encode(buildAchievementConfiguration());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_achievementId).then(unittest.expectAsync(((api.AchievementConfiguration response) {
        checkAchievementConfiguration(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.AchievementConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).achievementConfigurations;
      var arg_request = buildAchievementConfiguration();
      var arg_achievementId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AchievementConfiguration.fromJson(json);
        checkAchievementConfiguration(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("achievements/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_achievementId"));

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
        var resp = convert.JSON.encode(buildAchievementConfiguration());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_achievementId).then(unittest.expectAsync(((api.AchievementConfiguration response) {
        checkAchievementConfiguration(response);
      })));
    });

  });


  unittest.group("resource-ImageConfigurationsResourceApi", () {
    unittest.test("method--upload", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.ImageConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).imageConfigurations;
      var arg_resourceId = "foo";
      var arg_imageType = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("images/"));
        pathOffset += 7;
        index = path.indexOf("/imageType/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_resourceId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("/imageType/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_imageType"));

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
        var resp = convert.JSON.encode(buildImageConfiguration());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.upload(arg_resourceId, arg_imageType).then(unittest.expectAsync(((api.ImageConfiguration response) {
        checkImageConfiguration(response);
      })));
    });

  });


  unittest.group("resource-LeaderboardConfigurationsResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.LeaderboardConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).leaderboardConfigurations;
      var arg_leaderboardId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("leaderboards/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_leaderboardId"));

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
      res.delete(arg_leaderboardId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.LeaderboardConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).leaderboardConfigurations;
      var arg_leaderboardId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("leaderboards/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_leaderboardId"));

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
        var resp = convert.JSON.encode(buildLeaderboardConfiguration());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_leaderboardId).then(unittest.expectAsync(((api.LeaderboardConfiguration response) {
        checkLeaderboardConfiguration(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.LeaderboardConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).leaderboardConfigurations;
      var arg_request = buildLeaderboardConfiguration();
      var arg_applicationId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.LeaderboardConfiguration.fromJson(json);
        checkLeaderboardConfiguration(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("applications/"));
        pathOffset += 13;
        index = path.indexOf("/leaderboards", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_applicationId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/leaderboards"));
        pathOffset += 13;

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
        var resp = convert.JSON.encode(buildLeaderboardConfiguration());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_applicationId).then(unittest.expectAsync(((api.LeaderboardConfiguration response) {
        checkLeaderboardConfiguration(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.LeaderboardConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).leaderboardConfigurations;
      var arg_applicationId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("applications/"));
        pathOffset += 13;
        index = path.indexOf("/leaderboards", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_applicationId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/leaderboards"));
        pathOffset += 13;

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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildLeaderboardConfigurationListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_applicationId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.LeaderboardConfigurationListResponse response) {
        checkLeaderboardConfigurationListResponse(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.LeaderboardConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).leaderboardConfigurations;
      var arg_request = buildLeaderboardConfiguration();
      var arg_leaderboardId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.LeaderboardConfiguration.fromJson(json);
        checkLeaderboardConfiguration(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("leaderboards/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_leaderboardId"));

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
        var resp = convert.JSON.encode(buildLeaderboardConfiguration());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_leaderboardId).then(unittest.expectAsync(((api.LeaderboardConfiguration response) {
        checkLeaderboardConfiguration(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.LeaderboardConfigurationsResourceApi res = new api.GamesConfigurationApi(mock).leaderboardConfigurations;
      var arg_request = buildLeaderboardConfiguration();
      var arg_leaderboardId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.LeaderboardConfiguration.fromJson(json);
        checkLeaderboardConfiguration(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("games/v1configuration/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("leaderboards/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_leaderboardId"));

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
        var resp = convert.JSON.encode(buildLeaderboardConfiguration());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_leaderboardId).then(unittest.expectAsync(((api.LeaderboardConfiguration response) {
        checkLeaderboardConfiguration(response);
      })));
    });

  });


}

