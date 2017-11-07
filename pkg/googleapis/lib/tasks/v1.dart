// This is a generated file (see the discoveryapis_generator project).

library googleapis.tasks.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client tasks/v1';

/** Lets you manage your tasks and task lists. */
class TasksApi {
  /** Manage your tasks */
  static const TasksScope = "https://www.googleapis.com/auth/tasks";

  /** View your tasks */
  static const TasksReadonlyScope = "https://www.googleapis.com/auth/tasks.readonly";


  final commons.ApiRequester _requester;

  TasklistsResourceApi get tasklists => new TasklistsResourceApi(_requester);
  TasksResourceApi get tasks => new TasksResourceApi(_requester);

  TasksApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "tasks/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class TasklistsResourceApi {
  final commons.ApiRequester _requester;

  TasklistsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes the authenticated user's specified task list.
   *
   * Request parameters:
   *
   * [tasklist] - Task list identifier.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String tasklist) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (tasklist == null) {
      throw new core.ArgumentError("Parameter tasklist is required.");
    }

    _downloadOptions = null;

    _url = 'users/@me/lists/' + commons.Escaper.ecapeVariable('$tasklist');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Returns the authenticated user's specified task list.
   *
   * Request parameters:
   *
   * [tasklist] - Task list identifier.
   *
   * Completes with a [TaskList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TaskList> get(core.String tasklist) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (tasklist == null) {
      throw new core.ArgumentError("Parameter tasklist is required.");
    }

    _url = 'users/@me/lists/' + commons.Escaper.ecapeVariable('$tasklist');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TaskList.fromJson(data));
  }

  /**
   * Creates a new task list and adds it to the authenticated user's task lists.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [TaskList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TaskList> insert(TaskList request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'users/@me/lists';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TaskList.fromJson(data));
  }

  /**
   * Returns all the authenticated user's task lists.
   *
   * Request parameters:
   *
   * [maxResults] - Maximum number of task lists returned on one page. Optional.
   * The default is 100.
   *
   * [pageToken] - Token specifying the result page to return. Optional.
   *
   * Completes with a [TaskLists].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TaskLists> list({core.String maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (maxResults != null) {
      _queryParams["maxResults"] = [maxResults];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'users/@me/lists';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TaskLists.fromJson(data));
  }

  /**
   * Updates the authenticated user's specified task list. This method supports
   * patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [tasklist] - Task list identifier.
   *
   * Completes with a [TaskList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TaskList> patch(TaskList request, core.String tasklist) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (tasklist == null) {
      throw new core.ArgumentError("Parameter tasklist is required.");
    }

    _url = 'users/@me/lists/' + commons.Escaper.ecapeVariable('$tasklist');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TaskList.fromJson(data));
  }

  /**
   * Updates the authenticated user's specified task list.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [tasklist] - Task list identifier.
   *
   * Completes with a [TaskList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TaskList> update(TaskList request, core.String tasklist) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (tasklist == null) {
      throw new core.ArgumentError("Parameter tasklist is required.");
    }

    _url = 'users/@me/lists/' + commons.Escaper.ecapeVariable('$tasklist');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TaskList.fromJson(data));
  }

}


class TasksResourceApi {
  final commons.ApiRequester _requester;

  TasksResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Clears all completed tasks from the specified task list. The affected tasks
   * will be marked as 'hidden' and no longer be returned by default when
   * retrieving all tasks for a task list.
   *
   * Request parameters:
   *
   * [tasklist] - Task list identifier.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future clear(core.String tasklist) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (tasklist == null) {
      throw new core.ArgumentError("Parameter tasklist is required.");
    }

    _downloadOptions = null;

    _url = 'lists/' + commons.Escaper.ecapeVariable('$tasklist') + '/clear';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Deletes the specified task from the task list.
   *
   * Request parameters:
   *
   * [tasklist] - Task list identifier.
   *
   * [task] - Task identifier.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String tasklist, core.String task) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (tasklist == null) {
      throw new core.ArgumentError("Parameter tasklist is required.");
    }
    if (task == null) {
      throw new core.ArgumentError("Parameter task is required.");
    }

    _downloadOptions = null;

    _url = 'lists/' + commons.Escaper.ecapeVariable('$tasklist') + '/tasks/' + commons.Escaper.ecapeVariable('$task');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Returns the specified task.
   *
   * Request parameters:
   *
   * [tasklist] - Task list identifier.
   *
   * [task] - Task identifier.
   *
   * Completes with a [Task].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Task> get(core.String tasklist, core.String task) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (tasklist == null) {
      throw new core.ArgumentError("Parameter tasklist is required.");
    }
    if (task == null) {
      throw new core.ArgumentError("Parameter task is required.");
    }

    _url = 'lists/' + commons.Escaper.ecapeVariable('$tasklist') + '/tasks/' + commons.Escaper.ecapeVariable('$task');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Task.fromJson(data));
  }

  /**
   * Creates a new task on the specified task list.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [tasklist] - Task list identifier.
   *
   * [parent] - Parent task identifier. If the task is created at the top level,
   * this parameter is omitted. Optional.
   *
   * [previous] - Previous sibling task identifier. If the task is created at
   * the first position among its siblings, this parameter is omitted. Optional.
   *
   * Completes with a [Task].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Task> insert(Task request, core.String tasklist, {core.String parent, core.String previous}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (tasklist == null) {
      throw new core.ArgumentError("Parameter tasklist is required.");
    }
    if (parent != null) {
      _queryParams["parent"] = [parent];
    }
    if (previous != null) {
      _queryParams["previous"] = [previous];
    }

    _url = 'lists/' + commons.Escaper.ecapeVariable('$tasklist') + '/tasks';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Task.fromJson(data));
  }

  /**
   * Returns all tasks in the specified task list.
   *
   * Request parameters:
   *
   * [tasklist] - Task list identifier.
   *
   * [completedMax] - Upper bound for a task's completion date (as a RFC 3339
   * timestamp) to filter by. Optional. The default is not to filter by
   * completion date.
   *
   * [completedMin] - Lower bound for a task's completion date (as a RFC 3339
   * timestamp) to filter by. Optional. The default is not to filter by
   * completion date.
   *
   * [dueMax] - Upper bound for a task's due date (as a RFC 3339 timestamp) to
   * filter by. Optional. The default is not to filter by due date.
   *
   * [dueMin] - Lower bound for a task's due date (as a RFC 3339 timestamp) to
   * filter by. Optional. The default is not to filter by due date.
   *
   * [maxResults] - Maximum number of task lists returned on one page. Optional.
   * The default is 100.
   *
   * [pageToken] - Token specifying the result page to return. Optional.
   *
   * [showCompleted] - Flag indicating whether completed tasks are returned in
   * the result. Optional. The default is True.
   *
   * [showDeleted] - Flag indicating whether deleted tasks are returned in the
   * result. Optional. The default is False.
   *
   * [showHidden] - Flag indicating whether hidden tasks are returned in the
   * result. Optional. The default is False.
   *
   * [updatedMin] - Lower bound for a task's last modification time (as a RFC
   * 3339 timestamp) to filter by. Optional. The default is not to filter by
   * last modification time.
   *
   * Completes with a [Tasks].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Tasks> list(core.String tasklist, {core.String completedMax, core.String completedMin, core.String dueMax, core.String dueMin, core.String maxResults, core.String pageToken, core.bool showCompleted, core.bool showDeleted, core.bool showHidden, core.String updatedMin}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (tasklist == null) {
      throw new core.ArgumentError("Parameter tasklist is required.");
    }
    if (completedMax != null) {
      _queryParams["completedMax"] = [completedMax];
    }
    if (completedMin != null) {
      _queryParams["completedMin"] = [completedMin];
    }
    if (dueMax != null) {
      _queryParams["dueMax"] = [dueMax];
    }
    if (dueMin != null) {
      _queryParams["dueMin"] = [dueMin];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = [maxResults];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (showCompleted != null) {
      _queryParams["showCompleted"] = ["${showCompleted}"];
    }
    if (showDeleted != null) {
      _queryParams["showDeleted"] = ["${showDeleted}"];
    }
    if (showHidden != null) {
      _queryParams["showHidden"] = ["${showHidden}"];
    }
    if (updatedMin != null) {
      _queryParams["updatedMin"] = [updatedMin];
    }

    _url = 'lists/' + commons.Escaper.ecapeVariable('$tasklist') + '/tasks';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Tasks.fromJson(data));
  }

  /**
   * Moves the specified task to another position in the task list. This can
   * include putting it as a child task under a new parent and/or move it to a
   * different position among its sibling tasks.
   *
   * Request parameters:
   *
   * [tasklist] - Task list identifier.
   *
   * [task] - Task identifier.
   *
   * [parent] - New parent task identifier. If the task is moved to the top
   * level, this parameter is omitted. Optional.
   *
   * [previous] - New previous sibling task identifier. If the task is moved to
   * the first position among its siblings, this parameter is omitted. Optional.
   *
   * Completes with a [Task].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Task> move(core.String tasklist, core.String task, {core.String parent, core.String previous}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (tasklist == null) {
      throw new core.ArgumentError("Parameter tasklist is required.");
    }
    if (task == null) {
      throw new core.ArgumentError("Parameter task is required.");
    }
    if (parent != null) {
      _queryParams["parent"] = [parent];
    }
    if (previous != null) {
      _queryParams["previous"] = [previous];
    }

    _url = 'lists/' + commons.Escaper.ecapeVariable('$tasklist') + '/tasks/' + commons.Escaper.ecapeVariable('$task') + '/move';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Task.fromJson(data));
  }

  /**
   * Updates the specified task. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [tasklist] - Task list identifier.
   *
   * [task] - Task identifier.
   *
   * Completes with a [Task].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Task> patch(Task request, core.String tasklist, core.String task) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (tasklist == null) {
      throw new core.ArgumentError("Parameter tasklist is required.");
    }
    if (task == null) {
      throw new core.ArgumentError("Parameter task is required.");
    }

    _url = 'lists/' + commons.Escaper.ecapeVariable('$tasklist') + '/tasks/' + commons.Escaper.ecapeVariable('$task');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Task.fromJson(data));
  }

  /**
   * Updates the specified task.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [tasklist] - Task list identifier.
   *
   * [task] - Task identifier.
   *
   * Completes with a [Task].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Task> update(Task request, core.String tasklist, core.String task) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (tasklist == null) {
      throw new core.ArgumentError("Parameter tasklist is required.");
    }
    if (task == null) {
      throw new core.ArgumentError("Parameter task is required.");
    }

    _url = 'lists/' + commons.Escaper.ecapeVariable('$tasklist') + '/tasks/' + commons.Escaper.ecapeVariable('$task');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Task.fromJson(data));
  }

}



class TaskLinks {
  /** The description. In HTML speak: Everything between <a> and </a>. */
  core.String description;
  /** The URL. */
  core.String link;
  /** Type of the link, e.g. "email". */
  core.String type;

  TaskLinks();

  TaskLinks.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("link")) {
      link = _json["link"];
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
    if (link != null) {
      _json["link"] = link;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class Task {
  /**
   * Completion date of the task (as a RFC 3339 timestamp). This field is
   * omitted if the task has not been completed.
   */
  core.DateTime completed;
  /**
   * Flag indicating whether the task has been deleted. The default if False.
   */
  core.bool deleted;
  /** Due date of the task (as a RFC 3339 timestamp). Optional. */
  core.DateTime due;
  /** ETag of the resource. */
  core.String etag;
  /**
   * Flag indicating whether the task is hidden. This is the case if the task
   * had been marked completed when the task list was last cleared. The default
   * is False. This field is read-only.
   */
  core.bool hidden;
  /** Task identifier. */
  core.String id;
  /** Type of the resource. This is always "tasks#task". */
  core.String kind;
  /** Collection of links. This collection is read-only. */
  core.List<TaskLinks> links;
  /** Notes describing the task. Optional. */
  core.String notes;
  /**
   * Parent task identifier. This field is omitted if it is a top-level task.
   * This field is read-only. Use the "move" method to move the task under a
   * different parent or to the top level.
   */
  core.String parent;
  /**
   * String indicating the position of the task among its sibling tasks under
   * the same parent task or at the top level. If this string is greater than
   * another task's corresponding position string according to lexicographical
   * ordering, the task is positioned after the other task under the same parent
   * task (or at the top level). This field is read-only. Use the "move" method
   * to move the task to another position.
   */
  core.String position;
  /**
   * URL pointing to this task. Used to retrieve, update, or delete this task.
   */
  core.String selfLink;
  /** Status of the task. This is either "needsAction" or "completed". */
  core.String status;
  /** Title of the task. */
  core.String title;
  /** Last modification time of the task (as a RFC 3339 timestamp). */
  core.DateTime updated;

  Task();

  Task.fromJson(core.Map _json) {
    if (_json.containsKey("completed")) {
      completed = core.DateTime.parse(_json["completed"]);
    }
    if (_json.containsKey("deleted")) {
      deleted = _json["deleted"];
    }
    if (_json.containsKey("due")) {
      due = core.DateTime.parse(_json["due"]);
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("hidden")) {
      hidden = _json["hidden"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("links")) {
      links = _json["links"].map((value) => new TaskLinks.fromJson(value)).toList();
    }
    if (_json.containsKey("notes")) {
      notes = _json["notes"];
    }
    if (_json.containsKey("parent")) {
      parent = _json["parent"];
    }
    if (_json.containsKey("position")) {
      position = _json["position"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (completed != null) {
      _json["completed"] = (completed).toIso8601String();
    }
    if (deleted != null) {
      _json["deleted"] = deleted;
    }
    if (due != null) {
      _json["due"] = (due).toIso8601String();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (hidden != null) {
      _json["hidden"] = hidden;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (links != null) {
      _json["links"] = links.map((value) => (value).toJson()).toList();
    }
    if (notes != null) {
      _json["notes"] = notes;
    }
    if (parent != null) {
      _json["parent"] = parent;
    }
    if (position != null) {
      _json["position"] = position;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

class TaskList {
  /** ETag of the resource. */
  core.String etag;
  /** Task list identifier. */
  core.String id;
  /** Type of the resource. This is always "tasks#taskList". */
  core.String kind;
  /**
   * URL pointing to this task list. Used to retrieve, update, or delete this
   * task list.
   */
  core.String selfLink;
  /** Title of the task list. */
  core.String title;
  /** Last modification time of the task list (as a RFC 3339 timestamp). */
  core.DateTime updated;

  TaskList();

  TaskList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

class TaskLists {
  /** ETag of the resource. */
  core.String etag;
  /** Collection of task lists. */
  core.List<TaskList> items;
  /** Type of the resource. This is always "tasks#taskLists". */
  core.String kind;
  /** Token that can be used to request the next page of this result. */
  core.String nextPageToken;

  TaskLists();

  TaskLists.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new TaskList.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
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
    return _json;
  }
}

class Tasks {
  /** ETag of the resource. */
  core.String etag;
  /** Collection of tasks. */
  core.List<Task> items;
  /** Type of the resource. This is always "tasks#tasks". */
  core.String kind;
  /** Token used to access the next page of this result. */
  core.String nextPageToken;

  Tasks();

  Tasks.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Task.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
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
    return _json;
  }
}
