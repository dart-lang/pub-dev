library googleapis_beta.proximitybeacon.v1beta1.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis_beta/proximitybeacon/v1beta1.dart' as api;

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

core.int buildCounterAdvertisedId = 0;
buildAdvertisedId() {
  var o = new api.AdvertisedId();
  buildCounterAdvertisedId++;
  if (buildCounterAdvertisedId < 3) {
    o.id = "foo";
    o.type = "foo";
  }
  buildCounterAdvertisedId--;
  return o;
}

checkAdvertisedId(api.AdvertisedId o) {
  buildCounterAdvertisedId++;
  if (buildCounterAdvertisedId < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterAdvertisedId--;
}

core.int buildCounterAttachmentInfo = 0;
buildAttachmentInfo() {
  var o = new api.AttachmentInfo();
  buildCounterAttachmentInfo++;
  if (buildCounterAttachmentInfo < 3) {
    o.data = "foo";
    o.namespacedType = "foo";
  }
  buildCounterAttachmentInfo--;
  return o;
}

checkAttachmentInfo(api.AttachmentInfo o) {
  buildCounterAttachmentInfo++;
  if (buildCounterAttachmentInfo < 3) {
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.namespacedType, unittest.equals('foo'));
  }
  buildCounterAttachmentInfo--;
}

buildUnnamed3464() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed3464(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterBeacon = 0;
buildBeacon() {
  var o = new api.Beacon();
  buildCounterBeacon++;
  if (buildCounterBeacon < 3) {
    o.advertisedId = buildAdvertisedId();
    o.beaconName = "foo";
    o.description = "foo";
    o.ephemeralIdRegistration = buildEphemeralIdRegistration();
    o.expectedStability = "foo";
    o.indoorLevel = buildIndoorLevel();
    o.latLng = buildLatLng();
    o.placeId = "foo";
    o.properties = buildUnnamed3464();
    o.provisioningKey = "foo";
    o.status = "foo";
  }
  buildCounterBeacon--;
  return o;
}

checkBeacon(api.Beacon o) {
  buildCounterBeacon++;
  if (buildCounterBeacon < 3) {
    checkAdvertisedId(o.advertisedId);
    unittest.expect(o.beaconName, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    checkEphemeralIdRegistration(o.ephemeralIdRegistration);
    unittest.expect(o.expectedStability, unittest.equals('foo'));
    checkIndoorLevel(o.indoorLevel);
    checkLatLng(o.latLng);
    unittest.expect(o.placeId, unittest.equals('foo'));
    checkUnnamed3464(o.properties);
    unittest.expect(o.provisioningKey, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterBeacon--;
}

core.int buildCounterBeaconAttachment = 0;
buildBeaconAttachment() {
  var o = new api.BeaconAttachment();
  buildCounterBeaconAttachment++;
  if (buildCounterBeaconAttachment < 3) {
    o.attachmentName = "foo";
    o.creationTimeMs = "foo";
    o.data = "foo";
    o.namespacedType = "foo";
  }
  buildCounterBeaconAttachment--;
  return o;
}

checkBeaconAttachment(api.BeaconAttachment o) {
  buildCounterBeaconAttachment++;
  if (buildCounterBeaconAttachment < 3) {
    unittest.expect(o.attachmentName, unittest.equals('foo'));
    unittest.expect(o.creationTimeMs, unittest.equals('foo'));
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.namespacedType, unittest.equals('foo'));
  }
  buildCounterBeaconAttachment--;
}

buildUnnamed3465() {
  var o = new core.List<api.AttachmentInfo>();
  o.add(buildAttachmentInfo());
  o.add(buildAttachmentInfo());
  return o;
}

checkUnnamed3465(core.List<api.AttachmentInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAttachmentInfo(o[0]);
  checkAttachmentInfo(o[1]);
}

core.int buildCounterBeaconInfo = 0;
buildBeaconInfo() {
  var o = new api.BeaconInfo();
  buildCounterBeaconInfo++;
  if (buildCounterBeaconInfo < 3) {
    o.advertisedId = buildAdvertisedId();
    o.attachments = buildUnnamed3465();
    o.beaconName = "foo";
  }
  buildCounterBeaconInfo--;
  return o;
}

checkBeaconInfo(api.BeaconInfo o) {
  buildCounterBeaconInfo++;
  if (buildCounterBeaconInfo < 3) {
    checkAdvertisedId(o.advertisedId);
    checkUnnamed3465(o.attachments);
    unittest.expect(o.beaconName, unittest.equals('foo'));
  }
  buildCounterBeaconInfo--;
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

core.int buildCounterDeleteAttachmentsResponse = 0;
buildDeleteAttachmentsResponse() {
  var o = new api.DeleteAttachmentsResponse();
  buildCounterDeleteAttachmentsResponse++;
  if (buildCounterDeleteAttachmentsResponse < 3) {
    o.numDeleted = 42;
  }
  buildCounterDeleteAttachmentsResponse--;
  return o;
}

checkDeleteAttachmentsResponse(api.DeleteAttachmentsResponse o) {
  buildCounterDeleteAttachmentsResponse++;
  if (buildCounterDeleteAttachmentsResponse < 3) {
    unittest.expect(o.numDeleted, unittest.equals(42));
  }
  buildCounterDeleteAttachmentsResponse--;
}

buildUnnamed3466() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3466(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterDiagnostics = 0;
buildDiagnostics() {
  var o = new api.Diagnostics();
  buildCounterDiagnostics++;
  if (buildCounterDiagnostics < 3) {
    o.alerts = buildUnnamed3466();
    o.beaconName = "foo";
    o.estimatedLowBatteryDate = buildDate();
  }
  buildCounterDiagnostics--;
  return o;
}

checkDiagnostics(api.Diagnostics o) {
  buildCounterDiagnostics++;
  if (buildCounterDiagnostics < 3) {
    checkUnnamed3466(o.alerts);
    unittest.expect(o.beaconName, unittest.equals('foo'));
    checkDate(o.estimatedLowBatteryDate);
  }
  buildCounterDiagnostics--;
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

core.int buildCounterEphemeralIdRegistration = 0;
buildEphemeralIdRegistration() {
  var o = new api.EphemeralIdRegistration();
  buildCounterEphemeralIdRegistration++;
  if (buildCounterEphemeralIdRegistration < 3) {
    o.beaconEcdhPublicKey = "foo";
    o.beaconIdentityKey = "foo";
    o.initialClockValue = "foo";
    o.initialEid = "foo";
    o.rotationPeriodExponent = 42;
    o.serviceEcdhPublicKey = "foo";
  }
  buildCounterEphemeralIdRegistration--;
  return o;
}

checkEphemeralIdRegistration(api.EphemeralIdRegistration o) {
  buildCounterEphemeralIdRegistration++;
  if (buildCounterEphemeralIdRegistration < 3) {
    unittest.expect(o.beaconEcdhPublicKey, unittest.equals('foo'));
    unittest.expect(o.beaconIdentityKey, unittest.equals('foo'));
    unittest.expect(o.initialClockValue, unittest.equals('foo'));
    unittest.expect(o.initialEid, unittest.equals('foo'));
    unittest.expect(o.rotationPeriodExponent, unittest.equals(42));
    unittest.expect(o.serviceEcdhPublicKey, unittest.equals('foo'));
  }
  buildCounterEphemeralIdRegistration--;
}

core.int buildCounterEphemeralIdRegistrationParams = 0;
buildEphemeralIdRegistrationParams() {
  var o = new api.EphemeralIdRegistrationParams();
  buildCounterEphemeralIdRegistrationParams++;
  if (buildCounterEphemeralIdRegistrationParams < 3) {
    o.maxRotationPeriodExponent = 42;
    o.minRotationPeriodExponent = 42;
    o.serviceEcdhPublicKey = "foo";
  }
  buildCounterEphemeralIdRegistrationParams--;
  return o;
}

checkEphemeralIdRegistrationParams(api.EphemeralIdRegistrationParams o) {
  buildCounterEphemeralIdRegistrationParams++;
  if (buildCounterEphemeralIdRegistrationParams < 3) {
    unittest.expect(o.maxRotationPeriodExponent, unittest.equals(42));
    unittest.expect(o.minRotationPeriodExponent, unittest.equals(42));
    unittest.expect(o.serviceEcdhPublicKey, unittest.equals('foo'));
  }
  buildCounterEphemeralIdRegistrationParams--;
}

buildUnnamed3467() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed3467(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed3468() {
  var o = new core.List<api.Observation>();
  o.add(buildObservation());
  o.add(buildObservation());
  return o;
}

checkUnnamed3468(core.List<api.Observation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkObservation(o[0]);
  checkObservation(o[1]);
}

core.int buildCounterGetInfoForObservedBeaconsRequest = 0;
buildGetInfoForObservedBeaconsRequest() {
  var o = new api.GetInfoForObservedBeaconsRequest();
  buildCounterGetInfoForObservedBeaconsRequest++;
  if (buildCounterGetInfoForObservedBeaconsRequest < 3) {
    o.namespacedTypes = buildUnnamed3467();
    o.observations = buildUnnamed3468();
  }
  buildCounterGetInfoForObservedBeaconsRequest--;
  return o;
}

checkGetInfoForObservedBeaconsRequest(api.GetInfoForObservedBeaconsRequest o) {
  buildCounterGetInfoForObservedBeaconsRequest++;
  if (buildCounterGetInfoForObservedBeaconsRequest < 3) {
    checkUnnamed3467(o.namespacedTypes);
    checkUnnamed3468(o.observations);
  }
  buildCounterGetInfoForObservedBeaconsRequest--;
}

buildUnnamed3469() {
  var o = new core.List<api.BeaconInfo>();
  o.add(buildBeaconInfo());
  o.add(buildBeaconInfo());
  return o;
}

checkUnnamed3469(core.List<api.BeaconInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBeaconInfo(o[0]);
  checkBeaconInfo(o[1]);
}

core.int buildCounterGetInfoForObservedBeaconsResponse = 0;
buildGetInfoForObservedBeaconsResponse() {
  var o = new api.GetInfoForObservedBeaconsResponse();
  buildCounterGetInfoForObservedBeaconsResponse++;
  if (buildCounterGetInfoForObservedBeaconsResponse < 3) {
    o.beacons = buildUnnamed3469();
  }
  buildCounterGetInfoForObservedBeaconsResponse--;
  return o;
}

checkGetInfoForObservedBeaconsResponse(
    api.GetInfoForObservedBeaconsResponse o) {
  buildCounterGetInfoForObservedBeaconsResponse++;
  if (buildCounterGetInfoForObservedBeaconsResponse < 3) {
    checkUnnamed3469(o.beacons);
  }
  buildCounterGetInfoForObservedBeaconsResponse--;
}

core.int buildCounterIndoorLevel = 0;
buildIndoorLevel() {
  var o = new api.IndoorLevel();
  buildCounterIndoorLevel++;
  if (buildCounterIndoorLevel < 3) {
    o.name = "foo";
  }
  buildCounterIndoorLevel--;
  return o;
}

checkIndoorLevel(api.IndoorLevel o) {
  buildCounterIndoorLevel++;
  if (buildCounterIndoorLevel < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterIndoorLevel--;
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

buildUnnamed3470() {
  var o = new core.List<api.BeaconAttachment>();
  o.add(buildBeaconAttachment());
  o.add(buildBeaconAttachment());
  return o;
}

checkUnnamed3470(core.List<api.BeaconAttachment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBeaconAttachment(o[0]);
  checkBeaconAttachment(o[1]);
}

core.int buildCounterListBeaconAttachmentsResponse = 0;
buildListBeaconAttachmentsResponse() {
  var o = new api.ListBeaconAttachmentsResponse();
  buildCounterListBeaconAttachmentsResponse++;
  if (buildCounterListBeaconAttachmentsResponse < 3) {
    o.attachments = buildUnnamed3470();
  }
  buildCounterListBeaconAttachmentsResponse--;
  return o;
}

checkListBeaconAttachmentsResponse(api.ListBeaconAttachmentsResponse o) {
  buildCounterListBeaconAttachmentsResponse++;
  if (buildCounterListBeaconAttachmentsResponse < 3) {
    checkUnnamed3470(o.attachments);
  }
  buildCounterListBeaconAttachmentsResponse--;
}

buildUnnamed3471() {
  var o = new core.List<api.Beacon>();
  o.add(buildBeacon());
  o.add(buildBeacon());
  return o;
}

checkUnnamed3471(core.List<api.Beacon> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBeacon(o[0]);
  checkBeacon(o[1]);
}

core.int buildCounterListBeaconsResponse = 0;
buildListBeaconsResponse() {
  var o = new api.ListBeaconsResponse();
  buildCounterListBeaconsResponse++;
  if (buildCounterListBeaconsResponse < 3) {
    o.beacons = buildUnnamed3471();
    o.nextPageToken = "foo";
    o.totalCount = "foo";
  }
  buildCounterListBeaconsResponse--;
  return o;
}

checkListBeaconsResponse(api.ListBeaconsResponse o) {
  buildCounterListBeaconsResponse++;
  if (buildCounterListBeaconsResponse < 3) {
    checkUnnamed3471(o.beacons);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.totalCount, unittest.equals('foo'));
  }
  buildCounterListBeaconsResponse--;
}

buildUnnamed3472() {
  var o = new core.List<api.Diagnostics>();
  o.add(buildDiagnostics());
  o.add(buildDiagnostics());
  return o;
}

checkUnnamed3472(core.List<api.Diagnostics> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDiagnostics(o[0]);
  checkDiagnostics(o[1]);
}

core.int buildCounterListDiagnosticsResponse = 0;
buildListDiagnosticsResponse() {
  var o = new api.ListDiagnosticsResponse();
  buildCounterListDiagnosticsResponse++;
  if (buildCounterListDiagnosticsResponse < 3) {
    o.diagnostics = buildUnnamed3472();
    o.nextPageToken = "foo";
  }
  buildCounterListDiagnosticsResponse--;
  return o;
}

checkListDiagnosticsResponse(api.ListDiagnosticsResponse o) {
  buildCounterListDiagnosticsResponse++;
  if (buildCounterListDiagnosticsResponse < 3) {
    checkUnnamed3472(o.diagnostics);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListDiagnosticsResponse--;
}

buildUnnamed3473() {
  var o = new core.List<api.Namespace>();
  o.add(buildNamespace());
  o.add(buildNamespace());
  return o;
}

checkUnnamed3473(core.List<api.Namespace> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkNamespace(o[0]);
  checkNamespace(o[1]);
}

core.int buildCounterListNamespacesResponse = 0;
buildListNamespacesResponse() {
  var o = new api.ListNamespacesResponse();
  buildCounterListNamespacesResponse++;
  if (buildCounterListNamespacesResponse < 3) {
    o.namespaces = buildUnnamed3473();
  }
  buildCounterListNamespacesResponse--;
  return o;
}

checkListNamespacesResponse(api.ListNamespacesResponse o) {
  buildCounterListNamespacesResponse++;
  if (buildCounterListNamespacesResponse < 3) {
    checkUnnamed3473(o.namespaces);
  }
  buildCounterListNamespacesResponse--;
}

core.int buildCounterNamespace = 0;
buildNamespace() {
  var o = new api.Namespace();
  buildCounterNamespace++;
  if (buildCounterNamespace < 3) {
    o.namespaceName = "foo";
    o.servingVisibility = "foo";
  }
  buildCounterNamespace--;
  return o;
}

checkNamespace(api.Namespace o) {
  buildCounterNamespace++;
  if (buildCounterNamespace < 3) {
    unittest.expect(o.namespaceName, unittest.equals('foo'));
    unittest.expect(o.servingVisibility, unittest.equals('foo'));
  }
  buildCounterNamespace--;
}

core.int buildCounterObservation = 0;
buildObservation() {
  var o = new api.Observation();
  buildCounterObservation++;
  if (buildCounterObservation < 3) {
    o.advertisedId = buildAdvertisedId();
    o.telemetry = "foo";
    o.timestampMs = "foo";
  }
  buildCounterObservation--;
  return o;
}

checkObservation(api.Observation o) {
  buildCounterObservation++;
  if (buildCounterObservation < 3) {
    checkAdvertisedId(o.advertisedId);
    unittest.expect(o.telemetry, unittest.equals('foo'));
    unittest.expect(o.timestampMs, unittest.equals('foo'));
  }
  buildCounterObservation--;
}

main() {
  unittest.group("obj-schema-AdvertisedId", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdvertisedId();
      var od = new api.AdvertisedId.fromJson(o.toJson());
      checkAdvertisedId(od);
    });
  });

  unittest.group("obj-schema-AttachmentInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildAttachmentInfo();
      var od = new api.AttachmentInfo.fromJson(o.toJson());
      checkAttachmentInfo(od);
    });
  });

  unittest.group("obj-schema-Beacon", () {
    unittest.test("to-json--from-json", () {
      var o = buildBeacon();
      var od = new api.Beacon.fromJson(o.toJson());
      checkBeacon(od);
    });
  });

  unittest.group("obj-schema-BeaconAttachment", () {
    unittest.test("to-json--from-json", () {
      var o = buildBeaconAttachment();
      var od = new api.BeaconAttachment.fromJson(o.toJson());
      checkBeaconAttachment(od);
    });
  });

  unittest.group("obj-schema-BeaconInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildBeaconInfo();
      var od = new api.BeaconInfo.fromJson(o.toJson());
      checkBeaconInfo(od);
    });
  });

  unittest.group("obj-schema-Date", () {
    unittest.test("to-json--from-json", () {
      var o = buildDate();
      var od = new api.Date.fromJson(o.toJson());
      checkDate(od);
    });
  });

  unittest.group("obj-schema-DeleteAttachmentsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteAttachmentsResponse();
      var od = new api.DeleteAttachmentsResponse.fromJson(o.toJson());
      checkDeleteAttachmentsResponse(od);
    });
  });

  unittest.group("obj-schema-Diagnostics", () {
    unittest.test("to-json--from-json", () {
      var o = buildDiagnostics();
      var od = new api.Diagnostics.fromJson(o.toJson());
      checkDiagnostics(od);
    });
  });

  unittest.group("obj-schema-Empty", () {
    unittest.test("to-json--from-json", () {
      var o = buildEmpty();
      var od = new api.Empty.fromJson(o.toJson());
      checkEmpty(od);
    });
  });

  unittest.group("obj-schema-EphemeralIdRegistration", () {
    unittest.test("to-json--from-json", () {
      var o = buildEphemeralIdRegistration();
      var od = new api.EphemeralIdRegistration.fromJson(o.toJson());
      checkEphemeralIdRegistration(od);
    });
  });

  unittest.group("obj-schema-EphemeralIdRegistrationParams", () {
    unittest.test("to-json--from-json", () {
      var o = buildEphemeralIdRegistrationParams();
      var od = new api.EphemeralIdRegistrationParams.fromJson(o.toJson());
      checkEphemeralIdRegistrationParams(od);
    });
  });

  unittest.group("obj-schema-GetInfoForObservedBeaconsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildGetInfoForObservedBeaconsRequest();
      var od = new api.GetInfoForObservedBeaconsRequest.fromJson(o.toJson());
      checkGetInfoForObservedBeaconsRequest(od);
    });
  });

  unittest.group("obj-schema-GetInfoForObservedBeaconsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildGetInfoForObservedBeaconsResponse();
      var od = new api.GetInfoForObservedBeaconsResponse.fromJson(o.toJson());
      checkGetInfoForObservedBeaconsResponse(od);
    });
  });

  unittest.group("obj-schema-IndoorLevel", () {
    unittest.test("to-json--from-json", () {
      var o = buildIndoorLevel();
      var od = new api.IndoorLevel.fromJson(o.toJson());
      checkIndoorLevel(od);
    });
  });

  unittest.group("obj-schema-LatLng", () {
    unittest.test("to-json--from-json", () {
      var o = buildLatLng();
      var od = new api.LatLng.fromJson(o.toJson());
      checkLatLng(od);
    });
  });

  unittest.group("obj-schema-ListBeaconAttachmentsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListBeaconAttachmentsResponse();
      var od = new api.ListBeaconAttachmentsResponse.fromJson(o.toJson());
      checkListBeaconAttachmentsResponse(od);
    });
  });

  unittest.group("obj-schema-ListBeaconsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListBeaconsResponse();
      var od = new api.ListBeaconsResponse.fromJson(o.toJson());
      checkListBeaconsResponse(od);
    });
  });

  unittest.group("obj-schema-ListDiagnosticsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListDiagnosticsResponse();
      var od = new api.ListDiagnosticsResponse.fromJson(o.toJson());
      checkListDiagnosticsResponse(od);
    });
  });

  unittest.group("obj-schema-ListNamespacesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListNamespacesResponse();
      var od = new api.ListNamespacesResponse.fromJson(o.toJson());
      checkListNamespacesResponse(od);
    });
  });

  unittest.group("obj-schema-Namespace", () {
    unittest.test("to-json--from-json", () {
      var o = buildNamespace();
      var od = new api.Namespace.fromJson(o.toJson());
      checkNamespace(od);
    });
  });

  unittest.group("obj-schema-Observation", () {
    unittest.test("to-json--from-json", () {
      var o = buildObservation();
      var od = new api.Observation.fromJson(o.toJson());
      checkObservation(od);
    });
  });

  unittest.group("resource-BeaconinfoResourceApi", () {
    unittest.test("method--getforobserved", () {
      var mock = new HttpServerMock();
      api.BeaconinfoResourceApi res =
          new api.ProximitybeaconApi(mock).beaconinfo;
      var arg_request = buildGetInfoForObservedBeaconsRequest();
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.GetInfoForObservedBeaconsRequest.fromJson(json);
        checkGetInfoForObservedBeaconsRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 33),
            unittest.equals("v1beta1/beaconinfo:getforobserved"));
        pathOffset += 33;

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
        var resp =
            convert.JSON.encode(buildGetInfoForObservedBeaconsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getforobserved(arg_request).then(unittest
          .expectAsync1(((api.GetInfoForObservedBeaconsResponse response) {
        checkGetInfoForObservedBeaconsResponse(response);
      })));
    });
  });

  unittest.group("resource-BeaconsResourceApi", () {
    unittest.test("method--activate", () {
      var mock = new HttpServerMock();
      api.BeaconsResourceApi res = new api.ProximitybeaconApi(mock).beacons;
      var arg_beaconName = "foo";
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v1beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .activate(arg_beaconName, projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--deactivate", () {
      var mock = new HttpServerMock();
      api.BeaconsResourceApi res = new api.ProximitybeaconApi(mock).beacons;
      var arg_beaconName = "foo";
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v1beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .deactivate(arg_beaconName, projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--decommission", () {
      var mock = new HttpServerMock();
      api.BeaconsResourceApi res = new api.ProximitybeaconApi(mock).beacons;
      var arg_beaconName = "foo";
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v1beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .decommission(arg_beaconName, projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.BeaconsResourceApi res = new api.ProximitybeaconApi(mock).beacons;
      var arg_beaconName = "foo";
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v1beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_beaconName, projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.BeaconsResourceApi res = new api.ProximitybeaconApi(mock).beacons;
      var arg_beaconName = "foo";
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v1beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBeacon());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_beaconName, projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.Beacon response) {
        checkBeacon(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.BeaconsResourceApi res = new api.ProximitybeaconApi(mock).beacons;
      var arg_pageToken = "foo";
      var arg_pageSize = 42;
      var arg_q = "foo";
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 15),
            unittest.equals("v1beta1/beacons"));
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
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));
        unittest.expect(queryMap["q"].first, unittest.equals(arg_q));
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListBeaconsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(
              pageToken: arg_pageToken,
              pageSize: arg_pageSize,
              q: arg_q,
              projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.ListBeaconsResponse response) {
        checkListBeaconsResponse(response);
      })));
    });

    unittest.test("method--register", () {
      var mock = new HttpServerMock();
      api.BeaconsResourceApi res = new api.ProximitybeaconApi(mock).beacons;
      var arg_request = buildBeacon();
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Beacon.fromJson(json);
        checkBeacon(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 24),
            unittest.equals("v1beta1/beacons:register"));
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
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBeacon());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .register(arg_request, projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.Beacon response) {
        checkBeacon(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.BeaconsResourceApi res = new api.ProximitybeaconApi(mock).beacons;
      var arg_request = buildBeacon();
      var arg_beaconName = "foo";
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Beacon.fromJson(json);
        checkBeacon(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v1beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBeacon());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_beaconName, projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.Beacon response) {
        checkBeacon(response);
      })));
    });
  });

  unittest.group("resource-BeaconsAttachmentsResourceApi", () {
    unittest.test("method--batchDelete", () {
      var mock = new HttpServerMock();
      api.BeaconsAttachmentsResourceApi res =
          new api.ProximitybeaconApi(mock).beacons.attachments;
      var arg_beaconName = "foo";
      var arg_projectId = "foo";
      var arg_namespacedType = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v1beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));
        unittest.expect(queryMap["namespacedType"].first,
            unittest.equals(arg_namespacedType));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildDeleteAttachmentsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .batchDelete(arg_beaconName,
              projectId: arg_projectId, namespacedType: arg_namespacedType)
          .then(
              unittest.expectAsync1(((api.DeleteAttachmentsResponse response) {
        checkDeleteAttachmentsResponse(response);
      })));
    });

    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.BeaconsAttachmentsResourceApi res =
          new api.ProximitybeaconApi(mock).beacons.attachments;
      var arg_request = buildBeaconAttachment();
      var arg_beaconName = "foo";
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.BeaconAttachment.fromJson(json);
        checkBeaconAttachment(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v1beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBeaconAttachment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_beaconName, projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.BeaconAttachment response) {
        checkBeaconAttachment(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.BeaconsAttachmentsResourceApi res =
          new api.ProximitybeaconApi(mock).beacons.attachments;
      var arg_attachmentName = "foo";
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v1beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_attachmentName, projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.Empty response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.BeaconsAttachmentsResourceApi res =
          new api.ProximitybeaconApi(mock).beacons.attachments;
      var arg_beaconName = "foo";
      var arg_namespacedType = "foo";
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v1beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["namespacedType"].first,
            unittest.equals(arg_namespacedType));
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListBeaconAttachmentsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_beaconName,
              namespacedType: arg_namespacedType, projectId: arg_projectId)
          .then(unittest
              .expectAsync1(((api.ListBeaconAttachmentsResponse response) {
        checkListBeaconAttachmentsResponse(response);
      })));
    });
  });

  unittest.group("resource-BeaconsDiagnosticsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.BeaconsDiagnosticsResourceApi res =
          new api.ProximitybeaconApi(mock).beacons.diagnostics;
      var arg_beaconName = "foo";
      var arg_pageToken = "foo";
      var arg_alertFilter = "foo";
      var arg_pageSize = 42;
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v1beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(
            queryMap["alertFilter"].first, unittest.equals(arg_alertFilter));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListDiagnosticsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_beaconName,
              pageToken: arg_pageToken,
              alertFilter: arg_alertFilter,
              pageSize: arg_pageSize,
              projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.ListDiagnosticsResponse response) {
        checkListDiagnosticsResponse(response);
      })));
    });
  });

  unittest.group("resource-NamespacesResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.NamespacesResourceApi res =
          new api.ProximitybeaconApi(mock).namespaces;
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 18),
            unittest.equals("v1beta1/namespaces"));
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
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildListNamespacesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.ListNamespacesResponse response) {
        checkListNamespacesResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.NamespacesResourceApi res =
          new api.ProximitybeaconApi(mock).namespaces;
      var arg_request = buildNamespace();
      var arg_namespaceName = "foo";
      var arg_projectId = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Namespace.fromJson(json);
        checkNamespace(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("v1beta1/"));
        pathOffset += 8;
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(
            queryMap["projectId"].first, unittest.equals(arg_projectId));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildNamespace());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_namespaceName, projectId: arg_projectId)
          .then(unittest.expectAsync1(((api.Namespace response) {
        checkNamespace(response);
      })));
    });
  });

  unittest.group("resource-V1beta1ResourceApi", () {
    unittest.test("method--getEidparams", () {
      var mock = new HttpServerMock();
      api.V1beta1ResourceApi res = new api.ProximitybeaconApi(mock).v1beta1;
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17),
            unittest.equals("v1beta1/eidparams"));
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

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEphemeralIdRegistrationParams());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getEidparams().then(
          unittest.expectAsync1(((api.EphemeralIdRegistrationParams response) {
        checkEphemeralIdRegistrationParams(response);
      })));
    });
  });
}
