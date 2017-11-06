// This is a generated file (see the discoveryapis_generator project).

library googleapis.adexchangebuyer.v1_3;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client adexchangebuyer/v1.3';

/**
 * Accesses your bidding-account information, submits creatives for validation,
 * finds available direct deals, and retrieves performance reports.
 */
class AdexchangebuyerApi {
  /** Manage your Ad Exchange buyer account configuration */
  static const AdexchangeBuyerScope = "https://www.googleapis.com/auth/adexchange.buyer";


  final commons.ApiRequester _requester;

  AccountsResourceApi get accounts => new AccountsResourceApi(_requester);
  BillingInfoResourceApi get billingInfo => new BillingInfoResourceApi(_requester);
  BudgetResourceApi get budget => new BudgetResourceApi(_requester);
  CreativesResourceApi get creatives => new CreativesResourceApi(_requester);
  DirectDealsResourceApi get directDeals => new DirectDealsResourceApi(_requester);
  PerformanceReportResourceApi get performanceReport => new PerformanceReportResourceApi(_requester);
  PretargetingConfigResourceApi get pretargetingConfig => new PretargetingConfigResourceApi(_requester);

  AdexchangebuyerApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "adexchangebuyer/v1.3/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AccountsResourceApi {
  final commons.ApiRequester _requester;

  AccountsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one account by ID.
   *
   * Request parameters:
   *
   * [id] - The account id
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> get(core.int id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$id');

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
   * Retrieves the authenticated user's list of accounts.
   *
   * Request parameters:
   *
   * Completes with a [AccountsList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountsList> list() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'accounts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountsList.fromJson(data));
  }

  /**
   * Updates an existing account. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [id] - The account id
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> patch(Account request, core.int id) {
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

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$id');

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
   * Updates an existing account.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [id] - The account id
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> update(Account request, core.int id) {
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

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$id');

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


class BillingInfoResourceApi {
  final commons.ApiRequester _requester;

  BillingInfoResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns the billing information for one account specified by account ID.
   *
   * Request parameters:
   *
   * [accountId] - The account id.
   *
   * Completes with a [BillingInfo].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BillingInfo> get(core.int accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = 'billinginfo/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BillingInfo.fromJson(data));
  }

  /**
   * Retrieves a list of billing information for all accounts of the
   * authenticated user.
   *
   * Request parameters:
   *
   * Completes with a [BillingInfoList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BillingInfoList> list() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'billinginfo';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BillingInfoList.fromJson(data));
  }

}


class BudgetResourceApi {
  final commons.ApiRequester _requester;

  BudgetResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns the budget information for the adgroup specified by the accountId
   * and billingId.
   *
   * Request parameters:
   *
   * [accountId] - The account id to get the budget information for.
   *
   * [billingId] - The billing id to get the budget information for.
   *
   * Completes with a [Budget].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Budget> get(core.String accountId, core.String billingId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (billingId == null) {
      throw new core.ArgumentError("Parameter billingId is required.");
    }

    _url = 'billinginfo/' + commons.Escaper.ecapeVariable('$accountId') + '/' + commons.Escaper.ecapeVariable('$billingId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Budget.fromJson(data));
  }

  /**
   * Updates the budget amount for the budget of the adgroup specified by the
   * accountId and billingId, with the budget amount in the request. This method
   * supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - The account id associated with the budget being updated.
   *
   * [billingId] - The billing id associated with the budget being updated.
   *
   * Completes with a [Budget].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Budget> patch(Budget request, core.String accountId, core.String billingId) {
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
    if (billingId == null) {
      throw new core.ArgumentError("Parameter billingId is required.");
    }

    _url = 'billinginfo/' + commons.Escaper.ecapeVariable('$accountId') + '/' + commons.Escaper.ecapeVariable('$billingId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Budget.fromJson(data));
  }

  /**
   * Updates the budget amount for the budget of the adgroup specified by the
   * accountId and billingId, with the budget amount in the request.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - The account id associated with the budget being updated.
   *
   * [billingId] - The billing id associated with the budget being updated.
   *
   * Completes with a [Budget].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Budget> update(Budget request, core.String accountId, core.String billingId) {
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
    if (billingId == null) {
      throw new core.ArgumentError("Parameter billingId is required.");
    }

    _url = 'billinginfo/' + commons.Escaper.ecapeVariable('$accountId') + '/' + commons.Escaper.ecapeVariable('$billingId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Budget.fromJson(data));
  }

}


class CreativesResourceApi {
  final commons.ApiRequester _requester;

  CreativesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the status for a single creative. A creative will be available 30-40
   * minutes after submission.
   *
   * Request parameters:
   *
   * [accountId] - The id for the account that will serve this creative.
   *
   * [buyerCreativeId] - The buyer-specific id for this creative.
   *
   * Completes with a [Creative].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Creative> get(core.int accountId, core.String buyerCreativeId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (buyerCreativeId == null) {
      throw new core.ArgumentError("Parameter buyerCreativeId is required.");
    }

    _url = 'creatives/' + commons.Escaper.ecapeVariable('$accountId') + '/' + commons.Escaper.ecapeVariable('$buyerCreativeId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Creative.fromJson(data));
  }

  /**
   * Submit a new creative.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Creative].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Creative> insert(Creative request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'creatives';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Creative.fromJson(data));
  }

  /**
   * Retrieves a list of the authenticated user's active creatives. A creative
   * will be available 30-40 minutes after submission.
   *
   * Request parameters:
   *
   * [accountId] - When specified, only creatives for the given account ids are
   * returned.
   *
   * [buyerCreativeId] - When specified, only creatives for the given buyer
   * creative ids are returned.
   *
   * [maxResults] - Maximum number of entries returned on one result page. If
   * not set, the default is 100. Optional.
   * Value must be between "1" and "1000".
   *
   * [pageToken] - A continuation token, used to page through ad clients. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response. Optional.
   *
   * [statusFilter] - When specified, only creatives having the given status are
   * returned.
   * Possible string values are:
   * - "approved" : Creatives which have been approved.
   * - "disapproved" : Creatives which have been disapproved.
   * - "not_checked" : Creatives whose status is not yet checked.
   *
   * Completes with a [CreativesList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativesList> list({core.List<core.int> accountId, core.List<core.String> buyerCreativeId, core.int maxResults, core.String pageToken, core.String statusFilter}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId != null) {
      _queryParams["accountId"] = accountId.map((item) => "${item}").toList();
    }
    if (buyerCreativeId != null) {
      _queryParams["buyerCreativeId"] = buyerCreativeId;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (statusFilter != null) {
      _queryParams["statusFilter"] = [statusFilter];
    }

    _url = 'creatives';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativesList.fromJson(data));
  }

}


class DirectDealsResourceApi {
  final commons.ApiRequester _requester;

  DirectDealsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one direct deal by ID.
   *
   * Request parameters:
   *
   * [id] - The direct deal id
   *
   * Completes with a [DirectDeal].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DirectDeal> get(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'directdeals/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DirectDeal.fromJson(data));
  }

  /**
   * Retrieves the authenticated user's list of direct deals.
   *
   * Request parameters:
   *
   * Completes with a [DirectDealsList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DirectDealsList> list() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'directdeals';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DirectDealsList.fromJson(data));
  }

}


class PerformanceReportResourceApi {
  final commons.ApiRequester _requester;

  PerformanceReportResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves the authenticated user's list of performance metrics.
   *
   * Request parameters:
   *
   * [accountId] - The account id to get the reports.
   *
   * [endDateTime] - The end time of the report in ISO 8601 timestamp format
   * using UTC.
   *
   * [startDateTime] - The start time of the report in ISO 8601 timestamp format
   * using UTC.
   *
   * [maxResults] - Maximum number of entries returned on one result page. If
   * not set, the default is 100. Optional.
   * Value must be between "1" and "1000".
   *
   * [pageToken] - A continuation token, used to page through performance
   * reports. To retrieve the next page, set this parameter to the value of
   * "nextPageToken" from the previous response. Optional.
   *
   * Completes with a [PerformanceReportList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PerformanceReportList> list(core.String accountId, core.String endDateTime, core.String startDateTime, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    _queryParams["accountId"] = [accountId];
    if (endDateTime == null) {
      throw new core.ArgumentError("Parameter endDateTime is required.");
    }
    _queryParams["endDateTime"] = [endDateTime];
    if (startDateTime == null) {
      throw new core.ArgumentError("Parameter startDateTime is required.");
    }
    _queryParams["startDateTime"] = [startDateTime];
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'performancereport';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PerformanceReportList.fromJson(data));
  }

}


class PretargetingConfigResourceApi {
  final commons.ApiRequester _requester;

  PretargetingConfigResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an existing pretargeting config.
   *
   * Request parameters:
   *
   * [accountId] - The account id to delete the pretargeting config for.
   *
   * [configId] - The specific id of the configuration to delete.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String accountId, core.String configId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (configId == null) {
      throw new core.ArgumentError("Parameter configId is required.");
    }

    _downloadOptions = null;

    _url = 'pretargetingconfigs/' + commons.Escaper.ecapeVariable('$accountId') + '/' + commons.Escaper.ecapeVariable('$configId');

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
   * Gets a specific pretargeting configuration
   *
   * Request parameters:
   *
   * [accountId] - The account id to get the pretargeting config for.
   *
   * [configId] - The specific id of the configuration to retrieve.
   *
   * Completes with a [PretargetingConfig].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PretargetingConfig> get(core.String accountId, core.String configId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (configId == null) {
      throw new core.ArgumentError("Parameter configId is required.");
    }

    _url = 'pretargetingconfigs/' + commons.Escaper.ecapeVariable('$accountId') + '/' + commons.Escaper.ecapeVariable('$configId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PretargetingConfig.fromJson(data));
  }

  /**
   * Inserts a new pretargeting configuration.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - The account id to insert the pretargeting config for.
   *
   * Completes with a [PretargetingConfig].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PretargetingConfig> insert(PretargetingConfig request, core.String accountId) {
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

    _url = 'pretargetingconfigs/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PretargetingConfig.fromJson(data));
  }

  /**
   * Retrieves a list of the authenticated user's pretargeting configurations.
   *
   * Request parameters:
   *
   * [accountId] - The account id to get the pretargeting configs for.
   *
   * Completes with a [PretargetingConfigList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PretargetingConfigList> list(core.String accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = 'pretargetingconfigs/' + commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PretargetingConfigList.fromJson(data));
  }

  /**
   * Updates an existing pretargeting config. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - The account id to update the pretargeting config for.
   *
   * [configId] - The specific id of the configuration to update.
   *
   * Completes with a [PretargetingConfig].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PretargetingConfig> patch(PretargetingConfig request, core.String accountId, core.String configId) {
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
    if (configId == null) {
      throw new core.ArgumentError("Parameter configId is required.");
    }

    _url = 'pretargetingconfigs/' + commons.Escaper.ecapeVariable('$accountId') + '/' + commons.Escaper.ecapeVariable('$configId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PretargetingConfig.fromJson(data));
  }

  /**
   * Updates an existing pretargeting config.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - The account id to update the pretargeting config for.
   *
   * [configId] - The specific id of the configuration to update.
   *
   * Completes with a [PretargetingConfig].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PretargetingConfig> update(PretargetingConfig request, core.String accountId, core.String configId) {
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
    if (configId == null) {
      throw new core.ArgumentError("Parameter configId is required.");
    }

    _url = 'pretargetingconfigs/' + commons.Escaper.ecapeVariable('$accountId') + '/' + commons.Escaper.ecapeVariable('$configId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PretargetingConfig.fromJson(data));
  }

}



class AccountBidderLocation {
  /** The maximum queries per second the Ad Exchange will send. */
  core.int maximumQps;
  /**
   * The geographical region the Ad Exchange should send requests from. Only
   * used by some quota systems, but always setting the value is recommended.
   * Allowed values:
   * - ASIA
   * - EUROPE
   * - US_EAST
   * - US_WEST
   */
  core.String region;
  /** The URL to which the Ad Exchange will send bid requests. */
  core.String url;

  AccountBidderLocation();

  AccountBidderLocation.fromJson(core.Map _json) {
    if (_json.containsKey("maximumQps")) {
      maximumQps = _json["maximumQps"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (maximumQps != null) {
      _json["maximumQps"] = maximumQps;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Configuration data for an Ad Exchange buyer account. */
class Account {
  /** Your bidder locations that have distinct URLs. */
  core.List<AccountBidderLocation> bidderLocation;
  /**
   * The nid parameter value used in cookie match requests. Please contact your
   * technical account manager if you need to change this.
   */
  core.String cookieMatchingNid;
  /** The base URL used in cookie match requests. */
  core.String cookieMatchingUrl;
  /** Account id. */
  core.int id;
  /** Resource type. */
  core.String kind;
  /**
   * The maximum number of active creatives that an account can have, where a
   * creative is active if it was inserted or bid with in the last 30 days.
   * Please contact your technical account manager if you need to change this.
   */
  core.int maximumActiveCreatives;
  /**
   * The sum of all bidderLocation.maximumQps values cannot exceed this. Please
   * contact your technical account manager if you need to change this.
   */
  core.int maximumTotalQps;
  /**
   * The number of creatives that this account inserted or bid with in the last
   * 30 days.
   */
  core.int numberActiveCreatives;

  Account();

  Account.fromJson(core.Map _json) {
    if (_json.containsKey("bidderLocation")) {
      bidderLocation = _json["bidderLocation"].map((value) => new AccountBidderLocation.fromJson(value)).toList();
    }
    if (_json.containsKey("cookieMatchingNid")) {
      cookieMatchingNid = _json["cookieMatchingNid"];
    }
    if (_json.containsKey("cookieMatchingUrl")) {
      cookieMatchingUrl = _json["cookieMatchingUrl"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("maximumActiveCreatives")) {
      maximumActiveCreatives = _json["maximumActiveCreatives"];
    }
    if (_json.containsKey("maximumTotalQps")) {
      maximumTotalQps = _json["maximumTotalQps"];
    }
    if (_json.containsKey("numberActiveCreatives")) {
      numberActiveCreatives = _json["numberActiveCreatives"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bidderLocation != null) {
      _json["bidderLocation"] = bidderLocation.map((value) => (value).toJson()).toList();
    }
    if (cookieMatchingNid != null) {
      _json["cookieMatchingNid"] = cookieMatchingNid;
    }
    if (cookieMatchingUrl != null) {
      _json["cookieMatchingUrl"] = cookieMatchingUrl;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (maximumActiveCreatives != null) {
      _json["maximumActiveCreatives"] = maximumActiveCreatives;
    }
    if (maximumTotalQps != null) {
      _json["maximumTotalQps"] = maximumTotalQps;
    }
    if (numberActiveCreatives != null) {
      _json["numberActiveCreatives"] = numberActiveCreatives;
    }
    return _json;
  }
}

/**
 * An account feed lists Ad Exchange buyer accounts that the user has access to.
 * Each entry in the feed corresponds to a single buyer account.
 */
class AccountsList {
  /** A list of accounts. */
  core.List<Account> items;
  /** Resource type. */
  core.String kind;

  AccountsList();

  AccountsList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Account.fromJson(value)).toList();
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

/** The configuration data for an Ad Exchange billing info. */
class BillingInfo {
  /** Account id. */
  core.int accountId;
  /** Account name. */
  core.String accountName;
  /**
   * A list of adgroup IDs associated with this particular account. These IDs
   * may show up as part of a realtime bidding BidRequest, which indicates a bid
   * request for this account.
   */
  core.List<core.String> billingId;
  /** Resource type. */
  core.String kind;

  BillingInfo();

  BillingInfo.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("accountName")) {
      accountName = _json["accountName"];
    }
    if (_json.containsKey("billingId")) {
      billingId = _json["billingId"];
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
    if (accountName != null) {
      _json["accountName"] = accountName;
    }
    if (billingId != null) {
      _json["billingId"] = billingId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/**
 * A billing info feed lists Billing Info the Ad Exchange buyer account has
 * access to. Each entry in the feed corresponds to a single billing info.
 */
class BillingInfoList {
  /** A list of billing info relevant for your account. */
  core.List<BillingInfo> items;
  /** Resource type. */
  core.String kind;

  BillingInfoList();

  BillingInfoList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new BillingInfo.fromJson(value)).toList();
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

/** The configuration data for Ad Exchange RTB - Budget API. */
class Budget {
  /** The id of the account. This is required for get and update requests. */
  core.String accountId;
  /**
   * The billing id to determine which adgroup to provide budget information
   * for. This is required for get and update requests.
   */
  core.String billingId;
  /**
   * The daily budget amount in unit amount of the account currency to apply for
   * the billingId provided. This is required for update requests.
   */
  core.String budgetAmount;
  /** The currency code for the buyer. This cannot be altered here. */
  core.String currencyCode;
  /** The unique id that describes this item. */
  core.String id;
  /** The kind of the resource, i.e. "adexchangebuyer#budget". */
  core.String kind;

  Budget();

  Budget.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("billingId")) {
      billingId = _json["billingId"];
    }
    if (_json.containsKey("budgetAmount")) {
      budgetAmount = _json["budgetAmount"];
    }
    if (_json.containsKey("currencyCode")) {
      currencyCode = _json["currencyCode"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
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
    if (billingId != null) {
      _json["billingId"] = billingId;
    }
    if (budgetAmount != null) {
      _json["budgetAmount"] = budgetAmount;
    }
    if (currencyCode != null) {
      _json["currencyCode"] = currencyCode;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class CreativeCorrections {
  /** Additional details about the correction. */
  core.List<core.String> details;
  /** The type of correction that was applied to the creative. */
  core.String reason;

  CreativeCorrections();

  CreativeCorrections.fromJson(core.Map _json) {
    if (_json.containsKey("details")) {
      details = _json["details"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (details != null) {
      _json["details"] = details;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    return _json;
  }
}

class CreativeDisapprovalReasons {
  /** Additional details about the reason for disapproval. */
  core.List<core.String> details;
  /** The categorized reason for disapproval. */
  core.String reason;

  CreativeDisapprovalReasons();

  CreativeDisapprovalReasons.fromJson(core.Map _json) {
    if (_json.containsKey("details")) {
      details = _json["details"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (details != null) {
      _json["details"] = details;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    return _json;
  }
}

class CreativeFilteringReasonsReasons {
  /**
   * The number of times the creative was filtered for the status. The count is
   * aggregated across all publishers on the exchange.
   */
  core.String filteringCount;
  /**
   * The filtering status code. Please refer to the creative-status-codes.txt
   * file for different statuses.
   */
  core.int filteringStatus;

  CreativeFilteringReasonsReasons();

  CreativeFilteringReasonsReasons.fromJson(core.Map _json) {
    if (_json.containsKey("filteringCount")) {
      filteringCount = _json["filteringCount"];
    }
    if (_json.containsKey("filteringStatus")) {
      filteringStatus = _json["filteringStatus"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (filteringCount != null) {
      _json["filteringCount"] = filteringCount;
    }
    if (filteringStatus != null) {
      _json["filteringStatus"] = filteringStatus;
    }
    return _json;
  }
}

/**
 * The filtering reasons for the creative. Read-only. This field should not be
 * set in requests.
 */
class CreativeFilteringReasons {
  /**
   * The date in ISO 8601 format for the data. The data is collected from
   * 00:00:00 to 23:59:59 in PST.
   */
  core.String date;
  /** The filtering reasons. */
  core.List<CreativeFilteringReasonsReasons> reasons;

  CreativeFilteringReasons();

  CreativeFilteringReasons.fromJson(core.Map _json) {
    if (_json.containsKey("date")) {
      date = _json["date"];
    }
    if (_json.containsKey("reasons")) {
      reasons = _json["reasons"].map((value) => new CreativeFilteringReasonsReasons.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (date != null) {
      _json["date"] = date;
    }
    if (reasons != null) {
      _json["reasons"] = reasons.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The app icon, for app download ads. */
class CreativeNativeAdAppIcon {
  core.int height;
  core.String url;
  core.int width;

  CreativeNativeAdAppIcon();

  CreativeNativeAdAppIcon.fromJson(core.Map _json) {
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

  core.Map toJson() {
    var _json = new core.Map();
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

/** A large image. */
class CreativeNativeAdImage {
  core.int height;
  core.String url;
  core.int width;

  CreativeNativeAdImage();

  CreativeNativeAdImage.fromJson(core.Map _json) {
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

  core.Map toJson() {
    var _json = new core.Map();
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

/** A smaller image, for the advertiser logo. */
class CreativeNativeAdLogo {
  core.int height;
  core.String url;
  core.int width;

  CreativeNativeAdLogo();

  CreativeNativeAdLogo.fromJson(core.Map _json) {
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

  core.Map toJson() {
    var _json = new core.Map();
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

/** If nativeAd is set, HTMLSnippet and videoURL should not be set. */
class CreativeNativeAd {
  core.String advertiser;
  /** The app icon, for app download ads. */
  CreativeNativeAdAppIcon appIcon;
  /** A long description of the ad. */
  core.String body;
  /** A label for the button that the user is supposed to click. */
  core.String callToAction;
  /** The URL to use for click tracking. */
  core.String clickTrackingUrl;
  /** A short title for the ad. */
  core.String headline;
  /** A large image. */
  CreativeNativeAdImage image;
  /** The URLs are called when the impression is rendered. */
  core.List<core.String> impressionTrackingUrl;
  /** A smaller image, for the advertiser logo. */
  CreativeNativeAdLogo logo;
  /** The price of the promoted app including the currency info. */
  core.String price;
  /** The app rating in the app store. Must be in the range [0-5]. */
  core.double starRating;
  /** The URL to the app store to purchase/download the promoted app. */
  core.String store;

  CreativeNativeAd();

  CreativeNativeAd.fromJson(core.Map _json) {
    if (_json.containsKey("advertiser")) {
      advertiser = _json["advertiser"];
    }
    if (_json.containsKey("appIcon")) {
      appIcon = new CreativeNativeAdAppIcon.fromJson(_json["appIcon"]);
    }
    if (_json.containsKey("body")) {
      body = _json["body"];
    }
    if (_json.containsKey("callToAction")) {
      callToAction = _json["callToAction"];
    }
    if (_json.containsKey("clickTrackingUrl")) {
      clickTrackingUrl = _json["clickTrackingUrl"];
    }
    if (_json.containsKey("headline")) {
      headline = _json["headline"];
    }
    if (_json.containsKey("image")) {
      image = new CreativeNativeAdImage.fromJson(_json["image"]);
    }
    if (_json.containsKey("impressionTrackingUrl")) {
      impressionTrackingUrl = _json["impressionTrackingUrl"];
    }
    if (_json.containsKey("logo")) {
      logo = new CreativeNativeAdLogo.fromJson(_json["logo"]);
    }
    if (_json.containsKey("price")) {
      price = _json["price"];
    }
    if (_json.containsKey("starRating")) {
      starRating = _json["starRating"];
    }
    if (_json.containsKey("store")) {
      store = _json["store"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (advertiser != null) {
      _json["advertiser"] = advertiser;
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
    if (clickTrackingUrl != null) {
      _json["clickTrackingUrl"] = clickTrackingUrl;
    }
    if (headline != null) {
      _json["headline"] = headline;
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (impressionTrackingUrl != null) {
      _json["impressionTrackingUrl"] = impressionTrackingUrl;
    }
    if (logo != null) {
      _json["logo"] = (logo).toJson();
    }
    if (price != null) {
      _json["price"] = price;
    }
    if (starRating != null) {
      _json["starRating"] = starRating;
    }
    if (store != null) {
      _json["store"] = store;
    }
    return _json;
  }
}

/** A creative and its classification data. */
class Creative {
  /**
   * The HTML snippet that displays the ad when inserted in the web page. If
   * set, videoURL should not be set.
   */
  core.String HTMLSnippet;
  /** Account id. */
  core.int accountId;
  /**
   * Detected advertiser id, if any. Read-only. This field should not be set in
   * requests.
   */
  core.List<core.String> advertiserId;
  /** The name of the company being advertised in the creative. */
  core.String advertiserName;
  /** The agency id for this creative. */
  core.String agencyId;
  /**
   * The last upload timestamp of this creative if it was uploaded via API.
   * Read-only. The value of this field is generated, and will be ignored for
   * uploads. (formatted RFC 3339 timestamp).
   */
  core.DateTime apiUploadTimestamp;
  /** All attributes for the ads that may be shown from this snippet. */
  core.List<core.int> attribute;
  /** A buyer-specific id identifying the creative in this ad. */
  core.String buyerCreativeId;
  /** The set of destination urls for the snippet. */
  core.List<core.String> clickThroughUrl;
  /**
   * Shows any corrections that were applied to this creative. Read-only. This
   * field should not be set in requests.
   */
  core.List<CreativeCorrections> corrections;
  /**
   * The reasons for disapproval, if any. Note that not all disapproval reasons
   * may be categorized, so it is possible for the creative to have a status of
   * DISAPPROVED with an empty list for disapproval_reasons. In this case,
   * please reach out to your TAM to help debug the issue. Read-only. This field
   * should not be set in requests.
   */
  core.List<CreativeDisapprovalReasons> disapprovalReasons;
  /**
   * The filtering reasons for the creative. Read-only. This field should not be
   * set in requests.
   */
  CreativeFilteringReasons filteringReasons;
  /** Ad height. */
  core.int height;
  /** The set of urls to be called to record an impression. */
  core.List<core.String> impressionTrackingUrl;
  /** Resource type. */
  core.String kind;
  /** If nativeAd is set, HTMLSnippet and videoURL should not be set. */
  CreativeNativeAd nativeAd;
  /**
   * Detected product categories, if any. Read-only. This field should not be
   * set in requests.
   */
  core.List<core.int> productCategories;
  /**
   * All restricted categories for the ads that may be shown from this snippet.
   */
  core.List<core.int> restrictedCategories;
  /**
   * Detected sensitive categories, if any. Read-only. This field should not be
   * set in requests.
   */
  core.List<core.int> sensitiveCategories;
  /**
   * Creative serving status. Read-only. This field should not be set in
   * requests.
   */
  core.String status;
  /** All vendor types for the ads that may be shown from this snippet. */
  core.List<core.int> vendorType;
  /**
   * The version for this creative. Read-only. This field should not be set in
   * requests.
   */
  core.int version;
  /**
   * The URL to fetch a video ad. If set, HTMLSnippet and the nativeAd should
   * not be set.
   */
  core.String videoURL;
  /** Ad width. */
  core.int width;

  Creative();

  Creative.fromJson(core.Map _json) {
    if (_json.containsKey("HTMLSnippet")) {
      HTMLSnippet = _json["HTMLSnippet"];
    }
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserName")) {
      advertiserName = _json["advertiserName"];
    }
    if (_json.containsKey("agencyId")) {
      agencyId = _json["agencyId"];
    }
    if (_json.containsKey("apiUploadTimestamp")) {
      apiUploadTimestamp = core.DateTime.parse(_json["apiUploadTimestamp"]);
    }
    if (_json.containsKey("attribute")) {
      attribute = _json["attribute"];
    }
    if (_json.containsKey("buyerCreativeId")) {
      buyerCreativeId = _json["buyerCreativeId"];
    }
    if (_json.containsKey("clickThroughUrl")) {
      clickThroughUrl = _json["clickThroughUrl"];
    }
    if (_json.containsKey("corrections")) {
      corrections = _json["corrections"].map((value) => new CreativeCorrections.fromJson(value)).toList();
    }
    if (_json.containsKey("disapprovalReasons")) {
      disapprovalReasons = _json["disapprovalReasons"].map((value) => new CreativeDisapprovalReasons.fromJson(value)).toList();
    }
    if (_json.containsKey("filteringReasons")) {
      filteringReasons = new CreativeFilteringReasons.fromJson(_json["filteringReasons"]);
    }
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("impressionTrackingUrl")) {
      impressionTrackingUrl = _json["impressionTrackingUrl"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nativeAd")) {
      nativeAd = new CreativeNativeAd.fromJson(_json["nativeAd"]);
    }
    if (_json.containsKey("productCategories")) {
      productCategories = _json["productCategories"];
    }
    if (_json.containsKey("restrictedCategories")) {
      restrictedCategories = _json["restrictedCategories"];
    }
    if (_json.containsKey("sensitiveCategories")) {
      sensitiveCategories = _json["sensitiveCategories"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("vendorType")) {
      vendorType = _json["vendorType"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
    if (_json.containsKey("videoURL")) {
      videoURL = _json["videoURL"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (HTMLSnippet != null) {
      _json["HTMLSnippet"] = HTMLSnippet;
    }
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserName != null) {
      _json["advertiserName"] = advertiserName;
    }
    if (agencyId != null) {
      _json["agencyId"] = agencyId;
    }
    if (apiUploadTimestamp != null) {
      _json["apiUploadTimestamp"] = (apiUploadTimestamp).toIso8601String();
    }
    if (attribute != null) {
      _json["attribute"] = attribute;
    }
    if (buyerCreativeId != null) {
      _json["buyerCreativeId"] = buyerCreativeId;
    }
    if (clickThroughUrl != null) {
      _json["clickThroughUrl"] = clickThroughUrl;
    }
    if (corrections != null) {
      _json["corrections"] = corrections.map((value) => (value).toJson()).toList();
    }
    if (disapprovalReasons != null) {
      _json["disapprovalReasons"] = disapprovalReasons.map((value) => (value).toJson()).toList();
    }
    if (filteringReasons != null) {
      _json["filteringReasons"] = (filteringReasons).toJson();
    }
    if (height != null) {
      _json["height"] = height;
    }
    if (impressionTrackingUrl != null) {
      _json["impressionTrackingUrl"] = impressionTrackingUrl;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nativeAd != null) {
      _json["nativeAd"] = (nativeAd).toJson();
    }
    if (productCategories != null) {
      _json["productCategories"] = productCategories;
    }
    if (restrictedCategories != null) {
      _json["restrictedCategories"] = restrictedCategories;
    }
    if (sensitiveCategories != null) {
      _json["sensitiveCategories"] = sensitiveCategories;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (vendorType != null) {
      _json["vendorType"] = vendorType;
    }
    if (version != null) {
      _json["version"] = version;
    }
    if (videoURL != null) {
      _json["videoURL"] = videoURL;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/**
 * The creatives feed lists the active creatives for the Ad Exchange buyer
 * accounts that the user has access to. Each entry in the feed corresponds to a
 * single creative.
 */
class CreativesList {
  /** A list of creatives. */
  core.List<Creative> items;
  /** Resource type. */
  core.String kind;
  /**
   * Continuation token used to page through creatives. To retrieve the next
   * page of results, set the next request's "pageToken" value to this.
   */
  core.String nextPageToken;

  CreativesList();

  CreativesList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Creative.fromJson(value)).toList();
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

/** The configuration data for an Ad Exchange direct deal. */
class DirectDeal {
  /** The account id of the buyer this deal is for. */
  core.int accountId;
  /** The name of the advertiser this deal is for. */
  core.String advertiser;
  /** Whether the publisher for this deal is eligible for alcohol ads. */
  core.bool allowsAlcohol;
  /**
   * The account id that this deal was negotiated for. It is either the buyer or
   * the client that this deal was negotiated on behalf of.
   */
  core.String buyerAccountId;
  /**
   * The currency code that applies to the fixed_cpm value. If not set then
   * assumed to be USD.
   */
  core.String currencyCode;
  /**
   * The deal type such as programmatic reservation or fixed price and so on.
   */
  core.String dealTier;
  /**
   * End time for when this deal stops being active. If not set then this deal
   * is valid until manually disabled by the publisher. In seconds since the
   * epoch.
   */
  core.String endTime;
  /**
   * The fixed price for this direct deal. In cpm micros of currency according
   * to currency_code. If set, then this deal is eligible for the fixed price
   * tier of buying (highest priority, pay exactly the configured fixed price).
   */
  core.String fixedCpm;
  /** Deal id. */
  core.String id;
  /** Resource type. */
  core.String kind;
  /** Deal name. */
  core.String name;
  /**
   * The minimum price for this direct deal. In cpm micros of currency according
   * to currency_code. If set, then this deal is eligible for the private
   * exchange tier of buying (below fixed price priority, run as a second price
   * auction).
   */
  core.String privateExchangeMinCpm;
  /**
   * If true, the publisher has opted to have their blocks ignored when a
   * creative is bid with for this deal.
   */
  core.bool publisherBlocksOverriden;
  /** The name of the publisher offering this direct deal. */
  core.String sellerNetwork;
  /**
   * Start time for when this deal becomes active. If not set then this deal is
   * active immediately upon creation. In seconds since the epoch.
   */
  core.String startTime;

  DirectDeal();

  DirectDeal.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiser")) {
      advertiser = _json["advertiser"];
    }
    if (_json.containsKey("allowsAlcohol")) {
      allowsAlcohol = _json["allowsAlcohol"];
    }
    if (_json.containsKey("buyerAccountId")) {
      buyerAccountId = _json["buyerAccountId"];
    }
    if (_json.containsKey("currencyCode")) {
      currencyCode = _json["currencyCode"];
    }
    if (_json.containsKey("dealTier")) {
      dealTier = _json["dealTier"];
    }
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("fixedCpm")) {
      fixedCpm = _json["fixedCpm"];
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
    if (_json.containsKey("privateExchangeMinCpm")) {
      privateExchangeMinCpm = _json["privateExchangeMinCpm"];
    }
    if (_json.containsKey("publisherBlocksOverriden")) {
      publisherBlocksOverriden = _json["publisherBlocksOverriden"];
    }
    if (_json.containsKey("sellerNetwork")) {
      sellerNetwork = _json["sellerNetwork"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiser != null) {
      _json["advertiser"] = advertiser;
    }
    if (allowsAlcohol != null) {
      _json["allowsAlcohol"] = allowsAlcohol;
    }
    if (buyerAccountId != null) {
      _json["buyerAccountId"] = buyerAccountId;
    }
    if (currencyCode != null) {
      _json["currencyCode"] = currencyCode;
    }
    if (dealTier != null) {
      _json["dealTier"] = dealTier;
    }
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (fixedCpm != null) {
      _json["fixedCpm"] = fixedCpm;
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
    if (privateExchangeMinCpm != null) {
      _json["privateExchangeMinCpm"] = privateExchangeMinCpm;
    }
    if (publisherBlocksOverriden != null) {
      _json["publisherBlocksOverriden"] = publisherBlocksOverriden;
    }
    if (sellerNetwork != null) {
      _json["sellerNetwork"] = sellerNetwork;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

/**
 * A direct deals feed lists Direct Deals the Ad Exchange buyer account has
 * access to. This includes direct deals set up for the buyer account as well as
 * its merged stream seats.
 */
class DirectDealsList {
  /** A list of direct deals relevant for your account. */
  core.List<DirectDeal> directDeals;
  /** Resource type. */
  core.String kind;

  DirectDealsList();

  DirectDealsList.fromJson(core.Map _json) {
    if (_json.containsKey("directDeals")) {
      directDeals = _json["directDeals"].map((value) => new DirectDeal.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (directDeals != null) {
      _json["directDeals"] = directDeals.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** The configuration data for an Ad Exchange performance report list. */
class PerformanceReport {
  /** The number of bid responses with an ad. */
  core.double bidRate;
  /** The number of bid requests sent to your bidder. */
  core.double bidRequestRate;
  /**
   * Rate of various prefiltering statuses per match. Please refer to the
   * callout-status-codes.txt file for different statuses.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> calloutStatusRate;
  /**
   * Average QPS for cookie matcher operations.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> cookieMatcherStatusRate;
  /**
   * Rate of ads with a given status. Please refer to the
   * creative-status-codes.txt file for different statuses.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> creativeStatusRate;
  /**
   * The number of bid responses that were filtered due to a policy violation or
   * other errors.
   */
  core.double filteredBidRate;
  /**
   * Average QPS for hosted match operations.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> hostedMatchStatusRate;
  /** The number of potential queries based on your pretargeting settings. */
  core.double inventoryMatchRate;
  /** Resource type. */
  core.String kind;
  /**
   * The 50th percentile round trip latency(ms) as perceived from Google servers
   * for the duration period covered by the report.
   */
  core.double latency50thPercentile;
  /**
   * The 85th percentile round trip latency(ms) as perceived from Google servers
   * for the duration period covered by the report.
   */
  core.double latency85thPercentile;
  /**
   * The 95th percentile round trip latency(ms) as perceived from Google servers
   * for the duration period covered by the report.
   */
  core.double latency95thPercentile;
  /** Rate of various quota account statuses per quota check. */
  core.double noQuotaInRegion;
  /** Rate of various quota account statuses per quota check. */
  core.double outOfQuota;
  /** Average QPS for pixel match requests from clients. */
  core.double pixelMatchRequests;
  /** Average QPS for pixel match responses from clients. */
  core.double pixelMatchResponses;
  /** The configured quota limits for this account. */
  core.double quotaConfiguredLimit;
  /** The throttled quota limits for this account. */
  core.double quotaThrottledLimit;
  /** The trading location of this data. */
  core.String region;
  /**
   * The number of properly formed bid responses received by our servers within
   * the deadline.
   */
  core.double successfulRequestRate;
  /** The unix timestamp of the starting time of this performance data. */
  core.String timestamp;
  /**
   * The number of bid responses that were unsuccessful due to timeouts,
   * incorrect formatting, etc.
   */
  core.double unsuccessfulRequestRate;

  PerformanceReport();

  PerformanceReport.fromJson(core.Map _json) {
    if (_json.containsKey("bidRate")) {
      bidRate = _json["bidRate"];
    }
    if (_json.containsKey("bidRequestRate")) {
      bidRequestRate = _json["bidRequestRate"];
    }
    if (_json.containsKey("calloutStatusRate")) {
      calloutStatusRate = _json["calloutStatusRate"];
    }
    if (_json.containsKey("cookieMatcherStatusRate")) {
      cookieMatcherStatusRate = _json["cookieMatcherStatusRate"];
    }
    if (_json.containsKey("creativeStatusRate")) {
      creativeStatusRate = _json["creativeStatusRate"];
    }
    if (_json.containsKey("filteredBidRate")) {
      filteredBidRate = _json["filteredBidRate"];
    }
    if (_json.containsKey("hostedMatchStatusRate")) {
      hostedMatchStatusRate = _json["hostedMatchStatusRate"];
    }
    if (_json.containsKey("inventoryMatchRate")) {
      inventoryMatchRate = _json["inventoryMatchRate"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("latency50thPercentile")) {
      latency50thPercentile = _json["latency50thPercentile"];
    }
    if (_json.containsKey("latency85thPercentile")) {
      latency85thPercentile = _json["latency85thPercentile"];
    }
    if (_json.containsKey("latency95thPercentile")) {
      latency95thPercentile = _json["latency95thPercentile"];
    }
    if (_json.containsKey("noQuotaInRegion")) {
      noQuotaInRegion = _json["noQuotaInRegion"];
    }
    if (_json.containsKey("outOfQuota")) {
      outOfQuota = _json["outOfQuota"];
    }
    if (_json.containsKey("pixelMatchRequests")) {
      pixelMatchRequests = _json["pixelMatchRequests"];
    }
    if (_json.containsKey("pixelMatchResponses")) {
      pixelMatchResponses = _json["pixelMatchResponses"];
    }
    if (_json.containsKey("quotaConfiguredLimit")) {
      quotaConfiguredLimit = _json["quotaConfiguredLimit"];
    }
    if (_json.containsKey("quotaThrottledLimit")) {
      quotaThrottledLimit = _json["quotaThrottledLimit"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("successfulRequestRate")) {
      successfulRequestRate = _json["successfulRequestRate"];
    }
    if (_json.containsKey("timestamp")) {
      timestamp = _json["timestamp"];
    }
    if (_json.containsKey("unsuccessfulRequestRate")) {
      unsuccessfulRequestRate = _json["unsuccessfulRequestRate"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bidRate != null) {
      _json["bidRate"] = bidRate;
    }
    if (bidRequestRate != null) {
      _json["bidRequestRate"] = bidRequestRate;
    }
    if (calloutStatusRate != null) {
      _json["calloutStatusRate"] = calloutStatusRate;
    }
    if (cookieMatcherStatusRate != null) {
      _json["cookieMatcherStatusRate"] = cookieMatcherStatusRate;
    }
    if (creativeStatusRate != null) {
      _json["creativeStatusRate"] = creativeStatusRate;
    }
    if (filteredBidRate != null) {
      _json["filteredBidRate"] = filteredBidRate;
    }
    if (hostedMatchStatusRate != null) {
      _json["hostedMatchStatusRate"] = hostedMatchStatusRate;
    }
    if (inventoryMatchRate != null) {
      _json["inventoryMatchRate"] = inventoryMatchRate;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (latency50thPercentile != null) {
      _json["latency50thPercentile"] = latency50thPercentile;
    }
    if (latency85thPercentile != null) {
      _json["latency85thPercentile"] = latency85thPercentile;
    }
    if (latency95thPercentile != null) {
      _json["latency95thPercentile"] = latency95thPercentile;
    }
    if (noQuotaInRegion != null) {
      _json["noQuotaInRegion"] = noQuotaInRegion;
    }
    if (outOfQuota != null) {
      _json["outOfQuota"] = outOfQuota;
    }
    if (pixelMatchRequests != null) {
      _json["pixelMatchRequests"] = pixelMatchRequests;
    }
    if (pixelMatchResponses != null) {
      _json["pixelMatchResponses"] = pixelMatchResponses;
    }
    if (quotaConfiguredLimit != null) {
      _json["quotaConfiguredLimit"] = quotaConfiguredLimit;
    }
    if (quotaThrottledLimit != null) {
      _json["quotaThrottledLimit"] = quotaThrottledLimit;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (successfulRequestRate != null) {
      _json["successfulRequestRate"] = successfulRequestRate;
    }
    if (timestamp != null) {
      _json["timestamp"] = timestamp;
    }
    if (unsuccessfulRequestRate != null) {
      _json["unsuccessfulRequestRate"] = unsuccessfulRequestRate;
    }
    return _json;
  }
}

/** The configuration data for an Ad Exchange performance report list. */
class PerformanceReportList {
  /** Resource type. */
  core.String kind;
  /** A list of performance reports relevant for the account. */
  core.List<PerformanceReport> performanceReport;

  PerformanceReportList();

  PerformanceReportList.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("performanceReport")) {
      performanceReport = _json["performanceReport"].map((value) => new PerformanceReport.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (performanceReport != null) {
      _json["performanceReport"] = performanceReport.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class PretargetingConfigDimensions {
  /** Height in pixels. */
  core.String height;
  /** Width in pixels. */
  core.String width;

  PretargetingConfigDimensions();

  PretargetingConfigDimensions.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
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
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

class PretargetingConfigExcludedPlacements {
  /**
   * The value of the placement. Interpretation depends on the placement type,
   * e.g. URL for a site placement, channel name for a channel placement, app id
   * for a mobile app placement.
   */
  core.String token;
  /** The type of the placement. */
  core.String type;

  PretargetingConfigExcludedPlacements();

  PretargetingConfigExcludedPlacements.fromJson(core.Map _json) {
    if (_json.containsKey("token")) {
      token = _json["token"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (token != null) {
      _json["token"] = token;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class PretargetingConfigPlacements {
  /**
   * The value of the placement. Interpretation depends on the placement type,
   * e.g. URL for a site placement, channel name for a channel placement, app id
   * for a mobile app placement.
   */
  core.String token;
  /** The type of the placement. */
  core.String type;

  PretargetingConfigPlacements();

  PretargetingConfigPlacements.fromJson(core.Map _json) {
    if (_json.containsKey("token")) {
      token = _json["token"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (token != null) {
      _json["token"] = token;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class PretargetingConfig {
  /**
   * The id for billing purposes, provided for reference. Leave this field blank
   * for insert requests; the id will be generated automatically.
   */
  core.String billingId;
  /**
   * The config id; generated automatically. Leave this field blank for insert
   * requests.
   */
  core.String configId;
  /** The name of the config. Must be unique. Required for all requests. */
  core.String configName;
  /**
   * List must contain exactly one of PRETARGETING_CREATIVE_TYPE_HTML or
   * PRETARGETING_CREATIVE_TYPE_VIDEO.
   */
  core.List<core.String> creativeType;
  /**
   * Requests which allow one of these (width, height) pairs will match. All
   * pairs must be supported ad dimensions.
   */
  core.List<PretargetingConfigDimensions> dimensions;
  /**
   * Requests with any of these content labels will not match. Values are from
   * content-labels.txt in the downloadable files section.
   */
  core.List<core.String> excludedContentLabels;
  /** Requests containing any of these geo criteria ids will not match. */
  core.List<core.String> excludedGeoCriteriaIds;
  /** Requests containing any of these placements will not match. */
  core.List<PretargetingConfigExcludedPlacements> excludedPlacements;
  /** Requests containing any of these users list ids will not match. */
  core.List<core.String> excludedUserLists;
  /**
   * Requests containing any of these vertical ids will not match. Values are
   * from the publisher-verticals.txt file in the downloadable files section.
   */
  core.List<core.String> excludedVerticals;
  /** Requests containing any of these geo criteria ids will match. */
  core.List<core.String> geoCriteriaIds;
  /** Whether this config is active. Required for all requests. */
  core.bool isActive;
  /** The kind of the resource, i.e. "adexchangebuyer#pretargetingConfig". */
  core.String kind;
  /** Request containing any of these language codes will match. */
  core.List<core.String> languages;
  /**
   * Requests containing any of these mobile carrier ids will match. Values are
   * from mobile-carriers.csv in the downloadable files section.
   */
  core.List<core.String> mobileCarriers;
  /**
   * Requests containing any of these mobile device ids will match. Values are
   * from mobile-devices.csv in the downloadable files section.
   */
  core.List<core.String> mobileDevices;
  /**
   * Requests containing any of these mobile operating system version ids will
   * match. Values are from mobile-os.csv in the downloadable files section.
   */
  core.List<core.String> mobileOperatingSystemVersions;
  /** Requests containing any of these placements will match. */
  core.List<PretargetingConfigPlacements> placements;
  /**
   * Requests matching any of these platforms will match. Possible values are
   * PRETARGETING_PLATFORM_MOBILE, PRETARGETING_PLATFORM_DESKTOP, and
   * PRETARGETING_PLATFORM_TABLET.
   */
  core.List<core.String> platforms;
  /**
   * Creative attributes should be declared here if all creatives corresponding
   * to this pretargeting configuration have that creative attribute. Values are
   * from pretargetable-creative-attributes.txt in the downloadable files
   * section.
   */
  core.List<core.String> supportedCreativeAttributes;
  /** Requests containing any of these user list ids will match. */
  core.List<core.String> userLists;
  /**
   * Requests that allow any of these vendor ids will match. Values are from
   * vendors.txt in the downloadable files section.
   */
  core.List<core.String> vendorTypes;
  /** Requests containing any of these vertical ids will match. */
  core.List<core.String> verticals;

  PretargetingConfig();

  PretargetingConfig.fromJson(core.Map _json) {
    if (_json.containsKey("billingId")) {
      billingId = _json["billingId"];
    }
    if (_json.containsKey("configId")) {
      configId = _json["configId"];
    }
    if (_json.containsKey("configName")) {
      configName = _json["configName"];
    }
    if (_json.containsKey("creativeType")) {
      creativeType = _json["creativeType"];
    }
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"].map((value) => new PretargetingConfigDimensions.fromJson(value)).toList();
    }
    if (_json.containsKey("excludedContentLabels")) {
      excludedContentLabels = _json["excludedContentLabels"];
    }
    if (_json.containsKey("excludedGeoCriteriaIds")) {
      excludedGeoCriteriaIds = _json["excludedGeoCriteriaIds"];
    }
    if (_json.containsKey("excludedPlacements")) {
      excludedPlacements = _json["excludedPlacements"].map((value) => new PretargetingConfigExcludedPlacements.fromJson(value)).toList();
    }
    if (_json.containsKey("excludedUserLists")) {
      excludedUserLists = _json["excludedUserLists"];
    }
    if (_json.containsKey("excludedVerticals")) {
      excludedVerticals = _json["excludedVerticals"];
    }
    if (_json.containsKey("geoCriteriaIds")) {
      geoCriteriaIds = _json["geoCriteriaIds"];
    }
    if (_json.containsKey("isActive")) {
      isActive = _json["isActive"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("languages")) {
      languages = _json["languages"];
    }
    if (_json.containsKey("mobileCarriers")) {
      mobileCarriers = _json["mobileCarriers"];
    }
    if (_json.containsKey("mobileDevices")) {
      mobileDevices = _json["mobileDevices"];
    }
    if (_json.containsKey("mobileOperatingSystemVersions")) {
      mobileOperatingSystemVersions = _json["mobileOperatingSystemVersions"];
    }
    if (_json.containsKey("placements")) {
      placements = _json["placements"].map((value) => new PretargetingConfigPlacements.fromJson(value)).toList();
    }
    if (_json.containsKey("platforms")) {
      platforms = _json["platforms"];
    }
    if (_json.containsKey("supportedCreativeAttributes")) {
      supportedCreativeAttributes = _json["supportedCreativeAttributes"];
    }
    if (_json.containsKey("userLists")) {
      userLists = _json["userLists"];
    }
    if (_json.containsKey("vendorTypes")) {
      vendorTypes = _json["vendorTypes"];
    }
    if (_json.containsKey("verticals")) {
      verticals = _json["verticals"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (billingId != null) {
      _json["billingId"] = billingId;
    }
    if (configId != null) {
      _json["configId"] = configId;
    }
    if (configName != null) {
      _json["configName"] = configName;
    }
    if (creativeType != null) {
      _json["creativeType"] = creativeType;
    }
    if (dimensions != null) {
      _json["dimensions"] = dimensions.map((value) => (value).toJson()).toList();
    }
    if (excludedContentLabels != null) {
      _json["excludedContentLabels"] = excludedContentLabels;
    }
    if (excludedGeoCriteriaIds != null) {
      _json["excludedGeoCriteriaIds"] = excludedGeoCriteriaIds;
    }
    if (excludedPlacements != null) {
      _json["excludedPlacements"] = excludedPlacements.map((value) => (value).toJson()).toList();
    }
    if (excludedUserLists != null) {
      _json["excludedUserLists"] = excludedUserLists;
    }
    if (excludedVerticals != null) {
      _json["excludedVerticals"] = excludedVerticals;
    }
    if (geoCriteriaIds != null) {
      _json["geoCriteriaIds"] = geoCriteriaIds;
    }
    if (isActive != null) {
      _json["isActive"] = isActive;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (languages != null) {
      _json["languages"] = languages;
    }
    if (mobileCarriers != null) {
      _json["mobileCarriers"] = mobileCarriers;
    }
    if (mobileDevices != null) {
      _json["mobileDevices"] = mobileDevices;
    }
    if (mobileOperatingSystemVersions != null) {
      _json["mobileOperatingSystemVersions"] = mobileOperatingSystemVersions;
    }
    if (placements != null) {
      _json["placements"] = placements.map((value) => (value).toJson()).toList();
    }
    if (platforms != null) {
      _json["platforms"] = platforms;
    }
    if (supportedCreativeAttributes != null) {
      _json["supportedCreativeAttributes"] = supportedCreativeAttributes;
    }
    if (userLists != null) {
      _json["userLists"] = userLists;
    }
    if (vendorTypes != null) {
      _json["vendorTypes"] = vendorTypes;
    }
    if (verticals != null) {
      _json["verticals"] = verticals;
    }
    return _json;
  }
}

class PretargetingConfigList {
  /** A list of pretargeting configs */
  core.List<PretargetingConfig> items;
  /** Resource type. */
  core.String kind;

  PretargetingConfigList();

  PretargetingConfigList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new PretargetingConfig.fromJson(value)).toList();
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
