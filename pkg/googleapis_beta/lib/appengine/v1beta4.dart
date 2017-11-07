// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.appengine.v1beta4;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client appengine/v1beta4';

/// The App Engine Admin API enables developers to provision and manage their
/// App Engine applications.
class AppengineApi {
  /// View and manage your applications deployed on Google App Engine
  static const AppengineAdminScope =
      "https://www.googleapis.com/auth/appengine.admin";

  /// View and manage your data across Google Cloud Platform services
  static const CloudPlatformScope =
      "https://www.googleapis.com/auth/cloud-platform";

  /// View your data across Google Cloud Platform services
  static const CloudPlatformReadOnlyScope =
      "https://www.googleapis.com/auth/cloud-platform.read-only";

  final commons.ApiRequester _requester;

  AppsResourceApi get apps => new AppsResourceApi(_requester);

  AppengineApi(http.Client client,
      {core.String rootUrl: "https://appengine.googleapis.com/",
      core.String servicePath: ""})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class AppsResourceApi {
  final commons.ApiRequester _requester;

  AppsLocationsResourceApi get locations =>
      new AppsLocationsResourceApi(_requester);
  AppsModulesResourceApi get modules => new AppsModulesResourceApi(_requester);
  AppsOperationsResourceApi get operations =>
      new AppsOperationsResourceApi(_requester);

  AppsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Creates an App Engine application for a Google Cloud Platform project.
  /// Required fields:
  /// id - The ID of the target Cloud Platform project.
  /// location - The region (https://cloud.google.com/appengine/docs/locations)
  /// where you want the App Engine application located.For more information
  /// about App Engine applications, see Managing Projects, Applications, and
  /// Billing (https://cloud.google.com/appengine/docs/python/console/).
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> create(Application request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1beta4/apps';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Gets information about an application.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the application to get. Example:
  /// apps/myapp.
  ///
  /// [ensureResourcesExist] - Certain resources associated with an application
  /// are created on-demand. Controls whether these resources should be created
  /// when performing the GET operation. If specified and any resources could
  /// not be created, the request will fail with an error code. Additionally,
  /// this parameter can cause the request to take longer to complete.
  ///
  /// Completes with a [Application].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Application> get(core.String appsId,
      {core.bool ensureResourcesExist}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (ensureResourcesExist != null) {
      _queryParams["ensureResourcesExist"] = ["${ensureResourcesExist}"];
    }

    _url = 'v1beta4/apps/' + commons.Escaper.ecapeVariable('$appsId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Application.fromJson(data));
  }

  /// Updates the specified Application resource. You can update the following
  /// fields:
  /// auth_domain
  /// (https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1beta4/apps#Application.FIELDS.auth_domain)
  /// default_cookie_expiration
  /// (https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1beta4/apps#Application.FIELDS.default_cookie_expiration)
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the Application resource to update.
  /// Example: apps/myapp.
  ///
  /// [mask] - Standard field mask for the set of fields to be updated.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> patch(Application request, core.String appsId,
      {core.String mask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (mask != null) {
      _queryParams["mask"] = [mask];
    }

    _url = 'v1beta4/apps/' + commons.Escaper.ecapeVariable('$appsId');

    var _response = _requester.request(_url, "PATCH",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }
}

class AppsLocationsResourceApi {
  final commons.ApiRequester _requester;

  AppsLocationsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Get information about a location.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Resource name for the location.
  ///
  /// [locationsId] - Part of `name`. See documentation of `appsId`.
  ///
  /// Completes with a [Location].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Location> get(core.String appsId, core.String locationsId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (locationsId == null) {
      throw new core.ArgumentError("Parameter locationsId is required.");
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/locations/' +
        commons.Escaper.ecapeVariable('$locationsId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Location.fromJson(data));
  }

  /// Lists information about the supported locations for this service.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. The resource that owns the locations
  /// collection, if applicable.
  ///
  /// [pageToken] - The standard list page token.
  ///
  /// [pageSize] - The standard list page size.
  ///
  /// [filter] - The standard list filter.
  ///
  /// Completes with a [ListLocationsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListLocationsResponse> list(core.String appsId,
      {core.String pageToken, core.int pageSize, core.String filter}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/locations';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListLocationsResponse.fromJson(data));
  }
}

class AppsModulesResourceApi {
  final commons.ApiRequester _requester;

  AppsModulesVersionsResourceApi get versions =>
      new AppsModulesVersionsResourceApi(_requester);

  AppsModulesResourceApi(commons.ApiRequester client) : _requester = client;

  /// Deletes the specified module and all enclosed versions.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource requested. Example:
  /// apps/myapp/modules/default.
  ///
  /// [modulesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> delete(core.String appsId, core.String modulesId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (modulesId == null) {
      throw new core.ArgumentError("Parameter modulesId is required.");
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/modules/' +
        commons.Escaper.ecapeVariable('$modulesId');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Gets the current configuration of the specified module.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource requested. Example:
  /// apps/myapp/modules/default.
  ///
  /// [modulesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// Completes with a [Module].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Module> get(core.String appsId, core.String modulesId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (modulesId == null) {
      throw new core.ArgumentError("Parameter modulesId is required.");
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/modules/' +
        commons.Escaper.ecapeVariable('$modulesId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Module.fromJson(data));
  }

  /// Lists all the modules in the application.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource requested. Example:
  /// apps/myapp.
  ///
  /// [pageToken] - Continuation token for fetching the next page of results.
  ///
  /// [pageSize] - Maximum results to return per page.
  ///
  /// Completes with a [ListModulesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListModulesResponse> list(core.String appsId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url =
        'v1beta4/apps/' + commons.Escaper.ecapeVariable('$appsId') + '/modules';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListModulesResponse.fromJson(data));
  }

  /// Updates the configuration of the specified module.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource to update. Example:
  /// apps/myapp/modules/default.
  ///
  /// [modulesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [migrateTraffic] - Set to true to gradually shift traffic to one or more
  /// versions that you specify. By default, traffic is shifted immediately. For
  /// gradual traffic migration, the target versions must be located within
  /// instances that are configured for both warmup requests
  /// (https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1beta4/apps.modules.versions#inboundservicetype)
  /// and automatic scaling
  /// (https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1beta4/apps.modules.versions#automaticscaling).
  /// You must specify the shardBy
  /// (https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1beta4/apps.modules#shardby)
  /// field in the Module resource. Gradual traffic migration is not supported
  /// in the App Engine flexible environment. For examples, see Migrating and
  /// Splitting Traffic
  /// (https://cloud.google.com/appengine/docs/admin-api/migrating-splitting-traffic).
  ///
  /// [mask] - Standard field mask for the set of fields to be updated.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> patch(
      Module request, core.String appsId, core.String modulesId,
      {core.bool migrateTraffic, core.String mask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (modulesId == null) {
      throw new core.ArgumentError("Parameter modulesId is required.");
    }
    if (migrateTraffic != null) {
      _queryParams["migrateTraffic"] = ["${migrateTraffic}"];
    }
    if (mask != null) {
      _queryParams["mask"] = [mask];
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/modules/' +
        commons.Escaper.ecapeVariable('$modulesId');

    var _response = _requester.request(_url, "PATCH",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }
}

class AppsModulesVersionsResourceApi {
  final commons.ApiRequester _requester;

  AppsModulesVersionsInstancesResourceApi get instances =>
      new AppsModulesVersionsInstancesResourceApi(_requester);

  AppsModulesVersionsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Deploys code and resource files to a new version.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource to update. Example:
  /// apps/myapp/modules/default.
  ///
  /// [modulesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> create(
      Version request, core.String appsId, core.String modulesId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (modulesId == null) {
      throw new core.ArgumentError("Parameter modulesId is required.");
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/modules/' +
        commons.Escaper.ecapeVariable('$modulesId') +
        '/versions';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Deletes an existing version.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource requested. Example:
  /// apps/myapp/modules/default/versions/v1.
  ///
  /// [modulesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [versionsId] - Part of `name`. See documentation of `appsId`.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> delete(
      core.String appsId, core.String modulesId, core.String versionsId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (modulesId == null) {
      throw new core.ArgumentError("Parameter modulesId is required.");
    }
    if (versionsId == null) {
      throw new core.ArgumentError("Parameter versionsId is required.");
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/modules/' +
        commons.Escaper.ecapeVariable('$modulesId') +
        '/versions/' +
        commons.Escaper.ecapeVariable('$versionsId');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Gets the specified Version resource. By default, only a BASIC_VIEW will be
  /// returned. Specify the FULL_VIEW parameter to get the full resource.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource requested. Example:
  /// apps/myapp/modules/default/versions/v1.
  ///
  /// [modulesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [versionsId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [view] - Controls the set of fields returned in the Get response.
  /// Possible string values are:
  /// - "BASIC" : A BASIC.
  /// - "FULL" : A FULL.
  ///
  /// Completes with a [Version].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Version> get(
      core.String appsId, core.String modulesId, core.String versionsId,
      {core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (modulesId == null) {
      throw new core.ArgumentError("Parameter modulesId is required.");
    }
    if (versionsId == null) {
      throw new core.ArgumentError("Parameter versionsId is required.");
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/modules/' +
        commons.Escaper.ecapeVariable('$modulesId') +
        '/versions/' +
        commons.Escaper.ecapeVariable('$versionsId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Version.fromJson(data));
  }

  /// Lists the versions of a module.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource requested. Example:
  /// apps/myapp/modules/default.
  ///
  /// [modulesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [pageSize] - Maximum results to return per page.
  ///
  /// [view] - Controls the set of fields returned in the List response.
  /// Possible string values are:
  /// - "BASIC" : A BASIC.
  /// - "FULL" : A FULL.
  ///
  /// [pageToken] - Continuation token for fetching the next page of results.
  ///
  /// Completes with a [ListVersionsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListVersionsResponse> list(
      core.String appsId, core.String modulesId,
      {core.int pageSize, core.String view, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (modulesId == null) {
      throw new core.ArgumentError("Parameter modulesId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/modules/' +
        commons.Escaper.ecapeVariable('$modulesId') +
        '/versions';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListVersionsResponse.fromJson(data));
  }

  /// Updates the specified Version resource. You can specify the following
  /// fields depending on the App Engine environment and type of scaling that
  /// the version resource uses:
  /// serving_status
  /// (https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1beta4/apps.modules.versions#Version.FIELDS.serving_status):
  /// For Version resources that use basic scaling, manual scaling, or run in
  /// the App Engine flexible environment.
  /// instance_class
  /// (https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1beta4/apps.modules.versions#Version.FIELDS.instance_class):
  /// For Version resources that run in the App Engine standard environment.
  /// automatic_scaling.min_idle_instances
  /// (https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1beta4/apps.modules.versions#Version.FIELDS.automatic_scaling):
  /// For Version resources that use automatic scaling and run in the App
  /// Engine standard environment.
  /// automatic_scaling.max_idle_instances
  /// (https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1beta4/apps.modules.versions#Version.FIELDS.automatic_scaling):
  /// For Version resources that use automatic scaling and run in the App
  /// Engine standard environment.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource to update. Example:
  /// apps/myapp/modules/default/versions/1.
  ///
  /// [modulesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [versionsId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [mask] - Standard field mask for the set of fields to be updated.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> patch(Version request, core.String appsId,
      core.String modulesId, core.String versionsId,
      {core.String mask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (modulesId == null) {
      throw new core.ArgumentError("Parameter modulesId is required.");
    }
    if (versionsId == null) {
      throw new core.ArgumentError("Parameter versionsId is required.");
    }
    if (mask != null) {
      _queryParams["mask"] = [mask];
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/modules/' +
        commons.Escaper.ecapeVariable('$modulesId') +
        '/versions/' +
        commons.Escaper.ecapeVariable('$versionsId');

    var _response = _requester.request(_url, "PATCH",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }
}

class AppsModulesVersionsInstancesResourceApi {
  final commons.ApiRequester _requester;

  AppsModulesVersionsInstancesResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Enables debugging on a VM instance. This allows you to use the SSH command
  /// to connect to the virtual machine where the instance lives. While in
  /// "debug mode", the instance continues to serve live traffic. You should
  /// delete the instance when you are done debugging and then allow the system
  /// to take over and determine if another instance should be started.Only
  /// applicable for instances in App Engine flexible environment.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource requested. Example:
  /// apps/myapp/modules/default/versions/v1/instances/instance-1.
  ///
  /// [modulesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [versionsId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [instancesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> debug(
      DebugInstanceRequest request,
      core.String appsId,
      core.String modulesId,
      core.String versionsId,
      core.String instancesId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (modulesId == null) {
      throw new core.ArgumentError("Parameter modulesId is required.");
    }
    if (versionsId == null) {
      throw new core.ArgumentError("Parameter versionsId is required.");
    }
    if (instancesId == null) {
      throw new core.ArgumentError("Parameter instancesId is required.");
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/modules/' +
        commons.Escaper.ecapeVariable('$modulesId') +
        '/versions/' +
        commons.Escaper.ecapeVariable('$versionsId') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instancesId') +
        ':debug';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Stops a running instance.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource requested. Example:
  /// apps/myapp/modules/default/versions/v1/instances/instance-1.
  ///
  /// [modulesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [versionsId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [instancesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> delete(core.String appsId, core.String modulesId,
      core.String versionsId, core.String instancesId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (modulesId == null) {
      throw new core.ArgumentError("Parameter modulesId is required.");
    }
    if (versionsId == null) {
      throw new core.ArgumentError("Parameter versionsId is required.");
    }
    if (instancesId == null) {
      throw new core.ArgumentError("Parameter instancesId is required.");
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/modules/' +
        commons.Escaper.ecapeVariable('$modulesId') +
        '/versions/' +
        commons.Escaper.ecapeVariable('$versionsId') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instancesId');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Gets instance information.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource requested. Example:
  /// apps/myapp/modules/default/versions/v1/instances/instance-1.
  ///
  /// [modulesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [versionsId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [instancesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// Completes with a [Instance].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Instance> get(core.String appsId, core.String modulesId,
      core.String versionsId, core.String instancesId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (modulesId == null) {
      throw new core.ArgumentError("Parameter modulesId is required.");
    }
    if (versionsId == null) {
      throw new core.ArgumentError("Parameter versionsId is required.");
    }
    if (instancesId == null) {
      throw new core.ArgumentError("Parameter instancesId is required.");
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/modules/' +
        commons.Escaper.ecapeVariable('$modulesId') +
        '/versions/' +
        commons.Escaper.ecapeVariable('$versionsId') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instancesId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Instance.fromJson(data));
  }

  /// Lists the instances of a version.Tip: To aggregate details about instances
  /// over time, see the Stackdriver Monitoring API
  /// (https://cloud.google.com/monitoring/api/ref_v3/rest/v3/projects.timeSeries/list).
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. Name of the resource requested. Example:
  /// apps/myapp/modules/default/versions/v1.
  ///
  /// [modulesId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [versionsId] - Part of `name`. See documentation of `appsId`.
  ///
  /// [pageToken] - Continuation token for fetching the next page of results.
  ///
  /// [pageSize] - Maximum results to return per page.
  ///
  /// Completes with a [ListInstancesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListInstancesResponse> list(
      core.String appsId, core.String modulesId, core.String versionsId,
      {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (modulesId == null) {
      throw new core.ArgumentError("Parameter modulesId is required.");
    }
    if (versionsId == null) {
      throw new core.ArgumentError("Parameter versionsId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/modules/' +
        commons.Escaper.ecapeVariable('$modulesId') +
        '/versions/' +
        commons.Escaper.ecapeVariable('$versionsId') +
        '/instances';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListInstancesResponse.fromJson(data));
  }
}

class AppsOperationsResourceApi {
  final commons.ApiRequester _requester;

  AppsOperationsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Gets the latest state of a long-running operation. Clients can use this
  /// method to poll the operation result at intervals as recommended by the API
  /// service.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. The name of the operation resource.
  ///
  /// [operationsId] - Part of `name`. See documentation of `appsId`.
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> get(core.String appsId, core.String operationsId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (operationsId == null) {
      throw new core.ArgumentError("Parameter operationsId is required.");
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/operations/' +
        commons.Escaper.ecapeVariable('$operationsId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Lists operations that match the specified filter in the request. If the
  /// server doesn't support this method, it returns UNIMPLEMENTED.NOTE: the
  /// name binding allows API services to override the binding to use different
  /// resource name schemes, such as users / * /operations. To override the
  /// binding, API services can add a binding such as "/v1/{name=users / *
  /// }/operations" to their service configuration. For backwards compatibility,
  /// the default name includes the operations collection id, however overriding
  /// users must ensure the name binding is the parent resource, without the
  /// operations collection id.
  ///
  /// Request parameters:
  ///
  /// [appsId] - Part of `name`. The name of the operation's parent resource.
  ///
  /// [filter] - The standard list filter.
  ///
  /// [pageToken] - The standard list page token.
  ///
  /// [pageSize] - The standard list page size.
  ///
  /// Completes with a [ListOperationsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListOperationsResponse> list(core.String appsId,
      {core.String filter, core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appsId == null) {
      throw new core.ArgumentError("Parameter appsId is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1beta4/apps/' +
        commons.Escaper.ecapeVariable('$appsId') +
        '/operations';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListOperationsResponse.fromJson(data));
  }
}

/// Google Cloud Endpoints
/// (https://cloud.google.com/appengine/docs/python/endpoints/) configuration
/// for API handlers.
class ApiConfigHandler {
  /// Action to take when users access resources that require authentication.
  /// Defaults to redirect.
  /// Possible string values are:
  /// - "AUTH_FAIL_ACTION_UNSPECIFIED" : Not specified.
  /// AUTH_FAIL_ACTION_REDIRECT is assumed.
  /// - "AUTH_FAIL_ACTION_REDIRECT" : Redirects user to "accounts.google.com".
  /// The user is redirected back to the application URL after signing in or
  /// creating an account.
  /// - "AUTH_FAIL_ACTION_UNAUTHORIZED" : Rejects request with a 401 HTTP status
  /// code and an error message.
  core.String authFailAction;

  /// Level of login required to access this resource. Defaults to optional.
  /// Possible string values are:
  /// - "LOGIN_UNSPECIFIED" : Not specified. LOGIN_OPTIONAL is assumed.
  /// - "LOGIN_OPTIONAL" : Does not require that the user is signed in.
  /// - "LOGIN_ADMIN" : If the user is not signed in, the auth_fail_action is
  /// taken. In addition, if the user is not an administrator for the
  /// application, they are given an error message regardless of
  /// auth_fail_action. If the user is an administrator, the handler proceeds.
  /// - "LOGIN_REQUIRED" : If the user has signed in, the handler proceeds
  /// normally. Otherwise, the auth_fail_action is taken.
  core.String login;

  /// Path to the script from the application root directory.
  core.String script;

  /// Security (HTTPS) enforcement for this URL.
  /// Possible string values are:
  /// - "SECURE_UNSPECIFIED" : Not specified.
  /// - "SECURE_DEFAULT" : Both HTTP and HTTPS requests with URLs that match the
  /// handler succeed without redirects. The application can examine the request
  /// to determine which protocol was used, and respond accordingly.
  /// - "SECURE_NEVER" : Requests for a URL that match this handler that use
  /// HTTPS are automatically redirected to the HTTP equivalent URL.
  /// - "SECURE_OPTIONAL" : Both HTTP and HTTPS requests with URLs that match
  /// the handler succeed without redirects. The application can examine the
  /// request to determine which protocol was used and respond accordingly.
  /// - "SECURE_ALWAYS" : Requests for a URL that match this handler that do not
  /// use HTTPS are automatically redirected to the HTTPS URL with the same
  /// path. Query parameters are reserved for the redirect.
  core.String securityLevel;

  /// URL to serve the endpoint at.
  core.String url;

  ApiConfigHandler();

  ApiConfigHandler.fromJson(core.Map _json) {
    if (_json.containsKey("authFailAction")) {
      authFailAction = _json["authFailAction"];
    }
    if (_json.containsKey("login")) {
      login = _json["login"];
    }
    if (_json.containsKey("script")) {
      script = _json["script"];
    }
    if (_json.containsKey("securityLevel")) {
      securityLevel = _json["securityLevel"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (authFailAction != null) {
      _json["authFailAction"] = authFailAction;
    }
    if (login != null) {
      _json["login"] = login;
    }
    if (script != null) {
      _json["script"] = script;
    }
    if (securityLevel != null) {
      _json["securityLevel"] = securityLevel;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/// Uses Google Cloud Endpoints to handle requests.
class ApiEndpointHandler {
  /// Path to the script from the application root directory.
  core.String scriptPath;

  ApiEndpointHandler();

  ApiEndpointHandler.fromJson(core.Map _json) {
    if (_json.containsKey("scriptPath")) {
      scriptPath = _json["scriptPath"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (scriptPath != null) {
      _json["scriptPath"] = scriptPath;
    }
    return _json;
  }
}

/// An Application resource contains the top-level configuration of an App
/// Engine application.
class Application {
  /// Google Apps authentication domain that controls which users can access
  /// this application.Defaults to open access for any Google Account.
  core.String authDomain;

  /// Google Cloud Storage bucket that can be used for storing files associated
  /// with this application. This bucket is associated with the application and
  /// can be used by the gcloud deployment commands.@OutputOnly
  core.String codeBucket;

  /// Google Cloud Storage bucket that can be used by this application to store
  /// content.@OutputOnly
  core.String defaultBucket;

  /// Cookie expiration policy for this application.
  core.String defaultCookieExpiration;

  /// Hostname used to reach the application, as resolved by App
  /// Engine.@OutputOnly
  core.String defaultHostname;

  /// HTTP path dispatch rules for requests to the application that do not
  /// explicitly target a module or version. Rules are
  /// order-dependent.@OutputOnly
  core.List<UrlDispatchRule> dispatchRules;
  IdentityAwareProxy iap;

  /// Identifier of the Application resource. This identifier is equivalent to
  /// the project ID of the Google Cloud Platform project where you want to
  /// deploy your application. Example: myapp.
  core.String id;

  /// Location from which this application will be run. Application instances
  /// will run out of data centers in the chosen location, which is also where
  /// all of the application's end user content is stored.Defaults to
  /// us-central.Options are:us-central - Central USeurope-west - Western
  /// Europeus-east1 - Eastern US
  core.String location;

  /// Full path to the Application resource in the API. Example:
  /// apps/myapp.@OutputOnly
  core.String name;

  Application();

  Application.fromJson(core.Map _json) {
    if (_json.containsKey("authDomain")) {
      authDomain = _json["authDomain"];
    }
    if (_json.containsKey("codeBucket")) {
      codeBucket = _json["codeBucket"];
    }
    if (_json.containsKey("defaultBucket")) {
      defaultBucket = _json["defaultBucket"];
    }
    if (_json.containsKey("defaultCookieExpiration")) {
      defaultCookieExpiration = _json["defaultCookieExpiration"];
    }
    if (_json.containsKey("defaultHostname")) {
      defaultHostname = _json["defaultHostname"];
    }
    if (_json.containsKey("dispatchRules")) {
      dispatchRules = _json["dispatchRules"]
          .map((value) => new UrlDispatchRule.fromJson(value))
          .toList();
    }
    if (_json.containsKey("iap")) {
      iap = new IdentityAwareProxy.fromJson(_json["iap"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
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
    if (authDomain != null) {
      _json["authDomain"] = authDomain;
    }
    if (codeBucket != null) {
      _json["codeBucket"] = codeBucket;
    }
    if (defaultBucket != null) {
      _json["defaultBucket"] = defaultBucket;
    }
    if (defaultCookieExpiration != null) {
      _json["defaultCookieExpiration"] = defaultCookieExpiration;
    }
    if (defaultHostname != null) {
      _json["defaultHostname"] = defaultHostname;
    }
    if (dispatchRules != null) {
      _json["dispatchRules"] =
          dispatchRules.map((value) => (value).toJson()).toList();
    }
    if (iap != null) {
      _json["iap"] = (iap).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/// Automatic scaling is based on request rate, response latencies, and other
/// application metrics.
class AutomaticScaling {
  /// Amount of time that the Autoscaler
  /// (https://cloud.google.com/compute/docs/autoscaler/) should wait between
  /// changes to the number of virtual machines. Only applicable for VM
  /// runtimes.
  core.String coolDownPeriod;

  /// Target scaling by CPU usage.
  CpuUtilization cpuUtilization;

  /// Target scaling by disk usage.
  DiskUtilization diskUtilization;

  /// Number of concurrent requests an automatic scaling instance can accept
  /// before the scheduler spawns a new instance.Defaults to a runtime-specific
  /// value.
  core.int maxConcurrentRequests;

  /// Maximum number of idle instances that should be maintained for this
  /// version.
  core.int maxIdleInstances;

  /// Maximum amount of time that a request should wait in the pending queue
  /// before starting a new instance to handle it.
  core.String maxPendingLatency;

  /// Maximum number of instances that should be started to handle requests.
  core.int maxTotalInstances;

  /// Minimum number of idle instances that should be maintained for this
  /// version. Only applicable for the default version of a module.
  core.int minIdleInstances;

  /// Minimum amount of time a request should wait in the pending queue before
  /// starting a new instance to handle it.
  core.String minPendingLatency;

  /// Minimum number of instances that should be maintained for this version.
  core.int minTotalInstances;

  /// Target scaling by network usage.
  NetworkUtilization networkUtilization;

  /// Target scaling by request utilization.
  RequestUtilization requestUtilization;

  AutomaticScaling();

  AutomaticScaling.fromJson(core.Map _json) {
    if (_json.containsKey("coolDownPeriod")) {
      coolDownPeriod = _json["coolDownPeriod"];
    }
    if (_json.containsKey("cpuUtilization")) {
      cpuUtilization = new CpuUtilization.fromJson(_json["cpuUtilization"]);
    }
    if (_json.containsKey("diskUtilization")) {
      diskUtilization = new DiskUtilization.fromJson(_json["diskUtilization"]);
    }
    if (_json.containsKey("maxConcurrentRequests")) {
      maxConcurrentRequests = _json["maxConcurrentRequests"];
    }
    if (_json.containsKey("maxIdleInstances")) {
      maxIdleInstances = _json["maxIdleInstances"];
    }
    if (_json.containsKey("maxPendingLatency")) {
      maxPendingLatency = _json["maxPendingLatency"];
    }
    if (_json.containsKey("maxTotalInstances")) {
      maxTotalInstances = _json["maxTotalInstances"];
    }
    if (_json.containsKey("minIdleInstances")) {
      minIdleInstances = _json["minIdleInstances"];
    }
    if (_json.containsKey("minPendingLatency")) {
      minPendingLatency = _json["minPendingLatency"];
    }
    if (_json.containsKey("minTotalInstances")) {
      minTotalInstances = _json["minTotalInstances"];
    }
    if (_json.containsKey("networkUtilization")) {
      networkUtilization =
          new NetworkUtilization.fromJson(_json["networkUtilization"]);
    }
    if (_json.containsKey("requestUtilization")) {
      requestUtilization =
          new RequestUtilization.fromJson(_json["requestUtilization"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (coolDownPeriod != null) {
      _json["coolDownPeriod"] = coolDownPeriod;
    }
    if (cpuUtilization != null) {
      _json["cpuUtilization"] = (cpuUtilization).toJson();
    }
    if (diskUtilization != null) {
      _json["diskUtilization"] = (diskUtilization).toJson();
    }
    if (maxConcurrentRequests != null) {
      _json["maxConcurrentRequests"] = maxConcurrentRequests;
    }
    if (maxIdleInstances != null) {
      _json["maxIdleInstances"] = maxIdleInstances;
    }
    if (maxPendingLatency != null) {
      _json["maxPendingLatency"] = maxPendingLatency;
    }
    if (maxTotalInstances != null) {
      _json["maxTotalInstances"] = maxTotalInstances;
    }
    if (minIdleInstances != null) {
      _json["minIdleInstances"] = minIdleInstances;
    }
    if (minPendingLatency != null) {
      _json["minPendingLatency"] = minPendingLatency;
    }
    if (minTotalInstances != null) {
      _json["minTotalInstances"] = minTotalInstances;
    }
    if (networkUtilization != null) {
      _json["networkUtilization"] = (networkUtilization).toJson();
    }
    if (requestUtilization != null) {
      _json["requestUtilization"] = (requestUtilization).toJson();
    }
    return _json;
  }
}

/// A module with basic scaling will create an instance when the application
/// receives a request. The instance will be turned down when the app becomes
/// idle. Basic scaling is ideal for work that is intermittent or driven by user
/// activity.
class BasicScaling {
  /// Duration of time after the last request that an instance must wait before
  /// the instance is shut down.
  core.String idleTimeout;

  /// Maximum number of instances to create for this version.
  core.int maxInstances;

  BasicScaling();

  BasicScaling.fromJson(core.Map _json) {
    if (_json.containsKey("idleTimeout")) {
      idleTimeout = _json["idleTimeout"];
    }
    if (_json.containsKey("maxInstances")) {
      maxInstances = _json["maxInstances"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (idleTimeout != null) {
      _json["idleTimeout"] = idleTimeout;
    }
    if (maxInstances != null) {
      _json["maxInstances"] = maxInstances;
    }
    return _json;
  }
}

/// Docker image that is used to create a container and start a VM instance for
/// the version that you deploy. Only applicable for instances running in the
/// App Engine flexible environment.
class ContainerInfo {
  /// URI to the hosted container image in Google Container Registry. The URI
  /// must be fully qualified and include a tag or digest. Examples:
  /// "gcr.io/my-project/image:tag" or "gcr.io/my-project/image@digest"
  core.String image;

  ContainerInfo();

  ContainerInfo.fromJson(core.Map _json) {
    if (_json.containsKey("image")) {
      image = _json["image"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (image != null) {
      _json["image"] = image;
    }
    return _json;
  }
}

/// Target scaling by CPU usage.
class CpuUtilization {
  /// Period of time over which CPU utilization is calculated.
  core.String aggregationWindowLength;

  /// Target CPU utilization ratio to maintain when scaling. Must be between 0
  /// and 1.
  core.double targetUtilization;

  CpuUtilization();

  CpuUtilization.fromJson(core.Map _json) {
    if (_json.containsKey("aggregationWindowLength")) {
      aggregationWindowLength = _json["aggregationWindowLength"];
    }
    if (_json.containsKey("targetUtilization")) {
      targetUtilization = _json["targetUtilization"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (aggregationWindowLength != null) {
      _json["aggregationWindowLength"] = aggregationWindowLength;
    }
    if (targetUtilization != null) {
      _json["targetUtilization"] = targetUtilization;
    }
    return _json;
  }
}

/// Request message for Instances.DebugInstance.
class DebugInstanceRequest {
  /// Public SSH key to add to the instance. Examples:
  /// [USERNAME]:ssh-rsa [KEY_VALUE] [USERNAME]
  /// [USERNAME]:ssh-rsa [KEY_VALUE] google-ssh
  /// {"userName":"[USERNAME]","expireOn":"[EXPIRE_TIME]"}For more information,
  /// see Adding and Removing SSH Keys
  /// (https://cloud.google.com/compute/docs/instances/adding-removing-ssh-keys).
  core.String sshKey;

  DebugInstanceRequest();

  DebugInstanceRequest.fromJson(core.Map _json) {
    if (_json.containsKey("sshKey")) {
      sshKey = _json["sshKey"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (sshKey != null) {
      _json["sshKey"] = sshKey;
    }
    return _json;
  }
}

/// Code and application artifacts used to deploy a version to App Engine.
class Deployment {
  /// The Docker image for the container that runs the version. Only applicable
  /// for instances running in the App Engine flexible environment.
  ContainerInfo container;

  /// Manifest of the files stored in Google Cloud Storage that are included as
  /// part of this version. All files must be readable using the credentials
  /// supplied with this call.
  core.Map<core.String, FileInfo> files;

  /// Origin of the source code for this deployment. There can be more than one
  /// source reference per version if source code is distributed among multiple
  /// repositories.
  core.List<SourceReference> sourceReferences;

  Deployment();

  Deployment.fromJson(core.Map _json) {
    if (_json.containsKey("container")) {
      container = new ContainerInfo.fromJson(_json["container"]);
    }
    if (_json.containsKey("files")) {
      files = commons.mapMap<core.Map<core.String, core.Object>, FileInfo>(
          _json["files"],
          (core.Map<core.String, core.Object> item) =>
              new FileInfo.fromJson(item));
    }
    if (_json.containsKey("sourceReferences")) {
      sourceReferences = _json["sourceReferences"]
          .map((value) => new SourceReference.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (container != null) {
      _json["container"] = (container).toJson();
    }
    if (files != null) {
      _json["files"] =
          commons.mapMap<FileInfo, core.Map<core.String, core.Object>>(
              files, (FileInfo item) => (item).toJson());
    }
    if (sourceReferences != null) {
      _json["sourceReferences"] =
          sourceReferences.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Target scaling by disk usage. Only applicable for VM runtimes.
class DiskUtilization {
  /// Target bytes read per second.
  core.int targetReadBytesPerSec;

  /// Target ops read per second.
  core.int targetReadOpsPerSec;

  /// Target bytes written per second.
  core.int targetWriteBytesPerSec;

  /// Target ops written per second.
  core.int targetWriteOpsPerSec;

  DiskUtilization();

  DiskUtilization.fromJson(core.Map _json) {
    if (_json.containsKey("targetReadBytesPerSec")) {
      targetReadBytesPerSec = _json["targetReadBytesPerSec"];
    }
    if (_json.containsKey("targetReadOpsPerSec")) {
      targetReadOpsPerSec = _json["targetReadOpsPerSec"];
    }
    if (_json.containsKey("targetWriteBytesPerSec")) {
      targetWriteBytesPerSec = _json["targetWriteBytesPerSec"];
    }
    if (_json.containsKey("targetWriteOpsPerSec")) {
      targetWriteOpsPerSec = _json["targetWriteOpsPerSec"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (targetReadBytesPerSec != null) {
      _json["targetReadBytesPerSec"] = targetReadBytesPerSec;
    }
    if (targetReadOpsPerSec != null) {
      _json["targetReadOpsPerSec"] = targetReadOpsPerSec;
    }
    if (targetWriteBytesPerSec != null) {
      _json["targetWriteBytesPerSec"] = targetWriteBytesPerSec;
    }
    if (targetWriteOpsPerSec != null) {
      _json["targetWriteOpsPerSec"] = targetWriteOpsPerSec;
    }
    return _json;
  }
}

/// Custom static error page to be served when an error occurs.
class ErrorHandler {
  /// Error condition this handler applies to.
  /// Possible string values are:
  /// - "ERROR_CODE_UNSPECIFIED" : Not specified. ERROR_CODE_DEFAULT is assumed.
  /// - "ERROR_CODE_DEFAULT" : All other error types.
  /// - "ERROR_CODE_OVER_QUOTA" : Application has exceeded a resource quota.
  /// - "ERROR_CODE_DOS_API_DENIAL" : Client blocked by the application's Denial
  /// of Service protection configuration.
  /// - "ERROR_CODE_TIMEOUT" : Deadline reached before the application responds.
  core.String errorCode;

  /// MIME type of file. Defaults to text/html.
  core.String mimeType;

  /// Static file content to be served for this error.
  core.String staticFile;

  ErrorHandler();

  ErrorHandler.fromJson(core.Map _json) {
    if (_json.containsKey("errorCode")) {
      errorCode = _json["errorCode"];
    }
    if (_json.containsKey("mimeType")) {
      mimeType = _json["mimeType"];
    }
    if (_json.containsKey("staticFile")) {
      staticFile = _json["staticFile"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (errorCode != null) {
      _json["errorCode"] = errorCode;
    }
    if (mimeType != null) {
      _json["mimeType"] = mimeType;
    }
    if (staticFile != null) {
      _json["staticFile"] = staticFile;
    }
    return _json;
  }
}

/// Single source file that is part of the version to be deployed. Each source
/// file that is deployed must be specified separately.
class FileInfo {
  /// The MIME type of the file.Defaults to the value from Google Cloud Storage.
  core.String mimeType;

  /// The SHA1 hash of the file, in hex.
  core.String sha1Sum;

  /// URL source to use to fetch this file. Must be a URL to a resource in
  /// Google Cloud Storage in the form
  /// 'http(s)://storage.googleapis.com/<bucket>/<object>'.
  core.String sourceUrl;

  FileInfo();

  FileInfo.fromJson(core.Map _json) {
    if (_json.containsKey("mimeType")) {
      mimeType = _json["mimeType"];
    }
    if (_json.containsKey("sha1Sum")) {
      sha1Sum = _json["sha1Sum"];
    }
    if (_json.containsKey("sourceUrl")) {
      sourceUrl = _json["sourceUrl"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (mimeType != null) {
      _json["mimeType"] = mimeType;
    }
    if (sha1Sum != null) {
      _json["sha1Sum"] = sha1Sum;
    }
    if (sourceUrl != null) {
      _json["sourceUrl"] = sourceUrl;
    }
    return _json;
  }
}

/// Health checking configuration for VM instances. Unhealthy instances are
/// killed and replaced with new instances. Only applicable for instances in App
/// Engine flexible environment.
class HealthCheck {
  /// Interval between health checks.
  core.String checkInterval;

  /// Whether to explicitly disable health checks for this instance.
  core.bool disableHealthCheck;

  /// Number of consecutive successful health checks required before receiving
  /// traffic.
  core.int healthyThreshold;

  /// Host header to send when performing an HTTP health check. Example:
  /// "myapp.appspot.com"
  core.String host;

  /// Number of consecutive failed health checks required before an instance is
  /// restarted.
  core.int restartThreshold;

  /// Time before the health check is considered failed.
  core.String timeout;

  /// Number of consecutive failed health checks required before removing
  /// traffic.
  core.int unhealthyThreshold;

  HealthCheck();

  HealthCheck.fromJson(core.Map _json) {
    if (_json.containsKey("checkInterval")) {
      checkInterval = _json["checkInterval"];
    }
    if (_json.containsKey("disableHealthCheck")) {
      disableHealthCheck = _json["disableHealthCheck"];
    }
    if (_json.containsKey("healthyThreshold")) {
      healthyThreshold = _json["healthyThreshold"];
    }
    if (_json.containsKey("host")) {
      host = _json["host"];
    }
    if (_json.containsKey("restartThreshold")) {
      restartThreshold = _json["restartThreshold"];
    }
    if (_json.containsKey("timeout")) {
      timeout = _json["timeout"];
    }
    if (_json.containsKey("unhealthyThreshold")) {
      unhealthyThreshold = _json["unhealthyThreshold"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (checkInterval != null) {
      _json["checkInterval"] = checkInterval;
    }
    if (disableHealthCheck != null) {
      _json["disableHealthCheck"] = disableHealthCheck;
    }
    if (healthyThreshold != null) {
      _json["healthyThreshold"] = healthyThreshold;
    }
    if (host != null) {
      _json["host"] = host;
    }
    if (restartThreshold != null) {
      _json["restartThreshold"] = restartThreshold;
    }
    if (timeout != null) {
      _json["timeout"] = timeout;
    }
    if (unhealthyThreshold != null) {
      _json["unhealthyThreshold"] = unhealthyThreshold;
    }
    return _json;
  }
}

/// Identity-Aware Proxy
class IdentityAwareProxy {
  /// Whether the serving infrastructure will authenticate and authorize all
  /// incoming requests.If true, the oauth2_client_id and oauth2_client_secret
  /// fields must be non-empty.
  core.bool enabled;

  /// OAuth2 client ID to use for the authentication flow.
  core.String oauth2ClientId;

  /// For security reasons, this value cannot be retrieved via the API. Instead,
  /// the SHA-256 hash of the value is returned in the
  /// oauth2_client_secret_sha256 field.@InputOnly
  core.String oauth2ClientSecret;

  /// Hex-encoded SHA-256 hash of the client secret.@OutputOnly
  core.String oauth2ClientSecretSha256;

  IdentityAwareProxy();

  IdentityAwareProxy.fromJson(core.Map _json) {
    if (_json.containsKey("enabled")) {
      enabled = _json["enabled"];
    }
    if (_json.containsKey("oauth2ClientId")) {
      oauth2ClientId = _json["oauth2ClientId"];
    }
    if (_json.containsKey("oauth2ClientSecret")) {
      oauth2ClientSecret = _json["oauth2ClientSecret"];
    }
    if (_json.containsKey("oauth2ClientSecretSha256")) {
      oauth2ClientSecretSha256 = _json["oauth2ClientSecretSha256"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (enabled != null) {
      _json["enabled"] = enabled;
    }
    if (oauth2ClientId != null) {
      _json["oauth2ClientId"] = oauth2ClientId;
    }
    if (oauth2ClientSecret != null) {
      _json["oauth2ClientSecret"] = oauth2ClientSecret;
    }
    if (oauth2ClientSecretSha256 != null) {
      _json["oauth2ClientSecretSha256"] = oauth2ClientSecretSha256;
    }
    return _json;
  }
}

/// An Instance resource is the computing unit that App Engine uses to
/// automatically scale an application.
class Instance {
  /// App Engine release this instance is running on.@OutputOnly
  core.String appEngineRelease;

  /// Availability of the instance.@OutputOnly
  /// Possible string values are:
  /// - "UNSPECIFIED"
  /// - "RESIDENT"
  /// - "DYNAMIC"
  core.String availability;

  /// Average latency (ms) over the last minute.@OutputOnly
  core.int averageLatency;

  /// Number of errors since this instance was started.@OutputOnly
  core.int errors;

  /// Relative name of the instance within the version. Example:
  /// instance-1.@OutputOnly
  core.String id;

  /// Total memory in use (bytes).@OutputOnly
  core.String memoryUsage;

  /// Full path to the Instance resource in the API. Example:
  /// apps/myapp/modules/default/versions/v1/instances/instance-1.@OutputOnly
  core.String name;

  /// Average queries per second (QPS) over the last minute.@OutputOnly
  core.double qps;

  /// Number of requests since this instance was started.@OutputOnly
  core.int requests;

  /// Time that this instance was started.@OutputOnly
  core.String startTimestamp;

  /// Virtual machine ID of this instance. Only applicable for instances in App
  /// Engine flexible environment.@OutputOnly
  core.String vmId;

  /// The IP address of this instance. Only applicable for instances in App
  /// Engine flexible environment.@OutputOnly
  core.String vmIp;

  /// Name of the virtual machine where this instance lives. Only applicable for
  /// instances in App Engine flexible environment.@OutputOnly
  core.String vmName;

  /// Status of the virtual machine where this instance lives. Only applicable
  /// for instances in App Engine flexible environment.@OutputOnly
  core.String vmStatus;

  /// Whether this instance is in debug mode. Only applicable for instances in
  /// App Engine flexible environment.@OutputOnly
  core.bool vmUnlocked;

  /// Zone where the virtual machine is located. Only applicable for instances
  /// in App Engine flexible environment.@OutputOnly
  core.String vmZoneName;

  Instance();

  Instance.fromJson(core.Map _json) {
    if (_json.containsKey("appEngineRelease")) {
      appEngineRelease = _json["appEngineRelease"];
    }
    if (_json.containsKey("availability")) {
      availability = _json["availability"];
    }
    if (_json.containsKey("averageLatency")) {
      averageLatency = _json["averageLatency"];
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("memoryUsage")) {
      memoryUsage = _json["memoryUsage"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("qps")) {
      qps = _json["qps"];
    }
    if (_json.containsKey("requests")) {
      requests = _json["requests"];
    }
    if (_json.containsKey("startTimestamp")) {
      startTimestamp = _json["startTimestamp"];
    }
    if (_json.containsKey("vmId")) {
      vmId = _json["vmId"];
    }
    if (_json.containsKey("vmIp")) {
      vmIp = _json["vmIp"];
    }
    if (_json.containsKey("vmName")) {
      vmName = _json["vmName"];
    }
    if (_json.containsKey("vmStatus")) {
      vmStatus = _json["vmStatus"];
    }
    if (_json.containsKey("vmUnlocked")) {
      vmUnlocked = _json["vmUnlocked"];
    }
    if (_json.containsKey("vmZoneName")) {
      vmZoneName = _json["vmZoneName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (appEngineRelease != null) {
      _json["appEngineRelease"] = appEngineRelease;
    }
    if (availability != null) {
      _json["availability"] = availability;
    }
    if (averageLatency != null) {
      _json["averageLatency"] = averageLatency;
    }
    if (errors != null) {
      _json["errors"] = errors;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (memoryUsage != null) {
      _json["memoryUsage"] = memoryUsage;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (qps != null) {
      _json["qps"] = qps;
    }
    if (requests != null) {
      _json["requests"] = requests;
    }
    if (startTimestamp != null) {
      _json["startTimestamp"] = startTimestamp;
    }
    if (vmId != null) {
      _json["vmId"] = vmId;
    }
    if (vmIp != null) {
      _json["vmIp"] = vmIp;
    }
    if (vmName != null) {
      _json["vmName"] = vmName;
    }
    if (vmStatus != null) {
      _json["vmStatus"] = vmStatus;
    }
    if (vmUnlocked != null) {
      _json["vmUnlocked"] = vmUnlocked;
    }
    if (vmZoneName != null) {
      _json["vmZoneName"] = vmZoneName;
    }
    return _json;
  }
}

/// Third-party Python runtime library that is required by the application.
class Library {
  /// Name of the library. Example: "django".
  core.String name;

  /// Version of the library to select, or "latest".
  core.String version;

  Library();

  Library.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (name != null) {
      _json["name"] = name;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

/// Response message for Instances.ListInstances.
class ListInstancesResponse {
  /// The instances belonging to the requested version.
  core.List<Instance> instances;

  /// Continuation token for fetching the next page of results.
  core.String nextPageToken;

  ListInstancesResponse();

  ListInstancesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("instances")) {
      instances = _json["instances"]
          .map((value) => new Instance.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (instances != null) {
      _json["instances"] = instances.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// The response message for Locations.ListLocations.
class ListLocationsResponse {
  /// A list of locations that matches the specified filter in the request.
  core.List<Location> locations;

  /// The standard List next-page token.
  core.String nextPageToken;

  ListLocationsResponse();

  ListLocationsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("locations")) {
      locations = _json["locations"]
          .map((value) => new Location.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (locations != null) {
      _json["locations"] = locations.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response message for Modules.ListModules.
class ListModulesResponse {
  /// The modules belonging to the requested application.
  core.List<Module> modules;

  /// Continuation token for fetching the next page of results.
  core.String nextPageToken;

  ListModulesResponse();

  ListModulesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("modules")) {
      modules =
          _json["modules"].map((value) => new Module.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (modules != null) {
      _json["modules"] = modules.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// The response message for Operations.ListOperations.
class ListOperationsResponse {
  /// The standard List next-page token.
  core.String nextPageToken;

  /// A list of operations that matches the specified filter in the request.
  core.List<Operation> operations;

  ListOperationsResponse();

  ListOperationsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("operations")) {
      operations = _json["operations"]
          .map((value) => new Operation.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (operations != null) {
      _json["operations"] =
          operations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Response message for Versions.ListVersions.
class ListVersionsResponse {
  /// Continuation token for fetching the next page of results.
  core.String nextPageToken;

  /// The versions belonging to the requested module.
  core.List<Version> versions;

  ListVersionsResponse();

  ListVersionsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("versions")) {
      versions = _json["versions"]
          .map((value) => new Version.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (versions != null) {
      _json["versions"] = versions.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A resource that represents Google Cloud Platform location.
class Location {
  /// Cross-service attributes for the location. For example
  /// {"cloud.googleapis.com/region": "us-east1"}
  core.Map<core.String, core.String> labels;

  /// The canonical id for this location. For example: "us-east1".
  core.String locationId;

  /// Service-specific metadata. For example the available capacity at the given
  /// location.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> metadata;

  /// Resource name for the location, which may vary between implementations.
  /// For example: "projects/example-project/locations/us-east1"
  core.String name;

  Location();

  Location.fromJson(core.Map _json) {
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("locationId")) {
      locationId = _json["locationId"];
    }
    if (_json.containsKey("metadata")) {
      metadata = _json["metadata"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (locationId != null) {
      _json["locationId"] = locationId;
    }
    if (metadata != null) {
      _json["metadata"] = metadata;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/// Metadata for the given google.cloud.location.Location.
class LocationMetadata {
  /// App Engine Flexible Environment is available in the given
  /// location.@OutputOnly
  core.bool flexibleEnvironmentAvailable;

  /// App Engine Standard Environment is available in the given
  /// location.@OutputOnly
  core.bool standardEnvironmentAvailable;

  LocationMetadata();

  LocationMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("flexibleEnvironmentAvailable")) {
      flexibleEnvironmentAvailable = _json["flexibleEnvironmentAvailable"];
    }
    if (_json.containsKey("standardEnvironmentAvailable")) {
      standardEnvironmentAvailable = _json["standardEnvironmentAvailable"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (flexibleEnvironmentAvailable != null) {
      _json["flexibleEnvironmentAvailable"] = flexibleEnvironmentAvailable;
    }
    if (standardEnvironmentAvailable != null) {
      _json["standardEnvironmentAvailable"] = standardEnvironmentAvailable;
    }
    return _json;
  }
}

/// A module with manual scaling runs continuously, allowing you to perform
/// complex initialization and rely on the state of its memory over time.
class ManualScaling {
  /// Number of instances to assign to the module at the start. This number can
  /// later be altered by using the Modules API
  /// (https://cloud.google.com/appengine/docs/python/modules/functions)
  /// set_num_instances() function.
  core.int instances;

  ManualScaling();

  ManualScaling.fromJson(core.Map _json) {
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

/// A Module resource is a logical component of an application that can share
/// state and communicate in a secure fashion with other modules. For example,
/// an application that handles customer requests might include separate modules
/// to handle tasks such as backend data analysis or API requests from mobile
/// devices. Each module has a collection of versions that define a specific set
/// of code used to implement the functionality of that module.
class Module {
  /// Relative name of the module within the application. Example:
  /// default.@OutputOnly
  core.String id;

  /// Full path to the Module resource in the API. Example:
  /// apps/myapp/modules/default.@OutputOnly
  core.String name;

  /// Mapping that defines fractional HTTP traffic diversion to different
  /// versions within the module.
  TrafficSplit split;

  Module();

  Module.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("split")) {
      split = new TrafficSplit.fromJson(_json["split"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (split != null) {
      _json["split"] = (split).toJson();
    }
    return _json;
  }
}

/// Extra network settings. Only applicable for VM runtimes.
class Network {
  /// List of ports, or port pairs, to forward from the virtual machine to the
  /// application container.
  core.List<core.String> forwardedPorts;

  /// Tag to apply to the VM instance during creation.
  core.String instanceTag;

  /// Google Cloud Platform network where the virtual machines are created.
  /// Specify the short name, not the resource path.Defaults to default.
  core.String name;

  Network();

  Network.fromJson(core.Map _json) {
    if (_json.containsKey("forwardedPorts")) {
      forwardedPorts = _json["forwardedPorts"];
    }
    if (_json.containsKey("instanceTag")) {
      instanceTag = _json["instanceTag"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (forwardedPorts != null) {
      _json["forwardedPorts"] = forwardedPorts;
    }
    if (instanceTag != null) {
      _json["instanceTag"] = instanceTag;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/// Target scaling by network usage. Only applicable for VM runtimes.
class NetworkUtilization {
  /// Target bytes received per second.
  core.int targetReceivedBytesPerSec;

  /// Target packets received per second.
  core.int targetReceivedPacketsPerSec;

  /// Target bytes sent per second.
  core.int targetSentBytesPerSec;

  /// Target packets sent per second.
  core.int targetSentPacketsPerSec;

  NetworkUtilization();

  NetworkUtilization.fromJson(core.Map _json) {
    if (_json.containsKey("targetReceivedBytesPerSec")) {
      targetReceivedBytesPerSec = _json["targetReceivedBytesPerSec"];
    }
    if (_json.containsKey("targetReceivedPacketsPerSec")) {
      targetReceivedPacketsPerSec = _json["targetReceivedPacketsPerSec"];
    }
    if (_json.containsKey("targetSentBytesPerSec")) {
      targetSentBytesPerSec = _json["targetSentBytesPerSec"];
    }
    if (_json.containsKey("targetSentPacketsPerSec")) {
      targetSentPacketsPerSec = _json["targetSentPacketsPerSec"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (targetReceivedBytesPerSec != null) {
      _json["targetReceivedBytesPerSec"] = targetReceivedBytesPerSec;
    }
    if (targetReceivedPacketsPerSec != null) {
      _json["targetReceivedPacketsPerSec"] = targetReceivedPacketsPerSec;
    }
    if (targetSentBytesPerSec != null) {
      _json["targetSentBytesPerSec"] = targetSentBytesPerSec;
    }
    if (targetSentPacketsPerSec != null) {
      _json["targetSentPacketsPerSec"] = targetSentPacketsPerSec;
    }
    return _json;
  }
}

/// This resource represents a long-running operation that is the result of a
/// network API call.
class Operation {
  /// If the value is false, it means the operation is still in progress. If
  /// true, the operation is completed, and either error or response is
  /// available.
  core.bool done;

  /// The error result of the operation in case of failure or cancellation.
  Status error;

  /// Service-specific metadata associated with the operation. It typically
  /// contains progress information and common metadata such as create time.
  /// Some services might not provide such metadata. Any method that returns a
  /// long-running operation should document the metadata type, if any.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> metadata;

  /// The server-assigned name, which is only unique within the same service
  /// that originally returns it. If you use the default HTTP mapping, the name
  /// should have the format of operations/some/unique/name.
  core.String name;

  /// The normal response of the operation in case of success. If the original
  /// method returns no data on success, such as Delete, the response is
  /// google.protobuf.Empty. If the original method is standard
  /// Get/Create/Update, the response should be the resource. For other methods,
  /// the response should have the type XxxResponse, where Xxx is the original
  /// method name. For example, if the original method name is TakeSnapshot(),
  /// the inferred response type is TakeSnapshotResponse.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
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

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
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

/// Metadata for the given google.longrunning.Operation.
class OperationMetadata {
  /// Timestamp that this operation completed.@OutputOnly
  core.String endTime;

  /// Timestamp that this operation was created.@OutputOnly
  core.String insertTime;

  /// API method that initiated this operation. Example:
  /// google.appengine.v1beta4.Version.CreateVersion.@OutputOnly
  core.String method;

  /// Type of this operation. Deprecated, use method field instead. Example:
  /// "create_version".@OutputOnly
  core.String operationType;

  /// Name of the resource that this operation is acting on. Example:
  /// apps/myapp/modules/default.@OutputOnly
  core.String target;

  /// User who requested this operation.@OutputOnly
  core.String user;

  OperationMetadata();

  OperationMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("insertTime")) {
      insertTime = _json["insertTime"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("operationType")) {
      operationType = _json["operationType"];
    }
    if (_json.containsKey("target")) {
      target = _json["target"];
    }
    if (_json.containsKey("user")) {
      user = _json["user"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (insertTime != null) {
      _json["insertTime"] = insertTime;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (operationType != null) {
      _json["operationType"] = operationType;
    }
    if (target != null) {
      _json["target"] = target;
    }
    if (user != null) {
      _json["user"] = user;
    }
    return _json;
  }
}

/// Metadata for the given google.longrunning.Operation.
class OperationMetadataExperimental {
  /// Time that this operation completed.@OutputOnly
  core.String endTime;

  /// Time that this operation was created.@OutputOnly
  core.String insertTime;

  /// API method that initiated this operation. Example:
  /// google.appengine.experimental.CustomDomains.CreateCustomDomain.@OutputOnly
  core.String method;

  /// Name of the resource that this operation is acting on. Example:
  /// apps/myapp/customDomains/example.com.@OutputOnly
  core.String target;

  /// User who requested this operation.@OutputOnly
  core.String user;

  OperationMetadataExperimental();

  OperationMetadataExperimental.fromJson(core.Map _json) {
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("insertTime")) {
      insertTime = _json["insertTime"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("target")) {
      target = _json["target"];
    }
    if (_json.containsKey("user")) {
      user = _json["user"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (insertTime != null) {
      _json["insertTime"] = insertTime;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (target != null) {
      _json["target"] = target;
    }
    if (user != null) {
      _json["user"] = user;
    }
    return _json;
  }
}

/// Metadata for the given google.longrunning.Operation.
class OperationMetadataV1 {
  /// Time that this operation completed.@OutputOnly
  core.String endTime;

  /// Ephemeral message that may change every time the operation is polled.
  /// @OutputOnly
  core.String ephemeralMessage;

  /// Time that this operation was created.@OutputOnly
  core.String insertTime;

  /// API method that initiated this operation. Example:
  /// google.appengine.v1.Versions.CreateVersion.@OutputOnly
  core.String method;

  /// Name of the resource that this operation is acting on. Example:
  /// apps/myapp/services/default.@OutputOnly
  core.String target;

  /// User who requested this operation.@OutputOnly
  core.String user;

  /// Durable messages that persist on every operation poll. @OutputOnly
  core.List<core.String> warning;

  OperationMetadataV1();

  OperationMetadataV1.fromJson(core.Map _json) {
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("ephemeralMessage")) {
      ephemeralMessage = _json["ephemeralMessage"];
    }
    if (_json.containsKey("insertTime")) {
      insertTime = _json["insertTime"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("target")) {
      target = _json["target"];
    }
    if (_json.containsKey("user")) {
      user = _json["user"];
    }
    if (_json.containsKey("warning")) {
      warning = _json["warning"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (ephemeralMessage != null) {
      _json["ephemeralMessage"] = ephemeralMessage;
    }
    if (insertTime != null) {
      _json["insertTime"] = insertTime;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (target != null) {
      _json["target"] = target;
    }
    if (user != null) {
      _json["user"] = user;
    }
    if (warning != null) {
      _json["warning"] = warning;
    }
    return _json;
  }
}

/// Metadata for the given google.longrunning.Operation.
class OperationMetadataV1Alpha {
  /// Time that this operation completed.@OutputOnly
  core.String endTime;

  /// Ephemeral message that may change every time the operation is polled.
  /// @OutputOnly
  core.String ephemeralMessage;

  /// Time that this operation was created.@OutputOnly
  core.String insertTime;

  /// API method that initiated this operation. Example:
  /// google.appengine.v1alpha.Versions.CreateVersion.@OutputOnly
  core.String method;

  /// Name of the resource that this operation is acting on. Example:
  /// apps/myapp/services/default.@OutputOnly
  core.String target;

  /// User who requested this operation.@OutputOnly
  core.String user;

  /// Durable messages that persist on every operation poll. @OutputOnly
  core.List<core.String> warning;

  OperationMetadataV1Alpha();

  OperationMetadataV1Alpha.fromJson(core.Map _json) {
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("ephemeralMessage")) {
      ephemeralMessage = _json["ephemeralMessage"];
    }
    if (_json.containsKey("insertTime")) {
      insertTime = _json["insertTime"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("target")) {
      target = _json["target"];
    }
    if (_json.containsKey("user")) {
      user = _json["user"];
    }
    if (_json.containsKey("warning")) {
      warning = _json["warning"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (ephemeralMessage != null) {
      _json["ephemeralMessage"] = ephemeralMessage;
    }
    if (insertTime != null) {
      _json["insertTime"] = insertTime;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (target != null) {
      _json["target"] = target;
    }
    if (user != null) {
      _json["user"] = user;
    }
    if (warning != null) {
      _json["warning"] = warning;
    }
    return _json;
  }
}

/// Metadata for the given google.longrunning.Operation.
class OperationMetadataV1Beta {
  /// Time that this operation completed.@OutputOnly
  core.String endTime;

  /// Ephemeral message that may change every time the operation is polled.
  /// @OutputOnly
  core.String ephemeralMessage;

  /// Time that this operation was created.@OutputOnly
  core.String insertTime;

  /// API method that initiated this operation. Example:
  /// google.appengine.v1beta.Versions.CreateVersion.@OutputOnly
  core.String method;

  /// Name of the resource that this operation is acting on. Example:
  /// apps/myapp/services/default.@OutputOnly
  core.String target;

  /// User who requested this operation.@OutputOnly
  core.String user;

  /// Durable messages that persist on every operation poll. @OutputOnly
  core.List<core.String> warning;

  OperationMetadataV1Beta();

  OperationMetadataV1Beta.fromJson(core.Map _json) {
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("ephemeralMessage")) {
      ephemeralMessage = _json["ephemeralMessage"];
    }
    if (_json.containsKey("insertTime")) {
      insertTime = _json["insertTime"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("target")) {
      target = _json["target"];
    }
    if (_json.containsKey("user")) {
      user = _json["user"];
    }
    if (_json.containsKey("warning")) {
      warning = _json["warning"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (ephemeralMessage != null) {
      _json["ephemeralMessage"] = ephemeralMessage;
    }
    if (insertTime != null) {
      _json["insertTime"] = insertTime;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (target != null) {
      _json["target"] = target;
    }
    if (user != null) {
      _json["user"] = user;
    }
    if (warning != null) {
      _json["warning"] = warning;
    }
    return _json;
  }
}

/// Metadata for the given google.longrunning.Operation.
class OperationMetadataV1Beta5 {
  /// Timestamp that this operation completed.@OutputOnly
  core.String endTime;

  /// Timestamp that this operation was created.@OutputOnly
  core.String insertTime;

  /// API method name that initiated this operation. Example:
  /// google.appengine.v1beta5.Version.CreateVersion.@OutputOnly
  core.String method;

  /// Name of the resource that this operation is acting on. Example:
  /// apps/myapp/services/default.@OutputOnly
  core.String target;

  /// User who requested this operation.@OutputOnly
  core.String user;

  OperationMetadataV1Beta5();

  OperationMetadataV1Beta5.fromJson(core.Map _json) {
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("insertTime")) {
      insertTime = _json["insertTime"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("target")) {
      target = _json["target"];
    }
    if (_json.containsKey("user")) {
      user = _json["user"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (insertTime != null) {
      _json["insertTime"] = insertTime;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (target != null) {
      _json["target"] = target;
    }
    if (user != null) {
      _json["user"] = user;
    }
    return _json;
  }
}

/// Target scaling by request utilization. Only applicable for VM runtimes.
class RequestUtilization {
  /// Target number of concurrent requests.
  core.int targetConcurrentRequests;

  /// Target requests per second.
  core.int targetRequestCountPerSec;

  RequestUtilization();

  RequestUtilization.fromJson(core.Map _json) {
    if (_json.containsKey("targetConcurrentRequests")) {
      targetConcurrentRequests = _json["targetConcurrentRequests"];
    }
    if (_json.containsKey("targetRequestCountPerSec")) {
      targetRequestCountPerSec = _json["targetRequestCountPerSec"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (targetConcurrentRequests != null) {
      _json["targetConcurrentRequests"] = targetConcurrentRequests;
    }
    if (targetRequestCountPerSec != null) {
      _json["targetRequestCountPerSec"] = targetRequestCountPerSec;
    }
    return _json;
  }
}

/// Machine resources for a version.
class Resources {
  /// Number of CPU cores needed.
  core.double cpu;

  /// Disk size (GB) needed.
  core.double diskGb;

  /// Memory (GB) needed.
  core.double memoryGb;

  /// User specified volumes.
  core.List<Volume> volumes;

  Resources();

  Resources.fromJson(core.Map _json) {
    if (_json.containsKey("cpu")) {
      cpu = _json["cpu"];
    }
    if (_json.containsKey("diskGb")) {
      diskGb = _json["diskGb"];
    }
    if (_json.containsKey("memoryGb")) {
      memoryGb = _json["memoryGb"];
    }
    if (_json.containsKey("volumes")) {
      volumes =
          _json["volumes"].map((value) => new Volume.fromJson(value)).toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (cpu != null) {
      _json["cpu"] = cpu;
    }
    if (diskGb != null) {
      _json["diskGb"] = diskGb;
    }
    if (memoryGb != null) {
      _json["memoryGb"] = memoryGb;
    }
    if (volumes != null) {
      _json["volumes"] = volumes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Executes a script to handle the request that matches the URL pattern.
class ScriptHandler {
  /// Path to the script from the application root directory.
  core.String scriptPath;

  ScriptHandler();

  ScriptHandler.fromJson(core.Map _json) {
    if (_json.containsKey("scriptPath")) {
      scriptPath = _json["scriptPath"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (scriptPath != null) {
      _json["scriptPath"] = scriptPath;
    }
    return _json;
  }
}

/// Reference to a particular snapshot of the source tree used to build and
/// deploy the application.
class SourceReference {
  /// URI string identifying the repository. Example:
  /// "https://source.developers.google.com/p/app-123/r/default"
  core.String repository;

  /// The canonical, persistent identifier of the deployed revision. Aliases
  /// that include tags or branch names are not allowed. Example (git):
  /// "2198322f89e0bb2e25021667c2ed489d1fd34e6b"
  core.String revisionId;

  SourceReference();

  SourceReference.fromJson(core.Map _json) {
    if (_json.containsKey("repository")) {
      repository = _json["repository"];
    }
    if (_json.containsKey("revisionId")) {
      revisionId = _json["revisionId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (repository != null) {
      _json["repository"] = repository;
    }
    if (revisionId != null) {
      _json["revisionId"] = revisionId;
    }
    return _json;
  }
}

/// Files served directly to the user for a given URL, such as images, CSS
/// stylesheets, or JavaScript source files. Static directory handlers make it
/// easy to serve the entire contents of a directory as static files.
class StaticDirectoryHandler {
  /// Whether files should also be uploaded as code data. By default, files
  /// declared in static directory handlers are uploaded as static data and are
  /// only served to end users; they cannot be read by the application. If
  /// enabled, uploads are charged against both your code and static data
  /// storage resource quotas.
  core.bool applicationReadable;

  /// Path to the directory containing the static files from the application
  /// root directory. Everything after the end of the matched URL pattern is
  /// appended to static_dir to form the full path to the requested file.
  core.String directory;

  /// Time a static file served by this handler should be cached.
  core.String expiration;

  /// HTTP headers to use for all responses from these URLs.
  core.Map<core.String, core.String> httpHeaders;

  /// MIME type used to serve all files served by this handler. Defaults to
  /// file-specific MIME types, which are direved from each file's filename
  /// extension.
  core.String mimeType;

  /// Whether this handler should match the request if the file referenced by
  /// the handler does not exist.
  core.bool requireMatchingFile;

  StaticDirectoryHandler();

  StaticDirectoryHandler.fromJson(core.Map _json) {
    if (_json.containsKey("applicationReadable")) {
      applicationReadable = _json["applicationReadable"];
    }
    if (_json.containsKey("directory")) {
      directory = _json["directory"];
    }
    if (_json.containsKey("expiration")) {
      expiration = _json["expiration"];
    }
    if (_json.containsKey("httpHeaders")) {
      httpHeaders = _json["httpHeaders"];
    }
    if (_json.containsKey("mimeType")) {
      mimeType = _json["mimeType"];
    }
    if (_json.containsKey("requireMatchingFile")) {
      requireMatchingFile = _json["requireMatchingFile"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (applicationReadable != null) {
      _json["applicationReadable"] = applicationReadable;
    }
    if (directory != null) {
      _json["directory"] = directory;
    }
    if (expiration != null) {
      _json["expiration"] = expiration;
    }
    if (httpHeaders != null) {
      _json["httpHeaders"] = httpHeaders;
    }
    if (mimeType != null) {
      _json["mimeType"] = mimeType;
    }
    if (requireMatchingFile != null) {
      _json["requireMatchingFile"] = requireMatchingFile;
    }
    return _json;
  }
}

/// Files served directly to the user for a given URL, such as images, CSS
/// stylesheets, or JavaScript source files. Static file handlers describe which
/// files in the application directory are static files, and which URLs serve
/// them.
class StaticFilesHandler {
  /// Whether files should also be uploaded as code data. By default, files
  /// declared in static file handlers are uploaded as static data and are only
  /// served to end users; they cannot be read by the application. If enabled,
  /// uploads are charged against both your code and static data storage
  /// resource quotas.
  core.bool applicationReadable;

  /// Time a static file served by this handler should be cached.
  core.String expiration;

  /// HTTP headers to use for all responses from these URLs.
  core.Map<core.String, core.String> httpHeaders;

  /// MIME type used to serve all files served by this handler. Defaults to
  /// file-specific MIME types, which are derived from each file's filename
  /// extension.
  core.String mimeType;

  /// Path to the static files matched by the URL pattern, from the application
  /// root directory. The path can refer to text matched in groupings in the URL
  /// pattern.
  core.String path;

  /// Whether this handler should match the request if the file referenced by
  /// the handler does not exist.
  core.bool requireMatchingFile;

  /// Regular expression that matches the file paths for all files that should
  /// be referenced by this handler.
  core.String uploadPathRegex;

  StaticFilesHandler();

  StaticFilesHandler.fromJson(core.Map _json) {
    if (_json.containsKey("applicationReadable")) {
      applicationReadable = _json["applicationReadable"];
    }
    if (_json.containsKey("expiration")) {
      expiration = _json["expiration"];
    }
    if (_json.containsKey("httpHeaders")) {
      httpHeaders = _json["httpHeaders"];
    }
    if (_json.containsKey("mimeType")) {
      mimeType = _json["mimeType"];
    }
    if (_json.containsKey("path")) {
      path = _json["path"];
    }
    if (_json.containsKey("requireMatchingFile")) {
      requireMatchingFile = _json["requireMatchingFile"];
    }
    if (_json.containsKey("uploadPathRegex")) {
      uploadPathRegex = _json["uploadPathRegex"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (applicationReadable != null) {
      _json["applicationReadable"] = applicationReadable;
    }
    if (expiration != null) {
      _json["expiration"] = expiration;
    }
    if (httpHeaders != null) {
      _json["httpHeaders"] = httpHeaders;
    }
    if (mimeType != null) {
      _json["mimeType"] = mimeType;
    }
    if (path != null) {
      _json["path"] = path;
    }
    if (requireMatchingFile != null) {
      _json["requireMatchingFile"] = requireMatchingFile;
    }
    if (uploadPathRegex != null) {
      _json["uploadPathRegex"] = uploadPathRegex;
    }
    return _json;
  }
}

/// The Status type defines a logical error model that is suitable for different
/// programming environments, including REST APIs and RPC APIs. It is used by
/// gRPC (https://github.com/grpc). The error model is designed to be:
/// Simple to use and understand for most users
/// Flexible enough to meet unexpected needsOverviewThe Status message contains
/// three pieces of data: error code, error message, and error details. The
/// error code should be an enum value of google.rpc.Code, but it may accept
/// additional error codes if needed. The error message should be a
/// developer-facing English message that helps developers understand and
/// resolve the error. If a localized user-facing error message is needed, put
/// the localized message in the error details or localize it in the client. The
/// optional error details may contain arbitrary information about the error.
/// There is a predefined set of error detail types in the package google.rpc
/// that can be used for common error conditions.Language mappingThe Status
/// message is the logical representation of the error model, but it is not
/// necessarily the actual wire format. When the Status message is exposed in
/// different client libraries and different wire protocols, it can be mapped
/// differently. For example, it will likely be mapped to some exceptions in
/// Java, but more likely mapped to some error codes in C.Other usesThe error
/// model and the Status message can be used in a variety of environments,
/// either with or without APIs, to provide a consistent developer experience
/// across different environments.Example uses of this error model include:
/// Partial errors. If a service needs to return partial errors to the client,
/// it may embed the Status in the normal response to indicate the partial
/// errors.
/// Workflow errors. A typical workflow has multiple steps. Each step may have a
/// Status message for error reporting.
/// Batch operations. If a client uses batch request and batch response, the
/// Status message should be used directly inside batch response, one for each
/// error sub-response.
/// Asynchronous operations. If an API call embeds asynchronous operation
/// results in its response, the status of those operations should be
/// represented directly using the Status message.
/// Logging. If some API errors are stored in logs, the message Status could be
/// used directly after any stripping needed for security/privacy reasons.
class Status {
  /// The status code, which should be an enum value of google.rpc.Code.
  core.int code;

  /// A list of messages that carry the error details. There is a common set of
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

/// Traffic routing configuration for versions within a single module. Traffic
/// splits define how traffic directed to the module is assigned to versions.
class TrafficSplit {
  /// Mapping from version IDs within the module to fractional (0.000, 1]
  /// allocations of traffic for that version. Each version can be specified
  /// only once, but some versions in the module may not have any traffic
  /// allocation. Modules that have traffic allocated cannot be deleted until
  /// either the module is deleted or their traffic allocation is removed.
  /// Allocations must sum to 1. Up to two decimal place precision is supported
  /// for IP-based splits and up to three decimal places is supported for
  /// cookie-based splits.
  core.Map<core.String, core.double> allocations;

  /// Mechanism used to determine which version a request is sent to. The
  /// traffic selection algorithm will be stable for either type until
  /// allocations are changed.
  /// Possible string values are:
  /// - "UNSPECIFIED" : Diversion method unspecified.
  /// - "COOKIE" : Diversion based on a specially named cookie, "GOOGAPPUID."
  /// The cookie must be set by the application itself or else no diversion will
  /// occur.
  /// - "IP" : Diversion based on applying the modulus operation to a
  /// fingerprint of the IP address.
  core.String shardBy;

  TrafficSplit();

  TrafficSplit.fromJson(core.Map _json) {
    if (_json.containsKey("allocations")) {
      allocations = _json["allocations"];
    }
    if (_json.containsKey("shardBy")) {
      shardBy = _json["shardBy"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (allocations != null) {
      _json["allocations"] = allocations;
    }
    if (shardBy != null) {
      _json["shardBy"] = shardBy;
    }
    return _json;
  }
}

/// Rules to match an HTTP request and dispatch that request to a module.
class UrlDispatchRule {
  /// Domain name to match against. The wildcard "*" is supported if specified
  /// before a period: "*.".Defaults to matching all domains: "*".
  core.String domain;

  /// Resource ID of a module in this application that should serve the matched
  /// request. The module must already exist. Example: default.
  core.String module;

  /// Pathname within the host. Must start with a "/". A single "*" can be
  /// included at the end of the path. The sum of the lengths of the domain and
  /// path may not exceed 100 characters.
  core.String path;

  UrlDispatchRule();

  UrlDispatchRule.fromJson(core.Map _json) {
    if (_json.containsKey("domain")) {
      domain = _json["domain"];
    }
    if (_json.containsKey("module")) {
      module = _json["module"];
    }
    if (_json.containsKey("path")) {
      path = _json["path"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (domain != null) {
      _json["domain"] = domain;
    }
    if (module != null) {
      _json["module"] = module;
    }
    if (path != null) {
      _json["path"] = path;
    }
    return _json;
  }
}

/// URL pattern and description of how the URL should be handled. App Engine can
/// handle URLs by executing application code, or by serving static files
/// uploaded with the version, such as images, CSS, or JavaScript.
class UrlMap {
  /// Uses API Endpoints to handle requests.
  ApiEndpointHandler apiEndpoint;

  /// Action to take when users access resources that require authentication.
  /// Defaults to redirect.
  /// Possible string values are:
  /// - "AUTH_FAIL_ACTION_UNSPECIFIED" : Not specified.
  /// AUTH_FAIL_ACTION_REDIRECT is assumed.
  /// - "AUTH_FAIL_ACTION_REDIRECT" : Redirects user to "accounts.google.com".
  /// The user is redirected back to the application URL after signing in or
  /// creating an account.
  /// - "AUTH_FAIL_ACTION_UNAUTHORIZED" : Rejects request with a 401 HTTP status
  /// code and an error message.
  core.String authFailAction;

  /// Level of login required to access this resource.
  /// Possible string values are:
  /// - "LOGIN_UNSPECIFIED" : Not specified. LOGIN_OPTIONAL is assumed.
  /// - "LOGIN_OPTIONAL" : Does not require that the user is signed in.
  /// - "LOGIN_ADMIN" : If the user is not signed in, the auth_fail_action is
  /// taken. In addition, if the user is not an administrator for the
  /// application, they are given an error message regardless of
  /// auth_fail_action. If the user is an administrator, the handler proceeds.
  /// - "LOGIN_REQUIRED" : If the user has signed in, the handler proceeds
  /// normally. Otherwise, the auth_fail_action is taken.
  core.String login;

  /// 30x code to use when performing redirects for the secure field. Defaults
  /// to 302.
  /// Possible string values are:
  /// - "REDIRECT_HTTP_RESPONSE_CODE_UNSPECIFIED" : Not specified. 302 is
  /// assumed.
  /// - "REDIRECT_HTTP_RESPONSE_CODE_301" : 301 Moved Permanently code.
  /// - "REDIRECT_HTTP_RESPONSE_CODE_302" : 302 Moved Temporarily code.
  /// - "REDIRECT_HTTP_RESPONSE_CODE_303" : 303 See Other code.
  /// - "REDIRECT_HTTP_RESPONSE_CODE_307" : 307 Temporary Redirect code.
  core.String redirectHttpResponseCode;

  /// Executes a script to handle the request that matches this URL pattern.
  ScriptHandler script;

  /// Security (HTTPS) enforcement for this URL.
  /// Possible string values are:
  /// - "SECURE_UNSPECIFIED" : Not specified.
  /// - "SECURE_DEFAULT" : Both HTTP and HTTPS requests with URLs that match the
  /// handler succeed without redirects. The application can examine the request
  /// to determine which protocol was used, and respond accordingly.
  /// - "SECURE_NEVER" : Requests for a URL that match this handler that use
  /// HTTPS are automatically redirected to the HTTP equivalent URL.
  /// - "SECURE_OPTIONAL" : Both HTTP and HTTPS requests with URLs that match
  /// the handler succeed without redirects. The application can examine the
  /// request to determine which protocol was used and respond accordingly.
  /// - "SECURE_ALWAYS" : Requests for a URL that match this handler that do not
  /// use HTTPS are automatically redirected to the HTTPS URL with the same
  /// path. Query parameters are reserved for the redirect.
  core.String securityLevel;

  /// Serves the entire contents of a directory as static files.This attribute
  /// is deprecated. You can mimic the behavior of static directories using
  /// static files.
  StaticDirectoryHandler staticDirectory;

  /// Returns the contents of a file, such as an image, as the response.
  StaticFilesHandler staticFiles;

  /// A URL prefix. Uses regular expression syntax, which means regexp special
  /// characters must be escaped, but should not contain groupings. All URLs
  /// that begin with this prefix are handled by this handler, using the portion
  /// of the URL after the prefix as part of the file path.
  core.String urlRegex;

  UrlMap();

  UrlMap.fromJson(core.Map _json) {
    if (_json.containsKey("apiEndpoint")) {
      apiEndpoint = new ApiEndpointHandler.fromJson(_json["apiEndpoint"]);
    }
    if (_json.containsKey("authFailAction")) {
      authFailAction = _json["authFailAction"];
    }
    if (_json.containsKey("login")) {
      login = _json["login"];
    }
    if (_json.containsKey("redirectHttpResponseCode")) {
      redirectHttpResponseCode = _json["redirectHttpResponseCode"];
    }
    if (_json.containsKey("script")) {
      script = new ScriptHandler.fromJson(_json["script"]);
    }
    if (_json.containsKey("securityLevel")) {
      securityLevel = _json["securityLevel"];
    }
    if (_json.containsKey("staticDirectory")) {
      staticDirectory =
          new StaticDirectoryHandler.fromJson(_json["staticDirectory"]);
    }
    if (_json.containsKey("staticFiles")) {
      staticFiles = new StaticFilesHandler.fromJson(_json["staticFiles"]);
    }
    if (_json.containsKey("urlRegex")) {
      urlRegex = _json["urlRegex"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (apiEndpoint != null) {
      _json["apiEndpoint"] = (apiEndpoint).toJson();
    }
    if (authFailAction != null) {
      _json["authFailAction"] = authFailAction;
    }
    if (login != null) {
      _json["login"] = login;
    }
    if (redirectHttpResponseCode != null) {
      _json["redirectHttpResponseCode"] = redirectHttpResponseCode;
    }
    if (script != null) {
      _json["script"] = (script).toJson();
    }
    if (securityLevel != null) {
      _json["securityLevel"] = securityLevel;
    }
    if (staticDirectory != null) {
      _json["staticDirectory"] = (staticDirectory).toJson();
    }
    if (staticFiles != null) {
      _json["staticFiles"] = (staticFiles).toJson();
    }
    if (urlRegex != null) {
      _json["urlRegex"] = urlRegex;
    }
    return _json;
  }
}

/// A Version resource is a specific set of source code and configuration files
/// that are deployed into a module.
class Version {
  /// Serving configuration for Google Cloud Endpoints
  /// (https://cloud.google.com/appengine/docs/python/endpoints/).Only returned
  /// in GET requests if view=FULL is set.
  ApiConfigHandler apiConfig;

  /// Automatic scaling is based on request rate, response latencies, and other
  /// application metrics.
  AutomaticScaling automaticScaling;

  /// A module with basic scaling will create an instance when the application
  /// receives a request. The instance will be turned down when the app becomes
  /// idle. Basic scaling is ideal for work that is intermittent or driven by
  /// user activity.
  BasicScaling basicScaling;

  /// Metadata settings that are supplied to this version to enable beta runtime
  /// features.
  core.Map<core.String, core.String> betaSettings;

  /// Time that this version was created.@OutputOnly
  core.String creationTime;

  /// Duration that static files should be cached by web proxies and browsers.
  /// Only applicable if the corresponding StaticFilesHandler
  /// (https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1/apps.services.versions#staticfileshandler)
  /// does not specify its own expiration time.Only returned in GET requests if
  /// view=FULL is set.
  core.String defaultExpiration;

  /// Email address of the user who created this version.@OutputOnly
  core.String deployer;

  /// Code and application artifacts that make up this version.Only returned in
  /// GET requests if view=FULL is set.
  Deployment deployment;

  /// App Engine execution environment to use for this version.Defaults to 1.
  core.String env;

  /// Environment variables made available to the application.Only returned in
  /// GET requests if view=FULL is set.
  core.Map<core.String, core.String> envVariables;

  /// Custom static error pages. Limited to 10KB per page.Only returned in GET
  /// requests if view=FULL is set.
  core.List<ErrorHandler> errorHandlers;

  /// An ordered list of URL-matching patterns that should be applied to
  /// incoming requests. The first matching URL handles the request and other
  /// request handlers are not attempted.Only returned in GET requests if
  /// view=FULL is set.
  core.List<UrlMap> handlers;

  /// Configures health checking for VM instances. Unhealthy instances are
  /// stopped and replaced with new instances. Only applicable for VM
  /// runtimes.Only returned in GET requests if view=FULL is set.
  HealthCheck healthCheck;

  /// Relative name of the version within the module. Example: v1. Version names
  /// can contain only lowercase letters, numbers, or hyphens. Reserved names:
  /// "default", "latest", and any name with the prefix "ah-".
  core.String id;

  /// Before an application can receive email or XMPP messages, the application
  /// must be configured to enable the service.
  core.List<core.String> inboundServices;

  /// Instance class that is used to run this version. Valid values are:
  /// AutomaticScaling: F1, F2, F4, F4_1G
  /// ManualScaling or BasicScaling: B1, B2, B4, B8, B4_1GDefaults to F1 for
  /// AutomaticScaling and B1 for ManualScaling or BasicScaling.
  core.String instanceClass;

  /// Configuration for third-party Python runtime libraries required by the
  /// application.Only returned in GET requests if view=FULL is set.
  core.List<Library> libraries;

  /// A module with manual scaling runs continuously, allowing you to perform
  /// complex initialization and rely on the state of its memory over time.
  ManualScaling manualScaling;

  /// Full path to the Version resource in the API. Example:
  /// apps/myapp/modules/default/versions/v1.@OutputOnly
  core.String name;

  /// Extra network settings. Only applicable for VM runtimes.
  Network network;

  /// Files that match this pattern will not be built into this version. Only
  /// applicable for Go runtimes.Only returned in GET requests if view=FULL is
  /// set.
  core.String nobuildFilesRegex;

  /// Machine resources for this version. Only applicable for VM runtimes.
  Resources resources;

  /// Desired runtime. Example: python27.
  core.String runtime;

  /// The version of the API in the given runtime environment. Please see the
  /// app.yaml reference for valid values at
  /// https://cloud.google.com/appengine/docs/standard/<language>/config/appref
  core.String runtimeApiVersion;

  /// Current serving status of this version. Only the versions with a SERVING
  /// status create instances and can be billed.SERVING_STATUS_UNSPECIFIED is an
  /// invalid value. Defaults to SERVING.
  /// Possible string values are:
  /// - "SERVING_STATUS_UNSPECIFIED" : Not specified.
  /// - "SERVING" : Currently serving. Instances are created according to the
  /// scaling settings of the version.
  /// - "STOPPED" : Disabled. No instances will be created and the scaling
  /// settings are ignored until the state of the version changes to SERVING.
  core.String servingStatus;

  /// Whether multiple requests can be dispatched to this version at once.
  core.bool threadsafe;

  /// Whether to deploy this version in a container on a virtual machine.
  core.bool vm;

  Version();

  Version.fromJson(core.Map _json) {
    if (_json.containsKey("apiConfig")) {
      apiConfig = new ApiConfigHandler.fromJson(_json["apiConfig"]);
    }
    if (_json.containsKey("automaticScaling")) {
      automaticScaling =
          new AutomaticScaling.fromJson(_json["automaticScaling"]);
    }
    if (_json.containsKey("basicScaling")) {
      basicScaling = new BasicScaling.fromJson(_json["basicScaling"]);
    }
    if (_json.containsKey("betaSettings")) {
      betaSettings = _json["betaSettings"];
    }
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("defaultExpiration")) {
      defaultExpiration = _json["defaultExpiration"];
    }
    if (_json.containsKey("deployer")) {
      deployer = _json["deployer"];
    }
    if (_json.containsKey("deployment")) {
      deployment = new Deployment.fromJson(_json["deployment"]);
    }
    if (_json.containsKey("env")) {
      env = _json["env"];
    }
    if (_json.containsKey("envVariables")) {
      envVariables = _json["envVariables"];
    }
    if (_json.containsKey("errorHandlers")) {
      errorHandlers = _json["errorHandlers"]
          .map((value) => new ErrorHandler.fromJson(value))
          .toList();
    }
    if (_json.containsKey("handlers")) {
      handlers =
          _json["handlers"].map((value) => new UrlMap.fromJson(value)).toList();
    }
    if (_json.containsKey("healthCheck")) {
      healthCheck = new HealthCheck.fromJson(_json["healthCheck"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("inboundServices")) {
      inboundServices = _json["inboundServices"];
    }
    if (_json.containsKey("instanceClass")) {
      instanceClass = _json["instanceClass"];
    }
    if (_json.containsKey("libraries")) {
      libraries = _json["libraries"]
          .map((value) => new Library.fromJson(value))
          .toList();
    }
    if (_json.containsKey("manualScaling")) {
      manualScaling = new ManualScaling.fromJson(_json["manualScaling"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("network")) {
      network = new Network.fromJson(_json["network"]);
    }
    if (_json.containsKey("nobuildFilesRegex")) {
      nobuildFilesRegex = _json["nobuildFilesRegex"];
    }
    if (_json.containsKey("resources")) {
      resources = new Resources.fromJson(_json["resources"]);
    }
    if (_json.containsKey("runtime")) {
      runtime = _json["runtime"];
    }
    if (_json.containsKey("runtimeApiVersion")) {
      runtimeApiVersion = _json["runtimeApiVersion"];
    }
    if (_json.containsKey("servingStatus")) {
      servingStatus = _json["servingStatus"];
    }
    if (_json.containsKey("threadsafe")) {
      threadsafe = _json["threadsafe"];
    }
    if (_json.containsKey("vm")) {
      vm = _json["vm"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (apiConfig != null) {
      _json["apiConfig"] = (apiConfig).toJson();
    }
    if (automaticScaling != null) {
      _json["automaticScaling"] = (automaticScaling).toJson();
    }
    if (basicScaling != null) {
      _json["basicScaling"] = (basicScaling).toJson();
    }
    if (betaSettings != null) {
      _json["betaSettings"] = betaSettings;
    }
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (defaultExpiration != null) {
      _json["defaultExpiration"] = defaultExpiration;
    }
    if (deployer != null) {
      _json["deployer"] = deployer;
    }
    if (deployment != null) {
      _json["deployment"] = (deployment).toJson();
    }
    if (env != null) {
      _json["env"] = env;
    }
    if (envVariables != null) {
      _json["envVariables"] = envVariables;
    }
    if (errorHandlers != null) {
      _json["errorHandlers"] =
          errorHandlers.map((value) => (value).toJson()).toList();
    }
    if (handlers != null) {
      _json["handlers"] = handlers.map((value) => (value).toJson()).toList();
    }
    if (healthCheck != null) {
      _json["healthCheck"] = (healthCheck).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (inboundServices != null) {
      _json["inboundServices"] = inboundServices;
    }
    if (instanceClass != null) {
      _json["instanceClass"] = instanceClass;
    }
    if (libraries != null) {
      _json["libraries"] = libraries.map((value) => (value).toJson()).toList();
    }
    if (manualScaling != null) {
      _json["manualScaling"] = (manualScaling).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (network != null) {
      _json["network"] = (network).toJson();
    }
    if (nobuildFilesRegex != null) {
      _json["nobuildFilesRegex"] = nobuildFilesRegex;
    }
    if (resources != null) {
      _json["resources"] = (resources).toJson();
    }
    if (runtime != null) {
      _json["runtime"] = runtime;
    }
    if (runtimeApiVersion != null) {
      _json["runtimeApiVersion"] = runtimeApiVersion;
    }
    if (servingStatus != null) {
      _json["servingStatus"] = servingStatus;
    }
    if (threadsafe != null) {
      _json["threadsafe"] = threadsafe;
    }
    if (vm != null) {
      _json["vm"] = vm;
    }
    return _json;
  }
}

/// Volumes mounted within the app container. Only applicable for VM runtimes.
class Volume {
  /// Unique name for the volume.
  core.String name;

  /// Volume size in gigabytes.
  core.double sizeGb;

  /// Underlying volume type, e.g. 'tmpfs'.
  core.String volumeType;

  Volume();

  Volume.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("sizeGb")) {
      sizeGb = _json["sizeGb"];
    }
    if (_json.containsKey("volumeType")) {
      volumeType = _json["volumeType"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (name != null) {
      _json["name"] = name;
    }
    if (sizeGb != null) {
      _json["sizeGb"] = sizeGb;
    }
    if (volumeType != null) {
      _json["volumeType"] = volumeType;
    }
    return _json;
  }
}
