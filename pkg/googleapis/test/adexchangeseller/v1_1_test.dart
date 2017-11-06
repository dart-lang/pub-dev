library googleapis.adexchangeseller.v1_1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/adexchangeseller/v1_1.dart' as api;

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

core.int buildCounterAccount = 0;
buildAccount() {
  var o = new api.Account();
  buildCounterAccount++;
  if (buildCounterAccount < 3) {
    o.id = "foo";
    o.kind = "foo";
    o.name = "foo";
  }
  buildCounterAccount--;
  return o;
}

checkAccount(api.Account o) {
  buildCounterAccount++;
  if (buildCounterAccount < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterAccount--;
}

core.int buildCounterAdClient = 0;
buildAdClient() {
  var o = new api.AdClient();
  buildCounterAdClient++;
  if (buildCounterAdClient < 3) {
    o.arcOptIn = true;
    o.id = "foo";
    o.kind = "foo";
    o.productCode = "foo";
    o.supportsReporting = true;
  }
  buildCounterAdClient--;
  return o;
}

checkAdClient(api.AdClient o) {
  buildCounterAdClient++;
  if (buildCounterAdClient < 3) {
    unittest.expect(o.arcOptIn, unittest.isTrue);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.productCode, unittest.equals('foo'));
    unittest.expect(o.supportsReporting, unittest.isTrue);
  }
  buildCounterAdClient--;
}

buildUnnamed200() {
  var o = new core.List<api.AdClient>();
  o.add(buildAdClient());
  o.add(buildAdClient());
  return o;
}

checkUnnamed200(core.List<api.AdClient> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAdClient(o[0]);
  checkAdClient(o[1]);
}

core.int buildCounterAdClients = 0;
buildAdClients() {
  var o = new api.AdClients();
  buildCounterAdClients++;
  if (buildCounterAdClients < 3) {
    o.etag = "foo";
    o.items = buildUnnamed200();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterAdClients--;
  return o;
}

checkAdClients(api.AdClients o) {
  buildCounterAdClients++;
  if (buildCounterAdClients < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed200(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterAdClients--;
}

core.int buildCounterAdUnit = 0;
buildAdUnit() {
  var o = new api.AdUnit();
  buildCounterAdUnit++;
  if (buildCounterAdUnit < 3) {
    o.code = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.name = "foo";
    o.status = "foo";
  }
  buildCounterAdUnit--;
  return o;
}

checkAdUnit(api.AdUnit o) {
  buildCounterAdUnit++;
  if (buildCounterAdUnit < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterAdUnit--;
}

buildUnnamed201() {
  var o = new core.List<api.AdUnit>();
  o.add(buildAdUnit());
  o.add(buildAdUnit());
  return o;
}

checkUnnamed201(core.List<api.AdUnit> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAdUnit(o[0]);
  checkAdUnit(o[1]);
}

core.int buildCounterAdUnits = 0;
buildAdUnits() {
  var o = new api.AdUnits();
  buildCounterAdUnits++;
  if (buildCounterAdUnits < 3) {
    o.etag = "foo";
    o.items = buildUnnamed201();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterAdUnits--;
  return o;
}

checkAdUnits(api.AdUnits o) {
  buildCounterAdUnits++;
  if (buildCounterAdUnits < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed201(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterAdUnits--;
}

core.int buildCounterAlert = 0;
buildAlert() {
  var o = new api.Alert();
  buildCounterAlert++;
  if (buildCounterAlert < 3) {
    o.id = "foo";
    o.kind = "foo";
    o.message = "foo";
    o.severity = "foo";
    o.type = "foo";
  }
  buildCounterAlert--;
  return o;
}

checkAlert(api.Alert o) {
  buildCounterAlert++;
  if (buildCounterAlert < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.message, unittest.equals('foo'));
    unittest.expect(o.severity, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterAlert--;
}

buildUnnamed202() {
  var o = new core.List<api.Alert>();
  o.add(buildAlert());
  o.add(buildAlert());
  return o;
}

checkUnnamed202(core.List<api.Alert> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAlert(o[0]);
  checkAlert(o[1]);
}

core.int buildCounterAlerts = 0;
buildAlerts() {
  var o = new api.Alerts();
  buildCounterAlerts++;
  if (buildCounterAlerts < 3) {
    o.items = buildUnnamed202();
    o.kind = "foo";
  }
  buildCounterAlerts--;
  return o;
}

checkAlerts(api.Alerts o) {
  buildCounterAlerts++;
  if (buildCounterAlerts < 3) {
    checkUnnamed202(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAlerts--;
}

core.int buildCounterCustomChannelTargetingInfo = 0;
buildCustomChannelTargetingInfo() {
  var o = new api.CustomChannelTargetingInfo();
  buildCounterCustomChannelTargetingInfo++;
  if (buildCounterCustomChannelTargetingInfo < 3) {
    o.adsAppearOn = "foo";
    o.description = "foo";
    o.location = "foo";
    o.siteLanguage = "foo";
  }
  buildCounterCustomChannelTargetingInfo--;
  return o;
}

checkCustomChannelTargetingInfo(api.CustomChannelTargetingInfo o) {
  buildCounterCustomChannelTargetingInfo++;
  if (buildCounterCustomChannelTargetingInfo < 3) {
    unittest.expect(o.adsAppearOn, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.location, unittest.equals('foo'));
    unittest.expect(o.siteLanguage, unittest.equals('foo'));
  }
  buildCounterCustomChannelTargetingInfo--;
}

core.int buildCounterCustomChannel = 0;
buildCustomChannel() {
  var o = new api.CustomChannel();
  buildCounterCustomChannel++;
  if (buildCounterCustomChannel < 3) {
    o.code = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.name = "foo";
    o.targetingInfo = buildCustomChannelTargetingInfo();
  }
  buildCounterCustomChannel--;
  return o;
}

checkCustomChannel(api.CustomChannel o) {
  buildCounterCustomChannel++;
  if (buildCounterCustomChannel < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    checkCustomChannelTargetingInfo(o.targetingInfo);
  }
  buildCounterCustomChannel--;
}

buildUnnamed203() {
  var o = new core.List<api.CustomChannel>();
  o.add(buildCustomChannel());
  o.add(buildCustomChannel());
  return o;
}

checkUnnamed203(core.List<api.CustomChannel> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCustomChannel(o[0]);
  checkCustomChannel(o[1]);
}

core.int buildCounterCustomChannels = 0;
buildCustomChannels() {
  var o = new api.CustomChannels();
  buildCounterCustomChannels++;
  if (buildCounterCustomChannels < 3) {
    o.etag = "foo";
    o.items = buildUnnamed203();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterCustomChannels--;
  return o;
}

checkCustomChannels(api.CustomChannels o) {
  buildCounterCustomChannels++;
  if (buildCounterCustomChannels < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed203(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterCustomChannels--;
}

buildUnnamed204() {
  var o = new core.List<api.ReportingMetadataEntry>();
  o.add(buildReportingMetadataEntry());
  o.add(buildReportingMetadataEntry());
  return o;
}

checkUnnamed204(core.List<api.ReportingMetadataEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReportingMetadataEntry(o[0]);
  checkReportingMetadataEntry(o[1]);
}

core.int buildCounterMetadata = 0;
buildMetadata() {
  var o = new api.Metadata();
  buildCounterMetadata++;
  if (buildCounterMetadata < 3) {
    o.items = buildUnnamed204();
    o.kind = "foo";
  }
  buildCounterMetadata--;
  return o;
}

checkMetadata(api.Metadata o) {
  buildCounterMetadata++;
  if (buildCounterMetadata < 3) {
    checkUnnamed204(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterMetadata--;
}

core.int buildCounterPreferredDeal = 0;
buildPreferredDeal() {
  var o = new api.PreferredDeal();
  buildCounterPreferredDeal++;
  if (buildCounterPreferredDeal < 3) {
    o.advertiserName = "foo";
    o.buyerNetworkName = "foo";
    o.currencyCode = "foo";
    o.endTime = "foo";
    o.fixedCpm = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.startTime = "foo";
  }
  buildCounterPreferredDeal--;
  return o;
}

checkPreferredDeal(api.PreferredDeal o) {
  buildCounterPreferredDeal++;
  if (buildCounterPreferredDeal < 3) {
    unittest.expect(o.advertiserName, unittest.equals('foo'));
    unittest.expect(o.buyerNetworkName, unittest.equals('foo'));
    unittest.expect(o.currencyCode, unittest.equals('foo'));
    unittest.expect(o.endTime, unittest.equals('foo'));
    unittest.expect(o.fixedCpm, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.startTime, unittest.equals('foo'));
  }
  buildCounterPreferredDeal--;
}

buildUnnamed205() {
  var o = new core.List<api.PreferredDeal>();
  o.add(buildPreferredDeal());
  o.add(buildPreferredDeal());
  return o;
}

checkUnnamed205(core.List<api.PreferredDeal> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPreferredDeal(o[0]);
  checkPreferredDeal(o[1]);
}

core.int buildCounterPreferredDeals = 0;
buildPreferredDeals() {
  var o = new api.PreferredDeals();
  buildCounterPreferredDeals++;
  if (buildCounterPreferredDeals < 3) {
    o.items = buildUnnamed205();
    o.kind = "foo";
  }
  buildCounterPreferredDeals--;
  return o;
}

checkPreferredDeals(api.PreferredDeals o) {
  buildCounterPreferredDeals++;
  if (buildCounterPreferredDeals < 3) {
    checkUnnamed205(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterPreferredDeals--;
}

buildUnnamed206() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed206(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterReportHeaders = 0;
buildReportHeaders() {
  var o = new api.ReportHeaders();
  buildCounterReportHeaders++;
  if (buildCounterReportHeaders < 3) {
    o.currency = "foo";
    o.name = "foo";
    o.type = "foo";
  }
  buildCounterReportHeaders--;
  return o;
}

checkReportHeaders(api.ReportHeaders o) {
  buildCounterReportHeaders++;
  if (buildCounterReportHeaders < 3) {
    unittest.expect(o.currency, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterReportHeaders--;
}

buildUnnamed207() {
  var o = new core.List<api.ReportHeaders>();
  o.add(buildReportHeaders());
  o.add(buildReportHeaders());
  return o;
}

checkUnnamed207(core.List<api.ReportHeaders> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReportHeaders(o[0]);
  checkReportHeaders(o[1]);
}

buildUnnamed208() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed208(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed209() {
  var o = new core.List<core.List<core.String>>();
  o.add(buildUnnamed208());
  o.add(buildUnnamed208());
  return o;
}

checkUnnamed209(core.List<core.List<core.String>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed208(o[0]);
  checkUnnamed208(o[1]);
}

buildUnnamed210() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed210(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed211() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed211(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterReport = 0;
buildReport() {
  var o = new api.Report();
  buildCounterReport++;
  if (buildCounterReport < 3) {
    o.averages = buildUnnamed206();
    o.headers = buildUnnamed207();
    o.kind = "foo";
    o.rows = buildUnnamed209();
    o.totalMatchedRows = "foo";
    o.totals = buildUnnamed210();
    o.warnings = buildUnnamed211();
  }
  buildCounterReport--;
  return o;
}

checkReport(api.Report o) {
  buildCounterReport++;
  if (buildCounterReport < 3) {
    checkUnnamed206(o.averages);
    checkUnnamed207(o.headers);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed209(o.rows);
    unittest.expect(o.totalMatchedRows, unittest.equals('foo'));
    checkUnnamed210(o.totals);
    checkUnnamed211(o.warnings);
  }
  buildCounterReport--;
}

buildUnnamed212() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed212(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed213() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed213(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed214() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed214(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed215() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed215(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed216() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed216(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterReportingMetadataEntry = 0;
buildReportingMetadataEntry() {
  var o = new api.ReportingMetadataEntry();
  buildCounterReportingMetadataEntry++;
  if (buildCounterReportingMetadataEntry < 3) {
    o.compatibleDimensions = buildUnnamed212();
    o.compatibleMetrics = buildUnnamed213();
    o.id = "foo";
    o.kind = "foo";
    o.requiredDimensions = buildUnnamed214();
    o.requiredMetrics = buildUnnamed215();
    o.supportedProducts = buildUnnamed216();
  }
  buildCounterReportingMetadataEntry--;
  return o;
}

checkReportingMetadataEntry(api.ReportingMetadataEntry o) {
  buildCounterReportingMetadataEntry++;
  if (buildCounterReportingMetadataEntry < 3) {
    checkUnnamed212(o.compatibleDimensions);
    checkUnnamed213(o.compatibleMetrics);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed214(o.requiredDimensions);
    checkUnnamed215(o.requiredMetrics);
    checkUnnamed216(o.supportedProducts);
  }
  buildCounterReportingMetadataEntry--;
}

core.int buildCounterSavedReport = 0;
buildSavedReport() {
  var o = new api.SavedReport();
  buildCounterSavedReport++;
  if (buildCounterSavedReport < 3) {
    o.id = "foo";
    o.kind = "foo";
    o.name = "foo";
  }
  buildCounterSavedReport--;
  return o;
}

checkSavedReport(api.SavedReport o) {
  buildCounterSavedReport++;
  if (buildCounterSavedReport < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterSavedReport--;
}

buildUnnamed217() {
  var o = new core.List<api.SavedReport>();
  o.add(buildSavedReport());
  o.add(buildSavedReport());
  return o;
}

checkUnnamed217(core.List<api.SavedReport> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSavedReport(o[0]);
  checkSavedReport(o[1]);
}

core.int buildCounterSavedReports = 0;
buildSavedReports() {
  var o = new api.SavedReports();
  buildCounterSavedReports++;
  if (buildCounterSavedReports < 3) {
    o.etag = "foo";
    o.items = buildUnnamed217();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterSavedReports--;
  return o;
}

checkSavedReports(api.SavedReports o) {
  buildCounterSavedReports++;
  if (buildCounterSavedReports < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed217(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterSavedReports--;
}

core.int buildCounterUrlChannel = 0;
buildUrlChannel() {
  var o = new api.UrlChannel();
  buildCounterUrlChannel++;
  if (buildCounterUrlChannel < 3) {
    o.id = "foo";
    o.kind = "foo";
    o.urlPattern = "foo";
  }
  buildCounterUrlChannel--;
  return o;
}

checkUrlChannel(api.UrlChannel o) {
  buildCounterUrlChannel++;
  if (buildCounterUrlChannel < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.urlPattern, unittest.equals('foo'));
  }
  buildCounterUrlChannel--;
}

buildUnnamed218() {
  var o = new core.List<api.UrlChannel>();
  o.add(buildUrlChannel());
  o.add(buildUrlChannel());
  return o;
}

checkUnnamed218(core.List<api.UrlChannel> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUrlChannel(o[0]);
  checkUrlChannel(o[1]);
}

core.int buildCounterUrlChannels = 0;
buildUrlChannels() {
  var o = new api.UrlChannels();
  buildCounterUrlChannels++;
  if (buildCounterUrlChannels < 3) {
    o.etag = "foo";
    o.items = buildUnnamed218();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterUrlChannels--;
  return o;
}

checkUrlChannels(api.UrlChannels o) {
  buildCounterUrlChannels++;
  if (buildCounterUrlChannels < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed218(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterUrlChannels--;
}

buildUnnamed219() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed219(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed220() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed220(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed221() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed221(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed222() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed222(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}


main() {
  unittest.group("obj-schema-Account", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccount();
      var od = new api.Account.fromJson(o.toJson());
      checkAccount(od);
    });
  });


  unittest.group("obj-schema-AdClient", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdClient();
      var od = new api.AdClient.fromJson(o.toJson());
      checkAdClient(od);
    });
  });


  unittest.group("obj-schema-AdClients", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdClients();
      var od = new api.AdClients.fromJson(o.toJson());
      checkAdClients(od);
    });
  });


  unittest.group("obj-schema-AdUnit", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdUnit();
      var od = new api.AdUnit.fromJson(o.toJson());
      checkAdUnit(od);
    });
  });


  unittest.group("obj-schema-AdUnits", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdUnits();
      var od = new api.AdUnits.fromJson(o.toJson());
      checkAdUnits(od);
    });
  });


  unittest.group("obj-schema-Alert", () {
    unittest.test("to-json--from-json", () {
      var o = buildAlert();
      var od = new api.Alert.fromJson(o.toJson());
      checkAlert(od);
    });
  });


  unittest.group("obj-schema-Alerts", () {
    unittest.test("to-json--from-json", () {
      var o = buildAlerts();
      var od = new api.Alerts.fromJson(o.toJson());
      checkAlerts(od);
    });
  });


  unittest.group("obj-schema-CustomChannelTargetingInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildCustomChannelTargetingInfo();
      var od = new api.CustomChannelTargetingInfo.fromJson(o.toJson());
      checkCustomChannelTargetingInfo(od);
    });
  });


  unittest.group("obj-schema-CustomChannel", () {
    unittest.test("to-json--from-json", () {
      var o = buildCustomChannel();
      var od = new api.CustomChannel.fromJson(o.toJson());
      checkCustomChannel(od);
    });
  });


  unittest.group("obj-schema-CustomChannels", () {
    unittest.test("to-json--from-json", () {
      var o = buildCustomChannels();
      var od = new api.CustomChannels.fromJson(o.toJson());
      checkCustomChannels(od);
    });
  });


  unittest.group("obj-schema-Metadata", () {
    unittest.test("to-json--from-json", () {
      var o = buildMetadata();
      var od = new api.Metadata.fromJson(o.toJson());
      checkMetadata(od);
    });
  });


  unittest.group("obj-schema-PreferredDeal", () {
    unittest.test("to-json--from-json", () {
      var o = buildPreferredDeal();
      var od = new api.PreferredDeal.fromJson(o.toJson());
      checkPreferredDeal(od);
    });
  });


  unittest.group("obj-schema-PreferredDeals", () {
    unittest.test("to-json--from-json", () {
      var o = buildPreferredDeals();
      var od = new api.PreferredDeals.fromJson(o.toJson());
      checkPreferredDeals(od);
    });
  });


  unittest.group("obj-schema-ReportHeaders", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportHeaders();
      var od = new api.ReportHeaders.fromJson(o.toJson());
      checkReportHeaders(od);
    });
  });


  unittest.group("obj-schema-Report", () {
    unittest.test("to-json--from-json", () {
      var o = buildReport();
      var od = new api.Report.fromJson(o.toJson());
      checkReport(od);
    });
  });


  unittest.group("obj-schema-ReportingMetadataEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportingMetadataEntry();
      var od = new api.ReportingMetadataEntry.fromJson(o.toJson());
      checkReportingMetadataEntry(od);
    });
  });


  unittest.group("obj-schema-SavedReport", () {
    unittest.test("to-json--from-json", () {
      var o = buildSavedReport();
      var od = new api.SavedReport.fromJson(o.toJson());
      checkSavedReport(od);
    });
  });


  unittest.group("obj-schema-SavedReports", () {
    unittest.test("to-json--from-json", () {
      var o = buildSavedReports();
      var od = new api.SavedReports.fromJson(o.toJson());
      checkSavedReports(od);
    });
  });


  unittest.group("obj-schema-UrlChannel", () {
    unittest.test("to-json--from-json", () {
      var o = buildUrlChannel();
      var od = new api.UrlChannel.fromJson(o.toJson());
      checkUrlChannel(od);
    });
  });


  unittest.group("obj-schema-UrlChannels", () {
    unittest.test("to-json--from-json", () {
      var o = buildUrlChannels();
      var od = new api.UrlChannels.fromJson(o.toJson());
      checkUrlChannels(od);
    });
  });


  unittest.group("resource-AccountsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.AdexchangesellerApi(mock).accounts;
      var arg_accountId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("accounts/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));

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
        var resp = convert.JSON.encode(buildAccount());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_accountId).then(unittest.expectAsync(((api.Account response) {
        checkAccount(response);
      })));
    });

  });


  unittest.group("resource-AdclientsResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.AdclientsResourceApi res = new api.AdexchangesellerApi(mock).adclients;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("adclients"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAdClients());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.AdClients response) {
        checkAdClients(response);
      })));
    });

  });


  unittest.group("resource-AdunitsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.AdunitsResourceApi res = new api.AdexchangesellerApi(mock).adunits;
      var arg_adClientId = "foo";
      var arg_adUnitId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/adunits/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/adunits/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_adUnitId"));

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
        var resp = convert.JSON.encode(buildAdUnit());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_adClientId, arg_adUnitId).then(unittest.expectAsync(((api.AdUnit response) {
        checkAdUnit(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.AdunitsResourceApi res = new api.AdexchangesellerApi(mock).adunits;
      var arg_adClientId = "foo";
      var arg_includeInactive = true;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/adunits", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/adunits"));
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
        unittest.expect(queryMap["includeInactive"].first, unittest.equals("$arg_includeInactive"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAdUnits());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_adClientId, includeInactive: arg_includeInactive, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.AdUnits response) {
        checkAdUnits(response);
      })));
    });

  });


  unittest.group("resource-AdunitsCustomchannelsResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.AdunitsCustomchannelsResourceApi res = new api.AdexchangesellerApi(mock).adunits.customchannels;
      var arg_adClientId = "foo";
      var arg_adUnitId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/adunits/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/adunits/"));
        pathOffset += 9;
        index = path.indexOf("/customchannels", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adUnitId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("/customchannels"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCustomChannels());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_adClientId, arg_adUnitId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.CustomChannels response) {
        checkCustomChannels(response);
      })));
    });

  });


  unittest.group("resource-AlertsResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.AlertsResourceApi res = new api.AdexchangesellerApi(mock).alerts;
      var arg_locale = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("alerts"));
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
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAlerts());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(locale: arg_locale).then(unittest.expectAsync(((api.Alerts response) {
        checkAlerts(response);
      })));
    });

  });


  unittest.group("resource-CustomchannelsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.CustomchannelsResourceApi res = new api.AdexchangesellerApi(mock).customchannels;
      var arg_adClientId = "foo";
      var arg_customChannelId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/customchannels/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("/customchannels/"));
        pathOffset += 16;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_customChannelId"));

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
        var resp = convert.JSON.encode(buildCustomChannel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_adClientId, arg_customChannelId).then(unittest.expectAsync(((api.CustomChannel response) {
        checkCustomChannel(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.CustomchannelsResourceApi res = new api.AdexchangesellerApi(mock).customchannels;
      var arg_adClientId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/customchannels", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("/customchannels"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCustomChannels());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_adClientId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.CustomChannels response) {
        checkCustomChannels(response);
      })));
    });

  });


  unittest.group("resource-CustomchannelsAdunitsResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.CustomchannelsAdunitsResourceApi res = new api.AdexchangesellerApi(mock).customchannels.adunits;
      var arg_adClientId = "foo";
      var arg_customChannelId = "foo";
      var arg_includeInactive = true;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/customchannels/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("/customchannels/"));
        pathOffset += 16;
        index = path.indexOf("/adunits", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_customChannelId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/adunits"));
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
        unittest.expect(queryMap["includeInactive"].first, unittest.equals("$arg_includeInactive"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAdUnits());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_adClientId, arg_customChannelId, includeInactive: arg_includeInactive, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.AdUnits response) {
        checkAdUnits(response);
      })));
    });

  });


  unittest.group("resource-MetadataDimensionsResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.MetadataDimensionsResourceApi res = new api.AdexchangesellerApi(mock).metadata.dimensions;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 19), unittest.equals("metadata/dimensions"));
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
        var resp = convert.JSON.encode(buildMetadata());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list().then(unittest.expectAsync(((api.Metadata response) {
        checkMetadata(response);
      })));
    });

  });


  unittest.group("resource-MetadataMetricsResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.MetadataMetricsResourceApi res = new api.AdexchangesellerApi(mock).metadata.metrics;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("metadata/metrics"));
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
        var resp = convert.JSON.encode(buildMetadata());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list().then(unittest.expectAsync(((api.Metadata response) {
        checkMetadata(response);
      })));
    });

  });


  unittest.group("resource-PreferreddealsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.PreferreddealsResourceApi res = new api.AdexchangesellerApi(mock).preferreddeals;
      var arg_dealId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("preferreddeals/"));
        pathOffset += 15;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_dealId"));

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
        var resp = convert.JSON.encode(buildPreferredDeal());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_dealId).then(unittest.expectAsync(((api.PreferredDeal response) {
        checkPreferredDeal(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.PreferreddealsResourceApi res = new api.AdexchangesellerApi(mock).preferreddeals;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("preferreddeals"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPreferredDeals());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list().then(unittest.expectAsync(((api.PreferredDeals response) {
        checkPreferredDeals(response);
      })));
    });

  });


  unittest.group("resource-ReportsResourceApi", () {
    unittest.test("method--generate", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.ReportsResourceApi res = new api.AdexchangesellerApi(mock).reports;
      var arg_startDate = "foo";
      var arg_endDate = "foo";
      var arg_dimension = buildUnnamed219();
      var arg_filter = buildUnnamed220();
      var arg_locale = "foo";
      var arg_maxResults = 42;
      var arg_metric = buildUnnamed221();
      var arg_sort = buildUnnamed222();
      var arg_startIndex = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
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
        unittest.expect(queryMap["startDate"].first, unittest.equals(arg_startDate));
        unittest.expect(queryMap["endDate"].first, unittest.equals(arg_endDate));
        unittest.expect(queryMap["dimension"], unittest.equals(arg_dimension));
        unittest.expect(queryMap["filter"], unittest.equals(arg_filter));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["metric"], unittest.equals(arg_metric));
        unittest.expect(queryMap["sort"], unittest.equals(arg_sort));
        unittest.expect(core.int.parse(queryMap["startIndex"].first), unittest.equals(arg_startIndex));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildReport());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.generate(arg_startDate, arg_endDate, dimension: arg_dimension, filter: arg_filter, locale: arg_locale, maxResults: arg_maxResults, metric: arg_metric, sort: arg_sort, startIndex: arg_startIndex).then(unittest.expectAsync(((api.Report response) {
        checkReport(response);
      })));
    });

  });


  unittest.group("resource-ReportsSavedResourceApi", () {
    unittest.test("method--generate", () {

      var mock = new HttpServerMock();
      api.ReportsSavedResourceApi res = new api.AdexchangesellerApi(mock).reports.saved;
      var arg_savedReportId = "foo";
      var arg_locale = "foo";
      var arg_maxResults = 42;
      var arg_startIndex = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("reports/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_savedReportId"));

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
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(core.int.parse(queryMap["startIndex"].first), unittest.equals(arg_startIndex));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildReport());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.generate(arg_savedReportId, locale: arg_locale, maxResults: arg_maxResults, startIndex: arg_startIndex).then(unittest.expectAsync(((api.Report response) {
        checkReport(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.ReportsSavedResourceApi res = new api.AdexchangesellerApi(mock).reports.saved;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("reports/saved"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSavedReports());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.SavedReports response) {
        checkSavedReports(response);
      })));
    });

  });


  unittest.group("resource-UrlchannelsResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.UrlchannelsResourceApi res = new api.AdexchangesellerApi(mock).urlchannels;
      var arg_adClientId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("adexchangeseller/v1.1/"));
        pathOffset += 22;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/urlchannels", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("/urlchannels"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildUrlChannels());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_adClientId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.UrlChannels response) {
        checkUrlChannels(response);
      })));
    });

  });


}

