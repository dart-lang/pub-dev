// This is a generated file (see the discoveryapis_generator project).

library googleapis.deploymentmanager.v2;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client deploymentmanager/v2';

/**
 * Declares, configures, and deploys complex solutions on Google Cloud Platform.
 */
class DeploymentmanagerApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /** View your data across Google Cloud Platform services */
  static const CloudPlatformReadOnlyScope = "https://www.googleapis.com/auth/cloud-platform.read-only";

  /**
   * View and manage your Google Cloud Platform management resources and
   * deployment status information
   */
  static const NdevCloudmanScope = "https://www.googleapis.com/auth/ndev.cloudman";

  /**
   * View your Google Cloud Platform management resources and deployment status
   * information
   */
  static const NdevCloudmanReadonlyScope = "https://www.googleapis.com/auth/ndev.cloudman.readonly";


  final commons.ApiRequester _requester;

  DeploymentsResourceApi get deployments => new DeploymentsResourceApi(_requester);
  ManifestsResourceApi get manifests => new ManifestsResourceApi(_requester);
  OperationsResourceApi get operations => new OperationsResourceApi(_requester);
  ResourcesResourceApi get resources => new ResourcesResourceApi(_requester);
  TypesResourceApi get types => new TypesResourceApi(_requester);

  DeploymentmanagerApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "deploymentmanager/v2/projects/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class DeploymentsResourceApi {
  final commons.ApiRequester _requester;

  DeploymentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Cancels and removes the preview currently associated with the deployment.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [deployment] - The name of the deployment for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> cancelPreview(DeploymentsCancelPreviewRequest request, core.String project, core.String deployment) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (deployment == null) {
      throw new core.ArgumentError("Parameter deployment is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$deployment') + '/cancelPreview';

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
   * Deletes a deployment and all of the resources in the deployment.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [deployment] - The name of the deployment for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
   *
   * [deletePolicy] - Sets the policy to use for deleting resources.
   * Possible string values are:
   * - "ABANDON"
   * - "DELETE"
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> delete(core.String project, core.String deployment, {core.String deletePolicy}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (deployment == null) {
      throw new core.ArgumentError("Parameter deployment is required.");
    }
    if (deletePolicy != null) {
      _queryParams["deletePolicy"] = [deletePolicy];
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$deployment');

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
   * Gets information about a specific deployment.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [deployment] - The name of the deployment for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
   *
   * Completes with a [Deployment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Deployment> get(core.String project, core.String deployment) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (deployment == null) {
      throw new core.ArgumentError("Parameter deployment is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$deployment');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Deployment.fromJson(data));
  }

  /**
   * Gets the access control policy for a resource. May be empty if no such
   * policy or resource exists.
   *
   * Request parameters:
   *
   * [project] - Project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z0-9](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [resource] - Name of the resource for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9_]{0,61}[a-z0-9])?".
   *
   * Completes with a [Policy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Policy> getIamPolicy(core.String project, core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$resource') + '/getIamPolicy';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Policy.fromJson(data));
  }

  /**
   * Creates a deployment and all of the resources described by the deployment
   * manifest.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [preview] - If set to true, creates a deployment and creates "shell"
   * resources but does not actually instantiate these resources. This allows
   * you to preview what your deployment looks like. After previewing a
   * deployment, you can deploy your resources by making a request with the
   * update() method or you can use the cancelPreview() method to cancel the
   * preview altogether. Note that the deployment will still exist after you
   * cancel the preview and you must separately delete this deployment if you
   * want to remove it.
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> insert(Deployment request, core.String project, {core.bool preview}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (preview != null) {
      _queryParams["preview"] = ["${preview}"];
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments';

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
   * Lists all deployments for a given project.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [filter] - Sets a filter expression for filtering listed resources, in the
   * form filter={expression}. Your {expression} must be in the format:
   * field_name comparison_string literal_string.
   *
   * The field_name is the name of the field you want to compare. Only atomic
   * field types are supported (string, number, boolean). The comparison_string
   * must be either eq (equals) or ne (not equals). The literal_string is the
   * string value to filter to. The literal value must be valid for the type of
   * field you are filtering by (string, number, boolean). For string fields,
   * the literal value is interpreted as a regular expression using RE2 syntax.
   * The literal value must match the entire field.
   *
   * For example, to filter for instances that do not have a name of
   * example-instance, you would use filter=name ne example-instance.
   *
   * You can filter on nested fields. For example, you could filter on instances
   * that have set the scheduling.automaticRestart field to true. Use filtering
   * on nested fields to take advantage of labels to organize and search for
   * results based on label values.
   *
   * To filter on multiple expressions, provide each separate expression within
   * parentheses. For example, (scheduling.automaticRestart eq true) (zone eq
   * us-central1-f). Multiple expressions are treated as AND expressions,
   * meaning that resources must match all expressions to pass the filters.
   *
   * [maxResults] - The maximum number of results per page that should be
   * returned. If the number of available results is larger than maxResults,
   * Compute Engine returns a nextPageToken that can be used to get the next
   * page of results in subsequent list requests. Acceptable values are 0 to
   * 500, inclusive. (Default: 500)
   *
   * [orderBy] - Sorts list results by a certain order. By default, results are
   * returned in alphanumerical order based on the resource name.
   *
   * You can also sort results in descending order based on the creation
   * timestamp using orderBy="creationTimestamp desc". This sorts results based
   * on the creationTimestamp field in reverse chronological order (newest
   * result first). Use this to sort resources like operations so that the
   * newest operation is returned first.
   *
   * Currently, only sorting by name or creationTimestamp desc is supported.
   *
   * [pageToken] - Specifies a page token to use. Set pageToken to the
   * nextPageToken returned by a previous list request to get the next page of
   * results.
   *
   * Completes with a [DeploymentsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DeploymentsListResponse> list(core.String project, {core.String filter, core.int maxResults, core.String orderBy, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
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

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DeploymentsListResponse.fromJson(data));
  }

  /**
   * Updates a deployment and all of the resources described by the deployment
   * manifest. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [deployment] - The name of the deployment for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
   *
   * [createPolicy] - Sets the policy to use for creating new resources.
   * Possible string values are:
   * - "ACQUIRE"
   * - "CREATE_OR_ACQUIRE"
   *
   * [deletePolicy] - Sets the policy to use for deleting resources.
   * Possible string values are:
   * - "ABANDON"
   * - "DELETE"
   *
   * [preview] - If set to true, updates the deployment and creates and updates
   * the "shell" resources but does not actually alter or instantiate these
   * resources. This allows you to preview what your deployment will look like.
   * You can use this intent to preview how an update would affect your
   * deployment. You must provide a target.config with a configuration if this
   * is set to true. After previewing a deployment, you can deploy your
   * resources by making a request with the update() or you can cancelPreview()
   * to remove the preview altogether. Note that the deployment will still exist
   * after you cancel the preview and you must separately delete this deployment
   * if you want to remove it.
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> patch(Deployment request, core.String project, core.String deployment, {core.String createPolicy, core.String deletePolicy, core.bool preview}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (deployment == null) {
      throw new core.ArgumentError("Parameter deployment is required.");
    }
    if (createPolicy != null) {
      _queryParams["createPolicy"] = [createPolicy];
    }
    if (deletePolicy != null) {
      _queryParams["deletePolicy"] = [deletePolicy];
    }
    if (preview != null) {
      _queryParams["preview"] = ["${preview}"];
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$deployment');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /**
   * Sets the access control policy on the specified resource. Replaces any
   * existing policy.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - Project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z0-9](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [resource] - Name of the resource for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9_]{0,61}[a-z0-9])?".
   *
   * Completes with a [Policy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Policy> setIamPolicy(Policy request, core.String project, core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$resource') + '/setIamPolicy';

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
   * Stops an ongoing operation. This does not roll back any work that has
   * already been completed, but prevents any new work from being started.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [deployment] - The name of the deployment for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> stop(DeploymentsStopRequest request, core.String project, core.String deployment) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (deployment == null) {
      throw new core.ArgumentError("Parameter deployment is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$deployment') + '/stop';

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
   * Returns permissions that a caller has on the specified resource.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - Project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z0-9](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [resource] - Name of the resource for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9_]{0,61}[a-z0-9])?".
   *
   * Completes with a [TestPermissionsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TestPermissionsResponse> testIamPermissions(TestPermissionsRequest request, core.String project, core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$resource') + '/testIamPermissions';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TestPermissionsResponse.fromJson(data));
  }

  /**
   * Updates a deployment and all of the resources described by the deployment
   * manifest.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [deployment] - The name of the deployment for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
   *
   * [createPolicy] - Sets the policy to use for creating new resources.
   * Possible string values are:
   * - "ACQUIRE"
   * - "CREATE_OR_ACQUIRE"
   *
   * [deletePolicy] - Sets the policy to use for deleting resources.
   * Possible string values are:
   * - "ABANDON"
   * - "DELETE"
   *
   * [preview] - If set to true, updates the deployment and creates and updates
   * the "shell" resources but does not actually alter or instantiate these
   * resources. This allows you to preview what your deployment will look like.
   * You can use this intent to preview how an update would affect your
   * deployment. You must provide a target.config with a configuration if this
   * is set to true. After previewing a deployment, you can deploy your
   * resources by making a request with the update() or you can cancelPreview()
   * to remove the preview altogether. Note that the deployment will still exist
   * after you cancel the preview and you must separately delete this deployment
   * if you want to remove it.
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> update(Deployment request, core.String project, core.String deployment, {core.String createPolicy, core.String deletePolicy, core.bool preview}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (deployment == null) {
      throw new core.ArgumentError("Parameter deployment is required.");
    }
    if (createPolicy != null) {
      _queryParams["createPolicy"] = [createPolicy];
    }
    if (deletePolicy != null) {
      _queryParams["deletePolicy"] = [deletePolicy];
    }
    if (preview != null) {
      _queryParams["preview"] = ["${preview}"];
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$deployment');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

}


class ManifestsResourceApi {
  final commons.ApiRequester _requester;

  ManifestsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets information about a specific manifest.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [deployment] - The name of the deployment for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
   *
   * [manifest] - The name of the manifest for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
   *
   * Completes with a [Manifest].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Manifest> get(core.String project, core.String deployment, core.String manifest) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (deployment == null) {
      throw new core.ArgumentError("Parameter deployment is required.");
    }
    if (manifest == null) {
      throw new core.ArgumentError("Parameter manifest is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$deployment') + '/manifests/' + commons.Escaper.ecapeVariable('$manifest');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Manifest.fromJson(data));
  }

  /**
   * Lists all manifests for a given deployment.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [deployment] - The name of the deployment for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
   *
   * [filter] - Sets a filter expression for filtering listed resources, in the
   * form filter={expression}. Your {expression} must be in the format:
   * field_name comparison_string literal_string.
   *
   * The field_name is the name of the field you want to compare. Only atomic
   * field types are supported (string, number, boolean). The comparison_string
   * must be either eq (equals) or ne (not equals). The literal_string is the
   * string value to filter to. The literal value must be valid for the type of
   * field you are filtering by (string, number, boolean). For string fields,
   * the literal value is interpreted as a regular expression using RE2 syntax.
   * The literal value must match the entire field.
   *
   * For example, to filter for instances that do not have a name of
   * example-instance, you would use filter=name ne example-instance.
   *
   * You can filter on nested fields. For example, you could filter on instances
   * that have set the scheduling.automaticRestart field to true. Use filtering
   * on nested fields to take advantage of labels to organize and search for
   * results based on label values.
   *
   * To filter on multiple expressions, provide each separate expression within
   * parentheses. For example, (scheduling.automaticRestart eq true) (zone eq
   * us-central1-f). Multiple expressions are treated as AND expressions,
   * meaning that resources must match all expressions to pass the filters.
   *
   * [maxResults] - The maximum number of results per page that should be
   * returned. If the number of available results is larger than maxResults,
   * Compute Engine returns a nextPageToken that can be used to get the next
   * page of results in subsequent list requests. Acceptable values are 0 to
   * 500, inclusive. (Default: 500)
   *
   * [orderBy] - Sorts list results by a certain order. By default, results are
   * returned in alphanumerical order based on the resource name.
   *
   * You can also sort results in descending order based on the creation
   * timestamp using orderBy="creationTimestamp desc". This sorts results based
   * on the creationTimestamp field in reverse chronological order (newest
   * result first). Use this to sort resources like operations so that the
   * newest operation is returned first.
   *
   * Currently, only sorting by name or creationTimestamp desc is supported.
   *
   * [pageToken] - Specifies a page token to use. Set pageToken to the
   * nextPageToken returned by a previous list request to get the next page of
   * results.
   *
   * Completes with a [ManifestsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ManifestsListResponse> list(core.String project, core.String deployment, {core.String filter, core.int maxResults, core.String orderBy, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (deployment == null) {
      throw new core.ArgumentError("Parameter deployment is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
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

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$deployment') + '/manifests';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ManifestsListResponse.fromJson(data));
  }

}


class OperationsResourceApi {
  final commons.ApiRequester _requester;

  OperationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets information about a specific operation.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [operation] - The name of the operation for this request.
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> get(core.String project, core.String operation) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (operation == null) {
      throw new core.ArgumentError("Parameter operation is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/operations/' + commons.Escaper.ecapeVariable('$operation');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /**
   * Lists all operations for a project.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [filter] - Sets a filter expression for filtering listed resources, in the
   * form filter={expression}. Your {expression} must be in the format:
   * field_name comparison_string literal_string.
   *
   * The field_name is the name of the field you want to compare. Only atomic
   * field types are supported (string, number, boolean). The comparison_string
   * must be either eq (equals) or ne (not equals). The literal_string is the
   * string value to filter to. The literal value must be valid for the type of
   * field you are filtering by (string, number, boolean). For string fields,
   * the literal value is interpreted as a regular expression using RE2 syntax.
   * The literal value must match the entire field.
   *
   * For example, to filter for instances that do not have a name of
   * example-instance, you would use filter=name ne example-instance.
   *
   * You can filter on nested fields. For example, you could filter on instances
   * that have set the scheduling.automaticRestart field to true. Use filtering
   * on nested fields to take advantage of labels to organize and search for
   * results based on label values.
   *
   * To filter on multiple expressions, provide each separate expression within
   * parentheses. For example, (scheduling.automaticRestart eq true) (zone eq
   * us-central1-f). Multiple expressions are treated as AND expressions,
   * meaning that resources must match all expressions to pass the filters.
   *
   * [maxResults] - The maximum number of results per page that should be
   * returned. If the number of available results is larger than maxResults,
   * Compute Engine returns a nextPageToken that can be used to get the next
   * page of results in subsequent list requests. Acceptable values are 0 to
   * 500, inclusive. (Default: 500)
   *
   * [orderBy] - Sorts list results by a certain order. By default, results are
   * returned in alphanumerical order based on the resource name.
   *
   * You can also sort results in descending order based on the creation
   * timestamp using orderBy="creationTimestamp desc". This sorts results based
   * on the creationTimestamp field in reverse chronological order (newest
   * result first). Use this to sort resources like operations so that the
   * newest operation is returned first.
   *
   * Currently, only sorting by name or creationTimestamp desc is supported.
   *
   * [pageToken] - Specifies a page token to use. Set pageToken to the
   * nextPageToken returned by a previous list request to get the next page of
   * results.
   *
   * Completes with a [OperationsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OperationsListResponse> list(core.String project, {core.String filter, core.int maxResults, core.String orderBy, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
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

    _url = commons.Escaper.ecapeVariable('$project') + '/global/operations';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OperationsListResponse.fromJson(data));
  }

}


class ResourcesResourceApi {
  final commons.ApiRequester _requester;

  ResourcesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets information about a single resource.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [deployment] - The name of the deployment for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
   *
   * [resource] - The name of the resource for this request.
   *
   * Completes with a [Resource].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Resource> get(core.String project, core.String deployment, core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (deployment == null) {
      throw new core.ArgumentError("Parameter deployment is required.");
    }
    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$deployment') + '/resources/' + commons.Escaper.ecapeVariable('$resource');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Resource.fromJson(data));
  }

  /**
   * Lists all resources in a given deployment.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [deployment] - The name of the deployment for this request.
   * Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
   *
   * [filter] - Sets a filter expression for filtering listed resources, in the
   * form filter={expression}. Your {expression} must be in the format:
   * field_name comparison_string literal_string.
   *
   * The field_name is the name of the field you want to compare. Only atomic
   * field types are supported (string, number, boolean). The comparison_string
   * must be either eq (equals) or ne (not equals). The literal_string is the
   * string value to filter to. The literal value must be valid for the type of
   * field you are filtering by (string, number, boolean). For string fields,
   * the literal value is interpreted as a regular expression using RE2 syntax.
   * The literal value must match the entire field.
   *
   * For example, to filter for instances that do not have a name of
   * example-instance, you would use filter=name ne example-instance.
   *
   * You can filter on nested fields. For example, you could filter on instances
   * that have set the scheduling.automaticRestart field to true. Use filtering
   * on nested fields to take advantage of labels to organize and search for
   * results based on label values.
   *
   * To filter on multiple expressions, provide each separate expression within
   * parentheses. For example, (scheduling.automaticRestart eq true) (zone eq
   * us-central1-f). Multiple expressions are treated as AND expressions,
   * meaning that resources must match all expressions to pass the filters.
   *
   * [maxResults] - The maximum number of results per page that should be
   * returned. If the number of available results is larger than maxResults,
   * Compute Engine returns a nextPageToken that can be used to get the next
   * page of results in subsequent list requests. Acceptable values are 0 to
   * 500, inclusive. (Default: 500)
   *
   * [orderBy] - Sorts list results by a certain order. By default, results are
   * returned in alphanumerical order based on the resource name.
   *
   * You can also sort results in descending order based on the creation
   * timestamp using orderBy="creationTimestamp desc". This sorts results based
   * on the creationTimestamp field in reverse chronological order (newest
   * result first). Use this to sort resources like operations so that the
   * newest operation is returned first.
   *
   * Currently, only sorting by name or creationTimestamp desc is supported.
   *
   * [pageToken] - Specifies a page token to use. Set pageToken to the
   * nextPageToken returned by a previous list request to get the next page of
   * results.
   *
   * Completes with a [ResourcesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ResourcesListResponse> list(core.String project, core.String deployment, {core.String filter, core.int maxResults, core.String orderBy, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (deployment == null) {
      throw new core.ArgumentError("Parameter deployment is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
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

    _url = commons.Escaper.ecapeVariable('$project') + '/global/deployments/' + commons.Escaper.ecapeVariable('$deployment') + '/resources';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ResourcesListResponse.fromJson(data));
  }

}


class TypesResourceApi {
  final commons.ApiRequester _requester;

  TypesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists all resource types for Deployment Manager.
   *
   * Request parameters:
   *
   * [project] - The project ID for this request.
   * Value must have pattern
   * "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
   *
   * [filter] - Sets a filter expression for filtering listed resources, in the
   * form filter={expression}. Your {expression} must be in the format:
   * field_name comparison_string literal_string.
   *
   * The field_name is the name of the field you want to compare. Only atomic
   * field types are supported (string, number, boolean). The comparison_string
   * must be either eq (equals) or ne (not equals). The literal_string is the
   * string value to filter to. The literal value must be valid for the type of
   * field you are filtering by (string, number, boolean). For string fields,
   * the literal value is interpreted as a regular expression using RE2 syntax.
   * The literal value must match the entire field.
   *
   * For example, to filter for instances that do not have a name of
   * example-instance, you would use filter=name ne example-instance.
   *
   * You can filter on nested fields. For example, you could filter on instances
   * that have set the scheduling.automaticRestart field to true. Use filtering
   * on nested fields to take advantage of labels to organize and search for
   * results based on label values.
   *
   * To filter on multiple expressions, provide each separate expression within
   * parentheses. For example, (scheduling.automaticRestart eq true) (zone eq
   * us-central1-f). Multiple expressions are treated as AND expressions,
   * meaning that resources must match all expressions to pass the filters.
   *
   * [maxResults] - The maximum number of results per page that should be
   * returned. If the number of available results is larger than maxResults,
   * Compute Engine returns a nextPageToken that can be used to get the next
   * page of results in subsequent list requests. Acceptable values are 0 to
   * 500, inclusive. (Default: 500)
   *
   * [orderBy] - Sorts list results by a certain order. By default, results are
   * returned in alphanumerical order based on the resource name.
   *
   * You can also sort results in descending order based on the creation
   * timestamp using orderBy="creationTimestamp desc". This sorts results based
   * on the creationTimestamp field in reverse chronological order (newest
   * result first). Use this to sort resources like operations so that the
   * newest operation is returned first.
   *
   * Currently, only sorting by name or creationTimestamp desc is supported.
   *
   * [pageToken] - Specifies a page token to use. Set pageToken to the
   * nextPageToken returned by a previous list request to get the next page of
   * results.
   *
   * Completes with a [TypesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TypesListResponse> list(core.String project, {core.String filter, core.int maxResults, core.String orderBy, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
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

    _url = commons.Escaper.ecapeVariable('$project') + '/global/types';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TypesListResponse.fromJson(data));
  }

}



/**
 * Specifies the audit configuration for a service. It consists of which
 * permission types are logged, and what identities, if any, are exempted from
 * logging. An AuditConifg must have one or more AuditLogConfigs.
 *
 * If there are AuditConfigs for both `allServices` and a specific service, the
 * union of the two AuditConfigs is used for that service: the log_types
 * specified in each AuditConfig are enabled, and the exempted_members in each
 * AuditConfig are exempted. Example Policy with multiple AuditConfigs: {
 * "audit_configs": [ { "service": "allServices" "audit_log_configs": [ {
 * "log_type": "DATA_READ", "exempted_members": [ "user:foo@gmail.com" ] }, {
 * "log_type": "DATA_WRITE", }, { "log_type": "ADMIN_READ", } ] }, { "service":
 * "fooservice@googleapis.com" "audit_log_configs": [ { "log_type": "DATA_READ",
 * }, { "log_type": "DATA_WRITE", "exempted_members": [ "user:bar@gmail.com" ] }
 * ] } ] } For fooservice, this policy enables DATA_READ, DATA_WRITE and
 * ADMIN_READ logging. It also exempts foo@gmail.com from DATA_READ logging, and
 * bar@gmail.com from DATA_WRITE logging.
 */
class AuditConfig {
  /** The configuration for logging of each type of permission. */
  core.List<AuditLogConfig> auditLogConfigs;
  core.List<core.String> exemptedMembers;
  /**
   * Specifies a service that will be enabled for audit logging. For example,
   * `resourcemanager`, `storage`, `compute`. `allServices` is a special value
   * that covers all services.
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
 * Provides the configuration for logging a type of permissions. Example:
 *
 * { "audit_log_configs": [ { "log_type": "DATA_READ", "exempted_members": [
 * "user:foo@gmail.com" ] }, { "log_type": "DATA_WRITE", } ] }
 *
 * This enables 'DATA_READ' and 'DATA_WRITE' logging, while exempting
 * foo@gmail.com from DATA_READ logging.
 */
class AuditLogConfig {
  /**
   * Specifies the identities that do not cause logging for this type of
   * permission. Follows the same format of [Binding.members][].
   */
  core.List<core.String> exemptedMembers;
  /** The log type that this config enables. */
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

/** Associates `members` with a `role`. */
class Binding {
  /**
   * Specifies the identities requesting access for a Cloud Platform resource.
   * `members` can have the following values:
   *
   * * `allUsers`: A special identifier that represents anyone who is on the
   * internet; with or without a Google account.
   *
   * * `allAuthenticatedUsers`: A special identifier that represents anyone who
   * is authenticated with a Google account or a service account.
   *
   * * `user:{emailid}`: An email address that represents a specific Google
   * account. For example, `alice@gmail.com` or `joe@example.com`.
   *
   *
   *
   * * `serviceAccount:{emailid}`: An email address that represents a service
   * account. For example, `my-other-app@appspot.gserviceaccount.com`.
   *
   * * `group:{emailid}`: An email address that represents a Google group. For
   * example, `admins@example.com`.
   *
   * * `domain:{domain}`: A Google Apps domain name that represents all the
   * users of that domain. For example, `google.com` or `example.com`.
   */
  core.List<core.String> members;
  /**
   * Role that is assigned to `members`. For example, `roles/viewer`,
   * `roles/editor`, or `roles/owner`.
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

/** A condition to be met. */
class Condition {
  /** Trusted attributes supplied by the IAM system. */
  core.String iam;
  /** An operator to apply the subject with. */
  core.String op;
  /** Trusted attributes discharged by the service. */
  core.String svc;
  /**
   * Trusted attributes supplied by any service that owns resources and uses the
   * IAM system for access control.
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

class ConfigFile {
  /** The contents of the file. */
  core.String content;

  ConfigFile();

  ConfigFile.fromJson(core.Map _json) {
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (content != null) {
      _json["content"] = content;
    }
    return _json;
  }
}

class Deployment {
  /** An optional user-provided description of the deployment. */
  core.String description;
  /**
   * Provides a fingerprint to use in requests to modify a deployment, such as
   * update(), stop(), and cancelPreview() requests. A fingerprint is a randomly
   * generated value that must be provided with update(), stop(), and
   * cancelPreview() requests to perform optimistic locking. This ensures
   * optimistic concurrency so that only one request happens at a time.
   *
   * The fingerprint is initially generated by Deployment Manager and changes
   * after every request to modify data. To get the latest fingerprint value,
   * perform a get() request to a deployment.
   */
  core.String fingerprint;
  core.List<core.int> get fingerprintAsBytes {
    return convert.BASE64.decode(fingerprint);
  }

  void set fingerprintAsBytes(core.List<core.int> _bytes) {
    fingerprint = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * [Output Only] Unique identifier for the resource; defined by the server.
   */
  core.String id;
  /**
   * [Output Only] Timestamp when the deployment was created, in RFC3339 text
   * format .
   */
  core.String insertTime;
  /**
   * Map of labels; provided by the client when the resource is created or
   * updated. Specifically: Label keys must be between 1 and 63 characters long
   * and must conform to the following regular expression:
   * [a-z]([-a-z0-9]*[a-z0-9])? Label values must be between 0 and 63 characters
   * long and must conform to the regular expression
   * ([a-z]([-a-z0-9]*[a-z0-9])?)?
   */
  core.List<DeploymentLabelEntry> labels;
  /**
   * [Output Only] URL of the manifest representing the last manifest that was
   * successfully deployed.
   */
  core.String manifest;
  /**
   * Name of the resource; provided by the client when the resource is created.
   * The name must be 1-63 characters long, and comply with RFC1035.
   * Specifically, the name must be 1-63 characters long and match the regular
   * expression [a-z]([-a-z0-9]*[a-z0-9])? which means the first character must
   * be a lowercase letter, and all following characters must be a dash,
   * lowercase letter, or digit, except the last character, which cannot be a
   * dash.
   */
  core.String name;
  /**
   * [Output Only] The Operation that most recently ran, or is currently
   * running, on this deployment.
   */
  Operation operation;
  /** [Output Only] Self link for the deployment. */
  core.String selfLink;
  /**
   * [Input Only] The parameters that define your deployment, including the
   * deployment configuration and relevant templates.
   */
  TargetConfiguration target;
  /**
   * [Output Only] If Deployment Manager is currently updating or previewing an
   * update to this deployment, the updated configuration appears here.
   */
  DeploymentUpdate update;

  Deployment();

  Deployment.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("fingerprint")) {
      fingerprint = _json["fingerprint"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("insertTime")) {
      insertTime = _json["insertTime"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"].map((value) => new DeploymentLabelEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("manifest")) {
      manifest = _json["manifest"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("operation")) {
      operation = new Operation.fromJson(_json["operation"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("target")) {
      target = new TargetConfiguration.fromJson(_json["target"]);
    }
    if (_json.containsKey("update")) {
      update = new DeploymentUpdate.fromJson(_json["update"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (fingerprint != null) {
      _json["fingerprint"] = fingerprint;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (insertTime != null) {
      _json["insertTime"] = insertTime;
    }
    if (labels != null) {
      _json["labels"] = labels.map((value) => (value).toJson()).toList();
    }
    if (manifest != null) {
      _json["manifest"] = manifest;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (operation != null) {
      _json["operation"] = (operation).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (target != null) {
      _json["target"] = (target).toJson();
    }
    if (update != null) {
      _json["update"] = (update).toJson();
    }
    return _json;
  }
}

class DeploymentLabelEntry {
  core.String key;
  core.String value;

  DeploymentLabelEntry();

  DeploymentLabelEntry.fromJson(core.Map _json) {
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (key != null) {
      _json["key"] = key;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class DeploymentUpdate {
  /**
   * [Output Only] An optional user-provided description of the deployment after
   * the current update has been applied.
   */
  core.String description;
  /**
   * [Output Only] Map of labels; provided by the client when the resource is
   * created or updated. Specifically: Label keys must be between 1 and 63
   * characters long and must conform to the following regular expression:
   * [a-z]([-a-z0-9]*[a-z0-9])? Label values must be between 0 and 63 characters
   * long and must conform to the regular expression
   * ([a-z]([-a-z0-9]*[a-z0-9])?)?
   */
  core.List<DeploymentUpdateLabelEntry> labels;
  /**
   * [Output Only] URL of the manifest representing the update configuration of
   * this deployment.
   */
  core.String manifest;

  DeploymentUpdate();

  DeploymentUpdate.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"].map((value) => new DeploymentUpdateLabelEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("manifest")) {
      manifest = _json["manifest"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (labels != null) {
      _json["labels"] = labels.map((value) => (value).toJson()).toList();
    }
    if (manifest != null) {
      _json["manifest"] = manifest;
    }
    return _json;
  }
}

class DeploymentUpdateLabelEntry {
  core.String key;
  core.String value;

  DeploymentUpdateLabelEntry();

  DeploymentUpdateLabelEntry.fromJson(core.Map _json) {
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (key != null) {
      _json["key"] = key;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class DeploymentsCancelPreviewRequest {
  /**
   * Specifies a fingerprint for cancelPreview() requests. A fingerprint is a
   * randomly generated value that must be provided in cancelPreview() requests
   * to perform optimistic locking. This ensures optimistic concurrency so that
   * the deployment does not have conflicting requests (e.g. if someone attempts
   * to make a new update request while another user attempts to cancel a
   * preview, this would prevent one of the requests).
   *
   * The fingerprint is initially generated by Deployment Manager and changes
   * after every request to modify a deployment. To get the latest fingerprint
   * value, perform a get() request on the deployment.
   */
  core.String fingerprint;
  core.List<core.int> get fingerprintAsBytes {
    return convert.BASE64.decode(fingerprint);
  }

  void set fingerprintAsBytes(core.List<core.int> _bytes) {
    fingerprint = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  DeploymentsCancelPreviewRequest();

  DeploymentsCancelPreviewRequest.fromJson(core.Map _json) {
    if (_json.containsKey("fingerprint")) {
      fingerprint = _json["fingerprint"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fingerprint != null) {
      _json["fingerprint"] = fingerprint;
    }
    return _json;
  }
}

/**
 * A response containing a partial list of deployments and a page token used to
 * build the next request if the request has been truncated.
 */
class DeploymentsListResponse {
  /** [Output Only] The deployments contained in this response. */
  core.List<Deployment> deployments;
  /** [Output Only] A token used to continue a truncated list request. */
  core.String nextPageToken;

  DeploymentsListResponse();

  DeploymentsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("deployments")) {
      deployments = _json["deployments"].map((value) => new Deployment.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deployments != null) {
      _json["deployments"] = deployments.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

class DeploymentsStopRequest {
  /**
   * Specifies a fingerprint for stop() requests. A fingerprint is a randomly
   * generated value that must be provided in stop() requests to perform
   * optimistic locking. This ensures optimistic concurrency so that the
   * deployment does not have conflicting requests (e.g. if someone attempts to
   * make a new update request while another user attempts to stop an ongoing
   * update request, this would prevent a collision).
   *
   * The fingerprint is initially generated by Deployment Manager and changes
   * after every request to modify a deployment. To get the latest fingerprint
   * value, perform a get() request on the deployment.
   */
  core.String fingerprint;
  core.List<core.int> get fingerprintAsBytes {
    return convert.BASE64.decode(fingerprint);
  }

  void set fingerprintAsBytes(core.List<core.int> _bytes) {
    fingerprint = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  DeploymentsStopRequest();

  DeploymentsStopRequest.fromJson(core.Map _json) {
    if (_json.containsKey("fingerprint")) {
      fingerprint = _json["fingerprint"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fingerprint != null) {
      _json["fingerprint"] = fingerprint;
    }
    return _json;
  }
}

class ImportFile {
  /** The contents of the file. */
  core.String content;
  /** The name of the file. */
  core.String name;

  ImportFile();

  ImportFile.fromJson(core.Map _json) {
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
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
    return _json;
  }
}

/** Specifies what kind of log the caller must write */
class LogConfig {
  /** Counter options. */
  LogConfigCounterOptions counter;

  LogConfig();

  LogConfig.fromJson(core.Map _json) {
    if (_json.containsKey("counter")) {
      counter = new LogConfigCounterOptions.fromJson(_json["counter"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (counter != null) {
      _json["counter"] = (counter).toJson();
    }
    return _json;
  }
}

/** Options for counters */
class LogConfigCounterOptions {
  /** The field value to attribute. */
  core.String field;
  /** The metric to update. */
  core.String metric;

  LogConfigCounterOptions();

  LogConfigCounterOptions.fromJson(core.Map _json) {
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

class Manifest {
  /** [Output Only] The YAML configuration for this manifest. */
  ConfigFile config;
  /**
   * [Output Only] The fully-expanded configuration file, including any
   * templates and references.
   */
  core.String expandedConfig;
  /**
   * [Output Only] Unique identifier for the resource; defined by the server.
   */
  core.String id;
  /** [Output Only] The imported files for this manifest. */
  core.List<ImportFile> imports;
  /**
   * [Output Only] Timestamp when the manifest was created, in RFC3339 text
   * format.
   */
  core.String insertTime;
  /** [Output Only] The YAML layout for this manifest. */
  core.String layout;
  /** [Output Only] The name of the manifest. */
  core.String name;
  /** [Output Only] Self link for the manifest. */
  core.String selfLink;

  Manifest();

  Manifest.fromJson(core.Map _json) {
    if (_json.containsKey("config")) {
      config = new ConfigFile.fromJson(_json["config"]);
    }
    if (_json.containsKey("expandedConfig")) {
      expandedConfig = _json["expandedConfig"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("imports")) {
      imports = _json["imports"].map((value) => new ImportFile.fromJson(value)).toList();
    }
    if (_json.containsKey("insertTime")) {
      insertTime = _json["insertTime"];
    }
    if (_json.containsKey("layout")) {
      layout = _json["layout"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (config != null) {
      _json["config"] = (config).toJson();
    }
    if (expandedConfig != null) {
      _json["expandedConfig"] = expandedConfig;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (imports != null) {
      _json["imports"] = imports.map((value) => (value).toJson()).toList();
    }
    if (insertTime != null) {
      _json["insertTime"] = insertTime;
    }
    if (layout != null) {
      _json["layout"] = layout;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/**
 * A response containing a partial list of manifests and a page token used to
 * build the next request if the request has been truncated.
 */
class ManifestsListResponse {
  /** [Output Only] Manifests contained in this list response. */
  core.List<Manifest> manifests;
  /** [Output Only] A token used to continue a truncated list request. */
  core.String nextPageToken;

  ManifestsListResponse();

  ManifestsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("manifests")) {
      manifests = _json["manifests"].map((value) => new Manifest.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (manifests != null) {
      _json["manifests"] = manifests.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

class OperationErrorErrors {
  /** [Output Only] The error type identifier for this error. */
  core.String code;
  /**
   * [Output Only] Indicates the field in the request that caused the error.
   * This property is optional.
   */
  core.String location;
  /** [Output Only] An optional, human-readable error message. */
  core.String message;

  OperationErrorErrors();

  OperationErrorErrors.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
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
    if (code != null) {
      _json["code"] = code;
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

/**
 * [Output Only] If errors are generated during processing of the operation,
 * this field will be populated.
 */
class OperationError {
  /**
   * [Output Only] The array of errors encountered while processing this
   * operation.
   */
  core.List<OperationErrorErrors> errors;

  OperationError();

  OperationError.fromJson(core.Map _json) {
    if (_json.containsKey("errors")) {
      errors = _json["errors"].map((value) => new OperationErrorErrors.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OperationWarningsData {
  /**
   * [Output Only] A key that provides more detail on the warning being
   * returned. For example, for warnings where there are no results in a list
   * request for a particular zone, this key might be scope and the key value
   * might be the zone name. Other examples might be a key indicating a
   * deprecated resource and a suggested replacement, or a warning about invalid
   * network settings (for example, if an instance attempts to perform IP
   * forwarding but is not enabled for IP forwarding).
   */
  core.String key;
  /** [Output Only] A warning data value corresponding to the key. */
  core.String value;

  OperationWarningsData();

  OperationWarningsData.fromJson(core.Map _json) {
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (key != null) {
      _json["key"] = key;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class OperationWarnings {
  /**
   * [Output Only] A warning code, if applicable. For example, Compute Engine
   * returns NO_RESULTS_ON_PAGE if there are no results in the response.
   */
  core.String code;
  /**
   * [Output Only] Metadata about this warning in key: value format. For
   * example:
   * "data": [ { "key": "scope", "value": "zones/us-east1-d" }
   */
  core.List<OperationWarningsData> data;
  /** [Output Only] A human-readable description of the warning code. */
  core.String message;

  OperationWarnings();

  OperationWarnings.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("data")) {
      data = _json["data"].map((value) => new OperationWarningsData.fromJson(value)).toList();
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
    if (data != null) {
      _json["data"] = data.map((value) => (value).toJson()).toList();
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

/** An Operation resource, used to manage asynchronous API requests. */
class Operation {
  /** [Output Only] Reserved for future use. */
  core.String clientOperationId;
  /** [Deprecated] This field is deprecated. */
  core.String creationTimestamp;
  /**
   * [Output Only] A textual description of the operation, which is set when the
   * operation is created.
   */
  core.String description;
  /**
   * [Output Only] The time that this operation was completed. This value is in
   * RFC3339 text format.
   */
  core.String endTime;
  /**
   * [Output Only] If errors are generated during processing of the operation,
   * this field will be populated.
   */
  OperationError error;
  /**
   * [Output Only] If the operation fails, this field contains the HTTP error
   * message that was returned, such as NOT FOUND.
   */
  core.String httpErrorMessage;
  /**
   * [Output Only] If the operation fails, this field contains the HTTP error
   * status code that was returned. For example, a 404 means the resource was
   * not found.
   */
  core.int httpErrorStatusCode;
  /**
   * [Output Only] The unique identifier for the resource. This identifier is
   * defined by the server.
   */
  core.String id;
  /**
   * [Output Only] The time that this operation was requested. This value is in
   * RFC3339 text format.
   */
  core.String insertTime;
  /**
   * [Output Only] Type of the resource. Always compute#operation for Operation
   * resources.
   */
  core.String kind;
  /** [Output Only] Name of the resource. */
  core.String name;
  /**
   * [Output Only] The type of operation, such as insert, update, or delete, and
   * so on.
   */
  core.String operationType;
  /**
   * [Output Only] An optional progress indicator that ranges from 0 to 100.
   * There is no requirement that this be linear or support any granularity of
   * operations. This should not be used to guess when the operation will be
   * complete. This number should monotonically increase as the operation
   * progresses.
   */
  core.int progress;
  /**
   * [Output Only] The URL of the region where the operation resides. Only
   * available when performing regional operations.
   */
  core.String region;
  /** [Output Only] Server-defined URL for the resource. */
  core.String selfLink;
  /**
   * [Output Only] The time that this operation was started by the server. This
   * value is in RFC3339 text format.
   */
  core.String startTime;
  /**
   * [Output Only] The status of the operation, which can be one of the
   * following: PENDING, RUNNING, or DONE.
   */
  core.String status;
  /**
   * [Output Only] An optional textual description of the current status of the
   * operation.
   */
  core.String statusMessage;
  /**
   * [Output Only] The unique target ID, which identifies a specific incarnation
   * of the target resource.
   */
  core.String targetId;
  /**
   * [Output Only] The URL of the resource that the operation modifies. For
   * operations related to creating a snapshot, this points to the persistent
   * disk that the snapshot was created from.
   */
  core.String targetLink;
  /**
   * [Output Only] User who requested the operation, for example:
   * user@example.com.
   */
  core.String user;
  /**
   * [Output Only] If warning messages are generated during processing of the
   * operation, this field will be populated.
   */
  core.List<OperationWarnings> warnings;
  /**
   * [Output Only] The URL of the zone where the operation resides. Only
   * available when performing per-zone operations.
   */
  core.String zone;

  Operation();

  Operation.fromJson(core.Map _json) {
    if (_json.containsKey("clientOperationId")) {
      clientOperationId = _json["clientOperationId"];
    }
    if (_json.containsKey("creationTimestamp")) {
      creationTimestamp = _json["creationTimestamp"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("error")) {
      error = new OperationError.fromJson(_json["error"]);
    }
    if (_json.containsKey("httpErrorMessage")) {
      httpErrorMessage = _json["httpErrorMessage"];
    }
    if (_json.containsKey("httpErrorStatusCode")) {
      httpErrorStatusCode = _json["httpErrorStatusCode"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("insertTime")) {
      insertTime = _json["insertTime"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("operationType")) {
      operationType = _json["operationType"];
    }
    if (_json.containsKey("progress")) {
      progress = _json["progress"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("statusMessage")) {
      statusMessage = _json["statusMessage"];
    }
    if (_json.containsKey("targetId")) {
      targetId = _json["targetId"];
    }
    if (_json.containsKey("targetLink")) {
      targetLink = _json["targetLink"];
    }
    if (_json.containsKey("user")) {
      user = _json["user"];
    }
    if (_json.containsKey("warnings")) {
      warnings = _json["warnings"].map((value) => new OperationWarnings.fromJson(value)).toList();
    }
    if (_json.containsKey("zone")) {
      zone = _json["zone"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clientOperationId != null) {
      _json["clientOperationId"] = clientOperationId;
    }
    if (creationTimestamp != null) {
      _json["creationTimestamp"] = creationTimestamp;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (error != null) {
      _json["error"] = (error).toJson();
    }
    if (httpErrorMessage != null) {
      _json["httpErrorMessage"] = httpErrorMessage;
    }
    if (httpErrorStatusCode != null) {
      _json["httpErrorStatusCode"] = httpErrorStatusCode;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (insertTime != null) {
      _json["insertTime"] = insertTime;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (operationType != null) {
      _json["operationType"] = operationType;
    }
    if (progress != null) {
      _json["progress"] = progress;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (statusMessage != null) {
      _json["statusMessage"] = statusMessage;
    }
    if (targetId != null) {
      _json["targetId"] = targetId;
    }
    if (targetLink != null) {
      _json["targetLink"] = targetLink;
    }
    if (user != null) {
      _json["user"] = user;
    }
    if (warnings != null) {
      _json["warnings"] = warnings.map((value) => (value).toJson()).toList();
    }
    if (zone != null) {
      _json["zone"] = zone;
    }
    return _json;
  }
}

/**
 * A response containing a partial list of operations and a page token used to
 * build the next request if the request has been truncated.
 */
class OperationsListResponse {
  /** [Output Only] A token used to continue a truncated list request. */
  core.String nextPageToken;
  /** [Output Only] Operations contained in this list response. */
  core.List<Operation> operations;

  OperationsListResponse();

  OperationsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("operations")) {
      operations = _json["operations"].map((value) => new Operation.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (operations != null) {
      _json["operations"] = operations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Defines an Identity and Access Management (IAM) policy. It is used to specify
 * access control policies for Cloud Platform resources.
 *
 *
 *
 * A `Policy` consists of a list of `bindings`. A `Binding` binds a list of
 * `members` to a `role`, where the members can be user accounts, Google groups,
 * Google domains, and service accounts. A `role` is a named list of permissions
 * defined by IAM.
 *
 * **Example**
 *
 * { "bindings": [ { "role": "roles/owner", "members": [
 * "user:mike@example.com", "group:admins@example.com", "domain:google.com",
 * "serviceAccount:my-other-app@appspot.gserviceaccount.com", ] }, { "role":
 * "roles/viewer", "members": ["user:sean@example.com"] } ] }
 *
 * For a description of IAM and its features, see the [IAM developer's
 * guide](https://cloud.google.com/iam).
 */
class Policy {
  /** Specifies cloud audit logging configuration for this policy. */
  core.List<AuditConfig> auditConfigs;
  /**
   * Associates a list of `members` to a `role`. Multiple `bindings` must not be
   * specified for the same `role`. `bindings` with no members will result in an
   * error.
   */
  core.List<Binding> bindings;
  /**
   * `etag` is used for optimistic concurrency control as a way to help prevent
   * simultaneous updates of a policy from overwriting each other. It is
   * strongly suggested that systems make use of the `etag` in the
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
   * manner: - All matching LOG rules are always applied. - If any
   * DENY/DENY_WITH_LOG rule matches, permission is denied. Logging will be
   * applied if one or more matching rule requires logging. - Otherwise, if any
   * ALLOW/ALLOW_WITH_LOG rule matches, permission is granted. Logging will be
   * applied if one or more matching rule requires logging. - Otherwise, if no
   * rule applies, permission is denied.
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

class ResourceWarningsData {
  /**
   * [Output Only] A key that provides more detail on the warning being
   * returned. For example, for warnings where there are no results in a list
   * request for a particular zone, this key might be scope and the key value
   * might be the zone name. Other examples might be a key indicating a
   * deprecated resource and a suggested replacement, or a warning about invalid
   * network settings (for example, if an instance attempts to perform IP
   * forwarding but is not enabled for IP forwarding).
   */
  core.String key;
  /** [Output Only] A warning data value corresponding to the key. */
  core.String value;

  ResourceWarningsData();

  ResourceWarningsData.fromJson(core.Map _json) {
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (key != null) {
      _json["key"] = key;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class ResourceWarnings {
  /**
   * [Output Only] A warning code, if applicable. For example, Compute Engine
   * returns NO_RESULTS_ON_PAGE if there are no results in the response.
   */
  core.String code;
  /**
   * [Output Only] Metadata about this warning in key: value format. For
   * example:
   * "data": [ { "key": "scope", "value": "zones/us-east1-d" }
   */
  core.List<ResourceWarningsData> data;
  /** [Output Only] A human-readable description of the warning code. */
  core.String message;

  ResourceWarnings();

  ResourceWarnings.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("data")) {
      data = _json["data"].map((value) => new ResourceWarningsData.fromJson(value)).toList();
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
    if (data != null) {
      _json["data"] = data.map((value) => (value).toJson()).toList();
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

class Resource {
  /** The Access Control Policy set on this resource. */
  ResourceAccessControl accessControl;
  /**
   * [Output Only] The evaluated properties of the resource with references
   * expanded. Returned as serialized YAML.
   */
  core.String finalProperties;
  /**
   * [Output Only] Unique identifier for the resource; defined by the server.
   */
  core.String id;
  /**
   * [Output Only] Timestamp when the resource was created or acquired, in
   * RFC3339 text format .
   */
  core.String insertTime;
  /**
   * [Output Only] URL of the manifest representing the current configuration of
   * this resource.
   */
  core.String manifest;
  /**
   * [Output Only] The name of the resource as it appears in the YAML config.
   */
  core.String name;
  /**
   * [Output Only] The current properties of the resource before any references
   * have been filled in. Returned as serialized YAML.
   */
  core.String properties;
  /**
   * [Output Only] The type of the resource, for example compute.v1.instance, or
   * cloudfunctions.v1beta1.function.
   */
  core.String type;
  /**
   * [Output Only] If Deployment Manager is currently updating or previewing an
   * update to this resource, the updated configuration appears here.
   */
  ResourceUpdate update;
  /**
   * [Output Only] Timestamp when the resource was updated, in RFC3339 text
   * format .
   */
  core.String updateTime;
  /** [Output Only] The URL of the actual resource. */
  core.String url;
  /**
   * [Output Only] If warning messages are generated during processing of this
   * resource, this field will be populated.
   */
  core.List<ResourceWarnings> warnings;

  Resource();

  Resource.fromJson(core.Map _json) {
    if (_json.containsKey("accessControl")) {
      accessControl = new ResourceAccessControl.fromJson(_json["accessControl"]);
    }
    if (_json.containsKey("finalProperties")) {
      finalProperties = _json["finalProperties"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("insertTime")) {
      insertTime = _json["insertTime"];
    }
    if (_json.containsKey("manifest")) {
      manifest = _json["manifest"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("properties")) {
      properties = _json["properties"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("update")) {
      update = new ResourceUpdate.fromJson(_json["update"]);
    }
    if (_json.containsKey("updateTime")) {
      updateTime = _json["updateTime"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("warnings")) {
      warnings = _json["warnings"].map((value) => new ResourceWarnings.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accessControl != null) {
      _json["accessControl"] = (accessControl).toJson();
    }
    if (finalProperties != null) {
      _json["finalProperties"] = finalProperties;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (insertTime != null) {
      _json["insertTime"] = insertTime;
    }
    if (manifest != null) {
      _json["manifest"] = manifest;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (properties != null) {
      _json["properties"] = properties;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (update != null) {
      _json["update"] = (update).toJson();
    }
    if (updateTime != null) {
      _json["updateTime"] = updateTime;
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (warnings != null) {
      _json["warnings"] = warnings.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The access controls set on the resource. */
class ResourceAccessControl {
  /** The GCP IAM Policy to set on the resource. */
  core.String gcpIamPolicy;

  ResourceAccessControl();

  ResourceAccessControl.fromJson(core.Map _json) {
    if (_json.containsKey("gcpIamPolicy")) {
      gcpIamPolicy = _json["gcpIamPolicy"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (gcpIamPolicy != null) {
      _json["gcpIamPolicy"] = gcpIamPolicy;
    }
    return _json;
  }
}

class ResourceUpdateErrorErrors {
  /** [Output Only] The error type identifier for this error. */
  core.String code;
  /**
   * [Output Only] Indicates the field in the request that caused the error.
   * This property is optional.
   */
  core.String location;
  /** [Output Only] An optional, human-readable error message. */
  core.String message;

  ResourceUpdateErrorErrors();

  ResourceUpdateErrorErrors.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
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
    if (code != null) {
      _json["code"] = code;
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

/**
 * [Output Only] If errors are generated during update of the resource, this
 * field will be populated.
 */
class ResourceUpdateError {
  /**
   * [Output Only] The array of errors encountered while processing this
   * operation.
   */
  core.List<ResourceUpdateErrorErrors> errors;

  ResourceUpdateError();

  ResourceUpdateError.fromJson(core.Map _json) {
    if (_json.containsKey("errors")) {
      errors = _json["errors"].map((value) => new ResourceUpdateErrorErrors.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ResourceUpdateWarningsData {
  /**
   * [Output Only] A key that provides more detail on the warning being
   * returned. For example, for warnings where there are no results in a list
   * request for a particular zone, this key might be scope and the key value
   * might be the zone name. Other examples might be a key indicating a
   * deprecated resource and a suggested replacement, or a warning about invalid
   * network settings (for example, if an instance attempts to perform IP
   * forwarding but is not enabled for IP forwarding).
   */
  core.String key;
  /** [Output Only] A warning data value corresponding to the key. */
  core.String value;

  ResourceUpdateWarningsData();

  ResourceUpdateWarningsData.fromJson(core.Map _json) {
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (key != null) {
      _json["key"] = key;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class ResourceUpdateWarnings {
  /**
   * [Output Only] A warning code, if applicable. For example, Compute Engine
   * returns NO_RESULTS_ON_PAGE if there are no results in the response.
   */
  core.String code;
  /**
   * [Output Only] Metadata about this warning in key: value format. For
   * example:
   * "data": [ { "key": "scope", "value": "zones/us-east1-d" }
   */
  core.List<ResourceUpdateWarningsData> data;
  /** [Output Only] A human-readable description of the warning code. */
  core.String message;

  ResourceUpdateWarnings();

  ResourceUpdateWarnings.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("data")) {
      data = _json["data"].map((value) => new ResourceUpdateWarningsData.fromJson(value)).toList();
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
    if (data != null) {
      _json["data"] = data.map((value) => (value).toJson()).toList();
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

class ResourceUpdate {
  /**
   * The Access Control Policy to set on this resource after updating the
   * resource itself.
   */
  ResourceAccessControl accessControl;
  /**
   * [Output Only] If errors are generated during update of the resource, this
   * field will be populated.
   */
  ResourceUpdateError error;
  /**
   * [Output Only] The expanded properties of the resource with reference values
   * expanded. Returned as serialized YAML.
   */
  core.String finalProperties;
  /** [Output Only] The intent of the resource: PREVIEW, UPDATE, or CANCEL. */
  core.String intent;
  /**
   * [Output Only] URL of the manifest representing the update configuration of
   * this resource.
   */
  core.String manifest;
  /**
   * [Output Only] The set of updated properties for this resource, before
   * references are expanded. Returned as serialized YAML.
   */
  core.String properties;
  /** [Output Only] The state of the resource. */
  core.String state;
  /**
   * [Output Only] If warning messages are generated during processing of this
   * resource, this field will be populated.
   */
  core.List<ResourceUpdateWarnings> warnings;

  ResourceUpdate();

  ResourceUpdate.fromJson(core.Map _json) {
    if (_json.containsKey("accessControl")) {
      accessControl = new ResourceAccessControl.fromJson(_json["accessControl"]);
    }
    if (_json.containsKey("error")) {
      error = new ResourceUpdateError.fromJson(_json["error"]);
    }
    if (_json.containsKey("finalProperties")) {
      finalProperties = _json["finalProperties"];
    }
    if (_json.containsKey("intent")) {
      intent = _json["intent"];
    }
    if (_json.containsKey("manifest")) {
      manifest = _json["manifest"];
    }
    if (_json.containsKey("properties")) {
      properties = _json["properties"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("warnings")) {
      warnings = _json["warnings"].map((value) => new ResourceUpdateWarnings.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accessControl != null) {
      _json["accessControl"] = (accessControl).toJson();
    }
    if (error != null) {
      _json["error"] = (error).toJson();
    }
    if (finalProperties != null) {
      _json["finalProperties"] = finalProperties;
    }
    if (intent != null) {
      _json["intent"] = intent;
    }
    if (manifest != null) {
      _json["manifest"] = manifest;
    }
    if (properties != null) {
      _json["properties"] = properties;
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (warnings != null) {
      _json["warnings"] = warnings.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * A response containing a partial list of resources and a page token used to
 * build the next request if the request has been truncated.
 */
class ResourcesListResponse {
  /** A token used to continue a truncated list request. */
  core.String nextPageToken;
  /** Resources contained in this list response. */
  core.List<Resource> resources;

  ResourcesListResponse();

  ResourcesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new Resource.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A rule to be applied in a Policy. */
class Rule {
  /** Required */
  core.String action;
  /** Additional restrictions that must be met */
  core.List<Condition> conditions;
  /** Human-readable description of the rule. */
  core.String description;
  /**
   * If one or more 'in' clauses are specified, the rule matches if the
   * PRINCIPAL/AUTHORITY_SELECTOR is in at least one of these entries.
   */
  core.List<core.String> ins;
  /**
   * The config returned to callers of tech.iam.IAM.CheckPolicy for any entries
   * that match the LOG action.
   */
  core.List<LogConfig> logConfigs;
  /**
   * If one or more 'not_in' clauses are specified, the rule matches if the
   * PRINCIPAL/AUTHORITY_SELECTOR is in none of the entries.
   */
  core.List<core.String> notIns;
  /**
   * A permission is a string of form '..' (e.g., 'storage.buckets.list'). A
   * value of '*' matches all permissions, and a verb part of '*' (e.g.,
   * 'storage.buckets.*') matches all verbs.
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
    if (_json.containsKey("ins")) {
      ins = _json["ins"];
    }
    if (_json.containsKey("logConfigs")) {
      logConfigs = _json["logConfigs"].map((value) => new LogConfig.fromJson(value)).toList();
    }
    if (_json.containsKey("notIns")) {
      notIns = _json["notIns"];
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
    if (ins != null) {
      _json["ins"] = ins;
    }
    if (logConfigs != null) {
      _json["logConfigs"] = logConfigs.map((value) => (value).toJson()).toList();
    }
    if (notIns != null) {
      _json["notIns"] = notIns;
    }
    if (permissions != null) {
      _json["permissions"] = permissions;
    }
    return _json;
  }
}

class TargetConfiguration {
  /** The configuration to use for this deployment. */
  ConfigFile config;
  /**
   * Specifies any files to import for this configuration. This can be used to
   * import templates or other files. For example, you might import a text file
   * in order to use the file in a template.
   */
  core.List<ImportFile> imports;

  TargetConfiguration();

  TargetConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("config")) {
      config = new ConfigFile.fromJson(_json["config"]);
    }
    if (_json.containsKey("imports")) {
      imports = _json["imports"].map((value) => new ImportFile.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (config != null) {
      _json["config"] = (config).toJson();
    }
    if (imports != null) {
      _json["imports"] = imports.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class TestPermissionsRequest {
  /**
   * The set of permissions to check for the 'resource'. Permissions with
   * wildcards (such as '*' or 'storage.*') are not allowed.
   */
  core.List<core.String> permissions;

  TestPermissionsRequest();

  TestPermissionsRequest.fromJson(core.Map _json) {
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

class TestPermissionsResponse {
  /**
   * A subset of `TestPermissionsRequest.permissions` that the caller is
   * allowed.
   */
  core.List<core.String> permissions;

  TestPermissionsResponse();

  TestPermissionsResponse.fromJson(core.Map _json) {
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

/** A resource type supported by Deployment Manager. */
class Type {
  /**
   * [Output Only] Unique identifier for the resource; defined by the server.
   */
  core.String id;
  /**
   * [Output Only] Timestamp when the type was created, in RFC3339 text format.
   */
  core.String insertTime;
  /** Name of the type. */
  core.String name;
  /**
   * [Output Only] The Operation that most recently ran, or is currently
   * running, on this type.
   */
  Operation operation;
  /** [Output Only] Self link for the type. */
  core.String selfLink;

  Type();

  Type.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("insertTime")) {
      insertTime = _json["insertTime"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("operation")) {
      operation = new Operation.fromJson(_json["operation"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (insertTime != null) {
      _json["insertTime"] = insertTime;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (operation != null) {
      _json["operation"] = (operation).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/** A response that returns all Types supported by Deployment Manager */
class TypesListResponse {
  /** A token used to continue a truncated list request. */
  core.String nextPageToken;
  /**
   * [Output Only] A list of resource types supported by Deployment Manager.
   */
  core.List<Type> types;

  TypesListResponse();

  TypesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("types")) {
      types = _json["types"].map((value) => new Type.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (types != null) {
      _json["types"] = types.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
