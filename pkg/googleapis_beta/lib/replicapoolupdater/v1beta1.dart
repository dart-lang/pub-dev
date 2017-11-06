// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.replicapoolupdater.v1beta1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client replicapoolupdater/v1beta1';

/// [Deprecated. Please use compute.instanceGroupManagers.update method.
/// replicapoolupdater API will be disabled after December 30th, 2016] Updates
/// groups of Compute Engine instances.
class ReplicapoolupdaterApi {
  /// View and manage your data across Google Cloud Platform services
  static const CloudPlatformScope =
      "https://www.googleapis.com/auth/cloud-platform";

  /// View your data across Google Cloud Platform services
  static const CloudPlatformReadOnlyScope =
      "https://www.googleapis.com/auth/cloud-platform.read-only";

  /// View and manage replica pools
  static const ReplicapoolScope = "https://www.googleapis.com/auth/replicapool";

  /// View replica pools
  static const ReplicapoolReadonlyScope =
      "https://www.googleapis.com/auth/replicapool.readonly";

  final commons.ApiRequester _requester;

  RollingUpdatesResourceApi get rollingUpdates =>
      new RollingUpdatesResourceApi(_requester);
  ZoneOperationsResourceApi get zoneOperations =>
      new ZoneOperationsResourceApi(_requester);

  ReplicapoolupdaterApi(http.Client client,
      {core.String rootUrl: "https://www.googleapis.com/",
      core.String servicePath: "replicapoolupdater/v1beta1/projects/"})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class RollingUpdatesResourceApi {
  final commons.ApiRequester _requester;

  RollingUpdatesResourceApi(commons.ApiRequester client) : _requester = client;

  /// Cancels an update. The update must be PAUSED before it can be cancelled.
  /// This has no effect if the update is already CANCELLED.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the update's target resides.
  ///
  /// [rollingUpdate] - The name of the update.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> cancel(
      core.String project, core.String zone, core.String rollingUpdate) {
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
    if (rollingUpdate == null) {
      throw new core.ArgumentError("Parameter rollingUpdate is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/rollingUpdates/' +
        commons.Escaper.ecapeVariable('$rollingUpdate') +
        '/cancel';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Returns information about an update.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the update's target resides.
  ///
  /// [rollingUpdate] - The name of the update.
  ///
  /// Completes with a [RollingUpdate].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<RollingUpdate> get(
      core.String project, core.String zone, core.String rollingUpdate) {
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
    if (rollingUpdate == null) {
      throw new core.ArgumentError("Parameter rollingUpdate is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/rollingUpdates/' +
        commons.Escaper.ecapeVariable('$rollingUpdate');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new RollingUpdate.fromJson(data));
  }

  /// Inserts and starts a new update.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the update's target resides.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> insert(
      RollingUpdate request, core.String project, core.String zone) {
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

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/rollingUpdates';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Lists recent updates for a given managed instance group, in reverse
  /// chronological order and paginated format.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the update's target resides.
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
  /// Completes with a [RollingUpdateList].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<RollingUpdateList> list(core.String project, core.String zone,
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
        '/rollingUpdates';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new RollingUpdateList.fromJson(data));
  }

  /// Lists the current status for each instance within a given update.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the update's target resides.
  ///
  /// [rollingUpdate] - The name of the update.
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
  /// Completes with a [InstanceUpdateList].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstanceUpdateList> listInstanceUpdates(
      core.String project, core.String zone, core.String rollingUpdate,
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
    if (rollingUpdate == null) {
      throw new core.ArgumentError("Parameter rollingUpdate is required.");
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
        '/rollingUpdates/' +
        commons.Escaper.ecapeVariable('$rollingUpdate') +
        '/instanceUpdates';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new InstanceUpdateList.fromJson(data));
  }

  /// Pauses the update in state from ROLLING_FORWARD or ROLLING_BACK. Has no
  /// effect if invoked when the state of the update is PAUSED.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the update's target resides.
  ///
  /// [rollingUpdate] - The name of the update.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> pause(
      core.String project, core.String zone, core.String rollingUpdate) {
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
    if (rollingUpdate == null) {
      throw new core.ArgumentError("Parameter rollingUpdate is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/rollingUpdates/' +
        commons.Escaper.ecapeVariable('$rollingUpdate') +
        '/pause';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Continues an update in PAUSED state. Has no effect if invoked when the
  /// state of the update is ROLLED_OUT.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the update's target resides.
  ///
  /// [rollingUpdate] - The name of the update.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> resume(
      core.String project, core.String zone, core.String rollingUpdate) {
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
    if (rollingUpdate == null) {
      throw new core.ArgumentError("Parameter rollingUpdate is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/rollingUpdates/' +
        commons.Escaper.ecapeVariable('$rollingUpdate') +
        '/resume';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Rolls back the update in state from ROLLING_FORWARD or PAUSED. Has no
  /// effect if invoked when the state of the update is ROLLED_BACK.
  ///
  /// Request parameters:
  ///
  /// [project] - The Google Developers Console project name.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - The name of the zone in which the update's target resides.
  ///
  /// [rollingUpdate] - The name of the update.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> rollback(
      core.String project, core.String zone, core.String rollingUpdate) {
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
    if (rollingUpdate == null) {
      throw new core.ArgumentError("Parameter rollingUpdate is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/rollingUpdates/' +
        commons.Escaper.ecapeVariable('$rollingUpdate') +
        '/rollback';

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
  ///
  /// [operation] - Name of the operation resource to return.
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

  /// Retrieves the list of Operation resources contained within the specified
  /// zone.
  ///
  /// Request parameters:
  ///
  /// [project] - Name of the project scoping this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - Name of the zone scoping this request.
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

class InstanceUpdateErrorErrors {
  /// [Output Only] The error type identifier for this error.
  core.String code;

  /// [Output Only] Indicates the field in the request that caused the error.
  /// This property is optional.
  core.String location;

  /// [Output Only] An optional, human-readable error message.
  core.String message;

  InstanceUpdateErrorErrors();

  InstanceUpdateErrorErrors.fromJson(core.Map _json) {
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

/// Errors that occurred during the instance update.
class InstanceUpdateError {
  /// [Output Only] The array of errors encountered while processing this
  /// operation.
  core.List<InstanceUpdateErrorErrors> errors;

  InstanceUpdateError();

  InstanceUpdateError.fromJson(core.Map _json) {
    if (_json.containsKey("errors")) {
      errors = _json["errors"]
          .map((value) => new InstanceUpdateErrorErrors.fromJson(value))
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

/// Update of a single instance.
class InstanceUpdate {
  /// Errors that occurred during the instance update.
  InstanceUpdateError error;

  /// Fully-qualified URL of the instance being updated.
  core.String instance;

  /// Status of the instance update. Possible values are:
  /// - "PENDING": The instance update is pending execution.
  /// - "ROLLING_FORWARD": The instance update is going forward.
  /// - "ROLLING_BACK": The instance update is being rolled back.
  /// - "PAUSED": The instance update is temporarily paused (inactive).
  /// - "ROLLED_OUT": The instance update is finished, the instance is running
  /// the new template.
  /// - "ROLLED_BACK": The instance update is finished, the instance has been
  /// reverted to the previous template.
  /// - "CANCELLED": The instance update is paused and no longer can be resumed,
  /// undefined in which template the instance is running.
  core.String status;

  InstanceUpdate();

  InstanceUpdate.fromJson(core.Map _json) {
    if (_json.containsKey("error")) {
      error = new InstanceUpdateError.fromJson(_json["error"]);
    }
    if (_json.containsKey("instance")) {
      instance = _json["instance"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (error != null) {
      _json["error"] = (error).toJson();
    }
    if (instance != null) {
      _json["instance"] = instance;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/// Response returned by ListInstanceUpdates method.
class InstanceUpdateList {
  /// Collection of requested instance updates.
  core.List<InstanceUpdate> items;

  /// [Output Only] Type of the resource.
  core.String kind;

  /// A token used to continue a truncated list request.
  core.String nextPageToken;

  /// [Output Only] The fully qualified URL for the resource.
  core.String selfLink;

  InstanceUpdateList();

  InstanceUpdateList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"]
          .map((value) => new InstanceUpdate.fromJson(value))
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

class OperationErrorErrors {
  /// [Output Only] The error type identifier for this error.
  core.String code;

  /// [Output Only] Indicates the field in the request that caused the error.
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
  core.String clientOperationId;

  /// [Output Only] Creation timestamp in RFC3339 text format.
  core.String creationTimestamp;
  core.String endTime;

  /// [Output Only] If errors occurred during processing of this operation, this
  /// field will be populated.
  OperationError error;
  core.String httpErrorMessage;
  core.int httpErrorStatusCode;

  /// [Output Only] Unique identifier for the resource; defined by the server.
  core.String id;

  /// [Output Only] The time that this operation was requested. This is in RFC
  /// 3339 format.
  core.String insertTime;

  /// [Output Only] Type of the resource. Always replicapoolupdater#operation
  /// for Operation resources.
  core.String kind;

  /// [Output Only] Name of the resource.
  core.String name;
  core.String operationType;
  core.int progress;

  /// [Output Only] URL of the region where the operation resides.
  core.String region;

  /// [Output Only] The fully qualified URL for the resource.
  core.String selfLink;

  /// [Output Only] The time that this operation was started by the server. This
  /// is in RFC 3339 format.
  core.String startTime;

  /// [Output Only] Status of the operation. Can be one of the following:
  /// "PENDING", "RUNNING", or "DONE".
  core.String status;

  /// [Output Only] An optional textual description of the current status of the
  /// operation.
  core.String statusMessage;

  /// [Output Only] Unique target id which identifies a particular incarnation
  /// of the target.
  core.String targetId;

  /// [Output Only] URL of the resource the operation is mutating.
  core.String targetLink;
  core.String user;
  core.List<OperationWarnings> warnings;

  /// [Output Only] URL of the zone where the operation resides.
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

/// Contains a list of Operation resources.
class OperationList {
  /// [Output Only] Unique identifier for the resource; defined by the server.
  core.String id;

  /// [Output Only] The Operation resources.
  core.List<Operation> items;

  /// [Output Only] Type of resource. Always replicapoolupdater#operationList
  /// for OperationList resources.
  core.String kind;

  /// [Output Only] A token used to continue a truncate.
  core.String nextPageToken;

  /// [Output Only] The fully qualified URL for the resource.
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

class RollingUpdateErrorErrors {
  /// [Output Only] The error type identifier for this error.
  core.String code;

  /// [Output Only] Indicates the field in the request that caused the error.
  /// This property is optional.
  core.String location;

  /// [Output Only] An optional, human-readable error message.
  core.String message;

  RollingUpdateErrorErrors();

  RollingUpdateErrorErrors.fromJson(core.Map _json) {
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

/// [Output Only] Errors that occurred during the rolling update.
class RollingUpdateError {
  /// [Output Only] The array of errors encountered while processing this
  /// operation.
  core.List<RollingUpdateErrorErrors> errors;

  RollingUpdateError();

  RollingUpdateError.fromJson(core.Map _json) {
    if (_json.containsKey("errors")) {
      errors = _json["errors"]
          .map((value) => new RollingUpdateErrorErrors.fromJson(value))
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

/// Parameters of the update process.
class RollingUpdatePolicy {
  /// Number of instances to update before the updater pauses the rolling
  /// update.
  core.int autoPauseAfterInstances;

  /// The maximum amount of time that the updater waits for a HEALTHY state
  /// after all of the update steps are complete. If the HEALTHY state is not
  /// received before the deadline, the instance update is considered a failure.
  core.int instanceStartupTimeoutSec;

  /// The maximum number of instances that can be updated simultaneously. An
  /// instance update is considered complete only after the instance is
  /// restarted and initialized.
  core.int maxNumConcurrentInstances;

  /// The maximum number of instance updates that can fail before the group
  /// update is considered a failure. An instance update is considered failed if
  /// any of its update actions (e.g. Stop call on Instance resource in Rolling
  /// Reboot) failed with permanent failure, or if the instance is in an
  /// UNHEALTHY state after it finishes all of the update actions.
  core.int maxNumFailedInstances;

  /// The minimum amount of time that the updater spends to update each
  /// instance. Update time is the time it takes to complete all update actions
  /// (e.g. Stop call on Instance resource in Rolling Reboot), reboot, and
  /// initialize. If the instance update finishes early, the updater pauses for
  /// the remainder of the time before it starts the next instance update.
  core.int minInstanceUpdateTimeSec;

  RollingUpdatePolicy();

  RollingUpdatePolicy.fromJson(core.Map _json) {
    if (_json.containsKey("autoPauseAfterInstances")) {
      autoPauseAfterInstances = _json["autoPauseAfterInstances"];
    }
    if (_json.containsKey("instanceStartupTimeoutSec")) {
      instanceStartupTimeoutSec = _json["instanceStartupTimeoutSec"];
    }
    if (_json.containsKey("maxNumConcurrentInstances")) {
      maxNumConcurrentInstances = _json["maxNumConcurrentInstances"];
    }
    if (_json.containsKey("maxNumFailedInstances")) {
      maxNumFailedInstances = _json["maxNumFailedInstances"];
    }
    if (_json.containsKey("minInstanceUpdateTimeSec")) {
      minInstanceUpdateTimeSec = _json["minInstanceUpdateTimeSec"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (autoPauseAfterInstances != null) {
      _json["autoPauseAfterInstances"] = autoPauseAfterInstances;
    }
    if (instanceStartupTimeoutSec != null) {
      _json["instanceStartupTimeoutSec"] = instanceStartupTimeoutSec;
    }
    if (maxNumConcurrentInstances != null) {
      _json["maxNumConcurrentInstances"] = maxNumConcurrentInstances;
    }
    if (maxNumFailedInstances != null) {
      _json["maxNumFailedInstances"] = maxNumFailedInstances;
    }
    if (minInstanceUpdateTimeSec != null) {
      _json["minInstanceUpdateTimeSec"] = minInstanceUpdateTimeSec;
    }
    return _json;
  }
}

/// The following represents a resource describing a single update (rollout) of
/// a group of instances to the given template.
class RollingUpdate {
  /// Specifies the action to take for each instance within the instance group.
  /// This can be RECREATE which will recreate each instance and is only
  /// available for managed instance groups. It can also be REBOOT which
  /// performs a soft reboot for each instance and is only available for regular
  /// (non-managed) instance groups.
  core.String actionType;

  /// [Output Only] Creation timestamp in RFC3339 text format.
  core.String creationTimestamp;

  /// An optional textual description of the resource; provided by the client
  /// when the resource is created.
  core.String description;

  /// [Output Only] Errors that occurred during the rolling update.
  RollingUpdateError error;

  /// [Output Only] Unique identifier for the resource; defined by the server.
  core.String id;

  /// Fully-qualified URL of an instance group being updated. Exactly one of
  /// instanceGroupManager and instanceGroup must be set.
  core.String instanceGroup;

  /// Fully-qualified URL of an instance group manager being updated. Exactly
  /// one of instanceGroupManager and instanceGroup must be set.
  core.String instanceGroupManager;

  /// Fully-qualified URL of an instance template to apply.
  core.String instanceTemplate;

  /// [Output Only] Type of the resource.
  core.String kind;

  /// Fully-qualified URL of the instance template encountered while starting
  /// the update.
  core.String oldInstanceTemplate;

  /// Parameters of the update process.
  RollingUpdatePolicy policy;

  /// [Output Only] An optional progress indicator that ranges from 0 to 100.
  /// There is no requirement that this be linear or support any granularity of
  /// operations. This should not be used to guess at when the update will be
  /// complete. This number should be monotonically increasing as the update
  /// progresses.
  core.int progress;

  /// [Output Only] The fully qualified URL for the resource.
  core.String selfLink;

  /// [Output Only] Status of the update. Possible values are:
  /// - "ROLLING_FORWARD": The update is going forward.
  /// - "ROLLING_BACK": The update is being rolled back.
  /// - "PAUSED": The update is temporarily paused (inactive).
  /// - "ROLLED_OUT": The update is finished, all instances have been updated
  /// successfully.
  /// - "ROLLED_BACK": The update is finished, all instances have been reverted
  /// to the previous template.
  /// - "CANCELLED": The update is paused and no longer can be resumed,
  /// undefined how many instances are running in which template.
  core.String status;

  /// [Output Only] An optional textual description of the current status of the
  /// update.
  core.String statusMessage;

  /// [Output Only] User who requested the update, for example:
  /// user@example.com.
  core.String user;

  RollingUpdate();

  RollingUpdate.fromJson(core.Map _json) {
    if (_json.containsKey("actionType")) {
      actionType = _json["actionType"];
    }
    if (_json.containsKey("creationTimestamp")) {
      creationTimestamp = _json["creationTimestamp"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("error")) {
      error = new RollingUpdateError.fromJson(_json["error"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("instanceGroup")) {
      instanceGroup = _json["instanceGroup"];
    }
    if (_json.containsKey("instanceGroupManager")) {
      instanceGroupManager = _json["instanceGroupManager"];
    }
    if (_json.containsKey("instanceTemplate")) {
      instanceTemplate = _json["instanceTemplate"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("oldInstanceTemplate")) {
      oldInstanceTemplate = _json["oldInstanceTemplate"];
    }
    if (_json.containsKey("policy")) {
      policy = new RollingUpdatePolicy.fromJson(_json["policy"]);
    }
    if (_json.containsKey("progress")) {
      progress = _json["progress"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("statusMessage")) {
      statusMessage = _json["statusMessage"];
    }
    if (_json.containsKey("user")) {
      user = _json["user"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (actionType != null) {
      _json["actionType"] = actionType;
    }
    if (creationTimestamp != null) {
      _json["creationTimestamp"] = creationTimestamp;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (error != null) {
      _json["error"] = (error).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (instanceGroup != null) {
      _json["instanceGroup"] = instanceGroup;
    }
    if (instanceGroupManager != null) {
      _json["instanceGroupManager"] = instanceGroupManager;
    }
    if (instanceTemplate != null) {
      _json["instanceTemplate"] = instanceTemplate;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (oldInstanceTemplate != null) {
      _json["oldInstanceTemplate"] = oldInstanceTemplate;
    }
    if (policy != null) {
      _json["policy"] = (policy).toJson();
    }
    if (progress != null) {
      _json["progress"] = progress;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (statusMessage != null) {
      _json["statusMessage"] = statusMessage;
    }
    if (user != null) {
      _json["user"] = user;
    }
    return _json;
  }
}

/// Response returned by List method.
class RollingUpdateList {
  /// Collection of requested updates.
  core.List<RollingUpdate> items;

  /// [Output Only] Type of the resource.
  core.String kind;

  /// A token used to continue a truncated list request.
  core.String nextPageToken;

  /// [Output Only] The fully qualified URL for the resource.
  core.String selfLink;

  RollingUpdateList();

  RollingUpdateList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"]
          .map((value) => new RollingUpdate.fromJson(value))
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
