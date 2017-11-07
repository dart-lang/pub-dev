// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.dataflow.v1b3;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client dataflow/v1b3';

/// Manages Google Cloud Dataflow projects on Google Cloud Platform.
class DataflowApi {
  /// View and manage your data across Google Cloud Platform services
  static const CloudPlatformScope =
      "https://www.googleapis.com/auth/cloud-platform";

  /// View and manage your Google Compute Engine resources
  static const ComputeScope = "https://www.googleapis.com/auth/compute";

  /// View your Google Compute Engine resources
  static const ComputeReadonlyScope =
      "https://www.googleapis.com/auth/compute.readonly";

  /// View your email address
  static const UserinfoEmailScope =
      "https://www.googleapis.com/auth/userinfo.email";

  final commons.ApiRequester _requester;

  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);

  DataflowApi(http.Client client,
      {core.String rootUrl: "https://dataflow.googleapis.com/",
      core.String servicePath: ""})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsJobsResourceApi get jobs => new ProjectsJobsResourceApi(_requester);
  ProjectsLocationsResourceApi get locations =>
      new ProjectsLocationsResourceApi(_requester);
  ProjectsTemplatesResourceApi get templates =>
      new ProjectsTemplatesResourceApi(_requester);

  ProjectsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Send a worker_message to the service.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project to send the WorkerMessages to.
  ///
  /// Completes with a [SendWorkerMessagesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SendWorkerMessagesResponse> workerMessages(
      SendWorkerMessagesRequest request, core.String projectId) {
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

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/WorkerMessages';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new SendWorkerMessagesResponse.fromJson(data));
  }
}

class ProjectsJobsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsJobsDebugResourceApi get debug =>
      new ProjectsJobsDebugResourceApi(_requester);
  ProjectsJobsMessagesResourceApi get messages =>
      new ProjectsJobsMessagesResourceApi(_requester);
  ProjectsJobsWorkItemsResourceApi get workItems =>
      new ProjectsJobsWorkItemsResourceApi(_requester);

  ProjectsJobsResourceApi(commons.ApiRequester client) : _requester = client;

  /// List the jobs of a project across all regions.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project which owns the jobs.
  ///
  /// [view] - Level of information requested in response. Default is
  /// `JOB_VIEW_SUMMARY`.
  /// Possible string values are:
  /// - "JOB_VIEW_UNKNOWN" : A JOB_VIEW_UNKNOWN.
  /// - "JOB_VIEW_SUMMARY" : A JOB_VIEW_SUMMARY.
  /// - "JOB_VIEW_ALL" : A JOB_VIEW_ALL.
  /// - "JOB_VIEW_DESCRIPTION" : A JOB_VIEW_DESCRIPTION.
  ///
  /// [filter] - The kind of filter to use.
  /// Possible string values are:
  /// - "UNKNOWN" : A UNKNOWN.
  /// - "ALL" : A ALL.
  /// - "TERMINATED" : A TERMINATED.
  /// - "ACTIVE" : A ACTIVE.
  ///
  /// [location] - The location that contains this job.
  ///
  /// [pageToken] - Set this to the 'next_page_token' field of a previous
  /// response
  /// to request additional results in a long list.
  ///
  /// [pageSize] - If there are many jobs, limit response to at most this many.
  /// The actual number of jobs returned will be the lesser of max_responses
  /// and an unspecified server-defined limit.
  ///
  /// Completes with a [ListJobsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListJobsResponse> aggregated(core.String projectId,
      {core.String view,
      core.String filter,
      core.String location,
      core.String pageToken,
      core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (location != null) {
      _queryParams["location"] = [location];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/jobs:aggregated';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListJobsResponse.fromJson(data));
  }

  /// Creates a Cloud Dataflow job.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The ID of the Cloud Platform project that the job belongs
  /// to.
  ///
  /// [location] - The location that contains this job.
  ///
  /// [replaceJobId] - Deprecated. This field is now in the Job message.
  ///
  /// [view] - The level of information requested in response.
  /// Possible string values are:
  /// - "JOB_VIEW_UNKNOWN" : A JOB_VIEW_UNKNOWN.
  /// - "JOB_VIEW_SUMMARY" : A JOB_VIEW_SUMMARY.
  /// - "JOB_VIEW_ALL" : A JOB_VIEW_ALL.
  /// - "JOB_VIEW_DESCRIPTION" : A JOB_VIEW_DESCRIPTION.
  ///
  /// Completes with a [Job].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Job> create(Job request, core.String projectId,
      {core.String location, core.String replaceJobId, core.String view}) {
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
    if (location != null) {
      _queryParams["location"] = [location];
    }
    if (replaceJobId != null) {
      _queryParams["replaceJobId"] = [replaceJobId];
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/jobs';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Job.fromJson(data));
  }

  /// Gets the state of the specified Cloud Dataflow job.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The ID of the Cloud Platform project that the job belongs
  /// to.
  ///
  /// [jobId] - The job ID.
  ///
  /// [location] - The location that contains this job.
  ///
  /// [view] - The level of information requested in response.
  /// Possible string values are:
  /// - "JOB_VIEW_UNKNOWN" : A JOB_VIEW_UNKNOWN.
  /// - "JOB_VIEW_SUMMARY" : A JOB_VIEW_SUMMARY.
  /// - "JOB_VIEW_ALL" : A JOB_VIEW_ALL.
  /// - "JOB_VIEW_DESCRIPTION" : A JOB_VIEW_DESCRIPTION.
  ///
  /// Completes with a [Job].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Job> get(core.String projectId, core.String jobId,
      {core.String location, core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }
    if (location != null) {
      _queryParams["location"] = [location];
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Job.fromJson(data));
  }

  /// Request the job status.
  ///
  /// Request parameters:
  ///
  /// [projectId] - A project id.
  ///
  /// [jobId] - The job to get messages for.
  ///
  /// [location] - The location which contains the job specified by job_id.
  ///
  /// [startTime] - Return only metric data that has changed since this time.
  /// Default is to return all information about all metrics for the job.
  ///
  /// Completes with a [JobMetrics].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<JobMetrics> getMetrics(core.String projectId, core.String jobId,
      {core.String location, core.String startTime}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }
    if (location != null) {
      _queryParams["location"] = [location];
    }
    if (startTime != null) {
      _queryParams["startTime"] = [startTime];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId') +
        '/metrics';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new JobMetrics.fromJson(data));
  }

  /// List the jobs of a project in a given region.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project which owns the jobs.
  ///
  /// [filter] - The kind of filter to use.
  /// Possible string values are:
  /// - "UNKNOWN" : A UNKNOWN.
  /// - "ALL" : A ALL.
  /// - "TERMINATED" : A TERMINATED.
  /// - "ACTIVE" : A ACTIVE.
  ///
  /// [location] - The location that contains this job.
  ///
  /// [pageToken] - Set this to the 'next_page_token' field of a previous
  /// response
  /// to request additional results in a long list.
  ///
  /// [pageSize] - If there are many jobs, limit response to at most this many.
  /// The actual number of jobs returned will be the lesser of max_responses
  /// and an unspecified server-defined limit.
  ///
  /// [view] - Level of information requested in response. Default is
  /// `JOB_VIEW_SUMMARY`.
  /// Possible string values are:
  /// - "JOB_VIEW_UNKNOWN" : A JOB_VIEW_UNKNOWN.
  /// - "JOB_VIEW_SUMMARY" : A JOB_VIEW_SUMMARY.
  /// - "JOB_VIEW_ALL" : A JOB_VIEW_ALL.
  /// - "JOB_VIEW_DESCRIPTION" : A JOB_VIEW_DESCRIPTION.
  ///
  /// Completes with a [ListJobsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListJobsResponse> list(core.String projectId,
      {core.String filter,
      core.String location,
      core.String pageToken,
      core.int pageSize,
      core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (location != null) {
      _queryParams["location"] = [location];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/jobs';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListJobsResponse.fromJson(data));
  }

  /// Updates the state of an existing Cloud Dataflow job.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The ID of the Cloud Platform project that the job belongs
  /// to.
  ///
  /// [jobId] - The job ID.
  ///
  /// [location] - The location that contains this job.
  ///
  /// Completes with a [Job].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Job> update(
      Job request, core.String projectId, core.String jobId,
      {core.String location}) {
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
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }
    if (location != null) {
      _queryParams["location"] = [location];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Job.fromJson(data));
  }
}

class ProjectsJobsDebugResourceApi {
  final commons.ApiRequester _requester;

  ProjectsJobsDebugResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Get encoded debug configuration for component. Not cacheable.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project id.
  ///
  /// [jobId] - The job id.
  ///
  /// Completes with a [GetDebugConfigResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GetDebugConfigResponse> getConfig(
      GetDebugConfigRequest request, core.String projectId, core.String jobId) {
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
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId') +
        '/debug/getConfig';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new GetDebugConfigResponse.fromJson(data));
  }

  /// Send encoded debug capture data for component.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project id.
  ///
  /// [jobId] - The job id.
  ///
  /// Completes with a [SendDebugCaptureResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SendDebugCaptureResponse> sendCapture(
      SendDebugCaptureRequest request,
      core.String projectId,
      core.String jobId) {
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
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId') +
        '/debug/sendCapture';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new SendDebugCaptureResponse.fromJson(data));
  }
}

class ProjectsJobsMessagesResourceApi {
  final commons.ApiRequester _requester;

  ProjectsJobsMessagesResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Request the job status.
  ///
  /// Request parameters:
  ///
  /// [projectId] - A project id.
  ///
  /// [jobId] - The job to get messages about.
  ///
  /// [location] - The location which contains the job specified by job_id.
  ///
  /// [endTime] - Return only messages with timestamps < end_time. The default
  /// is now
  /// (i.e. return up to the latest messages available).
  ///
  /// [pageToken] - If supplied, this should be the value of next_page_token
  /// returned
  /// by an earlier call. This will cause the next page of results to
  /// be returned.
  ///
  /// [startTime] - If specified, return only messages with timestamps >=
  /// start_time.
  /// The default is the job creation time (i.e. beginning of messages).
  ///
  /// [pageSize] - If specified, determines the maximum number of messages to
  /// return.  If unspecified, the service may choose an appropriate
  /// default, or may return an arbitrarily large number of results.
  ///
  /// [minimumImportance] - Filter to only get messages with importance >= level
  /// Possible string values are:
  /// - "JOB_MESSAGE_IMPORTANCE_UNKNOWN" : A JOB_MESSAGE_IMPORTANCE_UNKNOWN.
  /// - "JOB_MESSAGE_DEBUG" : A JOB_MESSAGE_DEBUG.
  /// - "JOB_MESSAGE_DETAILED" : A JOB_MESSAGE_DETAILED.
  /// - "JOB_MESSAGE_BASIC" : A JOB_MESSAGE_BASIC.
  /// - "JOB_MESSAGE_WARNING" : A JOB_MESSAGE_WARNING.
  /// - "JOB_MESSAGE_ERROR" : A JOB_MESSAGE_ERROR.
  ///
  /// Completes with a [ListJobMessagesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListJobMessagesResponse> list(
      core.String projectId, core.String jobId,
      {core.String location,
      core.String endTime,
      core.String pageToken,
      core.String startTime,
      core.int pageSize,
      core.String minimumImportance}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }
    if (location != null) {
      _queryParams["location"] = [location];
    }
    if (endTime != null) {
      _queryParams["endTime"] = [endTime];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (startTime != null) {
      _queryParams["startTime"] = [startTime];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (minimumImportance != null) {
      _queryParams["minimumImportance"] = [minimumImportance];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId') +
        '/messages';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListJobMessagesResponse.fromJson(data));
  }
}

class ProjectsJobsWorkItemsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsJobsWorkItemsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Leases a dataflow WorkItem to run.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - Identifies the project this worker belongs to.
  ///
  /// [jobId] - Identifies the workflow job this worker belongs to.
  ///
  /// Completes with a [LeaseWorkItemResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LeaseWorkItemResponse> lease(
      LeaseWorkItemRequest request, core.String projectId, core.String jobId) {
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
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId') +
        '/workItems:lease';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new LeaseWorkItemResponse.fromJson(data));
  }

  /// Reports the status of dataflow WorkItems leased by a worker.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project which owns the WorkItem's job.
  ///
  /// [jobId] - The job which the WorkItem is part of.
  ///
  /// Completes with a [ReportWorkItemStatusResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ReportWorkItemStatusResponse> reportStatus(
      ReportWorkItemStatusRequest request,
      core.String projectId,
      core.String jobId) {
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
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId') +
        '/workItems:reportStatus';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ReportWorkItemStatusResponse.fromJson(data));
  }
}

class ProjectsLocationsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsLocationsJobsResourceApi get jobs =>
      new ProjectsLocationsJobsResourceApi(_requester);
  ProjectsLocationsTemplatesResourceApi get templates =>
      new ProjectsLocationsTemplatesResourceApi(_requester);

  ProjectsLocationsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Send a worker_message to the service.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project to send the WorkerMessages to.
  ///
  /// [location] - The location which contains the job
  ///
  /// Completes with a [SendWorkerMessagesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SendWorkerMessagesResponse> workerMessages(
      SendWorkerMessagesRequest request,
      core.String projectId,
      core.String location) {
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
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/WorkerMessages';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new SendWorkerMessagesResponse.fromJson(data));
  }
}

class ProjectsLocationsJobsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsLocationsJobsDebugResourceApi get debug =>
      new ProjectsLocationsJobsDebugResourceApi(_requester);
  ProjectsLocationsJobsMessagesResourceApi get messages =>
      new ProjectsLocationsJobsMessagesResourceApi(_requester);
  ProjectsLocationsJobsWorkItemsResourceApi get workItems =>
      new ProjectsLocationsJobsWorkItemsResourceApi(_requester);

  ProjectsLocationsJobsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Creates a Cloud Dataflow job.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The ID of the Cloud Platform project that the job belongs
  /// to.
  ///
  /// [location] - The location that contains this job.
  ///
  /// [replaceJobId] - Deprecated. This field is now in the Job message.
  ///
  /// [view] - The level of information requested in response.
  /// Possible string values are:
  /// - "JOB_VIEW_UNKNOWN" : A JOB_VIEW_UNKNOWN.
  /// - "JOB_VIEW_SUMMARY" : A JOB_VIEW_SUMMARY.
  /// - "JOB_VIEW_ALL" : A JOB_VIEW_ALL.
  /// - "JOB_VIEW_DESCRIPTION" : A JOB_VIEW_DESCRIPTION.
  ///
  /// Completes with a [Job].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Job> create(
      Job request, core.String projectId, core.String location,
      {core.String replaceJobId, core.String view}) {
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
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }
    if (replaceJobId != null) {
      _queryParams["replaceJobId"] = [replaceJobId];
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/jobs';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Job.fromJson(data));
  }

  /// Gets the state of the specified Cloud Dataflow job.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The ID of the Cloud Platform project that the job belongs
  /// to.
  ///
  /// [location] - The location that contains this job.
  ///
  /// [jobId] - The job ID.
  ///
  /// [view] - The level of information requested in response.
  /// Possible string values are:
  /// - "JOB_VIEW_UNKNOWN" : A JOB_VIEW_UNKNOWN.
  /// - "JOB_VIEW_SUMMARY" : A JOB_VIEW_SUMMARY.
  /// - "JOB_VIEW_ALL" : A JOB_VIEW_ALL.
  /// - "JOB_VIEW_DESCRIPTION" : A JOB_VIEW_DESCRIPTION.
  ///
  /// Completes with a [Job].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Job> get(
      core.String projectId, core.String location, core.String jobId,
      {core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Job.fromJson(data));
  }

  /// Request the job status.
  ///
  /// Request parameters:
  ///
  /// [projectId] - A project id.
  ///
  /// [location] - The location which contains the job specified by job_id.
  ///
  /// [jobId] - The job to get messages for.
  ///
  /// [startTime] - Return only metric data that has changed since this time.
  /// Default is to return all information about all metrics for the job.
  ///
  /// Completes with a [JobMetrics].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<JobMetrics> getMetrics(
      core.String projectId, core.String location, core.String jobId,
      {core.String startTime}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }
    if (startTime != null) {
      _queryParams["startTime"] = [startTime];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId') +
        '/metrics';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new JobMetrics.fromJson(data));
  }

  /// List the jobs of a project in a given region.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project which owns the jobs.
  ///
  /// [location] - The location that contains this job.
  ///
  /// [pageToken] - Set this to the 'next_page_token' field of a previous
  /// response
  /// to request additional results in a long list.
  ///
  /// [pageSize] - If there are many jobs, limit response to at most this many.
  /// The actual number of jobs returned will be the lesser of max_responses
  /// and an unspecified server-defined limit.
  ///
  /// [view] - Level of information requested in response. Default is
  /// `JOB_VIEW_SUMMARY`.
  /// Possible string values are:
  /// - "JOB_VIEW_UNKNOWN" : A JOB_VIEW_UNKNOWN.
  /// - "JOB_VIEW_SUMMARY" : A JOB_VIEW_SUMMARY.
  /// - "JOB_VIEW_ALL" : A JOB_VIEW_ALL.
  /// - "JOB_VIEW_DESCRIPTION" : A JOB_VIEW_DESCRIPTION.
  ///
  /// [filter] - The kind of filter to use.
  /// Possible string values are:
  /// - "UNKNOWN" : A UNKNOWN.
  /// - "ALL" : A ALL.
  /// - "TERMINATED" : A TERMINATED.
  /// - "ACTIVE" : A ACTIVE.
  ///
  /// Completes with a [ListJobsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListJobsResponse> list(
      core.String projectId, core.String location,
      {core.String pageToken,
      core.int pageSize,
      core.String view,
      core.String filter}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/jobs';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListJobsResponse.fromJson(data));
  }

  /// Updates the state of an existing Cloud Dataflow job.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The ID of the Cloud Platform project that the job belongs
  /// to.
  ///
  /// [location] - The location that contains this job.
  ///
  /// [jobId] - The job ID.
  ///
  /// Completes with a [Job].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Job> update(Job request, core.String projectId,
      core.String location, core.String jobId) {
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
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Job.fromJson(data));
  }
}

class ProjectsLocationsJobsDebugResourceApi {
  final commons.ApiRequester _requester;

  ProjectsLocationsJobsDebugResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Get encoded debug configuration for component. Not cacheable.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project id.
  ///
  /// [location] - The location which contains the job specified by job_id.
  ///
  /// [jobId] - The job id.
  ///
  /// Completes with a [GetDebugConfigResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GetDebugConfigResponse> getConfig(GetDebugConfigRequest request,
      core.String projectId, core.String location, core.String jobId) {
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
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId') +
        '/debug/getConfig';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new GetDebugConfigResponse.fromJson(data));
  }

  /// Send encoded debug capture data for component.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project id.
  ///
  /// [location] - The location which contains the job specified by job_id.
  ///
  /// [jobId] - The job id.
  ///
  /// Completes with a [SendDebugCaptureResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SendDebugCaptureResponse> sendCapture(
      SendDebugCaptureRequest request,
      core.String projectId,
      core.String location,
      core.String jobId) {
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
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId') +
        '/debug/sendCapture';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new SendDebugCaptureResponse.fromJson(data));
  }
}

class ProjectsLocationsJobsMessagesResourceApi {
  final commons.ApiRequester _requester;

  ProjectsLocationsJobsMessagesResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Request the job status.
  ///
  /// Request parameters:
  ///
  /// [projectId] - A project id.
  ///
  /// [location] - The location which contains the job specified by job_id.
  ///
  /// [jobId] - The job to get messages about.
  ///
  /// [endTime] - Return only messages with timestamps < end_time. The default
  /// is now
  /// (i.e. return up to the latest messages available).
  ///
  /// [pageToken] - If supplied, this should be the value of next_page_token
  /// returned
  /// by an earlier call. This will cause the next page of results to
  /// be returned.
  ///
  /// [startTime] - If specified, return only messages with timestamps >=
  /// start_time.
  /// The default is the job creation time (i.e. beginning of messages).
  ///
  /// [pageSize] - If specified, determines the maximum number of messages to
  /// return.  If unspecified, the service may choose an appropriate
  /// default, or may return an arbitrarily large number of results.
  ///
  /// [minimumImportance] - Filter to only get messages with importance >= level
  /// Possible string values are:
  /// - "JOB_MESSAGE_IMPORTANCE_UNKNOWN" : A JOB_MESSAGE_IMPORTANCE_UNKNOWN.
  /// - "JOB_MESSAGE_DEBUG" : A JOB_MESSAGE_DEBUG.
  /// - "JOB_MESSAGE_DETAILED" : A JOB_MESSAGE_DETAILED.
  /// - "JOB_MESSAGE_BASIC" : A JOB_MESSAGE_BASIC.
  /// - "JOB_MESSAGE_WARNING" : A JOB_MESSAGE_WARNING.
  /// - "JOB_MESSAGE_ERROR" : A JOB_MESSAGE_ERROR.
  ///
  /// Completes with a [ListJobMessagesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListJobMessagesResponse> list(
      core.String projectId, core.String location, core.String jobId,
      {core.String endTime,
      core.String pageToken,
      core.String startTime,
      core.int pageSize,
      core.String minimumImportance}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }
    if (endTime != null) {
      _queryParams["endTime"] = [endTime];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (startTime != null) {
      _queryParams["startTime"] = [startTime];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (minimumImportance != null) {
      _queryParams["minimumImportance"] = [minimumImportance];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId') +
        '/messages';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListJobMessagesResponse.fromJson(data));
  }
}

class ProjectsLocationsJobsWorkItemsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsLocationsJobsWorkItemsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Leases a dataflow WorkItem to run.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - Identifies the project this worker belongs to.
  ///
  /// [location] - The location which contains the WorkItem's job.
  ///
  /// [jobId] - Identifies the workflow job this worker belongs to.
  ///
  /// Completes with a [LeaseWorkItemResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LeaseWorkItemResponse> lease(LeaseWorkItemRequest request,
      core.String projectId, core.String location, core.String jobId) {
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
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId') +
        '/workItems:lease';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new LeaseWorkItemResponse.fromJson(data));
  }

  /// Reports the status of dataflow WorkItems leased by a worker.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project which owns the WorkItem's job.
  ///
  /// [location] - The location which contains the WorkItem's job.
  ///
  /// [jobId] - The job which the WorkItem is part of.
  ///
  /// Completes with a [ReportWorkItemStatusResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ReportWorkItemStatusResponse> reportStatus(
      ReportWorkItemStatusRequest request,
      core.String projectId,
      core.String location,
      core.String jobId) {
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
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }
    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/jobs/' +
        commons.Escaper.ecapeVariable('$jobId') +
        '/workItems:reportStatus';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ReportWorkItemStatusResponse.fromJson(data));
  }
}

class ProjectsLocationsTemplatesResourceApi {
  final commons.ApiRequester _requester;

  ProjectsLocationsTemplatesResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Creates a Cloud Dataflow job from a template.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - Required. The ID of the Cloud Platform project that the job
  /// belongs to.
  ///
  /// [location] - The location to which to direct the request.
  ///
  /// Completes with a [Job].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Job> create(CreateJobFromTemplateRequest request,
      core.String projectId, core.String location) {
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
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/templates';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Job.fromJson(data));
  }

  /// Get the template associated with a template.
  ///
  /// Request parameters:
  ///
  /// [projectId] - Required. The ID of the Cloud Platform project that the job
  /// belongs to.
  ///
  /// [location] - The location to which to direct the request.
  ///
  /// [view] - The view to retrieve. Defaults to METADATA_ONLY.
  /// Possible string values are:
  /// - "METADATA_ONLY" : A METADATA_ONLY.
  ///
  /// [gcsPath] - Required. A Cloud Storage path to the template from which to
  /// create the job.
  /// Must be a valid Cloud Storage URL, beginning with `gs://`.
  ///
  /// Completes with a [GetTemplateResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GetTemplateResponse> get(
      core.String projectId, core.String location,
      {core.String view, core.String gcsPath}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }
    if (gcsPath != null) {
      _queryParams["gcsPath"] = [gcsPath];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/templates:get';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new GetTemplateResponse.fromJson(data));
  }

  /// Launch a template.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - Required. The ID of the Cloud Platform project that the job
  /// belongs to.
  ///
  /// [location] - The location to which to direct the request.
  ///
  /// [validateOnly] - If true, the request is validated but not actually
  /// executed.
  /// Defaults to false.
  ///
  /// [gcsPath] - Required. A Cloud Storage path to the template from which to
  /// create
  /// the job.
  /// Must be valid Cloud Storage URL, beginning with 'gs://'.
  ///
  /// Completes with a [LaunchTemplateResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LaunchTemplateResponse> launch(LaunchTemplateParameters request,
      core.String projectId, core.String location,
      {core.bool validateOnly, core.String gcsPath}) {
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
    if (location == null) {
      throw new core.ArgumentError("Parameter location is required.");
    }
    if (validateOnly != null) {
      _queryParams["validateOnly"] = ["${validateOnly}"];
    }
    if (gcsPath != null) {
      _queryParams["gcsPath"] = [gcsPath];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$location') +
        '/templates:launch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new LaunchTemplateResponse.fromJson(data));
  }
}

class ProjectsTemplatesResourceApi {
  final commons.ApiRequester _requester;

  ProjectsTemplatesResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Creates a Cloud Dataflow job from a template.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - Required. The ID of the Cloud Platform project that the job
  /// belongs to.
  ///
  /// Completes with a [Job].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Job> create(
      CreateJobFromTemplateRequest request, core.String projectId) {
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

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/templates';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Job.fromJson(data));
  }

  /// Get the template associated with a template.
  ///
  /// Request parameters:
  ///
  /// [projectId] - Required. The ID of the Cloud Platform project that the job
  /// belongs to.
  ///
  /// [view] - The view to retrieve. Defaults to METADATA_ONLY.
  /// Possible string values are:
  /// - "METADATA_ONLY" : A METADATA_ONLY.
  ///
  /// [gcsPath] - Required. A Cloud Storage path to the template from which to
  /// create the job.
  /// Must be a valid Cloud Storage URL, beginning with `gs://`.
  ///
  /// [location] - The location to which to direct the request.
  ///
  /// Completes with a [GetTemplateResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GetTemplateResponse> get(core.String projectId,
      {core.String view, core.String gcsPath, core.String location}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }
    if (gcsPath != null) {
      _queryParams["gcsPath"] = [gcsPath];
    }
    if (location != null) {
      _queryParams["location"] = [location];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/templates:get';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new GetTemplateResponse.fromJson(data));
  }

  /// Launch a template.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - Required. The ID of the Cloud Platform project that the job
  /// belongs to.
  ///
  /// [location] - The location to which to direct the request.
  ///
  /// [validateOnly] - If true, the request is validated but not actually
  /// executed.
  /// Defaults to false.
  ///
  /// [gcsPath] - Required. A Cloud Storage path to the template from which to
  /// create
  /// the job.
  /// Must be valid Cloud Storage URL, beginning with 'gs://'.
  ///
  /// Completes with a [LaunchTemplateResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LaunchTemplateResponse> launch(
      LaunchTemplateParameters request, core.String projectId,
      {core.String location, core.bool validateOnly, core.String gcsPath}) {
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
    if (location != null) {
      _queryParams["location"] = [location];
    }
    if (validateOnly != null) {
      _queryParams["validateOnly"] = ["${validateOnly}"];
    }
    if (gcsPath != null) {
      _queryParams["gcsPath"] = [gcsPath];
    }

    _url = 'v1b3/projects/' +
        commons.Escaper.ecapeVariable('$projectId') +
        '/templates:launch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new LaunchTemplateResponse.fromJson(data));
  }
}

/// Obsolete in favor of ApproximateReportedProgress and
/// ApproximateSplitRequest.
class ApproximateProgress {
  /// Obsolete.
  core.double percentComplete;

  /// Obsolete.
  Position position;

  /// Obsolete.
  core.String remainingTime;

  ApproximateProgress();

  ApproximateProgress.fromJson(core.Map _json) {
    if (_json.containsKey("percentComplete")) {
      percentComplete = _json["percentComplete"];
    }
    if (_json.containsKey("position")) {
      position = new Position.fromJson(_json["position"]);
    }
    if (_json.containsKey("remainingTime")) {
      remainingTime = _json["remainingTime"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (percentComplete != null) {
      _json["percentComplete"] = percentComplete;
    }
    if (position != null) {
      _json["position"] = (position).toJson();
    }
    if (remainingTime != null) {
      _json["remainingTime"] = remainingTime;
    }
    return _json;
  }
}

/// A progress measurement of a WorkItem by a worker.
class ApproximateReportedProgress {
  /// Total amount of parallelism in the portion of input of this task that has
  /// already been consumed and is no longer active. In the first two examples
  /// above (see remaining_parallelism), the value should be 29 or 2
  /// respectively.  The sum of remaining_parallelism and consumed_parallelism
  /// should equal the total amount of parallelism in this work item.  If
  /// specified, must be finite.
  ReportedParallelism consumedParallelism;

  /// Completion as fraction of the input consumed, from 0.0 (beginning, nothing
  /// consumed), to 1.0 (end of the input, entire input consumed).
  core.double fractionConsumed;

  /// A Position within the work to represent a progress.
  Position position;

  /// Total amount of parallelism in the input of this task that remains,
  /// (i.e. can be delegated to this task and any new tasks via dynamic
  /// splitting). Always at least 1 for non-finished work items and 0 for
  /// finished.
  ///
  /// "Amount of parallelism" refers to how many non-empty parts of the input
  /// can be read in parallel. This does not necessarily equal number
  /// of records. An input that can be read in parallel down to the
  /// individual records is called "perfectly splittable".
  /// An example of non-perfectly parallelizable input is a block-compressed
  /// file format where a block of records has to be read as a whole,
  /// but different blocks can be read in parallel.
  ///
  /// Examples:
  /// * If we are processing record #30 (starting at 1) out of 50 in a perfectly
  ///   splittable 50-record input, this value should be 21 (20 remaining + 1
  ///   current).
  /// * If we are reading through block 3 in a block-compressed file consisting
  ///   of 5 blocks, this value should be 3 (since blocks 4 and 5 can be
  /// processed in parallel by new tasks via dynamic splitting and the current
  ///   task remains processing block 3).
  /// * If we are reading through the last block in a block-compressed file,
  ///   or reading or processing the last record in a perfectly splittable
  ///   input, this value should be 1, because apart from the current task, no
  ///   additional remainder can be split off.
  ReportedParallelism remainingParallelism;

  ApproximateReportedProgress();

  ApproximateReportedProgress.fromJson(core.Map _json) {
    if (_json.containsKey("consumedParallelism")) {
      consumedParallelism =
          new ReportedParallelism.fromJson(_json["consumedParallelism"]);
    }
    if (_json.containsKey("fractionConsumed")) {
      fractionConsumed = _json["fractionConsumed"];
    }
    if (_json.containsKey("position")) {
      position = new Position.fromJson(_json["position"]);
    }
    if (_json.containsKey("remainingParallelism")) {
      remainingParallelism =
          new ReportedParallelism.fromJson(_json["remainingParallelism"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (consumedParallelism != null) {
      _json["consumedParallelism"] = (consumedParallelism).toJson();
    }
    if (fractionConsumed != null) {
      _json["fractionConsumed"] = fractionConsumed;
    }
    if (position != null) {
      _json["position"] = (position).toJson();
    }
    if (remainingParallelism != null) {
      _json["remainingParallelism"] = (remainingParallelism).toJson();
    }
    return _json;
  }
}

/// A suggestion by the service to the worker to dynamically split the WorkItem.
class ApproximateSplitRequest {
  /// A fraction at which to split the work item, from 0.0 (beginning of the
  /// input) to 1.0 (end of the input).
  core.double fractionConsumed;

  /// A Position at which to split the work item.
  Position position;

  ApproximateSplitRequest();

  ApproximateSplitRequest.fromJson(core.Map _json) {
    if (_json.containsKey("fractionConsumed")) {
      fractionConsumed = _json["fractionConsumed"];
    }
    if (_json.containsKey("position")) {
      position = new Position.fromJson(_json["position"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (fractionConsumed != null) {
      _json["fractionConsumed"] = fractionConsumed;
    }
    if (position != null) {
      _json["position"] = (position).toJson();
    }
    return _json;
  }
}

/// A structured message reporting an autoscaling decision made by the Dataflow
/// service.
class AutoscalingEvent {
  /// The current number of workers the job has.
  core.String currentNumWorkers;

  /// A message describing why the system decided to adjust the current
  /// number of workers, why it failed, or why the system decided to
  /// not make any changes to the number of workers.
  StructuredMessage description;

  /// The type of autoscaling event to report.
  /// Possible string values are:
  /// - "TYPE_UNKNOWN" : Default type for the enum.  Value should never be
  /// returned.
  /// - "TARGET_NUM_WORKERS_CHANGED" : The TARGET_NUM_WORKERS_CHANGED type
  /// should be used when the target
  /// worker pool size has changed at the start of an actuation. An event
  /// should always be specified as TARGET_NUM_WORKERS_CHANGED if it reflects
  /// a change in the target_num_workers.
  /// - "CURRENT_NUM_WORKERS_CHANGED" : The CURRENT_NUM_WORKERS_CHANGED type
  /// should be used when actual worker
  /// pool size has been changed, but the target_num_workers has not changed.
  /// - "ACTUATION_FAILURE" : The ACTUATION_FAILURE type should be used when we
  /// want to report
  /// an error to the user indicating why the current number of workers
  /// in the pool could not be changed.
  /// Displayed in the current status and history widgets.
  /// - "NO_CHANGE" : Used when we want to report to the user a reason why we
  /// are
  /// not currently adjusting the number of workers.
  /// Should specify both target_num_workers, current_num_workers and a
  /// decision_message.
  core.String eventType;

  /// The target number of workers the worker pool wants to resize to use.
  core.String targetNumWorkers;

  /// The time this event was emitted to indicate a new target or current
  /// num_workers value.
  core.String time;

  AutoscalingEvent();

  AutoscalingEvent.fromJson(core.Map _json) {
    if (_json.containsKey("currentNumWorkers")) {
      currentNumWorkers = _json["currentNumWorkers"];
    }
    if (_json.containsKey("description")) {
      description = new StructuredMessage.fromJson(_json["description"]);
    }
    if (_json.containsKey("eventType")) {
      eventType = _json["eventType"];
    }
    if (_json.containsKey("targetNumWorkers")) {
      targetNumWorkers = _json["targetNumWorkers"];
    }
    if (_json.containsKey("time")) {
      time = _json["time"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (currentNumWorkers != null) {
      _json["currentNumWorkers"] = currentNumWorkers;
    }
    if (description != null) {
      _json["description"] = (description).toJson();
    }
    if (eventType != null) {
      _json["eventType"] = eventType;
    }
    if (targetNumWorkers != null) {
      _json["targetNumWorkers"] = targetNumWorkers;
    }
    if (time != null) {
      _json["time"] = time;
    }
    return _json;
  }
}

/// Settings for WorkerPool autoscaling.
class AutoscalingSettings {
  /// The algorithm to use for autoscaling.
  /// Possible string values are:
  /// - "AUTOSCALING_ALGORITHM_UNKNOWN" : The algorithm is unknown, or
  /// unspecified.
  /// - "AUTOSCALING_ALGORITHM_NONE" : Disable autoscaling.
  /// - "AUTOSCALING_ALGORITHM_BASIC" : Increase worker count over time to
  /// reduce job execution time.
  core.String algorithm;

  /// The maximum number of workers to cap scaling at.
  core.int maxNumWorkers;

  AutoscalingSettings();

  AutoscalingSettings.fromJson(core.Map _json) {
    if (_json.containsKey("algorithm")) {
      algorithm = _json["algorithm"];
    }
    if (_json.containsKey("maxNumWorkers")) {
      maxNumWorkers = _json["maxNumWorkers"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (algorithm != null) {
      _json["algorithm"] = algorithm;
    }
    if (maxNumWorkers != null) {
      _json["maxNumWorkers"] = maxNumWorkers;
    }
    return _json;
  }
}

/// Modeled after information exposed by /proc/stat.
class CPUTime {
  /// Average CPU utilization rate (% non-idle cpu / second) since previous
  /// sample.
  core.double rate;

  /// Timestamp of the measurement.
  core.String timestamp;

  /// Total active CPU time across all cores (ie., non-idle) in milliseconds
  /// since start-up.
  core.String totalMs;

  CPUTime();

  CPUTime.fromJson(core.Map _json) {
    if (_json.containsKey("rate")) {
      rate = _json["rate"];
    }
    if (_json.containsKey("timestamp")) {
      timestamp = _json["timestamp"];
    }
    if (_json.containsKey("totalMs")) {
      totalMs = _json["totalMs"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (rate != null) {
      _json["rate"] = rate;
    }
    if (timestamp != null) {
      _json["timestamp"] = timestamp;
    }
    if (totalMs != null) {
      _json["totalMs"] = totalMs;
    }
    return _json;
  }
}

/// Description of an interstitial value between transforms in an execution
/// stage.
class ComponentSource {
  /// Dataflow service generated name for this source.
  core.String name;

  /// User name for the original user transform or collection with which this
  /// source is most closely associated.
  core.String originalTransformOrCollection;

  /// Human-readable name for this transform; may be user or system generated.
  core.String userName;

  ComponentSource();

  ComponentSource.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("originalTransformOrCollection")) {
      originalTransformOrCollection = _json["originalTransformOrCollection"];
    }
    if (_json.containsKey("userName")) {
      userName = _json["userName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (name != null) {
      _json["name"] = name;
    }
    if (originalTransformOrCollection != null) {
      _json["originalTransformOrCollection"] = originalTransformOrCollection;
    }
    if (userName != null) {
      _json["userName"] = userName;
    }
    return _json;
  }
}

/// Description of a transform executed as part of an execution stage.
class ComponentTransform {
  /// Dataflow service generated name for this source.
  core.String name;

  /// User name for the original user transform with which this transform is
  /// most closely associated.
  core.String originalTransform;

  /// Human-readable name for this transform; may be user or system generated.
  core.String userName;

  ComponentTransform();

  ComponentTransform.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("originalTransform")) {
      originalTransform = _json["originalTransform"];
    }
    if (_json.containsKey("userName")) {
      userName = _json["userName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (name != null) {
      _json["name"] = name;
    }
    if (originalTransform != null) {
      _json["originalTransform"] = originalTransform;
    }
    if (userName != null) {
      _json["userName"] = userName;
    }
    return _json;
  }
}

/// All configuration data for a particular Computation.
class ComputationTopology {
  /// The ID of the computation.
  core.String computationId;

  /// The inputs to the computation.
  core.List<StreamLocation> inputs;

  /// The key ranges processed by the computation.
  core.List<KeyRangeLocation> keyRanges;

  /// The outputs from the computation.
  core.List<StreamLocation> outputs;

  /// The state family values.
  core.List<StateFamilyConfig> stateFamilies;

  /// The system stage name.
  core.String systemStageName;

  ComputationTopology();

  ComputationTopology.fromJson(core.Map _json) {
    if (_json.containsKey("computationId")) {
      computationId = _json["computationId"];
    }
    if (_json.containsKey("inputs")) {
      inputs = _json["inputs"]
          .map((value) => new StreamLocation.fromJson(value))
          .toList();
    }
    if (_json.containsKey("keyRanges")) {
      keyRanges = _json["keyRanges"]
          .map((value) => new KeyRangeLocation.fromJson(value))
          .toList();
    }
    if (_json.containsKey("outputs")) {
      outputs = _json["outputs"]
          .map((value) => new StreamLocation.fromJson(value))
          .toList();
    }
    if (_json.containsKey("stateFamilies")) {
      stateFamilies = _json["stateFamilies"]
          .map((value) => new StateFamilyConfig.fromJson(value))
          .toList();
    }
    if (_json.containsKey("systemStageName")) {
      systemStageName = _json["systemStageName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (computationId != null) {
      _json["computationId"] = computationId;
    }
    if (inputs != null) {
      _json["inputs"] = inputs.map((value) => (value).toJson()).toList();
    }
    if (keyRanges != null) {
      _json["keyRanges"] = keyRanges.map((value) => (value).toJson()).toList();
    }
    if (outputs != null) {
      _json["outputs"] = outputs.map((value) => (value).toJson()).toList();
    }
    if (stateFamilies != null) {
      _json["stateFamilies"] =
          stateFamilies.map((value) => (value).toJson()).toList();
    }
    if (systemStageName != null) {
      _json["systemStageName"] = systemStageName;
    }
    return _json;
  }
}

/// A position that encapsulates an inner position and an index for the inner
/// position. A ConcatPosition can be used by a reader of a source that
/// encapsulates a set of other sources.
class ConcatPosition {
  /// Index of the inner source.
  core.int index;

  /// Position within the inner source.
  Position position;

  ConcatPosition();

  ConcatPosition.fromJson(core.Map _json) {
    if (_json.containsKey("index")) {
      index = _json["index"];
    }
    if (_json.containsKey("position")) {
      position = new Position.fromJson(_json["position"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (index != null) {
      _json["index"] = index;
    }
    if (position != null) {
      _json["position"] = (position).toJson();
    }
    return _json;
  }
}

/// CounterMetadata includes all static non-name non-value counter attributes.
class CounterMetadata {
  /// Human-readable description of the counter semantics.
  core.String description;

  /// Counter aggregation kind.
  /// Possible string values are:
  /// - "INVALID" : Counter aggregation kind was not set.
  /// - "SUM" : Aggregated value is the sum of all contributed values.
  /// - "MAX" : Aggregated value is the max of all contributed values.
  /// - "MIN" : Aggregated value is the min of all contributed values.
  /// - "MEAN" : Aggregated value is the mean of all contributed values.
  /// - "OR" : Aggregated value represents the logical 'or' of all contributed
  /// values.
  /// - "AND" : Aggregated value represents the logical 'and' of all contributed
  /// values.
  /// - "SET" : Aggregated value is a set of unique contributed values.
  /// - "DISTRIBUTION" : Aggregated value captures statistics about a
  /// distribution.
  core.String kind;

  /// A string referring to the unit type.
  core.String otherUnits;

  /// System defined Units, see above enum.
  /// Possible string values are:
  /// - "BYTES" : Counter returns a value in bytes.
  /// - "BYTES_PER_SEC" : Counter returns a value in bytes per second.
  /// - "MILLISECONDS" : Counter returns a value in milliseconds.
  /// - "MICROSECONDS" : Counter returns a value in microseconds.
  /// - "NANOSECONDS" : Counter returns a value in nanoseconds.
  /// - "TIMESTAMP_MSEC" : Counter returns a timestamp in milliseconds.
  /// - "TIMESTAMP_USEC" : Counter returns a timestamp in microseconds.
  /// - "TIMESTAMP_NSEC" : Counter returns a timestamp in nanoseconds.
  core.String standardUnits;

  CounterMetadata();

  CounterMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("otherUnits")) {
      otherUnits = _json["otherUnits"];
    }
    if (_json.containsKey("standardUnits")) {
      standardUnits = _json["standardUnits"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (description != null) {
      _json["description"] = description;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (otherUnits != null) {
      _json["otherUnits"] = otherUnits;
    }
    if (standardUnits != null) {
      _json["standardUnits"] = standardUnits;
    }
    return _json;
  }
}

/// Identifies a counter within a per-job namespace. Counters whose structured
/// names are the same get merged into a single value for the job.
class CounterStructuredName {
  /// Name of the optimized step being executed by the workers.
  core.String componentStepName;

  /// Name of the stage. An execution step contains multiple component steps.
  core.String executionStepName;

  /// Counter name. Not necessarily globally-unique, but unique within the
  /// context of the other fields.
  /// Required.
  core.String name;

  /// One of the standard Origins defined above.
  /// Possible string values are:
  /// - "SYSTEM" : Counter was created by the Dataflow system.
  /// - "USER" : Counter was created by the user.
  core.String origin;

  /// A string containing a more specific namespace of the counter's origin.
  core.String originNamespace;

  /// The GroupByKey step name from the original graph.
  core.String originalShuffleStepName;

  /// System generated name of the original step in the user's graph, before
  /// optimization.
  core.String originalStepName;

  /// Portion of this counter, either key or value.
  /// Possible string values are:
  /// - "ALL" : Counter portion has not been set.
  /// - "KEY" : Counter reports a key.
  /// - "VALUE" : Counter reports a value.
  core.String portion;

  /// ID of a side input being read from/written to. Side inputs are identified
  /// by a pair of (reader, input_index). The reader is usually equal to the
  /// original name, but it may be different, if a ParDo emits it's Iterator /
  /// Map side input object.
  SideInputId sideInput;

  /// ID of a particular worker.
  core.String workerId;

  CounterStructuredName();

  CounterStructuredName.fromJson(core.Map _json) {
    if (_json.containsKey("componentStepName")) {
      componentStepName = _json["componentStepName"];
    }
    if (_json.containsKey("executionStepName")) {
      executionStepName = _json["executionStepName"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("origin")) {
      origin = _json["origin"];
    }
    if (_json.containsKey("originNamespace")) {
      originNamespace = _json["originNamespace"];
    }
    if (_json.containsKey("originalShuffleStepName")) {
      originalShuffleStepName = _json["originalShuffleStepName"];
    }
    if (_json.containsKey("originalStepName")) {
      originalStepName = _json["originalStepName"];
    }
    if (_json.containsKey("portion")) {
      portion = _json["portion"];
    }
    if (_json.containsKey("sideInput")) {
      sideInput = new SideInputId.fromJson(_json["sideInput"]);
    }
    if (_json.containsKey("workerId")) {
      workerId = _json["workerId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (componentStepName != null) {
      _json["componentStepName"] = componentStepName;
    }
    if (executionStepName != null) {
      _json["executionStepName"] = executionStepName;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (origin != null) {
      _json["origin"] = origin;
    }
    if (originNamespace != null) {
      _json["originNamespace"] = originNamespace;
    }
    if (originalShuffleStepName != null) {
      _json["originalShuffleStepName"] = originalShuffleStepName;
    }
    if (originalStepName != null) {
      _json["originalStepName"] = originalStepName;
    }
    if (portion != null) {
      _json["portion"] = portion;
    }
    if (sideInput != null) {
      _json["sideInput"] = (sideInput).toJson();
    }
    if (workerId != null) {
      _json["workerId"] = workerId;
    }
    return _json;
  }
}

/// A single message which encapsulates structured name and metadata for a given
/// counter.
class CounterStructuredNameAndMetadata {
  /// Metadata associated with a counter
  CounterMetadata metadata;

  /// Structured name of the counter.
  CounterStructuredName name;

  CounterStructuredNameAndMetadata();

  CounterStructuredNameAndMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("metadata")) {
      metadata = new CounterMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("name")) {
      name = new CounterStructuredName.fromJson(_json["name"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (name != null) {
      _json["name"] = (name).toJson();
    }
    return _json;
  }
}

/// An update to a Counter sent from a worker.
class CounterUpdate {
  /// Boolean value for And, Or.
  core.bool boolean;

  /// True if this counter is reported as the total cumulative aggregate
  /// value accumulated since the worker started working on this WorkItem.
  /// By default this is false, indicating that this counter is reported
  /// as a delta.
  core.bool cumulative;

  /// Distribution data
  DistributionUpdate distribution;

  /// Floating point value for Sum, Max, Min.
  core.double floatingPoint;

  /// List of floating point numbers, for Set.
  FloatingPointList floatingPointList;

  /// Floating point mean aggregation value for Mean.
  FloatingPointMean floatingPointMean;

  /// Integer value for Sum, Max, Min.
  SplitInt64 integer;

  /// List of integers, for Set.
  IntegerList integerList;

  /// Integer mean aggregation value for Mean.
  IntegerMean integerMean;

  /// Value for internally-defined counters used by the Dataflow service.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Object internal;

  /// Counter name and aggregation type.
  NameAndKind nameAndKind;

  /// The service-generated short identifier for this counter.
  /// The short_id -> (name, metadata) mapping is constant for the lifetime of
  /// a job.
  core.String shortId;

  /// List of strings, for Set.
  StringList stringList;

  /// Counter structured name and metadata.
  CounterStructuredNameAndMetadata structuredNameAndMetadata;

  CounterUpdate();

  CounterUpdate.fromJson(core.Map _json) {
    if (_json.containsKey("boolean")) {
      boolean = _json["boolean"];
    }
    if (_json.containsKey("cumulative")) {
      cumulative = _json["cumulative"];
    }
    if (_json.containsKey("distribution")) {
      distribution = new DistributionUpdate.fromJson(_json["distribution"]);
    }
    if (_json.containsKey("floatingPoint")) {
      floatingPoint = _json["floatingPoint"];
    }
    if (_json.containsKey("floatingPointList")) {
      floatingPointList =
          new FloatingPointList.fromJson(_json["floatingPointList"]);
    }
    if (_json.containsKey("floatingPointMean")) {
      floatingPointMean =
          new FloatingPointMean.fromJson(_json["floatingPointMean"]);
    }
    if (_json.containsKey("integer")) {
      integer = new SplitInt64.fromJson(_json["integer"]);
    }
    if (_json.containsKey("integerList")) {
      integerList = new IntegerList.fromJson(_json["integerList"]);
    }
    if (_json.containsKey("integerMean")) {
      integerMean = new IntegerMean.fromJson(_json["integerMean"]);
    }
    if (_json.containsKey("internal")) {
      internal = _json["internal"];
    }
    if (_json.containsKey("nameAndKind")) {
      nameAndKind = new NameAndKind.fromJson(_json["nameAndKind"]);
    }
    if (_json.containsKey("shortId")) {
      shortId = _json["shortId"];
    }
    if (_json.containsKey("stringList")) {
      stringList = new StringList.fromJson(_json["stringList"]);
    }
    if (_json.containsKey("structuredNameAndMetadata")) {
      structuredNameAndMetadata = new CounterStructuredNameAndMetadata.fromJson(
          _json["structuredNameAndMetadata"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (boolean != null) {
      _json["boolean"] = boolean;
    }
    if (cumulative != null) {
      _json["cumulative"] = cumulative;
    }
    if (distribution != null) {
      _json["distribution"] = (distribution).toJson();
    }
    if (floatingPoint != null) {
      _json["floatingPoint"] = floatingPoint;
    }
    if (floatingPointList != null) {
      _json["floatingPointList"] = (floatingPointList).toJson();
    }
    if (floatingPointMean != null) {
      _json["floatingPointMean"] = (floatingPointMean).toJson();
    }
    if (integer != null) {
      _json["integer"] = (integer).toJson();
    }
    if (integerList != null) {
      _json["integerList"] = (integerList).toJson();
    }
    if (integerMean != null) {
      _json["integerMean"] = (integerMean).toJson();
    }
    if (internal != null) {
      _json["internal"] = internal;
    }
    if (nameAndKind != null) {
      _json["nameAndKind"] = (nameAndKind).toJson();
    }
    if (shortId != null) {
      _json["shortId"] = shortId;
    }
    if (stringList != null) {
      _json["stringList"] = (stringList).toJson();
    }
    if (structuredNameAndMetadata != null) {
      _json["structuredNameAndMetadata"] = (structuredNameAndMetadata).toJson();
    }
    return _json;
  }
}

/// A request to create a Cloud Dataflow job from a template.
class CreateJobFromTemplateRequest {
  /// The runtime environment for the job.
  RuntimeEnvironment environment;

  /// Required. A Cloud Storage path to the template from which to
  /// create the job.
  /// Must be a valid Cloud Storage URL, beginning with `gs://`.
  core.String gcsPath;

  /// Required. The job name to use for the created job.
  core.String jobName;

  /// The location to which to direct the request.
  core.String location;

  /// The runtime parameters to pass to the job.
  core.Map<core.String, core.String> parameters;

  CreateJobFromTemplateRequest();

  CreateJobFromTemplateRequest.fromJson(core.Map _json) {
    if (_json.containsKey("environment")) {
      environment = new RuntimeEnvironment.fromJson(_json["environment"]);
    }
    if (_json.containsKey("gcsPath")) {
      gcsPath = _json["gcsPath"];
    }
    if (_json.containsKey("jobName")) {
      jobName = _json["jobName"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("parameters")) {
      parameters = _json["parameters"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (environment != null) {
      _json["environment"] = (environment).toJson();
    }
    if (gcsPath != null) {
      _json["gcsPath"] = gcsPath;
    }
    if (jobName != null) {
      _json["jobName"] = jobName;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (parameters != null) {
      _json["parameters"] = parameters;
    }
    return _json;
  }
}

/// Identifies the location of a custom souce.
class CustomSourceLocation {
  /// Whether this source is stateful.
  core.bool stateful;

  CustomSourceLocation();

  CustomSourceLocation.fromJson(core.Map _json) {
    if (_json.containsKey("stateful")) {
      stateful = _json["stateful"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (stateful != null) {
      _json["stateful"] = stateful;
    }
    return _json;
  }
}

/// Data disk assignment for a given VM instance.
class DataDiskAssignment {
  /// Mounted data disks. The order is important a data disk's 0-based index in
  /// this list defines which persistent directory the disk is mounted to, for
  /// example the list of { "myproject-1014-104817-4c2-harness-0-disk-0" },
  /// { "myproject-1014-104817-4c2-harness-0-disk-1" }.
  core.List<core.String> dataDisks;

  /// VM instance name the data disks mounted to, for example
  /// "myproject-1014-104817-4c2-harness-0".
  core.String vmInstance;

  DataDiskAssignment();

  DataDiskAssignment.fromJson(core.Map _json) {
    if (_json.containsKey("dataDisks")) {
      dataDisks = _json["dataDisks"];
    }
    if (_json.containsKey("vmInstance")) {
      vmInstance = _json["vmInstance"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (dataDisks != null) {
      _json["dataDisks"] = dataDisks;
    }
    if (vmInstance != null) {
      _json["vmInstance"] = vmInstance;
    }
    return _json;
  }
}

/// Specification of one of the bundles produced as a result of splitting
/// a Source (e.g. when executing a SourceSplitRequest, or when
/// splitting an active task using WorkItemStatus.dynamic_source_split),
/// relative to the source being split.
class DerivedSource {
  /// What source to base the produced source on (if any).
  /// Possible string values are:
  /// - "SOURCE_DERIVATION_MODE_UNKNOWN" : The source derivation is unknown, or
  /// unspecified.
  /// - "SOURCE_DERIVATION_MODE_INDEPENDENT" : Produce a completely independent
  /// Source with no base.
  /// - "SOURCE_DERIVATION_MODE_CHILD_OF_CURRENT" : Produce a Source based on
  /// the Source being split.
  /// - "SOURCE_DERIVATION_MODE_SIBLING_OF_CURRENT" : Produce a Source based on
  /// the base of the Source being split.
  core.String derivationMode;

  /// Specification of the source.
  Source source;

  DerivedSource();

  DerivedSource.fromJson(core.Map _json) {
    if (_json.containsKey("derivationMode")) {
      derivationMode = _json["derivationMode"];
    }
    if (_json.containsKey("source")) {
      source = new Source.fromJson(_json["source"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (derivationMode != null) {
      _json["derivationMode"] = derivationMode;
    }
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    return _json;
  }
}

/// Describes the data disk used by a workflow job.
class Disk {
  /// Disk storage type, as defined by Google Compute Engine.  This
  /// must be a disk type appropriate to the project and zone in which
  /// the workers will run.  If unknown or unspecified, the service
  /// will attempt to choose a reasonable default.
  ///
  /// For example, the standard persistent disk type is a resource name
  /// typically ending in "pd-standard".  If SSD persistent disks are
  /// available, the resource name typically ends with "pd-ssd".  The
  /// actual valid values are defined the Google Compute Engine API,
  /// not by the Cloud Dataflow API; consult the Google Compute Engine
  /// documentation for more information about determining the set of
  /// available disk types for a particular project and zone.
  ///
  /// Google Compute Engine Disk types are local to a particular
  /// project in a particular zone, and so the resource name will
  /// typically look something like this:
  ///
  /// compute.googleapis.com/projects/project-id/zones/zone/diskTypes/pd-standard
  core.String diskType;

  /// Directory in a VM where disk is mounted.
  core.String mountPoint;

  /// Size of disk in GB.  If zero or unspecified, the service will
  /// attempt to choose a reasonable default.
  core.int sizeGb;

  Disk();

  Disk.fromJson(core.Map _json) {
    if (_json.containsKey("diskType")) {
      diskType = _json["diskType"];
    }
    if (_json.containsKey("mountPoint")) {
      mountPoint = _json["mountPoint"];
    }
    if (_json.containsKey("sizeGb")) {
      sizeGb = _json["sizeGb"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (diskType != null) {
      _json["diskType"] = diskType;
    }
    if (mountPoint != null) {
      _json["mountPoint"] = mountPoint;
    }
    if (sizeGb != null) {
      _json["sizeGb"] = sizeGb;
    }
    return _json;
  }
}

/// Data provided with a pipeline or transform to provide descriptive info.
class DisplayData {
  /// Contains value if the data is of a boolean type.
  core.bool boolValue;

  /// Contains value if the data is of duration type.
  core.String durationValue;

  /// Contains value if the data is of float type.
  core.double floatValue;

  /// Contains value if the data is of int64 type.
  core.String int64Value;

  /// Contains value if the data is of java class type.
  core.String javaClassValue;

  /// The key identifying the display data.
  /// This is intended to be used as a label for the display data
  /// when viewed in a dax monitoring system.
  core.String key;

  /// An optional label to display in a dax UI for the element.
  core.String label;

  /// The namespace for the key. This is usually a class name or programming
  /// language namespace (i.e. python module) which defines the display data.
  /// This allows a dax monitoring system to specially handle the data
  /// and perform custom rendering.
  core.String namespace;

  /// A possible additional shorter value to display.
  /// For example a java_class_name_value of com.mypackage.MyDoFn
  /// will be stored with MyDoFn as the short_str_value and
  /// com.mypackage.MyDoFn as the java_class_name value.
  /// short_str_value can be displayed and java_class_name_value
  /// will be displayed as a tooltip.
  core.String shortStrValue;

  /// Contains value if the data is of string type.
  core.String strValue;

  /// Contains value if the data is of timestamp type.
  core.String timestampValue;

  /// An optional full URL.
  core.String url;

  DisplayData();

  DisplayData.fromJson(core.Map _json) {
    if (_json.containsKey("boolValue")) {
      boolValue = _json["boolValue"];
    }
    if (_json.containsKey("durationValue")) {
      durationValue = _json["durationValue"];
    }
    if (_json.containsKey("floatValue")) {
      floatValue = _json["floatValue"];
    }
    if (_json.containsKey("int64Value")) {
      int64Value = _json["int64Value"];
    }
    if (_json.containsKey("javaClassValue")) {
      javaClassValue = _json["javaClassValue"];
    }
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("label")) {
      label = _json["label"];
    }
    if (_json.containsKey("namespace")) {
      namespace = _json["namespace"];
    }
    if (_json.containsKey("shortStrValue")) {
      shortStrValue = _json["shortStrValue"];
    }
    if (_json.containsKey("strValue")) {
      strValue = _json["strValue"];
    }
    if (_json.containsKey("timestampValue")) {
      timestampValue = _json["timestampValue"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (boolValue != null) {
      _json["boolValue"] = boolValue;
    }
    if (durationValue != null) {
      _json["durationValue"] = durationValue;
    }
    if (floatValue != null) {
      _json["floatValue"] = floatValue;
    }
    if (int64Value != null) {
      _json["int64Value"] = int64Value;
    }
    if (javaClassValue != null) {
      _json["javaClassValue"] = javaClassValue;
    }
    if (key != null) {
      _json["key"] = key;
    }
    if (label != null) {
      _json["label"] = label;
    }
    if (namespace != null) {
      _json["namespace"] = namespace;
    }
    if (shortStrValue != null) {
      _json["shortStrValue"] = shortStrValue;
    }
    if (strValue != null) {
      _json["strValue"] = strValue;
    }
    if (timestampValue != null) {
      _json["timestampValue"] = timestampValue;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/// A metric value representing a distribution.
class DistributionUpdate {
  /// The count of the number of elements present in the distribution.
  SplitInt64 count;

  /// (Optional) Logarithmic histogram of values.
  /// Each log may be in no more than one bucket. Order does not matter.
  core.List<LogBucket> logBuckets;

  /// The maximum value present in the distribution.
  SplitInt64 max;

  /// The minimum value present in the distribution.
  SplitInt64 min;

  /// Use an int64 since we'd prefer the added precision. If overflow is a
  /// common
  /// problem we can detect it and use an additional int64 or a double.
  SplitInt64 sum;

  /// Use a double since the sum of squares is likely to overflow int64.
  core.double sumOfSquares;

  DistributionUpdate();

  DistributionUpdate.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = new SplitInt64.fromJson(_json["count"]);
    }
    if (_json.containsKey("logBuckets")) {
      logBuckets = _json["logBuckets"]
          .map((value) => new LogBucket.fromJson(value))
          .toList();
    }
    if (_json.containsKey("max")) {
      max = new SplitInt64.fromJson(_json["max"]);
    }
    if (_json.containsKey("min")) {
      min = new SplitInt64.fromJson(_json["min"]);
    }
    if (_json.containsKey("sum")) {
      sum = new SplitInt64.fromJson(_json["sum"]);
    }
    if (_json.containsKey("sumOfSquares")) {
      sumOfSquares = _json["sumOfSquares"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (count != null) {
      _json["count"] = (count).toJson();
    }
    if (logBuckets != null) {
      _json["logBuckets"] =
          logBuckets.map((value) => (value).toJson()).toList();
    }
    if (max != null) {
      _json["max"] = (max).toJson();
    }
    if (min != null) {
      _json["min"] = (min).toJson();
    }
    if (sum != null) {
      _json["sum"] = (sum).toJson();
    }
    if (sumOfSquares != null) {
      _json["sumOfSquares"] = sumOfSquares;
    }
    return _json;
  }
}

/// When a task splits using WorkItemStatus.dynamic_source_split, this
/// message describes the two parts of the split relative to the
/// description of the current task's input.
class DynamicSourceSplit {
  /// Primary part (continued to be processed by worker).
  /// Specified relative to the previously-current source.
  /// Becomes current.
  DerivedSource primary;

  /// Residual part (returned to the pool of work).
  /// Specified relative to the previously-current source.
  DerivedSource residual;

  DynamicSourceSplit();

  DynamicSourceSplit.fromJson(core.Map _json) {
    if (_json.containsKey("primary")) {
      primary = new DerivedSource.fromJson(_json["primary"]);
    }
    if (_json.containsKey("residual")) {
      residual = new DerivedSource.fromJson(_json["residual"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (primary != null) {
      _json["primary"] = (primary).toJson();
    }
    if (residual != null) {
      _json["residual"] = (residual).toJson();
    }
    return _json;
  }
}

/// Describes the environment in which a Dataflow Job runs.
class Environment {
  /// The type of cluster manager API to use.  If unknown or
  /// unspecified, the service will attempt to choose a reasonable
  /// default.  This should be in the form of the API service name,
  /// e.g. "compute.googleapis.com".
  core.String clusterManagerApiService;

  /// The dataset for the current project where various workflow
  /// related tables are stored.
  ///
  /// The supported resource type is:
  ///
  /// Google BigQuery:
  ///   bigquery.googleapis.com/{dataset}
  core.String dataset;

  /// The list of experiments to enable.
  core.List<core.String> experiments;

  /// Experimental settings.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> internalExperiments;

  /// The Cloud Dataflow SDK pipeline options specified by the user. These
  /// options are passed through the service and are used to recreate the
  /// SDK pipeline options on the worker in a language agnostic and platform
  /// independent way.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> sdkPipelineOptions;

  /// Identity to run virtual machines as. Defaults to the default account.
  core.String serviceAccountEmail;

  /// The prefix of the resources the system should use for temporary
  /// storage.  The system will append the suffix "/temp-{JOBNAME} to
  /// this resource prefix, where {JOBNAME} is the value of the
  /// job_name field.  The resulting bucket and object prefix is used
  /// as the prefix of the resources used to store temporary data
  /// needed during the job execution.  NOTE: This will override the
  /// value in taskrunner_settings.
  /// The supported resource type is:
  ///
  /// Google Cloud Storage:
  ///
  ///   storage.googleapis.com/{bucket}/{object}
  ///   bucket.storage.googleapis.com/{object}
  core.String tempStoragePrefix;

  /// A description of the process that generated the request.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> userAgent;

  /// A structure describing which components and their versions of the service
  /// are required in order to run the job.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> version;

  /// The worker pools. At least one "harness" worker pool must be
  /// specified in order for the job to have workers.
  core.List<WorkerPool> workerPools;

  Environment();

  Environment.fromJson(core.Map _json) {
    if (_json.containsKey("clusterManagerApiService")) {
      clusterManagerApiService = _json["clusterManagerApiService"];
    }
    if (_json.containsKey("dataset")) {
      dataset = _json["dataset"];
    }
    if (_json.containsKey("experiments")) {
      experiments = _json["experiments"];
    }
    if (_json.containsKey("internalExperiments")) {
      internalExperiments = _json["internalExperiments"];
    }
    if (_json.containsKey("sdkPipelineOptions")) {
      sdkPipelineOptions = _json["sdkPipelineOptions"];
    }
    if (_json.containsKey("serviceAccountEmail")) {
      serviceAccountEmail = _json["serviceAccountEmail"];
    }
    if (_json.containsKey("tempStoragePrefix")) {
      tempStoragePrefix = _json["tempStoragePrefix"];
    }
    if (_json.containsKey("userAgent")) {
      userAgent = _json["userAgent"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
    if (_json.containsKey("workerPools")) {
      workerPools = _json["workerPools"]
          .map((value) => new WorkerPool.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (clusterManagerApiService != null) {
      _json["clusterManagerApiService"] = clusterManagerApiService;
    }
    if (dataset != null) {
      _json["dataset"] = dataset;
    }
    if (experiments != null) {
      _json["experiments"] = experiments;
    }
    if (internalExperiments != null) {
      _json["internalExperiments"] = internalExperiments;
    }
    if (sdkPipelineOptions != null) {
      _json["sdkPipelineOptions"] = sdkPipelineOptions;
    }
    if (serviceAccountEmail != null) {
      _json["serviceAccountEmail"] = serviceAccountEmail;
    }
    if (tempStoragePrefix != null) {
      _json["tempStoragePrefix"] = tempStoragePrefix;
    }
    if (userAgent != null) {
      _json["userAgent"] = userAgent;
    }
    if (version != null) {
      _json["version"] = version;
    }
    if (workerPools != null) {
      _json["workerPools"] =
          workerPools.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A message describing the state of a particular execution stage.
class ExecutionStageState {
  /// The time at which the stage transitioned to this state.
  core.String currentStateTime;

  /// The name of the execution stage.
  core.String executionStageName;

  /// Executions stage states allow the same set of values as JobState.
  /// Possible string values are:
  /// - "JOB_STATE_UNKNOWN" : The job's run state isn't specified.
  /// - "JOB_STATE_STOPPED" : `JOB_STATE_STOPPED` indicates that the job has not
  /// yet started to run.
  /// - "JOB_STATE_RUNNING" : `JOB_STATE_RUNNING` indicates that the job is
  /// currently running.
  /// - "JOB_STATE_DONE" : `JOB_STATE_DONE` indicates that the job has
  /// successfully completed.
  /// This is a terminal job state.  This state may be set by the Cloud Dataflow
  /// service, as a transition from `JOB_STATE_RUNNING`. It may also be set via
  /// a
  /// Cloud Dataflow `UpdateJob` call, if the job has not yet reached a terminal
  /// state.
  /// - "JOB_STATE_FAILED" : `JOB_STATE_FAILED` indicates that the job has
  /// failed.  This is a
  /// terminal job state.  This state may only be set by the Cloud Dataflow
  /// service, and only as a transition from `JOB_STATE_RUNNING`.
  /// - "JOB_STATE_CANCELLED" : `JOB_STATE_CANCELLED` indicates that the job has
  /// been explicitly
  /// cancelled. This is a terminal job state. This state may only be
  /// set via a Cloud Dataflow `UpdateJob` call, and only if the job has not
  /// yet reached another terminal state.
  /// - "JOB_STATE_UPDATED" : `JOB_STATE_UPDATED` indicates that the job was
  /// successfully updated,
  /// meaning that this job was stopped and another job was started, inheriting
  /// state from this one. This is a terminal job state. This state may only be
  /// set by the Cloud Dataflow service, and only as a transition from
  /// `JOB_STATE_RUNNING`.
  /// - "JOB_STATE_DRAINING" : `JOB_STATE_DRAINING` indicates that the job is in
  /// the process of draining.
  /// A draining job has stopped pulling from its input sources and is
  /// processing
  /// any data that remains in-flight. This state may be set via a Cloud
  /// Dataflow
  /// `UpdateJob` call, but only as a transition from `JOB_STATE_RUNNING`. Jobs
  /// that are draining may only transition to `JOB_STATE_DRAINED`,
  /// `JOB_STATE_CANCELLED`, or `JOB_STATE_FAILED`.
  /// - "JOB_STATE_DRAINED" : `JOB_STATE_DRAINED` indicates that the job has
  /// been drained.
  /// A drained job terminated by stopping pulling from its input sources and
  /// processing any data that remained in-flight when draining was requested.
  /// This state is a terminal state, may only be set by the Cloud Dataflow
  /// service, and only as a transition from `JOB_STATE_DRAINING`.
  /// - "JOB_STATE_PENDING" : 'JOB_STATE_PENDING' indicates that the job has
  /// been created but is not yet
  /// running.  Jobs that are pending may only transition to
  /// `JOB_STATE_RUNNING`,
  /// or `JOB_STATE_FAILED`.
  /// - "JOB_STATE_CANCELLING" : 'JOB_STATE_CANCELLING' indicates that the job
  /// has been explicitly cancelled
  /// and is in the process of stopping.  Jobs that are cancelling may only
  /// transition to 'JOB_STATE_CANCELLED' or 'JOB_STATE_FAILED'.
  core.String executionStageState;

  ExecutionStageState();

  ExecutionStageState.fromJson(core.Map _json) {
    if (_json.containsKey("currentStateTime")) {
      currentStateTime = _json["currentStateTime"];
    }
    if (_json.containsKey("executionStageName")) {
      executionStageName = _json["executionStageName"];
    }
    if (_json.containsKey("executionStageState")) {
      executionStageState = _json["executionStageState"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (currentStateTime != null) {
      _json["currentStateTime"] = currentStateTime;
    }
    if (executionStageName != null) {
      _json["executionStageName"] = executionStageName;
    }
    if (executionStageState != null) {
      _json["executionStageState"] = executionStageState;
    }
    return _json;
  }
}

/// Description of the composing transforms, names/ids, and input/outputs of a
/// stage of execution.  Some composing transforms and sources may have been
/// generated by the Dataflow service during execution planning.
class ExecutionStageSummary {
  /// Collections produced and consumed by component transforms of this stage.
  core.List<ComponentSource> componentSource;

  /// Transforms that comprise this execution stage.
  core.List<ComponentTransform> componentTransform;

  /// Dataflow service generated id for this stage.
  core.String id;

  /// Input sources for this stage.
  core.List<StageSource> inputSource;

  /// Type of tranform this stage is executing.
  /// Possible string values are:
  /// - "UNKNOWN_KIND" : Unrecognized transform type.
  /// - "PAR_DO_KIND" : ParDo transform.
  /// - "GROUP_BY_KEY_KIND" : Group By Key transform.
  /// - "FLATTEN_KIND" : Flatten transform.
  /// - "READ_KIND" : Read transform.
  /// - "WRITE_KIND" : Write transform.
  /// - "CONSTANT_KIND" : Constructs from a constant value, such as with
  /// Create.of.
  /// - "SINGLETON_KIND" : Creates a Singleton view of a collection.
  /// - "SHUFFLE_KIND" : Opening or closing a shuffle session, often as part of
  /// a GroupByKey.
  core.String kind;

  /// Dataflow service generated name for this stage.
  core.String name;

  /// Output sources for this stage.
  core.List<StageSource> outputSource;

  ExecutionStageSummary();

  ExecutionStageSummary.fromJson(core.Map _json) {
    if (_json.containsKey("componentSource")) {
      componentSource = _json["componentSource"]
          .map((value) => new ComponentSource.fromJson(value))
          .toList();
    }
    if (_json.containsKey("componentTransform")) {
      componentTransform = _json["componentTransform"]
          .map((value) => new ComponentTransform.fromJson(value))
          .toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("inputSource")) {
      inputSource = _json["inputSource"]
          .map((value) => new StageSource.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("outputSource")) {
      outputSource = _json["outputSource"]
          .map((value) => new StageSource.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (componentSource != null) {
      _json["componentSource"] =
          componentSource.map((value) => (value).toJson()).toList();
    }
    if (componentTransform != null) {
      _json["componentTransform"] =
          componentTransform.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (inputSource != null) {
      _json["inputSource"] =
          inputSource.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (outputSource != null) {
      _json["outputSource"] =
          outputSource.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Indicates which location failed to respond to a request for data.
class FailedLocation {
  /// The name of the failed location.
  core.String name;

  FailedLocation();

  FailedLocation.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/// An instruction that copies its inputs (zero or more) to its (single) output.
class FlattenInstruction {
  /// Describes the inputs to the flatten instruction.
  core.List<InstructionInput> inputs;

  FlattenInstruction();

  FlattenInstruction.fromJson(core.Map _json) {
    if (_json.containsKey("inputs")) {
      inputs = _json["inputs"]
          .map((value) => new InstructionInput.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (inputs != null) {
      _json["inputs"] = inputs.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A metric value representing a list of floating point numbers.
class FloatingPointList {
  /// Elements of the list.
  core.List<core.double> elements;

  FloatingPointList();

  FloatingPointList.fromJson(core.Map _json) {
    if (_json.containsKey("elements")) {
      elements = _json["elements"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (elements != null) {
      _json["elements"] = elements;
    }
    return _json;
  }
}

/// A representation of a floating point mean metric contribution.
class FloatingPointMean {
  /// The number of values being aggregated.
  SplitInt64 count;

  /// The sum of all values being aggregated.
  core.double sum;

  FloatingPointMean();

  FloatingPointMean.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = new SplitInt64.fromJson(_json["count"]);
    }
    if (_json.containsKey("sum")) {
      sum = _json["sum"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (count != null) {
      _json["count"] = (count).toJson();
    }
    if (sum != null) {
      _json["sum"] = sum;
    }
    return _json;
  }
}

/// Request to get updated debug configuration for component.
class GetDebugConfigRequest {
  /// The internal component id for which debug configuration is
  /// requested.
  core.String componentId;

  /// The location which contains the job specified by job_id.
  core.String location;

  /// The worker id, i.e., VM hostname.
  core.String workerId;

  GetDebugConfigRequest();

  GetDebugConfigRequest.fromJson(core.Map _json) {
    if (_json.containsKey("componentId")) {
      componentId = _json["componentId"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("workerId")) {
      workerId = _json["workerId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (componentId != null) {
      _json["componentId"] = componentId;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (workerId != null) {
      _json["workerId"] = workerId;
    }
    return _json;
  }
}

/// Response to a get debug configuration request.
class GetDebugConfigResponse {
  /// The encoded debug configuration for the requested component.
  core.String config;

  GetDebugConfigResponse();

  GetDebugConfigResponse.fromJson(core.Map _json) {
    if (_json.containsKey("config")) {
      config = _json["config"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (config != null) {
      _json["config"] = config;
    }
    return _json;
  }
}

/// The response to a GetTemplate request.
class GetTemplateResponse {
  /// The template metadata describing the template name, available
  /// parameters, etc.
  TemplateMetadata metadata;

  /// The status of the get template request. Any problems with the
  /// request will be indicated in the error_details.
  Status status;

  GetTemplateResponse();

  GetTemplateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("metadata")) {
      metadata = new TemplateMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("status")) {
      status = new Status.fromJson(_json["status"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    return _json;
  }
}

/// An input of an instruction, as a reference to an output of a
/// producer instruction.
class InstructionInput {
  /// The output index (origin zero) within the producer.
  core.int outputNum;

  /// The index (origin zero) of the parallel instruction that produces
  /// the output to be consumed by this input.  This index is relative
  /// to the list of instructions in this input's instruction's
  /// containing MapTask.
  core.int producerInstructionIndex;

  InstructionInput();

  InstructionInput.fromJson(core.Map _json) {
    if (_json.containsKey("outputNum")) {
      outputNum = _json["outputNum"];
    }
    if (_json.containsKey("producerInstructionIndex")) {
      producerInstructionIndex = _json["producerInstructionIndex"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (outputNum != null) {
      _json["outputNum"] = outputNum;
    }
    if (producerInstructionIndex != null) {
      _json["producerInstructionIndex"] = producerInstructionIndex;
    }
    return _json;
  }
}

/// An output of an instruction.
class InstructionOutput {
  /// The codec to use to encode data being written via this output.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> codec;

  /// The user-provided name of this output.
  core.String name;

  /// For system-generated byte and mean byte metrics, certain instructions
  /// should only report the key size.
  core.bool onlyCountKeyBytes;

  /// For system-generated byte and mean byte metrics, certain instructions
  /// should only report the value size.
  core.bool onlyCountValueBytes;

  /// System-defined name for this output in the original workflow graph.
  /// Outputs that do not contribute to an original instruction do not set this.
  core.String originalName;

  /// System-defined name of this output.
  /// Unique across the workflow.
  core.String systemName;

  InstructionOutput();

  InstructionOutput.fromJson(core.Map _json) {
    if (_json.containsKey("codec")) {
      codec = _json["codec"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("onlyCountKeyBytes")) {
      onlyCountKeyBytes = _json["onlyCountKeyBytes"];
    }
    if (_json.containsKey("onlyCountValueBytes")) {
      onlyCountValueBytes = _json["onlyCountValueBytes"];
    }
    if (_json.containsKey("originalName")) {
      originalName = _json["originalName"];
    }
    if (_json.containsKey("systemName")) {
      systemName = _json["systemName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (codec != null) {
      _json["codec"] = codec;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (onlyCountKeyBytes != null) {
      _json["onlyCountKeyBytes"] = onlyCountKeyBytes;
    }
    if (onlyCountValueBytes != null) {
      _json["onlyCountValueBytes"] = onlyCountValueBytes;
    }
    if (originalName != null) {
      _json["originalName"] = originalName;
    }
    if (systemName != null) {
      _json["systemName"] = systemName;
    }
    return _json;
  }
}

/// A metric value representing a list of integers.
class IntegerList {
  /// Elements of the list.
  core.List<SplitInt64> elements;

  IntegerList();

  IntegerList.fromJson(core.Map _json) {
    if (_json.containsKey("elements")) {
      elements = _json["elements"]
          .map((value) => new SplitInt64.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (elements != null) {
      _json["elements"] = elements.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A representation of an integer mean metric contribution.
class IntegerMean {
  /// The number of values being aggregated.
  SplitInt64 count;

  /// The sum of all values being aggregated.
  SplitInt64 sum;

  IntegerMean();

  IntegerMean.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = new SplitInt64.fromJson(_json["count"]);
    }
    if (_json.containsKey("sum")) {
      sum = new SplitInt64.fromJson(_json["sum"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (count != null) {
      _json["count"] = (count).toJson();
    }
    if (sum != null) {
      _json["sum"] = (sum).toJson();
    }
    return _json;
  }
}

/// Defines a job to be run by the Cloud Dataflow service.
class Job {
  /// The client's unique identifier of the job, re-used across retried
  /// attempts.
  /// If this field is set, the service will ensure its uniqueness.
  /// The request to create a job will fail if the service has knowledge of a
  /// previously submitted job with the same client's ID and job name.
  /// The caller may use this field to ensure idempotence of job
  /// creation across retried attempts to create a job.
  /// By default, the field is empty and, in that case, the service ignores it.
  core.String clientRequestId;

  /// The timestamp when the job was initially created. Immutable and set by the
  /// Cloud Dataflow service.
  core.String createTime;

  /// The current state of the job.
  ///
  /// Jobs are created in the `JOB_STATE_STOPPED` state unless otherwise
  /// specified.
  ///
  /// A job in the `JOB_STATE_RUNNING` state may asynchronously enter a
  /// terminal state. After a job has reached a terminal state, no
  /// further state updates may be made.
  ///
  /// This field may be mutated by the Cloud Dataflow service;
  /// callers cannot mutate it.
  /// Possible string values are:
  /// - "JOB_STATE_UNKNOWN" : The job's run state isn't specified.
  /// - "JOB_STATE_STOPPED" : `JOB_STATE_STOPPED` indicates that the job has not
  /// yet started to run.
  /// - "JOB_STATE_RUNNING" : `JOB_STATE_RUNNING` indicates that the job is
  /// currently running.
  /// - "JOB_STATE_DONE" : `JOB_STATE_DONE` indicates that the job has
  /// successfully completed.
  /// This is a terminal job state.  This state may be set by the Cloud Dataflow
  /// service, as a transition from `JOB_STATE_RUNNING`. It may also be set via
  /// a
  /// Cloud Dataflow `UpdateJob` call, if the job has not yet reached a terminal
  /// state.
  /// - "JOB_STATE_FAILED" : `JOB_STATE_FAILED` indicates that the job has
  /// failed.  This is a
  /// terminal job state.  This state may only be set by the Cloud Dataflow
  /// service, and only as a transition from `JOB_STATE_RUNNING`.
  /// - "JOB_STATE_CANCELLED" : `JOB_STATE_CANCELLED` indicates that the job has
  /// been explicitly
  /// cancelled. This is a terminal job state. This state may only be
  /// set via a Cloud Dataflow `UpdateJob` call, and only if the job has not
  /// yet reached another terminal state.
  /// - "JOB_STATE_UPDATED" : `JOB_STATE_UPDATED` indicates that the job was
  /// successfully updated,
  /// meaning that this job was stopped and another job was started, inheriting
  /// state from this one. This is a terminal job state. This state may only be
  /// set by the Cloud Dataflow service, and only as a transition from
  /// `JOB_STATE_RUNNING`.
  /// - "JOB_STATE_DRAINING" : `JOB_STATE_DRAINING` indicates that the job is in
  /// the process of draining.
  /// A draining job has stopped pulling from its input sources and is
  /// processing
  /// any data that remains in-flight. This state may be set via a Cloud
  /// Dataflow
  /// `UpdateJob` call, but only as a transition from `JOB_STATE_RUNNING`. Jobs
  /// that are draining may only transition to `JOB_STATE_DRAINED`,
  /// `JOB_STATE_CANCELLED`, or `JOB_STATE_FAILED`.
  /// - "JOB_STATE_DRAINED" : `JOB_STATE_DRAINED` indicates that the job has
  /// been drained.
  /// A drained job terminated by stopping pulling from its input sources and
  /// processing any data that remained in-flight when draining was requested.
  /// This state is a terminal state, may only be set by the Cloud Dataflow
  /// service, and only as a transition from `JOB_STATE_DRAINING`.
  /// - "JOB_STATE_PENDING" : 'JOB_STATE_PENDING' indicates that the job has
  /// been created but is not yet
  /// running.  Jobs that are pending may only transition to
  /// `JOB_STATE_RUNNING`,
  /// or `JOB_STATE_FAILED`.
  /// - "JOB_STATE_CANCELLING" : 'JOB_STATE_CANCELLING' indicates that the job
  /// has been explicitly cancelled
  /// and is in the process of stopping.  Jobs that are cancelling may only
  /// transition to 'JOB_STATE_CANCELLED' or 'JOB_STATE_FAILED'.
  core.String currentState;

  /// The timestamp associated with the current state.
  core.String currentStateTime;

  /// The environment for the job.
  Environment environment;

  /// Deprecated.
  JobExecutionInfo executionInfo;

  /// The unique ID of this job.
  ///
  /// This field is set by the Cloud Dataflow service when the Job is
  /// created, and is immutable for the life of the job.
  core.String id;

  /// User-defined labels for this job.
  ///
  /// The labels map can contain no more than 64 entries.  Entries of the labels
  /// map are UTF8 strings that comply with the following restrictions:
  ///
  /// * Keys must conform to regexp:  \p{Ll}\p{Lo}{0,62}
  /// * Values must conform to regexp:  [\p{Ll}\p{Lo}\p{N}_-]{0,63}
  /// * Both keys and values are additionally constrained to be <= 128 bytes in
  /// size.
  core.Map<core.String, core.String> labels;

  /// The location that contains this job.
  core.String location;

  /// The user-specified Cloud Dataflow job name.
  ///
  /// Only one Job with a given name may exist in a project at any
  /// given time. If a caller attempts to create a Job with the same
  /// name as an already-existing Job, the attempt returns the
  /// existing Job.
  ///
  /// The name must match the regular expression
  /// `[a-z]([-a-z0-9]{0,38}[a-z0-9])?`
  core.String name;

  /// Preliminary field: The format of this data may change at any time.
  /// A description of the user pipeline and stages through which it is
  /// executed.
  /// Created by Cloud Dataflow service.  Only retrieved with
  /// JOB_VIEW_DESCRIPTION or JOB_VIEW_ALL.
  PipelineDescription pipelineDescription;

  /// The ID of the Cloud Platform project that the job belongs to.
  core.String projectId;

  /// If this job is an update of an existing job, this field is the job ID
  /// of the job it replaced.
  ///
  /// When sending a `CreateJobRequest`, you can update a job by specifying it
  /// here. The job named here is stopped, and its intermediate state is
  /// transferred to this job.
  core.String replaceJobId;

  /// If another job is an update of this job (and thus, this job is in
  /// `JOB_STATE_UPDATED`), this field contains the ID of that job.
  core.String replacedByJobId;

  /// The job's requested state.
  ///
  /// `UpdateJob` may be used to switch between the `JOB_STATE_STOPPED` and
  /// `JOB_STATE_RUNNING` states, by setting requested_state.  `UpdateJob` may
  /// also be used to directly set a job's requested state to
  /// `JOB_STATE_CANCELLED` or `JOB_STATE_DONE`, irrevocably terminating the
  /// job if it has not already reached a terminal state.
  /// Possible string values are:
  /// - "JOB_STATE_UNKNOWN" : The job's run state isn't specified.
  /// - "JOB_STATE_STOPPED" : `JOB_STATE_STOPPED` indicates that the job has not
  /// yet started to run.
  /// - "JOB_STATE_RUNNING" : `JOB_STATE_RUNNING` indicates that the job is
  /// currently running.
  /// - "JOB_STATE_DONE" : `JOB_STATE_DONE` indicates that the job has
  /// successfully completed.
  /// This is a terminal job state.  This state may be set by the Cloud Dataflow
  /// service, as a transition from `JOB_STATE_RUNNING`. It may also be set via
  /// a
  /// Cloud Dataflow `UpdateJob` call, if the job has not yet reached a terminal
  /// state.
  /// - "JOB_STATE_FAILED" : `JOB_STATE_FAILED` indicates that the job has
  /// failed.  This is a
  /// terminal job state.  This state may only be set by the Cloud Dataflow
  /// service, and only as a transition from `JOB_STATE_RUNNING`.
  /// - "JOB_STATE_CANCELLED" : `JOB_STATE_CANCELLED` indicates that the job has
  /// been explicitly
  /// cancelled. This is a terminal job state. This state may only be
  /// set via a Cloud Dataflow `UpdateJob` call, and only if the job has not
  /// yet reached another terminal state.
  /// - "JOB_STATE_UPDATED" : `JOB_STATE_UPDATED` indicates that the job was
  /// successfully updated,
  /// meaning that this job was stopped and another job was started, inheriting
  /// state from this one. This is a terminal job state. This state may only be
  /// set by the Cloud Dataflow service, and only as a transition from
  /// `JOB_STATE_RUNNING`.
  /// - "JOB_STATE_DRAINING" : `JOB_STATE_DRAINING` indicates that the job is in
  /// the process of draining.
  /// A draining job has stopped pulling from its input sources and is
  /// processing
  /// any data that remains in-flight. This state may be set via a Cloud
  /// Dataflow
  /// `UpdateJob` call, but only as a transition from `JOB_STATE_RUNNING`. Jobs
  /// that are draining may only transition to `JOB_STATE_DRAINED`,
  /// `JOB_STATE_CANCELLED`, or `JOB_STATE_FAILED`.
  /// - "JOB_STATE_DRAINED" : `JOB_STATE_DRAINED` indicates that the job has
  /// been drained.
  /// A drained job terminated by stopping pulling from its input sources and
  /// processing any data that remained in-flight when draining was requested.
  /// This state is a terminal state, may only be set by the Cloud Dataflow
  /// service, and only as a transition from `JOB_STATE_DRAINING`.
  /// - "JOB_STATE_PENDING" : 'JOB_STATE_PENDING' indicates that the job has
  /// been created but is not yet
  /// running.  Jobs that are pending may only transition to
  /// `JOB_STATE_RUNNING`,
  /// or `JOB_STATE_FAILED`.
  /// - "JOB_STATE_CANCELLING" : 'JOB_STATE_CANCELLING' indicates that the job
  /// has been explicitly cancelled
  /// and is in the process of stopping.  Jobs that are cancelling may only
  /// transition to 'JOB_STATE_CANCELLED' or 'JOB_STATE_FAILED'.
  core.String requestedState;

  /// This field may be mutated by the Cloud Dataflow service;
  /// callers cannot mutate it.
  core.List<ExecutionStageState> stageStates;

  /// The top-level steps that constitute the entire job.
  core.List<Step> steps;

  /// A set of files the system should be aware of that are used
  /// for temporary storage. These temporary files will be
  /// removed on job completion.
  /// No duplicates are allowed.
  /// No file patterns are supported.
  ///
  /// The supported files are:
  ///
  /// Google Cloud Storage:
  ///
  ///    storage.googleapis.com/{bucket}/{object}
  ///    bucket.storage.googleapis.com/{object}
  core.List<core.String> tempFiles;

  /// The map of transform name prefixes of the job to be replaced to the
  /// corresponding name prefixes of the new job.
  core.Map<core.String, core.String> transformNameMapping;

  /// The type of Cloud Dataflow job.
  /// Possible string values are:
  /// - "JOB_TYPE_UNKNOWN" : The type of the job is unspecified, or unknown.
  /// - "JOB_TYPE_BATCH" : A batch job with a well-defined end point: data is
  /// read, data is
  /// processed, data is written, and the job is done.
  /// - "JOB_TYPE_STREAMING" : A continuously streaming job with no end: data is
  /// read,
  /// processed, and written continuously.
  core.String type;

  Job();

  Job.fromJson(core.Map _json) {
    if (_json.containsKey("clientRequestId")) {
      clientRequestId = _json["clientRequestId"];
    }
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("currentState")) {
      currentState = _json["currentState"];
    }
    if (_json.containsKey("currentStateTime")) {
      currentStateTime = _json["currentStateTime"];
    }
    if (_json.containsKey("environment")) {
      environment = new Environment.fromJson(_json["environment"]);
    }
    if (_json.containsKey("executionInfo")) {
      executionInfo = new JobExecutionInfo.fromJson(_json["executionInfo"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("pipelineDescription")) {
      pipelineDescription =
          new PipelineDescription.fromJson(_json["pipelineDescription"]);
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("replaceJobId")) {
      replaceJobId = _json["replaceJobId"];
    }
    if (_json.containsKey("replacedByJobId")) {
      replacedByJobId = _json["replacedByJobId"];
    }
    if (_json.containsKey("requestedState")) {
      requestedState = _json["requestedState"];
    }
    if (_json.containsKey("stageStates")) {
      stageStates = _json["stageStates"]
          .map((value) => new ExecutionStageState.fromJson(value))
          .toList();
    }
    if (_json.containsKey("steps")) {
      steps = _json["steps"].map((value) => new Step.fromJson(value)).toList();
    }
    if (_json.containsKey("tempFiles")) {
      tempFiles = _json["tempFiles"];
    }
    if (_json.containsKey("transformNameMapping")) {
      transformNameMapping = _json["transformNameMapping"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (clientRequestId != null) {
      _json["clientRequestId"] = clientRequestId;
    }
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (currentState != null) {
      _json["currentState"] = currentState;
    }
    if (currentStateTime != null) {
      _json["currentStateTime"] = currentStateTime;
    }
    if (environment != null) {
      _json["environment"] = (environment).toJson();
    }
    if (executionInfo != null) {
      _json["executionInfo"] = (executionInfo).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (pipelineDescription != null) {
      _json["pipelineDescription"] = (pipelineDescription).toJson();
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (replaceJobId != null) {
      _json["replaceJobId"] = replaceJobId;
    }
    if (replacedByJobId != null) {
      _json["replacedByJobId"] = replacedByJobId;
    }
    if (requestedState != null) {
      _json["requestedState"] = requestedState;
    }
    if (stageStates != null) {
      _json["stageStates"] =
          stageStates.map((value) => (value).toJson()).toList();
    }
    if (steps != null) {
      _json["steps"] = steps.map((value) => (value).toJson()).toList();
    }
    if (tempFiles != null) {
      _json["tempFiles"] = tempFiles;
    }
    if (transformNameMapping != null) {
      _json["transformNameMapping"] = transformNameMapping;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/// Additional information about how a Cloud Dataflow job will be executed that
/// isn't contained in the submitted job.
class JobExecutionInfo {
  /// A mapping from each stage to the information about that stage.
  core.Map<core.String, JobExecutionStageInfo> stages;

  JobExecutionInfo();

  JobExecutionInfo.fromJson(core.Map _json) {
    if (_json.containsKey("stages")) {
      stages = commons
          .mapMap<core.Map<core.String, core.Object>, JobExecutionStageInfo>(
              _json["stages"],
              (core.Map<core.String, core.Object> item) =>
                  new JobExecutionStageInfo.fromJson(item));
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (stages != null) {
      _json["stages"] = commons
          .mapMap<JobExecutionStageInfo, core.Map<core.String, core.Object>>(
              stages, (JobExecutionStageInfo item) => (item).toJson());
    }
    return _json;
  }
}

/// Contains information about how a particular
/// google.dataflow.v1beta3.Step will be executed.
class JobExecutionStageInfo {
  /// The steps associated with the execution stage.
  /// Note that stages may have several steps, and that a given step
  /// might be run by more than one stage.
  core.List<core.String> stepName;

  JobExecutionStageInfo();

  JobExecutionStageInfo.fromJson(core.Map _json) {
    if (_json.containsKey("stepName")) {
      stepName = _json["stepName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (stepName != null) {
      _json["stepName"] = stepName;
    }
    return _json;
  }
}

/// A particular message pertaining to a Dataflow job.
class JobMessage {
  /// Deprecated.
  core.String id;

  /// Importance level of the message.
  /// Possible string values are:
  /// - "JOB_MESSAGE_IMPORTANCE_UNKNOWN" : The message importance isn't
  /// specified, or is unknown.
  /// - "JOB_MESSAGE_DEBUG" : The message is at the 'debug' level: typically
  /// only useful for
  /// software engineers working on the code the job is running.
  /// Typically, Dataflow pipeline runners do not display log messages
  /// at this level by default.
  /// - "JOB_MESSAGE_DETAILED" : The message is at the 'detailed' level:
  /// somewhat verbose, but
  /// potentially useful to users.  Typically, Dataflow pipeline
  /// runners do not display log messages at this level by default.
  /// These messages are displayed by default in the Dataflow
  /// monitoring UI.
  /// - "JOB_MESSAGE_BASIC" : The message is at the 'basic' level: useful for
  /// keeping
  /// track of the execution of a Dataflow pipeline.  Typically,
  /// Dataflow pipeline runners display log messages at this level by
  /// default, and these messages are displayed by default in the
  /// Dataflow monitoring UI.
  /// - "JOB_MESSAGE_WARNING" : The message is at the 'warning' level:
  /// indicating a condition
  /// pertaining to a job which may require human intervention.
  /// Typically, Dataflow pipeline runners display log messages at this
  /// level by default, and these messages are displayed by default in
  /// the Dataflow monitoring UI.
  /// - "JOB_MESSAGE_ERROR" : The message is at the 'error' level: indicating a
  /// condition
  /// preventing a job from succeeding.  Typically, Dataflow pipeline
  /// runners display log messages at this level by default, and these
  /// messages are displayed by default in the Dataflow monitoring UI.
  core.String messageImportance;

  /// The text of the message.
  core.String messageText;

  /// The timestamp of the message.
  core.String time;

  JobMessage();

  JobMessage.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("messageImportance")) {
      messageImportance = _json["messageImportance"];
    }
    if (_json.containsKey("messageText")) {
      messageText = _json["messageText"];
    }
    if (_json.containsKey("time")) {
      time = _json["time"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (id != null) {
      _json["id"] = id;
    }
    if (messageImportance != null) {
      _json["messageImportance"] = messageImportance;
    }
    if (messageText != null) {
      _json["messageText"] = messageText;
    }
    if (time != null) {
      _json["time"] = time;
    }
    return _json;
  }
}

/// JobMetrics contains a collection of metrics descibing the detailed progress
/// of a Dataflow job. Metrics correspond to user-defined and system-defined
/// metrics in the job.
///
/// This resource captures only the most recent values of each metric;
/// time-series data can be queried for them (under the same metric names)
/// from Cloud Monitoring.
class JobMetrics {
  /// Timestamp as of which metric values are current.
  core.String metricTime;

  /// All metrics for this job.
  core.List<MetricUpdate> metrics;

  JobMetrics();

  JobMetrics.fromJson(core.Map _json) {
    if (_json.containsKey("metricTime")) {
      metricTime = _json["metricTime"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"]
          .map((value) => new MetricUpdate.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (metricTime != null) {
      _json["metricTime"] = metricTime;
    }
    if (metrics != null) {
      _json["metrics"] = metrics.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Data disk assignment information for a specific key-range of a sharded
/// computation.
/// Currently we only support UTF-8 character splits to simplify encoding into
/// JSON.
class KeyRangeDataDiskAssignment {
  /// The name of the data disk where data for this range is stored.
  /// This name is local to the Google Cloud Platform project and uniquely
  /// identifies the disk within that project, for example
  /// "myproject-1014-104817-4c2-harness-0-disk-1".
  core.String dataDisk;

  /// The end (exclusive) of the key range.
  core.String end;

  /// The start (inclusive) of the key range.
  core.String start;

  KeyRangeDataDiskAssignment();

  KeyRangeDataDiskAssignment.fromJson(core.Map _json) {
    if (_json.containsKey("dataDisk")) {
      dataDisk = _json["dataDisk"];
    }
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (dataDisk != null) {
      _json["dataDisk"] = dataDisk;
    }
    if (end != null) {
      _json["end"] = end;
    }
    if (start != null) {
      _json["start"] = start;
    }
    return _json;
  }
}

/// Location information for a specific key-range of a sharded computation.
/// Currently we only support UTF-8 character splits to simplify encoding into
/// JSON.
class KeyRangeLocation {
  /// The name of the data disk where data for this range is stored.
  /// This name is local to the Google Cloud Platform project and uniquely
  /// identifies the disk within that project, for example
  /// "myproject-1014-104817-4c2-harness-0-disk-1".
  core.String dataDisk;

  /// The physical location of this range assignment to be used for
  /// streaming computation cross-worker message delivery.
  core.String deliveryEndpoint;

  /// DEPRECATED. The location of the persistent state for this range, as a
  /// persistent directory in the worker local filesystem.
  core.String deprecatedPersistentDirectory;

  /// The end (exclusive) of the key range.
  core.String end;

  /// The start (inclusive) of the key range.
  core.String start;

  KeyRangeLocation();

  KeyRangeLocation.fromJson(core.Map _json) {
    if (_json.containsKey("dataDisk")) {
      dataDisk = _json["dataDisk"];
    }
    if (_json.containsKey("deliveryEndpoint")) {
      deliveryEndpoint = _json["deliveryEndpoint"];
    }
    if (_json.containsKey("deprecatedPersistentDirectory")) {
      deprecatedPersistentDirectory = _json["deprecatedPersistentDirectory"];
    }
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (dataDisk != null) {
      _json["dataDisk"] = dataDisk;
    }
    if (deliveryEndpoint != null) {
      _json["deliveryEndpoint"] = deliveryEndpoint;
    }
    if (deprecatedPersistentDirectory != null) {
      _json["deprecatedPersistentDirectory"] = deprecatedPersistentDirectory;
    }
    if (end != null) {
      _json["end"] = end;
    }
    if (start != null) {
      _json["start"] = start;
    }
    return _json;
  }
}

/// Parameters to provide to the template being launched.
class LaunchTemplateParameters {
  /// The runtime environment for the job.
  RuntimeEnvironment environment;

  /// Required. The job name to use for the created job.
  core.String jobName;

  /// The runtime parameters to pass to the job.
  core.Map<core.String, core.String> parameters;

  LaunchTemplateParameters();

  LaunchTemplateParameters.fromJson(core.Map _json) {
    if (_json.containsKey("environment")) {
      environment = new RuntimeEnvironment.fromJson(_json["environment"]);
    }
    if (_json.containsKey("jobName")) {
      jobName = _json["jobName"];
    }
    if (_json.containsKey("parameters")) {
      parameters = _json["parameters"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (environment != null) {
      _json["environment"] = (environment).toJson();
    }
    if (jobName != null) {
      _json["jobName"] = jobName;
    }
    if (parameters != null) {
      _json["parameters"] = parameters;
    }
    return _json;
  }
}

/// Response to the request to launch a template.
class LaunchTemplateResponse {
  /// The job that was launched, if the request was not a dry run and
  /// the job was successfully launched.
  Job job;

  LaunchTemplateResponse();

  LaunchTemplateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("job")) {
      job = new Job.fromJson(_json["job"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (job != null) {
      _json["job"] = (job).toJson();
    }
    return _json;
  }
}

/// Request to lease WorkItems.
class LeaseWorkItemRequest {
  /// The current timestamp at the worker.
  core.String currentWorkerTime;

  /// The location which contains the WorkItem's job.
  core.String location;

  /// The initial lease period.
  core.String requestedLeaseDuration;

  /// Filter for WorkItem type.
  core.List<core.String> workItemTypes;

  /// Worker capabilities. WorkItems might be limited to workers with specific
  /// capabilities.
  core.List<core.String> workerCapabilities;

  /// Identifies the worker leasing work -- typically the ID of the
  /// virtual machine running the worker.
  core.String workerId;

  LeaseWorkItemRequest();

  LeaseWorkItemRequest.fromJson(core.Map _json) {
    if (_json.containsKey("currentWorkerTime")) {
      currentWorkerTime = _json["currentWorkerTime"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("requestedLeaseDuration")) {
      requestedLeaseDuration = _json["requestedLeaseDuration"];
    }
    if (_json.containsKey("workItemTypes")) {
      workItemTypes = _json["workItemTypes"];
    }
    if (_json.containsKey("workerCapabilities")) {
      workerCapabilities = _json["workerCapabilities"];
    }
    if (_json.containsKey("workerId")) {
      workerId = _json["workerId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (currentWorkerTime != null) {
      _json["currentWorkerTime"] = currentWorkerTime;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (requestedLeaseDuration != null) {
      _json["requestedLeaseDuration"] = requestedLeaseDuration;
    }
    if (workItemTypes != null) {
      _json["workItemTypes"] = workItemTypes;
    }
    if (workerCapabilities != null) {
      _json["workerCapabilities"] = workerCapabilities;
    }
    if (workerId != null) {
      _json["workerId"] = workerId;
    }
    return _json;
  }
}

/// Response to a request to lease WorkItems.
class LeaseWorkItemResponse {
  /// A list of the leased WorkItems.
  core.List<WorkItem> workItems;

  LeaseWorkItemResponse();

  LeaseWorkItemResponse.fromJson(core.Map _json) {
    if (_json.containsKey("workItems")) {
      workItems = _json["workItems"]
          .map((value) => new WorkItem.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (workItems != null) {
      _json["workItems"] = workItems.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Response to a request to list job messages.
class ListJobMessagesResponse {
  /// Autoscaling events in ascending timestamp order.
  core.List<AutoscalingEvent> autoscalingEvents;

  /// Messages in ascending timestamp order.
  core.List<JobMessage> jobMessages;

  /// The token to obtain the next page of results if there are more.
  core.String nextPageToken;

  ListJobMessagesResponse();

  ListJobMessagesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("autoscalingEvents")) {
      autoscalingEvents = _json["autoscalingEvents"]
          .map((value) => new AutoscalingEvent.fromJson(value))
          .toList();
    }
    if (_json.containsKey("jobMessages")) {
      jobMessages = _json["jobMessages"]
          .map((value) => new JobMessage.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (autoscalingEvents != null) {
      _json["autoscalingEvents"] =
          autoscalingEvents.map((value) => (value).toJson()).toList();
    }
    if (jobMessages != null) {
      _json["jobMessages"] =
          jobMessages.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response to a request to list Cloud Dataflow jobs.  This may be a partial
/// response, depending on the page size in the ListJobsRequest.
class ListJobsResponse {
  /// Zero or more messages describing locations that failed to respond.
  core.List<FailedLocation> failedLocation;

  /// A subset of the requested job information.
  core.List<Job> jobs;

  /// Set if there may be more results than fit in this response.
  core.String nextPageToken;

  ListJobsResponse();

  ListJobsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("failedLocation")) {
      failedLocation = _json["failedLocation"]
          .map((value) => new FailedLocation.fromJson(value))
          .toList();
    }
    if (_json.containsKey("jobs")) {
      jobs = _json["jobs"].map((value) => new Job.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (failedLocation != null) {
      _json["failedLocation"] =
          failedLocation.map((value) => (value).toJson()).toList();
    }
    if (jobs != null) {
      _json["jobs"] = jobs.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Bucket of values for Distribution's logarithmic histogram.
class LogBucket {
  /// Number of values in this bucket.
  core.String count;

  /// floor(log2(value)); defined to be zero for nonpositive values.
  ///   log(-1) = 0
  ///   log(0) = 0
  ///   log(1) = 0
  ///   log(2) = 1
  ///   log(3) = 1
  ///   log(4) = 2
  ///   log(5) = 2
  core.int log;

  LogBucket();

  LogBucket.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("log")) {
      log = _json["log"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (count != null) {
      _json["count"] = count;
    }
    if (log != null) {
      _json["log"] = log;
    }
    return _json;
  }
}

/// MapTask consists of an ordered set of instructions, each of which
/// describes one particular low-level operation for the worker to
/// perform in order to accomplish the MapTask's WorkItem.
///
/// Each instruction must appear in the list before any instructions which
/// depends on its output.
class MapTask {
  /// The instructions in the MapTask.
  core.List<ParallelInstruction> instructions;

  /// System-defined name of the stage containing this MapTask.
  /// Unique across the workflow.
  core.String stageName;

  /// System-defined name of this MapTask.
  /// Unique across the workflow.
  core.String systemName;

  MapTask();

  MapTask.fromJson(core.Map _json) {
    if (_json.containsKey("instructions")) {
      instructions = _json["instructions"]
          .map((value) => new ParallelInstruction.fromJson(value))
          .toList();
    }
    if (_json.containsKey("stageName")) {
      stageName = _json["stageName"];
    }
    if (_json.containsKey("systemName")) {
      systemName = _json["systemName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (instructions != null) {
      _json["instructions"] =
          instructions.map((value) => (value).toJson()).toList();
    }
    if (stageName != null) {
      _json["stageName"] = stageName;
    }
    if (systemName != null) {
      _json["systemName"] = systemName;
    }
    return _json;
  }
}

/// The metric short id is returned to the user alongside an offset into
/// ReportWorkItemStatusRequest
class MetricShortId {
  /// The index of the corresponding metric in
  /// the ReportWorkItemStatusRequest. Required.
  core.int metricIndex;

  /// The service-generated short identifier for the metric.
  core.String shortId;

  MetricShortId();

  MetricShortId.fromJson(core.Map _json) {
    if (_json.containsKey("metricIndex")) {
      metricIndex = _json["metricIndex"];
    }
    if (_json.containsKey("shortId")) {
      shortId = _json["shortId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (metricIndex != null) {
      _json["metricIndex"] = metricIndex;
    }
    if (shortId != null) {
      _json["shortId"] = shortId;
    }
    return _json;
  }
}

/// Identifies a metric, by describing the source which generated the
/// metric.
class MetricStructuredName {
  /// Zero or more labeled fields which identify the part of the job this
  /// metric is associated with, such as the name of a step or collection.
  ///
  /// For example, built-in counters associated with steps will have
  /// context['step'] = <step-name>. Counters associated with PCollections
  /// in the SDK will have context['pcollection'] = <pcollection-name>.
  core.Map<core.String, core.String> context;

  /// Worker-defined metric name.
  core.String name;

  /// Origin (namespace) of metric name. May be blank for user-define metrics;
  /// will be "dataflow" for metrics defined by the Dataflow service or SDK.
  core.String origin;

  MetricStructuredName();

  MetricStructuredName.fromJson(core.Map _json) {
    if (_json.containsKey("context")) {
      context = _json["context"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("origin")) {
      origin = _json["origin"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (context != null) {
      _json["context"] = context;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (origin != null) {
      _json["origin"] = origin;
    }
    return _json;
  }
}

/// Describes the state of a metric.
class MetricUpdate {
  /// True if this metric is reported as the total cumulative aggregate
  /// value accumulated since the worker started working on this WorkItem.
  /// By default this is false, indicating that this metric is reported
  /// as a delta that is not associated with any WorkItem.
  core.bool cumulative;

  /// A struct value describing properties of a distribution of numeric values.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Object distribution;

  /// Worker-computed aggregate value for internal use by the Dataflow
  /// service.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Object internal;

  /// Metric aggregation kind.  The possible metric aggregation kinds are
  /// "Sum", "Max", "Min", "Mean", "Set", "And", "Or", and "Distribution".
  /// The specified aggregation kind is case-insensitive.
  ///
  /// If omitted, this is not an aggregated value but instead
  /// a single metric sample value.
  core.String kind;

  /// Worker-computed aggregate value for the "Mean" aggregation kind.
  /// This holds the count of the aggregated values and is used in combination
  /// with mean_sum above to obtain the actual mean aggregate value.
  /// The only possible value type is Long.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Object meanCount;

  /// Worker-computed aggregate value for the "Mean" aggregation kind.
  /// This holds the sum of the aggregated values and is used in combination
  /// with mean_count below to obtain the actual mean aggregate value.
  /// The only possible value types are Long and Double.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Object meanSum;

  /// Name of the metric.
  MetricStructuredName name;

  /// Worker-computed aggregate value for aggregation kinds "Sum", "Max", "Min",
  /// "And", and "Or".  The possible value types are Long, Double, and Boolean.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Object scalar;

  /// Worker-computed aggregate value for the "Set" aggregation kind.  The only
  /// possible value type is a list of Values whose type can be Long, Double,
  /// or String, according to the metric's type.  All Values in the list must
  /// be of the same type.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Object set;

  /// Timestamp associated with the metric value. Optional when workers are
  /// reporting work progress; it will be filled in responses from the
  /// metrics API.
  core.String updateTime;

  MetricUpdate();

  MetricUpdate.fromJson(core.Map _json) {
    if (_json.containsKey("cumulative")) {
      cumulative = _json["cumulative"];
    }
    if (_json.containsKey("distribution")) {
      distribution = _json["distribution"];
    }
    if (_json.containsKey("internal")) {
      internal = _json["internal"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("meanCount")) {
      meanCount = _json["meanCount"];
    }
    if (_json.containsKey("meanSum")) {
      meanSum = _json["meanSum"];
    }
    if (_json.containsKey("name")) {
      name = new MetricStructuredName.fromJson(_json["name"]);
    }
    if (_json.containsKey("scalar")) {
      scalar = _json["scalar"];
    }
    if (_json.containsKey("set")) {
      set = _json["set"];
    }
    if (_json.containsKey("updateTime")) {
      updateTime = _json["updateTime"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (cumulative != null) {
      _json["cumulative"] = cumulative;
    }
    if (distribution != null) {
      _json["distribution"] = distribution;
    }
    if (internal != null) {
      _json["internal"] = internal;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (meanCount != null) {
      _json["meanCount"] = meanCount;
    }
    if (meanSum != null) {
      _json["meanSum"] = meanSum;
    }
    if (name != null) {
      _json["name"] = (name).toJson();
    }
    if (scalar != null) {
      _json["scalar"] = scalar;
    }
    if (set != null) {
      _json["set"] = set;
    }
    if (updateTime != null) {
      _json["updateTime"] = updateTime;
    }
    return _json;
  }
}

/// Describes mounted data disk.
class MountedDataDisk {
  /// The name of the data disk.
  /// This name is local to the Google Cloud Platform project and uniquely
  /// identifies the disk within that project, for example
  /// "myproject-1014-104817-4c2-harness-0-disk-1".
  core.String dataDisk;

  MountedDataDisk();

  MountedDataDisk.fromJson(core.Map _json) {
    if (_json.containsKey("dataDisk")) {
      dataDisk = _json["dataDisk"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (dataDisk != null) {
      _json["dataDisk"] = dataDisk;
    }
    return _json;
  }
}

/// Information about an output of a multi-output DoFn.
class MultiOutputInfo {
  /// The id of the tag the user code will emit to this output by; this
  /// should correspond to the tag of some SideInputInfo.
  core.String tag;

  MultiOutputInfo();

  MultiOutputInfo.fromJson(core.Map _json) {
    if (_json.containsKey("tag")) {
      tag = _json["tag"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (tag != null) {
      _json["tag"] = tag;
    }
    return _json;
  }
}

/// Basic metadata about a counter.
class NameAndKind {
  /// Counter aggregation kind.
  /// Possible string values are:
  /// - "INVALID" : Counter aggregation kind was not set.
  /// - "SUM" : Aggregated value is the sum of all contributed values.
  /// - "MAX" : Aggregated value is the max of all contributed values.
  /// - "MIN" : Aggregated value is the min of all contributed values.
  /// - "MEAN" : Aggregated value is the mean of all contributed values.
  /// - "OR" : Aggregated value represents the logical 'or' of all contributed
  /// values.
  /// - "AND" : Aggregated value represents the logical 'and' of all contributed
  /// values.
  /// - "SET" : Aggregated value is a set of unique contributed values.
  /// - "DISTRIBUTION" : Aggregated value captures statistics about a
  /// distribution.
  core.String kind;

  /// Name of the counter.
  core.String name;

  NameAndKind();

  NameAndKind.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/// The packages that must be installed in order for a worker to run the
/// steps of the Cloud Dataflow job that will be assigned to its worker
/// pool.
///
/// This is the mechanism by which the Cloud Dataflow SDK causes code to
/// be loaded onto the workers. For example, the Cloud Dataflow Java SDK
/// might use this to install jars containing the user's code and all of the
/// various dependencies (libraries, data files, etc.) required in order
/// for that code to run.
class Package {
  /// The resource to read the package from. The supported resource type is:
  ///
  /// Google Cloud Storage:
  ///
  ///   storage.googleapis.com/{bucket}
  ///   bucket.storage.googleapis.com/
  core.String location;

  /// The name of the package.
  core.String name;

  Package();

  Package.fromJson(core.Map _json) {
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (location != null) {
      _json["location"] = location;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/// An instruction that does a ParDo operation.
/// Takes one main input and zero or more side inputs, and produces
/// zero or more outputs.
/// Runs user code.
class ParDoInstruction {
  /// The input.
  InstructionInput input;

  /// Information about each of the outputs, if user_fn is a  MultiDoFn.
  core.List<MultiOutputInfo> multiOutputInfos;

  /// The number of outputs.
  core.int numOutputs;

  /// Zero or more side inputs.
  core.List<SideInputInfo> sideInputs;

  /// The user function to invoke.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> userFn;

  ParDoInstruction();

  ParDoInstruction.fromJson(core.Map _json) {
    if (_json.containsKey("input")) {
      input = new InstructionInput.fromJson(_json["input"]);
    }
    if (_json.containsKey("multiOutputInfos")) {
      multiOutputInfos = _json["multiOutputInfos"]
          .map((value) => new MultiOutputInfo.fromJson(value))
          .toList();
    }
    if (_json.containsKey("numOutputs")) {
      numOutputs = _json["numOutputs"];
    }
    if (_json.containsKey("sideInputs")) {
      sideInputs = _json["sideInputs"]
          .map((value) => new SideInputInfo.fromJson(value))
          .toList();
    }
    if (_json.containsKey("userFn")) {
      userFn = _json["userFn"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (input != null) {
      _json["input"] = (input).toJson();
    }
    if (multiOutputInfos != null) {
      _json["multiOutputInfos"] =
          multiOutputInfos.map((value) => (value).toJson()).toList();
    }
    if (numOutputs != null) {
      _json["numOutputs"] = numOutputs;
    }
    if (sideInputs != null) {
      _json["sideInputs"] =
          sideInputs.map((value) => (value).toJson()).toList();
    }
    if (userFn != null) {
      _json["userFn"] = userFn;
    }
    return _json;
  }
}

/// Describes a particular operation comprising a MapTask.
class ParallelInstruction {
  /// Additional information for Flatten instructions.
  FlattenInstruction flatten;

  /// User-provided name of this operation.
  core.String name;

  /// System-defined name for the operation in the original workflow graph.
  core.String originalName;

  /// Describes the outputs of the instruction.
  core.List<InstructionOutput> outputs;

  /// Additional information for ParDo instructions.
  ParDoInstruction parDo;

  /// Additional information for PartialGroupByKey instructions.
  PartialGroupByKeyInstruction partialGroupByKey;

  /// Additional information for Read instructions.
  ReadInstruction read;

  /// System-defined name of this operation.
  /// Unique across the workflow.
  core.String systemName;

  /// Additional information for Write instructions.
  WriteInstruction write;

  ParallelInstruction();

  ParallelInstruction.fromJson(core.Map _json) {
    if (_json.containsKey("flatten")) {
      flatten = new FlattenInstruction.fromJson(_json["flatten"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("originalName")) {
      originalName = _json["originalName"];
    }
    if (_json.containsKey("outputs")) {
      outputs = _json["outputs"]
          .map((value) => new InstructionOutput.fromJson(value))
          .toList();
    }
    if (_json.containsKey("parDo")) {
      parDo = new ParDoInstruction.fromJson(_json["parDo"]);
    }
    if (_json.containsKey("partialGroupByKey")) {
      partialGroupByKey =
          new PartialGroupByKeyInstruction.fromJson(_json["partialGroupByKey"]);
    }
    if (_json.containsKey("read")) {
      read = new ReadInstruction.fromJson(_json["read"]);
    }
    if (_json.containsKey("systemName")) {
      systemName = _json["systemName"];
    }
    if (_json.containsKey("write")) {
      write = new WriteInstruction.fromJson(_json["write"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (flatten != null) {
      _json["flatten"] = (flatten).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (originalName != null) {
      _json["originalName"] = originalName;
    }
    if (outputs != null) {
      _json["outputs"] = outputs.map((value) => (value).toJson()).toList();
    }
    if (parDo != null) {
      _json["parDo"] = (parDo).toJson();
    }
    if (partialGroupByKey != null) {
      _json["partialGroupByKey"] = (partialGroupByKey).toJson();
    }
    if (read != null) {
      _json["read"] = (read).toJson();
    }
    if (systemName != null) {
      _json["systemName"] = systemName;
    }
    if (write != null) {
      _json["write"] = (write).toJson();
    }
    return _json;
  }
}

/// Structured data associated with this message.
class Parameter {
  /// Key or name for this parameter.
  core.String key;

  /// Value for this parameter.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Object value;

  Parameter();

  Parameter.fromJson(core.Map _json) {
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

/// Metadata for a specific parameter.
class ParameterMetadata {
  /// Required. The help text to display for the parameter.
  core.String helpText;

  /// Optional. Whether the parameter is optional. Defaults to false.
  core.bool isOptional;

  /// Required. The label to display for the parameter.
  core.String label;

  /// Required. The name of the parameter.
  core.String name;

  /// Optional. Regexes that the parameter must match.
  core.List<core.String> regexes;

  ParameterMetadata();

  ParameterMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("helpText")) {
      helpText = _json["helpText"];
    }
    if (_json.containsKey("isOptional")) {
      isOptional = _json["isOptional"];
    }
    if (_json.containsKey("label")) {
      label = _json["label"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("regexes")) {
      regexes = _json["regexes"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (helpText != null) {
      _json["helpText"] = helpText;
    }
    if (isOptional != null) {
      _json["isOptional"] = isOptional;
    }
    if (label != null) {
      _json["label"] = label;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (regexes != null) {
      _json["regexes"] = regexes;
    }
    return _json;
  }
}

/// An instruction that does a partial group-by-key.
/// One input and one output.
class PartialGroupByKeyInstruction {
  /// Describes the input to the partial group-by-key instruction.
  InstructionInput input;

  /// The codec to use for interpreting an element in the input PTable.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> inputElementCodec;

  /// If this instruction includes a combining function this is the name of the
  /// intermediate store between the GBK and the CombineValues.
  core.String originalCombineValuesInputStoreName;

  /// If this instruction includes a combining function, this is the name of the
  /// CombineValues instruction lifted into this instruction.
  core.String originalCombineValuesStepName;

  /// Zero or more side inputs.
  core.List<SideInputInfo> sideInputs;

  /// The value combining function to invoke.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> valueCombiningFn;

  PartialGroupByKeyInstruction();

  PartialGroupByKeyInstruction.fromJson(core.Map _json) {
    if (_json.containsKey("input")) {
      input = new InstructionInput.fromJson(_json["input"]);
    }
    if (_json.containsKey("inputElementCodec")) {
      inputElementCodec = _json["inputElementCodec"];
    }
    if (_json.containsKey("originalCombineValuesInputStoreName")) {
      originalCombineValuesInputStoreName =
          _json["originalCombineValuesInputStoreName"];
    }
    if (_json.containsKey("originalCombineValuesStepName")) {
      originalCombineValuesStepName = _json["originalCombineValuesStepName"];
    }
    if (_json.containsKey("sideInputs")) {
      sideInputs = _json["sideInputs"]
          .map((value) => new SideInputInfo.fromJson(value))
          .toList();
    }
    if (_json.containsKey("valueCombiningFn")) {
      valueCombiningFn = _json["valueCombiningFn"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (input != null) {
      _json["input"] = (input).toJson();
    }
    if (inputElementCodec != null) {
      _json["inputElementCodec"] = inputElementCodec;
    }
    if (originalCombineValuesInputStoreName != null) {
      _json["originalCombineValuesInputStoreName"] =
          originalCombineValuesInputStoreName;
    }
    if (originalCombineValuesStepName != null) {
      _json["originalCombineValuesStepName"] = originalCombineValuesStepName;
    }
    if (sideInputs != null) {
      _json["sideInputs"] =
          sideInputs.map((value) => (value).toJson()).toList();
    }
    if (valueCombiningFn != null) {
      _json["valueCombiningFn"] = valueCombiningFn;
    }
    return _json;
  }
}

/// A descriptive representation of submitted pipeline as well as the executed
/// form.  This data is provided by the Dataflow service for ease of visualizing
/// the pipeline and interpretting Dataflow provided metrics.
class PipelineDescription {
  /// Pipeline level display data.
  core.List<DisplayData> displayData;

  /// Description of each stage of execution of the pipeline.
  core.List<ExecutionStageSummary> executionPipelineStage;

  /// Description of each transform in the pipeline and collections between
  /// them.
  core.List<TransformSummary> originalPipelineTransform;

  PipelineDescription();

  PipelineDescription.fromJson(core.Map _json) {
    if (_json.containsKey("displayData")) {
      displayData = _json["displayData"]
          .map((value) => new DisplayData.fromJson(value))
          .toList();
    }
    if (_json.containsKey("executionPipelineStage")) {
      executionPipelineStage = _json["executionPipelineStage"]
          .map((value) => new ExecutionStageSummary.fromJson(value))
          .toList();
    }
    if (_json.containsKey("originalPipelineTransform")) {
      originalPipelineTransform = _json["originalPipelineTransform"]
          .map((value) => new TransformSummary.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (displayData != null) {
      _json["displayData"] =
          displayData.map((value) => (value).toJson()).toList();
    }
    if (executionPipelineStage != null) {
      _json["executionPipelineStage"] =
          executionPipelineStage.map((value) => (value).toJson()).toList();
    }
    if (originalPipelineTransform != null) {
      _json["originalPipelineTransform"] =
          originalPipelineTransform.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Position defines a position within a collection of data.  The value
/// can be either the end position, a key (used with ordered
/// collections), a byte offset, or a record index.
class Position {
  /// Position is a byte offset.
  core.String byteOffset;

  /// CloudPosition is a concat position.
  ConcatPosition concatPosition;

  /// Position is past all other positions. Also useful for the end
  /// position of an unbounded range.
  core.bool end;

  /// Position is a string key, ordered lexicographically.
  core.String key;

  /// Position is a record index.
  core.String recordIndex;

  /// CloudPosition is a base64 encoded BatchShufflePosition (with FIXED
  /// sharding).
  core.String shufflePosition;

  Position();

  Position.fromJson(core.Map _json) {
    if (_json.containsKey("byteOffset")) {
      byteOffset = _json["byteOffset"];
    }
    if (_json.containsKey("concatPosition")) {
      concatPosition = new ConcatPosition.fromJson(_json["concatPosition"]);
    }
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("recordIndex")) {
      recordIndex = _json["recordIndex"];
    }
    if (_json.containsKey("shufflePosition")) {
      shufflePosition = _json["shufflePosition"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (byteOffset != null) {
      _json["byteOffset"] = byteOffset;
    }
    if (concatPosition != null) {
      _json["concatPosition"] = (concatPosition).toJson();
    }
    if (end != null) {
      _json["end"] = end;
    }
    if (key != null) {
      _json["key"] = key;
    }
    if (recordIndex != null) {
      _json["recordIndex"] = recordIndex;
    }
    if (shufflePosition != null) {
      _json["shufflePosition"] = shufflePosition;
    }
    return _json;
  }
}

/// Identifies a pubsub location to use for transferring data into or
/// out of a streaming Dataflow job.
class PubsubLocation {
  /// Indicates whether the pipeline allows late-arriving data.
  core.bool dropLateData;

  /// If set, contains a pubsub label from which to extract record ids.
  /// If left empty, record deduplication will be strictly best effort.
  core.String idLabel;

  /// A pubsub subscription, in the form of
  /// "pubsub.googleapis.com/subscriptions/<project-id>/<subscription-name>"
  core.String subscription;

  /// If set, contains a pubsub label from which to extract record timestamps.
  /// If left empty, record timestamps will be generated upon arrival.
  core.String timestampLabel;

  /// A pubsub topic, in the form of
  /// "pubsub.googleapis.com/topics/<project-id>/<topic-name>"
  core.String topic;

  /// If set, specifies the pubsub subscription that will be used for tracking
  /// custom time timestamps for watermark estimation.
  core.String trackingSubscription;

  /// If true, then the client has requested to get pubsub attributes.
  core.bool withAttributes;

  PubsubLocation();

  PubsubLocation.fromJson(core.Map _json) {
    if (_json.containsKey("dropLateData")) {
      dropLateData = _json["dropLateData"];
    }
    if (_json.containsKey("idLabel")) {
      idLabel = _json["idLabel"];
    }
    if (_json.containsKey("subscription")) {
      subscription = _json["subscription"];
    }
    if (_json.containsKey("timestampLabel")) {
      timestampLabel = _json["timestampLabel"];
    }
    if (_json.containsKey("topic")) {
      topic = _json["topic"];
    }
    if (_json.containsKey("trackingSubscription")) {
      trackingSubscription = _json["trackingSubscription"];
    }
    if (_json.containsKey("withAttributes")) {
      withAttributes = _json["withAttributes"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (dropLateData != null) {
      _json["dropLateData"] = dropLateData;
    }
    if (idLabel != null) {
      _json["idLabel"] = idLabel;
    }
    if (subscription != null) {
      _json["subscription"] = subscription;
    }
    if (timestampLabel != null) {
      _json["timestampLabel"] = timestampLabel;
    }
    if (topic != null) {
      _json["topic"] = topic;
    }
    if (trackingSubscription != null) {
      _json["trackingSubscription"] = trackingSubscription;
    }
    if (withAttributes != null) {
      _json["withAttributes"] = withAttributes;
    }
    return _json;
  }
}

/// An instruction that reads records.
/// Takes no inputs, produces one output.
class ReadInstruction {
  /// The source to read from.
  Source source;

  ReadInstruction();

  ReadInstruction.fromJson(core.Map _json) {
    if (_json.containsKey("source")) {
      source = new Source.fromJson(_json["source"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    return _json;
  }
}

/// Request to report the status of WorkItems.
class ReportWorkItemStatusRequest {
  /// The current timestamp at the worker.
  core.String currentWorkerTime;

  /// The location which contains the WorkItem's job.
  core.String location;

  /// The order is unimportant, except that the order of the
  /// WorkItemServiceState messages in the ReportWorkItemStatusResponse
  /// corresponds to the order of WorkItemStatus messages here.
  core.List<WorkItemStatus> workItemStatuses;

  /// The ID of the worker reporting the WorkItem status.  If this
  /// does not match the ID of the worker which the Dataflow service
  /// believes currently has the lease on the WorkItem, the report
  /// will be dropped (with an error response).
  core.String workerId;

  ReportWorkItemStatusRequest();

  ReportWorkItemStatusRequest.fromJson(core.Map _json) {
    if (_json.containsKey("currentWorkerTime")) {
      currentWorkerTime = _json["currentWorkerTime"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("workItemStatuses")) {
      workItemStatuses = _json["workItemStatuses"]
          .map((value) => new WorkItemStatus.fromJson(value))
          .toList();
    }
    if (_json.containsKey("workerId")) {
      workerId = _json["workerId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (currentWorkerTime != null) {
      _json["currentWorkerTime"] = currentWorkerTime;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (workItemStatuses != null) {
      _json["workItemStatuses"] =
          workItemStatuses.map((value) => (value).toJson()).toList();
    }
    if (workerId != null) {
      _json["workerId"] = workerId;
    }
    return _json;
  }
}

/// Response from a request to report the status of WorkItems.
class ReportWorkItemStatusResponse {
  /// A set of messages indicating the service-side state for each
  /// WorkItem whose status was reported, in the same order as the
  /// WorkItemStatus messages in the ReportWorkItemStatusRequest which
  /// resulting in this response.
  core.List<WorkItemServiceState> workItemServiceStates;

  ReportWorkItemStatusResponse();

  ReportWorkItemStatusResponse.fromJson(core.Map _json) {
    if (_json.containsKey("workItemServiceStates")) {
      workItemServiceStates = _json["workItemServiceStates"]
          .map((value) => new WorkItemServiceState.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (workItemServiceStates != null) {
      _json["workItemServiceStates"] =
          workItemServiceStates.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Represents the level of parallelism in a WorkItem's input,
/// reported by the worker.
class ReportedParallelism {
  /// Specifies whether the parallelism is infinite. If true, "value" is
  /// ignored.
  /// Infinite parallelism means the service will assume that the work item
  /// can always be split into more non-empty work items by dynamic splitting.
  /// This is a work-around for lack of support for infinity by the current
  /// JSON-based Java RPC stack.
  core.bool isInfinite;

  /// Specifies the level of parallelism in case it is finite.
  core.double value;

  ReportedParallelism();

  ReportedParallelism.fromJson(core.Map _json) {
    if (_json.containsKey("isInfinite")) {
      isInfinite = _json["isInfinite"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (isInfinite != null) {
      _json["isInfinite"] = isInfinite;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/// Worker metrics exported from workers. This contains resource utilization
/// metrics accumulated from a variety of sources. For more information, see
/// go/df-resource-signals.
class ResourceUtilizationReport {
  /// CPU utilization samples.
  core.List<CPUTime> cpuTime;

  ResourceUtilizationReport();

  ResourceUtilizationReport.fromJson(core.Map _json) {
    if (_json.containsKey("cpuTime")) {
      cpuTime =
          _json["cpuTime"].map((value) => new CPUTime.fromJson(value)).toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (cpuTime != null) {
      _json["cpuTime"] = cpuTime.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Service-side response to WorkerMessage reporting resource utilization.
class ResourceUtilizationReportResponse {
  ResourceUtilizationReportResponse();

  ResourceUtilizationReportResponse.fromJson(core.Map _json) {}

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    return _json;
  }
}

/// The environment values to set at runtime.
class RuntimeEnvironment {
  /// Whether to bypass the safety checks for the job's temporary directory.
  /// Use with caution.
  core.bool bypassTempDirValidation;

  /// The machine type to use for the job. Defaults to the value from the
  /// template if not specified.
  core.String machineType;

  /// The maximum number of Google Compute Engine instances to be made
  /// available to your pipeline during execution, from 1 to 1000.
  core.int maxWorkers;

  /// The email address of the service account to run the job as.
  core.String serviceAccountEmail;

  /// The Cloud Storage path to use for temporary files.
  /// Must be a valid Cloud Storage URL, beginning with `gs://`.
  core.String tempLocation;

  /// The Compute Engine [availability
  /// zone](https://cloud.google.com/compute/docs/regions-zones/regions-zones)
  /// for launching worker instances to run your pipeline.
  core.String zone;

  RuntimeEnvironment();

  RuntimeEnvironment.fromJson(core.Map _json) {
    if (_json.containsKey("bypassTempDirValidation")) {
      bypassTempDirValidation = _json["bypassTempDirValidation"];
    }
    if (_json.containsKey("machineType")) {
      machineType = _json["machineType"];
    }
    if (_json.containsKey("maxWorkers")) {
      maxWorkers = _json["maxWorkers"];
    }
    if (_json.containsKey("serviceAccountEmail")) {
      serviceAccountEmail = _json["serviceAccountEmail"];
    }
    if (_json.containsKey("tempLocation")) {
      tempLocation = _json["tempLocation"];
    }
    if (_json.containsKey("zone")) {
      zone = _json["zone"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (bypassTempDirValidation != null) {
      _json["bypassTempDirValidation"] = bypassTempDirValidation;
    }
    if (machineType != null) {
      _json["machineType"] = machineType;
    }
    if (maxWorkers != null) {
      _json["maxWorkers"] = maxWorkers;
    }
    if (serviceAccountEmail != null) {
      _json["serviceAccountEmail"] = serviceAccountEmail;
    }
    if (tempLocation != null) {
      _json["tempLocation"] = tempLocation;
    }
    if (zone != null) {
      _json["zone"] = zone;
    }
    return _json;
  }
}

/// Request to send encoded debug information.
class SendDebugCaptureRequest {
  /// The internal component id for which debug information is sent.
  core.String componentId;

  /// The encoded debug information.
  core.String data;

  /// The location which contains the job specified by job_id.
  core.String location;

  /// The worker id, i.e., VM hostname.
  core.String workerId;

  SendDebugCaptureRequest();

  SendDebugCaptureRequest.fromJson(core.Map _json) {
    if (_json.containsKey("componentId")) {
      componentId = _json["componentId"];
    }
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("workerId")) {
      workerId = _json["workerId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (componentId != null) {
      _json["componentId"] = componentId;
    }
    if (data != null) {
      _json["data"] = data;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (workerId != null) {
      _json["workerId"] = workerId;
    }
    return _json;
  }
}

/// Response to a send capture request.
/// nothing
class SendDebugCaptureResponse {
  SendDebugCaptureResponse();

  SendDebugCaptureResponse.fromJson(core.Map _json) {}

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    return _json;
  }
}

/// A request for sending worker messages to the service.
class SendWorkerMessagesRequest {
  /// The location which contains the job
  core.String location;

  /// The WorkerMessages to send.
  core.List<WorkerMessage> workerMessages;

  SendWorkerMessagesRequest();

  SendWorkerMessagesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("workerMessages")) {
      workerMessages = _json["workerMessages"]
          .map((value) => new WorkerMessage.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (location != null) {
      _json["location"] = location;
    }
    if (workerMessages != null) {
      _json["workerMessages"] =
          workerMessages.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// The response to the worker messages.
class SendWorkerMessagesResponse {
  /// The servers response to the worker messages.
  core.List<WorkerMessageResponse> workerMessageResponses;

  SendWorkerMessagesResponse();

  SendWorkerMessagesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("workerMessageResponses")) {
      workerMessageResponses = _json["workerMessageResponses"]
          .map((value) => new WorkerMessageResponse.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (workerMessageResponses != null) {
      _json["workerMessageResponses"] =
          workerMessageResponses.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Describes a particular function to invoke.
class SeqMapTask {
  /// Information about each of the inputs.
  core.List<SideInputInfo> inputs;

  /// The user-provided name of the SeqDo operation.
  core.String name;

  /// Information about each of the outputs.
  core.List<SeqMapTaskOutputInfo> outputInfos;

  /// System-defined name of the stage containing the SeqDo operation.
  /// Unique across the workflow.
  core.String stageName;

  /// System-defined name of the SeqDo operation.
  /// Unique across the workflow.
  core.String systemName;

  /// The user function to invoke.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> userFn;

  SeqMapTask();

  SeqMapTask.fromJson(core.Map _json) {
    if (_json.containsKey("inputs")) {
      inputs = _json["inputs"]
          .map((value) => new SideInputInfo.fromJson(value))
          .toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("outputInfos")) {
      outputInfos = _json["outputInfos"]
          .map((value) => new SeqMapTaskOutputInfo.fromJson(value))
          .toList();
    }
    if (_json.containsKey("stageName")) {
      stageName = _json["stageName"];
    }
    if (_json.containsKey("systemName")) {
      systemName = _json["systemName"];
    }
    if (_json.containsKey("userFn")) {
      userFn = _json["userFn"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (inputs != null) {
      _json["inputs"] = inputs.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (outputInfos != null) {
      _json["outputInfos"] =
          outputInfos.map((value) => (value).toJson()).toList();
    }
    if (stageName != null) {
      _json["stageName"] = stageName;
    }
    if (systemName != null) {
      _json["systemName"] = systemName;
    }
    if (userFn != null) {
      _json["userFn"] = userFn;
    }
    return _json;
  }
}

/// Information about an output of a SeqMapTask.
class SeqMapTaskOutputInfo {
  /// The sink to write the output value to.
  Sink sink;

  /// The id of the TupleTag the user code will tag the output value by.
  core.String tag;

  SeqMapTaskOutputInfo();

  SeqMapTaskOutputInfo.fromJson(core.Map _json) {
    if (_json.containsKey("sink")) {
      sink = new Sink.fromJson(_json["sink"]);
    }
    if (_json.containsKey("tag")) {
      tag = _json["tag"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (sink != null) {
      _json["sink"] = (sink).toJson();
    }
    if (tag != null) {
      _json["tag"] = tag;
    }
    return _json;
  }
}

/// A task which consists of a shell command for the worker to execute.
class ShellTask {
  /// The shell command to run.
  core.String command;

  /// Exit code for the task.
  core.int exitCode;

  ShellTask();

  ShellTask.fromJson(core.Map _json) {
    if (_json.containsKey("command")) {
      command = _json["command"];
    }
    if (_json.containsKey("exitCode")) {
      exitCode = _json["exitCode"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (command != null) {
      _json["command"] = command;
    }
    if (exitCode != null) {
      _json["exitCode"] = exitCode;
    }
    return _json;
  }
}

/// Uniquely identifies a side input.
class SideInputId {
  /// The step that receives and usually consumes this side input.
  core.String declaringStepName;

  /// The index of the side input, from the list of non_parallel_inputs.
  core.int inputIndex;

  SideInputId();

  SideInputId.fromJson(core.Map _json) {
    if (_json.containsKey("declaringStepName")) {
      declaringStepName = _json["declaringStepName"];
    }
    if (_json.containsKey("inputIndex")) {
      inputIndex = _json["inputIndex"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (declaringStepName != null) {
      _json["declaringStepName"] = declaringStepName;
    }
    if (inputIndex != null) {
      _json["inputIndex"] = inputIndex;
    }
    return _json;
  }
}

/// Information about a side input of a DoFn or an input of a SeqDoFn.
class SideInputInfo {
  /// How to interpret the source element(s) as a side input value.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> kind;

  /// The source(s) to read element(s) from to get the value of this side input.
  /// If more than one source, then the elements are taken from the
  /// sources, in the specified order if order matters.
  /// At least one source is required.
  core.List<Source> sources;

  /// The id of the tag the user code will access this side input by;
  /// this should correspond to the tag of some MultiOutputInfo.
  core.String tag;

  SideInputInfo();

  SideInputInfo.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("sources")) {
      sources =
          _json["sources"].map((value) => new Source.fromJson(value)).toList();
    }
    if (_json.containsKey("tag")) {
      tag = _json["tag"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (sources != null) {
      _json["sources"] = sources.map((value) => (value).toJson()).toList();
    }
    if (tag != null) {
      _json["tag"] = tag;
    }
    return _json;
  }
}

/// A sink that records can be encoded and written to.
class Sink {
  /// The codec to use to encode data written to the sink.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> codec;

  /// The sink to write to, plus its parameters.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> spec;

  Sink();

  Sink.fromJson(core.Map _json) {
    if (_json.containsKey("codec")) {
      codec = _json["codec"];
    }
    if (_json.containsKey("spec")) {
      spec = _json["spec"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (codec != null) {
      _json["codec"] = codec;
    }
    if (spec != null) {
      _json["spec"] = spec;
    }
    return _json;
  }
}

/// A source that records can be read and decoded from.
class Source {
  /// While splitting, sources may specify the produced bundles
  /// as differences against another source, in order to save backend-side
  /// memory and allow bigger jobs. For details, see SourceSplitRequest.
  /// To support this use case, the full set of parameters of the source
  /// is logically obtained by taking the latest explicitly specified value
  /// of each parameter in the order:
  /// base_specs (later items win), spec (overrides anything in base_specs).
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.List<core.Map<core.String, core.Object>> baseSpecs;

  /// The codec to use to decode data read from the source.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> codec;

  /// Setting this value to true hints to the framework that the source
  /// doesn't need splitting, and using SourceSplitRequest on it would
  /// yield SOURCE_SPLIT_OUTCOME_USE_CURRENT.
  ///
  /// E.g. a file splitter may set this to true when splitting a single file
  /// into a set of byte ranges of appropriate size, and set this
  /// to false when splitting a filepattern into individual files.
  /// However, for efficiency, a file splitter may decide to produce
  /// file subranges directly from the filepattern to avoid a splitting
  /// round-trip.
  ///
  /// See SourceSplitRequest for an overview of the splitting process.
  ///
  /// This field is meaningful only in the Source objects populated
  /// by the user (e.g. when filling in a DerivedSource).
  /// Source objects supplied by the framework to the user don't have
  /// this field populated.
  core.bool doesNotNeedSplitting;

  /// Optionally, metadata for this source can be supplied right away,
  /// avoiding a SourceGetMetadataOperation roundtrip
  /// (see SourceOperationRequest).
  ///
  /// This field is meaningful only in the Source objects populated
  /// by the user (e.g. when filling in a DerivedSource).
  /// Source objects supplied by the framework to the user don't have
  /// this field populated.
  SourceMetadata metadata;

  /// The source to read from, plus its parameters.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> spec;

  Source();

  Source.fromJson(core.Map _json) {
    if (_json.containsKey("baseSpecs")) {
      baseSpecs = _json["baseSpecs"];
    }
    if (_json.containsKey("codec")) {
      codec = _json["codec"];
    }
    if (_json.containsKey("doesNotNeedSplitting")) {
      doesNotNeedSplitting = _json["doesNotNeedSplitting"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new SourceMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("spec")) {
      spec = _json["spec"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (baseSpecs != null) {
      _json["baseSpecs"] = baseSpecs;
    }
    if (codec != null) {
      _json["codec"] = codec;
    }
    if (doesNotNeedSplitting != null) {
      _json["doesNotNeedSplitting"] = doesNotNeedSplitting;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (spec != null) {
      _json["spec"] = spec;
    }
    return _json;
  }
}

/// DEPRECATED in favor of DynamicSourceSplit.
class SourceFork {
  /// DEPRECATED
  SourceSplitShard primary;

  /// DEPRECATED
  DerivedSource primarySource;

  /// DEPRECATED
  SourceSplitShard residual;

  /// DEPRECATED
  DerivedSource residualSource;

  SourceFork();

  SourceFork.fromJson(core.Map _json) {
    if (_json.containsKey("primary")) {
      primary = new SourceSplitShard.fromJson(_json["primary"]);
    }
    if (_json.containsKey("primarySource")) {
      primarySource = new DerivedSource.fromJson(_json["primarySource"]);
    }
    if (_json.containsKey("residual")) {
      residual = new SourceSplitShard.fromJson(_json["residual"]);
    }
    if (_json.containsKey("residualSource")) {
      residualSource = new DerivedSource.fromJson(_json["residualSource"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (primary != null) {
      _json["primary"] = (primary).toJson();
    }
    if (primarySource != null) {
      _json["primarySource"] = (primarySource).toJson();
    }
    if (residual != null) {
      _json["residual"] = (residual).toJson();
    }
    if (residualSource != null) {
      _json["residualSource"] = (residualSource).toJson();
    }
    return _json;
  }
}

/// A request to compute the SourceMetadata of a Source.
class SourceGetMetadataRequest {
  /// Specification of the source whose metadata should be computed.
  Source source;

  SourceGetMetadataRequest();

  SourceGetMetadataRequest.fromJson(core.Map _json) {
    if (_json.containsKey("source")) {
      source = new Source.fromJson(_json["source"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    return _json;
  }
}

/// The result of a SourceGetMetadataOperation.
class SourceGetMetadataResponse {
  /// The computed metadata.
  SourceMetadata metadata;

  SourceGetMetadataResponse();

  SourceGetMetadataResponse.fromJson(core.Map _json) {
    if (_json.containsKey("metadata")) {
      metadata = new SourceMetadata.fromJson(_json["metadata"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    return _json;
  }
}

/// Metadata about a Source useful for automatically optimizing
/// and tuning the pipeline, etc.
class SourceMetadata {
  /// An estimate of the total size (in bytes) of the data that would be
  /// read from this source.  This estimate is in terms of external storage
  /// size, before any decompression or other processing done by the reader.
  core.String estimatedSizeBytes;

  /// Specifies that the size of this source is known to be infinite
  /// (this is a streaming source).
  core.bool infinite;

  /// Whether this source is known to produce key/value pairs with
  /// the (encoded) keys in lexicographically sorted order.
  core.bool producesSortedKeys;

  SourceMetadata();

  SourceMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("estimatedSizeBytes")) {
      estimatedSizeBytes = _json["estimatedSizeBytes"];
    }
    if (_json.containsKey("infinite")) {
      infinite = _json["infinite"];
    }
    if (_json.containsKey("producesSortedKeys")) {
      producesSortedKeys = _json["producesSortedKeys"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (estimatedSizeBytes != null) {
      _json["estimatedSizeBytes"] = estimatedSizeBytes;
    }
    if (infinite != null) {
      _json["infinite"] = infinite;
    }
    if (producesSortedKeys != null) {
      _json["producesSortedKeys"] = producesSortedKeys;
    }
    return _json;
  }
}

/// A work item that represents the different operations that can be
/// performed on a user-defined Source specification.
class SourceOperationRequest {
  /// Information about a request to get metadata about a source.
  SourceGetMetadataRequest getMetadata;

  /// Information about a request to split a source.
  SourceSplitRequest split;

  SourceOperationRequest();

  SourceOperationRequest.fromJson(core.Map _json) {
    if (_json.containsKey("getMetadata")) {
      getMetadata = new SourceGetMetadataRequest.fromJson(_json["getMetadata"]);
    }
    if (_json.containsKey("split")) {
      split = new SourceSplitRequest.fromJson(_json["split"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (getMetadata != null) {
      _json["getMetadata"] = (getMetadata).toJson();
    }
    if (split != null) {
      _json["split"] = (split).toJson();
    }
    return _json;
  }
}

/// The result of a SourceOperationRequest, specified in
/// ReportWorkItemStatusRequest.source_operation when the work item
/// is completed.
class SourceOperationResponse {
  /// A response to a request to get metadata about a source.
  SourceGetMetadataResponse getMetadata;

  /// A response to a request to split a source.
  SourceSplitResponse split;

  SourceOperationResponse();

  SourceOperationResponse.fromJson(core.Map _json) {
    if (_json.containsKey("getMetadata")) {
      getMetadata =
          new SourceGetMetadataResponse.fromJson(_json["getMetadata"]);
    }
    if (_json.containsKey("split")) {
      split = new SourceSplitResponse.fromJson(_json["split"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (getMetadata != null) {
      _json["getMetadata"] = (getMetadata).toJson();
    }
    if (split != null) {
      _json["split"] = (split).toJson();
    }
    return _json;
  }
}

/// Hints for splitting a Source into bundles (parts for parallel
/// processing) using SourceSplitRequest.
class SourceSplitOptions {
  /// The source should be split into a set of bundles where the estimated size
  /// of each is approximately this many bytes.
  core.String desiredBundleSizeBytes;

  /// DEPRECATED in favor of desired_bundle_size_bytes.
  core.String desiredShardSizeBytes;

  SourceSplitOptions();

  SourceSplitOptions.fromJson(core.Map _json) {
    if (_json.containsKey("desiredBundleSizeBytes")) {
      desiredBundleSizeBytes = _json["desiredBundleSizeBytes"];
    }
    if (_json.containsKey("desiredShardSizeBytes")) {
      desiredShardSizeBytes = _json["desiredShardSizeBytes"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (desiredBundleSizeBytes != null) {
      _json["desiredBundleSizeBytes"] = desiredBundleSizeBytes;
    }
    if (desiredShardSizeBytes != null) {
      _json["desiredShardSizeBytes"] = desiredShardSizeBytes;
    }
    return _json;
  }
}

/// Represents the operation to split a high-level Source specification
/// into bundles (parts for parallel processing).
///
/// At a high level, splitting of a source into bundles happens as follows:
/// SourceSplitRequest is applied to the source. If it returns
/// SOURCE_SPLIT_OUTCOME_USE_CURRENT, no further splitting happens and the
/// source
/// is used "as is". Otherwise, splitting is applied recursively to each
/// produced DerivedSource.
///
/// As an optimization, for any Source, if its does_not_need_splitting is
/// true, the framework assumes that splitting this source would return
/// SOURCE_SPLIT_OUTCOME_USE_CURRENT, and doesn't initiate a SourceSplitRequest.
/// This applies both to the initial source being split and to bundles
/// produced from it.
class SourceSplitRequest {
  /// Hints for tuning the splitting process.
  SourceSplitOptions options;

  /// Specification of the source to be split.
  Source source;

  SourceSplitRequest();

  SourceSplitRequest.fromJson(core.Map _json) {
    if (_json.containsKey("options")) {
      options = new SourceSplitOptions.fromJson(_json["options"]);
    }
    if (_json.containsKey("source")) {
      source = new Source.fromJson(_json["source"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (options != null) {
      _json["options"] = (options).toJson();
    }
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    return _json;
  }
}

/// The response to a SourceSplitRequest.
class SourceSplitResponse {
  /// If outcome is SPLITTING_HAPPENED, then this is a list of bundles
  /// into which the source was split. Otherwise this field is ignored.
  /// This list can be empty, which means the source represents an empty input.
  core.List<DerivedSource> bundles;

  /// Indicates whether splitting happened and produced a list of bundles.
  /// If this is USE_CURRENT_SOURCE_AS_IS, the current source should
  /// be processed "as is" without splitting. "bundles" is ignored in this case.
  /// If this is SPLITTING_HAPPENED, then "bundles" contains a list of
  /// bundles into which the source was split.
  /// Possible string values are:
  /// - "SOURCE_SPLIT_OUTCOME_UNKNOWN" : The source split outcome is unknown, or
  /// unspecified.
  /// - "SOURCE_SPLIT_OUTCOME_USE_CURRENT" : The current source should be
  /// processed "as is" without splitting.
  /// - "SOURCE_SPLIT_OUTCOME_SPLITTING_HAPPENED" : Splitting produced a list of
  /// bundles.
  core.String outcome;

  /// DEPRECATED in favor of bundles.
  core.List<SourceSplitShard> shards;

  SourceSplitResponse();

  SourceSplitResponse.fromJson(core.Map _json) {
    if (_json.containsKey("bundles")) {
      bundles = _json["bundles"]
          .map((value) => new DerivedSource.fromJson(value))
          .toList();
    }
    if (_json.containsKey("outcome")) {
      outcome = _json["outcome"];
    }
    if (_json.containsKey("shards")) {
      shards = _json["shards"]
          .map((value) => new SourceSplitShard.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (bundles != null) {
      _json["bundles"] = bundles.map((value) => (value).toJson()).toList();
    }
    if (outcome != null) {
      _json["outcome"] = outcome;
    }
    if (shards != null) {
      _json["shards"] = shards.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// DEPRECATED in favor of DerivedSource.
class SourceSplitShard {
  /// DEPRECATED
  /// Possible string values are:
  /// - "SOURCE_DERIVATION_MODE_UNKNOWN" : The source derivation is unknown, or
  /// unspecified.
  /// - "SOURCE_DERIVATION_MODE_INDEPENDENT" : Produce a completely independent
  /// Source with no base.
  /// - "SOURCE_DERIVATION_MODE_CHILD_OF_CURRENT" : Produce a Source based on
  /// the Source being split.
  /// - "SOURCE_DERIVATION_MODE_SIBLING_OF_CURRENT" : Produce a Source based on
  /// the base of the Source being split.
  core.String derivationMode;

  /// DEPRECATED
  Source source;

  SourceSplitShard();

  SourceSplitShard.fromJson(core.Map _json) {
    if (_json.containsKey("derivationMode")) {
      derivationMode = _json["derivationMode"];
    }
    if (_json.containsKey("source")) {
      source = new Source.fromJson(_json["source"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (derivationMode != null) {
      _json["derivationMode"] = derivationMode;
    }
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    return _json;
  }
}

/// A representation of an int64, n, that is immune to precision loss when
/// encoded in JSON.
class SplitInt64 {
  /// The high order bits, including the sign: n >> 32.
  core.int highBits;

  /// The low order bits: n & 0xffffffff.
  core.int lowBits;

  SplitInt64();

  SplitInt64.fromJson(core.Map _json) {
    if (_json.containsKey("highBits")) {
      highBits = _json["highBits"];
    }
    if (_json.containsKey("lowBits")) {
      lowBits = _json["lowBits"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (highBits != null) {
      _json["highBits"] = highBits;
    }
    if (lowBits != null) {
      _json["lowBits"] = lowBits;
    }
    return _json;
  }
}

/// Description of an input or output of an execution stage.
class StageSource {
  /// Dataflow service generated name for this source.
  core.String name;

  /// User name for the original user transform or collection with which this
  /// source is most closely associated.
  core.String originalTransformOrCollection;

  /// Size of the source, if measurable.
  core.String sizeBytes;

  /// Human-readable name for this source; may be user or system generated.
  core.String userName;

  StageSource();

  StageSource.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("originalTransformOrCollection")) {
      originalTransformOrCollection = _json["originalTransformOrCollection"];
    }
    if (_json.containsKey("sizeBytes")) {
      sizeBytes = _json["sizeBytes"];
    }
    if (_json.containsKey("userName")) {
      userName = _json["userName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (name != null) {
      _json["name"] = name;
    }
    if (originalTransformOrCollection != null) {
      _json["originalTransformOrCollection"] = originalTransformOrCollection;
    }
    if (sizeBytes != null) {
      _json["sizeBytes"] = sizeBytes;
    }
    if (userName != null) {
      _json["userName"] = userName;
    }
    return _json;
  }
}

/// State family configuration.
class StateFamilyConfig {
  /// If true, this family corresponds to a read operation.
  core.bool isRead;

  /// The state family value.
  core.String stateFamily;

  StateFamilyConfig();

  StateFamilyConfig.fromJson(core.Map _json) {
    if (_json.containsKey("isRead")) {
      isRead = _json["isRead"];
    }
    if (_json.containsKey("stateFamily")) {
      stateFamily = _json["stateFamily"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (isRead != null) {
      _json["isRead"] = isRead;
    }
    if (stateFamily != null) {
      _json["stateFamily"] = stateFamily;
    }
    return _json;
  }
}

/// The `Status` type defines a logical error model that is suitable for
/// different
/// programming environments, including REST APIs and RPC APIs. It is used by
/// [gRPC](https://github.com/grpc). The error model is designed to be:
///
/// - Simple to use and understand for most users
/// - Flexible enough to meet unexpected needs
///
/// # Overview
///
/// The `Status` message contains three pieces of data: error code, error
/// message,
/// and error details. The error code should be an enum value of
/// google.rpc.Code, but it may accept additional error codes if needed.  The
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
/// it
/// is not necessarily the actual wire format. When the `Status` message is
/// exposed in different client libraries and different wire protocols, it can
/// be
/// mapped differently. For example, it will likely be mapped to some exceptions
/// in Java, but more likely mapped to some error codes in C.
///
/// # Other uses
///
/// The error model and the `Status` message can be used in a variety of
/// environments, either with or without APIs, to provide a
/// consistent developer experience across different environments.
///
/// Example uses of this error model include:
///
/// - Partial errors. If a service needs to return partial errors to the client,
/// it may embed the `Status` in the normal response to indicate the partial
///     errors.
///
/// - Workflow errors. A typical workflow has multiple steps. Each step may
///     have a `Status` message for error reporting.
///
/// - Batch operations. If a client uses batch request and batch response, the
///     `Status` message should be used directly inside batch response, one for
///     each error sub-response.
///
/// - Asynchronous operations. If an API call embeds asynchronous operation
///     results in its response, the status of those operations should be
///     represented directly using the `Status` message.
///
/// - Logging. If some API errors are stored in logs, the message `Status` could
/// be used directly after any stripping needed for security/privacy reasons.
class Status {
  /// The status code, which should be an enum value of google.rpc.Code.
  core.int code;

  /// A list of messages that carry the error details.  There is a common set of
  /// message types for APIs to use.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.List<core.Map<core.String, core.Object>> details;

  /// A developer-facing error message, which should be in English. Any
  /// user-facing error message should be localized and sent in the
  /// google.rpc.Status.details field, or localized by the client.
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

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
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

/// Defines a particular step within a Cloud Dataflow job.
///
/// A job consists of multiple steps, each of which performs some
/// specific operation as part of the overall job.  Data is typically
/// passed from one step to another as part of the job.
///
/// Here's an example of a sequence of steps which together implement a
/// Map-Reduce job:
///
///   * Read a collection of data from some source, parsing the
///     collection's elements.
///
///   * Validate the elements.
///
///   * Apply a user-defined function to map each element to some value
///     and extract an element-specific key value.
///
///   * Group elements with the same key into a single element with
///     that key, transforming a multiply-keyed collection into a
///     uniquely-keyed collection.
///
///   * Write the elements out to some data sink.
///
/// Note that the Cloud Dataflow service may be used to run many different
/// types of jobs, not just Map-Reduce.
class Step {
  /// The kind of step in the Cloud Dataflow job.
  core.String kind;

  /// The name that identifies the step. This must be unique for each
  /// step with respect to all other steps in the Cloud Dataflow job.
  core.String name;

  /// Named properties associated with the step. Each kind of
  /// predefined step has its own required set of properties.
  /// Must be provided on Create.  Only retrieved with JOB_VIEW_ALL.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> properties;

  Step();

  Step.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("properties")) {
      properties = _json["properties"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (properties != null) {
      _json["properties"] = properties;
    }
    return _json;
  }
}

/// Describes a stream of data, either as input to be processed or as
/// output of a streaming Dataflow job.
class StreamLocation {
  /// The stream is a custom source.
  CustomSourceLocation customSourceLocation;

  /// The stream is a pubsub stream.
  PubsubLocation pubsubLocation;

  /// The stream is a streaming side input.
  StreamingSideInputLocation sideInputLocation;

  /// The stream is part of another computation within the current
  /// streaming Dataflow job.
  StreamingStageLocation streamingStageLocation;

  StreamLocation();

  StreamLocation.fromJson(core.Map _json) {
    if (_json.containsKey("customSourceLocation")) {
      customSourceLocation =
          new CustomSourceLocation.fromJson(_json["customSourceLocation"]);
    }
    if (_json.containsKey("pubsubLocation")) {
      pubsubLocation = new PubsubLocation.fromJson(_json["pubsubLocation"]);
    }
    if (_json.containsKey("sideInputLocation")) {
      sideInputLocation =
          new StreamingSideInputLocation.fromJson(_json["sideInputLocation"]);
    }
    if (_json.containsKey("streamingStageLocation")) {
      streamingStageLocation =
          new StreamingStageLocation.fromJson(_json["streamingStageLocation"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (customSourceLocation != null) {
      _json["customSourceLocation"] = (customSourceLocation).toJson();
    }
    if (pubsubLocation != null) {
      _json["pubsubLocation"] = (pubsubLocation).toJson();
    }
    if (sideInputLocation != null) {
      _json["sideInputLocation"] = (sideInputLocation).toJson();
    }
    if (streamingStageLocation != null) {
      _json["streamingStageLocation"] = (streamingStageLocation).toJson();
    }
    return _json;
  }
}

/// Configuration information for a single streaming computation.
class StreamingComputationConfig {
  /// Unique identifier for this computation.
  core.String computationId;

  /// Instructions that comprise the computation.
  core.List<ParallelInstruction> instructions;

  /// Stage name of this computation.
  core.String stageName;

  /// System defined name for this computation.
  core.String systemName;

  StreamingComputationConfig();

  StreamingComputationConfig.fromJson(core.Map _json) {
    if (_json.containsKey("computationId")) {
      computationId = _json["computationId"];
    }
    if (_json.containsKey("instructions")) {
      instructions = _json["instructions"]
          .map((value) => new ParallelInstruction.fromJson(value))
          .toList();
    }
    if (_json.containsKey("stageName")) {
      stageName = _json["stageName"];
    }
    if (_json.containsKey("systemName")) {
      systemName = _json["systemName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (computationId != null) {
      _json["computationId"] = computationId;
    }
    if (instructions != null) {
      _json["instructions"] =
          instructions.map((value) => (value).toJson()).toList();
    }
    if (stageName != null) {
      _json["stageName"] = stageName;
    }
    if (systemName != null) {
      _json["systemName"] = systemName;
    }
    return _json;
  }
}

/// Describes full or partial data disk assignment information of the
/// computation
/// ranges.
class StreamingComputationRanges {
  /// The ID of the computation.
  core.String computationId;

  /// Data disk assignments for ranges from this computation.
  core.List<KeyRangeDataDiskAssignment> rangeAssignments;

  StreamingComputationRanges();

  StreamingComputationRanges.fromJson(core.Map _json) {
    if (_json.containsKey("computationId")) {
      computationId = _json["computationId"];
    }
    if (_json.containsKey("rangeAssignments")) {
      rangeAssignments = _json["rangeAssignments"]
          .map((value) => new KeyRangeDataDiskAssignment.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (computationId != null) {
      _json["computationId"] = computationId;
    }
    if (rangeAssignments != null) {
      _json["rangeAssignments"] =
          rangeAssignments.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A task which describes what action should be performed for the specified
/// streaming computation ranges.
class StreamingComputationTask {
  /// Contains ranges of a streaming computation this task should apply to.
  core.List<StreamingComputationRanges> computationRanges;

  /// Describes the set of data disks this task should apply to.
  core.List<MountedDataDisk> dataDisks;

  /// A type of streaming computation task.
  /// Possible string values are:
  /// - "STREAMING_COMPUTATION_TASK_UNKNOWN" : The streaming computation task is
  /// unknown, or unspecified.
  /// - "STREAMING_COMPUTATION_TASK_STOP" : Stop processing specified streaming
  /// computation range(s).
  /// - "STREAMING_COMPUTATION_TASK_START" : Start processing specified
  /// streaming computation range(s).
  core.String taskType;

  StreamingComputationTask();

  StreamingComputationTask.fromJson(core.Map _json) {
    if (_json.containsKey("computationRanges")) {
      computationRanges = _json["computationRanges"]
          .map((value) => new StreamingComputationRanges.fromJson(value))
          .toList();
    }
    if (_json.containsKey("dataDisks")) {
      dataDisks = _json["dataDisks"]
          .map((value) => new MountedDataDisk.fromJson(value))
          .toList();
    }
    if (_json.containsKey("taskType")) {
      taskType = _json["taskType"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (computationRanges != null) {
      _json["computationRanges"] =
          computationRanges.map((value) => (value).toJson()).toList();
    }
    if (dataDisks != null) {
      _json["dataDisks"] = dataDisks.map((value) => (value).toJson()).toList();
    }
    if (taskType != null) {
      _json["taskType"] = taskType;
    }
    return _json;
  }
}

/// A task that carries configuration information for streaming computations.
class StreamingConfigTask {
  /// Set of computation configuration information.
  core.List<StreamingComputationConfig> streamingComputationConfigs;

  /// Map from user step names to state families.
  core.Map<core.String, core.String> userStepToStateFamilyNameMap;

  /// If present, the worker must use this endpoint to communicate with Windmill
  /// Service dispatchers, otherwise the worker must continue to use whatever
  /// endpoint it had been using.
  core.String windmillServiceEndpoint;

  /// If present, the worker must use this port to communicate with Windmill
  /// Service dispatchers. Only applicable when windmill_service_endpoint is
  /// specified.
  core.String windmillServicePort;

  StreamingConfigTask();

  StreamingConfigTask.fromJson(core.Map _json) {
    if (_json.containsKey("streamingComputationConfigs")) {
      streamingComputationConfigs = _json["streamingComputationConfigs"]
          .map((value) => new StreamingComputationConfig.fromJson(value))
          .toList();
    }
    if (_json.containsKey("userStepToStateFamilyNameMap")) {
      userStepToStateFamilyNameMap = _json["userStepToStateFamilyNameMap"];
    }
    if (_json.containsKey("windmillServiceEndpoint")) {
      windmillServiceEndpoint = _json["windmillServiceEndpoint"];
    }
    if (_json.containsKey("windmillServicePort")) {
      windmillServicePort = _json["windmillServicePort"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (streamingComputationConfigs != null) {
      _json["streamingComputationConfigs"] =
          streamingComputationConfigs.map((value) => (value).toJson()).toList();
    }
    if (userStepToStateFamilyNameMap != null) {
      _json["userStepToStateFamilyNameMap"] = userStepToStateFamilyNameMap;
    }
    if (windmillServiceEndpoint != null) {
      _json["windmillServiceEndpoint"] = windmillServiceEndpoint;
    }
    if (windmillServicePort != null) {
      _json["windmillServicePort"] = windmillServicePort;
    }
    return _json;
  }
}

/// A task which initializes part of a streaming Dataflow job.
class StreamingSetupTask {
  /// The user has requested drain.
  core.bool drain;

  /// The TCP port on which the worker should listen for messages from
  /// other streaming computation workers.
  core.int receiveWorkPort;

  /// The global topology of the streaming Dataflow job.
  TopologyConfig streamingComputationTopology;

  /// The TCP port used by the worker to communicate with the Dataflow
  /// worker harness.
  core.int workerHarnessPort;

  StreamingSetupTask();

  StreamingSetupTask.fromJson(core.Map _json) {
    if (_json.containsKey("drain")) {
      drain = _json["drain"];
    }
    if (_json.containsKey("receiveWorkPort")) {
      receiveWorkPort = _json["receiveWorkPort"];
    }
    if (_json.containsKey("streamingComputationTopology")) {
      streamingComputationTopology =
          new TopologyConfig.fromJson(_json["streamingComputationTopology"]);
    }
    if (_json.containsKey("workerHarnessPort")) {
      workerHarnessPort = _json["workerHarnessPort"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (drain != null) {
      _json["drain"] = drain;
    }
    if (receiveWorkPort != null) {
      _json["receiveWorkPort"] = receiveWorkPort;
    }
    if (streamingComputationTopology != null) {
      _json["streamingComputationTopology"] =
          (streamingComputationTopology).toJson();
    }
    if (workerHarnessPort != null) {
      _json["workerHarnessPort"] = workerHarnessPort;
    }
    return _json;
  }
}

/// Identifies the location of a streaming side input.
class StreamingSideInputLocation {
  /// Identifies the state family where this side input is stored.
  core.String stateFamily;

  /// Identifies the particular side input within the streaming Dataflow job.
  core.String tag;

  StreamingSideInputLocation();

  StreamingSideInputLocation.fromJson(core.Map _json) {
    if (_json.containsKey("stateFamily")) {
      stateFamily = _json["stateFamily"];
    }
    if (_json.containsKey("tag")) {
      tag = _json["tag"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (stateFamily != null) {
      _json["stateFamily"] = stateFamily;
    }
    if (tag != null) {
      _json["tag"] = tag;
    }
    return _json;
  }
}

/// Identifies the location of a streaming computation stage, for
/// stage-to-stage communication.
class StreamingStageLocation {
  /// Identifies the particular stream within the streaming Dataflow
  /// job.
  core.String streamId;

  StreamingStageLocation();

  StreamingStageLocation.fromJson(core.Map _json) {
    if (_json.containsKey("streamId")) {
      streamId = _json["streamId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (streamId != null) {
      _json["streamId"] = streamId;
    }
    return _json;
  }
}

/// A metric value representing a list of strings.
class StringList {
  /// Elements of the list.
  core.List<core.String> elements;

  StringList();

  StringList.fromJson(core.Map _json) {
    if (_json.containsKey("elements")) {
      elements = _json["elements"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (elements != null) {
      _json["elements"] = elements;
    }
    return _json;
  }
}

/// A rich message format, including a human readable string, a key for
/// identifying the message, and structured data associated with the message for
/// programmatic consumption.
class StructuredMessage {
  /// Idenfier for this message type.  Used by external systems to
  /// internationalize or personalize message.
  core.String messageKey;

  /// Human-readable version of message.
  core.String messageText;

  /// The structured data associated with this message.
  core.List<Parameter> parameters;

  StructuredMessage();

  StructuredMessage.fromJson(core.Map _json) {
    if (_json.containsKey("messageKey")) {
      messageKey = _json["messageKey"];
    }
    if (_json.containsKey("messageText")) {
      messageText = _json["messageText"];
    }
    if (_json.containsKey("parameters")) {
      parameters = _json["parameters"]
          .map((value) => new Parameter.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (messageKey != null) {
      _json["messageKey"] = messageKey;
    }
    if (messageText != null) {
      _json["messageText"] = messageText;
    }
    if (parameters != null) {
      _json["parameters"] =
          parameters.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Taskrunner configuration settings.
class TaskRunnerSettings {
  /// Whether to also send taskrunner log info to stderr.
  core.bool alsologtostderr;

  /// The location on the worker for task-specific subdirectories.
  core.String baseTaskDir;

  /// The base URL for the taskrunner to use when accessing Google Cloud APIs.
  ///
  /// When workers access Google Cloud APIs, they logically do so via
  /// relative URLs.  If this field is specified, it supplies the base
  /// URL to use for resolving these relative URLs.  The normative
  /// algorithm used is defined by RFC 1808, "Relative Uniform Resource
  /// Locators".
  ///
  /// If not specified, the default value is "http://www.googleapis.com/"
  core.String baseUrl;

  /// The file to store preprocessing commands in.
  core.String commandlinesFileName;

  /// Whether to continue taskrunner if an exception is hit.
  core.bool continueOnException;

  /// The API version of endpoint, e.g. "v1b3"
  core.String dataflowApiVersion;

  /// The command to launch the worker harness.
  core.String harnessCommand;

  /// The suggested backend language.
  core.String languageHint;

  /// The directory on the VM to store logs.
  core.String logDir;

  /// Whether to send taskrunner log info to Google Compute Engine VM serial
  /// console.
  core.bool logToSerialconsole;

  /// Indicates where to put logs.  If this is not specified, the logs
  /// will not be uploaded.
  ///
  /// The supported resource type is:
  ///
  /// Google Cloud Storage:
  ///   storage.googleapis.com/{bucket}/{object}
  ///   bucket.storage.googleapis.com/{object}
  core.String logUploadLocation;

  /// The OAuth2 scopes to be requested by the taskrunner in order to
  /// access the Cloud Dataflow API.
  core.List<core.String> oauthScopes;

  /// The settings to pass to the parallel worker harness.
  WorkerSettings parallelWorkerSettings;

  /// The streaming worker main class name.
  core.String streamingWorkerMainClass;

  /// The UNIX group ID on the worker VM to use for tasks launched by
  /// taskrunner; e.g. "wheel".
  core.String taskGroup;

  /// The UNIX user ID on the worker VM to use for tasks launched by
  /// taskrunner; e.g. "root".
  core.String taskUser;

  /// The prefix of the resources the taskrunner should use for
  /// temporary storage.
  ///
  /// The supported resource type is:
  ///
  /// Google Cloud Storage:
  ///   storage.googleapis.com/{bucket}/{object}
  ///   bucket.storage.googleapis.com/{object}
  core.String tempStoragePrefix;

  /// The ID string of the VM.
  core.String vmId;

  /// The file to store the workflow in.
  core.String workflowFileName;

  TaskRunnerSettings();

  TaskRunnerSettings.fromJson(core.Map _json) {
    if (_json.containsKey("alsologtostderr")) {
      alsologtostderr = _json["alsologtostderr"];
    }
    if (_json.containsKey("baseTaskDir")) {
      baseTaskDir = _json["baseTaskDir"];
    }
    if (_json.containsKey("baseUrl")) {
      baseUrl = _json["baseUrl"];
    }
    if (_json.containsKey("commandlinesFileName")) {
      commandlinesFileName = _json["commandlinesFileName"];
    }
    if (_json.containsKey("continueOnException")) {
      continueOnException = _json["continueOnException"];
    }
    if (_json.containsKey("dataflowApiVersion")) {
      dataflowApiVersion = _json["dataflowApiVersion"];
    }
    if (_json.containsKey("harnessCommand")) {
      harnessCommand = _json["harnessCommand"];
    }
    if (_json.containsKey("languageHint")) {
      languageHint = _json["languageHint"];
    }
    if (_json.containsKey("logDir")) {
      logDir = _json["logDir"];
    }
    if (_json.containsKey("logToSerialconsole")) {
      logToSerialconsole = _json["logToSerialconsole"];
    }
    if (_json.containsKey("logUploadLocation")) {
      logUploadLocation = _json["logUploadLocation"];
    }
    if (_json.containsKey("oauthScopes")) {
      oauthScopes = _json["oauthScopes"];
    }
    if (_json.containsKey("parallelWorkerSettings")) {
      parallelWorkerSettings =
          new WorkerSettings.fromJson(_json["parallelWorkerSettings"]);
    }
    if (_json.containsKey("streamingWorkerMainClass")) {
      streamingWorkerMainClass = _json["streamingWorkerMainClass"];
    }
    if (_json.containsKey("taskGroup")) {
      taskGroup = _json["taskGroup"];
    }
    if (_json.containsKey("taskUser")) {
      taskUser = _json["taskUser"];
    }
    if (_json.containsKey("tempStoragePrefix")) {
      tempStoragePrefix = _json["tempStoragePrefix"];
    }
    if (_json.containsKey("vmId")) {
      vmId = _json["vmId"];
    }
    if (_json.containsKey("workflowFileName")) {
      workflowFileName = _json["workflowFileName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (alsologtostderr != null) {
      _json["alsologtostderr"] = alsologtostderr;
    }
    if (baseTaskDir != null) {
      _json["baseTaskDir"] = baseTaskDir;
    }
    if (baseUrl != null) {
      _json["baseUrl"] = baseUrl;
    }
    if (commandlinesFileName != null) {
      _json["commandlinesFileName"] = commandlinesFileName;
    }
    if (continueOnException != null) {
      _json["continueOnException"] = continueOnException;
    }
    if (dataflowApiVersion != null) {
      _json["dataflowApiVersion"] = dataflowApiVersion;
    }
    if (harnessCommand != null) {
      _json["harnessCommand"] = harnessCommand;
    }
    if (languageHint != null) {
      _json["languageHint"] = languageHint;
    }
    if (logDir != null) {
      _json["logDir"] = logDir;
    }
    if (logToSerialconsole != null) {
      _json["logToSerialconsole"] = logToSerialconsole;
    }
    if (logUploadLocation != null) {
      _json["logUploadLocation"] = logUploadLocation;
    }
    if (oauthScopes != null) {
      _json["oauthScopes"] = oauthScopes;
    }
    if (parallelWorkerSettings != null) {
      _json["parallelWorkerSettings"] = (parallelWorkerSettings).toJson();
    }
    if (streamingWorkerMainClass != null) {
      _json["streamingWorkerMainClass"] = streamingWorkerMainClass;
    }
    if (taskGroup != null) {
      _json["taskGroup"] = taskGroup;
    }
    if (taskUser != null) {
      _json["taskUser"] = taskUser;
    }
    if (tempStoragePrefix != null) {
      _json["tempStoragePrefix"] = tempStoragePrefix;
    }
    if (vmId != null) {
      _json["vmId"] = vmId;
    }
    if (workflowFileName != null) {
      _json["workflowFileName"] = workflowFileName;
    }
    return _json;
  }
}

/// Metadata describing a template.
class TemplateMetadata {
  /// Optional. A description of the template.
  core.String description;

  /// Required. The name of the template.
  core.String name;

  /// The parameters for the template.
  core.List<ParameterMetadata> parameters;

  TemplateMetadata();

  TemplateMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parameters")) {
      parameters = _json["parameters"]
          .map((value) => new ParameterMetadata.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (description != null) {
      _json["description"] = description;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parameters != null) {
      _json["parameters"] =
          parameters.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Global topology of the streaming Dataflow job, including all
/// computations and their sharded locations.
class TopologyConfig {
  /// The computations associated with a streaming Dataflow job.
  core.List<ComputationTopology> computations;

  /// The disks assigned to a streaming Dataflow job.
  core.List<DataDiskAssignment> dataDiskAssignments;

  /// The size (in bits) of keys that will be assigned to source messages.
  core.int forwardingKeyBits;

  /// Version number for persistent state.
  core.int persistentStateVersion;

  /// Maps user stage names to stable computation names.
  core.Map<core.String, core.String> userStageToComputationNameMap;

  TopologyConfig();

  TopologyConfig.fromJson(core.Map _json) {
    if (_json.containsKey("computations")) {
      computations = _json["computations"]
          .map((value) => new ComputationTopology.fromJson(value))
          .toList();
    }
    if (_json.containsKey("dataDiskAssignments")) {
      dataDiskAssignments = _json["dataDiskAssignments"]
          .map((value) => new DataDiskAssignment.fromJson(value))
          .toList();
    }
    if (_json.containsKey("forwardingKeyBits")) {
      forwardingKeyBits = _json["forwardingKeyBits"];
    }
    if (_json.containsKey("persistentStateVersion")) {
      persistentStateVersion = _json["persistentStateVersion"];
    }
    if (_json.containsKey("userStageToComputationNameMap")) {
      userStageToComputationNameMap = _json["userStageToComputationNameMap"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (computations != null) {
      _json["computations"] =
          computations.map((value) => (value).toJson()).toList();
    }
    if (dataDiskAssignments != null) {
      _json["dataDiskAssignments"] =
          dataDiskAssignments.map((value) => (value).toJson()).toList();
    }
    if (forwardingKeyBits != null) {
      _json["forwardingKeyBits"] = forwardingKeyBits;
    }
    if (persistentStateVersion != null) {
      _json["persistentStateVersion"] = persistentStateVersion;
    }
    if (userStageToComputationNameMap != null) {
      _json["userStageToComputationNameMap"] = userStageToComputationNameMap;
    }
    return _json;
  }
}

/// Description of the type, names/ids, and input/outputs for a transform.
class TransformSummary {
  /// Transform-specific display data.
  core.List<DisplayData> displayData;

  /// SDK generated id of this transform instance.
  core.String id;

  /// User names for all collection inputs to this transform.
  core.List<core.String> inputCollectionName;

  /// Type of transform.
  /// Possible string values are:
  /// - "UNKNOWN_KIND" : Unrecognized transform type.
  /// - "PAR_DO_KIND" : ParDo transform.
  /// - "GROUP_BY_KEY_KIND" : Group By Key transform.
  /// - "FLATTEN_KIND" : Flatten transform.
  /// - "READ_KIND" : Read transform.
  /// - "WRITE_KIND" : Write transform.
  /// - "CONSTANT_KIND" : Constructs from a constant value, such as with
  /// Create.of.
  /// - "SINGLETON_KIND" : Creates a Singleton view of a collection.
  /// - "SHUFFLE_KIND" : Opening or closing a shuffle session, often as part of
  /// a GroupByKey.
  core.String kind;

  /// User provided name for this transform instance.
  core.String name;

  /// User  names for all collection outputs to this transform.
  core.List<core.String> outputCollectionName;

  TransformSummary();

  TransformSummary.fromJson(core.Map _json) {
    if (_json.containsKey("displayData")) {
      displayData = _json["displayData"]
          .map((value) => new DisplayData.fromJson(value))
          .toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("inputCollectionName")) {
      inputCollectionName = _json["inputCollectionName"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("outputCollectionName")) {
      outputCollectionName = _json["outputCollectionName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (displayData != null) {
      _json["displayData"] =
          displayData.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (inputCollectionName != null) {
      _json["inputCollectionName"] = inputCollectionName;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (outputCollectionName != null) {
      _json["outputCollectionName"] = outputCollectionName;
    }
    return _json;
  }
}

/// WorkItem represents basic information about a WorkItem to be executed
/// in the cloud.
class WorkItem {
  /// Work item-specific configuration as an opaque blob.
  core.String configuration;

  /// Identifies this WorkItem.
  core.String id;

  /// The initial index to use when reporting the status of the WorkItem.
  core.String initialReportIndex;

  /// Identifies the workflow job this WorkItem belongs to.
  core.String jobId;

  /// Time when the lease on this Work will expire.
  core.String leaseExpireTime;

  /// Additional information for MapTask WorkItems.
  MapTask mapTask;

  /// Any required packages that need to be fetched in order to execute
  /// this WorkItem.
  core.List<Package> packages;

  /// Identifies the cloud project this WorkItem belongs to.
  core.String projectId;

  /// Recommended reporting interval.
  core.String reportStatusInterval;

  /// Additional information for SeqMapTask WorkItems.
  SeqMapTask seqMapTask;

  /// Additional information for ShellTask WorkItems.
  ShellTask shellTask;

  /// Additional information for source operation WorkItems.
  SourceOperationRequest sourceOperationTask;

  /// Additional information for StreamingComputationTask WorkItems.
  StreamingComputationTask streamingComputationTask;

  /// Additional information for StreamingConfigTask WorkItems.
  StreamingConfigTask streamingConfigTask;

  /// Additional information for StreamingSetupTask WorkItems.
  StreamingSetupTask streamingSetupTask;

  WorkItem();

  WorkItem.fromJson(core.Map _json) {
    if (_json.containsKey("configuration")) {
      configuration = _json["configuration"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("initialReportIndex")) {
      initialReportIndex = _json["initialReportIndex"];
    }
    if (_json.containsKey("jobId")) {
      jobId = _json["jobId"];
    }
    if (_json.containsKey("leaseExpireTime")) {
      leaseExpireTime = _json["leaseExpireTime"];
    }
    if (_json.containsKey("mapTask")) {
      mapTask = new MapTask.fromJson(_json["mapTask"]);
    }
    if (_json.containsKey("packages")) {
      packages = _json["packages"]
          .map((value) => new Package.fromJson(value))
          .toList();
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("reportStatusInterval")) {
      reportStatusInterval = _json["reportStatusInterval"];
    }
    if (_json.containsKey("seqMapTask")) {
      seqMapTask = new SeqMapTask.fromJson(_json["seqMapTask"]);
    }
    if (_json.containsKey("shellTask")) {
      shellTask = new ShellTask.fromJson(_json["shellTask"]);
    }
    if (_json.containsKey("sourceOperationTask")) {
      sourceOperationTask =
          new SourceOperationRequest.fromJson(_json["sourceOperationTask"]);
    }
    if (_json.containsKey("streamingComputationTask")) {
      streamingComputationTask = new StreamingComputationTask.fromJson(
          _json["streamingComputationTask"]);
    }
    if (_json.containsKey("streamingConfigTask")) {
      streamingConfigTask =
          new StreamingConfigTask.fromJson(_json["streamingConfigTask"]);
    }
    if (_json.containsKey("streamingSetupTask")) {
      streamingSetupTask =
          new StreamingSetupTask.fromJson(_json["streamingSetupTask"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (configuration != null) {
      _json["configuration"] = configuration;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (initialReportIndex != null) {
      _json["initialReportIndex"] = initialReportIndex;
    }
    if (jobId != null) {
      _json["jobId"] = jobId;
    }
    if (leaseExpireTime != null) {
      _json["leaseExpireTime"] = leaseExpireTime;
    }
    if (mapTask != null) {
      _json["mapTask"] = (mapTask).toJson();
    }
    if (packages != null) {
      _json["packages"] = packages.map((value) => (value).toJson()).toList();
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (reportStatusInterval != null) {
      _json["reportStatusInterval"] = reportStatusInterval;
    }
    if (seqMapTask != null) {
      _json["seqMapTask"] = (seqMapTask).toJson();
    }
    if (shellTask != null) {
      _json["shellTask"] = (shellTask).toJson();
    }
    if (sourceOperationTask != null) {
      _json["sourceOperationTask"] = (sourceOperationTask).toJson();
    }
    if (streamingComputationTask != null) {
      _json["streamingComputationTask"] = (streamingComputationTask).toJson();
    }
    if (streamingConfigTask != null) {
      _json["streamingConfigTask"] = (streamingConfigTask).toJson();
    }
    if (streamingSetupTask != null) {
      _json["streamingSetupTask"] = (streamingSetupTask).toJson();
    }
    return _json;
  }
}

/// The Dataflow service's idea of the current state of a WorkItem
/// being processed by a worker.
class WorkItemServiceState {
  /// Other data returned by the service, specific to the particular
  /// worker harness.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> harnessData;

  /// Time at which the current lease will expire.
  core.String leaseExpireTime;

  /// The short ids that workers should use in subsequent metric updates.
  /// Workers should strive to use short ids whenever possible, but it is ok
  /// to request the short_id again if a worker lost track of it
  /// (e.g. if the worker is recovering from a crash).
  /// NOTE: it is possible that the response may have short ids for a subset
  /// of the metrics.
  core.List<MetricShortId> metricShortId;

  /// The index value to use for the next report sent by the worker.
  /// Note: If the report call fails for whatever reason, the worker should
  /// reuse this index for subsequent report attempts.
  core.String nextReportIndex;

  /// New recommended reporting interval.
  core.String reportStatusInterval;

  /// The progress point in the WorkItem where the Dataflow service
  /// suggests that the worker truncate the task.
  ApproximateSplitRequest splitRequest;

  /// DEPRECATED in favor of split_request.
  ApproximateProgress suggestedStopPoint;

  /// Obsolete, always empty.
  Position suggestedStopPosition;

  WorkItemServiceState();

  WorkItemServiceState.fromJson(core.Map _json) {
    if (_json.containsKey("harnessData")) {
      harnessData = _json["harnessData"];
    }
    if (_json.containsKey("leaseExpireTime")) {
      leaseExpireTime = _json["leaseExpireTime"];
    }
    if (_json.containsKey("metricShortId")) {
      metricShortId = _json["metricShortId"]
          .map((value) => new MetricShortId.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextReportIndex")) {
      nextReportIndex = _json["nextReportIndex"];
    }
    if (_json.containsKey("reportStatusInterval")) {
      reportStatusInterval = _json["reportStatusInterval"];
    }
    if (_json.containsKey("splitRequest")) {
      splitRequest =
          new ApproximateSplitRequest.fromJson(_json["splitRequest"]);
    }
    if (_json.containsKey("suggestedStopPoint")) {
      suggestedStopPoint =
          new ApproximateProgress.fromJson(_json["suggestedStopPoint"]);
    }
    if (_json.containsKey("suggestedStopPosition")) {
      suggestedStopPosition =
          new Position.fromJson(_json["suggestedStopPosition"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (harnessData != null) {
      _json["harnessData"] = harnessData;
    }
    if (leaseExpireTime != null) {
      _json["leaseExpireTime"] = leaseExpireTime;
    }
    if (metricShortId != null) {
      _json["metricShortId"] =
          metricShortId.map((value) => (value).toJson()).toList();
    }
    if (nextReportIndex != null) {
      _json["nextReportIndex"] = nextReportIndex;
    }
    if (reportStatusInterval != null) {
      _json["reportStatusInterval"] = reportStatusInterval;
    }
    if (splitRequest != null) {
      _json["splitRequest"] = (splitRequest).toJson();
    }
    if (suggestedStopPoint != null) {
      _json["suggestedStopPoint"] = (suggestedStopPoint).toJson();
    }
    if (suggestedStopPosition != null) {
      _json["suggestedStopPosition"] = (suggestedStopPosition).toJson();
    }
    return _json;
  }
}

/// Conveys a worker's progress through the work described by a WorkItem.
class WorkItemStatus {
  /// True if the WorkItem was completed (successfully or unsuccessfully).
  core.bool completed;

  /// Worker output counters for this WorkItem.
  core.List<CounterUpdate> counterUpdates;

  /// See documentation of stop_position.
  DynamicSourceSplit dynamicSourceSplit;

  /// Specifies errors which occurred during processing.  If errors are
  /// provided, and completed = true, then the WorkItem is considered
  /// to have failed.
  core.List<Status> errors;

  /// DEPRECATED in favor of counter_updates.
  core.List<MetricUpdate> metricUpdates;

  /// DEPRECATED in favor of reported_progress.
  ApproximateProgress progress;

  /// The report index.  When a WorkItem is leased, the lease will
  /// contain an initial report index.  When a WorkItem's status is
  /// reported to the system, the report should be sent with
  /// that report index, and the response will contain the index the
  /// worker should use for the next report.  Reports received with
  /// unexpected index values will be rejected by the service.
  ///
  /// In order to preserve idempotency, the worker should not alter the
  /// contents of a report, even if the worker must submit the same
  /// report multiple times before getting back a response.  The worker
  /// should not submit a subsequent report until the response for the
  /// previous report had been received from the service.
  core.String reportIndex;

  /// The worker's progress through this WorkItem.
  ApproximateReportedProgress reportedProgress;

  /// Amount of time the worker requests for its lease.
  core.String requestedLeaseDuration;

  /// DEPRECATED in favor of dynamic_source_split.
  SourceFork sourceFork;

  /// If the work item represented a SourceOperationRequest, and the work
  /// is completed, contains the result of the operation.
  SourceOperationResponse sourceOperationResponse;

  /// A worker may split an active map task in two parts, "primary" and
  /// "residual", continuing to process the primary part and returning the
  /// residual part into the pool of available work.
  /// This event is called a "dynamic split" and is critical to the dynamic
  /// work rebalancing feature. The two obtained sub-tasks are called
  /// "parts" of the split.
  /// The parts, if concatenated, must represent the same input as would
  /// be read by the current task if the split did not happen.
  /// The exact way in which the original task is decomposed into the two
  /// parts is specified either as a position demarcating them
  /// (stop_position), or explicitly as two DerivedSources, if this
  /// task consumes a user-defined source type (dynamic_source_split).
  ///
  /// The "current" task is adjusted as a result of the split: after a task
  /// with range [A, B) sends a stop_position update at C, its range is
  /// considered to be [A, C), e.g.:
  /// * Progress should be interpreted relative to the new range, e.g.
  ///   "75% completed" means "75% of [A, C) completed"
  /// * The worker should interpret proposed_stop_position relative to the
  ///   new range, e.g. "split at 68%" should be interpreted as
  ///   "split at 68% of [A, C)".
  /// * If the worker chooses to split again using stop_position, only
  ///   stop_positions in [A, C) will be accepted.
  /// * Etc.
  /// dynamic_source_split has similar semantics: e.g., if a task with
  /// source S splits using dynamic_source_split into {P, R}
  /// (where P and R must be together equivalent to S), then subsequent
  /// progress and proposed_stop_position should be interpreted relative
  /// to P, and in a potential subsequent dynamic_source_split into {P', R'},
  /// P' and R' must be together equivalent to P, etc.
  Position stopPosition;

  /// Identifies the WorkItem.
  core.String workItemId;

  WorkItemStatus();

  WorkItemStatus.fromJson(core.Map _json) {
    if (_json.containsKey("completed")) {
      completed = _json["completed"];
    }
    if (_json.containsKey("counterUpdates")) {
      counterUpdates = _json["counterUpdates"]
          .map((value) => new CounterUpdate.fromJson(value))
          .toList();
    }
    if (_json.containsKey("dynamicSourceSplit")) {
      dynamicSourceSplit =
          new DynamicSourceSplit.fromJson(_json["dynamicSourceSplit"]);
    }
    if (_json.containsKey("errors")) {
      errors =
          _json["errors"].map((value) => new Status.fromJson(value)).toList();
    }
    if (_json.containsKey("metricUpdates")) {
      metricUpdates = _json["metricUpdates"]
          .map((value) => new MetricUpdate.fromJson(value))
          .toList();
    }
    if (_json.containsKey("progress")) {
      progress = new ApproximateProgress.fromJson(_json["progress"]);
    }
    if (_json.containsKey("reportIndex")) {
      reportIndex = _json["reportIndex"];
    }
    if (_json.containsKey("reportedProgress")) {
      reportedProgress =
          new ApproximateReportedProgress.fromJson(_json["reportedProgress"]);
    }
    if (_json.containsKey("requestedLeaseDuration")) {
      requestedLeaseDuration = _json["requestedLeaseDuration"];
    }
    if (_json.containsKey("sourceFork")) {
      sourceFork = new SourceFork.fromJson(_json["sourceFork"]);
    }
    if (_json.containsKey("sourceOperationResponse")) {
      sourceOperationResponse = new SourceOperationResponse.fromJson(
          _json["sourceOperationResponse"]);
    }
    if (_json.containsKey("stopPosition")) {
      stopPosition = new Position.fromJson(_json["stopPosition"]);
    }
    if (_json.containsKey("workItemId")) {
      workItemId = _json["workItemId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (completed != null) {
      _json["completed"] = completed;
    }
    if (counterUpdates != null) {
      _json["counterUpdates"] =
          counterUpdates.map((value) => (value).toJson()).toList();
    }
    if (dynamicSourceSplit != null) {
      _json["dynamicSourceSplit"] = (dynamicSourceSplit).toJson();
    }
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    if (metricUpdates != null) {
      _json["metricUpdates"] =
          metricUpdates.map((value) => (value).toJson()).toList();
    }
    if (progress != null) {
      _json["progress"] = (progress).toJson();
    }
    if (reportIndex != null) {
      _json["reportIndex"] = reportIndex;
    }
    if (reportedProgress != null) {
      _json["reportedProgress"] = (reportedProgress).toJson();
    }
    if (requestedLeaseDuration != null) {
      _json["requestedLeaseDuration"] = requestedLeaseDuration;
    }
    if (sourceFork != null) {
      _json["sourceFork"] = (sourceFork).toJson();
    }
    if (sourceOperationResponse != null) {
      _json["sourceOperationResponse"] = (sourceOperationResponse).toJson();
    }
    if (stopPosition != null) {
      _json["stopPosition"] = (stopPosition).toJson();
    }
    if (workItemId != null) {
      _json["workItemId"] = workItemId;
    }
    return _json;
  }
}

/// WorkerHealthReport contains information about the health of a worker.
///
/// The VM should be identified by the labels attached to the WorkerMessage that
/// this health ping belongs to.
class WorkerHealthReport {
  /// The pods running on the worker. See:
  /// http://kubernetes.io/v1.1/docs/api-reference/v1/definitions.html#_v1_pod
  ///
  /// This field is used by the worker to send the status of the indvidual
  /// containers running on each worker.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.List<core.Map<core.String, core.Object>> pods;

  /// The interval at which the worker is sending health reports.
  /// The default value of 0 should be interpreted as the field is not being
  /// explicitly set by the worker.
  core.String reportInterval;

  /// Whether the VM is healthy.
  core.bool vmIsHealthy;

  /// The time the VM was booted.
  core.String vmStartupTime;

  WorkerHealthReport();

  WorkerHealthReport.fromJson(core.Map _json) {
    if (_json.containsKey("pods")) {
      pods = _json["pods"];
    }
    if (_json.containsKey("reportInterval")) {
      reportInterval = _json["reportInterval"];
    }
    if (_json.containsKey("vmIsHealthy")) {
      vmIsHealthy = _json["vmIsHealthy"];
    }
    if (_json.containsKey("vmStartupTime")) {
      vmStartupTime = _json["vmStartupTime"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (pods != null) {
      _json["pods"] = pods;
    }
    if (reportInterval != null) {
      _json["reportInterval"] = reportInterval;
    }
    if (vmIsHealthy != null) {
      _json["vmIsHealthy"] = vmIsHealthy;
    }
    if (vmStartupTime != null) {
      _json["vmStartupTime"] = vmStartupTime;
    }
    return _json;
  }
}

/// WorkerHealthReportResponse contains information returned to the worker
/// in response to a health ping.
class WorkerHealthReportResponse {
  /// A positive value indicates the worker should change its reporting interval
  /// to the specified value.
  ///
  /// The default value of zero means no change in report rate is requested by
  /// the server.
  core.String reportInterval;

  WorkerHealthReportResponse();

  WorkerHealthReportResponse.fromJson(core.Map _json) {
    if (_json.containsKey("reportInterval")) {
      reportInterval = _json["reportInterval"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (reportInterval != null) {
      _json["reportInterval"] = reportInterval;
    }
    return _json;
  }
}

/// WorkerMessage provides information to the backend about a worker.
class WorkerMessage {
  /// Labels are used to group WorkerMessages.
  /// For example, a worker_message about a particular container
  /// might have the labels:
  /// { "JOB_ID": "2015-04-22",
  ///   "WORKER_ID": "wordcount-vm-2015…"
  ///   "CONTAINER_TYPE": "worker",
  ///   "CONTAINER_ID": "ac1234def"}
  /// Label tags typically correspond to Label enum values. However, for ease
  /// of development other strings can be used as tags. LABEL_UNSPECIFIED should
  /// not be used here.
  core.Map<core.String, core.String> labels;

  /// The timestamp of the worker_message.
  core.String time;

  /// The health of a worker.
  WorkerHealthReport workerHealthReport;

  /// A worker message code.
  WorkerMessageCode workerMessageCode;

  /// Resource metrics reported by workers.
  ResourceUtilizationReport workerMetrics;

  /// Shutdown notice by workers.
  WorkerShutdownNotice workerShutdownNotice;

  WorkerMessage();

  WorkerMessage.fromJson(core.Map _json) {
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("time")) {
      time = _json["time"];
    }
    if (_json.containsKey("workerHealthReport")) {
      workerHealthReport =
          new WorkerHealthReport.fromJson(_json["workerHealthReport"]);
    }
    if (_json.containsKey("workerMessageCode")) {
      workerMessageCode =
          new WorkerMessageCode.fromJson(_json["workerMessageCode"]);
    }
    if (_json.containsKey("workerMetrics")) {
      workerMetrics =
          new ResourceUtilizationReport.fromJson(_json["workerMetrics"]);
    }
    if (_json.containsKey("workerShutdownNotice")) {
      workerShutdownNotice =
          new WorkerShutdownNotice.fromJson(_json["workerShutdownNotice"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (time != null) {
      _json["time"] = time;
    }
    if (workerHealthReport != null) {
      _json["workerHealthReport"] = (workerHealthReport).toJson();
    }
    if (workerMessageCode != null) {
      _json["workerMessageCode"] = (workerMessageCode).toJson();
    }
    if (workerMetrics != null) {
      _json["workerMetrics"] = (workerMetrics).toJson();
    }
    if (workerShutdownNotice != null) {
      _json["workerShutdownNotice"] = (workerShutdownNotice).toJson();
    }
    return _json;
  }
}

/// A message code is used to report status and error messages to the service.
/// The message codes are intended to be machine readable. The service will
/// take care of translating these into user understandable messages if
/// necessary.
///
/// Example use cases:
///   1. Worker processes reporting successful startup.
///   2. Worker processes reporting specific errors (e.g. package staging
///      failure).
class WorkerMessageCode {
  /// The code is a string intended for consumption by a machine that identifies
  /// the type of message being sent.
  /// Examples:
  ///  1. "HARNESS_STARTED" might be used to indicate the worker harness has
  ///      started.
  ///  2. "GCS_DOWNLOAD_ERROR" might be used to indicate an error downloading
  /// a GCS file as part of the boot process of one of the worker containers.
  ///
  /// This is a string and not an enum to make it easy to add new codes without
  /// waiting for an API change.
  core.String code;

  /// Parameters contains specific information about the code.
  ///
  /// This is a struct to allow parameters of different types.
  ///
  /// Examples:
  ///  1. For a "HARNESS_STARTED" message parameters might provide the name
  ///     of the worker and additional data like timing information.
  ///  2. For a "GCS_DOWNLOAD_ERROR" parameters might contain fields listing
  ///     the GCS objects being downloaded and fields containing errors.
  ///
  /// In general complex data structures should be avoided. If a worker
  /// needs to send a specific and complicated data structure then please
  /// consider defining a new proto and adding it to the data oneof in
  /// WorkerMessageResponse.
  ///
  /// Conventions:
  /// Parameters should only be used for information that isn't typically passed
  ///  as a label.
  ///  hostname and other worker identifiers should almost always be passed
  ///  as labels since they will be included on most messages.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> parameters;

  WorkerMessageCode();

  WorkerMessageCode.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("parameters")) {
      parameters = _json["parameters"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (code != null) {
      _json["code"] = code;
    }
    if (parameters != null) {
      _json["parameters"] = parameters;
    }
    return _json;
  }
}

/// A worker_message response allows the server to pass information to the
/// sender.
class WorkerMessageResponse {
  /// The service's response to a worker's health report.
  WorkerHealthReportResponse workerHealthReportResponse;

  /// Service's response to reporting worker metrics (currently empty).
  ResourceUtilizationReportResponse workerMetricsResponse;

  /// Service's response to shutdown notice (currently empty).
  WorkerShutdownNoticeResponse workerShutdownNoticeResponse;

  WorkerMessageResponse();

  WorkerMessageResponse.fromJson(core.Map _json) {
    if (_json.containsKey("workerHealthReportResponse")) {
      workerHealthReportResponse = new WorkerHealthReportResponse.fromJson(
          _json["workerHealthReportResponse"]);
    }
    if (_json.containsKey("workerMetricsResponse")) {
      workerMetricsResponse = new ResourceUtilizationReportResponse.fromJson(
          _json["workerMetricsResponse"]);
    }
    if (_json.containsKey("workerShutdownNoticeResponse")) {
      workerShutdownNoticeResponse = new WorkerShutdownNoticeResponse.fromJson(
          _json["workerShutdownNoticeResponse"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (workerHealthReportResponse != null) {
      _json["workerHealthReportResponse"] =
          (workerHealthReportResponse).toJson();
    }
    if (workerMetricsResponse != null) {
      _json["workerMetricsResponse"] = (workerMetricsResponse).toJson();
    }
    if (workerShutdownNoticeResponse != null) {
      _json["workerShutdownNoticeResponse"] =
          (workerShutdownNoticeResponse).toJson();
    }
    return _json;
  }
}

/// Describes one particular pool of Cloud Dataflow workers to be
/// instantiated by the Cloud Dataflow service in order to perform the
/// computations required by a job.  Note that a workflow job may use
/// multiple pools, in order to match the various computational
/// requirements of the various stages of the job.
class WorkerPool {
  /// Settings for autoscaling of this WorkerPool.
  AutoscalingSettings autoscalingSettings;

  /// Data disks that are used by a VM in this workflow.
  core.List<Disk> dataDisks;

  /// The default package set to install.  This allows the service to
  /// select a default set of packages which are useful to worker
  /// harnesses written in a particular language.
  /// Possible string values are:
  /// - "DEFAULT_PACKAGE_SET_UNKNOWN" : The default set of packages to stage is
  /// unknown, or unspecified.
  /// - "DEFAULT_PACKAGE_SET_NONE" : Indicates that no packages should be staged
  /// at the worker unless
  /// explicitly specified by the job.
  /// - "DEFAULT_PACKAGE_SET_JAVA" : Stage packages typically useful to workers
  /// written in Java.
  /// - "DEFAULT_PACKAGE_SET_PYTHON" : Stage pacakges typically useful to
  /// workers written in Python.
  core.String defaultPackageSet;

  /// Size of root disk for VMs, in GB.  If zero or unspecified, the service
  /// will
  /// attempt to choose a reasonable default.
  core.int diskSizeGb;

  /// Fully qualified source image for disks.
  core.String diskSourceImage;

  /// Type of root disk for VMs.  If empty or unspecified, the service will
  /// attempt to choose a reasonable default.
  core.String diskType;

  /// Configuration for VM IPs.
  /// Possible string values are:
  /// - "WORKER_IP_UNSPECIFIED" : The configuration is unknown, or unspecified.
  /// - "WORKER_IP_PUBLIC" : Workers should have public IP addresses.
  /// - "WORKER_IP_PRIVATE" : Workers should have private IP addresses.
  core.String ipConfiguration;

  /// The kind of the worker pool; currently only `harness` and `shuffle`
  /// are supported.
  core.String kind;

  /// Machine type (e.g. "n1-standard-1").  If empty or unspecified, the
  /// service will attempt to choose a reasonable default.
  core.String machineType;

  /// Metadata to set on the Google Compute Engine VMs.
  core.Map<core.String, core.String> metadata;

  /// Network to which VMs will be assigned.  If empty or unspecified,
  /// the service will use the network "default".
  core.String network;

  /// The number of threads per worker harness. If empty or unspecified, the
  /// service will choose a number of threads (according to the number of cores
  /// on the selected machine type for batch, or 1 by convention for streaming).
  core.int numThreadsPerWorker;

  /// Number of Google Compute Engine workers in this pool needed to
  /// execute the job.  If zero or unspecified, the service will
  /// attempt to choose a reasonable default.
  core.int numWorkers;

  /// The action to take on host maintenance, as defined by the Google
  /// Compute Engine API.
  core.String onHostMaintenance;

  /// Packages to be installed on workers.
  core.List<Package> packages;

  /// Extra arguments for this worker pool.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> poolArgs;

  /// Subnetwork to which VMs will be assigned, if desired.  Expected to be of
  /// the form "regions/REGION/subnetworks/SUBNETWORK".
  core.String subnetwork;

  /// Settings passed through to Google Compute Engine workers when
  /// using the standard Dataflow task runner.  Users should ignore
  /// this field.
  TaskRunnerSettings taskrunnerSettings;

  /// Sets the policy for determining when to turndown worker pool.
  /// Allowed values are: `TEARDOWN_ALWAYS`, `TEARDOWN_ON_SUCCESS`, and
  /// `TEARDOWN_NEVER`.
  /// `TEARDOWN_ALWAYS` means workers are always torn down regardless of whether
  /// the job succeeds. `TEARDOWN_ON_SUCCESS` means workers are torn down
  /// if the job succeeds. `TEARDOWN_NEVER` means the workers are never torn
  /// down.
  ///
  /// If the workers are not torn down by the service, they will
  /// continue to run and use Google Compute Engine VM resources in the
  /// user's project until they are explicitly terminated by the user.
  /// Because of this, Google recommends using the `TEARDOWN_ALWAYS`
  /// policy except for small, manually supervised test jobs.
  ///
  /// If unknown or unspecified, the service will attempt to choose a reasonable
  /// default.
  /// Possible string values are:
  /// - "TEARDOWN_POLICY_UNKNOWN" : The teardown policy isn't specified, or is
  /// unknown.
  /// - "TEARDOWN_ALWAYS" : Always teardown the resource.
  /// - "TEARDOWN_ON_SUCCESS" : Teardown the resource on success. This is useful
  /// for debugging
  /// failures.
  /// - "TEARDOWN_NEVER" : Never teardown the resource. This is useful for
  /// debugging and
  /// development.
  core.String teardownPolicy;

  /// Required. Docker container image that executes the Cloud Dataflow worker
  /// harness, residing in Google Container Registry.
  core.String workerHarnessContainerImage;

  /// Zone to run the worker pools in.  If empty or unspecified, the service
  /// will attempt to choose a reasonable default.
  core.String zone;

  WorkerPool();

  WorkerPool.fromJson(core.Map _json) {
    if (_json.containsKey("autoscalingSettings")) {
      autoscalingSettings =
          new AutoscalingSettings.fromJson(_json["autoscalingSettings"]);
    }
    if (_json.containsKey("dataDisks")) {
      dataDisks =
          _json["dataDisks"].map((value) => new Disk.fromJson(value)).toList();
    }
    if (_json.containsKey("defaultPackageSet")) {
      defaultPackageSet = _json["defaultPackageSet"];
    }
    if (_json.containsKey("diskSizeGb")) {
      diskSizeGb = _json["diskSizeGb"];
    }
    if (_json.containsKey("diskSourceImage")) {
      diskSourceImage = _json["diskSourceImage"];
    }
    if (_json.containsKey("diskType")) {
      diskType = _json["diskType"];
    }
    if (_json.containsKey("ipConfiguration")) {
      ipConfiguration = _json["ipConfiguration"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("machineType")) {
      machineType = _json["machineType"];
    }
    if (_json.containsKey("metadata")) {
      metadata = _json["metadata"];
    }
    if (_json.containsKey("network")) {
      network = _json["network"];
    }
    if (_json.containsKey("numThreadsPerWorker")) {
      numThreadsPerWorker = _json["numThreadsPerWorker"];
    }
    if (_json.containsKey("numWorkers")) {
      numWorkers = _json["numWorkers"];
    }
    if (_json.containsKey("onHostMaintenance")) {
      onHostMaintenance = _json["onHostMaintenance"];
    }
    if (_json.containsKey("packages")) {
      packages = _json["packages"]
          .map((value) => new Package.fromJson(value))
          .toList();
    }
    if (_json.containsKey("poolArgs")) {
      poolArgs = _json["poolArgs"];
    }
    if (_json.containsKey("subnetwork")) {
      subnetwork = _json["subnetwork"];
    }
    if (_json.containsKey("taskrunnerSettings")) {
      taskrunnerSettings =
          new TaskRunnerSettings.fromJson(_json["taskrunnerSettings"]);
    }
    if (_json.containsKey("teardownPolicy")) {
      teardownPolicy = _json["teardownPolicy"];
    }
    if (_json.containsKey("workerHarnessContainerImage")) {
      workerHarnessContainerImage = _json["workerHarnessContainerImage"];
    }
    if (_json.containsKey("zone")) {
      zone = _json["zone"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (autoscalingSettings != null) {
      _json["autoscalingSettings"] = (autoscalingSettings).toJson();
    }
    if (dataDisks != null) {
      _json["dataDisks"] = dataDisks.map((value) => (value).toJson()).toList();
    }
    if (defaultPackageSet != null) {
      _json["defaultPackageSet"] = defaultPackageSet;
    }
    if (diskSizeGb != null) {
      _json["diskSizeGb"] = diskSizeGb;
    }
    if (diskSourceImage != null) {
      _json["diskSourceImage"] = diskSourceImage;
    }
    if (diskType != null) {
      _json["diskType"] = diskType;
    }
    if (ipConfiguration != null) {
      _json["ipConfiguration"] = ipConfiguration;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (machineType != null) {
      _json["machineType"] = machineType;
    }
    if (metadata != null) {
      _json["metadata"] = metadata;
    }
    if (network != null) {
      _json["network"] = network;
    }
    if (numThreadsPerWorker != null) {
      _json["numThreadsPerWorker"] = numThreadsPerWorker;
    }
    if (numWorkers != null) {
      _json["numWorkers"] = numWorkers;
    }
    if (onHostMaintenance != null) {
      _json["onHostMaintenance"] = onHostMaintenance;
    }
    if (packages != null) {
      _json["packages"] = packages.map((value) => (value).toJson()).toList();
    }
    if (poolArgs != null) {
      _json["poolArgs"] = poolArgs;
    }
    if (subnetwork != null) {
      _json["subnetwork"] = subnetwork;
    }
    if (taskrunnerSettings != null) {
      _json["taskrunnerSettings"] = (taskrunnerSettings).toJson();
    }
    if (teardownPolicy != null) {
      _json["teardownPolicy"] = teardownPolicy;
    }
    if (workerHarnessContainerImage != null) {
      _json["workerHarnessContainerImage"] = workerHarnessContainerImage;
    }
    if (zone != null) {
      _json["zone"] = zone;
    }
    return _json;
  }
}

/// Provides data to pass through to the worker harness.
class WorkerSettings {
  /// The base URL for accessing Google Cloud APIs.
  ///
  /// When workers access Google Cloud APIs, they logically do so via
  /// relative URLs.  If this field is specified, it supplies the base
  /// URL to use for resolving these relative URLs.  The normative
  /// algorithm used is defined by RFC 1808, "Relative Uniform Resource
  /// Locators".
  ///
  /// If not specified, the default value is "http://www.googleapis.com/"
  core.String baseUrl;

  /// Whether to send work progress updates to the service.
  core.bool reportingEnabled;

  /// The Cloud Dataflow service path relative to the root URL, for example,
  /// "dataflow/v1b3/projects".
  core.String servicePath;

  /// The Shuffle service path relative to the root URL, for example,
  /// "shuffle/v1beta1".
  core.String shuffleServicePath;

  /// The prefix of the resources the system should use for temporary
  /// storage.
  ///
  /// The supported resource type is:
  ///
  /// Google Cloud Storage:
  ///
  ///   storage.googleapis.com/{bucket}/{object}
  ///   bucket.storage.googleapis.com/{object}
  core.String tempStoragePrefix;

  /// The ID of the worker running this pipeline.
  core.String workerId;

  WorkerSettings();

  WorkerSettings.fromJson(core.Map _json) {
    if (_json.containsKey("baseUrl")) {
      baseUrl = _json["baseUrl"];
    }
    if (_json.containsKey("reportingEnabled")) {
      reportingEnabled = _json["reportingEnabled"];
    }
    if (_json.containsKey("servicePath")) {
      servicePath = _json["servicePath"];
    }
    if (_json.containsKey("shuffleServicePath")) {
      shuffleServicePath = _json["shuffleServicePath"];
    }
    if (_json.containsKey("tempStoragePrefix")) {
      tempStoragePrefix = _json["tempStoragePrefix"];
    }
    if (_json.containsKey("workerId")) {
      workerId = _json["workerId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (baseUrl != null) {
      _json["baseUrl"] = baseUrl;
    }
    if (reportingEnabled != null) {
      _json["reportingEnabled"] = reportingEnabled;
    }
    if (servicePath != null) {
      _json["servicePath"] = servicePath;
    }
    if (shuffleServicePath != null) {
      _json["shuffleServicePath"] = shuffleServicePath;
    }
    if (tempStoragePrefix != null) {
      _json["tempStoragePrefix"] = tempStoragePrefix;
    }
    if (workerId != null) {
      _json["workerId"] = workerId;
    }
    return _json;
  }
}

/// Shutdown notification from workers. This is to be sent by the shutdown
/// script of the worker VM so that the backend knows that the VM is being
/// shut down.
class WorkerShutdownNotice {
  /// Optional reason to be attached for the shutdown notice.
  /// For example: "PREEMPTION" would indicate the VM is being shut down because
  /// of preemption. Other possible reasons may be added in the future.
  core.String reason;

  WorkerShutdownNotice();

  WorkerShutdownNotice.fromJson(core.Map _json) {
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (reason != null) {
      _json["reason"] = reason;
    }
    return _json;
  }
}

/// Service-side response to WorkerMessage issuing shutdown notice.
class WorkerShutdownNoticeResponse {
  WorkerShutdownNoticeResponse();

  WorkerShutdownNoticeResponse.fromJson(core.Map _json) {}

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    return _json;
  }
}

/// An instruction that writes records.
/// Takes one input, produces no outputs.
class WriteInstruction {
  /// The input.
  InstructionInput input;

  /// The sink to write to.
  Sink sink;

  WriteInstruction();

  WriteInstruction.fromJson(core.Map _json) {
    if (_json.containsKey("input")) {
      input = new InstructionInput.fromJson(_json["input"]);
    }
    if (_json.containsKey("sink")) {
      sink = new Sink.fromJson(_json["sink"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (input != null) {
      _json["input"] = (input).toJson();
    }
    if (sink != null) {
      _json["sink"] = (sink).toJson();
    }
    return _json;
  }
}
