library googleapis.sheets.v4.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/sheets/v4.dart' as api;

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

core.int buildCounterAddBandingRequest = 0;
buildAddBandingRequest() {
  var o = new api.AddBandingRequest();
  buildCounterAddBandingRequest++;
  if (buildCounterAddBandingRequest < 3) {
    o.bandedRange = buildBandedRange();
  }
  buildCounterAddBandingRequest--;
  return o;
}

checkAddBandingRequest(api.AddBandingRequest o) {
  buildCounterAddBandingRequest++;
  if (buildCounterAddBandingRequest < 3) {
    checkBandedRange(o.bandedRange);
  }
  buildCounterAddBandingRequest--;
}

core.int buildCounterAddBandingResponse = 0;
buildAddBandingResponse() {
  var o = new api.AddBandingResponse();
  buildCounterAddBandingResponse++;
  if (buildCounterAddBandingResponse < 3) {
    o.bandedRange = buildBandedRange();
  }
  buildCounterAddBandingResponse--;
  return o;
}

checkAddBandingResponse(api.AddBandingResponse o) {
  buildCounterAddBandingResponse++;
  if (buildCounterAddBandingResponse < 3) {
    checkBandedRange(o.bandedRange);
  }
  buildCounterAddBandingResponse--;
}

core.int buildCounterAddChartRequest = 0;
buildAddChartRequest() {
  var o = new api.AddChartRequest();
  buildCounterAddChartRequest++;
  if (buildCounterAddChartRequest < 3) {
    o.chart = buildEmbeddedChart();
  }
  buildCounterAddChartRequest--;
  return o;
}

checkAddChartRequest(api.AddChartRequest o) {
  buildCounterAddChartRequest++;
  if (buildCounterAddChartRequest < 3) {
    checkEmbeddedChart(o.chart);
  }
  buildCounterAddChartRequest--;
}

core.int buildCounterAddChartResponse = 0;
buildAddChartResponse() {
  var o = new api.AddChartResponse();
  buildCounterAddChartResponse++;
  if (buildCounterAddChartResponse < 3) {
    o.chart = buildEmbeddedChart();
  }
  buildCounterAddChartResponse--;
  return o;
}

checkAddChartResponse(api.AddChartResponse o) {
  buildCounterAddChartResponse++;
  if (buildCounterAddChartResponse < 3) {
    checkEmbeddedChart(o.chart);
  }
  buildCounterAddChartResponse--;
}

core.int buildCounterAddConditionalFormatRuleRequest = 0;
buildAddConditionalFormatRuleRequest() {
  var o = new api.AddConditionalFormatRuleRequest();
  buildCounterAddConditionalFormatRuleRequest++;
  if (buildCounterAddConditionalFormatRuleRequest < 3) {
    o.index = 42;
    o.rule = buildConditionalFormatRule();
  }
  buildCounterAddConditionalFormatRuleRequest--;
  return o;
}

checkAddConditionalFormatRuleRequest(api.AddConditionalFormatRuleRequest o) {
  buildCounterAddConditionalFormatRuleRequest++;
  if (buildCounterAddConditionalFormatRuleRequest < 3) {
    unittest.expect(o.index, unittest.equals(42));
    checkConditionalFormatRule(o.rule);
  }
  buildCounterAddConditionalFormatRuleRequest--;
}

core.int buildCounterAddFilterViewRequest = 0;
buildAddFilterViewRequest() {
  var o = new api.AddFilterViewRequest();
  buildCounterAddFilterViewRequest++;
  if (buildCounterAddFilterViewRequest < 3) {
    o.filter = buildFilterView();
  }
  buildCounterAddFilterViewRequest--;
  return o;
}

checkAddFilterViewRequest(api.AddFilterViewRequest o) {
  buildCounterAddFilterViewRequest++;
  if (buildCounterAddFilterViewRequest < 3) {
    checkFilterView(o.filter);
  }
  buildCounterAddFilterViewRequest--;
}

core.int buildCounterAddFilterViewResponse = 0;
buildAddFilterViewResponse() {
  var o = new api.AddFilterViewResponse();
  buildCounterAddFilterViewResponse++;
  if (buildCounterAddFilterViewResponse < 3) {
    o.filter = buildFilterView();
  }
  buildCounterAddFilterViewResponse--;
  return o;
}

checkAddFilterViewResponse(api.AddFilterViewResponse o) {
  buildCounterAddFilterViewResponse++;
  if (buildCounterAddFilterViewResponse < 3) {
    checkFilterView(o.filter);
  }
  buildCounterAddFilterViewResponse--;
}

core.int buildCounterAddNamedRangeRequest = 0;
buildAddNamedRangeRequest() {
  var o = new api.AddNamedRangeRequest();
  buildCounterAddNamedRangeRequest++;
  if (buildCounterAddNamedRangeRequest < 3) {
    o.namedRange = buildNamedRange();
  }
  buildCounterAddNamedRangeRequest--;
  return o;
}

checkAddNamedRangeRequest(api.AddNamedRangeRequest o) {
  buildCounterAddNamedRangeRequest++;
  if (buildCounterAddNamedRangeRequest < 3) {
    checkNamedRange(o.namedRange);
  }
  buildCounterAddNamedRangeRequest--;
}

core.int buildCounterAddNamedRangeResponse = 0;
buildAddNamedRangeResponse() {
  var o = new api.AddNamedRangeResponse();
  buildCounterAddNamedRangeResponse++;
  if (buildCounterAddNamedRangeResponse < 3) {
    o.namedRange = buildNamedRange();
  }
  buildCounterAddNamedRangeResponse--;
  return o;
}

checkAddNamedRangeResponse(api.AddNamedRangeResponse o) {
  buildCounterAddNamedRangeResponse++;
  if (buildCounterAddNamedRangeResponse < 3) {
    checkNamedRange(o.namedRange);
  }
  buildCounterAddNamedRangeResponse--;
}

core.int buildCounterAddProtectedRangeRequest = 0;
buildAddProtectedRangeRequest() {
  var o = new api.AddProtectedRangeRequest();
  buildCounterAddProtectedRangeRequest++;
  if (buildCounterAddProtectedRangeRequest < 3) {
    o.protectedRange = buildProtectedRange();
  }
  buildCounterAddProtectedRangeRequest--;
  return o;
}

checkAddProtectedRangeRequest(api.AddProtectedRangeRequest o) {
  buildCounterAddProtectedRangeRequest++;
  if (buildCounterAddProtectedRangeRequest < 3) {
    checkProtectedRange(o.protectedRange);
  }
  buildCounterAddProtectedRangeRequest--;
}

core.int buildCounterAddProtectedRangeResponse = 0;
buildAddProtectedRangeResponse() {
  var o = new api.AddProtectedRangeResponse();
  buildCounterAddProtectedRangeResponse++;
  if (buildCounterAddProtectedRangeResponse < 3) {
    o.protectedRange = buildProtectedRange();
  }
  buildCounterAddProtectedRangeResponse--;
  return o;
}

checkAddProtectedRangeResponse(api.AddProtectedRangeResponse o) {
  buildCounterAddProtectedRangeResponse++;
  if (buildCounterAddProtectedRangeResponse < 3) {
    checkProtectedRange(o.protectedRange);
  }
  buildCounterAddProtectedRangeResponse--;
}

core.int buildCounterAddSheetRequest = 0;
buildAddSheetRequest() {
  var o = new api.AddSheetRequest();
  buildCounterAddSheetRequest++;
  if (buildCounterAddSheetRequest < 3) {
    o.properties = buildSheetProperties();
  }
  buildCounterAddSheetRequest--;
  return o;
}

checkAddSheetRequest(api.AddSheetRequest o) {
  buildCounterAddSheetRequest++;
  if (buildCounterAddSheetRequest < 3) {
    checkSheetProperties(o.properties);
  }
  buildCounterAddSheetRequest--;
}

core.int buildCounterAddSheetResponse = 0;
buildAddSheetResponse() {
  var o = new api.AddSheetResponse();
  buildCounterAddSheetResponse++;
  if (buildCounterAddSheetResponse < 3) {
    o.properties = buildSheetProperties();
  }
  buildCounterAddSheetResponse--;
  return o;
}

checkAddSheetResponse(api.AddSheetResponse o) {
  buildCounterAddSheetResponse++;
  if (buildCounterAddSheetResponse < 3) {
    checkSheetProperties(o.properties);
  }
  buildCounterAddSheetResponse--;
}

buildUnnamed358() {
  var o = new core.List<api.RowData>();
  o.add(buildRowData());
  o.add(buildRowData());
  return o;
}

checkUnnamed358(core.List<api.RowData> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRowData(o[0]);
  checkRowData(o[1]);
}

core.int buildCounterAppendCellsRequest = 0;
buildAppendCellsRequest() {
  var o = new api.AppendCellsRequest();
  buildCounterAppendCellsRequest++;
  if (buildCounterAppendCellsRequest < 3) {
    o.fields = "foo";
    o.rows = buildUnnamed358();
    o.sheetId = 42;
  }
  buildCounterAppendCellsRequest--;
  return o;
}

checkAppendCellsRequest(api.AppendCellsRequest o) {
  buildCounterAppendCellsRequest++;
  if (buildCounterAppendCellsRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    checkUnnamed358(o.rows);
    unittest.expect(o.sheetId, unittest.equals(42));
  }
  buildCounterAppendCellsRequest--;
}

core.int buildCounterAppendDimensionRequest = 0;
buildAppendDimensionRequest() {
  var o = new api.AppendDimensionRequest();
  buildCounterAppendDimensionRequest++;
  if (buildCounterAppendDimensionRequest < 3) {
    o.dimension = "foo";
    o.length = 42;
    o.sheetId = 42;
  }
  buildCounterAppendDimensionRequest--;
  return o;
}

checkAppendDimensionRequest(api.AppendDimensionRequest o) {
  buildCounterAppendDimensionRequest++;
  if (buildCounterAppendDimensionRequest < 3) {
    unittest.expect(o.dimension, unittest.equals('foo'));
    unittest.expect(o.length, unittest.equals(42));
    unittest.expect(o.sheetId, unittest.equals(42));
  }
  buildCounterAppendDimensionRequest--;
}

core.int buildCounterAppendValuesResponse = 0;
buildAppendValuesResponse() {
  var o = new api.AppendValuesResponse();
  buildCounterAppendValuesResponse++;
  if (buildCounterAppendValuesResponse < 3) {
    o.spreadsheetId = "foo";
    o.tableRange = "foo";
    o.updates = buildUpdateValuesResponse();
  }
  buildCounterAppendValuesResponse--;
  return o;
}

checkAppendValuesResponse(api.AppendValuesResponse o) {
  buildCounterAppendValuesResponse++;
  if (buildCounterAppendValuesResponse < 3) {
    unittest.expect(o.spreadsheetId, unittest.equals('foo'));
    unittest.expect(o.tableRange, unittest.equals('foo'));
    checkUpdateValuesResponse(o.updates);
  }
  buildCounterAppendValuesResponse--;
}

core.int buildCounterAutoFillRequest = 0;
buildAutoFillRequest() {
  var o = new api.AutoFillRequest();
  buildCounterAutoFillRequest++;
  if (buildCounterAutoFillRequest < 3) {
    o.range = buildGridRange();
    o.sourceAndDestination = buildSourceAndDestination();
    o.useAlternateSeries = true;
  }
  buildCounterAutoFillRequest--;
  return o;
}

checkAutoFillRequest(api.AutoFillRequest o) {
  buildCounterAutoFillRequest++;
  if (buildCounterAutoFillRequest < 3) {
    checkGridRange(o.range);
    checkSourceAndDestination(o.sourceAndDestination);
    unittest.expect(o.useAlternateSeries, unittest.isTrue);
  }
  buildCounterAutoFillRequest--;
}

core.int buildCounterAutoResizeDimensionsRequest = 0;
buildAutoResizeDimensionsRequest() {
  var o = new api.AutoResizeDimensionsRequest();
  buildCounterAutoResizeDimensionsRequest++;
  if (buildCounterAutoResizeDimensionsRequest < 3) {
    o.dimensions = buildDimensionRange();
  }
  buildCounterAutoResizeDimensionsRequest--;
  return o;
}

checkAutoResizeDimensionsRequest(api.AutoResizeDimensionsRequest o) {
  buildCounterAutoResizeDimensionsRequest++;
  if (buildCounterAutoResizeDimensionsRequest < 3) {
    checkDimensionRange(o.dimensions);
  }
  buildCounterAutoResizeDimensionsRequest--;
}

core.int buildCounterBandedRange = 0;
buildBandedRange() {
  var o = new api.BandedRange();
  buildCounterBandedRange++;
  if (buildCounterBandedRange < 3) {
    o.bandedRangeId = 42;
    o.columnProperties = buildBandingProperties();
    o.range = buildGridRange();
    o.rowProperties = buildBandingProperties();
  }
  buildCounterBandedRange--;
  return o;
}

checkBandedRange(api.BandedRange o) {
  buildCounterBandedRange++;
  if (buildCounterBandedRange < 3) {
    unittest.expect(o.bandedRangeId, unittest.equals(42));
    checkBandingProperties(o.columnProperties);
    checkGridRange(o.range);
    checkBandingProperties(o.rowProperties);
  }
  buildCounterBandedRange--;
}

core.int buildCounterBandingProperties = 0;
buildBandingProperties() {
  var o = new api.BandingProperties();
  buildCounterBandingProperties++;
  if (buildCounterBandingProperties < 3) {
    o.firstBandColor = buildColor();
    o.footerColor = buildColor();
    o.headerColor = buildColor();
    o.secondBandColor = buildColor();
  }
  buildCounterBandingProperties--;
  return o;
}

checkBandingProperties(api.BandingProperties o) {
  buildCounterBandingProperties++;
  if (buildCounterBandingProperties < 3) {
    checkColor(o.firstBandColor);
    checkColor(o.footerColor);
    checkColor(o.headerColor);
    checkColor(o.secondBandColor);
  }
  buildCounterBandingProperties--;
}

core.int buildCounterBasicChartAxis = 0;
buildBasicChartAxis() {
  var o = new api.BasicChartAxis();
  buildCounterBasicChartAxis++;
  if (buildCounterBasicChartAxis < 3) {
    o.format = buildTextFormat();
    o.position = "foo";
    o.title = "foo";
  }
  buildCounterBasicChartAxis--;
  return o;
}

checkBasicChartAxis(api.BasicChartAxis o) {
  buildCounterBasicChartAxis++;
  if (buildCounterBasicChartAxis < 3) {
    checkTextFormat(o.format);
    unittest.expect(o.position, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterBasicChartAxis--;
}

core.int buildCounterBasicChartDomain = 0;
buildBasicChartDomain() {
  var o = new api.BasicChartDomain();
  buildCounterBasicChartDomain++;
  if (buildCounterBasicChartDomain < 3) {
    o.domain = buildChartData();
  }
  buildCounterBasicChartDomain--;
  return o;
}

checkBasicChartDomain(api.BasicChartDomain o) {
  buildCounterBasicChartDomain++;
  if (buildCounterBasicChartDomain < 3) {
    checkChartData(o.domain);
  }
  buildCounterBasicChartDomain--;
}

core.int buildCounterBasicChartSeries = 0;
buildBasicChartSeries() {
  var o = new api.BasicChartSeries();
  buildCounterBasicChartSeries++;
  if (buildCounterBasicChartSeries < 3) {
    o.series = buildChartData();
    o.targetAxis = "foo";
    o.type = "foo";
  }
  buildCounterBasicChartSeries--;
  return o;
}

checkBasicChartSeries(api.BasicChartSeries o) {
  buildCounterBasicChartSeries++;
  if (buildCounterBasicChartSeries < 3) {
    checkChartData(o.series);
    unittest.expect(o.targetAxis, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterBasicChartSeries--;
}

buildUnnamed359() {
  var o = new core.List<api.BasicChartAxis>();
  o.add(buildBasicChartAxis());
  o.add(buildBasicChartAxis());
  return o;
}

checkUnnamed359(core.List<api.BasicChartAxis> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBasicChartAxis(o[0]);
  checkBasicChartAxis(o[1]);
}

buildUnnamed360() {
  var o = new core.List<api.BasicChartDomain>();
  o.add(buildBasicChartDomain());
  o.add(buildBasicChartDomain());
  return o;
}

checkUnnamed360(core.List<api.BasicChartDomain> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBasicChartDomain(o[0]);
  checkBasicChartDomain(o[1]);
}

buildUnnamed361() {
  var o = new core.List<api.BasicChartSeries>();
  o.add(buildBasicChartSeries());
  o.add(buildBasicChartSeries());
  return o;
}

checkUnnamed361(core.List<api.BasicChartSeries> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBasicChartSeries(o[0]);
  checkBasicChartSeries(o[1]);
}

core.int buildCounterBasicChartSpec = 0;
buildBasicChartSpec() {
  var o = new api.BasicChartSpec();
  buildCounterBasicChartSpec++;
  if (buildCounterBasicChartSpec < 3) {
    o.axis = buildUnnamed359();
    o.chartType = "foo";
    o.domains = buildUnnamed360();
    o.headerCount = 42;
    o.legendPosition = "foo";
    o.series = buildUnnamed361();
  }
  buildCounterBasicChartSpec--;
  return o;
}

checkBasicChartSpec(api.BasicChartSpec o) {
  buildCounterBasicChartSpec++;
  if (buildCounterBasicChartSpec < 3) {
    checkUnnamed359(o.axis);
    unittest.expect(o.chartType, unittest.equals('foo'));
    checkUnnamed360(o.domains);
    unittest.expect(o.headerCount, unittest.equals(42));
    unittest.expect(o.legendPosition, unittest.equals('foo'));
    checkUnnamed361(o.series);
  }
  buildCounterBasicChartSpec--;
}

buildUnnamed362() {
  var o = new core.Map<core.String, api.FilterCriteria>();
  o["x"] = buildFilterCriteria();
  o["y"] = buildFilterCriteria();
  return o;
}

checkUnnamed362(core.Map<core.String, api.FilterCriteria> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFilterCriteria(o["x"]);
  checkFilterCriteria(o["y"]);
}

buildUnnamed363() {
  var o = new core.List<api.SortSpec>();
  o.add(buildSortSpec());
  o.add(buildSortSpec());
  return o;
}

checkUnnamed363(core.List<api.SortSpec> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSortSpec(o[0]);
  checkSortSpec(o[1]);
}

core.int buildCounterBasicFilter = 0;
buildBasicFilter() {
  var o = new api.BasicFilter();
  buildCounterBasicFilter++;
  if (buildCounterBasicFilter < 3) {
    o.criteria = buildUnnamed362();
    o.range = buildGridRange();
    o.sortSpecs = buildUnnamed363();
  }
  buildCounterBasicFilter--;
  return o;
}

checkBasicFilter(api.BasicFilter o) {
  buildCounterBasicFilter++;
  if (buildCounterBasicFilter < 3) {
    checkUnnamed362(o.criteria);
    checkGridRange(o.range);
    checkUnnamed363(o.sortSpecs);
  }
  buildCounterBasicFilter--;
}

buildUnnamed364() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed364(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterBatchClearValuesRequest = 0;
buildBatchClearValuesRequest() {
  var o = new api.BatchClearValuesRequest();
  buildCounterBatchClearValuesRequest++;
  if (buildCounterBatchClearValuesRequest < 3) {
    o.ranges = buildUnnamed364();
  }
  buildCounterBatchClearValuesRequest--;
  return o;
}

checkBatchClearValuesRequest(api.BatchClearValuesRequest o) {
  buildCounterBatchClearValuesRequest++;
  if (buildCounterBatchClearValuesRequest < 3) {
    checkUnnamed364(o.ranges);
  }
  buildCounterBatchClearValuesRequest--;
}

buildUnnamed365() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed365(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterBatchClearValuesResponse = 0;
buildBatchClearValuesResponse() {
  var o = new api.BatchClearValuesResponse();
  buildCounterBatchClearValuesResponse++;
  if (buildCounterBatchClearValuesResponse < 3) {
    o.clearedRanges = buildUnnamed365();
    o.spreadsheetId = "foo";
  }
  buildCounterBatchClearValuesResponse--;
  return o;
}

checkBatchClearValuesResponse(api.BatchClearValuesResponse o) {
  buildCounterBatchClearValuesResponse++;
  if (buildCounterBatchClearValuesResponse < 3) {
    checkUnnamed365(o.clearedRanges);
    unittest.expect(o.spreadsheetId, unittest.equals('foo'));
  }
  buildCounterBatchClearValuesResponse--;
}

buildUnnamed366() {
  var o = new core.List<api.ValueRange>();
  o.add(buildValueRange());
  o.add(buildValueRange());
  return o;
}

checkUnnamed366(core.List<api.ValueRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkValueRange(o[0]);
  checkValueRange(o[1]);
}

core.int buildCounterBatchGetValuesResponse = 0;
buildBatchGetValuesResponse() {
  var o = new api.BatchGetValuesResponse();
  buildCounterBatchGetValuesResponse++;
  if (buildCounterBatchGetValuesResponse < 3) {
    o.spreadsheetId = "foo";
    o.valueRanges = buildUnnamed366();
  }
  buildCounterBatchGetValuesResponse--;
  return o;
}

checkBatchGetValuesResponse(api.BatchGetValuesResponse o) {
  buildCounterBatchGetValuesResponse++;
  if (buildCounterBatchGetValuesResponse < 3) {
    unittest.expect(o.spreadsheetId, unittest.equals('foo'));
    checkUnnamed366(o.valueRanges);
  }
  buildCounterBatchGetValuesResponse--;
}

buildUnnamed367() {
  var o = new core.List<api.Request>();
  o.add(buildRequest());
  o.add(buildRequest());
  return o;
}

checkUnnamed367(core.List<api.Request> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRequest(o[0]);
  checkRequest(o[1]);
}

buildUnnamed368() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed368(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterBatchUpdateSpreadsheetRequest = 0;
buildBatchUpdateSpreadsheetRequest() {
  var o = new api.BatchUpdateSpreadsheetRequest();
  buildCounterBatchUpdateSpreadsheetRequest++;
  if (buildCounterBatchUpdateSpreadsheetRequest < 3) {
    o.includeSpreadsheetInResponse = true;
    o.requests = buildUnnamed367();
    o.responseIncludeGridData = true;
    o.responseRanges = buildUnnamed368();
  }
  buildCounterBatchUpdateSpreadsheetRequest--;
  return o;
}

checkBatchUpdateSpreadsheetRequest(api.BatchUpdateSpreadsheetRequest o) {
  buildCounterBatchUpdateSpreadsheetRequest++;
  if (buildCounterBatchUpdateSpreadsheetRequest < 3) {
    unittest.expect(o.includeSpreadsheetInResponse, unittest.isTrue);
    checkUnnamed367(o.requests);
    unittest.expect(o.responseIncludeGridData, unittest.isTrue);
    checkUnnamed368(o.responseRanges);
  }
  buildCounterBatchUpdateSpreadsheetRequest--;
}

buildUnnamed369() {
  var o = new core.List<api.Response>();
  o.add(buildResponse());
  o.add(buildResponse());
  return o;
}

checkUnnamed369(core.List<api.Response> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResponse(o[0]);
  checkResponse(o[1]);
}

core.int buildCounterBatchUpdateSpreadsheetResponse = 0;
buildBatchUpdateSpreadsheetResponse() {
  var o = new api.BatchUpdateSpreadsheetResponse();
  buildCounterBatchUpdateSpreadsheetResponse++;
  if (buildCounterBatchUpdateSpreadsheetResponse < 3) {
    o.replies = buildUnnamed369();
    o.spreadsheetId = "foo";
    o.updatedSpreadsheet = buildSpreadsheet();
  }
  buildCounterBatchUpdateSpreadsheetResponse--;
  return o;
}

checkBatchUpdateSpreadsheetResponse(api.BatchUpdateSpreadsheetResponse o) {
  buildCounterBatchUpdateSpreadsheetResponse++;
  if (buildCounterBatchUpdateSpreadsheetResponse < 3) {
    checkUnnamed369(o.replies);
    unittest.expect(o.spreadsheetId, unittest.equals('foo'));
    checkSpreadsheet(o.updatedSpreadsheet);
  }
  buildCounterBatchUpdateSpreadsheetResponse--;
}

buildUnnamed370() {
  var o = new core.List<api.ValueRange>();
  o.add(buildValueRange());
  o.add(buildValueRange());
  return o;
}

checkUnnamed370(core.List<api.ValueRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkValueRange(o[0]);
  checkValueRange(o[1]);
}

core.int buildCounterBatchUpdateValuesRequest = 0;
buildBatchUpdateValuesRequest() {
  var o = new api.BatchUpdateValuesRequest();
  buildCounterBatchUpdateValuesRequest++;
  if (buildCounterBatchUpdateValuesRequest < 3) {
    o.data = buildUnnamed370();
    o.includeValuesInResponse = true;
    o.responseDateTimeRenderOption = "foo";
    o.responseValueRenderOption = "foo";
    o.valueInputOption = "foo";
  }
  buildCounterBatchUpdateValuesRequest--;
  return o;
}

checkBatchUpdateValuesRequest(api.BatchUpdateValuesRequest o) {
  buildCounterBatchUpdateValuesRequest++;
  if (buildCounterBatchUpdateValuesRequest < 3) {
    checkUnnamed370(o.data);
    unittest.expect(o.includeValuesInResponse, unittest.isTrue);
    unittest.expect(o.responseDateTimeRenderOption, unittest.equals('foo'));
    unittest.expect(o.responseValueRenderOption, unittest.equals('foo'));
    unittest.expect(o.valueInputOption, unittest.equals('foo'));
  }
  buildCounterBatchUpdateValuesRequest--;
}

buildUnnamed371() {
  var o = new core.List<api.UpdateValuesResponse>();
  o.add(buildUpdateValuesResponse());
  o.add(buildUpdateValuesResponse());
  return o;
}

checkUnnamed371(core.List<api.UpdateValuesResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUpdateValuesResponse(o[0]);
  checkUpdateValuesResponse(o[1]);
}

core.int buildCounterBatchUpdateValuesResponse = 0;
buildBatchUpdateValuesResponse() {
  var o = new api.BatchUpdateValuesResponse();
  buildCounterBatchUpdateValuesResponse++;
  if (buildCounterBatchUpdateValuesResponse < 3) {
    o.responses = buildUnnamed371();
    o.spreadsheetId = "foo";
    o.totalUpdatedCells = 42;
    o.totalUpdatedColumns = 42;
    o.totalUpdatedRows = 42;
    o.totalUpdatedSheets = 42;
  }
  buildCounterBatchUpdateValuesResponse--;
  return o;
}

checkBatchUpdateValuesResponse(api.BatchUpdateValuesResponse o) {
  buildCounterBatchUpdateValuesResponse++;
  if (buildCounterBatchUpdateValuesResponse < 3) {
    checkUnnamed371(o.responses);
    unittest.expect(o.spreadsheetId, unittest.equals('foo'));
    unittest.expect(o.totalUpdatedCells, unittest.equals(42));
    unittest.expect(o.totalUpdatedColumns, unittest.equals(42));
    unittest.expect(o.totalUpdatedRows, unittest.equals(42));
    unittest.expect(o.totalUpdatedSheets, unittest.equals(42));
  }
  buildCounterBatchUpdateValuesResponse--;
}

buildUnnamed372() {
  var o = new core.List<api.ConditionValue>();
  o.add(buildConditionValue());
  o.add(buildConditionValue());
  return o;
}

checkUnnamed372(core.List<api.ConditionValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkConditionValue(o[0]);
  checkConditionValue(o[1]);
}

core.int buildCounterBooleanCondition = 0;
buildBooleanCondition() {
  var o = new api.BooleanCondition();
  buildCounterBooleanCondition++;
  if (buildCounterBooleanCondition < 3) {
    o.type = "foo";
    o.values = buildUnnamed372();
  }
  buildCounterBooleanCondition--;
  return o;
}

checkBooleanCondition(api.BooleanCondition o) {
  buildCounterBooleanCondition++;
  if (buildCounterBooleanCondition < 3) {
    unittest.expect(o.type, unittest.equals('foo'));
    checkUnnamed372(o.values);
  }
  buildCounterBooleanCondition--;
}

core.int buildCounterBooleanRule = 0;
buildBooleanRule() {
  var o = new api.BooleanRule();
  buildCounterBooleanRule++;
  if (buildCounterBooleanRule < 3) {
    o.condition = buildBooleanCondition();
    o.format = buildCellFormat();
  }
  buildCounterBooleanRule--;
  return o;
}

checkBooleanRule(api.BooleanRule o) {
  buildCounterBooleanRule++;
  if (buildCounterBooleanRule < 3) {
    checkBooleanCondition(o.condition);
    checkCellFormat(o.format);
  }
  buildCounterBooleanRule--;
}

core.int buildCounterBorder = 0;
buildBorder() {
  var o = new api.Border();
  buildCounterBorder++;
  if (buildCounterBorder < 3) {
    o.color = buildColor();
    o.style = "foo";
    o.width = 42;
  }
  buildCounterBorder--;
  return o;
}

checkBorder(api.Border o) {
  buildCounterBorder++;
  if (buildCounterBorder < 3) {
    checkColor(o.color);
    unittest.expect(o.style, unittest.equals('foo'));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterBorder--;
}

core.int buildCounterBorders = 0;
buildBorders() {
  var o = new api.Borders();
  buildCounterBorders++;
  if (buildCounterBorders < 3) {
    o.bottom = buildBorder();
    o.left = buildBorder();
    o.right = buildBorder();
    o.top = buildBorder();
  }
  buildCounterBorders--;
  return o;
}

checkBorders(api.Borders o) {
  buildCounterBorders++;
  if (buildCounterBorders < 3) {
    checkBorder(o.bottom);
    checkBorder(o.left);
    checkBorder(o.right);
    checkBorder(o.top);
  }
  buildCounterBorders--;
}

buildUnnamed373() {
  var o = new core.List<api.TextFormatRun>();
  o.add(buildTextFormatRun());
  o.add(buildTextFormatRun());
  return o;
}

checkUnnamed373(core.List<api.TextFormatRun> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTextFormatRun(o[0]);
  checkTextFormatRun(o[1]);
}

core.int buildCounterCellData = 0;
buildCellData() {
  var o = new api.CellData();
  buildCounterCellData++;
  if (buildCounterCellData < 3) {
    o.dataValidation = buildDataValidationRule();
    o.effectiveFormat = buildCellFormat();
    o.effectiveValue = buildExtendedValue();
    o.formattedValue = "foo";
    o.hyperlink = "foo";
    o.note = "foo";
    o.pivotTable = buildPivotTable();
    o.textFormatRuns = buildUnnamed373();
    o.userEnteredFormat = buildCellFormat();
    o.userEnteredValue = buildExtendedValue();
  }
  buildCounterCellData--;
  return o;
}

checkCellData(api.CellData o) {
  buildCounterCellData++;
  if (buildCounterCellData < 3) {
    checkDataValidationRule(o.dataValidation);
    checkCellFormat(o.effectiveFormat);
    checkExtendedValue(o.effectiveValue);
    unittest.expect(o.formattedValue, unittest.equals('foo'));
    unittest.expect(o.hyperlink, unittest.equals('foo'));
    unittest.expect(o.note, unittest.equals('foo'));
    checkPivotTable(o.pivotTable);
    checkUnnamed373(o.textFormatRuns);
    checkCellFormat(o.userEnteredFormat);
    checkExtendedValue(o.userEnteredValue);
  }
  buildCounterCellData--;
}

core.int buildCounterCellFormat = 0;
buildCellFormat() {
  var o = new api.CellFormat();
  buildCounterCellFormat++;
  if (buildCounterCellFormat < 3) {
    o.backgroundColor = buildColor();
    o.borders = buildBorders();
    o.horizontalAlignment = "foo";
    o.hyperlinkDisplayType = "foo";
    o.numberFormat = buildNumberFormat();
    o.padding = buildPadding();
    o.textDirection = "foo";
    o.textFormat = buildTextFormat();
    o.verticalAlignment = "foo";
    o.wrapStrategy = "foo";
  }
  buildCounterCellFormat--;
  return o;
}

checkCellFormat(api.CellFormat o) {
  buildCounterCellFormat++;
  if (buildCounterCellFormat < 3) {
    checkColor(o.backgroundColor);
    checkBorders(o.borders);
    unittest.expect(o.horizontalAlignment, unittest.equals('foo'));
    unittest.expect(o.hyperlinkDisplayType, unittest.equals('foo'));
    checkNumberFormat(o.numberFormat);
    checkPadding(o.padding);
    unittest.expect(o.textDirection, unittest.equals('foo'));
    checkTextFormat(o.textFormat);
    unittest.expect(o.verticalAlignment, unittest.equals('foo'));
    unittest.expect(o.wrapStrategy, unittest.equals('foo'));
  }
  buildCounterCellFormat--;
}

core.int buildCounterChartData = 0;
buildChartData() {
  var o = new api.ChartData();
  buildCounterChartData++;
  if (buildCounterChartData < 3) {
    o.sourceRange = buildChartSourceRange();
  }
  buildCounterChartData--;
  return o;
}

checkChartData(api.ChartData o) {
  buildCounterChartData++;
  if (buildCounterChartData < 3) {
    checkChartSourceRange(o.sourceRange);
  }
  buildCounterChartData--;
}

buildUnnamed374() {
  var o = new core.List<api.GridRange>();
  o.add(buildGridRange());
  o.add(buildGridRange());
  return o;
}

checkUnnamed374(core.List<api.GridRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGridRange(o[0]);
  checkGridRange(o[1]);
}

core.int buildCounterChartSourceRange = 0;
buildChartSourceRange() {
  var o = new api.ChartSourceRange();
  buildCounterChartSourceRange++;
  if (buildCounterChartSourceRange < 3) {
    o.sources = buildUnnamed374();
  }
  buildCounterChartSourceRange--;
  return o;
}

checkChartSourceRange(api.ChartSourceRange o) {
  buildCounterChartSourceRange++;
  if (buildCounterChartSourceRange < 3) {
    checkUnnamed374(o.sources);
  }
  buildCounterChartSourceRange--;
}

core.int buildCounterChartSpec = 0;
buildChartSpec() {
  var o = new api.ChartSpec();
  buildCounterChartSpec++;
  if (buildCounterChartSpec < 3) {
    o.basicChart = buildBasicChartSpec();
    o.hiddenDimensionStrategy = "foo";
    o.pieChart = buildPieChartSpec();
    o.title = "foo";
  }
  buildCounterChartSpec--;
  return o;
}

checkChartSpec(api.ChartSpec o) {
  buildCounterChartSpec++;
  if (buildCounterChartSpec < 3) {
    checkBasicChartSpec(o.basicChart);
    unittest.expect(o.hiddenDimensionStrategy, unittest.equals('foo'));
    checkPieChartSpec(o.pieChart);
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterChartSpec--;
}

core.int buildCounterClearBasicFilterRequest = 0;
buildClearBasicFilterRequest() {
  var o = new api.ClearBasicFilterRequest();
  buildCounterClearBasicFilterRequest++;
  if (buildCounterClearBasicFilterRequest < 3) {
    o.sheetId = 42;
  }
  buildCounterClearBasicFilterRequest--;
  return o;
}

checkClearBasicFilterRequest(api.ClearBasicFilterRequest o) {
  buildCounterClearBasicFilterRequest++;
  if (buildCounterClearBasicFilterRequest < 3) {
    unittest.expect(o.sheetId, unittest.equals(42));
  }
  buildCounterClearBasicFilterRequest--;
}

core.int buildCounterClearValuesRequest = 0;
buildClearValuesRequest() {
  var o = new api.ClearValuesRequest();
  buildCounterClearValuesRequest++;
  if (buildCounterClearValuesRequest < 3) {
  }
  buildCounterClearValuesRequest--;
  return o;
}

checkClearValuesRequest(api.ClearValuesRequest o) {
  buildCounterClearValuesRequest++;
  if (buildCounterClearValuesRequest < 3) {
  }
  buildCounterClearValuesRequest--;
}

core.int buildCounterClearValuesResponse = 0;
buildClearValuesResponse() {
  var o = new api.ClearValuesResponse();
  buildCounterClearValuesResponse++;
  if (buildCounterClearValuesResponse < 3) {
    o.clearedRange = "foo";
    o.spreadsheetId = "foo";
  }
  buildCounterClearValuesResponse--;
  return o;
}

checkClearValuesResponse(api.ClearValuesResponse o) {
  buildCounterClearValuesResponse++;
  if (buildCounterClearValuesResponse < 3) {
    unittest.expect(o.clearedRange, unittest.equals('foo'));
    unittest.expect(o.spreadsheetId, unittest.equals('foo'));
  }
  buildCounterClearValuesResponse--;
}

core.int buildCounterColor = 0;
buildColor() {
  var o = new api.Color();
  buildCounterColor++;
  if (buildCounterColor < 3) {
    o.alpha = 42.0;
    o.blue = 42.0;
    o.green = 42.0;
    o.red = 42.0;
  }
  buildCounterColor--;
  return o;
}

checkColor(api.Color o) {
  buildCounterColor++;
  if (buildCounterColor < 3) {
    unittest.expect(o.alpha, unittest.equals(42.0));
    unittest.expect(o.blue, unittest.equals(42.0));
    unittest.expect(o.green, unittest.equals(42.0));
    unittest.expect(o.red, unittest.equals(42.0));
  }
  buildCounterColor--;
}

core.int buildCounterConditionValue = 0;
buildConditionValue() {
  var o = new api.ConditionValue();
  buildCounterConditionValue++;
  if (buildCounterConditionValue < 3) {
    o.relativeDate = "foo";
    o.userEnteredValue = "foo";
  }
  buildCounterConditionValue--;
  return o;
}

checkConditionValue(api.ConditionValue o) {
  buildCounterConditionValue++;
  if (buildCounterConditionValue < 3) {
    unittest.expect(o.relativeDate, unittest.equals('foo'));
    unittest.expect(o.userEnteredValue, unittest.equals('foo'));
  }
  buildCounterConditionValue--;
}

buildUnnamed375() {
  var o = new core.List<api.GridRange>();
  o.add(buildGridRange());
  o.add(buildGridRange());
  return o;
}

checkUnnamed375(core.List<api.GridRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGridRange(o[0]);
  checkGridRange(o[1]);
}

core.int buildCounterConditionalFormatRule = 0;
buildConditionalFormatRule() {
  var o = new api.ConditionalFormatRule();
  buildCounterConditionalFormatRule++;
  if (buildCounterConditionalFormatRule < 3) {
    o.booleanRule = buildBooleanRule();
    o.gradientRule = buildGradientRule();
    o.ranges = buildUnnamed375();
  }
  buildCounterConditionalFormatRule--;
  return o;
}

checkConditionalFormatRule(api.ConditionalFormatRule o) {
  buildCounterConditionalFormatRule++;
  if (buildCounterConditionalFormatRule < 3) {
    checkBooleanRule(o.booleanRule);
    checkGradientRule(o.gradientRule);
    checkUnnamed375(o.ranges);
  }
  buildCounterConditionalFormatRule--;
}

core.int buildCounterCopyPasteRequest = 0;
buildCopyPasteRequest() {
  var o = new api.CopyPasteRequest();
  buildCounterCopyPasteRequest++;
  if (buildCounterCopyPasteRequest < 3) {
    o.destination = buildGridRange();
    o.pasteOrientation = "foo";
    o.pasteType = "foo";
    o.source = buildGridRange();
  }
  buildCounterCopyPasteRequest--;
  return o;
}

checkCopyPasteRequest(api.CopyPasteRequest o) {
  buildCounterCopyPasteRequest++;
  if (buildCounterCopyPasteRequest < 3) {
    checkGridRange(o.destination);
    unittest.expect(o.pasteOrientation, unittest.equals('foo'));
    unittest.expect(o.pasteType, unittest.equals('foo'));
    checkGridRange(o.source);
  }
  buildCounterCopyPasteRequest--;
}

core.int buildCounterCopySheetToAnotherSpreadsheetRequest = 0;
buildCopySheetToAnotherSpreadsheetRequest() {
  var o = new api.CopySheetToAnotherSpreadsheetRequest();
  buildCounterCopySheetToAnotherSpreadsheetRequest++;
  if (buildCounterCopySheetToAnotherSpreadsheetRequest < 3) {
    o.destinationSpreadsheetId = "foo";
  }
  buildCounterCopySheetToAnotherSpreadsheetRequest--;
  return o;
}

checkCopySheetToAnotherSpreadsheetRequest(api.CopySheetToAnotherSpreadsheetRequest o) {
  buildCounterCopySheetToAnotherSpreadsheetRequest++;
  if (buildCounterCopySheetToAnotherSpreadsheetRequest < 3) {
    unittest.expect(o.destinationSpreadsheetId, unittest.equals('foo'));
  }
  buildCounterCopySheetToAnotherSpreadsheetRequest--;
}

core.int buildCounterCutPasteRequest = 0;
buildCutPasteRequest() {
  var o = new api.CutPasteRequest();
  buildCounterCutPasteRequest++;
  if (buildCounterCutPasteRequest < 3) {
    o.destination = buildGridCoordinate();
    o.pasteType = "foo";
    o.source = buildGridRange();
  }
  buildCounterCutPasteRequest--;
  return o;
}

checkCutPasteRequest(api.CutPasteRequest o) {
  buildCounterCutPasteRequest++;
  if (buildCounterCutPasteRequest < 3) {
    checkGridCoordinate(o.destination);
    unittest.expect(o.pasteType, unittest.equals('foo'));
    checkGridRange(o.source);
  }
  buildCounterCutPasteRequest--;
}

core.int buildCounterDataValidationRule = 0;
buildDataValidationRule() {
  var o = new api.DataValidationRule();
  buildCounterDataValidationRule++;
  if (buildCounterDataValidationRule < 3) {
    o.condition = buildBooleanCondition();
    o.inputMessage = "foo";
    o.showCustomUi = true;
    o.strict = true;
  }
  buildCounterDataValidationRule--;
  return o;
}

checkDataValidationRule(api.DataValidationRule o) {
  buildCounterDataValidationRule++;
  if (buildCounterDataValidationRule < 3) {
    checkBooleanCondition(o.condition);
    unittest.expect(o.inputMessage, unittest.equals('foo'));
    unittest.expect(o.showCustomUi, unittest.isTrue);
    unittest.expect(o.strict, unittest.isTrue);
  }
  buildCounterDataValidationRule--;
}

core.int buildCounterDeleteBandingRequest = 0;
buildDeleteBandingRequest() {
  var o = new api.DeleteBandingRequest();
  buildCounterDeleteBandingRequest++;
  if (buildCounterDeleteBandingRequest < 3) {
    o.bandedRangeId = 42;
  }
  buildCounterDeleteBandingRequest--;
  return o;
}

checkDeleteBandingRequest(api.DeleteBandingRequest o) {
  buildCounterDeleteBandingRequest++;
  if (buildCounterDeleteBandingRequest < 3) {
    unittest.expect(o.bandedRangeId, unittest.equals(42));
  }
  buildCounterDeleteBandingRequest--;
}

core.int buildCounterDeleteConditionalFormatRuleRequest = 0;
buildDeleteConditionalFormatRuleRequest() {
  var o = new api.DeleteConditionalFormatRuleRequest();
  buildCounterDeleteConditionalFormatRuleRequest++;
  if (buildCounterDeleteConditionalFormatRuleRequest < 3) {
    o.index = 42;
    o.sheetId = 42;
  }
  buildCounterDeleteConditionalFormatRuleRequest--;
  return o;
}

checkDeleteConditionalFormatRuleRequest(api.DeleteConditionalFormatRuleRequest o) {
  buildCounterDeleteConditionalFormatRuleRequest++;
  if (buildCounterDeleteConditionalFormatRuleRequest < 3) {
    unittest.expect(o.index, unittest.equals(42));
    unittest.expect(o.sheetId, unittest.equals(42));
  }
  buildCounterDeleteConditionalFormatRuleRequest--;
}

core.int buildCounterDeleteConditionalFormatRuleResponse = 0;
buildDeleteConditionalFormatRuleResponse() {
  var o = new api.DeleteConditionalFormatRuleResponse();
  buildCounterDeleteConditionalFormatRuleResponse++;
  if (buildCounterDeleteConditionalFormatRuleResponse < 3) {
    o.rule = buildConditionalFormatRule();
  }
  buildCounterDeleteConditionalFormatRuleResponse--;
  return o;
}

checkDeleteConditionalFormatRuleResponse(api.DeleteConditionalFormatRuleResponse o) {
  buildCounterDeleteConditionalFormatRuleResponse++;
  if (buildCounterDeleteConditionalFormatRuleResponse < 3) {
    checkConditionalFormatRule(o.rule);
  }
  buildCounterDeleteConditionalFormatRuleResponse--;
}

core.int buildCounterDeleteDimensionRequest = 0;
buildDeleteDimensionRequest() {
  var o = new api.DeleteDimensionRequest();
  buildCounterDeleteDimensionRequest++;
  if (buildCounterDeleteDimensionRequest < 3) {
    o.range = buildDimensionRange();
  }
  buildCounterDeleteDimensionRequest--;
  return o;
}

checkDeleteDimensionRequest(api.DeleteDimensionRequest o) {
  buildCounterDeleteDimensionRequest++;
  if (buildCounterDeleteDimensionRequest < 3) {
    checkDimensionRange(o.range);
  }
  buildCounterDeleteDimensionRequest--;
}

core.int buildCounterDeleteEmbeddedObjectRequest = 0;
buildDeleteEmbeddedObjectRequest() {
  var o = new api.DeleteEmbeddedObjectRequest();
  buildCounterDeleteEmbeddedObjectRequest++;
  if (buildCounterDeleteEmbeddedObjectRequest < 3) {
    o.objectId = 42;
  }
  buildCounterDeleteEmbeddedObjectRequest--;
  return o;
}

checkDeleteEmbeddedObjectRequest(api.DeleteEmbeddedObjectRequest o) {
  buildCounterDeleteEmbeddedObjectRequest++;
  if (buildCounterDeleteEmbeddedObjectRequest < 3) {
    unittest.expect(o.objectId, unittest.equals(42));
  }
  buildCounterDeleteEmbeddedObjectRequest--;
}

core.int buildCounterDeleteFilterViewRequest = 0;
buildDeleteFilterViewRequest() {
  var o = new api.DeleteFilterViewRequest();
  buildCounterDeleteFilterViewRequest++;
  if (buildCounterDeleteFilterViewRequest < 3) {
    o.filterId = 42;
  }
  buildCounterDeleteFilterViewRequest--;
  return o;
}

checkDeleteFilterViewRequest(api.DeleteFilterViewRequest o) {
  buildCounterDeleteFilterViewRequest++;
  if (buildCounterDeleteFilterViewRequest < 3) {
    unittest.expect(o.filterId, unittest.equals(42));
  }
  buildCounterDeleteFilterViewRequest--;
}

core.int buildCounterDeleteNamedRangeRequest = 0;
buildDeleteNamedRangeRequest() {
  var o = new api.DeleteNamedRangeRequest();
  buildCounterDeleteNamedRangeRequest++;
  if (buildCounterDeleteNamedRangeRequest < 3) {
    o.namedRangeId = "foo";
  }
  buildCounterDeleteNamedRangeRequest--;
  return o;
}

checkDeleteNamedRangeRequest(api.DeleteNamedRangeRequest o) {
  buildCounterDeleteNamedRangeRequest++;
  if (buildCounterDeleteNamedRangeRequest < 3) {
    unittest.expect(o.namedRangeId, unittest.equals('foo'));
  }
  buildCounterDeleteNamedRangeRequest--;
}

core.int buildCounterDeleteProtectedRangeRequest = 0;
buildDeleteProtectedRangeRequest() {
  var o = new api.DeleteProtectedRangeRequest();
  buildCounterDeleteProtectedRangeRequest++;
  if (buildCounterDeleteProtectedRangeRequest < 3) {
    o.protectedRangeId = 42;
  }
  buildCounterDeleteProtectedRangeRequest--;
  return o;
}

checkDeleteProtectedRangeRequest(api.DeleteProtectedRangeRequest o) {
  buildCounterDeleteProtectedRangeRequest++;
  if (buildCounterDeleteProtectedRangeRequest < 3) {
    unittest.expect(o.protectedRangeId, unittest.equals(42));
  }
  buildCounterDeleteProtectedRangeRequest--;
}

core.int buildCounterDeleteRangeRequest = 0;
buildDeleteRangeRequest() {
  var o = new api.DeleteRangeRequest();
  buildCounterDeleteRangeRequest++;
  if (buildCounterDeleteRangeRequest < 3) {
    o.range = buildGridRange();
    o.shiftDimension = "foo";
  }
  buildCounterDeleteRangeRequest--;
  return o;
}

checkDeleteRangeRequest(api.DeleteRangeRequest o) {
  buildCounterDeleteRangeRequest++;
  if (buildCounterDeleteRangeRequest < 3) {
    checkGridRange(o.range);
    unittest.expect(o.shiftDimension, unittest.equals('foo'));
  }
  buildCounterDeleteRangeRequest--;
}

core.int buildCounterDeleteSheetRequest = 0;
buildDeleteSheetRequest() {
  var o = new api.DeleteSheetRequest();
  buildCounterDeleteSheetRequest++;
  if (buildCounterDeleteSheetRequest < 3) {
    o.sheetId = 42;
  }
  buildCounterDeleteSheetRequest--;
  return o;
}

checkDeleteSheetRequest(api.DeleteSheetRequest o) {
  buildCounterDeleteSheetRequest++;
  if (buildCounterDeleteSheetRequest < 3) {
    unittest.expect(o.sheetId, unittest.equals(42));
  }
  buildCounterDeleteSheetRequest--;
}

core.int buildCounterDimensionProperties = 0;
buildDimensionProperties() {
  var o = new api.DimensionProperties();
  buildCounterDimensionProperties++;
  if (buildCounterDimensionProperties < 3) {
    o.hiddenByFilter = true;
    o.hiddenByUser = true;
    o.pixelSize = 42;
  }
  buildCounterDimensionProperties--;
  return o;
}

checkDimensionProperties(api.DimensionProperties o) {
  buildCounterDimensionProperties++;
  if (buildCounterDimensionProperties < 3) {
    unittest.expect(o.hiddenByFilter, unittest.isTrue);
    unittest.expect(o.hiddenByUser, unittest.isTrue);
    unittest.expect(o.pixelSize, unittest.equals(42));
  }
  buildCounterDimensionProperties--;
}

core.int buildCounterDimensionRange = 0;
buildDimensionRange() {
  var o = new api.DimensionRange();
  buildCounterDimensionRange++;
  if (buildCounterDimensionRange < 3) {
    o.dimension = "foo";
    o.endIndex = 42;
    o.sheetId = 42;
    o.startIndex = 42;
  }
  buildCounterDimensionRange--;
  return o;
}

checkDimensionRange(api.DimensionRange o) {
  buildCounterDimensionRange++;
  if (buildCounterDimensionRange < 3) {
    unittest.expect(o.dimension, unittest.equals('foo'));
    unittest.expect(o.endIndex, unittest.equals(42));
    unittest.expect(o.sheetId, unittest.equals(42));
    unittest.expect(o.startIndex, unittest.equals(42));
  }
  buildCounterDimensionRange--;
}

core.int buildCounterDuplicateFilterViewRequest = 0;
buildDuplicateFilterViewRequest() {
  var o = new api.DuplicateFilterViewRequest();
  buildCounterDuplicateFilterViewRequest++;
  if (buildCounterDuplicateFilterViewRequest < 3) {
    o.filterId = 42;
  }
  buildCounterDuplicateFilterViewRequest--;
  return o;
}

checkDuplicateFilterViewRequest(api.DuplicateFilterViewRequest o) {
  buildCounterDuplicateFilterViewRequest++;
  if (buildCounterDuplicateFilterViewRequest < 3) {
    unittest.expect(o.filterId, unittest.equals(42));
  }
  buildCounterDuplicateFilterViewRequest--;
}

core.int buildCounterDuplicateFilterViewResponse = 0;
buildDuplicateFilterViewResponse() {
  var o = new api.DuplicateFilterViewResponse();
  buildCounterDuplicateFilterViewResponse++;
  if (buildCounterDuplicateFilterViewResponse < 3) {
    o.filter = buildFilterView();
  }
  buildCounterDuplicateFilterViewResponse--;
  return o;
}

checkDuplicateFilterViewResponse(api.DuplicateFilterViewResponse o) {
  buildCounterDuplicateFilterViewResponse++;
  if (buildCounterDuplicateFilterViewResponse < 3) {
    checkFilterView(o.filter);
  }
  buildCounterDuplicateFilterViewResponse--;
}

core.int buildCounterDuplicateSheetRequest = 0;
buildDuplicateSheetRequest() {
  var o = new api.DuplicateSheetRequest();
  buildCounterDuplicateSheetRequest++;
  if (buildCounterDuplicateSheetRequest < 3) {
    o.insertSheetIndex = 42;
    o.newSheetId = 42;
    o.newSheetName = "foo";
    o.sourceSheetId = 42;
  }
  buildCounterDuplicateSheetRequest--;
  return o;
}

checkDuplicateSheetRequest(api.DuplicateSheetRequest o) {
  buildCounterDuplicateSheetRequest++;
  if (buildCounterDuplicateSheetRequest < 3) {
    unittest.expect(o.insertSheetIndex, unittest.equals(42));
    unittest.expect(o.newSheetId, unittest.equals(42));
    unittest.expect(o.newSheetName, unittest.equals('foo'));
    unittest.expect(o.sourceSheetId, unittest.equals(42));
  }
  buildCounterDuplicateSheetRequest--;
}

core.int buildCounterDuplicateSheetResponse = 0;
buildDuplicateSheetResponse() {
  var o = new api.DuplicateSheetResponse();
  buildCounterDuplicateSheetResponse++;
  if (buildCounterDuplicateSheetResponse < 3) {
    o.properties = buildSheetProperties();
  }
  buildCounterDuplicateSheetResponse--;
  return o;
}

checkDuplicateSheetResponse(api.DuplicateSheetResponse o) {
  buildCounterDuplicateSheetResponse++;
  if (buildCounterDuplicateSheetResponse < 3) {
    checkSheetProperties(o.properties);
  }
  buildCounterDuplicateSheetResponse--;
}

buildUnnamed376() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed376(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed377() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed377(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterEditors = 0;
buildEditors() {
  var o = new api.Editors();
  buildCounterEditors++;
  if (buildCounterEditors < 3) {
    o.domainUsersCanEdit = true;
    o.groups = buildUnnamed376();
    o.users = buildUnnamed377();
  }
  buildCounterEditors--;
  return o;
}

checkEditors(api.Editors o) {
  buildCounterEditors++;
  if (buildCounterEditors < 3) {
    unittest.expect(o.domainUsersCanEdit, unittest.isTrue);
    checkUnnamed376(o.groups);
    checkUnnamed377(o.users);
  }
  buildCounterEditors--;
}

core.int buildCounterEmbeddedChart = 0;
buildEmbeddedChart() {
  var o = new api.EmbeddedChart();
  buildCounterEmbeddedChart++;
  if (buildCounterEmbeddedChart < 3) {
    o.chartId = 42;
    o.position = buildEmbeddedObjectPosition();
    o.spec = buildChartSpec();
  }
  buildCounterEmbeddedChart--;
  return o;
}

checkEmbeddedChart(api.EmbeddedChart o) {
  buildCounterEmbeddedChart++;
  if (buildCounterEmbeddedChart < 3) {
    unittest.expect(o.chartId, unittest.equals(42));
    checkEmbeddedObjectPosition(o.position);
    checkChartSpec(o.spec);
  }
  buildCounterEmbeddedChart--;
}

core.int buildCounterEmbeddedObjectPosition = 0;
buildEmbeddedObjectPosition() {
  var o = new api.EmbeddedObjectPosition();
  buildCounterEmbeddedObjectPosition++;
  if (buildCounterEmbeddedObjectPosition < 3) {
    o.newSheet = true;
    o.overlayPosition = buildOverlayPosition();
    o.sheetId = 42;
  }
  buildCounterEmbeddedObjectPosition--;
  return o;
}

checkEmbeddedObjectPosition(api.EmbeddedObjectPosition o) {
  buildCounterEmbeddedObjectPosition++;
  if (buildCounterEmbeddedObjectPosition < 3) {
    unittest.expect(o.newSheet, unittest.isTrue);
    checkOverlayPosition(o.overlayPosition);
    unittest.expect(o.sheetId, unittest.equals(42));
  }
  buildCounterEmbeddedObjectPosition--;
}

core.int buildCounterErrorValue = 0;
buildErrorValue() {
  var o = new api.ErrorValue();
  buildCounterErrorValue++;
  if (buildCounterErrorValue < 3) {
    o.message = "foo";
    o.type = "foo";
  }
  buildCounterErrorValue--;
  return o;
}

checkErrorValue(api.ErrorValue o) {
  buildCounterErrorValue++;
  if (buildCounterErrorValue < 3) {
    unittest.expect(o.message, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterErrorValue--;
}

core.int buildCounterExtendedValue = 0;
buildExtendedValue() {
  var o = new api.ExtendedValue();
  buildCounterExtendedValue++;
  if (buildCounterExtendedValue < 3) {
    o.boolValue = true;
    o.errorValue = buildErrorValue();
    o.formulaValue = "foo";
    o.numberValue = 42.0;
    o.stringValue = "foo";
  }
  buildCounterExtendedValue--;
  return o;
}

checkExtendedValue(api.ExtendedValue o) {
  buildCounterExtendedValue++;
  if (buildCounterExtendedValue < 3) {
    unittest.expect(o.boolValue, unittest.isTrue);
    checkErrorValue(o.errorValue);
    unittest.expect(o.formulaValue, unittest.equals('foo'));
    unittest.expect(o.numberValue, unittest.equals(42.0));
    unittest.expect(o.stringValue, unittest.equals('foo'));
  }
  buildCounterExtendedValue--;
}

buildUnnamed378() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed378(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterFilterCriteria = 0;
buildFilterCriteria() {
  var o = new api.FilterCriteria();
  buildCounterFilterCriteria++;
  if (buildCounterFilterCriteria < 3) {
    o.condition = buildBooleanCondition();
    o.hiddenValues = buildUnnamed378();
  }
  buildCounterFilterCriteria--;
  return o;
}

checkFilterCriteria(api.FilterCriteria o) {
  buildCounterFilterCriteria++;
  if (buildCounterFilterCriteria < 3) {
    checkBooleanCondition(o.condition);
    checkUnnamed378(o.hiddenValues);
  }
  buildCounterFilterCriteria--;
}

buildUnnamed379() {
  var o = new core.Map<core.String, api.FilterCriteria>();
  o["x"] = buildFilterCriteria();
  o["y"] = buildFilterCriteria();
  return o;
}

checkUnnamed379(core.Map<core.String, api.FilterCriteria> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFilterCriteria(o["x"]);
  checkFilterCriteria(o["y"]);
}

buildUnnamed380() {
  var o = new core.List<api.SortSpec>();
  o.add(buildSortSpec());
  o.add(buildSortSpec());
  return o;
}

checkUnnamed380(core.List<api.SortSpec> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSortSpec(o[0]);
  checkSortSpec(o[1]);
}

core.int buildCounterFilterView = 0;
buildFilterView() {
  var o = new api.FilterView();
  buildCounterFilterView++;
  if (buildCounterFilterView < 3) {
    o.criteria = buildUnnamed379();
    o.filterViewId = 42;
    o.namedRangeId = "foo";
    o.range = buildGridRange();
    o.sortSpecs = buildUnnamed380();
    o.title = "foo";
  }
  buildCounterFilterView--;
  return o;
}

checkFilterView(api.FilterView o) {
  buildCounterFilterView++;
  if (buildCounterFilterView < 3) {
    checkUnnamed379(o.criteria);
    unittest.expect(o.filterViewId, unittest.equals(42));
    unittest.expect(o.namedRangeId, unittest.equals('foo'));
    checkGridRange(o.range);
    checkUnnamed380(o.sortSpecs);
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterFilterView--;
}

core.int buildCounterFindReplaceRequest = 0;
buildFindReplaceRequest() {
  var o = new api.FindReplaceRequest();
  buildCounterFindReplaceRequest++;
  if (buildCounterFindReplaceRequest < 3) {
    o.allSheets = true;
    o.find = "foo";
    o.includeFormulas = true;
    o.matchCase = true;
    o.matchEntireCell = true;
    o.range = buildGridRange();
    o.replacement = "foo";
    o.searchByRegex = true;
    o.sheetId = 42;
  }
  buildCounterFindReplaceRequest--;
  return o;
}

checkFindReplaceRequest(api.FindReplaceRequest o) {
  buildCounterFindReplaceRequest++;
  if (buildCounterFindReplaceRequest < 3) {
    unittest.expect(o.allSheets, unittest.isTrue);
    unittest.expect(o.find, unittest.equals('foo'));
    unittest.expect(o.includeFormulas, unittest.isTrue);
    unittest.expect(o.matchCase, unittest.isTrue);
    unittest.expect(o.matchEntireCell, unittest.isTrue);
    checkGridRange(o.range);
    unittest.expect(o.replacement, unittest.equals('foo'));
    unittest.expect(o.searchByRegex, unittest.isTrue);
    unittest.expect(o.sheetId, unittest.equals(42));
  }
  buildCounterFindReplaceRequest--;
}

core.int buildCounterFindReplaceResponse = 0;
buildFindReplaceResponse() {
  var o = new api.FindReplaceResponse();
  buildCounterFindReplaceResponse++;
  if (buildCounterFindReplaceResponse < 3) {
    o.formulasChanged = 42;
    o.occurrencesChanged = 42;
    o.rowsChanged = 42;
    o.sheetsChanged = 42;
    o.valuesChanged = 42;
  }
  buildCounterFindReplaceResponse--;
  return o;
}

checkFindReplaceResponse(api.FindReplaceResponse o) {
  buildCounterFindReplaceResponse++;
  if (buildCounterFindReplaceResponse < 3) {
    unittest.expect(o.formulasChanged, unittest.equals(42));
    unittest.expect(o.occurrencesChanged, unittest.equals(42));
    unittest.expect(o.rowsChanged, unittest.equals(42));
    unittest.expect(o.sheetsChanged, unittest.equals(42));
    unittest.expect(o.valuesChanged, unittest.equals(42));
  }
  buildCounterFindReplaceResponse--;
}

core.int buildCounterGradientRule = 0;
buildGradientRule() {
  var o = new api.GradientRule();
  buildCounterGradientRule++;
  if (buildCounterGradientRule < 3) {
    o.maxpoint = buildInterpolationPoint();
    o.midpoint = buildInterpolationPoint();
    o.minpoint = buildInterpolationPoint();
  }
  buildCounterGradientRule--;
  return o;
}

checkGradientRule(api.GradientRule o) {
  buildCounterGradientRule++;
  if (buildCounterGradientRule < 3) {
    checkInterpolationPoint(o.maxpoint);
    checkInterpolationPoint(o.midpoint);
    checkInterpolationPoint(o.minpoint);
  }
  buildCounterGradientRule--;
}

core.int buildCounterGridCoordinate = 0;
buildGridCoordinate() {
  var o = new api.GridCoordinate();
  buildCounterGridCoordinate++;
  if (buildCounterGridCoordinate < 3) {
    o.columnIndex = 42;
    o.rowIndex = 42;
    o.sheetId = 42;
  }
  buildCounterGridCoordinate--;
  return o;
}

checkGridCoordinate(api.GridCoordinate o) {
  buildCounterGridCoordinate++;
  if (buildCounterGridCoordinate < 3) {
    unittest.expect(o.columnIndex, unittest.equals(42));
    unittest.expect(o.rowIndex, unittest.equals(42));
    unittest.expect(o.sheetId, unittest.equals(42));
  }
  buildCounterGridCoordinate--;
}

buildUnnamed381() {
  var o = new core.List<api.DimensionProperties>();
  o.add(buildDimensionProperties());
  o.add(buildDimensionProperties());
  return o;
}

checkUnnamed381(core.List<api.DimensionProperties> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDimensionProperties(o[0]);
  checkDimensionProperties(o[1]);
}

buildUnnamed382() {
  var o = new core.List<api.RowData>();
  o.add(buildRowData());
  o.add(buildRowData());
  return o;
}

checkUnnamed382(core.List<api.RowData> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRowData(o[0]);
  checkRowData(o[1]);
}

buildUnnamed383() {
  var o = new core.List<api.DimensionProperties>();
  o.add(buildDimensionProperties());
  o.add(buildDimensionProperties());
  return o;
}

checkUnnamed383(core.List<api.DimensionProperties> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDimensionProperties(o[0]);
  checkDimensionProperties(o[1]);
}

core.int buildCounterGridData = 0;
buildGridData() {
  var o = new api.GridData();
  buildCounterGridData++;
  if (buildCounterGridData < 3) {
    o.columnMetadata = buildUnnamed381();
    o.rowData = buildUnnamed382();
    o.rowMetadata = buildUnnamed383();
    o.startColumn = 42;
    o.startRow = 42;
  }
  buildCounterGridData--;
  return o;
}

checkGridData(api.GridData o) {
  buildCounterGridData++;
  if (buildCounterGridData < 3) {
    checkUnnamed381(o.columnMetadata);
    checkUnnamed382(o.rowData);
    checkUnnamed383(o.rowMetadata);
    unittest.expect(o.startColumn, unittest.equals(42));
    unittest.expect(o.startRow, unittest.equals(42));
  }
  buildCounterGridData--;
}

core.int buildCounterGridProperties = 0;
buildGridProperties() {
  var o = new api.GridProperties();
  buildCounterGridProperties++;
  if (buildCounterGridProperties < 3) {
    o.columnCount = 42;
    o.frozenColumnCount = 42;
    o.frozenRowCount = 42;
    o.hideGridlines = true;
    o.rowCount = 42;
  }
  buildCounterGridProperties--;
  return o;
}

checkGridProperties(api.GridProperties o) {
  buildCounterGridProperties++;
  if (buildCounterGridProperties < 3) {
    unittest.expect(o.columnCount, unittest.equals(42));
    unittest.expect(o.frozenColumnCount, unittest.equals(42));
    unittest.expect(o.frozenRowCount, unittest.equals(42));
    unittest.expect(o.hideGridlines, unittest.isTrue);
    unittest.expect(o.rowCount, unittest.equals(42));
  }
  buildCounterGridProperties--;
}

core.int buildCounterGridRange = 0;
buildGridRange() {
  var o = new api.GridRange();
  buildCounterGridRange++;
  if (buildCounterGridRange < 3) {
    o.endColumnIndex = 42;
    o.endRowIndex = 42;
    o.sheetId = 42;
    o.startColumnIndex = 42;
    o.startRowIndex = 42;
  }
  buildCounterGridRange--;
  return o;
}

checkGridRange(api.GridRange o) {
  buildCounterGridRange++;
  if (buildCounterGridRange < 3) {
    unittest.expect(o.endColumnIndex, unittest.equals(42));
    unittest.expect(o.endRowIndex, unittest.equals(42));
    unittest.expect(o.sheetId, unittest.equals(42));
    unittest.expect(o.startColumnIndex, unittest.equals(42));
    unittest.expect(o.startRowIndex, unittest.equals(42));
  }
  buildCounterGridRange--;
}

core.int buildCounterInsertDimensionRequest = 0;
buildInsertDimensionRequest() {
  var o = new api.InsertDimensionRequest();
  buildCounterInsertDimensionRequest++;
  if (buildCounterInsertDimensionRequest < 3) {
    o.inheritFromBefore = true;
    o.range = buildDimensionRange();
  }
  buildCounterInsertDimensionRequest--;
  return o;
}

checkInsertDimensionRequest(api.InsertDimensionRequest o) {
  buildCounterInsertDimensionRequest++;
  if (buildCounterInsertDimensionRequest < 3) {
    unittest.expect(o.inheritFromBefore, unittest.isTrue);
    checkDimensionRange(o.range);
  }
  buildCounterInsertDimensionRequest--;
}

core.int buildCounterInsertRangeRequest = 0;
buildInsertRangeRequest() {
  var o = new api.InsertRangeRequest();
  buildCounterInsertRangeRequest++;
  if (buildCounterInsertRangeRequest < 3) {
    o.range = buildGridRange();
    o.shiftDimension = "foo";
  }
  buildCounterInsertRangeRequest--;
  return o;
}

checkInsertRangeRequest(api.InsertRangeRequest o) {
  buildCounterInsertRangeRequest++;
  if (buildCounterInsertRangeRequest < 3) {
    checkGridRange(o.range);
    unittest.expect(o.shiftDimension, unittest.equals('foo'));
  }
  buildCounterInsertRangeRequest--;
}

core.int buildCounterInterpolationPoint = 0;
buildInterpolationPoint() {
  var o = new api.InterpolationPoint();
  buildCounterInterpolationPoint++;
  if (buildCounterInterpolationPoint < 3) {
    o.color = buildColor();
    o.type = "foo";
    o.value = "foo";
  }
  buildCounterInterpolationPoint--;
  return o;
}

checkInterpolationPoint(api.InterpolationPoint o) {
  buildCounterInterpolationPoint++;
  if (buildCounterInterpolationPoint < 3) {
    checkColor(o.color);
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterInterpolationPoint--;
}

core.int buildCounterIterativeCalculationSettings = 0;
buildIterativeCalculationSettings() {
  var o = new api.IterativeCalculationSettings();
  buildCounterIterativeCalculationSettings++;
  if (buildCounterIterativeCalculationSettings < 3) {
    o.convergenceThreshold = 42.0;
    o.maxIterations = 42;
  }
  buildCounterIterativeCalculationSettings--;
  return o;
}

checkIterativeCalculationSettings(api.IterativeCalculationSettings o) {
  buildCounterIterativeCalculationSettings++;
  if (buildCounterIterativeCalculationSettings < 3) {
    unittest.expect(o.convergenceThreshold, unittest.equals(42.0));
    unittest.expect(o.maxIterations, unittest.equals(42));
  }
  buildCounterIterativeCalculationSettings--;
}

core.int buildCounterMergeCellsRequest = 0;
buildMergeCellsRequest() {
  var o = new api.MergeCellsRequest();
  buildCounterMergeCellsRequest++;
  if (buildCounterMergeCellsRequest < 3) {
    o.mergeType = "foo";
    o.range = buildGridRange();
  }
  buildCounterMergeCellsRequest--;
  return o;
}

checkMergeCellsRequest(api.MergeCellsRequest o) {
  buildCounterMergeCellsRequest++;
  if (buildCounterMergeCellsRequest < 3) {
    unittest.expect(o.mergeType, unittest.equals('foo'));
    checkGridRange(o.range);
  }
  buildCounterMergeCellsRequest--;
}

core.int buildCounterMoveDimensionRequest = 0;
buildMoveDimensionRequest() {
  var o = new api.MoveDimensionRequest();
  buildCounterMoveDimensionRequest++;
  if (buildCounterMoveDimensionRequest < 3) {
    o.destinationIndex = 42;
    o.source = buildDimensionRange();
  }
  buildCounterMoveDimensionRequest--;
  return o;
}

checkMoveDimensionRequest(api.MoveDimensionRequest o) {
  buildCounterMoveDimensionRequest++;
  if (buildCounterMoveDimensionRequest < 3) {
    unittest.expect(o.destinationIndex, unittest.equals(42));
    checkDimensionRange(o.source);
  }
  buildCounterMoveDimensionRequest--;
}

core.int buildCounterNamedRange = 0;
buildNamedRange() {
  var o = new api.NamedRange();
  buildCounterNamedRange++;
  if (buildCounterNamedRange < 3) {
    o.name = "foo";
    o.namedRangeId = "foo";
    o.range = buildGridRange();
  }
  buildCounterNamedRange--;
  return o;
}

checkNamedRange(api.NamedRange o) {
  buildCounterNamedRange++;
  if (buildCounterNamedRange < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.namedRangeId, unittest.equals('foo'));
    checkGridRange(o.range);
  }
  buildCounterNamedRange--;
}

core.int buildCounterNumberFormat = 0;
buildNumberFormat() {
  var o = new api.NumberFormat();
  buildCounterNumberFormat++;
  if (buildCounterNumberFormat < 3) {
    o.pattern = "foo";
    o.type = "foo";
  }
  buildCounterNumberFormat--;
  return o;
}

checkNumberFormat(api.NumberFormat o) {
  buildCounterNumberFormat++;
  if (buildCounterNumberFormat < 3) {
    unittest.expect(o.pattern, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterNumberFormat--;
}

core.int buildCounterOverlayPosition = 0;
buildOverlayPosition() {
  var o = new api.OverlayPosition();
  buildCounterOverlayPosition++;
  if (buildCounterOverlayPosition < 3) {
    o.anchorCell = buildGridCoordinate();
    o.heightPixels = 42;
    o.offsetXPixels = 42;
    o.offsetYPixels = 42;
    o.widthPixels = 42;
  }
  buildCounterOverlayPosition--;
  return o;
}

checkOverlayPosition(api.OverlayPosition o) {
  buildCounterOverlayPosition++;
  if (buildCounterOverlayPosition < 3) {
    checkGridCoordinate(o.anchorCell);
    unittest.expect(o.heightPixels, unittest.equals(42));
    unittest.expect(o.offsetXPixels, unittest.equals(42));
    unittest.expect(o.offsetYPixels, unittest.equals(42));
    unittest.expect(o.widthPixels, unittest.equals(42));
  }
  buildCounterOverlayPosition--;
}

core.int buildCounterPadding = 0;
buildPadding() {
  var o = new api.Padding();
  buildCounterPadding++;
  if (buildCounterPadding < 3) {
    o.bottom = 42;
    o.left = 42;
    o.right = 42;
    o.top = 42;
  }
  buildCounterPadding--;
  return o;
}

checkPadding(api.Padding o) {
  buildCounterPadding++;
  if (buildCounterPadding < 3) {
    unittest.expect(o.bottom, unittest.equals(42));
    unittest.expect(o.left, unittest.equals(42));
    unittest.expect(o.right, unittest.equals(42));
    unittest.expect(o.top, unittest.equals(42));
  }
  buildCounterPadding--;
}

core.int buildCounterPasteDataRequest = 0;
buildPasteDataRequest() {
  var o = new api.PasteDataRequest();
  buildCounterPasteDataRequest++;
  if (buildCounterPasteDataRequest < 3) {
    o.coordinate = buildGridCoordinate();
    o.data = "foo";
    o.delimiter = "foo";
    o.html = true;
    o.type = "foo";
  }
  buildCounterPasteDataRequest--;
  return o;
}

checkPasteDataRequest(api.PasteDataRequest o) {
  buildCounterPasteDataRequest++;
  if (buildCounterPasteDataRequest < 3) {
    checkGridCoordinate(o.coordinate);
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.delimiter, unittest.equals('foo'));
    unittest.expect(o.html, unittest.isTrue);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterPasteDataRequest--;
}

core.int buildCounterPieChartSpec = 0;
buildPieChartSpec() {
  var o = new api.PieChartSpec();
  buildCounterPieChartSpec++;
  if (buildCounterPieChartSpec < 3) {
    o.domain = buildChartData();
    o.legendPosition = "foo";
    o.pieHole = 42.0;
    o.series = buildChartData();
    o.threeDimensional = true;
  }
  buildCounterPieChartSpec--;
  return o;
}

checkPieChartSpec(api.PieChartSpec o) {
  buildCounterPieChartSpec++;
  if (buildCounterPieChartSpec < 3) {
    checkChartData(o.domain);
    unittest.expect(o.legendPosition, unittest.equals('foo'));
    unittest.expect(o.pieHole, unittest.equals(42.0));
    checkChartData(o.series);
    unittest.expect(o.threeDimensional, unittest.isTrue);
  }
  buildCounterPieChartSpec--;
}

buildUnnamed384() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed384(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterPivotFilterCriteria = 0;
buildPivotFilterCriteria() {
  var o = new api.PivotFilterCriteria();
  buildCounterPivotFilterCriteria++;
  if (buildCounterPivotFilterCriteria < 3) {
    o.visibleValues = buildUnnamed384();
  }
  buildCounterPivotFilterCriteria--;
  return o;
}

checkPivotFilterCriteria(api.PivotFilterCriteria o) {
  buildCounterPivotFilterCriteria++;
  if (buildCounterPivotFilterCriteria < 3) {
    checkUnnamed384(o.visibleValues);
  }
  buildCounterPivotFilterCriteria--;
}

buildUnnamed385() {
  var o = new core.List<api.PivotGroupValueMetadata>();
  o.add(buildPivotGroupValueMetadata());
  o.add(buildPivotGroupValueMetadata());
  return o;
}

checkUnnamed385(core.List<api.PivotGroupValueMetadata> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPivotGroupValueMetadata(o[0]);
  checkPivotGroupValueMetadata(o[1]);
}

core.int buildCounterPivotGroup = 0;
buildPivotGroup() {
  var o = new api.PivotGroup();
  buildCounterPivotGroup++;
  if (buildCounterPivotGroup < 3) {
    o.showTotals = true;
    o.sortOrder = "foo";
    o.sourceColumnOffset = 42;
    o.valueBucket = buildPivotGroupSortValueBucket();
    o.valueMetadata = buildUnnamed385();
  }
  buildCounterPivotGroup--;
  return o;
}

checkPivotGroup(api.PivotGroup o) {
  buildCounterPivotGroup++;
  if (buildCounterPivotGroup < 3) {
    unittest.expect(o.showTotals, unittest.isTrue);
    unittest.expect(o.sortOrder, unittest.equals('foo'));
    unittest.expect(o.sourceColumnOffset, unittest.equals(42));
    checkPivotGroupSortValueBucket(o.valueBucket);
    checkUnnamed385(o.valueMetadata);
  }
  buildCounterPivotGroup--;
}

buildUnnamed386() {
  var o = new core.List<api.ExtendedValue>();
  o.add(buildExtendedValue());
  o.add(buildExtendedValue());
  return o;
}

checkUnnamed386(core.List<api.ExtendedValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkExtendedValue(o[0]);
  checkExtendedValue(o[1]);
}

core.int buildCounterPivotGroupSortValueBucket = 0;
buildPivotGroupSortValueBucket() {
  var o = new api.PivotGroupSortValueBucket();
  buildCounterPivotGroupSortValueBucket++;
  if (buildCounterPivotGroupSortValueBucket < 3) {
    o.buckets = buildUnnamed386();
    o.valuesIndex = 42;
  }
  buildCounterPivotGroupSortValueBucket--;
  return o;
}

checkPivotGroupSortValueBucket(api.PivotGroupSortValueBucket o) {
  buildCounterPivotGroupSortValueBucket++;
  if (buildCounterPivotGroupSortValueBucket < 3) {
    checkUnnamed386(o.buckets);
    unittest.expect(o.valuesIndex, unittest.equals(42));
  }
  buildCounterPivotGroupSortValueBucket--;
}

core.int buildCounterPivotGroupValueMetadata = 0;
buildPivotGroupValueMetadata() {
  var o = new api.PivotGroupValueMetadata();
  buildCounterPivotGroupValueMetadata++;
  if (buildCounterPivotGroupValueMetadata < 3) {
    o.collapsed = true;
    o.value = buildExtendedValue();
  }
  buildCounterPivotGroupValueMetadata--;
  return o;
}

checkPivotGroupValueMetadata(api.PivotGroupValueMetadata o) {
  buildCounterPivotGroupValueMetadata++;
  if (buildCounterPivotGroupValueMetadata < 3) {
    unittest.expect(o.collapsed, unittest.isTrue);
    checkExtendedValue(o.value);
  }
  buildCounterPivotGroupValueMetadata--;
}

buildUnnamed387() {
  var o = new core.List<api.PivotGroup>();
  o.add(buildPivotGroup());
  o.add(buildPivotGroup());
  return o;
}

checkUnnamed387(core.List<api.PivotGroup> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPivotGroup(o[0]);
  checkPivotGroup(o[1]);
}

buildUnnamed388() {
  var o = new core.Map<core.String, api.PivotFilterCriteria>();
  o["x"] = buildPivotFilterCriteria();
  o["y"] = buildPivotFilterCriteria();
  return o;
}

checkUnnamed388(core.Map<core.String, api.PivotFilterCriteria> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPivotFilterCriteria(o["x"]);
  checkPivotFilterCriteria(o["y"]);
}

buildUnnamed389() {
  var o = new core.List<api.PivotGroup>();
  o.add(buildPivotGroup());
  o.add(buildPivotGroup());
  return o;
}

checkUnnamed389(core.List<api.PivotGroup> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPivotGroup(o[0]);
  checkPivotGroup(o[1]);
}

buildUnnamed390() {
  var o = new core.List<api.PivotValue>();
  o.add(buildPivotValue());
  o.add(buildPivotValue());
  return o;
}

checkUnnamed390(core.List<api.PivotValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPivotValue(o[0]);
  checkPivotValue(o[1]);
}

core.int buildCounterPivotTable = 0;
buildPivotTable() {
  var o = new api.PivotTable();
  buildCounterPivotTable++;
  if (buildCounterPivotTable < 3) {
    o.columns = buildUnnamed387();
    o.criteria = buildUnnamed388();
    o.rows = buildUnnamed389();
    o.source = buildGridRange();
    o.valueLayout = "foo";
    o.values = buildUnnamed390();
  }
  buildCounterPivotTable--;
  return o;
}

checkPivotTable(api.PivotTable o) {
  buildCounterPivotTable++;
  if (buildCounterPivotTable < 3) {
    checkUnnamed387(o.columns);
    checkUnnamed388(o.criteria);
    checkUnnamed389(o.rows);
    checkGridRange(o.source);
    unittest.expect(o.valueLayout, unittest.equals('foo'));
    checkUnnamed390(o.values);
  }
  buildCounterPivotTable--;
}

core.int buildCounterPivotValue = 0;
buildPivotValue() {
  var o = new api.PivotValue();
  buildCounterPivotValue++;
  if (buildCounterPivotValue < 3) {
    o.formula = "foo";
    o.name = "foo";
    o.sourceColumnOffset = 42;
    o.summarizeFunction = "foo";
  }
  buildCounterPivotValue--;
  return o;
}

checkPivotValue(api.PivotValue o) {
  buildCounterPivotValue++;
  if (buildCounterPivotValue < 3) {
    unittest.expect(o.formula, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.sourceColumnOffset, unittest.equals(42));
    unittest.expect(o.summarizeFunction, unittest.equals('foo'));
  }
  buildCounterPivotValue--;
}

buildUnnamed391() {
  var o = new core.List<api.GridRange>();
  o.add(buildGridRange());
  o.add(buildGridRange());
  return o;
}

checkUnnamed391(core.List<api.GridRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGridRange(o[0]);
  checkGridRange(o[1]);
}

core.int buildCounterProtectedRange = 0;
buildProtectedRange() {
  var o = new api.ProtectedRange();
  buildCounterProtectedRange++;
  if (buildCounterProtectedRange < 3) {
    o.description = "foo";
    o.editors = buildEditors();
    o.namedRangeId = "foo";
    o.protectedRangeId = 42;
    o.range = buildGridRange();
    o.requestingUserCanEdit = true;
    o.unprotectedRanges = buildUnnamed391();
    o.warningOnly = true;
  }
  buildCounterProtectedRange--;
  return o;
}

checkProtectedRange(api.ProtectedRange o) {
  buildCounterProtectedRange++;
  if (buildCounterProtectedRange < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    checkEditors(o.editors);
    unittest.expect(o.namedRangeId, unittest.equals('foo'));
    unittest.expect(o.protectedRangeId, unittest.equals(42));
    checkGridRange(o.range);
    unittest.expect(o.requestingUserCanEdit, unittest.isTrue);
    checkUnnamed391(o.unprotectedRanges);
    unittest.expect(o.warningOnly, unittest.isTrue);
  }
  buildCounterProtectedRange--;
}

core.int buildCounterRepeatCellRequest = 0;
buildRepeatCellRequest() {
  var o = new api.RepeatCellRequest();
  buildCounterRepeatCellRequest++;
  if (buildCounterRepeatCellRequest < 3) {
    o.cell = buildCellData();
    o.fields = "foo";
    o.range = buildGridRange();
  }
  buildCounterRepeatCellRequest--;
  return o;
}

checkRepeatCellRequest(api.RepeatCellRequest o) {
  buildCounterRepeatCellRequest++;
  if (buildCounterRepeatCellRequest < 3) {
    checkCellData(o.cell);
    unittest.expect(o.fields, unittest.equals('foo'));
    checkGridRange(o.range);
  }
  buildCounterRepeatCellRequest--;
}

core.int buildCounterRequest = 0;
buildRequest() {
  var o = new api.Request();
  buildCounterRequest++;
  if (buildCounterRequest < 3) {
    o.addBanding = buildAddBandingRequest();
    o.addChart = buildAddChartRequest();
    o.addConditionalFormatRule = buildAddConditionalFormatRuleRequest();
    o.addFilterView = buildAddFilterViewRequest();
    o.addNamedRange = buildAddNamedRangeRequest();
    o.addProtectedRange = buildAddProtectedRangeRequest();
    o.addSheet = buildAddSheetRequest();
    o.appendCells = buildAppendCellsRequest();
    o.appendDimension = buildAppendDimensionRequest();
    o.autoFill = buildAutoFillRequest();
    o.autoResizeDimensions = buildAutoResizeDimensionsRequest();
    o.clearBasicFilter = buildClearBasicFilterRequest();
    o.copyPaste = buildCopyPasteRequest();
    o.cutPaste = buildCutPasteRequest();
    o.deleteBanding = buildDeleteBandingRequest();
    o.deleteConditionalFormatRule = buildDeleteConditionalFormatRuleRequest();
    o.deleteDimension = buildDeleteDimensionRequest();
    o.deleteEmbeddedObject = buildDeleteEmbeddedObjectRequest();
    o.deleteFilterView = buildDeleteFilterViewRequest();
    o.deleteNamedRange = buildDeleteNamedRangeRequest();
    o.deleteProtectedRange = buildDeleteProtectedRangeRequest();
    o.deleteRange = buildDeleteRangeRequest();
    o.deleteSheet = buildDeleteSheetRequest();
    o.duplicateFilterView = buildDuplicateFilterViewRequest();
    o.duplicateSheet = buildDuplicateSheetRequest();
    o.findReplace = buildFindReplaceRequest();
    o.insertDimension = buildInsertDimensionRequest();
    o.insertRange = buildInsertRangeRequest();
    o.mergeCells = buildMergeCellsRequest();
    o.moveDimension = buildMoveDimensionRequest();
    o.pasteData = buildPasteDataRequest();
    o.repeatCell = buildRepeatCellRequest();
    o.setBasicFilter = buildSetBasicFilterRequest();
    o.setDataValidation = buildSetDataValidationRequest();
    o.sortRange = buildSortRangeRequest();
    o.textToColumns = buildTextToColumnsRequest();
    o.unmergeCells = buildUnmergeCellsRequest();
    o.updateBanding = buildUpdateBandingRequest();
    o.updateBorders = buildUpdateBordersRequest();
    o.updateCells = buildUpdateCellsRequest();
    o.updateChartSpec = buildUpdateChartSpecRequest();
    o.updateConditionalFormatRule = buildUpdateConditionalFormatRuleRequest();
    o.updateDimensionProperties = buildUpdateDimensionPropertiesRequest();
    o.updateEmbeddedObjectPosition = buildUpdateEmbeddedObjectPositionRequest();
    o.updateFilterView = buildUpdateFilterViewRequest();
    o.updateNamedRange = buildUpdateNamedRangeRequest();
    o.updateProtectedRange = buildUpdateProtectedRangeRequest();
    o.updateSheetProperties = buildUpdateSheetPropertiesRequest();
    o.updateSpreadsheetProperties = buildUpdateSpreadsheetPropertiesRequest();
  }
  buildCounterRequest--;
  return o;
}

checkRequest(api.Request o) {
  buildCounterRequest++;
  if (buildCounterRequest < 3) {
    checkAddBandingRequest(o.addBanding);
    checkAddChartRequest(o.addChart);
    checkAddConditionalFormatRuleRequest(o.addConditionalFormatRule);
    checkAddFilterViewRequest(o.addFilterView);
    checkAddNamedRangeRequest(o.addNamedRange);
    checkAddProtectedRangeRequest(o.addProtectedRange);
    checkAddSheetRequest(o.addSheet);
    checkAppendCellsRequest(o.appendCells);
    checkAppendDimensionRequest(o.appendDimension);
    checkAutoFillRequest(o.autoFill);
    checkAutoResizeDimensionsRequest(o.autoResizeDimensions);
    checkClearBasicFilterRequest(o.clearBasicFilter);
    checkCopyPasteRequest(o.copyPaste);
    checkCutPasteRequest(o.cutPaste);
    checkDeleteBandingRequest(o.deleteBanding);
    checkDeleteConditionalFormatRuleRequest(o.deleteConditionalFormatRule);
    checkDeleteDimensionRequest(o.deleteDimension);
    checkDeleteEmbeddedObjectRequest(o.deleteEmbeddedObject);
    checkDeleteFilterViewRequest(o.deleteFilterView);
    checkDeleteNamedRangeRequest(o.deleteNamedRange);
    checkDeleteProtectedRangeRequest(o.deleteProtectedRange);
    checkDeleteRangeRequest(o.deleteRange);
    checkDeleteSheetRequest(o.deleteSheet);
    checkDuplicateFilterViewRequest(o.duplicateFilterView);
    checkDuplicateSheetRequest(o.duplicateSheet);
    checkFindReplaceRequest(o.findReplace);
    checkInsertDimensionRequest(o.insertDimension);
    checkInsertRangeRequest(o.insertRange);
    checkMergeCellsRequest(o.mergeCells);
    checkMoveDimensionRequest(o.moveDimension);
    checkPasteDataRequest(o.pasteData);
    checkRepeatCellRequest(o.repeatCell);
    checkSetBasicFilterRequest(o.setBasicFilter);
    checkSetDataValidationRequest(o.setDataValidation);
    checkSortRangeRequest(o.sortRange);
    checkTextToColumnsRequest(o.textToColumns);
    checkUnmergeCellsRequest(o.unmergeCells);
    checkUpdateBandingRequest(o.updateBanding);
    checkUpdateBordersRequest(o.updateBorders);
    checkUpdateCellsRequest(o.updateCells);
    checkUpdateChartSpecRequest(o.updateChartSpec);
    checkUpdateConditionalFormatRuleRequest(o.updateConditionalFormatRule);
    checkUpdateDimensionPropertiesRequest(o.updateDimensionProperties);
    checkUpdateEmbeddedObjectPositionRequest(o.updateEmbeddedObjectPosition);
    checkUpdateFilterViewRequest(o.updateFilterView);
    checkUpdateNamedRangeRequest(o.updateNamedRange);
    checkUpdateProtectedRangeRequest(o.updateProtectedRange);
    checkUpdateSheetPropertiesRequest(o.updateSheetProperties);
    checkUpdateSpreadsheetPropertiesRequest(o.updateSpreadsheetProperties);
  }
  buildCounterRequest--;
}

core.int buildCounterResponse = 0;
buildResponse() {
  var o = new api.Response();
  buildCounterResponse++;
  if (buildCounterResponse < 3) {
    o.addBanding = buildAddBandingResponse();
    o.addChart = buildAddChartResponse();
    o.addFilterView = buildAddFilterViewResponse();
    o.addNamedRange = buildAddNamedRangeResponse();
    o.addProtectedRange = buildAddProtectedRangeResponse();
    o.addSheet = buildAddSheetResponse();
    o.deleteConditionalFormatRule = buildDeleteConditionalFormatRuleResponse();
    o.duplicateFilterView = buildDuplicateFilterViewResponse();
    o.duplicateSheet = buildDuplicateSheetResponse();
    o.findReplace = buildFindReplaceResponse();
    o.updateConditionalFormatRule = buildUpdateConditionalFormatRuleResponse();
    o.updateEmbeddedObjectPosition = buildUpdateEmbeddedObjectPositionResponse();
  }
  buildCounterResponse--;
  return o;
}

checkResponse(api.Response o) {
  buildCounterResponse++;
  if (buildCounterResponse < 3) {
    checkAddBandingResponse(o.addBanding);
    checkAddChartResponse(o.addChart);
    checkAddFilterViewResponse(o.addFilterView);
    checkAddNamedRangeResponse(o.addNamedRange);
    checkAddProtectedRangeResponse(o.addProtectedRange);
    checkAddSheetResponse(o.addSheet);
    checkDeleteConditionalFormatRuleResponse(o.deleteConditionalFormatRule);
    checkDuplicateFilterViewResponse(o.duplicateFilterView);
    checkDuplicateSheetResponse(o.duplicateSheet);
    checkFindReplaceResponse(o.findReplace);
    checkUpdateConditionalFormatRuleResponse(o.updateConditionalFormatRule);
    checkUpdateEmbeddedObjectPositionResponse(o.updateEmbeddedObjectPosition);
  }
  buildCounterResponse--;
}

buildUnnamed392() {
  var o = new core.List<api.CellData>();
  o.add(buildCellData());
  o.add(buildCellData());
  return o;
}

checkUnnamed392(core.List<api.CellData> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCellData(o[0]);
  checkCellData(o[1]);
}

core.int buildCounterRowData = 0;
buildRowData() {
  var o = new api.RowData();
  buildCounterRowData++;
  if (buildCounterRowData < 3) {
    o.values = buildUnnamed392();
  }
  buildCounterRowData--;
  return o;
}

checkRowData(api.RowData o) {
  buildCounterRowData++;
  if (buildCounterRowData < 3) {
    checkUnnamed392(o.values);
  }
  buildCounterRowData--;
}

core.int buildCounterSetBasicFilterRequest = 0;
buildSetBasicFilterRequest() {
  var o = new api.SetBasicFilterRequest();
  buildCounterSetBasicFilterRequest++;
  if (buildCounterSetBasicFilterRequest < 3) {
    o.filter = buildBasicFilter();
  }
  buildCounterSetBasicFilterRequest--;
  return o;
}

checkSetBasicFilterRequest(api.SetBasicFilterRequest o) {
  buildCounterSetBasicFilterRequest++;
  if (buildCounterSetBasicFilterRequest < 3) {
    checkBasicFilter(o.filter);
  }
  buildCounterSetBasicFilterRequest--;
}

core.int buildCounterSetDataValidationRequest = 0;
buildSetDataValidationRequest() {
  var o = new api.SetDataValidationRequest();
  buildCounterSetDataValidationRequest++;
  if (buildCounterSetDataValidationRequest < 3) {
    o.range = buildGridRange();
    o.rule = buildDataValidationRule();
  }
  buildCounterSetDataValidationRequest--;
  return o;
}

checkSetDataValidationRequest(api.SetDataValidationRequest o) {
  buildCounterSetDataValidationRequest++;
  if (buildCounterSetDataValidationRequest < 3) {
    checkGridRange(o.range);
    checkDataValidationRule(o.rule);
  }
  buildCounterSetDataValidationRequest--;
}

buildUnnamed393() {
  var o = new core.List<api.BandedRange>();
  o.add(buildBandedRange());
  o.add(buildBandedRange());
  return o;
}

checkUnnamed393(core.List<api.BandedRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBandedRange(o[0]);
  checkBandedRange(o[1]);
}

buildUnnamed394() {
  var o = new core.List<api.EmbeddedChart>();
  o.add(buildEmbeddedChart());
  o.add(buildEmbeddedChart());
  return o;
}

checkUnnamed394(core.List<api.EmbeddedChart> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEmbeddedChart(o[0]);
  checkEmbeddedChart(o[1]);
}

buildUnnamed395() {
  var o = new core.List<api.ConditionalFormatRule>();
  o.add(buildConditionalFormatRule());
  o.add(buildConditionalFormatRule());
  return o;
}

checkUnnamed395(core.List<api.ConditionalFormatRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkConditionalFormatRule(o[0]);
  checkConditionalFormatRule(o[1]);
}

buildUnnamed396() {
  var o = new core.List<api.GridData>();
  o.add(buildGridData());
  o.add(buildGridData());
  return o;
}

checkUnnamed396(core.List<api.GridData> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGridData(o[0]);
  checkGridData(o[1]);
}

buildUnnamed397() {
  var o = new core.List<api.FilterView>();
  o.add(buildFilterView());
  o.add(buildFilterView());
  return o;
}

checkUnnamed397(core.List<api.FilterView> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFilterView(o[0]);
  checkFilterView(o[1]);
}

buildUnnamed398() {
  var o = new core.List<api.GridRange>();
  o.add(buildGridRange());
  o.add(buildGridRange());
  return o;
}

checkUnnamed398(core.List<api.GridRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGridRange(o[0]);
  checkGridRange(o[1]);
}

buildUnnamed399() {
  var o = new core.List<api.ProtectedRange>();
  o.add(buildProtectedRange());
  o.add(buildProtectedRange());
  return o;
}

checkUnnamed399(core.List<api.ProtectedRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProtectedRange(o[0]);
  checkProtectedRange(o[1]);
}

core.int buildCounterSheet = 0;
buildSheet() {
  var o = new api.Sheet();
  buildCounterSheet++;
  if (buildCounterSheet < 3) {
    o.bandedRanges = buildUnnamed393();
    o.basicFilter = buildBasicFilter();
    o.charts = buildUnnamed394();
    o.conditionalFormats = buildUnnamed395();
    o.data = buildUnnamed396();
    o.filterViews = buildUnnamed397();
    o.merges = buildUnnamed398();
    o.properties = buildSheetProperties();
    o.protectedRanges = buildUnnamed399();
  }
  buildCounterSheet--;
  return o;
}

checkSheet(api.Sheet o) {
  buildCounterSheet++;
  if (buildCounterSheet < 3) {
    checkUnnamed393(o.bandedRanges);
    checkBasicFilter(o.basicFilter);
    checkUnnamed394(o.charts);
    checkUnnamed395(o.conditionalFormats);
    checkUnnamed396(o.data);
    checkUnnamed397(o.filterViews);
    checkUnnamed398(o.merges);
    checkSheetProperties(o.properties);
    checkUnnamed399(o.protectedRanges);
  }
  buildCounterSheet--;
}

core.int buildCounterSheetProperties = 0;
buildSheetProperties() {
  var o = new api.SheetProperties();
  buildCounterSheetProperties++;
  if (buildCounterSheetProperties < 3) {
    o.gridProperties = buildGridProperties();
    o.hidden = true;
    o.index = 42;
    o.rightToLeft = true;
    o.sheetId = 42;
    o.sheetType = "foo";
    o.tabColor = buildColor();
    o.title = "foo";
  }
  buildCounterSheetProperties--;
  return o;
}

checkSheetProperties(api.SheetProperties o) {
  buildCounterSheetProperties++;
  if (buildCounterSheetProperties < 3) {
    checkGridProperties(o.gridProperties);
    unittest.expect(o.hidden, unittest.isTrue);
    unittest.expect(o.index, unittest.equals(42));
    unittest.expect(o.rightToLeft, unittest.isTrue);
    unittest.expect(o.sheetId, unittest.equals(42));
    unittest.expect(o.sheetType, unittest.equals('foo'));
    checkColor(o.tabColor);
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterSheetProperties--;
}

buildUnnamed400() {
  var o = new core.List<api.SortSpec>();
  o.add(buildSortSpec());
  o.add(buildSortSpec());
  return o;
}

checkUnnamed400(core.List<api.SortSpec> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSortSpec(o[0]);
  checkSortSpec(o[1]);
}

core.int buildCounterSortRangeRequest = 0;
buildSortRangeRequest() {
  var o = new api.SortRangeRequest();
  buildCounterSortRangeRequest++;
  if (buildCounterSortRangeRequest < 3) {
    o.range = buildGridRange();
    o.sortSpecs = buildUnnamed400();
  }
  buildCounterSortRangeRequest--;
  return o;
}

checkSortRangeRequest(api.SortRangeRequest o) {
  buildCounterSortRangeRequest++;
  if (buildCounterSortRangeRequest < 3) {
    checkGridRange(o.range);
    checkUnnamed400(o.sortSpecs);
  }
  buildCounterSortRangeRequest--;
}

core.int buildCounterSortSpec = 0;
buildSortSpec() {
  var o = new api.SortSpec();
  buildCounterSortSpec++;
  if (buildCounterSortSpec < 3) {
    o.dimensionIndex = 42;
    o.sortOrder = "foo";
  }
  buildCounterSortSpec--;
  return o;
}

checkSortSpec(api.SortSpec o) {
  buildCounterSortSpec++;
  if (buildCounterSortSpec < 3) {
    unittest.expect(o.dimensionIndex, unittest.equals(42));
    unittest.expect(o.sortOrder, unittest.equals('foo'));
  }
  buildCounterSortSpec--;
}

core.int buildCounterSourceAndDestination = 0;
buildSourceAndDestination() {
  var o = new api.SourceAndDestination();
  buildCounterSourceAndDestination++;
  if (buildCounterSourceAndDestination < 3) {
    o.dimension = "foo";
    o.fillLength = 42;
    o.source = buildGridRange();
  }
  buildCounterSourceAndDestination--;
  return o;
}

checkSourceAndDestination(api.SourceAndDestination o) {
  buildCounterSourceAndDestination++;
  if (buildCounterSourceAndDestination < 3) {
    unittest.expect(o.dimension, unittest.equals('foo'));
    unittest.expect(o.fillLength, unittest.equals(42));
    checkGridRange(o.source);
  }
  buildCounterSourceAndDestination--;
}

buildUnnamed401() {
  var o = new core.List<api.NamedRange>();
  o.add(buildNamedRange());
  o.add(buildNamedRange());
  return o;
}

checkUnnamed401(core.List<api.NamedRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkNamedRange(o[0]);
  checkNamedRange(o[1]);
}

buildUnnamed402() {
  var o = new core.List<api.Sheet>();
  o.add(buildSheet());
  o.add(buildSheet());
  return o;
}

checkUnnamed402(core.List<api.Sheet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSheet(o[0]);
  checkSheet(o[1]);
}

core.int buildCounterSpreadsheet = 0;
buildSpreadsheet() {
  var o = new api.Spreadsheet();
  buildCounterSpreadsheet++;
  if (buildCounterSpreadsheet < 3) {
    o.namedRanges = buildUnnamed401();
    o.properties = buildSpreadsheetProperties();
    o.sheets = buildUnnamed402();
    o.spreadsheetId = "foo";
    o.spreadsheetUrl = "foo";
  }
  buildCounterSpreadsheet--;
  return o;
}

checkSpreadsheet(api.Spreadsheet o) {
  buildCounterSpreadsheet++;
  if (buildCounterSpreadsheet < 3) {
    checkUnnamed401(o.namedRanges);
    checkSpreadsheetProperties(o.properties);
    checkUnnamed402(o.sheets);
    unittest.expect(o.spreadsheetId, unittest.equals('foo'));
    unittest.expect(o.spreadsheetUrl, unittest.equals('foo'));
  }
  buildCounterSpreadsheet--;
}

core.int buildCounterSpreadsheetProperties = 0;
buildSpreadsheetProperties() {
  var o = new api.SpreadsheetProperties();
  buildCounterSpreadsheetProperties++;
  if (buildCounterSpreadsheetProperties < 3) {
    o.autoRecalc = "foo";
    o.defaultFormat = buildCellFormat();
    o.iterativeCalculationSettings = buildIterativeCalculationSettings();
    o.locale = "foo";
    o.timeZone = "foo";
    o.title = "foo";
  }
  buildCounterSpreadsheetProperties--;
  return o;
}

checkSpreadsheetProperties(api.SpreadsheetProperties o) {
  buildCounterSpreadsheetProperties++;
  if (buildCounterSpreadsheetProperties < 3) {
    unittest.expect(o.autoRecalc, unittest.equals('foo'));
    checkCellFormat(o.defaultFormat);
    checkIterativeCalculationSettings(o.iterativeCalculationSettings);
    unittest.expect(o.locale, unittest.equals('foo'));
    unittest.expect(o.timeZone, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterSpreadsheetProperties--;
}

core.int buildCounterTextFormat = 0;
buildTextFormat() {
  var o = new api.TextFormat();
  buildCounterTextFormat++;
  if (buildCounterTextFormat < 3) {
    o.bold = true;
    o.fontFamily = "foo";
    o.fontSize = 42;
    o.foregroundColor = buildColor();
    o.italic = true;
    o.strikethrough = true;
    o.underline = true;
  }
  buildCounterTextFormat--;
  return o;
}

checkTextFormat(api.TextFormat o) {
  buildCounterTextFormat++;
  if (buildCounterTextFormat < 3) {
    unittest.expect(o.bold, unittest.isTrue);
    unittest.expect(o.fontFamily, unittest.equals('foo'));
    unittest.expect(o.fontSize, unittest.equals(42));
    checkColor(o.foregroundColor);
    unittest.expect(o.italic, unittest.isTrue);
    unittest.expect(o.strikethrough, unittest.isTrue);
    unittest.expect(o.underline, unittest.isTrue);
  }
  buildCounterTextFormat--;
}

core.int buildCounterTextFormatRun = 0;
buildTextFormatRun() {
  var o = new api.TextFormatRun();
  buildCounterTextFormatRun++;
  if (buildCounterTextFormatRun < 3) {
    o.format = buildTextFormat();
    o.startIndex = 42;
  }
  buildCounterTextFormatRun--;
  return o;
}

checkTextFormatRun(api.TextFormatRun o) {
  buildCounterTextFormatRun++;
  if (buildCounterTextFormatRun < 3) {
    checkTextFormat(o.format);
    unittest.expect(o.startIndex, unittest.equals(42));
  }
  buildCounterTextFormatRun--;
}

core.int buildCounterTextToColumnsRequest = 0;
buildTextToColumnsRequest() {
  var o = new api.TextToColumnsRequest();
  buildCounterTextToColumnsRequest++;
  if (buildCounterTextToColumnsRequest < 3) {
    o.delimiter = "foo";
    o.delimiterType = "foo";
    o.source = buildGridRange();
  }
  buildCounterTextToColumnsRequest--;
  return o;
}

checkTextToColumnsRequest(api.TextToColumnsRequest o) {
  buildCounterTextToColumnsRequest++;
  if (buildCounterTextToColumnsRequest < 3) {
    unittest.expect(o.delimiter, unittest.equals('foo'));
    unittest.expect(o.delimiterType, unittest.equals('foo'));
    checkGridRange(o.source);
  }
  buildCounterTextToColumnsRequest--;
}

core.int buildCounterUnmergeCellsRequest = 0;
buildUnmergeCellsRequest() {
  var o = new api.UnmergeCellsRequest();
  buildCounterUnmergeCellsRequest++;
  if (buildCounterUnmergeCellsRequest < 3) {
    o.range = buildGridRange();
  }
  buildCounterUnmergeCellsRequest--;
  return o;
}

checkUnmergeCellsRequest(api.UnmergeCellsRequest o) {
  buildCounterUnmergeCellsRequest++;
  if (buildCounterUnmergeCellsRequest < 3) {
    checkGridRange(o.range);
  }
  buildCounterUnmergeCellsRequest--;
}

core.int buildCounterUpdateBandingRequest = 0;
buildUpdateBandingRequest() {
  var o = new api.UpdateBandingRequest();
  buildCounterUpdateBandingRequest++;
  if (buildCounterUpdateBandingRequest < 3) {
    o.bandedRange = buildBandedRange();
    o.fields = "foo";
  }
  buildCounterUpdateBandingRequest--;
  return o;
}

checkUpdateBandingRequest(api.UpdateBandingRequest o) {
  buildCounterUpdateBandingRequest++;
  if (buildCounterUpdateBandingRequest < 3) {
    checkBandedRange(o.bandedRange);
    unittest.expect(o.fields, unittest.equals('foo'));
  }
  buildCounterUpdateBandingRequest--;
}

core.int buildCounterUpdateBordersRequest = 0;
buildUpdateBordersRequest() {
  var o = new api.UpdateBordersRequest();
  buildCounterUpdateBordersRequest++;
  if (buildCounterUpdateBordersRequest < 3) {
    o.bottom = buildBorder();
    o.innerHorizontal = buildBorder();
    o.innerVertical = buildBorder();
    o.left = buildBorder();
    o.range = buildGridRange();
    o.right = buildBorder();
    o.top = buildBorder();
  }
  buildCounterUpdateBordersRequest--;
  return o;
}

checkUpdateBordersRequest(api.UpdateBordersRequest o) {
  buildCounterUpdateBordersRequest++;
  if (buildCounterUpdateBordersRequest < 3) {
    checkBorder(o.bottom);
    checkBorder(o.innerHorizontal);
    checkBorder(o.innerVertical);
    checkBorder(o.left);
    checkGridRange(o.range);
    checkBorder(o.right);
    checkBorder(o.top);
  }
  buildCounterUpdateBordersRequest--;
}

buildUnnamed403() {
  var o = new core.List<api.RowData>();
  o.add(buildRowData());
  o.add(buildRowData());
  return o;
}

checkUnnamed403(core.List<api.RowData> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRowData(o[0]);
  checkRowData(o[1]);
}

core.int buildCounterUpdateCellsRequest = 0;
buildUpdateCellsRequest() {
  var o = new api.UpdateCellsRequest();
  buildCounterUpdateCellsRequest++;
  if (buildCounterUpdateCellsRequest < 3) {
    o.fields = "foo";
    o.range = buildGridRange();
    o.rows = buildUnnamed403();
    o.start = buildGridCoordinate();
  }
  buildCounterUpdateCellsRequest--;
  return o;
}

checkUpdateCellsRequest(api.UpdateCellsRequest o) {
  buildCounterUpdateCellsRequest++;
  if (buildCounterUpdateCellsRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    checkGridRange(o.range);
    checkUnnamed403(o.rows);
    checkGridCoordinate(o.start);
  }
  buildCounterUpdateCellsRequest--;
}

core.int buildCounterUpdateChartSpecRequest = 0;
buildUpdateChartSpecRequest() {
  var o = new api.UpdateChartSpecRequest();
  buildCounterUpdateChartSpecRequest++;
  if (buildCounterUpdateChartSpecRequest < 3) {
    o.chartId = 42;
    o.spec = buildChartSpec();
  }
  buildCounterUpdateChartSpecRequest--;
  return o;
}

checkUpdateChartSpecRequest(api.UpdateChartSpecRequest o) {
  buildCounterUpdateChartSpecRequest++;
  if (buildCounterUpdateChartSpecRequest < 3) {
    unittest.expect(o.chartId, unittest.equals(42));
    checkChartSpec(o.spec);
  }
  buildCounterUpdateChartSpecRequest--;
}

core.int buildCounterUpdateConditionalFormatRuleRequest = 0;
buildUpdateConditionalFormatRuleRequest() {
  var o = new api.UpdateConditionalFormatRuleRequest();
  buildCounterUpdateConditionalFormatRuleRequest++;
  if (buildCounterUpdateConditionalFormatRuleRequest < 3) {
    o.index = 42;
    o.newIndex = 42;
    o.rule = buildConditionalFormatRule();
    o.sheetId = 42;
  }
  buildCounterUpdateConditionalFormatRuleRequest--;
  return o;
}

checkUpdateConditionalFormatRuleRequest(api.UpdateConditionalFormatRuleRequest o) {
  buildCounterUpdateConditionalFormatRuleRequest++;
  if (buildCounterUpdateConditionalFormatRuleRequest < 3) {
    unittest.expect(o.index, unittest.equals(42));
    unittest.expect(o.newIndex, unittest.equals(42));
    checkConditionalFormatRule(o.rule);
    unittest.expect(o.sheetId, unittest.equals(42));
  }
  buildCounterUpdateConditionalFormatRuleRequest--;
}

core.int buildCounterUpdateConditionalFormatRuleResponse = 0;
buildUpdateConditionalFormatRuleResponse() {
  var o = new api.UpdateConditionalFormatRuleResponse();
  buildCounterUpdateConditionalFormatRuleResponse++;
  if (buildCounterUpdateConditionalFormatRuleResponse < 3) {
    o.newIndex = 42;
    o.newRule = buildConditionalFormatRule();
    o.oldIndex = 42;
    o.oldRule = buildConditionalFormatRule();
  }
  buildCounterUpdateConditionalFormatRuleResponse--;
  return o;
}

checkUpdateConditionalFormatRuleResponse(api.UpdateConditionalFormatRuleResponse o) {
  buildCounterUpdateConditionalFormatRuleResponse++;
  if (buildCounterUpdateConditionalFormatRuleResponse < 3) {
    unittest.expect(o.newIndex, unittest.equals(42));
    checkConditionalFormatRule(o.newRule);
    unittest.expect(o.oldIndex, unittest.equals(42));
    checkConditionalFormatRule(o.oldRule);
  }
  buildCounterUpdateConditionalFormatRuleResponse--;
}

core.int buildCounterUpdateDimensionPropertiesRequest = 0;
buildUpdateDimensionPropertiesRequest() {
  var o = new api.UpdateDimensionPropertiesRequest();
  buildCounterUpdateDimensionPropertiesRequest++;
  if (buildCounterUpdateDimensionPropertiesRequest < 3) {
    o.fields = "foo";
    o.properties = buildDimensionProperties();
    o.range = buildDimensionRange();
  }
  buildCounterUpdateDimensionPropertiesRequest--;
  return o;
}

checkUpdateDimensionPropertiesRequest(api.UpdateDimensionPropertiesRequest o) {
  buildCounterUpdateDimensionPropertiesRequest++;
  if (buildCounterUpdateDimensionPropertiesRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    checkDimensionProperties(o.properties);
    checkDimensionRange(o.range);
  }
  buildCounterUpdateDimensionPropertiesRequest--;
}

core.int buildCounterUpdateEmbeddedObjectPositionRequest = 0;
buildUpdateEmbeddedObjectPositionRequest() {
  var o = new api.UpdateEmbeddedObjectPositionRequest();
  buildCounterUpdateEmbeddedObjectPositionRequest++;
  if (buildCounterUpdateEmbeddedObjectPositionRequest < 3) {
    o.fields = "foo";
    o.newPosition = buildEmbeddedObjectPosition();
    o.objectId = 42;
  }
  buildCounterUpdateEmbeddedObjectPositionRequest--;
  return o;
}

checkUpdateEmbeddedObjectPositionRequest(api.UpdateEmbeddedObjectPositionRequest o) {
  buildCounterUpdateEmbeddedObjectPositionRequest++;
  if (buildCounterUpdateEmbeddedObjectPositionRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    checkEmbeddedObjectPosition(o.newPosition);
    unittest.expect(o.objectId, unittest.equals(42));
  }
  buildCounterUpdateEmbeddedObjectPositionRequest--;
}

core.int buildCounterUpdateEmbeddedObjectPositionResponse = 0;
buildUpdateEmbeddedObjectPositionResponse() {
  var o = new api.UpdateEmbeddedObjectPositionResponse();
  buildCounterUpdateEmbeddedObjectPositionResponse++;
  if (buildCounterUpdateEmbeddedObjectPositionResponse < 3) {
    o.position = buildEmbeddedObjectPosition();
  }
  buildCounterUpdateEmbeddedObjectPositionResponse--;
  return o;
}

checkUpdateEmbeddedObjectPositionResponse(api.UpdateEmbeddedObjectPositionResponse o) {
  buildCounterUpdateEmbeddedObjectPositionResponse++;
  if (buildCounterUpdateEmbeddedObjectPositionResponse < 3) {
    checkEmbeddedObjectPosition(o.position);
  }
  buildCounterUpdateEmbeddedObjectPositionResponse--;
}

core.int buildCounterUpdateFilterViewRequest = 0;
buildUpdateFilterViewRequest() {
  var o = new api.UpdateFilterViewRequest();
  buildCounterUpdateFilterViewRequest++;
  if (buildCounterUpdateFilterViewRequest < 3) {
    o.fields = "foo";
    o.filter = buildFilterView();
  }
  buildCounterUpdateFilterViewRequest--;
  return o;
}

checkUpdateFilterViewRequest(api.UpdateFilterViewRequest o) {
  buildCounterUpdateFilterViewRequest++;
  if (buildCounterUpdateFilterViewRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    checkFilterView(o.filter);
  }
  buildCounterUpdateFilterViewRequest--;
}

core.int buildCounterUpdateNamedRangeRequest = 0;
buildUpdateNamedRangeRequest() {
  var o = new api.UpdateNamedRangeRequest();
  buildCounterUpdateNamedRangeRequest++;
  if (buildCounterUpdateNamedRangeRequest < 3) {
    o.fields = "foo";
    o.namedRange = buildNamedRange();
  }
  buildCounterUpdateNamedRangeRequest--;
  return o;
}

checkUpdateNamedRangeRequest(api.UpdateNamedRangeRequest o) {
  buildCounterUpdateNamedRangeRequest++;
  if (buildCounterUpdateNamedRangeRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    checkNamedRange(o.namedRange);
  }
  buildCounterUpdateNamedRangeRequest--;
}

core.int buildCounterUpdateProtectedRangeRequest = 0;
buildUpdateProtectedRangeRequest() {
  var o = new api.UpdateProtectedRangeRequest();
  buildCounterUpdateProtectedRangeRequest++;
  if (buildCounterUpdateProtectedRangeRequest < 3) {
    o.fields = "foo";
    o.protectedRange = buildProtectedRange();
  }
  buildCounterUpdateProtectedRangeRequest--;
  return o;
}

checkUpdateProtectedRangeRequest(api.UpdateProtectedRangeRequest o) {
  buildCounterUpdateProtectedRangeRequest++;
  if (buildCounterUpdateProtectedRangeRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    checkProtectedRange(o.protectedRange);
  }
  buildCounterUpdateProtectedRangeRequest--;
}

core.int buildCounterUpdateSheetPropertiesRequest = 0;
buildUpdateSheetPropertiesRequest() {
  var o = new api.UpdateSheetPropertiesRequest();
  buildCounterUpdateSheetPropertiesRequest++;
  if (buildCounterUpdateSheetPropertiesRequest < 3) {
    o.fields = "foo";
    o.properties = buildSheetProperties();
  }
  buildCounterUpdateSheetPropertiesRequest--;
  return o;
}

checkUpdateSheetPropertiesRequest(api.UpdateSheetPropertiesRequest o) {
  buildCounterUpdateSheetPropertiesRequest++;
  if (buildCounterUpdateSheetPropertiesRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    checkSheetProperties(o.properties);
  }
  buildCounterUpdateSheetPropertiesRequest--;
}

core.int buildCounterUpdateSpreadsheetPropertiesRequest = 0;
buildUpdateSpreadsheetPropertiesRequest() {
  var o = new api.UpdateSpreadsheetPropertiesRequest();
  buildCounterUpdateSpreadsheetPropertiesRequest++;
  if (buildCounterUpdateSpreadsheetPropertiesRequest < 3) {
    o.fields = "foo";
    o.properties = buildSpreadsheetProperties();
  }
  buildCounterUpdateSpreadsheetPropertiesRequest--;
  return o;
}

checkUpdateSpreadsheetPropertiesRequest(api.UpdateSpreadsheetPropertiesRequest o) {
  buildCounterUpdateSpreadsheetPropertiesRequest++;
  if (buildCounterUpdateSpreadsheetPropertiesRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    checkSpreadsheetProperties(o.properties);
  }
  buildCounterUpdateSpreadsheetPropertiesRequest--;
}

core.int buildCounterUpdateValuesResponse = 0;
buildUpdateValuesResponse() {
  var o = new api.UpdateValuesResponse();
  buildCounterUpdateValuesResponse++;
  if (buildCounterUpdateValuesResponse < 3) {
    o.spreadsheetId = "foo";
    o.updatedCells = 42;
    o.updatedColumns = 42;
    o.updatedData = buildValueRange();
    o.updatedRange = "foo";
    o.updatedRows = 42;
  }
  buildCounterUpdateValuesResponse--;
  return o;
}

checkUpdateValuesResponse(api.UpdateValuesResponse o) {
  buildCounterUpdateValuesResponse++;
  if (buildCounterUpdateValuesResponse < 3) {
    unittest.expect(o.spreadsheetId, unittest.equals('foo'));
    unittest.expect(o.updatedCells, unittest.equals(42));
    unittest.expect(o.updatedColumns, unittest.equals(42));
    checkValueRange(o.updatedData);
    unittest.expect(o.updatedRange, unittest.equals('foo'));
    unittest.expect(o.updatedRows, unittest.equals(42));
  }
  buildCounterUpdateValuesResponse--;
}

buildUnnamed404() {
  var o = new core.List<core.Object>();
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  return o;
}

checkUnnamed404(core.List<core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o[0]) as core.Map; unittest.expect(casted1, unittest.hasLength(3)); unittest.expect(casted1["list"], unittest.equals([1, 2, 3])); unittest.expect(casted1["bool"], unittest.equals(true)); unittest.expect(casted1["string"], unittest.equals('foo')); 
  var casted2 = (o[1]) as core.Map; unittest.expect(casted2, unittest.hasLength(3)); unittest.expect(casted2["list"], unittest.equals([1, 2, 3])); unittest.expect(casted2["bool"], unittest.equals(true)); unittest.expect(casted2["string"], unittest.equals('foo')); 
}

buildUnnamed405() {
  var o = new core.List<core.List<core.Object>>();
  o.add(buildUnnamed404());
  o.add(buildUnnamed404());
  return o;
}

checkUnnamed405(core.List<core.List<core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed404(o[0]);
  checkUnnamed404(o[1]);
}

core.int buildCounterValueRange = 0;
buildValueRange() {
  var o = new api.ValueRange();
  buildCounterValueRange++;
  if (buildCounterValueRange < 3) {
    o.majorDimension = "foo";
    o.range = "foo";
    o.values = buildUnnamed405();
  }
  buildCounterValueRange--;
  return o;
}

checkValueRange(api.ValueRange o) {
  buildCounterValueRange++;
  if (buildCounterValueRange < 3) {
    unittest.expect(o.majorDimension, unittest.equals('foo'));
    unittest.expect(o.range, unittest.equals('foo'));
    checkUnnamed405(o.values);
  }
  buildCounterValueRange--;
}

buildUnnamed406() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed406(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed407() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed407(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}


main() {
  unittest.group("obj-schema-AddBandingRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddBandingRequest();
      var od = new api.AddBandingRequest.fromJson(o.toJson());
      checkAddBandingRequest(od);
    });
  });


  unittest.group("obj-schema-AddBandingResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddBandingResponse();
      var od = new api.AddBandingResponse.fromJson(o.toJson());
      checkAddBandingResponse(od);
    });
  });


  unittest.group("obj-schema-AddChartRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddChartRequest();
      var od = new api.AddChartRequest.fromJson(o.toJson());
      checkAddChartRequest(od);
    });
  });


  unittest.group("obj-schema-AddChartResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddChartResponse();
      var od = new api.AddChartResponse.fromJson(o.toJson());
      checkAddChartResponse(od);
    });
  });


  unittest.group("obj-schema-AddConditionalFormatRuleRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddConditionalFormatRuleRequest();
      var od = new api.AddConditionalFormatRuleRequest.fromJson(o.toJson());
      checkAddConditionalFormatRuleRequest(od);
    });
  });


  unittest.group("obj-schema-AddFilterViewRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddFilterViewRequest();
      var od = new api.AddFilterViewRequest.fromJson(o.toJson());
      checkAddFilterViewRequest(od);
    });
  });


  unittest.group("obj-schema-AddFilterViewResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddFilterViewResponse();
      var od = new api.AddFilterViewResponse.fromJson(o.toJson());
      checkAddFilterViewResponse(od);
    });
  });


  unittest.group("obj-schema-AddNamedRangeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddNamedRangeRequest();
      var od = new api.AddNamedRangeRequest.fromJson(o.toJson());
      checkAddNamedRangeRequest(od);
    });
  });


  unittest.group("obj-schema-AddNamedRangeResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddNamedRangeResponse();
      var od = new api.AddNamedRangeResponse.fromJson(o.toJson());
      checkAddNamedRangeResponse(od);
    });
  });


  unittest.group("obj-schema-AddProtectedRangeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddProtectedRangeRequest();
      var od = new api.AddProtectedRangeRequest.fromJson(o.toJson());
      checkAddProtectedRangeRequest(od);
    });
  });


  unittest.group("obj-schema-AddProtectedRangeResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddProtectedRangeResponse();
      var od = new api.AddProtectedRangeResponse.fromJson(o.toJson());
      checkAddProtectedRangeResponse(od);
    });
  });


  unittest.group("obj-schema-AddSheetRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddSheetRequest();
      var od = new api.AddSheetRequest.fromJson(o.toJson());
      checkAddSheetRequest(od);
    });
  });


  unittest.group("obj-schema-AddSheetResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddSheetResponse();
      var od = new api.AddSheetResponse.fromJson(o.toJson());
      checkAddSheetResponse(od);
    });
  });


  unittest.group("obj-schema-AppendCellsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAppendCellsRequest();
      var od = new api.AppendCellsRequest.fromJson(o.toJson());
      checkAppendCellsRequest(od);
    });
  });


  unittest.group("obj-schema-AppendDimensionRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAppendDimensionRequest();
      var od = new api.AppendDimensionRequest.fromJson(o.toJson());
      checkAppendDimensionRequest(od);
    });
  });


  unittest.group("obj-schema-AppendValuesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAppendValuesResponse();
      var od = new api.AppendValuesResponse.fromJson(o.toJson());
      checkAppendValuesResponse(od);
    });
  });


  unittest.group("obj-schema-AutoFillRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAutoFillRequest();
      var od = new api.AutoFillRequest.fromJson(o.toJson());
      checkAutoFillRequest(od);
    });
  });


  unittest.group("obj-schema-AutoResizeDimensionsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAutoResizeDimensionsRequest();
      var od = new api.AutoResizeDimensionsRequest.fromJson(o.toJson());
      checkAutoResizeDimensionsRequest(od);
    });
  });


  unittest.group("obj-schema-BandedRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildBandedRange();
      var od = new api.BandedRange.fromJson(o.toJson());
      checkBandedRange(od);
    });
  });


  unittest.group("obj-schema-BandingProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildBandingProperties();
      var od = new api.BandingProperties.fromJson(o.toJson());
      checkBandingProperties(od);
    });
  });


  unittest.group("obj-schema-BasicChartAxis", () {
    unittest.test("to-json--from-json", () {
      var o = buildBasicChartAxis();
      var od = new api.BasicChartAxis.fromJson(o.toJson());
      checkBasicChartAxis(od);
    });
  });


  unittest.group("obj-schema-BasicChartDomain", () {
    unittest.test("to-json--from-json", () {
      var o = buildBasicChartDomain();
      var od = new api.BasicChartDomain.fromJson(o.toJson());
      checkBasicChartDomain(od);
    });
  });


  unittest.group("obj-schema-BasicChartSeries", () {
    unittest.test("to-json--from-json", () {
      var o = buildBasicChartSeries();
      var od = new api.BasicChartSeries.fromJson(o.toJson());
      checkBasicChartSeries(od);
    });
  });


  unittest.group("obj-schema-BasicChartSpec", () {
    unittest.test("to-json--from-json", () {
      var o = buildBasicChartSpec();
      var od = new api.BasicChartSpec.fromJson(o.toJson());
      checkBasicChartSpec(od);
    });
  });


  unittest.group("obj-schema-BasicFilter", () {
    unittest.test("to-json--from-json", () {
      var o = buildBasicFilter();
      var od = new api.BasicFilter.fromJson(o.toJson());
      checkBasicFilter(od);
    });
  });


  unittest.group("obj-schema-BatchClearValuesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchClearValuesRequest();
      var od = new api.BatchClearValuesRequest.fromJson(o.toJson());
      checkBatchClearValuesRequest(od);
    });
  });


  unittest.group("obj-schema-BatchClearValuesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchClearValuesResponse();
      var od = new api.BatchClearValuesResponse.fromJson(o.toJson());
      checkBatchClearValuesResponse(od);
    });
  });


  unittest.group("obj-schema-BatchGetValuesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchGetValuesResponse();
      var od = new api.BatchGetValuesResponse.fromJson(o.toJson());
      checkBatchGetValuesResponse(od);
    });
  });


  unittest.group("obj-schema-BatchUpdateSpreadsheetRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchUpdateSpreadsheetRequest();
      var od = new api.BatchUpdateSpreadsheetRequest.fromJson(o.toJson());
      checkBatchUpdateSpreadsheetRequest(od);
    });
  });


  unittest.group("obj-schema-BatchUpdateSpreadsheetResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchUpdateSpreadsheetResponse();
      var od = new api.BatchUpdateSpreadsheetResponse.fromJson(o.toJson());
      checkBatchUpdateSpreadsheetResponse(od);
    });
  });


  unittest.group("obj-schema-BatchUpdateValuesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchUpdateValuesRequest();
      var od = new api.BatchUpdateValuesRequest.fromJson(o.toJson());
      checkBatchUpdateValuesRequest(od);
    });
  });


  unittest.group("obj-schema-BatchUpdateValuesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchUpdateValuesResponse();
      var od = new api.BatchUpdateValuesResponse.fromJson(o.toJson());
      checkBatchUpdateValuesResponse(od);
    });
  });


  unittest.group("obj-schema-BooleanCondition", () {
    unittest.test("to-json--from-json", () {
      var o = buildBooleanCondition();
      var od = new api.BooleanCondition.fromJson(o.toJson());
      checkBooleanCondition(od);
    });
  });


  unittest.group("obj-schema-BooleanRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildBooleanRule();
      var od = new api.BooleanRule.fromJson(o.toJson());
      checkBooleanRule(od);
    });
  });


  unittest.group("obj-schema-Border", () {
    unittest.test("to-json--from-json", () {
      var o = buildBorder();
      var od = new api.Border.fromJson(o.toJson());
      checkBorder(od);
    });
  });


  unittest.group("obj-schema-Borders", () {
    unittest.test("to-json--from-json", () {
      var o = buildBorders();
      var od = new api.Borders.fromJson(o.toJson());
      checkBorders(od);
    });
  });


  unittest.group("obj-schema-CellData", () {
    unittest.test("to-json--from-json", () {
      var o = buildCellData();
      var od = new api.CellData.fromJson(o.toJson());
      checkCellData(od);
    });
  });


  unittest.group("obj-schema-CellFormat", () {
    unittest.test("to-json--from-json", () {
      var o = buildCellFormat();
      var od = new api.CellFormat.fromJson(o.toJson());
      checkCellFormat(od);
    });
  });


  unittest.group("obj-schema-ChartData", () {
    unittest.test("to-json--from-json", () {
      var o = buildChartData();
      var od = new api.ChartData.fromJson(o.toJson());
      checkChartData(od);
    });
  });


  unittest.group("obj-schema-ChartSourceRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildChartSourceRange();
      var od = new api.ChartSourceRange.fromJson(o.toJson());
      checkChartSourceRange(od);
    });
  });


  unittest.group("obj-schema-ChartSpec", () {
    unittest.test("to-json--from-json", () {
      var o = buildChartSpec();
      var od = new api.ChartSpec.fromJson(o.toJson());
      checkChartSpec(od);
    });
  });


  unittest.group("obj-schema-ClearBasicFilterRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildClearBasicFilterRequest();
      var od = new api.ClearBasicFilterRequest.fromJson(o.toJson());
      checkClearBasicFilterRequest(od);
    });
  });


  unittest.group("obj-schema-ClearValuesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildClearValuesRequest();
      var od = new api.ClearValuesRequest.fromJson(o.toJson());
      checkClearValuesRequest(od);
    });
  });


  unittest.group("obj-schema-ClearValuesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildClearValuesResponse();
      var od = new api.ClearValuesResponse.fromJson(o.toJson());
      checkClearValuesResponse(od);
    });
  });


  unittest.group("obj-schema-Color", () {
    unittest.test("to-json--from-json", () {
      var o = buildColor();
      var od = new api.Color.fromJson(o.toJson());
      checkColor(od);
    });
  });


  unittest.group("obj-schema-ConditionValue", () {
    unittest.test("to-json--from-json", () {
      var o = buildConditionValue();
      var od = new api.ConditionValue.fromJson(o.toJson());
      checkConditionValue(od);
    });
  });


  unittest.group("obj-schema-ConditionalFormatRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildConditionalFormatRule();
      var od = new api.ConditionalFormatRule.fromJson(o.toJson());
      checkConditionalFormatRule(od);
    });
  });


  unittest.group("obj-schema-CopyPasteRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCopyPasteRequest();
      var od = new api.CopyPasteRequest.fromJson(o.toJson());
      checkCopyPasteRequest(od);
    });
  });


  unittest.group("obj-schema-CopySheetToAnotherSpreadsheetRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCopySheetToAnotherSpreadsheetRequest();
      var od = new api.CopySheetToAnotherSpreadsheetRequest.fromJson(o.toJson());
      checkCopySheetToAnotherSpreadsheetRequest(od);
    });
  });


  unittest.group("obj-schema-CutPasteRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCutPasteRequest();
      var od = new api.CutPasteRequest.fromJson(o.toJson());
      checkCutPasteRequest(od);
    });
  });


  unittest.group("obj-schema-DataValidationRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildDataValidationRule();
      var od = new api.DataValidationRule.fromJson(o.toJson());
      checkDataValidationRule(od);
    });
  });


  unittest.group("obj-schema-DeleteBandingRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteBandingRequest();
      var od = new api.DeleteBandingRequest.fromJson(o.toJson());
      checkDeleteBandingRequest(od);
    });
  });


  unittest.group("obj-schema-DeleteConditionalFormatRuleRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteConditionalFormatRuleRequest();
      var od = new api.DeleteConditionalFormatRuleRequest.fromJson(o.toJson());
      checkDeleteConditionalFormatRuleRequest(od);
    });
  });


  unittest.group("obj-schema-DeleteConditionalFormatRuleResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteConditionalFormatRuleResponse();
      var od = new api.DeleteConditionalFormatRuleResponse.fromJson(o.toJson());
      checkDeleteConditionalFormatRuleResponse(od);
    });
  });


  unittest.group("obj-schema-DeleteDimensionRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteDimensionRequest();
      var od = new api.DeleteDimensionRequest.fromJson(o.toJson());
      checkDeleteDimensionRequest(od);
    });
  });


  unittest.group("obj-schema-DeleteEmbeddedObjectRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteEmbeddedObjectRequest();
      var od = new api.DeleteEmbeddedObjectRequest.fromJson(o.toJson());
      checkDeleteEmbeddedObjectRequest(od);
    });
  });


  unittest.group("obj-schema-DeleteFilterViewRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteFilterViewRequest();
      var od = new api.DeleteFilterViewRequest.fromJson(o.toJson());
      checkDeleteFilterViewRequest(od);
    });
  });


  unittest.group("obj-schema-DeleteNamedRangeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteNamedRangeRequest();
      var od = new api.DeleteNamedRangeRequest.fromJson(o.toJson());
      checkDeleteNamedRangeRequest(od);
    });
  });


  unittest.group("obj-schema-DeleteProtectedRangeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteProtectedRangeRequest();
      var od = new api.DeleteProtectedRangeRequest.fromJson(o.toJson());
      checkDeleteProtectedRangeRequest(od);
    });
  });


  unittest.group("obj-schema-DeleteRangeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteRangeRequest();
      var od = new api.DeleteRangeRequest.fromJson(o.toJson());
      checkDeleteRangeRequest(od);
    });
  });


  unittest.group("obj-schema-DeleteSheetRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteSheetRequest();
      var od = new api.DeleteSheetRequest.fromJson(o.toJson());
      checkDeleteSheetRequest(od);
    });
  });


  unittest.group("obj-schema-DimensionProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildDimensionProperties();
      var od = new api.DimensionProperties.fromJson(o.toJson());
      checkDimensionProperties(od);
    });
  });


  unittest.group("obj-schema-DimensionRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildDimensionRange();
      var od = new api.DimensionRange.fromJson(o.toJson());
      checkDimensionRange(od);
    });
  });


  unittest.group("obj-schema-DuplicateFilterViewRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDuplicateFilterViewRequest();
      var od = new api.DuplicateFilterViewRequest.fromJson(o.toJson());
      checkDuplicateFilterViewRequest(od);
    });
  });


  unittest.group("obj-schema-DuplicateFilterViewResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildDuplicateFilterViewResponse();
      var od = new api.DuplicateFilterViewResponse.fromJson(o.toJson());
      checkDuplicateFilterViewResponse(od);
    });
  });


  unittest.group("obj-schema-DuplicateSheetRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDuplicateSheetRequest();
      var od = new api.DuplicateSheetRequest.fromJson(o.toJson());
      checkDuplicateSheetRequest(od);
    });
  });


  unittest.group("obj-schema-DuplicateSheetResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildDuplicateSheetResponse();
      var od = new api.DuplicateSheetResponse.fromJson(o.toJson());
      checkDuplicateSheetResponse(od);
    });
  });


  unittest.group("obj-schema-Editors", () {
    unittest.test("to-json--from-json", () {
      var o = buildEditors();
      var od = new api.Editors.fromJson(o.toJson());
      checkEditors(od);
    });
  });


  unittest.group("obj-schema-EmbeddedChart", () {
    unittest.test("to-json--from-json", () {
      var o = buildEmbeddedChart();
      var od = new api.EmbeddedChart.fromJson(o.toJson());
      checkEmbeddedChart(od);
    });
  });


  unittest.group("obj-schema-EmbeddedObjectPosition", () {
    unittest.test("to-json--from-json", () {
      var o = buildEmbeddedObjectPosition();
      var od = new api.EmbeddedObjectPosition.fromJson(o.toJson());
      checkEmbeddedObjectPosition(od);
    });
  });


  unittest.group("obj-schema-ErrorValue", () {
    unittest.test("to-json--from-json", () {
      var o = buildErrorValue();
      var od = new api.ErrorValue.fromJson(o.toJson());
      checkErrorValue(od);
    });
  });


  unittest.group("obj-schema-ExtendedValue", () {
    unittest.test("to-json--from-json", () {
      var o = buildExtendedValue();
      var od = new api.ExtendedValue.fromJson(o.toJson());
      checkExtendedValue(od);
    });
  });


  unittest.group("obj-schema-FilterCriteria", () {
    unittest.test("to-json--from-json", () {
      var o = buildFilterCriteria();
      var od = new api.FilterCriteria.fromJson(o.toJson());
      checkFilterCriteria(od);
    });
  });


  unittest.group("obj-schema-FilterView", () {
    unittest.test("to-json--from-json", () {
      var o = buildFilterView();
      var od = new api.FilterView.fromJson(o.toJson());
      checkFilterView(od);
    });
  });


  unittest.group("obj-schema-FindReplaceRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildFindReplaceRequest();
      var od = new api.FindReplaceRequest.fromJson(o.toJson());
      checkFindReplaceRequest(od);
    });
  });


  unittest.group("obj-schema-FindReplaceResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildFindReplaceResponse();
      var od = new api.FindReplaceResponse.fromJson(o.toJson());
      checkFindReplaceResponse(od);
    });
  });


  unittest.group("obj-schema-GradientRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildGradientRule();
      var od = new api.GradientRule.fromJson(o.toJson());
      checkGradientRule(od);
    });
  });


  unittest.group("obj-schema-GridCoordinate", () {
    unittest.test("to-json--from-json", () {
      var o = buildGridCoordinate();
      var od = new api.GridCoordinate.fromJson(o.toJson());
      checkGridCoordinate(od);
    });
  });


  unittest.group("obj-schema-GridData", () {
    unittest.test("to-json--from-json", () {
      var o = buildGridData();
      var od = new api.GridData.fromJson(o.toJson());
      checkGridData(od);
    });
  });


  unittest.group("obj-schema-GridProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildGridProperties();
      var od = new api.GridProperties.fromJson(o.toJson());
      checkGridProperties(od);
    });
  });


  unittest.group("obj-schema-GridRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildGridRange();
      var od = new api.GridRange.fromJson(o.toJson());
      checkGridRange(od);
    });
  });


  unittest.group("obj-schema-InsertDimensionRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInsertDimensionRequest();
      var od = new api.InsertDimensionRequest.fromJson(o.toJson());
      checkInsertDimensionRequest(od);
    });
  });


  unittest.group("obj-schema-InsertRangeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInsertRangeRequest();
      var od = new api.InsertRangeRequest.fromJson(o.toJson());
      checkInsertRangeRequest(od);
    });
  });


  unittest.group("obj-schema-InterpolationPoint", () {
    unittest.test("to-json--from-json", () {
      var o = buildInterpolationPoint();
      var od = new api.InterpolationPoint.fromJson(o.toJson());
      checkInterpolationPoint(od);
    });
  });


  unittest.group("obj-schema-IterativeCalculationSettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildIterativeCalculationSettings();
      var od = new api.IterativeCalculationSettings.fromJson(o.toJson());
      checkIterativeCalculationSettings(od);
    });
  });


  unittest.group("obj-schema-MergeCellsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildMergeCellsRequest();
      var od = new api.MergeCellsRequest.fromJson(o.toJson());
      checkMergeCellsRequest(od);
    });
  });


  unittest.group("obj-schema-MoveDimensionRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildMoveDimensionRequest();
      var od = new api.MoveDimensionRequest.fromJson(o.toJson());
      checkMoveDimensionRequest(od);
    });
  });


  unittest.group("obj-schema-NamedRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildNamedRange();
      var od = new api.NamedRange.fromJson(o.toJson());
      checkNamedRange(od);
    });
  });


  unittest.group("obj-schema-NumberFormat", () {
    unittest.test("to-json--from-json", () {
      var o = buildNumberFormat();
      var od = new api.NumberFormat.fromJson(o.toJson());
      checkNumberFormat(od);
    });
  });


  unittest.group("obj-schema-OverlayPosition", () {
    unittest.test("to-json--from-json", () {
      var o = buildOverlayPosition();
      var od = new api.OverlayPosition.fromJson(o.toJson());
      checkOverlayPosition(od);
    });
  });


  unittest.group("obj-schema-Padding", () {
    unittest.test("to-json--from-json", () {
      var o = buildPadding();
      var od = new api.Padding.fromJson(o.toJson());
      checkPadding(od);
    });
  });


  unittest.group("obj-schema-PasteDataRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildPasteDataRequest();
      var od = new api.PasteDataRequest.fromJson(o.toJson());
      checkPasteDataRequest(od);
    });
  });


  unittest.group("obj-schema-PieChartSpec", () {
    unittest.test("to-json--from-json", () {
      var o = buildPieChartSpec();
      var od = new api.PieChartSpec.fromJson(o.toJson());
      checkPieChartSpec(od);
    });
  });


  unittest.group("obj-schema-PivotFilterCriteria", () {
    unittest.test("to-json--from-json", () {
      var o = buildPivotFilterCriteria();
      var od = new api.PivotFilterCriteria.fromJson(o.toJson());
      checkPivotFilterCriteria(od);
    });
  });


  unittest.group("obj-schema-PivotGroup", () {
    unittest.test("to-json--from-json", () {
      var o = buildPivotGroup();
      var od = new api.PivotGroup.fromJson(o.toJson());
      checkPivotGroup(od);
    });
  });


  unittest.group("obj-schema-PivotGroupSortValueBucket", () {
    unittest.test("to-json--from-json", () {
      var o = buildPivotGroupSortValueBucket();
      var od = new api.PivotGroupSortValueBucket.fromJson(o.toJson());
      checkPivotGroupSortValueBucket(od);
    });
  });


  unittest.group("obj-schema-PivotGroupValueMetadata", () {
    unittest.test("to-json--from-json", () {
      var o = buildPivotGroupValueMetadata();
      var od = new api.PivotGroupValueMetadata.fromJson(o.toJson());
      checkPivotGroupValueMetadata(od);
    });
  });


  unittest.group("obj-schema-PivotTable", () {
    unittest.test("to-json--from-json", () {
      var o = buildPivotTable();
      var od = new api.PivotTable.fromJson(o.toJson());
      checkPivotTable(od);
    });
  });


  unittest.group("obj-schema-PivotValue", () {
    unittest.test("to-json--from-json", () {
      var o = buildPivotValue();
      var od = new api.PivotValue.fromJson(o.toJson());
      checkPivotValue(od);
    });
  });


  unittest.group("obj-schema-ProtectedRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildProtectedRange();
      var od = new api.ProtectedRange.fromJson(o.toJson());
      checkProtectedRange(od);
    });
  });


  unittest.group("obj-schema-RepeatCellRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildRepeatCellRequest();
      var od = new api.RepeatCellRequest.fromJson(o.toJson());
      checkRepeatCellRequest(od);
    });
  });


  unittest.group("obj-schema-Request", () {
    unittest.test("to-json--from-json", () {
      var o = buildRequest();
      var od = new api.Request.fromJson(o.toJson());
      checkRequest(od);
    });
  });


  unittest.group("obj-schema-Response", () {
    unittest.test("to-json--from-json", () {
      var o = buildResponse();
      var od = new api.Response.fromJson(o.toJson());
      checkResponse(od);
    });
  });


  unittest.group("obj-schema-RowData", () {
    unittest.test("to-json--from-json", () {
      var o = buildRowData();
      var od = new api.RowData.fromJson(o.toJson());
      checkRowData(od);
    });
  });


  unittest.group("obj-schema-SetBasicFilterRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildSetBasicFilterRequest();
      var od = new api.SetBasicFilterRequest.fromJson(o.toJson());
      checkSetBasicFilterRequest(od);
    });
  });


  unittest.group("obj-schema-SetDataValidationRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildSetDataValidationRequest();
      var od = new api.SetDataValidationRequest.fromJson(o.toJson());
      checkSetDataValidationRequest(od);
    });
  });


  unittest.group("obj-schema-Sheet", () {
    unittest.test("to-json--from-json", () {
      var o = buildSheet();
      var od = new api.Sheet.fromJson(o.toJson());
      checkSheet(od);
    });
  });


  unittest.group("obj-schema-SheetProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildSheetProperties();
      var od = new api.SheetProperties.fromJson(o.toJson());
      checkSheetProperties(od);
    });
  });


  unittest.group("obj-schema-SortRangeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildSortRangeRequest();
      var od = new api.SortRangeRequest.fromJson(o.toJson());
      checkSortRangeRequest(od);
    });
  });


  unittest.group("obj-schema-SortSpec", () {
    unittest.test("to-json--from-json", () {
      var o = buildSortSpec();
      var od = new api.SortSpec.fromJson(o.toJson());
      checkSortSpec(od);
    });
  });


  unittest.group("obj-schema-SourceAndDestination", () {
    unittest.test("to-json--from-json", () {
      var o = buildSourceAndDestination();
      var od = new api.SourceAndDestination.fromJson(o.toJson());
      checkSourceAndDestination(od);
    });
  });


  unittest.group("obj-schema-Spreadsheet", () {
    unittest.test("to-json--from-json", () {
      var o = buildSpreadsheet();
      var od = new api.Spreadsheet.fromJson(o.toJson());
      checkSpreadsheet(od);
    });
  });


  unittest.group("obj-schema-SpreadsheetProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildSpreadsheetProperties();
      var od = new api.SpreadsheetProperties.fromJson(o.toJson());
      checkSpreadsheetProperties(od);
    });
  });


  unittest.group("obj-schema-TextFormat", () {
    unittest.test("to-json--from-json", () {
      var o = buildTextFormat();
      var od = new api.TextFormat.fromJson(o.toJson());
      checkTextFormat(od);
    });
  });


  unittest.group("obj-schema-TextFormatRun", () {
    unittest.test("to-json--from-json", () {
      var o = buildTextFormatRun();
      var od = new api.TextFormatRun.fromJson(o.toJson());
      checkTextFormatRun(od);
    });
  });


  unittest.group("obj-schema-TextToColumnsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildTextToColumnsRequest();
      var od = new api.TextToColumnsRequest.fromJson(o.toJson());
      checkTextToColumnsRequest(od);
    });
  });


  unittest.group("obj-schema-UnmergeCellsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUnmergeCellsRequest();
      var od = new api.UnmergeCellsRequest.fromJson(o.toJson());
      checkUnmergeCellsRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateBandingRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateBandingRequest();
      var od = new api.UpdateBandingRequest.fromJson(o.toJson());
      checkUpdateBandingRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateBordersRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateBordersRequest();
      var od = new api.UpdateBordersRequest.fromJson(o.toJson());
      checkUpdateBordersRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateCellsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateCellsRequest();
      var od = new api.UpdateCellsRequest.fromJson(o.toJson());
      checkUpdateCellsRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateChartSpecRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateChartSpecRequest();
      var od = new api.UpdateChartSpecRequest.fromJson(o.toJson());
      checkUpdateChartSpecRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateConditionalFormatRuleRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateConditionalFormatRuleRequest();
      var od = new api.UpdateConditionalFormatRuleRequest.fromJson(o.toJson());
      checkUpdateConditionalFormatRuleRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateConditionalFormatRuleResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateConditionalFormatRuleResponse();
      var od = new api.UpdateConditionalFormatRuleResponse.fromJson(o.toJson());
      checkUpdateConditionalFormatRuleResponse(od);
    });
  });


  unittest.group("obj-schema-UpdateDimensionPropertiesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateDimensionPropertiesRequest();
      var od = new api.UpdateDimensionPropertiesRequest.fromJson(o.toJson());
      checkUpdateDimensionPropertiesRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateEmbeddedObjectPositionRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateEmbeddedObjectPositionRequest();
      var od = new api.UpdateEmbeddedObjectPositionRequest.fromJson(o.toJson());
      checkUpdateEmbeddedObjectPositionRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateEmbeddedObjectPositionResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateEmbeddedObjectPositionResponse();
      var od = new api.UpdateEmbeddedObjectPositionResponse.fromJson(o.toJson());
      checkUpdateEmbeddedObjectPositionResponse(od);
    });
  });


  unittest.group("obj-schema-UpdateFilterViewRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateFilterViewRequest();
      var od = new api.UpdateFilterViewRequest.fromJson(o.toJson());
      checkUpdateFilterViewRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateNamedRangeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateNamedRangeRequest();
      var od = new api.UpdateNamedRangeRequest.fromJson(o.toJson());
      checkUpdateNamedRangeRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateProtectedRangeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateProtectedRangeRequest();
      var od = new api.UpdateProtectedRangeRequest.fromJson(o.toJson());
      checkUpdateProtectedRangeRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateSheetPropertiesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateSheetPropertiesRequest();
      var od = new api.UpdateSheetPropertiesRequest.fromJson(o.toJson());
      checkUpdateSheetPropertiesRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateSpreadsheetPropertiesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateSpreadsheetPropertiesRequest();
      var od = new api.UpdateSpreadsheetPropertiesRequest.fromJson(o.toJson());
      checkUpdateSpreadsheetPropertiesRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateValuesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateValuesResponse();
      var od = new api.UpdateValuesResponse.fromJson(o.toJson());
      checkUpdateValuesResponse(od);
    });
  });


  unittest.group("obj-schema-ValueRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildValueRange();
      var od = new api.ValueRange.fromJson(o.toJson());
      checkValueRange(od);
    });
  });


  unittest.group("resource-SpreadsheetsResourceApi", () {
    unittest.test("method--batchUpdate", () {

      var mock = new HttpServerMock();
      api.SpreadsheetsResourceApi res = new api.SheetsApi(mock).spreadsheets;
      var arg_request = buildBatchUpdateSpreadsheetRequest();
      var arg_spreadsheetId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.BatchUpdateSpreadsheetRequest.fromJson(json);
        checkBatchUpdateSpreadsheetRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("v4/spreadsheets/"));
        pathOffset += 16;
        index = path.indexOf(":batchUpdate", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_spreadsheetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals(":batchUpdate"));
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
        var resp = convert.JSON.encode(buildBatchUpdateSpreadsheetResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.batchUpdate(arg_request, arg_spreadsheetId).then(unittest.expectAsync(((api.BatchUpdateSpreadsheetResponse response) {
        checkBatchUpdateSpreadsheetResponse(response);
      })));
    });

    unittest.test("method--create", () {

      var mock = new HttpServerMock();
      api.SpreadsheetsResourceApi res = new api.SheetsApi(mock).spreadsheets;
      var arg_request = buildSpreadsheet();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Spreadsheet.fromJson(json);
        checkSpreadsheet(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("v4/spreadsheets"));
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
        var resp = convert.JSON.encode(buildSpreadsheet());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.create(arg_request).then(unittest.expectAsync(((api.Spreadsheet response) {
        checkSpreadsheet(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.SpreadsheetsResourceApi res = new api.SheetsApi(mock).spreadsheets;
      var arg_spreadsheetId = "foo";
      var arg_ranges = buildUnnamed406();
      var arg_includeGridData = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("v4/spreadsheets/"));
        pathOffset += 16;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_spreadsheetId"));

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
        unittest.expect(queryMap["ranges"], unittest.equals(arg_ranges));
        unittest.expect(queryMap["includeGridData"].first, unittest.equals("$arg_includeGridData"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSpreadsheet());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_spreadsheetId, ranges: arg_ranges, includeGridData: arg_includeGridData).then(unittest.expectAsync(((api.Spreadsheet response) {
        checkSpreadsheet(response);
      })));
    });

  });


  unittest.group("resource-SpreadsheetsSheetsResourceApi", () {
    unittest.test("method--copyTo", () {

      var mock = new HttpServerMock();
      api.SpreadsheetsSheetsResourceApi res = new api.SheetsApi(mock).spreadsheets.sheets;
      var arg_request = buildCopySheetToAnotherSpreadsheetRequest();
      var arg_spreadsheetId = "foo";
      var arg_sheetId = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.CopySheetToAnotherSpreadsheetRequest.fromJson(json);
        checkCopySheetToAnotherSpreadsheetRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("v4/spreadsheets/"));
        pathOffset += 16;
        index = path.indexOf("/sheets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_spreadsheetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/sheets/"));
        pathOffset += 8;
        index = path.indexOf(":copyTo", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_sheetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals(":copyTo"));
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
        var resp = convert.JSON.encode(buildSheetProperties());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.copyTo(arg_request, arg_spreadsheetId, arg_sheetId).then(unittest.expectAsync(((api.SheetProperties response) {
        checkSheetProperties(response);
      })));
    });

  });


  unittest.group("resource-SpreadsheetsValuesResourceApi", () {
    unittest.test("method--append", () {

      var mock = new HttpServerMock();
      api.SpreadsheetsValuesResourceApi res = new api.SheetsApi(mock).spreadsheets.values;
      var arg_request = buildValueRange();
      var arg_spreadsheetId = "foo";
      var arg_range = "foo";
      var arg_responseValueRenderOption = "foo";
      var arg_insertDataOption = "foo";
      var arg_valueInputOption = "foo";
      var arg_responseDateTimeRenderOption = "foo";
      var arg_includeValuesInResponse = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ValueRange.fromJson(json);
        checkValueRange(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("v4/spreadsheets/"));
        pathOffset += 16;
        index = path.indexOf("/values/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_spreadsheetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/values/"));
        pathOffset += 8;
        index = path.indexOf(":append", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_range"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals(":append"));
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
        unittest.expect(queryMap["responseValueRenderOption"].first, unittest.equals(arg_responseValueRenderOption));
        unittest.expect(queryMap["insertDataOption"].first, unittest.equals(arg_insertDataOption));
        unittest.expect(queryMap["valueInputOption"].first, unittest.equals(arg_valueInputOption));
        unittest.expect(queryMap["responseDateTimeRenderOption"].first, unittest.equals(arg_responseDateTimeRenderOption));
        unittest.expect(queryMap["includeValuesInResponse"].first, unittest.equals("$arg_includeValuesInResponse"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAppendValuesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.append(arg_request, arg_spreadsheetId, arg_range, responseValueRenderOption: arg_responseValueRenderOption, insertDataOption: arg_insertDataOption, valueInputOption: arg_valueInputOption, responseDateTimeRenderOption: arg_responseDateTimeRenderOption, includeValuesInResponse: arg_includeValuesInResponse).then(unittest.expectAsync(((api.AppendValuesResponse response) {
        checkAppendValuesResponse(response);
      })));
    });

    unittest.test("method--batchClear", () {

      var mock = new HttpServerMock();
      api.SpreadsheetsValuesResourceApi res = new api.SheetsApi(mock).spreadsheets.values;
      var arg_request = buildBatchClearValuesRequest();
      var arg_spreadsheetId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.BatchClearValuesRequest.fromJson(json);
        checkBatchClearValuesRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("v4/spreadsheets/"));
        pathOffset += 16;
        index = path.indexOf("/values:batchClear", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_spreadsheetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 18), unittest.equals("/values:batchClear"));
        pathOffset += 18;

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
        var resp = convert.JSON.encode(buildBatchClearValuesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.batchClear(arg_request, arg_spreadsheetId).then(unittest.expectAsync(((api.BatchClearValuesResponse response) {
        checkBatchClearValuesResponse(response);
      })));
    });

    unittest.test("method--batchGet", () {

      var mock = new HttpServerMock();
      api.SpreadsheetsValuesResourceApi res = new api.SheetsApi(mock).spreadsheets.values;
      var arg_spreadsheetId = "foo";
      var arg_ranges = buildUnnamed407();
      var arg_majorDimension = "foo";
      var arg_valueRenderOption = "foo";
      var arg_dateTimeRenderOption = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("v4/spreadsheets/"));
        pathOffset += 16;
        index = path.indexOf("/values:batchGet", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_spreadsheetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("/values:batchGet"));
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
        unittest.expect(queryMap["ranges"], unittest.equals(arg_ranges));
        unittest.expect(queryMap["majorDimension"].first, unittest.equals(arg_majorDimension));
        unittest.expect(queryMap["valueRenderOption"].first, unittest.equals(arg_valueRenderOption));
        unittest.expect(queryMap["dateTimeRenderOption"].first, unittest.equals(arg_dateTimeRenderOption));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBatchGetValuesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.batchGet(arg_spreadsheetId, ranges: arg_ranges, majorDimension: arg_majorDimension, valueRenderOption: arg_valueRenderOption, dateTimeRenderOption: arg_dateTimeRenderOption).then(unittest.expectAsync(((api.BatchGetValuesResponse response) {
        checkBatchGetValuesResponse(response);
      })));
    });

    unittest.test("method--batchUpdate", () {

      var mock = new HttpServerMock();
      api.SpreadsheetsValuesResourceApi res = new api.SheetsApi(mock).spreadsheets.values;
      var arg_request = buildBatchUpdateValuesRequest();
      var arg_spreadsheetId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.BatchUpdateValuesRequest.fromJson(json);
        checkBatchUpdateValuesRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("v4/spreadsheets/"));
        pathOffset += 16;
        index = path.indexOf("/values:batchUpdate", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_spreadsheetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 19), unittest.equals("/values:batchUpdate"));
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
        var resp = convert.JSON.encode(buildBatchUpdateValuesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.batchUpdate(arg_request, arg_spreadsheetId).then(unittest.expectAsync(((api.BatchUpdateValuesResponse response) {
        checkBatchUpdateValuesResponse(response);
      })));
    });

    unittest.test("method--clear", () {

      var mock = new HttpServerMock();
      api.SpreadsheetsValuesResourceApi res = new api.SheetsApi(mock).spreadsheets.values;
      var arg_request = buildClearValuesRequest();
      var arg_spreadsheetId = "foo";
      var arg_range = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ClearValuesRequest.fromJson(json);
        checkClearValuesRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("v4/spreadsheets/"));
        pathOffset += 16;
        index = path.indexOf("/values/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_spreadsheetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/values/"));
        pathOffset += 8;
        index = path.indexOf(":clear", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_range"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals(":clear"));
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
        var resp = convert.JSON.encode(buildClearValuesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.clear(arg_request, arg_spreadsheetId, arg_range).then(unittest.expectAsync(((api.ClearValuesResponse response) {
        checkClearValuesResponse(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.SpreadsheetsValuesResourceApi res = new api.SheetsApi(mock).spreadsheets.values;
      var arg_spreadsheetId = "foo";
      var arg_range = "foo";
      var arg_valueRenderOption = "foo";
      var arg_dateTimeRenderOption = "foo";
      var arg_majorDimension = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("v4/spreadsheets/"));
        pathOffset += 16;
        index = path.indexOf("/values/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_spreadsheetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/values/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_range"));

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
        unittest.expect(queryMap["valueRenderOption"].first, unittest.equals(arg_valueRenderOption));
        unittest.expect(queryMap["dateTimeRenderOption"].first, unittest.equals(arg_dateTimeRenderOption));
        unittest.expect(queryMap["majorDimension"].first, unittest.equals(arg_majorDimension));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildValueRange());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_spreadsheetId, arg_range, valueRenderOption: arg_valueRenderOption, dateTimeRenderOption: arg_dateTimeRenderOption, majorDimension: arg_majorDimension).then(unittest.expectAsync(((api.ValueRange response) {
        checkValueRange(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.SpreadsheetsValuesResourceApi res = new api.SheetsApi(mock).spreadsheets.values;
      var arg_request = buildValueRange();
      var arg_spreadsheetId = "foo";
      var arg_range = "foo";
      var arg_responseValueRenderOption = "foo";
      var arg_valueInputOption = "foo";
      var arg_responseDateTimeRenderOption = "foo";
      var arg_includeValuesInResponse = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ValueRange.fromJson(json);
        checkValueRange(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("v4/spreadsheets/"));
        pathOffset += 16;
        index = path.indexOf("/values/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_spreadsheetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/values/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_range"));

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
        unittest.expect(queryMap["responseValueRenderOption"].first, unittest.equals(arg_responseValueRenderOption));
        unittest.expect(queryMap["valueInputOption"].first, unittest.equals(arg_valueInputOption));
        unittest.expect(queryMap["responseDateTimeRenderOption"].first, unittest.equals(arg_responseDateTimeRenderOption));
        unittest.expect(queryMap["includeValuesInResponse"].first, unittest.equals("$arg_includeValuesInResponse"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildUpdateValuesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_spreadsheetId, arg_range, responseValueRenderOption: arg_responseValueRenderOption, valueInputOption: arg_valueInputOption, responseDateTimeRenderOption: arg_responseDateTimeRenderOption, includeValuesInResponse: arg_includeValuesInResponse).then(unittest.expectAsync(((api.UpdateValuesResponse response) {
        checkUpdateValuesResponse(response);
      })));
    });

  });


}

