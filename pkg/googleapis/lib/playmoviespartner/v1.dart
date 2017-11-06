// This is a generated file (see the discoveryapis_generator project).

library googleapis.playmoviespartner.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client playmoviespartner/v1';

/** Gets the delivery status of titles for Google Play Movies Partners. */
class PlaymoviespartnerApi {
  /** View the digital assets you publish on Google Play Movies and TV */
  static const PlaymoviesPartnerReadonlyScope = "https://www.googleapis.com/auth/playmovies_partner.readonly";


  final commons.ApiRequester _requester;

  AccountsResourceApi get accounts => new AccountsResourceApi(_requester);

  PlaymoviespartnerApi(http.Client client, {core.String rootUrl: "https://playmoviespartner.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AccountsResourceApi {
  final commons.ApiRequester _requester;

  AccountsAvailsResourceApi get avails => new AccountsAvailsResourceApi(_requester);
  AccountsOrdersResourceApi get orders => new AccountsOrdersResourceApi(_requester);
  AccountsStoreInfosResourceApi get storeInfos => new AccountsStoreInfosResourceApi(_requester);

  AccountsResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class AccountsAvailsResourceApi {
  final commons.ApiRequester _requester;

  AccountsAvailsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get an Avail given its avail group id and avail id.
   *
   * Request parameters:
   *
   * [accountId] - REQUIRED. See _General rules_ for more information about this
   * field.
   *
   * [availId] - REQUIRED. Avail ID.
   *
   * Completes with a [Avail].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Avail> get(core.String accountId, core.String availId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (availId == null) {
      throw new core.ArgumentError("Parameter availId is required.");
    }

    _url = 'v1/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/avails/' + commons.Escaper.ecapeVariable('$availId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Avail.fromJson(data));
  }

  /**
   * List Avails owned or managed by the partner. See _Authentication and
   * Authorization rules_ and _List methods rules_ for more information about
   * this method.
   *
   * Request parameters:
   *
   * [accountId] - REQUIRED. See _General rules_ for more information about this
   * field.
   *
   * [pageSize] - See _List methods rules_ for info about this field.
   *
   * [pageToken] - See _List methods rules_ for info about this field.
   *
   * [pphNames] - See _List methods rules_ for info about this field.
   *
   * [studioNames] - See _List methods rules_ for info about this field.
   *
   * [title] - Filter that matches Avails with a `title_internal_alias`,
   * `series_title_internal_alias`, `season_title_internal_alias`, or
   * `episode_title_internal_alias` that contains the given case-insensitive
   * title.
   *
   * [territories] - Filter Avails that match (case-insensitive) any of the
   * given country codes, using the "ISO 3166-1 alpha-2" format (examples: "US",
   * "us", "Us").
   *
   * [altId] - Filter Avails that match a case-insensitive, partner-specific
   * custom id. NOTE: this field is deprecated and will be removed on V2;
   * `alt_ids` should be used instead.
   *
   * [videoIds] - Filter Avails that match any of the given `video_id`s.
   *
   * [altIds] - Filter Avails that match (case-insensitive) any of the given
   * partner-specific custom ids.
   *
   * Completes with a [ListAvailsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListAvailsResponse> list(core.String accountId, {core.int pageSize, core.String pageToken, core.List<core.String> pphNames, core.List<core.String> studioNames, core.String title, core.List<core.String> territories, core.String altId, core.List<core.String> videoIds, core.List<core.String> altIds}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pphNames != null) {
      _queryParams["pphNames"] = pphNames;
    }
    if (studioNames != null) {
      _queryParams["studioNames"] = studioNames;
    }
    if (title != null) {
      _queryParams["title"] = [title];
    }
    if (territories != null) {
      _queryParams["territories"] = territories;
    }
    if (altId != null) {
      _queryParams["altId"] = [altId];
    }
    if (videoIds != null) {
      _queryParams["videoIds"] = videoIds;
    }
    if (altIds != null) {
      _queryParams["altIds"] = altIds;
    }

    _url = 'v1/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/avails';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListAvailsResponse.fromJson(data));
  }

}


class AccountsOrdersResourceApi {
  final commons.ApiRequester _requester;

  AccountsOrdersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get an Order given its id. See _Authentication and Authorization rules_ and
   * _Get methods rules_ for more information about this method.
   *
   * Request parameters:
   *
   * [accountId] - REQUIRED. See _General rules_ for more information about this
   * field.
   *
   * [orderId] - REQUIRED. Order ID.
   *
   * Completes with a [Order].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Order> get(core.String accountId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = 'v1/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId');

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
   * List Orders owned or managed by the partner. See _Authentication and
   * Authorization rules_ and _List methods rules_ for more information about
   * this method.
   *
   * Request parameters:
   *
   * [accountId] - REQUIRED. See _General rules_ for more information about this
   * field.
   *
   * [pageSize] - See _List methods rules_ for info about this field.
   *
   * [pageToken] - See _List methods rules_ for info about this field.
   *
   * [pphNames] - See _List methods rules_ for info about this field.
   *
   * [studioNames] - See _List methods rules_ for info about this field.
   *
   * [name] - Filter that matches Orders with a `name`, `show`, `season` or
   * `episode` that contains the given case-insensitive name.
   *
   * [status] - Filter Orders that match one of the given status.
   *
   * [customId] - Filter Orders that match a case-insensitive, partner-specific
   * custom id.
   *
   * [videoIds] - Filter Orders that match any of the given `video_id`s.
   *
   * Completes with a [ListOrdersResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListOrdersResponse> list(core.String accountId, {core.int pageSize, core.String pageToken, core.List<core.String> pphNames, core.List<core.String> studioNames, core.String name, core.List<core.String> status, core.String customId, core.List<core.String> videoIds}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pphNames != null) {
      _queryParams["pphNames"] = pphNames;
    }
    if (studioNames != null) {
      _queryParams["studioNames"] = studioNames;
    }
    if (name != null) {
      _queryParams["name"] = [name];
    }
    if (status != null) {
      _queryParams["status"] = status;
    }
    if (customId != null) {
      _queryParams["customId"] = [customId];
    }
    if (videoIds != null) {
      _queryParams["videoIds"] = videoIds;
    }

    _url = 'v1/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/orders';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListOrdersResponse.fromJson(data));
  }

}


class AccountsStoreInfosResourceApi {
  final commons.ApiRequester _requester;

  AccountsStoreInfosCountryResourceApi get country => new AccountsStoreInfosCountryResourceApi(_requester);

  AccountsStoreInfosResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List StoreInfos owned or managed by the partner. See _Authentication and
   * Authorization rules_ and _List methods rules_ for more information about
   * this method.
   *
   * Request parameters:
   *
   * [accountId] - REQUIRED. See _General rules_ for more information about this
   * field.
   *
   * [pageSize] - See _List methods rules_ for info about this field.
   *
   * [pageToken] - See _List methods rules_ for info about this field.
   *
   * [pphNames] - See _List methods rules_ for info about this field.
   *
   * [studioNames] - See _List methods rules_ for info about this field.
   *
   * [videoId] - Filter StoreInfos that match a given `video_id`. NOTE: this
   * field is deprecated and will be removed on V2; `video_ids` should be used
   * instead.
   *
   * [countries] - Filter StoreInfos that match (case-insensitive) any of the
   * given country codes, using the "ISO 3166-1 alpha-2" format (examples: "US",
   * "us", "Us").
   *
   * [name] - Filter that matches StoreInfos with a `name` or `show_name` that
   * contains the given case-insensitive name.
   *
   * [videoIds] - Filter StoreInfos that match any of the given `video_id`s.
   *
   * [mids] - Filter StoreInfos that match any of the given `mid`s.
   *
   * [seasonIds] - Filter StoreInfos that match any of the given `season_id`s.
   *
   * Completes with a [ListStoreInfosResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListStoreInfosResponse> list(core.String accountId, {core.int pageSize, core.String pageToken, core.List<core.String> pphNames, core.List<core.String> studioNames, core.String videoId, core.List<core.String> countries, core.String name, core.List<core.String> videoIds, core.List<core.String> mids, core.List<core.String> seasonIds}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pphNames != null) {
      _queryParams["pphNames"] = pphNames;
    }
    if (studioNames != null) {
      _queryParams["studioNames"] = studioNames;
    }
    if (videoId != null) {
      _queryParams["videoId"] = [videoId];
    }
    if (countries != null) {
      _queryParams["countries"] = countries;
    }
    if (name != null) {
      _queryParams["name"] = [name];
    }
    if (videoIds != null) {
      _queryParams["videoIds"] = videoIds;
    }
    if (mids != null) {
      _queryParams["mids"] = mids;
    }
    if (seasonIds != null) {
      _queryParams["seasonIds"] = seasonIds;
    }

    _url = 'v1/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/storeInfos';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListStoreInfosResponse.fromJson(data));
  }

}


class AccountsStoreInfosCountryResourceApi {
  final commons.ApiRequester _requester;

  AccountsStoreInfosCountryResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get a StoreInfo given its video id and country. See _Authentication and
   * Authorization rules_ and _Get methods rules_ for more information about
   * this method.
   *
   * Request parameters:
   *
   * [accountId] - REQUIRED. See _General rules_ for more information about this
   * field.
   *
   * [videoId] - REQUIRED. Video ID.
   *
   * [country] - REQUIRED. Edit country.
   *
   * Completes with a [StoreInfo].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<StoreInfo> get(core.String accountId, core.String videoId, core.String country) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (videoId == null) {
      throw new core.ArgumentError("Parameter videoId is required.");
    }
    if (country == null) {
      throw new core.ArgumentError("Parameter country is required.");
    }

    _url = 'v1/accounts/' + commons.Escaper.ecapeVariable('$accountId') + '/storeInfos/' + commons.Escaper.ecapeVariable('$videoId') + '/country/' + commons.Escaper.ecapeVariable('$country');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new StoreInfo.fromJson(data));
  }

}



/**
 * An Avail describes the Availability Window of a specific Edit in a given
 * country, which means the period Google is allowed to sell or rent the Edit.
 * Avails are exposed in EMA format Version 1.6b (available at
 * http://www.movielabs.com/md/avails/) Studios can see the Avails for the
 * Titles they own. Post-production houses cannot see any Avails.
 */
class Avail {
  /**
   * Other identifier referring to the Edit, as defined by partner. Example:
   * "GOOGLER_2006"
   */
  core.String altId;
  /**
   * ID internally generated by Google to uniquely identify an Avail. Not part
   * of EMA Specs.
   */
  core.String availId;
  /**
   * Communicating an exempt category as defined by FCC regulations. It is not
   * required for non-US Avails. Example: "1"
   */
  core.String captionExemption;
  /** Communicating if caption file will be delivered. */
  core.bool captionIncluded;
  /**
   * Title Identifier. This should be the Title Level EIDR. Example:
   * "10.5240/1489-49A2-3956-4B2D-FE16-5".
   */
  core.String contentId;
  /**
   * The name of the studio that owns the Edit referred in the Avail. This is
   * the equivalent of `studio_name` in other resources, but it follows the EMA
   * nomenclature. Example: "Google Films".
   */
  core.String displayName;
  /**
   * Manifestation Identifier. This should be the Manifestation Level EIDR.
   * Example: "10.2340/1489-49A2-3956-4B2D-FE16-7"
   */
  core.String encodeId;
  /**
   * End of term in YYYY-MM-DD format in the timezone of the country of the
   * Avail. "Open" if no end date is available. Example: "2019-02-17"
   */
  core.String end;
  /**
   * Other identifier referring to the episode, as defined by partner. Only
   * available on TV avails. Example: "rs_googlers_s1_3".
   */
  core.String episodeAltId;
  /**
   * The number assigned to the episode within a season. Only available on TV
   * Avails. Example: "3".
   */
  core.String episodeNumber;
  /**
   * OPTIONAL.TV Only. Title used by involved parties to refer to this episode.
   * Only available on TV Avails. Example: "Coding at Google".
   */
  core.String episodeTitleInternalAlias;
  /**
   * Indicates the format profile covered by the transaction.
   * Possible string values are:
   * - "FORMAT_PROFILE_UNSPECIFIED" : A FORMAT_PROFILE_UNSPECIFIED.
   * - "SD" : A SD.
   * - "HD" : A HD.
   * - "UHD" : A UHD.
   */
  core.String formatProfile;
  /**
   * Type of transaction.
   * Possible string values are:
   * - "LICENSE_TYPE_UNSPECIFIED" : A LICENSE_TYPE_UNSPECIFIED.
   * - "EST" : A EST.
   * - "VOD" : A VOD.
   * - "SVOD" : A SVOD.
   * - "POEST" : A POEST.
   */
  core.String licenseType;
  /**
   * Name of the post-production houses that manage the Avail. Not part of EMA
   * Specs.
   */
  core.List<core.String> pphNames;
  /**
   * Type of pricing that should be applied to this Avail based on how the
   * partner classify them. Example: "Tier", "WSP", "SRP", or "Category".
   */
  core.String priceType;
  /** Value to be applied to the pricing type. Example: "4" or "2.99" */
  core.String priceValue;
  /**
   * Edit Identifier. This should be the Edit Level EIDR. Example:
   * "10.2340/1489-49A2-3956-4B2D-FE16-6"
   */
  core.String productId;
  /**
   * Value representing the rating reason. Rating reasons should be formatted as
   * per [EMA ratings spec](http://www.movielabs.com/md/ratings/) and
   * comma-separated for inclusion of multiple reasons. Example: "L, S, V"
   */
  core.String ratingReason;
  /**
   * Rating system applied to the version of title within territory of Avail.
   * Rating systems should be formatted as per [EMA ratings
   * spec](http://www.movielabs.com/md/ratings/) Example: "MPAA"
   */
  core.String ratingSystem;
  /**
   * Value representing the rating. Ratings should be formatted as per
   * http://www.movielabs.com/md/ratings/ Example: "PG"
   */
  core.String ratingValue;
  /**
   * Release date of the Title in earliest released territory. Typically it is
   * just the year, but it is free-form as per EMA spec. Examples: "1979", "Oct
   * 2014"
   */
  core.String releaseDate;
  /**
   * Other identifier referring to the season, as defined by partner. Only
   * available on TV avails. Example: "rs_googlers_s1".
   */
  core.String seasonAltId;
  /**
   * The number assigned to the season within a series. Only available on TV
   * Avails. Example: "1".
   */
  core.String seasonNumber;
  /**
   * Title used by involved parties to refer to this season. Only available on
   * TV Avails. Example: "Googlers, The".
   */
  core.String seasonTitleInternalAlias;
  /**
   * Other identifier referring to the series, as defined by partner. Only
   * available on TV avails. Example: "rs_googlers".
   */
  core.String seriesAltId;
  /**
   * Title used by involved parties to refer to this series. Only available on
   * TV Avails. Example: "Googlers, The".
   */
  core.String seriesTitleInternalAlias;
  /**
   * Start of term in YYYY-MM-DD format in the timezone of the country of the
   * Avail. Example: "2013-05-14".
   */
  core.String start;
  /**
   * Spoken language of the intended audience. Language shall be encoded in
   * accordance with RFC 5646. Example: "fr".
   */
  core.String storeLanguage;
  /**
   * First date an Edit could be publically announced as becoming available at a
   * specific future date in territory of Avail. *Not* the Avail start date or
   * pre-order start date. Format is YYYY-MM-DD. Only available for pre-orders.
   * Example: "2012-12-10"
   */
  core.String suppressionLiftDate;
  /**
   * ISO 3166-1 alpha-2 country code for the country or territory of this Avail.
   * For Avails, we use Territory in lieu of Country to comply with EMA
   * specifications. But please note that Territory and Country identify the
   * same thing. Example: "US".
   */
  core.String territory;
  /**
   * Title used by involved parties to refer to this content. Example:
   * "Googlers, The". Only available on Movie Avails.
   */
  core.String titleInternalAlias;
  /**
   * Google-generated ID identifying the video linked to this Avail, once
   * delivered. Not part of EMA Specs. Example: 'gtry456_xc'
   */
  core.String videoId;
  /**
   * Work type as enumerated in EMA.
   * Possible string values are:
   * - "TITLE_TYPE_UNSPECIFIED" : A TITLE_TYPE_UNSPECIFIED.
   * - "MOVIE" : A MOVIE.
   * - "SEASON" : A SEASON.
   * - "EPISODE" : A EPISODE.
   * - "BUNDLE" : A BUNDLE.
   */
  core.String workType;

  Avail();

  Avail.fromJson(core.Map _json) {
    if (_json.containsKey("altId")) {
      altId = _json["altId"];
    }
    if (_json.containsKey("availId")) {
      availId = _json["availId"];
    }
    if (_json.containsKey("captionExemption")) {
      captionExemption = _json["captionExemption"];
    }
    if (_json.containsKey("captionIncluded")) {
      captionIncluded = _json["captionIncluded"];
    }
    if (_json.containsKey("contentId")) {
      contentId = _json["contentId"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("encodeId")) {
      encodeId = _json["encodeId"];
    }
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("episodeAltId")) {
      episodeAltId = _json["episodeAltId"];
    }
    if (_json.containsKey("episodeNumber")) {
      episodeNumber = _json["episodeNumber"];
    }
    if (_json.containsKey("episodeTitleInternalAlias")) {
      episodeTitleInternalAlias = _json["episodeTitleInternalAlias"];
    }
    if (_json.containsKey("formatProfile")) {
      formatProfile = _json["formatProfile"];
    }
    if (_json.containsKey("licenseType")) {
      licenseType = _json["licenseType"];
    }
    if (_json.containsKey("pphNames")) {
      pphNames = _json["pphNames"];
    }
    if (_json.containsKey("priceType")) {
      priceType = _json["priceType"];
    }
    if (_json.containsKey("priceValue")) {
      priceValue = _json["priceValue"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("ratingReason")) {
      ratingReason = _json["ratingReason"];
    }
    if (_json.containsKey("ratingSystem")) {
      ratingSystem = _json["ratingSystem"];
    }
    if (_json.containsKey("ratingValue")) {
      ratingValue = _json["ratingValue"];
    }
    if (_json.containsKey("releaseDate")) {
      releaseDate = _json["releaseDate"];
    }
    if (_json.containsKey("seasonAltId")) {
      seasonAltId = _json["seasonAltId"];
    }
    if (_json.containsKey("seasonNumber")) {
      seasonNumber = _json["seasonNumber"];
    }
    if (_json.containsKey("seasonTitleInternalAlias")) {
      seasonTitleInternalAlias = _json["seasonTitleInternalAlias"];
    }
    if (_json.containsKey("seriesAltId")) {
      seriesAltId = _json["seriesAltId"];
    }
    if (_json.containsKey("seriesTitleInternalAlias")) {
      seriesTitleInternalAlias = _json["seriesTitleInternalAlias"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
    if (_json.containsKey("storeLanguage")) {
      storeLanguage = _json["storeLanguage"];
    }
    if (_json.containsKey("suppressionLiftDate")) {
      suppressionLiftDate = _json["suppressionLiftDate"];
    }
    if (_json.containsKey("territory")) {
      territory = _json["territory"];
    }
    if (_json.containsKey("titleInternalAlias")) {
      titleInternalAlias = _json["titleInternalAlias"];
    }
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
    if (_json.containsKey("workType")) {
      workType = _json["workType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (altId != null) {
      _json["altId"] = altId;
    }
    if (availId != null) {
      _json["availId"] = availId;
    }
    if (captionExemption != null) {
      _json["captionExemption"] = captionExemption;
    }
    if (captionIncluded != null) {
      _json["captionIncluded"] = captionIncluded;
    }
    if (contentId != null) {
      _json["contentId"] = contentId;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (encodeId != null) {
      _json["encodeId"] = encodeId;
    }
    if (end != null) {
      _json["end"] = end;
    }
    if (episodeAltId != null) {
      _json["episodeAltId"] = episodeAltId;
    }
    if (episodeNumber != null) {
      _json["episodeNumber"] = episodeNumber;
    }
    if (episodeTitleInternalAlias != null) {
      _json["episodeTitleInternalAlias"] = episodeTitleInternalAlias;
    }
    if (formatProfile != null) {
      _json["formatProfile"] = formatProfile;
    }
    if (licenseType != null) {
      _json["licenseType"] = licenseType;
    }
    if (pphNames != null) {
      _json["pphNames"] = pphNames;
    }
    if (priceType != null) {
      _json["priceType"] = priceType;
    }
    if (priceValue != null) {
      _json["priceValue"] = priceValue;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (ratingReason != null) {
      _json["ratingReason"] = ratingReason;
    }
    if (ratingSystem != null) {
      _json["ratingSystem"] = ratingSystem;
    }
    if (ratingValue != null) {
      _json["ratingValue"] = ratingValue;
    }
    if (releaseDate != null) {
      _json["releaseDate"] = releaseDate;
    }
    if (seasonAltId != null) {
      _json["seasonAltId"] = seasonAltId;
    }
    if (seasonNumber != null) {
      _json["seasonNumber"] = seasonNumber;
    }
    if (seasonTitleInternalAlias != null) {
      _json["seasonTitleInternalAlias"] = seasonTitleInternalAlias;
    }
    if (seriesAltId != null) {
      _json["seriesAltId"] = seriesAltId;
    }
    if (seriesTitleInternalAlias != null) {
      _json["seriesTitleInternalAlias"] = seriesTitleInternalAlias;
    }
    if (start != null) {
      _json["start"] = start;
    }
    if (storeLanguage != null) {
      _json["storeLanguage"] = storeLanguage;
    }
    if (suppressionLiftDate != null) {
      _json["suppressionLiftDate"] = suppressionLiftDate;
    }
    if (territory != null) {
      _json["territory"] = territory;
    }
    if (titleInternalAlias != null) {
      _json["titleInternalAlias"] = titleInternalAlias;
    }
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    if (workType != null) {
      _json["workType"] = workType;
    }
    return _json;
  }
}

/** Response to the 'ListAvails' method. */
class ListAvailsResponse {
  /** List of Avails that match the request criteria. */
  core.List<Avail> avails;
  /** See _List methods rules_ for info about this field. */
  core.String nextPageToken;
  /** See _List methods rules_ for more information about this field. */
  core.int totalSize;

  ListAvailsResponse();

  ListAvailsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("avails")) {
      avails = _json["avails"].map((value) => new Avail.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("totalSize")) {
      totalSize = _json["totalSize"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (avails != null) {
      _json["avails"] = avails.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (totalSize != null) {
      _json["totalSize"] = totalSize;
    }
    return _json;
  }
}

/** Response to the 'ListOrders' method. */
class ListOrdersResponse {
  /** See _List methods rules_ for info about this field. */
  core.String nextPageToken;
  /** List of Orders that match the request criteria. */
  core.List<Order> orders;
  /** See _List methods rules_ for more information about this field. */
  core.int totalSize;

  ListOrdersResponse();

  ListOrdersResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("orders")) {
      orders = _json["orders"].map((value) => new Order.fromJson(value)).toList();
    }
    if (_json.containsKey("totalSize")) {
      totalSize = _json["totalSize"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (orders != null) {
      _json["orders"] = orders.map((value) => (value).toJson()).toList();
    }
    if (totalSize != null) {
      _json["totalSize"] = totalSize;
    }
    return _json;
  }
}

/** Response to the 'ListStoreInfos' method. */
class ListStoreInfosResponse {
  /** See 'List methods rules' for info about this field. */
  core.String nextPageToken;
  /** List of StoreInfos that match the request criteria. */
  core.List<StoreInfo> storeInfos;
  /** See _List methods rules_ for more information about this field. */
  core.int totalSize;

  ListStoreInfosResponse();

  ListStoreInfosResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("storeInfos")) {
      storeInfos = _json["storeInfos"].map((value) => new StoreInfo.fromJson(value)).toList();
    }
    if (_json.containsKey("totalSize")) {
      totalSize = _json["totalSize"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (storeInfos != null) {
      _json["storeInfos"] = storeInfos.map((value) => (value).toJson()).toList();
    }
    if (totalSize != null) {
      _json["totalSize"] = totalSize;
    }
    return _json;
  }
}

/**
 * An Order tracks the fulfillment of an Edit when delivered using the legacy,
 * non-component-based delivery. Each Order is uniquely identified by an
 * `order_id`, which is generated by Google. Externally, Orders can also be
 * identified by partners using its `custom_id` (when provided).
 */
class Order {
  /** Timestamp when the Order was approved. */
  core.String approvedTime;
  /**
   * YouTube Channel ID that should be used to fulfill the Order. Example:
   * "UCRG64darCZhb".
   */
  core.String channelId;
  /**
   * YouTube Channel Name that should be used to fulfill the Order. Example:
   * "Google_channel".
   */
  core.String channelName;
  /**
   * Countries where the Order is available, using the "ISO 3166-1 alpha-2"
   * format (example: "US").
   */
  core.List<core.String> countries;
  /**
   * ID that can be used to externally identify an Order. This ID is provided by
   * partners when submitting the Avails. Example: 'GOOGLER_2006'
   */
  core.String customId;
  /**
   * Timestamp of the earliest start date of the Avails linked to this Order.
   */
  core.String earliestAvailStartTime;
  /**
   * Default Episode name, usually in the language of the country of origin.
   * Only available for TV Edits Example: "Googlers, The - Pilot".
   */
  core.String episodeName;
  /** Legacy Order priority, as defined by Google. Example: 'P0' */
  core.String legacyPriority;
  /**
   * Default Edit name, usually in the language of the country of origin.
   * Example: "Googlers, The".
   */
  core.String name;
  /**
   * A simpler representation of the priority.
   * Possible string values are:
   * - "NORMALIZED_PRIORITY_UNSPECIFIED" : A NORMALIZED_PRIORITY_UNSPECIFIED.
   * - "LOW_PRIORITY" : A LOW_PRIORITY.
   * - "HIGH_PRIORITY" : A HIGH_PRIORITY.
   */
  core.String normalizedPriority;
  /**
   * ID internally generated by Google to uniquely identify an Order. Example:
   * 'abcde12_x'
   */
  core.String orderId;
  /** Timestamp when the Order was created. */
  core.String orderedTime;
  /** Name of the post-production house that manages the Edit ordered. */
  core.String pphName;
  /**
   * Order priority, as defined by Google. The higher the value, the higher the
   * priority. Example: 90
   */
  core.double priority;
  /** Timestamp when the Order was fulfilled. */
  core.String receivedTime;
  /**
   * Field explaining why an Order has been rejected. Example: "Trailer audio is
   * 2ch mono, please re-deliver in stereo".
   */
  core.String rejectionNote;
  /**
   * Default Season name, usually in the language of the country of origin. Only
   * available for TV Edits Example: "Googlers, The - A Brave New World".
   */
  core.String seasonName;
  /**
   * Default Show name, usually in the language of the country of origin. Only
   * available for TV Edits Example: "Googlers, The".
   */
  core.String showName;
  /**
   * High-level status of the order.
   * Possible string values are:
   * - "STATUS_UNSPECIFIED" : A STATUS_UNSPECIFIED.
   * - "STATUS_APPROVED" : A STATUS_APPROVED.
   * - "STATUS_FAILED" : A STATUS_FAILED.
   * - "STATUS_PROCESSING" : A STATUS_PROCESSING.
   * - "STATUS_UNFULFILLED" : A STATUS_UNFULFILLED.
   * - "STATUS_NOT_AVAILABLE" : A STATUS_NOT_AVAILABLE.
   */
  core.String status;
  /**
   * Detailed status of the order
   * Possible string values are:
   * - "ORDER_STATUS_UNSPECIFIED" : A ORDER_STATUS_UNSPECIFIED.
   * - "ORDER_STATUS_QC_APPROVED" : A ORDER_STATUS_QC_APPROVED.
   * - "ORDER_STATUS_QC_REJECTION" : A ORDER_STATUS_QC_REJECTION.
   * - "ORDER_STATUS_INTERNAL_FIX" : A ORDER_STATUS_INTERNAL_FIX.
   * - "ORDER_STATUS_OPEN_ORDER" : A ORDER_STATUS_OPEN_ORDER.
   * - "ORDER_STATUS_NOT_AVAILABLE" : A ORDER_STATUS_NOT_AVAILABLE.
   * - "ORDER_STATUS_AWAITING_REDELIVERY" : A ORDER_STATUS_AWAITING_REDELIVERY.
   * - "ORDER_STATUS_READY_FOR_QC" : A ORDER_STATUS_READY_FOR_QC.
   * - "ORDER_STATUS_FILE_PROCESSING" : A ORDER_STATUS_FILE_PROCESSING.
   */
  core.String statusDetail;
  /** Name of the studio that owns the Edit ordered. */
  core.String studioName;
  /**
   * Type of the Edit linked to the Order.
   * Possible string values are:
   * - "TITLE_TYPE_UNSPECIFIED" : A TITLE_TYPE_UNSPECIFIED.
   * - "MOVIE" : A MOVIE.
   * - "SEASON" : A SEASON.
   * - "EPISODE" : A EPISODE.
   * - "BUNDLE" : A BUNDLE.
   */
  core.String type;
  /**
   * Google-generated ID identifying the video linked to this Order, once
   * delivered. Example: 'gtry456_xc'.
   */
  core.String videoId;

  Order();

  Order.fromJson(core.Map _json) {
    if (_json.containsKey("approvedTime")) {
      approvedTime = _json["approvedTime"];
    }
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("channelName")) {
      channelName = _json["channelName"];
    }
    if (_json.containsKey("countries")) {
      countries = _json["countries"];
    }
    if (_json.containsKey("customId")) {
      customId = _json["customId"];
    }
    if (_json.containsKey("earliestAvailStartTime")) {
      earliestAvailStartTime = _json["earliestAvailStartTime"];
    }
    if (_json.containsKey("episodeName")) {
      episodeName = _json["episodeName"];
    }
    if (_json.containsKey("legacyPriority")) {
      legacyPriority = _json["legacyPriority"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("normalizedPriority")) {
      normalizedPriority = _json["normalizedPriority"];
    }
    if (_json.containsKey("orderId")) {
      orderId = _json["orderId"];
    }
    if (_json.containsKey("orderedTime")) {
      orderedTime = _json["orderedTime"];
    }
    if (_json.containsKey("pphName")) {
      pphName = _json["pphName"];
    }
    if (_json.containsKey("priority")) {
      priority = _json["priority"];
    }
    if (_json.containsKey("receivedTime")) {
      receivedTime = _json["receivedTime"];
    }
    if (_json.containsKey("rejectionNote")) {
      rejectionNote = _json["rejectionNote"];
    }
    if (_json.containsKey("seasonName")) {
      seasonName = _json["seasonName"];
    }
    if (_json.containsKey("showName")) {
      showName = _json["showName"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("statusDetail")) {
      statusDetail = _json["statusDetail"];
    }
    if (_json.containsKey("studioName")) {
      studioName = _json["studioName"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (approvedTime != null) {
      _json["approvedTime"] = approvedTime;
    }
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (channelName != null) {
      _json["channelName"] = channelName;
    }
    if (countries != null) {
      _json["countries"] = countries;
    }
    if (customId != null) {
      _json["customId"] = customId;
    }
    if (earliestAvailStartTime != null) {
      _json["earliestAvailStartTime"] = earliestAvailStartTime;
    }
    if (episodeName != null) {
      _json["episodeName"] = episodeName;
    }
    if (legacyPriority != null) {
      _json["legacyPriority"] = legacyPriority;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (normalizedPriority != null) {
      _json["normalizedPriority"] = normalizedPriority;
    }
    if (orderId != null) {
      _json["orderId"] = orderId;
    }
    if (orderedTime != null) {
      _json["orderedTime"] = orderedTime;
    }
    if (pphName != null) {
      _json["pphName"] = pphName;
    }
    if (priority != null) {
      _json["priority"] = priority;
    }
    if (receivedTime != null) {
      _json["receivedTime"] = receivedTime;
    }
    if (rejectionNote != null) {
      _json["rejectionNote"] = rejectionNote;
    }
    if (seasonName != null) {
      _json["seasonName"] = seasonName;
    }
    if (showName != null) {
      _json["showName"] = showName;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (statusDetail != null) {
      _json["statusDetail"] = statusDetail;
    }
    if (studioName != null) {
      _json["studioName"] = studioName;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    return _json;
  }
}

/**
 * Information about a playable sequence (video) associated with an Edit and
 * available at the Google Play Store. Internally, each StoreInfo is uniquely
 * identified by a `video_id` and `country`. Externally, Title-level EIDR or
 * Edit-level EIDR, if provided, can also be used to identify a specific title
 * or edit in a country.
 */
class StoreInfo {
  /** Audio tracks available for this Edit. */
  core.List<core.String> audioTracks;
  /**
   * Country where Edit is available in ISO 3166-1 alpha-2 country code.
   * Example: "US".
   */
  core.String country;
  /** Edit-level EIDR ID. Example: "10.5240/1489-49A2-3956-4B2D-FE16-6". */
  core.String editLevelEidr;
  /**
   * The number assigned to the episode within a season. Only available on TV
   * Edits. Example: "1".
   */
  core.String episodeNumber;
  /** Whether the Edit has a 5.1 channel audio track. */
  core.bool hasAudio51;
  /** Whether the Edit has a EST offer. */
  core.bool hasEstOffer;
  /** Whether the Edit has a HD offer. */
  core.bool hasHdOffer;
  /** Whether the Edit has info cards. */
  core.bool hasInfoCards;
  /** Whether the Edit has a SD offer. */
  core.bool hasSdOffer;
  /** Whether the Edit has a VOD offer. */
  core.bool hasVodOffer;
  /** Timestamp when the Edit went live on the Store. */
  core.String liveTime;
  /**
   * Knowledge Graph ID associated to this Edit, if available. This ID links the
   * Edit to its knowledge entity, externally accessible at http://freebase.com.
   * In the absense of Title EIDR or Edit EIDR, this ID helps link together
   * multiple Edits across countries. Example: '/m/0ffx29'
   */
  core.String mid;
  /**
   * Default Edit name, usually in the language of the country of origin.
   * Example: "Googlers, The".
   */
  core.String name;
  /** Name of the post-production houses that manage the Edit. */
  core.List<core.String> pphNames;
  /**
   * Google-generated ID identifying the season linked to the Edit. Only
   * available for TV Edits. Example: 'ster23ex'
   */
  core.String seasonId;
  /**
   * Default Season name, usually in the language of the country of origin. Only
   * available for TV Edits Example: "Googlers, The - A Brave New World".
   */
  core.String seasonName;
  /**
   * The number assigned to the season within a show. Only available on TV
   * Edits. Example: "1".
   */
  core.String seasonNumber;
  /**
   * Google-generated ID identifying the show linked to the Edit. Only available
   * for TV Edits. Example: 'et2hsue_x'
   */
  core.String showId;
  /**
   * Default Show name, usually in the language of the country of origin. Only
   * available for TV Edits Example: "Googlers, The".
   */
  core.String showName;
  /** Name of the studio that owns the Edit ordered. */
  core.String studioName;
  /** Subtitles available for this Edit. */
  core.List<core.String> subtitles;
  /** Title-level EIDR ID. Example: "10.5240/1489-49A2-3956-4B2D-FE16-5". */
  core.String titleLevelEidr;
  /**
   * Google-generated ID identifying the trailer linked to the Edit. Example:
   * 'bhd_4e_cx'
   */
  core.String trailerId;
  /**
   * Edit type, like Movie, Episode or Season.
   * Possible string values are:
   * - "TITLE_TYPE_UNSPECIFIED" : A TITLE_TYPE_UNSPECIFIED.
   * - "MOVIE" : A MOVIE.
   * - "SEASON" : A SEASON.
   * - "EPISODE" : A EPISODE.
   * - "BUNDLE" : A BUNDLE.
   */
  core.String type;
  /**
   * Google-generated ID identifying the video linked to the Edit. Example:
   * 'gtry456_xc'
   */
  core.String videoId;

  StoreInfo();

  StoreInfo.fromJson(core.Map _json) {
    if (_json.containsKey("audioTracks")) {
      audioTracks = _json["audioTracks"];
    }
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("editLevelEidr")) {
      editLevelEidr = _json["editLevelEidr"];
    }
    if (_json.containsKey("episodeNumber")) {
      episodeNumber = _json["episodeNumber"];
    }
    if (_json.containsKey("hasAudio51")) {
      hasAudio51 = _json["hasAudio51"];
    }
    if (_json.containsKey("hasEstOffer")) {
      hasEstOffer = _json["hasEstOffer"];
    }
    if (_json.containsKey("hasHdOffer")) {
      hasHdOffer = _json["hasHdOffer"];
    }
    if (_json.containsKey("hasInfoCards")) {
      hasInfoCards = _json["hasInfoCards"];
    }
    if (_json.containsKey("hasSdOffer")) {
      hasSdOffer = _json["hasSdOffer"];
    }
    if (_json.containsKey("hasVodOffer")) {
      hasVodOffer = _json["hasVodOffer"];
    }
    if (_json.containsKey("liveTime")) {
      liveTime = _json["liveTime"];
    }
    if (_json.containsKey("mid")) {
      mid = _json["mid"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("pphNames")) {
      pphNames = _json["pphNames"];
    }
    if (_json.containsKey("seasonId")) {
      seasonId = _json["seasonId"];
    }
    if (_json.containsKey("seasonName")) {
      seasonName = _json["seasonName"];
    }
    if (_json.containsKey("seasonNumber")) {
      seasonNumber = _json["seasonNumber"];
    }
    if (_json.containsKey("showId")) {
      showId = _json["showId"];
    }
    if (_json.containsKey("showName")) {
      showName = _json["showName"];
    }
    if (_json.containsKey("studioName")) {
      studioName = _json["studioName"];
    }
    if (_json.containsKey("subtitles")) {
      subtitles = _json["subtitles"];
    }
    if (_json.containsKey("titleLevelEidr")) {
      titleLevelEidr = _json["titleLevelEidr"];
    }
    if (_json.containsKey("trailerId")) {
      trailerId = _json["trailerId"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (audioTracks != null) {
      _json["audioTracks"] = audioTracks;
    }
    if (country != null) {
      _json["country"] = country;
    }
    if (editLevelEidr != null) {
      _json["editLevelEidr"] = editLevelEidr;
    }
    if (episodeNumber != null) {
      _json["episodeNumber"] = episodeNumber;
    }
    if (hasAudio51 != null) {
      _json["hasAudio51"] = hasAudio51;
    }
    if (hasEstOffer != null) {
      _json["hasEstOffer"] = hasEstOffer;
    }
    if (hasHdOffer != null) {
      _json["hasHdOffer"] = hasHdOffer;
    }
    if (hasInfoCards != null) {
      _json["hasInfoCards"] = hasInfoCards;
    }
    if (hasSdOffer != null) {
      _json["hasSdOffer"] = hasSdOffer;
    }
    if (hasVodOffer != null) {
      _json["hasVodOffer"] = hasVodOffer;
    }
    if (liveTime != null) {
      _json["liveTime"] = liveTime;
    }
    if (mid != null) {
      _json["mid"] = mid;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (pphNames != null) {
      _json["pphNames"] = pphNames;
    }
    if (seasonId != null) {
      _json["seasonId"] = seasonId;
    }
    if (seasonName != null) {
      _json["seasonName"] = seasonName;
    }
    if (seasonNumber != null) {
      _json["seasonNumber"] = seasonNumber;
    }
    if (showId != null) {
      _json["showId"] = showId;
    }
    if (showName != null) {
      _json["showName"] = showName;
    }
    if (studioName != null) {
      _json["studioName"] = studioName;
    }
    if (subtitles != null) {
      _json["subtitles"] = subtitles;
    }
    if (titleLevelEidr != null) {
      _json["titleLevelEidr"] = titleLevelEidr;
    }
    if (trailerId != null) {
      _json["trailerId"] = trailerId;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    return _json;
  }
}
