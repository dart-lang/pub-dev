library googleapis_beta.dlp.v2beta1.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis_beta/dlp/v2beta1.dart' as api;

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

core.int buildCounterGoogleLongrunningCancelOperationRequest = 0;
buildGoogleLongrunningCancelOperationRequest() {
  var o = new api.GoogleLongrunningCancelOperationRequest();
  buildCounterGoogleLongrunningCancelOperationRequest++;
  if (buildCounterGoogleLongrunningCancelOperationRequest < 3) {}
  buildCounterGoogleLongrunningCancelOperationRequest--;
  return o;
}

checkGoogleLongrunningCancelOperationRequest(
    api.GoogleLongrunningCancelOperationRequest o) {
  buildCounterGoogleLongrunningCancelOperationRequest++;
  if (buildCounterGoogleLongrunningCancelOperationRequest < 3) {}
  buildCounterGoogleLongrunningCancelOperationRequest--;
}

buildUnnamed3303() {
  var o = new core.List<api.GoogleLongrunningOperation>();
  o.add(buildGoogleLongrunningOperation());
  o.add(buildGoogleLongrunningOperation());
  return o;
}

checkUnnamed3303(core.List<api.GoogleLongrunningOperation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleLongrunningOperation(o[0]);
  checkGoogleLongrunningOperation(o[1]);
}

core.int buildCounterGoogleLongrunningListOperationsResponse = 0;
buildGoogleLongrunningListOperationsResponse() {
  var o = new api.GoogleLongrunningListOperationsResponse();
  buildCounterGoogleLongrunningListOperationsResponse++;
  if (buildCounterGoogleLongrunningListOperationsResponse < 3) {
    o.nextPageToken = "foo";
    o.operations = buildUnnamed3303();
  }
  buildCounterGoogleLongrunningListOperationsResponse--;
  return o;
}

checkGoogleLongrunningListOperationsResponse(
    api.GoogleLongrunningListOperationsResponse o) {
  buildCounterGoogleLongrunningListOperationsResponse++;
  if (buildCounterGoogleLongrunningListOperationsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed3303(o.operations);
  }
  buildCounterGoogleLongrunningListOperationsResponse--;
}

buildUnnamed3304() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  o["y"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  return o;
}

checkUnnamed3304(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o["x"]) as core.Map;
  unittest.expect(casted1, unittest.hasLength(3));
  unittest.expect(casted1["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted1["bool"], unittest.equals(true));
  unittest.expect(casted1["string"], unittest.equals('foo'));
  var casted2 = (o["y"]) as core.Map;
  unittest.expect(casted2, unittest.hasLength(3));
  unittest.expect(casted2["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted2["bool"], unittest.equals(true));
  unittest.expect(casted2["string"], unittest.equals('foo'));
}

buildUnnamed3305() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  o["y"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  return o;
}

checkUnnamed3305(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted3 = (o["x"]) as core.Map;
  unittest.expect(casted3, unittest.hasLength(3));
  unittest.expect(casted3["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted3["bool"], unittest.equals(true));
  unittest.expect(casted3["string"], unittest.equals('foo'));
  var casted4 = (o["y"]) as core.Map;
  unittest.expect(casted4, unittest.hasLength(3));
  unittest.expect(casted4["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted4["bool"], unittest.equals(true));
  unittest.expect(casted4["string"], unittest.equals('foo'));
}

core.int buildCounterGoogleLongrunningOperation = 0;
buildGoogleLongrunningOperation() {
  var o = new api.GoogleLongrunningOperation();
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    o.done = true;
    o.error = buildGoogleRpcStatus();
    o.metadata = buildUnnamed3304();
    o.name = "foo";
    o.response = buildUnnamed3305();
  }
  buildCounterGoogleLongrunningOperation--;
  return o;
}

checkGoogleLongrunningOperation(api.GoogleLongrunningOperation o) {
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    unittest.expect(o.done, unittest.isTrue);
    checkGoogleRpcStatus(o.error);
    checkUnnamed3304(o.metadata);
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed3305(o.response);
  }
  buildCounterGoogleLongrunningOperation--;
}

buildUnnamed3306() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1FieldId>();
  o.add(buildGooglePrivacyDlpV2beta1FieldId());
  o.add(buildGooglePrivacyDlpV2beta1FieldId());
  return o;
}

checkUnnamed3306(core.List<api.GooglePrivacyDlpV2beta1FieldId> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1FieldId(o[0]);
  checkGooglePrivacyDlpV2beta1FieldId(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1BigQueryOptions = 0;
buildGooglePrivacyDlpV2beta1BigQueryOptions() {
  var o = new api.GooglePrivacyDlpV2beta1BigQueryOptions();
  buildCounterGooglePrivacyDlpV2beta1BigQueryOptions++;
  if (buildCounterGooglePrivacyDlpV2beta1BigQueryOptions < 3) {
    o.identifyingFields = buildUnnamed3306();
    o.tableReference = buildGooglePrivacyDlpV2beta1BigQueryTable();
  }
  buildCounterGooglePrivacyDlpV2beta1BigQueryOptions--;
  return o;
}

checkGooglePrivacyDlpV2beta1BigQueryOptions(
    api.GooglePrivacyDlpV2beta1BigQueryOptions o) {
  buildCounterGooglePrivacyDlpV2beta1BigQueryOptions++;
  if (buildCounterGooglePrivacyDlpV2beta1BigQueryOptions < 3) {
    checkUnnamed3306(o.identifyingFields);
    checkGooglePrivacyDlpV2beta1BigQueryTable(o.tableReference);
  }
  buildCounterGooglePrivacyDlpV2beta1BigQueryOptions--;
}

core.int buildCounterGooglePrivacyDlpV2beta1BigQueryTable = 0;
buildGooglePrivacyDlpV2beta1BigQueryTable() {
  var o = new api.GooglePrivacyDlpV2beta1BigQueryTable();
  buildCounterGooglePrivacyDlpV2beta1BigQueryTable++;
  if (buildCounterGooglePrivacyDlpV2beta1BigQueryTable < 3) {
    o.datasetId = "foo";
    o.projectId = "foo";
    o.tableId = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1BigQueryTable--;
  return o;
}

checkGooglePrivacyDlpV2beta1BigQueryTable(
    api.GooglePrivacyDlpV2beta1BigQueryTable o) {
  buildCounterGooglePrivacyDlpV2beta1BigQueryTable++;
  if (buildCounterGooglePrivacyDlpV2beta1BigQueryTable < 3) {
    unittest.expect(o.datasetId, unittest.equals('foo'));
    unittest.expect(o.projectId, unittest.equals('foo'));
    unittest.expect(o.tableId, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1BigQueryTable--;
}

core.int buildCounterGooglePrivacyDlpV2beta1CategoryDescription = 0;
buildGooglePrivacyDlpV2beta1CategoryDescription() {
  var o = new api.GooglePrivacyDlpV2beta1CategoryDescription();
  buildCounterGooglePrivacyDlpV2beta1CategoryDescription++;
  if (buildCounterGooglePrivacyDlpV2beta1CategoryDescription < 3) {
    o.displayName = "foo";
    o.name = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1CategoryDescription--;
  return o;
}

checkGooglePrivacyDlpV2beta1CategoryDescription(
    api.GooglePrivacyDlpV2beta1CategoryDescription o) {
  buildCounterGooglePrivacyDlpV2beta1CategoryDescription++;
  if (buildCounterGooglePrivacyDlpV2beta1CategoryDescription < 3) {
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1CategoryDescription--;
}

core.int buildCounterGooglePrivacyDlpV2beta1CloudStorageKey = 0;
buildGooglePrivacyDlpV2beta1CloudStorageKey() {
  var o = new api.GooglePrivacyDlpV2beta1CloudStorageKey();
  buildCounterGooglePrivacyDlpV2beta1CloudStorageKey++;
  if (buildCounterGooglePrivacyDlpV2beta1CloudStorageKey < 3) {
    o.filePath = "foo";
    o.startOffset = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1CloudStorageKey--;
  return o;
}

checkGooglePrivacyDlpV2beta1CloudStorageKey(
    api.GooglePrivacyDlpV2beta1CloudStorageKey o) {
  buildCounterGooglePrivacyDlpV2beta1CloudStorageKey++;
  if (buildCounterGooglePrivacyDlpV2beta1CloudStorageKey < 3) {
    unittest.expect(o.filePath, unittest.equals('foo'));
    unittest.expect(o.startOffset, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1CloudStorageKey--;
}

core.int buildCounterGooglePrivacyDlpV2beta1CloudStorageOptions = 0;
buildGooglePrivacyDlpV2beta1CloudStorageOptions() {
  var o = new api.GooglePrivacyDlpV2beta1CloudStorageOptions();
  buildCounterGooglePrivacyDlpV2beta1CloudStorageOptions++;
  if (buildCounterGooglePrivacyDlpV2beta1CloudStorageOptions < 3) {
    o.fileSet = buildGooglePrivacyDlpV2beta1FileSet();
  }
  buildCounterGooglePrivacyDlpV2beta1CloudStorageOptions--;
  return o;
}

checkGooglePrivacyDlpV2beta1CloudStorageOptions(
    api.GooglePrivacyDlpV2beta1CloudStorageOptions o) {
  buildCounterGooglePrivacyDlpV2beta1CloudStorageOptions++;
  if (buildCounterGooglePrivacyDlpV2beta1CloudStorageOptions < 3) {
    checkGooglePrivacyDlpV2beta1FileSet(o.fileSet);
  }
  buildCounterGooglePrivacyDlpV2beta1CloudStorageOptions--;
}

core.int buildCounterGooglePrivacyDlpV2beta1CloudStoragePath = 0;
buildGooglePrivacyDlpV2beta1CloudStoragePath() {
  var o = new api.GooglePrivacyDlpV2beta1CloudStoragePath();
  buildCounterGooglePrivacyDlpV2beta1CloudStoragePath++;
  if (buildCounterGooglePrivacyDlpV2beta1CloudStoragePath < 3) {
    o.path = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1CloudStoragePath--;
  return o;
}

checkGooglePrivacyDlpV2beta1CloudStoragePath(
    api.GooglePrivacyDlpV2beta1CloudStoragePath o) {
  buildCounterGooglePrivacyDlpV2beta1CloudStoragePath++;
  if (buildCounterGooglePrivacyDlpV2beta1CloudStoragePath < 3) {
    unittest.expect(o.path, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1CloudStoragePath--;
}

core.int buildCounterGooglePrivacyDlpV2beta1Color = 0;
buildGooglePrivacyDlpV2beta1Color() {
  var o = new api.GooglePrivacyDlpV2beta1Color();
  buildCounterGooglePrivacyDlpV2beta1Color++;
  if (buildCounterGooglePrivacyDlpV2beta1Color < 3) {
    o.blue = 42.0;
    o.green = 42.0;
    o.red = 42.0;
  }
  buildCounterGooglePrivacyDlpV2beta1Color--;
  return o;
}

checkGooglePrivacyDlpV2beta1Color(api.GooglePrivacyDlpV2beta1Color o) {
  buildCounterGooglePrivacyDlpV2beta1Color++;
  if (buildCounterGooglePrivacyDlpV2beta1Color < 3) {
    unittest.expect(o.blue, unittest.equals(42.0));
    unittest.expect(o.green, unittest.equals(42.0));
    unittest.expect(o.red, unittest.equals(42.0));
  }
  buildCounterGooglePrivacyDlpV2beta1Color--;
}

core.int buildCounterGooglePrivacyDlpV2beta1ContentItem = 0;
buildGooglePrivacyDlpV2beta1ContentItem() {
  var o = new api.GooglePrivacyDlpV2beta1ContentItem();
  buildCounterGooglePrivacyDlpV2beta1ContentItem++;
  if (buildCounterGooglePrivacyDlpV2beta1ContentItem < 3) {
    o.data = "foo";
    o.table = buildGooglePrivacyDlpV2beta1Table();
    o.type = "foo";
    o.value = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1ContentItem--;
  return o;
}

checkGooglePrivacyDlpV2beta1ContentItem(
    api.GooglePrivacyDlpV2beta1ContentItem o) {
  buildCounterGooglePrivacyDlpV2beta1ContentItem++;
  if (buildCounterGooglePrivacyDlpV2beta1ContentItem < 3) {
    unittest.expect(o.data, unittest.equals('foo'));
    checkGooglePrivacyDlpV2beta1Table(o.table);
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1ContentItem--;
}

core.int buildCounterGooglePrivacyDlpV2beta1CreateInspectOperationRequest = 0;
buildGooglePrivacyDlpV2beta1CreateInspectOperationRequest() {
  var o = new api.GooglePrivacyDlpV2beta1CreateInspectOperationRequest();
  buildCounterGooglePrivacyDlpV2beta1CreateInspectOperationRequest++;
  if (buildCounterGooglePrivacyDlpV2beta1CreateInspectOperationRequest < 3) {
    o.inspectConfig = buildGooglePrivacyDlpV2beta1InspectConfig();
    o.operationConfig = buildGooglePrivacyDlpV2beta1OperationConfig();
    o.outputConfig = buildGooglePrivacyDlpV2beta1OutputStorageConfig();
    o.storageConfig = buildGooglePrivacyDlpV2beta1StorageConfig();
  }
  buildCounterGooglePrivacyDlpV2beta1CreateInspectOperationRequest--;
  return o;
}

checkGooglePrivacyDlpV2beta1CreateInspectOperationRequest(
    api.GooglePrivacyDlpV2beta1CreateInspectOperationRequest o) {
  buildCounterGooglePrivacyDlpV2beta1CreateInspectOperationRequest++;
  if (buildCounterGooglePrivacyDlpV2beta1CreateInspectOperationRequest < 3) {
    checkGooglePrivacyDlpV2beta1InspectConfig(o.inspectConfig);
    checkGooglePrivacyDlpV2beta1OperationConfig(o.operationConfig);
    checkGooglePrivacyDlpV2beta1OutputStorageConfig(o.outputConfig);
    checkGooglePrivacyDlpV2beta1StorageConfig(o.storageConfig);
  }
  buildCounterGooglePrivacyDlpV2beta1CreateInspectOperationRequest--;
}

core.int buildCounterGooglePrivacyDlpV2beta1DatastoreKey = 0;
buildGooglePrivacyDlpV2beta1DatastoreKey() {
  var o = new api.GooglePrivacyDlpV2beta1DatastoreKey();
  buildCounterGooglePrivacyDlpV2beta1DatastoreKey++;
  if (buildCounterGooglePrivacyDlpV2beta1DatastoreKey < 3) {
    o.entityKey = buildGooglePrivacyDlpV2beta1Key();
  }
  buildCounterGooglePrivacyDlpV2beta1DatastoreKey--;
  return o;
}

checkGooglePrivacyDlpV2beta1DatastoreKey(
    api.GooglePrivacyDlpV2beta1DatastoreKey o) {
  buildCounterGooglePrivacyDlpV2beta1DatastoreKey++;
  if (buildCounterGooglePrivacyDlpV2beta1DatastoreKey < 3) {
    checkGooglePrivacyDlpV2beta1Key(o.entityKey);
  }
  buildCounterGooglePrivacyDlpV2beta1DatastoreKey--;
}

buildUnnamed3307() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1Projection>();
  o.add(buildGooglePrivacyDlpV2beta1Projection());
  o.add(buildGooglePrivacyDlpV2beta1Projection());
  return o;
}

checkUnnamed3307(core.List<api.GooglePrivacyDlpV2beta1Projection> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1Projection(o[0]);
  checkGooglePrivacyDlpV2beta1Projection(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1DatastoreOptions = 0;
buildGooglePrivacyDlpV2beta1DatastoreOptions() {
  var o = new api.GooglePrivacyDlpV2beta1DatastoreOptions();
  buildCounterGooglePrivacyDlpV2beta1DatastoreOptions++;
  if (buildCounterGooglePrivacyDlpV2beta1DatastoreOptions < 3) {
    o.kind = buildGooglePrivacyDlpV2beta1KindExpression();
    o.partitionId = buildGooglePrivacyDlpV2beta1PartitionId();
    o.projection = buildUnnamed3307();
  }
  buildCounterGooglePrivacyDlpV2beta1DatastoreOptions--;
  return o;
}

checkGooglePrivacyDlpV2beta1DatastoreOptions(
    api.GooglePrivacyDlpV2beta1DatastoreOptions o) {
  buildCounterGooglePrivacyDlpV2beta1DatastoreOptions++;
  if (buildCounterGooglePrivacyDlpV2beta1DatastoreOptions < 3) {
    checkGooglePrivacyDlpV2beta1KindExpression(o.kind);
    checkGooglePrivacyDlpV2beta1PartitionId(o.partitionId);
    checkUnnamed3307(o.projection);
  }
  buildCounterGooglePrivacyDlpV2beta1DatastoreOptions--;
}

core.int buildCounterGooglePrivacyDlpV2beta1FieldId = 0;
buildGooglePrivacyDlpV2beta1FieldId() {
  var o = new api.GooglePrivacyDlpV2beta1FieldId();
  buildCounterGooglePrivacyDlpV2beta1FieldId++;
  if (buildCounterGooglePrivacyDlpV2beta1FieldId < 3) {
    o.columnName = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1FieldId--;
  return o;
}

checkGooglePrivacyDlpV2beta1FieldId(api.GooglePrivacyDlpV2beta1FieldId o) {
  buildCounterGooglePrivacyDlpV2beta1FieldId++;
  if (buildCounterGooglePrivacyDlpV2beta1FieldId < 3) {
    unittest.expect(o.columnName, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1FieldId--;
}

core.int buildCounterGooglePrivacyDlpV2beta1FileSet = 0;
buildGooglePrivacyDlpV2beta1FileSet() {
  var o = new api.GooglePrivacyDlpV2beta1FileSet();
  buildCounterGooglePrivacyDlpV2beta1FileSet++;
  if (buildCounterGooglePrivacyDlpV2beta1FileSet < 3) {
    o.url = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1FileSet--;
  return o;
}

checkGooglePrivacyDlpV2beta1FileSet(api.GooglePrivacyDlpV2beta1FileSet o) {
  buildCounterGooglePrivacyDlpV2beta1FileSet++;
  if (buildCounterGooglePrivacyDlpV2beta1FileSet < 3) {
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1FileSet--;
}

core.int buildCounterGooglePrivacyDlpV2beta1Finding = 0;
buildGooglePrivacyDlpV2beta1Finding() {
  var o = new api.GooglePrivacyDlpV2beta1Finding();
  buildCounterGooglePrivacyDlpV2beta1Finding++;
  if (buildCounterGooglePrivacyDlpV2beta1Finding < 3) {
    o.createTime = "foo";
    o.infoType = buildGooglePrivacyDlpV2beta1InfoType();
    o.likelihood = "foo";
    o.location = buildGooglePrivacyDlpV2beta1Location();
    o.quote = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1Finding--;
  return o;
}

checkGooglePrivacyDlpV2beta1Finding(api.GooglePrivacyDlpV2beta1Finding o) {
  buildCounterGooglePrivacyDlpV2beta1Finding++;
  if (buildCounterGooglePrivacyDlpV2beta1Finding < 3) {
    unittest.expect(o.createTime, unittest.equals('foo'));
    checkGooglePrivacyDlpV2beta1InfoType(o.infoType);
    unittest.expect(o.likelihood, unittest.equals('foo'));
    checkGooglePrivacyDlpV2beta1Location(o.location);
    unittest.expect(o.quote, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1Finding--;
}

core.int buildCounterGooglePrivacyDlpV2beta1ImageLocation = 0;
buildGooglePrivacyDlpV2beta1ImageLocation() {
  var o = new api.GooglePrivacyDlpV2beta1ImageLocation();
  buildCounterGooglePrivacyDlpV2beta1ImageLocation++;
  if (buildCounterGooglePrivacyDlpV2beta1ImageLocation < 3) {
    o.height = 42;
    o.left = 42;
    o.top = 42;
    o.width = 42;
  }
  buildCounterGooglePrivacyDlpV2beta1ImageLocation--;
  return o;
}

checkGooglePrivacyDlpV2beta1ImageLocation(
    api.GooglePrivacyDlpV2beta1ImageLocation o) {
  buildCounterGooglePrivacyDlpV2beta1ImageLocation++;
  if (buildCounterGooglePrivacyDlpV2beta1ImageLocation < 3) {
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.left, unittest.equals(42));
    unittest.expect(o.top, unittest.equals(42));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterGooglePrivacyDlpV2beta1ImageLocation--;
}

core.int buildCounterGooglePrivacyDlpV2beta1ImageRedactionConfig = 0;
buildGooglePrivacyDlpV2beta1ImageRedactionConfig() {
  var o = new api.GooglePrivacyDlpV2beta1ImageRedactionConfig();
  buildCounterGooglePrivacyDlpV2beta1ImageRedactionConfig++;
  if (buildCounterGooglePrivacyDlpV2beta1ImageRedactionConfig < 3) {
    o.infoType = buildGooglePrivacyDlpV2beta1InfoType();
    o.redactAllText = true;
    o.redactionColor = buildGooglePrivacyDlpV2beta1Color();
  }
  buildCounterGooglePrivacyDlpV2beta1ImageRedactionConfig--;
  return o;
}

checkGooglePrivacyDlpV2beta1ImageRedactionConfig(
    api.GooglePrivacyDlpV2beta1ImageRedactionConfig o) {
  buildCounterGooglePrivacyDlpV2beta1ImageRedactionConfig++;
  if (buildCounterGooglePrivacyDlpV2beta1ImageRedactionConfig < 3) {
    checkGooglePrivacyDlpV2beta1InfoType(o.infoType);
    unittest.expect(o.redactAllText, unittest.isTrue);
    checkGooglePrivacyDlpV2beta1Color(o.redactionColor);
  }
  buildCounterGooglePrivacyDlpV2beta1ImageRedactionConfig--;
}

core.int buildCounterGooglePrivacyDlpV2beta1InfoType = 0;
buildGooglePrivacyDlpV2beta1InfoType() {
  var o = new api.GooglePrivacyDlpV2beta1InfoType();
  buildCounterGooglePrivacyDlpV2beta1InfoType++;
  if (buildCounterGooglePrivacyDlpV2beta1InfoType < 3) {
    o.name = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1InfoType--;
  return o;
}

checkGooglePrivacyDlpV2beta1InfoType(api.GooglePrivacyDlpV2beta1InfoType o) {
  buildCounterGooglePrivacyDlpV2beta1InfoType++;
  if (buildCounterGooglePrivacyDlpV2beta1InfoType < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1InfoType--;
}

buildUnnamed3308() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1CategoryDescription>();
  o.add(buildGooglePrivacyDlpV2beta1CategoryDescription());
  o.add(buildGooglePrivacyDlpV2beta1CategoryDescription());
  return o;
}

checkUnnamed3308(core.List<api.GooglePrivacyDlpV2beta1CategoryDescription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1CategoryDescription(o[0]);
  checkGooglePrivacyDlpV2beta1CategoryDescription(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1InfoTypeDescription = 0;
buildGooglePrivacyDlpV2beta1InfoTypeDescription() {
  var o = new api.GooglePrivacyDlpV2beta1InfoTypeDescription();
  buildCounterGooglePrivacyDlpV2beta1InfoTypeDescription++;
  if (buildCounterGooglePrivacyDlpV2beta1InfoTypeDescription < 3) {
    o.categories = buildUnnamed3308();
    o.displayName = "foo";
    o.name = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1InfoTypeDescription--;
  return o;
}

checkGooglePrivacyDlpV2beta1InfoTypeDescription(
    api.GooglePrivacyDlpV2beta1InfoTypeDescription o) {
  buildCounterGooglePrivacyDlpV2beta1InfoTypeDescription++;
  if (buildCounterGooglePrivacyDlpV2beta1InfoTypeDescription < 3) {
    checkUnnamed3308(o.categories);
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1InfoTypeDescription--;
}

core.int buildCounterGooglePrivacyDlpV2beta1InfoTypeLimit = 0;
buildGooglePrivacyDlpV2beta1InfoTypeLimit() {
  var o = new api.GooglePrivacyDlpV2beta1InfoTypeLimit();
  buildCounterGooglePrivacyDlpV2beta1InfoTypeLimit++;
  if (buildCounterGooglePrivacyDlpV2beta1InfoTypeLimit < 3) {
    o.infoType = buildGooglePrivacyDlpV2beta1InfoType();
    o.maxFindings = 42;
  }
  buildCounterGooglePrivacyDlpV2beta1InfoTypeLimit--;
  return o;
}

checkGooglePrivacyDlpV2beta1InfoTypeLimit(
    api.GooglePrivacyDlpV2beta1InfoTypeLimit o) {
  buildCounterGooglePrivacyDlpV2beta1InfoTypeLimit++;
  if (buildCounterGooglePrivacyDlpV2beta1InfoTypeLimit < 3) {
    checkGooglePrivacyDlpV2beta1InfoType(o.infoType);
    unittest.expect(o.maxFindings, unittest.equals(42));
  }
  buildCounterGooglePrivacyDlpV2beta1InfoTypeLimit--;
}

core.int buildCounterGooglePrivacyDlpV2beta1InfoTypeStatistics = 0;
buildGooglePrivacyDlpV2beta1InfoTypeStatistics() {
  var o = new api.GooglePrivacyDlpV2beta1InfoTypeStatistics();
  buildCounterGooglePrivacyDlpV2beta1InfoTypeStatistics++;
  if (buildCounterGooglePrivacyDlpV2beta1InfoTypeStatistics < 3) {
    o.count = "foo";
    o.infoType = buildGooglePrivacyDlpV2beta1InfoType();
  }
  buildCounterGooglePrivacyDlpV2beta1InfoTypeStatistics--;
  return o;
}

checkGooglePrivacyDlpV2beta1InfoTypeStatistics(
    api.GooglePrivacyDlpV2beta1InfoTypeStatistics o) {
  buildCounterGooglePrivacyDlpV2beta1InfoTypeStatistics++;
  if (buildCounterGooglePrivacyDlpV2beta1InfoTypeStatistics < 3) {
    unittest.expect(o.count, unittest.equals('foo'));
    checkGooglePrivacyDlpV2beta1InfoType(o.infoType);
  }
  buildCounterGooglePrivacyDlpV2beta1InfoTypeStatistics--;
}

buildUnnamed3309() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1InfoTypeLimit>();
  o.add(buildGooglePrivacyDlpV2beta1InfoTypeLimit());
  o.add(buildGooglePrivacyDlpV2beta1InfoTypeLimit());
  return o;
}

checkUnnamed3309(core.List<api.GooglePrivacyDlpV2beta1InfoTypeLimit> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1InfoTypeLimit(o[0]);
  checkGooglePrivacyDlpV2beta1InfoTypeLimit(o[1]);
}

buildUnnamed3310() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1InfoType>();
  o.add(buildGooglePrivacyDlpV2beta1InfoType());
  o.add(buildGooglePrivacyDlpV2beta1InfoType());
  return o;
}

checkUnnamed3310(core.List<api.GooglePrivacyDlpV2beta1InfoType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1InfoType(o[0]);
  checkGooglePrivacyDlpV2beta1InfoType(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1InspectConfig = 0;
buildGooglePrivacyDlpV2beta1InspectConfig() {
  var o = new api.GooglePrivacyDlpV2beta1InspectConfig();
  buildCounterGooglePrivacyDlpV2beta1InspectConfig++;
  if (buildCounterGooglePrivacyDlpV2beta1InspectConfig < 3) {
    o.excludeTypes = true;
    o.includeQuote = true;
    o.infoTypeLimits = buildUnnamed3309();
    o.infoTypes = buildUnnamed3310();
    o.maxFindings = 42;
    o.minLikelihood = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1InspectConfig--;
  return o;
}

checkGooglePrivacyDlpV2beta1InspectConfig(
    api.GooglePrivacyDlpV2beta1InspectConfig o) {
  buildCounterGooglePrivacyDlpV2beta1InspectConfig++;
  if (buildCounterGooglePrivacyDlpV2beta1InspectConfig < 3) {
    unittest.expect(o.excludeTypes, unittest.isTrue);
    unittest.expect(o.includeQuote, unittest.isTrue);
    checkUnnamed3309(o.infoTypeLimits);
    checkUnnamed3310(o.infoTypes);
    unittest.expect(o.maxFindings, unittest.equals(42));
    unittest.expect(o.minLikelihood, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1InspectConfig--;
}

buildUnnamed3311() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1ContentItem>();
  o.add(buildGooglePrivacyDlpV2beta1ContentItem());
  o.add(buildGooglePrivacyDlpV2beta1ContentItem());
  return o;
}

checkUnnamed3311(core.List<api.GooglePrivacyDlpV2beta1ContentItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1ContentItem(o[0]);
  checkGooglePrivacyDlpV2beta1ContentItem(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1InspectContentRequest = 0;
buildGooglePrivacyDlpV2beta1InspectContentRequest() {
  var o = new api.GooglePrivacyDlpV2beta1InspectContentRequest();
  buildCounterGooglePrivacyDlpV2beta1InspectContentRequest++;
  if (buildCounterGooglePrivacyDlpV2beta1InspectContentRequest < 3) {
    o.inspectConfig = buildGooglePrivacyDlpV2beta1InspectConfig();
    o.items = buildUnnamed3311();
  }
  buildCounterGooglePrivacyDlpV2beta1InspectContentRequest--;
  return o;
}

checkGooglePrivacyDlpV2beta1InspectContentRequest(
    api.GooglePrivacyDlpV2beta1InspectContentRequest o) {
  buildCounterGooglePrivacyDlpV2beta1InspectContentRequest++;
  if (buildCounterGooglePrivacyDlpV2beta1InspectContentRequest < 3) {
    checkGooglePrivacyDlpV2beta1InspectConfig(o.inspectConfig);
    checkUnnamed3311(o.items);
  }
  buildCounterGooglePrivacyDlpV2beta1InspectContentRequest--;
}

buildUnnamed3312() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1InspectResult>();
  o.add(buildGooglePrivacyDlpV2beta1InspectResult());
  o.add(buildGooglePrivacyDlpV2beta1InspectResult());
  return o;
}

checkUnnamed3312(core.List<api.GooglePrivacyDlpV2beta1InspectResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1InspectResult(o[0]);
  checkGooglePrivacyDlpV2beta1InspectResult(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1InspectContentResponse = 0;
buildGooglePrivacyDlpV2beta1InspectContentResponse() {
  var o = new api.GooglePrivacyDlpV2beta1InspectContentResponse();
  buildCounterGooglePrivacyDlpV2beta1InspectContentResponse++;
  if (buildCounterGooglePrivacyDlpV2beta1InspectContentResponse < 3) {
    o.results = buildUnnamed3312();
  }
  buildCounterGooglePrivacyDlpV2beta1InspectContentResponse--;
  return o;
}

checkGooglePrivacyDlpV2beta1InspectContentResponse(
    api.GooglePrivacyDlpV2beta1InspectContentResponse o) {
  buildCounterGooglePrivacyDlpV2beta1InspectContentResponse++;
  if (buildCounterGooglePrivacyDlpV2beta1InspectContentResponse < 3) {
    checkUnnamed3312(o.results);
  }
  buildCounterGooglePrivacyDlpV2beta1InspectContentResponse--;
}

buildUnnamed3313() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1InfoTypeStatistics>();
  o.add(buildGooglePrivacyDlpV2beta1InfoTypeStatistics());
  o.add(buildGooglePrivacyDlpV2beta1InfoTypeStatistics());
  return o;
}

checkUnnamed3313(core.List<api.GooglePrivacyDlpV2beta1InfoTypeStatistics> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1InfoTypeStatistics(o[0]);
  checkGooglePrivacyDlpV2beta1InfoTypeStatistics(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1InspectOperationMetadata = 0;
buildGooglePrivacyDlpV2beta1InspectOperationMetadata() {
  var o = new api.GooglePrivacyDlpV2beta1InspectOperationMetadata();
  buildCounterGooglePrivacyDlpV2beta1InspectOperationMetadata++;
  if (buildCounterGooglePrivacyDlpV2beta1InspectOperationMetadata < 3) {
    o.createTime = "foo";
    o.infoTypeStats = buildUnnamed3313();
    o.processedBytes = "foo";
    o.requestInspectConfig = buildGooglePrivacyDlpV2beta1InspectConfig();
    o.requestOutputConfig = buildGooglePrivacyDlpV2beta1OutputStorageConfig();
    o.requestStorageConfig = buildGooglePrivacyDlpV2beta1StorageConfig();
    o.totalEstimatedBytes = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1InspectOperationMetadata--;
  return o;
}

checkGooglePrivacyDlpV2beta1InspectOperationMetadata(
    api.GooglePrivacyDlpV2beta1InspectOperationMetadata o) {
  buildCounterGooglePrivacyDlpV2beta1InspectOperationMetadata++;
  if (buildCounterGooglePrivacyDlpV2beta1InspectOperationMetadata < 3) {
    unittest.expect(o.createTime, unittest.equals('foo'));
    checkUnnamed3313(o.infoTypeStats);
    unittest.expect(o.processedBytes, unittest.equals('foo'));
    checkGooglePrivacyDlpV2beta1InspectConfig(o.requestInspectConfig);
    checkGooglePrivacyDlpV2beta1OutputStorageConfig(o.requestOutputConfig);
    checkGooglePrivacyDlpV2beta1StorageConfig(o.requestStorageConfig);
    unittest.expect(o.totalEstimatedBytes, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1InspectOperationMetadata--;
}

core.int buildCounterGooglePrivacyDlpV2beta1InspectOperationResult = 0;
buildGooglePrivacyDlpV2beta1InspectOperationResult() {
  var o = new api.GooglePrivacyDlpV2beta1InspectOperationResult();
  buildCounterGooglePrivacyDlpV2beta1InspectOperationResult++;
  if (buildCounterGooglePrivacyDlpV2beta1InspectOperationResult < 3) {
    o.name = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1InspectOperationResult--;
  return o;
}

checkGooglePrivacyDlpV2beta1InspectOperationResult(
    api.GooglePrivacyDlpV2beta1InspectOperationResult o) {
  buildCounterGooglePrivacyDlpV2beta1InspectOperationResult++;
  if (buildCounterGooglePrivacyDlpV2beta1InspectOperationResult < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1InspectOperationResult--;
}

buildUnnamed3314() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1Finding>();
  o.add(buildGooglePrivacyDlpV2beta1Finding());
  o.add(buildGooglePrivacyDlpV2beta1Finding());
  return o;
}

checkUnnamed3314(core.List<api.GooglePrivacyDlpV2beta1Finding> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1Finding(o[0]);
  checkGooglePrivacyDlpV2beta1Finding(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1InspectResult = 0;
buildGooglePrivacyDlpV2beta1InspectResult() {
  var o = new api.GooglePrivacyDlpV2beta1InspectResult();
  buildCounterGooglePrivacyDlpV2beta1InspectResult++;
  if (buildCounterGooglePrivacyDlpV2beta1InspectResult < 3) {
    o.findings = buildUnnamed3314();
    o.findingsTruncated = true;
  }
  buildCounterGooglePrivacyDlpV2beta1InspectResult--;
  return o;
}

checkGooglePrivacyDlpV2beta1InspectResult(
    api.GooglePrivacyDlpV2beta1InspectResult o) {
  buildCounterGooglePrivacyDlpV2beta1InspectResult++;
  if (buildCounterGooglePrivacyDlpV2beta1InspectResult < 3) {
    checkUnnamed3314(o.findings);
    unittest.expect(o.findingsTruncated, unittest.isTrue);
  }
  buildCounterGooglePrivacyDlpV2beta1InspectResult--;
}

buildUnnamed3315() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1PathElement>();
  o.add(buildGooglePrivacyDlpV2beta1PathElement());
  o.add(buildGooglePrivacyDlpV2beta1PathElement());
  return o;
}

checkUnnamed3315(core.List<api.GooglePrivacyDlpV2beta1PathElement> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1PathElement(o[0]);
  checkGooglePrivacyDlpV2beta1PathElement(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1Key = 0;
buildGooglePrivacyDlpV2beta1Key() {
  var o = new api.GooglePrivacyDlpV2beta1Key();
  buildCounterGooglePrivacyDlpV2beta1Key++;
  if (buildCounterGooglePrivacyDlpV2beta1Key < 3) {
    o.partitionId = buildGooglePrivacyDlpV2beta1PartitionId();
    o.path = buildUnnamed3315();
  }
  buildCounterGooglePrivacyDlpV2beta1Key--;
  return o;
}

checkGooglePrivacyDlpV2beta1Key(api.GooglePrivacyDlpV2beta1Key o) {
  buildCounterGooglePrivacyDlpV2beta1Key++;
  if (buildCounterGooglePrivacyDlpV2beta1Key < 3) {
    checkGooglePrivacyDlpV2beta1PartitionId(o.partitionId);
    checkUnnamed3315(o.path);
  }
  buildCounterGooglePrivacyDlpV2beta1Key--;
}

core.int buildCounterGooglePrivacyDlpV2beta1KindExpression = 0;
buildGooglePrivacyDlpV2beta1KindExpression() {
  var o = new api.GooglePrivacyDlpV2beta1KindExpression();
  buildCounterGooglePrivacyDlpV2beta1KindExpression++;
  if (buildCounterGooglePrivacyDlpV2beta1KindExpression < 3) {
    o.name = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1KindExpression--;
  return o;
}

checkGooglePrivacyDlpV2beta1KindExpression(
    api.GooglePrivacyDlpV2beta1KindExpression o) {
  buildCounterGooglePrivacyDlpV2beta1KindExpression++;
  if (buildCounterGooglePrivacyDlpV2beta1KindExpression < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1KindExpression--;
}

buildUnnamed3316() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1InfoTypeDescription>();
  o.add(buildGooglePrivacyDlpV2beta1InfoTypeDescription());
  o.add(buildGooglePrivacyDlpV2beta1InfoTypeDescription());
  return o;
}

checkUnnamed3316(core.List<api.GooglePrivacyDlpV2beta1InfoTypeDescription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1InfoTypeDescription(o[0]);
  checkGooglePrivacyDlpV2beta1InfoTypeDescription(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1ListInfoTypesResponse = 0;
buildGooglePrivacyDlpV2beta1ListInfoTypesResponse() {
  var o = new api.GooglePrivacyDlpV2beta1ListInfoTypesResponse();
  buildCounterGooglePrivacyDlpV2beta1ListInfoTypesResponse++;
  if (buildCounterGooglePrivacyDlpV2beta1ListInfoTypesResponse < 3) {
    o.infoTypes = buildUnnamed3316();
  }
  buildCounterGooglePrivacyDlpV2beta1ListInfoTypesResponse--;
  return o;
}

checkGooglePrivacyDlpV2beta1ListInfoTypesResponse(
    api.GooglePrivacyDlpV2beta1ListInfoTypesResponse o) {
  buildCounterGooglePrivacyDlpV2beta1ListInfoTypesResponse++;
  if (buildCounterGooglePrivacyDlpV2beta1ListInfoTypesResponse < 3) {
    checkUnnamed3316(o.infoTypes);
  }
  buildCounterGooglePrivacyDlpV2beta1ListInfoTypesResponse--;
}

core.int buildCounterGooglePrivacyDlpV2beta1ListInspectFindingsResponse = 0;
buildGooglePrivacyDlpV2beta1ListInspectFindingsResponse() {
  var o = new api.GooglePrivacyDlpV2beta1ListInspectFindingsResponse();
  buildCounterGooglePrivacyDlpV2beta1ListInspectFindingsResponse++;
  if (buildCounterGooglePrivacyDlpV2beta1ListInspectFindingsResponse < 3) {
    o.nextPageToken = "foo";
    o.result = buildGooglePrivacyDlpV2beta1InspectResult();
  }
  buildCounterGooglePrivacyDlpV2beta1ListInspectFindingsResponse--;
  return o;
}

checkGooglePrivacyDlpV2beta1ListInspectFindingsResponse(
    api.GooglePrivacyDlpV2beta1ListInspectFindingsResponse o) {
  buildCounterGooglePrivacyDlpV2beta1ListInspectFindingsResponse++;
  if (buildCounterGooglePrivacyDlpV2beta1ListInspectFindingsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkGooglePrivacyDlpV2beta1InspectResult(o.result);
  }
  buildCounterGooglePrivacyDlpV2beta1ListInspectFindingsResponse--;
}

buildUnnamed3317() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1CategoryDescription>();
  o.add(buildGooglePrivacyDlpV2beta1CategoryDescription());
  o.add(buildGooglePrivacyDlpV2beta1CategoryDescription());
  return o;
}

checkUnnamed3317(core.List<api.GooglePrivacyDlpV2beta1CategoryDescription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1CategoryDescription(o[0]);
  checkGooglePrivacyDlpV2beta1CategoryDescription(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1ListRootCategoriesResponse = 0;
buildGooglePrivacyDlpV2beta1ListRootCategoriesResponse() {
  var o = new api.GooglePrivacyDlpV2beta1ListRootCategoriesResponse();
  buildCounterGooglePrivacyDlpV2beta1ListRootCategoriesResponse++;
  if (buildCounterGooglePrivacyDlpV2beta1ListRootCategoriesResponse < 3) {
    o.categories = buildUnnamed3317();
  }
  buildCounterGooglePrivacyDlpV2beta1ListRootCategoriesResponse--;
  return o;
}

checkGooglePrivacyDlpV2beta1ListRootCategoriesResponse(
    api.GooglePrivacyDlpV2beta1ListRootCategoriesResponse o) {
  buildCounterGooglePrivacyDlpV2beta1ListRootCategoriesResponse++;
  if (buildCounterGooglePrivacyDlpV2beta1ListRootCategoriesResponse < 3) {
    checkUnnamed3317(o.categories);
  }
  buildCounterGooglePrivacyDlpV2beta1ListRootCategoriesResponse--;
}

buildUnnamed3318() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1ImageLocation>();
  o.add(buildGooglePrivacyDlpV2beta1ImageLocation());
  o.add(buildGooglePrivacyDlpV2beta1ImageLocation());
  return o;
}

checkUnnamed3318(core.List<api.GooglePrivacyDlpV2beta1ImageLocation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1ImageLocation(o[0]);
  checkGooglePrivacyDlpV2beta1ImageLocation(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1Location = 0;
buildGooglePrivacyDlpV2beta1Location() {
  var o = new api.GooglePrivacyDlpV2beta1Location();
  buildCounterGooglePrivacyDlpV2beta1Location++;
  if (buildCounterGooglePrivacyDlpV2beta1Location < 3) {
    o.byteRange = buildGooglePrivacyDlpV2beta1Range();
    o.codepointRange = buildGooglePrivacyDlpV2beta1Range();
    o.fieldId = buildGooglePrivacyDlpV2beta1FieldId();
    o.imageBoxes = buildUnnamed3318();
    o.recordKey = buildGooglePrivacyDlpV2beta1RecordKey();
    o.tableLocation = buildGooglePrivacyDlpV2beta1TableLocation();
  }
  buildCounterGooglePrivacyDlpV2beta1Location--;
  return o;
}

checkGooglePrivacyDlpV2beta1Location(api.GooglePrivacyDlpV2beta1Location o) {
  buildCounterGooglePrivacyDlpV2beta1Location++;
  if (buildCounterGooglePrivacyDlpV2beta1Location < 3) {
    checkGooglePrivacyDlpV2beta1Range(o.byteRange);
    checkGooglePrivacyDlpV2beta1Range(o.codepointRange);
    checkGooglePrivacyDlpV2beta1FieldId(o.fieldId);
    checkUnnamed3318(o.imageBoxes);
    checkGooglePrivacyDlpV2beta1RecordKey(o.recordKey);
    checkGooglePrivacyDlpV2beta1TableLocation(o.tableLocation);
  }
  buildCounterGooglePrivacyDlpV2beta1Location--;
}

core.int buildCounterGooglePrivacyDlpV2beta1OperationConfig = 0;
buildGooglePrivacyDlpV2beta1OperationConfig() {
  var o = new api.GooglePrivacyDlpV2beta1OperationConfig();
  buildCounterGooglePrivacyDlpV2beta1OperationConfig++;
  if (buildCounterGooglePrivacyDlpV2beta1OperationConfig < 3) {
    o.maxItemFindings = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1OperationConfig--;
  return o;
}

checkGooglePrivacyDlpV2beta1OperationConfig(
    api.GooglePrivacyDlpV2beta1OperationConfig o) {
  buildCounterGooglePrivacyDlpV2beta1OperationConfig++;
  if (buildCounterGooglePrivacyDlpV2beta1OperationConfig < 3) {
    unittest.expect(o.maxItemFindings, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1OperationConfig--;
}

core.int buildCounterGooglePrivacyDlpV2beta1OutputStorageConfig = 0;
buildGooglePrivacyDlpV2beta1OutputStorageConfig() {
  var o = new api.GooglePrivacyDlpV2beta1OutputStorageConfig();
  buildCounterGooglePrivacyDlpV2beta1OutputStorageConfig++;
  if (buildCounterGooglePrivacyDlpV2beta1OutputStorageConfig < 3) {
    o.storagePath = buildGooglePrivacyDlpV2beta1CloudStoragePath();
    o.table = buildGooglePrivacyDlpV2beta1BigQueryTable();
  }
  buildCounterGooglePrivacyDlpV2beta1OutputStorageConfig--;
  return o;
}

checkGooglePrivacyDlpV2beta1OutputStorageConfig(
    api.GooglePrivacyDlpV2beta1OutputStorageConfig o) {
  buildCounterGooglePrivacyDlpV2beta1OutputStorageConfig++;
  if (buildCounterGooglePrivacyDlpV2beta1OutputStorageConfig < 3) {
    checkGooglePrivacyDlpV2beta1CloudStoragePath(o.storagePath);
    checkGooglePrivacyDlpV2beta1BigQueryTable(o.table);
  }
  buildCounterGooglePrivacyDlpV2beta1OutputStorageConfig--;
}

core.int buildCounterGooglePrivacyDlpV2beta1PartitionId = 0;
buildGooglePrivacyDlpV2beta1PartitionId() {
  var o = new api.GooglePrivacyDlpV2beta1PartitionId();
  buildCounterGooglePrivacyDlpV2beta1PartitionId++;
  if (buildCounterGooglePrivacyDlpV2beta1PartitionId < 3) {
    o.namespaceId = "foo";
    o.projectId = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1PartitionId--;
  return o;
}

checkGooglePrivacyDlpV2beta1PartitionId(
    api.GooglePrivacyDlpV2beta1PartitionId o) {
  buildCounterGooglePrivacyDlpV2beta1PartitionId++;
  if (buildCounterGooglePrivacyDlpV2beta1PartitionId < 3) {
    unittest.expect(o.namespaceId, unittest.equals('foo'));
    unittest.expect(o.projectId, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1PartitionId--;
}

core.int buildCounterGooglePrivacyDlpV2beta1PathElement = 0;
buildGooglePrivacyDlpV2beta1PathElement() {
  var o = new api.GooglePrivacyDlpV2beta1PathElement();
  buildCounterGooglePrivacyDlpV2beta1PathElement++;
  if (buildCounterGooglePrivacyDlpV2beta1PathElement < 3) {
    o.id = "foo";
    o.kind = "foo";
    o.name = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1PathElement--;
  return o;
}

checkGooglePrivacyDlpV2beta1PathElement(
    api.GooglePrivacyDlpV2beta1PathElement o) {
  buildCounterGooglePrivacyDlpV2beta1PathElement++;
  if (buildCounterGooglePrivacyDlpV2beta1PathElement < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1PathElement--;
}

core.int buildCounterGooglePrivacyDlpV2beta1Projection = 0;
buildGooglePrivacyDlpV2beta1Projection() {
  var o = new api.GooglePrivacyDlpV2beta1Projection();
  buildCounterGooglePrivacyDlpV2beta1Projection++;
  if (buildCounterGooglePrivacyDlpV2beta1Projection < 3) {
    o.property = buildGooglePrivacyDlpV2beta1PropertyReference();
  }
  buildCounterGooglePrivacyDlpV2beta1Projection--;
  return o;
}

checkGooglePrivacyDlpV2beta1Projection(
    api.GooglePrivacyDlpV2beta1Projection o) {
  buildCounterGooglePrivacyDlpV2beta1Projection++;
  if (buildCounterGooglePrivacyDlpV2beta1Projection < 3) {
    checkGooglePrivacyDlpV2beta1PropertyReference(o.property);
  }
  buildCounterGooglePrivacyDlpV2beta1Projection--;
}

core.int buildCounterGooglePrivacyDlpV2beta1PropertyReference = 0;
buildGooglePrivacyDlpV2beta1PropertyReference() {
  var o = new api.GooglePrivacyDlpV2beta1PropertyReference();
  buildCounterGooglePrivacyDlpV2beta1PropertyReference++;
  if (buildCounterGooglePrivacyDlpV2beta1PropertyReference < 3) {
    o.name = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1PropertyReference--;
  return o;
}

checkGooglePrivacyDlpV2beta1PropertyReference(
    api.GooglePrivacyDlpV2beta1PropertyReference o) {
  buildCounterGooglePrivacyDlpV2beta1PropertyReference++;
  if (buildCounterGooglePrivacyDlpV2beta1PropertyReference < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1PropertyReference--;
}

core.int buildCounterGooglePrivacyDlpV2beta1Range = 0;
buildGooglePrivacyDlpV2beta1Range() {
  var o = new api.GooglePrivacyDlpV2beta1Range();
  buildCounterGooglePrivacyDlpV2beta1Range++;
  if (buildCounterGooglePrivacyDlpV2beta1Range < 3) {
    o.end = "foo";
    o.start = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1Range--;
  return o;
}

checkGooglePrivacyDlpV2beta1Range(api.GooglePrivacyDlpV2beta1Range o) {
  buildCounterGooglePrivacyDlpV2beta1Range++;
  if (buildCounterGooglePrivacyDlpV2beta1Range < 3) {
    unittest.expect(o.end, unittest.equals('foo'));
    unittest.expect(o.start, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1Range--;
}

core.int buildCounterGooglePrivacyDlpV2beta1RecordKey = 0;
buildGooglePrivacyDlpV2beta1RecordKey() {
  var o = new api.GooglePrivacyDlpV2beta1RecordKey();
  buildCounterGooglePrivacyDlpV2beta1RecordKey++;
  if (buildCounterGooglePrivacyDlpV2beta1RecordKey < 3) {
    o.cloudStorageKey = buildGooglePrivacyDlpV2beta1CloudStorageKey();
    o.datastoreKey = buildGooglePrivacyDlpV2beta1DatastoreKey();
  }
  buildCounterGooglePrivacyDlpV2beta1RecordKey--;
  return o;
}

checkGooglePrivacyDlpV2beta1RecordKey(api.GooglePrivacyDlpV2beta1RecordKey o) {
  buildCounterGooglePrivacyDlpV2beta1RecordKey++;
  if (buildCounterGooglePrivacyDlpV2beta1RecordKey < 3) {
    checkGooglePrivacyDlpV2beta1CloudStorageKey(o.cloudStorageKey);
    checkGooglePrivacyDlpV2beta1DatastoreKey(o.datastoreKey);
  }
  buildCounterGooglePrivacyDlpV2beta1RecordKey--;
}

buildUnnamed3319() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1ImageRedactionConfig>();
  o.add(buildGooglePrivacyDlpV2beta1ImageRedactionConfig());
  o.add(buildGooglePrivacyDlpV2beta1ImageRedactionConfig());
  return o;
}

checkUnnamed3319(core.List<api.GooglePrivacyDlpV2beta1ImageRedactionConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1ImageRedactionConfig(o[0]);
  checkGooglePrivacyDlpV2beta1ImageRedactionConfig(o[1]);
}

buildUnnamed3320() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1ContentItem>();
  o.add(buildGooglePrivacyDlpV2beta1ContentItem());
  o.add(buildGooglePrivacyDlpV2beta1ContentItem());
  return o;
}

checkUnnamed3320(core.List<api.GooglePrivacyDlpV2beta1ContentItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1ContentItem(o[0]);
  checkGooglePrivacyDlpV2beta1ContentItem(o[1]);
}

buildUnnamed3321() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1ReplaceConfig>();
  o.add(buildGooglePrivacyDlpV2beta1ReplaceConfig());
  o.add(buildGooglePrivacyDlpV2beta1ReplaceConfig());
  return o;
}

checkUnnamed3321(core.List<api.GooglePrivacyDlpV2beta1ReplaceConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1ReplaceConfig(o[0]);
  checkGooglePrivacyDlpV2beta1ReplaceConfig(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1RedactContentRequest = 0;
buildGooglePrivacyDlpV2beta1RedactContentRequest() {
  var o = new api.GooglePrivacyDlpV2beta1RedactContentRequest();
  buildCounterGooglePrivacyDlpV2beta1RedactContentRequest++;
  if (buildCounterGooglePrivacyDlpV2beta1RedactContentRequest < 3) {
    o.imageRedactionConfigs = buildUnnamed3319();
    o.inspectConfig = buildGooglePrivacyDlpV2beta1InspectConfig();
    o.items = buildUnnamed3320();
    o.replaceConfigs = buildUnnamed3321();
  }
  buildCounterGooglePrivacyDlpV2beta1RedactContentRequest--;
  return o;
}

checkGooglePrivacyDlpV2beta1RedactContentRequest(
    api.GooglePrivacyDlpV2beta1RedactContentRequest o) {
  buildCounterGooglePrivacyDlpV2beta1RedactContentRequest++;
  if (buildCounterGooglePrivacyDlpV2beta1RedactContentRequest < 3) {
    checkUnnamed3319(o.imageRedactionConfigs);
    checkGooglePrivacyDlpV2beta1InspectConfig(o.inspectConfig);
    checkUnnamed3320(o.items);
    checkUnnamed3321(o.replaceConfigs);
  }
  buildCounterGooglePrivacyDlpV2beta1RedactContentRequest--;
}

buildUnnamed3322() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1ContentItem>();
  o.add(buildGooglePrivacyDlpV2beta1ContentItem());
  o.add(buildGooglePrivacyDlpV2beta1ContentItem());
  return o;
}

checkUnnamed3322(core.List<api.GooglePrivacyDlpV2beta1ContentItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1ContentItem(o[0]);
  checkGooglePrivacyDlpV2beta1ContentItem(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1RedactContentResponse = 0;
buildGooglePrivacyDlpV2beta1RedactContentResponse() {
  var o = new api.GooglePrivacyDlpV2beta1RedactContentResponse();
  buildCounterGooglePrivacyDlpV2beta1RedactContentResponse++;
  if (buildCounterGooglePrivacyDlpV2beta1RedactContentResponse < 3) {
    o.items = buildUnnamed3322();
  }
  buildCounterGooglePrivacyDlpV2beta1RedactContentResponse--;
  return o;
}

checkGooglePrivacyDlpV2beta1RedactContentResponse(
    api.GooglePrivacyDlpV2beta1RedactContentResponse o) {
  buildCounterGooglePrivacyDlpV2beta1RedactContentResponse++;
  if (buildCounterGooglePrivacyDlpV2beta1RedactContentResponse < 3) {
    checkUnnamed3322(o.items);
  }
  buildCounterGooglePrivacyDlpV2beta1RedactContentResponse--;
}

core.int buildCounterGooglePrivacyDlpV2beta1ReplaceConfig = 0;
buildGooglePrivacyDlpV2beta1ReplaceConfig() {
  var o = new api.GooglePrivacyDlpV2beta1ReplaceConfig();
  buildCounterGooglePrivacyDlpV2beta1ReplaceConfig++;
  if (buildCounterGooglePrivacyDlpV2beta1ReplaceConfig < 3) {
    o.infoType = buildGooglePrivacyDlpV2beta1InfoType();
    o.replaceWith = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1ReplaceConfig--;
  return o;
}

checkGooglePrivacyDlpV2beta1ReplaceConfig(
    api.GooglePrivacyDlpV2beta1ReplaceConfig o) {
  buildCounterGooglePrivacyDlpV2beta1ReplaceConfig++;
  if (buildCounterGooglePrivacyDlpV2beta1ReplaceConfig < 3) {
    checkGooglePrivacyDlpV2beta1InfoType(o.infoType);
    unittest.expect(o.replaceWith, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1ReplaceConfig--;
}

buildUnnamed3323() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1Value>();
  o.add(buildGooglePrivacyDlpV2beta1Value());
  o.add(buildGooglePrivacyDlpV2beta1Value());
  return o;
}

checkUnnamed3323(core.List<api.GooglePrivacyDlpV2beta1Value> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1Value(o[0]);
  checkGooglePrivacyDlpV2beta1Value(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1Row = 0;
buildGooglePrivacyDlpV2beta1Row() {
  var o = new api.GooglePrivacyDlpV2beta1Row();
  buildCounterGooglePrivacyDlpV2beta1Row++;
  if (buildCounterGooglePrivacyDlpV2beta1Row < 3) {
    o.values = buildUnnamed3323();
  }
  buildCounterGooglePrivacyDlpV2beta1Row--;
  return o;
}

checkGooglePrivacyDlpV2beta1Row(api.GooglePrivacyDlpV2beta1Row o) {
  buildCounterGooglePrivacyDlpV2beta1Row++;
  if (buildCounterGooglePrivacyDlpV2beta1Row < 3) {
    checkUnnamed3323(o.values);
  }
  buildCounterGooglePrivacyDlpV2beta1Row--;
}

core.int buildCounterGooglePrivacyDlpV2beta1StorageConfig = 0;
buildGooglePrivacyDlpV2beta1StorageConfig() {
  var o = new api.GooglePrivacyDlpV2beta1StorageConfig();
  buildCounterGooglePrivacyDlpV2beta1StorageConfig++;
  if (buildCounterGooglePrivacyDlpV2beta1StorageConfig < 3) {
    o.bigQueryOptions = buildGooglePrivacyDlpV2beta1BigQueryOptions();
    o.cloudStorageOptions = buildGooglePrivacyDlpV2beta1CloudStorageOptions();
    o.datastoreOptions = buildGooglePrivacyDlpV2beta1DatastoreOptions();
  }
  buildCounterGooglePrivacyDlpV2beta1StorageConfig--;
  return o;
}

checkGooglePrivacyDlpV2beta1StorageConfig(
    api.GooglePrivacyDlpV2beta1StorageConfig o) {
  buildCounterGooglePrivacyDlpV2beta1StorageConfig++;
  if (buildCounterGooglePrivacyDlpV2beta1StorageConfig < 3) {
    checkGooglePrivacyDlpV2beta1BigQueryOptions(o.bigQueryOptions);
    checkGooglePrivacyDlpV2beta1CloudStorageOptions(o.cloudStorageOptions);
    checkGooglePrivacyDlpV2beta1DatastoreOptions(o.datastoreOptions);
  }
  buildCounterGooglePrivacyDlpV2beta1StorageConfig--;
}

buildUnnamed3324() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1FieldId>();
  o.add(buildGooglePrivacyDlpV2beta1FieldId());
  o.add(buildGooglePrivacyDlpV2beta1FieldId());
  return o;
}

checkUnnamed3324(core.List<api.GooglePrivacyDlpV2beta1FieldId> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1FieldId(o[0]);
  checkGooglePrivacyDlpV2beta1FieldId(o[1]);
}

buildUnnamed3325() {
  var o = new core.List<api.GooglePrivacyDlpV2beta1Row>();
  o.add(buildGooglePrivacyDlpV2beta1Row());
  o.add(buildGooglePrivacyDlpV2beta1Row());
  return o;
}

checkUnnamed3325(core.List<api.GooglePrivacyDlpV2beta1Row> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGooglePrivacyDlpV2beta1Row(o[0]);
  checkGooglePrivacyDlpV2beta1Row(o[1]);
}

core.int buildCounterGooglePrivacyDlpV2beta1Table = 0;
buildGooglePrivacyDlpV2beta1Table() {
  var o = new api.GooglePrivacyDlpV2beta1Table();
  buildCounterGooglePrivacyDlpV2beta1Table++;
  if (buildCounterGooglePrivacyDlpV2beta1Table < 3) {
    o.headers = buildUnnamed3324();
    o.rows = buildUnnamed3325();
  }
  buildCounterGooglePrivacyDlpV2beta1Table--;
  return o;
}

checkGooglePrivacyDlpV2beta1Table(api.GooglePrivacyDlpV2beta1Table o) {
  buildCounterGooglePrivacyDlpV2beta1Table++;
  if (buildCounterGooglePrivacyDlpV2beta1Table < 3) {
    checkUnnamed3324(o.headers);
    checkUnnamed3325(o.rows);
  }
  buildCounterGooglePrivacyDlpV2beta1Table--;
}

core.int buildCounterGooglePrivacyDlpV2beta1TableLocation = 0;
buildGooglePrivacyDlpV2beta1TableLocation() {
  var o = new api.GooglePrivacyDlpV2beta1TableLocation();
  buildCounterGooglePrivacyDlpV2beta1TableLocation++;
  if (buildCounterGooglePrivacyDlpV2beta1TableLocation < 3) {
    o.rowIndex = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1TableLocation--;
  return o;
}

checkGooglePrivacyDlpV2beta1TableLocation(
    api.GooglePrivacyDlpV2beta1TableLocation o) {
  buildCounterGooglePrivacyDlpV2beta1TableLocation++;
  if (buildCounterGooglePrivacyDlpV2beta1TableLocation < 3) {
    unittest.expect(o.rowIndex, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1TableLocation--;
}

core.int buildCounterGooglePrivacyDlpV2beta1Value = 0;
buildGooglePrivacyDlpV2beta1Value() {
  var o = new api.GooglePrivacyDlpV2beta1Value();
  buildCounterGooglePrivacyDlpV2beta1Value++;
  if (buildCounterGooglePrivacyDlpV2beta1Value < 3) {
    o.booleanValue = true;
    o.dateValue = buildGoogleTypeDate();
    o.floatValue = 42.0;
    o.integerValue = "foo";
    o.stringValue = "foo";
    o.timeValue = buildGoogleTypeTimeOfDay();
    o.timestampValue = "foo";
  }
  buildCounterGooglePrivacyDlpV2beta1Value--;
  return o;
}

checkGooglePrivacyDlpV2beta1Value(api.GooglePrivacyDlpV2beta1Value o) {
  buildCounterGooglePrivacyDlpV2beta1Value++;
  if (buildCounterGooglePrivacyDlpV2beta1Value < 3) {
    unittest.expect(o.booleanValue, unittest.isTrue);
    checkGoogleTypeDate(o.dateValue);
    unittest.expect(o.floatValue, unittest.equals(42.0));
    unittest.expect(o.integerValue, unittest.equals('foo'));
    unittest.expect(o.stringValue, unittest.equals('foo'));
    checkGoogleTypeTimeOfDay(o.timeValue);
    unittest.expect(o.timestampValue, unittest.equals('foo'));
  }
  buildCounterGooglePrivacyDlpV2beta1Value--;
}

core.int buildCounterGoogleProtobufEmpty = 0;
buildGoogleProtobufEmpty() {
  var o = new api.GoogleProtobufEmpty();
  buildCounterGoogleProtobufEmpty++;
  if (buildCounterGoogleProtobufEmpty < 3) {}
  buildCounterGoogleProtobufEmpty--;
  return o;
}

checkGoogleProtobufEmpty(api.GoogleProtobufEmpty o) {
  buildCounterGoogleProtobufEmpty++;
  if (buildCounterGoogleProtobufEmpty < 3) {}
  buildCounterGoogleProtobufEmpty--;
}

buildUnnamed3326() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  o["y"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  return o;
}

checkUnnamed3326(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted5 = (o["x"]) as core.Map;
  unittest.expect(casted5, unittest.hasLength(3));
  unittest.expect(casted5["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted5["bool"], unittest.equals(true));
  unittest.expect(casted5["string"], unittest.equals('foo'));
  var casted6 = (o["y"]) as core.Map;
  unittest.expect(casted6, unittest.hasLength(3));
  unittest.expect(casted6["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted6["bool"], unittest.equals(true));
  unittest.expect(casted6["string"], unittest.equals('foo'));
}

buildUnnamed3327() {
  var o = new core.List<core.Map<core.String, core.Object>>();
  o.add(buildUnnamed3326());
  o.add(buildUnnamed3326());
  return o;
}

checkUnnamed3327(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed3326(o[0]);
  checkUnnamed3326(o[1]);
}

core.int buildCounterGoogleRpcStatus = 0;
buildGoogleRpcStatus() {
  var o = new api.GoogleRpcStatus();
  buildCounterGoogleRpcStatus++;
  if (buildCounterGoogleRpcStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed3327();
    o.message = "foo";
  }
  buildCounterGoogleRpcStatus--;
  return o;
}

checkGoogleRpcStatus(api.GoogleRpcStatus o) {
  buildCounterGoogleRpcStatus++;
  if (buildCounterGoogleRpcStatus < 3) {
    unittest.expect(o.code, unittest.equals(42));
    checkUnnamed3327(o.details);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterGoogleRpcStatus--;
}

core.int buildCounterGoogleTypeDate = 0;
buildGoogleTypeDate() {
  var o = new api.GoogleTypeDate();
  buildCounterGoogleTypeDate++;
  if (buildCounterGoogleTypeDate < 3) {
    o.day = 42;
    o.month = 42;
    o.year = 42;
  }
  buildCounterGoogleTypeDate--;
  return o;
}

checkGoogleTypeDate(api.GoogleTypeDate o) {
  buildCounterGoogleTypeDate++;
  if (buildCounterGoogleTypeDate < 3) {
    unittest.expect(o.day, unittest.equals(42));
    unittest.expect(o.month, unittest.equals(42));
    unittest.expect(o.year, unittest.equals(42));
  }
  buildCounterGoogleTypeDate--;
}

core.int buildCounterGoogleTypeTimeOfDay = 0;
buildGoogleTypeTimeOfDay() {
  var o = new api.GoogleTypeTimeOfDay();
  buildCounterGoogleTypeTimeOfDay++;
  if (buildCounterGoogleTypeTimeOfDay < 3) {
    o.hours = 42;
    o.minutes = 42;
    o.nanos = 42;
    o.seconds = 42;
  }
  buildCounterGoogleTypeTimeOfDay--;
  return o;
}

checkGoogleTypeTimeOfDay(api.GoogleTypeTimeOfDay o) {
  buildCounterGoogleTypeTimeOfDay++;
  if (buildCounterGoogleTypeTimeOfDay < 3) {
    unittest.expect(o.hours, unittest.equals(42));
    unittest.expect(o.minutes, unittest.equals(42));
    unittest.expect(o.nanos, unittest.equals(42));
    unittest.expect(o.seconds, unittest.equals(42));
  }
  buildCounterGoogleTypeTimeOfDay--;
}

main() {
  unittest.group("obj-schema-GoogleLongrunningCancelOperationRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleLongrunningCancelOperationRequest();
      var od =
          new api.GoogleLongrunningCancelOperationRequest.fromJson(o.toJson());
      checkGoogleLongrunningCancelOperationRequest(od);
    });
  });

  unittest.group("obj-schema-GoogleLongrunningListOperationsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleLongrunningListOperationsResponse();
      var od =
          new api.GoogleLongrunningListOperationsResponse.fromJson(o.toJson());
      checkGoogleLongrunningListOperationsResponse(od);
    });
  });

  unittest.group("obj-schema-GoogleLongrunningOperation", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleLongrunningOperation();
      var od = new api.GoogleLongrunningOperation.fromJson(o.toJson());
      checkGoogleLongrunningOperation(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1BigQueryOptions", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1BigQueryOptions();
      var od =
          new api.GooglePrivacyDlpV2beta1BigQueryOptions.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1BigQueryOptions(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1BigQueryTable", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1BigQueryTable();
      var od =
          new api.GooglePrivacyDlpV2beta1BigQueryTable.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1BigQueryTable(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1CategoryDescription", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1CategoryDescription();
      var od = new api.GooglePrivacyDlpV2beta1CategoryDescription.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1CategoryDescription(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1CloudStorageKey", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1CloudStorageKey();
      var od =
          new api.GooglePrivacyDlpV2beta1CloudStorageKey.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1CloudStorageKey(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1CloudStorageOptions", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1CloudStorageOptions();
      var od = new api.GooglePrivacyDlpV2beta1CloudStorageOptions.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1CloudStorageOptions(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1CloudStoragePath", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1CloudStoragePath();
      var od =
          new api.GooglePrivacyDlpV2beta1CloudStoragePath.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1CloudStoragePath(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1Color", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1Color();
      var od = new api.GooglePrivacyDlpV2beta1Color.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1Color(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1ContentItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1ContentItem();
      var od = new api.GooglePrivacyDlpV2beta1ContentItem.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1ContentItem(od);
    });
  });

  unittest.group(
      "obj-schema-GooglePrivacyDlpV2beta1CreateInspectOperationRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1CreateInspectOperationRequest();
      var od =
          new api.GooglePrivacyDlpV2beta1CreateInspectOperationRequest.fromJson(
              o.toJson());
      checkGooglePrivacyDlpV2beta1CreateInspectOperationRequest(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1DatastoreKey", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1DatastoreKey();
      var od = new api.GooglePrivacyDlpV2beta1DatastoreKey.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1DatastoreKey(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1DatastoreOptions", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1DatastoreOptions();
      var od =
          new api.GooglePrivacyDlpV2beta1DatastoreOptions.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1DatastoreOptions(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1FieldId", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1FieldId();
      var od = new api.GooglePrivacyDlpV2beta1FieldId.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1FieldId(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1FileSet", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1FileSet();
      var od = new api.GooglePrivacyDlpV2beta1FileSet.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1FileSet(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1Finding", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1Finding();
      var od = new api.GooglePrivacyDlpV2beta1Finding.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1Finding(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1ImageLocation", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1ImageLocation();
      var od =
          new api.GooglePrivacyDlpV2beta1ImageLocation.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1ImageLocation(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1ImageRedactionConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1ImageRedactionConfig();
      var od = new api.GooglePrivacyDlpV2beta1ImageRedactionConfig.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1ImageRedactionConfig(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1InfoType", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1InfoType();
      var od = new api.GooglePrivacyDlpV2beta1InfoType.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1InfoType(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1InfoTypeDescription", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1InfoTypeDescription();
      var od = new api.GooglePrivacyDlpV2beta1InfoTypeDescription.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1InfoTypeDescription(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1InfoTypeLimit", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1InfoTypeLimit();
      var od =
          new api.GooglePrivacyDlpV2beta1InfoTypeLimit.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1InfoTypeLimit(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1InfoTypeStatistics", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1InfoTypeStatistics();
      var od = new api.GooglePrivacyDlpV2beta1InfoTypeStatistics.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1InfoTypeStatistics(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1InspectConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1InspectConfig();
      var od =
          new api.GooglePrivacyDlpV2beta1InspectConfig.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1InspectConfig(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1InspectContentRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1InspectContentRequest();
      var od = new api.GooglePrivacyDlpV2beta1InspectContentRequest.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1InspectContentRequest(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1InspectContentResponse",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1InspectContentResponse();
      var od = new api.GooglePrivacyDlpV2beta1InspectContentResponse.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1InspectContentResponse(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1InspectOperationMetadata",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1InspectOperationMetadata();
      var od = new api.GooglePrivacyDlpV2beta1InspectOperationMetadata.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1InspectOperationMetadata(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1InspectOperationResult",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1InspectOperationResult();
      var od = new api.GooglePrivacyDlpV2beta1InspectOperationResult.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1InspectOperationResult(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1InspectResult", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1InspectResult();
      var od =
          new api.GooglePrivacyDlpV2beta1InspectResult.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1InspectResult(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1Key", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1Key();
      var od = new api.GooglePrivacyDlpV2beta1Key.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1Key(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1KindExpression", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1KindExpression();
      var od =
          new api.GooglePrivacyDlpV2beta1KindExpression.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1KindExpression(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1ListInfoTypesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1ListInfoTypesResponse();
      var od = new api.GooglePrivacyDlpV2beta1ListInfoTypesResponse.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1ListInfoTypesResponse(od);
    });
  });

  unittest.group(
      "obj-schema-GooglePrivacyDlpV2beta1ListInspectFindingsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1ListInspectFindingsResponse();
      var od =
          new api.GooglePrivacyDlpV2beta1ListInspectFindingsResponse.fromJson(
              o.toJson());
      checkGooglePrivacyDlpV2beta1ListInspectFindingsResponse(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1ListRootCategoriesResponse",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1ListRootCategoriesResponse();
      var od =
          new api.GooglePrivacyDlpV2beta1ListRootCategoriesResponse.fromJson(
              o.toJson());
      checkGooglePrivacyDlpV2beta1ListRootCategoriesResponse(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1Location", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1Location();
      var od = new api.GooglePrivacyDlpV2beta1Location.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1Location(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1OperationConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1OperationConfig();
      var od =
          new api.GooglePrivacyDlpV2beta1OperationConfig.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1OperationConfig(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1OutputStorageConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1OutputStorageConfig();
      var od = new api.GooglePrivacyDlpV2beta1OutputStorageConfig.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1OutputStorageConfig(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1PartitionId", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1PartitionId();
      var od = new api.GooglePrivacyDlpV2beta1PartitionId.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1PartitionId(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1PathElement", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1PathElement();
      var od = new api.GooglePrivacyDlpV2beta1PathElement.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1PathElement(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1Projection", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1Projection();
      var od = new api.GooglePrivacyDlpV2beta1Projection.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1Projection(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1PropertyReference", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1PropertyReference();
      var od =
          new api.GooglePrivacyDlpV2beta1PropertyReference.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1PropertyReference(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1Range", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1Range();
      var od = new api.GooglePrivacyDlpV2beta1Range.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1Range(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1RecordKey", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1RecordKey();
      var od = new api.GooglePrivacyDlpV2beta1RecordKey.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1RecordKey(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1RedactContentRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1RedactContentRequest();
      var od = new api.GooglePrivacyDlpV2beta1RedactContentRequest.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1RedactContentRequest(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1RedactContentResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1RedactContentResponse();
      var od = new api.GooglePrivacyDlpV2beta1RedactContentResponse.fromJson(
          o.toJson());
      checkGooglePrivacyDlpV2beta1RedactContentResponse(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1ReplaceConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1ReplaceConfig();
      var od =
          new api.GooglePrivacyDlpV2beta1ReplaceConfig.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1ReplaceConfig(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1Row", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1Row();
      var od = new api.GooglePrivacyDlpV2beta1Row.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1Row(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1StorageConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1StorageConfig();
      var od =
          new api.GooglePrivacyDlpV2beta1StorageConfig.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1StorageConfig(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1Table", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1Table();
      var od = new api.GooglePrivacyDlpV2beta1Table.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1Table(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1TableLocation", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1TableLocation();
      var od =
          new api.GooglePrivacyDlpV2beta1TableLocation.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1TableLocation(od);
    });
  });

  unittest.group("obj-schema-GooglePrivacyDlpV2beta1Value", () {
    unittest.test("to-json--from-json", () {
      var o = buildGooglePrivacyDlpV2beta1Value();
      var od = new api.GooglePrivacyDlpV2beta1Value.fromJson(o.toJson());
      checkGooglePrivacyDlpV2beta1Value(od);
    });
  });

  unittest.group("obj-schema-GoogleProtobufEmpty", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleProtobufEmpty();
      var od = new api.GoogleProtobufEmpty.fromJson(o.toJson());
      checkGoogleProtobufEmpty(od);
    });
  });

  unittest.group("obj-schema-GoogleRpcStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleRpcStatus();
      var od = new api.GoogleRpcStatus.fromJson(o.toJson());
      checkGoogleRpcStatus(od);
    });
  });

  unittest.group("obj-schema-GoogleTypeDate", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleTypeDate();
      var od = new api.GoogleTypeDate.fromJson(o.toJson());
      checkGoogleTypeDate(od);
    });
  });

  unittest.group("obj-schema-GoogleTypeTimeOfDay", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleTypeTimeOfDay();
      var od = new api.GoogleTypeTimeOfDay.fromJson(o.toJson());
      checkGoogleTypeTimeOfDay(od);
    });
  });

  unittest.group("resource-ContentResourceApi", () {
    unittest.test("method--inspect", () {
      var mock = new HttpServerMock();
      api.ContentResourceApi res = new api.DlpApi(mock).content;
      var arg_request = buildGooglePrivacyDlpV2beta1InspectContentRequest();
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            new api.GooglePrivacyDlpV2beta1InspectContentRequest.fromJson(json);
        checkGooglePrivacyDlpV2beta1InspectContentRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 23),
            unittest.equals("v2beta1/content:inspect"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON
            .encode(buildGooglePrivacyDlpV2beta1InspectContentResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.inspect(arg_request).then(unittest.expectAsync1(
          ((api.GooglePrivacyDlpV2beta1InspectContentResponse response) {
        checkGooglePrivacyDlpV2beta1InspectContentResponse(response);
      })));
    });

    unittest.test("method--redact", () {
      var mock = new HttpServerMock();
      api.ContentResourceApi res = new api.DlpApi(mock).content;
      var arg_request = buildGooglePrivacyDlpV2beta1RedactContentRequest();
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            new api.GooglePrivacyDlpV2beta1RedactContentRequest.fromJson(json);
        checkGooglePrivacyDlpV2beta1RedactContentRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22),
            unittest.equals("v2beta1/content:redact"));
        pathOffset += 22;

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
        var resp = convert.JSON
            .encode(buildGooglePrivacyDlpV2beta1RedactContentResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.redact(arg_request).then(unittest.expectAsync1(
          ((api.GooglePrivacyDlpV2beta1RedactContentResponse response) {
        checkGooglePrivacyDlpV2beta1RedactContentResponse(response);
      })));
    });
  });

  unittest.group("resource-InspectOperationsResourceApi", () {
    unittest.test("method--cancel", () {
      var mock = new HttpServerMock();
      api.InspectOperationsResourceApi res =
          new api.DlpApi(mock).inspect.operations;
      var arg_request = buildGoogleLongrunningCancelOperationRequest();
      var arg_name = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            new api.GoogleLongrunningCancelOperationRequest.fromJson(json);
        checkGoogleLongrunningCancelOperationRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v2beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildGoogleProtobufEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .cancel(arg_request, arg_name)
          .then(unittest.expectAsync1(((api.GoogleProtobufEmpty response) {
        checkGoogleProtobufEmpty(response);
      })));
    });

    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.InspectOperationsResourceApi res =
          new api.DlpApi(mock).inspect.operations;
      var arg_request =
          buildGooglePrivacyDlpV2beta1CreateInspectOperationRequest();
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api
                .GooglePrivacyDlpV2beta1CreateInspectOperationRequest.fromJson(
            json);
        checkGooglePrivacyDlpV2beta1CreateInspectOperationRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 26),
            unittest.equals("v2beta1/inspect/operations"));
        pathOffset += 26;

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
        var resp = convert.JSON.encode(buildGoogleLongrunningOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.create(arg_request).then(
          unittest.expectAsync1(((api.GoogleLongrunningOperation response) {
        checkGoogleLongrunningOperation(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.InspectOperationsResourceApi res =
          new api.DlpApi(mock).inspect.operations;
      var arg_name = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v2beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildGoogleProtobufEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_name)
          .then(unittest.expectAsync1(((api.GoogleProtobufEmpty response) {
        checkGoogleProtobufEmpty(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.InspectOperationsResourceApi res =
          new api.DlpApi(mock).inspect.operations;
      var arg_name = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v2beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildGoogleLongrunningOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_name).then(
          unittest.expectAsync1(((api.GoogleLongrunningOperation response) {
        checkGoogleLongrunningOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.InspectOperationsResourceApi res =
          new api.DlpApi(mock).inspect.operations;
      var arg_name = "foo";
      var arg_filter = "foo";
      var arg_pageToken = "foo";
      var arg_pageSize = 42;
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v2beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp =
            convert.JSON.encode(buildGoogleLongrunningListOperationsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_name,
              filter: arg_filter,
              pageToken: arg_pageToken,
              pageSize: arg_pageSize)
          .then(unittest.expectAsync1(
              ((api.GoogleLongrunningListOperationsResponse response) {
        checkGoogleLongrunningListOperationsResponse(response);
      })));
    });
  });

  unittest.group("resource-InspectResultsFindingsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.InspectResultsFindingsResourceApi res =
          new api.DlpApi(mock).inspect.results.findings;
      var arg_name = "foo";
      var arg_pageToken = "foo";
      var arg_pageSize = 42;
      var arg_filter = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v2beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON
            .encode(buildGooglePrivacyDlpV2beta1ListInspectFindingsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_name,
              pageToken: arg_pageToken,
              pageSize: arg_pageSize,
              filter: arg_filter)
          .then(unittest.expectAsync1(
              ((api.GooglePrivacyDlpV2beta1ListInspectFindingsResponse
                  response) {
        checkGooglePrivacyDlpV2beta1ListInspectFindingsResponse(response);
      })));
    });
  });

  unittest.group("resource-RiskAnalysisOperationsResourceApi", () {
    unittest.test("method--cancel", () {
      var mock = new HttpServerMock();
      api.RiskAnalysisOperationsResourceApi res =
          new api.DlpApi(mock).riskAnalysis.operations;
      var arg_request = buildGoogleLongrunningCancelOperationRequest();
      var arg_name = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            new api.GoogleLongrunningCancelOperationRequest.fromJson(json);
        checkGoogleLongrunningCancelOperationRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v2beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildGoogleProtobufEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .cancel(arg_request, arg_name)
          .then(unittest.expectAsync1(((api.GoogleProtobufEmpty response) {
        checkGoogleProtobufEmpty(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.RiskAnalysisOperationsResourceApi res =
          new api.DlpApi(mock).riskAnalysis.operations;
      var arg_name = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v2beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildGoogleProtobufEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_name)
          .then(unittest.expectAsync1(((api.GoogleProtobufEmpty response) {
        checkGoogleProtobufEmpty(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.RiskAnalysisOperationsResourceApi res =
          new api.DlpApi(mock).riskAnalysis.operations;
      var arg_name = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v2beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildGoogleLongrunningOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_name).then(
          unittest.expectAsync1(((api.GoogleLongrunningOperation response) {
        checkGoogleLongrunningOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.RiskAnalysisOperationsResourceApi res =
          new api.DlpApi(mock).riskAnalysis.operations;
      var arg_name = "foo";
      var arg_pageToken = "foo";
      var arg_pageSize = 42;
      var arg_filter = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v2beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp =
            convert.JSON.encode(buildGoogleLongrunningListOperationsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_name,
              pageToken: arg_pageToken,
              pageSize: arg_pageSize,
              filter: arg_filter)
          .then(unittest.expectAsync1(
              ((api.GoogleLongrunningListOperationsResponse response) {
        checkGoogleLongrunningListOperationsResponse(response);
      })));
    });
  });

  unittest.group("resource-RootCategoriesResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.RootCategoriesResourceApi res = new api.DlpApi(mock).rootCategories;
      var arg_languageCode = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22),
            unittest.equals("v2beta1/rootCategories"));
        pathOffset += 22;

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
            queryMap["languageCode"].first, unittest.equals(arg_languageCode));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON
            .encode(buildGooglePrivacyDlpV2beta1ListRootCategoriesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(languageCode: arg_languageCode).then(unittest.expectAsync1(
          ((api.GooglePrivacyDlpV2beta1ListRootCategoriesResponse response) {
        checkGooglePrivacyDlpV2beta1ListRootCategoriesResponse(response);
      })));
    });
  });

  unittest.group("resource-RootCategoriesInfoTypesResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.RootCategoriesInfoTypesResourceApi res =
          new api.DlpApi(mock).rootCategories.infoTypes;
      var arg_category = "foo";
      var arg_languageCode = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 23),
            unittest.equals("v2beta1/rootCategories/"));
        pathOffset += 23;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["languageCode"].first, unittest.equals(arg_languageCode));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON
            .encode(buildGooglePrivacyDlpV2beta1ListInfoTypesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_category, languageCode: arg_languageCode).then(unittest
          .expectAsync1(
              ((api.GooglePrivacyDlpV2beta1ListInfoTypesResponse response) {
        checkGooglePrivacyDlpV2beta1ListInfoTypesResponse(response);
      })));
    });
  });
}
