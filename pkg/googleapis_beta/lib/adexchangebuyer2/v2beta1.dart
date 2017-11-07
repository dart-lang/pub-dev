// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.adexchangebuyer2.v2beta1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client adexchangebuyer2/v2beta1';

/// Accesses the latest features for managing Ad Exchange accounts, Real-Time
/// Bidding configurations and auction metrics, and Marketplace programmatic
/// deals.
class Adexchangebuyer2Api {
  /// Manage your Ad Exchange buyer account configuration
  static const AdexchangeBuyerScope =
      "https://www.googleapis.com/auth/adexchange.buyer";

  final commons.ApiRequester _requester;

  AccountsResourceApi get accounts => new AccountsResourceApi(_requester);

  Adexchangebuyer2Api(http.Client client,
      {core.String rootUrl: "https://adexchangebuyer.googleapis.com/",
      core.String servicePath: ""})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class AccountsResourceApi {
  final commons.ApiRequester _requester;

  AccountsClientsResourceApi get clients =>
      new AccountsClientsResourceApi(_requester);
  AccountsCreativesResourceApi get creatives =>
      new AccountsCreativesResourceApi(_requester);
  AccountsFilterSetsResourceApi get filterSets =>
      new AccountsFilterSetsResourceApi(_requester);

  AccountsResourceApi(commons.ApiRequester client) : _requester = client;
}

class AccountsClientsResourceApi {
  final commons.ApiRequester _requester;

  AccountsClientsInvitationsResourceApi get invitations =>
      new AccountsClientsInvitationsResourceApi(_requester);
  AccountsClientsUsersResourceApi get users =>
      new AccountsClientsUsersResourceApi(_requester);

  AccountsClientsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Creates a new client buyer.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Unique numerical account ID for the buyer of which the
  /// client buyer
  /// is a customer; the sponsor buyer to create a client for. (required)
  ///
  /// Completes with a [Client].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Client> create(Client request, core.String accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/clients';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Client.fromJson(data));
  }

  /// Gets a client buyer with a given client account ID.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Numerical account ID of the client's sponsor buyer.
  /// (required)
  ///
  /// [clientAccountId] - Numerical account ID of the client buyer to retrieve.
  /// (required)
  ///
  /// Completes with a [Client].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Client> get(core.String accountId, core.String clientAccountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (clientAccountId == null) {
      throw new core.ArgumentError("Parameter clientAccountId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/clients/' +
        commons.Escaper.ecapeVariable('$clientAccountId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Client.fromJson(data));
  }

  /// Lists all the clients for the current sponsor buyer.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Unique numerical account ID of the sponsor buyer to list the
  /// clients for.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListClientsResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.clients.list method.
  ///
  /// [pageSize] - Requested page size. The server may return fewer clients than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// Completes with a [ListClientsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListClientsResponse> list(core.String accountId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/clients';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListClientsResponse.fromJson(data));
  }

  /// Updates an existing client buyer.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Unique numerical account ID for the buyer of which the
  /// client buyer
  /// is a customer; the sponsor buyer to update a client for. (required)
  ///
  /// [clientAccountId] - Unique numerical account ID of the client to update.
  /// (required)
  ///
  /// Completes with a [Client].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Client> update(
      Client request, core.String accountId, core.String clientAccountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (clientAccountId == null) {
      throw new core.ArgumentError("Parameter clientAccountId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/clients/' +
        commons.Escaper.ecapeVariable('$clientAccountId');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Client.fromJson(data));
  }
}

class AccountsClientsInvitationsResourceApi {
  final commons.ApiRequester _requester;

  AccountsClientsInvitationsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Creates and sends out an email invitation to access
  /// an Ad Exchange client buyer account.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Numerical account ID of the client's sponsor buyer.
  /// (required)
  ///
  /// [clientAccountId] - Numerical account ID of the client buyer that the user
  /// should be associated with. (required)
  ///
  /// Completes with a [ClientUserInvitation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ClientUserInvitation> create(ClientUserInvitation request,
      core.String accountId, core.String clientAccountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (clientAccountId == null) {
      throw new core.ArgumentError("Parameter clientAccountId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/clients/' +
        commons.Escaper.ecapeVariable('$clientAccountId') +
        '/invitations';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ClientUserInvitation.fromJson(data));
  }

  /// Retrieves an existing client user invitation.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Numerical account ID of the client's sponsor buyer.
  /// (required)
  ///
  /// [clientAccountId] - Numerical account ID of the client buyer that the user
  /// invitation
  /// to be retrieved is associated with. (required)
  ///
  /// [invitationId] - Numerical identifier of the user invitation to retrieve.
  /// (required)
  ///
  /// Completes with a [ClientUserInvitation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ClientUserInvitation> get(core.String accountId,
      core.String clientAccountId, core.String invitationId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (clientAccountId == null) {
      throw new core.ArgumentError("Parameter clientAccountId is required.");
    }
    if (invitationId == null) {
      throw new core.ArgumentError("Parameter invitationId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/clients/' +
        commons.Escaper.ecapeVariable('$clientAccountId') +
        '/invitations/' +
        commons.Escaper.ecapeVariable('$invitationId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ClientUserInvitation.fromJson(data));
  }

  /// Lists all the client users invitations for a client
  /// with a given account ID.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Numerical account ID of the client's sponsor buyer.
  /// (required)
  ///
  /// [clientAccountId] - Numerical account ID of the client buyer to list
  /// invitations for.
  /// (required)
  /// You must either specify a string representation of a
  /// numerical account identifier or the `-` character
  /// to list all the invitations for all the clients
  /// of a given sponsor buyer.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListClientUserInvitationsResponse.nextPageToken
  /// returned from the previous call to the
  /// clients.invitations.list
  /// method.
  ///
  /// [pageSize] - Requested page size. Server may return fewer clients than
  /// requested.
  /// If unspecified, server will pick an appropriate default.
  ///
  /// Completes with a [ListClientUserInvitationsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListClientUserInvitationsResponse> list(
      core.String accountId, core.String clientAccountId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (clientAccountId == null) {
      throw new core.ArgumentError("Parameter clientAccountId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/clients/' +
        commons.Escaper.ecapeVariable('$clientAccountId') +
        '/invitations';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ListClientUserInvitationsResponse.fromJson(data));
  }
}

class AccountsClientsUsersResourceApi {
  final commons.ApiRequester _requester;

  AccountsClientsUsersResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Retrieves an existing client user.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Numerical account ID of the client's sponsor buyer.
  /// (required)
  ///
  /// [clientAccountId] - Numerical account ID of the client buyer
  /// that the user to be retrieved is associated with. (required)
  ///
  /// [userId] - Numerical identifier of the user to retrieve. (required)
  ///
  /// Completes with a [ClientUser].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ClientUser> get(
      core.String accountId, core.String clientAccountId, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (clientAccountId == null) {
      throw new core.ArgumentError("Parameter clientAccountId is required.");
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/clients/' +
        commons.Escaper.ecapeVariable('$clientAccountId') +
        '/users/' +
        commons.Escaper.ecapeVariable('$userId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ClientUser.fromJson(data));
  }

  /// Lists all the known client users for a specified
  /// sponsor buyer account ID.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Numerical account ID of the sponsor buyer of the client to
  /// list users for.
  /// (required)
  ///
  /// [clientAccountId] - The account ID of the client buyer to list users for.
  /// (required)
  /// You must specify either a string representation of a
  /// numerical account identifier or the `-` character
  /// to list all the client users for all the clients
  /// of a given sponsor buyer.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListClientUsersResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.clients.users.list method.
  ///
  /// [pageSize] - Requested page size. The server may return fewer clients than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// Completes with a [ListClientUsersResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListClientUsersResponse> list(
      core.String accountId, core.String clientAccountId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (clientAccountId == null) {
      throw new core.ArgumentError("Parameter clientAccountId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/clients/' +
        commons.Escaper.ecapeVariable('$clientAccountId') +
        '/users';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListClientUsersResponse.fromJson(data));
  }

  /// Updates an existing client user.
  /// Only the user status can be changed on update.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Numerical account ID of the client's sponsor buyer.
  /// (required)
  ///
  /// [clientAccountId] - Numerical account ID of the client buyer that the user
  /// to be retrieved
  /// is associated with. (required)
  ///
  /// [userId] - Numerical identifier of the user to retrieve. (required)
  ///
  /// Completes with a [ClientUser].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ClientUser> update(ClientUser request, core.String accountId,
      core.String clientAccountId, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (clientAccountId == null) {
      throw new core.ArgumentError("Parameter clientAccountId is required.");
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/clients/' +
        commons.Escaper.ecapeVariable('$clientAccountId') +
        '/users/' +
        commons.Escaper.ecapeVariable('$userId');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ClientUser.fromJson(data));
  }
}

class AccountsCreativesResourceApi {
  final commons.ApiRequester _requester;

  AccountsCreativesDealAssociationsResourceApi get dealAssociations =>
      new AccountsCreativesDealAssociationsResourceApi(_requester);

  AccountsCreativesResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Creates a creative.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [accountId] - The account that this creative belongs to.
  /// Can be used to filter the response of the
  /// creatives.list
  /// method.
  ///
  /// [duplicateIdMode] - Indicates if multiple creatives can share an ID or
  /// not. Default is
  /// NO_DUPLICATES (one ID per creative).
  /// Possible string values are:
  /// - "NO_DUPLICATES" : A NO_DUPLICATES.
  /// - "FORCE_ENABLE_DUPLICATE_IDS" : A FORCE_ENABLE_DUPLICATE_IDS.
  ///
  /// Completes with a [Creative].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Creative> create(Creative request, core.String accountId,
      {core.String duplicateIdMode}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (duplicateIdMode != null) {
      _queryParams["duplicateIdMode"] = [duplicateIdMode];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/creatives';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Creative.fromJson(data));
  }

  /// Gets a creative.
  ///
  /// Request parameters:
  ///
  /// [accountId] - The account the creative belongs to.
  ///
  /// [creativeId] - The ID of the creative to retrieve.
  ///
  /// Completes with a [Creative].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Creative> get(core.String accountId, core.String creativeId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (creativeId == null) {
      throw new core.ArgumentError("Parameter creativeId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/creatives/' +
        commons.Escaper.ecapeVariable('$creativeId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Creative.fromJson(data));
  }

  /// Lists creatives.
  ///
  /// Request parameters:
  ///
  /// [accountId] - The account to list the creatives from.
  /// Specify "-" to list all creatives the current user has access to.
  ///
  /// [query] - An optional query string to filter creatives. If no filter is
  /// specified,
  /// all active creatives will be returned.
  /// Supported queries are:
  /// <ul>
  /// <li>accountId=<i>account_id_string</i>
  /// <li>creativeId=<i>creative_id_string</i>
  /// <li>dealsStatus: {approved, conditionally_approved, disapproved,
  ///                    not_checked}
  /// <li>openAuctionStatus: {approved, conditionally_approved, disapproved,
  ///                           not_checked}
  /// <li>attribute: {a numeric attribute from the list of attributes}
  /// <li>disapprovalReason: {a reason from DisapprovalReason
  /// </ul>
  /// Example: 'accountId=12345 AND (dealsStatus:disapproved AND
  /// disapprovalReason:unacceptable_content) OR attribute:47'
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListCreativesResponse.next_page_token
  /// returned from the previous call to 'ListCreatives' method.
  ///
  /// [pageSize] - Requested page size. The server may return fewer creatives
  /// than requested
  /// (due to timeout constraint) even if more are available via another call.
  /// If unspecified, server will pick an appropriate default.
  /// Acceptable values are 1 to 1000, inclusive.
  ///
  /// Completes with a [ListCreativesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListCreativesResponse> list(core.String accountId,
      {core.String query, core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (query != null) {
      _queryParams["query"] = [query];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/creatives';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListCreativesResponse.fromJson(data));
  }

  /// Stops watching a creative. Will stop push notifications being sent to the
  /// topics when the creative changes status.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [accountId] - The account of the creative to stop notifications for.
  ///
  /// [creativeId] - The creative ID of the creative to stop notifications for.
  /// Specify "-" to specify stopping account level notifications.
  ///
  /// Completes with a [Empty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Empty> stopWatching(StopWatchingCreativeRequest request,
      core.String accountId, core.String creativeId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (creativeId == null) {
      throw new core.ArgumentError("Parameter creativeId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/creatives/' +
        commons.Escaper.ecapeVariable('$creativeId') +
        ':stopWatching';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /// Updates a creative.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [accountId] - The account that this creative belongs to.
  /// Can be used to filter the response of the
  /// creatives.list
  /// method.
  ///
  /// [creativeId] - The buyer-defined creative ID of this creative.
  /// Can be used to filter the response of the
  /// creatives.list
  /// method.
  ///
  /// Completes with a [Creative].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Creative> update(
      Creative request, core.String accountId, core.String creativeId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (creativeId == null) {
      throw new core.ArgumentError("Parameter creativeId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/creatives/' +
        commons.Escaper.ecapeVariable('$creativeId');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Creative.fromJson(data));
  }

  /// Watches a creative. Will result in push notifications being sent to the
  /// topic when the creative changes status.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [accountId] - The account of the creative to watch.
  ///
  /// [creativeId] - The creative ID to watch for status changes.
  /// Specify "-" to watch all creatives under the above account.
  /// If both creative-level and account-level notifications are
  /// sent, only a single notification will be sent to the
  /// creative-level notification topic.
  ///
  /// Completes with a [Empty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Empty> watch(WatchCreativeRequest request, core.String accountId,
      core.String creativeId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (creativeId == null) {
      throw new core.ArgumentError("Parameter creativeId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/creatives/' +
        commons.Escaper.ecapeVariable('$creativeId') +
        ':watch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }
}

class AccountsCreativesDealAssociationsResourceApi {
  final commons.ApiRequester _requester;

  AccountsCreativesDealAssociationsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Associate an existing deal with a creative.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [accountId] - The account the creative belongs to.
  ///
  /// [creativeId] - The ID of the creative associated with the deal.
  ///
  /// Completes with a [Empty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Empty> add(AddDealAssociationRequest request,
      core.String accountId, core.String creativeId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (creativeId == null) {
      throw new core.ArgumentError("Parameter creativeId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/creatives/' +
        commons.Escaper.ecapeVariable('$creativeId') +
        '/dealAssociations:add';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /// List all creative-deal associations.
  ///
  /// Request parameters:
  ///
  /// [accountId] - The account to list the associations from.
  /// Specify "-" to list all creatives the current user has access to.
  ///
  /// [creativeId] - The creative ID to list the associations from.
  /// Specify "-" to list all creatives under the above account.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListDealAssociationsResponse.next_page_token
  /// returned from the previous call to 'ListDealAssociations' method.
  ///
  /// [pageSize] - Requested page size. Server may return fewer associations
  /// than requested.
  /// If unspecified, server will pick an appropriate default.
  ///
  /// [query] - An optional query string to filter deal associations. If no
  /// filter is
  /// specified, all associations will be returned.
  /// Supported queries are:
  /// <ul>
  /// <li>accountId=<i>account_id_string</i>
  /// <li>creativeId=<i>creative_id_string</i>
  /// <li>dealsId=<i>deals_id_string</i>
  /// <li>dealsStatus:{approved, conditionally_approved, disapproved,
  ///                   not_checked}
  /// <li>openAuctionStatus:{approved, conditionally_approved, disapproved,
  ///                          not_checked}
  /// </ul>
  /// Example: 'dealsId=12345 AND dealsStatus:disapproved'
  ///
  /// Completes with a [ListDealAssociationsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListDealAssociationsResponse> list(
      core.String accountId, core.String creativeId,
      {core.String pageToken, core.int pageSize, core.String query}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (creativeId == null) {
      throw new core.ArgumentError("Parameter creativeId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (query != null) {
      _queryParams["query"] = [query];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/creatives/' +
        commons.Escaper.ecapeVariable('$creativeId') +
        '/dealAssociations';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ListDealAssociationsResponse.fromJson(data));
  }

  /// Remove the association between a deal and a creative.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [accountId] - The account the creative belongs to.
  ///
  /// [creativeId] - The ID of the creative associated with the deal.
  ///
  /// Completes with a [Empty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Empty> remove(RemoveDealAssociationRequest request,
      core.String accountId, core.String creativeId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (creativeId == null) {
      throw new core.ArgumentError("Parameter creativeId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/creatives/' +
        commons.Escaper.ecapeVariable('$creativeId') +
        '/dealAssociations:remove';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }
}

class AccountsFilterSetsResourceApi {
  final commons.ApiRequester _requester;

  AccountsFilterSetsBidMetricsResourceApi get bidMetrics =>
      new AccountsFilterSetsBidMetricsResourceApi(_requester);
  AccountsFilterSetsBidResponseErrorsResourceApi get bidResponseErrors =>
      new AccountsFilterSetsBidResponseErrorsResourceApi(_requester);
  AccountsFilterSetsBidResponsesWithoutBidsResourceApi
      get bidResponsesWithoutBids =>
          new AccountsFilterSetsBidResponsesWithoutBidsResourceApi(_requester);
  AccountsFilterSetsFilteredBidRequestsResourceApi get filteredBidRequests =>
      new AccountsFilterSetsFilteredBidRequestsResourceApi(_requester);
  AccountsFilterSetsFilteredBidsResourceApi get filteredBids =>
      new AccountsFilterSetsFilteredBidsResourceApi(_requester);
  AccountsFilterSetsImpressionMetricsResourceApi get impressionMetrics =>
      new AccountsFilterSetsImpressionMetricsResourceApi(_requester);
  AccountsFilterSetsLosingBidsResourceApi get losingBids =>
      new AccountsFilterSetsLosingBidsResourceApi(_requester);
  AccountsFilterSetsNonBillableWinningBidsResourceApi
      get nonBillableWinningBids =>
          new AccountsFilterSetsNonBillableWinningBidsResourceApi(_requester);

  AccountsFilterSetsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Creates the specified filter set for the account with the given account
  /// ID.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [isTransient] - Whether the filter set is transient, or should be
  /// persisted indefinitely.
  /// By default, filter sets are not transient.
  /// If transient, it will be available for at least 1 hour after creation.
  ///
  /// Completes with a [FilterSet].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<FilterSet> create(FilterSet request, core.String accountId,
      {core.bool isTransient}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (isTransient != null) {
      _queryParams["isTransient"] = ["${isTransient}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new FilterSet.fromJson(data));
  }

  /// Deletes the requested filter set from the account with the given account
  /// ID.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [filterSetId] - The ID of the filter set to delete.
  ///
  /// Completes with a [Empty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Empty> delete(core.String accountId, core.String filterSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterSetId == null) {
      throw new core.ArgumentError("Parameter filterSetId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets/' +
        commons.Escaper.ecapeVariable('$filterSetId');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /// Retrieves the requested filter set for the account with the given account
  /// ID.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [filterSetId] - The ID of the filter set to get.
  ///
  /// Completes with a [FilterSet].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<FilterSet> get(core.String accountId, core.String filterSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterSetId == null) {
      throw new core.ArgumentError("Parameter filterSetId is required.");
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets/' +
        commons.Escaper.ecapeVariable('$filterSetId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new FilterSet.fromJson(data));
  }

  /// Lists all filter sets for the account with the given account ID.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListFilterSetsResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.filterSets.list
  /// method.
  ///
  /// [pageSize] - Requested page size. The server may return fewer results than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// Completes with a [ListFilterSetsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListFilterSetsResponse> list(core.String accountId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListFilterSetsResponse.fromJson(data));
  }
}

class AccountsFilterSetsBidMetricsResourceApi {
  final commons.ApiRequester _requester;

  AccountsFilterSetsBidMetricsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Lists all metrics that are measured in terms of number of bids.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [filterSetId] - The ID of the filter set to apply.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListBidMetricsResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.filterSets.bidMetrics.list
  /// method.
  ///
  /// [pageSize] - Requested page size. The server may return fewer results than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// Completes with a [ListBidMetricsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListBidMetricsResponse> list(
      core.String accountId, core.String filterSetId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterSetId == null) {
      throw new core.ArgumentError("Parameter filterSetId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets/' +
        commons.Escaper.ecapeVariable('$filterSetId') +
        '/bidMetrics';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListBidMetricsResponse.fromJson(data));
  }
}

class AccountsFilterSetsBidResponseErrorsResourceApi {
  final commons.ApiRequester _requester;

  AccountsFilterSetsBidResponseErrorsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// List all errors that occurred in bid responses, with the number of bid
  /// responses affected for each reason.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [filterSetId] - The ID of the filter set to apply.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListBidResponseErrorsResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.filterSets.bidResponseErrors.list
  /// method.
  ///
  /// [pageSize] - Requested page size. The server may return fewer results than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// Completes with a [ListBidResponseErrorsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListBidResponseErrorsResponse> list(
      core.String accountId, core.String filterSetId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterSetId == null) {
      throw new core.ArgumentError("Parameter filterSetId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets/' +
        commons.Escaper.ecapeVariable('$filterSetId') +
        '/bidResponseErrors';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ListBidResponseErrorsResponse.fromJson(data));
  }
}

class AccountsFilterSetsBidResponsesWithoutBidsResourceApi {
  final commons.ApiRequester _requester;

  AccountsFilterSetsBidResponsesWithoutBidsResourceApi(
      commons.ApiRequester client)
      : _requester = client;

  /// List all reasons for which bid responses were considered to have no
  /// applicable bids, with the number of bid responses affected for each
  /// reason.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [filterSetId] - The ID of the filter set to apply.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListBidResponsesWithoutBidsResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.filterSets.bidResponsesWithoutBids.list
  /// method.
  ///
  /// [pageSize] - Requested page size. The server may return fewer results than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// Completes with a [ListBidResponsesWithoutBidsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListBidResponsesWithoutBidsResponse> list(
      core.String accountId, core.String filterSetId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterSetId == null) {
      throw new core.ArgumentError("Parameter filterSetId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets/' +
        commons.Escaper.ecapeVariable('$filterSetId') +
        '/bidResponsesWithoutBids';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ListBidResponsesWithoutBidsResponse.fromJson(data));
  }
}

class AccountsFilterSetsFilteredBidRequestsResourceApi {
  final commons.ApiRequester _requester;

  AccountsFilterSetsFilteredBidRequestsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// List all reasons that caused a bid request not to be sent for an
  /// impression, with the number of bid requests not sent for each reason.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [filterSetId] - The ID of the filter set to apply.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListFilteredBidRequestsResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.filterSets.filteredBidRequests.list
  /// method.
  ///
  /// [pageSize] - Requested page size. The server may return fewer results than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// Completes with a [ListFilteredBidRequestsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListFilteredBidRequestsResponse> list(
      core.String accountId, core.String filterSetId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterSetId == null) {
      throw new core.ArgumentError("Parameter filterSetId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets/' +
        commons.Escaper.ecapeVariable('$filterSetId') +
        '/filteredBidRequests';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ListFilteredBidRequestsResponse.fromJson(data));
  }
}

class AccountsFilterSetsFilteredBidsResourceApi {
  final commons.ApiRequester _requester;

  AccountsFilterSetsFilteredBidsCreativesResourceApi get creatives =>
      new AccountsFilterSetsFilteredBidsCreativesResourceApi(_requester);
  AccountsFilterSetsFilteredBidsDetailsResourceApi get details =>
      new AccountsFilterSetsFilteredBidsDetailsResourceApi(_requester);

  AccountsFilterSetsFilteredBidsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// List all reasons for which bids were filtered, with the number of bids
  /// filtered for each reason.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [filterSetId] - The ID of the filter set to apply.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListFilteredBidsResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.filterSets.filteredBids.list
  /// method.
  ///
  /// [pageSize] - Requested page size. The server may return fewer results than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// Completes with a [ListFilteredBidsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListFilteredBidsResponse> list(
      core.String accountId, core.String filterSetId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterSetId == null) {
      throw new core.ArgumentError("Parameter filterSetId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets/' +
        commons.Escaper.ecapeVariable('$filterSetId') +
        '/filteredBids';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ListFilteredBidsResponse.fromJson(data));
  }
}

class AccountsFilterSetsFilteredBidsCreativesResourceApi {
  final commons.ApiRequester _requester;

  AccountsFilterSetsFilteredBidsCreativesResourceApi(
      commons.ApiRequester client)
      : _requester = client;

  /// List all creatives associated with a specific reason for which bids were
  /// filtered, with the number of bids filtered for each creative.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [filterSetId] - The ID of the filter set to apply.
  ///
  /// [creativeStatusId] - The ID of the creative status for which to retrieve a
  /// breakdown by
  /// creative.
  /// See
  /// [creative-status-codes](https://developers.google.com/ad-exchange/rtb/downloads/creative-status-codes).
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListCreativeStatusBreakdownByCreativeResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.filterSets.filteredBids.creatives.list
  /// method.
  ///
  /// [pageSize] - Requested page size. The server may return fewer results than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// Completes with a [ListCreativeStatusBreakdownByCreativeResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListCreativeStatusBreakdownByCreativeResponse> list(
      core.String accountId, core.String filterSetId, core.int creativeStatusId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterSetId == null) {
      throw new core.ArgumentError("Parameter filterSetId is required.");
    }
    if (creativeStatusId == null) {
      throw new core.ArgumentError("Parameter creativeStatusId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets/' +
        commons.Escaper.ecapeVariable('$filterSetId') +
        '/filteredBids/' +
        commons.Escaper.ecapeVariable('$creativeStatusId') +
        '/creatives';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new ListCreativeStatusBreakdownByCreativeResponse.fromJson(data));
  }
}

class AccountsFilterSetsFilteredBidsDetailsResourceApi {
  final commons.ApiRequester _requester;

  AccountsFilterSetsFilteredBidsDetailsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// List all details associated with a specific reason for which bids were
  /// filtered, with the number of bids filtered for each detail.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [filterSetId] - The ID of the filter set to apply.
  ///
  /// [creativeStatusId] - The ID of the creative status for which to retrieve a
  /// breakdown by detail.
  /// See
  /// [creative-status-codes](https://developers.google.com/ad-exchange/rtb/downloads/creative-status-codes).
  /// Details are only available for statuses 10, 14, 15, 17, 18, 19, 86, and
  /// 87.
  ///
  /// [pageSize] - Requested page size. The server may return fewer results than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListCreativeStatusBreakdownByDetailResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.filterSets.filteredBids.details.list
  /// method.
  ///
  /// Completes with a [ListCreativeStatusBreakdownByDetailResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListCreativeStatusBreakdownByDetailResponse> list(
      core.String accountId, core.String filterSetId, core.int creativeStatusId,
      {core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterSetId == null) {
      throw new core.ArgumentError("Parameter filterSetId is required.");
    }
    if (creativeStatusId == null) {
      throw new core.ArgumentError("Parameter creativeStatusId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets/' +
        commons.Escaper.ecapeVariable('$filterSetId') +
        '/filteredBids/' +
        commons.Escaper.ecapeVariable('$creativeStatusId') +
        '/details';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new ListCreativeStatusBreakdownByDetailResponse.fromJson(data));
  }
}

class AccountsFilterSetsImpressionMetricsResourceApi {
  final commons.ApiRequester _requester;

  AccountsFilterSetsImpressionMetricsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Lists all metrics that are measured in terms of number of impressions.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [filterSetId] - The ID of the filter set to apply.
  ///
  /// [pageSize] - Requested page size. The server may return fewer results than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListImpressionMetricsResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.filterSets.impressionMetrics.list
  /// method.
  ///
  /// Completes with a [ListImpressionMetricsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListImpressionMetricsResponse> list(
      core.String accountId, core.String filterSetId,
      {core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterSetId == null) {
      throw new core.ArgumentError("Parameter filterSetId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets/' +
        commons.Escaper.ecapeVariable('$filterSetId') +
        '/impressionMetrics';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ListImpressionMetricsResponse.fromJson(data));
  }
}

class AccountsFilterSetsLosingBidsResourceApi {
  final commons.ApiRequester _requester;

  AccountsFilterSetsLosingBidsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// List all reasons for which bids lost in the auction, with the number of
  /// bids that lost for each reason.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [filterSetId] - The ID of the filter set to apply.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListLosingBidsResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.filterSets.losingBids.list
  /// method.
  ///
  /// [pageSize] - Requested page size. The server may return fewer results than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// Completes with a [ListLosingBidsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListLosingBidsResponse> list(
      core.String accountId, core.String filterSetId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterSetId == null) {
      throw new core.ArgumentError("Parameter filterSetId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets/' +
        commons.Escaper.ecapeVariable('$filterSetId') +
        '/losingBids';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListLosingBidsResponse.fromJson(data));
  }
}

class AccountsFilterSetsNonBillableWinningBidsResourceApi {
  final commons.ApiRequester _requester;

  AccountsFilterSetsNonBillableWinningBidsResourceApi(
      commons.ApiRequester client)
      : _requester = client;

  /// List all reasons for which winning bids were not billable, with the number
  /// of bids not billed for each reason.
  ///
  /// Request parameters:
  ///
  /// [accountId] - Account ID of the buyer.
  ///
  /// [filterSetId] - The ID of the filter set to apply.
  ///
  /// [pageToken] - A token identifying a page of results the server should
  /// return.
  /// Typically, this is the value of
  /// ListNonBillableWinningBidsResponse.nextPageToken
  /// returned from the previous call to the
  /// accounts.filterSets.nonBillableWinningBids.list
  /// method.
  ///
  /// [pageSize] - Requested page size. The server may return fewer results than
  /// requested.
  /// If unspecified, the server will pick an appropriate default.
  ///
  /// Completes with a [ListNonBillableWinningBidsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListNonBillableWinningBidsResponse> list(
      core.String accountId, core.String filterSetId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterSetId == null) {
      throw new core.ArgumentError("Parameter filterSetId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/filterSets/' +
        commons.Escaper.ecapeVariable('$filterSetId') +
        '/nonBillableWinningBids';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ListNonBillableWinningBidsResponse.fromJson(data));
  }
}

/// An absolute date range, specified by its start date and end date.
/// The supported range of dates begins 30 days before today and ends today.
/// Validity checked upon filter set creation. If a filter set with an absolute
/// date range is run at a later date more than 30 days after start_date, it
/// will
/// fail.
class AbsoluteDateRange {
  /// The end date of the range (inclusive).
  /// Must be within the 30 days leading up to current date, and must be equal
  /// to
  /// or after start_date.
  Date endDate;

  /// The start date of the range (inclusive).
  /// Must be within the 30 days leading up to current date, and must be equal
  /// to
  /// or before end_date.
  Date startDate;

  AbsoluteDateRange();

  AbsoluteDateRange.fromJson(core.Map _json) {
    if (_json.containsKey("endDate")) {
      endDate = new Date.fromJson(_json["endDate"]);
    }
    if (_json.containsKey("startDate")) {
      startDate = new Date.fromJson(_json["startDate"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endDate != null) {
      _json["endDate"] = (endDate).toJson();
    }
    if (startDate != null) {
      _json["startDate"] = (startDate).toJson();
    }
    return _json;
  }
}

/// A request for associating a deal and a creative.
class AddDealAssociationRequest {
  /// The association between a creative and a deal that should be added.
  CreativeDealAssociation association;

  AddDealAssociationRequest();

  AddDealAssociationRequest.fromJson(core.Map _json) {
    if (_json.containsKey("association")) {
      association = new CreativeDealAssociation.fromJson(_json["association"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (association != null) {
      _json["association"] = (association).toJson();
    }
    return _json;
  }
}

/// @OutputOnly The app type the restriction applies to for mobile device.
class AppContext {
  /// The app types this restriction applies to.
  core.List<core.String> appTypes;

  AppContext();

  AppContext.fromJson(core.Map _json) {
    if (_json.containsKey("appTypes")) {
      appTypes = _json["appTypes"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (appTypes != null) {
      _json["appTypes"] = appTypes;
    }
    return _json;
  }
}

/// @OutputOnly The auction type the restriction applies to.
class AuctionContext {
  /// The auction types this restriction applies to.
  core.List<core.String> auctionTypes;

  AuctionContext();

  AuctionContext.fromJson(core.Map _json) {
    if (_json.containsKey("auctionTypes")) {
      auctionTypes = _json["auctionTypes"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (auctionTypes != null) {
      _json["auctionTypes"] = auctionTypes;
    }
    return _json;
  }
}

/// The set of metrics that are measured in numbers of bids, representing how
/// many bids with the specified dimension values were considered eligible at
/// each stage of the bidding funnel;
class BidMetricsRow {
  /// The number of bids that Ad Exchange received from the buyer.
  MetricValue bids;

  /// The number of bids that were permitted to compete in the auction.
  MetricValue bidsInAuction;

  /// The number of bids for which the buyer was billed.
  MetricValue billedImpressions;

  /// The number of bids that won an impression.
  MetricValue impressionsWon;

  /// The number of bids for which the corresponding impression was measurable
  /// for viewability (as defined by Active View).
  MetricValue measurableImpressions;

  /// The values of all dimensions associated with metric values in this row.
  RowDimensions rowDimensions;

  /// The number of bids for which the corresponding impression was viewable (as
  /// defined by Active View).
  MetricValue viewableImpressions;

  BidMetricsRow();

  BidMetricsRow.fromJson(core.Map _json) {
    if (_json.containsKey("bids")) {
      bids = new MetricValue.fromJson(_json["bids"]);
    }
    if (_json.containsKey("bidsInAuction")) {
      bidsInAuction = new MetricValue.fromJson(_json["bidsInAuction"]);
    }
    if (_json.containsKey("billedImpressions")) {
      billedImpressions = new MetricValue.fromJson(_json["billedImpressions"]);
    }
    if (_json.containsKey("impressionsWon")) {
      impressionsWon = new MetricValue.fromJson(_json["impressionsWon"]);
    }
    if (_json.containsKey("measurableImpressions")) {
      measurableImpressions =
          new MetricValue.fromJson(_json["measurableImpressions"]);
    }
    if (_json.containsKey("rowDimensions")) {
      rowDimensions = new RowDimensions.fromJson(_json["rowDimensions"]);
    }
    if (_json.containsKey("viewableImpressions")) {
      viewableImpressions =
          new MetricValue.fromJson(_json["viewableImpressions"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (bids != null) {
      _json["bids"] = (bids).toJson();
    }
    if (bidsInAuction != null) {
      _json["bidsInAuction"] = (bidsInAuction).toJson();
    }
    if (billedImpressions != null) {
      _json["billedImpressions"] = (billedImpressions).toJson();
    }
    if (impressionsWon != null) {
      _json["impressionsWon"] = (impressionsWon).toJson();
    }
    if (measurableImpressions != null) {
      _json["measurableImpressions"] = (measurableImpressions).toJson();
    }
    if (rowDimensions != null) {
      _json["rowDimensions"] = (rowDimensions).toJson();
    }
    if (viewableImpressions != null) {
      _json["viewableImpressions"] = (viewableImpressions).toJson();
    }
    return _json;
  }
}

/// The number of impressions with the specified dimension values that were
/// considered to have no applicable bids, as described by the specified status.
class BidResponseWithoutBidsStatusRow {
  /// The number of impressions for which there was a bid response with the
  /// specified status.
  MetricValue impressionCount;

  /// The values of all dimensions associated with metric values in this row.
  RowDimensions rowDimensions;

  /// The status specifying why the bid responses were considered to have no
  /// applicable bids.
  /// Possible string values are:
  /// - "STATUS_UNSPECIFIED" : A placeholder for an undefined status.
  /// This value will never be returned in responses.
  /// - "RESPONSES_WITHOUT_BIDS" : The response had no bids.
  /// - "RESPONSES_WITHOUT_BIDS_FOR_ACCOUNT" : The response had no bids for the
  /// specified account, though it may have
  /// included bids on behalf of other accounts.
  /// - "RESPONSES_WITHOUT_BIDS_FOR_DEAL" : The response had no bids for the
  /// specified deal, though it may have
  /// included bids on other deals on behalf of the account to which the deal
  /// belongs.
  core.String status;

  BidResponseWithoutBidsStatusRow();

  BidResponseWithoutBidsStatusRow.fromJson(core.Map _json) {
    if (_json.containsKey("impressionCount")) {
      impressionCount = new MetricValue.fromJson(_json["impressionCount"]);
    }
    if (_json.containsKey("rowDimensions")) {
      rowDimensions = new RowDimensions.fromJson(_json["rowDimensions"]);
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (impressionCount != null) {
      _json["impressionCount"] = (impressionCount).toJson();
    }
    if (rowDimensions != null) {
      _json["rowDimensions"] = (rowDimensions).toJson();
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/// The number of impressions with the specified dimension values where the
/// corresponding bid request or bid response was not successful, as described
/// by
/// the specified callout status.
class CalloutStatusRow {
  /// The ID of the callout status.
  /// See
  /// [callout-status-codes](https://developers.google.com/ad-exchange/rtb/downloads/callout-status-codes).
  core.int calloutStatusId;

  /// The number of impressions for which there was a bid request or bid
  /// response
  /// with the specified callout status.
  MetricValue impressionCount;

  /// The values of all dimensions associated with metric values in this row.
  RowDimensions rowDimensions;

  CalloutStatusRow();

  CalloutStatusRow.fromJson(core.Map _json) {
    if (_json.containsKey("calloutStatusId")) {
      calloutStatusId = _json["calloutStatusId"];
    }
    if (_json.containsKey("impressionCount")) {
      impressionCount = new MetricValue.fromJson(_json["impressionCount"]);
    }
    if (_json.containsKey("rowDimensions")) {
      rowDimensions = new RowDimensions.fromJson(_json["rowDimensions"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (calloutStatusId != null) {
      _json["calloutStatusId"] = calloutStatusId;
    }
    if (impressionCount != null) {
      _json["impressionCount"] = (impressionCount).toJson();
    }
    if (rowDimensions != null) {
      _json["rowDimensions"] = (rowDimensions).toJson();
    }
    return _json;
  }
}

/// A client resource represents a client buyer&mdash;an agency,
/// a brand, or an advertiser customer of the sponsor buyer.
/// Users associated with the client buyer have restricted access to
/// the Ad Exchange Marketplace and certain other sections
/// of the Ad Exchange Buyer UI based on the role
/// granted to the client buyer.
/// All fields are required unless otherwise specified.
class Client {
  /// The globally-unique numerical ID of the client.
  /// The value of this field is ignored in create and update operations.
  core.String clientAccountId;

  /// Name used to represent this client to publishers.
  /// You may have multiple clients that map to the same entity,
  /// but for each client the combination of `clientName` and entity
  /// must be unique.
  /// You can specify this field as empty.
  core.String clientName;

  /// Numerical identifier of the client entity.
  /// The entity can be an advertiser, a brand, or an agency.
  /// This identifier is unique among all the entities with the same type.
  ///
  /// A list of all known advertisers with their identifiers is available in the
  /// [advertisers.txt](https://storage.googleapis.com/adx-rtb-dictionaries/advertisers.txt)
  /// file.
  ///
  /// A list of all known brands with their identifiers is available in the
  /// [brands.txt](https://storage.googleapis.com/adx-rtb-dictionaries/brands.txt)
  /// file.
  ///
  /// A list of all known agencies with their identifiers is available in the
  /// [agencies.txt](https://storage.googleapis.com/adx-rtb-dictionaries/agencies.txt)
  /// file.
  core.String entityId;

  /// The name of the entity. This field is automatically fetched based on
  /// the type and ID.
  /// The value of this field is ignored in create and update operations.
  core.String entityName;

  /// The type of the client entity: `ADVERTISER`, `BRAND`, or `AGENCY`.
  /// Possible string values are:
  /// - "ENTITY_TYPE_UNSPECIFIED" : A placeholder for an undefined client entity
  /// type. Should not be used.
  /// - "ADVERTISER" : An advertiser.
  /// - "BRAND" : A brand.
  /// - "AGENCY" : An advertising agency.
  core.String entityType;

  /// The role which is assigned to the client buyer. Each role implies a set of
  /// permissions granted to the client. Must be one of `CLIENT_DEAL_VIEWER`,
  /// `CLIENT_DEAL_NEGOTIATOR` or `CLIENT_DEAL_APPROVER`.
  /// Possible string values are:
  /// - "CLIENT_ROLE_UNSPECIFIED" : A placeholder for an undefined client role.
  /// - "CLIENT_DEAL_VIEWER" : Users associated with this client can see
  /// publisher deal offers
  /// in the Marketplace.
  /// They can neither negotiate proposals nor approve deals.
  /// If this client is visible to publishers, they can send deal proposals
  /// to this client.
  /// - "CLIENT_DEAL_NEGOTIATOR" : Users associated with this client can respond
  /// to deal proposals
  /// sent to them by publishers. They can also initiate deal proposals
  /// of their own.
  /// - "CLIENT_DEAL_APPROVER" : Users associated with this client can approve
  /// eligible deals
  /// on your behalf. Some deals may still explicitly require publisher
  /// finalization. If this role is not selected, the sponsor buyer
  /// will need to manually approve each of their deals.
  core.String role;

  /// The status of the client buyer.
  /// Possible string values are:
  /// - "CLIENT_STATUS_UNSPECIFIED" : A placeholder for an undefined client
  /// status.
  /// - "DISABLED" : A client that is currently disabled.
  /// - "ACTIVE" : A client that is currently active.
  core.String status;

  /// Whether the client buyer will be visible to sellers.
  core.bool visibleToSeller;

  Client();

  Client.fromJson(core.Map _json) {
    if (_json.containsKey("clientAccountId")) {
      clientAccountId = _json["clientAccountId"];
    }
    if (_json.containsKey("clientName")) {
      clientName = _json["clientName"];
    }
    if (_json.containsKey("entityId")) {
      entityId = _json["entityId"];
    }
    if (_json.containsKey("entityName")) {
      entityName = _json["entityName"];
    }
    if (_json.containsKey("entityType")) {
      entityType = _json["entityType"];
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("visibleToSeller")) {
      visibleToSeller = _json["visibleToSeller"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (clientAccountId != null) {
      _json["clientAccountId"] = clientAccountId;
    }
    if (clientName != null) {
      _json["clientName"] = clientName;
    }
    if (entityId != null) {
      _json["entityId"] = entityId;
    }
    if (entityName != null) {
      _json["entityName"] = entityName;
    }
    if (entityType != null) {
      _json["entityType"] = entityType;
    }
    if (role != null) {
      _json["role"] = role;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (visibleToSeller != null) {
      _json["visibleToSeller"] = visibleToSeller;
    }
    return _json;
  }
}

/// A client user is created under a client buyer and has restricted access to
/// the Ad Exchange Marketplace and certain other sections
/// of the Ad Exchange Buyer UI based on the role
/// granted to the associated client buyer.
///
/// The only way a new client user can be created is via accepting an
/// email invitation
/// (see the
/// accounts.clients.invitations.create
/// method).
///
/// All fields are required unless otherwise specified.
class ClientUser {
  /// Numerical account ID of the client buyer
  /// with which the user is associated; the
  /// buyer must be a client of the current sponsor buyer.
  /// The value of this field is ignored in an update operation.
  core.String clientAccountId;

  /// User's email address. The value of this field
  /// is ignored in an update operation.
  core.String email;

  /// The status of the client user.
  /// Possible string values are:
  /// - "USER_STATUS_UNSPECIFIED" : A placeholder for an undefined user status.
  /// - "PENDING" : A user who was already created but hasn't accepted the
  /// invitation yet.
  /// - "ACTIVE" : A user that is currently active.
  /// - "DISABLED" : A user that is currently disabled.
  core.String status;

  /// The unique numerical ID of the client user
  /// that has accepted an invitation.
  /// The value of this field is ignored in an update operation.
  core.String userId;

  ClientUser();

  ClientUser.fromJson(core.Map _json) {
    if (_json.containsKey("clientAccountId")) {
      clientAccountId = _json["clientAccountId"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("userId")) {
      userId = _json["userId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (clientAccountId != null) {
      _json["clientAccountId"] = clientAccountId;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (userId != null) {
      _json["userId"] = userId;
    }
    return _json;
  }
}

/// An invitation for a new client user to get access to the Ad Exchange
/// Buyer UI.
/// All fields are required unless otherwise specified.
class ClientUserInvitation {
  /// Numerical account ID of the client buyer
  /// that the invited user is associated with.
  /// The value of this field is ignored in create operations.
  core.String clientAccountId;

  /// The email address to which the invitation is sent. Email
  /// addresses should be unique among all client users under each sponsor
  /// buyer.
  core.String email;

  /// The unique numerical ID of the invitation that is sent to the user.
  /// The value of this field is ignored in create operations.
  core.String invitationId;

  ClientUserInvitation();

  ClientUserInvitation.fromJson(core.Map _json) {
    if (_json.containsKey("clientAccountId")) {
      clientAccountId = _json["clientAccountId"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("invitationId")) {
      invitationId = _json["invitationId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (clientAccountId != null) {
      _json["clientAccountId"] = clientAccountId;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (invitationId != null) {
      _json["invitationId"] = invitationId;
    }
    return _json;
  }
}

/// @OutputOnly Shows any corrections that were applied to this creative.
class Correction {
  /// The contexts for the correction.
  core.List<ServingContext> contexts;

  /// Additional details about what was corrected.
  core.List<core.String> details;

  /// The type of correction that was applied to the creative.
  /// Possible string values are:
  /// - "CORRECTION_TYPE_UNSPECIFIED" : The correction type is unknown. Refer to
  /// the details for more information.
  /// - "VENDOR_IDS_ADDED" : The ad's declared vendors did not match the vendors
  /// that were detected.
  /// The detected vendors were added.
  /// - "SSL_ATTRIBUTE_REMOVED" : The ad had the SSL attribute declared but was
  /// not SSL-compliant.
  /// The SSL attribute was removed.
  /// - "FLASH_FREE_ATTRIBUTE_REMOVED" : The ad was declared as Flash-free but
  /// contained Flash, so the Flash-free
  /// attribute was removed.
  /// - "FLASH_FREE_ATTRIBUTE_ADDED" : The ad was not declared as Flash-free but
  /// it did not reference any flash
  /// content, so the Flash-free attribute was added.
  /// - "REQUIRED_ATTRIBUTE_ADDED" : The ad did not declare a required creative
  /// attribute.
  /// The attribute was added.
  /// - "REQUIRED_VENDOR_ADDED" : The ad did not declare a required technology
  /// vendor.
  /// The technology vendor was added.
  /// - "SSL_ATTRIBUTE_ADDED" : The ad did not declare the SSL attribute but was
  /// SSL-compliant, so the
  /// SSL attribute was added.
  /// - "IN_BANNER_VIDEO_ATTRIBUTE_ADDED" : Properties consistent with In-banner
  /// video were found, so an
  /// In-Banner Video attribute was added.
  /// - "MRAID_ATTRIBUTE_ADDED" : The ad makes calls to the MRAID API so the
  /// MRAID attribute was added.
  /// - "FLASH_ATTRIBUTE_REMOVED" : The ad unnecessarily declared the Flash
  /// attribute, so the Flash attribute
  /// was removed.
  /// - "VIDEO_IN_SNIPPET_ATTRIBUTE_ADDED" : The ad contains video content.
  core.String type;

  Correction();

  Correction.fromJson(core.Map _json) {
    if (_json.containsKey("contexts")) {
      contexts = _json["contexts"]
          .map((value) => new ServingContext.fromJson(value))
          .toList();
    }
    if (_json.containsKey("details")) {
      details = _json["details"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (contexts != null) {
      _json["contexts"] = contexts.map((value) => (value).toJson()).toList();
    }
    if (details != null) {
      _json["details"] = details;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/// A creative and its classification data.
class Creative {
  /// The account that this creative belongs to.
  /// Can be used to filter the response of the
  /// creatives.list
  /// method.
  core.String accountId;

  /// The link to AdChoices destination page.
  core.String adChoicesDestinationUrl;

  /// The name of the company being advertised in the creative.
  core.String advertiserName;

  /// The agency ID for this creative.
  core.String agencyId;

  /// @OutputOnly The last update timestamp of the creative via API.
  core.String apiUpdateTime;

  /// All attributes for the ads that may be shown from this creative.
  /// Can be used to filter the response of the
  /// creatives.list
  /// method.
  core.List<core.String> attributes;

  /// The set of destination URLs for the creative.
  core.List<core.String> clickThroughUrls;

  /// @OutputOnly Shows any corrections that were applied to this creative.
  core.List<Correction> corrections;

  /// The buyer-defined creative ID of this creative.
  /// Can be used to filter the response of the
  /// creatives.list
  /// method.
  core.String creativeId;

  /// @OutputOnly The top-level deals status of this creative.
  /// If disapproved, an entry for 'auctionType=DIRECT_DEALS' (or 'ALL') in
  /// serving_restrictions will also exist. Note
  /// that this may be nuanced with other contextual restrictions, in which
  /// case,
  /// it may be preferable to read from serving_restrictions directly.
  /// Can be used to filter the response of the
  /// creatives.list
  /// method.
  /// Possible string values are:
  /// - "STATUS_UNSPECIFIED" : The status is unknown.
  /// - "NOT_CHECKED" : The creative has not been checked.
  /// - "CONDITIONALLY_APPROVED" : The creative has been conditionally approved.
  /// See serving_restrictions for details.
  /// - "APPROVED" : The creative has been approved.
  /// - "DISAPPROVED" : The creative has been disapproved.
  core.String dealsStatus;

  /// @OutputOnly Detected advertiser IDs, if any.
  core.List<core.String> detectedAdvertiserIds;

  /// @OutputOnly
  /// The detected domains for this creative.
  core.List<core.String> detectedDomains;

  /// @OutputOnly
  /// The detected languages for this creative. The order is arbitrary. The
  /// codes
  /// are 2 or 5 characters and are documented at
  /// https://developers.google.com/adwords/api/docs/appendix/languagecodes.
  core.List<core.String> detectedLanguages;

  /// @OutputOnly Detected product categories, if any.
  /// See the ad-product-categories.txt file in the technical documentation
  /// for a list of IDs.
  core.List<core.int> detectedProductCategories;

  /// @OutputOnly Detected sensitive categories, if any.
  /// See the ad-sensitive-categories.txt file in the technical documentation
  /// for
  /// a list of IDs. You should use these IDs along with the
  /// excluded-sensitive-category field in the bid request to filter your bids.
  core.List<core.int> detectedSensitiveCategories;

  /// @OutputOnly The filtering stats for this creative.
  FilteringStats filteringStats;

  /// An HTML creative.
  HtmlContent html;

  /// The set of URLs to be called to record an impression.
  core.List<core.String> impressionTrackingUrls;

  /// A native creative.
  NativeContent native;

  /// @OutputOnly The top-level open auction status of this creative.
  /// If disapproved, an entry for 'auctionType = OPEN_AUCTION' (or 'ALL') in
  /// serving_restrictions will also exist. Note
  /// that this may be nuanced with other contextual restrictions, in which
  /// case,
  /// it may be preferable to read from serving_restrictions directly.
  /// Can be used to filter the response of the
  /// creatives.list
  /// method.
  /// Possible string values are:
  /// - "STATUS_UNSPECIFIED" : The status is unknown.
  /// - "NOT_CHECKED" : The creative has not been checked.
  /// - "CONDITIONALLY_APPROVED" : The creative has been conditionally approved.
  /// See serving_restrictions for details.
  /// - "APPROVED" : The creative has been approved.
  /// - "DISAPPROVED" : The creative has been disapproved.
  core.String openAuctionStatus;

  /// All restricted categories for the ads that may be shown from this
  /// creative.
  core.List<core.String> restrictedCategories;

  /// @OutputOnly The granular status of this ad in specific contexts.
  /// A context here relates to where something ultimately serves (for example,
  /// a physical location, a platform, an HTTPS vs HTTP request, or the type
  /// of auction).
  core.List<ServingRestriction> servingRestrictions;

  /// All vendor IDs for the ads that may be shown from this creative.
  /// See https://storage.googleapis.com/adx-rtb-dictionaries/vendors.txt
  /// for possible values.
  core.List<core.int> vendorIds;

  /// @OutputOnly The version of this creative.
  core.int version;

  /// A video creative.
  VideoContent video;

  Creative();

  Creative.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("adChoicesDestinationUrl")) {
      adChoicesDestinationUrl = _json["adChoicesDestinationUrl"];
    }
    if (_json.containsKey("advertiserName")) {
      advertiserName = _json["advertiserName"];
    }
    if (_json.containsKey("agencyId")) {
      agencyId = _json["agencyId"];
    }
    if (_json.containsKey("apiUpdateTime")) {
      apiUpdateTime = _json["apiUpdateTime"];
    }
    if (_json.containsKey("attributes")) {
      attributes = _json["attributes"];
    }
    if (_json.containsKey("clickThroughUrls")) {
      clickThroughUrls = _json["clickThroughUrls"];
    }
    if (_json.containsKey("corrections")) {
      corrections = _json["corrections"]
          .map((value) => new Correction.fromJson(value))
          .toList();
    }
    if (_json.containsKey("creativeId")) {
      creativeId = _json["creativeId"];
    }
    if (_json.containsKey("dealsStatus")) {
      dealsStatus = _json["dealsStatus"];
    }
    if (_json.containsKey("detectedAdvertiserIds")) {
      detectedAdvertiserIds = _json["detectedAdvertiserIds"];
    }
    if (_json.containsKey("detectedDomains")) {
      detectedDomains = _json["detectedDomains"];
    }
    if (_json.containsKey("detectedLanguages")) {
      detectedLanguages = _json["detectedLanguages"];
    }
    if (_json.containsKey("detectedProductCategories")) {
      detectedProductCategories = _json["detectedProductCategories"];
    }
    if (_json.containsKey("detectedSensitiveCategories")) {
      detectedSensitiveCategories = _json["detectedSensitiveCategories"];
    }
    if (_json.containsKey("filteringStats")) {
      filteringStats = new FilteringStats.fromJson(_json["filteringStats"]);
    }
    if (_json.containsKey("html")) {
      html = new HtmlContent.fromJson(_json["html"]);
    }
    if (_json.containsKey("impressionTrackingUrls")) {
      impressionTrackingUrls = _json["impressionTrackingUrls"];
    }
    if (_json.containsKey("native")) {
      native = new NativeContent.fromJson(_json["native"]);
    }
    if (_json.containsKey("openAuctionStatus")) {
      openAuctionStatus = _json["openAuctionStatus"];
    }
    if (_json.containsKey("restrictedCategories")) {
      restrictedCategories = _json["restrictedCategories"];
    }
    if (_json.containsKey("servingRestrictions")) {
      servingRestrictions = _json["servingRestrictions"]
          .map((value) => new ServingRestriction.fromJson(value))
          .toList();
    }
    if (_json.containsKey("vendorIds")) {
      vendorIds = _json["vendorIds"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
    if (_json.containsKey("video")) {
      video = new VideoContent.fromJson(_json["video"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (adChoicesDestinationUrl != null) {
      _json["adChoicesDestinationUrl"] = adChoicesDestinationUrl;
    }
    if (advertiserName != null) {
      _json["advertiserName"] = advertiserName;
    }
    if (agencyId != null) {
      _json["agencyId"] = agencyId;
    }
    if (apiUpdateTime != null) {
      _json["apiUpdateTime"] = apiUpdateTime;
    }
    if (attributes != null) {
      _json["attributes"] = attributes;
    }
    if (clickThroughUrls != null) {
      _json["clickThroughUrls"] = clickThroughUrls;
    }
    if (corrections != null) {
      _json["corrections"] =
          corrections.map((value) => (value).toJson()).toList();
    }
    if (creativeId != null) {
      _json["creativeId"] = creativeId;
    }
    if (dealsStatus != null) {
      _json["dealsStatus"] = dealsStatus;
    }
    if (detectedAdvertiserIds != null) {
      _json["detectedAdvertiserIds"] = detectedAdvertiserIds;
    }
    if (detectedDomains != null) {
      _json["detectedDomains"] = detectedDomains;
    }
    if (detectedLanguages != null) {
      _json["detectedLanguages"] = detectedLanguages;
    }
    if (detectedProductCategories != null) {
      _json["detectedProductCategories"] = detectedProductCategories;
    }
    if (detectedSensitiveCategories != null) {
      _json["detectedSensitiveCategories"] = detectedSensitiveCategories;
    }
    if (filteringStats != null) {
      _json["filteringStats"] = (filteringStats).toJson();
    }
    if (html != null) {
      _json["html"] = (html).toJson();
    }
    if (impressionTrackingUrls != null) {
      _json["impressionTrackingUrls"] = impressionTrackingUrls;
    }
    if (native != null) {
      _json["native"] = (native).toJson();
    }
    if (openAuctionStatus != null) {
      _json["openAuctionStatus"] = openAuctionStatus;
    }
    if (restrictedCategories != null) {
      _json["restrictedCategories"] = restrictedCategories;
    }
    if (servingRestrictions != null) {
      _json["servingRestrictions"] =
          servingRestrictions.map((value) => (value).toJson()).toList();
    }
    if (vendorIds != null) {
      _json["vendorIds"] = vendorIds;
    }
    if (version != null) {
      _json["version"] = version;
    }
    if (video != null) {
      _json["video"] = (video).toJson();
    }
    return _json;
  }
}

/// The association between a creative and a deal.
class CreativeDealAssociation {
  /// The account the creative belongs to.
  core.String accountId;

  /// The ID of the creative associated with the deal.
  core.String creativeId;

  /// The externalDealId for the deal associated with the creative.
  core.String dealsId;

  CreativeDealAssociation();

  CreativeDealAssociation.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("creativeId")) {
      creativeId = _json["creativeId"];
    }
    if (_json.containsKey("dealsId")) {
      dealsId = _json["dealsId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (creativeId != null) {
      _json["creativeId"] = creativeId;
    }
    if (dealsId != null) {
      _json["dealsId"] = dealsId;
    }
    return _json;
  }
}

/// The number of bids with the specified dimension values that did not win the
/// auction (either were filtered pre-auction or lost the auction), as described
/// by the specified creative status.
class CreativeStatusRow {
  /// The number of bids with the specified status.
  MetricValue bidCount;

  /// The ID of the creative status.
  /// See
  /// [creative-status-codes](https://developers.google.com/ad-exchange/rtb/downloads/creative-status-codes).
  core.int creativeStatusId;

  /// The values of all dimensions associated with metric values in this row.
  RowDimensions rowDimensions;

  CreativeStatusRow();

  CreativeStatusRow.fromJson(core.Map _json) {
    if (_json.containsKey("bidCount")) {
      bidCount = new MetricValue.fromJson(_json["bidCount"]);
    }
    if (_json.containsKey("creativeStatusId")) {
      creativeStatusId = _json["creativeStatusId"];
    }
    if (_json.containsKey("rowDimensions")) {
      rowDimensions = new RowDimensions.fromJson(_json["rowDimensions"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (bidCount != null) {
      _json["bidCount"] = (bidCount).toJson();
    }
    if (creativeStatusId != null) {
      _json["creativeStatusId"] = creativeStatusId;
    }
    if (rowDimensions != null) {
      _json["rowDimensions"] = (rowDimensions).toJson();
    }
    return _json;
  }
}

/// Represents a whole calendar date, e.g. date of birth. The time of day and
/// time zone are either specified elsewhere or are not significant. The date
/// is relative to the Proleptic Gregorian Calendar. The day may be 0 to
/// represent a year and month where the day is not significant, e.g. credit
/// card
/// expiration date. The year may be 0 to represent a month and day independent
/// of year, e.g. anniversary date. Related types are google.type.TimeOfDay
/// and `google.protobuf.Timestamp`.
class Date {
  /// Day of month. Must be from 1 to 31 and valid for the year and month, or 0
  /// if specifying a year/month where the day is not significant.
  core.int day;

  /// Month of year. Must be from 1 to 12.
  core.int month;

  /// Year of date. Must be from 1 to 9999, or 0 if specifying a date without
  /// a year.
  core.int year;

  Date();

  Date.fromJson(core.Map _json) {
    if (_json.containsKey("day")) {
      day = _json["day"];
    }
    if (_json.containsKey("month")) {
      month = _json["month"];
    }
    if (_json.containsKey("year")) {
      year = _json["year"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (day != null) {
      _json["day"] = day;
    }
    if (month != null) {
      _json["month"] = month;
    }
    if (year != null) {
      _json["year"] = year;
    }
    return _json;
  }
}

/// @OutputOnly The reason and details for a disapproval.
class Disapproval {
  /// Additional details about the reason for disapproval.
  core.List<core.String> details;

  /// The categorized reason for disapproval.
  /// Possible string values are:
  /// - "LENGTH_OF_IMAGE_ANIMATION" : The length of the image animation is
  /// longer than allowed.
  /// - "BROKEN_URL" : The click through URL doesn't work properly.
  /// - "MEDIA_NOT_FUNCTIONAL" : Something is wrong with the creative itself.
  /// - "INVALID_FOURTH_PARTY_CALL" : The ad makes a fourth party call to an
  /// unapproved vendor.
  /// - "INCORRECT_REMARKETING_DECLARATION" : The ad targets consumers using
  /// remarketing lists and/or collects
  /// data for subsequent use in retargeting, but does not correctly declare
  /// that use.
  /// - "LANDING_PAGE_ERROR" : Clicking on the ad leads to an error page.
  /// - "AD_SIZE_DOES_NOT_MATCH_AD_SLOT" : The ad size when rendered does not
  /// match the declaration.
  /// - "NO_BORDER" : Ads with a white background require a border, which was
  /// missing.
  /// - "FOURTH_PARTY_BROWSER_COOKIES" : The creative attempts to set cookies
  /// from a fourth party that is not
  /// certified.
  /// - "LSO_OBJECTS" : The creative sets an LSO object.
  /// - "BLANK_CREATIVE" : The ad serves a blank.
  /// - "DESTINATION_URLS_UNDECLARED" : The ad uses rotation, but not all
  /// destination URLs were declared.
  /// - "PROBLEM_WITH_CLICK_MACRO" : There is a problem with the way the click
  /// macro is used.
  /// - "INCORRECT_AD_TECHNOLOGY_DECLARATION" : The ad technology declaration is
  /// not accurate.
  /// - "INCORRECT_DESTINATION_URL_DECLARATION" : The actual destination URL
  /// does not match the declared destination URL.
  /// - "EXPANDABLE_INCORRECT_DIRECTION" : The declared expanding direction does
  /// not match the actual direction.
  /// - "EXPANDABLE_DIRECTION_NOT_SUPPORTED" : The ad does not expand in a
  /// supported direction.
  /// - "EXPANDABLE_INVALID_VENDOR" : The ad uses an expandable vendor that is
  /// not supported.
  /// - "EXPANDABLE_FUNCTIONALITY" : There was an issue with the expandable ad.
  /// - "VIDEO_INVALID_VENDOR" : The ad uses a video vendor that is not
  /// supported.
  /// - "VIDEO_UNSUPPORTED_LENGTH" : The length of the video ad is not
  /// supported.
  /// - "VIDEO_UNSUPPORTED_FORMAT" : The format of the video ad is not
  /// supported.
  /// - "VIDEO_FUNCTIONALITY" : There was an issue with the video ad.
  /// - "LANDING_PAGE_DISABLED" : The landing page does not conform to Ad
  /// Exchange policy.
  /// - "MALWARE_SUSPECTED" : The ad or the landing page may contain malware.
  /// - "ADULT_IMAGE_OR_VIDEO" : The ad contains adult images or video content.
  /// - "INACCURATE_AD_TEXT" : The ad contains text that is unclear or
  /// inaccurate.
  /// - "COUNTERFEIT_DESIGNER_GOODS" : The ad promotes counterfeit designer
  /// goods.
  /// - "POP_UP" : The ad causes a popup window to appear.
  /// - "INVALID_RTB_PROTOCOL_USAGE" : The creative does not follow policies set
  /// for the RTB protocol.
  /// - "RAW_IP_ADDRESS_IN_SNIPPET" : The ad contains a URL that uses a numeric
  /// IP address for the domain.
  /// - "UNACCEPTABLE_CONTENT_SOFTWARE" : The ad or landing page contains
  /// unacceptable content because it initiated
  /// a software or executable download.
  /// - "UNAUTHORIZED_COOKIE_ON_GOOGLE_DOMAIN" : The ad set an unauthorized
  /// cookie on a Google domain.
  /// - "UNDECLARED_FLASH_OBJECTS" : Flash content found when no flash was
  /// declared.
  /// - "INVALID_SSL_DECLARATION" : SSL support declared but not working
  /// correctly.
  /// - "DIRECT_DOWNLOAD_IN_AD" : Rich Media - Direct Download in Ad (ex. PDF
  /// download).
  /// - "MAXIMUM_DOWNLOAD_SIZE_EXCEEDED" : Maximum download size exceeded.
  /// - "DESTINATION_URL_SITE_NOT_CRAWLABLE" : Bad Destination URL: Site Not
  /// Crawlable.
  /// - "BAD_URL_LEGAL_DISAPPROVAL" : Bad URL: Legal disapproval.
  /// - "PHARMA_GAMBLING_ALCOHOL_NOT_ALLOWED" : Pharmaceuticals, Gambling,
  /// Alcohol not allowed and at least one was
  /// detected.
  /// - "DYNAMIC_DNS_AT_DESTINATION_URL" : Dynamic DNS at Destination URL.
  /// - "POOR_IMAGE_OR_VIDEO_QUALITY" : Poor Image / Video Quality.
  /// - "UNACCEPTABLE_IMAGE_CONTENT" : For example, Image Trick to Click.
  /// - "INCORRECT_IMAGE_LAYOUT" : Incorrect Image Layout.
  /// - "IRRELEVANT_IMAGE_OR_VIDEO" : Irrelevant Image / Video.
  /// - "DESTINATION_SITE_DOES_NOT_ALLOW_GOING_BACK" : Broken back button.
  /// - "MISLEADING_CLAIMS_IN_AD" : Misleading/Inaccurate claims in ads.
  /// - "RESTRICTED_PRODUCTS" : Restricted Products.
  /// - "UNACCEPTABLE_CONTENT" : Unacceptable content. For example, malware.
  /// - "AUTOMATED_AD_CLICKING" : The ad automatically redirects to the
  /// destination site without a click,
  /// or reports a click when none were made.
  /// - "INVALID_URL_PROTOCOL" : The ad uses URL protocols that do not exist or
  /// are not allowed on AdX.
  /// - "UNDECLARED_RESTRICTED_CONTENT" : Restricted content (for example,
  /// alcohol) was found in the ad but not
  /// declared.
  /// - "INVALID_REMARKETING_LIST_USAGE" : Violation of the remarketing list
  /// policy.
  /// - "DESTINATION_SITE_NOT_CRAWLABLE_ROBOTS_TXT" : The destination site's
  /// robot.txt file prevents it from being crawled.
  /// - "CLICK_TO_DOWNLOAD_NOT_AN_APP" : Click to download must link to an app.
  /// - "INACCURATE_REVIEW_EXTENSION" : A review extension must be an accurate
  /// review.
  /// - "SEXUALLY_EXPLICIT_CONTENT" : Sexually explicit content.
  /// - "GAINING_AN_UNFAIR_ADVANTAGE" : The ad tries to gain an unfair traffic
  /// advantage.
  /// - "GAMING_THE_GOOGLE_NETWORK" : The ad tries to circumvent Google's
  /// advertising systems.
  /// - "DANGEROUS_PRODUCTS_KNIVES" : The ad promotes dangerous knives.
  /// - "DANGEROUS_PRODUCTS_EXPLOSIVES" : The ad promotes explosives.
  /// - "DANGEROUS_PRODUCTS_GUNS" : The ad promotes guns & parts.
  /// - "DANGEROUS_PRODUCTS_DRUGS" : The ad promotes recreational drugs/services
  /// & related equipment.
  /// - "DANGEROUS_PRODUCTS_TOBACCO" : The ad promotes tobacco products/services
  /// & related equipment.
  /// - "DANGEROUS_PRODUCTS_WEAPONS" : The ad promotes weapons.
  /// - "UNCLEAR_OR_IRRELEVANT_AD" : The ad is unclear or irrelevant to the
  /// destination site.
  /// - "PROFESSIONAL_STANDARDS" : The ad does not meet professional standards.
  /// - "DYSFUNCTIONAL_PROMOTION" : The promotion is unnecessarily difficult to
  /// navigate.
  /// - "INVALID_INTEREST_BASED_AD" : Violation of Google's policy for
  /// interest-based ads.
  /// - "MISUSE_OF_PERSONAL_INFORMATION" : Misuse of personal information.
  /// - "OMISSION_OF_RELEVANT_INFORMATION" : Omission of relevant information.
  /// - "UNAVAILABLE_PROMOTIONS" : Unavailable promotions.
  /// - "MISLEADING_PROMOTIONS" : Misleading or unrealistic promotions.
  /// - "INAPPROPRIATE_CONTENT" : Offensive or inappropriate content.
  /// - "SENSITIVE_EVENTS" : Capitalizing on sensitive events.
  /// - "SHOCKING_CONTENT" : Shocking content.
  /// - "ENABLING_DISHONEST_BEHAVIOR" : Products & Services that enable
  /// dishonest behavior.
  /// - "TECHNICAL_REQUIREMENTS" : The ad does not meet technical requirements.
  /// - "RESTRICTED_POLITICAL_CONTENT" : Restricted political content.
  /// - "UNSUPPORTED_CONTENT" : Unsupported content.
  /// - "INVALID_BIDDING_METHOD" : Invalid bidding method.
  /// - "VIDEO_TOO_LONG" : Video length exceeds limits.
  /// - "VIOLATES_JAPANESE_PHARMACY_LAW" : Unacceptable content: Japanese
  /// healthcare.
  /// - "UNACCREDITED_PET_PHARMACY" : Online pharmacy ID required.
  /// - "ABORTION" : Unacceptable content: Abortion.
  /// - "CONTRACEPTIVES" : Unacceptable content: Birth control.
  /// - "NEED_CERTIFICATES_TO_ADVERTISE_IN_CHINA" : Restricted in China.
  /// - "KCDSP_REGISTRATION" : Unacceptable content: Korean healthcare.
  /// - "NOT_FAMILY_SAFE" : Non-family safe or adult content.
  /// - "CLINICAL_TRIAL_RECRUITMENT" : Clinical trial recruitment.
  /// - "MAXIMUM_NUMBER_OF_HTTP_CALLS_EXCEEDED" : Maximum number of HTTP calls
  /// exceeded.
  /// - "MAXIMUM_NUMBER_OF_COOKIES_EXCEEDED" : Maximum number of cookies
  /// exceeded.
  /// - "PERSONAL_LOANS" : Financial service ad does not adhere to
  /// specifications.
  /// - "UNSUPPORTED_FLASH_CONTENT" : Flash content was found in an unsupported
  /// context.
  core.String reason;

  Disapproval();

  Disapproval.fromJson(core.Map _json) {
    if (_json.containsKey("details")) {
      details = _json["details"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (details != null) {
      _json["details"] = details;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    return _json;
  }
}

/// A generic empty message that you can re-use to avoid defining duplicated
/// empty messages in your APIs. A typical example is to use it as the request
/// or the response type of an API method. For instance:
///
///     service Foo {
///       rpc Bar(google.protobuf.Empty) returns (google.protobuf.Empty);
///     }
///
/// The JSON representation for `Empty` is empty JSON object `{}`.
class Empty {
  Empty();

  Empty.fromJson(core.Map _json) {}

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    return _json;
  }
}

/// A set of filters that is applied to a request for data.
/// Within a filter set, an AND operation is performed across the filters
/// represented by each field. An OR operation is performed across the filters
/// represented by the multiple values of a repeated field. E.g.
/// "format=VIDEO AND deal_id=12 AND (seller_network_id=34 OR
/// seller_network_id=56)"
class FilterSet {
  /// An absolute date range, defined by a start date and an end date.
  /// Interpreted relative to Pacific time zone.
  AbsoluteDateRange absoluteDateRange;

  /// The ID of the buyer account on which to filter; optional.
  core.String buyerAccountId;

  /// The ID of the creative on which to filter; optional.
  core.String creativeId;

  /// The ID of the deal on which to filter; optional.
  core.String dealId;

  /// The environment on which to filter; optional.
  /// Possible string values are:
  /// - "ENVIRONMENT_UNSPECIFIED" : A placeholder for an undefined environment;
  /// indicates that no environment
  /// filter will be applied.
  /// - "WEB" : The ad impression appears on the web.
  /// - "APP" : The ad impression appears in an app.
  core.String environment;

  /// The ID of the filter set; unique within the account of the filter set
  /// owner.
  /// The value of this field is ignored in create operations.
  core.String filterSetId;

  /// The format on which to filter; optional.
  /// Possible string values are:
  /// - "FORMAT_UNSPECIFIED" : A placeholder for an undefined format; indicates
  /// that no format filter
  /// will be applied.
  /// - "DISPLAY" : The ad impression is display format (i.e. an image).
  /// - "VIDEO" : The ad impression is video format.
  core.String format;

  /// The account ID of the buyer who owns this filter set.
  /// The value of this field is ignored in create operations.
  core.String ownerAccountId;

  /// The list of platforms on which to filter; may be empty. The filters
  /// represented by multiple platforms are ORed together (i.e. if non-empty,
  /// results must match any one of the platforms).
  core.List<core.String> platforms;

  /// An open-ended realtime time range, defined by the aggregation start
  /// timestamp.
  RealtimeTimeRange realtimeTimeRange;

  /// A relative date range, defined by an offset from today and a duration.
  /// Interpreted relative to Pacific time zone.
  RelativeDateRange relativeDateRange;

  /// The list of IDs of the seller (publisher) networks on which to filter;
  /// may be empty. The filters represented by multiple seller network IDs are
  /// ORed together (i.e. if non-empty, results must match any one of the
  /// publisher networks).
  /// See
  /// [seller-network-ids](https://developers.google.com/ad-exchange/rtb/downloads/seller-network-ids)
  /// file for the set of existing seller network IDs.
  core.List<core.int> sellerNetworkIds;

  /// The granularity of time intervals if a time series breakdown is desired;
  /// optional.
  /// Possible string values are:
  /// - "TIME_SERIES_GRANULARITY_UNSPECIFIED" : A placeholder for an unspecified
  /// interval; no time series is applied.
  /// All rows in response will contain data for the entire requested time
  /// range.
  /// - "HOURLY" : Indicates that data will be broken down by the hour.
  /// - "DAILY" : Indicates that data will be broken down by the day.
  core.String timeSeriesGranularity;

  FilterSet();

  FilterSet.fromJson(core.Map _json) {
    if (_json.containsKey("absoluteDateRange")) {
      absoluteDateRange =
          new AbsoluteDateRange.fromJson(_json["absoluteDateRange"]);
    }
    if (_json.containsKey("buyerAccountId")) {
      buyerAccountId = _json["buyerAccountId"];
    }
    if (_json.containsKey("creativeId")) {
      creativeId = _json["creativeId"];
    }
    if (_json.containsKey("dealId")) {
      dealId = _json["dealId"];
    }
    if (_json.containsKey("environment")) {
      environment = _json["environment"];
    }
    if (_json.containsKey("filterSetId")) {
      filterSetId = _json["filterSetId"];
    }
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("ownerAccountId")) {
      ownerAccountId = _json["ownerAccountId"];
    }
    if (_json.containsKey("platforms")) {
      platforms = _json["platforms"];
    }
    if (_json.containsKey("realtimeTimeRange")) {
      realtimeTimeRange =
          new RealtimeTimeRange.fromJson(_json["realtimeTimeRange"]);
    }
    if (_json.containsKey("relativeDateRange")) {
      relativeDateRange =
          new RelativeDateRange.fromJson(_json["relativeDateRange"]);
    }
    if (_json.containsKey("sellerNetworkIds")) {
      sellerNetworkIds = _json["sellerNetworkIds"];
    }
    if (_json.containsKey("timeSeriesGranularity")) {
      timeSeriesGranularity = _json["timeSeriesGranularity"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (absoluteDateRange != null) {
      _json["absoluteDateRange"] = (absoluteDateRange).toJson();
    }
    if (buyerAccountId != null) {
      _json["buyerAccountId"] = buyerAccountId;
    }
    if (creativeId != null) {
      _json["creativeId"] = creativeId;
    }
    if (dealId != null) {
      _json["dealId"] = dealId;
    }
    if (environment != null) {
      _json["environment"] = environment;
    }
    if (filterSetId != null) {
      _json["filterSetId"] = filterSetId;
    }
    if (format != null) {
      _json["format"] = format;
    }
    if (ownerAccountId != null) {
      _json["ownerAccountId"] = ownerAccountId;
    }
    if (platforms != null) {
      _json["platforms"] = platforms;
    }
    if (realtimeTimeRange != null) {
      _json["realtimeTimeRange"] = (realtimeTimeRange).toJson();
    }
    if (relativeDateRange != null) {
      _json["relativeDateRange"] = (relativeDateRange).toJson();
    }
    if (sellerNetworkIds != null) {
      _json["sellerNetworkIds"] = sellerNetworkIds;
    }
    if (timeSeriesGranularity != null) {
      _json["timeSeriesGranularity"] = timeSeriesGranularity;
    }
    return _json;
  }
}

/// The number of filtered bids with the specified dimension values that have
/// the
/// specified creative.
class FilteredBidCreativeRow {
  /// The number of bids with the specified creative.
  MetricValue bidCount;

  /// The ID of the creative.
  core.String creativeId;

  /// The values of all dimensions associated with metric values in this row.
  RowDimensions rowDimensions;

  FilteredBidCreativeRow();

  FilteredBidCreativeRow.fromJson(core.Map _json) {
    if (_json.containsKey("bidCount")) {
      bidCount = new MetricValue.fromJson(_json["bidCount"]);
    }
    if (_json.containsKey("creativeId")) {
      creativeId = _json["creativeId"];
    }
    if (_json.containsKey("rowDimensions")) {
      rowDimensions = new RowDimensions.fromJson(_json["rowDimensions"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (bidCount != null) {
      _json["bidCount"] = (bidCount).toJson();
    }
    if (creativeId != null) {
      _json["creativeId"] = creativeId;
    }
    if (rowDimensions != null) {
      _json["rowDimensions"] = (rowDimensions).toJson();
    }
    return _json;
  }
}

/// The number of filtered bids with the specified dimension values, among those
/// filtered due to the requested filtering reason (i.e. creative status), that
/// have the specified detail.
class FilteredBidDetailRow {
  /// The number of bids with the specified detail.
  MetricValue bidCount;

  /// The ID of the detail. The associated value can be looked up in the
  /// dictionary file corresponding to the DetailType in the response message.
  core.int detailId;

  /// The values of all dimensions associated with metric values in this row.
  RowDimensions rowDimensions;

  FilteredBidDetailRow();

  FilteredBidDetailRow.fromJson(core.Map _json) {
    if (_json.containsKey("bidCount")) {
      bidCount = new MetricValue.fromJson(_json["bidCount"]);
    }
    if (_json.containsKey("detailId")) {
      detailId = _json["detailId"];
    }
    if (_json.containsKey("rowDimensions")) {
      rowDimensions = new RowDimensions.fromJson(_json["rowDimensions"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (bidCount != null) {
      _json["bidCount"] = (bidCount).toJson();
    }
    if (detailId != null) {
      _json["detailId"] = detailId;
    }
    if (rowDimensions != null) {
      _json["rowDimensions"] = (rowDimensions).toJson();
    }
    return _json;
  }
}

/// @OutputOnly Filtering reasons for this creative during a period of a single
/// day (from midnight to midnight Pacific).
class FilteringStats {
  /// The day during which the data was collected.
  /// The data is collected from 00:00:00 to 23:59:59 PT.
  /// During switches from PST to PDT and back, the day may
  /// contain 23 or 25 hours of data instead of the usual 24.
  Date date;

  /// The set of filtering reasons for this date.
  core.List<Reason> reasons;

  FilteringStats();

  FilteringStats.fromJson(core.Map _json) {
    if (_json.containsKey("date")) {
      date = new Date.fromJson(_json["date"]);
    }
    if (_json.containsKey("reasons")) {
      reasons =
          _json["reasons"].map((value) => new Reason.fromJson(value)).toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (date != null) {
      _json["date"] = (date).toJson();
    }
    if (reasons != null) {
      _json["reasons"] = reasons.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// HTML content for a creative.
class HtmlContent {
  /// The height of the HTML snippet in pixels.
  core.int height;

  /// The HTML snippet that displays the ad when inserted in the web page.
  core.String snippet;

  /// The width of the HTML snippet in pixels.
  core.int width;

  HtmlContent();

  HtmlContent.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("snippet")) {
      snippet = _json["snippet"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (height != null) {
      _json["height"] = height;
    }
    if (snippet != null) {
      _json["snippet"] = snippet;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/// An image resource. You may provide a larger image than was requested,
/// so long as the aspect ratio is preserved.
class Image {
  /// Image height in pixels.
  core.int height;

  /// The URL of the image.
  core.String url;

  /// Image width in pixels.
  core.int width;

  Image();

  Image.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (height != null) {
      _json["height"] = height;
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

/// The set of metrics that are measured in numbers of impressions, representing
/// how many impressions with the specified dimension values were considered
/// eligible at each stage of the bidding funnel.
class ImpressionMetricsRow {
  /// The number of impressions available to the buyer on Ad Exchange.
  /// In some cases this value may be unavailable.
  MetricValue availableImpressions;

  /// The number of impressions for which Ad Exchange sent the buyer a bid
  /// request.
  MetricValue bidRequests;

  /// The number of impressions that match the buyer's inventory pretargeting.
  MetricValue inventoryMatches;

  /// The number of impressions for which Ad Exchange received a response from
  /// the buyer that contained at least one applicable bid.
  MetricValue responsesWithBids;

  /// The values of all dimensions associated with metric values in this row.
  RowDimensions rowDimensions;

  /// The number of impressions for which the buyer successfully sent a response
  /// to Ad Exchange.
  MetricValue successfulResponses;

  ImpressionMetricsRow();

  ImpressionMetricsRow.fromJson(core.Map _json) {
    if (_json.containsKey("availableImpressions")) {
      availableImpressions =
          new MetricValue.fromJson(_json["availableImpressions"]);
    }
    if (_json.containsKey("bidRequests")) {
      bidRequests = new MetricValue.fromJson(_json["bidRequests"]);
    }
    if (_json.containsKey("inventoryMatches")) {
      inventoryMatches = new MetricValue.fromJson(_json["inventoryMatches"]);
    }
    if (_json.containsKey("responsesWithBids")) {
      responsesWithBids = new MetricValue.fromJson(_json["responsesWithBids"]);
    }
    if (_json.containsKey("rowDimensions")) {
      rowDimensions = new RowDimensions.fromJson(_json["rowDimensions"]);
    }
    if (_json.containsKey("successfulResponses")) {
      successfulResponses =
          new MetricValue.fromJson(_json["successfulResponses"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (availableImpressions != null) {
      _json["availableImpressions"] = (availableImpressions).toJson();
    }
    if (bidRequests != null) {
      _json["bidRequests"] = (bidRequests).toJson();
    }
    if (inventoryMatches != null) {
      _json["inventoryMatches"] = (inventoryMatches).toJson();
    }
    if (responsesWithBids != null) {
      _json["responsesWithBids"] = (responsesWithBids).toJson();
    }
    if (rowDimensions != null) {
      _json["rowDimensions"] = (rowDimensions).toJson();
    }
    if (successfulResponses != null) {
      _json["successfulResponses"] = (successfulResponses).toJson();
    }
    return _json;
  }
}

/// Response message for listing the metrics that are measured in number of
/// bids.
class ListBidMetricsResponse {
  /// List of rows, each containing a set of bid metrics.
  core.List<BidMetricsRow> bidMetricsRows;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListBidMetricsRequest.pageToken
  /// field in the subsequent call to the
  /// accounts.filterSets.bidMetrics.list
  /// method to retrieve the next page of results.
  core.String nextPageToken;

  ListBidMetricsResponse();

  ListBidMetricsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("bidMetricsRows")) {
      bidMetricsRows = _json["bidMetricsRows"]
          .map((value) => new BidMetricsRow.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (bidMetricsRows != null) {
      _json["bidMetricsRows"] =
          bidMetricsRows.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response message for listing all reasons that bid responses resulted in an
/// error.
class ListBidResponseErrorsResponse {
  /// List of rows, with counts of bid responses aggregated by callout status.
  core.List<CalloutStatusRow> calloutStatusRows;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListBidResponseErrorsRequest.pageToken
  /// field in the subsequent call to the
  /// accounts.filterSets.bidResponseErrors.list
  /// method to retrieve the next page of results.
  core.String nextPageToken;

  ListBidResponseErrorsResponse();

  ListBidResponseErrorsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("calloutStatusRows")) {
      calloutStatusRows = _json["calloutStatusRows"]
          .map((value) => new CalloutStatusRow.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (calloutStatusRows != null) {
      _json["calloutStatusRows"] =
          calloutStatusRows.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response message for listing all reasons that bid responses were considered
/// to have no applicable bids.
class ListBidResponsesWithoutBidsResponse {
  /// List of rows, with counts of bid responses without bids aggregated by
  /// status.
  core.List<BidResponseWithoutBidsStatusRow> bidResponseWithoutBidsStatusRows;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListBidResponsesWithoutBidsRequest.pageToken
  /// field in the subsequent call to the
  /// accounts.filterSets.bidResponsesWithoutBids.list
  /// method to retrieve the next page of results.
  core.String nextPageToken;

  ListBidResponsesWithoutBidsResponse();

  ListBidResponsesWithoutBidsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("bidResponseWithoutBidsStatusRows")) {
      bidResponseWithoutBidsStatusRows = _json[
              "bidResponseWithoutBidsStatusRows"]
          .map((value) => new BidResponseWithoutBidsStatusRow.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (bidResponseWithoutBidsStatusRows != null) {
      _json["bidResponseWithoutBidsStatusRows"] =
          bidResponseWithoutBidsStatusRows
              .map((value) => (value).toJson())
              .toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

class ListClientUserInvitationsResponse {
  /// The returned list of client users.
  core.List<ClientUserInvitation> invitations;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListClientUserInvitationsRequest.pageToken
  /// field in the subsequent call to the
  /// clients.invitations.list
  /// method to retrieve the next
  /// page of results.
  core.String nextPageToken;

  ListClientUserInvitationsResponse();

  ListClientUserInvitationsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("invitations")) {
      invitations = _json["invitations"]
          .map((value) => new ClientUserInvitation.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (invitations != null) {
      _json["invitations"] =
          invitations.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

class ListClientUsersResponse {
  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListClientUsersRequest.pageToken
  /// field in the subsequent call to the
  /// clients.invitations.list
  /// method to retrieve the next
  /// page of results.
  core.String nextPageToken;

  /// The returned list of client users.
  core.List<ClientUser> users;

  ListClientUsersResponse();

  ListClientUsersResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("users")) {
      users = _json["users"]
          .map((value) => new ClientUser.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (users != null) {
      _json["users"] = users.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ListClientsResponse {
  /// The returned list of clients.
  core.List<Client> clients;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListClientsRequest.pageToken
  /// field in the subsequent call to the
  /// accounts.clients.list method
  /// to retrieve the next page of results.
  core.String nextPageToken;

  ListClientsResponse();

  ListClientsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("clients")) {
      clients =
          _json["clients"].map((value) => new Client.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (clients != null) {
      _json["clients"] = clients.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response message for listing all creatives associated with a given filtered
/// bid reason.
class ListCreativeStatusBreakdownByCreativeResponse {
  /// List of rows, with counts of bids with a given creative status aggregated
  /// by creative.
  core.List<FilteredBidCreativeRow> filteredBidCreativeRows;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListCreativeStatusBreakdownByCreativeRequest.pageToken
  /// field in the subsequent call to the
  /// accounts.filterSets.filteredBids.creatives.list
  /// method to retrieve the next page of results.
  core.String nextPageToken;

  ListCreativeStatusBreakdownByCreativeResponse();

  ListCreativeStatusBreakdownByCreativeResponse.fromJson(core.Map _json) {
    if (_json.containsKey("filteredBidCreativeRows")) {
      filteredBidCreativeRows = _json["filteredBidCreativeRows"]
          .map((value) => new FilteredBidCreativeRow.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (filteredBidCreativeRows != null) {
      _json["filteredBidCreativeRows"] =
          filteredBidCreativeRows.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response message for listing all details associated with a given filtered
/// bid
/// reason.
class ListCreativeStatusBreakdownByDetailResponse {
  /// The type of detail that the detail IDs represent.
  /// Possible string values are:
  /// - "DETAIL_TYPE_UNSPECIFIED" : A placeholder for an undefined status.
  /// This value will never be returned in responses.
  /// - "CREATIVE_ATTRIBUTE" : Indicates that the detail ID refers to a creative
  /// attribute; see
  /// [publisher-excludable-creative-attributes](https://developers.google.com/ad-exchange/rtb/downloads/publisher-excludable-creative-attributes).
  /// - "VENDOR" : Indicates that the detail ID refers to a vendor; see
  /// [vendors](https://developers.google.com/ad-exchange/rtb/downloads/vendors).
  /// - "SENSITIVE_CATEGORY" : Indicates that the detail ID refers to a
  /// sensitive category; see
  /// [ad-sensitive-categories](https://developers.google.com/ad-exchange/rtb/downloads/ad-sensitive-categories).
  /// - "PRODUCT_CATEGORY" : Indicates that the detail ID refers to a product
  /// category; see
  /// [ad-product-categories](https://developers.google.com/ad-exchange/rtb/downloads/ad-product-categories).
  /// - "DISAPPROVAL_REASON" : Indicates that the detail ID refers to a
  /// disapproval reason; see
  /// DisapprovalReason enum in
  /// [snippet-status-report-proto](https://developers.google.com/ad-exchange/rtb/downloads/snippet-status-report-proto).
  core.String detailType;

  /// List of rows, with counts of bids with a given creative status aggregated
  /// by detail.
  core.List<FilteredBidDetailRow> filteredBidDetailRows;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListCreativeStatusBreakdownByDetailRequest.pageToken
  /// field in the subsequent call to the
  /// accounts.filterSets.filteredBids.details.list
  /// method to retrieve the next page of results.
  core.String nextPageToken;

  ListCreativeStatusBreakdownByDetailResponse();

  ListCreativeStatusBreakdownByDetailResponse.fromJson(core.Map _json) {
    if (_json.containsKey("detailType")) {
      detailType = _json["detailType"];
    }
    if (_json.containsKey("filteredBidDetailRows")) {
      filteredBidDetailRows = _json["filteredBidDetailRows"]
          .map((value) => new FilteredBidDetailRow.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (detailType != null) {
      _json["detailType"] = detailType;
    }
    if (filteredBidDetailRows != null) {
      _json["filteredBidDetailRows"] =
          filteredBidDetailRows.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// A response for listing creatives.
class ListCreativesResponse {
  /// The list of creatives.
  core.List<Creative> creatives;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListCreativesRequest.page_token
  /// field in the subsequent call to `ListCreatives` method to retrieve the
  /// next
  /// page of results.
  core.String nextPageToken;

  ListCreativesResponse();

  ListCreativesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("creatives")) {
      creatives = _json["creatives"]
          .map((value) => new Creative.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (creatives != null) {
      _json["creatives"] = creatives.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// A response for listing creative and deal associations
class ListDealAssociationsResponse {
  /// The list of associations.
  core.List<CreativeDealAssociation> associations;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListDealAssociationsRequest.page_token
  /// field in the subsequent call to 'ListDealAssociation' method to retrieve
  /// the next page of results.
  core.String nextPageToken;

  ListDealAssociationsResponse();

  ListDealAssociationsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("associations")) {
      associations = _json["associations"]
          .map((value) => new CreativeDealAssociation.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (associations != null) {
      _json["associations"] =
          associations.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response message for listing filter sets.
class ListFilterSetsResponse {
  /// The filter sets belonging to the buyer.
  core.List<FilterSet> filterSets;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListFilterSetsRequest.pageToken
  /// field in the subsequent call to the
  /// accounts.filterSets.list
  /// method to retrieve the next page of results.
  core.String nextPageToken;

  ListFilterSetsResponse();

  ListFilterSetsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("filterSets")) {
      filterSets = _json["filterSets"]
          .map((value) => new FilterSet.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (filterSets != null) {
      _json["filterSets"] =
          filterSets.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response message for listing all reasons that bid requests were filtered and
/// not sent to the buyer.
class ListFilteredBidRequestsResponse {
  /// List of rows, with counts of filtered bid requests aggregated by callout
  /// status.
  core.List<CalloutStatusRow> calloutStatusRows;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListFilteredBidRequestsRequest.pageToken
  /// field in the subsequent call to the
  /// accounts.filterSets.filteredBidRequests.list
  /// method to retrieve the next page of results.
  core.String nextPageToken;

  ListFilteredBidRequestsResponse();

  ListFilteredBidRequestsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("calloutStatusRows")) {
      calloutStatusRows = _json["calloutStatusRows"]
          .map((value) => new CalloutStatusRow.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (calloutStatusRows != null) {
      _json["calloutStatusRows"] =
          calloutStatusRows.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response message for listing all reasons that bids were filtered from the
/// auction.
class ListFilteredBidsResponse {
  /// List of rows, with counts of filtered bids aggregated by filtering reason
  /// (i.e. creative status).
  core.List<CreativeStatusRow> creativeStatusRows;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListFilteredBidsRequest.pageToken
  /// field in the subsequent call to the
  /// accounts.filterSets.filteredBids.list
  /// method to retrieve the next page of results.
  core.String nextPageToken;

  ListFilteredBidsResponse();

  ListFilteredBidsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("creativeStatusRows")) {
      creativeStatusRows = _json["creativeStatusRows"]
          .map((value) => new CreativeStatusRow.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (creativeStatusRows != null) {
      _json["creativeStatusRows"] =
          creativeStatusRows.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response message for listing the metrics that are measured in number of
/// impressions.
class ListImpressionMetricsResponse {
  /// List of rows, each containing a set of impression metrics.
  core.List<ImpressionMetricsRow> impressionMetricsRows;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListImpressionMetricsRequest.pageToken
  /// field in the subsequent call to the
  /// accounts.filterSets.impressionMetrics.list
  /// method to retrieve the next page of results.
  core.String nextPageToken;

  ListImpressionMetricsResponse();

  ListImpressionMetricsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("impressionMetricsRows")) {
      impressionMetricsRows = _json["impressionMetricsRows"]
          .map((value) => new ImpressionMetricsRow.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (impressionMetricsRows != null) {
      _json["impressionMetricsRows"] =
          impressionMetricsRows.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response message for listing all reasons that bids lost in the auction.
class ListLosingBidsResponse {
  /// List of rows, with counts of losing bids aggregated by loss reason (i.e.
  /// creative status).
  core.List<CreativeStatusRow> creativeStatusRows;

  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListLosingBidsRequest.pageToken
  /// field in the subsequent call to the
  /// accounts.filterSets.losingBids.list
  /// method to retrieve the next page of results.
  core.String nextPageToken;

  ListLosingBidsResponse();

  ListLosingBidsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("creativeStatusRows")) {
      creativeStatusRows = _json["creativeStatusRows"]
          .map((value) => new CreativeStatusRow.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (creativeStatusRows != null) {
      _json["creativeStatusRows"] =
          creativeStatusRows.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response message for listing all reasons for which a buyer was not billed
/// for
/// a winning bid.
class ListNonBillableWinningBidsResponse {
  /// A token to retrieve the next page of results.
  /// Pass this value in the
  /// ListNonBillableWinningBidsRequest.pageToken
  /// field in the subsequent call to the
  /// accounts.filterSets.nonBillableWinningBids.list
  /// method to retrieve the next page of results.
  core.String nextPageToken;

  /// List of rows, with counts of bids not billed aggregated by reason.
  core.List<NonBillableWinningBidStatusRow> nonBillableWinningBidStatusRows;

  ListNonBillableWinningBidsResponse();

  ListNonBillableWinningBidsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("nonBillableWinningBidStatusRows")) {
      nonBillableWinningBidStatusRows = _json["nonBillableWinningBidStatusRows"]
          .map((value) => new NonBillableWinningBidStatusRow.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (nonBillableWinningBidStatusRows != null) {
      _json["nonBillableWinningBidStatusRows"] = nonBillableWinningBidStatusRows
          .map((value) => (value).toJson())
          .toList();
    }
    return _json;
  }
}

/// @OutputOnly The Geo criteria the restriction applies to.
class LocationContext {
  /// IDs representing the geo location for this context.
  /// Please refer to the
  /// [geo-table.csv](https://storage.googleapis.com/adx-rtb-dictionaries/geo-table.csv)
  /// file for different geo criteria IDs.
  core.List<core.int> geoCriteriaIds;

  LocationContext();

  LocationContext.fromJson(core.Map _json) {
    if (_json.containsKey("geoCriteriaIds")) {
      geoCriteriaIds = _json["geoCriteriaIds"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (geoCriteriaIds != null) {
      _json["geoCriteriaIds"] = geoCriteriaIds;
    }
    return _json;
  }
}

/// A metric value, with an expected value and a variance; represents a count
/// that may be either exact or estimated (i.e. when sampled).
class MetricValue {
  /// The expected value of the metric.
  core.String value;

  /// The variance (i.e. square of the standard deviation) of the metric value.
  /// If value is exact, variance is 0.
  /// Can be used to calculate margin of error as a percentage of value, using
  /// the following formula, where Z is the standard constant that depends on
  /// the
  /// desired size of the confidence interval (e.g. for 90% confidence interval,
  /// use Z = 1.645):
  ///
  ///   marginOfError = 100 * Z * sqrt(variance) / value
  core.String variance;

  MetricValue();

  MetricValue.fromJson(core.Map _json) {
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
    if (_json.containsKey("variance")) {
      variance = _json["variance"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (value != null) {
      _json["value"] = value;
    }
    if (variance != null) {
      _json["variance"] = variance;
    }
    return _json;
  }
}

/// Native content for a creative.
class NativeContent {
  /// The name of the advertiser or sponsor, to be displayed in the ad creative.
  core.String advertiserName;

  /// The app icon, for app download ads.
  Image appIcon;

  /// A long description of the ad.
  core.String body;

  /// A label for the button that the user is supposed to click.
  core.String callToAction;

  /// The URL that the browser/SDK will load when the user clicks the ad.
  core.String clickLinkUrl;

  /// The URL to use for click tracking.
  core.String clickTrackingUrl;

  /// A short title for the ad.
  core.String headline;

  /// A large image.
  Image image;

  /// A smaller image, for the advertiser's logo.
  Image logo;

  /// The price of the promoted app including currency info.
  core.String priceDisplayText;

  /// The app rating in the app store. Must be in the range [0-5].
  core.double starRating;

  /// The URL to the app store to purchase/download the promoted app.
  core.String storeUrl;

  /// The URL to fetch a native video ad.
  core.String videoUrl;

  NativeContent();

  NativeContent.fromJson(core.Map _json) {
    if (_json.containsKey("advertiserName")) {
      advertiserName = _json["advertiserName"];
    }
    if (_json.containsKey("appIcon")) {
      appIcon = new Image.fromJson(_json["appIcon"]);
    }
    if (_json.containsKey("body")) {
      body = _json["body"];
    }
    if (_json.containsKey("callToAction")) {
      callToAction = _json["callToAction"];
    }
    if (_json.containsKey("clickLinkUrl")) {
      clickLinkUrl = _json["clickLinkUrl"];
    }
    if (_json.containsKey("clickTrackingUrl")) {
      clickTrackingUrl = _json["clickTrackingUrl"];
    }
    if (_json.containsKey("headline")) {
      headline = _json["headline"];
    }
    if (_json.containsKey("image")) {
      image = new Image.fromJson(_json["image"]);
    }
    if (_json.containsKey("logo")) {
      logo = new Image.fromJson(_json["logo"]);
    }
    if (_json.containsKey("priceDisplayText")) {
      priceDisplayText = _json["priceDisplayText"];
    }
    if (_json.containsKey("starRating")) {
      starRating = _json["starRating"];
    }
    if (_json.containsKey("storeUrl")) {
      storeUrl = _json["storeUrl"];
    }
    if (_json.containsKey("videoUrl")) {
      videoUrl = _json["videoUrl"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (advertiserName != null) {
      _json["advertiserName"] = advertiserName;
    }
    if (appIcon != null) {
      _json["appIcon"] = (appIcon).toJson();
    }
    if (body != null) {
      _json["body"] = body;
    }
    if (callToAction != null) {
      _json["callToAction"] = callToAction;
    }
    if (clickLinkUrl != null) {
      _json["clickLinkUrl"] = clickLinkUrl;
    }
    if (clickTrackingUrl != null) {
      _json["clickTrackingUrl"] = clickTrackingUrl;
    }
    if (headline != null) {
      _json["headline"] = headline;
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (logo != null) {
      _json["logo"] = (logo).toJson();
    }
    if (priceDisplayText != null) {
      _json["priceDisplayText"] = priceDisplayText;
    }
    if (starRating != null) {
      _json["starRating"] = starRating;
    }
    if (storeUrl != null) {
      _json["storeUrl"] = storeUrl;
    }
    if (videoUrl != null) {
      _json["videoUrl"] = videoUrl;
    }
    return _json;
  }
}

/// The number of winning bids with the specified dimension values for which the
/// buyer was not billed, as described by the specified status.
class NonBillableWinningBidStatusRow {
  /// The number of bids with the specified status.
  MetricValue bidCount;

  /// The values of all dimensions associated with metric values in this row.
  RowDimensions rowDimensions;

  /// The status specifying why the winning bids were not billed.
  /// Possible string values are:
  /// - "STATUS_UNSPECIFIED" : A placeholder for an undefined status.
  /// This value will never be returned in responses.
  /// - "AD_NOT_RENDERED" : The buyer was not billed because the ad was not
  /// rendered by the
  /// publisher.
  /// - "INVALID_IMPRESSION" : The buyer was not billed because the impression
  /// won by the bid was
  /// determined to be invalid.
  core.String status;

  NonBillableWinningBidStatusRow();

  NonBillableWinningBidStatusRow.fromJson(core.Map _json) {
    if (_json.containsKey("bidCount")) {
      bidCount = new MetricValue.fromJson(_json["bidCount"]);
    }
    if (_json.containsKey("rowDimensions")) {
      rowDimensions = new RowDimensions.fromJson(_json["rowDimensions"]);
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (bidCount != null) {
      _json["bidCount"] = (bidCount).toJson();
    }
    if (rowDimensions != null) {
      _json["rowDimensions"] = (rowDimensions).toJson();
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/// @OutputOnly The type of platform the restriction applies to.
class PlatformContext {
  /// The platforms this restriction applies to.
  core.List<core.String> platforms;

  PlatformContext();

  PlatformContext.fromJson(core.Map _json) {
    if (_json.containsKey("platforms")) {
      platforms = _json["platforms"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (platforms != null) {
      _json["platforms"] = platforms;
    }
    return _json;
  }
}

/// An open-ended realtime time range specified by the start timestamp.
/// For filter sets that specify a realtime time range RTB metrics continue to
/// be aggregated throughout the lifetime of the filter set.
class RealtimeTimeRange {
  /// The start timestamp of the real-time RTB metrics aggregation.
  core.String startTimestamp;

  RealtimeTimeRange();

  RealtimeTimeRange.fromJson(core.Map _json) {
    if (_json.containsKey("startTimestamp")) {
      startTimestamp = _json["startTimestamp"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (startTimestamp != null) {
      _json["startTimestamp"] = startTimestamp;
    }
    return _json;
  }
}

/// A specific filtering status and how many times it occurred.
class Reason {
  /// The number of times the creative was filtered for the status. The
  /// count is aggregated across all publishers on the exchange.
  core.String count;

  /// The filtering status code. Please refer to the
  /// [creative-status-codes.txt](https://storage.googleapis.com/adx-rtb-dictionaries/creative-status-codes.txt)
  /// file for different statuses.
  core.int status;

  Reason();

  Reason.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (count != null) {
      _json["count"] = count;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/// A relative date range, specified by an offset and a duration.
/// The supported range of dates begins 30 days before today and ends today.
/// I.e. the limits for these values are:
/// offset_days >= 0
/// duration_days >= 1
/// offset_days + duration_days <= 30
class RelativeDateRange {
  /// The number of days in the requested date range. E.g. for a range spanning
  /// today, 1. For a range spanning the last 7 days, 7.
  core.int durationDays;

  /// The end date of the filter set, specified as the number of days before
  /// today. E.g. for a range where the last date is today, 0.
  core.int offsetDays;

  RelativeDateRange();

  RelativeDateRange.fromJson(core.Map _json) {
    if (_json.containsKey("durationDays")) {
      durationDays = _json["durationDays"];
    }
    if (_json.containsKey("offsetDays")) {
      offsetDays = _json["offsetDays"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (durationDays != null) {
      _json["durationDays"] = durationDays;
    }
    if (offsetDays != null) {
      _json["offsetDays"] = offsetDays;
    }
    return _json;
  }
}

/// A request for removing the association between a deal and a creative.
class RemoveDealAssociationRequest {
  /// The association between a creative and a deal that should be removed.
  CreativeDealAssociation association;

  RemoveDealAssociationRequest();

  RemoveDealAssociationRequest.fromJson(core.Map _json) {
    if (_json.containsKey("association")) {
      association = new CreativeDealAssociation.fromJson(_json["association"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (association != null) {
      _json["association"] = (association).toJson();
    }
    return _json;
  }
}

/// A response may include multiple rows, breaking down along various
/// dimensions.
/// Encapsulates the values of all dimensions for a given row.
class RowDimensions {
  /// The time interval that this row represents.
  TimeInterval timeInterval;

  RowDimensions();

  RowDimensions.fromJson(core.Map _json) {
    if (_json.containsKey("timeInterval")) {
      timeInterval = new TimeInterval.fromJson(_json["timeInterval"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (timeInterval != null) {
      _json["timeInterval"] = (timeInterval).toJson();
    }
    return _json;
  }
}

/// @OutputOnly A security context.
class SecurityContext {
  /// The security types in this context.
  core.List<core.String> securities;

  SecurityContext();

  SecurityContext.fromJson(core.Map _json) {
    if (_json.containsKey("securities")) {
      securities = _json["securities"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (securities != null) {
      _json["securities"] = securities;
    }
    return _json;
  }
}

/// The serving context for this restriction.
class ServingContext {
  /// Matches all contexts.
  /// Possible string values are:
  /// - "SIMPLE_CONTEXT" : A simple context.
  core.String all;

  /// Matches impressions for a particular app type.
  AppContext appType;

  /// Matches impressions for a particular auction type.
  AuctionContext auctionType;

  /// Matches impressions coming from users *or* publishers in a specific
  /// location.
  LocationContext location;

  /// Matches impressions coming from a particular platform.
  PlatformContext platform;

  /// Matches impressions for a particular security type.
  SecurityContext securityType;

  ServingContext();

  ServingContext.fromJson(core.Map _json) {
    if (_json.containsKey("all")) {
      all = _json["all"];
    }
    if (_json.containsKey("appType")) {
      appType = new AppContext.fromJson(_json["appType"]);
    }
    if (_json.containsKey("auctionType")) {
      auctionType = new AuctionContext.fromJson(_json["auctionType"]);
    }
    if (_json.containsKey("location")) {
      location = new LocationContext.fromJson(_json["location"]);
    }
    if (_json.containsKey("platform")) {
      platform = new PlatformContext.fromJson(_json["platform"]);
    }
    if (_json.containsKey("securityType")) {
      securityType = new SecurityContext.fromJson(_json["securityType"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (all != null) {
      _json["all"] = all;
    }
    if (appType != null) {
      _json["appType"] = (appType).toJson();
    }
    if (auctionType != null) {
      _json["auctionType"] = (auctionType).toJson();
    }
    if (location != null) {
      _json["location"] = (location).toJson();
    }
    if (platform != null) {
      _json["platform"] = (platform).toJson();
    }
    if (securityType != null) {
      _json["securityType"] = (securityType).toJson();
    }
    return _json;
  }
}

/// @OutputOnly A representation of the status of an ad in a
/// specific context. A context here relates to where something ultimately
/// serves
/// (for example, a user or publisher geo, a platform, an HTTPS vs HTTP request,
/// or the type of auction).
class ServingRestriction {
  /// The contexts for the restriction.
  core.List<ServingContext> contexts;

  /// Any disapprovals bound to this restriction.
  /// Only present if status=DISAPPROVED.
  /// Can be used to filter the response of the
  /// creatives.list
  /// method.
  core.List<Disapproval> disapprovalReasons;

  /// The status of the creative in this context (for example, it has been
  /// explicitly disapproved or is pending review).
  /// Possible string values are:
  /// - "STATUS_UNSPECIFIED" : The status is not known.
  /// - "DISAPPROVAL" : The ad was disapproved in this context.
  /// - "PENDING_REVIEW" : The ad is pending review in this context.
  core.String status;

  ServingRestriction();

  ServingRestriction.fromJson(core.Map _json) {
    if (_json.containsKey("contexts")) {
      contexts = _json["contexts"]
          .map((value) => new ServingContext.fromJson(value))
          .toList();
    }
    if (_json.containsKey("disapprovalReasons")) {
      disapprovalReasons = _json["disapprovalReasons"]
          .map((value) => new Disapproval.fromJson(value))
          .toList();
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (contexts != null) {
      _json["contexts"] = contexts.map((value) => (value).toJson()).toList();
    }
    if (disapprovalReasons != null) {
      _json["disapprovalReasons"] =
          disapprovalReasons.map((value) => (value).toJson()).toList();
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/// A request for stopping notifications for changes to creative Status.
class StopWatchingCreativeRequest {
  StopWatchingCreativeRequest();

  StopWatchingCreativeRequest.fromJson(core.Map _json) {}

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    return _json;
  }
}

/// An interval of time, with an absolute start and end.
/// This is included in the response, for several reasons:
/// 1) The request may have specified start or end times relative to the time
/// the
///    request was sent; the response indicates the corresponding absolute time
///    interval.
/// 2) The request may have specified an end time past the latest time for which
///    data was available (e.g. if requesting data for the today); the response
///    indicates the latest time for which data was actually returned.
/// 3) The response data for a single request may be broken down into multiple
///    time intervals, if a time series was requested.
class TimeInterval {
  /// The timestamp marking the end of the range (exclusive) for which data is
  /// included.
  core.String endTime;

  /// The timestamp marking the start of the range (inclusive) for which data is
  /// included.
  core.String startTime;

  TimeInterval();

  TimeInterval.fromJson(core.Map _json) {
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

/// Video content for a creative.
class VideoContent {
  /// The URL to fetch a video ad.
  core.String videoUrl;

  VideoContent();

  VideoContent.fromJson(core.Map _json) {
    if (_json.containsKey("videoUrl")) {
      videoUrl = _json["videoUrl"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (videoUrl != null) {
      _json["videoUrl"] = videoUrl;
    }
    return _json;
  }
}

/// A request for watching changes to creative Status.
class WatchCreativeRequest {
  /// The Pub/Sub topic to publish notifications to.
  /// This topic must already exist and must give permission to
  /// ad-exchange-buyside-reports@google.com to write to the topic.
  /// This should be the full resource name in
  /// "projects/{project_id}/topics/{topic_id}" format.
  core.String topic;

  WatchCreativeRequest();

  WatchCreativeRequest.fromJson(core.Map _json) {
    if (_json.containsKey("topic")) {
      topic = _json["topic"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (topic != null) {
      _json["topic"] = topic;
    }
    return _json;
  }
}
