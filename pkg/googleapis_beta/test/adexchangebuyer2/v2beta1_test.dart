library googleapis_beta.adexchangebuyer2.v2beta1.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis_beta/adexchangebuyer2/v2beta1.dart' as api;

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

core.int buildCounterAbsoluteDateRange = 0;
buildAbsoluteDateRange() {
  var o = new api.AbsoluteDateRange();
  buildCounterAbsoluteDateRange++;
  if (buildCounterAbsoluteDateRange < 3) {
    o.endDate = buildDate();
    o.startDate = buildDate();
  }
  buildCounterAbsoluteDateRange--;
  return o;
}

checkAbsoluteDateRange(api.AbsoluteDateRange o) {
  buildCounterAbsoluteDateRange++;
  if (buildCounterAbsoluteDateRange < 3) {
    checkDate(o.endDate);
    checkDate(o.startDate);
  }
  buildCounterAbsoluteDateRange--;
}

core.int buildCounterAddDealAssociationRequest = 0;
buildAddDealAssociationRequest() {
  var o = new api.AddDealAssociationRequest();
  buildCounterAddDealAssociationRequest++;
  if (buildCounterAddDealAssociationRequest < 3) {
    o.association = buildCreativeDealAssociation();
  }
  buildCounterAddDealAssociationRequest--;
  return o;
}

checkAddDealAssociationRequest(api.AddDealAssociationRequest o) {
  buildCounterAddDealAssociationRequest++;
  if (buildCounterAddDealAssociationRequest < 3) {
    checkCreativeDealAssociation(o.association);
  }
  buildCounterAddDealAssociationRequest--;
}

buildUnnamed3572() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3572(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterAppContext = 0;
buildAppContext() {
  var o = new api.AppContext();
  buildCounterAppContext++;
  if (buildCounterAppContext < 3) {
    o.appTypes = buildUnnamed3572();
  }
  buildCounterAppContext--;
  return o;
}

checkAppContext(api.AppContext o) {
  buildCounterAppContext++;
  if (buildCounterAppContext < 3) {
    checkUnnamed3572(o.appTypes);
  }
  buildCounterAppContext--;
}

buildUnnamed3573() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3573(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterAuctionContext = 0;
buildAuctionContext() {
  var o = new api.AuctionContext();
  buildCounterAuctionContext++;
  if (buildCounterAuctionContext < 3) {
    o.auctionTypes = buildUnnamed3573();
  }
  buildCounterAuctionContext--;
  return o;
}

checkAuctionContext(api.AuctionContext o) {
  buildCounterAuctionContext++;
  if (buildCounterAuctionContext < 3) {
    checkUnnamed3573(o.auctionTypes);
  }
  buildCounterAuctionContext--;
}

core.int buildCounterBidMetricsRow = 0;
buildBidMetricsRow() {
  var o = new api.BidMetricsRow();
  buildCounterBidMetricsRow++;
  if (buildCounterBidMetricsRow < 3) {
    o.bids = buildMetricValue();
    o.bidsInAuction = buildMetricValue();
    o.billedImpressions = buildMetricValue();
    o.impressionsWon = buildMetricValue();
    o.measurableImpressions = buildMetricValue();
    o.rowDimensions = buildRowDimensions();
    o.viewableImpressions = buildMetricValue();
  }
  buildCounterBidMetricsRow--;
  return o;
}

checkBidMetricsRow(api.BidMetricsRow o) {
  buildCounterBidMetricsRow++;
  if (buildCounterBidMetricsRow < 3) {
    checkMetricValue(o.bids);
    checkMetricValue(o.bidsInAuction);
    checkMetricValue(o.billedImpressions);
    checkMetricValue(o.impressionsWon);
    checkMetricValue(o.measurableImpressions);
    checkRowDimensions(o.rowDimensions);
    checkMetricValue(o.viewableImpressions);
  }
  buildCounterBidMetricsRow--;
}

core.int buildCounterBidResponseWithoutBidsStatusRow = 0;
buildBidResponseWithoutBidsStatusRow() {
  var o = new api.BidResponseWithoutBidsStatusRow();
  buildCounterBidResponseWithoutBidsStatusRow++;
  if (buildCounterBidResponseWithoutBidsStatusRow < 3) {
    o.impressionCount = buildMetricValue();
    o.rowDimensions = buildRowDimensions();
    o.status = "foo";
  }
  buildCounterBidResponseWithoutBidsStatusRow--;
  return o;
}

checkBidResponseWithoutBidsStatusRow(api.BidResponseWithoutBidsStatusRow o) {
  buildCounterBidResponseWithoutBidsStatusRow++;
  if (buildCounterBidResponseWithoutBidsStatusRow < 3) {
    checkMetricValue(o.impressionCount);
    checkRowDimensions(o.rowDimensions);
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterBidResponseWithoutBidsStatusRow--;
}

core.int buildCounterCalloutStatusRow = 0;
buildCalloutStatusRow() {
  var o = new api.CalloutStatusRow();
  buildCounterCalloutStatusRow++;
  if (buildCounterCalloutStatusRow < 3) {
    o.calloutStatusId = 42;
    o.impressionCount = buildMetricValue();
    o.rowDimensions = buildRowDimensions();
  }
  buildCounterCalloutStatusRow--;
  return o;
}

checkCalloutStatusRow(api.CalloutStatusRow o) {
  buildCounterCalloutStatusRow++;
  if (buildCounterCalloutStatusRow < 3) {
    unittest.expect(o.calloutStatusId, unittest.equals(42));
    checkMetricValue(o.impressionCount);
    checkRowDimensions(o.rowDimensions);
  }
  buildCounterCalloutStatusRow--;
}

core.int buildCounterClient = 0;
buildClient() {
  var o = new api.Client();
  buildCounterClient++;
  if (buildCounterClient < 3) {
    o.clientAccountId = "foo";
    o.clientName = "foo";
    o.entityId = "foo";
    o.entityName = "foo";
    o.entityType = "foo";
    o.role = "foo";
    o.status = "foo";
    o.visibleToSeller = true;
  }
  buildCounterClient--;
  return o;
}

checkClient(api.Client o) {
  buildCounterClient++;
  if (buildCounterClient < 3) {
    unittest.expect(o.clientAccountId, unittest.equals('foo'));
    unittest.expect(o.clientName, unittest.equals('foo'));
    unittest.expect(o.entityId, unittest.equals('foo'));
    unittest.expect(o.entityName, unittest.equals('foo'));
    unittest.expect(o.entityType, unittest.equals('foo'));
    unittest.expect(o.role, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.visibleToSeller, unittest.isTrue);
  }
  buildCounterClient--;
}

core.int buildCounterClientUser = 0;
buildClientUser() {
  var o = new api.ClientUser();
  buildCounterClientUser++;
  if (buildCounterClientUser < 3) {
    o.clientAccountId = "foo";
    o.email = "foo";
    o.status = "foo";
    o.userId = "foo";
  }
  buildCounterClientUser--;
  return o;
}

checkClientUser(api.ClientUser o) {
  buildCounterClientUser++;
  if (buildCounterClientUser < 3) {
    unittest.expect(o.clientAccountId, unittest.equals('foo'));
    unittest.expect(o.email, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.userId, unittest.equals('foo'));
  }
  buildCounterClientUser--;
}

core.int buildCounterClientUserInvitation = 0;
buildClientUserInvitation() {
  var o = new api.ClientUserInvitation();
  buildCounterClientUserInvitation++;
  if (buildCounterClientUserInvitation < 3) {
    o.clientAccountId = "foo";
    o.email = "foo";
    o.invitationId = "foo";
  }
  buildCounterClientUserInvitation--;
  return o;
}

checkClientUserInvitation(api.ClientUserInvitation o) {
  buildCounterClientUserInvitation++;
  if (buildCounterClientUserInvitation < 3) {
    unittest.expect(o.clientAccountId, unittest.equals('foo'));
    unittest.expect(o.email, unittest.equals('foo'));
    unittest.expect(o.invitationId, unittest.equals('foo'));
  }
  buildCounterClientUserInvitation--;
}

buildUnnamed3574() {
  var o = new core.List<api.ServingContext>();
  o.add(buildServingContext());
  o.add(buildServingContext());
  return o;
}

checkUnnamed3574(core.List<api.ServingContext> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkServingContext(o[0]);
  checkServingContext(o[1]);
}

buildUnnamed3575() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3575(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterCorrection = 0;
buildCorrection() {
  var o = new api.Correction();
  buildCounterCorrection++;
  if (buildCounterCorrection < 3) {
    o.contexts = buildUnnamed3574();
    o.details = buildUnnamed3575();
    o.type = "foo";
  }
  buildCounterCorrection--;
  return o;
}

checkCorrection(api.Correction o) {
  buildCounterCorrection++;
  if (buildCounterCorrection < 3) {
    checkUnnamed3574(o.contexts);
    checkUnnamed3575(o.details);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterCorrection--;
}

buildUnnamed3576() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3576(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3577() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3577(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3578() {
  var o = new core.List<api.Correction>();
  o.add(buildCorrection());
  o.add(buildCorrection());
  return o;
}

checkUnnamed3578(core.List<api.Correction> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCorrection(o[0]);
  checkCorrection(o[1]);
}

buildUnnamed3579() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3579(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3580() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3580(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3581() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3581(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3582() {
  var o = new core.List<core.int>();
  o.add(42);
  o.add(42);
  return o;
}

checkUnnamed3582(core.List<core.int> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42));
  unittest.expect(o[1], unittest.equals(42));
}

buildUnnamed3583() {
  var o = new core.List<core.int>();
  o.add(42);
  o.add(42);
  return o;
}

checkUnnamed3583(core.List<core.int> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42));
  unittest.expect(o[1], unittest.equals(42));
}

buildUnnamed3584() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3584(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3585() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3585(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3586() {
  var o = new core.List<api.ServingRestriction>();
  o.add(buildServingRestriction());
  o.add(buildServingRestriction());
  return o;
}

checkUnnamed3586(core.List<api.ServingRestriction> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkServingRestriction(o[0]);
  checkServingRestriction(o[1]);
}

buildUnnamed3587() {
  var o = new core.List<core.int>();
  o.add(42);
  o.add(42);
  return o;
}

checkUnnamed3587(core.List<core.int> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42));
  unittest.expect(o[1], unittest.equals(42));
}

core.int buildCounterCreative = 0;
buildCreative() {
  var o = new api.Creative();
  buildCounterCreative++;
  if (buildCounterCreative < 3) {
    o.accountId = "foo";
    o.adChoicesDestinationUrl = "foo";
    o.advertiserName = "foo";
    o.agencyId = "foo";
    o.apiUpdateTime = "foo";
    o.attributes = buildUnnamed3576();
    o.clickThroughUrls = buildUnnamed3577();
    o.corrections = buildUnnamed3578();
    o.creativeId = "foo";
    o.dealsStatus = "foo";
    o.detectedAdvertiserIds = buildUnnamed3579();
    o.detectedDomains = buildUnnamed3580();
    o.detectedLanguages = buildUnnamed3581();
    o.detectedProductCategories = buildUnnamed3582();
    o.detectedSensitiveCategories = buildUnnamed3583();
    o.filteringStats = buildFilteringStats();
    o.html = buildHtmlContent();
    o.impressionTrackingUrls = buildUnnamed3584();
    o.native = buildNativeContent();
    o.openAuctionStatus = "foo";
    o.restrictedCategories = buildUnnamed3585();
    o.servingRestrictions = buildUnnamed3586();
    o.vendorIds = buildUnnamed3587();
    o.version = 42;
    o.video = buildVideoContent();
  }
  buildCounterCreative--;
  return o;
}

checkCreative(api.Creative o) {
  buildCounterCreative++;
  if (buildCounterCreative < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.adChoicesDestinationUrl, unittest.equals('foo'));
    unittest.expect(o.advertiserName, unittest.equals('foo'));
    unittest.expect(o.agencyId, unittest.equals('foo'));
    unittest.expect(o.apiUpdateTime, unittest.equals('foo'));
    checkUnnamed3576(o.attributes);
    checkUnnamed3577(o.clickThroughUrls);
    checkUnnamed3578(o.corrections);
    unittest.expect(o.creativeId, unittest.equals('foo'));
    unittest.expect(o.dealsStatus, unittest.equals('foo'));
    checkUnnamed3579(o.detectedAdvertiserIds);
    checkUnnamed3580(o.detectedDomains);
    checkUnnamed3581(o.detectedLanguages);
    checkUnnamed3582(o.detectedProductCategories);
    checkUnnamed3583(o.detectedSensitiveCategories);
    checkFilteringStats(o.filteringStats);
    checkHtmlContent(o.html);
    checkUnnamed3584(o.impressionTrackingUrls);
    checkNativeContent(o.native);
    unittest.expect(o.openAuctionStatus, unittest.equals('foo'));
    checkUnnamed3585(o.restrictedCategories);
    checkUnnamed3586(o.servingRestrictions);
    checkUnnamed3587(o.vendorIds);
    unittest.expect(o.version, unittest.equals(42));
    checkVideoContent(o.video);
  }
  buildCounterCreative--;
}

core.int buildCounterCreativeDealAssociation = 0;
buildCreativeDealAssociation() {
  var o = new api.CreativeDealAssociation();
  buildCounterCreativeDealAssociation++;
  if (buildCounterCreativeDealAssociation < 3) {
    o.accountId = "foo";
    o.creativeId = "foo";
    o.dealsId = "foo";
  }
  buildCounterCreativeDealAssociation--;
  return o;
}

checkCreativeDealAssociation(api.CreativeDealAssociation o) {
  buildCounterCreativeDealAssociation++;
  if (buildCounterCreativeDealAssociation < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.creativeId, unittest.equals('foo'));
    unittest.expect(o.dealsId, unittest.equals('foo'));
  }
  buildCounterCreativeDealAssociation--;
}

core.int buildCounterCreativeStatusRow = 0;
buildCreativeStatusRow() {
  var o = new api.CreativeStatusRow();
  buildCounterCreativeStatusRow++;
  if (buildCounterCreativeStatusRow < 3) {
    o.bidCount = buildMetricValue();
    o.creativeStatusId = 42;
    o.rowDimensions = buildRowDimensions();
  }
  buildCounterCreativeStatusRow--;
  return o;
}

checkCreativeStatusRow(api.CreativeStatusRow o) {
  buildCounterCreativeStatusRow++;
  if (buildCounterCreativeStatusRow < 3) {
    checkMetricValue(o.bidCount);
    unittest.expect(o.creativeStatusId, unittest.equals(42));
    checkRowDimensions(o.rowDimensions);
  }
  buildCounterCreativeStatusRow--;
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

buildUnnamed3588() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3588(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterDisapproval = 0;
buildDisapproval() {
  var o = new api.Disapproval();
  buildCounterDisapproval++;
  if (buildCounterDisapproval < 3) {
    o.details = buildUnnamed3588();
    o.reason = "foo";
  }
  buildCounterDisapproval--;
  return o;
}

checkDisapproval(api.Disapproval o) {
  buildCounterDisapproval++;
  if (buildCounterDisapproval < 3) {
    checkUnnamed3588(o.details);
    unittest.expect(o.reason, unittest.equals('foo'));
  }
  buildCounterDisapproval--;
}

core.int buildCounterEmpty = 0;
buildEmpty() {
  var o = new api.Empty();
  buildCounterEmpty++;
  if (buildCounterEmpty < 3) {}
  buildCounterEmpty--;
  return o;
}

checkEmpty(api.Empty o) {
  buildCounterEmpty++;
  if (buildCounterEmpty < 3) {}
  buildCounterEmpty--;
}

buildUnnamed3589() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3589(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3590() {
  var o = new core.List<core.int>();
  o.add(42);
  o.add(42);
  return o;
}

checkUnnamed3590(core.List<core.int> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42));
  unittest.expect(o[1], unittest.equals(42));
}

core.int buildCounterFilterSet = 0;
buildFilterSet() {
  var o = new api.FilterSet();
  buildCounterFilterSet++;
  if (buildCounterFilterSet < 3) {
    o.absoluteDateRange = buildAbsoluteDateRange();
    o.buyerAccountId = "foo";
    o.creativeId = "foo";
    o.dealId = "foo";
    o.environment = "foo";
    o.filterSetId = "foo";
    o.format = "foo";
    o.ownerAccountId = "foo";
    o.platforms = buildUnnamed3589();
    o.realtimeTimeRange = buildRealtimeTimeRange();
    o.relativeDateRange = buildRelativeDateRange();
    o.sellerNetworkIds = buildUnnamed3590();
    o.timeSeriesGranularity = "foo";
  }
  buildCounterFilterSet--;
  return o;
}

checkFilterSet(api.FilterSet o) {
  buildCounterFilterSet++;
  if (buildCounterFilterSet < 3) {
    checkAbsoluteDateRange(o.absoluteDateRange);
    unittest.expect(o.buyerAccountId, unittest.equals('foo'));
    unittest.expect(o.creativeId, unittest.equals('foo'));
    unittest.expect(o.dealId, unittest.equals('foo'));
    unittest.expect(o.environment, unittest.equals('foo'));
    unittest.expect(o.filterSetId, unittest.equals('foo'));
    unittest.expect(o.format, unittest.equals('foo'));
    unittest.expect(o.ownerAccountId, unittest.equals('foo'));
    checkUnnamed3589(o.platforms);
    checkRealtimeTimeRange(o.realtimeTimeRange);
    checkRelativeDateRange(o.relativeDateRange);
    checkUnnamed3590(o.sellerNetworkIds);
    unittest.expect(o.timeSeriesGranularity, unittest.equals('foo'));
  }
  buildCounterFilterSet--;
}

core.int buildCounterFilteredBidCreativeRow = 0;
buildFilteredBidCreativeRow() {
  var o = new api.FilteredBidCreativeRow();
  buildCounterFilteredBidCreativeRow++;
  if (buildCounterFilteredBidCreativeRow < 3) {
    o.bidCount = buildMetricValue();
    o.creativeId = "foo";
    o.rowDimensions = buildRowDimensions();
  }
  buildCounterFilteredBidCreativeRow--;
  return o;
}

checkFilteredBidCreativeRow(api.FilteredBidCreativeRow o) {
  buildCounterFilteredBidCreativeRow++;
  if (buildCounterFilteredBidCreativeRow < 3) {
    checkMetricValue(o.bidCount);
    unittest.expect(o.creativeId, unittest.equals('foo'));
    checkRowDimensions(o.rowDimensions);
  }
  buildCounterFilteredBidCreativeRow--;
}

core.int buildCounterFilteredBidDetailRow = 0;
buildFilteredBidDetailRow() {
  var o = new api.FilteredBidDetailRow();
  buildCounterFilteredBidDetailRow++;
  if (buildCounterFilteredBidDetailRow < 3) {
    o.bidCount = buildMetricValue();
    o.detailId = 42;
    o.rowDimensions = buildRowDimensions();
  }
  buildCounterFilteredBidDetailRow--;
  return o;
}

checkFilteredBidDetailRow(api.FilteredBidDetailRow o) {
  buildCounterFilteredBidDetailRow++;
  if (buildCounterFilteredBidDetailRow < 3) {
    checkMetricValue(o.bidCount);
    unittest.expect(o.detailId, unittest.equals(42));
    checkRowDimensions(o.rowDimensions);
  }
  buildCounterFilteredBidDetailRow--;
}

buildUnnamed3591() {
  var o = new core.List<api.Reason>();
  o.add(buildReason());
  o.add(buildReason());
  return o;
}

checkUnnamed3591(core.List<api.Reason> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReason(o[0]);
  checkReason(o[1]);
}

core.int buildCounterFilteringStats = 0;
buildFilteringStats() {
  var o = new api.FilteringStats();
  buildCounterFilteringStats++;
  if (buildCounterFilteringStats < 3) {
    o.date = buildDate();
    o.reasons = buildUnnamed3591();
  }
  buildCounterFilteringStats--;
  return o;
}

checkFilteringStats(api.FilteringStats o) {
  buildCounterFilteringStats++;
  if (buildCounterFilteringStats < 3) {
    checkDate(o.date);
    checkUnnamed3591(o.reasons);
  }
  buildCounterFilteringStats--;
}

core.int buildCounterHtmlContent = 0;
buildHtmlContent() {
  var o = new api.HtmlContent();
  buildCounterHtmlContent++;
  if (buildCounterHtmlContent < 3) {
    o.height = 42;
    o.snippet = "foo";
    o.width = 42;
  }
  buildCounterHtmlContent--;
  return o;
}

checkHtmlContent(api.HtmlContent o) {
  buildCounterHtmlContent++;
  if (buildCounterHtmlContent < 3) {
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.snippet, unittest.equals('foo'));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterHtmlContent--;
}

core.int buildCounterImage = 0;
buildImage() {
  var o = new api.Image();
  buildCounterImage++;
  if (buildCounterImage < 3) {
    o.height = 42;
    o.url = "foo";
    o.width = 42;
  }
  buildCounterImage--;
  return o;
}

checkImage(api.Image o) {
  buildCounterImage++;
  if (buildCounterImage < 3) {
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.url, unittest.equals('foo'));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterImage--;
}

core.int buildCounterImpressionMetricsRow = 0;
buildImpressionMetricsRow() {
  var o = new api.ImpressionMetricsRow();
  buildCounterImpressionMetricsRow++;
  if (buildCounterImpressionMetricsRow < 3) {
    o.availableImpressions = buildMetricValue();
    o.bidRequests = buildMetricValue();
    o.inventoryMatches = buildMetricValue();
    o.responsesWithBids = buildMetricValue();
    o.rowDimensions = buildRowDimensions();
    o.successfulResponses = buildMetricValue();
  }
  buildCounterImpressionMetricsRow--;
  return o;
}

checkImpressionMetricsRow(api.ImpressionMetricsRow o) {
  buildCounterImpressionMetricsRow++;
  if (buildCounterImpressionMetricsRow < 3) {
    checkMetricValue(o.availableImpressions);
    checkMetricValue(o.bidRequests);
    checkMetricValue(o.inventoryMatches);
    checkMetricValue(o.responsesWithBids);
    checkRowDimensions(o.rowDimensions);
    checkMetricValue(o.successfulResponses);
  }
  buildCounterImpressionMetricsRow--;
}

buildUnnamed3592() {
  var o = new core.List<api.BidMetricsRow>();
  o.add(buildBidMetricsRow());
  o.add(buildBidMetricsRow());
  return o;
}

checkUnnamed3592(core.List<api.BidMetricsRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBidMetricsRow(o[0]);
  checkBidMetricsRow(o[1]);
}

core.int buildCounterListBidMetricsResponse = 0;
buildListBidMetricsResponse() {
  var o = new api.ListBidMetricsResponse();
  buildCounterListBidMetricsResponse++;
  if (buildCounterListBidMetricsResponse < 3) {
    o.bidMetricsRows = buildUnnamed3592();
    o.nextPageToken = "foo";
  }
  buildCounterListBidMetricsResponse--;
  return o;
}

checkListBidMetricsResponse(api.ListBidMetricsResponse o) {
  buildCounterListBidMetricsResponse++;
  if (buildCounterListBidMetricsResponse < 3) {
    checkUnnamed3592(o.bidMetricsRows);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListBidMetricsResponse--;
}

buildUnnamed3593() {
  var o = new core.List<api.CalloutStatusRow>();
  o.add(buildCalloutStatusRow());
  o.add(buildCalloutStatusRow());
  return o;
}

checkUnnamed3593(core.List<api.CalloutStatusRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCalloutStatusRow(o[0]);
  checkCalloutStatusRow(o[1]);
}

core.int buildCounterListBidResponseErrorsResponse = 0;
buildListBidResponseErrorsResponse() {
  var o = new api.ListBidResponseErrorsResponse();
  buildCounterListBidResponseErrorsResponse++;
  if (buildCounterListBidResponseErrorsResponse < 3) {
    o.calloutStatusRows = buildUnnamed3593();
    o.nextPageToken = "foo";
  }
  buildCounterListBidResponseErrorsResponse--;
  return o;
}

checkListBidResponseErrorsResponse(api.ListBidResponseErrorsResponse o) {
  buildCounterListBidResponseErrorsResponse++;
  if (buildCounterListBidResponseErrorsResponse < 3) {
    checkUnnamed3593(o.calloutStatusRows);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListBidResponseErrorsResponse--;
}

buildUnnamed3594() {
  var o = new core.List<api.BidResponseWithoutBidsStatusRow>();
  o.add(buildBidResponseWithoutBidsStatusRow());
  o.add(buildBidResponseWithoutBidsStatusRow());
  return o;
}

checkUnnamed3594(core.List<api.BidResponseWithoutBidsStatusRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBidResponseWithoutBidsStatusRow(o[0]);
  checkBidResponseWithoutBidsStatusRow(o[1]);
}

core.int buildCounterListBidResponsesWithoutBidsResponse = 0;
buildListBidResponsesWithoutBidsResponse() {
  var o = new api.ListBidResponsesWithoutBidsResponse();
  buildCounterListBidResponsesWithoutBidsResponse++;
  if (buildCounterListBidResponsesWithoutBidsResponse < 3) {
    o.bidResponseWithoutBidsStatusRows = buildUnnamed3594();
    o.nextPageToken = "foo";
  }
  buildCounterListBidResponsesWithoutBidsResponse--;
  return o;
}

checkListBidResponsesWithoutBidsResponse(
    api.ListBidResponsesWithoutBidsResponse o) {
  buildCounterListBidResponsesWithoutBidsResponse++;
  if (buildCounterListBidResponsesWithoutBidsResponse < 3) {
    checkUnnamed3594(o.bidResponseWithoutBidsStatusRows);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListBidResponsesWithoutBidsResponse--;
}

buildUnnamed3595() {
  var o = new core.List<api.ClientUserInvitation>();
  o.add(buildClientUserInvitation());
  o.add(buildClientUserInvitation());
  return o;
}

checkUnnamed3595(core.List<api.ClientUserInvitation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkClientUserInvitation(o[0]);
  checkClientUserInvitation(o[1]);
}

core.int buildCounterListClientUserInvitationsResponse = 0;
buildListClientUserInvitationsResponse() {
  var o = new api.ListClientUserInvitationsResponse();
  buildCounterListClientUserInvitationsResponse++;
  if (buildCounterListClientUserInvitationsResponse < 3) {
    o.invitations = buildUnnamed3595();
    o.nextPageToken = "foo";
  }
  buildCounterListClientUserInvitationsResponse--;
  return o;
}

checkListClientUserInvitationsResponse(
    api.ListClientUserInvitationsResponse o) {
  buildCounterListClientUserInvitationsResponse++;
  if (buildCounterListClientUserInvitationsResponse < 3) {
    checkUnnamed3595(o.invitations);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListClientUserInvitationsResponse--;
}

buildUnnamed3596() {
  var o = new core.List<api.ClientUser>();
  o.add(buildClientUser());
  o.add(buildClientUser());
  return o;
}

checkUnnamed3596(core.List<api.ClientUser> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkClientUser(o[0]);
  checkClientUser(o[1]);
}

core.int buildCounterListClientUsersResponse = 0;
buildListClientUsersResponse() {
  var o = new api.ListClientUsersResponse();
  buildCounterListClientUsersResponse++;
  if (buildCounterListClientUsersResponse < 3) {
    o.nextPageToken = "foo";
    o.users = buildUnnamed3596();
  }
  buildCounterListClientUsersResponse--;
  return o;
}

checkListClientUsersResponse(api.ListClientUsersResponse o) {
  buildCounterListClientUsersResponse++;
  if (buildCounterListClientUsersResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed3596(o.users);
  }
  buildCounterListClientUsersResponse--;
}

buildUnnamed3597() {
  var o = new core.List<api.Client>();
  o.add(buildClient());
  o.add(buildClient());
  return o;
}

checkUnnamed3597(core.List<api.Client> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkClient(o[0]);
  checkClient(o[1]);
}

core.int buildCounterListClientsResponse = 0;
buildListClientsResponse() {
  var o = new api.ListClientsResponse();
  buildCounterListClientsResponse++;
  if (buildCounterListClientsResponse < 3) {
    o.clients = buildUnnamed3597();
    o.nextPageToken = "foo";
  }
  buildCounterListClientsResponse--;
  return o;
}

checkListClientsResponse(api.ListClientsResponse o) {
  buildCounterListClientsResponse++;
  if (buildCounterListClientsResponse < 3) {
    checkUnnamed3597(o.clients);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListClientsResponse--;
}

buildUnnamed3598() {
  var o = new core.List<api.FilteredBidCreativeRow>();
  o.add(buildFilteredBidCreativeRow());
  o.add(buildFilteredBidCreativeRow());
  return o;
}

checkUnnamed3598(core.List<api.FilteredBidCreativeRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFilteredBidCreativeRow(o[0]);
  checkFilteredBidCreativeRow(o[1]);
}

core.int buildCounterListCreativeStatusBreakdownByCreativeResponse = 0;
buildListCreativeStatusBreakdownByCreativeResponse() {
  var o = new api.ListCreativeStatusBreakdownByCreativeResponse();
  buildCounterListCreativeStatusBreakdownByCreativeResponse++;
  if (buildCounterListCreativeStatusBreakdownByCreativeResponse < 3) {
    o.filteredBidCreativeRows = buildUnnamed3598();
    o.nextPageToken = "foo";
  }
  buildCounterListCreativeStatusBreakdownByCreativeResponse--;
  return o;
}

checkListCreativeStatusBreakdownByCreativeResponse(
    api.ListCreativeStatusBreakdownByCreativeResponse o) {
  buildCounterListCreativeStatusBreakdownByCreativeResponse++;
  if (buildCounterListCreativeStatusBreakdownByCreativeResponse < 3) {
    checkUnnamed3598(o.filteredBidCreativeRows);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListCreativeStatusBreakdownByCreativeResponse--;
}

buildUnnamed3599() {
  var o = new core.List<api.FilteredBidDetailRow>();
  o.add(buildFilteredBidDetailRow());
  o.add(buildFilteredBidDetailRow());
  return o;
}

checkUnnamed3599(core.List<api.FilteredBidDetailRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFilteredBidDetailRow(o[0]);
  checkFilteredBidDetailRow(o[1]);
}

core.int buildCounterListCreativeStatusBreakdownByDetailResponse = 0;
buildListCreativeStatusBreakdownByDetailResponse() {
  var o = new api.ListCreativeStatusBreakdownByDetailResponse();
  buildCounterListCreativeStatusBreakdownByDetailResponse++;
  if (buildCounterListCreativeStatusBreakdownByDetailResponse < 3) {
    o.detailType = "foo";
    o.filteredBidDetailRows = buildUnnamed3599();
    o.nextPageToken = "foo";
  }
  buildCounterListCreativeStatusBreakdownByDetailResponse--;
  return o;
}

checkListCreativeStatusBreakdownByDetailResponse(
    api.ListCreativeStatusBreakdownByDetailResponse o) {
  buildCounterListCreativeStatusBreakdownByDetailResponse++;
  if (buildCounterListCreativeStatusBreakdownByDetailResponse < 3) {
    unittest.expect(o.detailType, unittest.equals('foo'));
    checkUnnamed3599(o.filteredBidDetailRows);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListCreativeStatusBreakdownByDetailResponse--;
}

buildUnnamed3600() {
  var o = new core.List<api.Creative>();
  o.add(buildCreative());
  o.add(buildCreative());
  return o;
}

checkUnnamed3600(core.List<api.Creative> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCreative(o[0]);
  checkCreative(o[1]);
}

core.int buildCounterListCreativesResponse = 0;
buildListCreativesResponse() {
  var o = new api.ListCreativesResponse();
  buildCounterListCreativesResponse++;
  if (buildCounterListCreativesResponse < 3) {
    o.creatives = buildUnnamed3600();
    o.nextPageToken = "foo";
  }
  buildCounterListCreativesResponse--;
  return o;
}

checkListCreativesResponse(api.ListCreativesResponse o) {
  buildCounterListCreativesResponse++;
  if (buildCounterListCreativesResponse < 3) {
    checkUnnamed3600(o.creatives);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListCreativesResponse--;
}

buildUnnamed3601() {
  var o = new core.List<api.CreativeDealAssociation>();
  o.add(buildCreativeDealAssociation());
  o.add(buildCreativeDealAssociation());
  return o;
}

checkUnnamed3601(core.List<api.CreativeDealAssociation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCreativeDealAssociation(o[0]);
  checkCreativeDealAssociation(o[1]);
}

core.int buildCounterListDealAssociationsResponse = 0;
buildListDealAssociationsResponse() {
  var o = new api.ListDealAssociationsResponse();
  buildCounterListDealAssociationsResponse++;
  if (buildCounterListDealAssociationsResponse < 3) {
    o.associations = buildUnnamed3601();
    o.nextPageToken = "foo";
  }
  buildCounterListDealAssociationsResponse--;
  return o;
}

checkListDealAssociationsResponse(api.ListDealAssociationsResponse o) {
  buildCounterListDealAssociationsResponse++;
  if (buildCounterListDealAssociationsResponse < 3) {
    checkUnnamed3601(o.associations);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListDealAssociationsResponse--;
}

buildUnnamed3602() {
  var o = new core.List<api.FilterSet>();
  o.add(buildFilterSet());
  o.add(buildFilterSet());
  return o;
}

checkUnnamed3602(core.List<api.FilterSet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFilterSet(o[0]);
  checkFilterSet(o[1]);
}

core.int buildCounterListFilterSetsResponse = 0;
buildListFilterSetsResponse() {
  var o = new api.ListFilterSetsResponse();
  buildCounterListFilterSetsResponse++;
  if (buildCounterListFilterSetsResponse < 3) {
    o.filterSets = buildUnnamed3602();
    o.nextPageToken = "foo";
  }
  buildCounterListFilterSetsResponse--;
  return o;
}

checkListFilterSetsResponse(api.ListFilterSetsResponse o) {
  buildCounterListFilterSetsResponse++;
  if (buildCounterListFilterSetsResponse < 3) {
    checkUnnamed3602(o.filterSets);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListFilterSetsResponse--;
}

buildUnnamed3603() {
  var o = new core.List<api.CalloutStatusRow>();
  o.add(buildCalloutStatusRow());
  o.add(buildCalloutStatusRow());
  return o;
}

checkUnnamed3603(core.List<api.CalloutStatusRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCalloutStatusRow(o[0]);
  checkCalloutStatusRow(o[1]);
}

core.int buildCounterListFilteredBidRequestsResponse = 0;
buildListFilteredBidRequestsResponse() {
  var o = new api.ListFilteredBidRequestsResponse();
  buildCounterListFilteredBidRequestsResponse++;
  if (buildCounterListFilteredBidRequestsResponse < 3) {
    o.calloutStatusRows = buildUnnamed3603();
    o.nextPageToken = "foo";
  }
  buildCounterListFilteredBidRequestsResponse--;
  return o;
}

checkListFilteredBidRequestsResponse(api.ListFilteredBidRequestsResponse o) {
  buildCounterListFilteredBidRequestsResponse++;
  if (buildCounterListFilteredBidRequestsResponse < 3) {
    checkUnnamed3603(o.calloutStatusRows);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListFilteredBidRequestsResponse--;
}

buildUnnamed3604() {
  var o = new core.List<api.CreativeStatusRow>();
  o.add(buildCreativeStatusRow());
  o.add(buildCreativeStatusRow());
  return o;
}

checkUnnamed3604(core.List<api.CreativeStatusRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCreativeStatusRow(o[0]);
  checkCreativeStatusRow(o[1]);
}

core.int buildCounterListFilteredBidsResponse = 0;
buildListFilteredBidsResponse() {
  var o = new api.ListFilteredBidsResponse();
  buildCounterListFilteredBidsResponse++;
  if (buildCounterListFilteredBidsResponse < 3) {
    o.creativeStatusRows = buildUnnamed3604();
    o.nextPageToken = "foo";
  }
  buildCounterListFilteredBidsResponse--;
  return o;
}

checkListFilteredBidsResponse(api.ListFilteredBidsResponse o) {
  buildCounterListFilteredBidsResponse++;
  if (buildCounterListFilteredBidsResponse < 3) {
    checkUnnamed3604(o.creativeStatusRows);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListFilteredBidsResponse--;
}

buildUnnamed3605() {
  var o = new core.List<api.ImpressionMetricsRow>();
  o.add(buildImpressionMetricsRow());
  o.add(buildImpressionMetricsRow());
  return o;
}

checkUnnamed3605(core.List<api.ImpressionMetricsRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkImpressionMetricsRow(o[0]);
  checkImpressionMetricsRow(o[1]);
}

core.int buildCounterListImpressionMetricsResponse = 0;
buildListImpressionMetricsResponse() {
  var o = new api.ListImpressionMetricsResponse();
  buildCounterListImpressionMetricsResponse++;
  if (buildCounterListImpressionMetricsResponse < 3) {
    o.impressionMetricsRows = buildUnnamed3605();
    o.nextPageToken = "foo";
  }
  buildCounterListImpressionMetricsResponse--;
  return o;
}

checkListImpressionMetricsResponse(api.ListImpressionMetricsResponse o) {
  buildCounterListImpressionMetricsResponse++;
  if (buildCounterListImpressionMetricsResponse < 3) {
    checkUnnamed3605(o.impressionMetricsRows);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListImpressionMetricsResponse--;
}

buildUnnamed3606() {
  var o = new core.List<api.CreativeStatusRow>();
  o.add(buildCreativeStatusRow());
  o.add(buildCreativeStatusRow());
  return o;
}

checkUnnamed3606(core.List<api.CreativeStatusRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCreativeStatusRow(o[0]);
  checkCreativeStatusRow(o[1]);
}

core.int buildCounterListLosingBidsResponse = 0;
buildListLosingBidsResponse() {
  var o = new api.ListLosingBidsResponse();
  buildCounterListLosingBidsResponse++;
  if (buildCounterListLosingBidsResponse < 3) {
    o.creativeStatusRows = buildUnnamed3606();
    o.nextPageToken = "foo";
  }
  buildCounterListLosingBidsResponse--;
  return o;
}

checkListLosingBidsResponse(api.ListLosingBidsResponse o) {
  buildCounterListLosingBidsResponse++;
  if (buildCounterListLosingBidsResponse < 3) {
    checkUnnamed3606(o.creativeStatusRows);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListLosingBidsResponse--;
}

buildUnnamed3607() {
  var o = new core.List<api.NonBillableWinningBidStatusRow>();
  o.add(buildNonBillableWinningBidStatusRow());
  o.add(buildNonBillableWinningBidStatusRow());
  return o;
}

checkUnnamed3607(core.List<api.NonBillableWinningBidStatusRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkNonBillableWinningBidStatusRow(o[0]);
  checkNonBillableWinningBidStatusRow(o[1]);
}

core.int buildCounterListNonBillableWinningBidsResponse = 0;
buildListNonBillableWinningBidsResponse() {
  var o = new api.ListNonBillableWinningBidsResponse();
  buildCounterListNonBillableWinningBidsResponse++;
  if (buildCounterListNonBillableWinningBidsResponse < 3) {
    o.nextPageToken = "foo";
    o.nonBillableWinningBidStatusRows = buildUnnamed3607();
  }
  buildCounterListNonBillableWinningBidsResponse--;
  return o;
}

checkListNonBillableWinningBidsResponse(
    api.ListNonBillableWinningBidsResponse o) {
  buildCounterListNonBillableWinningBidsResponse++;
  if (buildCounterListNonBillableWinningBidsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed3607(o.nonBillableWinningBidStatusRows);
  }
  buildCounterListNonBillableWinningBidsResponse--;
}

buildUnnamed3608() {
  var o = new core.List<core.int>();
  o.add(42);
  o.add(42);
  return o;
}

checkUnnamed3608(core.List<core.int> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42));
  unittest.expect(o[1], unittest.equals(42));
}

core.int buildCounterLocationContext = 0;
buildLocationContext() {
  var o = new api.LocationContext();
  buildCounterLocationContext++;
  if (buildCounterLocationContext < 3) {
    o.geoCriteriaIds = buildUnnamed3608();
  }
  buildCounterLocationContext--;
  return o;
}

checkLocationContext(api.LocationContext o) {
  buildCounterLocationContext++;
  if (buildCounterLocationContext < 3) {
    checkUnnamed3608(o.geoCriteriaIds);
  }
  buildCounterLocationContext--;
}

core.int buildCounterMetricValue = 0;
buildMetricValue() {
  var o = new api.MetricValue();
  buildCounterMetricValue++;
  if (buildCounterMetricValue < 3) {
    o.value = "foo";
    o.variance = "foo";
  }
  buildCounterMetricValue--;
  return o;
}

checkMetricValue(api.MetricValue o) {
  buildCounterMetricValue++;
  if (buildCounterMetricValue < 3) {
    unittest.expect(o.value, unittest.equals('foo'));
    unittest.expect(o.variance, unittest.equals('foo'));
  }
  buildCounterMetricValue--;
}

core.int buildCounterNativeContent = 0;
buildNativeContent() {
  var o = new api.NativeContent();
  buildCounterNativeContent++;
  if (buildCounterNativeContent < 3) {
    o.advertiserName = "foo";
    o.appIcon = buildImage();
    o.body = "foo";
    o.callToAction = "foo";
    o.clickLinkUrl = "foo";
    o.clickTrackingUrl = "foo";
    o.headline = "foo";
    o.image = buildImage();
    o.logo = buildImage();
    o.priceDisplayText = "foo";
    o.starRating = 42.0;
    o.storeUrl = "foo";
    o.videoUrl = "foo";
  }
  buildCounterNativeContent--;
  return o;
}

checkNativeContent(api.NativeContent o) {
  buildCounterNativeContent++;
  if (buildCounterNativeContent < 3) {
    unittest.expect(o.advertiserName, unittest.equals('foo'));
    checkImage(o.appIcon);
    unittest.expect(o.body, unittest.equals('foo'));
    unittest.expect(o.callToAction, unittest.equals('foo'));
    unittest.expect(o.clickLinkUrl, unittest.equals('foo'));
    unittest.expect(o.clickTrackingUrl, unittest.equals('foo'));
    unittest.expect(o.headline, unittest.equals('foo'));
    checkImage(o.image);
    checkImage(o.logo);
    unittest.expect(o.priceDisplayText, unittest.equals('foo'));
    unittest.expect(o.starRating, unittest.equals(42.0));
    unittest.expect(o.storeUrl, unittest.equals('foo'));
    unittest.expect(o.videoUrl, unittest.equals('foo'));
  }
  buildCounterNativeContent--;
}

core.int buildCounterNonBillableWinningBidStatusRow = 0;
buildNonBillableWinningBidStatusRow() {
  var o = new api.NonBillableWinningBidStatusRow();
  buildCounterNonBillableWinningBidStatusRow++;
  if (buildCounterNonBillableWinningBidStatusRow < 3) {
    o.bidCount = buildMetricValue();
    o.rowDimensions = buildRowDimensions();
    o.status = "foo";
  }
  buildCounterNonBillableWinningBidStatusRow--;
  return o;
}

checkNonBillableWinningBidStatusRow(api.NonBillableWinningBidStatusRow o) {
  buildCounterNonBillableWinningBidStatusRow++;
  if (buildCounterNonBillableWinningBidStatusRow < 3) {
    checkMetricValue(o.bidCount);
    checkRowDimensions(o.rowDimensions);
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterNonBillableWinningBidStatusRow--;
}

buildUnnamed3609() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3609(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterPlatformContext = 0;
buildPlatformContext() {
  var o = new api.PlatformContext();
  buildCounterPlatformContext++;
  if (buildCounterPlatformContext < 3) {
    o.platforms = buildUnnamed3609();
  }
  buildCounterPlatformContext--;
  return o;
}

checkPlatformContext(api.PlatformContext o) {
  buildCounterPlatformContext++;
  if (buildCounterPlatformContext < 3) {
    checkUnnamed3609(o.platforms);
  }
  buildCounterPlatformContext--;
}

core.int buildCounterRealtimeTimeRange = 0;
buildRealtimeTimeRange() {
  var o = new api.RealtimeTimeRange();
  buildCounterRealtimeTimeRange++;
  if (buildCounterRealtimeTimeRange < 3) {
    o.startTimestamp = "foo";
  }
  buildCounterRealtimeTimeRange--;
  return o;
}

checkRealtimeTimeRange(api.RealtimeTimeRange o) {
  buildCounterRealtimeTimeRange++;
  if (buildCounterRealtimeTimeRange < 3) {
    unittest.expect(o.startTimestamp, unittest.equals('foo'));
  }
  buildCounterRealtimeTimeRange--;
}

core.int buildCounterReason = 0;
buildReason() {
  var o = new api.Reason();
  buildCounterReason++;
  if (buildCounterReason < 3) {
    o.count = "foo";
    o.status = 42;
  }
  buildCounterReason--;
  return o;
}

checkReason(api.Reason o) {
  buildCounterReason++;
  if (buildCounterReason < 3) {
    unittest.expect(o.count, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals(42));
  }
  buildCounterReason--;
}

core.int buildCounterRelativeDateRange = 0;
buildRelativeDateRange() {
  var o = new api.RelativeDateRange();
  buildCounterRelativeDateRange++;
  if (buildCounterRelativeDateRange < 3) {
    o.durationDays = 42;
    o.offsetDays = 42;
  }
  buildCounterRelativeDateRange--;
  return o;
}

checkRelativeDateRange(api.RelativeDateRange o) {
  buildCounterRelativeDateRange++;
  if (buildCounterRelativeDateRange < 3) {
    unittest.expect(o.durationDays, unittest.equals(42));
    unittest.expect(o.offsetDays, unittest.equals(42));
  }
  buildCounterRelativeDateRange--;
}

core.int buildCounterRemoveDealAssociationRequest = 0;
buildRemoveDealAssociationRequest() {
  var o = new api.RemoveDealAssociationRequest();
  buildCounterRemoveDealAssociationRequest++;
  if (buildCounterRemoveDealAssociationRequest < 3) {
    o.association = buildCreativeDealAssociation();
  }
  buildCounterRemoveDealAssociationRequest--;
  return o;
}

checkRemoveDealAssociationRequest(api.RemoveDealAssociationRequest o) {
  buildCounterRemoveDealAssociationRequest++;
  if (buildCounterRemoveDealAssociationRequest < 3) {
    checkCreativeDealAssociation(o.association);
  }
  buildCounterRemoveDealAssociationRequest--;
}

core.int buildCounterRowDimensions = 0;
buildRowDimensions() {
  var o = new api.RowDimensions();
  buildCounterRowDimensions++;
  if (buildCounterRowDimensions < 3) {
    o.timeInterval = buildTimeInterval();
  }
  buildCounterRowDimensions--;
  return o;
}

checkRowDimensions(api.RowDimensions o) {
  buildCounterRowDimensions++;
  if (buildCounterRowDimensions < 3) {
    checkTimeInterval(o.timeInterval);
  }
  buildCounterRowDimensions--;
}

buildUnnamed3610() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3610(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterSecurityContext = 0;
buildSecurityContext() {
  var o = new api.SecurityContext();
  buildCounterSecurityContext++;
  if (buildCounterSecurityContext < 3) {
    o.securities = buildUnnamed3610();
  }
  buildCounterSecurityContext--;
  return o;
}

checkSecurityContext(api.SecurityContext o) {
  buildCounterSecurityContext++;
  if (buildCounterSecurityContext < 3) {
    checkUnnamed3610(o.securities);
  }
  buildCounterSecurityContext--;
}

core.int buildCounterServingContext = 0;
buildServingContext() {
  var o = new api.ServingContext();
  buildCounterServingContext++;
  if (buildCounterServingContext < 3) {
    o.all = "foo";
    o.appType = buildAppContext();
    o.auctionType = buildAuctionContext();
    o.location = buildLocationContext();
    o.platform = buildPlatformContext();
    o.securityType = buildSecurityContext();
  }
  buildCounterServingContext--;
  return o;
}

checkServingContext(api.ServingContext o) {
  buildCounterServingContext++;
  if (buildCounterServingContext < 3) {
    unittest.expect(o.all, unittest.equals('foo'));
    checkAppContext(o.appType);
    checkAuctionContext(o.auctionType);
    checkLocationContext(o.location);
    checkPlatformContext(o.platform);
    checkSecurityContext(o.securityType);
  }
  buildCounterServingContext--;
}

buildUnnamed3611() {
  var o = new core.List<api.ServingContext>();
  o.add(buildServingContext());
  o.add(buildServingContext());
  return o;
}

checkUnnamed3611(core.List<api.ServingContext> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkServingContext(o[0]);
  checkServingContext(o[1]);
}

buildUnnamed3612() {
  var o = new core.List<api.Disapproval>();
  o.add(buildDisapproval());
  o.add(buildDisapproval());
  return o;
}

checkUnnamed3612(core.List<api.Disapproval> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDisapproval(o[0]);
  checkDisapproval(o[1]);
}

core.int buildCounterServingRestriction = 0;
buildServingRestriction() {
  var o = new api.ServingRestriction();
  buildCounterServingRestriction++;
  if (buildCounterServingRestriction < 3) {
    o.contexts = buildUnnamed3611();
    o.disapprovalReasons = buildUnnamed3612();
    o.status = "foo";
  }
  buildCounterServingRestriction--;
  return o;
}

checkServingRestriction(api.ServingRestriction o) {
  buildCounterServingRestriction++;
  if (buildCounterServingRestriction < 3) {
    checkUnnamed3611(o.contexts);
    checkUnnamed3612(o.disapprovalReasons);
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterServingRestriction--;
}

core.int buildCounterStopWatchingCreativeRequest = 0;
buildStopWatchingCreativeRequest() {
  var o = new api.StopWatchingCreativeRequest();
  buildCounterStopWatchingCreativeRequest++;
  if (buildCounterStopWatchingCreativeRequest < 3) {}
  buildCounterStopWatchingCreativeRequest--;
  return o;
}

checkStopWatchingCreativeRequest(api.StopWatchingCreativeRequest o) {
  buildCounterStopWatchingCreativeRequest++;
  if (buildCounterStopWatchingCreativeRequest < 3) {}
  buildCounterStopWatchingCreativeRequest--;
}

core.int buildCounterTimeInterval = 0;
buildTimeInterval() {
  var o = new api.TimeInterval();
  buildCounterTimeInterval++;
  if (buildCounterTimeInterval < 3) {
    o.endTime = "foo";
    o.startTime = "foo";
  }
  buildCounterTimeInterval--;
  return o;
}

checkTimeInterval(api.TimeInterval o) {
  buildCounterTimeInterval++;
  if (buildCounterTimeInterval < 3) {
    unittest.expect(o.endTime, unittest.equals('foo'));
    unittest.expect(o.startTime, unittest.equals('foo'));
  }
  buildCounterTimeInterval--;
}

core.int buildCounterVideoContent = 0;
buildVideoContent() {
  var o = new api.VideoContent();
  buildCounterVideoContent++;
  if (buildCounterVideoContent < 3) {
    o.videoUrl = "foo";
  }
  buildCounterVideoContent--;
  return o;
}

checkVideoContent(api.VideoContent o) {
  buildCounterVideoContent++;
  if (buildCounterVideoContent < 3) {
    unittest.expect(o.videoUrl, unittest.equals('foo'));
  }
  buildCounterVideoContent--;
}

core.int buildCounterWatchCreativeRequest = 0;
buildWatchCreativeRequest() {
  var o = new api.WatchCreativeRequest();
  buildCounterWatchCreativeRequest++;
  if (buildCounterWatchCreativeRequest < 3) {
    o.topic = "foo";
  }
  buildCounterWatchCreativeRequest--;
  return o;
}

checkWatchCreativeRequest(api.WatchCreativeRequest o) {
  buildCounterWatchCreativeRequest++;
  if (buildCounterWatchCreativeRequest < 3) {
    unittest.expect(o.topic, unittest.equals('foo'));
  }
  buildCounterWatchCreativeRequest--;
}

main() {
  unittest.group("obj-schema-AbsoluteDateRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildAbsoluteDateRange();
      var od = new api.AbsoluteDateRange.fromJson(o.toJson());
      checkAbsoluteDateRange(od);
    });
  });

  unittest.group("obj-schema-AddDealAssociationRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddDealAssociationRequest();
      var od = new api.AddDealAssociationRequest.fromJson(o.toJson());
      checkAddDealAssociationRequest(od);
    });
  });

  unittest.group("obj-schema-AppContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildAppContext();
      var od = new api.AppContext.fromJson(o.toJson());
      checkAppContext(od);
    });
  });

  unittest.group("obj-schema-AuctionContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildAuctionContext();
      var od = new api.AuctionContext.fromJson(o.toJson());
      checkAuctionContext(od);
    });
  });

  unittest.group("obj-schema-BidMetricsRow", () {
    unittest.test("to-json--from-json", () {
      var o = buildBidMetricsRow();
      var od = new api.BidMetricsRow.fromJson(o.toJson());
      checkBidMetricsRow(od);
    });
  });

  unittest.group("obj-schema-BidResponseWithoutBidsStatusRow", () {
    unittest.test("to-json--from-json", () {
      var o = buildBidResponseWithoutBidsStatusRow();
      var od = new api.BidResponseWithoutBidsStatusRow.fromJson(o.toJson());
      checkBidResponseWithoutBidsStatusRow(od);
    });
  });

  unittest.group("obj-schema-CalloutStatusRow", () {
    unittest.test("to-json--from-json", () {
      var o = buildCalloutStatusRow();
      var od = new api.CalloutStatusRow.fromJson(o.toJson());
      checkCalloutStatusRow(od);
    });
  });

  unittest.group("obj-schema-Client", () {
    unittest.test("to-json--from-json", () {
      var o = buildClient();
      var od = new api.Client.fromJson(o.toJson());
      checkClient(od);
    });
  });

  unittest.group("obj-schema-ClientUser", () {
    unittest.test("to-json--from-json", () {
      var o = buildClientUser();
      var od = new api.ClientUser.fromJson(o.toJson());
      checkClientUser(od);
    });
  });

  unittest.group("obj-schema-ClientUserInvitation", () {
    unittest.test("to-json--from-json", () {
      var o = buildClientUserInvitation();
      var od = new api.ClientUserInvitation.fromJson(o.toJson());
      checkClientUserInvitation(od);
    });
  });

  unittest.group("obj-schema-Correction", () {
    unittest.test("to-json--from-json", () {
      var o = buildCorrection();
      var od = new api.Correction.fromJson(o.toJson());
      checkCorrection(od);
    });
  });

  unittest.group("obj-schema-Creative", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreative();
      var od = new api.Creative.fromJson(o.toJson());
      checkCreative(od);
    });
  });

  unittest.group("obj-schema-CreativeDealAssociation", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreativeDealAssociation();
      var od = new api.CreativeDealAssociation.fromJson(o.toJson());
      checkCreativeDealAssociation(od);
    });
  });

  unittest.group("obj-schema-CreativeStatusRow", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreativeStatusRow();
      var od = new api.CreativeStatusRow.fromJson(o.toJson());
      checkCreativeStatusRow(od);
    });
  });

  unittest.group("obj-schema-Date", () {
    unittest.test("to-json--from-json", () {
      var o = buildDate();
      var od = new api.Date.fromJson(o.toJson());
      checkDate(od);
    });
  });

  unittest.group("obj-schema-Disapproval", () {
    unittest.test("to-json--from-json", () {
      var o = buildDisapproval();
      var od = new api.Disapproval.fromJson(o.toJson());
      checkDisapproval(od);
    });
  });

  unittest.group("obj-schema-Empty", () {
    unittest.test("to-json--from-json", () {
      var o = buildEmpty();
      var od = new api.Empty.fromJson(o.toJson());
      checkEmpty(od);
    });
  });

  unittest.group("obj-schema-FilterSet", () {
    unittest.test("to-json--from-json", () {
      var o = buildFilterSet();
      var od = new api.FilterSet.fromJson(o.toJson());
      checkFilterSet(od);
    });
  });

  unittest.group("obj-schema-FilteredBidCreativeRow", () {
    unittest.test("to-json--from-json", () {
      var o = buildFilteredBidCreativeRow();
      var od = new api.FilteredBidCreativeRow.fromJson(o.toJson());
      checkFilteredBidCreativeRow(od);
    });
  });

  unittest.group("obj-schema-FilteredBidDetailRow", () {
    unittest.test("to-json--from-json", () {
      var o = buildFilteredBidDetailRow();
      var od = new api.FilteredBidDetailRow.fromJson(o.toJson());
      checkFilteredBidDetailRow(od);
    });
  });

  unittest.group("obj-schema-FilteringStats", () {
    unittest.test("to-json--from-json", () {
      var o = buildFilteringStats();
      var od = new api.FilteringStats.fromJson(o.toJson());
      checkFilteringStats(od);
    });
  });

  unittest.group("obj-schema-HtmlContent", () {
    unittest.test("to-json--from-json", () {
      var o = buildHtmlContent();
      var od = new api.HtmlContent.fromJson(o.toJson());
      checkHtmlContent(od);
    });
  });

  unittest.group("obj-schema-Image", () {
    unittest.test("to-json--from-json", () {
      var o = buildImage();
      var od = new api.Image.fromJson(o.toJson());
      checkImage(od);
    });
  });

  unittest.group("obj-schema-ImpressionMetricsRow", () {
    unittest.test("to-json--from-json", () {
      var o = buildImpressionMetricsRow();
      var od = new api.ImpressionMetricsRow.fromJson(o.toJson());
      checkImpressionMetricsRow(od);
    });
  });

  unittest.group("obj-schema-ListBidMetricsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListBidMetricsResponse();
      var od = new api.ListBidMetricsResponse.fromJson(o.toJson());
      checkListBidMetricsResponse(od);
    });
  });

  unittest.group("obj-schema-ListBidResponseErrorsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListBidResponseErrorsResponse();
      var od = new api.ListBidResponseErrorsResponse.fromJson(o.toJson());
      checkListBidResponseErrorsResponse(od);
    });
  });

  unittest.group("obj-schema-ListBidResponsesWithoutBidsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListBidResponsesWithoutBidsResponse();
      var od = new api.ListBidResponsesWithoutBidsResponse.fromJson(o.toJson());
      checkListBidResponsesWithoutBidsResponse(od);
    });
  });

  unittest.group("obj-schema-ListClientUserInvitationsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListClientUserInvitationsResponse();
      var od = new api.ListClientUserInvitationsResponse.fromJson(o.toJson());
      checkListClientUserInvitationsResponse(od);
    });
  });

  unittest.group("obj-schema-ListClientUsersResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListClientUsersResponse();
      var od = new api.ListClientUsersResponse.fromJson(o.toJson());
      checkListClientUsersResponse(od);
    });
  });

  unittest.group("obj-schema-ListClientsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListClientsResponse();
      var od = new api.ListClientsResponse.fromJson(o.toJson());
      checkListClientsResponse(od);
    });
  });

  unittest.group("obj-schema-ListCreativeStatusBreakdownByCreativeResponse",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildListCreativeStatusBreakdownByCreativeResponse();
      var od = new api.ListCreativeStatusBreakdownByCreativeResponse.fromJson(
          o.toJson());
      checkListCreativeStatusBreakdownByCreativeResponse(od);
    });
  });

  unittest.group("obj-schema-ListCreativeStatusBreakdownByDetailResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListCreativeStatusBreakdownByDetailResponse();
      var od = new api.ListCreativeStatusBreakdownByDetailResponse.fromJson(
          o.toJson());
      checkListCreativeStatusBreakdownByDetailResponse(od);
    });
  });

  unittest.group("obj-schema-ListCreativesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListCreativesResponse();
      var od = new api.ListCreativesResponse.fromJson(o.toJson());
      checkListCreativesResponse(od);
    });
  });

  unittest.group("obj-schema-ListDealAssociationsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListDealAssociationsResponse();
      var od = new api.ListDealAssociationsResponse.fromJson(o.toJson());
      checkListDealAssociationsResponse(od);
    });
  });

  unittest.group("obj-schema-ListFilterSetsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListFilterSetsResponse();
      var od = new api.ListFilterSetsResponse.fromJson(o.toJson());
      checkListFilterSetsResponse(od);
    });
  });

  unittest.group("obj-schema-ListFilteredBidRequestsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListFilteredBidRequestsResponse();
      var od = new api.ListFilteredBidRequestsResponse.fromJson(o.toJson());
      checkListFilteredBidRequestsResponse(od);
    });
  });

  unittest.group("obj-schema-ListFilteredBidsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListFilteredBidsResponse();
      var od = new api.ListFilteredBidsResponse.fromJson(o.toJson());
      checkListFilteredBidsResponse(od);
    });
  });

  unittest.group("obj-schema-ListImpressionMetricsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListImpressionMetricsResponse();
      var od = new api.ListImpressionMetricsResponse.fromJson(o.toJson());
      checkListImpressionMetricsResponse(od);
    });
  });

  unittest.group("obj-schema-ListLosingBidsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListLosingBidsResponse();
      var od = new api.ListLosingBidsResponse.fromJson(o.toJson());
      checkListLosingBidsResponse(od);
    });
  });

  unittest.group("obj-schema-ListNonBillableWinningBidsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListNonBillableWinningBidsResponse();
      var od = new api.ListNonBillableWinningBidsResponse.fromJson(o.toJson());
      checkListNonBillableWinningBidsResponse(od);
    });
  });

  unittest.group("obj-schema-LocationContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildLocationContext();
      var od = new api.LocationContext.fromJson(o.toJson());
      checkLocationContext(od);
    });
  });

  unittest.group("obj-schema-MetricValue", () {
    unittest.test("to-json--from-json", () {
      var o = buildMetricValue();
      var od = new api.MetricValue.fromJson(o.toJson());
      checkMetricValue(od);
    });
  });

  unittest.group("obj-schema-NativeContent", () {
    unittest.test("to-json--from-json", () {
      var o = buildNativeContent();
      var od = new api.NativeContent.fromJson(o.toJson());
      checkNativeContent(od);
    });
  });

  unittest.group("obj-schema-NonBillableWinningBidStatusRow", () {
    unittest.test("to-json--from-json", () {
      var o = buildNonBillableWinningBidStatusRow();
      var od = new api.NonBillableWinningBidStatusRow.fromJson(o.toJson());
      checkNonBillableWinningBidStatusRow(od);
    });
  });

  unittest.group("obj-schema-PlatformContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlatformContext();
      var od = new api.PlatformContext.fromJson(o.toJson());
      checkPlatformContext(od);
    });
  });

  unittest.group("obj-schema-RealtimeTimeRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildRealtimeTimeRange();
      var od = new api.RealtimeTimeRange.fromJson(o.toJson());
      checkRealtimeTimeRange(od);
    });
  });

  unittest.group("obj-schema-Reason", () {
    unittest.test("to-json--from-json", () {
      var o = buildReason();
      var od = new api.Reason.fromJson(o.toJson());
      checkReason(od);
    });
  });

  unittest.group("obj-schema-RelativeDateRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildRelativeDateRange();
      var od = new api.RelativeDateRange.fromJson(o.toJson());
      checkRelativeDateRange(od);
    });
  });

  unittest.group("obj-schema-RemoveDealAssociationRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildRemoveDealAssociationRequest();
      var od = new api.RemoveDealAssociationRequest.fromJson(o.toJson());
      checkRemoveDealAssociationRequest(od);
    });
  });

  unittest.group("obj-schema-RowDimensions", () {
    unittest.test("to-json--from-json", () {
      var o = buildRowDimensions();
      var od = new api.RowDimensions.fromJson(o.toJson());
      checkRowDimensions(od);
    });
  });

  unittest.group("obj-schema-SecurityContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildSecurityContext();
      var od = new api.SecurityContext.fromJson(o.toJson());
      checkSecurityContext(od);
    });
  });

  unittest.group("obj-schema-ServingContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildServingContext();
      var od = new api.ServingContext.fromJson(o.toJson());
      checkServingContext(od);
    });
  });

  unittest.group("obj-schema-ServingRestriction", () {
    unittest.test("to-json--from-json", () {
      var o = buildServingRestriction();
      var od = new api.ServingRestriction.fromJson(o.toJson());
      checkServingRestriction(od);
    });
  });

  unittest.group("obj-schema-StopWatchingCreativeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildStopWatchingCreativeRequest();
      var od = new api.StopWatchingCreativeRequest.fromJson(o.toJson());
      checkStopWatchingCreativeRequest(od);
    });
  });

  unittest.group("obj-schema-TimeInterval", () {
    unittest.test("to-json--from-json", () {
      var o = buildTimeInterval();
      var od = new api.TimeInterval.fromJson(o.toJson());
      checkTimeInterval(od);
    });
  });

  unittest.group("obj-schema-VideoContent", () {
    unittest.test("to-json--from-json", () {
      var o = buildVideoContent();
      var od = new api.VideoContent.fromJson(o.toJson());
      checkVideoContent(od);
    });
  });

  unittest.group("obj-schema-WatchCreativeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildWatchCreativeRequest();
      var od = new api.WatchCreativeRequest.fromJson(o.toJson());
      checkWatchCreativeRequest(od);
    });
  });

  unittest.group("resource-AccountsClientsResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsClientsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.clients;
      var arg_request = buildClient();
      var arg_accountId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Client.fromJson(json);
        checkClient(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/clients", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("/clients"));
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
        var resp = convert.JSON.encode(buildClient());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_accountId)
          .then(unittest.expectAsync1(((api.Client response) {
        checkClient(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsClientsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.clients;
      var arg_accountId = "foo";
      var arg_clientAccountId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/clients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/clients/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_clientAccountId"));

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
        var resp = convert.JSON.encode(buildClient());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_accountId, arg_clientAccountId)
          .then(unittest.expectAsync1(((api.Client response) {
        checkClient(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsClientsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.clients;
      var arg_accountId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/clients", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("/clients"));
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
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListClientsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, pageToken: arg_pageToken, pageSize: arg_pageSize)
          .then(unittest.expectAsync1(((api.ListClientsResponse response) {
        checkListClientsResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsClientsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.clients;
      var arg_request = buildClient();
      var arg_accountId = "foo";
      var arg_clientAccountId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Client.fromJson(json);
        checkClient(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/clients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/clients/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_clientAccountId"));

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
        var resp = convert.JSON.encode(buildClient());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_accountId, arg_clientAccountId)
          .then(unittest.expectAsync1(((api.Client response) {
        checkClient(response);
      })));
    });
  });

  unittest.group("resource-AccountsClientsInvitationsResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsClientsInvitationsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.clients.invitations;
      var arg_request = buildClientUserInvitation();
      var arg_accountId = "foo";
      var arg_clientAccountId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ClientUserInvitation.fromJson(json);
        checkClientUserInvitation(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/clients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/clients/"));
        pathOffset += 9;
        index = path.indexOf("/invitations", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_clientAccountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/invitations"));
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
        var resp = convert.JSON.encode(buildClientUserInvitation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_accountId, arg_clientAccountId)
          .then(unittest.expectAsync1(((api.ClientUserInvitation response) {
        checkClientUserInvitation(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsClientsInvitationsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.clients.invitations;
      var arg_accountId = "foo";
      var arg_clientAccountId = "foo";
      var arg_invitationId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/clients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/clients/"));
        pathOffset += 9;
        index = path.indexOf("/invitations/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_clientAccountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("/invitations/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_invitationId"));

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
        var resp = convert.JSON.encode(buildClientUserInvitation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_accountId, arg_clientAccountId, arg_invitationId)
          .then(unittest.expectAsync1(((api.ClientUserInvitation response) {
        checkClientUserInvitation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsClientsInvitationsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.clients.invitations;
      var arg_accountId = "foo";
      var arg_clientAccountId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/clients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/clients/"));
        pathOffset += 9;
        index = path.indexOf("/invitations", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_clientAccountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/invitations"));
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
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp =
            convert.JSON.encode(buildListClientUserInvitationsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_clientAccountId,
              pageToken: arg_pageToken, pageSize: arg_pageSize)
          .then(unittest
              .expectAsync1(((api.ListClientUserInvitationsResponse response) {
        checkListClientUserInvitationsResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsClientsUsersResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsClientsUsersResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.clients.users;
      var arg_accountId = "foo";
      var arg_clientAccountId = "foo";
      var arg_userId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/clients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/clients/"));
        pathOffset += 9;
        index = path.indexOf("/users/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_clientAccountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7),
            unittest.equals("/users/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_userId"));

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
        var resp = convert.JSON.encode(buildClientUser());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_accountId, arg_clientAccountId, arg_userId)
          .then(unittest.expectAsync1(((api.ClientUser response) {
        checkClientUser(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsClientsUsersResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.clients.users;
      var arg_accountId = "foo";
      var arg_clientAccountId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/clients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/clients/"));
        pathOffset += 9;
        index = path.indexOf("/users", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_clientAccountId"));
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
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListClientUsersResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_clientAccountId,
              pageToken: arg_pageToken, pageSize: arg_pageSize)
          .then(unittest.expectAsync1(((api.ListClientUsersResponse response) {
        checkListClientUsersResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsClientsUsersResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.clients.users;
      var arg_request = buildClientUser();
      var arg_accountId = "foo";
      var arg_clientAccountId = "foo";
      var arg_userId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ClientUser.fromJson(json);
        checkClientUser(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/clients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/clients/"));
        pathOffset += 9;
        index = path.indexOf("/users/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_clientAccountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7),
            unittest.equals("/users/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_userId"));

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
        var resp = convert.JSON.encode(buildClientUser());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_accountId, arg_clientAccountId, arg_userId)
          .then(unittest.expectAsync1(((api.ClientUser response) {
        checkClientUser(response);
      })));
    });
  });

  unittest.group("resource-AccountsCreativesResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsCreativesResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.creatives;
      var arg_request = buildCreative();
      var arg_accountId = "foo";
      var arg_duplicateIdMode = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Creative.fromJson(json);
        checkCreative(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/creatives", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("/creatives"));
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
        unittest.expect(queryMap["duplicateIdMode"].first,
            unittest.equals(arg_duplicateIdMode));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCreative());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_accountId,
              duplicateIdMode: arg_duplicateIdMode)
          .then(unittest.expectAsync1(((api.Creative response) {
        checkCreative(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsCreativesResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.creatives;
      var arg_accountId = "foo";
      var arg_creativeId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/creatives/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/creatives/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_creativeId"));

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
        var resp = convert.JSON.encode(buildCreative());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_accountId, arg_creativeId)
          .then(unittest.expectAsync1(((api.Creative response) {
        checkCreative(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsCreativesResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.creatives;
      var arg_accountId = "foo";
      var arg_query = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/creatives", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("/creatives"));
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
        unittest.expect(queryMap["query"].first, unittest.equals(arg_query));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListCreativesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId,
              query: arg_query,
              pageToken: arg_pageToken,
              pageSize: arg_pageSize)
          .then(unittest.expectAsync1(((api.ListCreativesResponse response) {
        checkListCreativesResponse(response);
      })));
    });

    unittest.test("method--stopWatching", () {
      var mock = new HttpServerMock();
      api.AccountsCreativesResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.creatives;
      var arg_request = buildStopWatchingCreativeRequest();
      var arg_accountId = "foo";
      var arg_creativeId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.StopWatchingCreativeRequest.fromJson(json);
        checkStopWatchingCreativeRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/creatives/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/creatives/"));
        pathOffset += 11;
        index = path.indexOf(":stopWatching", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_creativeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals(":stopWatching"));
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
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .stopWatching(arg_request, arg_accountId, arg_creativeId)
          .then(unittest.expectAsync1(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsCreativesResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.creatives;
      var arg_request = buildCreative();
      var arg_accountId = "foo";
      var arg_creativeId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Creative.fromJson(json);
        checkCreative(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/creatives/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/creatives/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_creativeId"));

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
        var resp = convert.JSON.encode(buildCreative());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_accountId, arg_creativeId)
          .then(unittest.expectAsync1(((api.Creative response) {
        checkCreative(response);
      })));
    });

    unittest.test("method--watch", () {
      var mock = new HttpServerMock();
      api.AccountsCreativesResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.creatives;
      var arg_request = buildWatchCreativeRequest();
      var arg_accountId = "foo";
      var arg_creativeId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.WatchCreativeRequest.fromJson(json);
        checkWatchCreativeRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/creatives/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/creatives/"));
        pathOffset += 11;
        index = path.indexOf(":watch", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_creativeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6),
            unittest.equals(":watch"));
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
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .watch(arg_request, arg_accountId, arg_creativeId)
          .then(unittest.expectAsync1(((api.Empty response) {
        checkEmpty(response);
      })));
    });
  });

  unittest.group("resource-AccountsCreativesDealAssociationsResourceApi", () {
    unittest.test("method--add", () {
      var mock = new HttpServerMock();
      api.AccountsCreativesDealAssociationsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.creatives.dealAssociations;
      var arg_request = buildAddDealAssociationRequest();
      var arg_accountId = "foo";
      var arg_creativeId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.AddDealAssociationRequest.fromJson(json);
        checkAddDealAssociationRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/creatives/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/creatives/"));
        pathOffset += 11;
        index = path.indexOf("/dealAssociations:add", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_creativeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 21),
            unittest.equals("/dealAssociations:add"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .add(arg_request, arg_accountId, arg_creativeId)
          .then(unittest.expectAsync1(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsCreativesDealAssociationsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.creatives.dealAssociations;
      var arg_accountId = "foo";
      var arg_creativeId = "foo";
      var arg_pageToken = "foo";
      var arg_pageSize = 42;
      var arg_query = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/creatives/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/creatives/"));
        pathOffset += 11;
        index = path.indexOf("/dealAssociations", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_creativeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("/dealAssociations"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));
        unittest.expect(queryMap["query"].first, unittest.equals(arg_query));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListDealAssociationsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_creativeId,
              pageToken: arg_pageToken,
              pageSize: arg_pageSize,
              query: arg_query)
          .then(unittest
              .expectAsync1(((api.ListDealAssociationsResponse response) {
        checkListDealAssociationsResponse(response);
      })));
    });

    unittest.test("method--remove", () {
      var mock = new HttpServerMock();
      api.AccountsCreativesDealAssociationsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.creatives.dealAssociations;
      var arg_request = buildRemoveDealAssociationRequest();
      var arg_accountId = "foo";
      var arg_creativeId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.RemoveDealAssociationRequest.fromJson(json);
        checkRemoveDealAssociationRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/creatives/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/creatives/"));
        pathOffset += 11;
        index = path.indexOf("/dealAssociations:remove", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_creativeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 24),
            unittest.equals("/dealAssociations:remove"));
        pathOffset += 24;

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
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .remove(arg_request, arg_accountId, arg_creativeId)
          .then(unittest.expectAsync1(((api.Empty response) {
        checkEmpty(response);
      })));
    });
  });

  unittest.group("resource-AccountsFilterSetsResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.filterSets;
      var arg_request = buildFilterSet();
      var arg_accountId = "foo";
      var arg_isTransient = true;
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.FilterSet.fromJson(json);
        checkFilterSet(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/filterSets"));
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
            queryMap["isTransient"].first, unittest.equals("$arg_isTransient"));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildFilterSet());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_accountId, isTransient: arg_isTransient)
          .then(unittest.expectAsync1(((api.FilterSet response) {
        checkFilterSet(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.filterSets;
      var arg_accountId = "foo";
      var arg_filterSetId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/filterSets/"));
        pathOffset += 12;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_filterSetId"));

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
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_accountId, arg_filterSetId)
          .then(unittest.expectAsync1(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.filterSets;
      var arg_accountId = "foo";
      var arg_filterSetId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/filterSets/"));
        pathOffset += 12;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_filterSetId"));

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
        var resp = convert.JSON.encode(buildFilterSet());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_accountId, arg_filterSetId)
          .then(unittest.expectAsync1(((api.FilterSet response) {
        checkFilterSet(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.filterSets;
      var arg_accountId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/filterSets"));
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListFilterSetsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, pageToken: arg_pageToken, pageSize: arg_pageSize)
          .then(unittest.expectAsync1(((api.ListFilterSetsResponse response) {
        checkListFilterSetsResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsFilterSetsBidMetricsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsBidMetricsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.filterSets.bidMetrics;
      var arg_accountId = "foo";
      var arg_filterSetId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/filterSets/"));
        pathOffset += 12;
        index = path.indexOf("/bidMetrics", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_filterSetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/bidMetrics"));
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListBidMetricsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_filterSetId,
              pageToken: arg_pageToken, pageSize: arg_pageSize)
          .then(unittest.expectAsync1(((api.ListBidMetricsResponse response) {
        checkListBidMetricsResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsFilterSetsBidResponseErrorsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsBidResponseErrorsResourceApi res =
          new api.Adexchangebuyer2Api(mock)
              .accounts
              .filterSets
              .bidResponseErrors;
      var arg_accountId = "foo";
      var arg_filterSetId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/filterSets/"));
        pathOffset += 12;
        index = path.indexOf("/bidResponseErrors", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_filterSetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 18),
            unittest.equals("/bidResponseErrors"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListBidResponseErrorsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_filterSetId,
              pageToken: arg_pageToken, pageSize: arg_pageSize)
          .then(unittest
              .expectAsync1(((api.ListBidResponseErrorsResponse response) {
        checkListBidResponseErrorsResponse(response);
      })));
    });
  });

  unittest.group(
      "resource-AccountsFilterSetsBidResponsesWithoutBidsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsBidResponsesWithoutBidsResourceApi res =
          new api.Adexchangebuyer2Api(mock)
              .accounts
              .filterSets
              .bidResponsesWithoutBids;
      var arg_accountId = "foo";
      var arg_filterSetId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/filterSets/"));
        pathOffset += 12;
        index = path.indexOf("/bidResponsesWithoutBids", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_filterSetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 24),
            unittest.equals("/bidResponsesWithoutBids"));
        pathOffset += 24;

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

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp =
            convert.JSON.encode(buildListBidResponsesWithoutBidsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_filterSetId,
              pageToken: arg_pageToken, pageSize: arg_pageSize)
          .then(unittest.expectAsync1(
              ((api.ListBidResponsesWithoutBidsResponse response) {
        checkListBidResponsesWithoutBidsResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsFilterSetsFilteredBidRequestsResourceApi",
      () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsFilteredBidRequestsResourceApi res =
          new api.Adexchangebuyer2Api(mock)
              .accounts
              .filterSets
              .filteredBidRequests;
      var arg_accountId = "foo";
      var arg_filterSetId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/filterSets/"));
        pathOffset += 12;
        index = path.indexOf("/filteredBidRequests", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_filterSetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 20),
            unittest.equals("/filteredBidRequests"));
        pathOffset += 20;

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

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListFilteredBidRequestsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_filterSetId,
              pageToken: arg_pageToken, pageSize: arg_pageSize)
          .then(unittest
              .expectAsync1(((api.ListFilteredBidRequestsResponse response) {
        checkListFilteredBidRequestsResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsFilterSetsFilteredBidsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsFilteredBidsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.filterSets.filteredBids;
      var arg_accountId = "foo";
      var arg_filterSetId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/filterSets/"));
        pathOffset += 12;
        index = path.indexOf("/filteredBids", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_filterSetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("/filteredBids"));
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
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListFilteredBidsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_filterSetId,
              pageToken: arg_pageToken, pageSize: arg_pageSize)
          .then(unittest.expectAsync1(((api.ListFilteredBidsResponse response) {
        checkListFilteredBidsResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsFilterSetsFilteredBidsCreativesResourceApi",
      () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsFilteredBidsCreativesResourceApi res =
          new api.Adexchangebuyer2Api(mock)
              .accounts
              .filterSets
              .filteredBids
              .creatives;
      var arg_accountId = "foo";
      var arg_filterSetId = "foo";
      var arg_creativeStatusId = 42;
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/filterSets/"));
        pathOffset += 12;
        index = path.indexOf("/filteredBids/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_filterSetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 14),
            unittest.equals("/filteredBids/"));
        pathOffset += 14;
        index = path.indexOf("/creatives", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_creativeStatusId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("/creatives"));
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
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON
            .encode(buildListCreativeStatusBreakdownByCreativeResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_filterSetId, arg_creativeStatusId,
              pageToken: arg_pageToken, pageSize: arg_pageSize)
          .then(unittest.expectAsync1(
              ((api.ListCreativeStatusBreakdownByCreativeResponse response) {
        checkListCreativeStatusBreakdownByCreativeResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsFilterSetsFilteredBidsDetailsResourceApi",
      () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsFilteredBidsDetailsResourceApi res =
          new api.Adexchangebuyer2Api(mock)
              .accounts
              .filterSets
              .filteredBids
              .details;
      var arg_accountId = "foo";
      var arg_filterSetId = "foo";
      var arg_creativeStatusId = 42;
      var arg_pageSize = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/filterSets/"));
        pathOffset += 12;
        index = path.indexOf("/filteredBids/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_filterSetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 14),
            unittest.equals("/filteredBids/"));
        pathOffset += 14;
        index = path.indexOf("/details", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_creativeStatusId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("/details"));
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
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON
            .encode(buildListCreativeStatusBreakdownByDetailResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_filterSetId, arg_creativeStatusId,
              pageSize: arg_pageSize, pageToken: arg_pageToken)
          .then(unittest.expectAsync1(
              ((api.ListCreativeStatusBreakdownByDetailResponse response) {
        checkListCreativeStatusBreakdownByDetailResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsFilterSetsImpressionMetricsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsImpressionMetricsResourceApi res =
          new api.Adexchangebuyer2Api(mock)
              .accounts
              .filterSets
              .impressionMetrics;
      var arg_accountId = "foo";
      var arg_filterSetId = "foo";
      var arg_pageSize = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/filterSets/"));
        pathOffset += 12;
        index = path.indexOf("/impressionMetrics", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_filterSetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 18),
            unittest.equals("/impressionMetrics"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListImpressionMetricsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_filterSetId,
              pageSize: arg_pageSize, pageToken: arg_pageToken)
          .then(unittest
              .expectAsync1(((api.ListImpressionMetricsResponse response) {
        checkListImpressionMetricsResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsFilterSetsLosingBidsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsLosingBidsResourceApi res =
          new api.Adexchangebuyer2Api(mock).accounts.filterSets.losingBids;
      var arg_accountId = "foo";
      var arg_filterSetId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/filterSets/"));
        pathOffset += 12;
        index = path.indexOf("/losingBids", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_filterSetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/losingBids"));
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListLosingBidsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_filterSetId,
              pageToken: arg_pageToken, pageSize: arg_pageSize)
          .then(unittest.expectAsync1(((api.ListLosingBidsResponse response) {
        checkListLosingBidsResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsFilterSetsNonBillableWinningBidsResourceApi",
      () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsFilterSetsNonBillableWinningBidsResourceApi res =
          new api.Adexchangebuyer2Api(mock)
              .accounts
              .filterSets
              .nonBillableWinningBids;
      var arg_accountId = "foo";
      var arg_filterSetId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v2beta1/accounts/"));
        pathOffset += 17;
        index = path.indexOf("/filterSets/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/filterSets/"));
        pathOffset += 12;
        index = path.indexOf("/nonBillableWinningBids", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_filterSetId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 23),
            unittest.equals("/nonBillableWinningBids"));
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
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp =
            convert.JSON.encode(buildListNonBillableWinningBidsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_filterSetId,
              pageToken: arg_pageToken, pageSize: arg_pageSize)
          .then(unittest
              .expectAsync1(((api.ListNonBillableWinningBidsResponse response) {
        checkListNonBillableWinningBidsResponse(response);
      })));
    });
  });
}
