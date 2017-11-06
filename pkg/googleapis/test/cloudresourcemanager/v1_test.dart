library googleapis.cloudresourcemanager.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/cloudresourcemanager/v1.dart' as api;

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

core.int buildCounterAncestor = 0;
buildAncestor() {
  var o = new api.Ancestor();
  buildCounterAncestor++;
  if (buildCounterAncestor < 3) {
    o.resourceId = buildResourceId();
  }
  buildCounterAncestor--;
  return o;
}

checkAncestor(api.Ancestor o) {
  buildCounterAncestor++;
  if (buildCounterAncestor < 3) {
    checkResourceId(o.resourceId);
  }
  buildCounterAncestor--;
}

buildUnnamed1555() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1555(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterBinding = 0;
buildBinding() {
  var o = new api.Binding();
  buildCounterBinding++;
  if (buildCounterBinding < 3) {
    o.members = buildUnnamed1555();
    o.role = "foo";
  }
  buildCounterBinding--;
  return o;
}

checkBinding(api.Binding o) {
  buildCounterBinding++;
  if (buildCounterBinding < 3) {
    checkUnnamed1555(o.members);
    unittest.expect(o.role, unittest.equals('foo'));
  }
  buildCounterBinding--;
}

core.int buildCounterEmpty = 0;
buildEmpty() {
  var o = new api.Empty();
  buildCounterEmpty++;
  if (buildCounterEmpty < 3) {
  }
  buildCounterEmpty--;
  return o;
}

checkEmpty(api.Empty o) {
  buildCounterEmpty++;
  if (buildCounterEmpty < 3) {
  }
  buildCounterEmpty--;
}

core.int buildCounterFolderOperation = 0;
buildFolderOperation() {
  var o = new api.FolderOperation();
  buildCounterFolderOperation++;
  if (buildCounterFolderOperation < 3) {
    o.destinationParent = "foo";
    o.displayName = "foo";
    o.operationType = "foo";
    o.sourceParent = "foo";
  }
  buildCounterFolderOperation--;
  return o;
}

checkFolderOperation(api.FolderOperation o) {
  buildCounterFolderOperation++;
  if (buildCounterFolderOperation < 3) {
    unittest.expect(o.destinationParent, unittest.equals('foo'));
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.operationType, unittest.equals('foo'));
    unittest.expect(o.sourceParent, unittest.equals('foo'));
  }
  buildCounterFolderOperation--;
}

core.int buildCounterFolderOperationError = 0;
buildFolderOperationError() {
  var o = new api.FolderOperationError();
  buildCounterFolderOperationError++;
  if (buildCounterFolderOperationError < 3) {
    o.errorMessageId = "foo";
  }
  buildCounterFolderOperationError--;
  return o;
}

checkFolderOperationError(api.FolderOperationError o) {
  buildCounterFolderOperationError++;
  if (buildCounterFolderOperationError < 3) {
    unittest.expect(o.errorMessageId, unittest.equals('foo'));
  }
  buildCounterFolderOperationError--;
}

core.int buildCounterGetAncestryRequest = 0;
buildGetAncestryRequest() {
  var o = new api.GetAncestryRequest();
  buildCounterGetAncestryRequest++;
  if (buildCounterGetAncestryRequest < 3) {
  }
  buildCounterGetAncestryRequest--;
  return o;
}

checkGetAncestryRequest(api.GetAncestryRequest o) {
  buildCounterGetAncestryRequest++;
  if (buildCounterGetAncestryRequest < 3) {
  }
  buildCounterGetAncestryRequest--;
}

buildUnnamed1556() {
  var o = new core.List<api.Ancestor>();
  o.add(buildAncestor());
  o.add(buildAncestor());
  return o;
}

checkUnnamed1556(core.List<api.Ancestor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAncestor(o[0]);
  checkAncestor(o[1]);
}

core.int buildCounterGetAncestryResponse = 0;
buildGetAncestryResponse() {
  var o = new api.GetAncestryResponse();
  buildCounterGetAncestryResponse++;
  if (buildCounterGetAncestryResponse < 3) {
    o.ancestor = buildUnnamed1556();
  }
  buildCounterGetAncestryResponse--;
  return o;
}

checkGetAncestryResponse(api.GetAncestryResponse o) {
  buildCounterGetAncestryResponse++;
  if (buildCounterGetAncestryResponse < 3) {
    checkUnnamed1556(o.ancestor);
  }
  buildCounterGetAncestryResponse--;
}

core.int buildCounterGetIamPolicyRequest = 0;
buildGetIamPolicyRequest() {
  var o = new api.GetIamPolicyRequest();
  buildCounterGetIamPolicyRequest++;
  if (buildCounterGetIamPolicyRequest < 3) {
  }
  buildCounterGetIamPolicyRequest--;
  return o;
}

checkGetIamPolicyRequest(api.GetIamPolicyRequest o) {
  buildCounterGetIamPolicyRequest++;
  if (buildCounterGetIamPolicyRequest < 3) {
  }
  buildCounterGetIamPolicyRequest--;
}

buildUnnamed1557() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1557(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterLien = 0;
buildLien() {
  var o = new api.Lien();
  buildCounterLien++;
  if (buildCounterLien < 3) {
    o.createTime = "foo";
    o.name = "foo";
    o.origin = "foo";
    o.parent = "foo";
    o.reason = "foo";
    o.restrictions = buildUnnamed1557();
  }
  buildCounterLien--;
  return o;
}

checkLien(api.Lien o) {
  buildCounterLien++;
  if (buildCounterLien < 3) {
    unittest.expect(o.createTime, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.origin, unittest.equals('foo'));
    unittest.expect(o.parent, unittest.equals('foo'));
    unittest.expect(o.reason, unittest.equals('foo'));
    checkUnnamed1557(o.restrictions);
  }
  buildCounterLien--;
}

buildUnnamed1558() {
  var o = new core.List<api.Lien>();
  o.add(buildLien());
  o.add(buildLien());
  return o;
}

checkUnnamed1558(core.List<api.Lien> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLien(o[0]);
  checkLien(o[1]);
}

core.int buildCounterListLiensResponse = 0;
buildListLiensResponse() {
  var o = new api.ListLiensResponse();
  buildCounterListLiensResponse++;
  if (buildCounterListLiensResponse < 3) {
    o.liens = buildUnnamed1558();
    o.nextPageToken = "foo";
  }
  buildCounterListLiensResponse--;
  return o;
}

checkListLiensResponse(api.ListLiensResponse o) {
  buildCounterListLiensResponse++;
  if (buildCounterListLiensResponse < 3) {
    checkUnnamed1558(o.liens);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListLiensResponse--;
}

buildUnnamed1559() {
  var o = new core.List<api.Project>();
  o.add(buildProject());
  o.add(buildProject());
  return o;
}

checkUnnamed1559(core.List<api.Project> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProject(o[0]);
  checkProject(o[1]);
}

core.int buildCounterListProjectsResponse = 0;
buildListProjectsResponse() {
  var o = new api.ListProjectsResponse();
  buildCounterListProjectsResponse++;
  if (buildCounterListProjectsResponse < 3) {
    o.nextPageToken = "foo";
    o.projects = buildUnnamed1559();
  }
  buildCounterListProjectsResponse--;
  return o;
}

checkListProjectsResponse(api.ListProjectsResponse o) {
  buildCounterListProjectsResponse++;
  if (buildCounterListProjectsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed1559(o.projects);
  }
  buildCounterListProjectsResponse--;
}

buildUnnamed1560() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  o["y"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  return o;
}

checkUnnamed1560(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o["x"]) as core.Map; unittest.expect(casted1, unittest.hasLength(3)); unittest.expect(casted1["list"], unittest.equals([1, 2, 3])); unittest.expect(casted1["bool"], unittest.equals(true)); unittest.expect(casted1["string"], unittest.equals('foo')); 
  var casted2 = (o["y"]) as core.Map; unittest.expect(casted2, unittest.hasLength(3)); unittest.expect(casted2["list"], unittest.equals([1, 2, 3])); unittest.expect(casted2["bool"], unittest.equals(true)); unittest.expect(casted2["string"], unittest.equals('foo')); 
}

buildUnnamed1561() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  o["y"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  return o;
}

checkUnnamed1561(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted3 = (o["x"]) as core.Map; unittest.expect(casted3, unittest.hasLength(3)); unittest.expect(casted3["list"], unittest.equals([1, 2, 3])); unittest.expect(casted3["bool"], unittest.equals(true)); unittest.expect(casted3["string"], unittest.equals('foo')); 
  var casted4 = (o["y"]) as core.Map; unittest.expect(casted4, unittest.hasLength(3)); unittest.expect(casted4["list"], unittest.equals([1, 2, 3])); unittest.expect(casted4["bool"], unittest.equals(true)); unittest.expect(casted4["string"], unittest.equals('foo')); 
}

core.int buildCounterOperation = 0;
buildOperation() {
  var o = new api.Operation();
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    o.done = true;
    o.error = buildStatus();
    o.metadata = buildUnnamed1560();
    o.name = "foo";
    o.response = buildUnnamed1561();
  }
  buildCounterOperation--;
  return o;
}

checkOperation(api.Operation o) {
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    unittest.expect(o.done, unittest.isTrue);
    checkStatus(o.error);
    checkUnnamed1560(o.metadata);
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed1561(o.response);
  }
  buildCounterOperation--;
}

core.int buildCounterOrganization = 0;
buildOrganization() {
  var o = new api.Organization();
  buildCounterOrganization++;
  if (buildCounterOrganization < 3) {
    o.creationTime = "foo";
    o.displayName = "foo";
    o.lifecycleState = "foo";
    o.name = "foo";
    o.owner = buildOrganizationOwner();
  }
  buildCounterOrganization--;
  return o;
}

checkOrganization(api.Organization o) {
  buildCounterOrganization++;
  if (buildCounterOrganization < 3) {
    unittest.expect(o.creationTime, unittest.equals('foo'));
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.lifecycleState, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    checkOrganizationOwner(o.owner);
  }
  buildCounterOrganization--;
}

core.int buildCounterOrganizationOwner = 0;
buildOrganizationOwner() {
  var o = new api.OrganizationOwner();
  buildCounterOrganizationOwner++;
  if (buildCounterOrganizationOwner < 3) {
    o.directoryCustomerId = "foo";
  }
  buildCounterOrganizationOwner--;
  return o;
}

checkOrganizationOwner(api.OrganizationOwner o) {
  buildCounterOrganizationOwner++;
  if (buildCounterOrganizationOwner < 3) {
    unittest.expect(o.directoryCustomerId, unittest.equals('foo'));
  }
  buildCounterOrganizationOwner--;
}

buildUnnamed1562() {
  var o = new core.List<api.Binding>();
  o.add(buildBinding());
  o.add(buildBinding());
  return o;
}

checkUnnamed1562(core.List<api.Binding> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBinding(o[0]);
  checkBinding(o[1]);
}

core.int buildCounterPolicy = 0;
buildPolicy() {
  var o = new api.Policy();
  buildCounterPolicy++;
  if (buildCounterPolicy < 3) {
    o.bindings = buildUnnamed1562();
    o.etag = "foo";
    o.version = 42;
  }
  buildCounterPolicy--;
  return o;
}

checkPolicy(api.Policy o) {
  buildCounterPolicy++;
  if (buildCounterPolicy < 3) {
    checkUnnamed1562(o.bindings);
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.version, unittest.equals(42));
  }
  buildCounterPolicy--;
}

buildUnnamed1563() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed1563(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterProject = 0;
buildProject() {
  var o = new api.Project();
  buildCounterProject++;
  if (buildCounterProject < 3) {
    o.createTime = "foo";
    o.labels = buildUnnamed1563();
    o.lifecycleState = "foo";
    o.name = "foo";
    o.parent = buildResourceId();
    o.projectId = "foo";
    o.projectNumber = "foo";
  }
  buildCounterProject--;
  return o;
}

checkProject(api.Project o) {
  buildCounterProject++;
  if (buildCounterProject < 3) {
    unittest.expect(o.createTime, unittest.equals('foo'));
    checkUnnamed1563(o.labels);
    unittest.expect(o.lifecycleState, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    checkResourceId(o.parent);
    unittest.expect(o.projectId, unittest.equals('foo'));
    unittest.expect(o.projectNumber, unittest.equals('foo'));
  }
  buildCounterProject--;
}

core.int buildCounterProjectCreationStatus = 0;
buildProjectCreationStatus() {
  var o = new api.ProjectCreationStatus();
  buildCounterProjectCreationStatus++;
  if (buildCounterProjectCreationStatus < 3) {
    o.createTime = "foo";
    o.gettable = true;
    o.ready = true;
  }
  buildCounterProjectCreationStatus--;
  return o;
}

checkProjectCreationStatus(api.ProjectCreationStatus o) {
  buildCounterProjectCreationStatus++;
  if (buildCounterProjectCreationStatus < 3) {
    unittest.expect(o.createTime, unittest.equals('foo'));
    unittest.expect(o.gettable, unittest.isTrue);
    unittest.expect(o.ready, unittest.isTrue);
  }
  buildCounterProjectCreationStatus--;
}

core.int buildCounterResourceId = 0;
buildResourceId() {
  var o = new api.ResourceId();
  buildCounterResourceId++;
  if (buildCounterResourceId < 3) {
    o.id = "foo";
    o.type = "foo";
  }
  buildCounterResourceId--;
  return o;
}

checkResourceId(api.ResourceId o) {
  buildCounterResourceId++;
  if (buildCounterResourceId < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterResourceId--;
}

core.int buildCounterSearchOrganizationsRequest = 0;
buildSearchOrganizationsRequest() {
  var o = new api.SearchOrganizationsRequest();
  buildCounterSearchOrganizationsRequest++;
  if (buildCounterSearchOrganizationsRequest < 3) {
    o.filter = "foo";
    o.pageSize = 42;
    o.pageToken = "foo";
  }
  buildCounterSearchOrganizationsRequest--;
  return o;
}

checkSearchOrganizationsRequest(api.SearchOrganizationsRequest o) {
  buildCounterSearchOrganizationsRequest++;
  if (buildCounterSearchOrganizationsRequest < 3) {
    unittest.expect(o.filter, unittest.equals('foo'));
    unittest.expect(o.pageSize, unittest.equals(42));
    unittest.expect(o.pageToken, unittest.equals('foo'));
  }
  buildCounterSearchOrganizationsRequest--;
}

buildUnnamed1564() {
  var o = new core.List<api.Organization>();
  o.add(buildOrganization());
  o.add(buildOrganization());
  return o;
}

checkUnnamed1564(core.List<api.Organization> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrganization(o[0]);
  checkOrganization(o[1]);
}

core.int buildCounterSearchOrganizationsResponse = 0;
buildSearchOrganizationsResponse() {
  var o = new api.SearchOrganizationsResponse();
  buildCounterSearchOrganizationsResponse++;
  if (buildCounterSearchOrganizationsResponse < 3) {
    o.nextPageToken = "foo";
    o.organizations = buildUnnamed1564();
  }
  buildCounterSearchOrganizationsResponse--;
  return o;
}

checkSearchOrganizationsResponse(api.SearchOrganizationsResponse o) {
  buildCounterSearchOrganizationsResponse++;
  if (buildCounterSearchOrganizationsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed1564(o.organizations);
  }
  buildCounterSearchOrganizationsResponse--;
}

core.int buildCounterSetIamPolicyRequest = 0;
buildSetIamPolicyRequest() {
  var o = new api.SetIamPolicyRequest();
  buildCounterSetIamPolicyRequest++;
  if (buildCounterSetIamPolicyRequest < 3) {
    o.policy = buildPolicy();
  }
  buildCounterSetIamPolicyRequest--;
  return o;
}

checkSetIamPolicyRequest(api.SetIamPolicyRequest o) {
  buildCounterSetIamPolicyRequest++;
  if (buildCounterSetIamPolicyRequest < 3) {
    checkPolicy(o.policy);
  }
  buildCounterSetIamPolicyRequest--;
}

buildUnnamed1565() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  o["y"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  return o;
}

checkUnnamed1565(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted5 = (o["x"]) as core.Map; unittest.expect(casted5, unittest.hasLength(3)); unittest.expect(casted5["list"], unittest.equals([1, 2, 3])); unittest.expect(casted5["bool"], unittest.equals(true)); unittest.expect(casted5["string"], unittest.equals('foo')); 
  var casted6 = (o["y"]) as core.Map; unittest.expect(casted6, unittest.hasLength(3)); unittest.expect(casted6["list"], unittest.equals([1, 2, 3])); unittest.expect(casted6["bool"], unittest.equals(true)); unittest.expect(casted6["string"], unittest.equals('foo')); 
}

buildUnnamed1566() {
  var o = new core.List<core.Map<core.String, core.Object>>();
  o.add(buildUnnamed1565());
  o.add(buildUnnamed1565());
  return o;
}

checkUnnamed1566(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed1565(o[0]);
  checkUnnamed1565(o[1]);
}

core.int buildCounterStatus = 0;
buildStatus() {
  var o = new api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed1566();
    o.message = "foo";
  }
  buildCounterStatus--;
  return o;
}

checkStatus(api.Status o) {
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    unittest.expect(o.code, unittest.equals(42));
    checkUnnamed1566(o.details);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterStatus--;
}

buildUnnamed1567() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1567(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterTestIamPermissionsRequest = 0;
buildTestIamPermissionsRequest() {
  var o = new api.TestIamPermissionsRequest();
  buildCounterTestIamPermissionsRequest++;
  if (buildCounterTestIamPermissionsRequest < 3) {
    o.permissions = buildUnnamed1567();
  }
  buildCounterTestIamPermissionsRequest--;
  return o;
}

checkTestIamPermissionsRequest(api.TestIamPermissionsRequest o) {
  buildCounterTestIamPermissionsRequest++;
  if (buildCounterTestIamPermissionsRequest < 3) {
    checkUnnamed1567(o.permissions);
  }
  buildCounterTestIamPermissionsRequest--;
}

buildUnnamed1568() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1568(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterTestIamPermissionsResponse = 0;
buildTestIamPermissionsResponse() {
  var o = new api.TestIamPermissionsResponse();
  buildCounterTestIamPermissionsResponse++;
  if (buildCounterTestIamPermissionsResponse < 3) {
    o.permissions = buildUnnamed1568();
  }
  buildCounterTestIamPermissionsResponse--;
  return o;
}

checkTestIamPermissionsResponse(api.TestIamPermissionsResponse o) {
  buildCounterTestIamPermissionsResponse++;
  if (buildCounterTestIamPermissionsResponse < 3) {
    checkUnnamed1568(o.permissions);
  }
  buildCounterTestIamPermissionsResponse--;
}

core.int buildCounterUndeleteProjectRequest = 0;
buildUndeleteProjectRequest() {
  var o = new api.UndeleteProjectRequest();
  buildCounterUndeleteProjectRequest++;
  if (buildCounterUndeleteProjectRequest < 3) {
  }
  buildCounterUndeleteProjectRequest--;
  return o;
}

checkUndeleteProjectRequest(api.UndeleteProjectRequest o) {
  buildCounterUndeleteProjectRequest++;
  if (buildCounterUndeleteProjectRequest < 3) {
  }
  buildCounterUndeleteProjectRequest--;
}


main() {
  unittest.group("obj-schema-Ancestor", () {
    unittest.test("to-json--from-json", () {
      var o = buildAncestor();
      var od = new api.Ancestor.fromJson(o.toJson());
      checkAncestor(od);
    });
  });


  unittest.group("obj-schema-Binding", () {
    unittest.test("to-json--from-json", () {
      var o = buildBinding();
      var od = new api.Binding.fromJson(o.toJson());
      checkBinding(od);
    });
  });


  unittest.group("obj-schema-Empty", () {
    unittest.test("to-json--from-json", () {
      var o = buildEmpty();
      var od = new api.Empty.fromJson(o.toJson());
      checkEmpty(od);
    });
  });


  unittest.group("obj-schema-FolderOperation", () {
    unittest.test("to-json--from-json", () {
      var o = buildFolderOperation();
      var od = new api.FolderOperation.fromJson(o.toJson());
      checkFolderOperation(od);
    });
  });


  unittest.group("obj-schema-FolderOperationError", () {
    unittest.test("to-json--from-json", () {
      var o = buildFolderOperationError();
      var od = new api.FolderOperationError.fromJson(o.toJson());
      checkFolderOperationError(od);
    });
  });


  unittest.group("obj-schema-GetAncestryRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildGetAncestryRequest();
      var od = new api.GetAncestryRequest.fromJson(o.toJson());
      checkGetAncestryRequest(od);
    });
  });


  unittest.group("obj-schema-GetAncestryResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildGetAncestryResponse();
      var od = new api.GetAncestryResponse.fromJson(o.toJson());
      checkGetAncestryResponse(od);
    });
  });


  unittest.group("obj-schema-GetIamPolicyRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildGetIamPolicyRequest();
      var od = new api.GetIamPolicyRequest.fromJson(o.toJson());
      checkGetIamPolicyRequest(od);
    });
  });


  unittest.group("obj-schema-Lien", () {
    unittest.test("to-json--from-json", () {
      var o = buildLien();
      var od = new api.Lien.fromJson(o.toJson());
      checkLien(od);
    });
  });


  unittest.group("obj-schema-ListLiensResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListLiensResponse();
      var od = new api.ListLiensResponse.fromJson(o.toJson());
      checkListLiensResponse(od);
    });
  });


  unittest.group("obj-schema-ListProjectsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListProjectsResponse();
      var od = new api.ListProjectsResponse.fromJson(o.toJson());
      checkListProjectsResponse(od);
    });
  });


  unittest.group("obj-schema-Operation", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperation();
      var od = new api.Operation.fromJson(o.toJson());
      checkOperation(od);
    });
  });


  unittest.group("obj-schema-Organization", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrganization();
      var od = new api.Organization.fromJson(o.toJson());
      checkOrganization(od);
    });
  });


  unittest.group("obj-schema-OrganizationOwner", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrganizationOwner();
      var od = new api.OrganizationOwner.fromJson(o.toJson());
      checkOrganizationOwner(od);
    });
  });


  unittest.group("obj-schema-Policy", () {
    unittest.test("to-json--from-json", () {
      var o = buildPolicy();
      var od = new api.Policy.fromJson(o.toJson());
      checkPolicy(od);
    });
  });


  unittest.group("obj-schema-Project", () {
    unittest.test("to-json--from-json", () {
      var o = buildProject();
      var od = new api.Project.fromJson(o.toJson());
      checkProject(od);
    });
  });


  unittest.group("obj-schema-ProjectCreationStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildProjectCreationStatus();
      var od = new api.ProjectCreationStatus.fromJson(o.toJson());
      checkProjectCreationStatus(od);
    });
  });


  unittest.group("obj-schema-ResourceId", () {
    unittest.test("to-json--from-json", () {
      var o = buildResourceId();
      var od = new api.ResourceId.fromJson(o.toJson());
      checkResourceId(od);
    });
  });


  unittest.group("obj-schema-SearchOrganizationsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildSearchOrganizationsRequest();
      var od = new api.SearchOrganizationsRequest.fromJson(o.toJson());
      checkSearchOrganizationsRequest(od);
    });
  });


  unittest.group("obj-schema-SearchOrganizationsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSearchOrganizationsResponse();
      var od = new api.SearchOrganizationsResponse.fromJson(o.toJson());
      checkSearchOrganizationsResponse(od);
    });
  });


  unittest.group("obj-schema-SetIamPolicyRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildSetIamPolicyRequest();
      var od = new api.SetIamPolicyRequest.fromJson(o.toJson());
      checkSetIamPolicyRequest(od);
    });
  });


  unittest.group("obj-schema-Status", () {
    unittest.test("to-json--from-json", () {
      var o = buildStatus();
      var od = new api.Status.fromJson(o.toJson());
      checkStatus(od);
    });
  });


  unittest.group("obj-schema-TestIamPermissionsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildTestIamPermissionsRequest();
      var od = new api.TestIamPermissionsRequest.fromJson(o.toJson());
      checkTestIamPermissionsRequest(od);
    });
  });


  unittest.group("obj-schema-TestIamPermissionsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildTestIamPermissionsResponse();
      var od = new api.TestIamPermissionsResponse.fromJson(o.toJson());
      checkTestIamPermissionsResponse(od);
    });
  });


  unittest.group("obj-schema-UndeleteProjectRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUndeleteProjectRequest();
      var od = new api.UndeleteProjectRequest.fromJson(o.toJson());
      checkUndeleteProjectRequest(od);
    });
  });


  unittest.group("resource-LiensResourceApi", () {
    unittest.test("method--create", () {

      var mock = new HttpServerMock();
      api.LiensResourceApi res = new api.CloudresourcemanagerApi(mock).liens;
      var arg_request = buildLien();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Lien.fromJson(json);
        checkLien(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("v1/liens"));
        pathOffset += 8;

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
        var resp = convert.JSON.encode(buildLien());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.create(arg_request).then(unittest.expectAsync(((api.Lien response) {
        checkLien(response);
      })));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.LiensResourceApi res = new api.CloudresourcemanagerApi(mock).liens;
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
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_name).then(unittest.expectAsync(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.LiensResourceApi res = new api.CloudresourcemanagerApi(mock).liens;
      var arg_parent = "foo";
      var arg_pageToken = "foo";
      var arg_pageSize = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("v1/liens"));
        pathOffset += 8;

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
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListLiensResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(parent: arg_parent, pageToken: arg_pageToken, pageSize: arg_pageSize).then(unittest.expectAsync(((api.ListLiensResponse response) {
        checkListLiensResponse(response);
      })));
    });

  });


  unittest.group("resource-OperationsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.OperationsResourceApi res = new api.CloudresourcemanagerApi(mock).operations;
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_name).then(unittest.expectAsync(((api.Operation response) {
        checkOperation(response);
      })));
    });

  });


  unittest.group("resource-OrganizationsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.OrganizationsResourceApi res = new api.CloudresourcemanagerApi(mock).organizations;
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
        var resp = convert.JSON.encode(buildOrganization());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_name).then(unittest.expectAsync(((api.Organization response) {
        checkOrganization(response);
      })));
    });

    unittest.test("method--getIamPolicy", () {

      var mock = new HttpServerMock();
      api.OrganizationsResourceApi res = new api.CloudresourcemanagerApi(mock).organizations;
      var arg_request = buildGetIamPolicyRequest();
      var arg_resource = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.GetIamPolicyRequest.fromJson(json);
        checkGetIamPolicyRequest(obj);

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
        var resp = convert.JSON.encode(buildPolicy());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getIamPolicy(arg_request, arg_resource).then(unittest.expectAsync(((api.Policy response) {
        checkPolicy(response);
      })));
    });

    unittest.test("method--search", () {

      var mock = new HttpServerMock();
      api.OrganizationsResourceApi res = new api.CloudresourcemanagerApi(mock).organizations;
      var arg_request = buildSearchOrganizationsRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.SearchOrganizationsRequest.fromJson(json);
        checkSearchOrganizationsRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 23), unittest.equals("v1/organizations:search"));
        pathOffset += 23;

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
        var resp = convert.JSON.encode(buildSearchOrganizationsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.search(arg_request).then(unittest.expectAsync(((api.SearchOrganizationsResponse response) {
        checkSearchOrganizationsResponse(response);
      })));
    });

    unittest.test("method--setIamPolicy", () {

      var mock = new HttpServerMock();
      api.OrganizationsResourceApi res = new api.CloudresourcemanagerApi(mock).organizations;
      var arg_request = buildSetIamPolicyRequest();
      var arg_resource = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.SetIamPolicyRequest.fromJson(json);
        checkSetIamPolicyRequest(obj);

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
        var resp = convert.JSON.encode(buildPolicy());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.setIamPolicy(arg_request, arg_resource).then(unittest.expectAsync(((api.Policy response) {
        checkPolicy(response);
      })));
    });

    unittest.test("method--testIamPermissions", () {

      var mock = new HttpServerMock();
      api.OrganizationsResourceApi res = new api.CloudresourcemanagerApi(mock).organizations;
      var arg_request = buildTestIamPermissionsRequest();
      var arg_resource = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.TestIamPermissionsRequest.fromJson(json);
        checkTestIamPermissionsRequest(obj);

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
        var resp = convert.JSON.encode(buildTestIamPermissionsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.testIamPermissions(arg_request, arg_resource).then(unittest.expectAsync(((api.TestIamPermissionsResponse response) {
        checkTestIamPermissionsResponse(response);
      })));
    });

  });


  unittest.group("resource-ProjectsResourceApi", () {
    unittest.test("method--create", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudresourcemanagerApi(mock).projects;
      var arg_request = buildProject();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Project.fromJson(json);
        checkProject(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("v1/projects"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.create(arg_request).then(unittest.expectAsync(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudresourcemanagerApi(mock).projects;
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("v1/projects/"));
        pathOffset += 12;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_projectId"));

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
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_projectId).then(unittest.expectAsync(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudresourcemanagerApi(mock).projects;
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("v1/projects/"));
        pathOffset += 12;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_projectId"));

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
        var resp = convert.JSON.encode(buildProject());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_projectId).then(unittest.expectAsync(((api.Project response) {
        checkProject(response);
      })));
    });

    unittest.test("method--getAncestry", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudresourcemanagerApi(mock).projects;
      var arg_request = buildGetAncestryRequest();
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.GetAncestryRequest.fromJson(json);
        checkGetAncestryRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("v1/projects/"));
        pathOffset += 12;
        index = path.indexOf(":getAncestry", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_projectId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals(":getAncestry"));
        pathOffset += 12;

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
        var resp = convert.JSON.encode(buildGetAncestryResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getAncestry(arg_request, arg_projectId).then(unittest.expectAsync(((api.GetAncestryResponse response) {
        checkGetAncestryResponse(response);
      })));
    });

    unittest.test("method--getIamPolicy", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudresourcemanagerApi(mock).projects;
      var arg_request = buildGetIamPolicyRequest();
      var arg_resource = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.GetIamPolicyRequest.fromJson(json);
        checkGetIamPolicyRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("v1/projects/"));
        pathOffset += 12;
        index = path.indexOf(":getIamPolicy", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_resource"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals(":getIamPolicy"));
        pathOffset += 13;

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
        var resp = convert.JSON.encode(buildPolicy());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getIamPolicy(arg_request, arg_resource).then(unittest.expectAsync(((api.Policy response) {
        checkPolicy(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudresourcemanagerApi(mock).projects;
      var arg_filter = "foo";
      var arg_pageToken = "foo";
      var arg_pageSize = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("v1/projects"));
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
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListProjectsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(filter: arg_filter, pageToken: arg_pageToken, pageSize: arg_pageSize).then(unittest.expectAsync(((api.ListProjectsResponse response) {
        checkListProjectsResponse(response);
      })));
    });

    unittest.test("method--setIamPolicy", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudresourcemanagerApi(mock).projects;
      var arg_request = buildSetIamPolicyRequest();
      var arg_resource = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.SetIamPolicyRequest.fromJson(json);
        checkSetIamPolicyRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("v1/projects/"));
        pathOffset += 12;
        index = path.indexOf(":setIamPolicy", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_resource"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals(":setIamPolicy"));
        pathOffset += 13;

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
        var resp = convert.JSON.encode(buildPolicy());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.setIamPolicy(arg_request, arg_resource).then(unittest.expectAsync(((api.Policy response) {
        checkPolicy(response);
      })));
    });

    unittest.test("method--testIamPermissions", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudresourcemanagerApi(mock).projects;
      var arg_request = buildTestIamPermissionsRequest();
      var arg_resource = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.TestIamPermissionsRequest.fromJson(json);
        checkTestIamPermissionsRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("v1/projects/"));
        pathOffset += 12;
        index = path.indexOf(":testIamPermissions", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_resource"));
        unittest.expect(path.substring(pathOffset, pathOffset + 19), unittest.equals(":testIamPermissions"));
        pathOffset += 19;

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
        var resp = convert.JSON.encode(buildTestIamPermissionsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.testIamPermissions(arg_request, arg_resource).then(unittest.expectAsync(((api.TestIamPermissionsResponse response) {
        checkTestIamPermissionsResponse(response);
      })));
    });

    unittest.test("method--undelete", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudresourcemanagerApi(mock).projects;
      var arg_request = buildUndeleteProjectRequest();
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.UndeleteProjectRequest.fromJson(json);
        checkUndeleteProjectRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("v1/projects/"));
        pathOffset += 12;
        index = path.indexOf(":undelete", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_projectId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals(":undelete"));
        pathOffset += 9;

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
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.undelete(arg_request, arg_projectId).then(unittest.expectAsync(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.CloudresourcemanagerApi(mock).projects;
      var arg_request = buildProject();
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Project.fromJson(json);
        checkProject(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("v1/projects/"));
        pathOffset += 12;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_projectId"));

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
        var resp = convert.JSON.encode(buildProject());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_projectId).then(unittest.expectAsync(((api.Project response) {
        checkProject(response);
      })));
    });

  });


}

