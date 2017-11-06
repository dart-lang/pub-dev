// This is a generated file (see the discoveryapis_generator project).

library googleapis.monitoring.v3;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client monitoring/v3';

/**
 * Manages your Stackdriver Monitoring data and configurations. Most projects
 * must be associated with a Stackdriver account, with a few exceptions as noted
 * on the individual method pages.
 */
class MonitoringApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /**
   * View and write monitoring data for all of your Google and third-party Cloud
   * and API projects
   */
  static const MonitoringScope = "https://www.googleapis.com/auth/monitoring";

  /**
   * View monitoring data for all of your Google Cloud and third-party projects
   */
  static const MonitoringReadScope = "https://www.googleapis.com/auth/monitoring.read";

  /** Publish metric data to your Google Cloud projects */
  static const MonitoringWriteScope = "https://www.googleapis.com/auth/monitoring.write";


  final commons.ApiRequester _requester;

  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);

  MonitoringApi(http.Client client, {core.String rootUrl: "https://monitoring.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsCollectdTimeSeriesResourceApi get collectdTimeSeries => new ProjectsCollectdTimeSeriesResourceApi(_requester);
  ProjectsGroupsResourceApi get groups => new ProjectsGroupsResourceApi(_requester);
  ProjectsMetricDescriptorsResourceApi get metricDescriptors => new ProjectsMetricDescriptorsResourceApi(_requester);
  ProjectsMonitoredResourceDescriptorsResourceApi get monitoredResourceDescriptors => new ProjectsMonitoredResourceDescriptorsResourceApi(_requester);
  ProjectsTimeSeriesResourceApi get timeSeries => new ProjectsTimeSeriesResourceApi(_requester);

  ProjectsResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class ProjectsCollectdTimeSeriesResourceApi {
  final commons.ApiRequester _requester;

  ProjectsCollectdTimeSeriesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Stackdriver Monitoring Agent only: Creates a new time series.<aside
   * class="caution">This method is only for use by the Stackdriver Monitoring
   * Agent. Use projects.timeSeries.create instead.</aside>
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - The project in which to create the time series. The format is
   * "projects/PROJECT_ID_OR_NUMBER".
   * Value must have pattern "^projects/[^/]+$".
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> create(CreateCollectdTimeSeriesRequest request, core.String name) {
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

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name') + '/collectdTimeSeries';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

}


class ProjectsGroupsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsGroupsMembersResourceApi get members => new ProjectsGroupsMembersResourceApi(_requester);

  ProjectsGroupsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new group.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - The project in which to create the group. The format is
   * "projects/{project_id_or_number}".
   * Value must have pattern "^projects/[^/]+$".
   *
   * [validateOnly] - If true, validate this request but do not create the
   * group.
   *
   * Completes with a [Group].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Group> create(Group request, core.String name, {core.bool validateOnly}) {
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
    if (validateOnly != null) {
      _queryParams["validateOnly"] = ["${validateOnly}"];
    }

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name') + '/groups';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Group.fromJson(data));
  }

  /**
   * Deletes an existing group.
   *
   * Request parameters:
   *
   * [name] - The group to delete. The format is
   * "projects/{project_id_or_number}/groups/{group_id}".
   * Value must have pattern "^projects/[^/]+/groups/[^/]+$".
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

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name');

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
   * Gets a single group.
   *
   * Request parameters:
   *
   * [name] - The group to retrieve. The format is
   * "projects/{project_id_or_number}/groups/{group_id}".
   * Value must have pattern "^projects/[^/]+/groups/[^/]+$".
   *
   * Completes with a [Group].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Group> get(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Group.fromJson(data));
  }

  /**
   * Lists the existing groups.
   *
   * Request parameters:
   *
   * [name] - The project whose groups are to be listed. The format is
   * "projects/{project_id_or_number}".
   * Value must have pattern "^projects/[^/]+$".
   *
   * [childrenOfGroup] - A group name:
   * "projects/{project_id_or_number}/groups/{group_id}". Returns groups whose
   * parentName field contains the group name. If no groups have this parent,
   * the results are empty.
   *
   * [descendantsOfGroup] - A group name:
   * "projects/{project_id_or_number}/groups/{group_id}". Returns the
   * descendants of the specified group. This is a superset of the results
   * returned by the childrenOfGroup filter, and includes children-of-children,
   * and so forth.
   *
   * [pageToken] - If this field is not empty then it must contain the
   * nextPageToken value returned by a previous call to this method. Using this
   * field causes the method to return additional results from the previous
   * method call.
   *
   * [pageSize] - A positive number that is the maximum number of results to
   * return.
   *
   * [ancestorsOfGroup] - A group name:
   * "projects/{project_id_or_number}/groups/{group_id}". Returns groups that
   * are ancestors of the specified group. The groups are returned in order,
   * starting with the immediate parent and ending with the most distant
   * ancestor. If the specified group has no immediate parent, the results are
   * empty.
   *
   * Completes with a [ListGroupsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListGroupsResponse> list(core.String name, {core.String childrenOfGroup, core.String descendantsOfGroup, core.String pageToken, core.int pageSize, core.String ancestorsOfGroup}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }
    if (childrenOfGroup != null) {
      _queryParams["childrenOfGroup"] = [childrenOfGroup];
    }
    if (descendantsOfGroup != null) {
      _queryParams["descendantsOfGroup"] = [descendantsOfGroup];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (ancestorsOfGroup != null) {
      _queryParams["ancestorsOfGroup"] = [ancestorsOfGroup];
    }

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name') + '/groups';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListGroupsResponse.fromJson(data));
  }

  /**
   * Updates an existing group. You can change any group attributes except name.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - Output only. The name of this group. The format is
   * "projects/{project_id_or_number}/groups/{group_id}". When creating a group,
   * this field is ignored and a new name is created consisting of the project
   * specified in the call to CreateGroup and a unique {group_id} that is
   * generated automatically.
   * Value must have pattern "^projects/[^/]+/groups/[^/]+$".
   *
   * [validateOnly] - If true, validate this request but do not update the
   * existing group.
   *
   * Completes with a [Group].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Group> update(Group request, core.String name, {core.bool validateOnly}) {
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
    if (validateOnly != null) {
      _queryParams["validateOnly"] = ["${validateOnly}"];
    }

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Group.fromJson(data));
  }

}


class ProjectsGroupsMembersResourceApi {
  final commons.ApiRequester _requester;

  ProjectsGroupsMembersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists the monitored resources that are members of a group.
   *
   * Request parameters:
   *
   * [name] - The group whose members are listed. The format is
   * "projects/{project_id_or_number}/groups/{group_id}".
   * Value must have pattern "^projects/[^/]+/groups/[^/]+$".
   *
   * [interval_endTime] - Required. The end of the time interval.
   *
   * [filter] - An optional list filter describing the members to be returned.
   * The filter may reference the type, labels, and metadata of monitored
   * resources that comprise the group. For example, to return only resources
   * representing Compute Engine VM instances, use this filter:
   * resource.type = "gce_instance"
   *
   * [pageToken] - If this field is not empty then it must contain the
   * nextPageToken value returned by a previous call to this method. Using this
   * field causes the method to return additional results from the previous
   * method call.
   *
   * [pageSize] - A positive number that is the maximum number of results to
   * return.
   *
   * [interval_startTime] - Optional. The beginning of the time interval. The
   * default value for the start time is the end time. The start time must not
   * be later than the end time.
   *
   * Completes with a [ListGroupMembersResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListGroupMembersResponse> list(core.String name, {core.String interval_endTime, core.String filter, core.String pageToken, core.int pageSize, core.String interval_startTime}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }
    if (interval_endTime != null) {
      _queryParams["interval.endTime"] = [interval_endTime];
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
    if (interval_startTime != null) {
      _queryParams["interval.startTime"] = [interval_startTime];
    }

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name') + '/members';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListGroupMembersResponse.fromJson(data));
  }

}


class ProjectsMetricDescriptorsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsMetricDescriptorsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new metric descriptor. User-created metric descriptors define
   * custom metrics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - The project on which to execute the request. The format is
   * "projects/{project_id_or_number}".
   * Value must have pattern "^projects/[^/]+$".
   *
   * Completes with a [MetricDescriptor].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<MetricDescriptor> create(MetricDescriptor request, core.String name) {
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

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name') + '/metricDescriptors';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new MetricDescriptor.fromJson(data));
  }

  /**
   * Deletes a metric descriptor. Only user-created custom metrics can be
   * deleted.
   *
   * Request parameters:
   *
   * [name] - The metric descriptor on which to execute the request. The format
   * is "projects/{project_id_or_number}/metricDescriptors/{metric_id}". An
   * example of {metric_id} is: "custom.googleapis.com/my_test_metric".
   * Value must have pattern "^projects/[^/]+/metricDescriptors/.+$".
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

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name');

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
   * Gets a single metric descriptor. This method does not require a Stackdriver
   * account.
   *
   * Request parameters:
   *
   * [name] - The metric descriptor on which to execute the request. The format
   * is "projects/{project_id_or_number}/metricDescriptors/{metric_id}". An
   * example value of {metric_id} is
   * "compute.googleapis.com/instance/disk/read_bytes_count".
   * Value must have pattern "^projects/[^/]+/metricDescriptors/.+$".
   *
   * Completes with a [MetricDescriptor].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<MetricDescriptor> get(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new MetricDescriptor.fromJson(data));
  }

  /**
   * Lists metric descriptors that match a filter. This method does not require
   * a Stackdriver account.
   *
   * Request parameters:
   *
   * [name] - The project on which to execute the request. The format is
   * "projects/{project_id_or_number}".
   * Value must have pattern "^projects/[^/]+$".
   *
   * [filter] - If this field is empty, all custom and system-defined metric
   * descriptors are returned. Otherwise, the filter specifies which metric
   * descriptors are to be returned. For example, the following filter matches
   * all custom metrics:
   * metric.type = starts_with("custom.googleapis.com/")
   *
   * [pageToken] - If this field is not empty then it must contain the
   * nextPageToken value returned by a previous call to this method. Using this
   * field causes the method to return additional results from the previous
   * method call.
   *
   * [pageSize] - A positive number that is the maximum number of results to
   * return.
   *
   * Completes with a [ListMetricDescriptorsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListMetricDescriptorsResponse> list(core.String name, {core.String filter, core.String pageToken, core.int pageSize}) {
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

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name') + '/metricDescriptors';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListMetricDescriptorsResponse.fromJson(data));
  }

}


class ProjectsMonitoredResourceDescriptorsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsMonitoredResourceDescriptorsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets a single monitored resource descriptor. This method does not require a
   * Stackdriver account.
   *
   * Request parameters:
   *
   * [name] - The monitored resource descriptor to get. The format is
   * "projects/{project_id_or_number}/monitoredResourceDescriptors/{resource_type}".
   * The {resource_type} is a predefined type, such as cloudsql_database.
   * Value must have pattern
   * "^projects/[^/]+/monitoredResourceDescriptors/[^/]+$".
   *
   * Completes with a [MonitoredResourceDescriptor].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<MonitoredResourceDescriptor> get(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new MonitoredResourceDescriptor.fromJson(data));
  }

  /**
   * Lists monitored resource descriptors that match a filter. This method does
   * not require a Stackdriver account.
   *
   * Request parameters:
   *
   * [name] - The project on which to execute the request. The format is
   * "projects/{project_id_or_number}".
   * Value must have pattern "^projects/[^/]+$".
   *
   * [filter] - An optional filter describing the descriptors to be returned.
   * The filter can reference the descriptor's type and labels. For example, the
   * following filter returns only Google Compute Engine descriptors that have
   * an id label:
   * resource.type = starts_with("gce_") AND resource.label:id
   *
   * [pageToken] - If this field is not empty then it must contain the
   * nextPageToken value returned by a previous call to this method. Using this
   * field causes the method to return additional results from the previous
   * method call.
   *
   * [pageSize] - A positive number that is the maximum number of results to
   * return.
   *
   * Completes with a [ListMonitoredResourceDescriptorsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListMonitoredResourceDescriptorsResponse> list(core.String name, {core.String filter, core.String pageToken, core.int pageSize}) {
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

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name') + '/monitoredResourceDescriptors';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListMonitoredResourceDescriptorsResponse.fromJson(data));
  }

}


class ProjectsTimeSeriesResourceApi {
  final commons.ApiRequester _requester;

  ProjectsTimeSeriesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates or adds data to one or more time series. The response is empty if
   * all time series in the request were written. If any time series could not
   * be written, a corresponding failure message is included in the error
   * response.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - The project on which to execute the request. The format is
   * "projects/{project_id_or_number}".
   * Value must have pattern "^projects/[^/]+$".
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> create(CreateTimeSeriesRequest request, core.String name) {
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

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name') + '/timeSeries';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Lists time series that match a filter. This method does not require a
   * Stackdriver account.
   *
   * Request parameters:
   *
   * [name] - The project on which to execute the request. The format is
   * "projects/{project_id_or_number}".
   * Value must have pattern "^projects/[^/]+$".
   *
   * [filter] - A monitoring filter that specifies which time series should be
   * returned. The filter must specify a single metric type, and can
   * additionally specify metric labels and other information. For example:
   * metric.type = "compute.googleapis.com/instance/cpu/usage_time" AND
   *     metric.label.instance_name = "my-instance-name"
   *
   * [pageToken] - If this field is not empty then it must contain the
   * nextPageToken value returned by a previous call to this method. Using this
   * field causes the method to return additional results from the previous
   * method call.
   *
   * [aggregation_perSeriesAligner] - The approach to be used to align
   * individual time series. Not all alignment functions may be applied to all
   * time series, depending on the metric type and value type of the original
   * time series. Alignment may change the metric type or the value type of the
   * time series.Time series data must be aligned in order to perform cross-time
   * series reduction. If crossSeriesReducer is specified, then perSeriesAligner
   * must be specified and not equal ALIGN_NONE and alignmentPeriod must be
   * specified; otherwise, an error is returned.
   * Possible string values are:
   * - "ALIGN_NONE" : A ALIGN_NONE.
   * - "ALIGN_DELTA" : A ALIGN_DELTA.
   * - "ALIGN_RATE" : A ALIGN_RATE.
   * - "ALIGN_INTERPOLATE" : A ALIGN_INTERPOLATE.
   * - "ALIGN_NEXT_OLDER" : A ALIGN_NEXT_OLDER.
   * - "ALIGN_MIN" : A ALIGN_MIN.
   * - "ALIGN_MAX" : A ALIGN_MAX.
   * - "ALIGN_MEAN" : A ALIGN_MEAN.
   * - "ALIGN_COUNT" : A ALIGN_COUNT.
   * - "ALIGN_SUM" : A ALIGN_SUM.
   * - "ALIGN_STDDEV" : A ALIGN_STDDEV.
   * - "ALIGN_COUNT_TRUE" : A ALIGN_COUNT_TRUE.
   * - "ALIGN_FRACTION_TRUE" : A ALIGN_FRACTION_TRUE.
   * - "ALIGN_PERCENTILE_99" : A ALIGN_PERCENTILE_99.
   * - "ALIGN_PERCENTILE_95" : A ALIGN_PERCENTILE_95.
   * - "ALIGN_PERCENTILE_50" : A ALIGN_PERCENTILE_50.
   * - "ALIGN_PERCENTILE_05" : A ALIGN_PERCENTILE_05.
   *
   * [interval_startTime] - Optional. The beginning of the time interval. The
   * default value for the start time is the end time. The start time must not
   * be later than the end time.
   *
   * [view] - Specifies which information is returned about the time series.
   * Possible string values are:
   * - "FULL" : A FULL.
   * - "HEADERS" : A HEADERS.
   *
   * [aggregation_groupByFields] - The set of fields to preserve when
   * crossSeriesReducer is specified. The groupByFields determine how the time
   * series are partitioned into subsets prior to applying the aggregation
   * function. Each subset contains time series that have the same value for
   * each of the grouping fields. Each individual time series is a member of
   * exactly one subset. The crossSeriesReducer is applied to each subset of
   * time series. It is not possible to reduce across different resource types,
   * so this field implicitly contains resource.type. Fields not specified in
   * groupByFields are aggregated away. If groupByFields is not specified and
   * all the time series have the same resource type, then the time series are
   * aggregated into a single output time series. If crossSeriesReducer is not
   * defined, this field is ignored.
   *
   * [interval_endTime] - Required. The end of the time interval.
   *
   * [aggregation_alignmentPeriod] - The alignment period for per-time series
   * alignment. If present, alignmentPeriod must be at least 60 seconds. After
   * per-time series alignment, each time series will contain data points only
   * on the period boundaries. If perSeriesAligner is not specified or equals
   * ALIGN_NONE, then this field is ignored. If perSeriesAligner is specified
   * and does not equal ALIGN_NONE, then this field must be defined; otherwise
   * an error is returned.
   *
   * [pageSize] - A positive number that is the maximum number of results to
   * return. When view field sets to FULL, it limits the number of Points server
   * will return; if view field is HEADERS, it limits the number of TimeSeries
   * server will return.
   *
   * [orderBy] - Specifies the order in which the points of the time series
   * should be returned. By default, results are not ordered. Currently, this
   * field must be left blank.
   *
   * [aggregation_crossSeriesReducer] - The approach to be used to combine time
   * series. Not all reducer functions may be applied to all time series,
   * depending on the metric type and the value type of the original time
   * series. Reduction may change the metric type of value type of the time
   * series.Time series data must be aligned in order to perform cross-time
   * series reduction. If crossSeriesReducer is specified, then perSeriesAligner
   * must be specified and not equal ALIGN_NONE and alignmentPeriod must be
   * specified; otherwise, an error is returned.
   * Possible string values are:
   * - "REDUCE_NONE" : A REDUCE_NONE.
   * - "REDUCE_MEAN" : A REDUCE_MEAN.
   * - "REDUCE_MIN" : A REDUCE_MIN.
   * - "REDUCE_MAX" : A REDUCE_MAX.
   * - "REDUCE_SUM" : A REDUCE_SUM.
   * - "REDUCE_STDDEV" : A REDUCE_STDDEV.
   * - "REDUCE_COUNT" : A REDUCE_COUNT.
   * - "REDUCE_COUNT_TRUE" : A REDUCE_COUNT_TRUE.
   * - "REDUCE_FRACTION_TRUE" : A REDUCE_FRACTION_TRUE.
   * - "REDUCE_PERCENTILE_99" : A REDUCE_PERCENTILE_99.
   * - "REDUCE_PERCENTILE_95" : A REDUCE_PERCENTILE_95.
   * - "REDUCE_PERCENTILE_50" : A REDUCE_PERCENTILE_50.
   * - "REDUCE_PERCENTILE_05" : A REDUCE_PERCENTILE_05.
   *
   * Completes with a [ListTimeSeriesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListTimeSeriesResponse> list(core.String name, {core.String filter, core.String pageToken, core.String aggregation_perSeriesAligner, core.String interval_startTime, core.String view, core.List<core.String> aggregation_groupByFields, core.String interval_endTime, core.String aggregation_alignmentPeriod, core.int pageSize, core.String orderBy, core.String aggregation_crossSeriesReducer}) {
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
    if (aggregation_perSeriesAligner != null) {
      _queryParams["aggregation.perSeriesAligner"] = [aggregation_perSeriesAligner];
    }
    if (interval_startTime != null) {
      _queryParams["interval.startTime"] = [interval_startTime];
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }
    if (aggregation_groupByFields != null) {
      _queryParams["aggregation.groupByFields"] = aggregation_groupByFields;
    }
    if (interval_endTime != null) {
      _queryParams["interval.endTime"] = [interval_endTime];
    }
    if (aggregation_alignmentPeriod != null) {
      _queryParams["aggregation.alignmentPeriod"] = [aggregation_alignmentPeriod];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (aggregation_crossSeriesReducer != null) {
      _queryParams["aggregation.crossSeriesReducer"] = [aggregation_crossSeriesReducer];
    }

    _url = 'v3/' + commons.Escaper.ecapeVariableReserved('$name') + '/timeSeries';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListTimeSeriesResponse.fromJson(data));
  }

}



/**
 * A Distribution may optionally contain a histogram of the values in the
 * population. The histogram is given in bucket_counts as counts of values that
 * fall into one of a sequence of non-overlapping buckets. The sequence of
 * buckets is described by bucket_options.A bucket specifies an inclusive lower
 * bound and exclusive upper bound for the values that are counted for that
 * bucket. The upper bound of a bucket is strictly greater than the lower
 * bound.The sequence of N buckets for a Distribution consists of an underflow
 * bucket (number 0), zero or more finite buckets (number 1 through N - 2) and
 * an overflow bucket (number N - 1). The buckets are contiguous: the lower
 * bound of bucket i (i > 0) is the same as the upper bound of bucket i - 1. The
 * buckets span the whole range of finite values: lower bound of the underflow
 * bucket is -infinity and the upper bound of the overflow bucket is +infinity.
 * The finite buckets are so-called because both bounds are finite.BucketOptions
 * describes bucket boundaries in one of three ways. Two describe the boundaries
 * by giving parameters for a formula to generate boundaries and one gives the
 * bucket boundaries explicitly.If bucket_options is not given, then no
 * bucket_counts may be given.
 */
class BucketOptions {
  /** The explicit buckets. */
  Explicit explicitBuckets;
  /** The exponential buckets. */
  Exponential exponentialBuckets;
  /** The linear bucket. */
  Linear linearBuckets;

  BucketOptions();

  BucketOptions.fromJson(core.Map _json) {
    if (_json.containsKey("explicitBuckets")) {
      explicitBuckets = new Explicit.fromJson(_json["explicitBuckets"]);
    }
    if (_json.containsKey("exponentialBuckets")) {
      exponentialBuckets = new Exponential.fromJson(_json["exponentialBuckets"]);
    }
    if (_json.containsKey("linearBuckets")) {
      linearBuckets = new Linear.fromJson(_json["linearBuckets"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (explicitBuckets != null) {
      _json["explicitBuckets"] = (explicitBuckets).toJson();
    }
    if (exponentialBuckets != null) {
      _json["exponentialBuckets"] = (exponentialBuckets).toJson();
    }
    if (linearBuckets != null) {
      _json["linearBuckets"] = (linearBuckets).toJson();
    }
    return _json;
  }
}

/**
 * A collection of data points sent from a collectd-based plugin. See the
 * collectd documentation for more information.
 */
class CollectdPayload {
  /** The end time of the interval. */
  core.String endTime;
  /** The measurement metadata. Example: "process_id" -> 12345 */
  core.Map<core.String, TypedValue> metadata;
  /** The name of the plugin. Example: "disk". */
  core.String plugin;
  /** The instance name of the plugin Example: "hdcl". */
  core.String pluginInstance;
  /** The start time of the interval. */
  core.String startTime;
  /** The measurement type. Example: "memory". */
  core.String type;
  /** The measurement type instance. Example: "used". */
  core.String typeInstance;
  /**
   * The measured values during this time interval. Each value must have a
   * different dataSourceName.
   */
  core.List<CollectdValue> values;

  CollectdPayload();

  CollectdPayload.fromJson(core.Map _json) {
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("metadata")) {
      metadata = commons.mapMap(_json["metadata"], (item) => new TypedValue.fromJson(item));
    }
    if (_json.containsKey("plugin")) {
      plugin = _json["plugin"];
    }
    if (_json.containsKey("pluginInstance")) {
      pluginInstance = _json["pluginInstance"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("typeInstance")) {
      typeInstance = _json["typeInstance"];
    }
    if (_json.containsKey("values")) {
      values = _json["values"].map((value) => new CollectdValue.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (metadata != null) {
      _json["metadata"] = commons.mapMap(metadata, (item) => (item).toJson());
    }
    if (plugin != null) {
      _json["plugin"] = plugin;
    }
    if (pluginInstance != null) {
      _json["pluginInstance"] = pluginInstance;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (typeInstance != null) {
      _json["typeInstance"] = typeInstance;
    }
    if (values != null) {
      _json["values"] = values.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A single data point from a collectd-based plugin. */
class CollectdValue {
  /**
   * The data source for the collectd value. For example there are two data
   * sources for network measurements: "rx" and "tx".
   */
  core.String dataSourceName;
  /**
   * The type of measurement.
   * Possible string values are:
   * - "UNSPECIFIED_DATA_SOURCE_TYPE" : An unspecified data source type. This
   * corresponds to
   * google.api.MetricDescriptor.MetricKind.METRIC_KIND_UNSPECIFIED.
   * - "GAUGE" : An instantaneous measurement of a varying quantity. This
   * corresponds to google.api.MetricDescriptor.MetricKind.GAUGE.
   * - "COUNTER" : A cumulative value over time. This corresponds to
   * google.api.MetricDescriptor.MetricKind.CUMULATIVE.
   * - "DERIVE" : A rate of change of the measurement.
   * - "ABSOLUTE" : An amount of change since the last measurement interval.
   * This corresponds to google.api.MetricDescriptor.MetricKind.DELTA.
   */
  core.String dataSourceType;
  /** The measurement value. */
  TypedValue value;

  CollectdValue();

  CollectdValue.fromJson(core.Map _json) {
    if (_json.containsKey("dataSourceName")) {
      dataSourceName = _json["dataSourceName"];
    }
    if (_json.containsKey("dataSourceType")) {
      dataSourceType = _json["dataSourceType"];
    }
    if (_json.containsKey("value")) {
      value = new TypedValue.fromJson(_json["value"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dataSourceName != null) {
      _json["dataSourceName"] = dataSourceName;
    }
    if (dataSourceType != null) {
      _json["dataSourceType"] = dataSourceType;
    }
    if (value != null) {
      _json["value"] = (value).toJson();
    }
    return _json;
  }
}

/** The CreateCollectdTimeSeries request. */
class CreateCollectdTimeSeriesRequest {
  /**
   * The collectd payloads representing the time series data. You must not
   * include more than a single point for each time series, so no two payloads
   * can have the same values for all of the fields plugin, plugin_instance,
   * type, and type_instance.
   */
  core.List<CollectdPayload> collectdPayloads;
  /**
   * The version of collectd that collected the data. Example: "5.3.0-192.el6".
   */
  core.String collectdVersion;
  /** The monitored resource associated with the time series. */
  MonitoredResource resource;

  CreateCollectdTimeSeriesRequest();

  CreateCollectdTimeSeriesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("collectdPayloads")) {
      collectdPayloads = _json["collectdPayloads"].map((value) => new CollectdPayload.fromJson(value)).toList();
    }
    if (_json.containsKey("collectdVersion")) {
      collectdVersion = _json["collectdVersion"];
    }
    if (_json.containsKey("resource")) {
      resource = new MonitoredResource.fromJson(_json["resource"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (collectdPayloads != null) {
      _json["collectdPayloads"] = collectdPayloads.map((value) => (value).toJson()).toList();
    }
    if (collectdVersion != null) {
      _json["collectdVersion"] = collectdVersion;
    }
    if (resource != null) {
      _json["resource"] = (resource).toJson();
    }
    return _json;
  }
}

/** The CreateTimeSeries request. */
class CreateTimeSeriesRequest {
  /**
   * The new data to be added to a list of time series. Adds at most one data
   * point to each of several time series. The new data point must be more
   * recent than any other point in its time series. Each TimeSeries value must
   * fully specify a unique time series by supplying all label values for the
   * metric and the monitored resource.
   */
  core.List<TimeSeries> timeSeries;

  CreateTimeSeriesRequest();

  CreateTimeSeriesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("timeSeries")) {
      timeSeries = _json["timeSeries"].map((value) => new TimeSeries.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (timeSeries != null) {
      _json["timeSeries"] = timeSeries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Distribution contains summary statistics for a population of values and,
 * optionally, a histogram representing the distribution of those values across
 * a specified set of histogram buckets.The summary statistics are the count,
 * mean, sum of the squared deviation from the mean, the minimum, and the
 * maximum of the set of population of values.The histogram is based on a
 * sequence of buckets and gives a count of values that fall into each bucket.
 * The boundaries of the buckets are given either explicitly or by specifying
 * parameters for a method of computing them (buckets of fixed width or buckets
 * of exponentially increasing width).Although it is not forbidden, it is
 * generally a bad idea to include non-finite values (infinities or NaNs) in the
 * population of values, as this will render the mean and
 * sum_of_squared_deviation fields meaningless.
 */
class Distribution {
  /**
   * If bucket_options is given, then the sum of the values in bucket_counts
   * must equal the value in count. If bucket_options is not given, no
   * bucket_counts fields may be given.Bucket counts are given in order under
   * the numbering scheme described above (the underflow bucket has number 0;
   * the finite buckets, if any, have numbers 1 through N-2; the overflow bucket
   * has number N-1).The size of bucket_counts must be no greater than N as
   * defined in bucket_options.Any suffix of trailing zero bucket_count fields
   * may be omitted.
   */
  core.List<core.String> bucketCounts;
  /** Defines the histogram bucket boundaries. */
  BucketOptions bucketOptions;
  /** The number of values in the population. Must be non-negative. */
  core.String count;
  /**
   * The arithmetic mean of the values in the population. If count is zero then
   * this field must be zero.
   */
  core.double mean;
  /**
   * If specified, contains the range of the population values. The field must
   * not be present if the count is zero. This field is presently ignored by the
   * Stackdriver Monitoring API v3.
   */
  Range range;
  /**
   * The sum of squared deviations from the mean of the values in the
   * population. For values x_i this is:
   * Sum[i=1..n]((x_i - mean)^2)
   * Knuth, "The Art of Computer Programming", Vol. 2, page 323, 3rd edition
   * describes Welford's method for accumulating this sum in one pass.If count
   * is zero then this field must be zero.
   */
  core.double sumOfSquaredDeviation;

  Distribution();

  Distribution.fromJson(core.Map _json) {
    if (_json.containsKey("bucketCounts")) {
      bucketCounts = _json["bucketCounts"];
    }
    if (_json.containsKey("bucketOptions")) {
      bucketOptions = new BucketOptions.fromJson(_json["bucketOptions"]);
    }
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("mean")) {
      mean = _json["mean"];
    }
    if (_json.containsKey("range")) {
      range = new Range.fromJson(_json["range"]);
    }
    if (_json.containsKey("sumOfSquaredDeviation")) {
      sumOfSquaredDeviation = _json["sumOfSquaredDeviation"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bucketCounts != null) {
      _json["bucketCounts"] = bucketCounts;
    }
    if (bucketOptions != null) {
      _json["bucketOptions"] = (bucketOptions).toJson();
    }
    if (count != null) {
      _json["count"] = count;
    }
    if (mean != null) {
      _json["mean"] = mean;
    }
    if (range != null) {
      _json["range"] = (range).toJson();
    }
    if (sumOfSquaredDeviation != null) {
      _json["sumOfSquaredDeviation"] = sumOfSquaredDeviation;
    }
    return _json;
  }
}

/**
 * A generic empty message that you can re-use to avoid defining duplicated
 * empty messages in your APIs. A typical example is to use it as the request or
 * the response type of an API method. For instance:
 * service Foo {
 *   rpc Bar(google.protobuf.Empty) returns (google.protobuf.Empty);
 * }
 * The JSON representation for Empty is empty JSON object {}.
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
 * A set of buckets with arbitrary widths.Defines size(bounds) + 1 (= N) buckets
 * with these boundaries for bucket i:Upper bound (0 <= i < N-1): boundsi  Lower
 * bound (1 <= i < N); boundsi - 1There must be at least one element in bounds.
 * If bounds has only one element, there are no finite buckets, and that single
 * element is the common boundary of the overflow and underflow buckets.
 */
class Explicit {
  /** The values must be monotonically increasing. */
  core.List<core.double> bounds;

  Explicit();

  Explicit.fromJson(core.Map _json) {
    if (_json.containsKey("bounds")) {
      bounds = _json["bounds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bounds != null) {
      _json["bounds"] = bounds;
    }
    return _json;
  }
}

/**
 * Specify a sequence of buckets that have a width that is proportional to the
 * value of the lower bound. Each bucket represents a constant relative
 * uncertainty on a specific value in the bucket.Defines num_finite_buckets + 2
 * (= N) buckets with these boundaries for bucket i:Upper bound (0 <= i < N-1):
 * scale * (growth_factor ^ i).  Lower bound (1 <= i < N): scale *
 * (growth_factor ^ (i - 1)).
 */
class Exponential {
  /** Must be greater than 1. */
  core.double growthFactor;
  /** Must be greater than 0. */
  core.int numFiniteBuckets;
  /** Must be greater than 0. */
  core.double scale;

  Exponential();

  Exponential.fromJson(core.Map _json) {
    if (_json.containsKey("growthFactor")) {
      growthFactor = _json["growthFactor"];
    }
    if (_json.containsKey("numFiniteBuckets")) {
      numFiniteBuckets = _json["numFiniteBuckets"];
    }
    if (_json.containsKey("scale")) {
      scale = _json["scale"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (growthFactor != null) {
      _json["growthFactor"] = growthFactor;
    }
    if (numFiniteBuckets != null) {
      _json["numFiniteBuckets"] = numFiniteBuckets;
    }
    if (scale != null) {
      _json["scale"] = scale;
    }
    return _json;
  }
}

/** A single field of a message type. */
class Field {
  /**
   * The field cardinality.
   * Possible string values are:
   * - "CARDINALITY_UNKNOWN" : For fields with unknown cardinality.
   * - "CARDINALITY_OPTIONAL" : For optional fields.
   * - "CARDINALITY_REQUIRED" : For required fields. Proto2 syntax only.
   * - "CARDINALITY_REPEATED" : For repeated fields.
   */
  core.String cardinality;
  /**
   * The string value of the default value of this field. Proto2 syntax only.
   */
  core.String defaultValue;
  /** The field JSON name. */
  core.String jsonName;
  /**
   * The field type.
   * Possible string values are:
   * - "TYPE_UNKNOWN" : Field type unknown.
   * - "TYPE_DOUBLE" : Field type double.
   * - "TYPE_FLOAT" : Field type float.
   * - "TYPE_INT64" : Field type int64.
   * - "TYPE_UINT64" : Field type uint64.
   * - "TYPE_INT32" : Field type int32.
   * - "TYPE_FIXED64" : Field type fixed64.
   * - "TYPE_FIXED32" : Field type fixed32.
   * - "TYPE_BOOL" : Field type bool.
   * - "TYPE_STRING" : Field type string.
   * - "TYPE_GROUP" : Field type group. Proto2 syntax only, and deprecated.
   * - "TYPE_MESSAGE" : Field type message.
   * - "TYPE_BYTES" : Field type bytes.
   * - "TYPE_UINT32" : Field type uint32.
   * - "TYPE_ENUM" : Field type enum.
   * - "TYPE_SFIXED32" : Field type sfixed32.
   * - "TYPE_SFIXED64" : Field type sfixed64.
   * - "TYPE_SINT32" : Field type sint32.
   * - "TYPE_SINT64" : Field type sint64.
   */
  core.String kind;
  /** The field name. */
  core.String name;
  /** The field number. */
  core.int number;
  /**
   * The index of the field type in Type.oneofs, for message or enumeration
   * types. The first type has index 1; zero means the type is not in the list.
   */
  core.int oneofIndex;
  /** The protocol buffer options. */
  core.List<Option> options;
  /** Whether to use alternative packed wire representation. */
  core.bool packed;
  /**
   * The field type URL, without the scheme, for message or enumeration types.
   * Example: "type.googleapis.com/google.protobuf.Timestamp".
   */
  core.String typeUrl;

  Field();

  Field.fromJson(core.Map _json) {
    if (_json.containsKey("cardinality")) {
      cardinality = _json["cardinality"];
    }
    if (_json.containsKey("defaultValue")) {
      defaultValue = _json["defaultValue"];
    }
    if (_json.containsKey("jsonName")) {
      jsonName = _json["jsonName"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("number")) {
      number = _json["number"];
    }
    if (_json.containsKey("oneofIndex")) {
      oneofIndex = _json["oneofIndex"];
    }
    if (_json.containsKey("options")) {
      options = _json["options"].map((value) => new Option.fromJson(value)).toList();
    }
    if (_json.containsKey("packed")) {
      packed = _json["packed"];
    }
    if (_json.containsKey("typeUrl")) {
      typeUrl = _json["typeUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cardinality != null) {
      _json["cardinality"] = cardinality;
    }
    if (defaultValue != null) {
      _json["defaultValue"] = defaultValue;
    }
    if (jsonName != null) {
      _json["jsonName"] = jsonName;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (number != null) {
      _json["number"] = number;
    }
    if (oneofIndex != null) {
      _json["oneofIndex"] = oneofIndex;
    }
    if (options != null) {
      _json["options"] = options.map((value) => (value).toJson()).toList();
    }
    if (packed != null) {
      _json["packed"] = packed;
    }
    if (typeUrl != null) {
      _json["typeUrl"] = typeUrl;
    }
    return _json;
  }
}

/**
 * The description of a dynamic collection of monitored resources. Each group
 * has a filter that is matched against monitored resources and their associated
 * metadata. If a group's filter matches an available monitored resource, then
 * that resource is a member of that group. Groups can contain any number of
 * monitored resources, and each monitored resource can be a member of any
 * number of groups.Groups can be nested in parent-child hierarchies. The
 * parentName field identifies an optional parent for each group. If a group has
 * a parent, then the only monitored resources available to be matched by the
 * group's filter are the resources contained in the parent group. In other
 * words, a group contains the monitored resources that match its filter and the
 * filters of all the group's ancestors. A group without a parent can contain
 * any monitored resource.For example, consider an infrastructure running a set
 * of instances with two user-defined tags: "environment" and "role". A parent
 * group has a filter, environment="production". A child of that parent group
 * has a filter, role="transcoder". The parent group contains all instances in
 * the production environment, regardless of their roles. The child group
 * contains instances that have the transcoder role and are in the production
 * environment.The monitored resources contained in a group can change at any
 * moment, depending on what resources exist and what filters are associated
 * with the group and its ancestors.
 */
class Group {
  /** A user-assigned name for this group, used only for display purposes. */
  core.String displayName;
  /**
   * The filter used to determine which monitored resources belong to this
   * group.
   */
  core.String filter;
  /**
   * If true, the members of this group are considered to be a cluster. The
   * system can perform additional analysis on groups that are clusters.
   */
  core.bool isCluster;
  /**
   * Output only. The name of this group. The format is
   * "projects/{project_id_or_number}/groups/{group_id}". When creating a group,
   * this field is ignored and a new name is created consisting of the project
   * specified in the call to CreateGroup and a unique {group_id} that is
   * generated automatically.
   */
  core.String name;
  /**
   * The name of the group's parent, if it has one. The format is
   * "projects/{project_id_or_number}/groups/{group_id}". For groups with no
   * parent, parentName is the empty string, "".
   */
  core.String parentName;

  Group();

  Group.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("filter")) {
      filter = _json["filter"];
    }
    if (_json.containsKey("isCluster")) {
      isCluster = _json["isCluster"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parentName")) {
      parentName = _json["parentName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (filter != null) {
      _json["filter"] = filter;
    }
    if (isCluster != null) {
      _json["isCluster"] = isCluster;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parentName != null) {
      _json["parentName"] = parentName;
    }
    return _json;
  }
}

/** A description of a label. */
class LabelDescriptor {
  /** A human-readable description for the label. */
  core.String description;
  /** The label key. */
  core.String key;
  /**
   * The type of data that can be assigned to the label.
   * Possible string values are:
   * - "STRING" : A variable-length string. This is the default.
   * - "BOOL" : Boolean; true or false.
   * - "INT64" : A 64-bit signed integer.
   */
  core.String valueType;

  LabelDescriptor();

  LabelDescriptor.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("valueType")) {
      valueType = _json["valueType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (key != null) {
      _json["key"] = key;
    }
    if (valueType != null) {
      _json["valueType"] = valueType;
    }
    return _json;
  }
}

/**
 * Specify a sequence of buckets that all have the same width (except overflow
 * and underflow). Each bucket represents a constant absolute uncertainty on the
 * specific value in the bucket.Defines num_finite_buckets + 2 (= N) buckets
 * with these boundaries for bucket i:Upper bound (0 <= i < N-1): offset +
 * (width * i).  Lower bound (1 <= i < N): offset + (width * (i - 1)).
 */
class Linear {
  /** Must be greater than 0. */
  core.int numFiniteBuckets;
  /** Lower bound of the first bucket. */
  core.double offset;
  /** Must be greater than 0. */
  core.double width;

  Linear();

  Linear.fromJson(core.Map _json) {
    if (_json.containsKey("numFiniteBuckets")) {
      numFiniteBuckets = _json["numFiniteBuckets"];
    }
    if (_json.containsKey("offset")) {
      offset = _json["offset"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (numFiniteBuckets != null) {
      _json["numFiniteBuckets"] = numFiniteBuckets;
    }
    if (offset != null) {
      _json["offset"] = offset;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/** The ListGroupMembers response. */
class ListGroupMembersResponse {
  /** A set of monitored resources in the group. */
  core.List<MonitoredResource> members;
  /**
   * If there are more results than have been returned, then this field is set
   * to a non-empty value. To see the additional results, use that value as
   * pageToken in the next call to this method.
   */
  core.String nextPageToken;
  /** The total number of elements matching this request. */
  core.int totalSize;

  ListGroupMembersResponse();

  ListGroupMembersResponse.fromJson(core.Map _json) {
    if (_json.containsKey("members")) {
      members = _json["members"].map((value) => new MonitoredResource.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("totalSize")) {
      totalSize = _json["totalSize"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (members != null) {
      _json["members"] = members.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (totalSize != null) {
      _json["totalSize"] = totalSize;
    }
    return _json;
  }
}

/** The ListGroups response. */
class ListGroupsResponse {
  /** The groups that match the specified filters. */
  core.List<Group> group;
  /**
   * If there are more results than have been returned, then this field is set
   * to a non-empty value. To see the additional results, use that value as
   * pageToken in the next call to this method.
   */
  core.String nextPageToken;

  ListGroupsResponse();

  ListGroupsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("group")) {
      group = _json["group"].map((value) => new Group.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (group != null) {
      _json["group"] = group.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** The ListMetricDescriptors response. */
class ListMetricDescriptorsResponse {
  /**
   * The metric descriptors that are available to the project and that match the
   * value of filter, if present.
   */
  core.List<MetricDescriptor> metricDescriptors;
  /**
   * If there are more results than have been returned, then this field is set
   * to a non-empty value. To see the additional results, use that value as
   * pageToken in the next call to this method.
   */
  core.String nextPageToken;

  ListMetricDescriptorsResponse();

  ListMetricDescriptorsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("metricDescriptors")) {
      metricDescriptors = _json["metricDescriptors"].map((value) => new MetricDescriptor.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (metricDescriptors != null) {
      _json["metricDescriptors"] = metricDescriptors.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** The ListMonitoredResourcDescriptors response. */
class ListMonitoredResourceDescriptorsResponse {
  /**
   * If there are more results than have been returned, then this field is set
   * to a non-empty value. To see the additional results, use that value as
   * pageToken in the next call to this method.
   */
  core.String nextPageToken;
  /**
   * The monitored resource descriptors that are available to this project and
   * that match filter, if present.
   */
  core.List<MonitoredResourceDescriptor> resourceDescriptors;

  ListMonitoredResourceDescriptorsResponse();

  ListMonitoredResourceDescriptorsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resourceDescriptors")) {
      resourceDescriptors = _json["resourceDescriptors"].map((value) => new MonitoredResourceDescriptor.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resourceDescriptors != null) {
      _json["resourceDescriptors"] = resourceDescriptors.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The ListTimeSeries response. */
class ListTimeSeriesResponse {
  /**
   * If there are more results than have been returned, then this field is set
   * to a non-empty value. To see the additional results, use that value as
   * pageToken in the next call to this method.
   */
  core.String nextPageToken;
  /** One or more time series that match the filter included in the request. */
  core.List<TimeSeries> timeSeries;

  ListTimeSeriesResponse();

  ListTimeSeriesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("timeSeries")) {
      timeSeries = _json["timeSeries"].map((value) => new TimeSeries.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (timeSeries != null) {
      _json["timeSeries"] = timeSeries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * A specific metric, identified by specifying values for all of the labels of a
 * MetricDescriptor.
 */
class Metric {
  /**
   * The set of label values that uniquely identify this metric. All labels
   * listed in the MetricDescriptor must be assigned values.
   */
  core.Map<core.String, core.String> labels;
  /**
   * An existing metric type, see google.api.MetricDescriptor. For example,
   * custom.googleapis.com/invoice/paid/amount.
   */
  core.String type;

  Metric();

  Metric.fromJson(core.Map _json) {
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * Defines a metric type and its schema. Once a metric descriptor is created,
 * deleting or altering it stops data collection and makes the metric type's
 * existing data unusable.
 */
class MetricDescriptor {
  /**
   * A detailed description of the metric, which can be used in documentation.
   */
  core.String description;
  /**
   * A concise name for the metric, which can be displayed in user interfaces.
   * Use sentence case without an ending period, for example "Request count".
   */
  core.String displayName;
  /**
   * The set of labels that can be used to describe a specific instance of this
   * metric type. For example, the
   * appengine.googleapis.com/http/server/response_latencies metric type has a
   * label for the HTTP response code, response_code, so you can look at
   * latencies for successful responses or just for responses that failed.
   */
  core.List<LabelDescriptor> labels;
  /**
   * Whether the metric records instantaneous values, changes to a value, etc.
   * Some combinations of metric_kind and value_type might not be supported.
   * Possible string values are:
   * - "METRIC_KIND_UNSPECIFIED" : Do not use this default value.
   * - "GAUGE" : An instantaneous measurement of a value.
   * - "DELTA" : The change in a value during a time interval.
   * - "CUMULATIVE" : A value accumulated over a time interval. Cumulative
   * measurements in a time series should have the same start time and
   * increasing end times, until an event resets the cumulative value to zero
   * and sets a new start time for the following points.
   */
  core.String metricKind;
  /**
   * The resource name of the metric descriptor. Depending on the
   * implementation, the name typically includes: (1) the parent resource name
   * that defines the scope of the metric type or of its data; and (2) the
   * metric's URL-encoded type, which also appears in the type field of this
   * descriptor. For example, following is the resource name of a custom metric
   * within the GCP project my-project-id:
   * "projects/my-project-id/metricDescriptors/custom.googleapis.com%2Finvoice%2Fpaid%2Famount"
   */
  core.String name;
  /**
   * The metric type, including its DNS name prefix. The type is not
   * URL-encoded. All user-defined custom metric types have the DNS name
   * custom.googleapis.com. Metric types should use a natural hierarchical
   * grouping. For example:
   * "custom.googleapis.com/invoice/paid/amount"
   * "appengine.googleapis.com/http/server/response_latencies"
   */
  core.String type;
  /**
   * The unit in which the metric value is reported. It is only applicable if
   * the value_type is INT64, DOUBLE, or DISTRIBUTION. The supported units are a
   * subset of The Unified Code for Units of Measure
   * (http://unitsofmeasure.org/ucum.html) standard:Basic units (UNIT)
   * bit bit
   * By byte
   * s second
   * min minute
   * h hour
   * d dayPrefixes (PREFIX)
   * k kilo (10**3)
   * M mega (10**6)
   * G giga (10**9)
   * T tera (10**12)
   * P peta (10**15)
   * E exa (10**18)
   * Z zetta (10**21)
   * Y yotta (10**24)
   * m milli (10**-3)
   * u micro (10**-6)
   * n nano (10**-9)
   * p pico (10**-12)
   * f femto (10**-15)
   * a atto (10**-18)
   * z zepto (10**-21)
   * y yocto (10**-24)
   * Ki kibi (2**10)
   * Mi mebi (2**20)
   * Gi gibi (2**30)
   * Ti tebi (2**40)GrammarThe grammar includes the dimensionless unit 1, such
   * as 1/s.The grammar also includes these connectors:
   * / division (as an infix operator, e.g. 1/s).
   * . multiplication (as an infix operator, e.g. GBy.d)The grammar for a unit
   * is as follows:
   * Expression = Component { "." Component } { "/" Component } ;
   *
   * Component = [ PREFIX ] UNIT [ Annotation ]
   *           | Annotation
   *           | "1"
   *           ;
   *
   * Annotation = "{" NAME "}" ;
   * Notes:
   * Annotation is just a comment if it follows a UNIT and is  equivalent to 1
   * if it is used alone. For examples,  {requests}/s == 1/s, By{transmitted}/s
   * == By/s.
   * NAME is a sequence of non-blank printable ASCII characters not  containing
   * '{' or '}'.
   */
  core.String unit;
  /**
   * Whether the measurement is an integer, a floating-point number, etc. Some
   * combinations of metric_kind and value_type might not be supported.
   * Possible string values are:
   * - "VALUE_TYPE_UNSPECIFIED" : Do not use this default value.
   * - "BOOL" : The value is a boolean. This value type can be used only if the
   * metric kind is GAUGE.
   * - "INT64" : The value is a signed 64-bit integer.
   * - "DOUBLE" : The value is a double precision floating point number.
   * - "STRING" : The value is a text string. This value type can be used only
   * if the metric kind is GAUGE.
   * - "DISTRIBUTION" : The value is a Distribution.
   * - "MONEY" : The value is money.
   */
  core.String valueType;

  MetricDescriptor();

  MetricDescriptor.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"].map((value) => new LabelDescriptor.fromJson(value)).toList();
    }
    if (_json.containsKey("metricKind")) {
      metricKind = _json["metricKind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("valueType")) {
      valueType = _json["valueType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (labels != null) {
      _json["labels"] = labels.map((value) => (value).toJson()).toList();
    }
    if (metricKind != null) {
      _json["metricKind"] = metricKind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (valueType != null) {
      _json["valueType"] = valueType;
    }
    return _json;
  }
}

/**
 * An object representing a resource that can be used for monitoring, logging,
 * billing, or other purposes. Examples include virtual machine instances,
 * databases, and storage devices such as disks. The type field identifies a
 * MonitoredResourceDescriptor object that describes the resource's schema.
 * Information in the labels field identifies the actual resource and its
 * attributes according to the schema. For example, a particular Compute Engine
 * VM instance could be represented by the following object, because the
 * MonitoredResourceDescriptor for "gce_instance" has labels "instance_id" and
 * "zone":
 * { "type": "gce_instance",
 *   "labels": { "instance_id": "12345678901234",
 *               "zone": "us-central1-a" }}
 */
class MonitoredResource {
  /**
   * Required. Values for all of the labels listed in the associated monitored
   * resource descriptor. For example, Cloud SQL databases use the labels
   * "database_id" and "zone".
   */
  core.Map<core.String, core.String> labels;
  /**
   * Required. The monitored resource type. This field must match the type field
   * of a MonitoredResourceDescriptor object. For example, the type of a Cloud
   * SQL database is "cloudsql_database".
   */
  core.String type;

  MonitoredResource();

  MonitoredResource.fromJson(core.Map _json) {
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * An object that describes the schema of a MonitoredResource object using a
 * type name and a set of labels. For example, the monitored resource descriptor
 * for Google Compute Engine VM instances has a type of "gce_instance" and
 * specifies the use of the labels "instance_id" and "zone" to identify
 * particular VM instances.Different APIs can support different monitored
 * resource types. APIs generally provide a list method that returns the
 * monitored resource descriptors used by the API.
 */
class MonitoredResourceDescriptor {
  /**
   * Optional. A detailed description of the monitored resource type that might
   * be used in documentation.
   */
  core.String description;
  /**
   * Optional. A concise name for the monitored resource type that might be
   * displayed in user interfaces. It should be a Title Cased Noun Phrase,
   * without any article or other determiners. For example, "Google Cloud SQL
   * Database".
   */
  core.String displayName;
  /**
   * Required. A set of labels used to describe instances of this monitored
   * resource type. For example, an individual Google Cloud SQL database is
   * identified by values for the labels "database_id" and "zone".
   */
  core.List<LabelDescriptor> labels;
  /**
   * Optional. The resource name of the monitored resource descriptor:
   * "projects/{project_id}/monitoredResourceDescriptors/{type}" where {type} is
   * the value of the type field in this object and {project_id} is a project ID
   * that provides API-specific context for accessing the type. APIs that do not
   * use project information can use the resource name format
   * "monitoredResourceDescriptors/{type}".
   */
  core.String name;
  /**
   * Required. The monitored resource type. For example, the type
   * "cloudsql_database" represents databases in Google Cloud SQL. The maximum
   * length of this value is 256 characters.
   */
  core.String type;

  MonitoredResourceDescriptor();

  MonitoredResourceDescriptor.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"].map((value) => new LabelDescriptor.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (labels != null) {
      _json["labels"] = labels.map((value) => (value).toJson()).toList();
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

/**
 * A protocol buffer option, which can be attached to a message, field,
 * enumeration, etc.
 */
class Option {
  /**
   * The option's name. For protobuf built-in options (options defined in
   * descriptor.proto), this is the short name. For example, "map_entry". For
   * custom options, it should be the fully-qualified name. For example,
   * "google.api.http".
   */
  core.String name;
  /**
   * The option's value packed in an Any message. If the value is a primitive,
   * the corresponding wrapper type defined in google/protobuf/wrappers.proto
   * should be used. If the value is an enum, it should be stored as an int32
   * value using the google.protobuf.Int32Value type.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> value;

  Option();

  Option.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** A single data point in a time series. */
class Point {
  /**
   * The time interval to which the data point applies. For GAUGE metrics, only
   * the end time of the interval is used. For DELTA metrics, the start and end
   * time should specify a non-zero interval, with subsequent points specifying
   * contiguous and non-overlapping intervals. For CUMULATIVE metrics, the start
   * and end time should specify a non-zero interval, with subsequent points
   * specifying the same start time and increasing end times, until an event
   * resets the cumulative value to zero and sets a new start time for the
   * following points.
   */
  TimeInterval interval;
  /** The value of the data point. */
  TypedValue value;

  Point();

  Point.fromJson(core.Map _json) {
    if (_json.containsKey("interval")) {
      interval = new TimeInterval.fromJson(_json["interval"]);
    }
    if (_json.containsKey("value")) {
      value = new TypedValue.fromJson(_json["value"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (interval != null) {
      _json["interval"] = (interval).toJson();
    }
    if (value != null) {
      _json["value"] = (value).toJson();
    }
    return _json;
  }
}

/** The range of the population values. */
class Range {
  /** The maximum of the population values. */
  core.double max;
  /** The minimum of the population values. */
  core.double min;

  Range();

  Range.fromJson(core.Map _json) {
    if (_json.containsKey("max")) {
      max = _json["max"];
    }
    if (_json.containsKey("min")) {
      min = _json["min"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (max != null) {
      _json["max"] = max;
    }
    if (min != null) {
      _json["min"] = min;
    }
    return _json;
  }
}

/**
 * SourceContext represents information about the source of a protobuf element,
 * like the file in which it is defined.
 */
class SourceContext {
  /**
   * The path-qualified name of the .proto file that contained the associated
   * protobuf element. For example: "google/protobuf/source_context.proto".
   */
  core.String fileName;

  SourceContext();

  SourceContext.fromJson(core.Map _json) {
    if (_json.containsKey("fileName")) {
      fileName = _json["fileName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fileName != null) {
      _json["fileName"] = fileName;
    }
    return _json;
  }
}

/**
 * A time interval extending just after a start time through an end time. If the
 * start time is the same as the end time, then the interval represents a single
 * point in time.
 */
class TimeInterval {
  /** Required. The end of the time interval. */
  core.String endTime;
  /**
   * Optional. The beginning of the time interval. The default value for the
   * start time is the end time. The start time must not be later than the end
   * time.
   */
  core.String startTime;

  TimeInterval();

  TimeInterval.fromJson(core.Map _json) {
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

/**
 * A collection of data points that describes the time-varying values of a
 * metric. A time series is identified by a combination of a fully-specified
 * monitored resource and a fully-specified metric. This type is used for both
 * listing and creating time series.
 */
class TimeSeries {
  /**
   * The associated metric. A fully-specified metric used to identify the time
   * series.
   */
  Metric metric;
  /**
   * The metric kind of the time series. When listing time series, this metric
   * kind might be different from the metric kind of the associated metric if
   * this time series is an alignment or reduction of other time series.When
   * creating a time series, this field is optional. If present, it must be the
   * same as the metric kind of the associated metric. If the associated
   * metric's descriptor must be auto-created, then this field specifies the
   * metric kind of the new descriptor and must be either GAUGE (the default) or
   * CUMULATIVE.
   * Possible string values are:
   * - "METRIC_KIND_UNSPECIFIED" : Do not use this default value.
   * - "GAUGE" : An instantaneous measurement of a value.
   * - "DELTA" : The change in a value during a time interval.
   * - "CUMULATIVE" : A value accumulated over a time interval. Cumulative
   * measurements in a time series should have the same start time and
   * increasing end times, until an event resets the cumulative value to zero
   * and sets a new start time for the following points.
   */
  core.String metricKind;
  /**
   * The data points of this time series. When listing time series, the order of
   * the points is specified by the list method.When creating a time series,
   * this field must contain exactly one point and the point's type must be the
   * same as the value type of the associated metric. If the associated metric's
   * descriptor must be auto-created, then the value type of the descriptor is
   * determined by the point's type, which must be BOOL, INT64, DOUBLE, or
   * DISTRIBUTION.
   */
  core.List<Point> points;
  /**
   * The associated resource. A fully-specified monitored resource used to
   * identify the time series.
   */
  MonitoredResource resource;
  /**
   * The value type of the time series. When listing time series, this value
   * type might be different from the value type of the associated metric if
   * this time series is an alignment or reduction of other time series.When
   * creating a time series, this field is optional. If present, it must be the
   * same as the type of the data in the points field.
   * Possible string values are:
   * - "VALUE_TYPE_UNSPECIFIED" : Do not use this default value.
   * - "BOOL" : The value is a boolean. This value type can be used only if the
   * metric kind is GAUGE.
   * - "INT64" : The value is a signed 64-bit integer.
   * - "DOUBLE" : The value is a double precision floating point number.
   * - "STRING" : The value is a text string. This value type can be used only
   * if the metric kind is GAUGE.
   * - "DISTRIBUTION" : The value is a Distribution.
   * - "MONEY" : The value is money.
   */
  core.String valueType;

  TimeSeries();

  TimeSeries.fromJson(core.Map _json) {
    if (_json.containsKey("metric")) {
      metric = new Metric.fromJson(_json["metric"]);
    }
    if (_json.containsKey("metricKind")) {
      metricKind = _json["metricKind"];
    }
    if (_json.containsKey("points")) {
      points = _json["points"].map((value) => new Point.fromJson(value)).toList();
    }
    if (_json.containsKey("resource")) {
      resource = new MonitoredResource.fromJson(_json["resource"]);
    }
    if (_json.containsKey("valueType")) {
      valueType = _json["valueType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (metric != null) {
      _json["metric"] = (metric).toJson();
    }
    if (metricKind != null) {
      _json["metricKind"] = metricKind;
    }
    if (points != null) {
      _json["points"] = points.map((value) => (value).toJson()).toList();
    }
    if (resource != null) {
      _json["resource"] = (resource).toJson();
    }
    if (valueType != null) {
      _json["valueType"] = valueType;
    }
    return _json;
  }
}

/** A protocol buffer message type. */
class Type {
  /** The list of fields. */
  core.List<Field> fields;
  /** The fully qualified message name. */
  core.String name;
  /** The list of types appearing in oneof definitions in this type. */
  core.List<core.String> oneofs;
  /** The protocol buffer options. */
  core.List<Option> options;
  /** The source context. */
  SourceContext sourceContext;
  /**
   * The source syntax.
   * Possible string values are:
   * - "SYNTAX_PROTO2" : Syntax proto2.
   * - "SYNTAX_PROTO3" : Syntax proto3.
   */
  core.String syntax;

  Type();

  Type.fromJson(core.Map _json) {
    if (_json.containsKey("fields")) {
      fields = _json["fields"].map((value) => new Field.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("oneofs")) {
      oneofs = _json["oneofs"];
    }
    if (_json.containsKey("options")) {
      options = _json["options"].map((value) => new Option.fromJson(value)).toList();
    }
    if (_json.containsKey("sourceContext")) {
      sourceContext = new SourceContext.fromJson(_json["sourceContext"]);
    }
    if (_json.containsKey("syntax")) {
      syntax = _json["syntax"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fields != null) {
      _json["fields"] = fields.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (oneofs != null) {
      _json["oneofs"] = oneofs;
    }
    if (options != null) {
      _json["options"] = options.map((value) => (value).toJson()).toList();
    }
    if (sourceContext != null) {
      _json["sourceContext"] = (sourceContext).toJson();
    }
    if (syntax != null) {
      _json["syntax"] = syntax;
    }
    return _json;
  }
}

/** A single strongly-typed value. */
class TypedValue {
  /** A Boolean value: true or false. */
  core.bool boolValue;
  /** A distribution value. */
  Distribution distributionValue;
  /**
   * A 64-bit double-precision floating-point number. Its magnitude is
   * approximately &plusmn;10<sup>&plusmn;300</sup> and it has 16 significant
   * digits of precision.
   */
  core.double doubleValue;
  /**
   * A 64-bit integer. Its range is approximately &plusmn;9.2x10<sup>18</sup>.
   */
  core.String int64Value;
  /** A variable-length string value. */
  core.String stringValue;

  TypedValue();

  TypedValue.fromJson(core.Map _json) {
    if (_json.containsKey("boolValue")) {
      boolValue = _json["boolValue"];
    }
    if (_json.containsKey("distributionValue")) {
      distributionValue = new Distribution.fromJson(_json["distributionValue"]);
    }
    if (_json.containsKey("doubleValue")) {
      doubleValue = _json["doubleValue"];
    }
    if (_json.containsKey("int64Value")) {
      int64Value = _json["int64Value"];
    }
    if (_json.containsKey("stringValue")) {
      stringValue = _json["stringValue"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (boolValue != null) {
      _json["boolValue"] = boolValue;
    }
    if (distributionValue != null) {
      _json["distributionValue"] = (distributionValue).toJson();
    }
    if (doubleValue != null) {
      _json["doubleValue"] = doubleValue;
    }
    if (int64Value != null) {
      _json["int64Value"] = int64Value;
    }
    if (stringValue != null) {
      _json["stringValue"] = stringValue;
    }
    return _json;
  }
}
