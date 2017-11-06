// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.resourceviews.v1beta2;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client resourceviews/v1beta2';

/// The Resource View API allows users to create and manage logical sets of
/// Google Compute Engine instances.
class ResourceviewsApi {
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

  /// View and manage your Google Cloud Platform management resources and
  /// deployment status information
  static const NdevCloudmanScope =
      "https://www.googleapis.com/auth/ndev.cloudman";

  /// View your Google Cloud Platform management resources and deployment status
  /// information
  static const NdevCloudmanReadonlyScope =
      "https://www.googleapis.com/auth/ndev.cloudman.readonly";

  final commons.ApiRequester _requester;

  ZoneOperationsResourceApi get zoneOperations =>
      new ZoneOperationsResourceApi(_requester);
  ZoneViewsResourceApi get zoneViews => new ZoneViewsResourceApi(_requester);

  ResourceviewsApi(http.Client client,
      {core.String rootUrl: "https://www.googleapis.com/",
      core.String servicePath: "resourceviews/v1beta2/projects/"})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
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

class ZoneViewsResourceApi {
  final commons.ApiRequester _requester;

  ZoneViewsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Add resources to the view.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [resourceView] - The name of the resource view.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> addResources(ZoneViewsAddResourcesRequest request,
      core.String project, core.String zone, core.String resourceView) {
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
    if (resourceView == null) {
      throw new core.ArgumentError("Parameter resourceView is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceView') +
        '/addResources';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Delete a resource view.
  ///
  /// Request parameters:
  ///
  /// [project] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [resourceView] - The name of the resource view.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> delete(
      core.String project, core.String zone, core.String resourceView) {
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
    if (resourceView == null) {
      throw new core.ArgumentError("Parameter resourceView is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceView');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Get the information of a zonal resource view.
  ///
  /// Request parameters:
  ///
  /// [project] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [resourceView] - The name of the resource view.
  ///
  /// Completes with a [ResourceView].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ResourceView> get(
      core.String project, core.String zone, core.String resourceView) {
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
    if (resourceView == null) {
      throw new core.ArgumentError("Parameter resourceView is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceView');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ResourceView.fromJson(data));
  }

  /// Get the service information of a resource view or a resource.
  ///
  /// Request parameters:
  ///
  /// [project] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [resourceView] - The name of the resource view.
  ///
  /// [resourceName] - The name of the resource if user wants to get the service
  /// information of the resource.
  ///
  /// Completes with a [ZoneViewsGetServiceResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ZoneViewsGetServiceResponse> getService(
      core.String project, core.String zone, core.String resourceView,
      {core.String resourceName}) {
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
    if (resourceView == null) {
      throw new core.ArgumentError("Parameter resourceView is required.");
    }
    if (resourceName != null) {
      _queryParams["resourceName"] = [resourceName];
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceView') +
        '/getService';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ZoneViewsGetServiceResponse.fromJson(data));
  }

  /// Create a resource view.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> insert(
      ResourceView request, core.String project, core.String zone) {
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
        '/resourceViews';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// List resource views.
  ///
  /// Request parameters:
  ///
  /// [project] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [maxResults] - Maximum count of results to be returned. Acceptable values
  /// are 0 to 5000, inclusive. (Default: 5000)
  /// Value must be between "0" and "5000".
  ///
  /// [pageToken] - Specifies a nextPageToken returned by a previous list
  /// request. This token can be used to request the next page of results from a
  /// previous list request.
  ///
  /// Completes with a [ZoneViewsList].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ZoneViewsList> list(core.String project, core.String zone,
      {core.int maxResults, core.String pageToken}) {
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
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ZoneViewsList.fromJson(data));
  }

  /// List the resources of the resource view.
  ///
  /// Request parameters:
  ///
  /// [project] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [resourceView] - The name of the resource view.
  ///
  /// [format] - The requested format of the return value. It can be URL or
  /// URL_PORT. A JSON object will be included in the response based on the
  /// format. The default format is NONE, which results in no JSON in the
  /// response.
  /// Possible string values are:
  /// - "NONE"
  /// - "URL"
  /// - "URL_PORT"
  ///
  /// [listState] - The state of the instance to list. By default, it lists all
  /// instances.
  /// Possible string values are:
  /// - "ALL"
  /// - "RUNNING"
  ///
  /// [maxResults] - Maximum count of results to be returned. Acceptable values
  /// are 0 to 5000, inclusive. (Default: 5000)
  /// Value must be between "0" and "5000".
  ///
  /// [pageToken] - Specifies a nextPageToken returned by a previous list
  /// request. This token can be used to request the next page of results from a
  /// previous list request.
  ///
  /// [serviceName] - The service name to return in the response. It is optional
  /// and if it is not set, all the service end points will be returned.
  ///
  /// Completes with a [ZoneViewsListResourcesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ZoneViewsListResourcesResponse> listResources(
      core.String project, core.String zone, core.String resourceView,
      {core.String format,
      core.String listState,
      core.int maxResults,
      core.String pageToken,
      core.String serviceName}) {
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
    if (resourceView == null) {
      throw new core.ArgumentError("Parameter resourceView is required.");
    }
    if (format != null) {
      _queryParams["format"] = [format];
    }
    if (listState != null) {
      _queryParams["listState"] = [listState];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (serviceName != null) {
      _queryParams["serviceName"] = [serviceName];
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceView') +
        '/resources';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ZoneViewsListResourcesResponse.fromJson(data));
  }

  /// Remove resources from the view.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [resourceView] - The name of the resource view.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> removeResources(
      ZoneViewsRemoveResourcesRequest request,
      core.String project,
      core.String zone,
      core.String resourceView) {
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
    if (resourceView == null) {
      throw new core.ArgumentError("Parameter resourceView is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceView') +
        '/removeResources';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Update the service information of a resource view or a resource.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [resourceView] - The name of the resource view.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> setService(ZoneViewsSetServiceRequest request,
      core.String project, core.String zone, core.String resourceView) {
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
    if (resourceView == null) {
      throw new core.ArgumentError("Parameter resourceView is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceView') +
        '/setService';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }
}

/// The Label to be applied to the resource views.
class Label {
  /// Key of the label.
  core.String key;

  /// Value of the label.
  core.String value;

  Label();

  Label.fromJson(core.Map _json) {
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

/// The list response item that contains the resource and end points
/// information.
class ListResourceResponseItem {
  /// The list of service end points on the resource.
  core.Map<core.String, core.List<core.int>> endpoints;

  /// The full URL of the resource.
  core.String resource;

  ListResourceResponseItem();

  ListResourceResponseItem.fromJson(core.Map _json) {
    if (_json.containsKey("endpoints")) {
      endpoints = _json["endpoints"];
    }
    if (_json.containsKey("resource")) {
      resource = _json["resource"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endpoints != null) {
      _json["endpoints"] = endpoints;
    }
    if (resource != null) {
      _json["resource"] = resource;
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

/// The resource view object.
class ResourceView {
  /// The creation time of the resource view.
  core.String creationTimestamp;

  /// The detailed description of the resource view.
  core.String description;

  /// Services endpoint information.
  core.List<ServiceEndpoint> endpoints;

  /// The fingerprint of the service endpoint information.
  core.String fingerprint;

  /// [Output Only] The ID of the resource view.
  core.String id;

  /// Type of the resource.
  core.String kind;

  /// The labels for events.
  core.List<Label> labels;

  /// The name of the resource view.
  core.String name;

  /// The URL of a Compute Engine network to which the resources in the view
  /// belong.
  core.String network;

  /// A list of all resources in the resource view.
  core.List<core.String> resources;

  /// [Output Only] A self-link to the resource view.
  core.String selfLink;

  /// The total number of resources in the resource view.
  core.int size;

  ResourceView();

  ResourceView.fromJson(core.Map _json) {
    if (_json.containsKey("creationTimestamp")) {
      creationTimestamp = _json["creationTimestamp"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("endpoints")) {
      endpoints = _json["endpoints"]
          .map((value) => new ServiceEndpoint.fromJson(value))
          .toList();
    }
    if (_json.containsKey("fingerprint")) {
      fingerprint = _json["fingerprint"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("labels")) {
      labels =
          _json["labels"].map((value) => new Label.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("network")) {
      network = _json["network"];
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("size")) {
      size = _json["size"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (creationTimestamp != null) {
      _json["creationTimestamp"] = creationTimestamp;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (endpoints != null) {
      _json["endpoints"] = endpoints.map((value) => (value).toJson()).toList();
    }
    if (fingerprint != null) {
      _json["fingerprint"] = fingerprint;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (labels != null) {
      _json["labels"] = labels.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (network != null) {
      _json["network"] = network;
    }
    if (resources != null) {
      _json["resources"] = resources;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (size != null) {
      _json["size"] = size;
    }
    return _json;
  }
}

/// The service endpoint that may be started in a VM.
class ServiceEndpoint {
  /// The name of the service endpoint.
  core.String name;

  /// The port of the service endpoint.
  core.int port;

  ServiceEndpoint();

  ServiceEndpoint.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("port")) {
      port = _json["port"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (name != null) {
      _json["name"] = name;
    }
    if (port != null) {
      _json["port"] = port;
    }
    return _json;
  }
}

/// The request to add resources to the resource view.
class ZoneViewsAddResourcesRequest {
  /// The list of resources to be added.
  core.List<core.String> resources;

  ZoneViewsAddResourcesRequest();

  ZoneViewsAddResourcesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("resources")) {
      resources = _json["resources"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (resources != null) {
      _json["resources"] = resources;
    }
    return _json;
  }
}

class ZoneViewsGetServiceResponse {
  /// The service information.
  core.List<ServiceEndpoint> endpoints;

  /// The fingerprint of the service information.
  core.String fingerprint;

  ZoneViewsGetServiceResponse();

  ZoneViewsGetServiceResponse.fromJson(core.Map _json) {
    if (_json.containsKey("endpoints")) {
      endpoints = _json["endpoints"]
          .map((value) => new ServiceEndpoint.fromJson(value))
          .toList();
    }
    if (_json.containsKey("fingerprint")) {
      fingerprint = _json["fingerprint"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endpoints != null) {
      _json["endpoints"] = endpoints.map((value) => (value).toJson()).toList();
    }
    if (fingerprint != null) {
      _json["fingerprint"] = fingerprint;
    }
    return _json;
  }
}

/// The response to a list request.
class ZoneViewsList {
  /// The result that contains all resource views that meet the criteria.
  core.List<ResourceView> items;

  /// Type of resource.
  core.String kind;

  /// A token used for pagination.
  core.String nextPageToken;

  /// Server defined URL for this resource (output only).
  core.String selfLink;

  ZoneViewsList();

  ZoneViewsList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"]
          .map((value) => new ResourceView.fromJson(value))
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

/// The response to a list resource request.
class ZoneViewsListResourcesResponse {
  /// The formatted JSON that is requested by the user.
  core.List<ListResourceResponseItem> items;

  /// The URL of a Compute Engine network to which the resources in the view
  /// belong.
  core.String network;

  /// A token used for pagination.
  core.String nextPageToken;

  ZoneViewsListResourcesResponse();

  ZoneViewsListResourcesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"]
          .map((value) => new ListResourceResponseItem.fromJson(value))
          .toList();
    }
    if (_json.containsKey("network")) {
      network = _json["network"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (network != null) {
      _json["network"] = network;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// The request to remove resources from the resource view.
class ZoneViewsRemoveResourcesRequest {
  /// The list of resources to be removed.
  core.List<core.String> resources;

  ZoneViewsRemoveResourcesRequest();

  ZoneViewsRemoveResourcesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("resources")) {
      resources = _json["resources"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (resources != null) {
      _json["resources"] = resources;
    }
    return _json;
  }
}

class ZoneViewsSetServiceRequest {
  /// The service information to be updated.
  core.List<ServiceEndpoint> endpoints;

  /// Fingerprint of the service information; a hash of the contents. This field
  /// is used for optimistic locking when updating the service entries.
  core.String fingerprint;

  /// The name of the resource if user wants to update the service information
  /// of the resource.
  core.String resourceName;

  ZoneViewsSetServiceRequest();

  ZoneViewsSetServiceRequest.fromJson(core.Map _json) {
    if (_json.containsKey("endpoints")) {
      endpoints = _json["endpoints"]
          .map((value) => new ServiceEndpoint.fromJson(value))
          .toList();
    }
    if (_json.containsKey("fingerprint")) {
      fingerprint = _json["fingerprint"];
    }
    if (_json.containsKey("resourceName")) {
      resourceName = _json["resourceName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endpoints != null) {
      _json["endpoints"] = endpoints.map((value) => (value).toJson()).toList();
    }
    if (fingerprint != null) {
      _json["fingerprint"] = fingerprint;
    }
    if (resourceName != null) {
      _json["resourceName"] = resourceName;
    }
    return _json;
  }
}
