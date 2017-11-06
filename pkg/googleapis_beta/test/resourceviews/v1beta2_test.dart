library googleapis_beta.resourceviews.v1beta2.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis_beta/resourceviews/v1beta2.dart' as api;

class HttpServerMock extends http.BaseClient {
  core.Function _callback;
  core.bool _expectJson;

  void register(core.Function callback, core.bool expectJson) {
    _callback = callback;
    _expectJson = expectJson;
  }

  async.Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (_expectJson) {
      return request
          .finalize()
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

http.StreamedResponse stringResponse(core.int status,
    core.Map<core.String, core.String> headers, core.String body) {
  var stream = new async.Stream.fromIterable([convert.UTF8.encode(body)]);
  return new http.StreamedResponse(stream, status, headers: headers);
}

core.int buildCounterLabel = 0;
buildLabel() {
  var o = new api.Label();
  buildCounterLabel++;
  if (buildCounterLabel < 3) {
    o.key = "foo";
    o.value = "foo";
  }
  buildCounterLabel--;
  return o;
}

checkLabel(api.Label o) {
  buildCounterLabel++;
  if (buildCounterLabel < 3) {
    unittest.expect(o.key, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterLabel--;
}

buildUnnamed3236() {
  var o = new core.List<core.int>();
  o.add(42);
  o.add(42);
  return o;
}

checkUnnamed3236(core.List<core.int> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42));
  unittest.expect(o[1], unittest.equals(42));
}

buildUnnamed3237() {
  var o = new core.Map<core.String, core.List<core.int>>();
  o["x"] = buildUnnamed3236();
  o["y"] = buildUnnamed3236();
  return o;
}

checkUnnamed3237(core.Map<core.String, core.List<core.int>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed3236(o["x"]);
  checkUnnamed3236(o["y"]);
}

core.int buildCounterListResourceResponseItem = 0;
buildListResourceResponseItem() {
  var o = new api.ListResourceResponseItem();
  buildCounterListResourceResponseItem++;
  if (buildCounterListResourceResponseItem < 3) {
    o.endpoints = buildUnnamed3237();
    o.resource = "foo";
  }
  buildCounterListResourceResponseItem--;
  return o;
}

checkListResourceResponseItem(api.ListResourceResponseItem o) {
  buildCounterListResourceResponseItem++;
  if (buildCounterListResourceResponseItem < 3) {
    checkUnnamed3237(o.endpoints);
    unittest.expect(o.resource, unittest.equals('foo'));
  }
  buildCounterListResourceResponseItem--;
}

core.int buildCounterOperationErrorErrors = 0;
buildOperationErrorErrors() {
  var o = new api.OperationErrorErrors();
  buildCounterOperationErrorErrors++;
  if (buildCounterOperationErrorErrors < 3) {
    o.code = "foo";
    o.location = "foo";
    o.message = "foo";
  }
  buildCounterOperationErrorErrors--;
  return o;
}

checkOperationErrorErrors(api.OperationErrorErrors o) {
  buildCounterOperationErrorErrors++;
  if (buildCounterOperationErrorErrors < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    unittest.expect(o.location, unittest.equals('foo'));
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterOperationErrorErrors--;
}

buildUnnamed3238() {
  var o = new core.List<api.OperationErrorErrors>();
  o.add(buildOperationErrorErrors());
  o.add(buildOperationErrorErrors());
  return o;
}

checkUnnamed3238(core.List<api.OperationErrorErrors> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperationErrorErrors(o[0]);
  checkOperationErrorErrors(o[1]);
}

core.int buildCounterOperationError = 0;
buildOperationError() {
  var o = new api.OperationError();
  buildCounterOperationError++;
  if (buildCounterOperationError < 3) {
    o.errors = buildUnnamed3238();
  }
  buildCounterOperationError--;
  return o;
}

checkOperationError(api.OperationError o) {
  buildCounterOperationError++;
  if (buildCounterOperationError < 3) {
    checkUnnamed3238(o.errors);
  }
  buildCounterOperationError--;
}

core.int buildCounterOperationWarningsData = 0;
buildOperationWarningsData() {
  var o = new api.OperationWarningsData();
  buildCounterOperationWarningsData++;
  if (buildCounterOperationWarningsData < 3) {
    o.key = "foo";
    o.value = "foo";
  }
  buildCounterOperationWarningsData--;
  return o;
}

checkOperationWarningsData(api.OperationWarningsData o) {
  buildCounterOperationWarningsData++;
  if (buildCounterOperationWarningsData < 3) {
    unittest.expect(o.key, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterOperationWarningsData--;
}

buildUnnamed3239() {
  var o = new core.List<api.OperationWarningsData>();
  o.add(buildOperationWarningsData());
  o.add(buildOperationWarningsData());
  return o;
}

checkUnnamed3239(core.List<api.OperationWarningsData> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperationWarningsData(o[0]);
  checkOperationWarningsData(o[1]);
}

core.int buildCounterOperationWarnings = 0;
buildOperationWarnings() {
  var o = new api.OperationWarnings();
  buildCounterOperationWarnings++;
  if (buildCounterOperationWarnings < 3) {
    o.code = "foo";
    o.data = buildUnnamed3239();
    o.message = "foo";
  }
  buildCounterOperationWarnings--;
  return o;
}

checkOperationWarnings(api.OperationWarnings o) {
  buildCounterOperationWarnings++;
  if (buildCounterOperationWarnings < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    checkUnnamed3239(o.data);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterOperationWarnings--;
}

buildUnnamed3240() {
  var o = new core.List<api.OperationWarnings>();
  o.add(buildOperationWarnings());
  o.add(buildOperationWarnings());
  return o;
}

checkUnnamed3240(core.List<api.OperationWarnings> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperationWarnings(o[0]);
  checkOperationWarnings(o[1]);
}

core.int buildCounterOperation = 0;
buildOperation() {
  var o = new api.Operation();
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    o.clientOperationId = "foo";
    o.creationTimestamp = "foo";
    o.endTime = "foo";
    o.error = buildOperationError();
    o.httpErrorMessage = "foo";
    o.httpErrorStatusCode = 42;
    o.id = "foo";
    o.insertTime = "foo";
    o.kind = "foo";
    o.name = "foo";
    o.operationType = "foo";
    o.progress = 42;
    o.region = "foo";
    o.selfLink = "foo";
    o.startTime = "foo";
    o.status = "foo";
    o.statusMessage = "foo";
    o.targetId = "foo";
    o.targetLink = "foo";
    o.user = "foo";
    o.warnings = buildUnnamed3240();
    o.zone = "foo";
  }
  buildCounterOperation--;
  return o;
}

checkOperation(api.Operation o) {
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    unittest.expect(o.clientOperationId, unittest.equals('foo'));
    unittest.expect(o.creationTimestamp, unittest.equals('foo'));
    unittest.expect(o.endTime, unittest.equals('foo'));
    checkOperationError(o.error);
    unittest.expect(o.httpErrorMessage, unittest.equals('foo'));
    unittest.expect(o.httpErrorStatusCode, unittest.equals(42));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.insertTime, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.operationType, unittest.equals('foo'));
    unittest.expect(o.progress, unittest.equals(42));
    unittest.expect(o.region, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.statusMessage, unittest.equals('foo'));
    unittest.expect(o.targetId, unittest.equals('foo'));
    unittest.expect(o.targetLink, unittest.equals('foo'));
    unittest.expect(o.user, unittest.equals('foo'));
    checkUnnamed3240(o.warnings);
    unittest.expect(o.zone, unittest.equals('foo'));
  }
  buildCounterOperation--;
}

buildUnnamed3241() {
  var o = new core.List<api.Operation>();
  o.add(buildOperation());
  o.add(buildOperation());
  return o;
}

checkUnnamed3241(core.List<api.Operation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperation(o[0]);
  checkOperation(o[1]);
}

core.int buildCounterOperationList = 0;
buildOperationList() {
  var o = new api.OperationList();
  buildCounterOperationList++;
  if (buildCounterOperationList < 3) {
    o.id = "foo";
    o.items = buildUnnamed3241();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.selfLink = "foo";
  }
  buildCounterOperationList--;
  return o;
}

checkOperationList(api.OperationList o) {
  buildCounterOperationList++;
  if (buildCounterOperationList < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed3241(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
  }
  buildCounterOperationList--;
}

buildUnnamed3242() {
  var o = new core.List<api.ServiceEndpoint>();
  o.add(buildServiceEndpoint());
  o.add(buildServiceEndpoint());
  return o;
}

checkUnnamed3242(core.List<api.ServiceEndpoint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkServiceEndpoint(o[0]);
  checkServiceEndpoint(o[1]);
}

buildUnnamed3243() {
  var o = new core.List<api.Label>();
  o.add(buildLabel());
  o.add(buildLabel());
  return o;
}

checkUnnamed3243(core.List<api.Label> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLabel(o[0]);
  checkLabel(o[1]);
}

buildUnnamed3244() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3244(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterResourceView = 0;
buildResourceView() {
  var o = new api.ResourceView();
  buildCounterResourceView++;
  if (buildCounterResourceView < 3) {
    o.creationTimestamp = "foo";
    o.description = "foo";
    o.endpoints = buildUnnamed3242();
    o.fingerprint = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.labels = buildUnnamed3243();
    o.name = "foo";
    o.network = "foo";
    o.resources = buildUnnamed3244();
    o.selfLink = "foo";
    o.size = 42;
  }
  buildCounterResourceView--;
  return o;
}

checkResourceView(api.ResourceView o) {
  buildCounterResourceView++;
  if (buildCounterResourceView < 3) {
    unittest.expect(o.creationTimestamp, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    checkUnnamed3242(o.endpoints);
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed3243(o.labels);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.network, unittest.equals('foo'));
    checkUnnamed3244(o.resources);
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.size, unittest.equals(42));
  }
  buildCounterResourceView--;
}

core.int buildCounterServiceEndpoint = 0;
buildServiceEndpoint() {
  var o = new api.ServiceEndpoint();
  buildCounterServiceEndpoint++;
  if (buildCounterServiceEndpoint < 3) {
    o.name = "foo";
    o.port = 42;
  }
  buildCounterServiceEndpoint--;
  return o;
}

checkServiceEndpoint(api.ServiceEndpoint o) {
  buildCounterServiceEndpoint++;
  if (buildCounterServiceEndpoint < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.port, unittest.equals(42));
  }
  buildCounterServiceEndpoint--;
}

buildUnnamed3245() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3245(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterZoneViewsAddResourcesRequest = 0;
buildZoneViewsAddResourcesRequest() {
  var o = new api.ZoneViewsAddResourcesRequest();
  buildCounterZoneViewsAddResourcesRequest++;
  if (buildCounterZoneViewsAddResourcesRequest < 3) {
    o.resources = buildUnnamed3245();
  }
  buildCounterZoneViewsAddResourcesRequest--;
  return o;
}

checkZoneViewsAddResourcesRequest(api.ZoneViewsAddResourcesRequest o) {
  buildCounterZoneViewsAddResourcesRequest++;
  if (buildCounterZoneViewsAddResourcesRequest < 3) {
    checkUnnamed3245(o.resources);
  }
  buildCounterZoneViewsAddResourcesRequest--;
}

buildUnnamed3246() {
  var o = new core.List<api.ServiceEndpoint>();
  o.add(buildServiceEndpoint());
  o.add(buildServiceEndpoint());
  return o;
}

checkUnnamed3246(core.List<api.ServiceEndpoint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkServiceEndpoint(o[0]);
  checkServiceEndpoint(o[1]);
}

core.int buildCounterZoneViewsGetServiceResponse = 0;
buildZoneViewsGetServiceResponse() {
  var o = new api.ZoneViewsGetServiceResponse();
  buildCounterZoneViewsGetServiceResponse++;
  if (buildCounterZoneViewsGetServiceResponse < 3) {
    o.endpoints = buildUnnamed3246();
    o.fingerprint = "foo";
  }
  buildCounterZoneViewsGetServiceResponse--;
  return o;
}

checkZoneViewsGetServiceResponse(api.ZoneViewsGetServiceResponse o) {
  buildCounterZoneViewsGetServiceResponse++;
  if (buildCounterZoneViewsGetServiceResponse < 3) {
    checkUnnamed3246(o.endpoints);
    unittest.expect(o.fingerprint, unittest.equals('foo'));
  }
  buildCounterZoneViewsGetServiceResponse--;
}

buildUnnamed3247() {
  var o = new core.List<api.ResourceView>();
  o.add(buildResourceView());
  o.add(buildResourceView());
  return o;
}

checkUnnamed3247(core.List<api.ResourceView> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResourceView(o[0]);
  checkResourceView(o[1]);
}

core.int buildCounterZoneViewsList = 0;
buildZoneViewsList() {
  var o = new api.ZoneViewsList();
  buildCounterZoneViewsList++;
  if (buildCounterZoneViewsList < 3) {
    o.items = buildUnnamed3247();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.selfLink = "foo";
  }
  buildCounterZoneViewsList--;
  return o;
}

checkZoneViewsList(api.ZoneViewsList o) {
  buildCounterZoneViewsList++;
  if (buildCounterZoneViewsList < 3) {
    checkUnnamed3247(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
  }
  buildCounterZoneViewsList--;
}

buildUnnamed3248() {
  var o = new core.List<api.ListResourceResponseItem>();
  o.add(buildListResourceResponseItem());
  o.add(buildListResourceResponseItem());
  return o;
}

checkUnnamed3248(core.List<api.ListResourceResponseItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkListResourceResponseItem(o[0]);
  checkListResourceResponseItem(o[1]);
}

core.int buildCounterZoneViewsListResourcesResponse = 0;
buildZoneViewsListResourcesResponse() {
  var o = new api.ZoneViewsListResourcesResponse();
  buildCounterZoneViewsListResourcesResponse++;
  if (buildCounterZoneViewsListResourcesResponse < 3) {
    o.items = buildUnnamed3248();
    o.network = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterZoneViewsListResourcesResponse--;
  return o;
}

checkZoneViewsListResourcesResponse(api.ZoneViewsListResourcesResponse o) {
  buildCounterZoneViewsListResourcesResponse++;
  if (buildCounterZoneViewsListResourcesResponse < 3) {
    checkUnnamed3248(o.items);
    unittest.expect(o.network, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterZoneViewsListResourcesResponse--;
}

buildUnnamed3249() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3249(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterZoneViewsRemoveResourcesRequest = 0;
buildZoneViewsRemoveResourcesRequest() {
  var o = new api.ZoneViewsRemoveResourcesRequest();
  buildCounterZoneViewsRemoveResourcesRequest++;
  if (buildCounterZoneViewsRemoveResourcesRequest < 3) {
    o.resources = buildUnnamed3249();
  }
  buildCounterZoneViewsRemoveResourcesRequest--;
  return o;
}

checkZoneViewsRemoveResourcesRequest(api.ZoneViewsRemoveResourcesRequest o) {
  buildCounterZoneViewsRemoveResourcesRequest++;
  if (buildCounterZoneViewsRemoveResourcesRequest < 3) {
    checkUnnamed3249(o.resources);
  }
  buildCounterZoneViewsRemoveResourcesRequest--;
}

buildUnnamed3250() {
  var o = new core.List<api.ServiceEndpoint>();
  o.add(buildServiceEndpoint());
  o.add(buildServiceEndpoint());
  return o;
}

checkUnnamed3250(core.List<api.ServiceEndpoint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkServiceEndpoint(o[0]);
  checkServiceEndpoint(o[1]);
}

core.int buildCounterZoneViewsSetServiceRequest = 0;
buildZoneViewsSetServiceRequest() {
  var o = new api.ZoneViewsSetServiceRequest();
  buildCounterZoneViewsSetServiceRequest++;
  if (buildCounterZoneViewsSetServiceRequest < 3) {
    o.endpoints = buildUnnamed3250();
    o.fingerprint = "foo";
    o.resourceName = "foo";
  }
  buildCounterZoneViewsSetServiceRequest--;
  return o;
}

checkZoneViewsSetServiceRequest(api.ZoneViewsSetServiceRequest o) {
  buildCounterZoneViewsSetServiceRequest++;
  if (buildCounterZoneViewsSetServiceRequest < 3) {
    checkUnnamed3250(o.endpoints);
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    unittest.expect(o.resourceName, unittest.equals('foo'));
  }
  buildCounterZoneViewsSetServiceRequest--;
}

main() {
  unittest.group("obj-schema-Label", () {
    unittest.test("to-json--from-json", () {
      var o = buildLabel();
      var od = new api.Label.fromJson(o.toJson());
      checkLabel(od);
    });
  });

  unittest.group("obj-schema-ListResourceResponseItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildListResourceResponseItem();
      var od = new api.ListResourceResponseItem.fromJson(o.toJson());
      checkListResourceResponseItem(od);
    });
  });

  unittest.group("obj-schema-OperationErrorErrors", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationErrorErrors();
      var od = new api.OperationErrorErrors.fromJson(o.toJson());
      checkOperationErrorErrors(od);
    });
  });

  unittest.group("obj-schema-OperationError", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationError();
      var od = new api.OperationError.fromJson(o.toJson());
      checkOperationError(od);
    });
  });

  unittest.group("obj-schema-OperationWarningsData", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationWarningsData();
      var od = new api.OperationWarningsData.fromJson(o.toJson());
      checkOperationWarningsData(od);
    });
  });

  unittest.group("obj-schema-OperationWarnings", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationWarnings();
      var od = new api.OperationWarnings.fromJson(o.toJson());
      checkOperationWarnings(od);
    });
  });

  unittest.group("obj-schema-Operation", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperation();
      var od = new api.Operation.fromJson(o.toJson());
      checkOperation(od);
    });
  });

  unittest.group("obj-schema-OperationList", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationList();
      var od = new api.OperationList.fromJson(o.toJson());
      checkOperationList(od);
    });
  });

  unittest.group("obj-schema-ResourceView", () {
    unittest.test("to-json--from-json", () {
      var o = buildResourceView();
      var od = new api.ResourceView.fromJson(o.toJson());
      checkResourceView(od);
    });
  });

  unittest.group("obj-schema-ServiceEndpoint", () {
    unittest.test("to-json--from-json", () {
      var o = buildServiceEndpoint();
      var od = new api.ServiceEndpoint.fromJson(o.toJson());
      checkServiceEndpoint(od);
    });
  });

  unittest.group("obj-schema-ZoneViewsAddResourcesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildZoneViewsAddResourcesRequest();
      var od = new api.ZoneViewsAddResourcesRequest.fromJson(o.toJson());
      checkZoneViewsAddResourcesRequest(od);
    });
  });

  unittest.group("obj-schema-ZoneViewsGetServiceResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildZoneViewsGetServiceResponse();
      var od = new api.ZoneViewsGetServiceResponse.fromJson(o.toJson());
      checkZoneViewsGetServiceResponse(od);
    });
  });

  unittest.group("obj-schema-ZoneViewsList", () {
    unittest.test("to-json--from-json", () {
      var o = buildZoneViewsList();
      var od = new api.ZoneViewsList.fromJson(o.toJson());
      checkZoneViewsList(od);
    });
  });

  unittest.group("obj-schema-ZoneViewsListResourcesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildZoneViewsListResourcesResponse();
      var od = new api.ZoneViewsListResourcesResponse.fromJson(o.toJson());
      checkZoneViewsListResourcesResponse(od);
    });
  });

  unittest.group("obj-schema-ZoneViewsRemoveResourcesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildZoneViewsRemoveResourcesRequest();
      var od = new api.ZoneViewsRemoveResourcesRequest.fromJson(o.toJson());
      checkZoneViewsRemoveResourcesRequest(od);
    });
  });

  unittest.group("obj-schema-ZoneViewsSetServiceRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildZoneViewsSetServiceRequest();
      var od = new api.ZoneViewsSetServiceRequest.fromJson(o.toJson());
      checkZoneViewsSetServiceRequest(od);
    });
  });

  unittest.group("resource-ZoneOperationsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.ZoneOperationsResourceApi res =
          new api.ResourceviewsApi(mock).zoneOperations;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_operation = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_zone, arg_operation)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.ZoneOperationsResourceApi res =
          new api.ResourceviewsApi(mock).zoneOperations;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_filter = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperationList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_zone,
              filter: arg_filter,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken)
          .then(unittest.expectAsync1(((api.OperationList response) {
        checkOperationList(response);
      })));
    });
  });

  unittest.group("resource-ZoneViewsResourceApi", () {
    unittest.test("method--addResources", () {
      var mock = new HttpServerMock();
      api.ZoneViewsResourceApi res = new api.ResourceviewsApi(mock).zoneViews;
      var arg_request = buildZoneViewsAddResourcesRequest();
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_resourceView = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ZoneViewsAddResourcesRequest.fromJson(json);
        checkZoneViewsAddResourcesRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .addResources(arg_request, arg_project, arg_zone, arg_resourceView)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.ZoneViewsResourceApi res = new api.ResourceviewsApi(mock).zoneViews;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_resourceView = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_project, arg_zone, arg_resourceView)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.ZoneViewsResourceApi res = new api.ResourceviewsApi(mock).zoneViews;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_resourceView = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildResourceView());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_zone, arg_resourceView)
          .then(unittest.expectAsync1(((api.ResourceView response) {
        checkResourceView(response);
      })));
    });

    unittest.test("method--getService", () {
      var mock = new HttpServerMock();
      api.ZoneViewsResourceApi res = new api.ResourceviewsApi(mock).zoneViews;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_resourceView = "foo";
      var arg_resourceName = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["resourceName"].first, unittest.equals(arg_resourceName));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildZoneViewsGetServiceResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .getService(arg_project, arg_zone, arg_resourceView,
              resourceName: arg_resourceName)
          .then(unittest
              .expectAsync1(((api.ZoneViewsGetServiceResponse response) {
        checkZoneViewsGetServiceResponse(response);
      })));
    });

    unittest.test("method--insert", () {
      var mock = new HttpServerMock();
      api.ZoneViewsResourceApi res = new api.ResourceviewsApi(mock).zoneViews;
      var arg_request = buildResourceView();
      var arg_project = "foo";
      var arg_zone = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ResourceView.fromJson(json);
        checkResourceView(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .insert(arg_request, arg_project, arg_zone)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.ZoneViewsResourceApi res = new api.ResourceviewsApi(mock).zoneViews;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildZoneViewsList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_zone,
              maxResults: arg_maxResults, pageToken: arg_pageToken)
          .then(unittest.expectAsync1(((api.ZoneViewsList response) {
        checkZoneViewsList(response);
      })));
    });

    unittest.test("method--listResources", () {
      var mock = new HttpServerMock();
      api.ZoneViewsResourceApi res = new api.ResourceviewsApi(mock).zoneViews;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_resourceView = "foo";
      var arg_format = "foo";
      var arg_listState = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_serviceName = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["format"].first, unittest.equals(arg_format));
        unittest.expect(
            queryMap["listState"].first, unittest.equals(arg_listState));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(
            queryMap["serviceName"].first, unittest.equals(arg_serviceName));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildZoneViewsListResourcesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .listResources(arg_project, arg_zone, arg_resourceView,
              format: arg_format,
              listState: arg_listState,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              serviceName: arg_serviceName)
          .then(unittest
              .expectAsync1(((api.ZoneViewsListResourcesResponse response) {
        checkZoneViewsListResourcesResponse(response);
      })));
    });

    unittest.test("method--removeResources", () {
      var mock = new HttpServerMock();
      api.ZoneViewsResourceApi res = new api.ResourceviewsApi(mock).zoneViews;
      var arg_request = buildZoneViewsRemoveResourcesRequest();
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_resourceView = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ZoneViewsRemoveResourcesRequest.fromJson(json);
        checkZoneViewsRemoveResourcesRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .removeResources(arg_request, arg_project, arg_zone, arg_resourceView)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--setService", () {
      var mock = new HttpServerMock();
      api.ZoneViewsResourceApi res = new api.ResourceviewsApi(mock).zoneViews;
      var arg_request = buildZoneViewsSetServiceRequest();
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_resourceView = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ZoneViewsSetServiceRequest.fromJson(json);
        checkZoneViewsSetServiceRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .setService(arg_request, arg_project, arg_zone, arg_resourceView)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });
  });
}
