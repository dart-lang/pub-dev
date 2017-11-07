library googleapis_beta.sqladmin.v1beta4.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis_beta/sqladmin/v1beta4.dart' as api;

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

core.int buildCounterAclEntry = 0;
buildAclEntry() {
  var o = new api.AclEntry();
  buildCounterAclEntry++;
  if (buildCounterAclEntry < 3) {
    o.expirationTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.kind = "foo";
    o.name = "foo";
    o.value = "foo";
  }
  buildCounterAclEntry--;
  return o;
}

checkAclEntry(api.AclEntry o) {
  buildCounterAclEntry++;
  if (buildCounterAclEntry < 3) {
    unittest.expect(o.expirationTime,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterAclEntry--;
}

core.int buildCounterBackupConfiguration = 0;
buildBackupConfiguration() {
  var o = new api.BackupConfiguration();
  buildCounterBackupConfiguration++;
  if (buildCounterBackupConfiguration < 3) {
    o.binaryLogEnabled = true;
    o.enabled = true;
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
    o.description = "foo";
    o.endTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.enqueuedTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.error = buildOperationError();
    o.id = "foo";
    o.instance = "foo";
    o.kind = "foo";
    o.selfLink = "foo";
    o.startTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.status = "foo";
    o.type = "foo";
    o.windowStartTime = core.DateTime.parse("2002-02-27T14:01:02");
  }
  buildCounterBackupRun--;
  return o;
}

checkBackupRun(api.BackupRun o) {
  buildCounterBackupRun++;
  if (buildCounterBackupRun < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(
        o.endTime, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.enqueuedTime,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    checkOperationError(o.error);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.instance, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.startTime,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.windowStartTime,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
  }
  buildCounterBackupRun--;
}

buildUnnamed3399() {
  var o = new core.List<api.BackupRun>();
  o.add(buildBackupRun());
  o.add(buildBackupRun());
  return o;
}

checkUnnamed3399(core.List<api.BackupRun> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBackupRun(o[0]);
  checkBackupRun(o[1]);
}

core.int buildCounterBackupRunsListResponse = 0;
buildBackupRunsListResponse() {
  var o = new api.BackupRunsListResponse();
  buildCounterBackupRunsListResponse++;
  if (buildCounterBackupRunsListResponse < 3) {
    o.items = buildUnnamed3399();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterBackupRunsListResponse--;
  return o;
}

checkBackupRunsListResponse(api.BackupRunsListResponse o) {
  buildCounterBackupRunsListResponse++;
  if (buildCounterBackupRunsListResponse < 3) {
    checkUnnamed3399(o.items);
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
  }
  buildCounterCloneContext--;
}

core.int buildCounterDatabase = 0;
buildDatabase() {
  var o = new api.Database();
  buildCounterDatabase++;
  if (buildCounterDatabase < 3) {
    o.charset = "foo";
    o.collation = "foo";
    o.etag = "foo";
    o.instance = "foo";
    o.kind = "foo";
    o.name = "foo";
    o.project = "foo";
    o.selfLink = "foo";
  }
  buildCounterDatabase--;
  return o;
}

checkDatabase(api.Database o) {
  buildCounterDatabase++;
  if (buildCounterDatabase < 3) {
    unittest.expect(o.charset, unittest.equals('foo'));
    unittest.expect(o.collation, unittest.equals('foo'));
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.instance, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.project, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
  }
  buildCounterDatabase--;
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

core.int buildCounterDatabaseInstanceFailoverReplica = 0;
buildDatabaseInstanceFailoverReplica() {
  var o = new api.DatabaseInstanceFailoverReplica();
  buildCounterDatabaseInstanceFailoverReplica++;
  if (buildCounterDatabaseInstanceFailoverReplica < 3) {
    o.available = true;
    o.name = "foo";
  }
  buildCounterDatabaseInstanceFailoverReplica--;
  return o;
}

checkDatabaseInstanceFailoverReplica(api.DatabaseInstanceFailoverReplica o) {
  buildCounterDatabaseInstanceFailoverReplica++;
  if (buildCounterDatabaseInstanceFailoverReplica < 3) {
    unittest.expect(o.available, unittest.isTrue);
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterDatabaseInstanceFailoverReplica--;
}

buildUnnamed3400() {
  var o = new core.List<api.IpMapping>();
  o.add(buildIpMapping());
  o.add(buildIpMapping());
  return o;
}

checkUnnamed3400(core.List<api.IpMapping> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkIpMapping(o[0]);
  checkIpMapping(o[1]);
}

buildUnnamed3401() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3401(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3402() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3402(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterDatabaseInstance = 0;
buildDatabaseInstance() {
  var o = new api.DatabaseInstance();
  buildCounterDatabaseInstance++;
  if (buildCounterDatabaseInstance < 3) {
    o.backendType = "foo";
    o.connectionName = "foo";
    o.currentDiskSize = "foo";
    o.databaseVersion = "foo";
    o.etag = "foo";
    o.failoverReplica = buildDatabaseInstanceFailoverReplica();
    o.gceZone = "foo";
    o.instanceType = "foo";
    o.ipAddresses = buildUnnamed3400();
    o.ipv6Address = "foo";
    o.kind = "foo";
    o.masterInstanceName = "foo";
    o.maxDiskSize = "foo";
    o.name = "foo";
    o.onPremisesConfiguration = buildOnPremisesConfiguration();
    o.project = "foo";
    o.region = "foo";
    o.replicaConfiguration = buildReplicaConfiguration();
    o.replicaNames = buildUnnamed3401();
    o.selfLink = "foo";
    o.serverCaCert = buildSslCert();
    o.serviceAccountEmailAddress = "foo";
    o.settings = buildSettings();
    o.state = "foo";
    o.suspensionReason = buildUnnamed3402();
  }
  buildCounterDatabaseInstance--;
  return o;
}

checkDatabaseInstance(api.DatabaseInstance o) {
  buildCounterDatabaseInstance++;
  if (buildCounterDatabaseInstance < 3) {
    unittest.expect(o.backendType, unittest.equals('foo'));
    unittest.expect(o.connectionName, unittest.equals('foo'));
    unittest.expect(o.currentDiskSize, unittest.equals('foo'));
    unittest.expect(o.databaseVersion, unittest.equals('foo'));
    unittest.expect(o.etag, unittest.equals('foo'));
    checkDatabaseInstanceFailoverReplica(o.failoverReplica);
    unittest.expect(o.gceZone, unittest.equals('foo'));
    unittest.expect(o.instanceType, unittest.equals('foo'));
    checkUnnamed3400(o.ipAddresses);
    unittest.expect(o.ipv6Address, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.masterInstanceName, unittest.equals('foo'));
    unittest.expect(o.maxDiskSize, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    checkOnPremisesConfiguration(o.onPremisesConfiguration);
    unittest.expect(o.project, unittest.equals('foo'));
    unittest.expect(o.region, unittest.equals('foo'));
    checkReplicaConfiguration(o.replicaConfiguration);
    checkUnnamed3401(o.replicaNames);
    unittest.expect(o.selfLink, unittest.equals('foo'));
    checkSslCert(o.serverCaCert);
    unittest.expect(o.serviceAccountEmailAddress, unittest.equals('foo'));
    checkSettings(o.settings);
    unittest.expect(o.state, unittest.equals('foo'));
    checkUnnamed3402(o.suspensionReason);
  }
  buildCounterDatabaseInstance--;
}

buildUnnamed3403() {
  var o = new core.List<api.Database>();
  o.add(buildDatabase());
  o.add(buildDatabase());
  return o;
}

checkUnnamed3403(core.List<api.Database> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatabase(o[0]);
  checkDatabase(o[1]);
}

core.int buildCounterDatabasesListResponse = 0;
buildDatabasesListResponse() {
  var o = new api.DatabasesListResponse();
  buildCounterDatabasesListResponse++;
  if (buildCounterDatabasesListResponse < 3) {
    o.items = buildUnnamed3403();
    o.kind = "foo";
  }
  buildCounterDatabasesListResponse--;
  return o;
}

checkDatabasesListResponse(api.DatabasesListResponse o) {
  buildCounterDatabasesListResponse++;
  if (buildCounterDatabasesListResponse < 3) {
    checkUnnamed3403(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterDatabasesListResponse--;
}

core.int buildCounterExportContextCsvExportOptions = 0;
buildExportContextCsvExportOptions() {
  var o = new api.ExportContextCsvExportOptions();
  buildCounterExportContextCsvExportOptions++;
  if (buildCounterExportContextCsvExportOptions < 3) {
    o.selectQuery = "foo";
  }
  buildCounterExportContextCsvExportOptions--;
  return o;
}

checkExportContextCsvExportOptions(api.ExportContextCsvExportOptions o) {
  buildCounterExportContextCsvExportOptions++;
  if (buildCounterExportContextCsvExportOptions < 3) {
    unittest.expect(o.selectQuery, unittest.equals('foo'));
  }
  buildCounterExportContextCsvExportOptions--;
}

buildUnnamed3404() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3404(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3405() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3405(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterExportContextSqlExportOptions = 0;
buildExportContextSqlExportOptions() {
  var o = new api.ExportContextSqlExportOptions();
  buildCounterExportContextSqlExportOptions++;
  if (buildCounterExportContextSqlExportOptions < 3) {
    o.schemaOnly = true;
    o.tables = buildUnnamed3405();
  }
  buildCounterExportContextSqlExportOptions--;
  return o;
}

checkExportContextSqlExportOptions(api.ExportContextSqlExportOptions o) {
  buildCounterExportContextSqlExportOptions++;
  if (buildCounterExportContextSqlExportOptions < 3) {
    unittest.expect(o.schemaOnly, unittest.isTrue);
    checkUnnamed3405(o.tables);
  }
  buildCounterExportContextSqlExportOptions--;
}

core.int buildCounterExportContext = 0;
buildExportContext() {
  var o = new api.ExportContext();
  buildCounterExportContext++;
  if (buildCounterExportContext < 3) {
    o.csvExportOptions = buildExportContextCsvExportOptions();
    o.databases = buildUnnamed3404();
    o.fileType = "foo";
    o.kind = "foo";
    o.sqlExportOptions = buildExportContextSqlExportOptions();
    o.uri = "foo";
  }
  buildCounterExportContext--;
  return o;
}

checkExportContext(api.ExportContext o) {
  buildCounterExportContext++;
  if (buildCounterExportContext < 3) {
    checkExportContextCsvExportOptions(o.csvExportOptions);
    checkUnnamed3404(o.databases);
    unittest.expect(o.fileType, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkExportContextSqlExportOptions(o.sqlExportOptions);
    unittest.expect(o.uri, unittest.equals('foo'));
  }
  buildCounterExportContext--;
}

core.int buildCounterFailoverContext = 0;
buildFailoverContext() {
  var o = new api.FailoverContext();
  buildCounterFailoverContext++;
  if (buildCounterFailoverContext < 3) {
    o.kind = "foo";
    o.settingsVersion = "foo";
  }
  buildCounterFailoverContext--;
  return o;
}

checkFailoverContext(api.FailoverContext o) {
  buildCounterFailoverContext++;
  if (buildCounterFailoverContext < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.settingsVersion, unittest.equals('foo'));
  }
  buildCounterFailoverContext--;
}

buildUnnamed3406() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3406(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3407() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3407(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterFlag = 0;
buildFlag() {
  var o = new api.Flag();
  buildCounterFlag++;
  if (buildCounterFlag < 3) {
    o.allowedStringValues = buildUnnamed3406();
    o.appliesTo = buildUnnamed3407();
    o.kind = "foo";
    o.maxValue = "foo";
    o.minValue = "foo";
    o.name = "foo";
    o.requiresRestart = true;
    o.type = "foo";
  }
  buildCounterFlag--;
  return o;
}

checkFlag(api.Flag o) {
  buildCounterFlag++;
  if (buildCounterFlag < 3) {
    checkUnnamed3406(o.allowedStringValues);
    checkUnnamed3407(o.appliesTo);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.maxValue, unittest.equals('foo'));
    unittest.expect(o.minValue, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.requiresRestart, unittest.isTrue);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterFlag--;
}

buildUnnamed3408() {
  var o = new core.List<api.Flag>();
  o.add(buildFlag());
  o.add(buildFlag());
  return o;
}

checkUnnamed3408(core.List<api.Flag> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFlag(o[0]);
  checkFlag(o[1]);
}

core.int buildCounterFlagsListResponse = 0;
buildFlagsListResponse() {
  var o = new api.FlagsListResponse();
  buildCounterFlagsListResponse++;
  if (buildCounterFlagsListResponse < 3) {
    o.items = buildUnnamed3408();
    o.kind = "foo";
  }
  buildCounterFlagsListResponse--;
  return o;
}

checkFlagsListResponse(api.FlagsListResponse o) {
  buildCounterFlagsListResponse++;
  if (buildCounterFlagsListResponse < 3) {
    checkUnnamed3408(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterFlagsListResponse--;
}

buildUnnamed3409() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3409(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterImportContextCsvImportOptions = 0;
buildImportContextCsvImportOptions() {
  var o = new api.ImportContextCsvImportOptions();
  buildCounterImportContextCsvImportOptions++;
  if (buildCounterImportContextCsvImportOptions < 3) {
    o.columns = buildUnnamed3409();
    o.table = "foo";
  }
  buildCounterImportContextCsvImportOptions--;
  return o;
}

checkImportContextCsvImportOptions(api.ImportContextCsvImportOptions o) {
  buildCounterImportContextCsvImportOptions++;
  if (buildCounterImportContextCsvImportOptions < 3) {
    checkUnnamed3409(o.columns);
    unittest.expect(o.table, unittest.equals('foo'));
  }
  buildCounterImportContextCsvImportOptions--;
}

core.int buildCounterImportContext = 0;
buildImportContext() {
  var o = new api.ImportContext();
  buildCounterImportContext++;
  if (buildCounterImportContext < 3) {
    o.csvImportOptions = buildImportContextCsvImportOptions();
    o.database = "foo";
    o.fileType = "foo";
    o.importUser = "foo";
    o.kind = "foo";
    o.uri = "foo";
  }
  buildCounterImportContext--;
  return o;
}

checkImportContext(api.ImportContext o) {
  buildCounterImportContext++;
  if (buildCounterImportContext < 3) {
    checkImportContextCsvImportOptions(o.csvImportOptions);
    unittest.expect(o.database, unittest.equals('foo'));
    unittest.expect(o.fileType, unittest.equals('foo'));
    unittest.expect(o.importUser, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.uri, unittest.equals('foo'));
  }
  buildCounterImportContext--;
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

core.int buildCounterInstancesFailoverRequest = 0;
buildInstancesFailoverRequest() {
  var o = new api.InstancesFailoverRequest();
  buildCounterInstancesFailoverRequest++;
  if (buildCounterInstancesFailoverRequest < 3) {
    o.failoverContext = buildFailoverContext();
  }
  buildCounterInstancesFailoverRequest--;
  return o;
}

checkInstancesFailoverRequest(api.InstancesFailoverRequest o) {
  buildCounterInstancesFailoverRequest++;
  if (buildCounterInstancesFailoverRequest < 3) {
    checkFailoverContext(o.failoverContext);
  }
  buildCounterInstancesFailoverRequest--;
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

buildUnnamed3410() {
  var o = new core.List<api.DatabaseInstance>();
  o.add(buildDatabaseInstance());
  o.add(buildDatabaseInstance());
  return o;
}

checkUnnamed3410(core.List<api.DatabaseInstance> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatabaseInstance(o[0]);
  checkDatabaseInstance(o[1]);
}

core.int buildCounterInstancesListResponse = 0;
buildInstancesListResponse() {
  var o = new api.InstancesListResponse();
  buildCounterInstancesListResponse++;
  if (buildCounterInstancesListResponse < 3) {
    o.items = buildUnnamed3410();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterInstancesListResponse--;
  return o;
}

checkInstancesListResponse(api.InstancesListResponse o) {
  buildCounterInstancesListResponse++;
  if (buildCounterInstancesListResponse < 3) {
    checkUnnamed3410(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterInstancesListResponse--;
}

core.int buildCounterInstancesRestoreBackupRequest = 0;
buildInstancesRestoreBackupRequest() {
  var o = new api.InstancesRestoreBackupRequest();
  buildCounterInstancesRestoreBackupRequest++;
  if (buildCounterInstancesRestoreBackupRequest < 3) {
    o.restoreBackupContext = buildRestoreBackupContext();
  }
  buildCounterInstancesRestoreBackupRequest--;
  return o;
}

checkInstancesRestoreBackupRequest(api.InstancesRestoreBackupRequest o) {
  buildCounterInstancesRestoreBackupRequest++;
  if (buildCounterInstancesRestoreBackupRequest < 3) {
    checkRestoreBackupContext(o.restoreBackupContext);
  }
  buildCounterInstancesRestoreBackupRequest--;
}

core.int buildCounterInstancesTruncateLogRequest = 0;
buildInstancesTruncateLogRequest() {
  var o = new api.InstancesTruncateLogRequest();
  buildCounterInstancesTruncateLogRequest++;
  if (buildCounterInstancesTruncateLogRequest < 3) {
    o.truncateLogContext = buildTruncateLogContext();
  }
  buildCounterInstancesTruncateLogRequest--;
  return o;
}

checkInstancesTruncateLogRequest(api.InstancesTruncateLogRequest o) {
  buildCounterInstancesTruncateLogRequest++;
  if (buildCounterInstancesTruncateLogRequest < 3) {
    checkTruncateLogContext(o.truncateLogContext);
  }
  buildCounterInstancesTruncateLogRequest--;
}

buildUnnamed3411() {
  var o = new core.List<api.AclEntry>();
  o.add(buildAclEntry());
  o.add(buildAclEntry());
  return o;
}

checkUnnamed3411(core.List<api.AclEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAclEntry(o[0]);
  checkAclEntry(o[1]);
}

core.int buildCounterIpConfiguration = 0;
buildIpConfiguration() {
  var o = new api.IpConfiguration();
  buildCounterIpConfiguration++;
  if (buildCounterIpConfiguration < 3) {
    o.authorizedNetworks = buildUnnamed3411();
    o.ipv4Enabled = true;
    o.requireSsl = true;
  }
  buildCounterIpConfiguration--;
  return o;
}

checkIpConfiguration(api.IpConfiguration o) {
  buildCounterIpConfiguration++;
  if (buildCounterIpConfiguration < 3) {
    checkUnnamed3411(o.authorizedNetworks);
    unittest.expect(o.ipv4Enabled, unittest.isTrue);
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
    o.type = "foo";
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
    unittest.expect(o.type, unittest.equals('foo'));
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

core.int buildCounterMaintenanceWindow = 0;
buildMaintenanceWindow() {
  var o = new api.MaintenanceWindow();
  buildCounterMaintenanceWindow++;
  if (buildCounterMaintenanceWindow < 3) {
    o.day = 42;
    o.hour = 42;
    o.kind = "foo";
    o.updateTrack = "foo";
  }
  buildCounterMaintenanceWindow--;
  return o;
}

checkMaintenanceWindow(api.MaintenanceWindow o) {
  buildCounterMaintenanceWindow++;
  if (buildCounterMaintenanceWindow < 3) {
    unittest.expect(o.day, unittest.equals(42));
    unittest.expect(o.hour, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.updateTrack, unittest.equals('foo'));
  }
  buildCounterMaintenanceWindow--;
}

core.int buildCounterMySqlReplicaConfiguration = 0;
buildMySqlReplicaConfiguration() {
  var o = new api.MySqlReplicaConfiguration();
  buildCounterMySqlReplicaConfiguration++;
  if (buildCounterMySqlReplicaConfiguration < 3) {
    o.caCertificate = "foo";
    o.clientCertificate = "foo";
    o.clientKey = "foo";
    o.connectRetryInterval = 42;
    o.dumpFilePath = "foo";
    o.kind = "foo";
    o.masterHeartbeatPeriod = "foo";
    o.password = "foo";
    o.sslCipher = "foo";
    o.username = "foo";
    o.verifyServerCertificate = true;
  }
  buildCounterMySqlReplicaConfiguration--;
  return o;
}

checkMySqlReplicaConfiguration(api.MySqlReplicaConfiguration o) {
  buildCounterMySqlReplicaConfiguration++;
  if (buildCounterMySqlReplicaConfiguration < 3) {
    unittest.expect(o.caCertificate, unittest.equals('foo'));
    unittest.expect(o.clientCertificate, unittest.equals('foo'));
    unittest.expect(o.clientKey, unittest.equals('foo'));
    unittest.expect(o.connectRetryInterval, unittest.equals(42));
    unittest.expect(o.dumpFilePath, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.masterHeartbeatPeriod, unittest.equals('foo'));
    unittest.expect(o.password, unittest.equals('foo'));
    unittest.expect(o.sslCipher, unittest.equals('foo'));
    unittest.expect(o.username, unittest.equals('foo'));
    unittest.expect(o.verifyServerCertificate, unittest.isTrue);
  }
  buildCounterMySqlReplicaConfiguration--;
}

core.int buildCounterOnPremisesConfiguration = 0;
buildOnPremisesConfiguration() {
  var o = new api.OnPremisesConfiguration();
  buildCounterOnPremisesConfiguration++;
  if (buildCounterOnPremisesConfiguration < 3) {
    o.hostPort = "foo";
    o.kind = "foo";
  }
  buildCounterOnPremisesConfiguration--;
  return o;
}

checkOnPremisesConfiguration(api.OnPremisesConfiguration o) {
  buildCounterOnPremisesConfiguration++;
  if (buildCounterOnPremisesConfiguration < 3) {
    unittest.expect(o.hostPort, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOnPremisesConfiguration--;
}

core.int buildCounterOperation = 0;
buildOperation() {
  var o = new api.Operation();
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    o.endTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.error = buildOperationErrors();
    o.exportContext = buildExportContext();
    o.importContext = buildImportContext();
    o.insertTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.kind = "foo";
    o.name = "foo";
    o.operationType = "foo";
    o.selfLink = "foo";
    o.startTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.status = "foo";
    o.targetId = "foo";
    o.targetLink = "foo";
    o.targetProject = "foo";
    o.user = "foo";
  }
  buildCounterOperation--;
  return o;
}

checkOperation(api.Operation o) {
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    unittest.expect(
        o.endTime, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    checkOperationErrors(o.error);
    checkExportContext(o.exportContext);
    checkImportContext(o.importContext);
    unittest.expect(o.insertTime,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.operationType, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.startTime,
        unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.targetId, unittest.equals('foo'));
    unittest.expect(o.targetLink, unittest.equals('foo'));
    unittest.expect(o.targetProject, unittest.equals('foo'));
    unittest.expect(o.user, unittest.equals('foo'));
  }
  buildCounterOperation--;
}

core.int buildCounterOperationError = 0;
buildOperationError() {
  var o = new api.OperationError();
  buildCounterOperationError++;
  if (buildCounterOperationError < 3) {
    o.code = "foo";
    o.kind = "foo";
    o.message = "foo";
  }
  buildCounterOperationError--;
  return o;
}

checkOperationError(api.OperationError o) {
  buildCounterOperationError++;
  if (buildCounterOperationError < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterOperationError--;
}

buildUnnamed3412() {
  var o = new core.List<api.OperationError>();
  o.add(buildOperationError());
  o.add(buildOperationError());
  return o;
}

checkUnnamed3412(core.List<api.OperationError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperationError(o[0]);
  checkOperationError(o[1]);
}

core.int buildCounterOperationErrors = 0;
buildOperationErrors() {
  var o = new api.OperationErrors();
  buildCounterOperationErrors++;
  if (buildCounterOperationErrors < 3) {
    o.errors = buildUnnamed3412();
    o.kind = "foo";
  }
  buildCounterOperationErrors--;
  return o;
}

checkOperationErrors(api.OperationErrors o) {
  buildCounterOperationErrors++;
  if (buildCounterOperationErrors < 3) {
    checkUnnamed3412(o.errors);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOperationErrors--;
}

buildUnnamed3413() {
  var o = new core.List<api.Operation>();
  o.add(buildOperation());
  o.add(buildOperation());
  return o;
}

checkUnnamed3413(core.List<api.Operation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperation(o[0]);
  checkOperation(o[1]);
}

core.int buildCounterOperationsListResponse = 0;
buildOperationsListResponse() {
  var o = new api.OperationsListResponse();
  buildCounterOperationsListResponse++;
  if (buildCounterOperationsListResponse < 3) {
    o.items = buildUnnamed3413();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterOperationsListResponse--;
  return o;
}

checkOperationsListResponse(api.OperationsListResponse o) {
  buildCounterOperationsListResponse++;
  if (buildCounterOperationsListResponse < 3) {
    checkUnnamed3413(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterOperationsListResponse--;
}

core.int buildCounterReplicaConfiguration = 0;
buildReplicaConfiguration() {
  var o = new api.ReplicaConfiguration();
  buildCounterReplicaConfiguration++;
  if (buildCounterReplicaConfiguration < 3) {
    o.failoverTarget = true;
    o.kind = "foo";
    o.mysqlReplicaConfiguration = buildMySqlReplicaConfiguration();
  }
  buildCounterReplicaConfiguration--;
  return o;
}

checkReplicaConfiguration(api.ReplicaConfiguration o) {
  buildCounterReplicaConfiguration++;
  if (buildCounterReplicaConfiguration < 3) {
    unittest.expect(o.failoverTarget, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkMySqlReplicaConfiguration(o.mysqlReplicaConfiguration);
  }
  buildCounterReplicaConfiguration--;
}

core.int buildCounterRestoreBackupContext = 0;
buildRestoreBackupContext() {
  var o = new api.RestoreBackupContext();
  buildCounterRestoreBackupContext++;
  if (buildCounterRestoreBackupContext < 3) {
    o.backupRunId = "foo";
    o.instanceId = "foo";
    o.kind = "foo";
  }
  buildCounterRestoreBackupContext--;
  return o;
}

checkRestoreBackupContext(api.RestoreBackupContext o) {
  buildCounterRestoreBackupContext++;
  if (buildCounterRestoreBackupContext < 3) {
    unittest.expect(o.backupRunId, unittest.equals('foo'));
    unittest.expect(o.instanceId, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterRestoreBackupContext--;
}

buildUnnamed3414() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3414(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3415() {
  var o = new core.List<api.DatabaseFlags>();
  o.add(buildDatabaseFlags());
  o.add(buildDatabaseFlags());
  return o;
}

checkUnnamed3415(core.List<api.DatabaseFlags> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatabaseFlags(o[0]);
  checkDatabaseFlags(o[1]);
}

buildUnnamed3416() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed3416(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterSettings = 0;
buildSettings() {
  var o = new api.Settings();
  buildCounterSettings++;
  if (buildCounterSettings < 3) {
    o.activationPolicy = "foo";
    o.authorizedGaeApplications = buildUnnamed3414();
    o.availabilityType = "foo";
    o.backupConfiguration = buildBackupConfiguration();
    o.crashSafeReplicationEnabled = true;
    o.dataDiskSizeGb = "foo";
    o.dataDiskType = "foo";
    o.databaseFlags = buildUnnamed3415();
    o.databaseReplicationEnabled = true;
    o.ipConfiguration = buildIpConfiguration();
    o.kind = "foo";
    o.locationPreference = buildLocationPreference();
    o.maintenanceWindow = buildMaintenanceWindow();
    o.pricingPlan = "foo";
    o.replicationType = "foo";
    o.settingsVersion = "foo";
    o.storageAutoResize = true;
    o.storageAutoResizeLimit = "foo";
    o.tier = "foo";
    o.userLabels = buildUnnamed3416();
  }
  buildCounterSettings--;
  return o;
}

checkSettings(api.Settings o) {
  buildCounterSettings++;
  if (buildCounterSettings < 3) {
    unittest.expect(o.activationPolicy, unittest.equals('foo'));
    checkUnnamed3414(o.authorizedGaeApplications);
    unittest.expect(o.availabilityType, unittest.equals('foo'));
    checkBackupConfiguration(o.backupConfiguration);
    unittest.expect(o.crashSafeReplicationEnabled, unittest.isTrue);
    unittest.expect(o.dataDiskSizeGb, unittest.equals('foo'));
    unittest.expect(o.dataDiskType, unittest.equals('foo'));
    checkUnnamed3415(o.databaseFlags);
    unittest.expect(o.databaseReplicationEnabled, unittest.isTrue);
    checkIpConfiguration(o.ipConfiguration);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkLocationPreference(o.locationPreference);
    checkMaintenanceWindow(o.maintenanceWindow);
    unittest.expect(o.pricingPlan, unittest.equals('foo'));
    unittest.expect(o.replicationType, unittest.equals('foo'));
    unittest.expect(o.settingsVersion, unittest.equals('foo'));
    unittest.expect(o.storageAutoResize, unittest.isTrue);
    unittest.expect(o.storageAutoResizeLimit, unittest.equals('foo'));
    unittest.expect(o.tier, unittest.equals('foo'));
    checkUnnamed3416(o.userLabels);
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
    o.selfLink = "foo";
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
    unittest.expect(o.selfLink, unittest.equals('foo'));
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

core.int buildCounterSslCertsCreateEphemeralRequest = 0;
buildSslCertsCreateEphemeralRequest() {
  var o = new api.SslCertsCreateEphemeralRequest();
  buildCounterSslCertsCreateEphemeralRequest++;
  if (buildCounterSslCertsCreateEphemeralRequest < 3) {
    o.publicKey = "foo";
  }
  buildCounterSslCertsCreateEphemeralRequest--;
  return o;
}

checkSslCertsCreateEphemeralRequest(api.SslCertsCreateEphemeralRequest o) {
  buildCounterSslCertsCreateEphemeralRequest++;
  if (buildCounterSslCertsCreateEphemeralRequest < 3) {
    unittest.expect(o.publicKey, unittest.equals('foo'));
  }
  buildCounterSslCertsCreateEphemeralRequest--;
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
    o.operation = buildOperation();
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
    checkOperation(o.operation);
    checkSslCert(o.serverCaCert);
  }
  buildCounterSslCertsInsertResponse--;
}

buildUnnamed3417() {
  var o = new core.List<api.SslCert>();
  o.add(buildSslCert());
  o.add(buildSslCert());
  return o;
}

checkUnnamed3417(core.List<api.SslCert> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSslCert(o[0]);
  checkSslCert(o[1]);
}

core.int buildCounterSslCertsListResponse = 0;
buildSslCertsListResponse() {
  var o = new api.SslCertsListResponse();
  buildCounterSslCertsListResponse++;
  if (buildCounterSslCertsListResponse < 3) {
    o.items = buildUnnamed3417();
    o.kind = "foo";
  }
  buildCounterSslCertsListResponse--;
  return o;
}

checkSslCertsListResponse(api.SslCertsListResponse o) {
  buildCounterSslCertsListResponse++;
  if (buildCounterSslCertsListResponse < 3) {
    checkUnnamed3417(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterSslCertsListResponse--;
}

buildUnnamed3418() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3418(core.List<core.String> o) {
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
    o.region = buildUnnamed3418();
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
    checkUnnamed3418(o.region);
    unittest.expect(o.tier, unittest.equals('foo'));
  }
  buildCounterTier--;
}

buildUnnamed3419() {
  var o = new core.List<api.Tier>();
  o.add(buildTier());
  o.add(buildTier());
  return o;
}

checkUnnamed3419(core.List<api.Tier> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTier(o[0]);
  checkTier(o[1]);
}

core.int buildCounterTiersListResponse = 0;
buildTiersListResponse() {
  var o = new api.TiersListResponse();
  buildCounterTiersListResponse++;
  if (buildCounterTiersListResponse < 3) {
    o.items = buildUnnamed3419();
    o.kind = "foo";
  }
  buildCounterTiersListResponse--;
  return o;
}

checkTiersListResponse(api.TiersListResponse o) {
  buildCounterTiersListResponse++;
  if (buildCounterTiersListResponse < 3) {
    checkUnnamed3419(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterTiersListResponse--;
}

core.int buildCounterTruncateLogContext = 0;
buildTruncateLogContext() {
  var o = new api.TruncateLogContext();
  buildCounterTruncateLogContext++;
  if (buildCounterTruncateLogContext < 3) {
    o.kind = "foo";
    o.logType = "foo";
  }
  buildCounterTruncateLogContext--;
  return o;
}

checkTruncateLogContext(api.TruncateLogContext o) {
  buildCounterTruncateLogContext++;
  if (buildCounterTruncateLogContext < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.logType, unittest.equals('foo'));
  }
  buildCounterTruncateLogContext--;
}

core.int buildCounterUser = 0;
buildUser() {
  var o = new api.User();
  buildCounterUser++;
  if (buildCounterUser < 3) {
    o.etag = "foo";
    o.host = "foo";
    o.instance = "foo";
    o.kind = "foo";
    o.name = "foo";
    o.password = "foo";
    o.project = "foo";
  }
  buildCounterUser--;
  return o;
}

checkUser(api.User o) {
  buildCounterUser++;
  if (buildCounterUser < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.host, unittest.equals('foo'));
    unittest.expect(o.instance, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.password, unittest.equals('foo'));
    unittest.expect(o.project, unittest.equals('foo'));
  }
  buildCounterUser--;
}

buildUnnamed3420() {
  var o = new core.List<api.User>();
  o.add(buildUser());
  o.add(buildUser());
  return o;
}

checkUnnamed3420(core.List<api.User> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUser(o[0]);
  checkUser(o[1]);
}

core.int buildCounterUsersListResponse = 0;
buildUsersListResponse() {
  var o = new api.UsersListResponse();
  buildCounterUsersListResponse++;
  if (buildCounterUsersListResponse < 3) {
    o.items = buildUnnamed3420();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterUsersListResponse--;
  return o;
}

checkUsersListResponse(api.UsersListResponse o) {
  buildCounterUsersListResponse++;
  if (buildCounterUsersListResponse < 3) {
    checkUnnamed3420(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterUsersListResponse--;
}

main() {
  unittest.group("obj-schema-AclEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildAclEntry();
      var od = new api.AclEntry.fromJson(o.toJson());
      checkAclEntry(od);
    });
  });

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

  unittest.group("obj-schema-Database", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatabase();
      var od = new api.Database.fromJson(o.toJson());
      checkDatabase(od);
    });
  });

  unittest.group("obj-schema-DatabaseFlags", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatabaseFlags();
      var od = new api.DatabaseFlags.fromJson(o.toJson());
      checkDatabaseFlags(od);
    });
  });

  unittest.group("obj-schema-DatabaseInstanceFailoverReplica", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatabaseInstanceFailoverReplica();
      var od = new api.DatabaseInstanceFailoverReplica.fromJson(o.toJson());
      checkDatabaseInstanceFailoverReplica(od);
    });
  });

  unittest.group("obj-schema-DatabaseInstance", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatabaseInstance();
      var od = new api.DatabaseInstance.fromJson(o.toJson());
      checkDatabaseInstance(od);
    });
  });

  unittest.group("obj-schema-DatabasesListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatabasesListResponse();
      var od = new api.DatabasesListResponse.fromJson(o.toJson());
      checkDatabasesListResponse(od);
    });
  });

  unittest.group("obj-schema-ExportContextCsvExportOptions", () {
    unittest.test("to-json--from-json", () {
      var o = buildExportContextCsvExportOptions();
      var od = new api.ExportContextCsvExportOptions.fromJson(o.toJson());
      checkExportContextCsvExportOptions(od);
    });
  });

  unittest.group("obj-schema-ExportContextSqlExportOptions", () {
    unittest.test("to-json--from-json", () {
      var o = buildExportContextSqlExportOptions();
      var od = new api.ExportContextSqlExportOptions.fromJson(o.toJson());
      checkExportContextSqlExportOptions(od);
    });
  });

  unittest.group("obj-schema-ExportContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildExportContext();
      var od = new api.ExportContext.fromJson(o.toJson());
      checkExportContext(od);
    });
  });

  unittest.group("obj-schema-FailoverContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildFailoverContext();
      var od = new api.FailoverContext.fromJson(o.toJson());
      checkFailoverContext(od);
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

  unittest.group("obj-schema-ImportContextCsvImportOptions", () {
    unittest.test("to-json--from-json", () {
      var o = buildImportContextCsvImportOptions();
      var od = new api.ImportContextCsvImportOptions.fromJson(o.toJson());
      checkImportContextCsvImportOptions(od);
    });
  });

  unittest.group("obj-schema-ImportContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildImportContext();
      var od = new api.ImportContext.fromJson(o.toJson());
      checkImportContext(od);
    });
  });

  unittest.group("obj-schema-InstancesCloneRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesCloneRequest();
      var od = new api.InstancesCloneRequest.fromJson(o.toJson());
      checkInstancesCloneRequest(od);
    });
  });

  unittest.group("obj-schema-InstancesExportRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesExportRequest();
      var od = new api.InstancesExportRequest.fromJson(o.toJson());
      checkInstancesExportRequest(od);
    });
  });

  unittest.group("obj-schema-InstancesFailoverRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesFailoverRequest();
      var od = new api.InstancesFailoverRequest.fromJson(o.toJson());
      checkInstancesFailoverRequest(od);
    });
  });

  unittest.group("obj-schema-InstancesImportRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesImportRequest();
      var od = new api.InstancesImportRequest.fromJson(o.toJson());
      checkInstancesImportRequest(od);
    });
  });

  unittest.group("obj-schema-InstancesListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesListResponse();
      var od = new api.InstancesListResponse.fromJson(o.toJson());
      checkInstancesListResponse(od);
    });
  });

  unittest.group("obj-schema-InstancesRestoreBackupRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesRestoreBackupRequest();
      var od = new api.InstancesRestoreBackupRequest.fromJson(o.toJson());
      checkInstancesRestoreBackupRequest(od);
    });
  });

  unittest.group("obj-schema-InstancesTruncateLogRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstancesTruncateLogRequest();
      var od = new api.InstancesTruncateLogRequest.fromJson(o.toJson());
      checkInstancesTruncateLogRequest(od);
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

  unittest.group("obj-schema-MaintenanceWindow", () {
    unittest.test("to-json--from-json", () {
      var o = buildMaintenanceWindow();
      var od = new api.MaintenanceWindow.fromJson(o.toJson());
      checkMaintenanceWindow(od);
    });
  });

  unittest.group("obj-schema-MySqlReplicaConfiguration", () {
    unittest.test("to-json--from-json", () {
      var o = buildMySqlReplicaConfiguration();
      var od = new api.MySqlReplicaConfiguration.fromJson(o.toJson());
      checkMySqlReplicaConfiguration(od);
    });
  });

  unittest.group("obj-schema-OnPremisesConfiguration", () {
    unittest.test("to-json--from-json", () {
      var o = buildOnPremisesConfiguration();
      var od = new api.OnPremisesConfiguration.fromJson(o.toJson());
      checkOnPremisesConfiguration(od);
    });
  });

  unittest.group("obj-schema-Operation", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperation();
      var od = new api.Operation.fromJson(o.toJson());
      checkOperation(od);
    });
  });

  unittest.group("obj-schema-OperationError", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationError();
      var od = new api.OperationError.fromJson(o.toJson());
      checkOperationError(od);
    });
  });

  unittest.group("obj-schema-OperationErrors", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationErrors();
      var od = new api.OperationErrors.fromJson(o.toJson());
      checkOperationErrors(od);
    });
  });

  unittest.group("obj-schema-OperationsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationsListResponse();
      var od = new api.OperationsListResponse.fromJson(o.toJson());
      checkOperationsListResponse(od);
    });
  });

  unittest.group("obj-schema-ReplicaConfiguration", () {
    unittest.test("to-json--from-json", () {
      var o = buildReplicaConfiguration();
      var od = new api.ReplicaConfiguration.fromJson(o.toJson());
      checkReplicaConfiguration(od);
    });
  });

  unittest.group("obj-schema-RestoreBackupContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildRestoreBackupContext();
      var od = new api.RestoreBackupContext.fromJson(o.toJson());
      checkRestoreBackupContext(od);
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

  unittest.group("obj-schema-SslCertsCreateEphemeralRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildSslCertsCreateEphemeralRequest();
      var od = new api.SslCertsCreateEphemeralRequest.fromJson(o.toJson());
      checkSslCertsCreateEphemeralRequest(od);
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

  unittest.group("obj-schema-TruncateLogContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildTruncateLogContext();
      var od = new api.TruncateLogContext.fromJson(o.toJson());
      checkTruncateLogContext(od);
    });
  });

  unittest.group("obj-schema-User", () {
    unittest.test("to-json--from-json", () {
      var o = buildUser();
      var od = new api.User.fromJson(o.toJson());
      checkUser(od);
    });
  });

  unittest.group("obj-schema-UsersListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildUsersListResponse();
      var od = new api.UsersListResponse.fromJson(o.toJson());
      checkUsersListResponse(od);
    });
  });

  unittest.group("resource-BackupRunsResourceApi", () {
    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.BackupRunsResourceApi res = new api.SqladminApi(mock).backupRuns;
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_id = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        unittest.expect(subPart, unittest.equals("$arg_id"));

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
          .delete(arg_project, arg_instance, arg_id)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.BackupRunsResourceApi res = new api.SqladminApi(mock).backupRuns;
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_id = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        unittest.expect(subPart, unittest.equals("$arg_id"));

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
        var resp = convert.JSON.encode(buildBackupRun());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_instance, arg_id)
          .then(unittest.expectAsync1(((api.BackupRun response) {
        checkBackupRun(response);
      })));
    });

    unittest.test("method--insert", () {
      var mock = new HttpServerMock();
      api.BackupRunsResourceApi res = new api.SqladminApi(mock).backupRuns;
      var arg_request = buildBackupRun();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.BackupRun.fromJson(json);
        checkBackupRun(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .insert(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.BackupRunsResourceApi res = new api.SqladminApi(mock).backupRuns;
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
            unittest.equals("sql/v1beta4/"));
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
          .list(arg_project, arg_instance,
              maxResults: arg_maxResults, pageToken: arg_pageToken)
          .then(unittest.expectAsync1(((api.BackupRunsListResponse response) {
        checkBackupRunsListResponse(response);
      })));
    });
  });

  unittest.group("resource-DatabasesResourceApi", () {
    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.DatabasesResourceApi res = new api.SqladminApi(mock).databases;
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_database = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/databases/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/databases/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_database"));

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
          .delete(arg_project, arg_instance, arg_database)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.DatabasesResourceApi res = new api.SqladminApi(mock).databases;
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_database = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/databases/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/databases/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_database"));

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
        var resp = convert.JSON.encode(buildDatabase());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_instance, arg_database)
          .then(unittest.expectAsync1(((api.Database response) {
        checkDatabase(response);
      })));
    });

    unittest.test("method--insert", () {
      var mock = new HttpServerMock();
      api.DatabasesResourceApi res = new api.SqladminApi(mock).databases;
      var arg_request = buildDatabase();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Database.fromJson(json);
        checkDatabase(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/databases", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("/databases"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .insert(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.DatabasesResourceApi res = new api.SqladminApi(mock).databases;
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
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/databases", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("/databases"));
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
        var resp = convert.JSON.encode(buildDatabasesListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.DatabasesListResponse response) {
        checkDatabasesListResponse(response);
      })));
    });

    unittest.test("method--patch", () {
      var mock = new HttpServerMock();
      api.DatabasesResourceApi res = new api.SqladminApi(mock).databases;
      var arg_request = buildDatabase();
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_database = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Database.fromJson(json);
        checkDatabase(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/databases/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/databases/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_database"));

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
          .patch(arg_request, arg_project, arg_instance, arg_database)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.DatabasesResourceApi res = new api.SqladminApi(mock).databases;
      var arg_request = buildDatabase();
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_database = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Database.fromJson(json);
        checkDatabase(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/databases/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/databases/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_database"));

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
          .update(arg_request, arg_project, arg_instance, arg_database)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });
  });

  unittest.group("resource-FlagsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.FlagsResourceApi res = new api.SqladminApi(mock).flags;
      var arg_databaseVersion = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        unittest.expect(queryMap["databaseVersion"].first,
            unittest.equals(arg_databaseVersion));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildFlagsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(databaseVersion: arg_databaseVersion)
          .then(unittest.expectAsync1(((api.FlagsListResponse response) {
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
      var arg_instance = "foo";
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
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/clone", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6),
            unittest.equals("/clone"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .clone(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
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
            unittest.equals("sql/v1beta4/"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
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
            unittest.equals("sql/v1beta4/"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .export(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--failover", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_request = buildInstancesFailoverRequest();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.InstancesFailoverRequest.fromJson(json);
        checkInstancesFailoverRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/failover", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/failover"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .failover(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
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
            unittest.equals("sql/v1beta4/"));
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
            unittest.equals("sql/v1beta4/"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .import(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
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
            unittest.equals("sql/v1beta4/"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .insert(arg_request, arg_project)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_project = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
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
              filter: arg_filter,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken)
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
            unittest.equals("sql/v1beta4/"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .patch(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
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
            unittest.equals("sql/v1beta4/"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .promoteReplica(arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
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
            unittest.equals("sql/v1beta4/"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .resetSslConfig(arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
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
            unittest.equals("sql/v1beta4/"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .restart(arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--restoreBackup", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_request = buildInstancesRestoreBackupRequest();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.InstancesRestoreBackupRequest.fromJson(json);
        checkInstancesRestoreBackupRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .restoreBackup(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--startReplica", () {
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
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/startReplica", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("/startReplica"));
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
          .startReplica(arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--stopReplica", () {
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
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/stopReplica", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/stopReplica"));
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
          .stopReplica(arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--truncateLog", () {
      var mock = new HttpServerMock();
      api.InstancesResourceApi res = new api.SqladminApi(mock).instances;
      var arg_request = buildInstancesTruncateLogRequest();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.InstancesTruncateLogRequest.fromJson(json);
        checkInstancesTruncateLogRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/truncateLog", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/truncateLog"));
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
          .truncateLog(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
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
            unittest.equals("sql/v1beta4/"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });
  });

  unittest.group("resource-OperationsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.OperationsResourceApi res = new api.SqladminApi(mock).operations;
      var arg_project = "foo";
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
            unittest.equals("sql/v1beta4/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/operations/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_operation)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
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
            unittest.equals("sql/v1beta4/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("projects/"));
        pathOffset += 9;
        index = path.indexOf("/operations", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_project"));
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
        unittest.expect(
            queryMap["instance"].first, unittest.equals(arg_instance));
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
    unittest.test("method--createEphemeral", () {
      var mock = new HttpServerMock();
      api.SslCertsResourceApi res = new api.SqladminApi(mock).sslCerts;
      var arg_request = buildSslCertsCreateEphemeralRequest();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.SslCertsCreateEphemeralRequest.fromJson(json);
        checkSslCertsCreateEphemeralRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/createEphemeral", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 16),
            unittest.equals("/createEphemeral"));
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
        var resp = convert.JSON.encode(buildSslCert());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .createEphemeral(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.SslCert response) {
        checkSslCert(response);
      })));
    });

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
            unittest.equals("sql/v1beta4/"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_project, arg_instance, arg_sha1Fingerprint)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
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
            unittest.equals("sql/v1beta4/"));
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
            unittest.equals("sql/v1beta4/"));
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
            unittest.equals("sql/v1beta4/"));
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
            unittest.equals("sql/v1beta4/"));
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

  unittest.group("resource-UsersResourceApi", () {
    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.UsersResourceApi res = new api.SqladminApi(mock).users;
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_host = "foo";
      var arg_name = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/users", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6),
            unittest.equals("/users"));
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
        unittest.expect(queryMap["host"].first, unittest.equals(arg_host));
        unittest.expect(queryMap["name"].first, unittest.equals(arg_name));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_project, arg_instance, arg_host, arg_name)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--insert", () {
      var mock = new HttpServerMock();
      api.UsersResourceApi res = new api.SqladminApi(mock).users;
      var arg_request = buildUser();
      var arg_project = "foo";
      var arg_instance = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.User.fromJson(json);
        checkUser(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/users", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6),
            unittest.equals("/users"));
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
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .insert(arg_request, arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.UsersResourceApi res = new api.SqladminApi(mock).users;
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
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/users", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6),
            unittest.equals("/users"));
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
        var resp = convert.JSON.encode(buildUsersListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_instance)
          .then(unittest.expectAsync1(((api.UsersListResponse response) {
        checkUsersListResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.UsersResourceApi res = new api.SqladminApi(mock).users;
      var arg_request = buildUser();
      var arg_project = "foo";
      var arg_instance = "foo";
      var arg_host = "foo";
      var arg_name = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.User.fromJson(json);
        checkUser(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("sql/v1beta4/"));
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
        index = path.indexOf("/users", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_instance"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6),
            unittest.equals("/users"));
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
        unittest.expect(queryMap["host"].first, unittest.equals(arg_host));
        unittest.expect(queryMap["name"].first, unittest.equals(arg_name));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_project, arg_instance, arg_host, arg_name)
          .then(unittest.expectAsync1(((api.Operation response) {
        checkOperation(response);
      })));
    });
  });
}
