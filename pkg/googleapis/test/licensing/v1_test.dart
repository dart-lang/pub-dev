library googleapis.licensing.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/licensing/v1.dart' as api;

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

core.int buildCounterLicenseAssignment = 0;
buildLicenseAssignment() {
  var o = new api.LicenseAssignment();
  buildCounterLicenseAssignment++;
  if (buildCounterLicenseAssignment < 3) {
    o.etags = "foo";
    o.kind = "foo";
    o.productId = "foo";
    o.selfLink = "foo";
    o.skuId = "foo";
    o.userId = "foo";
  }
  buildCounterLicenseAssignment--;
  return o;
}

checkLicenseAssignment(api.LicenseAssignment o) {
  buildCounterLicenseAssignment++;
  if (buildCounterLicenseAssignment < 3) {
    unittest.expect(o.etags, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.productId, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.skuId, unittest.equals('foo'));
    unittest.expect(o.userId, unittest.equals('foo'));
  }
  buildCounterLicenseAssignment--;
}

core.int buildCounterLicenseAssignmentInsert = 0;
buildLicenseAssignmentInsert() {
  var o = new api.LicenseAssignmentInsert();
  buildCounterLicenseAssignmentInsert++;
  if (buildCounterLicenseAssignmentInsert < 3) {
    o.userId = "foo";
  }
  buildCounterLicenseAssignmentInsert--;
  return o;
}

checkLicenseAssignmentInsert(api.LicenseAssignmentInsert o) {
  buildCounterLicenseAssignmentInsert++;
  if (buildCounterLicenseAssignmentInsert < 3) {
    unittest.expect(o.userId, unittest.equals('foo'));
  }
  buildCounterLicenseAssignmentInsert--;
}

buildUnnamed1768() {
  var o = new core.List<api.LicenseAssignment>();
  o.add(buildLicenseAssignment());
  o.add(buildLicenseAssignment());
  return o;
}

checkUnnamed1768(core.List<api.LicenseAssignment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLicenseAssignment(o[0]);
  checkLicenseAssignment(o[1]);
}

core.int buildCounterLicenseAssignmentList = 0;
buildLicenseAssignmentList() {
  var o = new api.LicenseAssignmentList();
  buildCounterLicenseAssignmentList++;
  if (buildCounterLicenseAssignmentList < 3) {
    o.etag = "foo";
    o.items = buildUnnamed1768();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterLicenseAssignmentList--;
  return o;
}

checkLicenseAssignmentList(api.LicenseAssignmentList o) {
  buildCounterLicenseAssignmentList++;
  if (buildCounterLicenseAssignmentList < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed1768(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterLicenseAssignmentList--;
}


main() {
  unittest.group("obj-schema-LicenseAssignment", () {
    unittest.test("to-json--from-json", () {
      var o = buildLicenseAssignment();
      var od = new api.LicenseAssignment.fromJson(o.toJson());
      checkLicenseAssignment(od);
    });
  });


  unittest.group("obj-schema-LicenseAssignmentInsert", () {
    unittest.test("to-json--from-json", () {
      var o = buildLicenseAssignmentInsert();
      var od = new api.LicenseAssignmentInsert.fromJson(o.toJson());
      checkLicenseAssignmentInsert(od);
    });
  });


  unittest.group("obj-schema-LicenseAssignmentList", () {
    unittest.test("to-json--from-json", () {
      var o = buildLicenseAssignmentList();
      var od = new api.LicenseAssignmentList.fromJson(o.toJson());
      checkLicenseAssignmentList(od);
    });
  });


  unittest.group("resource-LicenseAssignmentsResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.LicenseAssignmentsResourceApi res = new api.LicensingApi(mock).licenseAssignments;
      var arg_productId = "foo";
      var arg_skuId = "foo";
      var arg_userId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
      res.delete(arg_productId, arg_skuId, arg_userId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.LicenseAssignmentsResourceApi res = new api.LicensingApi(mock).licenseAssignments;
      var arg_productId = "foo";
      var arg_skuId = "foo";
      var arg_userId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildLicenseAssignment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_productId, arg_skuId, arg_userId).then(unittest.expectAsync(((api.LicenseAssignment response) {
        checkLicenseAssignment(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.LicenseAssignmentsResourceApi res = new api.LicensingApi(mock).licenseAssignments;
      var arg_request = buildLicenseAssignmentInsert();
      var arg_productId = "foo";
      var arg_skuId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.LicenseAssignmentInsert.fromJson(json);
        checkLicenseAssignmentInsert(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildLicenseAssignment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_productId, arg_skuId).then(unittest.expectAsync(((api.LicenseAssignment response) {
        checkLicenseAssignment(response);
      })));
    });

    unittest.test("method--listForProduct", () {

      var mock = new HttpServerMock();
      api.LicenseAssignmentsResourceApi res = new api.LicensingApi(mock).licenseAssignments;
      var arg_productId = "foo";
      var arg_customerId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["customerId"].first, unittest.equals(arg_customerId));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildLicenseAssignmentList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.listForProduct(arg_productId, arg_customerId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.LicenseAssignmentList response) {
        checkLicenseAssignmentList(response);
      })));
    });

    unittest.test("method--listForProductAndSku", () {

      var mock = new HttpServerMock();
      api.LicenseAssignmentsResourceApi res = new api.LicensingApi(mock).licenseAssignments;
      var arg_productId = "foo";
      var arg_skuId = "foo";
      var arg_customerId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["customerId"].first, unittest.equals(arg_customerId));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildLicenseAssignmentList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.listForProductAndSku(arg_productId, arg_skuId, arg_customerId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.LicenseAssignmentList response) {
        checkLicenseAssignmentList(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.LicenseAssignmentsResourceApi res = new api.LicensingApi(mock).licenseAssignments;
      var arg_request = buildLicenseAssignment();
      var arg_productId = "foo";
      var arg_skuId = "foo";
      var arg_userId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.LicenseAssignment.fromJson(json);
        checkLicenseAssignment(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildLicenseAssignment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_productId, arg_skuId, arg_userId).then(unittest.expectAsync(((api.LicenseAssignment response) {
        checkLicenseAssignment(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.LicenseAssignmentsResourceApi res = new api.LicensingApi(mock).licenseAssignments;
      var arg_request = buildLicenseAssignment();
      var arg_productId = "foo";
      var arg_skuId = "foo";
      var arg_userId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.LicenseAssignment.fromJson(json);
        checkLicenseAssignment(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildLicenseAssignment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_productId, arg_skuId, arg_userId).then(unittest.expectAsync(((api.LicenseAssignment response) {
        checkLicenseAssignment(response);
      })));
    });

  });


}

