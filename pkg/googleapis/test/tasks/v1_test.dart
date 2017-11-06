library googleapis.tasks.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/tasks/v1.dart' as api;

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

core.int buildCounterTaskLinks = 0;
buildTaskLinks() {
  var o = new api.TaskLinks();
  buildCounterTaskLinks++;
  if (buildCounterTaskLinks < 3) {
    o.description = "foo";
    o.link = "foo";
    o.type = "foo";
  }
  buildCounterTaskLinks--;
  return o;
}

checkTaskLinks(api.TaskLinks o) {
  buildCounterTaskLinks++;
  if (buildCounterTaskLinks < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.link, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterTaskLinks--;
}

buildUnnamed2886() {
  var o = new core.List<api.TaskLinks>();
  o.add(buildTaskLinks());
  o.add(buildTaskLinks());
  return o;
}

checkUnnamed2886(core.List<api.TaskLinks> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTaskLinks(o[0]);
  checkTaskLinks(o[1]);
}

core.int buildCounterTask = 0;
buildTask() {
  var o = new api.Task();
  buildCounterTask++;
  if (buildCounterTask < 3) {
    o.completed = core.DateTime.parse("2002-02-27T14:01:02");
    o.deleted = true;
    o.due = core.DateTime.parse("2002-02-27T14:01:02");
    o.etag = "foo";
    o.hidden = true;
    o.id = "foo";
    o.kind = "foo";
    o.links = buildUnnamed2886();
    o.notes = "foo";
    o.parent = "foo";
    o.position = "foo";
    o.selfLink = "foo";
    o.status = "foo";
    o.title = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
  }
  buildCounterTask--;
  return o;
}

checkTask(api.Task o) {
  buildCounterTask++;
  if (buildCounterTask < 3) {
    unittest.expect(o.completed, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.deleted, unittest.isTrue);
    unittest.expect(o.due, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.hidden, unittest.isTrue);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed2886(o.links);
    unittest.expect(o.notes, unittest.equals('foo'));
    unittest.expect(o.parent, unittest.equals('foo'));
    unittest.expect(o.position, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
  }
  buildCounterTask--;
}

core.int buildCounterTaskList = 0;
buildTaskList() {
  var o = new api.TaskList();
  buildCounterTaskList++;
  if (buildCounterTaskList < 3) {
    o.etag = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.selfLink = "foo";
    o.title = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
  }
  buildCounterTaskList--;
  return o;
}

checkTaskList(api.TaskList o) {
  buildCounterTaskList++;
  if (buildCounterTaskList < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
  }
  buildCounterTaskList--;
}

buildUnnamed2887() {
  var o = new core.List<api.TaskList>();
  o.add(buildTaskList());
  o.add(buildTaskList());
  return o;
}

checkUnnamed2887(core.List<api.TaskList> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTaskList(o[0]);
  checkTaskList(o[1]);
}

core.int buildCounterTaskLists = 0;
buildTaskLists() {
  var o = new api.TaskLists();
  buildCounterTaskLists++;
  if (buildCounterTaskLists < 3) {
    o.etag = "foo";
    o.items = buildUnnamed2887();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterTaskLists--;
  return o;
}

checkTaskLists(api.TaskLists o) {
  buildCounterTaskLists++;
  if (buildCounterTaskLists < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed2887(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterTaskLists--;
}

buildUnnamed2888() {
  var o = new core.List<api.Task>();
  o.add(buildTask());
  o.add(buildTask());
  return o;
}

checkUnnamed2888(core.List<api.Task> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTask(o[0]);
  checkTask(o[1]);
}

core.int buildCounterTasks = 0;
buildTasks() {
  var o = new api.Tasks();
  buildCounterTasks++;
  if (buildCounterTasks < 3) {
    o.etag = "foo";
    o.items = buildUnnamed2888();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterTasks--;
  return o;
}

checkTasks(api.Tasks o) {
  buildCounterTasks++;
  if (buildCounterTasks < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed2888(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterTasks--;
}


main() {
  unittest.group("obj-schema-TaskLinks", () {
    unittest.test("to-json--from-json", () {
      var o = buildTaskLinks();
      var od = new api.TaskLinks.fromJson(o.toJson());
      checkTaskLinks(od);
    });
  });


  unittest.group("obj-schema-Task", () {
    unittest.test("to-json--from-json", () {
      var o = buildTask();
      var od = new api.Task.fromJson(o.toJson());
      checkTask(od);
    });
  });


  unittest.group("obj-schema-TaskList", () {
    unittest.test("to-json--from-json", () {
      var o = buildTaskList();
      var od = new api.TaskList.fromJson(o.toJson());
      checkTaskList(od);
    });
  });


  unittest.group("obj-schema-TaskLists", () {
    unittest.test("to-json--from-json", () {
      var o = buildTaskLists();
      var od = new api.TaskLists.fromJson(o.toJson());
      checkTaskLists(od);
    });
  });


  unittest.group("obj-schema-Tasks", () {
    unittest.test("to-json--from-json", () {
      var o = buildTasks();
      var od = new api.Tasks.fromJson(o.toJson());
      checkTasks(od);
    });
  });


  unittest.group("resource-TasklistsResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.TasklistsResourceApi res = new api.TasksApi(mock).tasklists;
      var arg_tasklist = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("users/@me/lists/"));
        pathOffset += 16;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_tasklist"));

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
      res.delete(arg_tasklist).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.TasklistsResourceApi res = new api.TasksApi(mock).tasklists;
      var arg_tasklist = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("users/@me/lists/"));
        pathOffset += 16;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_tasklist"));

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
        var resp = convert.JSON.encode(buildTaskList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_tasklist).then(unittest.expectAsync(((api.TaskList response) {
        checkTaskList(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.TasklistsResourceApi res = new api.TasksApi(mock).tasklists;
      var arg_request = buildTaskList();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.TaskList.fromJson(json);
        checkTaskList(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("users/@me/lists"));
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
        var resp = convert.JSON.encode(buildTaskList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request).then(unittest.expectAsync(((api.TaskList response) {
        checkTaskList(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.TasklistsResourceApi res = new api.TasksApi(mock).tasklists;
      var arg_maxResults = "foo";
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("users/@me/lists"));
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
        unittest.expect(queryMap["maxResults"].first, unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTaskLists());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.TaskLists response) {
        checkTaskLists(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.TasklistsResourceApi res = new api.TasksApi(mock).tasklists;
      var arg_request = buildTaskList();
      var arg_tasklist = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.TaskList.fromJson(json);
        checkTaskList(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("users/@me/lists/"));
        pathOffset += 16;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_tasklist"));

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
        var resp = convert.JSON.encode(buildTaskList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_tasklist).then(unittest.expectAsync(((api.TaskList response) {
        checkTaskList(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.TasklistsResourceApi res = new api.TasksApi(mock).tasklists;
      var arg_request = buildTaskList();
      var arg_tasklist = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.TaskList.fromJson(json);
        checkTaskList(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("users/@me/lists/"));
        pathOffset += 16;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_tasklist"));

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
        var resp = convert.JSON.encode(buildTaskList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_tasklist).then(unittest.expectAsync(((api.TaskList response) {
        checkTaskList(response);
      })));
    });

  });


  unittest.group("resource-TasksResourceApi", () {
    unittest.test("method--clear", () {

      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TasksApi(mock).tasks;
      var arg_tasklist = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("lists/"));
        pathOffset += 6;
        index = path.indexOf("/clear", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tasklist"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/clear"));
        pathOffset += 6;

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
      res.clear(arg_tasklist).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TasksApi(mock).tasks;
      var arg_tasklist = "foo";
      var arg_task = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("lists/"));
        pathOffset += 6;
        index = path.indexOf("/tasks/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tasklist"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/tasks/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_task"));

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
      res.delete(arg_tasklist, arg_task).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TasksApi(mock).tasks;
      var arg_tasklist = "foo";
      var arg_task = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("lists/"));
        pathOffset += 6;
        index = path.indexOf("/tasks/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tasklist"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/tasks/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_task"));

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
        var resp = convert.JSON.encode(buildTask());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_tasklist, arg_task).then(unittest.expectAsync(((api.Task response) {
        checkTask(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TasksApi(mock).tasks;
      var arg_request = buildTask();
      var arg_tasklist = "foo";
      var arg_parent = "foo";
      var arg_previous = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Task.fromJson(json);
        checkTask(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("lists/"));
        pathOffset += 6;
        index = path.indexOf("/tasks", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tasklist"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/tasks"));
        pathOffset += 6;

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
        unittest.expect(queryMap["parent"].first, unittest.equals(arg_parent));
        unittest.expect(queryMap["previous"].first, unittest.equals(arg_previous));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTask());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_tasklist, parent: arg_parent, previous: arg_previous).then(unittest.expectAsync(((api.Task response) {
        checkTask(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TasksApi(mock).tasks;
      var arg_tasklist = "foo";
      var arg_completedMax = "foo";
      var arg_completedMin = "foo";
      var arg_dueMax = "foo";
      var arg_dueMin = "foo";
      var arg_maxResults = "foo";
      var arg_pageToken = "foo";
      var arg_showCompleted = true;
      var arg_showDeleted = true;
      var arg_showHidden = true;
      var arg_updatedMin = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("lists/"));
        pathOffset += 6;
        index = path.indexOf("/tasks", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tasklist"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/tasks"));
        pathOffset += 6;

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
        unittest.expect(queryMap["completedMax"].first, unittest.equals(arg_completedMax));
        unittest.expect(queryMap["completedMin"].first, unittest.equals(arg_completedMin));
        unittest.expect(queryMap["dueMax"].first, unittest.equals(arg_dueMax));
        unittest.expect(queryMap["dueMin"].first, unittest.equals(arg_dueMin));
        unittest.expect(queryMap["maxResults"].first, unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["showCompleted"].first, unittest.equals("$arg_showCompleted"));
        unittest.expect(queryMap["showDeleted"].first, unittest.equals("$arg_showDeleted"));
        unittest.expect(queryMap["showHidden"].first, unittest.equals("$arg_showHidden"));
        unittest.expect(queryMap["updatedMin"].first, unittest.equals(arg_updatedMin));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTasks());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_tasklist, completedMax: arg_completedMax, completedMin: arg_completedMin, dueMax: arg_dueMax, dueMin: arg_dueMin, maxResults: arg_maxResults, pageToken: arg_pageToken, showCompleted: arg_showCompleted, showDeleted: arg_showDeleted, showHidden: arg_showHidden, updatedMin: arg_updatedMin).then(unittest.expectAsync(((api.Tasks response) {
        checkTasks(response);
      })));
    });

    unittest.test("method--move", () {

      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TasksApi(mock).tasks;
      var arg_tasklist = "foo";
      var arg_task = "foo";
      var arg_parent = "foo";
      var arg_previous = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("lists/"));
        pathOffset += 6;
        index = path.indexOf("/tasks/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tasklist"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/tasks/"));
        pathOffset += 7;
        index = path.indexOf("/move", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_task"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/move"));
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
        unittest.expect(queryMap["parent"].first, unittest.equals(arg_parent));
        unittest.expect(queryMap["previous"].first, unittest.equals(arg_previous));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTask());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.move(arg_tasklist, arg_task, parent: arg_parent, previous: arg_previous).then(unittest.expectAsync(((api.Task response) {
        checkTask(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TasksApi(mock).tasks;
      var arg_request = buildTask();
      var arg_tasklist = "foo";
      var arg_task = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Task.fromJson(json);
        checkTask(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("lists/"));
        pathOffset += 6;
        index = path.indexOf("/tasks/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tasklist"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/tasks/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_task"));

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
        var resp = convert.JSON.encode(buildTask());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_tasklist, arg_task).then(unittest.expectAsync(((api.Task response) {
        checkTask(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.TasksResourceApi res = new api.TasksApi(mock).tasks;
      var arg_request = buildTask();
      var arg_tasklist = "foo";
      var arg_task = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Task.fromJson(json);
        checkTask(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("tasks/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("lists/"));
        pathOffset += 6;
        index = path.indexOf("/tasks/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tasklist"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/tasks/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_task"));

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
        var resp = convert.JSON.encode(buildTask());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_tasklist, arg_task).then(unittest.expectAsync(((api.Task response) {
        checkTask(response);
      })));
    });

  });


}

