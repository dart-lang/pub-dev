// This is a generated file (see the discoveryapis_generator project).

library googleapis.appstate.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client appstate/v1';

/** The Google App State API. */
class AppstateApi {
  /** View and manage your data for this application */
  static const AppstateScope = "https://www.googleapis.com/auth/appstate";


  final commons.ApiRequester _requester;

  StatesResourceApi get states => new StatesResourceApi(_requester);

  AppstateApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "appstate/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class StatesResourceApi {
  final commons.ApiRequester _requester;

  StatesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Clears (sets to empty) the data for the passed key if and only if the
   * passed version matches the currently stored version. This method results in
   * a conflict error on version mismatch.
   *
   * Request parameters:
   *
   * [stateKey] - The key for the data to be retrieved.
   * Value must be between "0" and "3".
   *
   * [currentDataVersion] - The version of the data to be cleared. Version
   * strings are returned by the server.
   *
   * Completes with a [WriteResult].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<WriteResult> clear(core.int stateKey, {core.String currentDataVersion}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (stateKey == null) {
      throw new core.ArgumentError("Parameter stateKey is required.");
    }
    if (currentDataVersion != null) {
      _queryParams["currentDataVersion"] = [currentDataVersion];
    }

    _url = 'states/' + commons.Escaper.ecapeVariable('$stateKey') + '/clear';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new WriteResult.fromJson(data));
  }

  /**
   * Deletes a key and the data associated with it. The key is removed and no
   * longer counts against the key quota. Note that since this method is not
   * safe in the face of concurrent modifications, it should only be used for
   * development and testing purposes. Invoking this method in shipping code can
   * result in data loss and data corruption.
   *
   * Request parameters:
   *
   * [stateKey] - The key for the data to be retrieved.
   * Value must be between "0" and "3".
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.int stateKey) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (stateKey == null) {
      throw new core.ArgumentError("Parameter stateKey is required.");
    }

    _downloadOptions = null;

    _url = 'states/' + commons.Escaper.ecapeVariable('$stateKey');

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
   * Retrieves the data corresponding to the passed key. If the key does not
   * exist on the server, an HTTP 404 will be returned.
   *
   * Request parameters:
   *
   * [stateKey] - The key for the data to be retrieved.
   * Value must be between "0" and "3".
   *
   * Completes with a [GetResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetResponse> get(core.int stateKey) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (stateKey == null) {
      throw new core.ArgumentError("Parameter stateKey is required.");
    }

    _url = 'states/' + commons.Escaper.ecapeVariable('$stateKey');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetResponse.fromJson(data));
  }

  /**
   * Lists all the states keys, and optionally the state data.
   *
   * Request parameters:
   *
   * [includeData] - Whether to include the full data in addition to the version
   * number
   *
   * Completes with a [ListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListResponse> list({core.bool includeData}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (includeData != null) {
      _queryParams["includeData"] = ["${includeData}"];
    }

    _url = 'states';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListResponse.fromJson(data));
  }

  /**
   * Update the data associated with the input key if and only if the passed
   * version matches the currently stored version. This method is safe in the
   * face of concurrent writes. Maximum per-key size is 128KB.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [stateKey] - The key for the data to be retrieved.
   * Value must be between "0" and "3".
   *
   * [currentStateVersion] - The version of the app state your application is
   * attempting to update. If this does not match the current version, this
   * method will return a conflict error. If there is no data stored on the
   * server for this key, the update will succeed irrespective of the value of
   * this parameter.
   *
   * Completes with a [WriteResult].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<WriteResult> update(UpdateRequest request, core.int stateKey, {core.String currentStateVersion}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (stateKey == null) {
      throw new core.ArgumentError("Parameter stateKey is required.");
    }
    if (currentStateVersion != null) {
      _queryParams["currentStateVersion"] = [currentStateVersion];
    }

    _url = 'states/' + commons.Escaper.ecapeVariable('$stateKey');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new WriteResult.fromJson(data));
  }

}



/** This is a JSON template for an app state resource. */
class GetResponse {
  /** The current app state version. */
  core.String currentStateVersion;
  /** The requested data. */
  core.String data;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string appstate#getResponse.
   */
  core.String kind;
  /** The key for the data. */
  core.int stateKey;

  GetResponse();

  GetResponse.fromJson(core.Map _json) {
    if (_json.containsKey("currentStateVersion")) {
      currentStateVersion = _json["currentStateVersion"];
    }
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("stateKey")) {
      stateKey = _json["stateKey"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currentStateVersion != null) {
      _json["currentStateVersion"] = currentStateVersion;
    }
    if (data != null) {
      _json["data"] = data;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (stateKey != null) {
      _json["stateKey"] = stateKey;
    }
    return _json;
  }
}

/** This is a JSON template to convert a list-response for app state. */
class ListResponse {
  /** The app state data. */
  core.List<GetResponse> items;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string appstate#listResponse.
   */
  core.String kind;
  /** The maximum number of keys allowed for this user. */
  core.int maximumKeyCount;

  ListResponse();

  ListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new GetResponse.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("maximumKeyCount")) {
      maximumKeyCount = _json["maximumKeyCount"];
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
    if (maximumKeyCount != null) {
      _json["maximumKeyCount"] = maximumKeyCount;
    }
    return _json;
  }
}

/** This is a JSON template for a requests which update app state */
class UpdateRequest {
  /** The new app state data that your application is trying to update with. */
  core.String data;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string appstate#updateRequest.
   */
  core.String kind;

  UpdateRequest();

  UpdateRequest.fromJson(core.Map _json) {
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (data != null) {
      _json["data"] = data;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** This is a JSON template for an app state write result. */
class WriteResult {
  /** The version of the data for this key on the server. */
  core.String currentStateVersion;
  /**
   * Uniquely identifies the type of this resource. Value is always the fixed
   * string appstate#writeResult.
   */
  core.String kind;
  /** The written key. */
  core.int stateKey;

  WriteResult();

  WriteResult.fromJson(core.Map _json) {
    if (_json.containsKey("currentStateVersion")) {
      currentStateVersion = _json["currentStateVersion"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("stateKey")) {
      stateKey = _json["stateKey"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currentStateVersion != null) {
      _json["currentStateVersion"] = currentStateVersion;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (stateKey != null) {
      _json["stateKey"] = stateKey;
    }
    return _json;
  }
}
