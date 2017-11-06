// This is a generated file (see the discoveryapis_generator project).

library googleapis.content.v2sandbox;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client content/v2sandbox';

/**
 * Manages product items, inventory, and Merchant Center accounts for Google
 * Shopping.
 */
class ContentApi {
  /** Manage your product listings and accounts for Google Shopping */
  static const ContentScope = "https://www.googleapis.com/auth/content";


  final commons.ApiRequester _requester;

  OrdersResourceApi get orders => new OrdersResourceApi(_requester);

  ContentApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "content/v2sandbox/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class OrdersResourceApi {
  final commons.ApiRequester _requester;

  OrdersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Marks an order as acknowledged. This method can only be called for
   * non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [OrdersAcknowledgeResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersAcknowledgeResponse> acknowledge(OrdersAcknowledgeRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/acknowledge';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersAcknowledgeResponse.fromJson(data));
  }

  /**
   * Sandbox only. Moves a test order from state "inProgress" to state
   * "pendingShipment". This method can only be called for non-multi-client
   * accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the test order to modify.
   *
   * Completes with a [OrdersAdvanceTestOrderResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersAdvanceTestOrderResponse> advancetestorder(core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/testorders/' + commons.Escaper.ecapeVariable('$orderId') + '/advance';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersAdvanceTestOrderResponse.fromJson(data));
  }

  /**
   * Cancels all line items in an order. This method can only be called for
   * non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order to cancel.
   *
   * Completes with a [OrdersCancelResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersCancelResponse> cancel(OrdersCancelRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/cancel';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersCancelResponse.fromJson(data));
  }

  /**
   * Cancels a line item. This method can only be called for non-multi-client
   * accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [OrdersCancelLineItemResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersCancelLineItemResponse> cancellineitem(OrdersCancelLineItemRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/cancelLineItem';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersCancelLineItemResponse.fromJson(data));
  }

  /**
   * Sandbox only. Creates a test order. This method can only be called for
   * non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * Completes with a [OrdersCreateTestOrderResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersCreateTestOrderResponse> createtestorder(OrdersCreateTestOrderRequest request, core.String merchantId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/testorders';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersCreateTestOrderResponse.fromJson(data));
  }

  /**
   * Retrieves or modifies multiple orders in a single request. This method can
   * only be called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [OrdersCustomBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersCustomBatchResponse> custombatch(OrdersCustomBatchRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'orders/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersCustomBatchResponse.fromJson(data));
  }

  /**
   * Retrieves an order from your Merchant Center account. This method can only
   * be called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [Order].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Order> get(core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId');

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
   * Retrieves an order using merchant order id. This method can only be called
   * for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [merchantOrderId] - The merchant order id to be looked for.
   *
   * Completes with a [OrdersGetByMerchantOrderIdResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersGetByMerchantOrderIdResponse> getbymerchantorderid(core.String merchantId, core.String merchantOrderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (merchantOrderId == null) {
      throw new core.ArgumentError("Parameter merchantOrderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/ordersbymerchantid/' + commons.Escaper.ecapeVariable('$merchantOrderId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersGetByMerchantOrderIdResponse.fromJson(data));
  }

  /**
   * Sandbox only. Retrieves an order template that can be used to quickly
   * create a new order in sandbox. This method can only be called for
   * non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [templateName] - The name of the template to retrieve.
   * Possible string values are:
   * - "template1"
   * - "template1a"
   * - "template1b"
   * - "template2"
   *
   * Completes with a [OrdersGetTestOrderTemplateResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersGetTestOrderTemplateResponse> gettestordertemplate(core.String merchantId, core.String templateName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (templateName == null) {
      throw new core.ArgumentError("Parameter templateName is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/testordertemplates/' + commons.Escaper.ecapeVariable('$templateName');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersGetTestOrderTemplateResponse.fromJson(data));
  }

  /**
   * Lists the orders in your Merchant Center account. This method can only be
   * called for non-multi-client accounts.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [acknowledged] - Obtains orders that match the acknowledgement status. When
   * set to true, obtains orders that have been acknowledged. When false,
   * obtains orders that have not been acknowledged.
   * We recommend using this filter set to false, in conjunction with the
   * acknowledge call, such that only un-acknowledged orders are returned.
   *
   * [maxResults] - The maximum number of orders to return in the response, used
   * for paging. The default value is 25 orders per page, and the maximum
   * allowed value is 250 orders per page.
   * Known issue: All List calls will return all Orders without limit regardless
   * of the value of this field.
   *
   * [orderBy] - The ordering of the returned list. The only supported value are
   * placedDate desc and placedDate asc for now, which returns orders sorted by
   * placement date. "placedDate desc" stands for listing orders by placement
   * date, from oldest to most recent. "placedDate asc" stands for listing
   * orders by placement date, from most recent to oldest. In future releases
   * we'll support other sorting criteria.
   * Possible string values are:
   * - "placedDate asc"
   * - "placedDate desc"
   *
   * [pageToken] - The token returned by the previous request.
   *
   * [placedDateEnd] - Obtains orders placed before this date (exclusively), in
   * ISO 8601 format.
   *
   * [placedDateStart] - Obtains orders placed after this date (inclusively), in
   * ISO 8601 format.
   *
   * [statuses] - Obtains orders that match any of the specified statuses.
   * Multiple values can be specified with comma separation. Additionally,
   * please note that active is a shortcut for pendingShipment and
   * partiallyShipped, and completed is a shortcut for shipped ,
   * partiallyDelivered, delivered, partiallyReturned, returned, and canceled.
   *
   * Completes with a [OrdersListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersListResponse> list(core.String merchantId, {core.bool acknowledged, core.int maxResults, core.String orderBy, core.String pageToken, core.String placedDateEnd, core.String placedDateStart, core.List<core.String> statuses}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (acknowledged != null) {
      _queryParams["acknowledged"] = ["${acknowledged}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (placedDateEnd != null) {
      _queryParams["placedDateEnd"] = [placedDateEnd];
    }
    if (placedDateStart != null) {
      _queryParams["placedDateStart"] = [placedDateStart];
    }
    if (statuses != null) {
      _queryParams["statuses"] = statuses;
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersListResponse.fromJson(data));
  }

  /**
   * Refund a portion of the order, up to the full amount paid. This method can
   * only be called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order to refund.
   *
   * Completes with a [OrdersRefundResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersRefundResponse> refund(OrdersRefundRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/refund';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersRefundResponse.fromJson(data));
  }

  /**
   * Returns a line item. This method can only be called for non-multi-client
   * accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [OrdersReturnLineItemResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersReturnLineItemResponse> returnlineitem(OrdersReturnLineItemRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/returnLineItem';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersReturnLineItemResponse.fromJson(data));
  }

  /**
   * Marks line item(s) as shipped. This method can only be called for
   * non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [OrdersShipLineItemsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersShipLineItemsResponse> shiplineitems(OrdersShipLineItemsRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/shipLineItems';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersShipLineItemsResponse.fromJson(data));
  }

  /**
   * Updates the merchant order ID for a given order. This method can only be
   * called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [OrdersUpdateMerchantOrderIdResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersUpdateMerchantOrderIdResponse> updatemerchantorderid(OrdersUpdateMerchantOrderIdRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/updateMerchantOrderId';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersUpdateMerchantOrderIdResponse.fromJson(data));
  }

  /**
   * Updates a shipment's status, carrier, and/or tracking ID. This method can
   * only be called for non-multi-client accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [merchantId] - The ID of the managing account.
   *
   * [orderId] - The ID of the order.
   *
   * Completes with a [OrdersUpdateShipmentResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersUpdateShipmentResponse> updateshipment(OrdersUpdateShipmentRequest request, core.String merchantId, core.String orderId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders/' + commons.Escaper.ecapeVariable('$orderId') + '/updateShipment';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersUpdateShipmentResponse.fromJson(data));
  }

}



/** An error returned by the API. */
class Error {
  /** The domain of the error. */
  core.String domain;
  /** A description of the error. */
  core.String message;
  /** The error code. */
  core.String reason;

  Error();

  Error.fromJson(core.Map _json) {
    if (_json.containsKey("domain")) {
      domain = _json["domain"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (domain != null) {
      _json["domain"] = domain;
    }
    if (message != null) {
      _json["message"] = message;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    return _json;
  }
}

/** A list of errors returned by a failed batch entry. */
class Errors {
  /** The HTTP status of the first error in errors. */
  core.int code;
  /** A list of errors. */
  core.List<Error> errors;
  /** The message of the first error in errors. */
  core.String message;

  Errors();

  Errors.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"].map((value) => new Error.fromJson(value)).toList();
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (code != null) {
      _json["code"] = code;
    }
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

class Order {
  /** Whether the order was acknowledged. */
  core.bool acknowledged;
  /** The channel type of the order: "purchaseOnGoogle" or "googleExpress". */
  core.String channelType;
  /** The details of the customer who placed the order. */
  OrderCustomer customer;
  /** The details for the delivery. */
  OrderDeliveryDetails deliveryDetails;
  /** The REST id of the order. Globally unique. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#order".
   */
  core.String kind;
  /** Line items that are ordered. */
  core.List<OrderLineItem> lineItems;
  core.String merchantId;
  /** Merchant-provided id of the order. */
  core.String merchantOrderId;
  /**
   * The net amount for the order. For example, if an order was originally for a
   * grand total of $100 and a refund was issued for $20, the net amount will be
   * $80.
   */
  Price netAmount;
  /** The details of the payment method. */
  OrderPaymentMethod paymentMethod;
  /** The status of the payment. */
  core.String paymentStatus;
  /** The date when the order was placed, in ISO 8601 format. */
  core.String placedDate;
  /**
   * The details of the merchant provided promotions applied to the order. More
   * details about the program are  here.
   */
  core.List<OrderPromotion> promotions;
  /** Refunds for the order. */
  core.List<OrderRefund> refunds;
  /** Shipments of the order. */
  core.List<OrderShipment> shipments;
  /** The total cost of shipping for all items. */
  Price shippingCost;
  /** The tax for the total shipping cost. */
  Price shippingCostTax;
  /** The requested shipping option. */
  core.String shippingOption;
  /** The status of the order. */
  core.String status;

  Order();

  Order.fromJson(core.Map _json) {
    if (_json.containsKey("acknowledged")) {
      acknowledged = _json["acknowledged"];
    }
    if (_json.containsKey("channelType")) {
      channelType = _json["channelType"];
    }
    if (_json.containsKey("customer")) {
      customer = new OrderCustomer.fromJson(_json["customer"]);
    }
    if (_json.containsKey("deliveryDetails")) {
      deliveryDetails = new OrderDeliveryDetails.fromJson(_json["deliveryDetails"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"].map((value) => new OrderLineItem.fromJson(value)).toList();
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("merchantOrderId")) {
      merchantOrderId = _json["merchantOrderId"];
    }
    if (_json.containsKey("netAmount")) {
      netAmount = new Price.fromJson(_json["netAmount"]);
    }
    if (_json.containsKey("paymentMethod")) {
      paymentMethod = new OrderPaymentMethod.fromJson(_json["paymentMethod"]);
    }
    if (_json.containsKey("paymentStatus")) {
      paymentStatus = _json["paymentStatus"];
    }
    if (_json.containsKey("placedDate")) {
      placedDate = _json["placedDate"];
    }
    if (_json.containsKey("promotions")) {
      promotions = _json["promotions"].map((value) => new OrderPromotion.fromJson(value)).toList();
    }
    if (_json.containsKey("refunds")) {
      refunds = _json["refunds"].map((value) => new OrderRefund.fromJson(value)).toList();
    }
    if (_json.containsKey("shipments")) {
      shipments = _json["shipments"].map((value) => new OrderShipment.fromJson(value)).toList();
    }
    if (_json.containsKey("shippingCost")) {
      shippingCost = new Price.fromJson(_json["shippingCost"]);
    }
    if (_json.containsKey("shippingCostTax")) {
      shippingCostTax = new Price.fromJson(_json["shippingCostTax"]);
    }
    if (_json.containsKey("shippingOption")) {
      shippingOption = _json["shippingOption"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (acknowledged != null) {
      _json["acknowledged"] = acknowledged;
    }
    if (channelType != null) {
      _json["channelType"] = channelType;
    }
    if (customer != null) {
      _json["customer"] = (customer).toJson();
    }
    if (deliveryDetails != null) {
      _json["deliveryDetails"] = (deliveryDetails).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (merchantOrderId != null) {
      _json["merchantOrderId"] = merchantOrderId;
    }
    if (netAmount != null) {
      _json["netAmount"] = (netAmount).toJson();
    }
    if (paymentMethod != null) {
      _json["paymentMethod"] = (paymentMethod).toJson();
    }
    if (paymentStatus != null) {
      _json["paymentStatus"] = paymentStatus;
    }
    if (placedDate != null) {
      _json["placedDate"] = placedDate;
    }
    if (promotions != null) {
      _json["promotions"] = promotions.map((value) => (value).toJson()).toList();
    }
    if (refunds != null) {
      _json["refunds"] = refunds.map((value) => (value).toJson()).toList();
    }
    if (shipments != null) {
      _json["shipments"] = shipments.map((value) => (value).toJson()).toList();
    }
    if (shippingCost != null) {
      _json["shippingCost"] = (shippingCost).toJson();
    }
    if (shippingCostTax != null) {
      _json["shippingCostTax"] = (shippingCostTax).toJson();
    }
    if (shippingOption != null) {
      _json["shippingOption"] = shippingOption;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

class OrderAddress {
  /** CLDR country code (e.g. "US"). */
  core.String country;
  /**
   * Strings representing the lines of the printed label for mailing the order,
   * for example:
   * John Smith
   * 1600 Amphitheatre Parkway
   * Mountain View, CA, 94043
   * United States
   */
  core.List<core.String> fullAddress;
  /** Whether the address is a post office box. */
  core.bool isPostOfficeBox;
  /**
   * City, town or commune. May also include dependent localities or
   * sublocalities (e.g. neighborhoods or suburbs).
   */
  core.String locality;
  /** Postal Code or ZIP (e.g. "94043"). */
  core.String postalCode;
  /** Name of the recipient. */
  core.String recipientName;
  /** Top-level administrative subdivision of the country (e.g. "CA"). */
  core.String region;
  /** Street-level part of the address. */
  core.List<core.String> streetAddress;

  OrderAddress();

  OrderAddress.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("fullAddress")) {
      fullAddress = _json["fullAddress"];
    }
    if (_json.containsKey("isPostOfficeBox")) {
      isPostOfficeBox = _json["isPostOfficeBox"];
    }
    if (_json.containsKey("locality")) {
      locality = _json["locality"];
    }
    if (_json.containsKey("postalCode")) {
      postalCode = _json["postalCode"];
    }
    if (_json.containsKey("recipientName")) {
      recipientName = _json["recipientName"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("streetAddress")) {
      streetAddress = _json["streetAddress"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (fullAddress != null) {
      _json["fullAddress"] = fullAddress;
    }
    if (isPostOfficeBox != null) {
      _json["isPostOfficeBox"] = isPostOfficeBox;
    }
    if (locality != null) {
      _json["locality"] = locality;
    }
    if (postalCode != null) {
      _json["postalCode"] = postalCode;
    }
    if (recipientName != null) {
      _json["recipientName"] = recipientName;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (streetAddress != null) {
      _json["streetAddress"] = streetAddress;
    }
    return _json;
  }
}

class OrderCancellation {
  /** The actor that created the cancellation. */
  core.String actor;
  /** Date on which the cancellation has been created, in ISO 8601 format. */
  core.String creationDate;
  /** The quantity that was canceled. */
  core.int quantity;
  /**
   * The reason for the cancellation. Orders that are cancelled with a
   * noInventory reason will lead to the removal of the product from POG until
   * you make an update to that product. This will not affect your Shopping ads.
   */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrderCancellation();

  OrderCancellation.fromJson(core.Map _json) {
    if (_json.containsKey("actor")) {
      actor = _json["actor"];
    }
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (actor != null) {
      _json["actor"] = actor;
    }
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrderCustomer {
  /** Email address of the customer. */
  core.String email;
  /**
   * If set, this indicates the user explicitly chose to opt in or out of
   * providing marketing rights to the merchant. If unset, this indicates the
   * user has already made this choice in a previous purchase, and was thus not
   * shown the marketing right opt in/out checkbox during the checkout flow.
   */
  core.bool explicitMarketingPreference;
  /** Full name of the customer. */
  core.String fullName;

  OrderCustomer();

  OrderCustomer.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("explicitMarketingPreference")) {
      explicitMarketingPreference = _json["explicitMarketingPreference"];
    }
    if (_json.containsKey("fullName")) {
      fullName = _json["fullName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (email != null) {
      _json["email"] = email;
    }
    if (explicitMarketingPreference != null) {
      _json["explicitMarketingPreference"] = explicitMarketingPreference;
    }
    if (fullName != null) {
      _json["fullName"] = fullName;
    }
    return _json;
  }
}

class OrderDeliveryDetails {
  /** The delivery address */
  OrderAddress address;
  /** The phone number of the person receiving the delivery. */
  core.String phoneNumber;

  OrderDeliveryDetails();

  OrderDeliveryDetails.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = new OrderAddress.fromJson(_json["address"]);
    }
    if (_json.containsKey("phoneNumber")) {
      phoneNumber = _json["phoneNumber"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (address != null) {
      _json["address"] = (address).toJson();
    }
    if (phoneNumber != null) {
      _json["phoneNumber"] = phoneNumber;
    }
    return _json;
  }
}

class OrderLineItem {
  /** Cancellations of the line item. */
  core.List<OrderCancellation> cancellations;
  /** The id of the line item. */
  core.String id;
  /**
   * Total price for the line item. For example, if two items for $10 are
   * purchased, the total price will be $20.
   */
  Price price;
  /** Product data from the time of the order placement. */
  OrderLineItemProduct product;
  /** Number of items canceled. */
  core.int quantityCanceled;
  /** Number of items delivered. */
  core.int quantityDelivered;
  /** Number of items ordered. */
  core.int quantityOrdered;
  /** Number of items pending. */
  core.int quantityPending;
  /** Number of items returned. */
  core.int quantityReturned;
  /** Number of items shipped. */
  core.int quantityShipped;
  /** Details of the return policy for the line item. */
  OrderLineItemReturnInfo returnInfo;
  /** Returns of the line item. */
  core.List<OrderReturn> returns;
  /** Details of the requested shipping for the line item. */
  OrderLineItemShippingDetails shippingDetails;
  /**
   * Total tax amount for the line item. For example, if two items are
   * purchased, and each have a cost tax of $2, the total tax amount will be $4.
   */
  Price tax;

  OrderLineItem();

  OrderLineItem.fromJson(core.Map _json) {
    if (_json.containsKey("cancellations")) {
      cancellations = _json["cancellations"].map((value) => new OrderCancellation.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("product")) {
      product = new OrderLineItemProduct.fromJson(_json["product"]);
    }
    if (_json.containsKey("quantityCanceled")) {
      quantityCanceled = _json["quantityCanceled"];
    }
    if (_json.containsKey("quantityDelivered")) {
      quantityDelivered = _json["quantityDelivered"];
    }
    if (_json.containsKey("quantityOrdered")) {
      quantityOrdered = _json["quantityOrdered"];
    }
    if (_json.containsKey("quantityPending")) {
      quantityPending = _json["quantityPending"];
    }
    if (_json.containsKey("quantityReturned")) {
      quantityReturned = _json["quantityReturned"];
    }
    if (_json.containsKey("quantityShipped")) {
      quantityShipped = _json["quantityShipped"];
    }
    if (_json.containsKey("returnInfo")) {
      returnInfo = new OrderLineItemReturnInfo.fromJson(_json["returnInfo"]);
    }
    if (_json.containsKey("returns")) {
      returns = _json["returns"].map((value) => new OrderReturn.fromJson(value)).toList();
    }
    if (_json.containsKey("shippingDetails")) {
      shippingDetails = new OrderLineItemShippingDetails.fromJson(_json["shippingDetails"]);
    }
    if (_json.containsKey("tax")) {
      tax = new Price.fromJson(_json["tax"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cancellations != null) {
      _json["cancellations"] = cancellations.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (product != null) {
      _json["product"] = (product).toJson();
    }
    if (quantityCanceled != null) {
      _json["quantityCanceled"] = quantityCanceled;
    }
    if (quantityDelivered != null) {
      _json["quantityDelivered"] = quantityDelivered;
    }
    if (quantityOrdered != null) {
      _json["quantityOrdered"] = quantityOrdered;
    }
    if (quantityPending != null) {
      _json["quantityPending"] = quantityPending;
    }
    if (quantityReturned != null) {
      _json["quantityReturned"] = quantityReturned;
    }
    if (quantityShipped != null) {
      _json["quantityShipped"] = quantityShipped;
    }
    if (returnInfo != null) {
      _json["returnInfo"] = (returnInfo).toJson();
    }
    if (returns != null) {
      _json["returns"] = returns.map((value) => (value).toJson()).toList();
    }
    if (shippingDetails != null) {
      _json["shippingDetails"] = (shippingDetails).toJson();
    }
    if (tax != null) {
      _json["tax"] = (tax).toJson();
    }
    return _json;
  }
}

class OrderLineItemProduct {
  /** Brand of the item. */
  core.String brand;
  /** The item's channel (online or local). */
  core.String channel;
  /** Condition or state of the item. */
  core.String condition;
  /** The two-letter ISO 639-1 language code for the item. */
  core.String contentLanguage;
  /** Global Trade Item Number (GTIN) of the item. */
  core.String gtin;
  /** The REST id of the product. */
  core.String id;
  /** URL of an image of the item. */
  core.String imageLink;
  /** Shared identifier for all variants of the same product. */
  core.String itemGroupId;
  /** Manufacturer Part Number (MPN) of the item. */
  core.String mpn;
  /** An identifier of the item. */
  core.String offerId;
  /** Price of the item. */
  Price price;
  /** URL to the cached image shown to the user when order was placed. */
  core.String shownImage;
  /** The CLDR territory code of the target country of the product. */
  core.String targetCountry;
  /** The title of the product. */
  core.String title;
  /**
   * Variant attributes for the item. These are dimensions of the product, such
   * as color, gender, material, pattern, and size. You can find a comprehensive
   * list of variant attributes here.
   */
  core.List<OrderLineItemProductVariantAttribute> variantAttributes;

  OrderLineItemProduct();

  OrderLineItemProduct.fromJson(core.Map _json) {
    if (_json.containsKey("brand")) {
      brand = _json["brand"];
    }
    if (_json.containsKey("channel")) {
      channel = _json["channel"];
    }
    if (_json.containsKey("condition")) {
      condition = _json["condition"];
    }
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("imageLink")) {
      imageLink = _json["imageLink"];
    }
    if (_json.containsKey("itemGroupId")) {
      itemGroupId = _json["itemGroupId"];
    }
    if (_json.containsKey("mpn")) {
      mpn = _json["mpn"];
    }
    if (_json.containsKey("offerId")) {
      offerId = _json["offerId"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("shownImage")) {
      shownImage = _json["shownImage"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("variantAttributes")) {
      variantAttributes = _json["variantAttributes"].map((value) => new OrderLineItemProductVariantAttribute.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (brand != null) {
      _json["brand"] = brand;
    }
    if (channel != null) {
      _json["channel"] = channel;
    }
    if (condition != null) {
      _json["condition"] = condition;
    }
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (imageLink != null) {
      _json["imageLink"] = imageLink;
    }
    if (itemGroupId != null) {
      _json["itemGroupId"] = itemGroupId;
    }
    if (mpn != null) {
      _json["mpn"] = mpn;
    }
    if (offerId != null) {
      _json["offerId"] = offerId;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (shownImage != null) {
      _json["shownImage"] = shownImage;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (variantAttributes != null) {
      _json["variantAttributes"] = variantAttributes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OrderLineItemProductVariantAttribute {
  /** The dimension of the variant. */
  core.String dimension;
  /** The value for the dimension. */
  core.String value;

  OrderLineItemProductVariantAttribute();

  OrderLineItemProductVariantAttribute.fromJson(core.Map _json) {
    if (_json.containsKey("dimension")) {
      dimension = _json["dimension"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimension != null) {
      _json["dimension"] = dimension;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class OrderLineItemReturnInfo {
  /** How many days later the item can be returned. */
  core.int daysToReturn;
  /** Whether the item is returnable. */
  core.bool isReturnable;
  /** URL of the item return policy. */
  core.String policyUrl;

  OrderLineItemReturnInfo();

  OrderLineItemReturnInfo.fromJson(core.Map _json) {
    if (_json.containsKey("daysToReturn")) {
      daysToReturn = _json["daysToReturn"];
    }
    if (_json.containsKey("isReturnable")) {
      isReturnable = _json["isReturnable"];
    }
    if (_json.containsKey("policyUrl")) {
      policyUrl = _json["policyUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (daysToReturn != null) {
      _json["daysToReturn"] = daysToReturn;
    }
    if (isReturnable != null) {
      _json["isReturnable"] = isReturnable;
    }
    if (policyUrl != null) {
      _json["policyUrl"] = policyUrl;
    }
    return _json;
  }
}

class OrderLineItemShippingDetails {
  /** The delivery by date, in ISO 8601 format. */
  core.String deliverByDate;
  /** Details of the shipping method. */
  OrderLineItemShippingDetailsMethod method;
  /** The ship by date, in ISO 8601 format. */
  core.String shipByDate;

  OrderLineItemShippingDetails();

  OrderLineItemShippingDetails.fromJson(core.Map _json) {
    if (_json.containsKey("deliverByDate")) {
      deliverByDate = _json["deliverByDate"];
    }
    if (_json.containsKey("method")) {
      method = new OrderLineItemShippingDetailsMethod.fromJson(_json["method"]);
    }
    if (_json.containsKey("shipByDate")) {
      shipByDate = _json["shipByDate"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deliverByDate != null) {
      _json["deliverByDate"] = deliverByDate;
    }
    if (method != null) {
      _json["method"] = (method).toJson();
    }
    if (shipByDate != null) {
      _json["shipByDate"] = shipByDate;
    }
    return _json;
  }
}

class OrderLineItemShippingDetailsMethod {
  /** The carrier for the shipping. Optional. */
  core.String carrier;
  /** Maximum transit time. */
  core.int maxDaysInTransit;
  /** The name of the shipping method. */
  core.String methodName;
  /** Minimum transit time. */
  core.int minDaysInTransit;

  OrderLineItemShippingDetailsMethod();

  OrderLineItemShippingDetailsMethod.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("maxDaysInTransit")) {
      maxDaysInTransit = _json["maxDaysInTransit"];
    }
    if (_json.containsKey("methodName")) {
      methodName = _json["methodName"];
    }
    if (_json.containsKey("minDaysInTransit")) {
      minDaysInTransit = _json["minDaysInTransit"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (maxDaysInTransit != null) {
      _json["maxDaysInTransit"] = maxDaysInTransit;
    }
    if (methodName != null) {
      _json["methodName"] = methodName;
    }
    if (minDaysInTransit != null) {
      _json["minDaysInTransit"] = minDaysInTransit;
    }
    return _json;
  }
}

class OrderPaymentMethod {
  /** The billing address. */
  OrderAddress billingAddress;
  /** The card expiration month (January = 1, February = 2 etc.). */
  core.int expirationMonth;
  /** The card expiration year (4-digit, e.g. 2015). */
  core.int expirationYear;
  /** The last four digits of the card number. */
  core.String lastFourDigits;
  /** The billing phone number. */
  core.String phoneNumber;
  /** The type of instrument (VISA, Mastercard, etc). */
  core.String type;

  OrderPaymentMethod();

  OrderPaymentMethod.fromJson(core.Map _json) {
    if (_json.containsKey("billingAddress")) {
      billingAddress = new OrderAddress.fromJson(_json["billingAddress"]);
    }
    if (_json.containsKey("expirationMonth")) {
      expirationMonth = _json["expirationMonth"];
    }
    if (_json.containsKey("expirationYear")) {
      expirationYear = _json["expirationYear"];
    }
    if (_json.containsKey("lastFourDigits")) {
      lastFourDigits = _json["lastFourDigits"];
    }
    if (_json.containsKey("phoneNumber")) {
      phoneNumber = _json["phoneNumber"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (billingAddress != null) {
      _json["billingAddress"] = (billingAddress).toJson();
    }
    if (expirationMonth != null) {
      _json["expirationMonth"] = expirationMonth;
    }
    if (expirationYear != null) {
      _json["expirationYear"] = expirationYear;
    }
    if (lastFourDigits != null) {
      _json["lastFourDigits"] = lastFourDigits;
    }
    if (phoneNumber != null) {
      _json["phoneNumber"] = phoneNumber;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class OrderPromotion {
  core.List<OrderPromotionBenefit> benefits;
  /**
   * The date and time frame when the promotion is active and ready for
   * validation review. Note that the promotion live time may be delayed for a
   * few hours due to the validation review.
   * Start date and end date are separated by a forward slash (/). The start
   * date is specified by the format (YYYY-MM-DD), followed by the letter ?T?,
   * the time of the day when the sale starts (in Greenwich Mean Time, GMT),
   * followed by an expression of the time zone for the sale. The end date is in
   * the same format.
   */
  core.String effectiveDates;
  /**
   * Optional. The text code that corresponds to the promotion when applied on
   * the retailer?s website.
   */
  core.String genericRedemptionCode;
  /** The unique ID of the promotion. */
  core.String id;
  /** The full title of the promotion. */
  core.String longTitle;
  /**
   * Whether the promotion is applicable to all products or only specific
   * products.
   */
  core.String productApplicability;
  /** Indicates that the promotion is valid online. */
  core.String redemptionChannel;

  OrderPromotion();

  OrderPromotion.fromJson(core.Map _json) {
    if (_json.containsKey("benefits")) {
      benefits = _json["benefits"].map((value) => new OrderPromotionBenefit.fromJson(value)).toList();
    }
    if (_json.containsKey("effectiveDates")) {
      effectiveDates = _json["effectiveDates"];
    }
    if (_json.containsKey("genericRedemptionCode")) {
      genericRedemptionCode = _json["genericRedemptionCode"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("longTitle")) {
      longTitle = _json["longTitle"];
    }
    if (_json.containsKey("productApplicability")) {
      productApplicability = _json["productApplicability"];
    }
    if (_json.containsKey("redemptionChannel")) {
      redemptionChannel = _json["redemptionChannel"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (benefits != null) {
      _json["benefits"] = benefits.map((value) => (value).toJson()).toList();
    }
    if (effectiveDates != null) {
      _json["effectiveDates"] = effectiveDates;
    }
    if (genericRedemptionCode != null) {
      _json["genericRedemptionCode"] = genericRedemptionCode;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (longTitle != null) {
      _json["longTitle"] = longTitle;
    }
    if (productApplicability != null) {
      _json["productApplicability"] = productApplicability;
    }
    if (redemptionChannel != null) {
      _json["redemptionChannel"] = redemptionChannel;
    }
    return _json;
  }
}

class OrderPromotionBenefit {
  /** The discount in the order price when the promotion is applied. */
  Price discount;
  /**
   * The OfferId(s) that were purchased in this order and map to this specific
   * benefit of the promotion.
   */
  core.List<core.String> offerIds;
  /**
   * Further describes the benefit of the promotion. Note that we will expand on
   * this enumeration as we support new promotion sub-types.
   */
  core.String subType;
  /** The impact on tax when the promotion is applied. */
  Price taxImpact;
  /**
   * Describes whether the promotion applies to products (e.g. 20% off) or to
   * shipping (e.g. Free Shipping).
   */
  core.String type;

  OrderPromotionBenefit();

  OrderPromotionBenefit.fromJson(core.Map _json) {
    if (_json.containsKey("discount")) {
      discount = new Price.fromJson(_json["discount"]);
    }
    if (_json.containsKey("offerIds")) {
      offerIds = _json["offerIds"];
    }
    if (_json.containsKey("subType")) {
      subType = _json["subType"];
    }
    if (_json.containsKey("taxImpact")) {
      taxImpact = new Price.fromJson(_json["taxImpact"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (discount != null) {
      _json["discount"] = (discount).toJson();
    }
    if (offerIds != null) {
      _json["offerIds"] = offerIds;
    }
    if (subType != null) {
      _json["subType"] = subType;
    }
    if (taxImpact != null) {
      _json["taxImpact"] = (taxImpact).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class OrderRefund {
  /** The actor that created the refund. */
  core.String actor;
  /** The amount that is refunded. */
  Price amount;
  /** Date on which the item has been created, in ISO 8601 format. */
  core.String creationDate;
  /** The reason for the refund. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrderRefund();

  OrderRefund.fromJson(core.Map _json) {
    if (_json.containsKey("actor")) {
      actor = _json["actor"];
    }
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (actor != null) {
      _json["actor"] = actor;
    }
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrderReturn {
  /** The actor that created the refund. */
  core.String actor;
  /** Date on which the item has been created, in ISO 8601 format. */
  core.String creationDate;
  /** Quantity that is returned. */
  core.int quantity;
  /** The reason for the return. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrderReturn();

  OrderReturn.fromJson(core.Map _json) {
    if (_json.containsKey("actor")) {
      actor = _json["actor"];
    }
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (actor != null) {
      _json["actor"] = actor;
    }
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrderShipment {
  /** The carrier handling the shipment. */
  core.String carrier;
  /** Date on which the shipment has been created, in ISO 8601 format. */
  core.String creationDate;
  /**
   * Date on which the shipment has been delivered, in ISO 8601 format. Present
   * only if status is delievered
   */
  core.String deliveryDate;
  /** The id of the shipment. */
  core.String id;
  /** The line items that are shipped. */
  core.List<OrderShipmentLineItemShipment> lineItems;
  /** The status of the shipment. */
  core.String status;
  /** The tracking id for the shipment. */
  core.String trackingId;

  OrderShipment();

  OrderShipment.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("deliveryDate")) {
      deliveryDate = _json["deliveryDate"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"].map((value) => new OrderShipmentLineItemShipment.fromJson(value)).toList();
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (deliveryDate != null) {
      _json["deliveryDate"] = deliveryDate;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrderShipmentLineItemShipment {
  /** The id of the line item that is shipped. */
  core.String lineItemId;
  /** The quantity that is shipped. */
  core.int quantity;

  OrderShipmentLineItemShipment();

  OrderShipmentLineItemShipment.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    return _json;
  }
}

class OrdersAcknowledgeRequest {
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;

  OrdersAcknowledgeRequest();

  OrdersAcknowledgeRequest.fromJson(core.Map _json) {
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    return _json;
  }
}

class OrdersAcknowledgeResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersAcknowledgeResponse".
   */
  core.String kind;

  OrdersAcknowledgeResponse();

  OrdersAcknowledgeResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersAdvanceTestOrderResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersAdvanceTestOrderResponse".
   */
  core.String kind;

  OrdersAdvanceTestOrderResponse();

  OrdersAdvanceTestOrderResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersCancelLineItemRequest {
  /**
   * Amount to refund for the cancelation. Optional. If not set, Google will
   * calculate the default based on the price and tax of the items involved. The
   * amount must not be larger than the net amount left on the order.
   */
  Price amount;
  /** The ID of the line item to cancel. */
  core.String lineItemId;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;
  /** The quantity to cancel. */
  core.int quantity;
  /** The reason for the cancellation. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersCancelLineItemRequest();

  OrdersCancelLineItemRequest.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCancelLineItemResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersCancelLineItemResponse".
   */
  core.String kind;

  OrdersCancelLineItemResponse();

  OrdersCancelLineItemResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersCancelRequest {
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;
  /** The reason for the cancellation. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersCancelRequest();

  OrdersCancelRequest.fromJson(core.Map _json) {
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCancelResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersCancelResponse".
   */
  core.String kind;

  OrdersCancelResponse();

  OrdersCancelResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersCreateTestOrderRequest {
  /**
   * The test order template to use. Specify as an alternative to testOrder as a
   * shortcut for retrieving a template and then creating an order using that
   * template.
   */
  core.String templateName;
  /** The test order to create. */
  TestOrder testOrder;

  OrdersCreateTestOrderRequest();

  OrdersCreateTestOrderRequest.fromJson(core.Map _json) {
    if (_json.containsKey("templateName")) {
      templateName = _json["templateName"];
    }
    if (_json.containsKey("testOrder")) {
      testOrder = new TestOrder.fromJson(_json["testOrder"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (templateName != null) {
      _json["templateName"] = templateName;
    }
    if (testOrder != null) {
      _json["testOrder"] = (testOrder).toJson();
    }
    return _json;
  }
}

class OrdersCreateTestOrderResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersCreateTestOrderResponse".
   */
  core.String kind;
  /** The ID of the newly created test order. */
  core.String orderId;

  OrdersCreateTestOrderResponse();

  OrdersCreateTestOrderResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("orderId")) {
      orderId = _json["orderId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (orderId != null) {
      _json["orderId"] = orderId;
    }
    return _json;
  }
}

class OrdersCustomBatchRequest {
  /** The request entries to be processed in the batch. */
  core.List<OrdersCustomBatchRequestEntry> entries;

  OrdersCustomBatchRequest();

  OrdersCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new OrdersCustomBatchRequestEntry.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntry {
  /** An entry ID, unique within the batch request. */
  core.int batchId;
  /** Required for cancel method. */
  OrdersCustomBatchRequestEntryCancel cancel;
  /** Required for cancelLineItem method. */
  OrdersCustomBatchRequestEntryCancelLineItem cancelLineItem;
  /** The ID of the managing account. */
  core.String merchantId;
  /**
   * The merchant order id. Required for updateMerchantOrderId and
   * getByMerchantOrderId methods.
   */
  core.String merchantOrderId;
  /** The method to apply. */
  core.String method;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   * Required for all methods beside get and getByMerchantOrderId.
   */
  core.String operationId;
  /**
   * The ID of the order. Required for all methods beside getByMerchantOrderId.
   */
  core.String orderId;
  /** Required for refund method. */
  OrdersCustomBatchRequestEntryRefund refund;
  /** Required for returnLineItem method. */
  OrdersCustomBatchRequestEntryReturnLineItem returnLineItem;
  /** Required for shipLineItems method. */
  OrdersCustomBatchRequestEntryShipLineItems shipLineItems;
  /** Required for updateShipment method. */
  OrdersCustomBatchRequestEntryUpdateShipment updateShipment;

  OrdersCustomBatchRequestEntry();

  OrdersCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("cancel")) {
      cancel = new OrdersCustomBatchRequestEntryCancel.fromJson(_json["cancel"]);
    }
    if (_json.containsKey("cancelLineItem")) {
      cancelLineItem = new OrdersCustomBatchRequestEntryCancelLineItem.fromJson(_json["cancelLineItem"]);
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("merchantOrderId")) {
      merchantOrderId = _json["merchantOrderId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("orderId")) {
      orderId = _json["orderId"];
    }
    if (_json.containsKey("refund")) {
      refund = new OrdersCustomBatchRequestEntryRefund.fromJson(_json["refund"]);
    }
    if (_json.containsKey("returnLineItem")) {
      returnLineItem = new OrdersCustomBatchRequestEntryReturnLineItem.fromJson(_json["returnLineItem"]);
    }
    if (_json.containsKey("shipLineItems")) {
      shipLineItems = new OrdersCustomBatchRequestEntryShipLineItems.fromJson(_json["shipLineItems"]);
    }
    if (_json.containsKey("updateShipment")) {
      updateShipment = new OrdersCustomBatchRequestEntryUpdateShipment.fromJson(_json["updateShipment"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (cancel != null) {
      _json["cancel"] = (cancel).toJson();
    }
    if (cancelLineItem != null) {
      _json["cancelLineItem"] = (cancelLineItem).toJson();
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (merchantOrderId != null) {
      _json["merchantOrderId"] = merchantOrderId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (orderId != null) {
      _json["orderId"] = orderId;
    }
    if (refund != null) {
      _json["refund"] = (refund).toJson();
    }
    if (returnLineItem != null) {
      _json["returnLineItem"] = (returnLineItem).toJson();
    }
    if (shipLineItems != null) {
      _json["shipLineItems"] = (shipLineItems).toJson();
    }
    if (updateShipment != null) {
      _json["updateShipment"] = (updateShipment).toJson();
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryCancel {
  /** The reason for the cancellation. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersCustomBatchRequestEntryCancel();

  OrdersCustomBatchRequestEntryCancel.fromJson(core.Map _json) {
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryCancelLineItem {
  /**
   * Amount to refund for the cancelation. Optional. If not set, Google will
   * calculate the default based on the price and tax of the items involved. The
   * amount must not be larger than the net amount left on the order.
   */
  Price amount;
  /** The ID of the line item to cancel. */
  core.String lineItemId;
  /** The quantity to cancel. */
  core.int quantity;
  /** The reason for the cancellation. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersCustomBatchRequestEntryCancelLineItem();

  OrdersCustomBatchRequestEntryCancelLineItem.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryRefund {
  /** The amount that is refunded. */
  Price amount;
  /** The reason for the refund. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersCustomBatchRequestEntryRefund();

  OrdersCustomBatchRequestEntryRefund.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryReturnLineItem {
  /** The ID of the line item to return. */
  core.String lineItemId;
  /** The quantity to return. */
  core.int quantity;
  /** The reason for the return. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersCustomBatchRequestEntryReturnLineItem();

  OrdersCustomBatchRequestEntryReturnLineItem.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryShipLineItems {
  /** The carrier handling the shipment. */
  core.String carrier;
  /** Line items to ship. */
  core.List<OrderShipmentLineItemShipment> lineItems;
  /** The ID of the shipment. */
  core.String shipmentId;
  /** The tracking id for the shipment. */
  core.String trackingId;

  OrdersCustomBatchRequestEntryShipLineItems();

  OrdersCustomBatchRequestEntryShipLineItems.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"].map((value) => new OrderShipmentLineItemShipment.fromJson(value)).toList();
    }
    if (_json.containsKey("shipmentId")) {
      shipmentId = _json["shipmentId"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (shipmentId != null) {
      _json["shipmentId"] = shipmentId;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryUpdateShipment {
  /** The carrier handling the shipment. Not updated if missing. */
  core.String carrier;
  /** The ID of the shipment. */
  core.String shipmentId;
  /** New status for the shipment. Not updated if missing. */
  core.String status;
  /** The tracking id for the shipment. Not updated if missing. */
  core.String trackingId;

  OrdersCustomBatchRequestEntryUpdateShipment();

  OrdersCustomBatchRequestEntryUpdateShipment.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("shipmentId")) {
      shipmentId = _json["shipmentId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (shipmentId != null) {
      _json["shipmentId"] = shipmentId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrdersCustomBatchResponse {
  /** The result of the execution of the batch requests. */
  core.List<OrdersCustomBatchResponseEntry> entries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersCustomBatchResponse".
   */
  core.String kind;

  OrdersCustomBatchResponse();

  OrdersCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new OrdersCustomBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersCustomBatchResponseEntry {
  /** The ID of the request entry this entry responds to. */
  core.int batchId;
  /** A list of errors defined if and only if the request failed. */
  Errors errors;
  /**
   * The status of the execution. Only defined if the method is not get or
   * getByMerchantOrderId and if the request was successful.
   */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersCustomBatchResponseEntry".
   */
  core.String kind;
  /**
   * The retrieved order. Only defined if the method is get and if the request
   * was successful.
   */
  Order order;

  OrdersCustomBatchResponseEntry();

  OrdersCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("order")) {
      order = new Order.fromJson(_json["order"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (order != null) {
      _json["order"] = (order).toJson();
    }
    return _json;
  }
}

class OrdersGetByMerchantOrderIdResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersGetByMerchantOrderIdResponse".
   */
  core.String kind;
  /** The requested order. */
  Order order;

  OrdersGetByMerchantOrderIdResponse();

  OrdersGetByMerchantOrderIdResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("order")) {
      order = new Order.fromJson(_json["order"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (order != null) {
      _json["order"] = (order).toJson();
    }
    return _json;
  }
}

class OrdersGetTestOrderTemplateResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersGetTestOrderTemplateResponse".
   */
  core.String kind;
  /** The requested test order template. */
  TestOrder template;

  OrdersGetTestOrderTemplateResponse();

  OrdersGetTestOrderTemplateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("template")) {
      template = new TestOrder.fromJson(_json["template"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (template != null) {
      _json["template"] = (template).toJson();
    }
    return _json;
  }
}

class OrdersListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersListResponse".
   */
  core.String kind;
  /** The token for the retrieval of the next page of orders. */
  core.String nextPageToken;
  core.List<Order> resources;

  OrdersListResponse();

  OrdersListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new Order.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OrdersRefundRequest {
  /** The amount that is refunded. */
  Price amount;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;
  /** The reason for the refund. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersRefundRequest();

  OrdersRefundRequest.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersRefundResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersRefundResponse".
   */
  core.String kind;

  OrdersRefundResponse();

  OrdersRefundResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersReturnLineItemRequest {
  /** The ID of the line item to return. */
  core.String lineItemId;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;
  /** The quantity to return. */
  core.int quantity;
  /** The reason for the return. */
  core.String reason;
  /** The explanation of the reason. */
  core.String reasonText;

  OrdersReturnLineItemRequest();

  OrdersReturnLineItemRequest.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersReturnLineItemResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersReturnLineItemResponse".
   */
  core.String kind;

  OrdersReturnLineItemResponse();

  OrdersReturnLineItemResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersShipLineItemsRequest {
  /** The carrier handling the shipment. */
  core.String carrier;
  /** Line items to ship. */
  core.List<OrderShipmentLineItemShipment> lineItems;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;
  /** The ID of the shipment. */
  core.String shipmentId;
  /** The tracking id for the shipment. */
  core.String trackingId;

  OrdersShipLineItemsRequest();

  OrdersShipLineItemsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"].map((value) => new OrderShipmentLineItemShipment.fromJson(value)).toList();
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("shipmentId")) {
      shipmentId = _json["shipmentId"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (shipmentId != null) {
      _json["shipmentId"] = shipmentId;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrdersShipLineItemsResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersShipLineItemsResponse".
   */
  core.String kind;

  OrdersShipLineItemsResponse();

  OrdersShipLineItemsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersUpdateMerchantOrderIdRequest {
  /**
   * The merchant order id to be assigned to the order. Must be unique per
   * merchant.
   */
  core.String merchantOrderId;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;

  OrdersUpdateMerchantOrderIdRequest();

  OrdersUpdateMerchantOrderIdRequest.fromJson(core.Map _json) {
    if (_json.containsKey("merchantOrderId")) {
      merchantOrderId = _json["merchantOrderId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (merchantOrderId != null) {
      _json["merchantOrderId"] = merchantOrderId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    return _json;
  }
}

class OrdersUpdateMerchantOrderIdResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersUpdateMerchantOrderIdResponse".
   */
  core.String kind;

  OrdersUpdateMerchantOrderIdResponse();

  OrdersUpdateMerchantOrderIdResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersUpdateShipmentRequest {
  /** The carrier handling the shipment. Not updated if missing. */
  core.String carrier;
  /**
   * The ID of the operation. Unique across all operations for a given order.
   */
  core.String operationId;
  /** The ID of the shipment. */
  core.String shipmentId;
  /** New status for the shipment. Not updated if missing. */
  core.String status;
  /** The tracking id for the shipment. Not updated if missing. */
  core.String trackingId;

  OrdersUpdateShipmentRequest();

  OrdersUpdateShipmentRequest.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("shipmentId")) {
      shipmentId = _json["shipmentId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (shipmentId != null) {
      _json["shipmentId"] = shipmentId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrdersUpdateShipmentResponse {
  /** The status of the execution. */
  core.String executionStatus;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#ordersUpdateShipmentResponse".
   */
  core.String kind;

  OrdersUpdateShipmentResponse();

  OrdersUpdateShipmentResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class Price {
  /** The currency of the price. */
  core.String currency;
  /** The price represented as a number. */
  core.String value;

  Price();

  Price.fromJson(core.Map _json) {
    if (_json.containsKey("currency")) {
      currency = _json["currency"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currency != null) {
      _json["currency"] = currency;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class TestOrder {
  /** The details of the customer who placed the order. */
  TestOrderCustomer customer;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "content#testOrder".
   */
  core.String kind;
  /** Line items that are ordered. At least one line item must be provided. */
  core.List<TestOrderLineItem> lineItems;
  /** The details of the payment method. */
  TestOrderPaymentMethod paymentMethod;
  /**
   * Identifier of one of the predefined delivery addresses for the delivery.
   */
  core.String predefinedDeliveryAddress;
  /**
   * The details of the merchant provided promotions applied to the order. More
   * details about the program are  here.
   */
  core.List<OrderPromotion> promotions;
  /** The total cost of shipping for all items. */
  Price shippingCost;
  /** The tax for the total shipping cost. */
  Price shippingCostTax;
  /** The requested shipping option. */
  core.String shippingOption;

  TestOrder();

  TestOrder.fromJson(core.Map _json) {
    if (_json.containsKey("customer")) {
      customer = new TestOrderCustomer.fromJson(_json["customer"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = _json["lineItems"].map((value) => new TestOrderLineItem.fromJson(value)).toList();
    }
    if (_json.containsKey("paymentMethod")) {
      paymentMethod = new TestOrderPaymentMethod.fromJson(_json["paymentMethod"]);
    }
    if (_json.containsKey("predefinedDeliveryAddress")) {
      predefinedDeliveryAddress = _json["predefinedDeliveryAddress"];
    }
    if (_json.containsKey("promotions")) {
      promotions = _json["promotions"].map((value) => new OrderPromotion.fromJson(value)).toList();
    }
    if (_json.containsKey("shippingCost")) {
      shippingCost = new Price.fromJson(_json["shippingCost"]);
    }
    if (_json.containsKey("shippingCostTax")) {
      shippingCostTax = new Price.fromJson(_json["shippingCostTax"]);
    }
    if (_json.containsKey("shippingOption")) {
      shippingOption = _json["shippingOption"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (customer != null) {
      _json["customer"] = (customer).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (paymentMethod != null) {
      _json["paymentMethod"] = (paymentMethod).toJson();
    }
    if (predefinedDeliveryAddress != null) {
      _json["predefinedDeliveryAddress"] = predefinedDeliveryAddress;
    }
    if (promotions != null) {
      _json["promotions"] = promotions.map((value) => (value).toJson()).toList();
    }
    if (shippingCost != null) {
      _json["shippingCost"] = (shippingCost).toJson();
    }
    if (shippingCostTax != null) {
      _json["shippingCostTax"] = (shippingCostTax).toJson();
    }
    if (shippingOption != null) {
      _json["shippingOption"] = shippingOption;
    }
    return _json;
  }
}

class TestOrderCustomer {
  /** Email address of the customer. */
  core.String email;
  /**
   * If set, this indicates the user explicitly chose to opt in or out of
   * providing marketing rights to the merchant. If unset, this indicates the
   * user has already made this choice in a previous purchase, and was thus not
   * shown the marketing right opt in/out checkbox during the checkout flow.
   * Optional.
   */
  core.bool explicitMarketingPreference;
  /** Full name of the customer. */
  core.String fullName;

  TestOrderCustomer();

  TestOrderCustomer.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("explicitMarketingPreference")) {
      explicitMarketingPreference = _json["explicitMarketingPreference"];
    }
    if (_json.containsKey("fullName")) {
      fullName = _json["fullName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (email != null) {
      _json["email"] = email;
    }
    if (explicitMarketingPreference != null) {
      _json["explicitMarketingPreference"] = explicitMarketingPreference;
    }
    if (fullName != null) {
      _json["fullName"] = fullName;
    }
    return _json;
  }
}

class TestOrderLineItem {
  /** Product data from the time of the order placement. */
  TestOrderLineItemProduct product;
  /** Number of items ordered. */
  core.int quantityOrdered;
  /** Details of the return policy for the line item. */
  OrderLineItemReturnInfo returnInfo;
  /** Details of the requested shipping for the line item. */
  OrderLineItemShippingDetails shippingDetails;
  /** Unit tax for the line item. */
  Price unitTax;

  TestOrderLineItem();

  TestOrderLineItem.fromJson(core.Map _json) {
    if (_json.containsKey("product")) {
      product = new TestOrderLineItemProduct.fromJson(_json["product"]);
    }
    if (_json.containsKey("quantityOrdered")) {
      quantityOrdered = _json["quantityOrdered"];
    }
    if (_json.containsKey("returnInfo")) {
      returnInfo = new OrderLineItemReturnInfo.fromJson(_json["returnInfo"]);
    }
    if (_json.containsKey("shippingDetails")) {
      shippingDetails = new OrderLineItemShippingDetails.fromJson(_json["shippingDetails"]);
    }
    if (_json.containsKey("unitTax")) {
      unitTax = new Price.fromJson(_json["unitTax"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (product != null) {
      _json["product"] = (product).toJson();
    }
    if (quantityOrdered != null) {
      _json["quantityOrdered"] = quantityOrdered;
    }
    if (returnInfo != null) {
      _json["returnInfo"] = (returnInfo).toJson();
    }
    if (shippingDetails != null) {
      _json["shippingDetails"] = (shippingDetails).toJson();
    }
    if (unitTax != null) {
      _json["unitTax"] = (unitTax).toJson();
    }
    return _json;
  }
}

class TestOrderLineItemProduct {
  /** Brand of the item. */
  core.String brand;
  /** The item's channel. */
  core.String channel;
  /** Condition or state of the item. */
  core.String condition;
  /** The two-letter ISO 639-1 language code for the item. */
  core.String contentLanguage;
  /** Global Trade Item Number (GTIN) of the item. Optional. */
  core.String gtin;
  /** URL of an image of the item. */
  core.String imageLink;
  /** Shared identifier for all variants of the same product. Optional. */
  core.String itemGroupId;
  /** Manufacturer Part Number (MPN) of the item. Optional. */
  core.String mpn;
  /** An identifier of the item. */
  core.String offerId;
  /** The price for the product. */
  Price price;
  /** The CLDR territory code of the target country of the product. */
  core.String targetCountry;
  /** The title of the product. */
  core.String title;
  /** Variant attributes for the item. Optional. */
  core.List<OrderLineItemProductVariantAttribute> variantAttributes;

  TestOrderLineItemProduct();

  TestOrderLineItemProduct.fromJson(core.Map _json) {
    if (_json.containsKey("brand")) {
      brand = _json["brand"];
    }
    if (_json.containsKey("channel")) {
      channel = _json["channel"];
    }
    if (_json.containsKey("condition")) {
      condition = _json["condition"];
    }
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("imageLink")) {
      imageLink = _json["imageLink"];
    }
    if (_json.containsKey("itemGroupId")) {
      itemGroupId = _json["itemGroupId"];
    }
    if (_json.containsKey("mpn")) {
      mpn = _json["mpn"];
    }
    if (_json.containsKey("offerId")) {
      offerId = _json["offerId"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("variantAttributes")) {
      variantAttributes = _json["variantAttributes"].map((value) => new OrderLineItemProductVariantAttribute.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (brand != null) {
      _json["brand"] = brand;
    }
    if (channel != null) {
      _json["channel"] = channel;
    }
    if (condition != null) {
      _json["condition"] = condition;
    }
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (imageLink != null) {
      _json["imageLink"] = imageLink;
    }
    if (itemGroupId != null) {
      _json["itemGroupId"] = itemGroupId;
    }
    if (mpn != null) {
      _json["mpn"] = mpn;
    }
    if (offerId != null) {
      _json["offerId"] = offerId;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (variantAttributes != null) {
      _json["variantAttributes"] = variantAttributes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class TestOrderPaymentMethod {
  /** The card expiration month (January = 1, February = 2 etc.). */
  core.int expirationMonth;
  /** The card expiration year (4-digit, e.g. 2015). */
  core.int expirationYear;
  /** The last four digits of the card number. */
  core.String lastFourDigits;
  /** The billing address. */
  core.String predefinedBillingAddress;
  /**
   * The type of instrument. Note that real orders might have different values
   * than the four values accepted by createTestOrder.
   */
  core.String type;

  TestOrderPaymentMethod();

  TestOrderPaymentMethod.fromJson(core.Map _json) {
    if (_json.containsKey("expirationMonth")) {
      expirationMonth = _json["expirationMonth"];
    }
    if (_json.containsKey("expirationYear")) {
      expirationYear = _json["expirationYear"];
    }
    if (_json.containsKey("lastFourDigits")) {
      lastFourDigits = _json["lastFourDigits"];
    }
    if (_json.containsKey("predefinedBillingAddress")) {
      predefinedBillingAddress = _json["predefinedBillingAddress"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (expirationMonth != null) {
      _json["expirationMonth"] = expirationMonth;
    }
    if (expirationYear != null) {
      _json["expirationYear"] = expirationYear;
    }
    if (lastFourDigits != null) {
      _json["lastFourDigits"] = lastFourDigits;
    }
    if (predefinedBillingAddress != null) {
      _json["predefinedBillingAddress"] = predefinedBillingAddress;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}
