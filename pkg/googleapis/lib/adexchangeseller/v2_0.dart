// This is a generated file (see the discoveryapis_generator project).

library googleapis.adexchangeseller.v2_0;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client adexchangeseller/v2.0';

/**
 * Accesses the inventory of Ad Exchange seller users and generates reports.
 */
class AdexchangesellerApi {
  /** View and manage your Ad Exchange data */
  static const AdexchangeSellerScope = "https://www.googleapis.com/auth/adexchange.seller";

  /** View your Ad Exchange data */
  static const AdexchangeSellerReadonlyScope = "https://www.googleapis.com/auth/adexchange.seller.readonly";


  final commons.ApiRequester _requester;

  AccountsResourceApi get accounts => new AccountsResourceApi(_requester);

  AdexchangesellerApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "adexchangeseller/v2.0/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AccountsResourceApi {
  final commons.ApiRequester _requester;

  AccountsAdclientsResourceApi get adclients => new AccountsAdclientsResourceApi(_requester);
  AccountsAlertsResourceApi get alerts => new AccountsAlertsResourceApi(_requester);
  AccountsCustomchannelsResourceApi get customchannels => new AccountsCustomchannelsResourceApi(_requester);
  AccountsMetadataResourceApi get metadata => new AccountsMetadataResourceApi(_requester);
  AccountsPreferreddealsResourceApi get preferreddeals => new AccountsPreferreddealsResourceApi(_requester);
  AccountsReportsResourceApi get reports => new AccountsReportsResourceApi(_requester);
  AccountsUrlchannelsResourceApi get urlchannels => new AccountsUrlchannelsResourceApi(_requester);

  AccountsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get information about the selected Ad Exchange account.
   *
   * Request parameters:
   *
   * [accountId] - Account to get information about. Tip: 'myaccount' is a valid
   * ID.
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> get(core.String accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
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
   * List all accounts available to this Ad Exchange account.
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
   * List all ad clients in this Ad Exchange account.
   *
   * Request parameters:
   *
   * [accountId] - Account to which the ad client belongs.
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


class AccountsAlertsResourceApi {
  final commons.ApiRequester _requester;

  AccountsAlertsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List the alerts for this Ad Exchange account.
   *
   * Request parameters:
   *
   * [accountId] - Account owning the alerts.
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

  AccountsCustomchannelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get the specified custom channel from the specified ad client.
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
   * List all custom channels in the specified ad client for this Ad Exchange
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


class AccountsMetadataResourceApi {
  final commons.ApiRequester _requester;

  AccountsMetadataDimensionsResourceApi get dimensions => new AccountsMetadataDimensionsResourceApi(_requester);
  AccountsMetadataMetricsResourceApi get metrics => new AccountsMetadataMetricsResourceApi(_requester);

  AccountsMetadataResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class AccountsMetadataDimensionsResourceApi {
  final commons.ApiRequester _requester;

  AccountsMetadataDimensionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List the metadata for the dimensions available to this AdExchange account.
   *
   * Request parameters:
   *
   * [accountId] - Account with visibility to the dimensions.
   *
   * Completes with a [Metadata].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Metadata> list(core.String accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/metadata/dimensions';

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


class AccountsMetadataMetricsResourceApi {
  final commons.ApiRequester _requester;

  AccountsMetadataMetricsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List the metadata for the metrics available to this AdExchange account.
   *
   * Request parameters:
   *
   * [accountId] - Account with visibility to the metrics.
   *
   * Completes with a [Metadata].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Metadata> list(core.String accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/metadata/metrics';

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


class AccountsPreferreddealsResourceApi {
  final commons.ApiRequester _requester;

  AccountsPreferreddealsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get information about the selected Ad Exchange Preferred Deal.
   *
   * Request parameters:
   *
   * [accountId] - Account owning the deal.
   *
   * [dealId] - Preferred deal to get information about.
   *
   * Completes with a [PreferredDeal].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PreferredDeal> get(core.String accountId, core.String dealId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (dealId == null) {
      throw new core.ArgumentError("Parameter dealId is required.");
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/preferreddeals/' + commons.Escaper.ecapeVariable('$dealId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PreferredDeal.fromJson(data));
  }

  /**
   * List the preferred deals for this Ad Exchange account.
   *
   * Request parameters:
   *
   * [accountId] - Account owning the deals.
   *
   * Completes with a [PreferredDeals].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PreferredDeals> list(core.String accountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }

    _url = 'accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/preferreddeals';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PreferredDeals.fromJson(data));
  }

}


class AccountsReportsResourceApi {
  final commons.ApiRequester _requester;

  AccountsReportsSavedResourceApi get saved => new AccountsReportsSavedResourceApi(_requester);

  AccountsReportsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Generate an Ad Exchange report based on the report request sent in the
   * query parameters. Returns the result as JSON; to retrieve output in CSV
   * format specify "alt=csv" as a query parameter.
   *
   * Request parameters:
   *
   * [accountId] - Account which owns the generated report.
   *
   * [startDate] - Start of the date range to report on in "YYYY-MM-DD" format,
   * inclusive.
   * Value must have pattern
   * "\d{4}-\d{2}-\d{2}|(today|startOfMonth|startOfYear)(([\-\+]\d+[dwmy]){0,3}?)".
   *
   * [endDate] - End of the date range to report on in "YYYY-MM-DD" format,
   * inclusive.
   * Value must have pattern
   * "\d{4}-\d{2}-\d{2}|(today|startOfMonth|startOfYear)(([\-\+]\d+[dwmy]){0,3}?)".
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
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [Report] for Metadata downloads (see [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future generate(core.String accountId, core.String startDate, core.String endDate, {core.List<core.String> dimension, core.List<core.String> filter, core.String locale, core.int maxResults, core.List<core.String> metric, core.List<core.String> sort, core.int startIndex, commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
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
      return _response.then((data) => new Report.fromJson(data));
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
   * Generate an Ad Exchange report based on the saved report ID sent in the
   * query parameters.
   *
   * Request parameters:
   *
   * [accountId] - Account owning the saved report.
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
   * Completes with a [Report].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Report> generate(core.String accountId, core.String savedReportId, {core.String locale, core.int maxResults, core.int startIndex}) {
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
    return _response.then((data) => new Report.fromJson(data));
  }

  /**
   * List all saved reports in this Ad Exchange account.
   *
   * Request parameters:
   *
   * [accountId] - Account owning the saved reports.
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


class AccountsUrlchannelsResourceApi {
  final commons.ApiRequester _requester;

  AccountsUrlchannelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List all URL channels in the specified ad client for this Ad Exchange
   * account.
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



class Account {
  /** Unique identifier of this account. */
  core.String id;
  /** Kind of resource this is, in this case adexchangeseller#account. */
  core.String kind;
  /** Name of this account. */
  core.String name;

  Account();

  Account.fromJson(core.Map _json) {
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

class Accounts {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The accounts returned in this list response. */
  core.List<Account> items;
  /** Kind of list this is, in this case adexchangeseller#accounts. */
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
  /** Kind of resource this is, in this case adexchangeseller#adClient. */
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
  /** Kind of list this is, in this case adexchangeseller#adClients. */
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

class Alert {
  /**
   * Unique identifier of this alert. This should be considered an opaque
   * identifier; it is not safe to rely on it being in any particular format.
   */
  core.String id;
  /** Kind of resource this is, in this case adexchangeseller#alert. */
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
  /** Kind of list this is, in this case adexchangeseller#alerts. */
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
   * content ads). Acceptable values for content ads are: TOP_LEFT, TOP_CENTER,
   * TOP_RIGHT, MIDDLE_LEFT, MIDDLE_CENTER, MIDDLE_RIGHT, BOTTOM_LEFT,
   * BOTTOM_CENTER, BOTTOM_RIGHT, MULTIPLE_LOCATIONS. Acceptable values for
   * mobile content ads are: TOP, MIDDLE, BOTTOM, MULTIPLE_LOCATIONS.
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
  /** Kind of resource this is, in this case adexchangeseller#customChannel. */
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
  /** Kind of list this is, in this case adexchangeseller#customChannels. */
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
  /** Kind of list this is, in this case adexchangeseller#metadata. */
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

class PreferredDeal {
  /** The name of the advertiser this deal is for. */
  core.String advertiserName;
  /** The name of the buyer network this deal is for. */
  core.String buyerNetworkName;
  /**
   * The currency code that applies to the fixed_cpm value. If not set then
   * assumed to be USD.
   */
  core.String currencyCode;
  /**
   * Time when this deal stops being active in seconds since the epoch (GMT). If
   * not set then this deal is valid until manually disabled by the publisher.
   */
  core.String endTime;
  /**
   * The fixed price for this preferred deal. In cpm micros of currency
   * according to currencyCode. If set, then this preferred deal is eligible for
   * the fixed price tier of buying (highest priority, pay exactly the
   * configured fixed price).
   */
  core.String fixedCpm;
  /** Unique identifier of this preferred deal. */
  core.String id;
  /** Kind of resource this is, in this case adexchangeseller#preferredDeal. */
  core.String kind;
  /**
   * Time when this deal becomes active in seconds since the epoch (GMT). If not
   * set then this deal is active immediately upon creation.
   */
  core.String startTime;

  PreferredDeal();

  PreferredDeal.fromJson(core.Map _json) {
    if (_json.containsKey("advertiserName")) {
      advertiserName = _json["advertiserName"];
    }
    if (_json.containsKey("buyerNetworkName")) {
      buyerNetworkName = _json["buyerNetworkName"];
    }
    if (_json.containsKey("currencyCode")) {
      currencyCode = _json["currencyCode"];
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
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (advertiserName != null) {
      _json["advertiserName"] = advertiserName;
    }
    if (buyerNetworkName != null) {
      _json["buyerNetworkName"] = buyerNetworkName;
    }
    if (currencyCode != null) {
      _json["currencyCode"] = currencyCode;
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
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

class PreferredDeals {
  /** The preferred deals returned in this list response. */
  core.List<PreferredDeal> items;
  /** Kind of list this is, in this case adexchangeseller#preferredDeals. */
  core.String kind;

  PreferredDeals();

  PreferredDeals.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new PreferredDeal.fromJson(value)).toList();
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

class ReportHeaders {
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

  ReportHeaders();

  ReportHeaders.fromJson(core.Map _json) {
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

class Report {
  /**
   * The averages of the report. This is the same length as any other row in the
   * report; cells corresponding to dimension columns are empty.
   */
  core.List<core.String> averages;
  /**
   * The header information of the columns requested in the report. This is a
   * list of headers; one for each dimension in the request, followed by one for
   * each metric in the request.
   */
  core.List<ReportHeaders> headers;
  /** Kind this is, in this case adexchangeseller#report. */
  core.String kind;
  /**
   * The output rows of the report. Each row is a list of cells; one for each
   * dimension in the request, followed by one for each metric in the request.
   * The dimension cells contain strings, and the metric cells contain numbers.
   */
  core.List<core.List<core.String>> rows;
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

  Report();

  Report.fromJson(core.Map _json) {
    if (_json.containsKey("averages")) {
      averages = _json["averages"];
    }
    if (_json.containsKey("headers")) {
      headers = _json["headers"].map((value) => new ReportHeaders.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"];
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
    if (headers != null) {
      _json["headers"] = headers.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (rows != null) {
      _json["rows"] = rows;
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
  /**
   * Kind of resource this is, in this case
   * adexchangeseller#reportingMetadataEntry.
   */
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

class SavedReport {
  /** Unique identifier of this saved report. */
  core.String id;
  /** Kind of resource this is, in this case adexchangeseller#savedReport. */
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
  /** Kind of list this is, in this case adexchangeseller#savedReports. */
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
  /** Kind of resource this is, in this case adexchangeseller#urlChannel. */
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
  /** Kind of list this is, in this case adexchangeseller#urlChannels. */
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
