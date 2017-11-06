// This is a generated file (see the discoveryapis_generator project).

library googleapis.gamesManagement.v1management;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client gamesManagement/v1management';

/** The Management API for Google Play Game Services. */
class GamesManagementApi {
  /**
   * Share your Google+ profile information and view and manage your game
   * activity
   */
  static const GamesScope = "https://www.googleapis.com/auth/games";

  /** Know the list of people in your circles, your age range, and language */
  static const PlusLoginScope = "https://www.googleapis.com/auth/plus.login";


  final commons.ApiRequester _requester;

  AchievementsResourceApi get achievements => new AchievementsResourceApi(_requester);
  ApplicationsResourceApi get applications => new ApplicationsResourceApi(_requester);
  EventsResourceApi get events => new EventsResourceApi(_requester);
  PlayersResourceApi get players => new PlayersResourceApi(_requester);
  QuestsResourceApi get quests => new QuestsResourceApi(_requester);
  RoomsResourceApi get rooms => new RoomsResourceApi(_requester);
  ScoresResourceApi get scores => new ScoresResourceApi(_requester);
  TurnBasedMatchesResourceApi get turnBasedMatches => new TurnBasedMatchesResourceApi(_requester);

  GamesManagementApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "games/v1management/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AchievementsResourceApi {
  final commons.ApiRequester _requester;

  AchievementsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Resets the achievement with the given ID for the currently authenticated
   * player. This method is only accessible to whitelisted tester accounts for
   * your application.
   *
   * Request parameters:
   *
   * [achievementId] - The ID of the achievement used by this method.
   *
   * Completes with a [AchievementResetResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementResetResponse> reset(core.String achievementId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (achievementId == null) {
      throw new core.ArgumentError("Parameter achievementId is required.");
    }

    _url = 'achievements/' + commons.Escaper.ecapeVariable('$achievementId') + '/reset';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementResetResponse.fromJson(data));
  }

  /**
   * Resets all achievements for the currently authenticated player for your
   * application. This method is only accessible to whitelisted tester accounts
   * for your application.
   *
   * Request parameters:
   *
   * Completes with a [AchievementResetAllResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AchievementResetAllResponse> resetAll() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'achievements/reset';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AchievementResetAllResponse.fromJson(data));
  }

  /**
   * Resets all draft achievements for all players. This method is only
   * available to user accounts for your developer console.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetAllForAllPlayers() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _downloadOptions = null;

    _url = 'achievements/resetAllForAllPlayers';

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
   * Resets the achievement with the given ID for all players. This method is
   * only available to user accounts for your developer console. Only draft
   * achievements can be reset.
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
  async.Future resetForAllPlayers(core.String achievementId) {
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

    _url = 'achievements/' + commons.Escaper.ecapeVariable('$achievementId') + '/resetForAllPlayers';

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
   * Resets achievements with the given IDs for all players. This method is only
   * available to user accounts for your developer console. Only draft
   * achievements may be reset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetMultipleForAllPlayers(AchievementResetMultipleForAllRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _downloadOptions = null;

    _url = 'achievements/resetMultipleForAllPlayers';

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


class ApplicationsResourceApi {
  final commons.ApiRequester _requester;

  ApplicationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get the list of players hidden from the given application. This method is
   * only available to user accounts for your developer console.
   *
   * Request parameters:
   *
   * [applicationId] - The application ID from the Google Play developer
   * console.
   *
   * [maxResults] - The maximum number of player resources to return in the
   * response, used for paging. For any response, the actual number of player
   * resources returned may be less than the specified maxResults.
   * Value must be between "1" and "50".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [HiddenPlayerList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<HiddenPlayerList> listHidden(core.String applicationId, {core.int maxResults, core.String pageToken}) {
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

    _url = 'applications/' + commons.Escaper.ecapeVariable('$applicationId') + '/players/hidden';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new HiddenPlayerList.fromJson(data));
  }

}


class EventsResourceApi {
  final commons.ApiRequester _requester;

  EventsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Resets all player progress on the event with the given ID for the currently
   * authenticated player. This method is only accessible to whitelisted tester
   * accounts for your application. All quests for this player that use the
   * event will also be reset.
   *
   * Request parameters:
   *
   * [eventId] - The ID of the event.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future reset(core.String eventId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (eventId == null) {
      throw new core.ArgumentError("Parameter eventId is required.");
    }

    _downloadOptions = null;

    _url = 'events/' + commons.Escaper.ecapeVariable('$eventId') + '/reset';

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
   * Resets all player progress on all events for the currently authenticated
   * player. This method is only accessible to whitelisted tester accounts for
   * your application. All quests for this player will also be reset.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetAll() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _downloadOptions = null;

    _url = 'events/reset';

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
   * Resets all draft events for all players. This method is only available to
   * user accounts for your developer console. All quests that use any of these
   * events will also be reset.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetAllForAllPlayers() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _downloadOptions = null;

    _url = 'events/resetAllForAllPlayers';

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
   * Resets the event with the given ID for all players. This method is only
   * available to user accounts for your developer console. Only draft events
   * can be reset. All quests that use the event will also be reset.
   *
   * Request parameters:
   *
   * [eventId] - The ID of the event.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetForAllPlayers(core.String eventId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (eventId == null) {
      throw new core.ArgumentError("Parameter eventId is required.");
    }

    _downloadOptions = null;

    _url = 'events/' + commons.Escaper.ecapeVariable('$eventId') + '/resetForAllPlayers';

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
   * Resets events with the given IDs for all players. This method is only
   * available to user accounts for your developer console. Only draft events
   * may be reset. All quests that use any of the events will also be reset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetMultipleForAllPlayers(EventsResetMultipleForAllRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _downloadOptions = null;

    _url = 'events/resetMultipleForAllPlayers';

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


class PlayersResourceApi {
  final commons.ApiRequester _requester;

  PlayersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Hide the given player's leaderboard scores from the given application. This
   * method is only available to user accounts for your developer console.
   *
   * Request parameters:
   *
   * [applicationId] - The application ID from the Google Play developer
   * console.
   *
   * [playerId] - A player ID. A value of me may be used in place of the
   * authenticated player's ID.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future hide(core.String applicationId, core.String playerId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (applicationId == null) {
      throw new core.ArgumentError("Parameter applicationId is required.");
    }
    if (playerId == null) {
      throw new core.ArgumentError("Parameter playerId is required.");
    }

    _downloadOptions = null;

    _url = 'applications/' + commons.Escaper.ecapeVariable('$applicationId') + '/players/hidden/' + commons.Escaper.ecapeVariable('$playerId');

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
   * Unhide the given player's leaderboard scores from the given application.
   * This method is only available to user accounts for your developer console.
   *
   * Request parameters:
   *
   * [applicationId] - The application ID from the Google Play developer
   * console.
   *
   * [playerId] - A player ID. A value of me may be used in place of the
   * authenticated player's ID.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future unhide(core.String applicationId, core.String playerId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (applicationId == null) {
      throw new core.ArgumentError("Parameter applicationId is required.");
    }
    if (playerId == null) {
      throw new core.ArgumentError("Parameter playerId is required.");
    }

    _downloadOptions = null;

    _url = 'applications/' + commons.Escaper.ecapeVariable('$applicationId') + '/players/hidden/' + commons.Escaper.ecapeVariable('$playerId');

    var _response = _requester.request(_url,
                                       "DELETE",
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
   * Resets all player progress on the quest with the given ID for the currently
   * authenticated player. This method is only accessible to whitelisted tester
   * accounts for your application.
   *
   * Request parameters:
   *
   * [questId] - The ID of the quest.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future reset(core.String questId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (questId == null) {
      throw new core.ArgumentError("Parameter questId is required.");
    }

    _downloadOptions = null;

    _url = 'quests/' + commons.Escaper.ecapeVariable('$questId') + '/reset';

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
   * Resets all player progress on all quests for the currently authenticated
   * player. This method is only accessible to whitelisted tester accounts for
   * your application.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetAll() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _downloadOptions = null;

    _url = 'quests/reset';

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
   * Resets all draft quests for all players. This method is only available to
   * user accounts for your developer console.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetAllForAllPlayers() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _downloadOptions = null;

    _url = 'quests/resetAllForAllPlayers';

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
   * Resets all player progress on the quest with the given ID for all players.
   * This method is only available to user accounts for your developer console.
   * Only draft quests can be reset.
   *
   * Request parameters:
   *
   * [questId] - The ID of the quest.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetForAllPlayers(core.String questId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (questId == null) {
      throw new core.ArgumentError("Parameter questId is required.");
    }

    _downloadOptions = null;

    _url = 'quests/' + commons.Escaper.ecapeVariable('$questId') + '/resetForAllPlayers';

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
   * Resets quests with the given IDs for all players. This method is only
   * available to user accounts for your developer console. Only draft quests
   * may be reset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetMultipleForAllPlayers(QuestsResetMultipleForAllRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _downloadOptions = null;

    _url = 'quests/resetMultipleForAllPlayers';

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


class RoomsResourceApi {
  final commons.ApiRequester _requester;

  RoomsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Reset all rooms for the currently authenticated player for your
   * application. This method is only accessible to whitelisted tester accounts
   * for your application.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future reset() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _downloadOptions = null;

    _url = 'rooms/reset';

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
   * Deletes rooms where the only room participants are from whitelisted tester
   * accounts for your application. This method is only available to user
   * accounts for your developer console.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetForAllPlayers() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _downloadOptions = null;

    _url = 'rooms/resetForAllPlayers';

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


class ScoresResourceApi {
  final commons.ApiRequester _requester;

  ScoresResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Resets scores for the leaderboard with the given ID for the currently
   * authenticated player. This method is only accessible to whitelisted tester
   * accounts for your application.
   *
   * Request parameters:
   *
   * [leaderboardId] - The ID of the leaderboard.
   *
   * Completes with a [PlayerScoreResetResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlayerScoreResetResponse> reset(core.String leaderboardId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (leaderboardId == null) {
      throw new core.ArgumentError("Parameter leaderboardId is required.");
    }

    _url = 'leaderboards/' + commons.Escaper.ecapeVariable('$leaderboardId') + '/scores/reset';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlayerScoreResetResponse.fromJson(data));
  }

  /**
   * Resets all scores for all leaderboards for the currently authenticated
   * players. This method is only accessible to whitelisted tester accounts for
   * your application.
   *
   * Request parameters:
   *
   * Completes with a [PlayerScoreResetAllResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlayerScoreResetAllResponse> resetAll() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'scores/reset';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlayerScoreResetAllResponse.fromJson(data));
  }

  /**
   * Resets scores for all draft leaderboards for all players. This method is
   * only available to user accounts for your developer console.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetAllForAllPlayers() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _downloadOptions = null;

    _url = 'scores/resetAllForAllPlayers';

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
   * Resets scores for the leaderboard with the given ID for all players. This
   * method is only available to user accounts for your developer console. Only
   * draft leaderboards can be reset.
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
  async.Future resetForAllPlayers(core.String leaderboardId) {
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

    _url = 'leaderboards/' + commons.Escaper.ecapeVariable('$leaderboardId') + '/scores/resetForAllPlayers';

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
   * Resets scores for the leaderboards with the given IDs for all players. This
   * method is only available to user accounts for your developer console. Only
   * draft leaderboards may be reset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetMultipleForAllPlayers(ScoresResetMultipleForAllRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _downloadOptions = null;

    _url = 'scores/resetMultipleForAllPlayers';

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


class TurnBasedMatchesResourceApi {
  final commons.ApiRequester _requester;

  TurnBasedMatchesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Reset all turn-based match data for a user. This method is only accessible
   * to whitelisted tester accounts for your application.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future reset() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _downloadOptions = null;

    _url = 'turnbasedmatches/reset';

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
   * Deletes turn-based matches where the only match participants are from
   * whitelisted tester accounts for your application. This method is only
   * available to user accounts for your developer console.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future resetForAllPlayers() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _downloadOptions = null;

    _url = 'turnbasedmatches/resetForAllPlayers';

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



/** This is a JSON template for achievement reset all response. */
class AchievementResetAllResponse {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesManagement#achievementResetAllResponse.
   */
  core.String kind;
  /** The achievement reset results. */
  core.List<AchievementResetResponse> results;

  AchievementResetAllResponse();

  AchievementResetAllResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("results")) {
      results = _json["results"].map((value) => new AchievementResetResponse.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (results != null) {
      _json["results"] = results.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** This is a JSON template for multiple achievements reset all request. */
class AchievementResetMultipleForAllRequest {
  /** The IDs of achievements to reset. */
  core.List<core.String> achievementIds;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesManagement#achievementResetMultipleForAllRequest.
   */
  core.String kind;

  AchievementResetMultipleForAllRequest();

  AchievementResetMultipleForAllRequest.fromJson(core.Map _json) {
    if (_json.containsKey("achievement_ids")) {
      achievementIds = _json["achievement_ids"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (achievementIds != null) {
      _json["achievement_ids"] = achievementIds;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** This is a JSON template for an achievement reset response. */
class AchievementResetResponse {
  /**
   * The current state of the achievement. This is the same as the initial state
   * of the achievement.
   * Possible values are:
   * - "HIDDEN"- Achievement is hidden.
   * - "REVEALED" - Achievement is revealed.
   * - "UNLOCKED" - Achievement is unlocked.
   */
  core.String currentState;
  /** The ID of an achievement for which player state has been updated. */
  core.String definitionId;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesManagement#achievementResetResponse.
   */
  core.String kind;
  /** Flag to indicate if the requested update actually occurred. */
  core.bool updateOccurred;

  AchievementResetResponse();

  AchievementResetResponse.fromJson(core.Map _json) {
    if (_json.containsKey("currentState")) {
      currentState = _json["currentState"];
    }
    if (_json.containsKey("definitionId")) {
      definitionId = _json["definitionId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("updateOccurred")) {
      updateOccurred = _json["updateOccurred"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currentState != null) {
      _json["currentState"] = currentState;
    }
    if (definitionId != null) {
      _json["definitionId"] = definitionId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (updateOccurred != null) {
      _json["updateOccurred"] = updateOccurred;
    }
    return _json;
  }
}

/** This is a JSON template for multiple events reset all request. */
class EventsResetMultipleForAllRequest {
  /** The IDs of events to reset. */
  core.List<core.String> eventIds;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesManagement#eventsResetMultipleForAllRequest.
   */
  core.String kind;

  EventsResetMultipleForAllRequest();

  EventsResetMultipleForAllRequest.fromJson(core.Map _json) {
    if (_json.containsKey("event_ids")) {
      eventIds = _json["event_ids"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (eventIds != null) {
      _json["event_ids"] = eventIds;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/**
 * This is a JSON template for metadata about a player playing a game with the
 * currently authenticated user.
 */
class GamesPlayedResource {
  /**
   * True if the player was auto-matched with the currently authenticated user.
   */
  core.bool autoMatched;
  /**
   * The last time the player played the game in milliseconds since the epoch in
   * UTC.
   */
  core.String timeMillis;

  GamesPlayedResource();

  GamesPlayedResource.fromJson(core.Map _json) {
    if (_json.containsKey("autoMatched")) {
      autoMatched = _json["autoMatched"];
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
    if (timeMillis != null) {
      _json["timeMillis"] = timeMillis;
    }
    return _json;
  }
}

/**
 * This is a JSON template for 1P/3P metadata about the player's experience.
 */
class GamesPlayerExperienceInfoResource {
  /** The current number of experience points for the player. */
  core.String currentExperiencePoints;
  /** The current level of the player. */
  GamesPlayerLevelResource currentLevel;
  /**
   * The timestamp when the player was leveled up, in millis since Unix epoch
   * UTC.
   */
  core.String lastLevelUpTimestampMillis;
  /**
   * The next level of the player. If the current level is the maximum level,
   * this should be same as the current level.
   */
  GamesPlayerLevelResource nextLevel;

  GamesPlayerExperienceInfoResource();

  GamesPlayerExperienceInfoResource.fromJson(core.Map _json) {
    if (_json.containsKey("currentExperiencePoints")) {
      currentExperiencePoints = _json["currentExperiencePoints"];
    }
    if (_json.containsKey("currentLevel")) {
      currentLevel = new GamesPlayerLevelResource.fromJson(_json["currentLevel"]);
    }
    if (_json.containsKey("lastLevelUpTimestampMillis")) {
      lastLevelUpTimestampMillis = _json["lastLevelUpTimestampMillis"];
    }
    if (_json.containsKey("nextLevel")) {
      nextLevel = new GamesPlayerLevelResource.fromJson(_json["nextLevel"]);
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
    if (lastLevelUpTimestampMillis != null) {
      _json["lastLevelUpTimestampMillis"] = lastLevelUpTimestampMillis;
    }
    if (nextLevel != null) {
      _json["nextLevel"] = (nextLevel).toJson();
    }
    return _json;
  }
}

/** This is a JSON template for 1P/3P metadata about a user's level. */
class GamesPlayerLevelResource {
  /** The level for the user. */
  core.int level;
  /** The maximum experience points for this level. */
  core.String maxExperiencePoints;
  /** The minimum experience points for this level. */
  core.String minExperiencePoints;

  GamesPlayerLevelResource();

  GamesPlayerLevelResource.fromJson(core.Map _json) {
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

/** This is a JSON template for the HiddenPlayer resource. */
class HiddenPlayer {
  /** The time this player was hidden. */
  core.String hiddenTimeMillis;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesManagement#hiddenPlayer.
   */
  core.String kind;
  /** The player information. */
  Player player;

  HiddenPlayer();

  HiddenPlayer.fromJson(core.Map _json) {
    if (_json.containsKey("hiddenTimeMillis")) {
      hiddenTimeMillis = _json["hiddenTimeMillis"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("player")) {
      player = new Player.fromJson(_json["player"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (hiddenTimeMillis != null) {
      _json["hiddenTimeMillis"] = hiddenTimeMillis;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (player != null) {
      _json["player"] = (player).toJson();
    }
    return _json;
  }
}

/** This is a JSON template for a list of hidden players. */
class HiddenPlayerList {
  /** The players. */
  core.List<HiddenPlayer> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesManagement#hiddenPlayerList.
   */
  core.String kind;
  /** The pagination token for the next page of results. */
  core.String nextPageToken;

  HiddenPlayerList();

  HiddenPlayerList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new HiddenPlayer.fromJson(value)).toList();
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
  GamesPlayerExperienceInfoResource experienceInfo;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesManagement#player.
   */
  core.String kind;
  /**
   * Details about the last time this player played a multiplayer game with the
   * currently authenticated player. Populated for PLAYED_WITH player collection
   * members.
   */
  GamesPlayedResource lastPlayedWith;
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
      experienceInfo = new GamesPlayerExperienceInfoResource.fromJson(_json["experienceInfo"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastPlayedWith")) {
      lastPlayedWith = new GamesPlayedResource.fromJson(_json["lastPlayedWith"]);
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

/** This is a JSON template for a list of leaderboard reset resources. */
class PlayerScoreResetAllResponse {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesManagement#playerScoreResetResponse.
   */
  core.String kind;
  /** The leaderboard reset results. */
  core.List<PlayerScoreResetResponse> results;

  PlayerScoreResetAllResponse();

  PlayerScoreResetAllResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("results")) {
      results = _json["results"].map((value) => new PlayerScoreResetResponse.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (results != null) {
      _json["results"] = results.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** This is a JSON template for a list of reset leaderboard entry resources. */
class PlayerScoreResetResponse {
  /** The ID of an leaderboard for which player state has been updated. */
  core.String definitionId;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesManagement#playerScoreResetResponse.
   */
  core.String kind;
  /**
   * The time spans of the updated score.
   * Possible values are:
   * - "ALL_TIME" - The score is an all-time score.
   * - "WEEKLY" - The score is a weekly score.
   * - "DAILY" - The score is a daily score.
   */
  core.List<core.String> resetScoreTimeSpans;

  PlayerScoreResetResponse();

  PlayerScoreResetResponse.fromJson(core.Map _json) {
    if (_json.containsKey("definitionId")) {
      definitionId = _json["definitionId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("resetScoreTimeSpans")) {
      resetScoreTimeSpans = _json["resetScoreTimeSpans"];
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
    if (resetScoreTimeSpans != null) {
      _json["resetScoreTimeSpans"] = resetScoreTimeSpans;
    }
    return _json;
  }
}

/** This is a JSON template for profile settings */
class ProfileSettings {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesManagement#profileSettings.
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

/** This is a JSON template for multiple quests reset all request. */
class QuestsResetMultipleForAllRequest {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesManagement#questsResetMultipleForAllRequest.
   */
  core.String kind;
  /** The IDs of quests to reset. */
  core.List<core.String> questIds;

  QuestsResetMultipleForAllRequest();

  QuestsResetMultipleForAllRequest.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("quest_ids")) {
      questIds = _json["quest_ids"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (questIds != null) {
      _json["quest_ids"] = questIds;
    }
    return _json;
  }
}

/** This is a JSON template for multiple scores reset all request. */
class ScoresResetMultipleForAllRequest {
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string gamesManagement#scoresResetMultipleForAllRequest.
   */
  core.String kind;
  /** The IDs of leaderboards to reset. */
  core.List<core.String> leaderboardIds;

  ScoresResetMultipleForAllRequest();

  ScoresResetMultipleForAllRequest.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("leaderboard_ids")) {
      leaderboardIds = _json["leaderboard_ids"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (leaderboardIds != null) {
      _json["leaderboard_ids"] = leaderboardIds;
    }
    return _json;
  }
}
