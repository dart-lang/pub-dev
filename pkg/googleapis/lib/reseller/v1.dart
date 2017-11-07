// This is a generated file (see the discoveryapis_generator project).

library googleapis.reseller.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client reseller/v1';

/** Creates and manages your customers and their subscriptions. */
class ResellerApi {
  /** Manage users on your domain */
  static const AppsOrderScope = "https://www.googleapis.com/auth/apps.order";

  /** Manage users on your domain */
  static const AppsOrderReadonlyScope = "https://www.googleapis.com/auth/apps.order.readonly";


  final commons.ApiRequester _requester;

  CustomersResourceApi get customers => new CustomersResourceApi(_requester);
  ResellernotifyResourceApi get resellernotify => new ResellernotifyResourceApi(_requester);
  SubscriptionsResourceApi get subscriptions => new SubscriptionsResourceApi(_requester);

  ResellerApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "apps/reseller/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class CustomersResourceApi {
  final commons.ApiRequester _requester;

  CustomersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get a customer account.
   *
   * Request parameters:
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * Completes with a [Customer].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Customer> get(core.String customerId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }

    _url = 'customers/' + commons.Escaper.ecapeVariable('$customerId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Customer.fromJson(data));
  }

  /**
   * Order a new customer's account.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [customerAuthToken] - The customerAuthToken query string is required when
   * creating a resold account that transfers a direct customer's subscription
   * or transfers another reseller customer's subscription to your reseller
   * management. This is a hexadecimal authentication token needed to complete
   * the subscription transfer. For more information, see the administrator help
   * center.
   *
   * Completes with a [Customer].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Customer> insert(Customer request, {core.String customerAuthToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (customerAuthToken != null) {
      _queryParams["customerAuthToken"] = [customerAuthToken];
    }

    _url = 'customers';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Customer.fromJson(data));
  }

  /**
   * Update a customer account's settings. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * Completes with a [Customer].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Customer> patch(Customer request, core.String customerId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }

    _url = 'customers/' + commons.Escaper.ecapeVariable('$customerId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Customer.fromJson(data));
  }

  /**
   * Update a customer account's settings.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * Completes with a [Customer].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Customer> update(Customer request, core.String customerId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }

    _url = 'customers/' + commons.Escaper.ecapeVariable('$customerId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Customer.fromJson(data));
  }

}


class ResellernotifyResourceApi {
  final commons.ApiRequester _requester;

  ResellernotifyResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns all the details of the watch corresponding to the reseller.
   *
   * Request parameters:
   *
   * Completes with a [ResellernotifyGetwatchdetailsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ResellernotifyGetwatchdetailsResponse> getwatchdetails() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'resellernotify/getwatchdetails';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ResellernotifyGetwatchdetailsResponse.fromJson(data));
  }

  /**
   * Registers a Reseller for receiving notifications.
   *
   * Request parameters:
   *
   * [serviceAccountEmailAddress] - The service account which will own the
   * created Cloud-PubSub topic.
   *
   * Completes with a [ResellernotifyResource].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ResellernotifyResource> register({core.String serviceAccountEmailAddress}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (serviceAccountEmailAddress != null) {
      _queryParams["serviceAccountEmailAddress"] = [serviceAccountEmailAddress];
    }

    _url = 'resellernotify/register';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ResellernotifyResource.fromJson(data));
  }

  /**
   * Unregisters a Reseller for receiving notifications.
   *
   * Request parameters:
   *
   * [serviceAccountEmailAddress] - The service account which owns the
   * Cloud-PubSub topic.
   *
   * Completes with a [ResellernotifyResource].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ResellernotifyResource> unregister({core.String serviceAccountEmailAddress}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (serviceAccountEmailAddress != null) {
      _queryParams["serviceAccountEmailAddress"] = [serviceAccountEmailAddress];
    }

    _url = 'resellernotify/unregister';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ResellernotifyResource.fromJson(data));
  }

}


class SubscriptionsResourceApi {
  final commons.ApiRequester _requester;

  SubscriptionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Activates a subscription previously suspended by the reseller
   *
   * Request parameters:
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * [subscriptionId] - This is a required property. The subscriptionId is the
   * subscription identifier and is unique for each customer. Since a
   * subscriptionId changes when a subscription is updated, we recommend to not
   * use this ID as a key for persistent data. And the subscriptionId can be
   * found using the retrieve all reseller subscriptions method.
   *
   * Completes with a [Subscription].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subscription> activate(core.String customerId, core.String subscriptionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }

    _url = 'customers/' + commons.Escaper.ecapeVariable('$customerId') + '/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId') + '/activate';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subscription.fromJson(data));
  }

  /**
   * Update a subscription plan. Use this method to update a plan for a 30-day
   * trial or a flexible plan subscription to an annual commitment plan with
   * monthly or yearly payments.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * [subscriptionId] - This is a required property. The subscriptionId is the
   * subscription identifier and is unique for each customer. Since a
   * subscriptionId changes when a subscription is updated, we recommend to not
   * use this ID as a key for persistent data. And the subscriptionId can be
   * found using the retrieve all reseller subscriptions method.
   *
   * Completes with a [Subscription].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subscription> changePlan(ChangePlanRequest request, core.String customerId, core.String subscriptionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }

    _url = 'customers/' + commons.Escaper.ecapeVariable('$customerId') + '/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId') + '/changePlan';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subscription.fromJson(data));
  }

  /**
   * Update a user license's renewal settings. This is applicable for accounts
   * with annual commitment plans only.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * [subscriptionId] - This is a required property. The subscriptionId is the
   * subscription identifier and is unique for each customer. Since a
   * subscriptionId changes when a subscription is updated, we recommend to not
   * use this ID as a key for persistent data. And the subscriptionId can be
   * found using the retrieve all reseller subscriptions method.
   *
   * Completes with a [Subscription].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subscription> changeRenewalSettings(RenewalSettings request, core.String customerId, core.String subscriptionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }

    _url = 'customers/' + commons.Escaper.ecapeVariable('$customerId') + '/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId') + '/changeRenewalSettings';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subscription.fromJson(data));
  }

  /**
   * Update a subscription's user license settings.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * [subscriptionId] - This is a required property. The subscriptionId is the
   * subscription identifier and is unique for each customer. Since a
   * subscriptionId changes when a subscription is updated, we recommend to not
   * use this ID as a key for persistent data. And the subscriptionId can be
   * found using the retrieve all reseller subscriptions method.
   *
   * Completes with a [Subscription].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subscription> changeSeats(Seats request, core.String customerId, core.String subscriptionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }

    _url = 'customers/' + commons.Escaper.ecapeVariable('$customerId') + '/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId') + '/changeSeats';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subscription.fromJson(data));
  }

  /**
   * Cancel, suspend or transfer a subscription to direct.
   *
   * Request parameters:
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * [subscriptionId] - This is a required property. The subscriptionId is the
   * subscription identifier and is unique for each customer. Since a
   * subscriptionId changes when a subscription is updated, we recommend to not
   * use this ID as a key for persistent data. And the subscriptionId can be
   * found using the retrieve all reseller subscriptions method.
   *
   * [deletionType] - The deletionType query string enables the cancellation,
   * downgrade, or suspension of a subscription.
   * Possible string values are:
   * - "cancel" : Cancels the subscription immediately. This does not apply to a
   * G Suite subscription.
   * - "downgrade" : Downgrades a G Suite subscription to a Google Apps Free
   * edition subscription only if the customer was initially subscribed to a
   * Google Apps Free edition (also known as the Standard edition). Once
   * downgraded, the customer no longer has access to the previous G Suite
   * subscription and is no longer managed by the reseller.
   *
   * A G Suite subscription's downgrade cannot be invoked if an active or
   * suspended Google Drive or Google Vault subscription is present. The Google
   * Drive or Google Vault subscription must be cancelled before the G Suite
   * subscription's downgrade is invoked.
   *
   * The downgrade deletionType does not apply to other products or G Suite
   * SKUs.
   * - "suspend" : (DEPRECATED) The G Suite account is suspended for four days
   * and then cancelled. Once suspended, an administrator has access to the
   * suspended account, but the account users can not access their services. A
   * suspension can be lifted, using the reseller tools.
   *
   * A G Suite subscription's suspension can not be invoked if an active or
   * suspended Google Drive or Google Vault subscription is present. The Google
   * Drive or Google Vault subscription must be cancelled before the G Suite
   * subscription's suspension is invoked.
   * - "transfer_to_direct" : Transfers a subscription directly to Google.  The
   * customer is immediately transferred to a direct billing relationship with
   * Google and is given a short amount of time with no service interruption.
   * The customer can then choose to set up billing directly with Google by
   * using a credit card, or they can transfer to another reseller.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String customerId, core.String subscriptionId, core.String deletionType) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }
    if (deletionType == null) {
      throw new core.ArgumentError("Parameter deletionType is required.");
    }
    _queryParams["deletionType"] = [deletionType];

    _downloadOptions = null;

    _url = 'customers/' + commons.Escaper.ecapeVariable('$customerId') + '/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId');

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
   * Get a specific subscription.
   *
   * Request parameters:
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * [subscriptionId] - This is a required property. The subscriptionId is the
   * subscription identifier and is unique for each customer. Since a
   * subscriptionId changes when a subscription is updated, we recommend to not
   * use this ID as a key for persistent data. And the subscriptionId can be
   * found using the retrieve all reseller subscriptions method.
   *
   * Completes with a [Subscription].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subscription> get(core.String customerId, core.String subscriptionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }

    _url = 'customers/' + commons.Escaper.ecapeVariable('$customerId') + '/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subscription.fromJson(data));
  }

  /**
   * Create or transfer a subscription.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * [customerAuthToken] - The customerAuthToken query string is required when
   * creating a resold account that transfers a direct customer's subscription
   * or transfers another reseller customer's subscription to your reseller
   * management. This is a hexadecimal authentication token needed to complete
   * the subscription transfer. For more information, see the administrator help
   * center.
   *
   * Completes with a [Subscription].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subscription> insert(Subscription request, core.String customerId, {core.String customerAuthToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }
    if (customerAuthToken != null) {
      _queryParams["customerAuthToken"] = [customerAuthToken];
    }

    _url = 'customers/' + commons.Escaper.ecapeVariable('$customerId') + '/subscriptions';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subscription.fromJson(data));
  }

  /**
   * List of subscriptions managed by the reseller. The list can be all
   * subscriptions, all of a customer's subscriptions, or all of a customer's
   * transferable subscriptions.
   *
   * Request parameters:
   *
   * [customerAuthToken] - The customerAuthToken query string is required when
   * creating a resold account that transfers a direct customer's subscription
   * or transfers another reseller customer's subscription to your reseller
   * management. This is a hexadecimal authentication token needed to complete
   * the subscription transfer. For more information, see the administrator help
   * center.
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * [customerNamePrefix] - When retrieving all of your subscriptions and
   * filtering for specific customers, you can enter a prefix for a customer
   * name. Using an example customer group that includes exam.com, example20.com
   * and example.com:
   * - exa -- Returns all customer names that start with 'exa' which could
   * include exam.com, example20.com, and example.com. A name prefix is similar
   * to using a regular expression's asterisk, exa*.
   * - example -- Returns example20.com and example.com.
   *
   * [maxResults] - When retrieving a large list, the maxResults is the maximum
   * number of results per page. The nextPageToken value takes you to the next
   * page. The default is 20.
   * Value must be between "1" and "100".
   *
   * [pageToken] - Token to specify next page in the list
   *
   * Completes with a [Subscriptions].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subscriptions> list({core.String customerAuthToken, core.String customerId, core.String customerNamePrefix, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (customerAuthToken != null) {
      _queryParams["customerAuthToken"] = [customerAuthToken];
    }
    if (customerId != null) {
      _queryParams["customerId"] = [customerId];
    }
    if (customerNamePrefix != null) {
      _queryParams["customerNamePrefix"] = [customerNamePrefix];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'subscriptions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subscriptions.fromJson(data));
  }

  /**
   * Immediately move a 30-day free trial subscription to a paid service
   * subscription.
   *
   * Request parameters:
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * [subscriptionId] - This is a required property. The subscriptionId is the
   * subscription identifier and is unique for each customer. Since a
   * subscriptionId changes when a subscription is updated, we recommend to not
   * use this ID as a key for persistent data. And the subscriptionId can be
   * found using the retrieve all reseller subscriptions method.
   *
   * Completes with a [Subscription].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subscription> startPaidService(core.String customerId, core.String subscriptionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }

    _url = 'customers/' + commons.Escaper.ecapeVariable('$customerId') + '/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId') + '/startPaidService';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subscription.fromJson(data));
  }

  /**
   * Suspends an active subscription.
   *
   * Request parameters:
   *
   * [customerId] - Either the customer's primary domain name or the customer's
   * unique identifier. If using the domain name, we do not recommend using a
   * customerId as a key for persistent data. If the domain name for a
   * customerId is changed, the Google system automatically updates.
   *
   * [subscriptionId] - This is a required property. The subscriptionId is the
   * subscription identifier and is unique for each customer. Since a
   * subscriptionId changes when a subscription is updated, we recommend to not
   * use this ID as a key for persistent data. And the subscriptionId can be
   * found using the retrieve all reseller subscriptions method.
   *
   * Completes with a [Subscription].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subscription> suspend(core.String customerId, core.String subscriptionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (customerId == null) {
      throw new core.ArgumentError("Parameter customerId is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }

    _url = 'customers/' + commons.Escaper.ecapeVariable('$customerId') + '/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId') + '/suspend';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subscription.fromJson(data));
  }

}



/** JSON template for address of a customer. */
class Address {
  /**
   * A customer's physical address. An address can be composed of one to three
   * lines. The addressline2 and addressLine3 are optional.
   */
  core.String addressLine1;
  /** Line 2 of the address. */
  core.String addressLine2;
  /** Line 3 of the address. */
  core.String addressLine3;
  /** The customer contact's name. This is required. */
  core.String contactName;
  /**
   * For countryCode information, see the ISO 3166 country code elements. Verify
   * that country is approved for resale of Google products. This property is
   * required when creating a new customer.
   */
  core.String countryCode;
  /**
   * Identifies the resource as a customer address. Value: customers#address
   */
  core.String kind;
  /** An example of a locality value is the city of San Francisco. */
  core.String locality;
  /** The company or company division name. This is required. */
  core.String organizationName;
  /**
   * A postalCode example is a postal zip code such as 94043. This property is
   * required when creating a new customer.
   */
  core.String postalCode;
  /** An example of a region value is CA for the state of California. */
  core.String region;

  Address();

  Address.fromJson(core.Map _json) {
    if (_json.containsKey("addressLine1")) {
      addressLine1 = _json["addressLine1"];
    }
    if (_json.containsKey("addressLine2")) {
      addressLine2 = _json["addressLine2"];
    }
    if (_json.containsKey("addressLine3")) {
      addressLine3 = _json["addressLine3"];
    }
    if (_json.containsKey("contactName")) {
      contactName = _json["contactName"];
    }
    if (_json.containsKey("countryCode")) {
      countryCode = _json["countryCode"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("locality")) {
      locality = _json["locality"];
    }
    if (_json.containsKey("organizationName")) {
      organizationName = _json["organizationName"];
    }
    if (_json.containsKey("postalCode")) {
      postalCode = _json["postalCode"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (addressLine1 != null) {
      _json["addressLine1"] = addressLine1;
    }
    if (addressLine2 != null) {
      _json["addressLine2"] = addressLine2;
    }
    if (addressLine3 != null) {
      _json["addressLine3"] = addressLine3;
    }
    if (contactName != null) {
      _json["contactName"] = contactName;
    }
    if (countryCode != null) {
      _json["countryCode"] = countryCode;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (locality != null) {
      _json["locality"] = locality;
    }
    if (organizationName != null) {
      _json["organizationName"] = organizationName;
    }
    if (postalCode != null) {
      _json["postalCode"] = postalCode;
    }
    if (region != null) {
      _json["region"] = region;
    }
    return _json;
  }
}

/** JSON template for the ChangePlan rpc request. */
class ChangePlanRequest {
  /**
   * Google-issued code (100 char max) for discounted pricing on subscription
   * plans. Deal code must be included in changePlan request in order to receive
   * discounted rate. This property is optional. If a deal code has already been
   * added to a subscription, this property may be left empty and the existing
   * discounted rate will still apply (if not empty, only provide the deal code
   * that is already present on the subscription). If a deal code has never been
   * added to a subscription and this property is left blank, regular pricing
   * will apply.
   */
  core.String dealCode;
  /**
   * Identifies the resource as a subscription change plan request. Value:
   * subscriptions#changePlanRequest
   */
  core.String kind;
  /**
   * The planName property is required. This is the name of the subscription's
   * payment plan. For more information about the Google payment plans, see API
   * concepts.
   *
   * Possible values are:
   * - ANNUAL_MONTHLY_PAY - The annual commitment plan with monthly payments
   * - ANNUAL_YEARLY_PAY - The annual commitment plan with yearly payments
   * - FLEXIBLE - The flexible plan
   * - TRIAL - The 30-day free trial plan
   */
  core.String planName;
  /**
   * This is an optional property. This purchase order (PO) information is for
   * resellers to use for their company tracking usage. If a purchaseOrderId
   * value is given it appears in the API responses and shows up in the invoice.
   * The property accepts up to 80 plain text characters.
   */
  core.String purchaseOrderId;
  /**
   * This is a required property. The seats property is the number of user seat
   * licenses.
   */
  Seats seats;

  ChangePlanRequest();

  ChangePlanRequest.fromJson(core.Map _json) {
    if (_json.containsKey("dealCode")) {
      dealCode = _json["dealCode"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("planName")) {
      planName = _json["planName"];
    }
    if (_json.containsKey("purchaseOrderId")) {
      purchaseOrderId = _json["purchaseOrderId"];
    }
    if (_json.containsKey("seats")) {
      seats = new Seats.fromJson(_json["seats"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dealCode != null) {
      _json["dealCode"] = dealCode;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (planName != null) {
      _json["planName"] = planName;
    }
    if (purchaseOrderId != null) {
      _json["purchaseOrderId"] = purchaseOrderId;
    }
    if (seats != null) {
      _json["seats"] = (seats).toJson();
    }
    return _json;
  }
}

/** JSON template for a customer. */
class Customer {
  /**
   * Like the "Customer email" in the reseller tools, this email is the
   * secondary contact used if something happens to the customer's service such
   * as service outage or a security issue. This property is required when
   * creating a new customer and should not use the same domain as
   * customerDomain.
   */
  core.String alternateEmail;
  /**
   * The customer's primary domain name string. customerDomain is required when
   * creating a new customer. Do not include the www prefix in the domain when
   * adding a customer.
   */
  core.String customerDomain;
  /** Whether the customer's primary domain has been verified. */
  core.bool customerDomainVerified;
  /**
   * This property will always be returned in a response as the unique
   * identifier generated by Google. In a request, this property can be either
   * the primary domain or the unique identifier generated by Google.
   */
  core.String customerId;
  /** Identifies the resource as a customer. Value: reseller#customer */
  core.String kind;
  /**
   * Customer contact phone number. This can be continuous numbers, with spaces,
   * etc. But it must be a real phone number and not, for example, "123". See
   * phone  local format conventions.
   */
  core.String phoneNumber;
  /**
   * A customer's address information. Each field has a limit of 255 charcters.
   */
  Address postalAddress;
  /**
   * URL to customer's Admin console dashboard. The read-only URL is generated
   * by the API service. This is used if your client application requires the
   * customer to complete a task in the Admin console.
   */
  core.String resourceUiUrl;

  Customer();

  Customer.fromJson(core.Map _json) {
    if (_json.containsKey("alternateEmail")) {
      alternateEmail = _json["alternateEmail"];
    }
    if (_json.containsKey("customerDomain")) {
      customerDomain = _json["customerDomain"];
    }
    if (_json.containsKey("customerDomainVerified")) {
      customerDomainVerified = _json["customerDomainVerified"];
    }
    if (_json.containsKey("customerId")) {
      customerId = _json["customerId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("phoneNumber")) {
      phoneNumber = _json["phoneNumber"];
    }
    if (_json.containsKey("postalAddress")) {
      postalAddress = new Address.fromJson(_json["postalAddress"]);
    }
    if (_json.containsKey("resourceUiUrl")) {
      resourceUiUrl = _json["resourceUiUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alternateEmail != null) {
      _json["alternateEmail"] = alternateEmail;
    }
    if (customerDomain != null) {
      _json["customerDomain"] = customerDomain;
    }
    if (customerDomainVerified != null) {
      _json["customerDomainVerified"] = customerDomainVerified;
    }
    if (customerId != null) {
      _json["customerId"] = customerId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (phoneNumber != null) {
      _json["phoneNumber"] = phoneNumber;
    }
    if (postalAddress != null) {
      _json["postalAddress"] = (postalAddress).toJson();
    }
    if (resourceUiUrl != null) {
      _json["resourceUiUrl"] = resourceUiUrl;
    }
    return _json;
  }
}

/** JSON template for a subscription renewal settings. */
class RenewalSettings {
  /**
   * Identifies the resource as a subscription renewal setting. Value:
   * subscriptions#renewalSettings
   */
  core.String kind;
  /**
   * Renewal settings for the annual commitment plan. For more detailed
   * information, see renewal options in the administrator help center. When
   * renewing a subscription, the renewalType is a required property.
   */
  core.String renewalType;

  RenewalSettings();

  RenewalSettings.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("renewalType")) {
      renewalType = _json["renewalType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (renewalType != null) {
      _json["renewalType"] = renewalType;
    }
    return _json;
  }
}

/** JSON template for resellernotify getwatchdetails response. */
class ResellernotifyGetwatchdetailsResponse {
  /** List of registered service accounts. */
  core.List<core.String> serviceAccountEmailAddresses;
  /** Topic name of the PubSub */
  core.String topicName;

  ResellernotifyGetwatchdetailsResponse();

  ResellernotifyGetwatchdetailsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("serviceAccountEmailAddresses")) {
      serviceAccountEmailAddresses = _json["serviceAccountEmailAddresses"];
    }
    if (_json.containsKey("topicName")) {
      topicName = _json["topicName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (serviceAccountEmailAddresses != null) {
      _json["serviceAccountEmailAddresses"] = serviceAccountEmailAddresses;
    }
    if (topicName != null) {
      _json["topicName"] = topicName;
    }
    return _json;
  }
}

/** JSON template for resellernotify response. */
class ResellernotifyResource {
  /** Topic name of the PubSub */
  core.String topicName;

  ResellernotifyResource();

  ResellernotifyResource.fromJson(core.Map _json) {
    if (_json.containsKey("topicName")) {
      topicName = _json["topicName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (topicName != null) {
      _json["topicName"] = topicName;
    }
    return _json;
  }
}

/** JSON template for subscription seats. */
class Seats {
  /**
   * Identifies the resource as a subscription change plan request. Value:
   * subscriptions#seats
   */
  core.String kind;
  /**
   * Read-only field containing the current number of licensed seats for
   * FLEXIBLE Google-Apps subscriptions and secondary subscriptions such as
   * Google-Vault and Drive-storage.
   */
  core.int licensedNumberOfSeats;
  /**
   * The maximumNumberOfSeats property is the maximum number of licenses that
   * the customer can purchase. This property applies to plans other than the
   * annual commitment plan. How a user's licenses are managed depends on the
   * subscription's payment plan:
   * - annual commitment plan (with monthly or yearly payments) — For this plan,
   * a reseller is invoiced on the number of user licenses in the numberOfSeats
   * property. The maximumNumberOfSeats property is a read-only property in the
   * API's response.
   * - flexible plan — For this plan, a reseller is invoiced on the actual
   * number of users which is capped by the maximumNumberOfSeats. This is the
   * maximum number of user licenses a customer has for user license
   * provisioning. This quantity can be increased up to the maximum limit
   * defined in the reseller's contract. And the minimum quantity is the current
   * number of users in the customer account.
   * - 30-day free trial plan — A subscription in a 30-day free trial is
   * restricted to maximum 10 seats.
   */
  core.int maximumNumberOfSeats;
  /**
   * The numberOfSeats property holds the customer's number of user licenses.
   * How a user's licenses are managed depends on the subscription's plan:
   * - annual commitment plan (with monthly or yearly pay) — For this plan, a
   * reseller is invoiced on the number of user licenses in the numberOfSeats
   * property. This is the maximum number of user licenses that a reseller's
   * customer can create. The reseller can add more licenses, but once set, the
   * numberOfSeats can not be reduced until renewal. The reseller is invoiced
   * based on the numberOfSeats value regardless of how many of these user
   * licenses are provisioned users.
   * - flexible plan — For this plan, a reseller is invoiced on the actual
   * number of users which is capped by the maximumNumberOfSeats. The
   * numberOfSeats property is not used in the request or response for flexible
   * plan customers.
   * - 30-day free trial plan — The numberOfSeats property is not used in the
   * request or response for an account in a 30-day trial.
   */
  core.int numberOfSeats;

  Seats();

  Seats.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("licensedNumberOfSeats")) {
      licensedNumberOfSeats = _json["licensedNumberOfSeats"];
    }
    if (_json.containsKey("maximumNumberOfSeats")) {
      maximumNumberOfSeats = _json["maximumNumberOfSeats"];
    }
    if (_json.containsKey("numberOfSeats")) {
      numberOfSeats = _json["numberOfSeats"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (licensedNumberOfSeats != null) {
      _json["licensedNumberOfSeats"] = licensedNumberOfSeats;
    }
    if (maximumNumberOfSeats != null) {
      _json["maximumNumberOfSeats"] = maximumNumberOfSeats;
    }
    if (numberOfSeats != null) {
      _json["numberOfSeats"] = numberOfSeats;
    }
    return _json;
  }
}

/**
 * In this version of the API, annual commitment plan's interval is one year.
 */
class SubscriptionPlanCommitmentInterval {
  /**
   * An annual commitment plan's interval's endTime in milliseconds using the
   * UNIX Epoch format. See an example Epoch converter.
   */
  core.String endTime;
  /**
   * An annual commitment plan's interval's startTime in milliseconds using UNIX
   * Epoch format. See an example Epoch converter.
   */
  core.String startTime;

  SubscriptionPlanCommitmentInterval();

  SubscriptionPlanCommitmentInterval.fromJson(core.Map _json) {
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

/**
 * The plan property is required. In this version of the API, the G Suite plans
 * are the flexible plan, annual commitment plan, and the 30-day free trial
 * plan. For more information about the API"s payment plans, see the API
 * concepts.
 */
class SubscriptionPlan {
  /**
   * In this version of the API, annual commitment plan's interval is one year.
   */
  SubscriptionPlanCommitmentInterval commitmentInterval;
  /**
   * The isCommitmentPlan property's boolean value identifies the plan as an
   * annual commitment plan:
   * - true — The subscription's plan is an annual commitment plan.
   * - false — The plan is not an annual commitment plan.
   */
  core.bool isCommitmentPlan;
  /**
   * The planName property is required. This is the name of the subscription's
   * plan. For more information about the Google payment plans, see the API
   * concepts.
   *
   * Possible values are:
   * - ANNUAL_MONTHLY_PAY — The annual commitment plan with monthly payments
   * - ANNUAL_YEARLY_PAY — The annual commitment plan with yearly payments
   * - FLEXIBLE — The flexible plan
   * - TRIAL — The 30-day free trial plan. A subscription in trial will be
   * suspended after the 30th free day if no payment plan is assigned. Calling
   * changePlan will assign a payment plan to a trial but will not activate the
   * plan. A trial will automatically begin its assigned payment plan after its
   * 30th free day or immediately after calling startPaidService.
   */
  core.String planName;

  SubscriptionPlan();

  SubscriptionPlan.fromJson(core.Map _json) {
    if (_json.containsKey("commitmentInterval")) {
      commitmentInterval = new SubscriptionPlanCommitmentInterval.fromJson(_json["commitmentInterval"]);
    }
    if (_json.containsKey("isCommitmentPlan")) {
      isCommitmentPlan = _json["isCommitmentPlan"];
    }
    if (_json.containsKey("planName")) {
      planName = _json["planName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (commitmentInterval != null) {
      _json["commitmentInterval"] = (commitmentInterval).toJson();
    }
    if (isCommitmentPlan != null) {
      _json["isCommitmentPlan"] = isCommitmentPlan;
    }
    if (planName != null) {
      _json["planName"] = planName;
    }
    return _json;
  }
}

/**
 * Read-only transfer related information for the subscription. For more
 * information, see retrieve transferable subscriptions for a customer.
 */
class SubscriptionTransferInfo {
  /**
   * When inserting a subscription, this is the minimum number of seats listed
   * in the transfer order for this product. For example, if the customer has 20
   * users, the reseller cannot place a transfer order of 15 seats. The minimum
   * is 20 seats.
   */
  core.int minimumTransferableSeats;
  /**
   * The time when transfer token or intent to transfer will expire. The time is
   * in milliseconds using UNIX Epoch format.
   */
  core.String transferabilityExpirationTime;

  SubscriptionTransferInfo();

  SubscriptionTransferInfo.fromJson(core.Map _json) {
    if (_json.containsKey("minimumTransferableSeats")) {
      minimumTransferableSeats = _json["minimumTransferableSeats"];
    }
    if (_json.containsKey("transferabilityExpirationTime")) {
      transferabilityExpirationTime = _json["transferabilityExpirationTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (minimumTransferableSeats != null) {
      _json["minimumTransferableSeats"] = minimumTransferableSeats;
    }
    if (transferabilityExpirationTime != null) {
      _json["transferabilityExpirationTime"] = transferabilityExpirationTime;
    }
    return _json;
  }
}

/**
 * The G Suite annual commitment and flexible payment plans can be in a 30-day
 * free trial. For more information, see the API concepts.
 */
class SubscriptionTrialSettings {
  /**
   * Determines if a subscription's plan is in a 30-day free trial or not:
   * - true — The plan is in trial.
   * - false — The plan is not in trial.
   */
  core.bool isInTrial;
  /**
   * Date when the trial ends. The value is in milliseconds using the UNIX Epoch
   * format. See an example Epoch converter.
   */
  core.String trialEndTime;

  SubscriptionTrialSettings();

  SubscriptionTrialSettings.fromJson(core.Map _json) {
    if (_json.containsKey("isInTrial")) {
      isInTrial = _json["isInTrial"];
    }
    if (_json.containsKey("trialEndTime")) {
      trialEndTime = _json["trialEndTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (isInTrial != null) {
      _json["isInTrial"] = isInTrial;
    }
    if (trialEndTime != null) {
      _json["trialEndTime"] = trialEndTime;
    }
    return _json;
  }
}

/** JSON template for a subscription. */
class Subscription {
  /**
   * Read-only field that returns the current billing method for a subscription.
   */
  core.String billingMethod;
  /**
   * The creationTime property is the date when subscription was created. It is
   * in milliseconds using the Epoch format. See an example Epoch converter.
   */
  core.String creationTime;
  /** Primary domain name of the customer */
  core.String customerDomain;
  /**
   * This property will always be returned in a response as the unique
   * identifier generated by Google. In a request, this property can be either
   * the primary domain or the unique identifier generated by Google.
   */
  core.String customerId;
  /**
   * Google-issued code (100 char max) for discounted pricing on subscription
   * plans. Deal code must be included in insert requests in order to receive
   * discounted rate. This property is optional, regular pricing applies if left
   * empty.
   */
  core.String dealCode;
  /**
   * Identifies the resource as a Subscription. Value: reseller#subscription
   */
  core.String kind;
  /**
   * The plan property is required. In this version of the API, the G Suite
   * plans are the flexible plan, annual commitment plan, and the 30-day free
   * trial plan. For more information about the API"s payment plans, see the API
   * concepts.
   */
  SubscriptionPlan plan;
  /**
   * This is an optional property. This purchase order (PO) information is for
   * resellers to use for their company tracking usage. If a purchaseOrderId
   * value is given it appears in the API responses and shows up in the invoice.
   * The property accepts up to 80 plain text characters.
   */
  core.String purchaseOrderId;
  /**
   * Renewal settings for the annual commitment plan. For more detailed
   * information, see renewal options in the administrator help center.
   */
  RenewalSettings renewalSettings;
  /**
   * URL to customer's Subscriptions page in the Admin console. The read-only
   * URL is generated by the API service. This is used if your client
   * application requires the customer to complete a task using the
   * Subscriptions page in the Admin console.
   */
  core.String resourceUiUrl;
  /**
   * This is a required property. The number and limit of user seat licenses in
   * the plan.
   */
  Seats seats;
  /**
   * A required property. The skuId is a unique system identifier for a
   * product's SKU assigned to a customer in the subscription. For products and
   * SKUs available in this version of the API, see  Product and SKU IDs.
   */
  core.String skuId;
  /** This is an optional property. */
  core.String status;
  /**
   * The subscriptionId is the subscription identifier and is unique for each
   * customer. This is a required property. Since a subscriptionId changes when
   * a subscription is updated, we recommend not using this ID as a key for
   * persistent data. Use the subscriptionId as described in retrieve all
   * reseller subscriptions.
   */
  core.String subscriptionId;
  /**
   * Read-only field containing an enumerable of all the current suspension
   * reasons for a subscription. It is possible for a subscription to have many
   * concurrent, overlapping suspension reasons. A subscription's STATUS is
   * SUSPENDED until all pending suspensions are removed.
   *
   * Possible options include:
   * - PENDING_TOS_ACCEPTANCE - The customer has not logged in and accepted the
   * G Suite Resold Terms of Services.
   * - RENEWAL_WITH_TYPE_CANCEL - The customer's commitment ended and their
   * service was cancelled at the end of their term.
   * - RESELLER_INITIATED - A manual suspension invoked by a Reseller.
   * - TRIAL_ENDED - The customer's trial expired without a plan selected.
   * - OTHER - The customer is suspended for an internal Google reason (e.g.
   * abuse or otherwise).
   */
  core.List<core.String> suspensionReasons;
  /**
   * Read-only transfer related information for the subscription. For more
   * information, see retrieve transferable subscriptions for a customer.
   */
  SubscriptionTransferInfo transferInfo;
  /**
   * The G Suite annual commitment and flexible payment plans can be in a 30-day
   * free trial. For more information, see the API concepts.
   */
  SubscriptionTrialSettings trialSettings;

  Subscription();

  Subscription.fromJson(core.Map _json) {
    if (_json.containsKey("billingMethod")) {
      billingMethod = _json["billingMethod"];
    }
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("customerDomain")) {
      customerDomain = _json["customerDomain"];
    }
    if (_json.containsKey("customerId")) {
      customerId = _json["customerId"];
    }
    if (_json.containsKey("dealCode")) {
      dealCode = _json["dealCode"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("plan")) {
      plan = new SubscriptionPlan.fromJson(_json["plan"]);
    }
    if (_json.containsKey("purchaseOrderId")) {
      purchaseOrderId = _json["purchaseOrderId"];
    }
    if (_json.containsKey("renewalSettings")) {
      renewalSettings = new RenewalSettings.fromJson(_json["renewalSettings"]);
    }
    if (_json.containsKey("resourceUiUrl")) {
      resourceUiUrl = _json["resourceUiUrl"];
    }
    if (_json.containsKey("seats")) {
      seats = new Seats.fromJson(_json["seats"]);
    }
    if (_json.containsKey("skuId")) {
      skuId = _json["skuId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("subscriptionId")) {
      subscriptionId = _json["subscriptionId"];
    }
    if (_json.containsKey("suspensionReasons")) {
      suspensionReasons = _json["suspensionReasons"];
    }
    if (_json.containsKey("transferInfo")) {
      transferInfo = new SubscriptionTransferInfo.fromJson(_json["transferInfo"]);
    }
    if (_json.containsKey("trialSettings")) {
      trialSettings = new SubscriptionTrialSettings.fromJson(_json["trialSettings"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (billingMethod != null) {
      _json["billingMethod"] = billingMethod;
    }
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (customerDomain != null) {
      _json["customerDomain"] = customerDomain;
    }
    if (customerId != null) {
      _json["customerId"] = customerId;
    }
    if (dealCode != null) {
      _json["dealCode"] = dealCode;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (plan != null) {
      _json["plan"] = (plan).toJson();
    }
    if (purchaseOrderId != null) {
      _json["purchaseOrderId"] = purchaseOrderId;
    }
    if (renewalSettings != null) {
      _json["renewalSettings"] = (renewalSettings).toJson();
    }
    if (resourceUiUrl != null) {
      _json["resourceUiUrl"] = resourceUiUrl;
    }
    if (seats != null) {
      _json["seats"] = (seats).toJson();
    }
    if (skuId != null) {
      _json["skuId"] = skuId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (subscriptionId != null) {
      _json["subscriptionId"] = subscriptionId;
    }
    if (suspensionReasons != null) {
      _json["suspensionReasons"] = suspensionReasons;
    }
    if (transferInfo != null) {
      _json["transferInfo"] = (transferInfo).toJson();
    }
    if (trialSettings != null) {
      _json["trialSettings"] = (trialSettings).toJson();
    }
    return _json;
  }
}

/** JSON template for a subscription list. */
class Subscriptions {
  /**
   * Identifies the resource as a collection of subscriptions. Value:
   * reseller#subscriptions
   */
  core.String kind;
  /**
   * The continuation token, used to page through large result sets. Provide
   * this value in a subsequent request to return the next page of results.
   */
  core.String nextPageToken;
  /** The subscriptions in this page of results. */
  core.List<Subscription> subscriptions;

  Subscriptions();

  Subscriptions.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("subscriptions")) {
      subscriptions = _json["subscriptions"].map((value) => new Subscription.fromJson(value)).toList();
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
    if (subscriptions != null) {
      _json["subscriptions"] = subscriptions.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
