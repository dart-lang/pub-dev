library googleapis_beta.replicapool.v1beta2.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis_beta/replicapool/v1beta2.dart' as api;

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

buildUnnamed3453() {
  var o = new core.List<api.ReplicaPoolAutoHealingPolicy>();
  o.add(buildReplicaPoolAutoHealingPolicy());
  o.add(buildReplicaPoolAutoHealingPolicy());
  return o;
}

checkUnnamed3453(core.List<api.ReplicaPoolAutoHealingPolicy> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReplicaPoolAutoHealingPolicy(o[0]);
  checkReplicaPoolAutoHealingPolicy(o[1]);
}

buildUnnamed3454() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3454(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterInstanceGroupManager = 0;
buildInstanceGroupManager() {
  var o = new api.InstanceGroupManager();
  buildCounterInstanceGroupManager++;
  if (buildCounterInstanceGroupManager < 3) {
    o.autoHealingPolicies = buildUnnamed3453();
    o.baseInstanceName = "foo";
    o.creationTimestamp = "foo";
    o.currentSize = 42;
    o.description = "foo";
    o.fingerprint = "foo";
    o.group = "foo";
    o.id = "foo";
    o.instanceTemplate = "foo";
    o.kind = "foo";
    o.name = "foo";
    o.selfLink = "foo";
    o.targetPools = buildUnnamed3454();
    o.targetSize = 42;
  }
  buildCounterInstanceGroupManager--;
  return o;
}

checkInstanceGroupManager(api.InstanceGroupManager o) {
  buildCounterInstanceGroupManager++;
  if (buildCounterInstanceGroupManager < 3) {
    checkUnnamed3453(o.autoHealingPolicies);
    unittest.expect(o.baseInstanceName, unittest.equals('foo'));
    unittest.expect(o.creationTimestamp, unittest.equals('foo'));
    unittest.expect(o.currentSize, unittest.equals(42));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    unittest.expect(o.group, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.instanceTemplate, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    checkUnnamed3454(o.targetPools);
    unittest.expect(o.targetSize, unittest.equals(42));
  }
  buildCounterInstanceGroupManager--;
}

buildUnnamed3455() {
  var o = new core.List<api.InstanceGroupManager>();
  o.add(buildInstanceGroupManager());
  o.add(buildInstanceGroupManager());
  return o;
}

checkUnnamed3455(core.List<api.InstanceGroupManager> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkInstanceGroupManager(o[0]);
  checkInstanceGroupManager(o[1]);
}

core.int buildCounterInstanceGroupManagerList = 0;
buildInstanceGroupManagerList() {
  var o = new api.InstanceGroupManagerList();
  buildCounterInstanceGroupManagerList++;
  if (buildCounterInstanceGroupManagerList < 3) {
    o.id = "foo";
    o.items = buildUnnamed3455();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.selfLink = "foo";
  }
  buildCounterInstanceGroupManagerList--;
  return o;
}

checkInstanceGroupManagerList(api.InstanceGroupManagerList o) {
  buildCounterInstanceGroupManagerList++;
  if (buildCounterInstanceGroupManagerList < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed3455(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
  }
  buildCounterInstanceGroupManagerList--;
}

buildUnnamed3456() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3456(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterInstanceGroupManagersAbandonInstancesRequest = 0;
buildInstanceGroupManagersAbandonInstancesRequest() {
  var o = new api.InstanceGroupManagersAbandonInstancesRequest();
  buildCounterInstanceGroupManagersAbandonInstancesRequest++;
  if (buildCounterInstanceGroupManagersAbandonInstancesRequest < 3) {
    o.instances = buildUnnamed3456();
  }
  buildCounterInstanceGroupManagersAbandonInstancesRequest--;
  return o;
}

checkInstanceGroupManagersAbandonInstancesRequest(
    api.InstanceGroupManagersAbandonInstancesRequest o) {
  buildCounterInstanceGroupManagersAbandonInstancesRequest++;
  if (buildCounterInstanceGroupManagersAbandonInstancesRequest < 3) {
    checkUnnamed3456(o.instances);
  }
  buildCounterInstanceGroupManagersAbandonInstancesRequest--;
}

buildUnnamed3457() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3457(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterInstanceGroupManagersDeleteInstancesRequest = 0;
buildInstanceGroupManagersDeleteInstancesRequest() {
  var o = new api.InstanceGroupManagersDeleteInstancesRequest();
  buildCounterInstanceGroupManagersDeleteInstancesRequest++;
  if (buildCounterInstanceGroupManagersDeleteInstancesRequest < 3) {
    o.instances = buildUnnamed3457();
  }
  buildCounterInstanceGroupManagersDeleteInstancesRequest--;
  return o;
}

checkInstanceGroupManagersDeleteInstancesRequest(
    api.InstanceGroupManagersDeleteInstancesRequest o) {
  buildCounterInstanceGroupManagersDeleteInstancesRequest++;
  if (buildCounterInstanceGroupManagersDeleteInstancesRequest < 3) {
    checkUnnamed3457(o.instances);
  }
  buildCounterInstanceGroupManagersDeleteInstancesRequest--;
}

buildUnnamed3458() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3458(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterInstanceGroupManagersRecreateInstancesRequest = 0;
buildInstanceGroupManagersRecreateInstancesRequest() {
  var o = new api.InstanceGroupManagersRecreateInstancesRequest();
  buildCounterInstanceGroupManagersRecreateInstancesRequest++;
  if (buildCounterInstanceGroupManagersRecreateInstancesRequest < 3) {
    o.instances = buildUnnamed3458();
  }
  buildCounterInstanceGroupManagersRecreateInstancesRequest--;
  return o;
}

checkInstanceGroupManagersRecreateInstancesRequest(
    api.InstanceGroupManagersRecreateInstancesRequest o) {
  buildCounterInstanceGroupManagersRecreateInstancesRequest++;
  if (buildCounterInstanceGroupManagersRecreateInstancesRequest < 3) {
    checkUnnamed3458(o.instances);
  }
  buildCounterInstanceGroupManagersRecreateInstancesRequest--;
}

core.int buildCounterInstanceGroupManagersSetInstanceTemplateRequest = 0;
buildInstanceGroupManagersSetInstanceTemplateRequest() {
  var o = new api.InstanceGroupManagersSetInstanceTemplateRequest();
  buildCounterInstanceGroupManagersSetInstanceTemplateRequest++;
  if (buildCounterInstanceGroupManagersSetInstanceTemplateRequest < 3) {
    o.instanceTemplate = "foo";
  }
  buildCounterInstanceGroupManagersSetInstanceTemplateRequest--;
  return o;
}

checkInstanceGroupManagersSetInstanceTemplateRequest(
    api.InstanceGroupManagersSetInstanceTemplateRequest o) {
  buildCounterInstanceGroupManagersSetInstanceTemplateRequest++;
  if (buildCounterInstanceGroupManagersSetInstanceTemplateRequest < 3) {
    unittest.expect(o.instanceTemplate, unittest.equals('foo'));
  }
  buildCounterInstanceGroupManagersSetInstanceTemplateRequest--;
}

buildUnnamed3459() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3459(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterInstanceGroupManagersSetTargetPoolsRequest = 0;
buildInstanceGroupManagersSetTargetPoolsRequest() {
  var o = new api.InstanceGroupManagersSetTargetPoolsRequest();
  buildCounterInstanceGroupManagersSetTargetPoolsRequest++;
  if (buildCounterInstanceGroupManagersSetTargetPoolsRequest < 3) {
    o.fingerprint = "foo";
    o.targetPools = buildUnnamed3459();
  }
  buildCounterInstanceGroupManagersSetTargetPoolsRequest--;
  return o;
}

checkInstanceGroupManagersSetTargetPoolsRequest(
    api.InstanceGroupManagersSetTargetPoolsRequest o) {
  buildCounterInstanceGroupManagersSetTargetPoolsRequest++;
  if (buildCounterInstanceGroupManagersSetTargetPoolsRequest < 3) {
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    checkUnnamed3459(o.targetPools);
  }
  buildCounterInstanceGroupManagersSetTargetPoolsRequest--;
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

buildUnnamed3460() {
  var o = new core.List<api.OperationErrorErrors>();
  o.add(buildOperationErrorErrors());
  o.add(buildOperationErrorErrors());
  return o;
}

checkUnnamed3460(core.List<api.OperationErrorErrors> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperationErrorErrors(o[0]);
  checkOperationErrorErrors(o[1]);
}

core.int buildCounterOperationError = 0;
buildOperationError() {
  var o = new api.OperationError();
  buildCounterOperationError++;
  if (buildCounterOperationError < 3) {
    o.errors = buildUnnamed3460();
  }
  buildCounterOperationError--;
  return o;
}

checkOperationError(api.OperationError o) {
  buildCounterOperationError++;
  if (buildCounterOperationError < 3) {
    checkUnnamed3460(o.errors);
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

buildUnnamed3461() {
  var o = new core.List<api.OperationWarningsData>();
  o.add(buildOperationWarningsData());
  o.add(buildOperationWarningsData());
  return o;
}

checkUnnamed3461(core.List<api.OperationWarningsData> o) {
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
    o.data = buildUnnamed3461();
    o.message = "foo";
  }
  buildCounterOperationWarnings--;
  return o;
}

checkOperationWarnings(api.OperationWarnings o) {
  buildCounterOperationWarnings++;
  if (buildCounterOperationWarnings < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    checkUnnamed3461(o.data);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterOperationWarnings--;
}

buildUnnamed3462() {
  var o = new core.List<api.OperationWarnings>();
  o.add(buildOperationWarnings());
  o.add(buildOperationWarnings());
  return o;
}

checkUnnamed3462(core.List<api.OperationWarnings> o) {
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
    o.warnings = buildUnnamed3462();
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
    checkUnnamed3462(o.warnings);
    unittest.expect(o.zone, unittest.equals('foo'));
  }
  buildCounterOperation--;
}

buildUnnamed3463() {
  var o = new core.List<api.Operation>();
  o.add(buildOperation());
  o.add(buildOperation());
  return o;
}

checkUnnamed3463(core.List<api.Operation> o) {
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
    o.items = buildUnnamed3463();
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
    checkUnnamed3463(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
  }
  buildCounterOperationList--;
}

core.int buildCounterReplicaPoolAutoHealingPolicy = 0;
buildReplicaPoolAutoHealingPolicy() {
  var o = new api.ReplicaPoolAutoHealingPolicy();
  buildCounterReplicaPoolAutoHealingPolicy++;
  if (buildCounterReplicaPoolAutoHealingPolicy < 3) {
    o.actionType = "foo";
    o.healthCheck = "foo";
  }
  buildCounterReplicaPoolAutoHealingPolicy--;
  return o;
}

checkReplicaPoolAutoHealingPolicy(api.ReplicaPoolAutoHealingPolicy o) {
  buildCounterReplicaPoolAutoHealingPolicy++;
  if (buildCounterReplicaPoolAutoHealingPolicy < 3) {
    unittest.expect(o.actionType, unittest.equals('foo'));
    unittest.expect(o.healthCheck, unittest.equals('foo'));
  }
  buildCounterReplicaPoolAutoHealingPolicy--;
}

main() {
  unittest.group("obj-schema-InstanceGroupManager", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceGroupManager();
      var od = new api.InstanceGroupManager.fromJson(o.toJson());
      checkInstanceGroupManager(od);
    });
  });

  unittest.group("obj-schema-InstanceGroupManagerList", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceGroupManagerList();
      var od = new api.InstanceGroupManagerList.fromJson(o.toJson());
      checkInstanceGroupManagerList(od);
    });
  });

  unittest.group("obj-schema-InstanceGroupManagersAbandonInstancesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceGroupManagersAbandonInstancesRequest();
      var od = new api.InstanceGroupManagersAbandonInstancesRequest.fromJson(
          o.toJson());
      checkInstanceGroupManagersAbandonInstancesRequest(od);
    });
  });

  unittest.group("obj-schema-InstanceGroupManagersDeleteInstancesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceGroupManagersDeleteInstancesRequest();
      var od = new api.InstanceGroupManagersDeleteInstancesRequest.fromJson(
          o.toJson());
      checkInstanceGroupManagersDeleteInstancesRequest(od);
    });
  });

  unittest.group("obj-schema-InstanceGroupManagersRecreateInstancesRequest",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceGroupManagersRecreateInstancesRequest();
      var od = new api.InstanceGroupManagersRecreateInstancesRequest.fromJson(
          o.toJson());
      checkInstanceGroupManagersRecreateInstancesRequest(od);
    });
  });

  unittest.group("obj-schema-InstanceGroupManagersSetInstanceTemplateRequest",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceGroupManagersSetInstanceTemplateRequest();
      var od = new api.InstanceGroupManagersSetInstanceTemplateRequest.fromJson(
          o.toJson());
      checkInstanceGroupManagersSetInstanceTemplateRequest(od);
    });
  });

  unittest.group("obj-schema-InstanceGroupManagersSetTargetPoolsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceGroupManagersSetTargetPoolsRequest();
      var od = new api.InstanceGroupManagersSetTargetPoolsRequest.fromJson(
          o.toJson());
      checkInstanceGroupManagersSetTargetPoolsRequest(od);
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

  unittest.group("obj-schema-ReplicaPoolAutoHealingPolicy", () {
    unittest.test("to-json--from-json", () {
      var o = buildReplicaPoolAutoHealingPolicy();
      var od = new api.ReplicaPoolAutoHealingPolicy.fromJson(o.toJson());
      checkReplicaPoolAutoHealingPolicy(od);
    });
  });

  unittest.group("resource-InstanceGroupManagersResourceApi", () {
    unittest.test("method--abandonInstances", () {
      var mock = new HttpServerMock();
      api.InstanceGroupManagersResourceApi res =
          new api.ReplicapoolApi(mock).instanceGroupManagers;
      var arg_request = buildInstanceGroupManagersAbandonInstancesRequest();
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_instanceGroupManager = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            new api.InstanceGroupManagersAbandonInstancesRequest.fromJson(json);
        checkInstanceGroupManagersAbandonInstancesRequest(obj);

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
          .abandonInstances(
              arg_request, arg_project, arg_zone, arg_instanceGroupManager)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.InstanceGroupManagersResourceApi res =
          new api.ReplicapoolApi(mock).instanceGroupManagers;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_instanceGroupManager = "foo";
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
          .delete(arg_project, arg_zone, arg_instanceGroupManager)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--deleteInstances", () {
      var mock = new HttpServerMock();
      api.InstanceGroupManagersResourceApi res =
          new api.ReplicapoolApi(mock).instanceGroupManagers;
      var arg_request = buildInstanceGroupManagersDeleteInstancesRequest();
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_instanceGroupManager = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            new api.InstanceGroupManagersDeleteInstancesRequest.fromJson(json);
        checkInstanceGroupManagersDeleteInstancesRequest(obj);

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
          .deleteInstances(
              arg_request, arg_project, arg_zone, arg_instanceGroupManager)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.InstanceGroupManagersResourceApi res =
          new api.ReplicapoolApi(mock).instanceGroupManagers;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_instanceGroupManager = "foo";
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
        var resp = convert.JSON.encode(buildInstanceGroupManager());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_zone, arg_instanceGroupManager)
          .then(unittest.expectAsync1(((api.InstanceGroupManager response) {
        checkInstanceGroupManager(response);
      })));
    });

    unittest.test("method--insert", () {
      var mock = new HttpServerMock();
      api.InstanceGroupManagersResourceApi res =
          new api.ReplicapoolApi(mock).instanceGroupManagers;
      var arg_request = buildInstanceGroupManager();
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_size = 42;
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.InstanceGroupManager.fromJson(json);
        checkInstanceGroupManager(obj);

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
            core.int.parse(queryMap["size"].first), unittest.equals(arg_size));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .insert(arg_request, arg_project, arg_zone, arg_size)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.InstanceGroupManagersResourceApi res =
          new api.ReplicapoolApi(mock).instanceGroupManagers;
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
        var resp = convert.JSON.encode(buildInstanceGroupManagerList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_zone,
              filter: arg_filter,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken)
          .then(unittest.expectAsync1(((api.InstanceGroupManagerList response) {
        checkInstanceGroupManagerList(response);
      })));
    });

    unittest.test("method--recreateInstances", () {
      var mock = new HttpServerMock();
      api.InstanceGroupManagersResourceApi res =
          new api.ReplicapoolApi(mock).instanceGroupManagers;
      var arg_request = buildInstanceGroupManagersRecreateInstancesRequest();
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_instanceGroupManager = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            new api.InstanceGroupManagersRecreateInstancesRequest.fromJson(
                json);
        checkInstanceGroupManagersRecreateInstancesRequest(obj);

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
          .recreateInstances(
              arg_request, arg_project, arg_zone, arg_instanceGroupManager)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--resize", () {
      var mock = new HttpServerMock();
      api.InstanceGroupManagersResourceApi res =
          new api.ReplicapoolApi(mock).instanceGroupManagers;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_instanceGroupManager = "foo";
      var arg_size = 42;
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
            core.int.parse(queryMap["size"].first), unittest.equals(arg_size));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .resize(arg_project, arg_zone, arg_instanceGroupManager, arg_size)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--setInstanceTemplate", () {
      var mock = new HttpServerMock();
      api.InstanceGroupManagersResourceApi res =
          new api.ReplicapoolApi(mock).instanceGroupManagers;
      var arg_request = buildInstanceGroupManagersSetInstanceTemplateRequest();
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_instanceGroupManager = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            new api.InstanceGroupManagersSetInstanceTemplateRequest.fromJson(
                json);
        checkInstanceGroupManagersSetInstanceTemplateRequest(obj);

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
          .setInstanceTemplate(
              arg_request, arg_project, arg_zone, arg_instanceGroupManager)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--setTargetPools", () {
      var mock = new HttpServerMock();
      api.InstanceGroupManagersResourceApi res =
          new api.ReplicapoolApi(mock).instanceGroupManagers;
      var arg_request = buildInstanceGroupManagersSetTargetPoolsRequest();
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_instanceGroupManager = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            new api.InstanceGroupManagersSetTargetPoolsRequest.fromJson(json);
        checkInstanceGroupManagersSetTargetPoolsRequest(obj);

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
          .setTargetPools(
              arg_request, arg_project, arg_zone, arg_instanceGroupManager)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });
  });

  unittest.group("resource-ZoneOperationsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.ZoneOperationsResourceApi res =
          new api.ReplicapoolApi(mock).zoneOperations;
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
          new api.ReplicapoolApi(mock).zoneOperations;
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
}
