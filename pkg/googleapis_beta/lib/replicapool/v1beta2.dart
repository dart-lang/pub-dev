// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.replicapool.v1beta2;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client replicapool/v1beta2';

/// [Deprecated. Please use Instance Group Manager in Compute API] Provides
/// groups of homogenous Compute Engine instances.
class ReplicapoolApi {
  /// View and manage your data across Google Cloud Platform services
  static const CloudPlatformScope =
      "https://www.googleapis.com/auth/cloud-platform";

  /// View your data across Google Cloud Platform services
  static const CloudPlatformReadOnlyScope =
      "https://www.googleapis.com/auth/cloud-platform.read-only";

  /// View and manage your Google Compute Engine resources
  static const ComputeScope = "https://www.googleapis.com/auth/compute";

  /// View your Google Compute Engine resources
  static const ComputeReadonlyScope =
      "https://www.googleapis.com/auth/compute.readonly";

  final commons.ApiRequester _requester;

  InstanceGroupManagersResourceApi get instanceGroupManagers =>
      new InstanceGroupManagersResourceApi(_requester);
  ZoneOperationsResourceApi get zoneOperations =>
      new ZoneOperationsResourceApi(_requester);

  ReplicapoolApi(http.Client client,
      {core.String rootUrl: "https://www.googleapis.com/",
      core.String servicePath: "replicapool/v1beta2/projects/"})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class InstanceGroupManagersResourceApi {
  final commons.ApiRequester _requester;

  InstanceGroupManagersResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Removes the specified instances from the managed instance group, and from
  /// any target pools of which they were members, without deleting the
  /// instances.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the instance group manager resides.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [instanceGroupManager] - The name of the instance group manager.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> abandonInstances(
      InstanceGroupManagersAbandonInstancesRequest request,
      core.String project,
      core.String zone,
      core.String instanceGroupManager) {
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
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (instanceGroupManager == null) {
      throw new core.ArgumentError(
          "Parameter instanceGroupManager is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/instanceGroupManagers/' +
        commons.Escaper.ecapeVariable('$instanceGroupManager') +
        '/abandonInstances';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Deletes the instance group manager and all instances contained within. If
  /// you'd like to delete the manager without deleting the instances, you must
  /// first abandon the instances to remove them from the group.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the instance group manager resides.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [instanceGroupManager] - Name of the Instance Group Manager resource to
  /// delete.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> delete(
      core.String project, core.String zone, core.String instanceGroupManager) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (instanceGroupManager == null) {
      throw new core.ArgumentError(
          "Parameter instanceGroupManager is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/instanceGroupManagers/' +
        commons.Escaper.ecapeVariable('$instanceGroupManager');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Deletes the specified instances. The instances are deleted, then removed
  /// from the instance group and any target pools of which they were a member.
  /// The targetSize of the instance group manager is reduced by the number of
  /// instances deleted.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the instance group manager resides.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [instanceGroupManager] - The name of the instance group manager.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> deleteInstances(
      InstanceGroupManagersDeleteInstancesRequest request,
      core.String project,
      core.String zone,
      core.String instanceGroupManager) {
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
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (instanceGroupManager == null) {
      throw new core.ArgumentError(
          "Parameter instanceGroupManager is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/instanceGroupManagers/' +
        commons.Escaper.ecapeVariable('$instanceGroupManager') +
        '/deleteInstances';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Returns the specified Instance Group Manager resource.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the instance group manager resides.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [instanceGroupManager] - Name of the instance resource to return.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// Completes with a [InstanceGroupManager].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstanceGroupManager> get(
      core.String project, core.String zone, core.String instanceGroupManager) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (instanceGroupManager == null) {
      throw new core.ArgumentError(
          "Parameter instanceGroupManager is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/instanceGroupManagers/' +
        commons.Escaper.ecapeVariable('$instanceGroupManager');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new InstanceGroupManager.fromJson(data));
  }

  /// Creates an instance group manager, as well as the instance group and the
  /// specified number of instances.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the instance group manager resides.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [size] - Number of instances that should exist.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> insert(InstanceGroupManager request,
      core.String project, core.String zone, core.int size) {
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
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (size == null) {
      throw new core.ArgumentError("Parameter size is required.");
    }
    _queryParams["size"] = ["${size}"];

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/instanceGroupManagers';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Retrieves the list of Instance Group Manager resources contained within
  /// the specified zone.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the instance group manager resides.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [filter] - Optional. Filter expression for filtering listed resources.
  ///
  /// [maxResults] - Optional. Maximum count of results to be returned. Maximum
  /// value is 500 and default value is 500.
  /// Value must be between "0" and "500".
  ///
  /// [pageToken] - Optional. Tag returned by a previous list request truncated
  /// by maxResults. Used to continue a previous list request.
  ///
  /// Completes with a [InstanceGroupManagerList].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstanceGroupManagerList> list(
      core.String project, core.String zone,
      {core.String filter, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/instanceGroupManagers';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new InstanceGroupManagerList.fromJson(data));
  }

  /// Recreates the specified instances. The instances are deleted, then
  /// recreated using the instance group manager's current instance template.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the instance group manager resides.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [instanceGroupManager] - The name of the instance group manager.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> recreateInstances(
      InstanceGroupManagersRecreateInstancesRequest request,
      core.String project,
      core.String zone,
      core.String instanceGroupManager) {
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
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (instanceGroupManager == null) {
      throw new core.ArgumentError(
          "Parameter instanceGroupManager is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/instanceGroupManagers/' +
        commons.Escaper.ecapeVariable('$instanceGroupManager') +
        '/recreateInstances';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Resizes the managed instance group up or down. If resized up, new
  /// instances are created using the current instance template. If resized
  /// down, instances are removed in the order outlined in Resizing a managed
  /// instance group.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the instance group manager resides.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [instanceGroupManager] - The name of the instance group manager.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [size] - Number of instances that should exist in this Instance Group
  /// Manager.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> resize(core.String project, core.String zone,
      core.String instanceGroupManager, core.int size) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (instanceGroupManager == null) {
      throw new core.ArgumentError(
          "Parameter instanceGroupManager is required.");
    }
    if (size == null) {
      throw new core.ArgumentError("Parameter size is required.");
    }
    _queryParams["size"] = ["${size}"];

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/instanceGroupManagers/' +
        commons.Escaper.ecapeVariable('$instanceGroupManager') +
        '/resize';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Sets the instance template to use when creating new instances in this
  /// group. Existing instances are not affected.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the instance group manager resides.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [instanceGroupManager] - The name of the instance group manager.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> setInstanceTemplate(
      InstanceGroupManagersSetInstanceTemplateRequest request,
      core.String project,
      core.String zone,
      core.String instanceGroupManager) {
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
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (instanceGroupManager == null) {
      throw new core.ArgumentError(
          "Parameter instanceGroupManager is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/instanceGroupManagers/' +
        commons.Escaper.ecapeVariable('$instanceGroupManager') +
        '/setInstanceTemplate';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Modifies the target pools to which all new instances in this group are
  /// assigned. Existing instances in the group are not affected.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the instance group manager resides.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [instanceGroupManager] - The name of the instance group manager.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> setTargetPools(
      InstanceGroupManagersSetTargetPoolsRequest request,
      core.String project,
      core.String zone,
      core.String instanceGroupManager) {
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
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (instanceGroupManager == null) {
      throw new core.ArgumentError(
          "Parameter instanceGroupManager is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/instanceGroupManagers/' +
        commons.Escaper.ecapeVariable('$instanceGroupManager') +
        '/setTargetPools';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }
}

class ZoneOperationsResourceApi {
  final commons.ApiRequester _requester;

  ZoneOperationsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Retrieves the specified zone-specific operation resource.
  ///
  /// Request parameters:
  ///
  /// [project] - Name of the project scoping this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - Name of the zone scoping this request.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [operation] - Name of the operation resource to return.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> get(
      core.String project, core.String zone, core.String operation) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (operation == null) {
      throw new core.ArgumentError("Parameter operation is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/operations/' +
        commons.Escaper.ecapeVariable('$operation');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Retrieves the list of operation resources contained within the specified
  /// zone.
  ///
  /// Request parameters:
  ///
  /// [project] - Name of the project scoping this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - Name of the zone scoping this request.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [filter] - Optional. Filter expression for filtering listed resources.
  ///
  /// [maxResults] - Optional. Maximum count of results to be returned. Maximum
  /// value is 500 and default value is 500.
  /// Value must be between "0" and "500".
  ///
  /// [pageToken] - Optional. Tag returned by a previous list request truncated
  /// by maxResults. Used to continue a previous list request.
  ///
  /// Completes with a [OperationList].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OperationList> list(core.String project, core.String zone,
      {core.String filter, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/operations';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new OperationList.fromJson(data));
  }
}

/// An Instance Group Manager resource.
class InstanceGroupManager {
  /// The autohealing policy for this managed instance group. You can specify
  /// only one value.
  core.List<ReplicaPoolAutoHealingPolicy> autoHealingPolicies;

  /// The base instance name to use for instances in this group. The value must
  /// be a valid RFC1035 name. Supported characters are lowercase letters,
  /// numbers, and hyphens (-). Instances are named by appending a hyphen and a
  /// random four-character string to the base instance name.
  core.String baseInstanceName;

  /// [Output only] The time the instance group manager was created, in RFC3339
  /// text format.
  core.String creationTimestamp;

  /// [Output only] The number of instances that currently exist and are a part
  /// of this group. This includes instances that are starting but are not yet
  /// RUNNING, and instances that are in the process of being deleted or
  /// abandoned.
  core.int currentSize;

  /// An optional textual description of the instance group manager.
  core.String description;

  /// [Output only] Fingerprint of the instance group manager. This field is
  /// used for optimistic locking. An up-to-date fingerprint must be provided in
  /// order to modify the Instance Group Manager resource.
  core.String fingerprint;
  core.List<core.int> get fingerprintAsBytes {
    return convert.BASE64.decode(fingerprint);
  }

  void set fingerprintAsBytes(core.List<core.int> _bytes) {
    fingerprint =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// [Output only] The full URL of the instance group created by the manager.
  /// This group contains all of the instances being managed, and cannot contain
  /// non-managed instances.
  core.String group;

  /// [Output only] A server-assigned unique identifier for the resource.
  core.String id;

  /// The full URL to an instance template from which all new instances will be
  /// created.
  core.String instanceTemplate;

  /// [Output only] The resource type. Always replicapool#instanceGroupManager.
  core.String kind;

  /// The name of the instance group manager. Must be 1-63 characters long and
  /// comply with RFC1035. Supported characters include lowercase letters,
  /// numbers, and hyphens.
  core.String name;

  /// [Output only] The fully qualified URL for this resource.
  core.String selfLink;

  /// The full URL of all target pools to which new instances in the group are
  /// added. Updating the target pool values does not affect existing instances.
  core.List<core.String> targetPools;

  /// [Output only] The number of instances that the manager is attempting to
  /// maintain. Deleting or abandoning instances affects this number, as does
  /// resizing the group.
  core.int targetSize;

  InstanceGroupManager();

  InstanceGroupManager.fromJson(core.Map _json) {
    if (_json.containsKey("autoHealingPolicies")) {
      autoHealingPolicies = _json["autoHealingPolicies"]
          .map((value) => new ReplicaPoolAutoHealingPolicy.fromJson(value))
          .toList();
    }
    if (_json.containsKey("baseInstanceName")) {
      baseInstanceName = _json["baseInstanceName"];
    }
    if (_json.containsKey("creationTimestamp")) {
      creationTimestamp = _json["creationTimestamp"];
    }
    if (_json.containsKey("currentSize")) {
      currentSize = _json["currentSize"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("fingerprint")) {
      fingerprint = _json["fingerprint"];
    }
    if (_json.containsKey("group")) {
      group = _json["group"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("instanceTemplate")) {
      instanceTemplate = _json["instanceTemplate"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("targetPools")) {
      targetPools = _json["targetPools"];
    }
    if (_json.containsKey("targetSize")) {
      targetSize = _json["targetSize"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (autoHealingPolicies != null) {
      _json["autoHealingPolicies"] =
          autoHealingPolicies.map((value) => (value).toJson()).toList();
    }
    if (baseInstanceName != null) {
      _json["baseInstanceName"] = baseInstanceName;
    }
    if (creationTimestamp != null) {
      _json["creationTimestamp"] = creationTimestamp;
    }
    if (currentSize != null) {
      _json["currentSize"] = currentSize;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (fingerprint != null) {
      _json["fingerprint"] = fingerprint;
    }
    if (group != null) {
      _json["group"] = group;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (instanceTemplate != null) {
      _json["instanceTemplate"] = instanceTemplate;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (targetPools != null) {
      _json["targetPools"] = targetPools;
    }
    if (targetSize != null) {
      _json["targetSize"] = targetSize;
    }
    return _json;
  }
}

class InstanceGroupManagerList {
  /// Unique identifier for the resource; defined by the server (output only).
  core.String id;

  /// A list of instance resources.
  core.List<InstanceGroupManager> items;

  /// Type of resource.
  core.String kind;

  /// A token used to continue a truncated list request (output only).
  core.String nextPageToken;

  /// Server defined URL for this resource (output only).
  core.String selfLink;

  InstanceGroupManagerList();

  InstanceGroupManagerList.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"]
          .map((value) => new InstanceGroupManager.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (id != null) {
      _json["id"] = id;
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
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

class InstanceGroupManagersAbandonInstancesRequest {
  /// The names of one or more instances to abandon. For example:
  /// { 'instances': [ 'instance-c3po', 'instance-r2d2' ] }
  core.List<core.String> instances;

  InstanceGroupManagersAbandonInstancesRequest();

  InstanceGroupManagersAbandonInstancesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("instances")) {
      instances = _json["instances"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (instances != null) {
      _json["instances"] = instances;
    }
    return _json;
  }
}

class InstanceGroupManagersDeleteInstancesRequest {
  /// Names of instances to delete.
  ///
  /// Example: 'instance-foo', 'instance-bar'
  core.List<core.String> instances;

  InstanceGroupManagersDeleteInstancesRequest();

  InstanceGroupManagersDeleteInstancesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("instances")) {
      instances = _json["instances"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (instances != null) {
      _json["instances"] = instances;
    }
    return _json;
  }
}

class InstanceGroupManagersRecreateInstancesRequest {
  /// The names of one or more instances to recreate. For example:
  /// { 'instances': [ 'instance-c3po', 'instance-r2d2' ] }
  core.List<core.String> instances;

  InstanceGroupManagersRecreateInstancesRequest();

  InstanceGroupManagersRecreateInstancesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("instances")) {
      instances = _json["instances"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (instances != null) {
      _json["instances"] = instances;
    }
    return _json;
  }
}

class InstanceGroupManagersSetInstanceTemplateRequest {
  /// The full URL to an Instance Template from which all new instances will be
  /// created.
  core.String instanceTemplate;

  InstanceGroupManagersSetInstanceTemplateRequest();

  InstanceGroupManagersSetInstanceTemplateRequest.fromJson(core.Map _json) {
    if (_json.containsKey("instanceTemplate")) {
      instanceTemplate = _json["instanceTemplate"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (instanceTemplate != null) {
      _json["instanceTemplate"] = instanceTemplate;
    }
    return _json;
  }
}

class InstanceGroupManagersSetTargetPoolsRequest {
  /// The current fingerprint of the Instance Group Manager resource. If this
  /// does not match the server-side fingerprint of the resource, then the
  /// request will be rejected.
  core.String fingerprint;
  core.List<core.int> get fingerprintAsBytes {
    return convert.BASE64.decode(fingerprint);
  }

  void set fingerprintAsBytes(core.List<core.int> _bytes) {
    fingerprint =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// A list of fully-qualified URLs to existing Target Pool resources. New
  /// instances in the Instance Group Manager will be added to the specified
  /// target pools; existing instances are not affected.
  core.List<core.String> targetPools;

  InstanceGroupManagersSetTargetPoolsRequest();

  InstanceGroupManagersSetTargetPoolsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("fingerprint")) {
      fingerprint = _json["fingerprint"];
    }
    if (_json.containsKey("targetPools")) {
      targetPools = _json["targetPools"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (fingerprint != null) {
      _json["fingerprint"] = fingerprint;
    }
    if (targetPools != null) {
      _json["targetPools"] = targetPools;
    }
    return _json;
  }
}

class OperationErrorErrors {
  /// [Output Only] The error type identifier for this error.
  core.String code;

  /// [Output Only] Indicates the field in the request which caused the error.
  /// This property is optional.
  core.String location;

  /// [Output Only] An optional, human-readable error message.
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

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
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

/// [Output Only] If errors occurred during processing of this operation, this
/// field will be populated.
class OperationError {
  /// [Output Only] The array of errors encountered while processing this
  /// operation.
  core.List<OperationErrorErrors> errors;

  OperationError();

  OperationError.fromJson(core.Map _json) {
    if (_json.containsKey("errors")) {
      errors = _json["errors"]
          .map((value) => new OperationErrorErrors.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OperationWarningsData {
  /// [Output Only] Metadata key for this warning.
  core.String key;

  /// [Output Only] Metadata value for this warning.
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

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
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
  /// [Output only] The warning type identifier for this warning.
  /// Possible string values are:
  /// - "DEPRECATED_RESOURCE_USED"
  /// - "DISK_SIZE_LARGER_THAN_IMAGE_SIZE"
  /// - "INJECTED_KERNELS_DEPRECATED"
  /// - "NEXT_HOP_ADDRESS_NOT_ASSIGNED"
  /// - "NEXT_HOP_CANNOT_IP_FORWARD"
  /// - "NEXT_HOP_INSTANCE_NOT_FOUND"
  /// - "NEXT_HOP_INSTANCE_NOT_ON_NETWORK"
  /// - "NEXT_HOP_NOT_RUNNING"
  /// - "NO_RESULTS_ON_PAGE"
  /// - "REQUIRED_TOS_AGREEMENT"
  /// - "RESOURCE_NOT_DELETED"
  /// - "SINGLE_INSTANCE_PROPERTY_TEMPLATE"
  /// - "UNREACHABLE"
  core.String code;

  /// [Output only] Metadata for this warning in key:value format.
  core.List<OperationWarningsData> data;

  /// [Output only] Optional human-readable details for this warning.
  core.String message;

  OperationWarnings();

  OperationWarnings.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("data")) {
      data = _json["data"]
          .map((value) => new OperationWarningsData.fromJson(value))
          .toList();
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
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

/// An operation resource, used to manage asynchronous API requests.
class Operation {
  /// [Output only] An optional identifier specified by the client when the
  /// mutation was initiated. Must be unique for all operation resources in the
  /// project.
  core.String clientOperationId;

  /// [Output Only] The time that this operation was requested, in RFC3339 text
  /// format.
  core.String creationTimestamp;

  /// [Output Only] The time that this operation was completed, in RFC3339 text
  /// format.
  core.String endTime;

  /// [Output Only] If errors occurred during processing of this operation, this
  /// field will be populated.
  OperationError error;

  /// [Output only] If operation fails, the HTTP error message returned.
  core.String httpErrorMessage;

  /// [Output only] If operation fails, the HTTP error status code returned.
  core.int httpErrorStatusCode;

  /// [Output Only] Unique identifier for the resource, generated by the server.
  core.String id;

  /// [Output Only] The time that this operation was requested, in RFC3339 text
  /// format.
  core.String insertTime;

  /// [Output only] Type of the resource.
  core.String kind;

  /// [Output Only] Name of the resource.
  core.String name;

  /// [Output only] Type of the operation. Operations include insert, update,
  /// and delete.
  core.String operationType;

  /// [Output only] An optional progress indicator that ranges from 0 to 100.
  /// There is no requirement that this be linear or support any granularity of
  /// operations. This should not be used to guess at when the operation will be
  /// complete. This number should be monotonically increasing as the operation
  /// progresses.
  core.int progress;

  /// [Output Only] URL of the region where the operation resides. Only
  /// available when performing regional operations.
  core.String region;

  /// [Output Only] Server-defined fully-qualified URL for this resource.
  core.String selfLink;

  /// [Output Only] The time that this operation was started by the server, in
  /// RFC3339 text format.
  core.String startTime;

  /// [Output Only] Status of the operation.
  /// Possible string values are:
  /// - "DONE"
  /// - "PENDING"
  /// - "RUNNING"
  core.String status;

  /// [Output Only] An optional textual description of the current status of the
  /// operation.
  core.String statusMessage;

  /// [Output Only] Unique target ID which identifies a particular incarnation
  /// of the target.
  core.String targetId;

  /// [Output only] URL of the resource the operation is mutating.
  core.String targetLink;

  /// [Output Only] User who requested the operation, for example:
  /// user@example.com.
  core.String user;

  /// [Output Only] If there are issues with this operation, a warning is
  /// returned.
  core.List<OperationWarnings> warnings;

  /// [Output Only] URL of the zone where the operation resides. Only available
  /// when performing per-zone operations.
  core.String zone;

  Operation();

  Operation.fromJson(core.Map _json) {
    if (_json.containsKey("clientOperationId")) {
      clientOperationId = _json["clientOperationId"];
    }
    if (_json.containsKey("creationTimestamp")) {
      creationTimestamp = _json["creationTimestamp"];
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
      warnings = _json["warnings"]
          .map((value) => new OperationWarnings.fromJson(value))
          .toList();
    }
    if (_json.containsKey("zone")) {
      zone = _json["zone"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (clientOperationId != null) {
      _json["clientOperationId"] = clientOperationId;
    }
    if (creationTimestamp != null) {
      _json["creationTimestamp"] = creationTimestamp;
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

class OperationList {
  /// Unique identifier for the resource; defined by the server (output only).
  core.String id;

  /// The operation resources.
  core.List<Operation> items;

  /// Type of resource.
  core.String kind;

  /// A token used to continue a truncated list request (output only).
  core.String nextPageToken;

  /// Server defined URL for this resource (output only).
  core.String selfLink;

  OperationList();

  OperationList.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("items")) {
      items =
          _json["items"].map((value) => new Operation.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (id != null) {
      _json["id"] = id;
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
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

class ReplicaPoolAutoHealingPolicy {
  /// The action to perform when an instance becomes unhealthy. Possible values
  /// are RECREATE or REBOOT. RECREATE replaces an unhealthy instance with a new
  /// instance that is based on the instance template for this managed instance
  /// group. REBOOT performs a soft reboot on an instance. If the instance
  /// cannot reboot, the instance performs a hard restart.
  /// Possible string values are:
  /// - "REBOOT"
  /// - "RECREATE"
  core.String actionType;

  /// The URL for the HealthCheck that signals autohealing.
  core.String healthCheck;

  ReplicaPoolAutoHealingPolicy();

  ReplicaPoolAutoHealingPolicy.fromJson(core.Map _json) {
    if (_json.containsKey("actionType")) {
      actionType = _json["actionType"];
    }
    if (_json.containsKey("healthCheck")) {
      healthCheck = _json["healthCheck"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (actionType != null) {
      _json["actionType"] = actionType;
    }
    if (healthCheck != null) {
      _json["healthCheck"] = healthCheck;
    }
    return _json;
  }
}
