// This is a generated file (see the discoveryapis_generator project).

library googleapis_beta.videointelligence.v1beta1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client videointelligence/v1beta1';

/// Google Cloud Video Intelligence API.
class VideointelligenceApi {
  /// View and manage your data across Google Cloud Platform services
  static const CloudPlatformScope =
      "https://www.googleapis.com/auth/cloud-platform";

  final commons.ApiRequester _requester;

  VideosResourceApi get videos => new VideosResourceApi(_requester);

  VideointelligenceApi(http.Client client,
      {core.String rootUrl: "https://videointelligence.googleapis.com/",
      core.String servicePath: ""})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class VideosResourceApi {
  final commons.ApiRequester _requester;

  VideosResourceApi(commons.ApiRequester client) : _requester = client;

  /// Performs asynchronous video annotation. Progress and results can be
  /// retrieved through the `google.longrunning.Operations` interface.
  /// `Operation.metadata` contains `AnnotateVideoProgress` (progress).
  /// `Operation.response` contains `AnnotateVideoResponse` (results).
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
  async.Future<GoogleLongrunningOperation> annotate(
      GoogleCloudVideointelligenceV1beta1AnnotateVideoRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1beta1/videos:annotate';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new GoogleLongrunningOperation.fromJson(data));
  }
}

/// Video annotation progress. Included in the `metadata`
/// field of the `Operation` returned by the `GetOperation`
/// call of the `google::longrunning::Operations` service.
class GoogleCloudVideointelligenceV1AnnotateVideoProgress {
  /// Progress metadata for all videos specified in `AnnotateVideoRequest`.
  core.List<GoogleCloudVideointelligenceV1VideoAnnotationProgress>
      annotationProgress;

  GoogleCloudVideointelligenceV1AnnotateVideoProgress();

  GoogleCloudVideointelligenceV1AnnotateVideoProgress.fromJson(core.Map _json) {
    if (_json.containsKey("annotationProgress")) {
      annotationProgress = _json["annotationProgress"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1VideoAnnotationProgress
                  .fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (annotationProgress != null) {
      _json["annotationProgress"] =
          annotationProgress.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Video annotation response. Included in the `response`
/// field of the `Operation` returned by the `GetOperation`
/// call of the `google::longrunning::Operations` service.
class GoogleCloudVideointelligenceV1AnnotateVideoResponse {
  /// Annotation results for all videos specified in `AnnotateVideoRequest`.
  core.List<GoogleCloudVideointelligenceV1VideoAnnotationResults>
      annotationResults;

  GoogleCloudVideointelligenceV1AnnotateVideoResponse();

  GoogleCloudVideointelligenceV1AnnotateVideoResponse.fromJson(core.Map _json) {
    if (_json.containsKey("annotationResults")) {
      annotationResults = _json["annotationResults"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1VideoAnnotationResults.fromJson(
                  value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (annotationResults != null) {
      _json["annotationResults"] =
          annotationResults.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Label annotation.
class GoogleCloudVideointelligenceV1LabelAnnotation {
  /// Textual description, e.g. `Fixed-gear bicycle`.
  core.String description;

  /// Language code for `description` in BCP-47 format.
  core.String languageCode;

  /// Where the label was detected and with what confidence.
  core.List<GoogleCloudVideointelligenceV1LabelLocation> locations;

  GoogleCloudVideointelligenceV1LabelAnnotation();

  GoogleCloudVideointelligenceV1LabelAnnotation.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("languageCode")) {
      languageCode = _json["languageCode"];
    }
    if (_json.containsKey("locations")) {
      locations = _json["locations"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1LabelLocation.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (description != null) {
      _json["description"] = description;
    }
    if (languageCode != null) {
      _json["languageCode"] = languageCode;
    }
    if (locations != null) {
      _json["locations"] = locations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Label location.
class GoogleCloudVideointelligenceV1LabelLocation {
  /// Confidence that the label is accurate. Range: [0, 1].
  core.double confidence;

  /// Label level.
  /// Possible string values are:
  /// - "LABEL_LEVEL_UNSPECIFIED" : Unspecified.
  /// - "VIDEO_LEVEL" : Video-level. Corresponds to the whole video.
  /// - "SEGMENT_LEVEL" : Segment-level. Corresponds to one of
  /// `AnnotateSpec.segments`.
  /// - "SHOT_LEVEL" : Shot-level. Corresponds to a single shot (i.e. a series
  /// of frames
  /// without a major camera position or background change).
  /// - "FRAME_LEVEL" : Frame-level. Corresponds to a single video frame.
  core.String level;

  /// Video segment. Unset for video-level labels.
  /// Set to a frame timestamp for frame-level labels.
  /// Otherwise, corresponds to one of `AnnotateSpec.segments`
  /// (if specified) or to shot boundaries (if requested).
  GoogleCloudVideointelligenceV1VideoSegment segment;

  GoogleCloudVideointelligenceV1LabelLocation();

  GoogleCloudVideointelligenceV1LabelLocation.fromJson(core.Map _json) {
    if (_json.containsKey("confidence")) {
      confidence = _json["confidence"];
    }
    if (_json.containsKey("level")) {
      level = _json["level"];
    }
    if (_json.containsKey("segment")) {
      segment = new GoogleCloudVideointelligenceV1VideoSegment.fromJson(
          _json["segment"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (confidence != null) {
      _json["confidence"] = confidence;
    }
    if (level != null) {
      _json["level"] = level;
    }
    if (segment != null) {
      _json["segment"] = (segment).toJson();
    }
    return _json;
  }
}

/// Safe search annotation (based on per-frame visual signals only).
/// If no unsafe content has been detected in a frame, no annotations
/// are present for that frame.
class GoogleCloudVideointelligenceV1SafeSearchAnnotation {
  /// Likelihood of adult content.
  /// Possible string values are:
  /// - "UNKNOWN" : Unknown likelihood.
  /// - "VERY_UNLIKELY" : Very unlikely.
  /// - "UNLIKELY" : Unlikely.
  /// - "POSSIBLE" : Possible.
  /// - "LIKELY" : Likely.
  /// - "VERY_LIKELY" : Very likely.
  core.String adult;

  /// Time-offset, relative to the beginning of the video,
  /// corresponding to the video frame for this annotation.
  core.String time;

  GoogleCloudVideointelligenceV1SafeSearchAnnotation();

  GoogleCloudVideointelligenceV1SafeSearchAnnotation.fromJson(core.Map _json) {
    if (_json.containsKey("adult")) {
      adult = _json["adult"];
    }
    if (_json.containsKey("time")) {
      time = _json["time"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (adult != null) {
      _json["adult"] = adult;
    }
    if (time != null) {
      _json["time"] = time;
    }
    return _json;
  }
}

/// Annotation progress for a single video.
class GoogleCloudVideointelligenceV1VideoAnnotationProgress {
  /// Video file location in
  /// [Google Cloud Storage](https://cloud.google.com/storage/).
  core.String inputUri;

  /// Approximate percentage processed thus far.
  /// Guaranteed to be 100 when fully processed.
  core.int progressPercent;

  /// Time when the request was received.
  core.String startTime;

  /// Time of the most recent update.
  core.String updateTime;

  GoogleCloudVideointelligenceV1VideoAnnotationProgress();

  GoogleCloudVideointelligenceV1VideoAnnotationProgress.fromJson(
      core.Map _json) {
    if (_json.containsKey("inputUri")) {
      inputUri = _json["inputUri"];
    }
    if (_json.containsKey("progressPercent")) {
      progressPercent = _json["progressPercent"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
    if (_json.containsKey("updateTime")) {
      updateTime = _json["updateTime"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (inputUri != null) {
      _json["inputUri"] = inputUri;
    }
    if (progressPercent != null) {
      _json["progressPercent"] = progressPercent;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    if (updateTime != null) {
      _json["updateTime"] = updateTime;
    }
    return _json;
  }
}

/// Annotation results for a single video.
class GoogleCloudVideointelligenceV1VideoAnnotationResults {
  /// If set, indicates an error. Note that for a single `AnnotateVideoRequest`
  /// some videos may succeed and some may fail.
  GoogleRpcStatus error;

  /// Video file location in
  /// [Google Cloud Storage](https://cloud.google.com/storage/).
  core.String inputUri;

  /// Label annotations. There is exactly one element for each unique label.
  core.List<GoogleCloudVideointelligenceV1LabelAnnotation> labelAnnotations;

  /// Safe search annotations.
  core.List<GoogleCloudVideointelligenceV1SafeSearchAnnotation>
      safeSearchAnnotations;

  /// Shot annotations. Each shot is represented as a video segment.
  core.List<GoogleCloudVideointelligenceV1VideoSegment> shotAnnotations;

  GoogleCloudVideointelligenceV1VideoAnnotationResults();

  GoogleCloudVideointelligenceV1VideoAnnotationResults.fromJson(
      core.Map _json) {
    if (_json.containsKey("error")) {
      error = new GoogleRpcStatus.fromJson(_json["error"]);
    }
    if (_json.containsKey("inputUri")) {
      inputUri = _json["inputUri"];
    }
    if (_json.containsKey("labelAnnotations")) {
      labelAnnotations = _json["labelAnnotations"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1LabelAnnotation.fromJson(value))
          .toList();
    }
    if (_json.containsKey("safeSearchAnnotations")) {
      safeSearchAnnotations = _json["safeSearchAnnotations"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1SafeSearchAnnotation.fromJson(
                  value))
          .toList();
    }
    if (_json.containsKey("shotAnnotations")) {
      shotAnnotations = _json["shotAnnotations"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1VideoSegment.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (error != null) {
      _json["error"] = (error).toJson();
    }
    if (inputUri != null) {
      _json["inputUri"] = inputUri;
    }
    if (labelAnnotations != null) {
      _json["labelAnnotations"] =
          labelAnnotations.map((value) => (value).toJson()).toList();
    }
    if (safeSearchAnnotations != null) {
      _json["safeSearchAnnotations"] =
          safeSearchAnnotations.map((value) => (value).toJson()).toList();
    }
    if (shotAnnotations != null) {
      _json["shotAnnotations"] =
          shotAnnotations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Video segment.
class GoogleCloudVideointelligenceV1VideoSegment {
  /// Time-offset, relative to the beginning of the video,
  /// corresponding to the end of the segment (inclusive).
  core.String endTime;

  /// Time-offset, relative to the beginning of the video,
  /// corresponding to the start of the segment (inclusive).
  core.String startTime;

  GoogleCloudVideointelligenceV1VideoSegment();

  GoogleCloudVideointelligenceV1VideoSegment.fromJson(core.Map _json) {
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

/// Video annotation progress. Included in the `metadata`
/// field of the `Operation` returned by the `GetOperation`
/// call of the `google::longrunning::Operations` service.
class GoogleCloudVideointelligenceV1beta1AnnotateVideoProgress {
  /// Progress metadata for all videos specified in `AnnotateVideoRequest`.
  core.List<GoogleCloudVideointelligenceV1beta1VideoAnnotationProgress>
      annotationProgress;

  GoogleCloudVideointelligenceV1beta1AnnotateVideoProgress();

  GoogleCloudVideointelligenceV1beta1AnnotateVideoProgress.fromJson(
      core.Map _json) {
    if (_json.containsKey("annotationProgress")) {
      annotationProgress = _json["annotationProgress"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta1VideoAnnotationProgress
                  .fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (annotationProgress != null) {
      _json["annotationProgress"] =
          annotationProgress.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Video annotation request.
class GoogleCloudVideointelligenceV1beta1AnnotateVideoRequest {
  /// Requested video annotation features.
  core.List<core.String> features;

  /// The video data bytes. Encoding: base64. If unset, the input video(s)
  /// should be specified via `input_uri`. If set, `input_uri` should be unset.
  core.String inputContent;

  /// Input video location. Currently, only
  /// [Google Cloud Storage](https://cloud.google.com/storage/) URIs are
  /// supported, which must be specified in the following format:
  /// `gs://bucket-id/object-id` (other URI formats return
  /// google.rpc.Code.INVALID_ARGUMENT). For more information, see
  /// [Request URIs](/storage/docs/reference-uris).
  /// A video URI may include wildcards in `object-id`, and thus identify
  /// multiple videos. Supported wildcards: '*' to match 0 or more characters;
  /// '?' to match 1 character. If unset, the input video should be embedded
  /// in the request as `input_content`. If set, `input_content` should be
  /// unset.
  core.String inputUri;

  /// Optional cloud region where annotation should take place. Supported cloud
  /// regions: `us-east1`, `us-west1`, `europe-west1`, `asia-east1`. If no
  /// region
  /// is specified, a region will be determined based on video file location.
  core.String locationId;

  /// Optional location where the output (in JSON format) should be stored.
  /// Currently, only [Google Cloud Storage](https://cloud.google.com/storage/)
  /// URIs are supported, which must be specified in the following format:
  /// `gs://bucket-id/object-id` (other URI formats return
  /// google.rpc.Code.INVALID_ARGUMENT). For more information, see
  /// [Request URIs](/storage/docs/reference-uris).
  core.String outputUri;

  /// Additional video context and/or feature-specific parameters.
  GoogleCloudVideointelligenceV1beta1VideoContext videoContext;

  GoogleCloudVideointelligenceV1beta1AnnotateVideoRequest();

  GoogleCloudVideointelligenceV1beta1AnnotateVideoRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey("features")) {
      features = _json["features"];
    }
    if (_json.containsKey("inputContent")) {
      inputContent = _json["inputContent"];
    }
    if (_json.containsKey("inputUri")) {
      inputUri = _json["inputUri"];
    }
    if (_json.containsKey("locationId")) {
      locationId = _json["locationId"];
    }
    if (_json.containsKey("outputUri")) {
      outputUri = _json["outputUri"];
    }
    if (_json.containsKey("videoContext")) {
      videoContext =
          new GoogleCloudVideointelligenceV1beta1VideoContext.fromJson(
              _json["videoContext"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (features != null) {
      _json["features"] = features;
    }
    if (inputContent != null) {
      _json["inputContent"] = inputContent;
    }
    if (inputUri != null) {
      _json["inputUri"] = inputUri;
    }
    if (locationId != null) {
      _json["locationId"] = locationId;
    }
    if (outputUri != null) {
      _json["outputUri"] = outputUri;
    }
    if (videoContext != null) {
      _json["videoContext"] = (videoContext).toJson();
    }
    return _json;
  }
}

/// Video annotation response. Included in the `response`
/// field of the `Operation` returned by the `GetOperation`
/// call of the `google::longrunning::Operations` service.
class GoogleCloudVideointelligenceV1beta1AnnotateVideoResponse {
  /// Annotation results for all videos specified in `AnnotateVideoRequest`.
  core.List<GoogleCloudVideointelligenceV1beta1VideoAnnotationResults>
      annotationResults;

  GoogleCloudVideointelligenceV1beta1AnnotateVideoResponse();

  GoogleCloudVideointelligenceV1beta1AnnotateVideoResponse.fromJson(
      core.Map _json) {
    if (_json.containsKey("annotationResults")) {
      annotationResults = _json["annotationResults"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta1VideoAnnotationResults
                  .fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (annotationResults != null) {
      _json["annotationResults"] =
          annotationResults.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Label annotation.
class GoogleCloudVideointelligenceV1beta1LabelAnnotation {
  /// Textual description, e.g. `Fixed-gear bicycle`.
  core.String description;

  /// Language code for `description` in BCP-47 format.
  core.String languageCode;

  /// Where the label was detected and with what confidence.
  core.List<GoogleCloudVideointelligenceV1beta1LabelLocation> locations;

  GoogleCloudVideointelligenceV1beta1LabelAnnotation();

  GoogleCloudVideointelligenceV1beta1LabelAnnotation.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("languageCode")) {
      languageCode = _json["languageCode"];
    }
    if (_json.containsKey("locations")) {
      locations = _json["locations"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta1LabelLocation.fromJson(
                  value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (description != null) {
      _json["description"] = description;
    }
    if (languageCode != null) {
      _json["languageCode"] = languageCode;
    }
    if (locations != null) {
      _json["locations"] = locations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Label location.
class GoogleCloudVideointelligenceV1beta1LabelLocation {
  /// Confidence that the label is accurate. Range: [0, 1].
  core.double confidence;

  /// Label level.
  /// Possible string values are:
  /// - "LABEL_LEVEL_UNSPECIFIED" : Unspecified.
  /// - "VIDEO_LEVEL" : Video-level. Corresponds to the whole video.
  /// - "SEGMENT_LEVEL" : Segment-level. Corresponds to one of
  /// `AnnotateSpec.segments`.
  /// - "SHOT_LEVEL" : Shot-level. Corresponds to a single shot (i.e. a series
  /// of frames
  /// without a major camera position or background change).
  /// - "FRAME_LEVEL" : Frame-level. Corresponds to a single video frame.
  core.String level;

  /// Video segment. Set to [-1, -1] for video-level labels.
  /// Set to [timestamp, timestamp] for frame-level labels.
  /// Otherwise, corresponds to one of `AnnotateSpec.segments`
  /// (if specified) or to shot boundaries (if requested).
  GoogleCloudVideointelligenceV1beta1VideoSegment segment;

  GoogleCloudVideointelligenceV1beta1LabelLocation();

  GoogleCloudVideointelligenceV1beta1LabelLocation.fromJson(core.Map _json) {
    if (_json.containsKey("confidence")) {
      confidence = _json["confidence"];
    }
    if (_json.containsKey("level")) {
      level = _json["level"];
    }
    if (_json.containsKey("segment")) {
      segment = new GoogleCloudVideointelligenceV1beta1VideoSegment.fromJson(
          _json["segment"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (confidence != null) {
      _json["confidence"] = confidence;
    }
    if (level != null) {
      _json["level"] = level;
    }
    if (segment != null) {
      _json["segment"] = (segment).toJson();
    }
    return _json;
  }
}

/// Safe search annotation (based on per-frame visual signals only).
/// If no unsafe content has been detected in a frame, no annotations
/// are present for that frame. If only some types of unsafe content
/// have been detected in a frame, the likelihood is set to `UNKNOWN`
/// for all other types of unsafe content.
class GoogleCloudVideointelligenceV1beta1SafeSearchAnnotation {
  /// Likelihood of adult content.
  /// Possible string values are:
  /// - "UNKNOWN" : Unknown likelihood.
  /// - "VERY_UNLIKELY" : Very unlikely.
  /// - "UNLIKELY" : Unlikely.
  /// - "POSSIBLE" : Possible.
  /// - "LIKELY" : Likely.
  /// - "VERY_LIKELY" : Very likely.
  core.String adult;

  /// Likelihood of medical content.
  /// Possible string values are:
  /// - "UNKNOWN" : Unknown likelihood.
  /// - "VERY_UNLIKELY" : Very unlikely.
  /// - "UNLIKELY" : Unlikely.
  /// - "POSSIBLE" : Possible.
  /// - "LIKELY" : Likely.
  /// - "VERY_LIKELY" : Very likely.
  core.String medical;

  /// Likelihood of racy content.
  /// Possible string values are:
  /// - "UNKNOWN" : Unknown likelihood.
  /// - "VERY_UNLIKELY" : Very unlikely.
  /// - "UNLIKELY" : Unlikely.
  /// - "POSSIBLE" : Possible.
  /// - "LIKELY" : Likely.
  /// - "VERY_LIKELY" : Very likely.
  core.String racy;

  /// Likelihood that an obvious modification was made to the original
  /// version to make it appear funny or offensive.
  /// Possible string values are:
  /// - "UNKNOWN" : Unknown likelihood.
  /// - "VERY_UNLIKELY" : Very unlikely.
  /// - "UNLIKELY" : Unlikely.
  /// - "POSSIBLE" : Possible.
  /// - "LIKELY" : Likely.
  /// - "VERY_LIKELY" : Very likely.
  core.String spoof;

  /// Video time offset in microseconds.
  core.String timeOffset;

  /// Likelihood of violent content.
  /// Possible string values are:
  /// - "UNKNOWN" : Unknown likelihood.
  /// - "VERY_UNLIKELY" : Very unlikely.
  /// - "UNLIKELY" : Unlikely.
  /// - "POSSIBLE" : Possible.
  /// - "LIKELY" : Likely.
  /// - "VERY_LIKELY" : Very likely.
  core.String violent;

  GoogleCloudVideointelligenceV1beta1SafeSearchAnnotation();

  GoogleCloudVideointelligenceV1beta1SafeSearchAnnotation.fromJson(
      core.Map _json) {
    if (_json.containsKey("adult")) {
      adult = _json["adult"];
    }
    if (_json.containsKey("medical")) {
      medical = _json["medical"];
    }
    if (_json.containsKey("racy")) {
      racy = _json["racy"];
    }
    if (_json.containsKey("spoof")) {
      spoof = _json["spoof"];
    }
    if (_json.containsKey("timeOffset")) {
      timeOffset = _json["timeOffset"];
    }
    if (_json.containsKey("violent")) {
      violent = _json["violent"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (adult != null) {
      _json["adult"] = adult;
    }
    if (medical != null) {
      _json["medical"] = medical;
    }
    if (racy != null) {
      _json["racy"] = racy;
    }
    if (spoof != null) {
      _json["spoof"] = spoof;
    }
    if (timeOffset != null) {
      _json["timeOffset"] = timeOffset;
    }
    if (violent != null) {
      _json["violent"] = violent;
    }
    return _json;
  }
}

/// Annotation progress for a single video.
class GoogleCloudVideointelligenceV1beta1VideoAnnotationProgress {
  /// Video file location in
  /// [Google Cloud Storage](https://cloud.google.com/storage/).
  core.String inputUri;

  /// Approximate percentage processed thus far.
  /// Guaranteed to be 100 when fully processed.
  core.int progressPercent;

  /// Time when the request was received.
  core.String startTime;

  /// Time of the most recent update.
  core.String updateTime;

  GoogleCloudVideointelligenceV1beta1VideoAnnotationProgress();

  GoogleCloudVideointelligenceV1beta1VideoAnnotationProgress.fromJson(
      core.Map _json) {
    if (_json.containsKey("inputUri")) {
      inputUri = _json["inputUri"];
    }
    if (_json.containsKey("progressPercent")) {
      progressPercent = _json["progressPercent"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
    if (_json.containsKey("updateTime")) {
      updateTime = _json["updateTime"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (inputUri != null) {
      _json["inputUri"] = inputUri;
    }
    if (progressPercent != null) {
      _json["progressPercent"] = progressPercent;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    if (updateTime != null) {
      _json["updateTime"] = updateTime;
    }
    return _json;
  }
}

/// Annotation results for a single video.
class GoogleCloudVideointelligenceV1beta1VideoAnnotationResults {
  /// If set, indicates an error. Note that for a single `AnnotateVideoRequest`
  /// some videos may succeed and some may fail.
  GoogleRpcStatus error;

  /// Video file location in
  /// [Google Cloud Storage](https://cloud.google.com/storage/).
  core.String inputUri;

  /// Label annotations. There is exactly one element for each unique label.
  core.List<GoogleCloudVideointelligenceV1beta1LabelAnnotation>
      labelAnnotations;

  /// Safe search annotations.
  core.List<GoogleCloudVideointelligenceV1beta1SafeSearchAnnotation>
      safeSearchAnnotations;

  /// Shot annotations. Each shot is represented as a video segment.
  core.List<GoogleCloudVideointelligenceV1beta1VideoSegment> shotAnnotations;

  GoogleCloudVideointelligenceV1beta1VideoAnnotationResults();

  GoogleCloudVideointelligenceV1beta1VideoAnnotationResults.fromJson(
      core.Map _json) {
    if (_json.containsKey("error")) {
      error = new GoogleRpcStatus.fromJson(_json["error"]);
    }
    if (_json.containsKey("inputUri")) {
      inputUri = _json["inputUri"];
    }
    if (_json.containsKey("labelAnnotations")) {
      labelAnnotations = _json["labelAnnotations"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta1LabelAnnotation.fromJson(
                  value))
          .toList();
    }
    if (_json.containsKey("safeSearchAnnotations")) {
      safeSearchAnnotations = _json["safeSearchAnnotations"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta1SafeSearchAnnotation
                  .fromJson(value))
          .toList();
    }
    if (_json.containsKey("shotAnnotations")) {
      shotAnnotations = _json["shotAnnotations"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta1VideoSegment.fromJson(
                  value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (error != null) {
      _json["error"] = (error).toJson();
    }
    if (inputUri != null) {
      _json["inputUri"] = inputUri;
    }
    if (labelAnnotations != null) {
      _json["labelAnnotations"] =
          labelAnnotations.map((value) => (value).toJson()).toList();
    }
    if (safeSearchAnnotations != null) {
      _json["safeSearchAnnotations"] =
          safeSearchAnnotations.map((value) => (value).toJson()).toList();
    }
    if (shotAnnotations != null) {
      _json["shotAnnotations"] =
          shotAnnotations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Video context and/or feature-specific parameters.
class GoogleCloudVideointelligenceV1beta1VideoContext {
  /// If label detection has been requested, what labels should be detected
  /// in addition to video-level labels or segment-level labels. If unspecified,
  /// defaults to `SHOT_MODE`.
  /// Possible string values are:
  /// - "LABEL_DETECTION_MODE_UNSPECIFIED" : Unspecified.
  /// - "SHOT_MODE" : Detect shot-level labels.
  /// - "FRAME_MODE" : Detect frame-level labels.
  /// - "SHOT_AND_FRAME_MODE" : Detect both shot-level and frame-level labels.
  core.String labelDetectionMode;

  /// Model to use for label detection.
  /// Supported values: "latest" and "stable" (the default).
  core.String labelDetectionModel;

  /// Model to use for safe search detection.
  /// Supported values: "latest" and "stable" (the default).
  core.String safeSearchDetectionModel;

  /// Video segments to annotate. The segments may overlap and are not required
  /// to be contiguous or span the whole video. If unspecified, each video
  /// is treated as a single segment.
  core.List<GoogleCloudVideointelligenceV1beta1VideoSegment> segments;

  /// Model to use for shot change detection.
  /// Supported values: "latest" and "stable" (the default).
  core.String shotChangeDetectionModel;

  /// Whether the video has been shot from a stationary (i.e. non-moving)
  /// camera.
  /// When set to true, might improve detection accuracy for moving objects.
  core.bool stationaryCamera;

  GoogleCloudVideointelligenceV1beta1VideoContext();

  GoogleCloudVideointelligenceV1beta1VideoContext.fromJson(core.Map _json) {
    if (_json.containsKey("labelDetectionMode")) {
      labelDetectionMode = _json["labelDetectionMode"];
    }
    if (_json.containsKey("labelDetectionModel")) {
      labelDetectionModel = _json["labelDetectionModel"];
    }
    if (_json.containsKey("safeSearchDetectionModel")) {
      safeSearchDetectionModel = _json["safeSearchDetectionModel"];
    }
    if (_json.containsKey("segments")) {
      segments = _json["segments"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta1VideoSegment.fromJson(
                  value))
          .toList();
    }
    if (_json.containsKey("shotChangeDetectionModel")) {
      shotChangeDetectionModel = _json["shotChangeDetectionModel"];
    }
    if (_json.containsKey("stationaryCamera")) {
      stationaryCamera = _json["stationaryCamera"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (labelDetectionMode != null) {
      _json["labelDetectionMode"] = labelDetectionMode;
    }
    if (labelDetectionModel != null) {
      _json["labelDetectionModel"] = labelDetectionModel;
    }
    if (safeSearchDetectionModel != null) {
      _json["safeSearchDetectionModel"] = safeSearchDetectionModel;
    }
    if (segments != null) {
      _json["segments"] = segments.map((value) => (value).toJson()).toList();
    }
    if (shotChangeDetectionModel != null) {
      _json["shotChangeDetectionModel"] = shotChangeDetectionModel;
    }
    if (stationaryCamera != null) {
      _json["stationaryCamera"] = stationaryCamera;
    }
    return _json;
  }
}

/// Video segment.
class GoogleCloudVideointelligenceV1beta1VideoSegment {
  /// End offset in microseconds (inclusive). Unset means 0.
  core.String endTimeOffset;

  /// Start offset in microseconds (inclusive). Unset means 0.
  core.String startTimeOffset;

  GoogleCloudVideointelligenceV1beta1VideoSegment();

  GoogleCloudVideointelligenceV1beta1VideoSegment.fromJson(core.Map _json) {
    if (_json.containsKey("endTimeOffset")) {
      endTimeOffset = _json["endTimeOffset"];
    }
    if (_json.containsKey("startTimeOffset")) {
      startTimeOffset = _json["startTimeOffset"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endTimeOffset != null) {
      _json["endTimeOffset"] = endTimeOffset;
    }
    if (startTimeOffset != null) {
      _json["startTimeOffset"] = startTimeOffset;
    }
    return _json;
  }
}

/// Video annotation progress. Included in the `metadata`
/// field of the `Operation` returned by the `GetOperation`
/// call of the `google::longrunning::Operations` service.
class GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress {
  /// Progress metadata for all videos specified in `AnnotateVideoRequest`.
  core.List<GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress>
      annotationProgress;

  GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress();

  GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress.fromJson(
      core.Map _json) {
    if (_json.containsKey("annotationProgress")) {
      annotationProgress = _json["annotationProgress"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress
                  .fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (annotationProgress != null) {
      _json["annotationProgress"] =
          annotationProgress.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Video annotation response. Included in the `response`
/// field of the `Operation` returned by the `GetOperation`
/// call of the `google::longrunning::Operations` service.
class GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse {
  /// Annotation results for all videos specified in `AnnotateVideoRequest`.
  core.List<GoogleCloudVideointelligenceV1beta2VideoAnnotationResults>
      annotationResults;

  GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse();

  GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse.fromJson(
      core.Map _json) {
    if (_json.containsKey("annotationResults")) {
      annotationResults = _json["annotationResults"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta2VideoAnnotationResults
                  .fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (annotationResults != null) {
      _json["annotationResults"] =
          annotationResults.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Detected entity from video analysis.
class GoogleCloudVideointelligenceV1beta2Entity {
  /// Textual description, e.g. `Fixed-gear bicycle`.
  core.String description;

  /// Opaque entity ID. Some IDs may be available in
  /// [Google Knowledge Graph Search
  /// API](https://developers.google.com/knowledge-graph/).
  core.String entityId;

  /// Language code for `description` in BCP-47 format.
  core.String languageCode;

  GoogleCloudVideointelligenceV1beta2Entity();

  GoogleCloudVideointelligenceV1beta2Entity.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("entityId")) {
      entityId = _json["entityId"];
    }
    if (_json.containsKey("languageCode")) {
      languageCode = _json["languageCode"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (description != null) {
      _json["description"] = description;
    }
    if (entityId != null) {
      _json["entityId"] = entityId;
    }
    if (languageCode != null) {
      _json["languageCode"] = languageCode;
    }
    return _json;
  }
}

/// Explicit content annotation (based on per-frame visual signals only).
/// If no explicit content has been detected in a frame, no annotations are
/// present for that frame.
class GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation {
  /// All video frames where explicit content was detected.
  core.List<GoogleCloudVideointelligenceV1beta2ExplicitContentFrame> frames;

  GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation();

  GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation.fromJson(
      core.Map _json) {
    if (_json.containsKey("frames")) {
      frames = _json["frames"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta2ExplicitContentFrame
                  .fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (frames != null) {
      _json["frames"] = frames.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Video frame level annotation results for explicit content.
class GoogleCloudVideointelligenceV1beta2ExplicitContentFrame {
  /// Likelihood of the pornography content..
  /// Possible string values are:
  /// - "LIKELIHOOD_UNSPECIFIED" : Unspecified likelihood.
  /// - "VERY_UNLIKELY" : Very unlikely.
  /// - "UNLIKELY" : Unlikely.
  /// - "POSSIBLE" : Possible.
  /// - "LIKELY" : Likely.
  /// - "VERY_LIKELY" : Very likely.
  core.String pornographyLikelihood;

  /// Time-offset, relative to the beginning of the video, corresponding to the
  /// video frame for this location.
  core.String timeOffset;

  GoogleCloudVideointelligenceV1beta2ExplicitContentFrame();

  GoogleCloudVideointelligenceV1beta2ExplicitContentFrame.fromJson(
      core.Map _json) {
    if (_json.containsKey("pornographyLikelihood")) {
      pornographyLikelihood = _json["pornographyLikelihood"];
    }
    if (_json.containsKey("timeOffset")) {
      timeOffset = _json["timeOffset"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (pornographyLikelihood != null) {
      _json["pornographyLikelihood"] = pornographyLikelihood;
    }
    if (timeOffset != null) {
      _json["timeOffset"] = timeOffset;
    }
    return _json;
  }
}

/// Label annotation.
class GoogleCloudVideointelligenceV1beta2LabelAnnotation {
  /// Common categories for the detected entity.
  /// E.g. when the label is `Terrier` the category is likely `dog`. And in some
  /// cases there might be more than one categories e.g. `Terrier` could also be
  /// a `pet`.
  core.List<GoogleCloudVideointelligenceV1beta2Entity> categoryEntities;

  /// Detected entity.
  GoogleCloudVideointelligenceV1beta2Entity entity;

  /// All video frames where a label was detected.
  core.List<GoogleCloudVideointelligenceV1beta2LabelFrame> frames;

  /// All video segments where a label was detected.
  core.List<GoogleCloudVideointelligenceV1beta2LabelSegment> segments;

  GoogleCloudVideointelligenceV1beta2LabelAnnotation();

  GoogleCloudVideointelligenceV1beta2LabelAnnotation.fromJson(core.Map _json) {
    if (_json.containsKey("categoryEntities")) {
      categoryEntities = _json["categoryEntities"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta2Entity.fromJson(value))
          .toList();
    }
    if (_json.containsKey("entity")) {
      entity = new GoogleCloudVideointelligenceV1beta2Entity.fromJson(
          _json["entity"]);
    }
    if (_json.containsKey("frames")) {
      frames = _json["frames"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta2LabelFrame.fromJson(value))
          .toList();
    }
    if (_json.containsKey("segments")) {
      segments = _json["segments"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta2LabelSegment.fromJson(
                  value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (categoryEntities != null) {
      _json["categoryEntities"] =
          categoryEntities.map((value) => (value).toJson()).toList();
    }
    if (entity != null) {
      _json["entity"] = (entity).toJson();
    }
    if (frames != null) {
      _json["frames"] = frames.map((value) => (value).toJson()).toList();
    }
    if (segments != null) {
      _json["segments"] = segments.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Video frame level annotation results for label detection.
class GoogleCloudVideointelligenceV1beta2LabelFrame {
  /// Confidence that the label is accurate. Range: [0, 1].
  core.double confidence;

  /// Time-offset, relative to the beginning of the video, corresponding to the
  /// video frame for this location.
  core.String timeOffset;

  GoogleCloudVideointelligenceV1beta2LabelFrame();

  GoogleCloudVideointelligenceV1beta2LabelFrame.fromJson(core.Map _json) {
    if (_json.containsKey("confidence")) {
      confidence = _json["confidence"];
    }
    if (_json.containsKey("timeOffset")) {
      timeOffset = _json["timeOffset"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (confidence != null) {
      _json["confidence"] = confidence;
    }
    if (timeOffset != null) {
      _json["timeOffset"] = timeOffset;
    }
    return _json;
  }
}

/// Video segment level annotation results for label detection.
class GoogleCloudVideointelligenceV1beta2LabelSegment {
  /// Confidence that the label is accurate. Range: [0, 1].
  core.double confidence;

  /// Video segment where a label was detected.
  GoogleCloudVideointelligenceV1beta2VideoSegment segment;

  GoogleCloudVideointelligenceV1beta2LabelSegment();

  GoogleCloudVideointelligenceV1beta2LabelSegment.fromJson(core.Map _json) {
    if (_json.containsKey("confidence")) {
      confidence = _json["confidence"];
    }
    if (_json.containsKey("segment")) {
      segment = new GoogleCloudVideointelligenceV1beta2VideoSegment.fromJson(
          _json["segment"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (confidence != null) {
      _json["confidence"] = confidence;
    }
    if (segment != null) {
      _json["segment"] = (segment).toJson();
    }
    return _json;
  }
}

/// Annotation progress for a single video.
class GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress {
  /// Video file location in
  /// [Google Cloud Storage](https://cloud.google.com/storage/).
  core.String inputUri;

  /// Approximate percentage processed thus far.
  /// Guaranteed to be 100 when fully processed.
  core.int progressPercent;

  /// Time when the request was received.
  core.String startTime;

  /// Time of the most recent update.
  core.String updateTime;

  GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress();

  GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress.fromJson(
      core.Map _json) {
    if (_json.containsKey("inputUri")) {
      inputUri = _json["inputUri"];
    }
    if (_json.containsKey("progressPercent")) {
      progressPercent = _json["progressPercent"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
    if (_json.containsKey("updateTime")) {
      updateTime = _json["updateTime"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (inputUri != null) {
      _json["inputUri"] = inputUri;
    }
    if (progressPercent != null) {
      _json["progressPercent"] = progressPercent;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    if (updateTime != null) {
      _json["updateTime"] = updateTime;
    }
    return _json;
  }
}

/// Annotation results for a single video.
class GoogleCloudVideointelligenceV1beta2VideoAnnotationResults {
  /// If set, indicates an error. Note that for a single `AnnotateVideoRequest`
  /// some videos may succeed and some may fail.
  GoogleRpcStatus error;

  /// Explicit content annotation.
  GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation
      explicitAnnotation;

  /// Label annotations on frame level.
  /// There is exactly one element for each unique label.
  core.List<GoogleCloudVideointelligenceV1beta2LabelAnnotation>
      frameLabelAnnotations;

  /// Video file location in
  /// [Google Cloud Storage](https://cloud.google.com/storage/).
  core.String inputUri;

  /// Label annotations on video level or user specified segment level.
  /// There is exactly one element for each unique label.
  core.List<GoogleCloudVideointelligenceV1beta2LabelAnnotation>
      segmentLabelAnnotations;

  /// Shot annotations. Each shot is represented as a video segment.
  core.List<GoogleCloudVideointelligenceV1beta2VideoSegment> shotAnnotations;

  /// Label annotations on shot level.
  /// There is exactly one element for each unique label.
  core.List<GoogleCloudVideointelligenceV1beta2LabelAnnotation>
      shotLabelAnnotations;

  GoogleCloudVideointelligenceV1beta2VideoAnnotationResults();

  GoogleCloudVideointelligenceV1beta2VideoAnnotationResults.fromJson(
      core.Map _json) {
    if (_json.containsKey("error")) {
      error = new GoogleRpcStatus.fromJson(_json["error"]);
    }
    if (_json.containsKey("explicitAnnotation")) {
      explicitAnnotation =
          new GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation
              .fromJson(_json["explicitAnnotation"]);
    }
    if (_json.containsKey("frameLabelAnnotations")) {
      frameLabelAnnotations = _json["frameLabelAnnotations"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta2LabelAnnotation.fromJson(
                  value))
          .toList();
    }
    if (_json.containsKey("inputUri")) {
      inputUri = _json["inputUri"];
    }
    if (_json.containsKey("segmentLabelAnnotations")) {
      segmentLabelAnnotations = _json["segmentLabelAnnotations"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta2LabelAnnotation.fromJson(
                  value))
          .toList();
    }
    if (_json.containsKey("shotAnnotations")) {
      shotAnnotations = _json["shotAnnotations"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta2VideoSegment.fromJson(
                  value))
          .toList();
    }
    if (_json.containsKey("shotLabelAnnotations")) {
      shotLabelAnnotations = _json["shotLabelAnnotations"]
          .map((value) =>
              new GoogleCloudVideointelligenceV1beta2LabelAnnotation.fromJson(
                  value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (error != null) {
      _json["error"] = (error).toJson();
    }
    if (explicitAnnotation != null) {
      _json["explicitAnnotation"] = (explicitAnnotation).toJson();
    }
    if (frameLabelAnnotations != null) {
      _json["frameLabelAnnotations"] =
          frameLabelAnnotations.map((value) => (value).toJson()).toList();
    }
    if (inputUri != null) {
      _json["inputUri"] = inputUri;
    }
    if (segmentLabelAnnotations != null) {
      _json["segmentLabelAnnotations"] =
          segmentLabelAnnotations.map((value) => (value).toJson()).toList();
    }
    if (shotAnnotations != null) {
      _json["shotAnnotations"] =
          shotAnnotations.map((value) => (value).toJson()).toList();
    }
    if (shotLabelAnnotations != null) {
      _json["shotLabelAnnotations"] =
          shotLabelAnnotations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Video segment.
class GoogleCloudVideointelligenceV1beta2VideoSegment {
  /// Time-offset, relative to the beginning of the video,
  /// corresponding to the end of the segment (inclusive).
  core.String endTimeOffset;

  /// Time-offset, relative to the beginning of the video,
  /// corresponding to the start of the segment (inclusive).
  core.String startTimeOffset;

  GoogleCloudVideointelligenceV1beta2VideoSegment();

  GoogleCloudVideointelligenceV1beta2VideoSegment.fromJson(core.Map _json) {
    if (_json.containsKey("endTimeOffset")) {
      endTimeOffset = _json["endTimeOffset"];
    }
    if (_json.containsKey("startTimeOffset")) {
      startTimeOffset = _json["startTimeOffset"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (endTimeOffset != null) {
      _json["endTimeOffset"] = endTimeOffset;
    }
    if (startTimeOffset != null) {
      _json["startTimeOffset"] = startTimeOffset;
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
