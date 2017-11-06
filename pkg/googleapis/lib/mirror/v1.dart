// This is a generated file (see the discoveryapis_generator project).

library googleapis.mirror.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client mirror/v1';

/** Interacts with Glass users via the timeline. */
class MirrorApi {
  /** View your location */
  static const GlassLocationScope = "https://www.googleapis.com/auth/glass.location";

  /** View and manage your Glass timeline */
  static const GlassTimelineScope = "https://www.googleapis.com/auth/glass.timeline";


  final commons.ApiRequester _requester;

  AccountsResourceApi get accounts => new AccountsResourceApi(_requester);
  ContactsResourceApi get contacts => new ContactsResourceApi(_requester);
  LocationsResourceApi get locations => new LocationsResourceApi(_requester);
  SettingsResourceApi get settings => new SettingsResourceApi(_requester);
  SubscriptionsResourceApi get subscriptions => new SubscriptionsResourceApi(_requester);
  TimelineResourceApi get timeline => new TimelineResourceApi(_requester);

  MirrorApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "mirror/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AccountsResourceApi {
  final commons.ApiRequester _requester;

  AccountsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Inserts a new account for a user
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [userToken] - The ID for the user.
   *
   * [accountType] - Account type to be passed to Android Account Manager.
   *
   * [accountName] - The name of the account to be passed to the Android Account
   * Manager.
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> insert(Account request, core.String userToken, core.String accountType, core.String accountName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (userToken == null) {
      throw new core.ArgumentError("Parameter userToken is required.");
    }
    if (accountType == null) {
      throw new core.ArgumentError("Parameter accountType is required.");
    }
    if (accountName == null) {
      throw new core.ArgumentError("Parameter accountName is required.");
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$userToken') + '/' + commons.Escaper.ecapeVariable('$accountType') + '/' + commons.Escaper.ecapeVariable('$accountName');

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Account.fromJson(data));
  }

}


class ContactsResourceApi {
  final commons.ApiRequester _requester;

  ContactsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a contact.
   *
   * Request parameters:
   *
   * [id] - The ID of the contact.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'contacts/' + commons.Escaper.ecapeVariable('$id');

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
   * Gets a single contact by ID.
   *
   * Request parameters:
   *
   * [id] - The ID of the contact.
   *
   * Completes with a [Contact].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Contact> get(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'contacts/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Contact.fromJson(data));
  }

  /**
   * Inserts a new contact.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Contact].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Contact> insert(Contact request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'contacts';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Contact.fromJson(data));
  }

  /**
   * Retrieves a list of contacts for the authenticated user.
   *
   * Request parameters:
   *
   * Completes with a [ContactsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ContactsListResponse> list() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'contacts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ContactsListResponse.fromJson(data));
  }

  /**
   * Updates a contact in place. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [id] - The ID of the contact.
   *
   * Completes with a [Contact].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Contact> patch(Contact request, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'contacts/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Contact.fromJson(data));
  }

  /**
   * Updates a contact in place.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [id] - The ID of the contact.
   *
   * Completes with a [Contact].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Contact> update(Contact request, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'contacts/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Contact.fromJson(data));
  }

}


class LocationsResourceApi {
  final commons.ApiRequester _requester;

  LocationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets a single location by ID.
   *
   * Request parameters:
   *
   * [id] - The ID of the location or latest for the last known location.
   *
   * Completes with a [Location].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Location> get(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'locations/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Location.fromJson(data));
  }

  /**
   * Retrieves a list of locations for the user.
   *
   * Request parameters:
   *
   * Completes with a [LocationsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LocationsListResponse> list() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'locations';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LocationsListResponse.fromJson(data));
  }

}


class SettingsResourceApi {
  final commons.ApiRequester _requester;

  SettingsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets a single setting by ID.
   *
   * Request parameters:
   *
   * [id] - The ID of the setting. The following IDs are valid:
   * - locale - The key to the user’s language/locale (BCP 47 identifier) that
   * Glassware should use to render localized content.
   * - timezone - The key to the user’s current time zone region as defined in
   * the tz database. Example: America/Los_Angeles.
   *
   * Completes with a [Setting].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Setting> get(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'settings/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Setting.fromJson(data));
  }

}


class SubscriptionsResourceApi {
  final commons.ApiRequester _requester;

  SubscriptionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a subscription.
   *
   * Request parameters:
   *
   * [id] - The ID of the subscription.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'subscriptions/' + commons.Escaper.ecapeVariable('$id');

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
   * Creates a new subscription.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Subscription].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subscription> insert(Subscription request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'subscriptions';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subscription.fromJson(data));
  }

  /**
   * Retrieves a list of subscriptions for the authenticated user and service.
   *
   * Request parameters:
   *
   * Completes with a [SubscriptionsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SubscriptionsListResponse> list() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'subscriptions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SubscriptionsListResponse.fromJson(data));
  }

  /**
   * Updates an existing subscription in place.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [id] - The ID of the subscription.
   *
   * Completes with a [Subscription].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subscription> update(Subscription request, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'subscriptions/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subscription.fromJson(data));
  }

}


class TimelineResourceApi {
  final commons.ApiRequester _requester;

  TimelineAttachmentsResourceApi get attachments => new TimelineAttachmentsResourceApi(_requester);

  TimelineResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a timeline item.
   *
   * Request parameters:
   *
   * [id] - The ID of the timeline item.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'timeline/' + commons.Escaper.ecapeVariable('$id');

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
   * Gets a single timeline item by ID.
   *
   * Request parameters:
   *
   * [id] - The ID of the timeline item.
   *
   * Completes with a [TimelineItem].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TimelineItem> get(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'timeline/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TimelineItem.fromJson(data));
  }

  /**
   * Inserts a new item into the timeline.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [TimelineItem].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TimelineItem> insert(TimelineItem request, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'timeline';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/mirror/v1/timeline';
    } else {
      _url = '/upload/mirror/v1/timeline';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TimelineItem.fromJson(data));
  }

  /**
   * Retrieves a list of timeline items for the authenticated user.
   *
   * Request parameters:
   *
   * [bundleId] - If provided, only items with the given bundleId will be
   * returned.
   *
   * [includeDeleted] - If true, tombstone records for deleted items will be
   * returned.
   *
   * [maxResults] - The maximum number of items to include in the response, used
   * for paging.
   *
   * [orderBy] - Controls the order in which timeline items are returned.
   * Possible string values are:
   * - "displayTime" : Results will be ordered by displayTime (default). This is
   * the same ordering as is used in the timeline on the device.
   * - "writeTime" : Results will be ordered by the time at which they were last
   * written to the data store.
   *
   * [pageToken] - Token for the page of results to return.
   *
   * [pinnedOnly] - If true, only pinned items will be returned.
   *
   * [sourceItemId] - If provided, only items with the given sourceItemId will
   * be returned.
   *
   * Completes with a [TimelineListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TimelineListResponse> list({core.String bundleId, core.bool includeDeleted, core.int maxResults, core.String orderBy, core.String pageToken, core.bool pinnedOnly, core.String sourceItemId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bundleId != null) {
      _queryParams["bundleId"] = [bundleId];
    }
    if (includeDeleted != null) {
      _queryParams["includeDeleted"] = ["${includeDeleted}"];
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
    if (pinnedOnly != null) {
      _queryParams["pinnedOnly"] = ["${pinnedOnly}"];
    }
    if (sourceItemId != null) {
      _queryParams["sourceItemId"] = [sourceItemId];
    }

    _url = 'timeline';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TimelineListResponse.fromJson(data));
  }

  /**
   * Updates a timeline item in place. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [id] - The ID of the timeline item.
   *
   * Completes with a [TimelineItem].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TimelineItem> patch(TimelineItem request, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'timeline/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TimelineItem.fromJson(data));
  }

  /**
   * Updates a timeline item in place.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [id] - The ID of the timeline item.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [TimelineItem].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TimelineItem> update(TimelineItem request, core.String id, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'timeline/' + commons.Escaper.ecapeVariable('$id');
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/mirror/v1/timeline/' + commons.Escaper.ecapeVariable('$id');
    } else {
      _url = '/upload/mirror/v1/timeline/' + commons.Escaper.ecapeVariable('$id');
    }


    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TimelineItem.fromJson(data));
  }

}


class TimelineAttachmentsResourceApi {
  final commons.ApiRequester _requester;

  TimelineAttachmentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an attachment from a timeline item.
   *
   * Request parameters:
   *
   * [itemId] - The ID of the timeline item the attachment belongs to.
   *
   * [attachmentId] - The ID of the attachment.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String itemId, core.String attachmentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (itemId == null) {
      throw new core.ArgumentError("Parameter itemId is required.");
    }
    if (attachmentId == null) {
      throw new core.ArgumentError("Parameter attachmentId is required.");
    }

    _downloadOptions = null;

    _url = 'timeline/' + commons.Escaper.ecapeVariable('$itemId') + '/attachments/' + commons.Escaper.ecapeVariable('$attachmentId');

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
   * Retrieves an attachment on a timeline item by item ID and attachment ID.
   *
   * Request parameters:
   *
   * [itemId] - The ID of the timeline item the attachment belongs to.
   *
   * [attachmentId] - The ID of the attachment.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [Attachment] for Metadata downloads (see [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future get(core.String itemId, core.String attachmentId, {commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (itemId == null) {
      throw new core.ArgumentError("Parameter itemId is required.");
    }
    if (attachmentId == null) {
      throw new core.ArgumentError("Parameter attachmentId is required.");
    }

    _downloadOptions = downloadOptions;

    _url = 'timeline/' + commons.Escaper.ecapeVariable('$itemId') + '/attachments/' + commons.Escaper.ecapeVariable('$attachmentId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new Attachment.fromJson(data));
    } else {
      return _response;
    }
  }

  /**
   * Adds a new attachment to a timeline item.
   *
   * Request parameters:
   *
   * [itemId] - The ID of the timeline item the attachment belongs to.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [Attachment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Attachment> insert(core.String itemId, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (itemId == null) {
      throw new core.ArgumentError("Parameter itemId is required.");
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'timeline/' + commons.Escaper.ecapeVariable('$itemId') + '/attachments';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/mirror/v1/timeline/' + commons.Escaper.ecapeVariable('$itemId') + '/attachments';
    } else {
      _url = '/upload/mirror/v1/timeline/' + commons.Escaper.ecapeVariable('$itemId') + '/attachments';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Attachment.fromJson(data));
  }

  /**
   * Returns a list of attachments for a timeline item.
   *
   * Request parameters:
   *
   * [itemId] - The ID of the timeline item whose attachments should be listed.
   *
   * Completes with a [AttachmentsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AttachmentsListResponse> list(core.String itemId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (itemId == null) {
      throw new core.ArgumentError("Parameter itemId is required.");
    }

    _url = 'timeline/' + commons.Escaper.ecapeVariable('$itemId') + '/attachments';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AttachmentsListResponse.fromJson(data));
  }

}



/** Represents an account passed into the Account Manager on Glass. */
class Account {
  core.List<AuthToken> authTokens;
  core.List<core.String> features;
  core.String password;
  core.List<UserData> userData;

  Account();

  Account.fromJson(core.Map _json) {
    if (_json.containsKey("authTokens")) {
      authTokens = _json["authTokens"].map((value) => new AuthToken.fromJson(value)).toList();
    }
    if (_json.containsKey("features")) {
      features = _json["features"];
    }
    if (_json.containsKey("password")) {
      password = _json["password"];
    }
    if (_json.containsKey("userData")) {
      userData = _json["userData"].map((value) => new UserData.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (authTokens != null) {
      _json["authTokens"] = authTokens.map((value) => (value).toJson()).toList();
    }
    if (features != null) {
      _json["features"] = features;
    }
    if (password != null) {
      _json["password"] = password;
    }
    if (userData != null) {
      _json["userData"] = userData.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Represents media content, such as a photo, that can be attached to a timeline
 * item.
 */
class Attachment {
  /** The MIME type of the attachment. */
  core.String contentType;
  /** The URL for the content. */
  core.String contentUrl;
  /** The ID of the attachment. */
  core.String id;
  /**
   * Indicates that the contentUrl is not available because the attachment
   * content is still being processed. If the caller wishes to retrieve the
   * content, it should try again later.
   */
  core.bool isProcessingContent;

  Attachment();

  Attachment.fromJson(core.Map _json) {
    if (_json.containsKey("contentType")) {
      contentType = _json["contentType"];
    }
    if (_json.containsKey("contentUrl")) {
      contentUrl = _json["contentUrl"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("isProcessingContent")) {
      isProcessingContent = _json["isProcessingContent"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contentType != null) {
      _json["contentType"] = contentType;
    }
    if (contentUrl != null) {
      _json["contentUrl"] = contentUrl;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (isProcessingContent != null) {
      _json["isProcessingContent"] = isProcessingContent;
    }
    return _json;
  }
}

/**
 * A list of Attachments. This is the response from the server to GET requests
 * on the attachments collection.
 */
class AttachmentsListResponse {
  /** The list of attachments. */
  core.List<Attachment> items;
  /** The type of resource. This is always mirror#attachmentsList. */
  core.String kind;

  AttachmentsListResponse();

  AttachmentsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Attachment.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    return _json;
  }
}

class AuthToken {
  core.String authToken;
  core.String type;

  AuthToken();

  AuthToken.fromJson(core.Map _json) {
    if (_json.containsKey("authToken")) {
      authToken = _json["authToken"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (authToken != null) {
      _json["authToken"] = authToken;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** A single menu command that is part of a Contact. */
class Command {
  /**
   * The type of operation this command corresponds to. Allowed values are:
   * - TAKE_A_NOTE - Shares a timeline item with the transcription of user
   * speech from the "Take a note" voice menu command.
   * - POST_AN_UPDATE - Shares a timeline item with the transcription of user
   * speech from the "Post an update" voice menu command.
   */
  core.String type;

  Command();

  Command.fromJson(core.Map _json) {
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** A person or group that can be used as a creator or a contact. */
class Contact {
  /**
   * A list of voice menu commands that a contact can handle. Glass shows up to
   * three contacts for each voice menu command. If there are more than that,
   * the three contacts with the highest priority are shown for that particular
   * command.
   */
  core.List<Command> acceptCommands;
  /**
   * A list of MIME types that a contact supports. The contact will be shown to
   * the user if any of its acceptTypes matches any of the types of the
   * attachments on the item. If no acceptTypes are given, the contact will be
   * shown for all items.
   */
  core.List<core.String> acceptTypes;
  /** The name to display for this contact. */
  core.String displayName;
  /**
   * An ID for this contact. This is generated by the application and is treated
   * as an opaque token.
   */
  core.String id;
  /**
   * Set of image URLs to display for a contact. Most contacts will have a
   * single image, but a "group" contact may include up to 8 image URLs and they
   * will be resized and cropped into a mosaic on the client.
   */
  core.List<core.String> imageUrls;
  /** The type of resource. This is always mirror#contact. */
  core.String kind;
  /**
   * Primary phone number for the contact. This can be a fully-qualified number,
   * with country calling code and area code, or a local number.
   */
  core.String phoneNumber;
  /**
   * Priority for the contact to determine ordering in a list of contacts.
   * Contacts with higher priorities will be shown before ones with lower
   * priorities.
   */
  core.int priority;
  /**
   * A list of sharing features that a contact can handle. Allowed values are:
   * - ADD_CAPTION
   */
  core.List<core.String> sharingFeatures;
  /**
   * The ID of the application that created this contact. This is populated by
   * the API
   */
  core.String source;
  /**
   * Name of this contact as it should be pronounced. If this contact's name
   * must be spoken as part of a voice disambiguation menu, this name is used as
   * the expected pronunciation. This is useful for contact names with
   * unpronounceable characters or whose display spelling is otherwise not
   * phonetic.
   */
  core.String speakableName;
  /**
   * The type for this contact. This is used for sorting in UIs. Allowed values
   * are:
   * - INDIVIDUAL - Represents a single person. This is the default.
   * - GROUP - Represents more than a single person.
   */
  core.String type;

  Contact();

  Contact.fromJson(core.Map _json) {
    if (_json.containsKey("acceptCommands")) {
      acceptCommands = _json["acceptCommands"].map((value) => new Command.fromJson(value)).toList();
    }
    if (_json.containsKey("acceptTypes")) {
      acceptTypes = _json["acceptTypes"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("imageUrls")) {
      imageUrls = _json["imageUrls"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("phoneNumber")) {
      phoneNumber = _json["phoneNumber"];
    }
    if (_json.containsKey("priority")) {
      priority = _json["priority"];
    }
    if (_json.containsKey("sharingFeatures")) {
      sharingFeatures = _json["sharingFeatures"];
    }
    if (_json.containsKey("source")) {
      source = _json["source"];
    }
    if (_json.containsKey("speakableName")) {
      speakableName = _json["speakableName"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (acceptCommands != null) {
      _json["acceptCommands"] = acceptCommands.map((value) => (value).toJson()).toList();
    }
    if (acceptTypes != null) {
      _json["acceptTypes"] = acceptTypes;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (imageUrls != null) {
      _json["imageUrls"] = imageUrls;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (phoneNumber != null) {
      _json["phoneNumber"] = phoneNumber;
    }
    if (priority != null) {
      _json["priority"] = priority;
    }
    if (sharingFeatures != null) {
      _json["sharingFeatures"] = sharingFeatures;
    }
    if (source != null) {
      _json["source"] = source;
    }
    if (speakableName != null) {
      _json["speakableName"] = speakableName;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * A list of Contacts representing contacts. This is the response from the
 * server to GET requests on the contacts collection.
 */
class ContactsListResponse {
  /** Contact list. */
  core.List<Contact> items;
  /** The type of resource. This is always mirror#contacts. */
  core.String kind;

  ContactsListResponse();

  ContactsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Contact.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    return _json;
  }
}

/** A geographic location that can be associated with a timeline item. */
class Location {
  /** The accuracy of the location fix in meters. */
  core.double accuracy;
  /** The full address of the location. */
  core.String address;
  /**
   * The name to be displayed. This may be a business name or a user-defined
   * place, such as "Home".
   */
  core.String displayName;
  /** The ID of the location. */
  core.String id;
  /** The type of resource. This is always mirror#location. */
  core.String kind;
  /** The latitude, in degrees. */
  core.double latitude;
  /** The longitude, in degrees. */
  core.double longitude;
  /**
   * The time at which this location was captured, formatted according to RFC
   * 3339.
   */
  core.DateTime timestamp;

  Location();

  Location.fromJson(core.Map _json) {
    if (_json.containsKey("accuracy")) {
      accuracy = _json["accuracy"];
    }
    if (_json.containsKey("address")) {
      address = _json["address"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("latitude")) {
      latitude = _json["latitude"];
    }
    if (_json.containsKey("longitude")) {
      longitude = _json["longitude"];
    }
    if (_json.containsKey("timestamp")) {
      timestamp = core.DateTime.parse(_json["timestamp"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accuracy != null) {
      _json["accuracy"] = accuracy;
    }
    if (address != null) {
      _json["address"] = address;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (latitude != null) {
      _json["latitude"] = latitude;
    }
    if (longitude != null) {
      _json["longitude"] = longitude;
    }
    if (timestamp != null) {
      _json["timestamp"] = (timestamp).toIso8601String();
    }
    return _json;
  }
}

/**
 * A list of Locations. This is the response from the server to GET requests on
 * the locations collection.
 */
class LocationsListResponse {
  /** The list of locations. */
  core.List<Location> items;
  /** The type of resource. This is always mirror#locationsList. */
  core.String kind;

  LocationsListResponse();

  LocationsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Location.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    return _json;
  }
}

/** A custom menu item that can be presented to the user by a timeline item. */
class MenuItem {
  /**
   * Controls the behavior when the user picks the menu option. Allowed values
   * are:
   * - CUSTOM - Custom action set by the service. When the user selects this
   * menuItem, the API triggers a notification to your callbackUrl with the
   * userActions.type set to CUSTOM and the userActions.payload set to the ID of
   * this menu item. This is the default value.
   * - Built-in actions:
   * - REPLY - Initiate a reply to the timeline item using the voice recording
   * UI. The creator attribute must be set in the timeline item for this menu to
   * be available.
   * - REPLY_ALL - Same behavior as REPLY. The original timeline item's
   * recipients will be added to the reply item.
   * - DELETE - Delete the timeline item.
   * - SHARE - Share the timeline item with the available contacts.
   * - READ_ALOUD - Read the timeline item's speakableText aloud; if this field
   * is not set, read the text field; if none of those fields are set, this menu
   * item is ignored.
   * - GET_MEDIA_INPUT - Allow users to provide media payloads to Glassware from
   * a menu item (currently, only transcribed text from voice input is
   * supported). Subscribe to notifications when users invoke this menu item to
   * receive the timeline item ID. Retrieve the media from the timeline item in
   * the payload property.
   * - VOICE_CALL - Initiate a phone call using the timeline item's
   * creator.phoneNumber attribute as recipient.
   * - NAVIGATE - Navigate to the timeline item's location.
   * - TOGGLE_PINNED - Toggle the isPinned state of the timeline item.
   * - OPEN_URI - Open the payload of the menu item in the browser.
   * - PLAY_VIDEO - Open the payload of the menu item in the Glass video player.
   * - SEND_MESSAGE - Initiate sending a message to the timeline item's creator:
   * - If the creator.phoneNumber is set and Glass is connected to an Android
   * phone, the message is an SMS.
   * - Otherwise, if the creator.email is set, the message is an email.
   */
  core.String action;
  /**
   * The ContextualMenus.Command associated with this MenuItem (e.g.
   * READ_ALOUD). The voice label for this command will be displayed in the
   * voice menu and the touch label will be displayed in the touch menu. Note
   * that the default menu value's display name will be overriden if you specify
   * this property. Values that do not correspond to a ContextualMenus.Command
   * name will be ignored.
   */
  core.String contextualCommand;
  /**
   * The ID for this menu item. This is generated by the application and is
   * treated as an opaque token.
   */
  core.String id;
  /**
   * A generic payload whose meaning changes depending on this MenuItem's
   * action.
   * - When the action is OPEN_URI, the payload is the URL of the website to
   * view.
   * - When the action is PLAY_VIDEO, the payload is the streaming URL of the
   * video
   * - When the action is GET_MEDIA_INPUT, the payload is the text transcription
   * of a user's speech input
   */
  core.String payload;
  /**
   * If set to true on a CUSTOM menu item, that item will be removed from the
   * menu after it is selected.
   */
  core.bool removeWhenSelected;
  /**
   * For CUSTOM items, a list of values controlling the appearance of the menu
   * item in each of its states. A value for the DEFAULT state must be provided.
   * If the PENDING or CONFIRMED states are missing, they will not be shown.
   */
  core.List<MenuValue> values;

  MenuItem();

  MenuItem.fromJson(core.Map _json) {
    if (_json.containsKey("action")) {
      action = _json["action"];
    }
    if (_json.containsKey("contextual_command")) {
      contextualCommand = _json["contextual_command"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("payload")) {
      payload = _json["payload"];
    }
    if (_json.containsKey("removeWhenSelected")) {
      removeWhenSelected = _json["removeWhenSelected"];
    }
    if (_json.containsKey("values")) {
      values = _json["values"].map((value) => new MenuValue.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (action != null) {
      _json["action"] = action;
    }
    if (contextualCommand != null) {
      _json["contextual_command"] = contextualCommand;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (payload != null) {
      _json["payload"] = payload;
    }
    if (removeWhenSelected != null) {
      _json["removeWhenSelected"] = removeWhenSelected;
    }
    if (values != null) {
      _json["values"] = values.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A single value that is part of a MenuItem. */
class MenuValue {
  /**
   * The name to display for the menu item. If you specify this property for a
   * built-in menu item, the default contextual voice command for that menu item
   * is not shown.
   */
  core.String displayName;
  /** URL of an icon to display with the menu item. */
  core.String iconUrl;
  /**
   * The state that this value applies to. Allowed values are:
   * - DEFAULT - Default value shown when displayed in the menuItems list.
   * - PENDING - Value shown when the menuItem has been selected by the user but
   * can still be cancelled.
   * - CONFIRMED - Value shown when the menuItem has been selected by the user
   * and can no longer be cancelled.
   */
  core.String state;

  MenuValue();

  MenuValue.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("iconUrl")) {
      iconUrl = _json["iconUrl"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (iconUrl != null) {
      _json["iconUrl"] = iconUrl;
    }
    if (state != null) {
      _json["state"] = state;
    }
    return _json;
  }
}

/** A notification delivered by the API. */
class Notification {
  /** The collection that generated the notification. */
  core.String collection;
  /** The ID of the item that generated the notification. */
  core.String itemId;
  /** The type of operation that generated the notification. */
  core.String operation;
  /** A list of actions taken by the user that triggered the notification. */
  core.List<UserAction> userActions;
  /**
   * The user token provided by the service when it subscribed for
   * notifications.
   */
  core.String userToken;
  /**
   * The secret verify token provided by the service when it subscribed for
   * notifications.
   */
  core.String verifyToken;

  Notification();

  Notification.fromJson(core.Map _json) {
    if (_json.containsKey("collection")) {
      collection = _json["collection"];
    }
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
    if (_json.containsKey("userActions")) {
      userActions = _json["userActions"].map((value) => new UserAction.fromJson(value)).toList();
    }
    if (_json.containsKey("userToken")) {
      userToken = _json["userToken"];
    }
    if (_json.containsKey("verifyToken")) {
      verifyToken = _json["verifyToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (collection != null) {
      _json["collection"] = collection;
    }
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    if (userActions != null) {
      _json["userActions"] = userActions.map((value) => (value).toJson()).toList();
    }
    if (userToken != null) {
      _json["userToken"] = userToken;
    }
    if (verifyToken != null) {
      _json["verifyToken"] = verifyToken;
    }
    return _json;
  }
}

/**
 * Controls how notifications for a timeline item are presented to the user.
 */
class NotificationConfig {
  /** The time at which the notification should be delivered. */
  core.DateTime deliveryTime;
  /**
   * Describes how important the notification is. Allowed values are:
   * - DEFAULT - Notifications of default importance. A chime will be played to
   * alert users.
   */
  core.String level;

  NotificationConfig();

  NotificationConfig.fromJson(core.Map _json) {
    if (_json.containsKey("deliveryTime")) {
      deliveryTime = core.DateTime.parse(_json["deliveryTime"]);
    }
    if (_json.containsKey("level")) {
      level = _json["level"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deliveryTime != null) {
      _json["deliveryTime"] = (deliveryTime).toIso8601String();
    }
    if (level != null) {
      _json["level"] = level;
    }
    return _json;
  }
}

/** A setting for Glass. */
class Setting {
  /**
   * The setting's ID. The following IDs are valid:
   * - locale - The key to the user’s language/locale (BCP 47 identifier) that
   * Glassware should use to render localized content.
   * - timezone - The key to the user’s current time zone region as defined in
   * the tz database. Example: America/Los_Angeles.
   */
  core.String id;
  /** The type of resource. This is always mirror#setting. */
  core.String kind;
  /** The setting value, as a string. */
  core.String value;

  Setting();

  Setting.fromJson(core.Map _json) {
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

/** A subscription to events on a collection. */
class Subscription {
  /**
   * The URL where notifications should be delivered (must start with https://).
   */
  core.String callbackUrl;
  /**
   * The collection to subscribe to. Allowed values are:
   * - timeline - Changes in the timeline including insertion, deletion, and
   * updates.
   * - locations - Location updates.
   * - settings - Settings updates.
   */
  core.String collection;
  /** The ID of the subscription. */
  core.String id;
  /** The type of resource. This is always mirror#subscription. */
  core.String kind;
  /**
   * Container object for notifications. This is not populated in the
   * Subscription resource.
   */
  Notification notification;
  /**
   * A list of operations that should be subscribed to. An empty list indicates
   * that all operations on the collection should be subscribed to. Allowed
   * values are:
   * - UPDATE - The item has been updated.
   * - INSERT - A new item has been inserted.
   * - DELETE - The item has been deleted.
   * - MENU_ACTION - A custom menu item has been triggered by the user.
   */
  core.List<core.String> operation;
  /**
   * The time at which this subscription was last modified, formatted according
   * to RFC 3339.
   */
  core.DateTime updated;
  /**
   * An opaque token sent to the subscriber in notifications so that it can
   * determine the ID of the user.
   */
  core.String userToken;
  /**
   * A secret token sent to the subscriber in notifications so that it can
   * verify that the notification was generated by Google.
   */
  core.String verifyToken;

  Subscription();

  Subscription.fromJson(core.Map _json) {
    if (_json.containsKey("callbackUrl")) {
      callbackUrl = _json["callbackUrl"];
    }
    if (_json.containsKey("collection")) {
      collection = _json["collection"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("notification")) {
      notification = new Notification.fromJson(_json["notification"]);
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("userToken")) {
      userToken = _json["userToken"];
    }
    if (_json.containsKey("verifyToken")) {
      verifyToken = _json["verifyToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (callbackUrl != null) {
      _json["callbackUrl"] = callbackUrl;
    }
    if (collection != null) {
      _json["collection"] = collection;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (notification != null) {
      _json["notification"] = (notification).toJson();
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (userToken != null) {
      _json["userToken"] = userToken;
    }
    if (verifyToken != null) {
      _json["verifyToken"] = verifyToken;
    }
    return _json;
  }
}

/**
 * A list of Subscriptions. This is the response from the server to GET requests
 * on the subscription collection.
 */
class SubscriptionsListResponse {
  /** The list of subscriptions. */
  core.List<Subscription> items;
  /** The type of resource. This is always mirror#subscriptionsList. */
  core.String kind;

  SubscriptionsListResponse();

  SubscriptionsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Subscription.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    return _json;
  }
}

/**
 * Each item in the user's timeline is represented as a TimelineItem JSON
 * structure, described below.
 */
class TimelineItem {
  /**
   * A list of media attachments associated with this item. As a convenience,
   * you can refer to attachments in your HTML payloads with the attachment or
   * cid scheme. For example:
   * - attachment: <img src="attachment:attachment_index"> where
   * attachment_index is the 0-based index of this array.
   * - cid: <img src="cid:attachment_id"> where attachment_id is the ID of the
   * attachment.
   */
  core.List<Attachment> attachments;
  /**
   * The bundle ID for this item. Services can specify a bundleId to group many
   * items together. They appear under a single top-level item on the device.
   */
  core.String bundleId;
  /**
   * A canonical URL pointing to the canonical/high quality version of the data
   * represented by the timeline item.
   */
  core.String canonicalUrl;
  /**
   * The time at which this item was created, formatted according to RFC 3339.
   */
  core.DateTime created;
  /** The user or group that created this item. */
  Contact creator;
  /**
   * The time that should be displayed when this item is viewed in the timeline,
   * formatted according to RFC 3339. This user's timeline is sorted
   * chronologically on display time, so this will also determine where the item
   * is displayed in the timeline. If not set by the service, the display time
   * defaults to the updated time.
   */
  core.DateTime displayTime;
  /** ETag for this item. */
  core.String etag;
  /**
   * HTML content for this item. If both text and html are provided for an item,
   * the html will be rendered in the timeline.
   * Allowed HTML elements - You can use these elements in your timeline cards.
   *
   * - Headers: h1, h2, h3, h4, h5, h6
   * - Images: img
   * - Lists: li, ol, ul
   * - HTML5 semantics: article, aside, details, figure, figcaption, footer,
   * header, nav, section, summary, time
   * - Structural: blockquote, br, div, hr, p, span
   * - Style: b, big, center, em, i, u, s, small, strike, strong, style, sub,
   * sup
   * - Tables: table, tbody, td, tfoot, th, thead, tr
   * Blocked HTML elements: These elements and their contents are removed from
   * HTML payloads.
   *
   * - Document headers: head, title
   * - Embeds: audio, embed, object, source, video
   * - Frames: frame, frameset
   * - Scripting: applet, script
   * Other elements: Any elements that aren't listed are removed, but their
   * contents are preserved.
   */
  core.String html;
  /** The ID of the timeline item. This is unique within a user's timeline. */
  core.String id;
  /**
   * If this item was generated as a reply to another item, this field will be
   * set to the ID of the item being replied to. This can be used to attach a
   * reply to the appropriate conversation or post.
   */
  core.String inReplyTo;
  /**
   * Whether this item is a bundle cover.
   *
   * If an item is marked as a bundle cover, it will be the entry point to the
   * bundle of items that have the same bundleId as that item. It will be shown
   * only on the main timeline — not within the opened bundle.
   *
   * On the main timeline, items that are shown are:
   * - Items that have isBundleCover set to true
   * - Items that do not have a bundleId  In a bundle sub-timeline, items that
   * are shown are:
   * - Items that have the bundleId in question AND isBundleCover set to false
   */
  core.bool isBundleCover;
  /**
   * When true, indicates this item is deleted, and only the ID property is set.
   */
  core.bool isDeleted;
  /**
   * When true, indicates this item is pinned, which means it's grouped
   * alongside "active" items like navigation and hangouts, on the opposite side
   * of the home screen from historical (non-pinned) timeline items. You can
   * allow the user to toggle the value of this property with the TOGGLE_PINNED
   * built-in menu item.
   */
  core.bool isPinned;
  /** The type of resource. This is always mirror#timelineItem. */
  core.String kind;
  /** The geographic location associated with this item. */
  Location location;
  /**
   * A list of menu items that will be presented to the user when this item is
   * selected in the timeline.
   */
  core.List<MenuItem> menuItems;
  /**
   * Controls how notifications for this item are presented on the device. If
   * this is missing, no notification will be generated.
   */
  NotificationConfig notification;
  /**
   * For pinned items, this determines the order in which the item is displayed
   * in the timeline, with a higher score appearing closer to the clock. Note:
   * setting this field is currently not supported.
   */
  core.int pinScore;
  /** A list of users or groups that this item has been shared with. */
  core.List<Contact> recipients;
  /** A URL that can be used to retrieve this item. */
  core.String selfLink;
  /**
   * Opaque string you can use to map a timeline item to data in your own
   * service.
   */
  core.String sourceItemId;
  /**
   * The speakable version of the content of this item. Along with the
   * READ_ALOUD menu item, use this field to provide text that would be clearer
   * when read aloud, or to provide extended information to what is displayed
   * visually on Glass.
   *
   * Glassware should also specify the speakableType field, which will be spoken
   * before this text in cases where the additional context is useful, for
   * example when the user requests that the item be read aloud following a
   * notification.
   */
  core.String speakableText;
  /**
   * A speakable description of the type of this item. This will be announced to
   * the user prior to reading the content of the item in cases where the
   * additional context is useful, for example when the user requests that the
   * item be read aloud following a notification.
   *
   * This should be a short, simple noun phrase such as "Email", "Text message",
   * or "Daily Planet News Update".
   *
   * Glassware are encouraged to populate this field for every timeline item,
   * even if the item does not contain speakableText or text so that the user
   * can learn the type of the item without looking at the screen.
   */
  core.String speakableType;
  /** Text content of this item. */
  core.String text;
  /** The title of this item. */
  core.String title;
  /**
   * The time at which this item was last modified, formatted according to RFC
   * 3339.
   */
  core.DateTime updated;

  TimelineItem();

  TimelineItem.fromJson(core.Map _json) {
    if (_json.containsKey("attachments")) {
      attachments = _json["attachments"].map((value) => new Attachment.fromJson(value)).toList();
    }
    if (_json.containsKey("bundleId")) {
      bundleId = _json["bundleId"];
    }
    if (_json.containsKey("canonicalUrl")) {
      canonicalUrl = _json["canonicalUrl"];
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("creator")) {
      creator = new Contact.fromJson(_json["creator"]);
    }
    if (_json.containsKey("displayTime")) {
      displayTime = core.DateTime.parse(_json["displayTime"]);
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("html")) {
      html = _json["html"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("inReplyTo")) {
      inReplyTo = _json["inReplyTo"];
    }
    if (_json.containsKey("isBundleCover")) {
      isBundleCover = _json["isBundleCover"];
    }
    if (_json.containsKey("isDeleted")) {
      isDeleted = _json["isDeleted"];
    }
    if (_json.containsKey("isPinned")) {
      isPinned = _json["isPinned"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("location")) {
      location = new Location.fromJson(_json["location"]);
    }
    if (_json.containsKey("menuItems")) {
      menuItems = _json["menuItems"].map((value) => new MenuItem.fromJson(value)).toList();
    }
    if (_json.containsKey("notification")) {
      notification = new NotificationConfig.fromJson(_json["notification"]);
    }
    if (_json.containsKey("pinScore")) {
      pinScore = _json["pinScore"];
    }
    if (_json.containsKey("recipients")) {
      recipients = _json["recipients"].map((value) => new Contact.fromJson(value)).toList();
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("sourceItemId")) {
      sourceItemId = _json["sourceItemId"];
    }
    if (_json.containsKey("speakableText")) {
      speakableText = _json["speakableText"];
    }
    if (_json.containsKey("speakableType")) {
      speakableType = _json["speakableType"];
    }
    if (_json.containsKey("text")) {
      text = _json["text"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (attachments != null) {
      _json["attachments"] = attachments.map((value) => (value).toJson()).toList();
    }
    if (bundleId != null) {
      _json["bundleId"] = bundleId;
    }
    if (canonicalUrl != null) {
      _json["canonicalUrl"] = canonicalUrl;
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (creator != null) {
      _json["creator"] = (creator).toJson();
    }
    if (displayTime != null) {
      _json["displayTime"] = (displayTime).toIso8601String();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (html != null) {
      _json["html"] = html;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (inReplyTo != null) {
      _json["inReplyTo"] = inReplyTo;
    }
    if (isBundleCover != null) {
      _json["isBundleCover"] = isBundleCover;
    }
    if (isDeleted != null) {
      _json["isDeleted"] = isDeleted;
    }
    if (isPinned != null) {
      _json["isPinned"] = isPinned;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (location != null) {
      _json["location"] = (location).toJson();
    }
    if (menuItems != null) {
      _json["menuItems"] = menuItems.map((value) => (value).toJson()).toList();
    }
    if (notification != null) {
      _json["notification"] = (notification).toJson();
    }
    if (pinScore != null) {
      _json["pinScore"] = pinScore;
    }
    if (recipients != null) {
      _json["recipients"] = recipients.map((value) => (value).toJson()).toList();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (sourceItemId != null) {
      _json["sourceItemId"] = sourceItemId;
    }
    if (speakableText != null) {
      _json["speakableText"] = speakableText;
    }
    if (speakableType != null) {
      _json["speakableType"] = speakableType;
    }
    if (text != null) {
      _json["text"] = text;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

/**
 * A list of timeline items. This is the response from the server to GET
 * requests on the timeline collection.
 */
class TimelineListResponse {
  /** Items in the timeline. */
  core.List<TimelineItem> items;
  /** The type of resource. This is always mirror#timeline. */
  core.String kind;
  /**
   * The next page token. Provide this as the pageToken parameter in the request
   * to retrieve the next page of results.
   */
  core.String nextPageToken;

  TimelineListResponse();

  TimelineListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new TimelineItem.fromJson(value)).toList();
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

/** Represents an action taken by the user that triggered a notification. */
class UserAction {
  /**
   * An optional payload for the action.
   *
   * For actions of type CUSTOM, this is the ID of the custom menu item that was
   * selected.
   */
  core.String payload;
  /**
   * The type of action. The value of this can be:
   * - SHARE - the user shared an item.
   * - REPLY - the user replied to an item.
   * - REPLY_ALL - the user replied to all recipients of an item.
   * - CUSTOM - the user selected a custom menu item on the timeline item.
   * - DELETE - the user deleted the item.
   * - PIN - the user pinned the item.
   * - UNPIN - the user unpinned the item.
   * - LAUNCH - the user initiated a voice command.  In the future, additional
   * types may be added. UserActions with unrecognized types should be ignored.
   */
  core.String type;

  UserAction();

  UserAction.fromJson(core.Map _json) {
    if (_json.containsKey("payload")) {
      payload = _json["payload"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (payload != null) {
      _json["payload"] = payload;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class UserData {
  core.String key;
  core.String value;

  UserData();

  UserData.fromJson(core.Map _json) {
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
