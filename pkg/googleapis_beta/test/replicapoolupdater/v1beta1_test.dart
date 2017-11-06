library googleapis_beta.replicapoolupdater.v1beta1.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis_beta/replicapoolupdater/v1beta1.dart' as api;

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

core.int buildCounterInstanceUpdateErrorErrors = 0;
buildInstanceUpdateErrorErrors() {
  var o = new api.InstanceUpdateErrorErrors();
  buildCounterInstanceUpdateErrorErrors++;
  if (buildCounterInstanceUpdateErrorErrors < 3) {
    o.code = "foo";
    o.location = "foo";
    o.message = "foo";
  }
  buildCounterInstanceUpdateErrorErrors--;
  return o;
}

checkInstanceUpdateErrorErrors(api.InstanceUpdateErrorErrors o) {
  buildCounterInstanceUpdateErrorErrors++;
  if (buildCounterInstanceUpdateErrorErrors < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    unittest.expect(o.location, unittest.equals('foo'));
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterInstanceUpdateErrorErrors--;
}

buildUnnamed3266() {
  var o = new core.List<api.InstanceUpdateErrorErrors>();
  o.add(buildInstanceUpdateErrorErrors());
  o.add(buildInstanceUpdateErrorErrors());
  return o;
}

checkUnnamed3266(core.List<api.InstanceUpdateErrorErrors> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkInstanceUpdateErrorErrors(o[0]);
  checkInstanceUpdateErrorErrors(o[1]);
}

core.int buildCounterInstanceUpdateError = 0;
buildInstanceUpdateError() {
  var o = new api.InstanceUpdateError();
  buildCounterInstanceUpdateError++;
  if (buildCounterInstanceUpdateError < 3) {
    o.errors = buildUnnamed3266();
  }
  buildCounterInstanceUpdateError--;
  return o;
}

checkInstanceUpdateError(api.InstanceUpdateError o) {
  buildCounterInstanceUpdateError++;
  if (buildCounterInstanceUpdateError < 3) {
    checkUnnamed3266(o.errors);
  }
  buildCounterInstanceUpdateError--;
}

core.int buildCounterInstanceUpdate = 0;
buildInstanceUpdate() {
  var o = new api.InstanceUpdate();
  buildCounterInstanceUpdate++;
  if (buildCounterInstanceUpdate < 3) {
    o.error = buildInstanceUpdateError();
    o.instance = "foo";
    o.status = "foo";
  }
  buildCounterInstanceUpdate--;
  return o;
}

checkInstanceUpdate(api.InstanceUpdate o) {
  buildCounterInstanceUpdate++;
  if (buildCounterInstanceUpdate < 3) {
    checkInstanceUpdateError(o.error);
    unittest.expect(o.instance, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterInstanceUpdate--;
}

buildUnnamed3267() {
  var o = new core.List<api.InstanceUpdate>();
  o.add(buildInstanceUpdate());
  o.add(buildInstanceUpdate());
  return o;
}

checkUnnamed3267(core.List<api.InstanceUpdate> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkInstanceUpdate(o[0]);
  checkInstanceUpdate(o[1]);
}

core.int buildCounterInstanceUpdateList = 0;
buildInstanceUpdateList() {
  var o = new api.InstanceUpdateList();
  buildCounterInstanceUpdateList++;
  if (buildCounterInstanceUpdateList < 3) {
    o.items = buildUnnamed3267();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.selfLink = "foo";
  }
  buildCounterInstanceUpdateList--;
  return o;
}

checkInstanceUpdateList(api.InstanceUpdateList o) {
  buildCounterInstanceUpdateList++;
  if (buildCounterInstanceUpdateList < 3) {
    checkUnnamed3267(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
  }
  buildCounterInstanceUpdateList--;
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

buildUnnamed3268() {
  var o = new core.List<api.OperationErrorErrors>();
  o.add(buildOperationErrorErrors());
  o.add(buildOperationErrorErrors());
  return o;
}

checkUnnamed3268(core.List<api.OperationErrorErrors> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperationErrorErrors(o[0]);
  checkOperationErrorErrors(o[1]);
}

core.int buildCounterOperationError = 0;
buildOperationError() {
  var o = new api.OperationError();
  buildCounterOperationError++;
  if (buildCounterOperationError < 3) {
    o.errors = buildUnnamed3268();
  }
  buildCounterOperationError--;
  return o;
}

checkOperationError(api.OperationError o) {
  buildCounterOperationError++;
  if (buildCounterOperationError < 3) {
    checkUnnamed3268(o.errors);
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

buildUnnamed3269() {
  var o = new core.List<api.OperationWarningsData>();
  o.add(buildOperationWarningsData());
  o.add(buildOperationWarningsData());
  return o;
}

checkUnnamed3269(core.List<api.OperationWarningsData> o) {
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
    o.data = buildUnnamed3269();
    o.message = "foo";
  }
  buildCounterOperationWarnings--;
  return o;
}

checkOperationWarnings(api.OperationWarnings o) {
  buildCounterOperationWarnings++;
  if (buildCounterOperationWarnings < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    checkUnnamed3269(o.data);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterOperationWarnings--;
}

buildUnnamed3270() {
  var o = new core.List<api.OperationWarnings>();
  o.add(buildOperationWarnings());
  o.add(buildOperationWarnings());
  return o;
}

checkUnnamed3270(core.List<api.OperationWarnings> o) {
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
    o.warnings = buildUnnamed3270();
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
    checkUnnamed3270(o.warnings);
    unittest.expect(o.zone, unittest.equals('foo'));
  }
  buildCounterOperation--;
}

buildUnnamed3271() {
  var o = new core.List<api.Operation>();
  o.add(buildOperation());
  o.add(buildOperation());
  return o;
}

checkUnnamed3271(core.List<api.Operation> o) {
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
    o.items = buildUnnamed3271();
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
    checkUnnamed3271(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
  }
  buildCounterOperationList--;
}

core.int buildCounterRollingUpdateErrorErrors = 0;
buildRollingUpdateErrorErrors() {
  var o = new api.RollingUpdateErrorErrors();
  buildCounterRollingUpdateErrorErrors++;
  if (buildCounterRollingUpdateErrorErrors < 3) {
    o.code = "foo";
    o.location = "foo";
    o.message = "foo";
  }
  buildCounterRollingUpdateErrorErrors--;
  return o;
}

checkRollingUpdateErrorErrors(api.RollingUpdateErrorErrors o) {
  buildCounterRollingUpdateErrorErrors++;
  if (buildCounterRollingUpdateErrorErrors < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    unittest.expect(o.location, unittest.equals('foo'));
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterRollingUpdateErrorErrors--;
}

buildUnnamed3272() {
  var o = new core.List<api.RollingUpdateErrorErrors>();
  o.add(buildRollingUpdateErrorErrors());
  o.add(buildRollingUpdateErrorErrors());
  return o;
}

checkUnnamed3272(core.List<api.RollingUpdateErrorErrors> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRollingUpdateErrorErrors(o[0]);
  checkRollingUpdateErrorErrors(o[1]);
}

core.int buildCounterRollingUpdateError = 0;
buildRollingUpdateError() {
  var o = new api.RollingUpdateError();
  buildCounterRollingUpdateError++;
  if (buildCounterRollingUpdateError < 3) {
    o.errors = buildUnnamed3272();
  }
  buildCounterRollingUpdateError--;
  return o;
}

checkRollingUpdateError(api.RollingUpdateError o) {
  buildCounterRollingUpdateError++;
  if (buildCounterRollingUpdateError < 3) {
    checkUnnamed3272(o.errors);
  }
  buildCounterRollingUpdateError--;
}

core.int buildCounterRollingUpdatePolicy = 0;
buildRollingUpdatePolicy() {
  var o = new api.RollingUpdatePolicy();
  buildCounterRollingUpdatePolicy++;
  if (buildCounterRollingUpdatePolicy < 3) {
    o.autoPauseAfterInstances = 42;
    o.instanceStartupTimeoutSec = 42;
    o.maxNumConcurrentInstances = 42;
    o.maxNumFailedInstances = 42;
    o.minInstanceUpdateTimeSec = 42;
  }
  buildCounterRollingUpdatePolicy--;
  return o;
}

checkRollingUpdatePolicy(api.RollingUpdatePolicy o) {
  buildCounterRollingUpdatePolicy++;
  if (buildCounterRollingUpdatePolicy < 3) {
    unittest.expect(o.autoPauseAfterInstances, unittest.equals(42));
    unittest.expect(o.instanceStartupTimeoutSec, unittest.equals(42));
    unittest.expect(o.maxNumConcurrentInstances, unittest.equals(42));
    unittest.expect(o.maxNumFailedInstances, unittest.equals(42));
    unittest.expect(o.minInstanceUpdateTimeSec, unittest.equals(42));
  }
  buildCounterRollingUpdatePolicy--;
}

core.int buildCounterRollingUpdate = 0;
buildRollingUpdate() {
  var o = new api.RollingUpdate();
  buildCounterRollingUpdate++;
  if (buildCounterRollingUpdate < 3) {
    o.actionType = "foo";
    o.creationTimestamp = "foo";
    o.description = "foo";
    o.error = buildRollingUpdateError();
    o.id = "foo";
    o.instanceGroup = "foo";
    o.instanceGroupManager = "foo";
    o.instanceTemplate = "foo";
    o.kind = "foo";
    o.oldInstanceTemplate = "foo";
    o.policy = buildRollingUpdatePolicy();
    o.progress = 42;
    o.selfLink = "foo";
    o.status = "foo";
    o.statusMessage = "foo";
    o.user = "foo";
  }
  buildCounterRollingUpdate--;
  return o;
}

checkRollingUpdate(api.RollingUpdate o) {
  buildCounterRollingUpdate++;
  if (buildCounterRollingUpdate < 3) {
    unittest.expect(o.actionType, unittest.equals('foo'));
    unittest.expect(o.creationTimestamp, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    checkRollingUpdateError(o.error);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.instanceGroup, unittest.equals('foo'));
    unittest.expect(o.instanceGroupManager, unittest.equals('foo'));
    unittest.expect(o.instanceTemplate, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.oldInstanceTemplate, unittest.equals('foo'));
    checkRollingUpdatePolicy(o.policy);
    unittest.expect(o.progress, unittest.equals(42));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.statusMessage, unittest.equals('foo'));
    unittest.expect(o.user, unittest.equals('foo'));
  }
  buildCounterRollingUpdate--;
}

buildUnnamed3273() {
  var o = new core.List<api.RollingUpdate>();
  o.add(buildRollingUpdate());
  o.add(buildRollingUpdate());
  return o;
}

checkUnnamed3273(core.List<api.RollingUpdate> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRollingUpdate(o[0]);
  checkRollingUpdate(o[1]);
}

core.int buildCounterRollingUpdateList = 0;
buildRollingUpdateList() {
  var o = new api.RollingUpdateList();
  buildCounterRollingUpdateList++;
  if (buildCounterRollingUpdateList < 3) {
    o.items = buildUnnamed3273();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.selfLink = "foo";
  }
  buildCounterRollingUpdateList--;
  return o;
}

checkRollingUpdateList(api.RollingUpdateList o) {
  buildCounterRollingUpdateList++;
  if (buildCounterRollingUpdateList < 3) {
    checkUnnamed3273(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
  }
  buildCounterRollingUpdateList--;
}

main() {
  unittest.group("obj-schema-InstanceUpdateErrorErrors", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceUpdateErrorErrors();
      var od = new api.InstanceUpdateErrorErrors.fromJson(o.toJson());
      checkInstanceUpdateErrorErrors(od);
    });
  });

  unittest.group("obj-schema-InstanceUpdateError", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceUpdateError();
      var od = new api.InstanceUpdateError.fromJson(o.toJson());
      checkInstanceUpdateError(od);
    });
  });

  unittest.group("obj-schema-InstanceUpdate", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceUpdate();
      var od = new api.InstanceUpdate.fromJson(o.toJson());
      checkInstanceUpdate(od);
    });
  });

  unittest.group("obj-schema-InstanceUpdateList", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceUpdateList();
      var od = new api.InstanceUpdateList.fromJson(o.toJson());
      checkInstanceUpdateList(od);
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

  unittest.group("obj-schema-RollingUpdateErrorErrors", () {
    unittest.test("to-json--from-json", () {
      var o = buildRollingUpdateErrorErrors();
      var od = new api.RollingUpdateErrorErrors.fromJson(o.toJson());
      checkRollingUpdateErrorErrors(od);
    });
  });

  unittest.group("obj-schema-RollingUpdateError", () {
    unittest.test("to-json--from-json", () {
      var o = buildRollingUpdateError();
      var od = new api.RollingUpdateError.fromJson(o.toJson());
      checkRollingUpdateError(od);
    });
  });

  unittest.group("obj-schema-RollingUpdatePolicy", () {
    unittest.test("to-json--from-json", () {
      var o = buildRollingUpdatePolicy();
      var od = new api.RollingUpdatePolicy.fromJson(o.toJson());
      checkRollingUpdatePolicy(od);
    });
  });

  unittest.group("obj-schema-RollingUpdate", () {
    unittest.test("to-json--from-json", () {
      var o = buildRollingUpdate();
      var od = new api.RollingUpdate.fromJson(o.toJson());
      checkRollingUpdate(od);
    });
  });

  unittest.group("obj-schema-RollingUpdateList", () {
    unittest.test("to-json--from-json", () {
      var o = buildRollingUpdateList();
      var od = new api.RollingUpdateList.fromJson(o.toJson());
      checkRollingUpdateList(od);
    });
  });

  unittest.group("resource-RollingUpdatesResourceApi", () {
    unittest.test("method--cancel", () {
      var mock = new HttpServerMock();
      api.RollingUpdatesResourceApi res =
          new api.ReplicapoolupdaterApi(mock).rollingUpdates;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_rollingUpdate = "foo";
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
          .cancel(arg_project, arg_zone, arg_rollingUpdate)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.RollingUpdatesResourceApi res =
          new api.ReplicapoolupdaterApi(mock).rollingUpdates;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_rollingUpdate = "foo";
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
        var resp = convert.JSON.encode(buildRollingUpdate());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_zone, arg_rollingUpdate)
          .then(unittest.expectAsync1(((api.RollingUpdate response) {
        checkRollingUpdate(response);
      })));
    });

    unittest.test("method--insert", () {
      var mock = new HttpServerMock();
      api.RollingUpdatesResourceApi res =
          new api.ReplicapoolupdaterApi(mock).rollingUpdates;
      var arg_request = buildRollingUpdate();
      var arg_project = "foo";
      var arg_zone = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.RollingUpdate.fromJson(json);
        checkRollingUpdate(obj);

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
      api.RollingUpdatesResourceApi res =
          new api.ReplicapoolupdaterApi(mock).rollingUpdates;
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
        var resp = convert.JSON.encode(buildRollingUpdateList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_zone,
              filter: arg_filter,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken)
          .then(unittest.expectAsync1(((api.RollingUpdateList response) {
        checkRollingUpdateList(response);
      })));
    });

    unittest.test("method--listInstanceUpdates", () {
      var mock = new HttpServerMock();
      api.RollingUpdatesResourceApi res =
          new api.ReplicapoolupdaterApi(mock).rollingUpdates;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_rollingUpdate = "foo";
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
        var resp = convert.JSON.encode(buildInstanceUpdateList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .listInstanceUpdates(arg_project, arg_zone, arg_rollingUpdate,
              filter: arg_filter,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken)
          .then(unittest.expectAsync1(((api.InstanceUpdateList response) {
        checkInstanceUpdateList(response);
      })));
    });

    unittest.test("method--pause", () {
      var mock = new HttpServerMock();
      api.RollingUpdatesResourceApi res =
          new api.ReplicapoolupdaterApi(mock).rollingUpdates;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_rollingUpdate = "foo";
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
          .pause(arg_project, arg_zone, arg_rollingUpdate)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--resume", () {
      var mock = new HttpServerMock();
      api.RollingUpdatesResourceApi res =
          new api.ReplicapoolupdaterApi(mock).rollingUpdates;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_rollingUpdate = "foo";
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
          .resume(arg_project, arg_zone, arg_rollingUpdate)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--rollback", () {
      var mock = new HttpServerMock();
      api.RollingUpdatesResourceApi res =
          new api.ReplicapoolupdaterApi(mock).rollingUpdates;
      var arg_project = "foo";
      var arg_zone = "foo";
      var arg_rollingUpdate = "foo";
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
          .rollback(arg_project, arg_zone, arg_rollingUpdate)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });
  });

  unittest.group("resource-ZoneOperationsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.ZoneOperationsResourceApi res =
          new api.ReplicapoolupdaterApi(mock).zoneOperations;
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
          new api.ReplicapoolupdaterApi(mock).zoneOperations;
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
