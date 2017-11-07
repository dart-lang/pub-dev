// This is a generated file (see the discoveryapis_generator project).

library googleapis.pagespeedonline.v2;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client pagespeedonline/v2';

/**
 * Analyzes the performance of a web page and provides tailored suggestions to
 * make that page faster.
 */
class PagespeedonlineApi {

  final commons.ApiRequester _requester;

  PagespeedapiResourceApi get pagespeedapi => new PagespeedapiResourceApi(_requester);

  PagespeedonlineApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "pagespeedonline/v2/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class PagespeedapiResourceApi {
  final commons.ApiRequester _requester;

  PagespeedapiResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Runs PageSpeed analysis on the page at the specified URL, and returns
   * PageSpeed scores, a list of suggestions to make that page faster, and other
   * information.
   *
   * Request parameters:
   *
   * [url] - The URL to fetch and analyze
   * Value must have pattern "(?i)http(s)?://.*".
   *
   * [filterThirdPartyResources] - Indicates if third party resources should be
   * filtered out before PageSpeed analysis.
   *
   * [locale] - The locale used to localize formatted results
   * Value must have pattern "[a-zA-Z]+(_[a-zA-Z]+)?".
   *
   * [rule] - A PageSpeed rule to run; if none are given, all rules are run
   * Value must have pattern "[a-zA-Z]+".
   *
   * [screenshot] - Indicates if binary data containing a screenshot should be
   * included
   *
   * [strategy] - The analysis strategy to use
   * Possible string values are:
   * - "desktop" : Fetch and analyze the URL for desktop browsers
   * - "mobile" : Fetch and analyze the URL for mobile devices
   *
   * Completes with a [Result].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Result> runpagespeed(core.String url, {core.bool filterThirdPartyResources, core.String locale, core.List<core.String> rule, core.bool screenshot, core.String strategy}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (url == null) {
      throw new core.ArgumentError("Parameter url is required.");
    }
    _queryParams["url"] = [url];
    if (filterThirdPartyResources != null) {
      _queryParams["filter_third_party_resources"] = ["${filterThirdPartyResources}"];
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (rule != null) {
      _queryParams["rule"] = rule;
    }
    if (screenshot != null) {
      _queryParams["screenshot"] = ["${screenshot}"];
    }
    if (strategy != null) {
      _queryParams["strategy"] = [strategy];
    }

    _url = 'runPagespeed';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Result.fromJson(data));
  }

}



class PagespeedApiFormatStringV2ArgsRects {
  /** The height of the rect. */
  core.int height;
  /** The left coordinate of the rect, in page coordinates. */
  core.int left;
  /** The top coordinate of the rect, in page coordinates. */
  core.int top;
  /** The width of the rect. */
  core.int width;

  PagespeedApiFormatStringV2ArgsRects();

  PagespeedApiFormatStringV2ArgsRects.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("left")) {
      left = _json["left"];
    }
    if (_json.containsKey("top")) {
      top = _json["top"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (height != null) {
      _json["height"] = height;
    }
    if (left != null) {
      _json["left"] = left;
    }
    if (top != null) {
      _json["top"] = top;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

class PagespeedApiFormatStringV2ArgsSecondaryRects {
  /** The height of the rect. */
  core.int height;
  /** The left coordinate of the rect, in page coordinates. */
  core.int left;
  /** The top coordinate of the rect, in page coordinates. */
  core.int top;
  /** The width of the rect. */
  core.int width;

  PagespeedApiFormatStringV2ArgsSecondaryRects();

  PagespeedApiFormatStringV2ArgsSecondaryRects.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("left")) {
      left = _json["left"];
    }
    if (_json.containsKey("top")) {
      top = _json["top"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (height != null) {
      _json["height"] = height;
    }
    if (left != null) {
      _json["left"] = left;
    }
    if (top != null) {
      _json["top"] = top;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

class PagespeedApiFormatStringV2Args {
  /** The placeholder key for this arg, as a string. */
  core.String key;
  /**
   * The screen rectangles being referred to, with dimensions measured in CSS
   * pixels. This is only ever used for SNAPSHOT_RECT arguments. If this is
   * absent for a SNAPSHOT_RECT argument, it means that that argument refers to
   * the entire snapshot.
   */
  core.List<PagespeedApiFormatStringV2ArgsRects> rects;
  /**
   * Secondary screen rectangles being referred to, with dimensions measured in
   * CSS pixels. This is only ever used for SNAPSHOT_RECT arguments.
   */
  core.List<PagespeedApiFormatStringV2ArgsSecondaryRects> secondaryRects;
  /**
   * Type of argument. One of URL, STRING_LITERAL, INT_LITERAL, BYTES, DURATION,
   * VERBATIM_STRING, PERCENTAGE, HYPERLINK, or SNAPSHOT_RECT.
   */
  core.String type;
  /** Argument value, as a localized string. */
  core.String value;

  PagespeedApiFormatStringV2Args();

  PagespeedApiFormatStringV2Args.fromJson(core.Map _json) {
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("rects")) {
      rects = _json["rects"].map((value) => new PagespeedApiFormatStringV2ArgsRects.fromJson(value)).toList();
    }
    if (_json.containsKey("secondary_rects")) {
      secondaryRects = _json["secondary_rects"].map((value) => new PagespeedApiFormatStringV2ArgsSecondaryRects.fromJson(value)).toList();
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (key != null) {
      _json["key"] = key;
    }
    if (rects != null) {
      _json["rects"] = rects.map((value) => (value).toJson()).toList();
    }
    if (secondaryRects != null) {
      _json["secondary_rects"] = secondaryRects.map((value) => (value).toJson()).toList();
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class PagespeedApiFormatStringV2 {
  /** List of arguments for the format string. */
  core.List<PagespeedApiFormatStringV2Args> args;
  /**
   * A localized format string with {{FOO}} placeholders, where 'FOO' is the key
   * of the argument whose value should be substituted. For HYPERLINK arguments,
   * the format string will instead contain {{BEGIN_FOO}} and {{END_FOO}} for
   * the argument with key 'FOO'.
   */
  core.String format;

  PagespeedApiFormatStringV2();

  PagespeedApiFormatStringV2.fromJson(core.Map _json) {
    if (_json.containsKey("args")) {
      args = _json["args"].map((value) => new PagespeedApiFormatStringV2Args.fromJson(value)).toList();
    }
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (args != null) {
      _json["args"] = args.map((value) => (value).toJson()).toList();
    }
    if (format != null) {
      _json["format"] = format;
    }
    return _json;
  }
}

/**
 * The region of the page that is captured by this image, with dimensions
 * measured in CSS pixels.
 */
class PagespeedApiImageV2PageRect {
  /** The height of the rect. */
  core.int height;
  /** The left coordinate of the rect, in page coordinates. */
  core.int left;
  /** The top coordinate of the rect, in page coordinates. */
  core.int top;
  /** The width of the rect. */
  core.int width;

  PagespeedApiImageV2PageRect();

  PagespeedApiImageV2PageRect.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("left")) {
      left = _json["left"];
    }
    if (_json.containsKey("top")) {
      top = _json["top"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (height != null) {
      _json["height"] = height;
    }
    if (left != null) {
      _json["left"] = left;
    }
    if (top != null) {
      _json["top"] = top;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

class PagespeedApiImageV2 {
  /** Image data base64 encoded. */
  core.String data;
  core.List<core.int> get dataAsBytes {
    return convert.BASE64.decode(data);
  }

  void set dataAsBytes(core.List<core.int> _bytes) {
    data = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** Height of screenshot in pixels. */
  core.int height;
  /** Unique string key, if any, identifying this image. */
  core.String key;
  /** Mime type of image data (e.g. "image/jpeg"). */
  core.String mimeType;
  /**
   * The region of the page that is captured by this image, with dimensions
   * measured in CSS pixels.
   */
  PagespeedApiImageV2PageRect pageRect;
  /** Width of screenshot in pixels. */
  core.int width;

  PagespeedApiImageV2();

  PagespeedApiImageV2.fromJson(core.Map _json) {
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("mime_type")) {
      mimeType = _json["mime_type"];
    }
    if (_json.containsKey("page_rect")) {
      pageRect = new PagespeedApiImageV2PageRect.fromJson(_json["page_rect"]);
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (data != null) {
      _json["data"] = data;
    }
    if (height != null) {
      _json["height"] = height;
    }
    if (key != null) {
      _json["key"] = key;
    }
    if (mimeType != null) {
      _json["mime_type"] = mimeType;
    }
    if (pageRect != null) {
      _json["page_rect"] = (pageRect).toJson();
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

class ResultFormattedResultsRuleResultsValueUrlBlocksUrls {
  /**
   * List of entries that provide additional details about a single URL.
   * Optional.
   */
  core.List<PagespeedApiFormatStringV2> details;
  /**
   * A format string that gives information about the URL, and a list of
   * arguments for that format string.
   */
  PagespeedApiFormatStringV2 result;

  ResultFormattedResultsRuleResultsValueUrlBlocksUrls();

  ResultFormattedResultsRuleResultsValueUrlBlocksUrls.fromJson(core.Map _json) {
    if (_json.containsKey("details")) {
      details = _json["details"].map((value) => new PagespeedApiFormatStringV2.fromJson(value)).toList();
    }
    if (_json.containsKey("result")) {
      result = new PagespeedApiFormatStringV2.fromJson(_json["result"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (details != null) {
      _json["details"] = details.map((value) => (value).toJson()).toList();
    }
    if (result != null) {
      _json["result"] = (result).toJson();
    }
    return _json;
  }
}

class ResultFormattedResultsRuleResultsValueUrlBlocks {
  /** Heading to be displayed with the list of URLs. */
  PagespeedApiFormatStringV2 header;
  /**
   * List of entries that provide information about URLs in the url block.
   * Optional.
   */
  core.List<ResultFormattedResultsRuleResultsValueUrlBlocksUrls> urls;

  ResultFormattedResultsRuleResultsValueUrlBlocks();

  ResultFormattedResultsRuleResultsValueUrlBlocks.fromJson(core.Map _json) {
    if (_json.containsKey("header")) {
      header = new PagespeedApiFormatStringV2.fromJson(_json["header"]);
    }
    if (_json.containsKey("urls")) {
      urls = _json["urls"].map((value) => new ResultFormattedResultsRuleResultsValueUrlBlocksUrls.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (header != null) {
      _json["header"] = (header).toJson();
    }
    if (urls != null) {
      _json["urls"] = urls.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * The enum-like identifier for this rule. For instance "EnableKeepAlive" or
 * "AvoidCssImport". Not localized.
 */
class ResultFormattedResultsRuleResultsValue {
  /**
   * List of rule groups that this rule belongs to. Each entry in the list is
   * one of "SPEED" or "USABILITY".
   */
  core.List<core.String> groups;
  /** Localized name of the rule, intended for presentation to a user. */
  core.String localizedRuleName;
  /**
   * The impact (unbounded floating point value) that implementing the
   * suggestions for this rule would have on making the page faster. Impact is
   * comparable between rules to determine which rule's suggestions would have a
   * higher or lower impact on making a page faster. For instance, if enabling
   * compression would save 1MB, while optimizing images would save 500kB, the
   * enable compression rule would have 2x the impact of the image optimization
   * rule, all other things being equal.
   */
  core.double ruleImpact;
  /**
   * A brief summary description for the rule, indicating at a high level what
   * should be done to follow the rule and what benefit can be gained by doing
   * so.
   */
  PagespeedApiFormatStringV2 summary;
  /**
   * List of blocks of URLs. Each block may contain a heading and a list of
   * URLs. Each URL may optionally include additional details.
   */
  core.List<ResultFormattedResultsRuleResultsValueUrlBlocks> urlBlocks;

  ResultFormattedResultsRuleResultsValue();

  ResultFormattedResultsRuleResultsValue.fromJson(core.Map _json) {
    if (_json.containsKey("groups")) {
      groups = _json["groups"];
    }
    if (_json.containsKey("localizedRuleName")) {
      localizedRuleName = _json["localizedRuleName"];
    }
    if (_json.containsKey("ruleImpact")) {
      ruleImpact = _json["ruleImpact"];
    }
    if (_json.containsKey("summary")) {
      summary = new PagespeedApiFormatStringV2.fromJson(_json["summary"]);
    }
    if (_json.containsKey("urlBlocks")) {
      urlBlocks = _json["urlBlocks"].map((value) => new ResultFormattedResultsRuleResultsValueUrlBlocks.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (groups != null) {
      _json["groups"] = groups;
    }
    if (localizedRuleName != null) {
      _json["localizedRuleName"] = localizedRuleName;
    }
    if (ruleImpact != null) {
      _json["ruleImpact"] = ruleImpact;
    }
    if (summary != null) {
      _json["summary"] = (summary).toJson();
    }
    if (urlBlocks != null) {
      _json["urlBlocks"] = urlBlocks.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Localized PageSpeed results. Contains a ruleResults entry for each PageSpeed
 * rule instantiated and run by the server.
 */
class ResultFormattedResults {
  /** The locale of the formattedResults, e.g. "en_US". */
  core.String locale;
  /**
   * Dictionary of formatted rule results, with one entry for each PageSpeed
   * rule instantiated and run by the server.
   */
  core.Map<core.String, ResultFormattedResultsRuleResultsValue> ruleResults;

  ResultFormattedResults();

  ResultFormattedResults.fromJson(core.Map _json) {
    if (_json.containsKey("locale")) {
      locale = _json["locale"];
    }
    if (_json.containsKey("ruleResults")) {
      ruleResults = commons.mapMap(_json["ruleResults"], (item) => new ResultFormattedResultsRuleResultsValue.fromJson(item));
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (locale != null) {
      _json["locale"] = locale;
    }
    if (ruleResults != null) {
      _json["ruleResults"] = commons.mapMap(ruleResults, (item) => (item).toJson());
    }
    return _json;
  }
}

/**
 * Summary statistics for the page, such as number of JavaScript bytes, number
 * of HTML bytes, etc.
 */
class ResultPageStats {
  /** Number of uncompressed response bytes for CSS resources on the page. */
  core.String cssResponseBytes;
  /** Number of response bytes for flash resources on the page. */
  core.String flashResponseBytes;
  /**
   * Number of uncompressed response bytes for the main HTML document and all
   * iframes on the page.
   */
  core.String htmlResponseBytes;
  /** Number of response bytes for image resources on the page. */
  core.String imageResponseBytes;
  /** Number of uncompressed response bytes for JS resources on the page. */
  core.String javascriptResponseBytes;
  /** Number of CSS resources referenced by the page. */
  core.int numberCssResources;
  /** Number of unique hosts referenced by the page. */
  core.int numberHosts;
  /** Number of JavaScript resources referenced by the page. */
  core.int numberJsResources;
  /** Number of HTTP resources loaded by the page. */
  core.int numberResources;
  /** Number of static (i.e. cacheable) resources on the page. */
  core.int numberStaticResources;
  /** Number of response bytes for other resources on the page. */
  core.String otherResponseBytes;
  /**
   * Number of uncompressed response bytes for text resources not covered by
   * other statistics (i.e non-HTML, non-script, non-CSS resources) on the page.
   */
  core.String textResponseBytes;
  /** Total size of all request bytes sent by the page. */
  core.String totalRequestBytes;

  ResultPageStats();

  ResultPageStats.fromJson(core.Map _json) {
    if (_json.containsKey("cssResponseBytes")) {
      cssResponseBytes = _json["cssResponseBytes"];
    }
    if (_json.containsKey("flashResponseBytes")) {
      flashResponseBytes = _json["flashResponseBytes"];
    }
    if (_json.containsKey("htmlResponseBytes")) {
      htmlResponseBytes = _json["htmlResponseBytes"];
    }
    if (_json.containsKey("imageResponseBytes")) {
      imageResponseBytes = _json["imageResponseBytes"];
    }
    if (_json.containsKey("javascriptResponseBytes")) {
      javascriptResponseBytes = _json["javascriptResponseBytes"];
    }
    if (_json.containsKey("numberCssResources")) {
      numberCssResources = _json["numberCssResources"];
    }
    if (_json.containsKey("numberHosts")) {
      numberHosts = _json["numberHosts"];
    }
    if (_json.containsKey("numberJsResources")) {
      numberJsResources = _json["numberJsResources"];
    }
    if (_json.containsKey("numberResources")) {
      numberResources = _json["numberResources"];
    }
    if (_json.containsKey("numberStaticResources")) {
      numberStaticResources = _json["numberStaticResources"];
    }
    if (_json.containsKey("otherResponseBytes")) {
      otherResponseBytes = _json["otherResponseBytes"];
    }
    if (_json.containsKey("textResponseBytes")) {
      textResponseBytes = _json["textResponseBytes"];
    }
    if (_json.containsKey("totalRequestBytes")) {
      totalRequestBytes = _json["totalRequestBytes"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cssResponseBytes != null) {
      _json["cssResponseBytes"] = cssResponseBytes;
    }
    if (flashResponseBytes != null) {
      _json["flashResponseBytes"] = flashResponseBytes;
    }
    if (htmlResponseBytes != null) {
      _json["htmlResponseBytes"] = htmlResponseBytes;
    }
    if (imageResponseBytes != null) {
      _json["imageResponseBytes"] = imageResponseBytes;
    }
    if (javascriptResponseBytes != null) {
      _json["javascriptResponseBytes"] = javascriptResponseBytes;
    }
    if (numberCssResources != null) {
      _json["numberCssResources"] = numberCssResources;
    }
    if (numberHosts != null) {
      _json["numberHosts"] = numberHosts;
    }
    if (numberJsResources != null) {
      _json["numberJsResources"] = numberJsResources;
    }
    if (numberResources != null) {
      _json["numberResources"] = numberResources;
    }
    if (numberStaticResources != null) {
      _json["numberStaticResources"] = numberStaticResources;
    }
    if (otherResponseBytes != null) {
      _json["otherResponseBytes"] = otherResponseBytes;
    }
    if (textResponseBytes != null) {
      _json["textResponseBytes"] = textResponseBytes;
    }
    if (totalRequestBytes != null) {
      _json["totalRequestBytes"] = totalRequestBytes;
    }
    return _json;
  }
}

/** The name of this rule group: one of "SPEED" or "USABILITY". */
class ResultRuleGroupsValue {
  /**
   * The score (0-100) for this rule group, which indicates how much better a
   * page could be in that category (e.g. how much faster, or how much more
   * usable). A high score indicates little room for improvement, while a lower
   * score indicates more room for improvement.
   */
  core.int score;

  ResultRuleGroupsValue();

  ResultRuleGroupsValue.fromJson(core.Map _json) {
    if (_json.containsKey("score")) {
      score = _json["score"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (score != null) {
      _json["score"] = score;
    }
    return _json;
  }
}

/** The version of PageSpeed used to generate these results. */
class ResultVersion {
  /** The major version number of PageSpeed used to generate these results. */
  core.int major;
  /** The minor version number of PageSpeed used to generate these results. */
  core.int minor;

  ResultVersion();

  ResultVersion.fromJson(core.Map _json) {
    if (_json.containsKey("major")) {
      major = _json["major"];
    }
    if (_json.containsKey("minor")) {
      minor = _json["minor"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (major != null) {
      _json["major"] = major;
    }
    if (minor != null) {
      _json["minor"] = minor;
    }
    return _json;
  }
}

class Result {
  /**
   * Localized PageSpeed results. Contains a ruleResults entry for each
   * PageSpeed rule instantiated and run by the server.
   */
  ResultFormattedResults formattedResults;
  /**
   * Canonicalized and final URL for the document, after following page
   * redirects (if any).
   */
  core.String id;
  /**
   * List of rules that were specified in the request, but which the server did
   * not know how to instantiate.
   */
  core.List<core.String> invalidRules;
  /** Kind of result. */
  core.String kind;
  /**
   * Summary statistics for the page, such as number of JavaScript bytes, number
   * of HTML bytes, etc.
   */
  ResultPageStats pageStats;
  /**
   * Response code for the document. 200 indicates a normal page load. 4xx/5xx
   * indicates an error.
   */
  core.int responseCode;
  /** A map with one entry for each rule group in these results. */
  core.Map<core.String, ResultRuleGroupsValue> ruleGroups;
  /** Base64-encoded screenshot of the page that was analyzed. */
  PagespeedApiImageV2 screenshot;
  /** Title of the page, as displayed in the browser's title bar. */
  core.String title;
  /** The version of PageSpeed used to generate these results. */
  ResultVersion version;

  Result();

  Result.fromJson(core.Map _json) {
    if (_json.containsKey("formattedResults")) {
      formattedResults = new ResultFormattedResults.fromJson(_json["formattedResults"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("invalidRules")) {
      invalidRules = _json["invalidRules"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("pageStats")) {
      pageStats = new ResultPageStats.fromJson(_json["pageStats"]);
    }
    if (_json.containsKey("responseCode")) {
      responseCode = _json["responseCode"];
    }
    if (_json.containsKey("ruleGroups")) {
      ruleGroups = commons.mapMap(_json["ruleGroups"], (item) => new ResultRuleGroupsValue.fromJson(item));
    }
    if (_json.containsKey("screenshot")) {
      screenshot = new PagespeedApiImageV2.fromJson(_json["screenshot"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("version")) {
      version = new ResultVersion.fromJson(_json["version"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formattedResults != null) {
      _json["formattedResults"] = (formattedResults).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (invalidRules != null) {
      _json["invalidRules"] = invalidRules;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (pageStats != null) {
      _json["pageStats"] = (pageStats).toJson();
    }
    if (responseCode != null) {
      _json["responseCode"] = responseCode;
    }
    if (ruleGroups != null) {
      _json["ruleGroups"] = commons.mapMap(ruleGroups, (item) => (item).toJson());
    }
    if (screenshot != null) {
      _json["screenshot"] = (screenshot).toJson();
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (version != null) {
      _json["version"] = (version).toJson();
    }
    return _json;
  }
}
