// This is a generated file (see the discoveryapis_generator project).

library googleapis.licensing.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client licensing/v1';

/** Licensing API to view and manage license for your domain. */
class LicensingApi {
  /** View and manage G Suite licenses for your domain */
  static const AppsLicensingScope = "https://www.googleapis.com/auth/apps.licensing";


  final commons.ApiRequester _requester;

  LicenseAssignmentsResourceApi get licenseAssignments => new LicenseAssignmentsResourceApi(_requester);

  LicensingApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "apps/licensing/v1/product/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class LicenseAssignmentsResourceApi {
  final commons.ApiRequester _requester;

  LicenseAssignmentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Revoke License.
   *
   * Request parameters:
   *
   * [productId] - Name for product
   *
   * [skuId] - Name for sku
   *
   * [userId] - email id or unique Id of the user
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String productId, core.String skuId, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if (skuId == null) {
      throw new core.ArgumentError("Parameter skuId is required.");
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$productId') + '/sku/' + commons.Escaper.ecapeVariable('$skuId') + '/user/' + commons.Escaper.ecapeVariable('$userId');

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
   * Get license assignment of a particular product and sku for a user
   *
   * Request parameters:
   *
   * [productId] - Name for product
   *
   * [skuId] - Name for sku
   *
   * [userId] - email id or unique Id of the user
   *
   * Completes with a [LicenseAssignment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LicenseAssignment> get(core.String productId, core.String skuId, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if (skuId == null) {
      throw new core.ArgumentError("Parameter skuId is required.");
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$productId') + '/sku/' + commons.Escaper.ecapeVariable('$skuId') + '/user/' + commons.Escaper.ecapeVariable('$userId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LicenseAssignment.fromJson(data));
  }

  /**
   * Assign License.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [productId] - Name for product
   *
   * [skuId] - Name for sku
   *
   * Completes with a [LicenseAssignment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LicenseAssignment> insert(LicenseAssignmentInsert request, core.String productId, core.String skuId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if (skuId == null) {
      throw new core.ArgumentError("Parameter skuId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$productId') + '/sku/' + commons.Escaper.ecapeVariable('$skuId') + '/user';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LicenseAssignment.fromJson(data));
  }

  /**
   * List license assignments for given product of the customer.
   *
   * Request parameters:
   *
   * [productId] - Name for product
   *
   * [customerId] - CustomerId represents the customer for whom
   * licenseassignments are queried
   *
   * [maxResults] - Maximum number of campaigns to return at one time. Must be
   * positive. Optional. Default value is 100.
   * Value must be between "1" and "1000".
   *
   * [pageToken] - Token to fetch the next page.Optional. By default server will
   * return first page
   *
   * Completes with a [LicenseAssignmentList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LicenseAssignmentList> listForProduct(core.String productId, core.String customerId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }
    _queryParams["customerId"] = [customerId];
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$productId') + '/users';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LicenseAssignmentList.fromJson(data));
  }

  /**
   * List license assignments for given product and sku of the customer.
   *
   * Request parameters:
   *
   * [productId] - Name for product
   *
   * [skuId] - Name for sku
   *
   * [customerId] - CustomerId represents the customer for whom
   * licenseassignments are queried
   *
   * [maxResults] - Maximum number of campaigns to return at one time. Must be
   * positive. Optional. Default value is 100.
   * Value must be between "1" and "1000".
   *
   * [pageToken] - Token to fetch the next page.Optional. By default server will
   * return first page
   *
   * Completes with a [LicenseAssignmentList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LicenseAssignmentList> listForProductAndSku(core.String productId, core.String skuId, core.String customerId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if (skuId == null) {
      throw new core.ArgumentError("Parameter skuId is required.");
    }
    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }
    _queryParams["customerId"] = [customerId];
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$productId') + '/sku/' + commons.Escaper.ecapeVariable('$skuId') + '/users';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LicenseAssignmentList.fromJson(data));
  }

  /**
   * Assign License. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [productId] - Name for product
   *
   * [skuId] - Name for sku for which license would be revoked
   *
   * [userId] - email id or unique Id of the user
   *
   * Completes with a [LicenseAssignment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LicenseAssignment> patch(LicenseAssignment request, core.String productId, core.String skuId, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if (skuId == null) {
      throw new core.ArgumentError("Parameter skuId is required.");
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$productId') + '/sku/' + commons.Escaper.ecapeVariable('$skuId') + '/user/' + commons.Escaper.ecapeVariable('$userId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LicenseAssignment.fromJson(data));
  }

  /**
   * Assign License.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [productId] - Name for product
   *
   * [skuId] - Name for sku for which license would be revoked
   *
   * [userId] - email id or unique Id of the user
   *
   * Completes with a [LicenseAssignment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LicenseAssignment> update(LicenseAssignment request, core.String productId, core.String skuId, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if (skuId == null) {
      throw new core.ArgumentError("Parameter skuId is required.");
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$productId') + '/sku/' + commons.Escaper.ecapeVariable('$skuId') + '/user/' + commons.Escaper.ecapeVariable('$userId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LicenseAssignment.fromJson(data));
  }

}



/** Template for LiscenseAssignment Resource */
class LicenseAssignment {
  /** ETag of the resource. */
  core.String etags;
  /** Identifies the resource as a LicenseAssignment. */
  core.String kind;
  /** Name of the product. */
  core.String productId;
  /** Link to this page. */
  core.String selfLink;
  /** Name of the sku of the product. */
  core.String skuId;
  /** Email id of the user. */
  core.String userId;

  LicenseAssignment();

  LicenseAssignment.fromJson(core.Map _json) {
    if (_json.containsKey("etags")) {
      etags = _json["etags"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("skuId")) {
      skuId = _json["skuId"];
    }
    if (_json.containsKey("userId")) {
      userId = _json["userId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etags != null) {
      _json["etags"] = etags;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (skuId != null) {
      _json["skuId"] = skuId;
    }
    if (userId != null) {
      _json["userId"] = userId;
    }
    return _json;
  }
}

/** Template for LicenseAssignment Insert request */
class LicenseAssignmentInsert {
  /** Email id of the user */
  core.String userId;

  LicenseAssignmentInsert();

  LicenseAssignmentInsert.fromJson(core.Map _json) {
    if (_json.containsKey("userId")) {
      userId = _json["userId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (userId != null) {
      _json["userId"] = userId;
    }
    return _json;
  }
}

/** LicesnseAssignment List for a given product/sku for a customer. */
class LicenseAssignmentList {
  /** ETag of the resource. */
  core.String etag;
  /** The LicenseAssignments in this page of results. */
  core.List<LicenseAssignment> items;
  /** Identifies the resource as a collection of LicenseAssignments. */
  core.String kind;
  /**
   * The continuation token, used to page through large result sets. Provide
   * this value in a subsequent request to return the next page of results.
   */
  core.String nextPageToken;

  LicenseAssignmentList();

  LicenseAssignmentList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new LicenseAssignment.fromJson(value)).toList();
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
