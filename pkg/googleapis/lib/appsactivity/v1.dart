// This is a generated file (see the discoveryapis_generator project).

library googleapis.appsactivity.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client appsactivity/v1';

/** Provides a historical view of activity. */
class AppsactivityApi {
  /** View the activity history of your Google apps */
  static const ActivityScope = "https://www.googleapis.com/auth/activity";

  /** View and manage the files in your Google Drive */
  static const DriveScope = "https://www.googleapis.com/auth/drive";

  /** View and manage metadata of files in your Google Drive */
  static const DriveMetadataScope = "https://www.googleapis.com/auth/drive.metadata";

  /** View metadata for files in your Google Drive */
  static const DriveMetadataReadonlyScope = "https://www.googleapis.com/auth/drive.metadata.readonly";

  /** View the files in your Google Drive */
  static const DriveReadonlyScope = "https://www.googleapis.com/auth/drive.readonly";


  final commons.ApiRequester _requester;

  ActivitiesResourceApi get activities => new ActivitiesResourceApi(_requester);

  AppsactivityApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "appsactivity/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ActivitiesResourceApi {
  final commons.ApiRequester _requester;

  ActivitiesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a list of activities visible to the current logged in user. Visible
   * activities are determined by the visiblity settings of the object that was
   * acted on, e.g. Drive files a user can see. An activity is a record of past
   * events. Multiple events may be merged if they are similar. A request is
   * scoped to activities from a given Google service using the source
   * parameter.
   *
   * Request parameters:
   *
   * [drive_ancestorId] - Identifies the Drive folder containing the items for
   * which to return activities.
   *
   * [drive_fileId] - Identifies the Drive item to return activities for.
   *
   * [groupingStrategy] - Indicates the strategy to use when grouping
   * singleEvents items in the associated combinedEvent object.
   * Possible string values are:
   * - "driveUi"
   * - "none"
   *
   * [pageSize] - The maximum number of events to return on a page. The response
   * includes a continuation token if there are more events.
   *
   * [pageToken] - A token to retrieve a specific page of results.
   *
   * [source] - The Google service from which to return activities. Possible
   * values of source are:
   * - drive.google.com
   *
   * [userId] - Indicates the user to return activity for. Use the special value
   * me to indicate the currently authenticated user.
   *
   * Completes with a [ListActivitiesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListActivitiesResponse> list({core.String drive_ancestorId, core.String drive_fileId, core.String groupingStrategy, core.int pageSize, core.String pageToken, core.String source, core.String userId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (drive_ancestorId != null) {
      _queryParams["drive.ancestorId"] = [drive_ancestorId];
    }
    if (drive_fileId != null) {
      _queryParams["drive.fileId"] = [drive_fileId];
    }
    if (groupingStrategy != null) {
      _queryParams["groupingStrategy"] = [groupingStrategy];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (userId != null) {
      _queryParams["userId"] = [userId];
    }

    _url = 'activities';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListActivitiesResponse.fromJson(data));
  }

}



/**
 * An Activity resource is a combined view of multiple events. An activity has a
 * list of individual events and a combined view of the common fields among all
 * events.
 */
class Activity {
  /**
   * The fields common to all of the singleEvents that make up the Activity.
   */
  Event combinedEvent;
  /** A list of all the Events that make up the Activity. */
  core.List<Event> singleEvents;

  Activity();

  Activity.fromJson(core.Map _json) {
    if (_json.containsKey("combinedEvent")) {
      combinedEvent = new Event.fromJson(_json["combinedEvent"]);
    }
    if (_json.containsKey("singleEvents")) {
      singleEvents = _json["singleEvents"].map((value) => new Event.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (combinedEvent != null) {
      _json["combinedEvent"] = (combinedEvent).toJson();
    }
    if (singleEvents != null) {
      _json["singleEvents"] = singleEvents.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Represents the changes associated with an action taken by a user. */
class Event {
  /**
   * Additional event types. Some events may have multiple types when multiple
   * actions are part of a single event. For example, creating a document,
   * renaming it, and sharing it may be part of a single file-creation event.
   */
  core.List<core.String> additionalEventTypes;
  /**
   * The time at which the event occurred formatted as Unix time in
   * milliseconds.
   */
  core.String eventTimeMillis;
  /** Whether this event is caused by a user being deleted. */
  core.bool fromUserDeletion;
  /**
   * Extra information for move type events, such as changes in an object's
   * parents.
   */
  Move move;
  /**
   * Extra information for permissionChange type events, such as the user or
   * group the new permission applies to.
   */
  core.List<PermissionChange> permissionChanges;
  /**
   * The main type of event that occurred.
   * Possible string values are:
   * - "comment"
   * - "create"
   * - "edit"
   * - "emptyTrash"
   * - "move"
   * - "permissionChange"
   * - "rename"
   * - "trash"
   * - "unknown"
   * - "untrash"
   * - "upload"
   */
  core.String primaryEventType;
  /**
   * Extra information for rename type events, such as the old and new names.
   */
  Rename rename;
  /** Information specific to the Target object modified by the event. */
  Target target;
  /** Represents the user responsible for the event. */
  User user;

  Event();

  Event.fromJson(core.Map _json) {
    if (_json.containsKey("additionalEventTypes")) {
      additionalEventTypes = _json["additionalEventTypes"];
    }
    if (_json.containsKey("eventTimeMillis")) {
      eventTimeMillis = _json["eventTimeMillis"];
    }
    if (_json.containsKey("fromUserDeletion")) {
      fromUserDeletion = _json["fromUserDeletion"];
    }
    if (_json.containsKey("move")) {
      move = new Move.fromJson(_json["move"]);
    }
    if (_json.containsKey("permissionChanges")) {
      permissionChanges = _json["permissionChanges"].map((value) => new PermissionChange.fromJson(value)).toList();
    }
    if (_json.containsKey("primaryEventType")) {
      primaryEventType = _json["primaryEventType"];
    }
    if (_json.containsKey("rename")) {
      rename = new Rename.fromJson(_json["rename"]);
    }
    if (_json.containsKey("target")) {
      target = new Target.fromJson(_json["target"]);
    }
    if (_json.containsKey("user")) {
      user = new User.fromJson(_json["user"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (additionalEventTypes != null) {
      _json["additionalEventTypes"] = additionalEventTypes;
    }
    if (eventTimeMillis != null) {
      _json["eventTimeMillis"] = eventTimeMillis;
    }
    if (fromUserDeletion != null) {
      _json["fromUserDeletion"] = fromUserDeletion;
    }
    if (move != null) {
      _json["move"] = (move).toJson();
    }
    if (permissionChanges != null) {
      _json["permissionChanges"] = permissionChanges.map((value) => (value).toJson()).toList();
    }
    if (primaryEventType != null) {
      _json["primaryEventType"] = primaryEventType;
    }
    if (rename != null) {
      _json["rename"] = (rename).toJson();
    }
    if (target != null) {
      _json["target"] = (target).toJson();
    }
    if (user != null) {
      _json["user"] = (user).toJson();
    }
    return _json;
  }
}

/**
 * The response from the list request. Contains a list of activities and a token
 * to retrieve the next page of results.
 */
class ListActivitiesResponse {
  /** List of activities. */
  core.List<Activity> activities;
  /** Token for the next page of results. */
  core.String nextPageToken;

  ListActivitiesResponse();

  ListActivitiesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("activities")) {
      activities = _json["activities"].map((value) => new Activity.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (activities != null) {
      _json["activities"] = activities.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/**
 * Contains information about changes in an object's parents as a result of a
 * move type event.
 */
class Move {
  /** The added parent(s). */
  core.List<Parent> addedParents;
  /** The removed parent(s). */
  core.List<Parent> removedParents;

  Move();

  Move.fromJson(core.Map _json) {
    if (_json.containsKey("addedParents")) {
      addedParents = _json["addedParents"].map((value) => new Parent.fromJson(value)).toList();
    }
    if (_json.containsKey("removedParents")) {
      removedParents = _json["removedParents"].map((value) => new Parent.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (addedParents != null) {
      _json["addedParents"] = addedParents.map((value) => (value).toJson()).toList();
    }
    if (removedParents != null) {
      _json["removedParents"] = removedParents.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Contains information about a parent object. For example, a folder in Drive is
 * a parent for all files within it.
 */
class Parent {
  /** The parent's ID. */
  core.String id;
  /** Whether this is the root folder. */
  core.bool isRoot;
  /** The parent's title. */
  core.String title;

  Parent();

  Parent.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("isRoot")) {
      isRoot = _json["isRoot"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (isRoot != null) {
      _json["isRoot"] = isRoot;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/**
 * Contains information about the permissions and type of access allowed with
 * regards to a Google Drive object. This is a subset of the fields contained in
 * a corresponding Drive Permissions object.
 */
class Permission {
  /** The name of the user or group the permission applies to. */
  core.String name;
  /**
   * The ID for this permission. Corresponds to the Drive API's permission ID
   * returned as part of the Drive Permissions resource.
   */
  core.String permissionId;
  /**
   * Indicates the Google Drive permissions role. The role determines a user's
   * ability to read, write, or comment on the file.
   * Possible string values are:
   * - "commenter"
   * - "owner"
   * - "reader"
   * - "writer"
   */
  core.String role;
  /**
   * Indicates how widely permissions are granted.
   * Possible string values are:
   * - "anyone"
   * - "domain"
   * - "group"
   * - "user"
   */
  core.String type;
  /** The user's information if the type is USER. */
  User user;
  /** Whether the permission requires a link to the file. */
  core.bool withLink;

  Permission();

  Permission.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("permissionId")) {
      permissionId = _json["permissionId"];
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("user")) {
      user = new User.fromJson(_json["user"]);
    }
    if (_json.containsKey("withLink")) {
      withLink = _json["withLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (permissionId != null) {
      _json["permissionId"] = permissionId;
    }
    if (role != null) {
      _json["role"] = role;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (user != null) {
      _json["user"] = (user).toJson();
    }
    if (withLink != null) {
      _json["withLink"] = withLink;
    }
    return _json;
  }
}

/**
 * Contains information about a Drive object's permissions that changed as a
 * result of a permissionChange type event.
 */
class PermissionChange {
  /** Lists all Permission objects added. */
  core.List<Permission> addedPermissions;
  /** Lists all Permission objects removed. */
  core.List<Permission> removedPermissions;

  PermissionChange();

  PermissionChange.fromJson(core.Map _json) {
    if (_json.containsKey("addedPermissions")) {
      addedPermissions = _json["addedPermissions"].map((value) => new Permission.fromJson(value)).toList();
    }
    if (_json.containsKey("removedPermissions")) {
      removedPermissions = _json["removedPermissions"].map((value) => new Permission.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (addedPermissions != null) {
      _json["addedPermissions"] = addedPermissions.map((value) => (value).toJson()).toList();
    }
    if (removedPermissions != null) {
      _json["removedPermissions"] = removedPermissions.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Photo information for a user. */
class Photo {
  /** The URL of the photo. */
  core.String url;

  Photo();

  Photo.fromJson(core.Map _json) {
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Contains information about a renametype event. */
class Rename {
  /** The new title. */
  core.String newTitle;
  /** The old title. */
  core.String oldTitle;

  Rename();

  Rename.fromJson(core.Map _json) {
    if (_json.containsKey("newTitle")) {
      newTitle = _json["newTitle"];
    }
    if (_json.containsKey("oldTitle")) {
      oldTitle = _json["oldTitle"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (newTitle != null) {
      _json["newTitle"] = newTitle;
    }
    if (oldTitle != null) {
      _json["oldTitle"] = oldTitle;
    }
    return _json;
  }
}

/** Information about the object modified by the event. */
class Target {
  /**
   * The ID of the target. For example, in Google Drive, this is the file or
   * folder ID.
   */
  core.String id;
  /** The MIME type of the target. */
  core.String mimeType;
  /**
   * The name of the target. For example, in Google Drive, this is the title of
   * the file.
   */
  core.String name;

  Target();

  Target.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("mimeType")) {
      mimeType = _json["mimeType"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (mimeType != null) {
      _json["mimeType"] = mimeType;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** A representation of a user. */
class User {
  /**
   * A boolean which indicates whether the specified User was deleted. If true,
   * name, photo and permission_id will be omitted.
   */
  core.bool isDeleted;
  /** Whether the user is the authenticated user. */
  core.bool isMe;
  /** The displayable name of the user. */
  core.String name;
  /**
   * The permission ID associated with this user. Equivalent to the Drive API's
   * permission ID for this user, returned as part of the Drive Permissions
   * resource.
   */
  core.String permissionId;
  /**
   * The profile photo of the user. Not present if the user has no profile
   * photo.
   */
  Photo photo;

  User();

  User.fromJson(core.Map _json) {
    if (_json.containsKey("isDeleted")) {
      isDeleted = _json["isDeleted"];
    }
    if (_json.containsKey("isMe")) {
      isMe = _json["isMe"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("permissionId")) {
      permissionId = _json["permissionId"];
    }
    if (_json.containsKey("photo")) {
      photo = new Photo.fromJson(_json["photo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (isDeleted != null) {
      _json["isDeleted"] = isDeleted;
    }
    if (isMe != null) {
      _json["isMe"] = isMe;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (permissionId != null) {
      _json["permissionId"] = permissionId;
    }
    if (photo != null) {
      _json["photo"] = (photo).toJson();
    }
    return _json;
  }
}
