library googleapis_beta.sqladmin.v1beta3.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis_beta/sqladmin/v1beta3.dart' as api;

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

core.int buildCounterBackupConfiguration = 0;
buildBackupConfiguration() {
  var o = new api.BackupConfiguration();
  buildCounterBackupConfiguration++;
  if (buildCounterBackupConfiguration < 3) {
    o.binaryLogEnabled = true;
    o.enabled = true;
    o.id = "foo";
    o.kind = "foo";
    o.startTime = "foo";
  }
  buildCounterBackupConfiguration--;
  return o;
}

checkBackupConfiguration(api.BackupConfiguration o) {
  buildCounterBackupConfiguration++;
  if (buildCounterBackupConfiguration < 3) {
    unittest.expect(o.binaryLogEnabled, unittest.isTrue);
    unittest.expect(o.enabled, unittest.isTrue);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.startTime, unittest.equals('foo'));
  }
  buildCounterBackupConfiguration--;
}

core.int buildCounterBackupRun = 0;
buildBackupRun() {
  var o = new api.BackupRun();
  buildCounterBackupRun++;
  if (buildCounterBackupRun < 3) {
    o.backupConfiguration = "foo";
    o.dueTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.endTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.enqueuedTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.error = buildOperationError();
    o.instance = "foo";
    o.kind = "foo";
    o.startTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.status = "foo";
  }
  buildCounterBackupRun--;
  return o;
}

checkBackupRun(api.BackupRun o) {
  buildCounterBackupRun++;
  if (buildCounterBackupRun < 3) {
    unittest.expect(o.backupConfiguration, unittest.equals('foo'));
    unittest.expect(
        o.dueTime, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(
        o.endTime, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.enqueuedTime,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    checkOperationError(o.error);
    unittest.expect(o.instance, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.startTime,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterBackupRun--;
}

buildUnnamed3184() {
  var o = new core.List<api.BackupRun>();
  o.add(buildBackupRun());
  o.add(buildBackupRun());
  return o;
}

checkUnnamed3184(core.List<api.BackupRun> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBackupRun(o[0]);
  checkBackupRun(o[1]);
}

core.int buildCounterBackupRunsListResponse = 0;
buildBackupRunsListResponse() {
  var o = new api.BackupRunsListResponse();
  buildCounterBackupRunsListResponse++;
  if (buildCounterBackupRunsListResponse < 3) {
    o.items = buildUnnamed3184();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterBackupRunsListResponse--;
  return o;
}

checkBackupRunsListResponse(api.BackupRunsListResponse o) {
  buildCounterBackupRunsListResponse++;
  if (buildCounterBackupRunsListResponse < 3) {
    checkUnnamed3184(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterBackupRunsListResponse--;
}

core.int buildCounterBinLogCoordinates = 0;
buildBinLogCoordinates() {
  var o = new api.BinLogCoordinates();
  buildCounterBinLogCoordinates++;
  if (buildCounterBinLogCoordinates < 3) {
    o.binLogFileName = "foo";
    o.binLogPosition = "foo";
    o.kind = "foo";
  }
  buildCounterBinLogCoordinates--;
  return o;
}

checkBinLogCoordinates(api.BinLogCoordinates o) {
  buildCounterBinLogCoordinates++;
  if (buildCounterBinLogCoordinates < 3) {
    unittest.expect(o.binLogFileName, unittest.equals('foo'));
    unittest.expect(o.binLogPosition, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterBinLogCoordinates--;
}

core.int buildCounterCloneContext = 0;
buildCloneContext() {
  var o = new api.CloneContext();
  buildCounterCloneContext++;
  if (buildCounterCloneContext < 3) {
    o.binLogCoordinates = buildBinLogCoordinates();
    o.destinationInstanceName = "foo";
    o.kind = "foo";
    o.sourceInstanceName = "foo";
  }
  buildCounterCloneContext--;
  return o;
}

checkCloneContext(api.CloneContext o) {
  buildCounterCloneContext++;
  if (buildCounterCloneContext < 3) {
    checkBinLogCoordinates(o.binLogCoordinates);
    unittest.expect(o.destinationInstanceName, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.sourceInstanceName, unittest.equals('foo'));
  }
  buildCounterCloneContext--;
}

core.int buildCounterDatabaseFlags = 0;
buildDatabaseFlags() {
  var o = new api.DatabaseFlags();
  buildCounterDatabaseFlags++;
  if (buildCounterDatabaseFlags < 3) {
    o.name = "foo";
    o.value = "foo";
  }
  buildCounterDatabaseFlags--;
  return o;
}

checkDatabaseFlags(api.DatabaseFlags o) {
  buildCounterDatabaseFlags++;
  if (buildCounterDatabaseFlags < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterDatabaseFlags--;
}

buildUnnamed3185() {
  var o = new core.List<api.IpMapping>();
  o.add(buildIpMapping());
  o.add(buildIpMapping());
  return o;
}

checkUnnamed3185(core.List<api.IpMapping> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkIpMapping(o[0]);
  checkIpMapping(o[1]);
}

buildUnnamed3186() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3186(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterDatabaseInstance = 0;
buildDatabaseInstance() {
  var o = new api.DatabaseInstance();
  buildCounterDatabaseInstance++;
  if (buildCounterDatabaseInstance < 3) {
    o.connectionName = "foo";
    o.currentDiskSize = "foo";
    o.databaseVersion = "foo";
    o.etag = "foo";
    o.instance = "foo";
    o.instanceType = "foo";
    o.ipAddresses = buildUnnamed3185();
    o.ipv6Address = "foo";
    o.kind = "foo";
    o.masterInstanceName = "foo";
    o.maxDiskSize = "foo";
    o.project = "foo";
    o.region = "foo";
    o.replicaNames = buildUnnamed3186();
    o.serverCaCert = buildSslCert();
    o.serviceAccountEmailAddress = "foo";
    o.settings = buildSettings();
    o.state = "foo";
  }
  buildCounterDatabaseInstance--;
  return o;
}

checkDatabaseInstance(api.DatabaseInstance o) {
  buildCounterDatabaseInstance++;
  if (buildCounterDatabaseInstance < 3) {
    unittest.expect(o.connectionName, unittest.equals('foo'));
    unittest.expect(o.currentDiskSize, unittest.equals('foo'));
    unittest.expect(o.databaseVersion, unittest.equals('foo'));
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.instance, unittest.equals('foo'));
    unittest.expect(o.instanceType, unittest.equals('foo'));
    checkUnnamed3185(o.ipAddresses);
    unittest.expect(o.ipv6Address, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.masterInstanceName, unittest.equals('foo'));
    unittest.expect(o.maxDiskSize, unittest.equals('foo'));
    unittest.expect(o.project, unittest.equals('foo'));
    unittest.expect(o.region, unittest.equals('foo'));
    checkUnnamed3186(o.replicaNames);
    checkSslCert(o.serverCaCert);
    unittest.expect(o.serviceAccountEmailAddress, unittest.equals('foo'));
    checkSettings(o.settings);
    unittest.expect(o.state, unittest.equals('foo'));
  }
  buildCounterDatabaseInstance--;
}

buildUnnamed3187() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3187(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3188() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3188(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterExportContext = 0;
buildExportContext() {
  var o = new api.ExportContext();
  buildCounterExportContext++;
  if (buildCounterExportContext < 3) {
    o.database = buildUnnamed3187();
    o.kind = "foo";
    o.table = buildUnnamed3188();
    o.uri = "foo";
  }
  buildCounterExportContext--;
  return o;
}

checkExportContext(api.ExportContext o) {
  buildCounterExportContext++;
  if (buildCounterExportContext < 3) {
    checkUnnamed3187(o.database);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed3188(o.table);
    unittest.expect(o.uri, unittest.equals('foo'));
  }
  buildCounterExportContext--;
}

buildUnnamed3189() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3189(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3190() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3190(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterFlag = 0;
buildFlag() {
  var o = new api.Flag();
  buildCounterFlag++;
  if (buildCounterFlag < 3) {
    o.allowedStringValues = buildUnnamed3189();
    o.appliesTo = buildUnnamed3190();
    o.kind = "foo";
    o.maxValue = "foo";
    o.minValue = "foo";
    o.name = "foo";
    o.type = "foo";
  }
  buildCounterFlag--;
  return o;
}

checkFlag(api.Flag o) {
  buildCounterFlag++;
  if (buildCounterFlag < 3) {
    checkUnnamed3189(o.allowedStringValues);
    checkUnnamed3190(o.appliesTo);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.maxValue, unittest.equals('foo'));
    unittest.expect(o.minValue, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterFlag--;
}

buildUnnamed3191() {
  var o = new core.List<api.Flag>();
  o.add(buildFlag());
  o.add(buildFlag());
  return o;
}

checkUnnamed3191(core.List<api.Flag> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFlag(o[0]);
  checkFlag(o[1]);
}

core.int buildCounterFlagsListResponse = 0;
buildFlagsListResponse() {
  var o = new api.FlagsListResponse();
  buildCounterFlagsListResponse++;
  if (buildCounterFlagsListResponse < 3) {
    o.items = buildUnnamed3191();
    o.kind = "foo";
  }
  buildCounterFlagsListResponse--;
  return o;
}

checkFlagsListResponse(api.FlagsListResponse o) {
  buildCounterFlagsListResponse++;
  if (buildCounterFlagsListResponse < 3) {
    checkUnnamed3191(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterFlagsListResponse--;
}

buildUnnamed3192() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3192(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterImportContext = 0;
buildImportContext() {
  var o = new api.ImportContext();
  buildCounterImportContext++;
  if (buildCounterImportContext < 3) {
    o.database = "foo";
    o.kind = "foo";
    o.uri = buildUnnamed3192();
  }
  buildCounterImportContext--;
  return o;
}

checkImportContext(api.ImportContext o) {
  buildCounterImportContext++;
  if (buildCounterImportContext < 3) {
    unittest.expect(o.database, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed3192(o.uri);
  }
  buildCounterImportContext--;
}

buildUnnamed3193() {
  var o = new core.List<api.OperationError>();
  o.add(buildOperationError());
  o.add(buildOperationError());
  return o;
}

checkUnnamed3193(core.List<api.OperationError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperationError(o[0]);
  checkOperationError(o[1]);
}

core.int buildCounterInstanceOperation = 0;
buildInstanceOperation() {
  var o = new api.InstanceOperation();
  buildCounterInstanceOperation++;
  if (buildCounterInstanceOperation < 3) {
    o.endTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.enqueuedTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.error = buildUnnamed3193();
    o.exportContext = buildExportContext();
    o.importContext = buildImportContext();
    o.instance = "foo";
    o.kind = "foo";
    o.operation = "foo";
    o.operationType = "foo";
    o.startTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.state = "foo";
    o.userEmailAddress = "foo";
  }
  buildCounterInstanceOperation--;
  return o;
}

checkInstanceOperation(api.InstanceOperation o) {
  buildCounterInstanceOperation++;
  if (buildCounterInstanceOperation < 3) {
    unittest.expect(
        o.endTime, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.enqueuedTime,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    checkUnnamed3193(o.error);
    checkExportContext(o.exportContext);
    checkImportContext(o.importContext);
    unittest.expect(o.instance, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
    unittest.expect(o.operationType, unittest.equals('foo'));
    unittest.expect(o.startTime,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.state, unittest.equals('foo'));
    unittest.expect(o.userEmailAddress, unittest.equals('foo'));
  }
  buildCounterInstanceOperation--;
}

core.int buildCounterInstanceSetRootPasswordRequest = 0;
buildInstanceSetRootPasswordRequest() {
  var o = new api.InstanceSetRootPasswordRequest();
  buildCounterInstanceSetRootPasswordRequest++;
  if (buildCounterInstanceSetRootPasswordRequest < 3) {
    o.setRootPasswordContext = buildSetRootPasswordContext();
  }
  buildCounterInstanceSetRootPasswordRequest--;
  return o;
}

checkInstanceSetRootPasswordRequest(api.InstanceSetRootPasswordRequest o) {
  buildCounterInstanceSetRootPasswordRequest++;
  if (buildCounterInstanceSetRootPasswordRequest < 3) {
    checkSetRootPasswordContext(o.setRootPasswordContext);
  }
  buildCounterInstanceSetRootPasswordRequest--;
}

core.int buildCounterInstancesCloneRequest = 0;
buildInstancesCloneRequest() {
  var o = new api.InstancesCloneRequest();
  buildCounterInstancesCloneRequest++;
  if (buildCounterInstancesCloneRequest < 3) {
    o.cloneContext = buildCloneContext();
  }
  buildCounterInstancesCloneRequest--;
  return o;
}

checkInstancesCloneRequest(api.InstancesCloneRequest o) {
  buildCounterInstancesCloneRequest++;
  if (buildCounterInstancesCloneRequest < 3) {
    checkCloneContext(o.cloneContext);
  }
  buildCounterInstancesCloneRequest--;
}

core.int buildCounterInstancesCloneResponse = 0;
buildInstancesCloneResponse() {
  var o = new api.InstancesCloneResponse();
  buildCounterInstancesCloneResponse++;
  if (buildCounterInstancesCloneResponse < 3) {
    o.kind = "foo";
    o.operation = "foo";
  }
  buildCounterInstancesCloneResponse--;
  return o;
}

checkInstancesCloneResponse(api.InstancesCloneResponse o) {
  buildCounterInstancesCloneResponse++;
  if (buildCounterInstancesCloneResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
  }
  buildCounterInstancesCloneResponse--;
}

core.int buildCounterInstancesDeleteResponse = 0;
buildInstancesDeleteResponse() {
  var o = new api.InstancesDeleteResponse();
  buildCounterInstancesDeleteResponse++;
  if (buildCounterInstancesDeleteResponse < 3) {
    o.kind = "foo";
    o.operation = "foo";
  }
  buildCounterInstancesDeleteResponse--;
  return o;
}

checkInstancesDeleteResponse(api.InstancesDeleteResponse o) {
  buildCounterInstancesDeleteResponse++;
  if (buildCounterInstancesDeleteResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
  }
  buildCounterInstancesDeleteResponse--;
}

core.int buildCounterInstancesExportRequest = 0;
buildInstancesExportRequest() {
  var o = new api.InstancesExportRequest();
  buildCounterInstancesExportRequest++;
  if (buildCounterInstancesExportRequest < 3) {
    o.exportContext = buildExportContext();
  }
  buildCounterInstancesExportRequest--;
  return o;
}

checkInstancesExportRequest(api.InstancesExportRequest o) {
  buildCounterInstancesExportRequest++;
  if (buildCounterInstancesExportRequest < 3) {
    checkExportContext(o.exportContext);
  }
  buildCounterInstancesExportRequest--;
}

core.int buildCounterInstancesExportResponse = 0;
buildInstancesExportResponse() {
  var o = new api.InstancesExportResponse();
  buildCounterInstancesExportResponse++;
  if (buildCounterInstancesExportResponse < 3) {
    o.kind = "foo";
    o.operation = "foo";
  }
  buildCounterInstancesExportResponse--;
  return o;
}

checkInstancesExportResponse(api.InstancesExportResponse o) {
  buildCounterInstancesExportResponse++;
  if (buildCounterInstancesExportResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
  }
  buildCounterInstancesExportResponse--;
}

core.int buildCounterInstancesImportRequest = 0;
buildInstancesImportRequest() {
  var o = new api.InstancesImportRequest();
  buildCounterInstancesImportRequest++;
  if (buildCounterInstancesImportRequest < 3) {
    o.importContext = buildImportContext();
  }
  buildCounterInstancesImportRequest--;
  return o;
}

checkInstancesImportRequest(api.InstancesImportRequest o) {
  buildCounterInstancesImportRequest++;
  if (buildCounterInstancesImportRequest < 3) {
    checkImportContext(o.importContext);
  }
  buildCounterInstancesImportRequest--;
}

core.int buildCounterInstancesImportResponse = 0;
buildInstancesImportResponse() {
  var o = new api.InstancesImportResponse();
  buildCounterInstancesImportResponse++;
  if (buildCounterInstancesImportResponse < 3) {
    o.kind = "foo";
    o.operation = "foo";
  }
  buildCounterInstancesImportResponse--;
  return o;
}

checkInstancesImportResponse(api.InstancesImportResponse o) {
  buildCounterInstancesImportResponse++;
  if (buildCounterInstancesImportResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
  }
  buildCounterInstancesImportResponse--;
}

core.int buildCounterInstancesInsertResponse = 0;
buildInstancesInsertResponse() {
  var o = new api.InstancesInsertResponse();
  buildCounterInstancesInsertResponse++;
  if (buildCounterInstancesInsertResponse < 3) {
    o.kind = "foo";
    o.operation = "foo";
  }
  buildCounterInstancesInsertResponse--;
  return o;
}

checkInstancesInsertResponse(api.InstancesInsertResponse o) {
  buildCounterInstancesInsertResponse++;
  if (buildCounterInstancesInsertResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
  }
  buildCounterInstancesInsertResponse--;
}

buildUnnamed3194() {
  var o = new core.List<api.DatabaseInstance>();
  o.add(buildDatabaseInstance());
  o.add(buildDatabaseInstance());
  return o;
}

checkUnnamed3194(core.List<api.DatabaseInstance> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatabaseInstance(o[0]);
  checkDatabaseInstance(o[1]);
}

core.int buildCounterInstancesListResponse = 0;
buildInstancesListResponse() {
  var o = new api.InstancesListResponse();
  buildCounterInstancesListResponse++;
  if (buildCounterInstancesListResponse < 3) {
    o.items = buildUnnamed3194();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterInstancesListResponse--;
  return o;
}

checkInstancesListResponse(api.InstancesListResponse o) {
  buildCounterInstancesListResponse++;
  if (buildCounterInstancesListResponse < 3) {
    checkUnnamed3194(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterInstancesListResponse--;
}

core.int buildCounterInstancesPromoteReplicaResponse = 0;
buildInstancesPromoteReplicaResponse() {
  var o = new api.InstancesPromoteReplicaResponse();
  buildCounterInstancesPromoteReplicaResponse++;
  if (buildCounterInstancesPromoteReplicaResponse < 3) {
    o.kind = "foo";
    o.operation = "foo";
  }
  buildCounterInstancesPromoteReplicaResponse--;
  return o;
}

checkInstancesPromoteReplicaResponse(api.InstancesPromoteReplicaResponse o) {
  buildCounterInstancesPromoteReplicaResponse++;
  if (buildCounterInstancesPromoteReplicaResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
  }
  buildCounterInstancesPromoteReplicaResponse--;
}

core.int buildCounterInstancesResetSslConfigResponse = 0;
buildInstancesResetSslConfigResponse() {
  var o = new api.InstancesResetSslConfigResponse();
  buildCounterInstancesResetSslConfigResponse++;
  if (buildCounterInstancesResetSslConfigResponse < 3) {
    o.kind = "foo";
    o.operation = "foo";
  }
  buildCounterInstancesResetSslConfigResponse--;
  return o;
}

checkInstancesResetSslConfigResponse(api.InstancesResetSslConfigResponse o) {
  buildCounterInstancesResetSslConfigResponse++;
  if (buildCounterInstancesResetSslConfigResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
  }
  buildCounterInstancesResetSslConfigResponse--;
}

core.int buildCounterInstancesRestartResponse = 0;
buildInstancesRestartResponse() {
  var o = new api.InstancesRestartResponse();
  buildCounterInstancesRestartResponse++;
  if (buildCounterInstancesRestartResponse < 3) {
    o.kind = "foo";
    o.operation = "foo";
  }
  buildCounterInstancesRestartResponse--;
  return o;
}

checkInstancesRestartResponse(api.InstancesRestartResponse o) {
  buildCounterInstancesRestartResponse++;
  if (buildCounterInstancesRestartResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
  }
  buildCounterInstancesRestartResponse--;
}

core.int buildCounterInstancesRestoreBackupResponse = 0;
buildInstancesRestoreBackupResponse() {
  var o = new api.InstancesRestoreBackupResponse();
  buildCounterInstancesRestoreBackupResponse++;
  if (buildCounterInstancesRestoreBackupResponse < 3) {
    o.kind = "foo";
    o.operation = "foo";
  }
  buildCounterInstancesRestoreBackupResponse--;
  return o;
}

checkInstancesRestoreBackupResponse(api.InstancesRestoreBackupResponse o) {
  buildCounterInstancesRestoreBackupResponse++;
  if (buildCounterInstancesRestoreBackupResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
  }
  buildCounterInstancesRestoreBackupResponse--;
}

core.int buildCounterInstancesSetRootPasswordResponse = 0;
buildInstancesSetRootPasswordResponse() {
  var o = new api.InstancesSetRootPasswordResponse();
  buildCounterInstancesSetRootPasswordResponse++;
  if (buildCounterInstancesSetRootPasswordResponse < 3) {
    o.kind = "foo";
    o.operation = "foo";
  }
  buildCounterInstancesSetRootPasswordResponse--;
  return o;
}

checkInstancesSetRootPasswordResponse(api.InstancesSetRootPasswordResponse o) {
  buildCounterInstancesSetRootPasswordResponse++;
  if (buildCounterInstancesSetRootPasswordResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
  }
  buildCounterInstancesSetRootPasswordResponse--;
}

core.int buildCounterInstancesUpdateResponse = 0;
buildInstancesUpdateResponse() {
  var o = new api.InstancesUpdateResponse();
  buildCounterInstancesUpdateResponse++;
  if (buildCounterInstancesUpdateResponse < 3) {
    o.kind = "foo";
    o.operation = "foo";
  }
  buildCounterInstancesUpdateResponse--;
  return o;
}

checkInstancesUpdateResponse(api.InstancesUpdateResponse o) {
  buildCounterInstancesUpdateResponse++;
  if (buildCounterInstancesUpdateResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
  }
  buildCounterInstancesUpdateResponse--;
}

buildUnnamed3195() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3195(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterIpConfiguration = 0;
buildIpConfiguration() {
  var o = new api.IpConfiguration();
  buildCounterIpConfiguration++;
  if (buildCounterIpConfiguration < 3) {
    o.authorizedNetworks = buildUnnamed3195();
    o.enabled = true;
    o.kind = "foo";
    o.requireSsl = true;
  }
  buildCounterIpConfiguration--;
  return o;
}

checkIpConfiguration(api.IpConfiguration o) {
  buildCounterIpConfiguration++;
  if (buildCounterIpConfiguration < 3) {
    checkUnnamed3195(o.authorizedNetworks);
    unittest.expect(o.enabled, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.requireSsl, unittest.isTrue);
  }
  buildCounterIpConfiguration--;
}

core.int buildCounterIpMapping = 0;
buildIpMapping() {
  var o = new api.IpMapping();
  buildCounterIpMapping++;
  if (buildCounterIpMapping < 3) {
    o.ipAddress = "foo";
    o.timeToRetire = core.DateTime.parse("2002-02-27T14:01:02");
  }
  buildCounterIpMapping--;
  return o;
}

checkIpMapping(api.IpMapping o) {
  buildCounterIpMapping++;
  if (buildCounterIpMapping < 3) {
    unittest.expect(o.ipAddress, unittest.equals('foo'));
    unittest.expect(o.timeToRetire,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
  }
  buildCounterIpMapping--;
}

core.int buildCounterLocationPreference = 0;
buildLocationPreference() {
  var o = new api.LocationPreference();
  buildCounterLocationPreference++;
  if (buildCounterLocationPreference < 3) {
    o.followGaeApplication = "foo";
    o.kind = "foo";
    o.zone = "foo";
  }
  buildCounterLocationPreference--;
  return o;
}

checkLocationPreference(api.LocationPreference o) {
  buildCounterLocationPreference++;
  if (buildCounterLocationPreference < 3) {
    unittest.expect(o.followGaeApplication, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.zone, unittest.equals('foo'));
  }
  buildCounterLocationPreference--;
}

core.int buildCounterOperationError = 0;
buildOperationError() {
  var o = new api.OperationError();
  buildCounterOperationError++;
  if (buildCounterOperationError < 3) {
    o.code = "foo";
    o.kind = "foo";
  }
  buildCounterOperationError--;
  return o;
}

checkOperationError(api.OperationError o) {
  buildCounterOperationError++;
  if (buildCounterOperationError < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOperationError--;
}

buildUnnamed3196() {
  var o = new core.List<api.InstanceOperation>();
  o.add(buildInstanceOperation());
  o.add(buildInstanceOperation());
  return o;
}

checkUnnamed3196(core.List<api.InstanceOperation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkInstanceOperation(o[0]);
  checkInstanceOperation(o[1]);
}

core.int buildCounterOperationsListResponse = 0;
buildOperationsListResponse() {
  var o = new api.OperationsListResponse();
  buildCounterOperationsListResponse++;
  if (buildCounterOperationsListResponse < 3) {
    o.items = buildUnnamed3196();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterOperationsListResponse--;
  return o;
}

checkOperationsListResponse(api.OperationsListResponse o) {
  buildCounterOperationsListResponse++;
  if (buildCounterOperationsListResponse < 3) {
    checkUnnamed3196(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterOperationsListResponse--;
}

core.int buildCounterSetRootPasswordContext = 0;
buildSetRootPasswordContext() {
  var o = new api.SetRootPasswordContext();
  buildCounterSetRootPasswordContext++;
  if (buildCounterSetRootPasswordContext < 3) {
    o.kind = "foo";
    o.password = "foo";
  }
  buildCounterSetRootPasswordContext--;
  return o;
}

checkSetRootPasswordContext(api.SetRootPasswordContext o) {
  buildCounterSetRootPasswordContext++;
  if (buildCounterSetRootPasswordContext < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.password, unittest.equals('foo'));
  }
  buildCounterSetRootPasswordContext--;
}

buildUnnamed3197() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3197(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3198() {
  var o = new core.List<api.BackupConfiguration>();
  o.add(buildBackupConfiguration());
  o.add(buildBackupConfiguration());
  return o;
}

checkUnnamed3198(core.List<api.BackupConfiguration> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBackupConfiguration(o[0]);
  checkBackupConfiguration(o[1]);
}

buildUnnamed3199() {
  var o = new core.List<api.DatabaseFlags>();
  o.add(buildDatabaseFlags());
  o.add(buildDatabaseFlags());
  return o;
}

checkUnnamed3199(core.List<api.DatabaseFlags> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatabaseFlags(o[0]);
  checkDatabaseFlags(o[1]);
}

core.int buildCounterSettings = 0;
buildSettings() {
  var o = new api.Settings();
  buildCounterSettings++;
  if (buildCounterSettings < 3) {
    o.activationPolicy = "foo";
    o.authorizedGaeApplications = buildUnnamed3197();
    o.backupConfiguration = buildUnnamed3198();
    o.databaseFlags = buildUnnamed3199();
    o.databaseReplicationEnabled = true;
    o.ipConfiguration = buildIpConfiguration();
    o.kind = "foo";
    o.locationPreference = buildLocationPreference();
    o.pricingPlan = "foo";
    o.replicationType = "foo";
    o.settingsVersion = "foo";
    o.tier = "foo";
  }
  buildCounterSettings--;
  return o;
}

checkSettings(api.Settings o) {
  buildCounterSettings++;
  if (buildCounterSettings < 3) {
    unittest.expect(o.activationPolicy, unittest.equals('foo'));
    checkUnnamed3197(o.authorizedGaeApplications);
    checkUnnamed3198(o.backupConfiguration);
    checkUnnamed3199(o.databaseFlags);
    unittest.expect(o.databaseReplicationEnabled, unittest.isTrue);
    checkIpConfiguration(o.ipConfiguration);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkLocationPreference(o.locationPreference);
    unittest.expect(o.pricingPlan, unittest.equals('foo'));
    unittest.expect(o.replicationType, unittest.equals('foo'));
    unittest.expect(o.settingsVersion, unittest.equals('foo'));
    unittest.expect(o.tier, unittest.equals('foo'));
  }
  buildCounterSettings--;
}

core.int buildCounterSslCert = 0;
buildSslCert() {
  var o = new api.SslCert();
  buildCounterSslCert++;
  if (buildCounterSslCert < 3) {
    o.cert = "foo";
    o.certSerialNumber = "foo";
    o.commonName = "foo";
    o.createTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.expirationTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.instance = "foo";
    o.kind = "foo";
    o.sha1Fingerprint = "foo";
  }
  buildCounterSslCert--;
  return o;
}

checkSslCert(api.SslCert o) {
  buildCounterSslCert++;
  if (buildCounterSslCert < 3) {
    unittest.expect(o.cert, unittest.equals('foo'));
    unittest.expect(o.certSerialNumber, unittest.equals('foo'));
    unittest.expect(o.commonName, unittest.equals('foo'));
    unittest.expect(o.createTime,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.expirationTime,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.instance, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.sha1Fingerprint, unittest.equals('foo'));
  }
  buildCounterSslCert--;
}

core.int buildCounterSslCertDetail = 0;
buildSslCertDetail() {
  var o = new api.SslCertDetail();
  buildCounterSslCertDetail++;
  if (buildCounterSslCertDetail < 3) {
    o.certInfo = buildSslCert();
    o.certPrivateKey = "foo";
  }
  buildCounterSslCertDetail--;
  return o;
}

checkSslCertDetail(api.SslCertDetail o) {
  buildCounterSslCertDetail++;
  if (buildCounterSslCertDetail < 3) {
    checkSslCert(o.certInfo);
    unittest.expect(o.certPrivateKey, unittest.equals('foo'));
  }
  buildCounterSslCertDetail--;
}

core.int buildCounterSslCertsDeleteResponse = 0;
buildSslCertsDeleteResponse() {
  var o = new api.SslCertsDeleteResponse();
  buildCounterSslCertsDeleteResponse++;
  if (buildCounterSslCertsDeleteResponse < 3) {
    o.kind = "foo";
    o.operation = "foo";
  }
  buildCounterSslCertsDeleteResponse--;
  return o;
}

checkSslCertsDeleteResponse(api.SslCertsDeleteResponse o) {
  buildCounterSslCertsDeleteResponse++;
  if (buildCounterSslCertsDeleteResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.operation, unittest.equals('foo'));
  }
  buildCounterSslCertsDeleteResponse--;
}

core.int buildCounterSslCertsInsertRequest = 0;
buildSslCertsInsertRequest() {
  var o = new api.SslCertsInsertRequest();
  buildCounterSslCertsInsertRequest++;
  if (buildCounterSslCertsInsertRequest < 3) {
    o.commonName = "foo";
  }
  buildCounterSslCertsInsertRequest--;
  return o;
}

checkSslCertsInsertRequest(api.SslCertsInsertRequest o) {
  buildCounterSslCertsInsertRequest++;
  if (buildCounterSslCertsInsertRequest < 3) {
    unittest.expect(o.commonName, unittest.equals('foo'));
  }
  buildCounterSslCertsInsertRequest--;
}

core.int buildCounterSslCertsInsertResponse = 0;
buildSslCertsInsertResponse() {
  var o = new api.SslCertsInsertResponse();
  buildCounterSslCertsInsertResponse++;
  if (buildCounterSslCertsInsertResponse < 3) {
    o.clientCert = buildSslCertDetail();
    o.kind = "foo";
    o.serverCaCert = buildSslCert();
  }
  buildCounterSslCertsInsertResponse--;
  return o;
}

checkSslCertsInsertResponse(api.SslCertsInsertResponse o) {
  buildCounterSslCertsInsertResponse++;
  if (buildCounterSslCertsInsertResponse < 3) {
    checkSslCertDetail(o.clientCert);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkSslCert(o.serverCaCert);
  }
  buildCounterSslCertsInsertResponse--;
}

buildUnnamed3200() {
  var o = new core.List<api.SslCert>();
  o.add(buildSslCert());
  o.add(buildSslCert());
  return o;
}

checkUnnamed3200(core.List<api.SslCert> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSslCert(o[0]);
  checkSslCert(o[1]);
}

core.int buildCounterSslCertsListResponse = 0;
buildSslCertsListResponse() {
  var o = new api.SslCertsListResponse();
  buildCounterSslCertsListResponse++;
  if (buildCounterSslCertsListResponse < 3) {
    o.items = buildUnnamed3200();
    o.kind = "foo";
  }
  buildCounterSslCertsListResponse--;
  return o;
}

checkSslCertsListResponse(api.SslCertsListResponse o) {
  buildCounterSslCertsListResponse++;
  if (buildCounterSslCertsListResponse < 3) {
    checkUnnamed3200(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterSslCertsListResponse--;
}

buildUnnamed3201() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3201(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterTier = 0;
buildTier() {
  var o = new api.Tier();
  buildCounterTier++;
  if (buildCounterTier < 3) {
    o.DiskQuota = "foo";
    o.RAM = "foo";
    o.kind = "foo";
    o.region = buildUnnamed3201();
    o.tier = "foo";
  }
  buildCounterTier--;
  return o;
}

checkTier(api.Tier o) {
  buildCounterTier++;
  if (buildCounterTier < 3) {
    unittest.expect(o.DiskQuota, unittest.equals('foo'));
    unittest.expect(o.RAM, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed3201(o.region);
    unittest.expect(o.tier, unittest.equals('foo'));
  }
  buildCounterTier--;
}

buildUnnamed3202() {
  var o = new core.List<api.Tier>();
  o.add(buildTier());
  o.add(buildTier());
  return o;
}

checkUnnamed3202(core.List<api.Tier> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTier(o[0]);
  checkTier(o[1]);
}

core.int buildCounterTiersListResponse = 0;
buildTiersListResponse() {
  var o = new api.TiersListResponse();
  buildCounterTiersListResponse++;
  if (buildCounterTiersListResponse < 3) {
    o.items = buildUnnamed3202();
    o.kind = "foo";
  }
  buildCounterTiersListResponse--;
  return o;
}

checkTiersListResponse(api.TiersListResponse o) {
  buildCounterTiersListResponse++;
  if (buildCounterTiersListResponse < 3) {
    checkUnnamed3202(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterTiersListResponse--;
}

main() {
  unittest.group("obj-schema-BackupConfiguration", () {
    unittest.test("to-json--from-json", () {
      var o = buildBackupConfiguration();
      var od = new api.BackupConfiguration.fromJson(o.toJson());
      checkBackupConfiguration(od);
    });
  });

  unittest.group("obj-schema-BackupRun", () {
    unittest.test("to-json--from-json", () {
      var o = buildBackupRun();
      var od = new api.BackupRun.fromJson(o.toJson());
      checkBackupRun(od);
    });
  });

  unittest.group("obj-schema-BackupRunsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildBackupRunsListResponse();
      var od = new api.BackupRunsListResponse.fromJson(o.toJson());
      checkBackupRunsListResponse(od);
    });
  });

  unittest.group("obj-schema-BinLogCoordinates", () {
    unittest.test("to-json--from-json", () {
      var o = buildBinLogCoordinates();
      var od = new api.BinLogCoordinates.fromJson(o.toJson());
      checkBinLogCoordinates(od);
    });
  });

  unittest.group("obj-schema-CloneContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildCloneContext();
      var od = new api.CloneContext.fromJson(o.toJson());
      checkCloneContext(od);
    });
  });

  unittest.group("obj-schema-DatabaseFlags", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatabaseFlags();
      var od = new api.DatabaseFlags.fromJson(o.toJson());
      checkDatabaseFlags(od);
    });
  });

  unittest.group("obj-schema-DatabaseInstance", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatabaseInstance();
      var od = new api.DatabaseInstance.fromJson(o.toJson());
      checkDatabaseInstance(od);
    });
  });

  unittest.group("obj-schema-ExportContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildExportContext();
      var od = new api.ExportContext.fromJson(o.toJson());
      checkExportContext(od);
    });
  });

  unittest.group("obj-schema-Flag", () {
    unittest.test("to-json--from-json", () {
      var o = buildFlag();
      var od = new api.Flag.fromJson(o.toJson());
      checkFlag(od);
    });
  });

  unittest.group("obj-schema-FlagsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildFlagsListResponse();
      var od = new api.FlagsListResponse.fromJson(o.toJson());
      checkFlagsListResponse(od);
    });
  });

  unittest.group("obj-schema-ImportContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildImportContext();
      var od = new api.ImportContext.fromJson(o.toJson());
      checkImportContext(od);
    });
  });

  unittest.group("obj-schema-InstanceOperation", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceOperation();
      var od = new api.InstanceOperation.fromJson(o.toJson());
      checkInstanceOperation(od);
    });
  });

  unittest.group("obj-schema-InstanceSetRootPasswordRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceSetRootPasswordRequest();
      var od = new api.InstanceSetRootPasswordRequest.fromJson(o.toJson());
      checkInstanceSetRootPasswordRequest(od);
    });
  });

  unittest.group("obj-schema-InstancesCloneRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesCloneRequest();
      var od = new api.InstancesCloneRequest.fromJson(o.toJson());
      checkInstancesCloneRequest(od);
    });
  });

  unittest.group("obj-schema-InstancesCloneResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesCloneResponse();
      var od = new api.InstancesCloneResponse.fromJson(o.toJson());
      checkInstancesCloneResponse(od);
    });
  });

  unittest.group("obj-schema-InstancesDeleteResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesDeleteResponse();
      var od = new api.InstancesDeleteResponse.fromJson(o.toJson());
      checkInstancesDeleteResponse(od);
    });
  });

  unittest.group("obj-schema-InstancesExportRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesExportRequest();
      var od = new api.InstancesExportRequest.fromJson(o.toJson());
      checkInstancesExportRequest(od);
    });
  });

  unittest.group("obj-schema-InstancesExportResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesExportResponse();
      var od = new api.InstancesExportResponse.fromJson(o.toJson());
      checkInstancesExportResponse(od);
    });
  });

  unittest.group("obj-schema-InstancesImportRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesImportRequest();
      var od = new api.InstancesImportRequest.fromJson(o.toJson());
      checkInstancesImportRequest(od);
    });
  });

  unittest.group("obj-schema-InstancesImportResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesImportResponse();
      var od = new api.InstancesImportResponse.fromJson(o.toJson());
      checkInstancesImportResponse(od);
    });
  });

  unittest.group("obj-schema-InstancesInsertResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesInsertResponse();
      var od = new api.InstancesInsertResponse.fromJson(o.toJson());
      checkInstancesInsertResponse(od);
    });
  });

  unittest.group("obj-schema-InstancesListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesListResponse();
      var od = new api.InstancesListResponse.fromJson(o.toJson());
      checkInstancesListResponse(od);
    });
  });

  unittest.group("obj-schema-InstancesPromoteReplicaResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesPromoteReplicaResponse();
      var od = new api.InstancesPromoteReplicaResponse.fromJson(o.toJson());
      checkInstancesPromoteReplicaResponse(od);
    });
  });

  unittest.group("obj-schema-InstancesResetSslConfigResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesResetSslConfigResponse();
      var od = new api.InstancesResetSslConfigResponse.fromJson(o.toJson());
      checkInstancesResetSslConfigResponse(od);
    });
  });

  unittest.group("obj-schema-InstancesRestartResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesRestartResponse();
      var od = new api.InstancesRestartResponse.fromJson(o.toJson());
      checkInstancesRestartResponse(od);
    });
  });

  unittest.group("obj-schema-InstancesRestoreBackupResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesRestoreBackupResponse();
      var od = new api.InstancesRestoreBackupResponse.fromJson(o.toJson());
      checkInstancesRestoreBackupResponse(od);
    });
  });

  unittest.group("obj-schema-InstancesSetRootPasswordResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesSetRootPasswordResponse();
      var od = new api.InstancesSetRootPasswordResponse.fromJson(o.toJson());
      checkInstancesSetRootPasswordResponse(od);
    });
  });

  unittest.group("obj-schema-InstancesUpdateResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesUpdateResponse();
      var od = new api.InstancesUpdateResponse.fromJson(o.toJson());
      checkInstancesUpdateResponse(od);
    });
  });

  unittest.group("obj-schema-IpConfiguration", () {
    unittest.test("to-json--from-json", () {
      var o = buildIpConfiguration();
      var od = new api.IpConfiguration.fromJson(o.toJson());
      checkIpConfiguration(od);
    });
  });

  unittest.group("obj-schema-IpMapping", () {
    unittest.test("to-json--from-json", () {
      var o = buildIpMapping();
      var od = new api.IpMapping.fromJson(o.toJson());
      checkIpMapping(od);
    });
  });

  unittest.group("obj-schema-LocationPreference", () {
    unittest.test("to-json--from-json", () {
      var o = buildLocationPreference();
      var od = new api.LocationPreference.fromJson(o.toJson());
      checkLocationPreference(od);
    });
  });

  unittest.group("obj-schema-OperationError", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationError();
      var od = new api.OperationError.fromJson(o.toJson());
      checkOperationError(od);
    });
  });

  unittest.group("obj-schema-OperationsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationsListResponse();
      var od = new api.OperationsListResponse.fromJson(o.toJson());
      checkOperationsListResponse(od);
    });
  });

  unittest.group("obj-schema-SetRootPasswordContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildSetRootPasswordContext();
      var od = new api.SetRootPasswordContext.fromJson(o.toJson());
      checkSetRootPasswordContext(od);
    });
  });

  unittest.group("obj-schema-Settings", () {
    unittest.test("to-json--from-json", () {
      var o = buildSettings();
      var od = new api.Settings.fromJson(o.toJson());
      checkSettings(od);
    });
  });

  unittest.group("obj-schema-SslCert", () {
    unittest.test("to-json--from-json", () {
      var o = buildSslCert();
      var od = new api.SslCert.fromJson(o.toJson());
      checkSslCert(od);
    });
  });

  unittest.group("obj-schema-SslCertDetail", () {
    unittest.test("to-json--from-json", () {
      var o = buildSslCertDetail();
      var od = new api.SslCertDetail.fromJson(o.toJson());
      checkSslCertDetail(od);
    });
  });

  unittest.group("obj-schema-SslCertsDeleteResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSslCertsDeleteResponse();
      var od = new api.SslCertsDeleteResponse.fromJson(o.toJson());
      checkSslCertsDeleteResponse(od);
    });
  });

  unittest.group("obj-schema-SslCertsInsertRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildSslCertsInsertRequest();
      var od = new api.SslCertsInsertRequest.fromJson(o.toJson());
      checkSslCertsInsertRequest(od);
    });
  });

  unittest.group("obj-schema-SslCertsInsertResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSslCertsInsertResponse();
      var od = new api.SslCertsInsertResponse.fromJson(o.toJson());
      checkSslCertsInsertResponse(od);
    });
  });

  unittest.group("obj-schema-SslCertsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSslCertsListResponse();
      var od = new api.SslCertsListResponse.fromJson(o.toJson());
      checkSslCertsListResponse(od);
    });
  });

  unittest.group("obj-schema-Tier", () {
    unittest.test("to-json--from-json", () {
      var o = buildTier();
      var od = new api.Tier.fromJson(o.toJson());
      checkTier(od);
    });
  });

  unittest.group("obj-schema-TiersListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildTiersListResponse();
      var od = new api.TiersListResponse.fromJson(o.toJson());
      checkTiersListResponse(od);
    });
  });

  unittest.group("resource-BackupRunsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.BackupRunsResourceApi res = new api.SqladminApi(mock).backupRuns;
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_backupConfiguration = "foo";
      var arg_dueTime = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/backupRuns/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/backupRuns/"));
        pathOffset += 12;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_backupConfiguration"));

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
            queryMap["dueTime"].first, unittest.equals(arg_dueTime));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBackupRun());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_instance, arg_backupConfiguration, arg_dueTime)
          .then(unittest.expectAsync1(((api.BackupRun response) {
        checkBackupRun(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.BackupRunsResourceApi res = new api.SqladminApi(mock).backupRuns;
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_backupConfiguration = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/backupRuns", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/backupRuns"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["backupConfiguration"].first,
            unittest.equals(arg_backupConfiguration));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBackupRunsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_instance, arg_backupConfiguration,
              maxResults: arg_maxResults, pageToken: arg_pageToken)
          .then(unittest.expectAsync1(((api.BackupRunsListResponse response) {
        checkBackupRunsListResponse(response);
      })));
    });
  });

  unittest.group("resource-FlagsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.FlagsResourceApi res = new api.SqladminApi(mock).flags;
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 5),
            unittest.equals("flags"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildFlagsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list().then(unittest.expectAsync1(((api.FlagsListResponse response) {
        checkFlagsListResponse(response);
      })));
    });
  });

  unittest.group("resource-InstancesResourceApi", () {
    unittest.test("method--clone", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_request = buildInstancesCloneRequest();
      var arg_project = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.InstancesCloneRequest.fromJson(json);
        checkInstancesCloneRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/clone", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 16),
            unittest.equals("/instances/clone"));
        pathOffset += 16;

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
        var resp = convert.JSON.encode(buildInstancesCloneResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .clone(arg_request, arg_project)
          .then(unittest.expectAsync1(((api.InstancesCloneResponse response) {
        checkInstancesCloneResponse(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_instance"));

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
        var resp = convert.JSON.encode(buildInstancesDeleteResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.InstancesDeleteResponse response) {
        checkInstancesDeleteResponse(response);
      })));
    });

    unittest.test("method--export", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_request = buildInstancesExportRequest();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.InstancesExportRequest.fromJson(json);
        checkInstancesExportRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/export", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7),
            unittest.equals("/export"));
        pathOffset += 7;

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
        var resp = convert.JSON.encode(buildInstancesExportResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .export(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.InstancesExportResponse response) {
        checkInstancesExportResponse(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_instance"));

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
        var resp = convert.JSON.encode(buildDatabaseInstance());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.DatabaseInstance response) {
        checkDatabaseInstance(response);
      })));
    });

    unittest.test("method--import", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_request = buildInstancesImportRequest();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.InstancesImportRequest.fromJson(json);
        checkInstancesImportRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/import", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7),
            unittest.equals("/import"));
        pathOffset += 7;

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
        var resp = convert.JSON.encode(buildInstancesImportResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .import(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.InstancesImportResponse response) {
        checkInstancesImportResponse(response);
      })));
    });

    unittest.test("method--insert", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_request = buildDatabaseInstance();
      var arg_project = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.DatabaseInstance.fromJson(json);
        checkDatabaseInstance(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("/instances"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildInstancesInsertResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .insert(arg_request, arg_project)
          .then(unittest.expectAsync1(((api.InstancesInsertResponse response) {
        checkInstancesInsertResponse(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_project = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("/instances"));
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
        var resp = convert.JSON.encode(buildInstancesListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project,
              maxResults: arg_maxResults, pageToken: arg_pageToken)
          .then(unittest.expectAsync1(((api.InstancesListResponse response) {
        checkInstancesListResponse(response);
      })));
    });

    unittest.test("method--patch", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_request = buildDatabaseInstance();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.DatabaseInstance.fromJson(json);
        checkDatabaseInstance(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_instance"));

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
        var resp = convert.JSON.encode(buildInstancesUpdateResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .patch(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.InstancesUpdateResponse response) {
        checkInstancesUpdateResponse(response);
      })));
    });

    unittest.test("method--promoteReplica", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/promoteReplica", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15),
            unittest.equals("/promoteReplica"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildInstancesPromoteReplicaResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.promoteReplica(arg_project, arg_instance).then(unittest
          .expectAsync1(((api.InstancesPromoteReplicaResponse response) {
        checkInstancesPromoteReplicaResponse(response);
      })));
    });

    unittest.test("method--resetSslConfig", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/resetSslConfig", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15),
            unittest.equals("/resetSslConfig"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildInstancesResetSslConfigResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.resetSslConfig(arg_project, arg_instance).then(unittest
          .expectAsync1(((api.InstancesResetSslConfigResponse response) {
        checkInstancesResetSslConfigResponse(response);
      })));
    });

    unittest.test("method--restart", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/restart", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("/restart"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildInstancesRestartResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .restart(arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.InstancesRestartResponse response) {
        checkInstancesRestartResponse(response);
      })));
    });

    unittest.test("method--restoreBackup", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_backupConfiguration = "foo";
      var arg_dueTime = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/restoreBackup", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 14),
            unittest.equals("/restoreBackup"));
        pathOffset += 14;

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
        unittest.expect(queryMap["backupConfiguration"].first,
            unittest.equals(arg_backupConfiguration));
        unittest.expect(
            queryMap["dueTime"].first, unittest.equals(arg_dueTime));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildInstancesRestoreBackupResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .restoreBackup(
              arg_project, arg_instance, arg_backupConfiguration, arg_dueTime)
          .then(unittest
              .expectAsync1(((api.InstancesRestoreBackupResponse response) {
        checkInstancesRestoreBackupResponse(response);
      })));
    });

    unittest.test("method--setRootPassword", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_request = buildInstanceSetRootPasswordRequest();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.InstanceSetRootPasswordRequest.fromJson(json);
        checkInstanceSetRootPasswordRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/setRootPassword", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 16),
            unittest.equals("/setRootPassword"));
        pathOffset += 16;

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
        var resp = convert.JSON.encode(buildInstancesSetRootPasswordResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.setRootPassword(arg_request, arg_project, arg_instance).then(unittest
          .expectAsync1(((api.InstancesSetRootPasswordResponse response) {
        checkInstancesSetRootPasswordResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_request = buildDatabaseInstance();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.DatabaseInstance.fromJson(json);
        checkDatabaseInstance(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_instance"));

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
        var resp = convert.JSON.encode(buildInstancesUpdateResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.InstancesUpdateResponse response) {
        checkInstancesUpdateResponse(response);
      })));
    });
  });

  unittest.group("resource-OperationsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.OperationsResourceApi res = new api.SqladminApi(mock).operations;
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_operation = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/operations/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/operations/"));
        pathOffset += 12;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_operation"));

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
        var resp = convert.JSON.encode(buildInstanceOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_instance, arg_operation)
          .then(unittest.expectAsync1(((api.InstanceOperation response) {
        checkInstanceOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.OperationsResourceApi res = new api.SqladminApi(mock).operations;
      var arg_project = "foo";
      var arg_instance = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/operations", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/operations"));
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
        var resp = convert.JSON.encode(buildOperationsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_instance,
              maxResults: arg_maxResults, pageToken: arg_pageToken)
          .then(unittest.expectAsync1(((api.OperationsListResponse response) {
        checkOperationsListResponse(response);
      })));
    });
  });

  unittest.group("resource-SslCertsResourceApi", () {
    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.SslCertsResourceApi res = new api.SqladminApi(mock).sslCerts;
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_sha1Fingerprint = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/sslCerts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("/sslCerts/"));
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_sha1Fingerprint"));

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
        var resp = convert.JSON.encode(buildSslCertsDeleteResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_project, arg_instance, arg_sha1Fingerprint)
          .then(unittest.expectAsync1(((api.SslCertsDeleteResponse response) {
        checkSslCertsDeleteResponse(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.SslCertsResourceApi res = new api.SqladminApi(mock).sslCerts;
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_sha1Fingerprint = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/sslCerts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("/sslCerts/"));
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_sha1Fingerprint"));

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
        var resp = convert.JSON.encode(buildSslCert());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_instance, arg_sha1Fingerprint)
          .then(unittest.expectAsync1(((api.SslCert response) {
        checkSslCert(response);
      })));
    });

    unittest.test("method--insert", () {
      var mock = new HttpServerMock();
      api.SslCertsResourceApi res = new api.SqladminApi(mock).sslCerts;
      var arg_request = buildSslCertsInsertRequest();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.SslCertsInsertRequest.fromJson(json);
        checkSslCertsInsertRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/sslCerts", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/sslCerts"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSslCertsInsertResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .insert(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.SslCertsInsertResponse response) {
        checkSslCertsInsertResponse(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.SslCertsResourceApi res = new api.SqladminApi(mock).sslCerts;
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/instances/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/instances/"));
        pathOffset += 11;
        index = path.indexOf("/sslCerts", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/sslCerts"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSslCertsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.SslCertsListResponse response) {
        checkSslCertsListResponse(response);
      })));
    });
  });

  unittest.group("resource-TiersResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.TiersResourceApi res = new api.SqladminApi(mock).tiers;
      var arg_project = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/tiers", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6),
            unittest.equals("/tiers"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTiersListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project)
          .then(unittest.expectAsync1(((api.TiersListResponse response) {
        checkTiersListResponse(response);
      })));
    });
  });
}
