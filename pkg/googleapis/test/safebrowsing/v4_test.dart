library googleapis.safebrowsing.v4.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/safebrowsing/v4.dart' as api;

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

core.int buildCounterChecksum = 0;
buildChecksum() {
  var o = new api.Checksum();
  buildCounterChecksum++;
  if (buildCounterChecksum < 3) {
    o.sha256 = "foo";
  }
  buildCounterChecksum--;
  return o;
}

checkChecksum(api.Checksum o) {
  buildCounterChecksum++;
  if (buildCounterChecksum < 3) {
    unittest.expect(o.sha256, unittest.equals('foo'));
  }
  buildCounterChecksum--;
}

core.int buildCounterClientInfo = 0;
buildClientInfo() {
  var o = new api.ClientInfo();
  buildCounterClientInfo++;
  if (buildCounterClientInfo < 3) {
    o.clientId = "foo";
    o.clientVersion = "foo";
  }
  buildCounterClientInfo--;
  return o;
}

checkClientInfo(api.ClientInfo o) {
  buildCounterClientInfo++;
  if (buildCounterClientInfo < 3) {
    unittest.expect(o.clientId, unittest.equals('foo'));
    unittest.expect(o.clientVersion, unittest.equals('foo'));
  }
  buildCounterClientInfo--;
}

buildUnnamed973() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed973(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterConstraints = 0;
buildConstraints() {
  var o = new api.Constraints();
  buildCounterConstraints++;
  if (buildCounterConstraints < 3) {
    o.maxDatabaseEntries = 42;
    o.maxUpdateEntries = 42;
    o.region = "foo";
    o.supportedCompressions = buildUnnamed973();
  }
  buildCounterConstraints--;
  return o;
}

checkConstraints(api.Constraints o) {
  buildCounterConstraints++;
  if (buildCounterConstraints < 3) {
    unittest.expect(o.maxDatabaseEntries, unittest.equals(42));
    unittest.expect(o.maxUpdateEntries, unittest.equals(42));
    unittest.expect(o.region, unittest.equals('foo'));
    checkUnnamed973(o.supportedCompressions);
  }
  buildCounterConstraints--;
}

buildUnnamed974() {
  var o = new core.List<api.ListUpdateRequest>();
  o.add(buildListUpdateRequest());
  o.add(buildListUpdateRequest());
  return o;
}

checkUnnamed974(core.List<api.ListUpdateRequest> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkListUpdateRequest(o[0]);
  checkListUpdateRequest(o[1]);
}

core.int buildCounterFetchThreatListUpdatesRequest = 0;
buildFetchThreatListUpdatesRequest() {
  var o = new api.FetchThreatListUpdatesRequest();
  buildCounterFetchThreatListUpdatesRequest++;
  if (buildCounterFetchThreatListUpdatesRequest < 3) {
    o.client = buildClientInfo();
    o.listUpdateRequests = buildUnnamed974();
  }
  buildCounterFetchThreatListUpdatesRequest--;
  return o;
}

checkFetchThreatListUpdatesRequest(api.FetchThreatListUpdatesRequest o) {
  buildCounterFetchThreatListUpdatesRequest++;
  if (buildCounterFetchThreatListUpdatesRequest < 3) {
    checkClientInfo(o.client);
    checkUnnamed974(o.listUpdateRequests);
  }
  buildCounterFetchThreatListUpdatesRequest--;
}

buildUnnamed975() {
  var o = new core.List<api.ListUpdateResponse>();
  o.add(buildListUpdateResponse());
  o.add(buildListUpdateResponse());
  return o;
}

checkUnnamed975(core.List<api.ListUpdateResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkListUpdateResponse(o[0]);
  checkListUpdateResponse(o[1]);
}

core.int buildCounterFetchThreatListUpdatesResponse = 0;
buildFetchThreatListUpdatesResponse() {
  var o = new api.FetchThreatListUpdatesResponse();
  buildCounterFetchThreatListUpdatesResponse++;
  if (buildCounterFetchThreatListUpdatesResponse < 3) {
    o.listUpdateResponses = buildUnnamed975();
    o.minimumWaitDuration = "foo";
  }
  buildCounterFetchThreatListUpdatesResponse--;
  return o;
}

checkFetchThreatListUpdatesResponse(api.FetchThreatListUpdatesResponse o) {
  buildCounterFetchThreatListUpdatesResponse++;
  if (buildCounterFetchThreatListUpdatesResponse < 3) {
    checkUnnamed975(o.listUpdateResponses);
    unittest.expect(o.minimumWaitDuration, unittest.equals('foo'));
  }
  buildCounterFetchThreatListUpdatesResponse--;
}

buildUnnamed976() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed976(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterFindFullHashesRequest = 0;
buildFindFullHashesRequest() {
  var o = new api.FindFullHashesRequest();
  buildCounterFindFullHashesRequest++;
  if (buildCounterFindFullHashesRequest < 3) {
    o.client = buildClientInfo();
    o.clientStates = buildUnnamed976();
    o.threatInfo = buildThreatInfo();
  }
  buildCounterFindFullHashesRequest--;
  return o;
}

checkFindFullHashesRequest(api.FindFullHashesRequest o) {
  buildCounterFindFullHashesRequest++;
  if (buildCounterFindFullHashesRequest < 3) {
    checkClientInfo(o.client);
    checkUnnamed976(o.clientStates);
    checkThreatInfo(o.threatInfo);
  }
  buildCounterFindFullHashesRequest--;
}

buildUnnamed977() {
  var o = new core.List<api.ThreatMatch>();
  o.add(buildThreatMatch());
  o.add(buildThreatMatch());
  return o;
}

checkUnnamed977(core.List<api.ThreatMatch> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkThreatMatch(o[0]);
  checkThreatMatch(o[1]);
}

core.int buildCounterFindFullHashesResponse = 0;
buildFindFullHashesResponse() {
  var o = new api.FindFullHashesResponse();
  buildCounterFindFullHashesResponse++;
  if (buildCounterFindFullHashesResponse < 3) {
    o.matches = buildUnnamed977();
    o.minimumWaitDuration = "foo";
    o.negativeCacheDuration = "foo";
  }
  buildCounterFindFullHashesResponse--;
  return o;
}

checkFindFullHashesResponse(api.FindFullHashesResponse o) {
  buildCounterFindFullHashesResponse++;
  if (buildCounterFindFullHashesResponse < 3) {
    checkUnnamed977(o.matches);
    unittest.expect(o.minimumWaitDuration, unittest.equals('foo'));
    unittest.expect(o.negativeCacheDuration, unittest.equals('foo'));
  }
  buildCounterFindFullHashesResponse--;
}

core.int buildCounterFindThreatMatchesRequest = 0;
buildFindThreatMatchesRequest() {
  var o = new api.FindThreatMatchesRequest();
  buildCounterFindThreatMatchesRequest++;
  if (buildCounterFindThreatMatchesRequest < 3) {
    o.client = buildClientInfo();
    o.threatInfo = buildThreatInfo();
  }
  buildCounterFindThreatMatchesRequest--;
  return o;
}

checkFindThreatMatchesRequest(api.FindThreatMatchesRequest o) {
  buildCounterFindThreatMatchesRequest++;
  if (buildCounterFindThreatMatchesRequest < 3) {
    checkClientInfo(o.client);
    checkThreatInfo(o.threatInfo);
  }
  buildCounterFindThreatMatchesRequest--;
}

buildUnnamed978() {
  var o = new core.List<api.ThreatMatch>();
  o.add(buildThreatMatch());
  o.add(buildThreatMatch());
  return o;
}

checkUnnamed978(core.List<api.ThreatMatch> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkThreatMatch(o[0]);
  checkThreatMatch(o[1]);
}

core.int buildCounterFindThreatMatchesResponse = 0;
buildFindThreatMatchesResponse() {
  var o = new api.FindThreatMatchesResponse();
  buildCounterFindThreatMatchesResponse++;
  if (buildCounterFindThreatMatchesResponse < 3) {
    o.matches = buildUnnamed978();
  }
  buildCounterFindThreatMatchesResponse--;
  return o;
}

checkFindThreatMatchesResponse(api.FindThreatMatchesResponse o) {
  buildCounterFindThreatMatchesResponse++;
  if (buildCounterFindThreatMatchesResponse < 3) {
    checkUnnamed978(o.matches);
  }
  buildCounterFindThreatMatchesResponse--;
}

buildUnnamed979() {
  var o = new core.List<api.ThreatListDescriptor>();
  o.add(buildThreatListDescriptor());
  o.add(buildThreatListDescriptor());
  return o;
}

checkUnnamed979(core.List<api.ThreatListDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkThreatListDescriptor(o[0]);
  checkThreatListDescriptor(o[1]);
}

core.int buildCounterListThreatListsResponse = 0;
buildListThreatListsResponse() {
  var o = new api.ListThreatListsResponse();
  buildCounterListThreatListsResponse++;
  if (buildCounterListThreatListsResponse < 3) {
    o.threatLists = buildUnnamed979();
  }
  buildCounterListThreatListsResponse--;
  return o;
}

checkListThreatListsResponse(api.ListThreatListsResponse o) {
  buildCounterListThreatListsResponse++;
  if (buildCounterListThreatListsResponse < 3) {
    checkUnnamed979(o.threatLists);
  }
  buildCounterListThreatListsResponse--;
}

core.int buildCounterListUpdateRequest = 0;
buildListUpdateRequest() {
  var o = new api.ListUpdateRequest();
  buildCounterListUpdateRequest++;
  if (buildCounterListUpdateRequest < 3) {
    o.constraints = buildConstraints();
    o.platformType = "foo";
    o.state = "foo";
    o.threatEntryType = "foo";
    o.threatType = "foo";
  }
  buildCounterListUpdateRequest--;
  return o;
}

checkListUpdateRequest(api.ListUpdateRequest o) {
  buildCounterListUpdateRequest++;
  if (buildCounterListUpdateRequest < 3) {
    checkConstraints(o.constraints);
    unittest.expect(o.platformType, unittest.equals('foo'));
    unittest.expect(o.state, unittest.equals('foo'));
    unittest.expect(o.threatEntryType, unittest.equals('foo'));
    unittest.expect(o.threatType, unittest.equals('foo'));
  }
  buildCounterListUpdateRequest--;
}

buildUnnamed980() {
  var o = new core.List<api.ThreatEntrySet>();
  o.add(buildThreatEntrySet());
  o.add(buildThreatEntrySet());
  return o;
}

checkUnnamed980(core.List<api.ThreatEntrySet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkThreatEntrySet(o[0]);
  checkThreatEntrySet(o[1]);
}

buildUnnamed981() {
  var o = new core.List<api.ThreatEntrySet>();
  o.add(buildThreatEntrySet());
  o.add(buildThreatEntrySet());
  return o;
}

checkUnnamed981(core.List<api.ThreatEntrySet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkThreatEntrySet(o[0]);
  checkThreatEntrySet(o[1]);
}

core.int buildCounterListUpdateResponse = 0;
buildListUpdateResponse() {
  var o = new api.ListUpdateResponse();
  buildCounterListUpdateResponse++;
  if (buildCounterListUpdateResponse < 3) {
    o.additions = buildUnnamed980();
    o.checksum = buildChecksum();
    o.newClientState = "foo";
    o.platformType = "foo";
    o.removals = buildUnnamed981();
    o.responseType = "foo";
    o.threatEntryType = "foo";
    o.threatType = "foo";
  }
  buildCounterListUpdateResponse--;
  return o;
}

checkListUpdateResponse(api.ListUpdateResponse o) {
  buildCounterListUpdateResponse++;
  if (buildCounterListUpdateResponse < 3) {
    checkUnnamed980(o.additions);
    checkChecksum(o.checksum);
    unittest.expect(o.newClientState, unittest.equals('foo'));
    unittest.expect(o.platformType, unittest.equals('foo'));
    checkUnnamed981(o.removals);
    unittest.expect(o.responseType, unittest.equals('foo'));
    unittest.expect(o.threatEntryType, unittest.equals('foo'));
    unittest.expect(o.threatType, unittest.equals('foo'));
  }
  buildCounterListUpdateResponse--;
}

core.int buildCounterMetadataEntry = 0;
buildMetadataEntry() {
  var o = new api.MetadataEntry();
  buildCounterMetadataEntry++;
  if (buildCounterMetadataEntry < 3) {
    o.key = "foo";
    o.value = "foo";
  }
  buildCounterMetadataEntry--;
  return o;
}

checkMetadataEntry(api.MetadataEntry o) {
  buildCounterMetadataEntry++;
  if (buildCounterMetadataEntry < 3) {
    unittest.expect(o.key, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterMetadataEntry--;
}

core.int buildCounterRawHashes = 0;
buildRawHashes() {
  var o = new api.RawHashes();
  buildCounterRawHashes++;
  if (buildCounterRawHashes < 3) {
    o.prefixSize = 42;
    o.rawHashes = "foo";
  }
  buildCounterRawHashes--;
  return o;
}

checkRawHashes(api.RawHashes o) {
  buildCounterRawHashes++;
  if (buildCounterRawHashes < 3) {
    unittest.expect(o.prefixSize, unittest.equals(42));
    unittest.expect(o.rawHashes, unittest.equals('foo'));
  }
  buildCounterRawHashes--;
}

buildUnnamed982() {
  var o = new core.List<core.int>();
  o.add(42);
  o.add(42);
  return o;
}

checkUnnamed982(core.List<core.int> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42));
  unittest.expect(o[1], unittest.equals(42));
}

core.int buildCounterRawIndices = 0;
buildRawIndices() {
  var o = new api.RawIndices();
  buildCounterRawIndices++;
  if (buildCounterRawIndices < 3) {
    o.indices = buildUnnamed982();
  }
  buildCounterRawIndices--;
  return o;
}

checkRawIndices(api.RawIndices o) {
  buildCounterRawIndices++;
  if (buildCounterRawIndices < 3) {
    checkUnnamed982(o.indices);
  }
  buildCounterRawIndices--;
}

core.int buildCounterRiceDeltaEncoding = 0;
buildRiceDeltaEncoding() {
  var o = new api.RiceDeltaEncoding();
  buildCounterRiceDeltaEncoding++;
  if (buildCounterRiceDeltaEncoding < 3) {
    o.encodedData = "foo";
    o.firstValue = "foo";
    o.numEntries = 42;
    o.riceParameter = 42;
  }
  buildCounterRiceDeltaEncoding--;
  return o;
}

checkRiceDeltaEncoding(api.RiceDeltaEncoding o) {
  buildCounterRiceDeltaEncoding++;
  if (buildCounterRiceDeltaEncoding < 3) {
    unittest.expect(o.encodedData, unittest.equals('foo'));
    unittest.expect(o.firstValue, unittest.equals('foo'));
    unittest.expect(o.numEntries, unittest.equals(42));
    unittest.expect(o.riceParameter, unittest.equals(42));
  }
  buildCounterRiceDeltaEncoding--;
}

core.int buildCounterThreatEntry = 0;
buildThreatEntry() {
  var o = new api.ThreatEntry();
  buildCounterThreatEntry++;
  if (buildCounterThreatEntry < 3) {
    o.digest = "foo";
    o.hash = "foo";
    o.url = "foo";
  }
  buildCounterThreatEntry--;
  return o;
}

checkThreatEntry(api.ThreatEntry o) {
  buildCounterThreatEntry++;
  if (buildCounterThreatEntry < 3) {
    unittest.expect(o.digest, unittest.equals('foo'));
    unittest.expect(o.hash, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterThreatEntry--;
}

buildUnnamed983() {
  var o = new core.List<api.MetadataEntry>();
  o.add(buildMetadataEntry());
  o.add(buildMetadataEntry());
  return o;
}

checkUnnamed983(core.List<api.MetadataEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMetadataEntry(o[0]);
  checkMetadataEntry(o[1]);
}

core.int buildCounterThreatEntryMetadata = 0;
buildThreatEntryMetadata() {
  var o = new api.ThreatEntryMetadata();
  buildCounterThreatEntryMetadata++;
  if (buildCounterThreatEntryMetadata < 3) {
    o.entries = buildUnnamed983();
  }
  buildCounterThreatEntryMetadata--;
  return o;
}

checkThreatEntryMetadata(api.ThreatEntryMetadata o) {
  buildCounterThreatEntryMetadata++;
  if (buildCounterThreatEntryMetadata < 3) {
    checkUnnamed983(o.entries);
  }
  buildCounterThreatEntryMetadata--;
}

core.int buildCounterThreatEntrySet = 0;
buildThreatEntrySet() {
  var o = new api.ThreatEntrySet();
  buildCounterThreatEntrySet++;
  if (buildCounterThreatEntrySet < 3) {
    o.compressionType = "foo";
    o.rawHashes = buildRawHashes();
    o.rawIndices = buildRawIndices();
    o.riceHashes = buildRiceDeltaEncoding();
    o.riceIndices = buildRiceDeltaEncoding();
  }
  buildCounterThreatEntrySet--;
  return o;
}

checkThreatEntrySet(api.ThreatEntrySet o) {
  buildCounterThreatEntrySet++;
  if (buildCounterThreatEntrySet < 3) {
    unittest.expect(o.compressionType, unittest.equals('foo'));
    checkRawHashes(o.rawHashes);
    checkRawIndices(o.rawIndices);
    checkRiceDeltaEncoding(o.riceHashes);
    checkRiceDeltaEncoding(o.riceIndices);
  }
  buildCounterThreatEntrySet--;
}

buildUnnamed984() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed984(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed985() {
  var o = new core.List<api.ThreatEntry>();
  o.add(buildThreatEntry());
  o.add(buildThreatEntry());
  return o;
}

checkUnnamed985(core.List<api.ThreatEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkThreatEntry(o[0]);
  checkThreatEntry(o[1]);
}

buildUnnamed986() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed986(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed987() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed987(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterThreatInfo = 0;
buildThreatInfo() {
  var o = new api.ThreatInfo();
  buildCounterThreatInfo++;
  if (buildCounterThreatInfo < 3) {
    o.platformTypes = buildUnnamed984();
    o.threatEntries = buildUnnamed985();
    o.threatEntryTypes = buildUnnamed986();
    o.threatTypes = buildUnnamed987();
  }
  buildCounterThreatInfo--;
  return o;
}

checkThreatInfo(api.ThreatInfo o) {
  buildCounterThreatInfo++;
  if (buildCounterThreatInfo < 3) {
    checkUnnamed984(o.platformTypes);
    checkUnnamed985(o.threatEntries);
    checkUnnamed986(o.threatEntryTypes);
    checkUnnamed987(o.threatTypes);
  }
  buildCounterThreatInfo--;
}

core.int buildCounterThreatListDescriptor = 0;
buildThreatListDescriptor() {
  var o = new api.ThreatListDescriptor();
  buildCounterThreatListDescriptor++;
  if (buildCounterThreatListDescriptor < 3) {
    o.platformType = "foo";
    o.threatEntryType = "foo";
    o.threatType = "foo";
  }
  buildCounterThreatListDescriptor--;
  return o;
}

checkThreatListDescriptor(api.ThreatListDescriptor o) {
  buildCounterThreatListDescriptor++;
  if (buildCounterThreatListDescriptor < 3) {
    unittest.expect(o.platformType, unittest.equals('foo'));
    unittest.expect(o.threatEntryType, unittest.equals('foo'));
    unittest.expect(o.threatType, unittest.equals('foo'));
  }
  buildCounterThreatListDescriptor--;
}

core.int buildCounterThreatMatch = 0;
buildThreatMatch() {
  var o = new api.ThreatMatch();
  buildCounterThreatMatch++;
  if (buildCounterThreatMatch < 3) {
    o.cacheDuration = "foo";
    o.platformType = "foo";
    o.threat = buildThreatEntry();
    o.threatEntryMetadata = buildThreatEntryMetadata();
    o.threatEntryType = "foo";
    o.threatType = "foo";
  }
  buildCounterThreatMatch--;
  return o;
}

checkThreatMatch(api.ThreatMatch o) {
  buildCounterThreatMatch++;
  if (buildCounterThreatMatch < 3) {
    unittest.expect(o.cacheDuration, unittest.equals('foo'));
    unittest.expect(o.platformType, unittest.equals('foo'));
    checkThreatEntry(o.threat);
    checkThreatEntryMetadata(o.threatEntryMetadata);
    unittest.expect(o.threatEntryType, unittest.equals('foo'));
    unittest.expect(o.threatType, unittest.equals('foo'));
  }
  buildCounterThreatMatch--;
}


main() {
  unittest.group("obj-schema-Checksum", () {
    unittest.test("to-json--from-json", () {
      var o = buildChecksum();
      var od = new api.Checksum.fromJson(o.toJson());
      checkChecksum(od);
    });
  });


  unittest.group("obj-schema-ClientInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildClientInfo();
      var od = new api.ClientInfo.fromJson(o.toJson());
      checkClientInfo(od);
    });
  });


  unittest.group("obj-schema-Constraints", () {
    unittest.test("to-json--from-json", () {
      var o = buildConstraints();
      var od = new api.Constraints.fromJson(o.toJson());
      checkConstraints(od);
    });
  });


  unittest.group("obj-schema-FetchThreatListUpdatesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildFetchThreatListUpdatesRequest();
      var od = new api.FetchThreatListUpdatesRequest.fromJson(o.toJson());
      checkFetchThreatListUpdatesRequest(od);
    });
  });


  unittest.group("obj-schema-FetchThreatListUpdatesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildFetchThreatListUpdatesResponse();
      var od = new api.FetchThreatListUpdatesResponse.fromJson(o.toJson());
      checkFetchThreatListUpdatesResponse(od);
    });
  });


  unittest.group("obj-schema-FindFullHashesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildFindFullHashesRequest();
      var od = new api.FindFullHashesRequest.fromJson(o.toJson());
      checkFindFullHashesRequest(od);
    });
  });


  unittest.group("obj-schema-FindFullHashesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildFindFullHashesResponse();
      var od = new api.FindFullHashesResponse.fromJson(o.toJson());
      checkFindFullHashesResponse(od);
    });
  });


  unittest.group("obj-schema-FindThreatMatchesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildFindThreatMatchesRequest();
      var od = new api.FindThreatMatchesRequest.fromJson(o.toJson());
      checkFindThreatMatchesRequest(od);
    });
  });


  unittest.group("obj-schema-FindThreatMatchesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildFindThreatMatchesResponse();
      var od = new api.FindThreatMatchesResponse.fromJson(o.toJson());
      checkFindThreatMatchesResponse(od);
    });
  });


  unittest.group("obj-schema-ListThreatListsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListThreatListsResponse();
      var od = new api.ListThreatListsResponse.fromJson(o.toJson());
      checkListThreatListsResponse(od);
    });
  });


  unittest.group("obj-schema-ListUpdateRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildListUpdateRequest();
      var od = new api.ListUpdateRequest.fromJson(o.toJson());
      checkListUpdateRequest(od);
    });
  });


  unittest.group("obj-schema-ListUpdateResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListUpdateResponse();
      var od = new api.ListUpdateResponse.fromJson(o.toJson());
      checkListUpdateResponse(od);
    });
  });


  unittest.group("obj-schema-MetadataEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildMetadataEntry();
      var od = new api.MetadataEntry.fromJson(o.toJson());
      checkMetadataEntry(od);
    });
  });


  unittest.group("obj-schema-RawHashes", () {
    unittest.test("to-json--from-json", () {
      var o = buildRawHashes();
      var od = new api.RawHashes.fromJson(o.toJson());
      checkRawHashes(od);
    });
  });


  unittest.group("obj-schema-RawIndices", () {
    unittest.test("to-json--from-json", () {
      var o = buildRawIndices();
      var od = new api.RawIndices.fromJson(o.toJson());
      checkRawIndices(od);
    });
  });


  unittest.group("obj-schema-RiceDeltaEncoding", () {
    unittest.test("to-json--from-json", () {
      var o = buildRiceDeltaEncoding();
      var od = new api.RiceDeltaEncoding.fromJson(o.toJson());
      checkRiceDeltaEncoding(od);
    });
  });


  unittest.group("obj-schema-ThreatEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildThreatEntry();
      var od = new api.ThreatEntry.fromJson(o.toJson());
      checkThreatEntry(od);
    });
  });


  unittest.group("obj-schema-ThreatEntryMetadata", () {
    unittest.test("to-json--from-json", () {
      var o = buildThreatEntryMetadata();
      var od = new api.ThreatEntryMetadata.fromJson(o.toJson());
      checkThreatEntryMetadata(od);
    });
  });


  unittest.group("obj-schema-ThreatEntrySet", () {
    unittest.test("to-json--from-json", () {
      var o = buildThreatEntrySet();
      var od = new api.ThreatEntrySet.fromJson(o.toJson());
      checkThreatEntrySet(od);
    });
  });


  unittest.group("obj-schema-ThreatInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildThreatInfo();
      var od = new api.ThreatInfo.fromJson(o.toJson());
      checkThreatInfo(od);
    });
  });


  unittest.group("obj-schema-ThreatListDescriptor", () {
    unittest.test("to-json--from-json", () {
      var o = buildThreatListDescriptor();
      var od = new api.ThreatListDescriptor.fromJson(o.toJson());
      checkThreatListDescriptor(od);
    });
  });


  unittest.group("obj-schema-ThreatMatch", () {
    unittest.test("to-json--from-json", () {
      var o = buildThreatMatch();
      var od = new api.ThreatMatch.fromJson(o.toJson());
      checkThreatMatch(od);
    });
  });


  unittest.group("resource-FullHashesResourceApi", () {
    unittest.test("method--find", () {

      var mock = new HttpServerMock();
      api.FullHashesResourceApi res = new api.SafebrowsingApi(mock).fullHashes;
      var arg_request = buildFindFullHashesRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.FindFullHashesRequest.fromJson(json);
        checkFindFullHashesRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 18), unittest.equals("v4/fullHashes:find"));
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
        var resp = convert.JSON.encode(buildFindFullHashesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.find(arg_request).then(unittest.expectAsync(((api.FindFullHashesResponse response) {
        checkFindFullHashesResponse(response);
      })));
    });

  });


  unittest.group("resource-ThreatListUpdatesResourceApi", () {
    unittest.test("method--fetch", () {

      var mock = new HttpServerMock();
      api.ThreatListUpdatesResourceApi res = new api.SafebrowsingApi(mock).threatListUpdates;
      var arg_request = buildFetchThreatListUpdatesRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.FetchThreatListUpdatesRequest.fromJson(json);
        checkFetchThreatListUpdatesRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 26), unittest.equals("v4/threatListUpdates:fetch"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildFetchThreatListUpdatesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.fetch(arg_request).then(unittest.expectAsync(((api.FetchThreatListUpdatesResponse response) {
        checkFetchThreatListUpdatesResponse(response);
      })));
    });

  });


  unittest.group("resource-ThreatListsResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.ThreatListsResourceApi res = new api.SafebrowsingApi(mock).threatLists;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("v4/threatLists"));
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
        var resp = convert.JSON.encode(buildListThreatListsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list().then(unittest.expectAsync(((api.ListThreatListsResponse response) {
        checkListThreatListsResponse(response);
      })));
    });

  });


  unittest.group("resource-ThreatMatchesResourceApi", () {
    unittest.test("method--find", () {

      var mock = new HttpServerMock();
      api.ThreatMatchesResourceApi res = new api.SafebrowsingApi(mock).threatMatches;
      var arg_request = buildFindThreatMatchesRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.FindThreatMatchesRequest.fromJson(json);
        checkFindThreatMatchesRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("v4/threatMatches:find"));
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
        var resp = convert.JSON.encode(buildFindThreatMatchesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.find(arg_request).then(unittest.expectAsync(((api.FindThreatMatchesResponse response) {
        checkFindThreatMatchesResponse(response);
      })));
    });

  });


}

