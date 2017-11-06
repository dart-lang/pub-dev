// This is a generated file (see the discoveryapis_generator project).

library googleapis.identitytoolkit.v3;

import 'dart:core' as core;
import 'dart:collection' as collection;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client identitytoolkit/v3';

/** Help the third party sites to implement federated login. */
class IdentitytoolkitApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /** View and administer all your Firebase data and settings */
  static const FirebaseScope = "https://www.googleapis.com/auth/firebase";


  final commons.ApiRequester _requester;

  RelyingpartyResourceApi get relyingparty => new RelyingpartyResourceApi(_requester);

  IdentitytoolkitApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "identitytoolkit/v3/relyingparty/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class RelyingpartyResourceApi {
  final commons.ApiRequester _requester;

  RelyingpartyResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates the URI used by the IdP to authenticate the user.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [CreateAuthUriResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreateAuthUriResponse> createAuthUri(IdentitytoolkitRelyingpartyCreateAuthUriRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'createAuthUri';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreateAuthUriResponse.fromJson(data));
  }

  /**
   * Delete user account.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [DeleteAccountResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DeleteAccountResponse> deleteAccount(IdentitytoolkitRelyingpartyDeleteAccountRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'deleteAccount';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DeleteAccountResponse.fromJson(data));
  }

  /**
   * Batch download user accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [DownloadAccountResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DownloadAccountResponse> downloadAccount(IdentitytoolkitRelyingpartyDownloadAccountRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'downloadAccount';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DownloadAccountResponse.fromJson(data));
  }

  /**
   * Returns the account info.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [GetAccountInfoResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetAccountInfoResponse> getAccountInfo(IdentitytoolkitRelyingpartyGetAccountInfoRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'getAccountInfo';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetAccountInfoResponse.fromJson(data));
  }

  /**
   * Get a code for user action confirmation.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [GetOobConfirmationCodeResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetOobConfirmationCodeResponse> getOobConfirmationCode(Relyingparty request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'getOobConfirmationCode';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetOobConfirmationCodeResponse.fromJson(data));
  }

  /**
   * Get project configuration.
   *
   * Request parameters:
   *
   * [delegatedProjectNumber] - Delegated GCP project number of the request.
   *
   * [projectNumber] - GCP project number of the request.
   *
   * Completes with a [IdentitytoolkitRelyingpartyGetProjectConfigResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<IdentitytoolkitRelyingpartyGetProjectConfigResponse> getProjectConfig({core.String delegatedProjectNumber, core.String projectNumber}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (delegatedProjectNumber != null) {
      _queryParams["delegatedProjectNumber"] = [delegatedProjectNumber];
    }
    if (projectNumber != null) {
      _queryParams["projectNumber"] = [projectNumber];
    }

    _url = 'getProjectConfig';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new IdentitytoolkitRelyingpartyGetProjectConfigResponse.fromJson(data));
  }

  /**
   * Get token signing public key.
   *
   * Request parameters:
   *
   * Completes with a [IdentitytoolkitRelyingpartyGetPublicKeysResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<IdentitytoolkitRelyingpartyGetPublicKeysResponse> getPublicKeys() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'publicKeys';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new IdentitytoolkitRelyingpartyGetPublicKeysResponse.fromJson(data));
  }

  /**
   * Get recaptcha secure param.
   *
   * Request parameters:
   *
   * Completes with a [GetRecaptchaParamResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetRecaptchaParamResponse> getRecaptchaParam() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'getRecaptchaParam';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetRecaptchaParamResponse.fromJson(data));
  }

  /**
   * Reset password for a user.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [ResetPasswordResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ResetPasswordResponse> resetPassword(IdentitytoolkitRelyingpartyResetPasswordRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'resetPassword';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ResetPasswordResponse.fromJson(data));
  }

  /**
   * Set account info for a user.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SetAccountInfoResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SetAccountInfoResponse> setAccountInfo(IdentitytoolkitRelyingpartySetAccountInfoRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'setAccountInfo';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SetAccountInfoResponse.fromJson(data));
  }

  /**
   * Set project configuration.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [IdentitytoolkitRelyingpartySetProjectConfigResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<IdentitytoolkitRelyingpartySetProjectConfigResponse> setProjectConfig(IdentitytoolkitRelyingpartySetProjectConfigRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'setProjectConfig';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new IdentitytoolkitRelyingpartySetProjectConfigResponse.fromJson(data));
  }

  /**
   * Sign out user.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [IdentitytoolkitRelyingpartySignOutUserResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<IdentitytoolkitRelyingpartySignOutUserResponse> signOutUser(IdentitytoolkitRelyingpartySignOutUserRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'signOutUser';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new IdentitytoolkitRelyingpartySignOutUserResponse.fromJson(data));
  }

  /**
   * Signup new user.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SignupNewUserResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SignupNewUserResponse> signupNewUser(IdentitytoolkitRelyingpartySignupNewUserRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'signupNewUser';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SignupNewUserResponse.fromJson(data));
  }

  /**
   * Batch upload existing user accounts.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [UploadAccountResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UploadAccountResponse> uploadAccount(IdentitytoolkitRelyingpartyUploadAccountRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'uploadAccount';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UploadAccountResponse.fromJson(data));
  }

  /**
   * Verifies the assertion returned by the IdP.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [VerifyAssertionResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VerifyAssertionResponse> verifyAssertion(IdentitytoolkitRelyingpartyVerifyAssertionRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'verifyAssertion';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VerifyAssertionResponse.fromJson(data));
  }

  /**
   * Verifies the developer asserted ID token.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [VerifyCustomTokenResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VerifyCustomTokenResponse> verifyCustomToken(IdentitytoolkitRelyingpartyVerifyCustomTokenRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'verifyCustomToken';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VerifyCustomTokenResponse.fromJson(data));
  }

  /**
   * Verifies the user entered password.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [VerifyPasswordResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VerifyPasswordResponse> verifyPassword(IdentitytoolkitRelyingpartyVerifyPasswordRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'verifyPassword';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VerifyPasswordResponse.fromJson(data));
  }

}



/** Response of creating the IDP authentication URL. */
class CreateAuthUriResponse {
  /** all providers the user has once used to do federated login */
  core.List<core.String> allProviders;
  /** The URI used by the IDP to authenticate the user. */
  core.String authUri;
  /** True if captcha is required. */
  core.bool captchaRequired;
  /** True if the authUri is for user's existing provider. */
  core.bool forExistingProvider;
  /** The fixed string identitytoolkit#CreateAuthUriResponse". */
  core.String kind;
  /** The provider ID of the auth URI. */
  core.String providerId;
  /** Whether the user is registered if the identifier is an email. */
  core.bool registered;
  /**
   * Session ID which should be passed in the following verifyAssertion request.
   */
  core.String sessionId;

  CreateAuthUriResponse();

  CreateAuthUriResponse.fromJson(core.Map _json) {
    if (_json.containsKey("allProviders")) {
      allProviders = _json["allProviders"];
    }
    if (_json.containsKey("authUri")) {
      authUri = _json["authUri"];
    }
    if (_json.containsKey("captchaRequired")) {
      captchaRequired = _json["captchaRequired"];
    }
    if (_json.containsKey("forExistingProvider")) {
      forExistingProvider = _json["forExistingProvider"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("providerId")) {
      providerId = _json["providerId"];
    }
    if (_json.containsKey("registered")) {
      registered = _json["registered"];
    }
    if (_json.containsKey("sessionId")) {
      sessionId = _json["sessionId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allProviders != null) {
      _json["allProviders"] = allProviders;
    }
    if (authUri != null) {
      _json["authUri"] = authUri;
    }
    if (captchaRequired != null) {
      _json["captchaRequired"] = captchaRequired;
    }
    if (forExistingProvider != null) {
      _json["forExistingProvider"] = forExistingProvider;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (providerId != null) {
      _json["providerId"] = providerId;
    }
    if (registered != null) {
      _json["registered"] = registered;
    }
    if (sessionId != null) {
      _json["sessionId"] = sessionId;
    }
    return _json;
  }
}

/** Respone of deleting account. */
class DeleteAccountResponse {
  /** The fixed string "identitytoolkit#DeleteAccountResponse". */
  core.String kind;

  DeleteAccountResponse();

  DeleteAccountResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Response of downloading accounts in batch. */
class DownloadAccountResponse {
  /** The fixed string "identitytoolkit#DownloadAccountResponse". */
  core.String kind;
  /**
   * The next page token. To be used in a subsequent request to return the next
   * page of results.
   */
  core.String nextPageToken;
  /** The user accounts data. */
  core.List<UserInfo> users;

  DownloadAccountResponse();

  DownloadAccountResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("users")) {
      users = _json["users"].map((value) => new UserInfo.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (users != null) {
      _json["users"] = users.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Template for an email template. */
class EmailTemplate {
  /** Email body. */
  core.String body;
  /** Email body format. */
  core.String format;
  /** From address of the email. */
  core.String from;
  /** From display name. */
  core.String fromDisplayName;
  /** Reply-to address. */
  core.String replyTo;
  /** Subject of the email. */
  core.String subject;

  EmailTemplate();

  EmailTemplate.fromJson(core.Map _json) {
    if (_json.containsKey("body")) {
      body = _json["body"];
    }
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("from")) {
      from = _json["from"];
    }
    if (_json.containsKey("fromDisplayName")) {
      fromDisplayName = _json["fromDisplayName"];
    }
    if (_json.containsKey("replyTo")) {
      replyTo = _json["replyTo"];
    }
    if (_json.containsKey("subject")) {
      subject = _json["subject"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (body != null) {
      _json["body"] = body;
    }
    if (format != null) {
      _json["format"] = format;
    }
    if (from != null) {
      _json["from"] = from;
    }
    if (fromDisplayName != null) {
      _json["fromDisplayName"] = fromDisplayName;
    }
    if (replyTo != null) {
      _json["replyTo"] = replyTo;
    }
    if (subject != null) {
      _json["subject"] = subject;
    }
    return _json;
  }
}

/** Response of getting account information. */
class GetAccountInfoResponse {
  /** The fixed string "identitytoolkit#GetAccountInfoResponse". */
  core.String kind;
  /** The info of the users. */
  core.List<UserInfo> users;

  GetAccountInfoResponse();

  GetAccountInfoResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("users")) {
      users = _json["users"].map((value) => new UserInfo.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (users != null) {
      _json["users"] = users.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Response of getting a code for user confirmation (reset password, change
 * email etc.).
 */
class GetOobConfirmationCodeResponse {
  /** The email address that the email is sent to. */
  core.String email;
  /** The fixed string "identitytoolkit#GetOobConfirmationCodeResponse". */
  core.String kind;
  /** The code to be send to the user. */
  core.String oobCode;

  GetOobConfirmationCodeResponse();

  GetOobConfirmationCodeResponse.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("oobCode")) {
      oobCode = _json["oobCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (email != null) {
      _json["email"] = email;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (oobCode != null) {
      _json["oobCode"] = oobCode;
    }
    return _json;
  }
}

/** Response of getting recaptcha param. */
class GetRecaptchaParamResponse {
  /** The fixed string "identitytoolkit#GetRecaptchaParamResponse". */
  core.String kind;
  /** Site key registered at recaptcha. */
  core.String recaptchaSiteKey;
  /**
   * The stoken field for the recaptcha widget, used to request captcha
   * challenge.
   */
  core.String recaptchaStoken;

  GetRecaptchaParamResponse();

  GetRecaptchaParamResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("recaptchaSiteKey")) {
      recaptchaSiteKey = _json["recaptchaSiteKey"];
    }
    if (_json.containsKey("recaptchaStoken")) {
      recaptchaStoken = _json["recaptchaStoken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (recaptchaSiteKey != null) {
      _json["recaptchaSiteKey"] = recaptchaSiteKey;
    }
    if (recaptchaStoken != null) {
      _json["recaptchaStoken"] = recaptchaStoken;
    }
    return _json;
  }
}

/** Request to get the IDP authentication URL. */
class IdentitytoolkitRelyingpartyCreateAuthUriRequest {
  /**
   * The app ID of the mobile app, base64(CERT_SHA1):PACKAGE_NAME for Android,
   * BUNDLE_ID for iOS.
   */
  core.String appId;
  /**
   * Explicitly specify the auth flow type. Currently only support "CODE_FLOW"
   * type. The field is only used for Google provider.
   */
  core.String authFlowType;
  /** The relying party OAuth client ID. */
  core.String clientId;
  /**
   * The opaque value used by the client to maintain context info between the
   * authentication request and the IDP callback.
   */
  core.String context;
  /**
   * The URI to which the IDP redirects the user after the federated login flow.
   */
  core.String continueUri;
  /**
   * The query parameter that client can customize by themselves in auth url.
   * The following parameters are reserved for server so that they cannot be
   * customized by clients: client_id, response_type, scope, redirect_uri,
   * state, oauth_token.
   */
  core.Map<core.String, core.String> customParameter;
  /**
   * The hosted domain to restrict sign-in to accounts at that domain for Google
   * Apps hosted accounts.
   */
  core.String hostedDomain;
  /** The email or federated ID of the user. */
  core.String identifier;
  /** The developer's consumer key for OpenId OAuth Extension */
  core.String oauthConsumerKey;
  /**
   * Additional oauth scopes, beyond the basid user profile, that the user would
   * be prompted to grant
   */
  core.String oauthScope;
  /**
   * Optional realm for OpenID protocol. The sub string "scheme://domain:port"
   * of the param "continueUri" is used if this is not set.
   */
  core.String openidRealm;
  /** The native app package for OTA installation. */
  core.String otaApp;
  /**
   * The IdP ID. For white listed IdPs it's a short domain name e.g. google.com,
   * aol.com, live.net and yahoo.com. For other OpenID IdPs it's the OP
   * identifier.
   */
  core.String providerId;
  /** The session_id passed by client. */
  core.String sessionId;

  IdentitytoolkitRelyingpartyCreateAuthUriRequest();

  IdentitytoolkitRelyingpartyCreateAuthUriRequest.fromJson(core.Map _json) {
    if (_json.containsKey("appId")) {
      appId = _json["appId"];
    }
    if (_json.containsKey("authFlowType")) {
      authFlowType = _json["authFlowType"];
    }
    if (_json.containsKey("clientId")) {
      clientId = _json["clientId"];
    }
    if (_json.containsKey("context")) {
      context = _json["context"];
    }
    if (_json.containsKey("continueUri")) {
      continueUri = _json["continueUri"];
    }
    if (_json.containsKey("customParameter")) {
      customParameter = _json["customParameter"];
    }
    if (_json.containsKey("hostedDomain")) {
      hostedDomain = _json["hostedDomain"];
    }
    if (_json.containsKey("identifier")) {
      identifier = _json["identifier"];
    }
    if (_json.containsKey("oauthConsumerKey")) {
      oauthConsumerKey = _json["oauthConsumerKey"];
    }
    if (_json.containsKey("oauthScope")) {
      oauthScope = _json["oauthScope"];
    }
    if (_json.containsKey("openidRealm")) {
      openidRealm = _json["openidRealm"];
    }
    if (_json.containsKey("otaApp")) {
      otaApp = _json["otaApp"];
    }
    if (_json.containsKey("providerId")) {
      providerId = _json["providerId"];
    }
    if (_json.containsKey("sessionId")) {
      sessionId = _json["sessionId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (appId != null) {
      _json["appId"] = appId;
    }
    if (authFlowType != null) {
      _json["authFlowType"] = authFlowType;
    }
    if (clientId != null) {
      _json["clientId"] = clientId;
    }
    if (context != null) {
      _json["context"] = context;
    }
    if (continueUri != null) {
      _json["continueUri"] = continueUri;
    }
    if (customParameter != null) {
      _json["customParameter"] = customParameter;
    }
    if (hostedDomain != null) {
      _json["hostedDomain"] = hostedDomain;
    }
    if (identifier != null) {
      _json["identifier"] = identifier;
    }
    if (oauthConsumerKey != null) {
      _json["oauthConsumerKey"] = oauthConsumerKey;
    }
    if (oauthScope != null) {
      _json["oauthScope"] = oauthScope;
    }
    if (openidRealm != null) {
      _json["openidRealm"] = openidRealm;
    }
    if (otaApp != null) {
      _json["otaApp"] = otaApp;
    }
    if (providerId != null) {
      _json["providerId"] = providerId;
    }
    if (sessionId != null) {
      _json["sessionId"] = sessionId;
    }
    return _json;
  }
}

/** Request to delete account. */
class IdentitytoolkitRelyingpartyDeleteAccountRequest {
  /**
   * GCP project number of the requesting delegated app. Currently only intended
   * for Firebase V1 migration.
   */
  core.String delegatedProjectNumber;
  /** The GITKit token or STS id token of the authenticated user. */
  core.String idToken;
  /** The local ID of the user. */
  core.String localId;

  IdentitytoolkitRelyingpartyDeleteAccountRequest();

  IdentitytoolkitRelyingpartyDeleteAccountRequest.fromJson(core.Map _json) {
    if (_json.containsKey("delegatedProjectNumber")) {
      delegatedProjectNumber = _json["delegatedProjectNumber"];
    }
    if (_json.containsKey("idToken")) {
      idToken = _json["idToken"];
    }
    if (_json.containsKey("localId")) {
      localId = _json["localId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (delegatedProjectNumber != null) {
      _json["delegatedProjectNumber"] = delegatedProjectNumber;
    }
    if (idToken != null) {
      _json["idToken"] = idToken;
    }
    if (localId != null) {
      _json["localId"] = localId;
    }
    return _json;
  }
}

/** Request to download user account in batch. */
class IdentitytoolkitRelyingpartyDownloadAccountRequest {
  /**
   * GCP project number of the requesting delegated app. Currently only intended
   * for Firebase V1 migration.
   */
  core.String delegatedProjectNumber;
  /** The max number of results to return in the response. */
  core.int maxResults;
  /**
   * The token for the next page. This should be taken from the previous
   * response.
   */
  core.String nextPageToken;
  /**
   * Specify which project (field value is actually project id) to operate. Only
   * used when provided credential.
   */
  core.String targetProjectId;

  IdentitytoolkitRelyingpartyDownloadAccountRequest();

  IdentitytoolkitRelyingpartyDownloadAccountRequest.fromJson(core.Map _json) {
    if (_json.containsKey("delegatedProjectNumber")) {
      delegatedProjectNumber = _json["delegatedProjectNumber"];
    }
    if (_json.containsKey("maxResults")) {
      maxResults = _json["maxResults"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("targetProjectId")) {
      targetProjectId = _json["targetProjectId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (delegatedProjectNumber != null) {
      _json["delegatedProjectNumber"] = delegatedProjectNumber;
    }
    if (maxResults != null) {
      _json["maxResults"] = maxResults;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (targetProjectId != null) {
      _json["targetProjectId"] = targetProjectId;
    }
    return _json;
  }
}

/** Request to get the account information. */
class IdentitytoolkitRelyingpartyGetAccountInfoRequest {
  /**
   * GCP project number of the requesting delegated app. Currently only intended
   * for Firebase V1 migration.
   */
  core.String delegatedProjectNumber;
  /** The list of emails of the users to inquiry. */
  core.List<core.String> email;
  /** The GITKit token of the authenticated user. */
  core.String idToken;
  /** The list of local ID's of the users to inquiry. */
  core.List<core.String> localId;

  IdentitytoolkitRelyingpartyGetAccountInfoRequest();

  IdentitytoolkitRelyingpartyGetAccountInfoRequest.fromJson(core.Map _json) {
    if (_json.containsKey("delegatedProjectNumber")) {
      delegatedProjectNumber = _json["delegatedProjectNumber"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("idToken")) {
      idToken = _json["idToken"];
    }
    if (_json.containsKey("localId")) {
      localId = _json["localId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (delegatedProjectNumber != null) {
      _json["delegatedProjectNumber"] = delegatedProjectNumber;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (idToken != null) {
      _json["idToken"] = idToken;
    }
    if (localId != null) {
      _json["localId"] = localId;
    }
    return _json;
  }
}

/** Response of getting the project configuration. */
class IdentitytoolkitRelyingpartyGetProjectConfigResponse {
  /** Whether to allow password user sign in or sign up. */
  core.bool allowPasswordUser;
  /** Browser API key, needed when making http request to Apiary. */
  core.String apiKey;
  /** Authorized domains. */
  core.List<core.String> authorizedDomains;
  /** Change email template. */
  EmailTemplate changeEmailTemplate;
  core.String dynamicLinksDomain;
  /** Whether anonymous user is enabled. */
  core.bool enableAnonymousUser;
  /** OAuth2 provider configuration. */
  core.List<IdpConfig> idpConfig;
  /** Legacy reset password email template. */
  EmailTemplate legacyResetPasswordTemplate;
  /** Project ID of the relying party. */
  core.String projectId;
  /** Reset password email template. */
  EmailTemplate resetPasswordTemplate;
  /** Whether to use email sending provided by Firebear. */
  core.bool useEmailSending;
  /** Verify email template. */
  EmailTemplate verifyEmailTemplate;

  IdentitytoolkitRelyingpartyGetProjectConfigResponse();

  IdentitytoolkitRelyingpartyGetProjectConfigResponse.fromJson(core.Map _json) {
    if (_json.containsKey("allowPasswordUser")) {
      allowPasswordUser = _json["allowPasswordUser"];
    }
    if (_json.containsKey("apiKey")) {
      apiKey = _json["apiKey"];
    }
    if (_json.containsKey("authorizedDomains")) {
      authorizedDomains = _json["authorizedDomains"];
    }
    if (_json.containsKey("changeEmailTemplate")) {
      changeEmailTemplate = new EmailTemplate.fromJson(_json["changeEmailTemplate"]);
    }
    if (_json.containsKey("dynamicLinksDomain")) {
      dynamicLinksDomain = _json["dynamicLinksDomain"];
    }
    if (_json.containsKey("enableAnonymousUser")) {
      enableAnonymousUser = _json["enableAnonymousUser"];
    }
    if (_json.containsKey("idpConfig")) {
      idpConfig = _json["idpConfig"].map((value) => new IdpConfig.fromJson(value)).toList();
    }
    if (_json.containsKey("legacyResetPasswordTemplate")) {
      legacyResetPasswordTemplate = new EmailTemplate.fromJson(_json["legacyResetPasswordTemplate"]);
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("resetPasswordTemplate")) {
      resetPasswordTemplate = new EmailTemplate.fromJson(_json["resetPasswordTemplate"]);
    }
    if (_json.containsKey("useEmailSending")) {
      useEmailSending = _json["useEmailSending"];
    }
    if (_json.containsKey("verifyEmailTemplate")) {
      verifyEmailTemplate = new EmailTemplate.fromJson(_json["verifyEmailTemplate"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowPasswordUser != null) {
      _json["allowPasswordUser"] = allowPasswordUser;
    }
    if (apiKey != null) {
      _json["apiKey"] = apiKey;
    }
    if (authorizedDomains != null) {
      _json["authorizedDomains"] = authorizedDomains;
    }
    if (changeEmailTemplate != null) {
      _json["changeEmailTemplate"] = (changeEmailTemplate).toJson();
    }
    if (dynamicLinksDomain != null) {
      _json["dynamicLinksDomain"] = dynamicLinksDomain;
    }
    if (enableAnonymousUser != null) {
      _json["enableAnonymousUser"] = enableAnonymousUser;
    }
    if (idpConfig != null) {
      _json["idpConfig"] = idpConfig.map((value) => (value).toJson()).toList();
    }
    if (legacyResetPasswordTemplate != null) {
      _json["legacyResetPasswordTemplate"] = (legacyResetPasswordTemplate).toJson();
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (resetPasswordTemplate != null) {
      _json["resetPasswordTemplate"] = (resetPasswordTemplate).toJson();
    }
    if (useEmailSending != null) {
      _json["useEmailSending"] = useEmailSending;
    }
    if (verifyEmailTemplate != null) {
      _json["verifyEmailTemplate"] = (verifyEmailTemplate).toJson();
    }
    return _json;
  }
}

/** Respone of getting public keys. */
class IdentitytoolkitRelyingpartyGetPublicKeysResponse
    extends collection.MapBase<core.String, core.String> {
  final core.Map _innerMap = {};

  IdentitytoolkitRelyingpartyGetPublicKeysResponse();

  IdentitytoolkitRelyingpartyGetPublicKeysResponse.fromJson(core.Map _json) {
    _json.forEach((core.String key, value) {
      this[key] = value;
    });
  }

  core.Map toJson() {
    var _json = {};
    this.forEach((core.String key, value) {
      _json[key] = value;
    });
    return _json;
  }

  core.String operator [](core.Object key)
      => _innerMap[key];

  operator []=(core.String key, core.String value) {
    _innerMap[key] = value;
  }

  void clear() {
    _innerMap.clear();
  }

  core.Iterable<core.String> get keys => _innerMap.keys;

  core.String remove(core.Object key) => _innerMap.remove(key);
}

/** Request to reset the password. */
class IdentitytoolkitRelyingpartyResetPasswordRequest {
  /** The email address of the user. */
  core.String email;
  /** The new password inputted by the user. */
  core.String newPassword;
  /** The old password inputted by the user. */
  core.String oldPassword;
  /** The confirmation code. */
  core.String oobCode;

  IdentitytoolkitRelyingpartyResetPasswordRequest();

  IdentitytoolkitRelyingpartyResetPasswordRequest.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("newPassword")) {
      newPassword = _json["newPassword"];
    }
    if (_json.containsKey("oldPassword")) {
      oldPassword = _json["oldPassword"];
    }
    if (_json.containsKey("oobCode")) {
      oobCode = _json["oobCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (email != null) {
      _json["email"] = email;
    }
    if (newPassword != null) {
      _json["newPassword"] = newPassword;
    }
    if (oldPassword != null) {
      _json["oldPassword"] = oldPassword;
    }
    if (oobCode != null) {
      _json["oobCode"] = oobCode;
    }
    return _json;
  }
}

/** Request to set the account information. */
class IdentitytoolkitRelyingpartySetAccountInfoRequest {
  /** The captcha challenge. */
  core.String captchaChallenge;
  /** Response to the captcha. */
  core.String captchaResponse;
  /** The timestamp when the account is created. */
  core.String createdAt;
  /**
   * GCP project number of the requesting delegated app. Currently only intended
   * for Firebase V1 migration.
   */
  core.String delegatedProjectNumber;
  /** The attributes users request to delete. */
  core.List<core.String> deleteAttribute;
  /** The IDPs the user request to delete. */
  core.List<core.String> deleteProvider;
  /** Whether to disable the user. */
  core.bool disableUser;
  /** The name of the user. */
  core.String displayName;
  /** The email of the user. */
  core.String email;
  /** Mark the email as verified or not. */
  core.bool emailVerified;
  /** The GITKit token of the authenticated user. */
  core.String idToken;
  /** Instance id token of the app. */
  core.String instanceId;
  /** Last login timestamp. */
  core.String lastLoginAt;
  /** The local ID of the user. */
  core.String localId;
  /** The out-of-band code of the change email request. */
  core.String oobCode;
  /** The new password of the user. */
  core.String password;
  /** The photo url of the user. */
  core.String photoUrl;
  /** The associated IDPs of the user. */
  core.List<core.String> provider;
  /** Whether return sts id token and refresh token instead of gitkit token. */
  core.bool returnSecureToken;
  /** Mark the user to upgrade to federated login. */
  core.bool upgradeToFederatedLogin;
  /** Timestamp in seconds for valid login token. */
  core.String validSince;

  IdentitytoolkitRelyingpartySetAccountInfoRequest();

  IdentitytoolkitRelyingpartySetAccountInfoRequest.fromJson(core.Map _json) {
    if (_json.containsKey("captchaChallenge")) {
      captchaChallenge = _json["captchaChallenge"];
    }
    if (_json.containsKey("captchaResponse")) {
      captchaResponse = _json["captchaResponse"];
    }
    if (_json.containsKey("createdAt")) {
      createdAt = _json["createdAt"];
    }
    if (_json.containsKey("delegatedProjectNumber")) {
      delegatedProjectNumber = _json["delegatedProjectNumber"];
    }
    if (_json.containsKey("deleteAttribute")) {
      deleteAttribute = _json["deleteAttribute"];
    }
    if (_json.containsKey("deleteProvider")) {
      deleteProvider = _json["deleteProvider"];
    }
    if (_json.containsKey("disableUser")) {
      disableUser = _json["disableUser"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("emailVerified")) {
      emailVerified = _json["emailVerified"];
    }
    if (_json.containsKey("idToken")) {
      idToken = _json["idToken"];
    }
    if (_json.containsKey("instanceId")) {
      instanceId = _json["instanceId"];
    }
    if (_json.containsKey("lastLoginAt")) {
      lastLoginAt = _json["lastLoginAt"];
    }
    if (_json.containsKey("localId")) {
      localId = _json["localId"];
    }
    if (_json.containsKey("oobCode")) {
      oobCode = _json["oobCode"];
    }
    if (_json.containsKey("password")) {
      password = _json["password"];
    }
    if (_json.containsKey("photoUrl")) {
      photoUrl = _json["photoUrl"];
    }
    if (_json.containsKey("provider")) {
      provider = _json["provider"];
    }
    if (_json.containsKey("returnSecureToken")) {
      returnSecureToken = _json["returnSecureToken"];
    }
    if (_json.containsKey("upgradeToFederatedLogin")) {
      upgradeToFederatedLogin = _json["upgradeToFederatedLogin"];
    }
    if (_json.containsKey("validSince")) {
      validSince = _json["validSince"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (captchaChallenge != null) {
      _json["captchaChallenge"] = captchaChallenge;
    }
    if (captchaResponse != null) {
      _json["captchaResponse"] = captchaResponse;
    }
    if (createdAt != null) {
      _json["createdAt"] = createdAt;
    }
    if (delegatedProjectNumber != null) {
      _json["delegatedProjectNumber"] = delegatedProjectNumber;
    }
    if (deleteAttribute != null) {
      _json["deleteAttribute"] = deleteAttribute;
    }
    if (deleteProvider != null) {
      _json["deleteProvider"] = deleteProvider;
    }
    if (disableUser != null) {
      _json["disableUser"] = disableUser;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (emailVerified != null) {
      _json["emailVerified"] = emailVerified;
    }
    if (idToken != null) {
      _json["idToken"] = idToken;
    }
    if (instanceId != null) {
      _json["instanceId"] = instanceId;
    }
    if (lastLoginAt != null) {
      _json["lastLoginAt"] = lastLoginAt;
    }
    if (localId != null) {
      _json["localId"] = localId;
    }
    if (oobCode != null) {
      _json["oobCode"] = oobCode;
    }
    if (password != null) {
      _json["password"] = password;
    }
    if (photoUrl != null) {
      _json["photoUrl"] = photoUrl;
    }
    if (provider != null) {
      _json["provider"] = provider;
    }
    if (returnSecureToken != null) {
      _json["returnSecureToken"] = returnSecureToken;
    }
    if (upgradeToFederatedLogin != null) {
      _json["upgradeToFederatedLogin"] = upgradeToFederatedLogin;
    }
    if (validSince != null) {
      _json["validSince"] = validSince;
    }
    return _json;
  }
}

/** Request to set the project configuration. */
class IdentitytoolkitRelyingpartySetProjectConfigRequest {
  /** Whether to allow password user sign in or sign up. */
  core.bool allowPasswordUser;
  /** Browser API key, needed when making http request to Apiary. */
  core.String apiKey;
  /** Authorized domains for widget redirect. */
  core.List<core.String> authorizedDomains;
  /** Change email template. */
  EmailTemplate changeEmailTemplate;
  /**
   * GCP project number of the requesting delegated app. Currently only intended
   * for Firebase V1 migration.
   */
  core.String delegatedProjectNumber;
  /** Whether to enable anonymous user. */
  core.bool enableAnonymousUser;
  /** Oauth2 provider configuration. */
  core.List<IdpConfig> idpConfig;
  /** Legacy reset password email template. */
  EmailTemplate legacyResetPasswordTemplate;
  /** Reset password email template. */
  EmailTemplate resetPasswordTemplate;
  /** Whether to use email sending provided by Firebear. */
  core.bool useEmailSending;
  /** Verify email template. */
  EmailTemplate verifyEmailTemplate;

  IdentitytoolkitRelyingpartySetProjectConfigRequest();

  IdentitytoolkitRelyingpartySetProjectConfigRequest.fromJson(core.Map _json) {
    if (_json.containsKey("allowPasswordUser")) {
      allowPasswordUser = _json["allowPasswordUser"];
    }
    if (_json.containsKey("apiKey")) {
      apiKey = _json["apiKey"];
    }
    if (_json.containsKey("authorizedDomains")) {
      authorizedDomains = _json["authorizedDomains"];
    }
    if (_json.containsKey("changeEmailTemplate")) {
      changeEmailTemplate = new EmailTemplate.fromJson(_json["changeEmailTemplate"]);
    }
    if (_json.containsKey("delegatedProjectNumber")) {
      delegatedProjectNumber = _json["delegatedProjectNumber"];
    }
    if (_json.containsKey("enableAnonymousUser")) {
      enableAnonymousUser = _json["enableAnonymousUser"];
    }
    if (_json.containsKey("idpConfig")) {
      idpConfig = _json["idpConfig"].map((value) => new IdpConfig.fromJson(value)).toList();
    }
    if (_json.containsKey("legacyResetPasswordTemplate")) {
      legacyResetPasswordTemplate = new EmailTemplate.fromJson(_json["legacyResetPasswordTemplate"]);
    }
    if (_json.containsKey("resetPasswordTemplate")) {
      resetPasswordTemplate = new EmailTemplate.fromJson(_json["resetPasswordTemplate"]);
    }
    if (_json.containsKey("useEmailSending")) {
      useEmailSending = _json["useEmailSending"];
    }
    if (_json.containsKey("verifyEmailTemplate")) {
      verifyEmailTemplate = new EmailTemplate.fromJson(_json["verifyEmailTemplate"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowPasswordUser != null) {
      _json["allowPasswordUser"] = allowPasswordUser;
    }
    if (apiKey != null) {
      _json["apiKey"] = apiKey;
    }
    if (authorizedDomains != null) {
      _json["authorizedDomains"] = authorizedDomains;
    }
    if (changeEmailTemplate != null) {
      _json["changeEmailTemplate"] = (changeEmailTemplate).toJson();
    }
    if (delegatedProjectNumber != null) {
      _json["delegatedProjectNumber"] = delegatedProjectNumber;
    }
    if (enableAnonymousUser != null) {
      _json["enableAnonymousUser"] = enableAnonymousUser;
    }
    if (idpConfig != null) {
      _json["idpConfig"] = idpConfig.map((value) => (value).toJson()).toList();
    }
    if (legacyResetPasswordTemplate != null) {
      _json["legacyResetPasswordTemplate"] = (legacyResetPasswordTemplate).toJson();
    }
    if (resetPasswordTemplate != null) {
      _json["resetPasswordTemplate"] = (resetPasswordTemplate).toJson();
    }
    if (useEmailSending != null) {
      _json["useEmailSending"] = useEmailSending;
    }
    if (verifyEmailTemplate != null) {
      _json["verifyEmailTemplate"] = (verifyEmailTemplate).toJson();
    }
    return _json;
  }
}

/** Response of setting the project configuration. */
class IdentitytoolkitRelyingpartySetProjectConfigResponse {
  /** Project ID of the relying party. */
  core.String projectId;

  IdentitytoolkitRelyingpartySetProjectConfigResponse();

  IdentitytoolkitRelyingpartySetProjectConfigResponse.fromJson(core.Map _json) {
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    return _json;
  }
}

/** Request to sign out user. */
class IdentitytoolkitRelyingpartySignOutUserRequest {
  /** Instance id token of the app. */
  core.String instanceId;
  /** The local ID of the user. */
  core.String localId;

  IdentitytoolkitRelyingpartySignOutUserRequest();

  IdentitytoolkitRelyingpartySignOutUserRequest.fromJson(core.Map _json) {
    if (_json.containsKey("instanceId")) {
      instanceId = _json["instanceId"];
    }
    if (_json.containsKey("localId")) {
      localId = _json["localId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (instanceId != null) {
      _json["instanceId"] = instanceId;
    }
    if (localId != null) {
      _json["localId"] = localId;
    }
    return _json;
  }
}

/** Response of signing out user. */
class IdentitytoolkitRelyingpartySignOutUserResponse {
  /** The local ID of the user. */
  core.String localId;

  IdentitytoolkitRelyingpartySignOutUserResponse();

  IdentitytoolkitRelyingpartySignOutUserResponse.fromJson(core.Map _json) {
    if (_json.containsKey("localId")) {
      localId = _json["localId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (localId != null) {
      _json["localId"] = localId;
    }
    return _json;
  }
}

/**
 * Request to signup new user, create anonymous user or anonymous user reauth.
 */
class IdentitytoolkitRelyingpartySignupNewUserRequest {
  /** The captcha challenge. */
  core.String captchaChallenge;
  /** Response to the captcha. */
  core.String captchaResponse;
  /** Whether to disable the user. Only can be used by service account. */
  core.bool disabled;
  /** The name of the user. */
  core.String displayName;
  /** The email of the user. */
  core.String email;
  /**
   * Mark the email as verified or not. Only can be used by service account.
   */
  core.bool emailVerified;
  /** The GITKit token of the authenticated user. */
  core.String idToken;
  /** Instance id token of the app. */
  core.String instanceId;
  /** Privileged caller can create user with specified user id. */
  core.String localId;
  /** The new password of the user. */
  core.String password;
  /** The photo url of the user. */
  core.String photoUrl;

  IdentitytoolkitRelyingpartySignupNewUserRequest();

  IdentitytoolkitRelyingpartySignupNewUserRequest.fromJson(core.Map _json) {
    if (_json.containsKey("captchaChallenge")) {
      captchaChallenge = _json["captchaChallenge"];
    }
    if (_json.containsKey("captchaResponse")) {
      captchaResponse = _json["captchaResponse"];
    }
    if (_json.containsKey("disabled")) {
      disabled = _json["disabled"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("emailVerified")) {
      emailVerified = _json["emailVerified"];
    }
    if (_json.containsKey("idToken")) {
      idToken = _json["idToken"];
    }
    if (_json.containsKey("instanceId")) {
      instanceId = _json["instanceId"];
    }
    if (_json.containsKey("localId")) {
      localId = _json["localId"];
    }
    if (_json.containsKey("password")) {
      password = _json["password"];
    }
    if (_json.containsKey("photoUrl")) {
      photoUrl = _json["photoUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (captchaChallenge != null) {
      _json["captchaChallenge"] = captchaChallenge;
    }
    if (captchaResponse != null) {
      _json["captchaResponse"] = captchaResponse;
    }
    if (disabled != null) {
      _json["disabled"] = disabled;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (emailVerified != null) {
      _json["emailVerified"] = emailVerified;
    }
    if (idToken != null) {
      _json["idToken"] = idToken;
    }
    if (instanceId != null) {
      _json["instanceId"] = instanceId;
    }
    if (localId != null) {
      _json["localId"] = localId;
    }
    if (password != null) {
      _json["password"] = password;
    }
    if (photoUrl != null) {
      _json["photoUrl"] = photoUrl;
    }
    return _json;
  }
}

/** Request to upload user account in batch. */
class IdentitytoolkitRelyingpartyUploadAccountRequest {
  /** Whether allow overwrite existing account when user local_id exists. */
  core.bool allowOverwrite;
  /**
   * GCP project number of the requesting delegated app. Currently only intended
   * for Firebase V1 migration.
   */
  core.String delegatedProjectNumber;
  /** The password hash algorithm. */
  core.String hashAlgorithm;
  /** Memory cost for hash calculation. Used by scrypt similar algorithms. */
  core.int memoryCost;
  /** Rounds for hash calculation. Used by scrypt and similar algorithms. */
  core.int rounds;
  /** The salt separator. */
  core.String saltSeparator;
  core.List<core.int> get saltSeparatorAsBytes {
    return convert.BASE64.decode(saltSeparator);
  }

  void set saltSeparatorAsBytes(core.List<core.int> _bytes) {
    saltSeparator = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * If true, backend will do sanity check(including duplicate email and
   * federated id) when uploading account.
   */
  core.bool sanityCheck;
  /** The key for to hash the password. */
  core.String signerKey;
  core.List<core.int> get signerKeyAsBytes {
    return convert.BASE64.decode(signerKey);
  }

  void set signerKeyAsBytes(core.List<core.int> _bytes) {
    signerKey = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * Specify which project (field value is actually project id) to operate. Only
   * used when provided credential.
   */
  core.String targetProjectId;
  /** The account info to be stored. */
  core.List<UserInfo> users;

  IdentitytoolkitRelyingpartyUploadAccountRequest();

  IdentitytoolkitRelyingpartyUploadAccountRequest.fromJson(core.Map _json) {
    if (_json.containsKey("allowOverwrite")) {
      allowOverwrite = _json["allowOverwrite"];
    }
    if (_json.containsKey("delegatedProjectNumber")) {
      delegatedProjectNumber = _json["delegatedProjectNumber"];
    }
    if (_json.containsKey("hashAlgorithm")) {
      hashAlgorithm = _json["hashAlgorithm"];
    }
    if (_json.containsKey("memoryCost")) {
      memoryCost = _json["memoryCost"];
    }
    if (_json.containsKey("rounds")) {
      rounds = _json["rounds"];
    }
    if (_json.containsKey("saltSeparator")) {
      saltSeparator = _json["saltSeparator"];
    }
    if (_json.containsKey("sanityCheck")) {
      sanityCheck = _json["sanityCheck"];
    }
    if (_json.containsKey("signerKey")) {
      signerKey = _json["signerKey"];
    }
    if (_json.containsKey("targetProjectId")) {
      targetProjectId = _json["targetProjectId"];
    }
    if (_json.containsKey("users")) {
      users = _json["users"].map((value) => new UserInfo.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowOverwrite != null) {
      _json["allowOverwrite"] = allowOverwrite;
    }
    if (delegatedProjectNumber != null) {
      _json["delegatedProjectNumber"] = delegatedProjectNumber;
    }
    if (hashAlgorithm != null) {
      _json["hashAlgorithm"] = hashAlgorithm;
    }
    if (memoryCost != null) {
      _json["memoryCost"] = memoryCost;
    }
    if (rounds != null) {
      _json["rounds"] = rounds;
    }
    if (saltSeparator != null) {
      _json["saltSeparator"] = saltSeparator;
    }
    if (sanityCheck != null) {
      _json["sanityCheck"] = sanityCheck;
    }
    if (signerKey != null) {
      _json["signerKey"] = signerKey;
    }
    if (targetProjectId != null) {
      _json["targetProjectId"] = targetProjectId;
    }
    if (users != null) {
      _json["users"] = users.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Request to verify the IDP assertion. */
class IdentitytoolkitRelyingpartyVerifyAssertionRequest {
  /**
   * GCP project number of the requesting delegated app. Currently only intended
   * for Firebase V1 migration.
   */
  core.String delegatedProjectNumber;
  /** The GITKit token of the authenticated user. */
  core.String idToken;
  /** Instance id token of the app. */
  core.String instanceId;
  /**
   * The GITKit token for the non-trusted IDP pending to be confirmed by the
   * user.
   */
  core.String pendingIdToken;
  /** The post body if the request is a HTTP POST. */
  core.String postBody;
  /**
   * The URI to which the IDP redirects the user back. It may contain federated
   * login result params added by the IDP.
   */
  core.String requestUri;
  /**
   * Whether return 200 and IDP credential rather than throw exception when
   * federated id is already linked.
   */
  core.bool returnIdpCredential;
  /** Whether to return refresh tokens. */
  core.bool returnRefreshToken;
  /** Whether return sts id token and refresh token instead of gitkit token. */
  core.bool returnSecureToken;
  /**
   * Session ID, which should match the one in previous createAuthUri request.
   */
  core.String sessionId;

  IdentitytoolkitRelyingpartyVerifyAssertionRequest();

  IdentitytoolkitRelyingpartyVerifyAssertionRequest.fromJson(core.Map _json) {
    if (_json.containsKey("delegatedProjectNumber")) {
      delegatedProjectNumber = _json["delegatedProjectNumber"];
    }
    if (_json.containsKey("idToken")) {
      idToken = _json["idToken"];
    }
    if (_json.containsKey("instanceId")) {
      instanceId = _json["instanceId"];
    }
    if (_json.containsKey("pendingIdToken")) {
      pendingIdToken = _json["pendingIdToken"];
    }
    if (_json.containsKey("postBody")) {
      postBody = _json["postBody"];
    }
    if (_json.containsKey("requestUri")) {
      requestUri = _json["requestUri"];
    }
    if (_json.containsKey("returnIdpCredential")) {
      returnIdpCredential = _json["returnIdpCredential"];
    }
    if (_json.containsKey("returnRefreshToken")) {
      returnRefreshToken = _json["returnRefreshToken"];
    }
    if (_json.containsKey("returnSecureToken")) {
      returnSecureToken = _json["returnSecureToken"];
    }
    if (_json.containsKey("sessionId")) {
      sessionId = _json["sessionId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (delegatedProjectNumber != null) {
      _json["delegatedProjectNumber"] = delegatedProjectNumber;
    }
    if (idToken != null) {
      _json["idToken"] = idToken;
    }
    if (instanceId != null) {
      _json["instanceId"] = instanceId;
    }
    if (pendingIdToken != null) {
      _json["pendingIdToken"] = pendingIdToken;
    }
    if (postBody != null) {
      _json["postBody"] = postBody;
    }
    if (requestUri != null) {
      _json["requestUri"] = requestUri;
    }
    if (returnIdpCredential != null) {
      _json["returnIdpCredential"] = returnIdpCredential;
    }
    if (returnRefreshToken != null) {
      _json["returnRefreshToken"] = returnRefreshToken;
    }
    if (returnSecureToken != null) {
      _json["returnSecureToken"] = returnSecureToken;
    }
    if (sessionId != null) {
      _json["sessionId"] = sessionId;
    }
    return _json;
  }
}

/** Request to verify a custom token */
class IdentitytoolkitRelyingpartyVerifyCustomTokenRequest {
  /**
   * GCP project number of the requesting delegated app. Currently only intended
   * for Firebase V1 migration.
   */
  core.String delegatedProjectNumber;
  /** Instance id token of the app. */
  core.String instanceId;
  /** Whether return sts id token and refresh token instead of gitkit token. */
  core.bool returnSecureToken;
  /** The custom token to verify */
  core.String token;

  IdentitytoolkitRelyingpartyVerifyCustomTokenRequest();

  IdentitytoolkitRelyingpartyVerifyCustomTokenRequest.fromJson(core.Map _json) {
    if (_json.containsKey("delegatedProjectNumber")) {
      delegatedProjectNumber = _json["delegatedProjectNumber"];
    }
    if (_json.containsKey("instanceId")) {
      instanceId = _json["instanceId"];
    }
    if (_json.containsKey("returnSecureToken")) {
      returnSecureToken = _json["returnSecureToken"];
    }
    if (_json.containsKey("token")) {
      token = _json["token"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (delegatedProjectNumber != null) {
      _json["delegatedProjectNumber"] = delegatedProjectNumber;
    }
    if (instanceId != null) {
      _json["instanceId"] = instanceId;
    }
    if (returnSecureToken != null) {
      _json["returnSecureToken"] = returnSecureToken;
    }
    if (token != null) {
      _json["token"] = token;
    }
    return _json;
  }
}

/** Request to verify the password. */
class IdentitytoolkitRelyingpartyVerifyPasswordRequest {
  /** The captcha challenge. */
  core.String captchaChallenge;
  /** Response to the captcha. */
  core.String captchaResponse;
  /**
   * GCP project number of the requesting delegated app. Currently only intended
   * for Firebase V1 migration.
   */
  core.String delegatedProjectNumber;
  /** The email of the user. */
  core.String email;
  /** The GITKit token of the authenticated user. */
  core.String idToken;
  /** Instance id token of the app. */
  core.String instanceId;
  /** The password inputed by the user. */
  core.String password;
  /**
   * The GITKit token for the non-trusted IDP, which is to be confirmed by the
   * user.
   */
  core.String pendingIdToken;
  /** Whether return sts id token and refresh token instead of gitkit token. */
  core.bool returnSecureToken;

  IdentitytoolkitRelyingpartyVerifyPasswordRequest();

  IdentitytoolkitRelyingpartyVerifyPasswordRequest.fromJson(core.Map _json) {
    if (_json.containsKey("captchaChallenge")) {
      captchaChallenge = _json["captchaChallenge"];
    }
    if (_json.containsKey("captchaResponse")) {
      captchaResponse = _json["captchaResponse"];
    }
    if (_json.containsKey("delegatedProjectNumber")) {
      delegatedProjectNumber = _json["delegatedProjectNumber"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("idToken")) {
      idToken = _json["idToken"];
    }
    if (_json.containsKey("instanceId")) {
      instanceId = _json["instanceId"];
    }
    if (_json.containsKey("password")) {
      password = _json["password"];
    }
    if (_json.containsKey("pendingIdToken")) {
      pendingIdToken = _json["pendingIdToken"];
    }
    if (_json.containsKey("returnSecureToken")) {
      returnSecureToken = _json["returnSecureToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (captchaChallenge != null) {
      _json["captchaChallenge"] = captchaChallenge;
    }
    if (captchaResponse != null) {
      _json["captchaResponse"] = captchaResponse;
    }
    if (delegatedProjectNumber != null) {
      _json["delegatedProjectNumber"] = delegatedProjectNumber;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (idToken != null) {
      _json["idToken"] = idToken;
    }
    if (instanceId != null) {
      _json["instanceId"] = instanceId;
    }
    if (password != null) {
      _json["password"] = password;
    }
    if (pendingIdToken != null) {
      _json["pendingIdToken"] = pendingIdToken;
    }
    if (returnSecureToken != null) {
      _json["returnSecureToken"] = returnSecureToken;
    }
    return _json;
  }
}

/** Template for a single idp configuration. */
class IdpConfig {
  /** OAuth2 client ID. */
  core.String clientId;
  /** Whether this IDP is enabled. */
  core.bool enabled;
  /**
   * Percent of users who will be prompted/redirected federated login for this
   * IDP.
   */
  core.int experimentPercent;
  /** OAuth2 provider. */
  core.String provider;
  /** OAuth2 client secret. */
  core.String secret;
  /** Whitelisted client IDs for audience check. */
  core.List<core.String> whitelistedAudiences;

  IdpConfig();

  IdpConfig.fromJson(core.Map _json) {
    if (_json.containsKey("clientId")) {
      clientId = _json["clientId"];
    }
    if (_json.containsKey("enabled")) {
      enabled = _json["enabled"];
    }
    if (_json.containsKey("experimentPercent")) {
      experimentPercent = _json["experimentPercent"];
    }
    if (_json.containsKey("provider")) {
      provider = _json["provider"];
    }
    if (_json.containsKey("secret")) {
      secret = _json["secret"];
    }
    if (_json.containsKey("whitelistedAudiences")) {
      whitelistedAudiences = _json["whitelistedAudiences"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clientId != null) {
      _json["clientId"] = clientId;
    }
    if (enabled != null) {
      _json["enabled"] = enabled;
    }
    if (experimentPercent != null) {
      _json["experimentPercent"] = experimentPercent;
    }
    if (provider != null) {
      _json["provider"] = provider;
    }
    if (secret != null) {
      _json["secret"] = secret;
    }
    if (whitelistedAudiences != null) {
      _json["whitelistedAudiences"] = whitelistedAudiences;
    }
    return _json;
  }
}

/**
 * Request of getting a code for user confirmation (reset password, change email
 * etc.)
 */
class Relyingparty {
  /** The recaptcha response from the user. */
  core.String captchaResp;
  /** The recaptcha challenge presented to the user. */
  core.String challenge;
  /** The email of the user. */
  core.String email;
  /** The user's Gitkit login token for email change. */
  core.String idToken;
  /** The fixed string "identitytoolkit#relyingparty". */
  core.String kind;
  /** The new email if the code is for email change. */
  core.String newEmail;
  /** The request type. */
  core.String requestType;
  /** The IP address of the user. */
  core.String userIp;

  Relyingparty();

  Relyingparty.fromJson(core.Map _json) {
    if (_json.containsKey("captchaResp")) {
      captchaResp = _json["captchaResp"];
    }
    if (_json.containsKey("challenge")) {
      challenge = _json["challenge"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("idToken")) {
      idToken = _json["idToken"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("newEmail")) {
      newEmail = _json["newEmail"];
    }
    if (_json.containsKey("requestType")) {
      requestType = _json["requestType"];
    }
    if (_json.containsKey("userIp")) {
      userIp = _json["userIp"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (captchaResp != null) {
      _json["captchaResp"] = captchaResp;
    }
    if (challenge != null) {
      _json["challenge"] = challenge;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (idToken != null) {
      _json["idToken"] = idToken;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (newEmail != null) {
      _json["newEmail"] = newEmail;
    }
    if (requestType != null) {
      _json["requestType"] = requestType;
    }
    if (userIp != null) {
      _json["userIp"] = userIp;
    }
    return _json;
  }
}

/** Response of resetting the password. */
class ResetPasswordResponse {
  /**
   * The user's email. If the out-of-band code is for email recovery, the user's
   * original email.
   */
  core.String email;
  /** The fixed string "identitytoolkit#ResetPasswordResponse". */
  core.String kind;
  /** If the out-of-band code is for email recovery, the user's new email. */
  core.String newEmail;
  /** The request type. */
  core.String requestType;

  ResetPasswordResponse();

  ResetPasswordResponse.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("newEmail")) {
      newEmail = _json["newEmail"];
    }
    if (_json.containsKey("requestType")) {
      requestType = _json["requestType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (email != null) {
      _json["email"] = email;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (newEmail != null) {
      _json["newEmail"] = newEmail;
    }
    if (requestType != null) {
      _json["requestType"] = requestType;
    }
    return _json;
  }
}

class SetAccountInfoResponseProviderUserInfo {
  /** The user's display name at the IDP. */
  core.String displayName;
  /** User's identifier at IDP. */
  core.String federatedId;
  /** The user's photo url at the IDP. */
  core.String photoUrl;
  /**
   * The IdP ID. For whitelisted IdPs it's a short domain name, e.g.,
   * google.com, aol.com, live.net and yahoo.com. For other OpenID IdPs it's the
   * OP identifier.
   */
  core.String providerId;

  SetAccountInfoResponseProviderUserInfo();

  SetAccountInfoResponseProviderUserInfo.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("federatedId")) {
      federatedId = _json["federatedId"];
    }
    if (_json.containsKey("photoUrl")) {
      photoUrl = _json["photoUrl"];
    }
    if (_json.containsKey("providerId")) {
      providerId = _json["providerId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (federatedId != null) {
      _json["federatedId"] = federatedId;
    }
    if (photoUrl != null) {
      _json["photoUrl"] = photoUrl;
    }
    if (providerId != null) {
      _json["providerId"] = providerId;
    }
    return _json;
  }
}

/** Respone of setting the account information. */
class SetAccountInfoResponse {
  /** The name of the user. */
  core.String displayName;
  /** The email of the user. */
  core.String email;
  /** If email has been verified. */
  core.bool emailVerified;
  /**
   * If idToken is STS id token, then this field will be expiration time of STS
   * id token in seconds.
   */
  core.String expiresIn;
  /** The Gitkit id token to login the newly sign up user. */
  core.String idToken;
  /** The fixed string "identitytoolkit#SetAccountInfoResponse". */
  core.String kind;
  /** The local ID of the user. */
  core.String localId;
  /** The new email the user attempts to change to. */
  core.String newEmail;
  /** The user's hashed password. */
  core.String passwordHash;
  core.List<core.int> get passwordHashAsBytes {
    return convert.BASE64.decode(passwordHash);
  }

  void set passwordHashAsBytes(core.List<core.int> _bytes) {
    passwordHash = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** The photo url of the user. */
  core.String photoUrl;
  /** The user's profiles at the associated IdPs. */
  core.List<SetAccountInfoResponseProviderUserInfo> providerUserInfo;
  /** If idToken is STS id token, then this field will be refresh token. */
  core.String refreshToken;

  SetAccountInfoResponse();

  SetAccountInfoResponse.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("emailVerified")) {
      emailVerified = _json["emailVerified"];
    }
    if (_json.containsKey("expiresIn")) {
      expiresIn = _json["expiresIn"];
    }
    if (_json.containsKey("idToken")) {
      idToken = _json["idToken"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("localId")) {
      localId = _json["localId"];
    }
    if (_json.containsKey("newEmail")) {
      newEmail = _json["newEmail"];
    }
    if (_json.containsKey("passwordHash")) {
      passwordHash = _json["passwordHash"];
    }
    if (_json.containsKey("photoUrl")) {
      photoUrl = _json["photoUrl"];
    }
    if (_json.containsKey("providerUserInfo")) {
      providerUserInfo = _json["providerUserInfo"].map((value) => new SetAccountInfoResponseProviderUserInfo.fromJson(value)).toList();
    }
    if (_json.containsKey("refreshToken")) {
      refreshToken = _json["refreshToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (emailVerified != null) {
      _json["emailVerified"] = emailVerified;
    }
    if (expiresIn != null) {
      _json["expiresIn"] = expiresIn;
    }
    if (idToken != null) {
      _json["idToken"] = idToken;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (localId != null) {
      _json["localId"] = localId;
    }
    if (newEmail != null) {
      _json["newEmail"] = newEmail;
    }
    if (passwordHash != null) {
      _json["passwordHash"] = passwordHash;
    }
    if (photoUrl != null) {
      _json["photoUrl"] = photoUrl;
    }
    if (providerUserInfo != null) {
      _json["providerUserInfo"] = providerUserInfo.map((value) => (value).toJson()).toList();
    }
    if (refreshToken != null) {
      _json["refreshToken"] = refreshToken;
    }
    return _json;
  }
}

/**
 * Response of signing up new user, creating anonymous user or anonymous user
 * reauth.
 */
class SignupNewUserResponse {
  /** The name of the user. */
  core.String displayName;
  /** The email of the user. */
  core.String email;
  /**
   * If idToken is STS id token, then this field will be expiration time of STS
   * id token in seconds.
   */
  core.String expiresIn;
  /** The Gitkit id token to login the newly sign up user. */
  core.String idToken;
  /** The fixed string "identitytoolkit#SignupNewUserResponse". */
  core.String kind;
  /** The RP local ID of the user. */
  core.String localId;
  /** If idToken is STS id token, then this field will be refresh token. */
  core.String refreshToken;

  SignupNewUserResponse();

  SignupNewUserResponse.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("expiresIn")) {
      expiresIn = _json["expiresIn"];
    }
    if (_json.containsKey("idToken")) {
      idToken = _json["idToken"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("localId")) {
      localId = _json["localId"];
    }
    if (_json.containsKey("refreshToken")) {
      refreshToken = _json["refreshToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (expiresIn != null) {
      _json["expiresIn"] = expiresIn;
    }
    if (idToken != null) {
      _json["idToken"] = idToken;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (localId != null) {
      _json["localId"] = localId;
    }
    if (refreshToken != null) {
      _json["refreshToken"] = refreshToken;
    }
    return _json;
  }
}

class UploadAccountResponseError {
  /** The index of the malformed account, starting from 0. */
  core.int index;
  /** Detailed error message for the account info. */
  core.String message;

  UploadAccountResponseError();

  UploadAccountResponseError.fromJson(core.Map _json) {
    if (_json.containsKey("index")) {
      index = _json["index"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (index != null) {
      _json["index"] = index;
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

/** Respone of uploading accounts in batch. */
class UploadAccountResponse {
  /** The error encountered while processing the account info. */
  core.List<UploadAccountResponseError> error;
  /** The fixed string "identitytoolkit#UploadAccountResponse". */
  core.String kind;

  UploadAccountResponse();

  UploadAccountResponse.fromJson(core.Map _json) {
    if (_json.containsKey("error")) {
      error = _json["error"].map((value) => new UploadAccountResponseError.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (error != null) {
      _json["error"] = error.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class UserInfoProviderUserInfo {
  /** The user's display name at the IDP. */
  core.String displayName;
  /** User's email at IDP. */
  core.String email;
  /** User's identifier at IDP. */
  core.String federatedId;
  /** The user's photo url at the IDP. */
  core.String photoUrl;
  /**
   * The IdP ID. For white listed IdPs it's a short domain name, e.g.,
   * google.com, aol.com, live.net and yahoo.com. For other OpenID IdPs it's the
   * OP identifier.
   */
  core.String providerId;
  /** User's raw identifier directly returned from IDP. */
  core.String rawId;
  /** User's screen name at Twitter or login name at Github. */
  core.String screenName;

  UserInfoProviderUserInfo();

  UserInfoProviderUserInfo.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("federatedId")) {
      federatedId = _json["federatedId"];
    }
    if (_json.containsKey("photoUrl")) {
      photoUrl = _json["photoUrl"];
    }
    if (_json.containsKey("providerId")) {
      providerId = _json["providerId"];
    }
    if (_json.containsKey("rawId")) {
      rawId = _json["rawId"];
    }
    if (_json.containsKey("screenName")) {
      screenName = _json["screenName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (federatedId != null) {
      _json["federatedId"] = federatedId;
    }
    if (photoUrl != null) {
      _json["photoUrl"] = photoUrl;
    }
    if (providerId != null) {
      _json["providerId"] = providerId;
    }
    if (rawId != null) {
      _json["rawId"] = rawId;
    }
    if (screenName != null) {
      _json["screenName"] = screenName;
    }
    return _json;
  }
}

/** Template for an individual account info. */
class UserInfo {
  /** User creation timestamp. */
  core.String createdAt;
  /** Whether the user is authenticated by the developer. */
  core.bool customAuth;
  /** Whether the user is disabled. */
  core.bool disabled;
  /** The name of the user. */
  core.String displayName;
  /** The email of the user. */
  core.String email;
  /** Whether the email has been verified. */
  core.bool emailVerified;
  /** last login timestamp. */
  core.String lastLoginAt;
  /** The local ID of the user. */
  core.String localId;
  /** The user's hashed password. */
  core.String passwordHash;
  core.List<core.int> get passwordHashAsBytes {
    return convert.BASE64.decode(passwordHash);
  }

  void set passwordHashAsBytes(core.List<core.int> _bytes) {
    passwordHash = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** The timestamp when the password was last updated. */
  core.double passwordUpdatedAt;
  /** The URL of the user profile photo. */
  core.String photoUrl;
  /** The IDP of the user. */
  core.List<UserInfoProviderUserInfo> providerUserInfo;
  /** The user's plain text password. */
  core.String rawPassword;
  /** The user's password salt. */
  core.String salt;
  core.List<core.int> get saltAsBytes {
    return convert.BASE64.decode(salt);
  }

  void set saltAsBytes(core.List<core.int> _bytes) {
    salt = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** User's screen name at Twitter or login name at Github. */
  core.String screenName;
  /** Timestamp in seconds for valid login token. */
  core.String validSince;
  /** Version of the user's password. */
  core.int version;

  UserInfo();

  UserInfo.fromJson(core.Map _json) {
    if (_json.containsKey("createdAt")) {
      createdAt = _json["createdAt"];
    }
    if (_json.containsKey("customAuth")) {
      customAuth = _json["customAuth"];
    }
    if (_json.containsKey("disabled")) {
      disabled = _json["disabled"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("emailVerified")) {
      emailVerified = _json["emailVerified"];
    }
    if (_json.containsKey("lastLoginAt")) {
      lastLoginAt = _json["lastLoginAt"];
    }
    if (_json.containsKey("localId")) {
      localId = _json["localId"];
    }
    if (_json.containsKey("passwordHash")) {
      passwordHash = _json["passwordHash"];
    }
    if (_json.containsKey("passwordUpdatedAt")) {
      passwordUpdatedAt = _json["passwordUpdatedAt"];
    }
    if (_json.containsKey("photoUrl")) {
      photoUrl = _json["photoUrl"];
    }
    if (_json.containsKey("providerUserInfo")) {
      providerUserInfo = _json["providerUserInfo"].map((value) => new UserInfoProviderUserInfo.fromJson(value)).toList();
    }
    if (_json.containsKey("rawPassword")) {
      rawPassword = _json["rawPassword"];
    }
    if (_json.containsKey("salt")) {
      salt = _json["salt"];
    }
    if (_json.containsKey("screenName")) {
      screenName = _json["screenName"];
    }
    if (_json.containsKey("validSince")) {
      validSince = _json["validSince"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (createdAt != null) {
      _json["createdAt"] = createdAt;
    }
    if (customAuth != null) {
      _json["customAuth"] = customAuth;
    }
    if (disabled != null) {
      _json["disabled"] = disabled;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (emailVerified != null) {
      _json["emailVerified"] = emailVerified;
    }
    if (lastLoginAt != null) {
      _json["lastLoginAt"] = lastLoginAt;
    }
    if (localId != null) {
      _json["localId"] = localId;
    }
    if (passwordHash != null) {
      _json["passwordHash"] = passwordHash;
    }
    if (passwordUpdatedAt != null) {
      _json["passwordUpdatedAt"] = passwordUpdatedAt;
    }
    if (photoUrl != null) {
      _json["photoUrl"] = photoUrl;
    }
    if (providerUserInfo != null) {
      _json["providerUserInfo"] = providerUserInfo.map((value) => (value).toJson()).toList();
    }
    if (rawPassword != null) {
      _json["rawPassword"] = rawPassword;
    }
    if (salt != null) {
      _json["salt"] = salt;
    }
    if (screenName != null) {
      _json["screenName"] = screenName;
    }
    if (validSince != null) {
      _json["validSince"] = validSince;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

/** Response of verifying the IDP assertion. */
class VerifyAssertionResponse {
  /** The action code. */
  core.String action;
  /** URL for OTA app installation. */
  core.String appInstallationUrl;
  /** The custom scheme used by mobile app. */
  core.String appScheme;
  /**
   * The opaque value used by the client to maintain context info between the
   * authentication request and the IDP callback.
   */
  core.String context;
  /** The birth date of the IdP account. */
  core.String dateOfBirth;
  /** The display name of the user. */
  core.String displayName;
  /**
   * The email returned by the IdP. NOTE: The federated login user may not own
   * the email.
   */
  core.String email;
  /** It's true if the email is recycled. */
  core.bool emailRecycled;
  /**
   * The value is true if the IDP is also the email provider. It means the user
   * owns the email.
   */
  core.bool emailVerified;
  /** Client error code. */
  core.String errorMessage;
  /**
   * If idToken is STS id token, then this field will be expiration time of STS
   * id token in seconds.
   */
  core.String expiresIn;
  /** The unique ID identifies the IdP account. */
  core.String federatedId;
  /** The first name of the user. */
  core.String firstName;
  /** The full name of the user. */
  core.String fullName;
  /** The ID token. */
  core.String idToken;
  /**
   * It's the identifier param in the createAuthUri request if the identifier is
   * an email. It can be used to check whether the user input email is different
   * from the asserted email.
   */
  core.String inputEmail;
  /** True if it's a new user sign-in, false if it's a returning user. */
  core.bool isNewUser;
  /** The fixed string "identitytoolkit#VerifyAssertionResponse". */
  core.String kind;
  /** The language preference of the user. */
  core.String language;
  /** The last name of the user. */
  core.String lastName;
  /**
   * The RP local ID if it's already been mapped to the IdP account identified
   * by the federated ID.
   */
  core.String localId;
  /**
   * Whether the assertion is from a non-trusted IDP and need account linking
   * confirmation.
   */
  core.bool needConfirmation;
  /**
   * Whether need client to supply email to complete the federated login flow.
   */
  core.bool needEmail;
  /** The nick name of the user. */
  core.String nickName;
  /** The OAuth2 access token. */
  core.String oauthAccessToken;
  /** The OAuth2 authorization code. */
  core.String oauthAuthorizationCode;
  /** The lifetime in seconds of the OAuth2 access token. */
  core.int oauthExpireIn;
  /** The OIDC id token. */
  core.String oauthIdToken;
  /** The user approved request token for the OpenID OAuth extension. */
  core.String oauthRequestToken;
  /** The scope for the OpenID OAuth extension. */
  core.String oauthScope;
  /** The OAuth1 access token secret. */
  core.String oauthTokenSecret;
  /**
   * The original email stored in the mapping storage. It's returned when the
   * federated ID is associated to a different email.
   */
  core.String originalEmail;
  /** The URI of the public accessible profiel picture. */
  core.String photoUrl;
  /**
   * The IdP ID. For white listed IdPs it's a short domain name e.g. google.com,
   * aol.com, live.net and yahoo.com. If the "providerId" param is set to OpenID
   * OP identifer other than the whilte listed IdPs the OP identifier is
   * returned. If the "identifier" param is federated ID in the createAuthUri
   * request. The domain part of the federated ID is returned.
   */
  core.String providerId;
  /** Raw IDP-returned user info. */
  core.String rawUserInfo;
  /** If idToken is STS id token, then this field will be refresh token. */
  core.String refreshToken;
  /** The screen_name of a Twitter user or the login name at Github. */
  core.String screenName;
  /** The timezone of the user. */
  core.String timeZone;
  /**
   * When action is 'map', contains the idps which can be used for confirmation.
   */
  core.List<core.String> verifiedProvider;

  VerifyAssertionResponse();

  VerifyAssertionResponse.fromJson(core.Map _json) {
    if (_json.containsKey("action")) {
      action = _json["action"];
    }
    if (_json.containsKey("appInstallationUrl")) {
      appInstallationUrl = _json["appInstallationUrl"];
    }
    if (_json.containsKey("appScheme")) {
      appScheme = _json["appScheme"];
    }
    if (_json.containsKey("context")) {
      context = _json["context"];
    }
    if (_json.containsKey("dateOfBirth")) {
      dateOfBirth = _json["dateOfBirth"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("emailRecycled")) {
      emailRecycled = _json["emailRecycled"];
    }
    if (_json.containsKey("emailVerified")) {
      emailVerified = _json["emailVerified"];
    }
    if (_json.containsKey("errorMessage")) {
      errorMessage = _json["errorMessage"];
    }
    if (_json.containsKey("expiresIn")) {
      expiresIn = _json["expiresIn"];
    }
    if (_json.containsKey("federatedId")) {
      federatedId = _json["federatedId"];
    }
    if (_json.containsKey("firstName")) {
      firstName = _json["firstName"];
    }
    if (_json.containsKey("fullName")) {
      fullName = _json["fullName"];
    }
    if (_json.containsKey("idToken")) {
      idToken = _json["idToken"];
    }
    if (_json.containsKey("inputEmail")) {
      inputEmail = _json["inputEmail"];
    }
    if (_json.containsKey("isNewUser")) {
      isNewUser = _json["isNewUser"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("lastName")) {
      lastName = _json["lastName"];
    }
    if (_json.containsKey("localId")) {
      localId = _json["localId"];
    }
    if (_json.containsKey("needConfirmation")) {
      needConfirmation = _json["needConfirmation"];
    }
    if (_json.containsKey("needEmail")) {
      needEmail = _json["needEmail"];
    }
    if (_json.containsKey("nickName")) {
      nickName = _json["nickName"];
    }
    if (_json.containsKey("oauthAccessToken")) {
      oauthAccessToken = _json["oauthAccessToken"];
    }
    if (_json.containsKey("oauthAuthorizationCode")) {
      oauthAuthorizationCode = _json["oauthAuthorizationCode"];
    }
    if (_json.containsKey("oauthExpireIn")) {
      oauthExpireIn = _json["oauthExpireIn"];
    }
    if (_json.containsKey("oauthIdToken")) {
      oauthIdToken = _json["oauthIdToken"];
    }
    if (_json.containsKey("oauthRequestToken")) {
      oauthRequestToken = _json["oauthRequestToken"];
    }
    if (_json.containsKey("oauthScope")) {
      oauthScope = _json["oauthScope"];
    }
    if (_json.containsKey("oauthTokenSecret")) {
      oauthTokenSecret = _json["oauthTokenSecret"];
    }
    if (_json.containsKey("originalEmail")) {
      originalEmail = _json["originalEmail"];
    }
    if (_json.containsKey("photoUrl")) {
      photoUrl = _json["photoUrl"];
    }
    if (_json.containsKey("providerId")) {
      providerId = _json["providerId"];
    }
    if (_json.containsKey("rawUserInfo")) {
      rawUserInfo = _json["rawUserInfo"];
    }
    if (_json.containsKey("refreshToken")) {
      refreshToken = _json["refreshToken"];
    }
    if (_json.containsKey("screenName")) {
      screenName = _json["screenName"];
    }
    if (_json.containsKey("timeZone")) {
      timeZone = _json["timeZone"];
    }
    if (_json.containsKey("verifiedProvider")) {
      verifiedProvider = _json["verifiedProvider"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (action != null) {
      _json["action"] = action;
    }
    if (appInstallationUrl != null) {
      _json["appInstallationUrl"] = appInstallationUrl;
    }
    if (appScheme != null) {
      _json["appScheme"] = appScheme;
    }
    if (context != null) {
      _json["context"] = context;
    }
    if (dateOfBirth != null) {
      _json["dateOfBirth"] = dateOfBirth;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (emailRecycled != null) {
      _json["emailRecycled"] = emailRecycled;
    }
    if (emailVerified != null) {
      _json["emailVerified"] = emailVerified;
    }
    if (errorMessage != null) {
      _json["errorMessage"] = errorMessage;
    }
    if (expiresIn != null) {
      _json["expiresIn"] = expiresIn;
    }
    if (federatedId != null) {
      _json["federatedId"] = federatedId;
    }
    if (firstName != null) {
      _json["firstName"] = firstName;
    }
    if (fullName != null) {
      _json["fullName"] = fullName;
    }
    if (idToken != null) {
      _json["idToken"] = idToken;
    }
    if (inputEmail != null) {
      _json["inputEmail"] = inputEmail;
    }
    if (isNewUser != null) {
      _json["isNewUser"] = isNewUser;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (language != null) {
      _json["language"] = language;
    }
    if (lastName != null) {
      _json["lastName"] = lastName;
    }
    if (localId != null) {
      _json["localId"] = localId;
    }
    if (needConfirmation != null) {
      _json["needConfirmation"] = needConfirmation;
    }
    if (needEmail != null) {
      _json["needEmail"] = needEmail;
    }
    if (nickName != null) {
      _json["nickName"] = nickName;
    }
    if (oauthAccessToken != null) {
      _json["oauthAccessToken"] = oauthAccessToken;
    }
    if (oauthAuthorizationCode != null) {
      _json["oauthAuthorizationCode"] = oauthAuthorizationCode;
    }
    if (oauthExpireIn != null) {
      _json["oauthExpireIn"] = oauthExpireIn;
    }
    if (oauthIdToken != null) {
      _json["oauthIdToken"] = oauthIdToken;
    }
    if (oauthRequestToken != null) {
      _json["oauthRequestToken"] = oauthRequestToken;
    }
    if (oauthScope != null) {
      _json["oauthScope"] = oauthScope;
    }
    if (oauthTokenSecret != null) {
      _json["oauthTokenSecret"] = oauthTokenSecret;
    }
    if (originalEmail != null) {
      _json["originalEmail"] = originalEmail;
    }
    if (photoUrl != null) {
      _json["photoUrl"] = photoUrl;
    }
    if (providerId != null) {
      _json["providerId"] = providerId;
    }
    if (rawUserInfo != null) {
      _json["rawUserInfo"] = rawUserInfo;
    }
    if (refreshToken != null) {
      _json["refreshToken"] = refreshToken;
    }
    if (screenName != null) {
      _json["screenName"] = screenName;
    }
    if (timeZone != null) {
      _json["timeZone"] = timeZone;
    }
    if (verifiedProvider != null) {
      _json["verifiedProvider"] = verifiedProvider;
    }
    return _json;
  }
}

/** Response from verifying a custom token */
class VerifyCustomTokenResponse {
  /**
   * If idToken is STS id token, then this field will be expiration time of STS
   * id token in seconds.
   */
  core.String expiresIn;
  /** The GITKit token for authenticated user. */
  core.String idToken;
  /** The fixed string "identitytoolkit#VerifyCustomTokenResponse". */
  core.String kind;
  /** If idToken is STS id token, then this field will be refresh token. */
  core.String refreshToken;

  VerifyCustomTokenResponse();

  VerifyCustomTokenResponse.fromJson(core.Map _json) {
    if (_json.containsKey("expiresIn")) {
      expiresIn = _json["expiresIn"];
    }
    if (_json.containsKey("idToken")) {
      idToken = _json["idToken"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("refreshToken")) {
      refreshToken = _json["refreshToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (expiresIn != null) {
      _json["expiresIn"] = expiresIn;
    }
    if (idToken != null) {
      _json["idToken"] = idToken;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (refreshToken != null) {
      _json["refreshToken"] = refreshToken;
    }
    return _json;
  }
}

/** Request of verifying the password. */
class VerifyPasswordResponse {
  /** The name of the user. */
  core.String displayName;
  /**
   * The email returned by the IdP. NOTE: The federated login user may not own
   * the email.
   */
  core.String email;
  /**
   * If idToken is STS id token, then this field will be expiration time of STS
   * id token in seconds.
   */
  core.String expiresIn;
  /** The GITKit token for authenticated user. */
  core.String idToken;
  /** The fixed string "identitytoolkit#VerifyPasswordResponse". */
  core.String kind;
  /**
   * The RP local ID if it's already been mapped to the IdP account identified
   * by the federated ID.
   */
  core.String localId;
  /** The OAuth2 access token. */
  core.String oauthAccessToken;
  /** The OAuth2 authorization code. */
  core.String oauthAuthorizationCode;
  /** The lifetime in seconds of the OAuth2 access token. */
  core.int oauthExpireIn;
  /** The URI of the user's photo at IdP */
  core.String photoUrl;
  /** If idToken is STS id token, then this field will be refresh token. */
  core.String refreshToken;
  /** Whether the email is registered. */
  core.bool registered;

  VerifyPasswordResponse();

  VerifyPasswordResponse.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("expiresIn")) {
      expiresIn = _json["expiresIn"];
    }
    if (_json.containsKey("idToken")) {
      idToken = _json["idToken"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("localId")) {
      localId = _json["localId"];
    }
    if (_json.containsKey("oauthAccessToken")) {
      oauthAccessToken = _json["oauthAccessToken"];
    }
    if (_json.containsKey("oauthAuthorizationCode")) {
      oauthAuthorizationCode = _json["oauthAuthorizationCode"];
    }
    if (_json.containsKey("oauthExpireIn")) {
      oauthExpireIn = _json["oauthExpireIn"];
    }
    if (_json.containsKey("photoUrl")) {
      photoUrl = _json["photoUrl"];
    }
    if (_json.containsKey("refreshToken")) {
      refreshToken = _json["refreshToken"];
    }
    if (_json.containsKey("registered")) {
      registered = _json["registered"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (expiresIn != null) {
      _json["expiresIn"] = expiresIn;
    }
    if (idToken != null) {
      _json["idToken"] = idToken;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (localId != null) {
      _json["localId"] = localId;
    }
    if (oauthAccessToken != null) {
      _json["oauthAccessToken"] = oauthAccessToken;
    }
    if (oauthAuthorizationCode != null) {
      _json["oauthAuthorizationCode"] = oauthAuthorizationCode;
    }
    if (oauthExpireIn != null) {
      _json["oauthExpireIn"] = oauthExpireIn;
    }
    if (photoUrl != null) {
      _json["photoUrl"] = photoUrl;
    }
    if (refreshToken != null) {
      _json["refreshToken"] = refreshToken;
    }
    if (registered != null) {
      _json["registered"] = registered;
    }
    return _json;
  }
}
