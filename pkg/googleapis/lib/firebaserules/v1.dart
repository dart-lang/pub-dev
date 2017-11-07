// This is a generated file (see the discoveryapis_generator project).

library googleapis.firebaserules.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client firebaserules/v1';

/**
 * Creates and manages rules that determine when a Firebase Rules-enabled
 * service should permit a request.
 */
class FirebaserulesApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /** View and administer all your Firebase data and settings */
  static const FirebaseScope = "https://www.googleapis.com/auth/firebase";

  /** View all your Firebase data and settings */
  static const FirebaseReadonlyScope = "https://www.googleapis.com/auth/firebase.readonly";


  final commons.ApiRequester _requester;

  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);

  FirebaserulesApi(http.Client client, {core.String rootUrl: "https://firebaserules.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsReleasesResourceApi get releases => new ProjectsReleasesResourceApi(_requester);
  ProjectsRulesetsResourceApi get rulesets => new ProjectsRulesetsResourceApi(_requester);

  ProjectsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Test `Source` for syntactic and semantic correctness. Issues present in the
   * rules, if any, will be returned to the caller with a description, severity,
   * and source location.
   *
   * The test method will typically be executed with a developer provided
   * `Source`, but if regression testing is desired, this method may be
   * executed against a `Ruleset` resource name and the `Source` will be
   * retrieved from the persisted `Ruleset`.
   *
   * The following is an example of `Source` that permits users to upload images
   * to a bucket bearing their user id and matching the correct metadata:
   *
   * _*Example*_
   *
   *     // Users are allowed to subscribe and unsubscribe to the blog.
   *     service firebase.storage {
   *       match /users/{userId}/images/{imageName} {
   *           allow write: if userId == request.userId
   * && (imageName.endsWith('.png') || imageName.endsWith('.jpg'))
   *               && resource.mimeType.startsWith('image/')
   *       }
   *     }
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - Name of the project.
   *
   * Format: `projects/{project_id}`
   * Value must have pattern "^projects/.+$".
   *
   * Completes with a [TestRulesetResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TestRulesetResponse> test(TestRulesetRequest request, core.String name) {
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

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + ':test';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TestRulesetResponse.fromJson(data));
  }

}


class ProjectsReleasesResourceApi {
  final commons.ApiRequester _requester;

  ProjectsReleasesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Create a `Release`.
   *
   * Release names should reflect the developer's deployment practices. For
   * example, the release name may include the environment name, application
   * name, application version, or any other name meaningful to the developer.
   * Once a `Release` refers to a `Ruleset`, the rules can be enforced by
   * Firebase Rules-enabled services.
   *
   * More than one `Release` may be 'live' concurrently. Consider the following
   * three `Release` names for `projects/foo` and the `Ruleset` to which they
   * refer.
   *
   * Release Name                    | Ruleset Name
   * --------------------------------|-------------
   * projects/foo/releases/prod      | projects/foo/rulesets/uuid123
   * projects/foo/releases/prod/beta | projects/foo/rulesets/uuid123
   * projects/foo/releases/prod/v23  | projects/foo/rulesets/uuid456
   *
   * The table reflects the `Ruleset` rollout in progress. The `prod` and
   * `prod/beta` releases refer to the same `Ruleset`. However, `prod/v23`
   * refers to a new `Ruleset`. The `Ruleset` reference for a `Release` may be
   * updated using the UpdateRelease method, and the custom `Release` name
   * may be referenced by specifying the `X-Firebase-Rules-Release-Name` header.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - Resource name for the project which owns this `Release`.
   *
   * Format: `projects/{project_id}`
   * Value must have pattern "^projects/[^/]+$".
   *
   * Completes with a [Release].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Release> create(Release request, core.String name) {
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

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + '/releases';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Release.fromJson(data));
  }

  /**
   * Delete a `Release` by resource name.
   *
   * Request parameters:
   *
   * [name] - Resource name for the `Release` to delete.
   *
   * Format: `projects/{project_id}/releases/{release_id}`
   * Value must have pattern "^projects/[^/]+/releases/.+$".
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
   * Get a `Release` by name.
   *
   * Request parameters:
   *
   * [name] - Resource name of the `Release`.
   *
   *
   * Format: `projects/{project_id}/releases/{release_id}`
   * Value must have pattern "^projects/[^/]+/releases/.+$".
   *
   * Completes with a [Release].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Release> get(core.String name) {
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
    return _response.then((data) => new Release.fromJson(data));
  }

  /**
   * List the `Release` values for a project. This list may optionally be
   * filtered by `Release` name or `Ruleset` id or both.
   *
   * Request parameters:
   *
   * [name] - Resource name for the project.
   *
   * Format: `projects/{project_id}`
   * Value must have pattern "^projects/[^/]+$".
   *
   * [filter] - `Release` filter. The list method supports filters with
   * restrictions on the
   * `Release` `name` and also on the `Ruleset` `ruleset_name`.
   *
   * Example 1) A filter of 'name=prod*' might return `Release`s with names
   * within 'projects/foo' prefixed with 'prod':
   *
   * Name                          | Ruleset Name
   * ------------------------------|-------------
   * projects/foo/releases/prod    | projects/foo/rulesets/uuid1234
   * projects/foo/releases/prod/v1 | projects/foo/rulesets/uuid1234
   * projects/foo/releases/prod/v2 | projects/foo/rulesets/uuid8888
   *
   * Example 2) A filter of `name=prod* ruleset_name=uuid1234` would return only
   * `Release` instances for 'projects/foo' with names prefixed with 'prod'
   * referring to the same `Ruleset` name of 'uuid1234':
   *
   * Name                          | Ruleset Name
   * ------------------------------|-------------
   * projects/foo/releases/prod    | projects/foo/rulesets/1234
   * projects/foo/releases/prod/v1 | projects/foo/rulesets/1234
   *
   * In the examples, the filter parameters refer to the search filters for
   * release and ruleset names are relative to the project releases and rulesets
   * collections. Fully qualified prefixed may also be used. e.g.
   * `name=projects/foo/releases/prod* ruleset_name=projects/foo/rulesets/uuid1`
   *
   * [pageToken] - Next page token for the next batch of `Release` instances.
   *
   * [pageSize] - Page size to load. Maximum of 100. Defaults to 10.
   * Note: `page_size` is just a hint and the service may choose to load less
   * than `page_size` due to the size of the output. To traverse all of the
   * releases, caller should iterate until the `page_token` is empty.
   *
   * Completes with a [ListReleasesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListReleasesResponse> list(core.String name, {core.String filter, core.String pageToken, core.int pageSize}) {
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
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + '/releases';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListReleasesResponse.fromJson(data));
  }

  /**
   * Update a `Release`.
   *
   * Only updates to the `ruleset_name` field will be honored. `Release` rename
   * is not supported. To create a `Release` use the CreateRelease method
   * instead.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - Resource name for the `Release`.
   *
   * `Release` names may be structured `app1/prod/v2` or flat `app1_prod_v2`
   * which affords developers a great deal of flexibility in mapping the name
   * to the style that best fits their existing development practices. For
   * example, a name could refer to an environment, an app, a version, or some
   * combination of three.
   *
   * In the table below, for the project name `projects/foo`, the following
   * relative release paths show how flat and structured names might be chosen
   * to match a desired development / deployment strategy.
   *
   * Use Case     | Flat Name           | Structured Name
   * -------------|---------------------|----------------
   * Environments | releases/qa         | releases/qa
   * Apps         | releases/app1_qa    | releases/app1/qa
   * Versions     | releases/app1_v2_qa | releases/app1/v2/qa
   *
   * The delimiter between the release name path elements can be almost anything
   * and it should work equally well with the release name list filter, but in
   * many ways the structured paths provide a clearer picture of the
   * relationship between `Release` instances.
   *
   * Format: `projects/{project_id}/releases/{release_id}`
   * Value must have pattern "^projects/[^/]+/releases/.+$".
   *
   * Completes with a [Release].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Release> update(Release request, core.String name) {
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

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Release.fromJson(data));
  }

}


class ProjectsRulesetsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsRulesetsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Create a `Ruleset` from `Source`.
   *
   * The `Ruleset` is given a unique generated name which is returned to the
   * caller. `Source` containing syntactic or semantics errors will result in an
   * error response indicating the first error encountered. For a detailed view
   * of `Source` issues, use TestRuleset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - Resource name for Project which owns this `Ruleset`.
   *
   * Format: `projects/{project_id}`
   * Value must have pattern "^projects/[^/]+$".
   *
   * Completes with a [Ruleset].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Ruleset> create(Ruleset request, core.String name) {
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

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + '/rulesets';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Ruleset.fromJson(data));
  }

  /**
   * Delete a `Ruleset` by resource name.
   *
   * If the `Ruleset` is referenced by a `Release` the operation will fail.
   *
   * Request parameters:
   *
   * [name] - Resource name for the ruleset to delete.
   *
   * Format: `projects/{project_id}/rulesets/{ruleset_id}`
   * Value must have pattern "^projects/[^/]+/rulesets/[^/]+$".
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
   * Get a `Ruleset` by name including the full `Source` contents.
   *
   * Request parameters:
   *
   * [name] - Resource name for the ruleset to get.
   *
   * Format: `projects/{project_id}/rulesets/{ruleset_id}`
   * Value must have pattern "^projects/[^/]+/rulesets/[^/]+$".
   *
   * Completes with a [Ruleset].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Ruleset> get(core.String name) {
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
    return _response.then((data) => new Ruleset.fromJson(data));
  }

  /**
   * List `Ruleset` metadata only and optionally filter the results by Ruleset
   * name.
   *
   * The full `Source` contents of a `Ruleset` may be retrieved with
   * GetRuleset.
   *
   * Request parameters:
   *
   * [name] - Resource name for the project.
   *
   * Format: `projects/{project_id}`
   * Value must have pattern "^projects/[^/]+$".
   *
   * [pageToken] - Next page token for loading the next batch of `Ruleset`
   * instances.
   *
   * [pageSize] - Page size to load. Maximum of 100. Defaults to 10.
   * Note: `page_size` is just a hint and the service may choose to load less
   * than `page_size` due to the size of the output. To traverse all of the
   * releases, caller should iterate until the `page_token` is empty.
   *
   * Completes with a [ListRulesetsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListRulesetsResponse> list(core.String name, {core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + '/rulesets';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListRulesetsResponse.fromJson(data));
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

/** `File` containing source content. */
class File {
  /** Textual Content. */
  core.String content;
  /** Fingerprint (e.g. github sha) associated with the `File`. */
  core.String fingerprint;
  core.List<core.int> get fingerprintAsBytes {
    return convert.BASE64.decode(fingerprint);
  }

  void set fingerprintAsBytes(core.List<core.int> _bytes) {
    fingerprint = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** File name. */
  core.String name;

  File();

  File.fromJson(core.Map _json) {
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("fingerprint")) {
      fingerprint = _json["fingerprint"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (content != null) {
      _json["content"] = content;
    }
    if (fingerprint != null) {
      _json["fingerprint"] = fingerprint;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Issues include warnings, errors, and deprecation notices. */
class Issue {
  /** Short error description. */
  core.String description;
  /**
   * The severity of the issue.
   * Possible string values are:
   * - "SEVERITY_UNSPECIFIED" : An unspecified severity.
   * - "DEPRECATION" : Deprecation issue for statements and method that may no
   * longer be
   * supported or maintained.
   * - "WARNING" : Warnings such as: unused variables.
   * - "ERROR" : Errors such as: unmatched curly braces or variable
   * redefinition.
   */
  core.String severity;
  /** Position of the issue in the `Source`. */
  SourcePosition sourcePosition;

  Issue();

  Issue.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("severity")) {
      severity = _json["severity"];
    }
    if (_json.containsKey("sourcePosition")) {
      sourcePosition = new SourcePosition.fromJson(_json["sourcePosition"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (severity != null) {
      _json["severity"] = severity;
    }
    if (sourcePosition != null) {
      _json["sourcePosition"] = (sourcePosition).toJson();
    }
    return _json;
  }
}

/** The response for FirebaseRulesService.ListReleases. */
class ListReleasesResponse {
  /**
   * The pagination token to retrieve the next page of results. If the value is
   * empty, no further results remain.
   */
  core.String nextPageToken;
  /** List of `Release` instances. */
  core.List<Release> releases;

  ListReleasesResponse();

  ListReleasesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("releases")) {
      releases = _json["releases"].map((value) => new Release.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (releases != null) {
      _json["releases"] = releases.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The response for FirebaseRulesService.ListRulesets */
class ListRulesetsResponse {
  /**
   * The pagination token to retrieve the next page of results. If the value is
   * empty, no further results remain.
   */
  core.String nextPageToken;
  /** List of `Ruleset` instances. */
  core.List<Ruleset> rulesets;

  ListRulesetsResponse();

  ListRulesetsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("rulesets")) {
      rulesets = _json["rulesets"].map((value) => new Ruleset.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (rulesets != null) {
      _json["rulesets"] = rulesets.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * `Release` is a named reference to a `Ruleset`. Once a `Release` refers to a
 * `Ruleset`, rules-enabled services will be able to enforce the `Ruleset`.
 */
class Release {
  /**
   * Time the release was created.
   * @OutputOnly
   */
  core.String createTime;
  /**
   * Resource name for the `Release`.
   *
   * `Release` names may be structured `app1/prod/v2` or flat `app1_prod_v2`
   * which affords developers a great deal of flexibility in mapping the name
   * to the style that best fits their existing development practices. For
   * example, a name could refer to an environment, an app, a version, or some
   * combination of three.
   *
   * In the table below, for the project name `projects/foo`, the following
   * relative release paths show how flat and structured names might be chosen
   * to match a desired development / deployment strategy.
   *
   * Use Case     | Flat Name           | Structured Name
   * -------------|---------------------|----------------
   * Environments | releases/qa         | releases/qa
   * Apps         | releases/app1_qa    | releases/app1/qa
   * Versions     | releases/app1_v2_qa | releases/app1/v2/qa
   *
   * The delimiter between the release name path elements can be almost anything
   * and it should work equally well with the release name list filter, but in
   * many ways the structured paths provide a clearer picture of the
   * relationship between `Release` instances.
   *
   * Format: `projects/{project_id}/releases/{release_id}`
   */
  core.String name;
  /**
   * Name of the `Ruleset` referred to by this `Release`. The `Ruleset` must
   * exist the `Release` to be created.
   */
  core.String rulesetName;
  /**
   * Time the release was updated.
   * @OutputOnly
   */
  core.String updateTime;

  Release();

  Release.fromJson(core.Map _json) {
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("rulesetName")) {
      rulesetName = _json["rulesetName"];
    }
    if (_json.containsKey("updateTime")) {
      updateTime = _json["updateTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (rulesetName != null) {
      _json["rulesetName"] = rulesetName;
    }
    if (updateTime != null) {
      _json["updateTime"] = updateTime;
    }
    return _json;
  }
}

/**
 * `Ruleset` is an immutable copy of `Source` with a globally unique identifier
 * and a creation time.
 */
class Ruleset {
  /**
   * Time the `Ruleset` was created.
   * @OutputOnly
   */
  core.String createTime;
  /**
   * Name of the `Ruleset`. The ruleset_id is auto generated by the service.
   * Format: `projects/{project_id}/rulesets/{ruleset_id}`
   * @OutputOnly
   */
  core.String name;
  /** `Source` for the `Ruleset`. */
  Source source;

  Ruleset();

  Ruleset.fromJson(core.Map _json) {
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("source")) {
      source = new Source.fromJson(_json["source"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    return _json;
  }
}

/**
 * `Source` is one or more `File` messages comprising a logical set of rules.
 */
class Source {
  /** `File` set constituting the `Source` bundle. */
  core.List<File> files;

  Source();

  Source.fromJson(core.Map _json) {
    if (_json.containsKey("files")) {
      files = _json["files"].map((value) => new File.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (files != null) {
      _json["files"] = files.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Position in the `Source` content including its line, column number, and an
 * index of the `File` in the `Source` message. Used for debug purposes.
 */
class SourcePosition {
  /** First column on the source line associated with the source fragment. */
  core.int column;
  /** Name of the `File`. */
  core.String fileName;
  /** Line number of the source fragment. 1-based. */
  core.int line;

  SourcePosition();

  SourcePosition.fromJson(core.Map _json) {
    if (_json.containsKey("column")) {
      column = _json["column"];
    }
    if (_json.containsKey("fileName")) {
      fileName = _json["fileName"];
    }
    if (_json.containsKey("line")) {
      line = _json["line"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (column != null) {
      _json["column"] = column;
    }
    if (fileName != null) {
      _json["fileName"] = fileName;
    }
    if (line != null) {
      _json["line"] = line;
    }
    return _json;
  }
}

/** The request for FirebaseRulesService.TestRuleset. */
class TestRulesetRequest {
  /** `Source` to be checked for correctness. */
  Source source;

  TestRulesetRequest();

  TestRulesetRequest.fromJson(core.Map _json) {
    if (_json.containsKey("source")) {
      source = new Source.fromJson(_json["source"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    return _json;
  }
}

/** The response for FirebaseRulesService.TestRuleset. */
class TestRulesetResponse {
  /**
   * Syntactic and semantic `Source` issues of varying severity. Issues of
   * `ERROR` severity will prevent tests from executing.
   */
  core.List<Issue> issues;

  TestRulesetResponse();

  TestRulesetResponse.fromJson(core.Map _json) {
    if (_json.containsKey("issues")) {
      issues = _json["issues"].map((value) => new Issue.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (issues != null) {
      _json["issues"] = issues.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
