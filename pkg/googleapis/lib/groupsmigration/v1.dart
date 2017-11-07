// This is a generated file (see the discoveryapis_generator project).

library googleapis.groupsmigration.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client groupsmigration/v1';

/** Groups Migration Api. */
class GroupsmigrationApi {
  /** Manage messages in groups on your domain */
  static const AppsGroupsMigrationScope = "https://www.googleapis.com/auth/apps.groups.migration";


  final commons.ApiRequester _requester;

  ArchiveResourceApi get archive => new ArchiveResourceApi(_requester);

  GroupsmigrationApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "groups/v1/groups/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ArchiveResourceApi {
  final commons.ApiRequester _requester;

  ArchiveResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Inserts a new mail into the archive of the Google group.
   *
   * Request parameters:
   *
   * [groupId] - The group ID
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [Groups].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Groups> insert(core.String groupId, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (groupId == null) {
      throw new core.ArgumentError("Parameter groupId is required.");
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = commons.Escaper.ecapeVariable('$groupId') + '/archive';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/groups/v1/groups/' + commons.Escaper.ecapeVariable('$groupId') + '/archive';
    } else {
      _url = '/upload/groups/v1/groups/' + commons.Escaper.ecapeVariable('$groupId') + '/archive';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Groups.fromJson(data));
  }

}



/** JSON response template for groups migration API. */
class Groups {
  /** The kind of insert resource this is. */
  core.String kind;
  /** The status of the insert request. */
  core.String responseCode;

  Groups();

  Groups.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("responseCode")) {
      responseCode = _json["responseCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (responseCode != null) {
      _json["responseCode"] = responseCode;
    }
    return _json;
  }
}
