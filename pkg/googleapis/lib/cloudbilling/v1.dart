// This is a generated file (see the discoveryapis_generator project).

library googleapis.cloudbilling.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client cloudbilling/v1';

/**
 * Retrieves Google Developers Console billing accounts and associates them with
 * projects.
 */
class CloudbillingApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";


  final commons.ApiRequester _requester;

  BillingAccountsResourceApi get billingAccounts => new BillingAccountsResourceApi(_requester);
  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);

  CloudbillingApi(http.Client client, {core.String rootUrl: "https://cloudbilling.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class BillingAccountsResourceApi {
  final commons.ApiRequester _requester;

  BillingAccountsProjectsResourceApi get projects => new BillingAccountsProjectsResourceApi(_requester);

  BillingAccountsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets information about a billing account. The current authenticated user
   * must be an [owner of the billing
   * account](https://support.google.com/cloud/answer/4430947).
   *
   * Request parameters:
   *
   * [name] - The resource name of the billing account to retrieve. For example,
   * `billingAccounts/012345-567890-ABCDEF`.
   * Value must have pattern "^billingAccounts/[^/]*$".
   *
   * Completes with a [BillingAccount].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BillingAccount> get(core.String name) {
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
    return _response.then((data) => new BillingAccount.fromJson(data));
  }

  /**
   * Lists the billing accounts that the current authenticated user
   * [owns](https://support.google.com/cloud/answer/4430947).
   *
   * Request parameters:
   *
   * [pageSize] - Requested page size. The maximum page size is 100; this is
   * also the default.
   *
   * [pageToken] - A token identifying a page of results to return. This should
   * be a `next_page_token` value returned from a previous `ListBillingAccounts`
   * call. If unspecified, the first page of results is returned.
   *
   * Completes with a [ListBillingAccountsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListBillingAccountsResponse> list({core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v1/billingAccounts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListBillingAccountsResponse.fromJson(data));
  }

}


class BillingAccountsProjectsResourceApi {
  final commons.ApiRequester _requester;

  BillingAccountsProjectsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists the projects associated with a billing account. The current
   * authenticated user must be an [owner of the billing
   * account](https://support.google.com/cloud/answer/4430947).
   *
   * Request parameters:
   *
   * [name] - The resource name of the billing account associated with the
   * projects that you want to list. For example,
   * `billingAccounts/012345-567890-ABCDEF`.
   * Value must have pattern "^billingAccounts/[^/]*$".
   *
   * [pageSize] - Requested page size. The maximum page size is 100; this is
   * also the default.
   *
   * [pageToken] - A token identifying a page of results to be returned. This
   * should be a `next_page_token` value returned from a previous
   * `ListProjectBillingInfo` call. If unspecified, the first page of results is
   * returned.
   *
   * Completes with a [ListProjectBillingInfoResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListProjectBillingInfoResponse> list(core.String name, {core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + '/projects';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListProjectBillingInfoResponse.fromJson(data));
  }

}


class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the billing information for a project. The current authenticated user
   * must have [permission to view the
   * project](https://cloud.google.com/docs/permissions-overview#h.bgs0oxofvnoo
   * ).
   *
   * Request parameters:
   *
   * [name] - The resource name of the project for which billing information is
   * retrieved. For example, `projects/tokyo-rain-123`.
   * Value must have pattern "^projects/[^/]*$".
   *
   * Completes with a [ProjectBillingInfo].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProjectBillingInfo> getBillingInfo(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + '/billingInfo';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProjectBillingInfo.fromJson(data));
  }

  /**
   * Sets or updates the billing account associated with a project. You specify
   * the new billing account by setting the `billing_account_name` in the
   * `ProjectBillingInfo` resource to the resource name of a billing account.
   * Associating a project with an open billing account enables billing on the
   * project and allows charges for resource usage. If the project already had a
   * billing account, this method changes the billing account used for resource
   * usage charges. *Note:* Incurred charges that have not yet been reported in
   * the transaction history of the Google Developers Console may be billed to
   * the new billing account, even if the charge occurred before the new billing
   * account was assigned to the project. The current authenticated user must
   * have ownership privileges for both the
   * [project](https://cloud.google.com/docs/permissions-overview#h.bgs0oxofvnoo
   * ) and the [billing
   * account](https://support.google.com/cloud/answer/4430947). You can disable
   * billing on the project by setting the `billing_account_name` field to
   * empty. This action disassociates the current billing account from the
   * project. Any billable activity of your in-use services will stop, and your
   * application could stop functioning as expected. Any unbilled charges to
   * date will be billed to the previously associated account. The current
   * authenticated user must be either an owner of the project or an owner of
   * the billing account for the project. Note that associating a project with a
   * *closed* billing account will have much the same effect as disabling
   * billing on the project: any paid resources used by the project will be shut
   * down. Thus, unless you wish to disable billing, you should always call this
   * method with the name of an *open* billing account.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - The resource name of the project associated with the billing
   * information that you want to update. For example,
   * `projects/tokyo-rain-123`.
   * Value must have pattern "^projects/[^/]*$".
   *
   * Completes with a [ProjectBillingInfo].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProjectBillingInfo> updateBillingInfo(ProjectBillingInfo request, core.String name) {
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

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + '/billingInfo';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProjectBillingInfo.fromJson(data));
  }

}



/**
 * A billing account in [Google Developers
 * Console](https://console.developers.google.com/). You can assign a billing
 * account to one or more projects.
 */
class BillingAccount {
  /**
   * The display name given to the billing account, such as `My Billing
   * Account`. This name is displayed in the Google Developers Console.
   */
  core.String displayName;
  /**
   * The resource name of the billing account. The resource name has the form
   * `billingAccounts/{billing_account_id}`. For example,
   * `billingAccounts/012345-567890-ABCDEF` would be the resource name for
   * billing account `012345-567890-ABCDEF`.
   */
  core.String name;
  /**
   * True if the billing account is open, and will therefore be charged for any
   * usage on associated projects. False if the billing account is closed, and
   * therefore projects associated with it will be unable to use paid services.
   */
  core.bool open;

  BillingAccount();

  BillingAccount.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("open")) {
      open = _json["open"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (open != null) {
      _json["open"] = open;
    }
    return _json;
  }
}

/** Response message for `ListBillingAccounts`. */
class ListBillingAccountsResponse {
  /** A list of billing accounts. */
  core.List<BillingAccount> billingAccounts;
  /**
   * A token to retrieve the next page of results. To retrieve the next page,
   * call `ListBillingAccounts` again with the `page_token` field set to this
   * value. This field is empty if there are no more results to retrieve.
   */
  core.String nextPageToken;

  ListBillingAccountsResponse();

  ListBillingAccountsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("billingAccounts")) {
      billingAccounts = _json["billingAccounts"].map((value) => new BillingAccount.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (billingAccounts != null) {
      _json["billingAccounts"] = billingAccounts.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Request message for `ListProjectBillingInfoResponse`. */
class ListProjectBillingInfoResponse {
  /**
   * A token to retrieve the next page of results. To retrieve the next page,
   * call `ListProjectBillingInfo` again with the `page_token` field set to this
   * value. This field is empty if there are no more results to retrieve.
   */
  core.String nextPageToken;
  /**
   * A list of `ProjectBillingInfo` resources representing the projects
   * associated with the billing account.
   */
  core.List<ProjectBillingInfo> projectBillingInfo;

  ListProjectBillingInfoResponse();

  ListProjectBillingInfoResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("projectBillingInfo")) {
      projectBillingInfo = _json["projectBillingInfo"].map((value) => new ProjectBillingInfo.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (projectBillingInfo != null) {
      _json["projectBillingInfo"] = projectBillingInfo.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Encapsulation of billing information for a Developers Console project. A
 * project has at most one associated billing account at a time (but a billing
 * account can be assigned to multiple projects).
 */
class ProjectBillingInfo {
  /**
   * The resource name of the billing account associated with the project, if
   * any. For example, `billingAccounts/012345-567890-ABCDEF`.
   */
  core.String billingAccountName;
  /**
   * True if the project is associated with an open billing account, to which
   * usage on the project is charged. False if the project is associated with a
   * closed billing account, or no billing account at all, and therefore cannot
   * use paid services. This field is read-only.
   */
  core.bool billingEnabled;
  /**
   * The resource name for the `ProjectBillingInfo`; has the form
   * `projects/{project_id}/billingInfo`. For example, the resource name for the
   * billing information for project `tokyo-rain-123` would be
   * `projects/tokyo-rain-123/billingInfo`. This field is read-only.
   */
  core.String name;
  /**
   * The ID of the project that this `ProjectBillingInfo` represents, such as
   * `tokyo-rain-123`. This is a convenience field so that you don't need to
   * parse the `name` field to obtain a project ID. This field is read-only.
   */
  core.String projectId;

  ProjectBillingInfo();

  ProjectBillingInfo.fromJson(core.Map _json) {
    if (_json.containsKey("billingAccountName")) {
      billingAccountName = _json["billingAccountName"];
    }
    if (_json.containsKey("billingEnabled")) {
      billingEnabled = _json["billingEnabled"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (billingAccountName != null) {
      _json["billingAccountName"] = billingAccountName;
    }
    if (billingEnabled != null) {
      _json["billingEnabled"] = billingEnabled;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    return _json;
  }
}
