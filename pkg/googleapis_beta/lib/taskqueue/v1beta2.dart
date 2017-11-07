// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.taskqueue.v1beta2;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client taskqueue/v1beta2';

/// Accesses a Google App Engine Pull Task Queue over REST.
class TaskqueueApi {
  /// Manage your Tasks and Taskqueues
  static const TaskqueueScope = "https://www.googleapis.com/auth/taskqueue";

  /// Consume Tasks from your Taskqueues
  static const TaskqueueConsumerScope =
      "https://www.googleapis.com/auth/taskqueue.consumer";

  final commons.ApiRequester _requester;

  TaskqueuesResourceApi get taskqueues => new TaskqueuesResourceApi(_requester);
  TasksResourceApi get tasks => new TasksResourceApi(_requester);

  TaskqueueApi(http.Client client,
      {core.String rootUrl: "https://www.googleapis.com/",
      core.String servicePath: "taskqueue/v1beta2/projects/"})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class TaskqueuesResourceApi {
  final commons.ApiRequester _requester;

  TaskqueuesResourceApi(commons.ApiRequester client) : _requester = client;

  /// Get detailed information about a TaskQueue.
  ///
  /// Request parameters:
  ///
  /// [project] - The project under which the queue lies.
  ///
  /// [taskqueue] - The id of the taskqueue to get the properties of.
  ///
  /// [getStats] - Whether to get stats. Optional.
  ///
  /// Completes with a [TaskQueue].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<TaskQueue> get(core.String project, core.String taskqueue,
      {core.bool getStats}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (taskqueue == null) {
      throw new core.ArgumentError("Parameter taskqueue is required.");
    }
    if (getStats != null) {
      _queryParams["getStats"] = ["${getStats}"];
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/taskqueues/' +
        commons.Escaper.ecapeVariable('$taskqueue');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new TaskQueue.fromJson(data));
  }
}

class TasksResourceApi {
  final commons.ApiRequester _requester;

  TasksResourceApi(commons.ApiRequester client) : _requester = client;

  /// Delete a task from a TaskQueue.
  ///
  /// Request parameters:
  ///
  /// [project] - The project under which the queue lies.
  ///
  /// [taskqueue] - The taskqueue to delete a task from.
  ///
  /// [task] - The id of the task to delete.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future delete(
      core.String project, core.String taskqueue, core.String task) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (taskqueue == null) {
      throw new core.ArgumentError("Parameter taskqueue is required.");
    }
    if (task == null) {
      throw new core.ArgumentError("Parameter task is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$project') +
        '/taskqueues/' +
        commons.Escaper.ecapeVariable('$taskqueue') +
        '/tasks/' +
        commons.Escaper.ecapeVariable('$task');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// Get a particular task from a TaskQueue.
  ///
  /// Request parameters:
  ///
  /// [project] - The project under which the queue lies.
  ///
  /// [taskqueue] - The taskqueue in which the task belongs.
  ///
  /// [task] - The task to get properties of.
  ///
  /// Completes with a [Task].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Task> get(
      core.String project, core.String taskqueue, core.String task) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (taskqueue == null) {
      throw new core.ArgumentError("Parameter taskqueue is required.");
    }
    if (task == null) {
      throw new core.ArgumentError("Parameter task is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/taskqueues/' +
        commons.Escaper.ecapeVariable('$taskqueue') +
        '/tasks/' +
        commons.Escaper.ecapeVariable('$task');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Task.fromJson(data));
  }

  /// Insert a new task in a TaskQueue
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The project under which the queue lies
  ///
  /// [taskqueue] - The taskqueue to insert the task into
  ///
  /// Completes with a [Task].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Task> insert(
      Task request, core.String project, core.String taskqueue) {
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
    if (taskqueue == null) {
      throw new core.ArgumentError("Parameter taskqueue is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/taskqueues/' +
        commons.Escaper.ecapeVariable('$taskqueue') +
        '/tasks';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Task.fromJson(data));
  }

  /// Lease 1 or more tasks from a TaskQueue.
  ///
  /// Request parameters:
  ///
  /// [project] - The project under which the queue lies.
  ///
  /// [taskqueue] - The taskqueue to lease a task from.
  ///
  /// [numTasks] - The number of tasks to lease.
  ///
  /// [leaseSecs] - The lease in seconds.
  ///
  /// [groupByTag] - When true, all returned tasks will have the same tag
  ///
  /// [tag] - The tag allowed for tasks in the response. Must only be specified
  /// if group_by_tag is true. If group_by_tag is true and tag is not specified
  /// the tag will be that of the oldest task by eta, i.e. the first available
  /// tag
  ///
  /// Completes with a [Tasks].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Tasks> lease(core.String project, core.String taskqueue,
      core.int numTasks, core.int leaseSecs,
      {core.bool groupByTag, core.String tag}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (taskqueue == null) {
      throw new core.ArgumentError("Parameter taskqueue is required.");
    }
    if (numTasks == null) {
      throw new core.ArgumentError("Parameter numTasks is required.");
    }
    _queryParams["numTasks"] = ["${numTasks}"];
    if (leaseSecs == null) {
      throw new core.ArgumentError("Parameter leaseSecs is required.");
    }
    _queryParams["leaseSecs"] = ["${leaseSecs}"];
    if (groupByTag != null) {
      _queryParams["groupByTag"] = ["${groupByTag}"];
    }
    if (tag != null) {
      _queryParams["tag"] = [tag];
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/taskqueues/' +
        commons.Escaper.ecapeVariable('$taskqueue') +
        '/tasks/lease';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Tasks.fromJson(data));
  }

  /// List Tasks in a TaskQueue
  ///
  /// Request parameters:
  ///
  /// [project] - The project under which the queue lies.
  ///
  /// [taskqueue] - The id of the taskqueue to list tasks from.
  ///
  /// Completes with a [Tasks2].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Tasks2> list(core.String project, core.String taskqueue) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (taskqueue == null) {
      throw new core.ArgumentError("Parameter taskqueue is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') +
        '/taskqueues/' +
        commons.Escaper.ecapeVariable('$taskqueue') +
        '/tasks';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Tasks2.fromJson(data));
  }

  /// Update tasks that are leased out of a TaskQueue. This method supports
  /// patch semantics.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The project under which the queue lies.
  ///
  /// [taskqueue] - null
  ///
  /// [task] - null
  ///
  /// [newLeaseSeconds] - The new lease in seconds.
  ///
  /// Completes with a [Task].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Task> patch(Task request, core.String project,
      core.String taskqueue, core.String task, core.int newLeaseSeconds) {
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
    if (taskqueue == null) {
      throw new core.ArgumentError("Parameter taskqueue is required.");
    }
    if (task == null) {
      throw new core.ArgumentError("Parameter task is required.");
    }
    if (newLeaseSeconds == null) {
      throw new core.ArgumentError("Parameter newLeaseSeconds is required.");
    }
    _queryParams["newLeaseSeconds"] = ["${newLeaseSeconds}"];

    _url = commons.Escaper.ecapeVariable('$project') +
        '/taskqueues/' +
        commons.Escaper.ecapeVariable('$taskqueue') +
        '/tasks/' +
        commons.Escaper.ecapeVariable('$task');

    var _response = _requester.request(_url, "PATCH",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Task.fromJson(data));
  }

  /// Update tasks that are leased out of a TaskQueue.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [project] - The project under which the queue lies.
  ///
  /// [taskqueue] - null
  ///
  /// [task] - null
  ///
  /// [newLeaseSeconds] - The new lease in seconds.
  ///
  /// Completes with a [Task].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Task> update(Task request, core.String project,
      core.String taskqueue, core.String task, core.int newLeaseSeconds) {
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
    if (taskqueue == null) {
      throw new core.ArgumentError("Parameter taskqueue is required.");
    }
    if (task == null) {
      throw new core.ArgumentError("Parameter task is required.");
    }
    if (newLeaseSeconds == null) {
      throw new core.ArgumentError("Parameter newLeaseSeconds is required.");
    }
    _queryParams["newLeaseSeconds"] = ["${newLeaseSeconds}"];

    _url = commons.Escaper.ecapeVariable('$project') +
        '/taskqueues/' +
        commons.Escaper.ecapeVariable('$taskqueue') +
        '/tasks/' +
        commons.Escaper.ecapeVariable('$task');

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Task.fromJson(data));
  }
}

class Task {
  /// Time (in seconds since the epoch) at which the task was enqueued.
  core.String enqueueTimestamp;

  /// Name of the task.
  core.String id;

  /// The kind of object returned, in this case set to task.
  core.String kind;

  /// Time (in seconds since the epoch) at which the task lease will expire.
  /// This value is 0 if the task isnt currently leased out to a worker.
  core.String leaseTimestamp;

  /// A bag of bytes which is the task payload. The payload on the JSON side is
  /// always Base64 encoded.
  core.String payloadBase64;

  /// Name of the queue that the task is in.
  core.String queueName;

  /// The number of leases applied to this task.
  core.int retryCount;

  /// Tag for the task, could be used later to lease tasks grouped by a specific
  /// tag.
  core.String tag;

  Task();

  Task.fromJson(core.Map _json) {
    if (_json.containsKey("enqueueTimestamp")) {
      enqueueTimestamp = _json["enqueueTimestamp"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("leaseTimestamp")) {
      leaseTimestamp = _json["leaseTimestamp"];
    }
    if (_json.containsKey("payloadBase64")) {
      payloadBase64 = _json["payloadBase64"];
    }
    if (_json.containsKey("queueName")) {
      queueName = _json["queueName"];
    }
    if (_json.containsKey("retry_count")) {
      retryCount = _json["retry_count"];
    }
    if (_json.containsKey("tag")) {
      tag = _json["tag"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (enqueueTimestamp != null) {
      _json["enqueueTimestamp"] = enqueueTimestamp;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (leaseTimestamp != null) {
      _json["leaseTimestamp"] = leaseTimestamp;
    }
    if (payloadBase64 != null) {
      _json["payloadBase64"] = payloadBase64;
    }
    if (queueName != null) {
      _json["queueName"] = queueName;
    }
    if (retryCount != null) {
      _json["retry_count"] = retryCount;
    }
    if (tag != null) {
      _json["tag"] = tag;
    }
    return _json;
  }
}

/// ACLs that are applicable to this TaskQueue object.
class TaskQueueAcl {
  /// Email addresses of users who are "admins" of the TaskQueue. This means
  /// they can control the queue, eg set ACLs for the queue.
  core.List<core.String> adminEmails;

  /// Email addresses of users who can "consume" tasks from the TaskQueue. This
  /// means they can Dequeue and Delete tasks from the queue.
  core.List<core.String> consumerEmails;

  /// Email addresses of users who can "produce" tasks into the TaskQueue. This
  /// means they can Insert tasks into the queue.
  core.List<core.String> producerEmails;

  TaskQueueAcl();

  TaskQueueAcl.fromJson(core.Map _json) {
    if (_json.containsKey("adminEmails")) {
      adminEmails = _json["adminEmails"];
    }
    if (_json.containsKey("consumerEmails")) {
      consumerEmails = _json["consumerEmails"];
    }
    if (_json.containsKey("producerEmails")) {
      producerEmails = _json["producerEmails"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (adminEmails != null) {
      _json["adminEmails"] = adminEmails;
    }
    if (consumerEmails != null) {
      _json["consumerEmails"] = consumerEmails;
    }
    if (producerEmails != null) {
      _json["producerEmails"] = producerEmails;
    }
    return _json;
  }
}

/// Statistics for the TaskQueue object in question.
class TaskQueueStats {
  /// Number of tasks leased in the last hour.
  core.String leasedLastHour;

  /// Number of tasks leased in the last minute.
  core.String leasedLastMinute;

  /// The timestamp (in seconds since the epoch) of the oldest unfinished task.
  core.String oldestTask;

  /// Number of tasks in the queue.
  core.int totalTasks;

  TaskQueueStats();

  TaskQueueStats.fromJson(core.Map _json) {
    if (_json.containsKey("leasedLastHour")) {
      leasedLastHour = _json["leasedLastHour"];
    }
    if (_json.containsKey("leasedLastMinute")) {
      leasedLastMinute = _json["leasedLastMinute"];
    }
    if (_json.containsKey("oldestTask")) {
      oldestTask = _json["oldestTask"];
    }
    if (_json.containsKey("totalTasks")) {
      totalTasks = _json["totalTasks"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (leasedLastHour != null) {
      _json["leasedLastHour"] = leasedLastHour;
    }
    if (leasedLastMinute != null) {
      _json["leasedLastMinute"] = leasedLastMinute;
    }
    if (oldestTask != null) {
      _json["oldestTask"] = oldestTask;
    }
    if (totalTasks != null) {
      _json["totalTasks"] = totalTasks;
    }
    return _json;
  }
}

class TaskQueue {
  /// ACLs that are applicable to this TaskQueue object.
  TaskQueueAcl acl;

  /// Name of the taskqueue.
  core.String id;

  /// The kind of REST object returned, in this case taskqueue.
  core.String kind;

  /// The number of times we should lease out tasks before giving up on them. If
  /// unset we lease them out forever until a worker deletes the task.
  core.int maxLeases;

  /// Statistics for the TaskQueue object in question.
  TaskQueueStats stats;

  TaskQueue();

  TaskQueue.fromJson(core.Map _json) {
    if (_json.containsKey("acl")) {
      acl = new TaskQueueAcl.fromJson(_json["acl"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("maxLeases")) {
      maxLeases = _json["maxLeases"];
    }
    if (_json.containsKey("stats")) {
      stats = new TaskQueueStats.fromJson(_json["stats"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (acl != null) {
      _json["acl"] = (acl).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (maxLeases != null) {
      _json["maxLeases"] = maxLeases;
    }
    if (stats != null) {
      _json["stats"] = (stats).toJson();
    }
    return _json;
  }
}

class Tasks {
  /// The actual list of tasks returned as a result of the lease operation.
  core.List<Task> items;

  /// The kind of object returned, a list of tasks.
  core.String kind;

  Tasks();

  Tasks.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Task.fromJson(value)).toList();
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

class Tasks2 {
  /// The actual list of tasks currently active in the TaskQueue.
  core.List<Task> items;

  /// The kind of object returned, a list of tasks.
  core.String kind;

  Tasks2();

  Tasks2.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Task.fromJson(value)).toList();
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
