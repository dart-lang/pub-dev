// This is a generated file (see the discoveryapis_generator project).

library googleapis.content.v2;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client content/v2';

/**
 * Manages product items, inventory, and Merchant Center accounts for Google
 * Shopping.
 */
class ContentApi {
  /** Manage your product listings and accounts for Google Shopping */
  static const ContentScope = "https://www.googleapis.com/auth/content";


  final commons.ApiRequester _requester;

  AccountsResourceApi get accounts => new AccountsResourceApi(_requester);
  AccountshippingResourceApi get accountshipping => new AccountshippingResourceApi(_requester);
  AccountstatusesResourceApi get accountstatuses => new AccountstatusesResourceApi(_requester);
  AccounttaxResourceApi get accounttax => new AccounttaxResourceApi(_requester);
  DatafeedsResourceApi get datafeeds => new DatafeedsResourceApi(_requester);
  DatafeedstatusesResourceApi get datafeedstatuses => new DatafeedstatusesResourceApi(_requester);
  InventoryResourceApi get inventory => new InventoryResourceApi(_requester);
  OrdersResourceApi get orders => new OrdersResourceApi(_requester);
  ProductsResourceApi get products => new ProductsResourceApi(_requester);
  ProductstatusesResourceApi get productstatuses => new ProductstatusesResourceApi(_requester);
  ShippingsettingsResourceApi get shippingsettings => new ShippingsettingsResourceApi(_requester);

  ContentApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "content/v2/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AccountsResourceApi {
  final commons.ApiRequester _requester;

  AccountsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns information about the authenticated user.
   *
   * Request parameters:
   *
   * Completes with a [AccountsAuthInfoResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountsAuthInfoResponse> authinfo() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'accounts/authinfo';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountsAuthInfoResponse.fromJson(data));
  }

  /**
   * Retrieves, inserts, updates, and deletes multiple Merchant Center
   * (sub-)accounts in a single request.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [AccountsCustomBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountsCustomBatchResponse> custombatch(AccountsCustomBatchRequest request, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = 'accounts/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountsCustomBatchResponse.fromJson(data));
  }

  /**
   * Deletes a Merchant Center sub-account. This method can only be called for
   * multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String merchantId, core.String accountId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounts/' + commons.Escaper.ecapeVariable('$accountId');

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
   * Retrieves a Merchant Center account. This method can only be called for
   * accounts to which the managing account has access: either the managing
   * account itself or sub-accounts if the managing account is a multi-client
   * account.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account.
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> get(core.String merchantId, core.String accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounts/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Account.fromJson(data));
  }

  /**
   * Creates a Merchant Center sub-account. This method can only be called for
   * multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> insert(Account request, core.String merchantId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounts';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Account.fromJson(data));
  }

  /**
   * Lists the sub-accounts in your Merchant Center account. This method can
   * only be called for multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [maxResults] - The maximum number of accounts to return in the response,
   * used for paging.
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [AccountsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountsListResponse> list(core.String merchantId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountsListResponse.fromJson(data));
  }

  /**
   * Updates a Merchant Center account. This method can only be called for
   * accounts to which the managing account has access: either the managing
   * account itself or sub-accounts if the managing account is a multi-client
   * account. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> patch(Account request, core.String merchantId, core.String accountId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounts/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Account.fromJson(data));
  }

  /**
   * Updates a Merchant Center account. This method can only be called for
   * accounts to which the managing account has access: either the managing
   * account itself or sub-accounts if the managing account is a multi-client
   * account.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> update(Account request, core.String merchantId, core.String accountId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounts/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Account.fromJson(data));
  }

}


class AccountshippingResourceApi {
  final commons.ApiRequester _requester;

  AccountshippingResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves and updates the shipping settings of multiple accounts in a
   * single request.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [AccountshippingCustomBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountshippingCustomBatchResponse> custombatch(AccountshippingCustomBatchRequest request, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = 'accountshipping/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountshippingCustomBatchResponse.fromJson(data));
  }

  /**
   * Retrieves the shipping settings of the account. This method can only be
   * called for accounts to which the managing account has access: either the
   * managing account itself or sub-accounts if the managing account is a
   * multi-client account.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account for which to get/update account
   * shipping settings.
   *
   * Completes with a [AccountShipping].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountShipping> get(core.String merchantId, core.String accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accountshipping/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountShipping.fromJson(data));
  }

  /**
   * Lists the shipping settings of the sub-accounts in your Merchant Center
   * account. This method can only be called for multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [maxResults] - The maximum number of shipping settings to return in the
   * response, used for paging.
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [AccountshippingListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountshippingListResponse> list(core.String merchantId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accountshipping';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountshippingListResponse.fromJson(data));
  }

  /**
   * Updates the shipping settings of the account. This method can only be
   * called for accounts to which the managing account has access: either the
   * managing account itself or sub-accounts if the managing account is a
   * multi-client account. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account for which to get/update account
   * shipping settings.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [AccountShipping].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountShipping> patch(AccountShipping request, core.String merchantId, core.String accountId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accountshipping/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountShipping.fromJson(data));
  }

  /**
   * Updates the shipping settings of the account. This method can only be
   * called for accounts to which the managing account has access: either the
   * managing account itself or sub-accounts if the managing account is a
   * multi-client account.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account for which to get/update account
   * shipping settings.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [AccountShipping].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountShipping> update(AccountShipping request, core.String merchantId, core.String accountId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accountshipping/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountShipping.fromJson(data));
  }

}


class AccountstatusesResourceApi {
  final commons.ApiRequester _requester;

  AccountstatusesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [AccountstatusesCustomBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountstatusesCustomBatchResponse> custombatch(AccountstatusesCustomBatchRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'accountstatuses/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountstatusesCustomBatchResponse.fromJson(data));
  }

  /**
   * Retrieves the status of a Merchant Center account. This method can only be
   * called for accounts to which the managing account has access: either the
   * managing account itself or sub-accounts if the managing account is a
   * multi-client account.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account.
   *
   * Completes with a [AccountStatus].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountStatus> get(core.String merchantId, core.String accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accountstatuses/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountStatus.fromJson(data));
  }

  /**
   * Lists the statuses of the sub-accounts in your Merchant Center account.
   * This method can only be called for multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [maxResults] - The maximum number of account statuses to return in the
   * response, used for paging.
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [AccountstatusesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountstatusesListResponse> list(core.String merchantId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accountstatuses';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountstatusesListResponse.fromJson(data));
  }

}


class AccounttaxResourceApi {
  final commons.ApiRequester _requester;

  AccounttaxResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves and updates tax settings of multiple accounts in a single
   * request.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [AccounttaxCustomBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccounttaxCustomBatchResponse> custombatch(AccounttaxCustomBatchRequest request, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = 'accounttax/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccounttaxCustomBatchResponse.fromJson(data));
  }

  /**
   * Retrieves the tax settings of the account. This method can only be called
   * for accounts to which the managing account has access: either the managing
   * account itself or sub-accounts if the managing account is a multi-client
   * account.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account for which to get/update account tax
   * settings.
   *
   * Completes with a [AccountTax].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountTax> get(core.String merchantId, core.String accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounttax/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountTax.fromJson(data));
  }

  /**
   * Lists the tax settings of the sub-accounts in your Merchant Center account.
   * This method can only be called for multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [maxResults] - The maximum number of tax settings to return in the
   * response, used for paging.
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [AccounttaxListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccounttaxListResponse> list(core.String merchantId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounttax';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccounttaxListResponse.fromJson(data));
  }

  /**
   * Updates the tax settings of the account. This method can only be called for
   * accounts to which the managing account has access: either the managing
   * account itself or sub-accounts if the managing account is a multi-client
   * account. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account for which to get/update account tax
   * settings.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [AccountTax].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountTax> patch(AccountTax request, core.String merchantId, core.String accountId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounttax/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountTax.fromJson(data));
  }

  /**
   * Updates the tax settings of the account. This method can only be called for
   * accounts to which the managing account has access: either the managing
   * account itself or sub-accounts if the managing account is a multi-client
   * account.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account for which to get/update account tax
   * settings.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [AccountTax].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountTax> update(AccountTax request, core.String merchantId, core.String accountId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounttax/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountTax.fromJson(data));
  }

}


class DatafeedsResourceApi {
  final commons.ApiRequester _requester;

  DatafeedsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [DatafeedsCustomBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DatafeedsCustomBatchResponse> custombatch(DatafeedsCustomBatchRequest request, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = 'datafeeds/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DatafeedsCustomBatchResponse.fromJson(data));
  }

  /**
   * Deletes a datafeed from your Merchant Center account. This method can only
   * be called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - null
   *
   * [datafeedId] - null
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String merchantId, core.String datafeedId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (datafeedId == null) {
      throw new core.ArgumentError("Parameter datafeedId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/datafeeds/' + commons.Escaper.ecapeVariable('$datafeedId');

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
   * Retrieves a datafeed from your Merchant Center account. This method can
   * only be called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - null
   *
   * [datafeedId] - null
   *
   * Completes with a [Datafeed].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Datafeed> get(core.String merchantId, core.String datafeedId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (datafeedId == null) {
      throw new core.ArgumentError("Parameter datafeedId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/datafeeds/' + commons.Escaper.ecapeVariable('$datafeedId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Datafeed.fromJson(data));
  }

  /**
   * Registers a datafeed with your Merchant Center account. This method can
   * only be called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - null
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [Datafeed].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Datafeed> insert(Datafeed request, core.String merchantId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/datafeeds';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Datafeed.fromJson(data));
  }

  /**
   * Lists the datafeeds in your Merchant Center account. This method can only
   * be called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [maxResults] - The maximum number of products to return in the response,
   * used for paging.
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [DatafeedsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DatafeedsListResponse> list(core.String merchantId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/datafeeds';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DatafeedsListResponse.fromJson(data));
  }

  /**
   * Updates a datafeed of your Merchant Center account. This method can only be
   * called for non-multi-client accounts. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - null
   *
   * [datafeedId] - null
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [Datafeed].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Datafeed> patch(Datafeed request, core.String merchantId, core.String datafeedId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (datafeedId == null) {
      throw new core.ArgumentError("Parameter datafeedId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/datafeeds/' + commons.Escaper.ecapeVariable('$datafeedId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Datafeed.fromJson(data));
  }

  /**
   * Updates a datafeed of your Merchant Center account. This method can only be
   * called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - null
   *
   * [datafeedId] - null
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [Datafeed].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Datafeed> update(Datafeed request, core.String merchantId, core.String datafeedId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (datafeedId == null) {
      throw new core.ArgumentError("Parameter datafeedId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/datafeeds/' + commons.Escaper.ecapeVariable('$datafeedId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Datafeed.fromJson(data));
  }

}


class DatafeedstatusesResourceApi {
  final commons.ApiRequester _requester;

  DatafeedstatusesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [DatafeedstatusesCustomBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DatafeedstatusesCustomBatchResponse> custombatch(DatafeedstatusesCustomBatchRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'datafeedstatuses/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DatafeedstatusesCustomBatchResponse.fromJson(data));
  }

  /**
   * Retrieves the status of a datafeed from your Merchant Center account. This
   * method can only be called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - null
   *
   * [datafeedId] - null
   *
   * Completes with a [DatafeedStatus].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DatafeedStatus> get(core.String merchantId, core.String datafeedId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (datafeedId == null) {
      throw new core.ArgumentError("Parameter datafeedId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/datafeedstatuses/' + commons.Escaper.ecapeVariable('$datafeedId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DatafeedStatus.fromJson(data));
  }

  /**
   * Lists the statuses of the datafeeds in your Merchant Center account. This
   * method can only be called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [maxResults] - The maximum number of products to return in the response,
   * used for paging.
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [DatafeedstatusesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DatafeedstatusesListResponse> list(core.String merchantId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/datafeedstatuses';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DatafeedstatusesListResponse.fromJson(data));
  }

}


class InventoryResourceApi {
  final commons.ApiRequester _requester;

  InventoryResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Updates price and availability for multiple products or stores in a single
   * request. This operation does not update the expiration date of the
   * products. This method can only be called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [InventoryCustomBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<InventoryCustomBatchResponse> custombatch(InventoryCustomBatchRequest request, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = 'inventory/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new InventoryCustomBatchResponse.fromJson(data));
  }

  /**
   * Updates price and availability of a product in your Merchant Center
   * account. This operation does not update the expiration date of the product.
   * This method can only be called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [storeCode] - The code of the store for which to update price and
   * availability. Use online to update price and availability of an online
   * product.
   *
   * [productId] - The ID of the product for which to update price and
   * availability.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [InventorySetResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<InventorySetResponse> set(InventorySetRequest request, core.String merchantId, core.String storeCode, core.String productId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (storeCode == null) {
      throw new core.ArgumentError("Parameter storeCode is required.");
    }
    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/inventory/' + commons.Escaper.ecapeVariable('$storeCode') + '/products/' + commons.Escaper.ecapeVariable('$productId');

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new InventorySetResponse.fromJson(data));
  }

}


class OrdersResourceApi {
  final commons.ApiRequester _requester;

  OrdersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Marks an order as acknowledged. This method can only be called for
   * non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [OrdersAcknowledgeResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersAcknowledgeResponse> acknowledge(OrdersAcknowledgeRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/acknowledge';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersAcknowledgeResponse.fromJson(data));
  }

  /**
   * Sandbox only. Moves a test order from state "inProgress" to state
   * "pendingShipment". This method can only be called for non-multi-client
   * accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the test order to modify.
   *
   * Completes with a [OrdersAdvanceTestOrderResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersAdvanceTestOrderResponse> advancetestorder(core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/testorders/' + commons.Escaper.ecapeVariable('$orderId') + '/advance';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersAdvanceTestOrderResponse.fromJson(data));
  }

  /**
   * Cancels all line items in an order. This method can only be called for
   * non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order to cancel.
   *
   * Completes with a [OrdersCancelResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersCancelResponse> cancel(OrdersCancelRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/cancel';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersCancelResponse.fromJson(data));
  }

  /**
   * Cancels a line item. This method can only be called for non-multi-client
   * accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [OrdersCancelLineItemResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersCancelLineItemResponse> cancellineitem(OrdersCancelLineItemRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/cancelLineItem';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersCancelLineItemResponse.fromJson(data));
  }

  /**
   * Sandbox only. Creates a test order. This method can only be called for
   * non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * Completes with a [OrdersCreateTestOrderResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersCreateTestOrderResponse> createtestorder(OrdersCreateTestOrderRequest request, core.String merchantId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/testorders';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersCreateTestOrderResponse.fromJson(data));
  }

  /**
   * Retrieves or modifies multiple orders in a single request. This method can
   * only be called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [OrdersCustomBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersCustomBatchResponse> custombatch(OrdersCustomBatchRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'orders/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersCustomBatchResponse.fromJson(data));
  }

  /**
   * Retrieves an order from your Merchant Center account. This method can only
   * be called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [Order].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Order> get(core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Order.fromJson(data));
  }

  /**
   * Retrieves an order using merchant order id. This method can only be called
   * for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [merchantOrderId] - The merchant order id to be looked for.
   *
   * Completes with a [OrdersGetByMerchantOrderIdResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersGetByMerchantOrderIdResponse> getbymerchantorderid(core.String merchantId, core.String merchantOrderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (merchantOrderId == null) {
      throw new core.ArgumentError("Parameter merchantOrderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/ordersbymerchantid/' + commons.Escaper.ecapeVariable('$merchantOrderId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersGetByMerchantOrderIdResponse.fromJson(data));
  }

  /**
   * Sandbox only. Retrieves an order template that can be used to quickly
   * create a new order in sandbox. This method can only be called for
   * non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [templateName] - The name of the template to retrieve.
   * Possible string values are:
   * - "template1"
   * - "template1a"
   * - "template1b"
   * - "template2"
   *
   * Completes with a [OrdersGetTestOrderTemplateResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersGetTestOrderTemplateResponse> gettestordertemplate(core.String merchantId, core.String templateName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (templateName == null) {
      throw new core.ArgumentError("Parameter templateName is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/testordertemplates/' + commons.Escaper.ecapeVariable('$templateName');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersGetTestOrderTemplateResponse.fromJson(data));
  }

  /**
   * Lists the orders in your Merchant Center account. This method can only be
   * called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [acknowledged] - Obtains orders that match the acknowledgement status. When
   * set to true, obtains orders that have been acknowledged. When false,
   * obtains orders that have not been acknowledged.
   * We recommend using this filter set to false, in conjunction with the
   * acknowledge call, such that only un-acknowledged orders are returned.
   *
   * [maxResults] - The maximum number of orders to return in the response, used
   * for paging. The default value is 25 orders per page, and the maximum
   * allowed value is 250 orders per page.
   * Known issue: All List calls will return all Orders without limit regardless
   * of the value of this field.
   *
   * [orderBy] - The ordering of the returned list. The only supported value are
   * placedDate desc and placedDate asc for now, which returns orders sorted by
   * placement date. "placedDate desc" stands for listing orders by placement
   * date, from oldest to most recent. "placedDate asc" stands for listing
   * orders by placement date, from most recent to oldest. In future releases
   * we'll support other sorting criteria.
   * Possible string values are:
   * - "placedDate asc"
   * - "placedDate desc"
   *
   * [pageToken] - The token returned by the previous request.
   *
   * [placedDateEnd] - Obtains orders placed before this date (exclusively), in
   * ISO 8601 format.
   *
   * [placedDateStart] - Obtains orders placed after this date (inclusively), in
   * ISO 8601 format.
   *
   * [statuses] - Obtains orders that match any of the specified statuses.
   * Multiple values can be specified with comma separation. Additionally,
   * please note that active is a shortcut for pendingShipment and
   * partiallyShipped, and completed is a shortcut for shipped ,
   * partiallyDelivered, delivered, partiallyReturned, returned, and canceled.
   *
   * Completes with a [OrdersListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersListResponse> list(core.String merchantId, {core.bool acknowledged, core.int maxResults, core.String orderBy, core.String pageToken, core.String placedDateEnd, core.String placedDateStart, core.List<core.String> statuses}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (acknowledged != null) {
      _queryParams["acknowledged"] = ["${acknowledged}"];
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
    if (placedDateEnd != null) {
      _queryParams["placedDateEnd"] = [placedDateEnd];
    }
    if (placedDateStart != null) {
      _queryParams["placedDateStart"] = [placedDateStart];
    }
    if (statuses != null) {
      _queryParams["statuses"] = statuses;
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersListResponse.fromJson(data));
  }

  /**
   * Refund a portion of the order, up to the full amount paid. This method can
   * only be called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order to refund.
   *
   * Completes with a [OrdersRefundResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersRefundResponse> refund(OrdersRefundRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/refund';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersRefundResponse.fromJson(data));
  }

  /**
   * Returns a line item. This method can only be called for non-multi-client
   * accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [OrdersReturnLineItemResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersReturnLineItemResponse> returnlineitem(OrdersReturnLineItemRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/returnLineItem';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersReturnLineItemResponse.fromJson(data));
  }

  /**
   * Marks line item(s) as shipped. This method can only be called for
   * non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [OrdersShipLineItemsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersShipLineItemsResponse> shiplineitems(OrdersShipLineItemsRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/shipLineItems';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersShipLineItemsResponse.fromJson(data));
  }

  /**
   * Updates the merchant order ID for a given order. This method can only be
   * called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [OrdersUpdateMerchantOrderIdResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersUpdateMerchantOrderIdResponse> updatemerchantorderid(OrdersUpdateMerchantOrderIdRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/updateMerchantOrderId';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersUpdateMerchantOrderIdResponse.fromJson(data));
  }

  /**
   * Updates a shipment's status, carrier, and/or tracking ID. This method can
   * only be called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [OrdersUpdateShipmentResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersUpdateShipmentResponse> updateshipment(OrdersUpdateShipmentRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/updateShipment';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersUpdateShipmentResponse.fromJson(data));
  }

}


class ProductsResourceApi {
  final commons.ApiRequester _requester;

  ProductsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves, inserts, and deletes multiple products in a single request. This
   * method can only be called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [ProductsCustomBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProductsCustomBatchResponse> custombatch(ProductsCustomBatchRequest request, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = 'products/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProductsCustomBatchResponse.fromJson(data));
  }

  /**
   * Deletes a product from your Merchant Center account. This method can only
   * be called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [productId] - The ID of the product.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String merchantId, core.String productId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/products/' + commons.Escaper.ecapeVariable('$productId');

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
   * Retrieves a product from your Merchant Center account. This method can only
   * be called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [productId] - The ID of the product.
   *
   * Completes with a [Product].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Product> get(core.String merchantId, core.String productId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/products/' + commons.Escaper.ecapeVariable('$productId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Product.fromJson(data));
  }

  /**
   * Uploads a product to your Merchant Center account. If an item with the same
   * channel, contentLanguage, offerId, and targetCountry already exists, this
   * method updates that entry. This method can only be called for
   * non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [Product].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Product> insert(Product request, core.String merchantId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/products';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Product.fromJson(data));
  }

  /**
   * Lists the products in your Merchant Center account. This method can only be
   * called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [includeInvalidInsertedItems] - Flag to include the invalid inserted items
   * in the result of the list request. By default the invalid items are not
   * shown (the default value is false).
   *
   * [maxResults] - The maximum number of products to return in the response,
   * used for paging.
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [ProductsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProductsListResponse> list(core.String merchantId, {core.bool includeInvalidInsertedItems, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (includeInvalidInsertedItems != null) {
      _queryParams["includeInvalidInsertedItems"] = ["${includeInvalidInsertedItems}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/products';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProductsListResponse.fromJson(data));
  }

}


class ProductstatusesResourceApi {
  final commons.ApiRequester _requester;

  ProductstatusesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the statuses of multiple products in a single request. This method can
   * only be called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [ProductstatusesCustomBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProductstatusesCustomBatchResponse> custombatch(ProductstatusesCustomBatchRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'productstatuses/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProductstatusesCustomBatchResponse.fromJson(data));
  }

  /**
   * Gets the status of a product from your Merchant Center account. This method
   * can only be called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [productId] - The ID of the product.
   *
   * Completes with a [ProductStatus].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProductStatus> get(core.String merchantId, core.String productId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/productstatuses/' + commons.Escaper.ecapeVariable('$productId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProductStatus.fromJson(data));
  }

  /**
   * Lists the statuses of the products in your Merchant Center account. This
   * method can only be called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [includeInvalidInsertedItems] - Flag to include the invalid inserted items
   * in the result of the list request. By default the invalid items are not
   * shown (the default value is false).
   *
   * [maxResults] - The maximum number of product statuses to return in the
   * response, used for paging.
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [ProductstatusesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProductstatusesListResponse> list(core.String merchantId, {core.bool includeInvalidInsertedItems, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (includeInvalidInsertedItems != null) {
      _queryParams["includeInvalidInsertedItems"] = ["${includeInvalidInsertedItems}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/productstatuses';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProductstatusesListResponse.fromJson(data));
  }

}


class ShippingsettingsResourceApi {
  final commons.ApiRequester _requester;

  ShippingsettingsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves and updates the shipping settings of multiple accounts in a
   * single request.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [ShippingsettingsCustomBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ShippingsettingsCustomBatchResponse> custombatch(ShippingsettingsCustomBatchRequest request, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = 'shippingsettings/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ShippingsettingsCustomBatchResponse.fromJson(data));
  }

  /**
   * Retrieves the shipping settings of the account. This method can only be
   * called for accounts to which the managing account has access: either the
   * managing account itself or sub-accounts if the managing account is a
   * multi-client account.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account for which to get/update shipping
   * settings.
   *
   * Completes with a [ShippingSettings].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ShippingSettings> get(core.String merchantId, core.String accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/shippingsettings/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ShippingSettings.fromJson(data));
  }

  /**
   * Retrieves supported carriers and carrier services for an account.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the account for which to retrieve the supported
   * carriers.
   *
   * Completes with a [ShippingsettingsGetSupportedCarriersResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ShippingsettingsGetSupportedCarriersResponse> getsupportedcarriers(core.String merchantId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/supportedCarriers';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ShippingsettingsGetSupportedCarriersResponse.fromJson(data));
  }

  /**
   * Lists the shipping settings of the sub-accounts in your Merchant Center
   * account. This method can only be called for multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [maxResults] - The maximum number of shipping settings to return in the
   * response, used for paging.
   *
   * [pageToken] - The token returned by the previous request.
   *
   * Completes with a [ShippingsettingsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ShippingsettingsListResponse> list(core.String merchantId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/shippingsettings';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ShippingsettingsListResponse.fromJson(data));
  }

  /**
   * Updates the shipping settings of the account. This method can only be
   * called for accounts to which the managing account has access: either the
   * managing account itself or sub-accounts if the managing account is a
   * multi-client account. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account for which to get/update shipping
   * settings.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [ShippingSettings].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ShippingSettings> patch(ShippingSettings request, core.String merchantId, core.String accountId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/shippingsettings/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ShippingSettings.fromJson(data));
  }

  /**
   * Updates the shipping settings of the account. This method can only be
   * called for accounts to which the managing account has access: either the
   * managing account itself or sub-accounts if the managing account is a
   * multi-client account.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [accountId] - The ID of the account for which to get/update shipping
   * settings.
   *
   * [dryRun] - Flag to run the request in dry-run mode.
   *
   * Completes with a [ShippingSettings].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ShippingSettings> update(ShippingSettings request, core.String merchantId, core.String accountId, {core.bool dryRun}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (dryRun != null) {
      _queryParams["dryRun"] = ["${dryRun}"];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/shippingsettings/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ShippingSettings.fromJson(data));
  }

}



/** Account data. */
class Account {
  /** Indicates whether the merchant sells adult content. */
  core.bool adultContent;
  /**
   * List of linked AdWords accounts that are active or pending approval. To
   * create a new link request, add a new link with status active to the list.
   * It will remain in a pending state until approved or rejected either in the
   * AdWords interface or through the  AdWords API. To delete an active link, or
   * to cancel a link request, remove it from the list.
   */
  core.List<AccountAdwordsLink> adwordsLinks;
  /** Merchant Center account ID. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#account".
   */
  core.String kind;
  /** Display name for the account. */
  core.String name;
  /**
   * URL for individual seller reviews, i.e., reviews for each child account.
   */
  core.String reviewsUrl;
  /** Client-specific, locally-unique, internal ID for the child account. */
  core.String sellerId;
  /**
   * Users with access to the account. Every account (except for subaccounts)
   * must have at least one admin user.
   */
  core.List<AccountUser> users;
  /** The merchant's website. */
  core.String websiteUrl;

  Account();

  Account.fromJson(core.Map _json) {
    if (_json.containsKey("adultContent")) {
      adultContent = _json["adultContent"];
    }
    if (_json.containsKey("adwordsLinks")) {
      adwordsLinks = _json["adwordsLinks"].map((value) => new AccountAdwordsLink.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("reviewsUrl")) {
      reviewsUrl = _json["reviewsUrl"];
    }
    if (_json.containsKey("sellerId")) {
      sellerId = _json["sellerId"];
    }
    if (_json.containsKey("users")) {
      users = _json["users"].map((value) => new AccountUser.fromJson(value)).toList();
    }
    if (_json.containsKey("websiteUrl")) {
      websiteUrl = _json["websiteUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adultContent != null) {
      _json["adultContent"] = adultContent;
    }
    if (adwordsLinks != null) {
      _json["adwordsLinks"] = adwordsLinks.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (reviewsUrl != null) {
      _json["reviewsUrl"] = reviewsUrl;
    }
    if (sellerId != null) {
      _json["sellerId"] = sellerId;
    }
    if (users != null) {
      _json["users"] = users.map((value) => (value).toJson()).toList();
    }
    if (websiteUrl != null) {
      _json["websiteUrl"] = websiteUrl;
    }
    return _json;
  }
}

class AccountAdwordsLink {
  /** Customer ID of the AdWords account. */
  core.String adwordsId;
  /**
   * Status of the link between this Merchant Center account and the AdWords
   * account. Upon retrieval, it represents the actual status of the link and
   * can be either active if it was approved in Google AdWords or pending if
   * it's pending approval. Upon insertion, it represents the intended status of
   * the link. Re-uploading a link with status active when it's still pending or
   * with status pending when it's already active will have no effect: the
   * status will remain unchanged. Re-uploading a link with deprecated status
   * inactive is equivalent to not submitting the link at all and will delete
   * the link if it was active or cancel the link request if it was pending.
   */
  core.String status;

  AccountAdwordsLink();

  AccountAdwordsLink.fromJson(core.Map _json) {
    if (_json.containsKey("adwordsId")) {
      adwordsId = _json["adwordsId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adwordsId != null) {
      _json["adwordsId"] = adwordsId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

class AccountIdentifier {
  /**
   * The aggregator ID, set for aggregators and subaccounts (in that case, it
   * represents the aggregator of the subaccount).
   */
  core.String aggregatorId;
  /** The merchant account ID, set for individual accounts and subaccounts. */
  core.String merchantId;

  AccountIdentifier();

  AccountIdentifier.fromJson(core.Map _json) {
    if (_json.containsKey("aggregatorId")) {
      aggregatorId = _json["aggregatorId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aggregatorId != null) {
      _json["aggregatorId"] = aggregatorId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    return _json;
  }
}

/** The shipping settings of a merchant account. */
class AccountShipping {
  /** The ID of the account to which these account shipping settings belong. */
  core.String accountId;
  /** Carrier-based shipping calculations. */
  core.List<AccountShippingCarrierRate> carrierRates;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accountShipping".
   */
  core.String kind;
  /** Location groups for shipping. */
  core.List<AccountShippingLocationGroup> locationGroups;
  /** Rate tables definitions. */
  core.List<AccountShippingRateTable> rateTables;
  /** Shipping services describing shipping fees calculation. */
  core.List<AccountShippingShippingService> services;

  AccountShipping();

  AccountShipping.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("carrierRates")) {
      carrierRates = _json["carrierRates"].map((value) => new AccountShippingCarrierRate.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("locationGroups")) {
      locationGroups = _json["locationGroups"].map((value) => new AccountShippingLocationGroup.fromJson(value)).toList();
    }
    if (_json.containsKey("rateTables")) {
      rateTables = _json["rateTables"].map((value) => new AccountShippingRateTable.fromJson(value)).toList();
    }
    if (_json.containsKey("services")) {
      services = _json["services"].map((value) => new AccountShippingShippingService.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (carrierRates != null) {
      _json["carrierRates"] = carrierRates.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (locationGroups != null) {
      _json["locationGroups"] = locationGroups.map((value) => (value).toJson()).toList();
    }
    if (rateTables != null) {
      _json["rateTables"] = rateTables.map((value) => (value).toJson()).toList();
    }
    if (services != null) {
      _json["services"] = services.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A carrier-calculated shipping rate. */
class AccountShippingCarrierRate {
  /**
   * The carrier that is responsible for the shipping, such as "UPS", "FedEx",
   * or "USPS".
   */
  core.String carrier;
  /** The carrier service, such as "Ground" or "2Day". */
  core.String carrierService;
  /** Additive shipping rate modifier. */
  Price modifierFlatRate;
  /**
   * Multiplicative shipping rate modifier in percent. Represented as a floating
   * point number without the percentage character.
   */
  core.String modifierPercent;
  /** The name of the carrier rate. */
  core.String name;
  /**
   * The sale country for which this carrier rate is valid, represented as a
   * CLDR territory code.
   */
  core.String saleCountry;
  /** Shipping origin represented as a postal code. */
  core.String shippingOrigin;

  AccountShippingCarrierRate();

  AccountShippingCarrierRate.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("carrierService")) {
      carrierService = _json["carrierService"];
    }
    if (_json.containsKey("modifierFlatRate")) {
      modifierFlatRate = new Price.fromJson(_json["modifierFlatRate"]);
    }
    if (_json.containsKey("modifierPercent")) {
      modifierPercent = _json["modifierPercent"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("saleCountry")) {
      saleCountry = _json["saleCountry"];
    }
    if (_json.containsKey("shippingOrigin")) {
      shippingOrigin = _json["shippingOrigin"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (carrierService != null) {
      _json["carrierService"] = carrierService;
    }
    if (modifierFlatRate != null) {
      _json["modifierFlatRate"] = (modifierFlatRate).toJson();
    }
    if (modifierPercent != null) {
      _json["modifierPercent"] = modifierPercent;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (saleCountry != null) {
      _json["saleCountry"] = saleCountry;
    }
    if (shippingOrigin != null) {
      _json["shippingOrigin"] = shippingOrigin;
    }
    return _json;
  }
}

class AccountShippingCondition {
  /**
   * Delivery location in terms of a location group name. A location group with
   * this name must be specified among location groups.
   */
  core.String deliveryLocationGroup;
  /**
   * Delivery location in terms of a location ID. Can be used to represent
   * administrative areas, smaller country subdivisions, or cities.
   */
  core.String deliveryLocationId;
  /** Delivery location in terms of a postal code. */
  core.String deliveryPostalCode;
  /** Delivery location in terms of a postal code range. */
  AccountShippingPostalCodeRange deliveryPostalCodeRange;
  /**
   * Maximum shipping price. Forms an interval between the maximum of smaller
   * prices (exclusive) and this price (inclusive).
   */
  Price priceMax;
  /**
   * Shipping label of the product. The products with the label are matched.
   */
  core.String shippingLabel;
  /**
   * Maximum shipping weight. Forms an interval between the maximum of smaller
   * weight (exclusive) and this weight (inclusive).
   */
  Weight weightMax;

  AccountShippingCondition();

  AccountShippingCondition.fromJson(core.Map _json) {
    if (_json.containsKey("deliveryLocationGroup")) {
      deliveryLocationGroup = _json["deliveryLocationGroup"];
    }
    if (_json.containsKey("deliveryLocationId")) {
      deliveryLocationId = _json["deliveryLocationId"];
    }
    if (_json.containsKey("deliveryPostalCode")) {
      deliveryPostalCode = _json["deliveryPostalCode"];
    }
    if (_json.containsKey("deliveryPostalCodeRange")) {
      deliveryPostalCodeRange = new AccountShippingPostalCodeRange.fromJson(_json["deliveryPostalCodeRange"]);
    }
    if (_json.containsKey("priceMax")) {
      priceMax = new Price.fromJson(_json["priceMax"]);
    }
    if (_json.containsKey("shippingLabel")) {
      shippingLabel = _json["shippingLabel"];
    }
    if (_json.containsKey("weightMax")) {
      weightMax = new Weight.fromJson(_json["weightMax"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deliveryLocationGroup != null) {
      _json["deliveryLocationGroup"] = deliveryLocationGroup;
    }
    if (deliveryLocationId != null) {
      _json["deliveryLocationId"] = deliveryLocationId;
    }
    if (deliveryPostalCode != null) {
      _json["deliveryPostalCode"] = deliveryPostalCode;
    }
    if (deliveryPostalCodeRange != null) {
      _json["deliveryPostalCodeRange"] = (deliveryPostalCodeRange).toJson();
    }
    if (priceMax != null) {
      _json["priceMax"] = (priceMax).toJson();
    }
    if (shippingLabel != null) {
      _json["shippingLabel"] = shippingLabel;
    }
    if (weightMax != null) {
      _json["weightMax"] = (weightMax).toJson();
    }
    return _json;
  }
}

/**
 * A user-defined locations group in a given country. All the locations of the
 * group must be of the same type.
 */
class AccountShippingLocationGroup {
  /**
   * The CLDR territory code of the country in which this location group is.
   */
  core.String country;
  /**
   * A location ID (also called criteria ID) representing administrative areas,
   * smaller country subdivisions (counties), or cities.
   */
  core.List<core.String> locationIds;
  /** The name of the location group. */
  core.String name;
  /** A postal code range representing a city or a set of cities. */
  core.List<AccountShippingPostalCodeRange> postalCodeRanges;
  /**
   * A postal code representing a city or a set of cities.
   * - A single postal code (e.g., 12345)
   * - A postal code prefix followed by a star (e.g., 1234*)
   */
  core.List<core.String> postalCodes;

  AccountShippingLocationGroup();

  AccountShippingLocationGroup.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("locationIds")) {
      locationIds = _json["locationIds"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("postalCodeRanges")) {
      postalCodeRanges = _json["postalCodeRanges"].map((value) => new AccountShippingPostalCodeRange.fromJson(value)).toList();
    }
    if (_json.containsKey("postalCodes")) {
      postalCodes = _json["postalCodes"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (locationIds != null) {
      _json["locationIds"] = locationIds;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (postalCodeRanges != null) {
      _json["postalCodeRanges"] = postalCodeRanges.map((value) => (value).toJson()).toList();
    }
    if (postalCodes != null) {
      _json["postalCodes"] = postalCodes;
    }
    return _json;
  }
}

/**
 * A postal code range, that can be either:
 * - A range of postal codes (e.g., start=12340, end=12359)
 * - A range of postal codes prefixes (e.g., start=1234* end=1235*). Prefixes
 * must be of the same length (e.g., start=12* end=2* is invalid).
 */
class AccountShippingPostalCodeRange {
  /** The last (inclusive) postal code or prefix of the range. */
  core.String end;
  /** The first (inclusive) postal code or prefix of the range. */
  core.String start;

  AccountShippingPostalCodeRange();

  AccountShippingPostalCodeRange.fromJson(core.Map _json) {
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (end != null) {
      _json["end"] = end;
    }
    if (start != null) {
      _json["start"] = start;
    }
    return _json;
  }
}

/**
 * A single or bi-dimensional table of shipping rates. Each dimension is defined
 * in terms of consecutive price/weight ranges, delivery locations, or shipping
 * labels.
 */
class AccountShippingRateTable {
  /**
   * One-dimensional table cells define one condition along the same dimension.
   * Bi-dimensional table cells use two dimensions with respectively M and N
   * distinct values and must contain exactly M * N cells with distinct
   * conditions (for each possible value pairs).
   */
  core.List<AccountShippingRateTableCell> content;
  /** The name of the rate table. */
  core.String name;
  /**
   * The sale country for which this table is valid, represented as a CLDR
   * territory code.
   */
  core.String saleCountry;

  AccountShippingRateTable();

  AccountShippingRateTable.fromJson(core.Map _json) {
    if (_json.containsKey("content")) {
      content = _json["content"].map((value) => new AccountShippingRateTableCell.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("saleCountry")) {
      saleCountry = _json["saleCountry"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (content != null) {
      _json["content"] = content.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (saleCountry != null) {
      _json["saleCountry"] = saleCountry;
    }
    return _json;
  }
}

class AccountShippingRateTableCell {
  /**
   * Conditions for which the cell is valid. All cells in a table must use the
   * same dimension or pair of dimensions among price, weight, shipping label or
   * delivery location. If no condition is specified, the cell acts as a
   * catch-all and matches all the elements that are not matched by other cells
   * in this dimension.
   */
  AccountShippingCondition condition;
  /** The rate applicable if the cell conditions are matched. */
  Price rate;

  AccountShippingRateTableCell();

  AccountShippingRateTableCell.fromJson(core.Map _json) {
    if (_json.containsKey("condition")) {
      condition = new AccountShippingCondition.fromJson(_json["condition"]);
    }
    if (_json.containsKey("rate")) {
      rate = new Price.fromJson(_json["rate"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (condition != null) {
      _json["condition"] = (condition).toJson();
    }
    if (rate != null) {
      _json["rate"] = (rate).toJson();
    }
    return _json;
  }
}

/** Shipping services provided in a country. */
class AccountShippingShippingService {
  /** Whether the shipping service is available. */
  core.bool active;
  /** Calculation method for the "simple" case that needs no rules. */
  AccountShippingShippingServiceCalculationMethod calculationMethod;
  /** Decision tree for "complicated" shipping cost calculation. */
  AccountShippingShippingServiceCostRule costRuleTree;
  /**
   * The maximum number of days in transit. Must be a value between 0 and 250
   * included. A value of 0 means same day delivery.
   */
  core.String maxDaysInTransit;
  /**
   * The minimum number of days in transit. Must be a value between 0 and
   * maxDaysIntransit included. A value of 0 means same day delivery.
   */
  core.String minDaysInTransit;
  /** The name of this shipping service. */
  core.String name;
  /**
   * The CLDR territory code of the sale country for which this service can be
   * used.
   */
  core.String saleCountry;

  AccountShippingShippingService();

  AccountShippingShippingService.fromJson(core.Map _json) {
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("calculationMethod")) {
      calculationMethod = new AccountShippingShippingServiceCalculationMethod.fromJson(_json["calculationMethod"]);
    }
    if (_json.containsKey("costRuleTree")) {
      costRuleTree = new AccountShippingShippingServiceCostRule.fromJson(_json["costRuleTree"]);
    }
    if (_json.containsKey("maxDaysInTransit")) {
      maxDaysInTransit = _json["maxDaysInTransit"];
    }
    if (_json.containsKey("minDaysInTransit")) {
      minDaysInTransit = _json["minDaysInTransit"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("saleCountry")) {
      saleCountry = _json["saleCountry"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (active != null) {
      _json["active"] = active;
    }
    if (calculationMethod != null) {
      _json["calculationMethod"] = (calculationMethod).toJson();
    }
    if (costRuleTree != null) {
      _json["costRuleTree"] = (costRuleTree).toJson();
    }
    if (maxDaysInTransit != null) {
      _json["maxDaysInTransit"] = maxDaysInTransit;
    }
    if (minDaysInTransit != null) {
      _json["minDaysInTransit"] = minDaysInTransit;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (saleCountry != null) {
      _json["saleCountry"] = saleCountry;
    }
    return _json;
  }
}

/** Shipping cost calculation method. Exactly one of the field is set. */
class AccountShippingShippingServiceCalculationMethod {
  /** Name of the carrier rate to use for the calculation. */
  core.String carrierRate;
  /** Delivery is excluded. Valid only within cost rules tree. */
  core.bool excluded;
  /**
   * Fixed price shipping, represented as a floating point number associated
   * with a currency.
   */
  Price flatRate;
  /**
   * Percentage of the price, represented as a floating point number without the
   * percentage character.
   */
  core.String percentageRate;
  /** Name of the rate table to use for the calculation. */
  core.String rateTable;

  AccountShippingShippingServiceCalculationMethod();

  AccountShippingShippingServiceCalculationMethod.fromJson(core.Map _json) {
    if (_json.containsKey("carrierRate")) {
      carrierRate = _json["carrierRate"];
    }
    if (_json.containsKey("excluded")) {
      excluded = _json["excluded"];
    }
    if (_json.containsKey("flatRate")) {
      flatRate = new Price.fromJson(_json["flatRate"]);
    }
    if (_json.containsKey("percentageRate")) {
      percentageRate = _json["percentageRate"];
    }
    if (_json.containsKey("rateTable")) {
      rateTable = _json["rateTable"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrierRate != null) {
      _json["carrierRate"] = carrierRate;
    }
    if (excluded != null) {
      _json["excluded"] = excluded;
    }
    if (flatRate != null) {
      _json["flatRate"] = (flatRate).toJson();
    }
    if (percentageRate != null) {
      _json["percentageRate"] = percentageRate;
    }
    if (rateTable != null) {
      _json["rateTable"] = rateTable;
    }
    return _json;
  }
}

/**
 * Building block of the cost calculation decision tree.
 * - The tree root should have no condition and no calculation method.
 * - All the children must have a condition on the same dimension. The first
 * child matching a condition is entered, therefore, price and weight conditions
 * form contiguous intervals.
 * - The last child of an element must have no condition and matches all
 * elements not previously matched.
 * - Children and calculation method are mutually exclusive, and exactly one of
 * them must be defined; the root must only have children.
 */
class AccountShippingShippingServiceCostRule {
  /** Final calculation method to be used only in leaf nodes. */
  AccountShippingShippingServiceCalculationMethod calculationMethod;
  /**
   * Subsequent rules to be applied, only for inner nodes. The last child must
   * not specify a condition and acts as a catch-all.
   */
  core.List<AccountShippingShippingServiceCostRule> children;
  /**
   * Condition for this rule to be applicable. If no condition is specified, the
   * rule acts as a catch-all.
   */
  AccountShippingCondition condition;

  AccountShippingShippingServiceCostRule();

  AccountShippingShippingServiceCostRule.fromJson(core.Map _json) {
    if (_json.containsKey("calculationMethod")) {
      calculationMethod = new AccountShippingShippingServiceCalculationMethod.fromJson(_json["calculationMethod"]);
    }
    if (_json.containsKey("children")) {
      children = _json["children"].map((value) => new AccountShippingShippingServiceCostRule.fromJson(value)).toList();
    }
    if (_json.containsKey("condition")) {
      condition = new AccountShippingCondition.fromJson(_json["condition"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (calculationMethod != null) {
      _json["calculationMethod"] = (calculationMethod).toJson();
    }
    if (children != null) {
      _json["children"] = children.map((value) => (value).toJson()).toList();
    }
    if (condition != null) {
      _json["condition"] = (condition).toJson();
    }
    return _json;
  }
}

/**
 * The status of an account, i.e., information about its products, which is
 * computed offline and not returned immediately at insertion time.
 */
class AccountStatus {
  /** The ID of the account for which the status is reported. */
  core.String accountId;
  /** A list of data quality issues. */
  core.List<AccountStatusDataQualityIssue> dataQualityIssues;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accountStatus".
   */
  core.String kind;

  AccountStatus();

  AccountStatus.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("dataQualityIssues")) {
      dataQualityIssues = _json["dataQualityIssues"].map((value) => new AccountStatusDataQualityIssue.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (dataQualityIssues != null) {
      _json["dataQualityIssues"] = dataQualityIssues.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class AccountStatusDataQualityIssue {
  /** Country for which this issue is reported. */
  core.String country;
  /** A more detailed description of the issue. */
  core.String detail;
  /** Actual value displayed on the landing page. */
  core.String displayedValue;
  /** Example items featuring the issue. */
  core.List<AccountStatusExampleItem> exampleItems;
  /** Issue identifier. */
  core.String id;
  /** Last time the account was checked for this issue. */
  core.String lastChecked;
  /** The attribute name that is relevant for the issue. */
  core.String location;
  /** Number of items in the account found to have the said issue. */
  core.int numItems;
  /** Severity of the problem. */
  core.String severity;
  /** Submitted value that causes the issue. */
  core.String submittedValue;

  AccountStatusDataQualityIssue();

  AccountStatusDataQualityIssue.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("detail")) {
      detail = _json["detail"];
    }
    if (_json.containsKey("displayedValue")) {
      displayedValue = _json["displayedValue"];
    }
    if (_json.containsKey("exampleItems")) {
      exampleItems = _json["exampleItems"].map((value) => new AccountStatusExampleItem.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("lastChecked")) {
      lastChecked = _json["lastChecked"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("numItems")) {
      numItems = _json["numItems"];
    }
    if (_json.containsKey("severity")) {
      severity = _json["severity"];
    }
    if (_json.containsKey("submittedValue")) {
      submittedValue = _json["submittedValue"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (detail != null) {
      _json["detail"] = detail;
    }
    if (displayedValue != null) {
      _json["displayedValue"] = displayedValue;
    }
    if (exampleItems != null) {
      _json["exampleItems"] = exampleItems.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (lastChecked != null) {
      _json["lastChecked"] = lastChecked;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (numItems != null) {
      _json["numItems"] = numItems;
    }
    if (severity != null) {
      _json["severity"] = severity;
    }
    if (submittedValue != null) {
      _json["submittedValue"] = submittedValue;
    }
    return _json;
  }
}

/**
 * An example of an item that has poor data quality. An item value on the
 * landing page differs from what is submitted, or conflicts with a policy.
 */
class AccountStatusExampleItem {
  /** Unique item ID as specified in the uploaded product data. */
  core.String itemId;
  /** Landing page of the item. */
  core.String link;
  /** The item value that was submitted. */
  core.String submittedValue;
  /** Title of the item. */
  core.String title;
  /** The actual value on the landing page. */
  core.String valueOnLandingPage;

  AccountStatusExampleItem();

  AccountStatusExampleItem.fromJson(core.Map _json) {
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
    if (_json.containsKey("link")) {
      link = _json["link"];
    }
    if (_json.containsKey("submittedValue")) {
      submittedValue = _json["submittedValue"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("valueOnLandingPage")) {
      valueOnLandingPage = _json["valueOnLandingPage"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    if (link != null) {
      _json["link"] = link;
    }
    if (submittedValue != null) {
      _json["submittedValue"] = submittedValue;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (valueOnLandingPage != null) {
      _json["valueOnLandingPage"] = valueOnLandingPage;
    }
    return _json;
  }
}

/** The tax settings of a merchant account. */
class AccountTax {
  /** The ID of the account to which these account tax settings belong. */
  core.String accountId;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accountTax".
   */
  core.String kind;
  /**
   * Tax rules. Updating the tax rules will enable US taxes (not reversible).
   * Defining no rules is equivalent to not charging tax at all.
   */
  core.List<AccountTaxTaxRule> rules;

  AccountTax();

  AccountTax.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new AccountTaxTaxRule.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Tax calculation rule to apply in a state or province (USA only). */
class AccountTaxTaxRule {
  /** Country code in which tax is applicable. */
  core.String country;
  /**
   * State (or province) is which the tax is applicable, described by its
   * location id (also called criteria id).
   */
  core.String locationId;
  /**
   * Explicit tax rate in percent, represented as a floating point number
   * without the percentage character. Must not be negative.
   */
  core.String ratePercent;
  /** If true, shipping charges are also taxed. */
  core.bool shippingTaxed;
  /**
   * Whether the tax rate is taken from a global tax table or specified
   * explicitly.
   */
  core.bool useGlobalRate;

  AccountTaxTaxRule();

  AccountTaxTaxRule.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("locationId")) {
      locationId = _json["locationId"];
    }
    if (_json.containsKey("ratePercent")) {
      ratePercent = _json["ratePercent"];
    }
    if (_json.containsKey("shippingTaxed")) {
      shippingTaxed = _json["shippingTaxed"];
    }
    if (_json.containsKey("useGlobalRate")) {
      useGlobalRate = _json["useGlobalRate"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (locationId != null) {
      _json["locationId"] = locationId;
    }
    if (ratePercent != null) {
      _json["ratePercent"] = ratePercent;
    }
    if (shippingTaxed != null) {
      _json["shippingTaxed"] = shippingTaxed;
    }
    if (useGlobalRate != null) {
      _json["useGlobalRate"] = useGlobalRate;
    }
    return _json;
  }
}

class AccountUser {
  /** Whether user is an admin. */
  core.bool admin;
  /** User's email address. */
  core.String emailAddress;

  AccountUser();

  AccountUser.fromJson(core.Map _json) {
    if (_json.containsKey("admin")) {
      admin = _json["admin"];
    }
    if (_json.containsKey("emailAddress")) {
      emailAddress = _json["emailAddress"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (admin != null) {
      _json["admin"] = admin;
    }
    if (emailAddress != null) {
      _json["emailAddress"] = emailAddress;
    }
    return _json;
  }
}

class AccountsAuthInfoResponse {
  /**
   * The account identifiers corresponding to the authenticated user.
   * - For an individual account: only the merchant ID is defined
   * - For an aggregator: only the aggregator ID is defined
   * - For a subaccount of an MCA: both the merchant ID and the aggregator ID
   * are defined.
   */
  core.List<AccountIdentifier> accountIdentifiers;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accountsAuthInfoResponse".
   */
  core.String kind;

  AccountsAuthInfoResponse();

  AccountsAuthInfoResponse.fromJson(core.Map _json) {
    if (_json.containsKey("accountIdentifiers")) {
      accountIdentifiers = _json["accountIdentifiers"].map((value) => new AccountIdentifier.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountIdentifiers != null) {
      _json["accountIdentifiers"] = accountIdentifiers.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class AccountsCustomBatchRequest {
  /** The request entries to be processed in the batch. */
  core.List<AccountsCustomBatchRequestEntry> entries;

  AccountsCustomBatchRequest();

  AccountsCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new AccountsCustomBatchRequestEntry.fromJson(value)).toList();
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

/** A batch entry encoding a single non-batch accounts request. */
class AccountsCustomBatchRequestEntry {
  /**
   * The account to create or update. Only defined if the method is insert or
   * update.
   */
  Account account;
  /**
   * The ID of the account to get or delete. Only defined if the method is get
   * or delete.
   */
  core.String accountId;
  /** An entry ID, unique within the batch request. */
  core.int batchId;
  /** The ID of the managing account. */
  core.String merchantId;
  core.String method;

  AccountsCustomBatchRequestEntry();

  AccountsCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("account")) {
      account = new Account.fromJson(_json["account"]);
    }
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (account != null) {
      _json["account"] = (account).toJson();
    }
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    return _json;
  }
}

class AccountsCustomBatchResponse {
  /** The result of the execution of the batch requests. */
  core.List<AccountsCustomBatchResponseEntry> entries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accountsCustomBatchResponse".
   */
  core.String kind;

  AccountsCustomBatchResponse();

  AccountsCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new AccountsCustomBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A batch entry encoding a single non-batch accounts response. */
class AccountsCustomBatchResponseEntry {
  /**
   * The retrieved, created, or updated account. Not defined if the method was
   * delete.
   */
  Account account;
  /** The ID of the request entry this entry responds to. */
  core.int batchId;
  /** A list of errors defined if and only if the request failed. */
  Errors errors;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accountsCustomBatchResponseEntry".
   */
  core.String kind;

  AccountsCustomBatchResponseEntry();

  AccountsCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("account")) {
      account = new Account.fromJson(_json["account"]);
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (account != null) {
      _json["account"] = (account).toJson();
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class AccountsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accountsListResponse".
   */
  core.String kind;
  /** The token for the retrieval of the next page of accounts. */
  core.String nextPageToken;
  core.List<Account> resources;

  AccountsListResponse();

  AccountsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new Account.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class AccountshippingCustomBatchRequest {
  /** The request entries to be processed in the batch. */
  core.List<AccountshippingCustomBatchRequestEntry> entries;

  AccountshippingCustomBatchRequest();

  AccountshippingCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new AccountshippingCustomBatchRequestEntry.fromJson(value)).toList();
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

/** A batch entry encoding a single non-batch accountshipping request. */
class AccountshippingCustomBatchRequestEntry {
  /**
   * The ID of the account for which to get/update account shipping settings.
   */
  core.String accountId;
  /**
   * The account shipping settings to update. Only defined if the method is
   * update.
   */
  AccountShipping accountShipping;
  /** An entry ID, unique within the batch request. */
  core.int batchId;
  /** The ID of the managing account. */
  core.String merchantId;
  core.String method;

  AccountshippingCustomBatchRequestEntry();

  AccountshippingCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("accountShipping")) {
      accountShipping = new AccountShipping.fromJson(_json["accountShipping"]);
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (accountShipping != null) {
      _json["accountShipping"] = (accountShipping).toJson();
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    return _json;
  }
}

class AccountshippingCustomBatchResponse {
  /** The result of the execution of the batch requests. */
  core.List<AccountshippingCustomBatchResponseEntry> entries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accountshippingCustomBatchResponse".
   */
  core.String kind;

  AccountshippingCustomBatchResponse();

  AccountshippingCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new AccountshippingCustomBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A batch entry encoding a single non-batch accountshipping response. */
class AccountshippingCustomBatchResponseEntry {
  /** The retrieved or updated account shipping settings. */
  AccountShipping accountShipping;
  /** The ID of the request entry this entry responds to. */
  core.int batchId;
  /** A list of errors defined if and only if the request failed. */
  Errors errors;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accountshippingCustomBatchResponseEntry".
   */
  core.String kind;

  AccountshippingCustomBatchResponseEntry();

  AccountshippingCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountShipping")) {
      accountShipping = new AccountShipping.fromJson(_json["accountShipping"]);
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountShipping != null) {
      _json["accountShipping"] = (accountShipping).toJson();
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class AccountshippingListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accountshippingListResponse".
   */
  core.String kind;
  /**
   * The token for the retrieval of the next page of account shipping settings.
   */
  core.String nextPageToken;
  core.List<AccountShipping> resources;

  AccountshippingListResponse();

  AccountshippingListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new AccountShipping.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class AccountstatusesCustomBatchRequest {
  /** The request entries to be processed in the batch. */
  core.List<AccountstatusesCustomBatchRequestEntry> entries;

  AccountstatusesCustomBatchRequest();

  AccountstatusesCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new AccountstatusesCustomBatchRequestEntry.fromJson(value)).toList();
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

/** A batch entry encoding a single non-batch accountstatuses request. */
class AccountstatusesCustomBatchRequestEntry {
  /** The ID of the (sub-)account whose status to get. */
  core.String accountId;
  /** An entry ID, unique within the batch request. */
  core.int batchId;
  /** The ID of the managing account. */
  core.String merchantId;
  /** The method (get). */
  core.String method;

  AccountstatusesCustomBatchRequestEntry();

  AccountstatusesCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    return _json;
  }
}

class AccountstatusesCustomBatchResponse {
  /** The result of the execution of the batch requests. */
  core.List<AccountstatusesCustomBatchResponseEntry> entries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accountstatusesCustomBatchResponse".
   */
  core.String kind;

  AccountstatusesCustomBatchResponse();

  AccountstatusesCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new AccountstatusesCustomBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A batch entry encoding a single non-batch accountstatuses response. */
class AccountstatusesCustomBatchResponseEntry {
  /**
   * The requested account status. Defined if and only if the request was
   * successful.
   */
  AccountStatus accountStatus;
  /** The ID of the request entry this entry responds to. */
  core.int batchId;
  /** A list of errors defined if and only if the request failed. */
  Errors errors;

  AccountstatusesCustomBatchResponseEntry();

  AccountstatusesCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountStatus")) {
      accountStatus = new AccountStatus.fromJson(_json["accountStatus"]);
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountStatus != null) {
      _json["accountStatus"] = (accountStatus).toJson();
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    return _json;
  }
}

class AccountstatusesListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accountstatusesListResponse".
   */
  core.String kind;
  /** The token for the retrieval of the next page of account statuses. */
  core.String nextPageToken;
  core.List<AccountStatus> resources;

  AccountstatusesListResponse();

  AccountstatusesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new AccountStatus.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class AccounttaxCustomBatchRequest {
  /** The request entries to be processed in the batch. */
  core.List<AccounttaxCustomBatchRequestEntry> entries;

  AccounttaxCustomBatchRequest();

  AccounttaxCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new AccounttaxCustomBatchRequestEntry.fromJson(value)).toList();
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

/** A batch entry encoding a single non-batch accounttax request. */
class AccounttaxCustomBatchRequestEntry {
  /** The ID of the account for which to get/update account tax settings. */
  core.String accountId;
  /**
   * The account tax settings to update. Only defined if the method is update.
   */
  AccountTax accountTax;
  /** An entry ID, unique within the batch request. */
  core.int batchId;
  /** The ID of the managing account. */
  core.String merchantId;
  core.String method;

  AccounttaxCustomBatchRequestEntry();

  AccounttaxCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("accountTax")) {
      accountTax = new AccountTax.fromJson(_json["accountTax"]);
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (accountTax != null) {
      _json["accountTax"] = (accountTax).toJson();
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    return _json;
  }
}

class AccounttaxCustomBatchResponse {
  /** The result of the execution of the batch requests. */
  core.List<AccounttaxCustomBatchResponseEntry> entries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accounttaxCustomBatchResponse".
   */
  core.String kind;

  AccounttaxCustomBatchResponse();

  AccounttaxCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new AccounttaxCustomBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A batch entry encoding a single non-batch accounttax response. */
class AccounttaxCustomBatchResponseEntry {
  /** The retrieved or updated account tax settings. */
  AccountTax accountTax;
  /** The ID of the request entry this entry responds to. */
  core.int batchId;
  /** A list of errors defined if and only if the request failed. */
  Errors errors;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accounttaxCustomBatchResponseEntry".
   */
  core.String kind;

  AccounttaxCustomBatchResponseEntry();

  AccounttaxCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountTax")) {
      accountTax = new AccountTax.fromJson(_json["accountTax"]);
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountTax != null) {
      _json["accountTax"] = (accountTax).toJson();
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class AccounttaxListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#accounttaxListResponse".
   */
  core.String kind;
  /** The token for the retrieval of the next page of account tax settings. */
  core.String nextPageToken;
  core.List<AccountTax> resources;

  AccounttaxListResponse();

  AccounttaxListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new AccountTax.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class CarrierRate {
  /**
   * Carrier service, such as "UPS" or "Fedex". The list of supported carriers
   * can be retrieved via the getSupportedCarriers method. Required.
   */
  core.String carrierName;
  /**
   * Carrier service, such as "ground" or "2 days". The list of supported
   * services for a carrier can be retrieved via the getSupportedCarriers
   * method. Required.
   */
  core.String carrierService;
  /**
   * Additive shipping rate modifier. Can be negative. For example { "value":
   * "1", "currency" : "USD" } adds $1 to the rate, { "value": "-3", "currency"
   * : "USD" } removes $3 from the rate. Optional.
   */
  Price flatAdjustment;
  /** Name of the carrier rate. Must be unique per rate group. Required. */
  core.String name;
  /** Shipping origin for this carrier rate. Required. */
  core.String originPostalCode;
  /**
   * Multiplicative shipping rate modifier as a number in decimal notation. Can
   * be negative. For example "5.4" increases the rate by 5.4%, "-3" decreases
   * the rate by 3%. Optional.
   */
  core.String percentageAdjustment;

  CarrierRate();

  CarrierRate.fromJson(core.Map _json) {
    if (_json.containsKey("carrierName")) {
      carrierName = _json["carrierName"];
    }
    if (_json.containsKey("carrierService")) {
      carrierService = _json["carrierService"];
    }
    if (_json.containsKey("flatAdjustment")) {
      flatAdjustment = new Price.fromJson(_json["flatAdjustment"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("originPostalCode")) {
      originPostalCode = _json["originPostalCode"];
    }
    if (_json.containsKey("percentageAdjustment")) {
      percentageAdjustment = _json["percentageAdjustment"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrierName != null) {
      _json["carrierName"] = carrierName;
    }
    if (carrierService != null) {
      _json["carrierService"] = carrierService;
    }
    if (flatAdjustment != null) {
      _json["flatAdjustment"] = (flatAdjustment).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (originPostalCode != null) {
      _json["originPostalCode"] = originPostalCode;
    }
    if (percentageAdjustment != null) {
      _json["percentageAdjustment"] = percentageAdjustment;
    }
    return _json;
  }
}

class CarriersCarrier {
  /** The CLDR country code of the carrier (e.g., "US"). Always present. */
  core.String country;
  /** The name of the carrier (e.g., "UPS"). Always present. */
  core.String name;
  /**
   * A list of supported services (e.g., "ground") for that carrier. Contains at
   * least one service.
   */
  core.List<core.String> services;

  CarriersCarrier();

  CarriersCarrier.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("services")) {
      services = _json["services"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (services != null) {
      _json["services"] = services;
    }
    return _json;
  }
}

/** Datafeed data. */
class Datafeed {
  /**
   * The two-letter ISO 639-1 language in which the attributes are defined in
   * the data feed.
   */
  core.String attributeLanguage;
  /**
   * The two-letter ISO 639-1 language of the items in the feed. Must be a valid
   * language for targetCountry.
   */
  core.String contentLanguage;
  /** The type of data feed. */
  core.String contentType;
  /** Fetch schedule for the feed file. */
  DatafeedFetchSchedule fetchSchedule;
  /** The filename of the feed. All feeds must have a unique file name. */
  core.String fileName;
  /** Format of the feed file. */
  DatafeedFormat format;
  /** The ID of the data feed. */
  core.String id;
  /**
   * The list of intended destinations (corresponds to checked check boxes in
   * Merchant Center).
   */
  core.List<core.String> intendedDestinations;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#datafeed".
   */
  core.String kind;
  /** A descriptive name of the data feed. */
  core.String name;
  /**
   * The country where the items in the feed will be included in the search
   * index, represented as a CLDR territory code.
   */
  core.String targetCountry;

  Datafeed();

  Datafeed.fromJson(core.Map _json) {
    if (_json.containsKey("attributeLanguage")) {
      attributeLanguage = _json["attributeLanguage"];
    }
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("contentType")) {
      contentType = _json["contentType"];
    }
    if (_json.containsKey("fetchSchedule")) {
      fetchSchedule = new DatafeedFetchSchedule.fromJson(_json["fetchSchedule"]);
    }
    if (_json.containsKey("fileName")) {
      fileName = _json["fileName"];
    }
    if (_json.containsKey("format")) {
      format = new DatafeedFormat.fromJson(_json["format"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("intendedDestinations")) {
      intendedDestinations = _json["intendedDestinations"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (attributeLanguage != null) {
      _json["attributeLanguage"] = attributeLanguage;
    }
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (contentType != null) {
      _json["contentType"] = contentType;
    }
    if (fetchSchedule != null) {
      _json["fetchSchedule"] = (fetchSchedule).toJson();
    }
    if (fileName != null) {
      _json["fileName"] = fileName;
    }
    if (format != null) {
      _json["format"] = (format).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (intendedDestinations != null) {
      _json["intendedDestinations"] = intendedDestinations;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    return _json;
  }
}

/**
 * The required fields vary based on the frequency of fetching. For a monthly
 * fetch schedule, day_of_month and hour are required. For a weekly fetch
 * schedule, weekday and hour are required. For a daily fetch schedule, only
 * hour is required.
 */
class DatafeedFetchSchedule {
  /** The day of the month the feed file should be fetched (1-31). */
  core.int dayOfMonth;
  /**
   * The URL where the feed file can be fetched. Google Merchant Center will
   * support automatic scheduled uploads using the HTTP, HTTPS, FTP, or SFTP
   * protocols, so the value will need to be a valid link using one of those
   * four protocols.
   */
  core.String fetchUrl;
  /** The hour of the day the feed file should be fetched (0-23). */
  core.int hour;
  /**
   * The minute of the hour the feed file should be fetched (0-59). Read-only.
   */
  core.int minuteOfHour;
  /** An optional password for fetch_url. */
  core.String password;
  /**
   * Time zone used for schedule. UTC by default. E.g., "America/Los_Angeles".
   */
  core.String timeZone;
  /** An optional user name for fetch_url. */
  core.String username;
  /** The day of the week the feed file should be fetched. */
  core.String weekday;

  DatafeedFetchSchedule();

  DatafeedFetchSchedule.fromJson(core.Map _json) {
    if (_json.containsKey("dayOfMonth")) {
      dayOfMonth = _json["dayOfMonth"];
    }
    if (_json.containsKey("fetchUrl")) {
      fetchUrl = _json["fetchUrl"];
    }
    if (_json.containsKey("hour")) {
      hour = _json["hour"];
    }
    if (_json.containsKey("minuteOfHour")) {
      minuteOfHour = _json["minuteOfHour"];
    }
    if (_json.containsKey("password")) {
      password = _json["password"];
    }
    if (_json.containsKey("timeZone")) {
      timeZone = _json["timeZone"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
    if (_json.containsKey("weekday")) {
      weekday = _json["weekday"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dayOfMonth != null) {
      _json["dayOfMonth"] = dayOfMonth;
    }
    if (fetchUrl != null) {
      _json["fetchUrl"] = fetchUrl;
    }
    if (hour != null) {
      _json["hour"] = hour;
    }
    if (minuteOfHour != null) {
      _json["minuteOfHour"] = minuteOfHour;
    }
    if (password != null) {
      _json["password"] = password;
    }
    if (timeZone != null) {
      _json["timeZone"] = timeZone;
    }
    if (username != null) {
      _json["username"] = username;
    }
    if (weekday != null) {
      _json["weekday"] = weekday;
    }
    return _json;
  }
}

class DatafeedFormat {
  /**
   * Delimiter for the separation of values in a delimiter-separated values
   * feed. If not specified, the delimiter will be auto-detected. Ignored for
   * non-DSV data feeds.
   */
  core.String columnDelimiter;
  /**
   * Character encoding scheme of the data feed. If not specified, the encoding
   * will be auto-detected.
   */
  core.String fileEncoding;
  /**
   * Specifies how double quotes are interpreted. If not specified, the mode
   * will be auto-detected. Ignored for non-DSV data feeds.
   */
  core.String quotingMode;

  DatafeedFormat();

  DatafeedFormat.fromJson(core.Map _json) {
    if (_json.containsKey("columnDelimiter")) {
      columnDelimiter = _json["columnDelimiter"];
    }
    if (_json.containsKey("fileEncoding")) {
      fileEncoding = _json["fileEncoding"];
    }
    if (_json.containsKey("quotingMode")) {
      quotingMode = _json["quotingMode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnDelimiter != null) {
      _json["columnDelimiter"] = columnDelimiter;
    }
    if (fileEncoding != null) {
      _json["fileEncoding"] = fileEncoding;
    }
    if (quotingMode != null) {
      _json["quotingMode"] = quotingMode;
    }
    return _json;
  }
}

/**
 * The status of a datafeed, i.e., the result of the last retrieval of the
 * datafeed computed asynchronously when the feed processing is finished.
 */
class DatafeedStatus {
  /** The ID of the feed for which the status is reported. */
  core.String datafeedId;
  /** The list of errors occurring in the feed. */
  core.List<DatafeedStatusError> errors;
  /** The number of items in the feed that were processed. */
  core.String itemsTotal;
  /** The number of items in the feed that were valid. */
  core.String itemsValid;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#datafeedStatus".
   */
  core.String kind;
  /** The last date at which the feed was uploaded. */
  core.String lastUploadDate;
  /** The processing status of the feed. */
  core.String processingStatus;
  /** The list of errors occurring in the feed. */
  core.List<DatafeedStatusError> warnings;

  DatafeedStatus();

  DatafeedStatus.fromJson(core.Map _json) {
    if (_json.containsKey("datafeedId")) {
      datafeedId = _json["datafeedId"];
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"].map((value) => new DatafeedStatusError.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsTotal")) {
      itemsTotal = _json["itemsTotal"];
    }
    if (_json.containsKey("itemsValid")) {
      itemsValid = _json["itemsValid"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastUploadDate")) {
      lastUploadDate = _json["lastUploadDate"];
    }
    if (_json.containsKey("processingStatus")) {
      processingStatus = _json["processingStatus"];
    }
    if (_json.containsKey("warnings")) {
      warnings = _json["warnings"].map((value) => new DatafeedStatusError.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datafeedId != null) {
      _json["datafeedId"] = datafeedId;
    }
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    if (itemsTotal != null) {
      _json["itemsTotal"] = itemsTotal;
    }
    if (itemsValid != null) {
      _json["itemsValid"] = itemsValid;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastUploadDate != null) {
      _json["lastUploadDate"] = lastUploadDate;
    }
    if (processingStatus != null) {
      _json["processingStatus"] = processingStatus;
    }
    if (warnings != null) {
      _json["warnings"] = warnings.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** An error occurring in the feed, like "invalid price". */
class DatafeedStatusError {
  /** The code of the error, e.g., "validation/invalid_value". */
  core.String code;
  /** The number of occurrences of the error in the feed. */
  core.String count;
  /** A list of example occurrences of the error, grouped by product. */
  core.List<DatafeedStatusExample> examples;
  /** The error message, e.g., "Invalid price". */
  core.String message;

  DatafeedStatusError();

  DatafeedStatusError.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("examples")) {
      examples = _json["examples"].map((value) => new DatafeedStatusExample.fromJson(value)).toList();
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (code != null) {
      _json["code"] = code;
    }
    if (count != null) {
      _json["count"] = count;
    }
    if (examples != null) {
      _json["examples"] = examples.map((value) => (value).toJson()).toList();
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

/** An example occurrence for a particular error. */
class DatafeedStatusExample {
  /** The ID of the example item. */
  core.String itemId;
  /** Line number in the data feed where the example is found. */
  core.String lineNumber;
  /** The problematic value. */
  core.String value;

  DatafeedStatusExample();

  DatafeedStatusExample.fromJson(core.Map _json) {
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
    if (_json.containsKey("lineNumber")) {
      lineNumber = _json["lineNumber"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    if (lineNumber != null) {
      _json["lineNumber"] = lineNumber;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class DatafeedsCustomBatchRequest {
  /** The request entries to be processed in the batch. */
  core.List<DatafeedsCustomBatchRequestEntry> entries;

  DatafeedsCustomBatchRequest();

  DatafeedsCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new DatafeedsCustomBatchRequestEntry.fromJson(value)).toList();
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

/** A batch entry encoding a single non-batch datafeeds request. */
class DatafeedsCustomBatchRequestEntry {
  /** An entry ID, unique within the batch request. */
  core.int batchId;
  /** The data feed to insert. */
  Datafeed datafeed;
  /** The ID of the data feed to get or delete. */
  core.String datafeedId;
  /** The ID of the managing account. */
  core.String merchantId;
  core.String method;

  DatafeedsCustomBatchRequestEntry();

  DatafeedsCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("datafeed")) {
      datafeed = new Datafeed.fromJson(_json["datafeed"]);
    }
    if (_json.containsKey("datafeedId")) {
      datafeedId = _json["datafeedId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (datafeed != null) {
      _json["datafeed"] = (datafeed).toJson();
    }
    if (datafeedId != null) {
      _json["datafeedId"] = datafeedId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    return _json;
  }
}

class DatafeedsCustomBatchResponse {
  /** The result of the execution of the batch requests. */
  core.List<DatafeedsCustomBatchResponseEntry> entries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#datafeedsCustomBatchResponse".
   */
  core.String kind;

  DatafeedsCustomBatchResponse();

  DatafeedsCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new DatafeedsCustomBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A batch entry encoding a single non-batch datafeeds response. */
class DatafeedsCustomBatchResponseEntry {
  /** The ID of the request entry this entry responds to. */
  core.int batchId;
  /**
   * The requested data feed. Defined if and only if the request was successful.
   */
  Datafeed datafeed;
  /** A list of errors defined if and only if the request failed. */
  Errors errors;

  DatafeedsCustomBatchResponseEntry();

  DatafeedsCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("datafeed")) {
      datafeed = new Datafeed.fromJson(_json["datafeed"]);
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (datafeed != null) {
      _json["datafeed"] = (datafeed).toJson();
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    return _json;
  }
}

class DatafeedsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#datafeedsListResponse".
   */
  core.String kind;
  /** The token for the retrieval of the next page of datafeeds. */
  core.String nextPageToken;
  core.List<Datafeed> resources;

  DatafeedsListResponse();

  DatafeedsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new Datafeed.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class DatafeedstatusesCustomBatchRequest {
  /** The request entries to be processed in the batch. */
  core.List<DatafeedstatusesCustomBatchRequestEntry> entries;

  DatafeedstatusesCustomBatchRequest();

  DatafeedstatusesCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new DatafeedstatusesCustomBatchRequestEntry.fromJson(value)).toList();
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

/** A batch entry encoding a single non-batch datafeedstatuses request. */
class DatafeedstatusesCustomBatchRequestEntry {
  /** An entry ID, unique within the batch request. */
  core.int batchId;
  /** The ID of the data feed to get or delete. */
  core.String datafeedId;
  /** The ID of the managing account. */
  core.String merchantId;
  core.String method;

  DatafeedstatusesCustomBatchRequestEntry();

  DatafeedstatusesCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("datafeedId")) {
      datafeedId = _json["datafeedId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (datafeedId != null) {
      _json["datafeedId"] = datafeedId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    return _json;
  }
}

class DatafeedstatusesCustomBatchResponse {
  /** The result of the execution of the batch requests. */
  core.List<DatafeedstatusesCustomBatchResponseEntry> entries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#datafeedstatusesCustomBatchResponse".
   */
  core.String kind;

  DatafeedstatusesCustomBatchResponse();

  DatafeedstatusesCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new DatafeedstatusesCustomBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A batch entry encoding a single non-batch datafeedstatuses response. */
class DatafeedstatusesCustomBatchResponseEntry {
  /** The ID of the request entry this entry responds to. */
  core.int batchId;
  /**
   * The requested data feed status. Defined if and only if the request was
   * successful.
   */
  DatafeedStatus datafeedStatus;
  /** A list of errors defined if and only if the request failed. */
  Errors errors;

  DatafeedstatusesCustomBatchResponseEntry();

  DatafeedstatusesCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("datafeedStatus")) {
      datafeedStatus = new DatafeedStatus.fromJson(_json["datafeedStatus"]);
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (datafeedStatus != null) {
      _json["datafeedStatus"] = (datafeedStatus).toJson();
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    return _json;
  }
}

class DatafeedstatusesListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#datafeedstatusesListResponse".
   */
  core.String kind;
  /** The token for the retrieval of the next page of datafeed statuses. */
  core.String nextPageToken;
  core.List<DatafeedStatus> resources;

  DatafeedstatusesListResponse();

  DatafeedstatusesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new DatafeedStatus.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class DeliveryTime {
  /**
   * Maximum number of business days that is spent in transit. 0 means same day
   * delivery, 1 means next day delivery. Must be greater than or equal to
   * minTransitTimeInDays. Required.
   */
  core.int maxTransitTimeInDays;
  /**
   * Minimum number of business days that is spent in transit. 0 means same day
   * delivery, 1 means next day delivery. Required.
   */
  core.int minTransitTimeInDays;

  DeliveryTime();

  DeliveryTime.fromJson(core.Map _json) {
    if (_json.containsKey("maxTransitTimeInDays")) {
      maxTransitTimeInDays = _json["maxTransitTimeInDays"];
    }
    if (_json.containsKey("minTransitTimeInDays")) {
      minTransitTimeInDays = _json["minTransitTimeInDays"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (maxTransitTimeInDays != null) {
      _json["maxTransitTimeInDays"] = maxTransitTimeInDays;
    }
    if (minTransitTimeInDays != null) {
      _json["minTransitTimeInDays"] = minTransitTimeInDays;
    }
    return _json;
  }
}

/** An error returned by the API. */
class Error {
  /** The domain of the error. */
  core.String domain;
  /** A description of the error. */
  core.String message;
  /** The error code. */
  core.String reason;

  Error();

  Error.fromJson(core.Map _json) {
    if (_json.containsKey("domain")) {
      domain = _json["domain"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
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
    if (message != null) {
      _json["message"] = message;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    return _json;
  }
}

/** A list of errors returned by a failed batch entry. */
class Errors {
  /** The HTTP status of the first error in errors. */
  core.int code;
  /** A list of errors. */
  core.List<Error> errors;
  /** The message of the first error in errors. */
  core.String message;

  Errors();

  Errors.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"].map((value) => new Error.fromJson(value)).toList();
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (code != null) {
      _json["code"] = code;
    }
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

/**
 * A non-empty list of row or column headers for a table. Exactly one of prices,
 * weights, numItems, postalCodeGroupNames, or locations must be set.
 */
class Headers {
  /**
   * A list of location ID sets. Must be non-empty. Can only be set if all other
   * fields are not set.
   */
  core.List<LocationIdSet> locations;
  /**
   * A list of inclusive number of items upper bounds. The last value can be
   * "infinity". For example ["10", "50", "infinity"] represents the headers "<=
   * 10 items", " 50 items". Must be non-empty. Can only be set if all other
   * fields are not set.
   */
  core.List<core.String> numberOfItems;
  /**
   * A list of postal group names. The last value can be "all other locations".
   * Example: ["zone 1", "zone 2", "all other locations"]. The referred postal
   * code groups must match the delivery country of the service. Must be
   * non-empty. Can only be set if all other fields are not set.
   */
  core.List<core.String> postalCodeGroupNames;
  /**
   * be "infinity". For example [{"value": "10", "currency": "USD"}, {"value":
   * "500", "currency": "USD"}, {"value": "infinity", "currency": "USD"}]
   * represents the headers "<= $10", " $500". All prices within a service must
   * have the same currency. Must be non-empty. Can only be set if all other
   * fields are not set.
   */
  core.List<Price> prices;
  /**
   * be "infinity". For example [{"value": "10", "unit": "kg"}, {"value": "50",
   * "unit": "kg"}, {"value": "infinity", "unit": "kg"}] represents the headers
   * "<= 10kg", " 50kg". All weights within a service must have the same unit.
   * Must be non-empty. Can only be set if all other fields are not set.
   */
  core.List<Weight> weights;

  Headers();

  Headers.fromJson(core.Map _json) {
    if (_json.containsKey("locations")) {
      locations = _json["locations"].map((value) => new LocationIdSet.fromJson(value)).toList();
    }
    if (_json.containsKey("numberOfItems")) {
      numberOfItems = _json["numberOfItems"];
    }
    if (_json.containsKey("postalCodeGroupNames")) {
      postalCodeGroupNames = _json["postalCodeGroupNames"];
    }
    if (_json.containsKey("prices")) {
      prices = _json["prices"].map((value) => new Price.fromJson(value)).toList();
    }
    if (_json.containsKey("weights")) {
      weights = _json["weights"].map((value) => new Weight.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (locations != null) {
      _json["locations"] = locations.map((value) => (value).toJson()).toList();
    }
    if (numberOfItems != null) {
      _json["numberOfItems"] = numberOfItems;
    }
    if (postalCodeGroupNames != null) {
      _json["postalCodeGroupNames"] = postalCodeGroupNames;
    }
    if (prices != null) {
      _json["prices"] = prices.map((value) => (value).toJson()).toList();
    }
    if (weights != null) {
      _json["weights"] = weights.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Installment {
  /** The amount the buyer has to pay per month. */
  Price amount;
  /** The number of installments the buyer has to pay. */
  core.String months;

  Installment();

  Installment.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("months")) {
      months = _json["months"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (months != null) {
      _json["months"] = months;
    }
    return _json;
  }
}

class Inventory {
  /** The availability of the product. */
  core.String availability;
  /** Number and amount of installments to pay for an item. Brazil only. */
  Installment installment;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#inventory".
   */
  core.String kind;
  /**
   * Loyalty points that users receive after purchasing the item. Japan only.
   */
  LoyaltyPoints loyaltyPoints;
  /**
   * Store pickup information. Only supported for local inventory. Not setting
   * pickup means "don't update" while setting it to the empty value ({} in
   * JSON) means "delete". Otherwise, pickupMethod and pickupSla must be set
   * together, unless pickupMethod is "not supported".
   */
  InventoryPickup pickup;
  /** The price of the product. */
  Price price;
  /**
   * The quantity of the product. Must be equal to or greater than zero.
   * Supported only for local products.
   */
  core.int quantity;
  /**
   * The sale price of the product. Mandatory if sale_price_effective_date is
   * defined.
   */
  Price salePrice;
  /**
   * A date range represented by a pair of ISO 8601 dates separated by a space,
   * comma, or slash. Both dates might be specified as 'null' if undecided.
   */
  core.String salePriceEffectiveDate;
  /**
   * The quantity of the product that is reserved for sell-on-google ads.
   * Supported only for online products.
   */
  core.int sellOnGoogleQuantity;

  Inventory();

  Inventory.fromJson(core.Map _json) {
    if (_json.containsKey("availability")) {
      availability = _json["availability"];
    }
    if (_json.containsKey("installment")) {
      installment = new Installment.fromJson(_json["installment"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("loyaltyPoints")) {
      loyaltyPoints = new LoyaltyPoints.fromJson(_json["loyaltyPoints"]);
    }
    if (_json.containsKey("pickup")) {
      pickup = new InventoryPickup.fromJson(_json["pickup"]);
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("salePrice")) {
      salePrice = new Price.fromJson(_json["salePrice"]);
    }
    if (_json.containsKey("salePriceEffectiveDate")) {
      salePriceEffectiveDate = _json["salePriceEffectiveDate"];
    }
    if (_json.containsKey("sellOnGoogleQuantity")) {
      sellOnGoogleQuantity = _json["sellOnGoogleQuantity"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (availability != null) {
      _json["availability"] = availability;
    }
    if (installment != null) {
      _json["installment"] = (installment).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (loyaltyPoints != null) {
      _json["loyaltyPoints"] = (loyaltyPoints).toJson();
    }
    if (pickup != null) {
      _json["pickup"] = (pickup).toJson();
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (salePrice != null) {
      _json["salePrice"] = (salePrice).toJson();
    }
    if (salePriceEffectiveDate != null) {
      _json["salePriceEffectiveDate"] = salePriceEffectiveDate;
    }
    if (sellOnGoogleQuantity != null) {
      _json["sellOnGoogleQuantity"] = sellOnGoogleQuantity;
    }
    return _json;
  }
}

class InventoryCustomBatchRequest {
  /** The request entries to be processed in the batch. */
  core.List<InventoryCustomBatchRequestEntry> entries;

  InventoryCustomBatchRequest();

  InventoryCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new InventoryCustomBatchRequestEntry.fromJson(value)).toList();
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

/** A batch entry encoding a single non-batch inventory request. */
class InventoryCustomBatchRequestEntry {
  /** An entry ID, unique within the batch request. */
  core.int batchId;
  /** Price and availability of the product. */
  Inventory inventory;
  /** The ID of the managing account. */
  core.String merchantId;
  /** The ID of the product for which to update price and availability. */
  core.String productId;
  /**
   * The code of the store for which to update price and availability. Use
   * online to update price and availability of an online product.
   */
  core.String storeCode;

  InventoryCustomBatchRequestEntry();

  InventoryCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("inventory")) {
      inventory = new Inventory.fromJson(_json["inventory"]);
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("storeCode")) {
      storeCode = _json["storeCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (inventory != null) {
      _json["inventory"] = (inventory).toJson();
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (storeCode != null) {
      _json["storeCode"] = storeCode;
    }
    return _json;
  }
}

class InventoryCustomBatchResponse {
  /** The result of the execution of the batch requests. */
  core.List<InventoryCustomBatchResponseEntry> entries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#inventoryCustomBatchResponse".
   */
  core.String kind;

  InventoryCustomBatchResponse();

  InventoryCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new InventoryCustomBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A batch entry encoding a single non-batch inventory response. */
class InventoryCustomBatchResponseEntry {
  /** The ID of the request entry this entry responds to. */
  core.int batchId;
  /** A list of errors defined if and only if the request failed. */
  Errors errors;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#inventoryCustomBatchResponseEntry".
   */
  core.String kind;

  InventoryCustomBatchResponseEntry();

  InventoryCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class InventoryPickup {
  /**
   * Whether store pickup is available for this offer and whether the pickup
   * option should be shown as buy, reserve, or not supported. Only supported
   * for local inventory. Unless the value is "not supported", must be submitted
   * together with pickupSla.
   */
  core.String pickupMethod;
  /**
   * The expected date that an order will be ready for pickup, relative to when
   * the order is placed. Only supported for local inventory. Must be submitted
   * together with pickupMethod.
   */
  core.String pickupSla;

  InventoryPickup();

  InventoryPickup.fromJson(core.Map _json) {
    if (_json.containsKey("pickupMethod")) {
      pickupMethod = _json["pickupMethod"];
    }
    if (_json.containsKey("pickupSla")) {
      pickupSla = _json["pickupSla"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (pickupMethod != null) {
      _json["pickupMethod"] = pickupMethod;
    }
    if (pickupSla != null) {
      _json["pickupSla"] = pickupSla;
    }
    return _json;
  }
}

class InventorySetRequest {
  /** The availability of the product. */
  core.String availability;
  /** Number and amount of installments to pay for an item. Brazil only. */
  Installment installment;
  /**
   * Loyalty points that users receive after purchasing the item. Japan only.
   */
  LoyaltyPoints loyaltyPoints;
  /**
   * Store pickup information. Only supported for local inventory. Not setting
   * pickup means "don't update" while setting it to the empty value ({} in
   * JSON) means "delete". Otherwise, pickupMethod and pickupSla must be set
   * together, unless pickupMethod is "not supported".
   */
  InventoryPickup pickup;
  /** The price of the product. */
  Price price;
  /**
   * The quantity of the product. Must be equal to or greater than zero.
   * Supported only for local products.
   */
  core.int quantity;
  /**
   * The sale price of the product. Mandatory if sale_price_effective_date is
   * defined.
   */
  Price salePrice;
  /**
   * A date range represented by a pair of ISO 8601 dates separated by a space,
   * comma, or slash. Both dates might be specified as 'null' if undecided.
   */
  core.String salePriceEffectiveDate;
  /**
   * The quantity of the product that is reserved for sell-on-google ads.
   * Supported only for online products.
   */
  core.int sellOnGoogleQuantity;

  InventorySetRequest();

  InventorySetRequest.fromJson(core.Map _json) {
    if (_json.containsKey("availability")) {
      availability = _json["availability"];
    }
    if (_json.containsKey("installment")) {
      installment = new Installment.fromJson(_json["installment"]);
    }
    if (_json.containsKey("loyaltyPoints")) {
      loyaltyPoints = new LoyaltyPoints.fromJson(_json["loyaltyPoints"]);
    }
    if (_json.containsKey("pickup")) {
      pickup = new InventoryPickup.fromJson(_json["pickup"]);
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("salePrice")) {
      salePrice = new Price.fromJson(_json["salePrice"]);
    }
    if (_json.containsKey("salePriceEffectiveDate")) {
      salePriceEffectiveDate = _json["salePriceEffectiveDate"];
    }
    if (_json.containsKey("sellOnGoogleQuantity")) {
      sellOnGoogleQuantity = _json["sellOnGoogleQuantity"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (availability != null) {
      _json["availability"] = availability;
    }
    if (installment != null) {
      _json["installment"] = (installment).toJson();
    }
    if (loyaltyPoints != null) {
      _json["loyaltyPoints"] = (loyaltyPoints).toJson();
    }
    if (pickup != null) {
      _json["pickup"] = (pickup).toJson();
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (salePrice != null) {
      _json["salePrice"] = (salePrice).toJson();
    }
    if (salePriceEffectiveDate != null) {
      _json["salePriceEffectiveDate"] = salePriceEffectiveDate;
    }
    if (sellOnGoogleQuantity != null) {
      _json["sellOnGoogleQuantity"] = sellOnGoogleQuantity;
    }
    return _json;
  }
}

class InventorySetResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#inventorySetResponse".
   */
  core.String kind;

  InventorySetResponse();

  InventorySetResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class LocationIdSet {
  /**
   * A non-empty list of location IDs. They must all be of the same location
   * type (e.g., state).
   */
  core.List<core.String> locationIds;

  LocationIdSet();

  LocationIdSet.fromJson(core.Map _json) {
    if (_json.containsKey("locationIds")) {
      locationIds = _json["locationIds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (locationIds != null) {
      _json["locationIds"] = locationIds;
    }
    return _json;
  }
}

class LoyaltyPoints {
  /**
   * Name of loyalty points program. It is recommended to limit the name to 12
   * full-width characters or 24 Roman characters.
   */
  core.String name;
  /** The retailer's loyalty points in absolute value. */
  core.String pointsValue;
  /**
   * The ratio of a point when converted to currency. Google assumes currency
   * based on Merchant Center settings. If ratio is left out, it defaults to
   * 1.0.
   */
  core.double ratio;

  LoyaltyPoints();

  LoyaltyPoints.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("pointsValue")) {
      pointsValue = _json["pointsValue"];
    }
    if (_json.containsKey("ratio")) {
      ratio = _json["ratio"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (pointsValue != null) {
      _json["pointsValue"] = pointsValue;
    }
    if (ratio != null) {
      _json["ratio"] = ratio;
    }
    return _json;
  }
}

class Order {
  /** Whether the order was acknowledged. */
  core.bool acknowledged;
  /** The channel type of the order: "purchaseOnGoogle" or "googleExpress". */
  core.String channelType;
  /** The details of the customer who placed the order. */
  OrderCustomer customer;
  /** The details for the delivery. */
  OrderDeliveryDetails deliveryDetails;
  /** The REST id of the order. Globally unique. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#order".
   */
  core.String kind;
  /** Line items that are ordered. */
  core.List<OrderLineItem> lineItems;
  core.String merchantId;
  /** Merchant-provided id of the order. */
  core.String merchantOrderId;
  /**
   * The net amount for the order. For example, if an order was originally for a
   * grand total of $100 and a refund was issued for $20, the net amount will be
   * $80.
   */
  Price netAmount;
  /** The details of the payment method. */
  OrderPaymentMethod paymentMethod;
  /** The status of the payment. */
  core.String paymentStatus;
  /** The date when the order was placed, in ISO 8601 format. */
  core.String placedDate;
  /**
   * The details of the merchant provided promotions applied to the order. More
   * details about the program are  here.
   */
  core.List<OrderPromotion> promotions;
  /** Refunds for the order. */
  core.List<OrderRefund> refunds;
  /** Shipments of the order. */
  core.List<OrderShipment> shipments;
  /** The total cost of shipping for all items. */
  Price shippingCost;
  /** The tax for the total shipping cost. */
  Price shippingCostTax;
  /** The requested shipping option. */
  core.String shippingOption;
  /** The status of the order. */
  core.String status;

  Order();

  Order.fromJson(core.Map _json) {
    if (_json.containsKey("acknowledged")) {
      acknowledged = _json["acknowledged"];
    }
    if (_json.containsKey("channelType")) {
      channelType = _json["channelType"];
    }
    if (_json.containsKey("customer")) {
      customer = new OrderCustomer.fromJson(_json["customer"]);
    }
    if (_json.containsKey("deliveryDetails")) {
      deliveryDetails = new OrderDeliveryDetails.fromJson(_json["deliveryDetails"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"].map((value) => new OrderLineItem.fromJson(value)).toList();
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("merchantOrderId")) {
      merchantOrderId = _json["merchantOrderId"];
    }
    if (_json.containsKey("netAmount")) {
      netAmount = new Price.fromJson(_json["netAmount"]);
    }
    if (_json.containsKey("paymentMethod")) {
      paymentMethod = new OrderPaymentMethod.fromJson(_json["paymentMethod"]);
    }
    if (_json.containsKey("paymentStatus")) {
      paymentStatus = _json["paymentStatus"];
    }
    if (_json.containsKey("placedDate")) {
      placedDate = _json["placedDate"];
    }
    if (_json.containsKey("promotions")) {
      promotions = _json["promotions"].map((value) => new OrderPromotion.fromJson(value)).toList();
    }
    if (_json.containsKey("refunds")) {
      refunds = _json["refunds"].map((value) => new OrderRefund.fromJson(value)).toList();
    }
    if (_json.containsKey("shipments")) {
      shipments = _json["shipments"].map((value) => new OrderShipment.fromJson(value)).toList();
    }
    if (_json.containsKey("shippingCost")) {
      shippingCost = new Price.fromJson(_json["shippingCost"]);
    }
    if (_json.containsKey("shippingCostTax")) {
      shippingCostTax = new Price.fromJson(_json["shippingCostTax"]);
    }
    if (_json.containsKey("shippingOption")) {
      shippingOption = _json["shippingOption"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (acknowledged != null) {
      _json["acknowledged"] = acknowledged;
    }
    if (channelType != null) {
      _json["channelType"] = channelType;
    }
    if (customer != null) {
      _json["customer"] = (customer).toJson();
    }
    if (deliveryDetails != null) {
      _json["deliveryDetails"] = (deliveryDetails).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (merchantOrderId != null) {
      _json["merchantOrderId"] = merchantOrderId;
    }
    if (netAmount != null) {
      _json["netAmount"] = (netAmount).toJson();
    }
    if (paymentMethod != null) {
      _json["paymentMethod"] = (paymentMethod).toJson();
    }
    if (paymentStatus != null) {
      _json["paymentStatus"] = paymentStatus;
    }
    if (placedDate != null) {
      _json["placedDate"] = placedDate;
    }
    if (promotions != null) {
      _json["promotions"] = promotions.map((value) => (value).toJson()).toList();
    }
    if (refunds != null) {
      _json["refunds"] = refunds.map((value) => (value).toJson()).toList();
    }
    if (shipments != null) {
      _json["shipments"] = shipments.map((value) => (value).toJson()).toList();
    }
    if (shippingCost != null) {
      _json["shippingCost"] = (shippingCost).toJson();
    }
    if (shippingCostTax != null) {
      _json["shippingCostTax"] = (shippingCostTax).toJson();
    }
    if (shippingOption != null) {
      _json["shippingOption"] = shippingOption;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

class OrderAddress {
  /** CLDR country code (e.g. "US"). */
  core.String country;
  /**
   * Strings representing the lines of the printed label for mailing the order,
   * for example:
   * John Smith
   * 1600 Amphitheatre Parkway
   * Mountain View, CA, 94043
   * United States
   */
  core.List<core.String> fullAddress;
  /** Whether the address is a post office box. */
  core.bool isPostOfficeBox;
  /**
   * City, town or commune. May also include dependent localities or
   * sublocalities (e.g. neighborhoods or suburbs).
   */
  core.String locality;
  /** Postal Code or ZIP (e.g. "94043"). */
  core.String postalCode;
  /** Name of the recipient. */
  core.String recipientName;
  /** Top-level administrative subdivision of the country (e.g. "CA"). */
  core.String region;
  /** Street-level part of the address. */
  core.List<core.String> streetAddress;

  OrderAddress();

  OrderAddress.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("fullAddress")) {
      fullAddress = _json["fullAddress"];
    }
    if (_json.containsKey("isPostOfficeBox")) {
      isPostOfficeBox = _json["isPostOfficeBox"];
    }
    if (_json.containsKey("locality")) {
      locality = _json["locality"];
    }
    if (_json.containsKey("postalCode")) {
      postalCode = _json["postalCode"];
    }
    if (_json.containsKey("recipientName")) {
      recipientName = _json["recipientName"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("streetAddress")) {
      streetAddress = _json["streetAddress"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (fullAddress != null) {
      _json["fullAddress"] = fullAddress;
    }
    if (isPostOfficeBox != null) {
      _json["isPostOfficeBox"] = isPostOfficeBox;
    }
    if (locality != null) {
      _json["locality"] = locality;
    }
    if (postalCode != null) {
      _json["postalCode"] = postalCode;
    }
    if (recipientName != null) {
      _json["recipientName"] = recipientName;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (streetAddress != null) {
      _json["streetAddress"] = streetAddress;
    }
    return _json;
  }
}

class OrderCancellation {
  /** The actor that created the cancellation. */
  core.String actor;
  /** Date on which the cancellation has been created, in ISO 8601 format. */
  core.String creationDate;
  /** The quantity that was canceled. */
  core.int quantity;
  /**
   * The reason for the cancellation. Orders that are cancelled with a
   * noInventory reason will lead to the removal of the product from POG until
   * you make an update to that product. This will not affect your Shopping ads.
   */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrderCancellation();

  OrderCancellation.fromJson(core.Map _json) {
    if (_json.containsKey("actor")) {
      actor = _json["actor"];
    }
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (actor != null) {
      _json["actor"] = actor;
    }
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrderCustomer {
  /** Email address of the customer. */
  core.String email;
  /**
   * If set, this indicates the user explicitly chose to opt in or out of
   * providing marketing rights to the merchant. If unset, this indicates the
   * user has already made this choice in a previous purchase, and was thus not
   * shown the marketing right opt in/out checkbox during the checkout flow.
   */
  core.bool explicitMarketingPreference;
  /** Full name of the customer. */
  core.String fullName;

  OrderCustomer();

  OrderCustomer.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("explicitMarketingPreference")) {
      explicitMarketingPreference = _json["explicitMarketingPreference"];
    }
    if (_json.containsKey("fullName")) {
      fullName = _json["fullName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (email != null) {
      _json["email"] = email;
    }
    if (explicitMarketingPreference != null) {
      _json["explicitMarketingPreference"] = explicitMarketingPreference;
    }
    if (fullName != null) {
      _json["fullName"] = fullName;
    }
    return _json;
  }
}

class OrderDeliveryDetails {
  /** The delivery address */
  OrderAddress address;
  /** The phone number of the person receiving the delivery. */
  core.String phoneNumber;

  OrderDeliveryDetails();

  OrderDeliveryDetails.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = new OrderAddress.fromJson(_json["address"]);
    }
    if (_json.containsKey("phoneNumber")) {
      phoneNumber = _json["phoneNumber"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (address != null) {
      _json["address"] = (address).toJson();
    }
    if (phoneNumber != null) {
      _json["phoneNumber"] = phoneNumber;
    }
    return _json;
  }
}

class OrderLineItem {
  /** Cancellations of the line item. */
  core.List<OrderCancellation> cancellations;
  /** The id of the line item. */
  core.String id;
  /**
   * Total price for the line item. For example, if two items for $10 are
   * purchased, the total price will be $20.
   */
  Price price;
  /** Product data from the time of the order placement. */
  OrderLineItemProduct product;
  /** Number of items canceled. */
  core.int quantityCanceled;
  /** Number of items delivered. */
  core.int quantityDelivered;
  /** Number of items ordered. */
  core.int quantityOrdered;
  /** Number of items pending. */
  core.int quantityPending;
  /** Number of items returned. */
  core.int quantityReturned;
  /** Number of items shipped. */
  core.int quantityShipped;
  /** Details of the return policy for the line item. */
  OrderLineItemReturnInfo returnInfo;
  /** Returns of the line item. */
  core.List<OrderReturn> returns;
  /** Details of the requested shipping for the line item. */
  OrderLineItemShippingDetails shippingDetails;
  /**
   * Total tax amount for the line item. For example, if two items are
   * purchased, and each have a cost tax of $2, the total tax amount will be $4.
   */
  Price tax;

  OrderLineItem();

  OrderLineItem.fromJson(core.Map _json) {
    if (_json.containsKey("cancellations")) {
      cancellations = _json["cancellations"].map((value) => new OrderCancellation.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("product")) {
      product = new OrderLineItemProduct.fromJson(_json["product"]);
    }
    if (_json.containsKey("quantityCanceled")) {
      quantityCanceled = _json["quantityCanceled"];
    }
    if (_json.containsKey("quantityDelivered")) {
      quantityDelivered = _json["quantityDelivered"];
    }
    if (_json.containsKey("quantityOrdered")) {
      quantityOrdered = _json["quantityOrdered"];
    }
    if (_json.containsKey("quantityPending")) {
      quantityPending = _json["quantityPending"];
    }
    if (_json.containsKey("quantityReturned")) {
      quantityReturned = _json["quantityReturned"];
    }
    if (_json.containsKey("quantityShipped")) {
      quantityShipped = _json["quantityShipped"];
    }
    if (_json.containsKey("returnInfo")) {
      returnInfo = new OrderLineItemReturnInfo.fromJson(_json["returnInfo"]);
    }
    if (_json.containsKey("returns")) {
      returns = _json["returns"].map((value) => new OrderReturn.fromJson(value)).toList();
    }
    if (_json.containsKey("shippingDetails")) {
      shippingDetails = new OrderLineItemShippingDetails.fromJson(_json["shippingDetails"]);
    }
    if (_json.containsKey("tax")) {
      tax = new Price.fromJson(_json["tax"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cancellations != null) {
      _json["cancellations"] = cancellations.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (product != null) {
      _json["product"] = (product).toJson();
    }
    if (quantityCanceled != null) {
      _json["quantityCanceled"] = quantityCanceled;
    }
    if (quantityDelivered != null) {
      _json["quantityDelivered"] = quantityDelivered;
    }
    if (quantityOrdered != null) {
      _json["quantityOrdered"] = quantityOrdered;
    }
    if (quantityPending != null) {
      _json["quantityPending"] = quantityPending;
    }
    if (quantityReturned != null) {
      _json["quantityReturned"] = quantityReturned;
    }
    if (quantityShipped != null) {
      _json["quantityShipped"] = quantityShipped;
    }
    if (returnInfo != null) {
      _json["returnInfo"] = (returnInfo).toJson();
    }
    if (returns != null) {
      _json["returns"] = returns.map((value) => (value).toJson()).toList();
    }
    if (shippingDetails != null) {
      _json["shippingDetails"] = (shippingDetails).toJson();
    }
    if (tax != null) {
      _json["tax"] = (tax).toJson();
    }
    return _json;
  }
}

class OrderLineItemProduct {
  /** Brand of the item. */
  core.String brand;
  /** The item's channel (online or local). */
  core.String channel;
  /** Condition or state of the item. */
  core.String condition;
  /** The two-letter ISO 639-1 language code for the item. */
  core.String contentLanguage;
  /** Global Trade Item Number (GTIN) of the item. */
  core.String gtin;
  /** The REST id of the product. */
  core.String id;
  /** URL of an image of the item. */
  core.String imageLink;
  /** Shared identifier for all variants of the same product. */
  core.String itemGroupId;
  /** Manufacturer Part Number (MPN) of the item. */
  core.String mpn;
  /** An identifier of the item. */
  core.String offerId;
  /** Price of the item. */
  Price price;
  /** URL to the cached image shown to the user when order was placed. */
  core.String shownImage;
  /** The CLDR territory code of the target country of the product. */
  core.String targetCountry;
  /** The title of the product. */
  core.String title;
  /**
   * Variant attributes for the item. These are dimensions of the product, such
   * as color, gender, material, pattern, and size. You can find a comprehensive
   * list of variant attributes here.
   */
  core.List<OrderLineItemProductVariantAttribute> variantAttributes;

  OrderLineItemProduct();

  OrderLineItemProduct.fromJson(core.Map _json) {
    if (_json.containsKey("brand")) {
      brand = _json["brand"];
    }
    if (_json.containsKey("channel")) {
      channel = _json["channel"];
    }
    if (_json.containsKey("condition")) {
      condition = _json["condition"];
    }
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("imageLink")) {
      imageLink = _json["imageLink"];
    }
    if (_json.containsKey("itemGroupId")) {
      itemGroupId = _json["itemGroupId"];
    }
    if (_json.containsKey("mpn")) {
      mpn = _json["mpn"];
    }
    if (_json.containsKey("offerId")) {
      offerId = _json["offerId"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("shownImage")) {
      shownImage = _json["shownImage"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("variantAttributes")) {
      variantAttributes = _json["variantAttributes"].map((value) => new OrderLineItemProductVariantAttribute.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (brand != null) {
      _json["brand"] = brand;
    }
    if (channel != null) {
      _json["channel"] = channel;
    }
    if (condition != null) {
      _json["condition"] = condition;
    }
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (imageLink != null) {
      _json["imageLink"] = imageLink;
    }
    if (itemGroupId != null) {
      _json["itemGroupId"] = itemGroupId;
    }
    if (mpn != null) {
      _json["mpn"] = mpn;
    }
    if (offerId != null) {
      _json["offerId"] = offerId;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (shownImage != null) {
      _json["shownImage"] = shownImage;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (variantAttributes != null) {
      _json["variantAttributes"] = variantAttributes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OrderLineItemProductVariantAttribute {
  /** The dimension of the variant. */
  core.String dimension;
  /** The value for the dimension. */
  core.String value;

  OrderLineItemProductVariantAttribute();

  OrderLineItemProductVariantAttribute.fromJson(core.Map _json) {
    if (_json.containsKey("dimension")) {
      dimension = _json["dimension"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimension != null) {
      _json["dimension"] = dimension;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class OrderLineItemReturnInfo {
  /** How many days later the item can be returned. */
  core.int daysToReturn;
  /** Whether the item is returnable. */
  core.bool isReturnable;
  /** URL of the item return policy. */
  core.String policyUrl;

  OrderLineItemReturnInfo();

  OrderLineItemReturnInfo.fromJson(core.Map _json) {
    if (_json.containsKey("daysToReturn")) {
      daysToReturn = _json["daysToReturn"];
    }
    if (_json.containsKey("isReturnable")) {
      isReturnable = _json["isReturnable"];
    }
    if (_json.containsKey("policyUrl")) {
      policyUrl = _json["policyUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (daysToReturn != null) {
      _json["daysToReturn"] = daysToReturn;
    }
    if (isReturnable != null) {
      _json["isReturnable"] = isReturnable;
    }
    if (policyUrl != null) {
      _json["policyUrl"] = policyUrl;
    }
    return _json;
  }
}

class OrderLineItemShippingDetails {
  /** The delivery by date, in ISO 8601 format. */
  core.String deliverByDate;
  /** Details of the shipping method. */
  OrderLineItemShippingDetailsMethod method;
  /** The ship by date, in ISO 8601 format. */
  core.String shipByDate;

  OrderLineItemShippingDetails();

  OrderLineItemShippingDetails.fromJson(core.Map _json) {
    if (_json.containsKey("deliverByDate")) {
      deliverByDate = _json["deliverByDate"];
    }
    if (_json.containsKey("method")) {
      method = new OrderLineItemShippingDetailsMethod.fromJson(_json["method"]);
    }
    if (_json.containsKey("shipByDate")) {
      shipByDate = _json["shipByDate"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deliverByDate != null) {
      _json["deliverByDate"] = deliverByDate;
    }
    if (method != null) {
      _json["method"] = (method).toJson();
    }
    if (shipByDate != null) {
      _json["shipByDate"] = shipByDate;
    }
    return _json;
  }
}

class OrderLineItemShippingDetailsMethod {
  /** The carrier for the shipping. Optional. */
  core.String carrier;
  /** Maximum transit time. */
  core.int maxDaysInTransit;
  /** The name of the shipping method. */
  core.String methodName;
  /** Minimum transit time. */
  core.int minDaysInTransit;

  OrderLineItemShippingDetailsMethod();

  OrderLineItemShippingDetailsMethod.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("maxDaysInTransit")) {
      maxDaysInTransit = _json["maxDaysInTransit"];
    }
    if (_json.containsKey("methodName")) {
      methodName = _json["methodName"];
    }
    if (_json.containsKey("minDaysInTransit")) {
      minDaysInTransit = _json["minDaysInTransit"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (maxDaysInTransit != null) {
      _json["maxDaysInTransit"] = maxDaysInTransit;
    }
    if (methodName != null) {
      _json["methodName"] = methodName;
    }
    if (minDaysInTransit != null) {
      _json["minDaysInTransit"] = minDaysInTransit;
    }
    return _json;
  }
}

class OrderPaymentMethod {
  /** The billing address. */
  OrderAddress billingAddress;
  /** The card expiration month (January = 1, February = 2 etc.). */
  core.int expirationMonth;
  /** The card expiration year (4-digit, e.g. 2015). */
  core.int expirationYear;
  /** The last four digits of the card number. */
  core.String lastFourDigits;
  /** The billing phone number. */
  core.String phoneNumber;
  /** The type of instrument (VISA, Mastercard, etc). */
  core.String type;

  OrderPaymentMethod();

  OrderPaymentMethod.fromJson(core.Map _json) {
    if (_json.containsKey("billingAddress")) {
      billingAddress = new OrderAddress.fromJson(_json["billingAddress"]);
    }
    if (_json.containsKey("expirationMonth")) {
      expirationMonth = _json["expirationMonth"];
    }
    if (_json.containsKey("expirationYear")) {
      expirationYear = _json["expirationYear"];
    }
    if (_json.containsKey("lastFourDigits")) {
      lastFourDigits = _json["lastFourDigits"];
    }
    if (_json.containsKey("phoneNumber")) {
      phoneNumber = _json["phoneNumber"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (billingAddress != null) {
      _json["billingAddress"] = (billingAddress).toJson();
    }
    if (expirationMonth != null) {
      _json["expirationMonth"] = expirationMonth;
    }
    if (expirationYear != null) {
      _json["expirationYear"] = expirationYear;
    }
    if (lastFourDigits != null) {
      _json["lastFourDigits"] = lastFourDigits;
    }
    if (phoneNumber != null) {
      _json["phoneNumber"] = phoneNumber;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class OrderPromotion {
  core.List<OrderPromotionBenefit> benefits;
  /**
   * The date and time frame when the promotion is active and ready for
   * validation review. Note that the promotion live time may be delayed for a
   * few hours due to the validation review.
   * Start date and end date are separated by a forward slash (/). The start
   * date is specified by the format (YYYY-MM-DD), followed by the letter ?T?,
   * the time of the day when the sale starts (in Greenwich Mean Time, GMT),
   * followed by an expression of the time zone for the sale. The end date is in
   * the same format.
   */
  core.String effectiveDates;
  /**
   * Optional. The text code that corresponds to the promotion when applied on
   * the retailer?s website.
   */
  core.String genericRedemptionCode;
  /** The unique ID of the promotion. */
  core.String id;
  /** The full title of the promotion. */
  core.String longTitle;
  /**
   * Whether the promotion is applicable to all products or only specific
   * products.
   */
  core.String productApplicability;
  /** Indicates that the promotion is valid online. */
  core.String redemptionChannel;

  OrderPromotion();

  OrderPromotion.fromJson(core.Map _json) {
    if (_json.containsKey("benefits")) {
      benefits = _json["benefits"].map((value) => new OrderPromotionBenefit.fromJson(value)).toList();
    }
    if (_json.containsKey("effectiveDates")) {
      effectiveDates = _json["effectiveDates"];
    }
    if (_json.containsKey("genericRedemptionCode")) {
      genericRedemptionCode = _json["genericRedemptionCode"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("longTitle")) {
      longTitle = _json["longTitle"];
    }
    if (_json.containsKey("productApplicability")) {
      productApplicability = _json["productApplicability"];
    }
    if (_json.containsKey("redemptionChannel")) {
      redemptionChannel = _json["redemptionChannel"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (benefits != null) {
      _json["benefits"] = benefits.map((value) => (value).toJson()).toList();
    }
    if (effectiveDates != null) {
      _json["effectiveDates"] = effectiveDates;
    }
    if (genericRedemptionCode != null) {
      _json["genericRedemptionCode"] = genericRedemptionCode;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (longTitle != null) {
      _json["longTitle"] = longTitle;
    }
    if (productApplicability != null) {
      _json["productApplicability"] = productApplicability;
    }
    if (redemptionChannel != null) {
      _json["redemptionChannel"] = redemptionChannel;
    }
    return _json;
  }
}

class OrderPromotionBenefit {
  /** The discount in the order price when the promotion is applied. */
  Price discount;
  /**
   * The OfferId(s) that were purchased in this order and map to this specific
   * benefit of the promotion.
   */
  core.List<core.String> offerIds;
  /**
   * Further describes the benefit of the promotion. Note that we will expand on
   * this enumeration as we support new promotion sub-types.
   */
  core.String subType;
  /** The impact on tax when the promotion is applied. */
  Price taxImpact;
  /**
   * Describes whether the promotion applies to products (e.g. 20% off) or to
   * shipping (e.g. Free Shipping).
   */
  core.String type;

  OrderPromotionBenefit();

  OrderPromotionBenefit.fromJson(core.Map _json) {
    if (_json.containsKey("discount")) {
      discount = new Price.fromJson(_json["discount"]);
    }
    if (_json.containsKey("offerIds")) {
      offerIds = _json["offerIds"];
    }
    if (_json.containsKey("subType")) {
      subType = _json["subType"];
    }
    if (_json.containsKey("taxImpact")) {
      taxImpact = new Price.fromJson(_json["taxImpact"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (discount != null) {
      _json["discount"] = (discount).toJson();
    }
    if (offerIds != null) {
      _json["offerIds"] = offerIds;
    }
    if (subType != null) {
      _json["subType"] = subType;
    }
    if (taxImpact != null) {
      _json["taxImpact"] = (taxImpact).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class OrderRefund {
  /** The actor that created the refund. */
  core.String actor;
  /** The amount that is refunded. */
  Price amount;
  /** Date on which the item has been created, in ISO 8601 format. */
  core.String creationDate;
  /** The reason for the refund. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrderRefund();

  OrderRefund.fromJson(core.Map _json) {
    if (_json.containsKey("actor")) {
      actor = _json["actor"];
    }
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (actor != null) {
      _json["actor"] = actor;
    }
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrderReturn {
  /** The actor that created the refund. */
  core.String actor;
  /** Date on which the item has been created, in ISO 8601 format. */
  core.String creationDate;
  /** Quantity that is returned. */
  core.int quantity;
  /** The reason for the return. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrderReturn();

  OrderReturn.fromJson(core.Map _json) {
    if (_json.containsKey("actor")) {
      actor = _json["actor"];
    }
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (actor != null) {
      _json["actor"] = actor;
    }
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrderShipment {
  /** The carrier handling the shipment. */
  core.String carrier;
  /** Date on which the shipment has been created, in ISO 8601 format. */
  core.String creationDate;
  /**
   * Date on which the shipment has been delivered, in ISO 8601 format. Present
   * only if status is delievered
   */
  core.String deliveryDate;
  /** The id of the shipment. */
  core.String id;
  /** The line items that are shipped. */
  core.List<OrderShipmentLineItemShipment> lineItems;
  /** The status of the shipment. */
  core.String status;
  /** The tracking id for the shipment. */
  core.String trackingId;

  OrderShipment();

  OrderShipment.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("deliveryDate")) {
      deliveryDate = _json["deliveryDate"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"].map((value) => new OrderShipmentLineItemShipment.fromJson(value)).toList();
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (deliveryDate != null) {
      _json["deliveryDate"] = deliveryDate;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrderShipmentLineItemShipment {
  /** The id of the line item that is shipped. */
  core.String lineItemId;
  /** The quantity that is shipped. */
  core.int quantity;

  OrderShipmentLineItemShipment();

  OrderShipmentLineItemShipment.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    return _json;
  }
}

class OrdersAcknowledgeRequest {
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;

  OrdersAcknowledgeRequest();

  OrdersAcknowledgeRequest.fromJson(core.Map _json) {
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    return _json;
  }
}

class OrdersAcknowledgeResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersAcknowledgeResponse".
   */
  core.String kind;

  OrdersAcknowledgeResponse();

  OrdersAcknowledgeResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersAdvanceTestOrderResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersAdvanceTestOrderResponse".
   */
  core.String kind;

  OrdersAdvanceTestOrderResponse();

  OrdersAdvanceTestOrderResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersCancelLineItemRequest {
  /**
   * Amount to refund for the cancelation. Optional. If not set, Google will
   * calculate the default based on the price and tax of the items involved. The
   * amount must not be larger than the net amount left on the order.
   */
  Price amount;
  /** The ID of the line item to cancel. */
  core.String lineItemId;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;
  /** The quantity to cancel. */
  core.int quantity;
  /** The reason for the cancellation. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersCancelLineItemRequest();

  OrdersCancelLineItemRequest.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCancelLineItemResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersCancelLineItemResponse".
   */
  core.String kind;

  OrdersCancelLineItemResponse();

  OrdersCancelLineItemResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersCancelRequest {
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;
  /** The reason for the cancellation. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersCancelRequest();

  OrdersCancelRequest.fromJson(core.Map _json) {
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCancelResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersCancelResponse".
   */
  core.String kind;

  OrdersCancelResponse();

  OrdersCancelResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersCreateTestOrderRequest {
  /**
   * The test order template to use. Specify as an alternative to testOrder as a
   * shortcut for retrieving a template and then creating an order using that
   * template.
   */
  core.String templateName;
  /** The test order to create. */
  TestOrder testOrder;

  OrdersCreateTestOrderRequest();

  OrdersCreateTestOrderRequest.fromJson(core.Map _json) {
    if (_json.containsKey("templateName")) {
      templateName = _json["templateName"];
    }
    if (_json.containsKey("testOrder")) {
      testOrder = new TestOrder.fromJson(_json["testOrder"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (templateName != null) {
      _json["templateName"] = templateName;
    }
    if (testOrder != null) {
      _json["testOrder"] = (testOrder).toJson();
    }
    return _json;
  }
}

class OrdersCreateTestOrderResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersCreateTestOrderResponse".
   */
  core.String kind;
  /** The ID of the newly created test order. */
  core.String orderId;

  OrdersCreateTestOrderResponse();

  OrdersCreateTestOrderResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("orderId")) {
      orderId = _json["orderId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (orderId != null) {
      _json["orderId"] = orderId;
    }
    return _json;
  }
}

class OrdersCustomBatchRequest {
  /** The request entries to be processed in the batch. */
  core.List<OrdersCustomBatchRequestEntry> entries;

  OrdersCustomBatchRequest();

  OrdersCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new OrdersCustomBatchRequestEntry.fromJson(value)).toList();
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

class OrdersCustomBatchRequestEntry {
  /** An entry ID, unique within the batch request. */
  core.int batchId;
  /** Required for cancel method. */
  OrdersCustomBatchRequestEntryCancel cancel;
  /** Required for cancelLineItem method. */
  OrdersCustomBatchRequestEntryCancelLineItem cancelLineItem;
  /** The ID of the managing account. */
  core.String merchantId;
  /**
   * The merchant order id. Required for updateMerchantOrderId and
   * getByMerchantOrderId methods.
   */
  core.String merchantOrderId;
  /** The method to apply. */
  core.String method;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   * Required for all methods beside get and getByMerchantOrderId.
   */
  core.String operationId;
  /**
   * The ID of the order. Required for all methods beside getByMerchantOrderId.
   */
  core.String orderId;
  /** Required for refund method. */
  OrdersCustomBatchRequestEntryRefund refund;
  /** Required for returnLineItem method. */
  OrdersCustomBatchRequestEntryReturnLineItem returnLineItem;
  /** Required for shipLineItems method. */
  OrdersCustomBatchRequestEntryShipLineItems shipLineItems;
  /** Required for updateShipment method. */
  OrdersCustomBatchRequestEntryUpdateShipment updateShipment;

  OrdersCustomBatchRequestEntry();

  OrdersCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("cancel")) {
      cancel = new OrdersCustomBatchRequestEntryCancel.fromJson(_json["cancel"]);
    }
    if (_json.containsKey("cancelLineItem")) {
      cancelLineItem = new OrdersCustomBatchRequestEntryCancelLineItem.fromJson(_json["cancelLineItem"]);
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("merchantOrderId")) {
      merchantOrderId = _json["merchantOrderId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("orderId")) {
      orderId = _json["orderId"];
    }
    if (_json.containsKey("refund")) {
      refund = new OrdersCustomBatchRequestEntryRefund.fromJson(_json["refund"]);
    }
    if (_json.containsKey("returnLineItem")) {
      returnLineItem = new OrdersCustomBatchRequestEntryReturnLineItem.fromJson(_json["returnLineItem"]);
    }
    if (_json.containsKey("shipLineItems")) {
      shipLineItems = new OrdersCustomBatchRequestEntryShipLineItems.fromJson(_json["shipLineItems"]);
    }
    if (_json.containsKey("updateShipment")) {
      updateShipment = new OrdersCustomBatchRequestEntryUpdateShipment.fromJson(_json["updateShipment"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (cancel != null) {
      _json["cancel"] = (cancel).toJson();
    }
    if (cancelLineItem != null) {
      _json["cancelLineItem"] = (cancelLineItem).toJson();
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (merchantOrderId != null) {
      _json["merchantOrderId"] = merchantOrderId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (orderId != null) {
      _json["orderId"] = orderId;
    }
    if (refund != null) {
      _json["refund"] = (refund).toJson();
    }
    if (returnLineItem != null) {
      _json["returnLineItem"] = (returnLineItem).toJson();
    }
    if (shipLineItems != null) {
      _json["shipLineItems"] = (shipLineItems).toJson();
    }
    if (updateShipment != null) {
      _json["updateShipment"] = (updateShipment).toJson();
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryCancel {
  /** The reason for the cancellation. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersCustomBatchRequestEntryCancel();

  OrdersCustomBatchRequestEntryCancel.fromJson(core.Map _json) {
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryCancelLineItem {
  /**
   * Amount to refund for the cancelation. Optional. If not set, Google will
   * calculate the default based on the price and tax of the items involved. The
   * amount must not be larger than the net amount left on the order.
   */
  Price amount;
  /** The ID of the line item to cancel. */
  core.String lineItemId;
  /** The quantity to cancel. */
  core.int quantity;
  /** The reason for the cancellation. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersCustomBatchRequestEntryCancelLineItem();

  OrdersCustomBatchRequestEntryCancelLineItem.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryRefund {
  /** The amount that is refunded. */
  Price amount;
  /** The reason for the refund. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersCustomBatchRequestEntryRefund();

  OrdersCustomBatchRequestEntryRefund.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryReturnLineItem {
  /** The ID of the line item to return. */
  core.String lineItemId;
  /** The quantity to return. */
  core.int quantity;
  /** The reason for the return. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersCustomBatchRequestEntryReturnLineItem();

  OrdersCustomBatchRequestEntryReturnLineItem.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryShipLineItems {
  /** The carrier handling the shipment. */
  core.String carrier;
  /** Line items to ship. */
  core.List<OrderShipmentLineItemShipment> lineItems;
  /** The ID of the shipment. */
  core.String shipmentId;
  /** The tracking id for the shipment. */
  core.String trackingId;

  OrdersCustomBatchRequestEntryShipLineItems();

  OrdersCustomBatchRequestEntryShipLineItems.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"].map((value) => new OrderShipmentLineItemShipment.fromJson(value)).toList();
    }
    if (_json.containsKey("shipmentId")) {
      shipmentId = _json["shipmentId"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (shipmentId != null) {
      _json["shipmentId"] = shipmentId;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryUpdateShipment {
  /** The carrier handling the shipment. Not updated if missing. */
  core.String carrier;
  /** The ID of the shipment. */
  core.String shipmentId;
  /** New status for the shipment. Not updated if missing. */
  core.String status;
  /** The tracking id for the shipment. Not updated if missing. */
  core.String trackingId;

  OrdersCustomBatchRequestEntryUpdateShipment();

  OrdersCustomBatchRequestEntryUpdateShipment.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("shipmentId")) {
      shipmentId = _json["shipmentId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (shipmentId != null) {
      _json["shipmentId"] = shipmentId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrdersCustomBatchResponse {
  /** The result of the execution of the batch requests. */
  core.List<OrdersCustomBatchResponseEntry> entries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersCustomBatchResponse".
   */
  core.String kind;

  OrdersCustomBatchResponse();

  OrdersCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new OrdersCustomBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersCustomBatchResponseEntry {
  /** The ID of the request entry this entry responds to. */
  core.int batchId;
  /** A list of errors defined if and only if the request failed. */
  Errors errors;
  /**
   * The status of the execution. Only defined if the method is not get or
   * getByMerchantOrderId and if the request was successful.
   */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersCustomBatchResponseEntry".
   */
  core.String kind;
  /**
   * The retrieved order. Only defined if the method is get and if the request
   * was successful.
   */
  Order order;

  OrdersCustomBatchResponseEntry();

  OrdersCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("order")) {
      order = new Order.fromJson(_json["order"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (order != null) {
      _json["order"] = (order).toJson();
    }
    return _json;
  }
}

class OrdersGetByMerchantOrderIdResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersGetByMerchantOrderIdResponse".
   */
  core.String kind;
  /** The requested order. */
  Order order;

  OrdersGetByMerchantOrderIdResponse();

  OrdersGetByMerchantOrderIdResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("order")) {
      order = new Order.fromJson(_json["order"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (order != null) {
      _json["order"] = (order).toJson();
    }
    return _json;
  }
}

class OrdersGetTestOrderTemplateResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersGetTestOrderTemplateResponse".
   */
  core.String kind;
  /** The requested test order template. */
  TestOrder template;

  OrdersGetTestOrderTemplateResponse();

  OrdersGetTestOrderTemplateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("template")) {
      template = new TestOrder.fromJson(_json["template"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (template != null) {
      _json["template"] = (template).toJson();
    }
    return _json;
  }
}

class OrdersListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersListResponse".
   */
  core.String kind;
  /** The token for the retrieval of the next page of orders. */
  core.String nextPageToken;
  core.List<Order> resources;

  OrdersListResponse();

  OrdersListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new Order.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OrdersRefundRequest {
  /** The amount that is refunded. */
  Price amount;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;
  /** The reason for the refund. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersRefundRequest();

  OrdersRefundRequest.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersRefundResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersRefundResponse".
   */
  core.String kind;

  OrdersRefundResponse();

  OrdersRefundResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersReturnLineItemRequest {
  /** The ID of the line item to return. */
  core.String lineItemId;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;
  /** The quantity to return. */
  core.int quantity;
  /** The reason for the return. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersReturnLineItemRequest();

  OrdersReturnLineItemRequest.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersReturnLineItemResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersReturnLineItemResponse".
   */
  core.String kind;

  OrdersReturnLineItemResponse();

  OrdersReturnLineItemResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersShipLineItemsRequest {
  /** The carrier handling the shipment. */
  core.String carrier;
  /** Line items to ship. */
  core.List<OrderShipmentLineItemShipment> lineItems;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;
  /** The ID of the shipment. */
  core.String shipmentId;
  /** The tracking id for the shipment. */
  core.String trackingId;

  OrdersShipLineItemsRequest();

  OrdersShipLineItemsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"].map((value) => new OrderShipmentLineItemShipment.fromJson(value)).toList();
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("shipmentId")) {
      shipmentId = _json["shipmentId"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (shipmentId != null) {
      _json["shipmentId"] = shipmentId;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrdersShipLineItemsResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersShipLineItemsResponse".
   */
  core.String kind;

  OrdersShipLineItemsResponse();

  OrdersShipLineItemsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersUpdateMerchantOrderIdRequest {
  /**
   * The merchant order id to be assigned to the order. Must be unique per
   * merchant.
   */
  core.String merchantOrderId;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;

  OrdersUpdateMerchantOrderIdRequest();

  OrdersUpdateMerchantOrderIdRequest.fromJson(core.Map _json) {
    if (_json.containsKey("merchantOrderId")) {
      merchantOrderId = _json["merchantOrderId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (merchantOrderId != null) {
      _json["merchantOrderId"] = merchantOrderId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    return _json;
  }
}

class OrdersUpdateMerchantOrderIdResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersUpdateMerchantOrderIdResponse".
   */
  core.String kind;

  OrdersUpdateMerchantOrderIdResponse();

  OrdersUpdateMerchantOrderIdResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersUpdateShipmentRequest {
  /** The carrier handling the shipment. Not updated if missing. */
  core.String carrier;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;
  /** The ID of the shipment. */
  core.String shipmentId;
  /** New status for the shipment. Not updated if missing. */
  core.String status;
  /** The tracking id for the shipment. Not updated if missing. */
  core.String trackingId;

  OrdersUpdateShipmentRequest();

  OrdersUpdateShipmentRequest.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("shipmentId")) {
      shipmentId = _json["shipmentId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (shipmentId != null) {
      _json["shipmentId"] = shipmentId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrdersUpdateShipmentResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersUpdateShipmentResponse".
   */
  core.String kind;

  OrdersUpdateShipmentResponse();

  OrdersUpdateShipmentResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class PostalCodeGroup {
  /**
   * The CLDR territory code of the country the postal code group applies to.
   * Required.
   */
  core.String country;
  /** The name of the postal code group, referred to in headers. Required. */
  core.String name;
  /** A range of postal codes. Required. */
  core.List<PostalCodeRange> postalCodeRanges;

  PostalCodeGroup();

  PostalCodeGroup.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("postalCodeRanges")) {
      postalCodeRanges = _json["postalCodeRanges"].map((value) => new PostalCodeRange.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (postalCodeRanges != null) {
      _json["postalCodeRanges"] = postalCodeRanges.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class PostalCodeRange {
  /**
   * A postal code or a pattern of the form prefix* denoting the inclusive lower
   * bound of the range defining the area. Examples values: "94108", "9410*",
   * "9*". Required.
   */
  core.String postalCodeRangeBegin;
  /**
   * A postal code or a pattern of the form prefix* denoting the inclusive upper
   * bound of the range defining the area. It must have the same length as
   * postalCodeRangeBegin: if postalCodeRangeBegin is a postal code then
   * postalCodeRangeEnd must be a postal code too; if postalCodeRangeBegin is a
   * pattern then postalCodeRangeEnd must be a pattern with the same prefix
   * length. Optional: if not set, then the area is defined as being all the
   * postal codes matching postalCodeRangeBegin.
   */
  core.String postalCodeRangeEnd;

  PostalCodeRange();

  PostalCodeRange.fromJson(core.Map _json) {
    if (_json.containsKey("postalCodeRangeBegin")) {
      postalCodeRangeBegin = _json["postalCodeRangeBegin"];
    }
    if (_json.containsKey("postalCodeRangeEnd")) {
      postalCodeRangeEnd = _json["postalCodeRangeEnd"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (postalCodeRangeBegin != null) {
      _json["postalCodeRangeBegin"] = postalCodeRangeBegin;
    }
    if (postalCodeRangeEnd != null) {
      _json["postalCodeRangeEnd"] = postalCodeRangeEnd;
    }
    return _json;
  }
}

class Price {
  /** The currency of the price. */
  core.String currency;
  /** The price represented as a number. */
  core.String value;

  Price();

  Price.fromJson(core.Map _json) {
    if (_json.containsKey("currency")) {
      currency = _json["currency"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currency != null) {
      _json["currency"] = currency;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** Product data. */
class Product {
  /** Additional URLs of images of the item. */
  core.List<core.String> additionalImageLinks;
  /**
   * Additional categories of the item (formatted as in products feed
   * specification).
   */
  core.List<core.String> additionalProductTypes;
  /** Set to true if the item is targeted towards adults. */
  core.bool adult;
  /**
   * Used to group items in an arbitrary way. Only for CPA%, discouraged
   * otherwise.
   */
  core.String adwordsGrouping;
  /** Similar to adwords_grouping, but only works on CPC. */
  core.List<core.String> adwordsLabels;
  /**
   * Allows advertisers to override the item URL when the product is shown
   * within the context of Product Ads.
   */
  core.String adwordsRedirect;
  /** Target age group of the item. */
  core.String ageGroup;
  /** Specifies the intended aspects for the product. */
  core.List<ProductAspect> aspects;
  /** Availability status of the item. */
  core.String availability;
  /**
   * The day a pre-ordered product becomes available for delivery, in ISO 8601
   * format.
   */
  core.String availabilityDate;
  /** Brand of the item. */
  core.String brand;
  /** The item's channel (online or local). */
  core.String channel;
  /** Color of the item. */
  core.String color;
  /** Condition or state of the item. */
  core.String condition;
  /** The two-letter ISO 639-1 language code for the item. */
  core.String contentLanguage;
  /**
   * A list of custom (merchant-provided) attributes. It can also be used for
   * submitting any attribute of the feed specification in its generic form
   * (e.g., { "name": "size type", "type": "text", "value": "regular" }). This
   * is useful for submitting attributes not explicitly exposed by the API.
   */
  core.List<ProductCustomAttribute> customAttributes;
  /** A list of custom (merchant-provided) custom attribute groups. */
  core.List<ProductCustomGroup> customGroups;
  /** Custom label 0 for custom grouping of items in a Shopping campaign. */
  core.String customLabel0;
  /** Custom label 1 for custom grouping of items in a Shopping campaign. */
  core.String customLabel1;
  /** Custom label 2 for custom grouping of items in a Shopping campaign. */
  core.String customLabel2;
  /** Custom label 3 for custom grouping of items in a Shopping campaign. */
  core.String customLabel3;
  /** Custom label 4 for custom grouping of items in a Shopping campaign. */
  core.String customLabel4;
  /** Description of the item. */
  core.String description;
  /** Specifies the intended destinations for the product. */
  core.List<ProductDestination> destinations;
  /** An identifier for an item for dynamic remarketing campaigns. */
  core.String displayAdsId;
  /**
   * URL directly to your item's landing page for dynamic remarketing campaigns.
   */
  core.String displayAdsLink;
  /** Advertiser-specified recommendations. */
  core.List<core.String> displayAdsSimilarIds;
  /** Title of an item for dynamic remarketing campaigns. */
  core.String displayAdsTitle;
  /** Offer margin for dynamic remarketing campaigns. */
  core.double displayAdsValue;
  /** The energy efficiency class as defined in EU directive 2010/30/EU. */
  core.String energyEfficiencyClass;
  /**
   * Date on which the item should expire, as specified upon insertion, in ISO
   * 8601 format. The actual expiration date in Google Shopping is exposed in
   * productstatuses as googleExpirationDate and might be earlier if
   * expirationDate is too far in the future.
   */
  core.String expirationDate;
  /** Target gender of the item. */
  core.String gender;
  /** Google's category of the item (see Google product taxonomy). */
  core.String googleProductCategory;
  /** Global Trade Item Number (GTIN) of the item. */
  core.String gtin;
  /** The REST id of the product. */
  core.String id;
  /**
   * False when the item does not have unique product identifiers appropriate to
   * its category, such as GTIN, MPN, and brand. Required according to the
   * Unique Product Identifier Rules for all target countries except for Canada.
   */
  core.bool identifierExists;
  /** URL of an image of the item. */
  core.String imageLink;
  /** Number and amount of installments to pay for an item. Brazil only. */
  Installment installment;
  /**
   * Whether the item is a merchant-defined bundle. A bundle is a custom
   * grouping of different products sold by a merchant for a single price.
   */
  core.bool isBundle;
  /** Shared identifier for all variants of the same product. */
  core.String itemGroupId;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#product".
   */
  core.String kind;
  /** URL directly linking to your item's page on your website. */
  core.String link;
  /**
   * Loyalty points that users receive after purchasing the item. Japan only.
   */
  LoyaltyPoints loyaltyPoints;
  /** The material of which the item is made. */
  core.String material;
  /** Link to a mobile-optimized version of the landing page. */
  core.String mobileLink;
  /** Manufacturer Part Number (MPN) of the item. */
  core.String mpn;
  /** The number of identical products in a merchant-defined multipack. */
  core.String multipack;
  /**
   * An identifier of the item. Leading and trailing whitespaces are stripped
   * and multiple whitespaces are replaced by a single whitespace upon
   * submission. Only valid unicode characters are accepted. See the products
   * feed specification for details.
   */
  core.String offerId;
  /** Whether an item is available for purchase only online. */
  core.bool onlineOnly;
  /** The item's pattern (e.g. polka dots). */
  core.String pattern;
  /** Price of the item. */
  Price price;
  /**
   * Your category of the item (formatted as in products feed specification).
   */
  core.String productType;
  /** The unique ID of a promotion. */
  core.List<core.String> promotionIds;
  /** Advertised sale price of the item. */
  Price salePrice;
  /**
   * Date range during which the item is on sale (see products feed
   * specification).
   */
  core.String salePriceEffectiveDate;
  /** The quantity of the product that is reserved for sell-on-google ads. */
  core.String sellOnGoogleQuantity;
  /** Shipping rules. */
  core.List<ProductShipping> shipping;
  /** Height of the item for shipping. */
  ProductShippingDimension shippingHeight;
  /**
   * The shipping label of the product, used to group product in account-level
   * shipping rules.
   */
  core.String shippingLabel;
  /** Length of the item for shipping. */
  ProductShippingDimension shippingLength;
  /** Weight of the item for shipping. */
  ProductShippingWeight shippingWeight;
  /** Width of the item for shipping. */
  ProductShippingDimension shippingWidth;
  /** System in which the size is specified. Recommended for apparel items. */
  core.String sizeSystem;
  /** The cut of the item. Recommended for apparel items. */
  core.String sizeType;
  /** Size of the item. */
  core.List<core.String> sizes;
  /** The CLDR territory code for the item. */
  core.String targetCountry;
  /** Tax information. */
  core.List<ProductTax> taxes;
  /** Title of the item. */
  core.String title;
  /** The preference of the denominator of the unit price. */
  ProductUnitPricingBaseMeasure unitPricingBaseMeasure;
  /** The measure and dimension of an item. */
  ProductUnitPricingMeasure unitPricingMeasure;
  /** The read-only list of intended destinations which passed validation. */
  core.List<core.String> validatedDestinations;
  /** Read-only warnings. */
  core.List<Error> warnings;

  Product();

  Product.fromJson(core.Map _json) {
    if (_json.containsKey("additionalImageLinks")) {
      additionalImageLinks = _json["additionalImageLinks"];
    }
    if (_json.containsKey("additionalProductTypes")) {
      additionalProductTypes = _json["additionalProductTypes"];
    }
    if (_json.containsKey("adult")) {
      adult = _json["adult"];
    }
    if (_json.containsKey("adwordsGrouping")) {
      adwordsGrouping = _json["adwordsGrouping"];
    }
    if (_json.containsKey("adwordsLabels")) {
      adwordsLabels = _json["adwordsLabels"];
    }
    if (_json.containsKey("adwordsRedirect")) {
      adwordsRedirect = _json["adwordsRedirect"];
    }
    if (_json.containsKey("ageGroup")) {
      ageGroup = _json["ageGroup"];
    }
    if (_json.containsKey("aspects")) {
      aspects = _json["aspects"].map((value) => new ProductAspect.fromJson(value)).toList();
    }
    if (_json.containsKey("availability")) {
      availability = _json["availability"];
    }
    if (_json.containsKey("availabilityDate")) {
      availabilityDate = _json["availabilityDate"];
    }
    if (_json.containsKey("brand")) {
      brand = _json["brand"];
    }
    if (_json.containsKey("channel")) {
      channel = _json["channel"];
    }
    if (_json.containsKey("color")) {
      color = _json["color"];
    }
    if (_json.containsKey("condition")) {
      condition = _json["condition"];
    }
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("customAttributes")) {
      customAttributes = _json["customAttributes"].map((value) => new ProductCustomAttribute.fromJson(value)).toList();
    }
    if (_json.containsKey("customGroups")) {
      customGroups = _json["customGroups"].map((value) => new ProductCustomGroup.fromJson(value)).toList();
    }
    if (_json.containsKey("customLabel0")) {
      customLabel0 = _json["customLabel0"];
    }
    if (_json.containsKey("customLabel1")) {
      customLabel1 = _json["customLabel1"];
    }
    if (_json.containsKey("customLabel2")) {
      customLabel2 = _json["customLabel2"];
    }
    if (_json.containsKey("customLabel3")) {
      customLabel3 = _json["customLabel3"];
    }
    if (_json.containsKey("customLabel4")) {
      customLabel4 = _json["customLabel4"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("destinations")) {
      destinations = _json["destinations"].map((value) => new ProductDestination.fromJson(value)).toList();
    }
    if (_json.containsKey("displayAdsId")) {
      displayAdsId = _json["displayAdsId"];
    }
    if (_json.containsKey("displayAdsLink")) {
      displayAdsLink = _json["displayAdsLink"];
    }
    if (_json.containsKey("displayAdsSimilarIds")) {
      displayAdsSimilarIds = _json["displayAdsSimilarIds"];
    }
    if (_json.containsKey("displayAdsTitle")) {
      displayAdsTitle = _json["displayAdsTitle"];
    }
    if (_json.containsKey("displayAdsValue")) {
      displayAdsValue = _json["displayAdsValue"];
    }
    if (_json.containsKey("energyEfficiencyClass")) {
      energyEfficiencyClass = _json["energyEfficiencyClass"];
    }
    if (_json.containsKey("expirationDate")) {
      expirationDate = _json["expirationDate"];
    }
    if (_json.containsKey("gender")) {
      gender = _json["gender"];
    }
    if (_json.containsKey("googleProductCategory")) {
      googleProductCategory = _json["googleProductCategory"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("identifierExists")) {
      identifierExists = _json["identifierExists"];
    }
    if (_json.containsKey("imageLink")) {
      imageLink = _json["imageLink"];
    }
    if (_json.containsKey("installment")) {
      installment = new Installment.fromJson(_json["installment"]);
    }
    if (_json.containsKey("isBundle")) {
      isBundle = _json["isBundle"];
    }
    if (_json.containsKey("itemGroupId")) {
      itemGroupId = _json["itemGroupId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("link")) {
      link = _json["link"];
    }
    if (_json.containsKey("loyaltyPoints")) {
      loyaltyPoints = new LoyaltyPoints.fromJson(_json["loyaltyPoints"]);
    }
    if (_json.containsKey("material")) {
      material = _json["material"];
    }
    if (_json.containsKey("mobileLink")) {
      mobileLink = _json["mobileLink"];
    }
    if (_json.containsKey("mpn")) {
      mpn = _json["mpn"];
    }
    if (_json.containsKey("multipack")) {
      multipack = _json["multipack"];
    }
    if (_json.containsKey("offerId")) {
      offerId = _json["offerId"];
    }
    if (_json.containsKey("onlineOnly")) {
      onlineOnly = _json["onlineOnly"];
    }
    if (_json.containsKey("pattern")) {
      pattern = _json["pattern"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("productType")) {
      productType = _json["productType"];
    }
    if (_json.containsKey("promotionIds")) {
      promotionIds = _json["promotionIds"];
    }
    if (_json.containsKey("salePrice")) {
      salePrice = new Price.fromJson(_json["salePrice"]);
    }
    if (_json.containsKey("salePriceEffectiveDate")) {
      salePriceEffectiveDate = _json["salePriceEffectiveDate"];
    }
    if (_json.containsKey("sellOnGoogleQuantity")) {
      sellOnGoogleQuantity = _json["sellOnGoogleQuantity"];
    }
    if (_json.containsKey("shipping")) {
      shipping = _json["shipping"].map((value) => new ProductShipping.fromJson(value)).toList();
    }
    if (_json.containsKey("shippingHeight")) {
      shippingHeight = new ProductShippingDimension.fromJson(_json["shippingHeight"]);
    }
    if (_json.containsKey("shippingLabel")) {
      shippingLabel = _json["shippingLabel"];
    }
    if (_json.containsKey("shippingLength")) {
      shippingLength = new ProductShippingDimension.fromJson(_json["shippingLength"]);
    }
    if (_json.containsKey("shippingWeight")) {
      shippingWeight = new ProductShippingWeight.fromJson(_json["shippingWeight"]);
    }
    if (_json.containsKey("shippingWidth")) {
      shippingWidth = new ProductShippingDimension.fromJson(_json["shippingWidth"]);
    }
    if (_json.containsKey("sizeSystem")) {
      sizeSystem = _json["sizeSystem"];
    }
    if (_json.containsKey("sizeType")) {
      sizeType = _json["sizeType"];
    }
    if (_json.containsKey("sizes")) {
      sizes = _json["sizes"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("taxes")) {
      taxes = _json["taxes"].map((value) => new ProductTax.fromJson(value)).toList();
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("unitPricingBaseMeasure")) {
      unitPricingBaseMeasure = new ProductUnitPricingBaseMeasure.fromJson(_json["unitPricingBaseMeasure"]);
    }
    if (_json.containsKey("unitPricingMeasure")) {
      unitPricingMeasure = new ProductUnitPricingMeasure.fromJson(_json["unitPricingMeasure"]);
    }
    if (_json.containsKey("validatedDestinations")) {
      validatedDestinations = _json["validatedDestinations"];
    }
    if (_json.containsKey("warnings")) {
      warnings = _json["warnings"].map((value) => new Error.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (additionalImageLinks != null) {
      _json["additionalImageLinks"] = additionalImageLinks;
    }
    if (additionalProductTypes != null) {
      _json["additionalProductTypes"] = additionalProductTypes;
    }
    if (adult != null) {
      _json["adult"] = adult;
    }
    if (adwordsGrouping != null) {
      _json["adwordsGrouping"] = adwordsGrouping;
    }
    if (adwordsLabels != null) {
      _json["adwordsLabels"] = adwordsLabels;
    }
    if (adwordsRedirect != null) {
      _json["adwordsRedirect"] = adwordsRedirect;
    }
    if (ageGroup != null) {
      _json["ageGroup"] = ageGroup;
    }
    if (aspects != null) {
      _json["aspects"] = aspects.map((value) => (value).toJson()).toList();
    }
    if (availability != null) {
      _json["availability"] = availability;
    }
    if (availabilityDate != null) {
      _json["availabilityDate"] = availabilityDate;
    }
    if (brand != null) {
      _json["brand"] = brand;
    }
    if (channel != null) {
      _json["channel"] = channel;
    }
    if (color != null) {
      _json["color"] = color;
    }
    if (condition != null) {
      _json["condition"] = condition;
    }
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (customAttributes != null) {
      _json["customAttributes"] = customAttributes.map((value) => (value).toJson()).toList();
    }
    if (customGroups != null) {
      _json["customGroups"] = customGroups.map((value) => (value).toJson()).toList();
    }
    if (customLabel0 != null) {
      _json["customLabel0"] = customLabel0;
    }
    if (customLabel1 != null) {
      _json["customLabel1"] = customLabel1;
    }
    if (customLabel2 != null) {
      _json["customLabel2"] = customLabel2;
    }
    if (customLabel3 != null) {
      _json["customLabel3"] = customLabel3;
    }
    if (customLabel4 != null) {
      _json["customLabel4"] = customLabel4;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (destinations != null) {
      _json["destinations"] = destinations.map((value) => (value).toJson()).toList();
    }
    if (displayAdsId != null) {
      _json["displayAdsId"] = displayAdsId;
    }
    if (displayAdsLink != null) {
      _json["displayAdsLink"] = displayAdsLink;
    }
    if (displayAdsSimilarIds != null) {
      _json["displayAdsSimilarIds"] = displayAdsSimilarIds;
    }
    if (displayAdsTitle != null) {
      _json["displayAdsTitle"] = displayAdsTitle;
    }
    if (displayAdsValue != null) {
      _json["displayAdsValue"] = displayAdsValue;
    }
    if (energyEfficiencyClass != null) {
      _json["energyEfficiencyClass"] = energyEfficiencyClass;
    }
    if (expirationDate != null) {
      _json["expirationDate"] = expirationDate;
    }
    if (gender != null) {
      _json["gender"] = gender;
    }
    if (googleProductCategory != null) {
      _json["googleProductCategory"] = googleProductCategory;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (identifierExists != null) {
      _json["identifierExists"] = identifierExists;
    }
    if (imageLink != null) {
      _json["imageLink"] = imageLink;
    }
    if (installment != null) {
      _json["installment"] = (installment).toJson();
    }
    if (isBundle != null) {
      _json["isBundle"] = isBundle;
    }
    if (itemGroupId != null) {
      _json["itemGroupId"] = itemGroupId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (link != null) {
      _json["link"] = link;
    }
    if (loyaltyPoints != null) {
      _json["loyaltyPoints"] = (loyaltyPoints).toJson();
    }
    if (material != null) {
      _json["material"] = material;
    }
    if (mobileLink != null) {
      _json["mobileLink"] = mobileLink;
    }
    if (mpn != null) {
      _json["mpn"] = mpn;
    }
    if (multipack != null) {
      _json["multipack"] = multipack;
    }
    if (offerId != null) {
      _json["offerId"] = offerId;
    }
    if (onlineOnly != null) {
      _json["onlineOnly"] = onlineOnly;
    }
    if (pattern != null) {
      _json["pattern"] = pattern;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (productType != null) {
      _json["productType"] = productType;
    }
    if (promotionIds != null) {
      _json["promotionIds"] = promotionIds;
    }
    if (salePrice != null) {
      _json["salePrice"] = (salePrice).toJson();
    }
    if (salePriceEffectiveDate != null) {
      _json["salePriceEffectiveDate"] = salePriceEffectiveDate;
    }
    if (sellOnGoogleQuantity != null) {
      _json["sellOnGoogleQuantity"] = sellOnGoogleQuantity;
    }
    if (shipping != null) {
      _json["shipping"] = shipping.map((value) => (value).toJson()).toList();
    }
    if (shippingHeight != null) {
      _json["shippingHeight"] = (shippingHeight).toJson();
    }
    if (shippingLabel != null) {
      _json["shippingLabel"] = shippingLabel;
    }
    if (shippingLength != null) {
      _json["shippingLength"] = (shippingLength).toJson();
    }
    if (shippingWeight != null) {
      _json["shippingWeight"] = (shippingWeight).toJson();
    }
    if (shippingWidth != null) {
      _json["shippingWidth"] = (shippingWidth).toJson();
    }
    if (sizeSystem != null) {
      _json["sizeSystem"] = sizeSystem;
    }
    if (sizeType != null) {
      _json["sizeType"] = sizeType;
    }
    if (sizes != null) {
      _json["sizes"] = sizes;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (taxes != null) {
      _json["taxes"] = taxes.map((value) => (value).toJson()).toList();
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (unitPricingBaseMeasure != null) {
      _json["unitPricingBaseMeasure"] = (unitPricingBaseMeasure).toJson();
    }
    if (unitPricingMeasure != null) {
      _json["unitPricingMeasure"] = (unitPricingMeasure).toJson();
    }
    if (validatedDestinations != null) {
      _json["validatedDestinations"] = validatedDestinations;
    }
    if (warnings != null) {
      _json["warnings"] = warnings.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ProductAspect {
  /** The name of the aspect. */
  core.String aspectName;
  /** The name of the destination. Leave out to apply to all destinations. */
  core.String destinationName;
  /** Whether the aspect is required, excluded or should be validated. */
  core.String intention;

  ProductAspect();

  ProductAspect.fromJson(core.Map _json) {
    if (_json.containsKey("aspectName")) {
      aspectName = _json["aspectName"];
    }
    if (_json.containsKey("destinationName")) {
      destinationName = _json["destinationName"];
    }
    if (_json.containsKey("intention")) {
      intention = _json["intention"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aspectName != null) {
      _json["aspectName"] = aspectName;
    }
    if (destinationName != null) {
      _json["destinationName"] = destinationName;
    }
    if (intention != null) {
      _json["intention"] = intention;
    }
    return _json;
  }
}

class ProductCustomAttribute {
  /**
   * The name of the attribute. Underscores will be replaced by spaces upon
   * insertion.
   */
  core.String name;
  /** The type of the attribute. */
  core.String type;
  /**
   * Free-form unit of the attribute. Unit can only be used for values of type
   * INT or FLOAT.
   */
  core.String unit;
  /** The value of the attribute. */
  core.String value;

  ProductCustomAttribute();

  ProductCustomAttribute.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class ProductCustomGroup {
  /** The sub-attributes. */
  core.List<ProductCustomAttribute> attributes;
  /**
   * The name of the group. Underscores will be replaced by spaces upon
   * insertion.
   */
  core.String name;

  ProductCustomGroup();

  ProductCustomGroup.fromJson(core.Map _json) {
    if (_json.containsKey("attributes")) {
      attributes = _json["attributes"].map((value) => new ProductCustomAttribute.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (attributes != null) {
      _json["attributes"] = attributes.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

class ProductDestination {
  /** The name of the destination. */
  core.String destinationName;
  /** Whether the destination is required, excluded or should be validated. */
  core.String intention;

  ProductDestination();

  ProductDestination.fromJson(core.Map _json) {
    if (_json.containsKey("destinationName")) {
      destinationName = _json["destinationName"];
    }
    if (_json.containsKey("intention")) {
      intention = _json["intention"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (destinationName != null) {
      _json["destinationName"] = destinationName;
    }
    if (intention != null) {
      _json["intention"] = intention;
    }
    return _json;
  }
}

class ProductShipping {
  /** The CLDR territory code of the country to which an item will ship. */
  core.String country;
  /**
   * The location where the shipping is applicable, represented by a location
   * group name.
   */
  core.String locationGroupName;
  /**
   * The numeric id of a location that the shipping rate applies to as defined
   * in the AdWords API.
   */
  core.String locationId;
  /**
   * The postal code range that the shipping rate applies to, represented by a
   * postal code, a postal code prefix followed by a * wildcard, a range between
   * two postal codes or two postal code prefixes of equal length.
   */
  core.String postalCode;
  /** Fixed shipping price, represented as a number. */
  Price price;
  /**
   * The geographic region to which a shipping rate applies (e.g. zip code).
   */
  core.String region;
  /** A free-form description of the service class or delivery speed. */
  core.String service;

  ProductShipping();

  ProductShipping.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("locationGroupName")) {
      locationGroupName = _json["locationGroupName"];
    }
    if (_json.containsKey("locationId")) {
      locationId = _json["locationId"];
    }
    if (_json.containsKey("postalCode")) {
      postalCode = _json["postalCode"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("service")) {
      service = _json["service"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (locationGroupName != null) {
      _json["locationGroupName"] = locationGroupName;
    }
    if (locationId != null) {
      _json["locationId"] = locationId;
    }
    if (postalCode != null) {
      _json["postalCode"] = postalCode;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (service != null) {
      _json["service"] = service;
    }
    return _json;
  }
}

class ProductShippingDimension {
  /**
   * The unit of value.
   *
   * Acceptable values are:
   * - "cm"
   * - "in"
   */
  core.String unit;
  /**
   * The dimension of the product used to calculate the shipping cost of the
   * item.
   */
  core.double value;

  ProductShippingDimension();

  ProductShippingDimension.fromJson(core.Map _json) {
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class ProductShippingWeight {
  /** The unit of value. */
  core.String unit;
  /**
   * The weight of the product used to calculate the shipping cost of the item.
   */
  core.double value;

  ProductShippingWeight();

  ProductShippingWeight.fromJson(core.Map _json) {
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/**
 * The status of a product, i.e., information about a product computed
 * asynchronously by the data quality analysis.
 */
class ProductStatus {
  /** Date on which the item has been created, in ISO 8601 format. */
  core.String creationDate;
  /** A list of data quality issues associated with the product. */
  core.List<ProductStatusDataQualityIssue> dataQualityIssues;
  /** The intended destinations for the product. */
  core.List<ProductStatusDestinationStatus> destinationStatuses;
  /** Date on which the item expires in Google Shopping, in ISO 8601 format. */
  core.String googleExpirationDate;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#productStatus".
   */
  core.String kind;
  /** Date on which the item has been last updated, in ISO 8601 format. */
  core.String lastUpdateDate;
  /** The link to the product. */
  core.String link;
  /** The id of the product for which status is reported. */
  core.String productId;
  /** The title of the product. */
  core.String title;

  ProductStatus();

  ProductStatus.fromJson(core.Map _json) {
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("dataQualityIssues")) {
      dataQualityIssues = _json["dataQualityIssues"].map((value) => new ProductStatusDataQualityIssue.fromJson(value)).toList();
    }
    if (_json.containsKey("destinationStatuses")) {
      destinationStatuses = _json["destinationStatuses"].map((value) => new ProductStatusDestinationStatus.fromJson(value)).toList();
    }
    if (_json.containsKey("googleExpirationDate")) {
      googleExpirationDate = _json["googleExpirationDate"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastUpdateDate")) {
      lastUpdateDate = _json["lastUpdateDate"];
    }
    if (_json.containsKey("link")) {
      link = _json["link"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (dataQualityIssues != null) {
      _json["dataQualityIssues"] = dataQualityIssues.map((value) => (value).toJson()).toList();
    }
    if (destinationStatuses != null) {
      _json["destinationStatuses"] = destinationStatuses.map((value) => (value).toJson()).toList();
    }
    if (googleExpirationDate != null) {
      _json["googleExpirationDate"] = googleExpirationDate;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastUpdateDate != null) {
      _json["lastUpdateDate"] = lastUpdateDate;
    }
    if (link != null) {
      _json["link"] = link;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class ProductStatusDataQualityIssue {
  /** A more detailed error string. */
  core.String detail;
  /** The fetch status for landing_page_errors. */
  core.String fetchStatus;
  /** The id of the data quality issue. */
  core.String id;
  /** The attribute name that is relevant for the issue. */
  core.String location;
  /** The severity of the data quality issue. */
  core.String severity;
  /** The time stamp of the data quality issue. */
  core.String timestamp;
  /** The value of that attribute that was found on the landing page */
  core.String valueOnLandingPage;
  /** The value the attribute had at time of evaluation. */
  core.String valueProvided;

  ProductStatusDataQualityIssue();

  ProductStatusDataQualityIssue.fromJson(core.Map _json) {
    if (_json.containsKey("detail")) {
      detail = _json["detail"];
    }
    if (_json.containsKey("fetchStatus")) {
      fetchStatus = _json["fetchStatus"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("severity")) {
      severity = _json["severity"];
    }
    if (_json.containsKey("timestamp")) {
      timestamp = _json["timestamp"];
    }
    if (_json.containsKey("valueOnLandingPage")) {
      valueOnLandingPage = _json["valueOnLandingPage"];
    }
    if (_json.containsKey("valueProvided")) {
      valueProvided = _json["valueProvided"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (detail != null) {
      _json["detail"] = detail;
    }
    if (fetchStatus != null) {
      _json["fetchStatus"] = fetchStatus;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (severity != null) {
      _json["severity"] = severity;
    }
    if (timestamp != null) {
      _json["timestamp"] = timestamp;
    }
    if (valueOnLandingPage != null) {
      _json["valueOnLandingPage"] = valueOnLandingPage;
    }
    if (valueProvided != null) {
      _json["valueProvided"] = valueProvided;
    }
    return _json;
  }
}

class ProductStatusDestinationStatus {
  /** The destination's approval status. */
  core.String approvalStatus;
  /** The name of the destination */
  core.String destination;
  /**
   * Whether the destination is required, excluded, selected by default or
   * should be validated.
   */
  core.String intention;

  ProductStatusDestinationStatus();

  ProductStatusDestinationStatus.fromJson(core.Map _json) {
    if (_json.containsKey("approvalStatus")) {
      approvalStatus = _json["approvalStatus"];
    }
    if (_json.containsKey("destination")) {
      destination = _json["destination"];
    }
    if (_json.containsKey("intention")) {
      intention = _json["intention"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (approvalStatus != null) {
      _json["approvalStatus"] = approvalStatus;
    }
    if (destination != null) {
      _json["destination"] = destination;
    }
    if (intention != null) {
      _json["intention"] = intention;
    }
    return _json;
  }
}

class ProductTax {
  /**
   * The country within which the item is taxed, specified as a CLDR territory
   * code.
   */
  core.String country;
  /**
   * The numeric id of a location that the tax rate applies to as defined in the
   * AdWords API.
   */
  core.String locationId;
  /**
   * The postal code range that the tax rate applies to, represented by a ZIP
   * code, a ZIP code prefix using * wildcard, a range between two ZIP codes or
   * two ZIP code prefixes of equal length. Examples: 94114, 94*, 94002-95460,
   * 94*-95*.
   */
  core.String postalCode;
  /** The percentage of tax rate that applies to the item price. */
  core.double rate;
  /** The geographic region to which the tax rate applies. */
  core.String region;
  /** Set to true if tax is charged on shipping. */
  core.bool taxShip;

  ProductTax();

  ProductTax.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("locationId")) {
      locationId = _json["locationId"];
    }
    if (_json.containsKey("postalCode")) {
      postalCode = _json["postalCode"];
    }
    if (_json.containsKey("rate")) {
      rate = _json["rate"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("taxShip")) {
      taxShip = _json["taxShip"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (locationId != null) {
      _json["locationId"] = locationId;
    }
    if (postalCode != null) {
      _json["postalCode"] = postalCode;
    }
    if (rate != null) {
      _json["rate"] = rate;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (taxShip != null) {
      _json["taxShip"] = taxShip;
    }
    return _json;
  }
}

class ProductUnitPricingBaseMeasure {
  /** The unit of the denominator. */
  core.String unit;
  /** The denominator of the unit price. */
  core.String value;

  ProductUnitPricingBaseMeasure();

  ProductUnitPricingBaseMeasure.fromJson(core.Map _json) {
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class ProductUnitPricingMeasure {
  /** The unit of the measure. */
  core.String unit;
  /** The measure of an item. */
  core.double value;

  ProductUnitPricingMeasure();

  ProductUnitPricingMeasure.fromJson(core.Map _json) {
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class ProductsCustomBatchRequest {
  /** The request entries to be processed in the batch. */
  core.List<ProductsCustomBatchRequestEntry> entries;

  ProductsCustomBatchRequest();

  ProductsCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new ProductsCustomBatchRequestEntry.fromJson(value)).toList();
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

/** A batch entry encoding a single non-batch products request. */
class ProductsCustomBatchRequestEntry {
  /** An entry ID, unique within the batch request. */
  core.int batchId;
  /** The ID of the managing account. */
  core.String merchantId;
  core.String method;
  /** The product to insert. Only required if the method is insert. */
  Product product;
  /**
   * The ID of the product to get or delete. Only defined if the method is get
   * or delete.
   */
  core.String productId;

  ProductsCustomBatchRequestEntry();

  ProductsCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("product")) {
      product = new Product.fromJson(_json["product"]);
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (product != null) {
      _json["product"] = (product).toJson();
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    return _json;
  }
}

class ProductsCustomBatchResponse {
  /** The result of the execution of the batch requests. */
  core.List<ProductsCustomBatchResponseEntry> entries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#productsCustomBatchResponse".
   */
  core.String kind;

  ProductsCustomBatchResponse();

  ProductsCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new ProductsCustomBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A batch entry encoding a single non-batch products response. */
class ProductsCustomBatchResponseEntry {
  /** The ID of the request entry this entry responds to. */
  core.int batchId;
  /** A list of errors defined if and only if the request failed. */
  Errors errors;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#productsCustomBatchResponseEntry".
   */
  core.String kind;
  /**
   * The inserted product. Only defined if the method is insert and if the
   * request was successful.
   */
  Product product;

  ProductsCustomBatchResponseEntry();

  ProductsCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("product")) {
      product = new Product.fromJson(_json["product"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (product != null) {
      _json["product"] = (product).toJson();
    }
    return _json;
  }
}

class ProductsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#productsListResponse".
   */
  core.String kind;
  /** The token for the retrieval of the next page of products. */
  core.String nextPageToken;
  core.List<Product> resources;

  ProductsListResponse();

  ProductsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new Product.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ProductstatusesCustomBatchRequest {
  /** The request entries to be processed in the batch. */
  core.List<ProductstatusesCustomBatchRequestEntry> entries;

  ProductstatusesCustomBatchRequest();

  ProductstatusesCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new ProductstatusesCustomBatchRequestEntry.fromJson(value)).toList();
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

/** A batch entry encoding a single non-batch productstatuses request. */
class ProductstatusesCustomBatchRequestEntry {
  /** An entry ID, unique within the batch request. */
  core.int batchId;
  /** The ID of the managing account. */
  core.String merchantId;
  core.String method;
  /** The ID of the product whose status to get. */
  core.String productId;

  ProductstatusesCustomBatchRequestEntry();

  ProductstatusesCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    return _json;
  }
}

class ProductstatusesCustomBatchResponse {
  /** The result of the execution of the batch requests. */
  core.List<ProductstatusesCustomBatchResponseEntry> entries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#productstatusesCustomBatchResponse".
   */
  core.String kind;

  ProductstatusesCustomBatchResponse();

  ProductstatusesCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new ProductstatusesCustomBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A batch entry encoding a single non-batch productstatuses response. */
class ProductstatusesCustomBatchResponseEntry {
  /** The ID of the request entry this entry responds to. */
  core.int batchId;
  /** A list of errors, if the request failed. */
  Errors errors;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#productstatusesCustomBatchResponseEntry".
   */
  core.String kind;
  /**
   * The requested product status. Only defined if the request was successful.
   */
  ProductStatus productStatus;

  ProductstatusesCustomBatchResponseEntry();

  ProductstatusesCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("productStatus")) {
      productStatus = new ProductStatus.fromJson(_json["productStatus"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (productStatus != null) {
      _json["productStatus"] = (productStatus).toJson();
    }
    return _json;
  }
}

class ProductstatusesListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#productstatusesListResponse".
   */
  core.String kind;
  /** The token for the retrieval of the next page of products statuses. */
  core.String nextPageToken;
  core.List<ProductStatus> resources;

  ProductstatusesListResponse();

  ProductstatusesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new ProductStatus.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class RateGroup {
  /**
   * A list of shipping labels defining the products to which this rate group
   * applies to. This is a disjunction: only one of the labels has to match for
   * the rate group to apply. May only be empty for the last rate group of a
   * service. Required.
   */
  core.List<core.String> applicableShippingLabels;
  /**
   * A list of carrier rates that can be referred to by mainTable or
   * singleValue.
   */
  core.List<CarrierRate> carrierRates;
  /**
   * A table defining the rate group, when singleValue is not expressive enough.
   * Can only be set if singleValue is not set.
   */
  Table mainTable;
  /**
   * The value of the rate group (e.g. flat rate $10). Can only be set if
   * mainTable and subtables are not set.
   */
  Value singleValue;
  /**
   * A list of subtables referred to by mainTable. Can only be set if mainTable
   * is set.
   */
  core.List<Table> subtables;

  RateGroup();

  RateGroup.fromJson(core.Map _json) {
    if (_json.containsKey("applicableShippingLabels")) {
      applicableShippingLabels = _json["applicableShippingLabels"];
    }
    if (_json.containsKey("carrierRates")) {
      carrierRates = _json["carrierRates"].map((value) => new CarrierRate.fromJson(value)).toList();
    }
    if (_json.containsKey("mainTable")) {
      mainTable = new Table.fromJson(_json["mainTable"]);
    }
    if (_json.containsKey("singleValue")) {
      singleValue = new Value.fromJson(_json["singleValue"]);
    }
    if (_json.containsKey("subtables")) {
      subtables = _json["subtables"].map((value) => new Table.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (applicableShippingLabels != null) {
      _json["applicableShippingLabels"] = applicableShippingLabels;
    }
    if (carrierRates != null) {
      _json["carrierRates"] = carrierRates.map((value) => (value).toJson()).toList();
    }
    if (mainTable != null) {
      _json["mainTable"] = (mainTable).toJson();
    }
    if (singleValue != null) {
      _json["singleValue"] = (singleValue).toJson();
    }
    if (subtables != null) {
      _json["subtables"] = subtables.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Row {
  /**
   * The list of cells that constitute the row. Must have the same length as
   * columnHeaders for two-dimensional tables, a length of 1 for one-dimensional
   * tables. Required.
   */
  core.List<Value> cells;

  Row();

  Row.fromJson(core.Map _json) {
    if (_json.containsKey("cells")) {
      cells = _json["cells"].map((value) => new Value.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cells != null) {
      _json["cells"] = cells.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Service {
  /**
   * A boolean exposing the active status of the shipping service. Required.
   */
  core.bool active;
  /**
   * The CLDR code of the currency to which this service applies. Must match
   * that of the prices in rate groups.
   */
  core.String currency;
  /**
   * The CLDR territory code of the country to which the service applies.
   * Required.
   */
  core.String deliveryCountry;
  /**
   * Time spent in various aspects from order to the delivery of the product.
   * Required.
   */
  DeliveryTime deliveryTime;
  /**
   * Free-form name of the service. Must be unique within target account.
   * Required.
   */
  core.String name;
  /**
   * Shipping rate group definitions. Only the last one is allowed to have an
   * empty applicableShippingLabels, which means "everything else". The other
   * applicableShippingLabels must not overlap.
   */
  core.List<RateGroup> rateGroups;

  Service();

  Service.fromJson(core.Map _json) {
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("currency")) {
      currency = _json["currency"];
    }
    if (_json.containsKey("deliveryCountry")) {
      deliveryCountry = _json["deliveryCountry"];
    }
    if (_json.containsKey("deliveryTime")) {
      deliveryTime = new DeliveryTime.fromJson(_json["deliveryTime"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("rateGroups")) {
      rateGroups = _json["rateGroups"].map((value) => new RateGroup.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (active != null) {
      _json["active"] = active;
    }
    if (currency != null) {
      _json["currency"] = currency;
    }
    if (deliveryCountry != null) {
      _json["deliveryCountry"] = deliveryCountry;
    }
    if (deliveryTime != null) {
      _json["deliveryTime"] = (deliveryTime).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (rateGroups != null) {
      _json["rateGroups"] = rateGroups.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The merchant account's shipping settings. */
class ShippingSettings {
  /**
   * The ID of the account to which these account shipping settings belong.
   * Ignored upon update, always present in get request responses.
   */
  core.String accountId;
  /**
   * A list of postal code groups that can be referred to in services. Optional.
   */
  core.List<PostalCodeGroup> postalCodeGroups;
  /** The target account's list of services. Optional. */
  core.List<Service> services;

  ShippingSettings();

  ShippingSettings.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("postalCodeGroups")) {
      postalCodeGroups = _json["postalCodeGroups"].map((value) => new PostalCodeGroup.fromJson(value)).toList();
    }
    if (_json.containsKey("services")) {
      services = _json["services"].map((value) => new Service.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (postalCodeGroups != null) {
      _json["postalCodeGroups"] = postalCodeGroups.map((value) => (value).toJson()).toList();
    }
    if (services != null) {
      _json["services"] = services.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ShippingsettingsCustomBatchRequest {
  /** The request entries to be processed in the batch. */
  core.List<ShippingsettingsCustomBatchRequestEntry> entries;

  ShippingsettingsCustomBatchRequest();

  ShippingsettingsCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new ShippingsettingsCustomBatchRequestEntry.fromJson(value)).toList();
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

/** A batch entry encoding a single non-batch accountshipping request. */
class ShippingsettingsCustomBatchRequestEntry {
  /**
   * The ID of the account for which to get/update account shipping settings.
   */
  core.String accountId;
  /** An entry ID, unique within the batch request. */
  core.int batchId;
  /** The ID of the managing account. */
  core.String merchantId;
  core.String method;
  /**
   * The account shipping settings to update. Only defined if the method is
   * update.
   */
  ShippingSettings shippingSettings;

  ShippingsettingsCustomBatchRequestEntry();

  ShippingsettingsCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("shippingSettings")) {
      shippingSettings = new ShippingSettings.fromJson(_json["shippingSettings"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (shippingSettings != null) {
      _json["shippingSettings"] = (shippingSettings).toJson();
    }
    return _json;
  }
}

class ShippingsettingsCustomBatchResponse {
  /** The result of the execution of the batch requests. */
  core.List<ShippingsettingsCustomBatchResponseEntry> entries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#shippingsettingsCustomBatchResponse".
   */
  core.String kind;

  ShippingsettingsCustomBatchResponse();

  ShippingsettingsCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new ShippingsettingsCustomBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A batch entry encoding a single non-batch shipping settings response. */
class ShippingsettingsCustomBatchResponseEntry {
  /** The ID of the request entry to which this entry responds. */
  core.int batchId;
  /** A list of errors defined if, and only if, the request failed. */
  Errors errors;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#shippingsettingsCustomBatchResponseEntry".
   */
  core.String kind;
  /** The retrieved or updated account shipping settings. */
  ShippingSettings shippingSettings;

  ShippingsettingsCustomBatchResponseEntry();

  ShippingsettingsCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("shippingSettings")) {
      shippingSettings = new ShippingSettings.fromJson(_json["shippingSettings"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (shippingSettings != null) {
      _json["shippingSettings"] = (shippingSettings).toJson();
    }
    return _json;
  }
}

class ShippingsettingsGetSupportedCarriersResponse {
  /** A list of supported carriers. May be empty. */
  core.List<CarriersCarrier> carriers;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#shippingsettingsGetSupportedCarriersResponse".
   */
  core.String kind;

  ShippingsettingsGetSupportedCarriersResponse();

  ShippingsettingsGetSupportedCarriersResponse.fromJson(core.Map _json) {
    if (_json.containsKey("carriers")) {
      carriers = _json["carriers"].map((value) => new CarriersCarrier.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carriers != null) {
      _json["carriers"] = carriers.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class ShippingsettingsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#shippingsettingsListResponse".
   */
  core.String kind;
  /** The token for the retrieval of the next page of shipping settings. */
  core.String nextPageToken;
  core.List<ShippingSettings> resources;

  ShippingsettingsListResponse();

  ShippingsettingsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new ShippingSettings.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Table {
  /**
   * Headers of the table's columns. Optional: if not set then the table has
   * only one dimension.
   */
  Headers columnHeaders;
  /** Name of the table. Required for subtables, ignored for the main table. */
  core.String name;
  /** Headers of the table's rows. Required. */
  Headers rowHeaders;
  /**
   * The list of rows that constitute the table. Must have the same length as
   * rowHeaders. Required.
   */
  core.List<Row> rows;

  Table();

  Table.fromJson(core.Map _json) {
    if (_json.containsKey("columnHeaders")) {
      columnHeaders = new Headers.fromJson(_json["columnHeaders"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("rowHeaders")) {
      rowHeaders = new Headers.fromJson(_json["rowHeaders"]);
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"].map((value) => new Row.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnHeaders != null) {
      _json["columnHeaders"] = (columnHeaders).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (rowHeaders != null) {
      _json["rowHeaders"] = (rowHeaders).toJson();
    }
    if (rows != null) {
      _json["rows"] = rows.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class TestOrder {
  /** The details of the customer who placed the order. */
  TestOrderCustomer customer;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#testOrder".
   */
  core.String kind;
  /** Line items that are ordered. At least one line item must be provided. */
  core.List<TestOrderLineItem> lineItems;
  /** The details of the payment method. */
  TestOrderPaymentMethod paymentMethod;
  /**
   * Identifier of one of the predefined delivery addresses for the delivery.
   */
  core.String predefinedDeliveryAddress;
  /**
   * The details of the merchant provided promotions applied to the order. More
   * details about the program are  here.
   */
  core.List<OrderPromotion> promotions;
  /** The total cost of shipping for all items. */
  Price shippingCost;
  /** The tax for the total shipping cost. */
  Price shippingCostTax;
  /** The requested shipping option. */
  core.String shippingOption;

  TestOrder();

  TestOrder.fromJson(core.Map _json) {
    if (_json.containsKey("customer")) {
      customer = new TestOrderCustomer.fromJson(_json["customer"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"].map((value) => new TestOrderLineItem.fromJson(value)).toList();
    }
    if (_json.containsKey("paymentMethod")) {
      paymentMethod = new TestOrderPaymentMethod.fromJson(_json["paymentMethod"]);
    }
    if (_json.containsKey("predefinedDeliveryAddress")) {
      predefinedDeliveryAddress = _json["predefinedDeliveryAddress"];
    }
    if (_json.containsKey("promotions")) {
      promotions = _json["promotions"].map((value) => new OrderPromotion.fromJson(value)).toList();
    }
    if (_json.containsKey("shippingCost")) {
      shippingCost = new Price.fromJson(_json["shippingCost"]);
    }
    if (_json.containsKey("shippingCostTax")) {
      shippingCostTax = new Price.fromJson(_json["shippingCostTax"]);
    }
    if (_json.containsKey("shippingOption")) {
      shippingOption = _json["shippingOption"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (customer != null) {
      _json["customer"] = (customer).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (paymentMethod != null) {
      _json["paymentMethod"] = (paymentMethod).toJson();
    }
    if (predefinedDeliveryAddress != null) {
      _json["predefinedDeliveryAddress"] = predefinedDeliveryAddress;
    }
    if (promotions != null) {
      _json["promotions"] = promotions.map((value) => (value).toJson()).toList();
    }
    if (shippingCost != null) {
      _json["shippingCost"] = (shippingCost).toJson();
    }
    if (shippingCostTax != null) {
      _json["shippingCostTax"] = (shippingCostTax).toJson();
    }
    if (shippingOption != null) {
      _json["shippingOption"] = shippingOption;
    }
    return _json;
  }
}

class TestOrderCustomer {
  /** Email address of the customer. */
  core.String email;
  /**
   * If set, this indicates the user explicitly chose to opt in or out of
   * providing marketing rights to the merchant. If unset, this indicates the
   * user has already made this choice in a previous purchase, and was thus not
   * shown the marketing right opt in/out checkbox during the checkout flow.
   * Optional.
   */
  core.bool explicitMarketingPreference;
  /** Full name of the customer. */
  core.String fullName;

  TestOrderCustomer();

  TestOrderCustomer.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("explicitMarketingPreference")) {
      explicitMarketingPreference = _json["explicitMarketingPreference"];
    }
    if (_json.containsKey("fullName")) {
      fullName = _json["fullName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (email != null) {
      _json["email"] = email;
    }
    if (explicitMarketingPreference != null) {
      _json["explicitMarketingPreference"] = explicitMarketingPreference;
    }
    if (fullName != null) {
      _json["fullName"] = fullName;
    }
    return _json;
  }
}

class TestOrderLineItem {
  /** Product data from the time of the order placement. */
  TestOrderLineItemProduct product;
  /** Number of items ordered. */
  core.int quantityOrdered;
  /** Details of the return policy for the line item. */
  OrderLineItemReturnInfo returnInfo;
  /** Details of the requested shipping for the line item. */
  OrderLineItemShippingDetails shippingDetails;
  /** Unit tax for the line item. */
  Price unitTax;

  TestOrderLineItem();

  TestOrderLineItem.fromJson(core.Map _json) {
    if (_json.containsKey("product")) {
      product = new TestOrderLineItemProduct.fromJson(_json["product"]);
    }
    if (_json.containsKey("quantityOrdered")) {
      quantityOrdered = _json["quantityOrdered"];
    }
    if (_json.containsKey("returnInfo")) {
      returnInfo = new OrderLineItemReturnInfo.fromJson(_json["returnInfo"]);
    }
    if (_json.containsKey("shippingDetails")) {
      shippingDetails = new OrderLineItemShippingDetails.fromJson(_json["shippingDetails"]);
    }
    if (_json.containsKey("unitTax")) {
      unitTax = new Price.fromJson(_json["unitTax"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (product != null) {
      _json["product"] = (product).toJson();
    }
    if (quantityOrdered != null) {
      _json["quantityOrdered"] = quantityOrdered;
    }
    if (returnInfo != null) {
      _json["returnInfo"] = (returnInfo).toJson();
    }
    if (shippingDetails != null) {
      _json["shippingDetails"] = (shippingDetails).toJson();
    }
    if (unitTax != null) {
      _json["unitTax"] = (unitTax).toJson();
    }
    return _json;
  }
}

class TestOrderLineItemProduct {
  /** Brand of the item. */
  core.String brand;
  /** The item's channel. */
  core.String channel;
  /** Condition or state of the item. */
  core.String condition;
  /** The two-letter ISO 639-1 language code for the item. */
  core.String contentLanguage;
  /** Global Trade Item Number (GTIN) of the item. Optional. */
  core.String gtin;
  /** URL of an image of the item. */
  core.String imageLink;
  /** Shared identifier for all variants of the same product. Optional. */
  core.String itemGroupId;
  /** Manufacturer Part Number (MPN) of the item. Optional. */
  core.String mpn;
  /** An identifier of the item. */
  core.String offerId;
  /** The price for the product. */
  Price price;
  /** The CLDR territory code of the target country of the product. */
  core.String targetCountry;
  /** The title of the product. */
  core.String title;
  /** Variant attributes for the item. Optional. */
  core.List<OrderLineItemProductVariantAttribute> variantAttributes;

  TestOrderLineItemProduct();

  TestOrderLineItemProduct.fromJson(core.Map _json) {
    if (_json.containsKey("brand")) {
      brand = _json["brand"];
    }
    if (_json.containsKey("channel")) {
      channel = _json["channel"];
    }
    if (_json.containsKey("condition")) {
      condition = _json["condition"];
    }
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("imageLink")) {
      imageLink = _json["imageLink"];
    }
    if (_json.containsKey("itemGroupId")) {
      itemGroupId = _json["itemGroupId"];
    }
    if (_json.containsKey("mpn")) {
      mpn = _json["mpn"];
    }
    if (_json.containsKey("offerId")) {
      offerId = _json["offerId"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("variantAttributes")) {
      variantAttributes = _json["variantAttributes"].map((value) => new OrderLineItemProductVariantAttribute.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (brand != null) {
      _json["brand"] = brand;
    }
    if (channel != null) {
      _json["channel"] = channel;
    }
    if (condition != null) {
      _json["condition"] = condition;
    }
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (imageLink != null) {
      _json["imageLink"] = imageLink;
    }
    if (itemGroupId != null) {
      _json["itemGroupId"] = itemGroupId;
    }
    if (mpn != null) {
      _json["mpn"] = mpn;
    }
    if (offerId != null) {
      _json["offerId"] = offerId;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (variantAttributes != null) {
      _json["variantAttributes"] = variantAttributes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class TestOrderPaymentMethod {
  /** The card expiration month (January = 1, February = 2 etc.). */
  core.int expirationMonth;
  /** The card expiration year (4-digit, e.g. 2015). */
  core.int expirationYear;
  /** The last four digits of the card number. */
  core.String lastFourDigits;
  /** The billing address. */
  core.String predefinedBillingAddress;
  /**
   * The type of instrument. Note that real orders might have different values
   * than the four values accepted by createTestOrder.
   */
  core.String type;

  TestOrderPaymentMethod();

  TestOrderPaymentMethod.fromJson(core.Map _json) {
    if (_json.containsKey("expirationMonth")) {
      expirationMonth = _json["expirationMonth"];
    }
    if (_json.containsKey("expirationYear")) {
      expirationYear = _json["expirationYear"];
    }
    if (_json.containsKey("lastFourDigits")) {
      lastFourDigits = _json["lastFourDigits"];
    }
    if (_json.containsKey("predefinedBillingAddress")) {
      predefinedBillingAddress = _json["predefinedBillingAddress"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (expirationMonth != null) {
      _json["expirationMonth"] = expirationMonth;
    }
    if (expirationYear != null) {
      _json["expirationYear"] = expirationYear;
    }
    if (lastFourDigits != null) {
      _json["lastFourDigits"] = lastFourDigits;
    }
    if (predefinedBillingAddress != null) {
      _json["predefinedBillingAddress"] = predefinedBillingAddress;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * The single value of a rate group or the value of a rate group table's cell.
 * Exactly one of noShipping, flatRate, pricePercentage, carrierRateName,
 * subtableName must be set.
 */
class Value {
  /**
   * The name of a carrier rate referring to a carrier rate defined in the same
   * rate group. Can only be set if all other fields are not set.
   */
  core.String carrierRateName;
  /** A flat rate. Can only be set if all other fields are not set. */
  Price flatRate;
  /**
   * If true, then the product can't ship. Must be true when set, can only be
   * set if all other fields are not set.
   */
  core.bool noShipping;
  /**
   * A percentage of the price represented as a number in decimal notation
   * (e.g., "5.4"). Can only be set if all other fields are not set.
   */
  core.String pricePercentage;
  /**
   * The name of a subtable. Can only be set in table cells (i.e., not for
   * single values), and only if all other fields are not set.
   */
  core.String subtableName;

  Value();

  Value.fromJson(core.Map _json) {
    if (_json.containsKey("carrierRateName")) {
      carrierRateName = _json["carrierRateName"];
    }
    if (_json.containsKey("flatRate")) {
      flatRate = new Price.fromJson(_json["flatRate"]);
    }
    if (_json.containsKey("noShipping")) {
      noShipping = _json["noShipping"];
    }
    if (_json.containsKey("pricePercentage")) {
      pricePercentage = _json["pricePercentage"];
    }
    if (_json.containsKey("subtableName")) {
      subtableName = _json["subtableName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrierRateName != null) {
      _json["carrierRateName"] = carrierRateName;
    }
    if (flatRate != null) {
      _json["flatRate"] = (flatRate).toJson();
    }
    if (noShipping != null) {
      _json["noShipping"] = noShipping;
    }
    if (pricePercentage != null) {
      _json["pricePercentage"] = pricePercentage;
    }
    if (subtableName != null) {
      _json["subtableName"] = subtableName;
    }
    return _json;
  }
}

class Weight {
  /** The weight unit. */
  core.String unit;
  /** The weight represented as a number. */
  core.String value;

  Weight();

  Weight.fromJson(core.Map _json) {
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}
