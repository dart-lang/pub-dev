// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.resourceviews.v1beta1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client resourceviews/v1beta1';

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

  RegionViewsResourceApi get regionViews =>
      new RegionViewsResourceApi(_requester);
  ZoneViewsResourceApi get zoneViews => new ZoneViewsResourceApi(_requester);

  ResourceviewsApi(http.Client client,
      {core.String rootUrl: "https://www.googleapis.com/",
      core.String servicePath: "resourceviews/v1beta1/projects/"})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class RegionViewsResourceApi {
  final commons.ApiRequester _requester;

  RegionViewsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Add resources to the view.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectName] - The project name of the resource view.
  ///
  /// [region] - The region name of the resource view.
  ///
  /// [resourceViewName] - The name of the resource view.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future addresources(
      RegionViewsAddResourcesRequest request,
      core.String projectName,
      core.String region,
      core.String resourceViewName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (region == null) {
      throw new core.ArgumentError("Parameter region is required.");
    }
    if (resourceViewName == null) {
      throw new core.ArgumentError("Parameter resourceViewName is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/regions/' +
        commons.Escaper.ecapeVariable('$region') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceViewName') +
        '/addResources';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// Delete a resource view.
  ///
  /// Request parameters:
  ///
  /// [projectName] - The project name of the resource view.
  ///
  /// [region] - The region name of the resource view.
  ///
  /// [resourceViewName] - The name of the resource view.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future delete(core.String projectName, core.String region,
      core.String resourceViewName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (region == null) {
      throw new core.ArgumentError("Parameter region is required.");
    }
    if (resourceViewName == null) {
      throw new core.ArgumentError("Parameter resourceViewName is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/regions/' +
        commons.Escaper.ecapeVariable('$region') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceViewName');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// Get the information of a resource view.
  ///
  /// Request parameters:
  ///
  /// [projectName] - The project name of the resource view.
  ///
  /// [region] - The region name of the resource view.
  ///
  /// [resourceViewName] - The name of the resource view.
  ///
  /// Completes with a [ResourceView].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ResourceView> get(core.String projectName, core.String region,
      core.String resourceViewName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (region == null) {
      throw new core.ArgumentError("Parameter region is required.");
    }
    if (resourceViewName == null) {
      throw new core.ArgumentError("Parameter resourceViewName is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/regions/' +
        commons.Escaper.ecapeVariable('$region') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceViewName');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ResourceView.fromJson(data));
  }

  /// Create a resource view.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectName] - The project name of the resource view.
  ///
  /// [region] - The region name of the resource view.
  ///
  /// Completes with a [RegionViewsInsertResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<RegionViewsInsertResponse> insert(
      ResourceView request, core.String projectName, core.String region) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (region == null) {
      throw new core.ArgumentError("Parameter region is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/regions/' +
        commons.Escaper.ecapeVariable('$region') +
        '/resourceViews';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new RegionViewsInsertResponse.fromJson(data));
  }

  /// List resource views.
  ///
  /// Request parameters:
  ///
  /// [projectName] - The project name of the resource view.
  ///
  /// [region] - The region name of the resource view.
  ///
  /// [maxResults] - Maximum count of results to be returned. Acceptable values
  /// are 0 to 5000, inclusive. (Default: 5000)
  /// Value must be between "0" and "5000".
  ///
  /// [pageToken] - Specifies a nextPageToken returned by a previous list
  /// request. This token can be used to request the next page of results from a
  /// previous list request.
  ///
  /// Completes with a [RegionViewsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<RegionViewsListResponse> list(
      core.String projectName, core.String region,
      {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (region == null) {
      throw new core.ArgumentError("Parameter region is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/regions/' +
        commons.Escaper.ecapeVariable('$region') +
        '/resourceViews';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new RegionViewsListResponse.fromJson(data));
  }

  /// List the resources in the view.
  ///
  /// Request parameters:
  ///
  /// [projectName] - The project name of the resource view.
  ///
  /// [region] - The region name of the resource view.
  ///
  /// [resourceViewName] - The name of the resource view.
  ///
  /// [maxResults] - Maximum count of results to be returned. Acceptable values
  /// are 0 to 5000, inclusive. (Default: 5000)
  /// Value must be between "0" and "5000".
  ///
  /// [pageToken] - Specifies a nextPageToken returned by a previous list
  /// request. This token can be used to request the next page of results from a
  /// previous list request.
  ///
  /// Completes with a [RegionViewsListResourcesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<RegionViewsListResourcesResponse> listresources(
      core.String projectName, core.String region, core.String resourceViewName,
      {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (region == null) {
      throw new core.ArgumentError("Parameter region is required.");
    }
    if (resourceViewName == null) {
      throw new core.ArgumentError("Parameter resourceViewName is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/regions/' +
        commons.Escaper.ecapeVariable('$region') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceViewName') +
        '/resources';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new RegionViewsListResourcesResponse.fromJson(data));
  }

  /// Remove resources from the view.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectName] - The project name of the resource view.
  ///
  /// [region] - The region name of the resource view.
  ///
  /// [resourceViewName] - The name of the resource view.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future removeresources(
      RegionViewsRemoveResourcesRequest request,
      core.String projectName,
      core.String region,
      core.String resourceViewName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (region == null) {
      throw new core.ArgumentError("Parameter region is required.");
    }
    if (resourceViewName == null) {
      throw new core.ArgumentError("Parameter resourceViewName is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/regions/' +
        commons.Escaper.ecapeVariable('$region') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceViewName') +
        '/removeResources';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
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
  /// [projectName] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [resourceViewName] - The name of the resource view.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future addresources(ZoneViewsAddResourcesRequest request,
      core.String projectName, core.String zone, core.String resourceViewName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (resourceViewName == null) {
      throw new core.ArgumentError("Parameter resourceViewName is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceViewName') +
        '/addResources';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// Delete a resource view.
  ///
  /// Request parameters:
  ///
  /// [projectName] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [resourceViewName] - The name of the resource view.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future delete(
      core.String projectName, core.String zone, core.String resourceViewName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (resourceViewName == null) {
      throw new core.ArgumentError("Parameter resourceViewName is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceViewName');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// Get the information of a zonal resource view.
  ///
  /// Request parameters:
  ///
  /// [projectName] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [resourceViewName] - The name of the resource view.
  ///
  /// Completes with a [ResourceView].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ResourceView> get(
      core.String projectName, core.String zone, core.String resourceViewName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (resourceViewName == null) {
      throw new core.ArgumentError("Parameter resourceViewName is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceViewName');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ResourceView.fromJson(data));
  }

  /// Create a resource view.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectName] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// Completes with a [ZoneViewsInsertResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ZoneViewsInsertResponse> insert(
      ResourceView request, core.String projectName, core.String zone) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ZoneViewsInsertResponse.fromJson(data));
  }

  /// List resource views.
  ///
  /// Request parameters:
  ///
  /// [projectName] - The project name of the resource view.
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
  /// Completes with a [ZoneViewsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ZoneViewsListResponse> list(
      core.String projectName, core.String zone,
      {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
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

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ZoneViewsListResponse.fromJson(data));
  }

  /// List the resources of the resource view.
  ///
  /// Request parameters:
  ///
  /// [projectName] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [resourceViewName] - The name of the resource view.
  ///
  /// [maxResults] - Maximum count of results to be returned. Acceptable values
  /// are 0 to 5000, inclusive. (Default: 5000)
  /// Value must be between "0" and "5000".
  ///
  /// [pageToken] - Specifies a nextPageToken returned by a previous list
  /// request. This token can be used to request the next page of results from a
  /// previous list request.
  ///
  /// Completes with a [ZoneViewsListResourcesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ZoneViewsListResourcesResponse> listresources(
      core.String projectName, core.String zone, core.String resourceViewName,
      {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (resourceViewName == null) {
      throw new core.ArgumentError("Parameter resourceViewName is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceViewName') +
        '/resources';

    var _response = _requester.request(_url, "POST",
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
  /// [projectName] - The project name of the resource view.
  ///
  /// [zone] - The zone name of the resource view.
  ///
  /// [resourceViewName] - The name of the resource view.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future removeresources(ZoneViewsRemoveResourcesRequest request,
      core.String projectName, core.String zone, core.String resourceViewName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (zone == null) {
      throw new core.ArgumentError("Parameter zone is required.");
    }
    if (resourceViewName == null) {
      throw new core.ArgumentError("Parameter resourceViewName is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$projectName') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/resourceViews/' +
        commons.Escaper.ecapeVariable('$resourceViewName') +
        '/removeResources';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
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

/// The request to add resources to the resource view.
class RegionViewsAddResourcesRequest {
  /// The list of resources to be added.
  core.List<core.String> resources;

  RegionViewsAddResourcesRequest();

  RegionViewsAddResourcesRequest.fromJson(core.Map _json) {
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

/// The response to a resource view insert request.
class RegionViewsInsertResponse {
  /// The resource view object inserted.
  ResourceView resource;

  RegionViewsInsertResponse();

  RegionViewsInsertResponse.fromJson(core.Map _json) {
    if (_json.containsKey("resource")) {
      resource = new ResourceView.fromJson(_json["resource"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (resource != null) {
      _json["resource"] = (resource).toJson();
    }
    return _json;
  }
}

/// The response to the list resource request.
class RegionViewsListResourcesResponse {
  /// The resources in the view.
  core.List<core.String> members;

  /// A token used for pagination.
  core.String nextPageToken;

  RegionViewsListResourcesResponse();

  RegionViewsListResourcesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("members")) {
      members = _json["members"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (members != null) {
      _json["members"] = members;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// The response to the list resource view request.
class RegionViewsListResponse {
  /// A token used for pagination.
  core.String nextPageToken;

  /// The list of resource views that meet the criteria.
  core.List<ResourceView> resourceViews;

  RegionViewsListResponse();

  RegionViewsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resourceViews")) {
      resourceViews = _json["resourceViews"]
          .map((value) => new ResourceView.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resourceViews != null) {
      _json["resourceViews"] =
          resourceViews.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// The request to remove resources from the resource view.
class RegionViewsRemoveResourcesRequest {
  /// The list of resources to be removed.
  core.List<core.String> resources;

  RegionViewsRemoveResourcesRequest();

  RegionViewsRemoveResourcesRequest.fromJson(core.Map _json) {
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

/// The resource view object.
class ResourceView {
  /// The creation time of the resource view.
  core.String creationTime;

  /// The detailed description of the resource view.
  core.String description;

  /// [Output Only] The ID of the resource view.
  core.String id;

  /// Type of the resource.
  core.String kind;

  /// The labels for events.
  core.List<Label> labels;

  /// The last modified time of the view. Not supported yet.
  core.String lastModified;

  /// A list of all resources in the resource view.
  core.List<core.String> members;

  /// The name of the resource view.
  core.String name;

  /// The total number of resources in the resource view.
  core.int numMembers;

  /// [Output Only] A self-link to the resource view.
  core.String selfLink;

  ResourceView();

  ResourceView.fromJson(core.Map _json) {
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
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
    if (_json.containsKey("lastModified")) {
      lastModified = _json["lastModified"];
    }
    if (_json.containsKey("members")) {
      members = _json["members"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("numMembers")) {
      numMembers = _json["numMembers"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (description != null) {
      _json["description"] = description;
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
    if (lastModified != null) {
      _json["lastModified"] = lastModified;
    }
    if (members != null) {
      _json["members"] = members;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (numMembers != null) {
      _json["numMembers"] = numMembers;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
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

/// The response to an insert request.
class ZoneViewsInsertResponse {
  /// The resource view object that has been inserted.
  ResourceView resource;

  ZoneViewsInsertResponse();

  ZoneViewsInsertResponse.fromJson(core.Map _json) {
    if (_json.containsKey("resource")) {
      resource = new ResourceView.fromJson(_json["resource"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (resource != null) {
      _json["resource"] = (resource).toJson();
    }
    return _json;
  }
}

/// The response to a list resource request.
class ZoneViewsListResourcesResponse {
  /// The full URL of resources in the view.
  core.List<core.String> members;

  /// A token used for pagination.
  core.String nextPageToken;

  ZoneViewsListResourcesResponse();

  ZoneViewsListResourcesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("members")) {
      members = _json["members"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (members != null) {
      _json["members"] = members;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// The response to a list request.
class ZoneViewsListResponse {
  /// A token used for pagination.
  core.String nextPageToken;

  /// The result that contains all resource views that meet the criteria.
  core.List<ResourceView> resourceViews;

  ZoneViewsListResponse();

  ZoneViewsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resourceViews")) {
      resourceViews = _json["resourceViews"]
          .map((value) => new ResourceView.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resourceViews != null) {
      _json["resourceViews"] =
          resourceViews.map((value) => (value).toJson()).toList();
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
