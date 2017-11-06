// This is a generated file (see the discoveryapis_generator project).

library googleapis.youtubeAnalytics.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client youtubeAnalytics/v1';

/** Retrieves your YouTube Analytics data. */
class YoutubeAnalyticsApi {
  /** Manage your YouTube account */
  static const YoutubeScope = "https://www.googleapis.com/auth/youtube";

  /** View your YouTube account */
  static const YoutubeReadonlyScope = "https://www.googleapis.com/auth/youtube.readonly";

  /** View and manage your assets and associated content on YouTube */
  static const YoutubepartnerScope = "https://www.googleapis.com/auth/youtubepartner";

  /**
   * View monetary and non-monetary YouTube Analytics reports for your YouTube
   * content
   */
  static const YtAnalyticsMonetaryReadonlyScope = "https://www.googleapis.com/auth/yt-analytics-monetary.readonly";

  /** View YouTube Analytics reports for your YouTube content */
  static const YtAnalyticsReadonlyScope = "https://www.googleapis.com/auth/yt-analytics.readonly";


  final commons.ApiRequester _requester;

  GroupItemsResourceApi get groupItems => new GroupItemsResourceApi(_requester);
  GroupsResourceApi get groups => new GroupsResourceApi(_requester);
  ReportsResourceApi get reports => new ReportsResourceApi(_requester);

  YoutubeAnalyticsApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "youtube/analytics/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class GroupItemsResourceApi {
  final commons.ApiRequester _requester;

  GroupItemsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Removes an item from a group.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the YouTube group item ID for the group
   * that is being deleted.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _downloadOptions = null;

    _url = 'groupItems';

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
   * Creates a group item.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [GroupItem].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GroupItem> insert(GroupItem request, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'groupItems';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GroupItem.fromJson(data));
  }

  /**
   * Returns a collection of group items that match the API request parameters.
   *
   * Request parameters:
   *
   * [groupId] - The id parameter specifies the unique ID of the group for which
   * you want to retrieve group items.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [GroupItemListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GroupItemListResponse> list(core.String groupId, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (groupId == null) {
      throw new core.ArgumentError("Parameter groupId is required.");
    }
    _queryParams["groupId"] = [groupId];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'groupItems';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GroupItemListResponse.fromJson(data));
  }

}


class GroupsResourceApi {
  final commons.ApiRequester _requester;

  GroupsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a group.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the YouTube group ID for the group that
   * is being deleted.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _downloadOptions = null;

    _url = 'groups';

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
   * Creates a group.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [Group].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Group> insert(Group request, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'groups';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Group.fromJson(data));
  }

  /**
   * Returns a collection of groups that match the API request parameters. For
   * example, you can retrieve all groups that the authenticated user owns, or
   * you can retrieve one or more groups by their unique IDs.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies a comma-separated list of the YouTube
   * group ID(s) for the resource(s) that are being retrieved. In a group
   * resource, the id property specifies the group's YouTube group ID.
   *
   * [mine] - Set this parameter's value to true to instruct the API to only
   * return groups owned by the authenticated user.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * property identifies the next page that can be retrieved.
   *
   * Completes with a [GroupListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GroupListResponse> list({core.String id, core.bool mine, core.String onBehalfOfContentOwner, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (mine != null) {
      _queryParams["mine"] = ["${mine}"];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'groups';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GroupListResponse.fromJson(data));
  }

  /**
   * Modifies a group. For example, you could change a group's title.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [Group].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Group> update(Group request, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'groups';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Group.fromJson(data));
  }

}


class ReportsResourceApi {
  final commons.ApiRequester _requester;

  ReportsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieve your YouTube Analytics reports.
   *
   * Request parameters:
   *
   * [ids] - Identifies the YouTube channel or content owner for which you are
   * retrieving YouTube Analytics data.
   * - To request data for a YouTube user, set the ids parameter value to
   * channel==CHANNEL_ID, where CHANNEL_ID specifies the unique YouTube channel
   * ID.
   * - To request data for a YouTube CMS content owner, set the ids parameter
   * value to contentOwner==OWNER_NAME, where OWNER_NAME is the CMS name of the
   * content owner.
   * Value must have pattern "[a-zA-Z]+==[a-zA-Z0-9_+-]+".
   *
   * [start_date] - The start date for fetching YouTube Analytics data. The
   * value should be in YYYY-MM-DD format.
   * Value must have pattern "[0-9]{4}-[0-9]{2}-[0-9]{2}".
   *
   * [end_date] - The end date for fetching YouTube Analytics data. The value
   * should be in YYYY-MM-DD format.
   * Value must have pattern "[0-9]{4}-[0-9]{2}-[0-9]{2}".
   *
   * [metrics] - A comma-separated list of YouTube Analytics metrics, such as
   * views or likes,dislikes. See the Available Reports document for a list of
   * the reports that you can retrieve and the metrics available in each report,
   * and see the Metrics document for definitions of those metrics.
   * Value must have pattern "[0-9a-zA-Z,]+".
   *
   * [currency] - The currency to which financial metrics should be converted.
   * The default is US Dollar (USD). If the result contains no financial
   * metrics, this flag will be ignored. Responds with an error if the specified
   * currency is not recognized.
   * Value must have pattern "[A-Z]{3}".
   *
   * [dimensions] - A comma-separated list of YouTube Analytics dimensions, such
   * as views or ageGroup,gender. See the Available Reports document for a list
   * of the reports that you can retrieve and the dimensions used for those
   * reports. Also see the Dimensions document for definitions of those
   * dimensions.
   * Value must have pattern "[0-9a-zA-Z,]+".
   *
   * [filters] - A list of filters that should be applied when retrieving
   * YouTube Analytics data. The Available Reports document identifies the
   * dimensions that can be used to filter each report, and the Dimensions
   * document defines those dimensions. If a request uses multiple filters, join
   * them together with a semicolon (;), and the returned result table will
   * satisfy both filters. For example, a filters parameter value of
   * video==dMH0bHeiRNg;country==IT restricts the result set to include data for
   * the given video in Italy.
   *
   * [include_historical_channel_data] - If set to true historical data (i.e.
   * channel data from before the linking of the channel to the content owner)
   * will be retrieved.
   *
   * [max_results] - The maximum number of rows to include in the response.
   *
   * [sort] - A comma-separated list of dimensions or metrics that determine the
   * sort order for YouTube Analytics data. By default the sort order is
   * ascending. The '-' prefix causes descending sort order.
   * Value must have pattern "[-0-9a-zA-Z,]+".
   *
   * [start_index] - An index of the first entity to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter
   * (one-based, inclusive).
   *
   * Completes with a [ResultTable].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ResultTable> query(core.String ids, core.String start_date, core.String end_date, core.String metrics, {core.String currency, core.String dimensions, core.String filters, core.bool include_historical_channel_data, core.int max_results, core.String sort, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (ids == null) {
      throw new core.ArgumentError("Parameter ids is required.");
    }
    _queryParams["ids"] = [ids];
    if (start_date == null) {
      throw new core.ArgumentError("Parameter start_date is required.");
    }
    _queryParams["start-date"] = [start_date];
    if (end_date == null) {
      throw new core.ArgumentError("Parameter end_date is required.");
    }
    _queryParams["end-date"] = [end_date];
    if (metrics == null) {
      throw new core.ArgumentError("Parameter metrics is required.");
    }
    _queryParams["metrics"] = [metrics];
    if (currency != null) {
      _queryParams["currency"] = [currency];
    }
    if (dimensions != null) {
      _queryParams["dimensions"] = [dimensions];
    }
    if (filters != null) {
      _queryParams["filters"] = [filters];
    }
    if (include_historical_channel_data != null) {
      _queryParams["include-historical-channel-data"] = ["${include_historical_channel_data}"];
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (sort != null) {
      _queryParams["sort"] = [sort];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'reports';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ResultTable.fromJson(data));
  }

}



class GroupContentDetails {
  core.String itemCount;
  core.String itemType;

  GroupContentDetails();

  GroupContentDetails.fromJson(core.Map _json) {
    if (_json.containsKey("itemCount")) {
      itemCount = _json["itemCount"];
    }
    if (_json.containsKey("itemType")) {
      itemType = _json["itemType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (itemCount != null) {
      _json["itemCount"] = itemCount;
    }
    if (itemType != null) {
      _json["itemType"] = itemType;
    }
    return _json;
  }
}

class GroupSnippet {
  core.DateTime publishedAt;
  core.String title;

  GroupSnippet();

  GroupSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("publishedAt")) {
      publishedAt = core.DateTime.parse(_json["publishedAt"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (publishedAt != null) {
      _json["publishedAt"] = (publishedAt).toIso8601String();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class Group {
  GroupContentDetails contentDetails;
  core.String etag;
  core.String id;
  core.String kind;
  GroupSnippet snippet;

  Group();

  Group.fromJson(core.Map _json) {
    if (_json.containsKey("contentDetails")) {
      contentDetails = new GroupContentDetails.fromJson(_json["contentDetails"]);
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new GroupSnippet.fromJson(_json["snippet"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contentDetails != null) {
      _json["contentDetails"] = (contentDetails).toJson();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class GroupItemResource {
  core.String id;
  core.String kind;

  GroupItemResource();

  GroupItemResource.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class GroupItem {
  core.String etag;
  core.String groupId;
  core.String id;
  core.String kind;
  GroupItemResource resource;

  GroupItem();

  GroupItem.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("groupId")) {
      groupId = _json["groupId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("resource")) {
      resource = new GroupItemResource.fromJson(_json["resource"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (groupId != null) {
      _json["groupId"] = groupId;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (resource != null) {
      _json["resource"] = (resource).toJson();
    }
    return _json;
  }
}

/**
 * A paginated list of grouList resources returned in response to a
 * youtubeAnalytics.groupApi.list request.
 */
class GroupItemListResponse {
  core.String etag;
  core.List<GroupItem> items;
  core.String kind;

  GroupItemListResponse();

  GroupItemListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new GroupItem.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/**
 * A paginated list of grouList resources returned in response to a
 * youtubeAnalytics.groupApi.list request.
 */
class GroupListResponse {
  core.String etag;
  core.List<Group> items;
  core.String kind;
  core.String nextPageToken;

  GroupListResponse();

  GroupListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Group.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

class ResultTableColumnHeaders {
  /** The type of the column (DIMENSION or METRIC). */
  core.String columnType;
  /** The type of the data in the column (STRING, INTEGER, FLOAT, etc.). */
  core.String dataType;
  /** The name of the dimension or metric. */
  core.String name;

  ResultTableColumnHeaders();

  ResultTableColumnHeaders.fromJson(core.Map _json) {
    if (_json.containsKey("columnType")) {
      columnType = _json["columnType"];
    }
    if (_json.containsKey("dataType")) {
      dataType = _json["dataType"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnType != null) {
      _json["columnType"] = columnType;
    }
    if (dataType != null) {
      _json["dataType"] = dataType;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/**
 * Contains a single result table. The table is returned as an array of rows
 * that contain the values for the cells of the table. Depending on the metric
 * or dimension, the cell can contain a string (video ID, country code) or a
 * number (number of views or number of likes).
 */
class ResultTable {
  /**
   * This value specifies information about the data returned in the rows
   * fields. Each item in the columnHeaders list identifies a field returned in
   * the rows value, which contains a list of comma-delimited data. The
   * columnHeaders list will begin with the dimensions specified in the API
   * request, which will be followed by the metrics specified in the API
   * request. The order of both dimensions and metrics will match the ordering
   * in the API request. For example, if the API request contains the parameters
   * dimensions=ageGroup,gender&metrics=viewerPercentage, the API response will
   * return columns in this order: ageGroup,gender,viewerPercentage.
   */
  core.List<ResultTableColumnHeaders> columnHeaders;
  /**
   * This value specifies the type of data included in the API response. For the
   * query method, the kind property value will be youtubeAnalytics#resultTable.
   */
  core.String kind;
  /**
   * The list contains all rows of the result table. Each item in the list is an
   * array that contains comma-delimited data corresponding to a single row of
   * data. The order of the comma-delimited data fields will match the order of
   * the columns listed in the columnHeaders field. If no data is available for
   * the given query, the rows element will be omitted from the response. The
   * response for a query with the day dimension will not contain rows for the
   * most recent days.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.List<core.Object>> rows;

  ResultTable();

  ResultTable.fromJson(core.Map _json) {
    if (_json.containsKey("columnHeaders")) {
      columnHeaders = _json["columnHeaders"].map((value) => new ResultTableColumnHeaders.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnHeaders != null) {
      _json["columnHeaders"] = columnHeaders.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (rows != null) {
      _json["rows"] = rows;
    }
    return _json;
  }
}
