// This is a generated file (see the discoveryapis_generator project).

library googleapis.youtubereporting.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client youtubereporting/v1';

/**
 * Schedules reporting jobs containing your YouTube Analytics data and downloads
 * the resulting bulk data reports in the form of CSV files.
 */
class YoutubereportingApi {
  /**
   * View monetary and non-monetary YouTube Analytics reports for your YouTube
   * content
   */
  static const YtAnalyticsMonetaryReadonlyScope = "https://www.googleapis.com/auth/yt-analytics-monetary.readonly";

  /** View YouTube Analytics reports for your YouTube content */
  static const YtAnalyticsReadonlyScope = "https://www.googleapis.com/auth/yt-analytics.readonly";


  final commons.ApiRequester _requester;

  JobsResourceApi get jobs => new JobsResourceApi(_requester);
  MediaResourceApi get media => new MediaResourceApi(_requester);
  ReportTypesResourceApi get reportTypes => new ReportTypesResourceApi(_requester);

  YoutubereportingApi(http.Client client, {core.String rootUrl: "https://youtubereporting.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class JobsResourceApi {
  final commons.ApiRequester _requester;

  JobsReportsResourceApi get reports => new JobsReportsResourceApi(_requester);

  JobsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a job and returns it.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [onBehalfOfContentOwner] - The content owner's external ID on which behalf
   * the user is acting on. If
   * not set, the user is acting for himself (his own channel).
   *
   * Completes with a [Job].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Job> create(Job request, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'v1/jobs';

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
   * Deletes a job.
   *
   * Request parameters:
   *
   * [jobId] - The ID of the job to delete.
   *
   * [onBehalfOfContentOwner] - The content owner's external ID on which behalf
   * the user is acting on. If
   * not set, the user is acting for himself (his own channel).
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String jobId, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'v1/jobs/' + commons.Escaper.ecapeVariable('$jobId');

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
   * Gets a job.
   *
   * Request parameters:
   *
   * [jobId] - The ID of the job to retrieve.
   *
   * [onBehalfOfContentOwner] - The content owner's external ID on which behalf
   * the user is acting on. If
   * not set, the user is acting for himself (his own channel).
   *
   * Completes with a [Job].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Job> get(core.String jobId, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'v1/jobs/' + commons.Escaper.ecapeVariable('$jobId');

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
   * Lists jobs.
   *
   * Request parameters:
   *
   * [pageToken] - A token identifying a page of results the server should
   * return. Typically,
   * this is the value of
   * ListReportTypesResponse.next_page_token
   * returned in response to the previous call to the `ListJobs` method.
   *
   * [includeSystemManaged] - If set to true, also system-managed jobs will be
   * returned; otherwise only
   * user-created jobs will be returned. System-managed jobs can neither be
   * modified nor deleted.
   *
   * [pageSize] - Requested page size. Server may return fewer jobs than
   * requested.
   * If unspecified, server will pick an appropriate default.
   *
   * [onBehalfOfContentOwner] - The content owner's external ID on which behalf
   * the user is acting on. If
   * not set, the user is acting for himself (his own channel).
   *
   * Completes with a [ListJobsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListJobsResponse> list({core.String pageToken, core.bool includeSystemManaged, core.int pageSize, core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (includeSystemManaged != null) {
      _queryParams["includeSystemManaged"] = ["${includeSystemManaged}"];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'v1/jobs';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListJobsResponse.fromJson(data));
  }

}


class JobsReportsResourceApi {
  final commons.ApiRequester _requester;

  JobsReportsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the metadata of a specific report.
   *
   * Request parameters:
   *
   * [jobId] - The ID of the job.
   *
   * [reportId] - The ID of the report to retrieve.
   *
   * [onBehalfOfContentOwner] - The content owner's external ID on which behalf
   * the user is acting on. If
   * not set, the user is acting for himself (his own channel).
   *
   * Completes with a [Report].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Report> get(core.String jobId, core.String reportId, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }
    if (reportId == null) {
      throw new core.ArgumentError("Parameter reportId is required.");
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'v1/jobs/' + commons.Escaper.ecapeVariable('$jobId') + '/reports/' + commons.Escaper.ecapeVariable('$reportId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Report.fromJson(data));
  }

  /**
   * Lists reports created by a specific job.
   * Returns NOT_FOUND if the job does not exist.
   *
   * Request parameters:
   *
   * [jobId] - The ID of the job.
   *
   * [onBehalfOfContentOwner] - The content owner's external ID on which behalf
   * the user is acting on. If
   * not set, the user is acting for himself (his own channel).
   *
   * [startTimeBefore] - If set, only reports whose start time is smaller than
   * the specified
   * date/time are returned.
   *
   * [createdAfter] - If set, only reports created after the specified date/time
   * are returned.
   *
   * [startTimeAtOrAfter] - If set, only reports whose start time is greater
   * than or equal the
   * specified date/time are returned.
   *
   * [pageToken] - A token identifying a page of results the server should
   * return. Typically,
   * this is the value of
   * ListReportsResponse.next_page_token
   * returned in response to the previous call to the `ListReports` method.
   *
   * [pageSize] - Requested page size. Server may return fewer report types than
   * requested.
   * If unspecified, server will pick an appropriate default.
   *
   * Completes with a [ListReportsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListReportsResponse> list(core.String jobId, {core.String onBehalfOfContentOwner, core.String startTimeBefore, core.String createdAfter, core.String startTimeAtOrAfter, core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (jobId == null) {
      throw new core.ArgumentError("Parameter jobId is required.");
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (startTimeBefore != null) {
      _queryParams["startTimeBefore"] = [startTimeBefore];
    }
    if (createdAfter != null) {
      _queryParams["createdAfter"] = [createdAfter];
    }
    if (startTimeAtOrAfter != null) {
      _queryParams["startTimeAtOrAfter"] = [startTimeAtOrAfter];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1/jobs/' + commons.Escaper.ecapeVariable('$jobId') + '/reports';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListReportsResponse.fromJson(data));
  }

}


class MediaResourceApi {
  final commons.ApiRequester _requester;

  MediaResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Method for media download. Download is supported
   * on the URI `/v1/media/{+name}?alt=media`.
   *
   * Request parameters:
   *
   * [resourceName] - Name of the media that is being downloaded.  See
   * ReadRequest.resource_name.
   * Value must have pattern "^.+$".
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [Media] for Metadata downloads (see [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future download(core.String resourceName, {commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (resourceName == null) {
      throw new core.ArgumentError("Parameter resourceName is required.");
    }

    _downloadOptions = downloadOptions;

    _url = 'v1/media/' + commons.Escaper.ecapeVariableReserved('$resourceName');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new Media.fromJson(data));
    } else {
      return _response;
    }
  }

}


class ReportTypesResourceApi {
  final commons.ApiRequester _requester;

  ReportTypesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists report types.
   *
   * Request parameters:
   *
   * [onBehalfOfContentOwner] - The content owner's external ID on which behalf
   * the user is acting on. If
   * not set, the user is acting for himself (his own channel).
   *
   * [pageToken] - A token identifying a page of results the server should
   * return. Typically,
   * this is the value of
   * ListReportTypesResponse.next_page_token
   * returned in response to the previous call to the `ListReportTypes` method.
   *
   * [includeSystemManaged] - If set to true, also system-managed report types
   * will be returned;
   * otherwise only the report types that can be used to create new reporting
   * jobs will be returned.
   *
   * [pageSize] - Requested page size. Server may return fewer report types than
   * requested.
   * If unspecified, server will pick an appropriate default.
   *
   * Completes with a [ListReportTypesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListReportTypesResponse> list({core.String onBehalfOfContentOwner, core.String pageToken, core.bool includeSystemManaged, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (includeSystemManaged != null) {
      _queryParams["includeSystemManaged"] = ["${includeSystemManaged}"];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1/reportTypes';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListReportTypesResponse.fromJson(data));
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

/** A job creating reports of a specific type. */
class Job {
  /** The creation date/time of the job. */
  core.String createTime;
  /**
   * The date/time when this job will expire/expired. After a job expired, no
   * new reports are generated.
   */
  core.String expireTime;
  /** The server-generated ID of the job (max. 40 characters). */
  core.String id;
  /** The name of the job (max. 100 characters). */
  core.String name;
  /**
   * The type of reports this job creates. Corresponds to the ID of a
   * ReportType.
   */
  core.String reportTypeId;
  /**
   * True if this a system-managed job that cannot be modified by the user;
   * otherwise false.
   */
  core.bool systemManaged;

  Job();

  Job.fromJson(core.Map _json) {
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("expireTime")) {
      expireTime = _json["expireTime"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("reportTypeId")) {
      reportTypeId = _json["reportTypeId"];
    }
    if (_json.containsKey("systemManaged")) {
      systemManaged = _json["systemManaged"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (expireTime != null) {
      _json["expireTime"] = expireTime;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (reportTypeId != null) {
      _json["reportTypeId"] = reportTypeId;
    }
    if (systemManaged != null) {
      _json["systemManaged"] = systemManaged;
    }
    return _json;
  }
}

/** Response message for ReportingService.ListJobs. */
class ListJobsResponse {
  /** The list of jobs. */
  core.List<Job> jobs;
  /**
   * A token to retrieve next page of results.
   * Pass this value in the
   * ListJobsRequest.page_token
   * field in the subsequent call to `ListJobs` method to retrieve the next
   * page of results.
   */
  core.String nextPageToken;

  ListJobsResponse();

  ListJobsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("jobs")) {
      jobs = _json["jobs"].map((value) => new Job.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (jobs != null) {
      _json["jobs"] = jobs.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Response message for ReportingService.ListReportTypes. */
class ListReportTypesResponse {
  /**
   * A token to retrieve next page of results.
   * Pass this value in the
   * ListReportTypesRequest.page_token
   * field in the subsequent call to `ListReportTypes` method to retrieve the
   * next
   * page of results.
   */
  core.String nextPageToken;
  /** The list of report types. */
  core.List<ReportType> reportTypes;

  ListReportTypesResponse();

  ListReportTypesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("reportTypes")) {
      reportTypes = _json["reportTypes"].map((value) => new ReportType.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (reportTypes != null) {
      _json["reportTypes"] = reportTypes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Response message for ReportingService.ListReports. */
class ListReportsResponse {
  /**
   * A token to retrieve next page of results.
   * Pass this value in the
   * ListReportsRequest.page_token
   * field in the subsequent call to `ListReports` method to retrieve the next
   * page of results.
   */
  core.String nextPageToken;
  /** The list of report types. */
  core.List<Report> reports;

  ListReportsResponse();

  ListReportsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("reports")) {
      reports = _json["reports"].map((value) => new Report.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (reports != null) {
      _json["reports"] = reports.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Media resource. */
class Media {
  /** Name of the media resource. */
  core.String resourceName;

  Media();

  Media.fromJson(core.Map _json) {
    if (_json.containsKey("resourceName")) {
      resourceName = _json["resourceName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (resourceName != null) {
      _json["resourceName"] = resourceName;
    }
    return _json;
  }
}

/**
 * A report's metadata including the URL from which the report itself can be
 * downloaded.
 */
class Report {
  /** The date/time when this report was created. */
  core.String createTime;
  /**
   * The URL from which the report can be downloaded (max. 1000 characters).
   */
  core.String downloadUrl;
  /**
   * The end of the time period that the report instance covers. The value is
   * exclusive.
   */
  core.String endTime;
  /** The server-generated ID of the report. */
  core.String id;
  /** The date/time when the job this report belongs to will expire/expired. */
  core.String jobExpireTime;
  /** The ID of the job that created this report. */
  core.String jobId;
  /**
   * The start of the time period that the report instance covers. The value is
   * inclusive.
   */
  core.String startTime;

  Report();

  Report.fromJson(core.Map _json) {
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("downloadUrl")) {
      downloadUrl = _json["downloadUrl"];
    }
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("jobExpireTime")) {
      jobExpireTime = _json["jobExpireTime"];
    }
    if (_json.containsKey("jobId")) {
      jobId = _json["jobId"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (downloadUrl != null) {
      _json["downloadUrl"] = downloadUrl;
    }
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (jobExpireTime != null) {
      _json["jobExpireTime"] = jobExpireTime;
    }
    if (jobId != null) {
      _json["jobId"] = jobId;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

/** A report type. */
class ReportType {
  /** The date/time when this report type was/will be deprecated. */
  core.String deprecateTime;
  /** The ID of the report type (max. 100 characters). */
  core.String id;
  /** The name of the report type (max. 100 characters). */
  core.String name;
  /**
   * True if this a system-managed report type; otherwise false. Reporting jobs
   * for system-managed report types are created automatically and can thus not
   * be used in the `CreateJob` method.
   */
  core.bool systemManaged;

  ReportType();

  ReportType.fromJson(core.Map _json) {
    if (_json.containsKey("deprecateTime")) {
      deprecateTime = _json["deprecateTime"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("systemManaged")) {
      systemManaged = _json["systemManaged"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deprecateTime != null) {
      _json["deprecateTime"] = deprecateTime;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (systemManaged != null) {
      _json["systemManaged"] = systemManaged;
    }
    return _json;
  }
}
