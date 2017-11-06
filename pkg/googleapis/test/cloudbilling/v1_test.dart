library googleapis.cloudbilling.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/cloudbilling/v1.dart' as api;

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

core.int buildCounterBillingAccount = 0;
buildBillingAccount() {
  var o = new api.BillingAccount();
  buildCounterBillingAccount++;
  if (buildCounterBillingAccount < 3) {
    o.displayName = "foo";
    o.name = "foo";
    o.open = true;
  }
  buildCounterBillingAccount--;
  return o;
}

checkBillingAccount(api.BillingAccount o) {
  buildCounterBillingAccount++;
  if (buildCounterBillingAccount < 3) {
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.open, unittest.isTrue);
  }
  buildCounterBillingAccount--;
}

buildUnnamed19() {
  var o = new core.List<api.BillingAccount>();
  o.add(buildBillingAccount());
  o.add(buildBillingAccount());
  return o;
}

checkUnnamed19(core.List<api.BillingAccount> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBillingAccount(o[0]);
  checkBillingAccount(o[1]);
}

core.int buildCounterListBillingAccountsResponse = 0;
buildListBillingAccountsResponse() {
  var o = new api.ListBillingAccountsResponse();
  buildCounterListBillingAccountsResponse++;
  if (buildCounterListBillingAccountsResponse < 3) {
    o.billingAccounts = buildUnnamed19();
    o.nextPageToken = "foo";
  }
  buildCounterListBillingAccountsResponse--;
  return o;
}

checkListBillingAccountsResponse(api.ListBillingAccountsResponse o) {
  buildCounterListBillingAccountsResponse++;
  if (buildCounterListBillingAccountsResponse < 3) {
    checkUnnamed19(o.billingAccounts);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListBillingAccountsResponse--;
}

buildUnnamed20() {
  var o = new core.List<api.ProjectBillingInfo>();
  o.add(buildProjectBillingInfo());
  o.add(buildProjectBillingInfo());
  return o;
}

checkUnnamed20(core.List<api.ProjectBillingInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProjectBillingInfo(o[0]);
  checkProjectBillingInfo(o[1]);
}

core.int buildCounterListProjectBillingInfoResponse = 0;
buildListProjectBillingInfoResponse() {
  var o = new api.ListProjectBillingInfoResponse();
  buildCounterListProjectBillingInfoResponse++;
  if (buildCounterListProjectBillingInfoResponse < 3) {
    o.nextPageToken = "foo";
    o.projectBillingInfo = buildUnnamed20();
  }
  buildCounterListProjectBillingInfoResponse--;
  return o;
}

checkListProjectBillingInfoResponse(api.ListProjectBillingInfoResponse o) {
  buildCounterListProjectBillingInfoResponse++;
  if (buildCounterListProjectBillingInfoResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed20(o.projectBillingInfo);
  }
  buildCounterListProjectBillingInfoResponse--;
}

core.int buildCounterProjectBillingInfo = 0;
buildProjectBillingInfo() {
  var o = new api.ProjectBillingInfo();
  buildCounterProjectBillingInfo++;
  if (buildCounterProjectBillingInfo < 3) {
    o.billingAccountName = "foo";
    o.billingEnabled = true;
    o.name = "foo";
    o.projectId = "foo";
  }
  buildCounterProjectBillingInfo--;
  return o;
}

checkProjectBillingInfo(api.ProjectBillingInfo o) {
  buildCounterProjectBillingInfo++;
  if (buildCounterProjectBillingInfo < 3) {
    unittest.expect(o.billingAccountName, unittest.equals('foo'));
    unittest.expect(o.billingEnabled, unittest.isTrue);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.projectId, unittest.equals('foo'));
  }
  buildCounterProjectBillingInfo--;
}


main() {
  unittest.group("obj-schema-BillingAccount", () {
    unittest.test("to-json--from-json", () {
      var o = buildBillingAccount();
      var od = new api.BillingAccount.fromJson(o.toJson());
      checkBillingAccount(od);
    });
  });


  unittest.group("obj-schema-ListBillingAccountsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListBillingAccountsResponse();
      var od = new api.ListBillingAccountsResponse.fromJson(o.toJson());
      checkListBillingAccountsResponse(od);
    });
  });


  unittest.group("obj-schema-ListProjectBillingInfoResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListProjectBillingInfoResponse();
      var od = new api.ListProjectBillingInfoResponse.fromJson(o.toJson());
      checkListProjectBillingInfoResponse(od);
    });
  });


  unittest.group("obj-schema-ProjectBillingInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildProjectBillingInfo();
      var od = new api.ProjectBillingInfo.fromJson(o.toJson());
      checkProjectBillingInfo(od);
    });
  });


  unittest.group("resource-BillingAccountsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.BillingAccountsResourceApi res = new api.CloudbillingApi(mock).billingAccounts;
      var arg_name = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

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
        var resp = convert.JSON.encode(buildBillingAccount());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_name).then(unittest.expectAsync(((api.BillingAccount response) {
        checkBillingAccount(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.BillingAccountsResourceApi res = new api.CloudbillingApi(mock).billingAccounts;
      var arg_pageSize = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 18), unittest.equals("v1/billingAccounts"));
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
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListBillingAccountsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(pageSize: arg_pageSize, pageToken: arg_pageToken).then(unittest.expectAsync(((api.ListBillingAccountsResponse response) {
        checkListBillingAccountsResponse(response);
      })));
    });

  });


  unittest.group("resource-BillingAccountsProjectsResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.BillingAccountsProjectsResourceApi res = new api.CloudbillingApi(mock).billingAccounts.projects;
      var arg_name = "foo";
      var arg_pageSize = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

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
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListProjectBillingInfoResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_name, pageSize: arg_pageSize, pageToken: arg_pageToken).then(unittest.expectAsync(((api.ListProjectBillingInfoResponse response) {
        checkListProjectBillingInfoResponse(response);
      })));
    });

  });


  unittest.group("resource-ProjectsResourceApi", () {
    unittest.test("method--getBillingInfo", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudbillingApi(mock).projects;
      var arg_name = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

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
        var resp = convert.JSON.encode(buildProjectBillingInfo());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getBillingInfo(arg_name).then(unittest.expectAsync(((api.ProjectBillingInfo response) {
        checkProjectBillingInfo(response);
      })));
    });

    unittest.test("method--updateBillingInfo", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudbillingApi(mock).projects;
      var arg_request = buildProjectBillingInfo();
      var arg_name = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ProjectBillingInfo.fromJson(json);
        checkProjectBillingInfo(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

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
        var resp = convert.JSON.encode(buildProjectBillingInfo());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.updateBillingInfo(arg_request, arg_name).then(unittest.expectAsync(((api.ProjectBillingInfo response) {
        checkProjectBillingInfo(response);
      })));
    });

  });


}

