// This is a generated file (see the discoveryapis_generator project).

library googleapis.firebasedynamiclinks.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client firebasedynamiclinks/v1';

/**
 * Firebase Dynamic Links API enables third party developers to programmatically
 * create and manage Dynamic Links.
 */
class FirebasedynamiclinksApi {
  /** View and administer all your Firebase data and settings */
  static const FirebaseScope = "https://www.googleapis.com/auth/firebase";


  final commons.ApiRequester _requester;

  ShortLinksResourceApi get shortLinks => new ShortLinksResourceApi(_requester);

  FirebasedynamiclinksApi(http.Client client, {core.String rootUrl: "https://firebasedynamiclinks.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ShortLinksResourceApi {
  final commons.ApiRequester _requester;

  ShortLinksResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a short Dynamic Link given either a valid long Dynamic Link or
   * details such as Dynamic Link domain, Android and iOS app information.
   * The created short Dynamic Link will not expire.
   *
   * Repeated calls with the same long Dynamic Link or Dynamic Link information
   * will produce the same short Dynamic Link.
   *
   * The Dynamic Link domain in the request must be owned by requester's
   * Firebase project.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [CreateShortDynamicLinkResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreateShortDynamicLinkResponse> create(CreateShortDynamicLinkRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/shortLinks';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreateShortDynamicLinkResponse.fromJson(data));
  }

}



/** Tracking parameters supported by Dynamic Link. */
class AnalyticsInfo {
  /** Google Play Campaign Measurements. */
  GooglePlayAnalytics googlePlayAnalytics;
  /** iTunes Connect App Analytics. */
  ITunesConnectAnalytics itunesConnectAnalytics;

  AnalyticsInfo();

  AnalyticsInfo.fromJson(core.Map _json) {
    if (_json.containsKey("googlePlayAnalytics")) {
      googlePlayAnalytics = new GooglePlayAnalytics.fromJson(_json["googlePlayAnalytics"]);
    }
    if (_json.containsKey("itunesConnectAnalytics")) {
      itunesConnectAnalytics = new ITunesConnectAnalytics.fromJson(_json["itunesConnectAnalytics"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (googlePlayAnalytics != null) {
      _json["googlePlayAnalytics"] = (googlePlayAnalytics).toJson();
    }
    if (itunesConnectAnalytics != null) {
      _json["itunesConnectAnalytics"] = (itunesConnectAnalytics).toJson();
    }
    return _json;
  }
}

/** Android related attributes to the Dynamic Link. */
class AndroidInfo {
  /** Link to open on Android if the app is not installed. */
  core.String androidFallbackLink;
  /** If specified, this overrides the ‘link’ parameter on Android. */
  core.String androidLink;
  /**
   * Minimum version code for the Android app. If the installed app’s version
   * code is lower, then the user is taken to the Play Store.
   */
  core.String androidMinPackageVersionCode;
  /** Android package name of the app. */
  core.String androidPackageName;

  AndroidInfo();

  AndroidInfo.fromJson(core.Map _json) {
    if (_json.containsKey("androidFallbackLink")) {
      androidFallbackLink = _json["androidFallbackLink"];
    }
    if (_json.containsKey("androidLink")) {
      androidLink = _json["androidLink"];
    }
    if (_json.containsKey("androidMinPackageVersionCode")) {
      androidMinPackageVersionCode = _json["androidMinPackageVersionCode"];
    }
    if (_json.containsKey("androidPackageName")) {
      androidPackageName = _json["androidPackageName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (androidFallbackLink != null) {
      _json["androidFallbackLink"] = androidFallbackLink;
    }
    if (androidLink != null) {
      _json["androidLink"] = androidLink;
    }
    if (androidMinPackageVersionCode != null) {
      _json["androidMinPackageVersionCode"] = androidMinPackageVersionCode;
    }
    if (androidPackageName != null) {
      _json["androidPackageName"] = androidPackageName;
    }
    return _json;
  }
}

/** Request to create a short Dynamic Link. */
class CreateShortDynamicLinkRequest {
  /**
   * Information about the Dynamic Link to be shortened.
   * [Learn
   * more](https://firebase.google.com/docs/dynamic-links/android#create-a-dynamic-link-programmatically).
   */
  DynamicLinkInfo dynamicLinkInfo;
  /**
   * Full long Dynamic Link URL with desired query parameters specified.
   * For example,
   * "https://sample.app.goo.gl/?link=http://www.google.com&apn=com.sample",
   * [Learn
   * more](https://firebase.google.com/docs/dynamic-links/android#create-a-dynamic-link-programmatically).
   */
  core.String longDynamicLink;
  /** Short Dynamic Link suffix. Optional. */
  Suffix suffix;

  CreateShortDynamicLinkRequest();

  CreateShortDynamicLinkRequest.fromJson(core.Map _json) {
    if (_json.containsKey("dynamicLinkInfo")) {
      dynamicLinkInfo = new DynamicLinkInfo.fromJson(_json["dynamicLinkInfo"]);
    }
    if (_json.containsKey("longDynamicLink")) {
      longDynamicLink = _json["longDynamicLink"];
    }
    if (_json.containsKey("suffix")) {
      suffix = new Suffix.fromJson(_json["suffix"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dynamicLinkInfo != null) {
      _json["dynamicLinkInfo"] = (dynamicLinkInfo).toJson();
    }
    if (longDynamicLink != null) {
      _json["longDynamicLink"] = longDynamicLink;
    }
    if (suffix != null) {
      _json["suffix"] = (suffix).toJson();
    }
    return _json;
  }
}

/** Response to create a short Dynamic Link. */
class CreateShortDynamicLinkResponse {
  /** Preivew link to show the link flow chart. */
  core.String previewLink;
  /** Short Dynamic Link value. e.g. https://abcd.app.goo.gl/wxyz */
  core.String shortLink;
  /** Information about potential warnings on link creation. */
  core.List<DynamicLinkWarning> warning;

  CreateShortDynamicLinkResponse();

  CreateShortDynamicLinkResponse.fromJson(core.Map _json) {
    if (_json.containsKey("previewLink")) {
      previewLink = _json["previewLink"];
    }
    if (_json.containsKey("shortLink")) {
      shortLink = _json["shortLink"];
    }
    if (_json.containsKey("warning")) {
      warning = _json["warning"].map((value) => new DynamicLinkWarning.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (previewLink != null) {
      _json["previewLink"] = previewLink;
    }
    if (shortLink != null) {
      _json["shortLink"] = shortLink;
    }
    if (warning != null) {
      _json["warning"] = warning.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Information about a Dynamic Link. */
class DynamicLinkInfo {
  /**
   * Parameters used for tracking. See all tracking parameters in the
   * [documentation](https://firebase.google.com/docs/dynamic-links/android#create-a-dynamic-link-programmatically).
   */
  AnalyticsInfo analyticsInfo;
  /**
   * Android related information. See Android related parameters in the
   * [documentation](https://firebase.google.com/docs/dynamic-links/android#create-a-dynamic-link-programmatically).
   */
  AndroidInfo androidInfo;
  /**
   * Dynamic Links domain that the project owns, e.g. abcd.app.goo.gl
   * [Learn
   * more](https://firebase.google.com/docs/dynamic-links/android#set-up-firebase-and-the-dynamic-links-sdk)
   * on how to set up Dynamic Link domain associated with your Firebase project.
   *
   * Required.
   */
  core.String dynamicLinkDomain;
  /**
   * iOS related information. See iOS related parameters in the
   * [documentation](https://firebase.google.com/docs/dynamic-links/ios#create-a-dynamic-link-programmatically).
   */
  IosInfo iosInfo;
  /**
   * The link your app will open, You can specify any URL your app can handle.
   * This link must be a well-formatted URL, be properly URL-encoded, and use
   * the HTTP or HTTPS scheme. See 'link' parameters in the
   * [documentation](https://firebase.google.com/docs/dynamic-links/android#create-a-dynamic-link-programmatically).
   *
   * Required.
   */
  core.String link;
  /**
   * Parameters for social meta tag params.
   * Used to set meta tag data for link previews on social sites.
   */
  SocialMetaTagInfo socialMetaTagInfo;

  DynamicLinkInfo();

  DynamicLinkInfo.fromJson(core.Map _json) {
    if (_json.containsKey("analyticsInfo")) {
      analyticsInfo = new AnalyticsInfo.fromJson(_json["analyticsInfo"]);
    }
    if (_json.containsKey("androidInfo")) {
      androidInfo = new AndroidInfo.fromJson(_json["androidInfo"]);
    }
    if (_json.containsKey("dynamicLinkDomain")) {
      dynamicLinkDomain = _json["dynamicLinkDomain"];
    }
    if (_json.containsKey("iosInfo")) {
      iosInfo = new IosInfo.fromJson(_json["iosInfo"]);
    }
    if (_json.containsKey("link")) {
      link = _json["link"];
    }
    if (_json.containsKey("socialMetaTagInfo")) {
      socialMetaTagInfo = new SocialMetaTagInfo.fromJson(_json["socialMetaTagInfo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (analyticsInfo != null) {
      _json["analyticsInfo"] = (analyticsInfo).toJson();
    }
    if (androidInfo != null) {
      _json["androidInfo"] = (androidInfo).toJson();
    }
    if (dynamicLinkDomain != null) {
      _json["dynamicLinkDomain"] = dynamicLinkDomain;
    }
    if (iosInfo != null) {
      _json["iosInfo"] = (iosInfo).toJson();
    }
    if (link != null) {
      _json["link"] = link;
    }
    if (socialMetaTagInfo != null) {
      _json["socialMetaTagInfo"] = (socialMetaTagInfo).toJson();
    }
    return _json;
  }
}

/** Dynamic Links warning messages. */
class DynamicLinkWarning {
  /**
   * The warning code.
   * Possible string values are:
   * - "CODE_UNSPECIFIED" : Unknown code.
   * - "NOT_IN_PROJECT_ANDROID_PACKAGE_NAME" : The Android package does not
   * match any in developer's DevConsole project.
   * - "NOT_INTEGER_ANDROID_PACKAGE_MIN_VERSION" : The Android minimum version
   * code has to be a valid integer.
   * - "UNNECESSARY_ANDROID_PACKAGE_MIN_VERSION" : Android package min version
   * param is not needed, e.g. when
   * 'apn' is missing.
   * - "NOT_URI_ANDROID_LINK" : Android link is not a valid URI.
   * - "UNNECESSARY_ANDROID_LINK" : Android link param is not needed, e.g. when
   * param 'al' and 'link' have
   * the same value..
   * - "NOT_URI_ANDROID_FALLBACK_LINK" : Android fallback link is not a valid
   * URI.
   * - "BAD_URI_SCHEME_ANDROID_FALLBACK_LINK" : Android fallback link has an
   * invalid (non http/https) URI scheme.
   * - "NOT_IN_PROJECT_IOS_BUNDLE_ID" : The iOS bundle ID does not match any in
   * developer's DevConsole project.
   * - "NOT_IN_PROJECT_IPAD_BUNDLE_ID" : The iPad bundle ID does not match any
   * in developer's DevConsole project.
   * - "UNNECESSARY_IOS_URL_SCHEME" : iOS URL scheme is not needed, e.g. when
   * 'ibi' are 'ipbi' are all missing.
   * - "NOT_NUMERIC_IOS_APP_STORE_ID" : iOS app store ID format is incorrect,
   * e.g. not numeric.
   * - "UNNECESSARY_IOS_APP_STORE_ID" : iOS app store ID is not needed.
   * - "NOT_URI_IOS_FALLBACK_LINK" : iOS fallback link is not a valid URI.
   * - "BAD_URI_SCHEME_IOS_FALLBACK_LINK" : iOS fallback link has an invalid
   * (non http/https) URI scheme.
   * - "NOT_URI_IPAD_FALLBACK_LINK" : iPad fallback link is not a valid URI.
   * - "BAD_URI_SCHEME_IPAD_FALLBACK_LINK" : iPad fallback link has an invalid
   * (non http/https) URI scheme.
   * - "BAD_DEBUG_PARAM" : Debug param format is incorrect.
   * - "BAD_AD_PARAM" : isAd param format is incorrect.
   * - "DEPRECATED_PARAM" : Indicates a certain param is deprecated.
   * - "UNRECOGNIZED_PARAM" : Indicates certain paramater is not recognized.
   * - "TOO_LONG_PARAM" : Indicates certain paramater is too long.
   * - "NOT_URI_SOCIAL_IMAGE_LINK" : Social meta tag image link is not a valid
   * URI.
   * - "BAD_URI_SCHEME_SOCIAL_IMAGE_LINK" : Social meta tag image link has an
   * invalid (non http/https) URI scheme.
   * - "NOT_URI_SOCIAL_URL"
   * - "BAD_URI_SCHEME_SOCIAL_URL"
   * - "LINK_LENGTH_TOO_LONG" : Dynamic Link URL length is too long.
   * - "LINK_WITH_FRAGMENTS" : Dynamic Link URL contains fragments.
   * - "NOT_MATCHING_IOS_BUNDLE_ID_AND_STORE_ID" : The iOS bundle ID does not
   * match with the given iOS store ID.
   */
  core.String warningCode;
  /** The warning message to help developers improve their requests. */
  core.String warningMessage;

  DynamicLinkWarning();

  DynamicLinkWarning.fromJson(core.Map _json) {
    if (_json.containsKey("warningCode")) {
      warningCode = _json["warningCode"];
    }
    if (_json.containsKey("warningMessage")) {
      warningMessage = _json["warningMessage"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (warningCode != null) {
      _json["warningCode"] = warningCode;
    }
    if (warningMessage != null) {
      _json["warningMessage"] = warningMessage;
    }
    return _json;
  }
}

/**
 * Parameters for Google Play Campaign Measurements.
 * [Learn
 * more](https://developers.google.com/analytics/devguides/collection/android/v4/campaigns#campaign-params)
 */
class GooglePlayAnalytics {
  /**
   * [AdWords autotagging
   * parameter](https://support.google.com/analytics/answer/1033981?hl=en);
   * used to measure Google AdWords ads. This value is generated dynamically
   * and should never be modified.
   */
  core.String gclid;
  /**
   * Campaign name; used for keyword analysis to identify a specific product
   * promotion or strategic campaign.
   */
  core.String utmCampaign;
  /**
   * Campaign content; used for A/B testing and content-targeted ads to
   * differentiate ads or links that point to the same URL.
   */
  core.String utmContent;
  /**
   * Campaign medium; used to identify a medium such as email or cost-per-click.
   */
  core.String utmMedium;
  /**
   * Campaign source; used to identify a search engine, newsletter, or other
   * source.
   */
  core.String utmSource;
  /** Campaign term; used with paid search to supply the keywords for ads. */
  core.String utmTerm;

  GooglePlayAnalytics();

  GooglePlayAnalytics.fromJson(core.Map _json) {
    if (_json.containsKey("gclid")) {
      gclid = _json["gclid"];
    }
    if (_json.containsKey("utmCampaign")) {
      utmCampaign = _json["utmCampaign"];
    }
    if (_json.containsKey("utmContent")) {
      utmContent = _json["utmContent"];
    }
    if (_json.containsKey("utmMedium")) {
      utmMedium = _json["utmMedium"];
    }
    if (_json.containsKey("utmSource")) {
      utmSource = _json["utmSource"];
    }
    if (_json.containsKey("utmTerm")) {
      utmTerm = _json["utmTerm"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (gclid != null) {
      _json["gclid"] = gclid;
    }
    if (utmCampaign != null) {
      _json["utmCampaign"] = utmCampaign;
    }
    if (utmContent != null) {
      _json["utmContent"] = utmContent;
    }
    if (utmMedium != null) {
      _json["utmMedium"] = utmMedium;
    }
    if (utmSource != null) {
      _json["utmSource"] = utmSource;
    }
    if (utmTerm != null) {
      _json["utmTerm"] = utmTerm;
    }
    return _json;
  }
}

/** Parameters for iTunes Connect App Analytics. */
class ITunesConnectAnalytics {
  /** Affiliate token used to create affiliate-coded links. */
  core.String at;
  /**
   * Campaign text that developers can optionally add to any link in order to
   * track sales from a specific marketing campaign.
   */
  core.String ct;
  /** iTune media types, including music, podcasts, audiobooks and so on. */
  core.String mt;
  /**
   * Provider token that enables analytics for Dynamic Links from within iTunes
   * Connect.
   */
  core.String pt;

  ITunesConnectAnalytics();

  ITunesConnectAnalytics.fromJson(core.Map _json) {
    if (_json.containsKey("at")) {
      at = _json["at"];
    }
    if (_json.containsKey("ct")) {
      ct = _json["ct"];
    }
    if (_json.containsKey("mt")) {
      mt = _json["mt"];
    }
    if (_json.containsKey("pt")) {
      pt = _json["pt"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (at != null) {
      _json["at"] = at;
    }
    if (ct != null) {
      _json["ct"] = ct;
    }
    if (mt != null) {
      _json["mt"] = mt;
    }
    if (pt != null) {
      _json["pt"] = pt;
    }
    return _json;
  }
}

/** iOS related attributes to the Dynamic Link.. */
class IosInfo {
  /** iOS App Store ID. */
  core.String iosAppStoreId;
  /** iOS bundle ID of the app. */
  core.String iosBundleId;
  /**
   * Custom (destination) scheme to use for iOS. By default, we’ll use the
   * bundle ID as the custom scheme. Developer can override this behavior using
   * this param.
   */
  core.String iosCustomScheme;
  /** Link to open on iOS if the app is not installed. */
  core.String iosFallbackLink;
  /** iPad bundle ID of the app. */
  core.String iosIpadBundleId;
  /** If specified, this overrides the ios_fallback_link value on iPads. */
  core.String iosIpadFallbackLink;

  IosInfo();

  IosInfo.fromJson(core.Map _json) {
    if (_json.containsKey("iosAppStoreId")) {
      iosAppStoreId = _json["iosAppStoreId"];
    }
    if (_json.containsKey("iosBundleId")) {
      iosBundleId = _json["iosBundleId"];
    }
    if (_json.containsKey("iosCustomScheme")) {
      iosCustomScheme = _json["iosCustomScheme"];
    }
    if (_json.containsKey("iosFallbackLink")) {
      iosFallbackLink = _json["iosFallbackLink"];
    }
    if (_json.containsKey("iosIpadBundleId")) {
      iosIpadBundleId = _json["iosIpadBundleId"];
    }
    if (_json.containsKey("iosIpadFallbackLink")) {
      iosIpadFallbackLink = _json["iosIpadFallbackLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (iosAppStoreId != null) {
      _json["iosAppStoreId"] = iosAppStoreId;
    }
    if (iosBundleId != null) {
      _json["iosBundleId"] = iosBundleId;
    }
    if (iosCustomScheme != null) {
      _json["iosCustomScheme"] = iosCustomScheme;
    }
    if (iosFallbackLink != null) {
      _json["iosFallbackLink"] = iosFallbackLink;
    }
    if (iosIpadBundleId != null) {
      _json["iosIpadBundleId"] = iosIpadBundleId;
    }
    if (iosIpadFallbackLink != null) {
      _json["iosIpadFallbackLink"] = iosIpadFallbackLink;
    }
    return _json;
  }
}

/**
 * Parameters for social meta tag params.
 * Used to set meta tag data for link previews on social sites.
 */
class SocialMetaTagInfo {
  /** A short description of the link. Optional. */
  core.String socialDescription;
  /** An image url string. Optional. */
  core.String socialImageLink;
  /** Title to be displayed. Optional. */
  core.String socialTitle;

  SocialMetaTagInfo();

  SocialMetaTagInfo.fromJson(core.Map _json) {
    if (_json.containsKey("socialDescription")) {
      socialDescription = _json["socialDescription"];
    }
    if (_json.containsKey("socialImageLink")) {
      socialImageLink = _json["socialImageLink"];
    }
    if (_json.containsKey("socialTitle")) {
      socialTitle = _json["socialTitle"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (socialDescription != null) {
      _json["socialDescription"] = socialDescription;
    }
    if (socialImageLink != null) {
      _json["socialImageLink"] = socialImageLink;
    }
    if (socialTitle != null) {
      _json["socialTitle"] = socialTitle;
    }
    return _json;
  }
}

/** Short Dynamic Link suffix. */
class Suffix {
  /**
   * Suffix option.
   * Possible string values are:
   * - "OPTION_UNSPECIFIED" : The suffix option is not specified, performs as
   * NOT_GUESSABLE .
   * - "UNGUESSABLE" : Short Dynamic Link suffix is a base62 [0-9A-Za-z] encoded
   * string of
   * a random generated 96 bit random number, which has a length of 17 chars.
   * For example, "nlAR8U4SlKRZw1cb2".
   * It prevents other people from guessing and crawling short Dynamic Links
   * that contain personal identifiable information.
   * - "SHORT" : Short Dynamic Link suffix is a base62 [0-9A-Za-z] string
   * starting with a
   * length of 4 chars. the length will increase when all the space is
   * occupied.
   */
  core.String option;

  Suffix();

  Suffix.fromJson(core.Map _json) {
    if (_json.containsKey("option")) {
      option = _json["option"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (option != null) {
      _json["option"] = option;
    }
    return _json;
  }
}
