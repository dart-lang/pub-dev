library googleapis.groupssettings.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/groupssettings/v1.dart' as api;

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

core.int buildCounterGroups = 0;
buildGroups() {
  var o = new api.Groups();
  buildCounterGroups++;
  if (buildCounterGroups < 3) {
    o.allowExternalMembers = "foo";
    o.allowGoogleCommunication = "foo";
    o.allowWebPosting = "foo";
    o.archiveOnly = "foo";
    o.customFooterText = "foo";
    o.customReplyTo = "foo";
    o.defaultMessageDenyNotificationText = "foo";
    o.description = "foo";
    o.email = "foo";
    o.includeCustomFooter = "foo";
    o.includeInGlobalAddressList = "foo";
    o.isArchived = "foo";
    o.kind = "foo";
    o.maxMessageBytes = 42;
    o.membersCanPostAsTheGroup = "foo";
    o.messageDisplayFont = "foo";
    o.messageModerationLevel = "foo";
    o.name = "foo";
    o.primaryLanguage = "foo";
    o.replyTo = "foo";
    o.sendMessageDenyNotification = "foo";
    o.showInGroupDirectory = "foo";
    o.spamModerationLevel = "foo";
    o.whoCanAdd = "foo";
    o.whoCanContactOwner = "foo";
    o.whoCanInvite = "foo";
    o.whoCanJoin = "foo";
    o.whoCanLeaveGroup = "foo";
    o.whoCanPostMessage = "foo";
    o.whoCanViewGroup = "foo";
    o.whoCanViewMembership = "foo";
  }
  buildCounterGroups--;
  return o;
}

checkGroups(api.Groups o) {
  buildCounterGroups++;
  if (buildCounterGroups < 3) {
    unittest.expect(o.allowExternalMembers, unittest.equals('foo'));
    unittest.expect(o.allowGoogleCommunication, unittest.equals('foo'));
    unittest.expect(o.allowWebPosting, unittest.equals('foo'));
    unittest.expect(o.archiveOnly, unittest.equals('foo'));
    unittest.expect(o.customFooterText, unittest.equals('foo'));
    unittest.expect(o.customReplyTo, unittest.equals('foo'));
    unittest.expect(o.defaultMessageDenyNotificationText, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.email, unittest.equals('foo'));
    unittest.expect(o.includeCustomFooter, unittest.equals('foo'));
    unittest.expect(o.includeInGlobalAddressList, unittest.equals('foo'));
    unittest.expect(o.isArchived, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.maxMessageBytes, unittest.equals(42));
    unittest.expect(o.membersCanPostAsTheGroup, unittest.equals('foo'));
    unittest.expect(o.messageDisplayFont, unittest.equals('foo'));
    unittest.expect(o.messageModerationLevel, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.primaryLanguage, unittest.equals('foo'));
    unittest.expect(o.replyTo, unittest.equals('foo'));
    unittest.expect(o.sendMessageDenyNotification, unittest.equals('foo'));
    unittest.expect(o.showInGroupDirectory, unittest.equals('foo'));
    unittest.expect(o.spamModerationLevel, unittest.equals('foo'));
    unittest.expect(o.whoCanAdd, unittest.equals('foo'));
    unittest.expect(o.whoCanContactOwner, unittest.equals('foo'));
    unittest.expect(o.whoCanInvite, unittest.equals('foo'));
    unittest.expect(o.whoCanJoin, unittest.equals('foo'));
    unittest.expect(o.whoCanLeaveGroup, unittest.equals('foo'));
    unittest.expect(o.whoCanPostMessage, unittest.equals('foo'));
    unittest.expect(o.whoCanViewGroup, unittest.equals('foo'));
    unittest.expect(o.whoCanViewMembership, unittest.equals('foo'));
  }
  buildCounterGroups--;
}


main() {
  unittest.group("obj-schema-Groups", () {
    unittest.test("to-json--from-json", () {
      var o = buildGroups();
      var od = new api.Groups.fromJson(o.toJson());
      checkGroups(od);
    });
  });


  unittest.group("resource-GroupsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.GroupsResourceApi res = new api.GroupssettingsApi(mock).groups;
      var arg_groupUniqueId = "foo";
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
        var resp = convert.JSON.encode(buildGroups());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_groupUniqueId).then(unittest.expectAsync(((api.Groups response) {
        checkGroups(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.GroupsResourceApi res = new api.GroupssettingsApi(mock).groups;
      var arg_request = buildGroups();
      var arg_groupUniqueId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Groups.fromJson(json);
        checkGroups(obj);

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
        var resp = convert.JSON.encode(buildGroups());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_groupUniqueId).then(unittest.expectAsync(((api.Groups response) {
        checkGroups(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.GroupsResourceApi res = new api.GroupssettingsApi(mock).groups;
      var arg_request = buildGroups();
      var arg_groupUniqueId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Groups.fromJson(json);
        checkGroups(obj);

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
        var resp = convert.JSON.encode(buildGroups());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_groupUniqueId).then(unittest.expectAsync(((api.Groups response) {
        checkGroups(response);
      })));
    });

  });


}

