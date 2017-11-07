library googleapis_beta.taskqueue.v1beta2.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis_beta/taskqueue/v1beta2.dart' as api;

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

core.int buildCounterTask = 0;
buildTask() {
  var o = new api.Task();
  buildCounterTask++;
  if (buildCounterTask < 3) {
    o.enqueueTimestamp = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.leaseTimestamp = "foo";
    o.payloadBase64 = "foo";
    o.queueName = "foo";
    o.retryCount = 42;
    o.tag = "foo";
  }
  buildCounterTask--;
  return o;
}

checkTask(api.Task o) {
  buildCounterTask++;
  if (buildCounterTask < 3) {
    unittest.expect(o.enqueueTimestamp, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.leaseTimestamp, unittest.equals('foo'));
    unittest.expect(o.payloadBase64, unittest.equals('foo'));
    unittest.expect(o.queueName, unittest.equals('foo'));
    unittest.expect(o.retryCount, unittest.equals(42));
    unittest.expect(o.tag, unittest.equals('foo'));
  }
  buildCounterTask--;
}

buildUnnamed3328() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3328(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3329() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3329(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3330() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3330(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterTaskQueueAcl = 0;
buildTaskQueueAcl() {
  var o = new api.TaskQueueAcl();
  buildCounterTaskQueueAcl++;
  if (buildCounterTaskQueueAcl < 3) {
    o.adminEmails = buildUnnamed3328();
    o.consumerEmails = buildUnnamed3329();
    o.producerEmails = buildUnnamed3330();
  }
  buildCounterTaskQueueAcl--;
  return o;
}

checkTaskQueueAcl(api.TaskQueueAcl o) {
  buildCounterTaskQueueAcl++;
  if (buildCounterTaskQueueAcl < 3) {
    checkUnnamed3328(o.adminEmails);
    checkUnnamed3329(o.consumerEmails);
    checkUnnamed3330(o.producerEmails);
  }
  buildCounterTaskQueueAcl--;
}

core.int buildCounterTaskQueueStats = 0;
buildTaskQueueStats() {
  var o = new api.TaskQueueStats();
  buildCounterTaskQueueStats++;
  if (buildCounterTaskQueueStats < 3) {
    o.leasedLastHour = "foo";
    o.leasedLastMinute = "foo";
    o.oldestTask = "foo";
    o.totalTasks = 42;
  }
  buildCounterTaskQueueStats--;
  return o;
}

checkTaskQueueStats(api.TaskQueueStats o) {
  buildCounterTaskQueueStats++;
  if (buildCounterTaskQueueStats < 3) {
    unittest.expect(o.leasedLastHour, unittest.equals('foo'));
    unittest.expect(o.leasedLastMinute, unittest.equals('foo'));
    unittest.expect(o.oldestTask, unittest.equals('foo'));
    unittest.expect(o.totalTasks, unittest.equals(42));
  }
  buildCounterTaskQueueStats--;
}

core.int buildCounterTaskQueue = 0;
buildTaskQueue() {
  var o = new api.TaskQueue();
  buildCounterTaskQueue++;
  if (buildCounterTaskQueue < 3) {
    o.acl = buildTaskQueueAcl();
    o.id = "foo";
    o.kind = "foo";
    o.maxLeases = 42;
    o.stats = buildTaskQueueStats();
  }
  buildCounterTaskQueue--;
  return o;
}

checkTaskQueue(api.TaskQueue o) {
  buildCounterTaskQueue++;
  if (buildCounterTaskQueue < 3) {
    checkTaskQueueAcl(o.acl);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.maxLeases, unittest.equals(42));
    checkTaskQueueStats(o.stats);
  }
  buildCounterTaskQueue--;
}

buildUnnamed3331() {
  var o = new core.List<api.Task>();
  o.add(buildTask());
  o.add(buildTask());
  return o;
}

checkUnnamed3331(core.List<api.Task> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTask(o[0]);
  checkTask(o[1]);
}

core.int buildCounterTasks = 0;
buildTasks() {
  var o = new api.Tasks();
  buildCounterTasks++;
  if (buildCounterTasks < 3) {
    o.items = buildUnnamed3331();
    o.kind = "foo";
  }
  buildCounterTasks--;
  return o;
}

checkTasks(api.Tasks o) {
  buildCounterTasks++;
  if (buildCounterTasks < 3) {
    checkUnnamed3331(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterTasks--;
}

buildUnnamed3332() {
  var o = new core.List<api.Task>();
  o.add(buildTask());
  o.add(buildTask());
  return o;
}

checkUnnamed3332(core.List<api.Task> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTask(o[0]);
  checkTask(o[1]);
}

core.int buildCounterTasks2 = 0;
buildTasks2() {
  var o = new api.Tasks2();
  buildCounterTasks2++;
  if (buildCounterTasks2 < 3) {
    o.items = buildUnnamed3332();
    o.kind = "foo";
  }
  buildCounterTasks2--;
  return o;
}

checkTasks2(api.Tasks2 o) {
  buildCounterTasks2++;
  if (buildCounterTasks2 < 3) {
    checkUnnamed3332(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterTasks2--;
}

main() {
  unittest.group("obj-schema-Task", () {
    unittest.test("to-json--from-json", () {
      var o = buildTask();
      var od = new api.Task.fromJson(o.toJson());
      checkTask(od);
    });
  });

  unittest.group("obj-schema-TaskQueueAcl", () {
    unittest.test("to-json--from-json", () {
      var o = buildTaskQueueAcl();
      var od = new api.TaskQueueAcl.fromJson(o.toJson());
      checkTaskQueueAcl(od);
    });
  });

  unittest.group("obj-schema-TaskQueueStats", () {
    unittest.test("to-json--from-json", () {
      var o = buildTaskQueueStats();
      var od = new api.TaskQueueStats.fromJson(o.toJson());
      checkTaskQueueStats(od);
    });
  });

  unittest.group("obj-schema-TaskQueue", () {
    unittest.test("to-json--from-json", () {
      var o = buildTaskQueue();
      var od = new api.TaskQueue.fromJson(o.toJson());
      checkTaskQueue(od);
    });
  });

  unittest.group("obj-schema-Tasks", () {
    unittest.test("to-json--from-json", () {
      var o = buildTasks();
      var od = new api.Tasks.fromJson(o.toJson());
      checkTasks(od);
    });
  });

  unittest.group("obj-schema-Tasks2", () {
    unittest.test("to-json--from-json", () {
      var o = buildTasks2();
      var od = new api.Tasks2.fromJson(o.toJson());
      checkTasks2(od);
    });
  });

  unittest.group("resource-TaskqueuesResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.TaskqueuesResourceApi res = new api.TaskqueueApi(mock).taskqueues;
      var arg_project = "foo";
      var arg_taskqueue = "foo";
      var arg_getStats = true;
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
            queryMap["getStats"].first, unittest.equals("$arg_getStats"));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTaskQueue());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_taskqueue, getStats: arg_getStats)
          .then(unittest.expectAsync1(((api.TaskQueue response) {
        checkTaskQueue(response);
      })));
    });
  });

  unittest.group("resource-TasksResourceApi", () {
    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TaskqueueApi(mock).tasks;
      var arg_project = "foo";
      var arg_taskqueue = "foo";
      var arg_task = "foo";
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
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_project, arg_taskqueue, arg_task)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TaskqueueApi(mock).tasks;
      var arg_project = "foo";
      var arg_taskqueue = "foo";
      var arg_task = "foo";
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
        var resp = convert.JSON.encode(buildTask());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_taskqueue, arg_task)
          .then(unittest.expectAsync1(((api.Task response) {
        checkTask(response);
      })));
    });

    unittest.test("method--insert", () {
      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TaskqueueApi(mock).tasks;
      var arg_request = buildTask();
      var arg_project = "foo";
      var arg_taskqueue = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Task.fromJson(json);
        checkTask(obj);

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
        var resp = convert.JSON.encode(buildTask());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .insert(arg_request, arg_project, arg_taskqueue)
          .then(unittest.expectAsync1(((api.Task response) {
        checkTask(response);
      })));
    });

    unittest.test("method--lease", () {
      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TaskqueueApi(mock).tasks;
      var arg_project = "foo";
      var arg_taskqueue = "foo";
      var arg_numTasks = 42;
      var arg_leaseSecs = 42;
      var arg_groupByTag = true;
      var arg_tag = "foo";
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
        unittest.expect(core.int.parse(queryMap["numTasks"].first),
            unittest.equals(arg_numTasks));
        unittest.expect(core.int.parse(queryMap["leaseSecs"].first),
            unittest.equals(arg_leaseSecs));
        unittest.expect(
            queryMap["groupByTag"].first, unittest.equals("$arg_groupByTag"));
        unittest.expect(queryMap["tag"].first, unittest.equals(arg_tag));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTasks());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .lease(arg_project, arg_taskqueue, arg_numTasks, arg_leaseSecs,
              groupByTag: arg_groupByTag, tag: arg_tag)
          .then(unittest.expectAsync1(((api.Tasks response) {
        checkTasks(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TaskqueueApi(mock).tasks;
      var arg_project = "foo";
      var arg_taskqueue = "foo";
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
        var resp = convert.JSON.encode(buildTasks2());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_taskqueue)
          .then(unittest.expectAsync1(((api.Tasks2 response) {
        checkTasks2(response);
      })));
    });

    unittest.test("method--patch", () {
      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TaskqueueApi(mock).tasks;
      var arg_request = buildTask();
      var arg_project = "foo";
      var arg_taskqueue = "foo";
      var arg_task = "foo";
      var arg_newLeaseSeconds = 42;
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Task.fromJson(json);
        checkTask(obj);

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
        unittest.expect(core.int.parse(queryMap["newLeaseSeconds"].first),
            unittest.equals(arg_newLeaseSeconds));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTask());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .patch(arg_request, arg_project, arg_taskqueue, arg_task,
              arg_newLeaseSeconds)
          .then(unittest.expectAsync1(((api.Task response) {
        checkTask(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TaskqueueApi(mock).tasks;
      var arg_request = buildTask();
      var arg_project = "foo";
      var arg_taskqueue = "foo";
      var arg_task = "foo";
      var arg_newLeaseSeconds = 42;
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Task.fromJson(json);
        checkTask(obj);

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
        unittest.expect(core.int.parse(queryMap["newLeaseSeconds"].first),
            unittest.equals(arg_newLeaseSeconds));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTask());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_project, arg_taskqueue, arg_task,
              arg_newLeaseSeconds)
          .then(unittest.expectAsync1(((api.Task response) {
        checkTask(response);
      })));
    });
  });
}
