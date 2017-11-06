// This is a generated file (see the discoveryapis_generator project).

library googleapis.gamesConfiguration.v1configuration;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client gamesConfiguration/v1configuration';

/** The Publishing API for Google Play Game Services. */
class GamesConfigurationApi {
  /** View and manage your Google Play Developer account */
  static const AndroidpublisherScope = "https://www.googleapis.com/auth/androidpublisher";


  final commons.ApiRequester _requester;

  AchievementConfigurationsResourceApi get achievementConfigurations => new AchievementConfigurationsResourceApi(_requester);
  ImageConfigurationsResourceApi get imageConfigurations => new ImageConfigurationsResourceApi(_requester);
  LeaderboardConfigurationsResourceApi get leaderboardConfigurations => new LeaderboardConfigurationsResourceApi(_requester);

  GamesConfigurationApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "games/v1configuration/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AchievementConfigurationsResourceApi {
  final commons.ApiRequester _requester;

  AchievementConfigurationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Delete the achievement configuration with the given ID.
   *
   * Request parameters:
   *
   * [achievementId] - The ID of the achievement used by this method.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String achievementId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (achievementId == null) {
      throw new core.ArgumentError("Parameter achievementId is required.");
    }

    _downloadOptions = null;

    _url = 'achievements/' + commons.Escaper.ecapeVariable('$achievementId');

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
   * Retrieves the metadata of the achievement configuration with the given ID.
   *
   * Request parameters:
   *
   * [achievementId] - The ID of the achievement used by this method.
   *
   * Completes with a [AchievementConfiguration].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementConfiguration> get(core.String achievementId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (achievementId == null) {
      throw new core.ArgumentError("Parameter achievementId is required.");
    }

    _url = 'achievements/' + commons.Escaper.ecapeVariable('$achievementId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementConfiguration.fromJson(data));
  }

  /**
   * Insert a new achievement configuration in this application.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [applicationId] - The application ID from the Google Play developer
   * console.
   *
   * Completes with a [AchievementConfiguration].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementConfiguration> insert(AchievementConfiguration request, core.String applicationId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (applicationId == null) {
      throw new core.ArgumentError("Parameter applicationId is required.");
    }

    _url = 'applications/' + commons.Escaper.ecapeVariable('$applicationId') + '/achievements';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementConfiguration.fromJson(data));
  }

  /**
   * Returns a list of the achievement configurations in this application.
   *
   * Request parameters:
   *
   * [applicationId] - The application ID from the Google Play developer
   * console.
   *
   * [maxResults] - The maximum number of resource configurations to return in
   * the response, used for paging. For any response, the actual number of
   * resources returned may be less than the specified maxResults.
   * Value must be between "1" and "200".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [AchievementConfigurationListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementConfigurationListResponse> list(core.String applicationId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (applicationId == null) {
      throw new core.ArgumentError("Parameter applicationId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'applications/' + commons.Escaper.ecapeVariable('$applicationId') + '/achievements';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementConfigurationListResponse.fromJson(data));
  }

  /**
   * Update the metadata of the achievement configuration with the given ID.
   * This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [achievementId] - The ID of the achievement used by this method.
   *
   * Completes with a [AchievementConfiguration].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementConfiguration> patch(AchievementConfiguration request, core.String achievementId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (achievementId == null) {
      throw new core.ArgumentError("Parameter achievementId is required.");
    }

    _url = 'achievements/' + commons.Escaper.ecapeVariable('$achievementId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementConfiguration.fromJson(data));
  }

  /**
   * Update the metadata of the achievement configuration with the given ID.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [achievementId] - The ID of the achievement used by this method.
   *
   * Completes with a [AchievementConfiguration].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementConfiguration> update(AchievementConfiguration request, core.String achievementId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (achievementId == null) {
      throw new core.ArgumentError("Parameter achievementId is required.");
    }

    _url = 'achievements/' + commons.Escaper.ecapeVariable('$achievementId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementConfiguration.fromJson(data));
  }

}


class ImageConfigurationsResourceApi {
  final commons.ApiRequester _requester;

  ImageConfigurationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Uploads an image for a resource with the given ID and image type.
   *
   * Request parameters:
   *
   * [resourceId] - The ID of the resource used by this method.
   *
   * [imageType] - Selects which image in a resource for this method.
   * Possible string values are:
   * - "ACHIEVEMENT_ICON" : The icon image for an achievement resource.
   * - "LEADERBOARD_ICON" : The icon image for a leaderboard resource.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [ImageConfiguration].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ImageConfiguration> upload(core.String resourceId, core.String imageType, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (resourceId == null) {
      throw new core.ArgumentError("Parameter resourceId is required.");
    }
    if (imageType == null) {
      throw new core.ArgumentError("Parameter imageType is required.");
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'images/' + commons.Escaper.ecapeVariable('$resourceId') + '/imageType/' + commons.Escaper.ecapeVariable('$imageType');
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/games/v1configuration/images/' + commons.Escaper.ecapeVariable('$resourceId') + '/imageType/' + commons.Escaper.ecapeVariable('$imageType');
    } else {
      _url = '/upload/games/v1configuration/images/' + commons.Escaper.ecapeVariable('$resourceId') + '/imageType/' + commons.Escaper.ecapeVariable('$imageType');
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ImageConfiguration.fromJson(data));
  }

}


class LeaderboardConfigurationsResourceApi {
  final commons.ApiRequester _requester;

  LeaderboardConfigurationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Delete the leaderboard configuration with the given ID.
   *
   * Request parameters:
   *
   * [leaderboardId] - The ID of the leaderboard.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String leaderboardId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (leaderboardId == null) {
      throw new core.ArgumentError("Parameter leaderboardId is required.");
    }

    _downloadOptions = null;

    _url = 'leaderboards/' + commons.Escaper.ecapeVariable('$leaderboardId');

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
   * Retrieves the metadata of the leaderboard configuration with the given ID.
   *
   * Request parameters:
   *
   * [leaderboardId] - The ID of the leaderboard.
   *
   * Completes with a [LeaderboardConfiguration].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LeaderboardConfiguration> get(core.String leaderboardId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (leaderboardId == null) {
      throw new core.ArgumentError("Parameter leaderboardId is required.");
    }

    _url = 'leaderboards/' + commons.Escaper.ecapeVariable('$leaderboardId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LeaderboardConfiguration.fromJson(data));
  }

  /**
   * Insert a new leaderboard configuration in this application.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [applicationId] - The application ID from the Google Play developer
   * console.
   *
   * Completes with a [LeaderboardConfiguration].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LeaderboardConfiguration> insert(LeaderboardConfiguration request, core.String applicationId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (applicationId == null) {
      throw new core.ArgumentError("Parameter applicationId is required.");
    }

    _url = 'applications/' + commons.Escaper.ecapeVariable('$applicationId') + '/leaderboards';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LeaderboardConfiguration.fromJson(data));
  }

  /**
   * Returns a list of the leaderboard configurations in this application.
   *
   * Request parameters:
   *
   * [applicationId] - The application ID from the Google Play developer
   * console.
   *
   * [maxResults] - The maximum number of resource configurations to return in
   * the response, used for paging. For any response, the actual number of
   * resources returned may be less than the specified maxResults.
   * Value must be between "1" and "200".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [LeaderboardConfigurationListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LeaderboardConfigurationListResponse> list(core.String applicationId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (applicationId == null) {
      throw new core.ArgumentError("Parameter applicationId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'applications/' + commons.Escaper.ecapeVariable('$applicationId') + '/leaderboards';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LeaderboardConfigurationListResponse.fromJson(data));
  }

  /**
   * Update the metadata of the leaderboard configuration with the given ID.
   * This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [leaderboardId] - The ID of the leaderboard.
   *
   * Completes with a [LeaderboardConfiguration].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LeaderboardConfiguration> patch(LeaderboardConfiguration request, core.String leaderboardId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (leaderboardId == null) {
      throw new core.ArgumentError("Parameter leaderboardId is required.");
    }

    _url = 'leaderboards/' + commons.Escaper.ecapeVariable('$leaderboardId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LeaderboardConfiguration.fromJson(data));
  }

  /**
   * Update the metadata of the leaderboard configuration with the given ID.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [leaderboardId] - The ID of the leaderboard.
   *
   * Completes with a [LeaderboardConfiguration].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LeaderboardConfiguration> update(LeaderboardConfiguration request, core.String leaderboardId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (leaderboardId == null) {
      throw new core.ArgumentError("Parameter leaderboardId is required.");
    }

    _url = 'leaderboards/' + commons.Escaper.ecapeVariable('$leaderboardId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LeaderboardConfiguration.fromJson(data));
  }

}



/** This is a JSON template for an achievement configuration resource. */
class AchievementConfiguration {
  /**
   * The type of the achievement.
   * Possible values are:
   * - "STANDARD" - Achievement is either locked or unlocked.
   * - "INCREMENTAL" - Achievement is incremental.
   */
  core.String achievementType;
  /** The draft data of the achievement. */
  AchievementConfigurationDetail draft;
  /** The ID of the achievement. */
  core.String id;
  /**
   * The initial state of the achievement.
   * Possible values are:
   * - "HIDDEN" - Achievement is hidden.
   * - "REVEALED" - Achievement is revealed.
   * - "UNLOCKED" - Achievement is unlocked.
   */
  core.String initialState;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesConfiguration#achievementConfiguration.
   */
  core.String kind;
  /** The read-only published data of the achievement. */
  AchievementConfigurationDetail published;
  /** Steps to unlock. Only applicable to incremental achievements. */
  core.int stepsToUnlock;
  /** The token for this resource. */
  core.String token;

  AchievementConfiguration();

  AchievementConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("achievementType")) {
      achievementType = _json["achievementType"];
    }
    if (_json.containsKey("draft")) {
      draft = new AchievementConfigurationDetail.fromJson(_json["draft"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("initialState")) {
      initialState = _json["initialState"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("published")) {
      published = new AchievementConfigurationDetail.fromJson(_json["published"]);
    }
    if (_json.containsKey("stepsToUnlock")) {
      stepsToUnlock = _json["stepsToUnlock"];
    }
    if (_json.containsKey("token")) {
      token = _json["token"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (achievementType != null) {
      _json["achievementType"] = achievementType;
    }
    if (draft != null) {
      _json["draft"] = (draft).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (initialState != null) {
      _json["initialState"] = initialState;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (published != null) {
      _json["published"] = (published).toJson();
    }
    if (stepsToUnlock != null) {
      _json["stepsToUnlock"] = stepsToUnlock;
    }
    if (token != null) {
      _json["token"] = token;
    }
    return _json;
  }
}

/** This is a JSON template for an achievement configuration detail. */
class AchievementConfigurationDetail {
  /** Localized strings for the achievement description. */
  LocalizedStringBundle description;
  /** The icon url of this achievement. Writes to this field are ignored. */
  core.String iconUrl;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesConfiguration#achievementConfigurationDetail.
   */
  core.String kind;
  /** Localized strings for the achievement name. */
  LocalizedStringBundle name;
  /** Point value for the achievement. */
  core.int pointValue;
  /** The sort rank of this achievement. Writes to this field are ignored. */
  core.int sortRank;

  AchievementConfigurationDetail();

  AchievementConfigurationDetail.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = new LocalizedStringBundle.fromJson(_json["description"]);
    }
    if (_json.containsKey("iconUrl")) {
      iconUrl = _json["iconUrl"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = new LocalizedStringBundle.fromJson(_json["name"]);
    }
    if (_json.containsKey("pointValue")) {
      pointValue = _json["pointValue"];
    }
    if (_json.containsKey("sortRank")) {
      sortRank = _json["sortRank"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = (description).toJson();
    }
    if (iconUrl != null) {
      _json["iconUrl"] = iconUrl;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = (name).toJson();
    }
    if (pointValue != null) {
      _json["pointValue"] = pointValue;
    }
    if (sortRank != null) {
      _json["sortRank"] = sortRank;
    }
    return _json;
  }
}

/** This is a JSON template for a ListConfigurations response. */
class AchievementConfigurationListResponse {
  /** The achievement configurations. */
  core.List<AchievementConfiguration> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#achievementConfigurationListResponse.
   */
  core.String kind;
  /** The pagination token for the next page of results. */
  core.String nextPageToken;

  AchievementConfigurationListResponse();

  AchievementConfigurationListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new AchievementConfiguration.fromJson(value)).toList();
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

/** This is a JSON template for a number affix resource. */
class GamesNumberAffixConfiguration {
  /**
   * When the language requires special treatment of "small" numbers (as with 2,
   * 3, and 4 in Czech; or numbers ending 2, 3, or 4 but not 12, 13, or 14 in
   * Polish).
   */
  LocalizedStringBundle few;
  /**
   * When the language requires special treatment of "large" numbers (as with
   * numbers ending 11-99 in Maltese).
   */
  LocalizedStringBundle many;
  /**
   * When the language requires special treatment of numbers like one (as with
   * the number 1 in English and most other languages; in Russian, any number
   * ending in 1 but not ending in 11 is in this class).
   */
  LocalizedStringBundle one;
  /**
   * When the language does not require special treatment of the given quantity
   * (as with all numbers in Chinese, or 42 in English).
   */
  LocalizedStringBundle other;
  /**
   * When the language requires special treatment of numbers like two (as with 2
   * in Welsh, or 102 in Slovenian).
   */
  LocalizedStringBundle two;
  /**
   * When the language requires special treatment of the number 0 (as in
   * Arabic).
   */
  LocalizedStringBundle zero;

  GamesNumberAffixConfiguration();

  GamesNumberAffixConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("few")) {
      few = new LocalizedStringBundle.fromJson(_json["few"]);
    }
    if (_json.containsKey("many")) {
      many = new LocalizedStringBundle.fromJson(_json["many"]);
    }
    if (_json.containsKey("one")) {
      one = new LocalizedStringBundle.fromJson(_json["one"]);
    }
    if (_json.containsKey("other")) {
      other = new LocalizedStringBundle.fromJson(_json["other"]);
    }
    if (_json.containsKey("two")) {
      two = new LocalizedStringBundle.fromJson(_json["two"]);
    }
    if (_json.containsKey("zero")) {
      zero = new LocalizedStringBundle.fromJson(_json["zero"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (few != null) {
      _json["few"] = (few).toJson();
    }
    if (many != null) {
      _json["many"] = (many).toJson();
    }
    if (one != null) {
      _json["one"] = (one).toJson();
    }
    if (other != null) {
      _json["other"] = (other).toJson();
    }
    if (two != null) {
      _json["two"] = (two).toJson();
    }
    if (zero != null) {
      _json["zero"] = (zero).toJson();
    }
    return _json;
  }
}

/** This is a JSON template for a number format resource. */
class GamesNumberFormatConfiguration {
  /** The curreny code string. Only used for CURRENCY format type. */
  core.String currencyCode;
  /**
   * The number of decimal places for number. Only used for NUMERIC format type.
   */
  core.int numDecimalPlaces;
  /**
   * The formatting for the number.
   * Possible values are:
   * - "NUMERIC" - Numbers are formatted to have no digits or a fixed number of
   * digits after the decimal point according to locale. An optional custom unit
   * can be added.
   * - "TIME_DURATION" - Numbers are formatted to hours, minutes and seconds.
   * - "CURRENCY" - Numbers are formatted to currency according to locale.
   */
  core.String numberFormatType;
  /**
   * An optional suffix for the NUMERIC format type. These strings follow the
   * same  plural rules as all Android string resources.
   */
  GamesNumberAffixConfiguration suffix;

  GamesNumberFormatConfiguration();

  GamesNumberFormatConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("currencyCode")) {
      currencyCode = _json["currencyCode"];
    }
    if (_json.containsKey("numDecimalPlaces")) {
      numDecimalPlaces = _json["numDecimalPlaces"];
    }
    if (_json.containsKey("numberFormatType")) {
      numberFormatType = _json["numberFormatType"];
    }
    if (_json.containsKey("suffix")) {
      suffix = new GamesNumberAffixConfiguration.fromJson(_json["suffix"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currencyCode != null) {
      _json["currencyCode"] = currencyCode;
    }
    if (numDecimalPlaces != null) {
      _json["numDecimalPlaces"] = numDecimalPlaces;
    }
    if (numberFormatType != null) {
      _json["numberFormatType"] = numberFormatType;
    }
    if (suffix != null) {
      _json["suffix"] = (suffix).toJson();
    }
    return _json;
  }
}

/** This is a JSON template for an image configuration resource. */
class ImageConfiguration {
  /** The image type for the image. */
  core.String imageType;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesConfiguration#imageConfiguration.
   */
  core.String kind;
  /** The resource ID of resource which the image belongs to. */
  core.String resourceId;
  /** The url for this image. */
  core.String url;

  ImageConfiguration();

  ImageConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("imageType")) {
      imageType = _json["imageType"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("resourceId")) {
      resourceId = _json["resourceId"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (imageType != null) {
      _json["imageType"] = imageType;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (resourceId != null) {
      _json["resourceId"] = resourceId;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** This is a JSON template for an leaderboard configuration resource. */
class LeaderboardConfiguration {
  /** The draft data of the leaderboard. */
  LeaderboardConfigurationDetail draft;
  /** The ID of the leaderboard. */
  core.String id;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesConfiguration#leaderboardConfiguration.
   */
  core.String kind;
  /** The read-only published data of the leaderboard. */
  LeaderboardConfigurationDetail published;
  /** Maximum score that can be posted to this leaderboard. */
  core.String scoreMax;
  /** Minimum score that can be posted to this leaderboard. */
  core.String scoreMin;
  /**
   * The type of the leaderboard.
   * Possible values are:
   * - "LARGER_IS_BETTER" - Larger scores posted are ranked higher.
   * - "SMALLER_IS_BETTER" - Smaller scores posted are ranked higher.
   */
  core.String scoreOrder;
  /** The token for this resource. */
  core.String token;

  LeaderboardConfiguration();

  LeaderboardConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("draft")) {
      draft = new LeaderboardConfigurationDetail.fromJson(_json["draft"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("published")) {
      published = new LeaderboardConfigurationDetail.fromJson(_json["published"]);
    }
    if (_json.containsKey("scoreMax")) {
      scoreMax = _json["scoreMax"];
    }
    if (_json.containsKey("scoreMin")) {
      scoreMin = _json["scoreMin"];
    }
    if (_json.containsKey("scoreOrder")) {
      scoreOrder = _json["scoreOrder"];
    }
    if (_json.containsKey("token")) {
      token = _json["token"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (draft != null) {
      _json["draft"] = (draft).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (published != null) {
      _json["published"] = (published).toJson();
    }
    if (scoreMax != null) {
      _json["scoreMax"] = scoreMax;
    }
    if (scoreMin != null) {
      _json["scoreMin"] = scoreMin;
    }
    if (scoreOrder != null) {
      _json["scoreOrder"] = scoreOrder;
    }
    if (token != null) {
      _json["token"] = token;
    }
    return _json;
  }
}

/** This is a JSON template for a leaderboard configuration detail. */
class LeaderboardConfigurationDetail {
  /** The icon url of this leaderboard. Writes to this field are ignored. */
  core.String iconUrl;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesConfiguration#leaderboardConfigurationDetail.
   */
  core.String kind;
  /** Localized strings for the leaderboard name. */
  LocalizedStringBundle name;
  /** The score formatting for the leaderboard. */
  GamesNumberFormatConfiguration scoreFormat;
  /** The sort rank of this leaderboard. Writes to this field are ignored. */
  core.int sortRank;

  LeaderboardConfigurationDetail();

  LeaderboardConfigurationDetail.fromJson(core.Map _json) {
    if (_json.containsKey("iconUrl")) {
      iconUrl = _json["iconUrl"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = new LocalizedStringBundle.fromJson(_json["name"]);
    }
    if (_json.containsKey("scoreFormat")) {
      scoreFormat = new GamesNumberFormatConfiguration.fromJson(_json["scoreFormat"]);
    }
    if (_json.containsKey("sortRank")) {
      sortRank = _json["sortRank"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (iconUrl != null) {
      _json["iconUrl"] = iconUrl;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = (name).toJson();
    }
    if (scoreFormat != null) {
      _json["scoreFormat"] = (scoreFormat).toJson();
    }
    if (sortRank != null) {
      _json["sortRank"] = sortRank;
    }
    return _json;
  }
}

/** This is a JSON template for a ListConfigurations response. */
class LeaderboardConfigurationListResponse {
  /** The leaderboard configurations. */
  core.List<LeaderboardConfiguration> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#leaderboardConfigurationListResponse.
   */
  core.String kind;
  /** The pagination token for the next page of results. */
  core.String nextPageToken;

  LeaderboardConfigurationListResponse();

  LeaderboardConfigurationListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new LeaderboardConfiguration.fromJson(value)).toList();
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

/** This is a JSON template for a localized string resource. */
class LocalizedString {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesConfiguration#localizedString.
   */
  core.String kind;
  /** The locale string. */
  core.String locale;
  /** The string value. */
  core.String value;

  LocalizedString();

  LocalizedString.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("locale")) {
      locale = _json["locale"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (locale != null) {
      _json["locale"] = locale;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** This is a JSON template for a localized string bundle resource. */
class LocalizedStringBundle {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesConfiguration#localizedStringBundle.
   */
  core.String kind;
  /** The locale strings. */
  core.List<LocalizedString> translations;

  LocalizedStringBundle();

  LocalizedStringBundle.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("translations")) {
      translations = _json["translations"].map((value) => new LocalizedString.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (translations != null) {
      _json["translations"] = translations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
