// This is a generated file (see the discoveryapis_generator project).

library googleapis.manufacturers.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client manufacturers/v1';

/** Public API for managing Manufacturer Center related data. */
class ManufacturersApi {
  /** Manage your product listings for Google Manufacturer Center */
  static const ManufacturercenterScope = "https://www.googleapis.com/auth/manufacturercenter";


  final commons.ApiRequester _requester;

  AccountsResourceApi get accounts => new AccountsResourceApi(_requester);

  ManufacturersApi(http.Client client, {core.String rootUrl: "https://manufacturers.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AccountsResourceApi {
  final commons.ApiRequester _requester;

  AccountsProductsResourceApi get products => new AccountsProductsResourceApi(_requester);

  AccountsResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class AccountsProductsResourceApi {
  final commons.ApiRequester _requester;

  AccountsProductsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the product from a Manufacturer Center account, including product
   * issues.
   *
   * Request parameters:
   *
   * [parent] - Parent ID in the format `accounts/{account_id}`.
   *
   * `account_id` - The ID of the Manufacturer Center account.
   * Value must have pattern "^accounts/[^/]+$".
   *
   * [name] - Name in the format
   * `{target_country}:{content_language}:{product_id}`.
   *
   * `target_country`   - The target country of the product as a CLDR territory
   *                      code (for example, US).
   *
   * `content_language` - The content language of the product as a two-letter
   *                      ISO 639-1 language code (for example, en).
   *
   * `product_id`     -   The ID of the product. For more information, see
   * https://support.google.com/manufacturers/answer/6124116#id.
   * Value must have pattern "^[^/]+$".
   *
   * Completes with a [Product].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Product> get(core.String parent, core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (parent == null) {
      throw new core.ArgumentError("Parameter parent is required.");
    }
    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$parent') + '/products/' + commons.Escaper.ecapeVariableReserved('$name');

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
   * Lists all the products in a Manufacturer Center account.
   *
   * Request parameters:
   *
   * [parent] - Parent ID in the format `accounts/{account_id}`.
   *
   * `account_id` - The ID of the Manufacturer Center account.
   * Value must have pattern "^accounts/[^/]+$".
   *
   * [pageToken] - The token returned by the previous request.
   *
   * [pageSize] - Maximum number of product statuses to return in the response,
   * used for
   * paging.
   *
   * Completes with a [ListProductsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListProductsResponse> list(core.String parent, {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (parent == null) {
      throw new core.ArgumentError("Parameter parent is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$parent') + '/products';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListProductsResponse.fromJson(data));
  }

}



/**
 * Attributes of the product. For more information, see
 * https://support.google.com/manufacturers/answer/6124116.
 */
class Attributes {
  /**
   * The brand name of the product. For more information, see
   * https://support.google.com/manufacturers/answer/6124116#brand.
   */
  core.String brand;
  /**
   * The Global Trade Item Number (GTIN) of the product. For more information,
   * see https://support.google.com/manufacturers/answer/6124116#gtin.
   */
  core.List<core.String> gtin;
  /**
   * The Manufacturer Part Number (MPN) of the product. For more information,
   * see https://support.google.com/manufacturers/answer/6124116#mpn.
   */
  core.String mpn;
  /**
   * The name of the group of products related to the product. For more
   * information, see
   * https://support.google.com/manufacturers/answer/6124116#productline.
   */
  core.String productLine;
  /**
   * The canonical name of the product. For more information, see
   * https://support.google.com/manufacturers/answer/6124116#productname.
   */
  core.String productName;
  /**
   * The URL of the manufacturer's detail page of the product. For more
   * information, see
   * https://support.google.com/manufacturers/answer/6124116#productpage.
   */
  core.String productPageUrl;
  /**
   * The manufacturer's category of the product. For more information, see
   * https://support.google.com/manufacturers/answer/6124116#producttype.
   */
  core.List<core.String> productType;
  /**
   * The title of the product. For more information, see
   * https://support.google.com/manufacturers/answer/6124116#title.
   */
  core.String title;

  Attributes();

  Attributes.fromJson(core.Map _json) {
    if (_json.containsKey("brand")) {
      brand = _json["brand"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("mpn")) {
      mpn = _json["mpn"];
    }
    if (_json.containsKey("productLine")) {
      productLine = _json["productLine"];
    }
    if (_json.containsKey("productName")) {
      productName = _json["productName"];
    }
    if (_json.containsKey("productPageUrl")) {
      productPageUrl = _json["productPageUrl"];
    }
    if (_json.containsKey("productType")) {
      productType = _json["productType"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (brand != null) {
      _json["brand"] = brand;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (mpn != null) {
      _json["mpn"] = mpn;
    }
    if (productLine != null) {
      _json["productLine"] = productLine;
    }
    if (productName != null) {
      _json["productName"] = productName;
    }
    if (productPageUrl != null) {
      _json["productPageUrl"] = productPageUrl;
    }
    if (productType != null) {
      _json["productType"] = productType;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** Product issue. */
class Issue {
  /**
   * If present, the attribute that triggered the issue. For more information
   * about attributes, see
   * https://support.google.com/manufacturers/answer/6124116.
   */
  core.String attribute;
  /** Description of the issue. */
  core.String description;
  /**
   * The severity of the issue.
   * Possible string values are:
   * - "SEVERITY_UNSPECIFIED" : Unspecified severity, never used.
   * - "ERROR" : Error severity. The issue prevents the usage of the whole item.
   * - "WARNING" : Warning severity. The issue is either one that prevents the
   * usage of the
   * attribute that triggered it or one that will soon prevent the usage of
   * the whole item.
   * - "INFO" : Info severity. The issue is one that doesn't require immediate
   * attention.
   * It is, for example, used to communicate which attributes are still
   * pending review.
   */
  core.String severity;
  /**
   * The server-generated type of the issue, for example,
   * “INCORRECT_TEXT_FORMATTING”, “IMAGE_NOT_SERVEABLE”, etc.
   */
  core.String type;

  Issue();

  Issue.fromJson(core.Map _json) {
    if (_json.containsKey("attribute")) {
      attribute = _json["attribute"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
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
    if (attribute != null) {
      _json["attribute"] = attribute;
    }
    if (description != null) {
      _json["description"] = description;
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

class ListProductsResponse {
  /** The token for the retrieval of the next page of product statuses. */
  core.String nextPageToken;
  /** List of the products. */
  core.List<Product> products;

  ListProductsResponse();

  ListProductsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("products")) {
      products = _json["products"].map((value) => new Product.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (products != null) {
      _json["products"] = products.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Product data. */
class Product {
  /**
   * The content language of the product as a two-letter ISO 639-1 language code
   * (for example, en).
   * @OutputOnly
   */
  core.String contentLanguage;
  /**
   * Final attributes of the product. The final attributes are obtained by
   * overriding the uploaded attributes with the manually provided and deleted
   * attributes. Google systems only process, evaluate, review, and/or use final
   * attributes.
   * @OutputOnly
   */
  Attributes finalAttributes;
  /**
   * A server-generated list of issues associated with the product.
   * @OutputOnly
   */
  core.List<Issue> issues;
  /**
   * Names of the attributes of the product deleted manually via the
   * Manufacturer Center UI.
   * @OutputOnly
   */
  core.List<core.String> manuallyDeletedAttributes;
  /**
   * Attributes of the product provided manually via the Manufacturer Center UI.
   * @OutputOnly
   */
  Attributes manuallyProvidedAttributes;
  /**
   * Name in the format `{target_country}:{content_language}:{product_id}`.
   *
   * `target_country`   - The target country of the product as a CLDR territory
   *                      code (for example, US).
   *
   * `content_language` - The content language of the product as a two-letter
   *                      ISO 639-1 language code (for example, en).
   *
   * `product_id`     -   The ID of the product. For more information, see
   * https://support.google.com/manufacturers/answer/6124116#id.
   * @OutputOnly
   */
  core.String name;
  /**
   * Parent ID in the format `accounts/{account_id}`.
   *
   * `account_id` - The ID of the Manufacturer Center account.
   * @OutputOnly
   */
  core.String parent;
  /**
   * The ID of the product. For more information, see
   * https://support.google.com/manufacturers/answer/6124116#id.
   * @OutputOnly
   */
  core.String productId;
  /**
   * The target country of the product as a CLDR territory code (for example,
   * US).
   * @OutputOnly
   */
  core.String targetCountry;
  /**
   * Attributes of the product uploaded via the Manufacturer Center API or via
   * feeds.
   */
  Attributes uploadedAttributes;

  Product();

  Product.fromJson(core.Map _json) {
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("finalAttributes")) {
      finalAttributes = new Attributes.fromJson(_json["finalAttributes"]);
    }
    if (_json.containsKey("issues")) {
      issues = _json["issues"].map((value) => new Issue.fromJson(value)).toList();
    }
    if (_json.containsKey("manuallyDeletedAttributes")) {
      manuallyDeletedAttributes = _json["manuallyDeletedAttributes"];
    }
    if (_json.containsKey("manuallyProvidedAttributes")) {
      manuallyProvidedAttributes = new Attributes.fromJson(_json["manuallyProvidedAttributes"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parent")) {
      parent = _json["parent"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("uploadedAttributes")) {
      uploadedAttributes = new Attributes.fromJson(_json["uploadedAttributes"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (finalAttributes != null) {
      _json["finalAttributes"] = (finalAttributes).toJson();
    }
    if (issues != null) {
      _json["issues"] = issues.map((value) => (value).toJson()).toList();
    }
    if (manuallyDeletedAttributes != null) {
      _json["manuallyDeletedAttributes"] = manuallyDeletedAttributes;
    }
    if (manuallyProvidedAttributes != null) {
      _json["manuallyProvidedAttributes"] = (manuallyProvidedAttributes).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parent != null) {
      _json["parent"] = parent;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (uploadedAttributes != null) {
      _json["uploadedAttributes"] = (uploadedAttributes).toJson();
    }
    return _json;
  }
}
