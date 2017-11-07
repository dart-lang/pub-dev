// This is a generated file (see the discoveryapis_generator project).

library googleapis.storagetransfer.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client storagetransfer/v1';

/**
 * Transfers data from external data sources to a Google Cloud Storage bucket or
 * between Google Cloud Storage buckets.
 */
class StoragetransferApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";


  final commons.ApiRequester _requester;

  GoogleServiceAccountsResourceApi get googleServiceAccounts => new GoogleServiceAccountsResourceApi(_requester);
  TransferJobsResourceApi get transferJobs => new TransferJobsResourceApi(_requester);
  TransferOperationsResourceApi get transferOperations => new TransferOperationsResourceApi(_requester);
  V1ResourceApi get v1 => new V1ResourceApi(_requester);

  StoragetransferApi(http.Client client, {core.String rootUrl: "https://storagetransfer.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class GoogleServiceAccountsResourceApi {
  final commons.ApiRequester _requester;

  GoogleServiceAccountsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns the Google service account that is used by Storage Transfer Service
   * to access buckets in the project where transfers run or in other projects.
   * Each Google service account is associated with one Google Developers
   * Console project. Users should add this service account to the Google Cloud
   * Storage bucket ACLs to grant access to Storage Transfer Service. This
   * service account is created and owned by Storage Transfer Service and can
   * only be used by Storage Transfer Service.
   *
   * Request parameters:
   *
   * [projectId] - The ID of the Google Developers Console project that the
   * Google service account is associated with. Required.
   *
   * Completes with a [GoogleServiceAccount].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GoogleServiceAccount> get(core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = 'v1/googleServiceAccounts/' + commons.Escaper.ecapeVariable('$projectId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GoogleServiceAccount.fromJson(data));
  }

}


class TransferJobsResourceApi {
  final commons.ApiRequester _requester;

  TransferJobsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a transfer job that runs periodically.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [TransferJob].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TransferJob> create(TransferJob request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/transferJobs';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TransferJob.fromJson(data));
  }

  /**
   * Gets a transfer job.
   *
   * Request parameters:
   *
   * [jobName] - The job to get. Required.
   * Value must have pattern "^transferJobs/.*$".
   *
   * [projectId] - The ID of the Google Developers Console project that owns the
   * job. Required.
   *
   * Completes with a [TransferJob].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TransferJob> get(core.String jobName, {core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (jobName == null) {
      throw new core.ArgumentError("Parameter jobName is required.");
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$jobName');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TransferJob.fromJson(data));
  }

  /**
   * Lists transfer jobs.
   *
   * Request parameters:
   *
   * [filter] - A list of query parameters specified as JSON text in the form of
   * {"`project_id`":"my_project_id", "`job_names`":["jobid1","jobid2",...],
   * "`job_statuses`":["status1","status2",...]}. Since `job_names` and
   * `job_statuses` support multiple values, their values must be specified with
   * array notation. `project_id` is required. `job_names` and `job_statuses`
   * are optional. The valid values for `job_statuses` are case-insensitive:
   * `ENABLED`, `DISABLED`, and `DELETED`.
   *
   * [pageSize] - The list page size. The max allowed value is 256.
   *
   * [pageToken] - The list page token.
   *
   * Completes with a [ListTransferJobsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListTransferJobsResponse> list({core.String filter, core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v1/transferJobs';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListTransferJobsResponse.fromJson(data));
  }

  /**
   * Updates a transfer job. Updating a job's transfer spec does not affect
   * transfer operations that are running already. Updating the scheduling of a
   * job is not allowed.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [jobName] - The name of job to update. Required.
   * Value must have pattern "^transferJobs/.*$".
   *
   * Completes with a [TransferJob].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TransferJob> patch(UpdateTransferJobRequest request, core.String jobName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (jobName == null) {
      throw new core.ArgumentError("Parameter jobName is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$jobName');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TransferJob.fromJson(data));
  }

}


class TransferOperationsResourceApi {
  final commons.ApiRequester _requester;

  TransferOperationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Cancels a transfer. Use the get method to check whether the cancellation
   * succeeded or whether the operation completed despite cancellation.
   *
   * Request parameters:
   *
   * [name] - The name of the operation resource to be cancelled.
   * Value must have pattern "^transferOperations/.*$".
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
   * This method is not supported and the server returns `UNIMPLEMENTED`.
   *
   * Request parameters:
   *
   * [name] - The name of the operation resource to be deleted.
   * Value must have pattern "^transferOperations/.*$".
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
   * Gets the latest state of a long-running operation. Clients can use this
   * method to poll the operation result at intervals as recommended by the API
   * service.
   *
   * Request parameters:
   *
   * [name] - The name of the operation resource.
   * Value must have pattern "^transferOperations/.*$".
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
   * server doesn't support this method, it returns `UNIMPLEMENTED`. NOTE: the
   * `name` binding below allows API services to override the binding to use
   * different resource name schemes, such as `users / * /operations`.
   *
   * Request parameters:
   *
   * [name] - The value `transferOperations`.
   * Value must have pattern "^transferOperations$".
   *
   * [filter] - The standard list filter.
   *
   * [pageSize] - The standard list page size.
   *
   * [pageToken] - The standard list page token.
   *
   * Completes with a [ListOperationsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListOperationsResponse> list(core.String name, {core.String filter, core.int pageSize, core.String pageToken}) {
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
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
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

  /**
   * Pauses a transfer operation.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - The name of the transfer operation. Required.
   * Value must have pattern "^transferOperations/.*$".
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> pause(PauseTransferOperationRequest request, core.String name) {
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

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + ':pause';

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
   * Resumes a transfer operation that is paused.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - The name of the transfer operation. Required.
   * Value must have pattern "^transferOperations/.*$".
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> resume(ResumeTransferOperationRequest request, core.String name) {
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

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + ':resume';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

}


class V1ResourceApi {
  final commons.ApiRequester _requester;

  V1ResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns the Google service account that is used by Storage Transfer Service
   * to access buckets in the project where transfers run or in other projects.
   * Each Google service account is associated with one Google Developers
   * Console project. Users should add this service account to the Google Cloud
   * Storage bucket ACLs to grant access to Storage Transfer Service. This
   * service account is created and owned by Storage Transfer Service and can
   * only be used by Storage Transfer Service.
   *
   * Request parameters:
   *
   * [projectId] - The ID of the Google Developers Console project that the
   * Google service account is associated with. Required.
   *
   * Completes with a [GoogleServiceAccount].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GoogleServiceAccount> getGoogleServiceAccount({core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1:getGoogleServiceAccount';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GoogleServiceAccount.fromJson(data));
  }

}



/**
 * AWS access key (see [AWS Security
 * Credentials](http://docs.aws.amazon.com/general/latest/gr/aws-security-credentials.html)).
 */
class AwsAccessKey {
  /** AWS access key ID. Required. */
  core.String accessKeyId;
  /**
   * AWS secret access key. This field is not returned in RPC responses.
   * Required.
   */
  core.String secretAccessKey;

  AwsAccessKey();

  AwsAccessKey.fromJson(core.Map _json) {
    if (_json.containsKey("accessKeyId")) {
      accessKeyId = _json["accessKeyId"];
    }
    if (_json.containsKey("secretAccessKey")) {
      secretAccessKey = _json["secretAccessKey"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accessKeyId != null) {
      _json["accessKeyId"] = accessKeyId;
    }
    if (secretAccessKey != null) {
      _json["secretAccessKey"] = secretAccessKey;
    }
    return _json;
  }
}

/**
 * An AwsS3Data can be a data source, but not a data sink. In an AwsS3Data, an
 * object's name is the S3 object's key name.
 */
class AwsS3Data {
  /**
   * AWS access key used to sign the API requests to the AWS S3 bucket.
   * Permissions on the bucket must be granted to the access ID of the AWS
   * access key. Required.
   */
  AwsAccessKey awsAccessKey;
  /**
   * S3 Bucket name (see [Creating a
   * bucket](http://docs.aws.amazon.com/AmazonS3/latest/dev/create-bucket-get-location-example.html)).
   * Required.
   */
  core.String bucketName;

  AwsS3Data();

  AwsS3Data.fromJson(core.Map _json) {
    if (_json.containsKey("awsAccessKey")) {
      awsAccessKey = new AwsAccessKey.fromJson(_json["awsAccessKey"]);
    }
    if (_json.containsKey("bucketName")) {
      bucketName = _json["bucketName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (awsAccessKey != null) {
      _json["awsAccessKey"] = (awsAccessKey).toJson();
    }
    if (bucketName != null) {
      _json["bucketName"] = bucketName;
    }
    return _json;
  }
}

/**
 * Represents a whole calendar date, e.g. date of birth. The time of day and
 * time zone are either specified elsewhere or are not significant. The date is
 * relative to the Proleptic Gregorian Calendar. The day may be 0 to represent a
 * year and month where the day is not significant, e.g. credit card expiration
 * date. The year may be 0 to represent a month and day independent of year,
 * e.g. anniversary date. Related types are
 * [google.type.TimeOfDay][google.type.TimeOfDay] and
 * `google.protobuf.Timestamp`.
 */
class Date {
  /**
   * Day of month. Must be from 1 to 31 and valid for the year and month, or 0
   * if specifying a year/month where the day is not sigificant.
   */
  core.int day;
  /** Month of year of date. Must be from 1 to 12. */
  core.int month;
  /**
   * Year of date. Must be from 1 to 9,999, or 0 if specifying a date without a
   * year.
   */
  core.int year;

  Date();

  Date.fromJson(core.Map _json) {
    if (_json.containsKey("day")) {
      day = _json["day"];
    }
    if (_json.containsKey("month")) {
      month = _json["month"];
    }
    if (_json.containsKey("year")) {
      year = _json["year"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (day != null) {
      _json["day"] = day;
    }
    if (month != null) {
      _json["month"] = month;
    }
    if (year != null) {
      _json["year"] = year;
    }
    return _json;
  }
}

/**
 * A generic empty message that you can re-use to avoid defining duplicated
 * empty messages in your APIs. A typical example is to use it as the request or
 * the response type of an API method. For instance: service Foo { rpc
 * Bar(google.protobuf.Empty) returns (google.protobuf.Empty); } The JSON
 * representation for `Empty` is empty JSON object `{}`.
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

/** An entry describing an error that has occurred. */
class ErrorLogEntry {
  /** A list of messages that carry the error details. */
  core.List<core.String> errorDetails;
  /**
   * A URL that refers to the target (a data source, a data sink, or an object)
   * with which the error is associated. Required.
   */
  core.String url;

  ErrorLogEntry();

  ErrorLogEntry.fromJson(core.Map _json) {
    if (_json.containsKey("errorDetails")) {
      errorDetails = _json["errorDetails"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (errorDetails != null) {
      _json["errorDetails"] = errorDetails;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/**
 * A summary of errors by error code, plus a count and sample error log entries.
 */
class ErrorSummary {
  /**
   * Required.
   * Possible string values are:
   * - "OK" : A OK.
   * - "CANCELLED" : A CANCELLED.
   * - "UNKNOWN" : A UNKNOWN.
   * - "INVALID_ARGUMENT" : A INVALID_ARGUMENT.
   * - "DEADLINE_EXCEEDED" : A DEADLINE_EXCEEDED.
   * - "NOT_FOUND" : A NOT_FOUND.
   * - "ALREADY_EXISTS" : A ALREADY_EXISTS.
   * - "PERMISSION_DENIED" : A PERMISSION_DENIED.
   * - "UNAUTHENTICATED" : A UNAUTHENTICATED.
   * - "RESOURCE_EXHAUSTED" : A RESOURCE_EXHAUSTED.
   * - "FAILED_PRECONDITION" : A FAILED_PRECONDITION.
   * - "ABORTED" : A ABORTED.
   * - "OUT_OF_RANGE" : A OUT_OF_RANGE.
   * - "UNIMPLEMENTED" : A UNIMPLEMENTED.
   * - "INTERNAL" : A INTERNAL.
   * - "UNAVAILABLE" : A UNAVAILABLE.
   * - "DATA_LOSS" : A DATA_LOSS.
   */
  core.String errorCode;
  /** Count of this type of error. Required. */
  core.String errorCount;
  /** Error samples. */
  core.List<ErrorLogEntry> errorLogEntries;

  ErrorSummary();

  ErrorSummary.fromJson(core.Map _json) {
    if (_json.containsKey("errorCode")) {
      errorCode = _json["errorCode"];
    }
    if (_json.containsKey("errorCount")) {
      errorCount = _json["errorCount"];
    }
    if (_json.containsKey("errorLogEntries")) {
      errorLogEntries = _json["errorLogEntries"].map((value) => new ErrorLogEntry.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (errorCode != null) {
      _json["errorCode"] = errorCode;
    }
    if (errorCount != null) {
      _json["errorCount"] = errorCount;
    }
    if (errorLogEntries != null) {
      _json["errorLogEntries"] = errorLogEntries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * In a GcsData, an object's name is the Google Cloud Storage object's name and
 * its `lastModificationTime` refers to the object's updated time, which changes
 * when the content or the metadata of the object is updated.
 */
class GcsData {
  /**
   * Google Cloud Storage bucket name (see [Bucket Name
   * Requirements](https://cloud.google.com/storage/docs/bucket-naming#requirements)).
   * Required.
   */
  core.String bucketName;

  GcsData();

  GcsData.fromJson(core.Map _json) {
    if (_json.containsKey("bucketName")) {
      bucketName = _json["bucketName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bucketName != null) {
      _json["bucketName"] = bucketName;
    }
    return _json;
  }
}

/** Google service account */
class GoogleServiceAccount {
  /** Required. */
  core.String accountEmail;

  GoogleServiceAccount();

  GoogleServiceAccount.fromJson(core.Map _json) {
    if (_json.containsKey("accountEmail")) {
      accountEmail = _json["accountEmail"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountEmail != null) {
      _json["accountEmail"] = accountEmail;
    }
    return _json;
  }
}

/**
 * An HttpData specifies a list of objects on the web to be transferred over
 * HTTP. The information of the objects to be transferred is contained in a file
 * referenced by a URL. The first line in the file must be "TsvHttpData-1.0",
 * which specifies the format of the file. Subsequent lines specify the
 * information of the list of objects, one object per list entry. Each entry has
 * the following tab-delimited fields: * HTTP URL * Length * MD5 - This field is
 * a base64-encoded MD5 hash of the object An HTTP URL that points to the object
 * to be transferred. It must be a valid URL with URL scheme HTTP or HTTPS. When
 * an object with URL `http(s)://hostname:port/` is transferred to the data
 * sink, the name of the object at the data sink is `/`. Length and MD5 provide
 * the size and the base64-encoded MD5 hash of the object. If Length does not
 * match the actual length of the object fetched, the object will not be
 * transferred. If MD5 does not match the MD5 computed from the transferred
 * bytes, the object transfer will fail. `lastModificationTime` is not available
 * in HttpData objects. The objects that the URL list points to must allow
 * public access. Storage Transfer Service obeys `robots.txt` rules and requires
 * the HTTP server to support Range requests and to return a Content-Length
 * header in each response.
 */
class HttpData {
  /**
   * The URL that points to the file that stores the object list entries. This
   * file must allow public access. Currently, only URLs with HTTP and HTTPS
   * schemes are supported. Required.
   */
  core.String listUrl;

  HttpData();

  HttpData.fromJson(core.Map _json) {
    if (_json.containsKey("listUrl")) {
      listUrl = _json["listUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (listUrl != null) {
      _json["listUrl"] = listUrl;
    }
    return _json;
  }
}

/**
 * The response message for
 * [Operations.ListOperations][google.longrunning.Operations.ListOperations].
 */
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

/** Response from ListTransferJobs. */
class ListTransferJobsResponse {
  /** The list next page token. */
  core.String nextPageToken;
  /** A list of transfer jobs. */
  core.List<TransferJob> transferJobs;

  ListTransferJobsResponse();

  ListTransferJobsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("transferJobs")) {
      transferJobs = _json["transferJobs"].map((value) => new TransferJob.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (transferJobs != null) {
      _json["transferJobs"] = transferJobs.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Conditions that determine which objects will be transferred. */
class ObjectConditions {
  /**
   * `excludePrefixes` must follow the requirements described for
   * `includePrefixes`. The max size of `excludePrefixes` is 20.
   */
  core.List<core.String> excludePrefixes;
  /**
   * If `includePrefixes` is specified, objects that satisfy the object
   * conditions must have names that start with one of the `includePrefixes` and
   * that do not start with any of the `excludePrefixes`. If `includePrefixes`
   * is not specified, all objects except those that have names starting with
   * one of the `excludePrefixes` must satisfy the object conditions.
   * Requirements: * Each include-prefix and exclude-prefix can contain any
   * sequence of Unicode characters, of max length 1024 bytes when UTF8-encoded,
   * and must not contain Carriage Return or Line Feed characters. Wildcard
   * matching and regular expression matching are not supported. * None of the
   * include-prefix or the exclude-prefix values can be empty, if specified. *
   * Each include-prefix must include a distinct portion of the object
   * namespace, i.e., no include-prefix may be a prefix of another
   * include-prefix. * Each exclude-prefix must exclude a distinct portion of
   * the object namespace, i.e., no exclude-prefix may be a prefix of another
   * exclude-prefix. * If `includePrefixes` is specified, then each
   * exclude-prefix must start with the value of a path explicitly included by
   * `includePrefixes`. The max size of `includePrefixes` is 20.
   */
  core.List<core.String> includePrefixes;
  /**
   * `maxTimeElapsedSinceLastModification` is the complement to
   * `minTimeElapsedSinceLastModification`.
   */
  core.String maxTimeElapsedSinceLastModification;
  /**
   * If unspecified, `minTimeElapsedSinceLastModification` takes a zero value
   * and `maxTimeElapsedSinceLastModification` takes the maximum possible value
   * of Duration. Objects that satisfy the object conditions must either have a
   * `lastModificationTime` greater or equal to `NOW` -
   * `maxTimeElapsedSinceLastModification` and less than `NOW` -
   * `minTimeElapsedSinceLastModification`, or not have a
   * `lastModificationTime`.
   */
  core.String minTimeElapsedSinceLastModification;

  ObjectConditions();

  ObjectConditions.fromJson(core.Map _json) {
    if (_json.containsKey("excludePrefixes")) {
      excludePrefixes = _json["excludePrefixes"];
    }
    if (_json.containsKey("includePrefixes")) {
      includePrefixes = _json["includePrefixes"];
    }
    if (_json.containsKey("maxTimeElapsedSinceLastModification")) {
      maxTimeElapsedSinceLastModification = _json["maxTimeElapsedSinceLastModification"];
    }
    if (_json.containsKey("minTimeElapsedSinceLastModification")) {
      minTimeElapsedSinceLastModification = _json["minTimeElapsedSinceLastModification"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (excludePrefixes != null) {
      _json["excludePrefixes"] = excludePrefixes;
    }
    if (includePrefixes != null) {
      _json["includePrefixes"] = includePrefixes;
    }
    if (maxTimeElapsedSinceLastModification != null) {
      _json["maxTimeElapsedSinceLastModification"] = maxTimeElapsedSinceLastModification;
    }
    if (minTimeElapsedSinceLastModification != null) {
      _json["minTimeElapsedSinceLastModification"] = minTimeElapsedSinceLastModification;
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
   * If the value is `false`, it means the operation is still in progress. If
   * true, the operation is completed and the `result` is available.
   */
  core.bool done;
  /** The error result of the operation in case of failure. */
  Status error;
  /**
   * Represents the transfer operation object.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> metadata;
  /**
   * The server-assigned name, which is only unique within the same service that
   * originally returns it. If you use the default HTTP mapping above, the
   * `name` should have the format of `operations/some/unique/name`.
   */
  core.String name;
  /**
   * The normal response of the operation in case of success. If the original
   * method returns no data on success, such as `Delete`, the response is
   * `google.protobuf.Empty`. If the original method is standard
   * `Get`/`Create`/`Update`, the response should be the resource. For other
   * methods, the response should have the type `XxxResponse`, where `Xxx` is
   * the original method name. For example, if the original method name is
   * `TakeSnapshot()`, the inferred response type is `TakeSnapshotResponse`.
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

/** Request passed to PauseTransferOperation. */
class PauseTransferOperationRequest {

  PauseTransferOperationRequest();

  PauseTransferOperationRequest.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** Request passed to ResumeTransferOperation. */
class ResumeTransferOperationRequest {

  ResumeTransferOperationRequest();

  ResumeTransferOperationRequest.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** Transfers can be scheduled to recur or to run just once. */
class Schedule {
  /**
   * The last day the recurring transfer will be run. If `scheduleEndDate` is
   * the same as `scheduleStartDate`, the transfer will be executed only once.
   */
  Date scheduleEndDate;
  /** The first day the recurring transfer is scheduled to run. Required. */
  Date scheduleStartDate;
  /**
   * The time in UTC at which the transfer will be scheduled to start in a day.
   * Transfers may start later than this time. If not specified, transfers are
   * scheduled to start at midnight UTC.
   */
  TimeOfDay startTimeOfDay;

  Schedule();

  Schedule.fromJson(core.Map _json) {
    if (_json.containsKey("scheduleEndDate")) {
      scheduleEndDate = new Date.fromJson(_json["scheduleEndDate"]);
    }
    if (_json.containsKey("scheduleStartDate")) {
      scheduleStartDate = new Date.fromJson(_json["scheduleStartDate"]);
    }
    if (_json.containsKey("startTimeOfDay")) {
      startTimeOfDay = new TimeOfDay.fromJson(_json["startTimeOfDay"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (scheduleEndDate != null) {
      _json["scheduleEndDate"] = (scheduleEndDate).toJson();
    }
    if (scheduleStartDate != null) {
      _json["scheduleStartDate"] = (scheduleStartDate).toJson();
    }
    if (startTimeOfDay != null) {
      _json["startTimeOfDay"] = (startTimeOfDay).toJson();
    }
    return _json;
  }
}

/**
 * The `Status` type defines a logical error model that is suitable for
 * different programming environments, including REST APIs and RPC APIs. It is
 * used by [gRPC](https://github.com/grpc). The error model is designed to be: -
 * Simple to use and understand for most users - Flexible enough to meet
 * unexpected needs # Overview The `Status` message contains three pieces of
 * data: error code, error message, and error details. The error code should be
 * an enum value of [google.rpc.Code][google.rpc.Code], but it may accept
 * additional error codes if needed. The error message should be a
 * developer-facing English message that helps developers *understand* and
 * *resolve* the error. If a localized user-facing error message is needed, put
 * the localized message in the error details or localize it in the client. The
 * optional error details may contain arbitrary information about the error.
 * There is a predefined set of error detail types in the package `google.rpc`
 * which can be used for common error conditions. # Language mapping The
 * `Status` message is the logical representation of the error model, but it is
 * not necessarily the actual wire format. When the `Status` message is exposed
 * in different client libraries and different wire protocols, it can be mapped
 * differently. For example, it will likely be mapped to some exceptions in
 * Java, but more likely mapped to some error codes in C. # Other uses The error
 * model and the `Status` message can be used in a variety of environments,
 * either with or without APIs, to provide a consistent developer experience
 * across different environments. Example uses of this error model include: -
 * Partial errors. If a service needs to return partial errors to the client, it
 * may embed the `Status` in the normal response to indicate the partial errors.
 * - Workflow errors. A typical workflow has multiple steps. Each step may have
 * a `Status` message for error reporting purpose. - Batch operations. If a
 * client uses batch request and batch response, the `Status` message should be
 * used directly inside batch response, one for each error sub-response. -
 * Asynchronous operations. If an API call embeds asynchronous operation results
 * in its response, the status of those operations should be represented
 * directly using the `Status` message. - Logging. If some API errors are stored
 * in logs, the message `Status` could be used directly after any stripping
 * needed for security/privacy reasons.
 */
class Status {
  /**
   * The status code, which should be an enum value of
   * [google.rpc.Code][google.rpc.Code].
   */
  core.int code;
  /**
   * A list of messages that carry the error details. There will be a common set
   * of message types for APIs to use.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Map<core.String, core.Object>> details;
  /**
   * A developer-facing error message, which should be in English. Any
   * user-facing error message should be localized and sent in the
   * [google.rpc.Status.details][google.rpc.Status.details] field, or localized
   * by the client.
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

/**
 * Represents a time of day. The date and time zone are either not significant
 * or are specified elsewhere. An API may chose to allow leap seconds. Related
 * types are [google.type.Date][google.type.Date] and
 * `google.protobuf.Timestamp`.
 */
class TimeOfDay {
  /**
   * Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
   * to allow the value "24:00:00" for scenarios like business closing time.
   */
  core.int hours;
  /** Minutes of hour of day. Must be from 0 to 59. */
  core.int minutes;
  /** Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. */
  core.int nanos;
  /**
   * Seconds of minutes of the time. Must normally be from 0 to 59. An API may
   * allow the value 60 if it allows leap-seconds.
   */
  core.int seconds;

  TimeOfDay();

  TimeOfDay.fromJson(core.Map _json) {
    if (_json.containsKey("hours")) {
      hours = _json["hours"];
    }
    if (_json.containsKey("minutes")) {
      minutes = _json["minutes"];
    }
    if (_json.containsKey("nanos")) {
      nanos = _json["nanos"];
    }
    if (_json.containsKey("seconds")) {
      seconds = _json["seconds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (hours != null) {
      _json["hours"] = hours;
    }
    if (minutes != null) {
      _json["minutes"] = minutes;
    }
    if (nanos != null) {
      _json["nanos"] = nanos;
    }
    if (seconds != null) {
      _json["seconds"] = seconds;
    }
    return _json;
  }
}

/**
 * A collection of counters that report the progress of a transfer operation.
 */
class TransferCounters {
  /** Bytes that are copied to the data sink. */
  core.String bytesCopiedToSink;
  /** Bytes that are deleted from the data sink. */
  core.String bytesDeletedFromSink;
  /** Bytes that are deleted from the data source. */
  core.String bytesDeletedFromSource;
  /** Bytes that failed to be deleted from the data sink. */
  core.String bytesFailedToDeleteFromSink;
  /**
   * Bytes found in the data source that are scheduled to be transferred, which
   * will be copied, excluded based on conditions, or skipped due to failures.
   */
  core.String bytesFoundFromSource;
  /** Bytes found only in the data sink that are scheduled to be deleted. */
  core.String bytesFoundOnlyFromSink;
  /** Bytes in the data source that failed during the transfer. */
  core.String bytesFromSourceFailed;
  /**
   * Bytes in the data source that are not transferred because they already
   * exist in the data sink.
   */
  core.String bytesFromSourceSkippedBySync;
  /** Objects that are copied to the data sink. */
  core.String objectsCopiedToSink;
  /** Objects that are deleted from the data sink. */
  core.String objectsDeletedFromSink;
  /** Objects that are deleted from the data source. */
  core.String objectsDeletedFromSource;
  /** Objects that failed to be deleted from the data sink. */
  core.String objectsFailedToDeleteFromSink;
  /**
   * Objects found in the data source that are scheduled to be transferred,
   * which will be copied, excluded based on conditions, or skipped due to
   * failures.
   */
  core.String objectsFoundFromSource;
  /** Objects found only in the data sink that are scheduled to be deleted. */
  core.String objectsFoundOnlyFromSink;
  /** Objects in the data source that failed during the transfer. */
  core.String objectsFromSourceFailed;
  /**
   * Objects in the data source that are not transferred because they already
   * exist in the data sink.
   */
  core.String objectsFromSourceSkippedBySync;

  TransferCounters();

  TransferCounters.fromJson(core.Map _json) {
    if (_json.containsKey("bytesCopiedToSink")) {
      bytesCopiedToSink = _json["bytesCopiedToSink"];
    }
    if (_json.containsKey("bytesDeletedFromSink")) {
      bytesDeletedFromSink = _json["bytesDeletedFromSink"];
    }
    if (_json.containsKey("bytesDeletedFromSource")) {
      bytesDeletedFromSource = _json["bytesDeletedFromSource"];
    }
    if (_json.containsKey("bytesFailedToDeleteFromSink")) {
      bytesFailedToDeleteFromSink = _json["bytesFailedToDeleteFromSink"];
    }
    if (_json.containsKey("bytesFoundFromSource")) {
      bytesFoundFromSource = _json["bytesFoundFromSource"];
    }
    if (_json.containsKey("bytesFoundOnlyFromSink")) {
      bytesFoundOnlyFromSink = _json["bytesFoundOnlyFromSink"];
    }
    if (_json.containsKey("bytesFromSourceFailed")) {
      bytesFromSourceFailed = _json["bytesFromSourceFailed"];
    }
    if (_json.containsKey("bytesFromSourceSkippedBySync")) {
      bytesFromSourceSkippedBySync = _json["bytesFromSourceSkippedBySync"];
    }
    if (_json.containsKey("objectsCopiedToSink")) {
      objectsCopiedToSink = _json["objectsCopiedToSink"];
    }
    if (_json.containsKey("objectsDeletedFromSink")) {
      objectsDeletedFromSink = _json["objectsDeletedFromSink"];
    }
    if (_json.containsKey("objectsDeletedFromSource")) {
      objectsDeletedFromSource = _json["objectsDeletedFromSource"];
    }
    if (_json.containsKey("objectsFailedToDeleteFromSink")) {
      objectsFailedToDeleteFromSink = _json["objectsFailedToDeleteFromSink"];
    }
    if (_json.containsKey("objectsFoundFromSource")) {
      objectsFoundFromSource = _json["objectsFoundFromSource"];
    }
    if (_json.containsKey("objectsFoundOnlyFromSink")) {
      objectsFoundOnlyFromSink = _json["objectsFoundOnlyFromSink"];
    }
    if (_json.containsKey("objectsFromSourceFailed")) {
      objectsFromSourceFailed = _json["objectsFromSourceFailed"];
    }
    if (_json.containsKey("objectsFromSourceSkippedBySync")) {
      objectsFromSourceSkippedBySync = _json["objectsFromSourceSkippedBySync"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bytesCopiedToSink != null) {
      _json["bytesCopiedToSink"] = bytesCopiedToSink;
    }
    if (bytesDeletedFromSink != null) {
      _json["bytesDeletedFromSink"] = bytesDeletedFromSink;
    }
    if (bytesDeletedFromSource != null) {
      _json["bytesDeletedFromSource"] = bytesDeletedFromSource;
    }
    if (bytesFailedToDeleteFromSink != null) {
      _json["bytesFailedToDeleteFromSink"] = bytesFailedToDeleteFromSink;
    }
    if (bytesFoundFromSource != null) {
      _json["bytesFoundFromSource"] = bytesFoundFromSource;
    }
    if (bytesFoundOnlyFromSink != null) {
      _json["bytesFoundOnlyFromSink"] = bytesFoundOnlyFromSink;
    }
    if (bytesFromSourceFailed != null) {
      _json["bytesFromSourceFailed"] = bytesFromSourceFailed;
    }
    if (bytesFromSourceSkippedBySync != null) {
      _json["bytesFromSourceSkippedBySync"] = bytesFromSourceSkippedBySync;
    }
    if (objectsCopiedToSink != null) {
      _json["objectsCopiedToSink"] = objectsCopiedToSink;
    }
    if (objectsDeletedFromSink != null) {
      _json["objectsDeletedFromSink"] = objectsDeletedFromSink;
    }
    if (objectsDeletedFromSource != null) {
      _json["objectsDeletedFromSource"] = objectsDeletedFromSource;
    }
    if (objectsFailedToDeleteFromSink != null) {
      _json["objectsFailedToDeleteFromSink"] = objectsFailedToDeleteFromSink;
    }
    if (objectsFoundFromSource != null) {
      _json["objectsFoundFromSource"] = objectsFoundFromSource;
    }
    if (objectsFoundOnlyFromSink != null) {
      _json["objectsFoundOnlyFromSink"] = objectsFoundOnlyFromSink;
    }
    if (objectsFromSourceFailed != null) {
      _json["objectsFromSourceFailed"] = objectsFromSourceFailed;
    }
    if (objectsFromSourceSkippedBySync != null) {
      _json["objectsFromSourceSkippedBySync"] = objectsFromSourceSkippedBySync;
    }
    return _json;
  }
}

/**
 * This resource represents the configuration of a transfer job that runs
 * periodically.
 */
class TransferJob {
  /** This field cannot be changed by user requests. */
  core.String creationTime;
  /** This field cannot be changed by user requests. */
  core.String deletionTime;
  /**
   * A description provided by the user for the job. Its max length is 1024
   * bytes when Unicode-encoded.
   */
  core.String description;
  /** This field cannot be changed by user requests. */
  core.String lastModificationTime;
  /**
   * A globally unique name assigned by Storage Transfer Service when the job is
   * created. This field should be left empty in requests to create a new
   * transfer job; otherwise, the requests result in an `INVALID_ARGUMENT`
   * error.
   */
  core.String name;
  /**
   * The ID of the Google Developers Console project that owns the job.
   * Required.
   */
  core.String projectId;
  /** Schedule specification. Required. */
  Schedule schedule;
  /**
   * Status of the job. This value MUST be specified for
   * `CreateTransferJobRequests`. NOTE: The effect of the new job status takes
   * place during a subsequent job run. For example, if you change the job
   * status from `ENABLED` to `DISABLED`, and an operation spawned by the
   * transfer is running, the status change would not affect the current
   * operation.
   * Possible string values are:
   * - "STATUS_UNSPECIFIED" : A STATUS_UNSPECIFIED.
   * - "ENABLED" : A ENABLED.
   * - "DISABLED" : A DISABLED.
   * - "DELETED" : A DELETED.
   */
  core.String status;
  /** Transfer specification. Required. */
  TransferSpec transferSpec;

  TransferJob();

  TransferJob.fromJson(core.Map _json) {
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("deletionTime")) {
      deletionTime = _json["deletionTime"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("lastModificationTime")) {
      lastModificationTime = _json["lastModificationTime"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("schedule")) {
      schedule = new Schedule.fromJson(_json["schedule"]);
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("transferSpec")) {
      transferSpec = new TransferSpec.fromJson(_json["transferSpec"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (deletionTime != null) {
      _json["deletionTime"] = deletionTime;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (lastModificationTime != null) {
      _json["lastModificationTime"] = lastModificationTime;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (schedule != null) {
      _json["schedule"] = (schedule).toJson();
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (transferSpec != null) {
      _json["transferSpec"] = (transferSpec).toJson();
    }
    return _json;
  }
}

/** A description of the execution of a transfer. */
class TransferOperation {
  /** Information about the progress of the transfer operation. */
  TransferCounters counters;
  /** End time of this transfer execution. */
  core.String endTime;
  /** Summarizes errors encountered with sample error log entries. */
  core.List<ErrorSummary> errorBreakdowns;
  /** A globally unique ID assigned by the system. */
  core.String name;
  /**
   * The ID of the Google Developers Console project that owns the operation.
   * Required.
   */
  core.String projectId;
  /** Start time of this transfer execution. */
  core.String startTime;
  /**
   * Status of the transfer operation.
   * Possible string values are:
   * - "STATUS_UNSPECIFIED" : A STATUS_UNSPECIFIED.
   * - "IN_PROGRESS" : A IN_PROGRESS.
   * - "PAUSED" : A PAUSED.
   * - "SUCCESS" : A SUCCESS.
   * - "FAILED" : A FAILED.
   * - "ABORTED" : A ABORTED.
   */
  core.String status;
  /** The name of the transfer job that triggers this transfer operation. */
  core.String transferJobName;
  /** Transfer specification. Required. */
  TransferSpec transferSpec;

  TransferOperation();

  TransferOperation.fromJson(core.Map _json) {
    if (_json.containsKey("counters")) {
      counters = new TransferCounters.fromJson(_json["counters"]);
    }
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("errorBreakdowns")) {
      errorBreakdowns = _json["errorBreakdowns"].map((value) => new ErrorSummary.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("transferJobName")) {
      transferJobName = _json["transferJobName"];
    }
    if (_json.containsKey("transferSpec")) {
      transferSpec = new TransferSpec.fromJson(_json["transferSpec"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (counters != null) {
      _json["counters"] = (counters).toJson();
    }
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (errorBreakdowns != null) {
      _json["errorBreakdowns"] = errorBreakdowns.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (transferJobName != null) {
      _json["transferJobName"] = transferJobName;
    }
    if (transferSpec != null) {
      _json["transferSpec"] = (transferSpec).toJson();
    }
    return _json;
  }
}

/**
 * TransferOptions uses three boolean parameters to define the actions to be
 * performed on objects in a transfer.
 */
class TransferOptions {
  /**
   * Whether objects should be deleted from the source after they are
   * transferred to the sink.
   */
  core.bool deleteObjectsFromSourceAfterTransfer;
  /** Whether objects that exist only in the sink should be deleted. */
  core.bool deleteObjectsUniqueInSink;
  /** Whether overwriting objects that already exist in the sink is allowed. */
  core.bool overwriteObjectsAlreadyExistingInSink;

  TransferOptions();

  TransferOptions.fromJson(core.Map _json) {
    if (_json.containsKey("deleteObjectsFromSourceAfterTransfer")) {
      deleteObjectsFromSourceAfterTransfer = _json["deleteObjectsFromSourceAfterTransfer"];
    }
    if (_json.containsKey("deleteObjectsUniqueInSink")) {
      deleteObjectsUniqueInSink = _json["deleteObjectsUniqueInSink"];
    }
    if (_json.containsKey("overwriteObjectsAlreadyExistingInSink")) {
      overwriteObjectsAlreadyExistingInSink = _json["overwriteObjectsAlreadyExistingInSink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deleteObjectsFromSourceAfterTransfer != null) {
      _json["deleteObjectsFromSourceAfterTransfer"] = deleteObjectsFromSourceAfterTransfer;
    }
    if (deleteObjectsUniqueInSink != null) {
      _json["deleteObjectsUniqueInSink"] = deleteObjectsUniqueInSink;
    }
    if (overwriteObjectsAlreadyExistingInSink != null) {
      _json["overwriteObjectsAlreadyExistingInSink"] = overwriteObjectsAlreadyExistingInSink;
    }
    return _json;
  }
}

/** Configuration for running a transfer. */
class TransferSpec {
  /** An AWS S3 data source. */
  AwsS3Data awsS3DataSource;
  /** A Google Cloud Storage data sink. */
  GcsData gcsDataSink;
  /** A Google Cloud Storage data source. */
  GcsData gcsDataSource;
  /** An HTTP URL data source. */
  HttpData httpDataSource;
  /**
   * Only objects that satisfy these object conditions are included in the set
   * of data source and data sink objects. Object conditions based on objects'
   * `lastModificationTime` do not exclude objects in a data sink.
   */
  ObjectConditions objectConditions;
  /**
   * If the option `deleteObjectsUniqueInSink` is `true`, object conditions
   * based on objects' `lastModificationTime` are ignored and do not exclude
   * objects in a data source or a data sink.
   */
  TransferOptions transferOptions;

  TransferSpec();

  TransferSpec.fromJson(core.Map _json) {
    if (_json.containsKey("awsS3DataSource")) {
      awsS3DataSource = new AwsS3Data.fromJson(_json["awsS3DataSource"]);
    }
    if (_json.containsKey("gcsDataSink")) {
      gcsDataSink = new GcsData.fromJson(_json["gcsDataSink"]);
    }
    if (_json.containsKey("gcsDataSource")) {
      gcsDataSource = new GcsData.fromJson(_json["gcsDataSource"]);
    }
    if (_json.containsKey("httpDataSource")) {
      httpDataSource = new HttpData.fromJson(_json["httpDataSource"]);
    }
    if (_json.containsKey("objectConditions")) {
      objectConditions = new ObjectConditions.fromJson(_json["objectConditions"]);
    }
    if (_json.containsKey("transferOptions")) {
      transferOptions = new TransferOptions.fromJson(_json["transferOptions"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (awsS3DataSource != null) {
      _json["awsS3DataSource"] = (awsS3DataSource).toJson();
    }
    if (gcsDataSink != null) {
      _json["gcsDataSink"] = (gcsDataSink).toJson();
    }
    if (gcsDataSource != null) {
      _json["gcsDataSource"] = (gcsDataSource).toJson();
    }
    if (httpDataSource != null) {
      _json["httpDataSource"] = (httpDataSource).toJson();
    }
    if (objectConditions != null) {
      _json["objectConditions"] = (objectConditions).toJson();
    }
    if (transferOptions != null) {
      _json["transferOptions"] = (transferOptions).toJson();
    }
    return _json;
  }
}

/** Request passed to UpdateTransferJob. */
class UpdateTransferJobRequest {
  /**
   * The ID of the Google Developers Console project that owns the job.
   * Required.
   */
  core.String projectId;
  /** The job to update. Required. */
  TransferJob transferJob;
  /**
   * The field mask of the fields in `transferJob` that are to be updated in
   * this request. Fields in `transferJob` that can be updated are:
   * `description`, `transferSpec`, and `status`. To update the `transferSpec`
   * of the job, a complete transfer specification has to be provided. An
   * incomplete specification which misses any required fields will be rejected
   * with the error `INVALID_ARGUMENT`.
   */
  core.String updateTransferJobFieldMask;

  UpdateTransferJobRequest();

  UpdateTransferJobRequest.fromJson(core.Map _json) {
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("transferJob")) {
      transferJob = new TransferJob.fromJson(_json["transferJob"]);
    }
    if (_json.containsKey("updateTransferJobFieldMask")) {
      updateTransferJobFieldMask = _json["updateTransferJobFieldMask"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (transferJob != null) {
      _json["transferJob"] = (transferJob).toJson();
    }
    if (updateTransferJobFieldMask != null) {
      _json["updateTransferJobFieldMask"] = updateTransferJobFieldMask;
    }
    return _json;
  }
}
