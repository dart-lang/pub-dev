// This is a generated file (see the discoveryapis_generator project).

library googleapis.cloudresourcemanager.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client cloudresourcemanager/v1';

/**
 * The Google Cloud Resource Manager API provides methods for creating, reading,
 * and updating project metadata.
 */
class CloudresourcemanagerApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /** View your data across Google Cloud Platform services */
  static const CloudPlatformReadOnlyScope = "https://www.googleapis.com/auth/cloud-platform.read-only";


  final commons.ApiRequester _requester;

  LiensResourceApi get liens => new LiensResourceApi(_requester);
  OperationsResourceApi get operations => new OperationsResourceApi(_requester);
  OrganizationsResourceApi get organizations => new OrganizationsResourceApi(_requester);
  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);

  CloudresourcemanagerApi(http.Client client, {core.String rootUrl: "https://cloudresourcemanager.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class LiensResourceApi {
  final commons.ApiRequester _requester;

  LiensResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Create a Lien which applies to the resource denoted by the `parent` field.
   *
   * Callers of this method will require permission on the `parent` resource.
   * For example, applying to `projects/1234` requires permission
   * `resourcemanager.projects.updateLiens`.
   *
   * NOTE: Some resources may limit the number of Liens which may be applied.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Lien].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Lien> create(Lien request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/liens';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Lien.fromJson(data));
  }

  /**
   * Delete a Lien by `name`.
   *
   * Callers of this method will require permission on the `parent` resource.
   * For example, a Lien with a `parent` of `projects/1234` requires permission
   * `resourcemanager.projects.updateLiens`.
   *
   * Request parameters:
   *
   * [name] - The name/identifier of the Lien to delete.
   * Value must have pattern "^liens/.+$".
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String name) {
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
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * List all Liens applied to the `parent` resource.
   *
   * Callers of this method will require permission on the `parent` resource.
   * For example, a Lien with a `parent` of `projects/1234` requires permission
   * `resourcemanager.projects.get`.
   *
   * Request parameters:
   *
   * [parent] - The name of the resource to list all attached Liens.
   * For example, `projects/1234`.
   *
   * [pageToken] - The `next_page_token` value returned from a previous List
   * request, if any.
   *
   * [pageSize] - The maximum number of items to return. This is a suggestion
   * for the server.
   *
   * Completes with a [ListLiensResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListLiensResponse> list({core.String parent, core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (parent != null) {
      _queryParams["parent"] = [parent];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1/liens';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListLiensResponse.fromJson(data));
  }

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
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
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


class OrganizationsResourceApi {
  final commons.ApiRequester _requester;

  OrganizationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Fetches an Organization resource identified by the specified resource name.
   *
   * Request parameters:
   *
   * [name] - The resource name of the Organization to fetch, e.g.
   * "organizations/1234".
   * Value must have pattern "^organizations/[^/]+$".
   *
   * Completes with a [Organization].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Organization> get(core.String name) {
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
    return _response.then((data) => new Organization.fromJson(data));
  }

  /**
   * Gets the access control policy for an Organization resource. May be empty
   * if no such policy or resource exists. The `resource` field should be the
   * organization's resource name, e.g. "organizations/123".
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which the policy is being
   * requested.
   * See the operation documentation for the appropriate value for this field.
   * Value must have pattern "^organizations/[^/]+$".
   *
   * Completes with a [Policy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
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
   * Searches Organization resources that are visible to the user and satisfy
   * the specified filter. This method returns Organizations in an unspecified
   * order. New Organizations do not necessarily appear at the end of the
   * results.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SearchOrganizationsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SearchOrganizationsResponse> search(SearchOrganizationsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/organizations:search';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SearchOrganizationsResponse.fromJson(data));
  }

  /**
   * Sets the access control policy on an Organization resource. Replaces any
   * existing policy. The `resource` field should be the organization's resource
   * name, e.g. "organizations/123".
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which the policy is being
   * specified.
   * See the operation documentation for the appropriate value for this field.
   * Value must have pattern "^organizations/[^/]+$".
   *
   * Completes with a [Policy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
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
   * Returns permissions that a caller has on the specified Organization.
   * The `resource` field should be the organization's resource name,
   * e.g. "organizations/123".
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which the policy detail is being
   * requested.
   * See the operation documentation for the appropriate value for this field.
   * Value must have pattern "^organizations/[^/]+$".
   *
   * Completes with a [TestIamPermissionsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
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

}


class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Request that a new Project be created. The result is an Operation which
   * can be used to track the creation process. It is automatically deleted
   * after a few hours, so there is no need to call DeleteOperation.
   *
   * Our SLO permits Project creation to take up to 30 seconds at the 90th
   * percentile. As of 2016-08-29, we are observing 6 seconds 50th percentile
   * latency. 95th percentile latency is around 11 seconds. We recommend
   * polling at the 5th second with an exponential backoff.
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
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> create(Project request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/projects';

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
   * Marks the Project identified by the specified
   * `project_id` (for example, `my-project-123`) for deletion.
   * This method will only affect the Project if the following criteria are met:
   *
   * + The Project does not have a billing account associated with it.
   * + The Project has a lifecycle state of
   * ACTIVE.
   *
   * This method changes the Project's lifecycle state from
   * ACTIVE
   * to DELETE_REQUESTED.
   * The deletion starts at an unspecified time,
   * at which point the Project is no longer accessible.
   *
   * Until the deletion completes, you can check the lifecycle state
   * checked by retrieving the Project with GetProject,
   * and the Project remains visible to ListProjects.
   * However, you cannot update the project.
   *
   * After the deletion completes, the Project is not retrievable by
   * the  GetProject and
   * ListProjects methods.
   *
   * The caller must have modify permissions for this Project.
   *
   * Request parameters:
   *
   * [projectId] - The Project ID (for example, `foo-bar-123`).
   *
   * Required.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$projectId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Retrieves the Project identified by the specified
   * `project_id` (for example, `my-project-123`).
   *
   * The caller must have read permissions for this Project.
   *
   * Request parameters:
   *
   * [projectId] - The Project ID (for example, `my-project-123`).
   *
   * Required.
   *
   * Completes with a [Project].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Project> get(core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$projectId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Project.fromJson(data));
  }

  /**
   * Gets a list of ancestors in the resource hierarchy for the Project
   * identified by the specified `project_id` (for example, `my-project-123`).
   *
   * The caller must have read permissions for this Project.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - The Project ID (for example, `my-project-123`).
   *
   * Required.
   *
   * Completes with a [GetAncestryResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetAncestryResponse> getAncestry(GetAncestryRequest request, core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$projectId') + ':getAncestry';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetAncestryResponse.fromJson(data));
  }

  /**
   * Returns the IAM access control policy for the specified Project.
   * Permission is denied if the policy or the resource does not exist.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which the policy is being
   * requested.
   * See the operation documentation for the appropriate value for this field.
   *
   * Completes with a [Policy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
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

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$resource') + ':getIamPolicy';

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
   * Lists Projects that are visible to the user and satisfy the
   * specified filter. This method returns Projects in an unspecified order.
   * New Projects do not necessarily appear at the end of the list.
   *
   * Request parameters:
   *
   * [filter] - An expression for filtering the results of the request.  Filter
   * rules are
   * case insensitive. The fields eligible for filtering are:
   *
   * + `name`
   * + `id`
   * + <code>labels.<em>key</em></code> where *key* is the name of a label
   *
   * Some examples of using labels as filters:
   *
   * |Filter|Description|
   * |------|-----------|
   * |name:*|The project has a name.|
   * |name:Howl|The project's name is `Howl` or `howl`.|
   * |name:HOWL|Equivalent to above.|
   * |NAME:howl|Equivalent to above.|
   * |labels.color:*|The project has the label `color`.|
   * |labels.color:red|The project's label `color` has the value `red`.|
   * |labels.color:red&nbsp;label.size:big|The project's label `color` has the
   * value `red` and its label `size` has the value `big`.
   *
   * Optional.
   *
   * [pageToken] - A pagination token returned from a previous call to
   * ListProjects
   * that indicates from where listing should continue.
   *
   * Optional.
   *
   * [pageSize] - The maximum number of Projects to return in the response.
   * The server can return fewer Projects than requested.
   * If unspecified, server picks an appropriate default.
   *
   * Optional.
   *
   * Completes with a [ListProjectsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListProjectsResponse> list({core.String filter, core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1/projects';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListProjectsResponse.fromJson(data));
  }

  /**
   * Sets the IAM access control policy for the specified Project. Replaces
   * any existing policy.
   *
   * The following constraints apply when using `setIamPolicy()`:
   *
   * + Project does not support `allUsers` and `allAuthenticatedUsers` as
   * `members` in a `Binding` of a `Policy`.
   *
   * + The owner role can be granted only to `user` and `serviceAccount`.
   *
   * + Service accounts can be made owners of a project directly
   * without any restrictions. However, to be added as an owner, a user must be
   * invited via Cloud Platform console and must accept the invitation.
   *
   * + A user cannot be granted the owner role using `setIamPolicy()`. The user
   * must be granted the owner role using the Cloud Platform Console and must
   * explicitly accept the invitation.
   *
   * + Invitations to grant the owner role cannot be sent using
   * `setIamPolicy()`;
   * they must be sent only using the Cloud Platform Console.
   *
   * + Membership changes that leave the project without any owners that have
   * accepted the Terms of Service (ToS) will be rejected.
   *
   * + There must be at least one owner who has accepted the Terms of
   * Service (ToS) agreement in the policy. Calling `setIamPolicy()` to
   * to remove the last ToS-accepted owner from the policy will fail. This
   * restriction also applies to legacy projects that no longer have owners
   * who have accepted the ToS. Edits to IAM policies will be rejected until
   * the lack of a ToS-accepting owner is rectified.
   *
   * + Calling this method requires enabling the App Engine Admin API.
   *
   * Note: Removing service accounts from policies or changing their roles
   * can render services completely inoperable. It is important to understand
   * how the service account is being used before removing or updating its
   * roles.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which the policy is being
   * specified.
   * See the operation documentation for the appropriate value for this field.
   *
   * Completes with a [Policy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
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

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$resource') + ':setIamPolicy';

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
   * Returns permissions that a caller has on the specified Project.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which the policy detail is being
   * requested.
   * See the operation documentation for the appropriate value for this field.
   *
   * Completes with a [TestIamPermissionsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
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

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$resource') + ':testIamPermissions';

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
   * Restores the Project identified by the specified
   * `project_id` (for example, `my-project-123`).
   * You can only use this method for a Project that has a lifecycle state of
   * DELETE_REQUESTED.
   * After deletion starts, the Project cannot be restored.
   *
   * The caller must have modify permissions for this Project.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - The project ID (for example, `foo-bar-123`).
   *
   * Required.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> undelete(UndeleteProjectRequest request, core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$projectId') + ':undelete';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Updates the attributes of the Project identified by the specified
   * `project_id` (for example, `my-project-123`).
   *
   * The caller must have modify permissions for this Project.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - The project ID (for example, `my-project-123`).
   *
   * Required.
   *
   * Completes with a [Project].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Project> update(Project request, core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$projectId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Project.fromJson(data));
  }

}



/** Identifying information for a single ancestor of a project. */
class Ancestor {
  /** Resource id of the ancestor. */
  ResourceId resourceId;

  Ancestor();

  Ancestor.fromJson(core.Map _json) {
    if (_json.containsKey("resourceId")) {
      resourceId = new ResourceId.fromJson(_json["resourceId"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (resourceId != null) {
      _json["resourceId"] = (resourceId).toJson();
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
 * A generic empty message that you can re-use to avoid defining duplicated
 * empty messages in your APIs. A typical example is to use it as the request
 * or the response type of an API method. For instance:
 *
 *     service Foo {
 *       rpc Bar(google.protobuf.Empty) returns (google.protobuf.Empty);
 *     }
 *
 * The JSON representation for `Empty` is empty JSON object `{}`.
 */
class Empty {

  Empty();

  Empty.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** Metadata describing a long running folder operation */
class FolderOperation {
  /**
   * The resource name of the folder or organization we are either creating
   * the folder under or moving the folder to.
   */
  core.String destinationParent;
  /** The display name of the folder. */
  core.String displayName;
  /**
   * The type of this operation.
   * Possible string values are:
   * - "OPERATION_TYPE_UNSPECIFIED" : Operation type not specified.
   * - "CREATE" : A create folder operation.
   * - "MOVE" : A move folder operation.
   */
  core.String operationType;
  /**
   * The resource name of the folder's parent.
   * Only applicable when the operation_type is MOVE.
   */
  core.String sourceParent;

  FolderOperation();

  FolderOperation.fromJson(core.Map _json) {
    if (_json.containsKey("destinationParent")) {
      destinationParent = _json["destinationParent"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("operationType")) {
      operationType = _json["operationType"];
    }
    if (_json.containsKey("sourceParent")) {
      sourceParent = _json["sourceParent"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (destinationParent != null) {
      _json["destinationParent"] = destinationParent;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (operationType != null) {
      _json["operationType"] = operationType;
    }
    if (sourceParent != null) {
      _json["sourceParent"] = sourceParent;
    }
    return _json;
  }
}

/** A classification of the Folder Operation error. */
class FolderOperationError {
  /**
   * The type of operation error experienced.
   * Possible string values are:
   * - "ERROR_TYPE_UNSPECIFIED" : The error type was unrecognized or
   * unspecified.
   * - "FOLDER_HEIGHT_VIOLATION" : The attempted action would violate the max
   * folder depth constraint.
   * - "MAX_CHILD_FOLDERS_VIOLATION" : The attempted action would violate the
   * max child folders constraint.
   * - "FOLDER_NAME_UNIQUENESS_VIOLATION" : The attempted action would violate
   * the locally-unique folder
   * display_name constraint.
   * - "RESOURCE_DELETED" : The resource being moved has been deleted.
   * - "PARENT_DELETED" : The resource a folder was being added to has been
   * deleted.
   * - "CYCLE_INTRODUCED_ERROR" : The attempted action would introduce cycle in
   * resource path.
   * - "FOLDER_ALREADY_BEING_MOVED" : The attempted action would move a folder
   * that is already being moved.
   * - "FOLDER_TO_DELETE_NON_EMPTY" : The folder the caller is trying to delete
   * contains active resources.
   */
  core.String errorMessageId;

  FolderOperationError();

  FolderOperationError.fromJson(core.Map _json) {
    if (_json.containsKey("errorMessageId")) {
      errorMessageId = _json["errorMessageId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (errorMessageId != null) {
      _json["errorMessageId"] = errorMessageId;
    }
    return _json;
  }
}

/**
 * The request sent to the
 * GetAncestry
 * method.
 */
class GetAncestryRequest {

  GetAncestryRequest();

  GetAncestryRequest.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** Response from the GetAncestry method. */
class GetAncestryResponse {
  /**
   * Ancestors are ordered from bottom to top of the resource hierarchy. The
   * first ancestor is the project itself, followed by the project's parent,
   * etc.
   */
  core.List<Ancestor> ancestor;

  GetAncestryResponse();

  GetAncestryResponse.fromJson(core.Map _json) {
    if (_json.containsKey("ancestor")) {
      ancestor = _json["ancestor"].map((value) => new Ancestor.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (ancestor != null) {
      _json["ancestor"] = ancestor.map((value) => (value).toJson()).toList();
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
 * A Lien represents an encumbrance on the actions that can be performed on a
 * resource.
 */
class Lien {
  /** The creation time of this Lien. */
  core.String createTime;
  /**
   * A system-generated unique identifier for this Lien.
   *
   * Example: `liens/1234abcd`
   */
  core.String name;
  /**
   * A stable, user-visible/meaningful string identifying the origin of the
   * Lien, intended to be inspected programmatically. Maximum length of 200
   * characters.
   *
   * Example: 'compute.googleapis.com'
   */
  core.String origin;
  /**
   * A reference to the resource this Lien is attached to. The server will
   * validate the parent against those for which Liens are supported.
   *
   * Example: `projects/1234`
   */
  core.String parent;
  /**
   * Concise user-visible strings indicating why an action cannot be performed
   * on a resource. Maximum lenth of 200 characters.
   *
   * Example: 'Holds production API key'
   */
  core.String reason;
  /**
   * The types of operations which should be blocked as a result of this Lien.
   * Each value should correspond to an IAM permission. The server will
   * validate the permissions against those for which Liens are supported.
   *
   * An empty list is meaningless and will be rejected.
   *
   * Example: ['resourcemanager.projects.delete']
   */
  core.List<core.String> restrictions;

  Lien();

  Lien.fromJson(core.Map _json) {
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("origin")) {
      origin = _json["origin"];
    }
    if (_json.containsKey("parent")) {
      parent = _json["parent"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("restrictions")) {
      restrictions = _json["restrictions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (origin != null) {
      _json["origin"] = origin;
    }
    if (parent != null) {
      _json["parent"] = parent;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (restrictions != null) {
      _json["restrictions"] = restrictions;
    }
    return _json;
  }
}

/** The response message for Liens.ListLiens. */
class ListLiensResponse {
  /** A list of Liens. */
  core.List<Lien> liens;
  /**
   * Token to retrieve the next page of results, or empty if there are no more
   * results in the list.
   */
  core.String nextPageToken;

  ListLiensResponse();

  ListLiensResponse.fromJson(core.Map _json) {
    if (_json.containsKey("liens")) {
      liens = _json["liens"].map((value) => new Lien.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (liens != null) {
      _json["liens"] = liens.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/**
 * A page of the response received from the
 * ListProjects
 * method.
 *
 * A paginated response where more pages are available has
 * `next_page_token` set. This token can be used in a subsequent request to
 * retrieve the next request page.
 */
class ListProjectsResponse {
  /**
   * Pagination token.
   *
   * If the result set is too large to fit in a single response, this token
   * is returned. It encodes the position of the current result cursor.
   * Feeding this value into a new list request with the `page_token` parameter
   * gives the next page of the results.
   *
   * When `next_page_token` is not filled in, there is no next page and
   * the list returned is the last page in the result set.
   *
   * Pagination tokens have a limited lifetime.
   */
  core.String nextPageToken;
  /**
   * The list of Projects that matched the list filter. This list can
   * be paginated.
   */
  core.List<Project> projects;

  ListProjectsResponse();

  ListProjectsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("projects")) {
      projects = _json["projects"].map((value) => new Project.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (projects != null) {
      _json["projects"] = projects.map((value) => (value).toJson()).toList();
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

/**
 * The root node in the resource hierarchy to which a particular entity's
 * (e.g., company) resources belong.
 */
class Organization {
  /**
   * Timestamp when the Organization was created. Assigned by the server.
   * @OutputOnly
   */
  core.String creationTime;
  /**
   * A friendly string to be used to refer to the Organization in the UI.
   * Assigned by the server, set to the primary domain of the G Suite
   * customer that owns the organization.
   * @OutputOnly
   */
  core.String displayName;
  /**
   * The organization's current lifecycle state. Assigned by the server.
   * @OutputOnly
   * Possible string values are:
   * - "LIFECYCLE_STATE_UNSPECIFIED" : Unspecified state.  This is only useful
   * for distinguishing unset values.
   * - "ACTIVE" : The normal and active state.
   * - "DELETE_REQUESTED" : The organization has been marked for deletion by the
   * user.
   */
  core.String lifecycleState;
  /**
   * Output Only. The resource name of the organization. This is the
   * organization's relative path in the API. Its format is
   * "organizations/[organization_id]". For example, "organizations/1234".
   */
  core.String name;
  /**
   * The owner of this Organization. The owner should be specified on
   * creation. Once set, it cannot be changed.
   * This field is required.
   */
  OrganizationOwner owner;

  Organization();

  Organization.fromJson(core.Map _json) {
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("lifecycleState")) {
      lifecycleState = _json["lifecycleState"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("owner")) {
      owner = new OrganizationOwner.fromJson(_json["owner"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (lifecycleState != null) {
      _json["lifecycleState"] = lifecycleState;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (owner != null) {
      _json["owner"] = (owner).toJson();
    }
    return _json;
  }
}

/**
 * The entity that owns an Organization. The lifetime of the Organization and
 * all of its descendants are bound to the `OrganizationOwner`. If the
 * `OrganizationOwner` is deleted, the Organization and all its descendants will
 * be deleted.
 */
class OrganizationOwner {
  /** The Google for Work customer id used in the Directory API. */
  core.String directoryCustomerId;

  OrganizationOwner();

  OrganizationOwner.fromJson(core.Map _json) {
    if (_json.containsKey("directoryCustomerId")) {
      directoryCustomerId = _json["directoryCustomerId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (directoryCustomerId != null) {
      _json["directoryCustomerId"] = directoryCustomerId;
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
  /** Version of the `Policy`. The default version is 0. */
  core.int version;

  Policy();

  Policy.fromJson(core.Map _json) {
    if (_json.containsKey("bindings")) {
      bindings = _json["bindings"].map((value) => new Binding.fromJson(value)).toList();
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bindings != null) {
      _json["bindings"] = bindings.map((value) => (value).toJson()).toList();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

/**
 * A Project is a high-level Google Cloud Platform entity.  It is a
 * container for ACLs, APIs, App Engine Apps, VMs, and other
 * Google Cloud Platform resources.
 */
class Project {
  /**
   * Creation time.
   *
   * Read-only.
   */
  core.String createTime;
  /**
   * The labels associated with this Project.
   *
   * Label keys must be between 1 and 63 characters long and must conform
   * to the following regular expression: \[a-z\](\[-a-z0-9\]*\[a-z0-9\])?.
   *
   * Label values must be between 0 and 63 characters long and must conform
   * to the regular expression (\[a-z\](\[-a-z0-9\]*\[a-z0-9\])?)?.
   *
   * No more than 256 labels can be associated with a given resource.
   *
   * Clients should store labels in a representation such as JSON that does not
   * depend on specific characters being disallowed.
   *
   * Example: <code>"environment" : "dev"</code>
   * Read-write.
   */
  core.Map<core.String, core.String> labels;
  /**
   * The Project lifecycle state.
   *
   * Read-only.
   * Possible string values are:
   * - "LIFECYCLE_STATE_UNSPECIFIED" : Unspecified state.  This is only
   * used/useful for distinguishing
   * unset values.
   * - "ACTIVE" : The normal and active state.
   * - "DELETE_REQUESTED" : The project has been marked for deletion by the user
   * (by invoking
   * DeleteProject)
   * or by the system (Google Cloud Platform).
   * This can generally be reversed by invoking UndeleteProject.
   * - "DELETE_IN_PROGRESS" : This lifecycle state is no longer used and not
   * returned by the API.
   */
  core.String lifecycleState;
  /**
   * The user-assigned display name of the Project.
   * It must be 4 to 30 characters.
   * Allowed characters are: lowercase and uppercase letters, numbers,
   * hyphen, single-quote, double-quote, space, and exclamation point.
   *
   * Example: <code>My Project</code>
   * Read-write.
   */
  core.String name;
  /**
   * An optional reference to a parent Resource.
   *
   * The only supported parent type is "organization". Once set, the parent
   * cannot be modified. The `parent` can be set on creation or using the
   * `UpdateProject` method; the end user must have the
   * `resourcemanager.projects.create` permission on the parent.
   *
   * Read-write.
   */
  ResourceId parent;
  /**
   * The unique, user-assigned ID of the Project.
   * It must be 6 to 30 lowercase letters, digits, or hyphens.
   * It must start with a letter.
   * Trailing hyphens are prohibited.
   *
   * Example: <code>tokyo-rain-123</code>
   * Read-only after creation.
   */
  core.String projectId;
  /**
   * The number uniquely identifying the project.
   *
   * Example: <code>415104041262</code>
   * Read-only.
   */
  core.String projectNumber;

  Project();

  Project.fromJson(core.Map _json) {
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("lifecycleState")) {
      lifecycleState = _json["lifecycleState"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parent")) {
      parent = new ResourceId.fromJson(_json["parent"]);
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("projectNumber")) {
      projectNumber = _json["projectNumber"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (lifecycleState != null) {
      _json["lifecycleState"] = lifecycleState;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parent != null) {
      _json["parent"] = (parent).toJson();
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (projectNumber != null) {
      _json["projectNumber"] = projectNumber;
    }
    return _json;
  }
}

/**
 * A status object which is used as the `metadata` field for the Operation
 * returned by CreateProject. It provides insight for when significant phases of
 * Project creation have completed.
 */
class ProjectCreationStatus {
  /** Creation time of the project creation workflow. */
  core.String createTime;
  /**
   * True if the project can be retrieved using GetProject. No other operations
   * on the project are guaranteed to work until the project creation is
   * complete.
   */
  core.bool gettable;
  /** True if the project creation process is complete. */
  core.bool ready;

  ProjectCreationStatus();

  ProjectCreationStatus.fromJson(core.Map _json) {
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("gettable")) {
      gettable = _json["gettable"];
    }
    if (_json.containsKey("ready")) {
      ready = _json["ready"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (gettable != null) {
      _json["gettable"] = gettable;
    }
    if (ready != null) {
      _json["ready"] = ready;
    }
    return _json;
  }
}

/**
 * A container to reference an id for any resource type. A `resource` in Google
 * Cloud Platform is a generic term for something you (a developer) may want to
 * interact with through one of our API's. Some examples are an App Engine app,
 * a Compute Engine instance, a Cloud SQL database, and so on.
 */
class ResourceId {
  /**
   * Required field for the type-specific id. This should correspond to the id
   * used in the type-specific API's.
   */
  core.String id;
  /**
   * Required field representing the resource type this id is for.
   * At present, the valid types are: "organization"
   */
  core.String type;

  ResourceId();

  ResourceId.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
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
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** The request sent to the `SearchOrganizations` method. */
class SearchOrganizationsRequest {
  /**
   * An optional query string used to filter the Organizations to return in
   * the response. Filter rules are case-insensitive.
   *
   *
   * Organizations may be filtered by `owner.directoryCustomerId` or by
   * `domain`, where the domain is a Google for Work domain, for example:
   *
   * |Filter|Description|
   * |------|-----------|
   * |owner.directorycustomerid:123456789|Organizations with
   * `owner.directory_customer_id` equal to `123456789`.|
   * |domain:google.com|Organizations corresponding to the domain `google.com`.|
   *
   * This field is optional.
   */
  core.String filter;
  /**
   * The maximum number of Organizations to return in the response.
   * This field is optional.
   */
  core.int pageSize;
  /**
   * A pagination token returned from a previous call to `SearchOrganizations`
   * that indicates from where listing should continue.
   * This field is optional.
   */
  core.String pageToken;

  SearchOrganizationsRequest();

  SearchOrganizationsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("filter")) {
      filter = _json["filter"];
    }
    if (_json.containsKey("pageSize")) {
      pageSize = _json["pageSize"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (filter != null) {
      _json["filter"] = filter;
    }
    if (pageSize != null) {
      _json["pageSize"] = pageSize;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    return _json;
  }
}

/** The response returned from the `SearchOrganizations` method. */
class SearchOrganizationsResponse {
  /**
   * A pagination token to be used to retrieve the next page of results. If the
   * result is too large to fit within the page size specified in the request,
   * this field will be set with a token that can be used to fetch the next page
   * of results. If this field is empty, it indicates that this response
   * contains the last page of results.
   */
  core.String nextPageToken;
  /**
   * The list of Organizations that matched the search query, possibly
   * paginated.
   */
  core.List<Organization> organizations;

  SearchOrganizationsResponse();

  SearchOrganizationsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("organizations")) {
      organizations = _json["organizations"].map((value) => new Organization.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (organizations != null) {
      _json["organizations"] = organizations.map((value) => (value).toJson()).toList();
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

  SetIamPolicyRequest();

  SetIamPolicyRequest.fromJson(core.Map _json) {
    if (_json.containsKey("policy")) {
      policy = new Policy.fromJson(_json["policy"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (policy != null) {
      _json["policy"] = (policy).toJson();
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
 * The request sent to the UndeleteProject
 * method.
 */
class UndeleteProjectRequest {

  UndeleteProjectRequest();

  UndeleteProjectRequest.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}
