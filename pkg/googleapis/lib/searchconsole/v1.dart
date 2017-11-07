// This is a generated file (see the discoveryapis_generator project).

library googleapis.searchconsole.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client searchconsole/v1';

/** Provides tools for running validation tests against single URLs */
class SearchconsoleApi {

  final commons.ApiRequester _requester;

  UrlTestingToolsResourceApi get urlTestingTools => new UrlTestingToolsResourceApi(_requester);

  SearchconsoleApi(http.Client client, {core.String rootUrl: "https://searchconsole.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class UrlTestingToolsResourceApi {
  final commons.ApiRequester _requester;

  UrlTestingToolsMobileFriendlyTestResourceApi get mobileFriendlyTest => new UrlTestingToolsMobileFriendlyTestResourceApi(_requester);

  UrlTestingToolsResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class UrlTestingToolsMobileFriendlyTestResourceApi {
  final commons.ApiRequester _requester;

  UrlTestingToolsMobileFriendlyTestResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Runs Mobile-Friendly Test for a given URL.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [RunMobileFriendlyTestResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RunMobileFriendlyTestResponse> run(RunMobileFriendlyTestRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/urlTestingTools/mobileFriendlyTest:run';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RunMobileFriendlyTestResponse.fromJson(data));
  }

}



/** Blocked resource. */
class BlockedResource {
  /** URL of the blocked resource. */
  core.String url;

  BlockedResource();

  BlockedResource.fromJson(core.Map _json) {
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Describe image data. */
class Image {
  /**
   * Image data in format determined by the mime type. Currently, the format
   * will always be "image/png", but this might change in the future.
   */
  core.String data;
  core.List<core.int> get dataAsBytes {
    return convert.BASE64.decode(data);
  }

  void set dataAsBytes(core.List<core.int> _bytes) {
    data = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** The mime-type of the image data. */
  core.String mimeType;

  Image();

  Image.fromJson(core.Map _json) {
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("mimeType")) {
      mimeType = _json["mimeType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (data != null) {
      _json["data"] = data;
    }
    if (mimeType != null) {
      _json["mimeType"] = mimeType;
    }
    return _json;
  }
}

/** Mobile-friendly issue. */
class MobileFriendlyIssue {
  /**
   * Rule violated.
   * Possible string values are:
   * - "MOBILE_FRIENDLY_RULE_UNSPECIFIED" : Unknown rule. Sorry, we don't have
   * any description for the rule that was
   * broken.
   * - "USES_INCOMPATIBLE_PLUGINS" : Plugins incompatible with mobile devices
   * are being used. [Learn more]
   * (https://support.google.com/webmasters/answer/6352293#flash_usage).
   * - "CONFIGURE_VIEWPORT" : Viewsport is not specified using the meta viewport
   * tag. [Learn more]
   * (https://support.google.com/webmasters/answer/6352293#viewport_not_configured).
   * - "FIXED_WIDTH_VIEWPORT" : Viewport defined to a fixed width. [Learn more]
   * (https://support.google.com/webmasters/answer/6352293#fixed-width_viewport).
   * - "SIZE_CONTENT_TO_VIEWPORT" : Content not sized to viewport. [Learn more]
   * (https://support.google.com/webmasters/answer/6352293#content_not_sized_to_viewport).
   * - "USE_LEGIBLE_FONT_SIZES" : Font size is too small for easy reading on a
   * small screen. [Learn More]
   * (https://support.google.com/webmasters/answer/6352293#small_font_size).
   * - "TAP_TARGETS_TOO_CLOSE" : Touch elements are too close to each other.
   * [Learn more]
   * (https://support.google.com/webmasters/answer/6352293#touch_elements_too_close).
   */
  core.String rule;

  MobileFriendlyIssue();

  MobileFriendlyIssue.fromJson(core.Map _json) {
    if (_json.containsKey("rule")) {
      rule = _json["rule"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (rule != null) {
      _json["rule"] = rule;
    }
    return _json;
  }
}

/** Information about a resource with issue. */
class ResourceIssue {
  /** Describes a blocked resource issue. */
  BlockedResource blockedResource;

  ResourceIssue();

  ResourceIssue.fromJson(core.Map _json) {
    if (_json.containsKey("blockedResource")) {
      blockedResource = new BlockedResource.fromJson(_json["blockedResource"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (blockedResource != null) {
      _json["blockedResource"] = (blockedResource).toJson();
    }
    return _json;
  }
}

/** Mobile-friendly test request. */
class RunMobileFriendlyTestRequest {
  /** Whether or not screenshot is requested. Default is false. */
  core.bool requestScreenshot;
  /** URL for inspection. */
  core.String url;

  RunMobileFriendlyTestRequest();

  RunMobileFriendlyTestRequest.fromJson(core.Map _json) {
    if (_json.containsKey("requestScreenshot")) {
      requestScreenshot = _json["requestScreenshot"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (requestScreenshot != null) {
      _json["requestScreenshot"] = requestScreenshot;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/**
 * Mobile-friendly test response, including mobile-friendly issues and resource
 * issues.
 */
class RunMobileFriendlyTestResponse {
  /**
   * Test verdict, whether the page is mobile friendly or not.
   * Possible string values are:
   * - "MOBILE_FRIENDLY_TEST_RESULT_UNSPECIFIED" : Internal error when running
   * this test. Please try running the test again.
   * - "MOBILE_FRIENDLY" : The page is mobile friendly.
   * - "NOT_MOBILE_FRIENDLY" : The page is not mobile friendly.
   */
  core.String mobileFriendliness;
  /** List of mobile-usability issues. */
  core.List<MobileFriendlyIssue> mobileFriendlyIssues;
  /** Information about embedded resources issues. */
  core.List<ResourceIssue> resourceIssues;
  /** Screenshot of the requested URL. */
  Image screenshot;
  /** Final state of the test, can be either complete or an error. */
  TestStatus testStatus;

  RunMobileFriendlyTestResponse();

  RunMobileFriendlyTestResponse.fromJson(core.Map _json) {
    if (_json.containsKey("mobileFriendliness")) {
      mobileFriendliness = _json["mobileFriendliness"];
    }
    if (_json.containsKey("mobileFriendlyIssues")) {
      mobileFriendlyIssues = _json["mobileFriendlyIssues"].map((value) => new MobileFriendlyIssue.fromJson(value)).toList();
    }
    if (_json.containsKey("resourceIssues")) {
      resourceIssues = _json["resourceIssues"].map((value) => new ResourceIssue.fromJson(value)).toList();
    }
    if (_json.containsKey("screenshot")) {
      screenshot = new Image.fromJson(_json["screenshot"]);
    }
    if (_json.containsKey("testStatus")) {
      testStatus = new TestStatus.fromJson(_json["testStatus"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (mobileFriendliness != null) {
      _json["mobileFriendliness"] = mobileFriendliness;
    }
    if (mobileFriendlyIssues != null) {
      _json["mobileFriendlyIssues"] = mobileFriendlyIssues.map((value) => (value).toJson()).toList();
    }
    if (resourceIssues != null) {
      _json["resourceIssues"] = resourceIssues.map((value) => (value).toJson()).toList();
    }
    if (screenshot != null) {
      _json["screenshot"] = (screenshot).toJson();
    }
    if (testStatus != null) {
      _json["testStatus"] = (testStatus).toJson();
    }
    return _json;
  }
}

/** Final state of the test, including error details if necessary. */
class TestStatus {
  /** Error details if applicable. */
  core.String details;
  /**
   * Status of the test.
   * Possible string values are:
   * - "TEST_STATUS_UNSPECIFIED" : Internal error when running this test. Please
   * try running the test again.
   * - "COMPLETE" : Inspection has completed without errors.
   * - "INTERNAL_ERROR" : Inspection terminated in an error state. This
   * indicates a problem in
   * Google's infrastructure, not a user error. Please try again later.
   * - "PAGE_UNREACHABLE" : Google can not access the URL because of a user
   * error such as a robots.txt
   * blockage, a 403 or 500 code etc. Please make sure that the URL provided is
   * accessible by Googlebot and is not password protected.
   */
  core.String status;

  TestStatus();

  TestStatus.fromJson(core.Map _json) {
    if (_json.containsKey("details")) {
      details = _json["details"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (details != null) {
      _json["details"] = details;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}
