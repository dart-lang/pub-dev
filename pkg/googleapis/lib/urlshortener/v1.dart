// This is a generated file (see the discoveryapis_generator project).

library googleapis.urlshortener.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client urlshortener/v1';

/** Lets you create, inspect, and manage goo.gl short URLs */
class UrlshortenerApi {
  /** Manage your goo.gl short URLs */
  static const UrlshortenerScope = "https://www.googleapis.com/auth/urlshortener";


  final commons.ApiRequester _requester;

  UrlResourceApi get url => new UrlResourceApi(_requester);

  UrlshortenerApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "urlshortener/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class UrlResourceApi {
  final commons.ApiRequester _requester;

  UrlResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Expands a short URL or gets creation time and analytics.
   *
   * Request parameters:
   *
   * [shortUrl] - The short URL, including the protocol.
   *
   * [projection] - Additional information to return.
   * Possible string values are:
   * - "ANALYTICS_CLICKS" : Returns only click counts.
   * - "ANALYTICS_TOP_STRINGS" : Returns only top string counts.
   * - "FULL" : Returns the creation timestamp and all available analytics.
   *
   * Completes with a [Url].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Url> get(core.String shortUrl, {core.String projection}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (shortUrl == null) {
      throw new core.ArgumentError("Parameter shortUrl is required.");
    }
    _queryParams["shortUrl"] = [shortUrl];
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }

    _url = 'url';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Url.fromJson(data));
  }

  /**
   * Creates a new short URL.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Url].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Url> insert(Url request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'url';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Url.fromJson(data));
  }

  /**
   * Retrieves a list of URLs shortened by a user.
   *
   * Request parameters:
   *
   * [projection] - Additional information to return.
   * Possible string values are:
   * - "ANALYTICS_CLICKS" : Returns short URL click counts.
   * - "FULL" : Returns short URL click counts.
   *
   * [start_token] - Token for requesting successive pages of results.
   *
   * Completes with a [UrlHistory].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UrlHistory> list({core.String projection, core.String start_token}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projection != null) {
      _queryParams["projection"] = [projection];
    }
    if (start_token != null) {
      _queryParams["start-token"] = [start_token];
    }

    _url = 'url/history';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UrlHistory.fromJson(data));
  }

}



class AnalyticsSnapshot {
  /**
   * Top browsers, e.g. "Chrome"; sorted by (descending) click counts. Only
   * present if this data is available.
   */
  core.List<StringCount> browsers;
  /**
   * Top countries (expressed as country codes), e.g. "US" or "DE"; sorted by
   * (descending) click counts. Only present if this data is available.
   */
  core.List<StringCount> countries;
  /** Number of clicks on all goo.gl short URLs pointing to this long URL. */
  core.String longUrlClicks;
  /**
   * Top platforms or OSes, e.g. "Windows"; sorted by (descending) click counts.
   * Only present if this data is available.
   */
  core.List<StringCount> platforms;
  /**
   * Top referring hosts, e.g. "www.google.com"; sorted by (descending) click
   * counts. Only present if this data is available.
   */
  core.List<StringCount> referrers;
  /** Number of clicks on this short URL. */
  core.String shortUrlClicks;

  AnalyticsSnapshot();

  AnalyticsSnapshot.fromJson(core.Map _json) {
    if (_json.containsKey("browsers")) {
      browsers = _json["browsers"].map((value) => new StringCount.fromJson(value)).toList();
    }
    if (_json.containsKey("countries")) {
      countries = _json["countries"].map((value) => new StringCount.fromJson(value)).toList();
    }
    if (_json.containsKey("longUrlClicks")) {
      longUrlClicks = _json["longUrlClicks"];
    }
    if (_json.containsKey("platforms")) {
      platforms = _json["platforms"].map((value) => new StringCount.fromJson(value)).toList();
    }
    if (_json.containsKey("referrers")) {
      referrers = _json["referrers"].map((value) => new StringCount.fromJson(value)).toList();
    }
    if (_json.containsKey("shortUrlClicks")) {
      shortUrlClicks = _json["shortUrlClicks"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (browsers != null) {
      _json["browsers"] = browsers.map((value) => (value).toJson()).toList();
    }
    if (countries != null) {
      _json["countries"] = countries.map((value) => (value).toJson()).toList();
    }
    if (longUrlClicks != null) {
      _json["longUrlClicks"] = longUrlClicks;
    }
    if (platforms != null) {
      _json["platforms"] = platforms.map((value) => (value).toJson()).toList();
    }
    if (referrers != null) {
      _json["referrers"] = referrers.map((value) => (value).toJson()).toList();
    }
    if (shortUrlClicks != null) {
      _json["shortUrlClicks"] = shortUrlClicks;
    }
    return _json;
  }
}

class AnalyticsSummary {
  /** Click analytics over all time. */
  AnalyticsSnapshot allTime;
  /** Click analytics over the last day. */
  AnalyticsSnapshot day;
  /** Click analytics over the last month. */
  AnalyticsSnapshot month;
  /** Click analytics over the last two hours. */
  AnalyticsSnapshot twoHours;
  /** Click analytics over the last week. */
  AnalyticsSnapshot week;

  AnalyticsSummary();

  AnalyticsSummary.fromJson(core.Map _json) {
    if (_json.containsKey("allTime")) {
      allTime = new AnalyticsSnapshot.fromJson(_json["allTime"]);
    }
    if (_json.containsKey("day")) {
      day = new AnalyticsSnapshot.fromJson(_json["day"]);
    }
    if (_json.containsKey("month")) {
      month = new AnalyticsSnapshot.fromJson(_json["month"]);
    }
    if (_json.containsKey("twoHours")) {
      twoHours = new AnalyticsSnapshot.fromJson(_json["twoHours"]);
    }
    if (_json.containsKey("week")) {
      week = new AnalyticsSnapshot.fromJson(_json["week"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allTime != null) {
      _json["allTime"] = (allTime).toJson();
    }
    if (day != null) {
      _json["day"] = (day).toJson();
    }
    if (month != null) {
      _json["month"] = (month).toJson();
    }
    if (twoHours != null) {
      _json["twoHours"] = (twoHours).toJson();
    }
    if (week != null) {
      _json["week"] = (week).toJson();
    }
    return _json;
  }
}

class StringCount {
  /**
   * Number of clicks for this top entry, e.g. for this particular country or
   * browser.
   */
  core.String count;
  /** Label assigned to this top entry, e.g. "US" or "Chrome". */
  core.String id;

  StringCount();

  StringCount.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (count != null) {
      _json["count"] = count;
    }
    if (id != null) {
      _json["id"] = id;
    }
    return _json;
  }
}

class Url {
  /**
   * A summary of the click analytics for the short and long URL. Might not be
   * present if not requested or currently unavailable.
   */
  AnalyticsSummary analytics;
  /**
   * Time the short URL was created; ISO 8601 representation using the
   * yyyy-MM-dd'T'HH:mm:ss.SSSZZ format, e.g. "2010-10-14T19:01:24.944+00:00".
   */
  core.String created;
  /** Short URL, e.g. "http://goo.gl/l6MS". */
  core.String id;
  /** The fixed string "urlshortener#url". */
  core.String kind;
  /**
   * Long URL, e.g. "http://www.google.com/". Might not be present if the status
   * is "REMOVED".
   */
  core.String longUrl;
  /**
   * Status of the target URL. Possible values: "OK", "MALWARE", "PHISHING", or
   * "REMOVED". A URL might be marked "REMOVED" if it was flagged as spam, for
   * example.
   */
  core.String status;

  Url();

  Url.fromJson(core.Map _json) {
    if (_json.containsKey("analytics")) {
      analytics = new AnalyticsSummary.fromJson(_json["analytics"]);
    }
    if (_json.containsKey("created")) {
      created = _json["created"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("longUrl")) {
      longUrl = _json["longUrl"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (analytics != null) {
      _json["analytics"] = (analytics).toJson();
    }
    if (created != null) {
      _json["created"] = created;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (longUrl != null) {
      _json["longUrl"] = longUrl;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

class UrlHistory {
  /** A list of URL resources. */
  core.List<Url> items;
  /**
   * Number of items returned with each full "page" of results. Note that the
   * last page could have fewer items than the "itemsPerPage" value.
   */
  core.int itemsPerPage;
  /** The fixed string "urlshortener#urlHistory". */
  core.String kind;
  /** A token to provide to get the next page of results. */
  core.String nextPageToken;
  /**
   * Total number of short URLs associated with this user (may be approximate).
   */
  core.int totalItems;

  UrlHistory();

  UrlHistory.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Url.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}
