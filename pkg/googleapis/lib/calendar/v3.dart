// This is a generated file (see the discoveryapis_generator project).

library googleapis.calendar.v3;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client calendar/v3';

/** Manipulates events and other calendar data. */
class CalendarApi {
  /** Manage your calendars */
  static const CalendarScope = "https://www.googleapis.com/auth/calendar";

  /** View your calendars */
  static const CalendarReadonlyScope = "https://www.googleapis.com/auth/calendar.readonly";


  final commons.ApiRequester _requester;

  AclResourceApi get acl => new AclResourceApi(_requester);
  CalendarListResourceApi get calendarList => new CalendarListResourceApi(_requester);
  CalendarsResourceApi get calendars => new CalendarsResourceApi(_requester);
  ChannelsResourceApi get channels => new ChannelsResourceApi(_requester);
  ColorsResourceApi get colors => new ColorsResourceApi(_requester);
  EventsResourceApi get events => new EventsResourceApi(_requester);
  FreebusyResourceApi get freebusy => new FreebusyResourceApi(_requester);
  SettingsResourceApi get settings => new SettingsResourceApi(_requester);

  CalendarApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "calendar/v3/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AclResourceApi {
  final commons.ApiRequester _requester;

  AclResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an access control rule.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [ruleId] - ACL rule identifier.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String calendarId, core.String ruleId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (ruleId == null) {
      throw new core.ArgumentError("Parameter ruleId is required.");
    }

    _downloadOptions = null;

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/acl/' + commons.Escaper.ecapeVariable('$ruleId');

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
   * Returns an access control rule.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [ruleId] - ACL rule identifier.
   *
   * Completes with a [AclRule].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AclRule> get(core.String calendarId, core.String ruleId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (ruleId == null) {
      throw new core.ArgumentError("Parameter ruleId is required.");
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/acl/' + commons.Escaper.ecapeVariable('$ruleId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AclRule.fromJson(data));
  }

  /**
   * Creates an access control rule.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * Completes with a [AclRule].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AclRule> insert(AclRule request, core.String calendarId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/acl';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AclRule.fromJson(data));
  }

  /**
   * Returns the rules in the access control list for the calendar.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [maxResults] - Maximum number of entries returned on one result page. By
   * default the value is 100 entries. The page size can never be larger than
   * 250 entries. Optional.
   *
   * [pageToken] - Token specifying which result page to return. Optional.
   *
   * [showDeleted] - Whether to include deleted ACLs in the result. Deleted ACLs
   * are represented by role equal to "none". Deleted ACLs will always be
   * included if syncToken is provided. Optional. The default is False.
   *
   * [syncToken] - Token obtained from the nextSyncToken field returned on the
   * last page of results from the previous list request. It makes the result of
   * this list request contain only entries that have changed since then. All
   * entries deleted since the previous list request will always be in the
   * result set and it is not allowed to set showDeleted to False.
   * If the syncToken expires, the server will respond with a 410 GONE response
   * code and the client should clear its storage and perform a full
   * synchronization without any syncToken.
   * Learn more about incremental synchronization.
   * Optional. The default is to return all entries.
   *
   * Completes with a [Acl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Acl> list(core.String calendarId, {core.int maxResults, core.String pageToken, core.bool showDeleted, core.String syncToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (showDeleted != null) {
      _queryParams["showDeleted"] = ["${showDeleted}"];
    }
    if (syncToken != null) {
      _queryParams["syncToken"] = [syncToken];
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/acl';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Acl.fromJson(data));
  }

  /**
   * Updates an access control rule. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [ruleId] - ACL rule identifier.
   *
   * Completes with a [AclRule].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AclRule> patch(AclRule request, core.String calendarId, core.String ruleId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (ruleId == null) {
      throw new core.ArgumentError("Parameter ruleId is required.");
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/acl/' + commons.Escaper.ecapeVariable('$ruleId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AclRule.fromJson(data));
  }

  /**
   * Updates an access control rule.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [ruleId] - ACL rule identifier.
   *
   * Completes with a [AclRule].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AclRule> update(AclRule request, core.String calendarId, core.String ruleId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (ruleId == null) {
      throw new core.ArgumentError("Parameter ruleId is required.");
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/acl/' + commons.Escaper.ecapeVariable('$ruleId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AclRule.fromJson(data));
  }

  /**
   * Watch for changes to ACL resources.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [maxResults] - Maximum number of entries returned on one result page. By
   * default the value is 100 entries. The page size can never be larger than
   * 250 entries. Optional.
   *
   * [pageToken] - Token specifying which result page to return. Optional.
   *
   * [showDeleted] - Whether to include deleted ACLs in the result. Deleted ACLs
   * are represented by role equal to "none". Deleted ACLs will always be
   * included if syncToken is provided. Optional. The default is False.
   *
   * [syncToken] - Token obtained from the nextSyncToken field returned on the
   * last page of results from the previous list request. It makes the result of
   * this list request contain only entries that have changed since then. All
   * entries deleted since the previous list request will always be in the
   * result set and it is not allowed to set showDeleted to False.
   * If the syncToken expires, the server will respond with a 410 GONE response
   * code and the client should clear its storage and perform a full
   * synchronization without any syncToken.
   * Learn more about incremental synchronization.
   * Optional. The default is to return all entries.
   *
   * Completes with a [Channel].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Channel> watch(Channel request, core.String calendarId, {core.int maxResults, core.String pageToken, core.bool showDeleted, core.String syncToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (showDeleted != null) {
      _queryParams["showDeleted"] = ["${showDeleted}"];
    }
    if (syncToken != null) {
      _queryParams["syncToken"] = [syncToken];
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/acl/watch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Channel.fromJson(data));
  }

}


class CalendarListResourceApi {
  final commons.ApiRequester _requester;

  CalendarListResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an entry on the user's calendar list.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String calendarId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }

    _downloadOptions = null;

    _url = 'users/me/calendarList/' + commons.Escaper.ecapeVariable('$calendarId');

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
   * Returns an entry on the user's calendar list.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * Completes with a [CalendarListEntry].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CalendarListEntry> get(core.String calendarId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }

    _url = 'users/me/calendarList/' + commons.Escaper.ecapeVariable('$calendarId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CalendarListEntry.fromJson(data));
  }

  /**
   * Adds an entry to the user's calendar list.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [colorRgbFormat] - Whether to use the foregroundColor and backgroundColor
   * fields to write the calendar colors (RGB). If this feature is used, the
   * index-based colorId field will be set to the best matching option
   * automatically. Optional. The default is False.
   *
   * Completes with a [CalendarListEntry].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CalendarListEntry> insert(CalendarListEntry request, {core.bool colorRgbFormat}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (colorRgbFormat != null) {
      _queryParams["colorRgbFormat"] = ["${colorRgbFormat}"];
    }

    _url = 'users/me/calendarList';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CalendarListEntry.fromJson(data));
  }

  /**
   * Returns entries on the user's calendar list.
   *
   * Request parameters:
   *
   * [maxResults] - Maximum number of entries returned on one result page. By
   * default the value is 100 entries. The page size can never be larger than
   * 250 entries. Optional.
   *
   * [minAccessRole] - The minimum access role for the user in the returned
   * entries. Optional. The default is no restriction.
   * Possible string values are:
   * - "freeBusyReader" : The user can read free/busy information.
   * - "owner" : The user can read and modify events and access control lists.
   * - "reader" : The user can read events that are not private.
   * - "writer" : The user can read and modify events.
   *
   * [pageToken] - Token specifying which result page to return. Optional.
   *
   * [showDeleted] - Whether to include deleted calendar list entries in the
   * result. Optional. The default is False.
   *
   * [showHidden] - Whether to show hidden entries. Optional. The default is
   * False.
   *
   * [syncToken] - Token obtained from the nextSyncToken field returned on the
   * last page of results from the previous list request. It makes the result of
   * this list request contain only entries that have changed since then. If
   * only read-only fields such as calendar properties or ACLs have changed, the
   * entry won't be returned. All entries deleted and hidden since the previous
   * list request will always be in the result set and it is not allowed to set
   * showDeleted neither showHidden to False.
   * To ensure client state consistency minAccessRole query parameter cannot be
   * specified together with nextSyncToken.
   * If the syncToken expires, the server will respond with a 410 GONE response
   * code and the client should clear its storage and perform a full
   * synchronization without any syncToken.
   * Learn more about incremental synchronization.
   * Optional. The default is to return all entries.
   *
   * Completes with a [CalendarList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CalendarList> list({core.int maxResults, core.String minAccessRole, core.String pageToken, core.bool showDeleted, core.bool showHidden, core.String syncToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (minAccessRole != null) {
      _queryParams["minAccessRole"] = [minAccessRole];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (showDeleted != null) {
      _queryParams["showDeleted"] = ["${showDeleted}"];
    }
    if (showHidden != null) {
      _queryParams["showHidden"] = ["${showHidden}"];
    }
    if (syncToken != null) {
      _queryParams["syncToken"] = [syncToken];
    }

    _url = 'users/me/calendarList';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CalendarList.fromJson(data));
  }

  /**
   * Updates an entry on the user's calendar list. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [colorRgbFormat] - Whether to use the foregroundColor and backgroundColor
   * fields to write the calendar colors (RGB). If this feature is used, the
   * index-based colorId field will be set to the best matching option
   * automatically. Optional. The default is False.
   *
   * Completes with a [CalendarListEntry].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CalendarListEntry> patch(CalendarListEntry request, core.String calendarId, {core.bool colorRgbFormat}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (colorRgbFormat != null) {
      _queryParams["colorRgbFormat"] = ["${colorRgbFormat}"];
    }

    _url = 'users/me/calendarList/' + commons.Escaper.ecapeVariable('$calendarId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CalendarListEntry.fromJson(data));
  }

  /**
   * Updates an entry on the user's calendar list.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [colorRgbFormat] - Whether to use the foregroundColor and backgroundColor
   * fields to write the calendar colors (RGB). If this feature is used, the
   * index-based colorId field will be set to the best matching option
   * automatically. Optional. The default is False.
   *
   * Completes with a [CalendarListEntry].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CalendarListEntry> update(CalendarListEntry request, core.String calendarId, {core.bool colorRgbFormat}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (colorRgbFormat != null) {
      _queryParams["colorRgbFormat"] = ["${colorRgbFormat}"];
    }

    _url = 'users/me/calendarList/' + commons.Escaper.ecapeVariable('$calendarId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CalendarListEntry.fromJson(data));
  }

  /**
   * Watch for changes to CalendarList resources.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [maxResults] - Maximum number of entries returned on one result page. By
   * default the value is 100 entries. The page size can never be larger than
   * 250 entries. Optional.
   *
   * [minAccessRole] - The minimum access role for the user in the returned
   * entries. Optional. The default is no restriction.
   * Possible string values are:
   * - "freeBusyReader" : The user can read free/busy information.
   * - "owner" : The user can read and modify events and access control lists.
   * - "reader" : The user can read events that are not private.
   * - "writer" : The user can read and modify events.
   *
   * [pageToken] - Token specifying which result page to return. Optional.
   *
   * [showDeleted] - Whether to include deleted calendar list entries in the
   * result. Optional. The default is False.
   *
   * [showHidden] - Whether to show hidden entries. Optional. The default is
   * False.
   *
   * [syncToken] - Token obtained from the nextSyncToken field returned on the
   * last page of results from the previous list request. It makes the result of
   * this list request contain only entries that have changed since then. If
   * only read-only fields such as calendar properties or ACLs have changed, the
   * entry won't be returned. All entries deleted and hidden since the previous
   * list request will always be in the result set and it is not allowed to set
   * showDeleted neither showHidden to False.
   * To ensure client state consistency minAccessRole query parameter cannot be
   * specified together with nextSyncToken.
   * If the syncToken expires, the server will respond with a 410 GONE response
   * code and the client should clear its storage and perform a full
   * synchronization without any syncToken.
   * Learn more about incremental synchronization.
   * Optional. The default is to return all entries.
   *
   * Completes with a [Channel].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Channel> watch(Channel request, {core.int maxResults, core.String minAccessRole, core.String pageToken, core.bool showDeleted, core.bool showHidden, core.String syncToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (minAccessRole != null) {
      _queryParams["minAccessRole"] = [minAccessRole];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (showDeleted != null) {
      _queryParams["showDeleted"] = ["${showDeleted}"];
    }
    if (showHidden != null) {
      _queryParams["showHidden"] = ["${showHidden}"];
    }
    if (syncToken != null) {
      _queryParams["syncToken"] = [syncToken];
    }

    _url = 'users/me/calendarList/watch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Channel.fromJson(data));
  }

}


class CalendarsResourceApi {
  final commons.ApiRequester _requester;

  CalendarsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Clears a primary calendar. This operation deletes all events associated
   * with the primary calendar of an account.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future clear(core.String calendarId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }

    _downloadOptions = null;

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/clear';

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
   * Deletes a secondary calendar. Use calendars.clear for clearing all events
   * on primary calendars.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String calendarId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }

    _downloadOptions = null;

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId');

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
   * Returns metadata for a calendar.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * Completes with a [Calendar].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Calendar> get(core.String calendarId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Calendar.fromJson(data));
  }

  /**
   * Creates a secondary calendar.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Calendar].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Calendar> insert(Calendar request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'calendars';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Calendar.fromJson(data));
  }

  /**
   * Updates metadata for a calendar. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * Completes with a [Calendar].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Calendar> patch(Calendar request, core.String calendarId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Calendar.fromJson(data));
  }

  /**
   * Updates metadata for a calendar.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * Completes with a [Calendar].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Calendar> update(Calendar request, core.String calendarId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Calendar.fromJson(data));
  }

}


class ChannelsResourceApi {
  final commons.ApiRequester _requester;

  ChannelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Stop watching resources through this channel
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
  async.Future stop(Channel request) {
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

    _url = 'channels/stop';

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


class ColorsResourceApi {
  final commons.ApiRequester _requester;

  ColorsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns the color definitions for calendars and events.
   *
   * Request parameters:
   *
   * Completes with a [Colors].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Colors> get() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'colors';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Colors.fromJson(data));
  }

}


class EventsResourceApi {
  final commons.ApiRequester _requester;

  EventsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an event.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [eventId] - Event identifier.
   *
   * [sendNotifications] - Whether to send notifications about the deletion of
   * the event. Optional. The default is False.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String calendarId, core.String eventId, {core.bool sendNotifications}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (eventId == null) {
      throw new core.ArgumentError("Parameter eventId is required.");
    }
    if (sendNotifications != null) {
      _queryParams["sendNotifications"] = ["${sendNotifications}"];
    }

    _downloadOptions = null;

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/events/' + commons.Escaper.ecapeVariable('$eventId');

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
   * Returns an event.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [eventId] - Event identifier.
   *
   * [alwaysIncludeEmail] - Whether to always include a value in the email field
   * for the organizer, creator and attendees, even if no real email is
   * available (i.e. a generated, non-working value will be provided). The use
   * of this option is discouraged and should only be used by clients which
   * cannot handle the absence of an email address value in the mentioned
   * places. Optional. The default is False.
   *
   * [maxAttendees] - The maximum number of attendees to include in the
   * response. If there are more than the specified number of attendees, only
   * the participant is returned. Optional.
   *
   * [timeZone] - Time zone used in the response. Optional. The default is the
   * time zone of the calendar.
   *
   * Completes with a [Event].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Event> get(core.String calendarId, core.String eventId, {core.bool alwaysIncludeEmail, core.int maxAttendees, core.String timeZone}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (eventId == null) {
      throw new core.ArgumentError("Parameter eventId is required.");
    }
    if (alwaysIncludeEmail != null) {
      _queryParams["alwaysIncludeEmail"] = ["${alwaysIncludeEmail}"];
    }
    if (maxAttendees != null) {
      _queryParams["maxAttendees"] = ["${maxAttendees}"];
    }
    if (timeZone != null) {
      _queryParams["timeZone"] = [timeZone];
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/events/' + commons.Escaper.ecapeVariable('$eventId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Event.fromJson(data));
  }

  /**
   * Imports an event. This operation is used to add a private copy of an
   * existing event to a calendar.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [supportsAttachments] - Whether API client performing operation supports
   * event attachments. Optional. The default is False.
   *
   * Completes with a [Event].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Event> import(Event request, core.String calendarId, {core.bool supportsAttachments}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (supportsAttachments != null) {
      _queryParams["supportsAttachments"] = ["${supportsAttachments}"];
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/events/import';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Event.fromJson(data));
  }

  /**
   * Creates an event.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [maxAttendees] - The maximum number of attendees to include in the
   * response. If there are more than the specified number of attendees, only
   * the participant is returned. Optional.
   *
   * [sendNotifications] - Whether to send notifications about the creation of
   * the new event. Optional. The default is False.
   *
   * [supportsAttachments] - Whether API client performing operation supports
   * event attachments. Optional. The default is False.
   *
   * Completes with a [Event].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Event> insert(Event request, core.String calendarId, {core.int maxAttendees, core.bool sendNotifications, core.bool supportsAttachments}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (maxAttendees != null) {
      _queryParams["maxAttendees"] = ["${maxAttendees}"];
    }
    if (sendNotifications != null) {
      _queryParams["sendNotifications"] = ["${sendNotifications}"];
    }
    if (supportsAttachments != null) {
      _queryParams["supportsAttachments"] = ["${supportsAttachments}"];
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/events';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Event.fromJson(data));
  }

  /**
   * Returns instances of the specified recurring event.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [eventId] - Recurring event identifier.
   *
   * [alwaysIncludeEmail] - Whether to always include a value in the email field
   * for the organizer, creator and attendees, even if no real email is
   * available (i.e. a generated, non-working value will be provided). The use
   * of this option is discouraged and should only be used by clients which
   * cannot handle the absence of an email address value in the mentioned
   * places. Optional. The default is False.
   *
   * [maxAttendees] - The maximum number of attendees to include in the
   * response. If there are more than the specified number of attendees, only
   * the participant is returned. Optional.
   *
   * [maxResults] - Maximum number of events returned on one result page. By
   * default the value is 250 events. The page size can never be larger than
   * 2500 events. Optional.
   *
   * [originalStart] - The original start time of the instance in the result.
   * Optional.
   *
   * [pageToken] - Token specifying which result page to return. Optional.
   *
   * [showDeleted] - Whether to include deleted events (with status equals
   * "cancelled") in the result. Cancelled instances of recurring events will
   * still be included if singleEvents is False. Optional. The default is False.
   *
   * [timeMax] - Upper bound (exclusive) for an event's start time to filter by.
   * Optional. The default is not to filter by start time. Must be an RFC3339
   * timestamp with mandatory time zone offset.
   *
   * [timeMin] - Lower bound (inclusive) for an event's end time to filter by.
   * Optional. The default is not to filter by end time. Must be an RFC3339
   * timestamp with mandatory time zone offset.
   *
   * [timeZone] - Time zone used in the response. Optional. The default is the
   * time zone of the calendar.
   *
   * Completes with a [Events].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Events> instances(core.String calendarId, core.String eventId, {core.bool alwaysIncludeEmail, core.int maxAttendees, core.int maxResults, core.String originalStart, core.String pageToken, core.bool showDeleted, core.DateTime timeMax, core.DateTime timeMin, core.String timeZone}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (eventId == null) {
      throw new core.ArgumentError("Parameter eventId is required.");
    }
    if (alwaysIncludeEmail != null) {
      _queryParams["alwaysIncludeEmail"] = ["${alwaysIncludeEmail}"];
    }
    if (maxAttendees != null) {
      _queryParams["maxAttendees"] = ["${maxAttendees}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (originalStart != null) {
      _queryParams["originalStart"] = [originalStart];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (showDeleted != null) {
      _queryParams["showDeleted"] = ["${showDeleted}"];
    }
    if (timeMax != null) {
      _queryParams["timeMax"] = [(timeMax).toIso8601String()];
    }
    if (timeMin != null) {
      _queryParams["timeMin"] = [(timeMin).toIso8601String()];
    }
    if (timeZone != null) {
      _queryParams["timeZone"] = [timeZone];
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/events/' + commons.Escaper.ecapeVariable('$eventId') + '/instances';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Events.fromJson(data));
  }

  /**
   * Returns events on the specified calendar.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [alwaysIncludeEmail] - Whether to always include a value in the email field
   * for the organizer, creator and attendees, even if no real email is
   * available (i.e. a generated, non-working value will be provided). The use
   * of this option is discouraged and should only be used by clients which
   * cannot handle the absence of an email address value in the mentioned
   * places. Optional. The default is False.
   *
   * [iCalUID] - Specifies event ID in the iCalendar format to be included in
   * the response. Optional.
   *
   * [maxAttendees] - The maximum number of attendees to include in the
   * response. If there are more than the specified number of attendees, only
   * the participant is returned. Optional.
   *
   * [maxResults] - Maximum number of events returned on one result page. By
   * default the value is 250 events. The page size can never be larger than
   * 2500 events. Optional.
   *
   * [orderBy] - The order of the events returned in the result. Optional. The
   * default is an unspecified, stable order.
   * Possible string values are:
   * - "startTime" : Order by the start date/time (ascending). This is only
   * available when querying single events (i.e. the parameter singleEvents is
   * True)
   * - "updated" : Order by last modification time (ascending).
   *
   * [pageToken] - Token specifying which result page to return. Optional.
   *
   * [privateExtendedProperty] - Extended properties constraint specified as
   * propertyName=value. Matches only private properties. This parameter might
   * be repeated multiple times to return events that match all given
   * constraints.
   *
   * [q] - Free text search terms to find events that match these terms in any
   * field, except for extended properties. Optional.
   *
   * [sharedExtendedProperty] - Extended properties constraint specified as
   * propertyName=value. Matches only shared properties. This parameter might be
   * repeated multiple times to return events that match all given constraints.
   *
   * [showDeleted] - Whether to include deleted events (with status equals
   * "cancelled") in the result. Cancelled instances of recurring events (but
   * not the underlying recurring event) will still be included if showDeleted
   * and singleEvents are both False. If showDeleted and singleEvents are both
   * True, only single instances of deleted events (but not the underlying
   * recurring events) are returned. Optional. The default is False.
   *
   * [showHiddenInvitations] - Whether to include hidden invitations in the
   * result. Optional. The default is False.
   *
   * [singleEvents] - Whether to expand recurring events into instances and only
   * return single one-off events and instances of recurring events, but not the
   * underlying recurring events themselves. Optional. The default is False.
   *
   * [syncToken] - Token obtained from the nextSyncToken field returned on the
   * last page of results from the previous list request. It makes the result of
   * this list request contain only entries that have changed since then. All
   * events deleted since the previous list request will always be in the result
   * set and it is not allowed to set showDeleted to False.
   * There are several query parameters that cannot be specified together with
   * nextSyncToken to ensure consistency of the client state.
   *
   * These are:
   * - iCalUID
   * - orderBy
   * - privateExtendedProperty
   * - q
   * - sharedExtendedProperty
   * - timeMin
   * - timeMax
   * - updatedMin If the syncToken expires, the server will respond with a 410
   * GONE response code and the client should clear its storage and perform a
   * full synchronization without any syncToken.
   * Learn more about incremental synchronization.
   * Optional. The default is to return all entries.
   *
   * [timeMax] - Upper bound (exclusive) for an event's start time to filter by.
   * Optional. The default is not to filter by start time. Must be an RFC3339
   * timestamp with mandatory time zone offset, e.g., 2011-06-03T10:00:00-07:00,
   * 2011-06-03T10:00:00Z. Milliseconds may be provided but will be ignored.
   *
   * [timeMin] - Lower bound (inclusive) for an event's end time to filter by.
   * Optional. The default is not to filter by end time. Must be an RFC3339
   * timestamp with mandatory time zone offset, e.g., 2011-06-03T10:00:00-07:00,
   * 2011-06-03T10:00:00Z. Milliseconds may be provided but will be ignored.
   *
   * [timeZone] - Time zone used in the response. Optional. The default is the
   * time zone of the calendar.
   *
   * [updatedMin] - Lower bound for an event's last modification time (as a
   * RFC3339 timestamp) to filter by. When specified, entries deleted since this
   * time will always be included regardless of showDeleted. Optional. The
   * default is not to filter by last modification time.
   *
   * Completes with a [Events].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Events> list(core.String calendarId, {core.bool alwaysIncludeEmail, core.String iCalUID, core.int maxAttendees, core.int maxResults, core.String orderBy, core.String pageToken, core.List<core.String> privateExtendedProperty, core.String q, core.List<core.String> sharedExtendedProperty, core.bool showDeleted, core.bool showHiddenInvitations, core.bool singleEvents, core.String syncToken, core.DateTime timeMax, core.DateTime timeMin, core.String timeZone, core.DateTime updatedMin}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (alwaysIncludeEmail != null) {
      _queryParams["alwaysIncludeEmail"] = ["${alwaysIncludeEmail}"];
    }
    if (iCalUID != null) {
      _queryParams["iCalUID"] = [iCalUID];
    }
    if (maxAttendees != null) {
      _queryParams["maxAttendees"] = ["${maxAttendees}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (privateExtendedProperty != null) {
      _queryParams["privateExtendedProperty"] = privateExtendedProperty;
    }
    if (q != null) {
      _queryParams["q"] = [q];
    }
    if (sharedExtendedProperty != null) {
      _queryParams["sharedExtendedProperty"] = sharedExtendedProperty;
    }
    if (showDeleted != null) {
      _queryParams["showDeleted"] = ["${showDeleted}"];
    }
    if (showHiddenInvitations != null) {
      _queryParams["showHiddenInvitations"] = ["${showHiddenInvitations}"];
    }
    if (singleEvents != null) {
      _queryParams["singleEvents"] = ["${singleEvents}"];
    }
    if (syncToken != null) {
      _queryParams["syncToken"] = [syncToken];
    }
    if (timeMax != null) {
      _queryParams["timeMax"] = [(timeMax).toIso8601String()];
    }
    if (timeMin != null) {
      _queryParams["timeMin"] = [(timeMin).toIso8601String()];
    }
    if (timeZone != null) {
      _queryParams["timeZone"] = [timeZone];
    }
    if (updatedMin != null) {
      _queryParams["updatedMin"] = [(updatedMin).toIso8601String()];
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/events';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Events.fromJson(data));
  }

  /**
   * Moves an event to another calendar, i.e. changes an event's organizer.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier of the source calendar where the event
   * currently is on.
   *
   * [eventId] - Event identifier.
   *
   * [destination] - Calendar identifier of the target calendar where the event
   * is to be moved to.
   *
   * [sendNotifications] - Whether to send notifications about the change of the
   * event's organizer. Optional. The default is False.
   *
   * Completes with a [Event].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Event> move(core.String calendarId, core.String eventId, core.String destination, {core.bool sendNotifications}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (eventId == null) {
      throw new core.ArgumentError("Parameter eventId is required.");
    }
    if (destination == null) {
      throw new core.ArgumentError("Parameter destination is required.");
    }
    _queryParams["destination"] = [destination];
    if (sendNotifications != null) {
      _queryParams["sendNotifications"] = ["${sendNotifications}"];
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/events/' + commons.Escaper.ecapeVariable('$eventId') + '/move';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Event.fromJson(data));
  }

  /**
   * Updates an event. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [eventId] - Event identifier.
   *
   * [alwaysIncludeEmail] - Whether to always include a value in the email field
   * for the organizer, creator and attendees, even if no real email is
   * available (i.e. a generated, non-working value will be provided). The use
   * of this option is discouraged and should only be used by clients which
   * cannot handle the absence of an email address value in the mentioned
   * places. Optional. The default is False.
   *
   * [maxAttendees] - The maximum number of attendees to include in the
   * response. If there are more than the specified number of attendees, only
   * the participant is returned. Optional.
   *
   * [sendNotifications] - Whether to send notifications about the event update
   * (e.g. attendee's responses, title changes, etc.). Optional. The default is
   * False.
   *
   * [supportsAttachments] - Whether API client performing operation supports
   * event attachments. Optional. The default is False.
   *
   * Completes with a [Event].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Event> patch(Event request, core.String calendarId, core.String eventId, {core.bool alwaysIncludeEmail, core.int maxAttendees, core.bool sendNotifications, core.bool supportsAttachments}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (eventId == null) {
      throw new core.ArgumentError("Parameter eventId is required.");
    }
    if (alwaysIncludeEmail != null) {
      _queryParams["alwaysIncludeEmail"] = ["${alwaysIncludeEmail}"];
    }
    if (maxAttendees != null) {
      _queryParams["maxAttendees"] = ["${maxAttendees}"];
    }
    if (sendNotifications != null) {
      _queryParams["sendNotifications"] = ["${sendNotifications}"];
    }
    if (supportsAttachments != null) {
      _queryParams["supportsAttachments"] = ["${supportsAttachments}"];
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/events/' + commons.Escaper.ecapeVariable('$eventId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Event.fromJson(data));
  }

  /**
   * Creates an event based on a simple text string.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [text] - The text describing the event to be created.
   *
   * [sendNotifications] - Whether to send notifications about the creation of
   * the event. Optional. The default is False.
   *
   * Completes with a [Event].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Event> quickAdd(core.String calendarId, core.String text, {core.bool sendNotifications}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (text == null) {
      throw new core.ArgumentError("Parameter text is required.");
    }
    _queryParams["text"] = [text];
    if (sendNotifications != null) {
      _queryParams["sendNotifications"] = ["${sendNotifications}"];
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/events/quickAdd';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Event.fromJson(data));
  }

  /**
   * Updates an event.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [eventId] - Event identifier.
   *
   * [alwaysIncludeEmail] - Whether to always include a value in the email field
   * for the organizer, creator and attendees, even if no real email is
   * available (i.e. a generated, non-working value will be provided). The use
   * of this option is discouraged and should only be used by clients which
   * cannot handle the absence of an email address value in the mentioned
   * places. Optional. The default is False.
   *
   * [maxAttendees] - The maximum number of attendees to include in the
   * response. If there are more than the specified number of attendees, only
   * the participant is returned. Optional.
   *
   * [sendNotifications] - Whether to send notifications about the event update
   * (e.g. attendee's responses, title changes, etc.). Optional. The default is
   * False.
   *
   * [supportsAttachments] - Whether API client performing operation supports
   * event attachments. Optional. The default is False.
   *
   * Completes with a [Event].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Event> update(Event request, core.String calendarId, core.String eventId, {core.bool alwaysIncludeEmail, core.int maxAttendees, core.bool sendNotifications, core.bool supportsAttachments}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (eventId == null) {
      throw new core.ArgumentError("Parameter eventId is required.");
    }
    if (alwaysIncludeEmail != null) {
      _queryParams["alwaysIncludeEmail"] = ["${alwaysIncludeEmail}"];
    }
    if (maxAttendees != null) {
      _queryParams["maxAttendees"] = ["${maxAttendees}"];
    }
    if (sendNotifications != null) {
      _queryParams["sendNotifications"] = ["${sendNotifications}"];
    }
    if (supportsAttachments != null) {
      _queryParams["supportsAttachments"] = ["${supportsAttachments}"];
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/events/' + commons.Escaper.ecapeVariable('$eventId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Event.fromJson(data));
  }

  /**
   * Watch for changes to Events resources.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [calendarId] - Calendar identifier. To retrieve calendar IDs call the
   * calendarList.list method. If you want to access the primary calendar of the
   * currently logged in user, use the "primary" keyword.
   *
   * [alwaysIncludeEmail] - Whether to always include a value in the email field
   * for the organizer, creator and attendees, even if no real email is
   * available (i.e. a generated, non-working value will be provided). The use
   * of this option is discouraged and should only be used by clients which
   * cannot handle the absence of an email address value in the mentioned
   * places. Optional. The default is False.
   *
   * [iCalUID] - Specifies event ID in the iCalendar format to be included in
   * the response. Optional.
   *
   * [maxAttendees] - The maximum number of attendees to include in the
   * response. If there are more than the specified number of attendees, only
   * the participant is returned. Optional.
   *
   * [maxResults] - Maximum number of events returned on one result page. By
   * default the value is 250 events. The page size can never be larger than
   * 2500 events. Optional.
   *
   * [orderBy] - The order of the events returned in the result. Optional. The
   * default is an unspecified, stable order.
   * Possible string values are:
   * - "startTime" : Order by the start date/time (ascending). This is only
   * available when querying single events (i.e. the parameter singleEvents is
   * True)
   * - "updated" : Order by last modification time (ascending).
   *
   * [pageToken] - Token specifying which result page to return. Optional.
   *
   * [privateExtendedProperty] - Extended properties constraint specified as
   * propertyName=value. Matches only private properties. This parameter might
   * be repeated multiple times to return events that match all given
   * constraints.
   *
   * [q] - Free text search terms to find events that match these terms in any
   * field, except for extended properties. Optional.
   *
   * [sharedExtendedProperty] - Extended properties constraint specified as
   * propertyName=value. Matches only shared properties. This parameter might be
   * repeated multiple times to return events that match all given constraints.
   *
   * [showDeleted] - Whether to include deleted events (with status equals
   * "cancelled") in the result. Cancelled instances of recurring events (but
   * not the underlying recurring event) will still be included if showDeleted
   * and singleEvents are both False. If showDeleted and singleEvents are both
   * True, only single instances of deleted events (but not the underlying
   * recurring events) are returned. Optional. The default is False.
   *
   * [showHiddenInvitations] - Whether to include hidden invitations in the
   * result. Optional. The default is False.
   *
   * [singleEvents] - Whether to expand recurring events into instances and only
   * return single one-off events and instances of recurring events, but not the
   * underlying recurring events themselves. Optional. The default is False.
   *
   * [syncToken] - Token obtained from the nextSyncToken field returned on the
   * last page of results from the previous list request. It makes the result of
   * this list request contain only entries that have changed since then. All
   * events deleted since the previous list request will always be in the result
   * set and it is not allowed to set showDeleted to False.
   * There are several query parameters that cannot be specified together with
   * nextSyncToken to ensure consistency of the client state.
   *
   * These are:
   * - iCalUID
   * - orderBy
   * - privateExtendedProperty
   * - q
   * - sharedExtendedProperty
   * - timeMin
   * - timeMax
   * - updatedMin If the syncToken expires, the server will respond with a 410
   * GONE response code and the client should clear its storage and perform a
   * full synchronization without any syncToken.
   * Learn more about incremental synchronization.
   * Optional. The default is to return all entries.
   *
   * [timeMax] - Upper bound (exclusive) for an event's start time to filter by.
   * Optional. The default is not to filter by start time. Must be an RFC3339
   * timestamp with mandatory time zone offset, e.g., 2011-06-03T10:00:00-07:00,
   * 2011-06-03T10:00:00Z. Milliseconds may be provided but will be ignored.
   *
   * [timeMin] - Lower bound (inclusive) for an event's end time to filter by.
   * Optional. The default is not to filter by end time. Must be an RFC3339
   * timestamp with mandatory time zone offset, e.g., 2011-06-03T10:00:00-07:00,
   * 2011-06-03T10:00:00Z. Milliseconds may be provided but will be ignored.
   *
   * [timeZone] - Time zone used in the response. Optional. The default is the
   * time zone of the calendar.
   *
   * [updatedMin] - Lower bound for an event's last modification time (as a
   * RFC3339 timestamp) to filter by. When specified, entries deleted since this
   * time will always be included regardless of showDeleted. Optional. The
   * default is not to filter by last modification time.
   *
   * Completes with a [Channel].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Channel> watch(Channel request, core.String calendarId, {core.bool alwaysIncludeEmail, core.String iCalUID, core.int maxAttendees, core.int maxResults, core.String orderBy, core.String pageToken, core.List<core.String> privateExtendedProperty, core.String q, core.List<core.String> sharedExtendedProperty, core.bool showDeleted, core.bool showHiddenInvitations, core.bool singleEvents, core.String syncToken, core.DateTime timeMax, core.DateTime timeMin, core.String timeZone, core.DateTime updatedMin}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (calendarId == null) {
      throw new core.ArgumentError("Parameter calendarId is required.");
    }
    if (alwaysIncludeEmail != null) {
      _queryParams["alwaysIncludeEmail"] = ["${alwaysIncludeEmail}"];
    }
    if (iCalUID != null) {
      _queryParams["iCalUID"] = [iCalUID];
    }
    if (maxAttendees != null) {
      _queryParams["maxAttendees"] = ["${maxAttendees}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (privateExtendedProperty != null) {
      _queryParams["privateExtendedProperty"] = privateExtendedProperty;
    }
    if (q != null) {
      _queryParams["q"] = [q];
    }
    if (sharedExtendedProperty != null) {
      _queryParams["sharedExtendedProperty"] = sharedExtendedProperty;
    }
    if (showDeleted != null) {
      _queryParams["showDeleted"] = ["${showDeleted}"];
    }
    if (showHiddenInvitations != null) {
      _queryParams["showHiddenInvitations"] = ["${showHiddenInvitations}"];
    }
    if (singleEvents != null) {
      _queryParams["singleEvents"] = ["${singleEvents}"];
    }
    if (syncToken != null) {
      _queryParams["syncToken"] = [syncToken];
    }
    if (timeMax != null) {
      _queryParams["timeMax"] = [(timeMax).toIso8601String()];
    }
    if (timeMin != null) {
      _queryParams["timeMin"] = [(timeMin).toIso8601String()];
    }
    if (timeZone != null) {
      _queryParams["timeZone"] = [timeZone];
    }
    if (updatedMin != null) {
      _queryParams["updatedMin"] = [(updatedMin).toIso8601String()];
    }

    _url = 'calendars/' + commons.Escaper.ecapeVariable('$calendarId') + '/events/watch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Channel.fromJson(data));
  }

}


class FreebusyResourceApi {
  final commons.ApiRequester _requester;

  FreebusyResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns free/busy information for a set of calendars.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [FreeBusyResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FreeBusyResponse> query(FreeBusyRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'freeBusy';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FreeBusyResponse.fromJson(data));
  }

}


class SettingsResourceApi {
  final commons.ApiRequester _requester;

  SettingsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a single user setting.
   *
   * Request parameters:
   *
   * [setting] - The id of the user setting.
   *
   * Completes with a [Setting].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Setting> get(core.String setting) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (setting == null) {
      throw new core.ArgumentError("Parameter setting is required.");
    }

    _url = 'users/me/settings/' + commons.Escaper.ecapeVariable('$setting');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Setting.fromJson(data));
  }

  /**
   * Returns all user settings for the authenticated user.
   *
   * Request parameters:
   *
   * [maxResults] - Maximum number of entries returned on one result page. By
   * default the value is 100 entries. The page size can never be larger than
   * 250 entries. Optional.
   *
   * [pageToken] - Token specifying which result page to return. Optional.
   *
   * [syncToken] - Token obtained from the nextSyncToken field returned on the
   * last page of results from the previous list request. It makes the result of
   * this list request contain only entries that have changed since then.
   * If the syncToken expires, the server will respond with a 410 GONE response
   * code and the client should clear its storage and perform a full
   * synchronization without any syncToken.
   * Learn more about incremental synchronization.
   * Optional. The default is to return all entries.
   *
   * Completes with a [Settings].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Settings> list({core.int maxResults, core.String pageToken, core.String syncToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (syncToken != null) {
      _queryParams["syncToken"] = [syncToken];
    }

    _url = 'users/me/settings';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Settings.fromJson(data));
  }

  /**
   * Watch for changes to Settings resources.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [maxResults] - Maximum number of entries returned on one result page. By
   * default the value is 100 entries. The page size can never be larger than
   * 250 entries. Optional.
   *
   * [pageToken] - Token specifying which result page to return. Optional.
   *
   * [syncToken] - Token obtained from the nextSyncToken field returned on the
   * last page of results from the previous list request. It makes the result of
   * this list request contain only entries that have changed since then.
   * If the syncToken expires, the server will respond with a 410 GONE response
   * code and the client should clear its storage and perform a full
   * synchronization without any syncToken.
   * Learn more about incremental synchronization.
   * Optional. The default is to return all entries.
   *
   * Completes with a [Channel].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Channel> watch(Channel request, {core.int maxResults, core.String pageToken, core.String syncToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (syncToken != null) {
      _queryParams["syncToken"] = [syncToken];
    }

    _url = 'users/me/settings/watch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Channel.fromJson(data));
  }

}



class Acl {
  /** ETag of the collection. */
  core.String etag;
  /** List of rules on the access control list. */
  core.List<AclRule> items;
  /** Type of the collection ("calendar#acl"). */
  core.String kind;
  /**
   * Token used to access the next page of this result. Omitted if no further
   * results are available, in which case nextSyncToken is provided.
   */
  core.String nextPageToken;
  /**
   * Token used at a later point in time to retrieve only the entries that have
   * changed since this result was returned. Omitted if further results are
   * available, in which case nextPageToken is provided.
   */
  core.String nextSyncToken;

  Acl();

  Acl.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new AclRule.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("nextSyncToken")) {
      nextSyncToken = _json["nextSyncToken"];
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
    if (nextSyncToken != null) {
      _json["nextSyncToken"] = nextSyncToken;
    }
    return _json;
  }
}

/** The scope of the rule. */
class AclRuleScope {
  /**
   * The type of the scope. Possible values are:
   * - "default" - The public scope. This is the default value.
   * - "user" - Limits the scope to a single user.
   * - "group" - Limits the scope to a group.
   * - "domain" - Limits the scope to a domain.  Note: The permissions granted
   * to the "default", or public, scope apply to any user, authenticated or not.
   */
  core.String type;
  /**
   * The email address of a user or group, or the name of a domain, depending on
   * the scope type. Omitted for type "default".
   */
  core.String value;

  AclRuleScope();

  AclRuleScope.fromJson(core.Map _json) {
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

class AclRule {
  /** ETag of the resource. */
  core.String etag;
  /** Identifier of the ACL rule. */
  core.String id;
  /** Type of the resource ("calendar#aclRule"). */
  core.String kind;
  /**
   * The role assigned to the scope. Possible values are:
   * - "none" - Provides no access.
   * - "freeBusyReader" - Provides read access to free/busy information.
   * - "reader" - Provides read access to the calendar. Private events will
   * appear to users with reader access, but event details will be hidden.
   * - "writer" - Provides read and write access to the calendar. Private events
   * will appear to users with writer access, and event details will be visible.
   * - "owner" - Provides ownership of the calendar. This role has all of the
   * permissions of the writer role with the additional ability to see and
   * manipulate ACLs.
   */
  core.String role;
  /** The scope of the rule. */
  AclRuleScope scope;

  AclRule();

  AclRule.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
    if (_json.containsKey("scope")) {
      scope = new AclRuleScope.fromJson(_json["scope"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (role != null) {
      _json["role"] = role;
    }
    if (scope != null) {
      _json["scope"] = (scope).toJson();
    }
    return _json;
  }
}

class Calendar {
  /** Description of the calendar. Optional. */
  core.String description;
  /** ETag of the resource. */
  core.String etag;
  /**
   * Identifier of the calendar. To retrieve IDs call the calendarList.list()
   * method.
   */
  core.String id;
  /** Type of the resource ("calendar#calendar"). */
  core.String kind;
  /** Geographic location of the calendar as free-form text. Optional. */
  core.String location;
  /** Title of the calendar. */
  core.String summary;
  /**
   * The time zone of the calendar. (Formatted as an IANA Time Zone Database
   * name, e.g. "Europe/Zurich".) Optional.
   */
  core.String timeZone;

  Calendar();

  Calendar.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
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
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("summary")) {
      summary = _json["summary"];
    }
    if (_json.containsKey("timeZone")) {
      timeZone = _json["timeZone"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
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
    if (location != null) {
      _json["location"] = location;
    }
    if (summary != null) {
      _json["summary"] = summary;
    }
    if (timeZone != null) {
      _json["timeZone"] = timeZone;
    }
    return _json;
  }
}

class CalendarList {
  /** ETag of the collection. */
  core.String etag;
  /** Calendars that are present on the user's calendar list. */
  core.List<CalendarListEntry> items;
  /** Type of the collection ("calendar#calendarList"). */
  core.String kind;
  /**
   * Token used to access the next page of this result. Omitted if no further
   * results are available, in which case nextSyncToken is provided.
   */
  core.String nextPageToken;
  /**
   * Token used at a later point in time to retrieve only the entries that have
   * changed since this result was returned. Omitted if further results are
   * available, in which case nextPageToken is provided.
   */
  core.String nextSyncToken;

  CalendarList();

  CalendarList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new CalendarListEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("nextSyncToken")) {
      nextSyncToken = _json["nextSyncToken"];
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
    if (nextSyncToken != null) {
      _json["nextSyncToken"] = nextSyncToken;
    }
    return _json;
  }
}

/**
 * The notifications that the authenticated user is receiving for this calendar.
 */
class CalendarListEntryNotificationSettings {
  /** The list of notifications set for this calendar. */
  core.List<CalendarNotification> notifications;

  CalendarListEntryNotificationSettings();

  CalendarListEntryNotificationSettings.fromJson(core.Map _json) {
    if (_json.containsKey("notifications")) {
      notifications = _json["notifications"].map((value) => new CalendarNotification.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (notifications != null) {
      _json["notifications"] = notifications.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class CalendarListEntry {
  /**
   * The effective access role that the authenticated user has on the calendar.
   * Read-only. Possible values are:
   * - "freeBusyReader" - Provides read access to free/busy information.
   * - "reader" - Provides read access to the calendar. Private events will
   * appear to users with reader access, but event details will be hidden.
   * - "writer" - Provides read and write access to the calendar. Private events
   * will appear to users with writer access, and event details will be visible.
   * - "owner" - Provides ownership of the calendar. This role has all of the
   * permissions of the writer role with the additional ability to see and
   * manipulate ACLs.
   */
  core.String accessRole;
  /**
   * The main color of the calendar in the hexadecimal format "#0088aa". This
   * property supersedes the index-based colorId property. To set or change this
   * property, you need to specify colorRgbFormat=true in the parameters of the
   * insert, update and patch methods. Optional.
   */
  core.String backgroundColor;
  /**
   * The color of the calendar. This is an ID referring to an entry in the
   * calendar section of the colors definition (see the colors endpoint). This
   * property is superseded by the backgroundColor and foregroundColor
   * properties and can be ignored when using these properties. Optional.
   */
  core.String colorId;
  /**
   * The default reminders that the authenticated user has for this calendar.
   */
  core.List<EventReminder> defaultReminders;
  /**
   * Whether this calendar list entry has been deleted from the calendar list.
   * Read-only. Optional. The default is False.
   */
  core.bool deleted;
  /** Description of the calendar. Optional. Read-only. */
  core.String description;
  /** ETag of the resource. */
  core.String etag;
  /**
   * The foreground color of the calendar in the hexadecimal format "#ffffff".
   * This property supersedes the index-based colorId property. To set or change
   * this property, you need to specify colorRgbFormat=true in the parameters of
   * the insert, update and patch methods. Optional.
   */
  core.String foregroundColor;
  /**
   * Whether the calendar has been hidden from the list. Optional. The default
   * is False.
   */
  core.bool hidden;
  /** Identifier of the calendar. */
  core.String id;
  /** Type of the resource ("calendar#calendarListEntry"). */
  core.String kind;
  /**
   * Geographic location of the calendar as free-form text. Optional. Read-only.
   */
  core.String location;
  /**
   * The notifications that the authenticated user is receiving for this
   * calendar.
   */
  CalendarListEntryNotificationSettings notificationSettings;
  /**
   * Whether the calendar is the primary calendar of the authenticated user.
   * Read-only. Optional. The default is False.
   */
  core.bool primary;
  /**
   * Whether the calendar content shows up in the calendar UI. Optional. The
   * default is False.
   */
  core.bool selected;
  /** Title of the calendar. Read-only. */
  core.String summary;
  /**
   * The summary that the authenticated user has set for this calendar.
   * Optional.
   */
  core.String summaryOverride;
  /** The time zone of the calendar. Optional. Read-only. */
  core.String timeZone;

  CalendarListEntry();

  CalendarListEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accessRole")) {
      accessRole = _json["accessRole"];
    }
    if (_json.containsKey("backgroundColor")) {
      backgroundColor = _json["backgroundColor"];
    }
    if (_json.containsKey("colorId")) {
      colorId = _json["colorId"];
    }
    if (_json.containsKey("defaultReminders")) {
      defaultReminders = _json["defaultReminders"].map((value) => new EventReminder.fromJson(value)).toList();
    }
    if (_json.containsKey("deleted")) {
      deleted = _json["deleted"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("foregroundColor")) {
      foregroundColor = _json["foregroundColor"];
    }
    if (_json.containsKey("hidden")) {
      hidden = _json["hidden"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("notificationSettings")) {
      notificationSettings = new CalendarListEntryNotificationSettings.fromJson(_json["notificationSettings"]);
    }
    if (_json.containsKey("primary")) {
      primary = _json["primary"];
    }
    if (_json.containsKey("selected")) {
      selected = _json["selected"];
    }
    if (_json.containsKey("summary")) {
      summary = _json["summary"];
    }
    if (_json.containsKey("summaryOverride")) {
      summaryOverride = _json["summaryOverride"];
    }
    if (_json.containsKey("timeZone")) {
      timeZone = _json["timeZone"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accessRole != null) {
      _json["accessRole"] = accessRole;
    }
    if (backgroundColor != null) {
      _json["backgroundColor"] = backgroundColor;
    }
    if (colorId != null) {
      _json["colorId"] = colorId;
    }
    if (defaultReminders != null) {
      _json["defaultReminders"] = defaultReminders.map((value) => (value).toJson()).toList();
    }
    if (deleted != null) {
      _json["deleted"] = deleted;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (foregroundColor != null) {
      _json["foregroundColor"] = foregroundColor;
    }
    if (hidden != null) {
      _json["hidden"] = hidden;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (notificationSettings != null) {
      _json["notificationSettings"] = (notificationSettings).toJson();
    }
    if (primary != null) {
      _json["primary"] = primary;
    }
    if (selected != null) {
      _json["selected"] = selected;
    }
    if (summary != null) {
      _json["summary"] = summary;
    }
    if (summaryOverride != null) {
      _json["summaryOverride"] = summaryOverride;
    }
    if (timeZone != null) {
      _json["timeZone"] = timeZone;
    }
    return _json;
  }
}

class CalendarNotification {
  /**
   * The method used to deliver the notification. Possible values are:
   * - "email" - Reminders are sent via email.
   * - "sms" - Reminders are sent via SMS. This value is read-only and is
   * ignored on inserts and updates. SMS reminders are only available for G
   * Suite customers.
   */
  core.String method;
  /**
   * The type of notification. Possible values are:
   * - "eventCreation" - Notification sent when a new event is put on the
   * calendar.
   * - "eventChange" - Notification sent when an event is changed.
   * - "eventCancellation" - Notification sent when an event is cancelled.
   * - "eventResponse" - Notification sent when an event is changed.
   * - "agenda" - An agenda with the events of the day (sent out in the
   * morning).
   */
  core.String type;

  CalendarNotification();

  CalendarNotification.fromJson(core.Map _json) {
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (method != null) {
      _json["method"] = method;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class Channel {
  /** The address where notifications are delivered for this channel. */
  core.String address;
  /**
   * Date and time of notification channel expiration, expressed as a Unix
   * timestamp, in milliseconds. Optional.
   */
  core.String expiration;
  /** A UUID or similar unique string that identifies this channel. */
  core.String id;
  /**
   * Identifies this as a notification channel used to watch for changes to a
   * resource. Value: the fixed string "api#channel".
   */
  core.String kind;
  /** Additional parameters controlling delivery channel behavior. Optional. */
  core.Map<core.String, core.String> params;
  /** A Boolean value to indicate whether payload is wanted. Optional. */
  core.bool payload;
  /**
   * An opaque ID that identifies the resource being watched on this channel.
   * Stable across different API versions.
   */
  core.String resourceId;
  /** A version-specific identifier for the watched resource. */
  core.String resourceUri;
  /**
   * An arbitrary string delivered to the target address with each notification
   * delivered over this channel. Optional.
   */
  core.String token;
  /** The type of delivery mechanism used for this channel. */
  core.String type;

  Channel();

  Channel.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = _json["address"];
    }
    if (_json.containsKey("expiration")) {
      expiration = _json["expiration"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("params")) {
      params = _json["params"];
    }
    if (_json.containsKey("payload")) {
      payload = _json["payload"];
    }
    if (_json.containsKey("resourceId")) {
      resourceId = _json["resourceId"];
    }
    if (_json.containsKey("resourceUri")) {
      resourceUri = _json["resourceUri"];
    }
    if (_json.containsKey("token")) {
      token = _json["token"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (address != null) {
      _json["address"] = address;
    }
    if (expiration != null) {
      _json["expiration"] = expiration;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (params != null) {
      _json["params"] = params;
    }
    if (payload != null) {
      _json["payload"] = payload;
    }
    if (resourceId != null) {
      _json["resourceId"] = resourceId;
    }
    if (resourceUri != null) {
      _json["resourceUri"] = resourceUri;
    }
    if (token != null) {
      _json["token"] = token;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class ColorDefinition {
  /** The background color associated with this color definition. */
  core.String background;
  /**
   * The foreground color that can be used to write on top of a background with
   * 'background' color.
   */
  core.String foreground;

  ColorDefinition();

  ColorDefinition.fromJson(core.Map _json) {
    if (_json.containsKey("background")) {
      background = _json["background"];
    }
    if (_json.containsKey("foreground")) {
      foreground = _json["foreground"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (background != null) {
      _json["background"] = background;
    }
    if (foreground != null) {
      _json["foreground"] = foreground;
    }
    return _json;
  }
}

class Colors {
  /**
   * A global palette of calendar colors, mapping from the color ID to its
   * definition. A calendarListEntry resource refers to one of these color IDs
   * in its color field. Read-only.
   */
  core.Map<core.String, ColorDefinition> calendar;
  /**
   * A global palette of event colors, mapping from the color ID to its
   * definition. An event resource may refer to one of these color IDs in its
   * color field. Read-only.
   */
  core.Map<core.String, ColorDefinition> event;
  /** Type of the resource ("calendar#colors"). */
  core.String kind;
  /**
   * Last modification time of the color palette (as a RFC3339 timestamp).
   * Read-only.
   */
  core.DateTime updated;

  Colors();

  Colors.fromJson(core.Map _json) {
    if (_json.containsKey("calendar")) {
      calendar = commons.mapMap(_json["calendar"], (item) => new ColorDefinition.fromJson(item));
    }
    if (_json.containsKey("event")) {
      event = commons.mapMap(_json["event"], (item) => new ColorDefinition.fromJson(item));
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (calendar != null) {
      _json["calendar"] = commons.mapMap(calendar, (item) => (item).toJson());
    }
    if (event != null) {
      _json["event"] = commons.mapMap(event, (item) => (item).toJson());
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

class Error {
  /** Domain, or broad category, of the error. */
  core.String domain;
  /**
   * Specific reason for the error. Some of the possible values are:
   * - "groupTooBig" - The group of users requested is too large for a single
   * query.
   * - "tooManyCalendarsRequested" - The number of calendars requested is too
   * large for a single query.
   * - "notFound" - The requested resource was not found.
   * - "internalError" - The API service has encountered an internal error.
   * Additional error types may be added in the future, so clients should
   * gracefully handle additional error statuses not included in this list.
   */
  core.String reason;

  Error();

  Error.fromJson(core.Map _json) {
    if (_json.containsKey("domain")) {
      domain = _json["domain"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (domain != null) {
      _json["domain"] = domain;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    return _json;
  }
}

/** The creator of the event. Read-only. */
class EventCreator {
  /** The creator's name, if available. */
  core.String displayName;
  /** The creator's email address, if available. */
  core.String email;
  /**
   * The creator's Profile ID, if available. It corresponds to theid field in
   * the People collection of the Google+ API
   */
  core.String id;
  /**
   * Whether the creator corresponds to the calendar on which this copy of the
   * event appears. Read-only. The default is False.
   */
  core.bool self;

  EventCreator();

  EventCreator.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("self")) {
      self = _json["self"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (self != null) {
      _json["self"] = self;
    }
    return _json;
  }
}

/** Extended properties of the event. */
class EventExtendedProperties {
  /**
   * Properties that are private to the copy of the event that appears on this
   * calendar.
   */
  core.Map<core.String, core.String> private;
  /**
   * Properties that are shared between copies of the event on other attendees'
   * calendars.
   */
  core.Map<core.String, core.String> shared;

  EventExtendedProperties();

  EventExtendedProperties.fromJson(core.Map _json) {
    if (_json.containsKey("private")) {
      private = _json["private"];
    }
    if (_json.containsKey("shared")) {
      shared = _json["shared"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (private != null) {
      _json["private"] = private;
    }
    if (shared != null) {
      _json["shared"] = shared;
    }
    return _json;
  }
}

/** A gadget that extends this event. */
class EventGadget {
  /**
   * The gadget's display mode. Optional. Possible values are:
   * - "icon" - The gadget displays next to the event's title in the calendar
   * view.
   * - "chip" - The gadget displays when the event is clicked.
   */
  core.String display;
  /**
   * The gadget's height in pixels. The height must be an integer greater than
   * 0. Optional.
   */
  core.int height;
  /** The gadget's icon URL. The URL scheme must be HTTPS. */
  core.String iconLink;
  /** The gadget's URL. The URL scheme must be HTTPS. */
  core.String link;
  /** Preferences. */
  core.Map<core.String, core.String> preferences;
  /** The gadget's title. */
  core.String title;
  /** The gadget's type. */
  core.String type;
  /**
   * The gadget's width in pixels. The width must be an integer greater than 0.
   * Optional.
   */
  core.int width;

  EventGadget();

  EventGadget.fromJson(core.Map _json) {
    if (_json.containsKey("display")) {
      display = _json["display"];
    }
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("iconLink")) {
      iconLink = _json["iconLink"];
    }
    if (_json.containsKey("link")) {
      link = _json["link"];
    }
    if (_json.containsKey("preferences")) {
      preferences = _json["preferences"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (display != null) {
      _json["display"] = display;
    }
    if (height != null) {
      _json["height"] = height;
    }
    if (iconLink != null) {
      _json["iconLink"] = iconLink;
    }
    if (link != null) {
      _json["link"] = link;
    }
    if (preferences != null) {
      _json["preferences"] = preferences;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/**
 * The organizer of the event. If the organizer is also an attendee, this is
 * indicated with a separate entry in attendees with the organizer field set to
 * True. To change the organizer, use the move operation. Read-only, except when
 * importing an event.
 */
class EventOrganizer {
  /** The organizer's name, if available. */
  core.String displayName;
  /**
   * The organizer's email address, if available. It must be a valid email
   * address as per RFC5322.
   */
  core.String email;
  /**
   * The organizer's Profile ID, if available. It corresponds to theid field in
   * the People collection of the Google+ API
   */
  core.String id;
  /**
   * Whether the organizer corresponds to the calendar on which this copy of the
   * event appears. Read-only. The default is False.
   */
  core.bool self;

  EventOrganizer();

  EventOrganizer.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("self")) {
      self = _json["self"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (self != null) {
      _json["self"] = self;
    }
    return _json;
  }
}

/** Information about the event's reminders for the authenticated user. */
class EventReminders {
  /**
   * If the event doesn't use the default reminders, this lists the reminders
   * specific to the event, or, if not set, indicates that no reminders are set
   * for this event. The maximum number of override reminders is 5.
   */
  core.List<EventReminder> overrides;
  /** Whether the default reminders of the calendar apply to the event. */
  core.bool useDefault;

  EventReminders();

  EventReminders.fromJson(core.Map _json) {
    if (_json.containsKey("overrides")) {
      overrides = _json["overrides"].map((value) => new EventReminder.fromJson(value)).toList();
    }
    if (_json.containsKey("useDefault")) {
      useDefault = _json["useDefault"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (overrides != null) {
      _json["overrides"] = overrides.map((value) => (value).toJson()).toList();
    }
    if (useDefault != null) {
      _json["useDefault"] = useDefault;
    }
    return _json;
  }
}

/**
 * Source from which the event was created. For example, a web page, an email
 * message or any document identifiable by an URL with HTTP or HTTPS scheme. Can
 * only be seen or modified by the creator of the event.
 */
class EventSource {
  /**
   * Title of the source; for example a title of a web page or an email subject.
   */
  core.String title;
  /**
   * URL of the source pointing to a resource. The URL scheme must be HTTP or
   * HTTPS.
   */
  core.String url;

  EventSource();

  EventSource.fromJson(core.Map _json) {
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (title != null) {
      _json["title"] = title;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class Event {
  /**
   * Whether anyone can invite themselves to the event (currently works for
   * Google+ events only). Optional. The default is False.
   */
  core.bool anyoneCanAddSelf;
  /**
   * File attachments for the event. Currently only Google Drive attachments are
   * supported.
   * In order to modify attachments the supportsAttachments request parameter
   * should be set to true.
   * There can be at most 25 attachments per event,
   */
  core.List<EventAttachment> attachments;
  /**
   * The attendees of the event. See the Events with attendees guide for more
   * information on scheduling events with other calendar users.
   */
  core.List<EventAttendee> attendees;
  /**
   * Whether attendees may have been omitted from the event's representation.
   * When retrieving an event, this may be due to a restriction specified by the
   * maxAttendee query parameter. When updating an event, this can be used to
   * only update the participant's response. Optional. The default is False.
   */
  core.bool attendeesOmitted;
  /**
   * The color of the event. This is an ID referring to an entry in the event
   * section of the colors definition (see the  colors endpoint). Optional.
   */
  core.String colorId;
  /** Creation time of the event (as a RFC3339 timestamp). Read-only. */
  core.DateTime created;
  /** The creator of the event. Read-only. */
  EventCreator creator;
  /** Description of the event. Optional. */
  core.String description;
  /**
   * The (exclusive) end time of the event. For a recurring event, this is the
   * end time of the first instance.
   */
  EventDateTime end;
  /**
   * Whether the end time is actually unspecified. An end time is still provided
   * for compatibility reasons, even if this attribute is set to True. The
   * default is False.
   */
  core.bool endTimeUnspecified;
  /** ETag of the resource. */
  core.String etag;
  /** Extended properties of the event. */
  EventExtendedProperties extendedProperties;
  /** A gadget that extends this event. */
  EventGadget gadget;
  /**
   * Whether attendees other than the organizer can invite others to the event.
   * Optional. The default is True.
   */
  core.bool guestsCanInviteOthers;
  /**
   * Whether attendees other than the organizer can modify the event. Optional.
   * The default is False.
   */
  core.bool guestsCanModify;
  /**
   * Whether attendees other than the organizer can see who the event's
   * attendees are. Optional. The default is True.
   */
  core.bool guestsCanSeeOtherGuests;
  /**
   * An absolute link to the Google+ hangout associated with this event.
   * Read-only.
   */
  core.String hangoutLink;
  /**
   * An absolute link to this event in the Google Calendar Web UI. Read-only.
   */
  core.String htmlLink;
  /**
   * Event unique identifier as defined in RFC5545. It is used to uniquely
   * identify events accross calendaring systems and must be supplied when
   * importing events via the import method.
   * Note that the icalUID and the id are not identical and only one of them
   * should be supplied at event creation time. One difference in their
   * semantics is that in recurring events, all occurrences of one event have
   * different ids while they all share the same icalUIDs.
   */
  core.String iCalUID;
  /**
   * Opaque identifier of the event. When creating new single or recurring
   * events, you can specify their IDs. Provided IDs must follow these rules:
   * - characters allowed in the ID are those used in base32hex encoding, i.e.
   * lowercase letters a-v and digits 0-9, see section 3.1.2 in RFC2938
   * - the length of the ID must be between 5 and 1024 characters
   * - the ID must be unique per calendar  Due to the globally distributed
   * nature of the system, we cannot guarantee that ID collisions will be
   * detected at event creation time. To minimize the risk of collisions we
   * recommend using an established UUID algorithm such as one described in
   * RFC4122.
   * If you do not specify an ID, it will be automatically generated by the
   * server.
   * Note that the icalUID and the id are not identical and only one of them
   * should be supplied at event creation time. One difference in their
   * semantics is that in recurring events, all occurrences of one event have
   * different ids while they all share the same icalUIDs.
   */
  core.String id;
  /** Type of the resource ("calendar#event"). */
  core.String kind;
  /** Geographic location of the event as free-form text. Optional. */
  core.String location;
  /**
   * Whether this is a locked event copy where no changes can be made to the
   * main event fields "summary", "description", "location", "start", "end" or
   * "recurrence". The default is False. Read-Only.
   */
  core.bool locked;
  /**
   * The organizer of the event. If the organizer is also an attendee, this is
   * indicated with a separate entry in attendees with the organizer field set
   * to True. To change the organizer, use the move operation. Read-only, except
   * when importing an event.
   */
  EventOrganizer organizer;
  /**
   * For an instance of a recurring event, this is the time at which this event
   * would start according to the recurrence data in the recurring event
   * identified by recurringEventId. Immutable.
   */
  EventDateTime originalStartTime;
  /**
   * Whether this is a private event copy where changes are not shared with
   * other copies on other calendars. Optional. Immutable. The default is False.
   */
  core.bool privateCopy;
  /**
   * List of RRULE, EXRULE, RDATE and EXDATE lines for a recurring event, as
   * specified in RFC5545. Note that DTSTART and DTEND lines are not allowed in
   * this field; event start and end times are specified in the start and end
   * fields. This field is omitted for single events or instances of recurring
   * events.
   */
  core.List<core.String> recurrence;
  /**
   * For an instance of a recurring event, this is the id of the recurring event
   * to which this instance belongs. Immutable.
   */
  core.String recurringEventId;
  /** Information about the event's reminders for the authenticated user. */
  EventReminders reminders;
  /** Sequence number as per iCalendar. */
  core.int sequence;
  /**
   * Source from which the event was created. For example, a web page, an email
   * message or any document identifiable by an URL with HTTP or HTTPS scheme.
   * Can only be seen or modified by the creator of the event.
   */
  EventSource source;
  /**
   * The (inclusive) start time of the event. For a recurring event, this is the
   * start time of the first instance.
   */
  EventDateTime start;
  /**
   * Status of the event. Optional. Possible values are:
   * - "confirmed" - The event is confirmed. This is the default status.
   * - "tentative" - The event is tentatively confirmed.
   * - "cancelled" - The event is cancelled.
   */
  core.String status;
  /** Title of the event. */
  core.String summary;
  /**
   * Whether the event blocks time on the calendar. Optional. Possible values
   * are:
   * - "opaque" - The event blocks time on the calendar. This is the default
   * value.
   * - "transparent" - The event does not block time on the calendar.
   */
  core.String transparency;
  /**
   * Last modification time of the event (as a RFC3339 timestamp). Read-only.
   */
  core.DateTime updated;
  /**
   * Visibility of the event. Optional. Possible values are:
   * - "default" - Uses the default visibility for events on the calendar. This
   * is the default value.
   * - "public" - The event is public and event details are visible to all
   * readers of the calendar.
   * - "private" - The event is private and only event attendees may view event
   * details.
   * - "confidential" - The event is private. This value is provided for
   * compatibility reasons.
   */
  core.String visibility;

  Event();

  Event.fromJson(core.Map _json) {
    if (_json.containsKey("anyoneCanAddSelf")) {
      anyoneCanAddSelf = _json["anyoneCanAddSelf"];
    }
    if (_json.containsKey("attachments")) {
      attachments = _json["attachments"].map((value) => new EventAttachment.fromJson(value)).toList();
    }
    if (_json.containsKey("attendees")) {
      attendees = _json["attendees"].map((value) => new EventAttendee.fromJson(value)).toList();
    }
    if (_json.containsKey("attendeesOmitted")) {
      attendeesOmitted = _json["attendeesOmitted"];
    }
    if (_json.containsKey("colorId")) {
      colorId = _json["colorId"];
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("creator")) {
      creator = new EventCreator.fromJson(_json["creator"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("end")) {
      end = new EventDateTime.fromJson(_json["end"]);
    }
    if (_json.containsKey("endTimeUnspecified")) {
      endTimeUnspecified = _json["endTimeUnspecified"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("extendedProperties")) {
      extendedProperties = new EventExtendedProperties.fromJson(_json["extendedProperties"]);
    }
    if (_json.containsKey("gadget")) {
      gadget = new EventGadget.fromJson(_json["gadget"]);
    }
    if (_json.containsKey("guestsCanInviteOthers")) {
      guestsCanInviteOthers = _json["guestsCanInviteOthers"];
    }
    if (_json.containsKey("guestsCanModify")) {
      guestsCanModify = _json["guestsCanModify"];
    }
    if (_json.containsKey("guestsCanSeeOtherGuests")) {
      guestsCanSeeOtherGuests = _json["guestsCanSeeOtherGuests"];
    }
    if (_json.containsKey("hangoutLink")) {
      hangoutLink = _json["hangoutLink"];
    }
    if (_json.containsKey("htmlLink")) {
      htmlLink = _json["htmlLink"];
    }
    if (_json.containsKey("iCalUID")) {
      iCalUID = _json["iCalUID"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("locked")) {
      locked = _json["locked"];
    }
    if (_json.containsKey("organizer")) {
      organizer = new EventOrganizer.fromJson(_json["organizer"]);
    }
    if (_json.containsKey("originalStartTime")) {
      originalStartTime = new EventDateTime.fromJson(_json["originalStartTime"]);
    }
    if (_json.containsKey("privateCopy")) {
      privateCopy = _json["privateCopy"];
    }
    if (_json.containsKey("recurrence")) {
      recurrence = _json["recurrence"];
    }
    if (_json.containsKey("recurringEventId")) {
      recurringEventId = _json["recurringEventId"];
    }
    if (_json.containsKey("reminders")) {
      reminders = new EventReminders.fromJson(_json["reminders"]);
    }
    if (_json.containsKey("sequence")) {
      sequence = _json["sequence"];
    }
    if (_json.containsKey("source")) {
      source = new EventSource.fromJson(_json["source"]);
    }
    if (_json.containsKey("start")) {
      start = new EventDateTime.fromJson(_json["start"]);
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("summary")) {
      summary = _json["summary"];
    }
    if (_json.containsKey("transparency")) {
      transparency = _json["transparency"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("visibility")) {
      visibility = _json["visibility"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (anyoneCanAddSelf != null) {
      _json["anyoneCanAddSelf"] = anyoneCanAddSelf;
    }
    if (attachments != null) {
      _json["attachments"] = attachments.map((value) => (value).toJson()).toList();
    }
    if (attendees != null) {
      _json["attendees"] = attendees.map((value) => (value).toJson()).toList();
    }
    if (attendeesOmitted != null) {
      _json["attendeesOmitted"] = attendeesOmitted;
    }
    if (colorId != null) {
      _json["colorId"] = colorId;
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (creator != null) {
      _json["creator"] = (creator).toJson();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (end != null) {
      _json["end"] = (end).toJson();
    }
    if (endTimeUnspecified != null) {
      _json["endTimeUnspecified"] = endTimeUnspecified;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (extendedProperties != null) {
      _json["extendedProperties"] = (extendedProperties).toJson();
    }
    if (gadget != null) {
      _json["gadget"] = (gadget).toJson();
    }
    if (guestsCanInviteOthers != null) {
      _json["guestsCanInviteOthers"] = guestsCanInviteOthers;
    }
    if (guestsCanModify != null) {
      _json["guestsCanModify"] = guestsCanModify;
    }
    if (guestsCanSeeOtherGuests != null) {
      _json["guestsCanSeeOtherGuests"] = guestsCanSeeOtherGuests;
    }
    if (hangoutLink != null) {
      _json["hangoutLink"] = hangoutLink;
    }
    if (htmlLink != null) {
      _json["htmlLink"] = htmlLink;
    }
    if (iCalUID != null) {
      _json["iCalUID"] = iCalUID;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (locked != null) {
      _json["locked"] = locked;
    }
    if (organizer != null) {
      _json["organizer"] = (organizer).toJson();
    }
    if (originalStartTime != null) {
      _json["originalStartTime"] = (originalStartTime).toJson();
    }
    if (privateCopy != null) {
      _json["privateCopy"] = privateCopy;
    }
    if (recurrence != null) {
      _json["recurrence"] = recurrence;
    }
    if (recurringEventId != null) {
      _json["recurringEventId"] = recurringEventId;
    }
    if (reminders != null) {
      _json["reminders"] = (reminders).toJson();
    }
    if (sequence != null) {
      _json["sequence"] = sequence;
    }
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    if (start != null) {
      _json["start"] = (start).toJson();
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (summary != null) {
      _json["summary"] = summary;
    }
    if (transparency != null) {
      _json["transparency"] = transparency;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (visibility != null) {
      _json["visibility"] = visibility;
    }
    return _json;
  }
}

class EventAttachment {
  /**
   * ID of the attached file. Read-only.
   * For Google Drive files, this is the ID of the corresponding Files resource
   * entry in the Drive API.
   */
  core.String fileId;
  /**
   * URL link to the attachment.
   * For adding Google Drive file attachments use the same format as in
   * alternateLink property of the Files resource in the Drive API.
   */
  core.String fileUrl;
  /** URL link to the attachment's icon. Read-only. */
  core.String iconLink;
  /** Internet media type (MIME type) of the attachment. */
  core.String mimeType;
  /** Attachment title. */
  core.String title;

  EventAttachment();

  EventAttachment.fromJson(core.Map _json) {
    if (_json.containsKey("fileId")) {
      fileId = _json["fileId"];
    }
    if (_json.containsKey("fileUrl")) {
      fileUrl = _json["fileUrl"];
    }
    if (_json.containsKey("iconLink")) {
      iconLink = _json["iconLink"];
    }
    if (_json.containsKey("mimeType")) {
      mimeType = _json["mimeType"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fileId != null) {
      _json["fileId"] = fileId;
    }
    if (fileUrl != null) {
      _json["fileUrl"] = fileUrl;
    }
    if (iconLink != null) {
      _json["iconLink"] = iconLink;
    }
    if (mimeType != null) {
      _json["mimeType"] = mimeType;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class EventAttendee {
  /** Number of additional guests. Optional. The default is 0. */
  core.int additionalGuests;
  /** The attendee's response comment. Optional. */
  core.String comment;
  /** The attendee's name, if available. Optional. */
  core.String displayName;
  /**
   * The attendee's email address, if available. This field must be present when
   * adding an attendee. It must be a valid email address as per RFC5322.
   */
  core.String email;
  /**
   * The attendee's Profile ID, if available. It corresponds to theid field in
   * the People collection of the Google+ API
   */
  core.String id;
  /** Whether this is an optional attendee. Optional. The default is False. */
  core.bool optional;
  /**
   * Whether the attendee is the organizer of the event. Read-only. The default
   * is False.
   */
  core.bool organizer;
  /** Whether the attendee is a resource. Read-only. The default is False. */
  core.bool resource;
  /**
   * The attendee's response status. Possible values are:
   * - "needsAction" - The attendee has not responded to the invitation.
   * - "declined" - The attendee has declined the invitation.
   * - "tentative" - The attendee has tentatively accepted the invitation.
   * - "accepted" - The attendee has accepted the invitation.
   */
  core.String responseStatus;
  /**
   * Whether this entry represents the calendar on which this copy of the event
   * appears. Read-only. The default is False.
   */
  core.bool self;

  EventAttendee();

  EventAttendee.fromJson(core.Map _json) {
    if (_json.containsKey("additionalGuests")) {
      additionalGuests = _json["additionalGuests"];
    }
    if (_json.containsKey("comment")) {
      comment = _json["comment"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("optional")) {
      optional = _json["optional"];
    }
    if (_json.containsKey("organizer")) {
      organizer = _json["organizer"];
    }
    if (_json.containsKey("resource")) {
      resource = _json["resource"];
    }
    if (_json.containsKey("responseStatus")) {
      responseStatus = _json["responseStatus"];
    }
    if (_json.containsKey("self")) {
      self = _json["self"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (additionalGuests != null) {
      _json["additionalGuests"] = additionalGuests;
    }
    if (comment != null) {
      _json["comment"] = comment;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (optional != null) {
      _json["optional"] = optional;
    }
    if (organizer != null) {
      _json["organizer"] = organizer;
    }
    if (resource != null) {
      _json["resource"] = resource;
    }
    if (responseStatus != null) {
      _json["responseStatus"] = responseStatus;
    }
    if (self != null) {
      _json["self"] = self;
    }
    return _json;
  }
}

class EventDateTime {
  /** The date, in the format "yyyy-mm-dd", if this is an all-day event. */
  core.DateTime date;
  /**
   * The time, as a combined date-time value (formatted according to RFC3339). A
   * time zone offset is required unless a time zone is explicitly specified in
   * timeZone.
   */
  core.DateTime dateTime;
  /**
   * The time zone in which the time is specified. (Formatted as an IANA Time
   * Zone Database name, e.g. "Europe/Zurich".) For recurring events this field
   * is required and specifies the time zone in which the recurrence is
   * expanded. For single events this field is optional and indicates a custom
   * time zone for the event start/end.
   */
  core.String timeZone;

  EventDateTime();

  EventDateTime.fromJson(core.Map _json) {
    if (_json.containsKey("date")) {
      date = core.DateTime.parse(_json["date"]);
    }
    if (_json.containsKey("dateTime")) {
      dateTime = core.DateTime.parse(_json["dateTime"]);
    }
    if (_json.containsKey("timeZone")) {
      timeZone = _json["timeZone"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (date != null) {
      _json["date"] = "${(date).year.toString().padLeft(4, '0')}-${(date).month.toString().padLeft(2, '0')}-${(date).day.toString().padLeft(2, '0')}";
    }
    if (dateTime != null) {
      _json["dateTime"] = (dateTime).toIso8601String();
    }
    if (timeZone != null) {
      _json["timeZone"] = timeZone;
    }
    return _json;
  }
}

class EventReminder {
  /**
   * The method used by this reminder. Possible values are:
   * - "email" - Reminders are sent via email.
   * - "sms" - Reminders are sent via SMS. These are only available for G Suite
   * customers. Requests to set SMS reminders for other account types are
   * ignored.
   * - "popup" - Reminders are sent via a UI popup.
   */
  core.String method;
  /**
   * Number of minutes before the start of the event when the reminder should
   * trigger. Valid values are between 0 and 40320 (4 weeks in minutes).
   */
  core.int minutes;

  EventReminder();

  EventReminder.fromJson(core.Map _json) {
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("minutes")) {
      minutes = _json["minutes"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (method != null) {
      _json["method"] = method;
    }
    if (minutes != null) {
      _json["minutes"] = minutes;
    }
    return _json;
  }
}

class Events {
  /**
   * The user's access role for this calendar. Read-only. Possible values are:
   * - "none" - The user has no access.
   * - "freeBusyReader" - The user has read access to free/busy information.
   * - "reader" - The user has read access to the calendar. Private events will
   * appear to users with reader access, but event details will be hidden.
   * - "writer" - The user has read and write access to the calendar. Private
   * events will appear to users with writer access, and event details will be
   * visible.
   * - "owner" - The user has ownership of the calendar. This role has all of
   * the permissions of the writer role with the additional ability to see and
   * manipulate ACLs.
   */
  core.String accessRole;
  /**
   * The default reminders on the calendar for the authenticated user. These
   * reminders apply to all events on this calendar that do not explicitly
   * override them (i.e. do not have reminders.useDefault set to True).
   */
  core.List<EventReminder> defaultReminders;
  /** Description of the calendar. Read-only. */
  core.String description;
  /** ETag of the collection. */
  core.String etag;
  /** List of events on the calendar. */
  core.List<Event> items;
  /** Type of the collection ("calendar#events"). */
  core.String kind;
  /**
   * Token used to access the next page of this result. Omitted if no further
   * results are available, in which case nextSyncToken is provided.
   */
  core.String nextPageToken;
  /**
   * Token used at a later point in time to retrieve only the entries that have
   * changed since this result was returned. Omitted if further results are
   * available, in which case nextPageToken is provided.
   */
  core.String nextSyncToken;
  /** Title of the calendar. Read-only. */
  core.String summary;
  /** The time zone of the calendar. Read-only. */
  core.String timeZone;
  /**
   * Last modification time of the calendar (as a RFC3339 timestamp). Read-only.
   */
  core.DateTime updated;

  Events();

  Events.fromJson(core.Map _json) {
    if (_json.containsKey("accessRole")) {
      accessRole = _json["accessRole"];
    }
    if (_json.containsKey("defaultReminders")) {
      defaultReminders = _json["defaultReminders"].map((value) => new EventReminder.fromJson(value)).toList();
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Event.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("nextSyncToken")) {
      nextSyncToken = _json["nextSyncToken"];
    }
    if (_json.containsKey("summary")) {
      summary = _json["summary"];
    }
    if (_json.containsKey("timeZone")) {
      timeZone = _json["timeZone"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accessRole != null) {
      _json["accessRole"] = accessRole;
    }
    if (defaultReminders != null) {
      _json["defaultReminders"] = defaultReminders.map((value) => (value).toJson()).toList();
    }
    if (description != null) {
      _json["description"] = description;
    }
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
    if (nextSyncToken != null) {
      _json["nextSyncToken"] = nextSyncToken;
    }
    if (summary != null) {
      _json["summary"] = summary;
    }
    if (timeZone != null) {
      _json["timeZone"] = timeZone;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

class FreeBusyCalendar {
  /**
   * List of time ranges during which this calendar should be regarded as busy.
   */
  core.List<TimePeriod> busy;
  /** Optional error(s) (if computation for the calendar failed). */
  core.List<Error> errors;

  FreeBusyCalendar();

  FreeBusyCalendar.fromJson(core.Map _json) {
    if (_json.containsKey("busy")) {
      busy = _json["busy"].map((value) => new TimePeriod.fromJson(value)).toList();
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"].map((value) => new Error.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (busy != null) {
      _json["busy"] = busy.map((value) => (value).toJson()).toList();
    }
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class FreeBusyGroup {
  /** List of calendars' identifiers within a group. */
  core.List<core.String> calendars;
  /** Optional error(s) (if computation for the group failed). */
  core.List<Error> errors;

  FreeBusyGroup();

  FreeBusyGroup.fromJson(core.Map _json) {
    if (_json.containsKey("calendars")) {
      calendars = _json["calendars"];
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"].map((value) => new Error.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (calendars != null) {
      _json["calendars"] = calendars;
    }
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class FreeBusyRequest {
  /**
   * Maximal number of calendars for which FreeBusy information is to be
   * provided. Optional.
   */
  core.int calendarExpansionMax;
  /**
   * Maximal number of calendar identifiers to be provided for a single group.
   * Optional. An error will be returned for a group with more members than this
   * value.
   */
  core.int groupExpansionMax;
  /** List of calendars and/or groups to query. */
  core.List<FreeBusyRequestItem> items;
  /** The end of the interval for the query. */
  core.DateTime timeMax;
  /** The start of the interval for the query. */
  core.DateTime timeMin;
  /** Time zone used in the response. Optional. The default is UTC. */
  core.String timeZone;

  FreeBusyRequest();

  FreeBusyRequest.fromJson(core.Map _json) {
    if (_json.containsKey("calendarExpansionMax")) {
      calendarExpansionMax = _json["calendarExpansionMax"];
    }
    if (_json.containsKey("groupExpansionMax")) {
      groupExpansionMax = _json["groupExpansionMax"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new FreeBusyRequestItem.fromJson(value)).toList();
    }
    if (_json.containsKey("timeMax")) {
      timeMax = core.DateTime.parse(_json["timeMax"]);
    }
    if (_json.containsKey("timeMin")) {
      timeMin = core.DateTime.parse(_json["timeMin"]);
    }
    if (_json.containsKey("timeZone")) {
      timeZone = _json["timeZone"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (calendarExpansionMax != null) {
      _json["calendarExpansionMax"] = calendarExpansionMax;
    }
    if (groupExpansionMax != null) {
      _json["groupExpansionMax"] = groupExpansionMax;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (timeMax != null) {
      _json["timeMax"] = (timeMax).toIso8601String();
    }
    if (timeMin != null) {
      _json["timeMin"] = (timeMin).toIso8601String();
    }
    if (timeZone != null) {
      _json["timeZone"] = timeZone;
    }
    return _json;
  }
}

class FreeBusyRequestItem {
  /** The identifier of a calendar or a group. */
  core.String id;

  FreeBusyRequestItem();

  FreeBusyRequestItem.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    return _json;
  }
}

class FreeBusyResponse {
  /** List of free/busy information for calendars. */
  core.Map<core.String, FreeBusyCalendar> calendars;
  /** Expansion of groups. */
  core.Map<core.String, FreeBusyGroup> groups;
  /** Type of the resource ("calendar#freeBusy"). */
  core.String kind;
  /** The end of the interval. */
  core.DateTime timeMax;
  /** The start of the interval. */
  core.DateTime timeMin;

  FreeBusyResponse();

  FreeBusyResponse.fromJson(core.Map _json) {
    if (_json.containsKey("calendars")) {
      calendars = commons.mapMap(_json["calendars"], (item) => new FreeBusyCalendar.fromJson(item));
    }
    if (_json.containsKey("groups")) {
      groups = commons.mapMap(_json["groups"], (item) => new FreeBusyGroup.fromJson(item));
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("timeMax")) {
      timeMax = core.DateTime.parse(_json["timeMax"]);
    }
    if (_json.containsKey("timeMin")) {
      timeMin = core.DateTime.parse(_json["timeMin"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (calendars != null) {
      _json["calendars"] = commons.mapMap(calendars, (item) => (item).toJson());
    }
    if (groups != null) {
      _json["groups"] = commons.mapMap(groups, (item) => (item).toJson());
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (timeMax != null) {
      _json["timeMax"] = (timeMax).toIso8601String();
    }
    if (timeMin != null) {
      _json["timeMin"] = (timeMin).toIso8601String();
    }
    return _json;
  }
}

class Setting {
  /** ETag of the resource. */
  core.String etag;
  /** The id of the user setting. */
  core.String id;
  /** Type of the resource ("calendar#setting"). */
  core.String kind;
  /**
   * Value of the user setting. The format of the value depends on the ID of the
   * setting. It must always be a UTF-8 string of length up to 1024 characters.
   */
  core.String value;

  Setting();

  Setting.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
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
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
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

class Settings {
  /** Etag of the collection. */
  core.String etag;
  /** List of user settings. */
  core.List<Setting> items;
  /** Type of the collection ("calendar#settings"). */
  core.String kind;
  /**
   * Token used to access the next page of this result. Omitted if no further
   * results are available, in which case nextSyncToken is provided.
   */
  core.String nextPageToken;
  /**
   * Token used at a later point in time to retrieve only the entries that have
   * changed since this result was returned. Omitted if further results are
   * available, in which case nextPageToken is provided.
   */
  core.String nextSyncToken;

  Settings();

  Settings.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Setting.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("nextSyncToken")) {
      nextSyncToken = _json["nextSyncToken"];
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
    if (nextSyncToken != null) {
      _json["nextSyncToken"] = nextSyncToken;
    }
    return _json;
  }
}

class TimePeriod {
  /** The (exclusive) end of the time period. */
  core.DateTime end;
  /** The (inclusive) start of the time period. */
  core.DateTime start;

  TimePeriod();

  TimePeriod.fromJson(core.Map _json) {
    if (_json.containsKey("end")) {
      end = core.DateTime.parse(_json["end"]);
    }
    if (_json.containsKey("start")) {
      start = core.DateTime.parse(_json["start"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (end != null) {
      _json["end"] = (end).toIso8601String();
    }
    if (start != null) {
      _json["start"] = (start).toIso8601String();
    }
    return _json;
  }
}
