// This is a generated file (see the discoveryapis_generator project).

library googleapis.doubleclicksearch.v2;

import 'dart:core' as core;
import 'dart:collection' as collection;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client doubleclicksearch/v2';

/**
 * Reports and modifies your advertising data in DoubleClick Search (for
 * example, campaigns, ad groups, keywords, and conversions).
 */
class DoubleclicksearchApi {
  /** View and manage your advertising data in DoubleClick Search */
  static const DoubleclicksearchScope = "https://www.googleapis.com/auth/doubleclicksearch";


  final commons.ApiRequester _requester;

  ConversionResourceApi get conversion => new ConversionResourceApi(_requester);
  ReportsResourceApi get reports => new ReportsResourceApi(_requester);
  SavedColumnsResourceApi get savedColumns => new SavedColumnsResourceApi(_requester);

  DoubleclicksearchApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "doubleclicksearch/v2/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ConversionResourceApi {
  final commons.ApiRequester _requester;

  ConversionResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves a list of conversions from a DoubleClick Search engine account.
   *
   * Request parameters:
   *
   * [agencyId] - Numeric ID of the agency.
   *
   * [advertiserId] - Numeric ID of the advertiser.
   *
   * [engineAccountId] - Numeric ID of the engine account.
   *
   * [endDate] - Last date (inclusive) on which to retrieve conversions. Format
   * is yyyymmdd.
   * Value must be between "20091101" and "99991231".
   *
   * [rowCount] - The number of conversions to return per call.
   * Value must be between "1" and "1000".
   *
   * [startDate] - First date (inclusive) on which to retrieve conversions.
   * Format is yyyymmdd.
   * Value must be between "20091101" and "99991231".
   *
   * [startRow] - The 0-based starting index for retrieving conversions results.
   *
   * [adGroupId] - Numeric ID of the ad group.
   *
   * [adId] - Numeric ID of the ad.
   *
   * [campaignId] - Numeric ID of the campaign.
   *
   * [criterionId] - Numeric ID of the criterion.
   *
   * Completes with a [ConversionList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ConversionList> get(core.String agencyId, core.String advertiserId, core.String engineAccountId, core.int endDate, core.int rowCount, core.int startDate, core.int startRow, {core.String adGroupId, core.String adId, core.String campaignId, core.String criterionId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (agencyId == null) {
      throw new core.ArgumentError("Parameter agencyId is required.");
    }
    if (advertiserId == null) {
      throw new core.ArgumentError("Parameter advertiserId is required.");
    }
    if (engineAccountId == null) {
      throw new core.ArgumentError("Parameter engineAccountId is required.");
    }
    if (endDate == null) {
      throw new core.ArgumentError("Parameter endDate is required.");
    }
    _queryParams["endDate"] = ["${endDate}"];
    if (rowCount == null) {
      throw new core.ArgumentError("Parameter rowCount is required.");
    }
    _queryParams["rowCount"] = ["${rowCount}"];
    if (startDate == null) {
      throw new core.ArgumentError("Parameter startDate is required.");
    }
    _queryParams["startDate"] = ["${startDate}"];
    if (startRow == null) {
      throw new core.ArgumentError("Parameter startRow is required.");
    }
    _queryParams["startRow"] = ["${startRow}"];
    if (adGroupId != null) {
      _queryParams["adGroupId"] = [adGroupId];
    }
    if (adId != null) {
      _queryParams["adId"] = [adId];
    }
    if (campaignId != null) {
      _queryParams["campaignId"] = [campaignId];
    }
    if (criterionId != null) {
      _queryParams["criterionId"] = [criterionId];
    }

    _url = 'agency/' + commons.Escaper.ecapeVariable('$agencyId') + '/advertiser/' + commons.Escaper.ecapeVariable('$advertiserId') + '/engine/' + commons.Escaper.ecapeVariable('$engineAccountId') + '/conversion';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ConversionList.fromJson(data));
  }

  /**
   * Inserts a batch of new conversions into DoubleClick Search.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [ConversionList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ConversionList> insert(ConversionList request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'conversion';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ConversionList.fromJson(data));
  }

  /**
   * Updates a batch of conversions in DoubleClick Search. This method supports
   * patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [advertiserId] - Numeric ID of the advertiser.
   *
   * [agencyId] - Numeric ID of the agency.
   *
   * [endDate] - Last date (inclusive) on which to retrieve conversions. Format
   * is yyyymmdd.
   * Value must be between "20091101" and "99991231".
   *
   * [engineAccountId] - Numeric ID of the engine account.
   *
   * [rowCount] - The number of conversions to return per call.
   * Value must be between "1" and "1000".
   *
   * [startDate] - First date (inclusive) on which to retrieve conversions.
   * Format is yyyymmdd.
   * Value must be between "20091101" and "99991231".
   *
   * [startRow] - The 0-based starting index for retrieving conversions results.
   *
   * Completes with a [ConversionList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ConversionList> patch(ConversionList request, core.String advertiserId, core.String agencyId, core.int endDate, core.String engineAccountId, core.int rowCount, core.int startDate, core.int startRow) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (advertiserId == null) {
      throw new core.ArgumentError("Parameter advertiserId is required.");
    }
    _queryParams["advertiserId"] = [advertiserId];
    if (agencyId == null) {
      throw new core.ArgumentError("Parameter agencyId is required.");
    }
    _queryParams["agencyId"] = [agencyId];
    if (endDate == null) {
      throw new core.ArgumentError("Parameter endDate is required.");
    }
    _queryParams["endDate"] = ["${endDate}"];
    if (engineAccountId == null) {
      throw new core.ArgumentError("Parameter engineAccountId is required.");
    }
    _queryParams["engineAccountId"] = [engineAccountId];
    if (rowCount == null) {
      throw new core.ArgumentError("Parameter rowCount is required.");
    }
    _queryParams["rowCount"] = ["${rowCount}"];
    if (startDate == null) {
      throw new core.ArgumentError("Parameter startDate is required.");
    }
    _queryParams["startDate"] = ["${startDate}"];
    if (startRow == null) {
      throw new core.ArgumentError("Parameter startRow is required.");
    }
    _queryParams["startRow"] = ["${startRow}"];

    _url = 'conversion';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ConversionList.fromJson(data));
  }

  /**
   * Updates a batch of conversions in DoubleClick Search.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [ConversionList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ConversionList> update(ConversionList request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'conversion';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ConversionList.fromJson(data));
  }

  /**
   * Updates the availabilities of a batch of floodlight activities in
   * DoubleClick Search.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [UpdateAvailabilityResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UpdateAvailabilityResponse> updateAvailability(UpdateAvailabilityRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'conversion/updateAvailability';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UpdateAvailabilityResponse.fromJson(data));
  }

}


class ReportsResourceApi {
  final commons.ApiRequester _requester;

  ReportsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Generates and returns a report immediately.
   *
   * [request_1] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Report].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Report> generate(ReportRequest request_1) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request_1 != null) {
      _body = convert.JSON.encode((request_1).toJson());
    }

    _url = 'reports/generate';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Report.fromJson(data));
  }

  /**
   * Polls for the status of a report request.
   *
   * Request parameters:
   *
   * [reportId] - ID of the report request being polled.
   *
   * Completes with a [Report].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Report> get(core.String reportId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (reportId == null) {
      throw new core.ArgumentError("Parameter reportId is required.");
    }

    _url = 'reports/' + commons.Escaper.ecapeVariable('$reportId');

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
   * Downloads a report file encoded in UTF-8.
   *
   * Request parameters:
   *
   * [reportId] - ID of the report.
   *
   * [reportFragment] - The index of the report fragment to download.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future getFile(core.String reportId, core.int reportFragment, {commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (reportId == null) {
      throw new core.ArgumentError("Parameter reportId is required.");
    }
    if (reportFragment == null) {
      throw new core.ArgumentError("Parameter reportFragment is required.");
    }

    _downloadOptions = downloadOptions;

    _url = 'reports/' + commons.Escaper.ecapeVariable('$reportId') + '/files/' + commons.Escaper.ecapeVariable('$reportFragment');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => null);
    } else {
      return _response;
    }
  }

  /**
   * Inserts a report request into the reporting system.
   *
   * [request_1] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Report].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Report> request(ReportRequest request_1) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request_1 != null) {
      _body = convert.JSON.encode((request_1).toJson());
    }

    _url = 'reports';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Report.fromJson(data));
  }

}


class SavedColumnsResourceApi {
  final commons.ApiRequester _requester;

  SavedColumnsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieve the list of saved columns for a specified advertiser.
   *
   * Request parameters:
   *
   * [agencyId] - DS ID of the agency.
   *
   * [advertiserId] - DS ID of the advertiser.
   *
   * Completes with a [SavedColumnList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SavedColumnList> list(core.String agencyId, core.String advertiserId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (agencyId == null) {
      throw new core.ArgumentError("Parameter agencyId is required.");
    }
    if (advertiserId == null) {
      throw new core.ArgumentError("Parameter advertiserId is required.");
    }

    _url = 'agency/' + commons.Escaper.ecapeVariable('$agencyId') + '/advertiser/' + commons.Escaper.ecapeVariable('$advertiserId') + '/savedcolumns';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SavedColumnList.fromJson(data));
  }

}



/** A message containing availability data relevant to DoubleClick Search. */
class Availability {
  /** DS advertiser ID. */
  core.String advertiserId;
  /** DS agency ID. */
  core.String agencyId;
  /**
   * The time by which all conversions have been uploaded, in epoch millis UTC.
   */
  core.String availabilityTimestamp;
  /**
   * The numeric segmentation identifier (for example, DoubleClick Search
   * Floodlight activity ID).
   */
  core.String segmentationId;
  /**
   * The friendly segmentation identifier (for example, DoubleClick Search
   * Floodlight activity name).
   */
  core.String segmentationName;
  /**
   * The segmentation type that this availability is for (its default value is
   * FLOODLIGHT).
   */
  core.String segmentationType;

  Availability();

  Availability.fromJson(core.Map _json) {
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("agencyId")) {
      agencyId = _json["agencyId"];
    }
    if (_json.containsKey("availabilityTimestamp")) {
      availabilityTimestamp = _json["availabilityTimestamp"];
    }
    if (_json.containsKey("segmentationId")) {
      segmentationId = _json["segmentationId"];
    }
    if (_json.containsKey("segmentationName")) {
      segmentationName = _json["segmentationName"];
    }
    if (_json.containsKey("segmentationType")) {
      segmentationType = _json["segmentationType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (agencyId != null) {
      _json["agencyId"] = agencyId;
    }
    if (availabilityTimestamp != null) {
      _json["availabilityTimestamp"] = availabilityTimestamp;
    }
    if (segmentationId != null) {
      _json["segmentationId"] = segmentationId;
    }
    if (segmentationName != null) {
      _json["segmentationName"] = segmentationName;
    }
    if (segmentationType != null) {
      _json["segmentationType"] = segmentationType;
    }
    return _json;
  }
}

/** A conversion containing data relevant to DoubleClick Search. */
class Conversion {
  /** DS ad group ID. */
  core.String adGroupId;
  /** DS ad ID. */
  core.String adId;
  /** DS advertiser ID. */
  core.String advertiserId;
  /** DS agency ID. */
  core.String agencyId;
  /**
   * Available to advertisers only after contacting DoubleClick Search customer
   * support.
   */
  core.String attributionModel;
  /** DS campaign ID. */
  core.String campaignId;
  /**
   * Sales channel for the product. Acceptable values are:
   * - "local": a physical store
   * - "online": an online store
   */
  core.String channel;
  /** DS click ID for the conversion. */
  core.String clickId;
  /**
   * For offline conversions, advertisers provide this ID. Advertisers can
   * specify any ID that is meaningful to them. Each conversion in a request
   * must specify a unique ID, and the combination of ID and timestamp must be
   * unique amongst all conversions within the advertiser.
   * For online conversions, DS copies the dsConversionId or floodlightOrderId
   * into this property depending on the advertiser's Floodlight instructions.
   */
  core.String conversionId;
  /**
   * The time at which the conversion was last modified, in epoch millis UTC.
   */
  core.String conversionModifiedTimestamp;
  /** The time at which the conversion took place, in epoch millis UTC. */
  core.String conversionTimestamp;
  /**
   * Available to advertisers only after contacting DoubleClick Search customer
   * support.
   */
  core.String countMillis;
  /** DS criterion (keyword) ID. */
  core.String criterionId;
  /**
   * The currency code for the conversion's revenue. Should be in ISO 4217
   * alphabetic (3-char) format.
   */
  core.String currencyCode;
  /**
   * Custom dimensions for the conversion, which can be used to filter data in a
   * report.
   */
  core.List<CustomDimension> customDimension;
  /** Custom metrics for the conversion. */
  core.List<CustomMetric> customMetric;
  /** The type of device on which the conversion occurred. */
  core.String deviceType;
  /** ID that DoubleClick Search generates for each conversion. */
  core.String dsConversionId;
  /** DS engine account ID. */
  core.String engineAccountId;
  /** The Floodlight order ID provided by the advertiser for the conversion. */
  core.String floodlightOrderId;
  /**
   * ID that DS generates and uses to uniquely identify the inventory account
   * that contains the product.
   */
  core.String inventoryAccountId;
  /**
   * The country registered for the Merchant Center feed that contains the
   * product. Use an ISO 3166 code to specify a country.
   */
  core.String productCountry;
  /** DS product group ID. */
  core.String productGroupId;
  /** The product ID (SKU). */
  core.String productId;
  /**
   * The language registered for the Merchant Center feed that contains the
   * product. Use an ISO 639 code to specify a language.
   */
  core.String productLanguage;
  /** The quantity of this conversion, in millis. */
  core.String quantityMillis;
  /**
   * The revenue amount of this TRANSACTION conversion, in micros (value
   * multiplied by 1000000, no decimal). For example, to specify a revenue value
   * of "10" enter "10000000" (10 million) in your request.
   */
  core.String revenueMicros;
  /**
   * The numeric segmentation identifier (for example, DoubleClick Search
   * Floodlight activity ID).
   */
  core.String segmentationId;
  /**
   * The friendly segmentation identifier (for example, DoubleClick Search
   * Floodlight activity name).
   */
  core.String segmentationName;
  /** The segmentation type of this conversion (for example, FLOODLIGHT). */
  core.String segmentationType;
  /**
   * The state of the conversion, that is, either ACTIVE or REMOVED. Note: state
   * DELETED is deprecated.
   */
  core.String state;
  /**
   * The ID of the local store for which the product was advertised. Applicable
   * only when the channel is "local".
   */
  core.String storeId;
  /**
   * The type of the conversion, that is, either ACTION or TRANSACTION. An
   * ACTION conversion is an action by the user that has no monetarily
   * quantifiable value, while a TRANSACTION conversion is an action that does
   * have a monetarily quantifiable value. Examples are email list signups
   * (ACTION) versus ecommerce purchases (TRANSACTION).
   */
  core.String type;

  Conversion();

  Conversion.fromJson(core.Map _json) {
    if (_json.containsKey("adGroupId")) {
      adGroupId = _json["adGroupId"];
    }
    if (_json.containsKey("adId")) {
      adId = _json["adId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("agencyId")) {
      agencyId = _json["agencyId"];
    }
    if (_json.containsKey("attributionModel")) {
      attributionModel = _json["attributionModel"];
    }
    if (_json.containsKey("campaignId")) {
      campaignId = _json["campaignId"];
    }
    if (_json.containsKey("channel")) {
      channel = _json["channel"];
    }
    if (_json.containsKey("clickId")) {
      clickId = _json["clickId"];
    }
    if (_json.containsKey("conversionId")) {
      conversionId = _json["conversionId"];
    }
    if (_json.containsKey("conversionModifiedTimestamp")) {
      conversionModifiedTimestamp = _json["conversionModifiedTimestamp"];
    }
    if (_json.containsKey("conversionTimestamp")) {
      conversionTimestamp = _json["conversionTimestamp"];
    }
    if (_json.containsKey("countMillis")) {
      countMillis = _json["countMillis"];
    }
    if (_json.containsKey("criterionId")) {
      criterionId = _json["criterionId"];
    }
    if (_json.containsKey("currencyCode")) {
      currencyCode = _json["currencyCode"];
    }
    if (_json.containsKey("customDimension")) {
      customDimension = _json["customDimension"].map((value) => new CustomDimension.fromJson(value)).toList();
    }
    if (_json.containsKey("customMetric")) {
      customMetric = _json["customMetric"].map((value) => new CustomMetric.fromJson(value)).toList();
    }
    if (_json.containsKey("deviceType")) {
      deviceType = _json["deviceType"];
    }
    if (_json.containsKey("dsConversionId")) {
      dsConversionId = _json["dsConversionId"];
    }
    if (_json.containsKey("engineAccountId")) {
      engineAccountId = _json["engineAccountId"];
    }
    if (_json.containsKey("floodlightOrderId")) {
      floodlightOrderId = _json["floodlightOrderId"];
    }
    if (_json.containsKey("inventoryAccountId")) {
      inventoryAccountId = _json["inventoryAccountId"];
    }
    if (_json.containsKey("productCountry")) {
      productCountry = _json["productCountry"];
    }
    if (_json.containsKey("productGroupId")) {
      productGroupId = _json["productGroupId"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("productLanguage")) {
      productLanguage = _json["productLanguage"];
    }
    if (_json.containsKey("quantityMillis")) {
      quantityMillis = _json["quantityMillis"];
    }
    if (_json.containsKey("revenueMicros")) {
      revenueMicros = _json["revenueMicros"];
    }
    if (_json.containsKey("segmentationId")) {
      segmentationId = _json["segmentationId"];
    }
    if (_json.containsKey("segmentationName")) {
      segmentationName = _json["segmentationName"];
    }
    if (_json.containsKey("segmentationType")) {
      segmentationType = _json["segmentationType"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("storeId")) {
      storeId = _json["storeId"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adGroupId != null) {
      _json["adGroupId"] = adGroupId;
    }
    if (adId != null) {
      _json["adId"] = adId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (agencyId != null) {
      _json["agencyId"] = agencyId;
    }
    if (attributionModel != null) {
      _json["attributionModel"] = attributionModel;
    }
    if (campaignId != null) {
      _json["campaignId"] = campaignId;
    }
    if (channel != null) {
      _json["channel"] = channel;
    }
    if (clickId != null) {
      _json["clickId"] = clickId;
    }
    if (conversionId != null) {
      _json["conversionId"] = conversionId;
    }
    if (conversionModifiedTimestamp != null) {
      _json["conversionModifiedTimestamp"] = conversionModifiedTimestamp;
    }
    if (conversionTimestamp != null) {
      _json["conversionTimestamp"] = conversionTimestamp;
    }
    if (countMillis != null) {
      _json["countMillis"] = countMillis;
    }
    if (criterionId != null) {
      _json["criterionId"] = criterionId;
    }
    if (currencyCode != null) {
      _json["currencyCode"] = currencyCode;
    }
    if (customDimension != null) {
      _json["customDimension"] = customDimension.map((value) => (value).toJson()).toList();
    }
    if (customMetric != null) {
      _json["customMetric"] = customMetric.map((value) => (value).toJson()).toList();
    }
    if (deviceType != null) {
      _json["deviceType"] = deviceType;
    }
    if (dsConversionId != null) {
      _json["dsConversionId"] = dsConversionId;
    }
    if (engineAccountId != null) {
      _json["engineAccountId"] = engineAccountId;
    }
    if (floodlightOrderId != null) {
      _json["floodlightOrderId"] = floodlightOrderId;
    }
    if (inventoryAccountId != null) {
      _json["inventoryAccountId"] = inventoryAccountId;
    }
    if (productCountry != null) {
      _json["productCountry"] = productCountry;
    }
    if (productGroupId != null) {
      _json["productGroupId"] = productGroupId;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (productLanguage != null) {
      _json["productLanguage"] = productLanguage;
    }
    if (quantityMillis != null) {
      _json["quantityMillis"] = quantityMillis;
    }
    if (revenueMicros != null) {
      _json["revenueMicros"] = revenueMicros;
    }
    if (segmentationId != null) {
      _json["segmentationId"] = segmentationId;
    }
    if (segmentationName != null) {
      _json["segmentationName"] = segmentationName;
    }
    if (segmentationType != null) {
      _json["segmentationType"] = segmentationType;
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (storeId != null) {
      _json["storeId"] = storeId;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** A list of conversions. */
class ConversionList {
  /** The conversions being requested. */
  core.List<Conversion> conversion;
  /**
   * Identifies this as a ConversionList resource. Value: the fixed string
   * doubleclicksearch#conversionList.
   */
  core.String kind;

  ConversionList();

  ConversionList.fromJson(core.Map _json) {
    if (_json.containsKey("conversion")) {
      conversion = _json["conversion"].map((value) => new Conversion.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (conversion != null) {
      _json["conversion"] = conversion.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A message containing the custome dimension. */
class CustomDimension {
  /** Custom dimension name. */
  core.String name;
  /** Custom dimension value. */
  core.String value;

  CustomDimension();

  CustomDimension.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
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
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** A message containing the custome metric. */
class CustomMetric {
  /** Custom metric name. */
  core.String name;
  /** Custom metric numeric value. */
  core.double value;

  CustomMetric();

  CustomMetric.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
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
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class ReportFiles {
  /** The size of this report file in bytes. */
  core.String byteCount;
  /** Use this url to download the report file. */
  core.String url;

  ReportFiles();

  ReportFiles.fromJson(core.Map _json) {
    if (_json.containsKey("byteCount")) {
      byteCount = _json["byteCount"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (byteCount != null) {
      _json["byteCount"] = byteCount;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/**
 * A DoubleClick Search report. This object contains the report request, some
 * report metadata such as currency code, and the generated report rows or
 * report files.
 */
class Report {
  /**
   * Asynchronous report only. Contains a list of generated report files once
   * the report has succesfully completed.
   */
  core.List<ReportFiles> files;
  /** Asynchronous report only. Id of the report. */
  core.String id;
  /**
   * Asynchronous report only. True if and only if the report has completed
   * successfully and the report files are ready to be downloaded.
   */
  core.bool isReportReady;
  /**
   * Identifies this as a Report resource. Value: the fixed string
   * doubleclicksearch#report.
   */
  core.String kind;
  /**
   * The request that created the report. Optional fields not specified in the
   * original request are filled with default values.
   */
  ReportRequest request;
  /**
   * The number of report rows generated by the report, not including headers.
   */
  core.int rowCount;
  /** Synchronous report only. Generated report rows. */
  core.List<ReportRow> rows;
  /**
   * The currency code of all monetary values produced in the report, including
   * values that are set by users (e.g., keyword bid settings) and metrics
   * (e.g., cost and revenue). The currency code of a report is determined by
   * the statisticsCurrency field of the report request.
   */
  core.String statisticsCurrencyCode;
  /**
   * If all statistics of the report are sourced from the same time zone, this
   * would be it. Otherwise the field is unset.
   */
  core.String statisticsTimeZone;

  Report();

  Report.fromJson(core.Map _json) {
    if (_json.containsKey("files")) {
      files = _json["files"].map((value) => new ReportFiles.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("isReportReady")) {
      isReportReady = _json["isReportReady"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("request")) {
      request = new ReportRequest.fromJson(_json["request"]);
    }
    if (_json.containsKey("rowCount")) {
      rowCount = _json["rowCount"];
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"].map((value) => new ReportRow.fromJson(value)).toList();
    }
    if (_json.containsKey("statisticsCurrencyCode")) {
      statisticsCurrencyCode = _json["statisticsCurrencyCode"];
    }
    if (_json.containsKey("statisticsTimeZone")) {
      statisticsTimeZone = _json["statisticsTimeZone"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (files != null) {
      _json["files"] = files.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (isReportReady != null) {
      _json["isReportReady"] = isReportReady;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (request != null) {
      _json["request"] = (request).toJson();
    }
    if (rowCount != null) {
      _json["rowCount"] = rowCount;
    }
    if (rows != null) {
      _json["rows"] = rows;
    }
    if (statisticsCurrencyCode != null) {
      _json["statisticsCurrencyCode"] = statisticsCurrencyCode;
    }
    if (statisticsTimeZone != null) {
      _json["statisticsTimeZone"] = statisticsTimeZone;
    }
    return _json;
  }
}

/** A request object used to create a DoubleClick Search report. */
class ReportApiColumnSpec {
  /** Name of a DoubleClick Search column to include in the report. */
  core.String columnName;
  /**
   * Segments a report by a custom dimension. The report must be scoped to an
   * advertiser or lower, and the custom dimension must already be set up in
   * DoubleClick Search. The custom dimension name, which appears in DoubleClick
   * Search, is case sensitive.
   * If used in a conversion report, returns the value of the specified custom
   * dimension for the given conversion, if set. This column does not segment
   * the conversion report.
   */
  core.String customDimensionName;
  /**
   * Name of a custom metric to include in the report. The report must be scoped
   * to an advertiser or lower, and the custom metric must already be set up in
   * DoubleClick Search. The custom metric name, which appears in DoubleClick
   * Search, is case sensitive.
   */
  core.String customMetricName;
  /**
   * Inclusive day in YYYY-MM-DD format. When provided, this overrides the
   * overall time range of the report for this column only. Must be provided
   * together with startDate.
   */
  core.String endDate;
  /**
   * Synchronous report only. Set to true to group by this column. Defaults to
   * false.
   */
  core.bool groupByColumn;
  /**
   * Text used to identify this column in the report output; defaults to
   * columnName or savedColumnName when not specified. This can be used to
   * prevent collisions between DoubleClick Search columns and saved columns
   * with the same name.
   */
  core.String headerText;
  /**
   * The platform that is used to provide data for the custom dimension.
   * Acceptable values are "floodlight".
   */
  core.String platformSource;
  /**
   * Returns metrics only for a specific type of product activity. Accepted
   * values are:
   * - "sold": returns metrics only for products that were sold
   * - "advertised": returns metrics only for products that were advertised in a
   * Shopping campaign, and that might or might not have been sold
   */
  core.String productReportPerspective;
  /**
   * Name of a saved column to include in the report. The report must be scoped
   * at advertiser or lower, and this saved column must already be created in
   * the DoubleClick Search UI.
   */
  core.String savedColumnName;
  /**
   * Inclusive date in YYYY-MM-DD format. When provided, this overrides the
   * overall time range of the report for this column only. Must be provided
   * together with endDate.
   */
  core.String startDate;

  ReportApiColumnSpec();

  ReportApiColumnSpec.fromJson(core.Map _json) {
    if (_json.containsKey("columnName")) {
      columnName = _json["columnName"];
    }
    if (_json.containsKey("customDimensionName")) {
      customDimensionName = _json["customDimensionName"];
    }
    if (_json.containsKey("customMetricName")) {
      customMetricName = _json["customMetricName"];
    }
    if (_json.containsKey("endDate")) {
      endDate = _json["endDate"];
    }
    if (_json.containsKey("groupByColumn")) {
      groupByColumn = _json["groupByColumn"];
    }
    if (_json.containsKey("headerText")) {
      headerText = _json["headerText"];
    }
    if (_json.containsKey("platformSource")) {
      platformSource = _json["platformSource"];
    }
    if (_json.containsKey("productReportPerspective")) {
      productReportPerspective = _json["productReportPerspective"];
    }
    if (_json.containsKey("savedColumnName")) {
      savedColumnName = _json["savedColumnName"];
    }
    if (_json.containsKey("startDate")) {
      startDate = _json["startDate"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnName != null) {
      _json["columnName"] = columnName;
    }
    if (customDimensionName != null) {
      _json["customDimensionName"] = customDimensionName;
    }
    if (customMetricName != null) {
      _json["customMetricName"] = customMetricName;
    }
    if (endDate != null) {
      _json["endDate"] = endDate;
    }
    if (groupByColumn != null) {
      _json["groupByColumn"] = groupByColumn;
    }
    if (headerText != null) {
      _json["headerText"] = headerText;
    }
    if (platformSource != null) {
      _json["platformSource"] = platformSource;
    }
    if (productReportPerspective != null) {
      _json["productReportPerspective"] = productReportPerspective;
    }
    if (savedColumnName != null) {
      _json["savedColumnName"] = savedColumnName;
    }
    if (startDate != null) {
      _json["startDate"] = startDate;
    }
    return _json;
  }
}

class ReportRequestFilters {
  /**
   * Column to perform the filter on. This can be a DoubleClick Search column or
   * a saved column.
   */
  ReportApiColumnSpec column;
  /**
   * Operator to use in the filter. See the filter reference for a list of
   * available operators.
   */
  core.String operator;
  /**
   * A list of values to filter the column value against.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> values;

  ReportRequestFilters();

  ReportRequestFilters.fromJson(core.Map _json) {
    if (_json.containsKey("column")) {
      column = new ReportApiColumnSpec.fromJson(_json["column"]);
    }
    if (_json.containsKey("operator")) {
      operator = _json["operator"];
    }
    if (_json.containsKey("values")) {
      values = _json["values"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (column != null) {
      _json["column"] = (column).toJson();
    }
    if (operator != null) {
      _json["operator"] = operator;
    }
    if (values != null) {
      _json["values"] = values;
    }
    return _json;
  }
}

class ReportRequestOrderBy {
  /**
   * Column to perform the sort on. This can be a DoubleClick Search-defined
   * column or a saved column.
   */
  ReportApiColumnSpec column;
  /** The sort direction, which is either ascending or descending. */
  core.String sortOrder;

  ReportRequestOrderBy();

  ReportRequestOrderBy.fromJson(core.Map _json) {
    if (_json.containsKey("column")) {
      column = new ReportApiColumnSpec.fromJson(_json["column"]);
    }
    if (_json.containsKey("sortOrder")) {
      sortOrder = _json["sortOrder"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (column != null) {
      _json["column"] = (column).toJson();
    }
    if (sortOrder != null) {
      _json["sortOrder"] = sortOrder;
    }
    return _json;
  }
}

/**
 * The reportScope is a set of IDs that are used to determine which subset of
 * entities will be returned in the report. The full lineage of IDs from the
 * lowest scoped level desired up through agency is required.
 */
class ReportRequestReportScope {
  /** DS ad group ID. */
  core.String adGroupId;
  /** DS ad ID. */
  core.String adId;
  /** DS advertiser ID. */
  core.String advertiserId;
  /** DS agency ID. */
  core.String agencyId;
  /** DS campaign ID. */
  core.String campaignId;
  /** DS engine account ID. */
  core.String engineAccountId;
  /** DS keyword ID. */
  core.String keywordId;

  ReportRequestReportScope();

  ReportRequestReportScope.fromJson(core.Map _json) {
    if (_json.containsKey("adGroupId")) {
      adGroupId = _json["adGroupId"];
    }
    if (_json.containsKey("adId")) {
      adId = _json["adId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("agencyId")) {
      agencyId = _json["agencyId"];
    }
    if (_json.containsKey("campaignId")) {
      campaignId = _json["campaignId"];
    }
    if (_json.containsKey("engineAccountId")) {
      engineAccountId = _json["engineAccountId"];
    }
    if (_json.containsKey("keywordId")) {
      keywordId = _json["keywordId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adGroupId != null) {
      _json["adGroupId"] = adGroupId;
    }
    if (adId != null) {
      _json["adId"] = adId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (agencyId != null) {
      _json["agencyId"] = agencyId;
    }
    if (campaignId != null) {
      _json["campaignId"] = campaignId;
    }
    if (engineAccountId != null) {
      _json["engineAccountId"] = engineAccountId;
    }
    if (keywordId != null) {
      _json["keywordId"] = keywordId;
    }
    return _json;
  }
}

/**
 * If metrics are requested in a report, this argument will be used to restrict
 * the metrics to a specific time range.
 */
class ReportRequestTimeRange {
  /**
   * Inclusive UTC timestamp in RFC format, e.g., 2013-07-16T10:16:23.555Z. See
   * additional references on how changed attribute reports work.
   */
  core.DateTime changedAttributesSinceTimestamp;
  /**
   * Inclusive UTC timestamp in RFC format, e.g., 2013-07-16T10:16:23.555Z. See
   * additional references on how changed metrics reports work.
   */
  core.DateTime changedMetricsSinceTimestamp;
  /** Inclusive date in YYYY-MM-DD format. */
  core.String endDate;
  /** Inclusive date in YYYY-MM-DD format. */
  core.String startDate;

  ReportRequestTimeRange();

  ReportRequestTimeRange.fromJson(core.Map _json) {
    if (_json.containsKey("changedAttributesSinceTimestamp")) {
      changedAttributesSinceTimestamp = core.DateTime.parse(_json["changedAttributesSinceTimestamp"]);
    }
    if (_json.containsKey("changedMetricsSinceTimestamp")) {
      changedMetricsSinceTimestamp = core.DateTime.parse(_json["changedMetricsSinceTimestamp"]);
    }
    if (_json.containsKey("endDate")) {
      endDate = _json["endDate"];
    }
    if (_json.containsKey("startDate")) {
      startDate = _json["startDate"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (changedAttributesSinceTimestamp != null) {
      _json["changedAttributesSinceTimestamp"] = (changedAttributesSinceTimestamp).toIso8601String();
    }
    if (changedMetricsSinceTimestamp != null) {
      _json["changedMetricsSinceTimestamp"] = (changedMetricsSinceTimestamp).toIso8601String();
    }
    if (endDate != null) {
      _json["endDate"] = endDate;
    }
    if (startDate != null) {
      _json["startDate"] = startDate;
    }
    return _json;
  }
}

/** A request object used to create a DoubleClick Search report. */
class ReportRequest {
  /**
   * The columns to include in the report. This includes both DoubleClick Search
   * columns and saved columns. For DoubleClick Search columns, only the
   * columnName parameter is required. For saved columns only the
   * savedColumnName parameter is required. Both columnName and savedColumnName
   * cannot be set in the same stanza.
   */
  core.List<ReportApiColumnSpec> columns;
  /**
   * Format that the report should be returned in. Currently csv or tsv is
   * supported.
   */
  core.String downloadFormat;
  /** A list of filters to be applied to the report. */
  core.List<ReportRequestFilters> filters;
  /**
   * Determines if removed entities should be included in the report. Defaults
   * to false. Deprecated, please use includeRemovedEntities instead.
   */
  core.bool includeDeletedEntities;
  /**
   * Determines if removed entities should be included in the report. Defaults
   * to false.
   */
  core.bool includeRemovedEntities;
  /**
   * Asynchronous report only. The maximum number of rows per report file. A
   * large report is split into many files based on this field. Acceptable
   * values are 1000000 to 100000000, inclusive.
   */
  core.int maxRowsPerFile;
  /**
   * Synchronous report only. A list of columns and directions defining sorting
   * to be performed on the report rows.
   */
  core.List<ReportRequestOrderBy> orderBy;
  /**
   * The reportScope is a set of IDs that are used to determine which subset of
   * entities will be returned in the report. The full lineage of IDs from the
   * lowest scoped level desired up through agency is required.
   */
  ReportRequestReportScope reportScope;
  /**
   * Determines the type of rows that are returned in the report. For example,
   * if you specify reportType: keyword, each row in the report will contain
   * data about a keyword. See the Types of Reports reference for the columns
   * that are available for each type.
   */
  core.String reportType;
  /**
   * Synchronous report only. The maxinum number of rows to return; additional
   * rows are dropped. Acceptable values are 0 to 10000, inclusive. Defaults to
   * 10000.
   */
  core.int rowCount;
  /**
   * Synchronous report only. Zero-based index of the first row to return.
   * Acceptable values are 0 to 50000, inclusive. Defaults to 0.
   */
  core.int startRow;
  /**
   * Specifies the currency in which monetary will be returned. Possible values
   * are: usd, agency (valid if the report is scoped to agency or lower),
   * advertiser (valid if the report is scoped to * advertiser or lower), or
   * account (valid if the report is scoped to engine account or lower).
   */
  core.String statisticsCurrency;
  /**
   * If metrics are requested in a report, this argument will be used to
   * restrict the metrics to a specific time range.
   */
  ReportRequestTimeRange timeRange;
  /**
   * If true, the report would only be created if all the requested stat data
   * are sourced from a single timezone. Defaults to false.
   */
  core.bool verifySingleTimeZone;

  ReportRequest();

  ReportRequest.fromJson(core.Map _json) {
    if (_json.containsKey("columns")) {
      columns = _json["columns"].map((value) => new ReportApiColumnSpec.fromJson(value)).toList();
    }
    if (_json.containsKey("downloadFormat")) {
      downloadFormat = _json["downloadFormat"];
    }
    if (_json.containsKey("filters")) {
      filters = _json["filters"].map((value) => new ReportRequestFilters.fromJson(value)).toList();
    }
    if (_json.containsKey("includeDeletedEntities")) {
      includeDeletedEntities = _json["includeDeletedEntities"];
    }
    if (_json.containsKey("includeRemovedEntities")) {
      includeRemovedEntities = _json["includeRemovedEntities"];
    }
    if (_json.containsKey("maxRowsPerFile")) {
      maxRowsPerFile = _json["maxRowsPerFile"];
    }
    if (_json.containsKey("orderBy")) {
      orderBy = _json["orderBy"].map((value) => new ReportRequestOrderBy.fromJson(value)).toList();
    }
    if (_json.containsKey("reportScope")) {
      reportScope = new ReportRequestReportScope.fromJson(_json["reportScope"]);
    }
    if (_json.containsKey("reportType")) {
      reportType = _json["reportType"];
    }
    if (_json.containsKey("rowCount")) {
      rowCount = _json["rowCount"];
    }
    if (_json.containsKey("startRow")) {
      startRow = _json["startRow"];
    }
    if (_json.containsKey("statisticsCurrency")) {
      statisticsCurrency = _json["statisticsCurrency"];
    }
    if (_json.containsKey("timeRange")) {
      timeRange = new ReportRequestTimeRange.fromJson(_json["timeRange"]);
    }
    if (_json.containsKey("verifySingleTimeZone")) {
      verifySingleTimeZone = _json["verifySingleTimeZone"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columns != null) {
      _json["columns"] = columns.map((value) => (value).toJson()).toList();
    }
    if (downloadFormat != null) {
      _json["downloadFormat"] = downloadFormat;
    }
    if (filters != null) {
      _json["filters"] = filters.map((value) => (value).toJson()).toList();
    }
    if (includeDeletedEntities != null) {
      _json["includeDeletedEntities"] = includeDeletedEntities;
    }
    if (includeRemovedEntities != null) {
      _json["includeRemovedEntities"] = includeRemovedEntities;
    }
    if (maxRowsPerFile != null) {
      _json["maxRowsPerFile"] = maxRowsPerFile;
    }
    if (orderBy != null) {
      _json["orderBy"] = orderBy.map((value) => (value).toJson()).toList();
    }
    if (reportScope != null) {
      _json["reportScope"] = (reportScope).toJson();
    }
    if (reportType != null) {
      _json["reportType"] = reportType;
    }
    if (rowCount != null) {
      _json["rowCount"] = rowCount;
    }
    if (startRow != null) {
      _json["startRow"] = startRow;
    }
    if (statisticsCurrency != null) {
      _json["statisticsCurrency"] = statisticsCurrency;
    }
    if (timeRange != null) {
      _json["timeRange"] = (timeRange).toJson();
    }
    if (verifySingleTimeZone != null) {
      _json["verifySingleTimeZone"] = verifySingleTimeZone;
    }
    return _json;
  }
}

/**
 * A row in a DoubleClick Search report.
 *
 * Indicates the columns that are represented in this row. That is, each key
 * corresponds to a column with a non-empty cell in this row.
 */
class ReportRow
    extends collection.MapBase<core.String, core.Object> {
  final core.Map _innerMap = {};

  ReportRow();

  ReportRow.fromJson(core.Map _json) {
    _json.forEach((core.String key, value) {
      this[key] = value;
    });
  }

  core.Map toJson() {
    var _json = {};
    this.forEach((core.String key, value) {
      _json[key] = value;
    });
    return _json;
  }

  core.Object operator [](core.Object key)
      => _innerMap[key];

  operator []=(core.String key, core.Object value) {
    _innerMap[key] = value;
  }

  void clear() {
    _innerMap.clear();
  }

  core.Iterable<core.String> get keys => _innerMap.keys;

  core.Object remove(core.Object key) => _innerMap.remove(key);
}

/** A saved column */
class SavedColumn {
  /**
   * Identifies this as a SavedColumn resource. Value: the fixed string
   * doubleclicksearch#savedColumn.
   */
  core.String kind;
  /** The name of the saved column. */
  core.String savedColumnName;
  /** The type of data this saved column will produce. */
  core.String type;

  SavedColumn();

  SavedColumn.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("savedColumnName")) {
      savedColumnName = _json["savedColumnName"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (savedColumnName != null) {
      _json["savedColumnName"] = savedColumnName;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * A list of saved columns. Advertisers create saved columns to report on
 * Floodlight activities, Google Analytics goals, or custom KPIs. To request
 * reports with saved columns, you'll need the saved column names that are
 * available from this list.
 */
class SavedColumnList {
  /** The saved columns being requested. */
  core.List<SavedColumn> items;
  /**
   * Identifies this as a SavedColumnList resource. Value: the fixed string
   * doubleclicksearch#savedColumnList.
   */
  core.String kind;

  SavedColumnList();

  SavedColumnList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new SavedColumn.fromJson(value)).toList();
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

/** The request to update availability. */
class UpdateAvailabilityRequest {
  /** The availabilities being requested. */
  core.List<Availability> availabilities;

  UpdateAvailabilityRequest();

  UpdateAvailabilityRequest.fromJson(core.Map _json) {
    if (_json.containsKey("availabilities")) {
      availabilities = _json["availabilities"].map((value) => new Availability.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (availabilities != null) {
      _json["availabilities"] = availabilities.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The response to a update availability request. */
class UpdateAvailabilityResponse {
  /** The availabilities being returned. */
  core.List<Availability> availabilities;

  UpdateAvailabilityResponse();

  UpdateAvailabilityResponse.fromJson(core.Map _json) {
    if (_json.containsKey("availabilities")) {
      availabilities = _json["availabilities"].map((value) => new Availability.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (availabilities != null) {
      _json["availabilities"] = availabilities.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
