// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.dlp.v2beta1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client dlp/v2beta1';

/// The Google Data Loss Prevention API provides methods for detection of
/// privacy-sensitive fragments in text, images, and Google Cloud Platform
/// storage repositories.
class DlpApi {
  /// View and manage your data across Google Cloud Platform services
  static const CloudPlatformScope =
      "https://www.googleapis.com/auth/cloud-platform";

  final commons.ApiRequester _requester;

  ContentResourceApi get content => new ContentResourceApi(_requester);
  InspectResourceApi get inspect => new InspectResourceApi(_requester);
  RiskAnalysisResourceApi get riskAnalysis =>
      new RiskAnalysisResourceApi(_requester);
  RootCategoriesResourceApi get rootCategories =>
      new RootCategoriesResourceApi(_requester);

  DlpApi(http.Client client,
      {core.String rootUrl: "https://dlp.googleapis.com/",
      core.String servicePath: ""})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class ContentResourceApi {
  final commons.ApiRequester _requester;

  ContentResourceApi(commons.ApiRequester client) : _requester = client;

  /// Finds potentially sensitive info in a list of strings.
  /// This method has limits on input size, processing time, and output size.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// Completes with a [GooglePrivacyDlpV2beta1InspectContentResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GooglePrivacyDlpV2beta1InspectContentResponse> inspect(
      GooglePrivacyDlpV2beta1InspectContentRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v2beta1/content:inspect';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new GooglePrivacyDlpV2beta1InspectContentResponse.fromJson(data));
  }

  /// Redacts potentially sensitive info from a list of strings.
  /// This method has limits on input size, processing time, and output size.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// Completes with a [GooglePrivacyDlpV2beta1RedactContentResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GooglePrivacyDlpV2beta1RedactContentResponse> redact(
      GooglePrivacyDlpV2beta1RedactContentRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v2beta1/content:redact';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new GooglePrivacyDlpV2beta1RedactContentResponse.fromJson(data));
  }
}

class InspectResourceApi {
  final commons.ApiRequester _requester;

  InspectOperationsResourceApi get operations =>
      new InspectOperationsResourceApi(_requester);
  InspectResultsResourceApi get results =>
      new InspectResultsResourceApi(_requester);

  InspectResourceApi(commons.ApiRequester client) : _requester = client;
}

class InspectOperationsResourceApi {
  final commons.ApiRequester _requester;

  InspectOperationsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Cancels an operation. Use the get method to check whether the cancellation
  /// succeeded or whether the operation completed despite cancellation.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [name] - The name of the operation resource to be cancelled.
  /// Value must have pattern "^inspect/operations/[^/]+$".
  ///
  /// Completes with a [GoogleProtobufEmpty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GoogleProtobufEmpty> cancel(
      GoogleLongrunningCancelOperationRequest request, core.String name) {
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

    _url =
        'v2beta1/' + commons.Escaper.ecapeVariableReserved('$name') + ':cancel';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new GoogleProtobufEmpty.fromJson(data));
  }

  /// Schedules a job scanning content in a Google Cloud Platform data
  /// repository.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// Completes with a [GoogleLongrunningOperation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GoogleLongrunningOperation> create(
      GooglePrivacyDlpV2beta1CreateInspectOperationRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v2beta1/inspect/operations';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new GoogleLongrunningOperation.fromJson(data));
  }

  /// This method is not supported and the server returns `UNIMPLEMENTED`.
  ///
  /// Request parameters:
  ///
  /// [name] - The name of the operation resource to be deleted.
  /// Value must have pattern "^inspect/operations/[^/]+$".
  ///
  /// Completes with a [GoogleProtobufEmpty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GoogleProtobufEmpty> delete(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v2beta1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new GoogleProtobufEmpty.fromJson(data));
  }

  /// Gets the latest state of a long-running operation.  Clients can use this
  /// method to poll the operation result at intervals as recommended by the API
  /// service.
  ///
  /// Request parameters:
  ///
  /// [name] - The name of the operation resource.
  /// Value must have pattern "^inspect/operations/[^/]+$".
  ///
  /// Completes with a [GoogleLongrunningOperation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GoogleLongrunningOperation> get(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v2beta1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new GoogleLongrunningOperation.fromJson(data));
  }

  /// Fetch the list of long running operations.
  ///
  /// Request parameters:
  ///
  /// [name] - The name of the operation's parent resource.
  /// Value must have pattern "^inspect/operations$".
  ///
  /// [filter] - This parameter supports filtering by done, ie done=true or
  /// done=false.
  ///
  /// [pageToken] - The standard list page token.
  ///
  /// [pageSize] - The list page size. The max allowed value is 256 and default
  /// is 100.
  ///
  /// Completes with a [GoogleLongrunningListOperationsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GoogleLongrunningListOperationsResponse> list(core.String name,
      {core.String filter, core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v2beta1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then(
        (data) => new GoogleLongrunningListOperationsResponse.fromJson(data));
  }
}

class InspectResultsResourceApi {
  final commons.ApiRequester _requester;

  InspectResultsFindingsResourceApi get findings =>
      new InspectResultsFindingsResourceApi(_requester);

  InspectResultsResourceApi(commons.ApiRequester client) : _requester = client;
}

class InspectResultsFindingsResourceApi {
  final commons.ApiRequester _requester;

  InspectResultsFindingsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Returns list of results for given inspect operation result set id.
  ///
  /// Request parameters:
  ///
  /// [name] - Identifier of the results set returned as metadata of
  /// the longrunning operation created by a call to InspectDataSource.
  /// Should be in the format of `inspect/results/{id}`.
  /// Value must have pattern "^inspect/results/[^/]+$".
  ///
  /// [pageToken] - The value returned by the last
  /// `ListInspectFindingsResponse`; indicates
  /// that this is a continuation of a prior `ListInspectFindings` call, and
  /// that
  /// the system should return the next page of data.
  ///
  /// [pageSize] - Maximum number of results to return.
  /// If 0, the implementation selects a reasonable value.
  ///
  /// [filter] - Restricts findings to items that match. Supports info_type and
  /// likelihood.
  /// Examples:
  /// - info_type=EMAIL_ADDRESS
  /// - info_type=PHONE_NUMBER,EMAIL_ADDRESS
  /// - likelihood=VERY_LIKELY
  /// - likelihood=VERY_LIKELY,LIKELY
  /// - info_type=EMAIL_ADDRESS,likelihood=VERY_LIKELY,LIKELY
  ///
  /// Completes with a [GooglePrivacyDlpV2beta1ListInspectFindingsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GooglePrivacyDlpV2beta1ListInspectFindingsResponse> list(
      core.String name,
      {core.String pageToken,
      core.int pageSize,
      core.String filter}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }

    _url = 'v2beta1/' +
        commons.Escaper.ecapeVariableReserved('$name') +
        '/findings';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new GooglePrivacyDlpV2beta1ListInspectFindingsResponse.fromJson(data));
  }
}

class RiskAnalysisResourceApi {
  final commons.ApiRequester _requester;

  RiskAnalysisOperationsResourceApi get operations =>
      new RiskAnalysisOperationsResourceApi(_requester);

  RiskAnalysisResourceApi(commons.ApiRequester client) : _requester = client;
}

class RiskAnalysisOperationsResourceApi {
  final commons.ApiRequester _requester;

  RiskAnalysisOperationsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Cancels an operation. Use the get method to check whether the cancellation
  /// succeeded or whether the operation completed despite cancellation.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [name] - The name of the operation resource to be cancelled.
  /// Value must have pattern "^riskAnalysis/operations/[^/]+$".
  ///
  /// Completes with a [GoogleProtobufEmpty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GoogleProtobufEmpty> cancel(
      GoogleLongrunningCancelOperationRequest request, core.String name) {
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

    _url =
        'v2beta1/' + commons.Escaper.ecapeVariableReserved('$name') + ':cancel';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new GoogleProtobufEmpty.fromJson(data));
  }

  /// This method is not supported and the server returns `UNIMPLEMENTED`.
  ///
  /// Request parameters:
  ///
  /// [name] - The name of the operation resource to be deleted.
  /// Value must have pattern "^riskAnalysis/operations/[^/]+$".
  ///
  /// Completes with a [GoogleProtobufEmpty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GoogleProtobufEmpty> delete(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v2beta1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new GoogleProtobufEmpty.fromJson(data));
  }

  /// Gets the latest state of a long-running operation.  Clients can use this
  /// method to poll the operation result at intervals as recommended by the API
  /// service.
  ///
  /// Request parameters:
  ///
  /// [name] - The name of the operation resource.
  /// Value must have pattern "^riskAnalysis/operations/[^/]+$".
  ///
  /// Completes with a [GoogleLongrunningOperation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GoogleLongrunningOperation> get(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v2beta1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new GoogleLongrunningOperation.fromJson(data));
  }

  /// Fetch the list of long running operations.
  ///
  /// Request parameters:
  ///
  /// [name] - The name of the operation's parent resource.
  /// Value must have pattern "^riskAnalysis/operations$".
  ///
  /// [pageToken] - The standard list page token.
  ///
  /// [pageSize] - The list page size. The max allowed value is 256 and default
  /// is 100.
  ///
  /// [filter] - This parameter supports filtering by done, ie done=true or
  /// done=false.
  ///
  /// Completes with a [GoogleLongrunningListOperationsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GoogleLongrunningListOperationsResponse> list(core.String name,
      {core.String pageToken, core.int pageSize, core.String filter}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }

    _url = 'v2beta1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then(
        (data) => new GoogleLongrunningListOperationsResponse.fromJson(data));
  }
}

class RootCategoriesResourceApi {
  final commons.ApiRequester _requester;

  RootCategoriesInfoTypesResourceApi get infoTypes =>
      new RootCategoriesInfoTypesResourceApi(_requester);

  RootCategoriesResourceApi(commons.ApiRequester client) : _requester = client;

  /// Returns the list of root categories of sensitive information.
  ///
  /// Request parameters:
  ///
  /// [languageCode] - Optional language code for localized friendly category
  /// names.
  /// If omitted or if localized strings are not available,
  /// en-US strings will be returned.
  ///
  /// Completes with a [GooglePrivacyDlpV2beta1ListRootCategoriesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GooglePrivacyDlpV2beta1ListRootCategoriesResponse> list(
      {core.String languageCode}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (languageCode != null) {
      _queryParams["languageCode"] = [languageCode];
    }

    _url = 'v2beta1/rootCategories';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new GooglePrivacyDlpV2beta1ListRootCategoriesResponse.fromJson(data));
  }
}

class RootCategoriesInfoTypesResourceApi {
  final commons.ApiRequester _requester;

  RootCategoriesInfoTypesResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Returns sensitive information types for given category.
  ///
  /// Request parameters:
  ///
  /// [category] - Category name as returned by ListRootCategories.
  /// Value must have pattern "^[^/]+$".
  ///
  /// [languageCode] - Optional BCP-47 language code for localized info type
  /// friendly
  /// names. If omitted, or if localized strings are not available,
  /// en-US strings will be returned.
  ///
  /// Completes with a [GooglePrivacyDlpV2beta1ListInfoTypesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GooglePrivacyDlpV2beta1ListInfoTypesResponse> list(
      core.String category,
      {core.String languageCode}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (category == null) {
      throw new core.ArgumentError("Parameter category is required.");
    }
    if (languageCode != null) {
      _queryParams["languageCode"] = [languageCode];
    }

    _url = 'v2beta1/rootCategories/' +
        commons.Escaper.ecapeVariableReserved('$category') +
        '/infoTypes';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new GooglePrivacyDlpV2beta1ListInfoTypesResponse.fromJson(data));
  }
}

/// The request message for Operations.CancelOperation.
class GoogleLongrunningCancelOperationRequest {
  GoogleLongrunningCancelOperationRequest();

  GoogleLongrunningCancelOperationRequest.fromJson(core.Map _json) {}

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    return _json;
  }
}

/// The response message for Operations.ListOperations.
class GoogleLongrunningListOperationsResponse {
  /// The standard List next-page token.
  core.String nextPageToken;

  /// A list of operations that matches the specified filter in the request.
  core.List<GoogleLongrunningOperation> operations;

  GoogleLongrunningListOperationsResponse();

  GoogleLongrunningListOperationsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("operations")) {
      operations = _json["operations"]
          .map((value) => new GoogleLongrunningOperation.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (operations != null) {
      _json["operations"] =
          operations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// This resource represents a long-running operation that is the result of a
/// network API call.
class GoogleLongrunningOperation {
  /// If the value is `false`, it means the operation is still in progress.
  /// If `true`, the operation is completed, and either `error` or `response` is
  /// available.
  core.bool done;

  /// The error result of the operation in case of failure or cancellation.
  GoogleRpcStatus error;

  /// This field will contain an InspectOperationMetadata object. This will
  /// always be returned with the Operation.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> metadata;

  /// The server-assigned name, The `name` should have the format of
  /// `inspect/operations/<identifier>`.
  core.String name;

  /// This field will contain an InspectOperationResult object.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> response;

  GoogleLongrunningOperation();

  GoogleLongrunningOperation.fromJson(core.Map _json) {
    if (_json.containsKey("done")) {
      done = _json["done"];
    }
    if (_json.containsKey("error")) {
      error = new GoogleRpcStatus.fromJson(_json["error"]);
    }
    if (_json.containsKey("metadata")) {
      metadata = _json["metadata"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("response")) {
      response = _json["response"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (done != null) {
      _json["done"] = done;
    }
    if (error != null) {
      _json["error"] = (error).toJson();
    }
    if (metadata != null) {
      _json["metadata"] = metadata;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (response != null) {
      _json["response"] = response;
    }
    return _json;
  }
}

/// Options defining BigQuery table and row identifiers.
class GooglePrivacyDlpV2beta1BigQueryOptions {
  /// References to fields uniquely identifying rows within the table.
  /// Nested fields in the format, like `person.birthdate.year`, are allowed.
  core.List<GooglePrivacyDlpV2beta1FieldId> identifyingFields;

  /// Complete BigQuery table reference.
  GooglePrivacyDlpV2beta1BigQueryTable tableReference;

  GooglePrivacyDlpV2beta1BigQueryOptions();

  GooglePrivacyDlpV2beta1BigQueryOptions.fromJson(core.Map _json) {
    if (_json.containsKey("identifyingFields")) {
      identifyingFields = _json["identifyingFields"]
          .map((value) => new GooglePrivacyDlpV2beta1FieldId.fromJson(value))
          .toList();
    }
    if (_json.containsKey("tableReference")) {
      tableReference = new GooglePrivacyDlpV2beta1BigQueryTable.fromJson(
          _json["tableReference"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (identifyingFields != null) {
      _json["identifyingFields"] =
          identifyingFields.map((value) => (value).toJson()).toList();
    }
    if (tableReference != null) {
      _json["tableReference"] = (tableReference).toJson();
    }
    return _json;
  }
}

/// Message defining the location of a BigQuery table. A table is uniquely
/// identified  by its project_id, dataset_id, and table_name. Within a query
/// a table is often referenced with a string in the format of:
/// `<project_id>:<dataset_id>.<table_id>` or
/// `<project_id>.<dataset_id>.<table_id>`.
class GooglePrivacyDlpV2beta1BigQueryTable {
  /// Dataset ID of the table.
  core.String datasetId;

  /// The Google Cloud Platform project ID of the project containing the table.
  /// If omitted, project ID is inferred from the API call.
  core.String projectId;

  /// Name of the table.
  core.String tableId;

  GooglePrivacyDlpV2beta1BigQueryTable();

  GooglePrivacyDlpV2beta1BigQueryTable.fromJson(core.Map _json) {
    if (_json.containsKey("datasetId")) {
      datasetId = _json["datasetId"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("tableId")) {
      tableId = _json["tableId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (datasetId != null) {
      _json["datasetId"] = datasetId;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (tableId != null) {
      _json["tableId"] = tableId;
    }
    return _json;
  }
}

/// Info Type Category description.
class GooglePrivacyDlpV2beta1CategoryDescription {
  /// Human readable form of the category name.
  core.String displayName;

  /// Internal name of the category.
  core.String name;

  GooglePrivacyDlpV2beta1CategoryDescription();

  GooglePrivacyDlpV2beta1CategoryDescription.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/// Record key for a finding in a Cloud Storage file.
class GooglePrivacyDlpV2beta1CloudStorageKey {
  /// Path to the file.
  core.String filePath;

  /// Byte offset of the referenced data in the file.
  core.String startOffset;

  GooglePrivacyDlpV2beta1CloudStorageKey();

  GooglePrivacyDlpV2beta1CloudStorageKey.fromJson(core.Map _json) {
    if (_json.containsKey("filePath")) {
      filePath = _json["filePath"];
    }
    if (_json.containsKey("startOffset")) {
      startOffset = _json["startOffset"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (filePath != null) {
      _json["filePath"] = filePath;
    }
    if (startOffset != null) {
      _json["startOffset"] = startOffset;
    }
    return _json;
  }
}

/// Options defining a file or a set of files (path ending with *) within
/// a Google Cloud Storage bucket.
class GooglePrivacyDlpV2beta1CloudStorageOptions {
  GooglePrivacyDlpV2beta1FileSet fileSet;

  GooglePrivacyDlpV2beta1CloudStorageOptions();

  GooglePrivacyDlpV2beta1CloudStorageOptions.fromJson(core.Map _json) {
    if (_json.containsKey("fileSet")) {
      fileSet = new GooglePrivacyDlpV2beta1FileSet.fromJson(_json["fileSet"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (fileSet != null) {
      _json["fileSet"] = (fileSet).toJson();
    }
    return _json;
  }
}

/// A location in Cloud Storage.
class GooglePrivacyDlpV2beta1CloudStoragePath {
  /// The url, in the format of `gs://bucket/<path>`.
  core.String path;

  GooglePrivacyDlpV2beta1CloudStoragePath();

  GooglePrivacyDlpV2beta1CloudStoragePath.fromJson(core.Map _json) {
    if (_json.containsKey("path")) {
      path = _json["path"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (path != null) {
      _json["path"] = path;
    }
    return _json;
  }
}

/// Represents a color in the RGB color space.
class GooglePrivacyDlpV2beta1Color {
  /// The amount of blue in the color as a value in the interval [0, 1].
  core.double blue;

  /// The amount of green in the color as a value in the interval [0, 1].
  core.double green;

  /// The amount of red in the color as a value in the interval [0, 1].
  core.double red;

  GooglePrivacyDlpV2beta1Color();

  GooglePrivacyDlpV2beta1Color.fromJson(core.Map _json) {
    if (_json.containsKey("blue")) {
      blue = _json["blue"];
    }
    if (_json.containsKey("green")) {
      green = _json["green"];
    }
    if (_json.containsKey("red")) {
      red = _json["red"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (blue != null) {
      _json["blue"] = blue;
    }
    if (green != null) {
      _json["green"] = green;
    }
    if (red != null) {
      _json["red"] = red;
    }
    return _json;
  }
}

/// Container structure for the content to inspect.
class GooglePrivacyDlpV2beta1ContentItem {
  /// Content data to inspect or redact.
  core.String data;
  core.List<core.int> get dataAsBytes {
    return convert.BASE64.decode(data);
  }

  void set dataAsBytes(core.List<core.int> _bytes) {
    data =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// Structured content for inspection.
  GooglePrivacyDlpV2beta1Table table;

  /// Type of the content, as defined in Content-Type HTTP header.
  /// Supported types are: all "text" types, octet streams, PNG images,
  /// JPEG images.
  core.String type;

  /// String data to inspect or redact.
  core.String value;

  GooglePrivacyDlpV2beta1ContentItem();

  GooglePrivacyDlpV2beta1ContentItem.fromJson(core.Map _json) {
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("table")) {
      table = new GooglePrivacyDlpV2beta1Table.fromJson(_json["table"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (data != null) {
      _json["data"] = data;
    }
    if (table != null) {
      _json["table"] = (table).toJson();
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

/// Request for scheduling a scan of a data subset from a Google Platform data
/// repository.
class GooglePrivacyDlpV2beta1CreateInspectOperationRequest {
  /// Configuration for the inspector.
  GooglePrivacyDlpV2beta1InspectConfig inspectConfig;

  /// Additional configuration settings for long running operations.
  GooglePrivacyDlpV2beta1OperationConfig operationConfig;

  /// Optional location to store findings. The bucket must already exist and
  /// the Google APIs service account for DLP must have write permission to
  /// write to the given bucket.
  /// Results are split over multiple csv files with each file name matching
  /// the pattern "[operation_id]_[count].csv", for example
  /// `3094877188788974909_1.csv`. The `operation_id` matches the
  /// identifier for the Operation, and the `count` is a counter used for
  /// tracking the number of files written.
  /// The CSV file(s) contain the
  /// following columns regardless of storage type scanned:
  /// - id
  /// - info_type
  /// - likelihood
  /// - byte size of finding
  /// - quote
  /// - timestamp
  ///
  /// For Cloud Storage the next columns are:
  /// - file_path
  /// - start_offset
  ///
  /// For Cloud Datastore the next columns are:
  /// - project_id
  /// - namespace_id
  /// - path
  /// - column_name
  /// - offset
  ///
  /// For BigQuery the next columns are:
  /// - row_number
  /// - project_id
  /// - dataset_id
  /// - table_id
  GooglePrivacyDlpV2beta1OutputStorageConfig outputConfig;

  /// Specification of the data set to process.
  GooglePrivacyDlpV2beta1StorageConfig storageConfig;

  GooglePrivacyDlpV2beta1CreateInspectOperationRequest();

  GooglePrivacyDlpV2beta1CreateInspectOperationRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey("inspectConfig")) {
      inspectConfig = new GooglePrivacyDlpV2beta1InspectConfig.fromJson(
          _json["inspectConfig"]);
    }
    if (_json.containsKey("operationConfig")) {
      operationConfig = new GooglePrivacyDlpV2beta1OperationConfig.fromJson(
          _json["operationConfig"]);
    }
    if (_json.containsKey("outputConfig")) {
      outputConfig = new GooglePrivacyDlpV2beta1OutputStorageConfig.fromJson(
          _json["outputConfig"]);
    }
    if (_json.containsKey("storageConfig")) {
      storageConfig = new GooglePrivacyDlpV2beta1StorageConfig.fromJson(
          _json["storageConfig"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (inspectConfig != null) {
      _json["inspectConfig"] = (inspectConfig).toJson();
    }
    if (operationConfig != null) {
      _json["operationConfig"] = (operationConfig).toJson();
    }
    if (outputConfig != null) {
      _json["outputConfig"] = (outputConfig).toJson();
    }
    if (storageConfig != null) {
      _json["storageConfig"] = (storageConfig).toJson();
    }
    return _json;
  }
}

/// Record key for a finding in Cloud Datastore.
class GooglePrivacyDlpV2beta1DatastoreKey {
  /// Datastore entity key.
  GooglePrivacyDlpV2beta1Key entityKey;

  GooglePrivacyDlpV2beta1DatastoreKey();

  GooglePrivacyDlpV2beta1DatastoreKey.fromJson(core.Map _json) {
    if (_json.containsKey("entityKey")) {
      entityKey = new GooglePrivacyDlpV2beta1Key.fromJson(_json["entityKey"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entityKey != null) {
      _json["entityKey"] = (entityKey).toJson();
    }
    return _json;
  }
}

/// Options defining a data set within Google Cloud Datastore.
class GooglePrivacyDlpV2beta1DatastoreOptions {
  /// The kind to process.
  GooglePrivacyDlpV2beta1KindExpression kind;

  /// A partition ID identifies a grouping of entities. The grouping is always
  /// by project and namespace, however the namespace ID may be empty.
  GooglePrivacyDlpV2beta1PartitionId partitionId;

  /// Properties to scan. If none are specified, all properties will be scanned
  /// by default.
  core.List<GooglePrivacyDlpV2beta1Projection> projection;

  GooglePrivacyDlpV2beta1DatastoreOptions();

  GooglePrivacyDlpV2beta1DatastoreOptions.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = new GooglePrivacyDlpV2beta1KindExpression.fromJson(_json["kind"]);
    }
    if (_json.containsKey("partitionId")) {
      partitionId =
          new GooglePrivacyDlpV2beta1PartitionId.fromJson(_json["partitionId"]);
    }
    if (_json.containsKey("projection")) {
      projection = _json["projection"]
          .map((value) => new GooglePrivacyDlpV2beta1Projection.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = (kind).toJson();
    }
    if (partitionId != null) {
      _json["partitionId"] = (partitionId).toJson();
    }
    if (projection != null) {
      _json["projection"] =
          projection.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// General identifier of a data field in a storage service.
class GooglePrivacyDlpV2beta1FieldId {
  /// Name describing the field.
  core.String columnName;

  GooglePrivacyDlpV2beta1FieldId();

  GooglePrivacyDlpV2beta1FieldId.fromJson(core.Map _json) {
    if (_json.containsKey("columnName")) {
      columnName = _json["columnName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (columnName != null) {
      _json["columnName"] = columnName;
    }
    return _json;
  }
}

/// Set of files to scan.
class GooglePrivacyDlpV2beta1FileSet {
  /// The url, in the format `gs://<bucket>/<path>`. Trailing wildcard in the
  /// path is allowed.
  core.String url;

  GooglePrivacyDlpV2beta1FileSet();

  GooglePrivacyDlpV2beta1FileSet.fromJson(core.Map _json) {
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/// Container structure describing a single finding within a string or image.
class GooglePrivacyDlpV2beta1Finding {
  /// Timestamp when finding was detected.
  core.String createTime;

  /// The specific type of info the string might be.
  GooglePrivacyDlpV2beta1InfoType infoType;

  /// Estimate of how likely it is that the info_type is correct.
  /// Possible string values are:
  /// - "LIKELIHOOD_UNSPECIFIED" : Default value; information with all
  /// likelihoods is included.
  /// - "VERY_UNLIKELY" : Few matching elements.
  /// - "UNLIKELY"
  /// - "POSSIBLE" : Some matching elements.
  /// - "LIKELY"
  /// - "VERY_LIKELY" : Many matching elements.
  core.String likelihood;

  /// Location of the info found.
  GooglePrivacyDlpV2beta1Location location;

  /// The specific string that may be potentially sensitive info.
  core.String quote;

  GooglePrivacyDlpV2beta1Finding();

  GooglePrivacyDlpV2beta1Finding.fromJson(core.Map _json) {
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("infoType")) {
      infoType =
          new GooglePrivacyDlpV2beta1InfoType.fromJson(_json["infoType"]);
    }
    if (_json.containsKey("likelihood")) {
      likelihood = _json["likelihood"];
    }
    if (_json.containsKey("location")) {
      location =
          new GooglePrivacyDlpV2beta1Location.fromJson(_json["location"]);
    }
    if (_json.containsKey("quote")) {
      quote = _json["quote"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (infoType != null) {
      _json["infoType"] = (infoType).toJson();
    }
    if (likelihood != null) {
      _json["likelihood"] = likelihood;
    }
    if (location != null) {
      _json["location"] = (location).toJson();
    }
    if (quote != null) {
      _json["quote"] = quote;
    }
    return _json;
  }
}

/// Bounding box encompassing detected text within an image.
class GooglePrivacyDlpV2beta1ImageLocation {
  /// Height of the bounding box in pixels.
  core.int height;

  /// Left coordinate of the bounding box. (0,0) is upper left.
  core.int left;

  /// Top coordinate of the bounding box. (0,0) is upper left.
  core.int top;

  /// Width of the bounding box in pixels.
  core.int width;

  GooglePrivacyDlpV2beta1ImageLocation();

  GooglePrivacyDlpV2beta1ImageLocation.fromJson(core.Map _json) {
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

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
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

/// Configuration for determing how redaction of images should occur.
class GooglePrivacyDlpV2beta1ImageRedactionConfig {
  /// Only one per info_type should be provided per request. If not
  /// specified, and redact_all_text is false, the DLP API will redact all
  /// text that it matches against all info_types that are found, but not
  /// specified in another ImageRedactionConfig.
  GooglePrivacyDlpV2beta1InfoType infoType;

  /// If true, all text found in the image, regardless whether it matches an
  /// info_type, is redacted.
  core.bool redactAllText;

  /// The color to use when redacting content from an image. If not specified,
  /// the default is black.
  GooglePrivacyDlpV2beta1Color redactionColor;

  GooglePrivacyDlpV2beta1ImageRedactionConfig();

  GooglePrivacyDlpV2beta1ImageRedactionConfig.fromJson(core.Map _json) {
    if (_json.containsKey("infoType")) {
      infoType =
          new GooglePrivacyDlpV2beta1InfoType.fromJson(_json["infoType"]);
    }
    if (_json.containsKey("redactAllText")) {
      redactAllText = _json["redactAllText"];
    }
    if (_json.containsKey("redactionColor")) {
      redactionColor =
          new GooglePrivacyDlpV2beta1Color.fromJson(_json["redactionColor"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (infoType != null) {
      _json["infoType"] = (infoType).toJson();
    }
    if (redactAllText != null) {
      _json["redactAllText"] = redactAllText;
    }
    if (redactionColor != null) {
      _json["redactionColor"] = (redactionColor).toJson();
    }
    return _json;
  }
}

/// Type of information detected by the API.
class GooglePrivacyDlpV2beta1InfoType {
  /// Name of the information type.
  core.String name;

  GooglePrivacyDlpV2beta1InfoType();

  GooglePrivacyDlpV2beta1InfoType.fromJson(core.Map _json) {
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

/// Info type description.
class GooglePrivacyDlpV2beta1InfoTypeDescription {
  /// List of categories this info type belongs to.
  core.List<GooglePrivacyDlpV2beta1CategoryDescription> categories;

  /// Human readable form of the info type name.
  core.String displayName;

  /// Internal name of the info type.
  core.String name;

  GooglePrivacyDlpV2beta1InfoTypeDescription();

  GooglePrivacyDlpV2beta1InfoTypeDescription.fromJson(core.Map _json) {
    if (_json.containsKey("categories")) {
      categories = _json["categories"]
          .map((value) =>
              new GooglePrivacyDlpV2beta1CategoryDescription.fromJson(value))
          .toList();
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (categories != null) {
      _json["categories"] =
          categories.map((value) => (value).toJson()).toList();
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/// Max findings configuration per info type, per content item or long running
/// operation.
class GooglePrivacyDlpV2beta1InfoTypeLimit {
  /// Type of information the findings limit applies to. Only one limit per
  /// info_type should be provided. If InfoTypeLimit does not have an
  /// info_type, the DLP API applies the limit against all info_types that are
  /// found but not specified in another InfoTypeLimit.
  GooglePrivacyDlpV2beta1InfoType infoType;

  /// Max findings limit for the given infoType.
  core.int maxFindings;

  GooglePrivacyDlpV2beta1InfoTypeLimit();

  GooglePrivacyDlpV2beta1InfoTypeLimit.fromJson(core.Map _json) {
    if (_json.containsKey("infoType")) {
      infoType =
          new GooglePrivacyDlpV2beta1InfoType.fromJson(_json["infoType"]);
    }
    if (_json.containsKey("maxFindings")) {
      maxFindings = _json["maxFindings"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (infoType != null) {
      _json["infoType"] = (infoType).toJson();
    }
    if (maxFindings != null) {
      _json["maxFindings"] = maxFindings;
    }
    return _json;
  }
}

/// Statistics regarding a specific InfoType.
class GooglePrivacyDlpV2beta1InfoTypeStatistics {
  /// Number of findings for this info type.
  core.String count;

  /// The type of finding this stat is for.
  GooglePrivacyDlpV2beta1InfoType infoType;

  GooglePrivacyDlpV2beta1InfoTypeStatistics();

  GooglePrivacyDlpV2beta1InfoTypeStatistics.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("infoType")) {
      infoType =
          new GooglePrivacyDlpV2beta1InfoType.fromJson(_json["infoType"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (count != null) {
      _json["count"] = count;
    }
    if (infoType != null) {
      _json["infoType"] = (infoType).toJson();
    }
    return _json;
  }
}

/// Configuration description of the scanning process.
/// When used with redactContent only info_types and min_likelihood are
/// currently
/// used.
class GooglePrivacyDlpV2beta1InspectConfig {
  /// When true, excludes type information of the findings.
  core.bool excludeTypes;

  /// When true, a contextual quote from the data that triggered a finding is
  /// included in the response; see Finding.quote.
  core.bool includeQuote;

  /// Configuration of findings limit given for specified info types.
  core.List<GooglePrivacyDlpV2beta1InfoTypeLimit> infoTypeLimits;

  /// Restricts what info_types to look for. The values must correspond to
  /// InfoType values returned by ListInfoTypes or found in documentation.
  /// Empty info_types runs all enabled detectors.
  core.List<GooglePrivacyDlpV2beta1InfoType> infoTypes;

  /// Limits the number of findings per content item or long running operation.
  core.int maxFindings;

  /// Only returns findings equal or above this threshold.
  /// Possible string values are:
  /// - "LIKELIHOOD_UNSPECIFIED" : Default value; information with all
  /// likelihoods is included.
  /// - "VERY_UNLIKELY" : Few matching elements.
  /// - "UNLIKELY"
  /// - "POSSIBLE" : Some matching elements.
  /// - "LIKELY"
  /// - "VERY_LIKELY" : Many matching elements.
  core.String minLikelihood;

  GooglePrivacyDlpV2beta1InspectConfig();

  GooglePrivacyDlpV2beta1InspectConfig.fromJson(core.Map _json) {
    if (_json.containsKey("excludeTypes")) {
      excludeTypes = _json["excludeTypes"];
    }
    if (_json.containsKey("includeQuote")) {
      includeQuote = _json["includeQuote"];
    }
    if (_json.containsKey("infoTypeLimits")) {
      infoTypeLimits = _json["infoTypeLimits"]
          .map((value) =>
              new GooglePrivacyDlpV2beta1InfoTypeLimit.fromJson(value))
          .toList();
    }
    if (_json.containsKey("infoTypes")) {
      infoTypes = _json["infoTypes"]
          .map((value) => new GooglePrivacyDlpV2beta1InfoType.fromJson(value))
          .toList();
    }
    if (_json.containsKey("maxFindings")) {
      maxFindings = _json["maxFindings"];
    }
    if (_json.containsKey("minLikelihood")) {
      minLikelihood = _json["minLikelihood"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (excludeTypes != null) {
      _json["excludeTypes"] = excludeTypes;
    }
    if (includeQuote != null) {
      _json["includeQuote"] = includeQuote;
    }
    if (infoTypeLimits != null) {
      _json["infoTypeLimits"] =
          infoTypeLimits.map((value) => (value).toJson()).toList();
    }
    if (infoTypes != null) {
      _json["infoTypes"] = infoTypes.map((value) => (value).toJson()).toList();
    }
    if (maxFindings != null) {
      _json["maxFindings"] = maxFindings;
    }
    if (minLikelihood != null) {
      _json["minLikelihood"] = minLikelihood;
    }
    return _json;
  }
}

/// Request to search for potentially sensitive info in a list of items.
class GooglePrivacyDlpV2beta1InspectContentRequest {
  /// Configuration for the inspector.
  GooglePrivacyDlpV2beta1InspectConfig inspectConfig;

  /// The list of items to inspect. Items in a single request are
  /// considered "related" unless inspect_config.independent_inputs is true.
  /// Up to 100 are allowed per request.
  core.List<GooglePrivacyDlpV2beta1ContentItem> items;

  GooglePrivacyDlpV2beta1InspectContentRequest();

  GooglePrivacyDlpV2beta1InspectContentRequest.fromJson(core.Map _json) {
    if (_json.containsKey("inspectConfig")) {
      inspectConfig = new GooglePrivacyDlpV2beta1InspectConfig.fromJson(
          _json["inspectConfig"]);
    }
    if (_json.containsKey("items")) {
      items = _json["items"]
          .map(
              (value) => new GooglePrivacyDlpV2beta1ContentItem.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (inspectConfig != null) {
      _json["inspectConfig"] = (inspectConfig).toJson();
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Results of inspecting a list of items.
class GooglePrivacyDlpV2beta1InspectContentResponse {
  /// Each content_item from the request has a result in this list, in the
  /// same order as the request.
  core.List<GooglePrivacyDlpV2beta1InspectResult> results;

  GooglePrivacyDlpV2beta1InspectContentResponse();

  GooglePrivacyDlpV2beta1InspectContentResponse.fromJson(core.Map _json) {
    if (_json.containsKey("results")) {
      results = _json["results"]
          .map((value) =>
              new GooglePrivacyDlpV2beta1InspectResult.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (results != null) {
      _json["results"] = results.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Metadata returned within GetOperation for an inspect request.
class GooglePrivacyDlpV2beta1InspectOperationMetadata {
  /// The time which this request was started.
  core.String createTime;
  core.List<GooglePrivacyDlpV2beta1InfoTypeStatistics> infoTypeStats;

  /// Total size in bytes that were processed.
  core.String processedBytes;

  /// The inspect config used to create the Operation.
  GooglePrivacyDlpV2beta1InspectConfig requestInspectConfig;

  /// Optional location to store findings.
  GooglePrivacyDlpV2beta1OutputStorageConfig requestOutputConfig;

  /// The storage config used to create the Operation.
  GooglePrivacyDlpV2beta1StorageConfig requestStorageConfig;

  /// Estimate of the number of bytes to process.
  core.String totalEstimatedBytes;

  GooglePrivacyDlpV2beta1InspectOperationMetadata();

  GooglePrivacyDlpV2beta1InspectOperationMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("infoTypeStats")) {
      infoTypeStats = _json["infoTypeStats"]
          .map((value) =>
              new GooglePrivacyDlpV2beta1InfoTypeStatistics.fromJson(value))
          .toList();
    }
    if (_json.containsKey("processedBytes")) {
      processedBytes = _json["processedBytes"];
    }
    if (_json.containsKey("requestInspectConfig")) {
      requestInspectConfig = new GooglePrivacyDlpV2beta1InspectConfig.fromJson(
          _json["requestInspectConfig"]);
    }
    if (_json.containsKey("requestOutputConfig")) {
      requestOutputConfig =
          new GooglePrivacyDlpV2beta1OutputStorageConfig.fromJson(
              _json["requestOutputConfig"]);
    }
    if (_json.containsKey("requestStorageConfig")) {
      requestStorageConfig = new GooglePrivacyDlpV2beta1StorageConfig.fromJson(
          _json["requestStorageConfig"]);
    }
    if (_json.containsKey("totalEstimatedBytes")) {
      totalEstimatedBytes = _json["totalEstimatedBytes"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (infoTypeStats != null) {
      _json["infoTypeStats"] =
          infoTypeStats.map((value) => (value).toJson()).toList();
    }
    if (processedBytes != null) {
      _json["processedBytes"] = processedBytes;
    }
    if (requestInspectConfig != null) {
      _json["requestInspectConfig"] = (requestInspectConfig).toJson();
    }
    if (requestOutputConfig != null) {
      _json["requestOutputConfig"] = (requestOutputConfig).toJson();
    }
    if (requestStorageConfig != null) {
      _json["requestStorageConfig"] = (requestStorageConfig).toJson();
    }
    if (totalEstimatedBytes != null) {
      _json["totalEstimatedBytes"] = totalEstimatedBytes;
    }
    return _json;
  }
}

/// The operational data.
class GooglePrivacyDlpV2beta1InspectOperationResult {
  /// The server-assigned name, which is only unique within the same service
  /// that
  /// originally returns it. If you use the default HTTP mapping, the
  /// `name` should have the format of `inspect/results/{id}`.
  core.String name;

  GooglePrivacyDlpV2beta1InspectOperationResult();

  GooglePrivacyDlpV2beta1InspectOperationResult.fromJson(core.Map _json) {
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

/// All the findings for a single scanned item.
class GooglePrivacyDlpV2beta1InspectResult {
  /// List of findings for an item.
  core.List<GooglePrivacyDlpV2beta1Finding> findings;

  /// If true, then this item might have more findings than were returned,
  /// and the findings returned are an arbitrary subset of all findings.
  /// The findings list might be truncated because the input items were too
  /// large, or because the server reached the maximum amount of resources
  /// allowed for a single API call. For best results, divide the input into
  /// smaller batches.
  core.bool findingsTruncated;

  GooglePrivacyDlpV2beta1InspectResult();

  GooglePrivacyDlpV2beta1InspectResult.fromJson(core.Map _json) {
    if (_json.containsKey("findings")) {
      findings = _json["findings"]
          .map((value) => new GooglePrivacyDlpV2beta1Finding.fromJson(value))
          .toList();
    }
    if (_json.containsKey("findingsTruncated")) {
      findingsTruncated = _json["findingsTruncated"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (findings != null) {
      _json["findings"] = findings.map((value) => (value).toJson()).toList();
    }
    if (findingsTruncated != null) {
      _json["findingsTruncated"] = findingsTruncated;
    }
    return _json;
  }
}

/// A unique identifier for a Datastore entity.
/// If a key's partition ID or any of its path kinds or names are
/// reserved/read-only, the key is reserved/read-only.
/// A reserved/read-only key is forbidden in certain documented contexts.
class GooglePrivacyDlpV2beta1Key {
  /// Entities are partitioned into subsets, currently identified by a project
  /// ID and namespace ID.
  /// Queries are scoped to a single partition.
  GooglePrivacyDlpV2beta1PartitionId partitionId;

  /// The entity path.
  /// An entity path consists of one or more elements composed of a kind and a
  /// string or numerical identifier, which identify entities. The first
  /// element identifies a _root entity_, the second element identifies
  /// a _child_ of the root entity, the third element identifies a child of the
  /// second entity, and so forth. The entities identified by all prefixes of
  /// the path are called the element's _ancestors_.
  ///
  /// A path can never be empty, and a path can have at most 100 elements.
  core.List<GooglePrivacyDlpV2beta1PathElement> path;

  GooglePrivacyDlpV2beta1Key();

  GooglePrivacyDlpV2beta1Key.fromJson(core.Map _json) {
    if (_json.containsKey("partitionId")) {
      partitionId =
          new GooglePrivacyDlpV2beta1PartitionId.fromJson(_json["partitionId"]);
    }
    if (_json.containsKey("path")) {
      path = _json["path"]
          .map(
              (value) => new GooglePrivacyDlpV2beta1PathElement.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (partitionId != null) {
      _json["partitionId"] = (partitionId).toJson();
    }
    if (path != null) {
      _json["path"] = path.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A representation of a Datastore kind.
class GooglePrivacyDlpV2beta1KindExpression {
  /// The name of the kind.
  core.String name;

  GooglePrivacyDlpV2beta1KindExpression();

  GooglePrivacyDlpV2beta1KindExpression.fromJson(core.Map _json) {
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

/// Response to the ListInfoTypes request.
class GooglePrivacyDlpV2beta1ListInfoTypesResponse {
  /// Set of sensitive info types belonging to a category.
  core.List<GooglePrivacyDlpV2beta1InfoTypeDescription> infoTypes;

  GooglePrivacyDlpV2beta1ListInfoTypesResponse();

  GooglePrivacyDlpV2beta1ListInfoTypesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("infoTypes")) {
      infoTypes = _json["infoTypes"]
          .map((value) =>
              new GooglePrivacyDlpV2beta1InfoTypeDescription.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (infoTypes != null) {
      _json["infoTypes"] = infoTypes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Response to the ListInspectFindings request.
class GooglePrivacyDlpV2beta1ListInspectFindingsResponse {
  /// If not empty, indicates that there may be more results that match the
  /// request; this value should be passed in a new
  /// `ListInspectFindingsRequest`.
  core.String nextPageToken;

  /// The results.
  GooglePrivacyDlpV2beta1InspectResult result;

  GooglePrivacyDlpV2beta1ListInspectFindingsResponse();

  GooglePrivacyDlpV2beta1ListInspectFindingsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("result")) {
      result =
          new GooglePrivacyDlpV2beta1InspectResult.fromJson(_json["result"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (result != null) {
      _json["result"] = (result).toJson();
    }
    return _json;
  }
}

/// Response for ListRootCategories request.
class GooglePrivacyDlpV2beta1ListRootCategoriesResponse {
  /// List of all into type categories supported by the API.
  core.List<GooglePrivacyDlpV2beta1CategoryDescription> categories;

  GooglePrivacyDlpV2beta1ListRootCategoriesResponse();

  GooglePrivacyDlpV2beta1ListRootCategoriesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("categories")) {
      categories = _json["categories"]
          .map((value) =>
              new GooglePrivacyDlpV2beta1CategoryDescription.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (categories != null) {
      _json["categories"] =
          categories.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Specifies the location of a finding within its source item.
class GooglePrivacyDlpV2beta1Location {
  /// Zero-based byte offsets within a content item.
  GooglePrivacyDlpV2beta1Range byteRange;

  /// Character offsets within a content item, included when content type
  /// is a text. Default charset assumed to be UTF-8.
  GooglePrivacyDlpV2beta1Range codepointRange;

  /// Field id of the field containing the finding.
  GooglePrivacyDlpV2beta1FieldId fieldId;

  /// Location within an image's pixels.
  core.List<GooglePrivacyDlpV2beta1ImageLocation> imageBoxes;

  /// Key of the finding.
  GooglePrivacyDlpV2beta1RecordKey recordKey;

  /// Location within a `ContentItem.Table`.
  GooglePrivacyDlpV2beta1TableLocation tableLocation;

  GooglePrivacyDlpV2beta1Location();

  GooglePrivacyDlpV2beta1Location.fromJson(core.Map _json) {
    if (_json.containsKey("byteRange")) {
      byteRange = new GooglePrivacyDlpV2beta1Range.fromJson(_json["byteRange"]);
    }
    if (_json.containsKey("codepointRange")) {
      codepointRange =
          new GooglePrivacyDlpV2beta1Range.fromJson(_json["codepointRange"]);
    }
    if (_json.containsKey("fieldId")) {
      fieldId = new GooglePrivacyDlpV2beta1FieldId.fromJson(_json["fieldId"]);
    }
    if (_json.containsKey("imageBoxes")) {
      imageBoxes = _json["imageBoxes"]
          .map((value) =>
              new GooglePrivacyDlpV2beta1ImageLocation.fromJson(value))
          .toList();
    }
    if (_json.containsKey("recordKey")) {
      recordKey =
          new GooglePrivacyDlpV2beta1RecordKey.fromJson(_json["recordKey"]);
    }
    if (_json.containsKey("tableLocation")) {
      tableLocation = new GooglePrivacyDlpV2beta1TableLocation.fromJson(
          _json["tableLocation"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (byteRange != null) {
      _json["byteRange"] = (byteRange).toJson();
    }
    if (codepointRange != null) {
      _json["codepointRange"] = (codepointRange).toJson();
    }
    if (fieldId != null) {
      _json["fieldId"] = (fieldId).toJson();
    }
    if (imageBoxes != null) {
      _json["imageBoxes"] =
          imageBoxes.map((value) => (value).toJson()).toList();
    }
    if (recordKey != null) {
      _json["recordKey"] = (recordKey).toJson();
    }
    if (tableLocation != null) {
      _json["tableLocation"] = (tableLocation).toJson();
    }
    return _json;
  }
}

/// Additional configuration for inspect long running operations.
class GooglePrivacyDlpV2beta1OperationConfig {
  /// Max number of findings per file, Datastore entity, or database row.
  core.String maxItemFindings;

  GooglePrivacyDlpV2beta1OperationConfig();

  GooglePrivacyDlpV2beta1OperationConfig.fromJson(core.Map _json) {
    if (_json.containsKey("maxItemFindings")) {
      maxItemFindings = _json["maxItemFindings"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (maxItemFindings != null) {
      _json["maxItemFindings"] = maxItemFindings;
    }
    return _json;
  }
}

/// Cloud repository for storing output.
class GooglePrivacyDlpV2beta1OutputStorageConfig {
  /// The path to a Google Cloud Storage location to store output.
  GooglePrivacyDlpV2beta1CloudStoragePath storagePath;

  /// Store findings in a new table in the dataset.
  GooglePrivacyDlpV2beta1BigQueryTable table;

  GooglePrivacyDlpV2beta1OutputStorageConfig();

  GooglePrivacyDlpV2beta1OutputStorageConfig.fromJson(core.Map _json) {
    if (_json.containsKey("storagePath")) {
      storagePath = new GooglePrivacyDlpV2beta1CloudStoragePath.fromJson(
          _json["storagePath"]);
    }
    if (_json.containsKey("table")) {
      table = new GooglePrivacyDlpV2beta1BigQueryTable.fromJson(_json["table"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (storagePath != null) {
      _json["storagePath"] = (storagePath).toJson();
    }
    if (table != null) {
      _json["table"] = (table).toJson();
    }
    return _json;
  }
}

/// Datastore partition ID.
/// A partition ID identifies a grouping of entities. The grouping is always
/// by project and namespace, however the namespace ID may be empty.
///
/// A partition ID contains several dimensions:
/// project ID and namespace ID.
class GooglePrivacyDlpV2beta1PartitionId {
  /// If not empty, the ID of the namespace to which the entities belong.
  core.String namespaceId;

  /// The ID of the project to which the entities belong.
  core.String projectId;

  GooglePrivacyDlpV2beta1PartitionId();

  GooglePrivacyDlpV2beta1PartitionId.fromJson(core.Map _json) {
    if (_json.containsKey("namespaceId")) {
      namespaceId = _json["namespaceId"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (namespaceId != null) {
      _json["namespaceId"] = namespaceId;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    return _json;
  }
}

/// A (kind, ID/name) pair used to construct a key path.
///
/// If either name or ID is set, the element is complete.
/// If neither is set, the element is incomplete.
class GooglePrivacyDlpV2beta1PathElement {
  /// The auto-allocated ID of the entity.
  /// Never equal to zero. Values less than zero are discouraged and may not
  /// be supported in the future.
  core.String id;

  /// The kind of the entity.
  /// A kind matching regex `__.*__` is reserved/read-only.
  /// A kind must not contain more than 1500 bytes when UTF-8 encoded.
  /// Cannot be `""`.
  core.String kind;

  /// The name of the entity.
  /// A name matching regex `__.*__` is reserved/read-only.
  /// A name must not be more than 1500 bytes when UTF-8 encoded.
  /// Cannot be `""`.
  core.String name;

  GooglePrivacyDlpV2beta1PathElement();

  GooglePrivacyDlpV2beta1PathElement.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/// A representation of a Datastore property in a projection.
class GooglePrivacyDlpV2beta1Projection {
  /// The property to project.
  GooglePrivacyDlpV2beta1PropertyReference property;

  GooglePrivacyDlpV2beta1Projection();

  GooglePrivacyDlpV2beta1Projection.fromJson(core.Map _json) {
    if (_json.containsKey("property")) {
      property = new GooglePrivacyDlpV2beta1PropertyReference.fromJson(
          _json["property"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (property != null) {
      _json["property"] = (property).toJson();
    }
    return _json;
  }
}

/// A reference to a property relative to the Datastore kind expressions.
class GooglePrivacyDlpV2beta1PropertyReference {
  /// The name of the property.
  /// If name includes "."s, it may be interpreted as a property name path.
  core.String name;

  GooglePrivacyDlpV2beta1PropertyReference();

  GooglePrivacyDlpV2beta1PropertyReference.fromJson(core.Map _json) {
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

/// Generic half-open interval [start, end)
class GooglePrivacyDlpV2beta1Range {
  /// Index of the last character of the range (exclusive).
  core.String end;

  /// Index of the first character of the range (inclusive).
  core.String start;

  GooglePrivacyDlpV2beta1Range();

  GooglePrivacyDlpV2beta1Range.fromJson(core.Map _json) {
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (end != null) {
      _json["end"] = end;
    }
    if (start != null) {
      _json["start"] = start;
    }
    return _json;
  }
}

/// Message for a unique key indicating a record that contains a finding.
class GooglePrivacyDlpV2beta1RecordKey {
  GooglePrivacyDlpV2beta1CloudStorageKey cloudStorageKey;
  GooglePrivacyDlpV2beta1DatastoreKey datastoreKey;

  GooglePrivacyDlpV2beta1RecordKey();

  GooglePrivacyDlpV2beta1RecordKey.fromJson(core.Map _json) {
    if (_json.containsKey("cloudStorageKey")) {
      cloudStorageKey = new GooglePrivacyDlpV2beta1CloudStorageKey.fromJson(
          _json["cloudStorageKey"]);
    }
    if (_json.containsKey("datastoreKey")) {
      datastoreKey = new GooglePrivacyDlpV2beta1DatastoreKey.fromJson(
          _json["datastoreKey"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (cloudStorageKey != null) {
      _json["cloudStorageKey"] = (cloudStorageKey).toJson();
    }
    if (datastoreKey != null) {
      _json["datastoreKey"] = (datastoreKey).toJson();
    }
    return _json;
  }
}

/// Request to search for potentially sensitive info in a list of items
/// and replace it with a default or provided content.
class GooglePrivacyDlpV2beta1RedactContentRequest {
  /// The configuration for specifying what content to redact from images.
  core.List<GooglePrivacyDlpV2beta1ImageRedactionConfig> imageRedactionConfigs;

  /// Configuration for the inspector.
  GooglePrivacyDlpV2beta1InspectConfig inspectConfig;

  /// The list of items to inspect. Up to 100 are allowed per request.
  core.List<GooglePrivacyDlpV2beta1ContentItem> items;

  /// The strings to replace findings text findings with. Must specify at least
  /// one of these or one ImageRedactionConfig if redacting images.
  core.List<GooglePrivacyDlpV2beta1ReplaceConfig> replaceConfigs;

  GooglePrivacyDlpV2beta1RedactContentRequest();

  GooglePrivacyDlpV2beta1RedactContentRequest.fromJson(core.Map _json) {
    if (_json.containsKey("imageRedactionConfigs")) {
      imageRedactionConfigs = _json["imageRedactionConfigs"]
          .map((value) =>
              new GooglePrivacyDlpV2beta1ImageRedactionConfig.fromJson(value))
          .toList();
    }
    if (_json.containsKey("inspectConfig")) {
      inspectConfig = new GooglePrivacyDlpV2beta1InspectConfig.fromJson(
          _json["inspectConfig"]);
    }
    if (_json.containsKey("items")) {
      items = _json["items"]
          .map(
              (value) => new GooglePrivacyDlpV2beta1ContentItem.fromJson(value))
          .toList();
    }
    if (_json.containsKey("replaceConfigs")) {
      replaceConfigs = _json["replaceConfigs"]
          .map((value) =>
              new GooglePrivacyDlpV2beta1ReplaceConfig.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (imageRedactionConfigs != null) {
      _json["imageRedactionConfigs"] =
          imageRedactionConfigs.map((value) => (value).toJson()).toList();
    }
    if (inspectConfig != null) {
      _json["inspectConfig"] = (inspectConfig).toJson();
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (replaceConfigs != null) {
      _json["replaceConfigs"] =
          replaceConfigs.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Results of redacting a list of items.
class GooglePrivacyDlpV2beta1RedactContentResponse {
  /// The redacted content.
  core.List<GooglePrivacyDlpV2beta1ContentItem> items;

  GooglePrivacyDlpV2beta1RedactContentResponse();

  GooglePrivacyDlpV2beta1RedactContentResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"]
          .map(
              (value) => new GooglePrivacyDlpV2beta1ContentItem.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class GooglePrivacyDlpV2beta1ReplaceConfig {
  /// Type of information to replace. Only one ReplaceConfig per info_type
  /// should be provided. If ReplaceConfig does not have an info_type, the DLP
  /// API matches it against all info_types that are found but not specified in
  /// another ReplaceConfig.
  GooglePrivacyDlpV2beta1InfoType infoType;

  /// Content replacing sensitive information of given type. Max 256 chars.
  core.String replaceWith;

  GooglePrivacyDlpV2beta1ReplaceConfig();

  GooglePrivacyDlpV2beta1ReplaceConfig.fromJson(core.Map _json) {
    if (_json.containsKey("infoType")) {
      infoType =
          new GooglePrivacyDlpV2beta1InfoType.fromJson(_json["infoType"]);
    }
    if (_json.containsKey("replaceWith")) {
      replaceWith = _json["replaceWith"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (infoType != null) {
      _json["infoType"] = (infoType).toJson();
    }
    if (replaceWith != null) {
      _json["replaceWith"] = replaceWith;
    }
    return _json;
  }
}

class GooglePrivacyDlpV2beta1Row {
  core.List<GooglePrivacyDlpV2beta1Value> values;

  GooglePrivacyDlpV2beta1Row();

  GooglePrivacyDlpV2beta1Row.fromJson(core.Map _json) {
    if (_json.containsKey("values")) {
      values = _json["values"]
          .map((value) => new GooglePrivacyDlpV2beta1Value.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (values != null) {
      _json["values"] = values.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Shared message indicating Cloud storage type.
class GooglePrivacyDlpV2beta1StorageConfig {
  /// BigQuery options specification.
  GooglePrivacyDlpV2beta1BigQueryOptions bigQueryOptions;

  /// Google Cloud Storage options specification.
  GooglePrivacyDlpV2beta1CloudStorageOptions cloudStorageOptions;

  /// Google Cloud Datastore options specification.
  GooglePrivacyDlpV2beta1DatastoreOptions datastoreOptions;

  GooglePrivacyDlpV2beta1StorageConfig();

  GooglePrivacyDlpV2beta1StorageConfig.fromJson(core.Map _json) {
    if (_json.containsKey("bigQueryOptions")) {
      bigQueryOptions = new GooglePrivacyDlpV2beta1BigQueryOptions.fromJson(
          _json["bigQueryOptions"]);
    }
    if (_json.containsKey("cloudStorageOptions")) {
      cloudStorageOptions =
          new GooglePrivacyDlpV2beta1CloudStorageOptions.fromJson(
              _json["cloudStorageOptions"]);
    }
    if (_json.containsKey("datastoreOptions")) {
      datastoreOptions = new GooglePrivacyDlpV2beta1DatastoreOptions.fromJson(
          _json["datastoreOptions"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (bigQueryOptions != null) {
      _json["bigQueryOptions"] = (bigQueryOptions).toJson();
    }
    if (cloudStorageOptions != null) {
      _json["cloudStorageOptions"] = (cloudStorageOptions).toJson();
    }
    if (datastoreOptions != null) {
      _json["datastoreOptions"] = (datastoreOptions).toJson();
    }
    return _json;
  }
}

/// Structured content to inspect. Up to 50,000 `Value`s per request allowed.
class GooglePrivacyDlpV2beta1Table {
  core.List<GooglePrivacyDlpV2beta1FieldId> headers;
  core.List<GooglePrivacyDlpV2beta1Row> rows;

  GooglePrivacyDlpV2beta1Table();

  GooglePrivacyDlpV2beta1Table.fromJson(core.Map _json) {
    if (_json.containsKey("headers")) {
      headers = _json["headers"]
          .map((value) => new GooglePrivacyDlpV2beta1FieldId.fromJson(value))
          .toList();
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"]
          .map((value) => new GooglePrivacyDlpV2beta1Row.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (headers != null) {
      _json["headers"] = headers.map((value) => (value).toJson()).toList();
    }
    if (rows != null) {
      _json["rows"] = rows.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Location of a finding within a `ContentItem.Table`.
class GooglePrivacyDlpV2beta1TableLocation {
  /// The zero-based index of the row where the finding is located.
  core.String rowIndex;

  GooglePrivacyDlpV2beta1TableLocation();

  GooglePrivacyDlpV2beta1TableLocation.fromJson(core.Map _json) {
    if (_json.containsKey("rowIndex")) {
      rowIndex = _json["rowIndex"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (rowIndex != null) {
      _json["rowIndex"] = rowIndex;
    }
    return _json;
  }
}

/// Set of primitive values supported by the system.
class GooglePrivacyDlpV2beta1Value {
  core.bool booleanValue;
  GoogleTypeDate dateValue;
  core.double floatValue;
  core.String integerValue;
  core.String stringValue;
  GoogleTypeTimeOfDay timeValue;
  core.String timestampValue;

  GooglePrivacyDlpV2beta1Value();

  GooglePrivacyDlpV2beta1Value.fromJson(core.Map _json) {
    if (_json.containsKey("booleanValue")) {
      booleanValue = _json["booleanValue"];
    }
    if (_json.containsKey("dateValue")) {
      dateValue = new GoogleTypeDate.fromJson(_json["dateValue"]);
    }
    if (_json.containsKey("floatValue")) {
      floatValue = _json["floatValue"];
    }
    if (_json.containsKey("integerValue")) {
      integerValue = _json["integerValue"];
    }
    if (_json.containsKey("stringValue")) {
      stringValue = _json["stringValue"];
    }
    if (_json.containsKey("timeValue")) {
      timeValue = new GoogleTypeTimeOfDay.fromJson(_json["timeValue"]);
    }
    if (_json.containsKey("timestampValue")) {
      timestampValue = _json["timestampValue"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (booleanValue != null) {
      _json["booleanValue"] = booleanValue;
    }
    if (dateValue != null) {
      _json["dateValue"] = (dateValue).toJson();
    }
    if (floatValue != null) {
      _json["floatValue"] = floatValue;
    }
    if (integerValue != null) {
      _json["integerValue"] = integerValue;
    }
    if (stringValue != null) {
      _json["stringValue"] = stringValue;
    }
    if (timeValue != null) {
      _json["timeValue"] = (timeValue).toJson();
    }
    if (timestampValue != null) {
      _json["timestampValue"] = timestampValue;
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
class GoogleProtobufEmpty {
  GoogleProtobufEmpty();

  GoogleProtobufEmpty.fromJson(core.Map _json) {}

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    return _json;
  }
}

/// The `Status` type defines a logical error model that is suitable for
/// different
/// programming environments, including REST APIs and RPC APIs. It is used by
/// [gRPC](https://github.com/grpc). The error model is designed to be:
///
/// - Simple to use and understand for most users
/// - Flexible enough to meet unexpected needs
///
/// # Overview
///
/// The `Status` message contains three pieces of data: error code, error
/// message,
/// and error details. The error code should be an enum value of
/// google.rpc.Code, but it may accept additional error codes if needed.  The
/// error message should be a developer-facing English message that helps
/// developers *understand* and *resolve* the error. If a localized user-facing
/// error message is needed, put the localized message in the error details or
/// localize it in the client. The optional error details may contain arbitrary
/// information about the error. There is a predefined set of error detail types
/// in the package `google.rpc` that can be used for common error conditions.
///
/// # Language mapping
///
/// The `Status` message is the logical representation of the error model, but
/// it
/// is not necessarily the actual wire format. When the `Status` message is
/// exposed in different client libraries and different wire protocols, it can
/// be
/// mapped differently. For example, it will likely be mapped to some exceptions
/// in Java, but more likely mapped to some error codes in C.
///
/// # Other uses
///
/// The error model and the `Status` message can be used in a variety of
/// environments, either with or without APIs, to provide a
/// consistent developer experience across different environments.
///
/// Example uses of this error model include:
///
/// - Partial errors. If a service needs to return partial errors to the client,
/// it may embed the `Status` in the normal response to indicate the partial
///     errors.
///
/// - Workflow errors. A typical workflow has multiple steps. Each step may
///     have a `Status` message for error reporting.
///
/// - Batch operations. If a client uses batch request and batch response, the
///     `Status` message should be used directly inside batch response, one for
///     each error sub-response.
///
/// - Asynchronous operations. If an API call embeds asynchronous operation
///     results in its response, the status of those operations should be
///     represented directly using the `Status` message.
///
/// - Logging. If some API errors are stored in logs, the message `Status` could
/// be used directly after any stripping needed for security/privacy reasons.
class GoogleRpcStatus {
  /// The status code, which should be an enum value of google.rpc.Code.
  core.int code;

  /// A list of messages that carry the error details.  There is a common set of
  /// message types for APIs to use.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.List<core.Map<core.String, core.Object>> details;

  /// A developer-facing error message, which should be in English. Any
  /// user-facing error message should be localized and sent in the
  /// google.rpc.Status.details field, or localized by the client.
  core.String message;

  GoogleRpcStatus();

  GoogleRpcStatus.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("details")) {
      details = _json["details"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (code != null) {
      _json["code"] = code;
    }
    if (details != null) {
      _json["details"] = details;
    }
    if (message != null) {
      _json["message"] = message;
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
class GoogleTypeDate {
  /// Day of month. Must be from 1 to 31 and valid for the year and month, or 0
  /// if specifying a year/month where the day is not significant.
  core.int day;

  /// Month of year. Must be from 1 to 12.
  core.int month;

  /// Year of date. Must be from 1 to 9999, or 0 if specifying a date without
  /// a year.
  core.int year;

  GoogleTypeDate();

  GoogleTypeDate.fromJson(core.Map _json) {
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

/// Represents a time of day. The date and time zone are either not significant
/// or are specified elsewhere. An API may choose to allow leap seconds. Related
/// types are google.type.Date and `google.protobuf.Timestamp`.
class GoogleTypeTimeOfDay {
  /// Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
  /// to allow the value "24:00:00" for scenarios like business closing time.
  core.int hours;

  /// Minutes of hour of day. Must be from 0 to 59.
  core.int minutes;

  /// Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.
  core.int nanos;

  /// Seconds of minutes of the time. Must normally be from 0 to 59. An API may
  /// allow the value 60 if it allows leap-seconds.
  core.int seconds;

  GoogleTypeTimeOfDay();

  GoogleTypeTimeOfDay.fromJson(core.Map _json) {
    if (_json.containsKey("hours")) {
      hours = _json["hours"];
    }
    if (_json.containsKey("minutes")) {
      minutes = _json["minutes"];
    }
    if (_json.containsKey("nanos")) {
      nanos = _json["nanos"];
    }
    if (_json.containsKey("seconds")) {
      seconds = _json["seconds"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (hours != null) {
      _json["hours"] = hours;
    }
    if (minutes != null) {
      _json["minutes"] = minutes;
    }
    if (nanos != null) {
      _json["nanos"] = nanos;
    }
    if (seconds != null) {
      _json["seconds"] = seconds;
    }
    return _json;
  }
}
