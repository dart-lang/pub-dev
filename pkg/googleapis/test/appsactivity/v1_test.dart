library googleapis.appsactivity.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/appsactivity/v1.dart' as api;

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

buildUnnamed988() {
  var o = new core.List<api.Event>();
  o.add(buildEvent());
  o.add(buildEvent());
  return o;
}

checkUnnamed988(core.List<api.Event> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEvent(o[0]);
  checkEvent(o[1]);
}

core.int buildCounterActivity = 0;
buildActivity() {
  var o = new api.Activity();
  buildCounterActivity++;
  if (buildCounterActivity < 3) {
    o.combinedEvent = buildEvent();
    o.singleEvents = buildUnnamed988();
  }
  buildCounterActivity--;
  return o;
}

checkActivity(api.Activity o) {
  buildCounterActivity++;
  if (buildCounterActivity < 3) {
    checkEvent(o.combinedEvent);
    checkUnnamed988(o.singleEvents);
  }
  buildCounterActivity--;
}

buildUnnamed989() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed989(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed990() {
  var o = new core.List<api.PermissionChange>();
  o.add(buildPermissionChange());
  o.add(buildPermissionChange());
  return o;
}

checkUnnamed990(core.List<api.PermissionChange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPermissionChange(o[0]);
  checkPermissionChange(o[1]);
}

core.int buildCounterEvent = 0;
buildEvent() {
  var o = new api.Event();
  buildCounterEvent++;
  if (buildCounterEvent < 3) {
    o.additionalEventTypes = buildUnnamed989();
    o.eventTimeMillis = "foo";
    o.fromUserDeletion = true;
    o.move = buildMove();
    o.permissionChanges = buildUnnamed990();
    o.primaryEventType = "foo";
    o.rename = buildRename();
    o.target = buildTarget();
    o.user = buildUser();
  }
  buildCounterEvent--;
  return o;
}

checkEvent(api.Event o) {
  buildCounterEvent++;
  if (buildCounterEvent < 3) {
    checkUnnamed989(o.additionalEventTypes);
    unittest.expect(o.eventTimeMillis, unittest.equals('foo'));
    unittest.expect(o.fromUserDeletion, unittest.isTrue);
    checkMove(o.move);
    checkUnnamed990(o.permissionChanges);
    unittest.expect(o.primaryEventType, unittest.equals('foo'));
    checkRename(o.rename);
    checkTarget(o.target);
    checkUser(o.user);
  }
  buildCounterEvent--;
}

buildUnnamed991() {
  var o = new core.List<api.Activity>();
  o.add(buildActivity());
  o.add(buildActivity());
  return o;
}

checkUnnamed991(core.List<api.Activity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkActivity(o[0]);
  checkActivity(o[1]);
}

core.int buildCounterListActivitiesResponse = 0;
buildListActivitiesResponse() {
  var o = new api.ListActivitiesResponse();
  buildCounterListActivitiesResponse++;
  if (buildCounterListActivitiesResponse < 3) {
    o.activities = buildUnnamed991();
    o.nextPageToken = "foo";
  }
  buildCounterListActivitiesResponse--;
  return o;
}

checkListActivitiesResponse(api.ListActivitiesResponse o) {
  buildCounterListActivitiesResponse++;
  if (buildCounterListActivitiesResponse < 3) {
    checkUnnamed991(o.activities);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListActivitiesResponse--;
}

buildUnnamed992() {
  var o = new core.List<api.Parent>();
  o.add(buildParent());
  o.add(buildParent());
  return o;
}

checkUnnamed992(core.List<api.Parent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParent(o[0]);
  checkParent(o[1]);
}

buildUnnamed993() {
  var o = new core.List<api.Parent>();
  o.add(buildParent());
  o.add(buildParent());
  return o;
}

checkUnnamed993(core.List<api.Parent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParent(o[0]);
  checkParent(o[1]);
}

core.int buildCounterMove = 0;
buildMove() {
  var o = new api.Move();
  buildCounterMove++;
  if (buildCounterMove < 3) {
    o.addedParents = buildUnnamed992();
    o.removedParents = buildUnnamed993();
  }
  buildCounterMove--;
  return o;
}

checkMove(api.Move o) {
  buildCounterMove++;
  if (buildCounterMove < 3) {
    checkUnnamed992(o.addedParents);
    checkUnnamed993(o.removedParents);
  }
  buildCounterMove--;
}

core.int buildCounterParent = 0;
buildParent() {
  var o = new api.Parent();
  buildCounterParent++;
  if (buildCounterParent < 3) {
    o.id = "foo";
    o.isRoot = true;
    o.title = "foo";
  }
  buildCounterParent--;
  return o;
}

checkParent(api.Parent o) {
  buildCounterParent++;
  if (buildCounterParent < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.isRoot, unittest.isTrue);
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterParent--;
}

core.int buildCounterPermission = 0;
buildPermission() {
  var o = new api.Permission();
  buildCounterPermission++;
  if (buildCounterPermission < 3) {
    o.name = "foo";
    o.permissionId = "foo";
    o.role = "foo";
    o.type = "foo";
    o.user = buildUser();
    o.withLink = true;
  }
  buildCounterPermission--;
  return o;
}

checkPermission(api.Permission o) {
  buildCounterPermission++;
  if (buildCounterPermission < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.permissionId, unittest.equals('foo'));
    unittest.expect(o.role, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    checkUser(o.user);
    unittest.expect(o.withLink, unittest.isTrue);
  }
  buildCounterPermission--;
}

buildUnnamed994() {
  var o = new core.List<api.Permission>();
  o.add(buildPermission());
  o.add(buildPermission());
  return o;
}

checkUnnamed994(core.List<api.Permission> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPermission(o[0]);
  checkPermission(o[1]);
}

buildUnnamed995() {
  var o = new core.List<api.Permission>();
  o.add(buildPermission());
  o.add(buildPermission());
  return o;
}

checkUnnamed995(core.List<api.Permission> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPermission(o[0]);
  checkPermission(o[1]);
}

core.int buildCounterPermissionChange = 0;
buildPermissionChange() {
  var o = new api.PermissionChange();
  buildCounterPermissionChange++;
  if (buildCounterPermissionChange < 3) {
    o.addedPermissions = buildUnnamed994();
    o.removedPermissions = buildUnnamed995();
  }
  buildCounterPermissionChange--;
  return o;
}

checkPermissionChange(api.PermissionChange o) {
  buildCounterPermissionChange++;
  if (buildCounterPermissionChange < 3) {
    checkUnnamed994(o.addedPermissions);
    checkUnnamed995(o.removedPermissions);
  }
  buildCounterPermissionChange--;
}

core.int buildCounterPhoto = 0;
buildPhoto() {
  var o = new api.Photo();
  buildCounterPhoto++;
  if (buildCounterPhoto < 3) {
    o.url = "foo";
  }
  buildCounterPhoto--;
  return o;
}

checkPhoto(api.Photo o) {
  buildCounterPhoto++;
  if (buildCounterPhoto < 3) {
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterPhoto--;
}

core.int buildCounterRename = 0;
buildRename() {
  var o = new api.Rename();
  buildCounterRename++;
  if (buildCounterRename < 3) {
    o.newTitle = "foo";
    o.oldTitle = "foo";
  }
  buildCounterRename--;
  return o;
}

checkRename(api.Rename o) {
  buildCounterRename++;
  if (buildCounterRename < 3) {
    unittest.expect(o.newTitle, unittest.equals('foo'));
    unittest.expect(o.oldTitle, unittest.equals('foo'));
  }
  buildCounterRename--;
}

core.int buildCounterTarget = 0;
buildTarget() {
  var o = new api.Target();
  buildCounterTarget++;
  if (buildCounterTarget < 3) {
    o.id = "foo";
    o.mimeType = "foo";
    o.name = "foo";
  }
  buildCounterTarget--;
  return o;
}

checkTarget(api.Target o) {
  buildCounterTarget++;
  if (buildCounterTarget < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.mimeType, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterTarget--;
}

core.int buildCounterUser = 0;
buildUser() {
  var o = new api.User();
  buildCounterUser++;
  if (buildCounterUser < 3) {
    o.isDeleted = true;
    o.isMe = true;
    o.name = "foo";
    o.permissionId = "foo";
    o.photo = buildPhoto();
  }
  buildCounterUser--;
  return o;
}

checkUser(api.User o) {
  buildCounterUser++;
  if (buildCounterUser < 3) {
    unittest.expect(o.isDeleted, unittest.isTrue);
    unittest.expect(o.isMe, unittest.isTrue);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.permissionId, unittest.equals('foo'));
    checkPhoto(o.photo);
  }
  buildCounterUser--;
}


main() {
  unittest.group("obj-schema-Activity", () {
    unittest.test("to-json--from-json", () {
      var o = buildActivity();
      var od = new api.Activity.fromJson(o.toJson());
      checkActivity(od);
    });
  });


  unittest.group("obj-schema-Event", () {
    unittest.test("to-json--from-json", () {
      var o = buildEvent();
      var od = new api.Event.fromJson(o.toJson());
      checkEvent(od);
    });
  });


  unittest.group("obj-schema-ListActivitiesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListActivitiesResponse();
      var od = new api.ListActivitiesResponse.fromJson(o.toJson());
      checkListActivitiesResponse(od);
    });
  });


  unittest.group("obj-schema-Move", () {
    unittest.test("to-json--from-json", () {
      var o = buildMove();
      var od = new api.Move.fromJson(o.toJson());
      checkMove(od);
    });
  });


  unittest.group("obj-schema-Parent", () {
    unittest.test("to-json--from-json", () {
      var o = buildParent();
      var od = new api.Parent.fromJson(o.toJson());
      checkParent(od);
    });
  });


  unittest.group("obj-schema-Permission", () {
    unittest.test("to-json--from-json", () {
      var o = buildPermission();
      var od = new api.Permission.fromJson(o.toJson());
      checkPermission(od);
    });
  });


  unittest.group("obj-schema-PermissionChange", () {
    unittest.test("to-json--from-json", () {
      var o = buildPermissionChange();
      var od = new api.PermissionChange.fromJson(o.toJson());
      checkPermissionChange(od);
    });
  });


  unittest.group("obj-schema-Photo", () {
    unittest.test("to-json--from-json", () {
      var o = buildPhoto();
      var od = new api.Photo.fromJson(o.toJson());
      checkPhoto(od);
    });
  });


  unittest.group("obj-schema-Rename", () {
    unittest.test("to-json--from-json", () {
      var o = buildRename();
      var od = new api.Rename.fromJson(o.toJson());
      checkRename(od);
    });
  });


  unittest.group("obj-schema-Target", () {
    unittest.test("to-json--from-json", () {
      var o = buildTarget();
      var od = new api.Target.fromJson(o.toJson());
      checkTarget(od);
    });
  });


  unittest.group("obj-schema-User", () {
    unittest.test("to-json--from-json", () {
      var o = buildUser();
      var od = new api.User.fromJson(o.toJson());
      checkUser(od);
    });
  });


  unittest.group("resource-ActivitiesResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.ActivitiesResourceApi res = new api.AppsactivityApi(mock).activities;
      var arg_drive_ancestorId = "foo";
      var arg_drive_fileId = "foo";
      var arg_groupingStrategy = "foo";
      var arg_pageSize = 42;
      var arg_pageToken = "foo";
      var arg_source = "foo";
      var arg_userId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("appsactivity/v1/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("activities"));
        pathOffset += 10;

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
        unittest.expect(queryMap["drive.ancestorId"].first, unittest.equals(arg_drive_ancestorId));
        unittest.expect(queryMap["drive.fileId"].first, unittest.equals(arg_drive_fileId));
        unittest.expect(queryMap["groupingStrategy"].first, unittest.equals(arg_groupingStrategy));
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(queryMap["userId"].first, unittest.equals(arg_userId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListActivitiesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(drive_ancestorId: arg_drive_ancestorId, drive_fileId: arg_drive_fileId, groupingStrategy: arg_groupingStrategy, pageSize: arg_pageSize, pageToken: arg_pageToken, source: arg_source, userId: arg_userId).then(unittest.expectAsync(((api.ListActivitiesResponse response) {
        checkListActivitiesResponse(response);
      })));
    });

  });


}

