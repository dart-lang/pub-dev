// This is a generated file (see the discoveryapis_generator project).

library googleapis.admin.datatransfer_v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client admin/datatransfer_v1';

/** Transfers user data from one user to another. */
class AdminApi {
  /** View and manage data transfers between users in your organization */
  static const AdminDatatransferScope = "https://www.googleapis.com/auth/admin.datatransfer";

  /** View data transfers between users in your organization */
  static const AdminDatatransferReadonlyScope = "https://www.googleapis.com/auth/admin.datatransfer.readonly";


  final commons.ApiRequester _requester;

  ApplicationsResourceApi get applications => new ApplicationsResourceApi(_requester);
  TransfersResourceApi get transfers => new TransfersResourceApi(_requester);

  AdminApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "admin/datatransfer/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ApplicationsResourceApi {
  final commons.ApiRequester _requester;

  ApplicationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves information about an application for the given application ID.
   *
   * Request parameters:
   *
   * [applicationId] - ID of the application resource to be retrieved.
   *
   * Completes with a [Application].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Application> get(core.String applicationId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (applicationId == null) {
      throw new core.ArgumentError("Parameter applicationId is required.");
    }

    _url = 'applications/' + commons.Escaper.ecapeVariable('$applicationId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Application.fromJson(data));
  }

  /**
   * Lists the applications available for data transfer for a customer.
   *
   * Request parameters:
   *
   * [customerId] - Immutable ID of the Google Apps account.
   *
   * [maxResults] - Maximum number of results to return. Default is 100.
   * Value must be between "1" and "500".
   *
   * [pageToken] - Token to specify next page in the list.
   *
   * Completes with a [ApplicationsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ApplicationsListResponse> list({core.String customerId, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (customerId != null) {
      _queryParams["customerId"] = [customerId];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'applications';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ApplicationsListResponse.fromJson(data));
  }

}


class TransfersResourceApi {
  final commons.ApiRequester _requester;

  TransfersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves a data transfer request by its resource ID.
   *
   * Request parameters:
   *
   * [dataTransferId] - ID of the resource to be retrieved. This is returned in
   * the response from the insert method.
   *
   * Completes with a [DataTransfer].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DataTransfer> get(core.String dataTransferId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (dataTransferId == null) {
      throw new core.ArgumentError("Parameter dataTransferId is required.");
    }

    _url = 'transfers/' + commons.Escaper.ecapeVariable('$dataTransferId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DataTransfer.fromJson(data));
  }

  /**
   * Inserts a data transfer request.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [DataTransfer].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DataTransfer> insert(DataTransfer request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'transfers';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DataTransfer.fromJson(data));
  }

  /**
   * Lists the transfers for a customer by source user, destination user, or
   * status.
   *
   * Request parameters:
   *
   * [customerId] - Immutable ID of the Google Apps account.
   *
   * [maxResults] - Maximum number of results to return. Default is 100.
   * Value must be between "1" and "500".
   *
   * [newOwnerUserId] - Destination user's profile ID.
   *
   * [oldOwnerUserId] - Source user's profile ID.
   *
   * [pageToken] - Token to specify the next page in the list.
   *
   * [status] - Status of the transfer.
   *
   * Completes with a [DataTransfersListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DataTransfersListResponse> list({core.String customerId, core.int maxResults, core.String newOwnerUserId, core.String oldOwnerUserId, core.String pageToken, core.String status}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (customerId != null) {
      _queryParams["customerId"] = [customerId];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (newOwnerUserId != null) {
      _queryParams["newOwnerUserId"] = [newOwnerUserId];
    }
    if (oldOwnerUserId != null) {
      _queryParams["oldOwnerUserId"] = [oldOwnerUserId];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (status != null) {
      _queryParams["status"] = [status];
    }

    _url = 'transfers';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DataTransfersListResponse.fromJson(data));
  }

}



/** The JSON template for an Application resource. */
class Application {
  /** Etag of the resource. */
  core.String etag;
  /** The application's ID. */
  core.String id;
  /** Identifies the resource as a DataTransfer Application Resource. */
  core.String kind;
  /** The application's name. */
  core.String name;
  /**
   * The list of all possible transfer parameters for this application. These
   * parameters can be used to select the data of the user in this application
   * to be transfered.
   */
  core.List<ApplicationTransferParam> transferParams;

  Application();

  Application.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("transferParams")) {
      transferParams = _json["transferParams"].map((value) => new ApplicationTransferParam.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (transferParams != null) {
      _json["transferParams"] = transferParams.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Template to map fields of ApplicationDataTransfer resource. */
class ApplicationDataTransfer {
  /** The application's ID. */
  core.String applicationId;
  /**
   * The transfer parameters for the application. These parameters are used to
   * select the data which will get transfered in context of this application.
   */
  core.List<ApplicationTransferParam> applicationTransferParams;
  /** Current status of transfer for this application. (Read-only) */
  core.String applicationTransferStatus;

  ApplicationDataTransfer();

  ApplicationDataTransfer.fromJson(core.Map _json) {
    if (_json.containsKey("applicationId")) {
      applicationId = _json["applicationId"];
    }
    if (_json.containsKey("applicationTransferParams")) {
      applicationTransferParams = _json["applicationTransferParams"].map((value) => new ApplicationTransferParam.fromJson(value)).toList();
    }
    if (_json.containsKey("applicationTransferStatus")) {
      applicationTransferStatus = _json["applicationTransferStatus"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (applicationId != null) {
      _json["applicationId"] = applicationId;
    }
    if (applicationTransferParams != null) {
      _json["applicationTransferParams"] = applicationTransferParams.map((value) => (value).toJson()).toList();
    }
    if (applicationTransferStatus != null) {
      _json["applicationTransferStatus"] = applicationTransferStatus;
    }
    return _json;
  }
}

/** Template for application transfer parameters. */
class ApplicationTransferParam {
  /** The type of the transfer parameter. eg: 'PRIVACY_LEVEL' */
  core.String key;
  /**
   * The value of the coressponding transfer parameter. eg: 'PRIVATE' or
   * 'SHARED'
   */
  core.List<core.String> value;

  ApplicationTransferParam();

  ApplicationTransferParam.fromJson(core.Map _json) {
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

/** Template for a collection of Applications. */
class ApplicationsListResponse {
  /**
   * List of applications that support data transfer and are also installed for
   * the customer.
   */
  core.List<Application> applications;
  /** ETag of the resource. */
  core.String etag;
  /** Identifies the resource as a collection of Applications. */
  core.String kind;
  /**
   * Continuation token which will be used to specify next page in list API.
   */
  core.String nextPageToken;

  ApplicationsListResponse();

  ApplicationsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("applications")) {
      applications = _json["applications"].map((value) => new Application.fromJson(value)).toList();
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
    if (applications != null) {
      _json["applications"] = applications.map((value) => (value).toJson()).toList();
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

/** The JSON template for a DataTransfer resource. */
class DataTransfer {
  /**
   * List of per application data transfer resources. It contains data transfer
   * details of the applications associated with this transfer resource. Note
   * that this list is also used to specify the applications for which data
   * transfer has to be done at the time of the transfer resource creation.
   */
  core.List<ApplicationDataTransfer> applicationDataTransfers;
  /** ETag of the resource. */
  core.String etag;
  /** The transfer's ID (Read-only). */
  core.String id;
  /** Identifies the resource as a DataTransfer request. */
  core.String kind;
  /** ID of the user to whom the data is being transfered. */
  core.String newOwnerUserId;
  /** ID of the user whose data is being transfered. */
  core.String oldOwnerUserId;
  /** Overall transfer status (Read-only). */
  core.String overallTransferStatusCode;
  /** The time at which the data transfer was requested (Read-only). */
  core.DateTime requestTime;

  DataTransfer();

  DataTransfer.fromJson(core.Map _json) {
    if (_json.containsKey("applicationDataTransfers")) {
      applicationDataTransfers = _json["applicationDataTransfers"].map((value) => new ApplicationDataTransfer.fromJson(value)).toList();
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("newOwnerUserId")) {
      newOwnerUserId = _json["newOwnerUserId"];
    }
    if (_json.containsKey("oldOwnerUserId")) {
      oldOwnerUserId = _json["oldOwnerUserId"];
    }
    if (_json.containsKey("overallTransferStatusCode")) {
      overallTransferStatusCode = _json["overallTransferStatusCode"];
    }
    if (_json.containsKey("requestTime")) {
      requestTime = core.DateTime.parse(_json["requestTime"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (applicationDataTransfers != null) {
      _json["applicationDataTransfers"] = applicationDataTransfers.map((value) => (value).toJson()).toList();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (newOwnerUserId != null) {
      _json["newOwnerUserId"] = newOwnerUserId;
    }
    if (oldOwnerUserId != null) {
      _json["oldOwnerUserId"] = oldOwnerUserId;
    }
    if (overallTransferStatusCode != null) {
      _json["overallTransferStatusCode"] = overallTransferStatusCode;
    }
    if (requestTime != null) {
      _json["requestTime"] = (requestTime).toIso8601String();
    }
    return _json;
  }
}

/** Template for a collection of DataTransfer resources. */
class DataTransfersListResponse {
  /** List of data transfer requests. */
  core.List<DataTransfer> dataTransfers;
  /** ETag of the resource. */
  core.String etag;
  /** Identifies the resource as a collection of data transfer requests. */
  core.String kind;
  /**
   * Continuation token which will be used to specify next page in list API.
   */
  core.String nextPageToken;

  DataTransfersListResponse();

  DataTransfersListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("dataTransfers")) {
      dataTransfers = _json["dataTransfers"].map((value) => new DataTransfer.fromJson(value)).toList();
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
    if (dataTransfers != null) {
      _json["dataTransfers"] = dataTransfers.map((value) => (value).toJson()).toList();
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
