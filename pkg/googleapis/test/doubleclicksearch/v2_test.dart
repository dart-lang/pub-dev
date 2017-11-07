library googleapis.doubleclicksearch.v2.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/doubleclicksearch/v2.dart' as api;

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

core.int buildCounterAvailability = 0;
buildAvailability() {
  var o = new api.Availability();
  buildCounterAvailability++;
  if (buildCounterAvailability < 3) {
    o.advertiserId = "foo";
    o.agencyId = "foo";
    o.availabilityTimestamp = "foo";
    o.segmentationId = "foo";
    o.segmentationName = "foo";
    o.segmentationType = "foo";
  }
  buildCounterAvailability--;
  return o;
}

checkAvailability(api.Availability o) {
  buildCounterAvailability++;
  if (buildCounterAvailability < 3) {
    unittest.expect(o.advertiserId, unittest.equals('foo'));
    unittest.expect(o.agencyId, unittest.equals('foo'));
    unittest.expect(o.availabilityTimestamp, unittest.equals('foo'));
    unittest.expect(o.segmentationId, unittest.equals('foo'));
    unittest.expect(o.segmentationName, unittest.equals('foo'));
    unittest.expect(o.segmentationType, unittest.equals('foo'));
  }
  buildCounterAvailability--;
}

buildUnnamed1235() {
  var o = new core.List<api.CustomDimension>();
  o.add(buildCustomDimension());
  o.add(buildCustomDimension());
  return o;
}

checkUnnamed1235(core.List<api.CustomDimension> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCustomDimension(o[0]);
  checkCustomDimension(o[1]);
}

buildUnnamed1236() {
  var o = new core.List<api.CustomMetric>();
  o.add(buildCustomMetric());
  o.add(buildCustomMetric());
  return o;
}

checkUnnamed1236(core.List<api.CustomMetric> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCustomMetric(o[0]);
  checkCustomMetric(o[1]);
}

core.int buildCounterConversion = 0;
buildConversion() {
  var o = new api.Conversion();
  buildCounterConversion++;
  if (buildCounterConversion < 3) {
    o.adGroupId = "foo";
    o.adId = "foo";
    o.advertiserId = "foo";
    o.agencyId = "foo";
    o.attributionModel = "foo";
    o.campaignId = "foo";
    o.channel = "foo";
    o.clickId = "foo";
    o.conversionId = "foo";
    o.conversionModifiedTimestamp = "foo";
    o.conversionTimestamp = "foo";
    o.countMillis = "foo";
    o.criterionId = "foo";
    o.currencyCode = "foo";
    o.customDimension = buildUnnamed1235();
    o.customMetric = buildUnnamed1236();
    o.deviceType = "foo";
    o.dsConversionId = "foo";
    o.engineAccountId = "foo";
    o.floodlightOrderId = "foo";
    o.inventoryAccountId = "foo";
    o.productCountry = "foo";
    o.productGroupId = "foo";
    o.productId = "foo";
    o.productLanguage = "foo";
    o.quantityMillis = "foo";
    o.revenueMicros = "foo";
    o.segmentationId = "foo";
    o.segmentationName = "foo";
    o.segmentationType = "foo";
    o.state = "foo";
    o.storeId = "foo";
    o.type = "foo";
  }
  buildCounterConversion--;
  return o;
}

checkConversion(api.Conversion o) {
  buildCounterConversion++;
  if (buildCounterConversion < 3) {
    unittest.expect(o.adGroupId, unittest.equals('foo'));
    unittest.expect(o.adId, unittest.equals('foo'));
    unittest.expect(o.advertiserId, unittest.equals('foo'));
    unittest.expect(o.agencyId, unittest.equals('foo'));
    unittest.expect(o.attributionModel, unittest.equals('foo'));
    unittest.expect(o.campaignId, unittest.equals('foo'));
    unittest.expect(o.channel, unittest.equals('foo'));
    unittest.expect(o.clickId, unittest.equals('foo'));
    unittest.expect(o.conversionId, unittest.equals('foo'));
    unittest.expect(o.conversionModifiedTimestamp, unittest.equals('foo'));
    unittest.expect(o.conversionTimestamp, unittest.equals('foo'));
    unittest.expect(o.countMillis, unittest.equals('foo'));
    unittest.expect(o.criterionId, unittest.equals('foo'));
    unittest.expect(o.currencyCode, unittest.equals('foo'));
    checkUnnamed1235(o.customDimension);
    checkUnnamed1236(o.customMetric);
    unittest.expect(o.deviceType, unittest.equals('foo'));
    unittest.expect(o.dsConversionId, unittest.equals('foo'));
    unittest.expect(o.engineAccountId, unittest.equals('foo'));
    unittest.expect(o.floodlightOrderId, unittest.equals('foo'));
    unittest.expect(o.inventoryAccountId, unittest.equals('foo'));
    unittest.expect(o.productCountry, unittest.equals('foo'));
    unittest.expect(o.productGroupId, unittest.equals('foo'));
    unittest.expect(o.productId, unittest.equals('foo'));
    unittest.expect(o.productLanguage, unittest.equals('foo'));
    unittest.expect(o.quantityMillis, unittest.equals('foo'));
    unittest.expect(o.revenueMicros, unittest.equals('foo'));
    unittest.expect(o.segmentationId, unittest.equals('foo'));
    unittest.expect(o.segmentationName, unittest.equals('foo'));
    unittest.expect(o.segmentationType, unittest.equals('foo'));
    unittest.expect(o.state, unittest.equals('foo'));
    unittest.expect(o.storeId, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterConversion--;
}

buildUnnamed1237() {
  var o = new core.List<api.Conversion>();
  o.add(buildConversion());
  o.add(buildConversion());
  return o;
}

checkUnnamed1237(core.List<api.Conversion> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkConversion(o[0]);
  checkConversion(o[1]);
}

core.int buildCounterConversionList = 0;
buildConversionList() {
  var o = new api.ConversionList();
  buildCounterConversionList++;
  if (buildCounterConversionList < 3) {
    o.conversion = buildUnnamed1237();
    o.kind = "foo";
  }
  buildCounterConversionList--;
  return o;
}

checkConversionList(api.ConversionList o) {
  buildCounterConversionList++;
  if (buildCounterConversionList < 3) {
    checkUnnamed1237(o.conversion);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterConversionList--;
}

core.int buildCounterCustomDimension = 0;
buildCustomDimension() {
  var o = new api.CustomDimension();
  buildCounterCustomDimension++;
  if (buildCounterCustomDimension < 3) {
    o.name = "foo";
    o.value = "foo";
  }
  buildCounterCustomDimension--;
  return o;
}

checkCustomDimension(api.CustomDimension o) {
  buildCounterCustomDimension++;
  if (buildCounterCustomDimension < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterCustomDimension--;
}

core.int buildCounterCustomMetric = 0;
buildCustomMetric() {
  var o = new api.CustomMetric();
  buildCounterCustomMetric++;
  if (buildCounterCustomMetric < 3) {
    o.name = "foo";
    o.value = 42.0;
  }
  buildCounterCustomMetric--;
  return o;
}

checkCustomMetric(api.CustomMetric o) {
  buildCounterCustomMetric++;
  if (buildCounterCustomMetric < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals(42.0));
  }
  buildCounterCustomMetric--;
}

core.int buildCounterReportFiles = 0;
buildReportFiles() {
  var o = new api.ReportFiles();
  buildCounterReportFiles++;
  if (buildCounterReportFiles < 3) {
    o.byteCount = "foo";
    o.url = "foo";
  }
  buildCounterReportFiles--;
  return o;
}

checkReportFiles(api.ReportFiles o) {
  buildCounterReportFiles++;
  if (buildCounterReportFiles < 3) {
    unittest.expect(o.byteCount, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterReportFiles--;
}

buildUnnamed1238() {
  var o = new core.List<api.ReportFiles>();
  o.add(buildReportFiles());
  o.add(buildReportFiles());
  return o;
}

checkUnnamed1238(core.List<api.ReportFiles> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReportFiles(o[0]);
  checkReportFiles(o[1]);
}

buildUnnamed1239() {
  var o = new core.List<api.ReportRow>();
  o.add(buildReportRow());
  o.add(buildReportRow());
  return o;
}

checkUnnamed1239(core.List<api.ReportRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReportRow(o[0]);
  checkReportRow(o[1]);
}

core.int buildCounterReport = 0;
buildReport() {
  var o = new api.Report();
  buildCounterReport++;
  if (buildCounterReport < 3) {
    o.files = buildUnnamed1238();
    o.id = "foo";
    o.isReportReady = true;
    o.kind = "foo";
    o.request = buildReportRequest();
    o.rowCount = 42;
    o.rows = buildUnnamed1239();
    o.statisticsCurrencyCode = "foo";
    o.statisticsTimeZone = "foo";
  }
  buildCounterReport--;
  return o;
}

checkReport(api.Report o) {
  buildCounterReport++;
  if (buildCounterReport < 3) {
    checkUnnamed1238(o.files);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.isReportReady, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkReportRequest(o.request);
    unittest.expect(o.rowCount, unittest.equals(42));
    checkUnnamed1239(o.rows);
    unittest.expect(o.statisticsCurrencyCode, unittest.equals('foo'));
    unittest.expect(o.statisticsTimeZone, unittest.equals('foo'));
  }
  buildCounterReport--;
}

core.int buildCounterReportApiColumnSpec = 0;
buildReportApiColumnSpec() {
  var o = new api.ReportApiColumnSpec();
  buildCounterReportApiColumnSpec++;
  if (buildCounterReportApiColumnSpec < 3) {
    o.columnName = "foo";
    o.customDimensionName = "foo";
    o.customMetricName = "foo";
    o.endDate = "foo";
    o.groupByColumn = true;
    o.headerText = "foo";
    o.platformSource = "foo";
    o.productReportPerspective = "foo";
    o.savedColumnName = "foo";
    o.startDate = "foo";
  }
  buildCounterReportApiColumnSpec--;
  return o;
}

checkReportApiColumnSpec(api.ReportApiColumnSpec o) {
  buildCounterReportApiColumnSpec++;
  if (buildCounterReportApiColumnSpec < 3) {
    unittest.expect(o.columnName, unittest.equals('foo'));
    unittest.expect(o.customDimensionName, unittest.equals('foo'));
    unittest.expect(o.customMetricName, unittest.equals('foo'));
    unittest.expect(o.endDate, unittest.equals('foo'));
    unittest.expect(o.groupByColumn, unittest.isTrue);
    unittest.expect(o.headerText, unittest.equals('foo'));
    unittest.expect(o.platformSource, unittest.equals('foo'));
    unittest.expect(o.productReportPerspective, unittest.equals('foo'));
    unittest.expect(o.savedColumnName, unittest.equals('foo'));
    unittest.expect(o.startDate, unittest.equals('foo'));
  }
  buildCounterReportApiColumnSpec--;
}

buildUnnamed1240() {
  var o = new core.List<api.ReportApiColumnSpec>();
  o.add(buildReportApiColumnSpec());
  o.add(buildReportApiColumnSpec());
  return o;
}

checkUnnamed1240(core.List<api.ReportApiColumnSpec> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReportApiColumnSpec(o[0]);
  checkReportApiColumnSpec(o[1]);
}

buildUnnamed1241() {
  var o = new core.List<core.Object>();
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  return o;
}

checkUnnamed1241(core.List<core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o[0]) as core.Map; unittest.expect(casted1, unittest.hasLength(3)); unittest.expect(casted1["list"], unittest.equals([1, 2, 3])); unittest.expect(casted1["bool"], unittest.equals(true)); unittest.expect(casted1["string"], unittest.equals('foo')); 
  var casted2 = (o[1]) as core.Map; unittest.expect(casted2, unittest.hasLength(3)); unittest.expect(casted2["list"], unittest.equals([1, 2, 3])); unittest.expect(casted2["bool"], unittest.equals(true)); unittest.expect(casted2["string"], unittest.equals('foo')); 
}

core.int buildCounterReportRequestFilters = 0;
buildReportRequestFilters() {
  var o = new api.ReportRequestFilters();
  buildCounterReportRequestFilters++;
  if (buildCounterReportRequestFilters < 3) {
    o.column = buildReportApiColumnSpec();
    o.operator = "foo";
    o.values = buildUnnamed1241();
  }
  buildCounterReportRequestFilters--;
  return o;
}

checkReportRequestFilters(api.ReportRequestFilters o) {
  buildCounterReportRequestFilters++;
  if (buildCounterReportRequestFilters < 3) {
    checkReportApiColumnSpec(o.column);
    unittest.expect(o.operator, unittest.equals('foo'));
    checkUnnamed1241(o.values);
  }
  buildCounterReportRequestFilters--;
}

buildUnnamed1242() {
  var o = new core.List<api.ReportRequestFilters>();
  o.add(buildReportRequestFilters());
  o.add(buildReportRequestFilters());
  return o;
}

checkUnnamed1242(core.List<api.ReportRequestFilters> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReportRequestFilters(o[0]);
  checkReportRequestFilters(o[1]);
}

core.int buildCounterReportRequestOrderBy = 0;
buildReportRequestOrderBy() {
  var o = new api.ReportRequestOrderBy();
  buildCounterReportRequestOrderBy++;
  if (buildCounterReportRequestOrderBy < 3) {
    o.column = buildReportApiColumnSpec();
    o.sortOrder = "foo";
  }
  buildCounterReportRequestOrderBy--;
  return o;
}

checkReportRequestOrderBy(api.ReportRequestOrderBy o) {
  buildCounterReportRequestOrderBy++;
  if (buildCounterReportRequestOrderBy < 3) {
    checkReportApiColumnSpec(o.column);
    unittest.expect(o.sortOrder, unittest.equals('foo'));
  }
  buildCounterReportRequestOrderBy--;
}

buildUnnamed1243() {
  var o = new core.List<api.ReportRequestOrderBy>();
  o.add(buildReportRequestOrderBy());
  o.add(buildReportRequestOrderBy());
  return o;
}

checkUnnamed1243(core.List<api.ReportRequestOrderBy> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReportRequestOrderBy(o[0]);
  checkReportRequestOrderBy(o[1]);
}

core.int buildCounterReportRequestReportScope = 0;
buildReportRequestReportScope() {
  var o = new api.ReportRequestReportScope();
  buildCounterReportRequestReportScope++;
  if (buildCounterReportRequestReportScope < 3) {
    o.adGroupId = "foo";
    o.adId = "foo";
    o.advertiserId = "foo";
    o.agencyId = "foo";
    o.campaignId = "foo";
    o.engineAccountId = "foo";
    o.keywordId = "foo";
  }
  buildCounterReportRequestReportScope--;
  return o;
}

checkReportRequestReportScope(api.ReportRequestReportScope o) {
  buildCounterReportRequestReportScope++;
  if (buildCounterReportRequestReportScope < 3) {
    unittest.expect(o.adGroupId, unittest.equals('foo'));
    unittest.expect(o.adId, unittest.equals('foo'));
    unittest.expect(o.advertiserId, unittest.equals('foo'));
    unittest.expect(o.agencyId, unittest.equals('foo'));
    unittest.expect(o.campaignId, unittest.equals('foo'));
    unittest.expect(o.engineAccountId, unittest.equals('foo'));
    unittest.expect(o.keywordId, unittest.equals('foo'));
  }
  buildCounterReportRequestReportScope--;
}

core.int buildCounterReportRequestTimeRange = 0;
buildReportRequestTimeRange() {
  var o = new api.ReportRequestTimeRange();
  buildCounterReportRequestTimeRange++;
  if (buildCounterReportRequestTimeRange < 3) {
    o.changedAttributesSinceTimestamp = core.DateTime.parse("2002-02-27T14:01:02");
    o.changedMetricsSinceTimestamp = core.DateTime.parse("2002-02-27T14:01:02");
    o.endDate = "foo";
    o.startDate = "foo";
  }
  buildCounterReportRequestTimeRange--;
  return o;
}

checkReportRequestTimeRange(api.ReportRequestTimeRange o) {
  buildCounterReportRequestTimeRange++;
  if (buildCounterReportRequestTimeRange < 3) {
    unittest.expect(o.changedAttributesSinceTimestamp, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.changedMetricsSinceTimestamp, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.endDate, unittest.equals('foo'));
    unittest.expect(o.startDate, unittest.equals('foo'));
  }
  buildCounterReportRequestTimeRange--;
}

core.int buildCounterReportRequest = 0;
buildReportRequest() {
  var o = new api.ReportRequest();
  buildCounterReportRequest++;
  if (buildCounterReportRequest < 3) {
    o.columns = buildUnnamed1240();
    o.downloadFormat = "foo";
    o.filters = buildUnnamed1242();
    o.includeDeletedEntities = true;
    o.includeRemovedEntities = true;
    o.maxRowsPerFile = 42;
    o.orderBy = buildUnnamed1243();
    o.reportScope = buildReportRequestReportScope();
    o.reportType = "foo";
    o.rowCount = 42;
    o.startRow = 42;
    o.statisticsCurrency = "foo";
    o.timeRange = buildReportRequestTimeRange();
    o.verifySingleTimeZone = true;
  }
  buildCounterReportRequest--;
  return o;
}

checkReportRequest(api.ReportRequest o) {
  buildCounterReportRequest++;
  if (buildCounterReportRequest < 3) {
    checkUnnamed1240(o.columns);
    unittest.expect(o.downloadFormat, unittest.equals('foo'));
    checkUnnamed1242(o.filters);
    unittest.expect(o.includeDeletedEntities, unittest.isTrue);
    unittest.expect(o.includeRemovedEntities, unittest.isTrue);
    unittest.expect(o.maxRowsPerFile, unittest.equals(42));
    checkUnnamed1243(o.orderBy);
    checkReportRequestReportScope(o.reportScope);
    unittest.expect(o.reportType, unittest.equals('foo'));
    unittest.expect(o.rowCount, unittest.equals(42));
    unittest.expect(o.startRow, unittest.equals(42));
    unittest.expect(o.statisticsCurrency, unittest.equals('foo'));
    checkReportRequestTimeRange(o.timeRange);
    unittest.expect(o.verifySingleTimeZone, unittest.isTrue);
  }
  buildCounterReportRequest--;
}

buildReportRow() {
  var o = new api.ReportRow();
  o["a"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  o["b"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  return o;
}

checkReportRow(api.ReportRow o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted3 = (o["a"]) as core.Map; unittest.expect(casted3, unittest.hasLength(3)); unittest.expect(casted3["list"], unittest.equals([1, 2, 3])); unittest.expect(casted3["bool"], unittest.equals(true)); unittest.expect(casted3["string"], unittest.equals('foo')); 
  var casted4 = (o["b"]) as core.Map; unittest.expect(casted4, unittest.hasLength(3)); unittest.expect(casted4["list"], unittest.equals([1, 2, 3])); unittest.expect(casted4["bool"], unittest.equals(true)); unittest.expect(casted4["string"], unittest.equals('foo')); 
}

core.int buildCounterSavedColumn = 0;
buildSavedColumn() {
  var o = new api.SavedColumn();
  buildCounterSavedColumn++;
  if (buildCounterSavedColumn < 3) {
    o.kind = "foo";
    o.savedColumnName = "foo";
    o.type = "foo";
  }
  buildCounterSavedColumn--;
  return o;
}

checkSavedColumn(api.SavedColumn o) {
  buildCounterSavedColumn++;
  if (buildCounterSavedColumn < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.savedColumnName, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterSavedColumn--;
}

buildUnnamed1244() {
  var o = new core.List<api.SavedColumn>();
  o.add(buildSavedColumn());
  o.add(buildSavedColumn());
  return o;
}

checkUnnamed1244(core.List<api.SavedColumn> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSavedColumn(o[0]);
  checkSavedColumn(o[1]);
}

core.int buildCounterSavedColumnList = 0;
buildSavedColumnList() {
  var o = new api.SavedColumnList();
  buildCounterSavedColumnList++;
  if (buildCounterSavedColumnList < 3) {
    o.items = buildUnnamed1244();
    o.kind = "foo";
  }
  buildCounterSavedColumnList--;
  return o;
}

checkSavedColumnList(api.SavedColumnList o) {
  buildCounterSavedColumnList++;
  if (buildCounterSavedColumnList < 3) {
    checkUnnamed1244(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterSavedColumnList--;
}

buildUnnamed1245() {
  var o = new core.List<api.Availability>();
  o.add(buildAvailability());
  o.add(buildAvailability());
  return o;
}

checkUnnamed1245(core.List<api.Availability> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAvailability(o[0]);
  checkAvailability(o[1]);
}

core.int buildCounterUpdateAvailabilityRequest = 0;
buildUpdateAvailabilityRequest() {
  var o = new api.UpdateAvailabilityRequest();
  buildCounterUpdateAvailabilityRequest++;
  if (buildCounterUpdateAvailabilityRequest < 3) {
    o.availabilities = buildUnnamed1245();
  }
  buildCounterUpdateAvailabilityRequest--;
  return o;
}

checkUpdateAvailabilityRequest(api.UpdateAvailabilityRequest o) {
  buildCounterUpdateAvailabilityRequest++;
  if (buildCounterUpdateAvailabilityRequest < 3) {
    checkUnnamed1245(o.availabilities);
  }
  buildCounterUpdateAvailabilityRequest--;
}

buildUnnamed1246() {
  var o = new core.List<api.Availability>();
  o.add(buildAvailability());
  o.add(buildAvailability());
  return o;
}

checkUnnamed1246(core.List<api.Availability> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAvailability(o[0]);
  checkAvailability(o[1]);
}

core.int buildCounterUpdateAvailabilityResponse = 0;
buildUpdateAvailabilityResponse() {
  var o = new api.UpdateAvailabilityResponse();
  buildCounterUpdateAvailabilityResponse++;
  if (buildCounterUpdateAvailabilityResponse < 3) {
    o.availabilities = buildUnnamed1246();
  }
  buildCounterUpdateAvailabilityResponse--;
  return o;
}

checkUpdateAvailabilityResponse(api.UpdateAvailabilityResponse o) {
  buildCounterUpdateAvailabilityResponse++;
  if (buildCounterUpdateAvailabilityResponse < 3) {
    checkUnnamed1246(o.availabilities);
  }
  buildCounterUpdateAvailabilityResponse--;
}


main() {
  unittest.group("obj-schema-Availability", () {
    unittest.test("to-json--from-json", () {
      var o = buildAvailability();
      var od = new api.Availability.fromJson(o.toJson());
      checkAvailability(od);
    });
  });


  unittest.group("obj-schema-Conversion", () {
    unittest.test("to-json--from-json", () {
      var o = buildConversion();
      var od = new api.Conversion.fromJson(o.toJson());
      checkConversion(od);
    });
  });


  unittest.group("obj-schema-ConversionList", () {
    unittest.test("to-json--from-json", () {
      var o = buildConversionList();
      var od = new api.ConversionList.fromJson(o.toJson());
      checkConversionList(od);
    });
  });


  unittest.group("obj-schema-CustomDimension", () {
    unittest.test("to-json--from-json", () {
      var o = buildCustomDimension();
      var od = new api.CustomDimension.fromJson(o.toJson());
      checkCustomDimension(od);
    });
  });


  unittest.group("obj-schema-CustomMetric", () {
    unittest.test("to-json--from-json", () {
      var o = buildCustomMetric();
      var od = new api.CustomMetric.fromJson(o.toJson());
      checkCustomMetric(od);
    });
  });


  unittest.group("obj-schema-ReportFiles", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportFiles();
      var od = new api.ReportFiles.fromJson(o.toJson());
      checkReportFiles(od);
    });
  });


  unittest.group("obj-schema-Report", () {
    unittest.test("to-json--from-json", () {
      var o = buildReport();
      var od = new api.Report.fromJson(o.toJson());
      checkReport(od);
    });
  });


  unittest.group("obj-schema-ReportApiColumnSpec", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportApiColumnSpec();
      var od = new api.ReportApiColumnSpec.fromJson(o.toJson());
      checkReportApiColumnSpec(od);
    });
  });


  unittest.group("obj-schema-ReportRequestFilters", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportRequestFilters();
      var od = new api.ReportRequestFilters.fromJson(o.toJson());
      checkReportRequestFilters(od);
    });
  });


  unittest.group("obj-schema-ReportRequestOrderBy", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportRequestOrderBy();
      var od = new api.ReportRequestOrderBy.fromJson(o.toJson());
      checkReportRequestOrderBy(od);
    });
  });


  unittest.group("obj-schema-ReportRequestReportScope", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportRequestReportScope();
      var od = new api.ReportRequestReportScope.fromJson(o.toJson());
      checkReportRequestReportScope(od);
    });
  });


  unittest.group("obj-schema-ReportRequestTimeRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportRequestTimeRange();
      var od = new api.ReportRequestTimeRange.fromJson(o.toJson());
      checkReportRequestTimeRange(od);
    });
  });


  unittest.group("obj-schema-ReportRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportRequest();
      var od = new api.ReportRequest.fromJson(o.toJson());
      checkReportRequest(od);
    });
  });


  unittest.group("obj-schema-ReportRow", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportRow();
      var od = new api.ReportRow.fromJson(o.toJson());
      checkReportRow(od);
    });
  });


  unittest.group("obj-schema-SavedColumn", () {
    unittest.test("to-json--from-json", () {
      var o = buildSavedColumn();
      var od = new api.SavedColumn.fromJson(o.toJson());
      checkSavedColumn(od);
    });
  });


  unittest.group("obj-schema-SavedColumnList", () {
    unittest.test("to-json--from-json", () {
      var o = buildSavedColumnList();
      var od = new api.SavedColumnList.fromJson(o.toJson());
      checkSavedColumnList(od);
    });
  });


  unittest.group("obj-schema-UpdateAvailabilityRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateAvailabilityRequest();
      var od = new api.UpdateAvailabilityRequest.fromJson(o.toJson());
      checkUpdateAvailabilityRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateAvailabilityResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateAvailabilityResponse();
      var od = new api.UpdateAvailabilityResponse.fromJson(o.toJson());
      checkUpdateAvailabilityResponse(od);
    });
  });


  unittest.group("resource-ConversionResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.ConversionResourceApi res = new api.DoubleclicksearchApi(mock).conversion;
      var arg_agencyId = "foo";
      var arg_advertiserId = "foo";
      var arg_engineAccountId = "foo";
      var arg_endDate = 42;
      var arg_rowCount = 42;
      var arg_startDate = 42;
      var arg_startRow = 42;
      var arg_adGroupId = "foo";
      var arg_adId = "foo";
      var arg_campaignId = "foo";
      var arg_criterionId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("doubleclicksearch/v2/"));
        pathOffset += 21;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("agency/"));
        pathOffset += 7;
        index = path.indexOf("/advertiser/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_agencyId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("/advertiser/"));
        pathOffset += 12;
        index = path.indexOf("/engine/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_advertiserId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/engine/"));
        pathOffset += 8;
        index = path.indexOf("/conversion", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_engineAccountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("/conversion"));
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
        unittest.expect(core.int.parse(queryMap["endDate"].first), unittest.equals(arg_endDate));
        unittest.expect(core.int.parse(queryMap["rowCount"].first), unittest.equals(arg_rowCount));
        unittest.expect(core.int.parse(queryMap["startDate"].first), unittest.equals(arg_startDate));
        unittest.expect(core.int.parse(queryMap["startRow"].first), unittest.equals(arg_startRow));
        unittest.expect(queryMap["adGroupId"].first, unittest.equals(arg_adGroupId));
        unittest.expect(queryMap["adId"].first, unittest.equals(arg_adId));
        unittest.expect(queryMap["campaignId"].first, unittest.equals(arg_campaignId));
        unittest.expect(queryMap["criterionId"].first, unittest.equals(arg_criterionId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildConversionList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_agencyId, arg_advertiserId, arg_engineAccountId, arg_endDate, arg_rowCount, arg_startDate, arg_startRow, adGroupId: arg_adGroupId, adId: arg_adId, campaignId: arg_campaignId, criterionId: arg_criterionId).then(unittest.expectAsync(((api.ConversionList response) {
        checkConversionList(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.ConversionResourceApi res = new api.DoubleclicksearchApi(mock).conversion;
      var arg_request = buildConversionList();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ConversionList.fromJson(json);
        checkConversionList(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("doubleclicksearch/v2/"));
        pathOffset += 21;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("conversion"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildConversionList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request).then(unittest.expectAsync(((api.ConversionList response) {
        checkConversionList(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.ConversionResourceApi res = new api.DoubleclicksearchApi(mock).conversion;
      var arg_request = buildConversionList();
      var arg_advertiserId = "foo";
      var arg_agencyId = "foo";
      var arg_endDate = 42;
      var arg_engineAccountId = "foo";
      var arg_rowCount = 42;
      var arg_startDate = 42;
      var arg_startRow = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ConversionList.fromJson(json);
        checkConversionList(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("doubleclicksearch/v2/"));
        pathOffset += 21;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("conversion"));
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
        unittest.expect(queryMap["advertiserId"].first, unittest.equals(arg_advertiserId));
        unittest.expect(queryMap["agencyId"].first, unittest.equals(arg_agencyId));
        unittest.expect(core.int.parse(queryMap["endDate"].first), unittest.equals(arg_endDate));
        unittest.expect(queryMap["engineAccountId"].first, unittest.equals(arg_engineAccountId));
        unittest.expect(core.int.parse(queryMap["rowCount"].first), unittest.equals(arg_rowCount));
        unittest.expect(core.int.parse(queryMap["startDate"].first), unittest.equals(arg_startDate));
        unittest.expect(core.int.parse(queryMap["startRow"].first), unittest.equals(arg_startRow));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildConversionList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_advertiserId, arg_agencyId, arg_endDate, arg_engineAccountId, arg_rowCount, arg_startDate, arg_startRow).then(unittest.expectAsync(((api.ConversionList response) {
        checkConversionList(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.ConversionResourceApi res = new api.DoubleclicksearchApi(mock).conversion;
      var arg_request = buildConversionList();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ConversionList.fromJson(json);
        checkConversionList(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("doubleclicksearch/v2/"));
        pathOffset += 21;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("conversion"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildConversionList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request).then(unittest.expectAsync(((api.ConversionList response) {
        checkConversionList(response);
      })));
    });

    unittest.test("method--updateAvailability", () {

      var mock = new HttpServerMock();
      api.ConversionResourceApi res = new api.DoubleclicksearchApi(mock).conversion;
      var arg_request = buildUpdateAvailabilityRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.UpdateAvailabilityRequest.fromJson(json);
        checkUpdateAvailabilityRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("doubleclicksearch/v2/"));
        pathOffset += 21;
        unittest.expect(path.substring(pathOffset, pathOffset + 29), unittest.equals("conversion/updateAvailability"));
        pathOffset += 29;

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
        var resp = convert.JSON.encode(buildUpdateAvailabilityResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.updateAvailability(arg_request).then(unittest.expectAsync(((api.UpdateAvailabilityResponse response) {
        checkUpdateAvailabilityResponse(response);
      })));
    });

  });


  unittest.group("resource-ReportsResourceApi", () {
    unittest.test("method--generate", () {

      var mock = new HttpServerMock();
      api.ReportsResourceApi res = new api.DoubleclicksearchApi(mock).reports;
      var arg_request_1 = buildReportRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ReportRequest.fromJson(json);
        checkReportRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("doubleclicksearch/v2/"));
        pathOffset += 21;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("reports/generate"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildReport());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.generate(arg_request_1).then(unittest.expectAsync(((api.Report response) {
        checkReport(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.ReportsResourceApi res = new api.DoubleclicksearchApi(mock).reports;
      var arg_reportId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("doubleclicksearch/v2/"));
        pathOffset += 21;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("reports/"));
        pathOffset += 8;
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildReport());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_reportId).then(unittest.expectAsync(((api.Report response) {
        checkReport(response);
      })));
    });

    unittest.test("method--getFile", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.ReportsResourceApi res = new api.DoubleclicksearchApi(mock).reports;
      var arg_reportId = "foo";
      var arg_reportFragment = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("doubleclicksearch/v2/"));
        pathOffset += 21;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("reports/"));
        pathOffset += 8;
        index = path.indexOf("/files/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_reportId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/files/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_reportFragment"));

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
      res.getFile(arg_reportId, arg_reportFragment).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--request", () {

      var mock = new HttpServerMock();
      api.ReportsResourceApi res = new api.DoubleclicksearchApi(mock).reports;
      var arg_request_1 = buildReportRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ReportRequest.fromJson(json);
        checkReportRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("doubleclicksearch/v2/"));
        pathOffset += 21;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("reports"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildReport());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.request(arg_request_1).then(unittest.expectAsync(((api.Report response) {
        checkReport(response);
      })));
    });

  });


  unittest.group("resource-SavedColumnsResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.SavedColumnsResourceApi res = new api.DoubleclicksearchApi(mock).savedColumns;
      var arg_agencyId = "foo";
      var arg_advertiserId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("doubleclicksearch/v2/"));
        pathOffset += 21;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("agency/"));
        pathOffset += 7;
        index = path.indexOf("/advertiser/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_agencyId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("/advertiser/"));
        pathOffset += 12;
        index = path.indexOf("/savedcolumns", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_advertiserId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/savedcolumns"));
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
        var resp = convert.JSON.encode(buildSavedColumnList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_agencyId, arg_advertiserId).then(unittest.expectAsync(((api.SavedColumnList response) {
        checkSavedColumnList(response);
      })));
    });

  });


}

