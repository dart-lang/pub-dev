library googleapis.content.v2.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/content/v2.dart' as api;

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

buildUnnamed254() {
  var o = new core.List<api.AccountAdwordsLink>();
  o.add(buildAccountAdwordsLink());
  o.add(buildAccountAdwordsLink());
  return o;
}

checkUnnamed254(core.List<api.AccountAdwordsLink> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountAdwordsLink(o[0]);
  checkAccountAdwordsLink(o[1]);
}

buildUnnamed255() {
  var o = new core.List<api.AccountUser>();
  o.add(buildAccountUser());
  o.add(buildAccountUser());
  return o;
}

checkUnnamed255(core.List<api.AccountUser> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountUser(o[0]);
  checkAccountUser(o[1]);
}

core.int buildCounterAccount = 0;
buildAccount() {
  var o = new api.Account();
  buildCounterAccount++;
  if (buildCounterAccount < 3) {
    o.adultContent = true;
    o.adwordsLinks = buildUnnamed254();
    o.id = "foo";
    o.kind = "foo";
    o.name = "foo";
    o.reviewsUrl = "foo";
    o.sellerId = "foo";
    o.users = buildUnnamed255();
    o.websiteUrl = "foo";
  }
  buildCounterAccount--;
  return o;
}

checkAccount(api.Account o) {
  buildCounterAccount++;
  if (buildCounterAccount < 3) {
    unittest.expect(o.adultContent, unittest.isTrue);
    checkUnnamed254(o.adwordsLinks);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.reviewsUrl, unittest.equals('foo'));
    unittest.expect(o.sellerId, unittest.equals('foo'));
    checkUnnamed255(o.users);
    unittest.expect(o.websiteUrl, unittest.equals('foo'));
  }
  buildCounterAccount--;
}

core.int buildCounterAccountAdwordsLink = 0;
buildAccountAdwordsLink() {
  var o = new api.AccountAdwordsLink();
  buildCounterAccountAdwordsLink++;
  if (buildCounterAccountAdwordsLink < 3) {
    o.adwordsId = "foo";
    o.status = "foo";
  }
  buildCounterAccountAdwordsLink--;
  return o;
}

checkAccountAdwordsLink(api.AccountAdwordsLink o) {
  buildCounterAccountAdwordsLink++;
  if (buildCounterAccountAdwordsLink < 3) {
    unittest.expect(o.adwordsId, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterAccountAdwordsLink--;
}

core.int buildCounterAccountIdentifier = 0;
buildAccountIdentifier() {
  var o = new api.AccountIdentifier();
  buildCounterAccountIdentifier++;
  if (buildCounterAccountIdentifier < 3) {
    o.aggregatorId = "foo";
    o.merchantId = "foo";
  }
  buildCounterAccountIdentifier--;
  return o;
}

checkAccountIdentifier(api.AccountIdentifier o) {
  buildCounterAccountIdentifier++;
  if (buildCounterAccountIdentifier < 3) {
    unittest.expect(o.aggregatorId, unittest.equals('foo'));
    unittest.expect(o.merchantId, unittest.equals('foo'));
  }
  buildCounterAccountIdentifier--;
}

buildUnnamed256() {
  var o = new core.List<api.AccountShippingCarrierRate>();
  o.add(buildAccountShippingCarrierRate());
  o.add(buildAccountShippingCarrierRate());
  return o;
}

checkUnnamed256(core.List<api.AccountShippingCarrierRate> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountShippingCarrierRate(o[0]);
  checkAccountShippingCarrierRate(o[1]);
}

buildUnnamed257() {
  var o = new core.List<api.AccountShippingLocationGroup>();
  o.add(buildAccountShippingLocationGroup());
  o.add(buildAccountShippingLocationGroup());
  return o;
}

checkUnnamed257(core.List<api.AccountShippingLocationGroup> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountShippingLocationGroup(o[0]);
  checkAccountShippingLocationGroup(o[1]);
}

buildUnnamed258() {
  var o = new core.List<api.AccountShippingRateTable>();
  o.add(buildAccountShippingRateTable());
  o.add(buildAccountShippingRateTable());
  return o;
}

checkUnnamed258(core.List<api.AccountShippingRateTable> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountShippingRateTable(o[0]);
  checkAccountShippingRateTable(o[1]);
}

buildUnnamed259() {
  var o = new core.List<api.AccountShippingShippingService>();
  o.add(buildAccountShippingShippingService());
  o.add(buildAccountShippingShippingService());
  return o;
}

checkUnnamed259(core.List<api.AccountShippingShippingService> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountShippingShippingService(o[0]);
  checkAccountShippingShippingService(o[1]);
}

core.int buildCounterAccountShipping = 0;
buildAccountShipping() {
  var o = new api.AccountShipping();
  buildCounterAccountShipping++;
  if (buildCounterAccountShipping < 3) {
    o.accountId = "foo";
    o.carrierRates = buildUnnamed256();
    o.kind = "foo";
    o.locationGroups = buildUnnamed257();
    o.rateTables = buildUnnamed258();
    o.services = buildUnnamed259();
  }
  buildCounterAccountShipping--;
  return o;
}

checkAccountShipping(api.AccountShipping o) {
  buildCounterAccountShipping++;
  if (buildCounterAccountShipping < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    checkUnnamed256(o.carrierRates);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed257(o.locationGroups);
    checkUnnamed258(o.rateTables);
    checkUnnamed259(o.services);
  }
  buildCounterAccountShipping--;
}

core.int buildCounterAccountShippingCarrierRate = 0;
buildAccountShippingCarrierRate() {
  var o = new api.AccountShippingCarrierRate();
  buildCounterAccountShippingCarrierRate++;
  if (buildCounterAccountShippingCarrierRate < 3) {
    o.carrier = "foo";
    o.carrierService = "foo";
    o.modifierFlatRate = buildPrice();
    o.modifierPercent = "foo";
    o.name = "foo";
    o.saleCountry = "foo";
    o.shippingOrigin = "foo";
  }
  buildCounterAccountShippingCarrierRate--;
  return o;
}

checkAccountShippingCarrierRate(api.AccountShippingCarrierRate o) {
  buildCounterAccountShippingCarrierRate++;
  if (buildCounterAccountShippingCarrierRate < 3) {
    unittest.expect(o.carrier, unittest.equals('foo'));
    unittest.expect(o.carrierService, unittest.equals('foo'));
    checkPrice(o.modifierFlatRate);
    unittest.expect(o.modifierPercent, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.saleCountry, unittest.equals('foo'));
    unittest.expect(o.shippingOrigin, unittest.equals('foo'));
  }
  buildCounterAccountShippingCarrierRate--;
}

core.int buildCounterAccountShippingCondition = 0;
buildAccountShippingCondition() {
  var o = new api.AccountShippingCondition();
  buildCounterAccountShippingCondition++;
  if (buildCounterAccountShippingCondition < 3) {
    o.deliveryLocationGroup = "foo";
    o.deliveryLocationId = "foo";
    o.deliveryPostalCode = "foo";
    o.deliveryPostalCodeRange = buildAccountShippingPostalCodeRange();
    o.priceMax = buildPrice();
    o.shippingLabel = "foo";
    o.weightMax = buildWeight();
  }
  buildCounterAccountShippingCondition--;
  return o;
}

checkAccountShippingCondition(api.AccountShippingCondition o) {
  buildCounterAccountShippingCondition++;
  if (buildCounterAccountShippingCondition < 3) {
    unittest.expect(o.deliveryLocationGroup, unittest.equals('foo'));
    unittest.expect(o.deliveryLocationId, unittest.equals('foo'));
    unittest.expect(o.deliveryPostalCode, unittest.equals('foo'));
    checkAccountShippingPostalCodeRange(o.deliveryPostalCodeRange);
    checkPrice(o.priceMax);
    unittest.expect(o.shippingLabel, unittest.equals('foo'));
    checkWeight(o.weightMax);
  }
  buildCounterAccountShippingCondition--;
}

buildUnnamed260() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed260(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed261() {
  var o = new core.List<api.AccountShippingPostalCodeRange>();
  o.add(buildAccountShippingPostalCodeRange());
  o.add(buildAccountShippingPostalCodeRange());
  return o;
}

checkUnnamed261(core.List<api.AccountShippingPostalCodeRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountShippingPostalCodeRange(o[0]);
  checkAccountShippingPostalCodeRange(o[1]);
}

buildUnnamed262() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed262(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterAccountShippingLocationGroup = 0;
buildAccountShippingLocationGroup() {
  var o = new api.AccountShippingLocationGroup();
  buildCounterAccountShippingLocationGroup++;
  if (buildCounterAccountShippingLocationGroup < 3) {
    o.country = "foo";
    o.locationIds = buildUnnamed260();
    o.name = "foo";
    o.postalCodeRanges = buildUnnamed261();
    o.postalCodes = buildUnnamed262();
  }
  buildCounterAccountShippingLocationGroup--;
  return o;
}

checkAccountShippingLocationGroup(api.AccountShippingLocationGroup o) {
  buildCounterAccountShippingLocationGroup++;
  if (buildCounterAccountShippingLocationGroup < 3) {
    unittest.expect(o.country, unittest.equals('foo'));
    checkUnnamed260(o.locationIds);
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed261(o.postalCodeRanges);
    checkUnnamed262(o.postalCodes);
  }
  buildCounterAccountShippingLocationGroup--;
}

core.int buildCounterAccountShippingPostalCodeRange = 0;
buildAccountShippingPostalCodeRange() {
  var o = new api.AccountShippingPostalCodeRange();
  buildCounterAccountShippingPostalCodeRange++;
  if (buildCounterAccountShippingPostalCodeRange < 3) {
    o.end = "foo";
    o.start = "foo";
  }
  buildCounterAccountShippingPostalCodeRange--;
  return o;
}

checkAccountShippingPostalCodeRange(api.AccountShippingPostalCodeRange o) {
  buildCounterAccountShippingPostalCodeRange++;
  if (buildCounterAccountShippingPostalCodeRange < 3) {
    unittest.expect(o.end, unittest.equals('foo'));
    unittest.expect(o.start, unittest.equals('foo'));
  }
  buildCounterAccountShippingPostalCodeRange--;
}

buildUnnamed263() {
  var o = new core.List<api.AccountShippingRateTableCell>();
  o.add(buildAccountShippingRateTableCell());
  o.add(buildAccountShippingRateTableCell());
  return o;
}

checkUnnamed263(core.List<api.AccountShippingRateTableCell> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountShippingRateTableCell(o[0]);
  checkAccountShippingRateTableCell(o[1]);
}

core.int buildCounterAccountShippingRateTable = 0;
buildAccountShippingRateTable() {
  var o = new api.AccountShippingRateTable();
  buildCounterAccountShippingRateTable++;
  if (buildCounterAccountShippingRateTable < 3) {
    o.content = buildUnnamed263();
    o.name = "foo";
    o.saleCountry = "foo";
  }
  buildCounterAccountShippingRateTable--;
  return o;
}

checkAccountShippingRateTable(api.AccountShippingRateTable o) {
  buildCounterAccountShippingRateTable++;
  if (buildCounterAccountShippingRateTable < 3) {
    checkUnnamed263(o.content);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.saleCountry, unittest.equals('foo'));
  }
  buildCounterAccountShippingRateTable--;
}

core.int buildCounterAccountShippingRateTableCell = 0;
buildAccountShippingRateTableCell() {
  var o = new api.AccountShippingRateTableCell();
  buildCounterAccountShippingRateTableCell++;
  if (buildCounterAccountShippingRateTableCell < 3) {
    o.condition = buildAccountShippingCondition();
    o.rate = buildPrice();
  }
  buildCounterAccountShippingRateTableCell--;
  return o;
}

checkAccountShippingRateTableCell(api.AccountShippingRateTableCell o) {
  buildCounterAccountShippingRateTableCell++;
  if (buildCounterAccountShippingRateTableCell < 3) {
    checkAccountShippingCondition(o.condition);
    checkPrice(o.rate);
  }
  buildCounterAccountShippingRateTableCell--;
}

core.int buildCounterAccountShippingShippingService = 0;
buildAccountShippingShippingService() {
  var o = new api.AccountShippingShippingService();
  buildCounterAccountShippingShippingService++;
  if (buildCounterAccountShippingShippingService < 3) {
    o.active = true;
    o.calculationMethod = buildAccountShippingShippingServiceCalculationMethod();
    o.costRuleTree = buildAccountShippingShippingServiceCostRule();
    o.maxDaysInTransit = "foo";
    o.minDaysInTransit = "foo";
    o.name = "foo";
    o.saleCountry = "foo";
  }
  buildCounterAccountShippingShippingService--;
  return o;
}

checkAccountShippingShippingService(api.AccountShippingShippingService o) {
  buildCounterAccountShippingShippingService++;
  if (buildCounterAccountShippingShippingService < 3) {
    unittest.expect(o.active, unittest.isTrue);
    checkAccountShippingShippingServiceCalculationMethod(o.calculationMethod);
    checkAccountShippingShippingServiceCostRule(o.costRuleTree);
    unittest.expect(o.maxDaysInTransit, unittest.equals('foo'));
    unittest.expect(o.minDaysInTransit, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.saleCountry, unittest.equals('foo'));
  }
  buildCounterAccountShippingShippingService--;
}

core.int buildCounterAccountShippingShippingServiceCalculationMethod = 0;
buildAccountShippingShippingServiceCalculationMethod() {
  var o = new api.AccountShippingShippingServiceCalculationMethod();
  buildCounterAccountShippingShippingServiceCalculationMethod++;
  if (buildCounterAccountShippingShippingServiceCalculationMethod < 3) {
    o.carrierRate = "foo";
    o.excluded = true;
    o.flatRate = buildPrice();
    o.percentageRate = "foo";
    o.rateTable = "foo";
  }
  buildCounterAccountShippingShippingServiceCalculationMethod--;
  return o;
}

checkAccountShippingShippingServiceCalculationMethod(api.AccountShippingShippingServiceCalculationMethod o) {
  buildCounterAccountShippingShippingServiceCalculationMethod++;
  if (buildCounterAccountShippingShippingServiceCalculationMethod < 3) {
    unittest.expect(o.carrierRate, unittest.equals('foo'));
    unittest.expect(o.excluded, unittest.isTrue);
    checkPrice(o.flatRate);
    unittest.expect(o.percentageRate, unittest.equals('foo'));
    unittest.expect(o.rateTable, unittest.equals('foo'));
  }
  buildCounterAccountShippingShippingServiceCalculationMethod--;
}

buildUnnamed264() {
  var o = new core.List<api.AccountShippingShippingServiceCostRule>();
  o.add(buildAccountShippingShippingServiceCostRule());
  o.add(buildAccountShippingShippingServiceCostRule());
  return o;
}

checkUnnamed264(core.List<api.AccountShippingShippingServiceCostRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountShippingShippingServiceCostRule(o[0]);
  checkAccountShippingShippingServiceCostRule(o[1]);
}

core.int buildCounterAccountShippingShippingServiceCostRule = 0;
buildAccountShippingShippingServiceCostRule() {
  var o = new api.AccountShippingShippingServiceCostRule();
  buildCounterAccountShippingShippingServiceCostRule++;
  if (buildCounterAccountShippingShippingServiceCostRule < 3) {
    o.calculationMethod = buildAccountShippingShippingServiceCalculationMethod();
    o.children = buildUnnamed264();
    o.condition = buildAccountShippingCondition();
  }
  buildCounterAccountShippingShippingServiceCostRule--;
  return o;
}

checkAccountShippingShippingServiceCostRule(api.AccountShippingShippingServiceCostRule o) {
  buildCounterAccountShippingShippingServiceCostRule++;
  if (buildCounterAccountShippingShippingServiceCostRule < 3) {
    checkAccountShippingShippingServiceCalculationMethod(o.calculationMethod);
    checkUnnamed264(o.children);
    checkAccountShippingCondition(o.condition);
  }
  buildCounterAccountShippingShippingServiceCostRule--;
}

buildUnnamed265() {
  var o = new core.List<api.AccountStatusDataQualityIssue>();
  o.add(buildAccountStatusDataQualityIssue());
  o.add(buildAccountStatusDataQualityIssue());
  return o;
}

checkUnnamed265(core.List<api.AccountStatusDataQualityIssue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountStatusDataQualityIssue(o[0]);
  checkAccountStatusDataQualityIssue(o[1]);
}

core.int buildCounterAccountStatus = 0;
buildAccountStatus() {
  var o = new api.AccountStatus();
  buildCounterAccountStatus++;
  if (buildCounterAccountStatus < 3) {
    o.accountId = "foo";
    o.dataQualityIssues = buildUnnamed265();
    o.kind = "foo";
  }
  buildCounterAccountStatus--;
  return o;
}

checkAccountStatus(api.AccountStatus o) {
  buildCounterAccountStatus++;
  if (buildCounterAccountStatus < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    checkUnnamed265(o.dataQualityIssues);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAccountStatus--;
}

buildUnnamed266() {
  var o = new core.List<api.AccountStatusExampleItem>();
  o.add(buildAccountStatusExampleItem());
  o.add(buildAccountStatusExampleItem());
  return o;
}

checkUnnamed266(core.List<api.AccountStatusExampleItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountStatusExampleItem(o[0]);
  checkAccountStatusExampleItem(o[1]);
}

core.int buildCounterAccountStatusDataQualityIssue = 0;
buildAccountStatusDataQualityIssue() {
  var o = new api.AccountStatusDataQualityIssue();
  buildCounterAccountStatusDataQualityIssue++;
  if (buildCounterAccountStatusDataQualityIssue < 3) {
    o.country = "foo";
    o.detail = "foo";
    o.displayedValue = "foo";
    o.exampleItems = buildUnnamed266();
    o.id = "foo";
    o.lastChecked = "foo";
    o.location = "foo";
    o.numItems = 42;
    o.severity = "foo";
    o.submittedValue = "foo";
  }
  buildCounterAccountStatusDataQualityIssue--;
  return o;
}

checkAccountStatusDataQualityIssue(api.AccountStatusDataQualityIssue o) {
  buildCounterAccountStatusDataQualityIssue++;
  if (buildCounterAccountStatusDataQualityIssue < 3) {
    unittest.expect(o.country, unittest.equals('foo'));
    unittest.expect(o.detail, unittest.equals('foo'));
    unittest.expect(o.displayedValue, unittest.equals('foo'));
    checkUnnamed266(o.exampleItems);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.lastChecked, unittest.equals('foo'));
    unittest.expect(o.location, unittest.equals('foo'));
    unittest.expect(o.numItems, unittest.equals(42));
    unittest.expect(o.severity, unittest.equals('foo'));
    unittest.expect(o.submittedValue, unittest.equals('foo'));
  }
  buildCounterAccountStatusDataQualityIssue--;
}

core.int buildCounterAccountStatusExampleItem = 0;
buildAccountStatusExampleItem() {
  var o = new api.AccountStatusExampleItem();
  buildCounterAccountStatusExampleItem++;
  if (buildCounterAccountStatusExampleItem < 3) {
    o.itemId = "foo";
    o.link = "foo";
    o.submittedValue = "foo";
    o.title = "foo";
    o.valueOnLandingPage = "foo";
  }
  buildCounterAccountStatusExampleItem--;
  return o;
}

checkAccountStatusExampleItem(api.AccountStatusExampleItem o) {
  buildCounterAccountStatusExampleItem++;
  if (buildCounterAccountStatusExampleItem < 3) {
    unittest.expect(o.itemId, unittest.equals('foo'));
    unittest.expect(o.link, unittest.equals('foo'));
    unittest.expect(o.submittedValue, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.valueOnLandingPage, unittest.equals('foo'));
  }
  buildCounterAccountStatusExampleItem--;
}

buildUnnamed267() {
  var o = new core.List<api.AccountTaxTaxRule>();
  o.add(buildAccountTaxTaxRule());
  o.add(buildAccountTaxTaxRule());
  return o;
}

checkUnnamed267(core.List<api.AccountTaxTaxRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountTaxTaxRule(o[0]);
  checkAccountTaxTaxRule(o[1]);
}

core.int buildCounterAccountTax = 0;
buildAccountTax() {
  var o = new api.AccountTax();
  buildCounterAccountTax++;
  if (buildCounterAccountTax < 3) {
    o.accountId = "foo";
    o.kind = "foo";
    o.rules = buildUnnamed267();
  }
  buildCounterAccountTax--;
  return o;
}

checkAccountTax(api.AccountTax o) {
  buildCounterAccountTax++;
  if (buildCounterAccountTax < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed267(o.rules);
  }
  buildCounterAccountTax--;
}

core.int buildCounterAccountTaxTaxRule = 0;
buildAccountTaxTaxRule() {
  var o = new api.AccountTaxTaxRule();
  buildCounterAccountTaxTaxRule++;
  if (buildCounterAccountTaxTaxRule < 3) {
    o.country = "foo";
    o.locationId = "foo";
    o.ratePercent = "foo";
    o.shippingTaxed = true;
    o.useGlobalRate = true;
  }
  buildCounterAccountTaxTaxRule--;
  return o;
}

checkAccountTaxTaxRule(api.AccountTaxTaxRule o) {
  buildCounterAccountTaxTaxRule++;
  if (buildCounterAccountTaxTaxRule < 3) {
    unittest.expect(o.country, unittest.equals('foo'));
    unittest.expect(o.locationId, unittest.equals('foo'));
    unittest.expect(o.ratePercent, unittest.equals('foo'));
    unittest.expect(o.shippingTaxed, unittest.isTrue);
    unittest.expect(o.useGlobalRate, unittest.isTrue);
  }
  buildCounterAccountTaxTaxRule--;
}

core.int buildCounterAccountUser = 0;
buildAccountUser() {
  var o = new api.AccountUser();
  buildCounterAccountUser++;
  if (buildCounterAccountUser < 3) {
    o.admin = true;
    o.emailAddress = "foo";
  }
  buildCounterAccountUser--;
  return o;
}

checkAccountUser(api.AccountUser o) {
  buildCounterAccountUser++;
  if (buildCounterAccountUser < 3) {
    unittest.expect(o.admin, unittest.isTrue);
    unittest.expect(o.emailAddress, unittest.equals('foo'));
  }
  buildCounterAccountUser--;
}

buildUnnamed268() {
  var o = new core.List<api.AccountIdentifier>();
  o.add(buildAccountIdentifier());
  o.add(buildAccountIdentifier());
  return o;
}

checkUnnamed268(core.List<api.AccountIdentifier> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountIdentifier(o[0]);
  checkAccountIdentifier(o[1]);
}

core.int buildCounterAccountsAuthInfoResponse = 0;
buildAccountsAuthInfoResponse() {
  var o = new api.AccountsAuthInfoResponse();
  buildCounterAccountsAuthInfoResponse++;
  if (buildCounterAccountsAuthInfoResponse < 3) {
    o.accountIdentifiers = buildUnnamed268();
    o.kind = "foo";
  }
  buildCounterAccountsAuthInfoResponse--;
  return o;
}

checkAccountsAuthInfoResponse(api.AccountsAuthInfoResponse o) {
  buildCounterAccountsAuthInfoResponse++;
  if (buildCounterAccountsAuthInfoResponse < 3) {
    checkUnnamed268(o.accountIdentifiers);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAccountsAuthInfoResponse--;
}

buildUnnamed269() {
  var o = new core.List<api.AccountsCustomBatchRequestEntry>();
  o.add(buildAccountsCustomBatchRequestEntry());
  o.add(buildAccountsCustomBatchRequestEntry());
  return o;
}

checkUnnamed269(core.List<api.AccountsCustomBatchRequestEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountsCustomBatchRequestEntry(o[0]);
  checkAccountsCustomBatchRequestEntry(o[1]);
}

core.int buildCounterAccountsCustomBatchRequest = 0;
buildAccountsCustomBatchRequest() {
  var o = new api.AccountsCustomBatchRequest();
  buildCounterAccountsCustomBatchRequest++;
  if (buildCounterAccountsCustomBatchRequest < 3) {
    o.entries = buildUnnamed269();
  }
  buildCounterAccountsCustomBatchRequest--;
  return o;
}

checkAccountsCustomBatchRequest(api.AccountsCustomBatchRequest o) {
  buildCounterAccountsCustomBatchRequest++;
  if (buildCounterAccountsCustomBatchRequest < 3) {
    checkUnnamed269(o.entries);
  }
  buildCounterAccountsCustomBatchRequest--;
}

core.int buildCounterAccountsCustomBatchRequestEntry = 0;
buildAccountsCustomBatchRequestEntry() {
  var o = new api.AccountsCustomBatchRequestEntry();
  buildCounterAccountsCustomBatchRequestEntry++;
  if (buildCounterAccountsCustomBatchRequestEntry < 3) {
    o.account = buildAccount();
    o.accountId = "foo";
    o.batchId = 42;
    o.merchantId = "foo";
    o.method = "foo";
  }
  buildCounterAccountsCustomBatchRequestEntry--;
  return o;
}

checkAccountsCustomBatchRequestEntry(api.AccountsCustomBatchRequestEntry o) {
  buildCounterAccountsCustomBatchRequestEntry++;
  if (buildCounterAccountsCustomBatchRequestEntry < 3) {
    checkAccount(o.account);
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.batchId, unittest.equals(42));
    unittest.expect(o.merchantId, unittest.equals('foo'));
    unittest.expect(o.method, unittest.equals('foo'));
  }
  buildCounterAccountsCustomBatchRequestEntry--;
}

buildUnnamed270() {
  var o = new core.List<api.AccountsCustomBatchResponseEntry>();
  o.add(buildAccountsCustomBatchResponseEntry());
  o.add(buildAccountsCustomBatchResponseEntry());
  return o;
}

checkUnnamed270(core.List<api.AccountsCustomBatchResponseEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountsCustomBatchResponseEntry(o[0]);
  checkAccountsCustomBatchResponseEntry(o[1]);
}

core.int buildCounterAccountsCustomBatchResponse = 0;
buildAccountsCustomBatchResponse() {
  var o = new api.AccountsCustomBatchResponse();
  buildCounterAccountsCustomBatchResponse++;
  if (buildCounterAccountsCustomBatchResponse < 3) {
    o.entries = buildUnnamed270();
    o.kind = "foo";
  }
  buildCounterAccountsCustomBatchResponse--;
  return o;
}

checkAccountsCustomBatchResponse(api.AccountsCustomBatchResponse o) {
  buildCounterAccountsCustomBatchResponse++;
  if (buildCounterAccountsCustomBatchResponse < 3) {
    checkUnnamed270(o.entries);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAccountsCustomBatchResponse--;
}

core.int buildCounterAccountsCustomBatchResponseEntry = 0;
buildAccountsCustomBatchResponseEntry() {
  var o = new api.AccountsCustomBatchResponseEntry();
  buildCounterAccountsCustomBatchResponseEntry++;
  if (buildCounterAccountsCustomBatchResponseEntry < 3) {
    o.account = buildAccount();
    o.batchId = 42;
    o.errors = buildErrors();
    o.kind = "foo";
  }
  buildCounterAccountsCustomBatchResponseEntry--;
  return o;
}

checkAccountsCustomBatchResponseEntry(api.AccountsCustomBatchResponseEntry o) {
  buildCounterAccountsCustomBatchResponseEntry++;
  if (buildCounterAccountsCustomBatchResponseEntry < 3) {
    checkAccount(o.account);
    unittest.expect(o.batchId, unittest.equals(42));
    checkErrors(o.errors);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAccountsCustomBatchResponseEntry--;
}

buildUnnamed271() {
  var o = new core.List<api.Account>();
  o.add(buildAccount());
  o.add(buildAccount());
  return o;
}

checkUnnamed271(core.List<api.Account> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccount(o[0]);
  checkAccount(o[1]);
}

core.int buildCounterAccountsListResponse = 0;
buildAccountsListResponse() {
  var o = new api.AccountsListResponse();
  buildCounterAccountsListResponse++;
  if (buildCounterAccountsListResponse < 3) {
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.resources = buildUnnamed271();
  }
  buildCounterAccountsListResponse--;
  return o;
}

checkAccountsListResponse(api.AccountsListResponse o) {
  buildCounterAccountsListResponse++;
  if (buildCounterAccountsListResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed271(o.resources);
  }
  buildCounterAccountsListResponse--;
}

buildUnnamed272() {
  var o = new core.List<api.AccountshippingCustomBatchRequestEntry>();
  o.add(buildAccountshippingCustomBatchRequestEntry());
  o.add(buildAccountshippingCustomBatchRequestEntry());
  return o;
}

checkUnnamed272(core.List<api.AccountshippingCustomBatchRequestEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountshippingCustomBatchRequestEntry(o[0]);
  checkAccountshippingCustomBatchRequestEntry(o[1]);
}

core.int buildCounterAccountshippingCustomBatchRequest = 0;
buildAccountshippingCustomBatchRequest() {
  var o = new api.AccountshippingCustomBatchRequest();
  buildCounterAccountshippingCustomBatchRequest++;
  if (buildCounterAccountshippingCustomBatchRequest < 3) {
    o.entries = buildUnnamed272();
  }
  buildCounterAccountshippingCustomBatchRequest--;
  return o;
}

checkAccountshippingCustomBatchRequest(api.AccountshippingCustomBatchRequest o) {
  buildCounterAccountshippingCustomBatchRequest++;
  if (buildCounterAccountshippingCustomBatchRequest < 3) {
    checkUnnamed272(o.entries);
  }
  buildCounterAccountshippingCustomBatchRequest--;
}

core.int buildCounterAccountshippingCustomBatchRequestEntry = 0;
buildAccountshippingCustomBatchRequestEntry() {
  var o = new api.AccountshippingCustomBatchRequestEntry();
  buildCounterAccountshippingCustomBatchRequestEntry++;
  if (buildCounterAccountshippingCustomBatchRequestEntry < 3) {
    o.accountId = "foo";
    o.accountShipping = buildAccountShipping();
    o.batchId = 42;
    o.merchantId = "foo";
    o.method = "foo";
  }
  buildCounterAccountshippingCustomBatchRequestEntry--;
  return o;
}

checkAccountshippingCustomBatchRequestEntry(api.AccountshippingCustomBatchRequestEntry o) {
  buildCounterAccountshippingCustomBatchRequestEntry++;
  if (buildCounterAccountshippingCustomBatchRequestEntry < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    checkAccountShipping(o.accountShipping);
    unittest.expect(o.batchId, unittest.equals(42));
    unittest.expect(o.merchantId, unittest.equals('foo'));
    unittest.expect(o.method, unittest.equals('foo'));
  }
  buildCounterAccountshippingCustomBatchRequestEntry--;
}

buildUnnamed273() {
  var o = new core.List<api.AccountshippingCustomBatchResponseEntry>();
  o.add(buildAccountshippingCustomBatchResponseEntry());
  o.add(buildAccountshippingCustomBatchResponseEntry());
  return o;
}

checkUnnamed273(core.List<api.AccountshippingCustomBatchResponseEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountshippingCustomBatchResponseEntry(o[0]);
  checkAccountshippingCustomBatchResponseEntry(o[1]);
}

core.int buildCounterAccountshippingCustomBatchResponse = 0;
buildAccountshippingCustomBatchResponse() {
  var o = new api.AccountshippingCustomBatchResponse();
  buildCounterAccountshippingCustomBatchResponse++;
  if (buildCounterAccountshippingCustomBatchResponse < 3) {
    o.entries = buildUnnamed273();
    o.kind = "foo";
  }
  buildCounterAccountshippingCustomBatchResponse--;
  return o;
}

checkAccountshippingCustomBatchResponse(api.AccountshippingCustomBatchResponse o) {
  buildCounterAccountshippingCustomBatchResponse++;
  if (buildCounterAccountshippingCustomBatchResponse < 3) {
    checkUnnamed273(o.entries);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAccountshippingCustomBatchResponse--;
}

core.int buildCounterAccountshippingCustomBatchResponseEntry = 0;
buildAccountshippingCustomBatchResponseEntry() {
  var o = new api.AccountshippingCustomBatchResponseEntry();
  buildCounterAccountshippingCustomBatchResponseEntry++;
  if (buildCounterAccountshippingCustomBatchResponseEntry < 3) {
    o.accountShipping = buildAccountShipping();
    o.batchId = 42;
    o.errors = buildErrors();
    o.kind = "foo";
  }
  buildCounterAccountshippingCustomBatchResponseEntry--;
  return o;
}

checkAccountshippingCustomBatchResponseEntry(api.AccountshippingCustomBatchResponseEntry o) {
  buildCounterAccountshippingCustomBatchResponseEntry++;
  if (buildCounterAccountshippingCustomBatchResponseEntry < 3) {
    checkAccountShipping(o.accountShipping);
    unittest.expect(o.batchId, unittest.equals(42));
    checkErrors(o.errors);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAccountshippingCustomBatchResponseEntry--;
}

buildUnnamed274() {
  var o = new core.List<api.AccountShipping>();
  o.add(buildAccountShipping());
  o.add(buildAccountShipping());
  return o;
}

checkUnnamed274(core.List<api.AccountShipping> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountShipping(o[0]);
  checkAccountShipping(o[1]);
}

core.int buildCounterAccountshippingListResponse = 0;
buildAccountshippingListResponse() {
  var o = new api.AccountshippingListResponse();
  buildCounterAccountshippingListResponse++;
  if (buildCounterAccountshippingListResponse < 3) {
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.resources = buildUnnamed274();
  }
  buildCounterAccountshippingListResponse--;
  return o;
}

checkAccountshippingListResponse(api.AccountshippingListResponse o) {
  buildCounterAccountshippingListResponse++;
  if (buildCounterAccountshippingListResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed274(o.resources);
  }
  buildCounterAccountshippingListResponse--;
}

buildUnnamed275() {
  var o = new core.List<api.AccountstatusesCustomBatchRequestEntry>();
  o.add(buildAccountstatusesCustomBatchRequestEntry());
  o.add(buildAccountstatusesCustomBatchRequestEntry());
  return o;
}

checkUnnamed275(core.List<api.AccountstatusesCustomBatchRequestEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountstatusesCustomBatchRequestEntry(o[0]);
  checkAccountstatusesCustomBatchRequestEntry(o[1]);
}

core.int buildCounterAccountstatusesCustomBatchRequest = 0;
buildAccountstatusesCustomBatchRequest() {
  var o = new api.AccountstatusesCustomBatchRequest();
  buildCounterAccountstatusesCustomBatchRequest++;
  if (buildCounterAccountstatusesCustomBatchRequest < 3) {
    o.entries = buildUnnamed275();
  }
  buildCounterAccountstatusesCustomBatchRequest--;
  return o;
}

checkAccountstatusesCustomBatchRequest(api.AccountstatusesCustomBatchRequest o) {
  buildCounterAccountstatusesCustomBatchRequest++;
  if (buildCounterAccountstatusesCustomBatchRequest < 3) {
    checkUnnamed275(o.entries);
  }
  buildCounterAccountstatusesCustomBatchRequest--;
}

core.int buildCounterAccountstatusesCustomBatchRequestEntry = 0;
buildAccountstatusesCustomBatchRequestEntry() {
  var o = new api.AccountstatusesCustomBatchRequestEntry();
  buildCounterAccountstatusesCustomBatchRequestEntry++;
  if (buildCounterAccountstatusesCustomBatchRequestEntry < 3) {
    o.accountId = "foo";
    o.batchId = 42;
    o.merchantId = "foo";
    o.method = "foo";
  }
  buildCounterAccountstatusesCustomBatchRequestEntry--;
  return o;
}

checkAccountstatusesCustomBatchRequestEntry(api.AccountstatusesCustomBatchRequestEntry o) {
  buildCounterAccountstatusesCustomBatchRequestEntry++;
  if (buildCounterAccountstatusesCustomBatchRequestEntry < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.batchId, unittest.equals(42));
    unittest.expect(o.merchantId, unittest.equals('foo'));
    unittest.expect(o.method, unittest.equals('foo'));
  }
  buildCounterAccountstatusesCustomBatchRequestEntry--;
}

buildUnnamed276() {
  var o = new core.List<api.AccountstatusesCustomBatchResponseEntry>();
  o.add(buildAccountstatusesCustomBatchResponseEntry());
  o.add(buildAccountstatusesCustomBatchResponseEntry());
  return o;
}

checkUnnamed276(core.List<api.AccountstatusesCustomBatchResponseEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountstatusesCustomBatchResponseEntry(o[0]);
  checkAccountstatusesCustomBatchResponseEntry(o[1]);
}

core.int buildCounterAccountstatusesCustomBatchResponse = 0;
buildAccountstatusesCustomBatchResponse() {
  var o = new api.AccountstatusesCustomBatchResponse();
  buildCounterAccountstatusesCustomBatchResponse++;
  if (buildCounterAccountstatusesCustomBatchResponse < 3) {
    o.entries = buildUnnamed276();
    o.kind = "foo";
  }
  buildCounterAccountstatusesCustomBatchResponse--;
  return o;
}

checkAccountstatusesCustomBatchResponse(api.AccountstatusesCustomBatchResponse o) {
  buildCounterAccountstatusesCustomBatchResponse++;
  if (buildCounterAccountstatusesCustomBatchResponse < 3) {
    checkUnnamed276(o.entries);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAccountstatusesCustomBatchResponse--;
}

core.int buildCounterAccountstatusesCustomBatchResponseEntry = 0;
buildAccountstatusesCustomBatchResponseEntry() {
  var o = new api.AccountstatusesCustomBatchResponseEntry();
  buildCounterAccountstatusesCustomBatchResponseEntry++;
  if (buildCounterAccountstatusesCustomBatchResponseEntry < 3) {
    o.accountStatus = buildAccountStatus();
    o.batchId = 42;
    o.errors = buildErrors();
  }
  buildCounterAccountstatusesCustomBatchResponseEntry--;
  return o;
}

checkAccountstatusesCustomBatchResponseEntry(api.AccountstatusesCustomBatchResponseEntry o) {
  buildCounterAccountstatusesCustomBatchResponseEntry++;
  if (buildCounterAccountstatusesCustomBatchResponseEntry < 3) {
    checkAccountStatus(o.accountStatus);
    unittest.expect(o.batchId, unittest.equals(42));
    checkErrors(o.errors);
  }
  buildCounterAccountstatusesCustomBatchResponseEntry--;
}

buildUnnamed277() {
  var o = new core.List<api.AccountStatus>();
  o.add(buildAccountStatus());
  o.add(buildAccountStatus());
  return o;
}

checkUnnamed277(core.List<api.AccountStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountStatus(o[0]);
  checkAccountStatus(o[1]);
}

core.int buildCounterAccountstatusesListResponse = 0;
buildAccountstatusesListResponse() {
  var o = new api.AccountstatusesListResponse();
  buildCounterAccountstatusesListResponse++;
  if (buildCounterAccountstatusesListResponse < 3) {
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.resources = buildUnnamed277();
  }
  buildCounterAccountstatusesListResponse--;
  return o;
}

checkAccountstatusesListResponse(api.AccountstatusesListResponse o) {
  buildCounterAccountstatusesListResponse++;
  if (buildCounterAccountstatusesListResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed277(o.resources);
  }
  buildCounterAccountstatusesListResponse--;
}

buildUnnamed278() {
  var o = new core.List<api.AccounttaxCustomBatchRequestEntry>();
  o.add(buildAccounttaxCustomBatchRequestEntry());
  o.add(buildAccounttaxCustomBatchRequestEntry());
  return o;
}

checkUnnamed278(core.List<api.AccounttaxCustomBatchRequestEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccounttaxCustomBatchRequestEntry(o[0]);
  checkAccounttaxCustomBatchRequestEntry(o[1]);
}

core.int buildCounterAccounttaxCustomBatchRequest = 0;
buildAccounttaxCustomBatchRequest() {
  var o = new api.AccounttaxCustomBatchRequest();
  buildCounterAccounttaxCustomBatchRequest++;
  if (buildCounterAccounttaxCustomBatchRequest < 3) {
    o.entries = buildUnnamed278();
  }
  buildCounterAccounttaxCustomBatchRequest--;
  return o;
}

checkAccounttaxCustomBatchRequest(api.AccounttaxCustomBatchRequest o) {
  buildCounterAccounttaxCustomBatchRequest++;
  if (buildCounterAccounttaxCustomBatchRequest < 3) {
    checkUnnamed278(o.entries);
  }
  buildCounterAccounttaxCustomBatchRequest--;
}

core.int buildCounterAccounttaxCustomBatchRequestEntry = 0;
buildAccounttaxCustomBatchRequestEntry() {
  var o = new api.AccounttaxCustomBatchRequestEntry();
  buildCounterAccounttaxCustomBatchRequestEntry++;
  if (buildCounterAccounttaxCustomBatchRequestEntry < 3) {
    o.accountId = "foo";
    o.accountTax = buildAccountTax();
    o.batchId = 42;
    o.merchantId = "foo";
    o.method = "foo";
  }
  buildCounterAccounttaxCustomBatchRequestEntry--;
  return o;
}

checkAccounttaxCustomBatchRequestEntry(api.AccounttaxCustomBatchRequestEntry o) {
  buildCounterAccounttaxCustomBatchRequestEntry++;
  if (buildCounterAccounttaxCustomBatchRequestEntry < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    checkAccountTax(o.accountTax);
    unittest.expect(o.batchId, unittest.equals(42));
    unittest.expect(o.merchantId, unittest.equals('foo'));
    unittest.expect(o.method, unittest.equals('foo'));
  }
  buildCounterAccounttaxCustomBatchRequestEntry--;
}

buildUnnamed279() {
  var o = new core.List<api.AccounttaxCustomBatchResponseEntry>();
  o.add(buildAccounttaxCustomBatchResponseEntry());
  o.add(buildAccounttaxCustomBatchResponseEntry());
  return o;
}

checkUnnamed279(core.List<api.AccounttaxCustomBatchResponseEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccounttaxCustomBatchResponseEntry(o[0]);
  checkAccounttaxCustomBatchResponseEntry(o[1]);
}

core.int buildCounterAccounttaxCustomBatchResponse = 0;
buildAccounttaxCustomBatchResponse() {
  var o = new api.AccounttaxCustomBatchResponse();
  buildCounterAccounttaxCustomBatchResponse++;
  if (buildCounterAccounttaxCustomBatchResponse < 3) {
    o.entries = buildUnnamed279();
    o.kind = "foo";
  }
  buildCounterAccounttaxCustomBatchResponse--;
  return o;
}

checkAccounttaxCustomBatchResponse(api.AccounttaxCustomBatchResponse o) {
  buildCounterAccounttaxCustomBatchResponse++;
  if (buildCounterAccounttaxCustomBatchResponse < 3) {
    checkUnnamed279(o.entries);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAccounttaxCustomBatchResponse--;
}

core.int buildCounterAccounttaxCustomBatchResponseEntry = 0;
buildAccounttaxCustomBatchResponseEntry() {
  var o = new api.AccounttaxCustomBatchResponseEntry();
  buildCounterAccounttaxCustomBatchResponseEntry++;
  if (buildCounterAccounttaxCustomBatchResponseEntry < 3) {
    o.accountTax = buildAccountTax();
    o.batchId = 42;
    o.errors = buildErrors();
    o.kind = "foo";
  }
  buildCounterAccounttaxCustomBatchResponseEntry--;
  return o;
}

checkAccounttaxCustomBatchResponseEntry(api.AccounttaxCustomBatchResponseEntry o) {
  buildCounterAccounttaxCustomBatchResponseEntry++;
  if (buildCounterAccounttaxCustomBatchResponseEntry < 3) {
    checkAccountTax(o.accountTax);
    unittest.expect(o.batchId, unittest.equals(42));
    checkErrors(o.errors);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAccounttaxCustomBatchResponseEntry--;
}

buildUnnamed280() {
  var o = new core.List<api.AccountTax>();
  o.add(buildAccountTax());
  o.add(buildAccountTax());
  return o;
}

checkUnnamed280(core.List<api.AccountTax> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccountTax(o[0]);
  checkAccountTax(o[1]);
}

core.int buildCounterAccounttaxListResponse = 0;
buildAccounttaxListResponse() {
  var o = new api.AccounttaxListResponse();
  buildCounterAccounttaxListResponse++;
  if (buildCounterAccounttaxListResponse < 3) {
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.resources = buildUnnamed280();
  }
  buildCounterAccounttaxListResponse--;
  return o;
}

checkAccounttaxListResponse(api.AccounttaxListResponse o) {
  buildCounterAccounttaxListResponse++;
  if (buildCounterAccounttaxListResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed280(o.resources);
  }
  buildCounterAccounttaxListResponse--;
}

core.int buildCounterCarrierRate = 0;
buildCarrierRate() {
  var o = new api.CarrierRate();
  buildCounterCarrierRate++;
  if (buildCounterCarrierRate < 3) {
    o.carrierName = "foo";
    o.carrierService = "foo";
    o.flatAdjustment = buildPrice();
    o.name = "foo";
    o.originPostalCode = "foo";
    o.percentageAdjustment = "foo";
  }
  buildCounterCarrierRate--;
  return o;
}

checkCarrierRate(api.CarrierRate o) {
  buildCounterCarrierRate++;
  if (buildCounterCarrierRate < 3) {
    unittest.expect(o.carrierName, unittest.equals('foo'));
    unittest.expect(o.carrierService, unittest.equals('foo'));
    checkPrice(o.flatAdjustment);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.originPostalCode, unittest.equals('foo'));
    unittest.expect(o.percentageAdjustment, unittest.equals('foo'));
  }
  buildCounterCarrierRate--;
}

buildUnnamed281() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed281(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterCarriersCarrier = 0;
buildCarriersCarrier() {
  var o = new api.CarriersCarrier();
  buildCounterCarriersCarrier++;
  if (buildCounterCarriersCarrier < 3) {
    o.country = "foo";
    o.name = "foo";
    o.services = buildUnnamed281();
  }
  buildCounterCarriersCarrier--;
  return o;
}

checkCarriersCarrier(api.CarriersCarrier o) {
  buildCounterCarriersCarrier++;
  if (buildCounterCarriersCarrier < 3) {
    unittest.expect(o.country, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed281(o.services);
  }
  buildCounterCarriersCarrier--;
}

buildUnnamed282() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed282(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterDatafeed = 0;
buildDatafeed() {
  var o = new api.Datafeed();
  buildCounterDatafeed++;
  if (buildCounterDatafeed < 3) {
    o.attributeLanguage = "foo";
    o.contentLanguage = "foo";
    o.contentType = "foo";
    o.fetchSchedule = buildDatafeedFetchSchedule();
    o.fileName = "foo";
    o.format = buildDatafeedFormat();
    o.id = "foo";
    o.intendedDestinations = buildUnnamed282();
    o.kind = "foo";
    o.name = "foo";
    o.targetCountry = "foo";
  }
  buildCounterDatafeed--;
  return o;
}

checkDatafeed(api.Datafeed o) {
  buildCounterDatafeed++;
  if (buildCounterDatafeed < 3) {
    unittest.expect(o.attributeLanguage, unittest.equals('foo'));
    unittest.expect(o.contentLanguage, unittest.equals('foo'));
    unittest.expect(o.contentType, unittest.equals('foo'));
    checkDatafeedFetchSchedule(o.fetchSchedule);
    unittest.expect(o.fileName, unittest.equals('foo'));
    checkDatafeedFormat(o.format);
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed282(o.intendedDestinations);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.targetCountry, unittest.equals('foo'));
  }
  buildCounterDatafeed--;
}

core.int buildCounterDatafeedFetchSchedule = 0;
buildDatafeedFetchSchedule() {
  var o = new api.DatafeedFetchSchedule();
  buildCounterDatafeedFetchSchedule++;
  if (buildCounterDatafeedFetchSchedule < 3) {
    o.dayOfMonth = 42;
    o.fetchUrl = "foo";
    o.hour = 42;
    o.minuteOfHour = 42;
    o.password = "foo";
    o.timeZone = "foo";
    o.username = "foo";
    o.weekday = "foo";
  }
  buildCounterDatafeedFetchSchedule--;
  return o;
}

checkDatafeedFetchSchedule(api.DatafeedFetchSchedule o) {
  buildCounterDatafeedFetchSchedule++;
  if (buildCounterDatafeedFetchSchedule < 3) {
    unittest.expect(o.dayOfMonth, unittest.equals(42));
    unittest.expect(o.fetchUrl, unittest.equals('foo'));
    unittest.expect(o.hour, unittest.equals(42));
    unittest.expect(o.minuteOfHour, unittest.equals(42));
    unittest.expect(o.password, unittest.equals('foo'));
    unittest.expect(o.timeZone, unittest.equals('foo'));
    unittest.expect(o.username, unittest.equals('foo'));
    unittest.expect(o.weekday, unittest.equals('foo'));
  }
  buildCounterDatafeedFetchSchedule--;
}

core.int buildCounterDatafeedFormat = 0;
buildDatafeedFormat() {
  var o = new api.DatafeedFormat();
  buildCounterDatafeedFormat++;
  if (buildCounterDatafeedFormat < 3) {
    o.columnDelimiter = "foo";
    o.fileEncoding = "foo";
    o.quotingMode = "foo";
  }
  buildCounterDatafeedFormat--;
  return o;
}

checkDatafeedFormat(api.DatafeedFormat o) {
  buildCounterDatafeedFormat++;
  if (buildCounterDatafeedFormat < 3) {
    unittest.expect(o.columnDelimiter, unittest.equals('foo'));
    unittest.expect(o.fileEncoding, unittest.equals('foo'));
    unittest.expect(o.quotingMode, unittest.equals('foo'));
  }
  buildCounterDatafeedFormat--;
}

buildUnnamed283() {
  var o = new core.List<api.DatafeedStatusError>();
  o.add(buildDatafeedStatusError());
  o.add(buildDatafeedStatusError());
  return o;
}

checkUnnamed283(core.List<api.DatafeedStatusError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatafeedStatusError(o[0]);
  checkDatafeedStatusError(o[1]);
}

buildUnnamed284() {
  var o = new core.List<api.DatafeedStatusError>();
  o.add(buildDatafeedStatusError());
  o.add(buildDatafeedStatusError());
  return o;
}

checkUnnamed284(core.List<api.DatafeedStatusError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatafeedStatusError(o[0]);
  checkDatafeedStatusError(o[1]);
}

core.int buildCounterDatafeedStatus = 0;
buildDatafeedStatus() {
  var o = new api.DatafeedStatus();
  buildCounterDatafeedStatus++;
  if (buildCounterDatafeedStatus < 3) {
    o.datafeedId = "foo";
    o.errors = buildUnnamed283();
    o.itemsTotal = "foo";
    o.itemsValid = "foo";
    o.kind = "foo";
    o.lastUploadDate = "foo";
    o.processingStatus = "foo";
    o.warnings = buildUnnamed284();
  }
  buildCounterDatafeedStatus--;
  return o;
}

checkDatafeedStatus(api.DatafeedStatus o) {
  buildCounterDatafeedStatus++;
  if (buildCounterDatafeedStatus < 3) {
    unittest.expect(o.datafeedId, unittest.equals('foo'));
    checkUnnamed283(o.errors);
    unittest.expect(o.itemsTotal, unittest.equals('foo'));
    unittest.expect(o.itemsValid, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.lastUploadDate, unittest.equals('foo'));
    unittest.expect(o.processingStatus, unittest.equals('foo'));
    checkUnnamed284(o.warnings);
  }
  buildCounterDatafeedStatus--;
}

buildUnnamed285() {
  var o = new core.List<api.DatafeedStatusExample>();
  o.add(buildDatafeedStatusExample());
  o.add(buildDatafeedStatusExample());
  return o;
}

checkUnnamed285(core.List<api.DatafeedStatusExample> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatafeedStatusExample(o[0]);
  checkDatafeedStatusExample(o[1]);
}

core.int buildCounterDatafeedStatusError = 0;
buildDatafeedStatusError() {
  var o = new api.DatafeedStatusError();
  buildCounterDatafeedStatusError++;
  if (buildCounterDatafeedStatusError < 3) {
    o.code = "foo";
    o.count = "foo";
    o.examples = buildUnnamed285();
    o.message = "foo";
  }
  buildCounterDatafeedStatusError--;
  return o;
}

checkDatafeedStatusError(api.DatafeedStatusError o) {
  buildCounterDatafeedStatusError++;
  if (buildCounterDatafeedStatusError < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    unittest.expect(o.count, unittest.equals('foo'));
    checkUnnamed285(o.examples);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterDatafeedStatusError--;
}

core.int buildCounterDatafeedStatusExample = 0;
buildDatafeedStatusExample() {
  var o = new api.DatafeedStatusExample();
  buildCounterDatafeedStatusExample++;
  if (buildCounterDatafeedStatusExample < 3) {
    o.itemId = "foo";
    o.lineNumber = "foo";
    o.value = "foo";
  }
  buildCounterDatafeedStatusExample--;
  return o;
}

checkDatafeedStatusExample(api.DatafeedStatusExample o) {
  buildCounterDatafeedStatusExample++;
  if (buildCounterDatafeedStatusExample < 3) {
    unittest.expect(o.itemId, unittest.equals('foo'));
    unittest.expect(o.lineNumber, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterDatafeedStatusExample--;
}

buildUnnamed286() {
  var o = new core.List<api.DatafeedsCustomBatchRequestEntry>();
  o.add(buildDatafeedsCustomBatchRequestEntry());
  o.add(buildDatafeedsCustomBatchRequestEntry());
  return o;
}

checkUnnamed286(core.List<api.DatafeedsCustomBatchRequestEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatafeedsCustomBatchRequestEntry(o[0]);
  checkDatafeedsCustomBatchRequestEntry(o[1]);
}

core.int buildCounterDatafeedsCustomBatchRequest = 0;
buildDatafeedsCustomBatchRequest() {
  var o = new api.DatafeedsCustomBatchRequest();
  buildCounterDatafeedsCustomBatchRequest++;
  if (buildCounterDatafeedsCustomBatchRequest < 3) {
    o.entries = buildUnnamed286();
  }
  buildCounterDatafeedsCustomBatchRequest--;
  return o;
}

checkDatafeedsCustomBatchRequest(api.DatafeedsCustomBatchRequest o) {
  buildCounterDatafeedsCustomBatchRequest++;
  if (buildCounterDatafeedsCustomBatchRequest < 3) {
    checkUnnamed286(o.entries);
  }
  buildCounterDatafeedsCustomBatchRequest--;
}

core.int buildCounterDatafeedsCustomBatchRequestEntry = 0;
buildDatafeedsCustomBatchRequestEntry() {
  var o = new api.DatafeedsCustomBatchRequestEntry();
  buildCounterDatafeedsCustomBatchRequestEntry++;
  if (buildCounterDatafeedsCustomBatchRequestEntry < 3) {
    o.batchId = 42;
    o.datafeed = buildDatafeed();
    o.datafeedId = "foo";
    o.merchantId = "foo";
    o.method = "foo";
  }
  buildCounterDatafeedsCustomBatchRequestEntry--;
  return o;
}

checkDatafeedsCustomBatchRequestEntry(api.DatafeedsCustomBatchRequestEntry o) {
  buildCounterDatafeedsCustomBatchRequestEntry++;
  if (buildCounterDatafeedsCustomBatchRequestEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    checkDatafeed(o.datafeed);
    unittest.expect(o.datafeedId, unittest.equals('foo'));
    unittest.expect(o.merchantId, unittest.equals('foo'));
    unittest.expect(o.method, unittest.equals('foo'));
  }
  buildCounterDatafeedsCustomBatchRequestEntry--;
}

buildUnnamed287() {
  var o = new core.List<api.DatafeedsCustomBatchResponseEntry>();
  o.add(buildDatafeedsCustomBatchResponseEntry());
  o.add(buildDatafeedsCustomBatchResponseEntry());
  return o;
}

checkUnnamed287(core.List<api.DatafeedsCustomBatchResponseEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatafeedsCustomBatchResponseEntry(o[0]);
  checkDatafeedsCustomBatchResponseEntry(o[1]);
}

core.int buildCounterDatafeedsCustomBatchResponse = 0;
buildDatafeedsCustomBatchResponse() {
  var o = new api.DatafeedsCustomBatchResponse();
  buildCounterDatafeedsCustomBatchResponse++;
  if (buildCounterDatafeedsCustomBatchResponse < 3) {
    o.entries = buildUnnamed287();
    o.kind = "foo";
  }
  buildCounterDatafeedsCustomBatchResponse--;
  return o;
}

checkDatafeedsCustomBatchResponse(api.DatafeedsCustomBatchResponse o) {
  buildCounterDatafeedsCustomBatchResponse++;
  if (buildCounterDatafeedsCustomBatchResponse < 3) {
    checkUnnamed287(o.entries);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterDatafeedsCustomBatchResponse--;
}

core.int buildCounterDatafeedsCustomBatchResponseEntry = 0;
buildDatafeedsCustomBatchResponseEntry() {
  var o = new api.DatafeedsCustomBatchResponseEntry();
  buildCounterDatafeedsCustomBatchResponseEntry++;
  if (buildCounterDatafeedsCustomBatchResponseEntry < 3) {
    o.batchId = 42;
    o.datafeed = buildDatafeed();
    o.errors = buildErrors();
  }
  buildCounterDatafeedsCustomBatchResponseEntry--;
  return o;
}

checkDatafeedsCustomBatchResponseEntry(api.DatafeedsCustomBatchResponseEntry o) {
  buildCounterDatafeedsCustomBatchResponseEntry++;
  if (buildCounterDatafeedsCustomBatchResponseEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    checkDatafeed(o.datafeed);
    checkErrors(o.errors);
  }
  buildCounterDatafeedsCustomBatchResponseEntry--;
}

buildUnnamed288() {
  var o = new core.List<api.Datafeed>();
  o.add(buildDatafeed());
  o.add(buildDatafeed());
  return o;
}

checkUnnamed288(core.List<api.Datafeed> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatafeed(o[0]);
  checkDatafeed(o[1]);
}

core.int buildCounterDatafeedsListResponse = 0;
buildDatafeedsListResponse() {
  var o = new api.DatafeedsListResponse();
  buildCounterDatafeedsListResponse++;
  if (buildCounterDatafeedsListResponse < 3) {
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.resources = buildUnnamed288();
  }
  buildCounterDatafeedsListResponse--;
  return o;
}

checkDatafeedsListResponse(api.DatafeedsListResponse o) {
  buildCounterDatafeedsListResponse++;
  if (buildCounterDatafeedsListResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed288(o.resources);
  }
  buildCounterDatafeedsListResponse--;
}

buildUnnamed289() {
  var o = new core.List<api.DatafeedstatusesCustomBatchRequestEntry>();
  o.add(buildDatafeedstatusesCustomBatchRequestEntry());
  o.add(buildDatafeedstatusesCustomBatchRequestEntry());
  return o;
}

checkUnnamed289(core.List<api.DatafeedstatusesCustomBatchRequestEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatafeedstatusesCustomBatchRequestEntry(o[0]);
  checkDatafeedstatusesCustomBatchRequestEntry(o[1]);
}

core.int buildCounterDatafeedstatusesCustomBatchRequest = 0;
buildDatafeedstatusesCustomBatchRequest() {
  var o = new api.DatafeedstatusesCustomBatchRequest();
  buildCounterDatafeedstatusesCustomBatchRequest++;
  if (buildCounterDatafeedstatusesCustomBatchRequest < 3) {
    o.entries = buildUnnamed289();
  }
  buildCounterDatafeedstatusesCustomBatchRequest--;
  return o;
}

checkDatafeedstatusesCustomBatchRequest(api.DatafeedstatusesCustomBatchRequest o) {
  buildCounterDatafeedstatusesCustomBatchRequest++;
  if (buildCounterDatafeedstatusesCustomBatchRequest < 3) {
    checkUnnamed289(o.entries);
  }
  buildCounterDatafeedstatusesCustomBatchRequest--;
}

core.int buildCounterDatafeedstatusesCustomBatchRequestEntry = 0;
buildDatafeedstatusesCustomBatchRequestEntry() {
  var o = new api.DatafeedstatusesCustomBatchRequestEntry();
  buildCounterDatafeedstatusesCustomBatchRequestEntry++;
  if (buildCounterDatafeedstatusesCustomBatchRequestEntry < 3) {
    o.batchId = 42;
    o.datafeedId = "foo";
    o.merchantId = "foo";
    o.method = "foo";
  }
  buildCounterDatafeedstatusesCustomBatchRequestEntry--;
  return o;
}

checkDatafeedstatusesCustomBatchRequestEntry(api.DatafeedstatusesCustomBatchRequestEntry o) {
  buildCounterDatafeedstatusesCustomBatchRequestEntry++;
  if (buildCounterDatafeedstatusesCustomBatchRequestEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    unittest.expect(o.datafeedId, unittest.equals('foo'));
    unittest.expect(o.merchantId, unittest.equals('foo'));
    unittest.expect(o.method, unittest.equals('foo'));
  }
  buildCounterDatafeedstatusesCustomBatchRequestEntry--;
}

buildUnnamed290() {
  var o = new core.List<api.DatafeedstatusesCustomBatchResponseEntry>();
  o.add(buildDatafeedstatusesCustomBatchResponseEntry());
  o.add(buildDatafeedstatusesCustomBatchResponseEntry());
  return o;
}

checkUnnamed290(core.List<api.DatafeedstatusesCustomBatchResponseEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatafeedstatusesCustomBatchResponseEntry(o[0]);
  checkDatafeedstatusesCustomBatchResponseEntry(o[1]);
}

core.int buildCounterDatafeedstatusesCustomBatchResponse = 0;
buildDatafeedstatusesCustomBatchResponse() {
  var o = new api.DatafeedstatusesCustomBatchResponse();
  buildCounterDatafeedstatusesCustomBatchResponse++;
  if (buildCounterDatafeedstatusesCustomBatchResponse < 3) {
    o.entries = buildUnnamed290();
    o.kind = "foo";
  }
  buildCounterDatafeedstatusesCustomBatchResponse--;
  return o;
}

checkDatafeedstatusesCustomBatchResponse(api.DatafeedstatusesCustomBatchResponse o) {
  buildCounterDatafeedstatusesCustomBatchResponse++;
  if (buildCounterDatafeedstatusesCustomBatchResponse < 3) {
    checkUnnamed290(o.entries);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterDatafeedstatusesCustomBatchResponse--;
}

core.int buildCounterDatafeedstatusesCustomBatchResponseEntry = 0;
buildDatafeedstatusesCustomBatchResponseEntry() {
  var o = new api.DatafeedstatusesCustomBatchResponseEntry();
  buildCounterDatafeedstatusesCustomBatchResponseEntry++;
  if (buildCounterDatafeedstatusesCustomBatchResponseEntry < 3) {
    o.batchId = 42;
    o.datafeedStatus = buildDatafeedStatus();
    o.errors = buildErrors();
  }
  buildCounterDatafeedstatusesCustomBatchResponseEntry--;
  return o;
}

checkDatafeedstatusesCustomBatchResponseEntry(api.DatafeedstatusesCustomBatchResponseEntry o) {
  buildCounterDatafeedstatusesCustomBatchResponseEntry++;
  if (buildCounterDatafeedstatusesCustomBatchResponseEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    checkDatafeedStatus(o.datafeedStatus);
    checkErrors(o.errors);
  }
  buildCounterDatafeedstatusesCustomBatchResponseEntry--;
}

buildUnnamed291() {
  var o = new core.List<api.DatafeedStatus>();
  o.add(buildDatafeedStatus());
  o.add(buildDatafeedStatus());
  return o;
}

checkUnnamed291(core.List<api.DatafeedStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDatafeedStatus(o[0]);
  checkDatafeedStatus(o[1]);
}

core.int buildCounterDatafeedstatusesListResponse = 0;
buildDatafeedstatusesListResponse() {
  var o = new api.DatafeedstatusesListResponse();
  buildCounterDatafeedstatusesListResponse++;
  if (buildCounterDatafeedstatusesListResponse < 3) {
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.resources = buildUnnamed291();
  }
  buildCounterDatafeedstatusesListResponse--;
  return o;
}

checkDatafeedstatusesListResponse(api.DatafeedstatusesListResponse o) {
  buildCounterDatafeedstatusesListResponse++;
  if (buildCounterDatafeedstatusesListResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed291(o.resources);
  }
  buildCounterDatafeedstatusesListResponse--;
}

core.int buildCounterDeliveryTime = 0;
buildDeliveryTime() {
  var o = new api.DeliveryTime();
  buildCounterDeliveryTime++;
  if (buildCounterDeliveryTime < 3) {
    o.maxTransitTimeInDays = 42;
    o.minTransitTimeInDays = 42;
  }
  buildCounterDeliveryTime--;
  return o;
}

checkDeliveryTime(api.DeliveryTime o) {
  buildCounterDeliveryTime++;
  if (buildCounterDeliveryTime < 3) {
    unittest.expect(o.maxTransitTimeInDays, unittest.equals(42));
    unittest.expect(o.minTransitTimeInDays, unittest.equals(42));
  }
  buildCounterDeliveryTime--;
}

core.int buildCounterError = 0;
buildError() {
  var o = new api.Error();
  buildCounterError++;
  if (buildCounterError < 3) {
    o.domain = "foo";
    o.message = "foo";
    o.reason = "foo";
  }
  buildCounterError--;
  return o;
}

checkError(api.Error o) {
  buildCounterError++;
  if (buildCounterError < 3) {
    unittest.expect(o.domain, unittest.equals('foo'));
    unittest.expect(o.message, unittest.equals('foo'));
    unittest.expect(o.reason, unittest.equals('foo'));
  }
  buildCounterError--;
}

buildUnnamed292() {
  var o = new core.List<api.Error>();
  o.add(buildError());
  o.add(buildError());
  return o;
}

checkUnnamed292(core.List<api.Error> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkError(o[0]);
  checkError(o[1]);
}

core.int buildCounterErrors = 0;
buildErrors() {
  var o = new api.Errors();
  buildCounterErrors++;
  if (buildCounterErrors < 3) {
    o.code = 42;
    o.errors = buildUnnamed292();
    o.message = "foo";
  }
  buildCounterErrors--;
  return o;
}

checkErrors(api.Errors o) {
  buildCounterErrors++;
  if (buildCounterErrors < 3) {
    unittest.expect(o.code, unittest.equals(42));
    checkUnnamed292(o.errors);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterErrors--;
}

buildUnnamed293() {
  var o = new core.List<api.LocationIdSet>();
  o.add(buildLocationIdSet());
  o.add(buildLocationIdSet());
  return o;
}

checkUnnamed293(core.List<api.LocationIdSet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLocationIdSet(o[0]);
  checkLocationIdSet(o[1]);
}

buildUnnamed294() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed294(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed295() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed295(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed296() {
  var o = new core.List<api.Price>();
  o.add(buildPrice());
  o.add(buildPrice());
  return o;
}

checkUnnamed296(core.List<api.Price> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPrice(o[0]);
  checkPrice(o[1]);
}

buildUnnamed297() {
  var o = new core.List<api.Weight>();
  o.add(buildWeight());
  o.add(buildWeight());
  return o;
}

checkUnnamed297(core.List<api.Weight> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWeight(o[0]);
  checkWeight(o[1]);
}

core.int buildCounterHeaders = 0;
buildHeaders() {
  var o = new api.Headers();
  buildCounterHeaders++;
  if (buildCounterHeaders < 3) {
    o.locations = buildUnnamed293();
    o.numberOfItems = buildUnnamed294();
    o.postalCodeGroupNames = buildUnnamed295();
    o.prices = buildUnnamed296();
    o.weights = buildUnnamed297();
  }
  buildCounterHeaders--;
  return o;
}

checkHeaders(api.Headers o) {
  buildCounterHeaders++;
  if (buildCounterHeaders < 3) {
    checkUnnamed293(o.locations);
    checkUnnamed294(o.numberOfItems);
    checkUnnamed295(o.postalCodeGroupNames);
    checkUnnamed296(o.prices);
    checkUnnamed297(o.weights);
  }
  buildCounterHeaders--;
}

core.int buildCounterInstallment = 0;
buildInstallment() {
  var o = new api.Installment();
  buildCounterInstallment++;
  if (buildCounterInstallment < 3) {
    o.amount = buildPrice();
    o.months = "foo";
  }
  buildCounterInstallment--;
  return o;
}

checkInstallment(api.Installment o) {
  buildCounterInstallment++;
  if (buildCounterInstallment < 3) {
    checkPrice(o.amount);
    unittest.expect(o.months, unittest.equals('foo'));
  }
  buildCounterInstallment--;
}

core.int buildCounterInventory = 0;
buildInventory() {
  var o = new api.Inventory();
  buildCounterInventory++;
  if (buildCounterInventory < 3) {
    o.availability = "foo";
    o.installment = buildInstallment();
    o.kind = "foo";
    o.loyaltyPoints = buildLoyaltyPoints();
    o.pickup = buildInventoryPickup();
    o.price = buildPrice();
    o.quantity = 42;
    o.salePrice = buildPrice();
    o.salePriceEffectiveDate = "foo";
    o.sellOnGoogleQuantity = 42;
  }
  buildCounterInventory--;
  return o;
}

checkInventory(api.Inventory o) {
  buildCounterInventory++;
  if (buildCounterInventory < 3) {
    unittest.expect(o.availability, unittest.equals('foo'));
    checkInstallment(o.installment);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkLoyaltyPoints(o.loyaltyPoints);
    checkInventoryPickup(o.pickup);
    checkPrice(o.price);
    unittest.expect(o.quantity, unittest.equals(42));
    checkPrice(o.salePrice);
    unittest.expect(o.salePriceEffectiveDate, unittest.equals('foo'));
    unittest.expect(o.sellOnGoogleQuantity, unittest.equals(42));
  }
  buildCounterInventory--;
}

buildUnnamed298() {
  var o = new core.List<api.InventoryCustomBatchRequestEntry>();
  o.add(buildInventoryCustomBatchRequestEntry());
  o.add(buildInventoryCustomBatchRequestEntry());
  return o;
}

checkUnnamed298(core.List<api.InventoryCustomBatchRequestEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkInventoryCustomBatchRequestEntry(o[0]);
  checkInventoryCustomBatchRequestEntry(o[1]);
}

core.int buildCounterInventoryCustomBatchRequest = 0;
buildInventoryCustomBatchRequest() {
  var o = new api.InventoryCustomBatchRequest();
  buildCounterInventoryCustomBatchRequest++;
  if (buildCounterInventoryCustomBatchRequest < 3) {
    o.entries = buildUnnamed298();
  }
  buildCounterInventoryCustomBatchRequest--;
  return o;
}

checkInventoryCustomBatchRequest(api.InventoryCustomBatchRequest o) {
  buildCounterInventoryCustomBatchRequest++;
  if (buildCounterInventoryCustomBatchRequest < 3) {
    checkUnnamed298(o.entries);
  }
  buildCounterInventoryCustomBatchRequest--;
}

core.int buildCounterInventoryCustomBatchRequestEntry = 0;
buildInventoryCustomBatchRequestEntry() {
  var o = new api.InventoryCustomBatchRequestEntry();
  buildCounterInventoryCustomBatchRequestEntry++;
  if (buildCounterInventoryCustomBatchRequestEntry < 3) {
    o.batchId = 42;
    o.inventory = buildInventory();
    o.merchantId = "foo";
    o.productId = "foo";
    o.storeCode = "foo";
  }
  buildCounterInventoryCustomBatchRequestEntry--;
  return o;
}

checkInventoryCustomBatchRequestEntry(api.InventoryCustomBatchRequestEntry o) {
  buildCounterInventoryCustomBatchRequestEntry++;
  if (buildCounterInventoryCustomBatchRequestEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    checkInventory(o.inventory);
    unittest.expect(o.merchantId, unittest.equals('foo'));
    unittest.expect(o.productId, unittest.equals('foo'));
    unittest.expect(o.storeCode, unittest.equals('foo'));
  }
  buildCounterInventoryCustomBatchRequestEntry--;
}

buildUnnamed299() {
  var o = new core.List<api.InventoryCustomBatchResponseEntry>();
  o.add(buildInventoryCustomBatchResponseEntry());
  o.add(buildInventoryCustomBatchResponseEntry());
  return o;
}

checkUnnamed299(core.List<api.InventoryCustomBatchResponseEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkInventoryCustomBatchResponseEntry(o[0]);
  checkInventoryCustomBatchResponseEntry(o[1]);
}

core.int buildCounterInventoryCustomBatchResponse = 0;
buildInventoryCustomBatchResponse() {
  var o = new api.InventoryCustomBatchResponse();
  buildCounterInventoryCustomBatchResponse++;
  if (buildCounterInventoryCustomBatchResponse < 3) {
    o.entries = buildUnnamed299();
    o.kind = "foo";
  }
  buildCounterInventoryCustomBatchResponse--;
  return o;
}

checkInventoryCustomBatchResponse(api.InventoryCustomBatchResponse o) {
  buildCounterInventoryCustomBatchResponse++;
  if (buildCounterInventoryCustomBatchResponse < 3) {
    checkUnnamed299(o.entries);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterInventoryCustomBatchResponse--;
}

core.int buildCounterInventoryCustomBatchResponseEntry = 0;
buildInventoryCustomBatchResponseEntry() {
  var o = new api.InventoryCustomBatchResponseEntry();
  buildCounterInventoryCustomBatchResponseEntry++;
  if (buildCounterInventoryCustomBatchResponseEntry < 3) {
    o.batchId = 42;
    o.errors = buildErrors();
    o.kind = "foo";
  }
  buildCounterInventoryCustomBatchResponseEntry--;
  return o;
}

checkInventoryCustomBatchResponseEntry(api.InventoryCustomBatchResponseEntry o) {
  buildCounterInventoryCustomBatchResponseEntry++;
  if (buildCounterInventoryCustomBatchResponseEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    checkErrors(o.errors);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterInventoryCustomBatchResponseEntry--;
}

core.int buildCounterInventoryPickup = 0;
buildInventoryPickup() {
  var o = new api.InventoryPickup();
  buildCounterInventoryPickup++;
  if (buildCounterInventoryPickup < 3) {
    o.pickupMethod = "foo";
    o.pickupSla = "foo";
  }
  buildCounterInventoryPickup--;
  return o;
}

checkInventoryPickup(api.InventoryPickup o) {
  buildCounterInventoryPickup++;
  if (buildCounterInventoryPickup < 3) {
    unittest.expect(o.pickupMethod, unittest.equals('foo'));
    unittest.expect(o.pickupSla, unittest.equals('foo'));
  }
  buildCounterInventoryPickup--;
}

core.int buildCounterInventorySetRequest = 0;
buildInventorySetRequest() {
  var o = new api.InventorySetRequest();
  buildCounterInventorySetRequest++;
  if (buildCounterInventorySetRequest < 3) {
    o.availability = "foo";
    o.installment = buildInstallment();
    o.loyaltyPoints = buildLoyaltyPoints();
    o.pickup = buildInventoryPickup();
    o.price = buildPrice();
    o.quantity = 42;
    o.salePrice = buildPrice();
    o.salePriceEffectiveDate = "foo";
    o.sellOnGoogleQuantity = 42;
  }
  buildCounterInventorySetRequest--;
  return o;
}

checkInventorySetRequest(api.InventorySetRequest o) {
  buildCounterInventorySetRequest++;
  if (buildCounterInventorySetRequest < 3) {
    unittest.expect(o.availability, unittest.equals('foo'));
    checkInstallment(o.installment);
    checkLoyaltyPoints(o.loyaltyPoints);
    checkInventoryPickup(o.pickup);
    checkPrice(o.price);
    unittest.expect(o.quantity, unittest.equals(42));
    checkPrice(o.salePrice);
    unittest.expect(o.salePriceEffectiveDate, unittest.equals('foo'));
    unittest.expect(o.sellOnGoogleQuantity, unittest.equals(42));
  }
  buildCounterInventorySetRequest--;
}

core.int buildCounterInventorySetResponse = 0;
buildInventorySetResponse() {
  var o = new api.InventorySetResponse();
  buildCounterInventorySetResponse++;
  if (buildCounterInventorySetResponse < 3) {
    o.kind = "foo";
  }
  buildCounterInventorySetResponse--;
  return o;
}

checkInventorySetResponse(api.InventorySetResponse o) {
  buildCounterInventorySetResponse++;
  if (buildCounterInventorySetResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterInventorySetResponse--;
}

buildUnnamed300() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed300(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterLocationIdSet = 0;
buildLocationIdSet() {
  var o = new api.LocationIdSet();
  buildCounterLocationIdSet++;
  if (buildCounterLocationIdSet < 3) {
    o.locationIds = buildUnnamed300();
  }
  buildCounterLocationIdSet--;
  return o;
}

checkLocationIdSet(api.LocationIdSet o) {
  buildCounterLocationIdSet++;
  if (buildCounterLocationIdSet < 3) {
    checkUnnamed300(o.locationIds);
  }
  buildCounterLocationIdSet--;
}

core.int buildCounterLoyaltyPoints = 0;
buildLoyaltyPoints() {
  var o = new api.LoyaltyPoints();
  buildCounterLoyaltyPoints++;
  if (buildCounterLoyaltyPoints < 3) {
    o.name = "foo";
    o.pointsValue = "foo";
    o.ratio = 42.0;
  }
  buildCounterLoyaltyPoints--;
  return o;
}

checkLoyaltyPoints(api.LoyaltyPoints o) {
  buildCounterLoyaltyPoints++;
  if (buildCounterLoyaltyPoints < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.pointsValue, unittest.equals('foo'));
    unittest.expect(o.ratio, unittest.equals(42.0));
  }
  buildCounterLoyaltyPoints--;
}

buildUnnamed301() {
  var o = new core.List<api.OrderLineItem>();
  o.add(buildOrderLineItem());
  o.add(buildOrderLineItem());
  return o;
}

checkUnnamed301(core.List<api.OrderLineItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderLineItem(o[0]);
  checkOrderLineItem(o[1]);
}

buildUnnamed302() {
  var o = new core.List<api.OrderPromotion>();
  o.add(buildOrderPromotion());
  o.add(buildOrderPromotion());
  return o;
}

checkUnnamed302(core.List<api.OrderPromotion> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderPromotion(o[0]);
  checkOrderPromotion(o[1]);
}

buildUnnamed303() {
  var o = new core.List<api.OrderRefund>();
  o.add(buildOrderRefund());
  o.add(buildOrderRefund());
  return o;
}

checkUnnamed303(core.List<api.OrderRefund> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderRefund(o[0]);
  checkOrderRefund(o[1]);
}

buildUnnamed304() {
  var o = new core.List<api.OrderShipment>();
  o.add(buildOrderShipment());
  o.add(buildOrderShipment());
  return o;
}

checkUnnamed304(core.List<api.OrderShipment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderShipment(o[0]);
  checkOrderShipment(o[1]);
}

core.int buildCounterOrder = 0;
buildOrder() {
  var o = new api.Order();
  buildCounterOrder++;
  if (buildCounterOrder < 3) {
    o.acknowledged = true;
    o.channelType = "foo";
    o.customer = buildOrderCustomer();
    o.deliveryDetails = buildOrderDeliveryDetails();
    o.id = "foo";
    o.kind = "foo";
    o.lineItems = buildUnnamed301();
    o.merchantId = "foo";
    o.merchantOrderId = "foo";
    o.netAmount = buildPrice();
    o.paymentMethod = buildOrderPaymentMethod();
    o.paymentStatus = "foo";
    o.placedDate = "foo";
    o.promotions = buildUnnamed302();
    o.refunds = buildUnnamed303();
    o.shipments = buildUnnamed304();
    o.shippingCost = buildPrice();
    o.shippingCostTax = buildPrice();
    o.shippingOption = "foo";
    o.status = "foo";
  }
  buildCounterOrder--;
  return o;
}

checkOrder(api.Order o) {
  buildCounterOrder++;
  if (buildCounterOrder < 3) {
    unittest.expect(o.acknowledged, unittest.isTrue);
    unittest.expect(o.channelType, unittest.equals('foo'));
    checkOrderCustomer(o.customer);
    checkOrderDeliveryDetails(o.deliveryDetails);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed301(o.lineItems);
    unittest.expect(o.merchantId, unittest.equals('foo'));
    unittest.expect(o.merchantOrderId, unittest.equals('foo'));
    checkPrice(o.netAmount);
    checkOrderPaymentMethod(o.paymentMethod);
    unittest.expect(o.paymentStatus, unittest.equals('foo'));
    unittest.expect(o.placedDate, unittest.equals('foo'));
    checkUnnamed302(o.promotions);
    checkUnnamed303(o.refunds);
    checkUnnamed304(o.shipments);
    checkPrice(o.shippingCost);
    checkPrice(o.shippingCostTax);
    unittest.expect(o.shippingOption, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterOrder--;
}

buildUnnamed305() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed305(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed306() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed306(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterOrderAddress = 0;
buildOrderAddress() {
  var o = new api.OrderAddress();
  buildCounterOrderAddress++;
  if (buildCounterOrderAddress < 3) {
    o.country = "foo";
    o.fullAddress = buildUnnamed305();
    o.isPostOfficeBox = true;
    o.locality = "foo";
    o.postalCode = "foo";
    o.recipientName = "foo";
    o.region = "foo";
    o.streetAddress = buildUnnamed306();
  }
  buildCounterOrderAddress--;
  return o;
}

checkOrderAddress(api.OrderAddress o) {
  buildCounterOrderAddress++;
  if (buildCounterOrderAddress < 3) {
    unittest.expect(o.country, unittest.equals('foo'));
    checkUnnamed305(o.fullAddress);
    unittest.expect(o.isPostOfficeBox, unittest.isTrue);
    unittest.expect(o.locality, unittest.equals('foo'));
    unittest.expect(o.postalCode, unittest.equals('foo'));
    unittest.expect(o.recipientName, unittest.equals('foo'));
    unittest.expect(o.region, unittest.equals('foo'));
    checkUnnamed306(o.streetAddress);
  }
  buildCounterOrderAddress--;
}

core.int buildCounterOrderCancellation = 0;
buildOrderCancellation() {
  var o = new api.OrderCancellation();
  buildCounterOrderCancellation++;
  if (buildCounterOrderCancellation < 3) {
    o.actor = "foo";
    o.creationDate = "foo";
    o.quantity = 42;
    o.reason = "foo";
    o.reasonText = "foo";
  }
  buildCounterOrderCancellation--;
  return o;
}

checkOrderCancellation(api.OrderCancellation o) {
  buildCounterOrderCancellation++;
  if (buildCounterOrderCancellation < 3) {
    unittest.expect(o.actor, unittest.equals('foo'));
    unittest.expect(o.creationDate, unittest.equals('foo'));
    unittest.expect(o.quantity, unittest.equals(42));
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.reasonText, unittest.equals('foo'));
  }
  buildCounterOrderCancellation--;
}

core.int buildCounterOrderCustomer = 0;
buildOrderCustomer() {
  var o = new api.OrderCustomer();
  buildCounterOrderCustomer++;
  if (buildCounterOrderCustomer < 3) {
    o.email = "foo";
    o.explicitMarketingPreference = true;
    o.fullName = "foo";
  }
  buildCounterOrderCustomer--;
  return o;
}

checkOrderCustomer(api.OrderCustomer o) {
  buildCounterOrderCustomer++;
  if (buildCounterOrderCustomer < 3) {
    unittest.expect(o.email, unittest.equals('foo'));
    unittest.expect(o.explicitMarketingPreference, unittest.isTrue);
    unittest.expect(o.fullName, unittest.equals('foo'));
  }
  buildCounterOrderCustomer--;
}

core.int buildCounterOrderDeliveryDetails = 0;
buildOrderDeliveryDetails() {
  var o = new api.OrderDeliveryDetails();
  buildCounterOrderDeliveryDetails++;
  if (buildCounterOrderDeliveryDetails < 3) {
    o.address = buildOrderAddress();
    o.phoneNumber = "foo";
  }
  buildCounterOrderDeliveryDetails--;
  return o;
}

checkOrderDeliveryDetails(api.OrderDeliveryDetails o) {
  buildCounterOrderDeliveryDetails++;
  if (buildCounterOrderDeliveryDetails < 3) {
    checkOrderAddress(o.address);
    unittest.expect(o.phoneNumber, unittest.equals('foo'));
  }
  buildCounterOrderDeliveryDetails--;
}

buildUnnamed307() {
  var o = new core.List<api.OrderCancellation>();
  o.add(buildOrderCancellation());
  o.add(buildOrderCancellation());
  return o;
}

checkUnnamed307(core.List<api.OrderCancellation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderCancellation(o[0]);
  checkOrderCancellation(o[1]);
}

buildUnnamed308() {
  var o = new core.List<api.OrderReturn>();
  o.add(buildOrderReturn());
  o.add(buildOrderReturn());
  return o;
}

checkUnnamed308(core.List<api.OrderReturn> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderReturn(o[0]);
  checkOrderReturn(o[1]);
}

core.int buildCounterOrderLineItem = 0;
buildOrderLineItem() {
  var o = new api.OrderLineItem();
  buildCounterOrderLineItem++;
  if (buildCounterOrderLineItem < 3) {
    o.cancellations = buildUnnamed307();
    o.id = "foo";
    o.price = buildPrice();
    o.product = buildOrderLineItemProduct();
    o.quantityCanceled = 42;
    o.quantityDelivered = 42;
    o.quantityOrdered = 42;
    o.quantityPending = 42;
    o.quantityReturned = 42;
    o.quantityShipped = 42;
    o.returnInfo = buildOrderLineItemReturnInfo();
    o.returns = buildUnnamed308();
    o.shippingDetails = buildOrderLineItemShippingDetails();
    o.tax = buildPrice();
  }
  buildCounterOrderLineItem--;
  return o;
}

checkOrderLineItem(api.OrderLineItem o) {
  buildCounterOrderLineItem++;
  if (buildCounterOrderLineItem < 3) {
    checkUnnamed307(o.cancellations);
    unittest.expect(o.id, unittest.equals('foo'));
    checkPrice(o.price);
    checkOrderLineItemProduct(o.product);
    unittest.expect(o.quantityCanceled, unittest.equals(42));
    unittest.expect(o.quantityDelivered, unittest.equals(42));
    unittest.expect(o.quantityOrdered, unittest.equals(42));
    unittest.expect(o.quantityPending, unittest.equals(42));
    unittest.expect(o.quantityReturned, unittest.equals(42));
    unittest.expect(o.quantityShipped, unittest.equals(42));
    checkOrderLineItemReturnInfo(o.returnInfo);
    checkUnnamed308(o.returns);
    checkOrderLineItemShippingDetails(o.shippingDetails);
    checkPrice(o.tax);
  }
  buildCounterOrderLineItem--;
}

buildUnnamed309() {
  var o = new core.List<api.OrderLineItemProductVariantAttribute>();
  o.add(buildOrderLineItemProductVariantAttribute());
  o.add(buildOrderLineItemProductVariantAttribute());
  return o;
}

checkUnnamed309(core.List<api.OrderLineItemProductVariantAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderLineItemProductVariantAttribute(o[0]);
  checkOrderLineItemProductVariantAttribute(o[1]);
}

core.int buildCounterOrderLineItemProduct = 0;
buildOrderLineItemProduct() {
  var o = new api.OrderLineItemProduct();
  buildCounterOrderLineItemProduct++;
  if (buildCounterOrderLineItemProduct < 3) {
    o.brand = "foo";
    o.channel = "foo";
    o.condition = "foo";
    o.contentLanguage = "foo";
    o.gtin = "foo";
    o.id = "foo";
    o.imageLink = "foo";
    o.itemGroupId = "foo";
    o.mpn = "foo";
    o.offerId = "foo";
    o.price = buildPrice();
    o.shownImage = "foo";
    o.targetCountry = "foo";
    o.title = "foo";
    o.variantAttributes = buildUnnamed309();
  }
  buildCounterOrderLineItemProduct--;
  return o;
}

checkOrderLineItemProduct(api.OrderLineItemProduct o) {
  buildCounterOrderLineItemProduct++;
  if (buildCounterOrderLineItemProduct < 3) {
    unittest.expect(o.brand, unittest.equals('foo'));
    unittest.expect(o.channel, unittest.equals('foo'));
    unittest.expect(o.condition, unittest.equals('foo'));
    unittest.expect(o.contentLanguage, unittest.equals('foo'));
    unittest.expect(o.gtin, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.imageLink, unittest.equals('foo'));
    unittest.expect(o.itemGroupId, unittest.equals('foo'));
    unittest.expect(o.mpn, unittest.equals('foo'));
    unittest.expect(o.offerId, unittest.equals('foo'));
    checkPrice(o.price);
    unittest.expect(o.shownImage, unittest.equals('foo'));
    unittest.expect(o.targetCountry, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    checkUnnamed309(o.variantAttributes);
  }
  buildCounterOrderLineItemProduct--;
}

core.int buildCounterOrderLineItemProductVariantAttribute = 0;
buildOrderLineItemProductVariantAttribute() {
  var o = new api.OrderLineItemProductVariantAttribute();
  buildCounterOrderLineItemProductVariantAttribute++;
  if (buildCounterOrderLineItemProductVariantAttribute < 3) {
    o.dimension = "foo";
    o.value = "foo";
  }
  buildCounterOrderLineItemProductVariantAttribute--;
  return o;
}

checkOrderLineItemProductVariantAttribute(api.OrderLineItemProductVariantAttribute o) {
  buildCounterOrderLineItemProductVariantAttribute++;
  if (buildCounterOrderLineItemProductVariantAttribute < 3) {
    unittest.expect(o.dimension, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterOrderLineItemProductVariantAttribute--;
}

core.int buildCounterOrderLineItemReturnInfo = 0;
buildOrderLineItemReturnInfo() {
  var o = new api.OrderLineItemReturnInfo();
  buildCounterOrderLineItemReturnInfo++;
  if (buildCounterOrderLineItemReturnInfo < 3) {
    o.daysToReturn = 42;
    o.isReturnable = true;
    o.policyUrl = "foo";
  }
  buildCounterOrderLineItemReturnInfo--;
  return o;
}

checkOrderLineItemReturnInfo(api.OrderLineItemReturnInfo o) {
  buildCounterOrderLineItemReturnInfo++;
  if (buildCounterOrderLineItemReturnInfo < 3) {
    unittest.expect(o.daysToReturn, unittest.equals(42));
    unittest.expect(o.isReturnable, unittest.isTrue);
    unittest.expect(o.policyUrl, unittest.equals('foo'));
  }
  buildCounterOrderLineItemReturnInfo--;
}

core.int buildCounterOrderLineItemShippingDetails = 0;
buildOrderLineItemShippingDetails() {
  var o = new api.OrderLineItemShippingDetails();
  buildCounterOrderLineItemShippingDetails++;
  if (buildCounterOrderLineItemShippingDetails < 3) {
    o.deliverByDate = "foo";
    o.method = buildOrderLineItemShippingDetailsMethod();
    o.shipByDate = "foo";
  }
  buildCounterOrderLineItemShippingDetails--;
  return o;
}

checkOrderLineItemShippingDetails(api.OrderLineItemShippingDetails o) {
  buildCounterOrderLineItemShippingDetails++;
  if (buildCounterOrderLineItemShippingDetails < 3) {
    unittest.expect(o.deliverByDate, unittest.equals('foo'));
    checkOrderLineItemShippingDetailsMethod(o.method);
    unittest.expect(o.shipByDate, unittest.equals('foo'));
  }
  buildCounterOrderLineItemShippingDetails--;
}

core.int buildCounterOrderLineItemShippingDetailsMethod = 0;
buildOrderLineItemShippingDetailsMethod() {
  var o = new api.OrderLineItemShippingDetailsMethod();
  buildCounterOrderLineItemShippingDetailsMethod++;
  if (buildCounterOrderLineItemShippingDetailsMethod < 3) {
    o.carrier = "foo";
    o.maxDaysInTransit = 42;
    o.methodName = "foo";
    o.minDaysInTransit = 42;
  }
  buildCounterOrderLineItemShippingDetailsMethod--;
  return o;
}

checkOrderLineItemShippingDetailsMethod(api.OrderLineItemShippingDetailsMethod o) {
  buildCounterOrderLineItemShippingDetailsMethod++;
  if (buildCounterOrderLineItemShippingDetailsMethod < 3) {
    unittest.expect(o.carrier, unittest.equals('foo'));
    unittest.expect(o.maxDaysInTransit, unittest.equals(42));
    unittest.expect(o.methodName, unittest.equals('foo'));
    unittest.expect(o.minDaysInTransit, unittest.equals(42));
  }
  buildCounterOrderLineItemShippingDetailsMethod--;
}

core.int buildCounterOrderPaymentMethod = 0;
buildOrderPaymentMethod() {
  var o = new api.OrderPaymentMethod();
  buildCounterOrderPaymentMethod++;
  if (buildCounterOrderPaymentMethod < 3) {
    o.billingAddress = buildOrderAddress();
    o.expirationMonth = 42;
    o.expirationYear = 42;
    o.lastFourDigits = "foo";
    o.phoneNumber = "foo";
    o.type = "foo";
  }
  buildCounterOrderPaymentMethod--;
  return o;
}

checkOrderPaymentMethod(api.OrderPaymentMethod o) {
  buildCounterOrderPaymentMethod++;
  if (buildCounterOrderPaymentMethod < 3) {
    checkOrderAddress(o.billingAddress);
    unittest.expect(o.expirationMonth, unittest.equals(42));
    unittest.expect(o.expirationYear, unittest.equals(42));
    unittest.expect(o.lastFourDigits, unittest.equals('foo'));
    unittest.expect(o.phoneNumber, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterOrderPaymentMethod--;
}

buildUnnamed310() {
  var o = new core.List<api.OrderPromotionBenefit>();
  o.add(buildOrderPromotionBenefit());
  o.add(buildOrderPromotionBenefit());
  return o;
}

checkUnnamed310(core.List<api.OrderPromotionBenefit> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderPromotionBenefit(o[0]);
  checkOrderPromotionBenefit(o[1]);
}

core.int buildCounterOrderPromotion = 0;
buildOrderPromotion() {
  var o = new api.OrderPromotion();
  buildCounterOrderPromotion++;
  if (buildCounterOrderPromotion < 3) {
    o.benefits = buildUnnamed310();
    o.effectiveDates = "foo";
    o.genericRedemptionCode = "foo";
    o.id = "foo";
    o.longTitle = "foo";
    o.productApplicability = "foo";
    o.redemptionChannel = "foo";
  }
  buildCounterOrderPromotion--;
  return o;
}

checkOrderPromotion(api.OrderPromotion o) {
  buildCounterOrderPromotion++;
  if (buildCounterOrderPromotion < 3) {
    checkUnnamed310(o.benefits);
    unittest.expect(o.effectiveDates, unittest.equals('foo'));
    unittest.expect(o.genericRedemptionCode, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.longTitle, unittest.equals('foo'));
    unittest.expect(o.productApplicability, unittest.equals('foo'));
    unittest.expect(o.redemptionChannel, unittest.equals('foo'));
  }
  buildCounterOrderPromotion--;
}

buildUnnamed311() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed311(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterOrderPromotionBenefit = 0;
buildOrderPromotionBenefit() {
  var o = new api.OrderPromotionBenefit();
  buildCounterOrderPromotionBenefit++;
  if (buildCounterOrderPromotionBenefit < 3) {
    o.discount = buildPrice();
    o.offerIds = buildUnnamed311();
    o.subType = "foo";
    o.taxImpact = buildPrice();
    o.type = "foo";
  }
  buildCounterOrderPromotionBenefit--;
  return o;
}

checkOrderPromotionBenefit(api.OrderPromotionBenefit o) {
  buildCounterOrderPromotionBenefit++;
  if (buildCounterOrderPromotionBenefit < 3) {
    checkPrice(o.discount);
    checkUnnamed311(o.offerIds);
    unittest.expect(o.subType, unittest.equals('foo'));
    checkPrice(o.taxImpact);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterOrderPromotionBenefit--;
}

core.int buildCounterOrderRefund = 0;
buildOrderRefund() {
  var o = new api.OrderRefund();
  buildCounterOrderRefund++;
  if (buildCounterOrderRefund < 3) {
    o.actor = "foo";
    o.amount = buildPrice();
    o.creationDate = "foo";
    o.reason = "foo";
    o.reasonText = "foo";
  }
  buildCounterOrderRefund--;
  return o;
}

checkOrderRefund(api.OrderRefund o) {
  buildCounterOrderRefund++;
  if (buildCounterOrderRefund < 3) {
    unittest.expect(o.actor, unittest.equals('foo'));
    checkPrice(o.amount);
    unittest.expect(o.creationDate, unittest.equals('foo'));
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.reasonText, unittest.equals('foo'));
  }
  buildCounterOrderRefund--;
}

core.int buildCounterOrderReturn = 0;
buildOrderReturn() {
  var o = new api.OrderReturn();
  buildCounterOrderReturn++;
  if (buildCounterOrderReturn < 3) {
    o.actor = "foo";
    o.creationDate = "foo";
    o.quantity = 42;
    o.reason = "foo";
    o.reasonText = "foo";
  }
  buildCounterOrderReturn--;
  return o;
}

checkOrderReturn(api.OrderReturn o) {
  buildCounterOrderReturn++;
  if (buildCounterOrderReturn < 3) {
    unittest.expect(o.actor, unittest.equals('foo'));
    unittest.expect(o.creationDate, unittest.equals('foo'));
    unittest.expect(o.quantity, unittest.equals(42));
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.reasonText, unittest.equals('foo'));
  }
  buildCounterOrderReturn--;
}

buildUnnamed312() {
  var o = new core.List<api.OrderShipmentLineItemShipment>();
  o.add(buildOrderShipmentLineItemShipment());
  o.add(buildOrderShipmentLineItemShipment());
  return o;
}

checkUnnamed312(core.List<api.OrderShipmentLineItemShipment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderShipmentLineItemShipment(o[0]);
  checkOrderShipmentLineItemShipment(o[1]);
}

core.int buildCounterOrderShipment = 0;
buildOrderShipment() {
  var o = new api.OrderShipment();
  buildCounterOrderShipment++;
  if (buildCounterOrderShipment < 3) {
    o.carrier = "foo";
    o.creationDate = "foo";
    o.deliveryDate = "foo";
    o.id = "foo";
    o.lineItems = buildUnnamed312();
    o.status = "foo";
    o.trackingId = "foo";
  }
  buildCounterOrderShipment--;
  return o;
}

checkOrderShipment(api.OrderShipment o) {
  buildCounterOrderShipment++;
  if (buildCounterOrderShipment < 3) {
    unittest.expect(o.carrier, unittest.equals('foo'));
    unittest.expect(o.creationDate, unittest.equals('foo'));
    unittest.expect(o.deliveryDate, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed312(o.lineItems);
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.trackingId, unittest.equals('foo'));
  }
  buildCounterOrderShipment--;
}

core.int buildCounterOrderShipmentLineItemShipment = 0;
buildOrderShipmentLineItemShipment() {
  var o = new api.OrderShipmentLineItemShipment();
  buildCounterOrderShipmentLineItemShipment++;
  if (buildCounterOrderShipmentLineItemShipment < 3) {
    o.lineItemId = "foo";
    o.quantity = 42;
  }
  buildCounterOrderShipmentLineItemShipment--;
  return o;
}

checkOrderShipmentLineItemShipment(api.OrderShipmentLineItemShipment o) {
  buildCounterOrderShipmentLineItemShipment++;
  if (buildCounterOrderShipmentLineItemShipment < 3) {
    unittest.expect(o.lineItemId, unittest.equals('foo'));
    unittest.expect(o.quantity, unittest.equals(42));
  }
  buildCounterOrderShipmentLineItemShipment--;
}

core.int buildCounterOrdersAcknowledgeRequest = 0;
buildOrdersAcknowledgeRequest() {
  var o = new api.OrdersAcknowledgeRequest();
  buildCounterOrdersAcknowledgeRequest++;
  if (buildCounterOrdersAcknowledgeRequest < 3) {
    o.operationId = "foo";
  }
  buildCounterOrdersAcknowledgeRequest--;
  return o;
}

checkOrdersAcknowledgeRequest(api.OrdersAcknowledgeRequest o) {
  buildCounterOrdersAcknowledgeRequest++;
  if (buildCounterOrdersAcknowledgeRequest < 3) {
    unittest.expect(o.operationId, unittest.equals('foo'));
  }
  buildCounterOrdersAcknowledgeRequest--;
}

core.int buildCounterOrdersAcknowledgeResponse = 0;
buildOrdersAcknowledgeResponse() {
  var o = new api.OrdersAcknowledgeResponse();
  buildCounterOrdersAcknowledgeResponse++;
  if (buildCounterOrdersAcknowledgeResponse < 3) {
    o.executionStatus = "foo";
    o.kind = "foo";
  }
  buildCounterOrdersAcknowledgeResponse--;
  return o;
}

checkOrdersAcknowledgeResponse(api.OrdersAcknowledgeResponse o) {
  buildCounterOrdersAcknowledgeResponse++;
  if (buildCounterOrdersAcknowledgeResponse < 3) {
    unittest.expect(o.executionStatus, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOrdersAcknowledgeResponse--;
}

core.int buildCounterOrdersAdvanceTestOrderResponse = 0;
buildOrdersAdvanceTestOrderResponse() {
  var o = new api.OrdersAdvanceTestOrderResponse();
  buildCounterOrdersAdvanceTestOrderResponse++;
  if (buildCounterOrdersAdvanceTestOrderResponse < 3) {
    o.kind = "foo";
  }
  buildCounterOrdersAdvanceTestOrderResponse--;
  return o;
}

checkOrdersAdvanceTestOrderResponse(api.OrdersAdvanceTestOrderResponse o) {
  buildCounterOrdersAdvanceTestOrderResponse++;
  if (buildCounterOrdersAdvanceTestOrderResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOrdersAdvanceTestOrderResponse--;
}

core.int buildCounterOrdersCancelLineItemRequest = 0;
buildOrdersCancelLineItemRequest() {
  var o = new api.OrdersCancelLineItemRequest();
  buildCounterOrdersCancelLineItemRequest++;
  if (buildCounterOrdersCancelLineItemRequest < 3) {
    o.amount = buildPrice();
    o.lineItemId = "foo";
    o.operationId = "foo";
    o.quantity = 42;
    o.reason = "foo";
    o.reasonText = "foo";
  }
  buildCounterOrdersCancelLineItemRequest--;
  return o;
}

checkOrdersCancelLineItemRequest(api.OrdersCancelLineItemRequest o) {
  buildCounterOrdersCancelLineItemRequest++;
  if (buildCounterOrdersCancelLineItemRequest < 3) {
    checkPrice(o.amount);
    unittest.expect(o.lineItemId, unittest.equals('foo'));
    unittest.expect(o.operationId, unittest.equals('foo'));
    unittest.expect(o.quantity, unittest.equals(42));
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.reasonText, unittest.equals('foo'));
  }
  buildCounterOrdersCancelLineItemRequest--;
}

core.int buildCounterOrdersCancelLineItemResponse = 0;
buildOrdersCancelLineItemResponse() {
  var o = new api.OrdersCancelLineItemResponse();
  buildCounterOrdersCancelLineItemResponse++;
  if (buildCounterOrdersCancelLineItemResponse < 3) {
    o.executionStatus = "foo";
    o.kind = "foo";
  }
  buildCounterOrdersCancelLineItemResponse--;
  return o;
}

checkOrdersCancelLineItemResponse(api.OrdersCancelLineItemResponse o) {
  buildCounterOrdersCancelLineItemResponse++;
  if (buildCounterOrdersCancelLineItemResponse < 3) {
    unittest.expect(o.executionStatus, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOrdersCancelLineItemResponse--;
}

core.int buildCounterOrdersCancelRequest = 0;
buildOrdersCancelRequest() {
  var o = new api.OrdersCancelRequest();
  buildCounterOrdersCancelRequest++;
  if (buildCounterOrdersCancelRequest < 3) {
    o.operationId = "foo";
    o.reason = "foo";
    o.reasonText = "foo";
  }
  buildCounterOrdersCancelRequest--;
  return o;
}

checkOrdersCancelRequest(api.OrdersCancelRequest o) {
  buildCounterOrdersCancelRequest++;
  if (buildCounterOrdersCancelRequest < 3) {
    unittest.expect(o.operationId, unittest.equals('foo'));
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.reasonText, unittest.equals('foo'));
  }
  buildCounterOrdersCancelRequest--;
}

core.int buildCounterOrdersCancelResponse = 0;
buildOrdersCancelResponse() {
  var o = new api.OrdersCancelResponse();
  buildCounterOrdersCancelResponse++;
  if (buildCounterOrdersCancelResponse < 3) {
    o.executionStatus = "foo";
    o.kind = "foo";
  }
  buildCounterOrdersCancelResponse--;
  return o;
}

checkOrdersCancelResponse(api.OrdersCancelResponse o) {
  buildCounterOrdersCancelResponse++;
  if (buildCounterOrdersCancelResponse < 3) {
    unittest.expect(o.executionStatus, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOrdersCancelResponse--;
}

core.int buildCounterOrdersCreateTestOrderRequest = 0;
buildOrdersCreateTestOrderRequest() {
  var o = new api.OrdersCreateTestOrderRequest();
  buildCounterOrdersCreateTestOrderRequest++;
  if (buildCounterOrdersCreateTestOrderRequest < 3) {
    o.templateName = "foo";
    o.testOrder = buildTestOrder();
  }
  buildCounterOrdersCreateTestOrderRequest--;
  return o;
}

checkOrdersCreateTestOrderRequest(api.OrdersCreateTestOrderRequest o) {
  buildCounterOrdersCreateTestOrderRequest++;
  if (buildCounterOrdersCreateTestOrderRequest < 3) {
    unittest.expect(o.templateName, unittest.equals('foo'));
    checkTestOrder(o.testOrder);
  }
  buildCounterOrdersCreateTestOrderRequest--;
}

core.int buildCounterOrdersCreateTestOrderResponse = 0;
buildOrdersCreateTestOrderResponse() {
  var o = new api.OrdersCreateTestOrderResponse();
  buildCounterOrdersCreateTestOrderResponse++;
  if (buildCounterOrdersCreateTestOrderResponse < 3) {
    o.kind = "foo";
    o.orderId = "foo";
  }
  buildCounterOrdersCreateTestOrderResponse--;
  return o;
}

checkOrdersCreateTestOrderResponse(api.OrdersCreateTestOrderResponse o) {
  buildCounterOrdersCreateTestOrderResponse++;
  if (buildCounterOrdersCreateTestOrderResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.orderId, unittest.equals('foo'));
  }
  buildCounterOrdersCreateTestOrderResponse--;
}

buildUnnamed313() {
  var o = new core.List<api.OrdersCustomBatchRequestEntry>();
  o.add(buildOrdersCustomBatchRequestEntry());
  o.add(buildOrdersCustomBatchRequestEntry());
  return o;
}

checkUnnamed313(core.List<api.OrdersCustomBatchRequestEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrdersCustomBatchRequestEntry(o[0]);
  checkOrdersCustomBatchRequestEntry(o[1]);
}

core.int buildCounterOrdersCustomBatchRequest = 0;
buildOrdersCustomBatchRequest() {
  var o = new api.OrdersCustomBatchRequest();
  buildCounterOrdersCustomBatchRequest++;
  if (buildCounterOrdersCustomBatchRequest < 3) {
    o.entries = buildUnnamed313();
  }
  buildCounterOrdersCustomBatchRequest--;
  return o;
}

checkOrdersCustomBatchRequest(api.OrdersCustomBatchRequest o) {
  buildCounterOrdersCustomBatchRequest++;
  if (buildCounterOrdersCustomBatchRequest < 3) {
    checkUnnamed313(o.entries);
  }
  buildCounterOrdersCustomBatchRequest--;
}

core.int buildCounterOrdersCustomBatchRequestEntry = 0;
buildOrdersCustomBatchRequestEntry() {
  var o = new api.OrdersCustomBatchRequestEntry();
  buildCounterOrdersCustomBatchRequestEntry++;
  if (buildCounterOrdersCustomBatchRequestEntry < 3) {
    o.batchId = 42;
    o.cancel = buildOrdersCustomBatchRequestEntryCancel();
    o.cancelLineItem = buildOrdersCustomBatchRequestEntryCancelLineItem();
    o.merchantId = "foo";
    o.merchantOrderId = "foo";
    o.method = "foo";
    o.operationId = "foo";
    o.orderId = "foo";
    o.refund = buildOrdersCustomBatchRequestEntryRefund();
    o.returnLineItem = buildOrdersCustomBatchRequestEntryReturnLineItem();
    o.shipLineItems = buildOrdersCustomBatchRequestEntryShipLineItems();
    o.updateShipment = buildOrdersCustomBatchRequestEntryUpdateShipment();
  }
  buildCounterOrdersCustomBatchRequestEntry--;
  return o;
}

checkOrdersCustomBatchRequestEntry(api.OrdersCustomBatchRequestEntry o) {
  buildCounterOrdersCustomBatchRequestEntry++;
  if (buildCounterOrdersCustomBatchRequestEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    checkOrdersCustomBatchRequestEntryCancel(o.cancel);
    checkOrdersCustomBatchRequestEntryCancelLineItem(o.cancelLineItem);
    unittest.expect(o.merchantId, unittest.equals('foo'));
    unittest.expect(o.merchantOrderId, unittest.equals('foo'));
    unittest.expect(o.method, unittest.equals('foo'));
    unittest.expect(o.operationId, unittest.equals('foo'));
    unittest.expect(o.orderId, unittest.equals('foo'));
    checkOrdersCustomBatchRequestEntryRefund(o.refund);
    checkOrdersCustomBatchRequestEntryReturnLineItem(o.returnLineItem);
    checkOrdersCustomBatchRequestEntryShipLineItems(o.shipLineItems);
    checkOrdersCustomBatchRequestEntryUpdateShipment(o.updateShipment);
  }
  buildCounterOrdersCustomBatchRequestEntry--;
}

core.int buildCounterOrdersCustomBatchRequestEntryCancel = 0;
buildOrdersCustomBatchRequestEntryCancel() {
  var o = new api.OrdersCustomBatchRequestEntryCancel();
  buildCounterOrdersCustomBatchRequestEntryCancel++;
  if (buildCounterOrdersCustomBatchRequestEntryCancel < 3) {
    o.reason = "foo";
    o.reasonText = "foo";
  }
  buildCounterOrdersCustomBatchRequestEntryCancel--;
  return o;
}

checkOrdersCustomBatchRequestEntryCancel(api.OrdersCustomBatchRequestEntryCancel o) {
  buildCounterOrdersCustomBatchRequestEntryCancel++;
  if (buildCounterOrdersCustomBatchRequestEntryCancel < 3) {
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.reasonText, unittest.equals('foo'));
  }
  buildCounterOrdersCustomBatchRequestEntryCancel--;
}

core.int buildCounterOrdersCustomBatchRequestEntryCancelLineItem = 0;
buildOrdersCustomBatchRequestEntryCancelLineItem() {
  var o = new api.OrdersCustomBatchRequestEntryCancelLineItem();
  buildCounterOrdersCustomBatchRequestEntryCancelLineItem++;
  if (buildCounterOrdersCustomBatchRequestEntryCancelLineItem < 3) {
    o.amount = buildPrice();
    o.lineItemId = "foo";
    o.quantity = 42;
    o.reason = "foo";
    o.reasonText = "foo";
  }
  buildCounterOrdersCustomBatchRequestEntryCancelLineItem--;
  return o;
}

checkOrdersCustomBatchRequestEntryCancelLineItem(api.OrdersCustomBatchRequestEntryCancelLineItem o) {
  buildCounterOrdersCustomBatchRequestEntryCancelLineItem++;
  if (buildCounterOrdersCustomBatchRequestEntryCancelLineItem < 3) {
    checkPrice(o.amount);
    unittest.expect(o.lineItemId, unittest.equals('foo'));
    unittest.expect(o.quantity, unittest.equals(42));
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.reasonText, unittest.equals('foo'));
  }
  buildCounterOrdersCustomBatchRequestEntryCancelLineItem--;
}

core.int buildCounterOrdersCustomBatchRequestEntryRefund = 0;
buildOrdersCustomBatchRequestEntryRefund() {
  var o = new api.OrdersCustomBatchRequestEntryRefund();
  buildCounterOrdersCustomBatchRequestEntryRefund++;
  if (buildCounterOrdersCustomBatchRequestEntryRefund < 3) {
    o.amount = buildPrice();
    o.reason = "foo";
    o.reasonText = "foo";
  }
  buildCounterOrdersCustomBatchRequestEntryRefund--;
  return o;
}

checkOrdersCustomBatchRequestEntryRefund(api.OrdersCustomBatchRequestEntryRefund o) {
  buildCounterOrdersCustomBatchRequestEntryRefund++;
  if (buildCounterOrdersCustomBatchRequestEntryRefund < 3) {
    checkPrice(o.amount);
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.reasonText, unittest.equals('foo'));
  }
  buildCounterOrdersCustomBatchRequestEntryRefund--;
}

core.int buildCounterOrdersCustomBatchRequestEntryReturnLineItem = 0;
buildOrdersCustomBatchRequestEntryReturnLineItem() {
  var o = new api.OrdersCustomBatchRequestEntryReturnLineItem();
  buildCounterOrdersCustomBatchRequestEntryReturnLineItem++;
  if (buildCounterOrdersCustomBatchRequestEntryReturnLineItem < 3) {
    o.lineItemId = "foo";
    o.quantity = 42;
    o.reason = "foo";
    o.reasonText = "foo";
  }
  buildCounterOrdersCustomBatchRequestEntryReturnLineItem--;
  return o;
}

checkOrdersCustomBatchRequestEntryReturnLineItem(api.OrdersCustomBatchRequestEntryReturnLineItem o) {
  buildCounterOrdersCustomBatchRequestEntryReturnLineItem++;
  if (buildCounterOrdersCustomBatchRequestEntryReturnLineItem < 3) {
    unittest.expect(o.lineItemId, unittest.equals('foo'));
    unittest.expect(o.quantity, unittest.equals(42));
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.reasonText, unittest.equals('foo'));
  }
  buildCounterOrdersCustomBatchRequestEntryReturnLineItem--;
}

buildUnnamed314() {
  var o = new core.List<api.OrderShipmentLineItemShipment>();
  o.add(buildOrderShipmentLineItemShipment());
  o.add(buildOrderShipmentLineItemShipment());
  return o;
}

checkUnnamed314(core.List<api.OrderShipmentLineItemShipment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderShipmentLineItemShipment(o[0]);
  checkOrderShipmentLineItemShipment(o[1]);
}

core.int buildCounterOrdersCustomBatchRequestEntryShipLineItems = 0;
buildOrdersCustomBatchRequestEntryShipLineItems() {
  var o = new api.OrdersCustomBatchRequestEntryShipLineItems();
  buildCounterOrdersCustomBatchRequestEntryShipLineItems++;
  if (buildCounterOrdersCustomBatchRequestEntryShipLineItems < 3) {
    o.carrier = "foo";
    o.lineItems = buildUnnamed314();
    o.shipmentId = "foo";
    o.trackingId = "foo";
  }
  buildCounterOrdersCustomBatchRequestEntryShipLineItems--;
  return o;
}

checkOrdersCustomBatchRequestEntryShipLineItems(api.OrdersCustomBatchRequestEntryShipLineItems o) {
  buildCounterOrdersCustomBatchRequestEntryShipLineItems++;
  if (buildCounterOrdersCustomBatchRequestEntryShipLineItems < 3) {
    unittest.expect(o.carrier, unittest.equals('foo'));
    checkUnnamed314(o.lineItems);
    unittest.expect(o.shipmentId, unittest.equals('foo'));
    unittest.expect(o.trackingId, unittest.equals('foo'));
  }
  buildCounterOrdersCustomBatchRequestEntryShipLineItems--;
}

core.int buildCounterOrdersCustomBatchRequestEntryUpdateShipment = 0;
buildOrdersCustomBatchRequestEntryUpdateShipment() {
  var o = new api.OrdersCustomBatchRequestEntryUpdateShipment();
  buildCounterOrdersCustomBatchRequestEntryUpdateShipment++;
  if (buildCounterOrdersCustomBatchRequestEntryUpdateShipment < 3) {
    o.carrier = "foo";
    o.shipmentId = "foo";
    o.status = "foo";
    o.trackingId = "foo";
  }
  buildCounterOrdersCustomBatchRequestEntryUpdateShipment--;
  return o;
}

checkOrdersCustomBatchRequestEntryUpdateShipment(api.OrdersCustomBatchRequestEntryUpdateShipment o) {
  buildCounterOrdersCustomBatchRequestEntryUpdateShipment++;
  if (buildCounterOrdersCustomBatchRequestEntryUpdateShipment < 3) {
    unittest.expect(o.carrier, unittest.equals('foo'));
    unittest.expect(o.shipmentId, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.trackingId, unittest.equals('foo'));
  }
  buildCounterOrdersCustomBatchRequestEntryUpdateShipment--;
}

buildUnnamed315() {
  var o = new core.List<api.OrdersCustomBatchResponseEntry>();
  o.add(buildOrdersCustomBatchResponseEntry());
  o.add(buildOrdersCustomBatchResponseEntry());
  return o;
}

checkUnnamed315(core.List<api.OrdersCustomBatchResponseEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrdersCustomBatchResponseEntry(o[0]);
  checkOrdersCustomBatchResponseEntry(o[1]);
}

core.int buildCounterOrdersCustomBatchResponse = 0;
buildOrdersCustomBatchResponse() {
  var o = new api.OrdersCustomBatchResponse();
  buildCounterOrdersCustomBatchResponse++;
  if (buildCounterOrdersCustomBatchResponse < 3) {
    o.entries = buildUnnamed315();
    o.kind = "foo";
  }
  buildCounterOrdersCustomBatchResponse--;
  return o;
}

checkOrdersCustomBatchResponse(api.OrdersCustomBatchResponse o) {
  buildCounterOrdersCustomBatchResponse++;
  if (buildCounterOrdersCustomBatchResponse < 3) {
    checkUnnamed315(o.entries);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOrdersCustomBatchResponse--;
}

core.int buildCounterOrdersCustomBatchResponseEntry = 0;
buildOrdersCustomBatchResponseEntry() {
  var o = new api.OrdersCustomBatchResponseEntry();
  buildCounterOrdersCustomBatchResponseEntry++;
  if (buildCounterOrdersCustomBatchResponseEntry < 3) {
    o.batchId = 42;
    o.errors = buildErrors();
    o.executionStatus = "foo";
    o.kind = "foo";
    o.order = buildOrder();
  }
  buildCounterOrdersCustomBatchResponseEntry--;
  return o;
}

checkOrdersCustomBatchResponseEntry(api.OrdersCustomBatchResponseEntry o) {
  buildCounterOrdersCustomBatchResponseEntry++;
  if (buildCounterOrdersCustomBatchResponseEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    checkErrors(o.errors);
    unittest.expect(o.executionStatus, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkOrder(o.order);
  }
  buildCounterOrdersCustomBatchResponseEntry--;
}

core.int buildCounterOrdersGetByMerchantOrderIdResponse = 0;
buildOrdersGetByMerchantOrderIdResponse() {
  var o = new api.OrdersGetByMerchantOrderIdResponse();
  buildCounterOrdersGetByMerchantOrderIdResponse++;
  if (buildCounterOrdersGetByMerchantOrderIdResponse < 3) {
    o.kind = "foo";
    o.order = buildOrder();
  }
  buildCounterOrdersGetByMerchantOrderIdResponse--;
  return o;
}

checkOrdersGetByMerchantOrderIdResponse(api.OrdersGetByMerchantOrderIdResponse o) {
  buildCounterOrdersGetByMerchantOrderIdResponse++;
  if (buildCounterOrdersGetByMerchantOrderIdResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkOrder(o.order);
  }
  buildCounterOrdersGetByMerchantOrderIdResponse--;
}

core.int buildCounterOrdersGetTestOrderTemplateResponse = 0;
buildOrdersGetTestOrderTemplateResponse() {
  var o = new api.OrdersGetTestOrderTemplateResponse();
  buildCounterOrdersGetTestOrderTemplateResponse++;
  if (buildCounterOrdersGetTestOrderTemplateResponse < 3) {
    o.kind = "foo";
    o.template = buildTestOrder();
  }
  buildCounterOrdersGetTestOrderTemplateResponse--;
  return o;
}

checkOrdersGetTestOrderTemplateResponse(api.OrdersGetTestOrderTemplateResponse o) {
  buildCounterOrdersGetTestOrderTemplateResponse++;
  if (buildCounterOrdersGetTestOrderTemplateResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkTestOrder(o.template);
  }
  buildCounterOrdersGetTestOrderTemplateResponse--;
}

buildUnnamed316() {
  var o = new core.List<api.Order>();
  o.add(buildOrder());
  o.add(buildOrder());
  return o;
}

checkUnnamed316(core.List<api.Order> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrder(o[0]);
  checkOrder(o[1]);
}

core.int buildCounterOrdersListResponse = 0;
buildOrdersListResponse() {
  var o = new api.OrdersListResponse();
  buildCounterOrdersListResponse++;
  if (buildCounterOrdersListResponse < 3) {
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.resources = buildUnnamed316();
  }
  buildCounterOrdersListResponse--;
  return o;
}

checkOrdersListResponse(api.OrdersListResponse o) {
  buildCounterOrdersListResponse++;
  if (buildCounterOrdersListResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed316(o.resources);
  }
  buildCounterOrdersListResponse--;
}

core.int buildCounterOrdersRefundRequest = 0;
buildOrdersRefundRequest() {
  var o = new api.OrdersRefundRequest();
  buildCounterOrdersRefundRequest++;
  if (buildCounterOrdersRefundRequest < 3) {
    o.amount = buildPrice();
    o.operationId = "foo";
    o.reason = "foo";
    o.reasonText = "foo";
  }
  buildCounterOrdersRefundRequest--;
  return o;
}

checkOrdersRefundRequest(api.OrdersRefundRequest o) {
  buildCounterOrdersRefundRequest++;
  if (buildCounterOrdersRefundRequest < 3) {
    checkPrice(o.amount);
    unittest.expect(o.operationId, unittest.equals('foo'));
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.reasonText, unittest.equals('foo'));
  }
  buildCounterOrdersRefundRequest--;
}

core.int buildCounterOrdersRefundResponse = 0;
buildOrdersRefundResponse() {
  var o = new api.OrdersRefundResponse();
  buildCounterOrdersRefundResponse++;
  if (buildCounterOrdersRefundResponse < 3) {
    o.executionStatus = "foo";
    o.kind = "foo";
  }
  buildCounterOrdersRefundResponse--;
  return o;
}

checkOrdersRefundResponse(api.OrdersRefundResponse o) {
  buildCounterOrdersRefundResponse++;
  if (buildCounterOrdersRefundResponse < 3) {
    unittest.expect(o.executionStatus, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOrdersRefundResponse--;
}

core.int buildCounterOrdersReturnLineItemRequest = 0;
buildOrdersReturnLineItemRequest() {
  var o = new api.OrdersReturnLineItemRequest();
  buildCounterOrdersReturnLineItemRequest++;
  if (buildCounterOrdersReturnLineItemRequest < 3) {
    o.lineItemId = "foo";
    o.operationId = "foo";
    o.quantity = 42;
    o.reason = "foo";
    o.reasonText = "foo";
  }
  buildCounterOrdersReturnLineItemRequest--;
  return o;
}

checkOrdersReturnLineItemRequest(api.OrdersReturnLineItemRequest o) {
  buildCounterOrdersReturnLineItemRequest++;
  if (buildCounterOrdersReturnLineItemRequest < 3) {
    unittest.expect(o.lineItemId, unittest.equals('foo'));
    unittest.expect(o.operationId, unittest.equals('foo'));
    unittest.expect(o.quantity, unittest.equals(42));
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.reasonText, unittest.equals('foo'));
  }
  buildCounterOrdersReturnLineItemRequest--;
}

core.int buildCounterOrdersReturnLineItemResponse = 0;
buildOrdersReturnLineItemResponse() {
  var o = new api.OrdersReturnLineItemResponse();
  buildCounterOrdersReturnLineItemResponse++;
  if (buildCounterOrdersReturnLineItemResponse < 3) {
    o.executionStatus = "foo";
    o.kind = "foo";
  }
  buildCounterOrdersReturnLineItemResponse--;
  return o;
}

checkOrdersReturnLineItemResponse(api.OrdersReturnLineItemResponse o) {
  buildCounterOrdersReturnLineItemResponse++;
  if (buildCounterOrdersReturnLineItemResponse < 3) {
    unittest.expect(o.executionStatus, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOrdersReturnLineItemResponse--;
}

buildUnnamed317() {
  var o = new core.List<api.OrderShipmentLineItemShipment>();
  o.add(buildOrderShipmentLineItemShipment());
  o.add(buildOrderShipmentLineItemShipment());
  return o;
}

checkUnnamed317(core.List<api.OrderShipmentLineItemShipment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderShipmentLineItemShipment(o[0]);
  checkOrderShipmentLineItemShipment(o[1]);
}

core.int buildCounterOrdersShipLineItemsRequest = 0;
buildOrdersShipLineItemsRequest() {
  var o = new api.OrdersShipLineItemsRequest();
  buildCounterOrdersShipLineItemsRequest++;
  if (buildCounterOrdersShipLineItemsRequest < 3) {
    o.carrier = "foo";
    o.lineItems = buildUnnamed317();
    o.operationId = "foo";
    o.shipmentId = "foo";
    o.trackingId = "foo";
  }
  buildCounterOrdersShipLineItemsRequest--;
  return o;
}

checkOrdersShipLineItemsRequest(api.OrdersShipLineItemsRequest o) {
  buildCounterOrdersShipLineItemsRequest++;
  if (buildCounterOrdersShipLineItemsRequest < 3) {
    unittest.expect(o.carrier, unittest.equals('foo'));
    checkUnnamed317(o.lineItems);
    unittest.expect(o.operationId, unittest.equals('foo'));
    unittest.expect(o.shipmentId, unittest.equals('foo'));
    unittest.expect(o.trackingId, unittest.equals('foo'));
  }
  buildCounterOrdersShipLineItemsRequest--;
}

core.int buildCounterOrdersShipLineItemsResponse = 0;
buildOrdersShipLineItemsResponse() {
  var o = new api.OrdersShipLineItemsResponse();
  buildCounterOrdersShipLineItemsResponse++;
  if (buildCounterOrdersShipLineItemsResponse < 3) {
    o.executionStatus = "foo";
    o.kind = "foo";
  }
  buildCounterOrdersShipLineItemsResponse--;
  return o;
}

checkOrdersShipLineItemsResponse(api.OrdersShipLineItemsResponse o) {
  buildCounterOrdersShipLineItemsResponse++;
  if (buildCounterOrdersShipLineItemsResponse < 3) {
    unittest.expect(o.executionStatus, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOrdersShipLineItemsResponse--;
}

core.int buildCounterOrdersUpdateMerchantOrderIdRequest = 0;
buildOrdersUpdateMerchantOrderIdRequest() {
  var o = new api.OrdersUpdateMerchantOrderIdRequest();
  buildCounterOrdersUpdateMerchantOrderIdRequest++;
  if (buildCounterOrdersUpdateMerchantOrderIdRequest < 3) {
    o.merchantOrderId = "foo";
    o.operationId = "foo";
  }
  buildCounterOrdersUpdateMerchantOrderIdRequest--;
  return o;
}

checkOrdersUpdateMerchantOrderIdRequest(api.OrdersUpdateMerchantOrderIdRequest o) {
  buildCounterOrdersUpdateMerchantOrderIdRequest++;
  if (buildCounterOrdersUpdateMerchantOrderIdRequest < 3) {
    unittest.expect(o.merchantOrderId, unittest.equals('foo'));
    unittest.expect(o.operationId, unittest.equals('foo'));
  }
  buildCounterOrdersUpdateMerchantOrderIdRequest--;
}

core.int buildCounterOrdersUpdateMerchantOrderIdResponse = 0;
buildOrdersUpdateMerchantOrderIdResponse() {
  var o = new api.OrdersUpdateMerchantOrderIdResponse();
  buildCounterOrdersUpdateMerchantOrderIdResponse++;
  if (buildCounterOrdersUpdateMerchantOrderIdResponse < 3) {
    o.executionStatus = "foo";
    o.kind = "foo";
  }
  buildCounterOrdersUpdateMerchantOrderIdResponse--;
  return o;
}

checkOrdersUpdateMerchantOrderIdResponse(api.OrdersUpdateMerchantOrderIdResponse o) {
  buildCounterOrdersUpdateMerchantOrderIdResponse++;
  if (buildCounterOrdersUpdateMerchantOrderIdResponse < 3) {
    unittest.expect(o.executionStatus, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOrdersUpdateMerchantOrderIdResponse--;
}

core.int buildCounterOrdersUpdateShipmentRequest = 0;
buildOrdersUpdateShipmentRequest() {
  var o = new api.OrdersUpdateShipmentRequest();
  buildCounterOrdersUpdateShipmentRequest++;
  if (buildCounterOrdersUpdateShipmentRequest < 3) {
    o.carrier = "foo";
    o.operationId = "foo";
    o.shipmentId = "foo";
    o.status = "foo";
    o.trackingId = "foo";
  }
  buildCounterOrdersUpdateShipmentRequest--;
  return o;
}

checkOrdersUpdateShipmentRequest(api.OrdersUpdateShipmentRequest o) {
  buildCounterOrdersUpdateShipmentRequest++;
  if (buildCounterOrdersUpdateShipmentRequest < 3) {
    unittest.expect(o.carrier, unittest.equals('foo'));
    unittest.expect(o.operationId, unittest.equals('foo'));
    unittest.expect(o.shipmentId, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.trackingId, unittest.equals('foo'));
  }
  buildCounterOrdersUpdateShipmentRequest--;
}

core.int buildCounterOrdersUpdateShipmentResponse = 0;
buildOrdersUpdateShipmentResponse() {
  var o = new api.OrdersUpdateShipmentResponse();
  buildCounterOrdersUpdateShipmentResponse++;
  if (buildCounterOrdersUpdateShipmentResponse < 3) {
    o.executionStatus = "foo";
    o.kind = "foo";
  }
  buildCounterOrdersUpdateShipmentResponse--;
  return o;
}

checkOrdersUpdateShipmentResponse(api.OrdersUpdateShipmentResponse o) {
  buildCounterOrdersUpdateShipmentResponse++;
  if (buildCounterOrdersUpdateShipmentResponse < 3) {
    unittest.expect(o.executionStatus, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOrdersUpdateShipmentResponse--;
}

buildUnnamed318() {
  var o = new core.List<api.PostalCodeRange>();
  o.add(buildPostalCodeRange());
  o.add(buildPostalCodeRange());
  return o;
}

checkUnnamed318(core.List<api.PostalCodeRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPostalCodeRange(o[0]);
  checkPostalCodeRange(o[1]);
}

core.int buildCounterPostalCodeGroup = 0;
buildPostalCodeGroup() {
  var o = new api.PostalCodeGroup();
  buildCounterPostalCodeGroup++;
  if (buildCounterPostalCodeGroup < 3) {
    o.country = "foo";
    o.name = "foo";
    o.postalCodeRanges = buildUnnamed318();
  }
  buildCounterPostalCodeGroup--;
  return o;
}

checkPostalCodeGroup(api.PostalCodeGroup o) {
  buildCounterPostalCodeGroup++;
  if (buildCounterPostalCodeGroup < 3) {
    unittest.expect(o.country, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed318(o.postalCodeRanges);
  }
  buildCounterPostalCodeGroup--;
}

core.int buildCounterPostalCodeRange = 0;
buildPostalCodeRange() {
  var o = new api.PostalCodeRange();
  buildCounterPostalCodeRange++;
  if (buildCounterPostalCodeRange < 3) {
    o.postalCodeRangeBegin = "foo";
    o.postalCodeRangeEnd = "foo";
  }
  buildCounterPostalCodeRange--;
  return o;
}

checkPostalCodeRange(api.PostalCodeRange o) {
  buildCounterPostalCodeRange++;
  if (buildCounterPostalCodeRange < 3) {
    unittest.expect(o.postalCodeRangeBegin, unittest.equals('foo'));
    unittest.expect(o.postalCodeRangeEnd, unittest.equals('foo'));
  }
  buildCounterPostalCodeRange--;
}

core.int buildCounterPrice = 0;
buildPrice() {
  var o = new api.Price();
  buildCounterPrice++;
  if (buildCounterPrice < 3) {
    o.currency = "foo";
    o.value = "foo";
  }
  buildCounterPrice--;
  return o;
}

checkPrice(api.Price o) {
  buildCounterPrice++;
  if (buildCounterPrice < 3) {
    unittest.expect(o.currency, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterPrice--;
}

buildUnnamed319() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed319(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed320() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed320(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed321() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed321(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed322() {
  var o = new core.List<api.ProductAspect>();
  o.add(buildProductAspect());
  o.add(buildProductAspect());
  return o;
}

checkUnnamed322(core.List<api.ProductAspect> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductAspect(o[0]);
  checkProductAspect(o[1]);
}

buildUnnamed323() {
  var o = new core.List<api.ProductCustomAttribute>();
  o.add(buildProductCustomAttribute());
  o.add(buildProductCustomAttribute());
  return o;
}

checkUnnamed323(core.List<api.ProductCustomAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductCustomAttribute(o[0]);
  checkProductCustomAttribute(o[1]);
}

buildUnnamed324() {
  var o = new core.List<api.ProductCustomGroup>();
  o.add(buildProductCustomGroup());
  o.add(buildProductCustomGroup());
  return o;
}

checkUnnamed324(core.List<api.ProductCustomGroup> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductCustomGroup(o[0]);
  checkProductCustomGroup(o[1]);
}

buildUnnamed325() {
  var o = new core.List<api.ProductDestination>();
  o.add(buildProductDestination());
  o.add(buildProductDestination());
  return o;
}

checkUnnamed325(core.List<api.ProductDestination> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductDestination(o[0]);
  checkProductDestination(o[1]);
}

buildUnnamed326() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed326(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed327() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed327(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed328() {
  var o = new core.List<api.ProductShipping>();
  o.add(buildProductShipping());
  o.add(buildProductShipping());
  return o;
}

checkUnnamed328(core.List<api.ProductShipping> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductShipping(o[0]);
  checkProductShipping(o[1]);
}

buildUnnamed329() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed329(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed330() {
  var o = new core.List<api.ProductTax>();
  o.add(buildProductTax());
  o.add(buildProductTax());
  return o;
}

checkUnnamed330(core.List<api.ProductTax> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductTax(o[0]);
  checkProductTax(o[1]);
}

buildUnnamed331() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed331(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed332() {
  var o = new core.List<api.Error>();
  o.add(buildError());
  o.add(buildError());
  return o;
}

checkUnnamed332(core.List<api.Error> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkError(o[0]);
  checkError(o[1]);
}

core.int buildCounterProduct = 0;
buildProduct() {
  var o = new api.Product();
  buildCounterProduct++;
  if (buildCounterProduct < 3) {
    o.additionalImageLinks = buildUnnamed319();
    o.additionalProductTypes = buildUnnamed320();
    o.adult = true;
    o.adwordsGrouping = "foo";
    o.adwordsLabels = buildUnnamed321();
    o.adwordsRedirect = "foo";
    o.ageGroup = "foo";
    o.aspects = buildUnnamed322();
    o.availability = "foo";
    o.availabilityDate = "foo";
    o.brand = "foo";
    o.channel = "foo";
    o.color = "foo";
    o.condition = "foo";
    o.contentLanguage = "foo";
    o.customAttributes = buildUnnamed323();
    o.customGroups = buildUnnamed324();
    o.customLabel0 = "foo";
    o.customLabel1 = "foo";
    o.customLabel2 = "foo";
    o.customLabel3 = "foo";
    o.customLabel4 = "foo";
    o.description = "foo";
    o.destinations = buildUnnamed325();
    o.displayAdsId = "foo";
    o.displayAdsLink = "foo";
    o.displayAdsSimilarIds = buildUnnamed326();
    o.displayAdsTitle = "foo";
    o.displayAdsValue = 42.0;
    o.energyEfficiencyClass = "foo";
    o.expirationDate = "foo";
    o.gender = "foo";
    o.googleProductCategory = "foo";
    o.gtin = "foo";
    o.id = "foo";
    o.identifierExists = true;
    o.imageLink = "foo";
    o.installment = buildInstallment();
    o.isBundle = true;
    o.itemGroupId = "foo";
    o.kind = "foo";
    o.link = "foo";
    o.loyaltyPoints = buildLoyaltyPoints();
    o.material = "foo";
    o.mobileLink = "foo";
    o.mpn = "foo";
    o.multipack = "foo";
    o.offerId = "foo";
    o.onlineOnly = true;
    o.pattern = "foo";
    o.price = buildPrice();
    o.productType = "foo";
    o.promotionIds = buildUnnamed327();
    o.salePrice = buildPrice();
    o.salePriceEffectiveDate = "foo";
    o.sellOnGoogleQuantity = "foo";
    o.shipping = buildUnnamed328();
    o.shippingHeight = buildProductShippingDimension();
    o.shippingLabel = "foo";
    o.shippingLength = buildProductShippingDimension();
    o.shippingWeight = buildProductShippingWeight();
    o.shippingWidth = buildProductShippingDimension();
    o.sizeSystem = "foo";
    o.sizeType = "foo";
    o.sizes = buildUnnamed329();
    o.targetCountry = "foo";
    o.taxes = buildUnnamed330();
    o.title = "foo";
    o.unitPricingBaseMeasure = buildProductUnitPricingBaseMeasure();
    o.unitPricingMeasure = buildProductUnitPricingMeasure();
    o.validatedDestinations = buildUnnamed331();
    o.warnings = buildUnnamed332();
  }
  buildCounterProduct--;
  return o;
}

checkProduct(api.Product o) {
  buildCounterProduct++;
  if (buildCounterProduct < 3) {
    checkUnnamed319(o.additionalImageLinks);
    checkUnnamed320(o.additionalProductTypes);
    unittest.expect(o.adult, unittest.isTrue);
    unittest.expect(o.adwordsGrouping, unittest.equals('foo'));
    checkUnnamed321(o.adwordsLabels);
    unittest.expect(o.adwordsRedirect, unittest.equals('foo'));
    unittest.expect(o.ageGroup, unittest.equals('foo'));
    checkUnnamed322(o.aspects);
    unittest.expect(o.availability, unittest.equals('foo'));
    unittest.expect(o.availabilityDate, unittest.equals('foo'));
    unittest.expect(o.brand, unittest.equals('foo'));
    unittest.expect(o.channel, unittest.equals('foo'));
    unittest.expect(o.color, unittest.equals('foo'));
    unittest.expect(o.condition, unittest.equals('foo'));
    unittest.expect(o.contentLanguage, unittest.equals('foo'));
    checkUnnamed323(o.customAttributes);
    checkUnnamed324(o.customGroups);
    unittest.expect(o.customLabel0, unittest.equals('foo'));
    unittest.expect(o.customLabel1, unittest.equals('foo'));
    unittest.expect(o.customLabel2, unittest.equals('foo'));
    unittest.expect(o.customLabel3, unittest.equals('foo'));
    unittest.expect(o.customLabel4, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    checkUnnamed325(o.destinations);
    unittest.expect(o.displayAdsId, unittest.equals('foo'));
    unittest.expect(o.displayAdsLink, unittest.equals('foo'));
    checkUnnamed326(o.displayAdsSimilarIds);
    unittest.expect(o.displayAdsTitle, unittest.equals('foo'));
    unittest.expect(o.displayAdsValue, unittest.equals(42.0));
    unittest.expect(o.energyEfficiencyClass, unittest.equals('foo'));
    unittest.expect(o.expirationDate, unittest.equals('foo'));
    unittest.expect(o.gender, unittest.equals('foo'));
    unittest.expect(o.googleProductCategory, unittest.equals('foo'));
    unittest.expect(o.gtin, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.identifierExists, unittest.isTrue);
    unittest.expect(o.imageLink, unittest.equals('foo'));
    checkInstallment(o.installment);
    unittest.expect(o.isBundle, unittest.isTrue);
    unittest.expect(o.itemGroupId, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.link, unittest.equals('foo'));
    checkLoyaltyPoints(o.loyaltyPoints);
    unittest.expect(o.material, unittest.equals('foo'));
    unittest.expect(o.mobileLink, unittest.equals('foo'));
    unittest.expect(o.mpn, unittest.equals('foo'));
    unittest.expect(o.multipack, unittest.equals('foo'));
    unittest.expect(o.offerId, unittest.equals('foo'));
    unittest.expect(o.onlineOnly, unittest.isTrue);
    unittest.expect(o.pattern, unittest.equals('foo'));
    checkPrice(o.price);
    unittest.expect(o.productType, unittest.equals('foo'));
    checkUnnamed327(o.promotionIds);
    checkPrice(o.salePrice);
    unittest.expect(o.salePriceEffectiveDate, unittest.equals('foo'));
    unittest.expect(o.sellOnGoogleQuantity, unittest.equals('foo'));
    checkUnnamed328(o.shipping);
    checkProductShippingDimension(o.shippingHeight);
    unittest.expect(o.shippingLabel, unittest.equals('foo'));
    checkProductShippingDimension(o.shippingLength);
    checkProductShippingWeight(o.shippingWeight);
    checkProductShippingDimension(o.shippingWidth);
    unittest.expect(o.sizeSystem, unittest.equals('foo'));
    unittest.expect(o.sizeType, unittest.equals('foo'));
    checkUnnamed329(o.sizes);
    unittest.expect(o.targetCountry, unittest.equals('foo'));
    checkUnnamed330(o.taxes);
    unittest.expect(o.title, unittest.equals('foo'));
    checkProductUnitPricingBaseMeasure(o.unitPricingBaseMeasure);
    checkProductUnitPricingMeasure(o.unitPricingMeasure);
    checkUnnamed331(o.validatedDestinations);
    checkUnnamed332(o.warnings);
  }
  buildCounterProduct--;
}

core.int buildCounterProductAspect = 0;
buildProductAspect() {
  var o = new api.ProductAspect();
  buildCounterProductAspect++;
  if (buildCounterProductAspect < 3) {
    o.aspectName = "foo";
    o.destinationName = "foo";
    o.intention = "foo";
  }
  buildCounterProductAspect--;
  return o;
}

checkProductAspect(api.ProductAspect o) {
  buildCounterProductAspect++;
  if (buildCounterProductAspect < 3) {
    unittest.expect(o.aspectName, unittest.equals('foo'));
    unittest.expect(o.destinationName, unittest.equals('foo'));
    unittest.expect(o.intention, unittest.equals('foo'));
  }
  buildCounterProductAspect--;
}

core.int buildCounterProductCustomAttribute = 0;
buildProductCustomAttribute() {
  var o = new api.ProductCustomAttribute();
  buildCounterProductCustomAttribute++;
  if (buildCounterProductCustomAttribute < 3) {
    o.name = "foo";
    o.type = "foo";
    o.unit = "foo";
    o.value = "foo";
  }
  buildCounterProductCustomAttribute--;
  return o;
}

checkProductCustomAttribute(api.ProductCustomAttribute o) {
  buildCounterProductCustomAttribute++;
  if (buildCounterProductCustomAttribute < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.unit, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterProductCustomAttribute--;
}

buildUnnamed333() {
  var o = new core.List<api.ProductCustomAttribute>();
  o.add(buildProductCustomAttribute());
  o.add(buildProductCustomAttribute());
  return o;
}

checkUnnamed333(core.List<api.ProductCustomAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductCustomAttribute(o[0]);
  checkProductCustomAttribute(o[1]);
}

core.int buildCounterProductCustomGroup = 0;
buildProductCustomGroup() {
  var o = new api.ProductCustomGroup();
  buildCounterProductCustomGroup++;
  if (buildCounterProductCustomGroup < 3) {
    o.attributes = buildUnnamed333();
    o.name = "foo";
  }
  buildCounterProductCustomGroup--;
  return o;
}

checkProductCustomGroup(api.ProductCustomGroup o) {
  buildCounterProductCustomGroup++;
  if (buildCounterProductCustomGroup < 3) {
    checkUnnamed333(o.attributes);
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterProductCustomGroup--;
}

core.int buildCounterProductDestination = 0;
buildProductDestination() {
  var o = new api.ProductDestination();
  buildCounterProductDestination++;
  if (buildCounterProductDestination < 3) {
    o.destinationName = "foo";
    o.intention = "foo";
  }
  buildCounterProductDestination--;
  return o;
}

checkProductDestination(api.ProductDestination o) {
  buildCounterProductDestination++;
  if (buildCounterProductDestination < 3) {
    unittest.expect(o.destinationName, unittest.equals('foo'));
    unittest.expect(o.intention, unittest.equals('foo'));
  }
  buildCounterProductDestination--;
}

core.int buildCounterProductShipping = 0;
buildProductShipping() {
  var o = new api.ProductShipping();
  buildCounterProductShipping++;
  if (buildCounterProductShipping < 3) {
    o.country = "foo";
    o.locationGroupName = "foo";
    o.locationId = "foo";
    o.postalCode = "foo";
    o.price = buildPrice();
    o.region = "foo";
    o.service = "foo";
  }
  buildCounterProductShipping--;
  return o;
}

checkProductShipping(api.ProductShipping o) {
  buildCounterProductShipping++;
  if (buildCounterProductShipping < 3) {
    unittest.expect(o.country, unittest.equals('foo'));
    unittest.expect(o.locationGroupName, unittest.equals('foo'));
    unittest.expect(o.locationId, unittest.equals('foo'));
    unittest.expect(o.postalCode, unittest.equals('foo'));
    checkPrice(o.price);
    unittest.expect(o.region, unittest.equals('foo'));
    unittest.expect(o.service, unittest.equals('foo'));
  }
  buildCounterProductShipping--;
}

core.int buildCounterProductShippingDimension = 0;
buildProductShippingDimension() {
  var o = new api.ProductShippingDimension();
  buildCounterProductShippingDimension++;
  if (buildCounterProductShippingDimension < 3) {
    o.unit = "foo";
    o.value = 42.0;
  }
  buildCounterProductShippingDimension--;
  return o;
}

checkProductShippingDimension(api.ProductShippingDimension o) {
  buildCounterProductShippingDimension++;
  if (buildCounterProductShippingDimension < 3) {
    unittest.expect(o.unit, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals(42.0));
  }
  buildCounterProductShippingDimension--;
}

core.int buildCounterProductShippingWeight = 0;
buildProductShippingWeight() {
  var o = new api.ProductShippingWeight();
  buildCounterProductShippingWeight++;
  if (buildCounterProductShippingWeight < 3) {
    o.unit = "foo";
    o.value = 42.0;
  }
  buildCounterProductShippingWeight--;
  return o;
}

checkProductShippingWeight(api.ProductShippingWeight o) {
  buildCounterProductShippingWeight++;
  if (buildCounterProductShippingWeight < 3) {
    unittest.expect(o.unit, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals(42.0));
  }
  buildCounterProductShippingWeight--;
}

buildUnnamed334() {
  var o = new core.List<api.ProductStatusDataQualityIssue>();
  o.add(buildProductStatusDataQualityIssue());
  o.add(buildProductStatusDataQualityIssue());
  return o;
}

checkUnnamed334(core.List<api.ProductStatusDataQualityIssue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductStatusDataQualityIssue(o[0]);
  checkProductStatusDataQualityIssue(o[1]);
}

buildUnnamed335() {
  var o = new core.List<api.ProductStatusDestinationStatus>();
  o.add(buildProductStatusDestinationStatus());
  o.add(buildProductStatusDestinationStatus());
  return o;
}

checkUnnamed335(core.List<api.ProductStatusDestinationStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductStatusDestinationStatus(o[0]);
  checkProductStatusDestinationStatus(o[1]);
}

core.int buildCounterProductStatus = 0;
buildProductStatus() {
  var o = new api.ProductStatus();
  buildCounterProductStatus++;
  if (buildCounterProductStatus < 3) {
    o.creationDate = "foo";
    o.dataQualityIssues = buildUnnamed334();
    o.destinationStatuses = buildUnnamed335();
    o.googleExpirationDate = "foo";
    o.kind = "foo";
    o.lastUpdateDate = "foo";
    o.link = "foo";
    o.productId = "foo";
    o.title = "foo";
  }
  buildCounterProductStatus--;
  return o;
}

checkProductStatus(api.ProductStatus o) {
  buildCounterProductStatus++;
  if (buildCounterProductStatus < 3) {
    unittest.expect(o.creationDate, unittest.equals('foo'));
    checkUnnamed334(o.dataQualityIssues);
    checkUnnamed335(o.destinationStatuses);
    unittest.expect(o.googleExpirationDate, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.lastUpdateDate, unittest.equals('foo'));
    unittest.expect(o.link, unittest.equals('foo'));
    unittest.expect(o.productId, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterProductStatus--;
}

core.int buildCounterProductStatusDataQualityIssue = 0;
buildProductStatusDataQualityIssue() {
  var o = new api.ProductStatusDataQualityIssue();
  buildCounterProductStatusDataQualityIssue++;
  if (buildCounterProductStatusDataQualityIssue < 3) {
    o.detail = "foo";
    o.fetchStatus = "foo";
    o.id = "foo";
    o.location = "foo";
    o.severity = "foo";
    o.timestamp = "foo";
    o.valueOnLandingPage = "foo";
    o.valueProvided = "foo";
  }
  buildCounterProductStatusDataQualityIssue--;
  return o;
}

checkProductStatusDataQualityIssue(api.ProductStatusDataQualityIssue o) {
  buildCounterProductStatusDataQualityIssue++;
  if (buildCounterProductStatusDataQualityIssue < 3) {
    unittest.expect(o.detail, unittest.equals('foo'));
    unittest.expect(o.fetchStatus, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.location, unittest.equals('foo'));
    unittest.expect(o.severity, unittest.equals('foo'));
    unittest.expect(o.timestamp, unittest.equals('foo'));
    unittest.expect(o.valueOnLandingPage, unittest.equals('foo'));
    unittest.expect(o.valueProvided, unittest.equals('foo'));
  }
  buildCounterProductStatusDataQualityIssue--;
}

core.int buildCounterProductStatusDestinationStatus = 0;
buildProductStatusDestinationStatus() {
  var o = new api.ProductStatusDestinationStatus();
  buildCounterProductStatusDestinationStatus++;
  if (buildCounterProductStatusDestinationStatus < 3) {
    o.approvalStatus = "foo";
    o.destination = "foo";
    o.intention = "foo";
  }
  buildCounterProductStatusDestinationStatus--;
  return o;
}

checkProductStatusDestinationStatus(api.ProductStatusDestinationStatus o) {
  buildCounterProductStatusDestinationStatus++;
  if (buildCounterProductStatusDestinationStatus < 3) {
    unittest.expect(o.approvalStatus, unittest.equals('foo'));
    unittest.expect(o.destination, unittest.equals('foo'));
    unittest.expect(o.intention, unittest.equals('foo'));
  }
  buildCounterProductStatusDestinationStatus--;
}

core.int buildCounterProductTax = 0;
buildProductTax() {
  var o = new api.ProductTax();
  buildCounterProductTax++;
  if (buildCounterProductTax < 3) {
    o.country = "foo";
    o.locationId = "foo";
    o.postalCode = "foo";
    o.rate = 42.0;
    o.region = "foo";
    o.taxShip = true;
  }
  buildCounterProductTax--;
  return o;
}

checkProductTax(api.ProductTax o) {
  buildCounterProductTax++;
  if (buildCounterProductTax < 3) {
    unittest.expect(o.country, unittest.equals('foo'));
    unittest.expect(o.locationId, unittest.equals('foo'));
    unittest.expect(o.postalCode, unittest.equals('foo'));
    unittest.expect(o.rate, unittest.equals(42.0));
    unittest.expect(o.region, unittest.equals('foo'));
    unittest.expect(o.taxShip, unittest.isTrue);
  }
  buildCounterProductTax--;
}

core.int buildCounterProductUnitPricingBaseMeasure = 0;
buildProductUnitPricingBaseMeasure() {
  var o = new api.ProductUnitPricingBaseMeasure();
  buildCounterProductUnitPricingBaseMeasure++;
  if (buildCounterProductUnitPricingBaseMeasure < 3) {
    o.unit = "foo";
    o.value = "foo";
  }
  buildCounterProductUnitPricingBaseMeasure--;
  return o;
}

checkProductUnitPricingBaseMeasure(api.ProductUnitPricingBaseMeasure o) {
  buildCounterProductUnitPricingBaseMeasure++;
  if (buildCounterProductUnitPricingBaseMeasure < 3) {
    unittest.expect(o.unit, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterProductUnitPricingBaseMeasure--;
}

core.int buildCounterProductUnitPricingMeasure = 0;
buildProductUnitPricingMeasure() {
  var o = new api.ProductUnitPricingMeasure();
  buildCounterProductUnitPricingMeasure++;
  if (buildCounterProductUnitPricingMeasure < 3) {
    o.unit = "foo";
    o.value = 42.0;
  }
  buildCounterProductUnitPricingMeasure--;
  return o;
}

checkProductUnitPricingMeasure(api.ProductUnitPricingMeasure o) {
  buildCounterProductUnitPricingMeasure++;
  if (buildCounterProductUnitPricingMeasure < 3) {
    unittest.expect(o.unit, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals(42.0));
  }
  buildCounterProductUnitPricingMeasure--;
}

buildUnnamed336() {
  var o = new core.List<api.ProductsCustomBatchRequestEntry>();
  o.add(buildProductsCustomBatchRequestEntry());
  o.add(buildProductsCustomBatchRequestEntry());
  return o;
}

checkUnnamed336(core.List<api.ProductsCustomBatchRequestEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductsCustomBatchRequestEntry(o[0]);
  checkProductsCustomBatchRequestEntry(o[1]);
}

core.int buildCounterProductsCustomBatchRequest = 0;
buildProductsCustomBatchRequest() {
  var o = new api.ProductsCustomBatchRequest();
  buildCounterProductsCustomBatchRequest++;
  if (buildCounterProductsCustomBatchRequest < 3) {
    o.entries = buildUnnamed336();
  }
  buildCounterProductsCustomBatchRequest--;
  return o;
}

checkProductsCustomBatchRequest(api.ProductsCustomBatchRequest o) {
  buildCounterProductsCustomBatchRequest++;
  if (buildCounterProductsCustomBatchRequest < 3) {
    checkUnnamed336(o.entries);
  }
  buildCounterProductsCustomBatchRequest--;
}

core.int buildCounterProductsCustomBatchRequestEntry = 0;
buildProductsCustomBatchRequestEntry() {
  var o = new api.ProductsCustomBatchRequestEntry();
  buildCounterProductsCustomBatchRequestEntry++;
  if (buildCounterProductsCustomBatchRequestEntry < 3) {
    o.batchId = 42;
    o.merchantId = "foo";
    o.method = "foo";
    o.product = buildProduct();
    o.productId = "foo";
  }
  buildCounterProductsCustomBatchRequestEntry--;
  return o;
}

checkProductsCustomBatchRequestEntry(api.ProductsCustomBatchRequestEntry o) {
  buildCounterProductsCustomBatchRequestEntry++;
  if (buildCounterProductsCustomBatchRequestEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    unittest.expect(o.merchantId, unittest.equals('foo'));
    unittest.expect(o.method, unittest.equals('foo'));
    checkProduct(o.product);
    unittest.expect(o.productId, unittest.equals('foo'));
  }
  buildCounterProductsCustomBatchRequestEntry--;
}

buildUnnamed337() {
  var o = new core.List<api.ProductsCustomBatchResponseEntry>();
  o.add(buildProductsCustomBatchResponseEntry());
  o.add(buildProductsCustomBatchResponseEntry());
  return o;
}

checkUnnamed337(core.List<api.ProductsCustomBatchResponseEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductsCustomBatchResponseEntry(o[0]);
  checkProductsCustomBatchResponseEntry(o[1]);
}

core.int buildCounterProductsCustomBatchResponse = 0;
buildProductsCustomBatchResponse() {
  var o = new api.ProductsCustomBatchResponse();
  buildCounterProductsCustomBatchResponse++;
  if (buildCounterProductsCustomBatchResponse < 3) {
    o.entries = buildUnnamed337();
    o.kind = "foo";
  }
  buildCounterProductsCustomBatchResponse--;
  return o;
}

checkProductsCustomBatchResponse(api.ProductsCustomBatchResponse o) {
  buildCounterProductsCustomBatchResponse++;
  if (buildCounterProductsCustomBatchResponse < 3) {
    checkUnnamed337(o.entries);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterProductsCustomBatchResponse--;
}

core.int buildCounterProductsCustomBatchResponseEntry = 0;
buildProductsCustomBatchResponseEntry() {
  var o = new api.ProductsCustomBatchResponseEntry();
  buildCounterProductsCustomBatchResponseEntry++;
  if (buildCounterProductsCustomBatchResponseEntry < 3) {
    o.batchId = 42;
    o.errors = buildErrors();
    o.kind = "foo";
    o.product = buildProduct();
  }
  buildCounterProductsCustomBatchResponseEntry--;
  return o;
}

checkProductsCustomBatchResponseEntry(api.ProductsCustomBatchResponseEntry o) {
  buildCounterProductsCustomBatchResponseEntry++;
  if (buildCounterProductsCustomBatchResponseEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    checkErrors(o.errors);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkProduct(o.product);
  }
  buildCounterProductsCustomBatchResponseEntry--;
}

buildUnnamed338() {
  var o = new core.List<api.Product>();
  o.add(buildProduct());
  o.add(buildProduct());
  return o;
}

checkUnnamed338(core.List<api.Product> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProduct(o[0]);
  checkProduct(o[1]);
}

core.int buildCounterProductsListResponse = 0;
buildProductsListResponse() {
  var o = new api.ProductsListResponse();
  buildCounterProductsListResponse++;
  if (buildCounterProductsListResponse < 3) {
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.resources = buildUnnamed338();
  }
  buildCounterProductsListResponse--;
  return o;
}

checkProductsListResponse(api.ProductsListResponse o) {
  buildCounterProductsListResponse++;
  if (buildCounterProductsListResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed338(o.resources);
  }
  buildCounterProductsListResponse--;
}

buildUnnamed339() {
  var o = new core.List<api.ProductstatusesCustomBatchRequestEntry>();
  o.add(buildProductstatusesCustomBatchRequestEntry());
  o.add(buildProductstatusesCustomBatchRequestEntry());
  return o;
}

checkUnnamed339(core.List<api.ProductstatusesCustomBatchRequestEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductstatusesCustomBatchRequestEntry(o[0]);
  checkProductstatusesCustomBatchRequestEntry(o[1]);
}

core.int buildCounterProductstatusesCustomBatchRequest = 0;
buildProductstatusesCustomBatchRequest() {
  var o = new api.ProductstatusesCustomBatchRequest();
  buildCounterProductstatusesCustomBatchRequest++;
  if (buildCounterProductstatusesCustomBatchRequest < 3) {
    o.entries = buildUnnamed339();
  }
  buildCounterProductstatusesCustomBatchRequest--;
  return o;
}

checkProductstatusesCustomBatchRequest(api.ProductstatusesCustomBatchRequest o) {
  buildCounterProductstatusesCustomBatchRequest++;
  if (buildCounterProductstatusesCustomBatchRequest < 3) {
    checkUnnamed339(o.entries);
  }
  buildCounterProductstatusesCustomBatchRequest--;
}

core.int buildCounterProductstatusesCustomBatchRequestEntry = 0;
buildProductstatusesCustomBatchRequestEntry() {
  var o = new api.ProductstatusesCustomBatchRequestEntry();
  buildCounterProductstatusesCustomBatchRequestEntry++;
  if (buildCounterProductstatusesCustomBatchRequestEntry < 3) {
    o.batchId = 42;
    o.merchantId = "foo";
    o.method = "foo";
    o.productId = "foo";
  }
  buildCounterProductstatusesCustomBatchRequestEntry--;
  return o;
}

checkProductstatusesCustomBatchRequestEntry(api.ProductstatusesCustomBatchRequestEntry o) {
  buildCounterProductstatusesCustomBatchRequestEntry++;
  if (buildCounterProductstatusesCustomBatchRequestEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    unittest.expect(o.merchantId, unittest.equals('foo'));
    unittest.expect(o.method, unittest.equals('foo'));
    unittest.expect(o.productId, unittest.equals('foo'));
  }
  buildCounterProductstatusesCustomBatchRequestEntry--;
}

buildUnnamed340() {
  var o = new core.List<api.ProductstatusesCustomBatchResponseEntry>();
  o.add(buildProductstatusesCustomBatchResponseEntry());
  o.add(buildProductstatusesCustomBatchResponseEntry());
  return o;
}

checkUnnamed340(core.List<api.ProductstatusesCustomBatchResponseEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductstatusesCustomBatchResponseEntry(o[0]);
  checkProductstatusesCustomBatchResponseEntry(o[1]);
}

core.int buildCounterProductstatusesCustomBatchResponse = 0;
buildProductstatusesCustomBatchResponse() {
  var o = new api.ProductstatusesCustomBatchResponse();
  buildCounterProductstatusesCustomBatchResponse++;
  if (buildCounterProductstatusesCustomBatchResponse < 3) {
    o.entries = buildUnnamed340();
    o.kind = "foo";
  }
  buildCounterProductstatusesCustomBatchResponse--;
  return o;
}

checkProductstatusesCustomBatchResponse(api.ProductstatusesCustomBatchResponse o) {
  buildCounterProductstatusesCustomBatchResponse++;
  if (buildCounterProductstatusesCustomBatchResponse < 3) {
    checkUnnamed340(o.entries);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterProductstatusesCustomBatchResponse--;
}

core.int buildCounterProductstatusesCustomBatchResponseEntry = 0;
buildProductstatusesCustomBatchResponseEntry() {
  var o = new api.ProductstatusesCustomBatchResponseEntry();
  buildCounterProductstatusesCustomBatchResponseEntry++;
  if (buildCounterProductstatusesCustomBatchResponseEntry < 3) {
    o.batchId = 42;
    o.errors = buildErrors();
    o.kind = "foo";
    o.productStatus = buildProductStatus();
  }
  buildCounterProductstatusesCustomBatchResponseEntry--;
  return o;
}

checkProductstatusesCustomBatchResponseEntry(api.ProductstatusesCustomBatchResponseEntry o) {
  buildCounterProductstatusesCustomBatchResponseEntry++;
  if (buildCounterProductstatusesCustomBatchResponseEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    checkErrors(o.errors);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkProductStatus(o.productStatus);
  }
  buildCounterProductstatusesCustomBatchResponseEntry--;
}

buildUnnamed341() {
  var o = new core.List<api.ProductStatus>();
  o.add(buildProductStatus());
  o.add(buildProductStatus());
  return o;
}

checkUnnamed341(core.List<api.ProductStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductStatus(o[0]);
  checkProductStatus(o[1]);
}

core.int buildCounterProductstatusesListResponse = 0;
buildProductstatusesListResponse() {
  var o = new api.ProductstatusesListResponse();
  buildCounterProductstatusesListResponse++;
  if (buildCounterProductstatusesListResponse < 3) {
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.resources = buildUnnamed341();
  }
  buildCounterProductstatusesListResponse--;
  return o;
}

checkProductstatusesListResponse(api.ProductstatusesListResponse o) {
  buildCounterProductstatusesListResponse++;
  if (buildCounterProductstatusesListResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed341(o.resources);
  }
  buildCounterProductstatusesListResponse--;
}

buildUnnamed342() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed342(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed343() {
  var o = new core.List<api.CarrierRate>();
  o.add(buildCarrierRate());
  o.add(buildCarrierRate());
  return o;
}

checkUnnamed343(core.List<api.CarrierRate> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCarrierRate(o[0]);
  checkCarrierRate(o[1]);
}

buildUnnamed344() {
  var o = new core.List<api.Table>();
  o.add(buildTable());
  o.add(buildTable());
  return o;
}

checkUnnamed344(core.List<api.Table> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTable(o[0]);
  checkTable(o[1]);
}

core.int buildCounterRateGroup = 0;
buildRateGroup() {
  var o = new api.RateGroup();
  buildCounterRateGroup++;
  if (buildCounterRateGroup < 3) {
    o.applicableShippingLabels = buildUnnamed342();
    o.carrierRates = buildUnnamed343();
    o.mainTable = buildTable();
    o.singleValue = buildValue();
    o.subtables = buildUnnamed344();
  }
  buildCounterRateGroup--;
  return o;
}

checkRateGroup(api.RateGroup o) {
  buildCounterRateGroup++;
  if (buildCounterRateGroup < 3) {
    checkUnnamed342(o.applicableShippingLabels);
    checkUnnamed343(o.carrierRates);
    checkTable(o.mainTable);
    checkValue(o.singleValue);
    checkUnnamed344(o.subtables);
  }
  buildCounterRateGroup--;
}

buildUnnamed345() {
  var o = new core.List<api.Value>();
  o.add(buildValue());
  o.add(buildValue());
  return o;
}

checkUnnamed345(core.List<api.Value> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkValue(o[0]);
  checkValue(o[1]);
}

core.int buildCounterRow = 0;
buildRow() {
  var o = new api.Row();
  buildCounterRow++;
  if (buildCounterRow < 3) {
    o.cells = buildUnnamed345();
  }
  buildCounterRow--;
  return o;
}

checkRow(api.Row o) {
  buildCounterRow++;
  if (buildCounterRow < 3) {
    checkUnnamed345(o.cells);
  }
  buildCounterRow--;
}

buildUnnamed346() {
  var o = new core.List<api.RateGroup>();
  o.add(buildRateGroup());
  o.add(buildRateGroup());
  return o;
}

checkUnnamed346(core.List<api.RateGroup> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRateGroup(o[0]);
  checkRateGroup(o[1]);
}

core.int buildCounterService = 0;
buildService() {
  var o = new api.Service();
  buildCounterService++;
  if (buildCounterService < 3) {
    o.active = true;
    o.currency = "foo";
    o.deliveryCountry = "foo";
    o.deliveryTime = buildDeliveryTime();
    o.name = "foo";
    o.rateGroups = buildUnnamed346();
  }
  buildCounterService--;
  return o;
}

checkService(api.Service o) {
  buildCounterService++;
  if (buildCounterService < 3) {
    unittest.expect(o.active, unittest.isTrue);
    unittest.expect(o.currency, unittest.equals('foo'));
    unittest.expect(o.deliveryCountry, unittest.equals('foo'));
    checkDeliveryTime(o.deliveryTime);
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed346(o.rateGroups);
  }
  buildCounterService--;
}

buildUnnamed347() {
  var o = new core.List<api.PostalCodeGroup>();
  o.add(buildPostalCodeGroup());
  o.add(buildPostalCodeGroup());
  return o;
}

checkUnnamed347(core.List<api.PostalCodeGroup> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPostalCodeGroup(o[0]);
  checkPostalCodeGroup(o[1]);
}

buildUnnamed348() {
  var o = new core.List<api.Service>();
  o.add(buildService());
  o.add(buildService());
  return o;
}

checkUnnamed348(core.List<api.Service> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkService(o[0]);
  checkService(o[1]);
}

core.int buildCounterShippingSettings = 0;
buildShippingSettings() {
  var o = new api.ShippingSettings();
  buildCounterShippingSettings++;
  if (buildCounterShippingSettings < 3) {
    o.accountId = "foo";
    o.postalCodeGroups = buildUnnamed347();
    o.services = buildUnnamed348();
  }
  buildCounterShippingSettings--;
  return o;
}

checkShippingSettings(api.ShippingSettings o) {
  buildCounterShippingSettings++;
  if (buildCounterShippingSettings < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    checkUnnamed347(o.postalCodeGroups);
    checkUnnamed348(o.services);
  }
  buildCounterShippingSettings--;
}

buildUnnamed349() {
  var o = new core.List<api.ShippingsettingsCustomBatchRequestEntry>();
  o.add(buildShippingsettingsCustomBatchRequestEntry());
  o.add(buildShippingsettingsCustomBatchRequestEntry());
  return o;
}

checkUnnamed349(core.List<api.ShippingsettingsCustomBatchRequestEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkShippingsettingsCustomBatchRequestEntry(o[0]);
  checkShippingsettingsCustomBatchRequestEntry(o[1]);
}

core.int buildCounterShippingsettingsCustomBatchRequest = 0;
buildShippingsettingsCustomBatchRequest() {
  var o = new api.ShippingsettingsCustomBatchRequest();
  buildCounterShippingsettingsCustomBatchRequest++;
  if (buildCounterShippingsettingsCustomBatchRequest < 3) {
    o.entries = buildUnnamed349();
  }
  buildCounterShippingsettingsCustomBatchRequest--;
  return o;
}

checkShippingsettingsCustomBatchRequest(api.ShippingsettingsCustomBatchRequest o) {
  buildCounterShippingsettingsCustomBatchRequest++;
  if (buildCounterShippingsettingsCustomBatchRequest < 3) {
    checkUnnamed349(o.entries);
  }
  buildCounterShippingsettingsCustomBatchRequest--;
}

core.int buildCounterShippingsettingsCustomBatchRequestEntry = 0;
buildShippingsettingsCustomBatchRequestEntry() {
  var o = new api.ShippingsettingsCustomBatchRequestEntry();
  buildCounterShippingsettingsCustomBatchRequestEntry++;
  if (buildCounterShippingsettingsCustomBatchRequestEntry < 3) {
    o.accountId = "foo";
    o.batchId = 42;
    o.merchantId = "foo";
    o.method = "foo";
    o.shippingSettings = buildShippingSettings();
  }
  buildCounterShippingsettingsCustomBatchRequestEntry--;
  return o;
}

checkShippingsettingsCustomBatchRequestEntry(api.ShippingsettingsCustomBatchRequestEntry o) {
  buildCounterShippingsettingsCustomBatchRequestEntry++;
  if (buildCounterShippingsettingsCustomBatchRequestEntry < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.batchId, unittest.equals(42));
    unittest.expect(o.merchantId, unittest.equals('foo'));
    unittest.expect(o.method, unittest.equals('foo'));
    checkShippingSettings(o.shippingSettings);
  }
  buildCounterShippingsettingsCustomBatchRequestEntry--;
}

buildUnnamed350() {
  var o = new core.List<api.ShippingsettingsCustomBatchResponseEntry>();
  o.add(buildShippingsettingsCustomBatchResponseEntry());
  o.add(buildShippingsettingsCustomBatchResponseEntry());
  return o;
}

checkUnnamed350(core.List<api.ShippingsettingsCustomBatchResponseEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkShippingsettingsCustomBatchResponseEntry(o[0]);
  checkShippingsettingsCustomBatchResponseEntry(o[1]);
}

core.int buildCounterShippingsettingsCustomBatchResponse = 0;
buildShippingsettingsCustomBatchResponse() {
  var o = new api.ShippingsettingsCustomBatchResponse();
  buildCounterShippingsettingsCustomBatchResponse++;
  if (buildCounterShippingsettingsCustomBatchResponse < 3) {
    o.entries = buildUnnamed350();
    o.kind = "foo";
  }
  buildCounterShippingsettingsCustomBatchResponse--;
  return o;
}

checkShippingsettingsCustomBatchResponse(api.ShippingsettingsCustomBatchResponse o) {
  buildCounterShippingsettingsCustomBatchResponse++;
  if (buildCounterShippingsettingsCustomBatchResponse < 3) {
    checkUnnamed350(o.entries);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterShippingsettingsCustomBatchResponse--;
}

core.int buildCounterShippingsettingsCustomBatchResponseEntry = 0;
buildShippingsettingsCustomBatchResponseEntry() {
  var o = new api.ShippingsettingsCustomBatchResponseEntry();
  buildCounterShippingsettingsCustomBatchResponseEntry++;
  if (buildCounterShippingsettingsCustomBatchResponseEntry < 3) {
    o.batchId = 42;
    o.errors = buildErrors();
    o.kind = "foo";
    o.shippingSettings = buildShippingSettings();
  }
  buildCounterShippingsettingsCustomBatchResponseEntry--;
  return o;
}

checkShippingsettingsCustomBatchResponseEntry(api.ShippingsettingsCustomBatchResponseEntry o) {
  buildCounterShippingsettingsCustomBatchResponseEntry++;
  if (buildCounterShippingsettingsCustomBatchResponseEntry < 3) {
    unittest.expect(o.batchId, unittest.equals(42));
    checkErrors(o.errors);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkShippingSettings(o.shippingSettings);
  }
  buildCounterShippingsettingsCustomBatchResponseEntry--;
}

buildUnnamed351() {
  var o = new core.List<api.CarriersCarrier>();
  o.add(buildCarriersCarrier());
  o.add(buildCarriersCarrier());
  return o;
}

checkUnnamed351(core.List<api.CarriersCarrier> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCarriersCarrier(o[0]);
  checkCarriersCarrier(o[1]);
}

core.int buildCounterShippingsettingsGetSupportedCarriersResponse = 0;
buildShippingsettingsGetSupportedCarriersResponse() {
  var o = new api.ShippingsettingsGetSupportedCarriersResponse();
  buildCounterShippingsettingsGetSupportedCarriersResponse++;
  if (buildCounterShippingsettingsGetSupportedCarriersResponse < 3) {
    o.carriers = buildUnnamed351();
    o.kind = "foo";
  }
  buildCounterShippingsettingsGetSupportedCarriersResponse--;
  return o;
}

checkShippingsettingsGetSupportedCarriersResponse(api.ShippingsettingsGetSupportedCarriersResponse o) {
  buildCounterShippingsettingsGetSupportedCarriersResponse++;
  if (buildCounterShippingsettingsGetSupportedCarriersResponse < 3) {
    checkUnnamed351(o.carriers);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterShippingsettingsGetSupportedCarriersResponse--;
}

buildUnnamed352() {
  var o = new core.List<api.ShippingSettings>();
  o.add(buildShippingSettings());
  o.add(buildShippingSettings());
  return o;
}

checkUnnamed352(core.List<api.ShippingSettings> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkShippingSettings(o[0]);
  checkShippingSettings(o[1]);
}

core.int buildCounterShippingsettingsListResponse = 0;
buildShippingsettingsListResponse() {
  var o = new api.ShippingsettingsListResponse();
  buildCounterShippingsettingsListResponse++;
  if (buildCounterShippingsettingsListResponse < 3) {
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.resources = buildUnnamed352();
  }
  buildCounterShippingsettingsListResponse--;
  return o;
}

checkShippingsettingsListResponse(api.ShippingsettingsListResponse o) {
  buildCounterShippingsettingsListResponse++;
  if (buildCounterShippingsettingsListResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed352(o.resources);
  }
  buildCounterShippingsettingsListResponse--;
}

buildUnnamed353() {
  var o = new core.List<api.Row>();
  o.add(buildRow());
  o.add(buildRow());
  return o;
}

checkUnnamed353(core.List<api.Row> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRow(o[0]);
  checkRow(o[1]);
}

core.int buildCounterTable = 0;
buildTable() {
  var o = new api.Table();
  buildCounterTable++;
  if (buildCounterTable < 3) {
    o.columnHeaders = buildHeaders();
    o.name = "foo";
    o.rowHeaders = buildHeaders();
    o.rows = buildUnnamed353();
  }
  buildCounterTable--;
  return o;
}

checkTable(api.Table o) {
  buildCounterTable++;
  if (buildCounterTable < 3) {
    checkHeaders(o.columnHeaders);
    unittest.expect(o.name, unittest.equals('foo'));
    checkHeaders(o.rowHeaders);
    checkUnnamed353(o.rows);
  }
  buildCounterTable--;
}

buildUnnamed354() {
  var o = new core.List<api.TestOrderLineItem>();
  o.add(buildTestOrderLineItem());
  o.add(buildTestOrderLineItem());
  return o;
}

checkUnnamed354(core.List<api.TestOrderLineItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTestOrderLineItem(o[0]);
  checkTestOrderLineItem(o[1]);
}

buildUnnamed355() {
  var o = new core.List<api.OrderPromotion>();
  o.add(buildOrderPromotion());
  o.add(buildOrderPromotion());
  return o;
}

checkUnnamed355(core.List<api.OrderPromotion> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderPromotion(o[0]);
  checkOrderPromotion(o[1]);
}

core.int buildCounterTestOrder = 0;
buildTestOrder() {
  var o = new api.TestOrder();
  buildCounterTestOrder++;
  if (buildCounterTestOrder < 3) {
    o.customer = buildTestOrderCustomer();
    o.kind = "foo";
    o.lineItems = buildUnnamed354();
    o.paymentMethod = buildTestOrderPaymentMethod();
    o.predefinedDeliveryAddress = "foo";
    o.promotions = buildUnnamed355();
    o.shippingCost = buildPrice();
    o.shippingCostTax = buildPrice();
    o.shippingOption = "foo";
  }
  buildCounterTestOrder--;
  return o;
}

checkTestOrder(api.TestOrder o) {
  buildCounterTestOrder++;
  if (buildCounterTestOrder < 3) {
    checkTestOrderCustomer(o.customer);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed354(o.lineItems);
    checkTestOrderPaymentMethod(o.paymentMethod);
    unittest.expect(o.predefinedDeliveryAddress, unittest.equals('foo'));
    checkUnnamed355(o.promotions);
    checkPrice(o.shippingCost);
    checkPrice(o.shippingCostTax);
    unittest.expect(o.shippingOption, unittest.equals('foo'));
  }
  buildCounterTestOrder--;
}

core.int buildCounterTestOrderCustomer = 0;
buildTestOrderCustomer() {
  var o = new api.TestOrderCustomer();
  buildCounterTestOrderCustomer++;
  if (buildCounterTestOrderCustomer < 3) {
    o.email = "foo";
    o.explicitMarketingPreference = true;
    o.fullName = "foo";
  }
  buildCounterTestOrderCustomer--;
  return o;
}

checkTestOrderCustomer(api.TestOrderCustomer o) {
  buildCounterTestOrderCustomer++;
  if (buildCounterTestOrderCustomer < 3) {
    unittest.expect(o.email, unittest.equals('foo'));
    unittest.expect(o.explicitMarketingPreference, unittest.isTrue);
    unittest.expect(o.fullName, unittest.equals('foo'));
  }
  buildCounterTestOrderCustomer--;
}

core.int buildCounterTestOrderLineItem = 0;
buildTestOrderLineItem() {
  var o = new api.TestOrderLineItem();
  buildCounterTestOrderLineItem++;
  if (buildCounterTestOrderLineItem < 3) {
    o.product = buildTestOrderLineItemProduct();
    o.quantityOrdered = 42;
    o.returnInfo = buildOrderLineItemReturnInfo();
    o.shippingDetails = buildOrderLineItemShippingDetails();
    o.unitTax = buildPrice();
  }
  buildCounterTestOrderLineItem--;
  return o;
}

checkTestOrderLineItem(api.TestOrderLineItem o) {
  buildCounterTestOrderLineItem++;
  if (buildCounterTestOrderLineItem < 3) {
    checkTestOrderLineItemProduct(o.product);
    unittest.expect(o.quantityOrdered, unittest.equals(42));
    checkOrderLineItemReturnInfo(o.returnInfo);
    checkOrderLineItemShippingDetails(o.shippingDetails);
    checkPrice(o.unitTax);
  }
  buildCounterTestOrderLineItem--;
}

buildUnnamed356() {
  var o = new core.List<api.OrderLineItemProductVariantAttribute>();
  o.add(buildOrderLineItemProductVariantAttribute());
  o.add(buildOrderLineItemProductVariantAttribute());
  return o;
}

checkUnnamed356(core.List<api.OrderLineItemProductVariantAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderLineItemProductVariantAttribute(o[0]);
  checkOrderLineItemProductVariantAttribute(o[1]);
}

core.int buildCounterTestOrderLineItemProduct = 0;
buildTestOrderLineItemProduct() {
  var o = new api.TestOrderLineItemProduct();
  buildCounterTestOrderLineItemProduct++;
  if (buildCounterTestOrderLineItemProduct < 3) {
    o.brand = "foo";
    o.channel = "foo";
    o.condition = "foo";
    o.contentLanguage = "foo";
    o.gtin = "foo";
    o.imageLink = "foo";
    o.itemGroupId = "foo";
    o.mpn = "foo";
    o.offerId = "foo";
    o.price = buildPrice();
    o.targetCountry = "foo";
    o.title = "foo";
    o.variantAttributes = buildUnnamed356();
  }
  buildCounterTestOrderLineItemProduct--;
  return o;
}

checkTestOrderLineItemProduct(api.TestOrderLineItemProduct o) {
  buildCounterTestOrderLineItemProduct++;
  if (buildCounterTestOrderLineItemProduct < 3) {
    unittest.expect(o.brand, unittest.equals('foo'));
    unittest.expect(o.channel, unittest.equals('foo'));
    unittest.expect(o.condition, unittest.equals('foo'));
    unittest.expect(o.contentLanguage, unittest.equals('foo'));
    unittest.expect(o.gtin, unittest.equals('foo'));
    unittest.expect(o.imageLink, unittest.equals('foo'));
    unittest.expect(o.itemGroupId, unittest.equals('foo'));
    unittest.expect(o.mpn, unittest.equals('foo'));
    unittest.expect(o.offerId, unittest.equals('foo'));
    checkPrice(o.price);
    unittest.expect(o.targetCountry, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    checkUnnamed356(o.variantAttributes);
  }
  buildCounterTestOrderLineItemProduct--;
}

core.int buildCounterTestOrderPaymentMethod = 0;
buildTestOrderPaymentMethod() {
  var o = new api.TestOrderPaymentMethod();
  buildCounterTestOrderPaymentMethod++;
  if (buildCounterTestOrderPaymentMethod < 3) {
    o.expirationMonth = 42;
    o.expirationYear = 42;
    o.lastFourDigits = "foo";
    o.predefinedBillingAddress = "foo";
    o.type = "foo";
  }
  buildCounterTestOrderPaymentMethod--;
  return o;
}

checkTestOrderPaymentMethod(api.TestOrderPaymentMethod o) {
  buildCounterTestOrderPaymentMethod++;
  if (buildCounterTestOrderPaymentMethod < 3) {
    unittest.expect(o.expirationMonth, unittest.equals(42));
    unittest.expect(o.expirationYear, unittest.equals(42));
    unittest.expect(o.lastFourDigits, unittest.equals('foo'));
    unittest.expect(o.predefinedBillingAddress, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterTestOrderPaymentMethod--;
}

core.int buildCounterValue = 0;
buildValue() {
  var o = new api.Value();
  buildCounterValue++;
  if (buildCounterValue < 3) {
    o.carrierRateName = "foo";
    o.flatRate = buildPrice();
    o.noShipping = true;
    o.pricePercentage = "foo";
    o.subtableName = "foo";
  }
  buildCounterValue--;
  return o;
}

checkValue(api.Value o) {
  buildCounterValue++;
  if (buildCounterValue < 3) {
    unittest.expect(o.carrierRateName, unittest.equals('foo'));
    checkPrice(o.flatRate);
    unittest.expect(o.noShipping, unittest.isTrue);
    unittest.expect(o.pricePercentage, unittest.equals('foo'));
    unittest.expect(o.subtableName, unittest.equals('foo'));
  }
  buildCounterValue--;
}

core.int buildCounterWeight = 0;
buildWeight() {
  var o = new api.Weight();
  buildCounterWeight++;
  if (buildCounterWeight < 3) {
    o.unit = "foo";
    o.value = "foo";
  }
  buildCounterWeight--;
  return o;
}

checkWeight(api.Weight o) {
  buildCounterWeight++;
  if (buildCounterWeight < 3) {
    unittest.expect(o.unit, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterWeight--;
}

buildUnnamed357() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed357(core.List<core.String> o) {
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


  unittest.group("obj-schema-AccountAdwordsLink", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountAdwordsLink();
      var od = new api.AccountAdwordsLink.fromJson(o.toJson());
      checkAccountAdwordsLink(od);
    });
  });


  unittest.group("obj-schema-AccountIdentifier", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountIdentifier();
      var od = new api.AccountIdentifier.fromJson(o.toJson());
      checkAccountIdentifier(od);
    });
  });


  unittest.group("obj-schema-AccountShipping", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountShipping();
      var od = new api.AccountShipping.fromJson(o.toJson());
      checkAccountShipping(od);
    });
  });


  unittest.group("obj-schema-AccountShippingCarrierRate", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountShippingCarrierRate();
      var od = new api.AccountShippingCarrierRate.fromJson(o.toJson());
      checkAccountShippingCarrierRate(od);
    });
  });


  unittest.group("obj-schema-AccountShippingCondition", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountShippingCondition();
      var od = new api.AccountShippingCondition.fromJson(o.toJson());
      checkAccountShippingCondition(od);
    });
  });


  unittest.group("obj-schema-AccountShippingLocationGroup", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountShippingLocationGroup();
      var od = new api.AccountShippingLocationGroup.fromJson(o.toJson());
      checkAccountShippingLocationGroup(od);
    });
  });


  unittest.group("obj-schema-AccountShippingPostalCodeRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountShippingPostalCodeRange();
      var od = new api.AccountShippingPostalCodeRange.fromJson(o.toJson());
      checkAccountShippingPostalCodeRange(od);
    });
  });


  unittest.group("obj-schema-AccountShippingRateTable", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountShippingRateTable();
      var od = new api.AccountShippingRateTable.fromJson(o.toJson());
      checkAccountShippingRateTable(od);
    });
  });


  unittest.group("obj-schema-AccountShippingRateTableCell", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountShippingRateTableCell();
      var od = new api.AccountShippingRateTableCell.fromJson(o.toJson());
      checkAccountShippingRateTableCell(od);
    });
  });


  unittest.group("obj-schema-AccountShippingShippingService", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountShippingShippingService();
      var od = new api.AccountShippingShippingService.fromJson(o.toJson());
      checkAccountShippingShippingService(od);
    });
  });


  unittest.group("obj-schema-AccountShippingShippingServiceCalculationMethod", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountShippingShippingServiceCalculationMethod();
      var od = new api.AccountShippingShippingServiceCalculationMethod.fromJson(o.toJson());
      checkAccountShippingShippingServiceCalculationMethod(od);
    });
  });


  unittest.group("obj-schema-AccountShippingShippingServiceCostRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountShippingShippingServiceCostRule();
      var od = new api.AccountShippingShippingServiceCostRule.fromJson(o.toJson());
      checkAccountShippingShippingServiceCostRule(od);
    });
  });


  unittest.group("obj-schema-AccountStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountStatus();
      var od = new api.AccountStatus.fromJson(o.toJson());
      checkAccountStatus(od);
    });
  });


  unittest.group("obj-schema-AccountStatusDataQualityIssue", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountStatusDataQualityIssue();
      var od = new api.AccountStatusDataQualityIssue.fromJson(o.toJson());
      checkAccountStatusDataQualityIssue(od);
    });
  });


  unittest.group("obj-schema-AccountStatusExampleItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountStatusExampleItem();
      var od = new api.AccountStatusExampleItem.fromJson(o.toJson());
      checkAccountStatusExampleItem(od);
    });
  });


  unittest.group("obj-schema-AccountTax", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountTax();
      var od = new api.AccountTax.fromJson(o.toJson());
      checkAccountTax(od);
    });
  });


  unittest.group("obj-schema-AccountTaxTaxRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountTaxTaxRule();
      var od = new api.AccountTaxTaxRule.fromJson(o.toJson());
      checkAccountTaxTaxRule(od);
    });
  });


  unittest.group("obj-schema-AccountUser", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountUser();
      var od = new api.AccountUser.fromJson(o.toJson());
      checkAccountUser(od);
    });
  });


  unittest.group("obj-schema-AccountsAuthInfoResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountsAuthInfoResponse();
      var od = new api.AccountsAuthInfoResponse.fromJson(o.toJson());
      checkAccountsAuthInfoResponse(od);
    });
  });


  unittest.group("obj-schema-AccountsCustomBatchRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountsCustomBatchRequest();
      var od = new api.AccountsCustomBatchRequest.fromJson(o.toJson());
      checkAccountsCustomBatchRequest(od);
    });
  });


  unittest.group("obj-schema-AccountsCustomBatchRequestEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountsCustomBatchRequestEntry();
      var od = new api.AccountsCustomBatchRequestEntry.fromJson(o.toJson());
      checkAccountsCustomBatchRequestEntry(od);
    });
  });


  unittest.group("obj-schema-AccountsCustomBatchResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountsCustomBatchResponse();
      var od = new api.AccountsCustomBatchResponse.fromJson(o.toJson());
      checkAccountsCustomBatchResponse(od);
    });
  });


  unittest.group("obj-schema-AccountsCustomBatchResponseEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountsCustomBatchResponseEntry();
      var od = new api.AccountsCustomBatchResponseEntry.fromJson(o.toJson());
      checkAccountsCustomBatchResponseEntry(od);
    });
  });


  unittest.group("obj-schema-AccountsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountsListResponse();
      var od = new api.AccountsListResponse.fromJson(o.toJson());
      checkAccountsListResponse(od);
    });
  });


  unittest.group("obj-schema-AccountshippingCustomBatchRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountshippingCustomBatchRequest();
      var od = new api.AccountshippingCustomBatchRequest.fromJson(o.toJson());
      checkAccountshippingCustomBatchRequest(od);
    });
  });


  unittest.group("obj-schema-AccountshippingCustomBatchRequestEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountshippingCustomBatchRequestEntry();
      var od = new api.AccountshippingCustomBatchRequestEntry.fromJson(o.toJson());
      checkAccountshippingCustomBatchRequestEntry(od);
    });
  });


  unittest.group("obj-schema-AccountshippingCustomBatchResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountshippingCustomBatchResponse();
      var od = new api.AccountshippingCustomBatchResponse.fromJson(o.toJson());
      checkAccountshippingCustomBatchResponse(od);
    });
  });


  unittest.group("obj-schema-AccountshippingCustomBatchResponseEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountshippingCustomBatchResponseEntry();
      var od = new api.AccountshippingCustomBatchResponseEntry.fromJson(o.toJson());
      checkAccountshippingCustomBatchResponseEntry(od);
    });
  });


  unittest.group("obj-schema-AccountshippingListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountshippingListResponse();
      var od = new api.AccountshippingListResponse.fromJson(o.toJson());
      checkAccountshippingListResponse(od);
    });
  });


  unittest.group("obj-schema-AccountstatusesCustomBatchRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountstatusesCustomBatchRequest();
      var od = new api.AccountstatusesCustomBatchRequest.fromJson(o.toJson());
      checkAccountstatusesCustomBatchRequest(od);
    });
  });


  unittest.group("obj-schema-AccountstatusesCustomBatchRequestEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountstatusesCustomBatchRequestEntry();
      var od = new api.AccountstatusesCustomBatchRequestEntry.fromJson(o.toJson());
      checkAccountstatusesCustomBatchRequestEntry(od);
    });
  });


  unittest.group("obj-schema-AccountstatusesCustomBatchResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountstatusesCustomBatchResponse();
      var od = new api.AccountstatusesCustomBatchResponse.fromJson(o.toJson());
      checkAccountstatusesCustomBatchResponse(od);
    });
  });


  unittest.group("obj-schema-AccountstatusesCustomBatchResponseEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountstatusesCustomBatchResponseEntry();
      var od = new api.AccountstatusesCustomBatchResponseEntry.fromJson(o.toJson());
      checkAccountstatusesCustomBatchResponseEntry(od);
    });
  });


  unittest.group("obj-schema-AccountstatusesListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountstatusesListResponse();
      var od = new api.AccountstatusesListResponse.fromJson(o.toJson());
      checkAccountstatusesListResponse(od);
    });
  });


  unittest.group("obj-schema-AccounttaxCustomBatchRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccounttaxCustomBatchRequest();
      var od = new api.AccounttaxCustomBatchRequest.fromJson(o.toJson());
      checkAccounttaxCustomBatchRequest(od);
    });
  });


  unittest.group("obj-schema-AccounttaxCustomBatchRequestEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccounttaxCustomBatchRequestEntry();
      var od = new api.AccounttaxCustomBatchRequestEntry.fromJson(o.toJson());
      checkAccounttaxCustomBatchRequestEntry(od);
    });
  });


  unittest.group("obj-schema-AccounttaxCustomBatchResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccounttaxCustomBatchResponse();
      var od = new api.AccounttaxCustomBatchResponse.fromJson(o.toJson());
      checkAccounttaxCustomBatchResponse(od);
    });
  });


  unittest.group("obj-schema-AccounttaxCustomBatchResponseEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccounttaxCustomBatchResponseEntry();
      var od = new api.AccounttaxCustomBatchResponseEntry.fromJson(o.toJson());
      checkAccounttaxCustomBatchResponseEntry(od);
    });
  });


  unittest.group("obj-schema-AccounttaxListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccounttaxListResponse();
      var od = new api.AccounttaxListResponse.fromJson(o.toJson());
      checkAccounttaxListResponse(od);
    });
  });


  unittest.group("obj-schema-CarrierRate", () {
    unittest.test("to-json--from-json", () {
      var o = buildCarrierRate();
      var od = new api.CarrierRate.fromJson(o.toJson());
      checkCarrierRate(od);
    });
  });


  unittest.group("obj-schema-CarriersCarrier", () {
    unittest.test("to-json--from-json", () {
      var o = buildCarriersCarrier();
      var od = new api.CarriersCarrier.fromJson(o.toJson());
      checkCarriersCarrier(od);
    });
  });


  unittest.group("obj-schema-Datafeed", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeed();
      var od = new api.Datafeed.fromJson(o.toJson());
      checkDatafeed(od);
    });
  });


  unittest.group("obj-schema-DatafeedFetchSchedule", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedFetchSchedule();
      var od = new api.DatafeedFetchSchedule.fromJson(o.toJson());
      checkDatafeedFetchSchedule(od);
    });
  });


  unittest.group("obj-schema-DatafeedFormat", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedFormat();
      var od = new api.DatafeedFormat.fromJson(o.toJson());
      checkDatafeedFormat(od);
    });
  });


  unittest.group("obj-schema-DatafeedStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedStatus();
      var od = new api.DatafeedStatus.fromJson(o.toJson());
      checkDatafeedStatus(od);
    });
  });


  unittest.group("obj-schema-DatafeedStatusError", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedStatusError();
      var od = new api.DatafeedStatusError.fromJson(o.toJson());
      checkDatafeedStatusError(od);
    });
  });


  unittest.group("obj-schema-DatafeedStatusExample", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedStatusExample();
      var od = new api.DatafeedStatusExample.fromJson(o.toJson());
      checkDatafeedStatusExample(od);
    });
  });


  unittest.group("obj-schema-DatafeedsCustomBatchRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedsCustomBatchRequest();
      var od = new api.DatafeedsCustomBatchRequest.fromJson(o.toJson());
      checkDatafeedsCustomBatchRequest(od);
    });
  });


  unittest.group("obj-schema-DatafeedsCustomBatchRequestEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedsCustomBatchRequestEntry();
      var od = new api.DatafeedsCustomBatchRequestEntry.fromJson(o.toJson());
      checkDatafeedsCustomBatchRequestEntry(od);
    });
  });


  unittest.group("obj-schema-DatafeedsCustomBatchResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedsCustomBatchResponse();
      var od = new api.DatafeedsCustomBatchResponse.fromJson(o.toJson());
      checkDatafeedsCustomBatchResponse(od);
    });
  });


  unittest.group("obj-schema-DatafeedsCustomBatchResponseEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedsCustomBatchResponseEntry();
      var od = new api.DatafeedsCustomBatchResponseEntry.fromJson(o.toJson());
      checkDatafeedsCustomBatchResponseEntry(od);
    });
  });


  unittest.group("obj-schema-DatafeedsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedsListResponse();
      var od = new api.DatafeedsListResponse.fromJson(o.toJson());
      checkDatafeedsListResponse(od);
    });
  });


  unittest.group("obj-schema-DatafeedstatusesCustomBatchRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedstatusesCustomBatchRequest();
      var od = new api.DatafeedstatusesCustomBatchRequest.fromJson(o.toJson());
      checkDatafeedstatusesCustomBatchRequest(od);
    });
  });


  unittest.group("obj-schema-DatafeedstatusesCustomBatchRequestEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedstatusesCustomBatchRequestEntry();
      var od = new api.DatafeedstatusesCustomBatchRequestEntry.fromJson(o.toJson());
      checkDatafeedstatusesCustomBatchRequestEntry(od);
    });
  });


  unittest.group("obj-schema-DatafeedstatusesCustomBatchResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedstatusesCustomBatchResponse();
      var od = new api.DatafeedstatusesCustomBatchResponse.fromJson(o.toJson());
      checkDatafeedstatusesCustomBatchResponse(od);
    });
  });


  unittest.group("obj-schema-DatafeedstatusesCustomBatchResponseEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedstatusesCustomBatchResponseEntry();
      var od = new api.DatafeedstatusesCustomBatchResponseEntry.fromJson(o.toJson());
      checkDatafeedstatusesCustomBatchResponseEntry(od);
    });
  });


  unittest.group("obj-schema-DatafeedstatusesListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildDatafeedstatusesListResponse();
      var od = new api.DatafeedstatusesListResponse.fromJson(o.toJson());
      checkDatafeedstatusesListResponse(od);
    });
  });


  unittest.group("obj-schema-DeliveryTime", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeliveryTime();
      var od = new api.DeliveryTime.fromJson(o.toJson());
      checkDeliveryTime(od);
    });
  });


  unittest.group("obj-schema-Error", () {
    unittest.test("to-json--from-json", () {
      var o = buildError();
      var od = new api.Error.fromJson(o.toJson());
      checkError(od);
    });
  });


  unittest.group("obj-schema-Errors", () {
    unittest.test("to-json--from-json", () {
      var o = buildErrors();
      var od = new api.Errors.fromJson(o.toJson());
      checkErrors(od);
    });
  });


  unittest.group("obj-schema-Headers", () {
    unittest.test("to-json--from-json", () {
      var o = buildHeaders();
      var od = new api.Headers.fromJson(o.toJson());
      checkHeaders(od);
    });
  });


  unittest.group("obj-schema-Installment", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstallment();
      var od = new api.Installment.fromJson(o.toJson());
      checkInstallment(od);
    });
  });


  unittest.group("obj-schema-Inventory", () {
    unittest.test("to-json--from-json", () {
      var o = buildInventory();
      var od = new api.Inventory.fromJson(o.toJson());
      checkInventory(od);
    });
  });


  unittest.group("obj-schema-InventoryCustomBatchRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInventoryCustomBatchRequest();
      var od = new api.InventoryCustomBatchRequest.fromJson(o.toJson());
      checkInventoryCustomBatchRequest(od);
    });
  });


  unittest.group("obj-schema-InventoryCustomBatchRequestEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildInventoryCustomBatchRequestEntry();
      var od = new api.InventoryCustomBatchRequestEntry.fromJson(o.toJson());
      checkInventoryCustomBatchRequestEntry(od);
    });
  });


  unittest.group("obj-schema-InventoryCustomBatchResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInventoryCustomBatchResponse();
      var od = new api.InventoryCustomBatchResponse.fromJson(o.toJson());
      checkInventoryCustomBatchResponse(od);
    });
  });


  unittest.group("obj-schema-InventoryCustomBatchResponseEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildInventoryCustomBatchResponseEntry();
      var od = new api.InventoryCustomBatchResponseEntry.fromJson(o.toJson());
      checkInventoryCustomBatchResponseEntry(od);
    });
  });


  unittest.group("obj-schema-InventoryPickup", () {
    unittest.test("to-json--from-json", () {
      var o = buildInventoryPickup();
      var od = new api.InventoryPickup.fromJson(o.toJson());
      checkInventoryPickup(od);
    });
  });


  unittest.group("obj-schema-InventorySetRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInventorySetRequest();
      var od = new api.InventorySetRequest.fromJson(o.toJson());
      checkInventorySetRequest(od);
    });
  });


  unittest.group("obj-schema-InventorySetResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildInventorySetResponse();
      var od = new api.InventorySetResponse.fromJson(o.toJson());
      checkInventorySetResponse(od);
    });
  });


  unittest.group("obj-schema-LocationIdSet", () {
    unittest.test("to-json--from-json", () {
      var o = buildLocationIdSet();
      var od = new api.LocationIdSet.fromJson(o.toJson());
      checkLocationIdSet(od);
    });
  });


  unittest.group("obj-schema-LoyaltyPoints", () {
    unittest.test("to-json--from-json", () {
      var o = buildLoyaltyPoints();
      var od = new api.LoyaltyPoints.fromJson(o.toJson());
      checkLoyaltyPoints(od);
    });
  });


  unittest.group("obj-schema-Order", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrder();
      var od = new api.Order.fromJson(o.toJson());
      checkOrder(od);
    });
  });


  unittest.group("obj-schema-OrderAddress", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderAddress();
      var od = new api.OrderAddress.fromJson(o.toJson());
      checkOrderAddress(od);
    });
  });


  unittest.group("obj-schema-OrderCancellation", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderCancellation();
      var od = new api.OrderCancellation.fromJson(o.toJson());
      checkOrderCancellation(od);
    });
  });


  unittest.group("obj-schema-OrderCustomer", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderCustomer();
      var od = new api.OrderCustomer.fromJson(o.toJson());
      checkOrderCustomer(od);
    });
  });


  unittest.group("obj-schema-OrderDeliveryDetails", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderDeliveryDetails();
      var od = new api.OrderDeliveryDetails.fromJson(o.toJson());
      checkOrderDeliveryDetails(od);
    });
  });


  unittest.group("obj-schema-OrderLineItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderLineItem();
      var od = new api.OrderLineItem.fromJson(o.toJson());
      checkOrderLineItem(od);
    });
  });


  unittest.group("obj-schema-OrderLineItemProduct", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderLineItemProduct();
      var od = new api.OrderLineItemProduct.fromJson(o.toJson());
      checkOrderLineItemProduct(od);
    });
  });


  unittest.group("obj-schema-OrderLineItemProductVariantAttribute", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderLineItemProductVariantAttribute();
      var od = new api.OrderLineItemProductVariantAttribute.fromJson(o.toJson());
      checkOrderLineItemProductVariantAttribute(od);
    });
  });


  unittest.group("obj-schema-OrderLineItemReturnInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderLineItemReturnInfo();
      var od = new api.OrderLineItemReturnInfo.fromJson(o.toJson());
      checkOrderLineItemReturnInfo(od);
    });
  });


  unittest.group("obj-schema-OrderLineItemShippingDetails", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderLineItemShippingDetails();
      var od = new api.OrderLineItemShippingDetails.fromJson(o.toJson());
      checkOrderLineItemShippingDetails(od);
    });
  });


  unittest.group("obj-schema-OrderLineItemShippingDetailsMethod", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderLineItemShippingDetailsMethod();
      var od = new api.OrderLineItemShippingDetailsMethod.fromJson(o.toJson());
      checkOrderLineItemShippingDetailsMethod(od);
    });
  });


  unittest.group("obj-schema-OrderPaymentMethod", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderPaymentMethod();
      var od = new api.OrderPaymentMethod.fromJson(o.toJson());
      checkOrderPaymentMethod(od);
    });
  });


  unittest.group("obj-schema-OrderPromotion", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderPromotion();
      var od = new api.OrderPromotion.fromJson(o.toJson());
      checkOrderPromotion(od);
    });
  });


  unittest.group("obj-schema-OrderPromotionBenefit", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderPromotionBenefit();
      var od = new api.OrderPromotionBenefit.fromJson(o.toJson());
      checkOrderPromotionBenefit(od);
    });
  });


  unittest.group("obj-schema-OrderRefund", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderRefund();
      var od = new api.OrderRefund.fromJson(o.toJson());
      checkOrderRefund(od);
    });
  });


  unittest.group("obj-schema-OrderReturn", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderReturn();
      var od = new api.OrderReturn.fromJson(o.toJson());
      checkOrderReturn(od);
    });
  });


  unittest.group("obj-schema-OrderShipment", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderShipment();
      var od = new api.OrderShipment.fromJson(o.toJson());
      checkOrderShipment(od);
    });
  });


  unittest.group("obj-schema-OrderShipmentLineItemShipment", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrderShipmentLineItemShipment();
      var od = new api.OrderShipmentLineItemShipment.fromJson(o.toJson());
      checkOrderShipmentLineItemShipment(od);
    });
  });


  unittest.group("obj-schema-OrdersAcknowledgeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersAcknowledgeRequest();
      var od = new api.OrdersAcknowledgeRequest.fromJson(o.toJson());
      checkOrdersAcknowledgeRequest(od);
    });
  });


  unittest.group("obj-schema-OrdersAcknowledgeResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersAcknowledgeResponse();
      var od = new api.OrdersAcknowledgeResponse.fromJson(o.toJson());
      checkOrdersAcknowledgeResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersAdvanceTestOrderResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersAdvanceTestOrderResponse();
      var od = new api.OrdersAdvanceTestOrderResponse.fromJson(o.toJson());
      checkOrdersAdvanceTestOrderResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersCancelLineItemRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCancelLineItemRequest();
      var od = new api.OrdersCancelLineItemRequest.fromJson(o.toJson());
      checkOrdersCancelLineItemRequest(od);
    });
  });


  unittest.group("obj-schema-OrdersCancelLineItemResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCancelLineItemResponse();
      var od = new api.OrdersCancelLineItemResponse.fromJson(o.toJson());
      checkOrdersCancelLineItemResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersCancelRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCancelRequest();
      var od = new api.OrdersCancelRequest.fromJson(o.toJson());
      checkOrdersCancelRequest(od);
    });
  });


  unittest.group("obj-schema-OrdersCancelResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCancelResponse();
      var od = new api.OrdersCancelResponse.fromJson(o.toJson());
      checkOrdersCancelResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersCreateTestOrderRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCreateTestOrderRequest();
      var od = new api.OrdersCreateTestOrderRequest.fromJson(o.toJson());
      checkOrdersCreateTestOrderRequest(od);
    });
  });


  unittest.group("obj-schema-OrdersCreateTestOrderResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCreateTestOrderResponse();
      var od = new api.OrdersCreateTestOrderResponse.fromJson(o.toJson());
      checkOrdersCreateTestOrderResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersCustomBatchRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCustomBatchRequest();
      var od = new api.OrdersCustomBatchRequest.fromJson(o.toJson());
      checkOrdersCustomBatchRequest(od);
    });
  });


  unittest.group("obj-schema-OrdersCustomBatchRequestEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCustomBatchRequestEntry();
      var od = new api.OrdersCustomBatchRequestEntry.fromJson(o.toJson());
      checkOrdersCustomBatchRequestEntry(od);
    });
  });


  unittest.group("obj-schema-OrdersCustomBatchRequestEntryCancel", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCustomBatchRequestEntryCancel();
      var od = new api.OrdersCustomBatchRequestEntryCancel.fromJson(o.toJson());
      checkOrdersCustomBatchRequestEntryCancel(od);
    });
  });


  unittest.group("obj-schema-OrdersCustomBatchRequestEntryCancelLineItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCustomBatchRequestEntryCancelLineItem();
      var od = new api.OrdersCustomBatchRequestEntryCancelLineItem.fromJson(o.toJson());
      checkOrdersCustomBatchRequestEntryCancelLineItem(od);
    });
  });


  unittest.group("obj-schema-OrdersCustomBatchRequestEntryRefund", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCustomBatchRequestEntryRefund();
      var od = new api.OrdersCustomBatchRequestEntryRefund.fromJson(o.toJson());
      checkOrdersCustomBatchRequestEntryRefund(od);
    });
  });


  unittest.group("obj-schema-OrdersCustomBatchRequestEntryReturnLineItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCustomBatchRequestEntryReturnLineItem();
      var od = new api.OrdersCustomBatchRequestEntryReturnLineItem.fromJson(o.toJson());
      checkOrdersCustomBatchRequestEntryReturnLineItem(od);
    });
  });


  unittest.group("obj-schema-OrdersCustomBatchRequestEntryShipLineItems", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCustomBatchRequestEntryShipLineItems();
      var od = new api.OrdersCustomBatchRequestEntryShipLineItems.fromJson(o.toJson());
      checkOrdersCustomBatchRequestEntryShipLineItems(od);
    });
  });


  unittest.group("obj-schema-OrdersCustomBatchRequestEntryUpdateShipment", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCustomBatchRequestEntryUpdateShipment();
      var od = new api.OrdersCustomBatchRequestEntryUpdateShipment.fromJson(o.toJson());
      checkOrdersCustomBatchRequestEntryUpdateShipment(od);
    });
  });


  unittest.group("obj-schema-OrdersCustomBatchResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCustomBatchResponse();
      var od = new api.OrdersCustomBatchResponse.fromJson(o.toJson());
      checkOrdersCustomBatchResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersCustomBatchResponseEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersCustomBatchResponseEntry();
      var od = new api.OrdersCustomBatchResponseEntry.fromJson(o.toJson());
      checkOrdersCustomBatchResponseEntry(od);
    });
  });


  unittest.group("obj-schema-OrdersGetByMerchantOrderIdResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersGetByMerchantOrderIdResponse();
      var od = new api.OrdersGetByMerchantOrderIdResponse.fromJson(o.toJson());
      checkOrdersGetByMerchantOrderIdResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersGetTestOrderTemplateResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersGetTestOrderTemplateResponse();
      var od = new api.OrdersGetTestOrderTemplateResponse.fromJson(o.toJson());
      checkOrdersGetTestOrderTemplateResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersListResponse();
      var od = new api.OrdersListResponse.fromJson(o.toJson());
      checkOrdersListResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersRefundRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersRefundRequest();
      var od = new api.OrdersRefundRequest.fromJson(o.toJson());
      checkOrdersRefundRequest(od);
    });
  });


  unittest.group("obj-schema-OrdersRefundResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersRefundResponse();
      var od = new api.OrdersRefundResponse.fromJson(o.toJson());
      checkOrdersRefundResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersReturnLineItemRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersReturnLineItemRequest();
      var od = new api.OrdersReturnLineItemRequest.fromJson(o.toJson());
      checkOrdersReturnLineItemRequest(od);
    });
  });


  unittest.group("obj-schema-OrdersReturnLineItemResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersReturnLineItemResponse();
      var od = new api.OrdersReturnLineItemResponse.fromJson(o.toJson());
      checkOrdersReturnLineItemResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersShipLineItemsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersShipLineItemsRequest();
      var od = new api.OrdersShipLineItemsRequest.fromJson(o.toJson());
      checkOrdersShipLineItemsRequest(od);
    });
  });


  unittest.group("obj-schema-OrdersShipLineItemsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersShipLineItemsResponse();
      var od = new api.OrdersShipLineItemsResponse.fromJson(o.toJson());
      checkOrdersShipLineItemsResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersUpdateMerchantOrderIdRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersUpdateMerchantOrderIdRequest();
      var od = new api.OrdersUpdateMerchantOrderIdRequest.fromJson(o.toJson());
      checkOrdersUpdateMerchantOrderIdRequest(od);
    });
  });


  unittest.group("obj-schema-OrdersUpdateMerchantOrderIdResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersUpdateMerchantOrderIdResponse();
      var od = new api.OrdersUpdateMerchantOrderIdResponse.fromJson(o.toJson());
      checkOrdersUpdateMerchantOrderIdResponse(od);
    });
  });


  unittest.group("obj-schema-OrdersUpdateShipmentRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersUpdateShipmentRequest();
      var od = new api.OrdersUpdateShipmentRequest.fromJson(o.toJson());
      checkOrdersUpdateShipmentRequest(od);
    });
  });


  unittest.group("obj-schema-OrdersUpdateShipmentResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildOrdersUpdateShipmentResponse();
      var od = new api.OrdersUpdateShipmentResponse.fromJson(o.toJson());
      checkOrdersUpdateShipmentResponse(od);
    });
  });


  unittest.group("obj-schema-PostalCodeGroup", () {
    unittest.test("to-json--from-json", () {
      var o = buildPostalCodeGroup();
      var od = new api.PostalCodeGroup.fromJson(o.toJson());
      checkPostalCodeGroup(od);
    });
  });


  unittest.group("obj-schema-PostalCodeRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildPostalCodeRange();
      var od = new api.PostalCodeRange.fromJson(o.toJson());
      checkPostalCodeRange(od);
    });
  });


  unittest.group("obj-schema-Price", () {
    unittest.test("to-json--from-json", () {
      var o = buildPrice();
      var od = new api.Price.fromJson(o.toJson());
      checkPrice(od);
    });
  });


  unittest.group("obj-schema-Product", () {
    unittest.test("to-json--from-json", () {
      var o = buildProduct();
      var od = new api.Product.fromJson(o.toJson());
      checkProduct(od);
    });
  });


  unittest.group("obj-schema-ProductAspect", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductAspect();
      var od = new api.ProductAspect.fromJson(o.toJson());
      checkProductAspect(od);
    });
  });


  unittest.group("obj-schema-ProductCustomAttribute", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductCustomAttribute();
      var od = new api.ProductCustomAttribute.fromJson(o.toJson());
      checkProductCustomAttribute(od);
    });
  });


  unittest.group("obj-schema-ProductCustomGroup", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductCustomGroup();
      var od = new api.ProductCustomGroup.fromJson(o.toJson());
      checkProductCustomGroup(od);
    });
  });


  unittest.group("obj-schema-ProductDestination", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductDestination();
      var od = new api.ProductDestination.fromJson(o.toJson());
      checkProductDestination(od);
    });
  });


  unittest.group("obj-schema-ProductShipping", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductShipping();
      var od = new api.ProductShipping.fromJson(o.toJson());
      checkProductShipping(od);
    });
  });


  unittest.group("obj-schema-ProductShippingDimension", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductShippingDimension();
      var od = new api.ProductShippingDimension.fromJson(o.toJson());
      checkProductShippingDimension(od);
    });
  });


  unittest.group("obj-schema-ProductShippingWeight", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductShippingWeight();
      var od = new api.ProductShippingWeight.fromJson(o.toJson());
      checkProductShippingWeight(od);
    });
  });


  unittest.group("obj-schema-ProductStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductStatus();
      var od = new api.ProductStatus.fromJson(o.toJson());
      checkProductStatus(od);
    });
  });


  unittest.group("obj-schema-ProductStatusDataQualityIssue", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductStatusDataQualityIssue();
      var od = new api.ProductStatusDataQualityIssue.fromJson(o.toJson());
      checkProductStatusDataQualityIssue(od);
    });
  });


  unittest.group("obj-schema-ProductStatusDestinationStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductStatusDestinationStatus();
      var od = new api.ProductStatusDestinationStatus.fromJson(o.toJson());
      checkProductStatusDestinationStatus(od);
    });
  });


  unittest.group("obj-schema-ProductTax", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductTax();
      var od = new api.ProductTax.fromJson(o.toJson());
      checkProductTax(od);
    });
  });


  unittest.group("obj-schema-ProductUnitPricingBaseMeasure", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductUnitPricingBaseMeasure();
      var od = new api.ProductUnitPricingBaseMeasure.fromJson(o.toJson());
      checkProductUnitPricingBaseMeasure(od);
    });
  });


  unittest.group("obj-schema-ProductUnitPricingMeasure", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductUnitPricingMeasure();
      var od = new api.ProductUnitPricingMeasure.fromJson(o.toJson());
      checkProductUnitPricingMeasure(od);
    });
  });


  unittest.group("obj-schema-ProductsCustomBatchRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductsCustomBatchRequest();
      var od = new api.ProductsCustomBatchRequest.fromJson(o.toJson());
      checkProductsCustomBatchRequest(od);
    });
  });


  unittest.group("obj-schema-ProductsCustomBatchRequestEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductsCustomBatchRequestEntry();
      var od = new api.ProductsCustomBatchRequestEntry.fromJson(o.toJson());
      checkProductsCustomBatchRequestEntry(od);
    });
  });


  unittest.group("obj-schema-ProductsCustomBatchResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductsCustomBatchResponse();
      var od = new api.ProductsCustomBatchResponse.fromJson(o.toJson());
      checkProductsCustomBatchResponse(od);
    });
  });


  unittest.group("obj-schema-ProductsCustomBatchResponseEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductsCustomBatchResponseEntry();
      var od = new api.ProductsCustomBatchResponseEntry.fromJson(o.toJson());
      checkProductsCustomBatchResponseEntry(od);
    });
  });


  unittest.group("obj-schema-ProductsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductsListResponse();
      var od = new api.ProductsListResponse.fromJson(o.toJson());
      checkProductsListResponse(od);
    });
  });


  unittest.group("obj-schema-ProductstatusesCustomBatchRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductstatusesCustomBatchRequest();
      var od = new api.ProductstatusesCustomBatchRequest.fromJson(o.toJson());
      checkProductstatusesCustomBatchRequest(od);
    });
  });


  unittest.group("obj-schema-ProductstatusesCustomBatchRequestEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductstatusesCustomBatchRequestEntry();
      var od = new api.ProductstatusesCustomBatchRequestEntry.fromJson(o.toJson());
      checkProductstatusesCustomBatchRequestEntry(od);
    });
  });


  unittest.group("obj-schema-ProductstatusesCustomBatchResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductstatusesCustomBatchResponse();
      var od = new api.ProductstatusesCustomBatchResponse.fromJson(o.toJson());
      checkProductstatusesCustomBatchResponse(od);
    });
  });


  unittest.group("obj-schema-ProductstatusesCustomBatchResponseEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductstatusesCustomBatchResponseEntry();
      var od = new api.ProductstatusesCustomBatchResponseEntry.fromJson(o.toJson());
      checkProductstatusesCustomBatchResponseEntry(od);
    });
  });


  unittest.group("obj-schema-ProductstatusesListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildProductstatusesListResponse();
      var od = new api.ProductstatusesListResponse.fromJson(o.toJson());
      checkProductstatusesListResponse(od);
    });
  });


  unittest.group("obj-schema-RateGroup", () {
    unittest.test("to-json--from-json", () {
      var o = buildRateGroup();
      var od = new api.RateGroup.fromJson(o.toJson());
      checkRateGroup(od);
    });
  });


  unittest.group("obj-schema-Row", () {
    unittest.test("to-json--from-json", () {
      var o = buildRow();
      var od = new api.Row.fromJson(o.toJson());
      checkRow(od);
    });
  });


  unittest.group("obj-schema-Service", () {
    unittest.test("to-json--from-json", () {
      var o = buildService();
      var od = new api.Service.fromJson(o.toJson());
      checkService(od);
    });
  });


  unittest.group("obj-schema-ShippingSettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildShippingSettings();
      var od = new api.ShippingSettings.fromJson(o.toJson());
      checkShippingSettings(od);
    });
  });


  unittest.group("obj-schema-ShippingsettingsCustomBatchRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildShippingsettingsCustomBatchRequest();
      var od = new api.ShippingsettingsCustomBatchRequest.fromJson(o.toJson());
      checkShippingsettingsCustomBatchRequest(od);
    });
  });


  unittest.group("obj-schema-ShippingsettingsCustomBatchRequestEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildShippingsettingsCustomBatchRequestEntry();
      var od = new api.ShippingsettingsCustomBatchRequestEntry.fromJson(o.toJson());
      checkShippingsettingsCustomBatchRequestEntry(od);
    });
  });


  unittest.group("obj-schema-ShippingsettingsCustomBatchResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildShippingsettingsCustomBatchResponse();
      var od = new api.ShippingsettingsCustomBatchResponse.fromJson(o.toJson());
      checkShippingsettingsCustomBatchResponse(od);
    });
  });


  unittest.group("obj-schema-ShippingsettingsCustomBatchResponseEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildShippingsettingsCustomBatchResponseEntry();
      var od = new api.ShippingsettingsCustomBatchResponseEntry.fromJson(o.toJson());
      checkShippingsettingsCustomBatchResponseEntry(od);
    });
  });


  unittest.group("obj-schema-ShippingsettingsGetSupportedCarriersResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildShippingsettingsGetSupportedCarriersResponse();
      var od = new api.ShippingsettingsGetSupportedCarriersResponse.fromJson(o.toJson());
      checkShippingsettingsGetSupportedCarriersResponse(od);
    });
  });


  unittest.group("obj-schema-ShippingsettingsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildShippingsettingsListResponse();
      var od = new api.ShippingsettingsListResponse.fromJson(o.toJson());
      checkShippingsettingsListResponse(od);
    });
  });


  unittest.group("obj-schema-Table", () {
    unittest.test("to-json--from-json", () {
      var o = buildTable();
      var od = new api.Table.fromJson(o.toJson());
      checkTable(od);
    });
  });


  unittest.group("obj-schema-TestOrder", () {
    unittest.test("to-json--from-json", () {
      var o = buildTestOrder();
      var od = new api.TestOrder.fromJson(o.toJson());
      checkTestOrder(od);
    });
  });


  unittest.group("obj-schema-TestOrderCustomer", () {
    unittest.test("to-json--from-json", () {
      var o = buildTestOrderCustomer();
      var od = new api.TestOrderCustomer.fromJson(o.toJson());
      checkTestOrderCustomer(od);
    });
  });


  unittest.group("obj-schema-TestOrderLineItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildTestOrderLineItem();
      var od = new api.TestOrderLineItem.fromJson(o.toJson());
      checkTestOrderLineItem(od);
    });
  });


  unittest.group("obj-schema-TestOrderLineItemProduct", () {
    unittest.test("to-json--from-json", () {
      var o = buildTestOrderLineItemProduct();
      var od = new api.TestOrderLineItemProduct.fromJson(o.toJson());
      checkTestOrderLineItemProduct(od);
    });
  });


  unittest.group("obj-schema-TestOrderPaymentMethod", () {
    unittest.test("to-json--from-json", () {
      var o = buildTestOrderPaymentMethod();
      var od = new api.TestOrderPaymentMethod.fromJson(o.toJson());
      checkTestOrderPaymentMethod(od);
    });
  });


  unittest.group("obj-schema-Value", () {
    unittest.test("to-json--from-json", () {
      var o = buildValue();
      var od = new api.Value.fromJson(o.toJson());
      checkValue(od);
    });
  });


  unittest.group("obj-schema-Weight", () {
    unittest.test("to-json--from-json", () {
      var o = buildWeight();
      var od = new api.Weight.fromJson(o.toJson());
      checkWeight(od);
    });
  });


  unittest.group("resource-AccountsResourceApi", () {
    unittest.test("method--authinfo", () {

      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.ContentApi(mock).accounts;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("content/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("accounts/authinfo"));
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
        var resp = convert.JSON.encode(buildAccountsAuthInfoResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.authinfo().then(unittest.expectAsync(((api.AccountsAuthInfoResponse response) {
        checkAccountsAuthInfoResponse(response);
      })));
    });

    unittest.test("method--custombatch", () {

      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.ContentApi(mock).accounts;
      var arg_request = buildAccountsCustomBatchRequest();
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AccountsCustomBatchRequest.fromJson(json);
        checkAccountsCustomBatchRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("content/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("accounts/batch"));
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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAccountsCustomBatchResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.custombatch(arg_request, dryRun: arg_dryRun).then(unittest.expectAsync(((api.AccountsCustomBatchResponse response) {
        checkAccountsCustomBatchResponse(response);
      })));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.ContentApi(mock).accounts;
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_merchantId, arg_accountId, dryRun: arg_dryRun).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.ContentApi(mock).accounts;
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
      res.get(arg_merchantId, arg_accountId).then(unittest.expectAsync(((api.Account response) {
        checkAccount(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.ContentApi(mock).accounts;
      var arg_request = buildAccount();
      var arg_merchantId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Account.fromJson(json);
        checkAccount(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAccount());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_merchantId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.Account response) {
        checkAccount(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.ContentApi(mock).accounts;
      var arg_merchantId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildAccountsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_merchantId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.AccountsListResponse response) {
        checkAccountsListResponse(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.ContentApi(mock).accounts;
      var arg_request = buildAccount();
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Account.fromJson(json);
        checkAccount(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAccount());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_merchantId, arg_accountId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.Account response) {
        checkAccount(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.ContentApi(mock).accounts;
      var arg_request = buildAccount();
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Account.fromJson(json);
        checkAccount(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAccount());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_merchantId, arg_accountId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.Account response) {
        checkAccount(response);
      })));
    });

  });


  unittest.group("resource-AccountshippingResourceApi", () {
    unittest.test("method--custombatch", () {

      var mock = new HttpServerMock();
      api.AccountshippingResourceApi res = new api.ContentApi(mock).accountshipping;
      var arg_request = buildAccountshippingCustomBatchRequest();
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AccountshippingCustomBatchRequest.fromJson(json);
        checkAccountshippingCustomBatchRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("content/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("accountshipping/batch"));
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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAccountshippingCustomBatchResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.custombatch(arg_request, dryRun: arg_dryRun).then(unittest.expectAsync(((api.AccountshippingCustomBatchResponse response) {
        checkAccountshippingCustomBatchResponse(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.AccountshippingResourceApi res = new api.ContentApi(mock).accountshipping;
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildAccountShipping());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_merchantId, arg_accountId).then(unittest.expectAsync(((api.AccountShipping response) {
        checkAccountShipping(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.AccountshippingResourceApi res = new api.ContentApi(mock).accountshipping;
      var arg_merchantId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildAccountshippingListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_merchantId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.AccountshippingListResponse response) {
        checkAccountshippingListResponse(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.AccountshippingResourceApi res = new api.ContentApi(mock).accountshipping;
      var arg_request = buildAccountShipping();
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AccountShipping.fromJson(json);
        checkAccountShipping(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAccountShipping());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_merchantId, arg_accountId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.AccountShipping response) {
        checkAccountShipping(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.AccountshippingResourceApi res = new api.ContentApi(mock).accountshipping;
      var arg_request = buildAccountShipping();
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AccountShipping.fromJson(json);
        checkAccountShipping(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAccountShipping());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_merchantId, arg_accountId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.AccountShipping response) {
        checkAccountShipping(response);
      })));
    });

  });


  unittest.group("resource-AccountstatusesResourceApi", () {
    unittest.test("method--custombatch", () {

      var mock = new HttpServerMock();
      api.AccountstatusesResourceApi res = new api.ContentApi(mock).accountstatuses;
      var arg_request = buildAccountstatusesCustomBatchRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AccountstatusesCustomBatchRequest.fromJson(json);
        checkAccountstatusesCustomBatchRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("content/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("accountstatuses/batch"));
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
        var resp = convert.JSON.encode(buildAccountstatusesCustomBatchResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.custombatch(arg_request).then(unittest.expectAsync(((api.AccountstatusesCustomBatchResponse response) {
        checkAccountstatusesCustomBatchResponse(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.AccountstatusesResourceApi res = new api.ContentApi(mock).accountstatuses;
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildAccountStatus());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_merchantId, arg_accountId).then(unittest.expectAsync(((api.AccountStatus response) {
        checkAccountStatus(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.AccountstatusesResourceApi res = new api.ContentApi(mock).accountstatuses;
      var arg_merchantId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildAccountstatusesListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_merchantId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.AccountstatusesListResponse response) {
        checkAccountstatusesListResponse(response);
      })));
    });

  });


  unittest.group("resource-AccounttaxResourceApi", () {
    unittest.test("method--custombatch", () {

      var mock = new HttpServerMock();
      api.AccounttaxResourceApi res = new api.ContentApi(mock).accounttax;
      var arg_request = buildAccounttaxCustomBatchRequest();
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AccounttaxCustomBatchRequest.fromJson(json);
        checkAccounttaxCustomBatchRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("content/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("accounttax/batch"));
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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAccounttaxCustomBatchResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.custombatch(arg_request, dryRun: arg_dryRun).then(unittest.expectAsync(((api.AccounttaxCustomBatchResponse response) {
        checkAccounttaxCustomBatchResponse(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.AccounttaxResourceApi res = new api.ContentApi(mock).accounttax;
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildAccountTax());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_merchantId, arg_accountId).then(unittest.expectAsync(((api.AccountTax response) {
        checkAccountTax(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.AccounttaxResourceApi res = new api.ContentApi(mock).accounttax;
      var arg_merchantId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildAccounttaxListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_merchantId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.AccounttaxListResponse response) {
        checkAccounttaxListResponse(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.AccounttaxResourceApi res = new api.ContentApi(mock).accounttax;
      var arg_request = buildAccountTax();
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AccountTax.fromJson(json);
        checkAccountTax(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAccountTax());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_merchantId, arg_accountId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.AccountTax response) {
        checkAccountTax(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.AccounttaxResourceApi res = new api.ContentApi(mock).accounttax;
      var arg_request = buildAccountTax();
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AccountTax.fromJson(json);
        checkAccountTax(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAccountTax());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_merchantId, arg_accountId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.AccountTax response) {
        checkAccountTax(response);
      })));
    });

  });


  unittest.group("resource-DatafeedsResourceApi", () {
    unittest.test("method--custombatch", () {

      var mock = new HttpServerMock();
      api.DatafeedsResourceApi res = new api.ContentApi(mock).datafeeds;
      var arg_request = buildDatafeedsCustomBatchRequest();
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.DatafeedsCustomBatchRequest.fromJson(json);
        checkDatafeedsCustomBatchRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("content/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("datafeeds/batch"));
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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildDatafeedsCustomBatchResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.custombatch(arg_request, dryRun: arg_dryRun).then(unittest.expectAsync(((api.DatafeedsCustomBatchResponse response) {
        checkDatafeedsCustomBatchResponse(response);
      })));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.DatafeedsResourceApi res = new api.ContentApi(mock).datafeeds;
      var arg_merchantId = "foo";
      var arg_datafeedId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_merchantId, arg_datafeedId, dryRun: arg_dryRun).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.DatafeedsResourceApi res = new api.ContentApi(mock).datafeeds;
      var arg_merchantId = "foo";
      var arg_datafeedId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildDatafeed());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_merchantId, arg_datafeedId).then(unittest.expectAsync(((api.Datafeed response) {
        checkDatafeed(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.DatafeedsResourceApi res = new api.ContentApi(mock).datafeeds;
      var arg_request = buildDatafeed();
      var arg_merchantId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Datafeed.fromJson(json);
        checkDatafeed(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildDatafeed());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_merchantId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.Datafeed response) {
        checkDatafeed(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.DatafeedsResourceApi res = new api.ContentApi(mock).datafeeds;
      var arg_merchantId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildDatafeedsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_merchantId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.DatafeedsListResponse response) {
        checkDatafeedsListResponse(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.DatafeedsResourceApi res = new api.ContentApi(mock).datafeeds;
      var arg_request = buildDatafeed();
      var arg_merchantId = "foo";
      var arg_datafeedId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Datafeed.fromJson(json);
        checkDatafeed(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildDatafeed());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_merchantId, arg_datafeedId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.Datafeed response) {
        checkDatafeed(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.DatafeedsResourceApi res = new api.ContentApi(mock).datafeeds;
      var arg_request = buildDatafeed();
      var arg_merchantId = "foo";
      var arg_datafeedId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Datafeed.fromJson(json);
        checkDatafeed(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildDatafeed());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_merchantId, arg_datafeedId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.Datafeed response) {
        checkDatafeed(response);
      })));
    });

  });


  unittest.group("resource-DatafeedstatusesResourceApi", () {
    unittest.test("method--custombatch", () {

      var mock = new HttpServerMock();
      api.DatafeedstatusesResourceApi res = new api.ContentApi(mock).datafeedstatuses;
      var arg_request = buildDatafeedstatusesCustomBatchRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.DatafeedstatusesCustomBatchRequest.fromJson(json);
        checkDatafeedstatusesCustomBatchRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("content/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("datafeedstatuses/batch"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildDatafeedstatusesCustomBatchResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.custombatch(arg_request).then(unittest.expectAsync(((api.DatafeedstatusesCustomBatchResponse response) {
        checkDatafeedstatusesCustomBatchResponse(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.DatafeedstatusesResourceApi res = new api.ContentApi(mock).datafeedstatuses;
      var arg_merchantId = "foo";
      var arg_datafeedId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildDatafeedStatus());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_merchantId, arg_datafeedId).then(unittest.expectAsync(((api.DatafeedStatus response) {
        checkDatafeedStatus(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.DatafeedstatusesResourceApi res = new api.ContentApi(mock).datafeedstatuses;
      var arg_merchantId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildDatafeedstatusesListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_merchantId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.DatafeedstatusesListResponse response) {
        checkDatafeedstatusesListResponse(response);
      })));
    });

  });


  unittest.group("resource-InventoryResourceApi", () {
    unittest.test("method--custombatch", () {

      var mock = new HttpServerMock();
      api.InventoryResourceApi res = new api.ContentApi(mock).inventory;
      var arg_request = buildInventoryCustomBatchRequest();
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.InventoryCustomBatchRequest.fromJson(json);
        checkInventoryCustomBatchRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("content/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("inventory/batch"));
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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildInventoryCustomBatchResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.custombatch(arg_request, dryRun: arg_dryRun).then(unittest.expectAsync(((api.InventoryCustomBatchResponse response) {
        checkInventoryCustomBatchResponse(response);
      })));
    });

    unittest.test("method--set", () {

      var mock = new HttpServerMock();
      api.InventoryResourceApi res = new api.ContentApi(mock).inventory;
      var arg_request = buildInventorySetRequest();
      var arg_merchantId = "foo";
      var arg_storeCode = "foo";
      var arg_productId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.InventorySetRequest.fromJson(json);
        checkInventorySetRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildInventorySetResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.set(arg_request, arg_merchantId, arg_storeCode, arg_productId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.InventorySetResponse response) {
        checkInventorySetResponse(response);
      })));
    });

  });


  unittest.group("resource-OrdersResourceApi", () {
    unittest.test("method--acknowledge", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_request = buildOrdersAcknowledgeRequest();
      var arg_merchantId = "foo";
      var arg_orderId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.OrdersAcknowledgeRequest.fromJson(json);
        checkOrdersAcknowledgeRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrdersAcknowledgeResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.acknowledge(arg_request, arg_merchantId, arg_orderId).then(unittest.expectAsync(((api.OrdersAcknowledgeResponse response) {
        checkOrdersAcknowledgeResponse(response);
      })));
    });

    unittest.test("method--advancetestorder", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_merchantId = "foo";
      var arg_orderId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrdersAdvanceTestOrderResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.advancetestorder(arg_merchantId, arg_orderId).then(unittest.expectAsync(((api.OrdersAdvanceTestOrderResponse response) {
        checkOrdersAdvanceTestOrderResponse(response);
      })));
    });

    unittest.test("method--cancel", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_request = buildOrdersCancelRequest();
      var arg_merchantId = "foo";
      var arg_orderId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.OrdersCancelRequest.fromJson(json);
        checkOrdersCancelRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrdersCancelResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.cancel(arg_request, arg_merchantId, arg_orderId).then(unittest.expectAsync(((api.OrdersCancelResponse response) {
        checkOrdersCancelResponse(response);
      })));
    });

    unittest.test("method--cancellineitem", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_request = buildOrdersCancelLineItemRequest();
      var arg_merchantId = "foo";
      var arg_orderId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.OrdersCancelLineItemRequest.fromJson(json);
        checkOrdersCancelLineItemRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrdersCancelLineItemResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.cancellineitem(arg_request, arg_merchantId, arg_orderId).then(unittest.expectAsync(((api.OrdersCancelLineItemResponse response) {
        checkOrdersCancelLineItemResponse(response);
      })));
    });

    unittest.test("method--createtestorder", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_request = buildOrdersCreateTestOrderRequest();
      var arg_merchantId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.OrdersCreateTestOrderRequest.fromJson(json);
        checkOrdersCreateTestOrderRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrdersCreateTestOrderResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.createtestorder(arg_request, arg_merchantId).then(unittest.expectAsync(((api.OrdersCreateTestOrderResponse response) {
        checkOrdersCreateTestOrderResponse(response);
      })));
    });

    unittest.test("method--custombatch", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_request = buildOrdersCustomBatchRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.OrdersCustomBatchRequest.fromJson(json);
        checkOrdersCustomBatchRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("content/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("orders/batch"));
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
        var resp = convert.JSON.encode(buildOrdersCustomBatchResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.custombatch(arg_request).then(unittest.expectAsync(((api.OrdersCustomBatchResponse response) {
        checkOrdersCustomBatchResponse(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_merchantId = "foo";
      var arg_orderId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrder());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_merchantId, arg_orderId).then(unittest.expectAsync(((api.Order response) {
        checkOrder(response);
      })));
    });

    unittest.test("method--getbymerchantorderid", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_merchantId = "foo";
      var arg_merchantOrderId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrdersGetByMerchantOrderIdResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getbymerchantorderid(arg_merchantId, arg_merchantOrderId).then(unittest.expectAsync(((api.OrdersGetByMerchantOrderIdResponse response) {
        checkOrdersGetByMerchantOrderIdResponse(response);
      })));
    });

    unittest.test("method--gettestordertemplate", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_merchantId = "foo";
      var arg_templateName = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrdersGetTestOrderTemplateResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.gettestordertemplate(arg_merchantId, arg_templateName).then(unittest.expectAsync(((api.OrdersGetTestOrderTemplateResponse response) {
        checkOrdersGetTestOrderTemplateResponse(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_merchantId = "foo";
      var arg_acknowledged = true;
      var arg_maxResults = 42;
      var arg_orderBy = "foo";
      var arg_pageToken = "foo";
      var arg_placedDateEnd = "foo";
      var arg_placedDateStart = "foo";
      var arg_statuses = buildUnnamed357();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["acknowledged"].first, unittest.equals("$arg_acknowledged"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["orderBy"].first, unittest.equals(arg_orderBy));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["placedDateEnd"].first, unittest.equals(arg_placedDateEnd));
        unittest.expect(queryMap["placedDateStart"].first, unittest.equals(arg_placedDateStart));
        unittest.expect(queryMap["statuses"], unittest.equals(arg_statuses));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOrdersListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_merchantId, acknowledged: arg_acknowledged, maxResults: arg_maxResults, orderBy: arg_orderBy, pageToken: arg_pageToken, placedDateEnd: arg_placedDateEnd, placedDateStart: arg_placedDateStart, statuses: arg_statuses).then(unittest.expectAsync(((api.OrdersListResponse response) {
        checkOrdersListResponse(response);
      })));
    });

    unittest.test("method--refund", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_request = buildOrdersRefundRequest();
      var arg_merchantId = "foo";
      var arg_orderId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.OrdersRefundRequest.fromJson(json);
        checkOrdersRefundRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrdersRefundResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.refund(arg_request, arg_merchantId, arg_orderId).then(unittest.expectAsync(((api.OrdersRefundResponse response) {
        checkOrdersRefundResponse(response);
      })));
    });

    unittest.test("method--returnlineitem", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_request = buildOrdersReturnLineItemRequest();
      var arg_merchantId = "foo";
      var arg_orderId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.OrdersReturnLineItemRequest.fromJson(json);
        checkOrdersReturnLineItemRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrdersReturnLineItemResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.returnlineitem(arg_request, arg_merchantId, arg_orderId).then(unittest.expectAsync(((api.OrdersReturnLineItemResponse response) {
        checkOrdersReturnLineItemResponse(response);
      })));
    });

    unittest.test("method--shiplineitems", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_request = buildOrdersShipLineItemsRequest();
      var arg_merchantId = "foo";
      var arg_orderId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.OrdersShipLineItemsRequest.fromJson(json);
        checkOrdersShipLineItemsRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrdersShipLineItemsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.shiplineitems(arg_request, arg_merchantId, arg_orderId).then(unittest.expectAsync(((api.OrdersShipLineItemsResponse response) {
        checkOrdersShipLineItemsResponse(response);
      })));
    });

    unittest.test("method--updatemerchantorderid", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_request = buildOrdersUpdateMerchantOrderIdRequest();
      var arg_merchantId = "foo";
      var arg_orderId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.OrdersUpdateMerchantOrderIdRequest.fromJson(json);
        checkOrdersUpdateMerchantOrderIdRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrdersUpdateMerchantOrderIdResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.updatemerchantorderid(arg_request, arg_merchantId, arg_orderId).then(unittest.expectAsync(((api.OrdersUpdateMerchantOrderIdResponse response) {
        checkOrdersUpdateMerchantOrderIdResponse(response);
      })));
    });

    unittest.test("method--updateshipment", () {

      var mock = new HttpServerMock();
      api.OrdersResourceApi res = new api.ContentApi(mock).orders;
      var arg_request = buildOrdersUpdateShipmentRequest();
      var arg_merchantId = "foo";
      var arg_orderId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.OrdersUpdateShipmentRequest.fromJson(json);
        checkOrdersUpdateShipmentRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOrdersUpdateShipmentResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.updateshipment(arg_request, arg_merchantId, arg_orderId).then(unittest.expectAsync(((api.OrdersUpdateShipmentResponse response) {
        checkOrdersUpdateShipmentResponse(response);
      })));
    });

  });


  unittest.group("resource-ProductsResourceApi", () {
    unittest.test("method--custombatch", () {

      var mock = new HttpServerMock();
      api.ProductsResourceApi res = new api.ContentApi(mock).products;
      var arg_request = buildProductsCustomBatchRequest();
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ProductsCustomBatchRequest.fromJson(json);
        checkProductsCustomBatchRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("content/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("products/batch"));
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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildProductsCustomBatchResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.custombatch(arg_request, dryRun: arg_dryRun).then(unittest.expectAsync(((api.ProductsCustomBatchResponse response) {
        checkProductsCustomBatchResponse(response);
      })));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.ProductsResourceApi res = new api.ContentApi(mock).products;
      var arg_merchantId = "foo";
      var arg_productId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_merchantId, arg_productId, dryRun: arg_dryRun).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.ProductsResourceApi res = new api.ContentApi(mock).products;
      var arg_merchantId = "foo";
      var arg_productId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildProduct());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_merchantId, arg_productId).then(unittest.expectAsync(((api.Product response) {
        checkProduct(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.ProductsResourceApi res = new api.ContentApi(mock).products;
      var arg_request = buildProduct();
      var arg_merchantId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Product.fromJson(json);
        checkProduct(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildProduct());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_merchantId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.Product response) {
        checkProduct(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.ProductsResourceApi res = new api.ContentApi(mock).products;
      var arg_merchantId = "foo";
      var arg_includeInvalidInsertedItems = true;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["includeInvalidInsertedItems"].first, unittest.equals("$arg_includeInvalidInsertedItems"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildProductsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_merchantId, includeInvalidInsertedItems: arg_includeInvalidInsertedItems, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.ProductsListResponse response) {
        checkProductsListResponse(response);
      })));
    });

  });


  unittest.group("resource-ProductstatusesResourceApi", () {
    unittest.test("method--custombatch", () {

      var mock = new HttpServerMock();
      api.ProductstatusesResourceApi res = new api.ContentApi(mock).productstatuses;
      var arg_request = buildProductstatusesCustomBatchRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ProductstatusesCustomBatchRequest.fromJson(json);
        checkProductstatusesCustomBatchRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("content/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("productstatuses/batch"));
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
        var resp = convert.JSON.encode(buildProductstatusesCustomBatchResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.custombatch(arg_request).then(unittest.expectAsync(((api.ProductstatusesCustomBatchResponse response) {
        checkProductstatusesCustomBatchResponse(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.ProductstatusesResourceApi res = new api.ContentApi(mock).productstatuses;
      var arg_merchantId = "foo";
      var arg_productId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildProductStatus());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_merchantId, arg_productId).then(unittest.expectAsync(((api.ProductStatus response) {
        checkProductStatus(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.ProductstatusesResourceApi res = new api.ContentApi(mock).productstatuses;
      var arg_merchantId = "foo";
      var arg_includeInvalidInsertedItems = true;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["includeInvalidInsertedItems"].first, unittest.equals("$arg_includeInvalidInsertedItems"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildProductstatusesListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_merchantId, includeInvalidInsertedItems: arg_includeInvalidInsertedItems, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.ProductstatusesListResponse response) {
        checkProductstatusesListResponse(response);
      })));
    });

  });


  unittest.group("resource-ShippingsettingsResourceApi", () {
    unittest.test("method--custombatch", () {

      var mock = new HttpServerMock();
      api.ShippingsettingsResourceApi res = new api.ContentApi(mock).shippingsettings;
      var arg_request = buildShippingsettingsCustomBatchRequest();
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ShippingsettingsCustomBatchRequest.fromJson(json);
        checkShippingsettingsCustomBatchRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("content/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("shippingsettings/batch"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildShippingsettingsCustomBatchResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.custombatch(arg_request, dryRun: arg_dryRun).then(unittest.expectAsync(((api.ShippingsettingsCustomBatchResponse response) {
        checkShippingsettingsCustomBatchResponse(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.ShippingsettingsResourceApi res = new api.ContentApi(mock).shippingsettings;
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildShippingSettings());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_merchantId, arg_accountId).then(unittest.expectAsync(((api.ShippingSettings response) {
        checkShippingSettings(response);
      })));
    });

    unittest.test("method--getsupportedcarriers", () {

      var mock = new HttpServerMock();
      api.ShippingsettingsResourceApi res = new api.ContentApi(mock).shippingsettings;
      var arg_merchantId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildShippingsettingsGetSupportedCarriersResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getsupportedcarriers(arg_merchantId).then(unittest.expectAsync(((api.ShippingsettingsGetSupportedCarriersResponse response) {
        checkShippingsettingsGetSupportedCarriersResponse(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.ShippingsettingsResourceApi res = new api.ContentApi(mock).shippingsettings;
      var arg_merchantId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildShippingsettingsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_merchantId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.ShippingsettingsListResponse response) {
        checkShippingsettingsListResponse(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.ShippingsettingsResourceApi res = new api.ContentApi(mock).shippingsettings;
      var arg_request = buildShippingSettings();
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ShippingSettings.fromJson(json);
        checkShippingSettings(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildShippingSettings());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_merchantId, arg_accountId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.ShippingSettings response) {
        checkShippingSettings(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.ShippingsettingsResourceApi res = new api.ContentApi(mock).shippingsettings;
      var arg_request = buildShippingSettings();
      var arg_merchantId = "foo";
      var arg_accountId = "foo";
      var arg_dryRun = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ShippingSettings.fromJson(json);
        checkShippingSettings(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["dryRun"].first, unittest.equals("$arg_dryRun"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildShippingSettings());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_merchantId, arg_accountId, dryRun: arg_dryRun).then(unittest.expectAsync(((api.ShippingSettings response) {
        checkShippingSettings(response);
      })));
    });

  });


}

