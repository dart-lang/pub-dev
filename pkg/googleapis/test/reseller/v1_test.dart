library googleapis.reseller.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/reseller/v1.dart' as api;

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

core.int buildCounterAddress = 0;
buildAddress() {
  var o = new api.Address();
  buildCounterAddress++;
  if (buildCounterAddress < 3) {
    o.addressLine1 = "foo";
    o.addressLine2 = "foo";
    o.addressLine3 = "foo";
    o.contactName = "foo";
    o.countryCode = "foo";
    o.kind = "foo";
    o.locality = "foo";
    o.organizationName = "foo";
    o.postalCode = "foo";
    o.region = "foo";
  }
  buildCounterAddress--;
  return o;
}

checkAddress(api.Address o) {
  buildCounterAddress++;
  if (buildCounterAddress < 3) {
    unittest.expect(o.addressLine1, unittest.equals('foo'));
    unittest.expect(o.addressLine2, unittest.equals('foo'));
    unittest.expect(o.addressLine3, unittest.equals('foo'));
    unittest.expect(o.contactName, unittest.equals('foo'));
    unittest.expect(o.countryCode, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.locality, unittest.equals('foo'));
    unittest.expect(o.organizationName, unittest.equals('foo'));
    unittest.expect(o.postalCode, unittest.equals('foo'));
    unittest.expect(o.region, unittest.equals('foo'));
  }
  buildCounterAddress--;
}

core.int buildCounterChangePlanRequest = 0;
buildChangePlanRequest() {
  var o = new api.ChangePlanRequest();
  buildCounterChangePlanRequest++;
  if (buildCounterChangePlanRequest < 3) {
    o.dealCode = "foo";
    o.kind = "foo";
    o.planName = "foo";
    o.purchaseOrderId = "foo";
    o.seats = buildSeats();
  }
  buildCounterChangePlanRequest--;
  return o;
}

checkChangePlanRequest(api.ChangePlanRequest o) {
  buildCounterChangePlanRequest++;
  if (buildCounterChangePlanRequest < 3) {
    unittest.expect(o.dealCode, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.planName, unittest.equals('foo'));
    unittest.expect(o.purchaseOrderId, unittest.equals('foo'));
    checkSeats(o.seats);
  }
  buildCounterChangePlanRequest--;
}

core.int buildCounterCustomer = 0;
buildCustomer() {
  var o = new api.Customer();
  buildCounterCustomer++;
  if (buildCounterCustomer < 3) {
    o.alternateEmail = "foo";
    o.customerDomain = "foo";
    o.customerDomainVerified = true;
    o.customerId = "foo";
    o.kind = "foo";
    o.phoneNumber = "foo";
    o.postalAddress = buildAddress();
    o.resourceUiUrl = "foo";
  }
  buildCounterCustomer--;
  return o;
}

checkCustomer(api.Customer o) {
  buildCounterCustomer++;
  if (buildCounterCustomer < 3) {
    unittest.expect(o.alternateEmail, unittest.equals('foo'));
    unittest.expect(o.customerDomain, unittest.equals('foo'));
    unittest.expect(o.customerDomainVerified, unittest.isTrue);
    unittest.expect(o.customerId, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.phoneNumber, unittest.equals('foo'));
    checkAddress(o.postalAddress);
    unittest.expect(o.resourceUiUrl, unittest.equals('foo'));
  }
  buildCounterCustomer--;
}

core.int buildCounterRenewalSettings = 0;
buildRenewalSettings() {
  var o = new api.RenewalSettings();
  buildCounterRenewalSettings++;
  if (buildCounterRenewalSettings < 3) {
    o.kind = "foo";
    o.renewalType = "foo";
  }
  buildCounterRenewalSettings--;
  return o;
}

checkRenewalSettings(api.RenewalSettings o) {
  buildCounterRenewalSettings++;
  if (buildCounterRenewalSettings < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.renewalType, unittest.equals('foo'));
  }
  buildCounterRenewalSettings--;
}

buildUnnamed2079() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2079(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterResellernotifyGetwatchdetailsResponse = 0;
buildResellernotifyGetwatchdetailsResponse() {
  var o = new api.ResellernotifyGetwatchdetailsResponse();
  buildCounterResellernotifyGetwatchdetailsResponse++;
  if (buildCounterResellernotifyGetwatchdetailsResponse < 3) {
    o.serviceAccountEmailAddresses = buildUnnamed2079();
    o.topicName = "foo";
  }
  buildCounterResellernotifyGetwatchdetailsResponse--;
  return o;
}

checkResellernotifyGetwatchdetailsResponse(api.ResellernotifyGetwatchdetailsResponse o) {
  buildCounterResellernotifyGetwatchdetailsResponse++;
  if (buildCounterResellernotifyGetwatchdetailsResponse < 3) {
    checkUnnamed2079(o.serviceAccountEmailAddresses);
    unittest.expect(o.topicName, unittest.equals('foo'));
  }
  buildCounterResellernotifyGetwatchdetailsResponse--;
}

core.int buildCounterResellernotifyResource = 0;
buildResellernotifyResource() {
  var o = new api.ResellernotifyResource();
  buildCounterResellernotifyResource++;
  if (buildCounterResellernotifyResource < 3) {
    o.topicName = "foo";
  }
  buildCounterResellernotifyResource--;
  return o;
}

checkResellernotifyResource(api.ResellernotifyResource o) {
  buildCounterResellernotifyResource++;
  if (buildCounterResellernotifyResource < 3) {
    unittest.expect(o.topicName, unittest.equals('foo'));
  }
  buildCounterResellernotifyResource--;
}

core.int buildCounterSeats = 0;
buildSeats() {
  var o = new api.Seats();
  buildCounterSeats++;
  if (buildCounterSeats < 3) {
    o.kind = "foo";
    o.licensedNumberOfSeats = 42;
    o.maximumNumberOfSeats = 42;
    o.numberOfSeats = 42;
  }
  buildCounterSeats--;
  return o;
}

checkSeats(api.Seats o) {
  buildCounterSeats++;
  if (buildCounterSeats < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.licensedNumberOfSeats, unittest.equals(42));
    unittest.expect(o.maximumNumberOfSeats, unittest.equals(42));
    unittest.expect(o.numberOfSeats, unittest.equals(42));
  }
  buildCounterSeats--;
}

core.int buildCounterSubscriptionPlanCommitmentInterval = 0;
buildSubscriptionPlanCommitmentInterval() {
  var o = new api.SubscriptionPlanCommitmentInterval();
  buildCounterSubscriptionPlanCommitmentInterval++;
  if (buildCounterSubscriptionPlanCommitmentInterval < 3) {
    o.endTime = "foo";
    o.startTime = "foo";
  }
  buildCounterSubscriptionPlanCommitmentInterval--;
  return o;
}

checkSubscriptionPlanCommitmentInterval(api.SubscriptionPlanCommitmentInterval o) {
  buildCounterSubscriptionPlanCommitmentInterval++;
  if (buildCounterSubscriptionPlanCommitmentInterval < 3) {
    unittest.expect(o.endTime, unittest.equals('foo'));
    unittest.expect(o.startTime, unittest.equals('foo'));
  }
  buildCounterSubscriptionPlanCommitmentInterval--;
}

core.int buildCounterSubscriptionPlan = 0;
buildSubscriptionPlan() {
  var o = new api.SubscriptionPlan();
  buildCounterSubscriptionPlan++;
  if (buildCounterSubscriptionPlan < 3) {
    o.commitmentInterval = buildSubscriptionPlanCommitmentInterval();
    o.isCommitmentPlan = true;
    o.planName = "foo";
  }
  buildCounterSubscriptionPlan--;
  return o;
}

checkSubscriptionPlan(api.SubscriptionPlan o) {
  buildCounterSubscriptionPlan++;
  if (buildCounterSubscriptionPlan < 3) {
    checkSubscriptionPlanCommitmentInterval(o.commitmentInterval);
    unittest.expect(o.isCommitmentPlan, unittest.isTrue);
    unittest.expect(o.planName, unittest.equals('foo'));
  }
  buildCounterSubscriptionPlan--;
}

buildUnnamed2080() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2080(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterSubscriptionTransferInfo = 0;
buildSubscriptionTransferInfo() {
  var o = new api.SubscriptionTransferInfo();
  buildCounterSubscriptionTransferInfo++;
  if (buildCounterSubscriptionTransferInfo < 3) {
    o.minimumTransferableSeats = 42;
    o.transferabilityExpirationTime = "foo";
  }
  buildCounterSubscriptionTransferInfo--;
  return o;
}

checkSubscriptionTransferInfo(api.SubscriptionTransferInfo o) {
  buildCounterSubscriptionTransferInfo++;
  if (buildCounterSubscriptionTransferInfo < 3) {
    unittest.expect(o.minimumTransferableSeats, unittest.equals(42));
    unittest.expect(o.transferabilityExpirationTime, unittest.equals('foo'));
  }
  buildCounterSubscriptionTransferInfo--;
}

core.int buildCounterSubscriptionTrialSettings = 0;
buildSubscriptionTrialSettings() {
  var o = new api.SubscriptionTrialSettings();
  buildCounterSubscriptionTrialSettings++;
  if (buildCounterSubscriptionTrialSettings < 3) {
    o.isInTrial = true;
    o.trialEndTime = "foo";
  }
  buildCounterSubscriptionTrialSettings--;
  return o;
}

checkSubscriptionTrialSettings(api.SubscriptionTrialSettings o) {
  buildCounterSubscriptionTrialSettings++;
  if (buildCounterSubscriptionTrialSettings < 3) {
    unittest.expect(o.isInTrial, unittest.isTrue);
    unittest.expect(o.trialEndTime, unittest.equals('foo'));
  }
  buildCounterSubscriptionTrialSettings--;
}

core.int buildCounterSubscription = 0;
buildSubscription() {
  var o = new api.Subscription();
  buildCounterSubscription++;
  if (buildCounterSubscription < 3) {
    o.billingMethod = "foo";
    o.creationTime = "foo";
    o.customerDomain = "foo";
    o.customerId = "foo";
    o.dealCode = "foo";
    o.kind = "foo";
    o.plan = buildSubscriptionPlan();
    o.purchaseOrderId = "foo";
    o.renewalSettings = buildRenewalSettings();
    o.resourceUiUrl = "foo";
    o.seats = buildSeats();
    o.skuId = "foo";
    o.status = "foo";
    o.subscriptionId = "foo";
    o.suspensionReasons = buildUnnamed2080();
    o.transferInfo = buildSubscriptionTransferInfo();
    o.trialSettings = buildSubscriptionTrialSettings();
  }
  buildCounterSubscription--;
  return o;
}

checkSubscription(api.Subscription o) {
  buildCounterSubscription++;
  if (buildCounterSubscription < 3) {
    unittest.expect(o.billingMethod, unittest.equals('foo'));
    unittest.expect(o.creationTime, unittest.equals('foo'));
    unittest.expect(o.customerDomain, unittest.equals('foo'));
    unittest.expect(o.customerId, unittest.equals('foo'));
    unittest.expect(o.dealCode, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkSubscriptionPlan(o.plan);
    unittest.expect(o.purchaseOrderId, unittest.equals('foo'));
    checkRenewalSettings(o.renewalSettings);
    unittest.expect(o.resourceUiUrl, unittest.equals('foo'));
    checkSeats(o.seats);
    unittest.expect(o.skuId, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.subscriptionId, unittest.equals('foo'));
    checkUnnamed2080(o.suspensionReasons);
    checkSubscriptionTransferInfo(o.transferInfo);
    checkSubscriptionTrialSettings(o.trialSettings);
  }
  buildCounterSubscription--;
}

buildUnnamed2081() {
  var o = new core.List<api.Subscription>();
  o.add(buildSubscription());
  o.add(buildSubscription());
  return o;
}

checkUnnamed2081(core.List<api.Subscription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSubscription(o[0]);
  checkSubscription(o[1]);
}

core.int buildCounterSubscriptions = 0;
buildSubscriptions() {
  var o = new api.Subscriptions();
  buildCounterSubscriptions++;
  if (buildCounterSubscriptions < 3) {
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.subscriptions = buildUnnamed2081();
  }
  buildCounterSubscriptions--;
  return o;
}

checkSubscriptions(api.Subscriptions o) {
  buildCounterSubscriptions++;
  if (buildCounterSubscriptions < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed2081(o.subscriptions);
  }
  buildCounterSubscriptions--;
}


main() {
  unittest.group("obj-schema-Address", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddress();
      var od = new api.Address.fromJson(o.toJson());
      checkAddress(od);
    });
  });


  unittest.group("obj-schema-ChangePlanRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildChangePlanRequest();
      var od = new api.ChangePlanRequest.fromJson(o.toJson());
      checkChangePlanRequest(od);
    });
  });


  unittest.group("obj-schema-Customer", () {
    unittest.test("to-json--from-json", () {
      var o = buildCustomer();
      var od = new api.Customer.fromJson(o.toJson());
      checkCustomer(od);
    });
  });


  unittest.group("obj-schema-RenewalSettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildRenewalSettings();
      var od = new api.RenewalSettings.fromJson(o.toJson());
      checkRenewalSettings(od);
    });
  });


  unittest.group("obj-schema-ResellernotifyGetwatchdetailsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildResellernotifyGetwatchdetailsResponse();
      var od = new api.ResellernotifyGetwatchdetailsResponse.fromJson(o.toJson());
      checkResellernotifyGetwatchdetailsResponse(od);
    });
  });


  unittest.group("obj-schema-ResellernotifyResource", () {
    unittest.test("to-json--from-json", () {
      var o = buildResellernotifyResource();
      var od = new api.ResellernotifyResource.fromJson(o.toJson());
      checkResellernotifyResource(od);
    });
  });


  unittest.group("obj-schema-Seats", () {
    unittest.test("to-json--from-json", () {
      var o = buildSeats();
      var od = new api.Seats.fromJson(o.toJson());
      checkSeats(od);
    });
  });


  unittest.group("obj-schema-SubscriptionPlanCommitmentInterval", () {
    unittest.test("to-json--from-json", () {
      var o = buildSubscriptionPlanCommitmentInterval();
      var od = new api.SubscriptionPlanCommitmentInterval.fromJson(o.toJson());
      checkSubscriptionPlanCommitmentInterval(od);
    });
  });


  unittest.group("obj-schema-SubscriptionPlan", () {
    unittest.test("to-json--from-json", () {
      var o = buildSubscriptionPlan();
      var od = new api.SubscriptionPlan.fromJson(o.toJson());
      checkSubscriptionPlan(od);
    });
  });


  unittest.group("obj-schema-SubscriptionTransferInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildSubscriptionTransferInfo();
      var od = new api.SubscriptionTransferInfo.fromJson(o.toJson());
      checkSubscriptionTransferInfo(od);
    });
  });


  unittest.group("obj-schema-SubscriptionTrialSettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildSubscriptionTrialSettings();
      var od = new api.SubscriptionTrialSettings.fromJson(o.toJson());
      checkSubscriptionTrialSettings(od);
    });
  });


  unittest.group("obj-schema-Subscription", () {
    unittest.test("to-json--from-json", () {
      var o = buildSubscription();
      var od = new api.Subscription.fromJson(o.toJson());
      checkSubscription(od);
    });
  });


  unittest.group("obj-schema-Subscriptions", () {
    unittest.test("to-json--from-json", () {
      var o = buildSubscriptions();
      var od = new api.Subscriptions.fromJson(o.toJson());
      checkSubscriptions(od);
    });
  });


  unittest.group("resource-CustomersResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.CustomersResourceApi res = new api.ResellerApi(mock).customers;
      var arg_customerId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("customers/"));
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_customerId"));

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
        var resp = convert.JSON.encode(buildCustomer());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_customerId).then(unittest.expectAsync(((api.Customer response) {
        checkCustomer(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.CustomersResourceApi res = new api.ResellerApi(mock).customers;
      var arg_request = buildCustomer();
      var arg_customerAuthToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Customer.fromJson(json);
        checkCustomer(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("customers"));
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
        unittest.expect(queryMap["customerAuthToken"].first, unittest.equals(arg_customerAuthToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCustomer());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, customerAuthToken: arg_customerAuthToken).then(unittest.expectAsync(((api.Customer response) {
        checkCustomer(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.CustomersResourceApi res = new api.ResellerApi(mock).customers;
      var arg_request = buildCustomer();
      var arg_customerId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Customer.fromJson(json);
        checkCustomer(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("customers/"));
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_customerId"));

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
        var resp = convert.JSON.encode(buildCustomer());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_customerId).then(unittest.expectAsync(((api.Customer response) {
        checkCustomer(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.CustomersResourceApi res = new api.ResellerApi(mock).customers;
      var arg_request = buildCustomer();
      var arg_customerId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Customer.fromJson(json);
        checkCustomer(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("customers/"));
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_customerId"));

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
        var resp = convert.JSON.encode(buildCustomer());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_customerId).then(unittest.expectAsync(((api.Customer response) {
        checkCustomer(response);
      })));
    });

  });


  unittest.group("resource-ResellernotifyResourceApi", () {
    unittest.test("method--getwatchdetails", () {

      var mock = new HttpServerMock();
      api.ResellernotifyResourceApi res = new api.ResellerApi(mock).resellernotify;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 30), unittest.equals("resellernotify/getwatchdetails"));
        pathOffset += 30;

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
        var resp = convert.JSON.encode(buildResellernotifyGetwatchdetailsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getwatchdetails().then(unittest.expectAsync(((api.ResellernotifyGetwatchdetailsResponse response) {
        checkResellernotifyGetwatchdetailsResponse(response);
      })));
    });

    unittest.test("method--register", () {

      var mock = new HttpServerMock();
      api.ResellernotifyResourceApi res = new api.ResellerApi(mock).resellernotify;
      var arg_serviceAccountEmailAddress = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 23), unittest.equals("resellernotify/register"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["serviceAccountEmailAddress"].first, unittest.equals(arg_serviceAccountEmailAddress));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildResellernotifyResource());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.register(serviceAccountEmailAddress: arg_serviceAccountEmailAddress).then(unittest.expectAsync(((api.ResellernotifyResource response) {
        checkResellernotifyResource(response);
      })));
    });

    unittest.test("method--unregister", () {

      var mock = new HttpServerMock();
      api.ResellernotifyResourceApi res = new api.ResellerApi(mock).resellernotify;
      var arg_serviceAccountEmailAddress = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 25), unittest.equals("resellernotify/unregister"));
        pathOffset += 25;

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
        unittest.expect(queryMap["serviceAccountEmailAddress"].first, unittest.equals(arg_serviceAccountEmailAddress));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildResellernotifyResource());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.unregister(serviceAccountEmailAddress: arg_serviceAccountEmailAddress).then(unittest.expectAsync(((api.ResellernotifyResource response) {
        checkResellernotifyResource(response);
      })));
    });

  });


  unittest.group("resource-SubscriptionsResourceApi", () {
    unittest.test("method--activate", () {

      var mock = new HttpServerMock();
      api.SubscriptionsResourceApi res = new api.ResellerApi(mock).subscriptions;
      var arg_customerId = "foo";
      var arg_subscriptionId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("customers/"));
        pathOffset += 10;
        index = path.indexOf("/subscriptions/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_customerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("/subscriptions/"));
        pathOffset += 15;
        index = path.indexOf("/activate", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_subscriptionId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/activate"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSubscription());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.activate(arg_customerId, arg_subscriptionId).then(unittest.expectAsync(((api.Subscription response) {
        checkSubscription(response);
      })));
    });

    unittest.test("method--changePlan", () {

      var mock = new HttpServerMock();
      api.SubscriptionsResourceApi res = new api.ResellerApi(mock).subscriptions;
      var arg_request = buildChangePlanRequest();
      var arg_customerId = "foo";
      var arg_subscriptionId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ChangePlanRequest.fromJson(json);
        checkChangePlanRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("customers/"));
        pathOffset += 10;
        index = path.indexOf("/subscriptions/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_customerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("/subscriptions/"));
        pathOffset += 15;
        index = path.indexOf("/changePlan", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_subscriptionId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("/changePlan"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSubscription());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.changePlan(arg_request, arg_customerId, arg_subscriptionId).then(unittest.expectAsync(((api.Subscription response) {
        checkSubscription(response);
      })));
    });

    unittest.test("method--changeRenewalSettings", () {

      var mock = new HttpServerMock();
      api.SubscriptionsResourceApi res = new api.ResellerApi(mock).subscriptions;
      var arg_request = buildRenewalSettings();
      var arg_customerId = "foo";
      var arg_subscriptionId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.RenewalSettings.fromJson(json);
        checkRenewalSettings(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("customers/"));
        pathOffset += 10;
        index = path.indexOf("/subscriptions/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_customerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("/subscriptions/"));
        pathOffset += 15;
        index = path.indexOf("/changeRenewalSettings", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_subscriptionId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("/changeRenewalSettings"));
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
        var resp = convert.JSON.encode(buildSubscription());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.changeRenewalSettings(arg_request, arg_customerId, arg_subscriptionId).then(unittest.expectAsync(((api.Subscription response) {
        checkSubscription(response);
      })));
    });

    unittest.test("method--changeSeats", () {

      var mock = new HttpServerMock();
      api.SubscriptionsResourceApi res = new api.ResellerApi(mock).subscriptions;
      var arg_request = buildSeats();
      var arg_customerId = "foo";
      var arg_subscriptionId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Seats.fromJson(json);
        checkSeats(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("customers/"));
        pathOffset += 10;
        index = path.indexOf("/subscriptions/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_customerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("/subscriptions/"));
        pathOffset += 15;
        index = path.indexOf("/changeSeats", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_subscriptionId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("/changeSeats"));
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
        var resp = convert.JSON.encode(buildSubscription());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.changeSeats(arg_request, arg_customerId, arg_subscriptionId).then(unittest.expectAsync(((api.Subscription response) {
        checkSubscription(response);
      })));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.SubscriptionsResourceApi res = new api.ResellerApi(mock).subscriptions;
      var arg_customerId = "foo";
      var arg_subscriptionId = "foo";
      var arg_deletionType = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("customers/"));
        pathOffset += 10;
        index = path.indexOf("/subscriptions/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_customerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("/subscriptions/"));
        pathOffset += 15;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_subscriptionId"));

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
        unittest.expect(queryMap["deletionType"].first, unittest.equals(arg_deletionType));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_customerId, arg_subscriptionId, arg_deletionType).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.SubscriptionsResourceApi res = new api.ResellerApi(mock).subscriptions;
      var arg_customerId = "foo";
      var arg_subscriptionId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("customers/"));
        pathOffset += 10;
        index = path.indexOf("/subscriptions/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_customerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("/subscriptions/"));
        pathOffset += 15;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_subscriptionId"));

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
        var resp = convert.JSON.encode(buildSubscription());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_customerId, arg_subscriptionId).then(unittest.expectAsync(((api.Subscription response) {
        checkSubscription(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.SubscriptionsResourceApi res = new api.ResellerApi(mock).subscriptions;
      var arg_request = buildSubscription();
      var arg_customerId = "foo";
      var arg_customerAuthToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Subscription.fromJson(json);
        checkSubscription(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("customers/"));
        pathOffset += 10;
        index = path.indexOf("/subscriptions", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_customerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("/subscriptions"));
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
        unittest.expect(queryMap["customerAuthToken"].first, unittest.equals(arg_customerAuthToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSubscription());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_customerId, customerAuthToken: arg_customerAuthToken).then(unittest.expectAsync(((api.Subscription response) {
        checkSubscription(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.SubscriptionsResourceApi res = new api.ResellerApi(mock).subscriptions;
      var arg_customerAuthToken = "foo";
      var arg_customerId = "foo";
      var arg_customerNamePrefix = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("subscriptions"));
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
        unittest.expect(queryMap["customerAuthToken"].first, unittest.equals(arg_customerAuthToken));
        unittest.expect(queryMap["customerId"].first, unittest.equals(arg_customerId));
        unittest.expect(queryMap["customerNamePrefix"].first, unittest.equals(arg_customerNamePrefix));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSubscriptions());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(customerAuthToken: arg_customerAuthToken, customerId: arg_customerId, customerNamePrefix: arg_customerNamePrefix, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.Subscriptions response) {
        checkSubscriptions(response);
      })));
    });

    unittest.test("method--startPaidService", () {

      var mock = new HttpServerMock();
      api.SubscriptionsResourceApi res = new api.ResellerApi(mock).subscriptions;
      var arg_customerId = "foo";
      var arg_subscriptionId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("customers/"));
        pathOffset += 10;
        index = path.indexOf("/subscriptions/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_customerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("/subscriptions/"));
        pathOffset += 15;
        index = path.indexOf("/startPaidService", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_subscriptionId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("/startPaidService"));
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
        var resp = convert.JSON.encode(buildSubscription());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.startPaidService(arg_customerId, arg_subscriptionId).then(unittest.expectAsync(((api.Subscription response) {
        checkSubscription(response);
      })));
    });

    unittest.test("method--suspend", () {

      var mock = new HttpServerMock();
      api.SubscriptionsResourceApi res = new api.ResellerApi(mock).subscriptions;
      var arg_customerId = "foo";
      var arg_subscriptionId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("apps/reseller/v1/"));
        pathOffset += 17;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("customers/"));
        pathOffset += 10;
        index = path.indexOf("/subscriptions/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_customerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("/subscriptions/"));
        pathOffset += 15;
        index = path.indexOf("/suspend", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_subscriptionId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/suspend"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSubscription());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.suspend(arg_customerId, arg_subscriptionId).then(unittest.expectAsync(((api.Subscription response) {
        checkSubscription(response);
      })));
    });

  });


}

