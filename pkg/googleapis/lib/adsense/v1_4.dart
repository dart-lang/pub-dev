// This is a generated file (see the discoveryapis_generator project).

library googleapis.adsense.v1_4;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client adsense/v1.4';

/**
 * Accesses AdSense publishers' inventory and generates performance reports.
 */
class AdsenseApi {
  /** View and manage your AdSense data */
  static const AdsenseScope = "https://www.googleapis.com/auth/adsense";

  /** View your AdSense data */
  static const AdsenseReadonlyScope = "https://www.googleapis.com/auth/adsense.readonly";


  final commons.ApiRequester _requester;

  AccountsResourceApi get accounts => new AccountsResourceApi(_requester);
  AdclientsResourceApi get adclients => new AdclientsResourceApi(_requester);
  AdunitsResourceApi get adunits => new AdunitsResourceApi(_requester);
  AlertsResourceApi get alerts => new AlertsResourceApi(_requester);
  CustomchannelsResourceApi get customchannels => new CustomchannelsResourceApi(_requester);
  MetadataResourceApi get metadata => new MetadataResourceApi(_requester);
  PaymentsResourceApi get payments => new PaymentsResourceApi(_requester);
  ReportsResourceApi get reports => new ReportsResourceApi(_requester);
  SavedadstylesResourceApi get savedadstyles => new SavedadstylesResourceApi(_requester);
  UrlchannelsResourceApi get urlchannels => new UrlchannelsResourceApi(_requester);

  AdsenseApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "adsense/v1.4/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AccountsResourceApi {
  final commons.ApiRequester _requester;

  AccountsAdclientsResourceApi get adclients => new AccountsAdclientsResourceApi(_requester);
  AccountsAdunitsResourceApi get adunits => new AccountsAdunitsResourceApi(_requester);
  AccountsAlertsResourceApi get alerts => new AccountsAlertsResourceApi(_requester);
  AccountsCustomchannelsResourceApi get customchannels => new AccountsCustomchannelsResourceApi(_requester);
  AccountsPaymentsResourceApi get payments => new AccountsPaymentsResourceApi(_requester);
  AccountsReportsResourceApi get reports => new AccountsReportsResourceApi(_requester);
  AccountsSavedadstylesResourceApi get savedadstyles => new AccountsSavedadstylesResourceApi(_requester);
  AccountsUrlchannelsResourceApi get urlchannels => new AccountsUrlchannelsResourceApi(_requester);

  AccountsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get information about the selected AdSense account.
   *
   * Request parameters:
   *
   * [accountId] - Account to get information about.
   *
   * [tree] - Whether the tree of sub accounts should be returned.
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> get(core.String accountId, {core.bool tree}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (tree != null) {
      _queryParams["tree"] = ["${tree}"];
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId');

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
   * List all accounts available to this AdSense account.
   *
   * Request parameters:
   *
   * [maxResults] - The maximum number of accounts to include in the response,
   * used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through accounts. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response.
   *
   * Completes with a [Accounts].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Accounts> list({core.int maxResults, core.String pageToken}) {
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

    _url = 'accounts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Accounts.fromJson(data));
  }

}


class AccountsAdclientsResourceApi {
  final commons.ApiRequester _requester;

  AccountsAdclientsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List all ad clients in the specified account.
   *
   * Request parameters:
   *
   * [accountId] - Account for which to list ad clients.
   *
   * [maxResults] - The maximum number of ad clients to include in the response,
   * used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through ad clients. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response.
   *
   * Completes with a [AdClients].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdClients> list(core.String accountId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/adclients';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdClients.fromJson(data));
  }

}


class AccountsAdunitsResourceApi {
  final commons.ApiRequester _requester;

  AccountsAdunitsCustomchannelsResourceApi get customchannels => new AccountsAdunitsCustomchannelsResourceApi(_requester);

  AccountsAdunitsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the specified ad unit in the specified ad client for the specified
   * account.
   *
   * Request parameters:
   *
   * [accountId] - Account to which the ad client belongs.
   *
   * [adClientId] - Ad client for which to get the ad unit.
   *
   * [adUnitId] - Ad unit to retrieve.
   *
   * Completes with a [AdUnit].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdUnit> get(core.String accountId, core.String adClientId, core.String adUnitId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (adUnitId == null) {
      throw new core.ArgumentError("Parameter adUnitId is required.");
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/adunits/' + commons.Escaper.ecapeVariable('$adUnitId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdUnit.fromJson(data));
  }

  /**
   * Get ad code for the specified ad unit.
   *
   * Request parameters:
   *
   * [accountId] - Account which contains the ad client.
   *
   * [adClientId] - Ad client with contains the ad unit.
   *
   * [adUnitId] - Ad unit to get the code for.
   *
   * Completes with a [AdCode].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdCode> getAdCode(core.String accountId, core.String adClientId, core.String adUnitId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (adUnitId == null) {
      throw new core.ArgumentError("Parameter adUnitId is required.");
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/adunits/' + commons.Escaper.ecapeVariable('$adUnitId') + '/adcode';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdCode.fromJson(data));
  }

  /**
   * List all ad units in the specified ad client for the specified account.
   *
   * Request parameters:
   *
   * [accountId] - Account to which the ad client belongs.
   *
   * [adClientId] - Ad client for which to list ad units.
   *
   * [includeInactive] - Whether to include inactive ad units. Default: true.
   *
   * [maxResults] - The maximum number of ad units to include in the response,
   * used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through ad units. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response.
   *
   * Completes with a [AdUnits].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdUnits> list(core.String accountId, core.String adClientId, {core.bool includeInactive, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (includeInactive != null) {
      _queryParams["includeInactive"] = ["${includeInactive}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/adunits';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdUnits.fromJson(data));
  }

}


class AccountsAdunitsCustomchannelsResourceApi {
  final commons.ApiRequester _requester;

  AccountsAdunitsCustomchannelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List all custom channels which the specified ad unit belongs to.
   *
   * Request parameters:
   *
   * [accountId] - Account to which the ad client belongs.
   *
   * [adClientId] - Ad client which contains the ad unit.
   *
   * [adUnitId] - Ad unit for which to list custom channels.
   *
   * [maxResults] - The maximum number of custom channels to include in the
   * response, used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through custom channels.
   * To retrieve the next page, set this parameter to the value of
   * "nextPageToken" from the previous response.
   *
   * Completes with a [CustomChannels].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomChannels> list(core.String accountId, core.String adClientId, core.String adUnitId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (adUnitId == null) {
      throw new core.ArgumentError("Parameter adUnitId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/adunits/' + commons.Escaper.ecapeVariable('$adUnitId') + '/customchannels';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomChannels.fromJson(data));
  }

}


class AccountsAlertsResourceApi {
  final commons.ApiRequester _requester;

  AccountsAlertsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Dismiss (delete) the specified alert from the specified publisher AdSense
   * account.
   *
   * Request parameters:
   *
   * [accountId] - Account which contains the ad unit.
   *
   * [alertId] - Alert to delete.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String accountId, core.String alertId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (alertId == null) {
      throw new core.ArgumentError("Parameter alertId is required.");
    }

    _downloadOptions = null;

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/alerts/' + commons.Escaper.ecapeVariable('$alertId');

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
   * List the alerts for the specified AdSense account.
   *
   * Request parameters:
   *
   * [accountId] - Account for which to retrieve the alerts.
   *
   * [locale] - The locale to use for translating alert messages. The account
   * locale will be used if this is not supplied. The AdSense default (English)
   * will be used if the supplied locale is invalid or unsupported.
   *
   * Completes with a [Alerts].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Alerts> list(core.String accountId, {core.String locale}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/alerts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Alerts.fromJson(data));
  }

}


class AccountsCustomchannelsResourceApi {
  final commons.ApiRequester _requester;

  AccountsCustomchannelsAdunitsResourceApi get adunits => new AccountsCustomchannelsAdunitsResourceApi(_requester);

  AccountsCustomchannelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get the specified custom channel from the specified ad client for the
   * specified account.
   *
   * Request parameters:
   *
   * [accountId] - Account to which the ad client belongs.
   *
   * [adClientId] - Ad client which contains the custom channel.
   *
   * [customChannelId] - Custom channel to retrieve.
   *
   * Completes with a [CustomChannel].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomChannel> get(core.String accountId, core.String adClientId, core.String customChannelId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (customChannelId == null) {
      throw new core.ArgumentError("Parameter customChannelId is required.");
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/customchannels/' + commons.Escaper.ecapeVariable('$customChannelId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomChannel.fromJson(data));
  }

  /**
   * List all custom channels in the specified ad client for the specified
   * account.
   *
   * Request parameters:
   *
   * [accountId] - Account to which the ad client belongs.
   *
   * [adClientId] - Ad client for which to list custom channels.
   *
   * [maxResults] - The maximum number of custom channels to include in the
   * response, used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through custom channels.
   * To retrieve the next page, set this parameter to the value of
   * "nextPageToken" from the previous response.
   *
   * Completes with a [CustomChannels].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomChannels> list(core.String accountId, core.String adClientId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/customchannels';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomChannels.fromJson(data));
  }

}


class AccountsCustomchannelsAdunitsResourceApi {
  final commons.ApiRequester _requester;

  AccountsCustomchannelsAdunitsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List all ad units in the specified custom channel.
   *
   * Request parameters:
   *
   * [accountId] - Account to which the ad client belongs.
   *
   * [adClientId] - Ad client which contains the custom channel.
   *
   * [customChannelId] - Custom channel for which to list ad units.
   *
   * [includeInactive] - Whether to include inactive ad units. Default: true.
   *
   * [maxResults] - The maximum number of ad units to include in the response,
   * used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through ad units. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response.
   *
   * Completes with a [AdUnits].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdUnits> list(core.String accountId, core.String adClientId, core.String customChannelId, {core.bool includeInactive, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (customChannelId == null) {
      throw new core.ArgumentError("Parameter customChannelId is required.");
    }
    if (includeInactive != null) {
      _queryParams["includeInactive"] = ["${includeInactive}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/customchannels/' + commons.Escaper.ecapeVariable('$customChannelId') + '/adunits';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdUnits.fromJson(data));
  }

}


class AccountsPaymentsResourceApi {
  final commons.ApiRequester _requester;

  AccountsPaymentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List the payments for the specified AdSense account.
   *
   * Request parameters:
   *
   * [accountId] - Account for which to retrieve the payments.
   *
   * Completes with a [Payments].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Payments> list(core.String accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/payments';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Payments.fromJson(data));
  }

}


class AccountsReportsResourceApi {
  final commons.ApiRequester _requester;

  AccountsReportsSavedResourceApi get saved => new AccountsReportsSavedResourceApi(_requester);

  AccountsReportsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Generate an AdSense report based on the report request sent in the query
   * parameters. Returns the result as JSON; to retrieve output in CSV format
   * specify "alt=csv" as a query parameter.
   *
   * Request parameters:
   *
   * [accountId] - Account upon which to report.
   *
   * [startDate] - Start of the date range to report on in "YYYY-MM-DD" format,
   * inclusive.
   * Value must have pattern
   * "\d{4}-\d{2}-\d{2}|(today|startOfMonth|startOfYear)(([\-\+]\d+[dwmy]){0,3}?)|(latest-(\d{2})-(\d{2})(-\d+y)?)|(latest-latest-(\d{2})(-\d+m)?)".
   *
   * [endDate] - End of the date range to report on in "YYYY-MM-DD" format,
   * inclusive.
   * Value must have pattern
   * "\d{4}-\d{2}-\d{2}|(today|startOfMonth|startOfYear)(([\-\+]\d+[dwmy]){0,3}?)|(latest-(\d{2})-(\d{2})(-\d+y)?)|(latest-latest-(\d{2})(-\d+m)?)".
   *
   * [currency] - Optional currency to use when reporting on monetary metrics.
   * Defaults to the account's currency if not set.
   * Value must have pattern "[a-zA-Z]+".
   *
   * [dimension] - Dimensions to base the report on.
   * Value must have pattern "[a-zA-Z_]+".
   *
   * [filter] - Filters to be run on the report.
   * Value must have pattern "[a-zA-Z_]+(==|=@).+".
   *
   * [locale] - Optional locale to use for translating report output to a local
   * language. Defaults to "en_US" if not specified.
   * Value must have pattern "[a-zA-Z_]+".
   *
   * [maxResults] - The maximum number of rows of report data to return.
   * Value must be between "0" and "50000".
   *
   * [metric] - Numeric columns to include in the report.
   * Value must have pattern "[a-zA-Z_]+".
   *
   * [sort] - The name of a dimension or metric to sort the resulting report on,
   * optionally prefixed with "+" to sort ascending or "-" to sort descending.
   * If no prefix is specified, the column is sorted ascending.
   * Value must have pattern "(\+|-)?[a-zA-Z_]+".
   *
   * [startIndex] - Index of the first row of report data to return.
   * Value must be between "0" and "5000".
   *
   * [useTimezoneReporting] - Whether the report should be generated in the
   * AdSense account's local timezone. If false default PST/PDT timezone will be
   * used.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [AdsenseReportsGenerateResponse] for Metadata downloads (see
   * [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future generate(core.String accountId, core.String startDate, core.String endDate, {core.String currency, core.List<core.String> dimension, core.List<core.String> filter, core.String locale, core.int maxResults, core.List<core.String> metric, core.List<core.String> sort, core.int startIndex, core.bool useTimezoneReporting, commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (startDate == null) {
      throw new core.ArgumentError("Parameter startDate is required.");
    }
    _queryParams["startDate"] = [startDate];
    if (endDate == null) {
      throw new core.ArgumentError("Parameter endDate is required.");
    }
    _queryParams["endDate"] = [endDate];
    if (currency != null) {
      _queryParams["currency"] = [currency];
    }
    if (dimension != null) {
      _queryParams["dimension"] = dimension;
    }
    if (filter != null) {
      _queryParams["filter"] = filter;
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (metric != null) {
      _queryParams["metric"] = metric;
    }
    if (sort != null) {
      _queryParams["sort"] = sort;
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }
    if (useTimezoneReporting != null) {
      _queryParams["useTimezoneReporting"] = ["${useTimezoneReporting}"];
    }

    _downloadOptions = downloadOptions;

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/reports';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new AdsenseReportsGenerateResponse.fromJson(data));
    } else {
      return _response;
    }
  }

}


class AccountsReportsSavedResourceApi {
  final commons.ApiRequester _requester;

  AccountsReportsSavedResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Generate an AdSense report based on the saved report ID sent in the query
   * parameters.
   *
   * Request parameters:
   *
   * [accountId] - Account to which the saved reports belong.
   *
   * [savedReportId] - The saved report to retrieve.
   *
   * [locale] - Optional locale to use for translating report output to a local
   * language. Defaults to "en_US" if not specified.
   * Value must have pattern "[a-zA-Z_]+".
   *
   * [maxResults] - The maximum number of rows of report data to return.
   * Value must be between "0" and "50000".
   *
   * [startIndex] - Index of the first row of report data to return.
   * Value must be between "0" and "5000".
   *
   * Completes with a [AdsenseReportsGenerateResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdsenseReportsGenerateResponse> generate(core.String accountId, core.String savedReportId, {core.String locale, core.int maxResults, core.int startIndex}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (savedReportId == null) {
      throw new core.ArgumentError("Parameter savedReportId is required.");
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/reports/' + commons.Escaper.ecapeVariable('$savedReportId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdsenseReportsGenerateResponse.fromJson(data));
  }

  /**
   * List all saved reports in the specified AdSense account.
   *
   * Request parameters:
   *
   * [accountId] - Account to which the saved reports belong.
   *
   * [maxResults] - The maximum number of saved reports to include in the
   * response, used for paging.
   * Value must be between "0" and "100".
   *
   * [pageToken] - A continuation token, used to page through saved reports. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response.
   *
   * Completes with a [SavedReports].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SavedReports> list(core.String accountId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/reports/saved';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SavedReports.fromJson(data));
  }

}


class AccountsSavedadstylesResourceApi {
  final commons.ApiRequester _requester;

  AccountsSavedadstylesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List a specific saved ad style for the specified account.
   *
   * Request parameters:
   *
   * [accountId] - Account for which to get the saved ad style.
   *
   * [savedAdStyleId] - Saved ad style to retrieve.
   *
   * Completes with a [SavedAdStyle].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SavedAdStyle> get(core.String accountId, core.String savedAdStyleId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (savedAdStyleId == null) {
      throw new core.ArgumentError("Parameter savedAdStyleId is required.");
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/savedadstyles/' + commons.Escaper.ecapeVariable('$savedAdStyleId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SavedAdStyle.fromJson(data));
  }

  /**
   * List all saved ad styles in the specified account.
   *
   * Request parameters:
   *
   * [accountId] - Account for which to list saved ad styles.
   *
   * [maxResults] - The maximum number of saved ad styles to include in the
   * response, used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through saved ad styles.
   * To retrieve the next page, set this parameter to the value of
   * "nextPageToken" from the previous response.
   *
   * Completes with a [SavedAdStyles].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SavedAdStyles> list(core.String accountId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/savedadstyles';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SavedAdStyles.fromJson(data));
  }

}


class AccountsUrlchannelsResourceApi {
  final commons.ApiRequester _requester;

  AccountsUrlchannelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List all URL channels in the specified ad client for the specified account.
   *
   * Request parameters:
   *
   * [accountId] - Account to which the ad client belongs.
   *
   * [adClientId] - Ad client for which to list URL channels.
   *
   * [maxResults] - The maximum number of URL channels to include in the
   * response, used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through URL channels. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response.
   *
   * Completes with a [UrlChannels].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UrlChannels> list(core.String accountId, core.String adClientId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/urlchannels';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UrlChannels.fromJson(data));
  }

}


class AdclientsResourceApi {
  final commons.ApiRequester _requester;

  AdclientsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List all ad clients in this AdSense account.
   *
   * Request parameters:
   *
   * [maxResults] - The maximum number of ad clients to include in the response,
   * used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through ad clients. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response.
   *
   * Completes with a [AdClients].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdClients> list({core.int maxResults, core.String pageToken}) {
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

    _url = 'adclients';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdClients.fromJson(data));
  }

}


class AdunitsResourceApi {
  final commons.ApiRequester _requester;

  AdunitsCustomchannelsResourceApi get customchannels => new AdunitsCustomchannelsResourceApi(_requester);

  AdunitsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the specified ad unit in the specified ad client.
   *
   * Request parameters:
   *
   * [adClientId] - Ad client for which to get the ad unit.
   *
   * [adUnitId] - Ad unit to retrieve.
   *
   * Completes with a [AdUnit].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdUnit> get(core.String adClientId, core.String adUnitId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (adUnitId == null) {
      throw new core.ArgumentError("Parameter adUnitId is required.");
    }

    _url = 'adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/adunits/' + commons.Escaper.ecapeVariable('$adUnitId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdUnit.fromJson(data));
  }

  /**
   * Get ad code for the specified ad unit.
   *
   * Request parameters:
   *
   * [adClientId] - Ad client with contains the ad unit.
   *
   * [adUnitId] - Ad unit to get the code for.
   *
   * Completes with a [AdCode].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdCode> getAdCode(core.String adClientId, core.String adUnitId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (adUnitId == null) {
      throw new core.ArgumentError("Parameter adUnitId is required.");
    }

    _url = 'adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/adunits/' + commons.Escaper.ecapeVariable('$adUnitId') + '/adcode';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdCode.fromJson(data));
  }

  /**
   * List all ad units in the specified ad client for this AdSense account.
   *
   * Request parameters:
   *
   * [adClientId] - Ad client for which to list ad units.
   *
   * [includeInactive] - Whether to include inactive ad units. Default: true.
   *
   * [maxResults] - The maximum number of ad units to include in the response,
   * used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through ad units. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response.
   *
   * Completes with a [AdUnits].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdUnits> list(core.String adClientId, {core.bool includeInactive, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (includeInactive != null) {
      _queryParams["includeInactive"] = ["${includeInactive}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/adunits';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdUnits.fromJson(data));
  }

}


class AdunitsCustomchannelsResourceApi {
  final commons.ApiRequester _requester;

  AdunitsCustomchannelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List all custom channels which the specified ad unit belongs to.
   *
   * Request parameters:
   *
   * [adClientId] - Ad client which contains the ad unit.
   *
   * [adUnitId] - Ad unit for which to list custom channels.
   *
   * [maxResults] - The maximum number of custom channels to include in the
   * response, used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through custom channels.
   * To retrieve the next page, set this parameter to the value of
   * "nextPageToken" from the previous response.
   *
   * Completes with a [CustomChannels].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomChannels> list(core.String adClientId, core.String adUnitId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (adUnitId == null) {
      throw new core.ArgumentError("Parameter adUnitId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/adunits/' + commons.Escaper.ecapeVariable('$adUnitId') + '/customchannels';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomChannels.fromJson(data));
  }

}


class AlertsResourceApi {
  final commons.ApiRequester _requester;

  AlertsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Dismiss (delete) the specified alert from the publisher's AdSense account.
   *
   * Request parameters:
   *
   * [alertId] - Alert to delete.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String alertId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (alertId == null) {
      throw new core.ArgumentError("Parameter alertId is required.");
    }

    _downloadOptions = null;

    _url = 'alerts/' + commons.Escaper.ecapeVariable('$alertId');

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
   * List the alerts for this AdSense account.
   *
   * Request parameters:
   *
   * [locale] - The locale to use for translating alert messages. The account
   * locale will be used if this is not supplied. The AdSense default (English)
   * will be used if the supplied locale is invalid or unsupported.
   *
   * Completes with a [Alerts].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Alerts> list({core.String locale}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (locale != null) {
      _queryParams["locale"] = [locale];
    }

    _url = 'alerts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Alerts.fromJson(data));
  }

}


class CustomchannelsResourceApi {
  final commons.ApiRequester _requester;

  CustomchannelsAdunitsResourceApi get adunits => new CustomchannelsAdunitsResourceApi(_requester);

  CustomchannelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get the specified custom channel from the specified ad client.
   *
   * Request parameters:
   *
   * [adClientId] - Ad client which contains the custom channel.
   *
   * [customChannelId] - Custom channel to retrieve.
   *
   * Completes with a [CustomChannel].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomChannel> get(core.String adClientId, core.String customChannelId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (customChannelId == null) {
      throw new core.ArgumentError("Parameter customChannelId is required.");
    }

    _url = 'adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/customchannels/' + commons.Escaper.ecapeVariable('$customChannelId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomChannel.fromJson(data));
  }

  /**
   * List all custom channels in the specified ad client for this AdSense
   * account.
   *
   * Request parameters:
   *
   * [adClientId] - Ad client for which to list custom channels.
   *
   * [maxResults] - The maximum number of custom channels to include in the
   * response, used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through custom channels.
   * To retrieve the next page, set this parameter to the value of
   * "nextPageToken" from the previous response.
   *
   * Completes with a [CustomChannels].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomChannels> list(core.String adClientId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/customchannels';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomChannels.fromJson(data));
  }

}


class CustomchannelsAdunitsResourceApi {
  final commons.ApiRequester _requester;

  CustomchannelsAdunitsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List all ad units in the specified custom channel.
   *
   * Request parameters:
   *
   * [adClientId] - Ad client which contains the custom channel.
   *
   * [customChannelId] - Custom channel for which to list ad units.
   *
   * [includeInactive] - Whether to include inactive ad units. Default: true.
   *
   * [maxResults] - The maximum number of ad units to include in the response,
   * used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through ad units. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response.
   *
   * Completes with a [AdUnits].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdUnits> list(core.String adClientId, core.String customChannelId, {core.bool includeInactive, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (customChannelId == null) {
      throw new core.ArgumentError("Parameter customChannelId is required.");
    }
    if (includeInactive != null) {
      _queryParams["includeInactive"] = ["${includeInactive}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/customchannels/' + commons.Escaper.ecapeVariable('$customChannelId') + '/adunits';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdUnits.fromJson(data));
  }

}


class MetadataResourceApi {
  final commons.ApiRequester _requester;

  MetadataDimensionsResourceApi get dimensions => new MetadataDimensionsResourceApi(_requester);
  MetadataMetricsResourceApi get metrics => new MetadataMetricsResourceApi(_requester);

  MetadataResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class MetadataDimensionsResourceApi {
  final commons.ApiRequester _requester;

  MetadataDimensionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List the metadata for the dimensions available to this AdSense account.
   *
   * Request parameters:
   *
   * Completes with a [Metadata].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Metadata> list() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'metadata/dimensions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Metadata.fromJson(data));
  }

}


class MetadataMetricsResourceApi {
  final commons.ApiRequester _requester;

  MetadataMetricsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List the metadata for the metrics available to this AdSense account.
   *
   * Request parameters:
   *
   * Completes with a [Metadata].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Metadata> list() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'metadata/metrics';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Metadata.fromJson(data));
  }

}


class PaymentsResourceApi {
  final commons.ApiRequester _requester;

  PaymentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List the payments for this AdSense account.
   *
   * Request parameters:
   *
   * Completes with a [Payments].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Payments> list() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'payments';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Payments.fromJson(data));
  }

}


class ReportsResourceApi {
  final commons.ApiRequester _requester;

  ReportsSavedResourceApi get saved => new ReportsSavedResourceApi(_requester);

  ReportsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Generate an AdSense report based on the report request sent in the query
   * parameters. Returns the result as JSON; to retrieve output in CSV format
   * specify "alt=csv" as a query parameter.
   *
   * Request parameters:
   *
   * [startDate] - Start of the date range to report on in "YYYY-MM-DD" format,
   * inclusive.
   * Value must have pattern
   * "\d{4}-\d{2}-\d{2}|(today|startOfMonth|startOfYear)(([\-\+]\d+[dwmy]){0,3}?)|(latest-(\d{2})-(\d{2})(-\d+y)?)|(latest-latest-(\d{2})(-\d+m)?)".
   *
   * [endDate] - End of the date range to report on in "YYYY-MM-DD" format,
   * inclusive.
   * Value must have pattern
   * "\d{4}-\d{2}-\d{2}|(today|startOfMonth|startOfYear)(([\-\+]\d+[dwmy]){0,3}?)|(latest-(\d{2})-(\d{2})(-\d+y)?)|(latest-latest-(\d{2})(-\d+m)?)".
   *
   * [accountId] - Accounts upon which to report.
   *
   * [currency] - Optional currency to use when reporting on monetary metrics.
   * Defaults to the account's currency if not set.
   * Value must have pattern "[a-zA-Z]+".
   *
   * [dimension] - Dimensions to base the report on.
   * Value must have pattern "[a-zA-Z_]+".
   *
   * [filter] - Filters to be run on the report.
   * Value must have pattern "[a-zA-Z_]+(==|=@).+".
   *
   * [locale] - Optional locale to use for translating report output to a local
   * language. Defaults to "en_US" if not specified.
   * Value must have pattern "[a-zA-Z_]+".
   *
   * [maxResults] - The maximum number of rows of report data to return.
   * Value must be between "0" and "50000".
   *
   * [metric] - Numeric columns to include in the report.
   * Value must have pattern "[a-zA-Z_]+".
   *
   * [sort] - The name of a dimension or metric to sort the resulting report on,
   * optionally prefixed with "+" to sort ascending or "-" to sort descending.
   * If no prefix is specified, the column is sorted ascending.
   * Value must have pattern "(\+|-)?[a-zA-Z_]+".
   *
   * [startIndex] - Index of the first row of report data to return.
   * Value must be between "0" and "5000".
   *
   * [useTimezoneReporting] - Whether the report should be generated in the
   * AdSense account's local timezone. If false default PST/PDT timezone will be
   * used.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [AdsenseReportsGenerateResponse] for Metadata downloads (see
   * [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future generate(core.String startDate, core.String endDate, {core.List<core.String> accountId, core.String currency, core.List<core.String> dimension, core.List<core.String> filter, core.String locale, core.int maxResults, core.List<core.String> metric, core.List<core.String> sort, core.int startIndex, core.bool useTimezoneReporting, commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (startDate == null) {
      throw new core.ArgumentError("Parameter startDate is required.");
    }
    _queryParams["startDate"] = [startDate];
    if (endDate == null) {
      throw new core.ArgumentError("Parameter endDate is required.");
    }
    _queryParams["endDate"] = [endDate];
    if (accountId != null) {
      _queryParams["accountId"] = accountId;
    }
    if (currency != null) {
      _queryParams["currency"] = [currency];
    }
    if (dimension != null) {
      _queryParams["dimension"] = dimension;
    }
    if (filter != null) {
      _queryParams["filter"] = filter;
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (metric != null) {
      _queryParams["metric"] = metric;
    }
    if (sort != null) {
      _queryParams["sort"] = sort;
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }
    if (useTimezoneReporting != null) {
      _queryParams["useTimezoneReporting"] = ["${useTimezoneReporting}"];
    }

    _downloadOptions = downloadOptions;

    _url = 'reports';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new AdsenseReportsGenerateResponse.fromJson(data));
    } else {
      return _response;
    }
  }

}


class ReportsSavedResourceApi {
  final commons.ApiRequester _requester;

  ReportsSavedResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Generate an AdSense report based on the saved report ID sent in the query
   * parameters.
   *
   * Request parameters:
   *
   * [savedReportId] - The saved report to retrieve.
   *
   * [locale] - Optional locale to use for translating report output to a local
   * language. Defaults to "en_US" if not specified.
   * Value must have pattern "[a-zA-Z_]+".
   *
   * [maxResults] - The maximum number of rows of report data to return.
   * Value must be between "0" and "50000".
   *
   * [startIndex] - Index of the first row of report data to return.
   * Value must be between "0" and "5000".
   *
   * Completes with a [AdsenseReportsGenerateResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdsenseReportsGenerateResponse> generate(core.String savedReportId, {core.String locale, core.int maxResults, core.int startIndex}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (savedReportId == null) {
      throw new core.ArgumentError("Parameter savedReportId is required.");
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }

    _url = 'reports/' + commons.Escaper.ecapeVariable('$savedReportId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdsenseReportsGenerateResponse.fromJson(data));
  }

  /**
   * List all saved reports in this AdSense account.
   *
   * Request parameters:
   *
   * [maxResults] - The maximum number of saved reports to include in the
   * response, used for paging.
   * Value must be between "0" and "100".
   *
   * [pageToken] - A continuation token, used to page through saved reports. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response.
   *
   * Completes with a [SavedReports].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SavedReports> list({core.int maxResults, core.String pageToken}) {
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

    _url = 'reports/saved';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SavedReports.fromJson(data));
  }

}


class SavedadstylesResourceApi {
  final commons.ApiRequester _requester;

  SavedadstylesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get a specific saved ad style from the user's account.
   *
   * Request parameters:
   *
   * [savedAdStyleId] - Saved ad style to retrieve.
   *
   * Completes with a [SavedAdStyle].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SavedAdStyle> get(core.String savedAdStyleId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (savedAdStyleId == null) {
      throw new core.ArgumentError("Parameter savedAdStyleId is required.");
    }

    _url = 'savedadstyles/' + commons.Escaper.ecapeVariable('$savedAdStyleId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SavedAdStyle.fromJson(data));
  }

  /**
   * List all saved ad styles in the user's account.
   *
   * Request parameters:
   *
   * [maxResults] - The maximum number of saved ad styles to include in the
   * response, used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through saved ad styles.
   * To retrieve the next page, set this parameter to the value of
   * "nextPageToken" from the previous response.
   *
   * Completes with a [SavedAdStyles].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SavedAdStyles> list({core.int maxResults, core.String pageToken}) {
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

    _url = 'savedadstyles';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SavedAdStyles.fromJson(data));
  }

}


class UrlchannelsResourceApi {
  final commons.ApiRequester _requester;

  UrlchannelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List all URL channels in the specified ad client for this AdSense account.
   *
   * Request parameters:
   *
   * [adClientId] - Ad client for which to list URL channels.
   *
   * [maxResults] - The maximum number of URL channels to include in the
   * response, used for paging.
   * Value must be between "0" and "10000".
   *
   * [pageToken] - A continuation token, used to page through URL channels. To
   * retrieve the next page, set this parameter to the value of "nextPageToken"
   * from the previous response.
   *
   * Completes with a [UrlChannels].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UrlChannels> list(core.String adClientId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (adClientId == null) {
      throw new core.ArgumentError("Parameter adClientId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'adclients/' + commons.Escaper.ecapeVariable('$adClientId') + '/urlchannels';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UrlChannels.fromJson(data));
  }

}



class Account {
  core.String creationTime;
  /** Unique identifier of this account. */
  core.String id;
  /** Kind of resource this is, in this case adsense#account. */
  core.String kind;
  /** Name of this account. */
  core.String name;
  /** Whether this account is premium. */
  core.bool premium;
  /** Sub accounts of the this account. */
  core.List<Account> subAccounts;
  /** AdSense timezone of this account. */
  core.String timezone;

  Account();

  Account.fromJson(core.Map _json) {
    if (_json.containsKey("creation_time")) {
      creationTime = _json["creation_time"];
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
    if (_json.containsKey("premium")) {
      premium = _json["premium"];
    }
    if (_json.containsKey("subAccounts")) {
      subAccounts = _json["subAccounts"].map((value) => new Account.fromJson(value)).toList();
    }
    if (_json.containsKey("timezone")) {
      timezone = _json["timezone"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creationTime != null) {
      _json["creation_time"] = creationTime;
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
    if (premium != null) {
      _json["premium"] = premium;
    }
    if (subAccounts != null) {
      _json["subAccounts"] = subAccounts.map((value) => (value).toJson()).toList();
    }
    if (timezone != null) {
      _json["timezone"] = timezone;
    }
    return _json;
  }
}

class Accounts {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The accounts returned in this list response. */
  core.List<Account> items;
  /** Kind of list this is, in this case adsense#accounts. */
  core.String kind;
  /**
   * Continuation token used to page through accounts. To retrieve the next page
   * of results, set the next request's "pageToken" value to this.
   */
  core.String nextPageToken;

  Accounts();

  Accounts.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Account.fromJson(value)).toList();
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

class AdClient {
  /** Whether this ad client is opted in to ARC. */
  core.bool arcOptIn;
  /** Unique identifier of this ad client. */
  core.String id;
  /** Kind of resource this is, in this case adsense#adClient. */
  core.String kind;
  /**
   * This ad client's product code, which corresponds to the PRODUCT_CODE report
   * dimension.
   */
  core.String productCode;
  /** Whether this ad client supports being reported on. */
  core.bool supportsReporting;

  AdClient();

  AdClient.fromJson(core.Map _json) {
    if (_json.containsKey("arcOptIn")) {
      arcOptIn = _json["arcOptIn"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("productCode")) {
      productCode = _json["productCode"];
    }
    if (_json.containsKey("supportsReporting")) {
      supportsReporting = _json["supportsReporting"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (arcOptIn != null) {
      _json["arcOptIn"] = arcOptIn;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (productCode != null) {
      _json["productCode"] = productCode;
    }
    if (supportsReporting != null) {
      _json["supportsReporting"] = supportsReporting;
    }
    return _json;
  }
}

class AdClients {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The ad clients returned in this list response. */
  core.List<AdClient> items;
  /** Kind of list this is, in this case adsense#adClients. */
  core.String kind;
  /**
   * Continuation token used to page through ad clients. To retrieve the next
   * page of results, set the next request's "pageToken" value to this.
   */
  core.String nextPageToken;

  AdClients();

  AdClients.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new AdClient.fromJson(value)).toList();
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

class AdCode {
  /** The ad code snippet. */
  core.String adCode;
  /** Kind this is, in this case adsense#adCode. */
  core.String kind;

  AdCode();

  AdCode.fromJson(core.Map _json) {
    if (_json.containsKey("adCode")) {
      adCode = _json["adCode"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adCode != null) {
      _json["adCode"] = adCode;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/**
 * The colors which are included in the style. These are represented as six
 * hexadecimal characters, similar to HTML color codes, but without the leading
 * hash.
 */
class AdStyleColors {
  /** The color of the ad background. */
  core.String background;
  /** The color of the ad border. */
  core.String border;
  /** The color of the ad text. */
  core.String text;
  /** The color of the ad title. */
  core.String title;
  /** The color of the ad url. */
  core.String url;

  AdStyleColors();

  AdStyleColors.fromJson(core.Map _json) {
    if (_json.containsKey("background")) {
      background = _json["background"];
    }
    if (_json.containsKey("border")) {
      border = _json["border"];
    }
    if (_json.containsKey("text")) {
      text = _json["text"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (background != null) {
      _json["background"] = background;
    }
    if (border != null) {
      _json["border"] = border;
    }
    if (text != null) {
      _json["text"] = text;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** The font which is included in the style. */
class AdStyleFont {
  /** The family of the font. */
  core.String family;
  /** The size of the font. */
  core.String size;

  AdStyleFont();

  AdStyleFont.fromJson(core.Map _json) {
    if (_json.containsKey("family")) {
      family = _json["family"];
    }
    if (_json.containsKey("size")) {
      size = _json["size"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (family != null) {
      _json["family"] = family;
    }
    if (size != null) {
      _json["size"] = size;
    }
    return _json;
  }
}

class AdStyle {
  /**
   * The colors which are included in the style. These are represented as six
   * hexadecimal characters, similar to HTML color codes, but without the
   * leading hash.
   */
  AdStyleColors colors;
  /**
   * The style of the corners in the ad (deprecated: never populated, ignored).
   */
  core.String corners;
  /** The font which is included in the style. */
  AdStyleFont font;
  /** Kind this is, in this case adsense#adStyle. */
  core.String kind;

  AdStyle();

  AdStyle.fromJson(core.Map _json) {
    if (_json.containsKey("colors")) {
      colors = new AdStyleColors.fromJson(_json["colors"]);
    }
    if (_json.containsKey("corners")) {
      corners = _json["corners"];
    }
    if (_json.containsKey("font")) {
      font = new AdStyleFont.fromJson(_json["font"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (colors != null) {
      _json["colors"] = (colors).toJson();
    }
    if (corners != null) {
      _json["corners"] = corners;
    }
    if (font != null) {
      _json["font"] = (font).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** The backup option to be used in instances where no ad is available. */
class AdUnitContentAdsSettingsBackupOption {
  /** Color to use when type is set to COLOR. */
  core.String color;
  /** Type of the backup option. Possible values are BLANK, COLOR and URL. */
  core.String type;
  /** URL to use when type is set to URL. */
  core.String url;

  AdUnitContentAdsSettingsBackupOption();

  AdUnitContentAdsSettingsBackupOption.fromJson(core.Map _json) {
    if (_json.containsKey("color")) {
      color = _json["color"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (color != null) {
      _json["color"] = color;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/**
 * Settings specific to content ads (AFC) and highend mobile content ads (AFMC -
 * deprecated).
 */
class AdUnitContentAdsSettings {
  /** The backup option to be used in instances where no ad is available. */
  AdUnitContentAdsSettingsBackupOption backupOption;
  /** Size of this ad unit. */
  core.String size;
  /** Type of this ad unit. */
  core.String type;

  AdUnitContentAdsSettings();

  AdUnitContentAdsSettings.fromJson(core.Map _json) {
    if (_json.containsKey("backupOption")) {
      backupOption = new AdUnitContentAdsSettingsBackupOption.fromJson(_json["backupOption"]);
    }
    if (_json.containsKey("size")) {
      size = _json["size"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (backupOption != null) {
      _json["backupOption"] = (backupOption).toJson();
    }
    if (size != null) {
      _json["size"] = size;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Settings specific to feed ads (AFF) - deprecated. */
class AdUnitFeedAdsSettings {
  /** The position of the ads relative to the feed entries. */
  core.String adPosition;
  /**
   * The frequency at which ads should appear in the feed (i.e. every N
   * entries).
   */
  core.int frequency;
  /** The minimum length an entry should be in order to have attached ads. */
  core.int minimumWordCount;
  /** The type of ads which should appear. */
  core.String type;

  AdUnitFeedAdsSettings();

  AdUnitFeedAdsSettings.fromJson(core.Map _json) {
    if (_json.containsKey("adPosition")) {
      adPosition = _json["adPosition"];
    }
    if (_json.containsKey("frequency")) {
      frequency = _json["frequency"];
    }
    if (_json.containsKey("minimumWordCount")) {
      minimumWordCount = _json["minimumWordCount"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adPosition != null) {
      _json["adPosition"] = adPosition;
    }
    if (frequency != null) {
      _json["frequency"] = frequency;
    }
    if (minimumWordCount != null) {
      _json["minimumWordCount"] = minimumWordCount;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Settings specific to WAP mobile content ads (AFMC) - deprecated. */
class AdUnitMobileContentAdsSettings {
  /** The markup language to use for this ad unit. */
  core.String markupLanguage;
  /** The scripting language to use for this ad unit. */
  core.String scriptingLanguage;
  /** Size of this ad unit. */
  core.String size;
  /** Type of this ad unit. */
  core.String type;

  AdUnitMobileContentAdsSettings();

  AdUnitMobileContentAdsSettings.fromJson(core.Map _json) {
    if (_json.containsKey("markupLanguage")) {
      markupLanguage = _json["markupLanguage"];
    }
    if (_json.containsKey("scriptingLanguage")) {
      scriptingLanguage = _json["scriptingLanguage"];
    }
    if (_json.containsKey("size")) {
      size = _json["size"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (markupLanguage != null) {
      _json["markupLanguage"] = markupLanguage;
    }
    if (scriptingLanguage != null) {
      _json["scriptingLanguage"] = scriptingLanguage;
    }
    if (size != null) {
      _json["size"] = size;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class AdUnit {
  /**
   * Identity code of this ad unit, not necessarily unique across ad clients.
   */
  core.String code;
  /**
   * Settings specific to content ads (AFC) and highend mobile content ads (AFMC
   * - deprecated).
   */
  AdUnitContentAdsSettings contentAdsSettings;
  /** Custom style information specific to this ad unit. */
  AdStyle customStyle;
  /** Settings specific to feed ads (AFF) - deprecated. */
  AdUnitFeedAdsSettings feedAdsSettings;
  /**
   * Unique identifier of this ad unit. This should be considered an opaque
   * identifier; it is not safe to rely on it being in any particular format.
   */
  core.String id;
  /** Kind of resource this is, in this case adsense#adUnit. */
  core.String kind;
  /** Settings specific to WAP mobile content ads (AFMC) - deprecated. */
  AdUnitMobileContentAdsSettings mobileContentAdsSettings;
  /** Name of this ad unit. */
  core.String name;
  /** ID of the saved ad style which holds this ad unit's style information. */
  core.String savedStyleId;
  /**
   * Status of this ad unit. Possible values are:
   * NEW: Indicates that the ad unit was created within the last seven days and
   * does not yet have any activity associated with it.
   *
   * ACTIVE: Indicates that there has been activity on this ad unit in the last
   * seven days.
   *
   * INACTIVE: Indicates that there has been no activity on this ad unit in the
   * last seven days.
   */
  core.String status;

  AdUnit();

  AdUnit.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("contentAdsSettings")) {
      contentAdsSettings = new AdUnitContentAdsSettings.fromJson(_json["contentAdsSettings"]);
    }
    if (_json.containsKey("customStyle")) {
      customStyle = new AdStyle.fromJson(_json["customStyle"]);
    }
    if (_json.containsKey("feedAdsSettings")) {
      feedAdsSettings = new AdUnitFeedAdsSettings.fromJson(_json["feedAdsSettings"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("mobileContentAdsSettings")) {
      mobileContentAdsSettings = new AdUnitMobileContentAdsSettings.fromJson(_json["mobileContentAdsSettings"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("savedStyleId")) {
      savedStyleId = _json["savedStyleId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (code != null) {
      _json["code"] = code;
    }
    if (contentAdsSettings != null) {
      _json["contentAdsSettings"] = (contentAdsSettings).toJson();
    }
    if (customStyle != null) {
      _json["customStyle"] = (customStyle).toJson();
    }
    if (feedAdsSettings != null) {
      _json["feedAdsSettings"] = (feedAdsSettings).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (mobileContentAdsSettings != null) {
      _json["mobileContentAdsSettings"] = (mobileContentAdsSettings).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (savedStyleId != null) {
      _json["savedStyleId"] = savedStyleId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

class AdUnits {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The ad units returned in this list response. */
  core.List<AdUnit> items;
  /** Kind of list this is, in this case adsense#adUnits. */
  core.String kind;
  /**
   * Continuation token used to page through ad units. To retrieve the next page
   * of results, set the next request's "pageToken" value to this.
   */
  core.String nextPageToken;

  AdUnits();

  AdUnits.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new AdUnit.fromJson(value)).toList();
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

class AdsenseReportsGenerateResponseHeaders {
  /**
   * The currency of this column. Only present if the header type is
   * METRIC_CURRENCY.
   */
  core.String currency;
  /** The name of the header. */
  core.String name;
  /**
   * The type of the header; one of DIMENSION, METRIC_TALLY, METRIC_RATIO, or
   * METRIC_CURRENCY.
   */
  core.String type;

  AdsenseReportsGenerateResponseHeaders();

  AdsenseReportsGenerateResponseHeaders.fromJson(core.Map _json) {
    if (_json.containsKey("currency")) {
      currency = _json["currency"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currency != null) {
      _json["currency"] = currency;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class AdsenseReportsGenerateResponse {
  /**
   * The averages of the report. This is the same length as any other row in the
   * report; cells corresponding to dimension columns are empty.
   */
  core.List<core.String> averages;
  /** The requested end date in yyyy-mm-dd format. */
  core.String endDate;
  /**
   * The header information of the columns requested in the report. This is a
   * list of headers; one for each dimension in the request, followed by one for
   * each metric in the request.
   */
  core.List<AdsenseReportsGenerateResponseHeaders> headers;
  /** Kind this is, in this case adsense#report. */
  core.String kind;
  /**
   * The output rows of the report. Each row is a list of cells; one for each
   * dimension in the request, followed by one for each metric in the request.
   * The dimension cells contain strings, and the metric cells contain numbers.
   */
  core.List<core.List<core.String>> rows;
  /** The requested start date in yyyy-mm-dd format. */
  core.String startDate;
  /**
   * The total number of rows matched by the report request. Fewer rows may be
   * returned in the response due to being limited by the row count requested or
   * the report row limit.
   */
  core.String totalMatchedRows;
  /**
   * The totals of the report. This is the same length as any other row in the
   * report; cells corresponding to dimension columns are empty.
   */
  core.List<core.String> totals;
  /** Any warnings associated with generation of the report. */
  core.List<core.String> warnings;

  AdsenseReportsGenerateResponse();

  AdsenseReportsGenerateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("averages")) {
      averages = _json["averages"];
    }
    if (_json.containsKey("endDate")) {
      endDate = _json["endDate"];
    }
    if (_json.containsKey("headers")) {
      headers = _json["headers"].map((value) => new AdsenseReportsGenerateResponseHeaders.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"];
    }
    if (_json.containsKey("startDate")) {
      startDate = _json["startDate"];
    }
    if (_json.containsKey("totalMatchedRows")) {
      totalMatchedRows = _json["totalMatchedRows"];
    }
    if (_json.containsKey("totals")) {
      totals = _json["totals"];
    }
    if (_json.containsKey("warnings")) {
      warnings = _json["warnings"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (averages != null) {
      _json["averages"] = averages;
    }
    if (endDate != null) {
      _json["endDate"] = endDate;
    }
    if (headers != null) {
      _json["headers"] = headers.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (rows != null) {
      _json["rows"] = rows;
    }
    if (startDate != null) {
      _json["startDate"] = startDate;
    }
    if (totalMatchedRows != null) {
      _json["totalMatchedRows"] = totalMatchedRows;
    }
    if (totals != null) {
      _json["totals"] = totals;
    }
    if (warnings != null) {
      _json["warnings"] = warnings;
    }
    return _json;
  }
}

class Alert {
  /**
   * Unique identifier of this alert. This should be considered an opaque
   * identifier; it is not safe to rely on it being in any particular format.
   */
  core.String id;
  /** Whether this alert can be dismissed. */
  core.bool isDismissible;
  /** Kind of resource this is, in this case adsense#alert. */
  core.String kind;
  /** The localized alert message. */
  core.String message;
  /** Severity of this alert. Possible values: INFO, WARNING, SEVERE. */
  core.String severity;
  /**
   * Type of this alert. Possible values: SELF_HOLD, MIGRATED_TO_BILLING3,
   * ADDRESS_PIN_VERIFICATION, PHONE_PIN_VERIFICATION, CORPORATE_ENTITY,
   * GRAYLISTED_PUBLISHER, API_HOLD.
   */
  core.String type;

  Alert();

  Alert.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("isDismissible")) {
      isDismissible = _json["isDismissible"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
    if (_json.containsKey("severity")) {
      severity = _json["severity"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (isDismissible != null) {
      _json["isDismissible"] = isDismissible;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (message != null) {
      _json["message"] = message;
    }
    if (severity != null) {
      _json["severity"] = severity;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class Alerts {
  /** The alerts returned in this list response. */
  core.List<Alert> items;
  /** Kind of list this is, in this case adsense#alerts. */
  core.String kind;

  Alerts();

  Alerts.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Alert.fromJson(value)).toList();
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

/** The targeting information of this custom channel, if activated. */
class CustomChannelTargetingInfo {
  /** The name used to describe this channel externally. */
  core.String adsAppearOn;
  /** The external description of the channel. */
  core.String description;
  /**
   * The locations in which ads appear. (Only valid for content and mobile
   * content ads (deprecated)). Acceptable values for content ads are: TOP_LEFT,
   * TOP_CENTER, TOP_RIGHT, MIDDLE_LEFT, MIDDLE_CENTER, MIDDLE_RIGHT,
   * BOTTOM_LEFT, BOTTOM_CENTER, BOTTOM_RIGHT, MULTIPLE_LOCATIONS. Acceptable
   * values for mobile content ads (deprecated) are: TOP, MIDDLE, BOTTOM,
   * MULTIPLE_LOCATIONS.
   */
  core.String location;
  /** The language of the sites ads will be displayed on. */
  core.String siteLanguage;

  CustomChannelTargetingInfo();

  CustomChannelTargetingInfo.fromJson(core.Map _json) {
    if (_json.containsKey("adsAppearOn")) {
      adsAppearOn = _json["adsAppearOn"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("siteLanguage")) {
      siteLanguage = _json["siteLanguage"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adsAppearOn != null) {
      _json["adsAppearOn"] = adsAppearOn;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (siteLanguage != null) {
      _json["siteLanguage"] = siteLanguage;
    }
    return _json;
  }
}

class CustomChannel {
  /** Code of this custom channel, not necessarily unique across ad clients. */
  core.String code;
  /**
   * Unique identifier of this custom channel. This should be considered an
   * opaque identifier; it is not safe to rely on it being in any particular
   * format.
   */
  core.String id;
  /** Kind of resource this is, in this case adsense#customChannel. */
  core.String kind;
  /** Name of this custom channel. */
  core.String name;
  /** The targeting information of this custom channel, if activated. */
  CustomChannelTargetingInfo targetingInfo;

  CustomChannel();

  CustomChannel.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
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
    if (_json.containsKey("targetingInfo")) {
      targetingInfo = new CustomChannelTargetingInfo.fromJson(_json["targetingInfo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (code != null) {
      _json["code"] = code;
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
    if (targetingInfo != null) {
      _json["targetingInfo"] = (targetingInfo).toJson();
    }
    return _json;
  }
}

class CustomChannels {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The custom channels returned in this list response. */
  core.List<CustomChannel> items;
  /** Kind of list this is, in this case adsense#customChannels. */
  core.String kind;
  /**
   * Continuation token used to page through custom channels. To retrieve the
   * next page of results, set the next request's "pageToken" value to this.
   */
  core.String nextPageToken;

  CustomChannels();

  CustomChannels.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new CustomChannel.fromJson(value)).toList();
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

class Metadata {
  core.List<ReportingMetadataEntry> items;
  /** Kind of list this is, in this case adsense#metadata. */
  core.String kind;

  Metadata();

  Metadata.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new ReportingMetadataEntry.fromJson(value)).toList();
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

class Payment {
  /** Unique identifier of this Payment. */
  core.String id;
  /** Kind of resource this is, in this case adsense#payment. */
  core.String kind;
  /** The amount to be paid. */
  core.String paymentAmount;
  /** The currency code for the amount to be paid. */
  core.String paymentAmountCurrencyCode;
  /**
   * The date this payment was/will be credited to the user, or none if the
   * payment threshold has not been met.
   */
  core.String paymentDate;

  Payment();

  Payment.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("paymentAmount")) {
      paymentAmount = _json["paymentAmount"];
    }
    if (_json.containsKey("paymentAmountCurrencyCode")) {
      paymentAmountCurrencyCode = _json["paymentAmountCurrencyCode"];
    }
    if (_json.containsKey("paymentDate")) {
      paymentDate = _json["paymentDate"];
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
    if (paymentAmount != null) {
      _json["paymentAmount"] = paymentAmount;
    }
    if (paymentAmountCurrencyCode != null) {
      _json["paymentAmountCurrencyCode"] = paymentAmountCurrencyCode;
    }
    if (paymentDate != null) {
      _json["paymentDate"] = paymentDate;
    }
    return _json;
  }
}

class Payments {
  /**
   * The list of Payments for the account. One or both of a) the account's most
   * recent payment; and b) the account's upcoming payment.
   */
  core.List<Payment> items;
  /** Kind of list this is, in this case adsense#payments. */
  core.String kind;

  Payments();

  Payments.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Payment.fromJson(value)).toList();
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

class ReportingMetadataEntry {
  /**
   * For metrics this is a list of dimension IDs which the metric is compatible
   * with, for dimensions it is a list of compatibility groups the dimension
   * belongs to.
   */
  core.List<core.String> compatibleDimensions;
  /**
   * The names of the metrics the dimension or metric this reporting metadata
   * entry describes is compatible with.
   */
  core.List<core.String> compatibleMetrics;
  /**
   * Unique identifier of this reporting metadata entry, corresponding to the
   * name of the appropriate dimension or metric.
   */
  core.String id;
  /** Kind of resource this is, in this case adsense#reportingMetadataEntry. */
  core.String kind;
  /**
   * The names of the dimensions which the dimension or metric this reporting
   * metadata entry describes requires to also be present in order for the
   * report to be valid. Omitting these will not cause an error or warning, but
   * may result in data which cannot be correctly interpreted.
   */
  core.List<core.String> requiredDimensions;
  /**
   * The names of the metrics which the dimension or metric this reporting
   * metadata entry describes requires to also be present in order for the
   * report to be valid. Omitting these will not cause an error or warning, but
   * may result in data which cannot be correctly interpreted.
   */
  core.List<core.String> requiredMetrics;
  /**
   * The codes of the projects supported by the dimension or metric this
   * reporting metadata entry describes.
   */
  core.List<core.String> supportedProducts;

  ReportingMetadataEntry();

  ReportingMetadataEntry.fromJson(core.Map _json) {
    if (_json.containsKey("compatibleDimensions")) {
      compatibleDimensions = _json["compatibleDimensions"];
    }
    if (_json.containsKey("compatibleMetrics")) {
      compatibleMetrics = _json["compatibleMetrics"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("requiredDimensions")) {
      requiredDimensions = _json["requiredDimensions"];
    }
    if (_json.containsKey("requiredMetrics")) {
      requiredMetrics = _json["requiredMetrics"];
    }
    if (_json.containsKey("supportedProducts")) {
      supportedProducts = _json["supportedProducts"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (compatibleDimensions != null) {
      _json["compatibleDimensions"] = compatibleDimensions;
    }
    if (compatibleMetrics != null) {
      _json["compatibleMetrics"] = compatibleMetrics;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (requiredDimensions != null) {
      _json["requiredDimensions"] = requiredDimensions;
    }
    if (requiredMetrics != null) {
      _json["requiredMetrics"] = requiredMetrics;
    }
    if (supportedProducts != null) {
      _json["supportedProducts"] = supportedProducts;
    }
    return _json;
  }
}

class SavedAdStyle {
  /** The AdStyle itself. */
  AdStyle adStyle;
  /**
   * Unique identifier of this saved ad style. This should be considered an
   * opaque identifier; it is not safe to rely on it being in any particular
   * format.
   */
  core.String id;
  /** Kind of resource this is, in this case adsense#savedAdStyle. */
  core.String kind;
  /** The user selected name of this SavedAdStyle. */
  core.String name;

  SavedAdStyle();

  SavedAdStyle.fromJson(core.Map _json) {
    if (_json.containsKey("adStyle")) {
      adStyle = new AdStyle.fromJson(_json["adStyle"]);
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
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adStyle != null) {
      _json["adStyle"] = (adStyle).toJson();
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
    return _json;
  }
}

class SavedAdStyles {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The saved ad styles returned in this list response. */
  core.List<SavedAdStyle> items;
  /** Kind of list this is, in this case adsense#savedAdStyles. */
  core.String kind;
  /**
   * Continuation token used to page through ad units. To retrieve the next page
   * of results, set the next request's "pageToken" value to this.
   */
  core.String nextPageToken;

  SavedAdStyles();

  SavedAdStyles.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new SavedAdStyle.fromJson(value)).toList();
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

class SavedReport {
  /** Unique identifier of this saved report. */
  core.String id;
  /** Kind of resource this is, in this case adsense#savedReport. */
  core.String kind;
  /** This saved report's name. */
  core.String name;

  SavedReport();

  SavedReport.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
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
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

class SavedReports {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The saved reports returned in this list response. */
  core.List<SavedReport> items;
  /** Kind of list this is, in this case adsense#savedReports. */
  core.String kind;
  /**
   * Continuation token used to page through saved reports. To retrieve the next
   * page of results, set the next request's "pageToken" value to this.
   */
  core.String nextPageToken;

  SavedReports();

  SavedReports.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new SavedReport.fromJson(value)).toList();
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

class UrlChannel {
  /**
   * Unique identifier of this URL channel. This should be considered an opaque
   * identifier; it is not safe to rely on it being in any particular format.
   */
  core.String id;
  /** Kind of resource this is, in this case adsense#urlChannel. */
  core.String kind;
  /**
   * URL Pattern of this URL channel. Does not include "http://" or "https://".
   * Example: www.example.com/home
   */
  core.String urlPattern;

  UrlChannel();

  UrlChannel.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("urlPattern")) {
      urlPattern = _json["urlPattern"];
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
    if (urlPattern != null) {
      _json["urlPattern"] = urlPattern;
    }
    return _json;
  }
}

class UrlChannels {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The URL channels returned in this list response. */
  core.List<UrlChannel> items;
  /** Kind of list this is, in this case adsense#urlChannels. */
  core.String kind;
  /**
   * Continuation token used to page through URL channels. To retrieve the next
   * page of results, set the next request's "pageToken" value to this.
   */
  core.String nextPageToken;

  UrlChannels();

  UrlChannels.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new UrlChannel.fromJson(value)).toList();
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
