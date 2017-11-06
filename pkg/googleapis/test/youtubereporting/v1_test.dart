library googleapis.youtubereporting.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/youtubereporting/v1.dart' as api;

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

core.int buildCounterJob = 0;
buildJob() {
  var o = new api.Job();
  buildCounterJob++;
  if (buildCounterJob < 3) {
    o.createTime = "foo";
    o.expireTime = "foo";
    o.id = "foo";
    o.name = "foo";
    o.reportTypeId = "foo";
    o.systemManaged = true;
  }
  buildCounterJob--;
  return o;
}

checkJob(api.Job o) {
  buildCounterJob++;
  if (buildCounterJob < 3) {
    unittest.expect(o.createTime, unittest.equals('foo'));
    unittest.expect(o.expireTime, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.reportTypeId, unittest.equals('foo'));
    unittest.expect(o.systemManaged, unittest.isTrue);
  }
  buildCounterJob--;
}

buildUnnamed970() {
  var o = new core.List<api.Job>();
  o.add(buildJob());
  o.add(buildJob());
  return o;
}

checkUnnamed970(core.List<api.Job> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkJob(o[0]);
  checkJob(o[1]);
}

core.int buildCounterListJobsResponse = 0;
buildListJobsResponse() {
  var o = new api.ListJobsResponse();
  buildCounterListJobsResponse++;
  if (buildCounterListJobsResponse < 3) {
    o.jobs = buildUnnamed970();
    o.nextPageToken = "foo";
  }
  buildCounterListJobsResponse--;
  return o;
}

checkListJobsResponse(api.ListJobsResponse o) {
  buildCounterListJobsResponse++;
  if (buildCounterListJobsResponse < 3) {
    checkUnnamed970(o.jobs);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListJobsResponse--;
}

buildUnnamed971() {
  var o = new core.List<api.ReportType>();
  o.add(buildReportType());
  o.add(buildReportType());
  return o;
}

checkUnnamed971(core.List<api.ReportType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReportType(o[0]);
  checkReportType(o[1]);
}

core.int buildCounterListReportTypesResponse = 0;
buildListReportTypesResponse() {
  var o = new api.ListReportTypesResponse();
  buildCounterListReportTypesResponse++;
  if (buildCounterListReportTypesResponse < 3) {
    o.nextPageToken = "foo";
    o.reportTypes = buildUnnamed971();
  }
  buildCounterListReportTypesResponse--;
  return o;
}

checkListReportTypesResponse(api.ListReportTypesResponse o) {
  buildCounterListReportTypesResponse++;
  if (buildCounterListReportTypesResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed971(o.reportTypes);
  }
  buildCounterListReportTypesResponse--;
}

buildUnnamed972() {
  var o = new core.List<api.Report>();
  o.add(buildReport());
  o.add(buildReport());
  return o;
}

checkUnnamed972(core.List<api.Report> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReport(o[0]);
  checkReport(o[1]);
}

core.int buildCounterListReportsResponse = 0;
buildListReportsResponse() {
  var o = new api.ListReportsResponse();
  buildCounterListReportsResponse++;
  if (buildCounterListReportsResponse < 3) {
    o.nextPageToken = "foo";
    o.reports = buildUnnamed972();
  }
  buildCounterListReportsResponse--;
  return o;
}

checkListReportsResponse(api.ListReportsResponse o) {
  buildCounterListReportsResponse++;
  if (buildCounterListReportsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed972(o.reports);
  }
  buildCounterListReportsResponse--;
}

core.int buildCounterMedia = 0;
buildMedia() {
  var o = new api.Media();
  buildCounterMedia++;
  if (buildCounterMedia < 3) {
    o.resourceName = "foo";
  }
  buildCounterMedia--;
  return o;
}

checkMedia(api.Media o) {
  buildCounterMedia++;
  if (buildCounterMedia < 3) {
    unittest.expect(o.resourceName, unittest.equals('foo'));
  }
  buildCounterMedia--;
}

core.int buildCounterReport = 0;
buildReport() {
  var o = new api.Report();
  buildCounterReport++;
  if (buildCounterReport < 3) {
    o.createTime = "foo";
    o.downloadUrl = "foo";
    o.endTime = "foo";
    o.id = "foo";
    o.jobExpireTime = "foo";
    o.jobId = "foo";
    o.startTime = "foo";
  }
  buildCounterReport--;
  return o;
}

checkReport(api.Report o) {
  buildCounterReport++;
  if (buildCounterReport < 3) {
    unittest.expect(o.createTime, unittest.equals('foo'));
    unittest.expect(o.downloadUrl, unittest.equals('foo'));
    unittest.expect(o.endTime, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.jobExpireTime, unittest.equals('foo'));
    unittest.expect(o.jobId, unittest.equals('foo'));
    unittest.expect(o.startTime, unittest.equals('foo'));
  }
  buildCounterReport--;
}

core.int buildCounterReportType = 0;
buildReportType() {
  var o = new api.ReportType();
  buildCounterReportType++;
  if (buildCounterReportType < 3) {
    o.deprecateTime = "foo";
    o.id = "foo";
    o.name = "foo";
    o.systemManaged = true;
  }
  buildCounterReportType--;
  return o;
}

checkReportType(api.ReportType o) {
  buildCounterReportType++;
  if (buildCounterReportType < 3) {
    unittest.expect(o.deprecateTime, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.systemManaged, unittest.isTrue);
  }
  buildCounterReportType--;
}


main() {
  unittest.group("obj-schema-Empty", () {
    unittest.test("to-json--from-json", () {
      var o = buildEmpty();
      var od = new api.Empty.fromJson(o.toJson());
      checkEmpty(od);
    });
  });


  unittest.group("obj-schema-Job", () {
    unittest.test("to-json--from-json", () {
      var o = buildJob();
      var od = new api.Job.fromJson(o.toJson());
      checkJob(od);
    });
  });


  unittest.group("obj-schema-ListJobsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListJobsResponse();
      var od = new api.ListJobsResponse.fromJson(o.toJson());
      checkListJobsResponse(od);
    });
  });


  unittest.group("obj-schema-ListReportTypesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListReportTypesResponse();
      var od = new api.ListReportTypesResponse.fromJson(o.toJson());
      checkListReportTypesResponse(od);
    });
  });


  unittest.group("obj-schema-ListReportsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListReportsResponse();
      var od = new api.ListReportsResponse.fromJson(o.toJson());
      checkListReportsResponse(od);
    });
  });


  unittest.group("obj-schema-Media", () {
    unittest.test("to-json--from-json", () {
      var o = buildMedia();
      var od = new api.Media.fromJson(o.toJson());
      checkMedia(od);
    });
  });


  unittest.group("obj-schema-Report", () {
    unittest.test("to-json--from-json", () {
      var o = buildReport();
      var od = new api.Report.fromJson(o.toJson());
      checkReport(od);
    });
  });


  unittest.group("obj-schema-ReportType", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportType();
      var od = new api.ReportType.fromJson(o.toJson());
      checkReportType(od);
    });
  });


  unittest.group("resource-JobsResourceApi", () {
    unittest.test("method--create", () {

      var mock = new HttpServerMock();
      api.JobsResourceApi res = new api.YoutubereportingApi(mock).jobs;
      var arg_request = buildJob();
      var arg_onBehalfOfContentOwner = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Job.fromJson(json);
        checkJob(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("v1/jobs"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["onBehalfOfContentOwner"].first, unittest.equals(arg_onBehalfOfContentOwner));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildJob());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.create(arg_request, onBehalfOfContentOwner: arg_onBehalfOfContentOwner).then(unittest.expectAsync(((api.Job response) {
        checkJob(response);
      })));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.JobsResourceApi res = new api.YoutubereportingApi(mock).jobs;
      var arg_jobId = "foo";
      var arg_onBehalfOfContentOwner = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("v1/jobs/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_jobId"));

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
        unittest.expect(queryMap["onBehalfOfContentOwner"].first, unittest.equals(arg_onBehalfOfContentOwner));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_jobId, onBehalfOfContentOwner: arg_onBehalfOfContentOwner).then(unittest.expectAsync(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.JobsResourceApi res = new api.YoutubereportingApi(mock).jobs;
      var arg_jobId = "foo";
      var arg_onBehalfOfContentOwner = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("v1/jobs/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_jobId"));

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
        unittest.expect(queryMap["onBehalfOfContentOwner"].first, unittest.equals(arg_onBehalfOfContentOwner));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildJob());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_jobId, onBehalfOfContentOwner: arg_onBehalfOfContentOwner).then(unittest.expectAsync(((api.Job response) {
        checkJob(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.JobsResourceApi res = new api.YoutubereportingApi(mock).jobs;
      var arg_pageToken = "foo";
      var arg_includeSystemManaged = true;
      var arg_pageSize = 42;
      var arg_onBehalfOfContentOwner = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("v1/jobs"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["includeSystemManaged"].first, unittest.equals("$arg_includeSystemManaged"));
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));
        unittest.expect(queryMap["onBehalfOfContentOwner"].first, unittest.equals(arg_onBehalfOfContentOwner));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListJobsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(pageToken: arg_pageToken, includeSystemManaged: arg_includeSystemManaged, pageSize: arg_pageSize, onBehalfOfContentOwner: arg_onBehalfOfContentOwner).then(unittest.expectAsync(((api.ListJobsResponse response) {
        checkListJobsResponse(response);
      })));
    });

  });


  unittest.group("resource-JobsReportsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.JobsReportsResourceApi res = new api.YoutubereportingApi(mock).jobs.reports;
      var arg_jobId = "foo";
      var arg_reportId = "foo";
      var arg_onBehalfOfContentOwner = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("v1/jobs/"));
        pathOffset += 8;
        index = path.indexOf("/reports/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_jobId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/reports/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_reportId"));

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
        unittest.expect(queryMap["onBehalfOfContentOwner"].first, unittest.equals(arg_onBehalfOfContentOwner));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildReport());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_jobId, arg_reportId, onBehalfOfContentOwner: arg_onBehalfOfContentOwner).then(unittest.expectAsync(((api.Report response) {
        checkReport(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.JobsReportsResourceApi res = new api.YoutubereportingApi(mock).jobs.reports;
      var arg_jobId = "foo";
      var arg_onBehalfOfContentOwner = "foo";
      var arg_startTimeBefore = "foo";
      var arg_createdAfter = "foo";
      var arg_startTimeAtOrAfter = "foo";
      var arg_pageToken = "foo";
      var arg_pageSize = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("v1/jobs/"));
        pathOffset += 8;
        index = path.indexOf("/reports", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_jobId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/reports"));
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
        unittest.expect(queryMap["onBehalfOfContentOwner"].first, unittest.equals(arg_onBehalfOfContentOwner));
        unittest.expect(queryMap["startTimeBefore"].first, unittest.equals(arg_startTimeBefore));
        unittest.expect(queryMap["createdAfter"].first, unittest.equals(arg_createdAfter));
        unittest.expect(queryMap["startTimeAtOrAfter"].first, unittest.equals(arg_startTimeAtOrAfter));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListReportsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_jobId, onBehalfOfContentOwner: arg_onBehalfOfContentOwner, startTimeBefore: arg_startTimeBefore, createdAfter: arg_createdAfter, startTimeAtOrAfter: arg_startTimeAtOrAfter, pageToken: arg_pageToken, pageSize: arg_pageSize).then(unittest.expectAsync(((api.ListReportsResponse response) {
        checkListReportsResponse(response);
      })));
    });

  });


  unittest.group("resource-MediaResourceApi", () {
    unittest.test("method--download", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.MediaResourceApi res = new api.YoutubereportingApi(mock).media;
      var arg_resourceName = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("v1/media/"));
        pathOffset += 9;
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
        var resp = convert.JSON.encode(buildMedia());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.download(arg_resourceName).then(unittest.expectAsync(((api.Media response) {
        checkMedia(response);
      })));
    });

  });


  unittest.group("resource-ReportTypesResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.ReportTypesResourceApi res = new api.YoutubereportingApi(mock).reportTypes;
      var arg_onBehalfOfContentOwner = "foo";
      var arg_pageToken = "foo";
      var arg_includeSystemManaged = true;
      var arg_pageSize = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("v1/reportTypes"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["onBehalfOfContentOwner"].first, unittest.equals(arg_onBehalfOfContentOwner));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["includeSystemManaged"].first, unittest.equals("$arg_includeSystemManaged"));
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListReportTypesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(onBehalfOfContentOwner: arg_onBehalfOfContentOwner, pageToken: arg_pageToken, includeSystemManaged: arg_includeSystemManaged, pageSize: arg_pageSize).then(unittest.expectAsync(((api.ListReportTypesResponse response) {
        checkListReportTypesResponse(response);
      })));
    });

  });


}

