// This is a generated file (see the discoveryapis_generator project).

library googleapis.adexchangebuyer.v1_4;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client adexchangebuyer/v1.4';

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
  MarketplacedealsResourceApi get marketplacedeals => new MarketplacedealsResourceApi(_requester);
  MarketplacenotesResourceApi get marketplacenotes => new MarketplacenotesResourceApi(_requester);
  MarketplaceprivateauctionResourceApi get marketplaceprivateauction => new MarketplaceprivateauctionResourceApi(_requester);
  PerformanceReportResourceApi get performanceReport => new PerformanceReportResourceApi(_requester);
  PretargetingConfigResourceApi get pretargetingConfig => new PretargetingConfigResourceApi(_requester);
  ProductsResourceApi get products => new ProductsResourceApi(_requester);
  ProposalsResourceApi get proposals => new ProposalsResourceApi(_requester);
  PubprofilesResourceApi get pubprofiles => new PubprofilesResourceApi(_requester);

  AdexchangebuyerApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "adexchangebuyer/v1.4/"}) :
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
   * [confirmUnsafeAccountChange] - Confirmation for erasing bidder and cookie
   * matching urls.
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> patch(Account request, core.int id, {core.bool confirmUnsafeAccountChange}) {
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
    if (confirmUnsafeAccountChange != null) {
      _queryParams["confirmUnsafeAccountChange"] = ["${confirmUnsafeAccountChange}"];
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
   * [confirmUnsafeAccountChange] - Confirmation for erasing bidder and cookie
   * matching urls.
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> update(Account request, core.int id, {core.bool confirmUnsafeAccountChange}) {
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
    if (confirmUnsafeAccountChange != null) {
      _queryParams["confirmUnsafeAccountChange"] = ["${confirmUnsafeAccountChange}"];
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
   * Add a deal id association for the creative.
   *
   * Request parameters:
   *
   * [accountId] - The id for the account that will serve this creative.
   *
   * [buyerCreativeId] - The buyer-specific id for this creative.
   *
   * [dealId] - The id of the deal id to associate with this creative.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future addDeal(core.int accountId, core.String buyerCreativeId, core.String dealId) {
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
    if (dealId == null) {
      throw new core.ArgumentError("Parameter dealId is required.");
    }

    _downloadOptions = null;

    _url = 'creatives/' + commons.Escaper.ecapeVariable('$accountId') + '/' + commons.Escaper.ecapeVariable('$buyerCreativeId') + '/addDeal/' + commons.Escaper.ecapeVariable('$dealId');

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
   * [dealsStatusFilter] - When specified, only creatives having the given deals
   * status are returned.
   * Possible string values are:
   * - "approved" : Creatives which have been approved for serving on deals.
   * - "conditionally_approved" : Creatives which have been conditionally
   * approved for serving on deals.
   * - "disapproved" : Creatives which have been disapproved for serving on
   * deals.
   * - "not_checked" : Creatives whose deals status is not yet checked.
   *
   * [maxResults] - Maximum number of entries returned on one result page. If
   * not set, the default is 100. Optional.
   * Value must be between "1" and "1000".
   *
   * [openAuctionStatusFilter] - When specified, only creatives having the given
   * open auction status are returned.
   * Possible string values are:
   * - "approved" : Creatives which have been approved for serving on the open
   * auction.
   * - "conditionally_approved" : Creatives which have been conditionally
   * approved for serving on the open auction.
   * - "disapproved" : Creatives which have been disapproved for serving on the
   * open auction.
   * - "not_checked" : Creatives whose open auction status is not yet checked.
   *
   * [pageToken] - A continuation token, used to page through ad clients. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response. Optional.
   *
   * Completes with a [CreativesList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativesList> list({core.List<core.int> accountId, core.List<core.String> buyerCreativeId, core.String dealsStatusFilter, core.int maxResults, core.String openAuctionStatusFilter, core.String pageToken}) {
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
    if (dealsStatusFilter != null) {
      _queryParams["dealsStatusFilter"] = [dealsStatusFilter];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (openAuctionStatusFilter != null) {
      _queryParams["openAuctionStatusFilter"] = [openAuctionStatusFilter];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
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

  /**
   * Lists the external deal ids associated with the creative.
   *
   * Request parameters:
   *
   * [accountId] - The id for the account that will serve this creative.
   *
   * [buyerCreativeId] - The buyer-specific id for this creative.
   *
   * Completes with a [CreativeDealIds].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeDealIds> listDeals(core.int accountId, core.String buyerCreativeId) {
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

    _url = 'creatives/' + commons.Escaper.ecapeVariable('$accountId') + '/' + commons.Escaper.ecapeVariable('$buyerCreativeId') + '/listDeals';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeDealIds.fromJson(data));
  }

  /**
   * Remove a deal id associated with the creative.
   *
   * Request parameters:
   *
   * [accountId] - The id for the account that will serve this creative.
   *
   * [buyerCreativeId] - The buyer-specific id for this creative.
   *
   * [dealId] - The id of the deal id to disassociate with this creative.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future removeDeal(core.int accountId, core.String buyerCreativeId, core.String dealId) {
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
    if (dealId == null) {
      throw new core.ArgumentError("Parameter dealId is required.");
    }

    _downloadOptions = null;

    _url = 'creatives/' + commons.Escaper.ecapeVariable('$accountId') + '/' + commons.Escaper.ecapeVariable('$buyerCreativeId') + '/removeDeal/' + commons.Escaper.ecapeVariable('$dealId');

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


class MarketplacedealsResourceApi {
  final commons.ApiRequester _requester;

  MarketplacedealsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Delete the specified deals from the proposal
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [proposalId] - The proposalId to delete deals from.
   *
   * Completes with a [DeleteOrderDealsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DeleteOrderDealsResponse> delete(DeleteOrderDealsRequest request, core.String proposalId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (proposalId == null) {
      throw new core.ArgumentError("Parameter proposalId is required.");
    }

    _url = 'proposals/' + commons.Escaper.ecapeVariable('$proposalId') + '/deals/delete';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DeleteOrderDealsResponse.fromJson(data));
  }

  /**
   * Add new deals for the specified proposal
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [proposalId] - proposalId for which deals need to be added.
   *
   * Completes with a [AddOrderDealsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AddOrderDealsResponse> insert(AddOrderDealsRequest request, core.String proposalId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (proposalId == null) {
      throw new core.ArgumentError("Parameter proposalId is required.");
    }

    _url = 'proposals/' + commons.Escaper.ecapeVariable('$proposalId') + '/deals/insert';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AddOrderDealsResponse.fromJson(data));
  }

  /**
   * List all the deals for a given proposal
   *
   * Request parameters:
   *
   * [proposalId] - The proposalId to get deals for. To search across all
   * proposals specify order_id = '-' as part of the URL.
   *
   * [pqlQuery] - Query string to retrieve specific deals.
   *
   * Completes with a [GetOrderDealsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetOrderDealsResponse> list(core.String proposalId, {core.String pqlQuery}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (proposalId == null) {
      throw new core.ArgumentError("Parameter proposalId is required.");
    }
    if (pqlQuery != null) {
      _queryParams["pqlQuery"] = [pqlQuery];
    }

    _url = 'proposals/' + commons.Escaper.ecapeVariable('$proposalId') + '/deals';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetOrderDealsResponse.fromJson(data));
  }

  /**
   * Replaces all the deals in the proposal with the passed in deals
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [proposalId] - The proposalId to edit deals on.
   *
   * Completes with a [EditAllOrderDealsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EditAllOrderDealsResponse> update(EditAllOrderDealsRequest request, core.String proposalId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (proposalId == null) {
      throw new core.ArgumentError("Parameter proposalId is required.");
    }

    _url = 'proposals/' + commons.Escaper.ecapeVariable('$proposalId') + '/deals/update';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EditAllOrderDealsResponse.fromJson(data));
  }

}


class MarketplacenotesResourceApi {
  final commons.ApiRequester _requester;

  MarketplacenotesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Add notes to the proposal
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [proposalId] - The proposalId to add notes for.
   *
   * Completes with a [AddOrderNotesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AddOrderNotesResponse> insert(AddOrderNotesRequest request, core.String proposalId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (proposalId == null) {
      throw new core.ArgumentError("Parameter proposalId is required.");
    }

    _url = 'proposals/' + commons.Escaper.ecapeVariable('$proposalId') + '/notes/insert';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AddOrderNotesResponse.fromJson(data));
  }

  /**
   * Get all the notes associated with a proposal
   *
   * Request parameters:
   *
   * [proposalId] - The proposalId to get notes for. To search across all
   * proposals specify order_id = '-' as part of the URL.
   *
   * [pqlQuery] - Query string to retrieve specific notes. To search the text
   * contents of notes, please use syntax like "WHERE note.note = "foo" or
   * "WHERE note.note LIKE "%bar%"
   *
   * Completes with a [GetOrderNotesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetOrderNotesResponse> list(core.String proposalId, {core.String pqlQuery}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (proposalId == null) {
      throw new core.ArgumentError("Parameter proposalId is required.");
    }
    if (pqlQuery != null) {
      _queryParams["pqlQuery"] = [pqlQuery];
    }

    _url = 'proposals/' + commons.Escaper.ecapeVariable('$proposalId') + '/notes';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetOrderNotesResponse.fromJson(data));
  }

}


class MarketplaceprivateauctionResourceApi {
  final commons.ApiRequester _requester;

  MarketplaceprivateauctionResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Update a given private auction proposal
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [privateAuctionId] - The private auction id to be updated.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future updateproposal(UpdatePrivateAuctionProposalRequest request, core.String privateAuctionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (privateAuctionId == null) {
      throw new core.ArgumentError("Parameter privateAuctionId is required.");
    }

    _downloadOptions = null;

    _url = 'privateauction/' + commons.Escaper.ecapeVariable('$privateAuctionId') + '/updateproposal';

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


class ProductsResourceApi {
  final commons.ApiRequester _requester;

  ProductsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the requested product by id.
   *
   * Request parameters:
   *
   * [productId] - The id for the product to get the head revision for.
   *
   * Completes with a [Product].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Product> get(core.String productId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }

    _url = 'products/' + commons.Escaper.ecapeVariable('$productId');

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
   * Gets the requested product.
   *
   * Request parameters:
   *
   * [pqlQuery] - The pql query used to query for products.
   *
   * Completes with a [GetOffersResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetOffersResponse> search({core.String pqlQuery}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (pqlQuery != null) {
      _queryParams["pqlQuery"] = [pqlQuery];
    }

    _url = 'products/search';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetOffersResponse.fromJson(data));
  }

}


class ProposalsResourceApi {
  final commons.ApiRequester _requester;

  ProposalsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get a proposal given its id
   *
   * Request parameters:
   *
   * [proposalId] - Id of the proposal to retrieve.
   *
   * Completes with a [Proposal].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Proposal> get(core.String proposalId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (proposalId == null) {
      throw new core.ArgumentError("Parameter proposalId is required.");
    }

    _url = 'proposals/' + commons.Escaper.ecapeVariable('$proposalId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Proposal.fromJson(data));
  }

  /**
   * Create the given list of proposals
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [CreateOrdersResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreateOrdersResponse> insert(CreateOrdersRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'proposals/insert';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreateOrdersResponse.fromJson(data));
  }

  /**
   * Update the given proposal. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [proposalId] - The proposal id to update.
   *
   * [revisionNumber] - The last known revision number to update. If the head
   * revision in the marketplace database has since changed, an error will be
   * thrown. The caller should then fetch the latest proposal at head revision
   * and retry the update at that revision.
   *
   * [updateAction] - The proposed action to take on the proposal. This field is
   * required and it must be set when updating a proposal.
   * Possible string values are:
   * - "accept"
   * - "cancel"
   * - "propose"
   * - "proposeAndAccept"
   * - "unknownAction"
   * - "updateNonTerms"
   *
   * Completes with a [Proposal].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Proposal> patch(Proposal request, core.String proposalId, core.String revisionNumber, core.String updateAction) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (proposalId == null) {
      throw new core.ArgumentError("Parameter proposalId is required.");
    }
    if (revisionNumber == null) {
      throw new core.ArgumentError("Parameter revisionNumber is required.");
    }
    if (updateAction == null) {
      throw new core.ArgumentError("Parameter updateAction is required.");
    }

    _url = 'proposals/' + commons.Escaper.ecapeVariable('$proposalId') + '/' + commons.Escaper.ecapeVariable('$revisionNumber') + '/' + commons.Escaper.ecapeVariable('$updateAction');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Proposal.fromJson(data));
  }

  /**
   * Search for proposals using pql query
   *
   * Request parameters:
   *
   * [pqlQuery] - Query string to retrieve specific proposals.
   *
   * Completes with a [GetOrdersResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetOrdersResponse> search({core.String pqlQuery}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (pqlQuery != null) {
      _queryParams["pqlQuery"] = [pqlQuery];
    }

    _url = 'proposals/search';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetOrdersResponse.fromJson(data));
  }

  /**
   * Update the given proposal to indicate that setup has been completed.
   *
   * Request parameters:
   *
   * [proposalId] - The proposal id for which the setup is complete
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future setupcomplete(core.String proposalId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (proposalId == null) {
      throw new core.ArgumentError("Parameter proposalId is required.");
    }

    _downloadOptions = null;

    _url = 'proposals/' + commons.Escaper.ecapeVariable('$proposalId') + '/setupcomplete';

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
   * Update the given proposal
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [proposalId] - The proposal id to update.
   *
   * [revisionNumber] - The last known revision number to update. If the head
   * revision in the marketplace database has since changed, an error will be
   * thrown. The caller should then fetch the latest proposal at head revision
   * and retry the update at that revision.
   *
   * [updateAction] - The proposed action to take on the proposal. This field is
   * required and it must be set when updating a proposal.
   * Possible string values are:
   * - "accept"
   * - "cancel"
   * - "propose"
   * - "proposeAndAccept"
   * - "unknownAction"
   * - "updateNonTerms"
   *
   * Completes with a [Proposal].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Proposal> update(Proposal request, core.String proposalId, core.String revisionNumber, core.String updateAction) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (proposalId == null) {
      throw new core.ArgumentError("Parameter proposalId is required.");
    }
    if (revisionNumber == null) {
      throw new core.ArgumentError("Parameter revisionNumber is required.");
    }
    if (updateAction == null) {
      throw new core.ArgumentError("Parameter updateAction is required.");
    }

    _url = 'proposals/' + commons.Escaper.ecapeVariable('$proposalId') + '/' + commons.Escaper.ecapeVariable('$revisionNumber') + '/' + commons.Escaper.ecapeVariable('$updateAction');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Proposal.fromJson(data));
  }

}


class PubprofilesResourceApi {
  final commons.ApiRequester _requester;

  PubprofilesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the requested publisher profile(s) by publisher accountId.
   *
   * Request parameters:
   *
   * [accountId] - The accountId of the publisher to get profiles for.
   *
   * Completes with a [GetPublisherProfilesByAccountIdResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetPublisherProfilesByAccountIdResponse> list(core.int accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = 'publisher/' + commons.Escaper.ecapeVariable('$accountId') + '/profiles';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetPublisherProfilesByAccountIdResponse.fromJson(data));
  }

}



class AccountBidderLocation {
  /**
   * The protocol that the bidder endpoint is using. OpenRTB protocols with
   * prefix PROTOCOL_OPENRTB_PROTOBUF use proto buffer, otherwise use JSON.
   * Allowed values:
   * - PROTOCOL_ADX
   * - PROTOCOL_OPENRTB_2_2
   * - PROTOCOL_OPENRTB_2_3
   * - PROTOCOL_OPENRTB_2_4
   * - PROTOCOL_OPENRTB_PROTOBUF_2_3
   * - PROTOCOL_OPENRTB_PROTOBUF_2_4
   */
  core.String bidProtocol;
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
    if (_json.containsKey("bidProtocol")) {
      bidProtocol = _json["bidProtocol"];
    }
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
    if (bidProtocol != null) {
      _json["bidProtocol"] = bidProtocol;
    }
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

class AddOrderDealsRequest {
  /** The list of deals to add */
  core.List<MarketplaceDeal> deals;
  /** The last known proposal revision number. */
  core.String proposalRevisionNumber;
  /** Indicates an optional action to take on the proposal */
  core.String updateAction;

  AddOrderDealsRequest();

  AddOrderDealsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("deals")) {
      deals = _json["deals"].map((value) => new MarketplaceDeal.fromJson(value)).toList();
    }
    if (_json.containsKey("proposalRevisionNumber")) {
      proposalRevisionNumber = _json["proposalRevisionNumber"];
    }
    if (_json.containsKey("updateAction")) {
      updateAction = _json["updateAction"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deals != null) {
      _json["deals"] = deals.map((value) => (value).toJson()).toList();
    }
    if (proposalRevisionNumber != null) {
      _json["proposalRevisionNumber"] = proposalRevisionNumber;
    }
    if (updateAction != null) {
      _json["updateAction"] = updateAction;
    }
    return _json;
  }
}

class AddOrderDealsResponse {
  /** List of deals added (in the same proposal as passed in the request) */
  core.List<MarketplaceDeal> deals;
  /** The updated revision number for the proposal. */
  core.String proposalRevisionNumber;

  AddOrderDealsResponse();

  AddOrderDealsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("deals")) {
      deals = _json["deals"].map((value) => new MarketplaceDeal.fromJson(value)).toList();
    }
    if (_json.containsKey("proposalRevisionNumber")) {
      proposalRevisionNumber = _json["proposalRevisionNumber"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deals != null) {
      _json["deals"] = deals.map((value) => (value).toJson()).toList();
    }
    if (proposalRevisionNumber != null) {
      _json["proposalRevisionNumber"] = proposalRevisionNumber;
    }
    return _json;
  }
}

class AddOrderNotesRequest {
  /** The list of notes to add. */
  core.List<MarketplaceNote> notes;

  AddOrderNotesRequest();

  AddOrderNotesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("notes")) {
      notes = _json["notes"].map((value) => new MarketplaceNote.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (notes != null) {
      _json["notes"] = notes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class AddOrderNotesResponse {
  core.List<MarketplaceNote> notes;

  AddOrderNotesResponse();

  AddOrderNotesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("notes")) {
      notes = _json["notes"].map((value) => new MarketplaceNote.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (notes != null) {
      _json["notes"] = notes.map((value) => (value).toJson()).toList();
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

class Buyer {
  /** Adx account id of the buyer. */
  core.String accountId;

  Buyer();

  Buyer.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    return _json;
  }
}

class ContactInformation {
  /** Email address of the contact. */
  core.String email;
  /** The name of the contact. */
  core.String name;

  ContactInformation();

  ContactInformation.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (email != null) {
      _json["email"] = email;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

class CreateOrdersRequest {
  /** The list of proposals to create. */
  core.List<Proposal> proposals;
  /** Web property id of the seller creating these orders */
  core.String webPropertyCode;

  CreateOrdersRequest();

  CreateOrdersRequest.fromJson(core.Map _json) {
    if (_json.containsKey("proposals")) {
      proposals = _json["proposals"].map((value) => new Proposal.fromJson(value)).toList();
    }
    if (_json.containsKey("webPropertyCode")) {
      webPropertyCode = _json["webPropertyCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (proposals != null) {
      _json["proposals"] = proposals.map((value) => (value).toJson()).toList();
    }
    if (webPropertyCode != null) {
      _json["webPropertyCode"] = webPropertyCode;
    }
    return _json;
  }
}

class CreateOrdersResponse {
  /** The list of proposals successfully created. */
  core.List<Proposal> proposals;

  CreateOrdersResponse();

  CreateOrdersResponse.fromJson(core.Map _json) {
    if (_json.containsKey("proposals")) {
      proposals = _json["proposals"].map((value) => new Proposal.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (proposals != null) {
      _json["proposals"] = proposals.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class CreativeCorrectionsContexts {
  /**
   * Only set when contextType=AUCTION_TYPE. Represents the auction types this
   * correction applies to.
   */
  core.List<core.String> auctionType;
  /**
   * The type of context (e.g., location, platform, auction type, SSL-ness).
   */
  core.String contextType;
  /**
   * Only set when contextType=LOCATION. Represents the geo criterias this
   * correction applies to.
   */
  core.List<core.int> geoCriteriaId;
  /**
   * Only set when contextType=PLATFORM. Represents the platforms this
   * correction applies to.
   */
  core.List<core.String> platform;

  CreativeCorrectionsContexts();

  CreativeCorrectionsContexts.fromJson(core.Map _json) {
    if (_json.containsKey("auctionType")) {
      auctionType = _json["auctionType"];
    }
    if (_json.containsKey("contextType")) {
      contextType = _json["contextType"];
    }
    if (_json.containsKey("geoCriteriaId")) {
      geoCriteriaId = _json["geoCriteriaId"];
    }
    if (_json.containsKey("platform")) {
      platform = _json["platform"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (auctionType != null) {
      _json["auctionType"] = auctionType;
    }
    if (contextType != null) {
      _json["contextType"] = contextType;
    }
    if (geoCriteriaId != null) {
      _json["geoCriteriaId"] = geoCriteriaId;
    }
    if (platform != null) {
      _json["platform"] = platform;
    }
    return _json;
  }
}

class CreativeCorrections {
  /** All known serving contexts containing serving status information. */
  core.List<CreativeCorrectionsContexts> contexts;
  /** Additional details about the correction. */
  core.List<core.String> details;
  /** The type of correction that was applied to the creative. */
  core.String reason;

  CreativeCorrections();

  CreativeCorrections.fromJson(core.Map _json) {
    if (_json.containsKey("contexts")) {
      contexts = _json["contexts"].map((value) => new CreativeCorrectionsContexts.fromJson(value)).toList();
    }
    if (_json.containsKey("details")) {
      details = _json["details"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contexts != null) {
      _json["contexts"] = contexts.map((value) => (value).toJson()).toList();
    }
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
  /** The filtering status code as defined in  creative-status-codes.txt. */
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

/**
 * If nativeAd is set, HTMLSnippet and the videoURL outside of nativeAd should
 * not be set. (The videoURL inside nativeAd can be set.)
 */
class CreativeNativeAd {
  core.String advertiser;
  /** The app icon, for app download ads. */
  CreativeNativeAdAppIcon appIcon;
  /** A long description of the ad. */
  core.String body;
  /** A label for the button that the user is supposed to click. */
  core.String callToAction;
  /** The URL that the browser/SDK will load when the user clicks the ad. */
  core.String clickLinkUrl;
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
  /**
   * The URL of the XML VAST for a native ad. Note this is a separate field from
   * resource.video_url.
   */
  core.String videoURL;

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
    if (_json.containsKey("videoURL")) {
      videoURL = _json["videoURL"];
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
    if (videoURL != null) {
      _json["videoURL"] = videoURL;
    }
    return _json;
  }
}

class CreativeServingRestrictionsContexts {
  /**
   * Only set when contextType=AUCTION_TYPE. Represents the auction types this
   * restriction applies to.
   */
  core.List<core.String> auctionType;
  /**
   * The type of context (e.g., location, platform, auction type, SSL-ness).
   */
  core.String contextType;
  /**
   * Only set when contextType=LOCATION. Represents the geo criterias this
   * restriction applies to. Impressions are considered to match a context if
   * either the user location or publisher location matches a given
   * geoCriteriaId.
   */
  core.List<core.int> geoCriteriaId;
  /**
   * Only set when contextType=PLATFORM. Represents the platforms this
   * restriction applies to.
   */
  core.List<core.String> platform;

  CreativeServingRestrictionsContexts();

  CreativeServingRestrictionsContexts.fromJson(core.Map _json) {
    if (_json.containsKey("auctionType")) {
      auctionType = _json["auctionType"];
    }
    if (_json.containsKey("contextType")) {
      contextType = _json["contextType"];
    }
    if (_json.containsKey("geoCriteriaId")) {
      geoCriteriaId = _json["geoCriteriaId"];
    }
    if (_json.containsKey("platform")) {
      platform = _json["platform"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (auctionType != null) {
      _json["auctionType"] = auctionType;
    }
    if (contextType != null) {
      _json["contextType"] = contextType;
    }
    if (geoCriteriaId != null) {
      _json["geoCriteriaId"] = geoCriteriaId;
    }
    if (platform != null) {
      _json["platform"] = platform;
    }
    return _json;
  }
}

class CreativeServingRestrictionsDisapprovalReasons {
  /** Additional details about the reason for disapproval. */
  core.List<core.String> details;
  /** The categorized reason for disapproval. */
  core.String reason;

  CreativeServingRestrictionsDisapprovalReasons();

  CreativeServingRestrictionsDisapprovalReasons.fromJson(core.Map _json) {
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

class CreativeServingRestrictions {
  /** All known contexts/restrictions. */
  core.List<CreativeServingRestrictionsContexts> contexts;
  /**
   * The reasons for disapproval within this restriction, if any. Note that not
   * all disapproval reasons may be categorized, so it is possible for the
   * creative to have a status of DISAPPROVED or CONDITIONALLY_APPROVED with an
   * empty list for disapproval_reasons. In this case, please reach out to your
   * TAM to help debug the issue.
   */
  core.List<CreativeServingRestrictionsDisapprovalReasons> disapprovalReasons;
  /**
   * Why the creative is ineligible to serve in this context (e.g., it has been
   * explicitly disapproved or is pending review).
   */
  core.String reason;

  CreativeServingRestrictions();

  CreativeServingRestrictions.fromJson(core.Map _json) {
    if (_json.containsKey("contexts")) {
      contexts = _json["contexts"].map((value) => new CreativeServingRestrictionsContexts.fromJson(value)).toList();
    }
    if (_json.containsKey("disapprovalReasons")) {
      disapprovalReasons = _json["disapprovalReasons"].map((value) => new CreativeServingRestrictionsDisapprovalReasons.fromJson(value)).toList();
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contexts != null) {
      _json["contexts"] = contexts.map((value) => (value).toJson()).toList();
    }
    if (disapprovalReasons != null) {
      _json["disapprovalReasons"] = disapprovalReasons.map((value) => (value).toJson()).toList();
    }
    if (reason != null) {
      _json["reason"] = reason;
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
   * The link to the Ad Preferences page. This is only supported for native ads.
   */
  core.String adChoicesDestinationUrl;
  /**
   * Detected advertiser id, if any. Read-only. This field should not be set in
   * requests.
   */
  core.List<core.String> advertiserId;
  /**
   * The name of the company being advertised in the creative. The value
   * provided must exist in the advertisers.txt file.
   */
  core.String advertiserName;
  /** The agency id for this creative. */
  core.String agencyId;
  /**
   * The last upload timestamp of this creative if it was uploaded via API.
   * Read-only. The value of this field is generated, and will be ignored for
   * uploads. (formatted RFC 3339 timestamp).
   */
  core.DateTime apiUploadTimestamp;
  /**
   * List of buyer selectable attributes for the ads that may be shown from this
   * snippet. Each attribute is represented by an integer as defined in
   * buyer-declarable-creative-attributes.txt.
   */
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
   * Top-level deals status. Read-only. This field should not be set in
   * requests. If disapproved, an entry for auctionType=DIRECT_DEALS (or ALL) in
   * servingRestrictions will also exist. Note that this may be nuanced with
   * other contextual restrictions, in which case it may be preferable to read
   * from servingRestrictions directly.
   */
  core.String dealsStatus;
  /**
   * Detected domains for this creative. Read-only. This field should not be set
   * in requests.
   */
  core.List<core.String> detectedDomains;
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
  /**
   * Detected languages for this creative. Read-only. This field should not be
   * set in requests.
   */
  core.List<core.String> languages;
  /**
   * If nativeAd is set, HTMLSnippet and the videoURL outside of nativeAd should
   * not be set. (The videoURL inside nativeAd can be set.)
   */
  CreativeNativeAd nativeAd;
  /**
   * Top-level open auction status. Read-only. This field should not be set in
   * requests. If disapproved, an entry for auctionType=OPEN_AUCTION (or ALL) in
   * servingRestrictions will also exist. Note that this may be nuanced with
   * other contextual restrictions, in which case it may be preferable to read
   * from ServingRestrictions directly.
   */
  core.String openAuctionStatus;
  /**
   * Detected product categories, if any. Each category is represented by an
   * integer as defined in  ad-product-categories.txt. Read-only. This field
   * should not be set in requests.
   */
  core.List<core.int> productCategories;
  /**
   * All restricted categories for the ads that may be shown from this snippet.
   * Each category is represented by an integer as defined in the
   * ad-restricted-categories.txt.
   */
  core.List<core.int> restrictedCategories;
  /**
   * Detected sensitive categories, if any. Each category is represented by an
   * integer as defined in  ad-sensitive-categories.txt. Read-only. This field
   * should not be set in requests.
   */
  core.List<core.int> sensitiveCategories;
  /**
   * The granular status of this ad in specific contexts. A context here relates
   * to where something ultimately serves (for example, a physical location, a
   * platform, an HTTPS vs HTTP request, or the type of auction). Read-only.
   * This field should not be set in requests.
   */
  core.List<CreativeServingRestrictions> servingRestrictions;
  /**
   * List of vendor types for the ads that may be shown from this snippet. Each
   * vendor type is represented by an integer as defined in vendors.txt.
   */
  core.List<core.int> vendorType;
  /**
   * The version for this creative. Read-only. This field should not be set in
   * requests.
   */
  core.int version;
  /**
   * The URL to fetch a video ad. If set, HTMLSnippet and the nativeAd should
   * not be set. Note, this is different from resource.native_ad.video_url
   * above.
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
    if (_json.containsKey("adChoicesDestinationUrl")) {
      adChoicesDestinationUrl = _json["adChoicesDestinationUrl"];
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
    if (_json.containsKey("dealsStatus")) {
      dealsStatus = _json["dealsStatus"];
    }
    if (_json.containsKey("detectedDomains")) {
      detectedDomains = _json["detectedDomains"];
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
    if (_json.containsKey("languages")) {
      languages = _json["languages"];
    }
    if (_json.containsKey("nativeAd")) {
      nativeAd = new CreativeNativeAd.fromJson(_json["nativeAd"]);
    }
    if (_json.containsKey("openAuctionStatus")) {
      openAuctionStatus = _json["openAuctionStatus"];
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
    if (_json.containsKey("servingRestrictions")) {
      servingRestrictions = _json["servingRestrictions"].map((value) => new CreativeServingRestrictions.fromJson(value)).toList();
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
    if (adChoicesDestinationUrl != null) {
      _json["adChoicesDestinationUrl"] = adChoicesDestinationUrl;
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
    if (dealsStatus != null) {
      _json["dealsStatus"] = dealsStatus;
    }
    if (detectedDomains != null) {
      _json["detectedDomains"] = detectedDomains;
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
    if (languages != null) {
      _json["languages"] = languages;
    }
    if (nativeAd != null) {
      _json["nativeAd"] = (nativeAd).toJson();
    }
    if (openAuctionStatus != null) {
      _json["openAuctionStatus"] = openAuctionStatus;
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
    if (servingRestrictions != null) {
      _json["servingRestrictions"] = servingRestrictions.map((value) => (value).toJson()).toList();
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

class CreativeDealIdsDealStatuses {
  /** ARC approval status. */
  core.String arcStatus;
  /** External deal ID. */
  core.String dealId;
  /** Publisher ID. */
  core.int webPropertyId;

  CreativeDealIdsDealStatuses();

  CreativeDealIdsDealStatuses.fromJson(core.Map _json) {
    if (_json.containsKey("arcStatus")) {
      arcStatus = _json["arcStatus"];
    }
    if (_json.containsKey("dealId")) {
      dealId = _json["dealId"];
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (arcStatus != null) {
      _json["arcStatus"] = arcStatus;
    }
    if (dealId != null) {
      _json["dealId"] = dealId;
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    return _json;
  }
}

/** The external deal ids associated with a creative. */
class CreativeDealIds {
  /** A list of external deal ids and ARC approval status. */
  core.List<CreativeDealIdsDealStatuses> dealStatuses;
  /** Resource type. */
  core.String kind;

  CreativeDealIds();

  CreativeDealIds.fromJson(core.Map _json) {
    if (_json.containsKey("dealStatuses")) {
      dealStatuses = _json["dealStatuses"].map((value) => new CreativeDealIdsDealStatuses.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dealStatuses != null) {
      _json["dealStatuses"] = dealStatuses.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
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

class DealServingMetadata {
  /**
   * True if alcohol ads are allowed for this deal (read-only). This field is
   * only populated when querying for finalized orders using the method
   * GetFinalizedOrderDeals
   */
  core.bool alcoholAdsAllowed;
  /**
   * Tracks which parties (if any) have paused a deal. (readonly, except via
   * PauseResumeOrderDeals action)
   */
  DealServingMetadataDealPauseStatus dealPauseStatus;

  DealServingMetadata();

  DealServingMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("alcoholAdsAllowed")) {
      alcoholAdsAllowed = _json["alcoholAdsAllowed"];
    }
    if (_json.containsKey("dealPauseStatus")) {
      dealPauseStatus = new DealServingMetadataDealPauseStatus.fromJson(_json["dealPauseStatus"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alcoholAdsAllowed != null) {
      _json["alcoholAdsAllowed"] = alcoholAdsAllowed;
    }
    if (dealPauseStatus != null) {
      _json["dealPauseStatus"] = (dealPauseStatus).toJson();
    }
    return _json;
  }
}

/**
 * Tracks which parties (if any) have paused a deal. The deal is considered
 * paused if has_buyer_paused || has_seller_paused. Each of the has_buyer_paused
 * or the has_seller_paused bits can be set independently.
 */
class DealServingMetadataDealPauseStatus {
  core.String buyerPauseReason;
  /** If the deal is paused, records which party paused the deal first. */
  core.String firstPausedBy;
  core.bool hasBuyerPaused;
  core.bool hasSellerPaused;
  core.String sellerPauseReason;

  DealServingMetadataDealPauseStatus();

  DealServingMetadataDealPauseStatus.fromJson(core.Map _json) {
    if (_json.containsKey("buyerPauseReason")) {
      buyerPauseReason = _json["buyerPauseReason"];
    }
    if (_json.containsKey("firstPausedBy")) {
      firstPausedBy = _json["firstPausedBy"];
    }
    if (_json.containsKey("hasBuyerPaused")) {
      hasBuyerPaused = _json["hasBuyerPaused"];
    }
    if (_json.containsKey("hasSellerPaused")) {
      hasSellerPaused = _json["hasSellerPaused"];
    }
    if (_json.containsKey("sellerPauseReason")) {
      sellerPauseReason = _json["sellerPauseReason"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (buyerPauseReason != null) {
      _json["buyerPauseReason"] = buyerPauseReason;
    }
    if (firstPausedBy != null) {
      _json["firstPausedBy"] = firstPausedBy;
    }
    if (hasBuyerPaused != null) {
      _json["hasBuyerPaused"] = hasBuyerPaused;
    }
    if (hasSellerPaused != null) {
      _json["hasSellerPaused"] = hasSellerPaused;
    }
    if (sellerPauseReason != null) {
      _json["sellerPauseReason"] = sellerPauseReason;
    }
    return _json;
  }
}

class DealTerms {
  /** Visibilty of the URL in bid requests. */
  core.String brandingType;
  /**
   * Indicates that this ExternalDealId exists under at least two different
   * AdxInventoryDeals. Currently, the only case that the same ExternalDealId
   * will exist is programmatic cross sell case.
   */
  core.String crossListedExternalDealIdType;
  /** Description for the proposed terms of the deal. */
  core.String description;
  /**
   * Non-binding estimate of the estimated gross spend for this deal Can be set
   * by buyer or seller.
   */
  Price estimatedGrossSpend;
  /**
   * Non-binding estimate of the impressions served per day Can be set by buyer
   * or seller.
   */
  core.String estimatedImpressionsPerDay;
  /** The terms for guaranteed fixed price deals. */
  DealTermsGuaranteedFixedPriceTerms guaranteedFixedPriceTerms;
  /** The terms for non-guaranteed auction deals. */
  DealTermsNonGuaranteedAuctionTerms nonGuaranteedAuctionTerms;
  /** The terms for non-guaranteed fixed price deals. */
  DealTermsNonGuaranteedFixedPriceTerms nonGuaranteedFixedPriceTerms;
  /** The terms for rubicon non-guaranteed deals. */
  DealTermsRubiconNonGuaranteedTerms rubiconNonGuaranteedTerms;
  /**
   * For deals with Cost Per Day billing, defines the timezone used to mark the
   * boundaries of a day (buyer-readonly)
   */
  core.String sellerTimeZone;

  DealTerms();

  DealTerms.fromJson(core.Map _json) {
    if (_json.containsKey("brandingType")) {
      brandingType = _json["brandingType"];
    }
    if (_json.containsKey("crossListedExternalDealIdType")) {
      crossListedExternalDealIdType = _json["crossListedExternalDealIdType"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("estimatedGrossSpend")) {
      estimatedGrossSpend = new Price.fromJson(_json["estimatedGrossSpend"]);
    }
    if (_json.containsKey("estimatedImpressionsPerDay")) {
      estimatedImpressionsPerDay = _json["estimatedImpressionsPerDay"];
    }
    if (_json.containsKey("guaranteedFixedPriceTerms")) {
      guaranteedFixedPriceTerms = new DealTermsGuaranteedFixedPriceTerms.fromJson(_json["guaranteedFixedPriceTerms"]);
    }
    if (_json.containsKey("nonGuaranteedAuctionTerms")) {
      nonGuaranteedAuctionTerms = new DealTermsNonGuaranteedAuctionTerms.fromJson(_json["nonGuaranteedAuctionTerms"]);
    }
    if (_json.containsKey("nonGuaranteedFixedPriceTerms")) {
      nonGuaranteedFixedPriceTerms = new DealTermsNonGuaranteedFixedPriceTerms.fromJson(_json["nonGuaranteedFixedPriceTerms"]);
    }
    if (_json.containsKey("rubiconNonGuaranteedTerms")) {
      rubiconNonGuaranteedTerms = new DealTermsRubiconNonGuaranteedTerms.fromJson(_json["rubiconNonGuaranteedTerms"]);
    }
    if (_json.containsKey("sellerTimeZone")) {
      sellerTimeZone = _json["sellerTimeZone"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (brandingType != null) {
      _json["brandingType"] = brandingType;
    }
    if (crossListedExternalDealIdType != null) {
      _json["crossListedExternalDealIdType"] = crossListedExternalDealIdType;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (estimatedGrossSpend != null) {
      _json["estimatedGrossSpend"] = (estimatedGrossSpend).toJson();
    }
    if (estimatedImpressionsPerDay != null) {
      _json["estimatedImpressionsPerDay"] = estimatedImpressionsPerDay;
    }
    if (guaranteedFixedPriceTerms != null) {
      _json["guaranteedFixedPriceTerms"] = (guaranteedFixedPriceTerms).toJson();
    }
    if (nonGuaranteedAuctionTerms != null) {
      _json["nonGuaranteedAuctionTerms"] = (nonGuaranteedAuctionTerms).toJson();
    }
    if (nonGuaranteedFixedPriceTerms != null) {
      _json["nonGuaranteedFixedPriceTerms"] = (nonGuaranteedFixedPriceTerms).toJson();
    }
    if (rubiconNonGuaranteedTerms != null) {
      _json["rubiconNonGuaranteedTerms"] = (rubiconNonGuaranteedTerms).toJson();
    }
    if (sellerTimeZone != null) {
      _json["sellerTimeZone"] = sellerTimeZone;
    }
    return _json;
  }
}

class DealTermsGuaranteedFixedPriceTerms {
  /**
   * External billing info for this Deal. This field is relevant when external
   * billing info such as price has a different currency code than DFP/AdX.
   */
  DealTermsGuaranteedFixedPriceTermsBillingInfo billingInfo;
  /** Fixed price for the specified buyer. */
  core.List<PricePerBuyer> fixedPrices;
  /**
   * Guaranteed impressions as a percentage. This is the percentage of
   * guaranteed looks that the buyer is guaranteeing to buy.
   */
  core.String guaranteedImpressions;
  /**
   * Count of guaranteed looks. Required for deal, optional for product. For CPD
   * deals, buyer changes to guaranteed_looks will be ignored.
   */
  core.String guaranteedLooks;
  /**
   * Count of minimum daily looks for a CPD deal. For CPD deals, buyer should
   * negotiate on this field instead of guaranteed_looks.
   */
  core.String minimumDailyLooks;

  DealTermsGuaranteedFixedPriceTerms();

  DealTermsGuaranteedFixedPriceTerms.fromJson(core.Map _json) {
    if (_json.containsKey("billingInfo")) {
      billingInfo = new DealTermsGuaranteedFixedPriceTermsBillingInfo.fromJson(_json["billingInfo"]);
    }
    if (_json.containsKey("fixedPrices")) {
      fixedPrices = _json["fixedPrices"].map((value) => new PricePerBuyer.fromJson(value)).toList();
    }
    if (_json.containsKey("guaranteedImpressions")) {
      guaranteedImpressions = _json["guaranteedImpressions"];
    }
    if (_json.containsKey("guaranteedLooks")) {
      guaranteedLooks = _json["guaranteedLooks"];
    }
    if (_json.containsKey("minimumDailyLooks")) {
      minimumDailyLooks = _json["minimumDailyLooks"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (billingInfo != null) {
      _json["billingInfo"] = (billingInfo).toJson();
    }
    if (fixedPrices != null) {
      _json["fixedPrices"] = fixedPrices.map((value) => (value).toJson()).toList();
    }
    if (guaranteedImpressions != null) {
      _json["guaranteedImpressions"] = guaranteedImpressions;
    }
    if (guaranteedLooks != null) {
      _json["guaranteedLooks"] = guaranteedLooks;
    }
    if (minimumDailyLooks != null) {
      _json["minimumDailyLooks"] = minimumDailyLooks;
    }
    return _json;
  }
}

class DealTermsGuaranteedFixedPriceTermsBillingInfo {
  /**
   * The timestamp (in ms since epoch) when the original reservation price for
   * the deal was first converted to DFP currency. This is used to convert the
   * contracted price into advertiser's currency without discrepancy.
   */
  core.String currencyConversionTimeMs;
  /**
   * The DFP line item id associated with this deal. For features like CPD,
   * buyers can retrieve the DFP line item for billing reconciliation.
   */
  core.String dfpLineItemId;
  /**
   * The original contracted quantity (# impressions) for this deal. To ensure
   * delivery, sometimes the publisher will book the deal with a impression
   * buffer, such that guaranteed_looks is greater than the contracted quantity.
   * However clients are billed using the original contracted quantity.
   */
  core.String originalContractedQuantity;
  /**
   * The original reservation price for the deal, if the currency code is
   * different from the one used in negotiation.
   */
  Price price;

  DealTermsGuaranteedFixedPriceTermsBillingInfo();

  DealTermsGuaranteedFixedPriceTermsBillingInfo.fromJson(core.Map _json) {
    if (_json.containsKey("currencyConversionTimeMs")) {
      currencyConversionTimeMs = _json["currencyConversionTimeMs"];
    }
    if (_json.containsKey("dfpLineItemId")) {
      dfpLineItemId = _json["dfpLineItemId"];
    }
    if (_json.containsKey("originalContractedQuantity")) {
      originalContractedQuantity = _json["originalContractedQuantity"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currencyConversionTimeMs != null) {
      _json["currencyConversionTimeMs"] = currencyConversionTimeMs;
    }
    if (dfpLineItemId != null) {
      _json["dfpLineItemId"] = dfpLineItemId;
    }
    if (originalContractedQuantity != null) {
      _json["originalContractedQuantity"] = originalContractedQuantity;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    return _json;
  }
}

class DealTermsNonGuaranteedAuctionTerms {
  /**
   * True if open auction buyers are allowed to compete with invited buyers in
   * this private auction (buyer-readonly).
   */
  core.bool autoOptimizePrivateAuction;
  /** Reserve price for the specified buyer. */
  core.List<PricePerBuyer> reservePricePerBuyers;

  DealTermsNonGuaranteedAuctionTerms();

  DealTermsNonGuaranteedAuctionTerms.fromJson(core.Map _json) {
    if (_json.containsKey("autoOptimizePrivateAuction")) {
      autoOptimizePrivateAuction = _json["autoOptimizePrivateAuction"];
    }
    if (_json.containsKey("reservePricePerBuyers")) {
      reservePricePerBuyers = _json["reservePricePerBuyers"].map((value) => new PricePerBuyer.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (autoOptimizePrivateAuction != null) {
      _json["autoOptimizePrivateAuction"] = autoOptimizePrivateAuction;
    }
    if (reservePricePerBuyers != null) {
      _json["reservePricePerBuyers"] = reservePricePerBuyers.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class DealTermsNonGuaranteedFixedPriceTerms {
  /** Fixed price for the specified buyer. */
  core.List<PricePerBuyer> fixedPrices;

  DealTermsNonGuaranteedFixedPriceTerms();

  DealTermsNonGuaranteedFixedPriceTerms.fromJson(core.Map _json) {
    if (_json.containsKey("fixedPrices")) {
      fixedPrices = _json["fixedPrices"].map((value) => new PricePerBuyer.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fixedPrices != null) {
      _json["fixedPrices"] = fixedPrices.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class DealTermsRubiconNonGuaranteedTerms {
  /** Optional price for Rubicon priority access in the auction. */
  Price priorityPrice;
  /** Optional price for Rubicon standard access in the auction. */
  Price standardPrice;

  DealTermsRubiconNonGuaranteedTerms();

  DealTermsRubiconNonGuaranteedTerms.fromJson(core.Map _json) {
    if (_json.containsKey("priorityPrice")) {
      priorityPrice = new Price.fromJson(_json["priorityPrice"]);
    }
    if (_json.containsKey("standardPrice")) {
      standardPrice = new Price.fromJson(_json["standardPrice"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (priorityPrice != null) {
      _json["priorityPrice"] = (priorityPrice).toJson();
    }
    if (standardPrice != null) {
      _json["standardPrice"] = (standardPrice).toJson();
    }
    return _json;
  }
}

class DeleteOrderDealsRequest {
  /** List of deals to delete for a given proposal */
  core.List<core.String> dealIds;
  /** The last known proposal revision number. */
  core.String proposalRevisionNumber;
  /** Indicates an optional action to take on the proposal */
  core.String updateAction;

  DeleteOrderDealsRequest();

  DeleteOrderDealsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("dealIds")) {
      dealIds = _json["dealIds"];
    }
    if (_json.containsKey("proposalRevisionNumber")) {
      proposalRevisionNumber = _json["proposalRevisionNumber"];
    }
    if (_json.containsKey("updateAction")) {
      updateAction = _json["updateAction"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dealIds != null) {
      _json["dealIds"] = dealIds;
    }
    if (proposalRevisionNumber != null) {
      _json["proposalRevisionNumber"] = proposalRevisionNumber;
    }
    if (updateAction != null) {
      _json["updateAction"] = updateAction;
    }
    return _json;
  }
}

class DeleteOrderDealsResponse {
  /** List of deals deleted (in the same proposal as passed in the request) */
  core.List<MarketplaceDeal> deals;
  /** The updated revision number for the proposal. */
  core.String proposalRevisionNumber;

  DeleteOrderDealsResponse();

  DeleteOrderDealsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("deals")) {
      deals = _json["deals"].map((value) => new MarketplaceDeal.fromJson(value)).toList();
    }
    if (_json.containsKey("proposalRevisionNumber")) {
      proposalRevisionNumber = _json["proposalRevisionNumber"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deals != null) {
      _json["deals"] = deals.map((value) => (value).toJson()).toList();
    }
    if (proposalRevisionNumber != null) {
      _json["proposalRevisionNumber"] = proposalRevisionNumber;
    }
    return _json;
  }
}

class DeliveryControl {
  core.String creativeBlockingLevel;
  core.String deliveryRateType;
  core.List<DeliveryControlFrequencyCap> frequencyCaps;

  DeliveryControl();

  DeliveryControl.fromJson(core.Map _json) {
    if (_json.containsKey("creativeBlockingLevel")) {
      creativeBlockingLevel = _json["creativeBlockingLevel"];
    }
    if (_json.containsKey("deliveryRateType")) {
      deliveryRateType = _json["deliveryRateType"];
    }
    if (_json.containsKey("frequencyCaps")) {
      frequencyCaps = _json["frequencyCaps"].map((value) => new DeliveryControlFrequencyCap.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creativeBlockingLevel != null) {
      _json["creativeBlockingLevel"] = creativeBlockingLevel;
    }
    if (deliveryRateType != null) {
      _json["deliveryRateType"] = deliveryRateType;
    }
    if (frequencyCaps != null) {
      _json["frequencyCaps"] = frequencyCaps.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class DeliveryControlFrequencyCap {
  core.int maxImpressions;
  core.int numTimeUnits;
  core.String timeUnitType;

  DeliveryControlFrequencyCap();

  DeliveryControlFrequencyCap.fromJson(core.Map _json) {
    if (_json.containsKey("maxImpressions")) {
      maxImpressions = _json["maxImpressions"];
    }
    if (_json.containsKey("numTimeUnits")) {
      numTimeUnits = _json["numTimeUnits"];
    }
    if (_json.containsKey("timeUnitType")) {
      timeUnitType = _json["timeUnitType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (maxImpressions != null) {
      _json["maxImpressions"] = maxImpressions;
    }
    if (numTimeUnits != null) {
      _json["numTimeUnits"] = numTimeUnits;
    }
    if (timeUnitType != null) {
      _json["timeUnitType"] = timeUnitType;
    }
    return _json;
  }
}

/**
 * This message carries publisher provided breakdown. E.g. {dimension_type:
 * 'COUNTRY', [{dimension_value: {id: 1, name: 'US'}}, {dimension_value: {id: 2,
 * name: 'UK'}}]}
 */
class Dimension {
  core.String dimensionType;
  core.List<DimensionDimensionValue> dimensionValues;

  Dimension();

  Dimension.fromJson(core.Map _json) {
    if (_json.containsKey("dimensionType")) {
      dimensionType = _json["dimensionType"];
    }
    if (_json.containsKey("dimensionValues")) {
      dimensionValues = _json["dimensionValues"].map((value) => new DimensionDimensionValue.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensionType != null) {
      _json["dimensionType"] = dimensionType;
    }
    if (dimensionValues != null) {
      _json["dimensionValues"] = dimensionValues.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Value of the dimension. */
class DimensionDimensionValue {
  /** Id of the dimension. */
  core.int id;
  /**
   * Name of the dimension mainly for debugging purposes, except for the case of
   * CREATIVE_SIZE. For CREATIVE_SIZE, strings are used instead of ids.
   */
  core.String name;
  /**
   * Percent of total impressions for a dimension type. e.g. {dimension_type:
   * 'GENDER', [{dimension_value: {id: 1, name: 'MALE', percentage: 60}}]}
   * Gender MALE is 60% of all impressions which have gender.
   */
  core.int percentage;

  DimensionDimensionValue();

  DimensionDimensionValue.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("percentage")) {
      percentage = _json["percentage"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (percentage != null) {
      _json["percentage"] = percentage;
    }
    return _json;
  }
}

class EditAllOrderDealsRequest {
  /**
   * List of deals to edit. Service may perform 3 different operations based on
   * comparison of deals in this list vs deals already persisted in database: 1.
   * Add new deal to proposal If a deal in this list does not exist in the
   * proposal, the service will create a new deal and add it to the proposal.
   * Validation will follow AddOrderDealsRequest. 2. Update existing deal in the
   * proposal If a deal in this list already exist in the proposal, the service
   * will update that existing deal to this new deal in the request. Validation
   * will follow UpdateOrderDealsRequest. 3. Delete deals from the proposal
   * (just need the id) If a existing deal in the proposal is not present in
   * this list, the service will delete that deal from the proposal. Validation
   * will follow DeleteOrderDealsRequest.
   */
  core.List<MarketplaceDeal> deals;
  /**
   * If specified, also updates the proposal in the batch transaction. This is
   * useful when the proposal and the deals need to be updated in one
   * transaction.
   */
  Proposal proposal;
  /** The last known revision number for the proposal. */
  core.String proposalRevisionNumber;
  /** Indicates an optional action to take on the proposal */
  core.String updateAction;

  EditAllOrderDealsRequest();

  EditAllOrderDealsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("deals")) {
      deals = _json["deals"].map((value) => new MarketplaceDeal.fromJson(value)).toList();
    }
    if (_json.containsKey("proposal")) {
      proposal = new Proposal.fromJson(_json["proposal"]);
    }
    if (_json.containsKey("proposalRevisionNumber")) {
      proposalRevisionNumber = _json["proposalRevisionNumber"];
    }
    if (_json.containsKey("updateAction")) {
      updateAction = _json["updateAction"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deals != null) {
      _json["deals"] = deals.map((value) => (value).toJson()).toList();
    }
    if (proposal != null) {
      _json["proposal"] = (proposal).toJson();
    }
    if (proposalRevisionNumber != null) {
      _json["proposalRevisionNumber"] = proposalRevisionNumber;
    }
    if (updateAction != null) {
      _json["updateAction"] = updateAction;
    }
    return _json;
  }
}

class EditAllOrderDealsResponse {
  /** List of all deals in the proposal after edit. */
  core.List<MarketplaceDeal> deals;
  /** The latest revision number after the update has been applied. */
  core.String orderRevisionNumber;

  EditAllOrderDealsResponse();

  EditAllOrderDealsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("deals")) {
      deals = _json["deals"].map((value) => new MarketplaceDeal.fromJson(value)).toList();
    }
    if (_json.containsKey("orderRevisionNumber")) {
      orderRevisionNumber = _json["orderRevisionNumber"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deals != null) {
      _json["deals"] = deals.map((value) => (value).toJson()).toList();
    }
    if (orderRevisionNumber != null) {
      _json["orderRevisionNumber"] = orderRevisionNumber;
    }
    return _json;
  }
}

class GetOffersResponse {
  /** The returned list of products. */
  core.List<Product> products;

  GetOffersResponse();

  GetOffersResponse.fromJson(core.Map _json) {
    if (_json.containsKey("products")) {
      products = _json["products"].map((value) => new Product.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (products != null) {
      _json["products"] = products.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class GetOrderDealsResponse {
  /** List of deals for the proposal */
  core.List<MarketplaceDeal> deals;

  GetOrderDealsResponse();

  GetOrderDealsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("deals")) {
      deals = _json["deals"].map((value) => new MarketplaceDeal.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deals != null) {
      _json["deals"] = deals.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class GetOrderNotesResponse {
  /**
   * The list of matching notes. The notes for a proposal are ordered from
   * oldest to newest. If the notes span multiple proposals, they will be
   * grouped by proposal, with the notes for the most recently modified proposal
   * appearing first.
   */
  core.List<MarketplaceNote> notes;

  GetOrderNotesResponse();

  GetOrderNotesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("notes")) {
      notes = _json["notes"].map((value) => new MarketplaceNote.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (notes != null) {
      _json["notes"] = notes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class GetOrdersResponse {
  /** The list of matching proposals. */
  core.List<Proposal> proposals;

  GetOrdersResponse();

  GetOrdersResponse.fromJson(core.Map _json) {
    if (_json.containsKey("proposals")) {
      proposals = _json["proposals"].map((value) => new Proposal.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (proposals != null) {
      _json["proposals"] = proposals.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class GetPublisherProfilesByAccountIdResponse {
  /** Profiles for the requested publisher */
  core.List<PublisherProfileApiProto> profiles;

  GetPublisherProfilesByAccountIdResponse();

  GetPublisherProfilesByAccountIdResponse.fromJson(core.Map _json) {
    if (_json.containsKey("profiles")) {
      profiles = _json["profiles"].map((value) => new PublisherProfileApiProto.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (profiles != null) {
      _json["profiles"] = profiles.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * A proposal can contain multiple deals. A deal contains the terms and
 * targeting information that is used for serving.
 */
class MarketplaceDeal {
  /** Buyer private data (hidden from seller). */
  PrivateData buyerPrivateData;
  /** The time (ms since epoch) of the deal creation. (readonly) */
  core.String creationTimeMs;
  /** Specifies the creative pre-approval policy (buyer-readonly) */
  core.String creativePreApprovalPolicy;
  /**
   * Specifies whether the creative is safeFrame compatible (buyer-readonly)
   */
  core.String creativeSafeFrameCompatibility;
  /** A unique deal-id for the deal (readonly). */
  core.String dealId;
  /**
   * Metadata about the serving status of this deal (readonly, writes via custom
   * actions)
   */
  DealServingMetadata dealServingMetadata;
  /**
   * The set of fields around delivery control that are interesting for a buyer
   * to see but are non-negotiable. These are set by the publisher. This message
   * is assigned an id of 100 since some day we would want to model this as a
   * protobuf extension.
   */
  DeliveryControl deliveryControl;
  /**
   * The external deal id assigned to this deal once the deal is finalized. This
   * is the deal-id that shows up in serving/reporting etc. (readonly)
   */
  core.String externalDealId;
  /**
   * Proposed flight end time of the deal (ms since epoch) This will generally
   * be stored in a granularity of a second. (updatable)
   */
  core.String flightEndTimeMs;
  /**
   * Proposed flight start time of the deal (ms since epoch) This will generally
   * be stored in a granularity of a second. (updatable)
   */
  core.String flightStartTimeMs;
  /** Description for the deal terms. (buyer-readonly) */
  core.String inventoryDescription;
  /**
   * Indicates whether the current deal is a RFP template. RFP template is
   * created by buyer and not based on seller created products.
   */
  core.bool isRfpTemplate;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "adexchangebuyer#marketplaceDeal".
   */
  core.String kind;
  /** The time (ms since epoch) when the deal was last updated. (readonly) */
  core.String lastUpdateTimeMs;
  /** The name of the deal. (updatable) */
  core.String name;
  /**
   * The product-id from which this deal was created. (readonly, except on
   * create)
   */
  core.String productId;
  /**
   * The revision number of the product that the deal was created from
   * (readonly, except on create)
   */
  core.String productRevisionNumber;
  /**
   * Specifies the creative source for programmatic deals, PUBLISHER means
   * creative is provided by seller and ADVERTISR means creative is provided by
   * buyer. (buyer-readonly)
   */
  core.String programmaticCreativeSource;
  core.String proposalId;
  /** Optional Seller contact information for the deal (buyer-readonly) */
  core.List<ContactInformation> sellerContacts;
  /**
   * The shared targeting visible to buyers and sellers. Each shared targeting
   * entity is AND'd together. (updatable)
   */
  core.List<SharedTargeting> sharedTargetings;
  /**
   * The syndication product associated with the deal. (readonly, except on
   * create)
   */
  core.String syndicationProduct;
  /** The negotiable terms of the deal. (updatable) */
  DealTerms terms;
  core.String webPropertyCode;

  MarketplaceDeal();

  MarketplaceDeal.fromJson(core.Map _json) {
    if (_json.containsKey("buyerPrivateData")) {
      buyerPrivateData = new PrivateData.fromJson(_json["buyerPrivateData"]);
    }
    if (_json.containsKey("creationTimeMs")) {
      creationTimeMs = _json["creationTimeMs"];
    }
    if (_json.containsKey("creativePreApprovalPolicy")) {
      creativePreApprovalPolicy = _json["creativePreApprovalPolicy"];
    }
    if (_json.containsKey("creativeSafeFrameCompatibility")) {
      creativeSafeFrameCompatibility = _json["creativeSafeFrameCompatibility"];
    }
    if (_json.containsKey("dealId")) {
      dealId = _json["dealId"];
    }
    if (_json.containsKey("dealServingMetadata")) {
      dealServingMetadata = new DealServingMetadata.fromJson(_json["dealServingMetadata"]);
    }
    if (_json.containsKey("deliveryControl")) {
      deliveryControl = new DeliveryControl.fromJson(_json["deliveryControl"]);
    }
    if (_json.containsKey("externalDealId")) {
      externalDealId = _json["externalDealId"];
    }
    if (_json.containsKey("flightEndTimeMs")) {
      flightEndTimeMs = _json["flightEndTimeMs"];
    }
    if (_json.containsKey("flightStartTimeMs")) {
      flightStartTimeMs = _json["flightStartTimeMs"];
    }
    if (_json.containsKey("inventoryDescription")) {
      inventoryDescription = _json["inventoryDescription"];
    }
    if (_json.containsKey("isRfpTemplate")) {
      isRfpTemplate = _json["isRfpTemplate"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastUpdateTimeMs")) {
      lastUpdateTimeMs = _json["lastUpdateTimeMs"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("productRevisionNumber")) {
      productRevisionNumber = _json["productRevisionNumber"];
    }
    if (_json.containsKey("programmaticCreativeSource")) {
      programmaticCreativeSource = _json["programmaticCreativeSource"];
    }
    if (_json.containsKey("proposalId")) {
      proposalId = _json["proposalId"];
    }
    if (_json.containsKey("sellerContacts")) {
      sellerContacts = _json["sellerContacts"].map((value) => new ContactInformation.fromJson(value)).toList();
    }
    if (_json.containsKey("sharedTargetings")) {
      sharedTargetings = _json["sharedTargetings"].map((value) => new SharedTargeting.fromJson(value)).toList();
    }
    if (_json.containsKey("syndicationProduct")) {
      syndicationProduct = _json["syndicationProduct"];
    }
    if (_json.containsKey("terms")) {
      terms = new DealTerms.fromJson(_json["terms"]);
    }
    if (_json.containsKey("webPropertyCode")) {
      webPropertyCode = _json["webPropertyCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (buyerPrivateData != null) {
      _json["buyerPrivateData"] = (buyerPrivateData).toJson();
    }
    if (creationTimeMs != null) {
      _json["creationTimeMs"] = creationTimeMs;
    }
    if (creativePreApprovalPolicy != null) {
      _json["creativePreApprovalPolicy"] = creativePreApprovalPolicy;
    }
    if (creativeSafeFrameCompatibility != null) {
      _json["creativeSafeFrameCompatibility"] = creativeSafeFrameCompatibility;
    }
    if (dealId != null) {
      _json["dealId"] = dealId;
    }
    if (dealServingMetadata != null) {
      _json["dealServingMetadata"] = (dealServingMetadata).toJson();
    }
    if (deliveryControl != null) {
      _json["deliveryControl"] = (deliveryControl).toJson();
    }
    if (externalDealId != null) {
      _json["externalDealId"] = externalDealId;
    }
    if (flightEndTimeMs != null) {
      _json["flightEndTimeMs"] = flightEndTimeMs;
    }
    if (flightStartTimeMs != null) {
      _json["flightStartTimeMs"] = flightStartTimeMs;
    }
    if (inventoryDescription != null) {
      _json["inventoryDescription"] = inventoryDescription;
    }
    if (isRfpTemplate != null) {
      _json["isRfpTemplate"] = isRfpTemplate;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastUpdateTimeMs != null) {
      _json["lastUpdateTimeMs"] = lastUpdateTimeMs;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (productRevisionNumber != null) {
      _json["productRevisionNumber"] = productRevisionNumber;
    }
    if (programmaticCreativeSource != null) {
      _json["programmaticCreativeSource"] = programmaticCreativeSource;
    }
    if (proposalId != null) {
      _json["proposalId"] = proposalId;
    }
    if (sellerContacts != null) {
      _json["sellerContacts"] = sellerContacts.map((value) => (value).toJson()).toList();
    }
    if (sharedTargetings != null) {
      _json["sharedTargetings"] = sharedTargetings.map((value) => (value).toJson()).toList();
    }
    if (syndicationProduct != null) {
      _json["syndicationProduct"] = syndicationProduct;
    }
    if (terms != null) {
      _json["terms"] = (terms).toJson();
    }
    if (webPropertyCode != null) {
      _json["webPropertyCode"] = webPropertyCode;
    }
    return _json;
  }
}

class MarketplaceDealParty {
  /**
   * The buyer/seller associated with the deal. One of buyer/seller is specified
   * for a deal-party.
   */
  Buyer buyer;
  /**
   * The buyer/seller associated with the deal. One of buyer/seller is specified
   * for a deal party.
   */
  Seller seller;

  MarketplaceDealParty();

  MarketplaceDealParty.fromJson(core.Map _json) {
    if (_json.containsKey("buyer")) {
      buyer = new Buyer.fromJson(_json["buyer"]);
    }
    if (_json.containsKey("seller")) {
      seller = new Seller.fromJson(_json["seller"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (buyer != null) {
      _json["buyer"] = (buyer).toJson();
    }
    if (seller != null) {
      _json["seller"] = (seller).toJson();
    }
    return _json;
  }
}

class MarketplaceLabel {
  /** The accountId of the party that created the label. */
  core.String accountId;
  /** The creation time (in ms since epoch) for the label. */
  core.String createTimeMs;
  /** Information about the party that created the label. */
  MarketplaceDealParty deprecatedMarketplaceDealParty;
  /** The label to use. */
  core.String label;

  MarketplaceLabel();

  MarketplaceLabel.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("createTimeMs")) {
      createTimeMs = _json["createTimeMs"];
    }
    if (_json.containsKey("deprecatedMarketplaceDealParty")) {
      deprecatedMarketplaceDealParty = new MarketplaceDealParty.fromJson(_json["deprecatedMarketplaceDealParty"]);
    }
    if (_json.containsKey("label")) {
      label = _json["label"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (createTimeMs != null) {
      _json["createTimeMs"] = createTimeMs;
    }
    if (deprecatedMarketplaceDealParty != null) {
      _json["deprecatedMarketplaceDealParty"] = (deprecatedMarketplaceDealParty).toJson();
    }
    if (label != null) {
      _json["label"] = label;
    }
    return _json;
  }
}

/**
 * A proposal is associated with a bunch of notes which may optionally be
 * associated with a deal and/or revision number.
 */
class MarketplaceNote {
  /** The role of the person (buyer/seller) creating the note. (readonly) */
  core.String creatorRole;
  /**
   * Notes can optionally be associated with a deal. (readonly, except on
   * create)
   */
  core.String dealId;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "adexchangebuyer#marketplaceNote".
   */
  core.String kind;
  /** The actual note to attach. (readonly, except on create) */
  core.String note;
  /** The unique id for the note. (readonly) */
  core.String noteId;
  /** The proposalId that a note is attached to. (readonly) */
  core.String proposalId;
  /**
   * If the note is associated with a proposal revision number, then store that
   * here. (readonly, except on create)
   */
  core.String proposalRevisionNumber;
  /** The timestamp (ms since epoch) that this note was created. (readonly) */
  core.String timestampMs;

  MarketplaceNote();

  MarketplaceNote.fromJson(core.Map _json) {
    if (_json.containsKey("creatorRole")) {
      creatorRole = _json["creatorRole"];
    }
    if (_json.containsKey("dealId")) {
      dealId = _json["dealId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("note")) {
      note = _json["note"];
    }
    if (_json.containsKey("noteId")) {
      noteId = _json["noteId"];
    }
    if (_json.containsKey("proposalId")) {
      proposalId = _json["proposalId"];
    }
    if (_json.containsKey("proposalRevisionNumber")) {
      proposalRevisionNumber = _json["proposalRevisionNumber"];
    }
    if (_json.containsKey("timestampMs")) {
      timestampMs = _json["timestampMs"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creatorRole != null) {
      _json["creatorRole"] = creatorRole;
    }
    if (dealId != null) {
      _json["dealId"] = dealId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (note != null) {
      _json["note"] = note;
    }
    if (noteId != null) {
      _json["noteId"] = noteId;
    }
    if (proposalId != null) {
      _json["proposalId"] = proposalId;
    }
    if (proposalRevisionNumber != null) {
      _json["proposalRevisionNumber"] = proposalRevisionNumber;
    }
    if (timestampMs != null) {
      _json["timestampMs"] = timestampMs;
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

class PretargetingConfigVideoPlayerSizes {
  /**
   * The type of aspect ratio. Leave this field blank to match all aspect
   * ratios.
   */
  core.String aspectRatio;
  /**
   * The minimum player height in pixels. Leave this field blank to match any
   * player height.
   */
  core.String minHeight;
  /**
   * The minimum player width in pixels. Leave this field blank to match any
   * player width.
   */
  core.String minWidth;

  PretargetingConfigVideoPlayerSizes();

  PretargetingConfigVideoPlayerSizes.fromJson(core.Map _json) {
    if (_json.containsKey("aspectRatio")) {
      aspectRatio = _json["aspectRatio"];
    }
    if (_json.containsKey("minHeight")) {
      minHeight = _json["minHeight"];
    }
    if (_json.containsKey("minWidth")) {
      minWidth = _json["minWidth"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aspectRatio != null) {
      _json["aspectRatio"] = aspectRatio;
    }
    if (minHeight != null) {
      _json["minHeight"] = minHeight;
    }
    if (minWidth != null) {
      _json["minWidth"] = minWidth;
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
   * Requests where the predicted viewability is below the specified decile will
   * not match. E.g. if the buyer sets this value to 5, requests from slots
   * where the predicted viewability is below 50% will not match. If the
   * predicted viewability is unknown this field will be ignored.
   */
  core.int minimumViewabilityDecile;
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
  /**
   * Requests containing the specified type of user data will match. Possible
   * values are HOSTED_MATCH_DATA, which means the request is cookie-targetable
   * and has a match in the buyer's hosted match table, and COOKIE_OR_IDFA,
   * which means the request has either a targetable cookie or an iOS IDFA.
   */
  core.List<core.String> userIdentifierDataRequired;
  /** Requests containing any of these user list ids will match. */
  core.List<core.String> userLists;
  /**
   * Requests that allow any of these vendor ids will match. Values are from
   * vendors.txt in the downloadable files section.
   */
  core.List<core.String> vendorTypes;
  /** Requests containing any of these vertical ids will match. */
  core.List<core.String> verticals;
  /**
   * Video requests satisfying any of these player size constraints will match.
   */
  core.List<PretargetingConfigVideoPlayerSizes> videoPlayerSizes;

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
    if (_json.containsKey("minimumViewabilityDecile")) {
      minimumViewabilityDecile = _json["minimumViewabilityDecile"];
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
    if (_json.containsKey("userIdentifierDataRequired")) {
      userIdentifierDataRequired = _json["userIdentifierDataRequired"];
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
    if (_json.containsKey("videoPlayerSizes")) {
      videoPlayerSizes = _json["videoPlayerSizes"].map((value) => new PretargetingConfigVideoPlayerSizes.fromJson(value)).toList();
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
    if (minimumViewabilityDecile != null) {
      _json["minimumViewabilityDecile"] = minimumViewabilityDecile;
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
    if (userIdentifierDataRequired != null) {
      _json["userIdentifierDataRequired"] = userIdentifierDataRequired;
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
    if (videoPlayerSizes != null) {
      _json["videoPlayerSizes"] = videoPlayerSizes.map((value) => (value).toJson()).toList();
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

class Price {
  /** The price value in micros. */
  core.double amountMicros;
  /** The currency code for the price. */
  core.String currencyCode;
  /** In case of CPD deals, the expected CPM in micros. */
  core.double expectedCpmMicros;
  /** The pricing type for the deal/product. */
  core.String pricingType;

  Price();

  Price.fromJson(core.Map _json) {
    if (_json.containsKey("amountMicros")) {
      amountMicros = _json["amountMicros"];
    }
    if (_json.containsKey("currencyCode")) {
      currencyCode = _json["currencyCode"];
    }
    if (_json.containsKey("expectedCpmMicros")) {
      expectedCpmMicros = _json["expectedCpmMicros"];
    }
    if (_json.containsKey("pricingType")) {
      pricingType = _json["pricingType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amountMicros != null) {
      _json["amountMicros"] = amountMicros;
    }
    if (currencyCode != null) {
      _json["currencyCode"] = currencyCode;
    }
    if (expectedCpmMicros != null) {
      _json["expectedCpmMicros"] = expectedCpmMicros;
    }
    if (pricingType != null) {
      _json["pricingType"] = pricingType;
    }
    return _json;
  }
}

/**
 * Used to specify pricing rules for buyers/advertisers. Each PricePerBuyer in
 * an product can become [0,1] deals. To check if there is a PricePerBuyer for a
 * particular buyer or buyer/advertiser pair, we look for the most specific
 * matching rule - we first look for a rule matching the buyer and advertiser,
 * next a rule with the buyer but an empty advertiser list, and otherwise look
 * for a matching rule where no buyer is set.
 */
class PricePerBuyer {
  /** Optional access type for this buyer. */
  core.String auctionTier;
  /**
   * The buyer who will pay this price. If unset, all buyers can pay this price
   * (if the advertisers match, and there's no more specific rule matching the
   * buyer).
   */
  Buyer buyer;
  /** The specified price */
  Price price;

  PricePerBuyer();

  PricePerBuyer.fromJson(core.Map _json) {
    if (_json.containsKey("auctionTier")) {
      auctionTier = _json["auctionTier"];
    }
    if (_json.containsKey("buyer")) {
      buyer = new Buyer.fromJson(_json["buyer"]);
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (auctionTier != null) {
      _json["auctionTier"] = auctionTier;
    }
    if (buyer != null) {
      _json["buyer"] = (buyer).toJson();
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    return _json;
  }
}

class PrivateData {
  core.String referenceId;
  core.String referencePayload;
  core.List<core.int> get referencePayloadAsBytes {
    return convert.BASE64.decode(referencePayload);
  }

  void set referencePayloadAsBytes(core.List<core.int> _bytes) {
    referencePayload = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  PrivateData();

  PrivateData.fromJson(core.Map _json) {
    if (_json.containsKey("referenceId")) {
      referenceId = _json["referenceId"];
    }
    if (_json.containsKey("referencePayload")) {
      referencePayload = _json["referencePayload"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (referenceId != null) {
      _json["referenceId"] = referenceId;
    }
    if (referencePayload != null) {
      _json["referencePayload"] = referencePayload;
    }
    return _json;
  }
}

/**
 * A product is segment of inventory that a seller wishes to sell. It is
 * associated with certain terms and targeting information which helps buyer
 * know more about the inventory. Each field in a product can have one of the
 * following setting:
 *
 * (readonly) - It is an error to try and set this field. (buyer-readonly) -
 * Only the seller can set this field. (seller-readonly) - Only the buyer can
 * set this field. (updatable) - The field is updatable at all times by either
 * buyer or the seller.
 */
class Product {
  /** Creation time in ms. since epoch (readonly) */
  core.String creationTimeMs;
  /**
   * Optional contact information for the creator of this product.
   * (buyer-readonly)
   */
  core.List<ContactInformation> creatorContacts;
  /**
   * The set of fields around delivery control that are interesting for a buyer
   * to see but are non-negotiable. These are set by the publisher. This message
   * is assigned an id of 100 since some day we would want to model this as a
   * protobuf extension.
   */
  DeliveryControl deliveryControl;
  /** The proposed end time for the deal (ms since epoch) (buyer-readonly) */
  core.String flightEndTimeMs;
  /**
   * Inventory availability dates. (times are in ms since epoch) The granularity
   * is generally in the order of seconds. (buyer-readonly)
   */
  core.String flightStartTimeMs;
  /**
   * If the creator has already signed off on the product, then the buyer can
   * finalize the deal by accepting the product as is. When copying to a
   * proposal, if any of the terms are changed, then auto_finalize is
   * automatically set to false.
   */
  core.bool hasCreatorSignedOff;
  /**
   * What exchange will provide this inventory (readonly, except on create).
   */
  core.String inventorySource;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "adexchangebuyer#product".
   */
  core.String kind;
  /** Optional List of labels for the product (optional, buyer-readonly). */
  core.List<MarketplaceLabel> labels;
  /** Time of last update in ms. since epoch (readonly) */
  core.String lastUpdateTimeMs;
  /** Optional legacy offer id if this offer is a preferred deal offer. */
  core.String legacyOfferId;
  /**
   * Marketplace publisher profile Id. This Id differs from the regular
   * publisher_profile_id in that 1. This is a new id, the old Id will be
   * deprecated in 2017. 2. This id uniquely identifies a publisher profile by
   * itself.
   */
  core.String marketplacePublisherProfileId;
  /** The name for this product as set by the seller. (buyer-readonly) */
  core.String name;
  /** Optional private auction id if this offer is a private auction offer. */
  core.String privateAuctionId;
  /** The unique id for the product (readonly) */
  core.String productId;
  /**
   * Id of the publisher profile for a given seller. A (seller.account_id,
   * publisher_profile_id) pair uniquely identifies a publisher profile. Buyers
   * can call the PublisherProfiles::List endpoint to get a list of publisher
   * profiles for a given seller.
   */
  core.String publisherProfileId;
  /** Publisher self-provided forecast information. */
  PublisherProvidedForecast publisherProvidedForecast;
  /** The revision number of the product. (readonly) */
  core.String revisionNumber;
  /**
   * Information about the seller that created this product (readonly, except on
   * create)
   */
  Seller seller;
  /**
   * Targeting that is shared between the buyer and the seller. Each targeting
   * criteria has a specified key and for each key there is a list of inclusion
   * value or exclusion values. (buyer-readonly)
   */
  core.List<SharedTargeting> sharedTargetings;
  /** The state of the product. (buyer-readonly) */
  core.String state;
  /**
   * The syndication product associated with the deal. (readonly, except on
   * create)
   */
  core.String syndicationProduct;
  /** The negotiable terms of the deal (buyer-readonly) */
  DealTerms terms;
  /**
   * The web property code for the seller. This field is meant to be copied over
   * as is when creating deals.
   */
  core.String webPropertyCode;

  Product();

  Product.fromJson(core.Map _json) {
    if (_json.containsKey("creationTimeMs")) {
      creationTimeMs = _json["creationTimeMs"];
    }
    if (_json.containsKey("creatorContacts")) {
      creatorContacts = _json["creatorContacts"].map((value) => new ContactInformation.fromJson(value)).toList();
    }
    if (_json.containsKey("deliveryControl")) {
      deliveryControl = new DeliveryControl.fromJson(_json["deliveryControl"]);
    }
    if (_json.containsKey("flightEndTimeMs")) {
      flightEndTimeMs = _json["flightEndTimeMs"];
    }
    if (_json.containsKey("flightStartTimeMs")) {
      flightStartTimeMs = _json["flightStartTimeMs"];
    }
    if (_json.containsKey("hasCreatorSignedOff")) {
      hasCreatorSignedOff = _json["hasCreatorSignedOff"];
    }
    if (_json.containsKey("inventorySource")) {
      inventorySource = _json["inventorySource"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"].map((value) => new MarketplaceLabel.fromJson(value)).toList();
    }
    if (_json.containsKey("lastUpdateTimeMs")) {
      lastUpdateTimeMs = _json["lastUpdateTimeMs"];
    }
    if (_json.containsKey("legacyOfferId")) {
      legacyOfferId = _json["legacyOfferId"];
    }
    if (_json.containsKey("marketplacePublisherProfileId")) {
      marketplacePublisherProfileId = _json["marketplacePublisherProfileId"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("privateAuctionId")) {
      privateAuctionId = _json["privateAuctionId"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("publisherProfileId")) {
      publisherProfileId = _json["publisherProfileId"];
    }
    if (_json.containsKey("publisherProvidedForecast")) {
      publisherProvidedForecast = new PublisherProvidedForecast.fromJson(_json["publisherProvidedForecast"]);
    }
    if (_json.containsKey("revisionNumber")) {
      revisionNumber = _json["revisionNumber"];
    }
    if (_json.containsKey("seller")) {
      seller = new Seller.fromJson(_json["seller"]);
    }
    if (_json.containsKey("sharedTargetings")) {
      sharedTargetings = _json["sharedTargetings"].map((value) => new SharedTargeting.fromJson(value)).toList();
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("syndicationProduct")) {
      syndicationProduct = _json["syndicationProduct"];
    }
    if (_json.containsKey("terms")) {
      terms = new DealTerms.fromJson(_json["terms"]);
    }
    if (_json.containsKey("webPropertyCode")) {
      webPropertyCode = _json["webPropertyCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creationTimeMs != null) {
      _json["creationTimeMs"] = creationTimeMs;
    }
    if (creatorContacts != null) {
      _json["creatorContacts"] = creatorContacts.map((value) => (value).toJson()).toList();
    }
    if (deliveryControl != null) {
      _json["deliveryControl"] = (deliveryControl).toJson();
    }
    if (flightEndTimeMs != null) {
      _json["flightEndTimeMs"] = flightEndTimeMs;
    }
    if (flightStartTimeMs != null) {
      _json["flightStartTimeMs"] = flightStartTimeMs;
    }
    if (hasCreatorSignedOff != null) {
      _json["hasCreatorSignedOff"] = hasCreatorSignedOff;
    }
    if (inventorySource != null) {
      _json["inventorySource"] = inventorySource;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (labels != null) {
      _json["labels"] = labels.map((value) => (value).toJson()).toList();
    }
    if (lastUpdateTimeMs != null) {
      _json["lastUpdateTimeMs"] = lastUpdateTimeMs;
    }
    if (legacyOfferId != null) {
      _json["legacyOfferId"] = legacyOfferId;
    }
    if (marketplacePublisherProfileId != null) {
      _json["marketplacePublisherProfileId"] = marketplacePublisherProfileId;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (privateAuctionId != null) {
      _json["privateAuctionId"] = privateAuctionId;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (publisherProfileId != null) {
      _json["publisherProfileId"] = publisherProfileId;
    }
    if (publisherProvidedForecast != null) {
      _json["publisherProvidedForecast"] = (publisherProvidedForecast).toJson();
    }
    if (revisionNumber != null) {
      _json["revisionNumber"] = revisionNumber;
    }
    if (seller != null) {
      _json["seller"] = (seller).toJson();
    }
    if (sharedTargetings != null) {
      _json["sharedTargetings"] = sharedTargetings.map((value) => (value).toJson()).toList();
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (syndicationProduct != null) {
      _json["syndicationProduct"] = syndicationProduct;
    }
    if (terms != null) {
      _json["terms"] = (terms).toJson();
    }
    if (webPropertyCode != null) {
      _json["webPropertyCode"] = webPropertyCode;
    }
    return _json;
  }
}

/**
 * Represents a proposal in the marketplace. A proposal is the unit of
 * negotiation between a seller and a buyer and contains deals which are served.
 * Each field in a proposal can have one of the following setting:
 *
 * (readonly) - It is an error to try and set this field. (buyer-readonly) -
 * Only the seller can set this field. (seller-readonly) - Only the buyer can
 * set this field. (updatable) - The field is updatable at all times by either
 * buyer or the seller.
 */
class Proposal {
  /**
   * Reference to the buyer that will get billed for this proposal. (readonly)
   */
  Buyer billedBuyer;
  /** Reference to the buyer on the proposal. (readonly, except on create) */
  Buyer buyer;
  /** Optional contact information of the buyer. (seller-readonly) */
  core.List<ContactInformation> buyerContacts;
  /** Private data for buyer. (hidden from seller). */
  PrivateData buyerPrivateData;
  /** IDs of DBM advertisers permission to this proposal. */
  core.List<core.String> dbmAdvertiserIds;
  /**
   * When an proposal is in an accepted state, indicates whether the buyer has
   * signed off. Once both sides have signed off on a deal, the proposal can be
   * finalized by the seller. (seller-readonly)
   */
  core.bool hasBuyerSignedOff;
  /**
   * When an proposal is in an accepted state, indicates whether the buyer has
   * signed off Once both sides have signed off on a deal, the proposal can be
   * finalized by the seller. (buyer-readonly)
   */
  core.bool hasSellerSignedOff;
  /**
   * What exchange will provide this inventory (readonly, except on create).
   */
  core.String inventorySource;
  /** True if the proposal is being renegotiated (readonly). */
  core.bool isRenegotiating;
  /**
   * True, if the buyside inventory setup is complete for this proposal.
   * (readonly, except via OrderSetupCompleted action)
   */
  core.bool isSetupComplete;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "adexchangebuyer#proposal".
   */
  core.String kind;
  /** List of labels associated with the proposal. (readonly) */
  core.List<MarketplaceLabel> labels;
  /**
   * The role of the last user that either updated the proposal or left a
   * comment. (readonly)
   */
  core.String lastUpdaterOrCommentorRole;
  /** The name for the proposal (updatable) */
  core.String name;
  /** Optional negotiation id if this proposal is a preferred deal proposal. */
  core.String negotiationId;
  /** Indicates whether the buyer/seller created the proposal.(readonly) */
  core.String originatorRole;
  /**
   * Optional private auction id if this proposal is a private auction proposal.
   */
  core.String privateAuctionId;
  /** The unique id of the proposal. (readonly). */
  core.String proposalId;
  /** The current state of the proposal. (readonly) */
  core.String proposalState;
  /** The revision number for the proposal (readonly). */
  core.String revisionNumber;
  /**
   * The time (ms since epoch) when the proposal was last revised (readonly).
   */
  core.String revisionTimeMs;
  /** Reference to the seller on the proposal. (readonly, except on create) */
  Seller seller;
  /** Optional contact information of the seller (buyer-readonly). */
  core.List<ContactInformation> sellerContacts;

  Proposal();

  Proposal.fromJson(core.Map _json) {
    if (_json.containsKey("billedBuyer")) {
      billedBuyer = new Buyer.fromJson(_json["billedBuyer"]);
    }
    if (_json.containsKey("buyer")) {
      buyer = new Buyer.fromJson(_json["buyer"]);
    }
    if (_json.containsKey("buyerContacts")) {
      buyerContacts = _json["buyerContacts"].map((value) => new ContactInformation.fromJson(value)).toList();
    }
    if (_json.containsKey("buyerPrivateData")) {
      buyerPrivateData = new PrivateData.fromJson(_json["buyerPrivateData"]);
    }
    if (_json.containsKey("dbmAdvertiserIds")) {
      dbmAdvertiserIds = _json["dbmAdvertiserIds"];
    }
    if (_json.containsKey("hasBuyerSignedOff")) {
      hasBuyerSignedOff = _json["hasBuyerSignedOff"];
    }
    if (_json.containsKey("hasSellerSignedOff")) {
      hasSellerSignedOff = _json["hasSellerSignedOff"];
    }
    if (_json.containsKey("inventorySource")) {
      inventorySource = _json["inventorySource"];
    }
    if (_json.containsKey("isRenegotiating")) {
      isRenegotiating = _json["isRenegotiating"];
    }
    if (_json.containsKey("isSetupComplete")) {
      isSetupComplete = _json["isSetupComplete"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"].map((value) => new MarketplaceLabel.fromJson(value)).toList();
    }
    if (_json.containsKey("lastUpdaterOrCommentorRole")) {
      lastUpdaterOrCommentorRole = _json["lastUpdaterOrCommentorRole"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("negotiationId")) {
      negotiationId = _json["negotiationId"];
    }
    if (_json.containsKey("originatorRole")) {
      originatorRole = _json["originatorRole"];
    }
    if (_json.containsKey("privateAuctionId")) {
      privateAuctionId = _json["privateAuctionId"];
    }
    if (_json.containsKey("proposalId")) {
      proposalId = _json["proposalId"];
    }
    if (_json.containsKey("proposalState")) {
      proposalState = _json["proposalState"];
    }
    if (_json.containsKey("revisionNumber")) {
      revisionNumber = _json["revisionNumber"];
    }
    if (_json.containsKey("revisionTimeMs")) {
      revisionTimeMs = _json["revisionTimeMs"];
    }
    if (_json.containsKey("seller")) {
      seller = new Seller.fromJson(_json["seller"]);
    }
    if (_json.containsKey("sellerContacts")) {
      sellerContacts = _json["sellerContacts"].map((value) => new ContactInformation.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (billedBuyer != null) {
      _json["billedBuyer"] = (billedBuyer).toJson();
    }
    if (buyer != null) {
      _json["buyer"] = (buyer).toJson();
    }
    if (buyerContacts != null) {
      _json["buyerContacts"] = buyerContacts.map((value) => (value).toJson()).toList();
    }
    if (buyerPrivateData != null) {
      _json["buyerPrivateData"] = (buyerPrivateData).toJson();
    }
    if (dbmAdvertiserIds != null) {
      _json["dbmAdvertiserIds"] = dbmAdvertiserIds;
    }
    if (hasBuyerSignedOff != null) {
      _json["hasBuyerSignedOff"] = hasBuyerSignedOff;
    }
    if (hasSellerSignedOff != null) {
      _json["hasSellerSignedOff"] = hasSellerSignedOff;
    }
    if (inventorySource != null) {
      _json["inventorySource"] = inventorySource;
    }
    if (isRenegotiating != null) {
      _json["isRenegotiating"] = isRenegotiating;
    }
    if (isSetupComplete != null) {
      _json["isSetupComplete"] = isSetupComplete;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (labels != null) {
      _json["labels"] = labels.map((value) => (value).toJson()).toList();
    }
    if (lastUpdaterOrCommentorRole != null) {
      _json["lastUpdaterOrCommentorRole"] = lastUpdaterOrCommentorRole;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (negotiationId != null) {
      _json["negotiationId"] = negotiationId;
    }
    if (originatorRole != null) {
      _json["originatorRole"] = originatorRole;
    }
    if (privateAuctionId != null) {
      _json["privateAuctionId"] = privateAuctionId;
    }
    if (proposalId != null) {
      _json["proposalId"] = proposalId;
    }
    if (proposalState != null) {
      _json["proposalState"] = proposalState;
    }
    if (revisionNumber != null) {
      _json["revisionNumber"] = revisionNumber;
    }
    if (revisionTimeMs != null) {
      _json["revisionTimeMs"] = revisionTimeMs;
    }
    if (seller != null) {
      _json["seller"] = (seller).toJson();
    }
    if (sellerContacts != null) {
      _json["sellerContacts"] = sellerContacts.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class PublisherProfileApiProto {
  /** The account id of the seller. */
  core.String accountId;
  /** Publisher provided info on its audience. */
  core.String audience;
  /** A pitch statement for the buyer */
  core.String buyerPitchStatement;
  /** Direct contact for the publisher profile. */
  core.String directContact;
  /**
   * Exchange where this publisher profile is from. E.g. AdX, Rubicon etc...
   */
  core.String exchange;
  /** Link to publisher's Google+ page. */
  core.String googlePlusLink;
  /**
   * True, if this is the parent profile, which represents all domains owned by
   * the publisher.
   */
  core.bool isParent;
  /** True, if this profile is published. Deprecated for state. */
  core.bool isPublished;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "adexchangebuyer#publisherProfileApiProto".
   */
  core.String kind;
  /** The url to the logo for the publisher. */
  core.String logoUrl;
  /** The url for additional marketing and sales materials. */
  core.String mediaKitLink;
  core.String name;
  /** Publisher provided overview. */
  core.String overview;
  /**
   * The pair of (seller.account_id, profile_id) uniquely identifies a publisher
   * profile for a given publisher.
   */
  core.int profileId;
  /** Programmatic contact for the publisher profile. */
  core.String programmaticContact;
  /**
   * The list of domains represented in this publisher profile. Empty if this is
   * a parent profile.
   */
  core.List<core.String> publisherDomains;
  /** Unique Id for publisher profile. */
  core.String publisherProfileId;
  /** Publisher provided forecasting information. */
  PublisherProvidedForecast publisherProvidedForecast;
  /** Link to publisher rate card */
  core.String rateCardInfoLink;
  /** Link for a sample content page. */
  core.String samplePageLink;
  /** Seller of the publisher profile. */
  Seller seller;
  /** State of the publisher profile. */
  core.String state;
  /** Publisher provided key metrics and rankings. */
  core.List<core.String> topHeadlines;

  PublisherProfileApiProto();

  PublisherProfileApiProto.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("audience")) {
      audience = _json["audience"];
    }
    if (_json.containsKey("buyerPitchStatement")) {
      buyerPitchStatement = _json["buyerPitchStatement"];
    }
    if (_json.containsKey("directContact")) {
      directContact = _json["directContact"];
    }
    if (_json.containsKey("exchange")) {
      exchange = _json["exchange"];
    }
    if (_json.containsKey("googlePlusLink")) {
      googlePlusLink = _json["googlePlusLink"];
    }
    if (_json.containsKey("isParent")) {
      isParent = _json["isParent"];
    }
    if (_json.containsKey("isPublished")) {
      isPublished = _json["isPublished"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("logoUrl")) {
      logoUrl = _json["logoUrl"];
    }
    if (_json.containsKey("mediaKitLink")) {
      mediaKitLink = _json["mediaKitLink"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("overview")) {
      overview = _json["overview"];
    }
    if (_json.containsKey("profileId")) {
      profileId = _json["profileId"];
    }
    if (_json.containsKey("programmaticContact")) {
      programmaticContact = _json["programmaticContact"];
    }
    if (_json.containsKey("publisherDomains")) {
      publisherDomains = _json["publisherDomains"];
    }
    if (_json.containsKey("publisherProfileId")) {
      publisherProfileId = _json["publisherProfileId"];
    }
    if (_json.containsKey("publisherProvidedForecast")) {
      publisherProvidedForecast = new PublisherProvidedForecast.fromJson(_json["publisherProvidedForecast"]);
    }
    if (_json.containsKey("rateCardInfoLink")) {
      rateCardInfoLink = _json["rateCardInfoLink"];
    }
    if (_json.containsKey("samplePageLink")) {
      samplePageLink = _json["samplePageLink"];
    }
    if (_json.containsKey("seller")) {
      seller = new Seller.fromJson(_json["seller"]);
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("topHeadlines")) {
      topHeadlines = _json["topHeadlines"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (audience != null) {
      _json["audience"] = audience;
    }
    if (buyerPitchStatement != null) {
      _json["buyerPitchStatement"] = buyerPitchStatement;
    }
    if (directContact != null) {
      _json["directContact"] = directContact;
    }
    if (exchange != null) {
      _json["exchange"] = exchange;
    }
    if (googlePlusLink != null) {
      _json["googlePlusLink"] = googlePlusLink;
    }
    if (isParent != null) {
      _json["isParent"] = isParent;
    }
    if (isPublished != null) {
      _json["isPublished"] = isPublished;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (logoUrl != null) {
      _json["logoUrl"] = logoUrl;
    }
    if (mediaKitLink != null) {
      _json["mediaKitLink"] = mediaKitLink;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (overview != null) {
      _json["overview"] = overview;
    }
    if (profileId != null) {
      _json["profileId"] = profileId;
    }
    if (programmaticContact != null) {
      _json["programmaticContact"] = programmaticContact;
    }
    if (publisherDomains != null) {
      _json["publisherDomains"] = publisherDomains;
    }
    if (publisherProfileId != null) {
      _json["publisherProfileId"] = publisherProfileId;
    }
    if (publisherProvidedForecast != null) {
      _json["publisherProvidedForecast"] = (publisherProvidedForecast).toJson();
    }
    if (rateCardInfoLink != null) {
      _json["rateCardInfoLink"] = rateCardInfoLink;
    }
    if (samplePageLink != null) {
      _json["samplePageLink"] = samplePageLink;
    }
    if (seller != null) {
      _json["seller"] = (seller).toJson();
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (topHeadlines != null) {
      _json["topHeadlines"] = topHeadlines;
    }
    return _json;
  }
}

/** This message carries publisher provided forecasting information. */
class PublisherProvidedForecast {
  /** Publisher provided dimensions. E.g. geo, sizes etc... */
  core.List<Dimension> dimensions;
  /** Publisher provided weekly impressions. */
  core.String weeklyImpressions;
  /** Publisher provided weekly uniques. */
  core.String weeklyUniques;

  PublisherProvidedForecast();

  PublisherProvidedForecast.fromJson(core.Map _json) {
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("weeklyImpressions")) {
      weeklyImpressions = _json["weeklyImpressions"];
    }
    if (_json.containsKey("weeklyUniques")) {
      weeklyUniques = _json["weeklyUniques"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensions != null) {
      _json["dimensions"] = dimensions.map((value) => (value).toJson()).toList();
    }
    if (weeklyImpressions != null) {
      _json["weeklyImpressions"] = weeklyImpressions;
    }
    if (weeklyUniques != null) {
      _json["weeklyUniques"] = weeklyUniques;
    }
    return _json;
  }
}

class Seller {
  /**
   * The unique id for the seller. The seller fills in this field. The seller
   * account id is then available to buyer in the product.
   */
  core.String accountId;
  /** Optional sub-account id for the seller. */
  core.String subAccountId;

  Seller();

  Seller.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("subAccountId")) {
      subAccountId = _json["subAccountId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (subAccountId != null) {
      _json["subAccountId"] = subAccountId;
    }
    return _json;
  }
}

class SharedTargeting {
  /**
   * The list of values to exclude from targeting. Each value is AND'd together.
   */
  core.List<TargetingValue> exclusions;
  /**
   * The list of value to include as part of the targeting. Each value is OR'd
   * together.
   */
  core.List<TargetingValue> inclusions;
  /** The key representing the shared targeting criterion. */
  core.String key;

  SharedTargeting();

  SharedTargeting.fromJson(core.Map _json) {
    if (_json.containsKey("exclusions")) {
      exclusions = _json["exclusions"].map((value) => new TargetingValue.fromJson(value)).toList();
    }
    if (_json.containsKey("inclusions")) {
      inclusions = _json["inclusions"].map((value) => new TargetingValue.fromJson(value)).toList();
    }
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (exclusions != null) {
      _json["exclusions"] = exclusions.map((value) => (value).toJson()).toList();
    }
    if (inclusions != null) {
      _json["inclusions"] = inclusions.map((value) => (value).toJson()).toList();
    }
    if (key != null) {
      _json["key"] = key;
    }
    return _json;
  }
}

class TargetingValue {
  /** The creative size value to exclude/include. */
  TargetingValueCreativeSize creativeSizeValue;
  /**
   * The daypart targeting to include / exclude. Filled in when the key is
   * GOOG_DAYPART_TARGETING.
   */
  TargetingValueDayPartTargeting dayPartTargetingValue;
  /** The long value to exclude/include. */
  core.String longValue;
  /** The string value to exclude/include. */
  core.String stringValue;

  TargetingValue();

  TargetingValue.fromJson(core.Map _json) {
    if (_json.containsKey("creativeSizeValue")) {
      creativeSizeValue = new TargetingValueCreativeSize.fromJson(_json["creativeSizeValue"]);
    }
    if (_json.containsKey("dayPartTargetingValue")) {
      dayPartTargetingValue = new TargetingValueDayPartTargeting.fromJson(_json["dayPartTargetingValue"]);
    }
    if (_json.containsKey("longValue")) {
      longValue = _json["longValue"];
    }
    if (_json.containsKey("stringValue")) {
      stringValue = _json["stringValue"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creativeSizeValue != null) {
      _json["creativeSizeValue"] = (creativeSizeValue).toJson();
    }
    if (dayPartTargetingValue != null) {
      _json["dayPartTargetingValue"] = (dayPartTargetingValue).toJson();
    }
    if (longValue != null) {
      _json["longValue"] = longValue;
    }
    if (stringValue != null) {
      _json["stringValue"] = stringValue;
    }
    return _json;
  }
}

class TargetingValueCreativeSize {
  /** For video size type, the list of companion sizes. */
  core.List<TargetingValueSize> companionSizes;
  /** The Creative size type. */
  core.String creativeSizeType;
  /**
   * For regular or video creative size type, specifies the size of the
   * creative.
   */
  TargetingValueSize size;
  /** The skippable ad type for video size. */
  core.String skippableAdType;

  TargetingValueCreativeSize();

  TargetingValueCreativeSize.fromJson(core.Map _json) {
    if (_json.containsKey("companionSizes")) {
      companionSizes = _json["companionSizes"].map((value) => new TargetingValueSize.fromJson(value)).toList();
    }
    if (_json.containsKey("creativeSizeType")) {
      creativeSizeType = _json["creativeSizeType"];
    }
    if (_json.containsKey("size")) {
      size = new TargetingValueSize.fromJson(_json["size"]);
    }
    if (_json.containsKey("skippableAdType")) {
      skippableAdType = _json["skippableAdType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (companionSizes != null) {
      _json["companionSizes"] = companionSizes.map((value) => (value).toJson()).toList();
    }
    if (creativeSizeType != null) {
      _json["creativeSizeType"] = creativeSizeType;
    }
    if (size != null) {
      _json["size"] = (size).toJson();
    }
    if (skippableAdType != null) {
      _json["skippableAdType"] = skippableAdType;
    }
    return _json;
  }
}

class TargetingValueDayPartTargeting {
  core.List<TargetingValueDayPartTargetingDayPart> dayParts;
  core.String timeZoneType;

  TargetingValueDayPartTargeting();

  TargetingValueDayPartTargeting.fromJson(core.Map _json) {
    if (_json.containsKey("dayParts")) {
      dayParts = _json["dayParts"].map((value) => new TargetingValueDayPartTargetingDayPart.fromJson(value)).toList();
    }
    if (_json.containsKey("timeZoneType")) {
      timeZoneType = _json["timeZoneType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dayParts != null) {
      _json["dayParts"] = dayParts.map((value) => (value).toJson()).toList();
    }
    if (timeZoneType != null) {
      _json["timeZoneType"] = timeZoneType;
    }
    return _json;
  }
}

class TargetingValueDayPartTargetingDayPart {
  core.String dayOfWeek;
  core.int endHour;
  core.int endMinute;
  core.int startHour;
  core.int startMinute;

  TargetingValueDayPartTargetingDayPart();

  TargetingValueDayPartTargetingDayPart.fromJson(core.Map _json) {
    if (_json.containsKey("dayOfWeek")) {
      dayOfWeek = _json["dayOfWeek"];
    }
    if (_json.containsKey("endHour")) {
      endHour = _json["endHour"];
    }
    if (_json.containsKey("endMinute")) {
      endMinute = _json["endMinute"];
    }
    if (_json.containsKey("startHour")) {
      startHour = _json["startHour"];
    }
    if (_json.containsKey("startMinute")) {
      startMinute = _json["startMinute"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dayOfWeek != null) {
      _json["dayOfWeek"] = dayOfWeek;
    }
    if (endHour != null) {
      _json["endHour"] = endHour;
    }
    if (endMinute != null) {
      _json["endMinute"] = endMinute;
    }
    if (startHour != null) {
      _json["startHour"] = startHour;
    }
    if (startMinute != null) {
      _json["startMinute"] = startMinute;
    }
    return _json;
  }
}

class TargetingValueSize {
  /** The height of the creative. */
  core.int height;
  /** The width of the creative. */
  core.int width;

  TargetingValueSize();

  TargetingValueSize.fromJson(core.Map _json) {
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

class UpdatePrivateAuctionProposalRequest {
  /** The externalDealId of the deal to be updated. */
  core.String externalDealId;
  /** Optional note to be added. */
  MarketplaceNote note;
  /** The current revision number of the proposal to be updated. */
  core.String proposalRevisionNumber;
  /** The proposed action on the private auction proposal. */
  core.String updateAction;

  UpdatePrivateAuctionProposalRequest();

  UpdatePrivateAuctionProposalRequest.fromJson(core.Map _json) {
    if (_json.containsKey("externalDealId")) {
      externalDealId = _json["externalDealId"];
    }
    if (_json.containsKey("note")) {
      note = new MarketplaceNote.fromJson(_json["note"]);
    }
    if (_json.containsKey("proposalRevisionNumber")) {
      proposalRevisionNumber = _json["proposalRevisionNumber"];
    }
    if (_json.containsKey("updateAction")) {
      updateAction = _json["updateAction"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (externalDealId != null) {
      _json["externalDealId"] = externalDealId;
    }
    if (note != null) {
      _json["note"] = (note).toJson();
    }
    if (proposalRevisionNumber != null) {
      _json["proposalRevisionNumber"] = proposalRevisionNumber;
    }
    if (updateAction != null) {
      _json["updateAction"] = updateAction;
    }
    return _json;
  }
}
