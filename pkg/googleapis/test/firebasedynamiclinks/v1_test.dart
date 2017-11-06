library googleapis.firebasedynamiclinks.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/firebasedynamiclinks/v1.dart' as api;

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

core.int buildCounterAnalyticsInfo = 0;
buildAnalyticsInfo() {
  var o = new api.AnalyticsInfo();
  buildCounterAnalyticsInfo++;
  if (buildCounterAnalyticsInfo < 3) {
    o.googlePlayAnalytics = buildGooglePlayAnalytics();
    o.itunesConnectAnalytics = buildITunesConnectAnalytics();
  }
  buildCounterAnalyticsInfo--;
  return o;
}

checkAnalyticsInfo(api.AnalyticsInfo o) {
  buildCounterAnalyticsInfo++;
  if (buildCounterAnalyticsInfo < 3) {
    checkGooglePlayAnalytics(o.googlePlayAnalytics);
    checkITunesConnectAnalytics(o.itunesConnectAnalytics);
  }
  buildCounterAnalyticsInfo--;
}

core.int buildCounterAndroidInfo = 0;
buildAndroidInfo() {
  var o = new api.AndroidInfo();
  buildCounterAndroidInfo++;
  if (buildCounterAndroidInfo < 3) {
    o.androidFallbackLink = "foo";
    o.androidLink = "foo";
    o.androidMinPackageVersionCode = "foo";
    o.androidPackageName = "foo";
  }
  buildCounterAndroidInfo--;
  return o;
}

checkAndroidInfo(api.AndroidInfo o) {
  buildCounterAndroidInfo++;
  if (buildCounterAndroidInfo < 3) {
    unittest.expect(o.androidFallbackLink, unittest.equals('foo'));
    unittest.expect(o.androidLink, unittest.equals('foo'));
    unittest.expect(o.androidMinPackageVersionCode, unittest.equals('foo'));
    unittest.expect(o.androidPackageName, unittest.equals('foo'));
  }
  buildCounterAndroidInfo--;
}

core.int buildCounterCreateShortDynamicLinkRequest = 0;
buildCreateShortDynamicLinkRequest() {
  var o = new api.CreateShortDynamicLinkRequest();
  buildCounterCreateShortDynamicLinkRequest++;
  if (buildCounterCreateShortDynamicLinkRequest < 3) {
    o.dynamicLinkInfo = buildDynamicLinkInfo();
    o.longDynamicLink = "foo";
    o.suffix = buildSuffix();
  }
  buildCounterCreateShortDynamicLinkRequest--;
  return o;
}

checkCreateShortDynamicLinkRequest(api.CreateShortDynamicLinkRequest o) {
  buildCounterCreateShortDynamicLinkRequest++;
  if (buildCounterCreateShortDynamicLinkRequest < 3) {
    checkDynamicLinkInfo(o.dynamicLinkInfo);
    unittest.expect(o.longDynamicLink, unittest.equals('foo'));
    checkSuffix(o.suffix);
  }
  buildCounterCreateShortDynamicLinkRequest--;
}

buildUnnamed1856() {
  var o = new core.List<api.DynamicLinkWarning>();
  o.add(buildDynamicLinkWarning());
  o.add(buildDynamicLinkWarning());
  return o;
}

checkUnnamed1856(core.List<api.DynamicLinkWarning> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDynamicLinkWarning(o[0]);
  checkDynamicLinkWarning(o[1]);
}

core.int buildCounterCreateShortDynamicLinkResponse = 0;
buildCreateShortDynamicLinkResponse() {
  var o = new api.CreateShortDynamicLinkResponse();
  buildCounterCreateShortDynamicLinkResponse++;
  if (buildCounterCreateShortDynamicLinkResponse < 3) {
    o.previewLink = "foo";
    o.shortLink = "foo";
    o.warning = buildUnnamed1856();
  }
  buildCounterCreateShortDynamicLinkResponse--;
  return o;
}

checkCreateShortDynamicLinkResponse(api.CreateShortDynamicLinkResponse o) {
  buildCounterCreateShortDynamicLinkResponse++;
  if (buildCounterCreateShortDynamicLinkResponse < 3) {
    unittest.expect(o.previewLink, unittest.equals('foo'));
    unittest.expect(o.shortLink, unittest.equals('foo'));
    checkUnnamed1856(o.warning);
  }
  buildCounterCreateShortDynamicLinkResponse--;
}

core.int buildCounterDynamicLinkInfo = 0;
buildDynamicLinkInfo() {
  var o = new api.DynamicLinkInfo();
  buildCounterDynamicLinkInfo++;
  if (buildCounterDynamicLinkInfo < 3) {
    o.analyticsInfo = buildAnalyticsInfo();
    o.androidInfo = buildAndroidInfo();
    o.dynamicLinkDomain = "foo";
    o.iosInfo = buildIosInfo();
    o.link = "foo";
    o.socialMetaTagInfo = buildSocialMetaTagInfo();
  }
  buildCounterDynamicLinkInfo--;
  return o;
}

checkDynamicLinkInfo(api.DynamicLinkInfo o) {
  buildCounterDynamicLinkInfo++;
  if (buildCounterDynamicLinkInfo < 3) {
    checkAnalyticsInfo(o.analyticsInfo);
    checkAndroidInfo(o.androidInfo);
    unittest.expect(o.dynamicLinkDomain, unittest.equals('foo'));
    checkIosInfo(o.iosInfo);
    unittest.expect(o.link, unittest.equals('foo'));
    checkSocialMetaTagInfo(o.socialMetaTagInfo);
  }
  buildCounterDynamicLinkInfo--;
}

core.int buildCounterDynamicLinkWarning = 0;
buildDynamicLinkWarning() {
  var o = new api.DynamicLinkWarning();
  buildCounterDynamicLinkWarning++;
  if (buildCounterDynamicLinkWarning < 3) {
    o.warningCode = "foo";
    o.warningMessage = "foo";
  }
  buildCounterDynamicLinkWarning--;
  return o;
}

checkDynamicLinkWarning(api.DynamicLinkWarning o) {
  buildCounterDynamicLinkWarning++;
  if (buildCounterDynamicLinkWarning < 3) {
    unittest.expect(o.warningCode, unittest.equals('foo'));
    unittest.expect(o.warningMessage, unittest.equals('foo'));
  }
  buildCounterDynamicLinkWarning--;
}

core.int buildCounterGooglePlayAnalytics = 0;
buildGooglePlayAnalytics() {
  var o = new api.GooglePlayAnalytics();
  buildCounterGooglePlayAnalytics++;
  if (buildCounterGooglePlayAnalytics < 3) {
    o.gclid = "foo";
    o.utmCampaign = "foo";
    o.utmContent = "foo";
    o.utmMedium = "foo";
    o.utmSource = "foo";
    o.utmTerm = "foo";
  }
  buildCounterGooglePlayAnalytics--;
  return o;
}

checkGooglePlayAnalytics(api.GooglePlayAnalytics o) {
  buildCounterGooglePlayAnalytics++;
  if (buildCounterGooglePlayAnalytics < 3) {
    unittest.expect(o.gclid, unittest.equals('foo'));
    unittest.expect(o.utmCampaign, unittest.equals('foo'));
    unittest.expect(o.utmContent, unittest.equals('foo'));
    unittest.expect(o.utmMedium, unittest.equals('foo'));
    unittest.expect(o.utmSource, unittest.equals('foo'));
    unittest.expect(o.utmTerm, unittest.equals('foo'));
  }
  buildCounterGooglePlayAnalytics--;
}

core.int buildCounterITunesConnectAnalytics = 0;
buildITunesConnectAnalytics() {
  var o = new api.ITunesConnectAnalytics();
  buildCounterITunesConnectAnalytics++;
  if (buildCounterITunesConnectAnalytics < 3) {
    o.at = "foo";
    o.ct = "foo";
    o.mt = "foo";
    o.pt = "foo";
  }
  buildCounterITunesConnectAnalytics--;
  return o;
}

checkITunesConnectAnalytics(api.ITunesConnectAnalytics o) {
  buildCounterITunesConnectAnalytics++;
  if (buildCounterITunesConnectAnalytics < 3) {
    unittest.expect(o.at, unittest.equals('foo'));
    unittest.expect(o.ct, unittest.equals('foo'));
    unittest.expect(o.mt, unittest.equals('foo'));
    unittest.expect(o.pt, unittest.equals('foo'));
  }
  buildCounterITunesConnectAnalytics--;
}

core.int buildCounterIosInfo = 0;
buildIosInfo() {
  var o = new api.IosInfo();
  buildCounterIosInfo++;
  if (buildCounterIosInfo < 3) {
    o.iosAppStoreId = "foo";
    o.iosBundleId = "foo";
    o.iosCustomScheme = "foo";
    o.iosFallbackLink = "foo";
    o.iosIpadBundleId = "foo";
    o.iosIpadFallbackLink = "foo";
  }
  buildCounterIosInfo--;
  return o;
}

checkIosInfo(api.IosInfo o) {
  buildCounterIosInfo++;
  if (buildCounterIosInfo < 3) {
    unittest.expect(o.iosAppStoreId, unittest.equals('foo'));
    unittest.expect(o.iosBundleId, unittest.equals('foo'));
    unittest.expect(o.iosCustomScheme, unittest.equals('foo'));
    unittest.expect(o.iosFallbackLink, unittest.equals('foo'));
    unittest.expect(o.iosIpadBundleId, unittest.equals('foo'));
    unittest.expect(o.iosIpadFallbackLink, unittest.equals('foo'));
  }
  buildCounterIosInfo--;
}

core.int buildCounterSocialMetaTagInfo = 0;
buildSocialMetaTagInfo() {
  var o = new api.SocialMetaTagInfo();
  buildCounterSocialMetaTagInfo++;
  if (buildCounterSocialMetaTagInfo < 3) {
    o.socialDescription = "foo";
    o.socialImageLink = "foo";
    o.socialTitle = "foo";
  }
  buildCounterSocialMetaTagInfo--;
  return o;
}

checkSocialMetaTagInfo(api.SocialMetaTagInfo o) {
  buildCounterSocialMetaTagInfo++;
  if (buildCounterSocialMetaTagInfo < 3) {
    unittest.expect(o.socialDescription, unittest.equals('foo'));
    unittest.expect(o.socialImageLink, unittest.equals('foo'));
    unittest.expect(o.socialTitle, unittest.equals('foo'));
  }
  buildCounterSocialMetaTagInfo--;
}

core.int buildCounterSuffix = 0;
buildSuffix() {
  var o = new api.Suffix();
  buildCounterSuffix++;
  if (buildCounterSuffix < 3) {
    o.option = "foo";
  }
  buildCounterSuffix--;
  return o;
}

checkSuffix(api.Suffix o) {
  buildCounterSuffix++;
  if (buildCounterSuffix < 3) {
    unittest.expect(o.option, unittest.equals('foo'));
  }
  buildCounterSuffix--;
}


main() {
  unittest.group("obj-schema-AnalyticsInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyticsInfo();
      var od = new api.AnalyticsInfo.fromJson(o.toJson());
      checkAnalyticsInfo(od);
    });
  });


  unittest.group("obj-schema-AndroidInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildAndroidInfo();
      var od = new api.AndroidInfo.fromJson(o.toJson());
      checkAndroidInfo(od);
    });
  });


  unittest.group("obj-schema-CreateShortDynamicLinkRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateShortDynamicLinkRequest();
      var od = new api.CreateShortDynamicLinkRequest.fromJson(o.toJson());
      checkCreateShortDynamicLinkRequest(od);
    });
  });


  unittest.group("obj-schema-CreateShortDynamicLinkResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateShortDynamicLinkResponse();
      var od = new api.CreateShortDynamicLinkResponse.fromJson(o.toJson());
      checkCreateShortDynamicLinkResponse(od);
    });
  });


  unittest.group("obj-schema-DynamicLinkInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildDynamicLinkInfo();
      var od = new api.DynamicLinkInfo.fromJson(o.toJson());
      checkDynamicLinkInfo(od);
    });
  });


  unittest.group("obj-schema-DynamicLinkWarning", () {
    unittest.test("to-json--from-json", () {
      var o = buildDynamicLinkWarning();
      var od = new api.DynamicLinkWarning.fromJson(o.toJson());
      checkDynamicLinkWarning(od);
    });
  });


  unittest.group("obj-schema-GooglePlayAnalytics", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePlayAnalytics();
      var od = new api.GooglePlayAnalytics.fromJson(o.toJson());
      checkGooglePlayAnalytics(od);
    });
  });


  unittest.group("obj-schema-ITunesConnectAnalytics", () {
    unittest.test("to-json--from-json", () {
      var o = buildITunesConnectAnalytics();
      var od = new api.ITunesConnectAnalytics.fromJson(o.toJson());
      checkITunesConnectAnalytics(od);
    });
  });


  unittest.group("obj-schema-IosInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildIosInfo();
      var od = new api.IosInfo.fromJson(o.toJson());
      checkIosInfo(od);
    });
  });


  unittest.group("obj-schema-SocialMetaTagInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildSocialMetaTagInfo();
      var od = new api.SocialMetaTagInfo.fromJson(o.toJson());
      checkSocialMetaTagInfo(od);
    });
  });


  unittest.group("obj-schema-Suffix", () {
    unittest.test("to-json--from-json", () {
      var o = buildSuffix();
      var od = new api.Suffix.fromJson(o.toJson());
      checkSuffix(od);
    });
  });


  unittest.group("resource-ShortLinksResourceApi", () {
    unittest.test("method--create", () {

      var mock = new HttpServerMock();
      api.ShortLinksResourceApi res = new api.FirebasedynamiclinksApi(mock).shortLinks;
      var arg_request = buildCreateShortDynamicLinkRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.CreateShortDynamicLinkRequest.fromJson(json);
        checkCreateShortDynamicLinkRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("v1/shortLinks"));
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
        var resp = convert.JSON.encode(buildCreateShortDynamicLinkResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.create(arg_request).then(unittest.expectAsync(((api.CreateShortDynamicLinkResponse response) {
        checkCreateShortDynamicLinkResponse(response);
      })));
    });

  });


}

