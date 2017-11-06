// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.speech.v1beta1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client speech/v1beta1';

/// Converts audio to text by applying powerful neural network models.
class SpeechApi {
  /// View and manage your data across Google Cloud Platform services
  static const CloudPlatformScope =
      "https://www.googleapis.com/auth/cloud-platform";

  final commons.ApiRequester _requester;

  OperationsResourceApi get operations => new OperationsResourceApi(_requester);
  SpeechResourceApi get speech => new SpeechResourceApi(_requester);

  SpeechApi(http.Client client,
      {core.String rootUrl: "https://speech.googleapis.com/",
      core.String servicePath: ""})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class OperationsResourceApi {
  final commons.ApiRequester _requester;

  OperationsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Starts asynchronous cancellation on a long-running operation.  The server
  /// makes a best effort to cancel the operation, but success is not
  /// guaranteed.  If the server doesn't support this method, it returns
  /// `google.rpc.Code.UNIMPLEMENTED`.  Clients can use
  /// Operations.GetOperation or
  /// other methods to check whether the cancellation succeeded or whether the
  /// operation completed despite cancellation. On successful cancellation,
  /// the operation is not deleted; instead, it becomes an operation with
  /// an Operation.error value with a google.rpc.Status.code of 1,
  /// corresponding to `Code.CANCELLED`.
  ///
  /// Request parameters:
  ///
  /// [name] - The name of the operation resource to be cancelled.
  /// Value must have pattern "^[^/]+$".
  ///
  /// Completes with a [Empty].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Empty> cancel(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url = 'v1beta1/operations/' +
        commons.Escaper.ecapeVariableReserved('$name') +
        ':cancel';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /// Deletes a long-running operation. This method indicates that the client is
  /// no longer interested in the operation result. It does not cancel the
  /// operation. If the server doesn't support this method, it returns
  /// `google.rpc.Code.UNIMPLEMENTED`.
  ///
  /// Request parameters:
  ///
  /// [name] - The name of the operation resource to be deleted.
  /// Value must have pattern "^[^/]+$".
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

    _url =
        'v1beta1/operations/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /// Gets the latest state of a long-running operation.  Clients can use this
  /// method to poll the operation result at intervals as recommended by the API
  /// service.
  ///
  /// Request parameters:
  ///
  /// [name] - The name of the operation resource.
  /// Value must have pattern "^[^/]+$".
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> get(core.String name) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }

    _url =
        'v1beta1/operations/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Lists operations that match the specified filter in the request. If the
  /// server doesn't support this method, it returns `UNIMPLEMENTED`.
  ///
  /// NOTE: the `name` binding allows API services to override the binding
  /// to use different resource name schemes, such as `users / * /operations`.
  /// To
  /// override the binding, API services can add a binding such as
  /// `"/v1/{name=users / * }/operations"` to their service configuration.
  /// For backwards compatibility, the default name includes the operations
  /// collection id, however overriding users must ensure the name binding
  /// is the parent resource, without the operations collection id.
  ///
  /// Request parameters:
  ///
  /// [filter] - The standard list filter.
  ///
  /// [pageToken] - The standard list page token.
  ///
  /// [name] - The name of the operation's parent resource.
  ///
  /// [pageSize] - The standard list page size.
  ///
  /// Completes with a [ListOperationsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListOperationsResponse> list(
      {core.String filter,
      core.String pageToken,
      core.String name,
      core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (name != null) {
      _queryParams["name"] = [name];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1beta1/operations';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ListOperationsResponse.fromJson(data));
  }
}

class SpeechResourceApi {
  final commons.ApiRequester _requester;

  SpeechResourceApi(commons.ApiRequester client) : _requester = client;

  /// Performs asynchronous speech recognition: receive results via the
  /// [google.longrunning.Operations]
  /// (/speech/reference/rest/v1beta1/operations#Operation)
  /// interface. Returns either an
  /// `Operation.error` or an `Operation.response` which contains
  /// an `AsyncRecognizeResponse` message.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// Completes with a [Operation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Operation> asyncrecognize(AsyncRecognizeRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1beta1/speech:asyncrecognize';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /// Performs synchronous speech recognition: receive results after all audio
  /// has been sent and processed.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// Completes with a [SyncRecognizeResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SyncRecognizeResponse> syncrecognize(
      SyncRecognizeRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1beta1/speech:syncrecognize';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new SyncRecognizeResponse.fromJson(data));
  }
}

/// The top-level message sent by the client for the `AsyncRecognize` method.
class AsyncRecognizeRequest {
  /// *Required* The audio data to be recognized.
  RecognitionAudio audio;

  /// *Required* Provides information to the recognizer that specifies how to
  /// process the request.
  RecognitionConfig config;

  AsyncRecognizeRequest();

  AsyncRecognizeRequest.fromJson(core.Map _json) {
    if (_json.containsKey("audio")) {
      audio = new RecognitionAudio.fromJson(_json["audio"]);
    }
    if (_json.containsKey("config")) {
      config = new RecognitionConfig.fromJson(_json["config"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (audio != null) {
      _json["audio"] = (audio).toJson();
    }
    if (config != null) {
      _json["config"] = (config).toJson();
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
class Empty {
  Empty();

  Empty.fromJson(core.Map _json) {}

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    return _json;
  }
}

/// The response message for Operations.ListOperations.
class ListOperationsResponse {
  /// The standard List next-page token.
  core.String nextPageToken;

  /// A list of operations that matches the specified filter in the request.
  core.List<Operation> operations;

  ListOperationsResponse();

  ListOperationsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("operations")) {
      operations = _json["operations"]
          .map((value) => new Operation.fromJson(value))
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
class Operation {
  /// If the value is `false`, it means the operation is still in progress.
  /// If `true`, the operation is completed, and either `error` or `response` is
  /// available.
  core.bool done;

  /// The error result of the operation in case of failure or cancellation.
  Status error;

  /// Service-specific metadata associated with the operation.  It typically
  /// contains progress information and common metadata such as create time.
  /// Some services might not provide such metadata.  Any method that returns a
  /// long-running operation should document the metadata type, if any.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> metadata;

  /// The server-assigned name, which is only unique within the same service
  /// that
  /// originally returns it. If you use the default HTTP mapping, the
  /// `name` should have the format of `operations/some/unique/name`.
  core.String name;

  /// The normal response of the operation in case of success.  If the original
  /// method returns no data on success, such as `Delete`, the response is
  /// `google.protobuf.Empty`.  If the original method is standard
  /// `Get`/`Create`/`Update`, the response should be the resource.  For other
  /// methods, the response should have the type `XxxResponse`, where `Xxx`
  /// is the original method name.  For example, if the original method name
  /// is `TakeSnapshot()`, the inferred response type is
  /// `TakeSnapshotResponse`.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object> response;

  Operation();

  Operation.fromJson(core.Map _json) {
    if (_json.containsKey("done")) {
      done = _json["done"];
    }
    if (_json.containsKey("error")) {
      error = new Status.fromJson(_json["error"]);
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

/// Contains audio data in the encoding specified in the `RecognitionConfig`.
/// Either `content` or `uri` must be supplied. Supplying both or neither
/// returns google.rpc.Code.INVALID_ARGUMENT. See
/// [audio limits](https://cloud.google.com/speech/limits#content).
class RecognitionAudio {
  /// The audio data bytes encoded as specified in
  /// `RecognitionConfig`. Note: as with all bytes fields, protobuffers use a
  /// pure binary representation, whereas JSON representations use base64.
  core.String content;
  core.List<core.int> get contentAsBytes {
    return convert.BASE64.decode(content);
  }

  void set contentAsBytes(core.List<core.int> _bytes) {
    content =
        convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  /// URI that points to a file that contains audio data bytes as specified in
  /// `RecognitionConfig`. Currently, only Google Cloud Storage URIs are
  /// supported, which must be specified in the following format:
  /// `gs://bucket_name/object_name` (other URI formats return
  /// google.rpc.Code.INVALID_ARGUMENT). For more information, see
  /// [Request URIs](https://cloud.google.com/storage/docs/reference-uris).
  core.String uri;

  RecognitionAudio();

  RecognitionAudio.fromJson(core.Map _json) {
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("uri")) {
      uri = _json["uri"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (content != null) {
      _json["content"] = content;
    }
    if (uri != null) {
      _json["uri"] = uri;
    }
    return _json;
  }
}

/// Provides information to the recognizer that specifies how to process the
/// request.
class RecognitionConfig {
  /// *Required* Encoding of audio data sent in all `RecognitionAudio` messages.
  /// Possible string values are:
  /// - "ENCODING_UNSPECIFIED" : Not specified. Will return result
  /// google.rpc.Code.INVALID_ARGUMENT.
  /// - "LINEAR16" : Uncompressed 16-bit signed little-endian samples (Linear
  /// PCM).
  /// This is the only encoding that may be used by `AsyncRecognize`.
  /// - "FLAC" : This is the recommended encoding for `SyncRecognize` and
  /// `StreamingRecognize` because it uses lossless compression; therefore
  /// recognition accuracy is not compromised by a lossy codec.
  ///
  /// The stream FLAC (Free Lossless Audio Codec) encoding is specified at:
  /// http://flac.sourceforge.net/documentation.html.
  /// 16-bit and 24-bit samples are supported.
  /// Not all fields in STREAMINFO are supported.
  /// - "MULAW" : 8-bit samples that compand 14-bit audio samples using G.711
  /// PCMU/mu-law.
  /// - "AMR" : Adaptive Multi-Rate Narrowband codec. `sample_rate` must be 8000
  /// Hz.
  /// - "AMR_WB" : Adaptive Multi-Rate Wideband codec. `sample_rate` must be
  /// 16000 Hz.
  core.String encoding;

  /// *Optional* The language of the supplied audio as a BCP-47 language tag.
  /// Example: "en-GB"  https://www.rfc-editor.org/rfc/bcp/bcp47.txt
  /// If omitted, defaults to "en-US". See
  /// [Language Support](https://cloud.google.com/speech/docs/languages)
  /// for a list of the currently supported language codes.
  core.String languageCode;

  /// *Optional* Maximum number of recognition hypotheses to be returned.
  /// Specifically, the maximum number of `SpeechRecognitionAlternative`
  /// messages
  /// within each `SpeechRecognitionResult`.
  /// The server may return fewer than `max_alternatives`.
  /// Valid values are `0`-`30`. A value of `0` or `1` will return a maximum of
  /// one. If omitted, will return a maximum of one.
  core.int maxAlternatives;

  /// *Optional* If set to `true`, the server will attempt to filter out
  /// profanities, replacing all but the initial character in each filtered word
  /// with asterisks, e.g. "f***". If set to `false` or omitted, profanities
  /// won't be filtered out.
  core.bool profanityFilter;

  /// *Required* Sample rate in Hertz of the audio data sent in all
  /// `RecognitionAudio` messages. Valid values are: 8000-48000.
  /// 16000 is optimal. For best results, set the sampling rate of the audio
  /// source to 16000 Hz. If that's not possible, use the native sample rate of
  /// the audio source (instead of re-sampling).
  core.int sampleRate;

  /// *Optional* A means to provide context to assist the speech recognition.
  SpeechContext speechContext;

  RecognitionConfig();

  RecognitionConfig.fromJson(core.Map _json) {
    if (_json.containsKey("encoding")) {
      encoding = _json["encoding"];
    }
    if (_json.containsKey("languageCode")) {
      languageCode = _json["languageCode"];
    }
    if (_json.containsKey("maxAlternatives")) {
      maxAlternatives = _json["maxAlternatives"];
    }
    if (_json.containsKey("profanityFilter")) {
      profanityFilter = _json["profanityFilter"];
    }
    if (_json.containsKey("sampleRate")) {
      sampleRate = _json["sampleRate"];
    }
    if (_json.containsKey("speechContext")) {
      speechContext = new SpeechContext.fromJson(_json["speechContext"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (encoding != null) {
      _json["encoding"] = encoding;
    }
    if (languageCode != null) {
      _json["languageCode"] = languageCode;
    }
    if (maxAlternatives != null) {
      _json["maxAlternatives"] = maxAlternatives;
    }
    if (profanityFilter != null) {
      _json["profanityFilter"] = profanityFilter;
    }
    if (sampleRate != null) {
      _json["sampleRate"] = sampleRate;
    }
    if (speechContext != null) {
      _json["speechContext"] = (speechContext).toJson();
    }
    return _json;
  }
}

/// Provides "hints" to the speech recognizer to favor specific words and
/// phrases
/// in the results.
class SpeechContext {
  /// *Optional* A list of strings containing words and phrases "hints" so that
  /// the speech recognition is more likely to recognize them. This can be used
  /// to improve the accuracy for specific words and phrases, for example, if
  /// specific commands are typically spoken by the user. This can also be used
  /// to add additional words to the vocabulary of the recognizer. See
  /// [usage limits](https://cloud.google.com/speech/limits#content).
  core.List<core.String> phrases;

  SpeechContext();

  SpeechContext.fromJson(core.Map _json) {
    if (_json.containsKey("phrases")) {
      phrases = _json["phrases"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (phrases != null) {
      _json["phrases"] = phrases;
    }
    return _json;
  }
}

/// Alternative hypotheses (a.k.a. n-best list).
class SpeechRecognitionAlternative {
  /// *Output-only* The confidence estimate between 0.0 and 1.0. A higher number
  /// indicates an estimated greater likelihood that the recognized words are
  /// correct. This field is typically provided only for the top hypothesis, and
  /// only for `is_final=true` results. Clients should not rely on the
  /// `confidence` field as it is not guaranteed to be accurate, or even set, in
  /// any of the results.
  /// The default of 0.0 is a sentinel value indicating `confidence` was not
  /// set.
  core.double confidence;

  /// *Output-only* Transcript text representing the words that the user spoke.
  core.String transcript;

  SpeechRecognitionAlternative();

  SpeechRecognitionAlternative.fromJson(core.Map _json) {
    if (_json.containsKey("confidence")) {
      confidence = _json["confidence"];
    }
    if (_json.containsKey("transcript")) {
      transcript = _json["transcript"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (confidence != null) {
      _json["confidence"] = confidence;
    }
    if (transcript != null) {
      _json["transcript"] = transcript;
    }
    return _json;
  }
}

/// A speech recognition result corresponding to a portion of the audio.
class SpeechRecognitionResult {
  /// *Output-only* May contain one or more recognition hypotheses (up to the
  /// maximum specified in `max_alternatives`).
  core.List<SpeechRecognitionAlternative> alternatives;

  SpeechRecognitionResult();

  SpeechRecognitionResult.fromJson(core.Map _json) {
    if (_json.containsKey("alternatives")) {
      alternatives = _json["alternatives"]
          .map((value) => new SpeechRecognitionAlternative.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (alternatives != null) {
      _json["alternatives"] =
          alternatives.map((value) => (value).toJson()).toList();
    }
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
class Status {
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

  Status();

  Status.fromJson(core.Map _json) {
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

/// The top-level message sent by the client for the `SyncRecognize` method.
class SyncRecognizeRequest {
  /// *Required* The audio data to be recognized.
  RecognitionAudio audio;

  /// *Required* Provides information to the recognizer that specifies how to
  /// process the request.
  RecognitionConfig config;

  SyncRecognizeRequest();

  SyncRecognizeRequest.fromJson(core.Map _json) {
    if (_json.containsKey("audio")) {
      audio = new RecognitionAudio.fromJson(_json["audio"]);
    }
    if (_json.containsKey("config")) {
      config = new RecognitionConfig.fromJson(_json["config"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (audio != null) {
      _json["audio"] = (audio).toJson();
    }
    if (config != null) {
      _json["config"] = (config).toJson();
    }
    return _json;
  }
}

/// The only message returned to the client by `SyncRecognize`. method. It
/// contains the result as zero or more sequential `SpeechRecognitionResult`
/// messages.
class SyncRecognizeResponse {
  /// *Output-only* Sequential list of transcription results corresponding to
  /// sequential portions of audio.
  core.List<SpeechRecognitionResult> results;

  SyncRecognizeResponse();

  SyncRecognizeResponse.fromJson(core.Map _json) {
    if (_json.containsKey("results")) {
      results = _json["results"]
          .map((value) => new SpeechRecognitionResult.fromJson(value))
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
