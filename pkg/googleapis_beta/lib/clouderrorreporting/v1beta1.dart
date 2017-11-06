// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.clouderrorreporting.v1beta1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client clouderrorreporting/v1beta1';

/// Groups and counts similar errors from cloud services and applications,
/// reports new errors, and provides access to error groups and their associated
/// errors.
class ClouderrorreportingApi {
  /// View and manage your data across Google Cloud Platform services
  static const CloudPlatformScope =
      "https://www.googleapis.com/auth/cloud-platform";

  final commons.ApiRequester _requester;

  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);

  ClouderrorreportingApi(http.Client client,
      {core.String rootUrl: "https://clouderrorreporting.googleapis.com/",
      core.String servicePath: ""})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsEventsResourceApi get events =>
      new ProjectsEventsResourceApi(_requester);
  ProjectsGroupStatsResourceApi get groupStats =>
      new ProjectsGroupStatsResourceApi(_requester);
  ProjectsGroupsResourceApi get groups =>
      new ProjectsGroupsResourceApi(_requester);

  ProjectsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Deletes all error events of a given project.
  ///
  /// Request parameters:
  ///
  /// [projectName] - [Required] The resource name of the Google Cloud Platform
  /// project. Written
  /// as `projects/` plus the
  /// [Google Cloud Platform project
  /// ID](https://support.google.com/cloud/answer/6158840).
  /// Example: `projects/my-project-123`.
  /// Value must have pattern "^projects/[^/]+$".
  ///
  /// Completes with a [DeleteEventsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<DeleteEventsResponse> deleteEvents(core.String projectName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }

    _url = 'v1beta1/' +
        commons.Escaper.ecapeVariableReserved('$projectName') +
        '/events';

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new DeleteEventsResponse.fromJson(data));
  }
}

class ProjectsEventsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsEventsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Lists the specified events.
  ///
  /// Request parameters:
  ///
  /// [projectName] - [Required] The resource name of the Google Cloud Platform
  /// project. Written
  /// as `projects/` plus the
  /// [Google Cloud Platform project
  /// ID](https://support.google.com/cloud/answer/6158840).
  /// Example: `projects/my-project-123`.
  /// Value must have pattern "^projects/[^/]+$".
  ///
  /// [serviceFilter_resourceType] - [Optional] The exact value to match against
  /// [`ServiceContext.resource_type`](/error-reporting/reference/rest/v1beta1/ServiceContext#FIELDS.resource_type).
  ///
  /// [timeRange_period] - Restricts the query to the specified time range.
  /// Possible string values are:
  /// - "PERIOD_UNSPECIFIED" : A PERIOD_UNSPECIFIED.
  /// - "PERIOD_1_HOUR" : A PERIOD_1_HOUR.
  /// - "PERIOD_6_HOURS" : A PERIOD_6_HOURS.
  /// - "PERIOD_1_DAY" : A PERIOD_1_DAY.
  /// - "PERIOD_1_WEEK" : A PERIOD_1_WEEK.
  /// - "PERIOD_30_DAYS" : A PERIOD_30_DAYS.
  ///
  /// [groupId] - [Required] The group for which events shall be returned.
  ///
  /// [serviceFilter_service] - [Optional] The exact value to match against
  /// [`ServiceContext.service`](/error-reporting/reference/rest/v1beta1/ServiceContext#FIELDS.service).
  ///
  /// [pageToken] - [Optional] A `next_page_token` provided by a previous
  /// response.
  ///
  /// [pageSize] - [Optional] The maximum number of results to return per
  /// response.
  ///
  /// [serviceFilter_version] - [Optional] The exact value to match against
  /// [`ServiceContext.version`](/error-reporting/reference/rest/v1beta1/ServiceContext#FIELDS.version).
  ///
  /// Completes with a [ListEventsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListEventsResponse> list(core.String projectName,
      {core.String serviceFilter_resourceType,
      core.String timeRange_period,
      core.String groupId,
      core.String serviceFilter_service,
      core.String pageToken,
      core.int pageSize,
      core.String serviceFilter_version}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (serviceFilter_resourceType != null) {
      _queryParams["serviceFilter.resourceType"] = [serviceFilter_resourceType];
    }
    if (timeRange_period != null) {
      _queryParams["timeRange.period"] = [timeRange_period];
    }
    if (groupId != null) {
      _queryParams["groupId"] = [groupId];
    }
    if (serviceFilter_service != null) {
      _queryParams["serviceFilter.service"] = [serviceFilter_service];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (serviceFilter_version != null) {
      _queryParams["serviceFilter.version"] = [serviceFilter_version];
    }

    _url = 'v1beta1/' +
        commons.Escaper.ecapeVariableReserved('$projectName') +
        '/events';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListEventsResponse.fromJson(data));
  }

  /// Report an individual error event.
  ///
  /// This endpoint accepts <strong>either</strong> an OAuth token,
  /// <strong>or</strong> an
  /// <a href="https://support.google.com/cloud/answer/6158862">API key</a>
  /// for authentication. To use an API key, append it to the URL as the value
  /// of
  /// a `key` parameter. For example:
  /// <pre>POST
  /// https://clouderrorreporting.googleapis.com/v1beta1/projects/example-project/events:report?key=123ABC456</pre>
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectName] - [Required] The resource name of the Google Cloud Platform
  /// project. Written
  /// as `projects/` plus the
  /// [Google Cloud Platform project
  /// ID](https://support.google.com/cloud/answer/6158840).
  /// Example: `projects/my-project-123`.
  /// Value must have pattern "^projects/[^/]+$".
  ///
  /// Completes with a [ReportErrorEventResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ReportErrorEventResponse> report(
      ReportedErrorEvent request, core.String projectName) {
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

    _url = 'v1beta1/' +
        commons.Escaper.ecapeVariableReserved('$projectName') +
        '/events:report';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ReportErrorEventResponse.fromJson(data));
  }
}

class ProjectsGroupStatsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsGroupStatsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Lists the specified groups.
  ///
  /// Request parameters:
  ///
  /// [projectName] - [Required] The resource name of the Google Cloud Platform
  /// project. Written
  /// as <code>projects/</code> plus the
  /// <a href="https://support.google.com/cloud/answer/6158840">Google Cloud
  /// Platform project ID</a>.
  ///
  /// Example: <code>projects/my-project-123</code>.
  /// Value must have pattern "^projects/[^/]+$".
  ///
  /// [timedCountDuration] - [Optional] The preferred duration for a single
  /// returned `TimedCount`.
  /// If not set, no timed counts are returned.
  ///
  /// [pageToken] - [Optional] A `next_page_token` provided by a previous
  /// response. To view
  /// additional results, pass this token along with the identical query
  /// parameters as the first request.
  ///
  /// [timeRange_period] - Restricts the query to the specified time range.
  /// Possible string values are:
  /// - "PERIOD_UNSPECIFIED" : A PERIOD_UNSPECIFIED.
  /// - "PERIOD_1_HOUR" : A PERIOD_1_HOUR.
  /// - "PERIOD_6_HOURS" : A PERIOD_6_HOURS.
  /// - "PERIOD_1_DAY" : A PERIOD_1_DAY.
  /// - "PERIOD_1_WEEK" : A PERIOD_1_WEEK.
  /// - "PERIOD_30_DAYS" : A PERIOD_30_DAYS.
  ///
  /// [alignment] - [Optional] The alignment of the timed counts to be returned.
  /// Default is `ALIGNMENT_EQUAL_AT_END`.
  /// Possible string values are:
  /// - "ERROR_COUNT_ALIGNMENT_UNSPECIFIED" : A
  /// ERROR_COUNT_ALIGNMENT_UNSPECIFIED.
  /// - "ALIGNMENT_EQUAL_ROUNDED" : A ALIGNMENT_EQUAL_ROUNDED.
  /// - "ALIGNMENT_EQUAL_AT_END" : A ALIGNMENT_EQUAL_AT_END.
  ///
  /// [groupId] - [Optional] List all <code>ErrorGroupStats</code> with these
  /// IDs.
  ///
  /// [serviceFilter_service] - [Optional] The exact value to match against
  /// [`ServiceContext.service`](/error-reporting/reference/rest/v1beta1/ServiceContext#FIELDS.service).
  ///
  /// [pageSize] - [Optional] The maximum number of results to return per
  /// response.
  /// Default is 20.
  ///
  /// [serviceFilter_version] - [Optional] The exact value to match against
  /// [`ServiceContext.version`](/error-reporting/reference/rest/v1beta1/ServiceContext#FIELDS.version).
  ///
  /// [order] - [Optional] The sort order in which the results are returned.
  /// Default is `COUNT_DESC`.
  /// Possible string values are:
  /// - "GROUP_ORDER_UNSPECIFIED" : A GROUP_ORDER_UNSPECIFIED.
  /// - "COUNT_DESC" : A COUNT_DESC.
  /// - "LAST_SEEN_DESC" : A LAST_SEEN_DESC.
  /// - "CREATED_DESC" : A CREATED_DESC.
  /// - "AFFECTED_USERS_DESC" : A AFFECTED_USERS_DESC.
  ///
  /// [serviceFilter_resourceType] - [Optional] The exact value to match against
  /// [`ServiceContext.resource_type`](/error-reporting/reference/rest/v1beta1/ServiceContext#FIELDS.resource_type).
  ///
  /// [alignmentTime] - [Optional] Time where the timed counts shall be aligned
  /// if rounded
  /// alignment is chosen. Default is 00:00 UTC.
  ///
  /// Completes with a [ListGroupStatsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListGroupStatsResponse> list(core.String projectName,
      {core.String timedCountDuration,
      core.String pageToken,
      core.String timeRange_period,
      core.String alignment,
      core.List<core.String> groupId,
      core.String serviceFilter_service,
      core.int pageSize,
      core.String serviceFilter_version,
      core.String order,
      core.String serviceFilter_resourceType,
      core.String alignmentTime}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectName == null) {
      throw new core.ArgumentError("Parameter projectName is required.");
    }
    if (timedCountDuration != null) {
      _queryParams["timedCountDuration"] = [timedCountDuration];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (timeRange_period != null) {
      _queryParams["timeRange.period"] = [timeRange_period];
    }
    if (alignment != null) {
      _queryParams["alignment"] = [alignment];
    }
    if (groupId != null) {
      _queryParams["groupId"] = groupId;
    }
    if (serviceFilter_service != null) {
      _queryParams["serviceFilter.service"] = [serviceFilter_service];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (serviceFilter_version != null) {
      _queryParams["serviceFilter.version"] = [serviceFilter_version];
    }
    if (order != null) {
      _queryParams["order"] = [order];
    }
    if (serviceFilter_resourceType != null) {
      _queryParams["serviceFilter.resourceType"] = [serviceFilter_resourceType];
    }
    if (alignmentTime != null) {
      _queryParams["alignmentTime"] = [alignmentTime];
    }

    _url = 'v1beta1/' +
        commons.Escaper.ecapeVariableReserved('$projectName') +
        '/groupStats';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListGroupStatsResponse.fromJson(data));
  }
}

class ProjectsGroupsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsGroupsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Get the specified group.
  ///
  /// Request parameters:
  ///
  /// [groupName] - [Required] The group resource name. Written as
  /// <code>projects/<var>projectID</var>/groups/<var>group_name</var></code>.
  /// Call
  /// <a
  /// href="/error-reporting/reference/rest/v1beta1/projects.groupStats/list">
  /// <code>groupStats.list</code></a> to return a list of groups belonging to
  /// this project.
  ///
  /// Example: <code>projects/my-project-123/groups/my-group</code>
  /// Value must have pattern "^projects/[^/]+/groups/[^/]+$".
  ///
  /// Completes with a [ErrorGroup].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ErrorGroup> get(core.String groupName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (groupName == null) {
      throw new core.ArgumentError("Parameter groupName is required.");
    }

    _url = 'v1beta1/' + commons.Escaper.ecapeVariableReserved('$groupName');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ErrorGroup.fromJson(data));
  }

  /// Replace the data for the specified group.
  /// Fails if the group does not exist.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [name] - The group resource name.
  /// Example: <code>projects/my-project-123/groups/my-groupid</code>
  /// Value must have pattern "^projects/[^/]+/groups/[^/]+$".
  ///
  /// Completes with a [ErrorGroup].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ErrorGroup> update(ErrorGroup request, core.String name) {
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

    _url = 'v1beta1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ErrorGroup.fromJson(data));
  }
}

/// Response message for deleting error events.
class DeleteEventsResponse {
  DeleteEventsResponse();

  DeleteEventsResponse.fromJson(core.Map _json) {}

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    return _json;
  }
}

/// A description of the context in which an error occurred.
/// This data should be provided by the application when reporting an error,
/// unless the
/// error report has been generated automatically from Google App Engine logs.
class ErrorContext {
  /// The HTTP request which was processed when the error was
  /// triggered.
  HttpRequestContext httpRequest;

  /// The location in the source code where the decision was made to
  /// report the error, usually the place where it was logged.
  /// For a logged exception this would be the source line where the
  /// exception is logged, usually close to the place where it was
  /// caught.
  SourceLocation reportLocation;

  /// Source code that was used to build the executable which has
  /// caused the given error message.
  core.List<SourceReference> sourceReferences;

  /// The user who caused or was affected by the crash.
  /// This can be a user ID, an email address, or an arbitrary token that
  /// uniquely identifies the user.
  /// When sending an error report, leave this field empty if the user was not
  /// logged in. In this case the
  /// Error Reporting system will use other data, such as remote IP address, to
  /// distinguish affected users. See `affected_users_count` in
  /// `ErrorGroupStats`.
  core.String user;

  ErrorContext();

  ErrorContext.fromJson(core.Map _json) {
    if (_json.containsKey("httpRequest")) {
      httpRequest = new HttpRequestContext.fromJson(_json["httpRequest"]);
    }
    if (_json.containsKey("reportLocation")) {
      reportLocation = new SourceLocation.fromJson(_json["reportLocation"]);
    }
    if (_json.containsKey("sourceReferences")) {
      sourceReferences = _json["sourceReferences"]
          .map((value) => new SourceReference.fromJson(value))
          .toList();
    }
    if (_json.containsKey("user")) {
      user = _json["user"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (httpRequest != null) {
      _json["httpRequest"] = (httpRequest).toJson();
    }
    if (reportLocation != null) {
      _json["reportLocation"] = (reportLocation).toJson();
    }
    if (sourceReferences != null) {
      _json["sourceReferences"] =
          sourceReferences.map((value) => (value).toJson()).toList();
    }
    if (user != null) {
      _json["user"] = user;
    }
    return _json;
  }
}

/// An error event which is returned by the Error Reporting system.
class ErrorEvent {
  /// Data about the context in which the error occurred.
  ErrorContext context;

  /// Time when the event occurred as provided in the error report.
  /// If the report did not contain a timestamp, the time the error was received
  /// by the Error Reporting system is used.
  core.String eventTime;

  /// The stack trace that was reported or logged by the service.
  core.String message;

  /// The `ServiceContext` for which this error was reported.
  ServiceContext serviceContext;

  ErrorEvent();

  ErrorEvent.fromJson(core.Map _json) {
    if (_json.containsKey("context")) {
      context = new ErrorContext.fromJson(_json["context"]);
    }
    if (_json.containsKey("eventTime")) {
      eventTime = _json["eventTime"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
    if (_json.containsKey("serviceContext")) {
      serviceContext = new ServiceContext.fromJson(_json["serviceContext"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (context != null) {
      _json["context"] = (context).toJson();
    }
    if (eventTime != null) {
      _json["eventTime"] = eventTime;
    }
    if (message != null) {
      _json["message"] = message;
    }
    if (serviceContext != null) {
      _json["serviceContext"] = (serviceContext).toJson();
    }
    return _json;
  }
}

/// Description of a group of similar error events.
class ErrorGroup {
  /// Group IDs are unique for a given project. If the same kind of error
  /// occurs in different service contexts, it will receive the same group ID.
  core.String groupId;

  /// The group resource name.
  /// Example: <code>projects/my-project-123/groups/my-groupid</code>
  core.String name;

  /// Associated tracking issues.
  core.List<TrackingIssue> trackingIssues;

  ErrorGroup();

  ErrorGroup.fromJson(core.Map _json) {
    if (_json.containsKey("groupId")) {
      groupId = _json["groupId"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("trackingIssues")) {
      trackingIssues = _json["trackingIssues"]
          .map((value) => new TrackingIssue.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (groupId != null) {
      _json["groupId"] = groupId;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (trackingIssues != null) {
      _json["trackingIssues"] =
          trackingIssues.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Data extracted for a specific group based on certain filter criteria,
/// such as a given time period and/or service filter.
class ErrorGroupStats {
  /// Service contexts with a non-zero error count for the given filter
  /// criteria. This list can be truncated if multiple services are affected.
  /// Refer to `num_affected_services` for the total count.
  core.List<ServiceContext> affectedServices;

  /// Approximate number of affected users in the given group that
  /// match the filter criteria.
  /// Users are distinguished by data in the `ErrorContext` of the
  /// individual error events, such as their login name or their remote
  /// IP address in case of HTTP requests.
  /// The number of affected users can be zero even if the number of
  /// errors is non-zero if no data was provided from which the
  /// affected user could be deduced.
  /// Users are counted based on data in the request
  /// context that was provided in the error report. If more users are
  /// implicitly affected, such as due to a crash of the whole service,
  /// this is not reflected here.
  core.String affectedUsersCount;

  /// Approximate total number of events in the given group that match
  /// the filter criteria.
  core.String count;

  /// Approximate first occurrence that was ever seen for this group
  /// and which matches the given filter criteria, ignoring the
  /// time_range that was specified in the request.
  core.String firstSeenTime;

  /// Group data that is independent of the filter criteria.
  ErrorGroup group;

  /// Approximate last occurrence that was ever seen for this group and
  /// which matches the given filter criteria, ignoring the time_range
  /// that was specified in the request.
  core.String lastSeenTime;

  /// The total number of services with a non-zero error count for the given
  /// filter criteria.
  core.int numAffectedServices;

  /// An arbitrary event that is chosen as representative for the whole group.
  /// The representative event is intended to be used as a quick preview for
  /// the whole group. Events in the group are usually sufficiently similar
  /// to each other such that showing an arbitrary representative provides
  /// insight into the characteristics of the group as a whole.
  ErrorEvent representative;

  /// Approximate number of occurrences over time.
  /// Timed counts returned by ListGroups are guaranteed to be:
  ///
  /// - Inside the requested time interval
  /// - Non-overlapping, and
  /// - Ordered by ascending time.
  core.List<TimedCount> timedCounts;

  ErrorGroupStats();

  ErrorGroupStats.fromJson(core.Map _json) {
    if (_json.containsKey("affectedServices")) {
      affectedServices = _json["affectedServices"]
          .map((value) => new ServiceContext.fromJson(value))
          .toList();
    }
    if (_json.containsKey("affectedUsersCount")) {
      affectedUsersCount = _json["affectedUsersCount"];
    }
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("firstSeenTime")) {
      firstSeenTime = _json["firstSeenTime"];
    }
    if (_json.containsKey("group")) {
      group = new ErrorGroup.fromJson(_json["group"]);
    }
    if (_json.containsKey("lastSeenTime")) {
      lastSeenTime = _json["lastSeenTime"];
    }
    if (_json.containsKey("numAffectedServices")) {
      numAffectedServices = _json["numAffectedServices"];
    }
    if (_json.containsKey("representative")) {
      representative = new ErrorEvent.fromJson(_json["representative"]);
    }
    if (_json.containsKey("timedCounts")) {
      timedCounts = _json["timedCounts"]
          .map((value) => new TimedCount.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (affectedServices != null) {
      _json["affectedServices"] =
          affectedServices.map((value) => (value).toJson()).toList();
    }
    if (affectedUsersCount != null) {
      _json["affectedUsersCount"] = affectedUsersCount;
    }
    if (count != null) {
      _json["count"] = count;
    }
    if (firstSeenTime != null) {
      _json["firstSeenTime"] = firstSeenTime;
    }
    if (group != null) {
      _json["group"] = (group).toJson();
    }
    if (lastSeenTime != null) {
      _json["lastSeenTime"] = lastSeenTime;
    }
    if (numAffectedServices != null) {
      _json["numAffectedServices"] = numAffectedServices;
    }
    if (representative != null) {
      _json["representative"] = (representative).toJson();
    }
    if (timedCounts != null) {
      _json["timedCounts"] =
          timedCounts.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// HTTP request data that is related to a reported error.
/// This data should be provided by the application when reporting an error,
/// unless the
/// error report has been generated automatically from Google App Engine logs.
class HttpRequestContext {
  /// The type of HTTP request, such as `GET`, `POST`, etc.
  core.String method;

  /// The referrer information that is provided with the request.
  core.String referrer;

  /// The IP address from which the request originated.
  /// This can be IPv4, IPv6, or a token which is derived from the
  /// IP address, depending on the data that has been provided
  /// in the error report.
  core.String remoteIp;

  /// The HTTP response status code for the request.
  core.int responseStatusCode;

  /// The URL of the request.
  core.String url;

  /// The user agent information that is provided with the request.
  core.String userAgent;

  HttpRequestContext();

  HttpRequestContext.fromJson(core.Map _json) {
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("referrer")) {
      referrer = _json["referrer"];
    }
    if (_json.containsKey("remoteIp")) {
      remoteIp = _json["remoteIp"];
    }
    if (_json.containsKey("responseStatusCode")) {
      responseStatusCode = _json["responseStatusCode"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("userAgent")) {
      userAgent = _json["userAgent"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (method != null) {
      _json["method"] = method;
    }
    if (referrer != null) {
      _json["referrer"] = referrer;
    }
    if (remoteIp != null) {
      _json["remoteIp"] = remoteIp;
    }
    if (responseStatusCode != null) {
      _json["responseStatusCode"] = responseStatusCode;
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (userAgent != null) {
      _json["userAgent"] = userAgent;
    }
    return _json;
  }
}

/// Contains a set of requested error events.
class ListEventsResponse {
  /// The error events which match the given request.
  core.List<ErrorEvent> errorEvents;

  /// If non-empty, more results are available.
  /// Pass this token, along with the same query parameters as the first
  /// request, to view the next page of results.
  core.String nextPageToken;

  /// The timestamp specifies the start time to which the request was
  /// restricted.
  core.String timeRangeBegin;

  ListEventsResponse();

  ListEventsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("errorEvents")) {
      errorEvents = _json["errorEvents"]
          .map((value) => new ErrorEvent.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("timeRangeBegin")) {
      timeRangeBegin = _json["timeRangeBegin"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (errorEvents != null) {
      _json["errorEvents"] =
          errorEvents.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (timeRangeBegin != null) {
      _json["timeRangeBegin"] = timeRangeBegin;
    }
    return _json;
  }
}

/// Contains a set of requested error group stats.
class ListGroupStatsResponse {
  /// The error group stats which match the given request.
  core.List<ErrorGroupStats> errorGroupStats;

  /// If non-empty, more results are available.
  /// Pass this token, along with the same query parameters as the first
  /// request, to view the next page of results.
  core.String nextPageToken;

  /// The timestamp specifies the start time to which the request was
  /// restricted.
  /// The start time is set based on the requested time range. It may be
  /// adjusted
  /// to a later time if a project has exceeded the storage quota and older data
  /// has been deleted.
  core.String timeRangeBegin;

  ListGroupStatsResponse();

  ListGroupStatsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("errorGroupStats")) {
      errorGroupStats = _json["errorGroupStats"]
          .map((value) => new ErrorGroupStats.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("timeRangeBegin")) {
      timeRangeBegin = _json["timeRangeBegin"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (errorGroupStats != null) {
      _json["errorGroupStats"] =
          errorGroupStats.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (timeRangeBegin != null) {
      _json["timeRangeBegin"] = timeRangeBegin;
    }
    return _json;
  }
}

/// Response for reporting an individual error event.
/// Data may be added to this message in the future.
class ReportErrorEventResponse {
  ReportErrorEventResponse();

  ReportErrorEventResponse.fromJson(core.Map _json) {}

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    return _json;
  }
}

/// An error event which is reported to the Error Reporting system.
class ReportedErrorEvent {
  /// [Optional] A description of the context in which the error occurred.
  ErrorContext context;

  /// [Optional] Time when the event occurred.
  /// If not provided, the time when the event was received by the
  /// Error Reporting system will be used.
  core.String eventTime;

  /// [Required] The error message.
  /// If no `context.reportLocation` is provided, the message must contain a
  /// header (typically consisting of the exception type name and an error
  /// message) and an exception stack trace in one of the supported programming
  /// languages and formats.
  /// Supported languages are Java, Python, JavaScript, Ruby, C#, PHP, and Go.
  /// Supported stack trace formats are:
  ///
  /// * **Java**: Must be the return value of
  /// [`Throwable.printStackTrace()`](https://docs.oracle.com/javase/7/docs/api/java/lang/Throwable.html#printStackTrace%28%29).
  /// * **Python**: Must be the return value of
  /// [`traceback.format_exc()`](https://docs.python.org/2/library/traceback.html#traceback.format_exc).
  /// * **JavaScript**: Must be the value of
  /// [`error.stack`](https://github.com/v8/v8/wiki/Stack-Trace-API)
  /// as returned by V8.
  /// * **Ruby**: Must contain frames returned by
  /// [`Exception.backtrace`](https://ruby-doc.org/core-2.2.0/Exception.html#method-i-backtrace).
  /// * **C#**: Must be the return value of
  /// [`Exception.ToString()`](https://msdn.microsoft.com/en-us/library/system.exception.tostring.aspx).
  /// * **PHP**: Must start with `PHP (Notice|Parse error|Fatal error|Warning)`
  /// and contain the result of
  /// [`(string)$exception`](http://php.net/manual/en/exception.tostring.php).
  /// * **Go**: Must be the return value of
  /// [`runtime.Stack()`](https://golang.org/pkg/runtime/debug/#Stack).
  core.String message;

  /// [Required] The service context in which this error has occurred.
  ServiceContext serviceContext;

  ReportedErrorEvent();

  ReportedErrorEvent.fromJson(core.Map _json) {
    if (_json.containsKey("context")) {
      context = new ErrorContext.fromJson(_json["context"]);
    }
    if (_json.containsKey("eventTime")) {
      eventTime = _json["eventTime"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
    if (_json.containsKey("serviceContext")) {
      serviceContext = new ServiceContext.fromJson(_json["serviceContext"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (context != null) {
      _json["context"] = (context).toJson();
    }
    if (eventTime != null) {
      _json["eventTime"] = eventTime;
    }
    if (message != null) {
      _json["message"] = message;
    }
    if (serviceContext != null) {
      _json["serviceContext"] = (serviceContext).toJson();
    }
    return _json;
  }
}

/// Describes a running service that sends errors.
/// Its version changes over time and multiple versions can run in parallel.
class ServiceContext {
  /// Type of the MonitoredResource. List of possible values:
  /// https://cloud.google.com/monitoring/api/resources
  ///
  /// Value is set automatically for incoming errors and must not be set when
  /// reporting errors.
  core.String resourceType;

  /// An identifier of the service, such as the name of the
  /// executable, job, or Google App Engine service name. This field is expected
  /// to have a low number of values that are relatively stable over time, as
  /// opposed to `version`, which can be changed whenever new code is deployed.
  ///
  /// Contains the service name for error reports extracted from Google
  /// App Engine logs or `default` if the App Engine default service is used.
  core.String service;

  /// Represents the source code version that the developer provided,
  /// which could represent a version label or a Git SHA-1 hash, for example.
  /// For App Engine standard environment, the version is set to the version of
  /// the app.
  core.String version;

  ServiceContext();

  ServiceContext.fromJson(core.Map _json) {
    if (_json.containsKey("resourceType")) {
      resourceType = _json["resourceType"];
    }
    if (_json.containsKey("service")) {
      service = _json["service"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (resourceType != null) {
      _json["resourceType"] = resourceType;
    }
    if (service != null) {
      _json["service"] = service;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

/// Indicates a location in the source code of the service for which errors are
/// reported. `functionName` must be provided by the application when reporting
/// an error, unless the error report contains a `message` with a supported
/// exception stack trace. All fields are optional for the later case.
class SourceLocation {
  /// The source code filename, which can include a truncated relative
  /// path, or a full path from a production machine.
  core.String filePath;

  /// Human-readable name of a function or method.
  /// The value can include optional context like the class or package name.
  /// For example, `my.package.MyClass.method` in case of Java.
  core.String functionName;

  /// 1-based. 0 indicates that the line number is unknown.
  core.int lineNumber;

  SourceLocation();

  SourceLocation.fromJson(core.Map _json) {
    if (_json.containsKey("filePath")) {
      filePath = _json["filePath"];
    }
    if (_json.containsKey("functionName")) {
      functionName = _json["functionName"];
    }
    if (_json.containsKey("lineNumber")) {
      lineNumber = _json["lineNumber"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (filePath != null) {
      _json["filePath"] = filePath;
    }
    if (functionName != null) {
      _json["functionName"] = functionName;
    }
    if (lineNumber != null) {
      _json["lineNumber"] = lineNumber;
    }
    return _json;
  }
}

/// A reference to a particular snapshot of the source tree used to build and
/// deploy an application.
class SourceReference {
  /// Optional. A URI string identifying the repository.
  /// Example: "https://github.com/GoogleCloudPlatform/kubernetes.git"
  core.String repository;

  /// The canonical and persistent identifier of the deployed revision.
  /// Example (git): "0035781c50ec7aa23385dc841529ce8a4b70db1b"
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

/// The number of errors in a given time period.
/// All numbers are approximate since the error events are sampled
/// before counting them.
class TimedCount {
  /// Approximate number of occurrences in the given time period.
  core.String count;

  /// End of the time period to which `count` refers (excluded).
  core.String endTime;

  /// Start of the time period to which `count` refers (included).
  core.String startTime;

  TimedCount();

  TimedCount.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (count != null) {
      _json["count"] = count;
    }
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

/// Information related to tracking the progress on resolving the error.
class TrackingIssue {
  /// A URL pointing to a related entry in an issue tracking system.
  /// Example: https://github.com/user/project/issues/4
  core.String url;

  TrackingIssue();

  TrackingIssue.fromJson(core.Map _json) {
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}
