// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.toolresults.v1beta3;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client toolresults/v1beta3';

/// Reads and publishes results from Firebase Test Lab.
class ToolresultsApi {
  /// View and manage your data across Google Cloud Platform services
  static const CloudPlatformScope =
      "https://www.googleapis.com/auth/cloud-platform";

  final commons.ApiRequester _requester;

  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);

  ToolresultsApi(http.Client client,
      {core.String rootUrl: "https://www.googleapis.com/",
      core.String servicePath: "toolresults/v1beta3/projects/"})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsHistoriesResourceApi get histories =>
      new ProjectsHistoriesResourceApi(_requester);

  ProjectsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Gets the Tool Results settings for a project.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to read from project
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// Completes with a [ProjectSettings].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ProjectSettings> getSettings(core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') + '/settings';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ProjectSettings.fromJson(data));
  }

  /// Creates resources for settings which have not yet been set.
  ///
  /// Currently, this creates a single resource: a Google Cloud Storage bucket,
  /// to be used as the default bucket for this project. The bucket is created
  /// in an FTL-own storage project. Except for in rare cases, calling this
  /// method in parallel from multiple clients will only create a single bucket.
  /// In order to avoid unnecessary storage charges, the bucket is configured to
  /// automatically delete objects older than 90 days.
  ///
  /// The bucket is created with the following permissions: - Owner access for
  /// owners of central storage project (FTL-owned) - Writer access for
  /// owners/editors of customer project - Reader access for viewers of customer
  /// project The default ACL on objects created in the bucket is: - Owner
  /// access for owners of central storage project - Reader access for
  /// owners/editors/viewers of customer project See Google Cloud Storage
  /// documentation for more details.
  ///
  /// If there is already a default bucket set and the project can access the
  /// bucket, this call does nothing. However, if the project doesn't have the
  /// permission to access the bucket or the bucket is deleted, a new bucket
  /// will be created.
  ///
  /// May return any canonical error codes, including the following:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to write to project -
  /// Any error code raised by Google Cloud Storage
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// Completes with a [ProjectSettings].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ProjectSettings> initializeSettings(core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') + ':initializeSettings';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ProjectSettings.fromJson(data));
  }
}

class ProjectsHistoriesResourceApi {
  final commons.ApiRequester _requester;

  ProjectsHistoriesExecutionsResourceApi get executions =>
      new ProjectsHistoriesExecutionsResourceApi(_requester);

  ProjectsHistoriesResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Creates a History.
  ///
  /// The returned History will have the id set.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to write to project -
  /// INVALID_ARGUMENT - if the request is malformed - NOT_FOUND - if the
  /// containing project does not exist
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [requestId] - A unique request ID for server to detect duplicated
  /// requests. For example, a UUID.
  ///
  /// Optional, but strongly recommended.
  ///
  /// Completes with a [History].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<History> create(History request, core.String projectId,
      {core.String requestId}) {
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
    if (requestId != null) {
      _queryParams["requestId"] = [requestId];
    }

    _url = commons.Escaper.ecapeVariable('$projectId') + '/histories';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new History.fromJson(data));
  }

  /// Gets a History.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to read project -
  /// INVALID_ARGUMENT - if the request is malformed - NOT_FOUND - if the
  /// History does not exist
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [historyId] - A History id.
  ///
  /// Required.
  ///
  /// Completes with a [History].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<History> get(core.String projectId, core.String historyId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new History.fromJson(data));
  }

  /// Lists Histories for a given Project.
  ///
  /// The histories are sorted by modification time in descending order. The
  /// history_id key will be used to order the history with the same
  /// modification time.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to read project -
  /// INVALID_ARGUMENT - if the request is malformed - NOT_FOUND - if the
  /// History does not exist
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [filterByName] - If set, only return histories with the given name.
  ///
  /// Optional.
  ///
  /// [pageSize] - The maximum number of Histories to fetch.
  ///
  /// Default value: 20. The server will use this default if the field is not
  /// set or has a value of 0. Any value greater than 100 will be treated as
  /// 100.
  ///
  /// Optional.
  ///
  /// [pageToken] - A continuation token to resume the query at the next item.
  ///
  /// Optional.
  ///
  /// Completes with a [ListHistoriesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListHistoriesResponse> list(core.String projectId,
      {core.String filterByName, core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (filterByName != null) {
      _queryParams["filterByName"] = [filterByName];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$projectId') + '/histories';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListHistoriesResponse.fromJson(data));
  }
}

class ProjectsHistoriesExecutionsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsHistoriesExecutionsClustersResourceApi get clusters =>
      new ProjectsHistoriesExecutionsClustersResourceApi(_requester);
  ProjectsHistoriesExecutionsStepsResourceApi get steps =>
      new ProjectsHistoriesExecutionsStepsResourceApi(_requester);

  ProjectsHistoriesExecutionsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Creates an Execution.
  ///
  /// The returned Execution will have the id set.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to write to project -
  /// INVALID_ARGUMENT - if the request is malformed - NOT_FOUND - if the
  /// containing History does not exist
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [historyId] - A History id.
  ///
  /// Required.
  ///
  /// [requestId] - A unique request ID for server to detect duplicated
  /// requests. For example, a UUID.
  ///
  /// Optional, but strongly recommended.
  ///
  /// Completes with a [Execution].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Execution> create(
      Execution request, core.String projectId, core.String historyId,
      {core.String requestId}) {
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
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (requestId != null) {
      _queryParams["requestId"] = [requestId];
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Execution.fromJson(data));
  }

  /// Gets an Execution.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to write to project -
  /// INVALID_ARGUMENT - if the request is malformed - NOT_FOUND - if the
  /// Execution does not exist
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [historyId] - A History id.
  ///
  /// Required.
  ///
  /// [executionId] - An Execution id.
  ///
  /// Required.
  ///
  /// Completes with a [Execution].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Execution> get(
      core.String projectId, core.String historyId, core.String executionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Execution.fromJson(data));
  }

  /// Lists Histories for a given Project.
  ///
  /// The executions are sorted by creation_time in descending order. The
  /// execution_id key will be used to order the executions with the same
  /// creation_time.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to read project -
  /// INVALID_ARGUMENT - if the request is malformed - NOT_FOUND - if the
  /// containing History does not exist
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [historyId] - A History id.
  ///
  /// Required.
  ///
  /// [pageSize] - The maximum number of Executions to fetch.
  ///
  /// Default value: 25. The server will use this default if the field is not
  /// set or has a value of 0.
  ///
  /// Optional.
  ///
  /// [pageToken] - A continuation token to resume the query at the next item.
  ///
  /// Optional.
  ///
  /// Completes with a [ListExecutionsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListExecutionsResponse> list(
      core.String projectId, core.String historyId,
      {core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListExecutionsResponse.fromJson(data));
  }

  /// Updates an existing Execution with the supplied partial entity.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to write to project -
  /// INVALID_ARGUMENT - if the request is malformed - FAILED_PRECONDITION - if
  /// the requested state transition is illegal - NOT_FOUND - if the containing
  /// History does not exist
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id. Required.
  ///
  /// [historyId] - Required.
  ///
  /// [executionId] - Required.
  ///
  /// [requestId] - A unique request ID for server to detect duplicated
  /// requests. For example, a UUID.
  ///
  /// Optional, but strongly recommended.
  ///
  /// Completes with a [Execution].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Execution> patch(Execution request, core.String projectId,
      core.String historyId, core.String executionId,
      {core.String requestId}) {
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
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (requestId != null) {
      _queryParams["requestId"] = [requestId];
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId');

    var _response = _requester.request(_url, "PATCH",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Execution.fromJson(data));
  }
}

class ProjectsHistoriesExecutionsClustersResourceApi {
  final commons.ApiRequester _requester;

  ProjectsHistoriesExecutionsClustersResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Retrieves a single screenshot cluster by its ID
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [historyId] - A History id.
  ///
  /// Required.
  ///
  /// [executionId] - An Execution id.
  ///
  /// Required.
  ///
  /// [clusterId] - A Cluster id
  ///
  /// Required.
  ///
  /// Completes with a [ScreenshotCluster].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ScreenshotCluster> get(core.String projectId,
      core.String historyId, core.String executionId, core.String clusterId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (clusterId == null) {
      throw new core.ArgumentError("Parameter clusterId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/clusters/' +
        commons.Escaper.ecapeVariable('$clusterId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ScreenshotCluster.fromJson(data));
  }

  /// Lists Screenshot Clusters
  ///
  /// Returns the list of screenshot clusters corresponding to an execution.
  /// Screenshot clusters are created after the execution is finished. Clusters
  /// are created from a set of screenshots. Between any two screenshots, a
  /// matching score is calculated based off their metadata that determines how
  /// similar they are. Screenshots are placed in the cluster that has screens
  /// which have the highest matching scores.
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [historyId] - A History id.
  ///
  /// Required.
  ///
  /// [executionId] - An Execution id.
  ///
  /// Required.
  ///
  /// Completes with a [ListScreenshotClustersResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListScreenshotClustersResponse> list(
      core.String projectId, core.String historyId, core.String executionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/clusters';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ListScreenshotClustersResponse.fromJson(data));
  }
}

class ProjectsHistoriesExecutionsStepsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsHistoriesExecutionsStepsPerfMetricsSummaryResourceApi
      get perfMetricsSummary =>
          new ProjectsHistoriesExecutionsStepsPerfMetricsSummaryResourceApi(
              _requester);
  ProjectsHistoriesExecutionsStepsPerfSampleSeriesResourceApi
      get perfSampleSeries =>
          new ProjectsHistoriesExecutionsStepsPerfSampleSeriesResourceApi(
              _requester);
  ProjectsHistoriesExecutionsStepsThumbnailsResourceApi get thumbnails =>
      new ProjectsHistoriesExecutionsStepsThumbnailsResourceApi(_requester);

  ProjectsHistoriesExecutionsStepsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Creates a Step.
  ///
  /// The returned Step will have the id set.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to write to project -
  /// INVALID_ARGUMENT - if the request is malformed - FAILED_PRECONDITION - if
  /// the step is too large (more than 10Mib) - NOT_FOUND - if the containing
  /// Execution does not exist
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [historyId] - A History id.
  ///
  /// Required.
  ///
  /// [executionId] - A Execution id.
  ///
  /// Required.
  ///
  /// [requestId] - A unique request ID for server to detect duplicated
  /// requests. For example, a UUID.
  ///
  /// Optional, but strongly recommended.
  ///
  /// Completes with a [Step].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Step> create(Step request, core.String projectId,
      core.String historyId, core.String executionId,
      {core.String requestId}) {
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
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (requestId != null) {
      _queryParams["requestId"] = [requestId];
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Step.fromJson(data));
  }

  /// Gets a Step.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to read project -
  /// INVALID_ARGUMENT - if the request is malformed - NOT_FOUND - if the Step
  /// does not exist
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [historyId] - A History id.
  ///
  /// Required.
  ///
  /// [executionId] - A Execution id.
  ///
  /// Required.
  ///
  /// [stepId] - A Step id.
  ///
  /// Required.
  ///
  /// Completes with a [Step].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Step> get(core.String projectId, core.String historyId,
      core.String executionId, core.String stepId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (stepId == null) {
      throw new core.ArgumentError("Parameter stepId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps/' +
        commons.Escaper.ecapeVariable('$stepId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Step.fromJson(data));
  }

  /// Retrieves a PerfMetricsSummary.
  ///
  /// May return any of the following error code(s): - NOT_FOUND - The specified
  /// PerfMetricsSummary does not exist
  ///
  /// Request parameters:
  ///
  /// [projectId] - The cloud project
  ///
  /// [historyId] - A tool results history ID.
  ///
  /// [executionId] - A tool results execution ID.
  ///
  /// [stepId] - A tool results step ID.
  ///
  /// Completes with a [PerfMetricsSummary].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<PerfMetricsSummary> getPerfMetricsSummary(core.String projectId,
      core.String historyId, core.String executionId, core.String stepId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (stepId == null) {
      throw new core.ArgumentError("Parameter stepId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps/' +
        commons.Escaper.ecapeVariable('$stepId') +
        '/perfMetricsSummary';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new PerfMetricsSummary.fromJson(data));
  }

  /// Lists Steps for a given Execution.
  ///
  /// The steps are sorted by creation_time in descending order. The step_id key
  /// will be used to order the steps with the same creation_time.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to read project -
  /// INVALID_ARGUMENT - if the request is malformed - FAILED_PRECONDITION - if
  /// an argument in the request happens to be invalid; e.g. if an attempt is
  /// made to list the children of a nonexistent Step - NOT_FOUND - if the
  /// containing Execution does not exist
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [historyId] - A History id.
  ///
  /// Required.
  ///
  /// [executionId] - A Execution id.
  ///
  /// Required.
  ///
  /// [pageSize] - The maximum number of Steps to fetch.
  ///
  /// Default value: 25. The server will use this default if the field is not
  /// set or has a value of 0.
  ///
  /// Optional.
  ///
  /// [pageToken] - A continuation token to resume the query at the next item.
  ///
  /// Optional.
  ///
  /// Completes with a [ListStepsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListStepsResponse> list(
      core.String projectId, core.String historyId, core.String executionId,
      {core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListStepsResponse.fromJson(data));
  }

  /// Updates an existing Step with the supplied partial entity.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to write project -
  /// INVALID_ARGUMENT - if the request is malformed - FAILED_PRECONDITION - if
  /// the requested state transition is illegal (e.g try to upload a duplicate
  /// xml file), if the updated step is too large (more than 10Mib) - NOT_FOUND
  /// - if the containing Execution does not exist
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [historyId] - A History id.
  ///
  /// Required.
  ///
  /// [executionId] - A Execution id.
  ///
  /// Required.
  ///
  /// [stepId] - A Step id.
  ///
  /// Required.
  ///
  /// [requestId] - A unique request ID for server to detect duplicated
  /// requests. For example, a UUID.
  ///
  /// Optional, but strongly recommended.
  ///
  /// Completes with a [Step].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Step> patch(Step request, core.String projectId,
      core.String historyId, core.String executionId, core.String stepId,
      {core.String requestId}) {
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
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (stepId == null) {
      throw new core.ArgumentError("Parameter stepId is required.");
    }
    if (requestId != null) {
      _queryParams["requestId"] = [requestId];
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps/' +
        commons.Escaper.ecapeVariable('$stepId');

    var _response = _requester.request(_url, "PATCH",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Step.fromJson(data));
  }

  /// Publish xml files to an existing Step.
  ///
  /// May return any of the following canonical error codes:
  ///
  /// - PERMISSION_DENIED - if the user is not authorized to write project -
  /// INVALID_ARGUMENT - if the request is malformed - FAILED_PRECONDITION - if
  /// the requested state transition is illegal, e.g try to upload a duplicate
  /// xml file or a file too large. - NOT_FOUND - if the containing Execution
  /// does not exist
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [historyId] - A History id.
  ///
  /// Required.
  ///
  /// [executionId] - A Execution id.
  ///
  /// Required.
  ///
  /// [stepId] - A Step id. Note: This step must include a TestExecutionStep.
  ///
  /// Required.
  ///
  /// Completes with a [Step].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Step> publishXunitXmlFiles(
      PublishXunitXmlFilesRequest request,
      core.String projectId,
      core.String historyId,
      core.String executionId,
      core.String stepId) {
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
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (stepId == null) {
      throw new core.ArgumentError("Parameter stepId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps/' +
        commons.Escaper.ecapeVariable('$stepId') +
        ':publishXunitXmlFiles';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Step.fromJson(data));
  }
}

class ProjectsHistoriesExecutionsStepsPerfMetricsSummaryResourceApi {
  final commons.ApiRequester _requester;

  ProjectsHistoriesExecutionsStepsPerfMetricsSummaryResourceApi(
      commons.ApiRequester client)
      : _requester = client;

  /// Creates a PerfMetricsSummary resource. Returns the existing one if it has
  /// already been created.
  ///
  /// May return any of the following error code(s): - NOT_FOUND - The
  /// containing Step does not exist
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The cloud project
  ///
  /// [historyId] - A tool results history ID.
  ///
  /// [executionId] - A tool results execution ID.
  ///
  /// [stepId] - A tool results step ID.
  ///
  /// Completes with a [PerfMetricsSummary].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<PerfMetricsSummary> create(
      PerfMetricsSummary request,
      core.String projectId,
      core.String historyId,
      core.String executionId,
      core.String stepId) {
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
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (stepId == null) {
      throw new core.ArgumentError("Parameter stepId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps/' +
        commons.Escaper.ecapeVariable('$stepId') +
        '/perfMetricsSummary';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new PerfMetricsSummary.fromJson(data));
  }
}

class ProjectsHistoriesExecutionsStepsPerfSampleSeriesResourceApi {
  final commons.ApiRequester _requester;

  ProjectsHistoriesExecutionsStepsPerfSampleSeriesSamplesResourceApi
      get samples =>
          new ProjectsHistoriesExecutionsStepsPerfSampleSeriesSamplesResourceApi(
              _requester);

  ProjectsHistoriesExecutionsStepsPerfSampleSeriesResourceApi(
      commons.ApiRequester client)
      : _requester = client;

  /// Creates a PerfSampleSeries.
  ///
  /// May return any of the following error code(s): - ALREADY_EXISTS -
  /// PerfMetricSummary already exists for the given Step - NOT_FOUND - The
  /// containing Step does not exist
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The cloud project
  ///
  /// [historyId] - A tool results history ID.
  ///
  /// [executionId] - A tool results execution ID.
  ///
  /// [stepId] - A tool results step ID.
  ///
  /// Completes with a [PerfSampleSeries].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<PerfSampleSeries> create(
      PerfSampleSeries request,
      core.String projectId,
      core.String historyId,
      core.String executionId,
      core.String stepId) {
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
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (stepId == null) {
      throw new core.ArgumentError("Parameter stepId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps/' +
        commons.Escaper.ecapeVariable('$stepId') +
        '/perfSampleSeries';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new PerfSampleSeries.fromJson(data));
  }

  /// Gets a PerfSampleSeries.
  ///
  /// May return any of the following error code(s): - NOT_FOUND - The specified
  /// PerfSampleSeries does not exist
  ///
  /// Request parameters:
  ///
  /// [projectId] - The cloud project
  ///
  /// [historyId] - A tool results history ID.
  ///
  /// [executionId] - A tool results execution ID.
  ///
  /// [stepId] - A tool results step ID.
  ///
  /// [sampleSeriesId] - A sample series id
  ///
  /// Completes with a [PerfSampleSeries].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<PerfSampleSeries> get(
      core.String projectId,
      core.String historyId,
      core.String executionId,
      core.String stepId,
      core.String sampleSeriesId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (stepId == null) {
      throw new core.ArgumentError("Parameter stepId is required.");
    }
    if (sampleSeriesId == null) {
      throw new core.ArgumentError("Parameter sampleSeriesId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps/' +
        commons.Escaper.ecapeVariable('$stepId') +
        '/perfSampleSeries/' +
        commons.Escaper.ecapeVariable('$sampleSeriesId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new PerfSampleSeries.fromJson(data));
  }

  /// Lists PerfSampleSeries for a given Step.
  ///
  /// The request provides an optional filter which specifies one or more
  /// PerfMetricsType to include in the result; if none returns all. The
  /// resulting PerfSampleSeries are sorted by ids.
  ///
  /// May return any of the following canonical error codes: - NOT_FOUND - The
  /// containing Step does not exist
  ///
  /// Request parameters:
  ///
  /// [projectId] - The cloud project
  ///
  /// [historyId] - A tool results history ID.
  ///
  /// [executionId] - A tool results execution ID.
  ///
  /// [stepId] - A tool results step ID.
  ///
  /// [filter] - Specify one or more PerfMetricType values such as CPU to filter
  /// the result
  ///
  /// Completes with a [ListPerfSampleSeriesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListPerfSampleSeriesResponse> list(core.String projectId,
      core.String historyId, core.String executionId, core.String stepId,
      {core.List<core.String> filter}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (stepId == null) {
      throw new core.ArgumentError("Parameter stepId is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = filter;
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps/' +
        commons.Escaper.ecapeVariable('$stepId') +
        '/perfSampleSeries';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ListPerfSampleSeriesResponse.fromJson(data));
  }
}

class ProjectsHistoriesExecutionsStepsPerfSampleSeriesSamplesResourceApi {
  final commons.ApiRequester _requester;

  ProjectsHistoriesExecutionsStepsPerfSampleSeriesSamplesResourceApi(
      commons.ApiRequester client)
      : _requester = client;

  /// Creates a batch of PerfSamples - a client can submit multiple batches of
  /// Perf Samples through repeated calls to this method in order to split up a
  /// large request payload - duplicates and existing timestamp entries will be
  /// ignored. - the batch operation may partially succeed - the set of elements
  /// successfully inserted is returned in the response (omits items which
  /// already existed in the database).
  ///
  /// May return any of the following canonical error codes: - NOT_FOUND - The
  /// containing PerfSampleSeries does not exist
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The cloud project
  ///
  /// [historyId] - A tool results history ID.
  ///
  /// [executionId] - A tool results execution ID.
  ///
  /// [stepId] - A tool results step ID.
  ///
  /// [sampleSeriesId] - A sample series id
  ///
  /// Completes with a [BatchCreatePerfSamplesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<BatchCreatePerfSamplesResponse> batchCreate(
      BatchCreatePerfSamplesRequest request,
      core.String projectId,
      core.String historyId,
      core.String executionId,
      core.String stepId,
      core.String sampleSeriesId) {
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
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (stepId == null) {
      throw new core.ArgumentError("Parameter stepId is required.");
    }
    if (sampleSeriesId == null) {
      throw new core.ArgumentError("Parameter sampleSeriesId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps/' +
        commons.Escaper.ecapeVariable('$stepId') +
        '/perfSampleSeries/' +
        commons.Escaper.ecapeVariable('$sampleSeriesId') +
        '/samples:batchCreate';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new BatchCreatePerfSamplesResponse.fromJson(data));
  }

  /// Lists the Performance Samples of a given Sample Series - The list results
  /// are sorted by timestamps ascending - The default page size is 500 samples;
  /// and maximum size allowed 5000 - The response token indicates the last
  /// returned PerfSample timestamp - When the results size exceeds the page
  /// size, submit a subsequent request including the page token to return the
  /// rest of the samples up to the page limit
  ///
  /// May return any of the following canonical error codes: - OUT_OF_RANGE -
  /// The specified request page_token is out of valid range - NOT_FOUND - The
  /// containing PerfSampleSeries does not exist
  ///
  /// Request parameters:
  ///
  /// [projectId] - The cloud project
  ///
  /// [historyId] - A tool results history ID.
  ///
  /// [executionId] - A tool results execution ID.
  ///
  /// [stepId] - A tool results step ID.
  ///
  /// [sampleSeriesId] - A sample series id
  ///
  /// [pageSize] - The default page size is 500 samples, and the maximum size is
  /// 5000. If the page_size is greater than 5000, the effective page size will
  /// be 5000
  ///
  /// [pageToken] - Optional, the next_page_token returned in the previous
  /// response
  ///
  /// Completes with a [ListPerfSamplesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListPerfSamplesResponse> list(
      core.String projectId,
      core.String historyId,
      core.String executionId,
      core.String stepId,
      core.String sampleSeriesId,
      {core.int pageSize,
      core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (stepId == null) {
      throw new core.ArgumentError("Parameter stepId is required.");
    }
    if (sampleSeriesId == null) {
      throw new core.ArgumentError("Parameter sampleSeriesId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps/' +
        commons.Escaper.ecapeVariable('$stepId') +
        '/perfSampleSeries/' +
        commons.Escaper.ecapeVariable('$sampleSeriesId') +
        '/samples';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListPerfSamplesResponse.fromJson(data));
  }
}

class ProjectsHistoriesExecutionsStepsThumbnailsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsHistoriesExecutionsStepsThumbnailsResourceApi(
      commons.ApiRequester client)
      : _requester = client;

  /// Lists thumbnails of images attached to a step.
  ///
  /// May return any of the following canonical error codes: - PERMISSION_DENIED
  /// - if the user is not authorized to read from the project, or from any of
  /// the images - INVALID_ARGUMENT - if the request is malformed - NOT_FOUND -
  /// if the step does not exist, or if any of the images do not exist
  ///
  /// Request parameters:
  ///
  /// [projectId] - A Project id.
  ///
  /// Required.
  ///
  /// [historyId] - A History id.
  ///
  /// Required.
  ///
  /// [executionId] - An Execution id.
  ///
  /// Required.
  ///
  /// [stepId] - A Step id.
  ///
  /// Required.
  ///
  /// [pageSize] - The maximum number of thumbnails to fetch.
  ///
  /// Default value: 50. The server will use this default if the field is not
  /// set or has a value of 0.
  ///
  /// Optional.
  ///
  /// [pageToken] - A continuation token to resume the query at the next item.
  ///
  /// Optional.
  ///
  /// Completes with a [ListStepThumbnailsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListStepThumbnailsResponse> list(core.String projectId,
      core.String historyId, core.String executionId, core.String stepId,
      {core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (historyId == null) {
      throw new core.ArgumentError("Parameter historyId is required.");
    }
    if (executionId == null) {
      throw new core.ArgumentError("Parameter executionId is required.");
    }
    if (stepId == null) {
      throw new core.ArgumentError("Parameter stepId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$projectId') +
        '/histories/' +
        commons.Escaper.ecapeVariable('$historyId') +
        '/executions/' +
        commons.Escaper.ecapeVariable('$executionId') +
        '/steps/' +
        commons.Escaper.ecapeVariable('$stepId') +
        '/thumbnails';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ListStepThumbnailsResponse.fromJson(data));
  }
}

/// Android app information.
class AndroidAppInfo {
  /// The name of the app. Optional
  core.String name;

  /// The package name of the app. Required.
  core.String packageName;

  /// The internal version code of the app. Optional.
  core.String versionCode;

  /// The version name of the app. Optional.
  core.String versionName;

  AndroidAppInfo();

  AndroidAppInfo.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("packageName")) {
      packageName = _json["packageName"];
    }
    if (_json.containsKey("versionCode")) {
      versionCode = _json["versionCode"];
    }
    if (_json.containsKey("versionName")) {
      versionName = _json["versionName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (name != null) {
      _json["name"] = name;
    }
    if (packageName != null) {
      _json["packageName"] = packageName;
    }
    if (versionCode != null) {
      _json["versionCode"] = versionCode;
    }
    if (versionName != null) {
      _json["versionName"] = versionName;
    }
    return _json;
  }
}

/// A test of an Android application that can control an Android component
/// independently of its normal lifecycle.
///
/// See  for more information on types of Android tests.
class AndroidInstrumentationTest {
  /// The java package for the test to be executed. Required
  core.String testPackageId;

  /// The InstrumentationTestRunner class. Required
  core.String testRunnerClass;

  /// Each target must be fully qualified with the package name or class name,
  /// in one of these formats: - "package package_name" - "class
  /// package_name.class_name" - "class package_name.class_name#method_name"
  ///
  /// If empty, all targets in the module will be run.
  core.List<core.String> testTargets;

  /// The flag indicates whether Android Test Orchestrator will be used to run
  /// test or not. Test orchestrator is used if either: - orchestrator_option
  /// field is USE_ORCHESTRATOR, and test runner is compatible with
  /// orchestrator. Or - orchestrator_option field is unspecified or
  /// ORCHESTRATOR_OPTION_UNSPECIFIED, and test runner is compatible with
  /// orchestrator.
  core.bool useOrchestrator;

  AndroidInstrumentationTest();

  AndroidInstrumentationTest.fromJson(core.Map _json) {
    if (_json.containsKey("testPackageId")) {
      testPackageId = _json["testPackageId"];
    }
    if (_json.containsKey("testRunnerClass")) {
      testRunnerClass = _json["testRunnerClass"];
    }
    if (_json.containsKey("testTargets")) {
      testTargets = _json["testTargets"];
    }
    if (_json.containsKey("useOrchestrator")) {
      useOrchestrator = _json["useOrchestrator"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (testPackageId != null) {
      _json["testPackageId"] = testPackageId;
    }
    if (testRunnerClass != null) {
      _json["testRunnerClass"] = testRunnerClass;
    }
    if (testTargets != null) {
      _json["testTargets"] = testTargets;
    }
    if (useOrchestrator != null) {
      _json["useOrchestrator"] = useOrchestrator;
    }
    return _json;
  }
}

/// A test of an android application that explores the application on a virtual
/// or physical Android device, finding culprits and crashes as it goes.
class AndroidRoboTest {
  /// The initial activity that should be used to start the app. Optional
  core.String appInitialActivity;

  /// The java package for the bootstrap. Optional
  core.String bootstrapPackageId;

  /// The runner class for the bootstrap. Optional
  core.String bootstrapRunnerClass;

  /// The max depth of the traversal stack Robo can explore. Optional
  core.int maxDepth;

  /// The max number of steps/actions Robo can execute. Default is no limit (0).
  /// Optional
  core.int maxSteps;

  AndroidRoboTest();

  AndroidRoboTest.fromJson(core.Map _json) {
    if (_json.containsKey("appInitialActivity")) {
      appInitialActivity = _json["appInitialActivity"];
    }
    if (_json.containsKey("bootstrapPackageId")) {
      bootstrapPackageId = _json["bootstrapPackageId"];
    }
    if (_json.containsKey("bootstrapRunnerClass")) {
      bootstrapRunnerClass = _json["bootstrapRunnerClass"];
    }
    if (_json.containsKey("maxDepth")) {
      maxDepth = _json["maxDepth"];
    }
    if (_json.containsKey("maxSteps")) {
      maxSteps = _json["maxSteps"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (appInitialActivity != null) {
      _json["appInitialActivity"] = appInitialActivity;
    }
    if (bootstrapPackageId != null) {
      _json["bootstrapPackageId"] = bootstrapPackageId;
    }
    if (bootstrapRunnerClass != null) {
      _json["bootstrapRunnerClass"] = bootstrapRunnerClass;
    }
    if (maxDepth != null) {
      _json["maxDepth"] = maxDepth;
    }
    if (maxSteps != null) {
      _json["maxSteps"] = maxSteps;
    }
    return _json;
  }
}

/// An Android mobile test specification.
class AndroidTest {
  /// Infomation about the application under test.
  AndroidAppInfo androidAppInfo;

  /// An Android instrumentation test.
  AndroidInstrumentationTest androidInstrumentationTest;

  /// An Android robo test.
  AndroidRoboTest androidRoboTest;

  /// Max time a test is allowed to run before it is automatically cancelled.
  Duration testTimeout;

  AndroidTest();

  AndroidTest.fromJson(core.Map _json) {
    if (_json.containsKey("androidAppInfo")) {
      androidAppInfo = new AndroidAppInfo.fromJson(_json["androidAppInfo"]);
    }
    if (_json.containsKey("androidInstrumentationTest")) {
      androidInstrumentationTest = new AndroidInstrumentationTest.fromJson(
          _json["androidInstrumentationTest"]);
    }
    if (_json.containsKey("androidRoboTest")) {
      androidRoboTest = new AndroidRoboTest.fromJson(_json["androidRoboTest"]);
    }
    if (_json.containsKey("testTimeout")) {
      testTimeout = new Duration.fromJson(_json["testTimeout"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (androidAppInfo != null) {
      _json["androidAppInfo"] = (androidAppInfo).toJson();
    }
    if (androidInstrumentationTest != null) {
      _json["androidInstrumentationTest"] =
          (androidInstrumentationTest).toJson();
    }
    if (androidRoboTest != null) {
      _json["androidRoboTest"] = (androidRoboTest).toJson();
    }
    if (testTimeout != null) {
      _json["testTimeout"] = (testTimeout).toJson();
    }
    return _json;
  }
}

/// `Any` contains an arbitrary serialized protocol buffer message along with a
/// URL that describes the type of the serialized message.
///
/// Protobuf library provides support to pack/unpack Any values in the form of
/// utility functions or additional generated methods of the Any type.
///
/// Example 1: Pack and unpack a message in C++.
///
/// Foo foo = ...; Any any; any.PackFrom(foo); ... if (any.UnpackTo(&foo)) { ...
/// }
///
/// Example 2: Pack and unpack a message in Java.
///
/// Foo foo = ...; Any any = Any.pack(foo); ... if (any.is(Foo.class)) { foo =
/// any.unpack(Foo.class); }
///
/// Example 3: Pack and unpack a message in Python.
///
/// foo = Foo(...) any = Any() any.Pack(foo) ... if any.Is(Foo.DESCRIPTOR):
/// any.Unpack(foo) ...
///
/// Example 4: Pack and unpack a message in Go
///
/// foo := &pb.Foo{...} any, err := ptypes.MarshalAny(foo) ... foo := &pb.Foo{}
/// if err := ptypes.UnmarshalAny(any, foo); err != nil { ... }
///
/// The pack methods provided by protobuf library will by default use
/// 'type.googleapis.com/full.type.name' as the type URL and the unpack methods
/// only use the fully qualified type name after the last '/' in the type URL,
/// for example "foo.bar.com/x/y.z" will yield type name "y.z".
///
///
///
/// JSON ==== The JSON representation of an `Any` value uses the regular
/// representation of the deserialized, embedded message, with an additional
/// field `@type` which contains the type URL. Example:
///
/// package google.profile; message Person { string first_name = 1; string
/// last_name = 2; }
///
/// { "@type": "type.googleapis.com/google.profile.Person", "firstName": ,
/// "lastName":  }
///
/// If the embedded message type is well-known and has a custom JSON
/// representation, that representation will be embedded adding a field `value`
/// which holds the custom JSON in addition to the `@type` field. Example (for
/// message [google.protobuf.Duration][]):
///
/// { "@type": "type.googleapis.com/google.protobuf.Duration", "value": "1.212s"
/// }
class Any {
  /// A URL/resource name whose content describes the type of the serialized
  /// protocol buffer message.
  ///
  /// For URLs which use the scheme `http`, `https`, or no scheme, the following
  /// restrictions and interpretations apply:
  ///
  /// * If no scheme is provided, `https` is assumed. * The last segment of the
  /// URL's path must represent the fully qualified name of the type (as in
  /// `path/google.protobuf.Duration`). The name should be in a canonical form
  /// (e.g., leading "." is not accepted). * An HTTP GET on the URL must yield a
  /// [google.protobuf.Type][] value in binary format, or produce an error. *
  /// Applications are allowed to cache lookup results based on the URL, or have
  /// them precompiled into a binary to avoid any lookup. Therefore, binary
  /// compatibility needs to be preserved on changes to types. (Use versioned
  /// type names to manage breaking changes.)
  ///
  /// Schemes other than `http`, `https` (or the empty scheme) might be used
  /// with implementation specific semantics.
  core.String typeUrl;

  /// Must be a valid serialized protocol buffer of the above specified type.
  core.String value;
  core.List<core.int> get valueAsBytes {
    return convert.BASE64.decode(value);
  }

  void set valueAsBytes(core.List<core.int> _bytes) {
    value =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  Any();

  Any.fromJson(core.Map _json) {
    if (_json.containsKey("typeUrl")) {
      typeUrl = _json["typeUrl"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (typeUrl != null) {
      _json["typeUrl"] = typeUrl;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class AppStartTime {
  /// Optional. The time from app start to reaching the developer-reported
  /// "fully drawn" time. This is only stored if the app includes a call to
  /// Activity.reportFullyDrawn(). See
  /// https://developer.android.com/topic/performance/launch-time.html#time-full
  Duration fullyDrawnTime;

  /// The time from app start to the first displayed activity being drawn, as
  /// reported in Logcat. See
  /// https://developer.android.com/topic/performance/launch-time.html#time-initial
  Duration initialDisplayTime;

  AppStartTime();

  AppStartTime.fromJson(core.Map _json) {
    if (_json.containsKey("fullyDrawnTime")) {
      fullyDrawnTime = new Duration.fromJson(_json["fullyDrawnTime"]);
    }
    if (_json.containsKey("initialDisplayTime")) {
      initialDisplayTime = new Duration.fromJson(_json["initialDisplayTime"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (fullyDrawnTime != null) {
      _json["fullyDrawnTime"] = (fullyDrawnTime).toJson();
    }
    if (initialDisplayTime != null) {
      _json["initialDisplayTime"] = (initialDisplayTime).toJson();
    }
    return _json;
  }
}

/// Encapsulates the metadata for basic sample series represented by a line
/// chart
class BasicPerfSampleSeries {
  ///
  /// Possible string values are:
  /// - "cpu"
  /// - "graphics"
  /// - "memory"
  /// - "network"
  /// - "perfMetricTypeUnspecified"
  core.String perfMetricType;

  ///
  /// Possible string values are:
  /// - "byte"
  /// - "bytesPerSecond"
  /// - "framesPerSecond"
  /// - "kibibyte"
  /// - "percent"
  /// - "perfUnitUnspecified"
  core.String perfUnit;

  ///
  /// Possible string values are:
  /// - "cpuKernel"
  /// - "cpuTotal"
  /// - "cpuUser"
  /// - "graphicsFrameRate"
  /// - "memoryRssPrivate"
  /// - "memoryRssShared"
  /// - "memoryRssTotal"
  /// - "memoryTotal"
  /// - "networkReceived"
  /// - "networkSent"
  /// - "ntBytesReceived"
  /// - "ntBytesTransferred"
  /// - "sampleSeriesTypeUnspecified"
  core.String sampleSeriesLabel;

  BasicPerfSampleSeries();

  BasicPerfSampleSeries.fromJson(core.Map _json) {
    if (_json.containsKey("perfMetricType")) {
      perfMetricType = _json["perfMetricType"];
    }
    if (_json.containsKey("perfUnit")) {
      perfUnit = _json["perfUnit"];
    }
    if (_json.containsKey("sampleSeriesLabel")) {
      sampleSeriesLabel = _json["sampleSeriesLabel"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (perfMetricType != null) {
      _json["perfMetricType"] = perfMetricType;
    }
    if (perfUnit != null) {
      _json["perfUnit"] = perfUnit;
    }
    if (sampleSeriesLabel != null) {
      _json["sampleSeriesLabel"] = sampleSeriesLabel;
    }
    return _json;
  }
}

/// The request must provide up to a maximum of 5000 samples to be created; a
/// larger sample size will cause an INVALID_ARGUMENT error
class BatchCreatePerfSamplesRequest {
  /// The set of PerfSamples to create should not include existing timestamps
  core.List<PerfSample> perfSamples;

  BatchCreatePerfSamplesRequest();

  BatchCreatePerfSamplesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("perfSamples")) {
      perfSamples = _json["perfSamples"]
          .map((value) => new PerfSample.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (perfSamples != null) {
      _json["perfSamples"] =
          perfSamples.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class BatchCreatePerfSamplesResponse {
  core.List<PerfSample> perfSamples;

  BatchCreatePerfSamplesResponse();

  BatchCreatePerfSamplesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("perfSamples")) {
      perfSamples = _json["perfSamples"]
          .map((value) => new PerfSample.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (perfSamples != null) {
      _json["perfSamples"] =
          perfSamples.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class CPUInfo {
  /// description of the device processor ie '1.8 GHz hexa core 64-bit ARMv8-A'
  core.String cpuProcessor;

  /// the CPU clock speed in GHz
  core.double cpuSpeedInGhz;

  /// the number of CPU cores
  core.int numberOfCores;

  CPUInfo();

  CPUInfo.fromJson(core.Map _json) {
    if (_json.containsKey("cpuProcessor")) {
      cpuProcessor = _json["cpuProcessor"];
    }
    if (_json.containsKey("cpuSpeedInGhz")) {
      cpuSpeedInGhz = _json["cpuSpeedInGhz"];
    }
    if (_json.containsKey("numberOfCores")) {
      numberOfCores = _json["numberOfCores"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (cpuProcessor != null) {
      _json["cpuProcessor"] = cpuProcessor;
    }
    if (cpuSpeedInGhz != null) {
      _json["cpuSpeedInGhz"] = cpuSpeedInGhz;
    }
    if (numberOfCores != null) {
      _json["numberOfCores"] = numberOfCores;
    }
    return _json;
  }
}

/// A Duration represents a signed, fixed-length span of time represented as a
/// count of seconds and fractions of seconds at nanosecond resolution. It is
/// independent of any calendar and concepts like "day" or "month". It is
/// related to Timestamp in that the difference between two Timestamp values is
/// a Duration and it can be added or subtracted from a Timestamp. Range is
/// approximately +-10,000 years.
///
/// # Examples
///
/// Example 1: Compute Duration from two Timestamps in pseudo code.
///
/// Timestamp start = ...; Timestamp end = ...; Duration duration = ...;
///
/// duration.seconds = end.seconds - start.seconds; duration.nanos = end.nanos -
/// start.nanos;
///
/// if (duration.seconds  0) { duration.seconds += 1; duration.nanos -=
/// 1000000000; } else if (durations.seconds > 0 && duration.nanos < 0) {
/// duration.seconds -= 1; duration.nanos += 1000000000; }
///
/// Example 2: Compute Timestamp from Timestamp + Duration in pseudo code.
///
/// Timestamp start = ...; Duration duration = ...; Timestamp end = ...;
///
/// end.seconds = start.seconds + duration.seconds; end.nanos = start.nanos +
/// duration.nanos;
///
/// if (end.nanos = 1000000000) { end.seconds += 1; end.nanos -= 1000000000; }
///
/// Example 3: Compute Duration from datetime.timedelta in Python.
///
/// td = datetime.timedelta(days=3, minutes=10) duration = Duration()
/// duration.FromTimedelta(td)
///
/// # JSON Mapping
///
/// In JSON format, the Duration type is encoded as a string rather than an
/// object, where the string ends in the suffix "s" (indicating seconds) and is
/// preceded by the number of seconds, with nanoseconds expressed as fractional
/// seconds. For example, 3 seconds with 0 nanoseconds should be encoded in JSON
/// format as "3s", while 3 seconds and 1 nanosecond should be expressed in JSON
/// format as "3.000000001s", and 3 seconds and 1 microsecond should be
/// expressed in JSON format as "3.000001s".
class Duration {
  /// Signed fractions of a second at nanosecond resolution of the span of time.
  /// Durations less than one second are represented with a 0 `seconds` field
  /// and a positive or negative `nanos` field. For durations of one second or
  /// more, a non-zero value for the `nanos` field must be of the same sign as
  /// the `seconds` field. Must be from -999,999,999 to +999,999,999 inclusive.
  core.int nanos;

  /// Signed seconds of the span of time. Must be from -315,576,000,000 to
  /// +315,576,000,000 inclusive. Note: these bounds are computed from: 60
  /// sec/min * 60 min/hr * 24 hr/day * 365.25 days/year * 10000 years
  core.String seconds;

  Duration();

  Duration.fromJson(core.Map _json) {
    if (_json.containsKey("nanos")) {
      nanos = _json["nanos"];
    }
    if (_json.containsKey("seconds")) {
      seconds = _json["seconds"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nanos != null) {
      _json["nanos"] = nanos;
    }
    if (seconds != null) {
      _json["seconds"] = seconds;
    }
    return _json;
  }
}

/// An Execution represents a collection of Steps. For instance, it could
/// represent: - a mobile test executed across a range of device configurations
/// - a jenkins job with a build step followed by a test step
///
/// The maximum size of an execution message is 1 MiB.
///
/// An Execution can be updated until its state is set to COMPLETE at which
/// point it becomes immutable.
class Execution {
  /// The time when the Execution status transitioned to COMPLETE.
  ///
  /// This value will be set automatically when state transitions to COMPLETE.
  ///
  /// - In response: set if the execution state is COMPLETE. - In create/update
  /// request: never set
  Timestamp completionTime;

  /// The time when the Execution was created.
  ///
  /// This value will be set automatically when CreateExecution is called.
  ///
  /// - In response: always set - In create/update request: never set
  Timestamp creationTime;

  /// A unique identifier within a History for this Execution.
  ///
  /// Returns INVALID_ARGUMENT if this field is set or overwritten by the
  /// caller.
  ///
  /// - In response always set - In create/update request: never set
  core.String executionId;

  /// Classify the result, for example into SUCCESS or FAILURE
  ///
  /// - In response: present if set by create/update request - In create/update
  /// request: optional
  Outcome outcome;

  /// Lightweight information about execution request.
  ///
  /// - In response: present if set by create - In create: optional - In update:
  /// optional
  Specification specification;

  /// The initial state is IN_PROGRESS.
  ///
  /// The only legal state transitions is from IN_PROGRESS to COMPLETE.
  ///
  /// A PRECONDITION_FAILED will be returned if an invalid transition is
  /// requested.
  ///
  /// The state can only be set to COMPLETE once. A FAILED_PRECONDITION will be
  /// returned if the state is set to COMPLETE multiple times.
  ///
  /// If the state is set to COMPLETE, all the in-progress steps within the
  /// execution will be set as COMPLETE. If the outcome of the step is not set,
  /// the outcome will be set to INCONCLUSIVE.
  ///
  /// - In response always set - In create/update request: optional
  /// Possible string values are:
  /// - "complete"
  /// - "inProgress"
  /// - "pending"
  /// - "unknownState"
  core.String state;

  /// TestExecution Matrix ID that the TestExecutionService uses.
  ///
  /// - In response: present if set by create - In create: optional - In update:
  /// never set
  core.String testExecutionMatrixId;

  Execution();

  Execution.fromJson(core.Map _json) {
    if (_json.containsKey("completionTime")) {
      completionTime = new Timestamp.fromJson(_json["completionTime"]);
    }
    if (_json.containsKey("creationTime")) {
      creationTime = new Timestamp.fromJson(_json["creationTime"]);
    }
    if (_json.containsKey("executionId")) {
      executionId = _json["executionId"];
    }
    if (_json.containsKey("outcome")) {
      outcome = new Outcome.fromJson(_json["outcome"]);
    }
    if (_json.containsKey("specification")) {
      specification = new Specification.fromJson(_json["specification"]);
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("testExecutionMatrixId")) {
      testExecutionMatrixId = _json["testExecutionMatrixId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (completionTime != null) {
      _json["completionTime"] = (completionTime).toJson();
    }
    if (creationTime != null) {
      _json["creationTime"] = (creationTime).toJson();
    }
    if (executionId != null) {
      _json["executionId"] = executionId;
    }
    if (outcome != null) {
      _json["outcome"] = (outcome).toJson();
    }
    if (specification != null) {
      _json["specification"] = (specification).toJson();
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (testExecutionMatrixId != null) {
      _json["testExecutionMatrixId"] = testExecutionMatrixId;
    }
    return _json;
  }
}

class FailureDetail {
  /// If the failure was severe because the system under test crashed.
  core.bool crashed;

  /// If an app is not installed and thus no test can be run with the app. This
  /// might be caused by trying to run a test on an unsupported platform.
  core.bool notInstalled;

  /// If a native process other than the app crashed.
  core.bool otherNativeCrash;

  /// If the test overran some time limit, and that is why it failed.
  core.bool timedOut;

  /// If the robo was unable to crawl the app; perhaps because the app did not
  /// start.
  core.bool unableToCrawl;

  FailureDetail();

  FailureDetail.fromJson(core.Map _json) {
    if (_json.containsKey("crashed")) {
      crashed = _json["crashed"];
    }
    if (_json.containsKey("notInstalled")) {
      notInstalled = _json["notInstalled"];
    }
    if (_json.containsKey("otherNativeCrash")) {
      otherNativeCrash = _json["otherNativeCrash"];
    }
    if (_json.containsKey("timedOut")) {
      timedOut = _json["timedOut"];
    }
    if (_json.containsKey("unableToCrawl")) {
      unableToCrawl = _json["unableToCrawl"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (crashed != null) {
      _json["crashed"] = crashed;
    }
    if (notInstalled != null) {
      _json["notInstalled"] = notInstalled;
    }
    if (otherNativeCrash != null) {
      _json["otherNativeCrash"] = otherNativeCrash;
    }
    if (timedOut != null) {
      _json["timedOut"] = timedOut;
    }
    if (unableToCrawl != null) {
      _json["unableToCrawl"] = unableToCrawl;
    }
    return _json;
  }
}

/// A reference to a file.
class FileReference {
  /// The URI of a file stored in Google Cloud Storage.
  ///
  /// For example: http://storage.googleapis.com/mybucket/path/to/test.xml or in
  /// gsutil format: gs://mybucket/path/to/test.xml with version-specific info,
  /// gs://mybucket/path/to/test.xml#1360383693690000
  ///
  /// An INVALID_ARGUMENT error will be returned if the URI format is not
  /// supported.
  ///
  /// - In response: always set - In create/update request: always set
  core.String fileUri;

  FileReference();

  FileReference.fromJson(core.Map _json) {
    if (_json.containsKey("fileUri")) {
      fileUri = _json["fileUri"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (fileUri != null) {
      _json["fileUri"] = fileUri;
    }
    return _json;
  }
}

/// A History represents a sorted list of Executions ordered by the
/// start_timestamp_millis field (descending). It can be used to group all the
/// Executions of a continuous build.
///
/// Note that the ordering only operates on one-dimension. If a repository has
/// multiple branches, it means that multiple histories will need to be used in
/// order to order Executions per branch.
class History {
  /// A short human-readable (plain text) name to display in the UI. Maximum of
  /// 100 characters.
  ///
  /// - In response: present if set during create. - In create request: optional
  core.String displayName;

  /// A unique identifier within a project for this History.
  ///
  /// Returns INVALID_ARGUMENT if this field is set or overwritten by the
  /// caller.
  ///
  /// - In response always set - In create request: never set
  core.String historyId;

  /// A name to uniquely identify a history within a project. Maximum of 100
  /// characters.
  ///
  /// - In response always set - In create request: always set
  core.String name;

  History();

  History.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("historyId")) {
      historyId = _json["historyId"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (historyId != null) {
      _json["historyId"] = historyId;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/// An image, with a link to the main image and a thumbnail.
class Image {
  /// An error explaining why the thumbnail could not be rendered.
  Status error;

  /// A reference to the full-size, original image.
  ///
  /// This is the same as the tool_outputs entry for the image under its Step.
  ///
  /// Always set.
  ToolOutputReference sourceImage;

  /// The step to which the image is attached.
  ///
  /// Always set.
  core.String stepId;

  /// The thumbnail.
  Thumbnail thumbnail;

  Image();

  Image.fromJson(core.Map _json) {
    if (_json.containsKey("error")) {
      error = new Status.fromJson(_json["error"]);
    }
    if (_json.containsKey("sourceImage")) {
      sourceImage = new ToolOutputReference.fromJson(_json["sourceImage"]);
    }
    if (_json.containsKey("stepId")) {
      stepId = _json["stepId"];
    }
    if (_json.containsKey("thumbnail")) {
      thumbnail = new Thumbnail.fromJson(_json["thumbnail"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (error != null) {
      _json["error"] = (error).toJson();
    }
    if (sourceImage != null) {
      _json["sourceImage"] = (sourceImage).toJson();
    }
    if (stepId != null) {
      _json["stepId"] = stepId;
    }
    if (thumbnail != null) {
      _json["thumbnail"] = (thumbnail).toJson();
    }
    return _json;
  }
}

class InconclusiveDetail {
  /// If the end user aborted the test execution before a pass or fail could be
  /// determined. For example, the user pressed ctrl-c which sent a kill signal
  /// to the test runner while the test was running.
  core.bool abortedByUser;

  /// If the test runner could not determine success or failure because the test
  /// depends on a component other than the system under test which failed.
  ///
  /// For example, a mobile test requires provisioning a device where the test
  /// executes, and that provisioning can fail.
  core.bool infrastructureFailure;

  InconclusiveDetail();

  InconclusiveDetail.fromJson(core.Map _json) {
    if (_json.containsKey("abortedByUser")) {
      abortedByUser = _json["abortedByUser"];
    }
    if (_json.containsKey("infrastructureFailure")) {
      infrastructureFailure = _json["infrastructureFailure"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (abortedByUser != null) {
      _json["abortedByUser"] = abortedByUser;
    }
    if (infrastructureFailure != null) {
      _json["infrastructureFailure"] = infrastructureFailure;
    }
    return _json;
  }
}

class ListExecutionsResponse {
  /// Executions.
  ///
  /// Always set.
  core.List<Execution> executions;

  /// A continuation token to resume the query at the next item.
  ///
  /// Will only be set if there are more Executions to fetch.
  core.String nextPageToken;

  ListExecutionsResponse();

  ListExecutionsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executions")) {
      executions = _json["executions"]
          .map((value) => new Execution.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executions != null) {
      _json["executions"] =
          executions.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response message for HistoryService.List
class ListHistoriesResponse {
  /// Histories.
  core.List<History> histories;

  /// A continuation token to resume the query at the next item.
  ///
  /// Will only be set if there are more histories to fetch.
  ///
  /// Tokens are valid for up to one hour from the time of the first list
  /// request. For instance, if you make a list request at 1PM and use the token
  /// from this first request 10 minutes later, the token from this second
  /// response will only be valid for 50 minutes.
  core.String nextPageToken;

  ListHistoriesResponse();

  ListHistoriesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("histories")) {
      histories = _json["histories"]
          .map((value) => new History.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (histories != null) {
      _json["histories"] = histories.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

class ListPerfSampleSeriesResponse {
  /// The resulting PerfSampleSeries sorted by id
  core.List<PerfSampleSeries> perfSampleSeries;

  ListPerfSampleSeriesResponse();

  ListPerfSampleSeriesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("perfSampleSeries")) {
      perfSampleSeries = _json["perfSampleSeries"]
          .map((value) => new PerfSampleSeries.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (perfSampleSeries != null) {
      _json["perfSampleSeries"] =
          perfSampleSeries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ListPerfSamplesResponse {
  /// Optional, returned if result size exceeds the page size specified in the
  /// request (or the default page size, 500, if unspecified). It indicates the
  /// last sample timestamp to be used as page_token in subsequent request
  core.String nextPageToken;
  core.List<PerfSample> perfSamples;

  ListPerfSamplesResponse();

  ListPerfSamplesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("perfSamples")) {
      perfSamples = _json["perfSamples"]
          .map((value) => new PerfSample.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (perfSamples != null) {
      _json["perfSamples"] =
          perfSamples.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ListScreenshotClustersResponse {
  /// The set of clustres associated with an execution Always set
  core.List<ScreenshotCluster> clusters;

  ListScreenshotClustersResponse();

  ListScreenshotClustersResponse.fromJson(core.Map _json) {
    if (_json.containsKey("clusters")) {
      clusters = _json["clusters"]
          .map((value) => new ScreenshotCluster.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (clusters != null) {
      _json["clusters"] = clusters.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A response containing the thumbnails in a step.
class ListStepThumbnailsResponse {
  /// A continuation token to resume the query at the next item.
  ///
  /// If set, indicates that there are more thumbnails to read, by calling list
  /// again with this value in the page_token field.
  core.String nextPageToken;

  /// A list of image data.
  ///
  /// Images are returned in a deterministic order; they are ordered by these
  /// factors, in order of importance: * First, by their associated test case.
  /// Images without a test case are considered greater than images with one. *
  /// Second, by their creation time. Images without a creation time are greater
  /// than images with one. * Third, by the order in which they were added to
  /// the step (by calls to CreateStep or UpdateStep).
  core.List<Image> thumbnails;

  ListStepThumbnailsResponse();

  ListStepThumbnailsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("thumbnails")) {
      thumbnails = _json["thumbnails"]
          .map((value) => new Image.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (thumbnails != null) {
      _json["thumbnails"] =
          thumbnails.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Response message for StepService.List.
class ListStepsResponse {
  /// A continuation token to resume the query at the next item.
  ///
  /// If set, indicates that there are more steps to read, by calling list again
  /// with this value in the page_token field.
  core.String nextPageToken;

  /// Steps.
  core.List<Step> steps;

  ListStepsResponse();

  ListStepsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("steps")) {
      steps = _json["steps"].map((value) => new Step.fromJson(value)).toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (steps != null) {
      _json["steps"] = steps.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class MemoryInfo {
  /// Maximum memory that can be allocated to the process in KiB
  core.String memoryCapInKibibyte;

  /// Total memory available on the device in KiB
  core.String memoryTotalInKibibyte;

  MemoryInfo();

  MemoryInfo.fromJson(core.Map _json) {
    if (_json.containsKey("memoryCapInKibibyte")) {
      memoryCapInKibibyte = _json["memoryCapInKibibyte"];
    }
    if (_json.containsKey("memoryTotalInKibibyte")) {
      memoryTotalInKibibyte = _json["memoryTotalInKibibyte"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (memoryCapInKibibyte != null) {
      _json["memoryCapInKibibyte"] = memoryCapInKibibyte;
    }
    if (memoryTotalInKibibyte != null) {
      _json["memoryTotalInKibibyte"] = memoryTotalInKibibyte;
    }
    return _json;
  }
}

/// Interprets a result so that humans and machines can act on it.
class Outcome {
  /// More information about a FAILURE outcome.
  ///
  /// Returns INVALID_ARGUMENT if this field is set but the summary is not
  /// FAILURE.
  ///
  /// Optional
  FailureDetail failureDetail;

  /// More information about an INCONCLUSIVE outcome.
  ///
  /// Returns INVALID_ARGUMENT if this field is set but the summary is not
  /// INCONCLUSIVE.
  ///
  /// Optional
  InconclusiveDetail inconclusiveDetail;

  /// More information about a SKIPPED outcome.
  ///
  /// Returns INVALID_ARGUMENT if this field is set but the summary is not
  /// SKIPPED.
  ///
  /// Optional
  SkippedDetail skippedDetail;

  /// More information about a SUCCESS outcome.
  ///
  /// Returns INVALID_ARGUMENT if this field is set but the summary is not
  /// SUCCESS.
  ///
  /// Optional
  SuccessDetail successDetail;

  /// The simplest way to interpret a result.
  ///
  /// Required
  /// Possible string values are:
  /// - "failure"
  /// - "inconclusive"
  /// - "skipped"
  /// - "success"
  /// - "unset"
  core.String summary;

  Outcome();

  Outcome.fromJson(core.Map _json) {
    if (_json.containsKey("failureDetail")) {
      failureDetail = new FailureDetail.fromJson(_json["failureDetail"]);
    }
    if (_json.containsKey("inconclusiveDetail")) {
      inconclusiveDetail =
          new InconclusiveDetail.fromJson(_json["inconclusiveDetail"]);
    }
    if (_json.containsKey("skippedDetail")) {
      skippedDetail = new SkippedDetail.fromJson(_json["skippedDetail"]);
    }
    if (_json.containsKey("successDetail")) {
      successDetail = new SuccessDetail.fromJson(_json["successDetail"]);
    }
    if (_json.containsKey("summary")) {
      summary = _json["summary"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (failureDetail != null) {
      _json["failureDetail"] = (failureDetail).toJson();
    }
    if (inconclusiveDetail != null) {
      _json["inconclusiveDetail"] = (inconclusiveDetail).toJson();
    }
    if (skippedDetail != null) {
      _json["skippedDetail"] = (skippedDetail).toJson();
    }
    if (successDetail != null) {
      _json["successDetail"] = (successDetail).toJson();
    }
    if (summary != null) {
      _json["summary"] = summary;
    }
    return _json;
  }
}

/// Encapsulates performance environment info
class PerfEnvironment {
  /// CPU related environment info
  CPUInfo cpuInfo;

  /// Memory related environment info
  MemoryInfo memoryInfo;

  PerfEnvironment();

  PerfEnvironment.fromJson(core.Map _json) {
    if (_json.containsKey("cpuInfo")) {
      cpuInfo = new CPUInfo.fromJson(_json["cpuInfo"]);
    }
    if (_json.containsKey("memoryInfo")) {
      memoryInfo = new MemoryInfo.fromJson(_json["memoryInfo"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (cpuInfo != null) {
      _json["cpuInfo"] = (cpuInfo).toJson();
    }
    if (memoryInfo != null) {
      _json["memoryInfo"] = (memoryInfo).toJson();
    }
    return _json;
  }
}

/// A summary of perf metrics collected and performance environment info
class PerfMetricsSummary {
  AppStartTime appStartTime;

  /// A tool results execution ID.
  core.String executionId;

  /// A tool results history ID.
  core.String historyId;

  /// Describes the environment in which the performance metrics were collected
  PerfEnvironment perfEnvironment;

  /// Set of resource collected
  core.List<core.String> perfMetrics;

  /// The cloud project
  core.String projectId;

  /// A tool results step ID.
  core.String stepId;

  PerfMetricsSummary();

  PerfMetricsSummary.fromJson(core.Map _json) {
    if (_json.containsKey("appStartTime")) {
      appStartTime = new AppStartTime.fromJson(_json["appStartTime"]);
    }
    if (_json.containsKey("executionId")) {
      executionId = _json["executionId"];
    }
    if (_json.containsKey("historyId")) {
      historyId = _json["historyId"];
    }
    if (_json.containsKey("perfEnvironment")) {
      perfEnvironment = new PerfEnvironment.fromJson(_json["perfEnvironment"]);
    }
    if (_json.containsKey("perfMetrics")) {
      perfMetrics = _json["perfMetrics"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("stepId")) {
      stepId = _json["stepId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (appStartTime != null) {
      _json["appStartTime"] = (appStartTime).toJson();
    }
    if (executionId != null) {
      _json["executionId"] = executionId;
    }
    if (historyId != null) {
      _json["historyId"] = historyId;
    }
    if (perfEnvironment != null) {
      _json["perfEnvironment"] = (perfEnvironment).toJson();
    }
    if (perfMetrics != null) {
      _json["perfMetrics"] = perfMetrics;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (stepId != null) {
      _json["stepId"] = stepId;
    }
    return _json;
  }
}

/// Resource representing a single performance measure or data point
class PerfSample {
  /// Timestamp of collection
  Timestamp sampleTime;

  /// Value observed
  core.double value;

  PerfSample();

  PerfSample.fromJson(core.Map _json) {
    if (_json.containsKey("sampleTime")) {
      sampleTime = new Timestamp.fromJson(_json["sampleTime"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (sampleTime != null) {
      _json["sampleTime"] = (sampleTime).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/// Resource representing a collection of performance samples (or data points)
class PerfSampleSeries {
  /// Basic series represented by a line chart
  BasicPerfSampleSeries basicPerfSampleSeries;

  /// A tool results execution ID.
  core.String executionId;

  /// A tool results history ID.
  core.String historyId;

  /// The cloud project
  core.String projectId;

  /// A sample series id
  core.String sampleSeriesId;

  /// A tool results step ID.
  core.String stepId;

  PerfSampleSeries();

  PerfSampleSeries.fromJson(core.Map _json) {
    if (_json.containsKey("basicPerfSampleSeries")) {
      basicPerfSampleSeries =
          new BasicPerfSampleSeries.fromJson(_json["basicPerfSampleSeries"]);
    }
    if (_json.containsKey("executionId")) {
      executionId = _json["executionId"];
    }
    if (_json.containsKey("historyId")) {
      historyId = _json["historyId"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("sampleSeriesId")) {
      sampleSeriesId = _json["sampleSeriesId"];
    }
    if (_json.containsKey("stepId")) {
      stepId = _json["stepId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (basicPerfSampleSeries != null) {
      _json["basicPerfSampleSeries"] = (basicPerfSampleSeries).toJson();
    }
    if (executionId != null) {
      _json["executionId"] = executionId;
    }
    if (historyId != null) {
      _json["historyId"] = historyId;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (sampleSeriesId != null) {
      _json["sampleSeriesId"] = sampleSeriesId;
    }
    if (stepId != null) {
      _json["stepId"] = stepId;
    }
    return _json;
  }
}

/// Per-project settings for the Tool Results service.
class ProjectSettings {
  /// The name of the Google Cloud Storage bucket to which results are written.
  ///
  /// By default, this is unset.
  ///
  /// In update request: optional In response: optional
  core.String defaultBucket;

  /// The name of the project's settings.
  ///
  /// Always of the form: projects/{project-id}/settings
  ///
  /// In update request: never set In response: always set
  core.String name;

  ProjectSettings();

  ProjectSettings.fromJson(core.Map _json) {
    if (_json.containsKey("defaultBucket")) {
      defaultBucket = _json["defaultBucket"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (defaultBucket != null) {
      _json["defaultBucket"] = defaultBucket;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/// Request message for StepService.PublishXunitXmlFiles.
class PublishXunitXmlFilesRequest {
  /// URI of the Xunit XML files to publish.
  ///
  /// The maximum size of the file this reference is pointing to is 50MB.
  ///
  /// Required.
  core.List<FileReference> xunitXmlFiles;

  PublishXunitXmlFilesRequest();

  PublishXunitXmlFilesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("xunitXmlFiles")) {
      xunitXmlFiles = _json["xunitXmlFiles"]
          .map((value) => new FileReference.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (xunitXmlFiles != null) {
      _json["xunitXmlFiles"] =
          xunitXmlFiles.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Screen {
  /// File reference of the png file. Required.
  core.String fileReference;

  /// Locale of the device that the screenshot was taken on. Required.
  core.String locale;

  /// Model of the device that the screenshot was taken on. Required.
  core.String model;

  /// OS version of the device that the screenshot was taken on. Required.
  core.String version;

  Screen();

  Screen.fromJson(core.Map _json) {
    if (_json.containsKey("fileReference")) {
      fileReference = _json["fileReference"];
    }
    if (_json.containsKey("locale")) {
      locale = _json["locale"];
    }
    if (_json.containsKey("model")) {
      model = _json["model"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (fileReference != null) {
      _json["fileReference"] = fileReference;
    }
    if (locale != null) {
      _json["locale"] = locale;
    }
    if (model != null) {
      _json["model"] = model;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

class ScreenshotCluster {
  /// A string that describes the activity of every screen in the cluster.
  core.String activity;

  /// A unique identifier for the cluster.
  core.String clusterId;

  /// A singular screen that represents the cluster as a whole. This screen will
  /// act as the "cover" of the entire cluster. When users look at the clusters,
  /// only the key screen from each cluster will be shown. Which screen is the
  /// key screen is determined by the ClusteringAlgorithm
  Screen keyScreen;

  /// Full list of screens.
  core.List<Screen> screens;

  ScreenshotCluster();

  ScreenshotCluster.fromJson(core.Map _json) {
    if (_json.containsKey("activity")) {
      activity = _json["activity"];
    }
    if (_json.containsKey("clusterId")) {
      clusterId = _json["clusterId"];
    }
    if (_json.containsKey("keyScreen")) {
      keyScreen = new Screen.fromJson(_json["keyScreen"]);
    }
    if (_json.containsKey("screens")) {
      screens =
          _json["screens"].map((value) => new Screen.fromJson(value)).toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (activity != null) {
      _json["activity"] = activity;
    }
    if (clusterId != null) {
      _json["clusterId"] = clusterId;
    }
    if (keyScreen != null) {
      _json["keyScreen"] = (keyScreen).toJson();
    }
    if (screens != null) {
      _json["screens"] = screens.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class SkippedDetail {
  /// If the App doesn't support the specific API level.
  core.bool incompatibleAppVersion;

  /// If the App doesn't run on the specific architecture, for example, x86.
  core.bool incompatibleArchitecture;

  /// If the requested OS version doesn't run on the specific device model.
  core.bool incompatibleDevice;

  SkippedDetail();

  SkippedDetail.fromJson(core.Map _json) {
    if (_json.containsKey("incompatibleAppVersion")) {
      incompatibleAppVersion = _json["incompatibleAppVersion"];
    }
    if (_json.containsKey("incompatibleArchitecture")) {
      incompatibleArchitecture = _json["incompatibleArchitecture"];
    }
    if (_json.containsKey("incompatibleDevice")) {
      incompatibleDevice = _json["incompatibleDevice"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (incompatibleAppVersion != null) {
      _json["incompatibleAppVersion"] = incompatibleAppVersion;
    }
    if (incompatibleArchitecture != null) {
      _json["incompatibleArchitecture"] = incompatibleArchitecture;
    }
    if (incompatibleDevice != null) {
      _json["incompatibleDevice"] = incompatibleDevice;
    }
    return _json;
  }
}

/// The details about how to run the execution.
class Specification {
  /// An Android mobile test execution specification.
  AndroidTest androidTest;

  Specification();

  Specification.fromJson(core.Map _json) {
    if (_json.containsKey("androidTest")) {
      androidTest = new AndroidTest.fromJson(_json["androidTest"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (androidTest != null) {
      _json["androidTest"] = (androidTest).toJson();
    }
    return _json;
  }
}

/// A stacktrace.
class StackTrace {
  /// Exception cluster ID
  core.String clusterId;

  /// The stack trace message.
  ///
  /// Required
  core.String exception;

  /// Exception report ID
  core.String reportId;

  StackTrace();

  StackTrace.fromJson(core.Map _json) {
    if (_json.containsKey("clusterId")) {
      clusterId = _json["clusterId"];
    }
    if (_json.containsKey("exception")) {
      exception = _json["exception"];
    }
    if (_json.containsKey("reportId")) {
      reportId = _json["reportId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (clusterId != null) {
      _json["clusterId"] = clusterId;
    }
    if (exception != null) {
      _json["exception"] = exception;
    }
    if (reportId != null) {
      _json["reportId"] = reportId;
    }
    return _json;
  }
}

/// The `Status` type defines a logical error model that is suitable for
/// different programming environments, including REST APIs and RPC APIs. It is
/// used by [gRPC](https://github.com/grpc). The error model is designed to be:
///
/// - Simple to use and understand for most users - Flexible enough to meet
/// unexpected needs
///
/// # Overview
///
/// The `Status` message contains three pieces of data: error code, error
/// message, and error details. The error code should be an enum value of
/// [google.rpc.Code][], but it may accept additional error codes if needed. The
/// error message should be a developer-facing English message that helps
/// developers *understand* and *resolve* the error. If a localized user-facing
/// error message is needed, put the localized message in the error details or
/// localize it in the client. The optional error details may contain arbitrary
/// information about the error. There is a predefined set of error detail types
/// in the package `google.rpc` that can be used for common error conditions.
///
/// # Language mapping
///
/// The `Status` message is the logical representation of the error model, but
/// it is not necessarily the actual wire format. When the `Status` message is
/// exposed in different client libraries and different wire protocols, it can
/// be mapped differently. For example, it will likely be mapped to some
/// exceptions in Java, but more likely mapped to some error codes in C.
///
/// # Other uses
///
/// The error model and the `Status` message can be used in a variety of
/// environments, either with or without APIs, to provide a consistent developer
/// experience across different environments.
///
/// Example uses of this error model include:
///
/// - Partial errors. If a service needs to return partial errors to the client,
/// it may embed the `Status` in the normal response to indicate the partial
/// errors.
///
/// - Workflow errors. A typical workflow has multiple steps. Each step may have
/// a `Status` message for error reporting.
///
/// - Batch operations. If a client uses batch request and batch response, the
/// `Status` message should be used directly inside batch response, one for each
/// error sub-response.
///
/// - Asynchronous operations. If an API call embeds asynchronous operation
/// results in its response, the status of those operations should be
/// represented directly using the `Status` message.
///
/// - Logging. If some API errors are stored in logs, the message `Status` could
/// be used directly after any stripping needed for security/privacy reasons.
class Status {
  /// The status code, which should be an enum value of [google.rpc.Code][].
  core.int code;

  /// A list of messages that carry the error details. There is a common set of
  /// message types for APIs to use.
  core.List<Any> details;

  /// A developer-facing error message, which should be in English. Any
  /// user-facing error message should be localized and sent in the
  /// [google.rpc.Status.details][] field, or localized by the client.
  core.String message;

  Status();

  Status.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("details")) {
      details =
          _json["details"].map((value) => new Any.fromJson(value)).toList();
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
    if (details != null) {
      _json["details"] = details.map((value) => (value).toJson()).toList();
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

/// A Step represents a single operation performed as part of Execution. A step
/// can be used to represent the execution of a tool ( for example a test runner
/// execution or an execution of a compiler).
///
/// Steps can overlap (for instance two steps might have the same start time if
/// some operations are done in parallel).
///
/// Here is an example, let's consider that we have a continuous build is
/// executing a test runner for each iteration. The workflow would look like: -
/// user creates a Execution with id 1 - user creates an TestExecutionStep with
/// id 100 for Execution 1 - user update TestExecutionStep with id 100 to add a
/// raw xml log + the service parses the xml logs and returns a
/// TestExecutionStep with updated TestResult(s). - user update the status of
/// TestExecutionStep with id 100 to COMPLETE
///
/// A Step can be updated until its state is set to COMPLETE at which points it
/// becomes immutable.
class Step {
  /// The time when the step status was set to complete.
  ///
  /// This value will be set automatically when state transitions to COMPLETE.
  ///
  /// - In response: set if the execution state is COMPLETE. - In create/update
  /// request: never set
  Timestamp completionTime;

  /// The time when the step was created.
  ///
  /// - In response: always set - In create/update request: never set
  Timestamp creationTime;

  /// A description of this tool For example: mvn clean package -D
  /// skipTests=true
  ///
  /// - In response: present if set by create/update request - In create/update
  /// request: optional
  core.String description;

  /// How much the device resource is used to perform the test.
  ///
  /// This is the device usage used for billing purpose, which is different from
  /// the run_duration, for example, infrastructure failure won't be charged for
  /// device usage.
  ///
  /// PRECONDITION_FAILED will be returned if one attempts to set a device_usage
  /// on a step which already has this field set.
  ///
  /// - In response: present if previously set. - In create request: optional -
  /// In update request: optional
  Duration deviceUsageDuration;

  /// If the execution containing this step has any dimension_definition set,
  /// then this field allows the child to specify the values of the dimensions.
  ///
  /// The keys must exactly match the dimension_definition of the execution.
  ///
  /// For example, if the execution has `dimension_definition = ['attempt',
  /// 'device']` then a step must define values for those dimensions, eg.
  /// `dimension_value = ['attempt': '1', 'device': 'Nexus 6']`
  ///
  /// If a step does not participate in one dimension of the matrix, the value
  /// for that dimension should be empty string. For example, if one of the
  /// tests is executed by a runner which does not support retries, the step
  /// could have `dimension_value = ['attempt': '', 'device': 'Nexus 6']`
  ///
  /// If the step does not participate in any dimensions of the matrix, it may
  /// leave dimension_value unset.
  ///
  /// A PRECONDITION_FAILED will be returned if any of the keys do not exist in
  /// the dimension_definition of the execution.
  ///
  /// A PRECONDITION_FAILED will be returned if another step in this execution
  /// already has the same name and dimension_value, but differs on other data
  /// fields, for example, step field is different.
  ///
  /// A PRECONDITION_FAILED will be returned if dimension_value is set, and
  /// there is a dimension_definition in the execution which is not specified as
  /// one of the keys.
  ///
  /// - In response: present if set by create - In create request: optional - In
  /// update request: never set
  core.List<StepDimensionValueEntry> dimensionValue;

  /// Whether any of the outputs of this step are images whose thumbnails can be
  /// fetched with ListThumbnails.
  ///
  /// - In response: always set - In create/update request: never set
  core.bool hasImages;

  /// Arbitrary user-supplied key/value pairs that are associated with the step.
  ///
  /// Users are responsible for managing the key namespace such that keys don't
  /// accidentally collide.
  ///
  /// An INVALID_ARGUMENT will be returned if the number of labels exceeds 100
  /// or if the length of any of the keys or values exceeds 100 characters.
  ///
  /// - In response: always set - In create request: optional - In update
  /// request: optional; any new key/value pair will be added to the map, and
  /// any new value for an existing key will update that key's value
  core.List<StepLabelsEntry> labels;

  /// A short human-readable name to display in the UI. Maximum of 100
  /// characters. For example: Clean build
  ///
  /// A PRECONDITION_FAILED will be returned upon creating a new step if it
  /// shares its name and dimension_value with an existing step. If two steps
  /// represent a similar action, but have different dimension values, they
  /// should share the same name. For instance, if the same set of tests is run
  /// on two different platforms, the two steps should have the same name.
  ///
  /// - In response: always set - In create request: always set - In update
  /// request: never set
  core.String name;

  /// Classification of the result, for example into SUCCESS or FAILURE
  ///
  /// - In response: present if set by create/update request - In create/update
  /// request: optional
  Outcome outcome;

  /// How long it took for this step to run.
  ///
  /// If unset, this is set to the difference between creation_time and
  /// completion_time when the step is set to the COMPLETE state. In some cases,
  /// it is appropriate to set this value separately: For instance, if a step is
  /// created, but the operation it represents is queued for a few minutes
  /// before it executes, it would be appropriate not to include the time spent
  /// queued in its run_duration.
  ///
  /// PRECONDITION_FAILED will be returned if one attempts to set a run_duration
  /// on a step which already has this field set.
  ///
  /// - In response: present if previously set; always present on COMPLETE step
  /// - In create request: optional - In update request: optional
  Duration runDuration;

  /// The initial state is IN_PROGRESS. The only legal state transitions are *
  /// IN_PROGRESS -> COMPLETE
  ///
  /// A PRECONDITION_FAILED will be returned if an invalid transition is
  /// requested.
  ///
  /// It is valid to create Step with a state set to COMPLETE. The state can
  /// only be set to COMPLETE once. A PRECONDITION_FAILED will be returned if
  /// the state is set to COMPLETE multiple times.
  ///
  /// - In response: always set - In create/update request: optional
  /// Possible string values are:
  /// - "complete"
  /// - "inProgress"
  /// - "pending"
  /// - "unknownState"
  core.String state;

  /// A unique identifier within a Execution for this Step.
  ///
  /// Returns INVALID_ARGUMENT if this field is set or overwritten by the
  /// caller.
  ///
  /// - In response: always set - In create/update request: never set
  core.String stepId;

  /// An execution of a test runner.
  TestExecutionStep testExecutionStep;

  /// An execution of a tool (used for steps we don't explicitly support).
  ToolExecutionStep toolExecutionStep;

  Step();

  Step.fromJson(core.Map _json) {
    if (_json.containsKey("completionTime")) {
      completionTime = new Timestamp.fromJson(_json["completionTime"]);
    }
    if (_json.containsKey("creationTime")) {
      creationTime = new Timestamp.fromJson(_json["creationTime"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("deviceUsageDuration")) {
      deviceUsageDuration = new Duration.fromJson(_json["deviceUsageDuration"]);
    }
    if (_json.containsKey("dimensionValue")) {
      dimensionValue = _json["dimensionValue"]
          .map((value) => new StepDimensionValueEntry.fromJson(value))
          .toList();
    }
    if (_json.containsKey("hasImages")) {
      hasImages = _json["hasImages"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"]
          .map((value) => new StepLabelsEntry.fromJson(value))
          .toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("outcome")) {
      outcome = new Outcome.fromJson(_json["outcome"]);
    }
    if (_json.containsKey("runDuration")) {
      runDuration = new Duration.fromJson(_json["runDuration"]);
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("stepId")) {
      stepId = _json["stepId"];
    }
    if (_json.containsKey("testExecutionStep")) {
      testExecutionStep =
          new TestExecutionStep.fromJson(_json["testExecutionStep"]);
    }
    if (_json.containsKey("toolExecutionStep")) {
      toolExecutionStep =
          new ToolExecutionStep.fromJson(_json["toolExecutionStep"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (completionTime != null) {
      _json["completionTime"] = (completionTime).toJson();
    }
    if (creationTime != null) {
      _json["creationTime"] = (creationTime).toJson();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (deviceUsageDuration != null) {
      _json["deviceUsageDuration"] = (deviceUsageDuration).toJson();
    }
    if (dimensionValue != null) {
      _json["dimensionValue"] =
          dimensionValue.map((value) => (value).toJson()).toList();
    }
    if (hasImages != null) {
      _json["hasImages"] = hasImages;
    }
    if (labels != null) {
      _json["labels"] = labels.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (outcome != null) {
      _json["outcome"] = (outcome).toJson();
    }
    if (runDuration != null) {
      _json["runDuration"] = (runDuration).toJson();
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (stepId != null) {
      _json["stepId"] = stepId;
    }
    if (testExecutionStep != null) {
      _json["testExecutionStep"] = (testExecutionStep).toJson();
    }
    if (toolExecutionStep != null) {
      _json["toolExecutionStep"] = (toolExecutionStep).toJson();
    }
    return _json;
  }
}

class StepDimensionValueEntry {
  core.String key;
  core.String value;

  StepDimensionValueEntry();

  StepDimensionValueEntry.fromJson(core.Map _json) {
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

class StepLabelsEntry {
  core.String key;
  core.String value;

  StepLabelsEntry();

  StepLabelsEntry.fromJson(core.Map _json) {
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

class SuccessDetail {
  /// If a native process other than the app crashed.
  core.bool otherNativeCrash;

  SuccessDetail();

  SuccessDetail.fromJson(core.Map _json) {
    if (_json.containsKey("otherNativeCrash")) {
      otherNativeCrash = _json["otherNativeCrash"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (otherNativeCrash != null) {
      _json["otherNativeCrash"] = otherNativeCrash;
    }
    return _json;
  }
}

/// A reference to a test case.
///
/// Test case references are canonically ordered lexicographically by these
/// three factors: * First, by test_suite_name. * Second, by class_name. *
/// Third, by name.
class TestCaseReference {
  /// The name of the class.
  core.String className;

  /// The name of the test case.
  ///
  /// Required.
  core.String name;

  /// The name of the test suite to which this test case belongs.
  core.String testSuiteName;

  TestCaseReference();

  TestCaseReference.fromJson(core.Map _json) {
    if (_json.containsKey("className")) {
      className = _json["className"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("testSuiteName")) {
      testSuiteName = _json["testSuiteName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (className != null) {
      _json["className"] = className;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (testSuiteName != null) {
      _json["testSuiteName"] = testSuiteName;
    }
    return _json;
  }
}

/// A step that represents running tests.
///
/// It accepts ant-junit xml files which will be parsed into structured test
/// results by the service. Xml file paths are updated in order to append more
/// files, however they can't be deleted.
///
/// Users can also add test results manually by using the test_result field.
class TestExecutionStep {
  /// Issues observed during the test execution.
  ///
  /// For example, if the mobile app under test crashed during the test, the
  /// error message and the stack trace content can be recorded here to assist
  /// debugging.
  ///
  /// - In response: present if set by create or update - In create/update
  /// request: optional
  core.List<TestIssue> testIssues;

  /// List of test suite overview contents. This could be parsed from xUnit XML
  /// log by server, or uploaded directly by user. This references should only
  /// be called when test suites are fully parsed or uploaded.
  ///
  /// The maximum allowed number of test suite overviews per step is 1000.
  ///
  /// - In response: always set - In create request: optional - In update
  /// request: never (use publishXunitXmlFiles custom method instead)
  core.List<TestSuiteOverview> testSuiteOverviews;

  /// The timing break down of the test execution.
  ///
  /// - In response: present if set by create or update - In create/update
  /// request: optional
  TestTiming testTiming;

  /// Represents the execution of the test runner.
  ///
  /// The exit code of this tool will be used to determine if the test passed.
  ///
  /// - In response: always set - In create/update request: optional
  ToolExecution toolExecution;

  TestExecutionStep();

  TestExecutionStep.fromJson(core.Map _json) {
    if (_json.containsKey("testIssues")) {
      testIssues = _json["testIssues"]
          .map((value) => new TestIssue.fromJson(value))
          .toList();
    }
    if (_json.containsKey("testSuiteOverviews")) {
      testSuiteOverviews = _json["testSuiteOverviews"]
          .map((value) => new TestSuiteOverview.fromJson(value))
          .toList();
    }
    if (_json.containsKey("testTiming")) {
      testTiming = new TestTiming.fromJson(_json["testTiming"]);
    }
    if (_json.containsKey("toolExecution")) {
      toolExecution = new ToolExecution.fromJson(_json["toolExecution"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (testIssues != null) {
      _json["testIssues"] =
          testIssues.map((value) => (value).toJson()).toList();
    }
    if (testSuiteOverviews != null) {
      _json["testSuiteOverviews"] =
          testSuiteOverviews.map((value) => (value).toJson()).toList();
    }
    if (testTiming != null) {
      _json["testTiming"] = (testTiming).toJson();
    }
    if (toolExecution != null) {
      _json["toolExecution"] = (toolExecution).toJson();
    }
    return _json;
  }
}

/// An issue detected occurring during a test execution.
class TestIssue {
  /// A brief human-readable message describing the issue. Required.
  core.String errorMessage;

  /// Severity of issue. Required.
  /// Possible string values are:
  /// - "info"
  /// - "severe"
  /// - "unspecifiedSeverity"
  /// - "warning"
  core.String severity;

  /// Deprecated in favor of stack trace fields inside specific warnings.
  StackTrace stackTrace;

  /// Type of issue. Required.
  /// Possible string values are:
  /// - "anr"
  /// - "fatalException"
  /// - "nativeCrash"
  /// - "unspecifiedType"
  core.String type;

  /// Warning message with additional details of the issue. Should always be a
  /// message from com.google.devtools.toolresults.v1.warnings Required.
  Any warning;

  TestIssue();

  TestIssue.fromJson(core.Map _json) {
    if (_json.containsKey("errorMessage")) {
      errorMessage = _json["errorMessage"];
    }
    if (_json.containsKey("severity")) {
      severity = _json["severity"];
    }
    if (_json.containsKey("stackTrace")) {
      stackTrace = new StackTrace.fromJson(_json["stackTrace"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("warning")) {
      warning = new Any.fromJson(_json["warning"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (errorMessage != null) {
      _json["errorMessage"] = errorMessage;
    }
    if (severity != null) {
      _json["severity"] = severity;
    }
    if (stackTrace != null) {
      _json["stackTrace"] = (stackTrace).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (warning != null) {
      _json["warning"] = (warning).toJson();
    }
    return _json;
  }
}

/// A summary of a test suite result either parsed from XML or uploaded directly
/// by a user.
///
/// Note: the API related comments are for StepService only. This message is
/// also being used in ExecutionService in a read only mode for the
/// corresponding step.
class TestSuiteOverview {
  /// Number of test cases in error, typically set by the service by parsing the
  /// xml_source.
  ///
  /// - In create/response: always set - In update request: never
  core.int errorCount;

  /// Number of failed test cases, typically set by the service by parsing the
  /// xml_source. May also be set by the user.
  ///
  /// - In create/response: always set - In update request: never
  core.int failureCount;

  /// The name of the test suite.
  ///
  /// - In create/response: always set - In update request: never
  core.String name;

  /// Number of test cases not run, typically set by the service by parsing the
  /// xml_source.
  ///
  /// - In create/response: always set - In update request: never
  core.int skippedCount;

  /// Number of test cases, typically set by the service by parsing the
  /// xml_source.
  ///
  /// - In create/response: always set - In update request: never
  core.int totalCount;

  /// If this test suite was parsed from XML, this is the URI where the original
  /// XML file is stored.
  ///
  /// Note: Multiple test suites can share the same xml_source
  ///
  /// Returns INVALID_ARGUMENT if the uri format is not supported.
  ///
  /// - In create/response: optional - In update request: never
  FileReference xmlSource;

  TestSuiteOverview();

  TestSuiteOverview.fromJson(core.Map _json) {
    if (_json.containsKey("errorCount")) {
      errorCount = _json["errorCount"];
    }
    if (_json.containsKey("failureCount")) {
      failureCount = _json["failureCount"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("skippedCount")) {
      skippedCount = _json["skippedCount"];
    }
    if (_json.containsKey("totalCount")) {
      totalCount = _json["totalCount"];
    }
    if (_json.containsKey("xmlSource")) {
      xmlSource = new FileReference.fromJson(_json["xmlSource"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (errorCount != null) {
      _json["errorCount"] = errorCount;
    }
    if (failureCount != null) {
      _json["failureCount"] = failureCount;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (skippedCount != null) {
      _json["skippedCount"] = skippedCount;
    }
    if (totalCount != null) {
      _json["totalCount"] = totalCount;
    }
    if (xmlSource != null) {
      _json["xmlSource"] = (xmlSource).toJson();
    }
    return _json;
  }
}

/// Testing timing break down to know phases.
class TestTiming {
  /// How long it took to run the test process.
  ///
  /// - In response: present if previously set. - In create/update request:
  /// optional
  Duration testProcessDuration;

  TestTiming();

  TestTiming.fromJson(core.Map _json) {
    if (_json.containsKey("testProcessDuration")) {
      testProcessDuration = new Duration.fromJson(_json["testProcessDuration"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (testProcessDuration != null) {
      _json["testProcessDuration"] = (testProcessDuration).toJson();
    }
    return _json;
  }
}

/// A single thumbnail, with its size and format.
class Thumbnail {
  /// The thumbnail's content type, i.e. "image/png".
  ///
  /// Always set.
  core.String contentType;

  /// The thumbnail file itself.
  ///
  /// That is, the bytes here are precisely the bytes that make up the thumbnail
  /// file; they can be served as an image as-is (with the appropriate content
  /// type.)
  ///
  /// Always set.
  core.String data;
  core.List<core.int> get dataAsBytes {
    return convert.BASE64.decode(data);
  }

  void set dataAsBytes(core.List<core.int> _bytes) {
    data =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// The height of the thumbnail, in pixels.
  ///
  /// Always set.
  core.int heightPx;

  /// The width of the thumbnail, in pixels.
  ///
  /// Always set.
  core.int widthPx;

  Thumbnail();

  Thumbnail.fromJson(core.Map _json) {
    if (_json.containsKey("contentType")) {
      contentType = _json["contentType"];
    }
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("heightPx")) {
      heightPx = _json["heightPx"];
    }
    if (_json.containsKey("widthPx")) {
      widthPx = _json["widthPx"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (contentType != null) {
      _json["contentType"] = contentType;
    }
    if (data != null) {
      _json["data"] = data;
    }
    if (heightPx != null) {
      _json["heightPx"] = heightPx;
    }
    if (widthPx != null) {
      _json["widthPx"] = widthPx;
    }
    return _json;
  }
}

/// A Timestamp represents a point in time independent of any time zone or
/// calendar, represented as seconds and fractions of seconds at nanosecond
/// resolution in UTC Epoch time. It is encoded using the Proleptic Gregorian
/// Calendar which extends the Gregorian calendar backwards to year one. It is
/// encoded assuming all minutes are 60 seconds long, i.e. leap seconds are
/// "smeared" so that no leap second table is needed for interpretation. Range
/// is from 0001-01-01T00:00:00Z to 9999-12-31T23:59:59.999999999Z. By
/// restricting to that range, we ensure that we can convert to and from RFC
/// 3339 date strings. See
/// [https://www.ietf.org/rfc/rfc3339.txt](https://www.ietf.org/rfc/rfc3339.txt).
///
/// # Examples
///
/// Example 1: Compute Timestamp from POSIX `time()`.
///
/// Timestamp timestamp; timestamp.set_seconds(time(NULL));
/// timestamp.set_nanos(0);
///
/// Example 2: Compute Timestamp from POSIX `gettimeofday()`.
///
/// struct timeval tv; gettimeofday(&tv, NULL);
///
/// Timestamp timestamp; timestamp.set_seconds(tv.tv_sec);
/// timestamp.set_nanos(tv.tv_usec * 1000);
///
/// Example 3: Compute Timestamp from Win32 `GetSystemTimeAsFileTime()`.
///
/// FILETIME ft; GetSystemTimeAsFileTime(&ft); UINT64 ticks =
/// (((UINT64)ft.dwHighDateTime) << 32) | ft.dwLowDateTime;
///
/// // A Windows tick is 100 nanoseconds. Windows epoch 1601-01-01T00:00:00Z //
/// is 11644473600 seconds before Unix epoch 1970-01-01T00:00:00Z. Timestamp
/// timestamp; timestamp.set_seconds((INT64) ((ticks / 10000000) -
/// 11644473600LL)); timestamp.set_nanos((INT32) ((ticks % 10000000) * 100));
///
/// Example 4: Compute Timestamp from Java `System.currentTimeMillis()`.
///
/// long millis = System.currentTimeMillis();
///
/// Timestamp timestamp = Timestamp.newBuilder().setSeconds(millis / 1000)
/// .setNanos((int) ((millis % 1000) * 1000000)).build();
///
///
///
/// Example 5: Compute Timestamp from current time in Python.
///
/// timestamp = Timestamp() timestamp.GetCurrentTime()
///
/// # JSON Mapping
///
/// In JSON format, the Timestamp type is encoded as a string in the [RFC
/// 3339](https://www.ietf.org/rfc/rfc3339.txt) format. That is, the format is
/// "{year}-{month}-{day}T{hour}:{min}:{sec}[.{frac_sec}]Z" where {year} is
/// always expressed using four digits while {month}, {day}, {hour}, {min}, and
/// {sec} are zero-padded to two digits each. The fractional seconds, which can
/// go up to 9 digits (i.e. up to 1 nanosecond resolution), are optional. The
/// "Z" suffix indicates the timezone ("UTC"); the timezone is required, though
/// only UTC (as indicated by "Z") is presently supported.
///
/// For example, "2017-01-15T01:30:15.01Z" encodes 15.01 seconds past 01:30 UTC
/// on January 15, 2017.
///
/// In JavaScript, one can convert a Date object to this format using the
/// standard
/// [toISOString()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toISOString]
/// method. In Python, a standard `datetime.datetime` object can be converted to
/// this format using
/// [`strftime`](https://docs.python.org/2/library/time.html#time.strftime) with
/// the time format spec '%Y-%m-%dT%H:%M:%S.%fZ'. Likewise, in Java, one can use
/// the Joda Time's [`ISODateTimeFormat.dateTime()`](
/// http://joda-time.sourceforge.net/apidocs/org/joda/time/format/ISODateTimeFormat.html#dateTime())
/// to obtain a formatter capable of generating timestamps in this format.
class Timestamp {
  /// Non-negative fractions of a second at nanosecond resolution. Negative
  /// second values with fractions must still have non-negative nanos values
  /// that count forward in time. Must be from 0 to 999,999,999 inclusive.
  core.int nanos;

  /// Represents seconds of UTC time since Unix epoch 1970-01-01T00:00:00Z. Must
  /// be from 0001-01-01T00:00:00Z to 9999-12-31T23:59:59Z inclusive.
  core.String seconds;

  Timestamp();

  Timestamp.fromJson(core.Map _json) {
    if (_json.containsKey("nanos")) {
      nanos = _json["nanos"];
    }
    if (_json.containsKey("seconds")) {
      seconds = _json["seconds"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nanos != null) {
      _json["nanos"] = nanos;
    }
    if (seconds != null) {
      _json["seconds"] = seconds;
    }
    return _json;
  }
}

/// An execution of an arbitrary tool. It could be a test runner or a tool
/// copying artifacts or deploying code.
class ToolExecution {
  /// The full tokenized command line including the program name (equivalent to
  /// argv in a C program).
  ///
  /// - In response: present if set by create request - In create request:
  /// optional - In update request: never set
  core.List<core.String> commandLineArguments;

  /// Tool execution exit code. This field will be set once the tool has exited.
  ///
  /// - In response: present if set by create/update request - In create
  /// request: optional - In update request: optional, a FAILED_PRECONDITION
  /// error will be returned if an exit_code is already set.
  ToolExitCode exitCode;

  /// References to any plain text logs output the tool execution.
  ///
  /// This field can be set before the tool has exited in order to be able to
  /// have access to a live view of the logs while the tool is running.
  ///
  /// The maximum allowed number of tool logs per step is 1000.
  ///
  /// - In response: present if set by create/update request - In create
  /// request: optional - In update request: optional, any value provided will
  /// be appended to the existing list
  core.List<FileReference> toolLogs;

  /// References to opaque files of any format output by the tool execution.
  ///
  /// The maximum allowed number of tool outputs per step is 1000.
  ///
  /// - In response: present if set by create/update request - In create
  /// request: optional - In update request: optional, any value provided will
  /// be appended to the existing list
  core.List<ToolOutputReference> toolOutputs;

  ToolExecution();

  ToolExecution.fromJson(core.Map _json) {
    if (_json.containsKey("commandLineArguments")) {
      commandLineArguments = _json["commandLineArguments"];
    }
    if (_json.containsKey("exitCode")) {
      exitCode = new ToolExitCode.fromJson(_json["exitCode"]);
    }
    if (_json.containsKey("toolLogs")) {
      toolLogs = _json["toolLogs"]
          .map((value) => new FileReference.fromJson(value))
          .toList();
    }
    if (_json.containsKey("toolOutputs")) {
      toolOutputs = _json["toolOutputs"]
          .map((value) => new ToolOutputReference.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (commandLineArguments != null) {
      _json["commandLineArguments"] = commandLineArguments;
    }
    if (exitCode != null) {
      _json["exitCode"] = (exitCode).toJson();
    }
    if (toolLogs != null) {
      _json["toolLogs"] = toolLogs.map((value) => (value).toJson()).toList();
    }
    if (toolOutputs != null) {
      _json["toolOutputs"] =
          toolOutputs.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Generic tool step to be used for binaries we do not explicitly support. For
/// example: running cp to copy artifacts from one location to another.
class ToolExecutionStep {
  /// A Tool execution.
  ///
  /// - In response: present if set by create/update request - In create/update
  /// request: optional
  ToolExecution toolExecution;

  ToolExecutionStep();

  ToolExecutionStep.fromJson(core.Map _json) {
    if (_json.containsKey("toolExecution")) {
      toolExecution = new ToolExecution.fromJson(_json["toolExecution"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (toolExecution != null) {
      _json["toolExecution"] = (toolExecution).toJson();
    }
    return _json;
  }
}

/// Exit code from a tool execution.
class ToolExitCode {
  /// Tool execution exit code. A value of 0 means that the execution was
  /// successful.
  ///
  /// - In response: always set - In create/update request: always set
  core.int number;

  ToolExitCode();

  ToolExitCode.fromJson(core.Map _json) {
    if (_json.containsKey("number")) {
      number = _json["number"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (number != null) {
      _json["number"] = number;
    }
    return _json;
  }
}

/// A reference to a ToolExecution output file.
class ToolOutputReference {
  /// The creation time of the file.
  ///
  /// - In response: present if set by create/update request - In create/update
  /// request: optional
  Timestamp creationTime;

  /// A FileReference to an output file.
  ///
  /// - In response: always set - In create/update request: always set
  FileReference output;

  /// The test case to which this output file belongs.
  ///
  /// - In response: present if set by create/update request - In create/update
  /// request: optional
  TestCaseReference testCase;

  ToolOutputReference();

  ToolOutputReference.fromJson(core.Map _json) {
    if (_json.containsKey("creationTime")) {
      creationTime = new Timestamp.fromJson(_json["creationTime"]);
    }
    if (_json.containsKey("output")) {
      output = new FileReference.fromJson(_json["output"]);
    }
    if (_json.containsKey("testCase")) {
      testCase = new TestCaseReference.fromJson(_json["testCase"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (creationTime != null) {
      _json["creationTime"] = (creationTime).toJson();
    }
    if (output != null) {
      _json["output"] = (output).toJson();
    }
    if (testCase != null) {
      _json["testCase"] = (testCase).toJson();
    }
    return _json;
  }
}
