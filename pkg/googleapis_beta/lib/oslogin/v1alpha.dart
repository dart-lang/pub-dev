// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.oslogin.v1alpha;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client oslogin/v1alpha';

/// Manages OS login configuration for Directory API users.
class OsloginApi {
  /// View and manage your data across Google Cloud Platform services
  static const CloudPlatformScope =
      "https://www.googleapis.com/auth/cloud-platform";

  /// View your data across Google Cloud Platform services
  static const CloudPlatformReadOnlyScope =
      "https://www.googleapis.com/auth/cloud-platform.read-only";

  final commons.ApiRequester _requester;

  UsersResourceApi get users => new UsersResourceApi(_requester);

  OsloginApi(http.Client client,
      {core.String rootUrl: "https://oslogin.googleapis.com/",
      core.String servicePath: ""})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class UsersResourceApi {
  final commons.ApiRequester _requester;

  UsersSshPublicKeysResourceApi get sshPublicKeys =>
      new UsersSshPublicKeysResourceApi(_requester);

  UsersResourceApi(commons.ApiRequester client) : _requester = client;

  /// Retrieves the profile information used for logging in to a virtual machine
  /// on Google Compute Engine.
  ///
  /// Request parameters:
  ///
  /// [name] - The unique ID for the user in format `users/{user}`.
  /// Value must have pattern "^users/[^/]+$".
  ///
  /// Completes with a [LoginProfile].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LoginProfile> getLoginProfile(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v1alpha/' +
        commons.Escaper.ecapeVariableReserved('$name') +
        '/loginProfile';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new LoginProfile.fromJson(data));
  }

  /// Adds an SSH public key and returns the profile information. Default POSIX
  /// account information is set when no username and UID exist as part of the
  /// login profile.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [parent] - The unique ID for the user in format `users/{user}`.
  /// Value must have pattern "^users/[^/]+$".
  ///
  /// Completes with a [ImportSshPublicKeyResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ImportSshPublicKeyResponse> importSshPublicKey(
      SshPublicKey request, core.String parent) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (parent == null) {
      throw new core.ArgumentError("Parameter parent is required.");
    }

    _url = 'v1alpha/' +
        commons.Escaper.ecapeVariableReserved('$parent') +
        ':importSshPublicKey';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ImportSshPublicKeyResponse.fromJson(data));
  }
}

class UsersSshPublicKeysResourceApi {
  final commons.ApiRequester _requester;

  UsersSshPublicKeysResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Deletes an SSH public key.
  ///
  /// Request parameters:
  ///
  /// [name] - The fingerprint of the public key to update. Public keys are
  /// identified by
  /// their SHA-256 fingerprint. The fingerprint of the public key is in format
  /// `users/{user}/sshPublicKeys/{fingerprint}`.
  /// Value must have pattern "^users/[^/]+/sshPublicKeys/[^/]+$".
  ///
  /// Completes with a [Empty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
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

    _url = 'v1alpha/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /// Retrieves an SSH public key.
  ///
  /// Request parameters:
  ///
  /// [name] - The fingerprint of the public key to retrieve. Public keys are
  /// identified
  /// by their SHA-256 fingerprint. The fingerprint of the public key is in
  /// format `users/{user}/sshPublicKeys/{fingerprint}`.
  /// Value must have pattern "^users/[^/]+/sshPublicKeys/[^/]+$".
  ///
  /// Completes with a [SshPublicKey].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SshPublicKey> get(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v1alpha/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new SshPublicKey.fromJson(data));
  }

  /// Updates an SSH public key and returns the profile information. This method
  /// supports patch semantics.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [name] - The fingerprint of the public key to update. Public keys are
  /// identified by
  /// their SHA-256 fingerprint. The fingerprint of the public key is in format
  /// `users/{user}/sshPublicKeys/{fingerprint}`.
  /// Value must have pattern "^users/[^/]+/sshPublicKeys/[^/]+$".
  ///
  /// [updateMask] - Mask to control which fields get updated. Updates all if
  /// not present.
  ///
  /// Completes with a [SshPublicKey].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SshPublicKey> patch(SshPublicKey request, core.String name,
      {core.String updateMask}) {
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
    if (updateMask != null) {
      _queryParams["updateMask"] = [updateMask];
    }

    _url = 'v1alpha/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "PATCH",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new SshPublicKey.fromJson(data));
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

/// A response message for importing an SSH public key.
class ImportSshPublicKeyResponse {
  /// The login profile information for the user.
  LoginProfile loginProfile;

  ImportSshPublicKeyResponse();

  ImportSshPublicKeyResponse.fromJson(core.Map _json) {
    if (_json.containsKey("loginProfile")) {
      loginProfile = new LoginProfile.fromJson(_json["loginProfile"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (loginProfile != null) {
      _json["loginProfile"] = (loginProfile).toJson();
    }
    return _json;
  }
}

/// The Directory API profile information used for logging in to a virtual
/// machine on Google Compute Engine.
class LoginProfile {
  /// A unique user ID for identifying the user.
  core.String name;

  /// The list of POSIX accounts associated with the Directory API user.
  core.List<PosixAccount> posixAccounts;

  /// A map from SSH public key fingerprint to the associated key object.
  core.Map<core.String, SshPublicKey> sshPublicKeys;

  /// Indicates if the user is suspended.
  core.bool suspended;

  LoginProfile();

  LoginProfile.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("posixAccounts")) {
      posixAccounts = _json["posixAccounts"]
          .map((value) => new PosixAccount.fromJson(value))
          .toList();
    }
    if (_json.containsKey("sshPublicKeys")) {
      sshPublicKeys =
          commons.mapMap<core.Map<core.String, core.Object>, SshPublicKey>(
              _json["sshPublicKeys"],
              (core.Map<core.String, core.Object> item) =>
                  new SshPublicKey.fromJson(item));
    }
    if (_json.containsKey("suspended")) {
      suspended = _json["suspended"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (name != null) {
      _json["name"] = name;
    }
    if (posixAccounts != null) {
      _json["posixAccounts"] =
          posixAccounts.map((value) => (value).toJson()).toList();
    }
    if (sshPublicKeys != null) {
      _json["sshPublicKeys"] =
          commons.mapMap<SshPublicKey, core.Map<core.String, core.Object>>(
              sshPublicKeys, (SshPublicKey item) => (item).toJson());
    }
    if (suspended != null) {
      _json["suspended"] = suspended;
    }
    return _json;
  }
}

/// The POSIX account information associated with a Directory API User.
class PosixAccount {
  /// The GECOS (user information) entry for this account.
  core.String gecos;

  /// The default group ID.
  core.int gid;

  /// The path to the home directory for this account.
  core.String homeDirectory;

  /// Only one POSIX account can be marked as primary.
  core.bool primary;

  /// The path to the logic shell for this account.
  core.String shell;

  /// System identifier for which account the username or uid applies to.
  /// By default, the empty value is used.
  core.String systemId;

  /// The user ID.
  core.int uid;

  /// The username of the POSIX account.
  core.String username;

  PosixAccount();

  PosixAccount.fromJson(core.Map _json) {
    if (_json.containsKey("gecos")) {
      gecos = _json["gecos"];
    }
    if (_json.containsKey("gid")) {
      gid = _json["gid"];
    }
    if (_json.containsKey("homeDirectory")) {
      homeDirectory = _json["homeDirectory"];
    }
    if (_json.containsKey("primary")) {
      primary = _json["primary"];
    }
    if (_json.containsKey("shell")) {
      shell = _json["shell"];
    }
    if (_json.containsKey("systemId")) {
      systemId = _json["systemId"];
    }
    if (_json.containsKey("uid")) {
      uid = _json["uid"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (gecos != null) {
      _json["gecos"] = gecos;
    }
    if (gid != null) {
      _json["gid"] = gid;
    }
    if (homeDirectory != null) {
      _json["homeDirectory"] = homeDirectory;
    }
    if (primary != null) {
      _json["primary"] = primary;
    }
    if (shell != null) {
      _json["shell"] = shell;
    }
    if (systemId != null) {
      _json["systemId"] = systemId;
    }
    if (uid != null) {
      _json["uid"] = uid;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/// The SSH public key information associated with a Directory API User.
class SshPublicKey {
  /// An expiration time in microseconds since epoch.
  core.String expirationTimeUsec;

  /// [Output Only] The SHA-256 fingerprint of the SSH public key.
  core.String fingerprint;

  /// Public key text in SSH format, defined by
  /// <a href="https://www.ietf.org/rfc/rfc4253.txt" target="_blank">RFC4253</a>
  /// section 6.6.
  core.String key;

  SshPublicKey();

  SshPublicKey.fromJson(core.Map _json) {
    if (_json.containsKey("expirationTimeUsec")) {
      expirationTimeUsec = _json["expirationTimeUsec"];
    }
    if (_json.containsKey("fingerprint")) {
      fingerprint = _json["fingerprint"];
    }
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (expirationTimeUsec != null) {
      _json["expirationTimeUsec"] = expirationTimeUsec;
    }
    if (fingerprint != null) {
      _json["fingerprint"] = fingerprint;
    }
    if (key != null) {
      _json["key"] = key;
    }
    return _json;
  }
}
