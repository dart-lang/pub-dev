library googleapis.storagetransfer.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/storagetransfer/v1.dart' as api;

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

core.int buildCounterAwsAccessKey = 0;
buildAwsAccessKey() {
  var o = new api.AwsAccessKey();
  buildCounterAwsAccessKey++;
  if (buildCounterAwsAccessKey < 3) {
    o.accessKeyId = "foo";
    o.secretAccessKey = "foo";
  }
  buildCounterAwsAccessKey--;
  return o;
}

checkAwsAccessKey(api.AwsAccessKey o) {
  buildCounterAwsAccessKey++;
  if (buildCounterAwsAccessKey < 3) {
    unittest.expect(o.accessKeyId, unittest.equals('foo'));
    unittest.expect(o.secretAccessKey, unittest.equals('foo'));
  }
  buildCounterAwsAccessKey--;
}

core.int buildCounterAwsS3Data = 0;
buildAwsS3Data() {
  var o = new api.AwsS3Data();
  buildCounterAwsS3Data++;
  if (buildCounterAwsS3Data < 3) {
    o.awsAccessKey = buildAwsAccessKey();
    o.bucketName = "foo";
  }
  buildCounterAwsS3Data--;
  return o;
}

checkAwsS3Data(api.AwsS3Data o) {
  buildCounterAwsS3Data++;
  if (buildCounterAwsS3Data < 3) {
    checkAwsAccessKey(o.awsAccessKey);
    unittest.expect(o.bucketName, unittest.equals('foo'));
  }
  buildCounterAwsS3Data--;
}

core.int buildCounterDate = 0;
buildDate() {
  var o = new api.Date();
  buildCounterDate++;
  if (buildCounterDate < 3) {
    o.day = 42;
    o.month = 42;
    o.year = 42;
  }
  buildCounterDate--;
  return o;
}

checkDate(api.Date o) {
  buildCounterDate++;
  if (buildCounterDate < 3) {
    unittest.expect(o.day, unittest.equals(42));
    unittest.expect(o.month, unittest.equals(42));
    unittest.expect(o.year, unittest.equals(42));
  }
  buildCounterDate--;
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

buildUnnamed1205() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1205(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterErrorLogEntry = 0;
buildErrorLogEntry() {
  var o = new api.ErrorLogEntry();
  buildCounterErrorLogEntry++;
  if (buildCounterErrorLogEntry < 3) {
    o.errorDetails = buildUnnamed1205();
    o.url = "foo";
  }
  buildCounterErrorLogEntry--;
  return o;
}

checkErrorLogEntry(api.ErrorLogEntry o) {
  buildCounterErrorLogEntry++;
  if (buildCounterErrorLogEntry < 3) {
    checkUnnamed1205(o.errorDetails);
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterErrorLogEntry--;
}

buildUnnamed1206() {
  var o = new core.List<api.ErrorLogEntry>();
  o.add(buildErrorLogEntry());
  o.add(buildErrorLogEntry());
  return o;
}

checkUnnamed1206(core.List<api.ErrorLogEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkErrorLogEntry(o[0]);
  checkErrorLogEntry(o[1]);
}

core.int buildCounterErrorSummary = 0;
buildErrorSummary() {
  var o = new api.ErrorSummary();
  buildCounterErrorSummary++;
  if (buildCounterErrorSummary < 3) {
    o.errorCode = "foo";
    o.errorCount = "foo";
    o.errorLogEntries = buildUnnamed1206();
  }
  buildCounterErrorSummary--;
  return o;
}

checkErrorSummary(api.ErrorSummary o) {
  buildCounterErrorSummary++;
  if (buildCounterErrorSummary < 3) {
    unittest.expect(o.errorCode, unittest.equals('foo'));
    unittest.expect(o.errorCount, unittest.equals('foo'));
    checkUnnamed1206(o.errorLogEntries);
  }
  buildCounterErrorSummary--;
}

core.int buildCounterGcsData = 0;
buildGcsData() {
  var o = new api.GcsData();
  buildCounterGcsData++;
  if (buildCounterGcsData < 3) {
    o.bucketName = "foo";
  }
  buildCounterGcsData--;
  return o;
}

checkGcsData(api.GcsData o) {
  buildCounterGcsData++;
  if (buildCounterGcsData < 3) {
    unittest.expect(o.bucketName, unittest.equals('foo'));
  }
  buildCounterGcsData--;
}

core.int buildCounterGoogleServiceAccount = 0;
buildGoogleServiceAccount() {
  var o = new api.GoogleServiceAccount();
  buildCounterGoogleServiceAccount++;
  if (buildCounterGoogleServiceAccount < 3) {
    o.accountEmail = "foo";
  }
  buildCounterGoogleServiceAccount--;
  return o;
}

checkGoogleServiceAccount(api.GoogleServiceAccount o) {
  buildCounterGoogleServiceAccount++;
  if (buildCounterGoogleServiceAccount < 3) {
    unittest.expect(o.accountEmail, unittest.equals('foo'));
  }
  buildCounterGoogleServiceAccount--;
}

core.int buildCounterHttpData = 0;
buildHttpData() {
  var o = new api.HttpData();
  buildCounterHttpData++;
  if (buildCounterHttpData < 3) {
    o.listUrl = "foo";
  }
  buildCounterHttpData--;
  return o;
}

checkHttpData(api.HttpData o) {
  buildCounterHttpData++;
  if (buildCounterHttpData < 3) {
    unittest.expect(o.listUrl, unittest.equals('foo'));
  }
  buildCounterHttpData--;
}

buildUnnamed1207() {
  var o = new core.List<api.Operation>();
  o.add(buildOperation());
  o.add(buildOperation());
  return o;
}

checkUnnamed1207(core.List<api.Operation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperation(o[0]);
  checkOperation(o[1]);
}

core.int buildCounterListOperationsResponse = 0;
buildListOperationsResponse() {
  var o = new api.ListOperationsResponse();
  buildCounterListOperationsResponse++;
  if (buildCounterListOperationsResponse < 3) {
    o.nextPageToken = "foo";
    o.operations = buildUnnamed1207();
  }
  buildCounterListOperationsResponse--;
  return o;
}

checkListOperationsResponse(api.ListOperationsResponse o) {
  buildCounterListOperationsResponse++;
  if (buildCounterListOperationsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed1207(o.operations);
  }
  buildCounterListOperationsResponse--;
}

buildUnnamed1208() {
  var o = new core.List<api.TransferJob>();
  o.add(buildTransferJob());
  o.add(buildTransferJob());
  return o;
}

checkUnnamed1208(core.List<api.TransferJob> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTransferJob(o[0]);
  checkTransferJob(o[1]);
}

core.int buildCounterListTransferJobsResponse = 0;
buildListTransferJobsResponse() {
  var o = new api.ListTransferJobsResponse();
  buildCounterListTransferJobsResponse++;
  if (buildCounterListTransferJobsResponse < 3) {
    o.nextPageToken = "foo";
    o.transferJobs = buildUnnamed1208();
  }
  buildCounterListTransferJobsResponse--;
  return o;
}

checkListTransferJobsResponse(api.ListTransferJobsResponse o) {
  buildCounterListTransferJobsResponse++;
  if (buildCounterListTransferJobsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed1208(o.transferJobs);
  }
  buildCounterListTransferJobsResponse--;
}

buildUnnamed1209() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1209(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1210() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1210(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterObjectConditions = 0;
buildObjectConditions() {
  var o = new api.ObjectConditions();
  buildCounterObjectConditions++;
  if (buildCounterObjectConditions < 3) {
    o.excludePrefixes = buildUnnamed1209();
    o.includePrefixes = buildUnnamed1210();
    o.maxTimeElapsedSinceLastModification = "foo";
    o.minTimeElapsedSinceLastModification = "foo";
  }
  buildCounterObjectConditions--;
  return o;
}

checkObjectConditions(api.ObjectConditions o) {
  buildCounterObjectConditions++;
  if (buildCounterObjectConditions < 3) {
    checkUnnamed1209(o.excludePrefixes);
    checkUnnamed1210(o.includePrefixes);
    unittest.expect(o.maxTimeElapsedSinceLastModification, unittest.equals('foo'));
    unittest.expect(o.minTimeElapsedSinceLastModification, unittest.equals('foo'));
  }
  buildCounterObjectConditions--;
}

buildUnnamed1211() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  o["y"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  return o;
}

checkUnnamed1211(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o["x"]) as core.Map; unittest.expect(casted1, unittest.hasLength(3)); unittest.expect(casted1["list"], unittest.equals([1, 2, 3])); unittest.expect(casted1["bool"], unittest.equals(true)); unittest.expect(casted1["string"], unittest.equals('foo')); 
  var casted2 = (o["y"]) as core.Map; unittest.expect(casted2, unittest.hasLength(3)); unittest.expect(casted2["list"], unittest.equals([1, 2, 3])); unittest.expect(casted2["bool"], unittest.equals(true)); unittest.expect(casted2["string"], unittest.equals('foo')); 
}

buildUnnamed1212() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  o["y"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  return o;
}

checkUnnamed1212(core.Map<core.String, core.Object> o) {
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
    o.metadata = buildUnnamed1211();
    o.name = "foo";
    o.response = buildUnnamed1212();
  }
  buildCounterOperation--;
  return o;
}

checkOperation(api.Operation o) {
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    unittest.expect(o.done, unittest.isTrue);
    checkStatus(o.error);
    checkUnnamed1211(o.metadata);
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed1212(o.response);
  }
  buildCounterOperation--;
}

core.int buildCounterPauseTransferOperationRequest = 0;
buildPauseTransferOperationRequest() {
  var o = new api.PauseTransferOperationRequest();
  buildCounterPauseTransferOperationRequest++;
  if (buildCounterPauseTransferOperationRequest < 3) {
  }
  buildCounterPauseTransferOperationRequest--;
  return o;
}

checkPauseTransferOperationRequest(api.PauseTransferOperationRequest o) {
  buildCounterPauseTransferOperationRequest++;
  if (buildCounterPauseTransferOperationRequest < 3) {
  }
  buildCounterPauseTransferOperationRequest--;
}

core.int buildCounterResumeTransferOperationRequest = 0;
buildResumeTransferOperationRequest() {
  var o = new api.ResumeTransferOperationRequest();
  buildCounterResumeTransferOperationRequest++;
  if (buildCounterResumeTransferOperationRequest < 3) {
  }
  buildCounterResumeTransferOperationRequest--;
  return o;
}

checkResumeTransferOperationRequest(api.ResumeTransferOperationRequest o) {
  buildCounterResumeTransferOperationRequest++;
  if (buildCounterResumeTransferOperationRequest < 3) {
  }
  buildCounterResumeTransferOperationRequest--;
}

core.int buildCounterSchedule = 0;
buildSchedule() {
  var o = new api.Schedule();
  buildCounterSchedule++;
  if (buildCounterSchedule < 3) {
    o.scheduleEndDate = buildDate();
    o.scheduleStartDate = buildDate();
    o.startTimeOfDay = buildTimeOfDay();
  }
  buildCounterSchedule--;
  return o;
}

checkSchedule(api.Schedule o) {
  buildCounterSchedule++;
  if (buildCounterSchedule < 3) {
    checkDate(o.scheduleEndDate);
    checkDate(o.scheduleStartDate);
    checkTimeOfDay(o.startTimeOfDay);
  }
  buildCounterSchedule--;
}

buildUnnamed1213() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  o["y"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  return o;
}

checkUnnamed1213(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted5 = (o["x"]) as core.Map; unittest.expect(casted5, unittest.hasLength(3)); unittest.expect(casted5["list"], unittest.equals([1, 2, 3])); unittest.expect(casted5["bool"], unittest.equals(true)); unittest.expect(casted5["string"], unittest.equals('foo')); 
  var casted6 = (o["y"]) as core.Map; unittest.expect(casted6, unittest.hasLength(3)); unittest.expect(casted6["list"], unittest.equals([1, 2, 3])); unittest.expect(casted6["bool"], unittest.equals(true)); unittest.expect(casted6["string"], unittest.equals('foo')); 
}

buildUnnamed1214() {
  var o = new core.List<core.Map<core.String, core.Object>>();
  o.add(buildUnnamed1213());
  o.add(buildUnnamed1213());
  return o;
}

checkUnnamed1214(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed1213(o[0]);
  checkUnnamed1213(o[1]);
}

core.int buildCounterStatus = 0;
buildStatus() {
  var o = new api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed1214();
    o.message = "foo";
  }
  buildCounterStatus--;
  return o;
}

checkStatus(api.Status o) {
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    unittest.expect(o.code, unittest.equals(42));
    checkUnnamed1214(o.details);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterStatus--;
}

core.int buildCounterTimeOfDay = 0;
buildTimeOfDay() {
  var o = new api.TimeOfDay();
  buildCounterTimeOfDay++;
  if (buildCounterTimeOfDay < 3) {
    o.hours = 42;
    o.minutes = 42;
    o.nanos = 42;
    o.seconds = 42;
  }
  buildCounterTimeOfDay--;
  return o;
}

checkTimeOfDay(api.TimeOfDay o) {
  buildCounterTimeOfDay++;
  if (buildCounterTimeOfDay < 3) {
    unittest.expect(o.hours, unittest.equals(42));
    unittest.expect(o.minutes, unittest.equals(42));
    unittest.expect(o.nanos, unittest.equals(42));
    unittest.expect(o.seconds, unittest.equals(42));
  }
  buildCounterTimeOfDay--;
}

core.int buildCounterTransferCounters = 0;
buildTransferCounters() {
  var o = new api.TransferCounters();
  buildCounterTransferCounters++;
  if (buildCounterTransferCounters < 3) {
    o.bytesCopiedToSink = "foo";
    o.bytesDeletedFromSink = "foo";
    o.bytesDeletedFromSource = "foo";
    o.bytesFailedToDeleteFromSink = "foo";
    o.bytesFoundFromSource = "foo";
    o.bytesFoundOnlyFromSink = "foo";
    o.bytesFromSourceFailed = "foo";
    o.bytesFromSourceSkippedBySync = "foo";
    o.objectsCopiedToSink = "foo";
    o.objectsDeletedFromSink = "foo";
    o.objectsDeletedFromSource = "foo";
    o.objectsFailedToDeleteFromSink = "foo";
    o.objectsFoundFromSource = "foo";
    o.objectsFoundOnlyFromSink = "foo";
    o.objectsFromSourceFailed = "foo";
    o.objectsFromSourceSkippedBySync = "foo";
  }
  buildCounterTransferCounters--;
  return o;
}

checkTransferCounters(api.TransferCounters o) {
  buildCounterTransferCounters++;
  if (buildCounterTransferCounters < 3) {
    unittest.expect(o.bytesCopiedToSink, unittest.equals('foo'));
    unittest.expect(o.bytesDeletedFromSink, unittest.equals('foo'));
    unittest.expect(o.bytesDeletedFromSource, unittest.equals('foo'));
    unittest.expect(o.bytesFailedToDeleteFromSink, unittest.equals('foo'));
    unittest.expect(o.bytesFoundFromSource, unittest.equals('foo'));
    unittest.expect(o.bytesFoundOnlyFromSink, unittest.equals('foo'));
    unittest.expect(o.bytesFromSourceFailed, unittest.equals('foo'));
    unittest.expect(o.bytesFromSourceSkippedBySync, unittest.equals('foo'));
    unittest.expect(o.objectsCopiedToSink, unittest.equals('foo'));
    unittest.expect(o.objectsDeletedFromSink, unittest.equals('foo'));
    unittest.expect(o.objectsDeletedFromSource, unittest.equals('foo'));
    unittest.expect(o.objectsFailedToDeleteFromSink, unittest.equals('foo'));
    unittest.expect(o.objectsFoundFromSource, unittest.equals('foo'));
    unittest.expect(o.objectsFoundOnlyFromSink, unittest.equals('foo'));
    unittest.expect(o.objectsFromSourceFailed, unittest.equals('foo'));
    unittest.expect(o.objectsFromSourceSkippedBySync, unittest.equals('foo'));
  }
  buildCounterTransferCounters--;
}

core.int buildCounterTransferJob = 0;
buildTransferJob() {
  var o = new api.TransferJob();
  buildCounterTransferJob++;
  if (buildCounterTransferJob < 3) {
    o.creationTime = "foo";
    o.deletionTime = "foo";
    o.description = "foo";
    o.lastModificationTime = "foo";
    o.name = "foo";
    o.projectId = "foo";
    o.schedule = buildSchedule();
    o.status = "foo";
    o.transferSpec = buildTransferSpec();
  }
  buildCounterTransferJob--;
  return o;
}

checkTransferJob(api.TransferJob o) {
  buildCounterTransferJob++;
  if (buildCounterTransferJob < 3) {
    unittest.expect(o.creationTime, unittest.equals('foo'));
    unittest.expect(o.deletionTime, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.lastModificationTime, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.projectId, unittest.equals('foo'));
    checkSchedule(o.schedule);
    unittest.expect(o.status, unittest.equals('foo'));
    checkTransferSpec(o.transferSpec);
  }
  buildCounterTransferJob--;
}

buildUnnamed1215() {
  var o = new core.List<api.ErrorSummary>();
  o.add(buildErrorSummary());
  o.add(buildErrorSummary());
  return o;
}

checkUnnamed1215(core.List<api.ErrorSummary> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkErrorSummary(o[0]);
  checkErrorSummary(o[1]);
}

core.int buildCounterTransferOperation = 0;
buildTransferOperation() {
  var o = new api.TransferOperation();
  buildCounterTransferOperation++;
  if (buildCounterTransferOperation < 3) {
    o.counters = buildTransferCounters();
    o.endTime = "foo";
    o.errorBreakdowns = buildUnnamed1215();
    o.name = "foo";
    o.projectId = "foo";
    o.startTime = "foo";
    o.status = "foo";
    o.transferJobName = "foo";
    o.transferSpec = buildTransferSpec();
  }
  buildCounterTransferOperation--;
  return o;
}

checkTransferOperation(api.TransferOperation o) {
  buildCounterTransferOperation++;
  if (buildCounterTransferOperation < 3) {
    checkTransferCounters(o.counters);
    unittest.expect(o.endTime, unittest.equals('foo'));
    checkUnnamed1215(o.errorBreakdowns);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.projectId, unittest.equals('foo'));
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.transferJobName, unittest.equals('foo'));
    checkTransferSpec(o.transferSpec);
  }
  buildCounterTransferOperation--;
}

core.int buildCounterTransferOptions = 0;
buildTransferOptions() {
  var o = new api.TransferOptions();
  buildCounterTransferOptions++;
  if (buildCounterTransferOptions < 3) {
    o.deleteObjectsFromSourceAfterTransfer = true;
    o.deleteObjectsUniqueInSink = true;
    o.overwriteObjectsAlreadyExistingInSink = true;
  }
  buildCounterTransferOptions--;
  return o;
}

checkTransferOptions(api.TransferOptions o) {
  buildCounterTransferOptions++;
  if (buildCounterTransferOptions < 3) {
    unittest.expect(o.deleteObjectsFromSourceAfterTransfer, unittest.isTrue);
    unittest.expect(o.deleteObjectsUniqueInSink, unittest.isTrue);
    unittest.expect(o.overwriteObjectsAlreadyExistingInSink, unittest.isTrue);
  }
  buildCounterTransferOptions--;
}

core.int buildCounterTransferSpec = 0;
buildTransferSpec() {
  var o = new api.TransferSpec();
  buildCounterTransferSpec++;
  if (buildCounterTransferSpec < 3) {
    o.awsS3DataSource = buildAwsS3Data();
    o.gcsDataSink = buildGcsData();
    o.gcsDataSource = buildGcsData();
    o.httpDataSource = buildHttpData();
    o.objectConditions = buildObjectConditions();
    o.transferOptions = buildTransferOptions();
  }
  buildCounterTransferSpec--;
  return o;
}

checkTransferSpec(api.TransferSpec o) {
  buildCounterTransferSpec++;
  if (buildCounterTransferSpec < 3) {
    checkAwsS3Data(o.awsS3DataSource);
    checkGcsData(o.gcsDataSink);
    checkGcsData(o.gcsDataSource);
    checkHttpData(o.httpDataSource);
    checkObjectConditions(o.objectConditions);
    checkTransferOptions(o.transferOptions);
  }
  buildCounterTransferSpec--;
}

core.int buildCounterUpdateTransferJobRequest = 0;
buildUpdateTransferJobRequest() {
  var o = new api.UpdateTransferJobRequest();
  buildCounterUpdateTransferJobRequest++;
  if (buildCounterUpdateTransferJobRequest < 3) {
    o.projectId = "foo";
    o.transferJob = buildTransferJob();
    o.updateTransferJobFieldMask = "foo";
  }
  buildCounterUpdateTransferJobRequest--;
  return o;
}

checkUpdateTransferJobRequest(api.UpdateTransferJobRequest o) {
  buildCounterUpdateTransferJobRequest++;
  if (buildCounterUpdateTransferJobRequest < 3) {
    unittest.expect(o.projectId, unittest.equals('foo'));
    checkTransferJob(o.transferJob);
    unittest.expect(o.updateTransferJobFieldMask, unittest.equals('foo'));
  }
  buildCounterUpdateTransferJobRequest--;
}


main() {
  unittest.group("obj-schema-AwsAccessKey", () {
    unittest.test("to-json--from-json", () {
      var o = buildAwsAccessKey();
      var od = new api.AwsAccessKey.fromJson(o.toJson());
      checkAwsAccessKey(od);
    });
  });


  unittest.group("obj-schema-AwsS3Data", () {
    unittest.test("to-json--from-json", () {
      var o = buildAwsS3Data();
      var od = new api.AwsS3Data.fromJson(o.toJson());
      checkAwsS3Data(od);
    });
  });


  unittest.group("obj-schema-Date", () {
    unittest.test("to-json--from-json", () {
      var o = buildDate();
      var od = new api.Date.fromJson(o.toJson());
      checkDate(od);
    });
  });


  unittest.group("obj-schema-Empty", () {
    unittest.test("to-json--from-json", () {
      var o = buildEmpty();
      var od = new api.Empty.fromJson(o.toJson());
      checkEmpty(od);
    });
  });


  unittest.group("obj-schema-ErrorLogEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildErrorLogEntry();
      var od = new api.ErrorLogEntry.fromJson(o.toJson());
      checkErrorLogEntry(od);
    });
  });


  unittest.group("obj-schema-ErrorSummary", () {
    unittest.test("to-json--from-json", () {
      var o = buildErrorSummary();
      var od = new api.ErrorSummary.fromJson(o.toJson());
      checkErrorSummary(od);
    });
  });


  unittest.group("obj-schema-GcsData", () {
    unittest.test("to-json--from-json", () {
      var o = buildGcsData();
      var od = new api.GcsData.fromJson(o.toJson());
      checkGcsData(od);
    });
  });


  unittest.group("obj-schema-GoogleServiceAccount", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleServiceAccount();
      var od = new api.GoogleServiceAccount.fromJson(o.toJson());
      checkGoogleServiceAccount(od);
    });
  });


  unittest.group("obj-schema-HttpData", () {
    unittest.test("to-json--from-json", () {
      var o = buildHttpData();
      var od = new api.HttpData.fromJson(o.toJson());
      checkHttpData(od);
    });
  });


  unittest.group("obj-schema-ListOperationsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListOperationsResponse();
      var od = new api.ListOperationsResponse.fromJson(o.toJson());
      checkListOperationsResponse(od);
    });
  });


  unittest.group("obj-schema-ListTransferJobsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListTransferJobsResponse();
      var od = new api.ListTransferJobsResponse.fromJson(o.toJson());
      checkListTransferJobsResponse(od);
    });
  });


  unittest.group("obj-schema-ObjectConditions", () {
    unittest.test("to-json--from-json", () {
      var o = buildObjectConditions();
      var od = new api.ObjectConditions.fromJson(o.toJson());
      checkObjectConditions(od);
    });
  });


  unittest.group("obj-schema-Operation", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperation();
      var od = new api.Operation.fromJson(o.toJson());
      checkOperation(od);
    });
  });


  unittest.group("obj-schema-PauseTransferOperationRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildPauseTransferOperationRequest();
      var od = new api.PauseTransferOperationRequest.fromJson(o.toJson());
      checkPauseTransferOperationRequest(od);
    });
  });


  unittest.group("obj-schema-ResumeTransferOperationRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildResumeTransferOperationRequest();
      var od = new api.ResumeTransferOperationRequest.fromJson(o.toJson());
      checkResumeTransferOperationRequest(od);
    });
  });


  unittest.group("obj-schema-Schedule", () {
    unittest.test("to-json--from-json", () {
      var o = buildSchedule();
      var od = new api.Schedule.fromJson(o.toJson());
      checkSchedule(od);
    });
  });


  unittest.group("obj-schema-Status", () {
    unittest.test("to-json--from-json", () {
      var o = buildStatus();
      var od = new api.Status.fromJson(o.toJson());
      checkStatus(od);
    });
  });


  unittest.group("obj-schema-TimeOfDay", () {
    unittest.test("to-json--from-json", () {
      var o = buildTimeOfDay();
      var od = new api.TimeOfDay.fromJson(o.toJson());
      checkTimeOfDay(od);
    });
  });


  unittest.group("obj-schema-TransferCounters", () {
    unittest.test("to-json--from-json", () {
      var o = buildTransferCounters();
      var od = new api.TransferCounters.fromJson(o.toJson());
      checkTransferCounters(od);
    });
  });


  unittest.group("obj-schema-TransferJob", () {
    unittest.test("to-json--from-json", () {
      var o = buildTransferJob();
      var od = new api.TransferJob.fromJson(o.toJson());
      checkTransferJob(od);
    });
  });


  unittest.group("obj-schema-TransferOperation", () {
    unittest.test("to-json--from-json", () {
      var o = buildTransferOperation();
      var od = new api.TransferOperation.fromJson(o.toJson());
      checkTransferOperation(od);
    });
  });


  unittest.group("obj-schema-TransferOptions", () {
    unittest.test("to-json--from-json", () {
      var o = buildTransferOptions();
      var od = new api.TransferOptions.fromJson(o.toJson());
      checkTransferOptions(od);
    });
  });


  unittest.group("obj-schema-TransferSpec", () {
    unittest.test("to-json--from-json", () {
      var o = buildTransferSpec();
      var od = new api.TransferSpec.fromJson(o.toJson());
      checkTransferSpec(od);
    });
  });


  unittest.group("obj-schema-UpdateTransferJobRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateTransferJobRequest();
      var od = new api.UpdateTransferJobRequest.fromJson(o.toJson());
      checkUpdateTransferJobRequest(od);
    });
  });


  unittest.group("resource-GoogleServiceAccountsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.GoogleServiceAccountsResourceApi res = new api.StoragetransferApi(mock).googleServiceAccounts;
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 25), unittest.equals("v1/googleServiceAccounts/"));
        pathOffset += 25;
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
        var resp = convert.JSON.encode(buildGoogleServiceAccount());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_projectId).then(unittest.expectAsync(((api.GoogleServiceAccount response) {
        checkGoogleServiceAccount(response);
      })));
    });

  });


  unittest.group("resource-TransferJobsResourceApi", () {
    unittest.test("method--create", () {

      var mock = new HttpServerMock();
      api.TransferJobsResourceApi res = new api.StoragetransferApi(mock).transferJobs;
      var arg_request = buildTransferJob();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.TransferJob.fromJson(json);
        checkTransferJob(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("v1/transferJobs"));
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
        var resp = convert.JSON.encode(buildTransferJob());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.create(arg_request).then(unittest.expectAsync(((api.TransferJob response) {
        checkTransferJob(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.TransferJobsResourceApi res = new api.StoragetransferApi(mock).transferJobs;
      var arg_jobName = "foo";
      var arg_projectId = "foo";
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
        unittest.expect(queryMap["projectId"].first, unittest.equals(arg_projectId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTransferJob());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_jobName, projectId: arg_projectId).then(unittest.expectAsync(((api.TransferJob response) {
        checkTransferJob(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.TransferJobsResourceApi res = new api.StoragetransferApi(mock).transferJobs;
      var arg_filter = "foo";
      var arg_pageSize = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("v1/transferJobs"));
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
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListTransferJobsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(filter: arg_filter, pageSize: arg_pageSize, pageToken: arg_pageToken).then(unittest.expectAsync(((api.ListTransferJobsResponse response) {
        checkListTransferJobsResponse(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.TransferJobsResourceApi res = new api.StoragetransferApi(mock).transferJobs;
      var arg_request = buildUpdateTransferJobRequest();
      var arg_jobName = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.UpdateTransferJobRequest.fromJson(json);
        checkUpdateTransferJobRequest(obj);

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
        var resp = convert.JSON.encode(buildTransferJob());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_jobName).then(unittest.expectAsync(((api.TransferJob response) {
        checkTransferJob(response);
      })));
    });

  });


  unittest.group("resource-TransferOperationsResourceApi", () {
    unittest.test("method--cancel", () {

      var mock = new HttpServerMock();
      api.TransferOperationsResourceApi res = new api.StoragetransferApi(mock).transferOperations;
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
      res.cancel(arg_name).then(unittest.expectAsync(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.TransferOperationsResourceApi res = new api.StoragetransferApi(mock).transferOperations;
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

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.TransferOperationsResourceApi res = new api.StoragetransferApi(mock).transferOperations;
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

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.TransferOperationsResourceApi res = new api.StoragetransferApi(mock).transferOperations;
      var arg_name = "foo";
      var arg_filter = "foo";
      var arg_pageSize = 42;
      var arg_pageToken = "foo";
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
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListOperationsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_name, filter: arg_filter, pageSize: arg_pageSize, pageToken: arg_pageToken).then(unittest.expectAsync(((api.ListOperationsResponse response) {
        checkListOperationsResponse(response);
      })));
    });

    unittest.test("method--pause", () {

      var mock = new HttpServerMock();
      api.TransferOperationsResourceApi res = new api.StoragetransferApi(mock).transferOperations;
      var arg_request = buildPauseTransferOperationRequest();
      var arg_name = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.PauseTransferOperationRequest.fromJson(json);
        checkPauseTransferOperationRequest(obj);

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
      res.pause(arg_request, arg_name).then(unittest.expectAsync(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--resume", () {

      var mock = new HttpServerMock();
      api.TransferOperationsResourceApi res = new api.StoragetransferApi(mock).transferOperations;
      var arg_request = buildResumeTransferOperationRequest();
      var arg_name = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ResumeTransferOperationRequest.fromJson(json);
        checkResumeTransferOperationRequest(obj);

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
      res.resume(arg_request, arg_name).then(unittest.expectAsync(((api.Empty response) {
        checkEmpty(response);
      })));
    });

  });


  unittest.group("resource-V1ResourceApi", () {
    unittest.test("method--getGoogleServiceAccount", () {

      var mock = new HttpServerMock();
      api.V1ResourceApi res = new api.StoragetransferApi(mock).v1;
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 26), unittest.equals("v1:getGoogleServiceAccount"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["projectId"].first, unittest.equals(arg_projectId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildGoogleServiceAccount());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getGoogleServiceAccount(projectId: arg_projectId).then(unittest.expectAsync(((api.GoogleServiceAccount response) {
        checkGoogleServiceAccount(response);
      })));
    });

  });


}

