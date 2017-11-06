// This is a generated file (see the discoveryapis_generator project).

library googleapis.spanner.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client spanner/v1';

/**
 * Cloud Spanner is a managed, mission-critical, globally consistent and
 * scalable relational database service.
 */
class SpannerApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";


  final commons.ApiRequester _requester;

  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);

  SpannerApi(http.Client client, {core.String rootUrl: "https://spanner.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsInstanceConfigsResourceApi get instanceConfigs => new ProjectsInstanceConfigsResourceApi(_requester);
  ProjectsInstancesResourceApi get instances => new ProjectsInstancesResourceApi(_requester);

  ProjectsResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class ProjectsInstanceConfigsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsInstanceConfigsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets information about a particular instance configuration.
   *
   * Request parameters:
   *
   * [name] - Required. The name of the requested instance configuration. Values
   * are of
   * the form `projects/<project>/instanceConfigs/<config>`.
   * Value must have pattern "^projects/[^/]+/instanceConfigs/[^/]+$".
   *
   * Completes with a [InstanceConfig].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<InstanceConfig> get(core.String name) {
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
    return _response.then((data) => new InstanceConfig.fromJson(data));
  }

  /**
   * Lists the supported instance configurations for a given project.
   *
   * Request parameters:
   *
   * [parent] - Required. The name of the project for which a list of supported
   * instance
   * configurations is requested. Values are of the form
   * `projects/<project>`.
   * Value must have pattern "^projects/[^/]+$".
   *
   * [pageToken] - If non-empty, `page_token` should contain a
   * next_page_token
   * from a previous ListInstanceConfigsResponse.
   *
   * [pageSize] - Number of instance configurations to be returned in the
   * response. If 0 or
   * less, defaults to the server's maximum allowed page size.
   *
   * Completes with a [ListInstanceConfigsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListInstanceConfigsResponse> list(core.String parent, {core.String pageToken, core.int pageSize}) {
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

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$parent') + '/instanceConfigs';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListInstanceConfigsResponse.fromJson(data));
  }

}


class ProjectsInstancesResourceApi {
  final commons.ApiRequester _requester;

  ProjectsInstancesDatabasesResourceApi get databases => new ProjectsInstancesDatabasesResourceApi(_requester);
  ProjectsInstancesOperationsResourceApi get operations => new ProjectsInstancesOperationsResourceApi(_requester);

  ProjectsInstancesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates an instance and begins preparing it to begin serving. The
   * returned long-running operation
   * can be used to track the progress of preparing the new
   * instance. The instance name is assigned by the caller. If the
   * named instance already exists, `CreateInstance` returns
   * `ALREADY_EXISTS`.
   *
   * Immediately upon completion of this request:
   *
   *   * The instance is readable via the API, with all requested attributes
   *     but no allocated resources. Its state is `CREATING`.
   *
   * Until completion of the returned operation:
   *
   *   * Cancelling the operation renders the instance immediately unreadable
   *     via the API.
   *   * The instance can be deleted.
   *   * All other attempts to modify the instance are rejected.
   *
   * Upon completion of the returned operation:
   *
   *   * Billing for all successfully-allocated resources begins (some types
   *     may have lower than the requested levels).
   *   * Databases can be created in the instance.
   *   * The instance's allocated resource levels are readable via the API.
   *   * The instance's state becomes `READY`.
   *
   * The returned long-running operation will
   * have a name of the format `<instance_name>/operations/<operation_id>` and
   * can be used to track creation of the instance.  The
   * metadata field type is
   * CreateInstanceMetadata.
   * The response field type is
   * Instance, if successful.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [parent] - Required. The name of the project in which to create the
   * instance. Values
   * are of the form `projects/<project>`.
   * Value must have pattern "^projects/[^/]+$".
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> create(CreateInstanceRequest request, core.String parent) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (parent == null) {
      throw new core.ArgumentError("Parameter parent is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$parent') + '/instances';

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
   * Deletes an instance.
   *
   * Immediately upon completion of the request:
   *
   *   * Billing ceases for all of the instance's reserved resources.
   *
   * Soon afterward:
   *
   *   * The instance and *all of its databases* immediately and
   *     irrevocably disappear from the API. All data in the databases
   *     is permanently deleted.
   *
   * Request parameters:
   *
   * [name] - Required. The name of the instance to be deleted. Values are of
   * the form
   * `projects/<project>/instances/<instance>`
   * Value must have pattern "^projects/[^/]+/instances/[^/]+$".
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
   * Gets information about a particular instance.
   *
   * Request parameters:
   *
   * [name] - Required. The name of the requested instance. Values are of the
   * form
   * `projects/<project>/instances/<instance>`.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+$".
   *
   * Completes with a [Instance].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Instance> get(core.String name) {
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
    return _response.then((data) => new Instance.fromJson(data));
  }

  /**
   * Gets the access control policy for an instance resource. Returns an empty
   * policy if an instance exists but does not have a policy set.
   *
   * Authorization requires `spanner.instances.getIamPolicy` on
   * resource.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The Cloud Spanner resource for which the policy is
   * being retrieved. The format is `projects/<project ID>/instances/<instance
   * ID>` for instance resources and `projects/<project ID>/instances/<instance
   * ID>/databases/<database ID>` for database resources.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+$".
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
   * Lists all instances in the given project.
   *
   * Request parameters:
   *
   * [parent] - Required. The name of the project for which a list of instances
   * is
   * requested. Values are of the form `projects/<project>`.
   * Value must have pattern "^projects/[^/]+$".
   *
   * [pageToken] - If non-empty, `page_token` should contain a
   * next_page_token from a
   * previous ListInstancesResponse.
   *
   * [pageSize] - Number of instances to be returned in the response. If 0 or
   * less, defaults
   * to the server's maximum allowed page size.
   *
   * [filter] - An expression for filtering the results of the request. Filter
   * rules are
   * case insensitive. The fields eligible for filtering are:
   *
   *   * name
   *   * display_name
   *   * labels.key where key is the name of a label
   *
   * Some examples of using filters are:
   *
   *   * name:* --> The instance has a name.
   *   * name:Howl --> The instance's name contains the string "howl".
   *   * name:HOWL --> Equivalent to above.
   *   * NAME:howl --> Equivalent to above.
   *   * labels.env:* --> The instance has the label "env".
   *   * labels.env:dev --> The instance has the label "env" and the value of
   *                        the label contains the string "dev".
   *   * name:howl labels.env:dev --> The instance's name contains "howl" and
   *                                  it has the label "env" with its value
   *                                  containing "dev".
   *
   * Completes with a [ListInstancesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListInstancesResponse> list(core.String parent, {core.String pageToken, core.int pageSize, core.String filter}) {
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
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$parent') + '/instances';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListInstancesResponse.fromJson(data));
  }

  /**
   * Updates an instance, and begins allocating or releasing resources
   * as requested. The returned long-running
   * operation can be used to track the
   * progress of updating the instance. If the named instance does not
   * exist, returns `NOT_FOUND`.
   *
   * Immediately upon completion of this request:
   *
   *   * For resource types for which a decrease in the instance's allocation
   *     has been requested, billing is based on the newly-requested level.
   *
   * Until completion of the returned operation:
   *
   *   * Cancelling the operation sets its metadata's
   *     cancel_time, and begins
   *     restoring resources to their pre-request values. The operation
   *     is guaranteed to succeed at undoing all resource changes,
   *     after which point it terminates with a `CANCELLED` status.
   *   * All other attempts to modify the instance are rejected.
   *   * Reading the instance via the API continues to give the pre-request
   *     resource levels.
   *
   * Upon completion of the returned operation:
   *
   *   * Billing begins for all successfully-allocated resources (some types
   *     may have lower than the requested levels).
   *   * All newly-reserved resources are available for serving the instance's
   *     tables.
   *   * The instance's new resource levels are readable via the API.
   *
   * The returned long-running operation will
   * have a name of the format `<instance_name>/operations/<operation_id>` and
   * can be used to track the instance modification.  The
   * metadata field type is
   * UpdateInstanceMetadata.
   * The response field type is
   * Instance, if successful.
   *
   * Authorization requires `spanner.instances.update` permission on
   * resource name.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - Required. A unique identifier for the instance, which cannot be
   * changed
   * after the instance is created. Values are of the form
   * `projects/<project>/instances/a-z*[a-z0-9]`. The final
   * segment of the name must be between 6 and 30 characters in length.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+$".
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> patch(UpdateInstanceRequest request, core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name');

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
   * Sets the access control policy on an instance resource. Replaces any
   * existing policy.
   *
   * Authorization requires `spanner.instances.setIamPolicy` on
   * resource.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The Cloud Spanner resource for which the policy is
   * being set. The format is `projects/<project ID>/instances/<instance ID>`
   * for instance resources and `projects/<project ID>/instances/<instance
   * ID>/databases/<database ID>` for databases resources.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+$".
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
   * Returns permissions that the caller has on the specified instance resource.
   *
   * Attempting this RPC on a non-existent Cloud Spanner instance resource will
   * result in a NOT_FOUND error if the user has `spanner.instances.list`
   * permission on the containing Google Cloud Project. Otherwise returns an
   * empty set of permissions.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The Cloud Spanner resource for which permissions are
   * being tested. The format is `projects/<project ID>/instances/<instance ID>`
   * for instance resources and `projects/<project ID>/instances/<instance
   * ID>/databases/<database ID>` for database resources.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+$".
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


class ProjectsInstancesDatabasesResourceApi {
  final commons.ApiRequester _requester;

  ProjectsInstancesDatabasesOperationsResourceApi get operations => new ProjectsInstancesDatabasesOperationsResourceApi(_requester);
  ProjectsInstancesDatabasesSessionsResourceApi get sessions => new ProjectsInstancesDatabasesSessionsResourceApi(_requester);

  ProjectsInstancesDatabasesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new Cloud Spanner database and starts to prepare it for serving.
   * The returned long-running operation will
   * have a name of the format `<database_name>/operations/<operation_id>` and
   * can be used to track preparation of the database. The
   * metadata field type is
   * CreateDatabaseMetadata. The
   * response field type is
   * Database, if successful.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [parent] - Required. The name of the instance that will serve the new
   * database.
   * Values are of the form `projects/<project>/instances/<instance>`.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+$".
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> create(CreateDatabaseRequest request, core.String parent) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (parent == null) {
      throw new core.ArgumentError("Parameter parent is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$parent') + '/databases';

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
   * Drops (aka deletes) a Cloud Spanner database.
   *
   * Request parameters:
   *
   * [database] - Required. The database to be dropped.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+/databases/[^/]+$".
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> dropDatabase(core.String database) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (database == null) {
      throw new core.ArgumentError("Parameter database is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$database');

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
   * Gets the state of a Cloud Spanner database.
   *
   * Request parameters:
   *
   * [name] - Required. The name of the requested database. Values are of the
   * form
   * `projects/<project>/instances/<instance>/databases/<database>`.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+/databases/[^/]+$".
   *
   * Completes with a [Database].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Database> get(core.String name) {
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
    return _response.then((data) => new Database.fromJson(data));
  }

  /**
   * Returns the schema of a Cloud Spanner database as a list of formatted
   * DDL statements. This method does not show pending schema updates, those may
   * be queried using the Operations API.
   *
   * Request parameters:
   *
   * [database] - Required. The database whose schema we wish to get.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+/databases/[^/]+$".
   *
   * Completes with a [GetDatabaseDdlResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetDatabaseDdlResponse> getDdl(core.String database) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (database == null) {
      throw new core.ArgumentError("Parameter database is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$database') + '/ddl';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetDatabaseDdlResponse.fromJson(data));
  }

  /**
   * Gets the access control policy for a database resource. Returns an empty
   * policy if a database exists but does not have a policy set.
   *
   * Authorization requires `spanner.databases.getIamPolicy` permission on
   * resource.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The Cloud Spanner resource for which the policy is
   * being retrieved. The format is `projects/<project ID>/instances/<instance
   * ID>` for instance resources and `projects/<project ID>/instances/<instance
   * ID>/databases/<database ID>` for database resources.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+/databases/[^/]+$".
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
   * Lists Cloud Spanner databases.
   *
   * Request parameters:
   *
   * [parent] - Required. The instance whose databases should be listed.
   * Values are of the form `projects/<project>/instances/<instance>`.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+$".
   *
   * [pageToken] - If non-empty, `page_token` should contain a
   * next_page_token from a
   * previous ListDatabasesResponse.
   *
   * [pageSize] - Number of databases to be returned in the response. If 0 or
   * less,
   * defaults to the server's maximum allowed page size.
   *
   * Completes with a [ListDatabasesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListDatabasesResponse> list(core.String parent, {core.String pageToken, core.int pageSize}) {
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

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$parent') + '/databases';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListDatabasesResponse.fromJson(data));
  }

  /**
   * Sets the access control policy on a database resource. Replaces any
   * existing policy.
   *
   * Authorization requires `spanner.databases.setIamPolicy` permission on
   * resource.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The Cloud Spanner resource for which the policy is
   * being set. The format is `projects/<project ID>/instances/<instance ID>`
   * for instance resources and `projects/<project ID>/instances/<instance
   * ID>/databases/<database ID>` for databases resources.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+/databases/[^/]+$".
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
   * Returns permissions that the caller has on the specified database resource.
   *
   * Attempting this RPC on a non-existent Cloud Spanner database will result in
   * a NOT_FOUND error if the user has `spanner.databases.list` permission on
   * the containing Cloud Spanner instance. Otherwise returns an empty set of
   * permissions.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The Cloud Spanner resource for which permissions are
   * being tested. The format is `projects/<project ID>/instances/<instance ID>`
   * for instance resources and `projects/<project ID>/instances/<instance
   * ID>/databases/<database ID>` for database resources.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+/databases/[^/]+$".
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

  /**
   * Updates the schema of a Cloud Spanner database by
   * creating/altering/dropping tables, columns, indexes, etc. The returned
   * long-running operation will have a name of
   * the format `<database_name>/operations/<operation_id>` and can be used to
   * track execution of the schema change(s). The
   * metadata field type is
   * UpdateDatabaseDdlMetadata.  The operation has no response.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [database] - Required. The database to update.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+/databases/[^/]+$".
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> updateDdl(UpdateDatabaseDdlRequest request, core.String database) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (database == null) {
      throw new core.ArgumentError("Parameter database is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$database') + '/ddl';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

}


class ProjectsInstancesDatabasesOperationsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsInstancesDatabasesOperationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Starts asynchronous cancellation on a long-running operation.  The server
   * makes a best effort to cancel the operation, but success is not
   * guaranteed.  If the server doesn't support this method, it returns
   * `google.rpc.Code.UNIMPLEMENTED`.  Clients can use
   * Operations.GetOperation or
   * other methods to check whether the cancellation succeeded or whether the
   * operation completed despite cancellation. On successful cancellation,
   * the operation is not deleted; instead, it becomes an operation with
   * an Operation.error value with a google.rpc.Status.code of 1,
   * corresponding to `Code.CANCELLED`.
   *
   * Request parameters:
   *
   * [name] - The name of the operation resource to be cancelled.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/operations/[^/]+$".
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> cancel(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + ':cancel';

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
   * Deletes a long-running operation. This method indicates that the client is
   * no longer interested in the operation result. It does not cancel the
   * operation. If the server doesn't support this method, it returns
   * `google.rpc.Code.UNIMPLEMENTED`.
   *
   * Request parameters:
   *
   * [name] - The name of the operation resource to be deleted.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/operations/[^/]+$".
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
   * Gets the latest state of a long-running operation.  Clients can use this
   * method to poll the operation result at intervals as recommended by the API
   * service.
   *
   * Request parameters:
   *
   * [name] - The name of the operation resource.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/operations/[^/]+$".
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

  /**
   * Lists operations that match the specified filter in the request. If the
   * server doesn't support this method, it returns `UNIMPLEMENTED`.
   *
   * NOTE: the `name` binding below allows API services to override the binding
   * to use different resource name schemes, such as `users / * /operations`.
   *
   * Request parameters:
   *
   * [name] - The name of the operation collection.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/operations$".
   *
   * [filter] - The standard list filter.
   *
   * [pageToken] - The standard list page token.
   *
   * [pageSize] - The standard list page size.
   *
   * Completes with a [ListOperationsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListOperationsResponse> list(core.String name, {core.String filter, core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListOperationsResponse.fromJson(data));
  }

}


class ProjectsInstancesDatabasesSessionsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsInstancesDatabasesSessionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Begins a new transaction. This step can often be skipped:
   * Read, ExecuteSql and
   * Commit can begin a new transaction as a
   * side-effect.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [session] - Required. The session in which the transaction runs.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/sessions/[^/]+$".
   *
   * Completes with a [Transaction].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Transaction> beginTransaction(BeginTransactionRequest request, core.String session) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (session == null) {
      throw new core.ArgumentError("Parameter session is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$session') + ':beginTransaction';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Transaction.fromJson(data));
  }

  /**
   * Commits a transaction. The request includes the mutations to be
   * applied to rows in the database.
   *
   * `Commit` might return an `ABORTED` error. This can occur at any time;
   * commonly, the cause is conflicts with concurrent
   * transactions. However, it can also happen for a variety of other
   * reasons. If `Commit` returns `ABORTED`, the caller should re-attempt
   * the transaction from the beginning, re-using the same session.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [session] - Required. The session in which the transaction to be committed
   * is running.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/sessions/[^/]+$".
   *
   * Completes with a [CommitResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommitResponse> commit(CommitRequest request, core.String session) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (session == null) {
      throw new core.ArgumentError("Parameter session is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$session') + ':commit';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommitResponse.fromJson(data));
  }

  /**
   * Creates a new session. A session can be used to perform
   * transactions that read and/or modify data in a Cloud Spanner database.
   * Sessions are meant to be reused for many consecutive
   * transactions.
   *
   * Sessions can only execute one transaction at a time. To execute
   * multiple concurrent read-write/write-only transactions, create
   * multiple sessions. Note that standalone reads and queries use a
   * transaction internally, and count toward the one transaction
   * limit.
   *
   * Cloud Spanner limits the number of sessions that can exist at any given
   * time; thus, it is a good idea to delete idle and/or unneeded sessions.
   * Aside from explicit deletes, Cloud Spanner can delete sessions for
   * which no operations are sent for more than an hour, or due to
   * internal errors. If a session is deleted, requests to it
   * return `NOT_FOUND`.
   *
   * Idle sessions can be kept alive by sending a trivial SQL query
   * periodically, e.g., `"SELECT 1"`.
   *
   * Request parameters:
   *
   * [database] - Required. The database in which the new session is created.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+/databases/[^/]+$".
   *
   * Completes with a [Session].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Session> create(core.String database) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (database == null) {
      throw new core.ArgumentError("Parameter database is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$database') + '/sessions';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Session.fromJson(data));
  }

  /**
   * Ends a session, releasing server resources associated with it.
   *
   * Request parameters:
   *
   * [name] - Required. The name of the session to delete.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/sessions/[^/]+$".
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
   * Executes an SQL query, returning all rows in a single reply. This
   * method cannot be used to return a result set larger than 10 MiB;
   * if the query yields more data than that, the query fails with
   * a `FAILED_PRECONDITION` error.
   *
   * Queries inside read-write transactions might return `ABORTED`. If
   * this occurs, the application should restart the transaction from
   * the beginning. See Transaction for more details.
   *
   * Larger result sets can be fetched in streaming fashion by calling
   * ExecuteStreamingSql instead.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [session] - Required. The session in which the SQL query should be
   * performed.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/sessions/[^/]+$".
   *
   * Completes with a [ResultSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ResultSet> executeSql(ExecuteSqlRequest request, core.String session) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (session == null) {
      throw new core.ArgumentError("Parameter session is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$session') + ':executeSql';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ResultSet.fromJson(data));
  }

  /**
   * Like ExecuteSql, except returns the result
   * set as a stream. Unlike ExecuteSql, there
   * is no limit on the size of the returned result set. However, no
   * individual row in the result set can exceed 100 MiB, and no
   * column value can exceed 10 MiB.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [session] - Required. The session in which the SQL query should be
   * performed.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/sessions/[^/]+$".
   *
   * Completes with a [PartialResultSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PartialResultSet> executeStreamingSql(ExecuteSqlRequest request, core.String session) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (session == null) {
      throw new core.ArgumentError("Parameter session is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$session') + ':executeStreamingSql';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PartialResultSet.fromJson(data));
  }

  /**
   * Gets a session. Returns `NOT_FOUND` if the session does not exist.
   * This is mainly useful for determining whether a session is still
   * alive.
   *
   * Request parameters:
   *
   * [name] - Required. The name of the session to retrieve.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/sessions/[^/]+$".
   *
   * Completes with a [Session].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Session> get(core.String name) {
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
    return _response.then((data) => new Session.fromJson(data));
  }

  /**
   * Reads rows from the database using key lookups and scans, as a
   * simple key/value style alternative to
   * ExecuteSql.  This method cannot be used to
   * return a result set larger than 10 MiB; if the read matches more
   * data than that, the read fails with a `FAILED_PRECONDITION`
   * error.
   *
   * Reads inside read-write transactions might return `ABORTED`. If
   * this occurs, the application should restart the transaction from
   * the beginning. See Transaction for more details.
   *
   * Larger result sets can be yielded in streaming fashion by calling
   * StreamingRead instead.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [session] - Required. The session in which the read should be performed.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/sessions/[^/]+$".
   *
   * Completes with a [ResultSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ResultSet> read(ReadRequest request, core.String session) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (session == null) {
      throw new core.ArgumentError("Parameter session is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$session') + ':read';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ResultSet.fromJson(data));
  }

  /**
   * Rolls back a transaction, releasing any locks it holds. It is a good
   * idea to call this for any transaction that includes one or more
   * Read or ExecuteSql requests and
   * ultimately decides not to commit.
   *
   * `Rollback` returns `OK` if it successfully aborts the transaction, the
   * transaction was already aborted, or the transaction is not
   * found. `Rollback` never returns `ABORTED`.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [session] - Required. The session in which the transaction to roll back is
   * running.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/sessions/[^/]+$".
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> rollback(RollbackRequest request, core.String session) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (session == null) {
      throw new core.ArgumentError("Parameter session is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$session') + ':rollback';

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
   * Like Read, except returns the result set as a
   * stream. Unlike Read, there is no limit on the
   * size of the returned result set. However, no individual row in
   * the result set can exceed 100 MiB, and no column value can exceed
   * 10 MiB.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [session] - Required. The session in which the read should be performed.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/databases/[^/]+/sessions/[^/]+$".
   *
   * Completes with a [PartialResultSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PartialResultSet> streamingRead(ReadRequest request, core.String session) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (session == null) {
      throw new core.ArgumentError("Parameter session is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$session') + ':streamingRead';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PartialResultSet.fromJson(data));
  }

}


class ProjectsInstancesOperationsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsInstancesOperationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Starts asynchronous cancellation on a long-running operation.  The server
   * makes a best effort to cancel the operation, but success is not
   * guaranteed.  If the server doesn't support this method, it returns
   * `google.rpc.Code.UNIMPLEMENTED`.  Clients can use
   * Operations.GetOperation or
   * other methods to check whether the cancellation succeeded or whether the
   * operation completed despite cancellation. On successful cancellation,
   * the operation is not deleted; instead, it becomes an operation with
   * an Operation.error value with a google.rpc.Status.code of 1,
   * corresponding to `Code.CANCELLED`.
   *
   * Request parameters:
   *
   * [name] - The name of the operation resource to be cancelled.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/operations/[^/]+$".
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> cancel(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + ':cancel';

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
   * Deletes a long-running operation. This method indicates that the client is
   * no longer interested in the operation result. It does not cancel the
   * operation. If the server doesn't support this method, it returns
   * `google.rpc.Code.UNIMPLEMENTED`.
   *
   * Request parameters:
   *
   * [name] - The name of the operation resource to be deleted.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/operations/[^/]+$".
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
   * Gets the latest state of a long-running operation.  Clients can use this
   * method to poll the operation result at intervals as recommended by the API
   * service.
   *
   * Request parameters:
   *
   * [name] - The name of the operation resource.
   * Value must have pattern
   * "^projects/[^/]+/instances/[^/]+/operations/[^/]+$".
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

  /**
   * Lists operations that match the specified filter in the request. If the
   * server doesn't support this method, it returns `UNIMPLEMENTED`.
   *
   * NOTE: the `name` binding below allows API services to override the binding
   * to use different resource name schemes, such as `users / * /operations`.
   *
   * Request parameters:
   *
   * [name] - The name of the operation collection.
   * Value must have pattern "^projects/[^/]+/instances/[^/]+/operations$".
   *
   * [pageToken] - The standard list page token.
   *
   * [pageSize] - The standard list page size.
   *
   * [filter] - The standard list filter.
   *
   * Completes with a [ListOperationsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListOperationsResponse> list(core.String name, {core.String pageToken, core.int pageSize, core.String filter}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListOperationsResponse.fromJson(data));
  }

}



/**
 * Specifies the audit configuration for a service.
 * It consists of which permission types are logged, and what identities, if
 * any, are exempted from logging.
 * An AuditConifg must have one or more AuditLogConfigs.
 */
class AuditConfig {
  /**
   * The configuration for logging of each type of permission.
   * Next ID: 4
   */
  core.List<AuditLogConfig> auditLogConfigs;
  /**
   * Specifies the identities that are exempted from "data access" audit
   * logging for the `service` specified above.
   * Follows the same format of Binding.members.
   * This field is deprecated in favor of per-permission-type exemptions.
   */
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

/** The request for BeginTransaction. */
class BeginTransactionRequest {
  /** Required. Options for the new transaction. */
  TransactionOptions options;

  BeginTransactionRequest();

  BeginTransactionRequest.fromJson(core.Map _json) {
    if (_json.containsKey("options")) {
      options = new TransactionOptions.fromJson(_json["options"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (options != null) {
      _json["options"] = (options).toJson();
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
 * Metadata associated with a parent-child relationship appearing in a
 * PlanNode.
 */
class ChildLink {
  /** The node to which the link points. */
  core.int childIndex;
  /**
   * The type of the link. For example, in Hash Joins this could be used to
   * distinguish between the build child and the probe child, or in the case
   * of the child being an output variable, to represent the tag associated
   * with the output variable.
   */
  core.String type;
  /**
   * Only present if the child node is SCALAR and corresponds
   * to an output variable of the parent node. The field carries the name of
   * the output variable.
   * For example, a `TableScan` operator that reads rows from a table will
   * have child links to the `SCALAR` nodes representing the output variables
   * created for each column that is read by the operator. The corresponding
   * `variable` fields will be set to the variable names assigned to the
   * columns.
   */
  core.String variable;

  ChildLink();

  ChildLink.fromJson(core.Map _json) {
    if (_json.containsKey("childIndex")) {
      childIndex = _json["childIndex"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("variable")) {
      variable = _json["variable"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (childIndex != null) {
      _json["childIndex"] = childIndex;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (variable != null) {
      _json["variable"] = variable;
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

/** The request for Commit. */
class CommitRequest {
  /**
   * The mutations to be executed when this transaction commits. All
   * mutations are applied atomically, in the order they appear in
   * this list.
   */
  core.List<Mutation> mutations;
  /**
   * Execute mutations in a temporary transaction. Note that unlike
   * commit of a previously-started transaction, commit with a
   * temporary transaction is non-idempotent. That is, if the
   * `CommitRequest` is sent to Cloud Spanner more than once (for
   * instance, due to retries in the application, or in the
   * transport library), it is possible that the mutations are
   * executed more than once. If this is undesirable, use
   * BeginTransaction and
   * Commit instead.
   */
  TransactionOptions singleUseTransaction;
  /** Commit a previously-started transaction. */
  core.String transactionId;
  core.List<core.int> get transactionIdAsBytes {
    return convert.BASE64.decode(transactionId);
  }

  void set transactionIdAsBytes(core.List<core.int> _bytes) {
    transactionId = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  CommitRequest();

  CommitRequest.fromJson(core.Map _json) {
    if (_json.containsKey("mutations")) {
      mutations = _json["mutations"].map((value) => new Mutation.fromJson(value)).toList();
    }
    if (_json.containsKey("singleUseTransaction")) {
      singleUseTransaction = new TransactionOptions.fromJson(_json["singleUseTransaction"]);
    }
    if (_json.containsKey("transactionId")) {
      transactionId = _json["transactionId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (mutations != null) {
      _json["mutations"] = mutations.map((value) => (value).toJson()).toList();
    }
    if (singleUseTransaction != null) {
      _json["singleUseTransaction"] = (singleUseTransaction).toJson();
    }
    if (transactionId != null) {
      _json["transactionId"] = transactionId;
    }
    return _json;
  }
}

/** The response for Commit. */
class CommitResponse {
  /** The Cloud Spanner timestamp at which the transaction committed. */
  core.String commitTimestamp;

  CommitResponse();

  CommitResponse.fromJson(core.Map _json) {
    if (_json.containsKey("commitTimestamp")) {
      commitTimestamp = _json["commitTimestamp"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (commitTimestamp != null) {
      _json["commitTimestamp"] = commitTimestamp;
    }
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
   * - "SECURITY_REALM" : Any of the security realms in the IAMContext
   * (go/security-realms).
   * When used with IN, the condition indicates "any of the request's realms
   * match one of the given values; with NOT_IN, "none of the realms match
   * any of the given values". It is not permitted to grant access based on
   * the *absence* of a realm, so realm conditions can only be used in
   * a "positive" context (e.g., ALLOW/IN or DENY/NOT_IN).
   */
  core.String iam;
  /**
   * An operator to apply the subject with.
   * Possible string values are:
   * - "NO_OP" : Default no-op.
   * - "EQUALS" : DEPRECATED. Use IN instead.
   * - "NOT_EQUALS" : DEPRECATED. Use NOT_IN instead.
   * - "IN" : Set-inclusion check.
   * - "NOT_IN" : Set-exclusion check.
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
 * Metadata type for the operation returned by
 * CreateDatabase.
 */
class CreateDatabaseMetadata {
  /** The database being created. */
  core.String database;

  CreateDatabaseMetadata();

  CreateDatabaseMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("database")) {
      database = _json["database"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (database != null) {
      _json["database"] = database;
    }
    return _json;
  }
}

/** The request for CreateDatabase. */
class CreateDatabaseRequest {
  /**
   * Required. A `CREATE DATABASE` statement, which specifies the ID of the
   * new database.  The database ID must conform to the regular expression
   * `a-z*[a-z0-9]` and be between 2 and 30 characters in length.
   */
  core.String createStatement;
  /**
   * An optional list of DDL statements to run inside the newly created
   * database. Statements can create tables, indexes, etc. These
   * statements execute atomically with the creation of the database:
   * if there is an error in any statement, the database is not created.
   */
  core.List<core.String> extraStatements;

  CreateDatabaseRequest();

  CreateDatabaseRequest.fromJson(core.Map _json) {
    if (_json.containsKey("createStatement")) {
      createStatement = _json["createStatement"];
    }
    if (_json.containsKey("extraStatements")) {
      extraStatements = _json["extraStatements"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (createStatement != null) {
      _json["createStatement"] = createStatement;
    }
    if (extraStatements != null) {
      _json["extraStatements"] = extraStatements;
    }
    return _json;
  }
}

/**
 * Metadata type for the operation returned by
 * CreateInstance.
 */
class CreateInstanceMetadata {
  /**
   * The time at which this operation was cancelled. If set, this operation is
   * in the process of undoing itself (which is guaranteed to succeed) and
   * cannot be cancelled again.
   */
  core.String cancelTime;
  /** The time at which this operation failed or was completed successfully. */
  core.String endTime;
  /** The instance being created. */
  Instance instance;
  /**
   * The time at which the
   * CreateInstance request was
   * received.
   */
  core.String startTime;

  CreateInstanceMetadata();

  CreateInstanceMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("cancelTime")) {
      cancelTime = _json["cancelTime"];
    }
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("instance")) {
      instance = new Instance.fromJson(_json["instance"]);
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cancelTime != null) {
      _json["cancelTime"] = cancelTime;
    }
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (instance != null) {
      _json["instance"] = (instance).toJson();
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

/** The request for CreateInstance. */
class CreateInstanceRequest {
  /**
   * Required. The instance to create.  The name may be omitted, but if
   * specified must be `<parent>/instances/<instance_id>`.
   */
  Instance instance;
  /**
   * Required. The ID of the instance to create.  Valid identifiers are of the
   * form `a-z*[a-z0-9]` and must be between 6 and 30 characters in
   * length.
   */
  core.String instanceId;

  CreateInstanceRequest();

  CreateInstanceRequest.fromJson(core.Map _json) {
    if (_json.containsKey("instance")) {
      instance = new Instance.fromJson(_json["instance"]);
    }
    if (_json.containsKey("instanceId")) {
      instanceId = _json["instanceId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (instance != null) {
      _json["instance"] = (instance).toJson();
    }
    if (instanceId != null) {
      _json["instanceId"] = instanceId;
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

/** A Cloud Spanner database. */
class Database {
  /**
   * Required. The name of the database. Values are of the form
   * `projects/<project>/instances/<instance>/databases/<database>`,
   * where `<database>` is as specified in the `CREATE DATABASE`
   * statement. This name can be passed to other API methods to
   * identify the database.
   */
  core.String name;
  /**
   * Output only. The current database state.
   * Possible string values are:
   * - "STATE_UNSPECIFIED" : Not specified.
   * - "CREATING" : The database is still being created. Operations on the
   * database may fail
   * with `FAILED_PRECONDITION` in this state.
   * - "READY" : The database is fully created and ready for use.
   */
  core.String state;

  Database();

  Database.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (state != null) {
      _json["state"] = state;
    }
    return _json;
  }
}

/** Arguments to delete operations. */
class Delete {
  /** Required. The primary keys of the rows within table to delete. */
  KeySet keySet;
  /** Required. The table whose rows will be deleted. */
  core.String table;

  Delete();

  Delete.fromJson(core.Map _json) {
    if (_json.containsKey("keySet")) {
      keySet = new KeySet.fromJson(_json["keySet"]);
    }
    if (_json.containsKey("table")) {
      table = _json["table"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (keySet != null) {
      _json["keySet"] = (keySet).toJson();
    }
    if (table != null) {
      _json["table"] = table;
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

/**
 * The request for ExecuteSql and
 * ExecuteStreamingSql.
 */
class ExecuteSqlRequest {
  /**
   * It is not always possible for Cloud Spanner to infer the right SQL type
   * from a JSON value.  For example, values of type `BYTES` and values
   * of type `STRING` both appear in params as JSON strings.
   *
   * In these cases, `param_types` can be used to specify the exact
   * SQL type for some or all of the SQL query parameters. See the
   * definition of Type for more information
   * about SQL types.
   */
  core.Map<core.String, Type> paramTypes;
  /**
   * The SQL query string can contain parameter placeholders. A parameter
   * placeholder consists of `'@'` followed by the parameter
   * name. Parameter names consist of any combination of letters,
   * numbers, and underscores.
   *
   * Parameters can appear anywhere that a literal value is expected.  The same
   * parameter name can be used more than once, for example:
   *   `"WHERE id > @msg_id AND id < @msg_id + 100"`
   *
   * It is an error to execute an SQL query with unbound parameters.
   *
   * Parameter values are specified using `params`, which is a JSON
   * object whose keys are parameter names, and whose values are the
   * corresponding parameter values.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> params;
  /**
   * Used to control the amount of debugging information returned in
   * ResultSetStats.
   * Possible string values are:
   * - "NORMAL" : The default mode where only the query result, without any
   * information
   * about the query plan is returned.
   * - "PLAN" : This mode returns only the query plan, without any result rows
   * or
   * execution statistics information.
   * - "PROFILE" : This mode returns both the query plan and the execution
   * statistics along
   * with the result rows.
   */
  core.String queryMode;
  /**
   * If this request is resuming a previously interrupted SQL query
   * execution, `resume_token` should be copied from the last
   * PartialResultSet yielded before the interruption. Doing this
   * enables the new SQL query execution to resume where the last one left
   * off. The rest of the request parameters must exactly match the
   * request that yielded this token.
   */
  core.String resumeToken;
  core.List<core.int> get resumeTokenAsBytes {
    return convert.BASE64.decode(resumeToken);
  }

  void set resumeTokenAsBytes(core.List<core.int> _bytes) {
    resumeToken = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** Required. The SQL query string. */
  core.String sql;
  /**
   * The transaction to use. If none is provided, the default is a
   * temporary read-only transaction with strong concurrency.
   */
  TransactionSelector transaction;

  ExecuteSqlRequest();

  ExecuteSqlRequest.fromJson(core.Map _json) {
    if (_json.containsKey("paramTypes")) {
      paramTypes = commons.mapMap(_json["paramTypes"], (item) => new Type.fromJson(item));
    }
    if (_json.containsKey("params")) {
      params = _json["params"];
    }
    if (_json.containsKey("queryMode")) {
      queryMode = _json["queryMode"];
    }
    if (_json.containsKey("resumeToken")) {
      resumeToken = _json["resumeToken"];
    }
    if (_json.containsKey("sql")) {
      sql = _json["sql"];
    }
    if (_json.containsKey("transaction")) {
      transaction = new TransactionSelector.fromJson(_json["transaction"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (paramTypes != null) {
      _json["paramTypes"] = commons.mapMap(paramTypes, (item) => (item).toJson());
    }
    if (params != null) {
      _json["params"] = params;
    }
    if (queryMode != null) {
      _json["queryMode"] = queryMode;
    }
    if (resumeToken != null) {
      _json["resumeToken"] = resumeToken;
    }
    if (sql != null) {
      _json["sql"] = sql;
    }
    if (transaction != null) {
      _json["transaction"] = (transaction).toJson();
    }
    return _json;
  }
}

/** Message representing a single field of a struct. */
class Field {
  /**
   * The name of the field. For reads, this is the column name. For
   * SQL queries, it is the column alias (e.g., `"Word"` in the
   * query `"SELECT 'hello' AS Word"`), or the column name (e.g.,
   * `"ColName"` in the query `"SELECT ColName FROM Table"`). Some
   * columns might have an empty name (e.g., !"SELECT
   * UPPER(ColName)"`). Note that a query result can contain
   * multiple fields with the same name.
   */
  core.String name;
  /** The type of the field. */
  Type type;

  Field();

  Field.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = new Type.fromJson(_json["type"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (type != null) {
      _json["type"] = (type).toJson();
    }
    return _json;
  }
}

/** The response for GetDatabaseDdl. */
class GetDatabaseDdlResponse {
  /**
   * A list of formatted DDL statements defining the schema of the database
   * specified in the request.
   */
  core.List<core.String> statements;

  GetDatabaseDdlResponse();

  GetDatabaseDdlResponse.fromJson(core.Map _json) {
    if (_json.containsKey("statements")) {
      statements = _json["statements"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (statements != null) {
      _json["statements"] = statements;
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
 * An isolated set of Cloud Spanner resources on which databases can be hosted.
 */
class Instance {
  /**
   * Required. The name of the instance's configuration. Values are of the form
   * `projects/<project>/instanceConfigs/<configuration>`. See
   * also InstanceConfig and
   * ListInstanceConfigs.
   */
  core.String config;
  /**
   * Required. The descriptive name for this instance as it appears in UIs.
   * Must be unique per project and between 4 and 30 characters in length.
   */
  core.String displayName;
  /**
   * Cloud Labels are a flexible and lightweight mechanism for organizing cloud
   * resources into groups that reflect a customer's organizational needs and
   * deployment strategies. Cloud Labels can be used to filter collections of
   * resources. They can be used to control how resource metrics are aggregated.
   * And they can be used as arguments to policy management rules (e.g. route,
   * firewall, load balancing, etc.).
   *
   *  * Label keys must be between 1 and 63 characters long and must conform to
   *    the following regular expression: `[a-z]([-a-z0-9]*[a-z0-9])?`.
   *  * Label values must be between 0 and 63 characters long and must conform
   *    to the regular expression `([a-z]([-a-z0-9]*[a-z0-9])?)?`.
   *  * No more than 64 labels can be associated with a given resource.
   *
   * See https://goo.gl/xmQnxf for more information on and examples of labels.
   *
   * If you plan to use labels in your own code, please note that additional
   * characters may be allowed in the future. And so you are advised to use an
   * internal label representation, such as JSON, which doesn't rely upon
   * specific characters being disallowed.  For example, representing labels
   * as the string:  name + "_" + value  would prove problematic if we were to
   * allow "_" in a future release.
   */
  core.Map<core.String, core.String> labels;
  /**
   * Required. A unique identifier for the instance, which cannot be changed
   * after the instance is created. Values are of the form
   * `projects/<project>/instances/a-z*[a-z0-9]`. The final
   * segment of the name must be between 6 and 30 characters in length.
   */
  core.String name;
  /** Required. The number of nodes allocated to this instance. */
  core.int nodeCount;
  /**
   * Output only. The current instance state. For
   * CreateInstance, the state must be
   * either omitted or set to `CREATING`. For
   * UpdateInstance, the state must be
   * either omitted or set to `READY`.
   * Possible string values are:
   * - "STATE_UNSPECIFIED" : Not specified.
   * - "CREATING" : The instance is still being created. Resources may not be
   * available yet, and operations such as database creation may not
   * work.
   * - "READY" : The instance is fully created and ready to do work such as
   * creating databases.
   */
  core.String state;

  Instance();

  Instance.fromJson(core.Map _json) {
    if (_json.containsKey("config")) {
      config = _json["config"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("nodeCount")) {
      nodeCount = _json["nodeCount"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (config != null) {
      _json["config"] = config;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (nodeCount != null) {
      _json["nodeCount"] = nodeCount;
    }
    if (state != null) {
      _json["state"] = state;
    }
    return _json;
  }
}

/**
 * A possible configuration for a Cloud Spanner instance. Configurations
 * define the geographic placement of nodes and their replication.
 */
class InstanceConfig {
  /** The name of this instance configuration as it appears in UIs. */
  core.String displayName;
  /**
   * A unique identifier for the instance configuration.  Values
   * are of the form
   * `projects/<project>/instanceConfigs/a-z*`
   */
  core.String name;

  InstanceConfig();

  InstanceConfig.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/**
 * KeyRange represents a range of rows in a table or index.
 *
 * A range has a start key and an end key. These keys can be open or
 * closed, indicating if the range includes rows with that key.
 *
 * Keys are represented by lists, where the ith value in the list
 * corresponds to the ith component of the table or index primary key.
 * Individual values are encoded as described here.
 *
 * For example, consider the following table definition:
 *
 *     CREATE TABLE UserEvents (
 *       UserName STRING(MAX),
 *       EventDate STRING(10)
 *     ) PRIMARY KEY(UserName, EventDate);
 *
 * The following keys name rows in this table:
 *
 *     "Bob", "2014-09-23"
 *
 * Since the `UserEvents` table's `PRIMARY KEY` clause names two
 * columns, each `UserEvents` key has two elements; the first is the
 * `UserName`, and the second is the `EventDate`.
 *
 * Key ranges with multiple components are interpreted
 * lexicographically by component using the table or index key's declared
 * sort order. For example, the following range returns all events for
 * user `"Bob"` that occurred in the year 2015:
 *
 *     "start_closed": ["Bob", "2015-01-01"]
 *     "end_closed": ["Bob", "2015-12-31"]
 *
 * Start and end keys can omit trailing key components. This affects the
 * inclusion and exclusion of rows that exactly match the provided key
 * components: if the key is closed, then rows that exactly match the
 * provided components are included; if the key is open, then rows
 * that exactly match are not included.
 *
 * For example, the following range includes all events for `"Bob"` that
 * occurred during and after the year 2000:
 *
 *     "start_closed": ["Bob", "2000-01-01"]
 *     "end_closed": ["Bob"]
 *
 * The next example retrieves all events for `"Bob"`:
 *
 *     "start_closed": ["Bob"]
 *     "end_closed": ["Bob"]
 *
 * To retrieve events before the year 2000:
 *
 *     "start_closed": ["Bob"]
 *     "end_open": ["Bob", "2000-01-01"]
 *
 * The following range includes all rows in the table:
 *
 *     "start_closed": []
 *     "end_closed": []
 *
 * This range returns all users whose `UserName` begins with any
 * character from A to C:
 *
 *     "start_closed": ["A"]
 *     "end_open": ["D"]
 *
 * This range returns all users whose `UserName` begins with B:
 *
 *     "start_closed": ["B"]
 *     "end_open": ["C"]
 *
 * Key ranges honor column sort order. For example, suppose a table is
 * defined as follows:
 *
 *     CREATE TABLE DescendingSortedTable {
 *       Key INT64,
 *       ...
 *     ) PRIMARY KEY(Key DESC);
 *
 * The following range retrieves all rows with key values between 1
 * and 100 inclusive:
 *
 *     "start_closed": ["100"]
 *     "end_closed": ["1"]
 *
 * Note that 100 is passed as the start, and 1 is passed as the end,
 * because `Key` is a descending column in the schema.
 */
class KeyRange {
  /**
   * If the end is closed, then the range includes all rows whose
   * first `len(end_closed)` key columns exactly match `end_closed`.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> endClosed;
  /**
   * If the end is open, then the range excludes rows whose first
   * `len(end_open)` key columns exactly match `end_open`.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> endOpen;
  /**
   * If the start is closed, then the range includes all rows whose
   * first `len(start_closed)` key columns exactly match `start_closed`.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> startClosed;
  /**
   * If the start is open, then the range excludes rows whose first
   * `len(start_open)` key columns exactly match `start_open`.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> startOpen;

  KeyRange();

  KeyRange.fromJson(core.Map _json) {
    if (_json.containsKey("endClosed")) {
      endClosed = _json["endClosed"];
    }
    if (_json.containsKey("endOpen")) {
      endOpen = _json["endOpen"];
    }
    if (_json.containsKey("startClosed")) {
      startClosed = _json["startClosed"];
    }
    if (_json.containsKey("startOpen")) {
      startOpen = _json["startOpen"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endClosed != null) {
      _json["endClosed"] = endClosed;
    }
    if (endOpen != null) {
      _json["endOpen"] = endOpen;
    }
    if (startClosed != null) {
      _json["startClosed"] = startClosed;
    }
    if (startOpen != null) {
      _json["startOpen"] = startOpen;
    }
    return _json;
  }
}

/**
 * `KeySet` defines a collection of Cloud Spanner keys and/or key ranges. All
 * the keys are expected to be in the same table or index. The keys need
 * not be sorted in any particular way.
 *
 * If the same key is specified multiple times in the set (for example
 * if two ranges, two keys, or a key and a range overlap), Cloud Spanner
 * behaves as if the key were only specified once.
 */
class KeySet {
  /**
   * For convenience `all` can be set to `true` to indicate that this
   * `KeySet` matches all keys in the table or index. Note that any keys
   * specified in `keys` or `ranges` are only yielded once.
   */
  core.bool all;
  /**
   * A list of specific keys. Entries in `keys` should have exactly as
   * many elements as there are columns in the primary or index key
   * with which this `KeySet` is used.  Individual key values are
   * encoded as described here.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.List<core.Object>> keys;
  /**
   * A list of key ranges. See KeyRange for more information about
   * key range specifications.
   */
  core.List<KeyRange> ranges;

  KeySet();

  KeySet.fromJson(core.Map _json) {
    if (_json.containsKey("all")) {
      all = _json["all"];
    }
    if (_json.containsKey("keys")) {
      keys = _json["keys"];
    }
    if (_json.containsKey("ranges")) {
      ranges = _json["ranges"].map((value) => new KeyRange.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (all != null) {
      _json["all"] = all;
    }
    if (keys != null) {
      _json["keys"] = keys;
    }
    if (ranges != null) {
      _json["ranges"] = ranges.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The response for ListDatabases. */
class ListDatabasesResponse {
  /** Databases that matched the request. */
  core.List<Database> databases;
  /**
   * `next_page_token` can be sent in a subsequent
   * ListDatabases call to fetch more
   * of the matching databases.
   */
  core.String nextPageToken;

  ListDatabasesResponse();

  ListDatabasesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("databases")) {
      databases = _json["databases"].map((value) => new Database.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (databases != null) {
      _json["databases"] = databases.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** The response for ListInstanceConfigs. */
class ListInstanceConfigsResponse {
  /** The list of requested instance configurations. */
  core.List<InstanceConfig> instanceConfigs;
  /**
   * `next_page_token` can be sent in a subsequent
   * ListInstanceConfigs call to
   * fetch more of the matching instance configurations.
   */
  core.String nextPageToken;

  ListInstanceConfigsResponse();

  ListInstanceConfigsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("instanceConfigs")) {
      instanceConfigs = _json["instanceConfigs"].map((value) => new InstanceConfig.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (instanceConfigs != null) {
      _json["instanceConfigs"] = instanceConfigs.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** The response for ListInstances. */
class ListInstancesResponse {
  /** The list of requested instances. */
  core.List<Instance> instances;
  /**
   * `next_page_token` can be sent in a subsequent
   * ListInstances call to fetch more
   * of the matching instances.
   */
  core.String nextPageToken;

  ListInstancesResponse();

  ListInstancesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("instances")) {
      instances = _json["instances"].map((value) => new Instance.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (instances != null) {
      _json["instances"] = instances.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** The response message for Operations.ListOperations. */
class ListOperationsResponse {
  /** The standard List next-page token. */
  core.String nextPageToken;
  /** A list of operations that matches the specified filter in the request. */
  core.List<Operation> operations;

  ListOperationsResponse();

  ListOperationsResponse.fromJson(core.Map _json) {
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
 * A modification to one or more Cloud Spanner rows.  Mutations can be
 * applied to a Cloud Spanner database by sending them in a
 * Commit call.
 */
class Mutation {
  /**
   * Delete rows from a table. Succeeds whether or not the named
   * rows were present.
   */
  Delete delete;
  /**
   * Insert new rows in a table. If any of the rows already exist,
   * the write or transaction fails with error `ALREADY_EXISTS`.
   */
  Write insert;
  /**
   * Like insert, except that if the row already exists, then
   * its column values are overwritten with the ones provided. Any
   * column values not explicitly written are preserved.
   */
  Write insertOrUpdate;
  /**
   * Like insert, except that if the row already exists, it is
   * deleted, and the column values provided are inserted
   * instead. Unlike insert_or_update, this means any values not
   * explicitly written become `NULL`.
   */
  Write replace;
  /**
   * Update existing rows in a table. If any of the rows does not
   * already exist, the transaction fails with error `NOT_FOUND`.
   */
  Write update;

  Mutation();

  Mutation.fromJson(core.Map _json) {
    if (_json.containsKey("delete")) {
      delete = new Delete.fromJson(_json["delete"]);
    }
    if (_json.containsKey("insert")) {
      insert = new Write.fromJson(_json["insert"]);
    }
    if (_json.containsKey("insertOrUpdate")) {
      insertOrUpdate = new Write.fromJson(_json["insertOrUpdate"]);
    }
    if (_json.containsKey("replace")) {
      replace = new Write.fromJson(_json["replace"]);
    }
    if (_json.containsKey("update")) {
      update = new Write.fromJson(_json["update"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (delete != null) {
      _json["delete"] = (delete).toJson();
    }
    if (insert != null) {
      _json["insert"] = (insert).toJson();
    }
    if (insertOrUpdate != null) {
      _json["insertOrUpdate"] = (insertOrUpdate).toJson();
    }
    if (replace != null) {
      _json["replace"] = (replace).toJson();
    }
    if (update != null) {
      _json["update"] = (update).toJson();
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
 * Partial results from a streaming read or SQL query. Streaming reads and
 * SQL queries better tolerate large result sets, large rows, and large
 * values, but are a little trickier to consume.
 */
class PartialResultSet {
  /**
   * If true, then the final value in values is chunked, and must
   * be combined with more values from subsequent `PartialResultSet`s
   * to obtain a complete field value.
   */
  core.bool chunkedValue;
  /**
   * Metadata about the result set, such as row type information.
   * Only present in the first response.
   */
  ResultSetMetadata metadata;
  /**
   * Streaming calls might be interrupted for a variety of reasons, such
   * as TCP connection loss. If this occurs, the stream of results can
   * be resumed by re-sending the original request and including
   * `resume_token`. Note that executing any other transaction in the
   * same session invalidates the token.
   */
  core.String resumeToken;
  core.List<core.int> get resumeTokenAsBytes {
    return convert.BASE64.decode(resumeToken);
  }

  void set resumeTokenAsBytes(core.List<core.int> _bytes) {
    resumeToken = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * Query plan and execution statistics for the query that produced this
   * streaming result set. These can be requested by setting
   * ExecuteSqlRequest.query_mode and are sent
   * only once with the last response in the stream.
   */
  ResultSetStats stats;
  /**
   * A streamed result set consists of a stream of values, which might
   * be split into many `PartialResultSet` messages to accommodate
   * large rows and/or large values. Every N complete values defines a
   * row, where N is equal to the number of entries in
   * metadata.row_type.fields.
   *
   * Most values are encoded based on type as described
   * here.
   *
   * It is possible that the last value in values is "chunked",
   * meaning that the rest of the value is sent in subsequent
   * `PartialResultSet`(s). This is denoted by the chunked_value
   * field. Two or more chunked values can be merged to form a
   * complete value as follows:
   *
   *   * `bool/number/null`: cannot be chunked
   *   * `string`: concatenate the strings
   *   * `list`: concatenate the lists. If the last element in a list is a
   *     `string`, `list`, or `object`, merge it with the first element in
   *     the next list by applying these rules recursively.
   *   * `object`: concatenate the (field name, field value) pairs. If a
   *     field name is duplicated, then apply these rules recursively
   *     to merge the field values.
   *
   * Some examples of merging:
   *
   *     # Strings are concatenated.
   *     "foo", "bar" => "foobar"
   *
   *     # Lists of non-strings are concatenated.
   *     [2, 3], [4] => [2, 3, 4]
   *
   *     # Lists are concatenated, but the last and first elements are merged
   *     # because they are strings.
   *     ["a", "b"], ["c", "d"] => ["a", "bc", "d"]
   *
   *     # Lists are concatenated, but the last and first elements are merged
   *     # because they are lists. Recursively, the last and first elements
   *     # of the inner lists are merged because they are strings.
   *     ["a", ["b", "c"]], [["d"], "e"] => ["a", ["b", "cd"], "e"]
   *
   *     # Non-overlapping object fields are combined.
   *     {"a": "1"}, {"b": "2"} => {"a": "1", "b": 2"}
   *
   *     # Overlapping object fields are merged.
   *     {"a": "1"}, {"a": "2"} => {"a": "12"}
   *
   *     # Examples of merging objects containing lists of strings.
   *     {"a": ["1"]}, {"a": ["2"]} => {"a": ["12"]}
   *
   * For a more complete example, suppose a streaming SQL query is
   * yielding a result set whose rows contain a single string
   * field. The following `PartialResultSet`s might be yielded:
   *
   *     {
   *       "metadata": { ... }
   *       "values": ["Hello", "W"]
   *       "chunked_value": true
   *       "resume_token": "Af65..."
   *     }
   *     {
   *       "values": ["orl"]
   *       "chunked_value": true
   *       "resume_token": "Bqp2..."
   *     }
   *     {
   *       "values": ["d"]
   *       "resume_token": "Zx1B..."
   *     }
   *
   * This sequence of `PartialResultSet`s encodes two rows, one
   * containing the field value `"Hello"`, and a second containing the
   * field value `"World" = "W" + "orl" + "d"`.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> values;

  PartialResultSet();

  PartialResultSet.fromJson(core.Map _json) {
    if (_json.containsKey("chunkedValue")) {
      chunkedValue = _json["chunkedValue"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new ResultSetMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("resumeToken")) {
      resumeToken = _json["resumeToken"];
    }
    if (_json.containsKey("stats")) {
      stats = new ResultSetStats.fromJson(_json["stats"]);
    }
    if (_json.containsKey("values")) {
      values = _json["values"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (chunkedValue != null) {
      _json["chunkedValue"] = chunkedValue;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (resumeToken != null) {
      _json["resumeToken"] = resumeToken;
    }
    if (stats != null) {
      _json["stats"] = (stats).toJson();
    }
    if (values != null) {
      _json["values"] = values;
    }
    return _json;
  }
}

/** Node information for nodes appearing in a QueryPlan.plan_nodes. */
class PlanNode {
  /** List of child node `index`es and their relationship to this parent. */
  core.List<ChildLink> childLinks;
  /** The display name for the node. */
  core.String displayName;
  /**
   * The execution statistics associated with the node, contained in a group of
   * key-value pairs. Only present if the plan was returned as a result of a
   * profile query. For example, number of executions, number of rows/time per
   * execution etc.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> executionStats;
  /** The `PlanNode`'s index in node list. */
  core.int index;
  /**
   * Used to determine the type of node. May be needed for visualizing
   * different kinds of nodes differently. For example, If the node is a
   * SCALAR node, it will have a condensed representation
   * which can be used to directly embed a description of the node in its
   * parent.
   * Possible string values are:
   * - "KIND_UNSPECIFIED" : Not specified.
   * - "RELATIONAL" : Denotes a Relational operator node in the expression tree.
   * Relational
   * operators represent iterative processing of rows during query execution.
   * For example, a `TableScan` operation that reads rows from a table.
   * - "SCALAR" : Denotes a Scalar node in the expression tree. Scalar nodes
   * represent
   * non-iterable entities in the query plan. For example, constants or
   * arithmetic operators appearing inside predicate expressions or references
   * to column names.
   */
  core.String kind;
  /**
   * Attributes relevant to the node contained in a group of key-value pairs.
   * For example, a Parameter Reference node could have the following
   * information in its metadata:
   *
   *     {
   *       "parameter_reference": "param1",
   *       "parameter_type": "array"
   *     }
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> metadata;
  /** Condensed representation for SCALAR nodes. */
  ShortRepresentation shortRepresentation;

  PlanNode();

  PlanNode.fromJson(core.Map _json) {
    if (_json.containsKey("childLinks")) {
      childLinks = _json["childLinks"].map((value) => new ChildLink.fromJson(value)).toList();
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("executionStats")) {
      executionStats = _json["executionStats"];
    }
    if (_json.containsKey("index")) {
      index = _json["index"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("metadata")) {
      metadata = _json["metadata"];
    }
    if (_json.containsKey("shortRepresentation")) {
      shortRepresentation = new ShortRepresentation.fromJson(_json["shortRepresentation"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (childLinks != null) {
      _json["childLinks"] = childLinks.map((value) => (value).toJson()).toList();
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (executionStats != null) {
      _json["executionStats"] = executionStats;
    }
    if (index != null) {
      _json["index"] = index;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (metadata != null) {
      _json["metadata"] = metadata;
    }
    if (shortRepresentation != null) {
      _json["shortRepresentation"] = (shortRepresentation).toJson();
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

/** Contains an ordered list of nodes appearing in the query plan. */
class QueryPlan {
  /**
   * The nodes in the query plan. Plan nodes are returned in pre-order starting
   * with the plan root. Each PlanNode's `id` corresponds to its index in
   * `plan_nodes`.
   */
  core.List<PlanNode> planNodes;

  QueryPlan();

  QueryPlan.fromJson(core.Map _json) {
    if (_json.containsKey("planNodes")) {
      planNodes = _json["planNodes"].map((value) => new PlanNode.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (planNodes != null) {
      _json["planNodes"] = planNodes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Options for read-only transactions. */
class ReadOnly {
  /**
   * Executes all reads at a timestamp that is `exact_staleness`
   * old. The timestamp is chosen soon after the read is started.
   *
   * Guarantees that all writes that have committed more than the
   * specified number of seconds ago are visible. Because Cloud Spanner
   * chooses the exact timestamp, this mode works even if the client's
   * local clock is substantially skewed from Cloud Spanner commit
   * timestamps.
   *
   * Useful for reading at nearby replicas without the distributed
   * timestamp negotiation overhead of `max_staleness`.
   */
  core.String exactStaleness;
  /**
   * Read data at a timestamp >= `NOW - max_staleness`
   * seconds. Guarantees that all writes that have committed more
   * than the specified number of seconds ago are visible. Because
   * Cloud Spanner chooses the exact timestamp, this mode works even if
   * the client's local clock is substantially skewed from Cloud Spanner
   * commit timestamps.
   *
   * Useful for reading the freshest data available at a nearby
   * replica, while bounding the possible staleness if the local
   * replica has fallen behind.
   *
   * Note that this option can only be used in single-use
   * transactions.
   */
  core.String maxStaleness;
  /**
   * Executes all reads at a timestamp >= `min_read_timestamp`.
   *
   * This is useful for requesting fresher data than some previous
   * read, or data that is fresh enough to observe the effects of some
   * previously committed transaction whose timestamp is known.
   *
   * Note that this option can only be used in single-use transactions.
   */
  core.String minReadTimestamp;
  /**
   * Executes all reads at the given timestamp. Unlike other modes,
   * reads at a specific timestamp are repeatable; the same read at
   * the same timestamp always returns the same data. If the
   * timestamp is in the future, the read will block until the
   * specified timestamp, modulo the read's deadline.
   *
   * Useful for large scale consistent reads such as mapreduces, or
   * for coordinating many reads against a consistent snapshot of the
   * data.
   */
  core.String readTimestamp;
  /**
   * If true, the Cloud Spanner-selected read timestamp is included in
   * the Transaction message that describes the transaction.
   */
  core.bool returnReadTimestamp;
  /**
   * Read at a timestamp where all previously committed transactions
   * are visible.
   */
  core.bool strong;

  ReadOnly();

  ReadOnly.fromJson(core.Map _json) {
    if (_json.containsKey("exactStaleness")) {
      exactStaleness = _json["exactStaleness"];
    }
    if (_json.containsKey("maxStaleness")) {
      maxStaleness = _json["maxStaleness"];
    }
    if (_json.containsKey("minReadTimestamp")) {
      minReadTimestamp = _json["minReadTimestamp"];
    }
    if (_json.containsKey("readTimestamp")) {
      readTimestamp = _json["readTimestamp"];
    }
    if (_json.containsKey("returnReadTimestamp")) {
      returnReadTimestamp = _json["returnReadTimestamp"];
    }
    if (_json.containsKey("strong")) {
      strong = _json["strong"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (exactStaleness != null) {
      _json["exactStaleness"] = exactStaleness;
    }
    if (maxStaleness != null) {
      _json["maxStaleness"] = maxStaleness;
    }
    if (minReadTimestamp != null) {
      _json["minReadTimestamp"] = minReadTimestamp;
    }
    if (readTimestamp != null) {
      _json["readTimestamp"] = readTimestamp;
    }
    if (returnReadTimestamp != null) {
      _json["returnReadTimestamp"] = returnReadTimestamp;
    }
    if (strong != null) {
      _json["strong"] = strong;
    }
    return _json;
  }
}

/**
 * The request for Read and
 * StreamingRead.
 */
class ReadRequest {
  /**
   * The columns of table to be returned for each row matching
   * this request.
   */
  core.List<core.String> columns;
  /**
   * If non-empty, the name of an index on table. This index is
   * used instead of the table primary key when interpreting key_set
   * and sorting result rows. See key_set for further information.
   */
  core.String index;
  /**
   * Required. `key_set` identifies the rows to be yielded. `key_set` names the
   * primary keys of the rows in table to be yielded, unless index
   * is present. If index is present, then key_set instead names
   * index keys in index.
   *
   * Rows are yielded in table primary key order (if index is empty)
   * or index key order (if index is non-empty).
   *
   * It is not an error for the `key_set` to name rows that do not
   * exist in the database. Read yields nothing for nonexistent rows.
   */
  KeySet keySet;
  /**
   * If greater than zero, only the first `limit` rows are yielded. If `limit`
   * is zero, the default is no limit.
   */
  core.String limit;
  /**
   * If this request is resuming a previously interrupted read,
   * `resume_token` should be copied from the last
   * PartialResultSet yielded before the interruption. Doing this
   * enables the new read to resume where the last read left off. The
   * rest of the request parameters must exactly match the request
   * that yielded this token.
   */
  core.String resumeToken;
  core.List<core.int> get resumeTokenAsBytes {
    return convert.BASE64.decode(resumeToken);
  }

  void set resumeTokenAsBytes(core.List<core.int> _bytes) {
    resumeToken = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** Required. The name of the table in the database to be read. */
  core.String table;
  /**
   * The transaction to use. If none is provided, the default is a
   * temporary read-only transaction with strong concurrency.
   */
  TransactionSelector transaction;

  ReadRequest();

  ReadRequest.fromJson(core.Map _json) {
    if (_json.containsKey("columns")) {
      columns = _json["columns"];
    }
    if (_json.containsKey("index")) {
      index = _json["index"];
    }
    if (_json.containsKey("keySet")) {
      keySet = new KeySet.fromJson(_json["keySet"]);
    }
    if (_json.containsKey("limit")) {
      limit = _json["limit"];
    }
    if (_json.containsKey("resumeToken")) {
      resumeToken = _json["resumeToken"];
    }
    if (_json.containsKey("table")) {
      table = _json["table"];
    }
    if (_json.containsKey("transaction")) {
      transaction = new TransactionSelector.fromJson(_json["transaction"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columns != null) {
      _json["columns"] = columns;
    }
    if (index != null) {
      _json["index"] = index;
    }
    if (keySet != null) {
      _json["keySet"] = (keySet).toJson();
    }
    if (limit != null) {
      _json["limit"] = limit;
    }
    if (resumeToken != null) {
      _json["resumeToken"] = resumeToken;
    }
    if (table != null) {
      _json["table"] = table;
    }
    if (transaction != null) {
      _json["transaction"] = (transaction).toJson();
    }
    return _json;
  }
}

/** Options for read-write transactions. */
class ReadWrite {

  ReadWrite();

  ReadWrite.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/**
 * Results from Read or
 * ExecuteSql.
 */
class ResultSet {
  /** Metadata about the result set, such as row type information. */
  ResultSetMetadata metadata;
  /**
   * Each element in `rows` is a row whose format is defined by
   * metadata.row_type. The ith element
   * in each row matches the ith field in
   * metadata.row_type. Elements are
   * encoded based on type as described
   * here.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.List<core.Object>> rows;
  /**
   * Query plan and execution statistics for the query that produced this
   * result set. These can be requested by setting
   * ExecuteSqlRequest.query_mode.
   */
  ResultSetStats stats;

  ResultSet();

  ResultSet.fromJson(core.Map _json) {
    if (_json.containsKey("metadata")) {
      metadata = new ResultSetMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"];
    }
    if (_json.containsKey("stats")) {
      stats = new ResultSetStats.fromJson(_json["stats"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (rows != null) {
      _json["rows"] = rows;
    }
    if (stats != null) {
      _json["stats"] = (stats).toJson();
    }
    return _json;
  }
}

/** Metadata about a ResultSet or PartialResultSet. */
class ResultSetMetadata {
  /**
   * Indicates the field names and types for the rows in the result
   * set.  For example, a SQL query like `"SELECT UserId, UserName FROM
   * Users"` could return a `row_type` value like:
   *
   *     "fields": [
   *       { "name": "UserId", "type": { "code": "INT64" } },
   *       { "name": "UserName", "type": { "code": "STRING" } },
   *     ]
   */
  StructType rowType;
  /**
   * If the read or SQL query began a transaction as a side-effect, the
   * information about the new transaction is yielded here.
   */
  Transaction transaction;

  ResultSetMetadata();

  ResultSetMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("rowType")) {
      rowType = new StructType.fromJson(_json["rowType"]);
    }
    if (_json.containsKey("transaction")) {
      transaction = new Transaction.fromJson(_json["transaction"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (rowType != null) {
      _json["rowType"] = (rowType).toJson();
    }
    if (transaction != null) {
      _json["transaction"] = (transaction).toJson();
    }
    return _json;
  }
}

/** Additional statistics about a ResultSet or PartialResultSet. */
class ResultSetStats {
  /** QueryPlan for the query associated with this result. */
  QueryPlan queryPlan;
  /**
   * Aggregated statistics from the execution of the query. Only present when
   * the query is profiled. For example, a query could return the statistics as
   * follows:
   *
   *     {
   *       "rows_returned": "3",
   *       "elapsed_time": "1.22 secs",
   *       "cpu_time": "1.19 secs"
   *     }
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> queryStats;

  ResultSetStats();

  ResultSetStats.fromJson(core.Map _json) {
    if (_json.containsKey("queryPlan")) {
      queryPlan = new QueryPlan.fromJson(_json["queryPlan"]);
    }
    if (_json.containsKey("queryStats")) {
      queryStats = _json["queryStats"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (queryPlan != null) {
      _json["queryPlan"] = (queryPlan).toJson();
    }
    if (queryStats != null) {
      _json["queryStats"] = queryStats;
    }
    return _json;
  }
}

/** The request for Rollback. */
class RollbackRequest {
  /** Required. The transaction to roll back. */
  core.String transactionId;
  core.List<core.int> get transactionIdAsBytes {
    return convert.BASE64.decode(transactionId);
  }

  void set transactionIdAsBytes(core.List<core.int> _bytes) {
    transactionId = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  RollbackRequest();

  RollbackRequest.fromJson(core.Map _json) {
    if (_json.containsKey("transactionId")) {
      transactionId = _json["transactionId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (transactionId != null) {
      _json["transactionId"] = transactionId;
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

/** A session in the Cloud Spanner API. */
class Session {
  /** Required. The name of the session. */
  core.String name;

  Session();

  Session.fromJson(core.Map _json) {
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
 * Condensed representation of a node and its subtree. Only present for
 * `SCALAR` PlanNode(s).
 */
class ShortRepresentation {
  /** A string representation of the expression subtree rooted at this node. */
  core.String description;
  /**
   * A mapping of (subquery variable name) -> (subquery node id) for cases
   * where the `description` string of this node references a `SCALAR`
   * subquery contained in the expression subtree rooted at this node. The
   * referenced `SCALAR` subquery may not necessarily be a direct child of
   * this node.
   */
  core.Map<core.String, core.int> subqueries;

  ShortRepresentation();

  ShortRepresentation.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("subqueries")) {
      subqueries = _json["subqueries"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (subqueries != null) {
      _json["subqueries"] = subqueries;
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

/** `StructType` defines the fields of a STRUCT type. */
class StructType {
  /**
   * The list of fields that make up this struct. Order is
   * significant, because values of this struct type are represented as
   * lists, where the order of field values matches the order of
   * fields in the StructType. In turn, the order of fields
   * matches the order of columns in a read request, or the order of
   * fields in the `SELECT` clause of a query.
   */
  core.List<Field> fields;

  StructType();

  StructType.fromJson(core.Map _json) {
    if (_json.containsKey("fields")) {
      fields = _json["fields"].map((value) => new Field.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fields != null) {
      _json["fields"] = fields.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Request message for `TestIamPermissions` method. */
class TestIamPermissionsRequest {
  /**
   * REQUIRED: The set of permissions to check for 'resource'.
   * Permissions with wildcards (such as '*', 'spanner.*',
   * 'spanner.instances.*') are not allowed.
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

/** A transaction. */
class Transaction {
  /**
   * `id` may be used to identify the transaction in subsequent
   * Read,
   * ExecuteSql,
   * Commit, or
   * Rollback calls.
   *
   * Single-use read-only transactions do not have IDs, because
   * single-use transactions do not support multiple requests.
   */
  core.String id;
  core.List<core.int> get idAsBytes {
    return convert.BASE64.decode(id);
  }

  void set idAsBytes(core.List<core.int> _bytes) {
    id = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * For snapshot read-only transactions, the read timestamp chosen
   * for the transaction. Not returned by default: see
   * TransactionOptions.ReadOnly.return_read_timestamp.
   */
  core.String readTimestamp;

  Transaction();

  Transaction.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("readTimestamp")) {
      readTimestamp = _json["readTimestamp"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (readTimestamp != null) {
      _json["readTimestamp"] = readTimestamp;
    }
    return _json;
  }
}

/**
 * # Transactions
 *
 *
 * Each session can have at most one active transaction at a time. After the
 * active transaction is completed, the session can immediately be
 * re-used for the next transaction. It is not necessary to create a
 * new session for each transaction.
 *
 * # Transaction Modes
 *
 * Cloud Spanner supports two transaction modes:
 *
 *   1. Locking read-write. This type of transaction is the only way
 *      to write data into Cloud Spanner. These transactions rely on
 *      pessimistic locking and, if necessary, two-phase commit.
 *      Locking read-write transactions may abort, requiring the
 *      application to retry.
 *
 *   2. Snapshot read-only. This transaction type provides guaranteed
 *      consistency across several reads, but does not allow
 *      writes. Snapshot read-only transactions can be configured to
 *      read at timestamps in the past. Snapshot read-only
 *      transactions do not need to be committed.
 *
 * For transactions that only read, snapshot read-only transactions
 * provide simpler semantics and are almost always faster. In
 * particular, read-only transactions do not take locks, so they do
 * not conflict with read-write transactions. As a consequence of not
 * taking locks, they also do not abort, so retry loops are not needed.
 *
 * Transactions may only read/write data in a single database. They
 * may, however, read/write data in different tables within that
 * database.
 *
 * ## Locking Read-Write Transactions
 *
 * Locking transactions may be used to atomically read-modify-write
 * data anywhere in a database. This type of transaction is externally
 * consistent.
 *
 * Clients should attempt to minimize the amount of time a transaction
 * is active. Faster transactions commit with higher probability
 * and cause less contention. Cloud Spanner attempts to keep read locks
 * active as long as the transaction continues to do reads, and the
 * transaction has not been terminated by
 * Commit or
 * Rollback.  Long periods of
 * inactivity at the client may cause Cloud Spanner to release a
 * transaction's locks and abort it.
 *
 * Reads performed within a transaction acquire locks on the data
 * being read. Writes can only be done at commit time, after all reads
 * have been completed.
 * Conceptually, a read-write transaction consists of zero or more
 * reads or SQL queries followed by
 * Commit. At any time before
 * Commit, the client can send a
 * Rollback request to abort the
 * transaction.
 *
 * ### Semantics
 *
 * Cloud Spanner can commit the transaction if all read locks it acquired
 * are still valid at commit time, and it is able to acquire write
 * locks for all writes. Cloud Spanner can abort the transaction for any
 * reason. If a commit attempt returns `ABORTED`, Cloud Spanner guarantees
 * that the transaction has not modified any user data in Cloud Spanner.
 *
 * Unless the transaction commits, Cloud Spanner makes no guarantees about
 * how long the transaction's locks were held for. It is an error to
 * use Cloud Spanner locks for any sort of mutual exclusion other than
 * between Cloud Spanner transactions themselves.
 *
 * ### Retrying Aborted Transactions
 *
 * When a transaction aborts, the application can choose to retry the
 * whole transaction again. To maximize the chances of successfully
 * committing the retry, the client should execute the retry in the
 * same session as the original attempt. The original session's lock
 * priority increases with each consecutive abort, meaning that each
 * attempt has a slightly better chance of success than the previous.
 *
 * Under some circumstances (e.g., many transactions attempting to
 * modify the same row(s)), a transaction can abort many times in a
 * short period before successfully committing. Thus, it is not a good
 * idea to cap the number of retries a transaction can attempt;
 * instead, it is better to limit the total amount of wall time spent
 * retrying.
 *
 * ### Idle Transactions
 *
 * A transaction is considered idle if it has no outstanding reads or
 * SQL queries and has not started a read or SQL query within the last 10
 * seconds. Idle transactions can be aborted by Cloud Spanner so that they
 * don't hold on to locks indefinitely. In that case, the commit will
 * fail with error `ABORTED`.
 *
 * If this behavior is undesirable, periodically executing a simple
 * SQL query in the transaction (e.g., `SELECT 1`) prevents the
 * transaction from becoming idle.
 *
 * ## Snapshot Read-Only Transactions
 *
 * Snapshot read-only transactions provides a simpler method than
 * locking read-write transactions for doing several consistent
 * reads. However, this type of transaction does not support writes.
 *
 * Snapshot transactions do not take locks. Instead, they work by
 * choosing a Cloud Spanner timestamp, then executing all reads at that
 * timestamp. Since they do not acquire locks, they do not block
 * concurrent read-write transactions.
 *
 * Unlike locking read-write transactions, snapshot read-only
 * transactions never abort. They can fail if the chosen read
 * timestamp is garbage collected; however, the default garbage
 * collection policy is generous enough that most applications do not
 * need to worry about this in practice.
 *
 * Snapshot read-only transactions do not need to call
 * Commit or
 * Rollback (and in fact are not
 * permitted to do so).
 *
 * To execute a snapshot transaction, the client specifies a timestamp
 * bound, which tells Cloud Spanner how to choose a read timestamp.
 *
 * The types of timestamp bound are:
 *
 *   - Strong (the default).
 *   - Bounded staleness.
 *   - Exact staleness.
 *
 * If the Cloud Spanner database to be read is geographically distributed,
 * stale read-only transactions can execute more quickly than strong
 * or read-write transaction, because they are able to execute far
 * from the leader replica.
 *
 * Each type of timestamp bound is discussed in detail below.
 *
 * ### Strong
 *
 * Strong reads are guaranteed to see the effects of all transactions
 * that have committed before the start of the read. Furthermore, all
 * rows yielded by a single read are consistent with each other -- if
 * any part of the read observes a transaction, all parts of the read
 * see the transaction.
 *
 * Strong reads are not repeatable: two consecutive strong read-only
 * transactions might return inconsistent results if there are
 * concurrent writes. If consistency across reads is required, the
 * reads should be executed within a transaction or at an exact read
 * timestamp.
 *
 * See TransactionOptions.ReadOnly.strong.
 *
 * ### Exact Staleness
 *
 * These timestamp bounds execute reads at a user-specified
 * timestamp. Reads at a timestamp are guaranteed to see a consistent
 * prefix of the global transaction history: they observe
 * modifications done by all transactions with a commit timestamp <=
 * the read timestamp, and observe none of the modifications done by
 * transactions with a larger commit timestamp. They will block until
 * all conflicting transactions that may be assigned commit timestamps
 * <= the read timestamp have finished.
 *
 * The timestamp can either be expressed as an absolute Cloud Spanner commit
 * timestamp or a staleness relative to the current time.
 *
 * These modes do not require a "negotiation phase" to pick a
 * timestamp. As a result, they execute slightly faster than the
 * equivalent boundedly stale concurrency modes. On the other hand,
 * boundedly stale reads usually return fresher results.
 *
 * See TransactionOptions.ReadOnly.read_timestamp and
 * TransactionOptions.ReadOnly.exact_staleness.
 *
 * ### Bounded Staleness
 *
 * Bounded staleness modes allow Cloud Spanner to pick the read timestamp,
 * subject to a user-provided staleness bound. Cloud Spanner chooses the
 * newest timestamp within the staleness bound that allows execution
 * of the reads at the closest available replica without blocking.
 *
 * All rows yielded are consistent with each other -- if any part of
 * the read observes a transaction, all parts of the read see the
 * transaction. Boundedly stale reads are not repeatable: two stale
 * reads, even if they use the same staleness bound, can execute at
 * different timestamps and thus return inconsistent results.
 *
 * Boundedly stale reads execute in two phases: the first phase
 * negotiates a timestamp among all replicas needed to serve the
 * read. In the second phase, reads are executed at the negotiated
 * timestamp.
 *
 * As a result of the two phase execution, bounded staleness reads are
 * usually a little slower than comparable exact staleness
 * reads. However, they are typically able to return fresher
 * results, and are more likely to execute at the closest replica.
 *
 * Because the timestamp negotiation requires up-front knowledge of
 * which rows will be read, it can only be used with single-use
 * read-only transactions.
 *
 * See TransactionOptions.ReadOnly.max_staleness and
 * TransactionOptions.ReadOnly.min_read_timestamp.
 *
 * ### Old Read Timestamps and Garbage Collection
 *
 * Cloud Spanner continuously garbage collects deleted and overwritten data
 * in the background to reclaim storage space. This process is known
 * as "version GC". By default, version GC reclaims versions after they
 * are one hour old. Because of this, Cloud Spanner cannot perform reads
 * at read timestamps more than one hour in the past. This
 * restriction also applies to in-progress reads and/or SQL queries whose
 * timestamp become too old while executing. Reads and SQL queries with
 * too-old read timestamps fail with the error `FAILED_PRECONDITION`.
 */
class TransactionOptions {
  /**
   * Transaction will not write.
   *
   * Authorization to begin a read-only transaction requires
   * `spanner.databases.beginReadOnlyTransaction` permission
   * on the `session` resource.
   */
  ReadOnly readOnly;
  /**
   * Transaction may write.
   *
   * Authorization to begin a read-write transaction requires
   * `spanner.databases.beginOrRollbackReadWriteTransaction` permission
   * on the `session` resource.
   */
  ReadWrite readWrite;

  TransactionOptions();

  TransactionOptions.fromJson(core.Map _json) {
    if (_json.containsKey("readOnly")) {
      readOnly = new ReadOnly.fromJson(_json["readOnly"]);
    }
    if (_json.containsKey("readWrite")) {
      readWrite = new ReadWrite.fromJson(_json["readWrite"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (readOnly != null) {
      _json["readOnly"] = (readOnly).toJson();
    }
    if (readWrite != null) {
      _json["readWrite"] = (readWrite).toJson();
    }
    return _json;
  }
}

/**
 * This message is used to select the transaction in which a
 * Read or
 * ExecuteSql call runs.
 *
 * See TransactionOptions for more information about transactions.
 */
class TransactionSelector {
  /**
   * Begin a new transaction and execute this read or SQL query in
   * it. The transaction ID of the new transaction is returned in
   * ResultSetMetadata.transaction, which is a Transaction.
   */
  TransactionOptions begin;
  /** Execute the read or SQL query in a previously-started transaction. */
  core.String id;
  core.List<core.int> get idAsBytes {
    return convert.BASE64.decode(id);
  }

  void set idAsBytes(core.List<core.int> _bytes) {
    id = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * Execute the read or SQL query in a temporary transaction.
   * This is the most efficient way to execute a transaction that
   * consists of a single SQL query.
   */
  TransactionOptions singleUse;

  TransactionSelector();

  TransactionSelector.fromJson(core.Map _json) {
    if (_json.containsKey("begin")) {
      begin = new TransactionOptions.fromJson(_json["begin"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("singleUse")) {
      singleUse = new TransactionOptions.fromJson(_json["singleUse"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (begin != null) {
      _json["begin"] = (begin).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (singleUse != null) {
      _json["singleUse"] = (singleUse).toJson();
    }
    return _json;
  }
}

/**
 * `Type` indicates the type of a Cloud Spanner value, as might be stored in a
 * table cell or returned from an SQL query.
 */
class Type {
  /**
   * If code == ARRAY, then `array_element_type`
   * is the type of the array elements.
   */
  Type arrayElementType;
  /**
   * Required. The TypeCode for this type.
   * Possible string values are:
   * - "TYPE_CODE_UNSPECIFIED" : Not specified.
   * - "BOOL" : Encoded as JSON `true` or `false`.
   * - "INT64" : Encoded as `string`, in decimal format.
   * - "FLOAT64" : Encoded as `number`, or the strings `"NaN"`, `"Infinity"`, or
   * `"-Infinity"`.
   * - "TIMESTAMP" : Encoded as `string` in RFC 3339 timestamp format. The time
   * zone
   * must be present, and must be `"Z"`.
   * - "DATE" : Encoded as `string` in RFC 3339 date format.
   * - "STRING" : Encoded as `string`.
   * - "BYTES" : Encoded as a base64-encoded `string`, as described in RFC 4648,
   * section 4.
   * - "ARRAY" : Encoded as `list`, where the list elements are represented
   * according to array_element_type.
   * - "STRUCT" : Encoded as `list`, where list element `i` is represented
   * according
   * to [struct_type.fields[i]][google.spanner.v1.StructType.fields].
   */
  core.String code;
  /**
   * If code == STRUCT, then `struct_type`
   * provides type information for the struct's fields.
   */
  StructType structType;

  Type();

  Type.fromJson(core.Map _json) {
    if (_json.containsKey("arrayElementType")) {
      arrayElementType = new Type.fromJson(_json["arrayElementType"]);
    }
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("structType")) {
      structType = new StructType.fromJson(_json["structType"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (arrayElementType != null) {
      _json["arrayElementType"] = (arrayElementType).toJson();
    }
    if (code != null) {
      _json["code"] = code;
    }
    if (structType != null) {
      _json["structType"] = (structType).toJson();
    }
    return _json;
  }
}

/**
 * Metadata type for the operation returned by
 * UpdateDatabaseDdl.
 */
class UpdateDatabaseDdlMetadata {
  /**
   * Reports the commit timestamps of all statements that have
   * succeeded so far, where `commit_timestamps[i]` is the commit
   * timestamp for the statement `statements[i]`.
   */
  core.List<core.String> commitTimestamps;
  /** The database being modified. */
  core.String database;
  /**
   * For an update this list contains all the statements. For an
   * individual statement, this list contains only that statement.
   */
  core.List<core.String> statements;

  UpdateDatabaseDdlMetadata();

  UpdateDatabaseDdlMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("commitTimestamps")) {
      commitTimestamps = _json["commitTimestamps"];
    }
    if (_json.containsKey("database")) {
      database = _json["database"];
    }
    if (_json.containsKey("statements")) {
      statements = _json["statements"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (commitTimestamps != null) {
      _json["commitTimestamps"] = commitTimestamps;
    }
    if (database != null) {
      _json["database"] = database;
    }
    if (statements != null) {
      _json["statements"] = statements;
    }
    return _json;
  }
}

/**
 * Enqueues the given DDL statements to be applied, in order but not
 * necessarily all at once, to the database schema at some point (or
 * points) in the future. The server checks that the statements
 * are executable (syntactically valid, name tables that exist, etc.)
 * before enqueueing them, but they may still fail upon
 * later execution (e.g., if a statement from another batch of
 * statements is applied first and it conflicts in some way, or if
 * there is some data-related problem like a `NULL` value in a column to
 * which `NOT NULL` would be added). If a statement fails, all
 * subsequent statements in the batch are automatically cancelled.
 *
 * Each batch of statements is assigned a name which can be used with
 * the Operations API to monitor
 * progress. See the
 * operation_id field for more
 * details.
 */
class UpdateDatabaseDdlRequest {
  /**
   * If empty, the new update request is assigned an
   * automatically-generated operation ID. Otherwise, `operation_id`
   * is used to construct the name of the resulting
   * Operation.
   *
   * Specifying an explicit operation ID simplifies determining
   * whether the statements were executed in the event that the
   * UpdateDatabaseDdl call is replayed,
   * or the return value is otherwise lost: the database and
   * `operation_id` fields can be combined to form the
   * name of the resulting
   * longrunning.Operation: `<database>/operations/<operation_id>`.
   *
   * `operation_id` should be unique within the database, and must be
   * a valid identifier: `a-z*`. Note that
   * automatically-generated operation IDs always begin with an
   * underscore. If the named operation already exists,
   * UpdateDatabaseDdl returns
   * `ALREADY_EXISTS`.
   */
  core.String operationId;
  /** DDL statements to be applied to the database. */
  core.List<core.String> statements;

  UpdateDatabaseDdlRequest();

  UpdateDatabaseDdlRequest.fromJson(core.Map _json) {
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("statements")) {
      statements = _json["statements"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (statements != null) {
      _json["statements"] = statements;
    }
    return _json;
  }
}

/**
 * Metadata type for the operation returned by
 * UpdateInstance.
 */
class UpdateInstanceMetadata {
  /**
   * The time at which this operation was cancelled. If set, this operation is
   * in the process of undoing itself (which is guaranteed to succeed) and
   * cannot be cancelled again.
   */
  core.String cancelTime;
  /** The time at which this operation failed or was completed successfully. */
  core.String endTime;
  /** The desired end state of the update. */
  Instance instance;
  /**
   * The time at which UpdateInstance
   * request was received.
   */
  core.String startTime;

  UpdateInstanceMetadata();

  UpdateInstanceMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("cancelTime")) {
      cancelTime = _json["cancelTime"];
    }
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("instance")) {
      instance = new Instance.fromJson(_json["instance"]);
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cancelTime != null) {
      _json["cancelTime"] = cancelTime;
    }
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (instance != null) {
      _json["instance"] = (instance).toJson();
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

/** The request for UpdateInstance. */
class UpdateInstanceRequest {
  /**
   * Required. A mask specifying which fields in
   * [][google.spanner.admin.instance.v1.UpdateInstanceRequest.instance] should
   * be updated.
   * The field mask must always be specified; this prevents any future fields in
   * [][google.spanner.admin.instance.v1.Instance] from being erased
   * accidentally by clients that do not know
   * about them.
   */
  core.String fieldMask;
  /**
   * Required. The instance to update, which must always include the instance
   * name.  Otherwise, only fields mentioned in
   * [][google.spanner.admin.instance.v1.UpdateInstanceRequest.field_mask] need
   * be included.
   */
  Instance instance;

  UpdateInstanceRequest();

  UpdateInstanceRequest.fromJson(core.Map _json) {
    if (_json.containsKey("fieldMask")) {
      fieldMask = _json["fieldMask"];
    }
    if (_json.containsKey("instance")) {
      instance = new Instance.fromJson(_json["instance"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fieldMask != null) {
      _json["fieldMask"] = fieldMask;
    }
    if (instance != null) {
      _json["instance"] = (instance).toJson();
    }
    return _json;
  }
}

/**
 * Arguments to insert, update, insert_or_update, and
 * replace operations.
 */
class Write {
  /**
   * The names of the columns in table to be written.
   *
   * The list of columns must contain enough columns to allow
   * Cloud Spanner to derive values for all primary key columns in the
   * row(s) to be modified.
   */
  core.List<core.String> columns;
  /** Required. The table whose rows will be written. */
  core.String table;
  /**
   * The values to be written. `values` can contain more than one
   * list of values. If it does, then multiple rows are written, one
   * for each entry in `values`. Each list in `values` must have
   * exactly as many entries as there are entries in columns
   * above. Sending multiple lists is equivalent to sending multiple
   * `Mutation`s, each containing one `values` entry and repeating
   * table and columns. Individual values in each list are
   * encoded as described here.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.List<core.Object>> values;

  Write();

  Write.fromJson(core.Map _json) {
    if (_json.containsKey("columns")) {
      columns = _json["columns"];
    }
    if (_json.containsKey("table")) {
      table = _json["table"];
    }
    if (_json.containsKey("values")) {
      values = _json["values"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columns != null) {
      _json["columns"] = columns;
    }
    if (table != null) {
      _json["table"] = table;
    }
    if (values != null) {
      _json["values"] = values;
    }
    return _json;
  }
}
