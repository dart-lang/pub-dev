// This is a generated file (see the discoveryapis_generator project).

library googleapis.sourcerepo.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client sourcerepo/v1';

/** Access source code repositories hosted by Google. */
class SourcerepoApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";


  final commons.ApiRequester _requester;

  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);

  SourcerepoApi(http.Client client, {core.String rootUrl: "https://sourcerepo.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsReposResourceApi get repos => new ProjectsReposResourceApi(_requester);

  ProjectsResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class ProjectsReposResourceApi {
  final commons.ApiRequester _requester;

  ProjectsReposResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a repo in the given project with the given name..
   *
   * If the named repository already exists, `CreateRepo` returns
   * `ALREADY_EXISTS`.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [parent] - The project in which to create the repo. Values are of the form
   * `projects/<project>`.
   * Value must have pattern "^projects/[^/]+$".
   *
   * Completes with a [Repo].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Repo> create(Repo request, core.String parent) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (parent == null) {
      throw new core.ArgumentError("Parameter parent is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$parent') + '/repos';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Repo.fromJson(data));
  }

  /**
   * Deletes a repo.
   *
   * Request parameters:
   *
   * [name] - The name of the repo to delete. Values are of the form
   * `projects/<project>/repos/<repo>`.
   * Value must have pattern "^projects/[^/]+/repos/.+$".
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
   * Returns information about a repo.
   *
   * Request parameters:
   *
   * [name] - The name of the requested repository. Values are of the form
   * `projects/<project>/repos/<repo>`.
   * Value must have pattern "^projects/[^/]+/repos/.+$".
   *
   * Completes with a [Repo].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Repo> get(core.String name) {
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
    return _response.then((data) => new Repo.fromJson(data));
  }

  /**
   * Gets the access control policy for a resource.
   * Returns an empty policy if the resource exists and does not have a policy
   * set.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which the policy is being
   * requested.
   * See the operation documentation for the appropriate value for this field.
   * Value must have pattern "^projects/[^/]+/repos/.+$".
   *
   * Completes with a [Policy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Policy> getIamPolicy(core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$resource') + ':getIamPolicy';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Policy.fromJson(data));
  }

  /**
   * Returns all repos belonging to a project.
   *
   * Request parameters:
   *
   * [name] - The project ID whose repos should be listed. Values are of the
   * form
   * `projects/<project>`.
   * Value must have pattern "^projects/[^/]+$".
   *
   * Completes with a [ListReposResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListReposResponse> list(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + '/repos';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListReposResponse.fromJson(data));
  }

  /**
   * Sets the access control policy on the specified resource. Replaces any
   * existing policy.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which the policy is being
   * specified.
   * See the operation documentation for the appropriate value for this field.
   * Value must have pattern "^projects/[^/]+/repos/.+$".
   *
   * Completes with a [Policy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Policy> setIamPolicy(SetIamPolicyRequest request, core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$resource') + ':setIamPolicy';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Policy.fromJson(data));
  }

  /**
   * Returns permissions that a caller has on the specified resource.
   * If the resource does not exist, this will return an empty set of
   * permissions, not a NOT_FOUND error.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which the policy detail is being
   * requested.
   * See the operation documentation for the appropriate value for this field.
   * Value must have pattern "^projects/[^/]+/repos/.+$".
   *
   * Completes with a [TestIamPermissionsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TestIamPermissionsResponse> testIamPermissions(TestIamPermissionsRequest request, core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$resource') + ':testIamPermissions';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TestIamPermissionsResponse.fromJson(data));
  }

}



/**
 * Specifies the audit configuration for a service.
 * It consists of which permission types are logged, and what identities, if
 * any, are exempted from logging.
 * An AuditConifg must have one or more AuditLogConfigs.
 *
 * If there are AuditConfigs for both `allServices` and a specific service,
 * the union of the two AuditConfigs is used for that service: the log_types
 * specified in each AuditConfig are enabled, and the exempted_members in each
 * AuditConfig are exempted.
 * Example Policy with multiple AuditConfigs:
 * {
 *   "audit_configs": [
 *     {
 *       "service": "allServices"
 *       "audit_log_configs": [
 *         {
 *           "log_type": "DATA_READ",
 *           "exempted_members": [
 *             "user:foo@gmail.com"
 *           ]
 *         },
 *         {
 *           "log_type": "DATA_WRITE",
 *         },
 *         {
 *           "log_type": "ADMIN_READ",
 *         }
 *       ]
 *     },
 *     {
 *       "service": "fooservice@googleapis.com"
 *       "audit_log_configs": [
 *         {
 *           "log_type": "DATA_READ",
 *         },
 *         {
 *           "log_type": "DATA_WRITE",
 *           "exempted_members": [
 *             "user:bar@gmail.com"
 *           ]
 *         }
 *       ]
 *     }
 *   ]
 * }
 * For fooservice, this policy enables DATA_READ, DATA_WRITE and ADMIN_READ
 * logging. It also exempts foo@gmail.com from DATA_READ logging, and
 * bar@gmail.com from DATA_WRITE logging.
 */
class AuditConfig {
  /**
   * The configuration for logging of each type of permission.
   * Next ID: 4
   */
  core.List<AuditLogConfig> auditLogConfigs;
  core.List<core.String> exemptedMembers;
  /**
   * Specifies a service that will be enabled for audit logging.
   * For example, `resourcemanager`, `storage`, `compute`.
   * `allServices` is a special value that covers all services.
   */
  core.String service;

  AuditConfig();

  AuditConfig.fromJson(core.Map _json) {
    if (_json.containsKey("auditLogConfigs")) {
      auditLogConfigs = _json["auditLogConfigs"].map((value) => new AuditLogConfig.fromJson(value)).toList();
    }
    if (_json.containsKey("exemptedMembers")) {
      exemptedMembers = _json["exemptedMembers"];
    }
    if (_json.containsKey("service")) {
      service = _json["service"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (auditLogConfigs != null) {
      _json["auditLogConfigs"] = auditLogConfigs.map((value) => (value).toJson()).toList();
    }
    if (exemptedMembers != null) {
      _json["exemptedMembers"] = exemptedMembers;
    }
    if (service != null) {
      _json["service"] = service;
    }
    return _json;
  }
}

/**
 * Provides the configuration for logging a type of permissions.
 * Example:
 *
 *     {
 *       "audit_log_configs": [
 *         {
 *           "log_type": "DATA_READ",
 *           "exempted_members": [
 *             "user:foo@gmail.com"
 *           ]
 *         },
 *         {
 *           "log_type": "DATA_WRITE",
 *         }
 *       ]
 *     }
 *
 * This enables 'DATA_READ' and 'DATA_WRITE' logging, while exempting
 * foo@gmail.com from DATA_READ logging.
 */
class AuditLogConfig {
  /**
   * Specifies the identities that do not cause logging for this type of
   * permission.
   * Follows the same format of Binding.members.
   */
  core.List<core.String> exemptedMembers;
  /**
   * The log type that this config enables.
   * Possible string values are:
   * - "LOG_TYPE_UNSPECIFIED" : Default case. Should never be this.
   * - "ADMIN_READ" : Admin reads. Example: CloudIAM getIamPolicy
   * - "DATA_WRITE" : Data writes. Example: CloudSQL Users create
   * - "DATA_READ" : Data reads. Example: CloudSQL Users list
   */
  core.String logType;

  AuditLogConfig();

  AuditLogConfig.fromJson(core.Map _json) {
    if (_json.containsKey("exemptedMembers")) {
      exemptedMembers = _json["exemptedMembers"];
    }
    if (_json.containsKey("logType")) {
      logType = _json["logType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (exemptedMembers != null) {
      _json["exemptedMembers"] = exemptedMembers;
    }
    if (logType != null) {
      _json["logType"] = logType;
    }
    return _json;
  }
}

/** Associates `members` with a `role`. */
class Binding {
  /**
   * Specifies the identities requesting access for a Cloud Platform resource.
   * `members` can have the following values:
   *
   * * `allUsers`: A special identifier that represents anyone who is
   *    on the internet; with or without a Google account.
   *
   * * `allAuthenticatedUsers`: A special identifier that represents anyone
   *    who is authenticated with a Google account or a service account.
   *
   * * `user:{emailid}`: An email address that represents a specific Google
   *    account. For example, `alice@gmail.com` or `joe@example.com`.
   *
   *
   * * `serviceAccount:{emailid}`: An email address that represents a service
   *    account. For example, `my-other-app@appspot.gserviceaccount.com`.
   *
   * * `group:{emailid}`: An email address that represents a Google group.
   *    For example, `admins@example.com`.
   *
   * * `domain:{domain}`: A Google Apps domain name that represents all the
   *    users of that domain. For example, `google.com` or `example.com`.
   */
  core.List<core.String> members;
  /**
   * Role that is assigned to `members`.
   * For example, `roles/viewer`, `roles/editor`, or `roles/owner`.
   * Required
   */
  core.String role;

  Binding();

  Binding.fromJson(core.Map _json) {
    if (_json.containsKey("members")) {
      members = _json["members"];
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (members != null) {
      _json["members"] = members;
    }
    if (role != null) {
      _json["role"] = role;
    }
    return _json;
  }
}

/** Write a Cloud Audit log */
class CloudAuditOptions {

  CloudAuditOptions();

  CloudAuditOptions.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** A condition to be met. */
class Condition {
  /**
   * Trusted attributes supplied by the IAM system.
   * Possible string values are:
   * - "NO_ATTR" : Default non-attribute.
   * - "AUTHORITY" : Either principal or (if present) authority selector.
   * - "ATTRIBUTION" : The principal (even if an authority selector is present),
   * which
   * must only be used for attribution, not authorization.
   * - "APPROVER" : An approver (distinct from the requester) that has
   * authorized this
   * request.
   * When used with IN, the condition indicates that one of the approvers
   * associated with the request matches the specified principal, or is a
   * member of the specified group. Approvers can only grant additional
   * access, and are thus only used in a strictly positive context
   * (e.g. ALLOW/IN or DENY/NOT_IN).
   * See: go/rpc-security-policy-dynamicauth.
   * - "JUSTIFICATION_TYPE" : What types of justifications have been supplied
   * with this request.
   * String values should match enum names from tech.iam.JustificationType,
   * e.g. "MANUAL_STRING". It is not permitted to grant access based on
   * the *absence* of a justification, so justification conditions can only
   * be used in a "positive" context (e.g., ALLOW/IN or DENY/NOT_IN).
   *
   * Multiple justifications, e.g., a Buganizer ID and a manually-entered
   * reason, are normal and supported.
   */
  core.String iam;
  /**
   * An operator to apply the subject with.
   * Possible string values are:
   * - "NO_OP" : Default no-op.
   * - "EQUALS" : DEPRECATED. Use IN instead.
   * - "NOT_EQUALS" : DEPRECATED. Use NOT_IN instead.
   * - "IN" : The condition is true if the subject (or any element of it if it
   * is
   * a set) matches any of the supplied values.
   * - "NOT_IN" : The condition is true if the subject (or every element of it
   * if it is
   * a set) matches none of the supplied values.
   * - "DISCHARGED" : Subject is discharged
   */
  core.String op;
  /** Trusted attributes discharged by the service. */
  core.String svc;
  /**
   * Trusted attributes supplied by any service that owns resources and uses
   * the IAM system for access control.
   * Possible string values are:
   * - "NO_ATTR" : Default non-attribute type
   * - "REGION" : Region of the resource
   * - "SERVICE" : Service name
   * - "NAME" : Resource name
   * - "IP" : IP address of the caller
   */
  core.String sys;
  /** DEPRECATED. Use 'values' instead. */
  core.String value;
  /** The objects of the condition. This is mutually exclusive with 'value'. */
  core.List<core.String> values;

  Condition();

  Condition.fromJson(core.Map _json) {
    if (_json.containsKey("iam")) {
      iam = _json["iam"];
    }
    if (_json.containsKey("op")) {
      op = _json["op"];
    }
    if (_json.containsKey("svc")) {
      svc = _json["svc"];
    }
    if (_json.containsKey("sys")) {
      sys = _json["sys"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
    if (_json.containsKey("values")) {
      values = _json["values"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (iam != null) {
      _json["iam"] = iam;
    }
    if (op != null) {
      _json["op"] = op;
    }
    if (svc != null) {
      _json["svc"] = svc;
    }
    if (sys != null) {
      _json["sys"] = sys;
    }
    if (value != null) {
      _json["value"] = value;
    }
    if (values != null) {
      _json["values"] = values;
    }
    return _json;
  }
}

/** Options for counters */
class CounterOptions {
  /** The field value to attribute. */
  core.String field;
  /** The metric to update. */
  core.String metric;

  CounterOptions();

  CounterOptions.fromJson(core.Map _json) {
    if (_json.containsKey("field")) {
      field = _json["field"];
    }
    if (_json.containsKey("metric")) {
      metric = _json["metric"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (field != null) {
      _json["field"] = field;
    }
    if (metric != null) {
      _json["metric"] = metric;
    }
    return _json;
  }
}

/** Write a Data Access (Gin) log */
class DataAccessOptions {

  DataAccessOptions();

  DataAccessOptions.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
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

/** Response for ListRepos. */
class ListReposResponse {
  /** The listed repos. */
  core.List<Repo> repos;

  ListReposResponse();

  ListReposResponse.fromJson(core.Map _json) {
    if (_json.containsKey("repos")) {
      repos = _json["repos"].map((value) => new Repo.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (repos != null) {
      _json["repos"] = repos.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Specifies what kind of log the caller must write
 * Increment a streamz counter with the specified metric and field names.
 *
 * Metric names should start with a '/', generally be lowercase-only,
 * and end in "_count". Field names should not contain an initial slash.
 * The actual exported metric names will have "/iam/policy" prepended.
 *
 * Field names correspond to IAM request parameters and field values are
 * their respective values.
 *
 * At present the only supported field names are
 *    - "iam_principal", corresponding to IAMContext.principal;
 *    - "" (empty string), resulting in one aggretated counter with no field.
 *
 * Examples:
 *   counter { metric: "/debug_access_count"  field: "iam_principal" }
 *   ==> increment counter /iam/policy/backend_debug_access_count
 *                         {iam_principal=[value of IAMContext.principal]}
 *
 * At this time we do not support:
 * * multiple field names (though this may be supported in the future)
 * * decrementing the counter
 * * incrementing it by anything other than 1
 */
class LogConfig {
  /** Cloud audit options. */
  CloudAuditOptions cloudAudit;
  /** Counter options. */
  CounterOptions counter;
  /** Data access options. */
  DataAccessOptions dataAccess;

  LogConfig();

  LogConfig.fromJson(core.Map _json) {
    if (_json.containsKey("cloudAudit")) {
      cloudAudit = new CloudAuditOptions.fromJson(_json["cloudAudit"]);
    }
    if (_json.containsKey("counter")) {
      counter = new CounterOptions.fromJson(_json["counter"]);
    }
    if (_json.containsKey("dataAccess")) {
      dataAccess = new DataAccessOptions.fromJson(_json["dataAccess"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cloudAudit != null) {
      _json["cloudAudit"] = (cloudAudit).toJson();
    }
    if (counter != null) {
      _json["counter"] = (counter).toJson();
    }
    if (dataAccess != null) {
      _json["dataAccess"] = (dataAccess).toJson();
    }
    return _json;
  }
}

/**
 * Configuration to automatically mirror a repository from another
 * hosting service, for example GitHub or BitBucket.
 */
class MirrorConfig {
  /**
   * ID of the SSH deploy key at the other hosting service.
   * Removing this key from the other service would deauthorize
   * Google Cloud Source Repositories from mirroring.
   */
  core.String deployKeyId;
  /** URL of the main repository at the other hosting service. */
  core.String url;
  /**
   * ID of the webhook listening to updates to trigger mirroring.
   * Removing this webook from the other hosting service will stop
   * Google Cloud Source Repositories from receiving notifications,
   * and thereby disabling mirroring.
   */
  core.String webhookId;

  MirrorConfig();

  MirrorConfig.fromJson(core.Map _json) {
    if (_json.containsKey("deployKeyId")) {
      deployKeyId = _json["deployKeyId"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("webhookId")) {
      webhookId = _json["webhookId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deployKeyId != null) {
      _json["deployKeyId"] = deployKeyId;
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (webhookId != null) {
      _json["webhookId"] = webhookId;
    }
    return _json;
  }
}

/**
 * Defines an Identity and Access Management (IAM) policy. It is used to
 * specify access control policies for Cloud Platform resources.
 *
 *
 * A `Policy` consists of a list of `bindings`. A `Binding` binds a list of
 * `members` to a `role`, where the members can be user accounts, Google groups,
 * Google domains, and service accounts. A `role` is a named list of permissions
 * defined by IAM.
 *
 * **Example**
 *
 *     {
 *       "bindings": [
 *         {
 *           "role": "roles/owner",
 *           "members": [
 *             "user:mike@example.com",
 *             "group:admins@example.com",
 *             "domain:google.com",
 *             "serviceAccount:my-other-app@appspot.gserviceaccount.com",
 *           ]
 *         },
 *         {
 *           "role": "roles/viewer",
 *           "members": ["user:sean@example.com"]
 *         }
 *       ]
 *     }
 *
 * For a description of IAM and its features, see the
 * [IAM developer's guide](https://cloud.google.com/iam).
 */
class Policy {
  /** Specifies cloud audit logging configuration for this policy. */
  core.List<AuditConfig> auditConfigs;
  /**
   * Associates a list of `members` to a `role`.
   * Multiple `bindings` must not be specified for the same `role`.
   * `bindings` with no members will result in an error.
   */
  core.List<Binding> bindings;
  /**
   * `etag` is used for optimistic concurrency control as a way to help
   * prevent simultaneous updates of a policy from overwriting each other.
   * It is strongly suggested that systems make use of the `etag` in the
   * read-modify-write cycle to perform policy updates in order to avoid race
   * conditions: An `etag` is returned in the response to `getIamPolicy`, and
   * systems are expected to put that etag in the request to `setIamPolicy` to
   * ensure that their change will be applied to the same version of the policy.
   *
   * If no `etag` is provided in the call to `setIamPolicy`, then the existing
   * policy is overwritten blindly.
   */
  core.String etag;
  core.List<core.int> get etagAsBytes {
    return convert.BASE64.decode(etag);
  }

  void set etagAsBytes(core.List<core.int> _bytes) {
    etag = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  core.bool iamOwned;
  /**
   * If more than one rule is specified, the rules are applied in the following
   * manner:
   * - All matching LOG rules are always applied.
   * - If any DENY/DENY_WITH_LOG rule matches, permission is denied.
   *   Logging will be applied if one or more matching rule requires logging.
   * - Otherwise, if any ALLOW/ALLOW_WITH_LOG rule matches, permission is
   *   granted.
   *   Logging will be applied if one or more matching rule requires logging.
   * - Otherwise, if no rule applies, permission is denied.
   */
  core.List<Rule> rules;
  /** Version of the `Policy`. The default version is 0. */
  core.int version;

  Policy();

  Policy.fromJson(core.Map _json) {
    if (_json.containsKey("auditConfigs")) {
      auditConfigs = _json["auditConfigs"].map((value) => new AuditConfig.fromJson(value)).toList();
    }
    if (_json.containsKey("bindings")) {
      bindings = _json["bindings"].map((value) => new Binding.fromJson(value)).toList();
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("iamOwned")) {
      iamOwned = _json["iamOwned"];
    }
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new Rule.fromJson(value)).toList();
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (auditConfigs != null) {
      _json["auditConfigs"] = auditConfigs.map((value) => (value).toJson()).toList();
    }
    if (bindings != null) {
      _json["bindings"] = bindings.map((value) => (value).toJson()).toList();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (iamOwned != null) {
      _json["iamOwned"] = iamOwned;
    }
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

/**
 * A repository (or repo) is a Git repository storing versioned source content.
 */
class Repo {
  /** How this repository mirrors a repository managed by another service. */
  MirrorConfig mirrorConfig;
  /**
   * Resource name of the repository, of the form
   * `projects/<project>/repos/<repo>`.
   */
  core.String name;
  /** The size in bytes of the repo. */
  core.String size;
  /** URL to clone the repository from Google Cloud Source Repositories. */
  core.String url;

  Repo();

  Repo.fromJson(core.Map _json) {
    if (_json.containsKey("mirrorConfig")) {
      mirrorConfig = new MirrorConfig.fromJson(_json["mirrorConfig"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("size")) {
      size = _json["size"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (mirrorConfig != null) {
      _json["mirrorConfig"] = (mirrorConfig).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (size != null) {
      _json["size"] = size;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** A rule to be applied in a Policy. */
class Rule {
  /**
   * Required
   * Possible string values are:
   * - "NO_ACTION" : Default no action.
   * - "ALLOW" : Matching 'Entries' grant access.
   * - "ALLOW_WITH_LOG" : Matching 'Entries' grant access and the caller
   * promises to log
   * the request per the returned log_configs.
   * - "DENY" : Matching 'Entries' deny access.
   * - "DENY_WITH_LOG" : Matching 'Entries' deny access and the caller promises
   * to log
   * the request per the returned log_configs.
   * - "LOG" : Matching 'Entries' tell IAM.Check callers to generate logs.
   */
  core.String action;
  /** Additional restrictions that must be met */
  core.List<Condition> conditions;
  /** Human-readable description of the rule. */
  core.String description;
  /**
   * If one or more 'in' clauses are specified, the rule matches if
   * the PRINCIPAL/AUTHORITY_SELECTOR is in at least one of these entries.
   */
  core.List<core.String> in_;
  /**
   * The config returned to callers of tech.iam.IAM.CheckPolicy for any entries
   * that match the LOG action.
   */
  core.List<LogConfig> logConfig;
  /**
   * If one or more 'not_in' clauses are specified, the rule matches
   * if the PRINCIPAL/AUTHORITY_SELECTOR is in none of the entries.
   * The format for in and not_in entries is the same as for members in a
   * Binding (see google/iam/v1/policy.proto).
   */
  core.List<core.String> notIn;
  /**
   * A permission is a string of form '<service>.<resource type>.<verb>'
   * (e.g., 'storage.buckets.list'). A value of '*' matches all permissions,
   * and a verb part of '*' (e.g., 'storage.buckets.*') matches all verbs.
   */
  core.List<core.String> permissions;

  Rule();

  Rule.fromJson(core.Map _json) {
    if (_json.containsKey("action")) {
      action = _json["action"];
    }
    if (_json.containsKey("conditions")) {
      conditions = _json["conditions"].map((value) => new Condition.fromJson(value)).toList();
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("in")) {
      in_ = _json["in"];
    }
    if (_json.containsKey("logConfig")) {
      logConfig = _json["logConfig"].map((value) => new LogConfig.fromJson(value)).toList();
    }
    if (_json.containsKey("notIn")) {
      notIn = _json["notIn"];
    }
    if (_json.containsKey("permissions")) {
      permissions = _json["permissions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (action != null) {
      _json["action"] = action;
    }
    if (conditions != null) {
      _json["conditions"] = conditions.map((value) => (value).toJson()).toList();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (in_ != null) {
      _json["in"] = in_;
    }
    if (logConfig != null) {
      _json["logConfig"] = logConfig.map((value) => (value).toJson()).toList();
    }
    if (notIn != null) {
      _json["notIn"] = notIn;
    }
    if (permissions != null) {
      _json["permissions"] = permissions;
    }
    return _json;
  }
}

/** Request message for `SetIamPolicy` method. */
class SetIamPolicyRequest {
  /**
   * REQUIRED: The complete policy to be applied to the `resource`. The size of
   * the policy is limited to a few 10s of KB. An empty policy is a
   * valid policy but certain Cloud Platform services (such as Projects)
   * might reject them.
   */
  Policy policy;
  /**
   * OPTIONAL: A FieldMask specifying which fields of the policy to modify. Only
   * the fields in the mask will be modified. If no mask is provided, a default
   * mask is used:
   * paths: "bindings, etag"
   * This field is only used by Cloud IAM.
   */
  core.String updateMask;

  SetIamPolicyRequest();

  SetIamPolicyRequest.fromJson(core.Map _json) {
    if (_json.containsKey("policy")) {
      policy = new Policy.fromJson(_json["policy"]);
    }
    if (_json.containsKey("updateMask")) {
      updateMask = _json["updateMask"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (policy != null) {
      _json["policy"] = (policy).toJson();
    }
    if (updateMask != null) {
      _json["updateMask"] = updateMask;
    }
    return _json;
  }
}

/** Request message for `TestIamPermissions` method. */
class TestIamPermissionsRequest {
  /**
   * The set of permissions to check for the `resource`. Permissions with
   * wildcards (such as '*' or 'storage.*') are not allowed. For more
   * information see
   * [IAM Overview](https://cloud.google.com/iam/docs/overview#permissions).
   */
  core.List<core.String> permissions;

  TestIamPermissionsRequest();

  TestIamPermissionsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("permissions")) {
      permissions = _json["permissions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (permissions != null) {
      _json["permissions"] = permissions;
    }
    return _json;
  }
}

/** Response message for `TestIamPermissions` method. */
class TestIamPermissionsResponse {
  /**
   * A subset of `TestPermissionsRequest.permissions` that the caller is
   * allowed.
   */
  core.List<core.String> permissions;

  TestIamPermissionsResponse();

  TestIamPermissionsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("permissions")) {
      permissions = _json["permissions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (permissions != null) {
      _json["permissions"] = permissions;
    }
    return _json;
  }
}
