// This is a generated file (see the discoveryapis_generator project).

library googleapis.clouddebugger.v2;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client clouddebugger/v2';

/**
 * Examines the call stack and variables of a running application without
 * stopping or slowing it down.
 */
class ClouddebuggerApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /** Manage cloud debugger */
  static const CloudDebuggerScope = "https://www.googleapis.com/auth/cloud_debugger";


  final commons.ApiRequester _requester;

  ControllerResourceApi get controller => new ControllerResourceApi(_requester);
  DebuggerResourceApi get debugger => new DebuggerResourceApi(_requester);

  ClouddebuggerApi(http.Client client, {core.String rootUrl: "https://clouddebugger.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ControllerResourceApi {
  final commons.ApiRequester _requester;

  ControllerDebuggeesResourceApi get debuggees => new ControllerDebuggeesResourceApi(_requester);

  ControllerResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class ControllerDebuggeesResourceApi {
  final commons.ApiRequester _requester;

  ControllerDebuggeesBreakpointsResourceApi get breakpoints => new ControllerDebuggeesBreakpointsResourceApi(_requester);

  ControllerDebuggeesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Registers the debuggee with the controller service.
   *
   * All agents attached to the same application should call this method with
   * the same request content to get back the same stable `debuggee_id`. Agents
   * should call this method again whenever `google.rpc.Code.NOT_FOUND` is
   * returned from any controller method.
   *
   * This allows the controller service to disable the agent or recover from any
   * data loss. If the debuggee is disabled by the server, the response will
   * have `is_disabled` set to `true`.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [RegisterDebuggeeResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RegisterDebuggeeResponse> register(RegisterDebuggeeRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v2/controller/debuggees/register';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RegisterDebuggeeResponse.fromJson(data));
  }

}


class ControllerDebuggeesBreakpointsResourceApi {
  final commons.ApiRequester _requester;

  ControllerDebuggeesBreakpointsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns the list of all active breakpoints for the debuggee.
   *
   * The breakpoint specification (location, condition, and expression
   * fields) is semantically immutable, although the field values may
   * change. For example, an agent may update the location line number
   * to reflect the actual line where the breakpoint was set, but this
   * doesn't change the breakpoint semantics.
   *
   * This means that an agent does not need to check if a breakpoint has changed
   * when it encounters the same breakpoint on a successive call.
   * Moreover, an agent should remember the breakpoints that are completed
   * until the controller removes them from the active list to avoid
   * setting those breakpoints again.
   *
   * Request parameters:
   *
   * [debuggeeId] - Identifies the debuggee.
   *
   * [successOnTimeout] - If set to `true`, returns `google.rpc.Code.OK` status
   * and sets the
   * `wait_expired` response field to `true` when the server-selected timeout
   * has expired (recommended).
   *
   * If set to `false`, returns `google.rpc.Code.ABORTED` status when the
   * server-selected timeout has expired (deprecated).
   *
   * [waitToken] - A wait token that, if specified, blocks the method call until
   * the list
   * of active breakpoints has changed, or a server selected timeout has
   * expired.  The value should be set from the last returned response.
   *
   * Completes with a [ListActiveBreakpointsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListActiveBreakpointsResponse> list(core.String debuggeeId, {core.bool successOnTimeout, core.String waitToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (debuggeeId == null) {
      throw new core.ArgumentError("Parameter debuggeeId is required.");
    }
    if (successOnTimeout != null) {
      _queryParams["successOnTimeout"] = ["${successOnTimeout}"];
    }
    if (waitToken != null) {
      _queryParams["waitToken"] = [waitToken];
    }

    _url = 'v2/controller/debuggees/' + commons.Escaper.ecapeVariable('$debuggeeId') + '/breakpoints';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListActiveBreakpointsResponse.fromJson(data));
  }

  /**
   * Updates the breakpoint state or mutable fields.
   * The entire Breakpoint message must be sent back to the controller
   * service.
   *
   * Updates to active breakpoint fields are only allowed if the new value
   * does not change the breakpoint specification. Updates to the `location`,
   * `condition` and `expression` fields should not alter the breakpoint
   * semantics. These may only make changes such as canonicalizing a value
   * or snapping the location to the correct line of code.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [debuggeeId] - Identifies the debuggee being debugged.
   *
   * [id] - Breakpoint identifier, unique in the scope of the debuggee.
   *
   * Completes with a [UpdateActiveBreakpointResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UpdateActiveBreakpointResponse> update(UpdateActiveBreakpointRequest request, core.String debuggeeId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (debuggeeId == null) {
      throw new core.ArgumentError("Parameter debuggeeId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v2/controller/debuggees/' + commons.Escaper.ecapeVariable('$debuggeeId') + '/breakpoints/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UpdateActiveBreakpointResponse.fromJson(data));
  }

}


class DebuggerResourceApi {
  final commons.ApiRequester _requester;

  DebuggerDebuggeesResourceApi get debuggees => new DebuggerDebuggeesResourceApi(_requester);

  DebuggerResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class DebuggerDebuggeesResourceApi {
  final commons.ApiRequester _requester;

  DebuggerDebuggeesBreakpointsResourceApi get breakpoints => new DebuggerDebuggeesBreakpointsResourceApi(_requester);

  DebuggerDebuggeesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists all the debuggees that the user can set breakpoints to.
   *
   * Request parameters:
   *
   * [clientVersion] - The client version making the call.
   * Following: `domain/type/version` (e.g., `google.com/intellij/v1`).
   *
   * [includeInactive] - When set to `true`, the result includes all debuggees.
   * Otherwise, the
   * result includes only debuggees that are active.
   *
   * [project] - Project number of a Google Cloud project whose debuggees to
   * list.
   *
   * Completes with a [ListDebuggeesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListDebuggeesResponse> list({core.String clientVersion, core.bool includeInactive, core.String project}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (clientVersion != null) {
      _queryParams["clientVersion"] = [clientVersion];
    }
    if (includeInactive != null) {
      _queryParams["includeInactive"] = ["${includeInactive}"];
    }
    if (project != null) {
      _queryParams["project"] = [project];
    }

    _url = 'v2/debugger/debuggees';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListDebuggeesResponse.fromJson(data));
  }

}


class DebuggerDebuggeesBreakpointsResourceApi {
  final commons.ApiRequester _requester;

  DebuggerDebuggeesBreakpointsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes the breakpoint from the debuggee.
   *
   * Request parameters:
   *
   * [debuggeeId] - ID of the debuggee whose breakpoint to delete.
   *
   * [breakpointId] - ID of the breakpoint to delete.
   *
   * [clientVersion] - The client version making the call.
   * Following: `domain/type/version` (e.g., `google.com/intellij/v1`).
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String debuggeeId, core.String breakpointId, {core.String clientVersion}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (debuggeeId == null) {
      throw new core.ArgumentError("Parameter debuggeeId is required.");
    }
    if (breakpointId == null) {
      throw new core.ArgumentError("Parameter breakpointId is required.");
    }
    if (clientVersion != null) {
      _queryParams["clientVersion"] = [clientVersion];
    }

    _url = 'v2/debugger/debuggees/' + commons.Escaper.ecapeVariable('$debuggeeId') + '/breakpoints/' + commons.Escaper.ecapeVariable('$breakpointId');

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
   * Gets breakpoint information.
   *
   * Request parameters:
   *
   * [debuggeeId] - ID of the debuggee whose breakpoint to get.
   *
   * [breakpointId] - ID of the breakpoint to get.
   *
   * [clientVersion] - The client version making the call.
   * Following: `domain/type/version` (e.g., `google.com/intellij/v1`).
   *
   * Completes with a [GetBreakpointResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetBreakpointResponse> get(core.String debuggeeId, core.String breakpointId, {core.String clientVersion}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (debuggeeId == null) {
      throw new core.ArgumentError("Parameter debuggeeId is required.");
    }
    if (breakpointId == null) {
      throw new core.ArgumentError("Parameter breakpointId is required.");
    }
    if (clientVersion != null) {
      _queryParams["clientVersion"] = [clientVersion];
    }

    _url = 'v2/debugger/debuggees/' + commons.Escaper.ecapeVariable('$debuggeeId') + '/breakpoints/' + commons.Escaper.ecapeVariable('$breakpointId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetBreakpointResponse.fromJson(data));
  }

  /**
   * Lists all breakpoints for the debuggee.
   *
   * Request parameters:
   *
   * [debuggeeId] - ID of the debuggee whose breakpoints to list.
   *
   * [waitToken] - A wait token that, if specified, blocks the call until the
   * breakpoints
   * list has changed, or a server selected timeout has expired.  The value
   * should be set from the last response. The error code
   * `google.rpc.Code.ABORTED` (RPC) is returned on wait timeout, which
   * should be called again with the same `wait_token`.
   *
   * [clientVersion] - The client version making the call.
   * Following: `domain/type/version` (e.g., `google.com/intellij/v1`).
   *
   * [action_value] - Only breakpoints with the specified action will pass the
   * filter.
   * Possible string values are:
   * - "CAPTURE" : A CAPTURE.
   * - "LOG" : A LOG.
   *
   * [includeAllUsers] - When set to `true`, the response includes the list of
   * breakpoints set by
   * any user. Otherwise, it includes only breakpoints set by the caller.
   *
   * [includeInactive] - When set to `true`, the response includes active and
   * inactive
   * breakpoints. Otherwise, it includes only active breakpoints.
   *
   * [stripResults] - This field is deprecated. The following fields are always
   * stripped out of
   * the result: `stack_frames`, `evaluated_expressions` and `variable_table`.
   *
   * Completes with a [ListBreakpointsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListBreakpointsResponse> list(core.String debuggeeId, {core.String waitToken, core.String clientVersion, core.String action_value, core.bool includeAllUsers, core.bool includeInactive, core.bool stripResults}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (debuggeeId == null) {
      throw new core.ArgumentError("Parameter debuggeeId is required.");
    }
    if (waitToken != null) {
      _queryParams["waitToken"] = [waitToken];
    }
    if (clientVersion != null) {
      _queryParams["clientVersion"] = [clientVersion];
    }
    if (action_value != null) {
      _queryParams["action.value"] = [action_value];
    }
    if (includeAllUsers != null) {
      _queryParams["includeAllUsers"] = ["${includeAllUsers}"];
    }
    if (includeInactive != null) {
      _queryParams["includeInactive"] = ["${includeInactive}"];
    }
    if (stripResults != null) {
      _queryParams["stripResults"] = ["${stripResults}"];
    }

    _url = 'v2/debugger/debuggees/' + commons.Escaper.ecapeVariable('$debuggeeId') + '/breakpoints';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListBreakpointsResponse.fromJson(data));
  }

  /**
   * Sets the breakpoint to the debuggee.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [debuggeeId] - ID of the debuggee where the breakpoint is to be set.
   *
   * [clientVersion] - The client version making the call.
   * Following: `domain/type/version` (e.g., `google.com/intellij/v1`).
   *
   * Completes with a [SetBreakpointResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SetBreakpointResponse> set(Breakpoint request, core.String debuggeeId, {core.String clientVersion}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (debuggeeId == null) {
      throw new core.ArgumentError("Parameter debuggeeId is required.");
    }
    if (clientVersion != null) {
      _queryParams["clientVersion"] = [clientVersion];
    }

    _url = 'v2/debugger/debuggees/' + commons.Escaper.ecapeVariable('$debuggeeId') + '/breakpoints/set';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SetBreakpointResponse.fromJson(data));
  }

}



/** An alias to a repo revision. */
class AliasContext {
  /**
   * The alias kind.
   * Possible string values are:
   * - "ANY" : Do not use.
   * - "FIXED" : Git tag
   * - "MOVABLE" : Git branch
   * - "OTHER" : OTHER is used to specify non-standard aliases, those not of the
   * kinds
   * above. For example, if a Git repo has a ref named "refs/foo/bar", it
   * is considered to be of kind OTHER.
   */
  core.String kind;
  /** The alias name. */
  core.String name;

  AliasContext();

  AliasContext.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Represents the breakpoint specification, status and results. */
class Breakpoint {
  /**
   * Action that the agent should perform when the code at the
   * breakpoint location is hit.
   * Possible string values are:
   * - "CAPTURE" : Capture stack frame and variables and update the breakpoint.
   * The data is only captured once. After that the breakpoint is set
   * in a final state.
   * - "LOG" : Log each breakpoint hit. The breakpoint remains active until
   * deleted or expired.
   */
  core.String action;
  /**
   * Condition that triggers the breakpoint.
   * The condition is a compound boolean expression composed using expressions
   * in a programming language at the source location.
   */
  core.String condition;
  /** Time this breakpoint was created by the server in seconds resolution. */
  core.String createTime;
  /**
   * Values of evaluated expressions at breakpoint time.
   * The evaluated expressions appear in exactly the same order they
   * are listed in the `expressions` field.
   * The `name` field holds the original expression text, the `value` or
   * `members` field holds the result of the evaluated expression.
   * If the expression cannot be evaluated, the `status` inside the `Variable`
   * will indicate an error and contain the error text.
   */
  core.List<Variable> evaluatedExpressions;
  /**
   * List of read-only expressions to evaluate at the breakpoint location.
   * The expressions are composed using expressions in the programming language
   * at the source location. If the breakpoint action is `LOG`, the evaluated
   * expressions are included in log statements.
   */
  core.List<core.String> expressions;
  /**
   * Time this breakpoint was finalized as seen by the server in seconds
   * resolution.
   */
  core.String finalTime;
  /** Breakpoint identifier, unique in the scope of the debuggee. */
  core.String id;
  /**
   * When true, indicates that this is a final result and the
   * breakpoint state will not change from here on.
   */
  core.bool isFinalState;
  /**
   * A set of custom breakpoint properties, populated by the agent, to be
   * displayed to the user.
   */
  core.Map<core.String, core.String> labels;
  /** Breakpoint source location. */
  SourceLocation location;
  /**
   * Indicates the severity of the log. Only relevant when action is `LOG`.
   * Possible string values are:
   * - "INFO" : Information log message.
   * - "WARNING" : Warning log message.
   * - "ERROR" : Error log message.
   */
  core.String logLevel;
  /**
   * Only relevant when action is `LOG`. Defines the message to log when
   * the breakpoint hits. The message may include parameter placeholders `$0`,
   * `$1`, etc. These placeholders are replaced with the evaluated value
   * of the appropriate expression. Expressions not referenced in
   * `log_message_format` are not logged.
   *
   * Example: `Message received, id = $0, count = $1` with
   * `expressions` = `[ message.id, message.count ]`.
   */
  core.String logMessageFormat;
  /** The stack at breakpoint time. */
  core.List<StackFrame> stackFrames;
  /**
   * Breakpoint status.
   *
   * The status includes an error flag and a human readable message.
   * This field is usually unset. The message can be either
   * informational or an error message. Regardless, clients should always
   * display the text message back to the user.
   *
   * Error status indicates complete failure of the breakpoint.
   *
   * Example (non-final state): `Still loading symbols...`
   *
   * Examples (final state):
   *
   * *   `Invalid line number` referring to location
   * *   `Field f not found in class C` referring to condition
   */
  StatusMessage status;
  /** E-mail address of the user that created this breakpoint */
  core.String userEmail;
  /**
   * The `variable_table` exists to aid with computation, memory and network
   * traffic optimization.  It enables storing a variable once and reference
   * it from multiple variables, including variables stored in the
   * `variable_table` itself.
   * For example, the same `this` object, which may appear at many levels of
   * the stack, can have all of its data stored once in this table.  The
   * stack frame variables then would hold only a reference to it.
   *
   * The variable `var_table_index` field is an index into this repeated field.
   * The stored objects are nameless and get their name from the referencing
   * variable. The effective variable is a merge of the referencing variable
   * and the referenced variable.
   */
  core.List<Variable> variableTable;

  Breakpoint();

  Breakpoint.fromJson(core.Map _json) {
    if (_json.containsKey("action")) {
      action = _json["action"];
    }
    if (_json.containsKey("condition")) {
      condition = _json["condition"];
    }
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("evaluatedExpressions")) {
      evaluatedExpressions = _json["evaluatedExpressions"].map((value) => new Variable.fromJson(value)).toList();
    }
    if (_json.containsKey("expressions")) {
      expressions = _json["expressions"];
    }
    if (_json.containsKey("finalTime")) {
      finalTime = _json["finalTime"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("isFinalState")) {
      isFinalState = _json["isFinalState"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("location")) {
      location = new SourceLocation.fromJson(_json["location"]);
    }
    if (_json.containsKey("logLevel")) {
      logLevel = _json["logLevel"];
    }
    if (_json.containsKey("logMessageFormat")) {
      logMessageFormat = _json["logMessageFormat"];
    }
    if (_json.containsKey("stackFrames")) {
      stackFrames = _json["stackFrames"].map((value) => new StackFrame.fromJson(value)).toList();
    }
    if (_json.containsKey("status")) {
      status = new StatusMessage.fromJson(_json["status"]);
    }
    if (_json.containsKey("userEmail")) {
      userEmail = _json["userEmail"];
    }
    if (_json.containsKey("variableTable")) {
      variableTable = _json["variableTable"].map((value) => new Variable.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (action != null) {
      _json["action"] = action;
    }
    if (condition != null) {
      _json["condition"] = condition;
    }
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (evaluatedExpressions != null) {
      _json["evaluatedExpressions"] = evaluatedExpressions.map((value) => (value).toJson()).toList();
    }
    if (expressions != null) {
      _json["expressions"] = expressions;
    }
    if (finalTime != null) {
      _json["finalTime"] = finalTime;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (isFinalState != null) {
      _json["isFinalState"] = isFinalState;
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (location != null) {
      _json["location"] = (location).toJson();
    }
    if (logLevel != null) {
      _json["logLevel"] = logLevel;
    }
    if (logMessageFormat != null) {
      _json["logMessageFormat"] = logMessageFormat;
    }
    if (stackFrames != null) {
      _json["stackFrames"] = stackFrames.map((value) => (value).toJson()).toList();
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    if (userEmail != null) {
      _json["userEmail"] = userEmail;
    }
    if (variableTable != null) {
      _json["variableTable"] = variableTable.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * A CloudRepoSourceContext denotes a particular revision in a cloud
 * repo (a repo hosted by the Google Cloud Platform).
 */
class CloudRepoSourceContext {
  /** An alias, which may be a branch or tag. */
  AliasContext aliasContext;
  /** The name of an alias (branch, tag, etc.). */
  core.String aliasName;
  /** The ID of the repo. */
  RepoId repoId;
  /** A revision ID. */
  core.String revisionId;

  CloudRepoSourceContext();

  CloudRepoSourceContext.fromJson(core.Map _json) {
    if (_json.containsKey("aliasContext")) {
      aliasContext = new AliasContext.fromJson(_json["aliasContext"]);
    }
    if (_json.containsKey("aliasName")) {
      aliasName = _json["aliasName"];
    }
    if (_json.containsKey("repoId")) {
      repoId = new RepoId.fromJson(_json["repoId"]);
    }
    if (_json.containsKey("revisionId")) {
      revisionId = _json["revisionId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aliasContext != null) {
      _json["aliasContext"] = (aliasContext).toJson();
    }
    if (aliasName != null) {
      _json["aliasName"] = aliasName;
    }
    if (repoId != null) {
      _json["repoId"] = (repoId).toJson();
    }
    if (revisionId != null) {
      _json["revisionId"] = revisionId;
    }
    return _json;
  }
}

/**
 * A CloudWorkspaceId is a unique identifier for a cloud workspace.
 * A cloud workspace is a place associated with a repo where modified files
 * can be stored before they are committed.
 */
class CloudWorkspaceId {
  /**
   * The unique name of the workspace within the repo.  This is the name
   * chosen by the client in the Source API's CreateWorkspace method.
   */
  core.String name;
  /** The ID of the repo containing the workspace. */
  RepoId repoId;

  CloudWorkspaceId();

  CloudWorkspaceId.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("repoId")) {
      repoId = new RepoId.fromJson(_json["repoId"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (repoId != null) {
      _json["repoId"] = (repoId).toJson();
    }
    return _json;
  }
}

/**
 * A CloudWorkspaceSourceContext denotes a workspace at a particular snapshot.
 */
class CloudWorkspaceSourceContext {
  /**
   * The ID of the snapshot.
   * An empty snapshot_id refers to the most recent snapshot.
   */
  core.String snapshotId;
  /** The ID of the workspace. */
  CloudWorkspaceId workspaceId;

  CloudWorkspaceSourceContext();

  CloudWorkspaceSourceContext.fromJson(core.Map _json) {
    if (_json.containsKey("snapshotId")) {
      snapshotId = _json["snapshotId"];
    }
    if (_json.containsKey("workspaceId")) {
      workspaceId = new CloudWorkspaceId.fromJson(_json["workspaceId"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (snapshotId != null) {
      _json["snapshotId"] = snapshotId;
    }
    if (workspaceId != null) {
      _json["workspaceId"] = (workspaceId).toJson();
    }
    return _json;
  }
}

/**
 * Represents the application to debug. The application may include one or more
 * replicated processes executing the same code. Each of these processes is
 * attached with a debugger agent, carrying out the debugging commands.
 * The agents attached to the same debuggee are identified by using exactly the
 * same field values when registering.
 */
class Debuggee {
  /**
   * Version ID of the agent release. The version ID is structured as
   * following: `domain/type/vmajor.minor` (for example
   * `google.com/gcp-java/v1.1`).
   */
  core.String agentVersion;
  /**
   * Human readable description of the debuggee.
   * Including a human-readable project name, environment name and version
   * information is recommended.
   */
  core.String description;
  /**
   * References to the locations and revisions of the source code used in the
   * deployed application.
   *
   * Contexts describing a remote repo related to the source code
   * have a `category` label of `remote_repo`. Source snapshot source
   * contexts have a `category` of `snapshot`.
   */
  core.List<ExtendedSourceContext> extSourceContexts;
  /**
   * Unique identifier for the debuggee generated by the controller service.
   */
  core.String id;
  /**
   * If set to `true`, indicates that the agent should disable itself and
   * detach from the debuggee.
   */
  core.bool isDisabled;
  /**
   * If set to `true`, indicates that the debuggee is considered as inactive by
   * the Controller service.
   */
  core.bool isInactive;
  /**
   * A set of custom debuggee properties, populated by the agent, to be
   * displayed to the user.
   */
  core.Map<core.String, core.String> labels;
  /**
   * Project the debuggee is associated with.
   * Use the project number when registering a Google Cloud Platform project.
   */
  core.String project;
  /**
   * References to the locations and revisions of the source code used in the
   * deployed application.
   *
   * NOTE: This field is deprecated. Consumers should use
   * `ext_source_contexts` if it is not empty. Debug agents should populate
   * both this field and `ext_source_contexts`.
   */
  core.List<SourceContext> sourceContexts;
  /**
   * Human readable message to be displayed to the user about this debuggee.
   * Absence of this field indicates no status. The message can be either
   * informational or an error status.
   */
  StatusMessage status;
  /**
   * Debuggee uniquifier within the project.
   * Any string that identifies the application within the project can be used.
   * Including environment and version or build IDs is recommended.
   */
  core.String uniquifier;

  Debuggee();

  Debuggee.fromJson(core.Map _json) {
    if (_json.containsKey("agentVersion")) {
      agentVersion = _json["agentVersion"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("extSourceContexts")) {
      extSourceContexts = _json["extSourceContexts"].map((value) => new ExtendedSourceContext.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("isDisabled")) {
      isDisabled = _json["isDisabled"];
    }
    if (_json.containsKey("isInactive")) {
      isInactive = _json["isInactive"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("project")) {
      project = _json["project"];
    }
    if (_json.containsKey("sourceContexts")) {
      sourceContexts = _json["sourceContexts"].map((value) => new SourceContext.fromJson(value)).toList();
    }
    if (_json.containsKey("status")) {
      status = new StatusMessage.fromJson(_json["status"]);
    }
    if (_json.containsKey("uniquifier")) {
      uniquifier = _json["uniquifier"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (agentVersion != null) {
      _json["agentVersion"] = agentVersion;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (extSourceContexts != null) {
      _json["extSourceContexts"] = extSourceContexts.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (isDisabled != null) {
      _json["isDisabled"] = isDisabled;
    }
    if (isInactive != null) {
      _json["isInactive"] = isInactive;
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (project != null) {
      _json["project"] = project;
    }
    if (sourceContexts != null) {
      _json["sourceContexts"] = sourceContexts.map((value) => (value).toJson()).toList();
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    if (uniquifier != null) {
      _json["uniquifier"] = uniquifier;
    }
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

/**
 * An ExtendedSourceContext is a SourceContext combined with additional
 * details describing the context.
 */
class ExtendedSourceContext {
  /** Any source context. */
  SourceContext context;
  /** Labels with user defined metadata. */
  core.Map<core.String, core.String> labels;

  ExtendedSourceContext();

  ExtendedSourceContext.fromJson(core.Map _json) {
    if (_json.containsKey("context")) {
      context = new SourceContext.fromJson(_json["context"]);
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (context != null) {
      _json["context"] = (context).toJson();
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    return _json;
  }
}

/** Represents a message with parameters. */
class FormatMessage {
  /**
   * Format template for the message. The `format` uses placeholders `$0`,
   * `$1`, etc. to reference parameters. `$$` can be used to denote the `$`
   * character.
   *
   * Examples:
   *
   * *   `Failed to load '$0' which helps debug $1 the first time it
   *     is loaded.  Again, $0 is very important.`
   * *   `Please pay $$10 to use $0 instead of $1.`
   */
  core.String format;
  /** Optional parameters to be embedded into the message. */
  core.List<core.String> parameters;

  FormatMessage();

  FormatMessage.fromJson(core.Map _json) {
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("parameters")) {
      parameters = _json["parameters"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (format != null) {
      _json["format"] = format;
    }
    if (parameters != null) {
      _json["parameters"] = parameters;
    }
    return _json;
  }
}

/** A SourceContext referring to a Gerrit project. */
class GerritSourceContext {
  /** An alias, which may be a branch or tag. */
  AliasContext aliasContext;
  /** The name of an alias (branch, tag, etc.). */
  core.String aliasName;
  /**
   * The full project name within the host. Projects may be nested, so
   * "project/subproject" is a valid project name.
   * The "repo name" is hostURI/project.
   */
  core.String gerritProject;
  /** The URI of a running Gerrit instance. */
  core.String hostUri;
  /** A revision (commit) ID. */
  core.String revisionId;

  GerritSourceContext();

  GerritSourceContext.fromJson(core.Map _json) {
    if (_json.containsKey("aliasContext")) {
      aliasContext = new AliasContext.fromJson(_json["aliasContext"]);
    }
    if (_json.containsKey("aliasName")) {
      aliasName = _json["aliasName"];
    }
    if (_json.containsKey("gerritProject")) {
      gerritProject = _json["gerritProject"];
    }
    if (_json.containsKey("hostUri")) {
      hostUri = _json["hostUri"];
    }
    if (_json.containsKey("revisionId")) {
      revisionId = _json["revisionId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aliasContext != null) {
      _json["aliasContext"] = (aliasContext).toJson();
    }
    if (aliasName != null) {
      _json["aliasName"] = aliasName;
    }
    if (gerritProject != null) {
      _json["gerritProject"] = gerritProject;
    }
    if (hostUri != null) {
      _json["hostUri"] = hostUri;
    }
    if (revisionId != null) {
      _json["revisionId"] = revisionId;
    }
    return _json;
  }
}

/** Response for getting breakpoint information. */
class GetBreakpointResponse {
  /**
   * Complete breakpoint state.
   * The fields `id` and `location` are guaranteed to be set.
   */
  Breakpoint breakpoint;

  GetBreakpointResponse();

  GetBreakpointResponse.fromJson(core.Map _json) {
    if (_json.containsKey("breakpoint")) {
      breakpoint = new Breakpoint.fromJson(_json["breakpoint"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (breakpoint != null) {
      _json["breakpoint"] = (breakpoint).toJson();
    }
    return _json;
  }
}

/**
 * A GitSourceContext denotes a particular revision in a third party Git
 * repository (e.g. GitHub).
 */
class GitSourceContext {
  /**
   * Git commit hash.
   * required.
   */
  core.String revisionId;
  /** Git repository URL. */
  core.String url;

  GitSourceContext();

  GitSourceContext.fromJson(core.Map _json) {
    if (_json.containsKey("revisionId")) {
      revisionId = _json["revisionId"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (revisionId != null) {
      _json["revisionId"] = revisionId;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Response for listing active breakpoints. */
class ListActiveBreakpointsResponse {
  /**
   * List of all active breakpoints.
   * The fields `id` and `location` are guaranteed to be set on each breakpoint.
   */
  core.List<Breakpoint> breakpoints;
  /**
   * A wait token that can be used in the next method call to block until
   * the list of breakpoints changes.
   */
  core.String nextWaitToken;
  /**
   * The `wait_expired` field is set to true by the server when the
   * request times out and the field `success_on_timeout` is set to true.
   */
  core.bool waitExpired;

  ListActiveBreakpointsResponse();

  ListActiveBreakpointsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("breakpoints")) {
      breakpoints = _json["breakpoints"].map((value) => new Breakpoint.fromJson(value)).toList();
    }
    if (_json.containsKey("nextWaitToken")) {
      nextWaitToken = _json["nextWaitToken"];
    }
    if (_json.containsKey("waitExpired")) {
      waitExpired = _json["waitExpired"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (breakpoints != null) {
      _json["breakpoints"] = breakpoints.map((value) => (value).toJson()).toList();
    }
    if (nextWaitToken != null) {
      _json["nextWaitToken"] = nextWaitToken;
    }
    if (waitExpired != null) {
      _json["waitExpired"] = waitExpired;
    }
    return _json;
  }
}

/** Response for listing breakpoints. */
class ListBreakpointsResponse {
  /**
   * List of breakpoints matching the request.
   * The fields `id` and `location` are guaranteed to be set on each breakpoint.
   * The fields: `stack_frames`, `evaluated_expressions` and `variable_table`
   * are cleared on each breakpoint regardless of it's status.
   */
  core.List<Breakpoint> breakpoints;
  /**
   * A wait token that can be used in the next call to `list` (REST) or
   * `ListBreakpoints` (RPC) to block until the list of breakpoints has changes.
   */
  core.String nextWaitToken;

  ListBreakpointsResponse();

  ListBreakpointsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("breakpoints")) {
      breakpoints = _json["breakpoints"].map((value) => new Breakpoint.fromJson(value)).toList();
    }
    if (_json.containsKey("nextWaitToken")) {
      nextWaitToken = _json["nextWaitToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (breakpoints != null) {
      _json["breakpoints"] = breakpoints.map((value) => (value).toJson()).toList();
    }
    if (nextWaitToken != null) {
      _json["nextWaitToken"] = nextWaitToken;
    }
    return _json;
  }
}

/** Response for listing debuggees. */
class ListDebuggeesResponse {
  /**
   * List of debuggees accessible to the calling user.
   * Note that the `description` field is the only human readable field
   * that should be displayed to the user.
   * The fields `debuggee.id` and  `description` fields are guaranteed to be
   * set on each debuggee.
   */
  core.List<Debuggee> debuggees;

  ListDebuggeesResponse();

  ListDebuggeesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("debuggees")) {
      debuggees = _json["debuggees"].map((value) => new Debuggee.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (debuggees != null) {
      _json["debuggees"] = debuggees.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Selects a repo using a Google Cloud Platform project ID
 * (e.g. winged-cargo-31) and a repo name within that project.
 */
class ProjectRepoId {
  /** The ID of the project. */
  core.String projectId;
  /** The name of the repo. Leave empty for the default repo. */
  core.String repoName;

  ProjectRepoId();

  ProjectRepoId.fromJson(core.Map _json) {
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("repoName")) {
      repoName = _json["repoName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (repoName != null) {
      _json["repoName"] = repoName;
    }
    return _json;
  }
}

/** Request to register a debuggee. */
class RegisterDebuggeeRequest {
  /**
   * Debuggee information to register.
   * The fields `project`, `uniquifier`, `description` and `agent_version`
   * of the debuggee must be set.
   */
  Debuggee debuggee;

  RegisterDebuggeeRequest();

  RegisterDebuggeeRequest.fromJson(core.Map _json) {
    if (_json.containsKey("debuggee")) {
      debuggee = new Debuggee.fromJson(_json["debuggee"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (debuggee != null) {
      _json["debuggee"] = (debuggee).toJson();
    }
    return _json;
  }
}

/** Response for registering a debuggee. */
class RegisterDebuggeeResponse {
  /**
   * Debuggee resource.
   * The field `id` is guranteed to be set (in addition to the echoed fields).
   */
  Debuggee debuggee;

  RegisterDebuggeeResponse();

  RegisterDebuggeeResponse.fromJson(core.Map _json) {
    if (_json.containsKey("debuggee")) {
      debuggee = new Debuggee.fromJson(_json["debuggee"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (debuggee != null) {
      _json["debuggee"] = (debuggee).toJson();
    }
    return _json;
  }
}

/** A unique identifier for a cloud repo. */
class RepoId {
  /** A combination of a project ID and a repo name. */
  ProjectRepoId projectRepoId;
  /** A server-assigned, globally unique identifier. */
  core.String uid;

  RepoId();

  RepoId.fromJson(core.Map _json) {
    if (_json.containsKey("projectRepoId")) {
      projectRepoId = new ProjectRepoId.fromJson(_json["projectRepoId"]);
    }
    if (_json.containsKey("uid")) {
      uid = _json["uid"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (projectRepoId != null) {
      _json["projectRepoId"] = (projectRepoId).toJson();
    }
    if (uid != null) {
      _json["uid"] = uid;
    }
    return _json;
  }
}

/** Response for setting a breakpoint. */
class SetBreakpointResponse {
  /**
   * Breakpoint resource.
   * The field `id` is guaranteed to be set (in addition to the echoed fileds).
   */
  Breakpoint breakpoint;

  SetBreakpointResponse();

  SetBreakpointResponse.fromJson(core.Map _json) {
    if (_json.containsKey("breakpoint")) {
      breakpoint = new Breakpoint.fromJson(_json["breakpoint"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (breakpoint != null) {
      _json["breakpoint"] = (breakpoint).toJson();
    }
    return _json;
  }
}

/**
 * A SourceContext is a reference to a tree of files. A SourceContext together
 * with a path point to a unique revision of a single file or directory.
 */
class SourceContext {
  /** A SourceContext referring to a revision in a cloud repo. */
  CloudRepoSourceContext cloudRepo;
  /** A SourceContext referring to a snapshot in a cloud workspace. */
  CloudWorkspaceSourceContext cloudWorkspace;
  /** A SourceContext referring to a Gerrit project. */
  GerritSourceContext gerrit;
  /** A SourceContext referring to any third party Git repo (e.g. GitHub). */
  GitSourceContext git;

  SourceContext();

  SourceContext.fromJson(core.Map _json) {
    if (_json.containsKey("cloudRepo")) {
      cloudRepo = new CloudRepoSourceContext.fromJson(_json["cloudRepo"]);
    }
    if (_json.containsKey("cloudWorkspace")) {
      cloudWorkspace = new CloudWorkspaceSourceContext.fromJson(_json["cloudWorkspace"]);
    }
    if (_json.containsKey("gerrit")) {
      gerrit = new GerritSourceContext.fromJson(_json["gerrit"]);
    }
    if (_json.containsKey("git")) {
      git = new GitSourceContext.fromJson(_json["git"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cloudRepo != null) {
      _json["cloudRepo"] = (cloudRepo).toJson();
    }
    if (cloudWorkspace != null) {
      _json["cloudWorkspace"] = (cloudWorkspace).toJson();
    }
    if (gerrit != null) {
      _json["gerrit"] = (gerrit).toJson();
    }
    if (git != null) {
      _json["git"] = (git).toJson();
    }
    return _json;
  }
}

/** Represents a location in the source code. */
class SourceLocation {
  /** Line inside the file. The first line in the file has the value `1`. */
  core.int line;
  /**
   * Path to the source file within the source context of the target binary.
   */
  core.String path;

  SourceLocation();

  SourceLocation.fromJson(core.Map _json) {
    if (_json.containsKey("line")) {
      line = _json["line"];
    }
    if (_json.containsKey("path")) {
      path = _json["path"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (line != null) {
      _json["line"] = line;
    }
    if (path != null) {
      _json["path"] = path;
    }
    return _json;
  }
}

/** Represents a stack frame context. */
class StackFrame {
  /**
   * Set of arguments passed to this function.
   * Note that this might not be populated for all stack frames.
   */
  core.List<Variable> arguments;
  /** Demangled function name at the call site. */
  core.String function;
  /**
   * Set of local variables at the stack frame location.
   * Note that this might not be populated for all stack frames.
   */
  core.List<Variable> locals;
  /** Source location of the call site. */
  SourceLocation location;

  StackFrame();

  StackFrame.fromJson(core.Map _json) {
    if (_json.containsKey("arguments")) {
      arguments = _json["arguments"].map((value) => new Variable.fromJson(value)).toList();
    }
    if (_json.containsKey("function")) {
      function = _json["function"];
    }
    if (_json.containsKey("locals")) {
      locals = _json["locals"].map((value) => new Variable.fromJson(value)).toList();
    }
    if (_json.containsKey("location")) {
      location = new SourceLocation.fromJson(_json["location"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (arguments != null) {
      _json["arguments"] = arguments.map((value) => (value).toJson()).toList();
    }
    if (function != null) {
      _json["function"] = function;
    }
    if (locals != null) {
      _json["locals"] = locals.map((value) => (value).toJson()).toList();
    }
    if (location != null) {
      _json["location"] = (location).toJson();
    }
    return _json;
  }
}

/**
 * Represents a contextual status message.
 * The message can indicate an error or informational status, and refer to
 * specific parts of the containing object.
 * For example, the `Breakpoint.status` field can indicate an error referring
 * to the `BREAKPOINT_SOURCE_LOCATION` with the message `Location not found`.
 */
class StatusMessage {
  /** Status message text. */
  FormatMessage description;
  /** Distinguishes errors from informational messages. */
  core.bool isError;
  /**
   * Reference to which the message applies.
   * Possible string values are:
   * - "UNSPECIFIED" : Status doesn't refer to any particular input.
   * - "BREAKPOINT_SOURCE_LOCATION" : Status applies to the breakpoint and is
   * related to its location.
   * - "BREAKPOINT_CONDITION" : Status applies to the breakpoint and is related
   * to its condition.
   * - "BREAKPOINT_EXPRESSION" : Status applies to the breakpoint and is related
   * to its expressions.
   * - "BREAKPOINT_AGE" : Status applies to the breakpoint and is related to its
   * age.
   * - "VARIABLE_NAME" : Status applies to the entire variable.
   * - "VARIABLE_VALUE" : Status applies to variable value (variable name is
   * valid).
   */
  core.String refersTo;

  StatusMessage();

  StatusMessage.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = new FormatMessage.fromJson(_json["description"]);
    }
    if (_json.containsKey("isError")) {
      isError = _json["isError"];
    }
    if (_json.containsKey("refersTo")) {
      refersTo = _json["refersTo"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = (description).toJson();
    }
    if (isError != null) {
      _json["isError"] = isError;
    }
    if (refersTo != null) {
      _json["refersTo"] = refersTo;
    }
    return _json;
  }
}

/** Request to update an active breakpoint. */
class UpdateActiveBreakpointRequest {
  /**
   * Updated breakpoint information.
   * The field 'id' must be set.
   */
  Breakpoint breakpoint;

  UpdateActiveBreakpointRequest();

  UpdateActiveBreakpointRequest.fromJson(core.Map _json) {
    if (_json.containsKey("breakpoint")) {
      breakpoint = new Breakpoint.fromJson(_json["breakpoint"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (breakpoint != null) {
      _json["breakpoint"] = (breakpoint).toJson();
    }
    return _json;
  }
}

/**
 * Response for updating an active breakpoint.
 * The message is defined to allow future extensions.
 */
class UpdateActiveBreakpointResponse {

  UpdateActiveBreakpointResponse();

  UpdateActiveBreakpointResponse.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/**
 * Represents a variable or an argument possibly of a compound object type.
 * Note how the following variables are represented:
 *
 * 1) A simple variable:
 *
 *     int x = 5
 *
 *     { name: "x", value: "5", type: "int" }  // Captured variable
 *
 * 2) A compound object:
 *
 *     struct T {
 *         int m1;
 *         int m2;
 *     };
 *     T x = { 3, 7 };
 *
 *     {  // Captured variable
 *         name: "x",
 *         type: "T",
 *         members { name: "m1", value: "3", type: "int" },
 *         members { name: "m2", value: "7", type: "int" }
 *     }
 *
 * 3) A pointer where the pointee was captured:
 *
 *     T x = { 3, 7 };
 *     T* p = &x;
 *
 *     {   // Captured variable
 *         name: "p",
 *         type: "T*",
 *         value: "0x00500500",
 *         members { name: "m1", value: "3", type: "int" },
 *         members { name: "m2", value: "7", type: "int" }
 *     }
 *
 * 4) A pointer where the pointee was not captured:
 *
 *     T* p = new T;
 *
 *     {   // Captured variable
 *         name: "p",
 *         type: "T*",
 *         value: "0x00400400"
 *         status { is_error: true, description { format: "unavailable" } }
 *     }
 *
 * The status should describe the reason for the missing value,
 * such as `<optimized out>`, `<inaccessible>`, `<pointers limit reached>`.
 *
 * Note that a null pointer should not have members.
 *
 * 5) An unnamed value:
 *
 *     int* p = new int(7);
 *
 *     {   // Captured variable
 *         name: "p",
 *         value: "0x00500500",
 *         type: "int*",
 *         members { value: "7", type: "int" } }
 *
 * 6) An unnamed pointer where the pointee was not captured:
 *
 *     int* p = new int(7);
 *     int** pp = &p;
 *
 *     {  // Captured variable
 *         name: "pp",
 *         value: "0x00500500",
 *         type: "int**",
 *         members {
 *             value: "0x00400400",
 *             type: "int*"
 *             status {
 *                 is_error: true,
 *                 description: { format: "unavailable" } }
 *             }
 *         }
 *     }
 *
 * To optimize computation, memory and network traffic, variables that
 * repeat in the output multiple times can be stored once in a shared
 * variable table and be referenced using the `var_table_index` field.  The
 * variables stored in the shared table are nameless and are essentially
 * a partition of the complete variable. To reconstruct the complete
 * variable, merge the referencing variable with the referenced variable.
 *
 * When using the shared variable table, the following variables:
 *
 *     T x = { 3, 7 };
 *     T* p = &x;
 *     T& r = x;
 *
 *     { name: "x", var_table_index: 3, type: "T" }  // Captured variables
 *     { name: "p", value "0x00500500", type="T*", var_table_index: 3 }
 *     { name: "r", type="T&", var_table_index: 3 }
 *
 *     {  // Shared variable table entry #3:
 *         members { name: "m1", value: "3", type: "int" },
 *         members { name: "m2", value: "7", type: "int" }
 *     }
 *
 * Note that the pointer address is stored with the referencing variable
 * and not with the referenced variable. This allows the referenced variable
 * to be shared between pointers and references.
 *
 * The type field is optional. The debugger agent may or may not support it.
 */
class Variable {
  /** Members contained or pointed to by the variable. */
  core.List<Variable> members;
  /** Name of the variable, if any. */
  core.String name;
  /**
   * Status associated with the variable. This field will usually stay
   * unset. A status of a single variable only applies to that variable or
   * expression. The rest of breakpoint data still remains valid. Variables
   * might be reported in error state even when breakpoint is not in final
   * state.
   *
   * The message may refer to variable name with `refers_to` set to
   * `VARIABLE_NAME`. Alternatively `refers_to` will be set to `VARIABLE_VALUE`.
   * In either case variable value and members will be unset.
   *
   * Example of error message applied to name: `Invalid expression syntax`.
   *
   * Example of information message applied to value: `Not captured`.
   *
   * Examples of error message applied to value:
   *
   * *   `Malformed string`,
   * *   `Field f not found in class C`
   * *   `Null pointer dereference`
   */
  StatusMessage status;
  /**
   * Variable type (e.g. `MyClass`). If the variable is split with
   * `var_table_index`, `type` goes next to `value`. The interpretation of
   * a type is agent specific. It is recommended to include the dynamic type
   * rather than a static type of an object.
   */
  core.String type;
  /** Simple value of the variable. */
  core.String value;
  /**
   * Reference to a variable in the shared variable table. More than
   * one variable can reference the same variable in the table. The
   * `var_table_index` field is an index into `variable_table` in Breakpoint.
   */
  core.int varTableIndex;

  Variable();

  Variable.fromJson(core.Map _json) {
    if (_json.containsKey("members")) {
      members = _json["members"].map((value) => new Variable.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("status")) {
      status = new StatusMessage.fromJson(_json["status"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
    if (_json.containsKey("varTableIndex")) {
      varTableIndex = _json["varTableIndex"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (members != null) {
      _json["members"] = members.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (value != null) {
      _json["value"] = value;
    }
    if (varTableIndex != null) {
      _json["varTableIndex"] = varTableIndex;
    }
    return _json;
  }
}
