// This is a generated file (see the discoveryapis_generator project).

library googleapis.partners.v2;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client partners/v2';

/**
 * Lets advertisers search certified companies and create contact leads with
 * them, and also audits the usage of clients.
 */
class PartnersApi {

  final commons.ApiRequester _requester;

  ClientMessagesResourceApi get clientMessages => new ClientMessagesResourceApi(_requester);
  CompaniesResourceApi get companies => new CompaniesResourceApi(_requester);
  UserEventsResourceApi get userEvents => new UserEventsResourceApi(_requester);
  UserStatesResourceApi get userStates => new UserStatesResourceApi(_requester);

  PartnersApi(http.Client client, {core.String rootUrl: "https://partners.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ClientMessagesResourceApi {
  final commons.ApiRequester _requester;

  ClientMessagesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Logs a generic message from the client, such as `Failed to render
   * component`, `Profile page is running slow`, `More than 500 users have
   * accessed this result.`, etc.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [LogMessageResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LogMessageResponse> log(LogMessageRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v2/clientMessages:log';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LogMessageResponse.fromJson(data));
  }

}


class CompaniesResourceApi {
  final commons.ApiRequester _requester;

  CompaniesLeadsResourceApi get leads => new CompaniesLeadsResourceApi(_requester);

  CompaniesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets a company.
   *
   * Request parameters:
   *
   * [companyId] - The ID of the company to retrieve.
   *
   * [requestMetadata_userOverrides_ipAddress] - IP address to use instead of
   * the user's geo-located IP address.
   *
   * [requestMetadata_userOverrides_userId] - Logged-in user ID to impersonate
   * instead of the user's ID.
   *
   * [requestMetadata_locale] - Locale to use for the current request.
   *
   * [requestMetadata_partnersSessionId] - Google Partners session ID.
   *
   * [requestMetadata_experimentIds] - Experiment IDs the current request
   * belongs to.
   *
   * [requestMetadata_trafficSource_trafficSourceId] - Identifier to indicate
   * where the traffic comes from. An identifier has multiple letters created by
   * a team which redirected the traffic to us.
   *
   * [requestMetadata_trafficSource_trafficSubId] - Second level identifier to
   * indicate where the traffic comes from. An identifier has multiple letters
   * created by a team which redirected the traffic to us.
   *
   * [view] - The view of `Company` resource to be returned. This must not be
   * `COMPANY_VIEW_UNSPECIFIED`.
   * Possible string values are:
   * - "COMPANY_VIEW_UNSPECIFIED" : A COMPANY_VIEW_UNSPECIFIED.
   * - "CV_GOOGLE_PARTNER_SEARCH" : A CV_GOOGLE_PARTNER_SEARCH.
   *
   * [orderBy] - How to order addresses within the returned company. Currently,
   * only `address` and `address desc` is supported which will sorted by closest
   * to farthest in distance from given address and farthest to closest distance
   * from given address respectively.
   *
   * [currencyCode] - If the company's budget is in a different currency code
   * than this one, then the converted budget is converted to this currency
   * code.
   *
   * [address] - The address to use for sorting the company's addresses by
   * proximity. If not given, the geo-located address of the request is used.
   * Used when order_by is set.
   *
   * Completes with a [GetCompanyResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetCompanyResponse> get(core.String companyId, {core.String requestMetadata_userOverrides_ipAddress, core.String requestMetadata_userOverrides_userId, core.String requestMetadata_locale, core.String requestMetadata_partnersSessionId, core.List<core.String> requestMetadata_experimentIds, core.String requestMetadata_trafficSource_trafficSourceId, core.String requestMetadata_trafficSource_trafficSubId, core.String view, core.String orderBy, core.String currencyCode, core.String address}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (companyId == null) {
      throw new core.ArgumentError("Parameter companyId is required.");
    }
    if (requestMetadata_userOverrides_ipAddress != null) {
      _queryParams["requestMetadata.userOverrides.ipAddress"] = [requestMetadata_userOverrides_ipAddress];
    }
    if (requestMetadata_userOverrides_userId != null) {
      _queryParams["requestMetadata.userOverrides.userId"] = [requestMetadata_userOverrides_userId];
    }
    if (requestMetadata_locale != null) {
      _queryParams["requestMetadata.locale"] = [requestMetadata_locale];
    }
    if (requestMetadata_partnersSessionId != null) {
      _queryParams["requestMetadata.partnersSessionId"] = [requestMetadata_partnersSessionId];
    }
    if (requestMetadata_experimentIds != null) {
      _queryParams["requestMetadata.experimentIds"] = requestMetadata_experimentIds;
    }
    if (requestMetadata_trafficSource_trafficSourceId != null) {
      _queryParams["requestMetadata.trafficSource.trafficSourceId"] = [requestMetadata_trafficSource_trafficSourceId];
    }
    if (requestMetadata_trafficSource_trafficSubId != null) {
      _queryParams["requestMetadata.trafficSource.trafficSubId"] = [requestMetadata_trafficSource_trafficSubId];
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (currencyCode != null) {
      _queryParams["currencyCode"] = [currencyCode];
    }
    if (address != null) {
      _queryParams["address"] = [address];
    }

    _url = 'v2/companies/' + commons.Escaper.ecapeVariable('$companyId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetCompanyResponse.fromJson(data));
  }

  /**
   * Lists companies.
   *
   * Request parameters:
   *
   * [requestMetadata_userOverrides_ipAddress] - IP address to use instead of
   * the user's geo-located IP address.
   *
   * [requestMetadata_userOverrides_userId] - Logged-in user ID to impersonate
   * instead of the user's ID.
   *
   * [requestMetadata_locale] - Locale to use for the current request.
   *
   * [requestMetadata_partnersSessionId] - Google Partners session ID.
   *
   * [requestMetadata_experimentIds] - Experiment IDs the current request
   * belongs to.
   *
   * [requestMetadata_trafficSource_trafficSourceId] - Identifier to indicate
   * where the traffic comes from. An identifier has multiple letters created by
   * a team which redirected the traffic to us.
   *
   * [requestMetadata_trafficSource_trafficSubId] - Second level identifier to
   * indicate where the traffic comes from. An identifier has multiple letters
   * created by a team which redirected the traffic to us.
   *
   * [pageSize] - Requested page size. Server may return fewer companies than
   * requested. If unspecified, server picks an appropriate default.
   *
   * [pageToken] - A token identifying a page of results that the server
   * returns. Typically, this is the value of
   * `ListCompaniesResponse.next_page_token` returned from the previous call to
   * ListCompanies.
   *
   * [companyName] - Company name to search for.
   *
   * [view] - The view of the `Company` resource to be returned. This must not
   * be `COMPANY_VIEW_UNSPECIFIED`.
   * Possible string values are:
   * - "COMPANY_VIEW_UNSPECIFIED" : A COMPANY_VIEW_UNSPECIFIED.
   * - "CV_GOOGLE_PARTNER_SEARCH" : A CV_GOOGLE_PARTNER_SEARCH.
   *
   * [minMonthlyBudget_currencyCode] - The 3-letter currency code defined in ISO
   * 4217.
   *
   * [minMonthlyBudget_units] - The whole units of the amount. For example if
   * `currencyCode` is `"USD"`, then 1 unit is one US dollar.
   *
   * [minMonthlyBudget_nanos] - Number of nano (10^-9) units of the amount. The
   * value must be between -999,999,999 and +999,999,999 inclusive. If `units`
   * is positive, `nanos` must be positive or zero. If `units` is zero, `nanos`
   * can be positive, zero, or negative. If `units` is negative, `nanos` must be
   * negative or zero. For example $-1.75 is represented as `units`=-1 and
   * `nanos`=-750,000,000.
   *
   * [maxMonthlyBudget_currencyCode] - The 3-letter currency code defined in ISO
   * 4217.
   *
   * [maxMonthlyBudget_units] - The whole units of the amount. For example if
   * `currencyCode` is `"USD"`, then 1 unit is one US dollar.
   *
   * [maxMonthlyBudget_nanos] - Number of nano (10^-9) units of the amount. The
   * value must be between -999,999,999 and +999,999,999 inclusive. If `units`
   * is positive, `nanos` must be positive or zero. If `units` is zero, `nanos`
   * can be positive, zero, or negative. If `units` is negative, `nanos` must be
   * negative or zero. For example $-1.75 is represented as `units`=-1 and
   * `nanos`=-750,000,000.
   *
   * [industries] - List of industries the company can help with.
   *
   * [services] - List of services the company can help with.
   *
   * [languageCodes] - List of language codes that company can support. Only
   * primary language subtags are accepted as defined by BCP 47 (IETF BCP 47,
   * "Tags for Identifying Languages").
   *
   * [address] - The address to use when searching for companies. If not given,
   * the geo-located address of the request is used.
   *
   * [orderBy] - How to order addresses within the returned companies.
   * Currently, only `address` and `address desc` is supported which will sorted
   * by closest to farthest in distance from given address and farthest to
   * closest distance from given address respectively.
   *
   * [gpsMotivations] - List of reasons for using Google Partner Search to get
   * companies.
   *
   * [websiteUrl] - Website URL that will help to find a better matched company.
   * .
   *
   * Completes with a [ListCompaniesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListCompaniesResponse> list({core.String requestMetadata_userOverrides_ipAddress, core.String requestMetadata_userOverrides_userId, core.String requestMetadata_locale, core.String requestMetadata_partnersSessionId, core.List<core.String> requestMetadata_experimentIds, core.String requestMetadata_trafficSource_trafficSourceId, core.String requestMetadata_trafficSource_trafficSubId, core.int pageSize, core.String pageToken, core.String companyName, core.String view, core.String minMonthlyBudget_currencyCode, core.String minMonthlyBudget_units, core.int minMonthlyBudget_nanos, core.String maxMonthlyBudget_currencyCode, core.String maxMonthlyBudget_units, core.int maxMonthlyBudget_nanos, core.List<core.String> industries, core.List<core.String> services, core.List<core.String> languageCodes, core.String address, core.String orderBy, core.List<core.String> gpsMotivations, core.String websiteUrl}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (requestMetadata_userOverrides_ipAddress != null) {
      _queryParams["requestMetadata.userOverrides.ipAddress"] = [requestMetadata_userOverrides_ipAddress];
    }
    if (requestMetadata_userOverrides_userId != null) {
      _queryParams["requestMetadata.userOverrides.userId"] = [requestMetadata_userOverrides_userId];
    }
    if (requestMetadata_locale != null) {
      _queryParams["requestMetadata.locale"] = [requestMetadata_locale];
    }
    if (requestMetadata_partnersSessionId != null) {
      _queryParams["requestMetadata.partnersSessionId"] = [requestMetadata_partnersSessionId];
    }
    if (requestMetadata_experimentIds != null) {
      _queryParams["requestMetadata.experimentIds"] = requestMetadata_experimentIds;
    }
    if (requestMetadata_trafficSource_trafficSourceId != null) {
      _queryParams["requestMetadata.trafficSource.trafficSourceId"] = [requestMetadata_trafficSource_trafficSourceId];
    }
    if (requestMetadata_trafficSource_trafficSubId != null) {
      _queryParams["requestMetadata.trafficSource.trafficSubId"] = [requestMetadata_trafficSource_trafficSubId];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (companyName != null) {
      _queryParams["companyName"] = [companyName];
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }
    if (minMonthlyBudget_currencyCode != null) {
      _queryParams["minMonthlyBudget.currencyCode"] = [minMonthlyBudget_currencyCode];
    }
    if (minMonthlyBudget_units != null) {
      _queryParams["minMonthlyBudget.units"] = [minMonthlyBudget_units];
    }
    if (minMonthlyBudget_nanos != null) {
      _queryParams["minMonthlyBudget.nanos"] = ["${minMonthlyBudget_nanos}"];
    }
    if (maxMonthlyBudget_currencyCode != null) {
      _queryParams["maxMonthlyBudget.currencyCode"] = [maxMonthlyBudget_currencyCode];
    }
    if (maxMonthlyBudget_units != null) {
      _queryParams["maxMonthlyBudget.units"] = [maxMonthlyBudget_units];
    }
    if (maxMonthlyBudget_nanos != null) {
      _queryParams["maxMonthlyBudget.nanos"] = ["${maxMonthlyBudget_nanos}"];
    }
    if (industries != null) {
      _queryParams["industries"] = industries;
    }
    if (services != null) {
      _queryParams["services"] = services;
    }
    if (languageCodes != null) {
      _queryParams["languageCodes"] = languageCodes;
    }
    if (address != null) {
      _queryParams["address"] = [address];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (gpsMotivations != null) {
      _queryParams["gpsMotivations"] = gpsMotivations;
    }
    if (websiteUrl != null) {
      _queryParams["websiteUrl"] = [websiteUrl];
    }

    _url = 'v2/companies';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListCompaniesResponse.fromJson(data));
  }

}


class CompaniesLeadsResourceApi {
  final commons.ApiRequester _requester;

  CompaniesLeadsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates an advertiser lead for the given company ID.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [companyId] - The ID of the company to contact.
   *
   * Completes with a [CreateLeadResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreateLeadResponse> create(CreateLeadRequest request, core.String companyId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (companyId == null) {
      throw new core.ArgumentError("Parameter companyId is required.");
    }

    _url = 'v2/companies/' + commons.Escaper.ecapeVariable('$companyId') + '/leads';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreateLeadResponse.fromJson(data));
  }

}


class UserEventsResourceApi {
  final commons.ApiRequester _requester;

  UserEventsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Logs a user event.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [LogUserEventResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LogUserEventResponse> log(LogUserEventRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v2/userEvents:log';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LogUserEventResponse.fromJson(data));
  }

}


class UserStatesResourceApi {
  final commons.ApiRequester _requester;

  UserStatesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists states for current user.
   *
   * Request parameters:
   *
   * [requestMetadata_userOverrides_ipAddress] - IP address to use instead of
   * the user's geo-located IP address.
   *
   * [requestMetadata_userOverrides_userId] - Logged-in user ID to impersonate
   * instead of the user's ID.
   *
   * [requestMetadata_locale] - Locale to use for the current request.
   *
   * [requestMetadata_partnersSessionId] - Google Partners session ID.
   *
   * [requestMetadata_experimentIds] - Experiment IDs the current request
   * belongs to.
   *
   * [requestMetadata_trafficSource_trafficSourceId] - Identifier to indicate
   * where the traffic comes from. An identifier has multiple letters created by
   * a team which redirected the traffic to us.
   *
   * [requestMetadata_trafficSource_trafficSubId] - Second level identifier to
   * indicate where the traffic comes from. An identifier has multiple letters
   * created by a team which redirected the traffic to us.
   *
   * Completes with a [ListUserStatesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListUserStatesResponse> list({core.String requestMetadata_userOverrides_ipAddress, core.String requestMetadata_userOverrides_userId, core.String requestMetadata_locale, core.String requestMetadata_partnersSessionId, core.List<core.String> requestMetadata_experimentIds, core.String requestMetadata_trafficSource_trafficSourceId, core.String requestMetadata_trafficSource_trafficSubId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (requestMetadata_userOverrides_ipAddress != null) {
      _queryParams["requestMetadata.userOverrides.ipAddress"] = [requestMetadata_userOverrides_ipAddress];
    }
    if (requestMetadata_userOverrides_userId != null) {
      _queryParams["requestMetadata.userOverrides.userId"] = [requestMetadata_userOverrides_userId];
    }
    if (requestMetadata_locale != null) {
      _queryParams["requestMetadata.locale"] = [requestMetadata_locale];
    }
    if (requestMetadata_partnersSessionId != null) {
      _queryParams["requestMetadata.partnersSessionId"] = [requestMetadata_partnersSessionId];
    }
    if (requestMetadata_experimentIds != null) {
      _queryParams["requestMetadata.experimentIds"] = requestMetadata_experimentIds;
    }
    if (requestMetadata_trafficSource_trafficSourceId != null) {
      _queryParams["requestMetadata.trafficSource.trafficSourceId"] = [requestMetadata_trafficSource_trafficSourceId];
    }
    if (requestMetadata_trafficSource_trafficSubId != null) {
      _queryParams["requestMetadata.trafficSource.trafficSubId"] = [requestMetadata_trafficSource_trafficSubId];
    }

    _url = 'v2/userStates';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListUserStatesResponse.fromJson(data));
  }

}



/** Status for a Google Partners certification exam. */
class CertificationExamStatus {
  /** The number of people who have passed the certification exam. */
  core.int numberUsersPass;
  /**
   * The type of certification exam.
   * Possible string values are:
   * - "CERTIFICATION_EXAM_TYPE_UNSPECIFIED" : A
   * CERTIFICATION_EXAM_TYPE_UNSPECIFIED.
   * - "CET_ADWORDS_ADVANCED_SEARCH" : A CET_ADWORDS_ADVANCED_SEARCH.
   * - "CET_ADWORDS_ADVANCED_DISPLAY" : A CET_ADWORDS_ADVANCED_DISPLAY.
   * - "CET_VIDEO_ADS" : A CET_VIDEO_ADS.
   * - "CET_ANALYTICS" : A CET_ANALYTICS.
   * - "CET_DOUBLECLICK" : A CET_DOUBLECLICK.
   * - "CET_SHOPPING" : A CET_SHOPPING.
   * - "CET_MOBILE" : A CET_MOBILE.
   */
  core.String type;

  CertificationExamStatus();

  CertificationExamStatus.fromJson(core.Map _json) {
    if (_json.containsKey("numberUsersPass")) {
      numberUsersPass = _json["numberUsersPass"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (numberUsersPass != null) {
      _json["numberUsersPass"] = numberUsersPass;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Google Partners certification status. */
class CertificationStatus {
  /** List of certification exam statuses. */
  core.List<CertificationExamStatus> examStatuses;
  /** Whether certification is passing. */
  core.bool isCertified;
  /**
   * The type of the certification.
   * Possible string values are:
   * - "CERTIFICATION_TYPE_UNSPECIFIED" : A CERTIFICATION_TYPE_UNSPECIFIED.
   * - "CT_ADWORDS" : A CT_ADWORDS.
   * - "CT_YOUTUBE" : A CT_YOUTUBE.
   * - "CT_VIDEOADS" : A CT_VIDEOADS.
   * - "CT_ANALYTICS" : A CT_ANALYTICS.
   * - "CT_DOUBLECLICK" : A CT_DOUBLECLICK.
   * - "CT_SHOPPING" : A CT_SHOPPING.
   * - "CT_MOBILE" : A CT_MOBILE.
   */
  core.String type;

  CertificationStatus();

  CertificationStatus.fromJson(core.Map _json) {
    if (_json.containsKey("examStatuses")) {
      examStatuses = _json["examStatuses"].map((value) => new CertificationExamStatus.fromJson(value)).toList();
    }
    if (_json.containsKey("isCertified")) {
      isCertified = _json["isCertified"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (examStatuses != null) {
      _json["examStatuses"] = examStatuses.map((value) => (value).toJson()).toList();
    }
    if (isCertified != null) {
      _json["isCertified"] = isCertified;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * A company resource in the Google Partners API. Once certified, it qualifies
 * for being searched by advertisers.
 */
class Company {
  /** The list of Google Partners certification statuses for the company. */
  core.List<CertificationStatus> certificationStatuses;
  /**
   * The minimum monthly budget that the company accepts for partner business,
   * converted to the requested currency code.
   */
  Money convertedMinMonthlyBudget;
  /** The ID of the company. */
  core.String id;
  /** Industries the company can help with. */
  core.List<core.String> industries;
  /** The list of localized info for the company. */
  core.List<LocalizedCompanyInfo> localizedInfos;
  /** The list of company locations. */
  core.List<Location> locations;
  /** The name of the company. */
  core.String name;
  /**
   * The unconverted minimum monthly budget that the company accepts for partner
   * business.
   */
  Money originalMinMonthlyBudget;
  /** Basic information from the company's public profile. */
  PublicProfile publicProfile;
  /**
   * Information related to the ranking of the company within the list of
   * companies.
   */
  core.List<Rank> ranks;
  /** Services the company can help with. */
  core.List<core.String> services;
  /** URL of the company's website. */
  core.String websiteUrl;

  Company();

  Company.fromJson(core.Map _json) {
    if (_json.containsKey("certificationStatuses")) {
      certificationStatuses = _json["certificationStatuses"].map((value) => new CertificationStatus.fromJson(value)).toList();
    }
    if (_json.containsKey("convertedMinMonthlyBudget")) {
      convertedMinMonthlyBudget = new Money.fromJson(_json["convertedMinMonthlyBudget"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("industries")) {
      industries = _json["industries"];
    }
    if (_json.containsKey("localizedInfos")) {
      localizedInfos = _json["localizedInfos"].map((value) => new LocalizedCompanyInfo.fromJson(value)).toList();
    }
    if (_json.containsKey("locations")) {
      locations = _json["locations"].map((value) => new Location.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("originalMinMonthlyBudget")) {
      originalMinMonthlyBudget = new Money.fromJson(_json["originalMinMonthlyBudget"]);
    }
    if (_json.containsKey("publicProfile")) {
      publicProfile = new PublicProfile.fromJson(_json["publicProfile"]);
    }
    if (_json.containsKey("ranks")) {
      ranks = _json["ranks"].map((value) => new Rank.fromJson(value)).toList();
    }
    if (_json.containsKey("services")) {
      services = _json["services"];
    }
    if (_json.containsKey("websiteUrl")) {
      websiteUrl = _json["websiteUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (certificationStatuses != null) {
      _json["certificationStatuses"] = certificationStatuses.map((value) => (value).toJson()).toList();
    }
    if (convertedMinMonthlyBudget != null) {
      _json["convertedMinMonthlyBudget"] = (convertedMinMonthlyBudget).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (industries != null) {
      _json["industries"] = industries;
    }
    if (localizedInfos != null) {
      _json["localizedInfos"] = localizedInfos.map((value) => (value).toJson()).toList();
    }
    if (locations != null) {
      _json["locations"] = locations.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (originalMinMonthlyBudget != null) {
      _json["originalMinMonthlyBudget"] = (originalMinMonthlyBudget).toJson();
    }
    if (publicProfile != null) {
      _json["publicProfile"] = (publicProfile).toJson();
    }
    if (ranks != null) {
      _json["ranks"] = ranks.map((value) => (value).toJson()).toList();
    }
    if (services != null) {
      _json["services"] = services;
    }
    if (websiteUrl != null) {
      _json["websiteUrl"] = websiteUrl;
    }
    return _json;
  }
}

/** Request message for CreateLead. */
class CreateLeadRequest {
  /**
   * The lead resource. The `LeadType` must not be `LEAD_TYPE_UNSPECIFIED` and
   * either `email` or `phone_number` must be provided.
   */
  Lead lead;
  /** reCaptcha challenge info. */
  RecaptchaChallenge recaptchaChallenge;
  /** Current request metadata. */
  RequestMetadata requestMetadata;

  CreateLeadRequest();

  CreateLeadRequest.fromJson(core.Map _json) {
    if (_json.containsKey("lead")) {
      lead = new Lead.fromJson(_json["lead"]);
    }
    if (_json.containsKey("recaptchaChallenge")) {
      recaptchaChallenge = new RecaptchaChallenge.fromJson(_json["recaptchaChallenge"]);
    }
    if (_json.containsKey("requestMetadata")) {
      requestMetadata = new RequestMetadata.fromJson(_json["requestMetadata"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lead != null) {
      _json["lead"] = (lead).toJson();
    }
    if (recaptchaChallenge != null) {
      _json["recaptchaChallenge"] = (recaptchaChallenge).toJson();
    }
    if (requestMetadata != null) {
      _json["requestMetadata"] = (requestMetadata).toJson();
    }
    return _json;
  }
}

/** Response message for CreateLead. Debug information about this request. */
class CreateLeadResponse {
  /**
   * Lead that was created depending on the outcome of reCaptcha validation.
   */
  Lead lead;
  /**
   * The outcome of reCaptcha validation.
   * Possible string values are:
   * - "RECAPTCHA_STATUS_UNSPECIFIED" : A RECAPTCHA_STATUS_UNSPECIFIED.
   * - "RS_NOT_NEEDED" : A RS_NOT_NEEDED.
   * - "RS_PASSED" : A RS_PASSED.
   * - "RS_FAILED" : A RS_FAILED.
   */
  core.String recaptchaStatus;
  /** Current response metadata. */
  ResponseMetadata responseMetadata;

  CreateLeadResponse();

  CreateLeadResponse.fromJson(core.Map _json) {
    if (_json.containsKey("lead")) {
      lead = new Lead.fromJson(_json["lead"]);
    }
    if (_json.containsKey("recaptchaStatus")) {
      recaptchaStatus = _json["recaptchaStatus"];
    }
    if (_json.containsKey("responseMetadata")) {
      responseMetadata = new ResponseMetadata.fromJson(_json["responseMetadata"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lead != null) {
      _json["lead"] = (lead).toJson();
    }
    if (recaptchaStatus != null) {
      _json["recaptchaStatus"] = recaptchaStatus;
    }
    if (responseMetadata != null) {
      _json["responseMetadata"] = (responseMetadata).toJson();
    }
    return _json;
  }
}

/** Debug information about this request. */
class DebugInfo {
  /** Info about the server that serviced this request. */
  core.String serverInfo;
  /** Server-side debug stack trace. */
  core.String serverTraceInfo;
  /** URL of the service that handled this request. */
  core.String serviceUrl;

  DebugInfo();

  DebugInfo.fromJson(core.Map _json) {
    if (_json.containsKey("serverInfo")) {
      serverInfo = _json["serverInfo"];
    }
    if (_json.containsKey("serverTraceInfo")) {
      serverTraceInfo = _json["serverTraceInfo"];
    }
    if (_json.containsKey("serviceUrl")) {
      serviceUrl = _json["serviceUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (serverInfo != null) {
      _json["serverInfo"] = serverInfo;
    }
    if (serverTraceInfo != null) {
      _json["serverTraceInfo"] = serverTraceInfo;
    }
    if (serviceUrl != null) {
      _json["serviceUrl"] = serviceUrl;
    }
    return _json;
  }
}

/** Key value data pair for an event. */
class EventData {
  /**
   * Data type.
   * Possible string values are:
   * - "EVENT_DATA_TYPE_UNSPECIFIED" : A EVENT_DATA_TYPE_UNSPECIFIED.
   * - "ACTION" : A ACTION.
   * - "AGENCY_ID" : A AGENCY_ID.
   * - "AGENCY_NAME" : A AGENCY_NAME.
   * - "AGENCY_PHONE_NUMBER" : A AGENCY_PHONE_NUMBER.
   * - "AGENCY_WEBSITE" : A AGENCY_WEBSITE.
   * - "BUDGET" : A BUDGET.
   * - "CENTER_POINT" : A CENTER_POINT.
   * - "CERTIFICATION" : A CERTIFICATION.
   * - "COMMENT" : A COMMENT.
   * - "COUNTRY" : A COUNTRY.
   * - "CURRENCY" : A CURRENCY.
   * - "CURRENTLY_VIEWED_AGENCY_ID" : A CURRENTLY_VIEWED_AGENCY_ID.
   * - "DISTANCE" : A DISTANCE.
   * - "DISTANCE_TYPE" : A DISTANCE_TYPE.
   * - "EXAM" : A EXAM.
   * - "HISTORY_TOKEN" : A HISTORY_TOKEN.
   * - "IDENTIFIER" : A IDENTIFIER.
   * - "INDUSTRY" : A INDUSTRY.
   * - "INSIGHT_TAG" : A INSIGHT_TAG.
   * - "LANGUAGE" : A LANGUAGE.
   * - "LOCATION" : A LOCATION.
   * - "MARKETING_OPT_IN" : A MARKETING_OPT_IN.
   * - "QUERY" : A QUERY.
   * - "SEARCH_START_INDEX" : A SEARCH_START_INDEX.
   * - "SERVICE" : A SERVICE.
   * - "SHOW_VOW" : A SHOW_VOW.
   * - "SOLUTION" : A SOLUTION.
   * - "TRAFFIC_SOURCE_ID" : A TRAFFIC_SOURCE_ID.
   * - "TRAFFIC_SUB_ID" : A TRAFFIC_SUB_ID.
   * - "VIEW_PORT" : A VIEW_PORT.
   * - "WEBSITE" : A WEBSITE.
   * - "DETAILS" : A DETAILS.
   * - "EXPERIMENT_ID" : A EXPERIMENT_ID.
   * - "GPS_MOTIVATION" : A GPS_MOTIVATION.
   * - "URL" : A URL.
   * - "ELEMENT_FOCUS" : A ELEMENT_FOCUS.
   * - "PROGRESS" : A PROGRESS.
   */
  core.String key;
  /** Data values. */
  core.List<core.String> values;

  EventData();

  EventData.fromJson(core.Map _json) {
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("values")) {
      values = _json["values"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (key != null) {
      _json["key"] = key;
    }
    if (values != null) {
      _json["values"] = values;
    }
    return _json;
  }
}

/** Response message for GetCompany. */
class GetCompanyResponse {
  /** The company. */
  Company company;
  /** Current response metadata. */
  ResponseMetadata responseMetadata;

  GetCompanyResponse();

  GetCompanyResponse.fromJson(core.Map _json) {
    if (_json.containsKey("company")) {
      company = new Company.fromJson(_json["company"]);
    }
    if (_json.containsKey("responseMetadata")) {
      responseMetadata = new ResponseMetadata.fromJson(_json["responseMetadata"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (company != null) {
      _json["company"] = (company).toJson();
    }
    if (responseMetadata != null) {
      _json["responseMetadata"] = (responseMetadata).toJson();
    }
    return _json;
  }
}

/**
 * An object representing a latitude/longitude pair. This is expressed as a pair
 * of doubles representing degrees latitude and degrees longitude. Unless
 * specified otherwise, this must conform to the WGS84 standard. Values must be
 * within normalized ranges. Example of normalization code in Python: def
 * NormalizeLongitude(longitude): """Wrapsdecimal degrees longitude to [-180.0,
 * 180.0].""" q, r = divmod(longitude, 360.0) if r > 180.0 or (r == 180.0 and q
 * <= -1.0): return r - 360.0 return r def NormalizeLatLng(latitude, longitude):
 * """Wraps decimal degrees latitude and longitude to [-180.0, 180.0] and
 * [-90.0, 90.0], respectively.""" r = latitude % 360.0 if r = 270.0: return r -
 * 360, NormalizeLongitude(longitude) else: return 180 - r,
 * NormalizeLongitude(longitude + 180.0) assert 180.0 ==
 * NormalizeLongitude(180.0) assert -180.0 == NormalizeLongitude(-180.0) assert
 * -179.0 == NormalizeLongitude(181.0) assert (0.0, 0.0) ==
 * NormalizeLatLng(360.0, 0.0) assert (0.0, 0.0) == NormalizeLatLng(-360.0, 0.0)
 * assert (85.0, 180.0) == NormalizeLatLng(95.0, 0.0) assert (-85.0, -170.0) ==
 * NormalizeLatLng(-95.0, 10.0) assert (90.0, 10.0) == NormalizeLatLng(90.0,
 * 10.0) assert (-90.0, -10.0) == NormalizeLatLng(-90.0, -10.0) assert (0.0,
 * -170.0) == NormalizeLatLng(-180.0, 10.0) assert (0.0, -170.0) ==
 * NormalizeLatLng(180.0, 10.0) assert (-90.0, 10.0) == NormalizeLatLng(270.0,
 * 10.0) assert (90.0, 10.0) == NormalizeLatLng(-270.0, 10.0)
 */
class LatLng {
  /** The latitude in degrees. It must be in the range [-90.0, +90.0]. */
  core.double latitude;
  /** The longitude in degrees. It must be in the range [-180.0, +180.0]. */
  core.double longitude;

  LatLng();

  LatLng.fromJson(core.Map _json) {
    if (_json.containsKey("latitude")) {
      latitude = _json["latitude"];
    }
    if (_json.containsKey("longitude")) {
      longitude = _json["longitude"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (latitude != null) {
      _json["latitude"] = latitude;
    }
    if (longitude != null) {
      _json["longitude"] = longitude;
    }
    return _json;
  }
}

/**
 * A lead resource that represents an advertiser contact for a `Company`. These
 * are usually generated via Google Partner Search (the advertiser portal).
 */
class Lead {
  /** Comments lead source gave. */
  core.String comments;
  /** Email address of lead source. */
  core.String email;
  /** Last name of lead source. */
  core.String familyName;
  /** First name of lead source. */
  core.String givenName;
  /** List of reasons for using Google Partner Search and creating a lead. */
  core.List<core.String> gpsMotivations;
  /** ID of the lead. */
  core.String id;
  /** The minimum monthly budget lead source is willing to spend. */
  Money minMonthlyBudget;
  /** Phone number of lead source. */
  core.String phoneNumber;
  /**
   * Type of lead.
   * Possible string values are:
   * - "LEAD_TYPE_UNSPECIFIED" : A LEAD_TYPE_UNSPECIFIED.
   * - "LT_GPS" : A LT_GPS.
   */
  core.String type;
  /** Website URL of lead source. */
  core.String websiteUrl;

  Lead();

  Lead.fromJson(core.Map _json) {
    if (_json.containsKey("comments")) {
      comments = _json["comments"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("familyName")) {
      familyName = _json["familyName"];
    }
    if (_json.containsKey("givenName")) {
      givenName = _json["givenName"];
    }
    if (_json.containsKey("gpsMotivations")) {
      gpsMotivations = _json["gpsMotivations"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("minMonthlyBudget")) {
      minMonthlyBudget = new Money.fromJson(_json["minMonthlyBudget"]);
    }
    if (_json.containsKey("phoneNumber")) {
      phoneNumber = _json["phoneNumber"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("websiteUrl")) {
      websiteUrl = _json["websiteUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (comments != null) {
      _json["comments"] = comments;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (familyName != null) {
      _json["familyName"] = familyName;
    }
    if (givenName != null) {
      _json["givenName"] = givenName;
    }
    if (gpsMotivations != null) {
      _json["gpsMotivations"] = gpsMotivations;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (minMonthlyBudget != null) {
      _json["minMonthlyBudget"] = (minMonthlyBudget).toJson();
    }
    if (phoneNumber != null) {
      _json["phoneNumber"] = phoneNumber;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (websiteUrl != null) {
      _json["websiteUrl"] = websiteUrl;
    }
    return _json;
  }
}

/** Response message for ListCompanies. */
class ListCompaniesResponse {
  /** The list of companies. */
  core.List<Company> companies;
  /**
   * A token to retrieve next page of results. Pass this value in the
   * `ListCompaniesRequest.page_token` field in the subsequent call to
   * ListCompanies to retrieve the next page of results.
   */
  core.String nextPageToken;
  /** Current response metadata. */
  ResponseMetadata responseMetadata;

  ListCompaniesResponse();

  ListCompaniesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("companies")) {
      companies = _json["companies"].map((value) => new Company.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("responseMetadata")) {
      responseMetadata = new ResponseMetadata.fromJson(_json["responseMetadata"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (companies != null) {
      _json["companies"] = companies.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (responseMetadata != null) {
      _json["responseMetadata"] = (responseMetadata).toJson();
    }
    return _json;
  }
}

/** Response message for ListUserStates. */
class ListUserStatesResponse {
  /** Current response metadata. */
  ResponseMetadata responseMetadata;
  /** User's states. */
  core.List<core.String> userStates;

  ListUserStatesResponse();

  ListUserStatesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("responseMetadata")) {
      responseMetadata = new ResponseMetadata.fromJson(_json["responseMetadata"]);
    }
    if (_json.containsKey("userStates")) {
      userStates = _json["userStates"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (responseMetadata != null) {
      _json["responseMetadata"] = (responseMetadata).toJson();
    }
    if (userStates != null) {
      _json["userStates"] = userStates;
    }
    return _json;
  }
}

/** The localized company information. */
class LocalizedCompanyInfo {
  /** List of country codes for the localized company info. */
  core.List<core.String> countryCodes;
  /** Localized display name. */
  core.String displayName;
  /**
   * Language code of the localized company info, as defined by BCP 47 (IETF BCP
   * 47, "Tags for Identifying Languages").
   */
  core.String languageCode;
  /**
   * Localized brief description that the company uses to advertise themselves.
   */
  core.String overview;

  LocalizedCompanyInfo();

  LocalizedCompanyInfo.fromJson(core.Map _json) {
    if (_json.containsKey("countryCodes")) {
      countryCodes = _json["countryCodes"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("languageCode")) {
      languageCode = _json["languageCode"];
    }
    if (_json.containsKey("overview")) {
      overview = _json["overview"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (countryCodes != null) {
      _json["countryCodes"] = countryCodes;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (languageCode != null) {
      _json["languageCode"] = languageCode;
    }
    if (overview != null) {
      _json["overview"] = overview;
    }
    return _json;
  }
}

/** A location with address and geographic coordinates. */
class Location {
  /** The complete address of the location. */
  core.String address;
  /** The latitude and longitude of the location, in degrees. */
  LatLng latLng;

  Location();

  Location.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = _json["address"];
    }
    if (_json.containsKey("latLng")) {
      latLng = new LatLng.fromJson(_json["latLng"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (address != null) {
      _json["address"] = address;
    }
    if (latLng != null) {
      _json["latLng"] = (latLng).toJson();
    }
    return _json;
  }
}

/** Request message for LogClientMessage. */
class LogMessageRequest {
  /**
   * Map of client info, such as URL, browser navigator, browser platform, etc.
   */
  core.Map<core.String, core.String> clientInfo;
  /** Details about the client message. */
  core.String details;
  /**
   * Message level of client message.
   * Possible string values are:
   * - "MESSAGE_LEVEL_UNSPECIFIED" : A MESSAGE_LEVEL_UNSPECIFIED.
   * - "ML_FINE" : A ML_FINE.
   * - "ML_INFO" : A ML_INFO.
   * - "ML_WARNING" : A ML_WARNING.
   * - "ML_SEVERE" : A ML_SEVERE.
   */
  core.String level;
  /** Current request metadata. */
  RequestMetadata requestMetadata;

  LogMessageRequest();

  LogMessageRequest.fromJson(core.Map _json) {
    if (_json.containsKey("clientInfo")) {
      clientInfo = _json["clientInfo"];
    }
    if (_json.containsKey("details")) {
      details = _json["details"];
    }
    if (_json.containsKey("level")) {
      level = _json["level"];
    }
    if (_json.containsKey("requestMetadata")) {
      requestMetadata = new RequestMetadata.fromJson(_json["requestMetadata"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clientInfo != null) {
      _json["clientInfo"] = clientInfo;
    }
    if (details != null) {
      _json["details"] = details;
    }
    if (level != null) {
      _json["level"] = level;
    }
    if (requestMetadata != null) {
      _json["requestMetadata"] = (requestMetadata).toJson();
    }
    return _json;
  }
}

/** Response message for LogClientMessage. */
class LogMessageResponse {
  /** Current response metadata. */
  ResponseMetadata responseMetadata;

  LogMessageResponse();

  LogMessageResponse.fromJson(core.Map _json) {
    if (_json.containsKey("responseMetadata")) {
      responseMetadata = new ResponseMetadata.fromJson(_json["responseMetadata"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (responseMetadata != null) {
      _json["responseMetadata"] = (responseMetadata).toJson();
    }
    return _json;
  }
}

/** Request message for LogUserEvent. */
class LogUserEventRequest {
  /**
   * The action that occurred.
   * Possible string values are:
   * - "EVENT_ACTION_UNSPECIFIED" : A EVENT_ACTION_UNSPECIFIED.
   * - "SMB_CLICKED_FIND_A_PARTNER_BUTTON_BOTTOM" : A
   * SMB_CLICKED_FIND_A_PARTNER_BUTTON_BOTTOM.
   * - "SMB_CLICKED_FIND_A_PARTNER_BUTTON_TOP" : A
   * SMB_CLICKED_FIND_A_PARTNER_BUTTON_TOP.
   * - "AGENCY_CLICKED_JOIN_NOW_BUTTON_BOTTOM" : A
   * AGENCY_CLICKED_JOIN_NOW_BUTTON_BOTTOM.
   * - "AGENCY_CLICKED_JOIN_NOW_BUTTON_TOP" : A
   * AGENCY_CLICKED_JOIN_NOW_BUTTON_TOP.
   * - "SMB_CANCELED_PARTNER_CONTACT_FORM" : A
   * SMB_CANCELED_PARTNER_CONTACT_FORM.
   * - "SMB_CLICKED_CONTACT_A_PARTNER" : A SMB_CLICKED_CONTACT_A_PARTNER.
   * - "SMB_COMPLETED_PARTNER_CONTACT_FORM" : A
   * SMB_COMPLETED_PARTNER_CONTACT_FORM.
   * - "SMB_ENTERED_EMAIL_IN_CONTACT_PARTNER_FORM" : A
   * SMB_ENTERED_EMAIL_IN_CONTACT_PARTNER_FORM.
   * - "SMB_ENTERED_NAME_IN_CONTACT_PARTNER_FORM" : A
   * SMB_ENTERED_NAME_IN_CONTACT_PARTNER_FORM.
   * - "SMB_ENTERED_PHONE_IN_CONTACT_PARTNER_FORM" : A
   * SMB_ENTERED_PHONE_IN_CONTACT_PARTNER_FORM.
   * - "SMB_FAILED_RECAPTCHA_IN_CONTACT_PARTNER_FORM" : A
   * SMB_FAILED_RECAPTCHA_IN_CONTACT_PARTNER_FORM.
   * - "PARTNER_VIEWED_BY_SMB" : A PARTNER_VIEWED_BY_SMB.
   * - "SMB_CANCELED_PARTNER_CONTACT_FORM_ON_GPS" : A
   * SMB_CANCELED_PARTNER_CONTACT_FORM_ON_GPS.
   * - "SMB_CHANGED_A_SEARCH_PARAMETER_TOP" : A
   * SMB_CHANGED_A_SEARCH_PARAMETER_TOP.
   * - "SMB_CLICKED_CONTACT_A_PARTNER_ON_GPS" : A
   * SMB_CLICKED_CONTACT_A_PARTNER_ON_GPS.
   * - "SMB_CLICKED_SHOW_MORE_PARTNERS_BUTTON_BOTTOM" : A
   * SMB_CLICKED_SHOW_MORE_PARTNERS_BUTTON_BOTTOM.
   * - "SMB_COMPLETED_PARTNER_CONTACT_FORM_ON_GPS" : A
   * SMB_COMPLETED_PARTNER_CONTACT_FORM_ON_GPS.
   * - "SMB_NO_PARTNERS_AVAILABLE_WITH_SEARCH_CRITERIA" : A
   * SMB_NO_PARTNERS_AVAILABLE_WITH_SEARCH_CRITERIA.
   * - "SMB_PERFORMED_SEARCH_ON_GPS" : A SMB_PERFORMED_SEARCH_ON_GPS.
   * - "SMB_VIEWED_A_PARTNER_ON_GPS" : A SMB_VIEWED_A_PARTNER_ON_GPS.
   * - "SMB_CANCELED_PARTNER_CONTACT_FORM_ON_PROFILE_PAGE" : A
   * SMB_CANCELED_PARTNER_CONTACT_FORM_ON_PROFILE_PAGE.
   * - "SMB_CLICKED_CONTACT_A_PARTNER_ON_PROFILE_PAGE" : A
   * SMB_CLICKED_CONTACT_A_PARTNER_ON_PROFILE_PAGE.
   * - "SMB_CLICKED_PARTNER_WEBSITE" : A SMB_CLICKED_PARTNER_WEBSITE.
   * - "SMB_COMPLETED_PARTNER_CONTACT_FORM_ON_PROFILE_PAGE" : A
   * SMB_COMPLETED_PARTNER_CONTACT_FORM_ON_PROFILE_PAGE.
   * - "SMB_VIEWED_A_PARTNER_PROFILE" : A SMB_VIEWED_A_PARTNER_PROFILE.
   * - "AGENCY_CLICKED_ACCEPT_TOS_BUTTON" : A AGENCY_CLICKED_ACCEPT_TOS_BUTTON.
   * - "AGENCY_CHANGED_TOS_COUNTRY" : A AGENCY_CHANGED_TOS_COUNTRY.
   * - "AGENCY_ADDED_ADDRESS_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_ADDED_ADDRESS_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_ADDED_PHONE_NUMBER_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_ADDED_PHONE_NUMBER_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_CHANGED_PRIMARY_ACCOUNT_ASSOCIATION" : A
   * AGENCY_CHANGED_PRIMARY_ACCOUNT_ASSOCIATION.
   * - "AGENCY_CHANGED_PRIMARY_COUNTRY_ASSOCIATION" : A
   * AGENCY_CHANGED_PRIMARY_COUNTRY_ASSOCIATION.
   * - "AGENCY_CLICKED_AFFILIATE_BUTTON_IN_MY_PROFILE_IN_PORTAL" : A
   * AGENCY_CLICKED_AFFILIATE_BUTTON_IN_MY_PROFILE_IN_PORTAL.
   * - "AGENCY_CLICKED_GIVE_EDIT_ACCESS_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_CLICKED_GIVE_EDIT_ACCESS_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_CLICKED_LOG_OUT_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_CLICKED_LOG_OUT_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_CLICKED_MY_PROFILE_LEFT_NAV_IN_PORTAL" : A
   * AGENCY_CLICKED_MY_PROFILE_LEFT_NAV_IN_PORTAL.
   * - "AGENCY_CLICKED_SAVE_AND_CONTINUE_AT_BOT_OF_COMPLETE_PROFILE" : A
   * AGENCY_CLICKED_SAVE_AND_CONTINUE_AT_BOT_OF_COMPLETE_PROFILE.
   * - "AGENCY_CLICKED_UNAFFILIATE_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_CLICKED_UNAFFILIATE_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_FILLED_OUT_COMP_AFFILIATION_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_FILLED_OUT_COMP_AFFILIATION_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_SUCCESSFULLY_CONNECTED_WITH_COMPANY_IN_MY_PROFILE" : A
   * AGENCY_SUCCESSFULLY_CONNECTED_WITH_COMPANY_IN_MY_PROFILE.
   * - "AGENCY_CLICKED_CREATE_MCC_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_CLICKED_CREATE_MCC_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_DIDNT_HAVE_AN_MCC_ASSOCIATED_ON_COMPLETE_PROFILE" : A
   * AGENCY_DIDNT_HAVE_AN_MCC_ASSOCIATED_ON_COMPLETE_PROFILE.
   * - "AGENCY_HAD_AN_MCC_ASSOCIATED_ON_COMPLETE_PROFILE" : A
   * AGENCY_HAD_AN_MCC_ASSOCIATED_ON_COMPLETE_PROFILE.
   * - "AGENCY_ADDED_JOB_FUNCTION_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_ADDED_JOB_FUNCTION_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_LOOKED_AT_JOB_FUNCTION_DROP_DOWN" : A
   * AGENCY_LOOKED_AT_JOB_FUNCTION_DROP_DOWN.
   * - "AGENCY_SELECTED_ACCOUNT_MANAGER_AS_JOB_FUNCTION" : A
   * AGENCY_SELECTED_ACCOUNT_MANAGER_AS_JOB_FUNCTION.
   * - "AGENCY_SELECTED_ACCOUNT_PLANNER_AS_JOB_FUNCTION" : A
   * AGENCY_SELECTED_ACCOUNT_PLANNER_AS_JOB_FUNCTION.
   * - "AGENCY_SELECTED_ANALYTICS_AS_JOB_FUNCTION" : A
   * AGENCY_SELECTED_ANALYTICS_AS_JOB_FUNCTION.
   * - "AGENCY_SELECTED_CREATIVE_AS_JOB_FUNCTION" : A
   * AGENCY_SELECTED_CREATIVE_AS_JOB_FUNCTION.
   * - "AGENCY_SELECTED_MEDIA_BUYER_AS_JOB_FUNCTION" : A
   * AGENCY_SELECTED_MEDIA_BUYER_AS_JOB_FUNCTION.
   * - "AGENCY_SELECTED_MEDIA_PLANNER_AS_JOB_FUNCTION" : A
   * AGENCY_SELECTED_MEDIA_PLANNER_AS_JOB_FUNCTION.
   * - "AGENCY_SELECTED_OTHER_AS_JOB_FUNCTION" : A
   * AGENCY_SELECTED_OTHER_AS_JOB_FUNCTION.
   * - "AGENCY_SELECTED_PRODUCTION_AS_JOB_FUNCTION" : A
   * AGENCY_SELECTED_PRODUCTION_AS_JOB_FUNCTION.
   * - "AGENCY_SELECTED_SEO_AS_JOB_FUNCTION" : A
   * AGENCY_SELECTED_SEO_AS_JOB_FUNCTION.
   * - "AGENCY_SELECTED_SALES_REP_AS_JOB_FUNCTION" : A
   * AGENCY_SELECTED_SALES_REP_AS_JOB_FUNCTION.
   * - "AGENCY_SELECTED_SEARCH_SPECIALIST_AS_JOB_FUNCTION" : A
   * AGENCY_SELECTED_SEARCH_SPECIALIST_AS_JOB_FUNCTION.
   * - "AGENCY_ADDED_CHANNELS_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_ADDED_CHANNELS_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_LOOKED_AT_ADD_CHANNEL_DROP_DOWN" : A
   * AGENCY_LOOKED_AT_ADD_CHANNEL_DROP_DOWN.
   * - "AGENCY_SELECTED_CROSS_CHANNEL_FROM_ADD_CHANNEL" : A
   * AGENCY_SELECTED_CROSS_CHANNEL_FROM_ADD_CHANNEL.
   * - "AGENCY_SELECTED_DISPLAY_FROM_ADD_CHANNEL" : A
   * AGENCY_SELECTED_DISPLAY_FROM_ADD_CHANNEL.
   * - "AGENCY_SELECTED_MOBILE_FROM_ADD_CHANNEL" : A
   * AGENCY_SELECTED_MOBILE_FROM_ADD_CHANNEL.
   * - "AGENCY_SELECTED_SEARCH_FROM_ADD_CHANNEL" : A
   * AGENCY_SELECTED_SEARCH_FROM_ADD_CHANNEL.
   * - "AGENCY_SELECTED_SOCIAL_FROM_ADD_CHANNEL" : A
   * AGENCY_SELECTED_SOCIAL_FROM_ADD_CHANNEL.
   * - "AGENCY_SELECTED_TOOLS_FROM_ADD_CHANNEL" : A
   * AGENCY_SELECTED_TOOLS_FROM_ADD_CHANNEL.
   * - "AGENCY_SELECTED_YOUTUBE_FROM_ADD_CHANNEL" : A
   * AGENCY_SELECTED_YOUTUBE_FROM_ADD_CHANNEL.
   * - "AGENCY_ADDED_INDUSTRIES_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_ADDED_INDUSTRIES_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_CHANGED_ADD_INDUSTRIES_DROP_DOWN" : A
   * AGENCY_CHANGED_ADD_INDUSTRIES_DROP_DOWN.
   * - "AGENCY_ADDED_MARKETS_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_ADDED_MARKETS_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_CHANGED_ADD_MARKETS_DROP_DOWN" : A
   * AGENCY_CHANGED_ADD_MARKETS_DROP_DOWN.
   * - "AGENCY_CHECKED_RECIEVE_MAIL_PROMOTIONS_MYPROFILE" : A
   * AGENCY_CHECKED_RECIEVE_MAIL_PROMOTIONS_MYPROFILE.
   * - "AGENCY_CHECKED_RECIEVE_MAIL_PROMOTIONS_SIGNUP" : A
   * AGENCY_CHECKED_RECIEVE_MAIL_PROMOTIONS_SIGNUP.
   * - "AGENCY_SELECTED_OPT_IN_BETA_TESTS_AND_MKT_RESEARCH" : A
   * AGENCY_SELECTED_OPT_IN_BETA_TESTS_AND_MKT_RESEARCH.
   * - "AGENCY_SELECTED_OPT_IN_BETA_TESTS_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_SELECTED_OPT_IN_BETA_TESTS_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_SELECTED_OPT_IN_NEWS_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_SELECTED_OPT_IN_NEWS_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_SELECTED_OPT_IN_NEWS_INVITATIONS_AND_PROMOS" : A
   * AGENCY_SELECTED_OPT_IN_NEWS_INVITATIONS_AND_PROMOS.
   * - "AGENCY_SELECTED_OPT_IN_PERFORMANCE_SUG_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_SELECTED_OPT_IN_PERFORMANCE_SUG_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_SELECTED_OPT_IN_PERFORMANCE_SUGGESTIONS" : A
   * AGENCY_SELECTED_OPT_IN_PERFORMANCE_SUGGESTIONS.
   * - "AGENCY_SELECTED_OPT_IN_SELECT_ALL_EMAIL_NOTIFICATIONS" : A
   * AGENCY_SELECTED_OPT_IN_SELECT_ALL_EMAIL_NOTIFICATIONS.
   * - "AGENCY_SELECTED_SELECT_ALL_OPT_INS_IN_MY_PROFILE_PORTAL" : A
   * AGENCY_SELECTED_SELECT_ALL_OPT_INS_IN_MY_PROFILE_PORTAL.
   * - "AGENCY_CLICKED_BACK_BUTTON_ON_CONNECT_WITH_COMPANY" : A
   * AGENCY_CLICKED_BACK_BUTTON_ON_CONNECT_WITH_COMPANY.
   * - "AGENCY_CLICKED_CONTINUE_TO_OVERVIEW_ON_CONNECT_WITH_COMPANY" : A
   * AGENCY_CLICKED_CONTINUE_TO_OVERVIEW_ON_CONNECT_WITH_COMPANY.
   * - "AGECNY_CLICKED_CREATE_MCC_CONNECT_WITH_COMPANY_NOT_FOUND" : A
   * AGECNY_CLICKED_CREATE_MCC_CONNECT_WITH_COMPANY_NOT_FOUND.
   * - "AGECNY_CLICKED_GIVE_EDIT_ACCESS_CONNECT_WITH_COMPANY_NOT_FOUND" : A
   * AGECNY_CLICKED_GIVE_EDIT_ACCESS_CONNECT_WITH_COMPANY_NOT_FOUND.
   * - "AGECNY_CLICKED_LOG_OUT_CONNECT_WITH_COMPANY_NOT_FOUND" : A
   * AGECNY_CLICKED_LOG_OUT_CONNECT_WITH_COMPANY_NOT_FOUND.
   * - "AGENCY_CLICKED_SKIP_FOR_NOW_ON_CONNECT_WITH_COMPANY_PAGE" : A
   * AGENCY_CLICKED_SKIP_FOR_NOW_ON_CONNECT_WITH_COMPANY_PAGE.
   * - "AGENCY_CLOSED_CONNECTED_TO_COMPANY_X_BUTTON_WRONG_COMPANY" : A
   * AGENCY_CLOSED_CONNECTED_TO_COMPANY_X_BUTTON_WRONG_COMPANY.
   * - "AGENCY_COMPLETED_FIELD_CONNECT_WITH_COMPANY" : A
   * AGENCY_COMPLETED_FIELD_CONNECT_WITH_COMPANY.
   * - "AGECNY_FOUND_COMPANY_TO_CONNECT_WITH" : A
   * AGECNY_FOUND_COMPANY_TO_CONNECT_WITH.
   * - "AGENCY_SUCCESSFULLY_CREATED_COMPANY" : A
   * AGENCY_SUCCESSFULLY_CREATED_COMPANY.
   * - "AGENCY_ADDED_NEW_COMPANY_LOCATION" : A
   * AGENCY_ADDED_NEW_COMPANY_LOCATION.
   * - "AGENCY_CLICKED_COMMUNITY_JOIN_NOW_LINK_IN_PORTAL_NOTIFICATIONS" : A
   * AGENCY_CLICKED_COMMUNITY_JOIN_NOW_LINK_IN_PORTAL_NOTIFICATIONS.
   * - "AGENCY_CLICKED_CONNECT_TO_COMPANY_LINK_IN_PORTAL_NOTIFICATIONS" : A
   * AGENCY_CLICKED_CONNECT_TO_COMPANY_LINK_IN_PORTAL_NOTIFICATIONS.
   * - "AGENCY_CLICKED_GET_CERTIFIED_LINK_IN_PORTAL_NOTIFICATIONS" : A
   * AGENCY_CLICKED_GET_CERTIFIED_LINK_IN_PORTAL_NOTIFICATIONS.
   * - "AGENCY_CLICKED_GET_VIDEO_ADS_CERTIFIED_LINK_IN_PORTAL_NOTIFICATIONS" : A
   * AGENCY_CLICKED_GET_VIDEO_ADS_CERTIFIED_LINK_IN_PORTAL_NOTIFICATIONS.
   * - "AGENCY_CLICKED_LINK_TO_MCC_LINK_IN_PORTAL_NOTIFICATIONS" : A
   * AGENCY_CLICKED_LINK_TO_MCC_LINK_IN_PORTAL_NOTIFICATIONS.
   * - "AGENCY_CLICKED_INSIGHT_CONTENT_IN_PORTAL" : A
   * AGENCY_CLICKED_INSIGHT_CONTENT_IN_PORTAL.
   * - "AGENCY_CLICKED_INSIGHTS_VIEW_NOW_PITCH_DECKS_IN_PORTAL" : A
   * AGENCY_CLICKED_INSIGHTS_VIEW_NOW_PITCH_DECKS_IN_PORTAL.
   * - "AGENCY_CLICKED_INSIGHTS_LEFT_NAV_IN_PORTAL" : A
   * AGENCY_CLICKED_INSIGHTS_LEFT_NAV_IN_PORTAL.
   * - "AGENCY_CLICKED_INSIGHTS_UPLOAD_CONTENT" : A
   * AGENCY_CLICKED_INSIGHTS_UPLOAD_CONTENT.
   * - "AGENCY_CLICKED_INSIGHTS_VIEWED_DEPRECATED" : A
   * AGENCY_CLICKED_INSIGHTS_VIEWED_DEPRECATED.
   * - "AGENCY_CLICKED_COMMUNITY_LEFT_NAV_IN_PORTAL" : A
   * AGENCY_CLICKED_COMMUNITY_LEFT_NAV_IN_PORTAL.
   * - "AGENCY_CLICKED_JOIN_COMMUNITY_BUTTON_COMMUNITY_PORTAL" : A
   * AGENCY_CLICKED_JOIN_COMMUNITY_BUTTON_COMMUNITY_PORTAL.
   * - "AGENCY_CLICKED_CERTIFICATIONS_LEFT_NAV_IN_PORTAL" : A
   * AGENCY_CLICKED_CERTIFICATIONS_LEFT_NAV_IN_PORTAL.
   * - "AGENCY_CLICKED_CERTIFICATIONS_PRODUCT_LEFT_NAV_IN_PORTAL" : A
   * AGENCY_CLICKED_CERTIFICATIONS_PRODUCT_LEFT_NAV_IN_PORTAL.
   * - "AGENCY_CLICKED_PARTNER_STATUS_LEFT_NAV_IN_PORTAL" : A
   * AGENCY_CLICKED_PARTNER_STATUS_LEFT_NAV_IN_PORTAL.
   * - "AGENCY_CLICKED_PARTNER_STATUS_PRODUCT_LEFT_NAV_IN_PORTAL" : A
   * AGENCY_CLICKED_PARTNER_STATUS_PRODUCT_LEFT_NAV_IN_PORTAL.
   * - "AGENCY_CLICKED_OFFERS_LEFT_NAV_IN_PORTAL" : A
   * AGENCY_CLICKED_OFFERS_LEFT_NAV_IN_PORTAL.
   * - "AGENCY_CLICKED_SEND_BUTTON_ON_OFFERS_PAGE" : A
   * AGENCY_CLICKED_SEND_BUTTON_ON_OFFERS_PAGE.
   * - "AGENCY_CLICKED_EXAM_DETAILS_ON_CERT_ADWORDS_PAGE" : A
   * AGENCY_CLICKED_EXAM_DETAILS_ON_CERT_ADWORDS_PAGE.
   * - "AGENCY_CLICKED_SEE_EXAMS_CERTIFICATION_MAIN_PAGE" : A
   * AGENCY_CLICKED_SEE_EXAMS_CERTIFICATION_MAIN_PAGE.
   * - "AGENCY_CLICKED_TAKE_EXAM_ON_CERT_EXAM_PAGE" : A
   * AGENCY_CLICKED_TAKE_EXAM_ON_CERT_EXAM_PAGE.
   * - "AGENCY_OPENED_LAST_ADMIN_DIALOG" : A AGENCY_OPENED_LAST_ADMIN_DIALOG.
   * - "AGENCY_OPENED_DIALOG_WITH_NO_USERS" : A
   * AGENCY_OPENED_DIALOG_WITH_NO_USERS.
   * - "AGENCY_PROMOTED_USER_TO_ADMIN" : A AGENCY_PROMOTED_USER_TO_ADMIN.
   * - "AGENCY_UNAFFILIATED" : A AGENCY_UNAFFILIATED.
   * - "AGENCY_CHANGED_ROLES" : A AGENCY_CHANGED_ROLES.
   * - "SMB_CLICKED_COMPANY_NAME_LINK_TO_PROFILE" : A
   * SMB_CLICKED_COMPANY_NAME_LINK_TO_PROFILE.
   * - "SMB_VIEWED_ADWORDS_CERTIFICATE" : A SMB_VIEWED_ADWORDS_CERTIFICATE.
   * - "SMB_CLICKED_ADWORDS_CERTIFICATE_HELP_ICON" : A
   * SMB_CLICKED_ADWORDS_CERTIFICATE_HELP_ICON.
   * - "SMB_VIEWED_ANALYTICS_CERTIFICATE" : A SMB_VIEWED_ANALYTICS_CERTIFICATE.
   * - "SMB_VIEWED_DOUBLECLICK_CERTIFICATE" : A
   * SMB_VIEWED_DOUBLECLICK_CERTIFICATE.
   * - "SMB_VIEWED_VIDEO_ADS_CERTIFICATE" : A SMB_VIEWED_VIDEO_ADS_CERTIFICATE.
   * - "SMB_VIEWED_SHOPPING_CERTIFICATE" : A SMB_VIEWED_SHOPPING_CERTIFICATE.
   * - "SMB_CLICKED_VIDEO_ADS_CERTIFICATE_HELP_ICON" : A
   * SMB_CLICKED_VIDEO_ADS_CERTIFICATE_HELP_ICON.
   * - "CLICKED_HELP_AT_BOTTOM" : A CLICKED_HELP_AT_BOTTOM.
   * - "CLICKED_HELP_AT_TOP" : A CLICKED_HELP_AT_TOP.
   * - "CLIENT_ERROR" : A CLIENT_ERROR.
   * - "AGENCY_CLICKED_LEFT_NAV_STORIES" : A AGENCY_CLICKED_LEFT_NAV_STORIES.
   * - "CLICKED" : A CLICKED.
   * - "SMB_VIEWED_MOBILE_CERTIFICATE" : A SMB_VIEWED_MOBILE_CERTIFICATE.
   * - "AGENCY_FAILED_COMPANY_VERIFICATION" : A
   * AGENCY_FAILED_COMPANY_VERIFICATION.
   * - "VISITED_LANDING" : A VISITED_LANDING.
   * - "VISITED_GPS" : A VISITED_GPS.
   * - "VISITED_AGENCY_PORTAL" : A VISITED_AGENCY_PORTAL.
   * - "CANCELLED_INDIVIDUAL_SIGN_UP" : A CANCELLED_INDIVIDUAL_SIGN_UP.
   * - "CANCELLED_COMPANY_SIGN_UP" : A CANCELLED_COMPANY_SIGN_UP.
   * - "AGENCY_CLICKED_SIGN_IN_BUTTON_TOP" : A
   * AGENCY_CLICKED_SIGN_IN_BUTTON_TOP.
   * - "AGENCY_CLICKED_SAVE_AND_CONTINUE_AT_BOT_OF_INCOMPLETE_PROFILE" : A
   * AGENCY_CLICKED_SAVE_AND_CONTINUE_AT_BOT_OF_INCOMPLETE_PROFILE.
   * - "AGENCY_UNSELECTED_OPT_IN_NEWS_INVITATIONS_AND_PROMOS" : A
   * AGENCY_UNSELECTED_OPT_IN_NEWS_INVITATIONS_AND_PROMOS.
   * - "AGENCY_UNSELECTED_OPT_IN_BETA_TESTS_AND_MKT_RESEARCH" : A
   * AGENCY_UNSELECTED_OPT_IN_BETA_TESTS_AND_MKT_RESEARCH.
   * - "AGENCY_UNSELECTED_OPT_IN_PERFORMANCE_SUGGESTIONS" : A
   * AGENCY_UNSELECTED_OPT_IN_PERFORMANCE_SUGGESTIONS.
   * - "AGENCY_SELECTED_OPT_OUT_UNSELECT_ALL_EMAIL_NOTIFICATIONS" : A
   * AGENCY_SELECTED_OPT_OUT_UNSELECT_ALL_EMAIL_NOTIFICATIONS.
   * - "AGENCY_LINKED_INDIVIDUAL_MCC" : A AGENCY_LINKED_INDIVIDUAL_MCC.
   * - "AGENCY_SUGGESTED_TO_USER" : A AGENCY_SUGGESTED_TO_USER.
   * - "AGENCY_IGNORED_SUGGESTED_AGENCIES_AND_SEARCHED" : A
   * AGENCY_IGNORED_SUGGESTED_AGENCIES_AND_SEARCHED.
   * - "AGENCY_PICKED_SUGGESTED_AGENCY" : A AGENCY_PICKED_SUGGESTED_AGENCY.
   * - "AGENCY_SEARCHED_FOR_AGENCIES" : A AGENCY_SEARCHED_FOR_AGENCIES.
   * - "AGENCY_PICKED_SEARCHED_AGENCY" : A AGENCY_PICKED_SEARCHED_AGENCY.
   * - "AGENCY_DISMISSED_AFFILIATION_WIDGET" : A
   * AGENCY_DISMISSED_AFFILIATION_WIDGET.
   * - "AGENCY_CLICKED_INSIGHTS_DOWNLOAD_CONTENT" : A
   * AGENCY_CLICKED_INSIGHTS_DOWNLOAD_CONTENT.
   * - "AGENCY_PROGRESS_INSIGHTS_VIEW_CONTENT" : A
   * AGENCY_PROGRESS_INSIGHTS_VIEW_CONTENT.
   * - "AGENCY_CLICKED_CANCEL_ACCEPT_TOS_BUTTON" : A
   * AGENCY_CLICKED_CANCEL_ACCEPT_TOS_BUTTON.
   * - "SMB_ENTERED_WEBSITE_IN_CONTACT_PARTNER_FORM" : A
   * SMB_ENTERED_WEBSITE_IN_CONTACT_PARTNER_FORM.
   */
  core.String eventAction;
  /**
   * The category the action belongs to.
   * Possible string values are:
   * - "EVENT_CATEGORY_UNSPECIFIED" : A EVENT_CATEGORY_UNSPECIFIED.
   * - "GOOGLE_PARTNER_SEARCH" : A GOOGLE_PARTNER_SEARCH.
   * - "GOOGLE_PARTNER_SIGNUP_FLOW" : A GOOGLE_PARTNER_SIGNUP_FLOW.
   * - "GOOGLE_PARTNER_PORTAL" : A GOOGLE_PARTNER_PORTAL.
   * - "GOOGLE_PARTNER_PORTAL_MY_PROFILE" : A GOOGLE_PARTNER_PORTAL_MY_PROFILE.
   * - "GOOGLE_PARTNER_PORTAL_CERTIFICATIONS" : A
   * GOOGLE_PARTNER_PORTAL_CERTIFICATIONS.
   * - "GOOGLE_PARTNER_PORTAL_COMMUNITY" : A GOOGLE_PARTNER_PORTAL_COMMUNITY.
   * - "GOOGLE_PARTNER_PORTAL_INSIGHTS" : A GOOGLE_PARTNER_PORTAL_INSIGHTS.
   * - "GOOGLE_PARTNER_PORTAL_CLIENTS" : A GOOGLE_PARTNER_PORTAL_CLIENTS.
   * - "GOOGLE_PARTNER_PUBLIC_USER_PROFILE" : A
   * GOOGLE_PARTNER_PUBLIC_USER_PROFILE.
   * - "GOOGLE_PARTNER_PANEL" : A GOOGLE_PARTNER_PANEL.
   * - "GOOGLE_PARTNER_PORTAL_LAST_ADMIN_DIALOG" : A
   * GOOGLE_PARTNER_PORTAL_LAST_ADMIN_DIALOG.
   * - "GOOGLE_PARTNER_CLIENT" : A GOOGLE_PARTNER_CLIENT.
   * - "GOOGLE_PARTNER_PORTAL_COMPANY_PROFILE" : A
   * GOOGLE_PARTNER_PORTAL_COMPANY_PROFILE.
   * - "EXTERNAL_LINKS" : A EXTERNAL_LINKS.
   * - "GOOGLE_PARTNER_LANDING" : A GOOGLE_PARTNER_LANDING.
   */
  core.String eventCategory;
  /** List of event data for the event. */
  core.List<EventData> eventDatas;
  /**
   * The scope of the event.
   * Possible string values are:
   * - "EVENT_SCOPE_UNSPECIFIED" : A EVENT_SCOPE_UNSPECIFIED.
   * - "VISITOR" : A VISITOR.
   * - "SESSION" : A SESSION.
   * - "PAGE" : A PAGE.
   */
  core.String eventScope;
  /** Advertiser lead information. */
  Lead lead;
  /** Current request metadata. */
  RequestMetadata requestMetadata;
  /** The URL where the event occurred. */
  core.String url;

  LogUserEventRequest();

  LogUserEventRequest.fromJson(core.Map _json) {
    if (_json.containsKey("eventAction")) {
      eventAction = _json["eventAction"];
    }
    if (_json.containsKey("eventCategory")) {
      eventCategory = _json["eventCategory"];
    }
    if (_json.containsKey("eventDatas")) {
      eventDatas = _json["eventDatas"].map((value) => new EventData.fromJson(value)).toList();
    }
    if (_json.containsKey("eventScope")) {
      eventScope = _json["eventScope"];
    }
    if (_json.containsKey("lead")) {
      lead = new Lead.fromJson(_json["lead"]);
    }
    if (_json.containsKey("requestMetadata")) {
      requestMetadata = new RequestMetadata.fromJson(_json["requestMetadata"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (eventAction != null) {
      _json["eventAction"] = eventAction;
    }
    if (eventCategory != null) {
      _json["eventCategory"] = eventCategory;
    }
    if (eventDatas != null) {
      _json["eventDatas"] = eventDatas.map((value) => (value).toJson()).toList();
    }
    if (eventScope != null) {
      _json["eventScope"] = eventScope;
    }
    if (lead != null) {
      _json["lead"] = (lead).toJson();
    }
    if (requestMetadata != null) {
      _json["requestMetadata"] = (requestMetadata).toJson();
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Response message for LogUserEvent. */
class LogUserEventResponse {
  /** Current response metadata. */
  ResponseMetadata responseMetadata;

  LogUserEventResponse();

  LogUserEventResponse.fromJson(core.Map _json) {
    if (_json.containsKey("responseMetadata")) {
      responseMetadata = new ResponseMetadata.fromJson(_json["responseMetadata"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (responseMetadata != null) {
      _json["responseMetadata"] = (responseMetadata).toJson();
    }
    return _json;
  }
}

/** Represents an amount of money with its currency type. */
class Money {
  /** The 3-letter currency code defined in ISO 4217. */
  core.String currencyCode;
  /**
   * Number of nano (10^-9) units of the amount. The value must be between
   * -999,999,999 and +999,999,999 inclusive. If `units` is positive, `nanos`
   * must be positive or zero. If `units` is zero, `nanos` can be positive,
   * zero, or negative. If `units` is negative, `nanos` must be negative or
   * zero. For example $-1.75 is represented as `units`=-1 and
   * `nanos`=-750,000,000.
   */
  core.int nanos;
  /**
   * The whole units of the amount. For example if `currencyCode` is `"USD"`,
   * then 1 unit is one US dollar.
   */
  core.String units;

  Money();

  Money.fromJson(core.Map _json) {
    if (_json.containsKey("currencyCode")) {
      currencyCode = _json["currencyCode"];
    }
    if (_json.containsKey("nanos")) {
      nanos = _json["nanos"];
    }
    if (_json.containsKey("units")) {
      units = _json["units"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currencyCode != null) {
      _json["currencyCode"] = currencyCode;
    }
    if (nanos != null) {
      _json["nanos"] = nanos;
    }
    if (units != null) {
      _json["units"] = units;
    }
    return _json;
  }
}

/** Basic information from a public profile. */
class PublicProfile {
  /** The URL to the main display image of the public profile. */
  core.String displayImageUrl;
  /** The display name of the public profile. */
  core.String displayName;
  /**
   * The ID which can be used to retrieve more details about the public profile.
   */
  core.String id;
  /** The URL of the public profile. */
  core.String url;

  PublicProfile();

  PublicProfile.fromJson(core.Map _json) {
    if (_json.containsKey("displayImageUrl")) {
      displayImageUrl = _json["displayImageUrl"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayImageUrl != null) {
      _json["displayImageUrl"] = displayImageUrl;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Information related to ranking of results. */
class Rank {
  /**
   * The type of rank.
   * Possible string values are:
   * - "RANK_TYPE_UNSPECIFIED" : A RANK_TYPE_UNSPECIFIED.
   * - "RT_FINAL_SCORE" : A RT_FINAL_SCORE.
   */
  core.String type;
  /** The numerical value of the rank. */
  core.double value;

  Rank();

  Rank.fromJson(core.Map _json) {
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

/** reCaptcha challenge info. */
class RecaptchaChallenge {
  /** The ID of the reCaptcha challenge. */
  core.String id;
  /** The response to the reCaptcha challenge. */
  core.String response;

  RecaptchaChallenge();

  RecaptchaChallenge.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("response")) {
      response = _json["response"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (response != null) {
      _json["response"] = response;
    }
    return _json;
  }
}

/** Common data that is in each API request. */
class RequestMetadata {
  /** Experiment IDs the current request belongs to. */
  core.List<core.String> experimentIds;
  /** Locale to use for the current request. */
  core.String locale;
  /** Google Partners session ID. */
  core.String partnersSessionId;
  /** Source of traffic for the current request. */
  TrafficSource trafficSource;
  /**
   * Values to use instead of the user's respective defaults for the current
   * request. These are only honored by whitelisted products.
   */
  UserOverrides userOverrides;

  RequestMetadata();

  RequestMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("experimentIds")) {
      experimentIds = _json["experimentIds"];
    }
    if (_json.containsKey("locale")) {
      locale = _json["locale"];
    }
    if (_json.containsKey("partnersSessionId")) {
      partnersSessionId = _json["partnersSessionId"];
    }
    if (_json.containsKey("trafficSource")) {
      trafficSource = new TrafficSource.fromJson(_json["trafficSource"]);
    }
    if (_json.containsKey("userOverrides")) {
      userOverrides = new UserOverrides.fromJson(_json["userOverrides"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (experimentIds != null) {
      _json["experimentIds"] = experimentIds;
    }
    if (locale != null) {
      _json["locale"] = locale;
    }
    if (partnersSessionId != null) {
      _json["partnersSessionId"] = partnersSessionId;
    }
    if (trafficSource != null) {
      _json["trafficSource"] = (trafficSource).toJson();
    }
    if (userOverrides != null) {
      _json["userOverrides"] = (userOverrides).toJson();
    }
    return _json;
  }
}

/** Common data that is in each API response. */
class ResponseMetadata {
  /** Debug information about this request. */
  DebugInfo debugInfo;

  ResponseMetadata();

  ResponseMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("debugInfo")) {
      debugInfo = new DebugInfo.fromJson(_json["debugInfo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (debugInfo != null) {
      _json["debugInfo"] = (debugInfo).toJson();
    }
    return _json;
  }
}

/** Source of traffic for the current request. */
class TrafficSource {
  /**
   * Identifier to indicate where the traffic comes from. An identifier has
   * multiple letters created by a team which redirected the traffic to us.
   */
  core.String trafficSourceId;
  /**
   * Second level identifier to indicate where the traffic comes from. An
   * identifier has multiple letters created by a team which redirected the
   * traffic to us.
   */
  core.String trafficSubId;

  TrafficSource();

  TrafficSource.fromJson(core.Map _json) {
    if (_json.containsKey("trafficSourceId")) {
      trafficSourceId = _json["trafficSourceId"];
    }
    if (_json.containsKey("trafficSubId")) {
      trafficSubId = _json["trafficSubId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (trafficSourceId != null) {
      _json["trafficSourceId"] = trafficSourceId;
    }
    if (trafficSubId != null) {
      _json["trafficSubId"] = trafficSubId;
    }
    return _json;
  }
}

/**
 * Values to use instead of the user's respective defaults. These are only
 * honored by whitelisted products.
 */
class UserOverrides {
  /** IP address to use instead of the user's geo-located IP address. */
  core.String ipAddress;
  /** Logged-in user ID to impersonate instead of the user's ID. */
  core.String userId;

  UserOverrides();

  UserOverrides.fromJson(core.Map _json) {
    if (_json.containsKey("ipAddress")) {
      ipAddress = _json["ipAddress"];
    }
    if (_json.containsKey("userId")) {
      userId = _json["userId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (ipAddress != null) {
      _json["ipAddress"] = ipAddress;
    }
    if (userId != null) {
      _json["userId"] = userId;
    }
    return _json;
  }
}
