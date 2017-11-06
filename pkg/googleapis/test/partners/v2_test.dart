library googleapis.partners.v2.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/partners/v2.dart' as api;

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

core.int buildCounterCertificationExamStatus = 0;
buildCertificationExamStatus() {
  var o = new api.CertificationExamStatus();
  buildCounterCertificationExamStatus++;
  if (buildCounterCertificationExamStatus < 3) {
    o.numberUsersPass = 42;
    o.type = "foo";
  }
  buildCounterCertificationExamStatus--;
  return o;
}

checkCertificationExamStatus(api.CertificationExamStatus o) {
  buildCounterCertificationExamStatus++;
  if (buildCounterCertificationExamStatus < 3) {
    unittest.expect(o.numberUsersPass, unittest.equals(42));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterCertificationExamStatus--;
}

buildUnnamed1651() {
  var o = new core.List<api.CertificationExamStatus>();
  o.add(buildCertificationExamStatus());
  o.add(buildCertificationExamStatus());
  return o;
}

checkUnnamed1651(core.List<api.CertificationExamStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCertificationExamStatus(o[0]);
  checkCertificationExamStatus(o[1]);
}

core.int buildCounterCertificationStatus = 0;
buildCertificationStatus() {
  var o = new api.CertificationStatus();
  buildCounterCertificationStatus++;
  if (buildCounterCertificationStatus < 3) {
    o.examStatuses = buildUnnamed1651();
    o.isCertified = true;
    o.type = "foo";
  }
  buildCounterCertificationStatus--;
  return o;
}

checkCertificationStatus(api.CertificationStatus o) {
  buildCounterCertificationStatus++;
  if (buildCounterCertificationStatus < 3) {
    checkUnnamed1651(o.examStatuses);
    unittest.expect(o.isCertified, unittest.isTrue);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterCertificationStatus--;
}

buildUnnamed1652() {
  var o = new core.List<api.CertificationStatus>();
  o.add(buildCertificationStatus());
  o.add(buildCertificationStatus());
  return o;
}

checkUnnamed1652(core.List<api.CertificationStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCertificationStatus(o[0]);
  checkCertificationStatus(o[1]);
}

buildUnnamed1653() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1653(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1654() {
  var o = new core.List<api.LocalizedCompanyInfo>();
  o.add(buildLocalizedCompanyInfo());
  o.add(buildLocalizedCompanyInfo());
  return o;
}

checkUnnamed1654(core.List<api.LocalizedCompanyInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLocalizedCompanyInfo(o[0]);
  checkLocalizedCompanyInfo(o[1]);
}

buildUnnamed1655() {
  var o = new core.List<api.Location>();
  o.add(buildLocation());
  o.add(buildLocation());
  return o;
}

checkUnnamed1655(core.List<api.Location> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLocation(o[0]);
  checkLocation(o[1]);
}

buildUnnamed1656() {
  var o = new core.List<api.Rank>();
  o.add(buildRank());
  o.add(buildRank());
  return o;
}

checkUnnamed1656(core.List<api.Rank> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRank(o[0]);
  checkRank(o[1]);
}

buildUnnamed1657() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1657(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterCompany = 0;
buildCompany() {
  var o = new api.Company();
  buildCounterCompany++;
  if (buildCounterCompany < 3) {
    o.certificationStatuses = buildUnnamed1652();
    o.convertedMinMonthlyBudget = buildMoney();
    o.id = "foo";
    o.industries = buildUnnamed1653();
    o.localizedInfos = buildUnnamed1654();
    o.locations = buildUnnamed1655();
    o.name = "foo";
    o.originalMinMonthlyBudget = buildMoney();
    o.publicProfile = buildPublicProfile();
    o.ranks = buildUnnamed1656();
    o.services = buildUnnamed1657();
    o.websiteUrl = "foo";
  }
  buildCounterCompany--;
  return o;
}

checkCompany(api.Company o) {
  buildCounterCompany++;
  if (buildCounterCompany < 3) {
    checkUnnamed1652(o.certificationStatuses);
    checkMoney(o.convertedMinMonthlyBudget);
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed1653(o.industries);
    checkUnnamed1654(o.localizedInfos);
    checkUnnamed1655(o.locations);
    unittest.expect(o.name, unittest.equals('foo'));
    checkMoney(o.originalMinMonthlyBudget);
    checkPublicProfile(o.publicProfile);
    checkUnnamed1656(o.ranks);
    checkUnnamed1657(o.services);
    unittest.expect(o.websiteUrl, unittest.equals('foo'));
  }
  buildCounterCompany--;
}

core.int buildCounterCreateLeadRequest = 0;
buildCreateLeadRequest() {
  var o = new api.CreateLeadRequest();
  buildCounterCreateLeadRequest++;
  if (buildCounterCreateLeadRequest < 3) {
    o.lead = buildLead();
    o.recaptchaChallenge = buildRecaptchaChallenge();
    o.requestMetadata = buildRequestMetadata();
  }
  buildCounterCreateLeadRequest--;
  return o;
}

checkCreateLeadRequest(api.CreateLeadRequest o) {
  buildCounterCreateLeadRequest++;
  if (buildCounterCreateLeadRequest < 3) {
    checkLead(o.lead);
    checkRecaptchaChallenge(o.recaptchaChallenge);
    checkRequestMetadata(o.requestMetadata);
  }
  buildCounterCreateLeadRequest--;
}

core.int buildCounterCreateLeadResponse = 0;
buildCreateLeadResponse() {
  var o = new api.CreateLeadResponse();
  buildCounterCreateLeadResponse++;
  if (buildCounterCreateLeadResponse < 3) {
    o.lead = buildLead();
    o.recaptchaStatus = "foo";
    o.responseMetadata = buildResponseMetadata();
  }
  buildCounterCreateLeadResponse--;
  return o;
}

checkCreateLeadResponse(api.CreateLeadResponse o) {
  buildCounterCreateLeadResponse++;
  if (buildCounterCreateLeadResponse < 3) {
    checkLead(o.lead);
    unittest.expect(o.recaptchaStatus, unittest.equals('foo'));
    checkResponseMetadata(o.responseMetadata);
  }
  buildCounterCreateLeadResponse--;
}

core.int buildCounterDebugInfo = 0;
buildDebugInfo() {
  var o = new api.DebugInfo();
  buildCounterDebugInfo++;
  if (buildCounterDebugInfo < 3) {
    o.serverInfo = "foo";
    o.serverTraceInfo = "foo";
    o.serviceUrl = "foo";
  }
  buildCounterDebugInfo--;
  return o;
}

checkDebugInfo(api.DebugInfo o) {
  buildCounterDebugInfo++;
  if (buildCounterDebugInfo < 3) {
    unittest.expect(o.serverInfo, unittest.equals('foo'));
    unittest.expect(o.serverTraceInfo, unittest.equals('foo'));
    unittest.expect(o.serviceUrl, unittest.equals('foo'));
  }
  buildCounterDebugInfo--;
}

buildUnnamed1658() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1658(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterEventData = 0;
buildEventData() {
  var o = new api.EventData();
  buildCounterEventData++;
  if (buildCounterEventData < 3) {
    o.key = "foo";
    o.values = buildUnnamed1658();
  }
  buildCounterEventData--;
  return o;
}

checkEventData(api.EventData o) {
  buildCounterEventData++;
  if (buildCounterEventData < 3) {
    unittest.expect(o.key, unittest.equals('foo'));
    checkUnnamed1658(o.values);
  }
  buildCounterEventData--;
}

core.int buildCounterGetCompanyResponse = 0;
buildGetCompanyResponse() {
  var o = new api.GetCompanyResponse();
  buildCounterGetCompanyResponse++;
  if (buildCounterGetCompanyResponse < 3) {
    o.company = buildCompany();
    o.responseMetadata = buildResponseMetadata();
  }
  buildCounterGetCompanyResponse--;
  return o;
}

checkGetCompanyResponse(api.GetCompanyResponse o) {
  buildCounterGetCompanyResponse++;
  if (buildCounterGetCompanyResponse < 3) {
    checkCompany(o.company);
    checkResponseMetadata(o.responseMetadata);
  }
  buildCounterGetCompanyResponse--;
}

core.int buildCounterLatLng = 0;
buildLatLng() {
  var o = new api.LatLng();
  buildCounterLatLng++;
  if (buildCounterLatLng < 3) {
    o.latitude = 42.0;
    o.longitude = 42.0;
  }
  buildCounterLatLng--;
  return o;
}

checkLatLng(api.LatLng o) {
  buildCounterLatLng++;
  if (buildCounterLatLng < 3) {
    unittest.expect(o.latitude, unittest.equals(42.0));
    unittest.expect(o.longitude, unittest.equals(42.0));
  }
  buildCounterLatLng--;
}

buildUnnamed1659() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1659(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterLead = 0;
buildLead() {
  var o = new api.Lead();
  buildCounterLead++;
  if (buildCounterLead < 3) {
    o.comments = "foo";
    o.email = "foo";
    o.familyName = "foo";
    o.givenName = "foo";
    o.gpsMotivations = buildUnnamed1659();
    o.id = "foo";
    o.minMonthlyBudget = buildMoney();
    o.phoneNumber = "foo";
    o.type = "foo";
    o.websiteUrl = "foo";
  }
  buildCounterLead--;
  return o;
}

checkLead(api.Lead o) {
  buildCounterLead++;
  if (buildCounterLead < 3) {
    unittest.expect(o.comments, unittest.equals('foo'));
    unittest.expect(o.email, unittest.equals('foo'));
    unittest.expect(o.familyName, unittest.equals('foo'));
    unittest.expect(o.givenName, unittest.equals('foo'));
    checkUnnamed1659(o.gpsMotivations);
    unittest.expect(o.id, unittest.equals('foo'));
    checkMoney(o.minMonthlyBudget);
    unittest.expect(o.phoneNumber, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.websiteUrl, unittest.equals('foo'));
  }
  buildCounterLead--;
}

buildUnnamed1660() {
  var o = new core.List<api.Company>();
  o.add(buildCompany());
  o.add(buildCompany());
  return o;
}

checkUnnamed1660(core.List<api.Company> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCompany(o[0]);
  checkCompany(o[1]);
}

core.int buildCounterListCompaniesResponse = 0;
buildListCompaniesResponse() {
  var o = new api.ListCompaniesResponse();
  buildCounterListCompaniesResponse++;
  if (buildCounterListCompaniesResponse < 3) {
    o.companies = buildUnnamed1660();
    o.nextPageToken = "foo";
    o.responseMetadata = buildResponseMetadata();
  }
  buildCounterListCompaniesResponse--;
  return o;
}

checkListCompaniesResponse(api.ListCompaniesResponse o) {
  buildCounterListCompaniesResponse++;
  if (buildCounterListCompaniesResponse < 3) {
    checkUnnamed1660(o.companies);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkResponseMetadata(o.responseMetadata);
  }
  buildCounterListCompaniesResponse--;
}

buildUnnamed1661() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1661(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterListUserStatesResponse = 0;
buildListUserStatesResponse() {
  var o = new api.ListUserStatesResponse();
  buildCounterListUserStatesResponse++;
  if (buildCounterListUserStatesResponse < 3) {
    o.responseMetadata = buildResponseMetadata();
    o.userStates = buildUnnamed1661();
  }
  buildCounterListUserStatesResponse--;
  return o;
}

checkListUserStatesResponse(api.ListUserStatesResponse o) {
  buildCounterListUserStatesResponse++;
  if (buildCounterListUserStatesResponse < 3) {
    checkResponseMetadata(o.responseMetadata);
    checkUnnamed1661(o.userStates);
  }
  buildCounterListUserStatesResponse--;
}

buildUnnamed1662() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1662(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterLocalizedCompanyInfo = 0;
buildLocalizedCompanyInfo() {
  var o = new api.LocalizedCompanyInfo();
  buildCounterLocalizedCompanyInfo++;
  if (buildCounterLocalizedCompanyInfo < 3) {
    o.countryCodes = buildUnnamed1662();
    o.displayName = "foo";
    o.languageCode = "foo";
    o.overview = "foo";
  }
  buildCounterLocalizedCompanyInfo--;
  return o;
}

checkLocalizedCompanyInfo(api.LocalizedCompanyInfo o) {
  buildCounterLocalizedCompanyInfo++;
  if (buildCounterLocalizedCompanyInfo < 3) {
    checkUnnamed1662(o.countryCodes);
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.languageCode, unittest.equals('foo'));
    unittest.expect(o.overview, unittest.equals('foo'));
  }
  buildCounterLocalizedCompanyInfo--;
}

core.int buildCounterLocation = 0;
buildLocation() {
  var o = new api.Location();
  buildCounterLocation++;
  if (buildCounterLocation < 3) {
    o.address = "foo";
    o.latLng = buildLatLng();
  }
  buildCounterLocation--;
  return o;
}

checkLocation(api.Location o) {
  buildCounterLocation++;
  if (buildCounterLocation < 3) {
    unittest.expect(o.address, unittest.equals('foo'));
    checkLatLng(o.latLng);
  }
  buildCounterLocation--;
}

buildUnnamed1663() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed1663(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterLogMessageRequest = 0;
buildLogMessageRequest() {
  var o = new api.LogMessageRequest();
  buildCounterLogMessageRequest++;
  if (buildCounterLogMessageRequest < 3) {
    o.clientInfo = buildUnnamed1663();
    o.details = "foo";
    o.level = "foo";
    o.requestMetadata = buildRequestMetadata();
  }
  buildCounterLogMessageRequest--;
  return o;
}

checkLogMessageRequest(api.LogMessageRequest o) {
  buildCounterLogMessageRequest++;
  if (buildCounterLogMessageRequest < 3) {
    checkUnnamed1663(o.clientInfo);
    unittest.expect(o.details, unittest.equals('foo'));
    unittest.expect(o.level, unittest.equals('foo'));
    checkRequestMetadata(o.requestMetadata);
  }
  buildCounterLogMessageRequest--;
}

core.int buildCounterLogMessageResponse = 0;
buildLogMessageResponse() {
  var o = new api.LogMessageResponse();
  buildCounterLogMessageResponse++;
  if (buildCounterLogMessageResponse < 3) {
    o.responseMetadata = buildResponseMetadata();
  }
  buildCounterLogMessageResponse--;
  return o;
}

checkLogMessageResponse(api.LogMessageResponse o) {
  buildCounterLogMessageResponse++;
  if (buildCounterLogMessageResponse < 3) {
    checkResponseMetadata(o.responseMetadata);
  }
  buildCounterLogMessageResponse--;
}

buildUnnamed1664() {
  var o = new core.List<api.EventData>();
  o.add(buildEventData());
  o.add(buildEventData());
  return o;
}

checkUnnamed1664(core.List<api.EventData> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEventData(o[0]);
  checkEventData(o[1]);
}

core.int buildCounterLogUserEventRequest = 0;
buildLogUserEventRequest() {
  var o = new api.LogUserEventRequest();
  buildCounterLogUserEventRequest++;
  if (buildCounterLogUserEventRequest < 3) {
    o.eventAction = "foo";
    o.eventCategory = "foo";
    o.eventDatas = buildUnnamed1664();
    o.eventScope = "foo";
    o.lead = buildLead();
    o.requestMetadata = buildRequestMetadata();
    o.url = "foo";
  }
  buildCounterLogUserEventRequest--;
  return o;
}

checkLogUserEventRequest(api.LogUserEventRequest o) {
  buildCounterLogUserEventRequest++;
  if (buildCounterLogUserEventRequest < 3) {
    unittest.expect(o.eventAction, unittest.equals('foo'));
    unittest.expect(o.eventCategory, unittest.equals('foo'));
    checkUnnamed1664(o.eventDatas);
    unittest.expect(o.eventScope, unittest.equals('foo'));
    checkLead(o.lead);
    checkRequestMetadata(o.requestMetadata);
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterLogUserEventRequest--;
}

core.int buildCounterLogUserEventResponse = 0;
buildLogUserEventResponse() {
  var o = new api.LogUserEventResponse();
  buildCounterLogUserEventResponse++;
  if (buildCounterLogUserEventResponse < 3) {
    o.responseMetadata = buildResponseMetadata();
  }
  buildCounterLogUserEventResponse--;
  return o;
}

checkLogUserEventResponse(api.LogUserEventResponse o) {
  buildCounterLogUserEventResponse++;
  if (buildCounterLogUserEventResponse < 3) {
    checkResponseMetadata(o.responseMetadata);
  }
  buildCounterLogUserEventResponse--;
}

core.int buildCounterMoney = 0;
buildMoney() {
  var o = new api.Money();
  buildCounterMoney++;
  if (buildCounterMoney < 3) {
    o.currencyCode = "foo";
    o.nanos = 42;
    o.units = "foo";
  }
  buildCounterMoney--;
  return o;
}

checkMoney(api.Money o) {
  buildCounterMoney++;
  if (buildCounterMoney < 3) {
    unittest.expect(o.currencyCode, unittest.equals('foo'));
    unittest.expect(o.nanos, unittest.equals(42));
    unittest.expect(o.units, unittest.equals('foo'));
  }
  buildCounterMoney--;
}

core.int buildCounterPublicProfile = 0;
buildPublicProfile() {
  var o = new api.PublicProfile();
  buildCounterPublicProfile++;
  if (buildCounterPublicProfile < 3) {
    o.displayImageUrl = "foo";
    o.displayName = "foo";
    o.id = "foo";
    o.url = "foo";
  }
  buildCounterPublicProfile--;
  return o;
}

checkPublicProfile(api.PublicProfile o) {
  buildCounterPublicProfile++;
  if (buildCounterPublicProfile < 3) {
    unittest.expect(o.displayImageUrl, unittest.equals('foo'));
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterPublicProfile--;
}

core.int buildCounterRank = 0;
buildRank() {
  var o = new api.Rank();
  buildCounterRank++;
  if (buildCounterRank < 3) {
    o.type = "foo";
    o.value = 42.0;
  }
  buildCounterRank--;
  return o;
}

checkRank(api.Rank o) {
  buildCounterRank++;
  if (buildCounterRank < 3) {
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals(42.0));
  }
  buildCounterRank--;
}

core.int buildCounterRecaptchaChallenge = 0;
buildRecaptchaChallenge() {
  var o = new api.RecaptchaChallenge();
  buildCounterRecaptchaChallenge++;
  if (buildCounterRecaptchaChallenge < 3) {
    o.id = "foo";
    o.response = "foo";
  }
  buildCounterRecaptchaChallenge--;
  return o;
}

checkRecaptchaChallenge(api.RecaptchaChallenge o) {
  buildCounterRecaptchaChallenge++;
  if (buildCounterRecaptchaChallenge < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.response, unittest.equals('foo'));
  }
  buildCounterRecaptchaChallenge--;
}

buildUnnamed1665() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1665(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterRequestMetadata = 0;
buildRequestMetadata() {
  var o = new api.RequestMetadata();
  buildCounterRequestMetadata++;
  if (buildCounterRequestMetadata < 3) {
    o.experimentIds = buildUnnamed1665();
    o.locale = "foo";
    o.partnersSessionId = "foo";
    o.trafficSource = buildTrafficSource();
    o.userOverrides = buildUserOverrides();
  }
  buildCounterRequestMetadata--;
  return o;
}

checkRequestMetadata(api.RequestMetadata o) {
  buildCounterRequestMetadata++;
  if (buildCounterRequestMetadata < 3) {
    checkUnnamed1665(o.experimentIds);
    unittest.expect(o.locale, unittest.equals('foo'));
    unittest.expect(o.partnersSessionId, unittest.equals('foo'));
    checkTrafficSource(o.trafficSource);
    checkUserOverrides(o.userOverrides);
  }
  buildCounterRequestMetadata--;
}

core.int buildCounterResponseMetadata = 0;
buildResponseMetadata() {
  var o = new api.ResponseMetadata();
  buildCounterResponseMetadata++;
  if (buildCounterResponseMetadata < 3) {
    o.debugInfo = buildDebugInfo();
  }
  buildCounterResponseMetadata--;
  return o;
}

checkResponseMetadata(api.ResponseMetadata o) {
  buildCounterResponseMetadata++;
  if (buildCounterResponseMetadata < 3) {
    checkDebugInfo(o.debugInfo);
  }
  buildCounterResponseMetadata--;
}

core.int buildCounterTrafficSource = 0;
buildTrafficSource() {
  var o = new api.TrafficSource();
  buildCounterTrafficSource++;
  if (buildCounterTrafficSource < 3) {
    o.trafficSourceId = "foo";
    o.trafficSubId = "foo";
  }
  buildCounterTrafficSource--;
  return o;
}

checkTrafficSource(api.TrafficSource o) {
  buildCounterTrafficSource++;
  if (buildCounterTrafficSource < 3) {
    unittest.expect(o.trafficSourceId, unittest.equals('foo'));
    unittest.expect(o.trafficSubId, unittest.equals('foo'));
  }
  buildCounterTrafficSource--;
}

core.int buildCounterUserOverrides = 0;
buildUserOverrides() {
  var o = new api.UserOverrides();
  buildCounterUserOverrides++;
  if (buildCounterUserOverrides < 3) {
    o.ipAddress = "foo";
    o.userId = "foo";
  }
  buildCounterUserOverrides--;
  return o;
}

checkUserOverrides(api.UserOverrides o) {
  buildCounterUserOverrides++;
  if (buildCounterUserOverrides < 3) {
    unittest.expect(o.ipAddress, unittest.equals('foo'));
    unittest.expect(o.userId, unittest.equals('foo'));
  }
  buildCounterUserOverrides--;
}

buildUnnamed1666() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1666(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1667() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1667(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1668() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1668(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1669() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1669(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1670() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1670(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1671() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1671(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1672() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1672(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}


main() {
  unittest.group("obj-schema-CertificationExamStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildCertificationExamStatus();
      var od = new api.CertificationExamStatus.fromJson(o.toJson());
      checkCertificationExamStatus(od);
    });
  });


  unittest.group("obj-schema-CertificationStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildCertificationStatus();
      var od = new api.CertificationStatus.fromJson(o.toJson());
      checkCertificationStatus(od);
    });
  });


  unittest.group("obj-schema-Company", () {
    unittest.test("to-json--from-json", () {
      var o = buildCompany();
      var od = new api.Company.fromJson(o.toJson());
      checkCompany(od);
    });
  });


  unittest.group("obj-schema-CreateLeadRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateLeadRequest();
      var od = new api.CreateLeadRequest.fromJson(o.toJson());
      checkCreateLeadRequest(od);
    });
  });


  unittest.group("obj-schema-CreateLeadResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateLeadResponse();
      var od = new api.CreateLeadResponse.fromJson(o.toJson());
      checkCreateLeadResponse(od);
    });
  });


  unittest.group("obj-schema-DebugInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildDebugInfo();
      var od = new api.DebugInfo.fromJson(o.toJson());
      checkDebugInfo(od);
    });
  });


  unittest.group("obj-schema-EventData", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventData();
      var od = new api.EventData.fromJson(o.toJson());
      checkEventData(od);
    });
  });


  unittest.group("obj-schema-GetCompanyResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildGetCompanyResponse();
      var od = new api.GetCompanyResponse.fromJson(o.toJson());
      checkGetCompanyResponse(od);
    });
  });


  unittest.group("obj-schema-LatLng", () {
    unittest.test("to-json--from-json", () {
      var o = buildLatLng();
      var od = new api.LatLng.fromJson(o.toJson());
      checkLatLng(od);
    });
  });


  unittest.group("obj-schema-Lead", () {
    unittest.test("to-json--from-json", () {
      var o = buildLead();
      var od = new api.Lead.fromJson(o.toJson());
      checkLead(od);
    });
  });


  unittest.group("obj-schema-ListCompaniesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListCompaniesResponse();
      var od = new api.ListCompaniesResponse.fromJson(o.toJson());
      checkListCompaniesResponse(od);
    });
  });


  unittest.group("obj-schema-ListUserStatesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListUserStatesResponse();
      var od = new api.ListUserStatesResponse.fromJson(o.toJson());
      checkListUserStatesResponse(od);
    });
  });


  unittest.group("obj-schema-LocalizedCompanyInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildLocalizedCompanyInfo();
      var od = new api.LocalizedCompanyInfo.fromJson(o.toJson());
      checkLocalizedCompanyInfo(od);
    });
  });


  unittest.group("obj-schema-Location", () {
    unittest.test("to-json--from-json", () {
      var o = buildLocation();
      var od = new api.Location.fromJson(o.toJson());
      checkLocation(od);
    });
  });


  unittest.group("obj-schema-LogMessageRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildLogMessageRequest();
      var od = new api.LogMessageRequest.fromJson(o.toJson());
      checkLogMessageRequest(od);
    });
  });


  unittest.group("obj-schema-LogMessageResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildLogMessageResponse();
      var od = new api.LogMessageResponse.fromJson(o.toJson());
      checkLogMessageResponse(od);
    });
  });


  unittest.group("obj-schema-LogUserEventRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildLogUserEventRequest();
      var od = new api.LogUserEventRequest.fromJson(o.toJson());
      checkLogUserEventRequest(od);
    });
  });


  unittest.group("obj-schema-LogUserEventResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildLogUserEventResponse();
      var od = new api.LogUserEventResponse.fromJson(o.toJson());
      checkLogUserEventResponse(od);
    });
  });


  unittest.group("obj-schema-Money", () {
    unittest.test("to-json--from-json", () {
      var o = buildMoney();
      var od = new api.Money.fromJson(o.toJson());
      checkMoney(od);
    });
  });


  unittest.group("obj-schema-PublicProfile", () {
    unittest.test("to-json--from-json", () {
      var o = buildPublicProfile();
      var od = new api.PublicProfile.fromJson(o.toJson());
      checkPublicProfile(od);
    });
  });


  unittest.group("obj-schema-Rank", () {
    unittest.test("to-json--from-json", () {
      var o = buildRank();
      var od = new api.Rank.fromJson(o.toJson());
      checkRank(od);
    });
  });


  unittest.group("obj-schema-RecaptchaChallenge", () {
    unittest.test("to-json--from-json", () {
      var o = buildRecaptchaChallenge();
      var od = new api.RecaptchaChallenge.fromJson(o.toJson());
      checkRecaptchaChallenge(od);
    });
  });


  unittest.group("obj-schema-RequestMetadata", () {
    unittest.test("to-json--from-json", () {
      var o = buildRequestMetadata();
      var od = new api.RequestMetadata.fromJson(o.toJson());
      checkRequestMetadata(od);
    });
  });


  unittest.group("obj-schema-ResponseMetadata", () {
    unittest.test("to-json--from-json", () {
      var o = buildResponseMetadata();
      var od = new api.ResponseMetadata.fromJson(o.toJson());
      checkResponseMetadata(od);
    });
  });


  unittest.group("obj-schema-TrafficSource", () {
    unittest.test("to-json--from-json", () {
      var o = buildTrafficSource();
      var od = new api.TrafficSource.fromJson(o.toJson());
      checkTrafficSource(od);
    });
  });


  unittest.group("obj-schema-UserOverrides", () {
    unittest.test("to-json--from-json", () {
      var o = buildUserOverrides();
      var od = new api.UserOverrides.fromJson(o.toJson());
      checkUserOverrides(od);
    });
  });


  unittest.group("resource-ClientMessagesResourceApi", () {
    unittest.test("method--log", () {

      var mock = new HttpServerMock();
      api.ClientMessagesResourceApi res = new api.PartnersApi(mock).clientMessages;
      var arg_request = buildLogMessageRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.LogMessageRequest.fromJson(json);
        checkLogMessageRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("v2/clientMessages:log"));
        pathOffset += 21;

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
        var resp = convert.JSON.encode(buildLogMessageResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.log(arg_request).then(unittest.expectAsync(((api.LogMessageResponse response) {
        checkLogMessageResponse(response);
      })));
    });

  });


  unittest.group("resource-CompaniesResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.CompaniesResourceApi res = new api.PartnersApi(mock).companies;
      var arg_companyId = "foo";
      var arg_requestMetadata_userOverrides_ipAddress = "foo";
      var arg_requestMetadata_userOverrides_userId = "foo";
      var arg_requestMetadata_locale = "foo";
      var arg_requestMetadata_partnersSessionId = "foo";
      var arg_requestMetadata_experimentIds = buildUnnamed1666();
      var arg_requestMetadata_trafficSource_trafficSourceId = "foo";
      var arg_requestMetadata_trafficSource_trafficSubId = "foo";
      var arg_view = "foo";
      var arg_orderBy = "foo";
      var arg_currencyCode = "foo";
      var arg_address = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("v2/companies/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_companyId"));

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
        unittest.expect(queryMap["requestMetadata.userOverrides.ipAddress"].first, unittest.equals(arg_requestMetadata_userOverrides_ipAddress));
        unittest.expect(queryMap["requestMetadata.userOverrides.userId"].first, unittest.equals(arg_requestMetadata_userOverrides_userId));
        unittest.expect(queryMap["requestMetadata.locale"].first, unittest.equals(arg_requestMetadata_locale));
        unittest.expect(queryMap["requestMetadata.partnersSessionId"].first, unittest.equals(arg_requestMetadata_partnersSessionId));
        unittest.expect(queryMap["requestMetadata.experimentIds"], unittest.equals(arg_requestMetadata_experimentIds));
        unittest.expect(queryMap["requestMetadata.trafficSource.trafficSourceId"].first, unittest.equals(arg_requestMetadata_trafficSource_trafficSourceId));
        unittest.expect(queryMap["requestMetadata.trafficSource.trafficSubId"].first, unittest.equals(arg_requestMetadata_trafficSource_trafficSubId));
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));
        unittest.expect(queryMap["orderBy"].first, unittest.equals(arg_orderBy));
        unittest.expect(queryMap["currencyCode"].first, unittest.equals(arg_currencyCode));
        unittest.expect(queryMap["address"].first, unittest.equals(arg_address));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildGetCompanyResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_companyId, requestMetadata_userOverrides_ipAddress: arg_requestMetadata_userOverrides_ipAddress, requestMetadata_userOverrides_userId: arg_requestMetadata_userOverrides_userId, requestMetadata_locale: arg_requestMetadata_locale, requestMetadata_partnersSessionId: arg_requestMetadata_partnersSessionId, requestMetadata_experimentIds: arg_requestMetadata_experimentIds, requestMetadata_trafficSource_trafficSourceId: arg_requestMetadata_trafficSource_trafficSourceId, requestMetadata_trafficSource_trafficSubId: arg_requestMetadata_trafficSource_trafficSubId, view: arg_view, orderBy: arg_orderBy, currencyCode: arg_currencyCode, address: arg_address).then(unittest.expectAsync(((api.GetCompanyResponse response) {
        checkGetCompanyResponse(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.CompaniesResourceApi res = new api.PartnersApi(mock).companies;
      var arg_requestMetadata_userOverrides_ipAddress = "foo";
      var arg_requestMetadata_userOverrides_userId = "foo";
      var arg_requestMetadata_locale = "foo";
      var arg_requestMetadata_partnersSessionId = "foo";
      var arg_requestMetadata_experimentIds = buildUnnamed1667();
      var arg_requestMetadata_trafficSource_trafficSourceId = "foo";
      var arg_requestMetadata_trafficSource_trafficSubId = "foo";
      var arg_pageSize = 42;
      var arg_pageToken = "foo";
      var arg_companyName = "foo";
      var arg_view = "foo";
      var arg_minMonthlyBudget_currencyCode = "foo";
      var arg_minMonthlyBudget_units = "foo";
      var arg_minMonthlyBudget_nanos = 42;
      var arg_maxMonthlyBudget_currencyCode = "foo";
      var arg_maxMonthlyBudget_units = "foo";
      var arg_maxMonthlyBudget_nanos = 42;
      var arg_industries = buildUnnamed1668();
      var arg_services = buildUnnamed1669();
      var arg_languageCodes = buildUnnamed1670();
      var arg_address = "foo";
      var arg_orderBy = "foo";
      var arg_gpsMotivations = buildUnnamed1671();
      var arg_websiteUrl = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("v2/companies"));
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
        unittest.expect(queryMap["requestMetadata.userOverrides.ipAddress"].first, unittest.equals(arg_requestMetadata_userOverrides_ipAddress));
        unittest.expect(queryMap["requestMetadata.userOverrides.userId"].first, unittest.equals(arg_requestMetadata_userOverrides_userId));
        unittest.expect(queryMap["requestMetadata.locale"].first, unittest.equals(arg_requestMetadata_locale));
        unittest.expect(queryMap["requestMetadata.partnersSessionId"].first, unittest.equals(arg_requestMetadata_partnersSessionId));
        unittest.expect(queryMap["requestMetadata.experimentIds"], unittest.equals(arg_requestMetadata_experimentIds));
        unittest.expect(queryMap["requestMetadata.trafficSource.trafficSourceId"].first, unittest.equals(arg_requestMetadata_trafficSource_trafficSourceId));
        unittest.expect(queryMap["requestMetadata.trafficSource.trafficSubId"].first, unittest.equals(arg_requestMetadata_trafficSource_trafficSubId));
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["companyName"].first, unittest.equals(arg_companyName));
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));
        unittest.expect(queryMap["minMonthlyBudget.currencyCode"].first, unittest.equals(arg_minMonthlyBudget_currencyCode));
        unittest.expect(queryMap["minMonthlyBudget.units"].first, unittest.equals(arg_minMonthlyBudget_units));
        unittest.expect(core.int.parse(queryMap["minMonthlyBudget.nanos"].first), unittest.equals(arg_minMonthlyBudget_nanos));
        unittest.expect(queryMap["maxMonthlyBudget.currencyCode"].first, unittest.equals(arg_maxMonthlyBudget_currencyCode));
        unittest.expect(queryMap["maxMonthlyBudget.units"].first, unittest.equals(arg_maxMonthlyBudget_units));
        unittest.expect(core.int.parse(queryMap["maxMonthlyBudget.nanos"].first), unittest.equals(arg_maxMonthlyBudget_nanos));
        unittest.expect(queryMap["industries"], unittest.equals(arg_industries));
        unittest.expect(queryMap["services"], unittest.equals(arg_services));
        unittest.expect(queryMap["languageCodes"], unittest.equals(arg_languageCodes));
        unittest.expect(queryMap["address"].first, unittest.equals(arg_address));
        unittest.expect(queryMap["orderBy"].first, unittest.equals(arg_orderBy));
        unittest.expect(queryMap["gpsMotivations"], unittest.equals(arg_gpsMotivations));
        unittest.expect(queryMap["websiteUrl"].first, unittest.equals(arg_websiteUrl));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListCompaniesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(requestMetadata_userOverrides_ipAddress: arg_requestMetadata_userOverrides_ipAddress, requestMetadata_userOverrides_userId: arg_requestMetadata_userOverrides_userId, requestMetadata_locale: arg_requestMetadata_locale, requestMetadata_partnersSessionId: arg_requestMetadata_partnersSessionId, requestMetadata_experimentIds: arg_requestMetadata_experimentIds, requestMetadata_trafficSource_trafficSourceId: arg_requestMetadata_trafficSource_trafficSourceId, requestMetadata_trafficSource_trafficSubId: arg_requestMetadata_trafficSource_trafficSubId, pageSize: arg_pageSize, pageToken: arg_pageToken, companyName: arg_companyName, view: arg_view, minMonthlyBudget_currencyCode: arg_minMonthlyBudget_currencyCode, minMonthlyBudget_units: arg_minMonthlyBudget_units, minMonthlyBudget_nanos: arg_minMonthlyBudget_nanos, maxMonthlyBudget_currencyCode: arg_maxMonthlyBudget_currencyCode, maxMonthlyBudget_units: arg_maxMonthlyBudget_units, maxMonthlyBudget_nanos: arg_maxMonthlyBudget_nanos, industries: arg_industries, services: arg_services, languageCodes: arg_languageCodes, address: arg_address, orderBy: arg_orderBy, gpsMotivations: arg_gpsMotivations, websiteUrl: arg_websiteUrl).then(unittest.expectAsync(((api.ListCompaniesResponse response) {
        checkListCompaniesResponse(response);
      })));
    });

  });


  unittest.group("resource-CompaniesLeadsResourceApi", () {
    unittest.test("method--create", () {

      var mock = new HttpServerMock();
      api.CompaniesLeadsResourceApi res = new api.PartnersApi(mock).companies.leads;
      var arg_request = buildCreateLeadRequest();
      var arg_companyId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.CreateLeadRequest.fromJson(json);
        checkCreateLeadRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("v2/companies/"));
        pathOffset += 13;
        index = path.indexOf("/leads", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_companyId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/leads"));
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
        var resp = convert.JSON.encode(buildCreateLeadResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.create(arg_request, arg_companyId).then(unittest.expectAsync(((api.CreateLeadResponse response) {
        checkCreateLeadResponse(response);
      })));
    });

  });


  unittest.group("resource-UserEventsResourceApi", () {
    unittest.test("method--log", () {

      var mock = new HttpServerMock();
      api.UserEventsResourceApi res = new api.PartnersApi(mock).userEvents;
      var arg_request = buildLogUserEventRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.LogUserEventRequest.fromJson(json);
        checkLogUserEventRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("v2/userEvents:log"));
        pathOffset += 17;

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
        var resp = convert.JSON.encode(buildLogUserEventResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.log(arg_request).then(unittest.expectAsync(((api.LogUserEventResponse response) {
        checkLogUserEventResponse(response);
      })));
    });

  });


  unittest.group("resource-UserStatesResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.UserStatesResourceApi res = new api.PartnersApi(mock).userStates;
      var arg_requestMetadata_userOverrides_ipAddress = "foo";
      var arg_requestMetadata_userOverrides_userId = "foo";
      var arg_requestMetadata_locale = "foo";
      var arg_requestMetadata_partnersSessionId = "foo";
      var arg_requestMetadata_experimentIds = buildUnnamed1672();
      var arg_requestMetadata_trafficSource_trafficSourceId = "foo";
      var arg_requestMetadata_trafficSource_trafficSubId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("v2/userStates"));
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
        unittest.expect(queryMap["requestMetadata.userOverrides.ipAddress"].first, unittest.equals(arg_requestMetadata_userOverrides_ipAddress));
        unittest.expect(queryMap["requestMetadata.userOverrides.userId"].first, unittest.equals(arg_requestMetadata_userOverrides_userId));
        unittest.expect(queryMap["requestMetadata.locale"].first, unittest.equals(arg_requestMetadata_locale));
        unittest.expect(queryMap["requestMetadata.partnersSessionId"].first, unittest.equals(arg_requestMetadata_partnersSessionId));
        unittest.expect(queryMap["requestMetadata.experimentIds"], unittest.equals(arg_requestMetadata_experimentIds));
        unittest.expect(queryMap["requestMetadata.trafficSource.trafficSourceId"].first, unittest.equals(arg_requestMetadata_trafficSource_trafficSourceId));
        unittest.expect(queryMap["requestMetadata.trafficSource.trafficSubId"].first, unittest.equals(arg_requestMetadata_trafficSource_trafficSubId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListUserStatesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(requestMetadata_userOverrides_ipAddress: arg_requestMetadata_userOverrides_ipAddress, requestMetadata_userOverrides_userId: arg_requestMetadata_userOverrides_userId, requestMetadata_locale: arg_requestMetadata_locale, requestMetadata_partnersSessionId: arg_requestMetadata_partnersSessionId, requestMetadata_experimentIds: arg_requestMetadata_experimentIds, requestMetadata_trafficSource_trafficSourceId: arg_requestMetadata_trafficSource_trafficSourceId, requestMetadata_trafficSource_trafficSubId: arg_requestMetadata_trafficSource_trafficSubId).then(unittest.expectAsync(((api.ListUserStatesResponse response) {
        checkListUserStatesResponse(response);
      })));
    });

  });


}

