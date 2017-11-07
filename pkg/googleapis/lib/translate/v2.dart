// This is a generated file (see the discoveryapis_generator project).

library googleapis.translate.v2;

import 'dart:core' as core;
import 'dart:collection' as collection;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client translate/v2';

/** Translates text from one language to another. */
class TranslateApi {

  final commons.ApiRequester _requester;

  DetectionsResourceApi get detections => new DetectionsResourceApi(_requester);
  LanguagesResourceApi get languages => new LanguagesResourceApi(_requester);
  TranslationsResourceApi get translations => new TranslationsResourceApi(_requester);

  TranslateApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "language/translate/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class DetectionsResourceApi {
  final commons.ApiRequester _requester;

  DetectionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Detect the language of text.
   *
   * Request parameters:
   *
   * [q] - The text to detect
   *
   * Completes with a [DetectionsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DetectionsListResponse> list(core.List<core.String> q) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (q == null || q.isEmpty) {
      throw new core.ArgumentError("Parameter q is required.");
    }
    _queryParams["q"] = q;

    _url = 'v2/detect';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DetectionsListResponse.fromJson(data));
  }

}


class LanguagesResourceApi {
  final commons.ApiRequester _requester;

  LanguagesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List the source/target languages supported by the API
   *
   * Request parameters:
   *
   * [target] - the language and collation in which the localized results should
   * be returned
   *
   * Completes with a [LanguagesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LanguagesListResponse> list({core.String target}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (target != null) {
      _queryParams["target"] = [target];
    }

    _url = 'v2/languages';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LanguagesListResponse.fromJson(data));
  }

}


class TranslationsResourceApi {
  final commons.ApiRequester _requester;

  TranslationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns text translations from one language to another.
   *
   * Request parameters:
   *
   * [q] - The text to translate
   *
   * [target] - The target language into which the text should be translated
   *
   * [cid] - The customization id for translate
   *
   * [format] - The format of the text
   * Possible string values are:
   * - "html" : Specifies the input is in HTML
   * - "text" : Specifies the input is in plain textual format
   *
   * [source] - The source language of the text
   *
   * Completes with a [TranslationsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TranslationsListResponse> list(core.List<core.String> q, core.String target, {core.List<core.String> cid, core.String format, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (q == null || q.isEmpty) {
      throw new core.ArgumentError("Parameter q is required.");
    }
    _queryParams["q"] = q;
    if (target == null) {
      throw new core.ArgumentError("Parameter target is required.");
    }
    _queryParams["target"] = [target];
    if (cid != null) {
      _queryParams["cid"] = cid;
    }
    if (format != null) {
      _queryParams["format"] = [format];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'v2';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TranslationsListResponse.fromJson(data));
  }

}



class DetectionsListResponse {
  /** A detections contains detection results of several text */
  core.List<DetectionsResource> detections;

  DetectionsListResponse();

  DetectionsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("detections")) {
      detections = _json["detections"].map((value) => new DetectionsResource.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (detections != null) {
      _json["detections"] = detections.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class DetectionsResourceElement {
  /** The confidence of the detection resul of this language. */
  core.double confidence;
  /** A boolean to indicate is the language detection result reliable. */
  core.bool isReliable;
  /** The language we detect */
  core.String language;

  DetectionsResourceElement();

  DetectionsResourceElement.fromJson(core.Map _json) {
    if (_json.containsKey("confidence")) {
      confidence = _json["confidence"];
    }
    if (_json.containsKey("isReliable")) {
      isReliable = _json["isReliable"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (confidence != null) {
      _json["confidence"] = confidence;
    }
    if (isReliable != null) {
      _json["isReliable"] = isReliable;
    }
    if (language != null) {
      _json["language"] = language;
    }
    return _json;
  }
}

/**
 * An array of languages which we detect for the given text The most likely
 * language list first.
 */
class DetectionsResource
    extends collection.ListBase<DetectionsResourceElement> {
  final core.List<DetectionsResourceElement> _inner;

  DetectionsResource() : _inner = [];

  DetectionsResource.fromJson(core.List json)
      : _inner = json.map((value) => new DetectionsResourceElement.fromJson(value)).toList();

  core.List toJson() {
    return _inner.map((value) => (value).toJson()).toList();
  }

  DetectionsResourceElement operator [](core.int key) => _inner[key];

  void operator []=(core.int key, DetectionsResourceElement value) {
    _inner[key] = value;
  }

  core.int get length => _inner.length;

  void set length(core.int newLength) {
    _inner.length = newLength;
  }
}

class LanguagesListResponse {
  /**
   * List of source/target languages supported by the translation API. If target
   * parameter is unspecified, the list is sorted by the ASCII code point order
   * of the language code. If target parameter is specified, the list is sorted
   * by the collation order of the language name in the target language.
   */
  core.List<LanguagesResource> languages;

  LanguagesListResponse();

  LanguagesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("languages")) {
      languages = _json["languages"].map((value) => new LanguagesResource.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (languages != null) {
      _json["languages"] = languages.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class LanguagesResource {
  /** The language code. */
  core.String language;
  /** The localized name of the language if target parameter is given. */
  core.String name;

  LanguagesResource();

  LanguagesResource.fromJson(core.Map _json) {
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (language != null) {
      _json["language"] = language;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

class TranslationsListResponse {
  /** Translations contains list of translation results of given text */
  core.List<TranslationsResource> translations;

  TranslationsListResponse();

  TranslationsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("translations")) {
      translations = _json["translations"].map((value) => new TranslationsResource.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (translations != null) {
      _json["translations"] = translations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class TranslationsResource {
  /** Detected source language if source parameter is unspecified. */
  core.String detectedSourceLanguage;
  /** The translation. */
  core.String translatedText;

  TranslationsResource();

  TranslationsResource.fromJson(core.Map _json) {
    if (_json.containsKey("detectedSourceLanguage")) {
      detectedSourceLanguage = _json["detectedSourceLanguage"];
    }
    if (_json.containsKey("translatedText")) {
      translatedText = _json["translatedText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (detectedSourceLanguage != null) {
      _json["detectedSourceLanguage"] = detectedSourceLanguage;
    }
    if (translatedText != null) {
      _json["translatedText"] = translatedText;
    }
    return _json;
  }
}
