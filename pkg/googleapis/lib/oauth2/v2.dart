// This is a generated file (see the discoveryapis_generator project).

library googleapis.oauth2.v2;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client oauth2/v2';

/** Obtains end-user authorization grants for use with other Google APIs. */
class Oauth2Api {
  /** Know the list of people in your circles, your age range, and language */
  static const PlusLoginScope = "https://www.googleapis.com/auth/plus.login";

  /** Know who you are on Google */
  static const PlusMeScope = "https://www.googleapis.com/auth/plus.me";

  /** View your email address */
  static const UserinfoEmailScope = "https://www.googleapis.com/auth/userinfo.email";

  /** View your basic profile info */
  static const UserinfoProfileScope = "https://www.googleapis.com/auth/userinfo.profile";


  final commons.ApiRequester _requester;

  UserinfoResourceApi get userinfo => new UserinfoResourceApi(_requester);

  Oauth2Api(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);

  /**
   * Request parameters:
   *
   * Completes with a [Jwk].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Jwk> getCertForOpenIdConnect() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'oauth2/v2/certs';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Jwk.fromJson(data));
  }

  /**
   * Request parameters:
   *
   * [accessToken] - null
   *
   * [idToken] - null
   *
   * [tokenHandle] - null
   *
   * Completes with a [Tokeninfo].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Tokeninfo> tokeninfo({core.String accessToken, core.String idToken, core.String tokenHandle}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (accessToken != null) {
      _queryParams["access_token"] = [accessToken];
    }
    if (idToken != null) {
      _queryParams["id_token"] = [idToken];
    }
    if (tokenHandle != null) {
      _queryParams["token_handle"] = [tokenHandle];
    }

    _url = 'oauth2/v2/tokeninfo';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Tokeninfo.fromJson(data));
  }

}


class UserinfoResourceApi {
  final commons.ApiRequester _requester;

  UserinfoV2ResourceApi get v2 => new UserinfoV2ResourceApi(_requester);

  UserinfoResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Request parameters:
   *
   * Completes with a [Userinfoplus].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Userinfoplus> get() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'oauth2/v2/userinfo';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Userinfoplus.fromJson(data));
  }

}


class UserinfoV2ResourceApi {
  final commons.ApiRequester _requester;

  UserinfoV2MeResourceApi get me => new UserinfoV2MeResourceApi(_requester);

  UserinfoV2ResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class UserinfoV2MeResourceApi {
  final commons.ApiRequester _requester;

  UserinfoV2MeResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Request parameters:
   *
   * Completes with a [Userinfoplus].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Userinfoplus> get() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'userinfo/v2/me';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Userinfoplus.fromJson(data));
  }

}



class JwkKeys {
  core.String alg;
  core.String e;
  core.String kid;
  core.String kty;
  core.String n;
  core.String use;

  JwkKeys();

  JwkKeys.fromJson(core.Map _json) {
    if (_json.containsKey("alg")) {
      alg = _json["alg"];
    }
    if (_json.containsKey("e")) {
      e = _json["e"];
    }
    if (_json.containsKey("kid")) {
      kid = _json["kid"];
    }
    if (_json.containsKey("kty")) {
      kty = _json["kty"];
    }
    if (_json.containsKey("n")) {
      n = _json["n"];
    }
    if (_json.containsKey("use")) {
      use = _json["use"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alg != null) {
      _json["alg"] = alg;
    }
    if (e != null) {
      _json["e"] = e;
    }
    if (kid != null) {
      _json["kid"] = kid;
    }
    if (kty != null) {
      _json["kty"] = kty;
    }
    if (n != null) {
      _json["n"] = n;
    }
    if (use != null) {
      _json["use"] = use;
    }
    return _json;
  }
}

class Jwk {
  core.List<JwkKeys> keys;

  Jwk();

  Jwk.fromJson(core.Map _json) {
    if (_json.containsKey("keys")) {
      keys = _json["keys"].map((value) => new JwkKeys.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (keys != null) {
      _json["keys"] = keys.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Tokeninfo {
  /** The access type granted with this token. It can be offline or online. */
  core.String accessType;
  /**
   * Who is the intended audience for this token. In general the same as
   * issued_to.
   */
  core.String audience;
  /**
   * The email address of the user. Present only if the email scope is present
   * in the request.
   */
  core.String email;
  /** The expiry time of the token, as number of seconds left until expiry. */
  core.int expiresIn;
  /** To whom was the token issued to. In general the same as audience. */
  core.String issuedTo;
  /** The space separated list of scopes granted to this token. */
  core.String scope;
  /** The token handle associated with this token. */
  core.String tokenHandle;
  /** The obfuscated user id. */
  core.String userId;
  /**
   * Boolean flag which is true if the email address is verified. Present only
   * if the email scope is present in the request.
   */
  core.bool verifiedEmail;

  Tokeninfo();

  Tokeninfo.fromJson(core.Map _json) {
    if (_json.containsKey("access_type")) {
      accessType = _json["access_type"];
    }
    if (_json.containsKey("audience")) {
      audience = _json["audience"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("expires_in")) {
      expiresIn = _json["expires_in"];
    }
    if (_json.containsKey("issued_to")) {
      issuedTo = _json["issued_to"];
    }
    if (_json.containsKey("scope")) {
      scope = _json["scope"];
    }
    if (_json.containsKey("token_handle")) {
      tokenHandle = _json["token_handle"];
    }
    if (_json.containsKey("user_id")) {
      userId = _json["user_id"];
    }
    if (_json.containsKey("verified_email")) {
      verifiedEmail = _json["verified_email"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accessType != null) {
      _json["access_type"] = accessType;
    }
    if (audience != null) {
      _json["audience"] = audience;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (expiresIn != null) {
      _json["expires_in"] = expiresIn;
    }
    if (issuedTo != null) {
      _json["issued_to"] = issuedTo;
    }
    if (scope != null) {
      _json["scope"] = scope;
    }
    if (tokenHandle != null) {
      _json["token_handle"] = tokenHandle;
    }
    if (userId != null) {
      _json["user_id"] = userId;
    }
    if (verifiedEmail != null) {
      _json["verified_email"] = verifiedEmail;
    }
    return _json;
  }
}

class Userinfoplus {
  /** The user's email address. */
  core.String email;
  /** The user's last name. */
  core.String familyName;
  /** The user's gender. */
  core.String gender;
  /** The user's first name. */
  core.String givenName;
  /** The hosted domain e.g. example.com if the user is Google apps user. */
  core.String hd;
  /** The obfuscated ID of the user. */
  core.String id;
  /** URL of the profile page. */
  core.String link;
  /** The user's preferred locale. */
  core.String locale;
  /** The user's full name. */
  core.String name;
  /** URL of the user's picture image. */
  core.String picture;
  /**
   * Boolean flag which is true if the email address is verified. Always
   * verified because we only return the user's primary email address.
   */
  core.bool verifiedEmail;

  Userinfoplus();

  Userinfoplus.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("family_name")) {
      familyName = _json["family_name"];
    }
    if (_json.containsKey("gender")) {
      gender = _json["gender"];
    }
    if (_json.containsKey("given_name")) {
      givenName = _json["given_name"];
    }
    if (_json.containsKey("hd")) {
      hd = _json["hd"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("link")) {
      link = _json["link"];
    }
    if (_json.containsKey("locale")) {
      locale = _json["locale"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("picture")) {
      picture = _json["picture"];
    }
    if (_json.containsKey("verified_email")) {
      verifiedEmail = _json["verified_email"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (email != null) {
      _json["email"] = email;
    }
    if (familyName != null) {
      _json["family_name"] = familyName;
    }
    if (gender != null) {
      _json["gender"] = gender;
    }
    if (givenName != null) {
      _json["given_name"] = givenName;
    }
    if (hd != null) {
      _json["hd"] = hd;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (link != null) {
      _json["link"] = link;
    }
    if (locale != null) {
      _json["locale"] = locale;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (picture != null) {
      _json["picture"] = picture;
    }
    if (verifiedEmail != null) {
      _json["verified_email"] = verifiedEmail;
    }
    return _json;
  }
}
