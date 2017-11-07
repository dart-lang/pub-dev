// This is a generated file (see the discoveryapis_generator project).

library googleapis.games.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client games/v1';

/** The API for Google Play Game Services. */
class GamesApi {
  /** View and manage its own configuration data in your Google Drive */
  static const DriveAppdataScope = "https://www.googleapis.com/auth/drive.appdata";

  /**
   * Share your Google+ profile information and view and manage your game
   * activity
   */
  static const GamesScope = "https://www.googleapis.com/auth/games";

  /** Know the list of people in your circles, your age range, and language */
  static const PlusLoginScope = "https://www.googleapis.com/auth/plus.login";


  final commons.ApiRequester _requester;

  AchievementDefinitionsResourceApi get achievementDefinitions => new AchievementDefinitionsResourceApi(_requester);
  AchievementsResourceApi get achievements => new AchievementsResourceApi(_requester);
  ApplicationsResourceApi get applications => new ApplicationsResourceApi(_requester);
  EventsResourceApi get events => new EventsResourceApi(_requester);
  LeaderboardsResourceApi get leaderboards => new LeaderboardsResourceApi(_requester);
  MetagameResourceApi get metagame => new MetagameResourceApi(_requester);
  PlayersResourceApi get players => new PlayersResourceApi(_requester);
  PushtokensResourceApi get pushtokens => new PushtokensResourceApi(_requester);
  QuestMilestonesResourceApi get questMilestones => new QuestMilestonesResourceApi(_requester);
  QuestsResourceApi get quests => new QuestsResourceApi(_requester);
  RevisionsResourceApi get revisions => new RevisionsResourceApi(_requester);
  RoomsResourceApi get rooms => new RoomsResourceApi(_requester);
  ScoresResourceApi get scores => new ScoresResourceApi(_requester);
  SnapshotsResourceApi get snapshots => new SnapshotsResourceApi(_requester);
  TurnBasedMatchesResourceApi get turnBasedMatches => new TurnBasedMatchesResourceApi(_requester);

  GamesApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "games/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AchievementDefinitionsResourceApi {
  final commons.ApiRequester _requester;

  AchievementDefinitionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists all the achievement definitions for your application.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of achievement resources to return in the
   * response, used for paging. For any response, the actual number of
   * achievement resources returned may be less than the specified maxResults.
   * Value must be between "1" and "200".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [AchievementDefinitionsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementDefinitionsListResponse> list({core.String consistencyToken, core.String language, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'achievements';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementDefinitionsListResponse.fromJson(data));
  }

}


class AchievementsResourceApi {
  final commons.ApiRequester _requester;

  AchievementsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Increments the steps of the achievement with the given ID for the currently
   * authenticated player.
   *
   * Request parameters:
   *
   * [achievementId] - The ID of the achievement used by this method.
   *
   * [stepsToIncrement] - The number of steps to increment.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [requestId] - A randomly generated numeric ID for each request specified by
   * the caller. This number is used at the server to ensure that the request is
   * handled correctly across retries.
   *
   * Completes with a [AchievementIncrementResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementIncrementResponse> increment(core.String achievementId, core.int stepsToIncrement, {core.String consistencyToken, core.String requestId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (achievementId == null) {
      throw new core.ArgumentError("Parameter achievementId is required.");
    }
    if (stepsToIncrement == null) {
      throw new core.ArgumentError("Parameter stepsToIncrement is required.");
    }
    _queryParams["stepsToIncrement"] = ["${stepsToIncrement}"];
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (requestId != null) {
      _queryParams["requestId"] = [requestId];
    }

    _url = 'achievements/' + commons.Escaper.ecapeVariable('$achievementId') + '/increment';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementIncrementResponse.fromJson(data));
  }

  /**
   * Lists the progress for all your application's achievements for the
   * currently authenticated player.
   *
   * Request parameters:
   *
   * [playerId] - A player ID. A value of me may be used in place of the
   * authenticated player's ID.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of achievement resources to return in the
   * response, used for paging. For any response, the actual number of
   * achievement resources returned may be less than the specified maxResults.
   * Value must be between "1" and "200".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * [state] - Tells the server to return only achievements with the specified
   * state. If this parameter isn't specified, all achievements are returned.
   * Possible string values are:
   * - "ALL" : List all achievements. This is the default.
   * - "HIDDEN" : List only hidden achievements.
   * - "REVEALED" : List only revealed achievements.
   * - "UNLOCKED" : List only unlocked achievements.
   *
   * Completes with a [PlayerAchievementListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlayerAchievementListResponse> list(core.String playerId, {core.String consistencyToken, core.String language, core.int maxResults, core.String pageToken, core.String state}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (playerId == null) {
      throw new core.ArgumentError("Parameter playerId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (state != null) {
      _queryParams["state"] = [state];
    }

    _url = 'players/' + commons.Escaper.ecapeVariable('$playerId') + '/achievements';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlayerAchievementListResponse.fromJson(data));
  }

  /**
   * Sets the state of the achievement with the given ID to REVEALED for the
   * currently authenticated player.
   *
   * Request parameters:
   *
   * [achievementId] - The ID of the achievement used by this method.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [AchievementRevealResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementRevealResponse> reveal(core.String achievementId, {core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (achievementId == null) {
      throw new core.ArgumentError("Parameter achievementId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _url = 'achievements/' + commons.Escaper.ecapeVariable('$achievementId') + '/reveal';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementRevealResponse.fromJson(data));
  }

  /**
   * Sets the steps for the currently authenticated player towards unlocking an
   * achievement. If the steps parameter is less than the current number of
   * steps that the player already gained for the achievement, the achievement
   * is not modified.
   *
   * Request parameters:
   *
   * [achievementId] - The ID of the achievement used by this method.
   *
   * [steps] - The minimum value to set the steps to.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [AchievementSetStepsAtLeastResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementSetStepsAtLeastResponse> setStepsAtLeast(core.String achievementId, core.int steps, {core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (achievementId == null) {
      throw new core.ArgumentError("Parameter achievementId is required.");
    }
    if (steps == null) {
      throw new core.ArgumentError("Parameter steps is required.");
    }
    _queryParams["steps"] = ["${steps}"];
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _url = 'achievements/' + commons.Escaper.ecapeVariable('$achievementId') + '/setStepsAtLeast';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementSetStepsAtLeastResponse.fromJson(data));
  }

  /**
   * Unlocks this achievement for the currently authenticated player.
   *
   * Request parameters:
   *
   * [achievementId] - The ID of the achievement used by this method.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [AchievementUnlockResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementUnlockResponse> unlock(core.String achievementId, {core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (achievementId == null) {
      throw new core.ArgumentError("Parameter achievementId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _url = 'achievements/' + commons.Escaper.ecapeVariable('$achievementId') + '/unlock';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementUnlockResponse.fromJson(data));
  }

  /**
   * Updates multiple achievements for the currently authenticated player.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [AchievementUpdateMultipleResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementUpdateMultipleResponse> updateMultiple(AchievementUpdateMultipleRequest request, {core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _url = 'achievements/updateMultiple';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementUpdateMultipleResponse.fromJson(data));
  }

}


class ApplicationsResourceApi {
  final commons.ApiRequester _requester;

  ApplicationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves the metadata of the application with the given ID. If the
   * requested application is not available for the specified platformType, the
   * returned response will not include any instance data.
   *
   * Request parameters:
   *
   * [applicationId] - The application ID from the Google Play developer
   * console.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [platformType] - Restrict application details returned to the specific
   * platform.
   * Possible string values are:
   * - "ANDROID" : Retrieve applications that can be played on Android.
   * - "IOS" : Retrieve applications that can be played on iOS.
   * - "WEB_APP" : Retrieve applications that can be played on desktop web.
   *
   * Completes with a [Application].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Application> get(core.String applicationId, {core.String consistencyToken, core.String language, core.String platformType}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (applicationId == null) {
      throw new core.ArgumentError("Parameter applicationId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (platformType != null) {
      _queryParams["platformType"] = [platformType];
    }

    _url = 'applications/' + commons.Escaper.ecapeVariable('$applicationId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Application.fromJson(data));
  }

  /**
   * Indicate that the the currently authenticated user is playing your
   * application.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future played({core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _downloadOptions = null;

    _url = 'applications/played';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Verifies the auth token provided with this request is for the application
   * with the specified ID, and returns the ID of the player it was granted for.
   *
   * Request parameters:
   *
   * [applicationId] - The application ID from the Google Play developer
   * console.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [ApplicationVerifyResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ApplicationVerifyResponse> verify(core.String applicationId, {core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (applicationId == null) {
      throw new core.ArgumentError("Parameter applicationId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _url = 'applications/' + commons.Escaper.ecapeVariable('$applicationId') + '/verify';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ApplicationVerifyResponse.fromJson(data));
  }

}


class EventsResourceApi {
  final commons.ApiRequester _requester;

  EventsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a list showing the current progress on events in this application
   * for the currently authenticated user.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of events to return in the response, used
   * for paging. For any response, the actual number of events to return may be
   * less than the specified maxResults.
   * Value must be between "1" and "100".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [PlayerEventListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlayerEventListResponse> listByPlayer({core.String consistencyToken, core.String language, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'events';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlayerEventListResponse.fromJson(data));
  }

  /**
   * Returns a list of the event definitions in this application.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of event definitions to return in the
   * response, used for paging. For any response, the actual number of event
   * definitions to return may be less than the specified maxResults.
   * Value must be between "1" and "100".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [EventDefinitionListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EventDefinitionListResponse> listDefinitions({core.String consistencyToken, core.String language, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'eventDefinitions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EventDefinitionListResponse.fromJson(data));
  }

  /**
   * Records a batch of changes to the number of times events have occurred for
   * the currently authenticated user of this application.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [EventUpdateResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EventUpdateResponse> record(EventRecordRequest request, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'events';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EventUpdateResponse.fromJson(data));
  }

}


class LeaderboardsResourceApi {
  final commons.ApiRequester _requester;

  LeaderboardsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves the metadata of the leaderboard with the given ID.
   *
   * Request parameters:
   *
   * [leaderboardId] - The ID of the leaderboard.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [Leaderboard].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Leaderboard> get(core.String leaderboardId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (leaderboardId == null) {
      throw new core.ArgumentError("Parameter leaderboardId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'leaderboards/' + commons.Escaper.ecapeVariable('$leaderboardId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Leaderboard.fromJson(data));
  }

  /**
   * Lists all the leaderboard metadata for your application.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of leaderboards to return in the
   * response. For any response, the actual number of leaderboards returned may
   * be less than the specified maxResults.
   * Value must be between "1" and "200".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [LeaderboardListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LeaderboardListResponse> list({core.String consistencyToken, core.String language, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'leaderboards';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LeaderboardListResponse.fromJson(data));
  }

}


class MetagameResourceApi {
  final commons.ApiRequester _requester;

  MetagameResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Return the metagame configuration data for the calling application.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [MetagameConfig].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<MetagameConfig> getMetagameConfig({core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _url = 'metagameConfig';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new MetagameConfig.fromJson(data));
  }

  /**
   * List play data aggregated per category for the player corresponding to
   * playerId.
   *
   * Request parameters:
   *
   * [playerId] - A player ID. A value of me may be used in place of the
   * authenticated player's ID.
   *
   * [collection] - The collection of categories for which data will be
   * returned.
   * Possible string values are:
   * - "all" : Retrieve data for all categories. This is the default.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of category resources to return in the
   * response, used for paging. For any response, the actual number of category
   * resources returned may be less than the specified maxResults.
   * Value must be between "1" and "100".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [CategoryListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CategoryListResponse> listCategoriesByPlayer(core.String playerId, core.String collection, {core.String consistencyToken, core.String language, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (playerId == null) {
      throw new core.ArgumentError("Parameter playerId is required.");
    }
    if (collection == null) {
      throw new core.ArgumentError("Parameter collection is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'players/' + commons.Escaper.ecapeVariable('$playerId') + '/categories/' + commons.Escaper.ecapeVariable('$collection');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CategoryListResponse.fromJson(data));
  }

}


class PlayersResourceApi {
  final commons.ApiRequester _requester;

  PlayersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves the Player resource with the given ID. To retrieve the player for
   * the currently authenticated user, set playerId to me.
   *
   * Request parameters:
   *
   * [playerId] - A player ID. A value of me may be used in place of the
   * authenticated player's ID.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [Player].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Player> get(core.String playerId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (playerId == null) {
      throw new core.ArgumentError("Parameter playerId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'players/' + commons.Escaper.ecapeVariable('$playerId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Player.fromJson(data));
  }

  /**
   * Get the collection of players for the currently authenticated user.
   *
   * Request parameters:
   *
   * [collection] - Collection of players being retrieved
   * Possible string values are:
   * - "connected" : Retrieve a list of players that are also playing this game
   * in reverse chronological order.
   * - "playedWith" : (DEPRECATED: please use played_with!) Retrieve a list of
   * players you have played a multiplayer game (realtime or turn-based) with
   * recently.
   * - "played_with" : Retrieve a list of players you have played a multiplayer
   * game (realtime or turn-based) with recently.
   * - "visible" : Retrieve a list of players in the user's social graph that
   * are visible to this game.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of player resources to return in the
   * response, used for paging. For any response, the actual number of player
   * resources returned may be less than the specified maxResults.
   * Value must be between "1" and "50".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [PlayerListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlayerListResponse> list(core.String collection, {core.String consistencyToken, core.String language, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (collection == null) {
      throw new core.ArgumentError("Parameter collection is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'players/me/players/' + commons.Escaper.ecapeVariable('$collection');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlayerListResponse.fromJson(data));
  }

}


class PushtokensResourceApi {
  final commons.ApiRequester _requester;

  PushtokensResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Removes a push token for the current user and application. Removing a
   * non-existent push token will report success.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future remove(PushTokenId request, {core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _downloadOptions = null;

    _url = 'pushtokens/remove';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Registers a push token for the current user and application.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future update(PushToken request, {core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _downloadOptions = null;

    _url = 'pushtokens';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

}


class QuestMilestonesResourceApi {
  final commons.ApiRequester _requester;

  QuestMilestonesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Report that a reward for the milestone corresponding to milestoneId for the
   * quest corresponding to questId has been claimed by the currently authorized
   * user.
   *
   * Request parameters:
   *
   * [questId] - The ID of the quest.
   *
   * [milestoneId] - The ID of the milestone.
   *
   * [requestId] - A numeric ID to ensure that the request is handled correctly
   * across retries. Your client application must generate this ID randomly.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future claim(core.String questId, core.String milestoneId, core.String requestId, {core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (questId == null) {
      throw new core.ArgumentError("Parameter questId is required.");
    }
    if (milestoneId == null) {
      throw new core.ArgumentError("Parameter milestoneId is required.");
    }
    if (requestId == null) {
      throw new core.ArgumentError("Parameter requestId is required.");
    }
    _queryParams["requestId"] = [requestId];
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _downloadOptions = null;

    _url = 'quests/' + commons.Escaper.ecapeVariable('$questId') + '/milestones/' + commons.Escaper.ecapeVariable('$milestoneId') + '/claim';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

}


class QuestsResourceApi {
  final commons.ApiRequester _requester;

  QuestsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Indicates that the currently authorized user will participate in the quest.
   *
   * Request parameters:
   *
   * [questId] - The ID of the quest.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [Quest].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Quest> accept(core.String questId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (questId == null) {
      throw new core.ArgumentError("Parameter questId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'quests/' + commons.Escaper.ecapeVariable('$questId') + '/accept';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Quest.fromJson(data));
  }

  /**
   * Get a list of quests for your application and the currently authenticated
   * player.
   *
   * Request parameters:
   *
   * [playerId] - A player ID. A value of me may be used in place of the
   * authenticated player's ID.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of quest resources to return in the
   * response, used for paging. For any response, the actual number of quest
   * resources returned may be less than the specified maxResults. Acceptable
   * values are 1 to 50, inclusive. (Default: 50).
   * Value must be between "1" and "50".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [QuestListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<QuestListResponse> list(core.String playerId, {core.String consistencyToken, core.String language, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (playerId == null) {
      throw new core.ArgumentError("Parameter playerId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'players/' + commons.Escaper.ecapeVariable('$playerId') + '/quests';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new QuestListResponse.fromJson(data));
  }

}


class RevisionsResourceApi {
  final commons.ApiRequester _requester;

  RevisionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Checks whether the games client is out of date.
   *
   * Request parameters:
   *
   * [clientRevision] - The revision of the client SDK used by your application.
   * Format:
   * [PLATFORM_TYPE]:[VERSION_NUMBER]. Possible values of PLATFORM_TYPE are:
   *
   * - "ANDROID" - Client is running the Android SDK.
   * - "IOS" - Client is running the iOS SDK.
   * - "WEB_APP" - Client is running as a Web App.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [RevisionCheckResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RevisionCheckResponse> check(core.String clientRevision, {core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (clientRevision == null) {
      throw new core.ArgumentError("Parameter clientRevision is required.");
    }
    _queryParams["clientRevision"] = [clientRevision];
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _url = 'revisions/check';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RevisionCheckResponse.fromJson(data));
  }

}


class RoomsResourceApi {
  final commons.ApiRequester _requester;

  RoomsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Create a room. For internal use by the Games SDK only. Calling this method
   * directly is unsupported.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [Room].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Room> create(RoomCreateRequest request, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'rooms/create';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Room.fromJson(data));
  }

  /**
   * Decline an invitation to join a room. For internal use by the Games SDK
   * only. Calling this method directly is unsupported.
   *
   * Request parameters:
   *
   * [roomId] - The ID of the room.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [Room].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Room> decline(core.String roomId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (roomId == null) {
      throw new core.ArgumentError("Parameter roomId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'rooms/' + commons.Escaper.ecapeVariable('$roomId') + '/decline';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Room.fromJson(data));
  }

  /**
   * Dismiss an invitation to join a room. For internal use by the Games SDK
   * only. Calling this method directly is unsupported.
   *
   * Request parameters:
   *
   * [roomId] - The ID of the room.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future dismiss(core.String roomId, {core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (roomId == null) {
      throw new core.ArgumentError("Parameter roomId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _downloadOptions = null;

    _url = 'rooms/' + commons.Escaper.ecapeVariable('$roomId') + '/dismiss';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Get the data for a room.
   *
   * Request parameters:
   *
   * [roomId] - The ID of the room.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [Room].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Room> get(core.String roomId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (roomId == null) {
      throw new core.ArgumentError("Parameter roomId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'rooms/' + commons.Escaper.ecapeVariable('$roomId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Room.fromJson(data));
  }

  /**
   * Join a room. For internal use by the Games SDK only. Calling this method
   * directly is unsupported.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [roomId] - The ID of the room.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [Room].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Room> join(RoomJoinRequest request, core.String roomId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (roomId == null) {
      throw new core.ArgumentError("Parameter roomId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'rooms/' + commons.Escaper.ecapeVariable('$roomId') + '/join';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Room.fromJson(data));
  }

  /**
   * Leave a room. For internal use by the Games SDK only. Calling this method
   * directly is unsupported.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [roomId] - The ID of the room.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [Room].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Room> leave(RoomLeaveRequest request, core.String roomId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (roomId == null) {
      throw new core.ArgumentError("Parameter roomId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'rooms/' + commons.Escaper.ecapeVariable('$roomId') + '/leave';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Room.fromJson(data));
  }

  /**
   * Returns invitations to join rooms.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of rooms to return in the response, used
   * for paging. For any response, the actual number of rooms to return may be
   * less than the specified maxResults.
   * Value must be between "1" and "500".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [RoomList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RoomList> list({core.String consistencyToken, core.String language, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'rooms';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RoomList.fromJson(data));
  }

  /**
   * Updates sent by a client reporting the status of peers in a room. For
   * internal use by the Games SDK only. Calling this method directly is
   * unsupported.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [roomId] - The ID of the room.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [RoomStatus].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RoomStatus> reportStatus(RoomP2PStatuses request, core.String roomId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (roomId == null) {
      throw new core.ArgumentError("Parameter roomId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'rooms/' + commons.Escaper.ecapeVariable('$roomId') + '/reportstatus';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RoomStatus.fromJson(data));
  }

}


class ScoresResourceApi {
  final commons.ApiRequester _requester;

  ScoresResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get high scores, and optionally ranks, in leaderboards for the currently
   * authenticated player. For a specific time span, leaderboardId can be set to
   * ALL to retrieve data for all leaderboards in a given time span.
   * NOTE: You cannot ask for 'ALL' leaderboards and 'ALL' timeSpans in the same
   * request; only one parameter may be set to 'ALL'.
   *
   * Request parameters:
   *
   * [playerId] - A player ID. A value of me may be used in place of the
   * authenticated player's ID.
   *
   * [leaderboardId] - The ID of the leaderboard. Can be set to 'ALL' to
   * retrieve data for all leaderboards for this application.
   *
   * [timeSpan] - The time span for the scores and ranks you're requesting.
   * Possible string values are:
   * - "ALL" : Get the high scores for all time spans. If this is used,
   * maxResults values will be ignored.
   * - "ALL_TIME" : Get the all time high score.
   * - "DAILY" : List the top scores for the current day.
   * - "WEEKLY" : List the top scores for the current week.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [includeRankType] - The types of ranks to return. If the parameter is
   * omitted, no ranks will be returned.
   * Possible string values are:
   * - "ALL" : Retrieve public and social ranks.
   * - "PUBLIC" : Retrieve public ranks, if the player is sharing their gameplay
   * activity publicly.
   * - "SOCIAL" : Retrieve the social rank.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of leaderboard scores to return in the
   * response. For any response, the actual number of leaderboard scores
   * returned may be less than the specified maxResults.
   * Value must be between "1" and "30".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [PlayerLeaderboardScoreListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlayerLeaderboardScoreListResponse> get(core.String playerId, core.String leaderboardId, core.String timeSpan, {core.String consistencyToken, core.String includeRankType, core.String language, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (playerId == null) {
      throw new core.ArgumentError("Parameter playerId is required.");
    }
    if (leaderboardId == null) {
      throw new core.ArgumentError("Parameter leaderboardId is required.");
    }
    if (timeSpan == null) {
      throw new core.ArgumentError("Parameter timeSpan is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (includeRankType != null) {
      _queryParams["includeRankType"] = [includeRankType];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'players/' + commons.Escaper.ecapeVariable('$playerId') + '/leaderboards/' + commons.Escaper.ecapeVariable('$leaderboardId') + '/scores/' + commons.Escaper.ecapeVariable('$timeSpan');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlayerLeaderboardScoreListResponse.fromJson(data));
  }

  /**
   * Lists the scores in a leaderboard, starting from the top.
   *
   * Request parameters:
   *
   * [leaderboardId] - The ID of the leaderboard.
   *
   * [collection] - The collection of scores you're requesting.
   * Possible string values are:
   * - "PUBLIC" : List all scores in the public leaderboard.
   * - "SOCIAL" : List only social scores.
   * - "SOCIAL_1P" : List only social scores, not respecting the fACL.
   *
   * [timeSpan] - The time span for the scores and ranks you're requesting.
   * Possible string values are:
   * - "ALL_TIME" : List the all-time top scores.
   * - "DAILY" : List the top scores for the current day.
   * - "WEEKLY" : List the top scores for the current week.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of leaderboard scores to return in the
   * response. For any response, the actual number of leaderboard scores
   * returned may be less than the specified maxResults.
   * Value must be between "1" and "30".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [LeaderboardScores].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LeaderboardScores> list(core.String leaderboardId, core.String collection, core.String timeSpan, {core.String consistencyToken, core.String language, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (leaderboardId == null) {
      throw new core.ArgumentError("Parameter leaderboardId is required.");
    }
    if (collection == null) {
      throw new core.ArgumentError("Parameter collection is required.");
    }
    if (timeSpan == null) {
      throw new core.ArgumentError("Parameter timeSpan is required.");
    }
    _queryParams["timeSpan"] = [timeSpan];
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'leaderboards/' + commons.Escaper.ecapeVariable('$leaderboardId') + '/scores/' + commons.Escaper.ecapeVariable('$collection');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LeaderboardScores.fromJson(data));
  }

  /**
   * Lists the scores in a leaderboard around (and including) a player's score.
   *
   * Request parameters:
   *
   * [leaderboardId] - The ID of the leaderboard.
   *
   * [collection] - The collection of scores you're requesting.
   * Possible string values are:
   * - "PUBLIC" : List all scores in the public leaderboard.
   * - "SOCIAL" : List only social scores.
   * - "SOCIAL_1P" : List only social scores, not respecting the fACL.
   *
   * [timeSpan] - The time span for the scores and ranks you're requesting.
   * Possible string values are:
   * - "ALL_TIME" : List the all-time top scores.
   * - "DAILY" : List the top scores for the current day.
   * - "WEEKLY" : List the top scores for the current week.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of leaderboard scores to return in the
   * response. For any response, the actual number of leaderboard scores
   * returned may be less than the specified maxResults.
   * Value must be between "1" and "30".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * [resultsAbove] - The preferred number of scores to return above the
   * player's score. More scores may be returned if the player is at the bottom
   * of the leaderboard; fewer may be returned if the player is at the top. Must
   * be less than or equal to maxResults.
   *
   * [returnTopIfAbsent] - True if the top scores should be returned when the
   * player is not in the leaderboard. Defaults to true.
   *
   * Completes with a [LeaderboardScores].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LeaderboardScores> listWindow(core.String leaderboardId, core.String collection, core.String timeSpan, {core.String consistencyToken, core.String language, core.int maxResults, core.String pageToken, core.int resultsAbove, core.bool returnTopIfAbsent}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (leaderboardId == null) {
      throw new core.ArgumentError("Parameter leaderboardId is required.");
    }
    if (collection == null) {
      throw new core.ArgumentError("Parameter collection is required.");
    }
    if (timeSpan == null) {
      throw new core.ArgumentError("Parameter timeSpan is required.");
    }
    _queryParams["timeSpan"] = [timeSpan];
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (resultsAbove != null) {
      _queryParams["resultsAbove"] = ["${resultsAbove}"];
    }
    if (returnTopIfAbsent != null) {
      _queryParams["returnTopIfAbsent"] = ["${returnTopIfAbsent}"];
    }

    _url = 'leaderboards/' + commons.Escaper.ecapeVariable('$leaderboardId') + '/window/' + commons.Escaper.ecapeVariable('$collection');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LeaderboardScores.fromJson(data));
  }

  /**
   * Submits a score to the specified leaderboard.
   *
   * Request parameters:
   *
   * [leaderboardId] - The ID of the leaderboard.
   *
   * [score] - The score you're submitting. The submitted score is ignored if it
   * is worse than a previously submitted score, where worse depends on the
   * leaderboard sort order. The meaning of the score value depends on the
   * leaderboard format type. For fixed-point, the score represents the raw
   * value. For time, the score represents elapsed time in milliseconds. For
   * currency, the score represents a value in micro units.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [scoreTag] - Additional information about the score you're submitting.
   * Values must contain no more than 64 URI-safe characters as defined by
   * section 2.3 of RFC 3986.
   * Value must have pattern "[a-zA-Z0-9-._~]{0,64}".
   *
   * Completes with a [PlayerScoreResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlayerScoreResponse> submit(core.String leaderboardId, core.String score, {core.String consistencyToken, core.String language, core.String scoreTag}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (leaderboardId == null) {
      throw new core.ArgumentError("Parameter leaderboardId is required.");
    }
    if (score == null) {
      throw new core.ArgumentError("Parameter score is required.");
    }
    _queryParams["score"] = [score];
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (scoreTag != null) {
      _queryParams["scoreTag"] = [scoreTag];
    }

    _url = 'leaderboards/' + commons.Escaper.ecapeVariable('$leaderboardId') + '/scores';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlayerScoreResponse.fromJson(data));
  }

  /**
   * Submits multiple scores to leaderboards.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [PlayerScoreListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlayerScoreListResponse> submitMultiple(PlayerScoreSubmissionList request, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'leaderboards/scores';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlayerScoreListResponse.fromJson(data));
  }

}


class SnapshotsResourceApi {
  final commons.ApiRequester _requester;

  SnapshotsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves the metadata for a given snapshot ID.
   *
   * Request parameters:
   *
   * [snapshotId] - The ID of the snapshot.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [Snapshot].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Snapshot> get(core.String snapshotId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (snapshotId == null) {
      throw new core.ArgumentError("Parameter snapshotId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'snapshots/' + commons.Escaper.ecapeVariable('$snapshotId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Snapshot.fromJson(data));
  }

  /**
   * Retrieves a list of snapshots created by your application for the player
   * corresponding to the player ID.
   *
   * Request parameters:
   *
   * [playerId] - A player ID. A value of me may be used in place of the
   * authenticated player's ID.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxResults] - The maximum number of snapshot resources to return in the
   * response, used for paging. For any response, the actual number of snapshot
   * resources returned may be less than the specified maxResults.
   * Value must be between "1" and "25".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [SnapshotListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SnapshotListResponse> list(core.String playerId, {core.String consistencyToken, core.String language, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (playerId == null) {
      throw new core.ArgumentError("Parameter playerId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'players/' + commons.Escaper.ecapeVariable('$playerId') + '/snapshots';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SnapshotListResponse.fromJson(data));
  }

}


class TurnBasedMatchesResourceApi {
  final commons.ApiRequester _requester;

  TurnBasedMatchesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Cancel a turn-based match.
   *
   * Request parameters:
   *
   * [matchId] - The ID of the match.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future cancel(core.String matchId, {core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (matchId == null) {
      throw new core.ArgumentError("Parameter matchId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _downloadOptions = null;

    _url = 'turnbasedmatches/' + commons.Escaper.ecapeVariable('$matchId') + '/cancel';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Create a turn-based match.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [TurnBasedMatch].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TurnBasedMatch> create(TurnBasedMatchCreateRequest request, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'turnbasedmatches/create';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TurnBasedMatch.fromJson(data));
  }

  /**
   * Decline an invitation to play a turn-based match.
   *
   * Request parameters:
   *
   * [matchId] - The ID of the match.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [TurnBasedMatch].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TurnBasedMatch> decline(core.String matchId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (matchId == null) {
      throw new core.ArgumentError("Parameter matchId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'turnbasedmatches/' + commons.Escaper.ecapeVariable('$matchId') + '/decline';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TurnBasedMatch.fromJson(data));
  }

  /**
   * Dismiss a turn-based match from the match list. The match will no longer
   * show up in the list and will not generate notifications.
   *
   * Request parameters:
   *
   * [matchId] - The ID of the match.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future dismiss(core.String matchId, {core.String consistencyToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (matchId == null) {
      throw new core.ArgumentError("Parameter matchId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }

    _downloadOptions = null;

    _url = 'turnbasedmatches/' + commons.Escaper.ecapeVariable('$matchId') + '/dismiss';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Finish a turn-based match. Each player should make this call once, after
   * all results are in. Only the player whose turn it is may make the first
   * call to Finish, and can pass in the final match state.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [matchId] - The ID of the match.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [TurnBasedMatch].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TurnBasedMatch> finish(TurnBasedMatchResults request, core.String matchId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (matchId == null) {
      throw new core.ArgumentError("Parameter matchId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'turnbasedmatches/' + commons.Escaper.ecapeVariable('$matchId') + '/finish';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TurnBasedMatch.fromJson(data));
  }

  /**
   * Get the data for a turn-based match.
   *
   * Request parameters:
   *
   * [matchId] - The ID of the match.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [includeMatchData] - Get match data along with metadata.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [TurnBasedMatch].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TurnBasedMatch> get(core.String matchId, {core.String consistencyToken, core.bool includeMatchData, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (matchId == null) {
      throw new core.ArgumentError("Parameter matchId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (includeMatchData != null) {
      _queryParams["includeMatchData"] = ["${includeMatchData}"];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'turnbasedmatches/' + commons.Escaper.ecapeVariable('$matchId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TurnBasedMatch.fromJson(data));
  }

  /**
   * Join a turn-based match.
   *
   * Request parameters:
   *
   * [matchId] - The ID of the match.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [TurnBasedMatch].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TurnBasedMatch> join(core.String matchId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (matchId == null) {
      throw new core.ArgumentError("Parameter matchId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'turnbasedmatches/' + commons.Escaper.ecapeVariable('$matchId') + '/join';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TurnBasedMatch.fromJson(data));
  }

  /**
   * Leave a turn-based match when it is not the current player's turn, without
   * canceling the match.
   *
   * Request parameters:
   *
   * [matchId] - The ID of the match.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [TurnBasedMatch].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TurnBasedMatch> leave(core.String matchId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (matchId == null) {
      throw new core.ArgumentError("Parameter matchId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'turnbasedmatches/' + commons.Escaper.ecapeVariable('$matchId') + '/leave';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TurnBasedMatch.fromJson(data));
  }

  /**
   * Leave a turn-based match during the current player's turn, without
   * canceling the match.
   *
   * Request parameters:
   *
   * [matchId] - The ID of the match.
   *
   * [matchVersion] - The version of the match being updated.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [pendingParticipantId] - The ID of another participant who should take
   * their turn next. If not set, the match will wait for other player(s) to
   * join via automatching; this is only valid if automatch criteria is set on
   * the match with remaining slots for automatched players.
   *
   * Completes with a [TurnBasedMatch].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TurnBasedMatch> leaveTurn(core.String matchId, core.int matchVersion, {core.String consistencyToken, core.String language, core.String pendingParticipantId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (matchId == null) {
      throw new core.ArgumentError("Parameter matchId is required.");
    }
    if (matchVersion == null) {
      throw new core.ArgumentError("Parameter matchVersion is required.");
    }
    _queryParams["matchVersion"] = ["${matchVersion}"];
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (pendingParticipantId != null) {
      _queryParams["pendingParticipantId"] = [pendingParticipantId];
    }

    _url = 'turnbasedmatches/' + commons.Escaper.ecapeVariable('$matchId') + '/leaveTurn';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TurnBasedMatch.fromJson(data));
  }

  /**
   * Returns turn-based matches the player is or was involved in.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [includeMatchData] - True if match data should be returned in the response.
   * Note that not all data will necessarily be returned if include_match_data
   * is true; the server may decide to only return data for some of the matches
   * to limit download size for the client. The remainder of the data for these
   * matches will be retrievable on request.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxCompletedMatches] - The maximum number of completed or canceled matches
   * to return in the response. If not set, all matches returned could be
   * completed or canceled.
   * Value must be between "0" and "500".
   *
   * [maxResults] - The maximum number of matches to return in the response,
   * used for paging. For any response, the actual number of matches to return
   * may be less than the specified maxResults.
   * Value must be between "1" and "500".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [TurnBasedMatchList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TurnBasedMatchList> list({core.String consistencyToken, core.bool includeMatchData, core.String language, core.int maxCompletedMatches, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (includeMatchData != null) {
      _queryParams["includeMatchData"] = ["${includeMatchData}"];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxCompletedMatches != null) {
      _queryParams["maxCompletedMatches"] = ["${maxCompletedMatches}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'turnbasedmatches';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TurnBasedMatchList.fromJson(data));
  }

  /**
   * Create a rematch of a match that was previously completed, with the same
   * participants. This can be called by only one player on a match still in
   * their list; the player must have called Finish first. Returns the newly
   * created match; it will be the caller's turn.
   *
   * Request parameters:
   *
   * [matchId] - The ID of the match.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [requestId] - A randomly generated numeric ID for each request specified by
   * the caller. This number is used at the server to ensure that the request is
   * handled correctly across retries.
   *
   * Completes with a [TurnBasedMatchRematch].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TurnBasedMatchRematch> rematch(core.String matchId, {core.String consistencyToken, core.String language, core.String requestId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (matchId == null) {
      throw new core.ArgumentError("Parameter matchId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (requestId != null) {
      _queryParams["requestId"] = [requestId];
    }

    _url = 'turnbasedmatches/' + commons.Escaper.ecapeVariable('$matchId') + '/rematch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TurnBasedMatchRematch.fromJson(data));
  }

  /**
   * Returns turn-based matches the player is or was involved in that changed
   * since the last sync call, with the least recent changes coming first.
   * Matches that should be removed from the local cache will have a status of
   * MATCH_DELETED.
   *
   * Request parameters:
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [includeMatchData] - True if match data should be returned in the response.
   * Note that not all data will necessarily be returned if include_match_data
   * is true; the server may decide to only return data for some of the matches
   * to limit download size for the client. The remainder of the data for these
   * matches will be retrievable on request.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * [maxCompletedMatches] - The maximum number of completed or canceled matches
   * to return in the response. If not set, all matches returned could be
   * completed or canceled.
   * Value must be between "0" and "500".
   *
   * [maxResults] - The maximum number of matches to return in the response,
   * used for paging. For any response, the actual number of matches to return
   * may be less than the specified maxResults.
   * Value must be between "1" and "500".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [TurnBasedMatchSync].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TurnBasedMatchSync> sync({core.String consistencyToken, core.bool includeMatchData, core.String language, core.int maxCompletedMatches, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (includeMatchData != null) {
      _queryParams["includeMatchData"] = ["${includeMatchData}"];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if (maxCompletedMatches != null) {
      _queryParams["maxCompletedMatches"] = ["${maxCompletedMatches}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'turnbasedmatches/sync';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TurnBasedMatchSync.fromJson(data));
  }

  /**
   * Commit the results of a player turn.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [matchId] - The ID of the match.
   *
   * [consistencyToken] - The last-seen mutation timestamp.
   *
   * [language] - The preferred language to use for strings returned by this
   * method.
   *
   * Completes with a [TurnBasedMatch].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TurnBasedMatch> takeTurn(TurnBasedMatchTurn request, core.String matchId, {core.String consistencyToken, core.String language}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (matchId == null) {
      throw new core.ArgumentError("Parameter matchId is required.");
    }
    if (consistencyToken != null) {
      _queryParams["consistencyToken"] = [consistencyToken];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }

    _url = 'turnbasedmatches/' + commons.Escaper.ecapeVariable('$matchId') + '/turn';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TurnBasedMatch.fromJson(data));
  }

}



/** This is a JSON template for an achievement definition object. */
class AchievementDefinition {
  /**
   * The type of the achievement.
   * Possible values are:
   * - "STANDARD" - Achievement is either locked or unlocked.
   * - "INCREMENTAL" - Achievement is incremental.
   */
  core.String achievementType;
  /** The description of the achievement. */
  core.String description;
  /**
   * Experience points which will be earned when unlocking this achievement.
   */
  core.String experiencePoints;
  /** The total steps for an incremental achievement as a string. */
  core.String formattedTotalSteps;
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
   * Indicates whether the revealed icon image being returned is a default
   * image, or is provided by the game.
   */
  core.bool isRevealedIconUrlDefault;
  /**
   * Indicates whether the unlocked icon image being returned is a default
   * image, or is game-provided.
   */
  core.bool isUnlockedIconUrlDefault;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#achievementDefinition.
   */
  core.String kind;
  /** The name of the achievement. */
  core.String name;
  /** The image URL for the revealed achievement icon. */
  core.String revealedIconUrl;
  /** The total steps for an incremental achievement. */
  core.int totalSteps;
  /** The image URL for the unlocked achievement icon. */
  core.String unlockedIconUrl;

  AchievementDefinition();

  AchievementDefinition.fromJson(core.Map _json) {
    if (_json.containsKey("achievementType")) {
      achievementType = _json["achievementType"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("experiencePoints")) {
      experiencePoints = _json["experiencePoints"];
    }
    if (_json.containsKey("formattedTotalSteps")) {
      formattedTotalSteps = _json["formattedTotalSteps"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("initialState")) {
      initialState = _json["initialState"];
    }
    if (_json.containsKey("isRevealedIconUrlDefault")) {
      isRevealedIconUrlDefault = _json["isRevealedIconUrlDefault"];
    }
    if (_json.containsKey("isUnlockedIconUrlDefault")) {
      isUnlockedIconUrlDefault = _json["isUnlockedIconUrlDefault"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("revealedIconUrl")) {
      revealedIconUrl = _json["revealedIconUrl"];
    }
    if (_json.containsKey("totalSteps")) {
      totalSteps = _json["totalSteps"];
    }
    if (_json.containsKey("unlockedIconUrl")) {
      unlockedIconUrl = _json["unlockedIconUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (achievementType != null) {
      _json["achievementType"] = achievementType;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (experiencePoints != null) {
      _json["experiencePoints"] = experiencePoints;
    }
    if (formattedTotalSteps != null) {
      _json["formattedTotalSteps"] = formattedTotalSteps;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (initialState != null) {
      _json["initialState"] = initialState;
    }
    if (isRevealedIconUrlDefault != null) {
      _json["isRevealedIconUrlDefault"] = isRevealedIconUrlDefault;
    }
    if (isUnlockedIconUrlDefault != null) {
      _json["isUnlockedIconUrlDefault"] = isUnlockedIconUrlDefault;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (revealedIconUrl != null) {
      _json["revealedIconUrl"] = revealedIconUrl;
    }
    if (totalSteps != null) {
      _json["totalSteps"] = totalSteps;
    }
    if (unlockedIconUrl != null) {
      _json["unlockedIconUrl"] = unlockedIconUrl;
    }
    return _json;
  }
}

/** This is a JSON template for a list of achievement definition objects. */
class AchievementDefinitionsListResponse {
  /** The achievement definitions. */
  core.List<AchievementDefinition> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#achievementDefinitionsListResponse.
   */
  core.String kind;
  /** Token corresponding to the next page of results. */
  core.String nextPageToken;

  AchievementDefinitionsListResponse();

  AchievementDefinitionsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new AchievementDefinition.fromJson(value)).toList();
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

/** This is a JSON template for an achievement increment response */
class AchievementIncrementResponse {
  /** The current steps recorded for this incremental achievement. */
  core.int currentSteps;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#achievementIncrementResponse.
   */
  core.String kind;
  /**
   * Whether the current steps for the achievement has reached the number of
   * steps required to unlock.
   */
  core.bool newlyUnlocked;

  AchievementIncrementResponse();

  AchievementIncrementResponse.fromJson(core.Map _json) {
    if (_json.containsKey("currentSteps")) {
      currentSteps = _json["currentSteps"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("newlyUnlocked")) {
      newlyUnlocked = _json["newlyUnlocked"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currentSteps != null) {
      _json["currentSteps"] = currentSteps;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (newlyUnlocked != null) {
      _json["newlyUnlocked"] = newlyUnlocked;
    }
    return _json;
  }
}

/** This is a JSON template for an achievement reveal response */
class AchievementRevealResponse {
  /**
   * The current state of the achievement for which a reveal was attempted. This
   * might be UNLOCKED if the achievement was already unlocked.
   * Possible values are:
   * - "REVEALED" - Achievement is revealed.
   * - "UNLOCKED" - Achievement is unlocked.
   */
  core.String currentState;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#achievementRevealResponse.
   */
  core.String kind;

  AchievementRevealResponse();

  AchievementRevealResponse.fromJson(core.Map _json) {
    if (_json.containsKey("currentState")) {
      currentState = _json["currentState"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currentState != null) {
      _json["currentState"] = currentState;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** This is a JSON template for an achievement set steps at least response. */
class AchievementSetStepsAtLeastResponse {
  /** The current steps recorded for this incremental achievement. */
  core.int currentSteps;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#achievementSetStepsAtLeastResponse.
   */
  core.String kind;
  /**
   * Whether the the current steps for the achievement has reached the number of
   * steps required to unlock.
   */
  core.bool newlyUnlocked;

  AchievementSetStepsAtLeastResponse();

  AchievementSetStepsAtLeastResponse.fromJson(core.Map _json) {
    if (_json.containsKey("currentSteps")) {
      currentSteps = _json["currentSteps"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("newlyUnlocked")) {
      newlyUnlocked = _json["newlyUnlocked"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currentSteps != null) {
      _json["currentSteps"] = currentSteps;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (newlyUnlocked != null) {
      _json["newlyUnlocked"] = newlyUnlocked;
    }
    return _json;
  }
}

/** This is a JSON template for an achievement unlock response */
class AchievementUnlockResponse {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#achievementUnlockResponse.
   */
  core.String kind;
  /**
   * Whether this achievement was newly unlocked (that is, whether the unlock
   * request for the achievement was the first for the player).
   */
  core.bool newlyUnlocked;

  AchievementUnlockResponse();

  AchievementUnlockResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("newlyUnlocked")) {
      newlyUnlocked = _json["newlyUnlocked"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (newlyUnlocked != null) {
      _json["newlyUnlocked"] = newlyUnlocked;
    }
    return _json;
  }
}

/** This is a JSON template for a list of achievement update requests. */
class AchievementUpdateMultipleRequest {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#achievementUpdateMultipleRequest.
   */
  core.String kind;
  /** The individual achievement update requests. */
  core.List<AchievementUpdateRequest> updates;

  AchievementUpdateMultipleRequest();

  AchievementUpdateMultipleRequest.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("updates")) {
      updates = _json["updates"].map((value) => new AchievementUpdateRequest.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (updates != null) {
      _json["updates"] = updates.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** This is a JSON template for an achievement unlock response. */
class AchievementUpdateMultipleResponse {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#achievementUpdateListResponse.
   */
  core.String kind;
  /** The updated state of the achievements. */
  core.List<AchievementUpdateResponse> updatedAchievements;

  AchievementUpdateMultipleResponse();

  AchievementUpdateMultipleResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("updatedAchievements")) {
      updatedAchievements = _json["updatedAchievements"].map((value) => new AchievementUpdateResponse.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (updatedAchievements != null) {
      _json["updatedAchievements"] = updatedAchievements.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** This is a JSON template for a request to update an achievement. */
class AchievementUpdateRequest {
  /** The achievement this update is being applied to. */
  core.String achievementId;
  /**
   * The payload if an update of type INCREMENT was requested for the
   * achievement.
   */
  GamesAchievementIncrement incrementPayload;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#achievementUpdateRequest.
   */
  core.String kind;
  /**
   * The payload if an update of type SET_STEPS_AT_LEAST was requested for the
   * achievement.
   */
  GamesAchievementSetStepsAtLeast setStepsAtLeastPayload;
  /**
   * The type of update being applied.
   * Possible values are:
   * - "REVEAL" - Achievement is revealed.
   * - "UNLOCK" - Achievement is unlocked.
   * - "INCREMENT" - Achievement is incremented.
   * - "SET_STEPS_AT_LEAST" - Achievement progress is set to at least the passed
   * value.
   */
  core.String updateType;

  AchievementUpdateRequest();

  AchievementUpdateRequest.fromJson(core.Map _json) {
    if (_json.containsKey("achievementId")) {
      achievementId = _json["achievementId"];
    }
    if (_json.containsKey("incrementPayload")) {
      incrementPayload = new GamesAchievementIncrement.fromJson(_json["incrementPayload"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("setStepsAtLeastPayload")) {
      setStepsAtLeastPayload = new GamesAchievementSetStepsAtLeast.fromJson(_json["setStepsAtLeastPayload"]);
    }
    if (_json.containsKey("updateType")) {
      updateType = _json["updateType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (achievementId != null) {
      _json["achievementId"] = achievementId;
    }
    if (incrementPayload != null) {
      _json["incrementPayload"] = (incrementPayload).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (setStepsAtLeastPayload != null) {
      _json["setStepsAtLeastPayload"] = (setStepsAtLeastPayload).toJson();
    }
    if (updateType != null) {
      _json["updateType"] = updateType;
    }
    return _json;
  }
}

/** This is a JSON template for an achievement update response. */
class AchievementUpdateResponse {
  /** The achievement this update is was applied to. */
  core.String achievementId;
  /**
   * The current state of the achievement.
   * Possible values are:
   * - "HIDDEN" - Achievement is hidden.
   * - "REVEALED" - Achievement is revealed.
   * - "UNLOCKED" - Achievement is unlocked.
   */
  core.String currentState;
  /** The current steps recorded for this achievement if it is incremental. */
  core.int currentSteps;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#achievementUpdateResponse.
   */
  core.String kind;
  /**
   * Whether this achievement was newly unlocked (that is, whether the unlock
   * request for the achievement was the first for the player).
   */
  core.bool newlyUnlocked;
  /** Whether the requested updates actually affected the achievement. */
  core.bool updateOccurred;

  AchievementUpdateResponse();

  AchievementUpdateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("achievementId")) {
      achievementId = _json["achievementId"];
    }
    if (_json.containsKey("currentState")) {
      currentState = _json["currentState"];
    }
    if (_json.containsKey("currentSteps")) {
      currentSteps = _json["currentSteps"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("newlyUnlocked")) {
      newlyUnlocked = _json["newlyUnlocked"];
    }
    if (_json.containsKey("updateOccurred")) {
      updateOccurred = _json["updateOccurred"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (achievementId != null) {
      _json["achievementId"] = achievementId;
    }
    if (currentState != null) {
      _json["currentState"] = currentState;
    }
    if (currentSteps != null) {
      _json["currentSteps"] = currentSteps;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (newlyUnlocked != null) {
      _json["newlyUnlocked"] = newlyUnlocked;
    }
    if (updateOccurred != null) {
      _json["updateOccurred"] = updateOccurred;
    }
    return _json;
  }
}

/** This is a JSON template for aggregate stats. */
class AggregateStats {
  /** The number of messages sent between a pair of peers. */
  core.String count;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#aggregateStats.
   */
  core.String kind;
  /** The maximum amount. */
  core.String max;
  /** The minimum amount. */
  core.String min;
  /** The total number of bytes sent for messages between a pair of peers. */
  core.String sum;

  AggregateStats();

  AggregateStats.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("max")) {
      max = _json["max"];
    }
    if (_json.containsKey("min")) {
      min = _json["min"];
    }
    if (_json.containsKey("sum")) {
      sum = _json["sum"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (count != null) {
      _json["count"] = count;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (max != null) {
      _json["max"] = max;
    }
    if (min != null) {
      _json["min"] = min;
    }
    if (sum != null) {
      _json["sum"] = sum;
    }
    return _json;
  }
}

/** This is a JSON template for an anonymous player */
class AnonymousPlayer {
  /** The base URL for the image to display for the anonymous player. */
  core.String avatarImageUrl;
  /** The name to display for the anonymous player. */
  core.String displayName;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#anonymousPlayer.
   */
  core.String kind;

  AnonymousPlayer();

  AnonymousPlayer.fromJson(core.Map _json) {
    if (_json.containsKey("avatarImageUrl")) {
      avatarImageUrl = _json["avatarImageUrl"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (avatarImageUrl != null) {
      _json["avatarImageUrl"] = avatarImageUrl;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** This is a JSON template for the Application resource. */
class Application {
  /**
   * The number of achievements visible to the currently authenticated player.
   */
  core.int achievementCount;
  /** The assets of the application. */
  core.List<ImageAsset> assets;
  /** The author of the application. */
  core.String author;
  /** The category of the application. */
  ApplicationCategory category;
  /** The description of the application. */
  core.String description;
  /**
   * A list of features that have been enabled for the application.
   * Possible values are:
   * - "SNAPSHOTS" - Snapshots has been enabled
   */
  core.List<core.String> enabledFeatures;
  /** The ID of the application. */
  core.String id;
  /** The instances of the application. */
  core.List<Instance> instances;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#application.
   */
  core.String kind;
  /** The last updated timestamp of the application. */
  core.String lastUpdatedTimestamp;
  /**
   * The number of leaderboards visible to the currently authenticated player.
   */
  core.int leaderboardCount;
  /** The name of the application. */
  core.String name;
  /**
   * A hint to the client UI for what color to use as an app-themed color. The
   * color is given as an RGB triplet (e.g. "E0E0E0").
   */
  core.String themeColor;

  Application();

  Application.fromJson(core.Map _json) {
    if (_json.containsKey("achievement_count")) {
      achievementCount = _json["achievement_count"];
    }
    if (_json.containsKey("assets")) {
      assets = _json["assets"].map((value) => new ImageAsset.fromJson(value)).toList();
    }
    if (_json.containsKey("author")) {
      author = _json["author"];
    }
    if (_json.containsKey("category")) {
      category = new ApplicationCategory.fromJson(_json["category"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("enabledFeatures")) {
      enabledFeatures = _json["enabledFeatures"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("instances")) {
      instances = _json["instances"].map((value) => new Instance.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastUpdatedTimestamp")) {
      lastUpdatedTimestamp = _json["lastUpdatedTimestamp"];
    }
    if (_json.containsKey("leaderboard_count")) {
      leaderboardCount = _json["leaderboard_count"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("themeColor")) {
      themeColor = _json["themeColor"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (achievementCount != null) {
      _json["achievement_count"] = achievementCount;
    }
    if (assets != null) {
      _json["assets"] = assets.map((value) => (value).toJson()).toList();
    }
    if (author != null) {
      _json["author"] = author;
    }
    if (category != null) {
      _json["category"] = (category).toJson();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (enabledFeatures != null) {
      _json["enabledFeatures"] = enabledFeatures;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (instances != null) {
      _json["instances"] = instances.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastUpdatedTimestamp != null) {
      _json["lastUpdatedTimestamp"] = lastUpdatedTimestamp;
    }
    if (leaderboardCount != null) {
      _json["leaderboard_count"] = leaderboardCount;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (themeColor != null) {
      _json["themeColor"] = themeColor;
    }
    return _json;
  }
}

/** This is a JSON template for an application category object. */
class ApplicationCategory {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#applicationCategory.
   */
  core.String kind;
  /** The primary category. */
  core.String primary;
  /** The secondary category. */
  core.String secondary;

  ApplicationCategory();

  ApplicationCategory.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("primary")) {
      primary = _json["primary"];
    }
    if (_json.containsKey("secondary")) {
      secondary = _json["secondary"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (primary != null) {
      _json["primary"] = primary;
    }
    if (secondary != null) {
      _json["secondary"] = secondary;
    }
    return _json;
  }
}

/**
 * This is a JSON template for a third party application verification response
 * resource.
 */
class ApplicationVerifyResponse {
  /**
   * An alternate ID that was once used for the player that was issued the auth
   * token used in this request. (This field is not normally populated.)
   */
  core.String alternatePlayerId;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#applicationVerifyResponse.
   */
  core.String kind;
  /**
   * The ID of the player that was issued the auth token used in this request.
   */
  core.String playerId;

  ApplicationVerifyResponse();

  ApplicationVerifyResponse.fromJson(core.Map _json) {
    if (_json.containsKey("alternate_player_id")) {
      alternatePlayerId = _json["alternate_player_id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("player_id")) {
      playerId = _json["player_id"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alternatePlayerId != null) {
      _json["alternate_player_id"] = alternatePlayerId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (playerId != null) {
      _json["player_id"] = playerId;
    }
    return _json;
  }
}

/** This is a JSON template for data related to individual game categories. */
class Category {
  /** The category name. */
  core.String category;
  /** Experience points earned in this category. */
  core.String experiencePoints;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#category.
   */
  core.String kind;

  Category();

  Category.fromJson(core.Map _json) {
    if (_json.containsKey("category")) {
      category = _json["category"];
    }
    if (_json.containsKey("experiencePoints")) {
      experiencePoints = _json["experiencePoints"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (category != null) {
      _json["category"] = category;
    }
    if (experiencePoints != null) {
      _json["experiencePoints"] = experiencePoints;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** This is a JSON template for a list of category data objects. */
class CategoryListResponse {
  /** The list of categories with usage data. */
  core.List<Category> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#categoryListResponse.
   */
  core.String kind;
  /** Token corresponding to the next page of results. */
  core.String nextPageToken;

  CategoryListResponse();

  CategoryListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Category.fromJson(value)).toList();
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

/** This is a JSON template for a batch update failure resource. */
class EventBatchRecordFailure {
  /**
   * The cause for the update failure.
   * Possible values are:
   * - "TOO_LARGE": A batch request was issued with more events than are allowed
   * in a single batch.
   * - "TIME_PERIOD_EXPIRED": A batch was sent with data too far in the past to
   * record.
   * - "TIME_PERIOD_SHORT": A batch was sent with a time range that was too
   * short.
   * - "TIME_PERIOD_LONG": A batch was sent with a time range that was too long.
   * - "ALREADY_UPDATED": An attempt was made to record a batch of data which
   * was already seen.
   * - "RECORD_RATE_HIGH": An attempt was made to record data faster than the
   * server will apply updates.
   */
  core.String failureCause;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#eventBatchRecordFailure.
   */
  core.String kind;
  /** The time range which was rejected; empty for a request-wide failure. */
  EventPeriodRange range;

  EventBatchRecordFailure();

  EventBatchRecordFailure.fromJson(core.Map _json) {
    if (_json.containsKey("failureCause")) {
      failureCause = _json["failureCause"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("range")) {
      range = new EventPeriodRange.fromJson(_json["range"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (failureCause != null) {
      _json["failureCause"] = failureCause;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (range != null) {
      _json["range"] = (range).toJson();
    }
    return _json;
  }
}

/** This is a JSON template for an event child relationship resource. */
class EventChild {
  /** The ID of the child event. */
  core.String childId;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#eventChild.
   */
  core.String kind;

  EventChild();

  EventChild.fromJson(core.Map _json) {
    if (_json.containsKey("childId")) {
      childId = _json["childId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (childId != null) {
      _json["childId"] = childId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** This is a JSON template for an event definition resource. */
class EventDefinition {
  /** A list of events that are a child of this event. */
  core.List<EventChild> childEvents;
  /** Description of what this event represents. */
  core.String description;
  /** The name to display for the event. */
  core.String displayName;
  /** The ID of the event. */
  core.String id;
  /** The base URL for the image that represents the event. */
  core.String imageUrl;
  /**
   * Indicates whether the icon image being returned is a default image, or is
   * game-provided.
   */
  core.bool isDefaultImageUrl;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#eventDefinition.
   */
  core.String kind;
  /**
   * The visibility of event being tracked in this definition.
   * Possible values are:
   * - "REVEALED": This event should be visible to all users.
   * - "HIDDEN": This event should only be shown to users that have recorded
   * this event at least once.
   */
  core.String visibility;

  EventDefinition();

  EventDefinition.fromJson(core.Map _json) {
    if (_json.containsKey("childEvents")) {
      childEvents = _json["childEvents"].map((value) => new EventChild.fromJson(value)).toList();
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("imageUrl")) {
      imageUrl = _json["imageUrl"];
    }
    if (_json.containsKey("isDefaultImageUrl")) {
      isDefaultImageUrl = _json["isDefaultImageUrl"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("visibility")) {
      visibility = _json["visibility"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (childEvents != null) {
      _json["childEvents"] = childEvents.map((value) => (value).toJson()).toList();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (imageUrl != null) {
      _json["imageUrl"] = imageUrl;
    }
    if (isDefaultImageUrl != null) {
      _json["isDefaultImageUrl"] = isDefaultImageUrl;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (visibility != null) {
      _json["visibility"] = visibility;
    }
    return _json;
  }
}

/** This is a JSON template for a ListDefinitions response. */
class EventDefinitionListResponse {
  /** The event definitions. */
  core.List<EventDefinition> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#eventDefinitionListResponse.
   */
  core.String kind;
  /** The pagination token for the next page of results. */
  core.String nextPageToken;

  EventDefinitionListResponse();

  EventDefinitionListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new EventDefinition.fromJson(value)).toList();
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

/** This is a JSON template for an event period time range. */
class EventPeriodRange {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#eventPeriodRange.
   */
  core.String kind;
  /**
   * The time when this update period ends, in millis, since 1970 UTC (Unix
   * Epoch).
   */
  core.String periodEndMillis;
  /**
   * The time when this update period begins, in millis, since 1970 UTC (Unix
   * Epoch).
   */
  core.String periodStartMillis;

  EventPeriodRange();

  EventPeriodRange.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("periodEndMillis")) {
      periodEndMillis = _json["periodEndMillis"];
    }
    if (_json.containsKey("periodStartMillis")) {
      periodStartMillis = _json["periodStartMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (periodEndMillis != null) {
      _json["periodEndMillis"] = periodEndMillis;
    }
    if (periodStartMillis != null) {
      _json["periodStartMillis"] = periodStartMillis;
    }
    return _json;
  }
}

/** This is a JSON template for an event period update resource. */
class EventPeriodUpdate {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#eventPeriodUpdate.
   */
  core.String kind;
  /** The time period being covered by this update. */
  EventPeriodRange timePeriod;
  /** The updates being made for this time period. */
  core.List<EventUpdateRequest> updates;

  EventPeriodUpdate();

  EventPeriodUpdate.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("timePeriod")) {
      timePeriod = new EventPeriodRange.fromJson(_json["timePeriod"]);
    }
    if (_json.containsKey("updates")) {
      updates = _json["updates"].map((value) => new EventUpdateRequest.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (timePeriod != null) {
      _json["timePeriod"] = (timePeriod).toJson();
    }
    if (updates != null) {
      _json["updates"] = updates.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** This is a JSON template for an event update failure resource. */
class EventRecordFailure {
  /** The ID of the event that was not updated. */
  core.String eventId;
  /**
   * The cause for the update failure.
   * Possible values are:
   * - "NOT_FOUND" - An attempt was made to set an event that was not defined.
   * - "INVALID_UPDATE_VALUE" - An attempt was made to increment an event by a
   * non-positive value.
   */
  core.String failureCause;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#eventRecordFailure.
   */
  core.String kind;

  EventRecordFailure();

  EventRecordFailure.fromJson(core.Map _json) {
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("failureCause")) {
      failureCause = _json["failureCause"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (eventId != null) {
      _json["eventId"] = eventId;
    }
    if (failureCause != null) {
      _json["failureCause"] = failureCause;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** This is a JSON template for an event period update resource. */
class EventRecordRequest {
  /**
   * The current time when this update was sent, in milliseconds, since 1970 UTC
   * (Unix Epoch).
   */
  core.String currentTimeMillis;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#eventRecordRequest.
   */
  core.String kind;
  /** The request ID used to identify this attempt to record events. */
  core.String requestId;
  /** A list of the time period updates being made in this request. */
  core.List<EventPeriodUpdate> timePeriods;

  EventRecordRequest();

  EventRecordRequest.fromJson(core.Map _json) {
    if (_json.containsKey("currentTimeMillis")) {
      currentTimeMillis = _json["currentTimeMillis"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("requestId")) {
      requestId = _json["requestId"];
    }
    if (_json.containsKey("timePeriods")) {
      timePeriods = _json["timePeriods"].map((value) => new EventPeriodUpdate.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currentTimeMillis != null) {
      _json["currentTimeMillis"] = currentTimeMillis;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (requestId != null) {
      _json["requestId"] = requestId;
    }
    if (timePeriods != null) {
      _json["timePeriods"] = timePeriods.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** This is a JSON template for an event period update resource. */
class EventUpdateRequest {
  /** The ID of the event being modified in this update. */
  core.String definitionId;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#eventUpdateRequest.
   */
  core.String kind;
  /** The number of times this event occurred in this time period. */
  core.String updateCount;

  EventUpdateRequest();

  EventUpdateRequest.fromJson(core.Map _json) {
    if (_json.containsKey("definitionId")) {
      definitionId = _json["definitionId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("updateCount")) {
      updateCount = _json["updateCount"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (definitionId != null) {
      _json["definitionId"] = definitionId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (updateCount != null) {
      _json["updateCount"] = updateCount;
    }
    return _json;
  }
}

/** This is a JSON template for an event period update resource. */
class EventUpdateResponse {
  /** Any batch-wide failures which occurred applying updates. */
  core.List<EventBatchRecordFailure> batchFailures;
  /** Any failures updating a particular event. */
  core.List<EventRecordFailure> eventFailures;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#eventUpdateResponse.
   */
  core.String kind;
  /** The current status of any updated events */
  core.List<PlayerEvent> playerEvents;

  EventUpdateResponse();

  EventUpdateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("batchFailures")) {
      batchFailures = _json["batchFailures"].map((value) => new EventBatchRecordFailure.fromJson(value)).toList();
    }
    if (_json.containsKey("eventFailures")) {
      eventFailures = _json["eventFailures"].map((value) => new EventRecordFailure.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("playerEvents")) {
      playerEvents = _json["playerEvents"].map((value) => new PlayerEvent.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchFailures != null) {
      _json["batchFailures"] = batchFailures.map((value) => (value).toJson()).toList();
    }
    if (eventFailures != null) {
      _json["eventFailures"] = eventFailures.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (playerEvents != null) {
      _json["playerEvents"] = playerEvents.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * This is a JSON template for the payload to request to increment an
 * achievement.
 */
class GamesAchievementIncrement {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#GamesAchievementIncrement.
   */
  core.String kind;
  /** The requestId associated with an increment to an achievement. */
  core.String requestId;
  /** The number of steps to be incremented. */
  core.int steps;

  GamesAchievementIncrement();

  GamesAchievementIncrement.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("requestId")) {
      requestId = _json["requestId"];
    }
    if (_json.containsKey("steps")) {
      steps = _json["steps"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (requestId != null) {
      _json["requestId"] = requestId;
    }
    if (steps != null) {
      _json["steps"] = steps;
    }
    return _json;
  }
}

/**
 * This is a JSON template for the payload to request to increment an
 * achievement.
 */
class GamesAchievementSetStepsAtLeast {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#GamesAchievementSetStepsAtLeast.
   */
  core.String kind;
  /** The minimum number of steps for the achievement to be set to. */
  core.int steps;

  GamesAchievementSetStepsAtLeast();

  GamesAchievementSetStepsAtLeast.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("steps")) {
      steps = _json["steps"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (steps != null) {
      _json["steps"] = steps;
    }
    return _json;
  }
}

/** This is a JSON template for an image asset object. */
class ImageAsset {
  /** The height of the asset. */
  core.int height;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#imageAsset.
   */
  core.String kind;
  /** The name of the asset. */
  core.String name;
  /** The URL of the asset. */
  core.String url;
  /** The width of the asset. */
  core.int width;

  ImageAsset();

  ImageAsset.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (height != null) {
      _json["height"] = height;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/** This is a JSON template for the Instance resource. */
class Instance {
  /** URI which shows where a user can acquire this instance. */
  core.String acquisitionUri;
  /** Platform dependent details for Android. */
  InstanceAndroidDetails androidInstance;
  /** Platform dependent details for iOS. */
  InstanceIosDetails iosInstance;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#instance.
   */
  core.String kind;
  /** Localized display name. */
  core.String name;
  /**
   * The platform type.
   * Possible values are:
   * - "ANDROID" - Instance is for Android.
   * - "IOS" - Instance is for iOS
   * - "WEB_APP" - Instance is for Web App.
   */
  core.String platformType;
  /** Flag to show if this game instance supports realtime play. */
  core.bool realtimePlay;
  /** Flag to show if this game instance supports turn based play. */
  core.bool turnBasedPlay;
  /** Platform dependent details for Web. */
  InstanceWebDetails webInstance;

  Instance();

  Instance.fromJson(core.Map _json) {
    if (_json.containsKey("acquisitionUri")) {
      acquisitionUri = _json["acquisitionUri"];
    }
    if (_json.containsKey("androidInstance")) {
      androidInstance = new InstanceAndroidDetails.fromJson(_json["androidInstance"]);
    }
    if (_json.containsKey("iosInstance")) {
      iosInstance = new InstanceIosDetails.fromJson(_json["iosInstance"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("platformType")) {
      platformType = _json["platformType"];
    }
    if (_json.containsKey("realtimePlay")) {
      realtimePlay = _json["realtimePlay"];
    }
    if (_json.containsKey("turnBasedPlay")) {
      turnBasedPlay = _json["turnBasedPlay"];
    }
    if (_json.containsKey("webInstance")) {
      webInstance = new InstanceWebDetails.fromJson(_json["webInstance"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (acquisitionUri != null) {
      _json["acquisitionUri"] = acquisitionUri;
    }
    if (androidInstance != null) {
      _json["androidInstance"] = (androidInstance).toJson();
    }
    if (iosInstance != null) {
      _json["iosInstance"] = (iosInstance).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (platformType != null) {
      _json["platformType"] = platformType;
    }
    if (realtimePlay != null) {
      _json["realtimePlay"] = realtimePlay;
    }
    if (turnBasedPlay != null) {
      _json["turnBasedPlay"] = turnBasedPlay;
    }
    if (webInstance != null) {
      _json["webInstance"] = (webInstance).toJson();
    }
    return _json;
  }
}

/** This is a JSON template for the Android instance details resource. */
class InstanceAndroidDetails {
  /** Flag indicating whether the anti-piracy check is enabled. */
  core.bool enablePiracyCheck;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#instanceAndroidDetails.
   */
  core.String kind;
  /** Android package name which maps to Google Play URL. */
  core.String packageName;
  /** Indicates that this instance is the default for new installations. */
  core.bool preferred;

  InstanceAndroidDetails();

  InstanceAndroidDetails.fromJson(core.Map _json) {
    if (_json.containsKey("enablePiracyCheck")) {
      enablePiracyCheck = _json["enablePiracyCheck"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("packageName")) {
      packageName = _json["packageName"];
    }
    if (_json.containsKey("preferred")) {
      preferred = _json["preferred"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (enablePiracyCheck != null) {
      _json["enablePiracyCheck"] = enablePiracyCheck;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (packageName != null) {
      _json["packageName"] = packageName;
    }
    if (preferred != null) {
      _json["preferred"] = preferred;
    }
    return _json;
  }
}

/** This is a JSON template for the iOS details resource. */
class InstanceIosDetails {
  /** Bundle identifier. */
  core.String bundleIdentifier;
  /** iTunes App ID. */
  core.String itunesAppId;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#instanceIosDetails.
   */
  core.String kind;
  /**
   * Indicates that this instance is the default for new installations on iPad
   * devices.
   */
  core.bool preferredForIpad;
  /**
   * Indicates that this instance is the default for new installations on iPhone
   * devices.
   */
  core.bool preferredForIphone;
  /** Flag to indicate if this instance supports iPad. */
  core.bool supportIpad;
  /** Flag to indicate if this instance supports iPhone. */
  core.bool supportIphone;

  InstanceIosDetails();

  InstanceIosDetails.fromJson(core.Map _json) {
    if (_json.containsKey("bundleIdentifier")) {
      bundleIdentifier = _json["bundleIdentifier"];
    }
    if (_json.containsKey("itunesAppId")) {
      itunesAppId = _json["itunesAppId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("preferredForIpad")) {
      preferredForIpad = _json["preferredForIpad"];
    }
    if (_json.containsKey("preferredForIphone")) {
      preferredForIphone = _json["preferredForIphone"];
    }
    if (_json.containsKey("supportIpad")) {
      supportIpad = _json["supportIpad"];
    }
    if (_json.containsKey("supportIphone")) {
      supportIphone = _json["supportIphone"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bundleIdentifier != null) {
      _json["bundleIdentifier"] = bundleIdentifier;
    }
    if (itunesAppId != null) {
      _json["itunesAppId"] = itunesAppId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (preferredForIpad != null) {
      _json["preferredForIpad"] = preferredForIpad;
    }
    if (preferredForIphone != null) {
      _json["preferredForIphone"] = preferredForIphone;
    }
    if (supportIpad != null) {
      _json["supportIpad"] = supportIpad;
    }
    if (supportIphone != null) {
      _json["supportIphone"] = supportIphone;
    }
    return _json;
  }
}

/** This is a JSON template for the Web details resource. */
class InstanceWebDetails {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#instanceWebDetails.
   */
  core.String kind;
  /** Launch URL for the game. */
  core.String launchUrl;
  /** Indicates that this instance is the default for new installations. */
  core.bool preferred;

  InstanceWebDetails();

  InstanceWebDetails.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("launchUrl")) {
      launchUrl = _json["launchUrl"];
    }
    if (_json.containsKey("preferred")) {
      preferred = _json["preferred"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (launchUrl != null) {
      _json["launchUrl"] = launchUrl;
    }
    if (preferred != null) {
      _json["preferred"] = preferred;
    }
    return _json;
  }
}

/** This is a JSON template for the Leaderboard resource. */
class Leaderboard {
  /** The icon for the leaderboard. */
  core.String iconUrl;
  /** The leaderboard ID. */
  core.String id;
  /**
   * Indicates whether the icon image being returned is a default image, or is
   * game-provided.
   */
  core.bool isIconUrlDefault;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#leaderboard.
   */
  core.String kind;
  /** The name of the leaderboard. */
  core.String name;
  /**
   * How scores are ordered.
   * Possible values are:
   * - "LARGER_IS_BETTER" - Larger values are better; scores are sorted in
   * descending order.
   * - "SMALLER_IS_BETTER" - Smaller values are better; scores are sorted in
   * ascending order.
   */
  core.String order;

  Leaderboard();

  Leaderboard.fromJson(core.Map _json) {
    if (_json.containsKey("iconUrl")) {
      iconUrl = _json["iconUrl"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("isIconUrlDefault")) {
      isIconUrlDefault = _json["isIconUrlDefault"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("order")) {
      order = _json["order"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (iconUrl != null) {
      _json["iconUrl"] = iconUrl;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (isIconUrlDefault != null) {
      _json["isIconUrlDefault"] = isIconUrlDefault;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (order != null) {
      _json["order"] = order;
    }
    return _json;
  }
}

/** This is a JSON template for the Leaderboard Entry resource. */
class LeaderboardEntry {
  /** The localized string for the numerical value of this score. */
  core.String formattedScore;
  /** The localized string for the rank of this score for this leaderboard. */
  core.String formattedScoreRank;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#leaderboardEntry.
   */
  core.String kind;
  /** The player who holds this score. */
  Player player;
  /** The rank of this score for this leaderboard. */
  core.String scoreRank;
  /**
   * Additional information about the score. Values must contain no more than 64
   * URI-safe characters as defined by section 2.3 of RFC 3986.
   */
  core.String scoreTag;
  /** The numerical value of this score. */
  core.String scoreValue;
  /**
   * The time span of this high score.
   * Possible values are:
   * - "ALL_TIME" - The score is an all-time high score.
   * - "WEEKLY" - The score is a weekly high score.
   * - "DAILY" - The score is a daily high score.
   */
  core.String timeSpan;
  /**
   * The timestamp at which this score was recorded, in milliseconds since the
   * epoch in UTC.
   */
  core.String writeTimestampMillis;

  LeaderboardEntry();

  LeaderboardEntry.fromJson(core.Map _json) {
    if (_json.containsKey("formattedScore")) {
      formattedScore = _json["formattedScore"];
    }
    if (_json.containsKey("formattedScoreRank")) {
      formattedScoreRank = _json["formattedScoreRank"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("player")) {
      player = new Player.fromJson(_json["player"]);
    }
    if (_json.containsKey("scoreRank")) {
      scoreRank = _json["scoreRank"];
    }
    if (_json.containsKey("scoreTag")) {
      scoreTag = _json["scoreTag"];
    }
    if (_json.containsKey("scoreValue")) {
      scoreValue = _json["scoreValue"];
    }
    if (_json.containsKey("timeSpan")) {
      timeSpan = _json["timeSpan"];
    }
    if (_json.containsKey("writeTimestampMillis")) {
      writeTimestampMillis = _json["writeTimestampMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formattedScore != null) {
      _json["formattedScore"] = formattedScore;
    }
    if (formattedScoreRank != null) {
      _json["formattedScoreRank"] = formattedScoreRank;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (player != null) {
      _json["player"] = (player).toJson();
    }
    if (scoreRank != null) {
      _json["scoreRank"] = scoreRank;
    }
    if (scoreTag != null) {
      _json["scoreTag"] = scoreTag;
    }
    if (scoreValue != null) {
      _json["scoreValue"] = scoreValue;
    }
    if (timeSpan != null) {
      _json["timeSpan"] = timeSpan;
    }
    if (writeTimestampMillis != null) {
      _json["writeTimestampMillis"] = writeTimestampMillis;
    }
    return _json;
  }
}

/** This is a JSON template for a list of leaderboard objects. */
class LeaderboardListResponse {
  /** The leaderboards. */
  core.List<Leaderboard> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#leaderboardListResponse.
   */
  core.String kind;
  /** Token corresponding to the next page of results. */
  core.String nextPageToken;

  LeaderboardListResponse();

  LeaderboardListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Leaderboard.fromJson(value)).toList();
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

/** This is a JSON template for a score rank in a leaderboard. */
class LeaderboardScoreRank {
  /** The number of scores in the leaderboard as a string. */
  core.String formattedNumScores;
  /** The rank in the leaderboard as a string. */
  core.String formattedRank;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#leaderboardScoreRank.
   */
  core.String kind;
  /** The number of scores in the leaderboard. */
  core.String numScores;
  /** The rank in the leaderboard. */
  core.String rank;

  LeaderboardScoreRank();

  LeaderboardScoreRank.fromJson(core.Map _json) {
    if (_json.containsKey("formattedNumScores")) {
      formattedNumScores = _json["formattedNumScores"];
    }
    if (_json.containsKey("formattedRank")) {
      formattedRank = _json["formattedRank"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("numScores")) {
      numScores = _json["numScores"];
    }
    if (_json.containsKey("rank")) {
      rank = _json["rank"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formattedNumScores != null) {
      _json["formattedNumScores"] = formattedNumScores;
    }
    if (formattedRank != null) {
      _json["formattedRank"] = formattedRank;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (numScores != null) {
      _json["numScores"] = numScores;
    }
    if (rank != null) {
      _json["rank"] = rank;
    }
    return _json;
  }
}

/** This is a JSON template for a ListScores response. */
class LeaderboardScores {
  /** The scores in the leaderboard. */
  core.List<LeaderboardEntry> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#leaderboardScores.
   */
  core.String kind;
  /** The pagination token for the next page of results. */
  core.String nextPageToken;
  /** The total number of scores in the leaderboard. */
  core.String numScores;
  /**
   * The score of the requesting player on the leaderboard. The player's score
   * may appear both here and in the list of scores above. If you are viewing a
   * public leaderboard and the player is not sharing their gameplay information
   * publicly, the scoreRank and formattedScoreRank values will not be present.
   */
  LeaderboardEntry playerScore;
  /** The pagination token for the previous page of results. */
  core.String prevPageToken;

  LeaderboardScores();

  LeaderboardScores.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new LeaderboardEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("numScores")) {
      numScores = _json["numScores"];
    }
    if (_json.containsKey("playerScore")) {
      playerScore = new LeaderboardEntry.fromJson(_json["playerScore"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
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
    if (numScores != null) {
      _json["numScores"] = numScores;
    }
    if (playerScore != null) {
      _json["playerScore"] = (playerScore).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    return _json;
  }
}

/** This is a JSON template for the metagame config resource */
class MetagameConfig {
  /**
   * Current version of the metagame configuration data. When this data is
   * updated, the version number will be increased by one.
   */
  core.int currentVersion;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#metagameConfig.
   */
  core.String kind;
  /** The list of player levels. */
  core.List<PlayerLevel> playerLevels;

  MetagameConfig();

  MetagameConfig.fromJson(core.Map _json) {
    if (_json.containsKey("currentVersion")) {
      currentVersion = _json["currentVersion"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("playerLevels")) {
      playerLevels = _json["playerLevels"].map((value) => new PlayerLevel.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currentVersion != null) {
      _json["currentVersion"] = currentVersion;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (playerLevels != null) {
      _json["playerLevels"] = playerLevels.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** This is a JSON template for network diagnostics reported for a client. */
class NetworkDiagnostics {
  /** The Android network subtype. */
  core.int androidNetworkSubtype;
  /** The Android network type. */
  core.int androidNetworkType;
  /** iOS network type as defined in Reachability.h. */
  core.int iosNetworkType;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#networkDiagnostics.
   */
  core.String kind;
  /**
   * The MCC+MNC code for the client's network connection. On Android:
   * http://developer.android.com/reference/android/telephony/TelephonyManager.html#getNetworkOperator()
   * On iOS, see:
   * https://developer.apple.com/library/ios/documentation/NetworkingInternet/Reference/CTCarrier/Reference/Reference.html
   */
  core.String networkOperatorCode;
  /**
   * The name of the carrier of the client's network connection. On Android:
   * http://developer.android.com/reference/android/telephony/TelephonyManager.html#getNetworkOperatorName()
   * On iOS:
   * https://developer.apple.com/library/ios/documentation/NetworkingInternet/Reference/CTCarrier/Reference/Reference.html#//apple_ref/occ/instp/CTCarrier/carrierName
   */
  core.String networkOperatorName;
  /**
   * The amount of time in milliseconds it took for the client to establish a
   * connection with the XMPP server.
   */
  core.int registrationLatencyMillis;

  NetworkDiagnostics();

  NetworkDiagnostics.fromJson(core.Map _json) {
    if (_json.containsKey("androidNetworkSubtype")) {
      androidNetworkSubtype = _json["androidNetworkSubtype"];
    }
    if (_json.containsKey("androidNetworkType")) {
      androidNetworkType = _json["androidNetworkType"];
    }
    if (_json.containsKey("iosNetworkType")) {
      iosNetworkType = _json["iosNetworkType"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("networkOperatorCode")) {
      networkOperatorCode = _json["networkOperatorCode"];
    }
    if (_json.containsKey("networkOperatorName")) {
      networkOperatorName = _json["networkOperatorName"];
    }
    if (_json.containsKey("registrationLatencyMillis")) {
      registrationLatencyMillis = _json["registrationLatencyMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (androidNetworkSubtype != null) {
      _json["androidNetworkSubtype"] = androidNetworkSubtype;
    }
    if (androidNetworkType != null) {
      _json["androidNetworkType"] = androidNetworkType;
    }
    if (iosNetworkType != null) {
      _json["iosNetworkType"] = iosNetworkType;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (networkOperatorCode != null) {
      _json["networkOperatorCode"] = networkOperatorCode;
    }
    if (networkOperatorName != null) {
      _json["networkOperatorName"] = networkOperatorName;
    }
    if (registrationLatencyMillis != null) {
      _json["registrationLatencyMillis"] = registrationLatencyMillis;
    }
    return _json;
  }
}

/** This is a JSON template for a result for a match participant. */
class ParticipantResult {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#participantResult.
   */
  core.String kind;
  /** The ID of the participant. */
  core.String participantId;
  /**
   * The placement or ranking of the participant in the match results; a number
   * from one to the number of participants in the match. Multiple participants
   * may have the same placing value in case of a type.
   */
  core.int placing;
  /**
   * The result of the participant for this match.
   * Possible values are:
   * - "MATCH_RESULT_WIN" - The participant won the match.
   * - "MATCH_RESULT_LOSS" - The participant lost the match.
   * - "MATCH_RESULT_TIE" - The participant tied the match.
   * - "MATCH_RESULT_NONE" - There was no winner for the match (nobody wins or
   * loses this kind of game.)
   * - "MATCH_RESULT_DISCONNECT" - The participant disconnected / left during
   * the match.
   * - "MATCH_RESULT_DISAGREED" - Different clients reported different results
   * for this participant.
   */
  core.String result;

  ParticipantResult();

  ParticipantResult.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("participantId")) {
      participantId = _json["participantId"];
    }
    if (_json.containsKey("placing")) {
      placing = _json["placing"];
    }
    if (_json.containsKey("result")) {
      result = _json["result"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (participantId != null) {
      _json["participantId"] = participantId;
    }
    if (placing != null) {
      _json["placing"] = placing;
    }
    if (result != null) {
      _json["result"] = result;
    }
    return _json;
  }
}

/** This is a JSON template for peer channel diagnostics. */
class PeerChannelDiagnostics {
  /** Number of bytes received. */
  AggregateStats bytesReceived;
  /** Number of bytes sent. */
  AggregateStats bytesSent;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#peerChannelDiagnostics.
   */
  core.String kind;
  /** Number of messages lost. */
  core.int numMessagesLost;
  /** Number of messages received. */
  core.int numMessagesReceived;
  /** Number of messages sent. */
  core.int numMessagesSent;
  /** Number of send failures. */
  core.int numSendFailures;
  /** Roundtrip latency stats in milliseconds. */
  AggregateStats roundtripLatencyMillis;

  PeerChannelDiagnostics();

  PeerChannelDiagnostics.fromJson(core.Map _json) {
    if (_json.containsKey("bytesReceived")) {
      bytesReceived = new AggregateStats.fromJson(_json["bytesReceived"]);
    }
    if (_json.containsKey("bytesSent")) {
      bytesSent = new AggregateStats.fromJson(_json["bytesSent"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("numMessagesLost")) {
      numMessagesLost = _json["numMessagesLost"];
    }
    if (_json.containsKey("numMessagesReceived")) {
      numMessagesReceived = _json["numMessagesReceived"];
    }
    if (_json.containsKey("numMessagesSent")) {
      numMessagesSent = _json["numMessagesSent"];
    }
    if (_json.containsKey("numSendFailures")) {
      numSendFailures = _json["numSendFailures"];
    }
    if (_json.containsKey("roundtripLatencyMillis")) {
      roundtripLatencyMillis = new AggregateStats.fromJson(_json["roundtripLatencyMillis"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bytesReceived != null) {
      _json["bytesReceived"] = (bytesReceived).toJson();
    }
    if (bytesSent != null) {
      _json["bytesSent"] = (bytesSent).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (numMessagesLost != null) {
      _json["numMessagesLost"] = numMessagesLost;
    }
    if (numMessagesReceived != null) {
      _json["numMessagesReceived"] = numMessagesReceived;
    }
    if (numMessagesSent != null) {
      _json["numMessagesSent"] = numMessagesSent;
    }
    if (numSendFailures != null) {
      _json["numSendFailures"] = numSendFailures;
    }
    if (roundtripLatencyMillis != null) {
      _json["roundtripLatencyMillis"] = (roundtripLatencyMillis).toJson();
    }
    return _json;
  }
}

/** This is a JSON template for peer session diagnostics. */
class PeerSessionDiagnostics {
  /** Connected time in milliseconds. */
  core.String connectedTimestampMillis;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#peerSessionDiagnostics.
   */
  core.String kind;
  /** The participant ID of the peer. */
  core.String participantId;
  /** Reliable channel diagnostics. */
  PeerChannelDiagnostics reliableChannel;
  /** Unreliable channel diagnostics. */
  PeerChannelDiagnostics unreliableChannel;

  PeerSessionDiagnostics();

  PeerSessionDiagnostics.fromJson(core.Map _json) {
    if (_json.containsKey("connectedTimestampMillis")) {
      connectedTimestampMillis = _json["connectedTimestampMillis"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("participantId")) {
      participantId = _json["participantId"];
    }
    if (_json.containsKey("reliableChannel")) {
      reliableChannel = new PeerChannelDiagnostics.fromJson(_json["reliableChannel"]);
    }
    if (_json.containsKey("unreliableChannel")) {
      unreliableChannel = new PeerChannelDiagnostics.fromJson(_json["unreliableChannel"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (connectedTimestampMillis != null) {
      _json["connectedTimestampMillis"] = connectedTimestampMillis;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (participantId != null) {
      _json["participantId"] = participantId;
    }
    if (reliableChannel != null) {
      _json["reliableChannel"] = (reliableChannel).toJson();
    }
    if (unreliableChannel != null) {
      _json["unreliableChannel"] = (unreliableChannel).toJson();
    }
    return _json;
  }
}

/**
 * This is a JSON template for metadata about a player playing a game with the
 * currently authenticated user.
 */
class Played {
  /**
   * True if the player was auto-matched with the currently authenticated user.
   */
  core.bool autoMatched;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#played.
   */
  core.String kind;
  /**
   * The last time the player played the game in milliseconds since the epoch in
   * UTC.
   */
  core.String timeMillis;

  Played();

  Played.fromJson(core.Map _json) {
    if (_json.containsKey("autoMatched")) {
      autoMatched = _json["autoMatched"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("timeMillis")) {
      timeMillis = _json["timeMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (autoMatched != null) {
      _json["autoMatched"] = autoMatched;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (timeMillis != null) {
      _json["timeMillis"] = timeMillis;
    }
    return _json;
  }
}

/**
 * An object representation of the individual components of the player's name.
 * For some players, these fields may not be present.
 */
class PlayerName {
  /**
   * The family name of this player. In some places, this is known as the last
   * name.
   */
  core.String familyName;
  /**
   * The given name of this player. In some places, this is known as the first
   * name.
   */
  core.String givenName;

  PlayerName();

  PlayerName.fromJson(core.Map _json) {
    if (_json.containsKey("familyName")) {
      familyName = _json["familyName"];
    }
    if (_json.containsKey("givenName")) {
      givenName = _json["givenName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (familyName != null) {
      _json["familyName"] = familyName;
    }
    if (givenName != null) {
      _json["givenName"] = givenName;
    }
    return _json;
  }
}

/** This is a JSON template for a Player resource. */
class Player {
  /** The base URL for the image that represents the player. */
  core.String avatarImageUrl;
  /** The url to the landscape mode player banner image. */
  core.String bannerUrlLandscape;
  /** The url to the portrait mode player banner image. */
  core.String bannerUrlPortrait;
  /** The name to display for the player. */
  core.String displayName;
  /**
   * An object to represent Play Game experience information for the player.
   */
  PlayerExperienceInfo experienceInfo;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#player.
   */
  core.String kind;
  /**
   * Details about the last time this player played a multiplayer game with the
   * currently authenticated player. Populated for PLAYED_WITH player collection
   * members.
   */
  Played lastPlayedWith;
  /**
   * An object representation of the individual components of the player's name.
   * For some players, these fields may not be present.
   */
  PlayerName name;
  /**
   * The player ID that was used for this player the first time they signed into
   * the game in question. This is only populated for calls to player.get for
   * the requesting player, only if the player ID has subsequently changed, and
   * only to clients that support remapping player IDs.
   */
  core.String originalPlayerId;
  /** The ID of the player. */
  core.String playerId;
  /**
   * The player's profile settings. Controls whether or not the player's profile
   * is visible to other players.
   */
  ProfileSettings profileSettings;
  /** The player's title rewarded for their game activities. */
  core.String title;

  Player();

  Player.fromJson(core.Map _json) {
    if (_json.containsKey("avatarImageUrl")) {
      avatarImageUrl = _json["avatarImageUrl"];
    }
    if (_json.containsKey("bannerUrlLandscape")) {
      bannerUrlLandscape = _json["bannerUrlLandscape"];
    }
    if (_json.containsKey("bannerUrlPortrait")) {
      bannerUrlPortrait = _json["bannerUrlPortrait"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("experienceInfo")) {
      experienceInfo = new PlayerExperienceInfo.fromJson(_json["experienceInfo"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastPlayedWith")) {
      lastPlayedWith = new Played.fromJson(_json["lastPlayedWith"]);
    }
    if (_json.containsKey("name")) {
      name = new PlayerName.fromJson(_json["name"]);
    }
    if (_json.containsKey("originalPlayerId")) {
      originalPlayerId = _json["originalPlayerId"];
    }
    if (_json.containsKey("playerId")) {
      playerId = _json["playerId"];
    }
    if (_json.containsKey("profileSettings")) {
      profileSettings = new ProfileSettings.fromJson(_json["profileSettings"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (avatarImageUrl != null) {
      _json["avatarImageUrl"] = avatarImageUrl;
    }
    if (bannerUrlLandscape != null) {
      _json["bannerUrlLandscape"] = bannerUrlLandscape;
    }
    if (bannerUrlPortrait != null) {
      _json["bannerUrlPortrait"] = bannerUrlPortrait;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (experienceInfo != null) {
      _json["experienceInfo"] = (experienceInfo).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastPlayedWith != null) {
      _json["lastPlayedWith"] = (lastPlayedWith).toJson();
    }
    if (name != null) {
      _json["name"] = (name).toJson();
    }
    if (originalPlayerId != null) {
      _json["originalPlayerId"] = originalPlayerId;
    }
    if (playerId != null) {
      _json["playerId"] = playerId;
    }
    if (profileSettings != null) {
      _json["profileSettings"] = (profileSettings).toJson();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** This is a JSON template for an achievement object. */
class PlayerAchievement {
  /**
   * The state of the achievement.
   * Possible values are:
   * - "HIDDEN" - Achievement is hidden.
   * - "REVEALED" - Achievement is revealed.
   * - "UNLOCKED" - Achievement is unlocked.
   */
  core.String achievementState;
  /** The current steps for an incremental achievement. */
  core.int currentSteps;
  /**
   * Experience points earned for the achievement. This field is absent for
   * achievements that have not yet been unlocked and 0 for achievements that
   * have been unlocked by testers but that are unpublished.
   */
  core.String experiencePoints;
  /** The current steps for an incremental achievement as a string. */
  core.String formattedCurrentStepsString;
  /** The ID of the achievement. */
  core.String id;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerAchievement.
   */
  core.String kind;
  /** The timestamp of the last modification to this achievement's state. */
  core.String lastUpdatedTimestamp;

  PlayerAchievement();

  PlayerAchievement.fromJson(core.Map _json) {
    if (_json.containsKey("achievementState")) {
      achievementState = _json["achievementState"];
    }
    if (_json.containsKey("currentSteps")) {
      currentSteps = _json["currentSteps"];
    }
    if (_json.containsKey("experiencePoints")) {
      experiencePoints = _json["experiencePoints"];
    }
    if (_json.containsKey("formattedCurrentStepsString")) {
      formattedCurrentStepsString = _json["formattedCurrentStepsString"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastUpdatedTimestamp")) {
      lastUpdatedTimestamp = _json["lastUpdatedTimestamp"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (achievementState != null) {
      _json["achievementState"] = achievementState;
    }
    if (currentSteps != null) {
      _json["currentSteps"] = currentSteps;
    }
    if (experiencePoints != null) {
      _json["experiencePoints"] = experiencePoints;
    }
    if (formattedCurrentStepsString != null) {
      _json["formattedCurrentStepsString"] = formattedCurrentStepsString;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastUpdatedTimestamp != null) {
      _json["lastUpdatedTimestamp"] = lastUpdatedTimestamp;
    }
    return _json;
  }
}

/** This is a JSON template for a list of achievement objects. */
class PlayerAchievementListResponse {
  /** The achievements. */
  core.List<PlayerAchievement> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerAchievementListResponse.
   */
  core.String kind;
  /** Token corresponding to the next page of results. */
  core.String nextPageToken;

  PlayerAchievementListResponse();

  PlayerAchievementListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new PlayerAchievement.fromJson(value)).toList();
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

/** This is a JSON template for an event status resource. */
class PlayerEvent {
  /** The ID of the event definition. */
  core.String definitionId;
  /**
   * The current number of times this event has occurred, as a string. The
   * formatting of this string depends on the configuration of your event in the
   * Play Games Developer Console.
   */
  core.String formattedNumEvents;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerEvent.
   */
  core.String kind;
  /** The current number of times this event has occurred. */
  core.String numEvents;
  /** The ID of the player. */
  core.String playerId;

  PlayerEvent();

  PlayerEvent.fromJson(core.Map _json) {
    if (_json.containsKey("definitionId")) {
      definitionId = _json["definitionId"];
    }
    if (_json.containsKey("formattedNumEvents")) {
      formattedNumEvents = _json["formattedNumEvents"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("numEvents")) {
      numEvents = _json["numEvents"];
    }
    if (_json.containsKey("playerId")) {
      playerId = _json["playerId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (definitionId != null) {
      _json["definitionId"] = definitionId;
    }
    if (formattedNumEvents != null) {
      _json["formattedNumEvents"] = formattedNumEvents;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (numEvents != null) {
      _json["numEvents"] = numEvents;
    }
    if (playerId != null) {
      _json["playerId"] = playerId;
    }
    return _json;
  }
}

/** This is a JSON template for a ListByPlayer response. */
class PlayerEventListResponse {
  /** The player events. */
  core.List<PlayerEvent> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerEventListResponse.
   */
  core.String kind;
  /** The pagination token for the next page of results. */
  core.String nextPageToken;

  PlayerEventListResponse();

  PlayerEventListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new PlayerEvent.fromJson(value)).toList();
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

/**
 * This is a JSON template for 1P/3P metadata about the player's experience.
 */
class PlayerExperienceInfo {
  /** The current number of experience points for the player. */
  core.String currentExperiencePoints;
  /** The current level of the player. */
  PlayerLevel currentLevel;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerExperienceInfo.
   */
  core.String kind;
  /**
   * The timestamp when the player was leveled up, in millis since Unix epoch
   * UTC.
   */
  core.String lastLevelUpTimestampMillis;
  /**
   * The next level of the player. If the current level is the maximum level,
   * this should be same as the current level.
   */
  PlayerLevel nextLevel;

  PlayerExperienceInfo();

  PlayerExperienceInfo.fromJson(core.Map _json) {
    if (_json.containsKey("currentExperiencePoints")) {
      currentExperiencePoints = _json["currentExperiencePoints"];
    }
    if (_json.containsKey("currentLevel")) {
      currentLevel = new PlayerLevel.fromJson(_json["currentLevel"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastLevelUpTimestampMillis")) {
      lastLevelUpTimestampMillis = _json["lastLevelUpTimestampMillis"];
    }
    if (_json.containsKey("nextLevel")) {
      nextLevel = new PlayerLevel.fromJson(_json["nextLevel"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currentExperiencePoints != null) {
      _json["currentExperiencePoints"] = currentExperiencePoints;
    }
    if (currentLevel != null) {
      _json["currentLevel"] = (currentLevel).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastLevelUpTimestampMillis != null) {
      _json["lastLevelUpTimestampMillis"] = lastLevelUpTimestampMillis;
    }
    if (nextLevel != null) {
      _json["nextLevel"] = (nextLevel).toJson();
    }
    return _json;
  }
}

/** This is a JSON template for a player leaderboard score object. */
class PlayerLeaderboardScore {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerLeaderboardScore.
   */
  core.String kind;
  /** The ID of the leaderboard this score is in. */
  core.String leaderboardId;
  /**
   * The public rank of the score in this leaderboard. This object will not be
   * present if the user is not sharing their scores publicly.
   */
  LeaderboardScoreRank publicRank;
  /** The formatted value of this score. */
  core.String scoreString;
  /**
   * Additional information about the score. Values must contain no more than 64
   * URI-safe characters as defined by section 2.3 of RFC 3986.
   */
  core.String scoreTag;
  /** The numerical value of this score. */
  core.String scoreValue;
  /** The social rank of the score in this leaderboard. */
  LeaderboardScoreRank socialRank;
  /**
   * The time span of this score.
   * Possible values are:
   * - "ALL_TIME" - The score is an all-time score.
   * - "WEEKLY" - The score is a weekly score.
   * - "DAILY" - The score is a daily score.
   */
  core.String timeSpan;
  /**
   * The timestamp at which this score was recorded, in milliseconds since the
   * epoch in UTC.
   */
  core.String writeTimestamp;

  PlayerLeaderboardScore();

  PlayerLeaderboardScore.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("leaderboard_id")) {
      leaderboardId = _json["leaderboard_id"];
    }
    if (_json.containsKey("publicRank")) {
      publicRank = new LeaderboardScoreRank.fromJson(_json["publicRank"]);
    }
    if (_json.containsKey("scoreString")) {
      scoreString = _json["scoreString"];
    }
    if (_json.containsKey("scoreTag")) {
      scoreTag = _json["scoreTag"];
    }
    if (_json.containsKey("scoreValue")) {
      scoreValue = _json["scoreValue"];
    }
    if (_json.containsKey("socialRank")) {
      socialRank = new LeaderboardScoreRank.fromJson(_json["socialRank"]);
    }
    if (_json.containsKey("timeSpan")) {
      timeSpan = _json["timeSpan"];
    }
    if (_json.containsKey("writeTimestamp")) {
      writeTimestamp = _json["writeTimestamp"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (leaderboardId != null) {
      _json["leaderboard_id"] = leaderboardId;
    }
    if (publicRank != null) {
      _json["publicRank"] = (publicRank).toJson();
    }
    if (scoreString != null) {
      _json["scoreString"] = scoreString;
    }
    if (scoreTag != null) {
      _json["scoreTag"] = scoreTag;
    }
    if (scoreValue != null) {
      _json["scoreValue"] = scoreValue;
    }
    if (socialRank != null) {
      _json["socialRank"] = (socialRank).toJson();
    }
    if (timeSpan != null) {
      _json["timeSpan"] = timeSpan;
    }
    if (writeTimestamp != null) {
      _json["writeTimestamp"] = writeTimestamp;
    }
    return _json;
  }
}

/** This is a JSON template for a list of player leaderboard scores. */
class PlayerLeaderboardScoreListResponse {
  /** The leaderboard scores. */
  core.List<PlayerLeaderboardScore> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerLeaderboardScoreListResponse.
   */
  core.String kind;
  /** The pagination token for the next page of results. */
  core.String nextPageToken;
  /** The Player resources for the owner of this score. */
  Player player;

  PlayerLeaderboardScoreListResponse();

  PlayerLeaderboardScoreListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new PlayerLeaderboardScore.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("player")) {
      player = new Player.fromJson(_json["player"]);
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
    if (player != null) {
      _json["player"] = (player).toJson();
    }
    return _json;
  }
}

/** This is a JSON template for 1P/3P metadata about a user's level. */
class PlayerLevel {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerLevel.
   */
  core.String kind;
  /** The level for the user. */
  core.int level;
  /** The maximum experience points for this level. */
  core.String maxExperiencePoints;
  /** The minimum experience points for this level. */
  core.String minExperiencePoints;

  PlayerLevel();

  PlayerLevel.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("level")) {
      level = _json["level"];
    }
    if (_json.containsKey("maxExperiencePoints")) {
      maxExperiencePoints = _json["maxExperiencePoints"];
    }
    if (_json.containsKey("minExperiencePoints")) {
      minExperiencePoints = _json["minExperiencePoints"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (level != null) {
      _json["level"] = level;
    }
    if (maxExperiencePoints != null) {
      _json["maxExperiencePoints"] = maxExperiencePoints;
    }
    if (minExperiencePoints != null) {
      _json["minExperiencePoints"] = minExperiencePoints;
    }
    return _json;
  }
}

/** This is a JSON template for a third party player list response. */
class PlayerListResponse {
  /** The players. */
  core.List<Player> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerListResponse.
   */
  core.String kind;
  /** Token corresponding to the next page of results. */
  core.String nextPageToken;

  PlayerListResponse();

  PlayerListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Player.fromJson(value)).toList();
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

/** This is a JSON template for a player score. */
class PlayerScore {
  /** The formatted score for this player score. */
  core.String formattedScore;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerScore.
   */
  core.String kind;
  /** The numerical value for this player score. */
  core.String score;
  /**
   * Additional information about this score. Values will contain no more than
   * 64 URI-safe characters as defined by section 2.3 of RFC 3986.
   */
  core.String scoreTag;
  /**
   * The time span for this player score.
   * Possible values are:
   * - "ALL_TIME" - The score is an all-time score.
   * - "WEEKLY" - The score is a weekly score.
   * - "DAILY" - The score is a daily score.
   */
  core.String timeSpan;

  PlayerScore();

  PlayerScore.fromJson(core.Map _json) {
    if (_json.containsKey("formattedScore")) {
      formattedScore = _json["formattedScore"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("score")) {
      score = _json["score"];
    }
    if (_json.containsKey("scoreTag")) {
      scoreTag = _json["scoreTag"];
    }
    if (_json.containsKey("timeSpan")) {
      timeSpan = _json["timeSpan"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formattedScore != null) {
      _json["formattedScore"] = formattedScore;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (score != null) {
      _json["score"] = score;
    }
    if (scoreTag != null) {
      _json["scoreTag"] = scoreTag;
    }
    if (timeSpan != null) {
      _json["timeSpan"] = timeSpan;
    }
    return _json;
  }
}

/** This is a JSON template for a list of score submission statuses. */
class PlayerScoreListResponse {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerScoreListResponse.
   */
  core.String kind;
  /** The score submissions statuses. */
  core.List<PlayerScoreResponse> submittedScores;

  PlayerScoreListResponse();

  PlayerScoreListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("submittedScores")) {
      submittedScores = _json["submittedScores"].map((value) => new PlayerScoreResponse.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (submittedScores != null) {
      _json["submittedScores"] = submittedScores.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** This is a JSON template for a list of leaderboard entry resources. */
class PlayerScoreResponse {
  /**
   * The time spans where the submitted score is better than the existing score
   * for that time span.
   * Possible values are:
   * - "ALL_TIME" - The score is an all-time score.
   * - "WEEKLY" - The score is a weekly score.
   * - "DAILY" - The score is a daily score.
   */
  core.List<core.String> beatenScoreTimeSpans;
  /** The formatted value of the submitted score. */
  core.String formattedScore;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerScoreResponse.
   */
  core.String kind;
  /** The leaderboard ID that this score was submitted to. */
  core.String leaderboardId;
  /**
   * Additional information about this score. Values will contain no more than
   * 64 URI-safe characters as defined by section 2.3 of RFC 3986.
   */
  core.String scoreTag;
  /**
   * The scores in time spans that have not been beaten. As an example, the
   * submitted score may be better than the player's DAILY score, but not better
   * than the player's scores for the WEEKLY or ALL_TIME time spans.
   */
  core.List<PlayerScore> unbeatenScores;

  PlayerScoreResponse();

  PlayerScoreResponse.fromJson(core.Map _json) {
    if (_json.containsKey("beatenScoreTimeSpans")) {
      beatenScoreTimeSpans = _json["beatenScoreTimeSpans"];
    }
    if (_json.containsKey("formattedScore")) {
      formattedScore = _json["formattedScore"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("leaderboardId")) {
      leaderboardId = _json["leaderboardId"];
    }
    if (_json.containsKey("scoreTag")) {
      scoreTag = _json["scoreTag"];
    }
    if (_json.containsKey("unbeatenScores")) {
      unbeatenScores = _json["unbeatenScores"].map((value) => new PlayerScore.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (beatenScoreTimeSpans != null) {
      _json["beatenScoreTimeSpans"] = beatenScoreTimeSpans;
    }
    if (formattedScore != null) {
      _json["formattedScore"] = formattedScore;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (leaderboardId != null) {
      _json["leaderboardId"] = leaderboardId;
    }
    if (scoreTag != null) {
      _json["scoreTag"] = scoreTag;
    }
    if (unbeatenScores != null) {
      _json["unbeatenScores"] = unbeatenScores.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** This is a JSON template for a list of score submission requests */
class PlayerScoreSubmissionList {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#playerScoreSubmissionList.
   */
  core.String kind;
  /** The score submissions. */
  core.List<ScoreSubmission> scores;

  PlayerScoreSubmissionList();

  PlayerScoreSubmissionList.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("scores")) {
      scores = _json["scores"].map((value) => new ScoreSubmission.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (scores != null) {
      _json["scores"] = scores.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** This is a JSON template for profile settings */
class ProfileSettings {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#profileSettings.
   */
  core.String kind;
  /**
   * The player's current profile visibility. This field is visible to both 1P
   * and 3P APIs.
   */
  core.bool profileVisible;

  ProfileSettings();

  ProfileSettings.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("profileVisible")) {
      profileVisible = _json["profileVisible"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (profileVisible != null) {
      _json["profileVisible"] = profileVisible;
    }
    return _json;
  }
}

/** This is a JSON template for a push token resource. */
class PushToken {
  /**
   * The revision of the client SDK used by your application, in the same format
   * that's used by revisions.check. Used to send backward compatible messages.
   * Format: [PLATFORM_TYPE]:[VERSION_NUMBER]. Possible values of PLATFORM_TYPE
   * are:
   * - IOS - Push token is for iOS
   */
  core.String clientRevision;
  /** Unique identifier for this push token. */
  PushTokenId id;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#pushToken.
   */
  core.String kind;
  /**
   * The preferred language for notifications that are sent using this token.
   */
  core.String language;

  PushToken();

  PushToken.fromJson(core.Map _json) {
    if (_json.containsKey("clientRevision")) {
      clientRevision = _json["clientRevision"];
    }
    if (_json.containsKey("id")) {
      id = new PushTokenId.fromJson(_json["id"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clientRevision != null) {
      _json["clientRevision"] = clientRevision;
    }
    if (id != null) {
      _json["id"] = (id).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (language != null) {
      _json["language"] = language;
    }
    return _json;
  }
}

/** A push token ID for iOS devices. */
class PushTokenIdIos {
  /**
   * Device token supplied by an iOS system call to register for remote
   * notifications. Encode this field as web-safe base64.
   */
  core.String apnsDeviceToken;
  core.List<core.int> get apnsDeviceTokenAsBytes {
    return convert.BASE64.decode(apnsDeviceToken);
  }

  void set apnsDeviceTokenAsBytes(core.List<core.int> _bytes) {
    apnsDeviceToken = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * Indicates whether this token should be used for the production or sandbox
   * APNS server.
   */
  core.String apnsEnvironment;

  PushTokenIdIos();

  PushTokenIdIos.fromJson(core.Map _json) {
    if (_json.containsKey("apns_device_token")) {
      apnsDeviceToken = _json["apns_device_token"];
    }
    if (_json.containsKey("apns_environment")) {
      apnsEnvironment = _json["apns_environment"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (apnsDeviceToken != null) {
      _json["apns_device_token"] = apnsDeviceToken;
    }
    if (apnsEnvironment != null) {
      _json["apns_environment"] = apnsEnvironment;
    }
    return _json;
  }
}

/** This is a JSON template for a push token ID resource. */
class PushTokenId {
  /** A push token ID for iOS devices. */
  PushTokenIdIos ios;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#pushTokenId.
   */
  core.String kind;

  PushTokenId();

  PushTokenId.fromJson(core.Map _json) {
    if (_json.containsKey("ios")) {
      ios = new PushTokenIdIos.fromJson(_json["ios"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (ios != null) {
      _json["ios"] = (ios).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** This is a JSON template for a Quest resource. */
class Quest {
  /**
   * The timestamp at which the user accepted the quest in milliseconds since
   * the epoch in UTC. Only present if the player has accepted the quest.
   */
  core.String acceptedTimestampMillis;
  /** The ID of the application this quest is part of. */
  core.String applicationId;
  /** The banner image URL for the quest. */
  core.String bannerUrl;
  /** The description of the quest. */
  core.String description;
  /**
   * The timestamp at which the quest ceases to be active in milliseconds since
   * the epoch in UTC.
   */
  core.String endTimestampMillis;
  /** The icon image URL for the quest. */
  core.String iconUrl;
  /** The ID of the quest. */
  core.String id;
  /**
   * Indicates whether the banner image being returned is a default image, or is
   * game-provided.
   */
  core.bool isDefaultBannerUrl;
  /**
   * Indicates whether the icon image being returned is a default image, or is
   * game-provided.
   */
  core.bool isDefaultIconUrl;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#quest.
   */
  core.String kind;
  /**
   * The timestamp at which the quest was last updated by the user in
   * milliseconds since the epoch in UTC. Only present if the player has
   * accepted the quest.
   */
  core.String lastUpdatedTimestampMillis;
  /** The quest milestones. */
  core.List<QuestMilestone> milestones;
  /** The name of the quest. */
  core.String name;
  /**
   * The timestamp at which the user should be notified that the quest will end
   * soon in milliseconds since the epoch in UTC.
   */
  core.String notifyTimestampMillis;
  /**
   * The timestamp at which the quest becomes active in milliseconds since the
   * epoch in UTC.
   */
  core.String startTimestampMillis;
  /**
   * The state of the quest.
   * Possible values are:
   * - "UPCOMING": The quest is upcoming. The user can see the quest, but cannot
   * accept it until it is open.
   * - "OPEN": The quest is currently open and may be accepted at this time.
   * - "ACCEPTED": The user is currently participating in this quest.
   * - "COMPLETED": The user has completed the quest.
   * - "FAILED": The quest was attempted but was not completed before the
   * deadline expired.
   * - "EXPIRED": The quest has expired and was not accepted.
   * - "DELETED": The quest should be deleted from the local database.
   */
  core.String state;

  Quest();

  Quest.fromJson(core.Map _json) {
    if (_json.containsKey("acceptedTimestampMillis")) {
      acceptedTimestampMillis = _json["acceptedTimestampMillis"];
    }
    if (_json.containsKey("applicationId")) {
      applicationId = _json["applicationId"];
    }
    if (_json.containsKey("bannerUrl")) {
      bannerUrl = _json["bannerUrl"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("endTimestampMillis")) {
      endTimestampMillis = _json["endTimestampMillis"];
    }
    if (_json.containsKey("iconUrl")) {
      iconUrl = _json["iconUrl"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("isDefaultBannerUrl")) {
      isDefaultBannerUrl = _json["isDefaultBannerUrl"];
    }
    if (_json.containsKey("isDefaultIconUrl")) {
      isDefaultIconUrl = _json["isDefaultIconUrl"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastUpdatedTimestampMillis")) {
      lastUpdatedTimestampMillis = _json["lastUpdatedTimestampMillis"];
    }
    if (_json.containsKey("milestones")) {
      milestones = _json["milestones"].map((value) => new QuestMilestone.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("notifyTimestampMillis")) {
      notifyTimestampMillis = _json["notifyTimestampMillis"];
    }
    if (_json.containsKey("startTimestampMillis")) {
      startTimestampMillis = _json["startTimestampMillis"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (acceptedTimestampMillis != null) {
      _json["acceptedTimestampMillis"] = acceptedTimestampMillis;
    }
    if (applicationId != null) {
      _json["applicationId"] = applicationId;
    }
    if (bannerUrl != null) {
      _json["bannerUrl"] = bannerUrl;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (endTimestampMillis != null) {
      _json["endTimestampMillis"] = endTimestampMillis;
    }
    if (iconUrl != null) {
      _json["iconUrl"] = iconUrl;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (isDefaultBannerUrl != null) {
      _json["isDefaultBannerUrl"] = isDefaultBannerUrl;
    }
    if (isDefaultIconUrl != null) {
      _json["isDefaultIconUrl"] = isDefaultIconUrl;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastUpdatedTimestampMillis != null) {
      _json["lastUpdatedTimestampMillis"] = lastUpdatedTimestampMillis;
    }
    if (milestones != null) {
      _json["milestones"] = milestones.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (notifyTimestampMillis != null) {
      _json["notifyTimestampMillis"] = notifyTimestampMillis;
    }
    if (startTimestampMillis != null) {
      _json["startTimestampMillis"] = startTimestampMillis;
    }
    if (state != null) {
      _json["state"] = state;
    }
    return _json;
  }
}

/** This is a JSON template for a Quest Criterion Contribution resource. */
class QuestContribution {
  /**
   * The formatted value of the contribution as a string. Format depends on the
   * configuration for the associated event definition in the Play Games
   * Developer Console.
   */
  core.String formattedValue;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#questContribution.
   */
  core.String kind;
  /** The value of the contribution. */
  core.String value;

  QuestContribution();

  QuestContribution.fromJson(core.Map _json) {
    if (_json.containsKey("formattedValue")) {
      formattedValue = _json["formattedValue"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formattedValue != null) {
      _json["formattedValue"] = formattedValue;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** This is a JSON template for a Quest Criterion resource. */
class QuestCriterion {
  /**
   * The total number of times the associated event must be incremented for the
   * player to complete this quest.
   */
  QuestContribution completionContribution;
  /**
   * The number of increments the player has made toward the completion count
   * event increments required to complete the quest. This value will not exceed
   * the completion contribution.
   * There will be no currentContribution until the player has accepted the
   * quest.
   */
  QuestContribution currentContribution;
  /** The ID of the event the criterion corresponds to. */
  core.String eventId;
  /**
   * The value of the event associated with this quest at the time that the
   * quest was accepted. This value may change if event increments that took
   * place before the start of quest are uploaded after the quest starts.
   * There will be no initialPlayerProgress until the player has accepted the
   * quest.
   */
  QuestContribution initialPlayerProgress;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#questCriterion.
   */
  core.String kind;

  QuestCriterion();

  QuestCriterion.fromJson(core.Map _json) {
    if (_json.containsKey("completionContribution")) {
      completionContribution = new QuestContribution.fromJson(_json["completionContribution"]);
    }
    if (_json.containsKey("currentContribution")) {
      currentContribution = new QuestContribution.fromJson(_json["currentContribution"]);
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("initialPlayerProgress")) {
      initialPlayerProgress = new QuestContribution.fromJson(_json["initialPlayerProgress"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (completionContribution != null) {
      _json["completionContribution"] = (completionContribution).toJson();
    }
    if (currentContribution != null) {
      _json["currentContribution"] = (currentContribution).toJson();
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
    }
    if (initialPlayerProgress != null) {
      _json["initialPlayerProgress"] = (initialPlayerProgress).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** This is a JSON template for a list of quest objects. */
class QuestListResponse {
  /** The quests. */
  core.List<Quest> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#questListResponse.
   */
  core.String kind;
  /** Token corresponding to the next page of results. */
  core.String nextPageToken;

  QuestListResponse();

  QuestListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Quest.fromJson(value)).toList();
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

/** This is a JSON template for a Quest Milestone resource. */
class QuestMilestone {
  /**
   * The completion reward data of the milestone, represented as a
   * Base64-encoded string. This is a developer-specified binary blob with size
   * between 0 and 2 KB before encoding.
   */
  core.String completionRewardData;
  core.List<core.int> get completionRewardDataAsBytes {
    return convert.BASE64.decode(completionRewardData);
  }

  void set completionRewardDataAsBytes(core.List<core.int> _bytes) {
    completionRewardData = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** The criteria of the milestone. */
  core.List<QuestCriterion> criteria;
  /** The milestone ID. */
  core.String id;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#questMilestone.
   */
  core.String kind;
  /**
   * The current state of the milestone.
   * Possible values are:
   * - "COMPLETED_NOT_CLAIMED" - The milestone is complete, but has not yet been
   * claimed.
   * - "CLAIMED" - The milestone is complete and has been claimed.
   * - "NOT_COMPLETED" - The milestone has not yet been completed.
   * - "NOT_STARTED" - The milestone is for a quest that has not yet been
   * accepted.
   */
  core.String state;

  QuestMilestone();

  QuestMilestone.fromJson(core.Map _json) {
    if (_json.containsKey("completionRewardData")) {
      completionRewardData = _json["completionRewardData"];
    }
    if (_json.containsKey("criteria")) {
      criteria = _json["criteria"].map((value) => new QuestCriterion.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (completionRewardData != null) {
      _json["completionRewardData"] = completionRewardData;
    }
    if (criteria != null) {
      _json["criteria"] = criteria.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (state != null) {
      _json["state"] = state;
    }
    return _json;
  }
}

/** This is a JSON template for the result of checking a revision. */
class RevisionCheckResponse {
  /**
   * The version of the API this client revision should use when calling API
   * methods.
   */
  core.String apiVersion;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#revisionCheckResponse.
   */
  core.String kind;
  /**
   * The result of the revision check.
   * Possible values are:
   * - "OK" - The revision being used is current.
   * - "DEPRECATED" - There is currently a newer version available, but the
   * revision being used still works.
   * - "INVALID" - The revision being used is not supported in any released
   * version.
   */
  core.String revisionStatus;

  RevisionCheckResponse();

  RevisionCheckResponse.fromJson(core.Map _json) {
    if (_json.containsKey("apiVersion")) {
      apiVersion = _json["apiVersion"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("revisionStatus")) {
      revisionStatus = _json["revisionStatus"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (apiVersion != null) {
      _json["apiVersion"] = apiVersion;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (revisionStatus != null) {
      _json["revisionStatus"] = revisionStatus;
    }
    return _json;
  }
}

/** This is a JSON template for a room resource object. */
class Room {
  /** The ID of the application being played. */
  core.String applicationId;
  /** Criteria for auto-matching players into this room. */
  RoomAutoMatchingCriteria autoMatchingCriteria;
  /**
   * Auto-matching status for this room. Not set if the room is not currently in
   * the auto-matching queue.
   */
  RoomAutoMatchStatus autoMatchingStatus;
  /** Details about the room creation. */
  RoomModification creationDetails;
  /**
   * This short description is generated by our servers and worded relative to
   * the player requesting the room. It is intended to be displayed when the
   * room is shown in a list (that is, an invitation to a room.)
   */
  core.String description;
  /**
   * The ID of the participant that invited the user to the room. Not set if the
   * user was not invited to the room.
   */
  core.String inviterId;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#room.
   */
  core.String kind;
  /** Details about the last update to the room. */
  RoomModification lastUpdateDetails;
  /**
   * The participants involved in the room, along with their statuses. Includes
   * participants who have left or declined invitations.
   */
  core.List<RoomParticipant> participants;
  /** Globally unique ID for a room. */
  core.String roomId;
  /**
   * The version of the room status: an increasing counter, used by the client
   * to ignore out-of-order updates to room status.
   */
  core.int roomStatusVersion;
  /**
   * The status of the room.
   * Possible values are:
   * - "ROOM_INVITING" - One or more players have been invited and not
   * responded.
   * - "ROOM_AUTO_MATCHING" - One or more slots need to be filled by
   * auto-matching.
   * - "ROOM_CONNECTING" - Players have joined and are connecting to each other
   * (either before or after auto-matching).
   * - "ROOM_ACTIVE" - All players have joined and connected to each other.
   * - "ROOM_DELETED" - The room should no longer be shown on the client.
   * Returned in sync calls when a player joins a room (as a tombstone), or for
   * rooms where all joined participants have left.
   */
  core.String status;
  /**
   * The variant / mode of the application being played; can be any integer
   * value, or left blank.
   */
  core.int variant;

  Room();

  Room.fromJson(core.Map _json) {
    if (_json.containsKey("applicationId")) {
      applicationId = _json["applicationId"];
    }
    if (_json.containsKey("autoMatchingCriteria")) {
      autoMatchingCriteria = new RoomAutoMatchingCriteria.fromJson(_json["autoMatchingCriteria"]);
    }
    if (_json.containsKey("autoMatchingStatus")) {
      autoMatchingStatus = new RoomAutoMatchStatus.fromJson(_json["autoMatchingStatus"]);
    }
    if (_json.containsKey("creationDetails")) {
      creationDetails = new RoomModification.fromJson(_json["creationDetails"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("inviterId")) {
      inviterId = _json["inviterId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastUpdateDetails")) {
      lastUpdateDetails = new RoomModification.fromJson(_json["lastUpdateDetails"]);
    }
    if (_json.containsKey("participants")) {
      participants = _json["participants"].map((value) => new RoomParticipant.fromJson(value)).toList();
    }
    if (_json.containsKey("roomId")) {
      roomId = _json["roomId"];
    }
    if (_json.containsKey("roomStatusVersion")) {
      roomStatusVersion = _json["roomStatusVersion"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("variant")) {
      variant = _json["variant"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (applicationId != null) {
      _json["applicationId"] = applicationId;
    }
    if (autoMatchingCriteria != null) {
      _json["autoMatchingCriteria"] = (autoMatchingCriteria).toJson();
    }
    if (autoMatchingStatus != null) {
      _json["autoMatchingStatus"] = (autoMatchingStatus).toJson();
    }
    if (creationDetails != null) {
      _json["creationDetails"] = (creationDetails).toJson();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (inviterId != null) {
      _json["inviterId"] = inviterId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastUpdateDetails != null) {
      _json["lastUpdateDetails"] = (lastUpdateDetails).toJson();
    }
    if (participants != null) {
      _json["participants"] = participants.map((value) => (value).toJson()).toList();
    }
    if (roomId != null) {
      _json["roomId"] = roomId;
    }
    if (roomStatusVersion != null) {
      _json["roomStatusVersion"] = roomStatusVersion;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (variant != null) {
      _json["variant"] = variant;
    }
    return _json;
  }
}

/**
 * This is a JSON template for status of room automatching that is in progress.
 */
class RoomAutoMatchStatus {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomAutoMatchStatus.
   */
  core.String kind;
  /**
   * An estimate for the amount of time (in seconds) that auto-matching is
   * expected to take to complete.
   */
  core.int waitEstimateSeconds;

  RoomAutoMatchStatus();

  RoomAutoMatchStatus.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("waitEstimateSeconds")) {
      waitEstimateSeconds = _json["waitEstimateSeconds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (waitEstimateSeconds != null) {
      _json["waitEstimateSeconds"] = waitEstimateSeconds;
    }
    return _json;
  }
}

/** This is a JSON template for a room auto-match criteria object. */
class RoomAutoMatchingCriteria {
  /**
   * A bitmask indicating when auto-matches are valid. When ANDed with other
   * exclusive bitmasks, the result must be zero. Can be used to support
   * exclusive roles within a game.
   */
  core.String exclusiveBitmask;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomAutoMatchingCriteria.
   */
  core.String kind;
  /**
   * The maximum number of players that should be added to the room by
   * auto-matching.
   */
  core.int maxAutoMatchingPlayers;
  /**
   * The minimum number of players that should be added to the room by
   * auto-matching.
   */
  core.int minAutoMatchingPlayers;

  RoomAutoMatchingCriteria();

  RoomAutoMatchingCriteria.fromJson(core.Map _json) {
    if (_json.containsKey("exclusiveBitmask")) {
      exclusiveBitmask = _json["exclusiveBitmask"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("maxAutoMatchingPlayers")) {
      maxAutoMatchingPlayers = _json["maxAutoMatchingPlayers"];
    }
    if (_json.containsKey("minAutoMatchingPlayers")) {
      minAutoMatchingPlayers = _json["minAutoMatchingPlayers"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (exclusiveBitmask != null) {
      _json["exclusiveBitmask"] = exclusiveBitmask;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (maxAutoMatchingPlayers != null) {
      _json["maxAutoMatchingPlayers"] = maxAutoMatchingPlayers;
    }
    if (minAutoMatchingPlayers != null) {
      _json["minAutoMatchingPlayers"] = minAutoMatchingPlayers;
    }
    return _json;
  }
}

/** This is a JSON template for the client address when setting up a room. */
class RoomClientAddress {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomClientAddress.
   */
  core.String kind;
  /** The XMPP address of the client on the Google Games XMPP network. */
  core.String xmppAddress;

  RoomClientAddress();

  RoomClientAddress.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("xmppAddress")) {
      xmppAddress = _json["xmppAddress"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (xmppAddress != null) {
      _json["xmppAddress"] = xmppAddress;
    }
    return _json;
  }
}

/** This is a JSON template for a room creation request. */
class RoomCreateRequest {
  /** Criteria for auto-matching players into this room. */
  RoomAutoMatchingCriteria autoMatchingCriteria;
  /** The capabilities that this client supports for realtime communication. */
  core.List<core.String> capabilities;
  /** Client address for the player creating the room. */
  RoomClientAddress clientAddress;
  /** The player IDs to invite to the room. */
  core.List<core.String> invitedPlayerIds;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomCreateRequest.
   */
  core.String kind;
  /** Network diagnostics for the client creating the room. */
  NetworkDiagnostics networkDiagnostics;
  /**
   * A randomly generated numeric ID. This number is used at the server to
   * ensure that the request is handled correctly across retries.
   */
  core.String requestId;
  /**
   * The variant / mode of the application to be played. This can be any integer
   * value, or left blank. You should use a small number of variants to keep the
   * auto-matching pool as large as possible.
   */
  core.int variant;

  RoomCreateRequest();

  RoomCreateRequest.fromJson(core.Map _json) {
    if (_json.containsKey("autoMatchingCriteria")) {
      autoMatchingCriteria = new RoomAutoMatchingCriteria.fromJson(_json["autoMatchingCriteria"]);
    }
    if (_json.containsKey("capabilities")) {
      capabilities = _json["capabilities"];
    }
    if (_json.containsKey("clientAddress")) {
      clientAddress = new RoomClientAddress.fromJson(_json["clientAddress"]);
    }
    if (_json.containsKey("invitedPlayerIds")) {
      invitedPlayerIds = _json["invitedPlayerIds"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("networkDiagnostics")) {
      networkDiagnostics = new NetworkDiagnostics.fromJson(_json["networkDiagnostics"]);
    }
    if (_json.containsKey("requestId")) {
      requestId = _json["requestId"];
    }
    if (_json.containsKey("variant")) {
      variant = _json["variant"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (autoMatchingCriteria != null) {
      _json["autoMatchingCriteria"] = (autoMatchingCriteria).toJson();
    }
    if (capabilities != null) {
      _json["capabilities"] = capabilities;
    }
    if (clientAddress != null) {
      _json["clientAddress"] = (clientAddress).toJson();
    }
    if (invitedPlayerIds != null) {
      _json["invitedPlayerIds"] = invitedPlayerIds;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (networkDiagnostics != null) {
      _json["networkDiagnostics"] = (networkDiagnostics).toJson();
    }
    if (requestId != null) {
      _json["requestId"] = requestId;
    }
    if (variant != null) {
      _json["variant"] = variant;
    }
    return _json;
  }
}

/** This is a JSON template for a join room request. */
class RoomJoinRequest {
  /** The capabilities that this client supports for realtime communication. */
  core.List<core.String> capabilities;
  /** Client address for the player joining the room. */
  RoomClientAddress clientAddress;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomJoinRequest.
   */
  core.String kind;
  /** Network diagnostics for the client joining the room. */
  NetworkDiagnostics networkDiagnostics;

  RoomJoinRequest();

  RoomJoinRequest.fromJson(core.Map _json) {
    if (_json.containsKey("capabilities")) {
      capabilities = _json["capabilities"];
    }
    if (_json.containsKey("clientAddress")) {
      clientAddress = new RoomClientAddress.fromJson(_json["clientAddress"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("networkDiagnostics")) {
      networkDiagnostics = new NetworkDiagnostics.fromJson(_json["networkDiagnostics"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (capabilities != null) {
      _json["capabilities"] = capabilities;
    }
    if (clientAddress != null) {
      _json["clientAddress"] = (clientAddress).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (networkDiagnostics != null) {
      _json["networkDiagnostics"] = (networkDiagnostics).toJson();
    }
    return _json;
  }
}

/** This is a JSON template for room leave diagnostics. */
class RoomLeaveDiagnostics {
  /**
   * Android network subtype.
   * http://developer.android.com/reference/android/net/NetworkInfo.html#getSubtype()
   */
  core.int androidNetworkSubtype;
  /**
   * Android network type.
   * http://developer.android.com/reference/android/net/NetworkInfo.html#getType()
   */
  core.int androidNetworkType;
  /** iOS network type as defined in Reachability.h. */
  core.int iosNetworkType;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomLeaveDiagnostics.
   */
  core.String kind;
  /**
   * The MCC+MNC code for the client's network connection. On Android:
   * http://developer.android.com/reference/android/telephony/TelephonyManager.html#getNetworkOperator()
   * On iOS, see:
   * https://developer.apple.com/library/ios/documentation/NetworkingInternet/Reference/CTCarrier/Reference/Reference.html
   */
  core.String networkOperatorCode;
  /**
   * The name of the carrier of the client's network connection. On Android:
   * http://developer.android.com/reference/android/telephony/TelephonyManager.html#getNetworkOperatorName()
   * On iOS:
   * https://developer.apple.com/library/ios/documentation/NetworkingInternet/Reference/CTCarrier/Reference/Reference.html#//apple_ref/occ/instp/CTCarrier/carrierName
   */
  core.String networkOperatorName;
  /** Diagnostics about all peer sessions. */
  core.List<PeerSessionDiagnostics> peerSession;
  /** Whether or not sockets were used. */
  core.bool socketsUsed;

  RoomLeaveDiagnostics();

  RoomLeaveDiagnostics.fromJson(core.Map _json) {
    if (_json.containsKey("androidNetworkSubtype")) {
      androidNetworkSubtype = _json["androidNetworkSubtype"];
    }
    if (_json.containsKey("androidNetworkType")) {
      androidNetworkType = _json["androidNetworkType"];
    }
    if (_json.containsKey("iosNetworkType")) {
      iosNetworkType = _json["iosNetworkType"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("networkOperatorCode")) {
      networkOperatorCode = _json["networkOperatorCode"];
    }
    if (_json.containsKey("networkOperatorName")) {
      networkOperatorName = _json["networkOperatorName"];
    }
    if (_json.containsKey("peerSession")) {
      peerSession = _json["peerSession"].map((value) => new PeerSessionDiagnostics.fromJson(value)).toList();
    }
    if (_json.containsKey("socketsUsed")) {
      socketsUsed = _json["socketsUsed"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (androidNetworkSubtype != null) {
      _json["androidNetworkSubtype"] = androidNetworkSubtype;
    }
    if (androidNetworkType != null) {
      _json["androidNetworkType"] = androidNetworkType;
    }
    if (iosNetworkType != null) {
      _json["iosNetworkType"] = iosNetworkType;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (networkOperatorCode != null) {
      _json["networkOperatorCode"] = networkOperatorCode;
    }
    if (networkOperatorName != null) {
      _json["networkOperatorName"] = networkOperatorName;
    }
    if (peerSession != null) {
      _json["peerSession"] = peerSession.map((value) => (value).toJson()).toList();
    }
    if (socketsUsed != null) {
      _json["socketsUsed"] = socketsUsed;
    }
    return _json;
  }
}

/** This is a JSON template for a leave room request. */
class RoomLeaveRequest {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomLeaveRequest.
   */
  core.String kind;
  /** Diagnostics for a player leaving the room. */
  RoomLeaveDiagnostics leaveDiagnostics;
  /**
   * Reason for leaving the match.
   * Possible values are:
   * - "PLAYER_LEFT" - The player chose to leave the room..
   * - "GAME_LEFT" - The game chose to remove the player from the room.
   * - "REALTIME_ABANDONED" - The player switched to another application and
   * abandoned the room.
   * - "REALTIME_PEER_CONNECTION_FAILURE" - The client was unable to establish a
   * connection to other peer(s).
   * - "REALTIME_SERVER_CONNECTION_FAILURE" - The client was unable to
   * communicate with the server.
   * - "REALTIME_SERVER_ERROR" - The client received an error response when it
   * tried to communicate with the server.
   * - "REALTIME_TIMEOUT" - The client timed out while waiting for a room.
   * - "REALTIME_CLIENT_DISCONNECTING" - The client disconnects without first
   * calling Leave.
   * - "REALTIME_SIGN_OUT" - The user signed out of G+ while in the room.
   * - "REALTIME_GAME_CRASHED" - The game crashed.
   * - "REALTIME_ROOM_SERVICE_CRASHED" - RoomAndroidService crashed.
   * - "REALTIME_DIFFERENT_CLIENT_ROOM_OPERATION" - Another client is trying to
   * enter a room.
   * - "REALTIME_SAME_CLIENT_ROOM_OPERATION" - The same client is trying to
   * enter a new room.
   */
  core.String reason;

  RoomLeaveRequest();

  RoomLeaveRequest.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("leaveDiagnostics")) {
      leaveDiagnostics = new RoomLeaveDiagnostics.fromJson(_json["leaveDiagnostics"]);
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (leaveDiagnostics != null) {
      _json["leaveDiagnostics"] = (leaveDiagnostics).toJson();
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    return _json;
  }
}

/** This is a JSON template for a list of rooms. */
class RoomList {
  /** The rooms. */
  core.List<Room> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomList.
   */
  core.String kind;
  /** The pagination token for the next page of results. */
  core.String nextPageToken;

  RoomList();

  RoomList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Room.fromJson(value)).toList();
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

/** This is a JSON template for room modification metadata. */
class RoomModification {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomModification.
   */
  core.String kind;
  /**
   * The timestamp at which they modified the room, in milliseconds since the
   * epoch in UTC.
   */
  core.String modifiedTimestampMillis;
  /** The ID of the participant that modified the room. */
  core.String participantId;

  RoomModification();

  RoomModification.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("modifiedTimestampMillis")) {
      modifiedTimestampMillis = _json["modifiedTimestampMillis"];
    }
    if (_json.containsKey("participantId")) {
      participantId = _json["participantId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (modifiedTimestampMillis != null) {
      _json["modifiedTimestampMillis"] = modifiedTimestampMillis;
    }
    if (participantId != null) {
      _json["participantId"] = participantId;
    }
    return _json;
  }
}

/** This is a JSON template for an update on the status of a peer in a room. */
class RoomP2PStatus {
  /**
   * The amount of time in milliseconds it took to establish connections with
   * this peer.
   */
  core.int connectionSetupLatencyMillis;
  /**
   * The error code in event of a failure.
   * Possible values are:
   * - "P2P_FAILED" - The client failed to establish a P2P connection with the
   * peer.
   * - "PRESENCE_FAILED" - The client failed to register to receive P2P
   * connections.
   * - "RELAY_SERVER_FAILED" - The client received an error when trying to use
   * the relay server to establish a P2P connection with the peer.
   */
  core.String error;
  /** More detailed diagnostic message returned in event of a failure. */
  core.String errorReason;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomP2PStatus.
   */
  core.String kind;
  /** The ID of the participant. */
  core.String participantId;
  /**
   * The status of the peer in the room.
   * Possible values are:
   * - "CONNECTION_ESTABLISHED" - The client established a P2P connection with
   * the peer.
   * - "CONNECTION_FAILED" - The client failed to establish directed presence
   * with the peer.
   */
  core.String status;
  /**
   * The amount of time in milliseconds it took to send packets back and forth
   * on the unreliable channel with this peer.
   */
  core.int unreliableRoundtripLatencyMillis;

  RoomP2PStatus();

  RoomP2PStatus.fromJson(core.Map _json) {
    if (_json.containsKey("connectionSetupLatencyMillis")) {
      connectionSetupLatencyMillis = _json["connectionSetupLatencyMillis"];
    }
    if (_json.containsKey("error")) {
      error = _json["error"];
    }
    if (_json.containsKey("error_reason")) {
      errorReason = _json["error_reason"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("participantId")) {
      participantId = _json["participantId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("unreliableRoundtripLatencyMillis")) {
      unreliableRoundtripLatencyMillis = _json["unreliableRoundtripLatencyMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (connectionSetupLatencyMillis != null) {
      _json["connectionSetupLatencyMillis"] = connectionSetupLatencyMillis;
    }
    if (error != null) {
      _json["error"] = error;
    }
    if (errorReason != null) {
      _json["error_reason"] = errorReason;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (participantId != null) {
      _json["participantId"] = participantId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (unreliableRoundtripLatencyMillis != null) {
      _json["unreliableRoundtripLatencyMillis"] = unreliableRoundtripLatencyMillis;
    }
    return _json;
  }
}

/** This is a JSON template for an update on the status of peers in a room. */
class RoomP2PStatuses {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomP2PStatuses.
   */
  core.String kind;
  /** The updates for the peers. */
  core.List<RoomP2PStatus> updates;

  RoomP2PStatuses();

  RoomP2PStatuses.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("updates")) {
      updates = _json["updates"].map((value) => new RoomP2PStatus.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (updates != null) {
      _json["updates"] = updates.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** This is a JSON template for a participant in a room. */
class RoomParticipant {
  /** True if this participant was auto-matched with the requesting player. */
  core.bool autoMatched;
  /**
   * Information about a player that has been anonymously auto-matched against
   * the requesting player. (Either player or autoMatchedPlayer will be set.)
   */
  AnonymousPlayer autoMatchedPlayer;
  /**
   * The capabilities which can be used when communicating with this
   * participant.
   */
  core.List<core.String> capabilities;
  /** Client address for the participant. */
  RoomClientAddress clientAddress;
  /**
   * True if this participant is in the fully connected set of peers in the
   * room.
   */
  core.bool connected;
  /**
   * An identifier for the participant in the scope of the room. Cannot be used
   * to identify a player across rooms or in other contexts.
   */
  core.String id;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomParticipant.
   */
  core.String kind;
  /**
   * The reason the participant left the room; populated if the participant
   * status is PARTICIPANT_LEFT.
   * Possible values are:
   * - "PLAYER_LEFT" - The player explicitly chose to leave the room.
   * - "GAME_LEFT" - The game chose to remove the player from the room.
   * - "ABANDONED" - The player switched to another application and abandoned
   * the room.
   * - "PEER_CONNECTION_FAILURE" - The client was unable to establish or
   * maintain a connection to other peer(s) in the room.
   * - "SERVER_ERROR" - The client received an error response when it tried to
   * communicate with the server.
   * - "TIMEOUT" - The client timed out while waiting for players to join and
   * connect.
   * - "PRESENCE_FAILURE" - The client's XMPP connection ended abruptly.
   */
  core.String leaveReason;
  /**
   * Information about the player. Not populated if this player was anonymously
   * auto-matched against the requesting player. (Either player or
   * autoMatchedPlayer will be set.)
   */
  Player player;
  /**
   * The status of the participant with respect to the room.
   * Possible values are:
   * - "PARTICIPANT_INVITED" - The participant has been invited to join the
   * room, but has not yet responded.
   * - "PARTICIPANT_JOINED" - The participant has joined the room (either after
   * creating it or accepting an invitation.)
   * - "PARTICIPANT_DECLINED" - The participant declined an invitation to join
   * the room.
   * - "PARTICIPANT_LEFT" - The participant joined the room and then left it.
   */
  core.String status;

  RoomParticipant();

  RoomParticipant.fromJson(core.Map _json) {
    if (_json.containsKey("autoMatched")) {
      autoMatched = _json["autoMatched"];
    }
    if (_json.containsKey("autoMatchedPlayer")) {
      autoMatchedPlayer = new AnonymousPlayer.fromJson(_json["autoMatchedPlayer"]);
    }
    if (_json.containsKey("capabilities")) {
      capabilities = _json["capabilities"];
    }
    if (_json.containsKey("clientAddress")) {
      clientAddress = new RoomClientAddress.fromJson(_json["clientAddress"]);
    }
    if (_json.containsKey("connected")) {
      connected = _json["connected"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("leaveReason")) {
      leaveReason = _json["leaveReason"];
    }
    if (_json.containsKey("player")) {
      player = new Player.fromJson(_json["player"]);
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (autoMatched != null) {
      _json["autoMatched"] = autoMatched;
    }
    if (autoMatchedPlayer != null) {
      _json["autoMatchedPlayer"] = (autoMatchedPlayer).toJson();
    }
    if (capabilities != null) {
      _json["capabilities"] = capabilities;
    }
    if (clientAddress != null) {
      _json["clientAddress"] = (clientAddress).toJson();
    }
    if (connected != null) {
      _json["connected"] = connected;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (leaveReason != null) {
      _json["leaveReason"] = leaveReason;
    }
    if (player != null) {
      _json["player"] = (player).toJson();
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/**
 * This is a JSON template for the status of a room that the player has joined.
 */
class RoomStatus {
  /**
   * Auto-matching status for this room. Not set if the room is not currently in
   * the automatching queue.
   */
  RoomAutoMatchStatus autoMatchingStatus;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#roomStatus.
   */
  core.String kind;
  /**
   * The participants involved in the room, along with their statuses. Includes
   * participants who have left or declined invitations.
   */
  core.List<RoomParticipant> participants;
  /** Globally unique ID for a room. */
  core.String roomId;
  /**
   * The status of the room.
   * Possible values are:
   * - "ROOM_INVITING" - One or more players have been invited and not
   * responded.
   * - "ROOM_AUTO_MATCHING" - One or more slots need to be filled by
   * auto-matching.
   * - "ROOM_CONNECTING" - Players have joined are connecting to each other
   * (either before or after auto-matching).
   * - "ROOM_ACTIVE" - All players have joined and connected to each other.
   * - "ROOM_DELETED" - All joined players have left.
   */
  core.String status;
  /**
   * The version of the status for the room: an increasing counter, used by the
   * client to ignore out-of-order updates to room status.
   */
  core.int statusVersion;

  RoomStatus();

  RoomStatus.fromJson(core.Map _json) {
    if (_json.containsKey("autoMatchingStatus")) {
      autoMatchingStatus = new RoomAutoMatchStatus.fromJson(_json["autoMatchingStatus"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("participants")) {
      participants = _json["participants"].map((value) => new RoomParticipant.fromJson(value)).toList();
    }
    if (_json.containsKey("roomId")) {
      roomId = _json["roomId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("statusVersion")) {
      statusVersion = _json["statusVersion"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (autoMatchingStatus != null) {
      _json["autoMatchingStatus"] = (autoMatchingStatus).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (participants != null) {
      _json["participants"] = participants.map((value) => (value).toJson()).toList();
    }
    if (roomId != null) {
      _json["roomId"] = roomId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (statusVersion != null) {
      _json["statusVersion"] = statusVersion;
    }
    return _json;
  }
}

/** This is a JSON template for a request to submit a score to leaderboards. */
class ScoreSubmission {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#scoreSubmission.
   */
  core.String kind;
  /** The leaderboard this score is being submitted to. */
  core.String leaderboardId;
  /** The new score being submitted. */
  core.String score;
  /**
   * Additional information about this score. Values will contain no more than
   * 64 URI-safe characters as defined by section 2.3 of RFC 3986.
   */
  core.String scoreTag;
  /**
   * Signature Values will contain URI-safe characters as defined by section 2.3
   * of RFC 3986.
   */
  core.String signature;

  ScoreSubmission();

  ScoreSubmission.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("leaderboardId")) {
      leaderboardId = _json["leaderboardId"];
    }
    if (_json.containsKey("score")) {
      score = _json["score"];
    }
    if (_json.containsKey("scoreTag")) {
      scoreTag = _json["scoreTag"];
    }
    if (_json.containsKey("signature")) {
      signature = _json["signature"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (leaderboardId != null) {
      _json["leaderboardId"] = leaderboardId;
    }
    if (score != null) {
      _json["score"] = score;
    }
    if (scoreTag != null) {
      _json["scoreTag"] = scoreTag;
    }
    if (signature != null) {
      _json["signature"] = signature;
    }
    return _json;
  }
}

/** This is a JSON template for an snapshot object. */
class Snapshot {
  /** The cover image of this snapshot. May be absent if there is no image. */
  SnapshotImage coverImage;
  /** The description of this snapshot. */
  core.String description;
  /**
   * The ID of the file underlying this snapshot in the Drive API. Only present
   * if the snapshot is a view on a Drive file and the file is owned by the
   * caller.
   */
  core.String driveId;
  /** The duration associated with this snapshot, in millis. */
  core.String durationMillis;
  /** The ID of the snapshot. */
  core.String id;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#snapshot.
   */
  core.String kind;
  /**
   * The timestamp (in millis since Unix epoch) of the last modification to this
   * snapshot.
   */
  core.String lastModifiedMillis;
  /**
   * The progress value (64-bit integer set by developer) associated with this
   * snapshot.
   */
  core.String progressValue;
  /** The title of this snapshot. */
  core.String title;
  /**
   * The type of this snapshot.
   * Possible values are:
   * - "SAVE_GAME" - A snapshot representing a save game.
   */
  core.String type;
  /** The unique name provided when the snapshot was created. */
  core.String uniqueName;

  Snapshot();

  Snapshot.fromJson(core.Map _json) {
    if (_json.containsKey("coverImage")) {
      coverImage = new SnapshotImage.fromJson(_json["coverImage"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("driveId")) {
      driveId = _json["driveId"];
    }
    if (_json.containsKey("durationMillis")) {
      durationMillis = _json["durationMillis"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastModifiedMillis")) {
      lastModifiedMillis = _json["lastModifiedMillis"];
    }
    if (_json.containsKey("progressValue")) {
      progressValue = _json["progressValue"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("uniqueName")) {
      uniqueName = _json["uniqueName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (coverImage != null) {
      _json["coverImage"] = (coverImage).toJson();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (driveId != null) {
      _json["driveId"] = driveId;
    }
    if (durationMillis != null) {
      _json["durationMillis"] = durationMillis;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastModifiedMillis != null) {
      _json["lastModifiedMillis"] = lastModifiedMillis;
    }
    if (progressValue != null) {
      _json["progressValue"] = progressValue;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (uniqueName != null) {
      _json["uniqueName"] = uniqueName;
    }
    return _json;
  }
}

/** This is a JSON template for an image of a snapshot. */
class SnapshotImage {
  /** The height of the image. */
  core.int height;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#snapshotImage.
   */
  core.String kind;
  /** The MIME type of the image. */
  core.String mimeType;
  /**
   * The URL of the image. This URL may be invalidated at any time and should
   * not be cached.
   */
  core.String url;
  /** The width of the image. */
  core.int width;

  SnapshotImage();

  SnapshotImage.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("mime_type")) {
      mimeType = _json["mime_type"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (height != null) {
      _json["height"] = height;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (mimeType != null) {
      _json["mime_type"] = mimeType;
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/** This is a JSON template for a list of snapshot objects. */
class SnapshotListResponse {
  /** The snapshots. */
  core.List<Snapshot> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#snapshotListResponse.
   */
  core.String kind;
  /**
   * Token corresponding to the next page of results. If there are no more
   * results, the token is omitted.
   */
  core.String nextPageToken;

  SnapshotListResponse();

  SnapshotListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Snapshot.fromJson(value)).toList();
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

/** This is a JSON template for an turn-based auto-match criteria object. */
class TurnBasedAutoMatchingCriteria {
  /**
   * A bitmask indicating when auto-matches are valid. When ANDed with other
   * exclusive bitmasks, the result must be zero. Can be used to support
   * exclusive roles within a game.
   */
  core.String exclusiveBitmask;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#turnBasedAutoMatchingCriteria.
   */
  core.String kind;
  /**
   * The maximum number of players that should be added to the match by
   * auto-matching.
   */
  core.int maxAutoMatchingPlayers;
  /**
   * The minimum number of players that should be added to the match by
   * auto-matching.
   */
  core.int minAutoMatchingPlayers;

  TurnBasedAutoMatchingCriteria();

  TurnBasedAutoMatchingCriteria.fromJson(core.Map _json) {
    if (_json.containsKey("exclusiveBitmask")) {
      exclusiveBitmask = _json["exclusiveBitmask"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("maxAutoMatchingPlayers")) {
      maxAutoMatchingPlayers = _json["maxAutoMatchingPlayers"];
    }
    if (_json.containsKey("minAutoMatchingPlayers")) {
      minAutoMatchingPlayers = _json["minAutoMatchingPlayers"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (exclusiveBitmask != null) {
      _json["exclusiveBitmask"] = exclusiveBitmask;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (maxAutoMatchingPlayers != null) {
      _json["maxAutoMatchingPlayers"] = maxAutoMatchingPlayers;
    }
    if (minAutoMatchingPlayers != null) {
      _json["minAutoMatchingPlayers"] = minAutoMatchingPlayers;
    }
    return _json;
  }
}

/** This is a JSON template for a turn-based match resource object. */
class TurnBasedMatch {
  /** The ID of the application being played. */
  core.String applicationId;
  /** Criteria for auto-matching players into this match. */
  TurnBasedAutoMatchingCriteria autoMatchingCriteria;
  /** Details about the match creation. */
  TurnBasedMatchModification creationDetails;
  /** The data / game state for this match. */
  TurnBasedMatchData data;
  /**
   * This short description is generated by our servers based on turn state and
   * is localized and worded relative to the player requesting the match. It is
   * intended to be displayed when the match is shown in a list.
   */
  core.String description;
  /**
   * The ID of the participant that invited the user to the match. Not set if
   * the user was not invited to the match.
   */
  core.String inviterId;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#turnBasedMatch.
   */
  core.String kind;
  /** Details about the last update to the match. */
  TurnBasedMatchModification lastUpdateDetails;
  /** Globally unique ID for a turn-based match. */
  core.String matchId;
  /**
   * The number of the match in a chain of rematches. Will be set to 1 for the
   * first match and incremented by 1 for each rematch.
   */
  core.int matchNumber;
  /**
   * The version of this match: an increasing counter, used to avoid out-of-date
   * updates to the match.
   */
  core.int matchVersion;
  /**
   * The participants involved in the match, along with their statuses. Includes
   * participants who have left or declined invitations.
   */
  core.List<TurnBasedMatchParticipant> participants;
  /** The ID of the participant that is taking a turn. */
  core.String pendingParticipantId;
  /**
   * The data / game state for the previous match; set for the first turn of
   * rematches only.
   */
  TurnBasedMatchData previousMatchData;
  /**
   * The ID of a rematch of this match. Only set for completed matches that have
   * been rematched.
   */
  core.String rematchId;
  /** The results reported for this match. */
  core.List<ParticipantResult> results;
  /**
   * The status of the match.
   * Possible values are:
   * - "MATCH_AUTO_MATCHING" - One or more slots need to be filled by
   * auto-matching; the match cannot be established until they are filled.
   * - "MATCH_ACTIVE" - The match has started.
   * - "MATCH_COMPLETE" - The match has finished.
   * - "MATCH_CANCELED" - The match was canceled.
   * - "MATCH_EXPIRED" - The match expired due to inactivity.
   * - "MATCH_DELETED" - The match should no longer be shown on the client.
   * Returned only for tombstones for matches when sync is called.
   */
  core.String status;
  /**
   * The status of the current user in the match. Derived from the match type,
   * match status, the user's participant status, and the pending participant
   * for the match.
   * Possible values are:
   * - "USER_INVITED" - The user has been invited to join the match and has not
   * responded yet.
   * - "USER_AWAITING_TURN" - The user is waiting for their turn.
   * - "USER_TURN" - The user has an action to take in the match.
   * - "USER_MATCH_COMPLETED" - The match has ended (it is completed, canceled,
   * or expired.)
   */
  core.String userMatchStatus;
  /**
   * The variant / mode of the application being played; can be any integer
   * value, or left blank.
   */
  core.int variant;
  /**
   * The ID of another participant in the match that can be used when describing
   * the participants the user is playing with.
   */
  core.String withParticipantId;

  TurnBasedMatch();

  TurnBasedMatch.fromJson(core.Map _json) {
    if (_json.containsKey("applicationId")) {
      applicationId = _json["applicationId"];
    }
    if (_json.containsKey("autoMatchingCriteria")) {
      autoMatchingCriteria = new TurnBasedAutoMatchingCriteria.fromJson(_json["autoMatchingCriteria"]);
    }
    if (_json.containsKey("creationDetails")) {
      creationDetails = new TurnBasedMatchModification.fromJson(_json["creationDetails"]);
    }
    if (_json.containsKey("data")) {
      data = new TurnBasedMatchData.fromJson(_json["data"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("inviterId")) {
      inviterId = _json["inviterId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastUpdateDetails")) {
      lastUpdateDetails = new TurnBasedMatchModification.fromJson(_json["lastUpdateDetails"]);
    }
    if (_json.containsKey("matchId")) {
      matchId = _json["matchId"];
    }
    if (_json.containsKey("matchNumber")) {
      matchNumber = _json["matchNumber"];
    }
    if (_json.containsKey("matchVersion")) {
      matchVersion = _json["matchVersion"];
    }
    if (_json.containsKey("participants")) {
      participants = _json["participants"].map((value) => new TurnBasedMatchParticipant.fromJson(value)).toList();
    }
    if (_json.containsKey("pendingParticipantId")) {
      pendingParticipantId = _json["pendingParticipantId"];
    }
    if (_json.containsKey("previousMatchData")) {
      previousMatchData = new TurnBasedMatchData.fromJson(_json["previousMatchData"]);
    }
    if (_json.containsKey("rematchId")) {
      rematchId = _json["rematchId"];
    }
    if (_json.containsKey("results")) {
      results = _json["results"].map((value) => new ParticipantResult.fromJson(value)).toList();
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("userMatchStatus")) {
      userMatchStatus = _json["userMatchStatus"];
    }
    if (_json.containsKey("variant")) {
      variant = _json["variant"];
    }
    if (_json.containsKey("withParticipantId")) {
      withParticipantId = _json["withParticipantId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (applicationId != null) {
      _json["applicationId"] = applicationId;
    }
    if (autoMatchingCriteria != null) {
      _json["autoMatchingCriteria"] = (autoMatchingCriteria).toJson();
    }
    if (creationDetails != null) {
      _json["creationDetails"] = (creationDetails).toJson();
    }
    if (data != null) {
      _json["data"] = (data).toJson();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (inviterId != null) {
      _json["inviterId"] = inviterId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastUpdateDetails != null) {
      _json["lastUpdateDetails"] = (lastUpdateDetails).toJson();
    }
    if (matchId != null) {
      _json["matchId"] = matchId;
    }
    if (matchNumber != null) {
      _json["matchNumber"] = matchNumber;
    }
    if (matchVersion != null) {
      _json["matchVersion"] = matchVersion;
    }
    if (participants != null) {
      _json["participants"] = participants.map((value) => (value).toJson()).toList();
    }
    if (pendingParticipantId != null) {
      _json["pendingParticipantId"] = pendingParticipantId;
    }
    if (previousMatchData != null) {
      _json["previousMatchData"] = (previousMatchData).toJson();
    }
    if (rematchId != null) {
      _json["rematchId"] = rematchId;
    }
    if (results != null) {
      _json["results"] = results.map((value) => (value).toJson()).toList();
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (userMatchStatus != null) {
      _json["userMatchStatus"] = userMatchStatus;
    }
    if (variant != null) {
      _json["variant"] = variant;
    }
    if (withParticipantId != null) {
      _json["withParticipantId"] = withParticipantId;
    }
    return _json;
  }
}

/** This is a JSON template for a turn-based match creation request. */
class TurnBasedMatchCreateRequest {
  /** Criteria for auto-matching players into this match. */
  TurnBasedAutoMatchingCriteria autoMatchingCriteria;
  /** The player ids to invite to the match. */
  core.List<core.String> invitedPlayerIds;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#turnBasedMatchCreateRequest.
   */
  core.String kind;
  /**
   * A randomly generated numeric ID. This number is used at the server to
   * ensure that the request is handled correctly across retries.
   */
  core.String requestId;
  /**
   * The variant / mode of the application to be played. This can be any integer
   * value, or left blank. You should use a small number of variants to keep the
   * auto-matching pool as large as possible.
   */
  core.int variant;

  TurnBasedMatchCreateRequest();

  TurnBasedMatchCreateRequest.fromJson(core.Map _json) {
    if (_json.containsKey("autoMatchingCriteria")) {
      autoMatchingCriteria = new TurnBasedAutoMatchingCriteria.fromJson(_json["autoMatchingCriteria"]);
    }
    if (_json.containsKey("invitedPlayerIds")) {
      invitedPlayerIds = _json["invitedPlayerIds"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("requestId")) {
      requestId = _json["requestId"];
    }
    if (_json.containsKey("variant")) {
      variant = _json["variant"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (autoMatchingCriteria != null) {
      _json["autoMatchingCriteria"] = (autoMatchingCriteria).toJson();
    }
    if (invitedPlayerIds != null) {
      _json["invitedPlayerIds"] = invitedPlayerIds;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (requestId != null) {
      _json["requestId"] = requestId;
    }
    if (variant != null) {
      _json["variant"] = variant;
    }
    return _json;
  }
}

/** This is a JSON template for a turn-based match data object. */
class TurnBasedMatchData {
  /**
   * The byte representation of the data (limited to 128 kB), as a
   * Base64-encoded string with the URL_SAFE encoding option.
   */
  core.String data;
  core.List<core.int> get dataAsBytes {
    return convert.BASE64.decode(data);
  }

  void set dataAsBytes(core.List<core.int> _bytes) {
    data = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * True if this match has data available but it wasn't returned in a list
   * response; fetching the match individually will retrieve this data.
   */
  core.bool dataAvailable;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#turnBasedMatchData.
   */
  core.String kind;

  TurnBasedMatchData();

  TurnBasedMatchData.fromJson(core.Map _json) {
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("dataAvailable")) {
      dataAvailable = _json["dataAvailable"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (data != null) {
      _json["data"] = data;
    }
    if (dataAvailable != null) {
      _json["dataAvailable"] = dataAvailable;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** This is a JSON template for sending a turn-based match data object. */
class TurnBasedMatchDataRequest {
  /**
   * The byte representation of the data (limited to 128 kB), as a
   * Base64-encoded string with the URL_SAFE encoding option.
   */
  core.String data;
  core.List<core.int> get dataAsBytes {
    return convert.BASE64.decode(data);
  }

  void set dataAsBytes(core.List<core.int> _bytes) {
    data = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#turnBasedMatchDataRequest.
   */
  core.String kind;

  TurnBasedMatchDataRequest();

  TurnBasedMatchDataRequest.fromJson(core.Map _json) {
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (data != null) {
      _json["data"] = data;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** This is a JSON template for a list of turn-based matches. */
class TurnBasedMatchList {
  /** The matches. */
  core.List<TurnBasedMatch> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#turnBasedMatchList.
   */
  core.String kind;
  /** The pagination token for the next page of results. */
  core.String nextPageToken;

  TurnBasedMatchList();

  TurnBasedMatchList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new TurnBasedMatch.fromJson(value)).toList();
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

/** This is a JSON template for turn-based match modification metadata. */
class TurnBasedMatchModification {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#turnBasedMatchModification.
   */
  core.String kind;
  /**
   * The timestamp at which they modified the match, in milliseconds since the
   * epoch in UTC.
   */
  core.String modifiedTimestampMillis;
  /** The ID of the participant that modified the match. */
  core.String participantId;

  TurnBasedMatchModification();

  TurnBasedMatchModification.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("modifiedTimestampMillis")) {
      modifiedTimestampMillis = _json["modifiedTimestampMillis"];
    }
    if (_json.containsKey("participantId")) {
      participantId = _json["participantId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (modifiedTimestampMillis != null) {
      _json["modifiedTimestampMillis"] = modifiedTimestampMillis;
    }
    if (participantId != null) {
      _json["participantId"] = participantId;
    }
    return _json;
  }
}

/** This is a JSON template for a participant in a turn-based match. */
class TurnBasedMatchParticipant {
  /** True if this participant was auto-matched with the requesting player. */
  core.bool autoMatched;
  /**
   * Information about a player that has been anonymously auto-matched against
   * the requesting player. (Either player or autoMatchedPlayer will be set.)
   */
  AnonymousPlayer autoMatchedPlayer;
  /**
   * An identifier for the participant in the scope of the match. Cannot be used
   * to identify a player across matches or in other contexts.
   */
  core.String id;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#turnBasedMatchParticipant.
   */
  core.String kind;
  /**
   * Information about the player. Not populated if this player was anonymously
   * auto-matched against the requesting player. (Either player or
   * autoMatchedPlayer will be set.)
   */
  Player player;
  /**
   * The status of the participant with respect to the match.
   * Possible values are:
   * - "PARTICIPANT_NOT_INVITED_YET" - The participant is slated to be invited
   * to the match, but the invitation has not been sent; the invite will be sent
   * when it becomes their turn.
   * - "PARTICIPANT_INVITED" - The participant has been invited to join the
   * match, but has not yet responded.
   * - "PARTICIPANT_JOINED" - The participant has joined the match (either after
   * creating it or accepting an invitation.)
   * - "PARTICIPANT_DECLINED" - The participant declined an invitation to join
   * the match.
   * - "PARTICIPANT_LEFT" - The participant joined the match and then left it.
   * - "PARTICIPANT_FINISHED" - The participant finished playing in the match.
   * - "PARTICIPANT_UNRESPONSIVE" - The participant did not take their turn in
   * the allotted time.
   */
  core.String status;

  TurnBasedMatchParticipant();

  TurnBasedMatchParticipant.fromJson(core.Map _json) {
    if (_json.containsKey("autoMatched")) {
      autoMatched = _json["autoMatched"];
    }
    if (_json.containsKey("autoMatchedPlayer")) {
      autoMatchedPlayer = new AnonymousPlayer.fromJson(_json["autoMatchedPlayer"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("player")) {
      player = new Player.fromJson(_json["player"]);
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (autoMatched != null) {
      _json["autoMatched"] = autoMatched;
    }
    if (autoMatchedPlayer != null) {
      _json["autoMatchedPlayer"] = (autoMatchedPlayer).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (player != null) {
      _json["player"] = (player).toJson();
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/** This is a JSON template for a rematch response. */
class TurnBasedMatchRematch {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#turnBasedMatchRematch.
   */
  core.String kind;
  /**
   * The old match that the rematch was created from; will be updated such that
   * the rematchId field will point at the new match.
   */
  TurnBasedMatch previousMatch;
  /**
   * The newly created match; a rematch of the old match with the same
   * participants.
   */
  TurnBasedMatch rematch;

  TurnBasedMatchRematch();

  TurnBasedMatchRematch.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("previousMatch")) {
      previousMatch = new TurnBasedMatch.fromJson(_json["previousMatch"]);
    }
    if (_json.containsKey("rematch")) {
      rematch = new TurnBasedMatch.fromJson(_json["rematch"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (previousMatch != null) {
      _json["previousMatch"] = (previousMatch).toJson();
    }
    if (rematch != null) {
      _json["rematch"] = (rematch).toJson();
    }
    return _json;
  }
}

/** This is a JSON template for a turn-based match results object. */
class TurnBasedMatchResults {
  /** The final match data. */
  TurnBasedMatchDataRequest data;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#turnBasedMatchResults.
   */
  core.String kind;
  /** The version of the match being updated. */
  core.int matchVersion;
  /** The match results for the participants in the match. */
  core.List<ParticipantResult> results;

  TurnBasedMatchResults();

  TurnBasedMatchResults.fromJson(core.Map _json) {
    if (_json.containsKey("data")) {
      data = new TurnBasedMatchDataRequest.fromJson(_json["data"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("matchVersion")) {
      matchVersion = _json["matchVersion"];
    }
    if (_json.containsKey("results")) {
      results = _json["results"].map((value) => new ParticipantResult.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (data != null) {
      _json["data"] = (data).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (matchVersion != null) {
      _json["matchVersion"] = matchVersion;
    }
    if (results != null) {
      _json["results"] = results.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * This is a JSON template for a list of turn-based matches returned from a
 * sync.
 */
class TurnBasedMatchSync {
  /** The matches. */
  core.List<TurnBasedMatch> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#turnBasedMatchSync.
   */
  core.String kind;
  /**
   * True if there were more matches available to fetch at the time the response
   * was generated (which were not returned due to page size limits.)
   */
  core.bool moreAvailable;
  /** The pagination token for the next page of results. */
  core.String nextPageToken;

  TurnBasedMatchSync();

  TurnBasedMatchSync.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new TurnBasedMatch.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("moreAvailable")) {
      moreAvailable = _json["moreAvailable"];
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
    if (moreAvailable != null) {
      _json["moreAvailable"] = moreAvailable;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** This is a JSON template for the object representing a turn. */
class TurnBasedMatchTurn {
  /** The shared game state data after the turn is over. */
  TurnBasedMatchDataRequest data;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string games#turnBasedMatchTurn.
   */
  core.String kind;
  /**
   * The version of this match: an increasing counter, used to avoid out-of-date
   * updates to the match.
   */
  core.int matchVersion;
  /**
   * The ID of the participant who should take their turn next. May be set to
   * the current player's participant ID to update match state without changing
   * the turn. If not set, the match will wait for other player(s) to join via
   * automatching; this is only valid if automatch criteria is set on the match
   * with remaining slots for automatched players.
   */
  core.String pendingParticipantId;
  /** The match results for the participants in the match. */
  core.List<ParticipantResult> results;

  TurnBasedMatchTurn();

  TurnBasedMatchTurn.fromJson(core.Map _json) {
    if (_json.containsKey("data")) {
      data = new TurnBasedMatchDataRequest.fromJson(_json["data"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("matchVersion")) {
      matchVersion = _json["matchVersion"];
    }
    if (_json.containsKey("pendingParticipantId")) {
      pendingParticipantId = _json["pendingParticipantId"];
    }
    if (_json.containsKey("results")) {
      results = _json["results"].map((value) => new ParticipantResult.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (data != null) {
      _json["data"] = (data).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (matchVersion != null) {
      _json["matchVersion"] = matchVersion;
    }
    if (pendingParticipantId != null) {
      _json["pendingParticipantId"] = pendingParticipantId;
    }
    if (results != null) {
      _json["results"] = results.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
