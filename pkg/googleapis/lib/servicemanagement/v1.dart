// This is a generated file (see the discoveryapis_generator project).

library googleapis.servicemanagement.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http_1;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client servicemanagement/v1';

/**
 * Google Service Management allows service producers to publish their services
 * on Google Cloud Platform so that they can be discovered and used by service
 * consumers.
 */
class ServicemanagementApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /** View your data across Google Cloud Platform services */
  static const CloudPlatformReadOnlyScope = "https://www.googleapis.com/auth/cloud-platform.read-only";

  /** Manage your Google API service configuration */
  static const ServiceManagementScope = "https://www.googleapis.com/auth/service.management";

  /** View your Google API service configuration */
  static const ServiceManagementReadonlyScope = "https://www.googleapis.com/auth/service.management.readonly";


  final commons.ApiRequester _requester;

  OperationsResourceApi get operations => new OperationsResourceApi(_requester);
  ServicesResourceApi get services => new ServicesResourceApi(_requester);

  ServicemanagementApi(http_1.Client client, {core.String rootUrl: "https://servicemanagement.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class OperationsResourceApi {
  final commons.ApiRequester _requester;

  OperationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the latest state of a long-running operation.  Clients can use this
   * method to poll the operation result at intervals as recommended by the API
   * service.
   *
   * Request parameters:
   *
   * [name] - The name of the operation resource.
   * Value must have pattern "^operations/.+$".
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Operation> get(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

}


class ServicesResourceApi {
  final commons.ApiRequester _requester;

  ServicesConfigsResourceApi get configs => new ServicesConfigsResourceApi(_requester);
  ServicesRolloutsResourceApi get rollouts => new ServicesRolloutsResourceApi(_requester);

  ServicesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new managed service.
   * Please note one producer project can own no more than 20 services.
   *
   * Operation<response: ManagedService>
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Operation> create(ManagedService request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/services';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /**
   * Deletes a managed service. This method will change the service to the
   * `Soft-Delete` state for 30 days. Within this period, service producers may
   * call UndeleteService to restore the service.
   * After 30 days, the service will be permanently deleted.
   *
   * Operation<response: google.protobuf.Empty>
   *
   * Request parameters:
   *
   * [serviceName] - The name of the service.  See the
   * [overview](/service-management/overview)
   * for naming requirements.  For example: `example.googleapis.com`.
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Operation> delete(core.String serviceName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /**
   * Disable a managed service for a project.
   *
   * Operation<response: DisableServiceResponse>
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [serviceName] - Name of the service to disable. Specifying an unknown
   * service name
   * will cause the request to fail.
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Operation> disable(DisableServiceRequest request, core.String serviceName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName') + ':disable';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /**
   * Enable a managed service for a project with default setting.
   *
   * Operation<response: EnableServiceResponse>
   *
   * google.rpc.Status errors may contain a
   * google.rpc.PreconditionFailure error detail.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [serviceName] - Name of the service to enable. Specifying an unknown
   * service name will
   * cause the request to fail.
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Operation> enable(EnableServiceRequest request, core.String serviceName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName') + ':enable';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /**
   * Generates and returns a report (errors, warnings and changes from
   * existing configurations) associated with
   * GenerateConfigReportRequest.new_value
   *
   * If GenerateConfigReportRequest.old_value is specified,
   * GenerateConfigReportRequest will contain a single ChangeReport based on the
   * comparison between GenerateConfigReportRequest.new_value and
   * GenerateConfigReportRequest.old_value.
   * If GenerateConfigReportRequest.old_value is not specified, this method
   * will compare GenerateConfigReportRequest.new_value with the last pushed
   * service configuration.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [GenerateConfigReportResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<GenerateConfigReportResponse> generateConfigReport(GenerateConfigReportRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/services:generateConfigReport';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GenerateConfigReportResponse.fromJson(data));
  }

  /**
   * Gets a managed service. Authentication is required unless the service is
   * public.
   *
   * Request parameters:
   *
   * [serviceName] - The name of the service.  See the `ServiceManager` overview
   * for naming
   * requirements.  For example: `example.googleapis.com`.
   *
   * Completes with a [ManagedService].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<ManagedService> get(core.String serviceName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ManagedService.fromJson(data));
  }

  /**
   * Gets a service configuration (version) for a managed service.
   *
   * Request parameters:
   *
   * [serviceName] - The name of the service.  See the
   * [overview](/service-management/overview)
   * for naming requirements.  For example: `example.googleapis.com`.
   *
   * [view] - Specifies which parts of the Service Config should be returned in
   * the
   * response.
   * Possible string values are:
   * - "BASIC" : A BASIC.
   * - "FULL" : A FULL.
   *
   * [configId] - The id of the service configuration resource.
   *
   * Completes with a [Service].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Service> getConfig(core.String serviceName, {core.String view, core.String configId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }
    if (configId != null) {
      _queryParams["configId"] = [configId];
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName') + '/config';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Service.fromJson(data));
  }

  /**
   * Gets the access control policy for a resource.
   * Returns an empty policy if the resource exists and does not have a policy
   * set.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which the policy is being
   * requested.
   * See the operation documentation for the appropriate value for this field.
   * Value must have pattern "^services/[^/]+$".
   *
   * Completes with a [Policy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Policy> getIamPolicy(GetIamPolicyRequest request, core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$resource') + ':getIamPolicy';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Policy.fromJson(data));
  }

  /**
   * Lists managed services.
   *
   * Returns all public services. For authenticated users, also returns all
   * services the calling user has "servicemanagement.services.get" permission
   * for.
   *
   * **BETA:** If the caller specifies the `consumer_id`, it returns only the
   * services enabled on the consumer. The `consumer_id` must have the format
   * of "project:{PROJECT-ID}".
   *
   * Request parameters:
   *
   * [consumerId] - Include services consumed by the specified consumer.
   *
   * The Google Service Management implementation accepts the following
   * forms:
   * - project:<project_id>
   *
   * [pageToken] - Token identifying which result to start with; returned by a
   * previous list
   * call.
   *
   * [pageSize] - Requested size of the next page of data.
   *
   * [producerProjectId] - Include services produced by the specified project.
   *
   * Completes with a [ListServicesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<ListServicesResponse> list({core.String consumerId, core.String pageToken, core.int pageSize, core.String producerProjectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (consumerId != null) {
      _queryParams["consumerId"] = [consumerId];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (producerProjectId != null) {
      _queryParams["producerProjectId"] = [producerProjectId];
    }

    _url = 'v1/services';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListServicesResponse.fromJson(data));
  }

  /**
   * Sets the access control policy on the specified resource. Replaces any
   * existing policy.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which the policy is being
   * specified.
   * See the operation documentation for the appropriate value for this field.
   * Value must have pattern "^services/[^/]+$".
   *
   * Completes with a [Policy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Policy> setIamPolicy(SetIamPolicyRequest request, core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$resource') + ':setIamPolicy';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Policy.fromJson(data));
  }

  /**
   * Returns permissions that a caller has on the specified resource.
   * If the resource does not exist, this will return an empty set of
   * permissions, not a NOT_FOUND error.
   *
   * Note: This operation is designed to be used for building permission-aware
   * UIs and command-line tools, not for authorization checking. This operation
   * may "fail open" without warning.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which the policy detail is being
   * requested.
   * See the operation documentation for the appropriate value for this field.
   * Value must have pattern "^services/[^/]+$".
   *
   * Completes with a [TestIamPermissionsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<TestIamPermissionsResponse> testIamPermissions(TestIamPermissionsRequest request, core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$resource') + ':testIamPermissions';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TestIamPermissionsResponse.fromJson(data));
  }

  /**
   * Revives a previously deleted managed service. The method restores the
   * service using the configuration at the time the service was deleted.
   * The target service must exist and must have been deleted within the
   * last 30 days.
   *
   * Operation<response: UndeleteServiceResponse>
   *
   * Request parameters:
   *
   * [serviceName] - The name of the service. See the
   * [overview](/service-management/overview)
   * for naming requirements. For example: `example.googleapis.com`.
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Operation> undelete(core.String serviceName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName') + ':undelete';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

}


class ServicesConfigsResourceApi {
  final commons.ApiRequester _requester;

  ServicesConfigsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new service configuration (version) for a managed service.
   * This method only stores the service configuration. To roll out the service
   * configuration to backend systems please call
   * CreateServiceRollout.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [serviceName] - The name of the service.  See the
   * [overview](/service-management/overview)
   * for naming requirements.  For example: `example.googleapis.com`.
   *
   * Completes with a [Service].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Service> create(Service request, core.String serviceName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName') + '/configs';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Service.fromJson(data));
  }

  /**
   * Gets a service configuration (version) for a managed service.
   *
   * Request parameters:
   *
   * [serviceName] - The name of the service.  See the
   * [overview](/service-management/overview)
   * for naming requirements.  For example: `example.googleapis.com`.
   *
   * [configId] - The id of the service configuration resource.
   *
   * [view] - Specifies which parts of the Service Config should be returned in
   * the
   * response.
   * Possible string values are:
   * - "BASIC" : A BASIC.
   * - "FULL" : A FULL.
   *
   * Completes with a [Service].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Service> get(core.String serviceName, core.String configId, {core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }
    if (configId == null) {
      throw new core.ArgumentError("Parameter configId is required.");
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName') + '/configs/' + commons.Escaper.ecapeVariable('$configId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Service.fromJson(data));
  }

  /**
   * Lists the history of the service configuration for a managed service,
   * from the newest to the oldest.
   *
   * Request parameters:
   *
   * [serviceName] - The name of the service.  See the
   * [overview](/service-management/overview)
   * for naming requirements.  For example: `example.googleapis.com`.
   *
   * [pageToken] - The token of the page to retrieve.
   *
   * [pageSize] - The max number of items to include in the response list.
   *
   * Completes with a [ListServiceConfigsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<ListServiceConfigsResponse> list(core.String serviceName, {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName') + '/configs';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListServiceConfigsResponse.fromJson(data));
  }

  /**
   * Creates a new service configuration (version) for a managed service based
   * on
   * user-supplied configuration source files (for example: OpenAPI
   * Specification). This method stores the source configurations as well as the
   * generated service configuration. To rollout the service configuration to
   * other services,
   * please call CreateServiceRollout.
   *
   * Operation<response: SubmitConfigSourceResponse>
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [serviceName] - The name of the service.  See the
   * [overview](/service-management/overview)
   * for naming requirements.  For example: `example.googleapis.com`.
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Operation> submit(SubmitConfigSourceRequest request, core.String serviceName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName') + '/configs:submit';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

}


class ServicesRolloutsResourceApi {
  final commons.ApiRequester _requester;

  ServicesRolloutsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new service configuration rollout. Based on rollout, the
   * Google Service Management will roll out the service configurations to
   * different backend services. For example, the logging configuration will be
   * pushed to Google Cloud Logging.
   *
   * Please note that any previous pending and running Rollouts and associated
   * Operations will be automatically cancelled so that the latest Rollout will
   * not be blocked by previous Rollouts.
   *
   * Operation<response: Rollout>
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [serviceName] - The name of the service.  See the
   * [overview](/service-management/overview)
   * for naming requirements.  For example: `example.googleapis.com`.
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Operation> create(Rollout request, core.String serviceName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName') + '/rollouts';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /**
   * Gets a service configuration rollout.
   *
   * Request parameters:
   *
   * [serviceName] - The name of the service.  See the
   * [overview](/service-management/overview)
   * for naming requirements.  For example: `example.googleapis.com`.
   *
   * [rolloutId] - The id of the rollout resource.
   *
   * Completes with a [Rollout].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<Rollout> get(core.String serviceName, core.String rolloutId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }
    if (rolloutId == null) {
      throw new core.ArgumentError("Parameter rolloutId is required.");
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName') + '/rollouts/' + commons.Escaper.ecapeVariable('$rolloutId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Rollout.fromJson(data));
  }

  /**
   * Lists the history of the service configuration rollouts for a managed
   * service, from the newest to the oldest.
   *
   * Request parameters:
   *
   * [serviceName] - The name of the service.  See the
   * [overview](/service-management/overview)
   * for naming requirements.  For example: `example.googleapis.com`.
   *
   * [pageSize] - The max number of items to include in the response list.
   *
   * [pageToken] - The token of the page to retrieve.
   *
   * Completes with a [ListServiceRolloutsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http_1.Client] completes with an error when making a REST
   * call, this method will complete with the same error.
   */
  async.Future<ListServiceRolloutsResponse> list(core.String serviceName, {core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (serviceName == null) {
      throw new core.ArgumentError("Parameter serviceName is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v1/services/' + commons.Escaper.ecapeVariable('$serviceName') + '/rollouts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListServiceRolloutsResponse.fromJson(data));
  }

}



/**
 * Generated advice about this change, used for providing more
 * information about how a change will affect the existing service.
 */
class Advice {
  /**
   * Useful description for why this advice was applied and what actions should
   * be taken to mitigate any implied risks.
   */
  core.String description;

  Advice();

  Advice.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    return _json;
  }
}

/** Api is a light-weight descriptor for a protocol buffer service. */
class Api {
  /** The methods of this api, in unspecified order. */
  core.List<Method> methods;
  /** Included APIs. See Mixin. */
  core.List<Mixin> mixins;
  /**
   * The fully qualified name of this api, including package name
   * followed by the api's simple name.
   */
  core.String name;
  /** Any metadata attached to the API. */
  core.List<Option> options;
  /**
   * Source context for the protocol buffer service represented by this
   * message.
   */
  SourceContext sourceContext;
  /**
   * The source syntax of the service.
   * Possible string values are:
   * - "SYNTAX_PROTO2" : Syntax `proto2`.
   * - "SYNTAX_PROTO3" : Syntax `proto3`.
   */
  core.String syntax;
  /**
   * A version string for this api. If specified, must have the form
   * `major-version.minor-version`, as in `1.10`. If the minor version
   * is omitted, it defaults to zero. If the entire version field is
   * empty, the major version is derived from the package name, as
   * outlined below. If the field is not empty, the version in the
   * package name will be verified to be consistent with what is
   * provided here.
   *
   * The versioning schema uses [semantic
   * versioning](http://semver.org) where the major version number
   * indicates a breaking change and the minor version an additive,
   * non-breaking change. Both version numbers are signals to users
   * what to expect from different versions, and should be carefully
   * chosen based on the product plan.
   *
   * The major version is also reflected in the package name of the
   * API, which must end in `v<major-version>`, as in
   * `google.feature.v1`. For major versions 0 and 1, the suffix can
   * be omitted. Zero major versions must only be used for
   * experimental, none-GA apis.
   */
  core.String version;

  Api();

  Api.fromJson(core.Map _json) {
    if (_json.containsKey("methods")) {
      methods = _json["methods"].map((value) => new Method.fromJson(value)).toList();
    }
    if (_json.containsKey("mixins")) {
      mixins = _json["mixins"].map((value) => new Mixin.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("options")) {
      options = _json["options"].map((value) => new Option.fromJson(value)).toList();
    }
    if (_json.containsKey("sourceContext")) {
      sourceContext = new SourceContext.fromJson(_json["sourceContext"]);
    }
    if (_json.containsKey("syntax")) {
      syntax = _json["syntax"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (methods != null) {
      _json["methods"] = methods.map((value) => (value).toJson()).toList();
    }
    if (mixins != null) {
      _json["mixins"] = mixins.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (options != null) {
      _json["options"] = options.map((value) => (value).toJson()).toList();
    }
    if (sourceContext != null) {
      _json["sourceContext"] = (sourceContext).toJson();
    }
    if (syntax != null) {
      _json["syntax"] = syntax;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

/**
 * Specifies the audit configuration for a service.
 * It consists of which permission types are logged, and what identities, if
 * any, are exempted from logging.
 * An AuditConifg must have one or more AuditLogConfigs.
 *
 * If there are AuditConfigs for both `allServices` and a specific service,
 * the union of the two AuditConfigs is used for that service: the log_types
 * specified in each AuditConfig are enabled, and the exempted_members in each
 * AuditConfig are exempted.
 * Example Policy with multiple AuditConfigs:
 * {
 *   "audit_configs": [
 *     {
 *       "service": "allServices"
 *       "audit_log_configs": [
 *         {
 *           "log_type": "DATA_READ",
 *           "exempted_members": [
 *             "user:foo@gmail.com"
 *           ]
 *         },
 *         {
 *           "log_type": "DATA_WRITE",
 *         },
 *         {
 *           "log_type": "ADMIN_READ",
 *         }
 *       ]
 *     },
 *     {
 *       "service": "fooservice@googleapis.com"
 *       "audit_log_configs": [
 *         {
 *           "log_type": "DATA_READ",
 *         },
 *         {
 *           "log_type": "DATA_WRITE",
 *           "exempted_members": [
 *             "user:bar@gmail.com"
 *           ]
 *         }
 *       ]
 *     }
 *   ]
 * }
 * For fooservice, this policy enables DATA_READ, DATA_WRITE and ADMIN_READ
 * logging. It also exempts foo@gmail.com from DATA_READ logging, and
 * bar@gmail.com from DATA_WRITE logging.
 */
class AuditConfig {
  /**
   * The configuration for logging of each type of permission.
   * Next ID: 4
   */
  core.List<AuditLogConfig> auditLogConfigs;
  core.List<core.String> exemptedMembers;
  /**
   * Specifies a service that will be enabled for audit logging.
   * For example, `resourcemanager`, `storage`, `compute`.
   * `allServices` is a special value that covers all services.
   */
  core.String service;

  AuditConfig();

  AuditConfig.fromJson(core.Map _json) {
    if (_json.containsKey("auditLogConfigs")) {
      auditLogConfigs = _json["auditLogConfigs"].map((value) => new AuditLogConfig.fromJson(value)).toList();
    }
    if (_json.containsKey("exemptedMembers")) {
      exemptedMembers = _json["exemptedMembers"];
    }
    if (_json.containsKey("service")) {
      service = _json["service"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (auditLogConfigs != null) {
      _json["auditLogConfigs"] = auditLogConfigs.map((value) => (value).toJson()).toList();
    }
    if (exemptedMembers != null) {
      _json["exemptedMembers"] = exemptedMembers;
    }
    if (service != null) {
      _json["service"] = service;
    }
    return _json;
  }
}

/**
 * Provides the configuration for logging a type of permissions.
 * Example:
 *
 *     {
 *       "audit_log_configs": [
 *         {
 *           "log_type": "DATA_READ",
 *           "exempted_members": [
 *             "user:foo@gmail.com"
 *           ]
 *         },
 *         {
 *           "log_type": "DATA_WRITE",
 *         }
 *       ]
 *     }
 *
 * This enables 'DATA_READ' and 'DATA_WRITE' logging, while exempting
 * foo@gmail.com from DATA_READ logging.
 */
class AuditLogConfig {
  /**
   * Specifies the identities that do not cause logging for this type of
   * permission.
   * Follows the same format of Binding.members.
   */
  core.List<core.String> exemptedMembers;
  /**
   * The log type that this config enables.
   * Possible string values are:
   * - "LOG_TYPE_UNSPECIFIED" : Default case. Should never be this.
   * - "ADMIN_READ" : Admin reads. Example: CloudIAM getIamPolicy
   * - "DATA_WRITE" : Data writes. Example: CloudSQL Users create
   * - "DATA_READ" : Data reads. Example: CloudSQL Users list
   */
  core.String logType;

  AuditLogConfig();

  AuditLogConfig.fromJson(core.Map _json) {
    if (_json.containsKey("exemptedMembers")) {
      exemptedMembers = _json["exemptedMembers"];
    }
    if (_json.containsKey("logType")) {
      logType = _json["logType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (exemptedMembers != null) {
      _json["exemptedMembers"] = exemptedMembers;
    }
    if (logType != null) {
      _json["logType"] = logType;
    }
    return _json;
  }
}

/**
 * Configuration for an anthentication provider, including support for
 * [JSON Web Token
 * (JWT)](https://tools.ietf.org/html/draft-ietf-oauth-json-web-token-32).
 */
class AuthProvider {
  /**
   * The list of JWT
   * [audiences](https://tools.ietf.org/html/draft-ietf-oauth-json-web-token-32#section-4.1.3).
   * that are allowed to access. A JWT containing any of these audiences will
   * be accepted. When this setting is absent, only JWTs with audience
   * "https://Service_name/API_name"
   * will be accepted. For example, if no audiences are in the setting,
   * LibraryService API will only accept JWTs with the following audience
   * "https://library-example.googleapis.com/google.example.library.v1.LibraryService".
   *
   * Example:
   *
   *     audiences: bookstore_android.apps.googleusercontent.com,
   *                bookstore_web.apps.googleusercontent.com
   */
  core.String audiences;
  /**
   * The unique identifier of the auth provider. It will be referred to by
   * `AuthRequirement.provider_id`.
   *
   * Example: "bookstore_auth".
   */
  core.String id;
  /**
   * Identifies the principal that issued the JWT. See
   * https://tools.ietf.org/html/draft-ietf-oauth-json-web-token-32#section-4.1.1
   * Usually a URL or an email address.
   *
   * Example: https://securetoken.google.com
   * Example: 1234567-compute@developer.gserviceaccount.com
   */
  core.String issuer;
  /**
   * URL of the provider's public key set to validate signature of the JWT. See
   * [OpenID
   * Discovery](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata).
   * Optional if the key set document:
   *  - can be retrieved from
   * [OpenID
   * Discovery](https://openid.net/specs/openid-connect-discovery-1_0.html
   *    of the issuer.
   * - can be inferred from the email domain of the issuer (e.g. a Google
   * service account).
   *
   * Example: https://www.googleapis.com/oauth2/v1/certs
   */
  core.String jwksUri;

  AuthProvider();

  AuthProvider.fromJson(core.Map _json) {
    if (_json.containsKey("audiences")) {
      audiences = _json["audiences"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("issuer")) {
      issuer = _json["issuer"];
    }
    if (_json.containsKey("jwksUri")) {
      jwksUri = _json["jwksUri"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (audiences != null) {
      _json["audiences"] = audiences;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (issuer != null) {
      _json["issuer"] = issuer;
    }
    if (jwksUri != null) {
      _json["jwksUri"] = jwksUri;
    }
    return _json;
  }
}

/**
 * User-defined authentication requirements, including support for
 * [JSON Web Token
 * (JWT)](https://tools.ietf.org/html/draft-ietf-oauth-json-web-token-32).
 */
class AuthRequirement {
  /**
   * NOTE: This will be deprecated soon, once AuthProvider.audiences is
   * implemented and accepted in all the runtime components.
   *
   * The list of JWT
   * [audiences](https://tools.ietf.org/html/draft-ietf-oauth-json-web-token-32#section-4.1.3).
   * that are allowed to access. A JWT containing any of these audiences will
   * be accepted. When this setting is absent, only JWTs with audience
   * "https://Service_name/API_name"
   * will be accepted. For example, if no audiences are in the setting,
   * LibraryService API will only accept JWTs with the following audience
   * "https://library-example.googleapis.com/google.example.library.v1.LibraryService".
   *
   * Example:
   *
   *     audiences: bookstore_android.apps.googleusercontent.com,
   *                bookstore_web.apps.googleusercontent.com
   */
  core.String audiences;
  /**
   * id from authentication provider.
   *
   * Example:
   *
   *     provider_id: bookstore_auth
   */
  core.String providerId;

  AuthRequirement();

  AuthRequirement.fromJson(core.Map _json) {
    if (_json.containsKey("audiences")) {
      audiences = _json["audiences"];
    }
    if (_json.containsKey("providerId")) {
      providerId = _json["providerId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (audiences != null) {
      _json["audiences"] = audiences;
    }
    if (providerId != null) {
      _json["providerId"] = providerId;
    }
    return _json;
  }
}

/**
 * `Authentication` defines the authentication configuration for an API.
 *
 * Example for an API targeted for external use:
 *
 *     name: calendar.googleapis.com
 *     authentication:
 *       providers:
 *       - id: google_calendar_auth
 *         jwks_uri: https://www.googleapis.com/oauth2/v1/certs
 *         issuer: https://securetoken.google.com
 *       rules:
 *       - selector: "*"
 *         requirements:
 *           provider_id: google_calendar_auth
 */
class Authentication {
  /** Defines a set of authentication providers that a service supports. */
  core.List<AuthProvider> providers;
  /**
   * A list of authentication rules that apply to individual API methods.
   *
   * **NOTE:** All service configuration rules follow "last one wins" order.
   */
  core.List<AuthenticationRule> rules;

  Authentication();

  Authentication.fromJson(core.Map _json) {
    if (_json.containsKey("providers")) {
      providers = _json["providers"].map((value) => new AuthProvider.fromJson(value)).toList();
    }
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new AuthenticationRule.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (providers != null) {
      _json["providers"] = providers.map((value) => (value).toJson()).toList();
    }
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Authentication rules for the service.
 *
 * By default, if a method has any authentication requirements, every request
 * must include a valid credential matching one of the requirements.
 * It's an error to include more than one kind of credential in a single
 * request.
 *
 * If a method doesn't have any auth requirements, request credentials will be
 * ignored.
 */
class AuthenticationRule {
  /**
   * Whether to allow requests without a credential. The credential can be
   * an OAuth token, Google cookies (first-party auth) or EndUserCreds.
   *
   * For requests without credentials, if the service control environment is
   * specified, each incoming request **must** be associated with a service
   * consumer. This can be done by passing an API key that belongs to a consumer
   * project.
   */
  core.bool allowWithoutCredential;
  /** The requirements for OAuth credentials. */
  OAuthRequirements oauth;
  /** Requirements for additional authentication providers. */
  core.List<AuthRequirement> requirements;
  /**
   * Selects the methods to which this rule applies.
   *
   * Refer to selector for syntax details.
   */
  core.String selector;

  AuthenticationRule();

  AuthenticationRule.fromJson(core.Map _json) {
    if (_json.containsKey("allowWithoutCredential")) {
      allowWithoutCredential = _json["allowWithoutCredential"];
    }
    if (_json.containsKey("oauth")) {
      oauth = new OAuthRequirements.fromJson(_json["oauth"]);
    }
    if (_json.containsKey("requirements")) {
      requirements = _json["requirements"].map((value) => new AuthRequirement.fromJson(value)).toList();
    }
    if (_json.containsKey("selector")) {
      selector = _json["selector"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowWithoutCredential != null) {
      _json["allowWithoutCredential"] = allowWithoutCredential;
    }
    if (oauth != null) {
      _json["oauth"] = (oauth).toJson();
    }
    if (requirements != null) {
      _json["requirements"] = requirements.map((value) => (value).toJson()).toList();
    }
    if (selector != null) {
      _json["selector"] = selector;
    }
    return _json;
  }
}

/**
 * Configuration of authorization.
 *
 * This section determines the authorization provider, if unspecified, then no
 * authorization check will be done.
 *
 * Example:
 *
 *     experimental:
 *       authorization:
 *         provider: firebaserules.googleapis.com
 */
class AuthorizationConfig {
  /**
   * The name of the authorization provider, such as
   * firebaserules.googleapis.com.
   */
  core.String provider;

  AuthorizationConfig();

  AuthorizationConfig.fromJson(core.Map _json) {
    if (_json.containsKey("provider")) {
      provider = _json["provider"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (provider != null) {
      _json["provider"] = provider;
    }
    return _json;
  }
}

/** `Backend` defines the backend configuration for a service. */
class Backend {
  /**
   * A list of API backend rules that apply to individual API methods.
   *
   * **NOTE:** All service configuration rules follow "last one wins" order.
   */
  core.List<BackendRule> rules;

  Backend();

  Backend.fromJson(core.Map _json) {
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new BackendRule.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A backend rule provides configuration for an individual API element. */
class BackendRule {
  /** The address of the API backend. */
  core.String address;
  /**
   * The number of seconds to wait for a response from a request.  The
   * default depends on the deployment context.
   */
  core.double deadline;
  /**
   * Selects the methods to which this rule applies.
   *
   * Refer to selector for syntax details.
   */
  core.String selector;

  BackendRule();

  BackendRule.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = _json["address"];
    }
    if (_json.containsKey("deadline")) {
      deadline = _json["deadline"];
    }
    if (_json.containsKey("selector")) {
      selector = _json["selector"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (address != null) {
      _json["address"] = address;
    }
    if (deadline != null) {
      _json["deadline"] = deadline;
    }
    if (selector != null) {
      _json["selector"] = selector;
    }
    return _json;
  }
}

/** Associates `members` with a `role`. */
class Binding {
  /**
   * Specifies the identities requesting access for a Cloud Platform resource.
   * `members` can have the following values:
   *
   * * `allUsers`: A special identifier that represents anyone who is
   *    on the internet; with or without a Google account.
   *
   * * `allAuthenticatedUsers`: A special identifier that represents anyone
   *    who is authenticated with a Google account or a service account.
   *
   * * `user:{emailid}`: An email address that represents a specific Google
   *    account. For example, `alice@gmail.com` or `joe@example.com`.
   *
   *
   * * `serviceAccount:{emailid}`: An email address that represents a service
   *    account. For example, `my-other-app@appspot.gserviceaccount.com`.
   *
   * * `group:{emailid}`: An email address that represents a Google group.
   *    For example, `admins@example.com`.
   *
   * * `domain:{domain}`: A Google Apps domain name that represents all the
   *    users of that domain. For example, `google.com` or `example.com`.
   */
  core.List<core.String> members;
  /**
   * Role that is assigned to `members`.
   * For example, `roles/viewer`, `roles/editor`, or `roles/owner`.
   * Required
   */
  core.String role;

  Binding();

  Binding.fromJson(core.Map _json) {
    if (_json.containsKey("members")) {
      members = _json["members"];
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (members != null) {
      _json["members"] = members;
    }
    if (role != null) {
      _json["role"] = role;
    }
    return _json;
  }
}

/**
 * Change report associated with a particular service configuration.
 *
 * It contains a list of ConfigChanges based on the comparison between
 * two service configurations.
 */
class ChangeReport {
  /**
   * List of changes between two service configurations.
   * The changes will be alphabetically sorted based on the identifier
   * of each change.
   * A ConfigChange identifier is a dot separated path to the configuration.
   * Example: visibility.rules[selector='LibraryService.CreateBook'].restriction
   */
  core.List<ConfigChange> configChanges;

  ChangeReport();

  ChangeReport.fromJson(core.Map _json) {
    if (_json.containsKey("configChanges")) {
      configChanges = _json["configChanges"].map((value) => new ConfigChange.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (configChanges != null) {
      _json["configChanges"] = configChanges.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Write a Cloud Audit log */
class CloudAuditOptions {

  CloudAuditOptions();

  CloudAuditOptions.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** A condition to be met. */
class Condition {
  /**
   * Trusted attributes supplied by the IAM system.
   * Possible string values are:
   * - "NO_ATTR" : Default non-attribute.
   * - "AUTHORITY" : Either principal or (if present) authority selector.
   * - "ATTRIBUTION" : The principal (even if an authority selector is present),
   * which
   * must only be used for attribution, not authorization.
   * - "APPROVER" : An approver (distinct from the requester) that has
   * authorized this
   * request.
   * When used with IN, the condition indicates that one of the approvers
   * associated with the request matches the specified principal, or is a
   * member of the specified group. Approvers can only grant additional
   * access, and are thus only used in a strictly positive context
   * (e.g. ALLOW/IN or DENY/NOT_IN).
   * See: go/rpc-security-policy-dynamicauth.
   * - "JUSTIFICATION_TYPE" : What types of justifications have been supplied
   * with this request.
   * String values should match enum names from tech.iam.JustificationType,
   * e.g. "MANUAL_STRING". It is not permitted to grant access based on
   * the *absence* of a justification, so justification conditions can only
   * be used in a "positive" context (e.g., ALLOW/IN or DENY/NOT_IN).
   *
   * Multiple justifications, e.g., a Buganizer ID and a manually-entered
   * reason, are normal and supported.
   */
  core.String iam;
  /**
   * An operator to apply the subject with.
   * Possible string values are:
   * - "NO_OP" : Default no-op.
   * - "EQUALS" : DEPRECATED. Use IN instead.
   * - "NOT_EQUALS" : DEPRECATED. Use NOT_IN instead.
   * - "IN" : The condition is true if the subject (or any element of it if it
   * is
   * a set) matches any of the supplied values.
   * - "NOT_IN" : The condition is true if the subject (or every element of it
   * if it is
   * a set) matches none of the supplied values.
   * - "DISCHARGED" : Subject is discharged
   */
  core.String op;
  /** Trusted attributes discharged by the service. */
  core.String svc;
  /**
   * Trusted attributes supplied by any service that owns resources and uses
   * the IAM system for access control.
   * Possible string values are:
   * - "NO_ATTR" : Default non-attribute type
   * - "REGION" : Region of the resource
   * - "SERVICE" : Service name
   * - "NAME" : Resource name
   * - "IP" : IP address of the caller
   */
  core.String sys;
  /** DEPRECATED. Use 'values' instead. */
  core.String value;
  /** The objects of the condition. This is mutually exclusive with 'value'. */
  core.List<core.String> values;

  Condition();

  Condition.fromJson(core.Map _json) {
    if (_json.containsKey("iam")) {
      iam = _json["iam"];
    }
    if (_json.containsKey("op")) {
      op = _json["op"];
    }
    if (_json.containsKey("svc")) {
      svc = _json["svc"];
    }
    if (_json.containsKey("sys")) {
      sys = _json["sys"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
    if (_json.containsKey("values")) {
      values = _json["values"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (iam != null) {
      _json["iam"] = iam;
    }
    if (op != null) {
      _json["op"] = op;
    }
    if (svc != null) {
      _json["svc"] = svc;
    }
    if (sys != null) {
      _json["sys"] = sys;
    }
    if (value != null) {
      _json["value"] = value;
    }
    if (values != null) {
      _json["values"] = values;
    }
    return _json;
  }
}

/**
 * Output generated from semantically comparing two versions of a service
 * configuration.
 *
 * Includes detailed information about a field that have changed with
 * applicable advice about potential consequences for the change, such as
 * backwards-incompatibility.
 */
class ConfigChange {
  /**
   * Collection of advice provided for this change, useful for determining the
   * possible impact of this change.
   */
  core.List<Advice> advices;
  /**
   * The type for this change, either ADDED, REMOVED, or MODIFIED.
   * Possible string values are:
   * - "CHANGE_TYPE_UNSPECIFIED" : No value was provided.
   * - "ADDED" : The changed object exists in the 'new' service configuration,
   * but not
   * in the 'old' service configuration.
   * - "REMOVED" : The changed object exists in the 'old' service configuration,
   * but not
   * in the 'new' service configuration.
   * - "MODIFIED" : The changed object exists in both service configurations,
   * but its value
   * is different.
   */
  core.String changeType;
  /**
   * Object hierarchy path to the change, with levels separated by a '.'
   * character. For repeated fields, an applicable unique identifier field is
   * used for the index (usually selector, name, or id). For maps, the term
   * 'key' is used. If the field has no unique identifier, the numeric index
   * is used.
   * Examples:
   * -
   * visibility.rules[selector=="google.LibraryService.CreateBook"].restriction
   * - quota.metric_rules[selector=="google"].metric_costs[key=="reads"].value
   * - logging.producer_destinations[0]
   */
  core.String element;
  /**
   * Value of the changed object in the new Service configuration,
   * in JSON format. This field will not be populated if ChangeType == REMOVED.
   */
  core.String newValue;
  /**
   * Value of the changed object in the old Service configuration,
   * in JSON format. This field will not be populated if ChangeType == ADDED.
   */
  core.String oldValue;

  ConfigChange();

  ConfigChange.fromJson(core.Map _json) {
    if (_json.containsKey("advices")) {
      advices = _json["advices"].map((value) => new Advice.fromJson(value)).toList();
    }
    if (_json.containsKey("changeType")) {
      changeType = _json["changeType"];
    }
    if (_json.containsKey("element")) {
      element = _json["element"];
    }
    if (_json.containsKey("newValue")) {
      newValue = _json["newValue"];
    }
    if (_json.containsKey("oldValue")) {
      oldValue = _json["oldValue"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (advices != null) {
      _json["advices"] = advices.map((value) => (value).toJson()).toList();
    }
    if (changeType != null) {
      _json["changeType"] = changeType;
    }
    if (element != null) {
      _json["element"] = element;
    }
    if (newValue != null) {
      _json["newValue"] = newValue;
    }
    if (oldValue != null) {
      _json["oldValue"] = oldValue;
    }
    return _json;
  }
}

/** Generic specification of a source configuration file */
class ConfigFile {
  /** The bytes that constitute the file. */
  core.String fileContents;
  core.List<core.int> get fileContentsAsBytes {
    return convert.BASE64.decode(fileContents);
  }

  void set fileContentsAsBytes(core.List<core.int> _bytes) {
    fileContents = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** The file name of the configuration file (full or relative path). */
  core.String filePath;
  /**
   * The type of configuration file this represents.
   * Possible string values are:
   * - "FILE_TYPE_UNSPECIFIED" : Unknown file type.
   * - "SERVICE_CONFIG_YAML" : YAML-specification of service.
   * - "OPEN_API_JSON" : OpenAPI specification, serialized in JSON.
   * - "OPEN_API_YAML" : OpenAPI specification, serialized in YAML.
   * - "FILE_DESCRIPTOR_SET_PROTO" : FileDescriptorSet, generated by protoc.
   *
   * To generate, use protoc with imports and source info included.
   * For an example test.proto file, the following command would put the value
   * in a new file named out.pb.
   *
   * $protoc --include_imports --include_source_info test.proto -o out.pb
   */
  core.String fileType;

  ConfigFile();

  ConfigFile.fromJson(core.Map _json) {
    if (_json.containsKey("fileContents")) {
      fileContents = _json["fileContents"];
    }
    if (_json.containsKey("filePath")) {
      filePath = _json["filePath"];
    }
    if (_json.containsKey("fileType")) {
      fileType = _json["fileType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fileContents != null) {
      _json["fileContents"] = fileContents;
    }
    if (filePath != null) {
      _json["filePath"] = filePath;
    }
    if (fileType != null) {
      _json["fileType"] = fileType;
    }
    return _json;
  }
}

/** Represents a service configuration with its name and id. */
class ConfigRef {
  /**
   * Resource name of a service config. It must have the following
   * format: "services/{service name}/configs/{config id}".
   */
  core.String name;

  ConfigRef();

  ConfigRef.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/**
 * Represents a source file which is used to generate the service configuration
 * defined by `google.api.Service`.
 */
class ConfigSource {
  /**
   * Set of source configuration files that are used to generate a service
   * configuration (`google.api.Service`).
   */
  core.List<ConfigFile> files;
  /**
   * A unique ID for a specific instance of this message, typically assigned
   * by the client for tracking purpose. If empty, the server may choose to
   * generate one instead.
   */
  core.String id;

  ConfigSource();

  ConfigSource.fromJson(core.Map _json) {
    if (_json.containsKey("files")) {
      files = _json["files"].map((value) => new ConfigFile.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
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
    return _json;
  }
}

/**
 * `Context` defines which contexts an API requests.
 *
 * Example:
 *
 *     context:
 *       rules:
 *       - selector: "*"
 *         requested:
 *         - google.rpc.context.ProjectContext
 *         - google.rpc.context.OriginContext
 *
 * The above specifies that all methods in the API request
 * `google.rpc.context.ProjectContext` and
 * `google.rpc.context.OriginContext`.
 *
 * Available context types are defined in package
 * `google.rpc.context`.
 */
class Context {
  /**
   * A list of RPC context rules that apply to individual API methods.
   *
   * **NOTE:** All service configuration rules follow "last one wins" order.
   */
  core.List<ContextRule> rules;

  Context();

  Context.fromJson(core.Map _json) {
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new ContextRule.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * A context rule provides information about the context for an individual API
 * element.
 */
class ContextRule {
  /** A list of full type names of provided contexts. */
  core.List<core.String> provided;
  /** A list of full type names of requested contexts. */
  core.List<core.String> requested;
  /**
   * Selects the methods to which this rule applies.
   *
   * Refer to selector for syntax details.
   */
  core.String selector;

  ContextRule();

  ContextRule.fromJson(core.Map _json) {
    if (_json.containsKey("provided")) {
      provided = _json["provided"];
    }
    if (_json.containsKey("requested")) {
      requested = _json["requested"];
    }
    if (_json.containsKey("selector")) {
      selector = _json["selector"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (provided != null) {
      _json["provided"] = provided;
    }
    if (requested != null) {
      _json["requested"] = requested;
    }
    if (selector != null) {
      _json["selector"] = selector;
    }
    return _json;
  }
}

/**
 * Selects and configures the service controller used by the service.  The
 * service controller handles features like abuse, quota, billing, logging,
 * monitoring, etc.
 */
class Control {
  /**
   * The service control environment to use. If empty, no control plane
   * feature (like quota and billing) will be enabled.
   */
  core.String environment;

  Control();

  Control.fromJson(core.Map _json) {
    if (_json.containsKey("environment")) {
      environment = _json["environment"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (environment != null) {
      _json["environment"] = environment;
    }
    return _json;
  }
}

/** Options for counters */
class CounterOptions {
  /** The field value to attribute. */
  core.String field;
  /** The metric to update. */
  core.String metric;

  CounterOptions();

  CounterOptions.fromJson(core.Map _json) {
    if (_json.containsKey("field")) {
      field = _json["field"];
    }
    if (_json.containsKey("metric")) {
      metric = _json["metric"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (field != null) {
      _json["field"] = field;
    }
    if (metric != null) {
      _json["metric"] = metric;
    }
    return _json;
  }
}

/**
 * Customize service error responses.  For example, list any service
 * specific protobuf types that can appear in error detail lists of
 * error responses.
 *
 * Example:
 *
 *     custom_error:
 *       types:
 *       - google.foo.v1.CustomError
 *       - google.foo.v1.AnotherError
 */
class CustomError {
  /**
   * The list of custom error rules that apply to individual API messages.
   *
   * **NOTE:** All service configuration rules follow "last one wins" order.
   */
  core.List<CustomErrorRule> rules;
  /**
   * The list of custom error detail types, e.g. 'google.foo.v1.CustomError'.
   */
  core.List<core.String> types;

  CustomError();

  CustomError.fromJson(core.Map _json) {
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new CustomErrorRule.fromJson(value)).toList();
    }
    if (_json.containsKey("types")) {
      types = _json["types"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    if (types != null) {
      _json["types"] = types;
    }
    return _json;
  }
}

/** A custom error rule. */
class CustomErrorRule {
  /**
   * Mark this message as possible payload in error response.  Otherwise,
   * objects of this type will be filtered when they appear in error payload.
   */
  core.bool isErrorType;
  /**
   * Selects messages to which this rule applies.
   *
   * Refer to selector for syntax details.
   */
  core.String selector;

  CustomErrorRule();

  CustomErrorRule.fromJson(core.Map _json) {
    if (_json.containsKey("isErrorType")) {
      isErrorType = _json["isErrorType"];
    }
    if (_json.containsKey("selector")) {
      selector = _json["selector"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (isErrorType != null) {
      _json["isErrorType"] = isErrorType;
    }
    if (selector != null) {
      _json["selector"] = selector;
    }
    return _json;
  }
}

/** A custom pattern is used for defining custom HTTP verb. */
class CustomHttpPattern {
  /** The name of this custom HTTP verb. */
  core.String kind;
  /** The path matched by this custom verb. */
  core.String path;

  CustomHttpPattern();

  CustomHttpPattern.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("path")) {
      path = _json["path"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (path != null) {
      _json["path"] = path;
    }
    return _json;
  }
}

/** Write a Data Access (Gin) log */
class DataAccessOptions {

  DataAccessOptions();

  DataAccessOptions.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/**
 * Strategy used to delete a service. This strategy is a placeholder only
 * used by the system generated rollout to delete a service.
 */
class DeleteServiceStrategy {

  DeleteServiceStrategy();

  DeleteServiceStrategy.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** Represents a diagnostic message (error or warning) */
class Diagnostic {
  /**
   * The kind of diagnostic information provided.
   * Possible string values are:
   * - "WARNING" : Warnings and errors
   * - "ERROR" : Only errors
   */
  core.String kind;
  /** File name and line number of the error or warning. */
  core.String location;
  /** Message describing the error or warning. */
  core.String message;

  Diagnostic();

  Diagnostic.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

/** Request message for DisableService method. */
class DisableServiceRequest {
  /**
   * The identity of consumer resource which service disablement will be
   * applied to.
   *
   * The Google Service Management implementation accepts the following
   * forms:
   * - "project:<project_id>"
   *
   * Note: this is made compatible with
   * google.api.servicecontrol.v1.Operation.consumer_id.
   */
  core.String consumerId;

  DisableServiceRequest();

  DisableServiceRequest.fromJson(core.Map _json) {
    if (_json.containsKey("consumerId")) {
      consumerId = _json["consumerId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (consumerId != null) {
      _json["consumerId"] = consumerId;
    }
    return _json;
  }
}

/**
 * `Documentation` provides the information for describing a service.
 *
 * Example:
 * <pre><code>documentation:
 *   summary: >
 *     The Google Calendar API gives access
 *     to most calendar features.
 *   pages:
 *   - name: Overview
 *     content: &#40;== include google/foo/overview.md ==&#41;
 *   - name: Tutorial
 *     content: &#40;== include google/foo/tutorial.md ==&#41;
 *     subpages;
 *     - name: Java
 *       content: &#40;== include google/foo/tutorial_java.md ==&#41;
 *   rules:
 *   - selector: google.calendar.Calendar.Get
 *     description: >
 *       ...
 *   - selector: google.calendar.Calendar.Put
 *     description: >
 *       ...
 * </code></pre>
 * Documentation is provided in markdown syntax. In addition to
 * standard markdown features, definition lists, tables and fenced
 * code blocks are supported. Section headers can be provided and are
 * interpreted relative to the section nesting of the context where
 * a documentation fragment is embedded.
 *
 * Documentation from the IDL is merged with documentation defined
 * via the config at normalization time, where documentation provided
 * by config rules overrides IDL provided.
 *
 * A number of constructs specific to the API platform are supported
 * in documentation text.
 *
 * In order to reference a proto element, the following
 * notation can be used:
 * <pre><code>&#91;fully.qualified.proto.name]&#91;]</code></pre>
 * To override the display text used for the link, this can be used:
 * <pre><code>&#91;display text]&#91;fully.qualified.proto.name]</code></pre>
 * Text can be excluded from doc using the following notation:
 * <pre><code>&#40;-- internal comment --&#41;</code></pre>
 * Comments can be made conditional using a visibility label. The below
 * text will be only rendered if the `BETA` label is available:
 * <pre><code>&#40;--BETA: comment for BETA users --&#41;</code></pre>
 * A few directives are available in documentation. Note that
 * directives must appear on a single line to be properly
 * identified. The `include` directive includes a markdown file from
 * an external source:
 * <pre><code>&#40;== include path/to/file ==&#41;</code></pre>
 * The `resource_for` directive marks a message to be the resource of
 * a collection in REST view. If it is not specified, tools attempt
 * to infer the resource from the operations in a collection:
 * <pre><code>&#40;== resource_for v1.shelves.books ==&#41;</code></pre>
 * The directive `suppress_warning` does not directly affect documentation
 * and is documented together with service config validation.
 */
class Documentation {
  /** The URL to the root of documentation. */
  core.String documentationRootUrl;
  /**
   * Declares a single overview page. For example:
   * <pre><code>documentation:
   *   summary: ...
   *   overview: &#40;== include overview.md ==&#41;
   * </code></pre>
   * This is a shortcut for the following declaration (using pages style):
   * <pre><code>documentation:
   *   summary: ...
   *   pages:
   *   - name: Overview
   *     content: &#40;== include overview.md ==&#41;
   * </code></pre>
   * Note: you cannot specify both `overview` field and `pages` field.
   */
  core.String overview;
  /** The top level pages for the documentation set. */
  core.List<Page> pages;
  /**
   * A list of documentation rules that apply to individual API elements.
   *
   * **NOTE:** All service configuration rules follow "last one wins" order.
   */
  core.List<DocumentationRule> rules;
  /**
   * A short summary of what the service does. Can only be provided by
   * plain text.
   */
  core.String summary;

  Documentation();

  Documentation.fromJson(core.Map _json) {
    if (_json.containsKey("documentationRootUrl")) {
      documentationRootUrl = _json["documentationRootUrl"];
    }
    if (_json.containsKey("overview")) {
      overview = _json["overview"];
    }
    if (_json.containsKey("pages")) {
      pages = _json["pages"].map((value) => new Page.fromJson(value)).toList();
    }
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new DocumentationRule.fromJson(value)).toList();
    }
    if (_json.containsKey("summary")) {
      summary = _json["summary"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (documentationRootUrl != null) {
      _json["documentationRootUrl"] = documentationRootUrl;
    }
    if (overview != null) {
      _json["overview"] = overview;
    }
    if (pages != null) {
      _json["pages"] = pages.map((value) => (value).toJson()).toList();
    }
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    if (summary != null) {
      _json["summary"] = summary;
    }
    return _json;
  }
}

/** A documentation rule provides information about individual API elements. */
class DocumentationRule {
  /**
   * Deprecation description of the selected element(s). It can be provided if
   * an
   * element is marked as `deprecated`.
   */
  core.String deprecationDescription;
  /** Description of the selected API(s). */
  core.String description;
  /**
   * The selector is a comma-separated list of patterns. Each pattern is a
   * qualified name of the element which may end in "*", indicating a wildcard.
   * Wildcards are only allowed at the end and for a whole component of the
   * qualified name, i.e. "foo.*" is ok, but not "foo.b*" or "foo.*.bar". To
   * specify a default for all applicable elements, the whole pattern "*"
   * is used.
   */
  core.String selector;

  DocumentationRule();

  DocumentationRule.fromJson(core.Map _json) {
    if (_json.containsKey("deprecationDescription")) {
      deprecationDescription = _json["deprecationDescription"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("selector")) {
      selector = _json["selector"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deprecationDescription != null) {
      _json["deprecationDescription"] = deprecationDescription;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (selector != null) {
      _json["selector"] = selector;
    }
    return _json;
  }
}

/** Request message for EnableService method. */
class EnableServiceRequest {
  /**
   * The identity of consumer resource which service enablement will be
   * applied to.
   *
   * The Google Service Management implementation accepts the following
   * forms:
   * - "project:<project_id>"
   *
   * Note: this is made compatible with
   * google.api.servicecontrol.v1.Operation.consumer_id.
   */
  core.String consumerId;

  EnableServiceRequest();

  EnableServiceRequest.fromJson(core.Map _json) {
    if (_json.containsKey("consumerId")) {
      consumerId = _json["consumerId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (consumerId != null) {
      _json["consumerId"] = consumerId;
    }
    return _json;
  }
}

/**
 * `Endpoint` describes a network endpoint that serves a set of APIs.
 * A service may expose any number of endpoints, and all endpoints share the
 * same service configuration, such as quota configuration and monitoring
 * configuration.
 *
 * Example service configuration:
 *
 *     name: library-example.googleapis.com
 *     endpoints:
 *       # Below entry makes 'google.example.library.v1.Library'
 *       # API be served from endpoint address library-example.googleapis.com.
 *       # It also allows HTTP OPTIONS calls to be passed to the backend, for
 *       # it to decide whether the subsequent cross-origin request is
 *       # allowed to proceed.
 *     - name: library-example.googleapis.com
 *       allow_cors: true
 */
class Endpoint {
  /**
   * DEPRECATED: This field is no longer supported. Instead of using aliases,
   * please specify multiple google.api.Endpoint for each of the intented
   * alias.
   *
   * Additional names that this endpoint will be hosted on.
   */
  core.List<core.String> aliases;
  /**
   * Allowing
   * [CORS](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing), aka
   * cross-domain traffic, would allow the backends served from this endpoint to
   * receive and respond to HTTP OPTIONS requests. The response will be used by
   * the browser to determine whether the subsequent cross-origin request is
   * allowed to proceed.
   */
  core.bool allowCors;
  /** The list of APIs served by this endpoint. */
  core.List<core.String> apis;
  /** The list of features enabled on this endpoint. */
  core.List<core.String> features;
  /** The canonical name of this endpoint. */
  core.String name;

  Endpoint();

  Endpoint.fromJson(core.Map _json) {
    if (_json.containsKey("aliases")) {
      aliases = _json["aliases"];
    }
    if (_json.containsKey("allowCors")) {
      allowCors = _json["allowCors"];
    }
    if (_json.containsKey("apis")) {
      apis = _json["apis"];
    }
    if (_json.containsKey("features")) {
      features = _json["features"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aliases != null) {
      _json["aliases"] = aliases;
    }
    if (allowCors != null) {
      _json["allowCors"] = allowCors;
    }
    if (apis != null) {
      _json["apis"] = apis;
    }
    if (features != null) {
      _json["features"] = features;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Enum type definition. */
class Enum {
  /** Enum value definitions. */
  core.List<EnumValue> enumvalue;
  /** Enum type name. */
  core.String name;
  /** Protocol buffer options. */
  core.List<Option> options;
  /** The source context. */
  SourceContext sourceContext;
  /**
   * The source syntax.
   * Possible string values are:
   * - "SYNTAX_PROTO2" : Syntax `proto2`.
   * - "SYNTAX_PROTO3" : Syntax `proto3`.
   */
  core.String syntax;

  Enum();

  Enum.fromJson(core.Map _json) {
    if (_json.containsKey("enumvalue")) {
      enumvalue = _json["enumvalue"].map((value) => new EnumValue.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("options")) {
      options = _json["options"].map((value) => new Option.fromJson(value)).toList();
    }
    if (_json.containsKey("sourceContext")) {
      sourceContext = new SourceContext.fromJson(_json["sourceContext"]);
    }
    if (_json.containsKey("syntax")) {
      syntax = _json["syntax"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (enumvalue != null) {
      _json["enumvalue"] = enumvalue.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (options != null) {
      _json["options"] = options.map((value) => (value).toJson()).toList();
    }
    if (sourceContext != null) {
      _json["sourceContext"] = (sourceContext).toJson();
    }
    if (syntax != null) {
      _json["syntax"] = syntax;
    }
    return _json;
  }
}

/** Enum value definition. */
class EnumValue {
  /** Enum value name. */
  core.String name;
  /** Enum value number. */
  core.int number;
  /** Protocol buffer options. */
  core.List<Option> options;

  EnumValue();

  EnumValue.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("number")) {
      number = _json["number"];
    }
    if (_json.containsKey("options")) {
      options = _json["options"].map((value) => new Option.fromJson(value)).toList();
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
    if (options != null) {
      _json["options"] = options.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Experimental service configuration. These configuration options can
 * only be used by whitelisted users.
 */
class Experimental {
  /** Authorization configuration. */
  AuthorizationConfig authorization;

  Experimental();

  Experimental.fromJson(core.Map _json) {
    if (_json.containsKey("authorization")) {
      authorization = new AuthorizationConfig.fromJson(_json["authorization"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (authorization != null) {
      _json["authorization"] = (authorization).toJson();
    }
    return _json;
  }
}

/** A single field of a message type. */
class Field {
  /**
   * The field cardinality.
   * Possible string values are:
   * - "CARDINALITY_UNKNOWN" : For fields with unknown cardinality.
   * - "CARDINALITY_OPTIONAL" : For optional fields.
   * - "CARDINALITY_REQUIRED" : For required fields. Proto2 syntax only.
   * - "CARDINALITY_REPEATED" : For repeated fields.
   */
  core.String cardinality;
  /**
   * The string value of the default value of this field. Proto2 syntax only.
   */
  core.String defaultValue;
  /** The field JSON name. */
  core.String jsonName;
  /**
   * The field type.
   * Possible string values are:
   * - "TYPE_UNKNOWN" : Field type unknown.
   * - "TYPE_DOUBLE" : Field type double.
   * - "TYPE_FLOAT" : Field type float.
   * - "TYPE_INT64" : Field type int64.
   * - "TYPE_UINT64" : Field type uint64.
   * - "TYPE_INT32" : Field type int32.
   * - "TYPE_FIXED64" : Field type fixed64.
   * - "TYPE_FIXED32" : Field type fixed32.
   * - "TYPE_BOOL" : Field type bool.
   * - "TYPE_STRING" : Field type string.
   * - "TYPE_GROUP" : Field type group. Proto2 syntax only, and deprecated.
   * - "TYPE_MESSAGE" : Field type message.
   * - "TYPE_BYTES" : Field type bytes.
   * - "TYPE_UINT32" : Field type uint32.
   * - "TYPE_ENUM" : Field type enum.
   * - "TYPE_SFIXED32" : Field type sfixed32.
   * - "TYPE_SFIXED64" : Field type sfixed64.
   * - "TYPE_SINT32" : Field type sint32.
   * - "TYPE_SINT64" : Field type sint64.
   */
  core.String kind;
  /** The field name. */
  core.String name;
  /** The field number. */
  core.int number;
  /**
   * The index of the field type in `Type.oneofs`, for message or enumeration
   * types. The first type has index 1; zero means the type is not in the list.
   */
  core.int oneofIndex;
  /** The protocol buffer options. */
  core.List<Option> options;
  /** Whether to use alternative packed wire representation. */
  core.bool packed;
  /**
   * The field type URL, without the scheme, for message or enumeration
   * types. Example: `"type.googleapis.com/google.protobuf.Timestamp"`.
   */
  core.String typeUrl;

  Field();

  Field.fromJson(core.Map _json) {
    if (_json.containsKey("cardinality")) {
      cardinality = _json["cardinality"];
    }
    if (_json.containsKey("defaultValue")) {
      defaultValue = _json["defaultValue"];
    }
    if (_json.containsKey("jsonName")) {
      jsonName = _json["jsonName"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("number")) {
      number = _json["number"];
    }
    if (_json.containsKey("oneofIndex")) {
      oneofIndex = _json["oneofIndex"];
    }
    if (_json.containsKey("options")) {
      options = _json["options"].map((value) => new Option.fromJson(value)).toList();
    }
    if (_json.containsKey("packed")) {
      packed = _json["packed"];
    }
    if (_json.containsKey("typeUrl")) {
      typeUrl = _json["typeUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cardinality != null) {
      _json["cardinality"] = cardinality;
    }
    if (defaultValue != null) {
      _json["defaultValue"] = defaultValue;
    }
    if (jsonName != null) {
      _json["jsonName"] = jsonName;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (number != null) {
      _json["number"] = number;
    }
    if (oneofIndex != null) {
      _json["oneofIndex"] = oneofIndex;
    }
    if (options != null) {
      _json["options"] = options.map((value) => (value).toJson()).toList();
    }
    if (packed != null) {
      _json["packed"] = packed;
    }
    if (typeUrl != null) {
      _json["typeUrl"] = typeUrl;
    }
    return _json;
  }
}

/** Request message for GenerateConfigReport method. */
class GenerateConfigReportRequest {
  /**
   * Service configuration for which we want to generate the report.
   * For this version of API, the supported types are
   * google.api.servicemanagement.v1.ConfigRef,
   * google.api.servicemanagement.v1.ConfigSource,
   * and google.api.Service
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> newConfig;
  /**
   * Service configuration against which the comparison will be done.
   * For this version of API, the supported types are
   * google.api.servicemanagement.v1.ConfigRef,
   * google.api.servicemanagement.v1.ConfigSource,
   * and google.api.Service
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> oldConfig;

  GenerateConfigReportRequest();

  GenerateConfigReportRequest.fromJson(core.Map _json) {
    if (_json.containsKey("newConfig")) {
      newConfig = _json["newConfig"];
    }
    if (_json.containsKey("oldConfig")) {
      oldConfig = _json["oldConfig"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (newConfig != null) {
      _json["newConfig"] = newConfig;
    }
    if (oldConfig != null) {
      _json["oldConfig"] = oldConfig;
    }
    return _json;
  }
}

/** Response message for GenerateConfigReport method. */
class GenerateConfigReportResponse {
  /**
   * list of ChangeReport, each corresponding to comparison between two
   * service configurations.
   */
  core.List<ChangeReport> changeReports;
  /**
   * Errors / Linter warnings associated with the service definition this
   * report
   * belongs to.
   */
  core.List<Diagnostic> diagnostics;
  /** ID of the service configuration this report belongs to. */
  core.String id;
  /** Name of the service this report belongs to. */
  core.String serviceName;

  GenerateConfigReportResponse();

  GenerateConfigReportResponse.fromJson(core.Map _json) {
    if (_json.containsKey("changeReports")) {
      changeReports = _json["changeReports"].map((value) => new ChangeReport.fromJson(value)).toList();
    }
    if (_json.containsKey("diagnostics")) {
      diagnostics = _json["diagnostics"].map((value) => new Diagnostic.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("serviceName")) {
      serviceName = _json["serviceName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (changeReports != null) {
      _json["changeReports"] = changeReports.map((value) => (value).toJson()).toList();
    }
    if (diagnostics != null) {
      _json["diagnostics"] = diagnostics.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (serviceName != null) {
      _json["serviceName"] = serviceName;
    }
    return _json;
  }
}

/** Request message for `GetIamPolicy` method. */
class GetIamPolicyRequest {

  GetIamPolicyRequest();

  GetIamPolicyRequest.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/**
 * Defines the HTTP configuration for a service. It contains a list of
 * HttpRule, each specifying the mapping of an RPC method
 * to one or more HTTP REST API methods.
 */
class Http {
  /**
   * A list of HTTP configuration rules that apply to individual API methods.
   *
   * **NOTE:** All service configuration rules follow "last one wins" order.
   */
  core.List<HttpRule> rules;

  Http();

  Http.fromJson(core.Map _json) {
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new HttpRule.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * `HttpRule` defines the mapping of an RPC method to one or more HTTP
 * REST APIs.  The mapping determines what portions of the request
 * message are populated from the path, query parameters, or body of
 * the HTTP request.  The mapping is typically specified as an
 * `google.api.http` annotation, see "google/api/annotations.proto"
 * for details.
 *
 * The mapping consists of a field specifying the path template and
 * method kind.  The path template can refer to fields in the request
 * message, as in the example below which describes a REST GET
 * operation on a resource collection of messages:
 *
 *
 *     service Messaging {
 *       rpc GetMessage(GetMessageRequest) returns (Message) {
 * option (google.api.http).get = "/v1/messages/{message_id}/{sub.subfield}";
 *       }
 *     }
 *     message GetMessageRequest {
 *       message SubMessage {
 *         string subfield = 1;
 *       }
 *       string message_id = 1; // mapped to the URL
 *       SubMessage sub = 2;    // `sub.subfield` is url-mapped
 *     }
 *     message Message {
 *       string text = 1; // content of the resource
 *     }
 *
 * The same http annotation can alternatively be expressed inside the
 * `GRPC API Configuration` YAML file.
 *
 *     http:
 *       rules:
 *         - selector: <proto_package_name>.Messaging.GetMessage
 *           get: /v1/messages/{message_id}/{sub.subfield}
 *
 * This definition enables an automatic, bidrectional mapping of HTTP
 * JSON to RPC. Example:
 *
 * HTTP | RPC
 * -----|-----
 * `GET /v1/messages/123456/foo`  | `GetMessage(message_id: "123456" sub:
 * SubMessage(subfield: "foo"))`
 *
 * In general, not only fields but also field paths can be referenced
 * from a path pattern. Fields mapped to the path pattern cannot be
 * repeated and must have a primitive (non-message) type.
 *
 * Any fields in the request message which are not bound by the path
 * pattern automatically become (optional) HTTP query
 * parameters. Assume the following definition of the request message:
 *
 *
 *     message GetMessageRequest {
 *       message SubMessage {
 *         string subfield = 1;
 *       }
 *       string message_id = 1; // mapped to the URL
 *       int64 revision = 2;    // becomes a parameter
 *       SubMessage sub = 3;    // `sub.subfield` becomes a parameter
 *     }
 *
 *
 * This enables a HTTP JSON to RPC mapping as below:
 *
 * HTTP | RPC
 * -----|-----
 * `GET /v1/messages/123456?revision=2&sub.subfield=foo` |
 * `GetMessage(message_id: "123456" revision: 2 sub: SubMessage(subfield:
 * "foo"))`
 *
 * Note that fields which are mapped to HTTP parameters must have a
 * primitive type or a repeated primitive type. Message types are not
 * allowed. In the case of a repeated type, the parameter can be
 * repeated in the URL, as in `...?param=A&param=B`.
 *
 * For HTTP method kinds which allow a request body, the `body` field
 * specifies the mapping. Consider a REST update method on the
 * message resource collection:
 *
 *
 *     service Messaging {
 *       rpc UpdateMessage(UpdateMessageRequest) returns (Message) {
 *         option (google.api.http) = {
 *           put: "/v1/messages/{message_id}"
 *           body: "message"
 *         };
 *       }
 *     }
 *     message UpdateMessageRequest {
 *       string message_id = 1; // mapped to the URL
 *       Message message = 2;   // mapped to the body
 *     }
 *
 *
 * The following HTTP JSON to RPC mapping is enabled, where the
 * representation of the JSON in the request body is determined by
 * protos JSON encoding:
 *
 * HTTP | RPC
 * -----|-----
 * `PUT /v1/messages/123456 { "text": "Hi!" }` | `UpdateMessage(message_id:
 * "123456" message { text: "Hi!" })`
 *
 * The special name `*` can be used in the body mapping to define that
 * every field not bound by the path template should be mapped to the
 * request body.  This enables the following alternative definition of
 * the update method:
 *
 *     service Messaging {
 *       rpc UpdateMessage(Message) returns (Message) {
 *         option (google.api.http) = {
 *           put: "/v1/messages/{message_id}"
 *           body: "*"
 *         };
 *       }
 *     }
 *     message Message {
 *       string message_id = 1;
 *       string text = 2;
 *     }
 *
 *
 * The following HTTP JSON to RPC mapping is enabled:
 *
 * HTTP | RPC
 * -----|-----
 * `PUT /v1/messages/123456 { "text": "Hi!" }` | `UpdateMessage(message_id:
 * "123456" text: "Hi!")`
 *
 * Note that when using `*` in the body mapping, it is not possible to
 * have HTTP parameters, as all fields not bound by the path end in
 * the body. This makes this option more rarely used in practice of
 * defining REST APIs. The common usage of `*` is in custom methods
 * which don't use the URL at all for transferring data.
 *
 * It is possible to define multiple HTTP methods for one RPC by using
 * the `additional_bindings` option. Example:
 *
 *     service Messaging {
 *       rpc GetMessage(GetMessageRequest) returns (Message) {
 *         option (google.api.http) = {
 *           get: "/v1/messages/{message_id}"
 *           additional_bindings {
 *             get: "/v1/users/{user_id}/messages/{message_id}"
 *           }
 *         };
 *       }
 *     }
 *     message GetMessageRequest {
 *       string message_id = 1;
 *       string user_id = 2;
 *     }
 *
 *
 * This enables the following two alternative HTTP JSON to RPC
 * mappings:
 *
 * HTTP | RPC
 * -----|-----
 * `GET /v1/messages/123456` | `GetMessage(message_id: "123456")`
 * `GET /v1/users/me/messages/123456` | `GetMessage(user_id: "me" message_id:
 * "123456")`
 *
 * # Rules for HTTP mapping
 *
 * The rules for mapping HTTP path, query parameters, and body fields
 * to the request message are as follows:
 *
 * 1. The `body` field specifies either `*` or a field path, or is
 *    omitted. If omitted, it assumes there is no HTTP body.
 * 2. Leaf fields (recursive expansion of nested messages in the
 *    request) can be classified into three types:
 *     (a) Matched in the URL template.
 *     (b) Covered by body (if body is `*`, everything except (a) fields;
 *         else everything under the body field)
 *     (c) All other fields.
 * 3. URL query parameters found in the HTTP request are mapped to (c) fields.
 * 4. Any body sent with an HTTP request can contain only (b) fields.
 *
 * The syntax of the path template is as follows:
 *
 *     Template = "/" Segments [ Verb ] ;
 *     Segments = Segment { "/" Segment } ;
 *     Segment  = "*" | "**" | LITERAL | Variable ;
 *     Variable = "{" FieldPath [ "=" Segments ] "}" ;
 *     FieldPath = IDENT { "." IDENT } ;
 *     Verb     = ":" LITERAL ;
 *
 * The syntax `*` matches a single path segment. It follows the semantics of
 * [RFC 6570](https://tools.ietf.org/html/rfc6570) Section 3.2.2 Simple String
 * Expansion.
 *
 * The syntax `**` matches zero or more path segments. It follows the semantics
 * of [RFC 6570](https://tools.ietf.org/html/rfc6570) Section 3.2.3 Reserved
 * Expansion. NOTE: it must be the last segment in the path except the Verb.
 *
 * The syntax `LITERAL` matches literal text in the URL path.
 *
 * The syntax `Variable` matches the entire path as specified by its template;
 * this nested template must not contain further variables. If a variable
 * matches a single path segment, its template may be omitted, e.g. `{var}`
 * is equivalent to `{var=*}`.
 *
 * NOTE: the field paths in variables and in the `body` must not refer to
 * repeated fields or map fields.
 *
 * Use CustomHttpPattern to specify any HTTP method that is not included in the
 * `pattern` field, such as HEAD, or "*" to leave the HTTP method unspecified
 * for
 * a given URL path rule. The wild-card rule is useful for services that provide
 * content to Web (HTML) clients.
 */
class HttpRule {
  /**
   * Additional HTTP bindings for the selector. Nested bindings must
   * not contain an `additional_bindings` field themselves (that is,
   * the nesting may only be one level deep).
   */
  core.List<HttpRule> additionalBindings;
  /**
   * The name of the request field whose value is mapped to the HTTP body, or
   * `*` for mapping all fields not captured by the path pattern to the HTTP
   * body. NOTE: the referred field must not be a repeated field and must be
   * present at the top-level of request message type.
   */
  core.String body;
  /** Custom pattern is used for defining custom verbs. */
  CustomHttpPattern custom;
  /** Used for deleting a resource. */
  core.String delete;
  /** Used for listing and getting information about resources. */
  core.String get;
  /**
   * Use this only for Scotty Requests. Do not use this for bytestream methods.
   * For media support, add instead [][google.bytestream.RestByteStream] as an
   * API to your configuration.
   */
  MediaDownload mediaDownload;
  /**
   * Use this only for Scotty Requests. Do not use this for media support using
   * Bytestream, add instead
   * [][google.bytestream.RestByteStream] as an API to your
   * configuration for Bytestream methods.
   */
  MediaUpload mediaUpload;
  /** Used for updating a resource. */
  core.String patch;
  /** Used for creating a resource. */
  core.String post;
  /** Used for updating a resource. */
  core.String put;
  /**
   * The name of the response field whose value is mapped to the HTTP body of
   * response. Other response fields are ignored. This field is optional. When
   * not set, the response message will be used as HTTP body of response.
   * NOTE: the referred field must be not a repeated field and must be present
   * at the top-level of response message type.
   */
  core.String responseBody;
  /**
   * Selects methods to which this rule applies.
   *
   * Refer to selector for syntax details.
   */
  core.String selector;

  HttpRule();

  HttpRule.fromJson(core.Map _json) {
    if (_json.containsKey("additionalBindings")) {
      additionalBindings = _json["additionalBindings"].map((value) => new HttpRule.fromJson(value)).toList();
    }
    if (_json.containsKey("body")) {
      body = _json["body"];
    }
    if (_json.containsKey("custom")) {
      custom = new CustomHttpPattern.fromJson(_json["custom"]);
    }
    if (_json.containsKey("delete")) {
      delete = _json["delete"];
    }
    if (_json.containsKey("get")) {
      get = _json["get"];
    }
    if (_json.containsKey("mediaDownload")) {
      mediaDownload = new MediaDownload.fromJson(_json["mediaDownload"]);
    }
    if (_json.containsKey("mediaUpload")) {
      mediaUpload = new MediaUpload.fromJson(_json["mediaUpload"]);
    }
    if (_json.containsKey("patch")) {
      patch = _json["patch"];
    }
    if (_json.containsKey("post")) {
      post = _json["post"];
    }
    if (_json.containsKey("put")) {
      put = _json["put"];
    }
    if (_json.containsKey("responseBody")) {
      responseBody = _json["responseBody"];
    }
    if (_json.containsKey("selector")) {
      selector = _json["selector"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (additionalBindings != null) {
      _json["additionalBindings"] = additionalBindings.map((value) => (value).toJson()).toList();
    }
    if (body != null) {
      _json["body"] = body;
    }
    if (custom != null) {
      _json["custom"] = (custom).toJson();
    }
    if (delete != null) {
      _json["delete"] = delete;
    }
    if (get != null) {
      _json["get"] = get;
    }
    if (mediaDownload != null) {
      _json["mediaDownload"] = (mediaDownload).toJson();
    }
    if (mediaUpload != null) {
      _json["mediaUpload"] = (mediaUpload).toJson();
    }
    if (patch != null) {
      _json["patch"] = patch;
    }
    if (post != null) {
      _json["post"] = post;
    }
    if (put != null) {
      _json["put"] = put;
    }
    if (responseBody != null) {
      _json["responseBody"] = responseBody;
    }
    if (selector != null) {
      _json["selector"] = selector;
    }
    return _json;
  }
}

/** A description of a label. */
class LabelDescriptor {
  /** A human-readable description for the label. */
  core.String description;
  /** The label key. */
  core.String key;
  /**
   * The type of data that can be assigned to the label.
   * Possible string values are:
   * - "STRING" : A variable-length string. This is the default.
   * - "BOOL" : Boolean; true or false.
   * - "INT64" : A 64-bit signed integer.
   */
  core.String valueType;

  LabelDescriptor();

  LabelDescriptor.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("valueType")) {
      valueType = _json["valueType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (key != null) {
      _json["key"] = key;
    }
    if (valueType != null) {
      _json["valueType"] = valueType;
    }
    return _json;
  }
}

/** Response message for ListServiceConfigs method. */
class ListServiceConfigsResponse {
  /** The token of the next page of results. */
  core.String nextPageToken;
  /** The list of service configuration resources. */
  core.List<Service> serviceConfigs;

  ListServiceConfigsResponse();

  ListServiceConfigsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("serviceConfigs")) {
      serviceConfigs = _json["serviceConfigs"].map((value) => new Service.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (serviceConfigs != null) {
      _json["serviceConfigs"] = serviceConfigs.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Response message for ListServiceRollouts method. */
class ListServiceRolloutsResponse {
  /** The token of the next page of results. */
  core.String nextPageToken;
  /** The list of rollout resources. */
  core.List<Rollout> rollouts;

  ListServiceRolloutsResponse();

  ListServiceRolloutsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("rollouts")) {
      rollouts = _json["rollouts"].map((value) => new Rollout.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (rollouts != null) {
      _json["rollouts"] = rollouts.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Response message for `ListServices` method. */
class ListServicesResponse {
  /**
   * Token that can be passed to `ListServices` to resume a paginated query.
   */
  core.String nextPageToken;
  /** The returned services will only have the name field set. */
  core.List<ManagedService> services;

  ListServicesResponse();

  ListServicesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("services")) {
      services = _json["services"].map((value) => new ManagedService.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (services != null) {
      _json["services"] = services.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Specifies what kind of log the caller must write
 * Increment a streamz counter with the specified metric and field names.
 *
 * Metric names should start with a '/', generally be lowercase-only,
 * and end in "_count". Field names should not contain an initial slash.
 * The actual exported metric names will have "/iam/policy" prepended.
 *
 * Field names correspond to IAM request parameters and field values are
 * their respective values.
 *
 * At present the only supported field names are
 *    - "iam_principal", corresponding to IAMContext.principal;
 *    - "" (empty string), resulting in one aggretated counter with no field.
 *
 * Examples:
 *   counter { metric: "/debug_access_count"  field: "iam_principal" }
 *   ==> increment counter /iam/policy/backend_debug_access_count
 *                         {iam_principal=[value of IAMContext.principal]}
 *
 * At this time we do not support:
 * * multiple field names (though this may be supported in the future)
 * * decrementing the counter
 * * incrementing it by anything other than 1
 */
class LogConfig {
  /** Cloud audit options. */
  CloudAuditOptions cloudAudit;
  /** Counter options. */
  CounterOptions counter;
  /** Data access options. */
  DataAccessOptions dataAccess;

  LogConfig();

  LogConfig.fromJson(core.Map _json) {
    if (_json.containsKey("cloudAudit")) {
      cloudAudit = new CloudAuditOptions.fromJson(_json["cloudAudit"]);
    }
    if (_json.containsKey("counter")) {
      counter = new CounterOptions.fromJson(_json["counter"]);
    }
    if (_json.containsKey("dataAccess")) {
      dataAccess = new DataAccessOptions.fromJson(_json["dataAccess"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cloudAudit != null) {
      _json["cloudAudit"] = (cloudAudit).toJson();
    }
    if (counter != null) {
      _json["counter"] = (counter).toJson();
    }
    if (dataAccess != null) {
      _json["dataAccess"] = (dataAccess).toJson();
    }
    return _json;
  }
}

/**
 * A description of a log type. Example in YAML format:
 *
 *     - name: library.googleapis.com/activity_history
 *       description: The history of borrowing and returning library items.
 *       display_name: Activity
 *       labels:
 *       - key: /customer_id
 *         description: Identifier of a library customer
 */
class LogDescriptor {
  /**
   * A human-readable description of this log. This information appears in
   * the documentation and can contain details.
   */
  core.String description;
  /**
   * The human-readable name for this log. This information appears on
   * the user interface and should be concise.
   */
  core.String displayName;
  /**
   * The set of labels that are available to describe a specific log entry.
   * Runtime requests that contain labels not specified here are
   * considered invalid.
   */
  core.List<LabelDescriptor> labels;
  /**
   * The name of the log. It must be less than 512 characters long and can
   * include the following characters: upper- and lower-case alphanumeric
   * characters [A-Za-z0-9], and punctuation characters including
   * slash, underscore, hyphen, period [/_-.].
   */
  core.String name;

  LogDescriptor();

  LogDescriptor.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"].map((value) => new LabelDescriptor.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (labels != null) {
      _json["labels"] = labels.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/**
 * Logging configuration of the service.
 *
 * The following example shows how to configure logs to be sent to the
 * producer and consumer projects. In the example, the `activity_history`
 * log is sent to both the producer and consumer projects, whereas the
 * `purchase_history` log is only sent to the producer project.
 *
 *     monitored_resources:
 *     - type: library.googleapis.com/branch
 *       labels:
 *       - key: /city
 *         description: The city where the library branch is located in.
 *       - key: /name
 *         description: The name of the branch.
 *     logs:
 *     - name: activity_history
 *       labels:
 *       - key: /customer_id
 *     - name: purchase_history
 *     logging:
 *       producer_destinations:
 *       - monitored_resource: library.googleapis.com/branch
 *         logs:
 *         - activity_history
 *         - purchase_history
 *       consumer_destinations:
 *       - monitored_resource: library.googleapis.com/branch
 *         logs:
 *         - activity_history
 */
class Logging {
  /**
   * Logging configurations for sending logs to the consumer project.
   * There can be multiple consumer destinations, each one must have a
   * different monitored resource type. A log can be used in at most
   * one consumer destination.
   */
  core.List<LoggingDestination> consumerDestinations;
  /**
   * Logging configurations for sending logs to the producer project.
   * There can be multiple producer destinations, each one must have a
   * different monitored resource type. A log can be used in at most
   * one producer destination.
   */
  core.List<LoggingDestination> producerDestinations;

  Logging();

  Logging.fromJson(core.Map _json) {
    if (_json.containsKey("consumerDestinations")) {
      consumerDestinations = _json["consumerDestinations"].map((value) => new LoggingDestination.fromJson(value)).toList();
    }
    if (_json.containsKey("producerDestinations")) {
      producerDestinations = _json["producerDestinations"].map((value) => new LoggingDestination.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (consumerDestinations != null) {
      _json["consumerDestinations"] = consumerDestinations.map((value) => (value).toJson()).toList();
    }
    if (producerDestinations != null) {
      _json["producerDestinations"] = producerDestinations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Configuration of a specific logging destination (the producer project
 * or the consumer project).
 */
class LoggingDestination {
  /**
   * Names of the logs to be sent to this destination. Each name must
   * be defined in the Service.logs section. If the log name is
   * not a domain scoped name, it will be automatically prefixed with
   * the service name followed by "/".
   */
  core.List<core.String> logs;
  /**
   * The monitored resource type. The type must be defined in the
   * Service.monitored_resources section.
   */
  core.String monitoredResource;

  LoggingDestination();

  LoggingDestination.fromJson(core.Map _json) {
    if (_json.containsKey("logs")) {
      logs = _json["logs"];
    }
    if (_json.containsKey("monitoredResource")) {
      monitoredResource = _json["monitoredResource"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (logs != null) {
      _json["logs"] = logs;
    }
    if (monitoredResource != null) {
      _json["monitoredResource"] = monitoredResource;
    }
    return _json;
  }
}

/**
 * The full representation of a Service that is managed by
 * Google Service Management.
 */
class ManagedService {
  /** ID of the project that produces and owns this service. */
  core.String producerProjectId;
  /**
   * The name of the service. See the [overview](/service-management/overview)
   * for naming requirements.
   */
  core.String serviceName;

  ManagedService();

  ManagedService.fromJson(core.Map _json) {
    if (_json.containsKey("producerProjectId")) {
      producerProjectId = _json["producerProjectId"];
    }
    if (_json.containsKey("serviceName")) {
      serviceName = _json["serviceName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (producerProjectId != null) {
      _json["producerProjectId"] = producerProjectId;
    }
    if (serviceName != null) {
      _json["serviceName"] = serviceName;
    }
    return _json;
  }
}

/**
 * Use this only for Scotty Requests. Do not use this for media support using
 * Bytestream, add instead [][google.bytestream.RestByteStream] as an API to
 * your configuration for Bytestream methods.
 */
class MediaDownload {
  /**
   * DO NOT USE THIS FIELD UNTIL THIS WARNING IS REMOVED.
   *
   * Specify name of the download service if one is used for download.
   */
  core.String downloadService;
  /** Whether download is enabled. */
  core.bool enabled;

  MediaDownload();

  MediaDownload.fromJson(core.Map _json) {
    if (_json.containsKey("downloadService")) {
      downloadService = _json["downloadService"];
    }
    if (_json.containsKey("enabled")) {
      enabled = _json["enabled"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (downloadService != null) {
      _json["downloadService"] = downloadService;
    }
    if (enabled != null) {
      _json["enabled"] = enabled;
    }
    return _json;
  }
}

/**
 * Use this only for Scotty Requests. Do not use this for media support using
 * Bytestream, add instead [][google.bytestream.RestByteStream] as an API to
 * your configuration for Bytestream methods.
 */
class MediaUpload {
  /** Whether upload is enabled. */
  core.bool enabled;
  /**
   * DO NOT USE THIS FIELD UNTIL THIS WARNING IS REMOVED.
   *
   * Specify name of the upload service if one is used for upload.
   */
  core.String uploadService;

  MediaUpload();

  MediaUpload.fromJson(core.Map _json) {
    if (_json.containsKey("enabled")) {
      enabled = _json["enabled"];
    }
    if (_json.containsKey("uploadService")) {
      uploadService = _json["uploadService"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (enabled != null) {
      _json["enabled"] = enabled;
    }
    if (uploadService != null) {
      _json["uploadService"] = uploadService;
    }
    return _json;
  }
}

/** Method represents a method of an api. */
class Method {
  /** The simple name of this method. */
  core.String name;
  /** Any metadata attached to the method. */
  core.List<Option> options;
  /** If true, the request is streamed. */
  core.bool requestStreaming;
  /** A URL of the input message type. */
  core.String requestTypeUrl;
  /** If true, the response is streamed. */
  core.bool responseStreaming;
  /** The URL of the output message type. */
  core.String responseTypeUrl;
  /**
   * The source syntax of this method.
   * Possible string values are:
   * - "SYNTAX_PROTO2" : Syntax `proto2`.
   * - "SYNTAX_PROTO3" : Syntax `proto3`.
   */
  core.String syntax;

  Method();

  Method.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("options")) {
      options = _json["options"].map((value) => new Option.fromJson(value)).toList();
    }
    if (_json.containsKey("requestStreaming")) {
      requestStreaming = _json["requestStreaming"];
    }
    if (_json.containsKey("requestTypeUrl")) {
      requestTypeUrl = _json["requestTypeUrl"];
    }
    if (_json.containsKey("responseStreaming")) {
      responseStreaming = _json["responseStreaming"];
    }
    if (_json.containsKey("responseTypeUrl")) {
      responseTypeUrl = _json["responseTypeUrl"];
    }
    if (_json.containsKey("syntax")) {
      syntax = _json["syntax"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (options != null) {
      _json["options"] = options.map((value) => (value).toJson()).toList();
    }
    if (requestStreaming != null) {
      _json["requestStreaming"] = requestStreaming;
    }
    if (requestTypeUrl != null) {
      _json["requestTypeUrl"] = requestTypeUrl;
    }
    if (responseStreaming != null) {
      _json["responseStreaming"] = responseStreaming;
    }
    if (responseTypeUrl != null) {
      _json["responseTypeUrl"] = responseTypeUrl;
    }
    if (syntax != null) {
      _json["syntax"] = syntax;
    }
    return _json;
  }
}

/**
 * Defines a metric type and its schema. Once a metric descriptor is created,
 * deleting or altering it stops data collection and makes the metric type's
 * existing data unusable.
 */
class MetricDescriptor {
  /**
   * A detailed description of the metric, which can be used in documentation.
   */
  core.String description;
  /**
   * A concise name for the metric, which can be displayed in user interfaces.
   * Use sentence case without an ending period, for example "Request count".
   */
  core.String displayName;
  /**
   * The set of labels that can be used to describe a specific
   * instance of this metric type. For example, the
   * `appengine.googleapis.com/http/server/response_latencies` metric
   * type has a label for the HTTP response code, `response_code`, so
   * you can look at latencies for successful responses or just
   * for responses that failed.
   */
  core.List<LabelDescriptor> labels;
  /**
   * Whether the metric records instantaneous values, changes to a value, etc.
   * Some combinations of `metric_kind` and `value_type` might not be supported.
   * Possible string values are:
   * - "METRIC_KIND_UNSPECIFIED" : Do not use this default value.
   * - "GAUGE" : An instantaneous measurement of a value.
   * - "DELTA" : The change in a value during a time interval.
   * - "CUMULATIVE" : A value accumulated over a time interval.  Cumulative
   * measurements in a time series should have the same start time
   * and increasing end times, until an event resets the cumulative
   * value to zero and sets a new start time for the following
   * points.
   */
  core.String metricKind;
  /**
   * The resource name of the metric descriptor. Depending on the
   * implementation, the name typically includes: (1) the parent resource name
   * that defines the scope of the metric type or of its data; and (2) the
   * metric's URL-encoded type, which also appears in the `type` field of this
   * descriptor. For example, following is the resource name of a custom
   * metric within the GCP project `my-project-id`:
   *
   * "projects/my-project-id/metricDescriptors/custom.googleapis.com%2Finvoice%2Fpaid%2Famount"
   */
  core.String name;
  /**
   * The metric type, including its DNS name prefix. The type is not
   * URL-encoded.  All user-defined custom metric types have the DNS name
   * `custom.googleapis.com`.  Metric types should use a natural hierarchical
   * grouping. For example:
   *
   *     "custom.googleapis.com/invoice/paid/amount"
   *     "appengine.googleapis.com/http/server/response_latencies"
   */
  core.String type;
  /**
   * The unit in which the metric value is reported. It is only applicable
   * if the `value_type` is `INT64`, `DOUBLE`, or `DISTRIBUTION`. The
   * supported units are a subset of [The Unified Code for Units of
   * Measure](http://unitsofmeasure.org/ucum.html) standard:
   *
   * **Basic units (UNIT)**
   *
   * * `bit`   bit
   * * `By`    byte
   * * `s`     second
   * * `min`   minute
   * * `h`     hour
   * * `d`     day
   *
   * **Prefixes (PREFIX)**
   *
   * * `k`     kilo    (10**3)
   * * `M`     mega    (10**6)
   * * `G`     giga    (10**9)
   * * `T`     tera    (10**12)
   * * `P`     peta    (10**15)
   * * `E`     exa     (10**18)
   * * `Z`     zetta   (10**21)
   * * `Y`     yotta   (10**24)
   * * `m`     milli   (10**-3)
   * * `u`     micro   (10**-6)
   * * `n`     nano    (10**-9)
   * * `p`     pico    (10**-12)
   * * `f`     femto   (10**-15)
   * * `a`     atto    (10**-18)
   * * `z`     zepto   (10**-21)
   * * `y`     yocto   (10**-24)
   * * `Ki`    kibi    (2**10)
   * * `Mi`    mebi    (2**20)
   * * `Gi`    gibi    (2**30)
   * * `Ti`    tebi    (2**40)
   *
   * **Grammar**
   *
   * The grammar includes the dimensionless unit `1`, such as `1/s`.
   *
   * The grammar also includes these connectors:
   *
   * * `/`    division (as an infix operator, e.g. `1/s`).
   * * `.`    multiplication (as an infix operator, e.g. `GBy.d`)
   *
   * The grammar for a unit is as follows:
   *
   *     Expression = Component { "." Component } { "/" Component } ;
   *
   *     Component = [ PREFIX ] UNIT [ Annotation ]
   *               | Annotation
   *               | "1"
   *               ;
   *
   *     Annotation = "{" NAME "}" ;
   *
   * Notes:
   *
   * * `Annotation` is just a comment if it follows a `UNIT` and is
   *    equivalent to `1` if it is used alone. For examples,
   *    `{requests}/s == 1/s`, `By{transmitted}/s == By/s`.
   * * `NAME` is a sequence of non-blank printable ASCII characters not
   *    containing '{' or '}'.
   */
  core.String unit;
  /**
   * Whether the measurement is an integer, a floating-point number, etc.
   * Some combinations of `metric_kind` and `value_type` might not be supported.
   * Possible string values are:
   * - "VALUE_TYPE_UNSPECIFIED" : Do not use this default value.
   * - "BOOL" : The value is a boolean.
   * This value type can be used only if the metric kind is `GAUGE`.
   * - "INT64" : The value is a signed 64-bit integer.
   * - "DOUBLE" : The value is a double precision floating point number.
   * - "STRING" : The value is a text string.
   * This value type can be used only if the metric kind is `GAUGE`.
   * - "DISTRIBUTION" : The value is a `Distribution`.
   * - "MONEY" : The value is money.
   */
  core.String valueType;

  MetricDescriptor();

  MetricDescriptor.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"].map((value) => new LabelDescriptor.fromJson(value)).toList();
    }
    if (_json.containsKey("metricKind")) {
      metricKind = _json["metricKind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("valueType")) {
      valueType = _json["valueType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (labels != null) {
      _json["labels"] = labels.map((value) => (value).toJson()).toList();
    }
    if (metricKind != null) {
      _json["metricKind"] = metricKind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (valueType != null) {
      _json["valueType"] = valueType;
    }
    return _json;
  }
}

/**
 * Declares an API to be included in this API. The including API must
 * redeclare all the methods from the included API, but documentation
 * and options are inherited as follows:
 *
 * - If after comment and whitespace stripping, the documentation
 *   string of the redeclared method is empty, it will be inherited
 *   from the original method.
 *
 * - Each annotation belonging to the service config (http,
 *   visibility) which is not set in the redeclared method will be
 *   inherited.
 *
 * - If an http annotation is inherited, the path pattern will be
 *   modified as follows. Any version prefix will be replaced by the
 *   version of the including API plus the root path if specified.
 *
 * Example of a simple mixin:
 *
 *     package google.acl.v1;
 *     service AccessControl {
 *       // Get the underlying ACL object.
 *       rpc GetAcl(GetAclRequest) returns (Acl) {
 *         option (google.api.http).get = "/v1/{resource=**}:getAcl";
 *       }
 *     }
 *
 *     package google.storage.v2;
 *     service Storage {
 *       //       rpc GetAcl(GetAclRequest) returns (Acl);
 *
 *       // Get a data record.
 *       rpc GetData(GetDataRequest) returns (Data) {
 *         option (google.api.http).get = "/v2/{resource=**}";
 *       }
 *     }
 *
 * Example of a mixin configuration:
 *
 *     apis:
 *     - name: google.storage.v2.Storage
 *       mixins:
 *       - name: google.acl.v1.AccessControl
 *
 * The mixin construct implies that all methods in `AccessControl` are
 * also declared with same name and request/response types in
 * `Storage`. A documentation generator or annotation processor will
 * see the effective `Storage.GetAcl` method after inherting
 * documentation and annotations as follows:
 *
 *     service Storage {
 *       // Get the underlying ACL object.
 *       rpc GetAcl(GetAclRequest) returns (Acl) {
 *         option (google.api.http).get = "/v2/{resource=**}:getAcl";
 *       }
 *       ...
 *     }
 *
 * Note how the version in the path pattern changed from `v1` to `v2`.
 *
 * If the `root` field in the mixin is specified, it should be a
 * relative path under which inherited HTTP paths are placed. Example:
 *
 *     apis:
 *     - name: google.storage.v2.Storage
 *       mixins:
 *       - name: google.acl.v1.AccessControl
 *         root: acls
 *
 * This implies the following inherited HTTP annotation:
 *
 *     service Storage {
 *       // Get the underlying ACL object.
 *       rpc GetAcl(GetAclRequest) returns (Acl) {
 *         option (google.api.http).get = "/v2/acls/{resource=**}:getAcl";
 *       }
 *       ...
 *     }
 */
class Mixin {
  /** The fully qualified name of the API which is included. */
  core.String name;
  /**
   * If non-empty specifies a path under which inherited HTTP paths
   * are rooted.
   */
  core.String root;

  Mixin();

  Mixin.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("root")) {
      root = _json["root"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (root != null) {
      _json["root"] = root;
    }
    return _json;
  }
}

/**
 * An object that describes the schema of a MonitoredResource object using a
 * type name and a set of labels.  For example, the monitored resource
 * descriptor for Google Compute Engine VM instances has a type of
 * `"gce_instance"` and specifies the use of the labels `"instance_id"` and
 * `"zone"` to identify particular VM instances.
 *
 * Different APIs can support different monitored resource types. APIs generally
 * provide a `list` method that returns the monitored resource descriptors used
 * by the API.
 */
class MonitoredResourceDescriptor {
  /**
   * Optional. A detailed description of the monitored resource type that might
   * be used in documentation.
   */
  core.String description;
  /**
   * Optional. A concise name for the monitored resource type that might be
   * displayed in user interfaces. It should be a Title Cased Noun Phrase,
   * without any article or other determiners. For example,
   * `"Google Cloud SQL Database"`.
   */
  core.String displayName;
  /**
   * Required. A set of labels used to describe instances of this monitored
   * resource type. For example, an individual Google Cloud SQL database is
   * identified by values for the labels `"database_id"` and `"zone"`.
   */
  core.List<LabelDescriptor> labels;
  /**
   * Optional. The resource name of the monitored resource descriptor:
   * `"projects/{project_id}/monitoredResourceDescriptors/{type}"` where
   * {type} is the value of the `type` field in this object and
   * {project_id} is a project ID that provides API-specific context for
   * accessing the type.  APIs that do not use project information can use the
   * resource name format `"monitoredResourceDescriptors/{type}"`.
   */
  core.String name;
  /**
   * Required. The monitored resource type. For example, the type
   * `"cloudsql_database"` represents databases in Google Cloud SQL.
   * The maximum length of this value is 256 characters.
   */
  core.String type;

  MonitoredResourceDescriptor();

  MonitoredResourceDescriptor.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"].map((value) => new LabelDescriptor.fromJson(value)).toList();
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
    if (description != null) {
      _json["description"] = description;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (labels != null) {
      _json["labels"] = labels.map((value) => (value).toJson()).toList();
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

/**
 * Monitoring configuration of the service.
 *
 * The example below shows how to configure monitored resources and metrics
 * for monitoring. In the example, a monitored resource and two metrics are
 * defined. The `library.googleapis.com/book/returned_count` metric is sent
 * to both producer and consumer projects, whereas the
 * `library.googleapis.com/book/overdue_count` metric is only sent to the
 * consumer project.
 *
 *     monitored_resources:
 *     - type: library.googleapis.com/branch
 *       labels:
 *       - key: /city
 *         description: The city where the library branch is located in.
 *       - key: /name
 *         description: The name of the branch.
 *     metrics:
 *     - name: library.googleapis.com/book/returned_count
 *       metric_kind: DELTA
 *       value_type: INT64
 *       labels:
 *       - key: /customer_id
 *     - name: library.googleapis.com/book/overdue_count
 *       metric_kind: GAUGE
 *       value_type: INT64
 *       labels:
 *       - key: /customer_id
 *     monitoring:
 *       producer_destinations:
 *       - monitored_resource: library.googleapis.com/branch
 *         metrics:
 *         - library.googleapis.com/book/returned_count
 *       consumer_destinations:
 *       - monitored_resource: library.googleapis.com/branch
 *         metrics:
 *         - library.googleapis.com/book/returned_count
 *         - library.googleapis.com/book/overdue_count
 */
class Monitoring {
  /**
   * Monitoring configurations for sending metrics to the consumer project.
   * There can be multiple consumer destinations, each one must have a
   * different monitored resource type. A metric can be used in at most
   * one consumer destination.
   */
  core.List<MonitoringDestination> consumerDestinations;
  /**
   * Monitoring configurations for sending metrics to the producer project.
   * There can be multiple producer destinations, each one must have a
   * different monitored resource type. A metric can be used in at most
   * one producer destination.
   */
  core.List<MonitoringDestination> producerDestinations;

  Monitoring();

  Monitoring.fromJson(core.Map _json) {
    if (_json.containsKey("consumerDestinations")) {
      consumerDestinations = _json["consumerDestinations"].map((value) => new MonitoringDestination.fromJson(value)).toList();
    }
    if (_json.containsKey("producerDestinations")) {
      producerDestinations = _json["producerDestinations"].map((value) => new MonitoringDestination.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (consumerDestinations != null) {
      _json["consumerDestinations"] = consumerDestinations.map((value) => (value).toJson()).toList();
    }
    if (producerDestinations != null) {
      _json["producerDestinations"] = producerDestinations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Configuration of a specific monitoring destination (the producer project
 * or the consumer project).
 */
class MonitoringDestination {
  /**
   * Names of the metrics to report to this monitoring destination.
   * Each name must be defined in Service.metrics section.
   */
  core.List<core.String> metrics;
  /**
   * The monitored resource type. The type must be defined in
   * Service.monitored_resources section.
   */
  core.String monitoredResource;

  MonitoringDestination();

  MonitoringDestination.fromJson(core.Map _json) {
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"];
    }
    if (_json.containsKey("monitoredResource")) {
      monitoredResource = _json["monitoredResource"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (metrics != null) {
      _json["metrics"] = metrics;
    }
    if (monitoredResource != null) {
      _json["monitoredResource"] = monitoredResource;
    }
    return _json;
  }
}

/**
 * OAuth scopes are a way to define data and permissions on data. For example,
 * there are scopes defined for "Read-only access to Google Calendar" and
 * "Access to Cloud Platform". Users can consent to a scope for an application,
 * giving it permission to access that data on their behalf.
 *
 * OAuth scope specifications should be fairly coarse grained; a user will need
 * to see and understand the text description of what your scope means.
 *
 * In most cases: use one or at most two OAuth scopes for an entire family of
 * products. If your product has multiple APIs, you should probably be sharing
 * the OAuth scope across all of those APIs.
 *
 * When you need finer grained OAuth consent screens: talk with your product
 * management about how developers will use them in practice.
 *
 * Please note that even though each of the canonical scopes is enough for a
 * request to be accepted and passed to the backend, a request can still fail
 * due to the backend requiring additional scopes or permissions.
 */
class OAuthRequirements {
  /**
   * The list of publicly documented OAuth scopes that are allowed access. An
   * OAuth token containing any of these scopes will be accepted.
   *
   * Example:
   *
   *      canonical_scopes: https://www.googleapis.com/auth/calendar,
   *                        https://www.googleapis.com/auth/calendar.read
   */
  core.String canonicalScopes;

  OAuthRequirements();

  OAuthRequirements.fromJson(core.Map _json) {
    if (_json.containsKey("canonicalScopes")) {
      canonicalScopes = _json["canonicalScopes"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (canonicalScopes != null) {
      _json["canonicalScopes"] = canonicalScopes;
    }
    return _json;
  }
}

/**
 * This resource represents a long-running operation that is the result of a
 * network API call.
 */
class Operation {
  /**
   * If the value is `false`, it means the operation is still in progress.
   * If true, the operation is completed, and either `error` or `response` is
   * available.
   */
  core.bool done;
  /** The error result of the operation in case of failure or cancellation. */
  Status error;
  /**
   * Service-specific metadata associated with the operation.  It typically
   * contains progress information and common metadata such as create time.
   * Some services might not provide such metadata.  Any method that returns a
   * long-running operation should document the metadata type, if any.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> metadata;
  /**
   * The server-assigned name, which is only unique within the same service that
   * originally returns it. If you use the default HTTP mapping, the
   * `name` should have the format of `operations/some/unique/name`.
   */
  core.String name;
  /**
   * The normal response of the operation in case of success.  If the original
   * method returns no data on success, such as `Delete`, the response is
   * `google.protobuf.Empty`.  If the original method is standard
   * `Get`/`Create`/`Update`, the response should be the resource.  For other
   * methods, the response should have the type `XxxResponse`, where `Xxx`
   * is the original method name.  For example, if the original method name
   * is `TakeSnapshot()`, the inferred response type is
   * `TakeSnapshotResponse`.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> response;

  Operation();

  Operation.fromJson(core.Map _json) {
    if (_json.containsKey("done")) {
      done = _json["done"];
    }
    if (_json.containsKey("error")) {
      error = new Status.fromJson(_json["error"]);
    }
    if (_json.containsKey("metadata")) {
      metadata = _json["metadata"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("response")) {
      response = _json["response"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (done != null) {
      _json["done"] = done;
    }
    if (error != null) {
      _json["error"] = (error).toJson();
    }
    if (metadata != null) {
      _json["metadata"] = metadata;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (response != null) {
      _json["response"] = response;
    }
    return _json;
  }
}

/** The metadata associated with a long running operation resource. */
class OperationMetadata {
  /** Percentage of completion of this operation, ranging from 0 to 100. */
  core.int progressPercentage;
  /**
   * The full name of the resources that this operation is directly
   * associated with.
   */
  core.List<core.String> resourceNames;
  /** The start time of the operation. */
  core.String startTime;
  /** Detailed status information for each step. The order is undetermined. */
  core.List<Step> steps;

  OperationMetadata();

  OperationMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("progressPercentage")) {
      progressPercentage = _json["progressPercentage"];
    }
    if (_json.containsKey("resourceNames")) {
      resourceNames = _json["resourceNames"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
    if (_json.containsKey("steps")) {
      steps = _json["steps"].map((value) => new Step.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (progressPercentage != null) {
      _json["progressPercentage"] = progressPercentage;
    }
    if (resourceNames != null) {
      _json["resourceNames"] = resourceNames;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    if (steps != null) {
      _json["steps"] = steps.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * A protocol buffer option, which can be attached to a message, field,
 * enumeration, etc.
 */
class Option {
  /**
   * The option's name. For protobuf built-in options (options defined in
   * descriptor.proto), this is the short name. For example, `"map_entry"`.
   * For custom options, it should be the fully-qualified name. For example,
   * `"google.api.http"`.
   */
  core.String name;
  /**
   * The option's value packed in an Any message. If the value is a primitive,
   * the corresponding wrapper type defined in google/protobuf/wrappers.proto
   * should be used. If the value is an enum, it should be stored as an int32
   * value using the google.protobuf.Int32Value type.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> value;

  Option();

  Option.fromJson(core.Map _json) {
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

/**
 * Represents a documentation page. A page can contain subpages to represent
 * nested documentation set structure.
 */
class Page {
  /**
   * The Markdown content of the page. You can use <code>&#40;== include {path}
   * ==&#41;</code>
   * to include content from a Markdown file.
   */
  core.String content;
  /**
   * The name of the page. It will be used as an identity of the page to
   * generate URI of the page, text of the link to this page in navigation,
   * etc. The full page name (start from the root page name to this page
   * concatenated with `.`) can be used as reference to the page in your
   * documentation. For example:
   * <pre><code>pages:
   * - name: Tutorial
   *   content: &#40;== include tutorial.md ==&#41;
   *   subpages:
   *   - name: Java
   *     content: &#40;== include tutorial_java.md ==&#41;
   * </code></pre>
   * You can reference `Java` page using Markdown reference link syntax:
   * `Java`.
   */
  core.String name;
  /**
   * Subpages of this page. The order of subpages specified here will be
   * honored in the generated docset.
   */
  core.List<Page> subpages;

  Page();

  Page.fromJson(core.Map _json) {
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("subpages")) {
      subpages = _json["subpages"].map((value) => new Page.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (content != null) {
      _json["content"] = content;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (subpages != null) {
      _json["subpages"] = subpages.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Defines an Identity and Access Management (IAM) policy. It is used to
 * specify access control policies for Cloud Platform resources.
 *
 *
 * A `Policy` consists of a list of `bindings`. A `Binding` binds a list of
 * `members` to a `role`, where the members can be user accounts, Google groups,
 * Google domains, and service accounts. A `role` is a named list of permissions
 * defined by IAM.
 *
 * **Example**
 *
 *     {
 *       "bindings": [
 *         {
 *           "role": "roles/owner",
 *           "members": [
 *             "user:mike@example.com",
 *             "group:admins@example.com",
 *             "domain:google.com",
 *             "serviceAccount:my-other-app@appspot.gserviceaccount.com",
 *           ]
 *         },
 *         {
 *           "role": "roles/viewer",
 *           "members": ["user:sean@example.com"]
 *         }
 *       ]
 *     }
 *
 * For a description of IAM and its features, see the
 * [IAM developer's guide](https://cloud.google.com/iam).
 */
class Policy {
  /** Specifies cloud audit logging configuration for this policy. */
  core.List<AuditConfig> auditConfigs;
  /**
   * Associates a list of `members` to a `role`.
   * Multiple `bindings` must not be specified for the same `role`.
   * `bindings` with no members will result in an error.
   */
  core.List<Binding> bindings;
  /**
   * `etag` is used for optimistic concurrency control as a way to help
   * prevent simultaneous updates of a policy from overwriting each other.
   * It is strongly suggested that systems make use of the `etag` in the
   * read-modify-write cycle to perform policy updates in order to avoid race
   * conditions: An `etag` is returned in the response to `getIamPolicy`, and
   * systems are expected to put that etag in the request to `setIamPolicy` to
   * ensure that their change will be applied to the same version of the policy.
   *
   * If no `etag` is provided in the call to `setIamPolicy`, then the existing
   * policy is overwritten blindly.
   */
  core.String etag;
  core.List<core.int> get etagAsBytes {
    return convert.BASE64.decode(etag);
  }

  void set etagAsBytes(core.List<core.int> _bytes) {
    etag = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  core.bool iamOwned;
  /**
   * If more than one rule is specified, the rules are applied in the following
   * manner:
   * - All matching LOG rules are always applied.
   * - If any DENY/DENY_WITH_LOG rule matches, permission is denied.
   *   Logging will be applied if one or more matching rule requires logging.
   * - Otherwise, if any ALLOW/ALLOW_WITH_LOG rule matches, permission is
   *   granted.
   *   Logging will be applied if one or more matching rule requires logging.
   * - Otherwise, if no rule applies, permission is denied.
   */
  core.List<Rule> rules;
  /** Version of the `Policy`. The default version is 0. */
  core.int version;

  Policy();

  Policy.fromJson(core.Map _json) {
    if (_json.containsKey("auditConfigs")) {
      auditConfigs = _json["auditConfigs"].map((value) => new AuditConfig.fromJson(value)).toList();
    }
    if (_json.containsKey("bindings")) {
      bindings = _json["bindings"].map((value) => new Binding.fromJson(value)).toList();
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("iamOwned")) {
      iamOwned = _json["iamOwned"];
    }
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new Rule.fromJson(value)).toList();
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (auditConfigs != null) {
      _json["auditConfigs"] = auditConfigs.map((value) => (value).toJson()).toList();
    }
    if (bindings != null) {
      _json["bindings"] = bindings.map((value) => (value).toJson()).toList();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (iamOwned != null) {
      _json["iamOwned"] = iamOwned;
    }
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

/**
 * A rollout resource that defines how service configuration versions are pushed
 * to control plane systems. Typically, you create a new version of the
 * service config, and then create a Rollout to push the service config.
 */
class Rollout {
  /** Creation time of the rollout. Readonly. */
  core.String createTime;
  /** The user who created the Rollout. Readonly. */
  core.String createdBy;
  /**
   * The strategy associated with a rollout to delete a `ManagedService`.
   * Readonly.
   */
  DeleteServiceStrategy deleteServiceStrategy;
  /**
   * Optional unique identifier of this Rollout. Only lower case letters, digits
   *  and '-' are allowed.
   *
   * If not specified by client, the server will generate one. The generated id
   * will have the form of <date><revision number>, where "date" is the create
   * date in ISO 8601 format.  "revision number" is a monotonically increasing
   * positive number that is reset every day for each service.
   * An example of the generated rollout_id is '2016-02-16r1'
   */
  core.String rolloutId;
  /** The name of the service associated with this Rollout. */
  core.String serviceName;
  /**
   * The status of this rollout. Readonly. In case of a failed rollout,
   * the system will automatically rollback to the current Rollout
   * version. Readonly.
   * Possible string values are:
   * - "ROLLOUT_STATUS_UNSPECIFIED" : No status specified.
   * - "IN_PROGRESS" : The Rollout is in progress.
   * - "SUCCESS" : The Rollout has completed successfully.
   * - "CANCELLED" : The Rollout has been cancelled. This can happen if you have
   * overlapping
   * Rollout pushes, and the previous ones will be cancelled.
   * - "FAILED" : The Rollout has failed. It is typically caused by
   * configuration errors.
   * - "PENDING" : The Rollout has not started yet and is pending for execution.
   */
  core.String status;
  /**
   * Google Service Control selects service configurations based on
   * traffic percentage.
   */
  TrafficPercentStrategy trafficPercentStrategy;

  Rollout();

  Rollout.fromJson(core.Map _json) {
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("createdBy")) {
      createdBy = _json["createdBy"];
    }
    if (_json.containsKey("deleteServiceStrategy")) {
      deleteServiceStrategy = new DeleteServiceStrategy.fromJson(_json["deleteServiceStrategy"]);
    }
    if (_json.containsKey("rolloutId")) {
      rolloutId = _json["rolloutId"];
    }
    if (_json.containsKey("serviceName")) {
      serviceName = _json["serviceName"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("trafficPercentStrategy")) {
      trafficPercentStrategy = new TrafficPercentStrategy.fromJson(_json["trafficPercentStrategy"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (createdBy != null) {
      _json["createdBy"] = createdBy;
    }
    if (deleteServiceStrategy != null) {
      _json["deleteServiceStrategy"] = (deleteServiceStrategy).toJson();
    }
    if (rolloutId != null) {
      _json["rolloutId"] = rolloutId;
    }
    if (serviceName != null) {
      _json["serviceName"] = serviceName;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (trafficPercentStrategy != null) {
      _json["trafficPercentStrategy"] = (trafficPercentStrategy).toJson();
    }
    return _json;
  }
}

/** A rule to be applied in a Policy. */
class Rule {
  /**
   * Required
   * Possible string values are:
   * - "NO_ACTION" : Default no action.
   * - "ALLOW" : Matching 'Entries' grant access.
   * - "ALLOW_WITH_LOG" : Matching 'Entries' grant access and the caller
   * promises to log
   * the request per the returned log_configs.
   * - "DENY" : Matching 'Entries' deny access.
   * - "DENY_WITH_LOG" : Matching 'Entries' deny access and the caller promises
   * to log
   * the request per the returned log_configs.
   * - "LOG" : Matching 'Entries' tell IAM.Check callers to generate logs.
   */
  core.String action;
  /** Additional restrictions that must be met */
  core.List<Condition> conditions;
  /** Human-readable description of the rule. */
  core.String description;
  /**
   * If one or more 'in' clauses are specified, the rule matches if
   * the PRINCIPAL/AUTHORITY_SELECTOR is in at least one of these entries.
   */
  core.List<core.String> in_;
  /**
   * The config returned to callers of tech.iam.IAM.CheckPolicy for any entries
   * that match the LOG action.
   */
  core.List<LogConfig> logConfig;
  /**
   * If one or more 'not_in' clauses are specified, the rule matches
   * if the PRINCIPAL/AUTHORITY_SELECTOR is in none of the entries.
   * The format for in and not_in entries is the same as for members in a
   * Binding (see google/iam/v1/policy.proto).
   */
  core.List<core.String> notIn;
  /**
   * A permission is a string of form '<service>.<resource type>.<verb>'
   * (e.g., 'storage.buckets.list'). A value of '*' matches all permissions,
   * and a verb part of '*' (e.g., 'storage.buckets.*') matches all verbs.
   */
  core.List<core.String> permissions;

  Rule();

  Rule.fromJson(core.Map _json) {
    if (_json.containsKey("action")) {
      action = _json["action"];
    }
    if (_json.containsKey("conditions")) {
      conditions = _json["conditions"].map((value) => new Condition.fromJson(value)).toList();
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("in")) {
      in_ = _json["in"];
    }
    if (_json.containsKey("logConfig")) {
      logConfig = _json["logConfig"].map((value) => new LogConfig.fromJson(value)).toList();
    }
    if (_json.containsKey("notIn")) {
      notIn = _json["notIn"];
    }
    if (_json.containsKey("permissions")) {
      permissions = _json["permissions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (action != null) {
      _json["action"] = action;
    }
    if (conditions != null) {
      _json["conditions"] = conditions.map((value) => (value).toJson()).toList();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (in_ != null) {
      _json["in"] = in_;
    }
    if (logConfig != null) {
      _json["logConfig"] = logConfig.map((value) => (value).toJson()).toList();
    }
    if (notIn != null) {
      _json["notIn"] = notIn;
    }
    if (permissions != null) {
      _json["permissions"] = permissions;
    }
    return _json;
  }
}

/**
 * `Service` is the root object of Google service configuration schema. It
 * describes basic information about a service, such as the name and the
 * title, and delegates other aspects to sub-sections. Each sub-section is
 * either a proto message or a repeated proto message that configures a
 * specific aspect, such as auth. See each proto message definition for details.
 *
 * Example:
 *
 *     type: google.api.Service
 *     config_version: 3
 *     name: calendar.googleapis.com
 *     title: Google Calendar API
 *     apis:
 *     - name: google.calendar.v3.Calendar
 *     authentication:
 *       providers:
 *       - id: google_calendar_auth
 *         jwks_uri: https://www.googleapis.com/oauth2/v1/certs
 *         issuer: https://securetoken.google.com
 *       rules:
 *       - selector: "*"
 *         requirements:
 *           provider_id: google_calendar_auth
 */
class Service {
  /**
   * A list of API interfaces exported by this service. Only the `name` field
   * of the google.protobuf.Api needs to be provided by the configuration
   * author, as the remaining fields will be derived from the IDL during the
   * normalization process. It is an error to specify an API interface here
   * which cannot be resolved against the associated IDL files.
   */
  core.List<Api> apis;
  /** Auth configuration. */
  Authentication authentication;
  /** API backend configuration. */
  Backend backend;
  /**
   * The version of the service configuration. The config version may
   * influence interpretation of the configuration, for example, to
   * determine defaults. This is documented together with applicable
   * options. The current default for the config version itself is `3`.
   */
  core.int configVersion;
  /** Context configuration. */
  Context context;
  /** Configuration for the service control plane. */
  Control control;
  /** Custom error configuration. */
  CustomError customError;
  /** Additional API documentation. */
  Documentation documentation;
  /**
   * Configuration for network endpoints.  If this is empty, then an endpoint
   * with the same name as the service is automatically generated to service all
   * defined APIs.
   */
  core.List<Endpoint> endpoints;
  /**
   * A list of all enum types included in this API service.  Enums
   * referenced directly or indirectly by the `apis` are automatically
   * included.  Enums which are not referenced but shall be included
   * should be listed here by name. Example:
   *
   *     enums:
   *     - name: google.someapi.v1.SomeEnum
   */
  core.List<Enum> enums;
  /** Experimental configuration. */
  Experimental experimental;
  /** HTTP configuration. */
  Http http;
  /**
   * A unique ID for a specific instance of this message, typically assigned
   * by the client for tracking purpose. If empty, the server may choose to
   * generate one instead.
   */
  core.String id;
  /** Logging configuration. */
  Logging logging;
  /** Defines the logs used by this service. */
  core.List<LogDescriptor> logs;
  /** Defines the metrics used by this service. */
  core.List<MetricDescriptor> metrics;
  /**
   * Defines the monitored resources used by this service. This is required
   * by the Service.monitoring and Service.logging configurations.
   */
  core.List<MonitoredResourceDescriptor> monitoredResources;
  /** Monitoring configuration. */
  Monitoring monitoring;
  /**
   * The DNS address at which this service is available,
   * e.g. `calendar.googleapis.com`.
   */
  core.String name;
  /**
   * The id of the Google developer project that owns the service.
   * Members of this project can manage the service configuration,
   * manage consumption of the service, etc.
   */
  core.String producerProjectId;
  /** System parameter configuration. */
  SystemParameters systemParameters;
  /**
   * A list of all proto message types included in this API service.
   * It serves similar purpose as [google.api.Service.types], except that
   * these types are not needed by user-defined APIs. Therefore, they will not
   * show up in the generated discovery doc. This field should only be used
   * to define system APIs in ESF.
   */
  core.List<Type> systemTypes;
  /** The product title associated with this service. */
  core.String title;
  /**
   * A list of all proto message types included in this API service.
   * Types referenced directly or indirectly by the `apis` are
   * automatically included.  Messages which are not referenced but
   * shall be included, such as types used by the `google.protobuf.Any` type,
   * should be listed here by name. Example:
   *
   *     types:
   *     - name: google.protobuf.Int32
   */
  core.List<Type> types;
  /** Configuration controlling usage of this service. */
  Usage usage;
  /** API visibility configuration. */
  Visibility visibility;

  Service();

  Service.fromJson(core.Map _json) {
    if (_json.containsKey("apis")) {
      apis = _json["apis"].map((value) => new Api.fromJson(value)).toList();
    }
    if (_json.containsKey("authentication")) {
      authentication = new Authentication.fromJson(_json["authentication"]);
    }
    if (_json.containsKey("backend")) {
      backend = new Backend.fromJson(_json["backend"]);
    }
    if (_json.containsKey("configVersion")) {
      configVersion = _json["configVersion"];
    }
    if (_json.containsKey("context")) {
      context = new Context.fromJson(_json["context"]);
    }
    if (_json.containsKey("control")) {
      control = new Control.fromJson(_json["control"]);
    }
    if (_json.containsKey("customError")) {
      customError = new CustomError.fromJson(_json["customError"]);
    }
    if (_json.containsKey("documentation")) {
      documentation = new Documentation.fromJson(_json["documentation"]);
    }
    if (_json.containsKey("endpoints")) {
      endpoints = _json["endpoints"].map((value) => new Endpoint.fromJson(value)).toList();
    }
    if (_json.containsKey("enums")) {
      enums = _json["enums"].map((value) => new Enum.fromJson(value)).toList();
    }
    if (_json.containsKey("experimental")) {
      experimental = new Experimental.fromJson(_json["experimental"]);
    }
    if (_json.containsKey("http")) {
      http = new Http.fromJson(_json["http"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("logging")) {
      logging = new Logging.fromJson(_json["logging"]);
    }
    if (_json.containsKey("logs")) {
      logs = _json["logs"].map((value) => new LogDescriptor.fromJson(value)).toList();
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"].map((value) => new MetricDescriptor.fromJson(value)).toList();
    }
    if (_json.containsKey("monitoredResources")) {
      monitoredResources = _json["monitoredResources"].map((value) => new MonitoredResourceDescriptor.fromJson(value)).toList();
    }
    if (_json.containsKey("monitoring")) {
      monitoring = new Monitoring.fromJson(_json["monitoring"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("producerProjectId")) {
      producerProjectId = _json["producerProjectId"];
    }
    if (_json.containsKey("systemParameters")) {
      systemParameters = new SystemParameters.fromJson(_json["systemParameters"]);
    }
    if (_json.containsKey("systemTypes")) {
      systemTypes = _json["systemTypes"].map((value) => new Type.fromJson(value)).toList();
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("types")) {
      types = _json["types"].map((value) => new Type.fromJson(value)).toList();
    }
    if (_json.containsKey("usage")) {
      usage = new Usage.fromJson(_json["usage"]);
    }
    if (_json.containsKey("visibility")) {
      visibility = new Visibility.fromJson(_json["visibility"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (apis != null) {
      _json["apis"] = apis.map((value) => (value).toJson()).toList();
    }
    if (authentication != null) {
      _json["authentication"] = (authentication).toJson();
    }
    if (backend != null) {
      _json["backend"] = (backend).toJson();
    }
    if (configVersion != null) {
      _json["configVersion"] = configVersion;
    }
    if (context != null) {
      _json["context"] = (context).toJson();
    }
    if (control != null) {
      _json["control"] = (control).toJson();
    }
    if (customError != null) {
      _json["customError"] = (customError).toJson();
    }
    if (documentation != null) {
      _json["documentation"] = (documentation).toJson();
    }
    if (endpoints != null) {
      _json["endpoints"] = endpoints.map((value) => (value).toJson()).toList();
    }
    if (enums != null) {
      _json["enums"] = enums.map((value) => (value).toJson()).toList();
    }
    if (experimental != null) {
      _json["experimental"] = (experimental).toJson();
    }
    if (http != null) {
      _json["http"] = (http).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (logging != null) {
      _json["logging"] = (logging).toJson();
    }
    if (logs != null) {
      _json["logs"] = logs.map((value) => (value).toJson()).toList();
    }
    if (metrics != null) {
      _json["metrics"] = metrics.map((value) => (value).toJson()).toList();
    }
    if (monitoredResources != null) {
      _json["monitoredResources"] = monitoredResources.map((value) => (value).toJson()).toList();
    }
    if (monitoring != null) {
      _json["monitoring"] = (monitoring).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (producerProjectId != null) {
      _json["producerProjectId"] = producerProjectId;
    }
    if (systemParameters != null) {
      _json["systemParameters"] = (systemParameters).toJson();
    }
    if (systemTypes != null) {
      _json["systemTypes"] = systemTypes.map((value) => (value).toJson()).toList();
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (types != null) {
      _json["types"] = types.map((value) => (value).toJson()).toList();
    }
    if (usage != null) {
      _json["usage"] = (usage).toJson();
    }
    if (visibility != null) {
      _json["visibility"] = (visibility).toJson();
    }
    return _json;
  }
}

/** Request message for `SetIamPolicy` method. */
class SetIamPolicyRequest {
  /**
   * REQUIRED: The complete policy to be applied to the `resource`. The size of
   * the policy is limited to a few 10s of KB. An empty policy is a
   * valid policy but certain Cloud Platform services (such as Projects)
   * might reject them.
   */
  Policy policy;
  /**
   * OPTIONAL: A FieldMask specifying which fields of the policy to modify. Only
   * the fields in the mask will be modified. If no mask is provided, a default
   * mask is used:
   * paths: "bindings, etag"
   * This field is only used by Cloud IAM.
   */
  core.String updateMask;

  SetIamPolicyRequest();

  SetIamPolicyRequest.fromJson(core.Map _json) {
    if (_json.containsKey("policy")) {
      policy = new Policy.fromJson(_json["policy"]);
    }
    if (_json.containsKey("updateMask")) {
      updateMask = _json["updateMask"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (policy != null) {
      _json["policy"] = (policy).toJson();
    }
    if (updateMask != null) {
      _json["updateMask"] = updateMask;
    }
    return _json;
  }
}

/**
 * `SourceContext` represents information about the source of a
 * protobuf element, like the file in which it is defined.
 */
class SourceContext {
  /**
   * The path-qualified name of the .proto file that contained the associated
   * protobuf element.  For example: `"google/protobuf/source_context.proto"`.
   */
  core.String fileName;

  SourceContext();

  SourceContext.fromJson(core.Map _json) {
    if (_json.containsKey("fileName")) {
      fileName = _json["fileName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fileName != null) {
      _json["fileName"] = fileName;
    }
    return _json;
  }
}

/**
 * The `Status` type defines a logical error model that is suitable for
 * different
 * programming environments, including REST APIs and RPC APIs. It is used by
 * [gRPC](https://github.com/grpc). The error model is designed to be:
 *
 * - Simple to use and understand for most users
 * - Flexible enough to meet unexpected needs
 *
 * # Overview
 *
 * The `Status` message contains three pieces of data: error code, error
 * message,
 * and error details. The error code should be an enum value of
 * google.rpc.Code, but it may accept additional error codes if needed.  The
 * error message should be a developer-facing English message that helps
 * developers *understand* and *resolve* the error. If a localized user-facing
 * error message is needed, put the localized message in the error details or
 * localize it in the client. The optional error details may contain arbitrary
 * information about the error. There is a predefined set of error detail types
 * in the package `google.rpc` which can be used for common error conditions.
 *
 * # Language mapping
 *
 * The `Status` message is the logical representation of the error model, but it
 * is not necessarily the actual wire format. When the `Status` message is
 * exposed in different client libraries and different wire protocols, it can be
 * mapped differently. For example, it will likely be mapped to some exceptions
 * in Java, but more likely mapped to some error codes in C.
 *
 * # Other uses
 *
 * The error model and the `Status` message can be used in a variety of
 * environments, either with or without APIs, to provide a
 * consistent developer experience across different environments.
 *
 * Example uses of this error model include:
 *
 * - Partial errors. If a service needs to return partial errors to the client,
 *     it may embed the `Status` in the normal response to indicate the partial
 *     errors.
 *
 * - Workflow errors. A typical workflow has multiple steps. Each step may
 *     have a `Status` message for error reporting purpose.
 *
 * - Batch operations. If a client uses batch request and batch response, the
 *     `Status` message should be used directly inside batch response, one for
 *     each error sub-response.
 *
 * - Asynchronous operations. If an API call embeds asynchronous operation
 *     results in its response, the status of those operations should be
 *     represented directly using the `Status` message.
 *
 * - Logging. If some API errors are stored in logs, the message `Status` could
 * be used directly after any stripping needed for security/privacy reasons.
 */
class Status {
  /** The status code, which should be an enum value of google.rpc.Code. */
  core.int code;
  /**
   * A list of messages that carry the error details.  There will be a
   * common set of message types for APIs to use.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Map<core.String, core.Object>> details;
  /**
   * A developer-facing error message, which should be in English. Any
   * user-facing error message should be localized and sent in the
   * google.rpc.Status.details field, or localized by the client.
   */
  core.String message;

  Status();

  Status.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("details")) {
      details = _json["details"];
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
    if (details != null) {
      _json["details"] = details;
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

/** Represents the status of one operation step. */
class Step {
  /** The short description of the step. */
  core.String description;
  /**
   * The status code.
   * Possible string values are:
   * - "STATUS_UNSPECIFIED" : Unspecifed code.
   * - "DONE" : The operation or step has completed without errors.
   * - "NOT_STARTED" : The operation or step has not started yet.
   * - "IN_PROGRESS" : The operation or step is in progress.
   * - "FAILED" : The operation or step has completed with errors.
   * - "CANCELLED" : The operation or step has completed with cancellation.
   */
  core.String status;

  Step();

  Step.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/** Request message for SubmitConfigSource method. */
class SubmitConfigSourceRequest {
  /** The source configuration for the service. */
  ConfigSource configSource;
  /**
   * Optional. If set, this will result in the generation of a
   * `google.api.Service` configuration based on the `ConfigSource` provided,
   * but the generated config and the sources will NOT be persisted.
   */
  core.bool validateOnly;

  SubmitConfigSourceRequest();

  SubmitConfigSourceRequest.fromJson(core.Map _json) {
    if (_json.containsKey("configSource")) {
      configSource = new ConfigSource.fromJson(_json["configSource"]);
    }
    if (_json.containsKey("validateOnly")) {
      validateOnly = _json["validateOnly"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (configSource != null) {
      _json["configSource"] = (configSource).toJson();
    }
    if (validateOnly != null) {
      _json["validateOnly"] = validateOnly;
    }
    return _json;
  }
}

/** Response message for SubmitConfigSource method. */
class SubmitConfigSourceResponse {
  /** The generated service configuration. */
  Service serviceConfig;

  SubmitConfigSourceResponse();

  SubmitConfigSourceResponse.fromJson(core.Map _json) {
    if (_json.containsKey("serviceConfig")) {
      serviceConfig = new Service.fromJson(_json["serviceConfig"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (serviceConfig != null) {
      _json["serviceConfig"] = (serviceConfig).toJson();
    }
    return _json;
  }
}

/**
 * Define a parameter's name and location. The parameter may be passed as either
 * an HTTP header or a URL query parameter, and if both are passed the behavior
 * is implementation-dependent.
 */
class SystemParameter {
  /**
   * Define the HTTP header name to use for the parameter. It is case
   * insensitive.
   */
  core.String httpHeader;
  /**
   * Define the name of the parameter, such as "api_key" . It is case sensitive.
   */
  core.String name;
  /**
   * Define the URL query parameter name to use for the parameter. It is case
   * sensitive.
   */
  core.String urlQueryParameter;

  SystemParameter();

  SystemParameter.fromJson(core.Map _json) {
    if (_json.containsKey("httpHeader")) {
      httpHeader = _json["httpHeader"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("urlQueryParameter")) {
      urlQueryParameter = _json["urlQueryParameter"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (httpHeader != null) {
      _json["httpHeader"] = httpHeader;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (urlQueryParameter != null) {
      _json["urlQueryParameter"] = urlQueryParameter;
    }
    return _json;
  }
}

/**
 * Define a system parameter rule mapping system parameter definitions to
 * methods.
 */
class SystemParameterRule {
  /**
   * Define parameters. Multiple names may be defined for a parameter.
   * For a given method call, only one of them should be used. If multiple
   * names are used the behavior is implementation-dependent.
   * If none of the specified names are present the behavior is
   * parameter-dependent.
   */
  core.List<SystemParameter> parameters;
  /**
   * Selects the methods to which this rule applies. Use '*' to indicate all
   * methods in all APIs.
   *
   * Refer to selector for syntax details.
   */
  core.String selector;

  SystemParameterRule();

  SystemParameterRule.fromJson(core.Map _json) {
    if (_json.containsKey("parameters")) {
      parameters = _json["parameters"].map((value) => new SystemParameter.fromJson(value)).toList();
    }
    if (_json.containsKey("selector")) {
      selector = _json["selector"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (parameters != null) {
      _json["parameters"] = parameters.map((value) => (value).toJson()).toList();
    }
    if (selector != null) {
      _json["selector"] = selector;
    }
    return _json;
  }
}

/**
 * ### System parameter configuration
 *
 * A system parameter is a special kind of parameter defined by the API
 * system, not by an individual API. It is typically mapped to an HTTP header
 * and/or a URL query parameter. This configuration specifies which methods
 * change the names of the system parameters.
 */
class SystemParameters {
  /**
   * Define system parameters.
   *
   * The parameters defined here will override the default parameters
   * implemented by the system. If this field is missing from the service
   * config, default system parameters will be used. Default system parameters
   * and names is implementation-dependent.
   *
   * Example: define api key for all methods
   *
   *     system_parameters
   *       rules:
   *         - selector: "*"
   *           parameters:
   *             - name: api_key
   *               url_query_parameter: api_key
   *
   *
   * Example: define 2 api key names for a specific method.
   *
   *     system_parameters
   *       rules:
   *         - selector: "/ListShelves"
   *           parameters:
   *             - name: api_key
   *               http_header: Api-Key1
   *             - name: api_key
   *               http_header: Api-Key2
   *
   * **NOTE:** All service configuration rules follow "last one wins" order.
   */
  core.List<SystemParameterRule> rules;

  SystemParameters();

  SystemParameters.fromJson(core.Map _json) {
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new SystemParameterRule.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Request message for `TestIamPermissions` method. */
class TestIamPermissionsRequest {
  /**
   * The set of permissions to check for the `resource`. Permissions with
   * wildcards (such as '*' or 'storage.*') are not allowed. For more
   * information see
   * [IAM Overview](https://cloud.google.com/iam/docs/overview#permissions).
   */
  core.List<core.String> permissions;

  TestIamPermissionsRequest();

  TestIamPermissionsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("permissions")) {
      permissions = _json["permissions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (permissions != null) {
      _json["permissions"] = permissions;
    }
    return _json;
  }
}

/** Response message for `TestIamPermissions` method. */
class TestIamPermissionsResponse {
  /**
   * A subset of `TestPermissionsRequest.permissions` that the caller is
   * allowed.
   */
  core.List<core.String> permissions;

  TestIamPermissionsResponse();

  TestIamPermissionsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("permissions")) {
      permissions = _json["permissions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (permissions != null) {
      _json["permissions"] = permissions;
    }
    return _json;
  }
}

/**
 * Strategy that specifies how Google Service Control should select
 * different
 * versions of service configurations based on traffic percentage.
 *
 * One example of how to gradually rollout a new service configuration using
 * this
 * strategy:
 * Day 1
 *
 *     Rollout {
 *       id: "example.googleapis.com/rollout_20160206"
 *       traffic_percent_strategy {
 *         percentages: {
 *           "example.googleapis.com/20160201": 70.00
 *           "example.googleapis.com/20160206": 30.00
 *         }
 *       }
 *     }
 *
 * Day 2
 *
 *     Rollout {
 *       id: "example.googleapis.com/rollout_20160207"
 *       traffic_percent_strategy: {
 *         percentages: {
 *           "example.googleapis.com/20160206": 100.00
 *         }
 *       }
 *     }
 */
class TrafficPercentStrategy {
  /**
   * Maps service configuration IDs to their corresponding traffic percentage.
   * Key is the service configuration ID, Value is the traffic percentage
   * which must be greater than 0.0 and the sum must equal to 100.0.
   */
  core.Map<core.String, core.double> percentages;

  TrafficPercentStrategy();

  TrafficPercentStrategy.fromJson(core.Map _json) {
    if (_json.containsKey("percentages")) {
      percentages = _json["percentages"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (percentages != null) {
      _json["percentages"] = percentages;
    }
    return _json;
  }
}

/** A protocol buffer message type. */
class Type {
  /** The list of fields. */
  core.List<Field> fields;
  /** The fully qualified message name. */
  core.String name;
  /** The list of types appearing in `oneof` definitions in this type. */
  core.List<core.String> oneofs;
  /** The protocol buffer options. */
  core.List<Option> options;
  /** The source context. */
  SourceContext sourceContext;
  /**
   * The source syntax.
   * Possible string values are:
   * - "SYNTAX_PROTO2" : Syntax `proto2`.
   * - "SYNTAX_PROTO3" : Syntax `proto3`.
   */
  core.String syntax;

  Type();

  Type.fromJson(core.Map _json) {
    if (_json.containsKey("fields")) {
      fields = _json["fields"].map((value) => new Field.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("oneofs")) {
      oneofs = _json["oneofs"];
    }
    if (_json.containsKey("options")) {
      options = _json["options"].map((value) => new Option.fromJson(value)).toList();
    }
    if (_json.containsKey("sourceContext")) {
      sourceContext = new SourceContext.fromJson(_json["sourceContext"]);
    }
    if (_json.containsKey("syntax")) {
      syntax = _json["syntax"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fields != null) {
      _json["fields"] = fields.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (oneofs != null) {
      _json["oneofs"] = oneofs;
    }
    if (options != null) {
      _json["options"] = options.map((value) => (value).toJson()).toList();
    }
    if (sourceContext != null) {
      _json["sourceContext"] = (sourceContext).toJson();
    }
    if (syntax != null) {
      _json["syntax"] = syntax;
    }
    return _json;
  }
}

/** Response message for UndeleteService method. */
class UndeleteServiceResponse {
  /** Revived service resource. */
  ManagedService service;

  UndeleteServiceResponse();

  UndeleteServiceResponse.fromJson(core.Map _json) {
    if (_json.containsKey("service")) {
      service = new ManagedService.fromJson(_json["service"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (service != null) {
      _json["service"] = (service).toJson();
    }
    return _json;
  }
}

/** Configuration controlling usage of a service. */
class Usage {
  /**
   * The full resource name of a channel used for sending notifications to the
   * service producer.
   *
   * Google Service Management currently only supports
   * [Google Cloud Pub/Sub](https://cloud.google.com/pubsub) as a notification
   * channel. To use Google Cloud Pub/Sub as the channel, this must be the name
   * of a Cloud Pub/Sub topic that uses the Cloud Pub/Sub topic name format
   * documented in https://cloud.google.com/pubsub/docs/overview.
   */
  core.String producerNotificationChannel;
  /**
   * Requirements that must be satisfied before a consumer project can use the
   * service. Each requirement is of the form <service.name>/<requirement-id>;
   * for example 'serviceusage.googleapis.com/billing-enabled'.
   */
  core.List<core.String> requirements;
  /**
   * A list of usage rules that apply to individual API methods.
   *
   * **NOTE:** All service configuration rules follow "last one wins" order.
   */
  core.List<UsageRule> rules;

  Usage();

  Usage.fromJson(core.Map _json) {
    if (_json.containsKey("producerNotificationChannel")) {
      producerNotificationChannel = _json["producerNotificationChannel"];
    }
    if (_json.containsKey("requirements")) {
      requirements = _json["requirements"];
    }
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new UsageRule.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (producerNotificationChannel != null) {
      _json["producerNotificationChannel"] = producerNotificationChannel;
    }
    if (requirements != null) {
      _json["requirements"] = requirements;
    }
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Usage configuration rules for the service.
 *
 * NOTE: Under development.
 *
 *
 * Use this rule to configure unregistered calls for the service. Unregistered
 * calls are calls that do not contain consumer project identity.
 * (Example: calls that do not contain an API key).
 * By default, API methods do not allow unregistered calls, and each method call
 * must be identified by a consumer project identity. Use this rule to
 * allow/disallow unregistered calls.
 *
 * Example of an API that wants to allow unregistered calls for entire service.
 *
 *     usage:
 *       rules:
 *       - selector: "*"
 *         allow_unregistered_calls: true
 *
 * Example of a method that wants to allow unregistered calls.
 *
 *     usage:
 *       rules:
 *       - selector: "google.example.library.v1.LibraryService.CreateBook"
 *         allow_unregistered_calls: true
 */
class UsageRule {
  /** True, if the method allows unregistered calls; false otherwise. */
  core.bool allowUnregisteredCalls;
  /**
   * Selects the methods to which this rule applies. Use '*' to indicate all
   * methods in all APIs.
   *
   * Refer to selector for syntax details.
   */
  core.String selector;

  UsageRule();

  UsageRule.fromJson(core.Map _json) {
    if (_json.containsKey("allowUnregisteredCalls")) {
      allowUnregisteredCalls = _json["allowUnregisteredCalls"];
    }
    if (_json.containsKey("selector")) {
      selector = _json["selector"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowUnregisteredCalls != null) {
      _json["allowUnregisteredCalls"] = allowUnregisteredCalls;
    }
    if (selector != null) {
      _json["selector"] = selector;
    }
    return _json;
  }
}

/**
 * `Visibility` defines restrictions for the visibility of service
 * elements.  Restrictions are specified using visibility labels
 * (e.g., TRUSTED_TESTER) that are elsewhere linked to users and projects.
 *
 * Users and projects can have access to more than one visibility label. The
 * effective visibility for multiple labels is the union of each label's
 * elements, plus any unrestricted elements.
 *
 * If an element and its parents have no restrictions, visibility is
 * unconditionally granted.
 *
 * Example:
 *
 *     visibility:
 *       rules:
 *       - selector: google.calendar.Calendar.EnhancedSearch
 *         restriction: TRUSTED_TESTER
 *       - selector: google.calendar.Calendar.Delegate
 *         restriction: GOOGLE_INTERNAL
 *
 * Here, all methods are publicly visible except for the restricted methods
 * EnhancedSearch and Delegate.
 */
class Visibility {
  /**
   * A list of visibility rules that apply to individual API elements.
   *
   * **NOTE:** All service configuration rules follow "last one wins" order.
   */
  core.List<VisibilityRule> rules;

  Visibility();

  Visibility.fromJson(core.Map _json) {
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new VisibilityRule.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * A visibility rule provides visibility configuration for an individual API
 * element.
 */
class VisibilityRule {
  /**
   * A comma-separated list of visibility labels that apply to the `selector`.
   * Any of the listed labels can be used to grant the visibility.
   *
   * If a rule has multiple labels, removing one of the labels but not all of
   * them can break clients.
   *
   * Example:
   *
   *     visibility:
   *       rules:
   *       - selector: google.calendar.Calendar.EnhancedSearch
   *         restriction: GOOGLE_INTERNAL, TRUSTED_TESTER
   *
   * Removing GOOGLE_INTERNAL from this restriction will break clients that
   * rely on this method and only had access to it through GOOGLE_INTERNAL.
   */
  core.String restriction;
  /**
   * Selects methods, messages, fields, enums, etc. to which this rule applies.
   *
   * Refer to selector for syntax details.
   */
  core.String selector;

  VisibilityRule();

  VisibilityRule.fromJson(core.Map _json) {
    if (_json.containsKey("restriction")) {
      restriction = _json["restriction"];
    }
    if (_json.containsKey("selector")) {
      selector = _json["selector"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (restriction != null) {
      _json["restriction"] = restriction;
    }
    if (selector != null) {
      _json["selector"] = selector;
    }
    return _json;
  }
}
