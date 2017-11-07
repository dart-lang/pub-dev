// This is a generated file (see the discoveryapis_generator project).

library googleapis.doubleclickbidmanager.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client doubleclickbidmanager/v1';

/** API for viewing and managing your reports in DoubleClick Bid Manager. */
class DoubleclickbidmanagerApi {

  final commons.ApiRequester _requester;

  LineitemsResourceApi get lineitems => new LineitemsResourceApi(_requester);
  QueriesResourceApi get queries => new QueriesResourceApi(_requester);
  ReportsResourceApi get reports => new ReportsResourceApi(_requester);
  SdfResourceApi get sdf => new SdfResourceApi(_requester);

  DoubleclickbidmanagerApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "doubleclickbidmanager/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class LineitemsResourceApi {
  final commons.ApiRequester _requester;

  LineitemsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves line items in CSV format.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [DownloadLineItemsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DownloadLineItemsResponse> downloadlineitems(DownloadLineItemsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'lineitems/downloadlineitems';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DownloadLineItemsResponse.fromJson(data));
  }

  /**
   * Uploads line items in CSV format.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [UploadLineItemsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UploadLineItemsResponse> uploadlineitems(UploadLineItemsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'lineitems/uploadlineitems';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UploadLineItemsResponse.fromJson(data));
  }

}


class QueriesResourceApi {
  final commons.ApiRequester _requester;

  QueriesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a query.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Query].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Query> createquery(Query request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'query';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Query.fromJson(data));
  }

  /**
   * Deletes a stored query as well as the associated stored reports.
   *
   * Request parameters:
   *
   * [queryId] - Query ID to delete.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future deletequery(core.String queryId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (queryId == null) {
      throw new core.ArgumentError("Parameter queryId is required.");
    }

    _downloadOptions = null;

    _url = 'query/' + commons.Escaper.ecapeVariable('$queryId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Retrieves a stored query.
   *
   * Request parameters:
   *
   * [queryId] - Query ID to retrieve.
   *
   * Completes with a [Query].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Query> getquery(core.String queryId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (queryId == null) {
      throw new core.ArgumentError("Parameter queryId is required.");
    }

    _url = 'query/' + commons.Escaper.ecapeVariable('$queryId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Query.fromJson(data));
  }

  /**
   * Retrieves stored queries.
   *
   * Request parameters:
   *
   * Completes with a [ListQueriesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListQueriesResponse> listqueries() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'queries';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListQueriesResponse.fromJson(data));
  }

  /**
   * Runs a stored query to generate a report.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [queryId] - Query ID to run.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future runquery(RunQueryRequest request, core.String queryId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (queryId == null) {
      throw new core.ArgumentError("Parameter queryId is required.");
    }

    _downloadOptions = null;

    _url = 'query/' + commons.Escaper.ecapeVariable('$queryId');

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

}


class ReportsResourceApi {
  final commons.ApiRequester _requester;

  ReportsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves stored reports.
   *
   * Request parameters:
   *
   * [queryId] - Query ID with which the reports are associated.
   *
   * Completes with a [ListReportsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListReportsResponse> listreports(core.String queryId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (queryId == null) {
      throw new core.ArgumentError("Parameter queryId is required.");
    }

    _url = 'queries/' + commons.Escaper.ecapeVariable('$queryId') + '/reports';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListReportsResponse.fromJson(data));
  }

}


class SdfResourceApi {
  final commons.ApiRequester _requester;

  SdfResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves entities in SDF format.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [DownloadResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DownloadResponse> download(DownloadRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'sdf/download';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DownloadResponse.fromJson(data));
  }

}



/** Request to fetch stored line items. */
class DownloadLineItemsRequest {
  /**
   * File specification (column names, types, order) in which the line items
   * will be returned. Default to EWF.
   * Possible string values are:
   * - "EWF"
   * - "SDF"
   */
  core.String fileSpec;
  /**
   * Ids of the specified filter type used to filter line items to fetch. If
   * omitted, all the line items will be returned.
   */
  core.List<core.String> filterIds;
  /**
   * Filter type used to filter line items to fetch.
   * Possible string values are:
   * - "ADVERTISER_ID"
   * - "INSERTION_ORDER_ID"
   * - "LINE_ITEM_ID"
   */
  core.String filterType;
  /**
   * Format in which the line items will be returned. Default to CSV.
   * Possible string values are:
   * - "CSV"
   */
  core.String format;

  DownloadLineItemsRequest();

  DownloadLineItemsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("fileSpec")) {
      fileSpec = _json["fileSpec"];
    }
    if (_json.containsKey("filterIds")) {
      filterIds = _json["filterIds"];
    }
    if (_json.containsKey("filterType")) {
      filterType = _json["filterType"];
    }
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fileSpec != null) {
      _json["fileSpec"] = fileSpec;
    }
    if (filterIds != null) {
      _json["filterIds"] = filterIds;
    }
    if (filterType != null) {
      _json["filterType"] = filterType;
    }
    if (format != null) {
      _json["format"] = format;
    }
    return _json;
  }
}

/** Download line items response. */
class DownloadLineItemsResponse {
  /**
   * Retrieved line items in CSV format. Refer to  Entity Write File Format or
   * Structured Data File Format for more information on file formats.
   */
  core.String lineItems;

  DownloadLineItemsResponse();

  DownloadLineItemsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lineItems != null) {
      _json["lineItems"] = lineItems;
    }
    return _json;
  }
}

/**
 * Request to fetch stored insertion orders, line items, TrueView ad groups and
 * ads.
 */
class DownloadRequest {
  /** File types that will be returned. */
  core.List<core.String> fileTypes;
  /**
   * The IDs of the specified filter type. This is used to filter entities to
   * fetch. At least one ID must be specified. Only one ID is allowed for the
   * ADVERTISER_ID filter type. For INSERTION_ORDER_ID or LINE_ITEM_ID filter
   * types, all IDs must be from the same Advertiser.
   */
  core.List<core.String> filterIds;
  /**
   * Filter type used to filter line items to fetch.
   * Possible string values are:
   * - "ADVERTISER_ID"
   * - "INSERTION_ORDER_ID"
   * - "LINE_ITEM_ID"
   */
  core.String filterType;
  /**
   * SDF Version (column names, types, order) in which the entities will be
   * returned. Default to 3.
   */
  core.String version;

  DownloadRequest();

  DownloadRequest.fromJson(core.Map _json) {
    if (_json.containsKey("fileTypes")) {
      fileTypes = _json["fileTypes"];
    }
    if (_json.containsKey("filterIds")) {
      filterIds = _json["filterIds"];
    }
    if (_json.containsKey("filterType")) {
      filterType = _json["filterType"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fileTypes != null) {
      _json["fileTypes"] = fileTypes;
    }
    if (filterIds != null) {
      _json["filterIds"] = filterIds;
    }
    if (filterType != null) {
      _json["filterType"] = filterType;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

/** Download response. */
class DownloadResponse {
  /** Retrieved ad groups in SDF format. */
  core.String adGroups;
  /** Retrieved ads in SDF format. */
  core.String ads;
  /** Retrieved insertion orders in SDF format. */
  core.String insertionOrders;
  /** Retrieved line items in SDF format. */
  core.String lineItems;

  DownloadResponse();

  DownloadResponse.fromJson(core.Map _json) {
    if (_json.containsKey("adGroups")) {
      adGroups = _json["adGroups"];
    }
    if (_json.containsKey("ads")) {
      ads = _json["ads"];
    }
    if (_json.containsKey("insertionOrders")) {
      insertionOrders = _json["insertionOrders"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adGroups != null) {
      _json["adGroups"] = adGroups;
    }
    if (ads != null) {
      _json["ads"] = ads;
    }
    if (insertionOrders != null) {
      _json["insertionOrders"] = insertionOrders;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems;
    }
    return _json;
  }
}

/** Filter used to match traffic data in your report. */
class FilterPair {
  /**
   * Filter type.
   * Possible string values are:
   * - "FILTER_ACTIVE_VIEW_EXPECTED_VIEWABILITY"
   * - "FILTER_ACTIVITY_ID"
   * - "FILTER_ADVERTISER"
   * - "FILTER_ADVERTISER_CURRENCY"
   * - "FILTER_ADVERTISER_TIMEZONE"
   * - "FILTER_AD_POSITION"
   * - "FILTER_AGE"
   * - "FILTER_BRANDSAFE_CHANNEL_ID"
   * - "FILTER_BROWSER"
   * - "FILTER_CAMPAIGN_DAILY_FREQUENCY"
   * - "FILTER_CARRIER"
   * - "FILTER_CHANNEL_ID"
   * - "FILTER_CITY"
   * - "FILTER_COMPANION_CREATIVE_ID"
   * - "FILTER_CONVERSION_DELAY"
   * - "FILTER_COUNTRY"
   * - "FILTER_CREATIVE_HEIGHT"
   * - "FILTER_CREATIVE_ID"
   * - "FILTER_CREATIVE_SIZE"
   * - "FILTER_CREATIVE_TYPE"
   * - "FILTER_CREATIVE_WIDTH"
   * - "FILTER_DATA_PROVIDER"
   * - "FILTER_DATE"
   * - "FILTER_DAY_OF_WEEK"
   * - "FILTER_DFP_ORDER_ID"
   * - "FILTER_DMA"
   * - "FILTER_EXCHANGE_ID"
   * - "FILTER_FLOODLIGHT_PIXEL_ID"
   * - "FILTER_GENDER"
   * - "FILTER_INSERTION_ORDER"
   * - "FILTER_INVENTORY_FORMAT"
   * - "FILTER_INVENTORY_SOURCE"
   * - "FILTER_INVENTORY_SOURCE_TYPE"
   * - "FILTER_KEYWORD"
   * - "FILTER_LINE_ITEM"
   * - "FILTER_LINE_ITEM_DAILY_FREQUENCY"
   * - "FILTER_LINE_ITEM_LIFETIME_FREQUENCY"
   * - "FILTER_LINE_ITEM_TYPE"
   * - "FILTER_MEDIA_PLAN"
   * - "FILTER_MOBILE_DEVICE_MAKE"
   * - "FILTER_MOBILE_DEVICE_MAKE_MODEL"
   * - "FILTER_MOBILE_DEVICE_TYPE"
   * - "FILTER_MOBILE_GEO"
   * - "FILTER_MONTH"
   * - "FILTER_MRAID_SUPPORT"
   * - "FILTER_NIELSEN_AGE"
   * - "FILTER_NIELSEN_COUNTRY_CODE"
   * - "FILTER_NIELSEN_DEVICE_ID"
   * - "FILTER_NIELSEN_GENDER"
   * - "FILTER_NOT_SUPPORTED"
   * - "FILTER_ORDER_ID"
   * - "FILTER_OS"
   * - "FILTER_PAGE_CATEGORY"
   * - "FILTER_PAGE_LAYOUT"
   * - "FILTER_PARTNER"
   * - "FILTER_PARTNER_CURRENCY"
   * - "FILTER_PUBLIC_INVENTORY"
   * - "FILTER_QUARTER"
   * - "FILTER_REGION"
   * - "FILTER_REGULAR_CHANNEL_ID"
   * - "FILTER_SITE_ID"
   * - "FILTER_SITE_LANGUAGE"
   * - "FILTER_SKIPPABLE_SUPPORT"
   * - "FILTER_TARGETED_USER_LIST"
   * - "FILTER_TIME_OF_DAY"
   * - "FILTER_TRUEVIEW_AD_GROUP_AD_ID"
   * - "FILTER_TRUEVIEW_AD_GROUP_ID"
   * - "FILTER_TRUEVIEW_AGE"
   * - "FILTER_TRUEVIEW_CATEGORY"
   * - "FILTER_TRUEVIEW_CITY"
   * - "FILTER_TRUEVIEW_CONVERSION_TYPE"
   * - "FILTER_TRUEVIEW_COUNTRY"
   * - "FILTER_TRUEVIEW_CUSTOM_AFFINITY"
   * - "FILTER_TRUEVIEW_DMA"
   * - "FILTER_TRUEVIEW_GENDER"
   * - "FILTER_TRUEVIEW_IAR_AGE"
   * - "FILTER_TRUEVIEW_IAR_CATEGORY"
   * - "FILTER_TRUEVIEW_IAR_CITY"
   * - "FILTER_TRUEVIEW_IAR_COUNTRY"
   * - "FILTER_TRUEVIEW_IAR_GENDER"
   * - "FILTER_TRUEVIEW_IAR_INTEREST"
   * - "FILTER_TRUEVIEW_IAR_LANGUAGE"
   * - "FILTER_TRUEVIEW_IAR_PARENTAL_STATUS"
   * - "FILTER_TRUEVIEW_IAR_REGION"
   * - "FILTER_TRUEVIEW_IAR_REMARKETING_LIST"
   * - "FILTER_TRUEVIEW_IAR_TIME_OF_DAY"
   * - "FILTER_TRUEVIEW_IAR_YOUTUBE_CHANNEL"
   * - "FILTER_TRUEVIEW_IAR_YOUTUBE_VIDEO"
   * - "FILTER_TRUEVIEW_IAR_ZIPCODE"
   * - "FILTER_TRUEVIEW_INTEREST"
   * - "FILTER_TRUEVIEW_KEYWORD"
   * - "FILTER_TRUEVIEW_PARENTAL_STATUS"
   * - "FILTER_TRUEVIEW_PLACEMENT"
   * - "FILTER_TRUEVIEW_REGION"
   * - "FILTER_TRUEVIEW_REMARKETING_LIST"
   * - "FILTER_TRUEVIEW_URL"
   * - "FILTER_TRUEVIEW_ZIPCODE"
   * - "FILTER_UNKNOWN"
   * - "FILTER_USER_LIST"
   * - "FILTER_USER_LIST_FIRST_PARTY"
   * - "FILTER_USER_LIST_THIRD_PARTY"
   * - "FILTER_VIDEO_AD_POSITION_IN_STREAM"
   * - "FILTER_VIDEO_COMPANION_SIZE"
   * - "FILTER_VIDEO_COMPANION_TYPE"
   * - "FILTER_VIDEO_CREATIVE_DURATION"
   * - "FILTER_VIDEO_CREATIVE_DURATION_SKIPPABLE"
   * - "FILTER_VIDEO_DURATION_SECONDS"
   * - "FILTER_VIDEO_FORMAT_SUPPORT"
   * - "FILTER_VIDEO_INVENTORY_TYPE"
   * - "FILTER_VIDEO_PLAYER_SIZE"
   * - "FILTER_VIDEO_RATING_TIER"
   * - "FILTER_VIDEO_SKIPPABLE_SUPPORT"
   * - "FILTER_VIDEO_VPAID_SUPPORT"
   * - "FILTER_WEEK"
   * - "FILTER_YEAR"
   * - "FILTER_YOUTUBE_VERTICAL"
   * - "FILTER_ZIP_CODE"
   */
  core.String type;
  /** Filter value. */
  core.String value;

  FilterPair();

  FilterPair.fromJson(core.Map _json) {
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (type != null) {
      _json["type"] = type;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** List queries response. */
class ListQueriesResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "doubleclickbidmanager#listQueriesResponse".
   */
  core.String kind;
  /** Retrieved queries. */
  core.List<Query> queries;

  ListQueriesResponse();

  ListQueriesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("queries")) {
      queries = _json["queries"].map((value) => new Query.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (queries != null) {
      _json["queries"] = queries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** List reports response. */
class ListReportsResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "doubleclickbidmanager#listReportsResponse".
   */
  core.String kind;
  /** Retrieved reports. */
  core.List<Report> reports;

  ListReportsResponse();

  ListReportsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("reports")) {
      reports = _json["reports"].map((value) => new Report.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (reports != null) {
      _json["reports"] = reports.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Parameters of a query or report. */
class Parameters {
  /** Filters used to match traffic data in your report. */
  core.List<FilterPair> filters;
  /** Data is grouped by the filters listed in this field. */
  core.List<core.String> groupBys;
  /** Whether to include data from Invite Media. */
  core.bool includeInviteData;
  /** Metrics to include as columns in your report. */
  core.List<core.String> metrics;
  /**
   * Report type.
   * Possible string values are:
   * - "TYPE_ACTIVE_GRP"
   * - "TYPE_AUDIENCE_COMPOSITION"
   * - "TYPE_AUDIENCE_PERFORMANCE"
   * - "TYPE_CLIENT_SAFE"
   * - "TYPE_COMSCORE_VCE"
   * - "TYPE_CROSS_FEE"
   * - "TYPE_CROSS_PARTNER"
   * - "TYPE_CROSS_PARTNER_THIRD_PARTY_DATA_PROVIDER"
   * - "TYPE_ESTIMATED_CONVERSION"
   * - "TYPE_FEE"
   * - "TYPE_GENERAL"
   * - "TYPE_INVENTORY_AVAILABILITY"
   * - "TYPE_KEYWORD"
   * - "TYPE_NIELSEN_AUDIENCE_PROFILE"
   * - "TYPE_NIELSEN_DAILY_REACH_BUILD"
   * - "TYPE_NIELSEN_ONLINE_GLOBAL_MARKET"
   * - "TYPE_NIELSEN_SITE"
   * - "TYPE_NOT_SUPPORTED"
   * - "TYPE_ORDER_ID"
   * - "TYPE_PAGE_CATEGORY"
   * - "TYPE_PETRA_NIELSEN_AUDIENCE_PROFILE"
   * - "TYPE_PETRA_NIELSEN_DAILY_REACH_BUILD"
   * - "TYPE_PETRA_NIELSEN_ONLINE_GLOBAL_MARKET"
   * - "TYPE_PIXEL_LOAD"
   * - "TYPE_REACH_AND_FREQUENCY"
   * - "TYPE_REACH_AUDIENCE"
   * - "TYPE_THIRD_PARTY_DATA_PROVIDER"
   * - "TYPE_TRUEVIEW"
   * - "TYPE_TRUEVIEW_IAR"
   * - "TYPE_VERIFICATION"
   * - "TYPE_YOUTUBE_VERTICAL"
   */
  core.String type;

  Parameters();

  Parameters.fromJson(core.Map _json) {
    if (_json.containsKey("filters")) {
      filters = _json["filters"].map((value) => new FilterPair.fromJson(value)).toList();
    }
    if (_json.containsKey("groupBys")) {
      groupBys = _json["groupBys"];
    }
    if (_json.containsKey("includeInviteData")) {
      includeInviteData = _json["includeInviteData"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (filters != null) {
      _json["filters"] = filters.map((value) => (value).toJson()).toList();
    }
    if (groupBys != null) {
      _json["groupBys"] = groupBys;
    }
    if (includeInviteData != null) {
      _json["includeInviteData"] = includeInviteData;
    }
    if (metrics != null) {
      _json["metrics"] = metrics;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Represents a query. */
class Query {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "doubleclickbidmanager#query".
   */
  core.String kind;
  /** Query metadata. */
  QueryMetadata metadata;
  /** Query parameters. */
  Parameters params;
  /** Query ID. */
  core.String queryId;
  /**
   * The ending time for the data that is shown in the report. Note,
   * reportDataEndTimeMs is required if metadata.dataRange is CUSTOM_DATES and
   * ignored otherwise.
   */
  core.String reportDataEndTimeMs;
  /**
   * The starting time for the data that is shown in the report. Note,
   * reportDataStartTimeMs is required if metadata.dataRange is CUSTOM_DATES and
   * ignored otherwise.
   */
  core.String reportDataStartTimeMs;
  /** Information on how often and when to run a query. */
  QuerySchedule schedule;
  /**
   * Canonical timezone code for report data time. Defaults to America/New_York.
   */
  core.String timezoneCode;

  Query();

  Query.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new QueryMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("params")) {
      params = new Parameters.fromJson(_json["params"]);
    }
    if (_json.containsKey("queryId")) {
      queryId = _json["queryId"];
    }
    if (_json.containsKey("reportDataEndTimeMs")) {
      reportDataEndTimeMs = _json["reportDataEndTimeMs"];
    }
    if (_json.containsKey("reportDataStartTimeMs")) {
      reportDataStartTimeMs = _json["reportDataStartTimeMs"];
    }
    if (_json.containsKey("schedule")) {
      schedule = new QuerySchedule.fromJson(_json["schedule"]);
    }
    if (_json.containsKey("timezoneCode")) {
      timezoneCode = _json["timezoneCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (params != null) {
      _json["params"] = (params).toJson();
    }
    if (queryId != null) {
      _json["queryId"] = queryId;
    }
    if (reportDataEndTimeMs != null) {
      _json["reportDataEndTimeMs"] = reportDataEndTimeMs;
    }
    if (reportDataStartTimeMs != null) {
      _json["reportDataStartTimeMs"] = reportDataStartTimeMs;
    }
    if (schedule != null) {
      _json["schedule"] = (schedule).toJson();
    }
    if (timezoneCode != null) {
      _json["timezoneCode"] = timezoneCode;
    }
    return _json;
  }
}

/** Query metadata. */
class QueryMetadata {
  /**
   * Range of report data.
   * Possible string values are:
   * - "ALL_TIME"
   * - "CURRENT_DAY"
   * - "CUSTOM_DATES"
   * - "LAST_14_DAYS"
   * - "LAST_30_DAYS"
   * - "LAST_365_DAYS"
   * - "LAST_7_DAYS"
   * - "LAST_90_DAYS"
   * - "MONTH_TO_DATE"
   * - "PREVIOUS_DAY"
   * - "PREVIOUS_HALF_MONTH"
   * - "PREVIOUS_MONTH"
   * - "PREVIOUS_QUARTER"
   * - "PREVIOUS_WEEK"
   * - "PREVIOUS_YEAR"
   * - "QUARTER_TO_DATE"
   * - "TYPE_NOT_SUPPORTED"
   * - "WEEK_TO_DATE"
   * - "YEAR_TO_DATE"
   */
  core.String dataRange;
  /**
   * Format of the generated report.
   * Possible string values are:
   * - "CSV"
   * - "EXCEL_CSV"
   * - "XLSX"
   */
  core.String format;
  /**
   * The path to the location in Google Cloud Storage where the latest report is
   * stored.
   */
  core.String googleCloudStoragePathForLatestReport;
  /** The path in Google Drive for the latest report. */
  core.String googleDrivePathForLatestReport;
  /** The time when the latest report started to run. */
  core.String latestReportRunTimeMs;
  /**
   * Locale of the generated reports. Valid values are cs CZECH de GERMAN en
   * ENGLISH es SPANISH fr FRENCH it ITALIAN ja JAPANESE ko KOREAN pl POLISH
   * pt-BR BRAZILIAN_PORTUGUESE ru RUSSIAN tr TURKISH uk UKRAINIAN zh-CN
   * CHINA_CHINESE zh-TW TAIWAN_CHINESE
   *
   * An locale string not in the list above will generate reports in English.
   */
  core.String locale;
  /** Number of reports that have been generated for the query. */
  core.int reportCount;
  /** Whether the latest report is currently running. */
  core.bool running;
  /**
   * Whether to send an email notification when a report is ready. Default to
   * false.
   */
  core.bool sendNotification;
  /**
   * List of email addresses which are sent email notifications when the report
   * is finished. Separate from sendNotification.
   */
  core.List<core.String> shareEmailAddress;
  /** Query title. It is used to name the reports generated from this query. */
  core.String title;

  QueryMetadata();

  QueryMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("dataRange")) {
      dataRange = _json["dataRange"];
    }
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("googleCloudStoragePathForLatestReport")) {
      googleCloudStoragePathForLatestReport = _json["googleCloudStoragePathForLatestReport"];
    }
    if (_json.containsKey("googleDrivePathForLatestReport")) {
      googleDrivePathForLatestReport = _json["googleDrivePathForLatestReport"];
    }
    if (_json.containsKey("latestReportRunTimeMs")) {
      latestReportRunTimeMs = _json["latestReportRunTimeMs"];
    }
    if (_json.containsKey("locale")) {
      locale = _json["locale"];
    }
    if (_json.containsKey("reportCount")) {
      reportCount = _json["reportCount"];
    }
    if (_json.containsKey("running")) {
      running = _json["running"];
    }
    if (_json.containsKey("sendNotification")) {
      sendNotification = _json["sendNotification"];
    }
    if (_json.containsKey("shareEmailAddress")) {
      shareEmailAddress = _json["shareEmailAddress"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dataRange != null) {
      _json["dataRange"] = dataRange;
    }
    if (format != null) {
      _json["format"] = format;
    }
    if (googleCloudStoragePathForLatestReport != null) {
      _json["googleCloudStoragePathForLatestReport"] = googleCloudStoragePathForLatestReport;
    }
    if (googleDrivePathForLatestReport != null) {
      _json["googleDrivePathForLatestReport"] = googleDrivePathForLatestReport;
    }
    if (latestReportRunTimeMs != null) {
      _json["latestReportRunTimeMs"] = latestReportRunTimeMs;
    }
    if (locale != null) {
      _json["locale"] = locale;
    }
    if (reportCount != null) {
      _json["reportCount"] = reportCount;
    }
    if (running != null) {
      _json["running"] = running;
    }
    if (sendNotification != null) {
      _json["sendNotification"] = sendNotification;
    }
    if (shareEmailAddress != null) {
      _json["shareEmailAddress"] = shareEmailAddress;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** Information on how frequently and when to run a query. */
class QuerySchedule {
  /** Datetime to periodically run the query until. */
  core.String endTimeMs;
  /**
   * How often the query is run.
   * Possible string values are:
   * - "DAILY"
   * - "MONTHLY"
   * - "ONE_TIME"
   * - "QUARTERLY"
   * - "SEMI_MONTHLY"
   * - "WEEKLY"
   */
  core.String frequency;
  /**
   * Time of day at which a new report will be generated, represented as minutes
   * past midnight. Range is 0 to 1439. Only applies to scheduled reports.
   */
  core.int nextRunMinuteOfDay;
  /**
   * Canonical timezone code for report generation time. Defaults to
   * America/New_York.
   */
  core.String nextRunTimezoneCode;

  QuerySchedule();

  QuerySchedule.fromJson(core.Map _json) {
    if (_json.containsKey("endTimeMs")) {
      endTimeMs = _json["endTimeMs"];
    }
    if (_json.containsKey("frequency")) {
      frequency = _json["frequency"];
    }
    if (_json.containsKey("nextRunMinuteOfDay")) {
      nextRunMinuteOfDay = _json["nextRunMinuteOfDay"];
    }
    if (_json.containsKey("nextRunTimezoneCode")) {
      nextRunTimezoneCode = _json["nextRunTimezoneCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endTimeMs != null) {
      _json["endTimeMs"] = endTimeMs;
    }
    if (frequency != null) {
      _json["frequency"] = frequency;
    }
    if (nextRunMinuteOfDay != null) {
      _json["nextRunMinuteOfDay"] = nextRunMinuteOfDay;
    }
    if (nextRunTimezoneCode != null) {
      _json["nextRunTimezoneCode"] = nextRunTimezoneCode;
    }
    return _json;
  }
}

/** Represents a report. */
class Report {
  /** Key used to identify a report. */
  ReportKey key;
  /** Report metadata. */
  ReportMetadata metadata;
  /** Report parameters. */
  Parameters params;

  Report();

  Report.fromJson(core.Map _json) {
    if (_json.containsKey("key")) {
      key = new ReportKey.fromJson(_json["key"]);
    }
    if (_json.containsKey("metadata")) {
      metadata = new ReportMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("params")) {
      params = new Parameters.fromJson(_json["params"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (key != null) {
      _json["key"] = (key).toJson();
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (params != null) {
      _json["params"] = (params).toJson();
    }
    return _json;
  }
}

/** An explanation of a report failure. */
class ReportFailure {
  /**
   * Error code that shows why the report was not created.
   * Possible string values are:
   * - "AUTHENTICATION_ERROR"
   * - "DEPRECATED_REPORTING_INVALID_QUERY"
   * - "REPORTING_BUCKET_NOT_FOUND"
   * - "REPORTING_CREATE_BUCKET_FAILED"
   * - "REPORTING_DELETE_BUCKET_FAILED"
   * - "REPORTING_FATAL_ERROR"
   * - "REPORTING_ILLEGAL_FILENAME"
   * - "REPORTING_IMCOMPATIBLE_METRICS"
   * - "REPORTING_INVALID_QUERY_MISSING_PARTNER_AND_ADVERTISER_FILTERS"
   * - "REPORTING_INVALID_QUERY_TITLE_MISSING"
   * - "REPORTING_INVALID_QUERY_TOO_MANY_UNFILTERED_LARGE_GROUP_BYS"
   * - "REPORTING_QUERY_NOT_FOUND"
   * - "REPORTING_TRANSIENT_ERROR"
   * - "REPORTING_UPDATE_BUCKET_PERMISSION_FAILED"
   * - "REPORTING_WRITE_BUCKET_OBJECT_FAILED"
   * - "SERVER_ERROR"
   * - "UNAUTHORIZED_API_ACCESS"
   * - "VALIDATION_ERROR"
   */
  core.String errorCode;

  ReportFailure();

  ReportFailure.fromJson(core.Map _json) {
    if (_json.containsKey("errorCode")) {
      errorCode = _json["errorCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (errorCode != null) {
      _json["errorCode"] = errorCode;
    }
    return _json;
  }
}

/** Key used to identify a report. */
class ReportKey {
  /** Query ID. */
  core.String queryId;
  /** Report ID. */
  core.String reportId;

  ReportKey();

  ReportKey.fromJson(core.Map _json) {
    if (_json.containsKey("queryId")) {
      queryId = _json["queryId"];
    }
    if (_json.containsKey("reportId")) {
      reportId = _json["reportId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (queryId != null) {
      _json["queryId"] = queryId;
    }
    if (reportId != null) {
      _json["reportId"] = reportId;
    }
    return _json;
  }
}

/** Report metadata. */
class ReportMetadata {
  /**
   * The path to the location in Google Cloud Storage where the report is
   * stored.
   */
  core.String googleCloudStoragePath;
  /** The ending time for the data that is shown in the report. */
  core.String reportDataEndTimeMs;
  /** The starting time for the data that is shown in the report. */
  core.String reportDataStartTimeMs;
  /** Report status. */
  ReportStatus status;

  ReportMetadata();

  ReportMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("googleCloudStoragePath")) {
      googleCloudStoragePath = _json["googleCloudStoragePath"];
    }
    if (_json.containsKey("reportDataEndTimeMs")) {
      reportDataEndTimeMs = _json["reportDataEndTimeMs"];
    }
    if (_json.containsKey("reportDataStartTimeMs")) {
      reportDataStartTimeMs = _json["reportDataStartTimeMs"];
    }
    if (_json.containsKey("status")) {
      status = new ReportStatus.fromJson(_json["status"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (googleCloudStoragePath != null) {
      _json["googleCloudStoragePath"] = googleCloudStoragePath;
    }
    if (reportDataEndTimeMs != null) {
      _json["reportDataEndTimeMs"] = reportDataEndTimeMs;
    }
    if (reportDataStartTimeMs != null) {
      _json["reportDataStartTimeMs"] = reportDataStartTimeMs;
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    return _json;
  }
}

/** Report status. */
class ReportStatus {
  /** If the report failed, this records the cause. */
  ReportFailure failure;
  /** The time when this report either completed successfully or failed. */
  core.String finishTimeMs;
  /**
   * The file type of the report.
   * Possible string values are:
   * - "CSV"
   * - "EXCEL_CSV"
   * - "XLSX"
   */
  core.String format;
  /**
   * The state of the report.
   * Possible string values are:
   * - "DONE"
   * - "FAILED"
   * - "RUNNING"
   */
  core.String state;

  ReportStatus();

  ReportStatus.fromJson(core.Map _json) {
    if (_json.containsKey("failure")) {
      failure = new ReportFailure.fromJson(_json["failure"]);
    }
    if (_json.containsKey("finishTimeMs")) {
      finishTimeMs = _json["finishTimeMs"];
    }
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (failure != null) {
      _json["failure"] = (failure).toJson();
    }
    if (finishTimeMs != null) {
      _json["finishTimeMs"] = finishTimeMs;
    }
    if (format != null) {
      _json["format"] = format;
    }
    if (state != null) {
      _json["state"] = state;
    }
    return _json;
  }
}

/** Represents the upload status of a row in the request. */
class RowStatus {
  /** Whether the stored entity is changed as a result of upload. */
  core.bool changed;
  /** Entity Id. */
  core.String entityId;
  /** Entity name. */
  core.String entityName;
  /** Reasons why the entity can't be uploaded. */
  core.List<core.String> errors;
  /** Whether the entity is persisted. */
  core.bool persisted;
  /** Row number. */
  core.int rowNumber;

  RowStatus();

  RowStatus.fromJson(core.Map _json) {
    if (_json.containsKey("changed")) {
      changed = _json["changed"];
    }
    if (_json.containsKey("entityId")) {
      entityId = _json["entityId"];
    }
    if (_json.containsKey("entityName")) {
      entityName = _json["entityName"];
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"];
    }
    if (_json.containsKey("persisted")) {
      persisted = _json["persisted"];
    }
    if (_json.containsKey("rowNumber")) {
      rowNumber = _json["rowNumber"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (changed != null) {
      _json["changed"] = changed;
    }
    if (entityId != null) {
      _json["entityId"] = entityId;
    }
    if (entityName != null) {
      _json["entityName"] = entityName;
    }
    if (errors != null) {
      _json["errors"] = errors;
    }
    if (persisted != null) {
      _json["persisted"] = persisted;
    }
    if (rowNumber != null) {
      _json["rowNumber"] = rowNumber;
    }
    return _json;
  }
}

/** Request to run a stored query to generate a report. */
class RunQueryRequest {
  /**
   * Report data range used to generate the report.
   * Possible string values are:
   * - "ALL_TIME"
   * - "CURRENT_DAY"
   * - "CUSTOM_DATES"
   * - "LAST_14_DAYS"
   * - "LAST_30_DAYS"
   * - "LAST_365_DAYS"
   * - "LAST_7_DAYS"
   * - "LAST_90_DAYS"
   * - "MONTH_TO_DATE"
   * - "PREVIOUS_DAY"
   * - "PREVIOUS_HALF_MONTH"
   * - "PREVIOUS_MONTH"
   * - "PREVIOUS_QUARTER"
   * - "PREVIOUS_WEEK"
   * - "PREVIOUS_YEAR"
   * - "QUARTER_TO_DATE"
   * - "TYPE_NOT_SUPPORTED"
   * - "WEEK_TO_DATE"
   * - "YEAR_TO_DATE"
   */
  core.String dataRange;
  /**
   * The ending time for the data that is shown in the report. Note,
   * reportDataEndTimeMs is required if dataRange is CUSTOM_DATES and ignored
   * otherwise.
   */
  core.String reportDataEndTimeMs;
  /**
   * The starting time for the data that is shown in the report. Note,
   * reportDataStartTimeMs is required if dataRange is CUSTOM_DATES and ignored
   * otherwise.
   */
  core.String reportDataStartTimeMs;
  /**
   * Canonical timezone code for report data time. Defaults to America/New_York.
   */
  core.String timezoneCode;

  RunQueryRequest();

  RunQueryRequest.fromJson(core.Map _json) {
    if (_json.containsKey("dataRange")) {
      dataRange = _json["dataRange"];
    }
    if (_json.containsKey("reportDataEndTimeMs")) {
      reportDataEndTimeMs = _json["reportDataEndTimeMs"];
    }
    if (_json.containsKey("reportDataStartTimeMs")) {
      reportDataStartTimeMs = _json["reportDataStartTimeMs"];
    }
    if (_json.containsKey("timezoneCode")) {
      timezoneCode = _json["timezoneCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dataRange != null) {
      _json["dataRange"] = dataRange;
    }
    if (reportDataEndTimeMs != null) {
      _json["reportDataEndTimeMs"] = reportDataEndTimeMs;
    }
    if (reportDataStartTimeMs != null) {
      _json["reportDataStartTimeMs"] = reportDataStartTimeMs;
    }
    if (timezoneCode != null) {
      _json["timezoneCode"] = timezoneCode;
    }
    return _json;
  }
}

/** Request to upload line items. */
class UploadLineItemsRequest {
  /**
   * Set to true to get upload status without actually persisting the line
   * items.
   */
  core.bool dryRun;
  /**
   * Format the line items are in. Default to CSV.
   * Possible string values are:
   * - "CSV"
   */
  core.String format;
  /**
   * Line items in CSV to upload. Refer to  Entity Write File Format for more
   * information on file format.
   */
  core.String lineItems;

  UploadLineItemsRequest();

  UploadLineItemsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("dryRun")) {
      dryRun = _json["dryRun"];
    }
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dryRun != null) {
      _json["dryRun"] = dryRun;
    }
    if (format != null) {
      _json["format"] = format;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems;
    }
    return _json;
  }
}

/** Upload line items response. */
class UploadLineItemsResponse {
  /** Status of upload. */
  UploadStatus uploadStatus;

  UploadLineItemsResponse();

  UploadLineItemsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("uploadStatus")) {
      uploadStatus = new UploadStatus.fromJson(_json["uploadStatus"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (uploadStatus != null) {
      _json["uploadStatus"] = (uploadStatus).toJson();
    }
    return _json;
  }
}

/** Represents the status of upload. */
class UploadStatus {
  /** Reasons why upload can't be completed. */
  core.List<core.String> errors;
  /** Per-row upload status. */
  core.List<RowStatus> rowStatus;

  UploadStatus();

  UploadStatus.fromJson(core.Map _json) {
    if (_json.containsKey("errors")) {
      errors = _json["errors"];
    }
    if (_json.containsKey("rowStatus")) {
      rowStatus = _json["rowStatus"].map((value) => new RowStatus.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (errors != null) {
      _json["errors"] = errors;
    }
    if (rowStatus != null) {
      _json["rowStatus"] = rowStatus.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
