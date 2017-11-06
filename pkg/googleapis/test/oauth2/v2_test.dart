library googleapis.oauth2.v2.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/oauth2/v2.dart' as api;

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

core.int buildCounterJwkKeys = 0;
buildJwkKeys() {
  var o = new api.JwkKeys();
  buildCounterJwkKeys++;
  if (buildCounterJwkKeys < 3) {
    o.alg = "foo";
    o.e = "foo";
    o.kid = "foo";
    o.kty = "foo";
    o.n = "foo";
    o.use = "foo";
  }
  buildCounterJwkKeys--;
  return o;
}

checkJwkKeys(api.JwkKeys o) {
  buildCounterJwkKeys++;
  if (buildCounterJwkKeys < 3) {
    unittest.expect(o.alg, unittest.equals('foo'));
    unittest.expect(o.e, unittest.equals('foo'));
    unittest.expect(o.kid, unittest.equals('foo'));
    unittest.expect(o.kty, unittest.equals('foo'));
    unittest.expect(o.n, unittest.equals('foo'));
    unittest.expect(o.use, unittest.equals('foo'));
  }
  buildCounterJwkKeys--;
}

buildUnnamed2697() {
  var o = new core.List<api.JwkKeys>();
  o.add(buildJwkKeys());
  o.add(buildJwkKeys());
  return o;
}

checkUnnamed2697(core.List<api.JwkKeys> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkJwkKeys(o[0]);
  checkJwkKeys(o[1]);
}

core.int buildCounterJwk = 0;
buildJwk() {
  var o = new api.Jwk();
  buildCounterJwk++;
  if (buildCounterJwk < 3) {
    o.keys = buildUnnamed2697();
  }
  buildCounterJwk--;
  return o;
}

checkJwk(api.Jwk o) {
  buildCounterJwk++;
  if (buildCounterJwk < 3) {
    checkUnnamed2697(o.keys);
  }
  buildCounterJwk--;
}

core.int buildCounterTokeninfo = 0;
buildTokeninfo() {
  var o = new api.Tokeninfo();
  buildCounterTokeninfo++;
  if (buildCounterTokeninfo < 3) {
    o.accessType = "foo";
    o.audience = "foo";
    o.email = "foo";
    o.expiresIn = 42;
    o.issuedTo = "foo";
    o.scope = "foo";
    o.tokenHandle = "foo";
    o.userId = "foo";
    o.verifiedEmail = true;
  }
  buildCounterTokeninfo--;
  return o;
}

checkTokeninfo(api.Tokeninfo o) {
  buildCounterTokeninfo++;
  if (buildCounterTokeninfo < 3) {
    unittest.expect(o.accessType, unittest.equals('foo'));
    unittest.expect(o.audience, unittest.equals('foo'));
    unittest.expect(o.email, unittest.equals('foo'));
    unittest.expect(o.expiresIn, unittest.equals(42));
    unittest.expect(o.issuedTo, unittest.equals('foo'));
    unittest.expect(o.scope, unittest.equals('foo'));
    unittest.expect(o.tokenHandle, unittest.equals('foo'));
    unittest.expect(o.userId, unittest.equals('foo'));
    unittest.expect(o.verifiedEmail, unittest.isTrue);
  }
  buildCounterTokeninfo--;
}

core.int buildCounterUserinfoplus = 0;
buildUserinfoplus() {
  var o = new api.Userinfoplus();
  buildCounterUserinfoplus++;
  if (buildCounterUserinfoplus < 3) {
    o.email = "foo";
    o.familyName = "foo";
    o.gender = "foo";
    o.givenName = "foo";
    o.hd = "foo";
    o.id = "foo";
    o.link = "foo";
    o.locale = "foo";
    o.name = "foo";
    o.picture = "foo";
    o.verifiedEmail = true;
  }
  buildCounterUserinfoplus--;
  return o;
}

checkUserinfoplus(api.Userinfoplus o) {
  buildCounterUserinfoplus++;
  if (buildCounterUserinfoplus < 3) {
    unittest.expect(o.email, unittest.equals('foo'));
    unittest.expect(o.familyName, unittest.equals('foo'));
    unittest.expect(o.gender, unittest.equals('foo'));
    unittest.expect(o.givenName, unittest.equals('foo'));
    unittest.expect(o.hd, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.link, unittest.equals('foo'));
    unittest.expect(o.locale, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.picture, unittest.equals('foo'));
    unittest.expect(o.verifiedEmail, unittest.isTrue);
  }
  buildCounterUserinfoplus--;
}


main() {
  unittest.group("obj-schema-JwkKeys", () {
    unittest.test("to-json--from-json", () {
      var o = buildJwkKeys();
      var od = new api.JwkKeys.fromJson(o.toJson());
      checkJwkKeys(od);
    });
  });


  unittest.group("obj-schema-Jwk", () {
    unittest.test("to-json--from-json", () {
      var o = buildJwk();
      var od = new api.Jwk.fromJson(o.toJson());
      checkJwk(od);
    });
  });


  unittest.group("obj-schema-Tokeninfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildTokeninfo();
      var od = new api.Tokeninfo.fromJson(o.toJson());
      checkTokeninfo(od);
    });
  });


  unittest.group("obj-schema-Userinfoplus", () {
    unittest.test("to-json--from-json", () {
      var o = buildUserinfoplus();
      var od = new api.Userinfoplus.fromJson(o.toJson());
      checkUserinfoplus(od);
    });
  });


  unittest.group("resource-Oauth2Api", () {
    unittest.test("method--getCertForOpenIdConnect", () {

      var mock = new HttpServerMock();
      api.Oauth2Api res = new api.Oauth2Api(mock);
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("oauth2/v2/certs"));
        pathOffset += 15;

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
        var resp = convert.JSON.encode(buildJwk());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getCertForOpenIdConnect().then(unittest.expectAsync(((api.Jwk response) {
        checkJwk(response);
      })));
    });

    unittest.test("method--tokeninfo", () {

      var mock = new HttpServerMock();
      api.Oauth2Api res = new api.Oauth2Api(mock);
      var arg_accessToken = "foo";
      var arg_idToken = "foo";
      var arg_tokenHandle = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 19), unittest.equals("oauth2/v2/tokeninfo"));
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
        unittest.expect(queryMap["access_token"].first, unittest.equals(arg_accessToken));
        unittest.expect(queryMap["id_token"].first, unittest.equals(arg_idToken));
        unittest.expect(queryMap["token_handle"].first, unittest.equals(arg_tokenHandle));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTokeninfo());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.tokeninfo(accessToken: arg_accessToken, idToken: arg_idToken, tokenHandle: arg_tokenHandle).then(unittest.expectAsync(((api.Tokeninfo response) {
        checkTokeninfo(response);
      })));
    });

  });


  unittest.group("resource-UserinfoResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.UserinfoResourceApi res = new api.Oauth2Api(mock).userinfo;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 18), unittest.equals("oauth2/v2/userinfo"));
        pathOffset += 18;

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
        var resp = convert.JSON.encode(buildUserinfoplus());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get().then(unittest.expectAsync(((api.Userinfoplus response) {
        checkUserinfoplus(response);
      })));
    });

  });


  unittest.group("resource-UserinfoV2MeResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.UserinfoV2MeResourceApi res = new api.Oauth2Api(mock).userinfo.v2.me;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("userinfo/v2/me"));
        pathOffset += 14;

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
        var resp = convert.JSON.encode(buildUserinfoplus());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get().then(unittest.expectAsync(((api.Userinfoplus response) {
        checkUserinfoplus(response);
      })));
    });

  });


}

