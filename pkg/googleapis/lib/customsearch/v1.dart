// This is a generated file (see the discoveryapis_generator project).

library googleapis.customsearch.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client customsearch/v1';

/** Lets you search over a website or collection of websites */
class CustomsearchApi {

  final commons.ApiRequester _requester;

  CseResourceApi get cse => new CseResourceApi(_requester);

  CustomsearchApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "customsearch/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class CseResourceApi {
  final commons.ApiRequester _requester;

  CseResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns metadata about the search performed, metadata about the custom
   * search engine used for the search, and the search results.
   *
   * Request parameters:
   *
   * [q] - Query
   *
   * [c2coff] - Turns off the translation between zh-CN and zh-TW.
   *
   * [cr] - Country restrict(s).
   *
   * [cref] - The URL of a linked custom search engine
   *
   * [cx] - The custom search engine ID to scope this search query
   *
   * [dateRestrict] - Specifies all search results are from a time period
   *
   * [exactTerms] - Identifies a phrase that all documents in the search results
   * must contain
   *
   * [excludeTerms] - Identifies a word or phrase that should not appear in any
   * documents in the search results
   *
   * [fileType] - Returns images of a specified type. Some of the allowed values
   * are: bmp, gif, png, jpg, svg, pdf, ...
   *
   * [filter] - Controls turning on or off the duplicate content filter.
   * Possible string values are:
   * - "0" : Turns off duplicate content filter.
   * - "1" : Turns on duplicate content filter.
   *
   * [gl] - Geolocation of end user.
   *
   * [googlehost] - The local Google domain to use to perform the search.
   *
   * [highRange] - Creates a range in form as_nlo value..as_nhi value and
   * attempts to append it to query
   *
   * [hl] - Sets the user interface language.
   *
   * [hq] - Appends the extra query terms to the query.
   *
   * [imgColorType] - Returns black and white, grayscale, or color images: mono,
   * gray, and color.
   * Possible string values are:
   * - "color" : color
   * - "gray" : gray
   * - "mono" : mono
   *
   * [imgDominantColor] - Returns images of a specific dominant color: yellow,
   * green, teal, blue, purple, pink, white, gray, black and brown.
   * Possible string values are:
   * - "black" : black
   * - "blue" : blue
   * - "brown" : brown
   * - "gray" : gray
   * - "green" : green
   * - "pink" : pink
   * - "purple" : purple
   * - "teal" : teal
   * - "white" : white
   * - "yellow" : yellow
   *
   * [imgSize] - Returns images of a specified size, where size can be one of:
   * icon, small, medium, large, xlarge, xxlarge, and huge.
   * Possible string values are:
   * - "huge" : huge
   * - "icon" : icon
   * - "large" : large
   * - "medium" : medium
   * - "small" : small
   * - "xlarge" : xlarge
   * - "xxlarge" : xxlarge
   *
   * [imgType] - Returns images of a type, which can be one of: clipart, face,
   * lineart, news, and photo.
   * Possible string values are:
   * - "clipart" : clipart
   * - "face" : face
   * - "lineart" : lineart
   * - "news" : news
   * - "photo" : photo
   *
   * [linkSite] - Specifies that all search results should contain a link to a
   * particular URL
   *
   * [lowRange] - Creates a range in form as_nlo value..as_nhi value and
   * attempts to append it to query
   *
   * [lr] - The language restriction for the search results
   * Possible string values are:
   * - "lang_ar" : Arabic
   * - "lang_bg" : Bulgarian
   * - "lang_ca" : Catalan
   * - "lang_cs" : Czech
   * - "lang_da" : Danish
   * - "lang_de" : German
   * - "lang_el" : Greek
   * - "lang_en" : English
   * - "lang_es" : Spanish
   * - "lang_et" : Estonian
   * - "lang_fi" : Finnish
   * - "lang_fr" : French
   * - "lang_hr" : Croatian
   * - "lang_hu" : Hungarian
   * - "lang_id" : Indonesian
   * - "lang_is" : Icelandic
   * - "lang_it" : Italian
   * - "lang_iw" : Hebrew
   * - "lang_ja" : Japanese
   * - "lang_ko" : Korean
   * - "lang_lt" : Lithuanian
   * - "lang_lv" : Latvian
   * - "lang_nl" : Dutch
   * - "lang_no" : Norwegian
   * - "lang_pl" : Polish
   * - "lang_pt" : Portuguese
   * - "lang_ro" : Romanian
   * - "lang_ru" : Russian
   * - "lang_sk" : Slovak
   * - "lang_sl" : Slovenian
   * - "lang_sr" : Serbian
   * - "lang_sv" : Swedish
   * - "lang_tr" : Turkish
   * - "lang_zh-CN" : Chinese (Simplified)
   * - "lang_zh-TW" : Chinese (Traditional)
   *
   * [num] - Number of search results to return
   *
   * [orTerms] - Provides additional search terms to check for in a document,
   * where each document in the search results must contain at least one of the
   * additional search terms
   *
   * [relatedSite] - Specifies that all search results should be pages that are
   * related to the specified URL
   *
   * [rights] - Filters based on licensing. Supported values include:
   * cc_publicdomain, cc_attribute, cc_sharealike, cc_noncommercial,
   * cc_nonderived and combinations of these.
   *
   * [safe] - Search safety level
   * Possible string values are:
   * - "high" : Enables highest level of safe search filtering.
   * - "medium" : Enables moderate safe search filtering.
   * - "off" : Disables safe search filtering.
   *
   * [searchType] - Specifies the search type: image.
   * Possible string values are:
   * - "image" : custom image search
   *
   * [siteSearch] - Specifies all search results should be pages from a given
   * site
   *
   * [siteSearchFilter] - Controls whether to include or exclude results from
   * the site named in the as_sitesearch parameter
   * Possible string values are:
   * - "e" : exclude
   * - "i" : include
   *
   * [sort] - The sort expression to apply to the results
   *
   * [start] - The index of the first result to return
   *
   * Completes with a [Search].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Search> list(core.String q, {core.String c2coff, core.String cr, core.String cref, core.String cx, core.String dateRestrict, core.String exactTerms, core.String excludeTerms, core.String fileType, core.String filter, core.String gl, core.String googlehost, core.String highRange, core.String hl, core.String hq, core.String imgColorType, core.String imgDominantColor, core.String imgSize, core.String imgType, core.String linkSite, core.String lowRange, core.String lr, core.int num, core.String orTerms, core.String relatedSite, core.String rights, core.String safe, core.String searchType, core.String siteSearch, core.String siteSearchFilter, core.String sort, core.int start}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (q == null) {
      throw new core.ArgumentError("Parameter q is required.");
    }
    _queryParams["q"] = [q];
    if (c2coff != null) {
      _queryParams["c2coff"] = [c2coff];
    }
    if (cr != null) {
      _queryParams["cr"] = [cr];
    }
    if (cref != null) {
      _queryParams["cref"] = [cref];
    }
    if (cx != null) {
      _queryParams["cx"] = [cx];
    }
    if (dateRestrict != null) {
      _queryParams["dateRestrict"] = [dateRestrict];
    }
    if (exactTerms != null) {
      _queryParams["exactTerms"] = [exactTerms];
    }
    if (excludeTerms != null) {
      _queryParams["excludeTerms"] = [excludeTerms];
    }
    if (fileType != null) {
      _queryParams["fileType"] = [fileType];
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (gl != null) {
      _queryParams["gl"] = [gl];
    }
    if (googlehost != null) {
      _queryParams["googlehost"] = [googlehost];
    }
    if (highRange != null) {
      _queryParams["highRange"] = [highRange];
    }
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }
    if (hq != null) {
      _queryParams["hq"] = [hq];
    }
    if (imgColorType != null) {
      _queryParams["imgColorType"] = [imgColorType];
    }
    if (imgDominantColor != null) {
      _queryParams["imgDominantColor"] = [imgDominantColor];
    }
    if (imgSize != null) {
      _queryParams["imgSize"] = [imgSize];
    }
    if (imgType != null) {
      _queryParams["imgType"] = [imgType];
    }
    if (linkSite != null) {
      _queryParams["linkSite"] = [linkSite];
    }
    if (lowRange != null) {
      _queryParams["lowRange"] = [lowRange];
    }
    if (lr != null) {
      _queryParams["lr"] = [lr];
    }
    if (num != null) {
      _queryParams["num"] = ["${num}"];
    }
    if (orTerms != null) {
      _queryParams["orTerms"] = [orTerms];
    }
    if (relatedSite != null) {
      _queryParams["relatedSite"] = [relatedSite];
    }
    if (rights != null) {
      _queryParams["rights"] = [rights];
    }
    if (safe != null) {
      _queryParams["safe"] = [safe];
    }
    if (searchType != null) {
      _queryParams["searchType"] = [searchType];
    }
    if (siteSearch != null) {
      _queryParams["siteSearch"] = [siteSearch];
    }
    if (siteSearchFilter != null) {
      _queryParams["siteSearchFilter"] = [siteSearchFilter];
    }
    if (sort != null) {
      _queryParams["sort"] = [sort];
    }
    if (start != null) {
      _queryParams["start"] = ["${start}"];
    }

    _url = 'v1';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Search.fromJson(data));
  }

}



class ContextFacets {
  core.String anchor;
  core.String label;
  core.String labelWithOp;

  ContextFacets();

  ContextFacets.fromJson(core.Map _json) {
    if (_json.containsKey("anchor")) {
      anchor = _json["anchor"];
    }
    if (_json.containsKey("label")) {
      label = _json["label"];
    }
    if (_json.containsKey("label_with_op")) {
      labelWithOp = _json["label_with_op"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (anchor != null) {
      _json["anchor"] = anchor;
    }
    if (label != null) {
      _json["label"] = label;
    }
    if (labelWithOp != null) {
      _json["label_with_op"] = labelWithOp;
    }
    return _json;
  }
}

class Context {
  core.List<core.List<ContextFacets>> facets;
  core.String title;

  Context();

  Context.fromJson(core.Map _json) {
    if (_json.containsKey("facets")) {
      facets = _json["facets"].map((value) => value.map((value) => new ContextFacets.fromJson(value)).toList()).toList();
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (facets != null) {
      _json["facets"] = facets.map((value) => value.map((value) => (value).toJson()).toList()).toList();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class PromotionBodyLines {
  core.String htmlTitle;
  core.String link;
  core.String title;
  core.String url;

  PromotionBodyLines();

  PromotionBodyLines.fromJson(core.Map _json) {
    if (_json.containsKey("htmlTitle")) {
      htmlTitle = _json["htmlTitle"];
    }
    if (_json.containsKey("link")) {
      link = _json["link"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (htmlTitle != null) {
      _json["htmlTitle"] = htmlTitle;
    }
    if (link != null) {
      _json["link"] = link;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class PromotionImage {
  core.int height;
  core.String source;
  core.int width;

  PromotionImage();

  PromotionImage.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("source")) {
      source = _json["source"];
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
    if (source != null) {
      _json["source"] = source;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

class Promotion {
  core.List<PromotionBodyLines> bodyLines;
  core.String displayLink;
  core.String htmlTitle;
  PromotionImage image;
  core.String link;
  core.String title;

  Promotion();

  Promotion.fromJson(core.Map _json) {
    if (_json.containsKey("bodyLines")) {
      bodyLines = _json["bodyLines"].map((value) => new PromotionBodyLines.fromJson(value)).toList();
    }
    if (_json.containsKey("displayLink")) {
      displayLink = _json["displayLink"];
    }
    if (_json.containsKey("htmlTitle")) {
      htmlTitle = _json["htmlTitle"];
    }
    if (_json.containsKey("image")) {
      image = new PromotionImage.fromJson(_json["image"]);
    }
    if (_json.containsKey("link")) {
      link = _json["link"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bodyLines != null) {
      _json["bodyLines"] = bodyLines.map((value) => (value).toJson()).toList();
    }
    if (displayLink != null) {
      _json["displayLink"] = displayLink;
    }
    if (htmlTitle != null) {
      _json["htmlTitle"] = htmlTitle;
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (link != null) {
      _json["link"] = link;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class Query {
  core.int count;
  core.String cr;
  core.String cref;
  core.String cx;
  core.String dateRestrict;
  core.String disableCnTwTranslation;
  core.String exactTerms;
  core.String excludeTerms;
  core.String fileType;
  core.String filter;
  core.String gl;
  core.String googleHost;
  core.String highRange;
  core.String hl;
  core.String hq;
  core.String imgColorType;
  core.String imgDominantColor;
  core.String imgSize;
  core.String imgType;
  core.String inputEncoding;
  core.String language;
  core.String linkSite;
  core.String lowRange;
  core.String orTerms;
  core.String outputEncoding;
  core.String relatedSite;
  core.String rights;
  core.String safe;
  core.String searchTerms;
  core.String searchType;
  core.String siteSearch;
  core.String siteSearchFilter;
  core.String sort;
  core.int startIndex;
  core.int startPage;
  core.String title;
  core.String totalResults;

  Query();

  Query.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("cr")) {
      cr = _json["cr"];
    }
    if (_json.containsKey("cref")) {
      cref = _json["cref"];
    }
    if (_json.containsKey("cx")) {
      cx = _json["cx"];
    }
    if (_json.containsKey("dateRestrict")) {
      dateRestrict = _json["dateRestrict"];
    }
    if (_json.containsKey("disableCnTwTranslation")) {
      disableCnTwTranslation = _json["disableCnTwTranslation"];
    }
    if (_json.containsKey("exactTerms")) {
      exactTerms = _json["exactTerms"];
    }
    if (_json.containsKey("excludeTerms")) {
      excludeTerms = _json["excludeTerms"];
    }
    if (_json.containsKey("fileType")) {
      fileType = _json["fileType"];
    }
    if (_json.containsKey("filter")) {
      filter = _json["filter"];
    }
    if (_json.containsKey("gl")) {
      gl = _json["gl"];
    }
    if (_json.containsKey("googleHost")) {
      googleHost = _json["googleHost"];
    }
    if (_json.containsKey("highRange")) {
      highRange = _json["highRange"];
    }
    if (_json.containsKey("hl")) {
      hl = _json["hl"];
    }
    if (_json.containsKey("hq")) {
      hq = _json["hq"];
    }
    if (_json.containsKey("imgColorType")) {
      imgColorType = _json["imgColorType"];
    }
    if (_json.containsKey("imgDominantColor")) {
      imgDominantColor = _json["imgDominantColor"];
    }
    if (_json.containsKey("imgSize")) {
      imgSize = _json["imgSize"];
    }
    if (_json.containsKey("imgType")) {
      imgType = _json["imgType"];
    }
    if (_json.containsKey("inputEncoding")) {
      inputEncoding = _json["inputEncoding"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("linkSite")) {
      linkSite = _json["linkSite"];
    }
    if (_json.containsKey("lowRange")) {
      lowRange = _json["lowRange"];
    }
    if (_json.containsKey("orTerms")) {
      orTerms = _json["orTerms"];
    }
    if (_json.containsKey("outputEncoding")) {
      outputEncoding = _json["outputEncoding"];
    }
    if (_json.containsKey("relatedSite")) {
      relatedSite = _json["relatedSite"];
    }
    if (_json.containsKey("rights")) {
      rights = _json["rights"];
    }
    if (_json.containsKey("safe")) {
      safe = _json["safe"];
    }
    if (_json.containsKey("searchTerms")) {
      searchTerms = _json["searchTerms"];
    }
    if (_json.containsKey("searchType")) {
      searchType = _json["searchType"];
    }
    if (_json.containsKey("siteSearch")) {
      siteSearch = _json["siteSearch"];
    }
    if (_json.containsKey("siteSearchFilter")) {
      siteSearchFilter = _json["siteSearchFilter"];
    }
    if (_json.containsKey("sort")) {
      sort = _json["sort"];
    }
    if (_json.containsKey("startIndex")) {
      startIndex = _json["startIndex"];
    }
    if (_json.containsKey("startPage")) {
      startPage = _json["startPage"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (count != null) {
      _json["count"] = count;
    }
    if (cr != null) {
      _json["cr"] = cr;
    }
    if (cref != null) {
      _json["cref"] = cref;
    }
    if (cx != null) {
      _json["cx"] = cx;
    }
    if (dateRestrict != null) {
      _json["dateRestrict"] = dateRestrict;
    }
    if (disableCnTwTranslation != null) {
      _json["disableCnTwTranslation"] = disableCnTwTranslation;
    }
    if (exactTerms != null) {
      _json["exactTerms"] = exactTerms;
    }
    if (excludeTerms != null) {
      _json["excludeTerms"] = excludeTerms;
    }
    if (fileType != null) {
      _json["fileType"] = fileType;
    }
    if (filter != null) {
      _json["filter"] = filter;
    }
    if (gl != null) {
      _json["gl"] = gl;
    }
    if (googleHost != null) {
      _json["googleHost"] = googleHost;
    }
    if (highRange != null) {
      _json["highRange"] = highRange;
    }
    if (hl != null) {
      _json["hl"] = hl;
    }
    if (hq != null) {
      _json["hq"] = hq;
    }
    if (imgColorType != null) {
      _json["imgColorType"] = imgColorType;
    }
    if (imgDominantColor != null) {
      _json["imgDominantColor"] = imgDominantColor;
    }
    if (imgSize != null) {
      _json["imgSize"] = imgSize;
    }
    if (imgType != null) {
      _json["imgType"] = imgType;
    }
    if (inputEncoding != null) {
      _json["inputEncoding"] = inputEncoding;
    }
    if (language != null) {
      _json["language"] = language;
    }
    if (linkSite != null) {
      _json["linkSite"] = linkSite;
    }
    if (lowRange != null) {
      _json["lowRange"] = lowRange;
    }
    if (orTerms != null) {
      _json["orTerms"] = orTerms;
    }
    if (outputEncoding != null) {
      _json["outputEncoding"] = outputEncoding;
    }
    if (relatedSite != null) {
      _json["relatedSite"] = relatedSite;
    }
    if (rights != null) {
      _json["rights"] = rights;
    }
    if (safe != null) {
      _json["safe"] = safe;
    }
    if (searchTerms != null) {
      _json["searchTerms"] = searchTerms;
    }
    if (searchType != null) {
      _json["searchType"] = searchType;
    }
    if (siteSearch != null) {
      _json["siteSearch"] = siteSearch;
    }
    if (siteSearchFilter != null) {
      _json["siteSearchFilter"] = siteSearchFilter;
    }
    if (sort != null) {
      _json["sort"] = sort;
    }
    if (startIndex != null) {
      _json["startIndex"] = startIndex;
    }
    if (startPage != null) {
      _json["startPage"] = startPage;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    return _json;
  }
}

class ResultImage {
  core.int byteSize;
  core.String contextLink;
  core.int height;
  core.int thumbnailHeight;
  core.String thumbnailLink;
  core.int thumbnailWidth;
  core.int width;

  ResultImage();

  ResultImage.fromJson(core.Map _json) {
    if (_json.containsKey("byteSize")) {
      byteSize = _json["byteSize"];
    }
    if (_json.containsKey("contextLink")) {
      contextLink = _json["contextLink"];
    }
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("thumbnailHeight")) {
      thumbnailHeight = _json["thumbnailHeight"];
    }
    if (_json.containsKey("thumbnailLink")) {
      thumbnailLink = _json["thumbnailLink"];
    }
    if (_json.containsKey("thumbnailWidth")) {
      thumbnailWidth = _json["thumbnailWidth"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (byteSize != null) {
      _json["byteSize"] = byteSize;
    }
    if (contextLink != null) {
      _json["contextLink"] = contextLink;
    }
    if (height != null) {
      _json["height"] = height;
    }
    if (thumbnailHeight != null) {
      _json["thumbnailHeight"] = thumbnailHeight;
    }
    if (thumbnailLink != null) {
      _json["thumbnailLink"] = thumbnailLink;
    }
    if (thumbnailWidth != null) {
      _json["thumbnailWidth"] = thumbnailWidth;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

class ResultLabels {
  core.String displayName;
  core.String labelWithOp;
  core.String name;

  ResultLabels();

  ResultLabels.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("label_with_op")) {
      labelWithOp = _json["label_with_op"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (labelWithOp != null) {
      _json["label_with_op"] = labelWithOp;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

class Result {
  core.String cacheId;
  core.String displayLink;
  core.String fileFormat;
  core.String formattedUrl;
  core.String htmlFormattedUrl;
  core.String htmlSnippet;
  core.String htmlTitle;
  ResultImage image;
  core.String kind;
  core.List<ResultLabels> labels;
  core.String link;
  core.String mime;
  /**
   *
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.List<core.Map<core.String, core.Object>>> pagemap;
  core.String snippet;
  core.String title;

  Result();

  Result.fromJson(core.Map _json) {
    if (_json.containsKey("cacheId")) {
      cacheId = _json["cacheId"];
    }
    if (_json.containsKey("displayLink")) {
      displayLink = _json["displayLink"];
    }
    if (_json.containsKey("fileFormat")) {
      fileFormat = _json["fileFormat"];
    }
    if (_json.containsKey("formattedUrl")) {
      formattedUrl = _json["formattedUrl"];
    }
    if (_json.containsKey("htmlFormattedUrl")) {
      htmlFormattedUrl = _json["htmlFormattedUrl"];
    }
    if (_json.containsKey("htmlSnippet")) {
      htmlSnippet = _json["htmlSnippet"];
    }
    if (_json.containsKey("htmlTitle")) {
      htmlTitle = _json["htmlTitle"];
    }
    if (_json.containsKey("image")) {
      image = new ResultImage.fromJson(_json["image"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"].map((value) => new ResultLabels.fromJson(value)).toList();
    }
    if (_json.containsKey("link")) {
      link = _json["link"];
    }
    if (_json.containsKey("mime")) {
      mime = _json["mime"];
    }
    if (_json.containsKey("pagemap")) {
      pagemap = _json["pagemap"];
    }
    if (_json.containsKey("snippet")) {
      snippet = _json["snippet"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cacheId != null) {
      _json["cacheId"] = cacheId;
    }
    if (displayLink != null) {
      _json["displayLink"] = displayLink;
    }
    if (fileFormat != null) {
      _json["fileFormat"] = fileFormat;
    }
    if (formattedUrl != null) {
      _json["formattedUrl"] = formattedUrl;
    }
    if (htmlFormattedUrl != null) {
      _json["htmlFormattedUrl"] = htmlFormattedUrl;
    }
    if (htmlSnippet != null) {
      _json["htmlSnippet"] = htmlSnippet;
    }
    if (htmlTitle != null) {
      _json["htmlTitle"] = htmlTitle;
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (labels != null) {
      _json["labels"] = labels.map((value) => (value).toJson()).toList();
    }
    if (link != null) {
      _json["link"] = link;
    }
    if (mime != null) {
      _json["mime"] = mime;
    }
    if (pagemap != null) {
      _json["pagemap"] = pagemap;
    }
    if (snippet != null) {
      _json["snippet"] = snippet;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class SearchSearchInformation {
  core.String formattedSearchTime;
  core.String formattedTotalResults;
  core.double searchTime;
  core.String totalResults;

  SearchSearchInformation();

  SearchSearchInformation.fromJson(core.Map _json) {
    if (_json.containsKey("formattedSearchTime")) {
      formattedSearchTime = _json["formattedSearchTime"];
    }
    if (_json.containsKey("formattedTotalResults")) {
      formattedTotalResults = _json["formattedTotalResults"];
    }
    if (_json.containsKey("searchTime")) {
      searchTime = _json["searchTime"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formattedSearchTime != null) {
      _json["formattedSearchTime"] = formattedSearchTime;
    }
    if (formattedTotalResults != null) {
      _json["formattedTotalResults"] = formattedTotalResults;
    }
    if (searchTime != null) {
      _json["searchTime"] = searchTime;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    return _json;
  }
}

class SearchSpelling {
  core.String correctedQuery;
  core.String htmlCorrectedQuery;

  SearchSpelling();

  SearchSpelling.fromJson(core.Map _json) {
    if (_json.containsKey("correctedQuery")) {
      correctedQuery = _json["correctedQuery"];
    }
    if (_json.containsKey("htmlCorrectedQuery")) {
      htmlCorrectedQuery = _json["htmlCorrectedQuery"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (correctedQuery != null) {
      _json["correctedQuery"] = correctedQuery;
    }
    if (htmlCorrectedQuery != null) {
      _json["htmlCorrectedQuery"] = htmlCorrectedQuery;
    }
    return _json;
  }
}

class SearchUrl {
  core.String template;
  core.String type;

  SearchUrl();

  SearchUrl.fromJson(core.Map _json) {
    if (_json.containsKey("template")) {
      template = _json["template"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (template != null) {
      _json["template"] = template;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class Search {
  Context context;
  core.List<Result> items;
  core.String kind;
  core.List<Promotion> promotions;
  core.Map<core.String, core.List<Query>> queries;
  SearchSearchInformation searchInformation;
  SearchSpelling spelling;
  SearchUrl url;

  Search();

  Search.fromJson(core.Map _json) {
    if (_json.containsKey("context")) {
      context = new Context.fromJson(_json["context"]);
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Result.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("promotions")) {
      promotions = _json["promotions"].map((value) => new Promotion.fromJson(value)).toList();
    }
    if (_json.containsKey("queries")) {
      queries = commons.mapMap(_json["queries"], (item) => item.map((value) => new Query.fromJson(value)).toList());
    }
    if (_json.containsKey("searchInformation")) {
      searchInformation = new SearchSearchInformation.fromJson(_json["searchInformation"]);
    }
    if (_json.containsKey("spelling")) {
      spelling = new SearchSpelling.fromJson(_json["spelling"]);
    }
    if (_json.containsKey("url")) {
      url = new SearchUrl.fromJson(_json["url"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (context != null) {
      _json["context"] = (context).toJson();
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (promotions != null) {
      _json["promotions"] = promotions.map((value) => (value).toJson()).toList();
    }
    if (queries != null) {
      _json["queries"] = commons.mapMap(queries, (item) => item.map((value) => (value).toJson()).toList());
    }
    if (searchInformation != null) {
      _json["searchInformation"] = (searchInformation).toJson();
    }
    if (spelling != null) {
      _json["spelling"] = (spelling).toJson();
    }
    if (url != null) {
      _json["url"] = (url).toJson();
    }
    return _json;
  }
}
