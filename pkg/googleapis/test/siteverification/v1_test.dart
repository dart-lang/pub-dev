library googleapis.siteVerification.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/siteverification/v1.dart' as api;

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

core.int buildCounterSiteVerificationWebResourceGettokenRequestSite = 0;
buildSiteVerificationWebResourceGettokenRequestSite() {
  var o = new api.SiteVerificationWebResourceGettokenRequestSite();
  buildCounterSiteVerificationWebResourceGettokenRequestSite++;
  if (buildCounterSiteVerificationWebResourceGettokenRequestSite < 3) {
    o.identifier = "foo";
    o.type = "foo";
  }
  buildCounterSiteVerificationWebResourceGettokenRequestSite--;
  return o;
}

checkSiteVerificationWebResourceGettokenRequestSite(api.SiteVerificationWebResourceGettokenRequestSite o) {
  buildCounterSiteVerificationWebResourceGettokenRequestSite++;
  if (buildCounterSiteVerificationWebResourceGettokenRequestSite < 3) {
    unittest.expect(o.identifier, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterSiteVerificationWebResourceGettokenRequestSite--;
}

core.int buildCounterSiteVerificationWebResourceGettokenRequest = 0;
buildSiteVerificationWebResourceGettokenRequest() {
  var o = new api.SiteVerificationWebResourceGettokenRequest();
  buildCounterSiteVerificationWebResourceGettokenRequest++;
  if (buildCounterSiteVerificationWebResourceGettokenRequest < 3) {
    o.site = buildSiteVerificationWebResourceGettokenRequestSite();
    o.verificationMethod = "foo";
  }
  buildCounterSiteVerificationWebResourceGettokenRequest--;
  return o;
}

checkSiteVerificationWebResourceGettokenRequest(api.SiteVerificationWebResourceGettokenRequest o) {
  buildCounterSiteVerificationWebResourceGettokenRequest++;
  if (buildCounterSiteVerificationWebResourceGettokenRequest < 3) {
    checkSiteVerificationWebResourceGettokenRequestSite(o.site);
    unittest.expect(o.verificationMethod, unittest.equals('foo'));
  }
  buildCounterSiteVerificationWebResourceGettokenRequest--;
}

core.int buildCounterSiteVerificationWebResourceGettokenResponse = 0;
buildSiteVerificationWebResourceGettokenResponse() {
  var o = new api.SiteVerificationWebResourceGettokenResponse();
  buildCounterSiteVerificationWebResourceGettokenResponse++;
  if (buildCounterSiteVerificationWebResourceGettokenResponse < 3) {
    o.method = "foo";
    o.token = "foo";
  }
  buildCounterSiteVerificationWebResourceGettokenResponse--;
  return o;
}

checkSiteVerificationWebResourceGettokenResponse(api.SiteVerificationWebResourceGettokenResponse o) {
  buildCounterSiteVerificationWebResourceGettokenResponse++;
  if (buildCounterSiteVerificationWebResourceGettokenResponse < 3) {
    unittest.expect(o.method, unittest.equals('foo'));
    unittest.expect(o.token, unittest.equals('foo'));
  }
  buildCounterSiteVerificationWebResourceGettokenResponse--;
}

buildUnnamed90() {
  var o = new core.List<api.SiteVerificationWebResourceResource>();
  o.add(buildSiteVerificationWebResourceResource());
  o.add(buildSiteVerificationWebResourceResource());
  return o;
}

checkUnnamed90(core.List<api.SiteVerificationWebResourceResource> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSiteVerificationWebResourceResource(o[0]);
  checkSiteVerificationWebResourceResource(o[1]);
}

core.int buildCounterSiteVerificationWebResourceListResponse = 0;
buildSiteVerificationWebResourceListResponse() {
  var o = new api.SiteVerificationWebResourceListResponse();
  buildCounterSiteVerificationWebResourceListResponse++;
  if (buildCounterSiteVerificationWebResourceListResponse < 3) {
    o.items = buildUnnamed90();
  }
  buildCounterSiteVerificationWebResourceListResponse--;
  return o;
}

checkSiteVerificationWebResourceListResponse(api.SiteVerificationWebResourceListResponse o) {
  buildCounterSiteVerificationWebResourceListResponse++;
  if (buildCounterSiteVerificationWebResourceListResponse < 3) {
    checkUnnamed90(o.items);
  }
  buildCounterSiteVerificationWebResourceListResponse--;
}

buildUnnamed91() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed91(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterSiteVerificationWebResourceResourceSite = 0;
buildSiteVerificationWebResourceResourceSite() {
  var o = new api.SiteVerificationWebResourceResourceSite();
  buildCounterSiteVerificationWebResourceResourceSite++;
  if (buildCounterSiteVerificationWebResourceResourceSite < 3) {
    o.identifier = "foo";
    o.type = "foo";
  }
  buildCounterSiteVerificationWebResourceResourceSite--;
  return o;
}

checkSiteVerificationWebResourceResourceSite(api.SiteVerificationWebResourceResourceSite o) {
  buildCounterSiteVerificationWebResourceResourceSite++;
  if (buildCounterSiteVerificationWebResourceResourceSite < 3) {
    unittest.expect(o.identifier, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterSiteVerificationWebResourceResourceSite--;
}

core.int buildCounterSiteVerificationWebResourceResource = 0;
buildSiteVerificationWebResourceResource() {
  var o = new api.SiteVerificationWebResourceResource();
  buildCounterSiteVerificationWebResourceResource++;
  if (buildCounterSiteVerificationWebResourceResource < 3) {
    o.id = "foo";
    o.owners = buildUnnamed91();
    o.site = buildSiteVerificationWebResourceResourceSite();
  }
  buildCounterSiteVerificationWebResourceResource--;
  return o;
}

checkSiteVerificationWebResourceResource(api.SiteVerificationWebResourceResource o) {
  buildCounterSiteVerificationWebResourceResource++;
  if (buildCounterSiteVerificationWebResourceResource < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed91(o.owners);
    checkSiteVerificationWebResourceResourceSite(o.site);
  }
  buildCounterSiteVerificationWebResourceResource--;
}


main() {
  unittest.group("obj-schema-SiteVerificationWebResourceGettokenRequestSite", () {
    unittest.test("to-json--from-json", () {
      var o = buildSiteVerificationWebResourceGettokenRequestSite();
      var od = new api.SiteVerificationWebResourceGettokenRequestSite.fromJson(o.toJson());
      checkSiteVerificationWebResourceGettokenRequestSite(od);
    });
  });


  unittest.group("obj-schema-SiteVerificationWebResourceGettokenRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildSiteVerificationWebResourceGettokenRequest();
      var od = new api.SiteVerificationWebResourceGettokenRequest.fromJson(o.toJson());
      checkSiteVerificationWebResourceGettokenRequest(od);
    });
  });


  unittest.group("obj-schema-SiteVerificationWebResourceGettokenResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSiteVerificationWebResourceGettokenResponse();
      var od = new api.SiteVerificationWebResourceGettokenResponse.fromJson(o.toJson());
      checkSiteVerificationWebResourceGettokenResponse(od);
    });
  });


  unittest.group("obj-schema-SiteVerificationWebResourceListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSiteVerificationWebResourceListResponse();
      var od = new api.SiteVerificationWebResourceListResponse.fromJson(o.toJson());
      checkSiteVerificationWebResourceListResponse(od);
    });
  });


  unittest.group("obj-schema-SiteVerificationWebResourceResourceSite", () {
    unittest.test("to-json--from-json", () {
      var o = buildSiteVerificationWebResourceResourceSite();
      var od = new api.SiteVerificationWebResourceResourceSite.fromJson(o.toJson());
      checkSiteVerificationWebResourceResourceSite(od);
    });
  });


  unittest.group("obj-schema-SiteVerificationWebResourceResource", () {
    unittest.test("to-json--from-json", () {
      var o = buildSiteVerificationWebResourceResource();
      var od = new api.SiteVerificationWebResourceResource.fromJson(o.toJson());
      checkSiteVerificationWebResourceResource(od);
    });
  });


  unittest.group("resource-WebResourceResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.WebResourceResourceApi res = new api.SiteVerificationApi(mock).webResource;
      var arg_id = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 20), unittest.equals("siteVerification/v1/"));
        pathOffset += 20;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("webResource/"));
        pathOffset += 12;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_id"));

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
      res.delete(arg_id).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.WebResourceResourceApi res = new api.SiteVerificationApi(mock).webResource;
      var arg_id = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 20), unittest.equals("siteVerification/v1/"));
        pathOffset += 20;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("webResource/"));
        pathOffset += 12;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_id"));

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
        var resp = convert.JSON.encode(buildSiteVerificationWebResourceResource());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_id).then(unittest.expectAsync(((api.SiteVerificationWebResourceResource response) {
        checkSiteVerificationWebResourceResource(response);
      })));
    });

    unittest.test("method--getToken", () {

      var mock = new HttpServerMock();
      api.WebResourceResourceApi res = new api.SiteVerificationApi(mock).webResource;
      var arg_request = buildSiteVerificationWebResourceGettokenRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.SiteVerificationWebResourceGettokenRequest.fromJson(json);
        checkSiteVerificationWebResourceGettokenRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 20), unittest.equals("siteVerification/v1/"));
        pathOffset += 20;
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("token"));
        pathOffset += 5;

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
        var resp = convert.JSON.encode(buildSiteVerificationWebResourceGettokenResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getToken(arg_request).then(unittest.expectAsync(((api.SiteVerificationWebResourceGettokenResponse response) {
        checkSiteVerificationWebResourceGettokenResponse(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.WebResourceResourceApi res = new api.SiteVerificationApi(mock).webResource;
      var arg_request = buildSiteVerificationWebResourceResource();
      var arg_verificationMethod = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.SiteVerificationWebResourceResource.fromJson(json);
        checkSiteVerificationWebResourceResource(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 20), unittest.equals("siteVerification/v1/"));
        pathOffset += 20;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("webResource"));
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
        unittest.expect(queryMap["verificationMethod"].first, unittest.equals(arg_verificationMethod));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSiteVerificationWebResourceResource());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_verificationMethod).then(unittest.expectAsync(((api.SiteVerificationWebResourceResource response) {
        checkSiteVerificationWebResourceResource(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.WebResourceResourceApi res = new api.SiteVerificationApi(mock).webResource;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 20), unittest.equals("siteVerification/v1/"));
        pathOffset += 20;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("webResource"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSiteVerificationWebResourceListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list().then(unittest.expectAsync(((api.SiteVerificationWebResourceListResponse response) {
        checkSiteVerificationWebResourceListResponse(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.WebResourceResourceApi res = new api.SiteVerificationApi(mock).webResource;
      var arg_request = buildSiteVerificationWebResourceResource();
      var arg_id = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.SiteVerificationWebResourceResource.fromJson(json);
        checkSiteVerificationWebResourceResource(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 20), unittest.equals("siteVerification/v1/"));
        pathOffset += 20;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("webResource/"));
        pathOffset += 12;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_id"));

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
        var resp = convert.JSON.encode(buildSiteVerificationWebResourceResource());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_id).then(unittest.expectAsync(((api.SiteVerificationWebResourceResource response) {
        checkSiteVerificationWebResourceResource(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.WebResourceResourceApi res = new api.SiteVerificationApi(mock).webResource;
      var arg_request = buildSiteVerificationWebResourceResource();
      var arg_id = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.SiteVerificationWebResourceResource.fromJson(json);
        checkSiteVerificationWebResourceResource(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 20), unittest.equals("siteVerification/v1/"));
        pathOffset += 20;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("webResource/"));
        pathOffset += 12;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_id"));

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
        var resp = convert.JSON.encode(buildSiteVerificationWebResourceResource());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_id).then(unittest.expectAsync(((api.SiteVerificationWebResourceResource response) {
        checkSiteVerificationWebResourceResource(response);
      })));
    });

  });


}

