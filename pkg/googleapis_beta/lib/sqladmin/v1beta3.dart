// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.sqladmin.v1beta3;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client sqladmin/v1beta3';

/// Creates and configures Cloud SQL instances, which provide fully-managed
/// MySQL databases.
class SqladminApi {
  /// View and manage your data across Google Cloud Platform services
  static const CloudPlatformScope =
      "https://www.googleapis.com/auth/cloud-platform";

  /// Manage your Google SQL Service instances
  static const SqlserviceAdminScope =
      "https://www.googleapis.com/auth/sqlservice.admin";

  final commons.ApiRequester _requester;

  BackupRunsResourceApi get backupRuns => new BackupRunsResourceApi(_requester);
  FlagsResourceApi get flags => new FlagsResourceApi(_requester);
  InstancesResourceApi get instances => new InstancesResourceApi(_requester);
  OperationsResourceApi get operations => new OperationsResourceApi(_requester);
  SslCertsResourceApi get sslCerts => new SslCertsResourceApi(_requester);
  TiersResourceApi get tiers => new TiersResourceApi(_requester);

  SqladminApi(http.Client client,
      {core.String rootUrl: "https://www.googleapis.com/",
      core.String servicePath: "sql/v1beta3/"})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class BackupRunsResourceApi {
  final commons.ApiRequester _requester;

  BackupRunsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Retrieves information about a specified backup run for a Cloud SQL
  /// instance.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// [backupConfiguration] - Identifier for the backup configuration. This gets
  /// generated automatically when a backup configuration is created.
  ///
  /// [dueTime] - The start time of the four-hour backup window. The backup can
  /// occur any time in the window. The time is in RFC 3339 format, for example
  /// 2012-11-15T16:19:00.094Z.
  ///
  /// Completes with a [BackupRun].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<BackupRun> get(core.String project, core.String instance,
      core.String backupConfiguration, core.String dueTime) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }
    if (backupConfiguration == null) {
      throw new core.ArgumentError(
          "Parameter backupConfiguration is required.");
    }
    if (dueTime == null) {
      throw new core.ArgumentError("Parameter dueTime is required.");
    }
    _queryParams["dueTime"] = [dueTime];

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/backupRuns/' +
        commons.Escaper.ecapeVariable('$backupConfiguration');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new BackupRun.fromJson(data));
  }

  /// Lists all backup runs associated with a Cloud SQL instance.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// [backupConfiguration] - Identifier for the backup configuration. This gets
  /// generated automatically when a backup configuration is created.
  ///
  /// [maxResults] - Maximum number of backup runs per response.
  ///
  /// [pageToken] - A previously-returned page token representing part of the
  /// larger set of results to view.
  ///
  /// Completes with a [BackupRunsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<BackupRunsListResponse> list(core.String project,
      core.String instance, core.String backupConfiguration,
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
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }
    if (backupConfiguration == null) {
      throw new core.ArgumentError(
          "Parameter backupConfiguration is required.");
    }
    _queryParams["backupConfiguration"] = [backupConfiguration];
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/backupRuns';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new BackupRunsListResponse.fromJson(data));
  }
}

class FlagsResourceApi {
  final commons.ApiRequester _requester;

  FlagsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Lists all database flags that can be set for Google Cloud SQL instances.
  ///
  /// Request parameters:
  ///
  /// Completes with a [FlagsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<FlagsListResponse> list() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    _url = 'flags';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new FlagsListResponse.fromJson(data));
  }
}

class InstancesResourceApi {
  final commons.ApiRequester _requester;

  InstancesResourceApi(commons.ApiRequester client) : _requester = client;

  /// Creates a Cloud SQL instance as a clone of a source instance.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the source as well as the clone Cloud SQL
  /// instance.
  ///
  /// Completes with a [InstancesCloneResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesCloneResponse> clone(
      InstancesCloneRequest request, core.String project) {
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

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/clone';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new InstancesCloneResponse.fromJson(data));
  }

  /// Deletes a Cloud SQL instance.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance to be
  /// deleted.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// Completes with a [InstancesDeleteResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesDeleteResponse> delete(
      core.String project, core.String instance) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new InstancesDeleteResponse.fromJson(data));
  }

  /// Exports data from a Cloud SQL instance to a Google Cloud Storage bucket as
  /// a MySQL dump file.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance to be
  /// exported.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// Completes with a [InstancesExportResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesExportResponse> export(InstancesExportRequest request,
      core.String project, core.String instance) {
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
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/export';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new InstancesExportResponse.fromJson(data));
  }

  /// Retrieves information about a Cloud SQL instance.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance.
  ///
  /// [instance] - Database instance ID. This does not include the project ID.
  ///
  /// Completes with a [DatabaseInstance].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<DatabaseInstance> get(
      core.String project, core.String instance) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new DatabaseInstance.fromJson(data));
  }

  /// Imports data into a Cloud SQL instance from a MySQL dump file stored in a
  /// Google Cloud Storage bucket.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// Completes with a [InstancesImportResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesImportResponse> import(InstancesImportRequest request,
      core.String project, core.String instance) {
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
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/import';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new InstancesImportResponse.fromJson(data));
  }

  /// Creates a new Cloud SQL instance.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project to which the newly created Cloud SQL
  /// instances should belong.
  ///
  /// Completes with a [InstancesInsertResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesInsertResponse> insert(
      DatabaseInstance request, core.String project) {
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

    _url =
        'projects/' + commons.Escaper.ecapeVariable('$project') + '/instances';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new InstancesInsertResponse.fromJson(data));
  }

  /// Lists instances for a given project, in alphabetical order by instance
  /// name.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project for which to list Cloud SQL
  /// instances.
  ///
  /// [maxResults] - The maximum number of results to return per response.
  ///
  /// [pageToken] - A previously-returned page token representing part of the
  /// larger set of results to view.
  ///
  /// Completes with a [InstancesListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesListResponse> list(core.String project,
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
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url =
        'projects/' + commons.Escaper.ecapeVariable('$project') + '/instances';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new InstancesListResponse.fromJson(data));
  }

  /// Updates the settings of a Cloud SQL instance. This method supports patch
  /// semantics.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// Completes with a [InstancesUpdateResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesUpdateResponse> patch(
      DatabaseInstance request, core.String project, core.String instance) {
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
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance');

    var _response = _requester.request(_url, "PATCH",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new InstancesUpdateResponse.fromJson(data));
  }

  /// Promotes the read replica instance to be a stand-alone Cloud SQL instance.
  ///
  /// Request parameters:
  ///
  /// [project] - ID of the project that contains the read replica.
  ///
  /// [instance] - Cloud SQL read replica instance name.
  ///
  /// Completes with a [InstancesPromoteReplicaResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesPromoteReplicaResponse> promoteReplica(
      core.String project, core.String instance) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/promoteReplica';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new InstancesPromoteReplicaResponse.fromJson(data));
  }

  /// Deletes all client certificates and generates a new server SSL certificate
  /// for a Cloud SQL instance.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// Completes with a [InstancesResetSslConfigResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesResetSslConfigResponse> resetSslConfig(
      core.String project, core.String instance) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/resetSslConfig';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new InstancesResetSslConfigResponse.fromJson(data));
  }

  /// Restarts a Cloud SQL instance.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance to be
  /// restarted.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// Completes with a [InstancesRestartResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesRestartResponse> restart(
      core.String project, core.String instance) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/restart';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new InstancesRestartResponse.fromJson(data));
  }

  /// Restores a backup of a Cloud SQL instance.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// [backupConfiguration] - The identifier of the backup configuration. This
  /// gets generated automatically when a backup configuration is created.
  ///
  /// [dueTime] - The start time of the four-hour backup window. The backup can
  /// occur any time in the window. The time is in RFC 3339 format, for example
  /// 2012-11-15T16:19:00.094Z.
  ///
  /// Completes with a [InstancesRestoreBackupResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesRestoreBackupResponse> restoreBackup(
      core.String project,
      core.String instance,
      core.String backupConfiguration,
      core.String dueTime) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }
    if (backupConfiguration == null) {
      throw new core.ArgumentError(
          "Parameter backupConfiguration is required.");
    }
    _queryParams["backupConfiguration"] = [backupConfiguration];
    if (dueTime == null) {
      throw new core.ArgumentError("Parameter dueTime is required.");
    }
    _queryParams["dueTime"] = [dueTime];

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/restoreBackup';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new InstancesRestoreBackupResponse.fromJson(data));
  }

  /// Sets the password for the root user of the specified Cloud SQL instance.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// Completes with a [InstancesSetRootPasswordResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesSetRootPasswordResponse> setRootPassword(
      InstanceSetRootPasswordRequest request,
      core.String project,
      core.String instance) {
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
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/setRootPassword';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new InstancesSetRootPasswordResponse.fromJson(data));
  }

  /// Updates the settings of a Cloud SQL instance.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// Completes with a [InstancesUpdateResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstancesUpdateResponse> update(
      DatabaseInstance request, core.String project, core.String instance) {
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
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new InstancesUpdateResponse.fromJson(data));
  }
}

class OperationsResourceApi {
  final commons.ApiRequester _requester;

  OperationsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Retrieves information about a specific operation that was performed on a
  /// Cloud SQL instance.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// [operation] - Instance operation ID.
  ///
  /// Completes with a [InstanceOperation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<InstanceOperation> get(
      core.String project, core.String instance, core.String operation) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }
    if (operation == null) {
      throw new core.ArgumentError("Parameter operation is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/operations/' +
        commons.Escaper.ecapeVariable('$operation');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new InstanceOperation.fromJson(data));
  }

  /// Lists all operations that have been performed on a Cloud SQL instance.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// [maxResults] - Maximum number of operations per response.
  ///
  /// [pageToken] - A previously-returned page token representing part of the
  /// larger set of results to view.
  ///
  /// Completes with a [OperationsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OperationsListResponse> list(
      core.String project, core.String instance,
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
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/operations';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new OperationsListResponse.fromJson(data));
  }
}

class SslCertsResourceApi {
  final commons.ApiRequester _requester;

  SslCertsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Deletes an SSL certificate from a Cloud SQL instance.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance to be
  /// deleted.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// [sha1Fingerprint] - Sha1 FingerPrint.
  ///
  /// Completes with a [SslCertsDeleteResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SslCertsDeleteResponse> delete(
      core.String project, core.String instance, core.String sha1Fingerprint) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }
    if (sha1Fingerprint == null) {
      throw new core.ArgumentError("Parameter sha1Fingerprint is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/sslCerts/' +
        commons.Escaper.ecapeVariable('$sha1Fingerprint');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new SslCertsDeleteResponse.fromJson(data));
  }

  /// Retrieves an SSL certificate as specified by its SHA-1 fingerprint.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project that contains the instance.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// [sha1Fingerprint] - Sha1 FingerPrint.
  ///
  /// Completes with a [SslCert].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SslCert> get(
      core.String project, core.String instance, core.String sha1Fingerprint) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }
    if (sha1Fingerprint == null) {
      throw new core.ArgumentError("Parameter sha1Fingerprint is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/sslCerts/' +
        commons.Escaper.ecapeVariable('$sha1Fingerprint');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new SslCert.fromJson(data));
  }

  /// Creates an SSL certificate and returns the certificate, the associated
  /// private key, and the server certificate authority.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project to which the newly created Cloud SQL
  /// instances should belong.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// Completes with a [SslCertsInsertResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SslCertsInsertResponse> insert(SslCertsInsertRequest request,
      core.String project, core.String instance) {
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
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/sslCerts';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new SslCertsInsertResponse.fromJson(data));
  }

  /// Lists all of the current SSL certificates defined for a Cloud SQL
  /// instance.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project for which to list Cloud SQL
  /// instances.
  ///
  /// [instance] - Cloud SQL instance ID. This does not include the project ID.
  ///
  /// Completes with a [SslCertsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SslCertsListResponse> list(
      core.String project, core.String instance) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }

    _url = 'projects/' +
        commons.Escaper.ecapeVariable('$project') +
        '/instances/' +
        commons.Escaper.ecapeVariable('$instance') +
        '/sslCerts';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new SslCertsListResponse.fromJson(data));
  }
}

class TiersResourceApi {
  final commons.ApiRequester _requester;

  TiersResourceApi(commons.ApiRequester client) : _requester = client;

  /// Lists service tiers that can be used to create Google Cloud SQL instances.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID of the project for which to list tiers.
  ///
  /// Completes with a [TiersListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<TiersListResponse> list(core.String project) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }

    _url = 'projects/' + commons.Escaper.ecapeVariable('$project') + '/tiers';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new TiersListResponse.fromJson(data));
  }
}

/// Database instance backup configuration.
class BackupConfiguration {
  /// Whether binary log is enabled. If backup configuration is disabled, binary
  /// log must be disabled as well.
  core.bool binaryLogEnabled;

  /// Whether this configuration is enabled.
  core.bool enabled;

  /// Identifier for this configuration. This gets generated automatically when
  /// a backup configuration is created.
  core.String id;

  /// This is always sql#backupConfiguration.
  core.String kind;

  /// Start time for the daily backup configuration in UTC timezone in the 24
  /// hour format - HH:MM.
  core.String startTime;

  BackupConfiguration();

  BackupConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("binaryLogEnabled")) {
      binaryLogEnabled = _json["binaryLogEnabled"];
    }
    if (_json.containsKey("enabled")) {
      enabled = _json["enabled"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (binaryLogEnabled != null) {
      _json["binaryLogEnabled"] = binaryLogEnabled;
    }
    if (enabled != null) {
      _json["enabled"] = enabled;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

/// A database instance backup run resource.
class BackupRun {
  /// Backup Configuration identifier.
  core.String backupConfiguration;

  /// The due time of this run in UTC timezone in RFC 3339 format, for example
  /// 2012-11-15T16:19:00.094Z.
  core.DateTime dueTime;

  /// The time the backup operation completed in UTC timezone in RFC 3339
  /// format, for example 2012-11-15T16:19:00.094Z.
  core.DateTime endTime;

  /// The time the run was enqueued in UTC timezone in RFC 3339 format, for
  /// example 2012-11-15T16:19:00.094Z.
  core.DateTime enqueuedTime;

  /// Information about why the backup operation failed. This is only present if
  /// the run has the FAILED status.
  OperationError error;

  /// Name of the database instance.
  core.String instance;

  /// This is always sql#backupRun.
  core.String kind;

  /// The time the backup operation actually started in UTC timezone in RFC 3339
  /// format, for example 2012-11-15T16:19:00.094Z.
  core.DateTime startTime;

  /// The status of this run.
  core.String status;

  BackupRun();

  BackupRun.fromJson(core.Map _json) {
    if (_json.containsKey("backupConfiguration")) {
      backupConfiguration = _json["backupConfiguration"];
    }
    if (_json.containsKey("dueTime")) {
      dueTime = core.DateTime.parse(_json["dueTime"]);
    }
    if (_json.containsKey("endTime")) {
      endTime = core.DateTime.parse(_json["endTime"]);
    }
    if (_json.containsKey("enqueuedTime")) {
      enqueuedTime = core.DateTime.parse(_json["enqueuedTime"]);
    }
    if (_json.containsKey("error")) {
      error = new OperationError.fromJson(_json["error"]);
    }
    if (_json.containsKey("instance")) {
      instance = _json["instance"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("startTime")) {
      startTime = core.DateTime.parse(_json["startTime"]);
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (backupConfiguration != null) {
      _json["backupConfiguration"] = backupConfiguration;
    }
    if (dueTime != null) {
      _json["dueTime"] = (dueTime).toIso8601String();
    }
    if (endTime != null) {
      _json["endTime"] = (endTime).toIso8601String();
    }
    if (enqueuedTime != null) {
      _json["enqueuedTime"] = (enqueuedTime).toIso8601String();
    }
    if (error != null) {
      _json["error"] = (error).toJson();
    }
    if (instance != null) {
      _json["instance"] = instance;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (startTime != null) {
      _json["startTime"] = (startTime).toIso8601String();
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/// Backup run list results.
class BackupRunsListResponse {
  /// A list of backup runs in reverse chronological order of the enqueued time.
  core.List<BackupRun> items;

  /// This is always sql#backupRunsList.
  core.String kind;

  /// The continuation token, used to page through large result sets. Provide
  /// this value in a subsequent request to return the next page of results.
  core.String nextPageToken;

  BackupRunsListResponse();

  BackupRunsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items =
          _json["items"].map((value) => new BackupRun.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Binary log coordinates.
class BinLogCoordinates {
  /// Name of the binary log file for a Cloud SQL instance.
  core.String binLogFileName;

  /// Position (offset) within the binary log file.
  core.String binLogPosition;

  /// This is always sql#binLogCoordinates.
  core.String kind;

  BinLogCoordinates();

  BinLogCoordinates.fromJson(core.Map _json) {
    if (_json.containsKey("binLogFileName")) {
      binLogFileName = _json["binLogFileName"];
    }
    if (_json.containsKey("binLogPosition")) {
      binLogPosition = _json["binLogPosition"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (binLogFileName != null) {
      _json["binLogFileName"] = binLogFileName;
    }
    if (binLogPosition != null) {
      _json["binLogPosition"] = binLogPosition;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/// Database instance clone context.
class CloneContext {
  /// Binary log coordinates, if specified, indentify the position up to which
  /// the source instance should be cloned. If not specified, the source
  /// instance is cloned up to the most recent binary log coordinates.
  BinLogCoordinates binLogCoordinates;

  /// Name of the Cloud SQL instance to be created as a clone.
  core.String destinationInstanceName;

  /// This is always sql#cloneContext.
  core.String kind;

  /// Name of the Cloud SQL instance to be cloned.
  core.String sourceInstanceName;

  CloneContext();

  CloneContext.fromJson(core.Map _json) {
    if (_json.containsKey("binLogCoordinates")) {
      binLogCoordinates =
          new BinLogCoordinates.fromJson(_json["binLogCoordinates"]);
    }
    if (_json.containsKey("destinationInstanceName")) {
      destinationInstanceName = _json["destinationInstanceName"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("sourceInstanceName")) {
      sourceInstanceName = _json["sourceInstanceName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (binLogCoordinates != null) {
      _json["binLogCoordinates"] = (binLogCoordinates).toJson();
    }
    if (destinationInstanceName != null) {
      _json["destinationInstanceName"] = destinationInstanceName;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (sourceInstanceName != null) {
      _json["sourceInstanceName"] = sourceInstanceName;
    }
    return _json;
  }
}

/// MySQL flags for Cloud SQL instances.
class DatabaseFlags {
  /// The name of the flag. These flags are passed at instance startup, so
  /// include both MySQL server options and MySQL system variables. Flags should
  /// be specified with underscores, not hyphens. For more information, see
  /// Configuring MySQL Flags in the Google Cloud SQL documentation, as well as
  /// the official MySQL documentation for server options and system variables.
  core.String name;

  /// The value of the flag. Booleans should be set to on for true and off for
  /// false. This field must be omitted if the flag doesn't take a value.
  core.String value;

  DatabaseFlags();

  DatabaseFlags.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (name != null) {
      _json["name"] = name;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/// A Cloud SQL instance resource.
class DatabaseInstance {
  /// Connection name of the Cloud SQL instance used in connection strings.
  core.String connectionName;

  /// The current disk usage of the instance in bytes.
  core.String currentDiskSize;

  /// The database engine type and version. Can be MYSQL_5_5 or MYSQL_5_6.
  /// Defaults to MYSQL_5_5. The databaseVersion cannot be changed after
  /// instance creation.
  core.String databaseVersion;

  /// HTTP 1.1 Entity tag for the resource.
  core.String etag;

  /// Name of the Cloud SQL instance. This does not include the project ID.
  core.String instance;

  /// The instance type. This can be one of the following.
  /// CLOUD_SQL_INSTANCE: Regular Cloud SQL instance.
  /// READ_REPLICA_INSTANCE: Cloud SQL instance acting as a read-replica.
  core.String instanceType;

  /// The assigned IP addresses for the instance.
  core.List<IpMapping> ipAddresses;

  /// The IPv6 address assigned to the instance.
  core.String ipv6Address;

  /// This is always sql#instance.
  core.String kind;

  /// The name of the instance which will act as master in the replication
  /// setup.
  core.String masterInstanceName;

  /// The maximum disk size of the instance in bytes.
  core.String maxDiskSize;

  /// The project ID of the project containing the Cloud SQL instance. The
  /// Google apps domain is prefixed if applicable.
  core.String project;

  /// The geographical region. Can be us-central, asia-east1 or europe-west1.
  /// Defaults to us-central. The region can not be changed after instance
  /// creation.
  core.String region;

  /// The replicas of the instance.
  core.List<core.String> replicaNames;

  /// SSL configuration.
  SslCert serverCaCert;

  /// The service account email address assigned to the instance.
  core.String serviceAccountEmailAddress;

  /// The user settings.
  Settings settings;

  /// The current serving state of the Cloud SQL instance. This can be one of
  /// the following.
  /// RUNNABLE: The instance is running, or is ready to run when accessed.
  /// SUSPENDED: The instance is not available, for example due to problems with
  /// billing.
  /// PENDING_CREATE: The instance is being created.
  /// MAINTENANCE: The instance is down for maintenance.
  /// UNKNOWN_STATE: The state of the instance is unknown.
  core.String state;

  DatabaseInstance();

  DatabaseInstance.fromJson(core.Map _json) {
    if (_json.containsKey("connectionName")) {
      connectionName = _json["connectionName"];
    }
    if (_json.containsKey("currentDiskSize")) {
      currentDiskSize = _json["currentDiskSize"];
    }
    if (_json.containsKey("databaseVersion")) {
      databaseVersion = _json["databaseVersion"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("instance")) {
      instance = _json["instance"];
    }
    if (_json.containsKey("instanceType")) {
      instanceType = _json["instanceType"];
    }
    if (_json.containsKey("ipAddresses")) {
      ipAddresses = _json["ipAddresses"]
          .map((value) => new IpMapping.fromJson(value))
          .toList();
    }
    if (_json.containsKey("ipv6Address")) {
      ipv6Address = _json["ipv6Address"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("masterInstanceName")) {
      masterInstanceName = _json["masterInstanceName"];
    }
    if (_json.containsKey("maxDiskSize")) {
      maxDiskSize = _json["maxDiskSize"];
    }
    if (_json.containsKey("project")) {
      project = _json["project"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("replicaNames")) {
      replicaNames = _json["replicaNames"];
    }
    if (_json.containsKey("serverCaCert")) {
      serverCaCert = new SslCert.fromJson(_json["serverCaCert"]);
    }
    if (_json.containsKey("serviceAccountEmailAddress")) {
      serviceAccountEmailAddress = _json["serviceAccountEmailAddress"];
    }
    if (_json.containsKey("settings")) {
      settings = new Settings.fromJson(_json["settings"]);
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (connectionName != null) {
      _json["connectionName"] = connectionName;
    }
    if (currentDiskSize != null) {
      _json["currentDiskSize"] = currentDiskSize;
    }
    if (databaseVersion != null) {
      _json["databaseVersion"] = databaseVersion;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (instance != null) {
      _json["instance"] = instance;
    }
    if (instanceType != null) {
      _json["instanceType"] = instanceType;
    }
    if (ipAddresses != null) {
      _json["ipAddresses"] =
          ipAddresses.map((value) => (value).toJson()).toList();
    }
    if (ipv6Address != null) {
      _json["ipv6Address"] = ipv6Address;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (masterInstanceName != null) {
      _json["masterInstanceName"] = masterInstanceName;
    }
    if (maxDiskSize != null) {
      _json["maxDiskSize"] = maxDiskSize;
    }
    if (project != null) {
      _json["project"] = project;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (replicaNames != null) {
      _json["replicaNames"] = replicaNames;
    }
    if (serverCaCert != null) {
      _json["serverCaCert"] = (serverCaCert).toJson();
    }
    if (serviceAccountEmailAddress != null) {
      _json["serviceAccountEmailAddress"] = serviceAccountEmailAddress;
    }
    if (settings != null) {
      _json["settings"] = (settings).toJson();
    }
    if (state != null) {
      _json["state"] = state;
    }
    return _json;
  }
}

/// Database instance export context.
class ExportContext {
  /// Databases (for example, guestbook) from which the export is made. If
  /// unspecified, all databases are exported.
  core.List<core.String> database;

  /// This is always sql#exportContext.
  core.String kind;

  /// Tables to export, or that were exported, from the specified database. If
  /// you specify tables, specify one and only one database.
  core.List<core.String> table;

  /// The path to the file in Google Cloud Storage where the export will be
  /// stored, or where it was already stored. The URI is in the form
  /// gs://bucketName/fileName. If the file already exists, the operation fails.
  /// If the filename ends with .gz, the contents are compressed.
  core.String uri;

  ExportContext();

  ExportContext.fromJson(core.Map _json) {
    if (_json.containsKey("database")) {
      database = _json["database"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("table")) {
      table = _json["table"];
    }
    if (_json.containsKey("uri")) {
      uri = _json["uri"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (database != null) {
      _json["database"] = database;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (table != null) {
      _json["table"] = table;
    }
    if (uri != null) {
      _json["uri"] = uri;
    }
    return _json;
  }
}

/// A Google Cloud SQL service flag resource.
class Flag {
  /// For STRING flags, a list of strings that the value can be set to.
  core.List<core.String> allowedStringValues;

  /// The database version this flag applies to. Currently this can only be
  /// [MYSQL_5_5].
  core.List<core.String> appliesTo;

  /// This is always sql#flag.
  core.String kind;

  /// For INTEGER flags, the maximum allowed value.
  core.String maxValue;

  /// For INTEGER flags, the minimum allowed value.
  core.String minValue;

  /// This is the name of the flag. Flag names always use underscores, not
  /// hyphens, e.g. max_allowed_packet
  core.String name;

  /// The type of the flag. Flags are typed to being BOOLEAN, STRING, INTEGER or
  /// NONE. NONE is used for flags which do not take a value, such as
  /// skip_grant_tables.
  core.String type;

  Flag();

  Flag.fromJson(core.Map _json) {
    if (_json.containsKey("allowedStringValues")) {
      allowedStringValues = _json["allowedStringValues"];
    }
    if (_json.containsKey("appliesTo")) {
      appliesTo = _json["appliesTo"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("maxValue")) {
      maxValue = _json["maxValue"];
    }
    if (_json.containsKey("minValue")) {
      minValue = _json["minValue"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (allowedStringValues != null) {
      _json["allowedStringValues"] = allowedStringValues;
    }
    if (appliesTo != null) {
      _json["appliesTo"] = appliesTo;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (maxValue != null) {
      _json["maxValue"] = maxValue;
    }
    if (minValue != null) {
      _json["minValue"] = minValue;
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

/// Flags list response.
class FlagsListResponse {
  /// List of flags.
  core.List<Flag> items;

  /// This is always sql#flagsList.
  core.String kind;

  FlagsListResponse();

  FlagsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Flag.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    return _json;
  }
}

/// Database instance import context.
class ImportContext {
  /// The database (for example, guestbook) to which the import is made. If not
  /// set, it is assumed that the database is specified in the file to be
  /// imported.
  core.String database;

  /// This is always sql#importContext.
  core.String kind;

  /// A path to the MySQL dump file in Google Cloud Storage from which the
  /// import is made. The URI is in the form gs://bucketName/fileName.
  /// Compressed gzip files (.gz) are also supported.
  core.List<core.String> uri;

  ImportContext();

  ImportContext.fromJson(core.Map _json) {
    if (_json.containsKey("database")) {
      database = _json["database"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("uri")) {
      uri = _json["uri"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (database != null) {
      _json["database"] = database;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (uri != null) {
      _json["uri"] = uri;
    }
    return _json;
  }
}

/// An Operations resource contains information about database instance
/// operations such as create, delete, and restart. Operations resources are
/// created in response to operations that were initiated; you never create them
/// directly.
class InstanceOperation {
  /// The time this operation finished in UTC timezone in RFC 3339 format, for
  /// example 2012-11-15T16:19:00.094Z.
  core.DateTime endTime;

  /// The time this operation was enqueued in UTC timezone in RFC 3339 format,
  /// for example 2012-11-15T16:19:00.094Z.
  core.DateTime enqueuedTime;

  /// The error(s) encountered by this operation. Only set if the operation
  /// results in an error.
  core.List<OperationError> error;

  /// The context for export operation, if applicable.
  ExportContext exportContext;

  /// The context for import operation, if applicable.
  ImportContext importContext;

  /// Name of the database instance.
  core.String instance;

  /// This is always sql#instanceOperation.
  core.String kind;

  /// An identifier that uniquely identifies the operation. You can use this
  /// identifier to retrieve the Operations resource that has information about
  /// the operation.
  core.String operation;

  /// The type of the operation. Valid values are CREATE, DELETE, UPDATE,
  /// RESTART, IMPORT, EXPORT, BACKUP_VOLUME, RESTORE_VOLUME.
  core.String operationType;

  /// The time this operation actually started in UTC timezone in RFC 3339
  /// format, for example 2012-11-15T16:19:00.094Z.
  core.DateTime startTime;

  /// The state of an operation. Valid values are PENDING, RUNNING, DONE,
  /// UNKNOWN.
  core.String state;

  /// The email address of the user who initiated this operation.
  core.String userEmailAddress;

  InstanceOperation();

  InstanceOperation.fromJson(core.Map _json) {
    if (_json.containsKey("endTime")) {
      endTime = core.DateTime.parse(_json["endTime"]);
    }
    if (_json.containsKey("enqueuedTime")) {
      enqueuedTime = core.DateTime.parse(_json["enqueuedTime"]);
    }
    if (_json.containsKey("error")) {
      error = _json["error"]
          .map((value) => new OperationError.fromJson(value))
          .toList();
    }
    if (_json.containsKey("exportContext")) {
      exportContext = new ExportContext.fromJson(_json["exportContext"]);
    }
    if (_json.containsKey("importContext")) {
      importContext = new ImportContext.fromJson(_json["importContext"]);
    }
    if (_json.containsKey("instance")) {
      instance = _json["instance"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
    if (_json.containsKey("operationType")) {
      operationType = _json["operationType"];
    }
    if (_json.containsKey("startTime")) {
      startTime = core.DateTime.parse(_json["startTime"]);
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("userEmailAddress")) {
      userEmailAddress = _json["userEmailAddress"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endTime != null) {
      _json["endTime"] = (endTime).toIso8601String();
    }
    if (enqueuedTime != null) {
      _json["enqueuedTime"] = (enqueuedTime).toIso8601String();
    }
    if (error != null) {
      _json["error"] = error.map((value) => (value).toJson()).toList();
    }
    if (exportContext != null) {
      _json["exportContext"] = (exportContext).toJson();
    }
    if (importContext != null) {
      _json["importContext"] = (importContext).toJson();
    }
    if (instance != null) {
      _json["instance"] = instance;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    if (operationType != null) {
      _json["operationType"] = operationType;
    }
    if (startTime != null) {
      _json["startTime"] = (startTime).toIso8601String();
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (userEmailAddress != null) {
      _json["userEmailAddress"] = userEmailAddress;
    }
    return _json;
  }
}

/// Database instance set root password request.
class InstanceSetRootPasswordRequest {
  /// Set Root Password Context.
  SetRootPasswordContext setRootPasswordContext;

  InstanceSetRootPasswordRequest();

  InstanceSetRootPasswordRequest.fromJson(core.Map _json) {
    if (_json.containsKey("setRootPasswordContext")) {
      setRootPasswordContext =
          new SetRootPasswordContext.fromJson(_json["setRootPasswordContext"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (setRootPasswordContext != null) {
      _json["setRootPasswordContext"] = (setRootPasswordContext).toJson();
    }
    return _json;
  }
}

/// Database instance clone request.
class InstancesCloneRequest {
  /// Contains details about the clone operation.
  CloneContext cloneContext;

  InstancesCloneRequest();

  InstancesCloneRequest.fromJson(core.Map _json) {
    if (_json.containsKey("cloneContext")) {
      cloneContext = new CloneContext.fromJson(_json["cloneContext"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (cloneContext != null) {
      _json["cloneContext"] = (cloneContext).toJson();
    }
    return _json;
  }
}

/// Database instance clone response.
class InstancesCloneResponse {
  /// This is always sql#instancesClone.
  core.String kind;

  /// An unique identifier for the operation associated with the cloned
  /// instance. You can use this identifier to retrieve the Operations resource,
  /// which has information about the operation.
  core.String operation;

  InstancesCloneResponse();

  InstancesCloneResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    return _json;
  }
}

/// Database instance delete response.
class InstancesDeleteResponse {
  /// This is always sql#instancesDelete.
  core.String kind;

  /// An identifier that uniquely identifies the operation. You can use this
  /// identifier to retrieve the Operations resource that has information about
  /// the operation.
  core.String operation;

  InstancesDeleteResponse();

  InstancesDeleteResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    return _json;
  }
}

/// Database instance export request.
class InstancesExportRequest {
  /// Contains details about the export operation.
  ExportContext exportContext;

  InstancesExportRequest();

  InstancesExportRequest.fromJson(core.Map _json) {
    if (_json.containsKey("exportContext")) {
      exportContext = new ExportContext.fromJson(_json["exportContext"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (exportContext != null) {
      _json["exportContext"] = (exportContext).toJson();
    }
    return _json;
  }
}

/// Database instance export response.
class InstancesExportResponse {
  /// This is always sql#instancesExport.
  core.String kind;

  /// An identifier that uniquely identifies the operation. You can use this
  /// identifier to retrieve the Operations resource that has information about
  /// the operation.
  core.String operation;

  InstancesExportResponse();

  InstancesExportResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    return _json;
  }
}

/// Database instance import request.
class InstancesImportRequest {
  /// Contains details about the import operation.
  ImportContext importContext;

  InstancesImportRequest();

  InstancesImportRequest.fromJson(core.Map _json) {
    if (_json.containsKey("importContext")) {
      importContext = new ImportContext.fromJson(_json["importContext"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (importContext != null) {
      _json["importContext"] = (importContext).toJson();
    }
    return _json;
  }
}

/// Database instance import response.
class InstancesImportResponse {
  /// This is always sql#instancesImport.
  core.String kind;

  /// An identifier that uniquely identifies the operation. You can use this
  /// identifier to retrieve the Operations resource that has information about
  /// the operation.
  core.String operation;

  InstancesImportResponse();

  InstancesImportResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    return _json;
  }
}

/// Database instance insert response.
class InstancesInsertResponse {
  /// This is always sql#instancesInsert.
  core.String kind;

  /// An identifier that uniquely identifies the operation. You can use this
  /// identifier to retrieve the Operations resource that has information about
  /// the operation.
  core.String operation;

  InstancesInsertResponse();

  InstancesInsertResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    return _json;
  }
}

/// Database instances list response.
class InstancesListResponse {
  /// List of database instance resources.
  core.List<DatabaseInstance> items;

  /// This is always sql#instancesList.
  core.String kind;

  /// The continuation token, used to page through large result sets. Provide
  /// this value in a subsequent request to return the next page of results.
  core.String nextPageToken;

  InstancesListResponse();

  InstancesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"]
          .map((value) => new DatabaseInstance.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Database promote read replica response.
class InstancesPromoteReplicaResponse {
  /// This is always sql#instancesPromoteReplica.
  core.String kind;

  /// An identifier that uniquely identifies the operation. You can use this
  /// identifier to retrieve the Operations resource that has information about
  /// the operation.
  core.String operation;

  InstancesPromoteReplicaResponse();

  InstancesPromoteReplicaResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    return _json;
  }
}

/// Database instance resetSslConfig response.
class InstancesResetSslConfigResponse {
  /// This is always sql#instancesResetSslConfig.
  core.String kind;

  /// An identifier that uniquely identifies the operation. You can use this
  /// identifier to retrieve the Operations resource that has information about
  /// the operation. All ssl client certificates will be deleted and a new
  /// server certificate will be created. Does not take effect until the next
  /// instance restart.
  core.String operation;

  InstancesResetSslConfigResponse();

  InstancesResetSslConfigResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    return _json;
  }
}

/// Database instance restart response.
class InstancesRestartResponse {
  /// This is always sql#instancesRestart.
  core.String kind;

  /// An identifier that uniquely identifies the operation. You can use this
  /// identifier to retrieve the Operations resource that has information about
  /// the operation.
  core.String operation;

  InstancesRestartResponse();

  InstancesRestartResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    return _json;
  }
}

/// Database instance restore backup response.
class InstancesRestoreBackupResponse {
  /// This is always sql#instancesRestoreBackup.
  core.String kind;

  /// An identifier that uniquely identifies the operation. You can use this
  /// identifier to retrieve the Operations resource that has information about
  /// the operation.
  core.String operation;

  InstancesRestoreBackupResponse();

  InstancesRestoreBackupResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    return _json;
  }
}

/// Database instance set root password response.
class InstancesSetRootPasswordResponse {
  /// This is always sql#instancesSetRootPassword.
  core.String kind;

  /// An identifier that uniquely identifies the operation. You can use this
  /// identifier to retrieve the Operations resource that has information about
  /// the operation.
  core.String operation;

  InstancesSetRootPasswordResponse();

  InstancesSetRootPasswordResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    return _json;
  }
}

/// Database instance update response.
class InstancesUpdateResponse {
  /// This is always sql#instancesUpdate.
  core.String kind;

  /// An identifier that uniquely identifies the operation. You can use this
  /// identifier to retrieve information about the operation.
  core.String operation;

  InstancesUpdateResponse();

  InstancesUpdateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    return _json;
  }
}

/// IP Management configuration.
class IpConfiguration {
  /// The list of external networks that are allowed to connect to the instance
  /// using the IP. In CIDR notation, also known as 'slash' notation (e.g.
  /// 192.168.100.0/24).
  core.List<core.String> authorizedNetworks;

  /// Whether the instance should be assigned an IP address or not.
  core.bool enabled;

  /// This is always sql#ipConfiguration.
  core.String kind;

  /// Whether SSL connections over IP should be enforced or not.
  core.bool requireSsl;

  IpConfiguration();

  IpConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("authorizedNetworks")) {
      authorizedNetworks = _json["authorizedNetworks"];
    }
    if (_json.containsKey("enabled")) {
      enabled = _json["enabled"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("requireSsl")) {
      requireSsl = _json["requireSsl"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (authorizedNetworks != null) {
      _json["authorizedNetworks"] = authorizedNetworks;
    }
    if (enabled != null) {
      _json["enabled"] = enabled;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (requireSsl != null) {
      _json["requireSsl"] = requireSsl;
    }
    return _json;
  }
}

/// Database instance IP Mapping.
class IpMapping {
  /// The IP address assigned.
  core.String ipAddress;

  /// The due time for this IP to be retired in RFC 3339 format, for example
  /// 2012-11-15T16:19:00.094Z. This field is only available when the IP is
  /// scheduled to be retired.
  core.DateTime timeToRetire;

  IpMapping();

  IpMapping.fromJson(core.Map _json) {
    if (_json.containsKey("ipAddress")) {
      ipAddress = _json["ipAddress"];
    }
    if (_json.containsKey("timeToRetire")) {
      timeToRetire = core.DateTime.parse(_json["timeToRetire"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (ipAddress != null) {
      _json["ipAddress"] = ipAddress;
    }
    if (timeToRetire != null) {
      _json["timeToRetire"] = (timeToRetire).toIso8601String();
    }
    return _json;
  }
}

/// Preferred location. This specifies where a Cloud SQL instance should
/// preferably be located, either in a specific Compute Engine zone, or
/// co-located with an App Engine application. Note that if the preferred
/// location is not available, the instance will be located as close as possible
/// within the region. Only one location may be specified.
class LocationPreference {
  /// The App Engine application to follow, it must be in the same region as the
  /// Cloud SQL instance.
  core.String followGaeApplication;

  /// This is always sql#locationPreference.
  core.String kind;

  /// The preferred Compute Engine zone (e.g. us-centra1-a, us-central1-b,
  /// etc.).
  core.String zone;

  LocationPreference();

  LocationPreference.fromJson(core.Map _json) {
    if (_json.containsKey("followGaeApplication")) {
      followGaeApplication = _json["followGaeApplication"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("zone")) {
      zone = _json["zone"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (followGaeApplication != null) {
      _json["followGaeApplication"] = followGaeApplication;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (zone != null) {
      _json["zone"] = zone;
    }
    return _json;
  }
}

/// Database instance operation error.
class OperationError {
  /// Identifies the specific error that occurred.
  core.String code;

  /// This is always sql#operationError.
  core.String kind;

  OperationError();

  OperationError.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (code != null) {
      _json["code"] = code;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/// Database instance list operations response.
class OperationsListResponse {
  /// List of operation resources.
  core.List<InstanceOperation> items;

  /// This is always sql#operationsList.
  core.String kind;

  /// The continuation token, used to page through large result sets. Provide
  /// this value in a subsequent request to return the next page of results.
  core.String nextPageToken;

  OperationsListResponse();

  OperationsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"]
          .map((value) => new InstanceOperation.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Database instance set root password context.
class SetRootPasswordContext {
  /// This is always sql#setRootUserContext.
  core.String kind;

  /// The password for the root user.
  core.String password;

  SetRootPasswordContext();

  SetRootPasswordContext.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("password")) {
      password = _json["password"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (password != null) {
      _json["password"] = password;
    }
    return _json;
  }
}

/// Database instance settings.
class Settings {
  /// The activation policy for this instance. This specifies when the instance
  /// should be activated and is applicable only when the instance state is
  /// RUNNABLE. This can be one of the following.
  /// ALWAYS: The instance should always be active.
  /// NEVER: The instance should never be activated.
  /// ON_DEMAND: The instance is activated upon receiving requests.
  core.String activationPolicy;

  /// The App Engine app IDs that can access this instance.
  core.List<core.String> authorizedGaeApplications;

  /// The daily backup configuration for the instance.
  core.List<BackupConfiguration> backupConfiguration;

  /// The database flags passed to the instance at startup.
  core.List<DatabaseFlags> databaseFlags;

  /// Configuration specific to read replica instance. Indicates whether
  /// replication is enabled or not.
  core.bool databaseReplicationEnabled;

  /// The settings for IP Management. This allows to enable or disable the
  /// instance IP and manage which external networks can connect to the
  /// instance.
  IpConfiguration ipConfiguration;

  /// This is always sql#settings.
  core.String kind;

  /// The location preference settings. This allows the instance to be located
  /// as near as possible to either an App Engine app or GCE zone for better
  /// performance.
  LocationPreference locationPreference;

  /// The pricing plan for this instance. This can be either PER_USE or PACKAGE.
  core.String pricingPlan;

  /// The type of replication this instance uses. This can be either
  /// ASYNCHRONOUS or SYNCHRONOUS.
  core.String replicationType;

  /// The version of instance settings. This is a required field for update
  /// method to make sure concurrent updates are handled properly. During
  /// update, use the most recent settingsVersion value for this instance and do
  /// not try to update this value.
  core.String settingsVersion;

  /// The tier of service for this instance, for example D1, D2. For more
  /// information, see pricing.
  core.String tier;

  Settings();

  Settings.fromJson(core.Map _json) {
    if (_json.containsKey("activationPolicy")) {
      activationPolicy = _json["activationPolicy"];
    }
    if (_json.containsKey("authorizedGaeApplications")) {
      authorizedGaeApplications = _json["authorizedGaeApplications"];
    }
    if (_json.containsKey("backupConfiguration")) {
      backupConfiguration = _json["backupConfiguration"]
          .map((value) => new BackupConfiguration.fromJson(value))
          .toList();
    }
    if (_json.containsKey("databaseFlags")) {
      databaseFlags = _json["databaseFlags"]
          .map((value) => new DatabaseFlags.fromJson(value))
          .toList();
    }
    if (_json.containsKey("databaseReplicationEnabled")) {
      databaseReplicationEnabled = _json["databaseReplicationEnabled"];
    }
    if (_json.containsKey("ipConfiguration")) {
      ipConfiguration = new IpConfiguration.fromJson(_json["ipConfiguration"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("locationPreference")) {
      locationPreference =
          new LocationPreference.fromJson(_json["locationPreference"]);
    }
    if (_json.containsKey("pricingPlan")) {
      pricingPlan = _json["pricingPlan"];
    }
    if (_json.containsKey("replicationType")) {
      replicationType = _json["replicationType"];
    }
    if (_json.containsKey("settingsVersion")) {
      settingsVersion = _json["settingsVersion"];
    }
    if (_json.containsKey("tier")) {
      tier = _json["tier"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (activationPolicy != null) {
      _json["activationPolicy"] = activationPolicy;
    }
    if (authorizedGaeApplications != null) {
      _json["authorizedGaeApplications"] = authorizedGaeApplications;
    }
    if (backupConfiguration != null) {
      _json["backupConfiguration"] =
          backupConfiguration.map((value) => (value).toJson()).toList();
    }
    if (databaseFlags != null) {
      _json["databaseFlags"] =
          databaseFlags.map((value) => (value).toJson()).toList();
    }
    if (databaseReplicationEnabled != null) {
      _json["databaseReplicationEnabled"] = databaseReplicationEnabled;
    }
    if (ipConfiguration != null) {
      _json["ipConfiguration"] = (ipConfiguration).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (locationPreference != null) {
      _json["locationPreference"] = (locationPreference).toJson();
    }
    if (pricingPlan != null) {
      _json["pricingPlan"] = pricingPlan;
    }
    if (replicationType != null) {
      _json["replicationType"] = replicationType;
    }
    if (settingsVersion != null) {
      _json["settingsVersion"] = settingsVersion;
    }
    if (tier != null) {
      _json["tier"] = tier;
    }
    return _json;
  }
}

/// SslCerts Resource
class SslCert {
  /// PEM representation.
  core.String cert;

  /// Serial number, as extracted from the certificate.
  core.String certSerialNumber;

  /// User supplied name. Constrained to [a-zA-Z.-_ ]+.
  core.String commonName;

  /// Time when the certificate was created.
  core.DateTime createTime;

  /// Time when the certificate expires.
  core.DateTime expirationTime;

  /// Name of the database instance.
  core.String instance;

  /// This is always sql#sslCert.
  core.String kind;

  /// Sha1 Fingerprint.
  core.String sha1Fingerprint;

  SslCert();

  SslCert.fromJson(core.Map _json) {
    if (_json.containsKey("cert")) {
      cert = _json["cert"];
    }
    if (_json.containsKey("certSerialNumber")) {
      certSerialNumber = _json["certSerialNumber"];
    }
    if (_json.containsKey("commonName")) {
      commonName = _json["commonName"];
    }
    if (_json.containsKey("createTime")) {
      createTime = core.DateTime.parse(_json["createTime"]);
    }
    if (_json.containsKey("expirationTime")) {
      expirationTime = core.DateTime.parse(_json["expirationTime"]);
    }
    if (_json.containsKey("instance")) {
      instance = _json["instance"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("sha1Fingerprint")) {
      sha1Fingerprint = _json["sha1Fingerprint"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (cert != null) {
      _json["cert"] = cert;
    }
    if (certSerialNumber != null) {
      _json["certSerialNumber"] = certSerialNumber;
    }
    if (commonName != null) {
      _json["commonName"] = commonName;
    }
    if (createTime != null) {
      _json["createTime"] = (createTime).toIso8601String();
    }
    if (expirationTime != null) {
      _json["expirationTime"] = (expirationTime).toIso8601String();
    }
    if (instance != null) {
      _json["instance"] = instance;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (sha1Fingerprint != null) {
      _json["sha1Fingerprint"] = sha1Fingerprint;
    }
    return _json;
  }
}

/// SslCertDetail.
class SslCertDetail {
  /// The public information about the cert.
  SslCert certInfo;

  /// The private key for the client cert, in pem format. Keep private in order
  /// to protect your security.
  core.String certPrivateKey;

  SslCertDetail();

  SslCertDetail.fromJson(core.Map _json) {
    if (_json.containsKey("certInfo")) {
      certInfo = new SslCert.fromJson(_json["certInfo"]);
    }
    if (_json.containsKey("certPrivateKey")) {
      certPrivateKey = _json["certPrivateKey"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (certInfo != null) {
      _json["certInfo"] = (certInfo).toJson();
    }
    if (certPrivateKey != null) {
      _json["certPrivateKey"] = certPrivateKey;
    }
    return _json;
  }
}

/// SslCert delete response.
class SslCertsDeleteResponse {
  /// This is always sql#sslCertsDelete.
  core.String kind;

  /// An identifier that uniquely identifies the operation. You can use this
  /// identifier to retrieve the Operations resource that has information about
  /// the operation.
  core.String operation;

  SslCertsDeleteResponse();

  SslCertsDeleteResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operation != null) {
      _json["operation"] = operation;
    }
    return _json;
  }
}

/// SslCerts insert request.
class SslCertsInsertRequest {
  /// User supplied name. Must be a distinct name from the other certificates
  /// for this instance. New certificates will not be usable until the instance
  /// is restarted.
  core.String commonName;

  SslCertsInsertRequest();

  SslCertsInsertRequest.fromJson(core.Map _json) {
    if (_json.containsKey("commonName")) {
      commonName = _json["commonName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (commonName != null) {
      _json["commonName"] = commonName;
    }
    return _json;
  }
}

/// SslCert insert response.
class SslCertsInsertResponse {
  /// The new client certificate and private key. The new certificate will not
  /// work until the instance is restarted.
  SslCertDetail clientCert;

  /// This is always sql#sslCertsInsert.
  core.String kind;

  /// The server Certificate Authority's certificate. If this is missing you can
  /// force a new one to be generated by calling resetSslConfig method on
  /// instances resource..
  SslCert serverCaCert;

  SslCertsInsertResponse();

  SslCertsInsertResponse.fromJson(core.Map _json) {
    if (_json.containsKey("clientCert")) {
      clientCert = new SslCertDetail.fromJson(_json["clientCert"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("serverCaCert")) {
      serverCaCert = new SslCert.fromJson(_json["serverCaCert"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (clientCert != null) {
      _json["clientCert"] = (clientCert).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (serverCaCert != null) {
      _json["serverCaCert"] = (serverCaCert).toJson();
    }
    return _json;
  }
}

/// SslCerts list response.
class SslCertsListResponse {
  /// List of client certificates for the instance.
  core.List<SslCert> items;

  /// This is always sql#sslCertsList.
  core.String kind;

  SslCertsListResponse();

  SslCertsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items =
          _json["items"].map((value) => new SslCert.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    return _json;
  }
}

/// A Google Cloud SQL service tier resource.
class Tier {
  /// The maximum disk size of this tier in bytes.
  core.String DiskQuota;

  /// The maximum RAM usage of this tier in bytes.
  core.String RAM;

  /// This is always sql#tier.
  core.String kind;

  /// The applicable regions for this tier.
  core.List<core.String> region;

  /// An identifier for the service tier, for example D1, D2 etc. For related
  /// information, see Pricing.
  core.String tier;

  Tier();

  Tier.fromJson(core.Map _json) {
    if (_json.containsKey("DiskQuota")) {
      DiskQuota = _json["DiskQuota"];
    }
    if (_json.containsKey("RAM")) {
      RAM = _json["RAM"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("tier")) {
      tier = _json["tier"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (DiskQuota != null) {
      _json["DiskQuota"] = DiskQuota;
    }
    if (RAM != null) {
      _json["RAM"] = RAM;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (tier != null) {
      _json["tier"] = tier;
    }
    return _json;
  }
}

/// Tiers list response.
class TiersListResponse {
  /// List of tiers.
  core.List<Tier> items;

  /// This is always sql#tiersList.
  core.String kind;

  TiersListResponse();

  TiersListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Tier.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    return _json;
  }
}
