// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.clouduseraccounts.beta;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client clouduseraccounts/beta';

/// Creates and manages users and groups for accessing Google Compute Engine
/// virtual machines.
class ClouduseraccountsApi {
  /// View and manage your data across Google Cloud Platform services
  static const CloudPlatformScope =
      "https://www.googleapis.com/auth/cloud-platform";

  /// View your data across Google Cloud Platform services
  static const CloudPlatformReadOnlyScope =
      "https://www.googleapis.com/auth/cloud-platform.read-only";

  /// Manage your Google Cloud User Accounts
  static const CloudUseraccountsScope =
      "https://www.googleapis.com/auth/cloud.useraccounts";

  /// View your Google Cloud User Accounts
  static const CloudUseraccountsReadonlyScope =
      "https://www.googleapis.com/auth/cloud.useraccounts.readonly";

  final commons.ApiRequester _requester;

  GlobalAccountsOperationsResourceApi get globalAccountsOperations =>
      new GlobalAccountsOperationsResourceApi(_requester);
  GroupsResourceApi get groups => new GroupsResourceApi(_requester);
  LinuxResourceApi get linux => new LinuxResourceApi(_requester);
  UsersResourceApi get users => new UsersResourceApi(_requester);

  ClouduseraccountsApi(http.Client client,
      {core.String rootUrl: "https://www.googleapis.com/",
      core.String servicePath: "clouduseraccounts/beta/projects/"})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class GlobalAccountsOperationsResourceApi {
  final commons.ApiRequester _requester;

  GlobalAccountsOperationsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Deletes the specified operation resource.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [operation] - Name of the Operations resource to delete.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future delete(core.String project, core.String operation) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (operation == null) {
      throw new core.ArgumentError("Parameter operation is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$project') +
        '/global/operations/' +
        commons.Escaper.ecapeVariable('$operation');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// Retrieves the specified operation resource.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [operation] - Name of the Operations resource to return.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> get(core.String project, core.String operation) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (operation == null) {
      throw new core.ArgumentError("Parameter operation is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/global/operations/' +
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
  /// project.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [filter] - Sets a filter expression for filtering listed resources, in the
  /// form filter={expression}. Your {expression} must be in the format:
  /// field_name comparison_string literal_string.
  ///
  /// The field_name is the name of the field you want to compare. Only atomic
  /// field types are supported (string, number, boolean). The comparison_string
  /// must be either eq (equals) or ne (not equals). The literal_string is the
  /// string value to filter to. The literal value must be valid for the type of
  /// field you are filtering by (string, number, boolean). For string fields,
  /// the literal value is interpreted as a regular expression using RE2 syntax.
  /// The literal value must match the entire field.
  ///
  /// For example, to filter for instances that do not have a name of
  /// example-instance, you would use filter=name ne example-instance.
  ///
  /// Compute Engine Beta API Only: If you use filtering in the Beta API, you
  /// can also filter on nested fields. For example, you could filter on
  /// instances that have set the scheduling.automaticRestart field to true. In
  /// particular, use filtering on nested fields to take advantage of instance
  /// labels to organize and filter results based on label values.
  ///
  /// The Beta API also supports filtering on multiple expressions by providing
  /// each separate expression within parentheses. For example,
  /// (scheduling.automaticRestart eq true) (zone eq us-central1-f). Multiple
  /// expressions are treated as AND expressions, meaning that resources must
  /// match all expressions to pass the filters.
  ///
  /// [maxResults] - The maximum number of results per page that should be
  /// returned. If the number of available results is larger than maxResults,
  /// Compute Engine returns a nextPageToken that can be used to get the next
  /// page of results in subsequent list requests.
  /// Value must be between "0" and "500".
  ///
  /// [orderBy] - Sorts list results by a certain order. By default, results are
  /// returned in alphanumerical order based on the resource name.
  ///
  /// You can also sort results in descending order based on the creation
  /// timestamp using orderBy="creationTimestamp desc". This sorts results based
  /// on the creationTimestamp field in reverse chronological order (newest
  /// result first). Use this to sort resources like operations so that the
  /// newest operation is returned first.
  ///
  /// Currently, only sorting by name or creationTimestamp desc is supported.
  ///
  /// [pageToken] - Specifies a page token to use. Set pageToken to the
  /// nextPageToken returned by a previous list request to get the next page of
  /// results.
  ///
  /// Completes with a [OperationList].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OperationList> list(core.String project,
      {core.String filter,
      core.int maxResults,
      core.String orderBy,
      core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/operations';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new OperationList.fromJson(data));
  }
}

class GroupsResourceApi {
  final commons.ApiRequester _requester;

  GroupsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Adds users to the specified group.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [groupName] - Name of the group for this request.
  /// Value must have pattern "[a-z][-a-z0-9_]{0,31}".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> addMember(GroupsAddMemberRequest request,
      core.String project, core.String groupName) {
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
    if (groupName == null) {
      throw new core.ArgumentError("Parameter groupName is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/global/groups/' +
        commons.Escaper.ecapeVariable('$groupName') +
        '/addMember';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Deletes the specified Group resource.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [groupName] - Name of the Group resource to delete.
  /// Value must have pattern "[a-z][-a-z0-9_]{0,31}".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> delete(core.String project, core.String groupName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (groupName == null) {
      throw new core.ArgumentError("Parameter groupName is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/global/groups/' +
        commons.Escaper.ecapeVariable('$groupName');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Returns the specified Group resource.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [groupName] - Name of the Group resource to return.
  /// Value must have pattern "[a-z][-a-z0-9_]{0,31}".
  ///
  /// Completes with a [Group].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Group> get(core.String project, core.String groupName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (groupName == null) {
      throw new core.ArgumentError("Parameter groupName is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/global/groups/' +
        commons.Escaper.ecapeVariable('$groupName');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Group.fromJson(data));
  }

  /// Creates a Group resource in the specified project using the data included
  /// in the request.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> insert(Group request, core.String project) {
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

    _url = commons.Escaper.ecapeVariable('$project') + '/global/groups';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Retrieves the list of groups contained within the specified project.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [filter] - Sets a filter expression for filtering listed resources, in the
  /// form filter={expression}. Your {expression} must be in the format:
  /// field_name comparison_string literal_string.
  ///
  /// The field_name is the name of the field you want to compare. Only atomic
  /// field types are supported (string, number, boolean). The comparison_string
  /// must be either eq (equals) or ne (not equals). The literal_string is the
  /// string value to filter to. The literal value must be valid for the type of
  /// field you are filtering by (string, number, boolean). For string fields,
  /// the literal value is interpreted as a regular expression using RE2 syntax.
  /// The literal value must match the entire field.
  ///
  /// For example, to filter for instances that do not have a name of
  /// example-instance, you would use filter=name ne example-instance.
  ///
  /// Compute Engine Beta API Only: If you use filtering in the Beta API, you
  /// can also filter on nested fields. For example, you could filter on
  /// instances that have set the scheduling.automaticRestart field to true. In
  /// particular, use filtering on nested fields to take advantage of instance
  /// labels to organize and filter results based on label values.
  ///
  /// The Beta API also supports filtering on multiple expressions by providing
  /// each separate expression within parentheses. For example,
  /// (scheduling.automaticRestart eq true) (zone eq us-central1-f). Multiple
  /// expressions are treated as AND expressions, meaning that resources must
  /// match all expressions to pass the filters.
  ///
  /// [maxResults] - The maximum number of results per page that should be
  /// returned. If the number of available results is larger than maxResults,
  /// Compute Engine returns a nextPageToken that can be used to get the next
  /// page of results in subsequent list requests.
  /// Value must be between "0" and "500".
  ///
  /// [orderBy] - Sorts list results by a certain order. By default, results are
  /// returned in alphanumerical order based on the resource name.
  ///
  /// You can also sort results in descending order based on the creation
  /// timestamp using orderBy="creationTimestamp desc". This sorts results based
  /// on the creationTimestamp field in reverse chronological order (newest
  /// result first). Use this to sort resources like operations so that the
  /// newest operation is returned first.
  ///
  /// Currently, only sorting by name or creationTimestamp desc is supported.
  ///
  /// [pageToken] - Specifies a page token to use. Set pageToken to the
  /// nextPageToken returned by a previous list request to get the next page of
  /// results.
  ///
  /// Completes with a [GroupList].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GroupList> list(core.String project,
      {core.String filter,
      core.int maxResults,
      core.String orderBy,
      core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/groups';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new GroupList.fromJson(data));
  }

  /// Removes users from the specified group.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [groupName] - Name of the group for this request.
  /// Value must have pattern "[a-z][-a-z0-9_]{0,31}".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> removeMember(GroupsRemoveMemberRequest request,
      core.String project, core.String groupName) {
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
    if (groupName == null) {
      throw new core.ArgumentError("Parameter groupName is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/global/groups/' +
        commons.Escaper.ecapeVariable('$groupName') +
        '/removeMember';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }
}

class LinuxResourceApi {
  final commons.ApiRequester _requester;

  LinuxResourceApi(commons.ApiRequester client) : _requester = client;

  /// Returns a list of authorized public keys for a specific user account.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - Name of the zone for this request.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [user] - The user account for which you want to get a list of authorized
  /// public keys.
  /// Value must have pattern "[a-z][-a-z0-9_]{0,31}".
  ///
  /// [instance] - The fully-qualified URL of the virtual machine requesting the
  /// view.
  ///
  /// [login] - Whether the view was requested as part of a user-initiated
  /// login.
  ///
  /// Completes with a [LinuxGetAuthorizedKeysViewResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LinuxGetAuthorizedKeysViewResponse> getAuthorizedKeysView(
      core.String project,
      core.String zone,
      core.String user,
      core.String instance,
      {core.bool login}) {
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
    if (user == null) {
      throw new core.ArgumentError("Parameter user is required.");
    }
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }
    _queryParams["instance"] = [instance];
    if (login != null) {
      _queryParams["login"] = ["${login}"];
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/authorizedKeysView/' +
        commons.Escaper.ecapeVariable('$user');

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new LinuxGetAuthorizedKeysViewResponse.fromJson(data));
  }

  /// Retrieves a list of user accounts for an instance within a specific
  /// project.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [zone] - Name of the zone for this request.
  /// Value must have pattern "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?".
  ///
  /// [instance] - The fully-qualified URL of the virtual machine requesting the
  /// views.
  ///
  /// [filter] - Sets a filter expression for filtering listed resources, in the
  /// form filter={expression}. Your {expression} must be in the format:
  /// field_name comparison_string literal_string.
  ///
  /// The field_name is the name of the field you want to compare. Only atomic
  /// field types are supported (string, number, boolean). The comparison_string
  /// must be either eq (equals) or ne (not equals). The literal_string is the
  /// string value to filter to. The literal value must be valid for the type of
  /// field you are filtering by (string, number, boolean). For string fields,
  /// the literal value is interpreted as a regular expression using RE2 syntax.
  /// The literal value must match the entire field.
  ///
  /// For example, to filter for instances that do not have a name of
  /// example-instance, you would use filter=name ne example-instance.
  ///
  /// Compute Engine Beta API Only: If you use filtering in the Beta API, you
  /// can also filter on nested fields. For example, you could filter on
  /// instances that have set the scheduling.automaticRestart field to true. In
  /// particular, use filtering on nested fields to take advantage of instance
  /// labels to organize and filter results based on label values.
  ///
  /// The Beta API also supports filtering on multiple expressions by providing
  /// each separate expression within parentheses. For example,
  /// (scheduling.automaticRestart eq true) (zone eq us-central1-f). Multiple
  /// expressions are treated as AND expressions, meaning that resources must
  /// match all expressions to pass the filters.
  ///
  /// [maxResults] - The maximum number of results per page that should be
  /// returned. If the number of available results is larger than maxResults,
  /// Compute Engine returns a nextPageToken that can be used to get the next
  /// page of results in subsequent list requests.
  /// Value must be between "0" and "500".
  ///
  /// [orderBy] - Sorts list results by a certain order. By default, results are
  /// returned in alphanumerical order based on the resource name.
  ///
  /// You can also sort results in descending order based on the creation
  /// timestamp using orderBy="creationTimestamp desc". This sorts results based
  /// on the creationTimestamp field in reverse chronological order (newest
  /// result first). Use this to sort resources like operations so that the
  /// newest operation is returned first.
  ///
  /// Currently, only sorting by name or creationTimestamp desc is supported.
  ///
  /// [pageToken] - Specifies a page token to use. Set pageToken to the
  /// nextPageToken returned by a previous list request to get the next page of
  /// results.
  ///
  /// Completes with a [LinuxGetLinuxAccountViewsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LinuxGetLinuxAccountViewsResponse> getLinuxAccountViews(
      core.String project, core.String zone, core.String instance,
      {core.String filter,
      core.int maxResults,
      core.String orderBy,
      core.String pageToken}) {
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
    if (instance == null) {
      throw new core.ArgumentError("Parameter instance is required.");
    }
    _queryParams["instance"] = [instance];
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/zones/' +
        commons.Escaper.ecapeVariable('$zone') +
        '/linuxAccountViews';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new LinuxGetLinuxAccountViewsResponse.fromJson(data));
  }
}

class UsersResourceApi {
  final commons.ApiRequester _requester;

  UsersResourceApi(commons.ApiRequester client) : _requester = client;

  /// Adds a public key to the specified User resource with the data included in
  /// the request.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [user] - Name of the user for this request.
  /// Value must have pattern "[a-z][-a-z0-9_]{0,31}".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> addPublicKey(
      PublicKey request, core.String project, core.String user) {
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
    if (user == null) {
      throw new core.ArgumentError("Parameter user is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/global/users/' +
        commons.Escaper.ecapeVariable('$user') +
        '/addPublicKey';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Deletes the specified User resource.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [user] - Name of the user resource to delete.
  /// Value must have pattern "[a-z][-a-z0-9_]{0,31}".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> delete(core.String project, core.String user) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (user == null) {
      throw new core.ArgumentError("Parameter user is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/global/users/' +
        commons.Escaper.ecapeVariable('$user');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Returns the specified User resource.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [user] - Name of the user resource to return.
  /// Value must have pattern "[a-z][-a-z0-9_]{0,31}".
  ///
  /// Completes with a [User].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<User> get(core.String project, core.String user) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (user == null) {
      throw new core.ArgumentError("Parameter user is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/global/users/' +
        commons.Escaper.ecapeVariable('$user');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new User.fromJson(data));
  }

  /// Creates a User resource in the specified project using the data included
  /// in the request.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> insert(User request, core.String project) {
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

    _url = commons.Escaper.ecapeVariable('$project') + '/global/users';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Retrieves a list of users contained within the specified project.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [filter] - Sets a filter expression for filtering listed resources, in the
  /// form filter={expression}. Your {expression} must be in the format:
  /// field_name comparison_string literal_string.
  ///
  /// The field_name is the name of the field you want to compare. Only atomic
  /// field types are supported (string, number, boolean). The comparison_string
  /// must be either eq (equals) or ne (not equals). The literal_string is the
  /// string value to filter to. The literal value must be valid for the type of
  /// field you are filtering by (string, number, boolean). For string fields,
  /// the literal value is interpreted as a regular expression using RE2 syntax.
  /// The literal value must match the entire field.
  ///
  /// For example, to filter for instances that do not have a name of
  /// example-instance, you would use filter=name ne example-instance.
  ///
  /// Compute Engine Beta API Only: If you use filtering in the Beta API, you
  /// can also filter on nested fields. For example, you could filter on
  /// instances that have set the scheduling.automaticRestart field to true. In
  /// particular, use filtering on nested fields to take advantage of instance
  /// labels to organize and filter results based on label values.
  ///
  /// The Beta API also supports filtering on multiple expressions by providing
  /// each separate expression within parentheses. For example,
  /// (scheduling.automaticRestart eq true) (zone eq us-central1-f). Multiple
  /// expressions are treated as AND expressions, meaning that resources must
  /// match all expressions to pass the filters.
  ///
  /// [maxResults] - The maximum number of results per page that should be
  /// returned. If the number of available results is larger than maxResults,
  /// Compute Engine returns a nextPageToken that can be used to get the next
  /// page of results in subsequent list requests.
  /// Value must be between "0" and "500".
  ///
  /// [orderBy] - Sorts list results by a certain order. By default, results are
  /// returned in alphanumerical order based on the resource name.
  ///
  /// You can also sort results in descending order based on the creation
  /// timestamp using orderBy="creationTimestamp desc". This sorts results based
  /// on the creationTimestamp field in reverse chronological order (newest
  /// result first). Use this to sort resources like operations so that the
  /// newest operation is returned first.
  ///
  /// Currently, only sorting by name or creationTimestamp desc is supported.
  ///
  /// [pageToken] - Specifies a page token to use. Set pageToken to the
  /// nextPageToken returned by a previous list request to get the next page of
  /// results.
  ///
  /// Completes with a [UserList].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<UserList> list(core.String project,
      {core.String filter,
      core.int maxResults,
      core.String orderBy,
      core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/global/users';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new UserList.fromJson(data));
  }

  /// Removes the specified public key from the user.
  ///
  /// Request parameters:
  ///
  /// [project] - Project ID for this request.
  /// Value must have pattern
  /// "(?:(?:[-a-z0-9]{1,63}\.)*(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?):)?(?:[0-9]{1,19}|(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?))".
  ///
  /// [user] - Name of the user for this request.
  /// Value must have pattern "[a-z][-a-z0-9_]{0,31}".
  ///
  /// [fingerprint] - The fingerprint of the public key to delete. Public keys
  /// are identified by their fingerprint, which is defined by RFC4716 to be the
  /// MD5 digest of the public key.
  /// Value must have pattern "[a-f0-9]{32}".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> removePublicKey(
      core.String project, core.String user, core.String fingerprint) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (user == null) {
      throw new core.ArgumentError("Parameter user is required.");
    }
    if (fingerprint == null) {
      throw new core.ArgumentError("Parameter fingerprint is required.");
    }
    _queryParams["fingerprint"] = [fingerprint];

    _url = commons.Escaper.ecapeVariable('$project') +
        '/global/users/' +
        commons.Escaper.ecapeVariable('$user') +
        '/removePublicKey';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }
}

/// A list of authorized public keys for a user account.
class AuthorizedKeysView {
  /// [Output Only] The list of authorized public keys in SSH format.
  core.List<core.String> keys;

  /// [Output Only] Whether the user has the ability to elevate on the instance
  /// that requested the authorized keys.
  core.bool sudoer;

  AuthorizedKeysView();

  AuthorizedKeysView.fromJson(core.Map _json) {
    if (_json.containsKey("keys")) {
      keys = _json["keys"];
    }
    if (_json.containsKey("sudoer")) {
      sudoer = _json["sudoer"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (keys != null) {
      _json["keys"] = keys;
    }
    if (sudoer != null) {
      _json["sudoer"] = sudoer;
    }
    return _json;
  }
}

/// A Group resource.
class Group {
  /// [Output Only] Creation timestamp in RFC3339 text format.
  core.String creationTimestamp;

  /// An optional textual description of the resource; provided by the client
  /// when the resource is created.
  core.String description;

  /// [Output Only] Unique identifier for the resource; defined by the server.
  core.String id;

  /// [Output Only] Type of the resource. Always clouduseraccounts#group for
  /// groups.
  core.String kind;

  /// [Output Only] A list of URLs to User resources who belong to the group.
  /// Users may only be members of groups in the same project.
  core.List<core.String> members;

  /// Name of the resource; provided by the client when the resource is created.
  core.String name;

  /// [Output Only] Server defined URL for the resource.
  core.String selfLink;

  Group();

  Group.fromJson(core.Map _json) {
    if (_json.containsKey("creationTimestamp")) {
      creationTimestamp = _json["creationTimestamp"];
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
    if (_json.containsKey("members")) {
      members = _json["members"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
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
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (members != null) {
      _json["members"] = members;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

class GroupList {
  /// [Output Only] Unique identifier for the resource; defined by the server.
  core.String id;

  /// [Output Only] A list of Group resources.
  core.List<Group> items;

  /// [Output Only] Type of resource. Always clouduseraccounts#groupList for
  /// lists of groups.
  core.String kind;

  /// [Output Only] A token used to continue a truncated list request.
  core.String nextPageToken;

  /// [Output Only] Server defined URL for this resource.
  core.String selfLink;

  GroupList();

  GroupList.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Group.fromJson(value)).toList();
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

class GroupsAddMemberRequest {
  /// Fully-qualified URLs of the User resources to add.
  core.List<core.String> users;

  GroupsAddMemberRequest();

  GroupsAddMemberRequest.fromJson(core.Map _json) {
    if (_json.containsKey("users")) {
      users = _json["users"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (users != null) {
      _json["users"] = users;
    }
    return _json;
  }
}

class GroupsRemoveMemberRequest {
  /// Fully-qualified URLs of the User resources to remove.
  core.List<core.String> users;

  GroupsRemoveMemberRequest();

  GroupsRemoveMemberRequest.fromJson(core.Map _json) {
    if (_json.containsKey("users")) {
      users = _json["users"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (users != null) {
      _json["users"] = users;
    }
    return _json;
  }
}

/// A list of all Linux accounts for this project. This API is only used by
/// Compute Engine virtual machines to get information about user accounts for a
/// project or instance. Linux resources are read-only views into users and
/// groups managed by the Compute Engine Accounts API.
class LinuxAccountViews {
  /// [Output Only] A list of all groups within a project.
  core.List<LinuxGroupView> groupViews;

  /// [Output Only] Type of the resource. Always
  /// clouduseraccounts#linuxAccountViews for Linux resources.
  core.String kind;

  /// [Output Only] A list of all users within a project.
  core.List<LinuxUserView> userViews;

  LinuxAccountViews();

  LinuxAccountViews.fromJson(core.Map _json) {
    if (_json.containsKey("groupViews")) {
      groupViews = _json["groupViews"]
          .map((value) => new LinuxGroupView.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("userViews")) {
      userViews = _json["userViews"]
          .map((value) => new LinuxUserView.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (groupViews != null) {
      _json["groupViews"] =
          groupViews.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (userViews != null) {
      _json["userViews"] = userViews.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class LinuxGetAuthorizedKeysViewResponse {
  /// [Output Only] A list of authorized public keys for a user.
  AuthorizedKeysView resource;

  LinuxGetAuthorizedKeysViewResponse();

  LinuxGetAuthorizedKeysViewResponse.fromJson(core.Map _json) {
    if (_json.containsKey("resource")) {
      resource = new AuthorizedKeysView.fromJson(_json["resource"]);
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

class LinuxGetLinuxAccountViewsResponse {
  /// [Output Only] A list of authorized user accounts and groups.
  LinuxAccountViews resource;

  LinuxGetLinuxAccountViewsResponse();

  LinuxGetLinuxAccountViewsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("resource")) {
      resource = new LinuxAccountViews.fromJson(_json["resource"]);
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

/// A detailed view of a Linux group.
class LinuxGroupView {
  /// [Output Only] The Group ID.
  core.int gid;

  /// [Output Only] Group name.
  core.String groupName;

  /// [Output Only] List of user accounts that belong to the group.
  core.List<core.String> members;

  LinuxGroupView();

  LinuxGroupView.fromJson(core.Map _json) {
    if (_json.containsKey("gid")) {
      gid = _json["gid"];
    }
    if (_json.containsKey("groupName")) {
      groupName = _json["groupName"];
    }
    if (_json.containsKey("members")) {
      members = _json["members"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (gid != null) {
      _json["gid"] = gid;
    }
    if (groupName != null) {
      _json["groupName"] = groupName;
    }
    if (members != null) {
      _json["members"] = members;
    }
    return _json;
  }
}

/// A detailed view of a Linux user account.
class LinuxUserView {
  /// [Output Only] The GECOS (user information) entry for this account.
  core.String gecos;

  /// [Output Only] User's default group ID.
  core.int gid;

  /// [Output Only] The path to the home directory for this account.
  core.String homeDirectory;

  /// [Output Only] The path to the login shell for this account.
  core.String shell;

  /// [Output Only] User ID.
  core.int uid;

  /// [Output Only] The username of the account.
  core.String username;

  LinuxUserView();

  LinuxUserView.fromJson(core.Map _json) {
    if (_json.containsKey("gecos")) {
      gecos = _json["gecos"];
    }
    if (_json.containsKey("gid")) {
      gid = _json["gid"];
    }
    if (_json.containsKey("homeDirectory")) {
      homeDirectory = _json["homeDirectory"];
    }
    if (_json.containsKey("shell")) {
      shell = _json["shell"];
    }
    if (_json.containsKey("uid")) {
      uid = _json["uid"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (gecos != null) {
      _json["gecos"] = gecos;
    }
    if (gid != null) {
      _json["gid"] = gid;
    }
    if (homeDirectory != null) {
      _json["homeDirectory"] = homeDirectory;
    }
    if (shell != null) {
      _json["shell"] = shell;
    }
    if (uid != null) {
      _json["uid"] = uid;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

class OperationErrorErrors {
  /// [Output Only] The error type identifier for this error.
  core.String code;

  /// [Output Only] Indicates the field in the request that caused the error.
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

/// [Output Only] If errors are generated during processing of the operation,
/// this field will be populated.
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
  /// [Output Only] A key that provides more detail on the warning being
  /// returned. For example, for warnings where there are no results in a list
  /// request for a particular zone, this key might be scope and the key value
  /// might be the zone name. Other examples might be a key indicating a
  /// deprecated resource and a suggested replacement, or a warning about
  /// invalid network settings (for example, if an instance attempts to perform
  /// IP forwarding but is not enabled for IP forwarding).
  core.String key;

  /// [Output Only] A warning data value corresponding to the key.
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
  /// [Output Only] A warning code, if applicable. For example, Compute Engine
  /// returns NO_RESULTS_ON_PAGE if there are no results in the response.
  /// Possible string values are:
  /// - "CLEANUP_FAILED"
  /// - "DEPRECATED_RESOURCE_USED"
  /// - "DISK_SIZE_LARGER_THAN_IMAGE_SIZE"
  /// - "INJECTED_KERNELS_DEPRECATED"
  /// - "NEXT_HOP_ADDRESS_NOT_ASSIGNED"
  /// - "NEXT_HOP_CANNOT_IP_FORWARD"
  /// - "NEXT_HOP_INSTANCE_NOT_FOUND"
  /// - "NEXT_HOP_INSTANCE_NOT_ON_NETWORK"
  /// - "NEXT_HOP_NOT_RUNNING"
  /// - "NOT_CRITICAL_ERROR"
  /// - "NO_RESULTS_ON_PAGE"
  /// - "REQUIRED_TOS_AGREEMENT"
  /// - "RESOURCE_NOT_DELETED"
  /// - "SINGLE_INSTANCE_PROPERTY_TEMPLATE"
  /// - "UNREACHABLE"
  core.String code;

  /// [Output Only] Metadata about this warning in key: value format. For
  /// example:
  /// "data": [ { "key": "scope", "value": "zones/us-east1-d" }
  core.List<OperationWarningsData> data;

  /// [Output Only] A human-readable description of the warning code.
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

/// An Operation resource, used to manage asynchronous API requests.
class Operation {
  /// [Output Only] Reserved for future use.
  core.String clientOperationId;

  /// [Output Only] Creation timestamp in RFC3339 text format.
  core.String creationTimestamp;

  /// [Output Only] A textual description of the operation, which is set when
  /// the operation is created.
  core.String description;

  /// [Output Only] The time that this operation was completed. This value is in
  /// RFC3339 text format.
  core.String endTime;

  /// [Output Only] If errors are generated during processing of the operation,
  /// this field will be populated.
  OperationError error;

  /// [Output Only] If the operation fails, this field contains the HTTP error
  /// message that was returned, such as NOT FOUND.
  core.String httpErrorMessage;

  /// [Output Only] If the operation fails, this field contains the HTTP error
  /// status code that was returned. For example, a 404 means the resource was
  /// not found.
  core.int httpErrorStatusCode;

  /// [Output Only] The unique identifier for the resource. This identifier is
  /// defined by the server.
  core.String id;

  /// [Output Only] The time that this operation was requested. This value is in
  /// RFC3339 text format.
  core.String insertTime;

  /// [Output Only] Type of the resource. Always compute#operation for Operation
  /// resources.
  core.String kind;

  /// [Output Only] Name of the resource.
  core.String name;

  /// [Output Only] The type of operation, such as insert, update, or delete,
  /// and so on.
  core.String operationType;

  /// [Output Only] An optional progress indicator that ranges from 0 to 100.
  /// There is no requirement that this be linear or support any granularity of
  /// operations. This should not be used to guess when the operation will be
  /// complete. This number should monotonically increase as the operation
  /// progresses.
  core.int progress;

  /// [Output Only] The URL of the region where the operation resides. Only
  /// available when performing regional operations.
  core.String region;

  /// [Output Only] Server-defined URL for the resource.
  core.String selfLink;

  /// [Output Only] The time that this operation was started by the server. This
  /// value is in RFC3339 text format.
  core.String startTime;

  /// [Output Only] The status of the operation, which can be one of the
  /// following: PENDING, RUNNING, or DONE.
  /// Possible string values are:
  /// - "DONE"
  /// - "PENDING"
  /// - "RUNNING"
  core.String status;

  /// [Output Only] An optional textual description of the current status of the
  /// operation.
  core.String statusMessage;

  /// [Output Only] The unique target ID, which identifies a specific
  /// incarnation of the target resource.
  core.String targetId;

  /// [Output Only] The URL of the resource that the operation modifies.
  core.String targetLink;

  /// [Output Only] User who requested the operation, for example:
  /// user@example.com.
  core.String user;

  /// [Output Only] If warning messages are generated during processing of the
  /// operation, this field will be populated.
  core.List<OperationWarnings> warnings;

  /// [Output Only] The URL of the zone where the operation resides. Only
  /// available when performing per-zone operations.
  core.String zone;

  Operation();

  Operation.fromJson(core.Map _json) {
    if (_json.containsKey("clientOperationId")) {
      clientOperationId = _json["clientOperationId"];
    }
    if (_json.containsKey("creationTimestamp")) {
      creationTimestamp = _json["creationTimestamp"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
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
    if (description != null) {
      _json["description"] = description;
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

/// Contains a list of Operation resources.
class OperationList {
  /// [Output Only] The unique identifier for the resource. This identifier is
  /// defined by the server.
  core.String id;

  /// [Output Only] A list of Operation resources.
  core.List<Operation> items;

  /// [Output Only] Type of resource. Always compute#operations for Operations
  /// resource.
  core.String kind;

  /// [Output Only] This token allows you to get the next page of results for
  /// list requests. If the number of results is larger than maxResults, use the
  /// nextPageToken as a value for the query parameter pageToken in the next
  /// list request. Subsequent list requests will have their own nextPageToken
  /// to continue paging through the results.
  core.String nextPageToken;

  /// [Output Only] Server-defined URL for this resource.
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

/// A public key for authenticating to guests.
class PublicKey {
  /// [Output Only] Creation timestamp in RFC3339 text format.
  core.String creationTimestamp;

  /// An optional textual description of the resource; provided by the client
  /// when the resource is created.
  core.String description;

  /// Optional expiration timestamp. If provided, the timestamp must be in
  /// RFC3339 text format. If not provided, the public key never expires.
  core.String expirationTimestamp;

  /// [Output Only] The fingerprint of the key is defined by RFC4716 to be the
  /// MD5 digest of the public key.
  core.String fingerprint;

  /// Public key text in SSH format, defined by RFC4253 section 6.6.
  core.String key;

  PublicKey();

  PublicKey.fromJson(core.Map _json) {
    if (_json.containsKey("creationTimestamp")) {
      creationTimestamp = _json["creationTimestamp"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("expirationTimestamp")) {
      expirationTimestamp = _json["expirationTimestamp"];
    }
    if (_json.containsKey("fingerprint")) {
      fingerprint = _json["fingerprint"];
    }
    if (_json.containsKey("key")) {
      key = _json["key"];
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
    if (expirationTimestamp != null) {
      _json["expirationTimestamp"] = expirationTimestamp;
    }
    if (fingerprint != null) {
      _json["fingerprint"] = fingerprint;
    }
    if (key != null) {
      _json["key"] = key;
    }
    return _json;
  }
}

/// A User resource.
class User {
  /// [Output Only] Creation timestamp in RFC3339 text format.
  core.String creationTimestamp;

  /// An optional textual description of the resource; provided by the client
  /// when the resource is created.
  core.String description;

  /// [Output Only] A list of URLs to Group resources who contain the user.
  /// Users are only members of groups in the same project.
  core.List<core.String> groups;

  /// [Output Only] Unique identifier for the resource; defined by the server.
  core.String id;

  /// [Output Only] Type of the resource. Always clouduseraccounts#user for
  /// users.
  core.String kind;

  /// Name of the resource; provided by the client when the resource is created.
  core.String name;

  /// Email address of account's owner. This account will be validated to make
  /// sure it exists. The email can belong to any domain, but it must be tied to
  /// a Google account.
  core.String owner;

  /// [Output Only] Public keys that this user may use to login.
  core.List<PublicKey> publicKeys;

  /// [Output Only] Server defined URL for the resource.
  core.String selfLink;

  User();

  User.fromJson(core.Map _json) {
    if (_json.containsKey("creationTimestamp")) {
      creationTimestamp = _json["creationTimestamp"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("groups")) {
      groups = _json["groups"];
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
    if (_json.containsKey("owner")) {
      owner = _json["owner"];
    }
    if (_json.containsKey("publicKeys")) {
      publicKeys = _json["publicKeys"]
          .map((value) => new PublicKey.fromJson(value))
          .toList();
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
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
    if (groups != null) {
      _json["groups"] = groups;
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
    if (owner != null) {
      _json["owner"] = owner;
    }
    if (publicKeys != null) {
      _json["publicKeys"] =
          publicKeys.map((value) => (value).toJson()).toList();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

class UserList {
  /// [Output Only] Unique identifier for the resource; defined by the server.
  core.String id;

  /// [Output Only] A list of User resources.
  core.List<User> items;

  /// [Output Only] Type of resource. Always clouduseraccounts#userList for
  /// lists of users.
  core.String kind;

  /// [Output Only] A token used to continue a truncated list request.
  core.String nextPageToken;

  /// [Output Only] Server defined URL for this resource.
  core.String selfLink;

  UserList();

  UserList.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new User.fromJson(value)).toList();
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
