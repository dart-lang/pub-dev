// This is a generated file (see the discoveryapis_generator project).

library googleapis.safebrowsing.v4;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client safebrowsing/v4';

/**
 * Enables client applications to check web resources (most commonly URLs)
 * against Google-generated lists of unsafe web resources.
 */
class SafebrowsingApi {

  final commons.ApiRequester _requester;

  FullHashesResourceApi get fullHashes => new FullHashesResourceApi(_requester);
  ThreatListUpdatesResourceApi get threatListUpdates => new ThreatListUpdatesResourceApi(_requester);
  ThreatListsResourceApi get threatLists => new ThreatListsResourceApi(_requester);
  ThreatMatchesResourceApi get threatMatches => new ThreatMatchesResourceApi(_requester);

  SafebrowsingApi(http.Client client, {core.String rootUrl: "https://safebrowsing.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class FullHashesResourceApi {
  final commons.ApiRequester _requester;

  FullHashesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Finds the full hashes that match the requested hash prefixes.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [FindFullHashesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FindFullHashesResponse> find(FindFullHashesRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v4/fullHashes:find';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FindFullHashesResponse.fromJson(data));
  }

}


class ThreatListUpdatesResourceApi {
  final commons.ApiRequester _requester;

  ThreatListUpdatesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Fetches the most recent threat list updates. A client can request updates
   * for multiple lists at once.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [FetchThreatListUpdatesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FetchThreatListUpdatesResponse> fetch(FetchThreatListUpdatesRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v4/threatListUpdates:fetch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FetchThreatListUpdatesResponse.fromJson(data));
  }

}


class ThreatListsResourceApi {
  final commons.ApiRequester _requester;

  ThreatListsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists the Safe Browsing threat lists available for download.
   *
   * Request parameters:
   *
   * Completes with a [ListThreatListsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListThreatListsResponse> list() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'v4/threatLists';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListThreatListsResponse.fromJson(data));
  }

}


class ThreatMatchesResourceApi {
  final commons.ApiRequester _requester;

  ThreatMatchesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Finds the threat entries that match the Safe Browsing lists.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [FindThreatMatchesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FindThreatMatchesResponse> find(FindThreatMatchesRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v4/threatMatches:find';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FindThreatMatchesResponse.fromJson(data));
  }

}



/** The expected state of a client's local database. */
class Checksum {
  /**
   * The SHA256 hash of the client state; that is, of the sorted list of all
   * hashes present in the database.
   */
  core.String sha256;
  core.List<core.int> get sha256AsBytes {
    return convert.BASE64.decode(sha256);
  }

  void set sha256AsBytes(core.List<core.int> _bytes) {
    sha256 = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  Checksum();

  Checksum.fromJson(core.Map _json) {
    if (_json.containsKey("sha256")) {
      sha256 = _json["sha256"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (sha256 != null) {
      _json["sha256"] = sha256;
    }
    return _json;
  }
}

/** The client metadata associated with Safe Browsing API requests. */
class ClientInfo {
  /**
   * A client ID that (hopefully) uniquely identifies the client implementation
   * of the Safe Browsing API.
   */
  core.String clientId;
  /** The version of the client implementation. */
  core.String clientVersion;

  ClientInfo();

  ClientInfo.fromJson(core.Map _json) {
    if (_json.containsKey("clientId")) {
      clientId = _json["clientId"];
    }
    if (_json.containsKey("clientVersion")) {
      clientVersion = _json["clientVersion"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clientId != null) {
      _json["clientId"] = clientId;
    }
    if (clientVersion != null) {
      _json["clientVersion"] = clientVersion;
    }
    return _json;
  }
}

/** The constraints for this update. */
class Constraints {
  /**
   * Sets the maximum number of entries that the client is willing to have in
   * the local database. This should be a power of 2 between 2**10 and 2**20. If
   * zero, no database size limit is set.
   */
  core.int maxDatabaseEntries;
  /**
   * The maximum size in number of entries. The update will not contain more
   * entries than this value. This should be a power of 2 between 2**10 and
   * 2**20. If zero, no update size limit is set.
   */
  core.int maxUpdateEntries;
  /**
   * Requests the list for a specific geographic location. If not set the server
   * may pick that value based on the user's IP address. Expects ISO 3166-1
   * alpha-2 format.
   */
  core.String region;
  /** The compression types supported by the client. */
  core.List<core.String> supportedCompressions;

  Constraints();

  Constraints.fromJson(core.Map _json) {
    if (_json.containsKey("maxDatabaseEntries")) {
      maxDatabaseEntries = _json["maxDatabaseEntries"];
    }
    if (_json.containsKey("maxUpdateEntries")) {
      maxUpdateEntries = _json["maxUpdateEntries"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("supportedCompressions")) {
      supportedCompressions = _json["supportedCompressions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (maxDatabaseEntries != null) {
      _json["maxDatabaseEntries"] = maxDatabaseEntries;
    }
    if (maxUpdateEntries != null) {
      _json["maxUpdateEntries"] = maxUpdateEntries;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (supportedCompressions != null) {
      _json["supportedCompressions"] = supportedCompressions;
    }
    return _json;
  }
}

/**
 * Describes a Safe Browsing API update request. Clients can request updates for
 * multiple lists in a single request. NOTE: Field index 2 is unused. NEXT: 4
 */
class FetchThreatListUpdatesRequest {
  /** The client metadata. */
  ClientInfo client;
  /** The requested threat list updates. */
  core.List<ListUpdateRequest> listUpdateRequests;

  FetchThreatListUpdatesRequest();

  FetchThreatListUpdatesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("client")) {
      client = new ClientInfo.fromJson(_json["client"]);
    }
    if (_json.containsKey("listUpdateRequests")) {
      listUpdateRequests = _json["listUpdateRequests"].map((value) => new ListUpdateRequest.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (client != null) {
      _json["client"] = (client).toJson();
    }
    if (listUpdateRequests != null) {
      _json["listUpdateRequests"] = listUpdateRequests.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class FetchThreatListUpdatesResponse {
  /** The list updates requested by the clients. */
  core.List<ListUpdateResponse> listUpdateResponses;
  /**
   * The minimum duration the client must wait before issuing any update
   * request. If this field is not set clients may update as soon as they want.
   */
  core.String minimumWaitDuration;

  FetchThreatListUpdatesResponse();

  FetchThreatListUpdatesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("listUpdateResponses")) {
      listUpdateResponses = _json["listUpdateResponses"].map((value) => new ListUpdateResponse.fromJson(value)).toList();
    }
    if (_json.containsKey("minimumWaitDuration")) {
      minimumWaitDuration = _json["minimumWaitDuration"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (listUpdateResponses != null) {
      _json["listUpdateResponses"] = listUpdateResponses.map((value) => (value).toJson()).toList();
    }
    if (minimumWaitDuration != null) {
      _json["minimumWaitDuration"] = minimumWaitDuration;
    }
    return _json;
  }
}

/** Request to return full hashes matched by the provided hash prefixes. */
class FindFullHashesRequest {
  /** The client metadata. */
  ClientInfo client;
  /** The current client states for each of the client's local threat lists. */
  core.List<core.String> clientStates;
  /** The lists and hashes to be checked. */
  ThreatInfo threatInfo;

  FindFullHashesRequest();

  FindFullHashesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("client")) {
      client = new ClientInfo.fromJson(_json["client"]);
    }
    if (_json.containsKey("clientStates")) {
      clientStates = _json["clientStates"];
    }
    if (_json.containsKey("threatInfo")) {
      threatInfo = new ThreatInfo.fromJson(_json["threatInfo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (client != null) {
      _json["client"] = (client).toJson();
    }
    if (clientStates != null) {
      _json["clientStates"] = clientStates;
    }
    if (threatInfo != null) {
      _json["threatInfo"] = (threatInfo).toJson();
    }
    return _json;
  }
}

class FindFullHashesResponse {
  /** The full hashes that matched the requested prefixes. */
  core.List<ThreatMatch> matches;
  /**
   * The minimum duration the client must wait before issuing any find hashes
   * request. If this field is not set, clients can issue a request as soon as
   * they want.
   */
  core.String minimumWaitDuration;
  /**
   * For requested entities that did not match the threat list, how long to
   * cache the response.
   */
  core.String negativeCacheDuration;

  FindFullHashesResponse();

  FindFullHashesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("matches")) {
      matches = _json["matches"].map((value) => new ThreatMatch.fromJson(value)).toList();
    }
    if (_json.containsKey("minimumWaitDuration")) {
      minimumWaitDuration = _json["minimumWaitDuration"];
    }
    if (_json.containsKey("negativeCacheDuration")) {
      negativeCacheDuration = _json["negativeCacheDuration"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (matches != null) {
      _json["matches"] = matches.map((value) => (value).toJson()).toList();
    }
    if (minimumWaitDuration != null) {
      _json["minimumWaitDuration"] = minimumWaitDuration;
    }
    if (negativeCacheDuration != null) {
      _json["negativeCacheDuration"] = negativeCacheDuration;
    }
    return _json;
  }
}

/** Request to check entries against lists. */
class FindThreatMatchesRequest {
  /** The client metadata. */
  ClientInfo client;
  /** The lists and entries to be checked for matches. */
  ThreatInfo threatInfo;

  FindThreatMatchesRequest();

  FindThreatMatchesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("client")) {
      client = new ClientInfo.fromJson(_json["client"]);
    }
    if (_json.containsKey("threatInfo")) {
      threatInfo = new ThreatInfo.fromJson(_json["threatInfo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (client != null) {
      _json["client"] = (client).toJson();
    }
    if (threatInfo != null) {
      _json["threatInfo"] = (threatInfo).toJson();
    }
    return _json;
  }
}

class FindThreatMatchesResponse {
  /** The threat list matches. */
  core.List<ThreatMatch> matches;

  FindThreatMatchesResponse();

  FindThreatMatchesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("matches")) {
      matches = _json["matches"].map((value) => new ThreatMatch.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (matches != null) {
      _json["matches"] = matches.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ListThreatListsResponse {
  /** The lists available for download by the client. */
  core.List<ThreatListDescriptor> threatLists;

  ListThreatListsResponse();

  ListThreatListsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("threatLists")) {
      threatLists = _json["threatLists"].map((value) => new ThreatListDescriptor.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (threatLists != null) {
      _json["threatLists"] = threatLists.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A single list update request. */
class ListUpdateRequest {
  /** The constraints associated with this request. */
  Constraints constraints;
  /**
   * The type of platform at risk by entries present in the list.
   * Possible string values are:
   * - "PLATFORM_TYPE_UNSPECIFIED" : A PLATFORM_TYPE_UNSPECIFIED.
   * - "WINDOWS" : A WINDOWS.
   * - "LINUX" : A LINUX.
   * - "ANDROID" : A ANDROID.
   * - "OSX" : A OSX.
   * - "IOS" : A IOS.
   * - "ANY_PLATFORM" : A ANY_PLATFORM.
   * - "ALL_PLATFORMS" : A ALL_PLATFORMS.
   * - "CHROME" : A CHROME.
   */
  core.String platformType;
  /**
   * The current state of the client for the requested list (the encrypted
   * client state that was received from the last successful list update).
   */
  core.String state;
  core.List<core.int> get stateAsBytes {
    return convert.BASE64.decode(state);
  }

  void set stateAsBytes(core.List<core.int> _bytes) {
    state = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * The types of entries present in the list.
   * Possible string values are:
   * - "THREAT_ENTRY_TYPE_UNSPECIFIED" : A THREAT_ENTRY_TYPE_UNSPECIFIED.
   * - "URL" : A URL.
   * - "EXECUTABLE" : A EXECUTABLE.
   * - "IP_RANGE" : A IP_RANGE.
   */
  core.String threatEntryType;
  /**
   * The type of threat posed by entries present in the list.
   * Possible string values are:
   * - "THREAT_TYPE_UNSPECIFIED" : A THREAT_TYPE_UNSPECIFIED.
   * - "MALWARE" : A MALWARE.
   * - "SOCIAL_ENGINEERING" : A SOCIAL_ENGINEERING.
   * - "UNWANTED_SOFTWARE" : A UNWANTED_SOFTWARE.
   * - "POTENTIALLY_HARMFUL_APPLICATION" : A POTENTIALLY_HARMFUL_APPLICATION.
   */
  core.String threatType;

  ListUpdateRequest();

  ListUpdateRequest.fromJson(core.Map _json) {
    if (_json.containsKey("constraints")) {
      constraints = new Constraints.fromJson(_json["constraints"]);
    }
    if (_json.containsKey("platformType")) {
      platformType = _json["platformType"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("threatEntryType")) {
      threatEntryType = _json["threatEntryType"];
    }
    if (_json.containsKey("threatType")) {
      threatType = _json["threatType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (constraints != null) {
      _json["constraints"] = (constraints).toJson();
    }
    if (platformType != null) {
      _json["platformType"] = platformType;
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (threatEntryType != null) {
      _json["threatEntryType"] = threatEntryType;
    }
    if (threatType != null) {
      _json["threatType"] = threatType;
    }
    return _json;
  }
}

/** An update to an individual list. */
class ListUpdateResponse {
  /**
   * A set of entries to add to a local threat type's list. Repeated to allow
   * for a combination of compressed and raw data to be sent in a single
   * response.
   */
  core.List<ThreatEntrySet> additions;
  /**
   * The expected SHA256 hash of the client state; that is, of the sorted list
   * of all hashes present in the database after applying the provided update.
   * If the client state doesn't match the expected state, the client must
   * disregard this update and retry later.
   */
  Checksum checksum;
  /** The new client state, in encrypted format. Opaque to clients. */
  core.String newClientState;
  core.List<core.int> get newClientStateAsBytes {
    return convert.BASE64.decode(newClientState);
  }

  void set newClientStateAsBytes(core.List<core.int> _bytes) {
    newClientState = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * The platform type for which data is returned.
   * Possible string values are:
   * - "PLATFORM_TYPE_UNSPECIFIED" : A PLATFORM_TYPE_UNSPECIFIED.
   * - "WINDOWS" : A WINDOWS.
   * - "LINUX" : A LINUX.
   * - "ANDROID" : A ANDROID.
   * - "OSX" : A OSX.
   * - "IOS" : A IOS.
   * - "ANY_PLATFORM" : A ANY_PLATFORM.
   * - "ALL_PLATFORMS" : A ALL_PLATFORMS.
   * - "CHROME" : A CHROME.
   */
  core.String platformType;
  /**
   * A set of entries to remove from a local threat type's list. Repeated for
   * the same reason as above.
   */
  core.List<ThreatEntrySet> removals;
  /**
   * The type of response. This may indicate that an action is required by the
   * client when the response is received.
   * Possible string values are:
   * - "RESPONSE_TYPE_UNSPECIFIED" : A RESPONSE_TYPE_UNSPECIFIED.
   * - "PARTIAL_UPDATE" : A PARTIAL_UPDATE.
   * - "FULL_UPDATE" : A FULL_UPDATE.
   */
  core.String responseType;
  /**
   * The format of the threats.
   * Possible string values are:
   * - "THREAT_ENTRY_TYPE_UNSPECIFIED" : A THREAT_ENTRY_TYPE_UNSPECIFIED.
   * - "URL" : A URL.
   * - "EXECUTABLE" : A EXECUTABLE.
   * - "IP_RANGE" : A IP_RANGE.
   */
  core.String threatEntryType;
  /**
   * The threat type for which data is returned.
   * Possible string values are:
   * - "THREAT_TYPE_UNSPECIFIED" : A THREAT_TYPE_UNSPECIFIED.
   * - "MALWARE" : A MALWARE.
   * - "SOCIAL_ENGINEERING" : A SOCIAL_ENGINEERING.
   * - "UNWANTED_SOFTWARE" : A UNWANTED_SOFTWARE.
   * - "POTENTIALLY_HARMFUL_APPLICATION" : A POTENTIALLY_HARMFUL_APPLICATION.
   */
  core.String threatType;

  ListUpdateResponse();

  ListUpdateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("additions")) {
      additions = _json["additions"].map((value) => new ThreatEntrySet.fromJson(value)).toList();
    }
    if (_json.containsKey("checksum")) {
      checksum = new Checksum.fromJson(_json["checksum"]);
    }
    if (_json.containsKey("newClientState")) {
      newClientState = _json["newClientState"];
    }
    if (_json.containsKey("platformType")) {
      platformType = _json["platformType"];
    }
    if (_json.containsKey("removals")) {
      removals = _json["removals"].map((value) => new ThreatEntrySet.fromJson(value)).toList();
    }
    if (_json.containsKey("responseType")) {
      responseType = _json["responseType"];
    }
    if (_json.containsKey("threatEntryType")) {
      threatEntryType = _json["threatEntryType"];
    }
    if (_json.containsKey("threatType")) {
      threatType = _json["threatType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (additions != null) {
      _json["additions"] = additions.map((value) => (value).toJson()).toList();
    }
    if (checksum != null) {
      _json["checksum"] = (checksum).toJson();
    }
    if (newClientState != null) {
      _json["newClientState"] = newClientState;
    }
    if (platformType != null) {
      _json["platformType"] = platformType;
    }
    if (removals != null) {
      _json["removals"] = removals.map((value) => (value).toJson()).toList();
    }
    if (responseType != null) {
      _json["responseType"] = responseType;
    }
    if (threatEntryType != null) {
      _json["threatEntryType"] = threatEntryType;
    }
    if (threatType != null) {
      _json["threatType"] = threatType;
    }
    return _json;
  }
}

/** A single metadata entry. */
class MetadataEntry {
  /** The metadata entry key. */
  core.String key;
  core.List<core.int> get keyAsBytes {
    return convert.BASE64.decode(key);
  }

  void set keyAsBytes(core.List<core.int> _bytes) {
    key = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** The metadata entry value. */
  core.String value;
  core.List<core.int> get valueAsBytes {
    return convert.BASE64.decode(value);
  }

  void set valueAsBytes(core.List<core.int> _bytes) {
    value = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  MetadataEntry();

  MetadataEntry.fromJson(core.Map _json) {
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (key != null) {
      _json["key"] = key;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/**
 * The uncompressed threat entries in hash format of a particular prefix length.
 * Hashes can be anywhere from 4 to 32 bytes in size. A large majority are 4
 * bytes, but some hashes are lengthened if they collide with the hash of a
 * popular URL. Used for sending ThreatEntrySet to clients that do not support
 * compression, or when sending non-4-byte hashes to clients that do support
 * compression.
 */
class RawHashes {
  /**
   * The number of bytes for each prefix encoded below. This field can be
   * anywhere from 4 (shortest prefix) to 32 (full SHA256 hash).
   */
  core.int prefixSize;
  /**
   * The hashes, all concatenated into one long string. Each hash has a prefix
   * size of |prefix_size| above. Hashes are sorted in lexicographic order.
   */
  core.String rawHashes;
  core.List<core.int> get rawHashesAsBytes {
    return convert.BASE64.decode(rawHashes);
  }

  void set rawHashesAsBytes(core.List<core.int> _bytes) {
    rawHashes = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  RawHashes();

  RawHashes.fromJson(core.Map _json) {
    if (_json.containsKey("prefixSize")) {
      prefixSize = _json["prefixSize"];
    }
    if (_json.containsKey("rawHashes")) {
      rawHashes = _json["rawHashes"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (prefixSize != null) {
      _json["prefixSize"] = prefixSize;
    }
    if (rawHashes != null) {
      _json["rawHashes"] = rawHashes;
    }
    return _json;
  }
}

/** A set of raw indices to remove from a local list. */
class RawIndices {
  /** The indices to remove from a lexicographically-sorted local list. */
  core.List<core.int> indices;

  RawIndices();

  RawIndices.fromJson(core.Map _json) {
    if (_json.containsKey("indices")) {
      indices = _json["indices"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (indices != null) {
      _json["indices"] = indices;
    }
    return _json;
  }
}

/**
 * The Rice-Golomb encoded data. Used for sending compressed 4-byte hashes or
 * compressed removal indices.
 */
class RiceDeltaEncoding {
  /** The encoded deltas that are encoded using the Golomb-Rice coder. */
  core.String encodedData;
  core.List<core.int> get encodedDataAsBytes {
    return convert.BASE64.decode(encodedData);
  }

  void set encodedDataAsBytes(core.List<core.int> _bytes) {
    encodedData = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * The offset of the first entry in the encoded data, or, if only a single
   * integer was encoded, that single integer's value.
   */
  core.String firstValue;
  /**
   * The number of entries that are delta encoded in the encoded data. If only a
   * single integer was encoded, this will be zero and the single value will be
   * stored in `first_value`.
   */
  core.int numEntries;
  /**
   * The Golomb-Rice parameter, which is a number between 2 and 28. This field
   * is missing (that is, zero) if `num_entries` is zero.
   */
  core.int riceParameter;

  RiceDeltaEncoding();

  RiceDeltaEncoding.fromJson(core.Map _json) {
    if (_json.containsKey("encodedData")) {
      encodedData = _json["encodedData"];
    }
    if (_json.containsKey("firstValue")) {
      firstValue = _json["firstValue"];
    }
    if (_json.containsKey("numEntries")) {
      numEntries = _json["numEntries"];
    }
    if (_json.containsKey("riceParameter")) {
      riceParameter = _json["riceParameter"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (encodedData != null) {
      _json["encodedData"] = encodedData;
    }
    if (firstValue != null) {
      _json["firstValue"] = firstValue;
    }
    if (numEntries != null) {
      _json["numEntries"] = numEntries;
    }
    if (riceParameter != null) {
      _json["riceParameter"] = riceParameter;
    }
    return _json;
  }
}

/**
 * An individual threat; for example, a malicious URL or its hash
 * representation. Only one of these fields should be set.
 */
class ThreatEntry {
  /**
   * The digest of an executable in SHA256 format. The API supports both binary
   * and hex digests.
   */
  core.String digest;
  core.List<core.int> get digestAsBytes {
    return convert.BASE64.decode(digest);
  }

  void set digestAsBytes(core.List<core.int> _bytes) {
    digest = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * A hash prefix, consisting of the most significant 4-32 bytes of a SHA256
   * hash. This field is in binary format.
   */
  core.String hash;
  core.List<core.int> get hashAsBytes {
    return convert.BASE64.decode(hash);
  }

  void set hashAsBytes(core.List<core.int> _bytes) {
    hash = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** A URL. */
  core.String url;

  ThreatEntry();

  ThreatEntry.fromJson(core.Map _json) {
    if (_json.containsKey("digest")) {
      digest = _json["digest"];
    }
    if (_json.containsKey("hash")) {
      hash = _json["hash"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (digest != null) {
      _json["digest"] = digest;
    }
    if (hash != null) {
      _json["hash"] = hash;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/**
 * The metadata associated with a specific threat entry. The client is expected
 * to know the metadata key/value pairs associated with each threat type.
 */
class ThreatEntryMetadata {
  /** The metadata entries. */
  core.List<MetadataEntry> entries;

  ThreatEntryMetadata();

  ThreatEntryMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new MetadataEntry.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * A set of threats that should be added or removed from a client's local
 * database.
 */
class ThreatEntrySet {
  /**
   * The compression type for the entries in this set.
   * Possible string values are:
   * - "COMPRESSION_TYPE_UNSPECIFIED" : A COMPRESSION_TYPE_UNSPECIFIED.
   * - "RAW" : A RAW.
   * - "RICE" : A RICE.
   */
  core.String compressionType;
  /** The raw SHA256-formatted entries. */
  RawHashes rawHashes;
  /** The raw removal indices for a local list. */
  RawIndices rawIndices;
  /**
   * The encoded 4-byte prefixes of SHA256-formatted entries, using a
   * Golomb-Rice encoding.
   */
  RiceDeltaEncoding riceHashes;
  /**
   * The encoded local, lexicographically-sorted list indices, using a
   * Golomb-Rice encoding. Used for sending compressed removal indices.
   */
  RiceDeltaEncoding riceIndices;

  ThreatEntrySet();

  ThreatEntrySet.fromJson(core.Map _json) {
    if (_json.containsKey("compressionType")) {
      compressionType = _json["compressionType"];
    }
    if (_json.containsKey("rawHashes")) {
      rawHashes = new RawHashes.fromJson(_json["rawHashes"]);
    }
    if (_json.containsKey("rawIndices")) {
      rawIndices = new RawIndices.fromJson(_json["rawIndices"]);
    }
    if (_json.containsKey("riceHashes")) {
      riceHashes = new RiceDeltaEncoding.fromJson(_json["riceHashes"]);
    }
    if (_json.containsKey("riceIndices")) {
      riceIndices = new RiceDeltaEncoding.fromJson(_json["riceIndices"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (compressionType != null) {
      _json["compressionType"] = compressionType;
    }
    if (rawHashes != null) {
      _json["rawHashes"] = (rawHashes).toJson();
    }
    if (rawIndices != null) {
      _json["rawIndices"] = (rawIndices).toJson();
    }
    if (riceHashes != null) {
      _json["riceHashes"] = (riceHashes).toJson();
    }
    if (riceIndices != null) {
      _json["riceIndices"] = (riceIndices).toJson();
    }
    return _json;
  }
}

/**
 * The information regarding one or more threats that a client submits when
 * checking for matches in threat lists.
 */
class ThreatInfo {
  /** The platform types to be checked. */
  core.List<core.String> platformTypes;
  /** The threat entries to be checked. */
  core.List<ThreatEntry> threatEntries;
  /** The entry types to be checked. */
  core.List<core.String> threatEntryTypes;
  /** The threat types to be checked. */
  core.List<core.String> threatTypes;

  ThreatInfo();

  ThreatInfo.fromJson(core.Map _json) {
    if (_json.containsKey("platformTypes")) {
      platformTypes = _json["platformTypes"];
    }
    if (_json.containsKey("threatEntries")) {
      threatEntries = _json["threatEntries"].map((value) => new ThreatEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("threatEntryTypes")) {
      threatEntryTypes = _json["threatEntryTypes"];
    }
    if (_json.containsKey("threatTypes")) {
      threatTypes = _json["threatTypes"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (platformTypes != null) {
      _json["platformTypes"] = platformTypes;
    }
    if (threatEntries != null) {
      _json["threatEntries"] = threatEntries.map((value) => (value).toJson()).toList();
    }
    if (threatEntryTypes != null) {
      _json["threatEntryTypes"] = threatEntryTypes;
    }
    if (threatTypes != null) {
      _json["threatTypes"] = threatTypes;
    }
    return _json;
  }
}

/**
 * Describes an individual threat list. A list is defined by three parameters:
 * the type of threat posed, the type of platform targeted by the threat, and
 * the type of entries in the list.
 */
class ThreatListDescriptor {
  /**
   * The platform type targeted by the list's entries.
   * Possible string values are:
   * - "PLATFORM_TYPE_UNSPECIFIED" : A PLATFORM_TYPE_UNSPECIFIED.
   * - "WINDOWS" : A WINDOWS.
   * - "LINUX" : A LINUX.
   * - "ANDROID" : A ANDROID.
   * - "OSX" : A OSX.
   * - "IOS" : A IOS.
   * - "ANY_PLATFORM" : A ANY_PLATFORM.
   * - "ALL_PLATFORMS" : A ALL_PLATFORMS.
   * - "CHROME" : A CHROME.
   */
  core.String platformType;
  /**
   * The entry types contained in the list.
   * Possible string values are:
   * - "THREAT_ENTRY_TYPE_UNSPECIFIED" : A THREAT_ENTRY_TYPE_UNSPECIFIED.
   * - "URL" : A URL.
   * - "EXECUTABLE" : A EXECUTABLE.
   * - "IP_RANGE" : A IP_RANGE.
   */
  core.String threatEntryType;
  /**
   * The threat type posed by the list's entries.
   * Possible string values are:
   * - "THREAT_TYPE_UNSPECIFIED" : A THREAT_TYPE_UNSPECIFIED.
   * - "MALWARE" : A MALWARE.
   * - "SOCIAL_ENGINEERING" : A SOCIAL_ENGINEERING.
   * - "UNWANTED_SOFTWARE" : A UNWANTED_SOFTWARE.
   * - "POTENTIALLY_HARMFUL_APPLICATION" : A POTENTIALLY_HARMFUL_APPLICATION.
   */
  core.String threatType;

  ThreatListDescriptor();

  ThreatListDescriptor.fromJson(core.Map _json) {
    if (_json.containsKey("platformType")) {
      platformType = _json["platformType"];
    }
    if (_json.containsKey("threatEntryType")) {
      threatEntryType = _json["threatEntryType"];
    }
    if (_json.containsKey("threatType")) {
      threatType = _json["threatType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (platformType != null) {
      _json["platformType"] = platformType;
    }
    if (threatEntryType != null) {
      _json["threatEntryType"] = threatEntryType;
    }
    if (threatType != null) {
      _json["threatType"] = threatType;
    }
    return _json;
  }
}

/** A match when checking a threat entry in the Safe Browsing threat lists. */
class ThreatMatch {
  /**
   * The cache lifetime for the returned match. Clients must not cache this
   * response for more than this duration to avoid false positives.
   */
  core.String cacheDuration;
  /**
   * The platform type matching this threat.
   * Possible string values are:
   * - "PLATFORM_TYPE_UNSPECIFIED" : A PLATFORM_TYPE_UNSPECIFIED.
   * - "WINDOWS" : A WINDOWS.
   * - "LINUX" : A LINUX.
   * - "ANDROID" : A ANDROID.
   * - "OSX" : A OSX.
   * - "IOS" : A IOS.
   * - "ANY_PLATFORM" : A ANY_PLATFORM.
   * - "ALL_PLATFORMS" : A ALL_PLATFORMS.
   * - "CHROME" : A CHROME.
   */
  core.String platformType;
  /** The threat matching this threat. */
  ThreatEntry threat;
  /** Optional metadata associated with this threat. */
  ThreatEntryMetadata threatEntryMetadata;
  /**
   * The threat entry type matching this threat.
   * Possible string values are:
   * - "THREAT_ENTRY_TYPE_UNSPECIFIED" : A THREAT_ENTRY_TYPE_UNSPECIFIED.
   * - "URL" : A URL.
   * - "EXECUTABLE" : A EXECUTABLE.
   * - "IP_RANGE" : A IP_RANGE.
   */
  core.String threatEntryType;
  /**
   * The threat type matching this threat.
   * Possible string values are:
   * - "THREAT_TYPE_UNSPECIFIED" : A THREAT_TYPE_UNSPECIFIED.
   * - "MALWARE" : A MALWARE.
   * - "SOCIAL_ENGINEERING" : A SOCIAL_ENGINEERING.
   * - "UNWANTED_SOFTWARE" : A UNWANTED_SOFTWARE.
   * - "POTENTIALLY_HARMFUL_APPLICATION" : A POTENTIALLY_HARMFUL_APPLICATION.
   */
  core.String threatType;

  ThreatMatch();

  ThreatMatch.fromJson(core.Map _json) {
    if (_json.containsKey("cacheDuration")) {
      cacheDuration = _json["cacheDuration"];
    }
    if (_json.containsKey("platformType")) {
      platformType = _json["platformType"];
    }
    if (_json.containsKey("threat")) {
      threat = new ThreatEntry.fromJson(_json["threat"]);
    }
    if (_json.containsKey("threatEntryMetadata")) {
      threatEntryMetadata = new ThreatEntryMetadata.fromJson(_json["threatEntryMetadata"]);
    }
    if (_json.containsKey("threatEntryType")) {
      threatEntryType = _json["threatEntryType"];
    }
    if (_json.containsKey("threatType")) {
      threatType = _json["threatType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cacheDuration != null) {
      _json["cacheDuration"] = cacheDuration;
    }
    if (platformType != null) {
      _json["platformType"] = platformType;
    }
    if (threat != null) {
      _json["threat"] = (threat).toJson();
    }
    if (threatEntryMetadata != null) {
      _json["threatEntryMetadata"] = (threatEntryMetadata).toJson();
    }
    if (threatEntryType != null) {
      _json["threatEntryType"] = threatEntryType;
    }
    if (threatType != null) {
      _json["threatType"] = threatType;
    }
    return _json;
  }
}
