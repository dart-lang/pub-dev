// This is a generated file (see the discoveryapis_generator project).

library googleapis.androidpublisher.v2;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client androidpublisher/v2';

/** Lets Android application developers access their Google Play accounts. */
class AndroidpublisherApi {
  /** View and manage your Google Play Developer account */
  static const AndroidpublisherScope = "https://www.googleapis.com/auth/androidpublisher";


  final commons.ApiRequester _requester;

  EditsResourceApi get edits => new EditsResourceApi(_requester);
  EntitlementsResourceApi get entitlements => new EntitlementsResourceApi(_requester);
  InappproductsResourceApi get inappproducts => new InappproductsResourceApi(_requester);
  PurchasesResourceApi get purchases => new PurchasesResourceApi(_requester);
  ReviewsResourceApi get reviews => new ReviewsResourceApi(_requester);

  AndroidpublisherApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "androidpublisher/v2/applications/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class EditsResourceApi {
  final commons.ApiRequester _requester;

  EditsApklistingsResourceApi get apklistings => new EditsApklistingsResourceApi(_requester);
  EditsApksResourceApi get apks => new EditsApksResourceApi(_requester);
  EditsDeobfuscationfilesResourceApi get deobfuscationfiles => new EditsDeobfuscationfilesResourceApi(_requester);
  EditsDetailsResourceApi get details => new EditsDetailsResourceApi(_requester);
  EditsExpansionfilesResourceApi get expansionfiles => new EditsExpansionfilesResourceApi(_requester);
  EditsImagesResourceApi get images => new EditsImagesResourceApi(_requester);
  EditsListingsResourceApi get listings => new EditsListingsResourceApi(_requester);
  EditsTestersResourceApi get testers => new EditsTestersResourceApi(_requester);
  EditsTracksResourceApi get tracks => new EditsTracksResourceApi(_requester);

  EditsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Commits/applies the changes made in this edit back to the app.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * Completes with a [AppEdit].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AppEdit> commit(core.String packageName, core.String editId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + ':commit';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AppEdit.fromJson(data));
  }

  /**
   * Deletes an edit for an app. Creating a new edit will automatically delete
   * any of your previous edits so this method need only be called if you want
   * to preemptively abandon an edit.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String packageName, core.String editId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId');

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
   * Returns information about the edit specified. Calls will fail if the edit
   * is no long active (e.g. has been deleted, superseded or expired).
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * Completes with a [AppEdit].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AppEdit> get(core.String packageName, core.String editId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AppEdit.fromJson(data));
  }

  /**
   * Creates a new edit for an app, populated with the app's current state.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * Completes with a [AppEdit].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AppEdit> insert(AppEdit request, core.String packageName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AppEdit.fromJson(data));
  }

  /**
   * Checks that the edit can be successfully committed. The edit's changes are
   * not applied to the live app.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * Completes with a [AppEdit].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AppEdit> validate(core.String packageName, core.String editId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + ':validate';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AppEdit.fromJson(data));
  }

}


class EditsApklistingsResourceApi {
  final commons.ApiRequester _requester;

  EditsApklistingsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes the APK-specific localized listing for a specified APK and language
   * code.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [apkVersionCode] - The APK version code whose APK-specific listings should
   * be read or modified.
   *
   * [language] - The language code (a BCP-47 language tag) of the APK-specific
   * localized listing to read or modify. For example, to select Austrian
   * German, pass "de-AT".
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String packageName, core.String editId, core.int apkVersionCode, core.String language) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (apkVersionCode == null) {
      throw new core.ArgumentError("Parameter apkVersionCode is required.");
    }
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/listings/' + commons.Escaper.ecapeVariable('$language');

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
   * Deletes all the APK-specific localized listings for a specified APK.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [apkVersionCode] - The APK version code whose APK-specific listings should
   * be read or modified.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future deleteall(core.String packageName, core.String editId, core.int apkVersionCode) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (apkVersionCode == null) {
      throw new core.ArgumentError("Parameter apkVersionCode is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/listings';

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
   * Fetches the APK-specific localized listing for a specified APK and language
   * code.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [apkVersionCode] - The APK version code whose APK-specific listings should
   * be read or modified.
   *
   * [language] - The language code (a BCP-47 language tag) of the APK-specific
   * localized listing to read or modify. For example, to select Austrian
   * German, pass "de-AT".
   *
   * Completes with a [ApkListing].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ApkListing> get(core.String packageName, core.String editId, core.int apkVersionCode, core.String language) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (apkVersionCode == null) {
      throw new core.ArgumentError("Parameter apkVersionCode is required.");
    }
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/listings/' + commons.Escaper.ecapeVariable('$language');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ApkListing.fromJson(data));
  }

  /**
   * Lists all the APK-specific localized listings for a specified APK.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [apkVersionCode] - The APK version code whose APK-specific listings should
   * be read or modified.
   *
   * Completes with a [ApkListingsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ApkListingsListResponse> list(core.String packageName, core.String editId, core.int apkVersionCode) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (apkVersionCode == null) {
      throw new core.ArgumentError("Parameter apkVersionCode is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/listings';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ApkListingsListResponse.fromJson(data));
  }

  /**
   * Updates or creates the APK-specific localized listing for a specified APK
   * and language code. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [apkVersionCode] - The APK version code whose APK-specific listings should
   * be read or modified.
   *
   * [language] - The language code (a BCP-47 language tag) of the APK-specific
   * localized listing to read or modify. For example, to select Austrian
   * German, pass "de-AT".
   *
   * Completes with a [ApkListing].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ApkListing> patch(ApkListing request, core.String packageName, core.String editId, core.int apkVersionCode, core.String language) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (apkVersionCode == null) {
      throw new core.ArgumentError("Parameter apkVersionCode is required.");
    }
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/listings/' + commons.Escaper.ecapeVariable('$language');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ApkListing.fromJson(data));
  }

  /**
   * Updates or creates the APK-specific localized listing for a specified APK
   * and language code.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [apkVersionCode] - The APK version code whose APK-specific listings should
   * be read or modified.
   *
   * [language] - The language code (a BCP-47 language tag) of the APK-specific
   * localized listing to read or modify. For example, to select Austrian
   * German, pass "de-AT".
   *
   * Completes with a [ApkListing].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ApkListing> update(ApkListing request, core.String packageName, core.String editId, core.int apkVersionCode, core.String language) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (apkVersionCode == null) {
      throw new core.ArgumentError("Parameter apkVersionCode is required.");
    }
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/listings/' + commons.Escaper.ecapeVariable('$language');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ApkListing.fromJson(data));
  }

}


class EditsApksResourceApi {
  final commons.ApiRequester _requester;

  EditsApksResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new APK without uploading the APK itself to Google Play, instead
   * hosting the APK at a specified URL. This function is only available to
   * enterprises using Google Play for Work whose application is configured to
   * restrict distribution to the enterprise domain.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * Completes with a [ApksAddExternallyHostedResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ApksAddExternallyHostedResponse> addexternallyhosted(ApksAddExternallyHostedRequest request, core.String packageName, core.String editId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/externallyHosted';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ApksAddExternallyHostedResponse.fromJson(data));
  }

  /**
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * Completes with a [ApksListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ApksListResponse> list(core.String packageName, core.String editId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ApksListResponse.fromJson(data));
  }

  /**
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [Apk].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Apk> upload(core.String packageName, core.String editId, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/androidpublisher/v2/applications/' + commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks';
    } else {
      _url = '/upload/androidpublisher/v2/applications/' + commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Apk.fromJson(data));
  }

}


class EditsDeobfuscationfilesResourceApi {
  final commons.ApiRequester _requester;

  EditsDeobfuscationfilesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Uploads the deobfuscation file of the specified APK. If a deobfuscation
   * file already exists, it will be replaced.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier of the Android app for which the
   * deobfuscatiuon files are being uploaded; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [apkVersionCode] - The version code of the APK whose deobfuscation file is
   * being uploaded.
   *
   * [deobfuscationFileType] - null
   * Possible string values are:
   * - "proguard"
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [DeobfuscationFilesUploadResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DeobfuscationFilesUploadResponse> upload(core.String packageName, core.String editId, core.int apkVersionCode, core.String deobfuscationFileType, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (apkVersionCode == null) {
      throw new core.ArgumentError("Parameter apkVersionCode is required.");
    }
    if (deobfuscationFileType == null) {
      throw new core.ArgumentError("Parameter deobfuscationFileType is required.");
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/deobfuscationFiles/' + commons.Escaper.ecapeVariable('$deobfuscationFileType');
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/androidpublisher/v2/applications/' + commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/deobfuscationFiles/' + commons.Escaper.ecapeVariable('$deobfuscationFileType');
    } else {
      _url = '/upload/androidpublisher/v2/applications/' + commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/deobfuscationFiles/' + commons.Escaper.ecapeVariable('$deobfuscationFileType');
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DeobfuscationFilesUploadResponse.fromJson(data));
  }

}


class EditsDetailsResourceApi {
  final commons.ApiRequester _requester;

  EditsDetailsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Fetches app details for this edit. This includes the default language and
   * developer support contact information.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * Completes with a [AppDetails].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AppDetails> get(core.String packageName, core.String editId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/details';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AppDetails.fromJson(data));
  }

  /**
   * Updates app details for this edit. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * Completes with a [AppDetails].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AppDetails> patch(AppDetails request, core.String packageName, core.String editId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/details';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AppDetails.fromJson(data));
  }

  /**
   * Updates app details for this edit.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * Completes with a [AppDetails].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AppDetails> update(AppDetails request, core.String packageName, core.String editId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/details';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AppDetails.fromJson(data));
  }

}


class EditsExpansionfilesResourceApi {
  final commons.ApiRequester _requester;

  EditsExpansionfilesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Fetches the Expansion File configuration for the APK specified.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [apkVersionCode] - The version code of the APK whose Expansion File
   * configuration is being read or modified.
   *
   * [expansionFileType] - null
   * Possible string values are:
   * - "main"
   * - "patch"
   *
   * Completes with a [ExpansionFile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ExpansionFile> get(core.String packageName, core.String editId, core.int apkVersionCode, core.String expansionFileType) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (apkVersionCode == null) {
      throw new core.ArgumentError("Parameter apkVersionCode is required.");
    }
    if (expansionFileType == null) {
      throw new core.ArgumentError("Parameter expansionFileType is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/expansionFiles/' + commons.Escaper.ecapeVariable('$expansionFileType');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ExpansionFile.fromJson(data));
  }

  /**
   * Updates the APK's Expansion File configuration to reference another APK's
   * Expansion Files. To add a new Expansion File use the Upload method. This
   * method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [apkVersionCode] - The version code of the APK whose Expansion File
   * configuration is being read or modified.
   *
   * [expansionFileType] - null
   * Possible string values are:
   * - "main"
   * - "patch"
   *
   * Completes with a [ExpansionFile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ExpansionFile> patch(ExpansionFile request, core.String packageName, core.String editId, core.int apkVersionCode, core.String expansionFileType) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (apkVersionCode == null) {
      throw new core.ArgumentError("Parameter apkVersionCode is required.");
    }
    if (expansionFileType == null) {
      throw new core.ArgumentError("Parameter expansionFileType is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/expansionFiles/' + commons.Escaper.ecapeVariable('$expansionFileType');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ExpansionFile.fromJson(data));
  }

  /**
   * Updates the APK's Expansion File configuration to reference another APK's
   * Expansion Files. To add a new Expansion File use the Upload method.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [apkVersionCode] - The version code of the APK whose Expansion File
   * configuration is being read or modified.
   *
   * [expansionFileType] - null
   * Possible string values are:
   * - "main"
   * - "patch"
   *
   * Completes with a [ExpansionFile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ExpansionFile> update(ExpansionFile request, core.String packageName, core.String editId, core.int apkVersionCode, core.String expansionFileType) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (apkVersionCode == null) {
      throw new core.ArgumentError("Parameter apkVersionCode is required.");
    }
    if (expansionFileType == null) {
      throw new core.ArgumentError("Parameter expansionFileType is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/expansionFiles/' + commons.Escaper.ecapeVariable('$expansionFileType');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ExpansionFile.fromJson(data));
  }

  /**
   * Uploads and attaches a new Expansion File to the APK specified.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [apkVersionCode] - The version code of the APK whose Expansion File
   * configuration is being read or modified.
   *
   * [expansionFileType] - null
   * Possible string values are:
   * - "main"
   * - "patch"
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [ExpansionFilesUploadResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ExpansionFilesUploadResponse> upload(core.String packageName, core.String editId, core.int apkVersionCode, core.String expansionFileType, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (apkVersionCode == null) {
      throw new core.ArgumentError("Parameter apkVersionCode is required.");
    }
    if (expansionFileType == null) {
      throw new core.ArgumentError("Parameter expansionFileType is required.");
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/expansionFiles/' + commons.Escaper.ecapeVariable('$expansionFileType');
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/androidpublisher/v2/applications/' + commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/expansionFiles/' + commons.Escaper.ecapeVariable('$expansionFileType');
    } else {
      _url = '/upload/androidpublisher/v2/applications/' + commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/apks/' + commons.Escaper.ecapeVariable('$apkVersionCode') + '/expansionFiles/' + commons.Escaper.ecapeVariable('$expansionFileType');
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ExpansionFilesUploadResponse.fromJson(data));
  }

}


class EditsImagesResourceApi {
  final commons.ApiRequester _requester;

  EditsImagesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes the image (specified by id) from the edit.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [language] - The language code (a BCP-47 language tag) of the localized
   * listing whose images are to read or modified. For example, to select
   * Austrian German, pass "de-AT".
   *
   * [imageType] - null
   * Possible string values are:
   * - "featureGraphic"
   * - "icon"
   * - "phoneScreenshots"
   * - "promoGraphic"
   * - "sevenInchScreenshots"
   * - "tenInchScreenshots"
   * - "tvBanner"
   * - "tvScreenshots"
   * - "wearScreenshots"
   *
   * [imageId] - Unique identifier an image within the set of images attached to
   * this edit.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String packageName, core.String editId, core.String language, core.String imageType, core.String imageId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }
    if (imageType == null) {
      throw new core.ArgumentError("Parameter imageType is required.");
    }
    if (imageId == null) {
      throw new core.ArgumentError("Parameter imageId is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/listings/' + commons.Escaper.ecapeVariable('$language') + '/' + commons.Escaper.ecapeVariable('$imageType') + '/' + commons.Escaper.ecapeVariable('$imageId');

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
   * Deletes all images for the specified language and image type.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [language] - The language code (a BCP-47 language tag) of the localized
   * listing whose images are to read or modified. For example, to select
   * Austrian German, pass "de-AT".
   *
   * [imageType] - null
   * Possible string values are:
   * - "featureGraphic"
   * - "icon"
   * - "phoneScreenshots"
   * - "promoGraphic"
   * - "sevenInchScreenshots"
   * - "tenInchScreenshots"
   * - "tvBanner"
   * - "tvScreenshots"
   * - "wearScreenshots"
   *
   * Completes with a [ImagesDeleteAllResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ImagesDeleteAllResponse> deleteall(core.String packageName, core.String editId, core.String language, core.String imageType) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }
    if (imageType == null) {
      throw new core.ArgumentError("Parameter imageType is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/listings/' + commons.Escaper.ecapeVariable('$language') + '/' + commons.Escaper.ecapeVariable('$imageType');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ImagesDeleteAllResponse.fromJson(data));
  }

  /**
   * Lists all images for the specified language and image type.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [language] - The language code (a BCP-47 language tag) of the localized
   * listing whose images are to read or modified. For example, to select
   * Austrian German, pass "de-AT".
   *
   * [imageType] - null
   * Possible string values are:
   * - "featureGraphic"
   * - "icon"
   * - "phoneScreenshots"
   * - "promoGraphic"
   * - "sevenInchScreenshots"
   * - "tenInchScreenshots"
   * - "tvBanner"
   * - "tvScreenshots"
   * - "wearScreenshots"
   *
   * Completes with a [ImagesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ImagesListResponse> list(core.String packageName, core.String editId, core.String language, core.String imageType) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }
    if (imageType == null) {
      throw new core.ArgumentError("Parameter imageType is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/listings/' + commons.Escaper.ecapeVariable('$language') + '/' + commons.Escaper.ecapeVariable('$imageType');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ImagesListResponse.fromJson(data));
  }

  /**
   * Uploads a new image and adds it to the list of images for the specified
   * language and image type.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [language] - The language code (a BCP-47 language tag) of the localized
   * listing whose images are to read or modified. For example, to select
   * Austrian German, pass "de-AT".
   *
   * [imageType] - null
   * Possible string values are:
   * - "featureGraphic"
   * - "icon"
   * - "phoneScreenshots"
   * - "promoGraphic"
   * - "sevenInchScreenshots"
   * - "tenInchScreenshots"
   * - "tvBanner"
   * - "tvScreenshots"
   * - "wearScreenshots"
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [ImagesUploadResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ImagesUploadResponse> upload(core.String packageName, core.String editId, core.String language, core.String imageType, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }
    if (imageType == null) {
      throw new core.ArgumentError("Parameter imageType is required.");
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/listings/' + commons.Escaper.ecapeVariable('$language') + '/' + commons.Escaper.ecapeVariable('$imageType');
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/androidpublisher/v2/applications/' + commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/listings/' + commons.Escaper.ecapeVariable('$language') + '/' + commons.Escaper.ecapeVariable('$imageType');
    } else {
      _url = '/upload/androidpublisher/v2/applications/' + commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/listings/' + commons.Escaper.ecapeVariable('$language') + '/' + commons.Escaper.ecapeVariable('$imageType');
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ImagesUploadResponse.fromJson(data));
  }

}


class EditsListingsResourceApi {
  final commons.ApiRequester _requester;

  EditsListingsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes the specified localized store listing from an edit.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [language] - The language code (a BCP-47 language tag) of the localized
   * listing to read or modify. For example, to select Austrian German, pass
   * "de-AT".
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String packageName, core.String editId, core.String language) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/listings/' + commons.Escaper.ecapeVariable('$language');

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
   * Deletes all localized listings from an edit.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future deleteall(core.String packageName, core.String editId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/listings';

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
   * Fetches information about a localized store listing.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [language] - The language code (a BCP-47 language tag) of the localized
   * listing to read or modify. For example, to select Austrian German, pass
   * "de-AT".
   *
   * Completes with a [Listing].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Listing> get(core.String packageName, core.String editId, core.String language) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/listings/' + commons.Escaper.ecapeVariable('$language');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Listing.fromJson(data));
  }

  /**
   * Returns all of the localized store listings attached to this edit.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * Completes with a [ListingsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListingsListResponse> list(core.String packageName, core.String editId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/listings';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListingsListResponse.fromJson(data));
  }

  /**
   * Creates or updates a localized store listing. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [language] - The language code (a BCP-47 language tag) of the localized
   * listing to read or modify. For example, to select Austrian German, pass
   * "de-AT".
   *
   * Completes with a [Listing].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Listing> patch(Listing request, core.String packageName, core.String editId, core.String language) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/listings/' + commons.Escaper.ecapeVariable('$language');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Listing.fromJson(data));
  }

  /**
   * Creates or updates a localized store listing.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [language] - The language code (a BCP-47 language tag) of the localized
   * listing to read or modify. For example, to select Austrian German, pass
   * "de-AT".
   *
   * Completes with a [Listing].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Listing> update(Listing request, core.String packageName, core.String editId, core.String language) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/listings/' + commons.Escaper.ecapeVariable('$language');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Listing.fromJson(data));
  }

}


class EditsTestersResourceApi {
  final commons.ApiRequester _requester;

  EditsTestersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [track] - null
   * Possible string values are:
   * - "alpha"
   * - "beta"
   * - "production"
   * - "rollout"
   *
   * Completes with a [Testers].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Testers> get(core.String packageName, core.String editId, core.String track) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (track == null) {
      throw new core.ArgumentError("Parameter track is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/testers/' + commons.Escaper.ecapeVariable('$track');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Testers.fromJson(data));
  }

  /**
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [track] - null
   * Possible string values are:
   * - "alpha"
   * - "beta"
   * - "production"
   * - "rollout"
   *
   * Completes with a [Testers].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Testers> patch(Testers request, core.String packageName, core.String editId, core.String track) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (track == null) {
      throw new core.ArgumentError("Parameter track is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/testers/' + commons.Escaper.ecapeVariable('$track');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Testers.fromJson(data));
  }

  /**
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [track] - null
   * Possible string values are:
   * - "alpha"
   * - "beta"
   * - "production"
   * - "rollout"
   *
   * Completes with a [Testers].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Testers> update(Testers request, core.String packageName, core.String editId, core.String track) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (track == null) {
      throw new core.ArgumentError("Parameter track is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/testers/' + commons.Escaper.ecapeVariable('$track');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Testers.fromJson(data));
  }

}


class EditsTracksResourceApi {
  final commons.ApiRequester _requester;

  EditsTracksResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Fetches the track configuration for the specified track type. Includes the
   * APK version codes that are in this track.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [track] - The track type to read or modify.
   * Possible string values are:
   * - "alpha"
   * - "beta"
   * - "production"
   * - "rollout"
   *
   * Completes with a [Track].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Track> get(core.String packageName, core.String editId, core.String track) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (track == null) {
      throw new core.ArgumentError("Parameter track is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/tracks/' + commons.Escaper.ecapeVariable('$track');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Track.fromJson(data));
  }

  /**
   * Lists all the track configurations for this edit.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * Completes with a [TracksListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TracksListResponse> list(core.String packageName, core.String editId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/tracks';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TracksListResponse.fromJson(data));
  }

  /**
   * Updates the track configuration for the specified track type. When halted,
   * the rollout track cannot be updated without adding new APKs, and adding new
   * APKs will cause it to resume. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [track] - The track type to read or modify.
   * Possible string values are:
   * - "alpha"
   * - "beta"
   * - "production"
   * - "rollout"
   *
   * Completes with a [Track].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Track> patch(Track request, core.String packageName, core.String editId, core.String track) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (track == null) {
      throw new core.ArgumentError("Parameter track is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/tracks/' + commons.Escaper.ecapeVariable('$track');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Track.fromJson(data));
  }

  /**
   * Updates the track configuration for the specified track type. When halted,
   * the rollout track cannot be updated without adding new APKs, and adding new
   * APKs will cause it to resume.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app that is being
   * updated; for example, "com.spiffygame".
   *
   * [editId] - Unique identifier for this edit.
   *
   * [track] - The track type to read or modify.
   * Possible string values are:
   * - "alpha"
   * - "beta"
   * - "production"
   * - "rollout"
   *
   * Completes with a [Track].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Track> update(Track request, core.String packageName, core.String editId, core.String track) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (editId == null) {
      throw new core.ArgumentError("Parameter editId is required.");
    }
    if (track == null) {
      throw new core.ArgumentError("Parameter track is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/edits/' + commons.Escaper.ecapeVariable('$editId') + '/tracks/' + commons.Escaper.ecapeVariable('$track');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Track.fromJson(data));
  }

}


class EntitlementsResourceApi {
  final commons.ApiRequester _requester;

  EntitlementsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists the user's current inapp item or subscription entitlements
   *
   * Request parameters:
   *
   * [packageName] - The package name of the application the inapp product was
   * sold in (for example, 'com.some.thing').
   *
   * [maxResults] - null
   *
   * [productId] - The product id of the inapp product (for example, 'sku1').
   * This can be used to restrict the result set.
   *
   * [startIndex] - null
   *
   * [token] - null
   *
   * Completes with a [EntitlementsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EntitlementsListResponse> list(core.String packageName, {core.int maxResults, core.String productId, core.int startIndex, core.String token}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (productId != null) {
      _queryParams["productId"] = [productId];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }
    if (token != null) {
      _queryParams["token"] = [token];
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/entitlements';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EntitlementsListResponse.fromJson(data));
  }

}


class InappproductsResourceApi {
  final commons.ApiRequester _requester;

  InappproductsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [InappproductsBatchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<InappproductsBatchResponse> batch(InappproductsBatchRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'inappproducts/batch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new InappproductsBatchResponse.fromJson(data));
  }

  /**
   * Delete an in-app product for an app.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app with the in-app
   * product; for example, "com.spiffygame".
   *
   * [sku] - Unique identifier for the in-app product.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String packageName, core.String sku) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (sku == null) {
      throw new core.ArgumentError("Parameter sku is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$packageName') + '/inappproducts/' + commons.Escaper.ecapeVariable('$sku');

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
   * Returns information about the in-app product specified.
   *
   * Request parameters:
   *
   * [packageName] - null
   *
   * [sku] - Unique identifier for the in-app product.
   *
   * Completes with a [InAppProduct].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<InAppProduct> get(core.String packageName, core.String sku) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (sku == null) {
      throw new core.ArgumentError("Parameter sku is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/inappproducts/' + commons.Escaper.ecapeVariable('$sku');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new InAppProduct.fromJson(data));
  }

  /**
   * Creates a new in-app product for an app.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app; for example,
   * "com.spiffygame".
   *
   * [autoConvertMissingPrices] - If true the prices for all regions targeted by
   * the parent app that don't have a price specified for this in-app product
   * will be auto converted to the target currency based on the default price.
   * Defaults to false.
   *
   * Completes with a [InAppProduct].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<InAppProduct> insert(InAppProduct request, core.String packageName, {core.bool autoConvertMissingPrices}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (autoConvertMissingPrices != null) {
      _queryParams["autoConvertMissingPrices"] = ["${autoConvertMissingPrices}"];
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/inappproducts';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new InAppProduct.fromJson(data));
  }

  /**
   * List all the in-app products for an Android app, both subscriptions and
   * managed in-app products..
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app with in-app products;
   * for example, "com.spiffygame".
   *
   * [maxResults] - null
   *
   * [startIndex] - null
   *
   * [token] - null
   *
   * Completes with a [InappproductsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<InappproductsListResponse> list(core.String packageName, {core.int maxResults, core.int startIndex, core.String token}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }
    if (token != null) {
      _queryParams["token"] = [token];
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/inappproducts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new InappproductsListResponse.fromJson(data));
  }

  /**
   * Updates the details of an in-app product. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app with the in-app
   * product; for example, "com.spiffygame".
   *
   * [sku] - Unique identifier for the in-app product.
   *
   * [autoConvertMissingPrices] - If true the prices for all regions targeted by
   * the parent app that don't have a price specified for this in-app product
   * will be auto converted to the target currency based on the default price.
   * Defaults to false.
   *
   * Completes with a [InAppProduct].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<InAppProduct> patch(InAppProduct request, core.String packageName, core.String sku, {core.bool autoConvertMissingPrices}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (sku == null) {
      throw new core.ArgumentError("Parameter sku is required.");
    }
    if (autoConvertMissingPrices != null) {
      _queryParams["autoConvertMissingPrices"] = ["${autoConvertMissingPrices}"];
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/inappproducts/' + commons.Escaper.ecapeVariable('$sku');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new InAppProduct.fromJson(data));
  }

  /**
   * Updates the details of an in-app product.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app with the in-app
   * product; for example, "com.spiffygame".
   *
   * [sku] - Unique identifier for the in-app product.
   *
   * [autoConvertMissingPrices] - If true the prices for all regions targeted by
   * the parent app that don't have a price specified for this in-app product
   * will be auto converted to the target currency based on the default price.
   * Defaults to false.
   *
   * Completes with a [InAppProduct].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<InAppProduct> update(InAppProduct request, core.String packageName, core.String sku, {core.bool autoConvertMissingPrices}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (sku == null) {
      throw new core.ArgumentError("Parameter sku is required.");
    }
    if (autoConvertMissingPrices != null) {
      _queryParams["autoConvertMissingPrices"] = ["${autoConvertMissingPrices}"];
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/inappproducts/' + commons.Escaper.ecapeVariable('$sku');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new InAppProduct.fromJson(data));
  }

}


class PurchasesResourceApi {
  final commons.ApiRequester _requester;

  PurchasesProductsResourceApi get products => new PurchasesProductsResourceApi(_requester);
  PurchasesSubscriptionsResourceApi get subscriptions => new PurchasesSubscriptionsResourceApi(_requester);
  PurchasesVoidedpurchasesResourceApi get voidedpurchases => new PurchasesVoidedpurchasesResourceApi(_requester);

  PurchasesResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class PurchasesProductsResourceApi {
  final commons.ApiRequester _requester;

  PurchasesProductsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Checks the purchase and consumption status of an inapp item.
   *
   * Request parameters:
   *
   * [packageName] - The package name of the application the inapp product was
   * sold in (for example, 'com.some.thing').
   *
   * [productId] - The inapp product SKU (for example, 'com.some.thing.inapp1').
   *
   * [token] - The token provided to the user's device when the inapp product
   * was purchased.
   *
   * Completes with a [ProductPurchase].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProductPurchase> get(core.String packageName, core.String productId, core.String token) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if (token == null) {
      throw new core.ArgumentError("Parameter token is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/purchases/products/' + commons.Escaper.ecapeVariable('$productId') + '/tokens/' + commons.Escaper.ecapeVariable('$token');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProductPurchase.fromJson(data));
  }

}


class PurchasesSubscriptionsResourceApi {
  final commons.ApiRequester _requester;

  PurchasesSubscriptionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Cancels a user's subscription purchase. The subscription remains valid
   * until its expiration time.
   *
   * Request parameters:
   *
   * [packageName] - The package name of the application for which this
   * subscription was purchased (for example, 'com.some.thing').
   *
   * [subscriptionId] - The purchased subscription ID (for example,
   * 'monthly001').
   *
   * [token] - The token provided to the user's device when the subscription was
   * purchased.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future cancel(core.String packageName, core.String subscriptionId, core.String token) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }
    if (token == null) {
      throw new core.ArgumentError("Parameter token is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$packageName') + '/purchases/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId') + '/tokens/' + commons.Escaper.ecapeVariable('$token') + ':cancel';

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
   * Defers a user's subscription purchase until a specified future expiration
   * time.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - The package name of the application for which this
   * subscription was purchased (for example, 'com.some.thing').
   *
   * [subscriptionId] - The purchased subscription ID (for example,
   * 'monthly001').
   *
   * [token] - The token provided to the user's device when the subscription was
   * purchased.
   *
   * Completes with a [SubscriptionPurchasesDeferResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SubscriptionPurchasesDeferResponse> defer(SubscriptionPurchasesDeferRequest request, core.String packageName, core.String subscriptionId, core.String token) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }
    if (token == null) {
      throw new core.ArgumentError("Parameter token is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/purchases/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId') + '/tokens/' + commons.Escaper.ecapeVariable('$token') + ':defer';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SubscriptionPurchasesDeferResponse.fromJson(data));
  }

  /**
   * Checks whether a user's subscription purchase is valid and returns its
   * expiry time.
   *
   * Request parameters:
   *
   * [packageName] - The package name of the application for which this
   * subscription was purchased (for example, 'com.some.thing').
   *
   * [subscriptionId] - The purchased subscription ID (for example,
   * 'monthly001').
   *
   * [token] - The token provided to the user's device when the subscription was
   * purchased.
   *
   * Completes with a [SubscriptionPurchase].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SubscriptionPurchase> get(core.String packageName, core.String subscriptionId, core.String token) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }
    if (token == null) {
      throw new core.ArgumentError("Parameter token is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/purchases/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId') + '/tokens/' + commons.Escaper.ecapeVariable('$token');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SubscriptionPurchase.fromJson(data));
  }

  /**
   * Refunds a user's subscription purchase, but the subscription remains valid
   * until its expiration time and it will continue to recur.
   *
   * Request parameters:
   *
   * [packageName] - The package name of the application for which this
   * subscription was purchased (for example, 'com.some.thing').
   *
   * [subscriptionId] - The purchased subscription ID (for example,
   * 'monthly001').
   *
   * [token] - The token provided to the user's device when the subscription was
   * purchased.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future refund(core.String packageName, core.String subscriptionId, core.String token) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }
    if (token == null) {
      throw new core.ArgumentError("Parameter token is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$packageName') + '/purchases/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId') + '/tokens/' + commons.Escaper.ecapeVariable('$token') + ':refund';

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
   * Refunds and immediately revokes a user's subscription purchase. Access to
   * the subscription will be terminated immediately and it will stop recurring.
   *
   * Request parameters:
   *
   * [packageName] - The package name of the application for which this
   * subscription was purchased (for example, 'com.some.thing').
   *
   * [subscriptionId] - The purchased subscription ID (for example,
   * 'monthly001').
   *
   * [token] - The token provided to the user's device when the subscription was
   * purchased.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future revoke(core.String packageName, core.String subscriptionId, core.String token) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (subscriptionId == null) {
      throw new core.ArgumentError("Parameter subscriptionId is required.");
    }
    if (token == null) {
      throw new core.ArgumentError("Parameter token is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$packageName') + '/purchases/subscriptions/' + commons.Escaper.ecapeVariable('$subscriptionId') + '/tokens/' + commons.Escaper.ecapeVariable('$token') + ':revoke';

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


class PurchasesVoidedpurchasesResourceApi {
  final commons.ApiRequester _requester;

  PurchasesVoidedpurchasesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists the purchases that were cancelled, refunded or charged-back.
   *
   * Request parameters:
   *
   * [packageName] - The package name of the application for which voided
   * purchases need to be returned (for example, 'com.some.thing').
   *
   * [endTime] - The time, in milliseconds since the Epoch, of the newest voided
   * in-app product purchase that you want to see in the response. The value of
   * this parameter cannot be greater than the current time and is ignored if a
   * pagination token is set. Default value is current time.
   *
   * [maxResults] - null
   *
   * [startIndex] - null
   *
   * [startTime] - The time, in milliseconds since the Epoch, of the oldest
   * voided in-app product purchase that you want to see in the response. The
   * value of this parameter cannot be older than 30 days and is ignored if a
   * pagination token is set. Default value is current time minus 30 days.
   *
   * [token] - null
   *
   * Completes with a [VoidedPurchasesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VoidedPurchasesListResponse> list(core.String packageName, {core.String endTime, core.int maxResults, core.int startIndex, core.String startTime, core.String token}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (endTime != null) {
      _queryParams["endTime"] = [endTime];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }
    if (startTime != null) {
      _queryParams["startTime"] = [startTime];
    }
    if (token != null) {
      _queryParams["token"] = [token];
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/purchases/voidedpurchases';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VoidedPurchasesListResponse.fromJson(data));
  }

}


class ReviewsResourceApi {
  final commons.ApiRequester _requester;

  ReviewsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a single review.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app for which we want
   * reviews; for example, "com.spiffygame".
   *
   * [reviewId] - null
   *
   * [translationLanguage] - null
   *
   * Completes with a [Review].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Review> get(core.String packageName, core.String reviewId, {core.String translationLanguage}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (reviewId == null) {
      throw new core.ArgumentError("Parameter reviewId is required.");
    }
    if (translationLanguage != null) {
      _queryParams["translationLanguage"] = [translationLanguage];
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/reviews/' + commons.Escaper.ecapeVariable('$reviewId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Review.fromJson(data));
  }

  /**
   * Returns a list of reviews. Only reviews from last week will be returned.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app for which we want
   * reviews; for example, "com.spiffygame".
   *
   * [maxResults] - null
   *
   * [startIndex] - null
   *
   * [token] - null
   *
   * [translationLanguage] - null
   *
   * Completes with a [ReviewsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ReviewsListResponse> list(core.String packageName, {core.int maxResults, core.int startIndex, core.String token, core.String translationLanguage}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }
    if (token != null) {
      _queryParams["token"] = [token];
    }
    if (translationLanguage != null) {
      _queryParams["translationLanguage"] = [translationLanguage];
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/reviews';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ReviewsListResponse.fromJson(data));
  }

  /**
   * Reply to a single review, or update an existing reply.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [packageName] - Unique identifier for the Android app for which we want
   * reviews; for example, "com.spiffygame".
   *
   * [reviewId] - null
   *
   * Completes with a [ReviewsReplyResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ReviewsReplyResponse> reply(ReviewsReplyRequest request, core.String packageName, core.String reviewId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (packageName == null) {
      throw new core.ArgumentError("Parameter packageName is required.");
    }
    if (reviewId == null) {
      throw new core.ArgumentError("Parameter reviewId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$packageName') + '/reviews/' + commons.Escaper.ecapeVariable('$reviewId') + ':reply';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ReviewsReplyResponse.fromJson(data));
  }

}



class Apk {
  /** Information about the binary payload of this APK. */
  ApkBinary binary;
  /** The version code of the APK, as specified in the APK's manifest file. */
  core.int versionCode;

  Apk();

  Apk.fromJson(core.Map _json) {
    if (_json.containsKey("binary")) {
      binary = new ApkBinary.fromJson(_json["binary"]);
    }
    if (_json.containsKey("versionCode")) {
      versionCode = _json["versionCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (binary != null) {
      _json["binary"] = (binary).toJson();
    }
    if (versionCode != null) {
      _json["versionCode"] = versionCode;
    }
    return _json;
  }
}

/** Represents the binary payload of an APK. */
class ApkBinary {
  /**
   * A sha1 hash of the APK payload, encoded as a hex string and matching the
   * output of the sha1sum command.
   */
  core.String sha1;

  ApkBinary();

  ApkBinary.fromJson(core.Map _json) {
    if (_json.containsKey("sha1")) {
      sha1 = _json["sha1"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (sha1 != null) {
      _json["sha1"] = sha1;
    }
    return _json;
  }
}

class ApkListing {
  /** The language code, in BCP 47 format (eg "en-US"). */
  core.String language;
  /** Describe what's new in your APK. */
  core.String recentChanges;

  ApkListing();

  ApkListing.fromJson(core.Map _json) {
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("recentChanges")) {
      recentChanges = _json["recentChanges"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (language != null) {
      _json["language"] = language;
    }
    if (recentChanges != null) {
      _json["recentChanges"] = recentChanges;
    }
    return _json;
  }
}

class ApkListingsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "androidpublisher#apkListingsListResponse".
   */
  core.String kind;
  core.List<ApkListing> listings;

  ApkListingsListResponse();

  ApkListingsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("listings")) {
      listings = _json["listings"].map((value) => new ApkListing.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (listings != null) {
      _json["listings"] = listings.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ApksAddExternallyHostedRequest {
  /** The definition of the externally-hosted APK and where it is located. */
  ExternallyHostedApk externallyHostedApk;

  ApksAddExternallyHostedRequest();

  ApksAddExternallyHostedRequest.fromJson(core.Map _json) {
    if (_json.containsKey("externallyHostedApk")) {
      externallyHostedApk = new ExternallyHostedApk.fromJson(_json["externallyHostedApk"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (externallyHostedApk != null) {
      _json["externallyHostedApk"] = (externallyHostedApk).toJson();
    }
    return _json;
  }
}

class ApksAddExternallyHostedResponse {
  /** The definition of the externally-hosted APK and where it is located. */
  ExternallyHostedApk externallyHostedApk;

  ApksAddExternallyHostedResponse();

  ApksAddExternallyHostedResponse.fromJson(core.Map _json) {
    if (_json.containsKey("externallyHostedApk")) {
      externallyHostedApk = new ExternallyHostedApk.fromJson(_json["externallyHostedApk"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (externallyHostedApk != null) {
      _json["externallyHostedApk"] = (externallyHostedApk).toJson();
    }
    return _json;
  }
}

class ApksListResponse {
  core.List<Apk> apks;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "androidpublisher#apksListResponse".
   */
  core.String kind;

  ApksListResponse();

  ApksListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("apks")) {
      apks = _json["apks"].map((value) => new Apk.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (apks != null) {
      _json["apks"] = apks.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class AppDetails {
  /** The user-visible support email for this app. */
  core.String contactEmail;
  /** The user-visible support telephone number for this app. */
  core.String contactPhone;
  /** The user-visible website for this app. */
  core.String contactWebsite;
  /** Default language code, in BCP 47 format (eg "en-US"). */
  core.String defaultLanguage;

  AppDetails();

  AppDetails.fromJson(core.Map _json) {
    if (_json.containsKey("contactEmail")) {
      contactEmail = _json["contactEmail"];
    }
    if (_json.containsKey("contactPhone")) {
      contactPhone = _json["contactPhone"];
    }
    if (_json.containsKey("contactWebsite")) {
      contactWebsite = _json["contactWebsite"];
    }
    if (_json.containsKey("defaultLanguage")) {
      defaultLanguage = _json["defaultLanguage"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contactEmail != null) {
      _json["contactEmail"] = contactEmail;
    }
    if (contactPhone != null) {
      _json["contactPhone"] = contactPhone;
    }
    if (contactWebsite != null) {
      _json["contactWebsite"] = contactWebsite;
    }
    if (defaultLanguage != null) {
      _json["defaultLanguage"] = defaultLanguage;
    }
    return _json;
  }
}

/**
 * Represents an edit of an app. An edit allows clients to make multiple changes
 * before committing them in one operation.
 */
class AppEdit {
  /**
   * The time at which the edit will expire and will be no longer valid for use
   * in any subsequent API calls (encoded as seconds since the Epoch).
   */
  core.String expiryTimeSeconds;
  /** The ID of the edit that can be used in subsequent API calls. */
  core.String id;

  AppEdit();

  AppEdit.fromJson(core.Map _json) {
    if (_json.containsKey("expiryTimeSeconds")) {
      expiryTimeSeconds = _json["expiryTimeSeconds"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (expiryTimeSeconds != null) {
      _json["expiryTimeSeconds"] = expiryTimeSeconds;
    }
    if (id != null) {
      _json["id"] = id;
    }
    return _json;
  }
}

class Comment {
  /** A comment from a developer. */
  DeveloperComment developerComment;
  /** A comment from a user. */
  UserComment userComment;

  Comment();

  Comment.fromJson(core.Map _json) {
    if (_json.containsKey("developerComment")) {
      developerComment = new DeveloperComment.fromJson(_json["developerComment"]);
    }
    if (_json.containsKey("userComment")) {
      userComment = new UserComment.fromJson(_json["userComment"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (developerComment != null) {
      _json["developerComment"] = (developerComment).toJson();
    }
    if (userComment != null) {
      _json["userComment"] = (userComment).toJson();
    }
    return _json;
  }
}

/** Represents a deobfuscation file. */
class DeobfuscationFile {
  /** The type of the deobfuscation file. */
  core.String symbolType;

  DeobfuscationFile();

  DeobfuscationFile.fromJson(core.Map _json) {
    if (_json.containsKey("symbolType")) {
      symbolType = _json["symbolType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (symbolType != null) {
      _json["symbolType"] = symbolType;
    }
    return _json;
  }
}

class DeobfuscationFilesUploadResponse {
  DeobfuscationFile deobfuscationFile;

  DeobfuscationFilesUploadResponse();

  DeobfuscationFilesUploadResponse.fromJson(core.Map _json) {
    if (_json.containsKey("deobfuscationFile")) {
      deobfuscationFile = new DeobfuscationFile.fromJson(_json["deobfuscationFile"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deobfuscationFile != null) {
      _json["deobfuscationFile"] = (deobfuscationFile).toJson();
    }
    return _json;
  }
}

class DeveloperComment {
  /** The last time at which this comment was updated. */
  Timestamp lastModified;
  /** The content of the comment, i.e. reply body. */
  core.String text;

  DeveloperComment();

  DeveloperComment.fromJson(core.Map _json) {
    if (_json.containsKey("lastModified")) {
      lastModified = new Timestamp.fromJson(_json["lastModified"]);
    }
    if (_json.containsKey("text")) {
      text = _json["text"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lastModified != null) {
      _json["lastModified"] = (lastModified).toJson();
    }
    if (text != null) {
      _json["text"] = text;
    }
    return _json;
  }
}

class DeviceMetadata {
  /** Device CPU make e.g. "Qualcomm" */
  core.String cpuMake;
  /** Device CPU model e.g. "MSM8974" */
  core.String cpuModel;
  /** Device class (e.g. tablet) */
  core.String deviceClass;
  /** OpenGL version */
  core.int glEsVersion;
  /** Device manufacturer (e.g. Motorola) */
  core.String manufacturer;
  /** Comma separated list of native platforms (e.g. "arm", "arm7") */
  core.String nativePlatform;
  /** Device model name (e.g. Droid) */
  core.String productName;
  /** Device RAM in Megabytes e.g. "2048" */
  core.int ramMb;
  /** Screen density in DPI */
  core.int screenDensityDpi;
  /** Screen height in pixels */
  core.int screenHeightPx;
  /** Screen width in pixels */
  core.int screenWidthPx;

  DeviceMetadata();

  DeviceMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("cpuMake")) {
      cpuMake = _json["cpuMake"];
    }
    if (_json.containsKey("cpuModel")) {
      cpuModel = _json["cpuModel"];
    }
    if (_json.containsKey("deviceClass")) {
      deviceClass = _json["deviceClass"];
    }
    if (_json.containsKey("glEsVersion")) {
      glEsVersion = _json["glEsVersion"];
    }
    if (_json.containsKey("manufacturer")) {
      manufacturer = _json["manufacturer"];
    }
    if (_json.containsKey("nativePlatform")) {
      nativePlatform = _json["nativePlatform"];
    }
    if (_json.containsKey("productName")) {
      productName = _json["productName"];
    }
    if (_json.containsKey("ramMb")) {
      ramMb = _json["ramMb"];
    }
    if (_json.containsKey("screenDensityDpi")) {
      screenDensityDpi = _json["screenDensityDpi"];
    }
    if (_json.containsKey("screenHeightPx")) {
      screenHeightPx = _json["screenHeightPx"];
    }
    if (_json.containsKey("screenWidthPx")) {
      screenWidthPx = _json["screenWidthPx"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cpuMake != null) {
      _json["cpuMake"] = cpuMake;
    }
    if (cpuModel != null) {
      _json["cpuModel"] = cpuModel;
    }
    if (deviceClass != null) {
      _json["deviceClass"] = deviceClass;
    }
    if (glEsVersion != null) {
      _json["glEsVersion"] = glEsVersion;
    }
    if (manufacturer != null) {
      _json["manufacturer"] = manufacturer;
    }
    if (nativePlatform != null) {
      _json["nativePlatform"] = nativePlatform;
    }
    if (productName != null) {
      _json["productName"] = productName;
    }
    if (ramMb != null) {
      _json["ramMb"] = ramMb;
    }
    if (screenDensityDpi != null) {
      _json["screenDensityDpi"] = screenDensityDpi;
    }
    if (screenHeightPx != null) {
      _json["screenHeightPx"] = screenHeightPx;
    }
    if (screenWidthPx != null) {
      _json["screenWidthPx"] = screenWidthPx;
    }
    return _json;
  }
}

/**
 * An Entitlement resource indicates a user's current entitlement to an inapp
 * item or subscription.
 */
class Entitlement {
  /**
   * This kind represents an entitlement object in the androidpublisher service.
   */
  core.String kind;
  /** The SKU of the product. */
  core.String productId;
  /**
   * The type of the inapp product. Possible values are:
   * - In-app item: "inapp"
   * - Subscription: "subs"
   */
  core.String productType;
  /**
   * The token which can be verified using the subscriptions or products API.
   */
  core.String token;

  Entitlement();

  Entitlement.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("productType")) {
      productType = _json["productType"];
    }
    if (_json.containsKey("token")) {
      token = _json["token"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (productType != null) {
      _json["productType"] = productType;
    }
    if (token != null) {
      _json["token"] = token;
    }
    return _json;
  }
}

class EntitlementsListResponse {
  PageInfo pageInfo;
  core.List<Entitlement> resources;
  TokenPagination tokenPagination;

  EntitlementsListResponse();

  EntitlementsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("resources")) {
      resources = _json["resources"].map((value) => new Entitlement.fromJson(value)).toList();
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    return _json;
  }
}

class ExpansionFile {
  /**
   * If set this field indicates that this APK has an Expansion File uploaded to
   * it: this APK does not reference another APK's Expansion File. The field's
   * value is the size of the uploaded Expansion File in bytes.
   */
  core.String fileSize;
  /**
   * If set this APK's Expansion File references another APK's Expansion File.
   * The file_size field will not be set.
   */
  core.int referencesVersion;

  ExpansionFile();

  ExpansionFile.fromJson(core.Map _json) {
    if (_json.containsKey("fileSize")) {
      fileSize = _json["fileSize"];
    }
    if (_json.containsKey("referencesVersion")) {
      referencesVersion = _json["referencesVersion"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fileSize != null) {
      _json["fileSize"] = fileSize;
    }
    if (referencesVersion != null) {
      _json["referencesVersion"] = referencesVersion;
    }
    return _json;
  }
}

class ExpansionFilesUploadResponse {
  ExpansionFile expansionFile;

  ExpansionFilesUploadResponse();

  ExpansionFilesUploadResponse.fromJson(core.Map _json) {
    if (_json.containsKey("expansionFile")) {
      expansionFile = new ExpansionFile.fromJson(_json["expansionFile"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (expansionFile != null) {
      _json["expansionFile"] = (expansionFile).toJson();
    }
    return _json;
  }
}

/**
 * Defines an APK available for this application that is hosted externally and
 * not uploaded to Google Play. This function is only available to enterprises
 * who are using Google Play for Work, and whos application is restricted to the
 * enterprise private channel
 */
class ExternallyHostedApk {
  /** The application label. */
  core.String applicationLabel;
  /**
   * A certificate (or array of certificates if a certificate-chain is used)
   * used to signed this APK, represented as a base64 encoded byte array.
   */
  core.List<core.String> certificateBase64s;
  /** The URL at which the APK is hosted. This must be an https URL. */
  core.String externallyHostedUrl;
  /**
   * The SHA1 checksum of this APK, represented as a base64 encoded byte array.
   */
  core.String fileSha1Base64;
  /**
   * The SHA256 checksum of this APK, represented as a base64 encoded byte
   * array.
   */
  core.String fileSha256Base64;
  /** The file size in bytes of this APK. */
  core.String fileSize;
  /** The icon image from the APK, as a base64 encoded byte array. */
  core.String iconBase64;
  /** The maximum SDK supported by this APK (optional). */
  core.int maximumSdk;
  /** The minimum SDK targeted by this APK. */
  core.int minimumSdk;
  /** The native code environments supported by this APK (optional). */
  core.List<core.String> nativeCodes;
  /** The package name. */
  core.String packageName;
  /** The features required by this APK (optional). */
  core.List<core.String> usesFeatures;
  /** The permissions requested by this APK. */
  core.List<ExternallyHostedApkUsesPermission> usesPermissions;
  /** The version code of this APK. */
  core.int versionCode;
  /** The version name of this APK. */
  core.String versionName;

  ExternallyHostedApk();

  ExternallyHostedApk.fromJson(core.Map _json) {
    if (_json.containsKey("applicationLabel")) {
      applicationLabel = _json["applicationLabel"];
    }
    if (_json.containsKey("certificateBase64s")) {
      certificateBase64s = _json["certificateBase64s"];
    }
    if (_json.containsKey("externallyHostedUrl")) {
      externallyHostedUrl = _json["externallyHostedUrl"];
    }
    if (_json.containsKey("fileSha1Base64")) {
      fileSha1Base64 = _json["fileSha1Base64"];
    }
    if (_json.containsKey("fileSha256Base64")) {
      fileSha256Base64 = _json["fileSha256Base64"];
    }
    if (_json.containsKey("fileSize")) {
      fileSize = _json["fileSize"];
    }
    if (_json.containsKey("iconBase64")) {
      iconBase64 = _json["iconBase64"];
    }
    if (_json.containsKey("maximumSdk")) {
      maximumSdk = _json["maximumSdk"];
    }
    if (_json.containsKey("minimumSdk")) {
      minimumSdk = _json["minimumSdk"];
    }
    if (_json.containsKey("nativeCodes")) {
      nativeCodes = _json["nativeCodes"];
    }
    if (_json.containsKey("packageName")) {
      packageName = _json["packageName"];
    }
    if (_json.containsKey("usesFeatures")) {
      usesFeatures = _json["usesFeatures"];
    }
    if (_json.containsKey("usesPermissions")) {
      usesPermissions = _json["usesPermissions"].map((value) => new ExternallyHostedApkUsesPermission.fromJson(value)).toList();
    }
    if (_json.containsKey("versionCode")) {
      versionCode = _json["versionCode"];
    }
    if (_json.containsKey("versionName")) {
      versionName = _json["versionName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (applicationLabel != null) {
      _json["applicationLabel"] = applicationLabel;
    }
    if (certificateBase64s != null) {
      _json["certificateBase64s"] = certificateBase64s;
    }
    if (externallyHostedUrl != null) {
      _json["externallyHostedUrl"] = externallyHostedUrl;
    }
    if (fileSha1Base64 != null) {
      _json["fileSha1Base64"] = fileSha1Base64;
    }
    if (fileSha256Base64 != null) {
      _json["fileSha256Base64"] = fileSha256Base64;
    }
    if (fileSize != null) {
      _json["fileSize"] = fileSize;
    }
    if (iconBase64 != null) {
      _json["iconBase64"] = iconBase64;
    }
    if (maximumSdk != null) {
      _json["maximumSdk"] = maximumSdk;
    }
    if (minimumSdk != null) {
      _json["minimumSdk"] = minimumSdk;
    }
    if (nativeCodes != null) {
      _json["nativeCodes"] = nativeCodes;
    }
    if (packageName != null) {
      _json["packageName"] = packageName;
    }
    if (usesFeatures != null) {
      _json["usesFeatures"] = usesFeatures;
    }
    if (usesPermissions != null) {
      _json["usesPermissions"] = usesPermissions.map((value) => (value).toJson()).toList();
    }
    if (versionCode != null) {
      _json["versionCode"] = versionCode;
    }
    if (versionName != null) {
      _json["versionName"] = versionName;
    }
    return _json;
  }
}

/** A permission used by this APK. */
class ExternallyHostedApkUsesPermission {
  /**
   * Optionally, the maximum SDK version for which the permission is required.
   */
  core.int maxSdkVersion;
  /** The name of the permission requested. */
  core.String name;

  ExternallyHostedApkUsesPermission();

  ExternallyHostedApkUsesPermission.fromJson(core.Map _json) {
    if (_json.containsKey("maxSdkVersion")) {
      maxSdkVersion = _json["maxSdkVersion"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (maxSdkVersion != null) {
      _json["maxSdkVersion"] = maxSdkVersion;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

class Image {
  /** A unique id representing this image. */
  core.String id;
  /** A sha1 hash of the image that was uploaded. */
  core.String sha1;
  /** A URL that will serve a preview of the image. */
  core.String url;

  Image();

  Image.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("sha1")) {
      sha1 = _json["sha1"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (sha1 != null) {
      _json["sha1"] = sha1;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class ImagesDeleteAllResponse {
  core.List<Image> deleted;

  ImagesDeleteAllResponse();

  ImagesDeleteAllResponse.fromJson(core.Map _json) {
    if (_json.containsKey("deleted")) {
      deleted = _json["deleted"].map((value) => new Image.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deleted != null) {
      _json["deleted"] = deleted.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ImagesListResponse {
  core.List<Image> images;

  ImagesListResponse();

  ImagesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("images")) {
      images = _json["images"].map((value) => new Image.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (images != null) {
      _json["images"] = images.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ImagesUploadResponse {
  Image image;

  ImagesUploadResponse();

  ImagesUploadResponse.fromJson(core.Map _json) {
    if (_json.containsKey("image")) {
      image = new Image.fromJson(_json["image"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    return _json;
  }
}

class InAppProduct {
  /**
   * The default language of the localized data, as defined by BCP 47. e.g.
   * "en-US", "en-GB".
   */
  core.String defaultLanguage;
  /**
   * Default price cannot be zero. In-app products can never be free. Default
   * price is always in the developer's Checkout merchant currency.
   */
  Price defaultPrice;
  /** List of localized title and description data. */
  core.Map<core.String, InAppProductListing> listings;
  /** The package name of the parent app. */
  core.String packageName;
  /**
   * Prices per buyer region. None of these prices should be zero. In-app
   * products can never be free.
   */
  core.Map<core.String, Price> prices;
  /** Purchase type enum value. Unmodifiable after creation. */
  core.String purchaseType;
  /**
   * Definition of a season for a seasonal subscription. Can be defined only for
   * yearly subscriptions.
   */
  Season season;
  /** The stock-keeping-unit (SKU) of the product, unique within an app. */
  core.String sku;
  core.String status;
  /**
   * Subscription period, specified in ISO 8601 format. Acceptable values are
   * "P1W" (one week), "P1M" (one month), "P3M" (three months), "P6M" (six
   * months), and "P1Y" (one year).
   */
  core.String subscriptionPeriod;
  /**
   * Trial period, specified in ISO 8601 format. Acceptable values are anything
   * between "P7D" (seven days) and "P999D" (999 days). Seasonal subscriptions
   * cannot have a trial period.
   */
  core.String trialPeriod;

  InAppProduct();

  InAppProduct.fromJson(core.Map _json) {
    if (_json.containsKey("defaultLanguage")) {
      defaultLanguage = _json["defaultLanguage"];
    }
    if (_json.containsKey("defaultPrice")) {
      defaultPrice = new Price.fromJson(_json["defaultPrice"]);
    }
    if (_json.containsKey("listings")) {
      listings = commons.mapMap(_json["listings"], (item) => new InAppProductListing.fromJson(item));
    }
    if (_json.containsKey("packageName")) {
      packageName = _json["packageName"];
    }
    if (_json.containsKey("prices")) {
      prices = commons.mapMap(_json["prices"], (item) => new Price.fromJson(item));
    }
    if (_json.containsKey("purchaseType")) {
      purchaseType = _json["purchaseType"];
    }
    if (_json.containsKey("season")) {
      season = new Season.fromJson(_json["season"]);
    }
    if (_json.containsKey("sku")) {
      sku = _json["sku"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("subscriptionPeriod")) {
      subscriptionPeriod = _json["subscriptionPeriod"];
    }
    if (_json.containsKey("trialPeriod")) {
      trialPeriod = _json["trialPeriod"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (defaultLanguage != null) {
      _json["defaultLanguage"] = defaultLanguage;
    }
    if (defaultPrice != null) {
      _json["defaultPrice"] = (defaultPrice).toJson();
    }
    if (listings != null) {
      _json["listings"] = commons.mapMap(listings, (item) => (item).toJson());
    }
    if (packageName != null) {
      _json["packageName"] = packageName;
    }
    if (prices != null) {
      _json["prices"] = commons.mapMap(prices, (item) => (item).toJson());
    }
    if (purchaseType != null) {
      _json["purchaseType"] = purchaseType;
    }
    if (season != null) {
      _json["season"] = (season).toJson();
    }
    if (sku != null) {
      _json["sku"] = sku;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (subscriptionPeriod != null) {
      _json["subscriptionPeriod"] = subscriptionPeriod;
    }
    if (trialPeriod != null) {
      _json["trialPeriod"] = trialPeriod;
    }
    return _json;
  }
}

class InAppProductListing {
  core.String description;
  core.String title;

  InAppProductListing();

  InAppProductListing.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class InappproductsBatchRequest {
  core.List<InappproductsBatchRequestEntry> entrys;

  InappproductsBatchRequest();

  InappproductsBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entrys")) {
      entrys = _json["entrys"].map((value) => new InappproductsBatchRequestEntry.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entrys != null) {
      _json["entrys"] = entrys.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class InappproductsBatchRequestEntry {
  core.int batchId;
  InappproductsInsertRequest inappproductsinsertrequest;
  InappproductsUpdateRequest inappproductsupdaterequest;
  core.String methodName;

  InappproductsBatchRequestEntry();

  InappproductsBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("inappproductsinsertrequest")) {
      inappproductsinsertrequest = new InappproductsInsertRequest.fromJson(_json["inappproductsinsertrequest"]);
    }
    if (_json.containsKey("inappproductsupdaterequest")) {
      inappproductsupdaterequest = new InappproductsUpdateRequest.fromJson(_json["inappproductsupdaterequest"]);
    }
    if (_json.containsKey("methodName")) {
      methodName = _json["methodName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (inappproductsinsertrequest != null) {
      _json["inappproductsinsertrequest"] = (inappproductsinsertrequest).toJson();
    }
    if (inappproductsupdaterequest != null) {
      _json["inappproductsupdaterequest"] = (inappproductsupdaterequest).toJson();
    }
    if (methodName != null) {
      _json["methodName"] = methodName;
    }
    return _json;
  }
}

class InappproductsBatchResponse {
  core.List<InappproductsBatchResponseEntry> entrys;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "androidpublisher#inappproductsBatchResponse".
   */
  core.String kind;

  InappproductsBatchResponse();

  InappproductsBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entrys")) {
      entrys = _json["entrys"].map((value) => new InappproductsBatchResponseEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entrys != null) {
      _json["entrys"] = entrys.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class InappproductsBatchResponseEntry {
  core.int batchId;
  InappproductsInsertResponse inappproductsinsertresponse;
  InappproductsUpdateResponse inappproductsupdateresponse;

  InappproductsBatchResponseEntry();

  InappproductsBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("inappproductsinsertresponse")) {
      inappproductsinsertresponse = new InappproductsInsertResponse.fromJson(_json["inappproductsinsertresponse"]);
    }
    if (_json.containsKey("inappproductsupdateresponse")) {
      inappproductsupdateresponse = new InappproductsUpdateResponse.fromJson(_json["inappproductsupdateresponse"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (inappproductsinsertresponse != null) {
      _json["inappproductsinsertresponse"] = (inappproductsinsertresponse).toJson();
    }
    if (inappproductsupdateresponse != null) {
      _json["inappproductsupdateresponse"] = (inappproductsupdateresponse).toJson();
    }
    return _json;
  }
}

class InappproductsInsertRequest {
  InAppProduct inappproduct;

  InappproductsInsertRequest();

  InappproductsInsertRequest.fromJson(core.Map _json) {
    if (_json.containsKey("inappproduct")) {
      inappproduct = new InAppProduct.fromJson(_json["inappproduct"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (inappproduct != null) {
      _json["inappproduct"] = (inappproduct).toJson();
    }
    return _json;
  }
}

class InappproductsInsertResponse {
  InAppProduct inappproduct;

  InappproductsInsertResponse();

  InappproductsInsertResponse.fromJson(core.Map _json) {
    if (_json.containsKey("inappproduct")) {
      inappproduct = new InAppProduct.fromJson(_json["inappproduct"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (inappproduct != null) {
      _json["inappproduct"] = (inappproduct).toJson();
    }
    return _json;
  }
}

class InappproductsListResponse {
  core.List<InAppProduct> inappproduct;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "androidpublisher#inappproductsListResponse".
   */
  core.String kind;
  PageInfo pageInfo;
  TokenPagination tokenPagination;

  InappproductsListResponse();

  InappproductsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("inappproduct")) {
      inappproduct = _json["inappproduct"].map((value) => new InAppProduct.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (inappproduct != null) {
      _json["inappproduct"] = inappproduct.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    return _json;
  }
}

class InappproductsUpdateRequest {
  InAppProduct inappproduct;

  InappproductsUpdateRequest();

  InappproductsUpdateRequest.fromJson(core.Map _json) {
    if (_json.containsKey("inappproduct")) {
      inappproduct = new InAppProduct.fromJson(_json["inappproduct"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (inappproduct != null) {
      _json["inappproduct"] = (inappproduct).toJson();
    }
    return _json;
  }
}

class InappproductsUpdateResponse {
  InAppProduct inappproduct;

  InappproductsUpdateResponse();

  InappproductsUpdateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("inappproduct")) {
      inappproduct = new InAppProduct.fromJson(_json["inappproduct"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (inappproduct != null) {
      _json["inappproduct"] = (inappproduct).toJson();
    }
    return _json;
  }
}

class Listing {
  /**
   * Full description of the app; this may be up to 4000 characters in length.
   */
  core.String fullDescription;
  /** Language localization code (for example, "de-AT" for Austrian German). */
  core.String language;
  /**
   * Short description of the app (previously known as promo text); this may be
   * up to 80 characters in length.
   */
  core.String shortDescription;
  /** App's localized title. */
  core.String title;
  /** URL of a promotional YouTube video for the app. */
  core.String video;

  Listing();

  Listing.fromJson(core.Map _json) {
    if (_json.containsKey("fullDescription")) {
      fullDescription = _json["fullDescription"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("shortDescription")) {
      shortDescription = _json["shortDescription"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("video")) {
      video = _json["video"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fullDescription != null) {
      _json["fullDescription"] = fullDescription;
    }
    if (language != null) {
      _json["language"] = language;
    }
    if (shortDescription != null) {
      _json["shortDescription"] = shortDescription;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (video != null) {
      _json["video"] = video;
    }
    return _json;
  }
}

class ListingsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "androidpublisher#listingsListResponse".
   */
  core.String kind;
  core.List<Listing> listings;

  ListingsListResponse();

  ListingsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("listings")) {
      listings = _json["listings"].map((value) => new Listing.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (listings != null) {
      _json["listings"] = listings.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class MonthDay {
  /**
   * Day of a month, value in [1, 31] range. Valid range depends on the
   * specified month.
   */
  core.int day;
  /** Month of a year. e.g. 1 = JAN, 2 = FEB etc. */
  core.int month;

  MonthDay();

  MonthDay.fromJson(core.Map _json) {
    if (_json.containsKey("day")) {
      day = _json["day"];
    }
    if (_json.containsKey("month")) {
      month = _json["month"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (day != null) {
      _json["day"] = day;
    }
    if (month != null) {
      _json["month"] = month;
    }
    return _json;
  }
}

class PageInfo {
  core.int resultPerPage;
  core.int startIndex;
  core.int totalResults;

  PageInfo();

  PageInfo.fromJson(core.Map _json) {
    if (_json.containsKey("resultPerPage")) {
      resultPerPage = _json["resultPerPage"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (resultPerPage != null) {
      _json["resultPerPage"] = resultPerPage;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    return _json;
  }
}

class Price {
  /** 3 letter Currency code, as defined by ISO 4217. */
  core.String currency;
  /**
   * The price in millionths of the currency base unit represented as a string.
   */
  core.String priceMicros;

  Price();

  Price.fromJson(core.Map _json) {
    if (_json.containsKey("currency")) {
      currency = _json["currency"];
    }
    if (_json.containsKey("priceMicros")) {
      priceMicros = _json["priceMicros"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (currency != null) {
      _json["currency"] = currency;
    }
    if (priceMicros != null) {
      _json["priceMicros"] = priceMicros;
    }
    return _json;
  }
}

/**
 * A ProductPurchase resource indicates the status of a user's inapp product
 * purchase.
 */
class ProductPurchase {
  /**
   * The consumption state of the inapp product. Possible values are:
   * - Yet to be consumed
   * - Consumed
   */
  core.int consumptionState;
  /**
   * A developer-specified string that contains supplemental information about
   * an order.
   */
  core.String developerPayload;
  /**
   * This kind represents an inappPurchase object in the androidpublisher
   * service.
   */
  core.String kind;
  /**
   * The purchase state of the order. Possible values are:
   * - Purchased
   * - Cancelled
   */
  core.int purchaseState;
  /**
   * The time the product was purchased, in milliseconds since the epoch (Jan 1,
   * 1970).
   */
  core.String purchaseTimeMillis;

  ProductPurchase();

  ProductPurchase.fromJson(core.Map _json) {
    if (_json.containsKey("consumptionState")) {
      consumptionState = _json["consumptionState"];
    }
    if (_json.containsKey("developerPayload")) {
      developerPayload = _json["developerPayload"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("purchaseState")) {
      purchaseState = _json["purchaseState"];
    }
    if (_json.containsKey("purchaseTimeMillis")) {
      purchaseTimeMillis = _json["purchaseTimeMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (consumptionState != null) {
      _json["consumptionState"] = consumptionState;
    }
    if (developerPayload != null) {
      _json["developerPayload"] = developerPayload;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (purchaseState != null) {
      _json["purchaseState"] = purchaseState;
    }
    if (purchaseTimeMillis != null) {
      _json["purchaseTimeMillis"] = purchaseTimeMillis;
    }
    return _json;
  }
}

class Prorate {
  /**
   * Default price cannot be zero and must be less than the full subscription
   * price. Default price is always in the developer's Checkout merchant
   * currency. Targeted countries have their prices set automatically based on
   * the default_price.
   */
  Price defaultPrice;
  /** Defines the first day on which the price takes effect. */
  MonthDay start;

  Prorate();

  Prorate.fromJson(core.Map _json) {
    if (_json.containsKey("defaultPrice")) {
      defaultPrice = new Price.fromJson(_json["defaultPrice"]);
    }
    if (_json.containsKey("start")) {
      start = new MonthDay.fromJson(_json["start"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (defaultPrice != null) {
      _json["defaultPrice"] = (defaultPrice).toJson();
    }
    if (start != null) {
      _json["start"] = (start).toJson();
    }
    return _json;
  }
}

class Review {
  /** The name of the user who wrote the review. */
  core.String authorName;
  /** A repeated field containing comments for the review. */
  core.List<Comment> comments;
  /** Unique identifier for this review. */
  core.String reviewId;

  Review();

  Review.fromJson(core.Map _json) {
    if (_json.containsKey("authorName")) {
      authorName = _json["authorName"];
    }
    if (_json.containsKey("comments")) {
      comments = _json["comments"].map((value) => new Comment.fromJson(value)).toList();
    }
    if (_json.containsKey("reviewId")) {
      reviewId = _json["reviewId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (authorName != null) {
      _json["authorName"] = authorName;
    }
    if (comments != null) {
      _json["comments"] = comments.map((value) => (value).toJson()).toList();
    }
    if (reviewId != null) {
      _json["reviewId"] = reviewId;
    }
    return _json;
  }
}

class ReviewReplyResult {
  /** The time at which the reply took effect. */
  Timestamp lastEdited;
  /** The reply text that was applied. */
  core.String replyText;

  ReviewReplyResult();

  ReviewReplyResult.fromJson(core.Map _json) {
    if (_json.containsKey("lastEdited")) {
      lastEdited = new Timestamp.fromJson(_json["lastEdited"]);
    }
    if (_json.containsKey("replyText")) {
      replyText = _json["replyText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lastEdited != null) {
      _json["lastEdited"] = (lastEdited).toJson();
    }
    if (replyText != null) {
      _json["replyText"] = replyText;
    }
    return _json;
  }
}

class ReviewsListResponse {
  PageInfo pageInfo;
  core.List<Review> reviews;
  TokenPagination tokenPagination;

  ReviewsListResponse();

  ReviewsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("reviews")) {
      reviews = _json["reviews"].map((value) => new Review.fromJson(value)).toList();
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (reviews != null) {
      _json["reviews"] = reviews.map((value) => (value).toJson()).toList();
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    return _json;
  }
}

class ReviewsReplyRequest {
  /**
   * The text to set as the reply. Replies of more than approximately 350
   * characters will be rejected. HTML tags will be stripped.
   */
  core.String replyText;

  ReviewsReplyRequest();

  ReviewsReplyRequest.fromJson(core.Map _json) {
    if (_json.containsKey("replyText")) {
      replyText = _json["replyText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (replyText != null) {
      _json["replyText"] = replyText;
    }
    return _json;
  }
}

class ReviewsReplyResponse {
  ReviewReplyResult result;

  ReviewsReplyResponse();

  ReviewsReplyResponse.fromJson(core.Map _json) {
    if (_json.containsKey("result")) {
      result = new ReviewReplyResult.fromJson(_json["result"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (result != null) {
      _json["result"] = (result).toJson();
    }
    return _json;
  }
}

class Season {
  /** Inclusive end date of the recurrence period. */
  MonthDay end;
  /**
   * Optionally present list of prorations for the season. Each proration is a
   * one-off discounted entry into a subscription. Each proration contains the
   * first date on which the discount is available and the new pricing
   * information.
   */
  core.List<Prorate> prorations;
  /** Inclusive start date of the recurrence period. */
  MonthDay start;

  Season();

  Season.fromJson(core.Map _json) {
    if (_json.containsKey("end")) {
      end = new MonthDay.fromJson(_json["end"]);
    }
    if (_json.containsKey("prorations")) {
      prorations = _json["prorations"].map((value) => new Prorate.fromJson(value)).toList();
    }
    if (_json.containsKey("start")) {
      start = new MonthDay.fromJson(_json["start"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (end != null) {
      _json["end"] = (end).toJson();
    }
    if (prorations != null) {
      _json["prorations"] = prorations.map((value) => (value).toJson()).toList();
    }
    if (start != null) {
      _json["start"] = (start).toJson();
    }
    return _json;
  }
}

/**
 * A SubscriptionDeferralInfo contains the data needed to defer a subscription
 * purchase to a future expiry time.
 */
class SubscriptionDeferralInfo {
  /**
   * The desired next expiry time to assign to the subscription, in milliseconds
   * since the Epoch. The given time must be later/greater than the current
   * expiry time for the subscription.
   */
  core.String desiredExpiryTimeMillis;
  /**
   * The expected expiry time for the subscription. If the current expiry time
   * for the subscription is not the value specified here, the deferral will not
   * occur.
   */
  core.String expectedExpiryTimeMillis;

  SubscriptionDeferralInfo();

  SubscriptionDeferralInfo.fromJson(core.Map _json) {
    if (_json.containsKey("desiredExpiryTimeMillis")) {
      desiredExpiryTimeMillis = _json["desiredExpiryTimeMillis"];
    }
    if (_json.containsKey("expectedExpiryTimeMillis")) {
      expectedExpiryTimeMillis = _json["expectedExpiryTimeMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (desiredExpiryTimeMillis != null) {
      _json["desiredExpiryTimeMillis"] = desiredExpiryTimeMillis;
    }
    if (expectedExpiryTimeMillis != null) {
      _json["expectedExpiryTimeMillis"] = expectedExpiryTimeMillis;
    }
    return _json;
  }
}

/**
 * A SubscriptionPurchase resource indicates the status of a user's subscription
 * purchase.
 */
class SubscriptionPurchase {
  /**
   * Whether the subscription will automatically be renewed when it reaches its
   * current expiry time.
   */
  core.bool autoRenewing;
  /**
   * The reason why a subscription was cancelled or is not auto-renewing.
   * Possible values are:
   * - User cancelled the subscription
   * - Subscription was cancelled by the system, for example because of a
   * billing problem
   */
  core.int cancelReason;
  /**
   * ISO 3166-1 alpha-2 billing country/region code of the user at the time the
   * subscription was granted.
   */
  core.String countryCode;
  /**
   * A developer-specified string that contains supplemental information about
   * an order.
   */
  core.String developerPayload;
  /**
   * Time at which the subscription will expire, in milliseconds since the
   * Epoch.
   */
  core.String expiryTimeMillis;
  /**
   * This kind represents a subscriptionPurchase object in the androidpublisher
   * service.
   */
  core.String kind;
  /**
   * The payment state of the subscription. Possible values are:
   * - Payment pending
   * - Payment received
   */
  core.int paymentState;
  /**
   * Price of the subscription, not including tax. Price is expressed in
   * micro-units, where 1,000,000 micro-units represents one unit of the
   * currency. For example, if the subscription price is €1.99,
   * price_amount_micros is 1990000.
   */
  core.String priceAmountMicros;
  /**
   * ISO 4217 currency code for the subscription price. For example, if the
   * price is specified in British pounds sterling, price_currency_code is
   * "GBP".
   */
  core.String priceCurrencyCode;
  /**
   * Time at which the subscription was granted, in milliseconds since the
   * Epoch.
   */
  core.String startTimeMillis;
  /**
   * The time at which the subscription was canceled by the user, in
   * milliseconds since the epoch. Only present if cancelReason is 0.
   */
  core.String userCancellationTimeMillis;

  SubscriptionPurchase();

  SubscriptionPurchase.fromJson(core.Map _json) {
    if (_json.containsKey("autoRenewing")) {
      autoRenewing = _json["autoRenewing"];
    }
    if (_json.containsKey("cancelReason")) {
      cancelReason = _json["cancelReason"];
    }
    if (_json.containsKey("countryCode")) {
      countryCode = _json["countryCode"];
    }
    if (_json.containsKey("developerPayload")) {
      developerPayload = _json["developerPayload"];
    }
    if (_json.containsKey("expiryTimeMillis")) {
      expiryTimeMillis = _json["expiryTimeMillis"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("paymentState")) {
      paymentState = _json["paymentState"];
    }
    if (_json.containsKey("priceAmountMicros")) {
      priceAmountMicros = _json["priceAmountMicros"];
    }
    if (_json.containsKey("priceCurrencyCode")) {
      priceCurrencyCode = _json["priceCurrencyCode"];
    }
    if (_json.containsKey("startTimeMillis")) {
      startTimeMillis = _json["startTimeMillis"];
    }
    if (_json.containsKey("userCancellationTimeMillis")) {
      userCancellationTimeMillis = _json["userCancellationTimeMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (autoRenewing != null) {
      _json["autoRenewing"] = autoRenewing;
    }
    if (cancelReason != null) {
      _json["cancelReason"] = cancelReason;
    }
    if (countryCode != null) {
      _json["countryCode"] = countryCode;
    }
    if (developerPayload != null) {
      _json["developerPayload"] = developerPayload;
    }
    if (expiryTimeMillis != null) {
      _json["expiryTimeMillis"] = expiryTimeMillis;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (paymentState != null) {
      _json["paymentState"] = paymentState;
    }
    if (priceAmountMicros != null) {
      _json["priceAmountMicros"] = priceAmountMicros;
    }
    if (priceCurrencyCode != null) {
      _json["priceCurrencyCode"] = priceCurrencyCode;
    }
    if (startTimeMillis != null) {
      _json["startTimeMillis"] = startTimeMillis;
    }
    if (userCancellationTimeMillis != null) {
      _json["userCancellationTimeMillis"] = userCancellationTimeMillis;
    }
    return _json;
  }
}

class SubscriptionPurchasesDeferRequest {
  /**
   * The information about the new desired expiry time for the subscription.
   */
  SubscriptionDeferralInfo deferralInfo;

  SubscriptionPurchasesDeferRequest();

  SubscriptionPurchasesDeferRequest.fromJson(core.Map _json) {
    if (_json.containsKey("deferralInfo")) {
      deferralInfo = new SubscriptionDeferralInfo.fromJson(_json["deferralInfo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deferralInfo != null) {
      _json["deferralInfo"] = (deferralInfo).toJson();
    }
    return _json;
  }
}

class SubscriptionPurchasesDeferResponse {
  /**
   * The new expiry time for the subscription in milliseconds since the Epoch.
   */
  core.String newExpiryTimeMillis;

  SubscriptionPurchasesDeferResponse();

  SubscriptionPurchasesDeferResponse.fromJson(core.Map _json) {
    if (_json.containsKey("newExpiryTimeMillis")) {
      newExpiryTimeMillis = _json["newExpiryTimeMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (newExpiryTimeMillis != null) {
      _json["newExpiryTimeMillis"] = newExpiryTimeMillis;
    }
    return _json;
  }
}

class Testers {
  core.List<core.String> googleGroups;
  core.List<core.String> googlePlusCommunities;

  Testers();

  Testers.fromJson(core.Map _json) {
    if (_json.containsKey("googleGroups")) {
      googleGroups = _json["googleGroups"];
    }
    if (_json.containsKey("googlePlusCommunities")) {
      googlePlusCommunities = _json["googlePlusCommunities"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (googleGroups != null) {
      _json["googleGroups"] = googleGroups;
    }
    if (googlePlusCommunities != null) {
      _json["googlePlusCommunities"] = googlePlusCommunities;
    }
    return _json;
  }
}

class Timestamp {
  core.int nanos;
  core.String seconds;

  Timestamp();

  Timestamp.fromJson(core.Map _json) {
    if (_json.containsKey("nanos")) {
      nanos = _json["nanos"];
    }
    if (_json.containsKey("seconds")) {
      seconds = _json["seconds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nanos != null) {
      _json["nanos"] = nanos;
    }
    if (seconds != null) {
      _json["seconds"] = seconds;
    }
    return _json;
  }
}

class TokenPagination {
  core.String nextPageToken;
  core.String previousPageToken;

  TokenPagination();

  TokenPagination.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("previousPageToken")) {
      previousPageToken = _json["previousPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (previousPageToken != null) {
      _json["previousPageToken"] = previousPageToken;
    }
    return _json;
  }
}

class Track {
  core.String track;
  core.double userFraction;
  core.List<core.int> versionCodes;

  Track();

  Track.fromJson(core.Map _json) {
    if (_json.containsKey("track")) {
      track = _json["track"];
    }
    if (_json.containsKey("userFraction")) {
      userFraction = _json["userFraction"];
    }
    if (_json.containsKey("versionCodes")) {
      versionCodes = _json["versionCodes"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (track != null) {
      _json["track"] = track;
    }
    if (userFraction != null) {
      _json["userFraction"] = userFraction;
    }
    if (versionCodes != null) {
      _json["versionCodes"] = versionCodes;
    }
    return _json;
  }
}

class TracksListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "androidpublisher#tracksListResponse".
   */
  core.String kind;
  core.List<Track> tracks;

  TracksListResponse();

  TracksListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("tracks")) {
      tracks = _json["tracks"].map((value) => new Track.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (tracks != null) {
      _json["tracks"] = tracks.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class UserComment {
  /**
   * Integer Android SDK version of the user's device at the time the review was
   * written, e.g. 23 is Marshmallow. May be absent.
   */
  core.int androidOsVersion;
  /**
   * Integer version code of the app as installed at the time the review was
   * written. May be absent.
   */
  core.int appVersionCode;
  /**
   * String version name of the app as installed at the time the review was
   * written. May be absent.
   */
  core.String appVersionName;
  /**
   * Codename for the reviewer's device, e.g. klte, flounder. May be absent.
   */
  core.String device;
  /** Some information about the characteristics of the user's device */
  DeviceMetadata deviceMetadata;
  /** The last time at which this comment was updated. */
  Timestamp lastModified;
  /**
   * Untranslated text of the review, in the case where the review has been
   * translated. If the review has not been translated this is left blank.
   */
  core.String originalText;
  /**
   * Language code for the reviewer. This is taken from the device settings so
   * is not guaranteed to match the language the review is written in. May be
   * absent.
   */
  core.String reviewerLanguage;
  /** The star rating associated with the review, from 1 to 5. */
  core.int starRating;
  /**
   * The content of the comment, i.e. review body. In some cases users have been
   * able to write a review with separate title and body; in those cases the
   * title and body are concatenated and separated by a tab character.
   */
  core.String text;
  /** Number of users who have given this review a thumbs down */
  core.int thumbsDownCount;
  /** Number of users who have given this review a thumbs up */
  core.int thumbsUpCount;

  UserComment();

  UserComment.fromJson(core.Map _json) {
    if (_json.containsKey("androidOsVersion")) {
      androidOsVersion = _json["androidOsVersion"];
    }
    if (_json.containsKey("appVersionCode")) {
      appVersionCode = _json["appVersionCode"];
    }
    if (_json.containsKey("appVersionName")) {
      appVersionName = _json["appVersionName"];
    }
    if (_json.containsKey("device")) {
      device = _json["device"];
    }
    if (_json.containsKey("deviceMetadata")) {
      deviceMetadata = new DeviceMetadata.fromJson(_json["deviceMetadata"]);
    }
    if (_json.containsKey("lastModified")) {
      lastModified = new Timestamp.fromJson(_json["lastModified"]);
    }
    if (_json.containsKey("originalText")) {
      originalText = _json["originalText"];
    }
    if (_json.containsKey("reviewerLanguage")) {
      reviewerLanguage = _json["reviewerLanguage"];
    }
    if (_json.containsKey("starRating")) {
      starRating = _json["starRating"];
    }
    if (_json.containsKey("text")) {
      text = _json["text"];
    }
    if (_json.containsKey("thumbsDownCount")) {
      thumbsDownCount = _json["thumbsDownCount"];
    }
    if (_json.containsKey("thumbsUpCount")) {
      thumbsUpCount = _json["thumbsUpCount"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (androidOsVersion != null) {
      _json["androidOsVersion"] = androidOsVersion;
    }
    if (appVersionCode != null) {
      _json["appVersionCode"] = appVersionCode;
    }
    if (appVersionName != null) {
      _json["appVersionName"] = appVersionName;
    }
    if (device != null) {
      _json["device"] = device;
    }
    if (deviceMetadata != null) {
      _json["deviceMetadata"] = (deviceMetadata).toJson();
    }
    if (lastModified != null) {
      _json["lastModified"] = (lastModified).toJson();
    }
    if (originalText != null) {
      _json["originalText"] = originalText;
    }
    if (reviewerLanguage != null) {
      _json["reviewerLanguage"] = reviewerLanguage;
    }
    if (starRating != null) {
      _json["starRating"] = starRating;
    }
    if (text != null) {
      _json["text"] = text;
    }
    if (thumbsDownCount != null) {
      _json["thumbsDownCount"] = thumbsDownCount;
    }
    if (thumbsUpCount != null) {
      _json["thumbsUpCount"] = thumbsUpCount;
    }
    return _json;
  }
}

/**
 * A VoidedPurchase resource indicates a purchase that was either
 * cancelled/refunded/charged-back.
 */
class VoidedPurchase {
  /**
   * This kind represents a voided purchase object in the androidpublisher
   * service.
   */
  core.String kind;
  /**
   * The time at which the purchase was made, in milliseconds since the epoch
   * (Jan 1, 1970).
   */
  core.String purchaseTimeMillis;
  /**
   * The token that was generated when a purchase was made. This uniquely
   * identifies a purchase.
   */
  core.String purchaseToken;
  /**
   * The time at which the purchase was cancelled/refunded/charged-back, in
   * milliseconds since the epoch (Jan 1, 1970).
   */
  core.String voidedTimeMillis;

  VoidedPurchase();

  VoidedPurchase.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("purchaseTimeMillis")) {
      purchaseTimeMillis = _json["purchaseTimeMillis"];
    }
    if (_json.containsKey("purchaseToken")) {
      purchaseToken = _json["purchaseToken"];
    }
    if (_json.containsKey("voidedTimeMillis")) {
      voidedTimeMillis = _json["voidedTimeMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (purchaseTimeMillis != null) {
      _json["purchaseTimeMillis"] = purchaseTimeMillis;
    }
    if (purchaseToken != null) {
      _json["purchaseToken"] = purchaseToken;
    }
    if (voidedTimeMillis != null) {
      _json["voidedTimeMillis"] = voidedTimeMillis;
    }
    return _json;
  }
}

class VoidedPurchasesListResponse {
  PageInfo pageInfo;
  TokenPagination tokenPagination;
  core.List<VoidedPurchase> voidedPurchases;

  VoidedPurchasesListResponse();

  VoidedPurchasesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("voidedPurchases")) {
      voidedPurchases = _json["voidedPurchases"].map((value) => new VoidedPurchase.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (voidedPurchases != null) {
      _json["voidedPurchases"] = voidedPurchases.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
