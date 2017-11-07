// This is a generated file (see the discoveryapis_generator project).

library googleapis.analytics.v3;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client analytics/v3';

/** Views and manages your Google Analytics data. */
class AnalyticsApi {
  /** View and manage your Google Analytics data */
  static const AnalyticsScope = "https://www.googleapis.com/auth/analytics";

  /** Edit Google Analytics management entities */
  static const AnalyticsEditScope = "https://www.googleapis.com/auth/analytics.edit";

  /** Manage Google Analytics Account users by email address */
  static const AnalyticsManageUsersScope = "https://www.googleapis.com/auth/analytics.manage.users";

  /** View Google Analytics user permissions */
  static const AnalyticsManageUsersReadonlyScope = "https://www.googleapis.com/auth/analytics.manage.users.readonly";

  /**
   * Create a new Google Analytics account along with its default property and
   * view
   */
  static const AnalyticsProvisionScope = "https://www.googleapis.com/auth/analytics.provision";

  /** View your Google Analytics data */
  static const AnalyticsReadonlyScope = "https://www.googleapis.com/auth/analytics.readonly";


  final commons.ApiRequester _requester;

  DataResourceApi get data => new DataResourceApi(_requester);
  ManagementResourceApi get management => new ManagementResourceApi(_requester);
  MetadataResourceApi get metadata => new MetadataResourceApi(_requester);
  ProvisioningResourceApi get provisioning => new ProvisioningResourceApi(_requester);

  AnalyticsApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "analytics/v3/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class DataResourceApi {
  final commons.ApiRequester _requester;

  DataGaResourceApi get ga => new DataGaResourceApi(_requester);
  DataMcfResourceApi get mcf => new DataMcfResourceApi(_requester);
  DataRealtimeResourceApi get realtime => new DataRealtimeResourceApi(_requester);

  DataResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class DataGaResourceApi {
  final commons.ApiRequester _requester;

  DataGaResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns Analytics data for a view (profile).
   *
   * Request parameters:
   *
   * [ids] - Unique table ID for retrieving Analytics data. Table ID is of the
   * form ga:XXXX, where XXXX is the Analytics view (profile) ID.
   * Value must have pattern "ga:[0-9]+".
   *
   * [start_date] - Start date for fetching Analytics data. Requests can specify
   * a start date formatted as YYYY-MM-DD, or as a relative date (e.g., today,
   * yesterday, or 7daysAgo). The default value is 7daysAgo.
   * Value must have pattern
   * "[0-9]{4}-[0-9]{2}-[0-9]{2}|today|yesterday|[0-9]+(daysAgo)".
   *
   * [end_date] - End date for fetching Analytics data. Request can should
   * specify an end date formatted as YYYY-MM-DD, or as a relative date (e.g.,
   * today, yesterday, or 7daysAgo). The default value is yesterday.
   * Value must have pattern
   * "[0-9]{4}-[0-9]{2}-[0-9]{2}|today|yesterday|[0-9]+(daysAgo)".
   *
   * [metrics] - A comma-separated list of Analytics metrics. E.g.,
   * 'ga:sessions,ga:pageviews'. At least one metric must be specified.
   * Value must have pattern "ga:.+".
   *
   * [dimensions] - A comma-separated list of Analytics dimensions. E.g.,
   * 'ga:browser,ga:city'.
   * Value must have pattern "(ga:.+)?".
   *
   * [filters] - A comma-separated list of dimension or metric filters to be
   * applied to Analytics data.
   * Value must have pattern "ga:.+".
   *
   * [include_empty_rows] - The response will include empty rows if this
   * parameter is set to true, the default is true
   *
   * [max_results] - The maximum number of entries to include in this feed.
   *
   * [output] - The selected format for the response. Default format is JSON.
   * Possible string values are:
   * - "dataTable" : Returns the response in Google Charts Data Table format.
   * This is useful in creating visualization using Google Charts.
   * - "json" : Returns the response in standard JSON format.
   *
   * [samplingLevel] - The desired sampling level.
   * Possible string values are:
   * - "DEFAULT" : Returns response with a sample size that balances speed and
   * accuracy.
   * - "FASTER" : Returns a fast response with a smaller sample size.
   * - "HIGHER_PRECISION" : Returns a more accurate response using a large
   * sample size, but this may result in the response being slower.
   *
   * [segment] - An Analytics segment to be applied to data.
   *
   * [sort] - A comma-separated list of dimensions or metrics that determine the
   * sort order for Analytics data.
   * Value must have pattern "(-)?ga:.+".
   *
   * [start_index] - An index of the first entity to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [GaData].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GaData> get(core.String ids, core.String start_date, core.String end_date, core.String metrics, {core.String dimensions, core.String filters, core.bool include_empty_rows, core.int max_results, core.String output, core.String samplingLevel, core.String segment, core.String sort, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (ids == null) {
      throw new core.ArgumentError("Parameter ids is required.");
    }
    _queryParams["ids"] = [ids];
    if (start_date == null) {
      throw new core.ArgumentError("Parameter start_date is required.");
    }
    _queryParams["start-date"] = [start_date];
    if (end_date == null) {
      throw new core.ArgumentError("Parameter end_date is required.");
    }
    _queryParams["end-date"] = [end_date];
    if (metrics == null) {
      throw new core.ArgumentError("Parameter metrics is required.");
    }
    _queryParams["metrics"] = [metrics];
    if (dimensions != null) {
      _queryParams["dimensions"] = [dimensions];
    }
    if (filters != null) {
      _queryParams["filters"] = [filters];
    }
    if (include_empty_rows != null) {
      _queryParams["include-empty-rows"] = ["${include_empty_rows}"];
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (output != null) {
      _queryParams["output"] = [output];
    }
    if (samplingLevel != null) {
      _queryParams["samplingLevel"] = [samplingLevel];
    }
    if (segment != null) {
      _queryParams["segment"] = [segment];
    }
    if (sort != null) {
      _queryParams["sort"] = [sort];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'data/ga';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GaData.fromJson(data));
  }

}


class DataMcfResourceApi {
  final commons.ApiRequester _requester;

  DataMcfResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns Analytics Multi-Channel Funnels data for a view (profile).
   *
   * Request parameters:
   *
   * [ids] - Unique table ID for retrieving Analytics data. Table ID is of the
   * form ga:XXXX, where XXXX is the Analytics view (profile) ID.
   * Value must have pattern "ga:[0-9]+".
   *
   * [start_date] - Start date for fetching Analytics data. Requests can specify
   * a start date formatted as YYYY-MM-DD, or as a relative date (e.g., today,
   * yesterday, or 7daysAgo). The default value is 7daysAgo.
   * Value must have pattern
   * "[0-9]{4}-[0-9]{2}-[0-9]{2}|today|yesterday|[0-9]+(daysAgo)".
   *
   * [end_date] - End date for fetching Analytics data. Requests can specify a
   * start date formatted as YYYY-MM-DD, or as a relative date (e.g., today,
   * yesterday, or 7daysAgo). The default value is 7daysAgo.
   * Value must have pattern
   * "[0-9]{4}-[0-9]{2}-[0-9]{2}|today|yesterday|[0-9]+(daysAgo)".
   *
   * [metrics] - A comma-separated list of Multi-Channel Funnels metrics. E.g.,
   * 'mcf:totalConversions,mcf:totalConversionValue'. At least one metric must
   * be specified.
   * Value must have pattern "mcf:.+".
   *
   * [dimensions] - A comma-separated list of Multi-Channel Funnels dimensions.
   * E.g., 'mcf:source,mcf:medium'.
   * Value must have pattern "(mcf:.+)?".
   *
   * [filters] - A comma-separated list of dimension or metric filters to be
   * applied to the Analytics data.
   * Value must have pattern "mcf:.+".
   *
   * [max_results] - The maximum number of entries to include in this feed.
   *
   * [samplingLevel] - The desired sampling level.
   * Possible string values are:
   * - "DEFAULT" : Returns response with a sample size that balances speed and
   * accuracy.
   * - "FASTER" : Returns a fast response with a smaller sample size.
   * - "HIGHER_PRECISION" : Returns a more accurate response using a large
   * sample size, but this may result in the response being slower.
   *
   * [sort] - A comma-separated list of dimensions or metrics that determine the
   * sort order for the Analytics data.
   * Value must have pattern "(-)?mcf:.+".
   *
   * [start_index] - An index of the first entity to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [McfData].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<McfData> get(core.String ids, core.String start_date, core.String end_date, core.String metrics, {core.String dimensions, core.String filters, core.int max_results, core.String samplingLevel, core.String sort, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (ids == null) {
      throw new core.ArgumentError("Parameter ids is required.");
    }
    _queryParams["ids"] = [ids];
    if (start_date == null) {
      throw new core.ArgumentError("Parameter start_date is required.");
    }
    _queryParams["start-date"] = [start_date];
    if (end_date == null) {
      throw new core.ArgumentError("Parameter end_date is required.");
    }
    _queryParams["end-date"] = [end_date];
    if (metrics == null) {
      throw new core.ArgumentError("Parameter metrics is required.");
    }
    _queryParams["metrics"] = [metrics];
    if (dimensions != null) {
      _queryParams["dimensions"] = [dimensions];
    }
    if (filters != null) {
      _queryParams["filters"] = [filters];
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (samplingLevel != null) {
      _queryParams["samplingLevel"] = [samplingLevel];
    }
    if (sort != null) {
      _queryParams["sort"] = [sort];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'data/mcf';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new McfData.fromJson(data));
  }

}


class DataRealtimeResourceApi {
  final commons.ApiRequester _requester;

  DataRealtimeResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns real time data for a view (profile).
   *
   * Request parameters:
   *
   * [ids] - Unique table ID for retrieving real time data. Table ID is of the
   * form ga:XXXX, where XXXX is the Analytics view (profile) ID.
   * Value must have pattern "ga:[0-9]+".
   *
   * [metrics] - A comma-separated list of real time metrics. E.g.,
   * 'rt:activeUsers'. At least one metric must be specified.
   * Value must have pattern "(ga:.+)|(rt:.+)".
   *
   * [dimensions] - A comma-separated list of real time dimensions. E.g.,
   * 'rt:medium,rt:city'.
   * Value must have pattern "(ga:.+)|(rt:.+)".
   *
   * [filters] - A comma-separated list of dimension or metric filters to be
   * applied to real time data.
   * Value must have pattern "(ga:.+)|(rt:.+)".
   *
   * [max_results] - The maximum number of entries to include in this feed.
   *
   * [sort] - A comma-separated list of dimensions or metrics that determine the
   * sort order for real time data.
   * Value must have pattern "(-)?((ga:.+)|(rt:.+))".
   *
   * Completes with a [RealtimeData].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RealtimeData> get(core.String ids, core.String metrics, {core.String dimensions, core.String filters, core.int max_results, core.String sort}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (ids == null) {
      throw new core.ArgumentError("Parameter ids is required.");
    }
    _queryParams["ids"] = [ids];
    if (metrics == null) {
      throw new core.ArgumentError("Parameter metrics is required.");
    }
    _queryParams["metrics"] = [metrics];
    if (dimensions != null) {
      _queryParams["dimensions"] = [dimensions];
    }
    if (filters != null) {
      _queryParams["filters"] = [filters];
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (sort != null) {
      _queryParams["sort"] = [sort];
    }

    _url = 'data/realtime';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RealtimeData.fromJson(data));
  }

}


class ManagementResourceApi {
  final commons.ApiRequester _requester;

  ManagementAccountSummariesResourceApi get accountSummaries => new ManagementAccountSummariesResourceApi(_requester);
  ManagementAccountUserLinksResourceApi get accountUserLinks => new ManagementAccountUserLinksResourceApi(_requester);
  ManagementAccountsResourceApi get accounts => new ManagementAccountsResourceApi(_requester);
  ManagementCustomDataSourcesResourceApi get customDataSources => new ManagementCustomDataSourcesResourceApi(_requester);
  ManagementCustomDimensionsResourceApi get customDimensions => new ManagementCustomDimensionsResourceApi(_requester);
  ManagementCustomMetricsResourceApi get customMetrics => new ManagementCustomMetricsResourceApi(_requester);
  ManagementExperimentsResourceApi get experiments => new ManagementExperimentsResourceApi(_requester);
  ManagementFiltersResourceApi get filters => new ManagementFiltersResourceApi(_requester);
  ManagementGoalsResourceApi get goals => new ManagementGoalsResourceApi(_requester);
  ManagementProfileFilterLinksResourceApi get profileFilterLinks => new ManagementProfileFilterLinksResourceApi(_requester);
  ManagementProfileUserLinksResourceApi get profileUserLinks => new ManagementProfileUserLinksResourceApi(_requester);
  ManagementProfilesResourceApi get profiles => new ManagementProfilesResourceApi(_requester);
  ManagementRemarketingAudienceResourceApi get remarketingAudience => new ManagementRemarketingAudienceResourceApi(_requester);
  ManagementSegmentsResourceApi get segments => new ManagementSegmentsResourceApi(_requester);
  ManagementUnsampledReportsResourceApi get unsampledReports => new ManagementUnsampledReportsResourceApi(_requester);
  ManagementUploadsResourceApi get uploads => new ManagementUploadsResourceApi(_requester);
  ManagementWebPropertyAdWordsLinksResourceApi get webPropertyAdWordsLinks => new ManagementWebPropertyAdWordsLinksResourceApi(_requester);
  ManagementWebpropertiesResourceApi get webproperties => new ManagementWebpropertiesResourceApi(_requester);
  ManagementWebpropertyUserLinksResourceApi get webpropertyUserLinks => new ManagementWebpropertyUserLinksResourceApi(_requester);

  ManagementResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class ManagementAccountSummariesResourceApi {
  final commons.ApiRequester _requester;

  ManagementAccountSummariesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists account summaries (lightweight tree comprised of
   * accounts/properties/profiles) to which the user has access.
   *
   * Request parameters:
   *
   * [max_results] - The maximum number of account summaries to include in this
   * response, where the largest acceptable value is 1000.
   *
   * [start_index] - An index of the first entity to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [AccountSummaries].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountSummaries> list({core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accountSummaries';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountSummaries.fromJson(data));
  }

}


class ManagementAccountUserLinksResourceApi {
  final commons.ApiRequester _requester;

  ManagementAccountUserLinksResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Removes a user from the given account.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to delete the user link for.
   *
   * [linkId] - Link ID to delete the user link for.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String accountId, core.String linkId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (linkId == null) {
      throw new core.ArgumentError("Parameter linkId is required.");
    }

    _downloadOptions = null;

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/entityUserLinks/' + commons.Escaper.ecapeVariable('$linkId');

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
   * Adds a new user to the given account.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to create the user link for.
   *
   * Completes with a [EntityUserLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityUserLink> insert(EntityUserLink request, core.String accountId) {
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

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/entityUserLinks';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityUserLink.fromJson(data));
  }

  /**
   * Lists account-user links for a given account.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve the user links for.
   *
   * [max_results] - The maximum number of account-user links to include in this
   * response.
   *
   * [start_index] - An index of the first account-user link to retrieve. Use
   * this parameter as a pagination mechanism along with the max-results
   * parameter.
   *
   * Completes with a [EntityUserLinks].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityUserLinks> list(core.String accountId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/entityUserLinks';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityUserLinks.fromJson(data));
  }

  /**
   * Updates permissions for an existing user on the given account.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to update the account-user link for.
   *
   * [linkId] - Link ID to update the account-user link for.
   *
   * Completes with a [EntityUserLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityUserLink> update(EntityUserLink request, core.String accountId, core.String linkId) {
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
    if (linkId == null) {
      throw new core.ArgumentError("Parameter linkId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/entityUserLinks/' + commons.Escaper.ecapeVariable('$linkId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityUserLink.fromJson(data));
  }

}


class ManagementAccountsResourceApi {
  final commons.ApiRequester _requester;

  ManagementAccountsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists all accounts to which the user has access.
   *
   * Request parameters:
   *
   * [max_results] - The maximum number of accounts to include in this response.
   *
   * [start_index] - An index of the first account to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [Accounts].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Accounts> list({core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts';

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


class ManagementCustomDataSourcesResourceApi {
  final commons.ApiRequester _requester;

  ManagementCustomDataSourcesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List custom data sources to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account Id for the custom data sources to retrieve.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property Id for the custom data sources to retrieve.
   * Value must have pattern "UA-(\d+)-(\d+)".
   *
   * [max_results] - The maximum number of custom data sources to include in
   * this response.
   *
   * [start_index] - A 1-based index of the first custom data source to
   * retrieve. Use this parameter as a pagination mechanism along with the
   * max-results parameter.
   *
   * Completes with a [CustomDataSources].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomDataSources> list(core.String accountId, core.String webPropertyId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customDataSources';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomDataSources.fromJson(data));
  }

}


class ManagementCustomDimensionsResourceApi {
  final commons.ApiRequester _requester;

  ManagementCustomDimensionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get a custom dimension to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID for the custom dimension to retrieve.
   *
   * [webPropertyId] - Web property ID for the custom dimension to retrieve.
   *
   * [customDimensionId] - The ID of the custom dimension to retrieve.
   *
   * Completes with a [CustomDimension].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomDimension> get(core.String accountId, core.String webPropertyId, core.String customDimensionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (customDimensionId == null) {
      throw new core.ArgumentError("Parameter customDimensionId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customDimensions/' + commons.Escaper.ecapeVariable('$customDimensionId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomDimension.fromJson(data));
  }

  /**
   * Create a new custom dimension.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID for the custom dimension to create.
   *
   * [webPropertyId] - Web property ID for the custom dimension to create.
   *
   * Completes with a [CustomDimension].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomDimension> insert(CustomDimension request, core.String accountId, core.String webPropertyId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customDimensions';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomDimension.fromJson(data));
  }

  /**
   * Lists custom dimensions to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID for the custom dimensions to retrieve.
   *
   * [webPropertyId] - Web property ID for the custom dimensions to retrieve.
   *
   * [max_results] - The maximum number of custom dimensions to include in this
   * response.
   *
   * [start_index] - An index of the first entity to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [CustomDimensions].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomDimensions> list(core.String accountId, core.String webPropertyId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customDimensions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomDimensions.fromJson(data));
  }

  /**
   * Updates an existing custom dimension. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID for the custom dimension to update.
   *
   * [webPropertyId] - Web property ID for the custom dimension to update.
   *
   * [customDimensionId] - Custom dimension ID for the custom dimension to
   * update.
   *
   * [ignoreCustomDataSourceLinks] - Force the update and ignore any warnings
   * related to the custom dimension being linked to a custom data source / data
   * set.
   *
   * Completes with a [CustomDimension].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomDimension> patch(CustomDimension request, core.String accountId, core.String webPropertyId, core.String customDimensionId, {core.bool ignoreCustomDataSourceLinks}) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (customDimensionId == null) {
      throw new core.ArgumentError("Parameter customDimensionId is required.");
    }
    if (ignoreCustomDataSourceLinks != null) {
      _queryParams["ignoreCustomDataSourceLinks"] = ["${ignoreCustomDataSourceLinks}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customDimensions/' + commons.Escaper.ecapeVariable('$customDimensionId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomDimension.fromJson(data));
  }

  /**
   * Updates an existing custom dimension.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID for the custom dimension to update.
   *
   * [webPropertyId] - Web property ID for the custom dimension to update.
   *
   * [customDimensionId] - Custom dimension ID for the custom dimension to
   * update.
   *
   * [ignoreCustomDataSourceLinks] - Force the update and ignore any warnings
   * related to the custom dimension being linked to a custom data source / data
   * set.
   *
   * Completes with a [CustomDimension].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomDimension> update(CustomDimension request, core.String accountId, core.String webPropertyId, core.String customDimensionId, {core.bool ignoreCustomDataSourceLinks}) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (customDimensionId == null) {
      throw new core.ArgumentError("Parameter customDimensionId is required.");
    }
    if (ignoreCustomDataSourceLinks != null) {
      _queryParams["ignoreCustomDataSourceLinks"] = ["${ignoreCustomDataSourceLinks}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customDimensions/' + commons.Escaper.ecapeVariable('$customDimensionId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomDimension.fromJson(data));
  }

}


class ManagementCustomMetricsResourceApi {
  final commons.ApiRequester _requester;

  ManagementCustomMetricsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get a custom metric to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID for the custom metric to retrieve.
   *
   * [webPropertyId] - Web property ID for the custom metric to retrieve.
   *
   * [customMetricId] - The ID of the custom metric to retrieve.
   *
   * Completes with a [CustomMetric].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomMetric> get(core.String accountId, core.String webPropertyId, core.String customMetricId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (customMetricId == null) {
      throw new core.ArgumentError("Parameter customMetricId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customMetrics/' + commons.Escaper.ecapeVariable('$customMetricId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomMetric.fromJson(data));
  }

  /**
   * Create a new custom metric.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID for the custom metric to create.
   *
   * [webPropertyId] - Web property ID for the custom dimension to create.
   *
   * Completes with a [CustomMetric].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomMetric> insert(CustomMetric request, core.String accountId, core.String webPropertyId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customMetrics';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomMetric.fromJson(data));
  }

  /**
   * Lists custom metrics to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID for the custom metrics to retrieve.
   *
   * [webPropertyId] - Web property ID for the custom metrics to retrieve.
   *
   * [max_results] - The maximum number of custom metrics to include in this
   * response.
   *
   * [start_index] - An index of the first entity to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [CustomMetrics].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomMetrics> list(core.String accountId, core.String webPropertyId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customMetrics';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomMetrics.fromJson(data));
  }

  /**
   * Updates an existing custom metric. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID for the custom metric to update.
   *
   * [webPropertyId] - Web property ID for the custom metric to update.
   *
   * [customMetricId] - Custom metric ID for the custom metric to update.
   *
   * [ignoreCustomDataSourceLinks] - Force the update and ignore any warnings
   * related to the custom metric being linked to a custom data source / data
   * set.
   *
   * Completes with a [CustomMetric].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomMetric> patch(CustomMetric request, core.String accountId, core.String webPropertyId, core.String customMetricId, {core.bool ignoreCustomDataSourceLinks}) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (customMetricId == null) {
      throw new core.ArgumentError("Parameter customMetricId is required.");
    }
    if (ignoreCustomDataSourceLinks != null) {
      _queryParams["ignoreCustomDataSourceLinks"] = ["${ignoreCustomDataSourceLinks}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customMetrics/' + commons.Escaper.ecapeVariable('$customMetricId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomMetric.fromJson(data));
  }

  /**
   * Updates an existing custom metric.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID for the custom metric to update.
   *
   * [webPropertyId] - Web property ID for the custom metric to update.
   *
   * [customMetricId] - Custom metric ID for the custom metric to update.
   *
   * [ignoreCustomDataSourceLinks] - Force the update and ignore any warnings
   * related to the custom metric being linked to a custom data source / data
   * set.
   *
   * Completes with a [CustomMetric].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CustomMetric> update(CustomMetric request, core.String accountId, core.String webPropertyId, core.String customMetricId, {core.bool ignoreCustomDataSourceLinks}) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (customMetricId == null) {
      throw new core.ArgumentError("Parameter customMetricId is required.");
    }
    if (ignoreCustomDataSourceLinks != null) {
      _queryParams["ignoreCustomDataSourceLinks"] = ["${ignoreCustomDataSourceLinks}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customMetrics/' + commons.Escaper.ecapeVariable('$customMetricId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CustomMetric.fromJson(data));
  }

}


class ManagementExperimentsResourceApi {
  final commons.ApiRequester _requester;

  ManagementExperimentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Delete an experiment.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to which the experiment belongs
   *
   * [webPropertyId] - Web property ID to which the experiment belongs
   *
   * [profileId] - View (Profile) ID to which the experiment belongs
   *
   * [experimentId] - ID of the experiment to delete
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String accountId, core.String webPropertyId, core.String profileId, core.String experimentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (experimentId == null) {
      throw new core.ArgumentError("Parameter experimentId is required.");
    }

    _downloadOptions = null;

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/experiments/' + commons.Escaper.ecapeVariable('$experimentId');

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
   * Returns an experiment to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve the experiment for.
   *
   * [webPropertyId] - Web property ID to retrieve the experiment for.
   *
   * [profileId] - View (Profile) ID to retrieve the experiment for.
   *
   * [experimentId] - Experiment ID to retrieve the experiment for.
   *
   * Completes with a [Experiment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Experiment> get(core.String accountId, core.String webPropertyId, core.String profileId, core.String experimentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (experimentId == null) {
      throw new core.ArgumentError("Parameter experimentId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/experiments/' + commons.Escaper.ecapeVariable('$experimentId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Experiment.fromJson(data));
  }

  /**
   * Create a new experiment.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to create the experiment for.
   *
   * [webPropertyId] - Web property ID to create the experiment for.
   *
   * [profileId] - View (Profile) ID to create the experiment for.
   *
   * Completes with a [Experiment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Experiment> insert(Experiment request, core.String accountId, core.String webPropertyId, core.String profileId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/experiments';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Experiment.fromJson(data));
  }

  /**
   * Lists experiments to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve experiments for.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property ID to retrieve experiments for.
   * Value must have pattern "UA-(\d+)-(\d+)".
   *
   * [profileId] - View (Profile) ID to retrieve experiments for.
   * Value must have pattern "\d+".
   *
   * [max_results] - The maximum number of experiments to include in this
   * response.
   *
   * [start_index] - An index of the first experiment to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [Experiments].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Experiments> list(core.String accountId, core.String webPropertyId, core.String profileId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/experiments';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Experiments.fromJson(data));
  }

  /**
   * Update an existing experiment. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID of the experiment to update.
   *
   * [webPropertyId] - Web property ID of the experiment to update.
   *
   * [profileId] - View (Profile) ID of the experiment to update.
   *
   * [experimentId] - Experiment ID of the experiment to update.
   *
   * Completes with a [Experiment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Experiment> patch(Experiment request, core.String accountId, core.String webPropertyId, core.String profileId, core.String experimentId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (experimentId == null) {
      throw new core.ArgumentError("Parameter experimentId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/experiments/' + commons.Escaper.ecapeVariable('$experimentId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Experiment.fromJson(data));
  }

  /**
   * Update an existing experiment.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID of the experiment to update.
   *
   * [webPropertyId] - Web property ID of the experiment to update.
   *
   * [profileId] - View (Profile) ID of the experiment to update.
   *
   * [experimentId] - Experiment ID of the experiment to update.
   *
   * Completes with a [Experiment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Experiment> update(Experiment request, core.String accountId, core.String webPropertyId, core.String profileId, core.String experimentId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (experimentId == null) {
      throw new core.ArgumentError("Parameter experimentId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/experiments/' + commons.Escaper.ecapeVariable('$experimentId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Experiment.fromJson(data));
  }

}


class ManagementFiltersResourceApi {
  final commons.ApiRequester _requester;

  ManagementFiltersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Delete a filter.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to delete the filter for.
   *
   * [filterId] - ID of the filter to be deleted.
   *
   * Completes with a [Filter].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Filter> delete(core.String accountId, core.String filterId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterId == null) {
      throw new core.ArgumentError("Parameter filterId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/filters/' + commons.Escaper.ecapeVariable('$filterId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Filter.fromJson(data));
  }

  /**
   * Returns a filters to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve filters for.
   *
   * [filterId] - Filter ID to retrieve filters for.
   *
   * Completes with a [Filter].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Filter> get(core.String accountId, core.String filterId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (filterId == null) {
      throw new core.ArgumentError("Parameter filterId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/filters/' + commons.Escaper.ecapeVariable('$filterId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Filter.fromJson(data));
  }

  /**
   * Create a new filter.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to create filter for.
   *
   * Completes with a [Filter].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Filter> insert(Filter request, core.String accountId) {
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

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/filters';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Filter.fromJson(data));
  }

  /**
   * Lists all filters for an account
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve filters for.
   * Value must have pattern "\d+".
   *
   * [max_results] - The maximum number of filters to include in this response.
   *
   * [start_index] - An index of the first entity to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [Filters].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Filters> list(core.String accountId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/filters';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Filters.fromJson(data));
  }

  /**
   * Updates an existing filter. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to which the filter belongs.
   *
   * [filterId] - ID of the filter to be updated.
   *
   * Completes with a [Filter].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Filter> patch(Filter request, core.String accountId, core.String filterId) {
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
    if (filterId == null) {
      throw new core.ArgumentError("Parameter filterId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/filters/' + commons.Escaper.ecapeVariable('$filterId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Filter.fromJson(data));
  }

  /**
   * Updates an existing filter.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to which the filter belongs.
   *
   * [filterId] - ID of the filter to be updated.
   *
   * Completes with a [Filter].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Filter> update(Filter request, core.String accountId, core.String filterId) {
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
    if (filterId == null) {
      throw new core.ArgumentError("Parameter filterId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/filters/' + commons.Escaper.ecapeVariable('$filterId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Filter.fromJson(data));
  }

}


class ManagementGoalsResourceApi {
  final commons.ApiRequester _requester;

  ManagementGoalsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets a goal to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve the goal for.
   *
   * [webPropertyId] - Web property ID to retrieve the goal for.
   *
   * [profileId] - View (Profile) ID to retrieve the goal for.
   *
   * [goalId] - Goal ID to retrieve the goal for.
   *
   * Completes with a [Goal].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Goal> get(core.String accountId, core.String webPropertyId, core.String profileId, core.String goalId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (goalId == null) {
      throw new core.ArgumentError("Parameter goalId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/goals/' + commons.Escaper.ecapeVariable('$goalId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Goal.fromJson(data));
  }

  /**
   * Create a new goal.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to create the goal for.
   *
   * [webPropertyId] - Web property ID to create the goal for.
   *
   * [profileId] - View (Profile) ID to create the goal for.
   *
   * Completes with a [Goal].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Goal> insert(Goal request, core.String accountId, core.String webPropertyId, core.String profileId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/goals';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Goal.fromJson(data));
  }

  /**
   * Lists goals to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve goals for. Can either be a specific
   * account ID or '~all', which refers to all the accounts that user has access
   * to.
   *
   * [webPropertyId] - Web property ID to retrieve goals for. Can either be a
   * specific web property ID or '~all', which refers to all the web properties
   * that user has access to.
   *
   * [profileId] - View (Profile) ID to retrieve goals for. Can either be a
   * specific view (profile) ID or '~all', which refers to all the views
   * (profiles) that user has access to.
   *
   * [max_results] - The maximum number of goals to include in this response.
   *
   * [start_index] - An index of the first goal to retrieve. Use this parameter
   * as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [Goals].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Goals> list(core.String accountId, core.String webPropertyId, core.String profileId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/goals';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Goals.fromJson(data));
  }

  /**
   * Updates an existing goal. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to update the goal.
   *
   * [webPropertyId] - Web property ID to update the goal.
   *
   * [profileId] - View (Profile) ID to update the goal.
   *
   * [goalId] - Index of the goal to be updated.
   *
   * Completes with a [Goal].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Goal> patch(Goal request, core.String accountId, core.String webPropertyId, core.String profileId, core.String goalId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (goalId == null) {
      throw new core.ArgumentError("Parameter goalId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/goals/' + commons.Escaper.ecapeVariable('$goalId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Goal.fromJson(data));
  }

  /**
   * Updates an existing goal.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to update the goal.
   *
   * [webPropertyId] - Web property ID to update the goal.
   *
   * [profileId] - View (Profile) ID to update the goal.
   *
   * [goalId] - Index of the goal to be updated.
   *
   * Completes with a [Goal].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Goal> update(Goal request, core.String accountId, core.String webPropertyId, core.String profileId, core.String goalId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (goalId == null) {
      throw new core.ArgumentError("Parameter goalId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/goals/' + commons.Escaper.ecapeVariable('$goalId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Goal.fromJson(data));
  }

}


class ManagementProfileFilterLinksResourceApi {
  final commons.ApiRequester _requester;

  ManagementProfileFilterLinksResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Delete a profile filter link.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to which the profile filter link belongs.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property Id to which the profile filter link belongs.
   * Value must have pattern "UA-(\d+)-(\d+)".
   *
   * [profileId] - Profile ID to which the filter link belongs.
   * Value must have pattern "\d+".
   *
   * [linkId] - ID of the profile filter link to delete.
   * Value must have pattern "\d+:\d+".
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String accountId, core.String webPropertyId, core.String profileId, core.String linkId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (linkId == null) {
      throw new core.ArgumentError("Parameter linkId is required.");
    }

    _downloadOptions = null;

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/profileFilterLinks/' + commons.Escaper.ecapeVariable('$linkId');

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
   * Returns a single profile filter link.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve profile filter link for.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property Id to retrieve profile filter link for.
   * Value must have pattern "UA-(\d+)-(\d+)".
   *
   * [profileId] - Profile ID to retrieve filter link for.
   * Value must have pattern "\d+".
   *
   * [linkId] - ID of the profile filter link.
   * Value must have pattern "\d+:\d+".
   *
   * Completes with a [ProfileFilterLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProfileFilterLink> get(core.String accountId, core.String webPropertyId, core.String profileId, core.String linkId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (linkId == null) {
      throw new core.ArgumentError("Parameter linkId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/profileFilterLinks/' + commons.Escaper.ecapeVariable('$linkId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProfileFilterLink.fromJson(data));
  }

  /**
   * Create a new profile filter link.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to create profile filter link for.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property Id to create profile filter link for.
   * Value must have pattern "UA-(\d+)-(\d+)".
   *
   * [profileId] - Profile ID to create filter link for.
   * Value must have pattern "\d+".
   *
   * Completes with a [ProfileFilterLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProfileFilterLink> insert(ProfileFilterLink request, core.String accountId, core.String webPropertyId, core.String profileId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/profileFilterLinks';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProfileFilterLink.fromJson(data));
  }

  /**
   * Lists all profile filter links for a profile.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve profile filter links for.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property Id for profile filter links for. Can either
   * be a specific web property ID or '~all', which refers to all the web
   * properties that user has access to.
   *
   * [profileId] - Profile ID to retrieve filter links for. Can either be a
   * specific profile ID or '~all', which refers to all the profiles that user
   * has access to.
   *
   * [max_results] - The maximum number of profile filter links to include in
   * this response.
   *
   * [start_index] - An index of the first entity to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [ProfileFilterLinks].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProfileFilterLinks> list(core.String accountId, core.String webPropertyId, core.String profileId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/profileFilterLinks';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProfileFilterLinks.fromJson(data));
  }

  /**
   * Update an existing profile filter link. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to which profile filter link belongs.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property Id to which profile filter link belongs
   * Value must have pattern "UA-(\d+)-(\d+)".
   *
   * [profileId] - Profile ID to which filter link belongs
   * Value must have pattern "\d+".
   *
   * [linkId] - ID of the profile filter link to be updated.
   * Value must have pattern "\d+:\d+".
   *
   * Completes with a [ProfileFilterLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProfileFilterLink> patch(ProfileFilterLink request, core.String accountId, core.String webPropertyId, core.String profileId, core.String linkId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (linkId == null) {
      throw new core.ArgumentError("Parameter linkId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/profileFilterLinks/' + commons.Escaper.ecapeVariable('$linkId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProfileFilterLink.fromJson(data));
  }

  /**
   * Update an existing profile filter link.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to which profile filter link belongs.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property Id to which profile filter link belongs
   * Value must have pattern "UA-(\d+)-(\d+)".
   *
   * [profileId] - Profile ID to which filter link belongs
   * Value must have pattern "\d+".
   *
   * [linkId] - ID of the profile filter link to be updated.
   * Value must have pattern "\d+:\d+".
   *
   * Completes with a [ProfileFilterLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProfileFilterLink> update(ProfileFilterLink request, core.String accountId, core.String webPropertyId, core.String profileId, core.String linkId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (linkId == null) {
      throw new core.ArgumentError("Parameter linkId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/profileFilterLinks/' + commons.Escaper.ecapeVariable('$linkId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProfileFilterLink.fromJson(data));
  }

}


class ManagementProfileUserLinksResourceApi {
  final commons.ApiRequester _requester;

  ManagementProfileUserLinksResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Removes a user from the given view (profile).
   *
   * Request parameters:
   *
   * [accountId] - Account ID to delete the user link for.
   *
   * [webPropertyId] - Web Property ID to delete the user link for.
   *
   * [profileId] - View (Profile) ID to delete the user link for.
   *
   * [linkId] - Link ID to delete the user link for.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String accountId, core.String webPropertyId, core.String profileId, core.String linkId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (linkId == null) {
      throw new core.ArgumentError("Parameter linkId is required.");
    }

    _downloadOptions = null;

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/entityUserLinks/' + commons.Escaper.ecapeVariable('$linkId');

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
   * Adds a new user to the given view (profile).
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to create the user link for.
   *
   * [webPropertyId] - Web Property ID to create the user link for.
   *
   * [profileId] - View (Profile) ID to create the user link for.
   *
   * Completes with a [EntityUserLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityUserLink> insert(EntityUserLink request, core.String accountId, core.String webPropertyId, core.String profileId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/entityUserLinks';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityUserLink.fromJson(data));
  }

  /**
   * Lists profile-user links for a given view (profile).
   *
   * Request parameters:
   *
   * [accountId] - Account ID which the given view (profile) belongs to.
   *
   * [webPropertyId] - Web Property ID which the given view (profile) belongs
   * to. Can either be a specific web property ID or '~all', which refers to all
   * the web properties that user has access to.
   *
   * [profileId] - View (Profile) ID to retrieve the profile-user links for. Can
   * either be a specific profile ID or '~all', which refers to all the profiles
   * that user has access to.
   *
   * [max_results] - The maximum number of profile-user links to include in this
   * response.
   *
   * [start_index] - An index of the first profile-user link to retrieve. Use
   * this parameter as a pagination mechanism along with the max-results
   * parameter.
   *
   * Completes with a [EntityUserLinks].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityUserLinks> list(core.String accountId, core.String webPropertyId, core.String profileId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/entityUserLinks';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityUserLinks.fromJson(data));
  }

  /**
   * Updates permissions for an existing user on the given view (profile).
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to update the user link for.
   *
   * [webPropertyId] - Web Property ID to update the user link for.
   *
   * [profileId] - View (Profile ID) to update the user link for.
   *
   * [linkId] - Link ID to update the user link for.
   *
   * Completes with a [EntityUserLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityUserLink> update(EntityUserLink request, core.String accountId, core.String webPropertyId, core.String profileId, core.String linkId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (linkId == null) {
      throw new core.ArgumentError("Parameter linkId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/entityUserLinks/' + commons.Escaper.ecapeVariable('$linkId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityUserLink.fromJson(data));
  }

}


class ManagementProfilesResourceApi {
  final commons.ApiRequester _requester;

  ManagementProfilesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a view (profile).
   *
   * Request parameters:
   *
   * [accountId] - Account ID to delete the view (profile) for.
   *
   * [webPropertyId] - Web property ID to delete the view (profile) for.
   *
   * [profileId] - ID of the view (profile) to be deleted.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String accountId, core.String webPropertyId, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _downloadOptions = null;

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId');

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
   * Gets a view (profile) to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve the view (profile) for.
   * Value must have pattern "[0-9]+".
   *
   * [webPropertyId] - Web property ID to retrieve the view (profile) for.
   * Value must have pattern "UA-[0-9]+-[0-9]+".
   *
   * [profileId] - View (Profile) ID to retrieve the view (profile) for.
   * Value must have pattern "[0-9]+".
   *
   * Completes with a [Profile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Profile> get(core.String accountId, core.String webPropertyId, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Profile.fromJson(data));
  }

  /**
   * Create a new view (profile).
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to create the view (profile) for.
   *
   * [webPropertyId] - Web property ID to create the view (profile) for.
   *
   * Completes with a [Profile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Profile> insert(Profile request, core.String accountId, core.String webPropertyId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Profile.fromJson(data));
  }

  /**
   * Lists views (profiles) to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID for the view (profiles) to retrieve. Can either be
   * a specific account ID or '~all', which refers to all the accounts to which
   * the user has access.
   *
   * [webPropertyId] - Web property ID for the views (profiles) to retrieve. Can
   * either be a specific web property ID or '~all', which refers to all the web
   * properties to which the user has access.
   *
   * [max_results] - The maximum number of views (profiles) to include in this
   * response.
   *
   * [start_index] - An index of the first entity to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [Profiles].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Profiles> list(core.String accountId, core.String webPropertyId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Profiles.fromJson(data));
  }

  /**
   * Updates an existing view (profile). This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to which the view (profile) belongs
   *
   * [webPropertyId] - Web property ID to which the view (profile) belongs
   *
   * [profileId] - ID of the view (profile) to be updated.
   *
   * Completes with a [Profile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Profile> patch(Profile request, core.String accountId, core.String webPropertyId, core.String profileId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Profile.fromJson(data));
  }

  /**
   * Updates an existing view (profile).
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to which the view (profile) belongs
   *
   * [webPropertyId] - Web property ID to which the view (profile) belongs
   *
   * [profileId] - ID of the view (profile) to be updated.
   *
   * Completes with a [Profile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Profile> update(Profile request, core.String accountId, core.String webPropertyId, core.String profileId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Profile.fromJson(data));
  }

}


class ManagementRemarketingAudienceResourceApi {
  final commons.ApiRequester _requester;

  ManagementRemarketingAudienceResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets a remarketing audience to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - The account ID of the remarketing audience to retrieve.
   *
   * [webPropertyId] - The web property ID of the remarketing audience to
   * retrieve.
   *
   * [remarketingAudienceId] - The ID of the remarketing audience to retrieve.
   *
   * Completes with a [RemarketingAudience].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingAudience> get(core.String accountId, core.String webPropertyId, core.String remarketingAudienceId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (remarketingAudienceId == null) {
      throw new core.ArgumentError("Parameter remarketingAudienceId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/remarketingAudiences/' + commons.Escaper.ecapeVariable('$remarketingAudienceId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingAudience.fromJson(data));
  }

  /**
   * Creates a new remarketing audience.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - The account ID for which to create the remarketing audience.
   *
   * [webPropertyId] - Web property ID for which to create the remarketing
   * audience.
   *
   * Completes with a [RemarketingAudience].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingAudience> insert(RemarketingAudience request, core.String accountId, core.String webPropertyId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/remarketingAudiences';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingAudience.fromJson(data));
  }

  /**
   * Lists remarketing audiences to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - The account ID of the remarketing audiences to retrieve.
   *
   * [webPropertyId] - The web property ID of the remarketing audiences to
   * retrieve.
   *
   * [max_results] - The maximum number of remarketing audiences to include in
   * this response.
   *
   * [start_index] - An index of the first entity to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * [type] - null
   *
   * Completes with a [RemarketingAudiences].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingAudiences> list(core.String accountId, core.String webPropertyId, {core.int max_results, core.int start_index, core.String type}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }
    if (type != null) {
      _queryParams["type"] = [type];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/remarketingAudiences';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingAudiences.fromJson(data));
  }

  /**
   * Updates an existing remarketing audience. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - The account ID of the remarketing audience to update.
   *
   * [webPropertyId] - The web property ID of the remarketing audience to
   * update.
   *
   * [remarketingAudienceId] - The ID of the remarketing audience to update.
   *
   * Completes with a [RemarketingAudience].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingAudience> patch(RemarketingAudience request, core.String accountId, core.String webPropertyId, core.String remarketingAudienceId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (remarketingAudienceId == null) {
      throw new core.ArgumentError("Parameter remarketingAudienceId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/remarketingAudiences/' + commons.Escaper.ecapeVariable('$remarketingAudienceId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingAudience.fromJson(data));
  }

  /**
   * Updates an existing remarketing audience.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - The account ID of the remarketing audience to update.
   *
   * [webPropertyId] - The web property ID of the remarketing audience to
   * update.
   *
   * [remarketingAudienceId] - The ID of the remarketing audience to update.
   *
   * Completes with a [RemarketingAudience].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingAudience> update(RemarketingAudience request, core.String accountId, core.String webPropertyId, core.String remarketingAudienceId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (remarketingAudienceId == null) {
      throw new core.ArgumentError("Parameter remarketingAudienceId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/remarketingAudiences/' + commons.Escaper.ecapeVariable('$remarketingAudienceId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingAudience.fromJson(data));
  }

}


class ManagementSegmentsResourceApi {
  final commons.ApiRequester _requester;

  ManagementSegmentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists segments to which the user has access.
   *
   * Request parameters:
   *
   * [max_results] - The maximum number of segments to include in this response.
   *
   * [start_index] - An index of the first segment to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [Segments].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Segments> list({core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/segments';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Segments.fromJson(data));
  }

}


class ManagementUnsampledReportsResourceApi {
  final commons.ApiRequester _requester;

  ManagementUnsampledReportsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an unsampled report.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to delete the unsampled report for.
   *
   * [webPropertyId] - Web property ID to delete the unsampled reports for.
   *
   * [profileId] - View (Profile) ID to delete the unsampled report for.
   *
   * [unsampledReportId] - ID of the unsampled report to be deleted.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String accountId, core.String webPropertyId, core.String profileId, core.String unsampledReportId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (unsampledReportId == null) {
      throw new core.ArgumentError("Parameter unsampledReportId is required.");
    }

    _downloadOptions = null;

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/unsampledReports/' + commons.Escaper.ecapeVariable('$unsampledReportId');

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
   * Returns a single unsampled report.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve unsampled report for.
   *
   * [webPropertyId] - Web property ID to retrieve unsampled reports for.
   *
   * [profileId] - View (Profile) ID to retrieve unsampled report for.
   *
   * [unsampledReportId] - ID of the unsampled report to retrieve.
   *
   * Completes with a [UnsampledReport].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UnsampledReport> get(core.String accountId, core.String webPropertyId, core.String profileId, core.String unsampledReportId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (unsampledReportId == null) {
      throw new core.ArgumentError("Parameter unsampledReportId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/unsampledReports/' + commons.Escaper.ecapeVariable('$unsampledReportId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UnsampledReport.fromJson(data));
  }

  /**
   * Create a new unsampled report.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to create the unsampled report for.
   *
   * [webPropertyId] - Web property ID to create the unsampled report for.
   *
   * [profileId] - View (Profile) ID to create the unsampled report for.
   *
   * Completes with a [UnsampledReport].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UnsampledReport> insert(UnsampledReport request, core.String accountId, core.String webPropertyId, core.String profileId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/unsampledReports';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UnsampledReport.fromJson(data));
  }

  /**
   * Lists unsampled reports to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve unsampled reports for. Must be a
   * specific account ID, ~all is not supported.
   *
   * [webPropertyId] - Web property ID to retrieve unsampled reports for. Must
   * be a specific web property ID, ~all is not supported.
   *
   * [profileId] - View (Profile) ID to retrieve unsampled reports for. Must be
   * a specific view (profile) ID, ~all is not supported.
   *
   * [max_results] - The maximum number of unsampled reports to include in this
   * response.
   *
   * [start_index] - An index of the first unsampled report to retrieve. Use
   * this parameter as a pagination mechanism along with the max-results
   * parameter.
   *
   * Completes with a [UnsampledReports].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UnsampledReports> list(core.String accountId, core.String webPropertyId, core.String profileId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/profiles/' + commons.Escaper.ecapeVariable('$profileId') + '/unsampledReports';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UnsampledReports.fromJson(data));
  }

}


class ManagementUploadsResourceApi {
  final commons.ApiRequester _requester;

  ManagementUploadsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Delete data associated with a previous upload.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account Id for the uploads to be deleted.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property Id for the uploads to be deleted.
   * Value must have pattern "UA-(\d+)-(\d+)".
   *
   * [customDataSourceId] - Custom data source Id for the uploads to be deleted.
   * Value must have pattern ".{22}".
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future deleteUploadData(AnalyticsDataimportDeleteUploadDataRequest request, core.String accountId, core.String webPropertyId, core.String customDataSourceId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (customDataSourceId == null) {
      throw new core.ArgumentError("Parameter customDataSourceId is required.");
    }

    _downloadOptions = null;

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customDataSources/' + commons.Escaper.ecapeVariable('$customDataSourceId') + '/deleteUploadData';

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
   * List uploads to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account Id for the upload to retrieve.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property Id for the upload to retrieve.
   * Value must have pattern "UA-(\d+)-(\d+)".
   *
   * [customDataSourceId] - Custom data source Id for upload to retrieve.
   * Value must have pattern ".{22}".
   *
   * [uploadId] - Upload Id to retrieve.
   * Value must have pattern ".{22}".
   *
   * Completes with a [Upload].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Upload> get(core.String accountId, core.String webPropertyId, core.String customDataSourceId, core.String uploadId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (customDataSourceId == null) {
      throw new core.ArgumentError("Parameter customDataSourceId is required.");
    }
    if (uploadId == null) {
      throw new core.ArgumentError("Parameter uploadId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customDataSources/' + commons.Escaper.ecapeVariable('$customDataSourceId') + '/uploads/' + commons.Escaper.ecapeVariable('$uploadId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Upload.fromJson(data));
  }

  /**
   * List uploads to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account Id for the uploads to retrieve.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property Id for the uploads to retrieve.
   * Value must have pattern "UA-(\d+)-(\d+)".
   *
   * [customDataSourceId] - Custom data source Id for uploads to retrieve.
   * Value must have pattern ".{22}".
   *
   * [max_results] - The maximum number of uploads to include in this response.
   *
   * [start_index] - A 1-based index of the first upload to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [Uploads].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Uploads> list(core.String accountId, core.String webPropertyId, core.String customDataSourceId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (customDataSourceId == null) {
      throw new core.ArgumentError("Parameter customDataSourceId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customDataSources/' + commons.Escaper.ecapeVariable('$customDataSourceId') + '/uploads';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Uploads.fromJson(data));
  }

  /**
   * Upload data for a custom data source.
   *
   * Request parameters:
   *
   * [accountId] - Account Id associated with the upload.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property UA-string associated with the upload.
   * Value must have pattern "UA-\d+-\d+".
   *
   * [customDataSourceId] - Custom data source Id to which the data being
   * uploaded belongs.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [Upload].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Upload> uploadData(core.String accountId, core.String webPropertyId, core.String customDataSourceId, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (customDataSourceId == null) {
      throw new core.ArgumentError("Parameter customDataSourceId is required.");
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customDataSources/' + commons.Escaper.ecapeVariable('$customDataSourceId') + '/uploads';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/analytics/v3/management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customDataSources/' + commons.Escaper.ecapeVariable('$customDataSourceId') + '/uploads';
    } else {
      _url = '/upload/analytics/v3/management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/customDataSources/' + commons.Escaper.ecapeVariable('$customDataSourceId') + '/uploads';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Upload.fromJson(data));
  }

}


class ManagementWebPropertyAdWordsLinksResourceApi {
  final commons.ApiRequester _requester;

  ManagementWebPropertyAdWordsLinksResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a web property-AdWords link.
   *
   * Request parameters:
   *
   * [accountId] - ID of the account which the given web property belongs to.
   *
   * [webPropertyId] - Web property ID to delete the AdWords link for.
   *
   * [webPropertyAdWordsLinkId] - Web property AdWords link ID.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String accountId, core.String webPropertyId, core.String webPropertyAdWordsLinkId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (webPropertyAdWordsLinkId == null) {
      throw new core.ArgumentError("Parameter webPropertyAdWordsLinkId is required.");
    }

    _downloadOptions = null;

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/entityAdWordsLinks/' + commons.Escaper.ecapeVariable('$webPropertyAdWordsLinkId');

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
   * Returns a web property-AdWords link to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - ID of the account which the given web property belongs to.
   *
   * [webPropertyId] - Web property ID to retrieve the AdWords link for.
   *
   * [webPropertyAdWordsLinkId] - Web property-AdWords link ID.
   *
   * Completes with a [EntityAdWordsLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityAdWordsLink> get(core.String accountId, core.String webPropertyId, core.String webPropertyAdWordsLinkId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (webPropertyAdWordsLinkId == null) {
      throw new core.ArgumentError("Parameter webPropertyAdWordsLinkId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/entityAdWordsLinks/' + commons.Escaper.ecapeVariable('$webPropertyAdWordsLinkId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityAdWordsLink.fromJson(data));
  }

  /**
   * Creates a webProperty-AdWords link.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - ID of the Google Analytics account to create the link for.
   *
   * [webPropertyId] - Web property ID to create the link for.
   *
   * Completes with a [EntityAdWordsLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityAdWordsLink> insert(EntityAdWordsLink request, core.String accountId, core.String webPropertyId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/entityAdWordsLinks';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityAdWordsLink.fromJson(data));
  }

  /**
   * Lists webProperty-AdWords links for a given web property.
   *
   * Request parameters:
   *
   * [accountId] - ID of the account which the given web property belongs to.
   * Value must have pattern "\d+".
   *
   * [webPropertyId] - Web property ID to retrieve the AdWords links for.
   *
   * [max_results] - The maximum number of webProperty-AdWords links to include
   * in this response.
   *
   * [start_index] - An index of the first webProperty-AdWords link to retrieve.
   * Use this parameter as a pagination mechanism along with the max-results
   * parameter.
   *
   * Completes with a [EntityAdWordsLinks].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityAdWordsLinks> list(core.String accountId, core.String webPropertyId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/entityAdWordsLinks';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityAdWordsLinks.fromJson(data));
  }

  /**
   * Updates an existing webProperty-AdWords link. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - ID of the account which the given web property belongs to.
   *
   * [webPropertyId] - Web property ID to retrieve the AdWords link for.
   *
   * [webPropertyAdWordsLinkId] - Web property-AdWords link ID.
   *
   * Completes with a [EntityAdWordsLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityAdWordsLink> patch(EntityAdWordsLink request, core.String accountId, core.String webPropertyId, core.String webPropertyAdWordsLinkId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (webPropertyAdWordsLinkId == null) {
      throw new core.ArgumentError("Parameter webPropertyAdWordsLinkId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/entityAdWordsLinks/' + commons.Escaper.ecapeVariable('$webPropertyAdWordsLinkId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityAdWordsLink.fromJson(data));
  }

  /**
   * Updates an existing webProperty-AdWords link.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - ID of the account which the given web property belongs to.
   *
   * [webPropertyId] - Web property ID to retrieve the AdWords link for.
   *
   * [webPropertyAdWordsLinkId] - Web property-AdWords link ID.
   *
   * Completes with a [EntityAdWordsLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityAdWordsLink> update(EntityAdWordsLink request, core.String accountId, core.String webPropertyId, core.String webPropertyAdWordsLinkId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (webPropertyAdWordsLinkId == null) {
      throw new core.ArgumentError("Parameter webPropertyAdWordsLinkId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/entityAdWordsLinks/' + commons.Escaper.ecapeVariable('$webPropertyAdWordsLinkId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityAdWordsLink.fromJson(data));
  }

}


class ManagementWebpropertiesResourceApi {
  final commons.ApiRequester _requester;

  ManagementWebpropertiesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets a web property to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve the web property for.
   * Value must have pattern "[0-9]+".
   *
   * [webPropertyId] - ID to retrieve the web property for.
   * Value must have pattern "UA-[0-9]+-[0-9]+".
   *
   * Completes with a [Webproperty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Webproperty> get(core.String accountId, core.String webPropertyId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Webproperty.fromJson(data));
  }

  /**
   * Create a new property if the account has fewer than 20 properties. Web
   * properties are visible in the Google Analytics interface only if they have
   * at least one profile.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to create the web property for.
   *
   * Completes with a [Webproperty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Webproperty> insert(Webproperty request, core.String accountId) {
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

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Webproperty.fromJson(data));
  }

  /**
   * Lists web properties to which the user has access.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to retrieve web properties for. Can either be a
   * specific account ID or '~all', which refers to all the accounts that user
   * has access to.
   *
   * [max_results] - The maximum number of web properties to include in this
   * response.
   *
   * [start_index] - An index of the first entity to retrieve. Use this
   * parameter as a pagination mechanism along with the max-results parameter.
   *
   * Completes with a [Webproperties].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Webproperties> list(core.String accountId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Webproperties.fromJson(data));
  }

  /**
   * Updates an existing web property. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to which the web property belongs
   *
   * [webPropertyId] - Web property ID
   *
   * Completes with a [Webproperty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Webproperty> patch(Webproperty request, core.String accountId, core.String webPropertyId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Webproperty.fromJson(data));
  }

  /**
   * Updates an existing web property.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to which the web property belongs
   *
   * [webPropertyId] - Web property ID
   *
   * Completes with a [Webproperty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Webproperty> update(Webproperty request, core.String accountId, core.String webPropertyId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Webproperty.fromJson(data));
  }

}


class ManagementWebpropertyUserLinksResourceApi {
  final commons.ApiRequester _requester;

  ManagementWebpropertyUserLinksResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Removes a user from the given web property.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to delete the user link for.
   *
   * [webPropertyId] - Web Property ID to delete the user link for.
   *
   * [linkId] - Link ID to delete the user link for.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String accountId, core.String webPropertyId, core.String linkId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (linkId == null) {
      throw new core.ArgumentError("Parameter linkId is required.");
    }

    _downloadOptions = null;

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/entityUserLinks/' + commons.Escaper.ecapeVariable('$linkId');

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
   * Adds a new user to the given web property.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to create the user link for.
   *
   * [webPropertyId] - Web Property ID to create the user link for.
   *
   * Completes with a [EntityUserLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityUserLink> insert(EntityUserLink request, core.String accountId, core.String webPropertyId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/entityUserLinks';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityUserLink.fromJson(data));
  }

  /**
   * Lists webProperty-user links for a given web property.
   *
   * Request parameters:
   *
   * [accountId] - Account ID which the given web property belongs to.
   *
   * [webPropertyId] - Web Property ID for the webProperty-user links to
   * retrieve. Can either be a specific web property ID or '~all', which refers
   * to all the web properties that user has access to.
   *
   * [max_results] - The maximum number of webProperty-user Links to include in
   * this response.
   *
   * [start_index] - An index of the first webProperty-user link to retrieve.
   * Use this parameter as a pagination mechanism along with the max-results
   * parameter.
   *
   * Completes with a [EntityUserLinks].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityUserLinks> list(core.String accountId, core.String webPropertyId, {core.int max_results, core.int start_index}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (max_results != null) {
      _queryParams["max-results"] = ["${max_results}"];
    }
    if (start_index != null) {
      _queryParams["start-index"] = ["${start_index}"];
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/entityUserLinks';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityUserLinks.fromJson(data));
  }

  /**
   * Updates permissions for an existing user on the given web property.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [accountId] - Account ID to update the account-user link for.
   *
   * [webPropertyId] - Web property ID to update the account-user link for.
   *
   * [linkId] - Link ID to update the account-user link for.
   *
   * Completes with a [EntityUserLink].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntityUserLink> update(EntityUserLink request, core.String accountId, core.String webPropertyId, core.String linkId) {
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
    if (webPropertyId == null) {
      throw new core.ArgumentError("Parameter webPropertyId is required.");
    }
    if (linkId == null) {
      throw new core.ArgumentError("Parameter linkId is required.");
    }

    _url = 'management/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/webproperties/' + commons.Escaper.ecapeVariable('$webPropertyId') + '/entityUserLinks/' + commons.Escaper.ecapeVariable('$linkId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntityUserLink.fromJson(data));
  }

}


class MetadataResourceApi {
  final commons.ApiRequester _requester;

  MetadataColumnsResourceApi get columns => new MetadataColumnsResourceApi(_requester);

  MetadataResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class MetadataColumnsResourceApi {
  final commons.ApiRequester _requester;

  MetadataColumnsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists all columns for a report type
   *
   * Request parameters:
   *
   * [reportType] - Report type. Allowed Values: 'ga'. Where 'ga' corresponds to
   * the Core Reporting API
   * Value must have pattern "ga".
   *
   * Completes with a [Columns].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Columns> list(core.String reportType) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (reportType == null) {
      throw new core.ArgumentError("Parameter reportType is required.");
    }

    _url = 'metadata/' + commons.Escaper.ecapeVariable('$reportType') + '/columns';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Columns.fromJson(data));
  }

}


class ProvisioningResourceApi {
  final commons.ApiRequester _requester;

  ProvisioningResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates an account ticket.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [AccountTicket].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountTicket> createAccountTicket(AccountTicket request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'provisioning/createAccountTicket';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountTicket.fromJson(data));
  }

}



/**
 * Child link for an account entry. Points to the list of web properties for
 * this account.
 */
class AccountChildLink {
  /** Link to the list of web properties for this account. */
  core.String href;
  /** Type of the child link. Its value is "analytics#webproperties". */
  core.String type;

  AccountChildLink();

  AccountChildLink.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (href != null) {
      _json["href"] = href;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Permissions the user has for this account. */
class AccountPermissions {
  /**
   * All the permissions that the user has for this account. These include any
   * implied permissions (e.g., EDIT implies VIEW).
   */
  core.List<core.String> effective;

  AccountPermissions();

  AccountPermissions.fromJson(core.Map _json) {
    if (_json.containsKey("effective")) {
      effective = _json["effective"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (effective != null) {
      _json["effective"] = effective;
    }
    return _json;
  }
}

/** JSON template for Analytics account entry. */
class Account {
  /**
   * Child link for an account entry. Points to the list of web properties for
   * this account.
   */
  AccountChildLink childLink;
  /** Time the account was created. */
  core.DateTime created;
  /** Account ID. */
  core.String id;
  /** Resource type for Analytics account. */
  core.String kind;
  /** Account name. */
  core.String name;
  /** Permissions the user has for this account. */
  AccountPermissions permissions;
  /** Link for this account. */
  core.String selfLink;
  /** Indicates whether this account is starred or not. */
  core.bool starred;
  /** Time the account was last modified. */
  core.DateTime updated;

  Account();

  Account.fromJson(core.Map _json) {
    if (_json.containsKey("childLink")) {
      childLink = new AccountChildLink.fromJson(_json["childLink"]);
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
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
    if (_json.containsKey("permissions")) {
      permissions = new AccountPermissions.fromJson(_json["permissions"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("starred")) {
      starred = _json["starred"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (childLink != null) {
      _json["childLink"] = (childLink).toJson();
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
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
    if (permissions != null) {
      _json["permissions"] = (permissions).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (starred != null) {
      _json["starred"] = starred;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

/** JSON template for a linked account. */
class AccountRef {
  /** Link for this account. */
  core.String href;
  /** Account ID. */
  core.String id;
  /** Analytics account reference. */
  core.String kind;
  /** Account name. */
  core.String name;

  AccountRef();

  AccountRef.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
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
    if (href != null) {
      _json["href"] = href;
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

/**
 * An AccountSummary collection lists a summary of accounts, properties and
 * views (profiles) to which the user has access. Each resource in the
 * collection corresponds to a single AccountSummary.
 */
class AccountSummaries {
  /** A list of AccountSummaries. */
  core.List<AccountSummary> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this AccountSummary collection. */
  core.String nextLink;
  /** Link to previous page for this AccountSummary collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  AccountSummaries();

  AccountSummaries.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new AccountSummary.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/**
 * JSON template for an Analytics AccountSummary. An AccountSummary is a
 * lightweight tree comprised of properties/profiles.
 */
class AccountSummary {
  /** Account ID. */
  core.String id;
  /** Resource type for Analytics AccountSummary. */
  core.String kind;
  /** Account name. */
  core.String name;
  /** Indicates whether this account is starred or not. */
  core.bool starred;
  /** List of web properties under this account. */
  core.List<WebPropertySummary> webProperties;

  AccountSummary();

  AccountSummary.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("starred")) {
      starred = _json["starred"];
    }
    if (_json.containsKey("webProperties")) {
      webProperties = _json["webProperties"].map((value) => new WebPropertySummary.fromJson(value)).toList();
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
    if (starred != null) {
      _json["starred"] = starred;
    }
    if (webProperties != null) {
      _json["webProperties"] = webProperties.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * JSON template for an Analytics account ticket. The account ticket consists of
 * the ticket ID and the basic information for the account, property and
 * profile.
 */
class AccountTicket {
  /** Account for this ticket. */
  Account account;
  /** Account ticket ID used to access the account ticket. */
  core.String id;
  /** Resource type for account ticket. */
  core.String kind;
  /** View (Profile) for the account. */
  Profile profile;
  /**
   * Redirect URI where the user will be sent after accepting Terms of Service.
   * Must be configured in APIs console as a callback URL.
   */
  core.String redirectUri;
  /** Web property for the account. */
  Webproperty webproperty;

  AccountTicket();

  AccountTicket.fromJson(core.Map _json) {
    if (_json.containsKey("account")) {
      account = new Account.fromJson(_json["account"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("profile")) {
      profile = new Profile.fromJson(_json["profile"]);
    }
    if (_json.containsKey("redirectUri")) {
      redirectUri = _json["redirectUri"];
    }
    if (_json.containsKey("webproperty")) {
      webproperty = new Webproperty.fromJson(_json["webproperty"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (account != null) {
      _json["account"] = (account).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (profile != null) {
      _json["profile"] = (profile).toJson();
    }
    if (redirectUri != null) {
      _json["redirectUri"] = redirectUri;
    }
    if (webproperty != null) {
      _json["webproperty"] = (webproperty).toJson();
    }
    return _json;
  }
}

/**
 * An account collection provides a list of Analytics accounts to which a user
 * has access. The account collection is the entry point to all management
 * information. Each resource in the collection corresponds to a single
 * Analytics account.
 */
class Accounts {
  /** A list of accounts. */
  core.List<Account> items;
  /**
   * The maximum number of entries the response can contain, regardless of the
   * actual number of entries returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Next link for this account collection. */
  core.String nextLink;
  /** Previous link for this account collection. */
  core.String previousLink;
  /**
   * The starting index of the entries, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  Accounts();

  Accounts.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Account.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/** JSON template for an AdWords account. */
class AdWordsAccount {
  /**
   * True if auto-tagging is enabled on the AdWords account. Read-only after the
   * insert operation.
   */
  core.bool autoTaggingEnabled;
  /** Customer ID. This field is required when creating an AdWords link. */
  core.String customerId;
  /** Resource type for AdWords account. */
  core.String kind;

  AdWordsAccount();

  AdWordsAccount.fromJson(core.Map _json) {
    if (_json.containsKey("autoTaggingEnabled")) {
      autoTaggingEnabled = _json["autoTaggingEnabled"];
    }
    if (_json.containsKey("customerId")) {
      customerId = _json["customerId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (autoTaggingEnabled != null) {
      _json["autoTaggingEnabled"] = autoTaggingEnabled;
    }
    if (customerId != null) {
      _json["customerId"] = customerId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Request template for the delete upload data request. */
class AnalyticsDataimportDeleteUploadDataRequest {
  /** A list of upload UIDs. */
  core.List<core.String> customDataImportUids;

  AnalyticsDataimportDeleteUploadDataRequest();

  AnalyticsDataimportDeleteUploadDataRequest.fromJson(core.Map _json) {
    if (_json.containsKey("customDataImportUids")) {
      customDataImportUids = _json["customDataImportUids"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (customDataImportUids != null) {
      _json["customDataImportUids"] = customDataImportUids;
    }
    return _json;
  }
}

/** JSON template for a metadata column. */
class Column {
  /** Map of attribute name and value for this column. */
  core.Map<core.String, core.String> attributes;
  /** Column id. */
  core.String id;
  /** Resource type for Analytics column. */
  core.String kind;

  Column();

  Column.fromJson(core.Map _json) {
    if (_json.containsKey("attributes")) {
      attributes = _json["attributes"];
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
    if (attributes != null) {
      _json["attributes"] = attributes;
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

/** Lists columns (dimensions and metrics) for a particular report type. */
class Columns {
  /** List of attributes names returned by columns. */
  core.List<core.String> attributeNames;
  /**
   * Etag of collection. This etag can be compared with the last response etag
   * to check if response has changed.
   */
  core.String etag;
  /** List of columns for a report type. */
  core.List<Column> items;
  /** Collection type. */
  core.String kind;
  /** Total number of columns returned in the response. */
  core.int totalResults;

  Columns();

  Columns.fromJson(core.Map _json) {
    if (_json.containsKey("attributeNames")) {
      attributeNames = _json["attributeNames"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Column.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (attributeNames != null) {
      _json["attributeNames"] = attributeNames;
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
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    return _json;
  }
}

class CustomDataSourceChildLink {
  /**
   * Link to the list of daily uploads for this custom data source. Link to the
   * list of uploads for this custom data source.
   */
  core.String href;
  /** Value is "analytics#dailyUploads". Value is "analytics#uploads". */
  core.String type;

  CustomDataSourceChildLink();

  CustomDataSourceChildLink.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (href != null) {
      _json["href"] = href;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * Parent link for this custom data source. Points to the web property to which
 * this custom data source belongs.
 */
class CustomDataSourceParentLink {
  /** Link to the web property to which this custom data source belongs. */
  core.String href;
  /** Value is "analytics#webproperty". */
  core.String type;

  CustomDataSourceParentLink();

  CustomDataSourceParentLink.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (href != null) {
      _json["href"] = href;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** JSON template for an Analytics custom data source. */
class CustomDataSource {
  /** Account ID to which this custom data source belongs. */
  core.String accountId;
  CustomDataSourceChildLink childLink;
  /** Time this custom data source was created. */
  core.DateTime created;
  /** Description of custom data source. */
  core.String description;
  /** Custom data source ID. */
  core.String id;
  core.String importBehavior;
  /** Resource type for Analytics custom data source. */
  core.String kind;
  /** Name of this custom data source. */
  core.String name;
  /**
   * Parent link for this custom data source. Points to the web property to
   * which this custom data source belongs.
   */
  CustomDataSourceParentLink parentLink;
  /** IDs of views (profiles) linked to the custom data source. */
  core.List<core.String> profilesLinked;
  /** Link for this Analytics custom data source. */
  core.String selfLink;
  /** Type of the custom data source. */
  core.String type;
  /** Time this custom data source was last modified. */
  core.DateTime updated;
  core.String uploadType;
  /**
   * Web property ID of the form UA-XXXXX-YY to which this custom data source
   * belongs.
   */
  core.String webPropertyId;

  CustomDataSource();

  CustomDataSource.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("childLink")) {
      childLink = new CustomDataSourceChildLink.fromJson(_json["childLink"]);
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("importBehavior")) {
      importBehavior = _json["importBehavior"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parentLink")) {
      parentLink = new CustomDataSourceParentLink.fromJson(_json["parentLink"]);
    }
    if (_json.containsKey("profilesLinked")) {
      profilesLinked = _json["profilesLinked"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("uploadType")) {
      uploadType = _json["uploadType"];
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (childLink != null) {
      _json["childLink"] = (childLink).toJson();
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (importBehavior != null) {
      _json["importBehavior"] = importBehavior;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parentLink != null) {
      _json["parentLink"] = (parentLink).toJson();
    }
    if (profilesLinked != null) {
      _json["profilesLinked"] = profilesLinked;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (uploadType != null) {
      _json["uploadType"] = uploadType;
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    return _json;
  }
}

/**
 * Lists Analytics custom data sources to which the user has access. Each
 * resource in the collection corresponds to a single Analytics custom data
 * source.
 */
class CustomDataSources {
  /** Collection of custom data sources. */
  core.List<CustomDataSource> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this custom data source collection. */
  core.String nextLink;
  /** Link to previous page for this custom data source collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  CustomDataSources();

  CustomDataSources.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new CustomDataSource.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/**
 * Parent link for the custom dimension. Points to the property to which the
 * custom dimension belongs.
 */
class CustomDimensionParentLink {
  /** Link to the property to which the custom dimension belongs. */
  core.String href;
  /** Type of the parent link. Set to "analytics#webproperty". */
  core.String type;

  CustomDimensionParentLink();

  CustomDimensionParentLink.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (href != null) {
      _json["href"] = href;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** JSON template for Analytics Custom Dimension. */
class CustomDimension {
  /** Account ID. */
  core.String accountId;
  /** Boolean indicating whether the custom dimension is active. */
  core.bool active;
  /** Time the custom dimension was created. */
  core.DateTime created;
  /** Custom dimension ID. */
  core.String id;
  /** Index of the custom dimension. */
  core.int index;
  /**
   * Kind value for a custom dimension. Set to "analytics#customDimension". It
   * is a read-only field.
   */
  core.String kind;
  /** Name of the custom dimension. */
  core.String name;
  /**
   * Parent link for the custom dimension. Points to the property to which the
   * custom dimension belongs.
   */
  CustomDimensionParentLink parentLink;
  /** Scope of the custom dimension: HIT, SESSION, USER or PRODUCT. */
  core.String scope;
  /** Link for the custom dimension */
  core.String selfLink;
  /** Time the custom dimension was last modified. */
  core.DateTime updated;
  /** Property ID. */
  core.String webPropertyId;

  CustomDimension();

  CustomDimension.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("index")) {
      index = _json["index"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parentLink")) {
      parentLink = new CustomDimensionParentLink.fromJson(_json["parentLink"]);
    }
    if (_json.containsKey("scope")) {
      scope = _json["scope"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (active != null) {
      _json["active"] = active;
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (index != null) {
      _json["index"] = index;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parentLink != null) {
      _json["parentLink"] = (parentLink).toJson();
    }
    if (scope != null) {
      _json["scope"] = scope;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    return _json;
  }
}

/**
 * A custom dimension collection lists Analytics custom dimensions to which the
 * user has access. Each resource in the collection corresponds to a single
 * Analytics custom dimension.
 */
class CustomDimensions {
  /** Collection of custom dimensions. */
  core.List<CustomDimension> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this custom dimension collection. */
  core.String nextLink;
  /** Link to previous page for this custom dimension collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  CustomDimensions();

  CustomDimensions.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new CustomDimension.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/**
 * Parent link for the custom metric. Points to the property to which the custom
 * metric belongs.
 */
class CustomMetricParentLink {
  /** Link to the property to which the custom metric belongs. */
  core.String href;
  /** Type of the parent link. Set to "analytics#webproperty". */
  core.String type;

  CustomMetricParentLink();

  CustomMetricParentLink.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (href != null) {
      _json["href"] = href;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** JSON template for Analytics Custom Metric. */
class CustomMetric {
  /** Account ID. */
  core.String accountId;
  /** Boolean indicating whether the custom metric is active. */
  core.bool active;
  /** Time the custom metric was created. */
  core.DateTime created;
  /** Custom metric ID. */
  core.String id;
  /** Index of the custom metric. */
  core.int index;
  /**
   * Kind value for a custom metric. Set to "analytics#customMetric". It is a
   * read-only field.
   */
  core.String kind;
  /** Max value of custom metric. */
  core.String maxValue;
  /** Min value of custom metric. */
  core.String minValue;
  /** Name of the custom metric. */
  core.String name;
  /**
   * Parent link for the custom metric. Points to the property to which the
   * custom metric belongs.
   */
  CustomMetricParentLink parentLink;
  /** Scope of the custom metric: HIT or PRODUCT. */
  core.String scope;
  /** Link for the custom metric */
  core.String selfLink;
  /** Data type of custom metric. */
  core.String type;
  /** Time the custom metric was last modified. */
  core.DateTime updated;
  /** Property ID. */
  core.String webPropertyId;

  CustomMetric();

  CustomMetric.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("index")) {
      index = _json["index"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("max_value")) {
      maxValue = _json["max_value"];
    }
    if (_json.containsKey("min_value")) {
      minValue = _json["min_value"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parentLink")) {
      parentLink = new CustomMetricParentLink.fromJson(_json["parentLink"]);
    }
    if (_json.containsKey("scope")) {
      scope = _json["scope"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (active != null) {
      _json["active"] = active;
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (index != null) {
      _json["index"] = index;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (maxValue != null) {
      _json["max_value"] = maxValue;
    }
    if (minValue != null) {
      _json["min_value"] = minValue;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parentLink != null) {
      _json["parentLink"] = (parentLink).toJson();
    }
    if (scope != null) {
      _json["scope"] = scope;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    return _json;
  }
}

/**
 * A custom metric collection lists Analytics custom metrics to which the user
 * has access. Each resource in the collection corresponds to a single Analytics
 * custom metric.
 */
class CustomMetrics {
  /** Collection of custom metrics. */
  core.List<CustomMetric> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this custom metric collection. */
  core.String nextLink;
  /** Link to previous page for this custom metric collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  CustomMetrics();

  CustomMetrics.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new CustomMetric.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/** Web property being linked. */
class EntityAdWordsLinkEntity {
  WebPropertyRef webPropertyRef;

  EntityAdWordsLinkEntity();

  EntityAdWordsLinkEntity.fromJson(core.Map _json) {
    if (_json.containsKey("webPropertyRef")) {
      webPropertyRef = new WebPropertyRef.fromJson(_json["webPropertyRef"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (webPropertyRef != null) {
      _json["webPropertyRef"] = (webPropertyRef).toJson();
    }
    return _json;
  }
}

/** JSON template for Analytics Entity AdWords Link. */
class EntityAdWordsLink {
  /**
   * A list of AdWords client accounts. These cannot be MCC accounts. This field
   * is required when creating an AdWords link. It cannot be empty.
   */
  core.List<AdWordsAccount> adWordsAccounts;
  /** Web property being linked. */
  EntityAdWordsLinkEntity entity;
  /** Entity AdWords link ID */
  core.String id;
  /** Resource type for entity AdWords link. */
  core.String kind;
  /**
   * Name of the link. This field is required when creating an AdWords link.
   */
  core.String name;
  /** IDs of linked Views (Profiles) represented as strings. */
  core.List<core.String> profileIds;
  /** URL link for this Google Analytics - Google AdWords link. */
  core.String selfLink;

  EntityAdWordsLink();

  EntityAdWordsLink.fromJson(core.Map _json) {
    if (_json.containsKey("adWordsAccounts")) {
      adWordsAccounts = _json["adWordsAccounts"].map((value) => new AdWordsAccount.fromJson(value)).toList();
    }
    if (_json.containsKey("entity")) {
      entity = new EntityAdWordsLinkEntity.fromJson(_json["entity"]);
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
    if (_json.containsKey("profileIds")) {
      profileIds = _json["profileIds"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adWordsAccounts != null) {
      _json["adWordsAccounts"] = adWordsAccounts.map((value) => (value).toJson()).toList();
    }
    if (entity != null) {
      _json["entity"] = (entity).toJson();
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
    if (profileIds != null) {
      _json["profileIds"] = profileIds;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/**
 * An entity AdWords link collection provides a list of GA-AdWords links Each
 * resource in this collection corresponds to a single link.
 */
class EntityAdWordsLinks {
  /** A list of entity AdWords links. */
  core.List<EntityAdWordsLink> items;
  /**
   * The maximum number of entries the response can contain, regardless of the
   * actual number of entries returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Next link for this AdWords link collection. */
  core.String nextLink;
  /** Previous link for this AdWords link collection. */
  core.String previousLink;
  /**
   * The starting index of the entries, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;

  EntityAdWordsLinks();

  EntityAdWordsLinks.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new EntityAdWordsLink.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    return _json;
  }
}

/**
 * Entity for this link. It can be an account, a web property, or a view
 * (profile).
 */
class EntityUserLinkEntity {
  /** Account for this link. */
  AccountRef accountRef;
  /** View (Profile) for this link. */
  ProfileRef profileRef;
  /** Web property for this link. */
  WebPropertyRef webPropertyRef;

  EntityUserLinkEntity();

  EntityUserLinkEntity.fromJson(core.Map _json) {
    if (_json.containsKey("accountRef")) {
      accountRef = new AccountRef.fromJson(_json["accountRef"]);
    }
    if (_json.containsKey("profileRef")) {
      profileRef = new ProfileRef.fromJson(_json["profileRef"]);
    }
    if (_json.containsKey("webPropertyRef")) {
      webPropertyRef = new WebPropertyRef.fromJson(_json["webPropertyRef"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountRef != null) {
      _json["accountRef"] = (accountRef).toJson();
    }
    if (profileRef != null) {
      _json["profileRef"] = (profileRef).toJson();
    }
    if (webPropertyRef != null) {
      _json["webPropertyRef"] = (webPropertyRef).toJson();
    }
    return _json;
  }
}

/** Permissions the user has for this entity. */
class EntityUserLinkPermissions {
  /**
   * Effective permissions represent all the permissions that a user has for
   * this entity. These include any implied permissions (e.g., EDIT implies
   * VIEW) or inherited permissions from the parent entity. Effective
   * permissions are read-only.
   */
  core.List<core.String> effective;
  /**
   * Permissions that a user has been assigned at this very level. Does not
   * include any implied or inherited permissions. Local permissions are
   * modifiable.
   */
  core.List<core.String> local;

  EntityUserLinkPermissions();

  EntityUserLinkPermissions.fromJson(core.Map _json) {
    if (_json.containsKey("effective")) {
      effective = _json["effective"];
    }
    if (_json.containsKey("local")) {
      local = _json["local"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (effective != null) {
      _json["effective"] = effective;
    }
    if (local != null) {
      _json["local"] = local;
    }
    return _json;
  }
}

/**
 * JSON template for an Analytics Entity-User Link. Returns permissions that a
 * user has for an entity.
 */
class EntityUserLink {
  /**
   * Entity for this link. It can be an account, a web property, or a view
   * (profile).
   */
  EntityUserLinkEntity entity;
  /** Entity user link ID */
  core.String id;
  /** Resource type for entity user link. */
  core.String kind;
  /** Permissions the user has for this entity. */
  EntityUserLinkPermissions permissions;
  /** Self link for this resource. */
  core.String selfLink;
  /** User reference. */
  UserRef userRef;

  EntityUserLink();

  EntityUserLink.fromJson(core.Map _json) {
    if (_json.containsKey("entity")) {
      entity = new EntityUserLinkEntity.fromJson(_json["entity"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("permissions")) {
      permissions = new EntityUserLinkPermissions.fromJson(_json["permissions"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("userRef")) {
      userRef = new UserRef.fromJson(_json["userRef"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entity != null) {
      _json["entity"] = (entity).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (permissions != null) {
      _json["permissions"] = (permissions).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (userRef != null) {
      _json["userRef"] = (userRef).toJson();
    }
    return _json;
  }
}

/**
 * An entity user link collection provides a list of Analytics ACL links Each
 * resource in this collection corresponds to a single link.
 */
class EntityUserLinks {
  /** A list of entity user links. */
  core.List<EntityUserLink> items;
  /**
   * The maximum number of entries the response can contain, regardless of the
   * actual number of entries returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Next link for this account collection. */
  core.String nextLink;
  /** Previous link for this account collection. */
  core.String previousLink;
  /**
   * The starting index of the entries, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;

  EntityUserLinks();

  EntityUserLinks.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new EntityUserLink.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    return _json;
  }
}

/**
 * Parent link for an experiment. Points to the view (profile) to which this
 * experiment belongs.
 */
class ExperimentParentLink {
  /**
   * Link to the view (profile) to which this experiment belongs. This field is
   * read-only.
   */
  core.String href;
  /** Value is "analytics#profile". This field is read-only. */
  core.String type;

  ExperimentParentLink();

  ExperimentParentLink.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (href != null) {
      _json["href"] = href;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class ExperimentVariations {
  /**
   * The name of the variation. This field is required when creating an
   * experiment. This field may not be changed for an experiment whose status is
   * ENDED.
   */
  core.String name;
  /**
   * Status of the variation. Possible values: "ACTIVE", "INACTIVE". INACTIVE
   * variations are not served. This field may not be changed for an experiment
   * whose status is ENDED.
   */
  core.String status;
  /**
   * The URL of the variation. This field may not be changed for an experiment
   * whose status is RUNNING or ENDED.
   */
  core.String url;
  /**
   * Weight that this variation should receive. Only present if the experiment
   * is running. This field is read-only.
   */
  core.double weight;
  /**
   * True if the experiment has ended and this variation performed
   * (statistically) significantly better than the original. This field is
   * read-only.
   */
  core.bool won;

  ExperimentVariations();

  ExperimentVariations.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("weight")) {
      weight = _json["weight"];
    }
    if (_json.containsKey("won")) {
      won = _json["won"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (weight != null) {
      _json["weight"] = weight;
    }
    if (won != null) {
      _json["won"] = won;
    }
    return _json;
  }
}

/** JSON template for Analytics experiment resource. */
class Experiment {
  /** Account ID to which this experiment belongs. This field is read-only. */
  core.String accountId;
  /** Time the experiment was created. This field is read-only. */
  core.DateTime created;
  /** Notes about this experiment. */
  core.String description;
  /**
   * If true, the end user will be able to edit the experiment via the Google
   * Analytics user interface.
   */
  core.bool editableInGaUi;
  /**
   * The ending time of the experiment (the time the status changed from RUNNING
   * to ENDED). This field is present only if the experiment has ended. This
   * field is read-only.
   */
  core.DateTime endTime;
  /**
   * Boolean specifying whether to distribute traffic evenly across all
   * variations. If the value is False, content experiments follows the default
   * behavior of adjusting traffic dynamically based on variation performance.
   * Optional -- defaults to False. This field may not be changed for an
   * experiment whose status is ENDED.
   */
  core.bool equalWeighting;
  /** Experiment ID. Required for patch and update. Disallowed for create. */
  core.String id;
  /**
   * Internal ID for the web property to which this experiment belongs. This
   * field is read-only.
   */
  core.String internalWebPropertyId;
  /** Resource type for an Analytics experiment. This field is read-only. */
  core.String kind;
  /**
   * An integer number in [3, 90]. Specifies the minimum length of the
   * experiment. Can be changed for a running experiment. This field may not be
   * changed for an experiments whose status is ENDED.
   */
  core.int minimumExperimentLengthInDays;
  /**
   * Experiment name. This field may not be changed for an experiment whose
   * status is ENDED. This field is required when creating an experiment.
   */
  core.String name;
  /**
   * The metric that the experiment is optimizing. Valid values:
   * "ga:goal(n)Completions", "ga:adsenseAdsClicks", "ga:adsenseAdsViewed",
   * "ga:adsenseRevenue", "ga:bounces", "ga:pageviews", "ga:sessionDuration",
   * "ga:transactions", "ga:transactionRevenue". This field is required if
   * status is "RUNNING" and servingFramework is one of "REDIRECT" or "API".
   */
  core.String objectiveMetric;
  /**
   * Whether the objectiveMetric should be minimized or maximized. Possible
   * values: "MAXIMUM", "MINIMUM". Optional--defaults to "MAXIMUM". Cannot be
   * specified without objectiveMetric. Cannot be modified when status is
   * "RUNNING" or "ENDED".
   */
  core.String optimizationType;
  /**
   * Parent link for an experiment. Points to the view (profile) to which this
   * experiment belongs.
   */
  ExperimentParentLink parentLink;
  /**
   * View (Profile) ID to which this experiment belongs. This field is
   * read-only.
   */
  core.String profileId;
  /**
   * Why the experiment ended. Possible values: "STOPPED_BY_USER",
   * "WINNER_FOUND", "EXPERIMENT_EXPIRED", "ENDED_WITH_NO_WINNER",
   * "GOAL_OBJECTIVE_CHANGED". "ENDED_WITH_NO_WINNER" means that the experiment
   * didn't expire but no winner was projected to be found. If the experiment
   * status is changed via the API to ENDED this field is set to
   * STOPPED_BY_USER. This field is read-only.
   */
  core.String reasonExperimentEnded;
  /**
   * Boolean specifying whether variations URLS are rewritten to match those of
   * the original. This field may not be changed for an experiments whose status
   * is ENDED.
   */
  core.bool rewriteVariationUrlsAsOriginal;
  /** Link for this experiment. This field is read-only. */
  core.String selfLink;
  /**
   * The framework used to serve the experiment variations and evaluate the
   * results. One of:
   * - REDIRECT: Google Analytics redirects traffic to different variation
   * pages, reports the chosen variation and evaluates the results.
   * - API: Google Analytics chooses and reports the variation to serve and
   * evaluates the results; the caller is responsible for serving the selected
   * variation.
   * - EXTERNAL: The variations will be served externally and the chosen
   * variation reported to Google Analytics. The caller is responsible for
   * serving the selected variation and evaluating the results.
   */
  core.String servingFramework;
  /**
   * The snippet of code to include on the control page(s). This field is
   * read-only.
   */
  core.String snippet;
  /**
   * The starting time of the experiment (the time the status changed from
   * READY_TO_RUN to RUNNING). This field is present only if the experiment has
   * started. This field is read-only.
   */
  core.DateTime startTime;
  /**
   * Experiment status. Possible values: "DRAFT", "READY_TO_RUN", "RUNNING",
   * "ENDED". Experiments can be created in the "DRAFT", "READY_TO_RUN" or
   * "RUNNING" state. This field is required when creating an experiment.
   */
  core.String status;
  /**
   * A floating-point number in (0, 1]. Specifies the fraction of the traffic
   * that participates in the experiment. Can be changed for a running
   * experiment. This field may not be changed for an experiments whose status
   * is ENDED.
   */
  core.double trafficCoverage;
  /** Time the experiment was last modified. This field is read-only. */
  core.DateTime updated;
  /**
   * Array of variations. The first variation in the array is the original. The
   * number of variations may not change once an experiment is in the RUNNING
   * state. At least two variations are required before status can be set to
   * RUNNING.
   */
  core.List<ExperimentVariations> variations;
  /**
   * Web property ID to which this experiment belongs. The web property ID is of
   * the form UA-XXXXX-YY. This field is read-only.
   */
  core.String webPropertyId;
  /**
   * A floating-point number in (0, 1). Specifies the necessary confidence level
   * to choose a winner. This field may not be changed for an experiments whose
   * status is ENDED.
   */
  core.double winnerConfidenceLevel;
  /**
   * Boolean specifying whether a winner has been found for this experiment.
   * This field is read-only.
   */
  core.bool winnerFound;

  Experiment();

  Experiment.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("editableInGaUi")) {
      editableInGaUi = _json["editableInGaUi"];
    }
    if (_json.containsKey("endTime")) {
      endTime = core.DateTime.parse(_json["endTime"]);
    }
    if (_json.containsKey("equalWeighting")) {
      equalWeighting = _json["equalWeighting"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("internalWebPropertyId")) {
      internalWebPropertyId = _json["internalWebPropertyId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("minimumExperimentLengthInDays")) {
      minimumExperimentLengthInDays = _json["minimumExperimentLengthInDays"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("objectiveMetric")) {
      objectiveMetric = _json["objectiveMetric"];
    }
    if (_json.containsKey("optimizationType")) {
      optimizationType = _json["optimizationType"];
    }
    if (_json.containsKey("parentLink")) {
      parentLink = new ExperimentParentLink.fromJson(_json["parentLink"]);
    }
    if (_json.containsKey("profileId")) {
      profileId = _json["profileId"];
    }
    if (_json.containsKey("reasonExperimentEnded")) {
      reasonExperimentEnded = _json["reasonExperimentEnded"];
    }
    if (_json.containsKey("rewriteVariationUrlsAsOriginal")) {
      rewriteVariationUrlsAsOriginal = _json["rewriteVariationUrlsAsOriginal"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("servingFramework")) {
      servingFramework = _json["servingFramework"];
    }
    if (_json.containsKey("snippet")) {
      snippet = _json["snippet"];
    }
    if (_json.containsKey("startTime")) {
      startTime = core.DateTime.parse(_json["startTime"]);
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("trafficCoverage")) {
      trafficCoverage = _json["trafficCoverage"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("variations")) {
      variations = _json["variations"].map((value) => new ExperimentVariations.fromJson(value)).toList();
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
    if (_json.containsKey("winnerConfidenceLevel")) {
      winnerConfidenceLevel = _json["winnerConfidenceLevel"];
    }
    if (_json.containsKey("winnerFound")) {
      winnerFound = _json["winnerFound"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (editableInGaUi != null) {
      _json["editableInGaUi"] = editableInGaUi;
    }
    if (endTime != null) {
      _json["endTime"] = (endTime).toIso8601String();
    }
    if (equalWeighting != null) {
      _json["equalWeighting"] = equalWeighting;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (internalWebPropertyId != null) {
      _json["internalWebPropertyId"] = internalWebPropertyId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (minimumExperimentLengthInDays != null) {
      _json["minimumExperimentLengthInDays"] = minimumExperimentLengthInDays;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (objectiveMetric != null) {
      _json["objectiveMetric"] = objectiveMetric;
    }
    if (optimizationType != null) {
      _json["optimizationType"] = optimizationType;
    }
    if (parentLink != null) {
      _json["parentLink"] = (parentLink).toJson();
    }
    if (profileId != null) {
      _json["profileId"] = profileId;
    }
    if (reasonExperimentEnded != null) {
      _json["reasonExperimentEnded"] = reasonExperimentEnded;
    }
    if (rewriteVariationUrlsAsOriginal != null) {
      _json["rewriteVariationUrlsAsOriginal"] = rewriteVariationUrlsAsOriginal;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (servingFramework != null) {
      _json["servingFramework"] = servingFramework;
    }
    if (snippet != null) {
      _json["snippet"] = snippet;
    }
    if (startTime != null) {
      _json["startTime"] = (startTime).toIso8601String();
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (trafficCoverage != null) {
      _json["trafficCoverage"] = trafficCoverage;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (variations != null) {
      _json["variations"] = variations.map((value) => (value).toJson()).toList();
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    if (winnerConfidenceLevel != null) {
      _json["winnerConfidenceLevel"] = winnerConfidenceLevel;
    }
    if (winnerFound != null) {
      _json["winnerFound"] = winnerFound;
    }
    return _json;
  }
}

/**
 * An experiment collection lists Analytics experiments to which the user has
 * access. Each view (profile) can have a set of experiments. Each resource in
 * the Experiment collection corresponds to a single Analytics experiment.
 */
class Experiments {
  /** A list of experiments. */
  core.List<Experiment> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this experiment collection. */
  core.String nextLink;
  /** Link to previous page for this experiment collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * resources in the result.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  Experiments();

  Experiments.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Experiment.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/** Details for the filter of the type ADVANCED. */
class FilterAdvancedDetails {
  /** Indicates if the filter expressions are case sensitive. */
  core.bool caseSensitive;
  /** Expression to extract from field A. */
  core.String extractA;
  /** Expression to extract from field B. */
  core.String extractB;
  /** Field A. */
  core.String fieldA;
  /**
   * The Index of the custom dimension. Required if field is a CUSTOM_DIMENSION.
   */
  core.int fieldAIndex;
  /** Indicates if field A is required to match. */
  core.bool fieldARequired;
  /** Field B. */
  core.String fieldB;
  /**
   * The Index of the custom dimension. Required if field is a CUSTOM_DIMENSION.
   */
  core.int fieldBIndex;
  /** Indicates if field B is required to match. */
  core.bool fieldBRequired;
  /** Expression used to construct the output value. */
  core.String outputConstructor;
  /** Output field. */
  core.String outputToField;
  /**
   * The Index of the custom dimension. Required if field is a CUSTOM_DIMENSION.
   */
  core.int outputToFieldIndex;
  /**
   * Indicates if the existing value of the output field, if any, should be
   * overridden by the output expression.
   */
  core.bool overrideOutputField;

  FilterAdvancedDetails();

  FilterAdvancedDetails.fromJson(core.Map _json) {
    if (_json.containsKey("caseSensitive")) {
      caseSensitive = _json["caseSensitive"];
    }
    if (_json.containsKey("extractA")) {
      extractA = _json["extractA"];
    }
    if (_json.containsKey("extractB")) {
      extractB = _json["extractB"];
    }
    if (_json.containsKey("fieldA")) {
      fieldA = _json["fieldA"];
    }
    if (_json.containsKey("fieldAIndex")) {
      fieldAIndex = _json["fieldAIndex"];
    }
    if (_json.containsKey("fieldARequired")) {
      fieldARequired = _json["fieldARequired"];
    }
    if (_json.containsKey("fieldB")) {
      fieldB = _json["fieldB"];
    }
    if (_json.containsKey("fieldBIndex")) {
      fieldBIndex = _json["fieldBIndex"];
    }
    if (_json.containsKey("fieldBRequired")) {
      fieldBRequired = _json["fieldBRequired"];
    }
    if (_json.containsKey("outputConstructor")) {
      outputConstructor = _json["outputConstructor"];
    }
    if (_json.containsKey("outputToField")) {
      outputToField = _json["outputToField"];
    }
    if (_json.containsKey("outputToFieldIndex")) {
      outputToFieldIndex = _json["outputToFieldIndex"];
    }
    if (_json.containsKey("overrideOutputField")) {
      overrideOutputField = _json["overrideOutputField"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (caseSensitive != null) {
      _json["caseSensitive"] = caseSensitive;
    }
    if (extractA != null) {
      _json["extractA"] = extractA;
    }
    if (extractB != null) {
      _json["extractB"] = extractB;
    }
    if (fieldA != null) {
      _json["fieldA"] = fieldA;
    }
    if (fieldAIndex != null) {
      _json["fieldAIndex"] = fieldAIndex;
    }
    if (fieldARequired != null) {
      _json["fieldARequired"] = fieldARequired;
    }
    if (fieldB != null) {
      _json["fieldB"] = fieldB;
    }
    if (fieldBIndex != null) {
      _json["fieldBIndex"] = fieldBIndex;
    }
    if (fieldBRequired != null) {
      _json["fieldBRequired"] = fieldBRequired;
    }
    if (outputConstructor != null) {
      _json["outputConstructor"] = outputConstructor;
    }
    if (outputToField != null) {
      _json["outputToField"] = outputToField;
    }
    if (outputToFieldIndex != null) {
      _json["outputToFieldIndex"] = outputToFieldIndex;
    }
    if (overrideOutputField != null) {
      _json["overrideOutputField"] = overrideOutputField;
    }
    return _json;
  }
}

/** Details for the filter of the type LOWER. */
class FilterLowercaseDetails {
  /** Field to use in the filter. */
  core.String field;
  /**
   * The Index of the custom dimension. Required if field is a CUSTOM_DIMENSION.
   */
  core.int fieldIndex;

  FilterLowercaseDetails();

  FilterLowercaseDetails.fromJson(core.Map _json) {
    if (_json.containsKey("field")) {
      field = _json["field"];
    }
    if (_json.containsKey("fieldIndex")) {
      fieldIndex = _json["fieldIndex"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (field != null) {
      _json["field"] = field;
    }
    if (fieldIndex != null) {
      _json["fieldIndex"] = fieldIndex;
    }
    return _json;
  }
}

/**
 * Parent link for this filter. Points to the account to which this filter
 * belongs.
 */
class FilterParentLink {
  /** Link to the account to which this filter belongs. */
  core.String href;
  /** Value is "analytics#account". */
  core.String type;

  FilterParentLink();

  FilterParentLink.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (href != null) {
      _json["href"] = href;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Details for the filter of the type SEARCH_AND_REPLACE. */
class FilterSearchAndReplaceDetails {
  /** Determines if the filter is case sensitive. */
  core.bool caseSensitive;
  /** Field to use in the filter. */
  core.String field;
  /**
   * The Index of the custom dimension. Required if field is a CUSTOM_DIMENSION.
   */
  core.int fieldIndex;
  /** Term to replace the search term with. */
  core.String replaceString;
  /** Term to search. */
  core.String searchString;

  FilterSearchAndReplaceDetails();

  FilterSearchAndReplaceDetails.fromJson(core.Map _json) {
    if (_json.containsKey("caseSensitive")) {
      caseSensitive = _json["caseSensitive"];
    }
    if (_json.containsKey("field")) {
      field = _json["field"];
    }
    if (_json.containsKey("fieldIndex")) {
      fieldIndex = _json["fieldIndex"];
    }
    if (_json.containsKey("replaceString")) {
      replaceString = _json["replaceString"];
    }
    if (_json.containsKey("searchString")) {
      searchString = _json["searchString"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (caseSensitive != null) {
      _json["caseSensitive"] = caseSensitive;
    }
    if (field != null) {
      _json["field"] = field;
    }
    if (fieldIndex != null) {
      _json["fieldIndex"] = fieldIndex;
    }
    if (replaceString != null) {
      _json["replaceString"] = replaceString;
    }
    if (searchString != null) {
      _json["searchString"] = searchString;
    }
    return _json;
  }
}

/** Details for the filter of the type UPPER. */
class FilterUppercaseDetails {
  /** Field to use in the filter. */
  core.String field;
  /**
   * The Index of the custom dimension. Required if field is a CUSTOM_DIMENSION.
   */
  core.int fieldIndex;

  FilterUppercaseDetails();

  FilterUppercaseDetails.fromJson(core.Map _json) {
    if (_json.containsKey("field")) {
      field = _json["field"];
    }
    if (_json.containsKey("fieldIndex")) {
      fieldIndex = _json["fieldIndex"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (field != null) {
      _json["field"] = field;
    }
    if (fieldIndex != null) {
      _json["fieldIndex"] = fieldIndex;
    }
    return _json;
  }
}

/** JSON template for an Analytics account filter. */
class Filter {
  /** Account ID to which this filter belongs. */
  core.String accountId;
  /** Details for the filter of the type ADVANCED. */
  FilterAdvancedDetails advancedDetails;
  /** Time this filter was created. */
  core.DateTime created;
  /** Details for the filter of the type EXCLUDE. */
  FilterExpression excludeDetails;
  /** Filter ID. */
  core.String id;
  /** Details for the filter of the type INCLUDE. */
  FilterExpression includeDetails;
  /** Resource type for Analytics filter. */
  core.String kind;
  /** Details for the filter of the type LOWER. */
  FilterLowercaseDetails lowercaseDetails;
  /** Name of this filter. */
  core.String name;
  /**
   * Parent link for this filter. Points to the account to which this filter
   * belongs.
   */
  FilterParentLink parentLink;
  /** Details for the filter of the type SEARCH_AND_REPLACE. */
  FilterSearchAndReplaceDetails searchAndReplaceDetails;
  /** Link for this filter. */
  core.String selfLink;
  /**
   * Type of this filter. Possible values are INCLUDE, EXCLUDE, LOWERCASE,
   * UPPERCASE, SEARCH_AND_REPLACE and ADVANCED.
   */
  core.String type;
  /** Time this filter was last modified. */
  core.DateTime updated;
  /** Details for the filter of the type UPPER. */
  FilterUppercaseDetails uppercaseDetails;

  Filter();

  Filter.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advancedDetails")) {
      advancedDetails = new FilterAdvancedDetails.fromJson(_json["advancedDetails"]);
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("excludeDetails")) {
      excludeDetails = new FilterExpression.fromJson(_json["excludeDetails"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("includeDetails")) {
      includeDetails = new FilterExpression.fromJson(_json["includeDetails"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lowercaseDetails")) {
      lowercaseDetails = new FilterLowercaseDetails.fromJson(_json["lowercaseDetails"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parentLink")) {
      parentLink = new FilterParentLink.fromJson(_json["parentLink"]);
    }
    if (_json.containsKey("searchAndReplaceDetails")) {
      searchAndReplaceDetails = new FilterSearchAndReplaceDetails.fromJson(_json["searchAndReplaceDetails"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("uppercaseDetails")) {
      uppercaseDetails = new FilterUppercaseDetails.fromJson(_json["uppercaseDetails"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advancedDetails != null) {
      _json["advancedDetails"] = (advancedDetails).toJson();
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (excludeDetails != null) {
      _json["excludeDetails"] = (excludeDetails).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (includeDetails != null) {
      _json["includeDetails"] = (includeDetails).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lowercaseDetails != null) {
      _json["lowercaseDetails"] = (lowercaseDetails).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parentLink != null) {
      _json["parentLink"] = (parentLink).toJson();
    }
    if (searchAndReplaceDetails != null) {
      _json["searchAndReplaceDetails"] = (searchAndReplaceDetails).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (uppercaseDetails != null) {
      _json["uppercaseDetails"] = (uppercaseDetails).toJson();
    }
    return _json;
  }
}

/** JSON template for an Analytics filter expression. */
class FilterExpression {
  /** Determines if the filter is case sensitive. */
  core.bool caseSensitive;
  /** Filter expression value */
  core.String expressionValue;
  /**
   * Field to filter. Possible values:
   * - Content and Traffic
   * - PAGE_REQUEST_URI,
   * - PAGE_HOSTNAME,
   * - PAGE_TITLE,
   * - REFERRAL,
   * - COST_DATA_URI (Campaign target URL),
   * - HIT_TYPE,
   * - INTERNAL_SEARCH_TERM,
   * - INTERNAL_SEARCH_TYPE,
   * - SOURCE_PROPERTY_TRACKING_ID,
   * - Campaign or AdGroup
   * - CAMPAIGN_SOURCE,
   * - CAMPAIGN_MEDIUM,
   * - CAMPAIGN_NAME,
   * - CAMPAIGN_AD_GROUP,
   * - CAMPAIGN_TERM,
   * - CAMPAIGN_CONTENT,
   * - CAMPAIGN_CODE,
   * - CAMPAIGN_REFERRAL_PATH,
   * - E-Commerce
   * - TRANSACTION_COUNTRY,
   * - TRANSACTION_REGION,
   * - TRANSACTION_CITY,
   * - TRANSACTION_AFFILIATION (Store or order location),
   * - ITEM_NAME,
   * - ITEM_CODE,
   * - ITEM_VARIATION,
   * - TRANSACTION_ID,
   * - TRANSACTION_CURRENCY_CODE,
   * - PRODUCT_ACTION_TYPE,
   * - Audience/Users
   * - BROWSER,
   * - BROWSER_VERSION,
   * - BROWSER_SIZE,
   * - PLATFORM,
   * - PLATFORM_VERSION,
   * - LANGUAGE,
   * - SCREEN_RESOLUTION,
   * - SCREEN_COLORS,
   * - JAVA_ENABLED (Boolean Field),
   * - FLASH_VERSION,
   * - GEO_SPEED (Connection speed),
   * - VISITOR_TYPE,
   * - GEO_ORGANIZATION (ISP organization),
   * - GEO_DOMAIN,
   * - GEO_IP_ADDRESS,
   * - GEO_IP_VERSION,
   * - Location
   * - GEO_COUNTRY,
   * - GEO_REGION,
   * - GEO_CITY,
   * - Event
   * - EVENT_CATEGORY,
   * - EVENT_ACTION,
   * - EVENT_LABEL,
   * - Other
   * - CUSTOM_FIELD_1,
   * - CUSTOM_FIELD_2,
   * - USER_DEFINED_VALUE,
   * - Application
   * - APP_ID,
   * - APP_INSTALLER_ID,
   * - APP_NAME,
   * - APP_VERSION,
   * - SCREEN,
   * - IS_APP (Boolean Field),
   * - IS_FATAL_EXCEPTION (Boolean Field),
   * - EXCEPTION_DESCRIPTION,
   * - Mobile device
   * - IS_MOBILE (Boolean Field, Deprecated. Use DEVICE_CATEGORY=mobile),
   * - IS_TABLET (Boolean Field, Deprecated. Use DEVICE_CATEGORY=tablet),
   * - DEVICE_CATEGORY,
   * - MOBILE_HAS_QWERTY_KEYBOARD (Boolean Field),
   * - MOBILE_HAS_NFC_SUPPORT (Boolean Field),
   * - MOBILE_HAS_CELLULAR_RADIO (Boolean Field),
   * - MOBILE_HAS_WIFI_SUPPORT (Boolean Field),
   * - MOBILE_BRAND_NAME,
   * - MOBILE_MODEL_NAME,
   * - MOBILE_MARKETING_NAME,
   * - MOBILE_POINTING_METHOD,
   * - Social
   * - SOCIAL_NETWORK,
   * - SOCIAL_ACTION,
   * - SOCIAL_ACTION_TARGET,
   * - Custom dimension
   * - CUSTOM_DIMENSION (See accompanying field index),
   */
  core.String field;
  /**
   * The Index of the custom dimension. Set only if the field is a is
   * CUSTOM_DIMENSION.
   */
  core.int fieldIndex;
  /** Kind value for filter expression */
  core.String kind;
  /**
   * Match type for this filter. Possible values are BEGINS_WITH, EQUAL,
   * ENDS_WITH, CONTAINS, or MATCHES. GEO_DOMAIN, GEO_IP_ADDRESS,
   * PAGE_REQUEST_URI, or PAGE_HOSTNAME filters can use any match type; all
   * other filters must use MATCHES.
   */
  core.String matchType;

  FilterExpression();

  FilterExpression.fromJson(core.Map _json) {
    if (_json.containsKey("caseSensitive")) {
      caseSensitive = _json["caseSensitive"];
    }
    if (_json.containsKey("expressionValue")) {
      expressionValue = _json["expressionValue"];
    }
    if (_json.containsKey("field")) {
      field = _json["field"];
    }
    if (_json.containsKey("fieldIndex")) {
      fieldIndex = _json["fieldIndex"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("matchType")) {
      matchType = _json["matchType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (caseSensitive != null) {
      _json["caseSensitive"] = caseSensitive;
    }
    if (expressionValue != null) {
      _json["expressionValue"] = expressionValue;
    }
    if (field != null) {
      _json["field"] = field;
    }
    if (fieldIndex != null) {
      _json["fieldIndex"] = fieldIndex;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (matchType != null) {
      _json["matchType"] = matchType;
    }
    return _json;
  }
}

/** JSON template for a profile filter link. */
class FilterRef {
  /** Account ID to which this filter belongs. */
  core.String accountId;
  /** Link for this filter. */
  core.String href;
  /** Filter ID. */
  core.String id;
  /** Kind value for filter reference. */
  core.String kind;
  /** Name of this filter. */
  core.String name;

  FilterRef();

  FilterRef.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("href")) {
      href = _json["href"];
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
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (href != null) {
      _json["href"] = href;
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

/**
 * A filter collection lists filters created by users in an Analytics account.
 * Each resource in the collection corresponds to a filter.
 */
class Filters {
  /** A list of filters. */
  core.List<Filter> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1,000 with
   * a value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this filter collection. */
  core.String nextLink;
  /** Link to previous page for this filter collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  Filters();

  Filters.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Filter.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

class GaDataColumnHeaders {
  /** Column Type. Either DIMENSION or METRIC. */
  core.String columnType;
  /**
   * Data type. Dimension column headers have only STRING as the data type.
   * Metric column headers have data types for metric values such as INTEGER,
   * DOUBLE, CURRENCY etc.
   */
  core.String dataType;
  /** Column name. */
  core.String name;

  GaDataColumnHeaders();

  GaDataColumnHeaders.fromJson(core.Map _json) {
    if (_json.containsKey("columnType")) {
      columnType = _json["columnType"];
    }
    if (_json.containsKey("dataType")) {
      dataType = _json["dataType"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnType != null) {
      _json["columnType"] = columnType;
    }
    if (dataType != null) {
      _json["dataType"] = dataType;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

class GaDataDataTableCols {
  core.String id;
  core.String label;
  core.String type;

  GaDataDataTableCols();

  GaDataDataTableCols.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("label")) {
      label = _json["label"];
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
    if (label != null) {
      _json["label"] = label;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class GaDataDataTableRowsC {
  core.String v;

  GaDataDataTableRowsC();

  GaDataDataTableRowsC.fromJson(core.Map _json) {
    if (_json.containsKey("v")) {
      v = _json["v"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (v != null) {
      _json["v"] = v;
    }
    return _json;
  }
}

class GaDataDataTableRows {
  core.List<GaDataDataTableRowsC> c;

  GaDataDataTableRows();

  GaDataDataTableRows.fromJson(core.Map _json) {
    if (_json.containsKey("c")) {
      c = _json["c"].map((value) => new GaDataDataTableRowsC.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (c != null) {
      _json["c"] = c.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class GaDataDataTable {
  core.List<GaDataDataTableCols> cols;
  core.List<GaDataDataTableRows> rows;

  GaDataDataTable();

  GaDataDataTable.fromJson(core.Map _json) {
    if (_json.containsKey("cols")) {
      cols = _json["cols"].map((value) => new GaDataDataTableCols.fromJson(value)).toList();
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"].map((value) => new GaDataDataTableRows.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cols != null) {
      _json["cols"] = cols.map((value) => (value).toJson()).toList();
    }
    if (rows != null) {
      _json["rows"] = rows.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Information for the view (profile), for which the Analytics data was
 * requested.
 */
class GaDataProfileInfo {
  /** Account ID to which this view (profile) belongs. */
  core.String accountId;
  /** Internal ID for the web property to which this view (profile) belongs. */
  core.String internalWebPropertyId;
  /** View (Profile) ID. */
  core.String profileId;
  /** View (Profile) name. */
  core.String profileName;
  /** Table ID for view (profile). */
  core.String tableId;
  /** Web Property ID to which this view (profile) belongs. */
  core.String webPropertyId;

  GaDataProfileInfo();

  GaDataProfileInfo.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("internalWebPropertyId")) {
      internalWebPropertyId = _json["internalWebPropertyId"];
    }
    if (_json.containsKey("profileId")) {
      profileId = _json["profileId"];
    }
    if (_json.containsKey("profileName")) {
      profileName = _json["profileName"];
    }
    if (_json.containsKey("tableId")) {
      tableId = _json["tableId"];
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (internalWebPropertyId != null) {
      _json["internalWebPropertyId"] = internalWebPropertyId;
    }
    if (profileId != null) {
      _json["profileId"] = profileId;
    }
    if (profileName != null) {
      _json["profileName"] = profileName;
    }
    if (tableId != null) {
      _json["tableId"] = tableId;
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    return _json;
  }
}

/** Analytics data request query parameters. */
class GaDataQuery {
  /** List of analytics dimensions. */
  core.String dimensions;
  /** End date. */
  core.String end_date;
  /** Comma-separated list of dimension or metric filters. */
  core.String filters;
  /** Unique table ID. */
  core.String ids;
  /** Maximum results per page. */
  core.int max_results;
  /** List of analytics metrics. */
  core.List<core.String> metrics;
  /** Desired sampling level */
  core.String samplingLevel;
  /** Analytics advanced segment. */
  core.String segment;
  /** List of dimensions or metrics based on which Analytics data is sorted. */
  core.List<core.String> sort;
  /** Start date. */
  core.String start_date;
  /** Start index. */
  core.int start_index;

  GaDataQuery();

  GaDataQuery.fromJson(core.Map _json) {
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"];
    }
    if (_json.containsKey("end-date")) {
      end_date = _json["end-date"];
    }
    if (_json.containsKey("filters")) {
      filters = _json["filters"];
    }
    if (_json.containsKey("ids")) {
      ids = _json["ids"];
    }
    if (_json.containsKey("max-results")) {
      max_results = _json["max-results"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"];
    }
    if (_json.containsKey("samplingLevel")) {
      samplingLevel = _json["samplingLevel"];
    }
    if (_json.containsKey("segment")) {
      segment = _json["segment"];
    }
    if (_json.containsKey("sort")) {
      sort = _json["sort"];
    }
    if (_json.containsKey("start-date")) {
      start_date = _json["start-date"];
    }
    if (_json.containsKey("start-index")) {
      start_index = _json["start-index"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensions != null) {
      _json["dimensions"] = dimensions;
    }
    if (end_date != null) {
      _json["end-date"] = end_date;
    }
    if (filters != null) {
      _json["filters"] = filters;
    }
    if (ids != null) {
      _json["ids"] = ids;
    }
    if (max_results != null) {
      _json["max-results"] = max_results;
    }
    if (metrics != null) {
      _json["metrics"] = metrics;
    }
    if (samplingLevel != null) {
      _json["samplingLevel"] = samplingLevel;
    }
    if (segment != null) {
      _json["segment"] = segment;
    }
    if (sort != null) {
      _json["sort"] = sort;
    }
    if (start_date != null) {
      _json["start-date"] = start_date;
    }
    if (start_index != null) {
      _json["start-index"] = start_index;
    }
    return _json;
  }
}

/** Analytics data for a given view (profile). */
class GaData {
  /**
   * Column headers that list dimension names followed by the metric names. The
   * order of dimensions and metrics is same as specified in the request.
   */
  core.List<GaDataColumnHeaders> columnHeaders;
  /** Determines if Analytics data contains samples. */
  core.bool containsSampledData;
  /** The last refreshed time in seconds for Analytics data. */
  core.String dataLastRefreshed;
  GaDataDataTable dataTable;
  /** Unique ID for this data response. */
  core.String id;
  /**
   * The maximum number of rows the response can contain, regardless of the
   * actual number of rows returned. Its value ranges from 1 to 10,000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Resource type. */
  core.String kind;
  /** Link to next page for this Analytics data query. */
  core.String nextLink;
  /** Link to previous page for this Analytics data query. */
  core.String previousLink;
  /**
   * Information for the view (profile), for which the Analytics data was
   * requested.
   */
  GaDataProfileInfo profileInfo;
  /** Analytics data request query parameters. */
  GaDataQuery query;
  /**
   * Analytics data rows, where each row contains a list of dimension values
   * followed by the metric values. The order of dimensions and metrics is same
   * as specified in the request.
   */
  core.List<core.List<core.String>> rows;
  /** The number of samples used to calculate the result. */
  core.String sampleSize;
  /** Total size of the sample space from which the samples were selected. */
  core.String sampleSpace;
  /** Link to this page. */
  core.String selfLink;
  /**
   * The total number of rows for the query, regardless of the number of rows in
   * the response.
   */
  core.int totalResults;
  /**
   * Total values for the requested metrics over all the results, not just the
   * results returned in this response. The order of the metric totals is same
   * as the metric order specified in the request.
   */
  core.Map<core.String, core.String> totalsForAllResults;

  GaData();

  GaData.fromJson(core.Map _json) {
    if (_json.containsKey("columnHeaders")) {
      columnHeaders = _json["columnHeaders"].map((value) => new GaDataColumnHeaders.fromJson(value)).toList();
    }
    if (_json.containsKey("containsSampledData")) {
      containsSampledData = _json["containsSampledData"];
    }
    if (_json.containsKey("dataLastRefreshed")) {
      dataLastRefreshed = _json["dataLastRefreshed"];
    }
    if (_json.containsKey("dataTable")) {
      dataTable = new GaDataDataTable.fromJson(_json["dataTable"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("profileInfo")) {
      profileInfo = new GaDataProfileInfo.fromJson(_json["profileInfo"]);
    }
    if (_json.containsKey("query")) {
      query = new GaDataQuery.fromJson(_json["query"]);
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"];
    }
    if (_json.containsKey("sampleSize")) {
      sampleSize = _json["sampleSize"];
    }
    if (_json.containsKey("sampleSpace")) {
      sampleSpace = _json["sampleSpace"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("totalsForAllResults")) {
      totalsForAllResults = _json["totalsForAllResults"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnHeaders != null) {
      _json["columnHeaders"] = columnHeaders.map((value) => (value).toJson()).toList();
    }
    if (containsSampledData != null) {
      _json["containsSampledData"] = containsSampledData;
    }
    if (dataLastRefreshed != null) {
      _json["dataLastRefreshed"] = dataLastRefreshed;
    }
    if (dataTable != null) {
      _json["dataTable"] = (dataTable).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (profileInfo != null) {
      _json["profileInfo"] = (profileInfo).toJson();
    }
    if (query != null) {
      _json["query"] = (query).toJson();
    }
    if (rows != null) {
      _json["rows"] = rows;
    }
    if (sampleSize != null) {
      _json["sampleSize"] = sampleSize;
    }
    if (sampleSpace != null) {
      _json["sampleSpace"] = sampleSpace;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (totalsForAllResults != null) {
      _json["totalsForAllResults"] = totalsForAllResults;
    }
    return _json;
  }
}

class GoalEventDetailsEventConditions {
  /**
   * Type of comparison. Possible values are LESS_THAN, GREATER_THAN or EQUAL.
   */
  core.String comparisonType;
  /** Value used for this comparison. */
  core.String comparisonValue;
  /** Expression used for this match. */
  core.String expression;
  /**
   * Type of the match to be performed. Possible values are REGEXP, BEGINS_WITH,
   * or EXACT.
   */
  core.String matchType;
  /**
   * Type of this event condition. Possible values are CATEGORY, ACTION, LABEL,
   * or VALUE.
   */
  core.String type;

  GoalEventDetailsEventConditions();

  GoalEventDetailsEventConditions.fromJson(core.Map _json) {
    if (_json.containsKey("comparisonType")) {
      comparisonType = _json["comparisonType"];
    }
    if (_json.containsKey("comparisonValue")) {
      comparisonValue = _json["comparisonValue"];
    }
    if (_json.containsKey("expression")) {
      expression = _json["expression"];
    }
    if (_json.containsKey("matchType")) {
      matchType = _json["matchType"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (comparisonType != null) {
      _json["comparisonType"] = comparisonType;
    }
    if (comparisonValue != null) {
      _json["comparisonValue"] = comparisonValue;
    }
    if (expression != null) {
      _json["expression"] = expression;
    }
    if (matchType != null) {
      _json["matchType"] = matchType;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Details for the goal of the type EVENT. */
class GoalEventDetails {
  /** List of event conditions. */
  core.List<GoalEventDetailsEventConditions> eventConditions;
  /**
   * Determines if the event value should be used as the value for this goal.
   */
  core.bool useEventValue;

  GoalEventDetails();

  GoalEventDetails.fromJson(core.Map _json) {
    if (_json.containsKey("eventConditions")) {
      eventConditions = _json["eventConditions"].map((value) => new GoalEventDetailsEventConditions.fromJson(value)).toList();
    }
    if (_json.containsKey("useEventValue")) {
      useEventValue = _json["useEventValue"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (eventConditions != null) {
      _json["eventConditions"] = eventConditions.map((value) => (value).toJson()).toList();
    }
    if (useEventValue != null) {
      _json["useEventValue"] = useEventValue;
    }
    return _json;
  }
}

/**
 * Parent link for a goal. Points to the view (profile) to which this goal
 * belongs.
 */
class GoalParentLink {
  /** Link to the view (profile) to which this goal belongs. */
  core.String href;
  /** Value is "analytics#profile". */
  core.String type;

  GoalParentLink();

  GoalParentLink.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (href != null) {
      _json["href"] = href;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class GoalUrlDestinationDetailsSteps {
  /** Step name. */
  core.String name;
  /** Step number. */
  core.int number;
  /** URL for this step. */
  core.String url;

  GoalUrlDestinationDetailsSteps();

  GoalUrlDestinationDetailsSteps.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("number")) {
      number = _json["number"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (number != null) {
      _json["number"] = number;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Details for the goal of the type URL_DESTINATION. */
class GoalUrlDestinationDetails {
  /**
   * Determines if the goal URL must exactly match the capitalization of visited
   * URLs.
   */
  core.bool caseSensitive;
  /** Determines if the first step in this goal is required. */
  core.bool firstStepRequired;
  /**
   * Match type for the goal URL. Possible values are HEAD, EXACT, or REGEX.
   */
  core.String matchType;
  /** List of steps configured for this goal funnel. */
  core.List<GoalUrlDestinationDetailsSteps> steps;
  /** URL for this goal. */
  core.String url;

  GoalUrlDestinationDetails();

  GoalUrlDestinationDetails.fromJson(core.Map _json) {
    if (_json.containsKey("caseSensitive")) {
      caseSensitive = _json["caseSensitive"];
    }
    if (_json.containsKey("firstStepRequired")) {
      firstStepRequired = _json["firstStepRequired"];
    }
    if (_json.containsKey("matchType")) {
      matchType = _json["matchType"];
    }
    if (_json.containsKey("steps")) {
      steps = _json["steps"].map((value) => new GoalUrlDestinationDetailsSteps.fromJson(value)).toList();
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (caseSensitive != null) {
      _json["caseSensitive"] = caseSensitive;
    }
    if (firstStepRequired != null) {
      _json["firstStepRequired"] = firstStepRequired;
    }
    if (matchType != null) {
      _json["matchType"] = matchType;
    }
    if (steps != null) {
      _json["steps"] = steps.map((value) => (value).toJson()).toList();
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Details for the goal of the type VISIT_NUM_PAGES. */
class GoalVisitNumPagesDetails {
  /**
   * Type of comparison. Possible values are LESS_THAN, GREATER_THAN, or EQUAL.
   */
  core.String comparisonType;
  /** Value used for this comparison. */
  core.String comparisonValue;

  GoalVisitNumPagesDetails();

  GoalVisitNumPagesDetails.fromJson(core.Map _json) {
    if (_json.containsKey("comparisonType")) {
      comparisonType = _json["comparisonType"];
    }
    if (_json.containsKey("comparisonValue")) {
      comparisonValue = _json["comparisonValue"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (comparisonType != null) {
      _json["comparisonType"] = comparisonType;
    }
    if (comparisonValue != null) {
      _json["comparisonValue"] = comparisonValue;
    }
    return _json;
  }
}

/** Details for the goal of the type VISIT_TIME_ON_SITE. */
class GoalVisitTimeOnSiteDetails {
  /** Type of comparison. Possible values are LESS_THAN or GREATER_THAN. */
  core.String comparisonType;
  /** Value used for this comparison. */
  core.String comparisonValue;

  GoalVisitTimeOnSiteDetails();

  GoalVisitTimeOnSiteDetails.fromJson(core.Map _json) {
    if (_json.containsKey("comparisonType")) {
      comparisonType = _json["comparisonType"];
    }
    if (_json.containsKey("comparisonValue")) {
      comparisonValue = _json["comparisonValue"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (comparisonType != null) {
      _json["comparisonType"] = comparisonType;
    }
    if (comparisonValue != null) {
      _json["comparisonValue"] = comparisonValue;
    }
    return _json;
  }
}

/** JSON template for Analytics goal resource. */
class Goal {
  /** Account ID to which this goal belongs. */
  core.String accountId;
  /** Determines whether this goal is active. */
  core.bool active;
  /** Time this goal was created. */
  core.DateTime created;
  /** Details for the goal of the type EVENT. */
  GoalEventDetails eventDetails;
  /** Goal ID. */
  core.String id;
  /** Internal ID for the web property to which this goal belongs. */
  core.String internalWebPropertyId;
  /** Resource type for an Analytics goal. */
  core.String kind;
  /** Goal name. */
  core.String name;
  /**
   * Parent link for a goal. Points to the view (profile) to which this goal
   * belongs.
   */
  GoalParentLink parentLink;
  /** View (Profile) ID to which this goal belongs. */
  core.String profileId;
  /** Link for this goal. */
  core.String selfLink;
  /**
   * Goal type. Possible values are URL_DESTINATION, VISIT_TIME_ON_SITE,
   * VISIT_NUM_PAGES, AND EVENT.
   */
  core.String type;
  /** Time this goal was last modified. */
  core.DateTime updated;
  /** Details for the goal of the type URL_DESTINATION. */
  GoalUrlDestinationDetails urlDestinationDetails;
  /** Goal value. */
  core.double value;
  /** Details for the goal of the type VISIT_NUM_PAGES. */
  GoalVisitNumPagesDetails visitNumPagesDetails;
  /** Details for the goal of the type VISIT_TIME_ON_SITE. */
  GoalVisitTimeOnSiteDetails visitTimeOnSiteDetails;
  /**
   * Web property ID to which this goal belongs. The web property ID is of the
   * form UA-XXXXX-YY.
   */
  core.String webPropertyId;

  Goal();

  Goal.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("eventDetails")) {
      eventDetails = new GoalEventDetails.fromJson(_json["eventDetails"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("internalWebPropertyId")) {
      internalWebPropertyId = _json["internalWebPropertyId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parentLink")) {
      parentLink = new GoalParentLink.fromJson(_json["parentLink"]);
    }
    if (_json.containsKey("profileId")) {
      profileId = _json["profileId"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("urlDestinationDetails")) {
      urlDestinationDetails = new GoalUrlDestinationDetails.fromJson(_json["urlDestinationDetails"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
    if (_json.containsKey("visitNumPagesDetails")) {
      visitNumPagesDetails = new GoalVisitNumPagesDetails.fromJson(_json["visitNumPagesDetails"]);
    }
    if (_json.containsKey("visitTimeOnSiteDetails")) {
      visitTimeOnSiteDetails = new GoalVisitTimeOnSiteDetails.fromJson(_json["visitTimeOnSiteDetails"]);
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (active != null) {
      _json["active"] = active;
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (eventDetails != null) {
      _json["eventDetails"] = (eventDetails).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (internalWebPropertyId != null) {
      _json["internalWebPropertyId"] = internalWebPropertyId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parentLink != null) {
      _json["parentLink"] = (parentLink).toJson();
    }
    if (profileId != null) {
      _json["profileId"] = profileId;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (urlDestinationDetails != null) {
      _json["urlDestinationDetails"] = (urlDestinationDetails).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    if (visitNumPagesDetails != null) {
      _json["visitNumPagesDetails"] = (visitNumPagesDetails).toJson();
    }
    if (visitTimeOnSiteDetails != null) {
      _json["visitTimeOnSiteDetails"] = (visitTimeOnSiteDetails).toJson();
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    return _json;
  }
}

/**
 * A goal collection lists Analytics goals to which the user has access. Each
 * view (profile) can have a set of goals. Each resource in the Goal collection
 * corresponds to a single Analytics goal.
 */
class Goals {
  /** A list of goals. */
  core.List<Goal> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this goal collection. */
  core.String nextLink;
  /** Link to previous page for this goal collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * resources in the result.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  Goals();

  Goals.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Goal.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/** JSON template for an Analytics Remarketing Include Conditions. */
class IncludeConditions {
  /**
   * The look-back window lets you specify a time frame for evaluating the
   * behavior that qualifies users for your audience. For example, if your
   * filters include users from Central Asia, and Transactions Greater than 2,
   * and you set the look-back window to 14 days, then any user from Central
   * Asia whose cumulative transactions exceed 2 during the last 14 days is
   * added to the audience.
   */
  core.int daysToLookBack;
  /**
   * Boolean indicating whether this segment is a smart list.
   * https://support.google.com/analytics/answer/4628577
   */
  core.bool isSmartList;
  /** Resource type for include conditions. */
  core.String kind;
  /** Number of days (in the range 1 to 540) a user remains in the audience. */
  core.int membershipDurationDays;
  /**
   * The segment condition that will cause a user to be added to an audience.
   */
  core.String segment;

  IncludeConditions();

  IncludeConditions.fromJson(core.Map _json) {
    if (_json.containsKey("daysToLookBack")) {
      daysToLookBack = _json["daysToLookBack"];
    }
    if (_json.containsKey("isSmartList")) {
      isSmartList = _json["isSmartList"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("membershipDurationDays")) {
      membershipDurationDays = _json["membershipDurationDays"];
    }
    if (_json.containsKey("segment")) {
      segment = _json["segment"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (daysToLookBack != null) {
      _json["daysToLookBack"] = daysToLookBack;
    }
    if (isSmartList != null) {
      _json["isSmartList"] = isSmartList;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (membershipDurationDays != null) {
      _json["membershipDurationDays"] = membershipDurationDays;
    }
    if (segment != null) {
      _json["segment"] = segment;
    }
    return _json;
  }
}

/** JSON template for an Analytics Remarketing Audience Foreign Link. */
class LinkedForeignAccount {
  /** Account ID to which this linked foreign account belongs. */
  core.String accountId;
  /** Boolean indicating whether this is eligible for search. */
  core.bool eligibleForSearch;
  /** Entity ad account link ID. */
  core.String id;
  /**
   * Internal ID for the web property to which this linked foreign account
   * belongs.
   */
  core.String internalWebPropertyId;
  /** Resource type for linked foreign account. */
  core.String kind;
  /**
   * The foreign account ID. For example the an AdWords `linkedAccountId` has
   * the following format XXX-XXX-XXXX.
   */
  core.String linkedAccountId;
  /** Remarketing audience ID to which this linked foreign account belongs. */
  core.String remarketingAudienceId;
  /** The status of this foreign account link. */
  core.String status;
  /** The type of the foreign account. For example `ADWORDS_LINKS`. */
  core.String type;
  /**
   * Web property ID of the form UA-XXXXX-YY to which this linked foreign
   * account belongs.
   */
  core.String webPropertyId;

  LinkedForeignAccount();

  LinkedForeignAccount.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("eligibleForSearch")) {
      eligibleForSearch = _json["eligibleForSearch"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("internalWebPropertyId")) {
      internalWebPropertyId = _json["internalWebPropertyId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("linkedAccountId")) {
      linkedAccountId = _json["linkedAccountId"];
    }
    if (_json.containsKey("remarketingAudienceId")) {
      remarketingAudienceId = _json["remarketingAudienceId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (eligibleForSearch != null) {
      _json["eligibleForSearch"] = eligibleForSearch;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (internalWebPropertyId != null) {
      _json["internalWebPropertyId"] = internalWebPropertyId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (linkedAccountId != null) {
      _json["linkedAccountId"] = linkedAccountId;
    }
    if (remarketingAudienceId != null) {
      _json["remarketingAudienceId"] = remarketingAudienceId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    return _json;
  }
}

class McfDataColumnHeaders {
  /** Column Type. Either DIMENSION or METRIC. */
  core.String columnType;
  /**
   * Data type. Dimension and metric values data types such as INTEGER, DOUBLE,
   * CURRENCY, MCF_SEQUENCE etc.
   */
  core.String dataType;
  /** Column name. */
  core.String name;

  McfDataColumnHeaders();

  McfDataColumnHeaders.fromJson(core.Map _json) {
    if (_json.containsKey("columnType")) {
      columnType = _json["columnType"];
    }
    if (_json.containsKey("dataType")) {
      dataType = _json["dataType"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnType != null) {
      _json["columnType"] = columnType;
    }
    if (dataType != null) {
      _json["dataType"] = dataType;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/**
 * Information for the view (profile), for which the Analytics data was
 * requested.
 */
class McfDataProfileInfo {
  /** Account ID to which this view (profile) belongs. */
  core.String accountId;
  /** Internal ID for the web property to which this view (profile) belongs. */
  core.String internalWebPropertyId;
  /** View (Profile) ID. */
  core.String profileId;
  /** View (Profile) name. */
  core.String profileName;
  /** Table ID for view (profile). */
  core.String tableId;
  /** Web Property ID to which this view (profile) belongs. */
  core.String webPropertyId;

  McfDataProfileInfo();

  McfDataProfileInfo.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("internalWebPropertyId")) {
      internalWebPropertyId = _json["internalWebPropertyId"];
    }
    if (_json.containsKey("profileId")) {
      profileId = _json["profileId"];
    }
    if (_json.containsKey("profileName")) {
      profileName = _json["profileName"];
    }
    if (_json.containsKey("tableId")) {
      tableId = _json["tableId"];
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (internalWebPropertyId != null) {
      _json["internalWebPropertyId"] = internalWebPropertyId;
    }
    if (profileId != null) {
      _json["profileId"] = profileId;
    }
    if (profileName != null) {
      _json["profileName"] = profileName;
    }
    if (tableId != null) {
      _json["tableId"] = tableId;
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    return _json;
  }
}

/** Analytics data request query parameters. */
class McfDataQuery {
  /** List of analytics dimensions. */
  core.String dimensions;
  /** End date. */
  core.String end_date;
  /** Comma-separated list of dimension or metric filters. */
  core.String filters;
  /** Unique table ID. */
  core.String ids;
  /** Maximum results per page. */
  core.int max_results;
  /** List of analytics metrics. */
  core.List<core.String> metrics;
  /** Desired sampling level */
  core.String samplingLevel;
  /** Analytics advanced segment. */
  core.String segment;
  /** List of dimensions or metrics based on which Analytics data is sorted. */
  core.List<core.String> sort;
  /** Start date. */
  core.String start_date;
  /** Start index. */
  core.int start_index;

  McfDataQuery();

  McfDataQuery.fromJson(core.Map _json) {
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"];
    }
    if (_json.containsKey("end-date")) {
      end_date = _json["end-date"];
    }
    if (_json.containsKey("filters")) {
      filters = _json["filters"];
    }
    if (_json.containsKey("ids")) {
      ids = _json["ids"];
    }
    if (_json.containsKey("max-results")) {
      max_results = _json["max-results"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"];
    }
    if (_json.containsKey("samplingLevel")) {
      samplingLevel = _json["samplingLevel"];
    }
    if (_json.containsKey("segment")) {
      segment = _json["segment"];
    }
    if (_json.containsKey("sort")) {
      sort = _json["sort"];
    }
    if (_json.containsKey("start-date")) {
      start_date = _json["start-date"];
    }
    if (_json.containsKey("start-index")) {
      start_index = _json["start-index"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensions != null) {
      _json["dimensions"] = dimensions;
    }
    if (end_date != null) {
      _json["end-date"] = end_date;
    }
    if (filters != null) {
      _json["filters"] = filters;
    }
    if (ids != null) {
      _json["ids"] = ids;
    }
    if (max_results != null) {
      _json["max-results"] = max_results;
    }
    if (metrics != null) {
      _json["metrics"] = metrics;
    }
    if (samplingLevel != null) {
      _json["samplingLevel"] = samplingLevel;
    }
    if (segment != null) {
      _json["segment"] = segment;
    }
    if (sort != null) {
      _json["sort"] = sort;
    }
    if (start_date != null) {
      _json["start-date"] = start_date;
    }
    if (start_index != null) {
      _json["start-index"] = start_index;
    }
    return _json;
  }
}

class McfDataRowsConversionPathValue {
  /**
   * Type of an interaction on conversion path. Such as CLICK, IMPRESSION etc.
   */
  core.String interactionType;
  /**
   * Node value of an interaction on conversion path. Such as source, medium
   * etc.
   */
  core.String nodeValue;

  McfDataRowsConversionPathValue();

  McfDataRowsConversionPathValue.fromJson(core.Map _json) {
    if (_json.containsKey("interactionType")) {
      interactionType = _json["interactionType"];
    }
    if (_json.containsKey("nodeValue")) {
      nodeValue = _json["nodeValue"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (interactionType != null) {
      _json["interactionType"] = interactionType;
    }
    if (nodeValue != null) {
      _json["nodeValue"] = nodeValue;
    }
    return _json;
  }
}

/**
 * A union object representing a dimension or metric value. Only one of
 * "primitiveValue" or "conversionPathValue" attribute will be populated.
 */
class McfDataRows {
  /**
   * A conversion path dimension value, containing a list of interactions with
   * their attributes.
   */
  core.List<McfDataRowsConversionPathValue> conversionPathValue;
  /** A primitive dimension value. A primitive metric value. */
  core.String primitiveValue;

  McfDataRows();

  McfDataRows.fromJson(core.Map _json) {
    if (_json.containsKey("conversionPathValue")) {
      conversionPathValue = _json["conversionPathValue"].map((value) => new McfDataRowsConversionPathValue.fromJson(value)).toList();
    }
    if (_json.containsKey("primitiveValue")) {
      primitiveValue = _json["primitiveValue"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (conversionPathValue != null) {
      _json["conversionPathValue"] = conversionPathValue.map((value) => (value).toJson()).toList();
    }
    if (primitiveValue != null) {
      _json["primitiveValue"] = primitiveValue;
    }
    return _json;
  }
}

/** Multi-Channel Funnels data for a given view (profile). */
class McfData {
  /**
   * Column headers that list dimension names followed by the metric names. The
   * order of dimensions and metrics is same as specified in the request.
   */
  core.List<McfDataColumnHeaders> columnHeaders;
  /** Determines if the Analytics data contains sampled data. */
  core.bool containsSampledData;
  /** Unique ID for this data response. */
  core.String id;
  /**
   * The maximum number of rows the response can contain, regardless of the
   * actual number of rows returned. Its value ranges from 1 to 10,000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Resource type. */
  core.String kind;
  /** Link to next page for this Analytics data query. */
  core.String nextLink;
  /** Link to previous page for this Analytics data query. */
  core.String previousLink;
  /**
   * Information for the view (profile), for which the Analytics data was
   * requested.
   */
  McfDataProfileInfo profileInfo;
  /** Analytics data request query parameters. */
  McfDataQuery query;
  /**
   * Analytics data rows, where each row contains a list of dimension values
   * followed by the metric values. The order of dimensions and metrics is same
   * as specified in the request.
   */
  core.List<core.List<McfDataRows>> rows;
  /** The number of samples used to calculate the result. */
  core.String sampleSize;
  /** Total size of the sample space from which the samples were selected. */
  core.String sampleSpace;
  /** Link to this page. */
  core.String selfLink;
  /**
   * The total number of rows for the query, regardless of the number of rows in
   * the response.
   */
  core.int totalResults;
  /**
   * Total values for the requested metrics over all the results, not just the
   * results returned in this response. The order of the metric totals is same
   * as the metric order specified in the request.
   */
  core.Map<core.String, core.String> totalsForAllResults;

  McfData();

  McfData.fromJson(core.Map _json) {
    if (_json.containsKey("columnHeaders")) {
      columnHeaders = _json["columnHeaders"].map((value) => new McfDataColumnHeaders.fromJson(value)).toList();
    }
    if (_json.containsKey("containsSampledData")) {
      containsSampledData = _json["containsSampledData"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("profileInfo")) {
      profileInfo = new McfDataProfileInfo.fromJson(_json["profileInfo"]);
    }
    if (_json.containsKey("query")) {
      query = new McfDataQuery.fromJson(_json["query"]);
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"].map((value) => value.map((value) => new McfDataRows.fromJson(value)).toList()).toList();
    }
    if (_json.containsKey("sampleSize")) {
      sampleSize = _json["sampleSize"];
    }
    if (_json.containsKey("sampleSpace")) {
      sampleSpace = _json["sampleSpace"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("totalsForAllResults")) {
      totalsForAllResults = _json["totalsForAllResults"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnHeaders != null) {
      _json["columnHeaders"] = columnHeaders.map((value) => (value).toJson()).toList();
    }
    if (containsSampledData != null) {
      _json["containsSampledData"] = containsSampledData;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (profileInfo != null) {
      _json["profileInfo"] = (profileInfo).toJson();
    }
    if (query != null) {
      _json["query"] = (query).toJson();
    }
    if (rows != null) {
      _json["rows"] = rows.map((value) => value.map((value) => (value).toJson()).toList()).toList();
    }
    if (sampleSize != null) {
      _json["sampleSize"] = sampleSize;
    }
    if (sampleSpace != null) {
      _json["sampleSpace"] = sampleSpace;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (totalsForAllResults != null) {
      _json["totalsForAllResults"] = totalsForAllResults;
    }
    return _json;
  }
}

/**
 * Child link for this view (profile). Points to the list of goals for this view
 * (profile).
 */
class ProfileChildLink {
  /** Link to the list of goals for this view (profile). */
  core.String href;
  /** Value is "analytics#goals". */
  core.String type;

  ProfileChildLink();

  ProfileChildLink.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (href != null) {
      _json["href"] = href;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * Parent link for this view (profile). Points to the web property to which this
 * view (profile) belongs.
 */
class ProfileParentLink {
  /** Link to the web property to which this view (profile) belongs. */
  core.String href;
  /** Value is "analytics#webproperty". */
  core.String type;

  ProfileParentLink();

  ProfileParentLink.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (href != null) {
      _json["href"] = href;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Permissions the user has for this view (profile). */
class ProfilePermissions {
  /**
   * All the permissions that the user has for this view (profile). These
   * include any implied permissions (e.g., EDIT implies VIEW) or inherited
   * permissions from the parent web property.
   */
  core.List<core.String> effective;

  ProfilePermissions();

  ProfilePermissions.fromJson(core.Map _json) {
    if (_json.containsKey("effective")) {
      effective = _json["effective"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (effective != null) {
      _json["effective"] = effective;
    }
    return _json;
  }
}

/** JSON template for an Analytics view (profile). */
class Profile {
  /** Account ID to which this view (profile) belongs. */
  core.String accountId;
  /** Indicates whether bot filtering is enabled for this view (profile). */
  core.bool botFilteringEnabled;
  /**
   * Child link for this view (profile). Points to the list of goals for this
   * view (profile).
   */
  ProfileChildLink childLink;
  /** Time this view (profile) was created. */
  core.DateTime created;
  /**
   * The currency type associated with this view (profile), defaults to USD. The
   * supported values are:
   * USD, JPY, EUR, GBP, AUD, KRW, BRL, CNY, DKK, RUB, SEK, NOK, PLN, TRY, TWD,
   * HKD, THB, IDR, ARS, MXN, VND, PHP, INR, CHF, CAD, CZK, NZD, HUF, BGN, LTL,
   * ZAR, UAH, AED, BOB, CLP, COP, EGP, HRK, ILS, MAD, MYR, PEN, PKR, RON, RSD,
   * SAR, SGD, VEF, LVL
   */
  core.String currency;
  /** Default page for this view (profile). */
  core.String defaultPage;
  /**
   * Indicates whether ecommerce tracking is enabled for this view (profile).
   */
  core.bool eCommerceTracking;
  /**
   * Indicates whether enhanced ecommerce tracking is enabled for this view
   * (profile). This property can only be enabled if ecommerce tracking is
   * enabled.
   */
  core.bool enhancedECommerceTracking;
  /** The query parameters that are excluded from this view (profile). */
  core.String excludeQueryParameters;
  /** View (Profile) ID. */
  core.String id;
  /** Internal ID for the web property to which this view (profile) belongs. */
  core.String internalWebPropertyId;
  /** Resource type for Analytics view (profile). */
  core.String kind;
  /** Name of this view (profile). */
  core.String name;
  /**
   * Parent link for this view (profile). Points to the web property to which
   * this view (profile) belongs.
   */
  ProfileParentLink parentLink;
  /** Permissions the user has for this view (profile). */
  ProfilePermissions permissions;
  /** Link for this view (profile). */
  core.String selfLink;
  /** Site search category parameters for this view (profile). */
  core.String siteSearchCategoryParameters;
  /** The site search query parameters for this view (profile). */
  core.String siteSearchQueryParameters;
  /** Indicates whether this view (profile) is starred or not. */
  core.bool starred;
  /**
   * Whether or not Analytics will strip search category parameters from the
   * URLs in your reports.
   */
  core.bool stripSiteSearchCategoryParameters;
  /**
   * Whether or not Analytics will strip search query parameters from the URLs
   * in your reports.
   */
  core.bool stripSiteSearchQueryParameters;
  /**
   * Time zone for which this view (profile) has been configured. Time zones are
   * identified by strings from the TZ database.
   */
  core.String timezone;
  /** View (Profile) type. Supported types: WEB or APP. */
  core.String type;
  /** Time this view (profile) was last modified. */
  core.DateTime updated;
  /**
   * Web property ID of the form UA-XXXXX-YY to which this view (profile)
   * belongs.
   */
  core.String webPropertyId;
  /** Website URL for this view (profile). */
  core.String websiteUrl;

  Profile();

  Profile.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("botFilteringEnabled")) {
      botFilteringEnabled = _json["botFilteringEnabled"];
    }
    if (_json.containsKey("childLink")) {
      childLink = new ProfileChildLink.fromJson(_json["childLink"]);
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("currency")) {
      currency = _json["currency"];
    }
    if (_json.containsKey("defaultPage")) {
      defaultPage = _json["defaultPage"];
    }
    if (_json.containsKey("eCommerceTracking")) {
      eCommerceTracking = _json["eCommerceTracking"];
    }
    if (_json.containsKey("enhancedECommerceTracking")) {
      enhancedECommerceTracking = _json["enhancedECommerceTracking"];
    }
    if (_json.containsKey("excludeQueryParameters")) {
      excludeQueryParameters = _json["excludeQueryParameters"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("internalWebPropertyId")) {
      internalWebPropertyId = _json["internalWebPropertyId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parentLink")) {
      parentLink = new ProfileParentLink.fromJson(_json["parentLink"]);
    }
    if (_json.containsKey("permissions")) {
      permissions = new ProfilePermissions.fromJson(_json["permissions"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("siteSearchCategoryParameters")) {
      siteSearchCategoryParameters = _json["siteSearchCategoryParameters"];
    }
    if (_json.containsKey("siteSearchQueryParameters")) {
      siteSearchQueryParameters = _json["siteSearchQueryParameters"];
    }
    if (_json.containsKey("starred")) {
      starred = _json["starred"];
    }
    if (_json.containsKey("stripSiteSearchCategoryParameters")) {
      stripSiteSearchCategoryParameters = _json["stripSiteSearchCategoryParameters"];
    }
    if (_json.containsKey("stripSiteSearchQueryParameters")) {
      stripSiteSearchQueryParameters = _json["stripSiteSearchQueryParameters"];
    }
    if (_json.containsKey("timezone")) {
      timezone = _json["timezone"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
    if (_json.containsKey("websiteUrl")) {
      websiteUrl = _json["websiteUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (botFilteringEnabled != null) {
      _json["botFilteringEnabled"] = botFilteringEnabled;
    }
    if (childLink != null) {
      _json["childLink"] = (childLink).toJson();
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (currency != null) {
      _json["currency"] = currency;
    }
    if (defaultPage != null) {
      _json["defaultPage"] = defaultPage;
    }
    if (eCommerceTracking != null) {
      _json["eCommerceTracking"] = eCommerceTracking;
    }
    if (enhancedECommerceTracking != null) {
      _json["enhancedECommerceTracking"] = enhancedECommerceTracking;
    }
    if (excludeQueryParameters != null) {
      _json["excludeQueryParameters"] = excludeQueryParameters;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (internalWebPropertyId != null) {
      _json["internalWebPropertyId"] = internalWebPropertyId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parentLink != null) {
      _json["parentLink"] = (parentLink).toJson();
    }
    if (permissions != null) {
      _json["permissions"] = (permissions).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (siteSearchCategoryParameters != null) {
      _json["siteSearchCategoryParameters"] = siteSearchCategoryParameters;
    }
    if (siteSearchQueryParameters != null) {
      _json["siteSearchQueryParameters"] = siteSearchQueryParameters;
    }
    if (starred != null) {
      _json["starred"] = starred;
    }
    if (stripSiteSearchCategoryParameters != null) {
      _json["stripSiteSearchCategoryParameters"] = stripSiteSearchCategoryParameters;
    }
    if (stripSiteSearchQueryParameters != null) {
      _json["stripSiteSearchQueryParameters"] = stripSiteSearchQueryParameters;
    }
    if (timezone != null) {
      _json["timezone"] = timezone;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    if (websiteUrl != null) {
      _json["websiteUrl"] = websiteUrl;
    }
    return _json;
  }
}

/** JSON template for an Analytics profile filter link. */
class ProfileFilterLink {
  /** Filter for this link. */
  FilterRef filterRef;
  /** Profile filter link ID. */
  core.String id;
  /** Resource type for Analytics filter. */
  core.String kind;
  /** View (Profile) for this link. */
  ProfileRef profileRef;
  /**
   * The rank of this profile filter link relative to the other filters linked
   * to the same profile.
   * For readonly (i.e., list and get) operations, the rank always starts at 1.
   * For write (i.e., create, update, or delete) operations, you may specify a
   * value between 0 and 255 inclusively, [0, 255]. In order to insert a link at
   * the end of the list, either don't specify a rank or set a rank to a number
   * greater than the largest rank in the list. In order to insert a link to the
   * beginning of the list specify a rank that is less than or equal to 1. The
   * new link will move all existing filters with the same or lower rank down
   * the list. After the link is inserted/updated/deleted all profile filter
   * links will be renumbered starting at 1.
   */
  core.int rank;
  /** Link for this profile filter link. */
  core.String selfLink;

  ProfileFilterLink();

  ProfileFilterLink.fromJson(core.Map _json) {
    if (_json.containsKey("filterRef")) {
      filterRef = new FilterRef.fromJson(_json["filterRef"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("profileRef")) {
      profileRef = new ProfileRef.fromJson(_json["profileRef"]);
    }
    if (_json.containsKey("rank")) {
      rank = _json["rank"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (filterRef != null) {
      _json["filterRef"] = (filterRef).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (profileRef != null) {
      _json["profileRef"] = (profileRef).toJson();
    }
    if (rank != null) {
      _json["rank"] = rank;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/**
 * A profile filter link collection lists profile filter links between profiles
 * and filters. Each resource in the collection corresponds to a profile filter
 * link.
 */
class ProfileFilterLinks {
  /** A list of profile filter links. */
  core.List<ProfileFilterLink> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1,000 with
   * a value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this profile filter link collection. */
  core.String nextLink;
  /** Link to previous page for this profile filter link collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  ProfileFilterLinks();

  ProfileFilterLinks.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new ProfileFilterLink.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/** JSON template for a linked view (profile). */
class ProfileRef {
  /** Account ID to which this view (profile) belongs. */
  core.String accountId;
  /** Link for this view (profile). */
  core.String href;
  /** View (Profile) ID. */
  core.String id;
  /** Internal ID for the web property to which this view (profile) belongs. */
  core.String internalWebPropertyId;
  /** Analytics view (profile) reference. */
  core.String kind;
  /** Name of this view (profile). */
  core.String name;
  /**
   * Web property ID of the form UA-XXXXX-YY to which this view (profile)
   * belongs.
   */
  core.String webPropertyId;

  ProfileRef();

  ProfileRef.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("internalWebPropertyId")) {
      internalWebPropertyId = _json["internalWebPropertyId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (href != null) {
      _json["href"] = href;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (internalWebPropertyId != null) {
      _json["internalWebPropertyId"] = internalWebPropertyId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    return _json;
  }
}

/**
 * JSON template for an Analytics ProfileSummary. ProfileSummary returns basic
 * information (i.e., summary) for a profile.
 */
class ProfileSummary {
  /** View (profile) ID. */
  core.String id;
  /** Resource type for Analytics ProfileSummary. */
  core.String kind;
  /** View (profile) name. */
  core.String name;
  /** Indicates whether this view (profile) is starred or not. */
  core.bool starred;
  /** View (Profile) type. Supported types: WEB or APP. */
  core.String type;

  ProfileSummary();

  ProfileSummary.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("starred")) {
      starred = _json["starred"];
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
    if (name != null) {
      _json["name"] = name;
    }
    if (starred != null) {
      _json["starred"] = starred;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * A view (profile) collection lists Analytics views (profiles) to which the
 * user has access. Each resource in the collection corresponds to a single
 * Analytics view (profile).
 */
class Profiles {
  /** A list of views (profiles). */
  core.List<Profile> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this view (profile) collection. */
  core.String nextLink;
  /** Link to previous page for this view (profile) collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  Profiles();

  Profiles.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Profile.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

class RealtimeDataColumnHeaders {
  /** Column Type. Either DIMENSION or METRIC. */
  core.String columnType;
  /**
   * Data type. Dimension column headers have only STRING as the data type.
   * Metric column headers have data types for metric values such as INTEGER,
   * DOUBLE, CURRENCY etc.
   */
  core.String dataType;
  /** Column name. */
  core.String name;

  RealtimeDataColumnHeaders();

  RealtimeDataColumnHeaders.fromJson(core.Map _json) {
    if (_json.containsKey("columnType")) {
      columnType = _json["columnType"];
    }
    if (_json.containsKey("dataType")) {
      dataType = _json["dataType"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnType != null) {
      _json["columnType"] = columnType;
    }
    if (dataType != null) {
      _json["dataType"] = dataType;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/**
 * Information for the view (profile), for which the real time data was
 * requested.
 */
class RealtimeDataProfileInfo {
  /** Account ID to which this view (profile) belongs. */
  core.String accountId;
  /** Internal ID for the web property to which this view (profile) belongs. */
  core.String internalWebPropertyId;
  /** View (Profile) ID. */
  core.String profileId;
  /** View (Profile) name. */
  core.String profileName;
  /** Table ID for view (profile). */
  core.String tableId;
  /** Web Property ID to which this view (profile) belongs. */
  core.String webPropertyId;

  RealtimeDataProfileInfo();

  RealtimeDataProfileInfo.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("internalWebPropertyId")) {
      internalWebPropertyId = _json["internalWebPropertyId"];
    }
    if (_json.containsKey("profileId")) {
      profileId = _json["profileId"];
    }
    if (_json.containsKey("profileName")) {
      profileName = _json["profileName"];
    }
    if (_json.containsKey("tableId")) {
      tableId = _json["tableId"];
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (internalWebPropertyId != null) {
      _json["internalWebPropertyId"] = internalWebPropertyId;
    }
    if (profileId != null) {
      _json["profileId"] = profileId;
    }
    if (profileName != null) {
      _json["profileName"] = profileName;
    }
    if (tableId != null) {
      _json["tableId"] = tableId;
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    return _json;
  }
}

/** Real time data request query parameters. */
class RealtimeDataQuery {
  /** List of real time dimensions. */
  core.String dimensions;
  /** Comma-separated list of dimension or metric filters. */
  core.String filters;
  /** Unique table ID. */
  core.String ids;
  /** Maximum results per page. */
  core.int max_results;
  /** List of real time metrics. */
  core.List<core.String> metrics;
  /** List of dimensions or metrics based on which real time data is sorted. */
  core.List<core.String> sort;

  RealtimeDataQuery();

  RealtimeDataQuery.fromJson(core.Map _json) {
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"];
    }
    if (_json.containsKey("filters")) {
      filters = _json["filters"];
    }
    if (_json.containsKey("ids")) {
      ids = _json["ids"];
    }
    if (_json.containsKey("max-results")) {
      max_results = _json["max-results"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"];
    }
    if (_json.containsKey("sort")) {
      sort = _json["sort"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensions != null) {
      _json["dimensions"] = dimensions;
    }
    if (filters != null) {
      _json["filters"] = filters;
    }
    if (ids != null) {
      _json["ids"] = ids;
    }
    if (max_results != null) {
      _json["max-results"] = max_results;
    }
    if (metrics != null) {
      _json["metrics"] = metrics;
    }
    if (sort != null) {
      _json["sort"] = sort;
    }
    return _json;
  }
}

/** Real time data for a given view (profile). */
class RealtimeData {
  /**
   * Column headers that list dimension names followed by the metric names. The
   * order of dimensions and metrics is same as specified in the request.
   */
  core.List<RealtimeDataColumnHeaders> columnHeaders;
  /** Unique ID for this data response. */
  core.String id;
  /** Resource type. */
  core.String kind;
  /**
   * Information for the view (profile), for which the real time data was
   * requested.
   */
  RealtimeDataProfileInfo profileInfo;
  /** Real time data request query parameters. */
  RealtimeDataQuery query;
  /**
   * Real time data rows, where each row contains a list of dimension values
   * followed by the metric values. The order of dimensions and metrics is same
   * as specified in the request.
   */
  core.List<core.List<core.String>> rows;
  /** Link to this page. */
  core.String selfLink;
  /**
   * The total number of rows for the query, regardless of the number of rows in
   * the response.
   */
  core.int totalResults;
  /**
   * Total values for the requested metrics over all the results, not just the
   * results returned in this response. The order of the metric totals is same
   * as the metric order specified in the request.
   */
  core.Map<core.String, core.String> totalsForAllResults;

  RealtimeData();

  RealtimeData.fromJson(core.Map _json) {
    if (_json.containsKey("columnHeaders")) {
      columnHeaders = _json["columnHeaders"].map((value) => new RealtimeDataColumnHeaders.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("profileInfo")) {
      profileInfo = new RealtimeDataProfileInfo.fromJson(_json["profileInfo"]);
    }
    if (_json.containsKey("query")) {
      query = new RealtimeDataQuery.fromJson(_json["query"]);
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("totalsForAllResults")) {
      totalsForAllResults = _json["totalsForAllResults"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnHeaders != null) {
      _json["columnHeaders"] = columnHeaders.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (profileInfo != null) {
      _json["profileInfo"] = (profileInfo).toJson();
    }
    if (query != null) {
      _json["query"] = (query).toJson();
    }
    if (rows != null) {
      _json["rows"] = rows;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (totalsForAllResults != null) {
      _json["totalsForAllResults"] = totalsForAllResults;
    }
    return _json;
  }
}

/**
 * The simple audience definition that will cause a user to be added to an
 * audience.
 */
class RemarketingAudienceAudienceDefinition {
  /** Defines the conditions to include users to the audience. */
  IncludeConditions includeConditions;

  RemarketingAudienceAudienceDefinition();

  RemarketingAudienceAudienceDefinition.fromJson(core.Map _json) {
    if (_json.containsKey("includeConditions")) {
      includeConditions = new IncludeConditions.fromJson(_json["includeConditions"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (includeConditions != null) {
      _json["includeConditions"] = (includeConditions).toJson();
    }
    return _json;
  }
}

/** Defines the conditions to exclude users from the audience. */
class RemarketingAudienceStateBasedAudienceDefinitionExcludeConditions {
  /** Whether to make the exclusion TEMPORARY or PERMANENT. */
  core.String exclusionDuration;
  /**
   * The segment condition that will cause a user to be removed from an
   * audience.
   */
  core.String segment;

  RemarketingAudienceStateBasedAudienceDefinitionExcludeConditions();

  RemarketingAudienceStateBasedAudienceDefinitionExcludeConditions.fromJson(core.Map _json) {
    if (_json.containsKey("exclusionDuration")) {
      exclusionDuration = _json["exclusionDuration"];
    }
    if (_json.containsKey("segment")) {
      segment = _json["segment"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (exclusionDuration != null) {
      _json["exclusionDuration"] = exclusionDuration;
    }
    if (segment != null) {
      _json["segment"] = segment;
    }
    return _json;
  }
}

/**
 * A state based audience definition that will cause a user to be added or
 * removed from an audience.
 */
class RemarketingAudienceStateBasedAudienceDefinition {
  /** Defines the conditions to exclude users from the audience. */
  RemarketingAudienceStateBasedAudienceDefinitionExcludeConditions excludeConditions;
  /** Defines the conditions to include users to the audience. */
  IncludeConditions includeConditions;

  RemarketingAudienceStateBasedAudienceDefinition();

  RemarketingAudienceStateBasedAudienceDefinition.fromJson(core.Map _json) {
    if (_json.containsKey("excludeConditions")) {
      excludeConditions = new RemarketingAudienceStateBasedAudienceDefinitionExcludeConditions.fromJson(_json["excludeConditions"]);
    }
    if (_json.containsKey("includeConditions")) {
      includeConditions = new IncludeConditions.fromJson(_json["includeConditions"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (excludeConditions != null) {
      _json["excludeConditions"] = (excludeConditions).toJson();
    }
    if (includeConditions != null) {
      _json["includeConditions"] = (includeConditions).toJson();
    }
    return _json;
  }
}

/** JSON template for an Analytics remarketing audience. */
class RemarketingAudience {
  /** Account ID to which this remarketing audience belongs. */
  core.String accountId;
  /**
   * The simple audience definition that will cause a user to be added to an
   * audience.
   */
  RemarketingAudienceAudienceDefinition audienceDefinition;
  /** The type of audience, either SIMPLE or STATE_BASED. */
  core.String audienceType;
  /** Time this remarketing audience was created. */
  core.DateTime created;
  /** The description of this remarketing audience. */
  core.String description;
  /** Remarketing Audience ID. */
  core.String id;
  /**
   * Internal ID for the web property to which this remarketing audience
   * belongs.
   */
  core.String internalWebPropertyId;
  /** Collection type. */
  core.String kind;
  /**
   * The linked ad accounts associated with this remarketing audience. A
   * remarketing audience can have only one linkedAdAccount currently.
   */
  core.List<LinkedForeignAccount> linkedAdAccounts;
  /** The views (profiles) that this remarketing audience is linked to. */
  core.List<core.String> linkedViews;
  /** The name of this remarketing audience. */
  core.String name;
  /**
   * A state based audience definition that will cause a user to be added or
   * removed from an audience.
   */
  RemarketingAudienceStateBasedAudienceDefinition stateBasedAudienceDefinition;
  /** Time this remarketing audience was last modified. */
  core.DateTime updated;
  /**
   * Web property ID of the form UA-XXXXX-YY to which this remarketing audience
   * belongs.
   */
  core.String webPropertyId;

  RemarketingAudience();

  RemarketingAudience.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("audienceDefinition")) {
      audienceDefinition = new RemarketingAudienceAudienceDefinition.fromJson(_json["audienceDefinition"]);
    }
    if (_json.containsKey("audienceType")) {
      audienceType = _json["audienceType"];
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("internalWebPropertyId")) {
      internalWebPropertyId = _json["internalWebPropertyId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("linkedAdAccounts")) {
      linkedAdAccounts = _json["linkedAdAccounts"].map((value) => new LinkedForeignAccount.fromJson(value)).toList();
    }
    if (_json.containsKey("linkedViews")) {
      linkedViews = _json["linkedViews"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("stateBasedAudienceDefinition")) {
      stateBasedAudienceDefinition = new RemarketingAudienceStateBasedAudienceDefinition.fromJson(_json["stateBasedAudienceDefinition"]);
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (audienceDefinition != null) {
      _json["audienceDefinition"] = (audienceDefinition).toJson();
    }
    if (audienceType != null) {
      _json["audienceType"] = audienceType;
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (internalWebPropertyId != null) {
      _json["internalWebPropertyId"] = internalWebPropertyId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (linkedAdAccounts != null) {
      _json["linkedAdAccounts"] = linkedAdAccounts.map((value) => (value).toJson()).toList();
    }
    if (linkedViews != null) {
      _json["linkedViews"] = linkedViews;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (stateBasedAudienceDefinition != null) {
      _json["stateBasedAudienceDefinition"] = (stateBasedAudienceDefinition).toJson();
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    return _json;
  }
}

/**
 * A remarketing audience collection lists Analytics remarketing audiences to
 * which the user has access. Each resource in the collection corresponds to a
 * single Analytics remarketing audience.
 */
class RemarketingAudiences {
  /** A list of remarketing audiences. */
  core.List<RemarketingAudience> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this remarketing audience collection. */
  core.String nextLink;
  /** Link to previous page for this view (profile) collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  RemarketingAudiences();

  RemarketingAudiences.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new RemarketingAudience.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/** JSON template for an Analytics segment. */
class Segment {
  /** Time the segment was created. */
  core.DateTime created;
  /** Segment definition. */
  core.String definition;
  /** Segment ID. */
  core.String id;
  /** Resource type for Analytics segment. */
  core.String kind;
  /** Segment name. */
  core.String name;
  /**
   * Segment ID. Can be used with the 'segment' parameter in Core Reporting API.
   */
  core.String segmentId;
  /** Link for this segment. */
  core.String selfLink;
  /** Type for a segment. Possible values are "BUILT_IN" or "CUSTOM". */
  core.String type;
  /** Time the segment was last modified. */
  core.DateTime updated;

  Segment();

  Segment.fromJson(core.Map _json) {
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("definition")) {
      definition = _json["definition"];
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
    if (_json.containsKey("segmentId")) {
      segmentId = _json["segmentId"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (definition != null) {
      _json["definition"] = definition;
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
    if (segmentId != null) {
      _json["segmentId"] = segmentId;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

/**
 * An segment collection lists Analytics segments that the user has access to.
 * Each resource in the collection corresponds to a single Analytics segment.
 */
class Segments {
  /** A list of segments. */
  core.List<Segment> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type for segments. */
  core.String kind;
  /** Link to next page for this segment collection. */
  core.String nextLink;
  /** Link to previous page for this segment collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  Segments();

  Segments.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Segment.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/** Download details for a file stored in Google Cloud Storage. */
class UnsampledReportCloudStorageDownloadDetails {
  /** Id of the bucket the file object is stored in. */
  core.String bucketId;
  /** Id of the file object containing the report data. */
  core.String objectId;

  UnsampledReportCloudStorageDownloadDetails();

  UnsampledReportCloudStorageDownloadDetails.fromJson(core.Map _json) {
    if (_json.containsKey("bucketId")) {
      bucketId = _json["bucketId"];
    }
    if (_json.containsKey("objectId")) {
      objectId = _json["objectId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bucketId != null) {
      _json["bucketId"] = bucketId;
    }
    if (objectId != null) {
      _json["objectId"] = objectId;
    }
    return _json;
  }
}

/** Download details for a file stored in Google Drive. */
class UnsampledReportDriveDownloadDetails {
  /** Id of the document/file containing the report data. */
  core.String documentId;

  UnsampledReportDriveDownloadDetails();

  UnsampledReportDriveDownloadDetails.fromJson(core.Map _json) {
    if (_json.containsKey("documentId")) {
      documentId = _json["documentId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (documentId != null) {
      _json["documentId"] = documentId;
    }
    return _json;
  }
}

/** JSON template for Analytics unsampled report resource. */
class UnsampledReport {
  /** Account ID to which this unsampled report belongs. */
  core.String accountId;
  /** Download details for a file stored in Google Cloud Storage. */
  UnsampledReportCloudStorageDownloadDetails cloudStorageDownloadDetails;
  /** Time this unsampled report was created. */
  core.DateTime created;
  /** The dimensions for the unsampled report. */
  core.String dimensions;
  /**
   * The type of download you need to use for the report data file. Possible
   * values include `GOOGLE_DRIVE` and `GOOGLE_CLOUD_STORAGE`. If the value is
   * `GOOGLE_DRIVE`, see the `driveDownloadDetails` field. If the value is
   * `GOOGLE_CLOUD_STORAGE`, see the `cloudStorageDownloadDetails` field.
   */
  core.String downloadType;
  /** Download details for a file stored in Google Drive. */
  UnsampledReportDriveDownloadDetails driveDownloadDetails;
  /** The end date for the unsampled report. */
  core.String end_date;
  /** The filters for the unsampled report. */
  core.String filters;
  /** Unsampled report ID. */
  core.String id;
  /** Resource type for an Analytics unsampled report. */
  core.String kind;
  /** The metrics for the unsampled report. */
  core.String metrics;
  /** View (Profile) ID to which this unsampled report belongs. */
  core.String profileId;
  /** The segment for the unsampled report. */
  core.String segment;
  /** Link for this unsampled report. */
  core.String selfLink;
  /** The start date for the unsampled report. */
  core.String start_date;
  /**
   * Status of this unsampled report. Possible values are PENDING, COMPLETED, or
   * FAILED.
   */
  core.String status;
  /** Title of the unsampled report. */
  core.String title;
  /** Time this unsampled report was last modified. */
  core.DateTime updated;
  /**
   * Web property ID to which this unsampled report belongs. The web property ID
   * is of the form UA-XXXXX-YY.
   */
  core.String webPropertyId;

  UnsampledReport();

  UnsampledReport.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("cloudStorageDownloadDetails")) {
      cloudStorageDownloadDetails = new UnsampledReportCloudStorageDownloadDetails.fromJson(_json["cloudStorageDownloadDetails"]);
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"];
    }
    if (_json.containsKey("downloadType")) {
      downloadType = _json["downloadType"];
    }
    if (_json.containsKey("driveDownloadDetails")) {
      driveDownloadDetails = new UnsampledReportDriveDownloadDetails.fromJson(_json["driveDownloadDetails"]);
    }
    if (_json.containsKey("end-date")) {
      end_date = _json["end-date"];
    }
    if (_json.containsKey("filters")) {
      filters = _json["filters"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"];
    }
    if (_json.containsKey("profileId")) {
      profileId = _json["profileId"];
    }
    if (_json.containsKey("segment")) {
      segment = _json["segment"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("start-date")) {
      start_date = _json["start-date"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("webPropertyId")) {
      webPropertyId = _json["webPropertyId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (cloudStorageDownloadDetails != null) {
      _json["cloudStorageDownloadDetails"] = (cloudStorageDownloadDetails).toJson();
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (dimensions != null) {
      _json["dimensions"] = dimensions;
    }
    if (downloadType != null) {
      _json["downloadType"] = downloadType;
    }
    if (driveDownloadDetails != null) {
      _json["driveDownloadDetails"] = (driveDownloadDetails).toJson();
    }
    if (end_date != null) {
      _json["end-date"] = end_date;
    }
    if (filters != null) {
      _json["filters"] = filters;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (metrics != null) {
      _json["metrics"] = metrics;
    }
    if (profileId != null) {
      _json["profileId"] = profileId;
    }
    if (segment != null) {
      _json["segment"] = segment;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (start_date != null) {
      _json["start-date"] = start_date;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (webPropertyId != null) {
      _json["webPropertyId"] = webPropertyId;
    }
    return _json;
  }
}

/**
 * An unsampled report collection lists Analytics unsampled reports to which the
 * user has access. Each view (profile) can have a set of unsampled reports.
 * Each resource in the unsampled report collection corresponds to a single
 * Analytics unsampled report.
 */
class UnsampledReports {
  /** A list of unsampled reports. */
  core.List<UnsampledReport> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this unsampled report collection. */
  core.String nextLink;
  /** Link to previous page for this unsampled report collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * resources in the result.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  UnsampledReports();

  UnsampledReports.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new UnsampledReport.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/** Metadata returned for an upload operation. */
class Upload {
  /** Account Id to which this upload belongs. */
  core.String accountId;
  /** Custom data source Id to which this data import belongs. */
  core.String customDataSourceId;
  /** Data import errors collection. */
  core.List<core.String> errors;
  /** A unique ID for this upload. */
  core.String id;
  /** Resource type for Analytics upload. */
  core.String kind;
  /**
   * Upload status. Possible values: PENDING, COMPLETED, FAILED, DELETING,
   * DELETED.
   */
  core.String status;

  Upload();

  Upload.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("customDataSourceId")) {
      customDataSourceId = _json["customDataSourceId"];
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (customDataSourceId != null) {
      _json["customDataSourceId"] = customDataSourceId;
    }
    if (errors != null) {
      _json["errors"] = errors;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/**
 * Upload collection lists Analytics uploads to which the user has access. Each
 * custom data source can have a set of uploads. Each resource in the upload
 * collection corresponds to a single Analytics data upload.
 */
class Uploads {
  /** A list of uploads. */
  core.List<Upload> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this upload collection. */
  core.String nextLink;
  /** Link to previous page for this upload collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * resources in the result.
   */
  core.int totalResults;

  Uploads();

  Uploads.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Upload.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    return _json;
  }
}

/** JSON template for a user reference. */
class UserRef {
  /** Email ID of this user. */
  core.String email;
  /** User ID. */
  core.String id;
  core.String kind;

  UserRef();

  UserRef.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
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
    if (email != null) {
      _json["email"] = email;
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

/** JSON template for a web property reference. */
class WebPropertyRef {
  /** Account ID to which this web property belongs. */
  core.String accountId;
  /** Link for this web property. */
  core.String href;
  /** Web property ID of the form UA-XXXXX-YY. */
  core.String id;
  /** Internal ID for this web property. */
  core.String internalWebPropertyId;
  /** Analytics web property reference. */
  core.String kind;
  /** Name of this web property. */
  core.String name;

  WebPropertyRef();

  WebPropertyRef.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("internalWebPropertyId")) {
      internalWebPropertyId = _json["internalWebPropertyId"];
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
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (href != null) {
      _json["href"] = href;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (internalWebPropertyId != null) {
      _json["internalWebPropertyId"] = internalWebPropertyId;
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

/**
 * JSON template for an Analytics WebPropertySummary. WebPropertySummary returns
 * basic information (i.e., summary) for a web property.
 */
class WebPropertySummary {
  /** Web property ID of the form UA-XXXXX-YY. */
  core.String id;
  /** Internal ID for this web property. */
  core.String internalWebPropertyId;
  /** Resource type for Analytics WebPropertySummary. */
  core.String kind;
  /** Level for this web property. Possible values are STANDARD or PREMIUM. */
  core.String level;
  /** Web property name. */
  core.String name;
  /** List of profiles under this web property. */
  core.List<ProfileSummary> profiles;
  /** Indicates whether this web property is starred or not. */
  core.bool starred;
  /** Website url for this web property. */
  core.String websiteUrl;

  WebPropertySummary();

  WebPropertySummary.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("internalWebPropertyId")) {
      internalWebPropertyId = _json["internalWebPropertyId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("level")) {
      level = _json["level"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("profiles")) {
      profiles = _json["profiles"].map((value) => new ProfileSummary.fromJson(value)).toList();
    }
    if (_json.containsKey("starred")) {
      starred = _json["starred"];
    }
    if (_json.containsKey("websiteUrl")) {
      websiteUrl = _json["websiteUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (internalWebPropertyId != null) {
      _json["internalWebPropertyId"] = internalWebPropertyId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (level != null) {
      _json["level"] = level;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (profiles != null) {
      _json["profiles"] = profiles.map((value) => (value).toJson()).toList();
    }
    if (starred != null) {
      _json["starred"] = starred;
    }
    if (websiteUrl != null) {
      _json["websiteUrl"] = websiteUrl;
    }
    return _json;
  }
}

/**
 * A web property collection lists Analytics web properties to which the user
 * has access. Each resource in the collection corresponds to a single Analytics
 * web property.
 */
class Webproperties {
  /** A list of web properties. */
  core.List<Webproperty> items;
  /**
   * The maximum number of resources the response can contain, regardless of the
   * actual number of resources returned. Its value ranges from 1 to 1000 with a
   * value of 1000 by default, or otherwise specified by the max-results query
   * parameter.
   */
  core.int itemsPerPage;
  /** Collection type. */
  core.String kind;
  /** Link to next page for this web property collection. */
  core.String nextLink;
  /** Link to previous page for this web property collection. */
  core.String previousLink;
  /**
   * The starting index of the resources, which is 1 by default or otherwise
   * specified by the start-index query parameter.
   */
  core.int startIndex;
  /**
   * The total number of results for the query, regardless of the number of
   * results in the response.
   */
  core.int totalResults;
  /** Email ID of the authenticated user */
  core.String username;

  Webproperties();

  Webproperties.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Webproperty.fromJson(value)).toList();
    }
    if (_json.containsKey("itemsPerPage")) {
      itemsPerPage = _json["itemsPerPage"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("previousLink")) {
      previousLink = _json["previousLink"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (itemsPerPage != null) {
      _json["itemsPerPage"] = itemsPerPage;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (previousLink != null) {
      _json["previousLink"] = previousLink;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/**
 * Child link for this web property. Points to the list of views (profiles) for
 * this web property.
 */
class WebpropertyChildLink {
  /** Link to the list of views (profiles) for this web property. */
  core.String href;
  /** Type of the parent link. Its value is "analytics#profiles". */
  core.String type;

  WebpropertyChildLink();

  WebpropertyChildLink.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (href != null) {
      _json["href"] = href;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * Parent link for this web property. Points to the account to which this web
 * property belongs.
 */
class WebpropertyParentLink {
  /** Link to the account for this web property. */
  core.String href;
  /** Type of the parent link. Its value is "analytics#account". */
  core.String type;

  WebpropertyParentLink();

  WebpropertyParentLink.fromJson(core.Map _json) {
    if (_json.containsKey("href")) {
      href = _json["href"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (href != null) {
      _json["href"] = href;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Permissions the user has for this web property. */
class WebpropertyPermissions {
  /**
   * All the permissions that the user has for this web property. These include
   * any implied permissions (e.g., EDIT implies VIEW) or inherited permissions
   * from the parent account.
   */
  core.List<core.String> effective;

  WebpropertyPermissions();

  WebpropertyPermissions.fromJson(core.Map _json) {
    if (_json.containsKey("effective")) {
      effective = _json["effective"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (effective != null) {
      _json["effective"] = effective;
    }
    return _json;
  }
}

/** JSON template for an Analytics web property. */
class Webproperty {
  /** Account ID to which this web property belongs. */
  core.String accountId;
  /**
   * Child link for this web property. Points to the list of views (profiles)
   * for this web property.
   */
  WebpropertyChildLink childLink;
  /** Time this web property was created. */
  core.DateTime created;
  /** Default view (profile) ID. */
  core.String defaultProfileId;
  /** Web property ID of the form UA-XXXXX-YY. */
  core.String id;
  /** The industry vertical/category selected for this web property. */
  core.String industryVertical;
  /** Internal ID for this web property. */
  core.String internalWebPropertyId;
  /** Resource type for Analytics WebProperty. */
  core.String kind;
  /** Level for this web property. Possible values are STANDARD or PREMIUM. */
  core.String level;
  /** Name of this web property. */
  core.String name;
  /**
   * Parent link for this web property. Points to the account to which this web
   * property belongs.
   */
  WebpropertyParentLink parentLink;
  /** Permissions the user has for this web property. */
  WebpropertyPermissions permissions;
  /** View (Profile) count for this web property. */
  core.int profileCount;
  /** Link for this web property. */
  core.String selfLink;
  /** Indicates whether this web property is starred or not. */
  core.bool starred;
  /** Time this web property was last modified. */
  core.DateTime updated;
  /** Website url for this web property. */
  core.String websiteUrl;

  Webproperty();

  Webproperty.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("childLink")) {
      childLink = new WebpropertyChildLink.fromJson(_json["childLink"]);
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("defaultProfileId")) {
      defaultProfileId = _json["defaultProfileId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("industryVertical")) {
      industryVertical = _json["industryVertical"];
    }
    if (_json.containsKey("internalWebPropertyId")) {
      internalWebPropertyId = _json["internalWebPropertyId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("level")) {
      level = _json["level"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parentLink")) {
      parentLink = new WebpropertyParentLink.fromJson(_json["parentLink"]);
    }
    if (_json.containsKey("permissions")) {
      permissions = new WebpropertyPermissions.fromJson(_json["permissions"]);
    }
    if (_json.containsKey("profileCount")) {
      profileCount = _json["profileCount"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("starred")) {
      starred = _json["starred"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("websiteUrl")) {
      websiteUrl = _json["websiteUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (childLink != null) {
      _json["childLink"] = (childLink).toJson();
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (defaultProfileId != null) {
      _json["defaultProfileId"] = defaultProfileId;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (industryVertical != null) {
      _json["industryVertical"] = industryVertical;
    }
    if (internalWebPropertyId != null) {
      _json["internalWebPropertyId"] = internalWebPropertyId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (level != null) {
      _json["level"] = level;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parentLink != null) {
      _json["parentLink"] = (parentLink).toJson();
    }
    if (permissions != null) {
      _json["permissions"] = (permissions).toJson();
    }
    if (profileCount != null) {
      _json["profileCount"] = profileCount;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (starred != null) {
      _json["starred"] = starred;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (websiteUrl != null) {
      _json["websiteUrl"] = websiteUrl;
    }
    return _json;
  }
}
