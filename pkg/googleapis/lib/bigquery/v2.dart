// This is a generated file (see the discoveryapis_generator project).

library googleapis.bigquery.v2;

import 'dart:core' as core;
import 'dart:collection' as collection;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client bigquery/v2';

/** A data platform for customers to create, manage, share and query data. */
class BigqueryApi {
  /** View and manage your data in Google BigQuery */
  static const BigqueryScope = "https://www.googleapis.com/auth/bigquery";

  /** Insert data into Google BigQuery */
  static const BigqueryInsertdataScope = "https://www.googleapis.com/auth/bigquery.insertdata";

  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /** View your data across Google Cloud Platform services */
  static const CloudPlatformReadOnlyScope = "https://www.googleapis.com/auth/cloud-platform.read-only";

  /** Manage your data and permissions in Google Cloud Storage */
  static const DevstorageFullControlScope = "https://www.googleapis.com/auth/devstorage.full_control";

  /** View your data in Google Cloud Storage */
  static const DevstorageReadOnlyScope = "https://www.googleapis.com/auth/devstorage.read_only";

  /** Manage your data in Google Cloud Storage */
  static const DevstorageReadWriteScope = "https://www.googleapis.com/auth/devstorage.read_write";


  final commons.ApiRequester _requester;

  DatasetsResourceApi get datasets => new DatasetsResourceApi(_requester);
  JobsResourceApi get jobs => new JobsResourceApi(_requester);
  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);
  TabledataResourceApi get tabledata => new TabledataResourceApi(_requester);
  TablesResourceApi get tables => new TablesResourceApi(_requester);

  BigqueryApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "bigquery/v2/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class DatasetsResourceApi {
  final commons.ApiRequester _requester;

  DatasetsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes the dataset specified by the datasetId value. Before you can delete
   * a dataset, you must delete all its tables, either manually or by specifying
   * deleteContents. Immediately after deletion, you can create another dataset
   * with the same name.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the dataset being deleted
   *
   * [datasetId] - Dataset ID of dataset being deleted
   *
   * [deleteContents] - If True, delete all the tables in the dataset. If False
   * and the dataset contains tables, the request will fail. Default is False
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String projectId, core.String datasetId, {core.bool deleteContents}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }
    if (deleteContents != null) {
      _queryParams["deleteContents"] = ["${deleteContents}"];
    }

    _downloadOptions = null;

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId');

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
   * Returns the dataset specified by datasetID.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the requested dataset
   *
   * [datasetId] - Dataset ID of the requested dataset
   *
   * Completes with a [Dataset].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Dataset> get(core.String projectId, core.String datasetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Dataset.fromJson(data));
  }

  /**
   * Creates a new empty dataset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the new dataset
   *
   * Completes with a [Dataset].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Dataset> insert(Dataset request, core.String projectId) {
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

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Dataset.fromJson(data));
  }

  /**
   * Lists all datasets in the specified project to which you have been granted
   * the READER dataset role.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the datasets to be listed
   *
   * [all] - Whether to list all datasets, including hidden ones
   *
   * [filter] - An expression for filtering the results of the request by label.
   * The syntax is "labels.<name>[:<value>]". Multiple filters can be ANDed
   * together by connecting with a space. Example: "labels.department:receiving
   * labels.active". See Filtering datasets using labels for details.
   *
   * [maxResults] - The maximum number of results to return
   *
   * [pageToken] - Page token, returned by a previous call, to request the next
   * page of results
   *
   * Completes with a [DatasetList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DatasetList> list(core.String projectId, {core.bool all, core.String filter, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (all != null) {
      _queryParams["all"] = ["${all}"];
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

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DatasetList.fromJson(data));
  }

  /**
   * Updates information in an existing dataset. The update method replaces the
   * entire dataset resource, whereas the patch method only replaces fields that
   * are provided in the submitted dataset resource. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the dataset being updated
   *
   * [datasetId] - Dataset ID of the dataset being updated
   *
   * Completes with a [Dataset].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Dataset> patch(Dataset request, core.String projectId, core.String datasetId) {
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
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Dataset.fromJson(data));
  }

  /**
   * Updates information in an existing dataset. The update method replaces the
   * entire dataset resource, whereas the patch method only replaces fields that
   * are provided in the submitted dataset resource.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the dataset being updated
   *
   * [datasetId] - Dataset ID of the dataset being updated
   *
   * Completes with a [Dataset].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Dataset> update(Dataset request, core.String projectId, core.String datasetId) {
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
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Dataset.fromJson(data));
  }

}


class JobsResourceApi {
  final commons.ApiRequester _requester;

  JobsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Requests that a job be cancelled. This call will return immediately, and
   * the client will need to poll for the job status to see if the cancel
   * completed successfully. Cancelled jobs may still incur costs.
   *
   * Request parameters:
   *
   * [projectId] - [Required] Project ID of the job to cancel
   *
   * [jobId] - [Required] Job ID of the job to cancel
   *
   * Completes with a [JobCancelResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<JobCancelResponse> cancel(core.String projectId, core.String jobId) {
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

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/jobs/' + commons.Escaper.ecapeVariable('$jobId') + '/cancel';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new JobCancelResponse.fromJson(data));
  }

  /**
   * Returns information about a specific job. Job information is available for
   * a six month period after creation. Requires that you're the person who ran
   * the job, or have the Is Owner project role.
   *
   * Request parameters:
   *
   * [projectId] - [Required] Project ID of the requested job
   *
   * [jobId] - [Required] Job ID of the requested job
   *
   * Completes with a [Job].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Job> get(core.String projectId, core.String jobId) {
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

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/jobs/' + commons.Escaper.ecapeVariable('$jobId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Job.fromJson(data));
  }

  /**
   * Retrieves the results of a query job.
   *
   * Request parameters:
   *
   * [projectId] - [Required] Project ID of the query job
   *
   * [jobId] - [Required] Job ID of the query job
   *
   * [maxResults] - Maximum number of results to read
   *
   * [pageToken] - Page token, returned by a previous call, to request the next
   * page of results
   *
   * [startIndex] - Zero-based index of the starting row
   *
   * [timeoutMs] - How long to wait for the query to complete, in milliseconds,
   * before returning. Default is 10 seconds. If the timeout passes before the
   * job completes, the 'jobComplete' field in the response will be false
   *
   * Completes with a [GetQueryResultsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetQueryResultsResponse> getQueryResults(core.String projectId, core.String jobId, {core.int maxResults, core.String pageToken, core.String startIndex, core.int timeoutMs}) {
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
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = [startIndex];
    }
    if (timeoutMs != null) {
      _queryParams["timeoutMs"] = ["${timeoutMs}"];
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/queries/' + commons.Escaper.ecapeVariable('$jobId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetQueryResultsResponse.fromJson(data));
  }

  /**
   * Starts a new asynchronous job. Requires the Can View project role.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the project that will be billed for the job
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [Job].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Job> insert(Job request, core.String projectId, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
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

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/jobs';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/bigquery/v2/projects/' + commons.Escaper.ecapeVariable('$projectId') + '/jobs';
    } else {
      _url = '/upload/bigquery/v2/projects/' + commons.Escaper.ecapeVariable('$projectId') + '/jobs';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Job.fromJson(data));
  }

  /**
   * Lists all jobs that you started in the specified project. Job information
   * is available for a six month period after creation. The job list is sorted
   * in reverse chronological order, by job creation time. Requires the Can View
   * project role, or the Is Owner project role if you set the allUsers
   * property.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the jobs to list
   *
   * [allUsers] - Whether to display jobs owned by all users in the project.
   * Default false
   *
   * [maxResults] - Maximum number of results to return
   *
   * [pageToken] - Page token, returned by a previous call, to request the next
   * page of results
   *
   * [projection] - Restrict information returned to a set of selected fields
   * Possible string values are:
   * - "full" : Includes all job data
   * - "minimal" : Does not include the job configuration
   *
   * [stateFilter] - Filter for job state
   *
   * Completes with a [JobList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<JobList> list(core.String projectId, {core.bool allUsers, core.int maxResults, core.String pageToken, core.String projection, core.List<core.String> stateFilter}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (allUsers != null) {
      _queryParams["allUsers"] = ["${allUsers}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }
    if (stateFilter != null) {
      _queryParams["stateFilter"] = stateFilter;
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/jobs';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new JobList.fromJson(data));
  }

  /**
   * Runs a BigQuery SQL query synchronously and returns query results if the
   * query completes within a specified timeout.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the project billed for the query
   *
   * Completes with a [QueryResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<QueryResponse> query(QueryRequest request, core.String projectId) {
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

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/queries';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new QueryResponse.fromJson(data));
  }

}


class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists all projects to which you have been granted any project role.
   *
   * Request parameters:
   *
   * [maxResults] - Maximum number of results to return
   *
   * [pageToken] - Page token, returned by a previous call, to request the next
   * page of results
   *
   * Completes with a [ProjectList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProjectList> list({core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'projects';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProjectList.fromJson(data));
  }

}


class TabledataResourceApi {
  final commons.ApiRequester _requester;

  TabledataResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Streams data into BigQuery one record at a time without needing to run a
   * load job. Requires the WRITER dataset role.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the destination table.
   *
   * [datasetId] - Dataset ID of the destination table.
   *
   * [tableId] - Table ID of the destination table.
   *
   * Completes with a [TableDataInsertAllResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TableDataInsertAllResponse> insertAll(TableDataInsertAllRequest request, core.String projectId, core.String datasetId, core.String tableId) {
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
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }
    if (tableId == null) {
      throw new core.ArgumentError("Parameter tableId is required.");
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId') + '/tables/' + commons.Escaper.ecapeVariable('$tableId') + '/insertAll';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TableDataInsertAllResponse.fromJson(data));
  }

  /**
   * Retrieves table data from a specified set of rows. Requires the READER
   * dataset role.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the table to read
   *
   * [datasetId] - Dataset ID of the table to read
   *
   * [tableId] - Table ID of the table to read
   *
   * [maxResults] - Maximum number of results to return
   *
   * [pageToken] - Page token, returned by a previous call, identifying the
   * result set
   *
   * [startIndex] - Zero-based index of the starting row to read
   *
   * Completes with a [TableDataList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TableDataList> list(core.String projectId, core.String datasetId, core.String tableId, {core.int maxResults, core.String pageToken, core.String startIndex}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }
    if (tableId == null) {
      throw new core.ArgumentError("Parameter tableId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = [startIndex];
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId') + '/tables/' + commons.Escaper.ecapeVariable('$tableId') + '/data';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TableDataList.fromJson(data));
  }

}


class TablesResourceApi {
  final commons.ApiRequester _requester;

  TablesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes the table specified by tableId from the dataset. If the table
   * contains data, all the data will be deleted.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the table to delete
   *
   * [datasetId] - Dataset ID of the table to delete
   *
   * [tableId] - Table ID of the table to delete
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String projectId, core.String datasetId, core.String tableId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }
    if (tableId == null) {
      throw new core.ArgumentError("Parameter tableId is required.");
    }

    _downloadOptions = null;

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId') + '/tables/' + commons.Escaper.ecapeVariable('$tableId');

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
   * Gets the specified table resource by table ID. This method does not return
   * the data in the table, it only returns the table resource, which describes
   * the structure of this table.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the requested table
   *
   * [datasetId] - Dataset ID of the requested table
   *
   * [tableId] - Table ID of the requested table
   *
   * Completes with a [Table].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Table> get(core.String projectId, core.String datasetId, core.String tableId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }
    if (tableId == null) {
      throw new core.ArgumentError("Parameter tableId is required.");
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId') + '/tables/' + commons.Escaper.ecapeVariable('$tableId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Table.fromJson(data));
  }

  /**
   * Creates a new, empty table in the dataset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the new table
   *
   * [datasetId] - Dataset ID of the new table
   *
   * Completes with a [Table].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Table> insert(Table request, core.String projectId, core.String datasetId) {
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
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId') + '/tables';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Table.fromJson(data));
  }

  /**
   * Lists all tables in the specified dataset. Requires the READER dataset
   * role.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the tables to list
   *
   * [datasetId] - Dataset ID of the tables to list
   *
   * [maxResults] - Maximum number of results to return
   *
   * [pageToken] - Page token, returned by a previous call, to request the next
   * page of results
   *
   * Completes with a [TableList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TableList> list(core.String projectId, core.String datasetId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId') + '/tables';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TableList.fromJson(data));
  }

  /**
   * Updates information in an existing table. The update method replaces the
   * entire table resource, whereas the patch method only replaces fields that
   * are provided in the submitted table resource. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the table to update
   *
   * [datasetId] - Dataset ID of the table to update
   *
   * [tableId] - Table ID of the table to update
   *
   * Completes with a [Table].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Table> patch(Table request, core.String projectId, core.String datasetId, core.String tableId) {
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
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }
    if (tableId == null) {
      throw new core.ArgumentError("Parameter tableId is required.");
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId') + '/tables/' + commons.Escaper.ecapeVariable('$tableId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Table.fromJson(data));
  }

  /**
   * Updates information in an existing table. The update method replaces the
   * entire table resource, whereas the patch method only replaces fields that
   * are provided in the submitted table resource.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - Project ID of the table to update
   *
   * [datasetId] - Dataset ID of the table to update
   *
   * [tableId] - Table ID of the table to update
   *
   * Completes with a [Table].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Table> update(Table request, core.String projectId, core.String datasetId, core.String tableId) {
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
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }
    if (tableId == null) {
      throw new core.ArgumentError("Parameter tableId is required.");
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$projectId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId') + '/tables/' + commons.Escaper.ecapeVariable('$tableId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Table.fromJson(data));
  }

}



class BigtableColumn {
  /**
   * [Optional] The encoding of the values when the type is not STRING.
   * Acceptable encoding values are: TEXT - indicates values are alphanumeric
   * text strings. BINARY - indicates values are encoded using HBase
   * Bytes.toBytes family of functions. 'encoding' can also be set at the column
   * family level. However, the setting at this level takes precedence if
   * 'encoding' is set at both levels.
   */
  core.String encoding;
  /**
   * [Optional] If the qualifier is not a valid BigQuery field identifier i.e.
   * does not match [a-zA-Z][a-zA-Z0-9_]*, a valid identifier must be provided
   * as the column field name and is used as field name in queries.
   */
  core.String fieldName;
  /**
   * [Optional] If this is set, only the latest version of value in this column
   * are exposed. 'onlyReadLatest' can also be set at the column family level.
   * However, the setting at this level takes precedence if 'onlyReadLatest' is
   * set at both levels.
   */
  core.bool onlyReadLatest;
  /**
   * [Required] Qualifier of the column. Columns in the parent column family
   * that has this exact qualifier are exposed as . field. If the qualifier is
   * valid UTF-8 string, it can be specified in the qualifier_string field.
   * Otherwise, a base-64 encoded value must be set to qualifier_encoded. The
   * column field name is the same as the column qualifier. However, if the
   * qualifier is not a valid BigQuery field identifier i.e. does not match
   * [a-zA-Z][a-zA-Z0-9_]*, a valid identifier must be provided as field_name.
   */
  core.String qualifierEncoded;
  core.List<core.int> get qualifierEncodedAsBytes {
    return convert.BASE64.decode(qualifierEncoded);
  }

  void set qualifierEncodedAsBytes(core.List<core.int> _bytes) {
    qualifierEncoded = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  core.String qualifierString;
  /**
   * [Optional] The type to convert the value in cells of this column. The
   * values are expected to be encoded using HBase Bytes.toBytes function when
   * using the BINARY encoding value. Following BigQuery types are allowed
   * (case-sensitive) - BYTES STRING INTEGER FLOAT BOOLEAN Default type is
   * BYTES. 'type' can also be set at the column family level. However, the
   * setting at this level takes precedence if 'type' is set at both levels.
   */
  core.String type;

  BigtableColumn();

  BigtableColumn.fromJson(core.Map _json) {
    if (_json.containsKey("encoding")) {
      encoding = _json["encoding"];
    }
    if (_json.containsKey("fieldName")) {
      fieldName = _json["fieldName"];
    }
    if (_json.containsKey("onlyReadLatest")) {
      onlyReadLatest = _json["onlyReadLatest"];
    }
    if (_json.containsKey("qualifierEncoded")) {
      qualifierEncoded = _json["qualifierEncoded"];
    }
    if (_json.containsKey("qualifierString")) {
      qualifierString = _json["qualifierString"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (encoding != null) {
      _json["encoding"] = encoding;
    }
    if (fieldName != null) {
      _json["fieldName"] = fieldName;
    }
    if (onlyReadLatest != null) {
      _json["onlyReadLatest"] = onlyReadLatest;
    }
    if (qualifierEncoded != null) {
      _json["qualifierEncoded"] = qualifierEncoded;
    }
    if (qualifierString != null) {
      _json["qualifierString"] = qualifierString;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class BigtableColumnFamily {
  /**
   * [Optional] Lists of columns that should be exposed as individual fields as
   * opposed to a list of (column name, value) pairs. All columns whose
   * qualifier matches a qualifier in this list can be accessed as .. Other
   * columns can be accessed as a list through .Column field.
   */
  core.List<BigtableColumn> columns;
  /**
   * [Optional] The encoding of the values when the type is not STRING.
   * Acceptable encoding values are: TEXT - indicates values are alphanumeric
   * text strings. BINARY - indicates values are encoded using HBase
   * Bytes.toBytes family of functions. This can be overridden for a specific
   * column by listing that column in 'columns' and specifying an encoding for
   * it.
   */
  core.String encoding;
  /** Identifier of the column family. */
  core.String familyId;
  /**
   * [Optional] If this is set only the latest version of value are exposed for
   * all columns in this column family. This can be overridden for a specific
   * column by listing that column in 'columns' and specifying a different
   * setting for that column.
   */
  core.bool onlyReadLatest;
  /**
   * [Optional] The type to convert the value in cells of this column family.
   * The values are expected to be encoded using HBase Bytes.toBytes function
   * when using the BINARY encoding value. Following BigQuery types are allowed
   * (case-sensitive) - BYTES STRING INTEGER FLOAT BOOLEAN Default type is
   * BYTES. This can be overridden for a specific column by listing that column
   * in 'columns' and specifying a type for it.
   */
  core.String type;

  BigtableColumnFamily();

  BigtableColumnFamily.fromJson(core.Map _json) {
    if (_json.containsKey("columns")) {
      columns = _json["columns"].map((value) => new BigtableColumn.fromJson(value)).toList();
    }
    if (_json.containsKey("encoding")) {
      encoding = _json["encoding"];
    }
    if (_json.containsKey("familyId")) {
      familyId = _json["familyId"];
    }
    if (_json.containsKey("onlyReadLatest")) {
      onlyReadLatest = _json["onlyReadLatest"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columns != null) {
      _json["columns"] = columns.map((value) => (value).toJson()).toList();
    }
    if (encoding != null) {
      _json["encoding"] = encoding;
    }
    if (familyId != null) {
      _json["familyId"] = familyId;
    }
    if (onlyReadLatest != null) {
      _json["onlyReadLatest"] = onlyReadLatest;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class BigtableOptions {
  /**
   * [Optional] List of column families to expose in the table schema along with
   * their types. This list restricts the column families that can be referenced
   * in queries and specifies their value types. You can use this list to do
   * type conversions - see the 'type' field for more details. If you leave this
   * list empty, all column families are present in the table schema and their
   * values are read as BYTES. During a query only the column families
   * referenced in that query are read from Bigtable.
   */
  core.List<BigtableColumnFamily> columnFamilies;
  /**
   * [Optional] If field is true, then the column families that are not
   * specified in columnFamilies list are not exposed in the table schema.
   * Otherwise, they are read with BYTES type values. The default value is
   * false.
   */
  core.bool ignoreUnspecifiedColumnFamilies;
  /**
   * [Optional] If field is true, then the rowkey column families will be read
   * and converted to string. Otherwise they are read with BYTES type values and
   * users need to manually cast them with CAST if necessary. The default value
   * is false.
   */
  core.bool readRowkeyAsString;

  BigtableOptions();

  BigtableOptions.fromJson(core.Map _json) {
    if (_json.containsKey("columnFamilies")) {
      columnFamilies = _json["columnFamilies"].map((value) => new BigtableColumnFamily.fromJson(value)).toList();
    }
    if (_json.containsKey("ignoreUnspecifiedColumnFamilies")) {
      ignoreUnspecifiedColumnFamilies = _json["ignoreUnspecifiedColumnFamilies"];
    }
    if (_json.containsKey("readRowkeyAsString")) {
      readRowkeyAsString = _json["readRowkeyAsString"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnFamilies != null) {
      _json["columnFamilies"] = columnFamilies.map((value) => (value).toJson()).toList();
    }
    if (ignoreUnspecifiedColumnFamilies != null) {
      _json["ignoreUnspecifiedColumnFamilies"] = ignoreUnspecifiedColumnFamilies;
    }
    if (readRowkeyAsString != null) {
      _json["readRowkeyAsString"] = readRowkeyAsString;
    }
    return _json;
  }
}

class CsvOptions {
  /**
   * [Optional] Indicates if BigQuery should accept rows that are missing
   * trailing optional columns. If true, BigQuery treats missing trailing
   * columns as null values. If false, records with missing trailing columns are
   * treated as bad records, and if there are too many bad records, an invalid
   * error is returned in the job result. The default value is false.
   */
  core.bool allowJaggedRows;
  /**
   * [Optional] Indicates if BigQuery should allow quoted data sections that
   * contain newline characters in a CSV file. The default value is false.
   */
  core.bool allowQuotedNewlines;
  /**
   * [Optional] The character encoding of the data. The supported values are
   * UTF-8 or ISO-8859-1. The default value is UTF-8. BigQuery decodes the data
   * after the raw, binary data has been split using the values of the quote and
   * fieldDelimiter properties.
   */
  core.String encoding;
  /**
   * [Optional] The separator for fields in a CSV file. BigQuery converts the
   * string to ISO-8859-1 encoding, and then uses the first byte of the encoded
   * string to split the data in its raw, binary state. BigQuery also supports
   * the escape sequence "\t" to specify a tab separator. The default value is a
   * comma (',').
   */
  core.String fieldDelimiter;
  /**
   * [Optional] The value that is used to quote data sections in a CSV file.
   * BigQuery converts the string to ISO-8859-1 encoding, and then uses the
   * first byte of the encoded string to split the data in its raw, binary
   * state. The default value is a double-quote ('"'). If your data does not
   * contain quoted sections, set the property value to an empty string. If your
   * data contains quoted newline characters, you must also set the
   * allowQuotedNewlines property to true.
   */
  core.String quote;
  /**
   * [Optional] The number of rows at the top of a CSV file that BigQuery will
   * skip when reading the data. The default value is 0. This property is useful
   * if you have header rows in the file that should be skipped.
   */
  core.String skipLeadingRows;

  CsvOptions();

  CsvOptions.fromJson(core.Map _json) {
    if (_json.containsKey("allowJaggedRows")) {
      allowJaggedRows = _json["allowJaggedRows"];
    }
    if (_json.containsKey("allowQuotedNewlines")) {
      allowQuotedNewlines = _json["allowQuotedNewlines"];
    }
    if (_json.containsKey("encoding")) {
      encoding = _json["encoding"];
    }
    if (_json.containsKey("fieldDelimiter")) {
      fieldDelimiter = _json["fieldDelimiter"];
    }
    if (_json.containsKey("quote")) {
      quote = _json["quote"];
    }
    if (_json.containsKey("skipLeadingRows")) {
      skipLeadingRows = _json["skipLeadingRows"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowJaggedRows != null) {
      _json["allowJaggedRows"] = allowJaggedRows;
    }
    if (allowQuotedNewlines != null) {
      _json["allowQuotedNewlines"] = allowQuotedNewlines;
    }
    if (encoding != null) {
      _json["encoding"] = encoding;
    }
    if (fieldDelimiter != null) {
      _json["fieldDelimiter"] = fieldDelimiter;
    }
    if (quote != null) {
      _json["quote"] = quote;
    }
    if (skipLeadingRows != null) {
      _json["skipLeadingRows"] = skipLeadingRows;
    }
    return _json;
  }
}

class DatasetAccess {
  /**
   * [Pick one] A domain to grant access to. Any users signed in with the domain
   * specified will be granted the specified access. Example: "example.com".
   */
  core.String domain;
  /** [Pick one] An email address of a Google Group to grant access to. */
  core.String groupByEmail;
  /**
   * [Required] Describes the rights granted to the user specified by the other
   * member of the access object. The following string values are supported:
   * READER, WRITER, OWNER.
   */
  core.String role;
  /**
   * [Pick one] A special group to grant access to. Possible values include:
   * projectOwners: Owners of the enclosing project. projectReaders: Readers of
   * the enclosing project. projectWriters: Writers of the enclosing project.
   * allAuthenticatedUsers: All authenticated BigQuery users.
   */
  core.String specialGroup;
  /**
   * [Pick one] An email address of a user to grant access to. For example:
   * fred@example.com.
   */
  core.String userByEmail;
  /**
   * [Pick one] A view from a different dataset to grant access to. Queries
   * executed against that view will have read access to tables in this dataset.
   * The role field is not required when this field is set. If that view is
   * updated by any user, access to the view needs to be granted again via an
   * update operation.
   */
  TableReference view;

  DatasetAccess();

  DatasetAccess.fromJson(core.Map _json) {
    if (_json.containsKey("domain")) {
      domain = _json["domain"];
    }
    if (_json.containsKey("groupByEmail")) {
      groupByEmail = _json["groupByEmail"];
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
    if (_json.containsKey("specialGroup")) {
      specialGroup = _json["specialGroup"];
    }
    if (_json.containsKey("userByEmail")) {
      userByEmail = _json["userByEmail"];
    }
    if (_json.containsKey("view")) {
      view = new TableReference.fromJson(_json["view"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (domain != null) {
      _json["domain"] = domain;
    }
    if (groupByEmail != null) {
      _json["groupByEmail"] = groupByEmail;
    }
    if (role != null) {
      _json["role"] = role;
    }
    if (specialGroup != null) {
      _json["specialGroup"] = specialGroup;
    }
    if (userByEmail != null) {
      _json["userByEmail"] = userByEmail;
    }
    if (view != null) {
      _json["view"] = (view).toJson();
    }
    return _json;
  }
}

class Dataset {
  /**
   * [Optional] An array of objects that define dataset access for one or more
   * entities. You can set this property when inserting or updating a dataset in
   * order to control who is allowed to access the data. If unspecified at
   * dataset creation time, BigQuery adds default dataset access for the
   * following entities: access.specialGroup: projectReaders; access.role:
   * READER; access.specialGroup: projectWriters; access.role: WRITER;
   * access.specialGroup: projectOwners; access.role: OWNER; access.userByEmail:
   * [dataset creator email]; access.role: OWNER;
   */
  core.List<DatasetAccess> access;
  /**
   * [Output-only] The time when this dataset was created, in milliseconds since
   * the epoch.
   */
  core.String creationTime;
  /** [Required] A reference that identifies the dataset. */
  DatasetReference datasetReference;
  /**
   * [Optional] The default lifetime of all tables in the dataset, in
   * milliseconds. The minimum value is 3600000 milliseconds (one hour). Once
   * this property is set, all newly-created tables in the dataset will have an
   * expirationTime property set to the creation time plus the value in this
   * property, and changing the value will only affect new tables, not existing
   * ones. When the expirationTime for a given table is reached, that table will
   * be deleted automatically. If a table's expirationTime is modified or
   * removed before the table expires, or if you provide an explicit
   * expirationTime when creating a table, that value takes precedence over the
   * default expiration time indicated by this property.
   */
  core.String defaultTableExpirationMs;
  /** [Optional] A user-friendly description of the dataset. */
  core.String description;
  /** [Output-only] A hash of the resource. */
  core.String etag;
  /** [Optional] A descriptive name for the dataset. */
  core.String friendlyName;
  /**
   * [Output-only] The fully-qualified unique name of the dataset in the format
   * projectId:datasetId. The dataset name without the project name is given in
   * the datasetId field. When creating a new dataset, leave this field blank,
   * and instead specify the datasetId field.
   */
  core.String id;
  /** [Output-only] The resource type. */
  core.String kind;
  /**
   * [Experimental] The labels associated with this dataset. You can use these
   * to organize and group your datasets. You can set this property when
   * inserting or updating a dataset. See Labeling Datasets for more
   * information.
   */
  core.Map<core.String, core.String> labels;
  /**
   * [Output-only] The date when this dataset or any of its tables was last
   * modified, in milliseconds since the epoch.
   */
  core.String lastModifiedTime;
  /**
   * [Experimental] The geographic location where the dataset should reside.
   * Possible values include EU and US. The default value is US.
   */
  core.String location;
  /**
   * [Output-only] A URL that can be used to access the resource again. You can
   * use this URL in Get or Update requests to the resource.
   */
  core.String selfLink;

  Dataset();

  Dataset.fromJson(core.Map _json) {
    if (_json.containsKey("access")) {
      access = _json["access"].map((value) => new DatasetAccess.fromJson(value)).toList();
    }
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("datasetReference")) {
      datasetReference = new DatasetReference.fromJson(_json["datasetReference"]);
    }
    if (_json.containsKey("defaultTableExpirationMs")) {
      defaultTableExpirationMs = _json["defaultTableExpirationMs"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("friendlyName")) {
      friendlyName = _json["friendlyName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("lastModifiedTime")) {
      lastModifiedTime = _json["lastModifiedTime"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (access != null) {
      _json["access"] = access.map((value) => (value).toJson()).toList();
    }
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (datasetReference != null) {
      _json["datasetReference"] = (datasetReference).toJson();
    }
    if (defaultTableExpirationMs != null) {
      _json["defaultTableExpirationMs"] = defaultTableExpirationMs;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (friendlyName != null) {
      _json["friendlyName"] = friendlyName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (lastModifiedTime != null) {
      _json["lastModifiedTime"] = lastModifiedTime;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

class DatasetListDatasets {
  /**
   * The dataset reference. Use this property to access specific parts of the
   * dataset's ID, such as project ID or dataset ID.
   */
  DatasetReference datasetReference;
  /** A descriptive name for the dataset, if one exists. */
  core.String friendlyName;
  /** The fully-qualified, unique, opaque ID of the dataset. */
  core.String id;
  /**
   * The resource type. This property always returns the value
   * "bigquery#dataset".
   */
  core.String kind;
  /**
   * [Experimental] The labels associated with this dataset. You can use these
   * to organize and group your datasets.
   */
  core.Map<core.String, core.String> labels;

  DatasetListDatasets();

  DatasetListDatasets.fromJson(core.Map _json) {
    if (_json.containsKey("datasetReference")) {
      datasetReference = new DatasetReference.fromJson(_json["datasetReference"]);
    }
    if (_json.containsKey("friendlyName")) {
      friendlyName = _json["friendlyName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasetReference != null) {
      _json["datasetReference"] = (datasetReference).toJson();
    }
    if (friendlyName != null) {
      _json["friendlyName"] = friendlyName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    return _json;
  }
}

class DatasetList {
  /**
   * An array of the dataset resources in the project. Each resource contains
   * basic information. For full information about a particular dataset
   * resource, use the Datasets: get method. This property is omitted when there
   * are no datasets in the project.
   */
  core.List<DatasetListDatasets> datasets;
  /**
   * A hash value of the results page. You can use this property to determine if
   * the page has changed since the last request.
   */
  core.String etag;
  /**
   * The list type. This property always returns the value
   * "bigquery#datasetList".
   */
  core.String kind;
  /**
   * A token that can be used to request the next results page. This property is
   * omitted on the final results page.
   */
  core.String nextPageToken;

  DatasetList();

  DatasetList.fromJson(core.Map _json) {
    if (_json.containsKey("datasets")) {
      datasets = _json["datasets"].map((value) => new DatasetListDatasets.fromJson(value)).toList();
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasets != null) {
      _json["datasets"] = datasets.map((value) => (value).toJson()).toList();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

class DatasetReference {
  /**
   * [Required] A unique ID for this dataset, without the project name. The ID
   * must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_).
   * The maximum length is 1,024 characters.
   */
  core.String datasetId;
  /** [Optional] The ID of the project containing this dataset. */
  core.String projectId;

  DatasetReference();

  DatasetReference.fromJson(core.Map _json) {
    if (_json.containsKey("datasetId")) {
      datasetId = _json["datasetId"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasetId != null) {
      _json["datasetId"] = datasetId;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    return _json;
  }
}

class ErrorProto {
  /**
   * Debugging information. This property is internal to Google and should not
   * be used.
   */
  core.String debugInfo;
  /** Specifies where the error occurred, if present. */
  core.String location;
  /** A human-readable description of the error. */
  core.String message;
  /** A short error code that summarizes the error. */
  core.String reason;

  ErrorProto();

  ErrorProto.fromJson(core.Map _json) {
    if (_json.containsKey("debugInfo")) {
      debugInfo = _json["debugInfo"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
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
    if (debugInfo != null) {
      _json["debugInfo"] = debugInfo;
    }
    if (location != null) {
      _json["location"] = location;
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

class ExplainQueryStage {
  /** Relative amount of time the average shard spent on CPU-bound tasks. */
  core.double computeRatioAvg;
  /** Relative amount of time the slowest shard spent on CPU-bound tasks. */
  core.double computeRatioMax;
  /** Unique ID for stage within plan. */
  core.String id;
  /** Human-readable name for stage. */
  core.String name;
  /** Relative amount of time the average shard spent reading input. */
  core.double readRatioAvg;
  /** Relative amount of time the slowest shard spent reading input. */
  core.double readRatioMax;
  /** Number of records read into the stage. */
  core.String recordsRead;
  /** Number of records written by the stage. */
  core.String recordsWritten;
  /** Current status for the stage. */
  core.String status;
  /**
   * List of operations within the stage in dependency order (approximately
   * chronological).
   */
  core.List<ExplainQueryStep> steps;
  /**
   * Relative amount of time the average shard spent waiting to be scheduled.
   */
  core.double waitRatioAvg;
  /**
   * Relative amount of time the slowest shard spent waiting to be scheduled.
   */
  core.double waitRatioMax;
  /** Relative amount of time the average shard spent on writing output. */
  core.double writeRatioAvg;
  /** Relative amount of time the slowest shard spent on writing output. */
  core.double writeRatioMax;

  ExplainQueryStage();

  ExplainQueryStage.fromJson(core.Map _json) {
    if (_json.containsKey("computeRatioAvg")) {
      computeRatioAvg = _json["computeRatioAvg"];
    }
    if (_json.containsKey("computeRatioMax")) {
      computeRatioMax = _json["computeRatioMax"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("readRatioAvg")) {
      readRatioAvg = _json["readRatioAvg"];
    }
    if (_json.containsKey("readRatioMax")) {
      readRatioMax = _json["readRatioMax"];
    }
    if (_json.containsKey("recordsRead")) {
      recordsRead = _json["recordsRead"];
    }
    if (_json.containsKey("recordsWritten")) {
      recordsWritten = _json["recordsWritten"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("steps")) {
      steps = _json["steps"].map((value) => new ExplainQueryStep.fromJson(value)).toList();
    }
    if (_json.containsKey("waitRatioAvg")) {
      waitRatioAvg = _json["waitRatioAvg"];
    }
    if (_json.containsKey("waitRatioMax")) {
      waitRatioMax = _json["waitRatioMax"];
    }
    if (_json.containsKey("writeRatioAvg")) {
      writeRatioAvg = _json["writeRatioAvg"];
    }
    if (_json.containsKey("writeRatioMax")) {
      writeRatioMax = _json["writeRatioMax"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (computeRatioAvg != null) {
      _json["computeRatioAvg"] = computeRatioAvg;
    }
    if (computeRatioMax != null) {
      _json["computeRatioMax"] = computeRatioMax;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (readRatioAvg != null) {
      _json["readRatioAvg"] = readRatioAvg;
    }
    if (readRatioMax != null) {
      _json["readRatioMax"] = readRatioMax;
    }
    if (recordsRead != null) {
      _json["recordsRead"] = recordsRead;
    }
    if (recordsWritten != null) {
      _json["recordsWritten"] = recordsWritten;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (steps != null) {
      _json["steps"] = steps.map((value) => (value).toJson()).toList();
    }
    if (waitRatioAvg != null) {
      _json["waitRatioAvg"] = waitRatioAvg;
    }
    if (waitRatioMax != null) {
      _json["waitRatioMax"] = waitRatioMax;
    }
    if (writeRatioAvg != null) {
      _json["writeRatioAvg"] = writeRatioAvg;
    }
    if (writeRatioMax != null) {
      _json["writeRatioMax"] = writeRatioMax;
    }
    return _json;
  }
}

class ExplainQueryStep {
  /** Machine-readable operation type. */
  core.String kind;
  /** Human-readable stage descriptions. */
  core.List<core.String> substeps;

  ExplainQueryStep();

  ExplainQueryStep.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("substeps")) {
      substeps = _json["substeps"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (substeps != null) {
      _json["substeps"] = substeps;
    }
    return _json;
  }
}

class ExternalDataConfiguration {
  /**
   * [Experimental] Try to detect schema and format options automatically. Any
   * option specified explicitly will be honored.
   */
  core.bool autodetect;
  /** [Optional] Additional options if sourceFormat is set to BIGTABLE. */
  BigtableOptions bigtableOptions;
  /**
   * [Optional] The compression type of the data source. Possible values include
   * GZIP and NONE. The default value is NONE. This setting is ignored for
   * Google Cloud Bigtable, Google Cloud Datastore backups and Avro formats.
   */
  core.String compression;
  /** Additional properties to set if sourceFormat is set to CSV. */
  CsvOptions csvOptions;
  /** [Optional] Additional options if sourceFormat is set to GOOGLE_SHEETS. */
  GoogleSheetsOptions googleSheetsOptions;
  /**
   * [Optional] Indicates if BigQuery should allow extra values that are not
   * represented in the table schema. If true, the extra values are ignored. If
   * false, records with extra columns are treated as bad records, and if there
   * are too many bad records, an invalid error is returned in the job result.
   * The default value is false. The sourceFormat property determines what
   * BigQuery treats as an extra value: CSV: Trailing columns JSON: Named values
   * that don't match any column names Google Cloud Bigtable: This setting is
   * ignored. Google Cloud Datastore backups: This setting is ignored. Avro:
   * This setting is ignored.
   */
  core.bool ignoreUnknownValues;
  /**
   * [Optional] The maximum number of bad records that BigQuery can ignore when
   * reading data. If the number of bad records exceeds this value, an invalid
   * error is returned in the job result. The default value is 0, which requires
   * that all records are valid. This setting is ignored for Google Cloud
   * Bigtable, Google Cloud Datastore backups and Avro formats.
   */
  core.int maxBadRecords;
  /**
   * [Optional] The schema for the data. Schema is required for CSV and JSON
   * formats. Schema is disallowed for Google Cloud Bigtable, Cloud Datastore
   * backups, and Avro formats.
   */
  TableSchema schema;
  /**
   * [Required] The data format. For CSV files, specify "CSV". For Google
   * sheets, specify "GOOGLE_SHEETS". For newline-delimited JSON, specify
   * "NEWLINE_DELIMITED_JSON". For Avro files, specify "AVRO". For Google Cloud
   * Datastore backups, specify "DATASTORE_BACKUP". [Experimental] For Google
   * Cloud Bigtable, specify "BIGTABLE". Please note that reading from Google
   * Cloud Bigtable is experimental and has to be enabled for your project.
   * Please contact Google Cloud Support to enable this for your project.
   */
  core.String sourceFormat;
  /**
   * [Required] The fully-qualified URIs that point to your data in Google
   * Cloud. For Google Cloud Storage URIs: Each URI can contain one '*' wildcard
   * character and it must come after the 'bucket' name. Size limits related to
   * load jobs apply to external data sources. For Google Cloud Bigtable URIs:
   * Exactly one URI can be specified and it has be a fully specified and valid
   * HTTPS URL for a Google Cloud Bigtable table. For Google Cloud Datastore
   * backups, exactly one URI can be specified, and it must end with
   * '.backup_info'. Also, the '*' wildcard character is not allowed.
   */
  core.List<core.String> sourceUris;

  ExternalDataConfiguration();

  ExternalDataConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("autodetect")) {
      autodetect = _json["autodetect"];
    }
    if (_json.containsKey("bigtableOptions")) {
      bigtableOptions = new BigtableOptions.fromJson(_json["bigtableOptions"]);
    }
    if (_json.containsKey("compression")) {
      compression = _json["compression"];
    }
    if (_json.containsKey("csvOptions")) {
      csvOptions = new CsvOptions.fromJson(_json["csvOptions"]);
    }
    if (_json.containsKey("googleSheetsOptions")) {
      googleSheetsOptions = new GoogleSheetsOptions.fromJson(_json["googleSheetsOptions"]);
    }
    if (_json.containsKey("ignoreUnknownValues")) {
      ignoreUnknownValues = _json["ignoreUnknownValues"];
    }
    if (_json.containsKey("maxBadRecords")) {
      maxBadRecords = _json["maxBadRecords"];
    }
    if (_json.containsKey("schema")) {
      schema = new TableSchema.fromJson(_json["schema"]);
    }
    if (_json.containsKey("sourceFormat")) {
      sourceFormat = _json["sourceFormat"];
    }
    if (_json.containsKey("sourceUris")) {
      sourceUris = _json["sourceUris"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (autodetect != null) {
      _json["autodetect"] = autodetect;
    }
    if (bigtableOptions != null) {
      _json["bigtableOptions"] = (bigtableOptions).toJson();
    }
    if (compression != null) {
      _json["compression"] = compression;
    }
    if (csvOptions != null) {
      _json["csvOptions"] = (csvOptions).toJson();
    }
    if (googleSheetsOptions != null) {
      _json["googleSheetsOptions"] = (googleSheetsOptions).toJson();
    }
    if (ignoreUnknownValues != null) {
      _json["ignoreUnknownValues"] = ignoreUnknownValues;
    }
    if (maxBadRecords != null) {
      _json["maxBadRecords"] = maxBadRecords;
    }
    if (schema != null) {
      _json["schema"] = (schema).toJson();
    }
    if (sourceFormat != null) {
      _json["sourceFormat"] = sourceFormat;
    }
    if (sourceUris != null) {
      _json["sourceUris"] = sourceUris;
    }
    return _json;
  }
}

class GetQueryResultsResponse {
  /** Whether the query result was fetched from the query cache. */
  core.bool cacheHit;
  /**
   * [Output-only] All errors and warnings encountered during the running of the
   * job. Errors here do not necessarily mean that the job has completed or was
   * unsuccessful.
   */
  core.List<ErrorProto> errors;
  /** A hash of this response. */
  core.String etag;
  /**
   * Whether the query has completed or not. If rows or totalRows are present,
   * this will always be true. If this is false, totalRows will not be
   * available.
   */
  core.bool jobComplete;
  /**
   * Reference to the BigQuery Job that was created to run the query. This field
   * will be present even if the original request timed out, in which case
   * GetQueryResults can be used to read the results once the query has
   * completed. Since this API only returns the first page of results,
   * subsequent pages can be fetched via the same mechanism (GetQueryResults).
   */
  JobReference jobReference;
  /** The resource type of the response. */
  core.String kind;
  /**
   * [Output-only, Experimental] The number of rows affected by a DML statement.
   * Present only for DML statements INSERT, UPDATE or DELETE.
   */
  core.String numDmlAffectedRows;
  /** A token used for paging results. */
  core.String pageToken;
  /**
   * An object with as many results as can be contained within the maximum
   * permitted reply size. To get any additional rows, you can call
   * GetQueryResults and specify the jobReference returned above. Present only
   * when the query completes successfully.
   */
  core.List<TableRow> rows;
  /**
   * The schema of the results. Present only when the query completes
   * successfully.
   */
  TableSchema schema;
  /** The total number of bytes processed for this query. */
  core.String totalBytesProcessed;
  /**
   * The total number of rows in the complete query result set, which can be
   * more than the number of rows in this single page of results. Present only
   * when the query completes successfully.
   */
  core.String totalRows;

  GetQueryResultsResponse();

  GetQueryResultsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("cacheHit")) {
      cacheHit = _json["cacheHit"];
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"].map((value) => new ErrorProto.fromJson(value)).toList();
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("jobComplete")) {
      jobComplete = _json["jobComplete"];
    }
    if (_json.containsKey("jobReference")) {
      jobReference = new JobReference.fromJson(_json["jobReference"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("numDmlAffectedRows")) {
      numDmlAffectedRows = _json["numDmlAffectedRows"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"].map((value) => new TableRow.fromJson(value)).toList();
    }
    if (_json.containsKey("schema")) {
      schema = new TableSchema.fromJson(_json["schema"]);
    }
    if (_json.containsKey("totalBytesProcessed")) {
      totalBytesProcessed = _json["totalBytesProcessed"];
    }
    if (_json.containsKey("totalRows")) {
      totalRows = _json["totalRows"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cacheHit != null) {
      _json["cacheHit"] = cacheHit;
    }
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (jobComplete != null) {
      _json["jobComplete"] = jobComplete;
    }
    if (jobReference != null) {
      _json["jobReference"] = (jobReference).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (numDmlAffectedRows != null) {
      _json["numDmlAffectedRows"] = numDmlAffectedRows;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    if (rows != null) {
      _json["rows"] = rows.map((value) => (value).toJson()).toList();
    }
    if (schema != null) {
      _json["schema"] = (schema).toJson();
    }
    if (totalBytesProcessed != null) {
      _json["totalBytesProcessed"] = totalBytesProcessed;
    }
    if (totalRows != null) {
      _json["totalRows"] = totalRows;
    }
    return _json;
  }
}

class GoogleSheetsOptions {
  /**
   * [Optional] The number of rows at the top of a sheet that BigQuery will skip
   * when reading the data. The default value is 0. This property is useful if
   * you have header rows that should be skipped. When autodetect is on,
   * behavior is the following: * skipLeadingRows unspecified - Autodetect tries
   * to detect headers in the first row. If they are not detected, the row is
   * read as data. Otherwise data is read starting from the second row. *
   * skipLeadingRows is 0 - Instructs autodetect that there are no headers and
   * data should be read starting from the first row. * skipLeadingRows = N > 0
   * - Autodetect skips N-1 rows and tries to detect headers in row N. If
   * headers are not detected, row N is just skipped. Otherwise row N is used to
   * extract column names for the detected schema.
   */
  core.String skipLeadingRows;

  GoogleSheetsOptions();

  GoogleSheetsOptions.fromJson(core.Map _json) {
    if (_json.containsKey("skipLeadingRows")) {
      skipLeadingRows = _json["skipLeadingRows"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (skipLeadingRows != null) {
      _json["skipLeadingRows"] = skipLeadingRows;
    }
    return _json;
  }
}

class Job {
  /** [Required] Describes the job configuration. */
  JobConfiguration configuration;
  /** [Output-only] A hash of this resource. */
  core.String etag;
  /** [Output-only] Opaque ID field of the job */
  core.String id;
  /** [Optional] Reference describing the unique-per-user name of the job. */
  JobReference jobReference;
  /** [Output-only] The type of the resource. */
  core.String kind;
  /** [Output-only] A URL that can be used to access this resource again. */
  core.String selfLink;
  /**
   * [Output-only] Information about the job, including starting time and ending
   * time of the job.
   */
  JobStatistics statistics;
  /**
   * [Output-only] The status of this job. Examine this value when polling an
   * asynchronous job to see if the job is complete.
   */
  JobStatus status;
  /** [Output-only] Email address of the user who ran the job. */
  core.String userEmail;

  Job();

  Job.fromJson(core.Map _json) {
    if (_json.containsKey("configuration")) {
      configuration = new JobConfiguration.fromJson(_json["configuration"]);
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("jobReference")) {
      jobReference = new JobReference.fromJson(_json["jobReference"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("statistics")) {
      statistics = new JobStatistics.fromJson(_json["statistics"]);
    }
    if (_json.containsKey("status")) {
      status = new JobStatus.fromJson(_json["status"]);
    }
    if (_json.containsKey("user_email")) {
      userEmail = _json["user_email"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (configuration != null) {
      _json["configuration"] = (configuration).toJson();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (jobReference != null) {
      _json["jobReference"] = (jobReference).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (statistics != null) {
      _json["statistics"] = (statistics).toJson();
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    if (userEmail != null) {
      _json["user_email"] = userEmail;
    }
    return _json;
  }
}

class JobCancelResponse {
  /** The final state of the job. */
  Job job;
  /** The resource type of the response. */
  core.String kind;

  JobCancelResponse();

  JobCancelResponse.fromJson(core.Map _json) {
    if (_json.containsKey("job")) {
      job = new Job.fromJson(_json["job"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (job != null) {
      _json["job"] = (job).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class JobConfiguration {
  /** [Pick one] Copies a table. */
  JobConfigurationTableCopy copy;
  /**
   * [Optional] If set, don't actually run this job. A valid query will return a
   * mostly empty response with some processing statistics, while an invalid
   * query will return the same error it would if it wasn't a dry run. Behavior
   * of non-query jobs is undefined.
   */
  core.bool dryRun;
  /** [Pick one] Configures an extract job. */
  JobConfigurationExtract extract;
  /**
   * [Experimental] The labels associated with this job. You can use these to
   * organize and group your jobs. Label keys and values can be no longer than
   * 63 characters, can only contain lowercase letters, numeric characters,
   * underscores and dashes. International characters are allowed. Label values
   * are optional. Label keys must start with a letter and each label in the
   * list must have a different key.
   */
  core.Map<core.String, core.String> labels;
  /** [Pick one] Configures a load job. */
  JobConfigurationLoad load;
  /** [Pick one] Configures a query job. */
  JobConfigurationQuery query;

  JobConfiguration();

  JobConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("copy")) {
      copy = new JobConfigurationTableCopy.fromJson(_json["copy"]);
    }
    if (_json.containsKey("dryRun")) {
      dryRun = _json["dryRun"];
    }
    if (_json.containsKey("extract")) {
      extract = new JobConfigurationExtract.fromJson(_json["extract"]);
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("load")) {
      load = new JobConfigurationLoad.fromJson(_json["load"]);
    }
    if (_json.containsKey("query")) {
      query = new JobConfigurationQuery.fromJson(_json["query"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (copy != null) {
      _json["copy"] = (copy).toJson();
    }
    if (dryRun != null) {
      _json["dryRun"] = dryRun;
    }
    if (extract != null) {
      _json["extract"] = (extract).toJson();
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (load != null) {
      _json["load"] = (load).toJson();
    }
    if (query != null) {
      _json["query"] = (query).toJson();
    }
    return _json;
  }
}

class JobConfigurationExtract {
  /**
   * [Optional] The compression type to use for exported files. Possible values
   * include GZIP and NONE. The default value is NONE.
   */
  core.String compression;
  /**
   * [Optional] The exported file format. Possible values include CSV,
   * NEWLINE_DELIMITED_JSON and AVRO. The default value is CSV. Tables with
   * nested or repeated fields cannot be exported as CSV.
   */
  core.String destinationFormat;
  /**
   * [Pick one] DEPRECATED: Use destinationUris instead, passing only one URI as
   * necessary. The fully-qualified Google Cloud Storage URI where the extracted
   * table should be written.
   */
  core.String destinationUri;
  /**
   * [Pick one] A list of fully-qualified Google Cloud Storage URIs where the
   * extracted table should be written.
   */
  core.List<core.String> destinationUris;
  /**
   * [Optional] Delimiter to use between fields in the exported data. Default is
   * ','
   */
  core.String fieldDelimiter;
  /**
   * [Optional] Whether to print out a header row in the results. Default is
   * true.
   */
  core.bool printHeader;
  /** [Required] A reference to the table being exported. */
  TableReference sourceTable;

  JobConfigurationExtract();

  JobConfigurationExtract.fromJson(core.Map _json) {
    if (_json.containsKey("compression")) {
      compression = _json["compression"];
    }
    if (_json.containsKey("destinationFormat")) {
      destinationFormat = _json["destinationFormat"];
    }
    if (_json.containsKey("destinationUri")) {
      destinationUri = _json["destinationUri"];
    }
    if (_json.containsKey("destinationUris")) {
      destinationUris = _json["destinationUris"];
    }
    if (_json.containsKey("fieldDelimiter")) {
      fieldDelimiter = _json["fieldDelimiter"];
    }
    if (_json.containsKey("printHeader")) {
      printHeader = _json["printHeader"];
    }
    if (_json.containsKey("sourceTable")) {
      sourceTable = new TableReference.fromJson(_json["sourceTable"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (compression != null) {
      _json["compression"] = compression;
    }
    if (destinationFormat != null) {
      _json["destinationFormat"] = destinationFormat;
    }
    if (destinationUri != null) {
      _json["destinationUri"] = destinationUri;
    }
    if (destinationUris != null) {
      _json["destinationUris"] = destinationUris;
    }
    if (fieldDelimiter != null) {
      _json["fieldDelimiter"] = fieldDelimiter;
    }
    if (printHeader != null) {
      _json["printHeader"] = printHeader;
    }
    if (sourceTable != null) {
      _json["sourceTable"] = (sourceTable).toJson();
    }
    return _json;
  }
}

class JobConfigurationLoad {
  /**
   * [Optional] Accept rows that are missing trailing optional columns. The
   * missing values are treated as nulls. If false, records with missing
   * trailing columns are treated as bad records, and if there are too many bad
   * records, an invalid error is returned in the job result. The default value
   * is false. Only applicable to CSV, ignored for other formats.
   */
  core.bool allowJaggedRows;
  /**
   * Indicates if BigQuery should allow quoted data sections that contain
   * newline characters in a CSV file. The default value is false.
   */
  core.bool allowQuotedNewlines;
  /**
   * [Experimental] Indicates if we should automatically infer the options and
   * schema for CSV and JSON sources.
   */
  core.bool autodetect;
  /**
   * [Optional] Specifies whether the job is allowed to create new tables. The
   * following values are supported: CREATE_IF_NEEDED: If the table does not
   * exist, BigQuery creates the table. CREATE_NEVER: The table must already
   * exist. If it does not, a 'notFound' error is returned in the job result.
   * The default value is CREATE_IF_NEEDED. Creation, truncation and append
   * actions occur as one atomic update upon job completion.
   */
  core.String createDisposition;
  /** [Required] The destination table to load the data into. */
  TableReference destinationTable;
  /**
   * [Optional] The character encoding of the data. The supported values are
   * UTF-8 or ISO-8859-1. The default value is UTF-8. BigQuery decodes the data
   * after the raw, binary data has been split using the values of the quote and
   * fieldDelimiter properties.
   */
  core.String encoding;
  /**
   * [Optional] The separator for fields in a CSV file. The separator can be any
   * ISO-8859-1 single-byte character. To use a character in the range 128-255,
   * you must encode the character as UTF8. BigQuery converts the string to
   * ISO-8859-1 encoding, and then uses the first byte of the encoded string to
   * split the data in its raw, binary state. BigQuery also supports the escape
   * sequence "\t" to specify a tab separator. The default value is a comma
   * (',').
   */
  core.String fieldDelimiter;
  /**
   * [Optional] Indicates if BigQuery should allow extra values that are not
   * represented in the table schema. If true, the extra values are ignored. If
   * false, records with extra columns are treated as bad records, and if there
   * are too many bad records, an invalid error is returned in the job result.
   * The default value is false. The sourceFormat property determines what
   * BigQuery treats as an extra value: CSV: Trailing columns JSON: Named values
   * that don't match any column names
   */
  core.bool ignoreUnknownValues;
  /**
   * [Optional] The maximum number of bad records that BigQuery can ignore when
   * running the job. If the number of bad records exceeds this value, an
   * invalid error is returned in the job result. The default value is 0, which
   * requires that all records are valid.
   */
  core.int maxBadRecords;
  /**
   * [Optional] Specifies a string that represents a null value in a CSV file.
   * For example, if you specify "\N", BigQuery interprets "\N" as a null value
   * when loading a CSV file. The default value is the empty string. If you set
   * this property to a custom value, BigQuery still interprets the empty string
   * as a null value for all data types except for STRING and BYTE. For STRING
   * and BYTE columns, BigQuery interprets the empty string as an empty value.
   */
  core.String nullMarker;
  /**
   * [Experimental] If sourceFormat is set to "DATASTORE_BACKUP", indicates
   * which entity properties to load into BigQuery from a Cloud Datastore
   * backup. Property names are case sensitive and must be top-level properties.
   * If no properties are specified, BigQuery loads all properties. If any named
   * property isn't found in the Cloud Datastore backup, an invalid error is
   * returned in the job result.
   */
  core.List<core.String> projectionFields;
  /**
   * [Optional] The value that is used to quote data sections in a CSV file.
   * BigQuery converts the string to ISO-8859-1 encoding, and then uses the
   * first byte of the encoded string to split the data in its raw, binary
   * state. The default value is a double-quote ('"'). If your data does not
   * contain quoted sections, set the property value to an empty string. If your
   * data contains quoted newline characters, you must also set the
   * allowQuotedNewlines property to true.
   */
  core.String quote;
  /**
   * [Optional] The schema for the destination table. The schema can be omitted
   * if the destination table already exists, or if you're loading data from
   * Google Cloud Datastore.
   */
  TableSchema schema;
  /**
   * [Deprecated] The inline schema. For CSV schemas, specify as
   * "Field1:Type1[,Field2:Type2]*". For example, "foo:STRING, bar:INTEGER,
   * baz:FLOAT".
   */
  core.String schemaInline;
  /** [Deprecated] The format of the schemaInline property. */
  core.String schemaInlineFormat;
  /**
   * [Experimental] Allows the schema of the desitination table to be updated as
   * a side effect of the load job. Schema update options are supported in two
   * cases: when writeDisposition is WRITE_APPEND; when writeDisposition is
   * WRITE_TRUNCATE and the destination table is a partition of a table,
   * specified by partition decorators. For normal tables, WRITE_TRUNCATE will
   * always overwrite the schema. One or more of the following values are
   * specified: ALLOW_FIELD_ADDITION: allow adding a nullable field to the
   * schema. ALLOW_FIELD_RELAXATION: allow relaxing a required field in the
   * original schema to nullable.
   */
  core.List<core.String> schemaUpdateOptions;
  /**
   * [Optional] The number of rows at the top of a CSV file that BigQuery will
   * skip when loading the data. The default value is 0. This property is useful
   * if you have header rows in the file that should be skipped.
   */
  core.int skipLeadingRows;
  /**
   * [Optional] The format of the data files. For CSV files, specify "CSV". For
   * datastore backups, specify "DATASTORE_BACKUP". For newline-delimited JSON,
   * specify "NEWLINE_DELIMITED_JSON". For Avro, specify "AVRO". The default
   * value is CSV.
   */
  core.String sourceFormat;
  /**
   * [Required] The fully-qualified URIs that point to your data in Google Cloud
   * Storage. Each URI can contain one '*' wildcard character and it must come
   * after the 'bucket' name.
   */
  core.List<core.String> sourceUris;
  /**
   * [Optional] Specifies the action that occurs if the destination table
   * already exists. The following values are supported: WRITE_TRUNCATE: If the
   * table already exists, BigQuery overwrites the table data. WRITE_APPEND: If
   * the table already exists, BigQuery appends the data to the table.
   * WRITE_EMPTY: If the table already exists and contains data, a 'duplicate'
   * error is returned in the job result. The default value is WRITE_APPEND.
   * Each action is atomic and only occurs if BigQuery is able to complete the
   * job successfully. Creation, truncation and append actions occur as one
   * atomic update upon job completion.
   */
  core.String writeDisposition;

  JobConfigurationLoad();

  JobConfigurationLoad.fromJson(core.Map _json) {
    if (_json.containsKey("allowJaggedRows")) {
      allowJaggedRows = _json["allowJaggedRows"];
    }
    if (_json.containsKey("allowQuotedNewlines")) {
      allowQuotedNewlines = _json["allowQuotedNewlines"];
    }
    if (_json.containsKey("autodetect")) {
      autodetect = _json["autodetect"];
    }
    if (_json.containsKey("createDisposition")) {
      createDisposition = _json["createDisposition"];
    }
    if (_json.containsKey("destinationTable")) {
      destinationTable = new TableReference.fromJson(_json["destinationTable"]);
    }
    if (_json.containsKey("encoding")) {
      encoding = _json["encoding"];
    }
    if (_json.containsKey("fieldDelimiter")) {
      fieldDelimiter = _json["fieldDelimiter"];
    }
    if (_json.containsKey("ignoreUnknownValues")) {
      ignoreUnknownValues = _json["ignoreUnknownValues"];
    }
    if (_json.containsKey("maxBadRecords")) {
      maxBadRecords = _json["maxBadRecords"];
    }
    if (_json.containsKey("nullMarker")) {
      nullMarker = _json["nullMarker"];
    }
    if (_json.containsKey("projectionFields")) {
      projectionFields = _json["projectionFields"];
    }
    if (_json.containsKey("quote")) {
      quote = _json["quote"];
    }
    if (_json.containsKey("schema")) {
      schema = new TableSchema.fromJson(_json["schema"]);
    }
    if (_json.containsKey("schemaInline")) {
      schemaInline = _json["schemaInline"];
    }
    if (_json.containsKey("schemaInlineFormat")) {
      schemaInlineFormat = _json["schemaInlineFormat"];
    }
    if (_json.containsKey("schemaUpdateOptions")) {
      schemaUpdateOptions = _json["schemaUpdateOptions"];
    }
    if (_json.containsKey("skipLeadingRows")) {
      skipLeadingRows = _json["skipLeadingRows"];
    }
    if (_json.containsKey("sourceFormat")) {
      sourceFormat = _json["sourceFormat"];
    }
    if (_json.containsKey("sourceUris")) {
      sourceUris = _json["sourceUris"];
    }
    if (_json.containsKey("writeDisposition")) {
      writeDisposition = _json["writeDisposition"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowJaggedRows != null) {
      _json["allowJaggedRows"] = allowJaggedRows;
    }
    if (allowQuotedNewlines != null) {
      _json["allowQuotedNewlines"] = allowQuotedNewlines;
    }
    if (autodetect != null) {
      _json["autodetect"] = autodetect;
    }
    if (createDisposition != null) {
      _json["createDisposition"] = createDisposition;
    }
    if (destinationTable != null) {
      _json["destinationTable"] = (destinationTable).toJson();
    }
    if (encoding != null) {
      _json["encoding"] = encoding;
    }
    if (fieldDelimiter != null) {
      _json["fieldDelimiter"] = fieldDelimiter;
    }
    if (ignoreUnknownValues != null) {
      _json["ignoreUnknownValues"] = ignoreUnknownValues;
    }
    if (maxBadRecords != null) {
      _json["maxBadRecords"] = maxBadRecords;
    }
    if (nullMarker != null) {
      _json["nullMarker"] = nullMarker;
    }
    if (projectionFields != null) {
      _json["projectionFields"] = projectionFields;
    }
    if (quote != null) {
      _json["quote"] = quote;
    }
    if (schema != null) {
      _json["schema"] = (schema).toJson();
    }
    if (schemaInline != null) {
      _json["schemaInline"] = schemaInline;
    }
    if (schemaInlineFormat != null) {
      _json["schemaInlineFormat"] = schemaInlineFormat;
    }
    if (schemaUpdateOptions != null) {
      _json["schemaUpdateOptions"] = schemaUpdateOptions;
    }
    if (skipLeadingRows != null) {
      _json["skipLeadingRows"] = skipLeadingRows;
    }
    if (sourceFormat != null) {
      _json["sourceFormat"] = sourceFormat;
    }
    if (sourceUris != null) {
      _json["sourceUris"] = sourceUris;
    }
    if (writeDisposition != null) {
      _json["writeDisposition"] = writeDisposition;
    }
    return _json;
  }
}

class JobConfigurationQuery {
  /**
   * If true, allows the query to produce arbitrarily large result tables at a
   * slight cost in performance. Requires destinationTable to be set.
   */
  core.bool allowLargeResults;
  /**
   * [Optional] Specifies whether the job is allowed to create new tables. The
   * following values are supported: CREATE_IF_NEEDED: If the table does not
   * exist, BigQuery creates the table. CREATE_NEVER: The table must already
   * exist. If it does not, a 'notFound' error is returned in the job result.
   * The default value is CREATE_IF_NEEDED. Creation, truncation and append
   * actions occur as one atomic update upon job completion.
   */
  core.String createDisposition;
  /**
   * [Optional] Specifies the default dataset to use for unqualified table names
   * in the query.
   */
  DatasetReference defaultDataset;
  /**
   * [Optional] Describes the table where the query results should be stored. If
   * not present, a new table will be created to store the results.
   */
  TableReference destinationTable;
  /**
   * [Optional] Flattens all nested and repeated fields in the query results.
   * The default value is true. allowLargeResults must be true if this is set to
   * false.
   */
  core.bool flattenResults;
  /**
   * [Optional] Limits the billing tier for this job. Queries that have resource
   * usage beyond this tier will fail (without incurring a charge). If
   * unspecified, this will be set to your project default.
   */
  core.int maximumBillingTier;
  /**
   * [Optional] Limits the bytes billed for this job. Queries that will have
   * bytes billed beyond this limit will fail (without incurring a charge). If
   * unspecified, this will be set to your project default.
   */
  core.String maximumBytesBilled;
  /**
   * [Experimental] Standard SQL only. Set to POSITIONAL to use positional (?)
   * query parameters or to NAMED to use named (@myparam) query parameters in
   * this query.
   */
  core.String parameterMode;
  /** [Deprecated] This property is deprecated. */
  core.bool preserveNulls;
  /**
   * [Optional] Specifies a priority for the query. Possible values include
   * INTERACTIVE and BATCH. The default value is INTERACTIVE.
   */
  core.String priority;
  /** [Required] BigQuery SQL query to execute. */
  core.String query;
  /** Query parameters for standard SQL queries. */
  core.List<QueryParameter> queryParameters;
  /**
   * [Experimental] Allows the schema of the destination table to be updated as
   * a side effect of the query job. Schema update options are supported in two
   * cases: when writeDisposition is WRITE_APPEND; when writeDisposition is
   * WRITE_TRUNCATE and the destination table is a partition of a table,
   * specified by partition decorators. For normal tables, WRITE_TRUNCATE will
   * always overwrite the schema. One or more of the following values are
   * specified: ALLOW_FIELD_ADDITION: allow adding a nullable field to the
   * schema. ALLOW_FIELD_RELAXATION: allow relaxing a required field in the
   * original schema to nullable.
   */
  core.List<core.String> schemaUpdateOptions;
  /**
   * [Optional] If querying an external data source outside of BigQuery,
   * describes the data format, location and other properties of the data
   * source. By defining these properties, the data source can then be queried
   * as if it were a standard BigQuery table.
   */
  core.Map<core.String, ExternalDataConfiguration> tableDefinitions;
  /**
   * Specifies whether to use BigQuery's legacy SQL dialect for this query. The
   * default value is true. If set to false, the query will use BigQuery's
   * standard SQL: https://cloud.google.com/bigquery/sql-reference/ When
   * useLegacySql is set to false, the values of allowLargeResults and
   * flattenResults are ignored; query will be run as if allowLargeResults is
   * true and flattenResults is false.
   */
  core.bool useLegacySql;
  /**
   * [Optional] Whether to look for the result in the query cache. The query
   * cache is a best-effort cache that will be flushed whenever tables in the
   * query are modified. Moreover, the query cache is only available when a
   * query does not have a destination table specified. The default value is
   * true.
   */
  core.bool useQueryCache;
  /**
   * [Experimental] Describes user-defined function resources used in the query.
   */
  core.List<UserDefinedFunctionResource> userDefinedFunctionResources;
  /**
   * [Optional] Specifies the action that occurs if the destination table
   * already exists. The following values are supported: WRITE_TRUNCATE: If the
   * table already exists, BigQuery overwrites the table data. WRITE_APPEND: If
   * the table already exists, BigQuery appends the data to the table.
   * WRITE_EMPTY: If the table already exists and contains data, a 'duplicate'
   * error is returned in the job result. The default value is WRITE_EMPTY. Each
   * action is atomic and only occurs if BigQuery is able to complete the job
   * successfully. Creation, truncation and append actions occur as one atomic
   * update upon job completion.
   */
  core.String writeDisposition;

  JobConfigurationQuery();

  JobConfigurationQuery.fromJson(core.Map _json) {
    if (_json.containsKey("allowLargeResults")) {
      allowLargeResults = _json["allowLargeResults"];
    }
    if (_json.containsKey("createDisposition")) {
      createDisposition = _json["createDisposition"];
    }
    if (_json.containsKey("defaultDataset")) {
      defaultDataset = new DatasetReference.fromJson(_json["defaultDataset"]);
    }
    if (_json.containsKey("destinationTable")) {
      destinationTable = new TableReference.fromJson(_json["destinationTable"]);
    }
    if (_json.containsKey("flattenResults")) {
      flattenResults = _json["flattenResults"];
    }
    if (_json.containsKey("maximumBillingTier")) {
      maximumBillingTier = _json["maximumBillingTier"];
    }
    if (_json.containsKey("maximumBytesBilled")) {
      maximumBytesBilled = _json["maximumBytesBilled"];
    }
    if (_json.containsKey("parameterMode")) {
      parameterMode = _json["parameterMode"];
    }
    if (_json.containsKey("preserveNulls")) {
      preserveNulls = _json["preserveNulls"];
    }
    if (_json.containsKey("priority")) {
      priority = _json["priority"];
    }
    if (_json.containsKey("query")) {
      query = _json["query"];
    }
    if (_json.containsKey("queryParameters")) {
      queryParameters = _json["queryParameters"].map((value) => new QueryParameter.fromJson(value)).toList();
    }
    if (_json.containsKey("schemaUpdateOptions")) {
      schemaUpdateOptions = _json["schemaUpdateOptions"];
    }
    if (_json.containsKey("tableDefinitions")) {
      tableDefinitions = commons.mapMap(_json["tableDefinitions"], (item) => new ExternalDataConfiguration.fromJson(item));
    }
    if (_json.containsKey("useLegacySql")) {
      useLegacySql = _json["useLegacySql"];
    }
    if (_json.containsKey("useQueryCache")) {
      useQueryCache = _json["useQueryCache"];
    }
    if (_json.containsKey("userDefinedFunctionResources")) {
      userDefinedFunctionResources = _json["userDefinedFunctionResources"].map((value) => new UserDefinedFunctionResource.fromJson(value)).toList();
    }
    if (_json.containsKey("writeDisposition")) {
      writeDisposition = _json["writeDisposition"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowLargeResults != null) {
      _json["allowLargeResults"] = allowLargeResults;
    }
    if (createDisposition != null) {
      _json["createDisposition"] = createDisposition;
    }
    if (defaultDataset != null) {
      _json["defaultDataset"] = (defaultDataset).toJson();
    }
    if (destinationTable != null) {
      _json["destinationTable"] = (destinationTable).toJson();
    }
    if (flattenResults != null) {
      _json["flattenResults"] = flattenResults;
    }
    if (maximumBillingTier != null) {
      _json["maximumBillingTier"] = maximumBillingTier;
    }
    if (maximumBytesBilled != null) {
      _json["maximumBytesBilled"] = maximumBytesBilled;
    }
    if (parameterMode != null) {
      _json["parameterMode"] = parameterMode;
    }
    if (preserveNulls != null) {
      _json["preserveNulls"] = preserveNulls;
    }
    if (priority != null) {
      _json["priority"] = priority;
    }
    if (query != null) {
      _json["query"] = query;
    }
    if (queryParameters != null) {
      _json["queryParameters"] = queryParameters.map((value) => (value).toJson()).toList();
    }
    if (schemaUpdateOptions != null) {
      _json["schemaUpdateOptions"] = schemaUpdateOptions;
    }
    if (tableDefinitions != null) {
      _json["tableDefinitions"] = commons.mapMap(tableDefinitions, (item) => (item).toJson());
    }
    if (useLegacySql != null) {
      _json["useLegacySql"] = useLegacySql;
    }
    if (useQueryCache != null) {
      _json["useQueryCache"] = useQueryCache;
    }
    if (userDefinedFunctionResources != null) {
      _json["userDefinedFunctionResources"] = userDefinedFunctionResources.map((value) => (value).toJson()).toList();
    }
    if (writeDisposition != null) {
      _json["writeDisposition"] = writeDisposition;
    }
    return _json;
  }
}

class JobConfigurationTableCopy {
  /**
   * [Optional] Specifies whether the job is allowed to create new tables. The
   * following values are supported: CREATE_IF_NEEDED: If the table does not
   * exist, BigQuery creates the table. CREATE_NEVER: The table must already
   * exist. If it does not, a 'notFound' error is returned in the job result.
   * The default value is CREATE_IF_NEEDED. Creation, truncation and append
   * actions occur as one atomic update upon job completion.
   */
  core.String createDisposition;
  /** [Required] The destination table */
  TableReference destinationTable;
  /** [Pick one] Source table to copy. */
  TableReference sourceTable;
  /** [Pick one] Source tables to copy. */
  core.List<TableReference> sourceTables;
  /**
   * [Optional] Specifies the action that occurs if the destination table
   * already exists. The following values are supported: WRITE_TRUNCATE: If the
   * table already exists, BigQuery overwrites the table data. WRITE_APPEND: If
   * the table already exists, BigQuery appends the data to the table.
   * WRITE_EMPTY: If the table already exists and contains data, a 'duplicate'
   * error is returned in the job result. The default value is WRITE_EMPTY. Each
   * action is atomic and only occurs if BigQuery is able to complete the job
   * successfully. Creation, truncation and append actions occur as one atomic
   * update upon job completion.
   */
  core.String writeDisposition;

  JobConfigurationTableCopy();

  JobConfigurationTableCopy.fromJson(core.Map _json) {
    if (_json.containsKey("createDisposition")) {
      createDisposition = _json["createDisposition"];
    }
    if (_json.containsKey("destinationTable")) {
      destinationTable = new TableReference.fromJson(_json["destinationTable"]);
    }
    if (_json.containsKey("sourceTable")) {
      sourceTable = new TableReference.fromJson(_json["sourceTable"]);
    }
    if (_json.containsKey("sourceTables")) {
      sourceTables = _json["sourceTables"].map((value) => new TableReference.fromJson(value)).toList();
    }
    if (_json.containsKey("writeDisposition")) {
      writeDisposition = _json["writeDisposition"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (createDisposition != null) {
      _json["createDisposition"] = createDisposition;
    }
    if (destinationTable != null) {
      _json["destinationTable"] = (destinationTable).toJson();
    }
    if (sourceTable != null) {
      _json["sourceTable"] = (sourceTable).toJson();
    }
    if (sourceTables != null) {
      _json["sourceTables"] = sourceTables.map((value) => (value).toJson()).toList();
    }
    if (writeDisposition != null) {
      _json["writeDisposition"] = writeDisposition;
    }
    return _json;
  }
}

class JobListJobs {
  /** [Full-projection-only] Specifies the job configuration. */
  JobConfiguration configuration;
  /** A result object that will be present only if the job has failed. */
  ErrorProto errorResult;
  /** Unique opaque ID of the job. */
  core.String id;
  /** Job reference uniquely identifying the job. */
  JobReference jobReference;
  /** The resource type. */
  core.String kind;
  /**
   * Running state of the job. When the state is DONE, errorResult can be
   * checked to determine whether the job succeeded or failed.
   */
  core.String state;
  /**
   * [Output-only] Information about the job, including starting time and ending
   * time of the job.
   */
  JobStatistics statistics;
  /** [Full-projection-only] Describes the state of the job. */
  JobStatus status;
  /** [Full-projection-only] Email address of the user who ran the job. */
  core.String userEmail;

  JobListJobs();

  JobListJobs.fromJson(core.Map _json) {
    if (_json.containsKey("configuration")) {
      configuration = new JobConfiguration.fromJson(_json["configuration"]);
    }
    if (_json.containsKey("errorResult")) {
      errorResult = new ErrorProto.fromJson(_json["errorResult"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("jobReference")) {
      jobReference = new JobReference.fromJson(_json["jobReference"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("statistics")) {
      statistics = new JobStatistics.fromJson(_json["statistics"]);
    }
    if (_json.containsKey("status")) {
      status = new JobStatus.fromJson(_json["status"]);
    }
    if (_json.containsKey("user_email")) {
      userEmail = _json["user_email"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (configuration != null) {
      _json["configuration"] = (configuration).toJson();
    }
    if (errorResult != null) {
      _json["errorResult"] = (errorResult).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (jobReference != null) {
      _json["jobReference"] = (jobReference).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (statistics != null) {
      _json["statistics"] = (statistics).toJson();
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    if (userEmail != null) {
      _json["user_email"] = userEmail;
    }
    return _json;
  }
}

class JobList {
  /** A hash of this page of results. */
  core.String etag;
  /** List of jobs that were requested. */
  core.List<JobListJobs> jobs;
  /** The resource type of the response. */
  core.String kind;
  /** A token to request the next page of results. */
  core.String nextPageToken;

  JobList();

  JobList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("jobs")) {
      jobs = _json["jobs"].map((value) => new JobListJobs.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (jobs != null) {
      _json["jobs"] = jobs.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

class JobReference {
  /**
   * [Required] The ID of the job. The ID must contain only letters (a-z, A-Z),
   * numbers (0-9), underscores (_), or dashes (-). The maximum length is 1,024
   * characters.
   */
  core.String jobId;
  /** [Required] The ID of the project containing this job. */
  core.String projectId;

  JobReference();

  JobReference.fromJson(core.Map _json) {
    if (_json.containsKey("jobId")) {
      jobId = _json["jobId"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (jobId != null) {
      _json["jobId"] = jobId;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    return _json;
  }
}

class JobStatistics {
  /**
   * [Output-only] Creation time of this job, in milliseconds since the epoch.
   * This field will be present on all jobs.
   */
  core.String creationTime;
  /**
   * [Output-only] End time of this job, in milliseconds since the epoch. This
   * field will be present whenever a job is in the DONE state.
   */
  core.String endTime;
  /** [Output-only] Statistics for an extract job. */
  JobStatistics4 extract;
  /** [Output-only] Statistics for a load job. */
  JobStatistics3 load;
  /** [Output-only] Statistics for a query job. */
  JobStatistics2 query;
  /**
   * [Output-only] Start time of this job, in milliseconds since the epoch. This
   * field will be present when the job transitions from the PENDING state to
   * either RUNNING or DONE.
   */
  core.String startTime;
  /**
   * [Output-only] [Deprecated] Use the bytes processed in the query statistics
   * instead.
   */
  core.String totalBytesProcessed;

  JobStatistics();

  JobStatistics.fromJson(core.Map _json) {
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("extract")) {
      extract = new JobStatistics4.fromJson(_json["extract"]);
    }
    if (_json.containsKey("load")) {
      load = new JobStatistics3.fromJson(_json["load"]);
    }
    if (_json.containsKey("query")) {
      query = new JobStatistics2.fromJson(_json["query"]);
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
    if (_json.containsKey("totalBytesProcessed")) {
      totalBytesProcessed = _json["totalBytesProcessed"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (extract != null) {
      _json["extract"] = (extract).toJson();
    }
    if (load != null) {
      _json["load"] = (load).toJson();
    }
    if (query != null) {
      _json["query"] = (query).toJson();
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    if (totalBytesProcessed != null) {
      _json["totalBytesProcessed"] = totalBytesProcessed;
    }
    return _json;
  }
}

class JobStatistics2 {
  /** [Output-only] Billing tier for the job. */
  core.int billingTier;
  /**
   * [Output-only] Whether the query result was fetched from the query cache.
   */
  core.bool cacheHit;
  /**
   * [Output-only, Experimental] The number of rows affected by a DML statement.
   * Present only for DML statements INSERT, UPDATE or DELETE.
   */
  core.String numDmlAffectedRows;
  /** [Output-only, Experimental] Describes execution plan for the query. */
  core.List<ExplainQueryStage> queryPlan;
  /**
   * [Output-only, Experimental] Referenced tables for the job. Queries that
   * reference more than 50 tables will not have a complete list.
   */
  core.List<TableReference> referencedTables;
  /**
   * [Output-only, Experimental] The schema of the results. Present only for
   * successful dry run of non-legacy SQL queries.
   */
  TableSchema schema;
  /** [Output-only, Experimental] The type of query statement, if valid. */
  core.String statementType;
  /** [Output-only] Total bytes billed for the job. */
  core.String totalBytesBilled;
  /** [Output-only] Total bytes processed for the job. */
  core.String totalBytesProcessed;
  /**
   * [Output-only, Experimental] Standard SQL only: list of undeclared query
   * parameters detected during a dry run validation.
   */
  core.List<QueryParameter> undeclaredQueryParameters;

  JobStatistics2();

  JobStatistics2.fromJson(core.Map _json) {
    if (_json.containsKey("billingTier")) {
      billingTier = _json["billingTier"];
    }
    if (_json.containsKey("cacheHit")) {
      cacheHit = _json["cacheHit"];
    }
    if (_json.containsKey("numDmlAffectedRows")) {
      numDmlAffectedRows = _json["numDmlAffectedRows"];
    }
    if (_json.containsKey("queryPlan")) {
      queryPlan = _json["queryPlan"].map((value) => new ExplainQueryStage.fromJson(value)).toList();
    }
    if (_json.containsKey("referencedTables")) {
      referencedTables = _json["referencedTables"].map((value) => new TableReference.fromJson(value)).toList();
    }
    if (_json.containsKey("schema")) {
      schema = new TableSchema.fromJson(_json["schema"]);
    }
    if (_json.containsKey("statementType")) {
      statementType = _json["statementType"];
    }
    if (_json.containsKey("totalBytesBilled")) {
      totalBytesBilled = _json["totalBytesBilled"];
    }
    if (_json.containsKey("totalBytesProcessed")) {
      totalBytesProcessed = _json["totalBytesProcessed"];
    }
    if (_json.containsKey("undeclaredQueryParameters")) {
      undeclaredQueryParameters = _json["undeclaredQueryParameters"].map((value) => new QueryParameter.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (billingTier != null) {
      _json["billingTier"] = billingTier;
    }
    if (cacheHit != null) {
      _json["cacheHit"] = cacheHit;
    }
    if (numDmlAffectedRows != null) {
      _json["numDmlAffectedRows"] = numDmlAffectedRows;
    }
    if (queryPlan != null) {
      _json["queryPlan"] = queryPlan.map((value) => (value).toJson()).toList();
    }
    if (referencedTables != null) {
      _json["referencedTables"] = referencedTables.map((value) => (value).toJson()).toList();
    }
    if (schema != null) {
      _json["schema"] = (schema).toJson();
    }
    if (statementType != null) {
      _json["statementType"] = statementType;
    }
    if (totalBytesBilled != null) {
      _json["totalBytesBilled"] = totalBytesBilled;
    }
    if (totalBytesProcessed != null) {
      _json["totalBytesProcessed"] = totalBytesProcessed;
    }
    if (undeclaredQueryParameters != null) {
      _json["undeclaredQueryParameters"] = undeclaredQueryParameters.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class JobStatistics3 {
  /** [Output-only] Number of bytes of source data in a load job. */
  core.String inputFileBytes;
  /** [Output-only] Number of source files in a load job. */
  core.String inputFiles;
  /**
   * [Output-only] Size of the loaded data in bytes. Note that while a load job
   * is in the running state, this value may change.
   */
  core.String outputBytes;
  /**
   * [Output-only] Number of rows imported in a load job. Note that while an
   * import job is in the running state, this value may change.
   */
  core.String outputRows;

  JobStatistics3();

  JobStatistics3.fromJson(core.Map _json) {
    if (_json.containsKey("inputFileBytes")) {
      inputFileBytes = _json["inputFileBytes"];
    }
    if (_json.containsKey("inputFiles")) {
      inputFiles = _json["inputFiles"];
    }
    if (_json.containsKey("outputBytes")) {
      outputBytes = _json["outputBytes"];
    }
    if (_json.containsKey("outputRows")) {
      outputRows = _json["outputRows"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (inputFileBytes != null) {
      _json["inputFileBytes"] = inputFileBytes;
    }
    if (inputFiles != null) {
      _json["inputFiles"] = inputFiles;
    }
    if (outputBytes != null) {
      _json["outputBytes"] = outputBytes;
    }
    if (outputRows != null) {
      _json["outputRows"] = outputRows;
    }
    return _json;
  }
}

class JobStatistics4 {
  /**
   * [Output-only] Number of files per destination URI or URI pattern specified
   * in the extract configuration. These values will be in the same order as the
   * URIs specified in the 'destinationUris' field.
   */
  core.List<core.String> destinationUriFileCounts;

  JobStatistics4();

  JobStatistics4.fromJson(core.Map _json) {
    if (_json.containsKey("destinationUriFileCounts")) {
      destinationUriFileCounts = _json["destinationUriFileCounts"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (destinationUriFileCounts != null) {
      _json["destinationUriFileCounts"] = destinationUriFileCounts;
    }
    return _json;
  }
}

class JobStatus {
  /**
   * [Output-only] Final error result of the job. If present, indicates that the
   * job has completed and was unsuccessful.
   */
  ErrorProto errorResult;
  /**
   * [Output-only] All errors encountered during the running of the job. Errors
   * here do not necessarily mean that the job has completed or was
   * unsuccessful.
   */
  core.List<ErrorProto> errors;
  /** [Output-only] Running state of the job. */
  core.String state;

  JobStatus();

  JobStatus.fromJson(core.Map _json) {
    if (_json.containsKey("errorResult")) {
      errorResult = new ErrorProto.fromJson(_json["errorResult"]);
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"].map((value) => new ErrorProto.fromJson(value)).toList();
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (errorResult != null) {
      _json["errorResult"] = (errorResult).toJson();
    }
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    if (state != null) {
      _json["state"] = state;
    }
    return _json;
  }
}

/** Represents a single JSON object. */
class JsonObject
    extends collection.MapBase<core.String, core.Object> {
  final core.Map _innerMap = {};

  JsonObject();

  JsonObject.fromJson(core.Map _json) {
    _json.forEach((core.String key, value) {
      this[key] = value;
    });
  }

  core.Map toJson() {
    var _json = {};
    this.forEach((core.String key, value) {
      _json[key] = value;
    });
    return _json;
  }

  core.Object operator [](core.Object key)
      => _innerMap[key];

  operator []=(core.String key, core.Object value) {
    _innerMap[key] = value;
  }

  void clear() {
    _innerMap.clear();
  }

  core.Iterable<core.String> get keys => _innerMap.keys;

  core.Object remove(core.Object key) => _innerMap.remove(key);
}

class ProjectListProjects {
  /** A descriptive name for this project. */
  core.String friendlyName;
  /** An opaque ID of this project. */
  core.String id;
  /** The resource type. */
  core.String kind;
  /** The numeric ID of this project. */
  core.String numericId;
  /** A unique reference to this project. */
  ProjectReference projectReference;

  ProjectListProjects();

  ProjectListProjects.fromJson(core.Map _json) {
    if (_json.containsKey("friendlyName")) {
      friendlyName = _json["friendlyName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("numericId")) {
      numericId = _json["numericId"];
    }
    if (_json.containsKey("projectReference")) {
      projectReference = new ProjectReference.fromJson(_json["projectReference"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (friendlyName != null) {
      _json["friendlyName"] = friendlyName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (numericId != null) {
      _json["numericId"] = numericId;
    }
    if (projectReference != null) {
      _json["projectReference"] = (projectReference).toJson();
    }
    return _json;
  }
}

class ProjectList {
  /** A hash of the page of results */
  core.String etag;
  /** The type of list. */
  core.String kind;
  /** A token to request the next page of results. */
  core.String nextPageToken;
  /** Projects to which you have at least READ access. */
  core.List<ProjectListProjects> projects;
  /** The total number of projects in the list. */
  core.int totalItems;

  ProjectList();

  ProjectList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("projects")) {
      projects = _json["projects"].map((value) => new ProjectListProjects.fromJson(value)).toList();
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (projects != null) {
      _json["projects"] = projects.map((value) => (value).toJson()).toList();
    }
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

class ProjectReference {
  /**
   * [Required] ID of the project. Can be either the numeric ID or the assigned
   * ID of the project.
   */
  core.String projectId;

  ProjectReference();

  ProjectReference.fromJson(core.Map _json) {
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    return _json;
  }
}

class QueryParameter {
  /**
   * [Optional] If unset, this is a positional parameter. Otherwise, should be
   * unique within a query.
   */
  core.String name;
  /** [Required] The type of this parameter. */
  QueryParameterType parameterType;
  /** [Required] The value of this parameter. */
  QueryParameterValue parameterValue;

  QueryParameter();

  QueryParameter.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parameterType")) {
      parameterType = new QueryParameterType.fromJson(_json["parameterType"]);
    }
    if (_json.containsKey("parameterValue")) {
      parameterValue = new QueryParameterValue.fromJson(_json["parameterValue"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (parameterType != null) {
      _json["parameterType"] = (parameterType).toJson();
    }
    if (parameterValue != null) {
      _json["parameterValue"] = (parameterValue).toJson();
    }
    return _json;
  }
}

class QueryParameterTypeStructTypes {
  /** [Optional] Human-oriented description of the field. */
  core.String description;
  /** [Optional] The name of this field. */
  core.String name;
  /** [Required] The type of this field. */
  QueryParameterType type;

  QueryParameterTypeStructTypes();

  QueryParameterTypeStructTypes.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = new QueryParameterType.fromJson(_json["type"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (type != null) {
      _json["type"] = (type).toJson();
    }
    return _json;
  }
}

class QueryParameterType {
  /** [Optional] The type of the array's elements, if this is an array. */
  QueryParameterType arrayType;
  /**
   * [Optional] The types of the fields of this struct, in order, if this is a
   * struct.
   */
  core.List<QueryParameterTypeStructTypes> structTypes;
  /** [Required] The top level type of this field. */
  core.String type;

  QueryParameterType();

  QueryParameterType.fromJson(core.Map _json) {
    if (_json.containsKey("arrayType")) {
      arrayType = new QueryParameterType.fromJson(_json["arrayType"]);
    }
    if (_json.containsKey("structTypes")) {
      structTypes = _json["structTypes"].map((value) => new QueryParameterTypeStructTypes.fromJson(value)).toList();
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (arrayType != null) {
      _json["arrayType"] = (arrayType).toJson();
    }
    if (structTypes != null) {
      _json["structTypes"] = structTypes.map((value) => (value).toJson()).toList();
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class QueryParameterValue {
  /** [Optional] The array values, if this is an array type. */
  core.List<QueryParameterValue> arrayValues;
  /**
   * [Optional] The struct field values, in order of the struct type's
   * declaration.
   */
  core.Map<core.String, QueryParameterValue> structValues;
  /** [Optional] The value of this value, if a simple scalar type. */
  core.String value;

  QueryParameterValue();

  QueryParameterValue.fromJson(core.Map _json) {
    if (_json.containsKey("arrayValues")) {
      arrayValues = _json["arrayValues"].map((value) => new QueryParameterValue.fromJson(value)).toList();
    }
    if (_json.containsKey("structValues")) {
      structValues = commons.mapMap(_json["structValues"], (item) => new QueryParameterValue.fromJson(item));
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (arrayValues != null) {
      _json["arrayValues"] = arrayValues.map((value) => (value).toJson()).toList();
    }
    if (structValues != null) {
      _json["structValues"] = commons.mapMap(structValues, (item) => (item).toJson());
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class QueryRequest {
  /**
   * [Optional] Specifies the default datasetId and projectId to assume for any
   * unqualified table names in the query. If not set, all table names in the
   * query string must be qualified in the format 'datasetId.tableId'.
   */
  DatasetReference defaultDataset;
  /**
   * [Optional] If set to true, BigQuery doesn't run the job. Instead, if the
   * query is valid, BigQuery returns statistics about the job such as how many
   * bytes would be processed. If the query is invalid, an error returns. The
   * default value is false.
   */
  core.bool dryRun;
  /** The resource type of the request. */
  core.String kind;
  /**
   * [Optional] The maximum number of rows of data to return per page of
   * results. Setting this flag to a small value such as 1000 and then paging
   * through results might improve reliability when the query result set is
   * large. In addition to this limit, responses are also limited to 10 MB. By
   * default, there is no maximum row count, and only the byte limit applies.
   */
  core.int maxResults;
  /**
   * [Experimental] Standard SQL only. Set to POSITIONAL to use positional (?)
   * query parameters or to NAMED to use named (@myparam) query parameters in
   * this query.
   */
  core.String parameterMode;
  /** [Deprecated] This property is deprecated. */
  core.bool preserveNulls;
  /**
   * [Required] A query string, following the BigQuery query syntax, of the
   * query to execute. Example: "SELECT count(f1) FROM
   * [myProjectId:myDatasetId.myTableId]".
   */
  core.String query;
  /** [Experimental] Query parameters for Standard SQL queries. */
  core.List<QueryParameter> queryParameters;
  /**
   * [Optional] How long to wait for the query to complete, in milliseconds,
   * before the request times out and returns. Note that this is only a timeout
   * for the request, not the query. If the query takes longer to run than the
   * timeout value, the call returns without any results and with the
   * 'jobComplete' flag set to false. You can call GetQueryResults() to wait for
   * the query to complete and read the results. The default value is 10000
   * milliseconds (10 seconds).
   */
  core.int timeoutMs;
  /**
   * Specifies whether to use BigQuery's legacy SQL dialect for this query. The
   * default value is true. If set to false, the query will use BigQuery's
   * standard SQL: https://cloud.google.com/bigquery/sql-reference/ When
   * useLegacySql is set to false, the values of allowLargeResults and
   * flattenResults are ignored; query will be run as if allowLargeResults is
   * true and flattenResults is false.
   */
  core.bool useLegacySql;
  /**
   * [Optional] Whether to look for the result in the query cache. The query
   * cache is a best-effort cache that will be flushed whenever tables in the
   * query are modified. The default value is true.
   */
  core.bool useQueryCache;

  QueryRequest();

  QueryRequest.fromJson(core.Map _json) {
    if (_json.containsKey("defaultDataset")) {
      defaultDataset = new DatasetReference.fromJson(_json["defaultDataset"]);
    }
    if (_json.containsKey("dryRun")) {
      dryRun = _json["dryRun"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("maxResults")) {
      maxResults = _json["maxResults"];
    }
    if (_json.containsKey("parameterMode")) {
      parameterMode = _json["parameterMode"];
    }
    if (_json.containsKey("preserveNulls")) {
      preserveNulls = _json["preserveNulls"];
    }
    if (_json.containsKey("query")) {
      query = _json["query"];
    }
    if (_json.containsKey("queryParameters")) {
      queryParameters = _json["queryParameters"].map((value) => new QueryParameter.fromJson(value)).toList();
    }
    if (_json.containsKey("timeoutMs")) {
      timeoutMs = _json["timeoutMs"];
    }
    if (_json.containsKey("useLegacySql")) {
      useLegacySql = _json["useLegacySql"];
    }
    if (_json.containsKey("useQueryCache")) {
      useQueryCache = _json["useQueryCache"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (defaultDataset != null) {
      _json["defaultDataset"] = (defaultDataset).toJson();
    }
    if (dryRun != null) {
      _json["dryRun"] = dryRun;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (maxResults != null) {
      _json["maxResults"] = maxResults;
    }
    if (parameterMode != null) {
      _json["parameterMode"] = parameterMode;
    }
    if (preserveNulls != null) {
      _json["preserveNulls"] = preserveNulls;
    }
    if (query != null) {
      _json["query"] = query;
    }
    if (queryParameters != null) {
      _json["queryParameters"] = queryParameters.map((value) => (value).toJson()).toList();
    }
    if (timeoutMs != null) {
      _json["timeoutMs"] = timeoutMs;
    }
    if (useLegacySql != null) {
      _json["useLegacySql"] = useLegacySql;
    }
    if (useQueryCache != null) {
      _json["useQueryCache"] = useQueryCache;
    }
    return _json;
  }
}

class QueryResponse {
  /** Whether the query result was fetched from the query cache. */
  core.bool cacheHit;
  /**
   * [Output-only] All errors and warnings encountered during the running of the
   * job. Errors here do not necessarily mean that the job has completed or was
   * unsuccessful.
   */
  core.List<ErrorProto> errors;
  /**
   * Whether the query has completed or not. If rows or totalRows are present,
   * this will always be true. If this is false, totalRows will not be
   * available.
   */
  core.bool jobComplete;
  /**
   * Reference to the Job that was created to run the query. This field will be
   * present even if the original request timed out, in which case
   * GetQueryResults can be used to read the results once the query has
   * completed. Since this API only returns the first page of results,
   * subsequent pages can be fetched via the same mechanism (GetQueryResults).
   */
  JobReference jobReference;
  /** The resource type. */
  core.String kind;
  /**
   * [Output-only, Experimental] The number of rows affected by a DML statement.
   * Present only for DML statements INSERT, UPDATE or DELETE.
   */
  core.String numDmlAffectedRows;
  /** A token used for paging results. */
  core.String pageToken;
  /**
   * An object with as many results as can be contained within the maximum
   * permitted reply size. To get any additional rows, you can call
   * GetQueryResults and specify the jobReference returned above.
   */
  core.List<TableRow> rows;
  /**
   * The schema of the results. Present only when the query completes
   * successfully.
   */
  TableSchema schema;
  /**
   * The total number of bytes processed for this query. If this query was a dry
   * run, this is the number of bytes that would be processed if the query were
   * run.
   */
  core.String totalBytesProcessed;
  /**
   * The total number of rows in the complete query result set, which can be
   * more than the number of rows in this single page of results.
   */
  core.String totalRows;

  QueryResponse();

  QueryResponse.fromJson(core.Map _json) {
    if (_json.containsKey("cacheHit")) {
      cacheHit = _json["cacheHit"];
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"].map((value) => new ErrorProto.fromJson(value)).toList();
    }
    if (_json.containsKey("jobComplete")) {
      jobComplete = _json["jobComplete"];
    }
    if (_json.containsKey("jobReference")) {
      jobReference = new JobReference.fromJson(_json["jobReference"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("numDmlAffectedRows")) {
      numDmlAffectedRows = _json["numDmlAffectedRows"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"].map((value) => new TableRow.fromJson(value)).toList();
    }
    if (_json.containsKey("schema")) {
      schema = new TableSchema.fromJson(_json["schema"]);
    }
    if (_json.containsKey("totalBytesProcessed")) {
      totalBytesProcessed = _json["totalBytesProcessed"];
    }
    if (_json.containsKey("totalRows")) {
      totalRows = _json["totalRows"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cacheHit != null) {
      _json["cacheHit"] = cacheHit;
    }
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    if (jobComplete != null) {
      _json["jobComplete"] = jobComplete;
    }
    if (jobReference != null) {
      _json["jobReference"] = (jobReference).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (numDmlAffectedRows != null) {
      _json["numDmlAffectedRows"] = numDmlAffectedRows;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    if (rows != null) {
      _json["rows"] = rows.map((value) => (value).toJson()).toList();
    }
    if (schema != null) {
      _json["schema"] = (schema).toJson();
    }
    if (totalBytesProcessed != null) {
      _json["totalBytesProcessed"] = totalBytesProcessed;
    }
    if (totalRows != null) {
      _json["totalRows"] = totalRows;
    }
    return _json;
  }
}

class Streamingbuffer {
  /**
   * [Output-only] A lower-bound estimate of the number of bytes currently in
   * the streaming buffer.
   */
  core.String estimatedBytes;
  /**
   * [Output-only] A lower-bound estimate of the number of rows currently in the
   * streaming buffer.
   */
  core.String estimatedRows;
  /**
   * [Output-only] Contains the timestamp of the oldest entry in the streaming
   * buffer, in milliseconds since the epoch, if the streaming buffer is
   * available.
   */
  core.String oldestEntryTime;

  Streamingbuffer();

  Streamingbuffer.fromJson(core.Map _json) {
    if (_json.containsKey("estimatedBytes")) {
      estimatedBytes = _json["estimatedBytes"];
    }
    if (_json.containsKey("estimatedRows")) {
      estimatedRows = _json["estimatedRows"];
    }
    if (_json.containsKey("oldestEntryTime")) {
      oldestEntryTime = _json["oldestEntryTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (estimatedBytes != null) {
      _json["estimatedBytes"] = estimatedBytes;
    }
    if (estimatedRows != null) {
      _json["estimatedRows"] = estimatedRows;
    }
    if (oldestEntryTime != null) {
      _json["oldestEntryTime"] = oldestEntryTime;
    }
    return _json;
  }
}

class Table {
  /**
   * [Output-only] The time when this table was created, in milliseconds since
   * the epoch.
   */
  core.String creationTime;
  /** [Optional] A user-friendly description of this table. */
  core.String description;
  /** [Output-only] A hash of this resource. */
  core.String etag;
  /**
   * [Optional] The time when this table expires, in milliseconds since the
   * epoch. If not present, the table will persist indefinitely. Expired tables
   * will be deleted and their storage reclaimed.
   */
  core.String expirationTime;
  /**
   * [Optional] Describes the data format, location, and other properties of a
   * table stored outside of BigQuery. By defining these properties, the data
   * source can then be queried as if it were a standard BigQuery table.
   */
  ExternalDataConfiguration externalDataConfiguration;
  /** [Optional] A descriptive name for this table. */
  core.String friendlyName;
  /** [Output-only] An opaque ID uniquely identifying the table. */
  core.String id;
  /** [Output-only] The type of the resource. */
  core.String kind;
  /**
   * [Experimental] The labels associated with this table. You can use these to
   * organize and group your tables. Label keys and values can be no longer than
   * 63 characters, can only contain lowercase letters, numeric characters,
   * underscores and dashes. International characters are allowed. Label values
   * are optional. Label keys must start with a letter and each label in the
   * list must have a different key.
   */
  core.Map<core.String, core.String> labels;
  /**
   * [Output-only] The time when this table was last modified, in milliseconds
   * since the epoch.
   */
  core.String lastModifiedTime;
  /**
   * [Output-only] The geographic location where the table resides. This value
   * is inherited from the dataset.
   */
  core.String location;
  /**
   * [Output-only] The size of this table in bytes, excluding any data in the
   * streaming buffer.
   */
  core.String numBytes;
  /**
   * [Output-only] The number of bytes in the table that are considered
   * "long-term storage".
   */
  core.String numLongTermBytes;
  /**
   * [Output-only] The number of rows of data in this table, excluding any data
   * in the streaming buffer.
   */
  core.String numRows;
  /** [Optional] Describes the schema of this table. */
  TableSchema schema;
  /** [Output-only] A URL that can be used to access this resource again. */
  core.String selfLink;
  /**
   * [Output-only] Contains information regarding this table's streaming buffer,
   * if one is present. This field will be absent if the table is not being
   * streamed to or if there is no data in the streaming buffer.
   */
  Streamingbuffer streamingBuffer;
  /** [Required] Reference describing the ID of this table. */
  TableReference tableReference;
  /**
   * [Experimental] If specified, configures time-based partitioning for this
   * table.
   */
  TimePartitioning timePartitioning;
  /**
   * [Output-only] Describes the table type. The following values are supported:
   * TABLE: A normal BigQuery table. VIEW: A virtual table defined by a SQL
   * query. EXTERNAL: A table that references data stored in an external storage
   * system, such as Google Cloud Storage. The default value is TABLE.
   */
  core.String type;
  /** [Optional] The view definition. */
  ViewDefinition view;

  Table();

  Table.fromJson(core.Map _json) {
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("expirationTime")) {
      expirationTime = _json["expirationTime"];
    }
    if (_json.containsKey("externalDataConfiguration")) {
      externalDataConfiguration = new ExternalDataConfiguration.fromJson(_json["externalDataConfiguration"]);
    }
    if (_json.containsKey("friendlyName")) {
      friendlyName = _json["friendlyName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("lastModifiedTime")) {
      lastModifiedTime = _json["lastModifiedTime"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("numBytes")) {
      numBytes = _json["numBytes"];
    }
    if (_json.containsKey("numLongTermBytes")) {
      numLongTermBytes = _json["numLongTermBytes"];
    }
    if (_json.containsKey("numRows")) {
      numRows = _json["numRows"];
    }
    if (_json.containsKey("schema")) {
      schema = new TableSchema.fromJson(_json["schema"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("streamingBuffer")) {
      streamingBuffer = new Streamingbuffer.fromJson(_json["streamingBuffer"]);
    }
    if (_json.containsKey("tableReference")) {
      tableReference = new TableReference.fromJson(_json["tableReference"]);
    }
    if (_json.containsKey("timePartitioning")) {
      timePartitioning = new TimePartitioning.fromJson(_json["timePartitioning"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("view")) {
      view = new ViewDefinition.fromJson(_json["view"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (expirationTime != null) {
      _json["expirationTime"] = expirationTime;
    }
    if (externalDataConfiguration != null) {
      _json["externalDataConfiguration"] = (externalDataConfiguration).toJson();
    }
    if (friendlyName != null) {
      _json["friendlyName"] = friendlyName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (lastModifiedTime != null) {
      _json["lastModifiedTime"] = lastModifiedTime;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (numBytes != null) {
      _json["numBytes"] = numBytes;
    }
    if (numLongTermBytes != null) {
      _json["numLongTermBytes"] = numLongTermBytes;
    }
    if (numRows != null) {
      _json["numRows"] = numRows;
    }
    if (schema != null) {
      _json["schema"] = (schema).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (streamingBuffer != null) {
      _json["streamingBuffer"] = (streamingBuffer).toJson();
    }
    if (tableReference != null) {
      _json["tableReference"] = (tableReference).toJson();
    }
    if (timePartitioning != null) {
      _json["timePartitioning"] = (timePartitioning).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (view != null) {
      _json["view"] = (view).toJson();
    }
    return _json;
  }
}

class TableCell {
  /**
   *
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Object v;

  TableCell();

  TableCell.fromJson(core.Map _json) {
    if (_json.containsKey("v")) {
      v = _json["v"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (v != null) {
      _json["v"] = v;
    }
    return _json;
  }
}

class TableDataInsertAllRequestRows {
  /**
   * [Optional] A unique ID for each row. BigQuery uses this property to detect
   * duplicate insertion requests on a best-effort basis.
   */
  core.String insertId;
  /**
   * [Required] A JSON object that contains a row of data. The object's
   * properties and values must match the destination table's schema.
   */
  JsonObject json;

  TableDataInsertAllRequestRows();

  TableDataInsertAllRequestRows.fromJson(core.Map _json) {
    if (_json.containsKey("insertId")) {
      insertId = _json["insertId"];
    }
    if (_json.containsKey("json")) {
      json = new JsonObject.fromJson(_json["json"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (insertId != null) {
      _json["insertId"] = insertId;
    }
    if (json != null) {
      _json["json"] = json;
    }
    return _json;
  }
}

class TableDataInsertAllRequest {
  /**
   * [Optional] Accept rows that contain values that do not match the schema.
   * The unknown values are ignored. Default is false, which treats unknown
   * values as errors.
   */
  core.bool ignoreUnknownValues;
  /** The resource type of the response. */
  core.String kind;
  /** The rows to insert. */
  core.List<TableDataInsertAllRequestRows> rows;
  /**
   * [Optional] Insert all valid rows of a request, even if invalid rows exist.
   * The default value is false, which causes the entire request to fail if any
   * invalid rows exist.
   */
  core.bool skipInvalidRows;
  /**
   * [Experimental] If specified, treats the destination table as a base
   * template, and inserts the rows into an instance table named
   * "{destination}{templateSuffix}". BigQuery will manage creation of the
   * instance table, using the schema of the base template table. See
   * https://cloud.google.com/bigquery/streaming-data-into-bigquery#template-tables
   * for considerations when working with templates tables.
   */
  core.String templateSuffix;

  TableDataInsertAllRequest();

  TableDataInsertAllRequest.fromJson(core.Map _json) {
    if (_json.containsKey("ignoreUnknownValues")) {
      ignoreUnknownValues = _json["ignoreUnknownValues"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"].map((value) => new TableDataInsertAllRequestRows.fromJson(value)).toList();
    }
    if (_json.containsKey("skipInvalidRows")) {
      skipInvalidRows = _json["skipInvalidRows"];
    }
    if (_json.containsKey("templateSuffix")) {
      templateSuffix = _json["templateSuffix"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (ignoreUnknownValues != null) {
      _json["ignoreUnknownValues"] = ignoreUnknownValues;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (rows != null) {
      _json["rows"] = rows.map((value) => (value).toJson()).toList();
    }
    if (skipInvalidRows != null) {
      _json["skipInvalidRows"] = skipInvalidRows;
    }
    if (templateSuffix != null) {
      _json["templateSuffix"] = templateSuffix;
    }
    return _json;
  }
}

class TableDataInsertAllResponseInsertErrors {
  /** Error information for the row indicated by the index property. */
  core.List<ErrorProto> errors;
  /** The index of the row that error applies to. */
  core.int index;

  TableDataInsertAllResponseInsertErrors();

  TableDataInsertAllResponseInsertErrors.fromJson(core.Map _json) {
    if (_json.containsKey("errors")) {
      errors = _json["errors"].map((value) => new ErrorProto.fromJson(value)).toList();
    }
    if (_json.containsKey("index")) {
      index = _json["index"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    if (index != null) {
      _json["index"] = index;
    }
    return _json;
  }
}

class TableDataInsertAllResponse {
  /** An array of errors for rows that were not inserted. */
  core.List<TableDataInsertAllResponseInsertErrors> insertErrors;
  /** The resource type of the response. */
  core.String kind;

  TableDataInsertAllResponse();

  TableDataInsertAllResponse.fromJson(core.Map _json) {
    if (_json.containsKey("insertErrors")) {
      insertErrors = _json["insertErrors"].map((value) => new TableDataInsertAllResponseInsertErrors.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (insertErrors != null) {
      _json["insertErrors"] = insertErrors.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class TableDataList {
  /** A hash of this page of results. */
  core.String etag;
  /** The resource type of the response. */
  core.String kind;
  /**
   * A token used for paging results. Providing this token instead of the
   * startIndex parameter can help you retrieve stable results when an
   * underlying table is changing.
   */
  core.String pageToken;
  /** Rows of results. */
  core.List<TableRow> rows;
  /** The total number of rows in the complete table. */
  core.String totalRows;

  TableDataList();

  TableDataList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"].map((value) => new TableRow.fromJson(value)).toList();
    }
    if (_json.containsKey("totalRows")) {
      totalRows = _json["totalRows"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    if (rows != null) {
      _json["rows"] = rows.map((value) => (value).toJson()).toList();
    }
    if (totalRows != null) {
      _json["totalRows"] = totalRows;
    }
    return _json;
  }
}

class TableFieldSchema {
  /**
   * [Optional] The field description. The maximum length is 16K characters.
   */
  core.String description;
  /**
   * [Optional] Describes the nested schema fields if the type property is set
   * to RECORD.
   */
  core.List<TableFieldSchema> fields;
  /**
   * [Optional] The field mode. Possible values include NULLABLE, REQUIRED and
   * REPEATED. The default value is NULLABLE.
   */
  core.String mode;
  /**
   * [Required] The field name. The name must contain only letters (a-z, A-Z),
   * numbers (0-9), or underscores (_), and must start with a letter or
   * underscore. The maximum length is 128 characters.
   */
  core.String name;
  /**
   * [Required] The field data type. Possible values include STRING, BYTES,
   * INTEGER, INT64 (same as INTEGER), FLOAT, FLOAT64 (same as FLOAT), BOOLEAN,
   * BOOL (same as BOOLEAN), TIMESTAMP, DATE, TIME, DATETIME, RECORD (where
   * RECORD indicates that the field contains a nested schema) or STRUCT (same
   * as RECORD).
   */
  core.String type;

  TableFieldSchema();

  TableFieldSchema.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("fields")) {
      fields = _json["fields"].map((value) => new TableFieldSchema.fromJson(value)).toList();
    }
    if (_json.containsKey("mode")) {
      mode = _json["mode"];
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
    if (fields != null) {
      _json["fields"] = fields.map((value) => (value).toJson()).toList();
    }
    if (mode != null) {
      _json["mode"] = mode;
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

/** Additional details for a view. */
class TableListTablesView {
  /**
   * True if view is defined in legacy SQL dialect, false if in standard SQL.
   */
  core.bool useLegacySql;

  TableListTablesView();

  TableListTablesView.fromJson(core.Map _json) {
    if (_json.containsKey("useLegacySql")) {
      useLegacySql = _json["useLegacySql"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (useLegacySql != null) {
      _json["useLegacySql"] = useLegacySql;
    }
    return _json;
  }
}

class TableListTables {
  /** The user-friendly name for this table. */
  core.String friendlyName;
  /** An opaque ID of the table */
  core.String id;
  /** The resource type. */
  core.String kind;
  /**
   * [Experimental] The labels associated with this table. You can use these to
   * organize and group your tables.
   */
  core.Map<core.String, core.String> labels;
  /** A reference uniquely identifying the table. */
  TableReference tableReference;
  /** The type of table. Possible values are: TABLE, VIEW. */
  core.String type;
  /** Additional details for a view. */
  TableListTablesView view;

  TableListTables();

  TableListTables.fromJson(core.Map _json) {
    if (_json.containsKey("friendlyName")) {
      friendlyName = _json["friendlyName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("tableReference")) {
      tableReference = new TableReference.fromJson(_json["tableReference"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("view")) {
      view = new TableListTablesView.fromJson(_json["view"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (friendlyName != null) {
      _json["friendlyName"] = friendlyName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (tableReference != null) {
      _json["tableReference"] = (tableReference).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (view != null) {
      _json["view"] = (view).toJson();
    }
    return _json;
  }
}

class TableList {
  /** A hash of this page of results. */
  core.String etag;
  /** The type of list. */
  core.String kind;
  /** A token to request the next page of results. */
  core.String nextPageToken;
  /** Tables in the requested dataset. */
  core.List<TableListTables> tables;
  /** The total number of tables in the dataset. */
  core.int totalItems;

  TableList();

  TableList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("tables")) {
      tables = _json["tables"].map((value) => new TableListTables.fromJson(value)).toList();
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (tables != null) {
      _json["tables"] = tables.map((value) => (value).toJson()).toList();
    }
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

class TableReference {
  /** [Required] The ID of the dataset containing this table. */
  core.String datasetId;
  /** [Required] The ID of the project containing this table. */
  core.String projectId;
  /**
   * [Required] The ID of the table. The ID must contain only letters (a-z,
   * A-Z), numbers (0-9), or underscores (_). The maximum length is 1,024
   * characters.
   */
  core.String tableId;

  TableReference();

  TableReference.fromJson(core.Map _json) {
    if (_json.containsKey("datasetId")) {
      datasetId = _json["datasetId"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("tableId")) {
      tableId = _json["tableId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasetId != null) {
      _json["datasetId"] = datasetId;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (tableId != null) {
      _json["tableId"] = tableId;
    }
    return _json;
  }
}

class TableRow {
  /**
   * Represents a single row in the result set, consisting of one or more
   * fields.
   */
  core.List<TableCell> f;

  TableRow();

  TableRow.fromJson(core.Map _json) {
    if (_json.containsKey("f")) {
      f = _json["f"].map((value) => new TableCell.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (f != null) {
      _json["f"] = f.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class TableSchema {
  /** Describes the fields in a table. */
  core.List<TableFieldSchema> fields;

  TableSchema();

  TableSchema.fromJson(core.Map _json) {
    if (_json.containsKey("fields")) {
      fields = _json["fields"].map((value) => new TableFieldSchema.fromJson(value)).toList();
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

class TimePartitioning {
  /**
   * [Optional] Number of milliseconds for which to keep the storage for a
   * partition.
   */
  core.String expirationMs;
  /**
   * [Required] The only type supported is DAY, which will generate one
   * partition per day based on data loading time.
   */
  core.String type;

  TimePartitioning();

  TimePartitioning.fromJson(core.Map _json) {
    if (_json.containsKey("expirationMs")) {
      expirationMs = _json["expirationMs"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (expirationMs != null) {
      _json["expirationMs"] = expirationMs;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class UserDefinedFunctionResource {
  /**
   * [Pick one] An inline resource that contains code for a user-defined
   * function (UDF). Providing a inline code resource is equivalent to providing
   * a URI for a file containing the same code.
   */
  core.String inlineCode;
  /**
   * [Pick one] A code resource to load from a Google Cloud Storage URI
   * (gs://bucket/path).
   */
  core.String resourceUri;

  UserDefinedFunctionResource();

  UserDefinedFunctionResource.fromJson(core.Map _json) {
    if (_json.containsKey("inlineCode")) {
      inlineCode = _json["inlineCode"];
    }
    if (_json.containsKey("resourceUri")) {
      resourceUri = _json["resourceUri"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (inlineCode != null) {
      _json["inlineCode"] = inlineCode;
    }
    if (resourceUri != null) {
      _json["resourceUri"] = resourceUri;
    }
    return _json;
  }
}

class ViewDefinition {
  /** [Required] A query that BigQuery executes when the view is referenced. */
  core.String query;
  /**
   * Specifies whether to use BigQuery's legacy SQL for this view. The default
   * value is true. If set to false, the view will use BigQuery's standard SQL:
   * https://cloud.google.com/bigquery/sql-reference/ Queries and views that
   * reference this view must use the same flag value.
   */
  core.bool useLegacySql;
  /**
   * [Experimental] Describes user-defined function resources used in the query.
   */
  core.List<UserDefinedFunctionResource> userDefinedFunctionResources;

  ViewDefinition();

  ViewDefinition.fromJson(core.Map _json) {
    if (_json.containsKey("query")) {
      query = _json["query"];
    }
    if (_json.containsKey("useLegacySql")) {
      useLegacySql = _json["useLegacySql"];
    }
    if (_json.containsKey("userDefinedFunctionResources")) {
      userDefinedFunctionResources = _json["userDefinedFunctionResources"].map((value) => new UserDefinedFunctionResource.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (query != null) {
      _json["query"] = query;
    }
    if (useLegacySql != null) {
      _json["useLegacySql"] = useLegacySql;
    }
    if (userDefinedFunctionResources != null) {
      _json["userDefinedFunctionResources"] = userDefinedFunctionResources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
