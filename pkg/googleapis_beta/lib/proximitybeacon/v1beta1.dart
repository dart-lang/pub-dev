// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.proximitybeacon.v1beta1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client proximitybeacon/v1beta1';

/// Registers, manages, indexes, and searches beacons.
class ProximitybeaconApi {
  /// View and modify your beacons
  static const UserlocationBeaconRegistryScope =
      "https://www.googleapis.com/auth/userlocation.beacon.registry";

  final commons.ApiRequester _requester;

  BeaconinfoResourceApi get beaconinfo => new BeaconinfoResourceApi(_requester);
  BeaconsResourceApi get beacons => new BeaconsResourceApi(_requester);
  NamespacesResourceApi get namespaces => new NamespacesResourceApi(_requester);
  V1beta1ResourceApi get v1beta1 => new V1beta1ResourceApi(_requester);

  ProximitybeaconApi(http.Client client,
      {core.String rootUrl: "https://proximitybeacon.googleapis.com/",
      core.String servicePath: ""})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class BeaconinfoResourceApi {
  final commons.ApiRequester _requester;

  BeaconinfoResourceApi(commons.ApiRequester client) : _requester = client;

  /// Given one or more beacon observations, returns any beacon information
  /// and attachments accessible to your application. Authorize by using the
  /// [API
  /// key](https://developers.google.com/beacons/proximity/get-started#request_a_browser_api_key)
  /// for the application.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// Completes with a [GetInfoForObservedBeaconsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GetInfoForObservedBeaconsResponse> getforobserved(
      GetInfoForObservedBeaconsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1beta1/beaconinfo:getforobserved';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new GetInfoForObservedBeaconsResponse.fromJson(data));
  }
}

class BeaconsResourceApi {
  final commons.ApiRequester _requester;

  BeaconsAttachmentsResourceApi get attachments =>
      new BeaconsAttachmentsResourceApi(_requester);
  BeaconsDiagnosticsResourceApi get diagnostics =>
      new BeaconsDiagnosticsResourceApi(_requester);

  BeaconsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Activates a beacon. A beacon that is active will return information
  /// and attachment data when queried via `beaconinfo.getforobserved`.
  /// Calling this method on an already active beacon will do nothing (but
  /// will return a successful response code).
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **Is owner** or **Can edit** permissions in the
  /// Google Developers Console project.
  ///
  /// Request parameters:
  ///
  /// [beaconName] - Beacon that should be activated. A beacon name has the
  /// format
  /// "beacons/N!beaconId" where the beaconId is the base16 ID broadcast by
  /// the beacon and N is a code for the beacon's type. Possible values are
  /// `3` for Eddystone-UID, `4` for Eddystone-EID, `1` for iBeacon, or `5`
  /// for AltBeacon. For Eddystone-EID beacons, you may use either the
  /// current EID or the beacon's "stable" UID.
  /// Required.
  /// Value must have pattern "^beacons/[^/]+$".
  ///
  /// [projectId] - The project id of the beacon to activate. If the project id
  /// is not
  /// specified then the project making the request is used. The project id
  /// must match the project that owns the beacon.
  /// Optional.
  ///
  /// Completes with a [Empty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Empty> activate(core.String beaconName,
      {core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (beaconName == null) {
      throw new core.ArgumentError("Parameter beaconName is required.");
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/' +
        commons.Escaper.ecapeVariableReserved('$beaconName') +
        ':activate';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /// Deactivates a beacon. Once deactivated, the API will not return
  /// information nor attachment data for the beacon when queried via
  /// `beaconinfo.getforobserved`. Calling this method on an already inactive
  /// beacon will do nothing (but will return a successful response code).
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **Is owner** or **Can edit** permissions in the
  /// Google Developers Console project.
  ///
  /// Request parameters:
  ///
  /// [beaconName] - Beacon that should be deactivated. A beacon name has the
  /// format
  /// "beacons/N!beaconId" where the beaconId is the base16 ID broadcast by
  /// the beacon and N is a code for the beacon's type. Possible values are
  /// `3` for Eddystone-UID, `4` for Eddystone-EID, `1` for iBeacon, or `5`
  /// for AltBeacon. For Eddystone-EID beacons, you may use either the
  /// current EID or the beacon's "stable" UID.
  /// Required.
  /// Value must have pattern "^beacons/[^/]+$".
  ///
  /// [projectId] - The project id of the beacon to deactivate. If the project
  /// id is not
  /// specified then the project making the request is used. The project id must
  /// match the project that owns the beacon.
  /// Optional.
  ///
  /// Completes with a [Empty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Empty> deactivate(core.String beaconName,
      {core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (beaconName == null) {
      throw new core.ArgumentError("Parameter beaconName is required.");
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/' +
        commons.Escaper.ecapeVariableReserved('$beaconName') +
        ':deactivate';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /// Decommissions the specified beacon in the service. This beacon will no
  /// longer be returned from `beaconinfo.getforobserved`. This operation is
  /// permanent -- you will not be able to re-register a beacon with this ID
  /// again.
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **Is owner** or **Can edit** permissions in the
  /// Google Developers Console project.
  ///
  /// Request parameters:
  ///
  /// [beaconName] - Beacon that should be decommissioned. A beacon name has the
  /// format
  /// "beacons/N!beaconId" where the beaconId is the base16 ID broadcast by
  /// the beacon and N is a code for the beacon's type. Possible values are
  /// `3` for Eddystone-UID, `4` for Eddystone-EID, `1` for iBeacon, or `5`
  /// for AltBeacon. For Eddystone-EID beacons, you may use either the
  /// current EID of the beacon's "stable" UID.
  /// Required.
  /// Value must have pattern "^beacons/[^/]+$".
  ///
  /// [projectId] - The project id of the beacon to decommission. If the project
  /// id is not
  /// specified then the project making the request is used. The project id
  /// must match the project that owns the beacon.
  /// Optional.
  ///
  /// Completes with a [Empty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Empty> decommission(core.String beaconName,
      {core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (beaconName == null) {
      throw new core.ArgumentError("Parameter beaconName is required.");
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/' +
        commons.Escaper.ecapeVariableReserved('$beaconName') +
        ':decommission';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /// Deletes the specified beacon including all diagnostics data for the beacon
  /// as well as any attachments on the beacon (including those belonging to
  /// other projects). This operation cannot be undone.
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **Is owner** or **Can edit** permissions in the
  /// Google Developers Console project.
  ///
  /// Request parameters:
  ///
  /// [beaconName] - Beacon that should be deleted. A beacon name has the format
  /// "beacons/N!beaconId" where the beaconId is the base16 ID broadcast by
  /// the beacon and N is a code for the beacon's type. Possible values are
  /// `3` for Eddystone-UID, `4` for Eddystone-EID, `1` for iBeacon, or `5`
  /// for AltBeacon. For Eddystone-EID beacons, you may use either the
  /// current EID or the beacon's "stable" UID.
  /// Required.
  /// Value must have pattern "^beacons/[^/]+$".
  ///
  /// [projectId] - The project id of the beacon to delete. If not provided, the
  /// project
  /// that is making the request is used.
  /// Optional.
  ///
  /// Completes with a [Empty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Empty> delete(core.String beaconName, {core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (beaconName == null) {
      throw new core.ArgumentError("Parameter beaconName is required.");
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/' + commons.Escaper.ecapeVariableReserved('$beaconName');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /// Returns detailed information about the specified beacon.
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **viewer**, **Is owner** or **Can edit**
  /// permissions in the Google Developers Console project.
  ///
  /// Requests may supply an Eddystone-EID beacon name in the form:
  /// `beacons/4!beaconId` where the `beaconId` is the base16 ephemeral ID
  /// broadcast by the beacon. The returned `Beacon` object will contain the
  /// beacon's stable Eddystone-UID. Clients not authorized to resolve the
  /// beacon's ephemeral Eddystone-EID broadcast will receive an error.
  ///
  /// Request parameters:
  ///
  /// [beaconName] - Resource name of this beacon. A beacon name has the format
  /// "beacons/N!beaconId" where the beaconId is the base16 ID broadcast by
  /// the beacon and N is a code for the beacon's type. Possible values are
  /// `3` for Eddystone-UID, `4` for Eddystone-EID, `1` for iBeacon, or `5`
  /// for AltBeacon. For Eddystone-EID beacons, you may use either the
  /// current EID or the beacon's "stable" UID.
  /// Required.
  /// Value must have pattern "^beacons/[^/]+$".
  ///
  /// [projectId] - The project id of the beacon to request. If the project id
  /// is not specified
  /// then the project making the request is used. The project id must match the
  /// project that owns the beacon.
  /// Optional.
  ///
  /// Completes with a [Beacon].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Beacon> get(core.String beaconName, {core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (beaconName == null) {
      throw new core.ArgumentError("Parameter beaconName is required.");
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/' + commons.Escaper.ecapeVariableReserved('$beaconName');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Beacon.fromJson(data));
  }

  /// Searches the beacon registry for beacons that match the given search
  /// criteria. Only those beacons that the client has permission to list
  /// will be returned.
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **viewer**, **Is owner** or **Can edit**
  /// permissions in the Google Developers Console project.
  ///
  /// Request parameters:
  ///
  /// [pageToken] - A pagination token obtained from a previous request to list
  /// beacons.
  ///
  /// [pageSize] - The maximum number of records to return for this request, up
  /// to a
  /// server-defined upper limit.
  ///
  /// [q] - Filter query string that supports the following field filters:
  ///
  /// * **description:`"<string>"`**
  ///   For example: **description:"Room 3"**
  ///   Returns beacons whose description matches tokens in the string "Room 3"
  ///   (not necessarily that exact string).
  ///   The string must be double-quoted.
  /// * **status:`<enum>`**
  ///   For example: **status:active**
  ///   Returns beacons whose status matches the given value. Values must be
  ///   one of the Beacon.Status enum values (case insensitive). Accepts
  ///   multiple filters which will be combined with OR logic.
  /// * **stability:`<enum>`**
  ///   For example: **stability:mobile**
  ///   Returns beacons whose expected stability matches the given value.
  ///   Values must be one of the Beacon.Stability enum values (case
  ///   insensitive). Accepts multiple filters which will be combined with
  ///   OR logic.
  /// * **place\_id:`"<string>"`**
  ///   For example: **place\_id:"ChIJVSZzVR8FdkgRXGmmm6SslKw="**
  ///   Returns beacons explicitly registered at the given place, expressed as
  /// a Place ID obtained from [Google Places API](/places/place-id). Does not
  ///   match places inside the given place. Does not consider the beacon's
  ///   actual location (which may be different from its registered place).
  ///   Accepts multiple filters that will be combined with OR logic. The place
  ///   ID must be double-quoted.
  /// * **registration\_time`[<|>|<=|>=]<integer>`**
  ///   For example: **registration\_time>=1433116800**
  ///   Returns beacons whose registration time matches the given filter.
  /// Supports the operators: <, >, <=, and >=. Timestamp must be expressed as
  /// an integer number of seconds since midnight January 1, 1970 UTC. Accepts
  ///   at most two filters that will be combined with AND logic, to support
  ///   "between" semantics. If more than two are supplied, the latter ones are
  ///   ignored.
  /// * **lat:`<double> lng:<double> radius:<integer>`**
  ///   For example: **lat:51.1232343 lng:-1.093852 radius:1000**
  ///   Returns beacons whose registered location is within the given circle.
  ///   When any of these fields are given, all are required. Latitude and
  ///   longitude must be decimal degrees between -90.0 and 90.0 and between
  ///   -180.0 and 180.0 respectively. Radius must be an integer number of
  ///   meters between 10 and 1,000,000 (1000 km).
  /// * **property:`"<string>=<string>"`**
  ///   For example: **property:"battery-type=CR2032"**
  ///   Returns beacons which have a property of the given name and value.
  ///   Supports multiple filters which will be combined with OR logic.
  ///   The entire name=value string must be double-quoted as one string.
  /// * **attachment\_type:`"<string>"`**
  ///   For example: **attachment_type:"my-namespace/my-type"**
  ///   Returns beacons having at least one attachment of the given namespaced
  ///   type. Supports "any within this namespace" via the partial wildcard
  ///   syntax: "my-namespace / * ". Supports multiple filters which will be
  ///   combined with OR logic. The string must be double-quoted.
  /// * **indoor\_level:`"<string>"`**
  ///   For example: **indoor\_level:"1"**
  ///   Returns beacons which are located on the given indoor level. Accepts
  ///   multiple filters that will be combined with OR logic.
  ///
  /// Multiple filters on the same field are combined with OR logic (except
  /// registration_time which is combined with AND logic).
  /// Multiple filters on different fields are combined with AND logic.
  /// Filters should be separated by spaces.
  ///
  /// As with any HTTP query string parameter, the whole filter expression must
  /// be URL-encoded.
  ///
  /// Example REST request:
  /// `GET
  /// /v1beta1/beacons?q=status:active%20lat:51.123%20lng:-1.095%20radius:1000`
  ///
  /// [projectId] - The project id to list beacons under. If not present then
  /// the project
  /// credential that made the request is used as the project.
  /// Optional.
  ///
  /// Completes with a [ListBeaconsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListBeaconsResponse> list(
      {core.String pageToken,
      core.int pageSize,
      core.String q,
      core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (q != null) {
      _queryParams["q"] = [q];
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/beacons';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListBeaconsResponse.fromJson(data));
  }

  /// Registers a previously unregistered beacon given its `advertisedId`.
  /// These IDs are unique within the system. An ID can be registered only once.
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **Is owner** or **Can edit** permissions in the
  /// Google Developers Console project.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project id of the project the beacon will be registered
  /// to. If
  /// the project id is not specified then the project making the request
  /// is used.
  /// Optional.
  ///
  /// Completes with a [Beacon].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Beacon> register(Beacon request, {core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/beacons:register';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Beacon.fromJson(data));
  }

  /// Updates the information about the specified beacon. **Any field that you
  /// do
  /// not populate in the submitted beacon will be permanently erased**, so you
  /// should follow the "read, modify, write" pattern to avoid inadvertently
  /// destroying data.
  ///
  /// Changes to the beacon status via this method will be  silently ignored.
  /// To update beacon status, use the separate methods on this API for
  /// activation, deactivation, and decommissioning.
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **Is owner** or **Can edit** permissions in the
  /// Google Developers Console project.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [beaconName] - Resource name of this beacon. A beacon name has the format
  /// "beacons/N!beaconId" where the beaconId is the base16 ID broadcast by
  /// the beacon and N is a code for the beacon's type. Possible values are
  /// `3` for Eddystone, `1` for iBeacon, or `5` for AltBeacon.
  ///
  /// This field must be left empty when registering. After reading a beacon,
  /// clients can use the name for future operations.
  /// Value must have pattern "^beacons/[^/]+$".
  ///
  /// [projectId] - The project id of the beacon to update. If the project id is
  /// not
  /// specified then the project making the request is used. The project id
  /// must match the project that owns the beacon.
  /// Optional.
  ///
  /// Completes with a [Beacon].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Beacon> update(Beacon request, core.String beaconName,
      {core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (beaconName == null) {
      throw new core.ArgumentError("Parameter beaconName is required.");
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/' + commons.Escaper.ecapeVariableReserved('$beaconName');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Beacon.fromJson(data));
  }
}

class BeaconsAttachmentsResourceApi {
  final commons.ApiRequester _requester;

  BeaconsAttachmentsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Deletes multiple attachments on a given beacon. This operation is
  /// permanent and cannot be undone.
  ///
  /// You can optionally specify `namespacedType` to choose which attachments
  /// should be deleted. If you do not specify `namespacedType`,  all your
  /// attachments on the given beacon will be deleted. You also may explicitly
  /// specify `* / * ` to delete all.
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **Is owner** or **Can edit** permissions in the
  /// Google Developers Console project.
  ///
  /// Request parameters:
  ///
  /// [beaconName] - The beacon whose attachments should be deleted. A beacon
  /// name has the
  /// format "beacons/N!beaconId" where the beaconId is the base16 ID broadcast
  /// by the beacon and N is a code for the beacon's type. Possible values are
  /// `3` for Eddystone-UID, `4` for Eddystone-EID, `1` for iBeacon, or `5`
  /// for AltBeacon. For Eddystone-EID beacons, you may use either the
  /// current EID or the beacon's "stable" UID.
  /// Required.
  /// Value must have pattern "^beacons/[^/]+$".
  ///
  /// [projectId] - The project id to delete beacon attachments under. This
  /// field can be
  /// used when "*" is specified to mean all attachment namespaces. Projects
  /// may have multiple attachments with multiple namespaces. If "*" is
  /// specified and the projectId string is empty, then the project
  /// making the request is used.
  /// Optional.
  ///
  /// [namespacedType] - Specifies the namespace and type of attachments to
  /// delete in
  /// `namespace/type` format. Accepts `* / * ` to specify
  /// "all types in all namespaces".
  /// Optional.
  ///
  /// Completes with a [DeleteAttachmentsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<DeleteAttachmentsResponse> batchDelete(core.String beaconName,
      {core.String projectId, core.String namespacedType}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (beaconName == null) {
      throw new core.ArgumentError("Parameter beaconName is required.");
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }
    if (namespacedType != null) {
      _queryParams["namespacedType"] = [namespacedType];
    }

    _url = 'v1beta1/' +
        commons.Escaper.ecapeVariableReserved('$beaconName') +
        '/attachments:batchDelete';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new DeleteAttachmentsResponse.fromJson(data));
  }

  /// Associates the given data with the specified beacon. Attachment data must
  /// contain two parts:
  /// <ul>
  /// <li>A namespaced type.</li>
  /// <li>The actual attachment data itself.</li>
  /// </ul>
  /// The namespaced type consists of two parts, the namespace and the type.
  /// The namespace must be one of the values returned by the `namespaces`
  /// endpoint, while the type can be a string of any characters except for the
  /// forward slash (`/`) up to 100 characters in length.
  ///
  /// Attachment data can be up to 1024 bytes long.
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **Is owner** or **Can edit** permissions in the
  /// Google Developers Console project.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [beaconName] - Beacon on which the attachment should be created. A beacon
  /// name has the
  /// format "beacons/N!beaconId" where the beaconId is the base16 ID broadcast
  /// by the beacon and N is a code for the beacon's type. Possible values are
  /// `3` for Eddystone-UID, `4` for Eddystone-EID, `1` for iBeacon, or `5`
  /// for AltBeacon. For Eddystone-EID beacons, you may use either the
  /// current EID or the beacon's "stable" UID.
  /// Required.
  /// Value must have pattern "^beacons/[^/]+$".
  ///
  /// [projectId] - The project id of the project the attachment will belong to.
  /// If
  /// the project id is not specified then the project making the request
  /// is used.
  /// Optional.
  ///
  /// Completes with a [BeaconAttachment].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<BeaconAttachment> create(
      BeaconAttachment request, core.String beaconName,
      {core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (beaconName == null) {
      throw new core.ArgumentError("Parameter beaconName is required.");
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/' +
        commons.Escaper.ecapeVariableReserved('$beaconName') +
        '/attachments';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new BeaconAttachment.fromJson(data));
  }

  /// Deletes the specified attachment for the given beacon. Each attachment has
  /// a unique attachment name (`attachmentName`) which is returned when you
  /// fetch the attachment data via this API. You specify this with the delete
  /// request to control which attachment is removed. This operation cannot be
  /// undone.
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **Is owner** or **Can edit** permissions in the
  /// Google Developers Console project.
  ///
  /// Request parameters:
  ///
  /// [attachmentName] - The attachment name (`attachmentName`) of
  /// the attachment to remove. For example:
  /// `beacons/3!893737abc9/attachments/c5e937-af0-494-959-ec49d12738`. For
  /// Eddystone-EID beacons, the beacon ID portion (`3!893737abc9`) may be the
  /// beacon's current EID, or its "stable" Eddystone-UID.
  /// Required.
  /// Value must have pattern "^beacons/[^/]+/attachments/[^/]+$".
  ///
  /// [projectId] - The project id of the attachment to delete. If not provided,
  /// the project
  /// that is making the request is used.
  /// Optional.
  ///
  /// Completes with a [Empty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Empty> delete(core.String attachmentName,
      {core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (attachmentName == null) {
      throw new core.ArgumentError("Parameter attachmentName is required.");
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url =
        'v1beta1/' + commons.Escaper.ecapeVariableReserved('$attachmentName');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /// Returns the attachments for the specified beacon that match the specified
  /// namespaced-type pattern.
  ///
  /// To control which namespaced types are returned, you add the
  /// `namespacedType` query parameter to the request. You must either use
  /// `* / * `, to return all attachments, or the namespace must be one of
  /// the ones returned from the  `namespaces` endpoint.
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **viewer**, **Is owner** or **Can edit**
  /// permissions in the Google Developers Console project.
  ///
  /// Request parameters:
  ///
  /// [beaconName] - Beacon whose attachments should be fetched. A beacon name
  /// has the
  /// format "beacons/N!beaconId" where the beaconId is the base16 ID broadcast
  /// by the beacon and N is a code for the beacon's type. Possible values are
  /// `3` for Eddystone-UID, `4` for Eddystone-EID, `1` for iBeacon, or `5`
  /// for AltBeacon. For Eddystone-EID beacons, you may use either the
  /// current EID or the beacon's "stable" UID.
  /// Required.
  /// Value must have pattern "^beacons/[^/]+$".
  ///
  /// [namespacedType] - Specifies the namespace and type of attachment to
  /// include in response in
  /// <var>namespace/type</var> format. Accepts `* / * ` to specify
  /// "all types in all namespaces".
  ///
  /// [projectId] - The project id to list beacon attachments under. This field
  /// can be
  /// used when "*" is specified to mean all attachment namespaces. Projects
  /// may have multiple attachments with multiple namespaces. If "*" is
  /// specified and the projectId string is empty, then the project
  /// making the request is used.
  /// Optional.
  ///
  /// Completes with a [ListBeaconAttachmentsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListBeaconAttachmentsResponse> list(core.String beaconName,
      {core.String namespacedType, core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (beaconName == null) {
      throw new core.ArgumentError("Parameter beaconName is required.");
    }
    if (namespacedType != null) {
      _queryParams["namespacedType"] = [namespacedType];
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/' +
        commons.Escaper.ecapeVariableReserved('$beaconName') +
        '/attachments';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ListBeaconAttachmentsResponse.fromJson(data));
  }
}

class BeaconsDiagnosticsResourceApi {
  final commons.ApiRequester _requester;

  BeaconsDiagnosticsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// List the diagnostics for a single beacon. You can also list diagnostics
  /// for
  /// all the beacons owned by your Google Developers Console project by using
  /// the beacon name `beacons/-`.
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **viewer**, **Is owner** or **Can edit**
  /// permissions in the Google Developers Console project.
  ///
  /// Request parameters:
  ///
  /// [beaconName] - Beacon that the diagnostics are for.
  /// Value must have pattern "^beacons/[^/]+$".
  ///
  /// [pageToken] - Requests results that occur after the `page_token`, obtained
  /// from the
  /// response to a previous request. Optional.
  ///
  /// [alertFilter] - Requests only beacons that have the given alert. For
  /// example, to find
  /// beacons that have low batteries use `alert_filter=LOW_BATTERY`.
  /// Possible string values are:
  /// - "ALERT_UNSPECIFIED" : A ALERT_UNSPECIFIED.
  /// - "WRONG_LOCATION" : A WRONG_LOCATION.
  /// - "LOW_BATTERY" : A LOW_BATTERY.
  ///
  /// [pageSize] - Specifies the maximum number of results to return. Defaults
  /// to
  /// 10. Maximum 1000. Optional.
  ///
  /// [projectId] - Requests only diagnostic records for the given project id.
  /// If not set,
  /// then the project making the request will be used for looking up
  /// diagnostic records. Optional.
  ///
  /// Completes with a [ListDiagnosticsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListDiagnosticsResponse> list(core.String beaconName,
      {core.String pageToken,
      core.String alertFilter,
      core.int pageSize,
      core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (beaconName == null) {
      throw new core.ArgumentError("Parameter beaconName is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (alertFilter != null) {
      _queryParams["alertFilter"] = [alertFilter];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/' +
        commons.Escaper.ecapeVariableReserved('$beaconName') +
        '/diagnostics';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListDiagnosticsResponse.fromJson(data));
  }
}

class NamespacesResourceApi {
  final commons.ApiRequester _requester;

  NamespacesResourceApi(commons.ApiRequester client) : _requester = client;

  /// Lists all attachment namespaces owned by your Google Developers Console
  /// project. Attachment data associated with a beacon must include a
  /// namespaced type, and the namespace must be owned by your project.
  ///
  /// Authenticate using an [OAuth access
  /// token](https://developers.google.com/identity/protocols/OAuth2)
  /// from a signed-in user with **viewer**, **Is owner** or **Can edit**
  /// permissions in the Google Developers Console project.
  ///
  /// Request parameters:
  ///
  /// [projectId] - The project id to list namespaces under.
  /// Optional.
  ///
  /// Completes with a [ListNamespacesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListNamespacesResponse> list({core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/namespaces';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListNamespacesResponse.fromJson(data));
  }

  /// Updates the information about the specified namespace. Only the namespace
  /// visibility can be updated.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [namespaceName] - Resource name of this namespace. Namespaces names have
  /// the format:
  /// <code>namespaces/<var>namespace</var></code>.
  /// Value must have pattern "^namespaces/[^/]+$".
  ///
  /// [projectId] - The project id of the namespace to update. If the project id
  /// is not
  /// specified then the project making the request is used. The project id
  /// must match the project that owns the beacon.
  /// Optional.
  ///
  /// Completes with a [Namespace].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Namespace> update(Namespace request, core.String namespaceName,
      {core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (namespaceName == null) {
      throw new core.ArgumentError("Parameter namespaceName is required.");
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1beta1/' + commons.Escaper.ecapeVariableReserved('$namespaceName');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Namespace.fromJson(data));
  }
}

class V1beta1ResourceApi {
  final commons.ApiRequester _requester;

  V1beta1ResourceApi(commons.ApiRequester client) : _requester = client;

  /// Gets the Proximity Beacon API's current public key and associated
  /// parameters used to initiate the Diffie-Hellman key exchange required to
  /// register a beacon that broadcasts the Eddystone-EID format. This key
  /// changes periodically; clients may cache it and re-use the same public key
  /// to provision and register multiple beacons. However, clients should be
  /// prepared to refresh this key when they encounter an error registering an
  /// Eddystone-EID beacon.
  ///
  /// Request parameters:
  ///
  /// Completes with a [EphemeralIdRegistrationParams].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<EphemeralIdRegistrationParams> getEidparams() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    _url = 'v1beta1/eidparams';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new EphemeralIdRegistrationParams.fromJson(data));
  }
}

/// Defines a unique identifier of a beacon as broadcast by the device.
class AdvertisedId {
  /// The actual beacon identifier, as broadcast by the beacon hardware. Must be
  /// [base64](http://tools.ietf.org/html/rfc4648#section-4) encoded in HTTP
  /// requests, and will be so encoded (with padding) in responses. The base64
  /// encoding should be of the binary byte-stream and not any textual (such as
  /// hex) representation thereof.
  /// Required.
  core.String id;
  core.List<core.int> get idAsBytes {
    return convert.BASE64.decode(id);
  }

  void set idAsBytes(core.List<core.int> _bytes) {
    id =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// Specifies the identifier type.
  /// Required.
  /// Possible string values are:
  /// - "TYPE_UNSPECIFIED" : Do not use this value.
  /// - "EDDYSTONE" : Eddystone, an open beacon format that supports Android and
  /// iOS devices
  /// https://github.com/google/eddystone/wiki/Beacon-Specification
  /// - "IBEACON" : Apple iBeacon compatible beacon
  /// - "ALTBEACON" : See http://altbeacon.org and/or
  /// https://github.com/AltBeacon/spec.
  /// - "EDDYSTONE_EID" : Eddystone Ephemeral ID
  core.String type;

  AdvertisedId();

  AdvertisedId.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (id != null) {
      _json["id"] = id;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/// A subset of attachment information served via the
/// `beaconinfo.getforobserved` method, used when your users encounter your
/// beacons.
class AttachmentInfo {
  /// An opaque data container for client-provided data.
  core.String data;
  core.List<core.int> get dataAsBytes {
    return convert.BASE64.decode(data);
  }

  void set dataAsBytes(core.List<core.int> _bytes) {
    data =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// Specifies what kind of attachment this is. Tells a client how to
  /// interpret the `data` field. Format is <var>namespace/type</var>, for
  /// example <code>scrupulous-wombat-12345/welcome-message</code>
  core.String namespacedType;

  AttachmentInfo();

  AttachmentInfo.fromJson(core.Map _json) {
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("namespacedType")) {
      namespacedType = _json["namespacedType"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (data != null) {
      _json["data"] = data;
    }
    if (namespacedType != null) {
      _json["namespacedType"] = namespacedType;
    }
    return _json;
  }
}

/// Details of a beacon device.
class Beacon {
  /// The identifier of a beacon as advertised by it. This field must be
  /// populated when registering. It may be empty when updating a beacon
  /// record because it is ignored in updates.
  ///
  /// When registering a beacon that broadcasts Eddystone-EID, this field
  /// should contain a "stable" Eddystone-UID that identifies the beacon and
  /// links it to its attachments. The stable Eddystone-UID is only used for
  /// administering the beacon.
  AdvertisedId advertisedId;

  /// Resource name of this beacon. A beacon name has the format
  /// "beacons/N!beaconId" where the beaconId is the base16 ID broadcast by
  /// the beacon and N is a code for the beacon's type. Possible values are
  /// `3` for Eddystone, `1` for iBeacon, or `5` for AltBeacon.
  ///
  /// This field must be left empty when registering. After reading a beacon,
  /// clients can use the name for future operations.
  core.String beaconName;

  /// Free text used to identify and describe the beacon. Maximum length 140
  /// characters.
  /// Optional.
  core.String description;

  /// Write-only registration parameters for beacons using Eddystone-EID
  /// (remotely resolved ephemeral ID) format. This information will not be
  /// populated in API responses. When submitting this data, the `advertised_id`
  /// field must contain an ID of type Eddystone-UID. Any other ID type will
  /// result in an error.
  EphemeralIdRegistration ephemeralIdRegistration;

  /// Expected location stability. This is set when the beacon is registered or
  /// updated, not automatically detected in any way.
  /// Optional.
  /// Possible string values are:
  /// - "STABILITY_UNSPECIFIED" : Do not use this value.
  /// - "STABLE" : Not expected to move, for example a store's front door.
  /// - "PORTABLE" : Usually stable but may move rarely, usually within a single
  /// place,
  /// for example a store display.
  /// - "MOBILE" : Moves frequently, for example a personal item or food truck.
  /// - "ROVING" : Moves continuously in service, for example a bus or train.
  core.String expectedStability;

  /// The indoor level information for this beacon, if known. As returned by the
  /// Google Maps API.
  /// Optional.
  IndoorLevel indoorLevel;

  /// The location of the beacon, expressed as a latitude and longitude pair.
  /// This location is given when the beacon is registered or updated. It does
  /// not necessarily indicate the actual current location of the beacon.
  /// Optional.
  LatLng latLng;

  /// The [Google Places API](/places/place-id) Place ID of the place where
  /// the beacon is deployed. This is given when the beacon is registered or
  /// updated, not automatically detected in any way.
  /// Optional.
  core.String placeId;

  /// Properties of the beacon device, for example battery type or firmware
  /// version.
  /// Optional.
  core.Map<core.String, core.String> properties;

  /// Some beacons may require a user to provide an authorization key before
  /// changing any of its configuration (e.g. broadcast frames, transmit power).
  /// This field provides a place to store and control access to that key.
  /// This field is populated in responses to `GET /v1beta1/beacons/3!beaconId`
  /// from users with write access to the given beacon. That is to say: If the
  /// user is authorized to write the beacon's confidential data in the service,
  /// the service considers them authorized to configure the beacon. Note
  /// that this key grants nothing on the service, only on the beacon itself.
  core.String provisioningKey;
  core.List<core.int> get provisioningKeyAsBytes {
    return convert.BASE64.decode(provisioningKey);
  }

  void set provisioningKeyAsBytes(core.List<core.int> _bytes) {
    provisioningKey =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// Current status of the beacon.
  /// Required.
  /// Possible string values are:
  /// - "STATUS_UNSPECIFIED" : Do not use this value.
  /// - "ACTIVE" : The "normal" in-use state of a beacon.
  /// - "DECOMMISSIONED" : Beacon should no longer be used for any purpose. This
  /// is irreversible.
  /// - "INACTIVE" : The beacon should not be visible to mobile devices. This is
  /// reversible.
  core.String status;

  Beacon();

  Beacon.fromJson(core.Map _json) {
    if (_json.containsKey("advertisedId")) {
      advertisedId = new AdvertisedId.fromJson(_json["advertisedId"]);
    }
    if (_json.containsKey("beaconName")) {
      beaconName = _json["beaconName"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("ephemeralIdRegistration")) {
      ephemeralIdRegistration = new EphemeralIdRegistration.fromJson(
          _json["ephemeralIdRegistration"]);
    }
    if (_json.containsKey("expectedStability")) {
      expectedStability = _json["expectedStability"];
    }
    if (_json.containsKey("indoorLevel")) {
      indoorLevel = new IndoorLevel.fromJson(_json["indoorLevel"]);
    }
    if (_json.containsKey("latLng")) {
      latLng = new LatLng.fromJson(_json["latLng"]);
    }
    if (_json.containsKey("placeId")) {
      placeId = _json["placeId"];
    }
    if (_json.containsKey("properties")) {
      properties = _json["properties"];
    }
    if (_json.containsKey("provisioningKey")) {
      provisioningKey = _json["provisioningKey"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (advertisedId != null) {
      _json["advertisedId"] = (advertisedId).toJson();
    }
    if (beaconName != null) {
      _json["beaconName"] = beaconName;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (ephemeralIdRegistration != null) {
      _json["ephemeralIdRegistration"] = (ephemeralIdRegistration).toJson();
    }
    if (expectedStability != null) {
      _json["expectedStability"] = expectedStability;
    }
    if (indoorLevel != null) {
      _json["indoorLevel"] = (indoorLevel).toJson();
    }
    if (latLng != null) {
      _json["latLng"] = (latLng).toJson();
    }
    if (placeId != null) {
      _json["placeId"] = placeId;
    }
    if (properties != null) {
      _json["properties"] = properties;
    }
    if (provisioningKey != null) {
      _json["provisioningKey"] = provisioningKey;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/// Project-specific data associated with a beacon.
class BeaconAttachment {
  /// Resource name of this attachment. Attachment names have the format:
  /// <code>beacons/<var>beacon_id</var>/attachments/<var>attachment_id</var></code>.
  /// Leave this empty on creation.
  core.String attachmentName;

  /// The UTC time when this attachment was created, in milliseconds since the
  /// UNIX epoch.
  core.String creationTimeMs;

  /// An opaque data container for client-provided data. Must be
  /// [base64](http://tools.ietf.org/html/rfc4648#section-4) encoded in HTTP
  /// requests, and will be so encoded (with padding) in responses.
  /// Required.
  core.String data;
  core.List<core.int> get dataAsBytes {
    return convert.BASE64.decode(data);
  }

  void set dataAsBytes(core.List<core.int> _bytes) {
    data =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// Specifies what kind of attachment this is. Tells a client how to
  /// interpret the `data` field. Format is <var>namespace/type</var>. Namespace
  /// provides type separation between clients. Type describes the type of
  /// `data`, for use by the client when parsing the `data` field.
  /// Required.
  core.String namespacedType;

  BeaconAttachment();

  BeaconAttachment.fromJson(core.Map _json) {
    if (_json.containsKey("attachmentName")) {
      attachmentName = _json["attachmentName"];
    }
    if (_json.containsKey("creationTimeMs")) {
      creationTimeMs = _json["creationTimeMs"];
    }
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("namespacedType")) {
      namespacedType = _json["namespacedType"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (attachmentName != null) {
      _json["attachmentName"] = attachmentName;
    }
    if (creationTimeMs != null) {
      _json["creationTimeMs"] = creationTimeMs;
    }
    if (data != null) {
      _json["data"] = data;
    }
    if (namespacedType != null) {
      _json["namespacedType"] = namespacedType;
    }
    return _json;
  }
}

/// A subset of beacon information served via the `beaconinfo.getforobserved`
/// method, which you call when users of your app encounter your beacons.
class BeaconInfo {
  /// The ID advertised by the beacon.
  AdvertisedId advertisedId;

  /// Attachments matching the type(s) requested.
  /// May be empty if no attachment types were requested.
  core.List<AttachmentInfo> attachments;

  /// The name under which the beacon is registered.
  core.String beaconName;

  BeaconInfo();

  BeaconInfo.fromJson(core.Map _json) {
    if (_json.containsKey("advertisedId")) {
      advertisedId = new AdvertisedId.fromJson(_json["advertisedId"]);
    }
    if (_json.containsKey("attachments")) {
      attachments = _json["attachments"]
          .map((value) => new AttachmentInfo.fromJson(value))
          .toList();
    }
    if (_json.containsKey("beaconName")) {
      beaconName = _json["beaconName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (advertisedId != null) {
      _json["advertisedId"] = (advertisedId).toJson();
    }
    if (attachments != null) {
      _json["attachments"] =
          attachments.map((value) => (value).toJson()).toList();
    }
    if (beaconName != null) {
      _json["beaconName"] = beaconName;
    }
    return _json;
  }
}

/// Represents a whole calendar date, e.g. date of birth. The time of day and
/// time zone are either specified elsewhere or are not significant. The date
/// is relative to the Proleptic Gregorian Calendar. The day may be 0 to
/// represent a year and month where the day is not significant, e.g. credit
/// card
/// expiration date. The year may be 0 to represent a month and day independent
/// of year, e.g. anniversary date. Related types are google.type.TimeOfDay
/// and `google.protobuf.Timestamp`.
class Date {
  /// Day of month. Must be from 1 to 31 and valid for the year and month, or 0
  /// if specifying a year/month where the day is not significant.
  core.int day;

  /// Month of year. Must be from 1 to 12.
  core.int month;

  /// Year of date. Must be from 1 to 9999, or 0 if specifying a date without
  /// a year.
  core.int year;

  Date();

  Date.fromJson(core.Map _json) {
    if (_json.containsKey("day")) {
      day = _json["day"];
    }
    if (_json.containsKey("month")) {
      month = _json["month"];
    }
    if (_json.containsKey("year")) {
      year = _json["year"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (day != null) {
      _json["day"] = day;
    }
    if (month != null) {
      _json["month"] = month;
    }
    if (year != null) {
      _json["year"] = year;
    }
    return _json;
  }
}

/// Response for a request to delete attachments.
class DeleteAttachmentsResponse {
  /// The number of attachments that were deleted.
  core.int numDeleted;

  DeleteAttachmentsResponse();

  DeleteAttachmentsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("numDeleted")) {
      numDeleted = _json["numDeleted"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (numDeleted != null) {
      _json["numDeleted"] = numDeleted;
    }
    return _json;
  }
}

/// Diagnostics for a single beacon.
class Diagnostics {
  /// An unordered list of Alerts that the beacon has.
  core.List<core.String> alerts;

  /// Resource name of the beacon. For Eddystone-EID beacons, this may
  /// be the beacon's current EID, or the beacon's "stable" Eddystone-UID.
  core.String beaconName;

  /// The date when the battery is expected to be low. If the value is missing
  /// then there is no estimate for when the battery will be low.
  /// This value is only an estimate, not an exact date.
  Date estimatedLowBatteryDate;

  Diagnostics();

  Diagnostics.fromJson(core.Map _json) {
    if (_json.containsKey("alerts")) {
      alerts = _json["alerts"];
    }
    if (_json.containsKey("beaconName")) {
      beaconName = _json["beaconName"];
    }
    if (_json.containsKey("estimatedLowBatteryDate")) {
      estimatedLowBatteryDate =
          new Date.fromJson(_json["estimatedLowBatteryDate"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (alerts != null) {
      _json["alerts"] = alerts;
    }
    if (beaconName != null) {
      _json["beaconName"] = beaconName;
    }
    if (estimatedLowBatteryDate != null) {
      _json["estimatedLowBatteryDate"] = (estimatedLowBatteryDate).toJson();
    }
    return _json;
  }
}

/// A generic empty message that you can re-use to avoid defining duplicated
/// empty messages in your APIs. A typical example is to use it as the request
/// or the response type of an API method. For instance:
///
///     service Foo {
///       rpc Bar(google.protobuf.Empty) returns (google.protobuf.Empty);
///     }
///
/// The JSON representation for `Empty` is empty JSON object `{}`.
class Empty {
  Empty();

  Empty.fromJson(core.Map _json) {}

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    return _json;
  }
}

/// Write-only registration parameters for beacons using Eddystone-EID format.
/// Two ways of securely registering an Eddystone-EID beacon with the service
/// are supported:
///
/// 1. Perform an ECDH key exchange via this API, including a previous call
///    to `GET /v1beta1/eidparams`. In this case the fields
///    `beacon_ecdh_public_key` and `service_ecdh_public_key` should be
///    populated and `beacon_identity_key` should not be populated. This
///    method ensures that only the two parties in the ECDH key exchange can
///    compute the identity key, which becomes a secret between them.
/// 2. Derive or obtain the beacon's identity key via other secure means
///    (perhaps an ECDH key exchange between the beacon and a mobile device
///    or any other secure method), and then submit the resulting identity key
///    to the service. In this case `beacon_identity_key` field should be
///    populated, and neither of `beacon_ecdh_public_key` nor
///    `service_ecdh_public_key` fields should be. The security of this method
///    depends on how securely the parties involved (in particular the
///    bluetooth client) handle the identity key, and obviously on how
///    securely the identity key was generated.
///
/// See [the Eddystone
/// specification](https://github.com/google/eddystone/tree/master/eddystone-eid)
/// at GitHub.
class EphemeralIdRegistration {
  /// The beacon's public key used for the Elliptic curve Diffie-Hellman
  /// key exchange. When this field is populated, `service_ecdh_public_key`
  /// must also be populated, and `beacon_identity_key` must not be.
  core.String beaconEcdhPublicKey;
  core.List<core.int> get beaconEcdhPublicKeyAsBytes {
    return convert.BASE64.decode(beaconEcdhPublicKey);
  }

  void set beaconEcdhPublicKeyAsBytes(core.List<core.int> _bytes) {
    beaconEcdhPublicKey =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// The private key of the beacon. If this field is populated,
  /// `beacon_ecdh_public_key` and `service_ecdh_public_key` must not be
  /// populated.
  core.String beaconIdentityKey;
  core.List<core.int> get beaconIdentityKeyAsBytes {
    return convert.BASE64.decode(beaconIdentityKey);
  }

  void set beaconIdentityKeyAsBytes(core.List<core.int> _bytes) {
    beaconIdentityKey =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// The initial clock value of the beacon. The beacon's clock must have
  /// begun counting at this value immediately prior to transmitting this
  /// value to the resolving service. Significant delay in transmitting this
  /// value to the service risks registration or resolution failures. If a
  /// value is not provided, the default is zero.
  core.String initialClockValue;

  /// An initial ephemeral ID calculated using the clock value submitted as
  /// `initial_clock_value`, and the secret key generated by the
  /// Diffie-Hellman key exchange using `service_ecdh_public_key` and
  /// `service_ecdh_public_key`. This initial EID value will be used by the
  /// service to confirm that the key exchange process was successful.
  core.String initialEid;
  core.List<core.int> get initialEidAsBytes {
    return convert.BASE64.decode(initialEid);
  }

  void set initialEidAsBytes(core.List<core.int> _bytes) {
    initialEid =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// Indicates the nominal period between each rotation of the beacon's
  /// ephemeral ID. "Nominal" because the beacon should randomize the
  /// actual interval. See [the spec at
  /// github](https://github.com/google/eddystone/tree/master/eddystone-eid)
  /// for details. This value corresponds to a power-of-two scaler on the
  /// beacon's clock: when the scaler value is K, the beacon will begin
  /// broadcasting a new ephemeral ID on average every 2^K seconds.
  core.int rotationPeriodExponent;

  /// The service's public key used for the Elliptic curve Diffie-Hellman
  /// key exchange. When this field is populated, `beacon_ecdh_public_key`
  /// must also be populated, and `beacon_identity_key` must not be.
  core.String serviceEcdhPublicKey;
  core.List<core.int> get serviceEcdhPublicKeyAsBytes {
    return convert.BASE64.decode(serviceEcdhPublicKey);
  }

  void set serviceEcdhPublicKeyAsBytes(core.List<core.int> _bytes) {
    serviceEcdhPublicKey =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  EphemeralIdRegistration();

  EphemeralIdRegistration.fromJson(core.Map _json) {
    if (_json.containsKey("beaconEcdhPublicKey")) {
      beaconEcdhPublicKey = _json["beaconEcdhPublicKey"];
    }
    if (_json.containsKey("beaconIdentityKey")) {
      beaconIdentityKey = _json["beaconIdentityKey"];
    }
    if (_json.containsKey("initialClockValue")) {
      initialClockValue = _json["initialClockValue"];
    }
    if (_json.containsKey("initialEid")) {
      initialEid = _json["initialEid"];
    }
    if (_json.containsKey("rotationPeriodExponent")) {
      rotationPeriodExponent = _json["rotationPeriodExponent"];
    }
    if (_json.containsKey("serviceEcdhPublicKey")) {
      serviceEcdhPublicKey = _json["serviceEcdhPublicKey"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (beaconEcdhPublicKey != null) {
      _json["beaconEcdhPublicKey"] = beaconEcdhPublicKey;
    }
    if (beaconIdentityKey != null) {
      _json["beaconIdentityKey"] = beaconIdentityKey;
    }
    if (initialClockValue != null) {
      _json["initialClockValue"] = initialClockValue;
    }
    if (initialEid != null) {
      _json["initialEid"] = initialEid;
    }
    if (rotationPeriodExponent != null) {
      _json["rotationPeriodExponent"] = rotationPeriodExponent;
    }
    if (serviceEcdhPublicKey != null) {
      _json["serviceEcdhPublicKey"] = serviceEcdhPublicKey;
    }
    return _json;
  }
}

/// Information a client needs to provision and register beacons that
/// broadcast Eddystone-EID format beacon IDs, using Elliptic curve
/// Diffie-Hellman key exchange. See
/// [the Eddystone
/// specification](https://github.com/google/eddystone/tree/master/eddystone-eid)
/// at GitHub.
class EphemeralIdRegistrationParams {
  /// Indicates the maximum rotation period supported by the service.
  /// See EddystoneEidRegistration.rotation_period_exponent
  core.int maxRotationPeriodExponent;

  /// Indicates the minimum rotation period supported by the service.
  /// See EddystoneEidRegistration.rotation_period_exponent
  core.int minRotationPeriodExponent;

  /// The beacon service's public key for use by a beacon to derive its
  /// Identity Key using Elliptic Curve Diffie-Hellman key exchange.
  core.String serviceEcdhPublicKey;
  core.List<core.int> get serviceEcdhPublicKeyAsBytes {
    return convert.BASE64.decode(serviceEcdhPublicKey);
  }

  void set serviceEcdhPublicKeyAsBytes(core.List<core.int> _bytes) {
    serviceEcdhPublicKey =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  EphemeralIdRegistrationParams();

  EphemeralIdRegistrationParams.fromJson(core.Map _json) {
    if (_json.containsKey("maxRotationPeriodExponent")) {
      maxRotationPeriodExponent = _json["maxRotationPeriodExponent"];
    }
    if (_json.containsKey("minRotationPeriodExponent")) {
      minRotationPeriodExponent = _json["minRotationPeriodExponent"];
    }
    if (_json.containsKey("serviceEcdhPublicKey")) {
      serviceEcdhPublicKey = _json["serviceEcdhPublicKey"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (maxRotationPeriodExponent != null) {
      _json["maxRotationPeriodExponent"] = maxRotationPeriodExponent;
    }
    if (minRotationPeriodExponent != null) {
      _json["minRotationPeriodExponent"] = minRotationPeriodExponent;
    }
    if (serviceEcdhPublicKey != null) {
      _json["serviceEcdhPublicKey"] = serviceEcdhPublicKey;
    }
    return _json;
  }
}

/// Request for beacon and attachment information about beacons that
/// a mobile client has encountered "in the wild".
class GetInfoForObservedBeaconsRequest {
  /// Specifies what kind of attachments to include in the response.
  /// When given, the response will include only attachments of the given types.
  /// When empty, no attachments will be returned. Must be in the format
  /// <var>namespace/type</var>. Accepts `*` to specify all types in
  /// all namespaces owned by the client.
  /// Optional.
  core.List<core.String> namespacedTypes;

  /// The beacons that the client has encountered.
  /// At least one must be given.
  core.List<Observation> observations;

  GetInfoForObservedBeaconsRequest();

  GetInfoForObservedBeaconsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("namespacedTypes")) {
      namespacedTypes = _json["namespacedTypes"];
    }
    if (_json.containsKey("observations")) {
      observations = _json["observations"]
          .map((value) => new Observation.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (namespacedTypes != null) {
      _json["namespacedTypes"] = namespacedTypes;
    }
    if (observations != null) {
      _json["observations"] =
          observations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Information about the requested beacons, optionally including attachment
/// data.
class GetInfoForObservedBeaconsResponse {
  /// Public information about beacons.
  /// May be empty if the request matched no beacons.
  core.List<BeaconInfo> beacons;

  GetInfoForObservedBeaconsResponse();

  GetInfoForObservedBeaconsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("beacons")) {
      beacons = _json["beacons"]
          .map((value) => new BeaconInfo.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (beacons != null) {
      _json["beacons"] = beacons.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Indoor level, a human-readable string as returned by Google Maps APIs,
/// useful to indicate which floor of a building a beacon is located on.
class IndoorLevel {
  /// The name of this level.
  core.String name;

  IndoorLevel();

  IndoorLevel.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/// An object representing a latitude/longitude pair. This is expressed as a
/// pair
/// of doubles representing degrees latitude and degrees longitude. Unless
/// specified otherwise, this must conform to the
/// <a href="http://www.unoosa.org/pdf/icg/2012/template/WGS_84.pdf">WGS84
/// standard</a>. Values must be within normalized ranges.
///
/// Example of normalization code in Python:
///
///     def NormalizeLongitude(longitude):
///       """Wraps decimal degrees longitude to [-180.0, 180.0]."""
///       q, r = divmod(longitude, 360.0)
///       if r > 180.0 or (r == 180.0 and q <= -1.0):
///         return r - 360.0
///       return r
///
///     def NormalizeLatLng(latitude, longitude):
///       """Wraps decimal degrees latitude and longitude to
///       [-90.0, 90.0] and [-180.0, 180.0], respectively."""
///       r = latitude % 360.0
///       if r <= 90.0:
///         return r, NormalizeLongitude(longitude)
///       elif r >= 270.0:
///         return r - 360, NormalizeLongitude(longitude)
///       else:
///         return 180 - r, NormalizeLongitude(longitude + 180.0)
///
///     assert 180.0 == NormalizeLongitude(180.0)
///     assert -180.0 == NormalizeLongitude(-180.0)
///     assert -179.0 == NormalizeLongitude(181.0)
///     assert (0.0, 0.0) == NormalizeLatLng(360.0, 0.0)
///     assert (0.0, 0.0) == NormalizeLatLng(-360.0, 0.0)
///     assert (85.0, 180.0) == NormalizeLatLng(95.0, 0.0)
///     assert (-85.0, -170.0) == NormalizeLatLng(-95.0, 10.0)
///     assert (90.0, 10.0) == NormalizeLatLng(90.0, 10.0)
///     assert (-90.0, -10.0) == NormalizeLatLng(-90.0, -10.0)
///     assert (0.0, -170.0) == NormalizeLatLng(-180.0, 10.0)
///     assert (0.0, -170.0) == NormalizeLatLng(180.0, 10.0)
///     assert (-90.0, 10.0) == NormalizeLatLng(270.0, 10.0)
///     assert (90.0, 10.0) == NormalizeLatLng(-270.0, 10.0)
class LatLng {
  /// The latitude in degrees. It must be in the range [-90.0, +90.0].
  core.double latitude;

  /// The longitude in degrees. It must be in the range [-180.0, +180.0].
  core.double longitude;

  LatLng();

  LatLng.fromJson(core.Map _json) {
    if (_json.containsKey("latitude")) {
      latitude = _json["latitude"];
    }
    if (_json.containsKey("longitude")) {
      longitude = _json["longitude"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (latitude != null) {
      _json["latitude"] = latitude;
    }
    if (longitude != null) {
      _json["longitude"] = longitude;
    }
    return _json;
  }
}

/// Response to `ListBeaconAttachments` that contains the requested attachments.
class ListBeaconAttachmentsResponse {
  /// The attachments that corresponded to the request params.
  core.List<BeaconAttachment> attachments;

  ListBeaconAttachmentsResponse();

  ListBeaconAttachmentsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("attachments")) {
      attachments = _json["attachments"]
          .map((value) => new BeaconAttachment.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (attachments != null) {
      _json["attachments"] =
          attachments.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Response that contains list beacon results and pagination help.
class ListBeaconsResponse {
  /// The beacons that matched the search criteria.
  core.List<Beacon> beacons;

  /// An opaque pagination token that the client may provide in their next
  /// request to retrieve the next page of results.
  core.String nextPageToken;

  /// Estimate of the total number of beacons matched by the query. Higher
  /// values may be less accurate.
  core.String totalCount;

  ListBeaconsResponse();

  ListBeaconsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("beacons")) {
      beacons =
          _json["beacons"].map((value) => new Beacon.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("totalCount")) {
      totalCount = _json["totalCount"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (beacons != null) {
      _json["beacons"] = beacons.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (totalCount != null) {
      _json["totalCount"] = totalCount;
    }
    return _json;
  }
}

/// Response that contains the requested diagnostics.
class ListDiagnosticsResponse {
  /// The diagnostics matching the given request.
  core.List<Diagnostics> diagnostics;

  /// Token that can be used for pagination. Returned only if the
  /// request matches more beacons than can be returned in this response.
  core.String nextPageToken;

  ListDiagnosticsResponse();

  ListDiagnosticsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("diagnostics")) {
      diagnostics = _json["diagnostics"]
          .map((value) => new Diagnostics.fromJson(value))
          .toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (diagnostics != null) {
      _json["diagnostics"] =
          diagnostics.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/// Response to ListNamespacesRequest that contains all the project's
/// namespaces.
class ListNamespacesResponse {
  /// The attachments that corresponded to the request params.
  core.List<Namespace> namespaces;

  ListNamespacesResponse();

  ListNamespacesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("namespaces")) {
      namespaces = _json["namespaces"]
          .map((value) => new Namespace.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (namespaces != null) {
      _json["namespaces"] =
          namespaces.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// An attachment namespace defines read and write access for all the
/// attachments
/// created under it. Each namespace is globally unique, and owned by one
/// project which is the only project that can create attachments under it.
class Namespace {
  /// Resource name of this namespace. Namespaces names have the format:
  /// <code>namespaces/<var>namespace</var></code>.
  core.String namespaceName;

  /// Specifies what clients may receive attachments under this namespace
  /// via `beaconinfo.getforobserved`.
  /// Possible string values are:
  /// - "VISIBILITY_UNSPECIFIED" : Do not use this value.
  /// - "UNLISTED" : Served only to the project that owns the namespace.
  /// - "PUBLIC" : Any project can subscribe to attachments under the namespace.
  core.String servingVisibility;

  Namespace();

  Namespace.fromJson(core.Map _json) {
    if (_json.containsKey("namespaceName")) {
      namespaceName = _json["namespaceName"];
    }
    if (_json.containsKey("servingVisibility")) {
      servingVisibility = _json["servingVisibility"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (namespaceName != null) {
      _json["namespaceName"] = namespaceName;
    }
    if (servingVisibility != null) {
      _json["servingVisibility"] = servingVisibility;
    }
    return _json;
  }
}

/// Represents one beacon observed once.
class Observation {
  /// The ID advertised by the beacon the client has encountered.
  ///
  /// If the submitted `advertised_id` type is Eddystone-EID, then the client
  /// must be authorized to resolve the given beacon. Otherwise no data will be
  /// returned for that beacon.
  /// Required.
  AdvertisedId advertisedId;

  /// The array of telemetry bytes received from the beacon. The server is
  /// responsible for parsing it. This field may frequently be empty, as
  /// with a beacon that transmits telemetry only occasionally.
  core.String telemetry;
  core.List<core.int> get telemetryAsBytes {
    return convert.BASE64.decode(telemetry);
  }

  void set telemetryAsBytes(core.List<core.int> _bytes) {
    telemetry =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// Time when the beacon was observed.
  core.String timestampMs;

  Observation();

  Observation.fromJson(core.Map _json) {
    if (_json.containsKey("advertisedId")) {
      advertisedId = new AdvertisedId.fromJson(_json["advertisedId"]);
    }
    if (_json.containsKey("telemetry")) {
      telemetry = _json["telemetry"];
    }
    if (_json.containsKey("timestampMs")) {
      timestampMs = _json["timestampMs"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (advertisedId != null) {
      _json["advertisedId"] = (advertisedId).toJson();
    }
    if (telemetry != null) {
      _json["telemetry"] = telemetry;
    }
    if (timestampMs != null) {
      _json["timestampMs"] = timestampMs;
    }
    return _json;
  }
}
