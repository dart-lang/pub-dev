// This is a generated file (see the discoveryapis_generator project).

library googleapis.drive.v2;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert_1;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client drive/v2';

/**
 * Manages files in Drive including uploading, downloading, searching, detecting
 * changes, and updating sharing permissions.
 */
class DriveApi {
  /** View and manage the files in your Google Drive */
  static const DriveScope = "https://www.googleapis.com/auth/drive";

  /** View and manage its own configuration data in your Google Drive */
  static const DriveAppdataScope = "https://www.googleapis.com/auth/drive.appdata";

  /** View your Google Drive apps */
  static const DriveAppsReadonlyScope = "https://www.googleapis.com/auth/drive.apps.readonly";

  /**
   * View and manage Google Drive files and folders that you have opened or
   * created with this app
   */
  static const DriveFileScope = "https://www.googleapis.com/auth/drive.file";

  /** View and manage metadata of files in your Google Drive */
  static const DriveMetadataScope = "https://www.googleapis.com/auth/drive.metadata";

  /** View metadata for files in your Google Drive */
  static const DriveMetadataReadonlyScope = "https://www.googleapis.com/auth/drive.metadata.readonly";

  /** View the photos, videos and albums in your Google Photos */
  static const DrivePhotosReadonlyScope = "https://www.googleapis.com/auth/drive.photos.readonly";

  /** View the files in your Google Drive */
  static const DriveReadonlyScope = "https://www.googleapis.com/auth/drive.readonly";

  /** Modify your Google Apps Script scripts' behavior */
  static const DriveScriptsScope = "https://www.googleapis.com/auth/drive.scripts";


  final commons.ApiRequester _requester;

  AboutResourceApi get about => new AboutResourceApi(_requester);
  AppsResourceApi get apps => new AppsResourceApi(_requester);
  ChangesResourceApi get changes => new ChangesResourceApi(_requester);
  ChannelsResourceApi get channels => new ChannelsResourceApi(_requester);
  ChildrenResourceApi get children => new ChildrenResourceApi(_requester);
  CommentsResourceApi get comments => new CommentsResourceApi(_requester);
  FilesResourceApi get files => new FilesResourceApi(_requester);
  ParentsResourceApi get parents => new ParentsResourceApi(_requester);
  PermissionsResourceApi get permissions => new PermissionsResourceApi(_requester);
  PropertiesResourceApi get properties => new PropertiesResourceApi(_requester);
  RealtimeResourceApi get realtime => new RealtimeResourceApi(_requester);
  RepliesResourceApi get replies => new RepliesResourceApi(_requester);
  RevisionsResourceApi get revisions => new RevisionsResourceApi(_requester);
  TeamdrivesResourceApi get teamdrives => new TeamdrivesResourceApi(_requester);

  DriveApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "drive/v2/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AboutResourceApi {
  final commons.ApiRequester _requester;

  AboutResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the information about the current user along with Drive API settings
   *
   * Request parameters:
   *
   * [includeSubscribed] - When calculating the number of remaining change IDs,
   * whether to include public files the user has opened and shared files. When
   * set to false, this counts only change IDs for owned files and any shared or
   * public files that the user has explicitly added to a folder they own.
   *
   * [maxChangeIdCount] - Maximum number of remaining change IDs to count
   *
   * [startChangeId] - Change ID to start counting from when calculating number
   * of remaining change IDs
   *
   * Completes with a [About].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<About> get({core.bool includeSubscribed, core.String maxChangeIdCount, core.String startChangeId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (includeSubscribed != null) {
      _queryParams["includeSubscribed"] = ["${includeSubscribed}"];
    }
    if (maxChangeIdCount != null) {
      _queryParams["maxChangeIdCount"] = [maxChangeIdCount];
    }
    if (startChangeId != null) {
      _queryParams["startChangeId"] = [startChangeId];
    }

    _url = 'about';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new About.fromJson(data));
  }

}


class AppsResourceApi {
  final commons.ApiRequester _requester;

  AppsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets a specific app.
   *
   * Request parameters:
   *
   * [appId] - The ID of the app.
   *
   * Completes with a [App].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<App> get(core.String appId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appId == null) {
      throw new core.ArgumentError("Parameter appId is required.");
    }

    _url = 'apps/' + commons.Escaper.ecapeVariable('$appId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new App.fromJson(data));
  }

  /**
   * Lists a user's installed apps.
   *
   * Request parameters:
   *
   * [appFilterExtensions] - A comma-separated list of file extensions for open
   * with filtering. All apps within the given app query scope which can open
   * any of the given file extensions will be included in the response. If
   * appFilterMimeTypes are provided as well, the result is a union of the two
   * resulting app lists.
   *
   * [appFilterMimeTypes] - A comma-separated list of MIME types for open with
   * filtering. All apps within the given app query scope which can open any of
   * the given MIME types will be included in the response. If
   * appFilterExtensions are provided as well, the result is a union of the two
   * resulting app lists.
   *
   * [languageCode] - A language or locale code, as defined by BCP 47, with some
   * extensions from Unicode's LDML format
   * (http://www.unicode.org/reports/tr35/).
   *
   * Completes with a [AppList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AppList> list({core.String appFilterExtensions, core.String appFilterMimeTypes, core.String languageCode}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (appFilterExtensions != null) {
      _queryParams["appFilterExtensions"] = [appFilterExtensions];
    }
    if (appFilterMimeTypes != null) {
      _queryParams["appFilterMimeTypes"] = [appFilterMimeTypes];
    }
    if (languageCode != null) {
      _queryParams["languageCode"] = [languageCode];
    }

    _url = 'apps';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AppList.fromJson(data));
  }

}


class ChangesResourceApi {
  final commons.ApiRequester _requester;

  ChangesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets a specific change.
   *
   * Request parameters:
   *
   * [changeId] - The ID of the change.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [teamDriveId] - The Team Drive from which the change will be returned.
   *
   * Completes with a [Change].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Change> get(core.String changeId, {core.bool supportsTeamDrives, core.String teamDriveId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (changeId == null) {
      throw new core.ArgumentError("Parameter changeId is required.");
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (teamDriveId != null) {
      _queryParams["teamDriveId"] = [teamDriveId];
    }

    _url = 'changes/' + commons.Escaper.ecapeVariable('$changeId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Change.fromJson(data));
  }

  /**
   * Gets the starting pageToken for listing future changes.
   *
   * Request parameters:
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [teamDriveId] - The ID of the Team Drive for which the starting pageToken
   * for listing future changes from that Team Drive will be returned.
   *
   * Completes with a [StartPageToken].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<StartPageToken> getStartPageToken({core.bool supportsTeamDrives, core.String teamDriveId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (teamDriveId != null) {
      _queryParams["teamDriveId"] = [teamDriveId];
    }

    _url = 'changes/startPageToken';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new StartPageToken.fromJson(data));
  }

  /**
   * Lists the changes for a user or Team Drive.
   *
   * Request parameters:
   *
   * [includeCorpusRemovals] - Whether changes should include the file resource
   * if the file is still accessible by the user at the time of the request,
   * even when a file was removed from the list of changes and there will be no
   * further change entries for this file.
   *
   * [includeDeleted] - Whether to include changes indicating that items have
   * been removed from the list of changes, for example by deletion or loss of
   * access.
   *
   * [includeSubscribed] - Whether to include public files the user has opened
   * and shared files. When set to false, the list only includes owned files
   * plus any shared or public files the user has explicitly added to a folder
   * they own.
   *
   * [includeTeamDriveItems] - Whether Team Drive files or changes should be
   * included in results.
   *
   * [maxResults] - Maximum number of changes to return.
   *
   * [pageToken] - The token for continuing a previous list request on the next
   * page. This should be set to the value of 'nextPageToken' from the previous
   * response or to the response from the getStartPageToken method.
   *
   * [spaces] - A comma-separated list of spaces to query. Supported values are
   * 'drive', 'appDataFolder' and 'photos'.
   *
   * [startChangeId] - Change ID to start listing changes from.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [teamDriveId] - The Team Drive from which changes will be returned. If
   * specified the change IDs will be reflective of the Team Drive; use the
   * combined Team Drive ID and change ID as an identifier.
   *
   * Completes with a [ChangeList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ChangeList> list({core.bool includeCorpusRemovals, core.bool includeDeleted, core.bool includeSubscribed, core.bool includeTeamDriveItems, core.int maxResults, core.String pageToken, core.String spaces, core.String startChangeId, core.bool supportsTeamDrives, core.String teamDriveId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (includeCorpusRemovals != null) {
      _queryParams["includeCorpusRemovals"] = ["${includeCorpusRemovals}"];
    }
    if (includeDeleted != null) {
      _queryParams["includeDeleted"] = ["${includeDeleted}"];
    }
    if (includeSubscribed != null) {
      _queryParams["includeSubscribed"] = ["${includeSubscribed}"];
    }
    if (includeTeamDriveItems != null) {
      _queryParams["includeTeamDriveItems"] = ["${includeTeamDriveItems}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (spaces != null) {
      _queryParams["spaces"] = [spaces];
    }
    if (startChangeId != null) {
      _queryParams["startChangeId"] = [startChangeId];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (teamDriveId != null) {
      _queryParams["teamDriveId"] = [teamDriveId];
    }

    _url = 'changes';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ChangeList.fromJson(data));
  }

  /**
   * Subscribe to changes for a user.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [includeCorpusRemovals] - Whether changes should include the file resource
   * if the file is still accessible by the user at the time of the request,
   * even when a file was removed from the list of changes and there will be no
   * further change entries for this file.
   *
   * [includeDeleted] - Whether to include changes indicating that items have
   * been removed from the list of changes, for example by deletion or loss of
   * access.
   *
   * [includeSubscribed] - Whether to include public files the user has opened
   * and shared files. When set to false, the list only includes owned files
   * plus any shared or public files the user has explicitly added to a folder
   * they own.
   *
   * [includeTeamDriveItems] - Whether Team Drive files or changes should be
   * included in results.
   *
   * [maxResults] - Maximum number of changes to return.
   *
   * [pageToken] - The token for continuing a previous list request on the next
   * page. This should be set to the value of 'nextPageToken' from the previous
   * response or to the response from the getStartPageToken method.
   *
   * [spaces] - A comma-separated list of spaces to query. Supported values are
   * 'drive', 'appDataFolder' and 'photos'.
   *
   * [startChangeId] - Change ID to start listing changes from.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [teamDriveId] - The Team Drive from which changes will be returned. If
   * specified the change IDs will be reflective of the Team Drive; use the
   * combined Team Drive ID and change ID as an identifier.
   *
   * Completes with a [Channel].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Channel> watch(Channel request, {core.bool includeCorpusRemovals, core.bool includeDeleted, core.bool includeSubscribed, core.bool includeTeamDriveItems, core.int maxResults, core.String pageToken, core.String spaces, core.String startChangeId, core.bool supportsTeamDrives, core.String teamDriveId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (includeCorpusRemovals != null) {
      _queryParams["includeCorpusRemovals"] = ["${includeCorpusRemovals}"];
    }
    if (includeDeleted != null) {
      _queryParams["includeDeleted"] = ["${includeDeleted}"];
    }
    if (includeSubscribed != null) {
      _queryParams["includeSubscribed"] = ["${includeSubscribed}"];
    }
    if (includeTeamDriveItems != null) {
      _queryParams["includeTeamDriveItems"] = ["${includeTeamDriveItems}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (spaces != null) {
      _queryParams["spaces"] = [spaces];
    }
    if (startChangeId != null) {
      _queryParams["startChangeId"] = [startChangeId];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (teamDriveId != null) {
      _queryParams["teamDriveId"] = [teamDriveId];
    }

    _url = 'changes/watch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Channel.fromJson(data));
  }

}


class ChannelsResourceApi {
  final commons.ApiRequester _requester;

  ChannelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Stop watching resources through this channel
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future stop(Channel request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }

    _downloadOptions = null;

    _url = 'channels/stop';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

}


class ChildrenResourceApi {
  final commons.ApiRequester _requester;

  ChildrenResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Removes a child from a folder.
   *
   * Request parameters:
   *
   * [folderId] - The ID of the folder.
   *
   * [childId] - The ID of the child.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String folderId, core.String childId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (folderId == null) {
      throw new core.ArgumentError("Parameter folderId is required.");
    }
    if (childId == null) {
      throw new core.ArgumentError("Parameter childId is required.");
    }

    _downloadOptions = null;

    _url = 'files/' + commons.Escaper.ecapeVariable('$folderId') + '/children/' + commons.Escaper.ecapeVariable('$childId');

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
   * Gets a specific child reference.
   *
   * Request parameters:
   *
   * [folderId] - The ID of the folder.
   *
   * [childId] - The ID of the child.
   *
   * Completes with a [ChildReference].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ChildReference> get(core.String folderId, core.String childId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (folderId == null) {
      throw new core.ArgumentError("Parameter folderId is required.");
    }
    if (childId == null) {
      throw new core.ArgumentError("Parameter childId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$folderId') + '/children/' + commons.Escaper.ecapeVariable('$childId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ChildReference.fromJson(data));
  }

  /**
   * Inserts a file into a folder.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [folderId] - The ID of the folder.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * Completes with a [ChildReference].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ChildReference> insert(ChildReference request, core.String folderId, {core.bool supportsTeamDrives}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (folderId == null) {
      throw new core.ArgumentError("Parameter folderId is required.");
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$folderId') + '/children';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ChildReference.fromJson(data));
  }

  /**
   * Lists a folder's children.
   *
   * Request parameters:
   *
   * [folderId] - The ID of the folder.
   *
   * [maxResults] - Maximum number of children to return.
   *
   * [orderBy] - A comma-separated list of sort keys. Valid keys are
   * 'createdDate', 'folder', 'lastViewedByMeDate', 'modifiedByMeDate',
   * 'modifiedDate', 'quotaBytesUsed', 'recency', 'sharedWithMeDate', 'starred',
   * and 'title'. Each key sorts ascending by default, but may be reversed with
   * the 'desc' modifier. Example usage: ?orderBy=folder,modifiedDate
   * desc,title. Please note that there is a current limitation for users with
   * approximately one million files in which the requested sort order is
   * ignored.
   *
   * [pageToken] - Page token for children.
   *
   * [q] - Query string for searching children.
   *
   * Completes with a [ChildList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ChildList> list(core.String folderId, {core.int maxResults, core.String orderBy, core.String pageToken, core.String q}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (folderId == null) {
      throw new core.ArgumentError("Parameter folderId is required.");
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
    if (q != null) {
      _queryParams["q"] = [q];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$folderId') + '/children';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ChildList.fromJson(data));
  }

}


class CommentsResourceApi {
  final commons.ApiRequester _requester;

  CommentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a comment.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String fileId, core.String commentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }

    _downloadOptions = null;

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId');

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
   * Gets a comment by ID.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [includeDeleted] - If set, this will succeed when retrieving a deleted
   * comment, and will include any deleted replies.
   *
   * Completes with a [Comment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Comment> get(core.String fileId, core.String commentId, {core.bool includeDeleted}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }
    if (includeDeleted != null) {
      _queryParams["includeDeleted"] = ["${includeDeleted}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Comment.fromJson(data));
  }

  /**
   * Creates a new comment on the given file.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * Completes with a [Comment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Comment> insert(Comment request, core.String fileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/comments';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Comment.fromJson(data));
  }

  /**
   * Lists a file's comments.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [includeDeleted] - If set, all comments and replies, including deleted
   * comments and replies (with content stripped) will be returned.
   *
   * [maxResults] - The maximum number of discussions to include in the
   * response, used for paging.
   * Value must be between "0" and "100".
   *
   * [pageToken] - The continuation token, used to page through large result
   * sets. To get the next page of results, set this parameter to the value of
   * "nextPageToken" from the previous response.
   *
   * [updatedMin] - Only discussions that were updated after this timestamp will
   * be returned. Formatted as an RFC 3339 timestamp.
   *
   * Completes with a [CommentList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentList> list(core.String fileId, {core.bool includeDeleted, core.int maxResults, core.String pageToken, core.String updatedMin}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (includeDeleted != null) {
      _queryParams["includeDeleted"] = ["${includeDeleted}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (updatedMin != null) {
      _queryParams["updatedMin"] = [updatedMin];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/comments';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentList.fromJson(data));
  }

  /**
   * Updates an existing comment. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * Completes with a [Comment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Comment> patch(Comment request, core.String fileId, core.String commentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Comment.fromJson(data));
  }

  /**
   * Updates an existing comment.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * Completes with a [Comment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Comment> update(Comment request, core.String fileId, core.String commentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Comment.fromJson(data));
  }

}


class FilesResourceApi {
  final commons.ApiRequester _requester;

  FilesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a copy of the specified file.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file to copy.
   *
   * [convert] - Whether to convert this file to the corresponding Google Docs
   * format.
   *
   * [ocr] - Whether to attempt OCR on .jpg, .png, .gif, or .pdf uploads.
   *
   * [ocrLanguage] - If ocr is true, hints at the language to use. Valid values
   * are BCP 47 codes.
   *
   * [pinned] - Whether to pin the head revision of the new copy. A file can
   * have a maximum of 200 pinned revisions.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [timedTextLanguage] - The language of the timed text.
   *
   * [timedTextTrackName] - The timed text track name.
   *
   * [visibility] - The visibility of the new file. This parameter is only
   * relevant when the source is not a native Google Doc and convert=false.
   * Possible string values are:
   * - "DEFAULT" : The visibility of the new file is determined by the user's
   * default visibility/sharing policies.
   * - "PRIVATE" : The new file will be visible to only the owner.
   *
   * Completes with a [File].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<File> copy(File request, core.String fileId, {core.bool convert, core.bool ocr, core.String ocrLanguage, core.bool pinned, core.bool supportsTeamDrives, core.String timedTextLanguage, core.String timedTextTrackName, core.String visibility}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (convert != null) {
      _queryParams["convert"] = ["${convert}"];
    }
    if (ocr != null) {
      _queryParams["ocr"] = ["${ocr}"];
    }
    if (ocrLanguage != null) {
      _queryParams["ocrLanguage"] = [ocrLanguage];
    }
    if (pinned != null) {
      _queryParams["pinned"] = ["${pinned}"];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (timedTextLanguage != null) {
      _queryParams["timedTextLanguage"] = [timedTextLanguage];
    }
    if (timedTextTrackName != null) {
      _queryParams["timedTextTrackName"] = [timedTextTrackName];
    }
    if (visibility != null) {
      _queryParams["visibility"] = [visibility];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/copy';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new File.fromJson(data));
  }

  /**
   * Permanently deletes a file by ID. Skips the trash. The currently
   * authenticated user must own the file or be an organizer on the parent for
   * Team Drive files.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file to delete.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String fileId, {core.bool supportsTeamDrives}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }

    _downloadOptions = null;

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId');

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
   * Permanently deletes all of the user's trashed files.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future emptyTrash() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _downloadOptions = null;

    _url = 'files/trash';

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
   * Exports a Google Doc to the requested MIME type and returns the exported
   * content.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [mimeType] - The MIME type of the format requested for this export.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future export(core.String fileId, core.String mimeType, {commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (mimeType == null) {
      throw new core.ArgumentError("Parameter mimeType is required.");
    }
    _queryParams["mimeType"] = [mimeType];

    _downloadOptions = downloadOptions;

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/export';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => null);
    } else {
      return _response;
    }
  }

  /**
   * Generates a set of file IDs which can be provided in insert requests.
   *
   * Request parameters:
   *
   * [maxResults] - Maximum number of IDs to return.
   * Value must be between "1" and "1000".
   *
   * [space] - The space in which the IDs can be used to create new files.
   * Supported values are 'drive' and 'appDataFolder'.
   *
   * Completes with a [GeneratedIds].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GeneratedIds> generateIds({core.int maxResults, core.String space}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (space != null) {
      _queryParams["space"] = [space];
    }

    _url = 'files/generateIds';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GeneratedIds.fromJson(data));
  }

  /**
   * Gets a file's metadata by ID.
   *
   * Request parameters:
   *
   * [fileId] - The ID for the file in question.
   *
   * [acknowledgeAbuse] - Whether the user is acknowledging the risk of
   * downloading known malware or other abusive files.
   *
   * [projection] - This parameter is deprecated and has no function.
   * Possible string values are:
   * - "BASIC" : Deprecated
   * - "FULL" : Deprecated
   *
   * [revisionId] - Specifies the Revision ID that should be downloaded. Ignored
   * unless alt=media is specified.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [updateViewedDate] - Deprecated: Use files.update with
   * modifiedDateBehavior=noChange, updateViewedDate=true and an empty request
   * body.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [File] for Metadata downloads (see [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future get(core.String fileId, {core.bool acknowledgeAbuse, core.String projection, core.String revisionId, core.bool supportsTeamDrives, core.bool updateViewedDate, commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (acknowledgeAbuse != null) {
      _queryParams["acknowledgeAbuse"] = ["${acknowledgeAbuse}"];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }
    if (revisionId != null) {
      _queryParams["revisionId"] = [revisionId];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (updateViewedDate != null) {
      _queryParams["updateViewedDate"] = ["${updateViewedDate}"];
    }

    _downloadOptions = downloadOptions;

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new File.fromJson(data));
    } else {
      return _response;
    }
  }

  /**
   * Insert a new file.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [convert] - Whether to convert this file to the corresponding Google Docs
   * format.
   *
   * [ocr] - Whether to attempt OCR on .jpg, .png, .gif, or .pdf uploads.
   *
   * [ocrLanguage] - If ocr is true, hints at the language to use. Valid values
   * are BCP 47 codes.
   *
   * [pinned] - Whether to pin the head revision of the uploaded file. A file
   * can have a maximum of 200 pinned revisions.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [timedTextLanguage] - The language of the timed text.
   *
   * [timedTextTrackName] - The timed text track name.
   *
   * [useContentAsIndexableText] - Whether to use the content as indexable text.
   *
   * [visibility] - The visibility of the new file. This parameter is only
   * relevant when convert=false.
   * Possible string values are:
   * - "DEFAULT" : The visibility of the new file is determined by the user's
   * default visibility/sharing policies.
   * - "PRIVATE" : The new file will be visible to only the owner.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [File].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<File> insert(File request, {core.bool convert, core.bool ocr, core.String ocrLanguage, core.bool pinned, core.bool supportsTeamDrives, core.String timedTextLanguage, core.String timedTextTrackName, core.bool useContentAsIndexableText, core.String visibility, commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (convert != null) {
      _queryParams["convert"] = ["${convert}"];
    }
    if (ocr != null) {
      _queryParams["ocr"] = ["${ocr}"];
    }
    if (ocrLanguage != null) {
      _queryParams["ocrLanguage"] = [ocrLanguage];
    }
    if (pinned != null) {
      _queryParams["pinned"] = ["${pinned}"];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (timedTextLanguage != null) {
      _queryParams["timedTextLanguage"] = [timedTextLanguage];
    }
    if (timedTextTrackName != null) {
      _queryParams["timedTextTrackName"] = [timedTextTrackName];
    }
    if (useContentAsIndexableText != null) {
      _queryParams["useContentAsIndexableText"] = ["${useContentAsIndexableText}"];
    }
    if (visibility != null) {
      _queryParams["visibility"] = [visibility];
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'files';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/drive/v2/files';
    } else {
      _url = '/upload/drive/v2/files';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new File.fromJson(data));
  }

  /**
   * Lists the user's files.
   *
   * Request parameters:
   *
   * [corpora] - Comma-separated list of bodies of items (files/documents) to
   * which the query applies. Supported bodies are 'default', 'domain',
   * 'teamDrive' and 'allTeamDrives'. 'allTeamDrives' must be combined with
   * 'default'; all other values must be used in isolation. Prefer 'default' or
   * 'teamDrive' to 'allTeamDrives' for efficiency.
   *
   * [corpus] - The body of items (files/documents) to which the query applies.
   * Deprecated: use 'corpora' instead.
   * Possible string values are:
   * - "DEFAULT" : The items that the user has accessed.
   * - "DOMAIN" : Items shared to the user's domain.
   *
   * [includeTeamDriveItems] - Whether Team Drive items should be included in
   * results.
   *
   * [maxResults] - Maximum number of files to return.
   *
   * [orderBy] - A comma-separated list of sort keys. Valid keys are
   * 'createdDate', 'folder', 'lastViewedByMeDate', 'modifiedByMeDate',
   * 'modifiedDate', 'quotaBytesUsed', 'recency', 'sharedWithMeDate', 'starred',
   * and 'title'. Each key sorts ascending by default, but may be reversed with
   * the 'desc' modifier. Example usage: ?orderBy=folder,modifiedDate
   * desc,title. Please note that there is a current limitation for users with
   * approximately one million files in which the requested sort order is
   * ignored.
   *
   * [pageToken] - Page token for files.
   *
   * [projection] - This parameter is deprecated and has no function.
   * Possible string values are:
   * - "BASIC" : Deprecated
   * - "FULL" : Deprecated
   *
   * [q] - Query string for searching files.
   *
   * [spaces] - A comma-separated list of spaces to query. Supported values are
   * 'drive', 'appDataFolder' and 'photos'.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [teamDriveId] - ID of Team Drive to search.
   *
   * Completes with a [FileList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FileList> list({core.String corpora, core.String corpus, core.bool includeTeamDriveItems, core.int maxResults, core.String orderBy, core.String pageToken, core.String projection, core.String q, core.String spaces, core.bool supportsTeamDrives, core.String teamDriveId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (corpora != null) {
      _queryParams["corpora"] = [corpora];
    }
    if (corpus != null) {
      _queryParams["corpus"] = [corpus];
    }
    if (includeTeamDriveItems != null) {
      _queryParams["includeTeamDriveItems"] = ["${includeTeamDriveItems}"];
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
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }
    if (q != null) {
      _queryParams["q"] = [q];
    }
    if (spaces != null) {
      _queryParams["spaces"] = [spaces];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (teamDriveId != null) {
      _queryParams["teamDriveId"] = [teamDriveId];
    }

    _url = 'files';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FileList.fromJson(data));
  }

  /**
   * Updates file metadata and/or content. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file to update.
   *
   * [addParents] - Comma-separated list of parent IDs to add.
   *
   * [convert] - This parameter is deprecated and has no function.
   *
   * [modifiedDateBehavior] - Determines the behavior in which modifiedDate is
   * updated. This overrides setModifiedDate.
   * Possible string values are:
   * - "fromBody" : Set modifiedDate to the value provided in the body of the
   * request. No change if no value was provided.
   * - "fromBodyIfNeeded" : Set modifiedDate to the value provided in the body
   * of the request depending on other contents of the update.
   * - "fromBodyOrNow" : Set modifiedDate to the value provided in the body of
   * the request, or to the current time if no value was provided.
   * - "noChange" : Maintain the previous value of modifiedDate.
   * - "now" : Set modifiedDate to the current time.
   * - "nowIfNeeded" : Set modifiedDate to the current time depending on
   * contents of the update.
   *
   * [newRevision] - Whether a blob upload should create a new revision. If
   * false, the blob data in the current head revision is replaced. If true or
   * not set, a new blob is created as head revision, and previous unpinned
   * revisions are preserved for a short period of time. Pinned revisions are
   * stored indefinitely, using additional storage quota, up to a maximum of 200
   * revisions. For details on how revisions are retained, see the Drive Help
   * Center.
   *
   * [ocr] - Whether to attempt OCR on .jpg, .png, .gif, or .pdf uploads.
   *
   * [ocrLanguage] - If ocr is true, hints at the language to use. Valid values
   * are BCP 47 codes.
   *
   * [pinned] - Whether to pin the new revision. A file can have a maximum of
   * 200 pinned revisions.
   *
   * [removeParents] - Comma-separated list of parent IDs to remove.
   *
   * [setModifiedDate] - Whether to set the modified date with the supplied
   * modified date.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [timedTextLanguage] - The language of the timed text.
   *
   * [timedTextTrackName] - The timed text track name.
   *
   * [updateViewedDate] - Whether to update the view date after successfully
   * updating the file.
   *
   * [useContentAsIndexableText] - Whether to use the content as indexable text.
   *
   * Completes with a [File].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<File> patch(File request, core.String fileId, {core.String addParents, core.bool convert, core.String modifiedDateBehavior, core.bool newRevision, core.bool ocr, core.String ocrLanguage, core.bool pinned, core.String removeParents, core.bool setModifiedDate, core.bool supportsTeamDrives, core.String timedTextLanguage, core.String timedTextTrackName, core.bool updateViewedDate, core.bool useContentAsIndexableText}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (addParents != null) {
      _queryParams["addParents"] = [addParents];
    }
    if (convert != null) {
      _queryParams["convert"] = ["${convert}"];
    }
    if (modifiedDateBehavior != null) {
      _queryParams["modifiedDateBehavior"] = [modifiedDateBehavior];
    }
    if (newRevision != null) {
      _queryParams["newRevision"] = ["${newRevision}"];
    }
    if (ocr != null) {
      _queryParams["ocr"] = ["${ocr}"];
    }
    if (ocrLanguage != null) {
      _queryParams["ocrLanguage"] = [ocrLanguage];
    }
    if (pinned != null) {
      _queryParams["pinned"] = ["${pinned}"];
    }
    if (removeParents != null) {
      _queryParams["removeParents"] = [removeParents];
    }
    if (setModifiedDate != null) {
      _queryParams["setModifiedDate"] = ["${setModifiedDate}"];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (timedTextLanguage != null) {
      _queryParams["timedTextLanguage"] = [timedTextLanguage];
    }
    if (timedTextTrackName != null) {
      _queryParams["timedTextTrackName"] = [timedTextTrackName];
    }
    if (updateViewedDate != null) {
      _queryParams["updateViewedDate"] = ["${updateViewedDate}"];
    }
    if (useContentAsIndexableText != null) {
      _queryParams["useContentAsIndexableText"] = ["${useContentAsIndexableText}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new File.fromJson(data));
  }

  /**
   * Set the file's updated time to the current server time.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file to update.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * Completes with a [File].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<File> touch(core.String fileId, {core.bool supportsTeamDrives}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/touch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new File.fromJson(data));
  }

  /**
   * Moves a file to the trash. The currently authenticated user must own the
   * file or be an organizer on the parent for Team Drive files.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file to trash.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * Completes with a [File].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<File> trash(core.String fileId, {core.bool supportsTeamDrives}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/trash';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new File.fromJson(data));
  }

  /**
   * Restores a file from the trash.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file to untrash.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * Completes with a [File].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<File> untrash(core.String fileId, {core.bool supportsTeamDrives}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/untrash';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new File.fromJson(data));
  }

  /**
   * Updates file metadata and/or content.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file to update.
   *
   * [addParents] - Comma-separated list of parent IDs to add.
   *
   * [convert] - This parameter is deprecated and has no function.
   *
   * [modifiedDateBehavior] - Determines the behavior in which modifiedDate is
   * updated. This overrides setModifiedDate.
   * Possible string values are:
   * - "fromBody" : Set modifiedDate to the value provided in the body of the
   * request. No change if no value was provided.
   * - "fromBodyIfNeeded" : Set modifiedDate to the value provided in the body
   * of the request depending on other contents of the update.
   * - "fromBodyOrNow" : Set modifiedDate to the value provided in the body of
   * the request, or to the current time if no value was provided.
   * - "noChange" : Maintain the previous value of modifiedDate.
   * - "now" : Set modifiedDate to the current time.
   * - "nowIfNeeded" : Set modifiedDate to the current time depending on
   * contents of the update.
   *
   * [newRevision] - Whether a blob upload should create a new revision. If
   * false, the blob data in the current head revision is replaced. If true or
   * not set, a new blob is created as head revision, and previous unpinned
   * revisions are preserved for a short period of time. Pinned revisions are
   * stored indefinitely, using additional storage quota, up to a maximum of 200
   * revisions. For details on how revisions are retained, see the Drive Help
   * Center.
   *
   * [ocr] - Whether to attempt OCR on .jpg, .png, .gif, or .pdf uploads.
   *
   * [ocrLanguage] - If ocr is true, hints at the language to use. Valid values
   * are BCP 47 codes.
   *
   * [pinned] - Whether to pin the new revision. A file can have a maximum of
   * 200 pinned revisions.
   *
   * [removeParents] - Comma-separated list of parent IDs to remove.
   *
   * [setModifiedDate] - Whether to set the modified date with the supplied
   * modified date.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [timedTextLanguage] - The language of the timed text.
   *
   * [timedTextTrackName] - The timed text track name.
   *
   * [updateViewedDate] - Whether to update the view date after successfully
   * updating the file.
   *
   * [useContentAsIndexableText] - Whether to use the content as indexable text.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [File].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<File> update(File request, core.String fileId, {core.String addParents, core.bool convert, core.String modifiedDateBehavior, core.bool newRevision, core.bool ocr, core.String ocrLanguage, core.bool pinned, core.String removeParents, core.bool setModifiedDate, core.bool supportsTeamDrives, core.String timedTextLanguage, core.String timedTextTrackName, core.bool updateViewedDate, core.bool useContentAsIndexableText, commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (addParents != null) {
      _queryParams["addParents"] = [addParents];
    }
    if (convert != null) {
      _queryParams["convert"] = ["${convert}"];
    }
    if (modifiedDateBehavior != null) {
      _queryParams["modifiedDateBehavior"] = [modifiedDateBehavior];
    }
    if (newRevision != null) {
      _queryParams["newRevision"] = ["${newRevision}"];
    }
    if (ocr != null) {
      _queryParams["ocr"] = ["${ocr}"];
    }
    if (ocrLanguage != null) {
      _queryParams["ocrLanguage"] = [ocrLanguage];
    }
    if (pinned != null) {
      _queryParams["pinned"] = ["${pinned}"];
    }
    if (removeParents != null) {
      _queryParams["removeParents"] = [removeParents];
    }
    if (setModifiedDate != null) {
      _queryParams["setModifiedDate"] = ["${setModifiedDate}"];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (timedTextLanguage != null) {
      _queryParams["timedTextLanguage"] = [timedTextLanguage];
    }
    if (timedTextTrackName != null) {
      _queryParams["timedTextTrackName"] = [timedTextTrackName];
    }
    if (updateViewedDate != null) {
      _queryParams["updateViewedDate"] = ["${updateViewedDate}"];
    }
    if (useContentAsIndexableText != null) {
      _queryParams["useContentAsIndexableText"] = ["${useContentAsIndexableText}"];
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'files/' + commons.Escaper.ecapeVariable('$fileId');
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/drive/v2/files/' + commons.Escaper.ecapeVariable('$fileId');
    } else {
      _url = '/upload/drive/v2/files/' + commons.Escaper.ecapeVariable('$fileId');
    }


    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new File.fromJson(data));
  }

  /**
   * Subscribe to changes on a file
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID for the file in question.
   *
   * [acknowledgeAbuse] - Whether the user is acknowledging the risk of
   * downloading known malware or other abusive files.
   *
   * [projection] - This parameter is deprecated and has no function.
   * Possible string values are:
   * - "BASIC" : Deprecated
   * - "FULL" : Deprecated
   *
   * [revisionId] - Specifies the Revision ID that should be downloaded. Ignored
   * unless alt=media is specified.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [updateViewedDate] - Deprecated: Use files.update with
   * modifiedDateBehavior=noChange, updateViewedDate=true and an empty request
   * body.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [Channel] for Metadata downloads (see [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future watch(Channel request, core.String fileId, {core.bool acknowledgeAbuse, core.String projection, core.String revisionId, core.bool supportsTeamDrives, core.bool updateViewedDate, commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (acknowledgeAbuse != null) {
      _queryParams["acknowledgeAbuse"] = ["${acknowledgeAbuse}"];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }
    if (revisionId != null) {
      _queryParams["revisionId"] = [revisionId];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (updateViewedDate != null) {
      _queryParams["updateViewedDate"] = ["${updateViewedDate}"];
    }

    _downloadOptions = downloadOptions;

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/watch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new Channel.fromJson(data));
    } else {
      return _response;
    }
  }

}


class ParentsResourceApi {
  final commons.ApiRequester _requester;

  ParentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Removes a parent from a file.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [parentId] - The ID of the parent.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String fileId, core.String parentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (parentId == null) {
      throw new core.ArgumentError("Parameter parentId is required.");
    }

    _downloadOptions = null;

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/parents/' + commons.Escaper.ecapeVariable('$parentId');

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
   * Gets a specific parent reference.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [parentId] - The ID of the parent.
   *
   * Completes with a [ParentReference].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ParentReference> get(core.String fileId, core.String parentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (parentId == null) {
      throw new core.ArgumentError("Parameter parentId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/parents/' + commons.Escaper.ecapeVariable('$parentId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ParentReference.fromJson(data));
  }

  /**
   * Adds a parent folder for a file.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * Completes with a [ParentReference].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ParentReference> insert(ParentReference request, core.String fileId, {core.bool supportsTeamDrives}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/parents';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ParentReference.fromJson(data));
  }

  /**
   * Lists a file's parents.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * Completes with a [ParentList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ParentList> list(core.String fileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/parents';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ParentList.fromJson(data));
  }

}


class PermissionsResourceApi {
  final commons.ApiRequester _requester;

  PermissionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a permission from a file or Team Drive.
   *
   * Request parameters:
   *
   * [fileId] - The ID for the file or Team Drive.
   *
   * [permissionId] - The ID for the permission.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String fileId, core.String permissionId, {core.bool supportsTeamDrives}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (permissionId == null) {
      throw new core.ArgumentError("Parameter permissionId is required.");
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }

    _downloadOptions = null;

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/permissions/' + commons.Escaper.ecapeVariable('$permissionId');

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
   * Gets a permission by ID.
   *
   * Request parameters:
   *
   * [fileId] - The ID for the file or Team Drive.
   *
   * [permissionId] - The ID for the permission.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * Completes with a [Permission].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Permission> get(core.String fileId, core.String permissionId, {core.bool supportsTeamDrives}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (permissionId == null) {
      throw new core.ArgumentError("Parameter permissionId is required.");
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/permissions/' + commons.Escaper.ecapeVariable('$permissionId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Permission.fromJson(data));
  }

  /**
   * Returns the permission ID for an email address.
   *
   * Request parameters:
   *
   * [email] - The email address for which to return a permission ID
   *
   * Completes with a [PermissionId].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PermissionId> getIdForEmail(core.String email) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (email == null) {
      throw new core.ArgumentError("Parameter email is required.");
    }

    _url = 'permissionIds/' + commons.Escaper.ecapeVariable('$email');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PermissionId.fromJson(data));
  }

  /**
   * Inserts a permission for a file or Team Drive.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID for the file or Team Drive.
   *
   * [emailMessage] - A custom message to include in notification emails.
   *
   * [sendNotificationEmails] - Whether to send notification emails when sharing
   * to users or groups. This parameter is ignored and an email is sent if the
   * role is owner.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * Completes with a [Permission].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Permission> insert(Permission request, core.String fileId, {core.String emailMessage, core.bool sendNotificationEmails, core.bool supportsTeamDrives}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (emailMessage != null) {
      _queryParams["emailMessage"] = [emailMessage];
    }
    if (sendNotificationEmails != null) {
      _queryParams["sendNotificationEmails"] = ["${sendNotificationEmails}"];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/permissions';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Permission.fromJson(data));
  }

  /**
   * Lists a file's or Team Drive's permissions.
   *
   * Request parameters:
   *
   * [fileId] - The ID for the file or Team Drive.
   *
   * [maxResults] - The maximum number of permissions to return per page. When
   * not set for files in a Team Drive, at most 100 results will be returned.
   * When not set for files that are not in a Team Drive, the entire list will
   * be returned.
   * Value must be between "1" and "100".
   *
   * [pageToken] - The token for continuing a previous list request on the next
   * page. This should be set to the value of 'nextPageToken' from the previous
   * response.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * Completes with a [PermissionList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PermissionList> list(core.String fileId, {core.int maxResults, core.String pageToken, core.bool supportsTeamDrives}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/permissions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PermissionList.fromJson(data));
  }

  /**
   * Updates a permission using patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID for the file or Team Drive.
   *
   * [permissionId] - The ID for the permission.
   *
   * [removeExpiration] - Whether to remove the expiration date.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [transferOwnership] - Whether changing a role to 'owner' downgrades the
   * current owners to writers. Does nothing if the specified role is not
   * 'owner'.
   *
   * Completes with a [Permission].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Permission> patch(Permission request, core.String fileId, core.String permissionId, {core.bool removeExpiration, core.bool supportsTeamDrives, core.bool transferOwnership}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (permissionId == null) {
      throw new core.ArgumentError("Parameter permissionId is required.");
    }
    if (removeExpiration != null) {
      _queryParams["removeExpiration"] = ["${removeExpiration}"];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (transferOwnership != null) {
      _queryParams["transferOwnership"] = ["${transferOwnership}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/permissions/' + commons.Escaper.ecapeVariable('$permissionId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Permission.fromJson(data));
  }

  /**
   * Updates a permission.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID for the file or Team Drive.
   *
   * [permissionId] - The ID for the permission.
   *
   * [removeExpiration] - Whether to remove the expiration date.
   *
   * [supportsTeamDrives] - Whether the requesting application supports Team
   * Drives.
   *
   * [transferOwnership] - Whether changing a role to 'owner' downgrades the
   * current owners to writers. Does nothing if the specified role is not
   * 'owner'.
   *
   * Completes with a [Permission].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Permission> update(Permission request, core.String fileId, core.String permissionId, {core.bool removeExpiration, core.bool supportsTeamDrives, core.bool transferOwnership}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (permissionId == null) {
      throw new core.ArgumentError("Parameter permissionId is required.");
    }
    if (removeExpiration != null) {
      _queryParams["removeExpiration"] = ["${removeExpiration}"];
    }
    if (supportsTeamDrives != null) {
      _queryParams["supportsTeamDrives"] = ["${supportsTeamDrives}"];
    }
    if (transferOwnership != null) {
      _queryParams["transferOwnership"] = ["${transferOwnership}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/permissions/' + commons.Escaper.ecapeVariable('$permissionId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Permission.fromJson(data));
  }

}


class PropertiesResourceApi {
  final commons.ApiRequester _requester;

  PropertiesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a property.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [propertyKey] - The key of the property.
   *
   * [visibility] - The visibility of the property.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String fileId, core.String propertyKey, {core.String visibility}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (propertyKey == null) {
      throw new core.ArgumentError("Parameter propertyKey is required.");
    }
    if (visibility != null) {
      _queryParams["visibility"] = [visibility];
    }

    _downloadOptions = null;

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/properties/' + commons.Escaper.ecapeVariable('$propertyKey');

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
   * Gets a property by its key.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [propertyKey] - The key of the property.
   *
   * [visibility] - The visibility of the property.
   *
   * Completes with a [Property].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Property> get(core.String fileId, core.String propertyKey, {core.String visibility}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (propertyKey == null) {
      throw new core.ArgumentError("Parameter propertyKey is required.");
    }
    if (visibility != null) {
      _queryParams["visibility"] = [visibility];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/properties/' + commons.Escaper.ecapeVariable('$propertyKey');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Property.fromJson(data));
  }

  /**
   * Adds a property to a file, or updates it if it already exists.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * Completes with a [Property].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Property> insert(Property request, core.String fileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/properties';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Property.fromJson(data));
  }

  /**
   * Lists a file's properties.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * Completes with a [PropertyList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PropertyList> list(core.String fileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/properties';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PropertyList.fromJson(data));
  }

  /**
   * Updates a property, or adds it if it doesn't exist. This method supports
   * patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [propertyKey] - The key of the property.
   *
   * [visibility] - The visibility of the property.
   *
   * Completes with a [Property].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Property> patch(Property request, core.String fileId, core.String propertyKey, {core.String visibility}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (propertyKey == null) {
      throw new core.ArgumentError("Parameter propertyKey is required.");
    }
    if (visibility != null) {
      _queryParams["visibility"] = [visibility];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/properties/' + commons.Escaper.ecapeVariable('$propertyKey');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Property.fromJson(data));
  }

  /**
   * Updates a property, or adds it if it doesn't exist.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [propertyKey] - The key of the property.
   *
   * [visibility] - The visibility of the property.
   *
   * Completes with a [Property].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Property> update(Property request, core.String fileId, core.String propertyKey, {core.String visibility}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (propertyKey == null) {
      throw new core.ArgumentError("Parameter propertyKey is required.");
    }
    if (visibility != null) {
      _queryParams["visibility"] = [visibility];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/properties/' + commons.Escaper.ecapeVariable('$propertyKey');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Property.fromJson(data));
  }

}


class RealtimeResourceApi {
  final commons.ApiRequester _requester;

  RealtimeResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Exports the contents of the Realtime API data model associated with this
   * file as JSON.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file that the Realtime API data model is
   * associated with.
   *
   * [revision] - The revision of the Realtime API data model to export.
   * Revisions start at 1 (the initial empty data model) and are incremented
   * with each change. If this parameter is excluded, the most recent data model
   * will be returned.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future get(core.String fileId, {core.int revision, commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (revision != null) {
      _queryParams["revision"] = ["${revision}"];
    }

    _downloadOptions = downloadOptions;

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/realtime';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => null);
    } else {
      return _response;
    }
  }

  /**
   * Overwrites the Realtime API data model associated with this file with the
   * provided JSON data model.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file that the Realtime API data model is
   * associated with.
   *
   * [baseRevision] - The revision of the model to diff the uploaded model
   * against. If set, the uploaded model is diffed against the provided revision
   * and those differences are merged with any changes made to the model after
   * the provided revision. If not set, the uploaded model replaces the current
   * model on the server.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future update(core.String fileId, {core.String baseRevision, commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (baseRevision != null) {
      _queryParams["baseRevision"] = [baseRevision];
    }


    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;
    _downloadOptions = null;

    if (_uploadMedia == null) {
      _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/realtime';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/drive/v2/files/' + commons.Escaper.ecapeVariable('$fileId') + '/realtime';
    } else {
      _url = '/upload/drive/v2/files/' + commons.Escaper.ecapeVariable('$fileId') + '/realtime';
    }


    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

}


class RepliesResourceApi {
  final commons.ApiRequester _requester;

  RepliesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a reply.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [replyId] - The ID of the reply.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String fileId, core.String commentId, core.String replyId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }
    if (replyId == null) {
      throw new core.ArgumentError("Parameter replyId is required.");
    }

    _downloadOptions = null;

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId') + '/replies/' + commons.Escaper.ecapeVariable('$replyId');

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
   * Gets a reply.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [replyId] - The ID of the reply.
   *
   * [includeDeleted] - If set, this will succeed when retrieving a deleted
   * reply.
   *
   * Completes with a [CommentReply].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentReply> get(core.String fileId, core.String commentId, core.String replyId, {core.bool includeDeleted}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }
    if (replyId == null) {
      throw new core.ArgumentError("Parameter replyId is required.");
    }
    if (includeDeleted != null) {
      _queryParams["includeDeleted"] = ["${includeDeleted}"];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId') + '/replies/' + commons.Escaper.ecapeVariable('$replyId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentReply.fromJson(data));
  }

  /**
   * Creates a new reply to the given comment.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * Completes with a [CommentReply].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentReply> insert(CommentReply request, core.String fileId, core.String commentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId') + '/replies';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentReply.fromJson(data));
  }

  /**
   * Lists all of the replies to a comment.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [includeDeleted] - If set, all replies, including deleted replies (with
   * content stripped) will be returned.
   *
   * [maxResults] - The maximum number of replies to include in the response,
   * used for paging.
   * Value must be between "0" and "100".
   *
   * [pageToken] - The continuation token, used to page through large result
   * sets. To get the next page of results, set this parameter to the value of
   * "nextPageToken" from the previous response.
   *
   * Completes with a [CommentReplyList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentReplyList> list(core.String fileId, core.String commentId, {core.bool includeDeleted, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }
    if (includeDeleted != null) {
      _queryParams["includeDeleted"] = ["${includeDeleted}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId') + '/replies';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentReplyList.fromJson(data));
  }

  /**
   * Updates an existing reply. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [replyId] - The ID of the reply.
   *
   * Completes with a [CommentReply].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentReply> patch(CommentReply request, core.String fileId, core.String commentId, core.String replyId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }
    if (replyId == null) {
      throw new core.ArgumentError("Parameter replyId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId') + '/replies/' + commons.Escaper.ecapeVariable('$replyId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentReply.fromJson(data));
  }

  /**
   * Updates an existing reply.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [replyId] - The ID of the reply.
   *
   * Completes with a [CommentReply].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentReply> update(CommentReply request, core.String fileId, core.String commentId, core.String replyId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }
    if (replyId == null) {
      throw new core.ArgumentError("Parameter replyId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId') + '/replies/' + commons.Escaper.ecapeVariable('$replyId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentReply.fromJson(data));
  }

}


class RevisionsResourceApi {
  final commons.ApiRequester _requester;

  RevisionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Removes a revision.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [revisionId] - The ID of the revision.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String fileId, core.String revisionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (revisionId == null) {
      throw new core.ArgumentError("Parameter revisionId is required.");
    }

    _downloadOptions = null;

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/revisions/' + commons.Escaper.ecapeVariable('$revisionId');

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
   * Gets a specific revision.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [revisionId] - The ID of the revision.
   *
   * Completes with a [Revision].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Revision> get(core.String fileId, core.String revisionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (revisionId == null) {
      throw new core.ArgumentError("Parameter revisionId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/revisions/' + commons.Escaper.ecapeVariable('$revisionId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Revision.fromJson(data));
  }

  /**
   * Lists a file's revisions.
   *
   * Request parameters:
   *
   * [fileId] - The ID of the file.
   *
   * [maxResults] - Maximum number of revisions to return.
   * Value must be between "1" and "1000".
   *
   * [pageToken] - Page token for revisions. To get the next page of results,
   * set this parameter to the value of "nextPageToken" from the previous
   * response.
   *
   * Completes with a [RevisionList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RevisionList> list(core.String fileId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/revisions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RevisionList.fromJson(data));
  }

  /**
   * Updates a revision. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID for the file.
   *
   * [revisionId] - The ID for the revision.
   *
   * Completes with a [Revision].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Revision> patch(Revision request, core.String fileId, core.String revisionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (revisionId == null) {
      throw new core.ArgumentError("Parameter revisionId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/revisions/' + commons.Escaper.ecapeVariable('$revisionId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Revision.fromJson(data));
  }

  /**
   * Updates a revision.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [fileId] - The ID for the file.
   *
   * [revisionId] - The ID for the revision.
   *
   * Completes with a [Revision].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Revision> update(Revision request, core.String fileId, core.String revisionId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }
    if (revisionId == null) {
      throw new core.ArgumentError("Parameter revisionId is required.");
    }

    _url = 'files/' + commons.Escaper.ecapeVariable('$fileId') + '/revisions/' + commons.Escaper.ecapeVariable('$revisionId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Revision.fromJson(data));
  }

}


class TeamdrivesResourceApi {
  final commons.ApiRequester _requester;

  TeamdrivesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Permanently deletes a Team Drive for which the user is an organizer. The
   * Team Drive cannot contain any untrashed items.
   *
   * Request parameters:
   *
   * [teamDriveId] - The ID of the Team Drive
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String teamDriveId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (teamDriveId == null) {
      throw new core.ArgumentError("Parameter teamDriveId is required.");
    }

    _downloadOptions = null;

    _url = 'teamdrives/' + commons.Escaper.ecapeVariable('$teamDriveId');

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
   * Gets a Team Drive's metadata by ID.
   *
   * Request parameters:
   *
   * [teamDriveId] - The ID of the Team Drive
   *
   * Completes with a [TeamDrive].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TeamDrive> get(core.String teamDriveId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (teamDriveId == null) {
      throw new core.ArgumentError("Parameter teamDriveId is required.");
    }

    _url = 'teamdrives/' + commons.Escaper.ecapeVariable('$teamDriveId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TeamDrive.fromJson(data));
  }

  /**
   * Creates a new Team Drive.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [requestId] - An ID, such as a random UUID, which uniquely identifies this
   * user's request for idempotent creation of a Team Drive. A repeated request
   * by the same user and with the same request ID will avoid creating
   * duplicates by attempting to create the same Team Drive. If the Team Drive
   * already exists a 409 error will be returned.
   *
   * Completes with a [TeamDrive].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TeamDrive> insert(TeamDrive request, core.String requestId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (requestId == null) {
      throw new core.ArgumentError("Parameter requestId is required.");
    }
    _queryParams["requestId"] = [requestId];

    _url = 'teamdrives';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TeamDrive.fromJson(data));
  }

  /**
   * Lists the user's Team Drives.
   *
   * Request parameters:
   *
   * [maxResults] - Maximum number of Team Drives to return.
   * Value must be between "1" and "100".
   *
   * [pageToken] - Page token for Team Drives.
   *
   * Completes with a [TeamDriveList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TeamDriveList> list({core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'teamdrives';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TeamDriveList.fromJson(data));
  }

  /**
   * Updates a Team Drive's metadata
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [teamDriveId] - The ID of the Team Drive
   *
   * Completes with a [TeamDrive].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TeamDrive> update(TeamDrive request, core.String teamDriveId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert_1.JSON.encode((request).toJson());
    }
    if (teamDriveId == null) {
      throw new core.ArgumentError("Parameter teamDriveId is required.");
    }

    _url = 'teamdrives/' + commons.Escaper.ecapeVariable('$teamDriveId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TeamDrive.fromJson(data));
  }

}



class AboutAdditionalRoleInfoRoleSets {
  /** The supported additional roles with the primary role. */
  core.List<core.String> additionalRoles;
  /** A primary permission role. */
  core.String primaryRole;

  AboutAdditionalRoleInfoRoleSets();

  AboutAdditionalRoleInfoRoleSets.fromJson(core.Map _json) {
    if (_json.containsKey("additionalRoles")) {
      additionalRoles = _json["additionalRoles"];
    }
    if (_json.containsKey("primaryRole")) {
      primaryRole = _json["primaryRole"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (additionalRoles != null) {
      _json["additionalRoles"] = additionalRoles;
    }
    if (primaryRole != null) {
      _json["primaryRole"] = primaryRole;
    }
    return _json;
  }
}

class AboutAdditionalRoleInfo {
  /** The supported additional roles per primary role. */
  core.List<AboutAdditionalRoleInfoRoleSets> roleSets;
  /** The content type that this additional role info applies to. */
  core.String type;

  AboutAdditionalRoleInfo();

  AboutAdditionalRoleInfo.fromJson(core.Map _json) {
    if (_json.containsKey("roleSets")) {
      roleSets = _json["roleSets"].map((value) => new AboutAdditionalRoleInfoRoleSets.fromJson(value)).toList();
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (roleSets != null) {
      _json["roleSets"] = roleSets.map((value) => (value).toJson()).toList();
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class AboutExportFormats {
  /** The content type to convert from. */
  core.String source;
  /** The possible content types to convert to. */
  core.List<core.String> targets;

  AboutExportFormats();

  AboutExportFormats.fromJson(core.Map _json) {
    if (_json.containsKey("source")) {
      source = _json["source"];
    }
    if (_json.containsKey("targets")) {
      targets = _json["targets"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (source != null) {
      _json["source"] = source;
    }
    if (targets != null) {
      _json["targets"] = targets;
    }
    return _json;
  }
}

class AboutFeatures {
  /** The name of the feature. */
  core.String featureName;
  /** The request limit rate for this feature, in queries per second. */
  core.double featureRate;

  AboutFeatures();

  AboutFeatures.fromJson(core.Map _json) {
    if (_json.containsKey("featureName")) {
      featureName = _json["featureName"];
    }
    if (_json.containsKey("featureRate")) {
      featureRate = _json["featureRate"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (featureName != null) {
      _json["featureName"] = featureName;
    }
    if (featureRate != null) {
      _json["featureRate"] = featureRate;
    }
    return _json;
  }
}

class AboutImportFormats {
  /** The imported file's content type to convert from. */
  core.String source;
  /** The possible content types to convert to. */
  core.List<core.String> targets;

  AboutImportFormats();

  AboutImportFormats.fromJson(core.Map _json) {
    if (_json.containsKey("source")) {
      source = _json["source"];
    }
    if (_json.containsKey("targets")) {
      targets = _json["targets"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (source != null) {
      _json["source"] = source;
    }
    if (targets != null) {
      _json["targets"] = targets;
    }
    return _json;
  }
}

class AboutMaxUploadSizes {
  /** The max upload size for this type. */
  core.String size;
  /** The file type. */
  core.String type;

  AboutMaxUploadSizes();

  AboutMaxUploadSizes.fromJson(core.Map _json) {
    if (_json.containsKey("size")) {
      size = _json["size"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (size != null) {
      _json["size"] = size;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class AboutQuotaBytesByService {
  /** The storage quota bytes used by the service. */
  core.String bytesUsed;
  /** The service's name, e.g. DRIVE, GMAIL, or PHOTOS. */
  core.String serviceName;

  AboutQuotaBytesByService();

  AboutQuotaBytesByService.fromJson(core.Map _json) {
    if (_json.containsKey("bytesUsed")) {
      bytesUsed = _json["bytesUsed"];
    }
    if (_json.containsKey("serviceName")) {
      serviceName = _json["serviceName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bytesUsed != null) {
      _json["bytesUsed"] = bytesUsed;
    }
    if (serviceName != null) {
      _json["serviceName"] = serviceName;
    }
    return _json;
  }
}

/** An item with user information and settings. */
class About {
  /**
   * Information about supported additional roles per file type. The most
   * specific type takes precedence.
   */
  core.List<AboutAdditionalRoleInfo> additionalRoleInfo;
  /**
   * The domain sharing policy for the current user. Possible values are:
   * - allowed
   * - allowedWithWarning
   * - incomingOnly
   * - disallowed
   */
  core.String domainSharingPolicy;
  /** The ETag of the item. */
  core.String etag;
  /** The allowable export formats. */
  core.List<AboutExportFormats> exportFormats;
  /** List of additional features enabled on this account. */
  core.List<AboutFeatures> features;
  /** The palette of allowable folder colors as RGB hex strings. */
  core.List<core.String> folderColorPalette;
  /** The allowable import formats. */
  core.List<AboutImportFormats> importFormats;
  /**
   * A boolean indicating whether the authenticated app is installed by the
   * authenticated user.
   */
  core.bool isCurrentAppInstalled;
  /** This is always drive#about. */
  core.String kind;
  /**
   * The user's language or locale code, as defined by BCP 47, with some
   * extensions from Unicode's LDML format
   * (http://www.unicode.org/reports/tr35/).
   */
  core.String languageCode;
  /** The largest change id. */
  core.String largestChangeId;
  /**
   * List of max upload sizes for each file type. The most specific type takes
   * precedence.
   */
  core.List<AboutMaxUploadSizes> maxUploadSizes;
  /** The name of the current user. */
  core.String name;
  /** The current user's ID as visible in the permissions collection. */
  core.String permissionId;
  /** The amount of storage quota used by different Google services. */
  core.List<AboutQuotaBytesByService> quotaBytesByService;
  /** The total number of quota bytes. */
  core.String quotaBytesTotal;
  /** The number of quota bytes used by Google Drive. */
  core.String quotaBytesUsed;
  /**
   * The number of quota bytes used by all Google apps (Drive, Picasa, etc.).
   */
  core.String quotaBytesUsedAggregate;
  /** The number of quota bytes used by trashed items. */
  core.String quotaBytesUsedInTrash;
  /**
   * The type of the user's storage quota. Possible values are:
   * - LIMITED
   * - UNLIMITED
   */
  core.String quotaType;
  /** The number of remaining change ids, limited to no more than 2500. */
  core.String remainingChangeIds;
  /** The id of the root folder. */
  core.String rootFolderId;
  /** A link back to this item. */
  core.String selfLink;
  /** The authenticated user. */
  User user;

  About();

  About.fromJson(core.Map _json) {
    if (_json.containsKey("additionalRoleInfo")) {
      additionalRoleInfo = _json["additionalRoleInfo"].map((value) => new AboutAdditionalRoleInfo.fromJson(value)).toList();
    }
    if (_json.containsKey("domainSharingPolicy")) {
      domainSharingPolicy = _json["domainSharingPolicy"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("exportFormats")) {
      exportFormats = _json["exportFormats"].map((value) => new AboutExportFormats.fromJson(value)).toList();
    }
    if (_json.containsKey("features")) {
      features = _json["features"].map((value) => new AboutFeatures.fromJson(value)).toList();
    }
    if (_json.containsKey("folderColorPalette")) {
      folderColorPalette = _json["folderColorPalette"];
    }
    if (_json.containsKey("importFormats")) {
      importFormats = _json["importFormats"].map((value) => new AboutImportFormats.fromJson(value)).toList();
    }
    if (_json.containsKey("isCurrentAppInstalled")) {
      isCurrentAppInstalled = _json["isCurrentAppInstalled"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("languageCode")) {
      languageCode = _json["languageCode"];
    }
    if (_json.containsKey("largestChangeId")) {
      largestChangeId = _json["largestChangeId"];
    }
    if (_json.containsKey("maxUploadSizes")) {
      maxUploadSizes = _json["maxUploadSizes"].map((value) => new AboutMaxUploadSizes.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("permissionId")) {
      permissionId = _json["permissionId"];
    }
    if (_json.containsKey("quotaBytesByService")) {
      quotaBytesByService = _json["quotaBytesByService"].map((value) => new AboutQuotaBytesByService.fromJson(value)).toList();
    }
    if (_json.containsKey("quotaBytesTotal")) {
      quotaBytesTotal = _json["quotaBytesTotal"];
    }
    if (_json.containsKey("quotaBytesUsed")) {
      quotaBytesUsed = _json["quotaBytesUsed"];
    }
    if (_json.containsKey("quotaBytesUsedAggregate")) {
      quotaBytesUsedAggregate = _json["quotaBytesUsedAggregate"];
    }
    if (_json.containsKey("quotaBytesUsedInTrash")) {
      quotaBytesUsedInTrash = _json["quotaBytesUsedInTrash"];
    }
    if (_json.containsKey("quotaType")) {
      quotaType = _json["quotaType"];
    }
    if (_json.containsKey("remainingChangeIds")) {
      remainingChangeIds = _json["remainingChangeIds"];
    }
    if (_json.containsKey("rootFolderId")) {
      rootFolderId = _json["rootFolderId"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("user")) {
      user = new User.fromJson(_json["user"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (additionalRoleInfo != null) {
      _json["additionalRoleInfo"] = additionalRoleInfo.map((value) => (value).toJson()).toList();
    }
    if (domainSharingPolicy != null) {
      _json["domainSharingPolicy"] = domainSharingPolicy;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (exportFormats != null) {
      _json["exportFormats"] = exportFormats.map((value) => (value).toJson()).toList();
    }
    if (features != null) {
      _json["features"] = features.map((value) => (value).toJson()).toList();
    }
    if (folderColorPalette != null) {
      _json["folderColorPalette"] = folderColorPalette;
    }
    if (importFormats != null) {
      _json["importFormats"] = importFormats.map((value) => (value).toJson()).toList();
    }
    if (isCurrentAppInstalled != null) {
      _json["isCurrentAppInstalled"] = isCurrentAppInstalled;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (languageCode != null) {
      _json["languageCode"] = languageCode;
    }
    if (largestChangeId != null) {
      _json["largestChangeId"] = largestChangeId;
    }
    if (maxUploadSizes != null) {
      _json["maxUploadSizes"] = maxUploadSizes.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (permissionId != null) {
      _json["permissionId"] = permissionId;
    }
    if (quotaBytesByService != null) {
      _json["quotaBytesByService"] = quotaBytesByService.map((value) => (value).toJson()).toList();
    }
    if (quotaBytesTotal != null) {
      _json["quotaBytesTotal"] = quotaBytesTotal;
    }
    if (quotaBytesUsed != null) {
      _json["quotaBytesUsed"] = quotaBytesUsed;
    }
    if (quotaBytesUsedAggregate != null) {
      _json["quotaBytesUsedAggregate"] = quotaBytesUsedAggregate;
    }
    if (quotaBytesUsedInTrash != null) {
      _json["quotaBytesUsedInTrash"] = quotaBytesUsedInTrash;
    }
    if (quotaType != null) {
      _json["quotaType"] = quotaType;
    }
    if (remainingChangeIds != null) {
      _json["remainingChangeIds"] = remainingChangeIds;
    }
    if (rootFolderId != null) {
      _json["rootFolderId"] = rootFolderId;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (user != null) {
      _json["user"] = (user).toJson();
    }
    return _json;
  }
}

class AppIcons {
  /**
   * Category of the icon. Allowed values are:
   * - application - icon for the application
   * - document - icon for a file associated with the app
   * - documentShared - icon for a shared file associated with the app
   */
  core.String category;
  /** URL for the icon. */
  core.String iconUrl;
  /** Size of the icon. Represented as the maximum of the width and height. */
  core.int size;

  AppIcons();

  AppIcons.fromJson(core.Map _json) {
    if (_json.containsKey("category")) {
      category = _json["category"];
    }
    if (_json.containsKey("iconUrl")) {
      iconUrl = _json["iconUrl"];
    }
    if (_json.containsKey("size")) {
      size = _json["size"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (category != null) {
      _json["category"] = category;
    }
    if (iconUrl != null) {
      _json["iconUrl"] = iconUrl;
    }
    if (size != null) {
      _json["size"] = size;
    }
    return _json;
  }
}

/**
 * The apps resource provides a list of the apps that a user has installed, with
 * information about each app's supported MIME types, file extensions, and other
 * details.
 */
class App {
  /** Whether the app is authorized to access data on the user's Drive. */
  core.bool authorized;
  /**
   * The template url to create a new file with this app in a given folder. The
   * template will contain {folderId} to be replaced by the folder to create the
   * new file in.
   */
  core.String createInFolderTemplate;
  /** The url to create a new file with this app. */
  core.String createUrl;
  /**
   * Whether the app has drive-wide scope. An app with drive-wide scope can
   * access all files in the user's drive.
   */
  core.bool hasDriveWideScope;
  /** The various icons for the app. */
  core.List<AppIcons> icons;
  /** The ID of the app. */
  core.String id;
  /** Whether the app is installed. */
  core.bool installed;
  /** This is always drive#app. */
  core.String kind;
  /** A long description of the app. */
  core.String longDescription;
  /** The name of the app. */
  core.String name;
  /**
   * The type of object this app creates (e.g. Chart). If empty, the app name
   * should be used instead.
   */
  core.String objectType;
  /**
   * The template url for opening files with this app. The template will contain
   * {ids} and/or {exportIds} to be replaced by the actual file ids. See  Open
   * Files  for the full documentation.
   */
  core.String openUrlTemplate;
  /** The list of primary file extensions. */
  core.List<core.String> primaryFileExtensions;
  /** The list of primary mime types. */
  core.List<core.String> primaryMimeTypes;
  /** The ID of the product listing for this app. */
  core.String productId;
  /** A link to the product listing for this app. */
  core.String productUrl;
  /** The list of secondary file extensions. */
  core.List<core.String> secondaryFileExtensions;
  /** The list of secondary mime types. */
  core.List<core.String> secondaryMimeTypes;
  /** A short description of the app. */
  core.String shortDescription;
  /** Whether this app supports creating new objects. */
  core.bool supportsCreate;
  /** Whether this app supports importing Google Docs. */
  core.bool supportsImport;
  /** Whether this app supports opening more than one file. */
  core.bool supportsMultiOpen;
  /** Whether this app supports creating new files when offline. */
  core.bool supportsOfflineCreate;
  /**
   * Whether the app is selected as the default handler for the types it
   * supports.
   */
  core.bool useByDefault;

  App();

  App.fromJson(core.Map _json) {
    if (_json.containsKey("authorized")) {
      authorized = _json["authorized"];
    }
    if (_json.containsKey("createInFolderTemplate")) {
      createInFolderTemplate = _json["createInFolderTemplate"];
    }
    if (_json.containsKey("createUrl")) {
      createUrl = _json["createUrl"];
    }
    if (_json.containsKey("hasDriveWideScope")) {
      hasDriveWideScope = _json["hasDriveWideScope"];
    }
    if (_json.containsKey("icons")) {
      icons = _json["icons"].map((value) => new AppIcons.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("installed")) {
      installed = _json["installed"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("longDescription")) {
      longDescription = _json["longDescription"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("objectType")) {
      objectType = _json["objectType"];
    }
    if (_json.containsKey("openUrlTemplate")) {
      openUrlTemplate = _json["openUrlTemplate"];
    }
    if (_json.containsKey("primaryFileExtensions")) {
      primaryFileExtensions = _json["primaryFileExtensions"];
    }
    if (_json.containsKey("primaryMimeTypes")) {
      primaryMimeTypes = _json["primaryMimeTypes"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("productUrl")) {
      productUrl = _json["productUrl"];
    }
    if (_json.containsKey("secondaryFileExtensions")) {
      secondaryFileExtensions = _json["secondaryFileExtensions"];
    }
    if (_json.containsKey("secondaryMimeTypes")) {
      secondaryMimeTypes = _json["secondaryMimeTypes"];
    }
    if (_json.containsKey("shortDescription")) {
      shortDescription = _json["shortDescription"];
    }
    if (_json.containsKey("supportsCreate")) {
      supportsCreate = _json["supportsCreate"];
    }
    if (_json.containsKey("supportsImport")) {
      supportsImport = _json["supportsImport"];
    }
    if (_json.containsKey("supportsMultiOpen")) {
      supportsMultiOpen = _json["supportsMultiOpen"];
    }
    if (_json.containsKey("supportsOfflineCreate")) {
      supportsOfflineCreate = _json["supportsOfflineCreate"];
    }
    if (_json.containsKey("useByDefault")) {
      useByDefault = _json["useByDefault"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (authorized != null) {
      _json["authorized"] = authorized;
    }
    if (createInFolderTemplate != null) {
      _json["createInFolderTemplate"] = createInFolderTemplate;
    }
    if (createUrl != null) {
      _json["createUrl"] = createUrl;
    }
    if (hasDriveWideScope != null) {
      _json["hasDriveWideScope"] = hasDriveWideScope;
    }
    if (icons != null) {
      _json["icons"] = icons.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (installed != null) {
      _json["installed"] = installed;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (longDescription != null) {
      _json["longDescription"] = longDescription;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (objectType != null) {
      _json["objectType"] = objectType;
    }
    if (openUrlTemplate != null) {
      _json["openUrlTemplate"] = openUrlTemplate;
    }
    if (primaryFileExtensions != null) {
      _json["primaryFileExtensions"] = primaryFileExtensions;
    }
    if (primaryMimeTypes != null) {
      _json["primaryMimeTypes"] = primaryMimeTypes;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (productUrl != null) {
      _json["productUrl"] = productUrl;
    }
    if (secondaryFileExtensions != null) {
      _json["secondaryFileExtensions"] = secondaryFileExtensions;
    }
    if (secondaryMimeTypes != null) {
      _json["secondaryMimeTypes"] = secondaryMimeTypes;
    }
    if (shortDescription != null) {
      _json["shortDescription"] = shortDescription;
    }
    if (supportsCreate != null) {
      _json["supportsCreate"] = supportsCreate;
    }
    if (supportsImport != null) {
      _json["supportsImport"] = supportsImport;
    }
    if (supportsMultiOpen != null) {
      _json["supportsMultiOpen"] = supportsMultiOpen;
    }
    if (supportsOfflineCreate != null) {
      _json["supportsOfflineCreate"] = supportsOfflineCreate;
    }
    if (useByDefault != null) {
      _json["useByDefault"] = useByDefault;
    }
    return _json;
  }
}

/**
 * A list of third-party applications which the user has installed or given
 * access to Google Drive.
 */
class AppList {
  /**
   * List of app IDs that the user has specified to use by default. The list is
   * in reverse-priority order (lowest to highest).
   */
  core.List<core.String> defaultAppIds;
  /** The ETag of the list. */
  core.String etag;
  /** The list of apps. */
  core.List<App> items;
  /** This is always drive#appList. */
  core.String kind;
  /** A link back to this list. */
  core.String selfLink;

  AppList();

  AppList.fromJson(core.Map _json) {
    if (_json.containsKey("defaultAppIds")) {
      defaultAppIds = _json["defaultAppIds"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new App.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (defaultAppIds != null) {
      _json["defaultAppIds"] = defaultAppIds;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/** Representation of a change to a file or Team Drive. */
class Change {
  /**
   * Whether the file or Team Drive has been removed from this list of changes,
   * for example by deletion or loss of access.
   */
  core.bool deleted;
  /**
   * The updated state of the file. Present if the type is file and the file has
   * not been removed from this list of changes.
   */
  File file;
  /** The ID of the file associated with this change. */
  core.String fileId;
  /** The ID of the change. */
  core.String id;
  /** This is always drive#change. */
  core.String kind;
  /** The time of this modification. */
  core.DateTime modificationDate;
  /** A link back to this change. */
  core.String selfLink;
  /**
   * The updated state of the Team Drive. Present if the type is teamDrive, the
   * user is still a member of the Team Drive, and the Team Drive has not been
   * deleted.
   */
  TeamDrive teamDrive;
  /** The ID of the Team Drive associated with this change. */
  core.String teamDriveId;
  /** The type of the change. Possible values are file and teamDrive. */
  core.String type;

  Change();

  Change.fromJson(core.Map _json) {
    if (_json.containsKey("deleted")) {
      deleted = _json["deleted"];
    }
    if (_json.containsKey("file")) {
      file = new File.fromJson(_json["file"]);
    }
    if (_json.containsKey("fileId")) {
      fileId = _json["fileId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("modificationDate")) {
      modificationDate = core.DateTime.parse(_json["modificationDate"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("teamDrive")) {
      teamDrive = new TeamDrive.fromJson(_json["teamDrive"]);
    }
    if (_json.containsKey("teamDriveId")) {
      teamDriveId = _json["teamDriveId"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deleted != null) {
      _json["deleted"] = deleted;
    }
    if (file != null) {
      _json["file"] = (file).toJson();
    }
    if (fileId != null) {
      _json["fileId"] = fileId;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (modificationDate != null) {
      _json["modificationDate"] = (modificationDate).toIso8601String();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (teamDrive != null) {
      _json["teamDrive"] = (teamDrive).toJson();
    }
    if (teamDriveId != null) {
      _json["teamDriveId"] = teamDriveId;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** A list of changes for a user. */
class ChangeList {
  /** The ETag of the list. */
  core.String etag;
  /**
   * The list of changes. If nextPageToken is populated, then this list may be
   * incomplete and an additional page of results should be fetched.
   */
  core.List<Change> items;
  /** This is always drive#changeList. */
  core.String kind;
  /** The current largest change ID. */
  core.String largestChangeId;
  /**
   * The starting page token for future changes. This will be present only if
   * the end of the current changes list has been reached.
   */
  core.String newStartPageToken;
  /** A link to the next page of changes. */
  core.String nextLink;
  /**
   * The page token for the next page of changes. This will be absent if the end
   * of the changes list has been reached. If the token is rejected for any
   * reason, it should be discarded, and pagination should be restarted from the
   * first page of results.
   */
  core.String nextPageToken;
  /** A link back to this list. */
  core.String selfLink;

  ChangeList();

  ChangeList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Change.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("largestChangeId")) {
      largestChangeId = _json["largestChangeId"];
    }
    if (_json.containsKey("newStartPageToken")) {
      newStartPageToken = _json["newStartPageToken"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
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
    if (largestChangeId != null) {
      _json["largestChangeId"] = largestChangeId;
    }
    if (newStartPageToken != null) {
      _json["newStartPageToken"] = newStartPageToken;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
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

/** An notification channel used to watch for resource changes. */
class Channel {
  /** The address where notifications are delivered for this channel. */
  core.String address;
  /**
   * Date and time of notification channel expiration, expressed as a Unix
   * timestamp, in milliseconds. Optional.
   */
  core.String expiration;
  /** A UUID or similar unique string that identifies this channel. */
  core.String id;
  /**
   * Identifies this as a notification channel used to watch for changes to a
   * resource. Value: the fixed string "api#channel".
   */
  core.String kind;
  /** Additional parameters controlling delivery channel behavior. Optional. */
  core.Map<core.String, core.String> params;
  /** A Boolean value to indicate whether payload is wanted. Optional. */
  core.bool payload;
  /**
   * An opaque ID that identifies the resource being watched on this channel.
   * Stable across different API versions.
   */
  core.String resourceId;
  /** A version-specific identifier for the watched resource. */
  core.String resourceUri;
  /**
   * An arbitrary string delivered to the target address with each notification
   * delivered over this channel. Optional.
   */
  core.String token;
  /** The type of delivery mechanism used for this channel. */
  core.String type;

  Channel();

  Channel.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = _json["address"];
    }
    if (_json.containsKey("expiration")) {
      expiration = _json["expiration"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("params")) {
      params = _json["params"];
    }
    if (_json.containsKey("payload")) {
      payload = _json["payload"];
    }
    if (_json.containsKey("resourceId")) {
      resourceId = _json["resourceId"];
    }
    if (_json.containsKey("resourceUri")) {
      resourceUri = _json["resourceUri"];
    }
    if (_json.containsKey("token")) {
      token = _json["token"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (address != null) {
      _json["address"] = address;
    }
    if (expiration != null) {
      _json["expiration"] = expiration;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (params != null) {
      _json["params"] = params;
    }
    if (payload != null) {
      _json["payload"] = payload;
    }
    if (resourceId != null) {
      _json["resourceId"] = resourceId;
    }
    if (resourceUri != null) {
      _json["resourceUri"] = resourceUri;
    }
    if (token != null) {
      _json["token"] = token;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** A list of children of a file. */
class ChildList {
  /** The ETag of the list. */
  core.String etag;
  /**
   * The list of children. If nextPageToken is populated, then this list may be
   * incomplete and an additional page of results should be fetched.
   */
  core.List<ChildReference> items;
  /** This is always drive#childList. */
  core.String kind;
  /** A link to the next page of children. */
  core.String nextLink;
  /**
   * The page token for the next page of children. This will be absent if the
   * end of the children list has been reached. If the token is rejected for any
   * reason, it should be discarded, and pagination should be restarted from the
   * first page of results.
   */
  core.String nextPageToken;
  /** A link back to this list. */
  core.String selfLink;

  ChildList();

  ChildList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new ChildReference.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
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
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
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

/** A reference to a folder's child. */
class ChildReference {
  /** A link to the child. */
  core.String childLink;
  /** The ID of the child. */
  core.String id;
  /** This is always drive#childReference. */
  core.String kind;
  /** A link back to this reference. */
  core.String selfLink;

  ChildReference();

  ChildReference.fromJson(core.Map _json) {
    if (_json.containsKey("childLink")) {
      childLink = _json["childLink"];
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
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (childLink != null) {
      _json["childLink"] = childLink;
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
    return _json;
  }
}

/** The context of the file which is being commented on. */
class CommentContext {
  /** The MIME type of the context snippet. */
  core.String type;
  /**
   * Data representation of the segment of the file being commented on. In the
   * case of a text file for example, this would be the actual text that the
   * comment is about.
   */
  core.String value;

  CommentContext();

  CommentContext.fromJson(core.Map _json) {
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (type != null) {
      _json["type"] = type;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** A comment on a file in Google Drive. */
class Comment {
  /**
   * A region of the document represented as a JSON string. See anchor
   * documentation for details on how to define and interpret anchor properties.
   */
  core.String anchor;
  /** The user who wrote this comment. */
  User author;
  /** The ID of the comment. */
  core.String commentId;
  /**
   * The plain text content used to create this comment. This is not HTML safe
   * and should only be used as a starting point to make edits to a comment's
   * content.
   */
  core.String content;
  /** The context of the file which is being commented on. */
  CommentContext context;
  /** The date when this comment was first created. */
  core.DateTime createdDate;
  /**
   * Whether this comment has been deleted. If a comment has been deleted the
   * content will be cleared and this will only represent a comment that once
   * existed.
   */
  core.bool deleted;
  /** The file which this comment is addressing. */
  core.String fileId;
  /** The title of the file which this comment is addressing. */
  core.String fileTitle;
  /** HTML formatted content for this comment. */
  core.String htmlContent;
  /** This is always drive#comment. */
  core.String kind;
  /** The date when this comment or any of its replies were last modified. */
  core.DateTime modifiedDate;
  /** Replies to this post. */
  core.List<CommentReply> replies;
  /** A link back to this comment. */
  core.String selfLink;
  /**
   * The status of this comment. Status can be changed by posting a reply to a
   * comment with the desired status.
   * - "open" - The comment is still open.
   * - "resolved" - The comment has been resolved by one of its replies.
   */
  core.String status;

  Comment();

  Comment.fromJson(core.Map _json) {
    if (_json.containsKey("anchor")) {
      anchor = _json["anchor"];
    }
    if (_json.containsKey("author")) {
      author = new User.fromJson(_json["author"]);
    }
    if (_json.containsKey("commentId")) {
      commentId = _json["commentId"];
    }
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("context")) {
      context = new CommentContext.fromJson(_json["context"]);
    }
    if (_json.containsKey("createdDate")) {
      createdDate = core.DateTime.parse(_json["createdDate"]);
    }
    if (_json.containsKey("deleted")) {
      deleted = _json["deleted"];
    }
    if (_json.containsKey("fileId")) {
      fileId = _json["fileId"];
    }
    if (_json.containsKey("fileTitle")) {
      fileTitle = _json["fileTitle"];
    }
    if (_json.containsKey("htmlContent")) {
      htmlContent = _json["htmlContent"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("modifiedDate")) {
      modifiedDate = core.DateTime.parse(_json["modifiedDate"]);
    }
    if (_json.containsKey("replies")) {
      replies = _json["replies"].map((value) => new CommentReply.fromJson(value)).toList();
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (anchor != null) {
      _json["anchor"] = anchor;
    }
    if (author != null) {
      _json["author"] = (author).toJson();
    }
    if (commentId != null) {
      _json["commentId"] = commentId;
    }
    if (content != null) {
      _json["content"] = content;
    }
    if (context != null) {
      _json["context"] = (context).toJson();
    }
    if (createdDate != null) {
      _json["createdDate"] = (createdDate).toIso8601String();
    }
    if (deleted != null) {
      _json["deleted"] = deleted;
    }
    if (fileId != null) {
      _json["fileId"] = fileId;
    }
    if (fileTitle != null) {
      _json["fileTitle"] = fileTitle;
    }
    if (htmlContent != null) {
      _json["htmlContent"] = htmlContent;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (modifiedDate != null) {
      _json["modifiedDate"] = (modifiedDate).toIso8601String();
    }
    if (replies != null) {
      _json["replies"] = replies.map((value) => (value).toJson()).toList();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/** A list of comments on a file in Google Drive. */
class CommentList {
  /**
   * The list of comments. If nextPageToken is populated, then this list may be
   * incomplete and an additional page of results should be fetched.
   */
  core.List<Comment> items;
  /** This is always drive#commentList. */
  core.String kind;
  /** A link to the next page of comments. */
  core.String nextLink;
  /**
   * The page token for the next page of comments. This will be absent if the
   * end of the comments list has been reached. If the token is rejected for any
   * reason, it should be discarded, and pagination should be restarted from the
   * first page of results.
   */
  core.String nextPageToken;
  /** A link back to this list. */
  core.String selfLink;

  CommentList();

  CommentList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Comment.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
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

/** A comment on a file in Google Drive. */
class CommentReply {
  /** The user who wrote this reply. */
  User author;
  /**
   * The plain text content used to create this reply. This is not HTML safe and
   * should only be used as a starting point to make edits to a reply's content.
   * This field is required on inserts if no verb is specified (resolve/reopen).
   */
  core.String content;
  /** The date when this reply was first created. */
  core.DateTime createdDate;
  /**
   * Whether this reply has been deleted. If a reply has been deleted the
   * content will be cleared and this will only represent a reply that once
   * existed.
   */
  core.bool deleted;
  /** HTML formatted content for this reply. */
  core.String htmlContent;
  /** This is always drive#commentReply. */
  core.String kind;
  /** The date when this reply was last modified. */
  core.DateTime modifiedDate;
  /** The ID of the reply. */
  core.String replyId;
  /**
   * The action this reply performed to the parent comment. When creating a new
   * reply this is the action to be perform to the parent comment. Possible
   * values are:
   * - "resolve" - To resolve a comment.
   * - "reopen" - To reopen (un-resolve) a comment.
   */
  core.String verb;

  CommentReply();

  CommentReply.fromJson(core.Map _json) {
    if (_json.containsKey("author")) {
      author = new User.fromJson(_json["author"]);
    }
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("createdDate")) {
      createdDate = core.DateTime.parse(_json["createdDate"]);
    }
    if (_json.containsKey("deleted")) {
      deleted = _json["deleted"];
    }
    if (_json.containsKey("htmlContent")) {
      htmlContent = _json["htmlContent"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("modifiedDate")) {
      modifiedDate = core.DateTime.parse(_json["modifiedDate"]);
    }
    if (_json.containsKey("replyId")) {
      replyId = _json["replyId"];
    }
    if (_json.containsKey("verb")) {
      verb = _json["verb"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (author != null) {
      _json["author"] = (author).toJson();
    }
    if (content != null) {
      _json["content"] = content;
    }
    if (createdDate != null) {
      _json["createdDate"] = (createdDate).toIso8601String();
    }
    if (deleted != null) {
      _json["deleted"] = deleted;
    }
    if (htmlContent != null) {
      _json["htmlContent"] = htmlContent;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (modifiedDate != null) {
      _json["modifiedDate"] = (modifiedDate).toIso8601String();
    }
    if (replyId != null) {
      _json["replyId"] = replyId;
    }
    if (verb != null) {
      _json["verb"] = verb;
    }
    return _json;
  }
}

/** A list of replies to a comment on a file in Google Drive. */
class CommentReplyList {
  /**
   * The list of replies. If nextPageToken is populated, then this list may be
   * incomplete and an additional page of results should be fetched.
   */
  core.List<CommentReply> items;
  /** This is always drive#commentReplyList. */
  core.String kind;
  /** A link to the next page of replies. */
  core.String nextLink;
  /**
   * The page token for the next page of replies. This will be absent if the end
   * of the replies list has been reached. If the token is rejected for any
   * reason, it should be discarded, and pagination should be restarted from the
   * first page of results.
   */
  core.String nextPageToken;
  /** A link back to this list. */
  core.String selfLink;

  CommentReplyList();

  CommentReplyList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new CommentReply.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
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

/**
 * Capabilities the current user has on the file. Each capability corresponds to
 * a fine-grained action that a user may take.
 */
class FileCapabilities {
  /**
   * Whether the current user can add children to this folder. This is always
   * false when the item is not a folder.
   */
  core.bool canAddChildren;
  /** Whether the current user can comment on the file. */
  core.bool canComment;
  /**
   * Whether the file can be copied by the current user. For a Team Drive item,
   * whether non-folder descendants of this item, or this item itself if it is
   * not a folder, can be copied.
   */
  core.bool canCopy;
  /** Whether the file can be deleted by the current user. */
  core.bool canDelete;
  /** Whether the file can be downloaded by the current user. */
  core.bool canDownload;
  /** Whether the file can be edited by the current user. */
  core.bool canEdit;
  /**
   * Whether the current user can list the children of this folder. This is
   * always false when the item is not a folder.
   */
  core.bool canListChildren;
  /**
   * Whether the current user can move this item into a Team Drive. If the item
   * is in a Team Drive, this field is equivalent to canMoveTeamDriveItem.
   */
  core.bool canMoveItemIntoTeamDrive;
  /**
   * Whether the current user can move this Team Drive item by changing its
   * parent. Note that a request to change the parent for this item may still
   * fail depending on the new parent that is being added. Only populated for
   * Team Drive files.
   */
  core.bool canMoveTeamDriveItem;
  /**
   * Whether the current user has read access to the Revisions resource of the
   * file. For a Team Drive item, whether revisions of non-folder descendants of
   * this item, or this item itself if it is not a folder, can be read.
   */
  core.bool canReadRevisions;
  /**
   * Whether the current user has read access to the Team Drive to which this
   * file belongs. Only populated for Team Drive files.
   */
  core.bool canReadTeamDrive;
  /**
   * Whether the current user can remove children from this folder. This is
   * always false when the item is not a folder.
   */
  core.bool canRemoveChildren;
  /** Whether the file can be renamed by the current user. */
  core.bool canRename;
  /**
   * Whether the file's sharing settings can be modified by the current user.
   */
  core.bool canShare;
  /** Whether the file can be trashed by the current user. */
  core.bool canTrash;
  /** Whether the file can be restored from the trash by the current user. */
  core.bool canUntrash;

  FileCapabilities();

  FileCapabilities.fromJson(core.Map _json) {
    if (_json.containsKey("canAddChildren")) {
      canAddChildren = _json["canAddChildren"];
    }
    if (_json.containsKey("canComment")) {
      canComment = _json["canComment"];
    }
    if (_json.containsKey("canCopy")) {
      canCopy = _json["canCopy"];
    }
    if (_json.containsKey("canDelete")) {
      canDelete = _json["canDelete"];
    }
    if (_json.containsKey("canDownload")) {
      canDownload = _json["canDownload"];
    }
    if (_json.containsKey("canEdit")) {
      canEdit = _json["canEdit"];
    }
    if (_json.containsKey("canListChildren")) {
      canListChildren = _json["canListChildren"];
    }
    if (_json.containsKey("canMoveItemIntoTeamDrive")) {
      canMoveItemIntoTeamDrive = _json["canMoveItemIntoTeamDrive"];
    }
    if (_json.containsKey("canMoveTeamDriveItem")) {
      canMoveTeamDriveItem = _json["canMoveTeamDriveItem"];
    }
    if (_json.containsKey("canReadRevisions")) {
      canReadRevisions = _json["canReadRevisions"];
    }
    if (_json.containsKey("canReadTeamDrive")) {
      canReadTeamDrive = _json["canReadTeamDrive"];
    }
    if (_json.containsKey("canRemoveChildren")) {
      canRemoveChildren = _json["canRemoveChildren"];
    }
    if (_json.containsKey("canRename")) {
      canRename = _json["canRename"];
    }
    if (_json.containsKey("canShare")) {
      canShare = _json["canShare"];
    }
    if (_json.containsKey("canTrash")) {
      canTrash = _json["canTrash"];
    }
    if (_json.containsKey("canUntrash")) {
      canUntrash = _json["canUntrash"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (canAddChildren != null) {
      _json["canAddChildren"] = canAddChildren;
    }
    if (canComment != null) {
      _json["canComment"] = canComment;
    }
    if (canCopy != null) {
      _json["canCopy"] = canCopy;
    }
    if (canDelete != null) {
      _json["canDelete"] = canDelete;
    }
    if (canDownload != null) {
      _json["canDownload"] = canDownload;
    }
    if (canEdit != null) {
      _json["canEdit"] = canEdit;
    }
    if (canListChildren != null) {
      _json["canListChildren"] = canListChildren;
    }
    if (canMoveItemIntoTeamDrive != null) {
      _json["canMoveItemIntoTeamDrive"] = canMoveItemIntoTeamDrive;
    }
    if (canMoveTeamDriveItem != null) {
      _json["canMoveTeamDriveItem"] = canMoveTeamDriveItem;
    }
    if (canReadRevisions != null) {
      _json["canReadRevisions"] = canReadRevisions;
    }
    if (canReadTeamDrive != null) {
      _json["canReadTeamDrive"] = canReadTeamDrive;
    }
    if (canRemoveChildren != null) {
      _json["canRemoveChildren"] = canRemoveChildren;
    }
    if (canRename != null) {
      _json["canRename"] = canRename;
    }
    if (canShare != null) {
      _json["canShare"] = canShare;
    }
    if (canTrash != null) {
      _json["canTrash"] = canTrash;
    }
    if (canUntrash != null) {
      _json["canUntrash"] = canUntrash;
    }
    return _json;
  }
}

/** Geographic location information stored in the image. */
class FileImageMediaMetadataLocation {
  /** The altitude stored in the image. */
  core.double altitude;
  /** The latitude stored in the image. */
  core.double latitude;
  /** The longitude stored in the image. */
  core.double longitude;

  FileImageMediaMetadataLocation();

  FileImageMediaMetadataLocation.fromJson(core.Map _json) {
    if (_json.containsKey("altitude")) {
      altitude = _json["altitude"];
    }
    if (_json.containsKey("latitude")) {
      latitude = _json["latitude"];
    }
    if (_json.containsKey("longitude")) {
      longitude = _json["longitude"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (altitude != null) {
      _json["altitude"] = altitude;
    }
    if (latitude != null) {
      _json["latitude"] = latitude;
    }
    if (longitude != null) {
      _json["longitude"] = longitude;
    }
    return _json;
  }
}

/**
 * Metadata about image media. This will only be present for image types, and
 * its contents will depend on what can be parsed from the image content.
 */
class FileImageMediaMetadata {
  /** The aperture used to create the photo (f-number). */
  core.double aperture;
  /** The make of the camera used to create the photo. */
  core.String cameraMake;
  /** The model of the camera used to create the photo. */
  core.String cameraModel;
  /** The color space of the photo. */
  core.String colorSpace;
  /** The date and time the photo was taken (EXIF format timestamp). */
  core.String date;
  /** The exposure bias of the photo (APEX value). */
  core.double exposureBias;
  /** The exposure mode used to create the photo. */
  core.String exposureMode;
  /** The length of the exposure, in seconds. */
  core.double exposureTime;
  /** Whether a flash was used to create the photo. */
  core.bool flashUsed;
  /** The focal length used to create the photo, in millimeters. */
  core.double focalLength;
  /** The height of the image in pixels. */
  core.int height;
  /** The ISO speed used to create the photo. */
  core.int isoSpeed;
  /** The lens used to create the photo. */
  core.String lens;
  /** Geographic location information stored in the image. */
  FileImageMediaMetadataLocation location;
  /**
   * The smallest f-number of the lens at the focal length used to create the
   * photo (APEX value).
   */
  core.double maxApertureValue;
  /** The metering mode used to create the photo. */
  core.String meteringMode;
  /**
   * The rotation in clockwise degrees from the image's original orientation.
   */
  core.int rotation;
  /** The type of sensor used to create the photo. */
  core.String sensor;
  /** The distance to the subject of the photo, in meters. */
  core.int subjectDistance;
  /** The white balance mode used to create the photo. */
  core.String whiteBalance;
  /** The width of the image in pixels. */
  core.int width;

  FileImageMediaMetadata();

  FileImageMediaMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("aperture")) {
      aperture = _json["aperture"];
    }
    if (_json.containsKey("cameraMake")) {
      cameraMake = _json["cameraMake"];
    }
    if (_json.containsKey("cameraModel")) {
      cameraModel = _json["cameraModel"];
    }
    if (_json.containsKey("colorSpace")) {
      colorSpace = _json["colorSpace"];
    }
    if (_json.containsKey("date")) {
      date = _json["date"];
    }
    if (_json.containsKey("exposureBias")) {
      exposureBias = _json["exposureBias"];
    }
    if (_json.containsKey("exposureMode")) {
      exposureMode = _json["exposureMode"];
    }
    if (_json.containsKey("exposureTime")) {
      exposureTime = _json["exposureTime"];
    }
    if (_json.containsKey("flashUsed")) {
      flashUsed = _json["flashUsed"];
    }
    if (_json.containsKey("focalLength")) {
      focalLength = _json["focalLength"];
    }
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("isoSpeed")) {
      isoSpeed = _json["isoSpeed"];
    }
    if (_json.containsKey("lens")) {
      lens = _json["lens"];
    }
    if (_json.containsKey("location")) {
      location = new FileImageMediaMetadataLocation.fromJson(_json["location"]);
    }
    if (_json.containsKey("maxApertureValue")) {
      maxApertureValue = _json["maxApertureValue"];
    }
    if (_json.containsKey("meteringMode")) {
      meteringMode = _json["meteringMode"];
    }
    if (_json.containsKey("rotation")) {
      rotation = _json["rotation"];
    }
    if (_json.containsKey("sensor")) {
      sensor = _json["sensor"];
    }
    if (_json.containsKey("subjectDistance")) {
      subjectDistance = _json["subjectDistance"];
    }
    if (_json.containsKey("whiteBalance")) {
      whiteBalance = _json["whiteBalance"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aperture != null) {
      _json["aperture"] = aperture;
    }
    if (cameraMake != null) {
      _json["cameraMake"] = cameraMake;
    }
    if (cameraModel != null) {
      _json["cameraModel"] = cameraModel;
    }
    if (colorSpace != null) {
      _json["colorSpace"] = colorSpace;
    }
    if (date != null) {
      _json["date"] = date;
    }
    if (exposureBias != null) {
      _json["exposureBias"] = exposureBias;
    }
    if (exposureMode != null) {
      _json["exposureMode"] = exposureMode;
    }
    if (exposureTime != null) {
      _json["exposureTime"] = exposureTime;
    }
    if (flashUsed != null) {
      _json["flashUsed"] = flashUsed;
    }
    if (focalLength != null) {
      _json["focalLength"] = focalLength;
    }
    if (height != null) {
      _json["height"] = height;
    }
    if (isoSpeed != null) {
      _json["isoSpeed"] = isoSpeed;
    }
    if (lens != null) {
      _json["lens"] = lens;
    }
    if (location != null) {
      _json["location"] = (location).toJson();
    }
    if (maxApertureValue != null) {
      _json["maxApertureValue"] = maxApertureValue;
    }
    if (meteringMode != null) {
      _json["meteringMode"] = meteringMode;
    }
    if (rotation != null) {
      _json["rotation"] = rotation;
    }
    if (sensor != null) {
      _json["sensor"] = sensor;
    }
    if (subjectDistance != null) {
      _json["subjectDistance"] = subjectDistance;
    }
    if (whiteBalance != null) {
      _json["whiteBalance"] = whiteBalance;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/** Indexable text attributes for the file (can only be written) */
class FileIndexableText {
  /** The text to be indexed for this file. */
  core.String text;

  FileIndexableText();

  FileIndexableText.fromJson(core.Map _json) {
    if (_json.containsKey("text")) {
      text = _json["text"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (text != null) {
      _json["text"] = text;
    }
    return _json;
  }
}

/** A group of labels for the file. */
class FileLabels {
  /** Deprecated. */
  core.bool hidden;
  /** Whether the file has been modified by this user. */
  core.bool modified;
  /**
   * Whether viewers and commenters are prevented from downloading, printing,
   * and copying this file.
   */
  core.bool restricted;
  /** Whether this file is starred by the user. */
  core.bool starred;
  /**
   * Whether this file has been trashed. This label applies to all users
   * accessing the file; however, only owners are allowed to see and untrash
   * files.
   */
  core.bool trashed;
  /** Whether this file has been viewed by this user. */
  core.bool viewed;

  FileLabels();

  FileLabels.fromJson(core.Map _json) {
    if (_json.containsKey("hidden")) {
      hidden = _json["hidden"];
    }
    if (_json.containsKey("modified")) {
      modified = _json["modified"];
    }
    if (_json.containsKey("restricted")) {
      restricted = _json["restricted"];
    }
    if (_json.containsKey("starred")) {
      starred = _json["starred"];
    }
    if (_json.containsKey("trashed")) {
      trashed = _json["trashed"];
    }
    if (_json.containsKey("viewed")) {
      viewed = _json["viewed"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (hidden != null) {
      _json["hidden"] = hidden;
    }
    if (modified != null) {
      _json["modified"] = modified;
    }
    if (restricted != null) {
      _json["restricted"] = restricted;
    }
    if (starred != null) {
      _json["starred"] = starred;
    }
    if (trashed != null) {
      _json["trashed"] = trashed;
    }
    if (viewed != null) {
      _json["viewed"] = viewed;
    }
    return _json;
  }
}

/**
 * A thumbnail for the file. This will only be used if Drive cannot generate a
 * standard thumbnail.
 */
class FileThumbnail {
  /**
   * The URL-safe Base64 encoded bytes of the thumbnail image. It should conform
   * to RFC 4648 section 5.
   */
  core.String image;
  core.List<core.int> get imageAsBytes {
    return convert_1.BASE64.decode(image);
  }

  void set imageAsBytes(core.List<core.int> _bytes) {
    image = convert_1.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** The MIME type of the thumbnail. */
  core.String mimeType;

  FileThumbnail();

  FileThumbnail.fromJson(core.Map _json) {
    if (_json.containsKey("image")) {
      image = _json["image"];
    }
    if (_json.containsKey("mimeType")) {
      mimeType = _json["mimeType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (image != null) {
      _json["image"] = image;
    }
    if (mimeType != null) {
      _json["mimeType"] = mimeType;
    }
    return _json;
  }
}

/** Metadata about video media. This will only be present for video types. */
class FileVideoMediaMetadata {
  /** The duration of the video in milliseconds. */
  core.String durationMillis;
  /** The height of the video in pixels. */
  core.int height;
  /** The width of the video in pixels. */
  core.int width;

  FileVideoMediaMetadata();

  FileVideoMediaMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("durationMillis")) {
      durationMillis = _json["durationMillis"];
    }
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (durationMillis != null) {
      _json["durationMillis"] = durationMillis;
    }
    if (height != null) {
      _json["height"] = height;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/** The metadata for a file. */
class File {
  /** A link for opening the file in a relevant Google editor or viewer. */
  core.String alternateLink;
  /** Whether this file is in the Application Data folder. */
  core.bool appDataContents;
  /**
   * Whether the current user can comment on the file. Deprecated: use
   * capabilities/canComment.
   */
  core.bool canComment;
  /**
   * Whether the current user has read access to the Revisions resource of the
   * file. Deprecated: use capabilities/canReadRevisions.
   */
  core.bool canReadRevisions;
  /**
   * Capabilities the current user has on the file. Each capability corresponds
   * to a fine-grained action that a user may take.
   */
  FileCapabilities capabilities;
  /**
   * Whether the file can be copied by the current user. Deprecated: use
   * capabilities/canCopy.
   */
  core.bool copyable;
  /** Create time for this file (formatted RFC 3339 timestamp). */
  core.DateTime createdDate;
  /**
   * A link to open this file with the user's default app for this file. Only
   * populated when the drive.apps.readonly scope is used.
   */
  core.String defaultOpenWithLink;
  /** A short description of the file. */
  core.String description;
  core.String downloadUrl;
  /**
   * Whether the file can be edited by the current user. Deprecated: use
   * capabilities/canEdit.
   */
  core.bool editable;
  /** A link for embedding the file. */
  core.String embedLink;
  /** ETag of the file. */
  core.String etag;
  /**
   * Whether this file has been explicitly trashed, as opposed to recursively
   * trashed.
   */
  core.bool explicitlyTrashed;
  /** Links for exporting Google Docs to specific formats. */
  core.Map<core.String, core.String> exportLinks;
  /**
   * The final component of fullFileExtension with trailing text that does not
   * appear to be part of the extension removed. This field is only populated
   * for files with content stored in Drive; it is not populated for Google Docs
   * or shortcut files.
   */
  core.String fileExtension;
  /**
   * The size of the file in bytes. This field is only populated for files with
   * content stored in Drive; it is not populated for Google Docs or shortcut
   * files.
   */
  core.String fileSize;
  /**
   * Folder color as an RGB hex string if the file is a folder. The list of
   * supported colors is available in the folderColorPalette field of the About
   * resource. If an unsupported color is specified, it will be changed to the
   * closest color in the palette. Not populated for Team Drive files.
   */
  core.String folderColorRgb;
  /**
   * The full file extension; extracted from the title. May contain multiple
   * concatenated extensions, such as "tar.gz". Removing an extension from the
   * title does not clear this field; however, changing the extension on the
   * title does update this field. This field is only populated for files with
   * content stored in Drive; it is not populated for Google Docs or shortcut
   * files.
   */
  core.String fullFileExtension;
  /**
   * Whether any users are granted file access directly on this file. This field
   * is only populated for Team Drive files.
   */
  core.bool hasAugmentedPermissions;
  /** Whether this file has a thumbnail. */
  core.bool hasThumbnail;
  /**
   * The ID of the file's head revision. This field is only populated for files
   * with content stored in Drive; it is not populated for Google Docs or
   * shortcut files.
   */
  core.String headRevisionId;
  /** A link to the file's icon. */
  core.String iconLink;
  /** The ID of the file. */
  core.String id;
  /**
   * Metadata about image media. This will only be present for image types, and
   * its contents will depend on what can be parsed from the image content.
   */
  FileImageMediaMetadata imageMediaMetadata;
  /** Indexable text attributes for the file (can only be written) */
  FileIndexableText indexableText;
  /** Whether the file was created or opened by the requesting app. */
  core.bool isAppAuthorized;
  /** The type of file. This is always drive#file. */
  core.String kind;
  /** A group of labels for the file. */
  FileLabels labels;
  /** The last user to modify this file. */
  User lastModifyingUser;
  /** Name of the last user to modify this file. */
  core.String lastModifyingUserName;
  /**
   * Last time this file was viewed by the user (formatted RFC 3339 timestamp).
   */
  core.DateTime lastViewedByMeDate;
  /** Deprecated. */
  core.DateTime markedViewedByMeDate;
  /**
   * An MD5 checksum for the content of this file. This field is only populated
   * for files with content stored in Drive; it is not populated for Google Docs
   * or shortcut files.
   */
  core.String md5Checksum;
  /**
   * The MIME type of the file. This is only mutable on update when uploading
   * new content. This field can be left blank, and the mimetype will be
   * determined from the uploaded content's MIME type.
   */
  core.String mimeType;
  /**
   * Last time this file was modified by the user (formatted RFC 3339
   * timestamp). Note that setting modifiedDate will also update the
   * modifiedByMe date for the user which set the date.
   */
  core.DateTime modifiedByMeDate;
  /**
   * Last time this file was modified by anyone (formatted RFC 3339 timestamp).
   * This is only mutable on update when the setModifiedDate parameter is set.
   */
  core.DateTime modifiedDate;
  /**
   * A map of the id of each of the user's apps to a link to open this file with
   * that app. Only populated when the drive.apps.readonly scope is used.
   */
  core.Map<core.String, core.String> openWithLinks;
  /**
   * The original filename of the uploaded content if available, or else the
   * original value of the title field. This is only available for files with
   * binary content in Drive.
   */
  core.String originalFilename;
  /**
   * Whether the file is owned by the current user. Not populated for Team Drive
   * files.
   */
  core.bool ownedByMe;
  /**
   * Name(s) of the owner(s) of this file. Not populated for Team Drive files.
   */
  core.List<core.String> ownerNames;
  /** The owner(s) of this file. Not populated for Team Drive files. */
  core.List<User> owners;
  /**
   * Collection of parent folders which contain this file.
   * Setting this field will put the file in all of the provided folders. On
   * insert, if no folders are provided, the file will be placed in the default
   * root folder.
   */
  core.List<ParentReference> parents;
  /**
   * The list of permissions for users with access to this file. Not populated
   * for Team Drive files.
   */
  core.List<Permission> permissions;
  /** The list of properties. */
  core.List<Property> properties;
  /** The number of quota bytes used by this file. */
  core.String quotaBytesUsed;
  /** A link back to this file. */
  core.String selfLink;
  /**
   * Whether the file's sharing settings can be modified by the current user.
   * Deprecated: use capabilities/canShare.
   */
  core.bool shareable;
  /** Whether the file has been shared. Not populated for Team Drive files. */
  core.bool shared;
  /**
   * Time at which this file was shared with the user (formatted RFC 3339
   * timestamp).
   */
  core.DateTime sharedWithMeDate;
  /** User that shared the item with the current user, if available. */
  User sharingUser;
  /**
   * The list of spaces which contain the file. Supported values are 'drive',
   * 'appDataFolder' and 'photos'.
   */
  core.List<core.String> spaces;
  /** ID of the Team Drive the file resides in. */
  core.String teamDriveId;
  /**
   * A thumbnail for the file. This will only be used if Drive cannot generate a
   * standard thumbnail.
   */
  FileThumbnail thumbnail;
  /**
   * A short-lived link to the file's thumbnail. Typically lasts on the order of
   * hours. Only populated when the requesting app can access the file's
   * content.
   */
  core.String thumbnailLink;
  /** The thumbnail version for use in thumbnail cache invalidation. */
  core.String thumbnailVersion;
  /** The title of this file. */
  core.String title;
  /**
   * The time that the item was trashed (formatted RFC 3339 timestamp). Only
   * populated for Team Drive files.
   */
  core.DateTime trashedDate;
  /**
   * If the file has been explicitly trashed, the user who trashed it. Only
   * populated for Team Drive files.
   */
  User trashingUser;
  /** The permissions for the authenticated user on this file. */
  Permission userPermission;
  /**
   * A monotonically increasing version number for the file. This reflects every
   * change made to the file on the server, even those not visible to the
   * requesting user.
   */
  core.String version;
  /** Metadata about video media. This will only be present for video types. */
  FileVideoMediaMetadata videoMediaMetadata;
  /**
   * A link for downloading the content of the file in a browser using cookie
   * based authentication. In cases where the content is shared publicly, the
   * content can be downloaded without any credentials.
   */
  core.String webContentLink;
  /**
   * A link only available on public folders for viewing their static web assets
   * (HTML, CSS, JS, etc) via Google Drive's Website Hosting.
   */
  core.String webViewLink;
  /**
   * Whether writers can share the document with other users. Not populated for
   * Team Drive files.
   */
  core.bool writersCanShare;

  File();

  File.fromJson(core.Map _json) {
    if (_json.containsKey("alternateLink")) {
      alternateLink = _json["alternateLink"];
    }
    if (_json.containsKey("appDataContents")) {
      appDataContents = _json["appDataContents"];
    }
    if (_json.containsKey("canComment")) {
      canComment = _json["canComment"];
    }
    if (_json.containsKey("canReadRevisions")) {
      canReadRevisions = _json["canReadRevisions"];
    }
    if (_json.containsKey("capabilities")) {
      capabilities = new FileCapabilities.fromJson(_json["capabilities"]);
    }
    if (_json.containsKey("copyable")) {
      copyable = _json["copyable"];
    }
    if (_json.containsKey("createdDate")) {
      createdDate = core.DateTime.parse(_json["createdDate"]);
    }
    if (_json.containsKey("defaultOpenWithLink")) {
      defaultOpenWithLink = _json["defaultOpenWithLink"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("downloadUrl")) {
      downloadUrl = _json["downloadUrl"];
    }
    if (_json.containsKey("editable")) {
      editable = _json["editable"];
    }
    if (_json.containsKey("embedLink")) {
      embedLink = _json["embedLink"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("explicitlyTrashed")) {
      explicitlyTrashed = _json["explicitlyTrashed"];
    }
    if (_json.containsKey("exportLinks")) {
      exportLinks = _json["exportLinks"];
    }
    if (_json.containsKey("fileExtension")) {
      fileExtension = _json["fileExtension"];
    }
    if (_json.containsKey("fileSize")) {
      fileSize = _json["fileSize"];
    }
    if (_json.containsKey("folderColorRgb")) {
      folderColorRgb = _json["folderColorRgb"];
    }
    if (_json.containsKey("fullFileExtension")) {
      fullFileExtension = _json["fullFileExtension"];
    }
    if (_json.containsKey("hasAugmentedPermissions")) {
      hasAugmentedPermissions = _json["hasAugmentedPermissions"];
    }
    if (_json.containsKey("hasThumbnail")) {
      hasThumbnail = _json["hasThumbnail"];
    }
    if (_json.containsKey("headRevisionId")) {
      headRevisionId = _json["headRevisionId"];
    }
    if (_json.containsKey("iconLink")) {
      iconLink = _json["iconLink"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("imageMediaMetadata")) {
      imageMediaMetadata = new FileImageMediaMetadata.fromJson(_json["imageMediaMetadata"]);
    }
    if (_json.containsKey("indexableText")) {
      indexableText = new FileIndexableText.fromJson(_json["indexableText"]);
    }
    if (_json.containsKey("isAppAuthorized")) {
      isAppAuthorized = _json["isAppAuthorized"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("labels")) {
      labels = new FileLabels.fromJson(_json["labels"]);
    }
    if (_json.containsKey("lastModifyingUser")) {
      lastModifyingUser = new User.fromJson(_json["lastModifyingUser"]);
    }
    if (_json.containsKey("lastModifyingUserName")) {
      lastModifyingUserName = _json["lastModifyingUserName"];
    }
    if (_json.containsKey("lastViewedByMeDate")) {
      lastViewedByMeDate = core.DateTime.parse(_json["lastViewedByMeDate"]);
    }
    if (_json.containsKey("markedViewedByMeDate")) {
      markedViewedByMeDate = core.DateTime.parse(_json["markedViewedByMeDate"]);
    }
    if (_json.containsKey("md5Checksum")) {
      md5Checksum = _json["md5Checksum"];
    }
    if (_json.containsKey("mimeType")) {
      mimeType = _json["mimeType"];
    }
    if (_json.containsKey("modifiedByMeDate")) {
      modifiedByMeDate = core.DateTime.parse(_json["modifiedByMeDate"]);
    }
    if (_json.containsKey("modifiedDate")) {
      modifiedDate = core.DateTime.parse(_json["modifiedDate"]);
    }
    if (_json.containsKey("openWithLinks")) {
      openWithLinks = _json["openWithLinks"];
    }
    if (_json.containsKey("originalFilename")) {
      originalFilename = _json["originalFilename"];
    }
    if (_json.containsKey("ownedByMe")) {
      ownedByMe = _json["ownedByMe"];
    }
    if (_json.containsKey("ownerNames")) {
      ownerNames = _json["ownerNames"];
    }
    if (_json.containsKey("owners")) {
      owners = _json["owners"].map((value) => new User.fromJson(value)).toList();
    }
    if (_json.containsKey("parents")) {
      parents = _json["parents"].map((value) => new ParentReference.fromJson(value)).toList();
    }
    if (_json.containsKey("permissions")) {
      permissions = _json["permissions"].map((value) => new Permission.fromJson(value)).toList();
    }
    if (_json.containsKey("properties")) {
      properties = _json["properties"].map((value) => new Property.fromJson(value)).toList();
    }
    if (_json.containsKey("quotaBytesUsed")) {
      quotaBytesUsed = _json["quotaBytesUsed"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("shareable")) {
      shareable = _json["shareable"];
    }
    if (_json.containsKey("shared")) {
      shared = _json["shared"];
    }
    if (_json.containsKey("sharedWithMeDate")) {
      sharedWithMeDate = core.DateTime.parse(_json["sharedWithMeDate"]);
    }
    if (_json.containsKey("sharingUser")) {
      sharingUser = new User.fromJson(_json["sharingUser"]);
    }
    if (_json.containsKey("spaces")) {
      spaces = _json["spaces"];
    }
    if (_json.containsKey("teamDriveId")) {
      teamDriveId = _json["teamDriveId"];
    }
    if (_json.containsKey("thumbnail")) {
      thumbnail = new FileThumbnail.fromJson(_json["thumbnail"]);
    }
    if (_json.containsKey("thumbnailLink")) {
      thumbnailLink = _json["thumbnailLink"];
    }
    if (_json.containsKey("thumbnailVersion")) {
      thumbnailVersion = _json["thumbnailVersion"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("trashedDate")) {
      trashedDate = core.DateTime.parse(_json["trashedDate"]);
    }
    if (_json.containsKey("trashingUser")) {
      trashingUser = new User.fromJson(_json["trashingUser"]);
    }
    if (_json.containsKey("userPermission")) {
      userPermission = new Permission.fromJson(_json["userPermission"]);
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
    if (_json.containsKey("videoMediaMetadata")) {
      videoMediaMetadata = new FileVideoMediaMetadata.fromJson(_json["videoMediaMetadata"]);
    }
    if (_json.containsKey("webContentLink")) {
      webContentLink = _json["webContentLink"];
    }
    if (_json.containsKey("webViewLink")) {
      webViewLink = _json["webViewLink"];
    }
    if (_json.containsKey("writersCanShare")) {
      writersCanShare = _json["writersCanShare"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alternateLink != null) {
      _json["alternateLink"] = alternateLink;
    }
    if (appDataContents != null) {
      _json["appDataContents"] = appDataContents;
    }
    if (canComment != null) {
      _json["canComment"] = canComment;
    }
    if (canReadRevisions != null) {
      _json["canReadRevisions"] = canReadRevisions;
    }
    if (capabilities != null) {
      _json["capabilities"] = (capabilities).toJson();
    }
    if (copyable != null) {
      _json["copyable"] = copyable;
    }
    if (createdDate != null) {
      _json["createdDate"] = (createdDate).toIso8601String();
    }
    if (defaultOpenWithLink != null) {
      _json["defaultOpenWithLink"] = defaultOpenWithLink;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (downloadUrl != null) {
      _json["downloadUrl"] = downloadUrl;
    }
    if (editable != null) {
      _json["editable"] = editable;
    }
    if (embedLink != null) {
      _json["embedLink"] = embedLink;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (explicitlyTrashed != null) {
      _json["explicitlyTrashed"] = explicitlyTrashed;
    }
    if (exportLinks != null) {
      _json["exportLinks"] = exportLinks;
    }
    if (fileExtension != null) {
      _json["fileExtension"] = fileExtension;
    }
    if (fileSize != null) {
      _json["fileSize"] = fileSize;
    }
    if (folderColorRgb != null) {
      _json["folderColorRgb"] = folderColorRgb;
    }
    if (fullFileExtension != null) {
      _json["fullFileExtension"] = fullFileExtension;
    }
    if (hasAugmentedPermissions != null) {
      _json["hasAugmentedPermissions"] = hasAugmentedPermissions;
    }
    if (hasThumbnail != null) {
      _json["hasThumbnail"] = hasThumbnail;
    }
    if (headRevisionId != null) {
      _json["headRevisionId"] = headRevisionId;
    }
    if (iconLink != null) {
      _json["iconLink"] = iconLink;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (imageMediaMetadata != null) {
      _json["imageMediaMetadata"] = (imageMediaMetadata).toJson();
    }
    if (indexableText != null) {
      _json["indexableText"] = (indexableText).toJson();
    }
    if (isAppAuthorized != null) {
      _json["isAppAuthorized"] = isAppAuthorized;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (labels != null) {
      _json["labels"] = (labels).toJson();
    }
    if (lastModifyingUser != null) {
      _json["lastModifyingUser"] = (lastModifyingUser).toJson();
    }
    if (lastModifyingUserName != null) {
      _json["lastModifyingUserName"] = lastModifyingUserName;
    }
    if (lastViewedByMeDate != null) {
      _json["lastViewedByMeDate"] = (lastViewedByMeDate).toIso8601String();
    }
    if (markedViewedByMeDate != null) {
      _json["markedViewedByMeDate"] = (markedViewedByMeDate).toIso8601String();
    }
    if (md5Checksum != null) {
      _json["md5Checksum"] = md5Checksum;
    }
    if (mimeType != null) {
      _json["mimeType"] = mimeType;
    }
    if (modifiedByMeDate != null) {
      _json["modifiedByMeDate"] = (modifiedByMeDate).toIso8601String();
    }
    if (modifiedDate != null) {
      _json["modifiedDate"] = (modifiedDate).toIso8601String();
    }
    if (openWithLinks != null) {
      _json["openWithLinks"] = openWithLinks;
    }
    if (originalFilename != null) {
      _json["originalFilename"] = originalFilename;
    }
    if (ownedByMe != null) {
      _json["ownedByMe"] = ownedByMe;
    }
    if (ownerNames != null) {
      _json["ownerNames"] = ownerNames;
    }
    if (owners != null) {
      _json["owners"] = owners.map((value) => (value).toJson()).toList();
    }
    if (parents != null) {
      _json["parents"] = parents.map((value) => (value).toJson()).toList();
    }
    if (permissions != null) {
      _json["permissions"] = permissions.map((value) => (value).toJson()).toList();
    }
    if (properties != null) {
      _json["properties"] = properties.map((value) => (value).toJson()).toList();
    }
    if (quotaBytesUsed != null) {
      _json["quotaBytesUsed"] = quotaBytesUsed;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (shareable != null) {
      _json["shareable"] = shareable;
    }
    if (shared != null) {
      _json["shared"] = shared;
    }
    if (sharedWithMeDate != null) {
      _json["sharedWithMeDate"] = (sharedWithMeDate).toIso8601String();
    }
    if (sharingUser != null) {
      _json["sharingUser"] = (sharingUser).toJson();
    }
    if (spaces != null) {
      _json["spaces"] = spaces;
    }
    if (teamDriveId != null) {
      _json["teamDriveId"] = teamDriveId;
    }
    if (thumbnail != null) {
      _json["thumbnail"] = (thumbnail).toJson();
    }
    if (thumbnailLink != null) {
      _json["thumbnailLink"] = thumbnailLink;
    }
    if (thumbnailVersion != null) {
      _json["thumbnailVersion"] = thumbnailVersion;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (trashedDate != null) {
      _json["trashedDate"] = (trashedDate).toIso8601String();
    }
    if (trashingUser != null) {
      _json["trashingUser"] = (trashingUser).toJson();
    }
    if (userPermission != null) {
      _json["userPermission"] = (userPermission).toJson();
    }
    if (version != null) {
      _json["version"] = version;
    }
    if (videoMediaMetadata != null) {
      _json["videoMediaMetadata"] = (videoMediaMetadata).toJson();
    }
    if (webContentLink != null) {
      _json["webContentLink"] = webContentLink;
    }
    if (webViewLink != null) {
      _json["webViewLink"] = webViewLink;
    }
    if (writersCanShare != null) {
      _json["writersCanShare"] = writersCanShare;
    }
    return _json;
  }
}

/** A list of files. */
class FileList {
  /** The ETag of the list. */
  core.String etag;
  /**
   * Whether the search process was incomplete. If true, then some search
   * results may be missing, since all documents were not searched. This may
   * occur when searching multiple Team Drives with the "default,allTeamDrives"
   * corpora, but all corpora could not be searched. When this happens, it is
   * suggested that clients narrow their query by choosing a different corpus
   * such as "default" or "teamDrive".
   */
  core.bool incompleteSearch;
  /**
   * The list of files. If nextPageToken is populated, then this list may be
   * incomplete and an additional page of results should be fetched.
   */
  core.List<File> items;
  /** This is always drive#fileList. */
  core.String kind;
  /** A link to the next page of files. */
  core.String nextLink;
  /**
   * The page token for the next page of files. This will be absent if the end
   * of the files list has been reached. If the token is rejected for any
   * reason, it should be discarded, and pagination should be restarted from the
   * first page of results.
   */
  core.String nextPageToken;
  /** A link back to this list. */
  core.String selfLink;

  FileList();

  FileList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("incompleteSearch")) {
      incompleteSearch = _json["incompleteSearch"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new File.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (incompleteSearch != null) {
      _json["incompleteSearch"] = incompleteSearch;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
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

/** A list of generated IDs which can be provided in insert requests */
class GeneratedIds {
  /** The IDs generated for the requesting user in the specified space. */
  core.List<core.String> ids;
  /** This is always drive#generatedIds */
  core.String kind;
  /** The type of file that can be created with these IDs. */
  core.String space;

  GeneratedIds();

  GeneratedIds.fromJson(core.Map _json) {
    if (_json.containsKey("ids")) {
      ids = _json["ids"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("space")) {
      space = _json["space"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (ids != null) {
      _json["ids"] = ids;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (space != null) {
      _json["space"] = space;
    }
    return _json;
  }
}

/** A list of a file's parents. */
class ParentList {
  /** The ETag of the list. */
  core.String etag;
  /** The list of parents. */
  core.List<ParentReference> items;
  /** This is always drive#parentList. */
  core.String kind;
  /** A link back to this list. */
  core.String selfLink;

  ParentList();

  ParentList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new ParentReference.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
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
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/** A reference to a file's parent. */
class ParentReference {
  /** The ID of the parent. */
  core.String id;
  /** Whether or not the parent is the root folder. */
  core.bool isRoot;
  /** This is always drive#parentReference. */
  core.String kind;
  /** A link to the parent. */
  core.String parentLink;
  /** A link back to this reference. */
  core.String selfLink;

  ParentReference();

  ParentReference.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("isRoot")) {
      isRoot = _json["isRoot"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("parentLink")) {
      parentLink = _json["parentLink"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (parentLink != null) {
      _json["parentLink"] = parentLink;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

class PermissionTeamDrivePermissionDetails {
  /**
   * Additional roles for this user. Only commenter is currently possible,
   * though more may be supported in the future.
   */
  core.List<core.String> additionalRoles;
  /**
   * Whether this permission is inherited. This field is always populated. This
   * is an output-only field.
   */
  core.bool inherited;
  /**
   * The ID of the item from which this permission is inherited. This is an
   * output-only field and is only populated for members of the Team Drive.
   */
  core.String inheritedFrom;
  /**
   * The primary role for this user. While new values may be added in the
   * future, the following are currently possible:
   * - organizer
   * - reader
   * - writer
   */
  core.String role;
  /**
   * The Team Drive permission type for this user. While new values may be added
   * in future, the following are currently possible:
   * - file
   * - member
   */
  core.String teamDrivePermissionType;

  PermissionTeamDrivePermissionDetails();

  PermissionTeamDrivePermissionDetails.fromJson(core.Map _json) {
    if (_json.containsKey("additionalRoles")) {
      additionalRoles = _json["additionalRoles"];
    }
    if (_json.containsKey("inherited")) {
      inherited = _json["inherited"];
    }
    if (_json.containsKey("inheritedFrom")) {
      inheritedFrom = _json["inheritedFrom"];
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
    if (_json.containsKey("teamDrivePermissionType")) {
      teamDrivePermissionType = _json["teamDrivePermissionType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (additionalRoles != null) {
      _json["additionalRoles"] = additionalRoles;
    }
    if (inherited != null) {
      _json["inherited"] = inherited;
    }
    if (inheritedFrom != null) {
      _json["inheritedFrom"] = inheritedFrom;
    }
    if (role != null) {
      _json["role"] = role;
    }
    if (teamDrivePermissionType != null) {
      _json["teamDrivePermissionType"] = teamDrivePermissionType;
    }
    return _json;
  }
}

/** A permission for a file. */
class Permission {
  /**
   * Additional roles for this user. Only commenter is currently allowed, though
   * more may be supported in the future.
   */
  core.List<core.String> additionalRoles;
  /** The authkey parameter required for this permission. */
  core.String authKey;
  /**
   * The domain name of the entity this permission refers to. This is an
   * output-only field which is present when the permission type is user, group
   * or domain.
   */
  core.String domain;
  /**
   * The email address of the user or group this permission refers to. This is
   * an output-only field which is present when the permission type is user or
   * group.
   */
  core.String emailAddress;
  /** The ETag of the permission. */
  core.String etag;
  /**
   * The time at which this permission will expire (RFC 3339 date-time).
   * Expiration dates have the following restrictions:
   * - They can only be set on user and group permissions
   * - The date must be in the future
   * - The date cannot be more than a year in the future
   * - The date can only be set on drive.permissions.update requests
   */
  core.DateTime expirationDate;
  /**
   * The ID of the user this permission refers to, and identical to the
   * permissionId in the About and Files resources. When making a
   * drive.permissions.insert request, exactly one of the id or value fields
   * must be specified unless the permission type is anyone, in which case both
   * id and value are ignored.
   */
  core.String id;
  /** This is always drive#permission. */
  core.String kind;
  /** The name for this permission. */
  core.String name;
  /** A link to the profile photo, if available. */
  core.String photoLink;
  /**
   * The primary role for this user. While new values may be supported in the
   * future, the following are currently allowed:
   * - organizer
   * - owner
   * - reader
   * - writer
   */
  core.String role;
  /** A link back to this permission. */
  core.String selfLink;
  /**
   * Details of whether the Permissions on this Team Drive item are inherited or
   * directly on this item. This is an output-only field which is present only
   * for Team Drive items.
   */
  core.List<PermissionTeamDrivePermissionDetails> teamDrivePermissionDetails;
  /**
   * The account type. Allowed values are:
   * - user
   * - group
   * - domain
   * - anyone
   */
  core.String type;
  /**
   * The email address or domain name for the entity. This is used during
   * inserts and is not populated in responses. When making a
   * drive.permissions.insert request, exactly one of the id or value fields
   * must be specified unless the permission type is anyone, in which case both
   * id and value are ignored.
   */
  core.String value;
  /** Whether the link is required for this permission. */
  core.bool withLink;

  Permission();

  Permission.fromJson(core.Map _json) {
    if (_json.containsKey("additionalRoles")) {
      additionalRoles = _json["additionalRoles"];
    }
    if (_json.containsKey("authKey")) {
      authKey = _json["authKey"];
    }
    if (_json.containsKey("domain")) {
      domain = _json["domain"];
    }
    if (_json.containsKey("emailAddress")) {
      emailAddress = _json["emailAddress"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("expirationDate")) {
      expirationDate = core.DateTime.parse(_json["expirationDate"]);
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
    if (_json.containsKey("photoLink")) {
      photoLink = _json["photoLink"];
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("teamDrivePermissionDetails")) {
      teamDrivePermissionDetails = _json["teamDrivePermissionDetails"].map((value) => new PermissionTeamDrivePermissionDetails.fromJson(value)).toList();
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
    if (_json.containsKey("withLink")) {
      withLink = _json["withLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (additionalRoles != null) {
      _json["additionalRoles"] = additionalRoles;
    }
    if (authKey != null) {
      _json["authKey"] = authKey;
    }
    if (domain != null) {
      _json["domain"] = domain;
    }
    if (emailAddress != null) {
      _json["emailAddress"] = emailAddress;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (expirationDate != null) {
      _json["expirationDate"] = (expirationDate).toIso8601String();
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
    if (photoLink != null) {
      _json["photoLink"] = photoLink;
    }
    if (role != null) {
      _json["role"] = role;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (teamDrivePermissionDetails != null) {
      _json["teamDrivePermissionDetails"] = teamDrivePermissionDetails.map((value) => (value).toJson()).toList();
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (value != null) {
      _json["value"] = value;
    }
    if (withLink != null) {
      _json["withLink"] = withLink;
    }
    return _json;
  }
}

/** An ID for a user or group as seen in Permission items. */
class PermissionId {
  /** The permission ID. */
  core.String id;
  /** This is always drive#permissionId. */
  core.String kind;

  PermissionId();

  PermissionId.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A list of permissions associated with a file. */
class PermissionList {
  /** The ETag of the list. */
  core.String etag;
  /** The list of permissions. */
  core.List<Permission> items;
  /** This is always drive#permissionList. */
  core.String kind;
  /**
   * The page token for the next page of permissions. This field will be absent
   * if the end of the permissions list has been reached. If the token is
   * rejected for any reason, it should be discarded, and pagination should be
   * restarted from the first page of results.
   */
  core.String nextPageToken;
  /** A link back to this list. */
  core.String selfLink;

  PermissionList();

  PermissionList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Permission.fromJson(value)).toList();
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
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/**
 * A key-value pair attached to a file that is either public or private to an
 * application.
 * The following limits apply to file properties:
 * - Maximum of 100 properties total per file
 * - Maximum of 30 private properties per app
 * - Maximum of 30 public properties
 * - Maximum of 124 bytes size limit on (key + value) string in UTF-8 encoding
 * for a single property.
 */
class Property {
  /** ETag of the property. */
  core.String etag;
  /** The key of this property. */
  core.String key;
  /** This is always drive#property. */
  core.String kind;
  /** The link back to this property. */
  core.String selfLink;
  /** The value of this property. */
  core.String value;
  /** The visibility of this property. */
  core.String visibility;

  Property();

  Property.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
    if (_json.containsKey("visibility")) {
      visibility = _json["visibility"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (key != null) {
      _json["key"] = key;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (value != null) {
      _json["value"] = value;
    }
    if (visibility != null) {
      _json["visibility"] = visibility;
    }
    return _json;
  }
}

/**
 * A collection of properties, key-value pairs that are either public or private
 * to an application.
 */
class PropertyList {
  /** The ETag of the list. */
  core.String etag;
  /** The list of properties. */
  core.List<Property> items;
  /** This is always drive#propertyList. */
  core.String kind;
  /** The link back to this list. */
  core.String selfLink;

  PropertyList();

  PropertyList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Property.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
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
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/** A revision of a file. */
class Revision {
  /**
   * Short term download URL for the file. This will only be populated on files
   * with content stored in Drive.
   */
  core.String downloadUrl;
  /** The ETag of the revision. */
  core.String etag;
  /** Links for exporting Google Docs to specific formats. */
  core.Map<core.String, core.String> exportLinks;
  /**
   * The size of the revision in bytes. This will only be populated on files
   * with content stored in Drive.
   */
  core.String fileSize;
  /** The ID of the revision. */
  core.String id;
  /** This is always drive#revision. */
  core.String kind;
  /** The last user to modify this revision. */
  User lastModifyingUser;
  /** Name of the last user to modify this revision. */
  core.String lastModifyingUserName;
  /**
   * An MD5 checksum for the content of this revision. This will only be
   * populated on files with content stored in Drive.
   */
  core.String md5Checksum;
  /** The MIME type of the revision. */
  core.String mimeType;
  /** Last time this revision was modified (formatted RFC 3339 timestamp). */
  core.DateTime modifiedDate;
  /**
   * The original filename when this revision was created. This will only be
   * populated on files with content stored in Drive.
   */
  core.String originalFilename;
  /**
   * Whether this revision is pinned to prevent automatic purging. This will
   * only be populated and can only be modified on files with content stored in
   * Drive which are not Google Docs. Revisions can also be pinned when they are
   * created through the drive.files.insert/update/copy by using the pinned
   * query parameter.
   */
  core.bool pinned;
  /**
   * Whether subsequent revisions will be automatically republished. This is
   * only populated and can only be modified for Google Docs.
   */
  core.bool publishAuto;
  /**
   * Whether this revision is published. This is only populated and can only be
   * modified for Google Docs.
   */
  core.bool published;
  /** A link to the published revision. */
  core.String publishedLink;
  /**
   * Whether this revision is published outside the domain. This is only
   * populated and can only be modified for Google Docs.
   */
  core.bool publishedOutsideDomain;
  /** A link back to this revision. */
  core.String selfLink;

  Revision();

  Revision.fromJson(core.Map _json) {
    if (_json.containsKey("downloadUrl")) {
      downloadUrl = _json["downloadUrl"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("exportLinks")) {
      exportLinks = _json["exportLinks"];
    }
    if (_json.containsKey("fileSize")) {
      fileSize = _json["fileSize"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastModifyingUser")) {
      lastModifyingUser = new User.fromJson(_json["lastModifyingUser"]);
    }
    if (_json.containsKey("lastModifyingUserName")) {
      lastModifyingUserName = _json["lastModifyingUserName"];
    }
    if (_json.containsKey("md5Checksum")) {
      md5Checksum = _json["md5Checksum"];
    }
    if (_json.containsKey("mimeType")) {
      mimeType = _json["mimeType"];
    }
    if (_json.containsKey("modifiedDate")) {
      modifiedDate = core.DateTime.parse(_json["modifiedDate"]);
    }
    if (_json.containsKey("originalFilename")) {
      originalFilename = _json["originalFilename"];
    }
    if (_json.containsKey("pinned")) {
      pinned = _json["pinned"];
    }
    if (_json.containsKey("publishAuto")) {
      publishAuto = _json["publishAuto"];
    }
    if (_json.containsKey("published")) {
      published = _json["published"];
    }
    if (_json.containsKey("publishedLink")) {
      publishedLink = _json["publishedLink"];
    }
    if (_json.containsKey("publishedOutsideDomain")) {
      publishedOutsideDomain = _json["publishedOutsideDomain"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (downloadUrl != null) {
      _json["downloadUrl"] = downloadUrl;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (exportLinks != null) {
      _json["exportLinks"] = exportLinks;
    }
    if (fileSize != null) {
      _json["fileSize"] = fileSize;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastModifyingUser != null) {
      _json["lastModifyingUser"] = (lastModifyingUser).toJson();
    }
    if (lastModifyingUserName != null) {
      _json["lastModifyingUserName"] = lastModifyingUserName;
    }
    if (md5Checksum != null) {
      _json["md5Checksum"] = md5Checksum;
    }
    if (mimeType != null) {
      _json["mimeType"] = mimeType;
    }
    if (modifiedDate != null) {
      _json["modifiedDate"] = (modifiedDate).toIso8601String();
    }
    if (originalFilename != null) {
      _json["originalFilename"] = originalFilename;
    }
    if (pinned != null) {
      _json["pinned"] = pinned;
    }
    if (publishAuto != null) {
      _json["publishAuto"] = publishAuto;
    }
    if (published != null) {
      _json["published"] = published;
    }
    if (publishedLink != null) {
      _json["publishedLink"] = publishedLink;
    }
    if (publishedOutsideDomain != null) {
      _json["publishedOutsideDomain"] = publishedOutsideDomain;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/** A list of revisions of a file. */
class RevisionList {
  /** The ETag of the list. */
  core.String etag;
  /**
   * The list of revisions. If nextPageToken is populated, then this list may be
   * incomplete and an additional page of results should be fetched.
   */
  core.List<Revision> items;
  /** This is always drive#revisionList. */
  core.String kind;
  /**
   * The page token for the next page of revisions. This field will be absent if
   * the end of the revisions list has been reached. If the token is rejected
   * for any reason, it should be discarded and pagination should be restarted
   * from the first page of results.
   */
  core.String nextPageToken;
  /** A link back to this list. */
  core.String selfLink;

  RevisionList();

  RevisionList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Revision.fromJson(value)).toList();
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
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

class StartPageToken {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "drive#startPageToken".
   */
  core.String kind;
  /** The starting page token for listing changes. */
  core.String startPageToken;

  StartPageToken();

  StartPageToken.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("startPageToken")) {
      startPageToken = _json["startPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (startPageToken != null) {
      _json["startPageToken"] = startPageToken;
    }
    return _json;
  }
}

/** Capabilities the current user has on this Team Drive. */
class TeamDriveCapabilities {
  /**
   * Whether the current user can add children to folders in this Team Drive.
   */
  core.bool canAddChildren;
  /** Whether the current user can comment on files in this Team Drive. */
  core.bool canComment;
  /** Whether files in this Team Drive can be copied by the current user. */
  core.bool canCopy;
  /** Whether this Team Drive can be deleted by the current user. */
  core.bool canDeleteTeamDrive;
  /**
   * Whether files in this Team Drive can be downloaded by the current user.
   */
  core.bool canDownload;
  /** Whether files in this Team Drive can be edited by the current user. */
  core.bool canEdit;
  /**
   * Whether the current user can list the children of folders in this Team
   * Drive.
   */
  core.bool canListChildren;
  /**
   * Whether the current user can add members to this Team Drive or remove them
   * or change their role.
   */
  core.bool canManageMembers;
  /**
   * Whether the current user has read access to the Revisions resource of files
   * in this Team Drive.
   */
  core.bool canReadRevisions;
  /**
   * Whether the current user can remove children from folders in this Team
   * Drive.
   */
  core.bool canRemoveChildren;
  /**
   * Whether files or folders in this Team Drive can be renamed by the current
   * user.
   */
  core.bool canRename;
  /** Whether this Team Drive can be renamed by the current user. */
  core.bool canRenameTeamDrive;
  /**
   * Whether the current user can share files or folders in this Team Drive.
   */
  core.bool canShare;

  TeamDriveCapabilities();

  TeamDriveCapabilities.fromJson(core.Map _json) {
    if (_json.containsKey("canAddChildren")) {
      canAddChildren = _json["canAddChildren"];
    }
    if (_json.containsKey("canComment")) {
      canComment = _json["canComment"];
    }
    if (_json.containsKey("canCopy")) {
      canCopy = _json["canCopy"];
    }
    if (_json.containsKey("canDeleteTeamDrive")) {
      canDeleteTeamDrive = _json["canDeleteTeamDrive"];
    }
    if (_json.containsKey("canDownload")) {
      canDownload = _json["canDownload"];
    }
    if (_json.containsKey("canEdit")) {
      canEdit = _json["canEdit"];
    }
    if (_json.containsKey("canListChildren")) {
      canListChildren = _json["canListChildren"];
    }
    if (_json.containsKey("canManageMembers")) {
      canManageMembers = _json["canManageMembers"];
    }
    if (_json.containsKey("canReadRevisions")) {
      canReadRevisions = _json["canReadRevisions"];
    }
    if (_json.containsKey("canRemoveChildren")) {
      canRemoveChildren = _json["canRemoveChildren"];
    }
    if (_json.containsKey("canRename")) {
      canRename = _json["canRename"];
    }
    if (_json.containsKey("canRenameTeamDrive")) {
      canRenameTeamDrive = _json["canRenameTeamDrive"];
    }
    if (_json.containsKey("canShare")) {
      canShare = _json["canShare"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (canAddChildren != null) {
      _json["canAddChildren"] = canAddChildren;
    }
    if (canComment != null) {
      _json["canComment"] = canComment;
    }
    if (canCopy != null) {
      _json["canCopy"] = canCopy;
    }
    if (canDeleteTeamDrive != null) {
      _json["canDeleteTeamDrive"] = canDeleteTeamDrive;
    }
    if (canDownload != null) {
      _json["canDownload"] = canDownload;
    }
    if (canEdit != null) {
      _json["canEdit"] = canEdit;
    }
    if (canListChildren != null) {
      _json["canListChildren"] = canListChildren;
    }
    if (canManageMembers != null) {
      _json["canManageMembers"] = canManageMembers;
    }
    if (canReadRevisions != null) {
      _json["canReadRevisions"] = canReadRevisions;
    }
    if (canRemoveChildren != null) {
      _json["canRemoveChildren"] = canRemoveChildren;
    }
    if (canRename != null) {
      _json["canRename"] = canRename;
    }
    if (canRenameTeamDrive != null) {
      _json["canRenameTeamDrive"] = canRenameTeamDrive;
    }
    if (canShare != null) {
      _json["canShare"] = canShare;
    }
    return _json;
  }
}

/** Representation of a Team Drive. */
class TeamDrive {
  /** Capabilities the current user has on this Team Drive. */
  TeamDriveCapabilities capabilities;
  /**
   * The ID of this Team Drive which is also the ID of the top level folder for
   * this Team Drive.
   */
  core.String id;
  /** This is always drive#teamDrive */
  core.String kind;
  /** The name of this Team Drive. */
  core.String name;

  TeamDrive();

  TeamDrive.fromJson(core.Map _json) {
    if (_json.containsKey("capabilities")) {
      capabilities = new TeamDriveCapabilities.fromJson(_json["capabilities"]);
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
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (capabilities != null) {
      _json["capabilities"] = (capabilities).toJson();
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
    return _json;
  }
}

/** A list of Team Drives. */
class TeamDriveList {
  /** The list of Team Drives. */
  core.List<TeamDrive> items;
  /** This is always drive#teamDriveList */
  core.String kind;
  /** The page token for the next page of Team Drives. */
  core.String nextPageToken;

  TeamDriveList();

  TeamDriveList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new TeamDrive.fromJson(value)).toList();
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

/** The user's profile picture. */
class UserPicture {
  /** A URL that points to a profile picture of this user. */
  core.String url;

  UserPicture();

  UserPicture.fromJson(core.Map _json) {
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

/** Information about a Drive user. */
class User {
  /** A plain text displayable name for this user. */
  core.String displayName;
  /** The email address of the user. */
  core.String emailAddress;
  /**
   * Whether this user is the same as the authenticated user for whom the
   * request was made.
   */
  core.bool isAuthenticatedUser;
  /** This is always drive#user. */
  core.String kind;
  /** The user's ID as visible in the permissions collection. */
  core.String permissionId;
  /** The user's profile picture. */
  UserPicture picture;

  User();

  User.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("emailAddress")) {
      emailAddress = _json["emailAddress"];
    }
    if (_json.containsKey("isAuthenticatedUser")) {
      isAuthenticatedUser = _json["isAuthenticatedUser"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("permissionId")) {
      permissionId = _json["permissionId"];
    }
    if (_json.containsKey("picture")) {
      picture = new UserPicture.fromJson(_json["picture"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (emailAddress != null) {
      _json["emailAddress"] = emailAddress;
    }
    if (isAuthenticatedUser != null) {
      _json["isAuthenticatedUser"] = isAuthenticatedUser;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (permissionId != null) {
      _json["permissionId"] = permissionId;
    }
    if (picture != null) {
      _json["picture"] = (picture).toJson();
    }
    return _json;
  }
}
