// This is a generated file (see the discoveryapis_generator project).

library googleapis.prediction.v1_6;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client prediction/v1.6';

/**
 * Lets you access a cloud hosted machine learning service that makes it easy to
 * build smart apps
 */
class PredictionApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /** Manage your data and permissions in Google Cloud Storage */
  static const DevstorageFullControlScope = "https://www.googleapis.com/auth/devstorage.full_control";

  /** View your data in Google Cloud Storage */
  static const DevstorageReadOnlyScope = "https://www.googleapis.com/auth/devstorage.read_only";

  /** Manage your data in Google Cloud Storage */
  static const DevstorageReadWriteScope = "https://www.googleapis.com/auth/devstorage.read_write";

  /** Manage your data in the Google Prediction API */
  static const PredictionScope = "https://www.googleapis.com/auth/prediction";


  final commons.ApiRequester _requester;

  HostedmodelsResourceApi get hostedmodels => new HostedmodelsResourceApi(_requester);
  TrainedmodelsResourceApi get trainedmodels => new TrainedmodelsResourceApi(_requester);

  PredictionApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "prediction/v1.6/projects/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class HostedmodelsResourceApi {
  final commons.ApiRequester _requester;

  HostedmodelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Submit input and request an output against a hosted model.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - The project associated with the model.
   *
   * [hostedModelName] - The name of a hosted model.
   *
   * Completes with a [Output].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Output> predict(Input request, core.String project, core.String hostedModelName) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (hostedModelName == null) {
      throw new core.ArgumentError("Parameter hostedModelName is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/hostedmodels/' + commons.Escaper.ecapeVariable('$hostedModelName') + '/predict';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Output.fromJson(data));
  }

}


class TrainedmodelsResourceApi {
  final commons.ApiRequester _requester;

  TrainedmodelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get analysis of the model and the data the model was trained on.
   *
   * Request parameters:
   *
   * [project] - The project associated with the model.
   *
   * [id] - The unique name for the predictive model.
   *
   * Completes with a [Analyze].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Analyze> analyze(core.String project, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/trainedmodels/' + commons.Escaper.ecapeVariable('$id') + '/analyze';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Analyze.fromJson(data));
  }

  /**
   * Delete a trained model.
   *
   * Request parameters:
   *
   * [project] - The project associated with the model.
   *
   * [id] - The unique name for the predictive model.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String project, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$project') + '/trainedmodels/' + commons.Escaper.ecapeVariable('$id');

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
   * Check training status of your model.
   *
   * Request parameters:
   *
   * [project] - The project associated with the model.
   *
   * [id] - The unique name for the predictive model.
   *
   * Completes with a [Insert2].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Insert2> get(core.String project, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/trainedmodels/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Insert2.fromJson(data));
  }

  /**
   * Train a Prediction API model.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - The project associated with the model.
   *
   * Completes with a [Insert2].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Insert2> insert(Insert request, core.String project) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/trainedmodels';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Insert2.fromJson(data));
  }

  /**
   * List available models.
   *
   * Request parameters:
   *
   * [project] - The project associated with the model.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Pagination token.
   *
   * Completes with a [List].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<List> list(core.String project, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/trainedmodels/list';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new List.fromJson(data));
  }

  /**
   * Submit model id and request a prediction.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - The project associated with the model.
   *
   * [id] - The unique name for the predictive model.
   *
   * Completes with a [Output].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Output> predict(Input request, core.String project, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/trainedmodels/' + commons.Escaper.ecapeVariable('$id') + '/predict';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Output.fromJson(data));
  }

  /**
   * Add new data to a trained model.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - The project associated with the model.
   *
   * [id] - The unique name for the predictive model.
   *
   * Completes with a [Insert2].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Insert2> update(Update request, core.String project, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/trainedmodels/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Insert2.fromJson(data));
  }

}



class AnalyzeDataDescriptionFeaturesCategoricalValues {
  /** Number of times this feature had this value. */
  core.String count;
  /** The category name. */
  core.String value;

  AnalyzeDataDescriptionFeaturesCategoricalValues();

  AnalyzeDataDescriptionFeaturesCategoricalValues.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (count != null) {
      _json["count"] = count;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** Description of the categorical values of this feature. */
class AnalyzeDataDescriptionFeaturesCategorical {
  /** Number of categorical values for this feature in the data. */
  core.String count;
  /** List of all the categories for this feature in the data set. */
  core.List<AnalyzeDataDescriptionFeaturesCategoricalValues> values;

  AnalyzeDataDescriptionFeaturesCategorical();

  AnalyzeDataDescriptionFeaturesCategorical.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("values")) {
      values = _json["values"].map((value) => new AnalyzeDataDescriptionFeaturesCategoricalValues.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (count != null) {
      _json["count"] = count;
    }
    if (values != null) {
      _json["values"] = values.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Description of the numeric values of this feature. */
class AnalyzeDataDescriptionFeaturesNumeric {
  /** Number of numeric values for this feature in the data set. */
  core.String count;
  /** Mean of the numeric values of this feature in the data set. */
  core.String mean;
  /** Variance of the numeric values of this feature in the data set. */
  core.String variance;

  AnalyzeDataDescriptionFeaturesNumeric();

  AnalyzeDataDescriptionFeaturesNumeric.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("mean")) {
      mean = _json["mean"];
    }
    if (_json.containsKey("variance")) {
      variance = _json["variance"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (count != null) {
      _json["count"] = count;
    }
    if (mean != null) {
      _json["mean"] = mean;
    }
    if (variance != null) {
      _json["variance"] = variance;
    }
    return _json;
  }
}

/** Description of multiple-word text values of this feature. */
class AnalyzeDataDescriptionFeaturesText {
  /** Number of multiple-word text values for this feature. */
  core.String count;

  AnalyzeDataDescriptionFeaturesText();

  AnalyzeDataDescriptionFeaturesText.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (count != null) {
      _json["count"] = count;
    }
    return _json;
  }
}

class AnalyzeDataDescriptionFeatures {
  /** Description of the categorical values of this feature. */
  AnalyzeDataDescriptionFeaturesCategorical categorical;
  /** The feature index. */
  core.String index;
  /** Description of the numeric values of this feature. */
  AnalyzeDataDescriptionFeaturesNumeric numeric;
  /** Description of multiple-word text values of this feature. */
  AnalyzeDataDescriptionFeaturesText text;

  AnalyzeDataDescriptionFeatures();

  AnalyzeDataDescriptionFeatures.fromJson(core.Map _json) {
    if (_json.containsKey("categorical")) {
      categorical = new AnalyzeDataDescriptionFeaturesCategorical.fromJson(_json["categorical"]);
    }
    if (_json.containsKey("index")) {
      index = _json["index"];
    }
    if (_json.containsKey("numeric")) {
      numeric = new AnalyzeDataDescriptionFeaturesNumeric.fromJson(_json["numeric"]);
    }
    if (_json.containsKey("text")) {
      text = new AnalyzeDataDescriptionFeaturesText.fromJson(_json["text"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (categorical != null) {
      _json["categorical"] = (categorical).toJson();
    }
    if (index != null) {
      _json["index"] = index;
    }
    if (numeric != null) {
      _json["numeric"] = (numeric).toJson();
    }
    if (text != null) {
      _json["text"] = (text).toJson();
    }
    return _json;
  }
}

/** Description of the output values in the data set. */
class AnalyzeDataDescriptionOutputFeatureNumeric {
  /** Number of numeric output values in the data set. */
  core.String count;
  /** Mean of the output values in the data set. */
  core.String mean;
  /** Variance of the output values in the data set. */
  core.String variance;

  AnalyzeDataDescriptionOutputFeatureNumeric();

  AnalyzeDataDescriptionOutputFeatureNumeric.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("mean")) {
      mean = _json["mean"];
    }
    if (_json.containsKey("variance")) {
      variance = _json["variance"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (count != null) {
      _json["count"] = count;
    }
    if (mean != null) {
      _json["mean"] = mean;
    }
    if (variance != null) {
      _json["variance"] = variance;
    }
    return _json;
  }
}

class AnalyzeDataDescriptionOutputFeatureText {
  /** Number of times the output label occurred in the data set. */
  core.String count;
  /** The output label. */
  core.String value;

  AnalyzeDataDescriptionOutputFeatureText();

  AnalyzeDataDescriptionOutputFeatureText.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (count != null) {
      _json["count"] = count;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** Description of the output value or label. */
class AnalyzeDataDescriptionOutputFeature {
  /** Description of the output values in the data set. */
  AnalyzeDataDescriptionOutputFeatureNumeric numeric;
  /** Description of the output labels in the data set. */
  core.List<AnalyzeDataDescriptionOutputFeatureText> text;

  AnalyzeDataDescriptionOutputFeature();

  AnalyzeDataDescriptionOutputFeature.fromJson(core.Map _json) {
    if (_json.containsKey("numeric")) {
      numeric = new AnalyzeDataDescriptionOutputFeatureNumeric.fromJson(_json["numeric"]);
    }
    if (_json.containsKey("text")) {
      text = _json["text"].map((value) => new AnalyzeDataDescriptionOutputFeatureText.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (numeric != null) {
      _json["numeric"] = (numeric).toJson();
    }
    if (text != null) {
      _json["text"] = text.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Description of the data the model was trained on. */
class AnalyzeDataDescription {
  /** Description of the input features in the data set. */
  core.List<AnalyzeDataDescriptionFeatures> features;
  /** Description of the output value or label. */
  AnalyzeDataDescriptionOutputFeature outputFeature;

  AnalyzeDataDescription();

  AnalyzeDataDescription.fromJson(core.Map _json) {
    if (_json.containsKey("features")) {
      features = _json["features"].map((value) => new AnalyzeDataDescriptionFeatures.fromJson(value)).toList();
    }
    if (_json.containsKey("outputFeature")) {
      outputFeature = new AnalyzeDataDescriptionOutputFeature.fromJson(_json["outputFeature"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (features != null) {
      _json["features"] = features.map((value) => (value).toJson()).toList();
    }
    if (outputFeature != null) {
      _json["outputFeature"] = (outputFeature).toJson();
    }
    return _json;
  }
}

/** Description of the model. */
class AnalyzeModelDescription {
  /**
   * An output confusion matrix. This shows an estimate for how this model will
   * do in predictions. This is first indexed by the true class label. For each
   * true class label, this provides a pair {predicted_label, count}, where
   * count is the estimated number of times the model will predict the predicted
   * label given the true label. Will not output if more then 100 classes
   * (Categorical models only).
   */
  core.Map<core.String, core.Map<core.String, core.String>> confusionMatrix;
  /** A list of the confusion matrix row totals. */
  core.Map<core.String, core.String> confusionMatrixRowTotals;
  /** Basic information about the model. */
  Insert2 modelinfo;

  AnalyzeModelDescription();

  AnalyzeModelDescription.fromJson(core.Map _json) {
    if (_json.containsKey("confusionMatrix")) {
      confusionMatrix = _json["confusionMatrix"];
    }
    if (_json.containsKey("confusionMatrixRowTotals")) {
      confusionMatrixRowTotals = _json["confusionMatrixRowTotals"];
    }
    if (_json.containsKey("modelinfo")) {
      modelinfo = new Insert2.fromJson(_json["modelinfo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (confusionMatrix != null) {
      _json["confusionMatrix"] = confusionMatrix;
    }
    if (confusionMatrixRowTotals != null) {
      _json["confusionMatrixRowTotals"] = confusionMatrixRowTotals;
    }
    if (modelinfo != null) {
      _json["modelinfo"] = (modelinfo).toJson();
    }
    return _json;
  }
}

class Analyze {
  /** Description of the data the model was trained on. */
  AnalyzeDataDescription dataDescription;
  /** List of errors with the data. */
  core.List<core.Map<core.String, core.String>> errors;
  /** The unique name for the predictive model. */
  core.String id;
  /** What kind of resource this is. */
  core.String kind;
  /** Description of the model. */
  AnalyzeModelDescription modelDescription;
  /** A URL to re-request this resource. */
  core.String selfLink;

  Analyze();

  Analyze.fromJson(core.Map _json) {
    if (_json.containsKey("dataDescription")) {
      dataDescription = new AnalyzeDataDescription.fromJson(_json["dataDescription"]);
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("modelDescription")) {
      modelDescription = new AnalyzeModelDescription.fromJson(_json["modelDescription"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dataDescription != null) {
      _json["dataDescription"] = (dataDescription).toJson();
    }
    if (errors != null) {
      _json["errors"] = errors;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (modelDescription != null) {
      _json["modelDescription"] = (modelDescription).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/** Input to the model for a prediction. */
class InputInput {
  /**
   * A list of input features, these can be strings or doubles.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> csvInstance;

  InputInput();

  InputInput.fromJson(core.Map _json) {
    if (_json.containsKey("csvInstance")) {
      csvInstance = _json["csvInstance"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (csvInstance != null) {
      _json["csvInstance"] = csvInstance;
    }
    return _json;
  }
}

class Input {
  /** Input to the model for a prediction. */
  InputInput input;

  Input();

  Input.fromJson(core.Map _json) {
    if (_json.containsKey("input")) {
      input = new InputInput.fromJson(_json["input"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (input != null) {
      _json["input"] = (input).toJson();
    }
    return _json;
  }
}

class InsertTrainingInstances {
  /**
   * The input features for this instance.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> csvInstance;
  /** The generic output value - could be regression or class label. */
  core.String output;

  InsertTrainingInstances();

  InsertTrainingInstances.fromJson(core.Map _json) {
    if (_json.containsKey("csvInstance")) {
      csvInstance = _json["csvInstance"];
    }
    if (_json.containsKey("output")) {
      output = _json["output"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (csvInstance != null) {
      _json["csvInstance"] = csvInstance;
    }
    if (output != null) {
      _json["output"] = output;
    }
    return _json;
  }
}

class Insert {
  /** The unique name for the predictive model. */
  core.String id;
  /** Type of predictive model (classification or regression). */
  core.String modelType;
  /** The Id of the model to be copied over. */
  core.String sourceModel;
  /** Google storage location of the training data file. */
  core.String storageDataLocation;
  /** Google storage location of the preprocessing pmml file. */
  core.String storagePMMLLocation;
  /** Google storage location of the pmml model file. */
  core.String storagePMMLModelLocation;
  /** Instances to train model on. */
  core.List<InsertTrainingInstances> trainingInstances;
  /**
   * A class weighting function, which allows the importance weights for class
   * labels to be specified (Categorical models only).
   */
  core.List<core.Map<core.String, core.double>> utility;

  Insert();

  Insert.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("modelType")) {
      modelType = _json["modelType"];
    }
    if (_json.containsKey("sourceModel")) {
      sourceModel = _json["sourceModel"];
    }
    if (_json.containsKey("storageDataLocation")) {
      storageDataLocation = _json["storageDataLocation"];
    }
    if (_json.containsKey("storagePMMLLocation")) {
      storagePMMLLocation = _json["storagePMMLLocation"];
    }
    if (_json.containsKey("storagePMMLModelLocation")) {
      storagePMMLModelLocation = _json["storagePMMLModelLocation"];
    }
    if (_json.containsKey("trainingInstances")) {
      trainingInstances = _json["trainingInstances"].map((value) => new InsertTrainingInstances.fromJson(value)).toList();
    }
    if (_json.containsKey("utility")) {
      utility = _json["utility"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (modelType != null) {
      _json["modelType"] = modelType;
    }
    if (sourceModel != null) {
      _json["sourceModel"] = sourceModel;
    }
    if (storageDataLocation != null) {
      _json["storageDataLocation"] = storageDataLocation;
    }
    if (storagePMMLLocation != null) {
      _json["storagePMMLLocation"] = storagePMMLLocation;
    }
    if (storagePMMLModelLocation != null) {
      _json["storagePMMLModelLocation"] = storagePMMLModelLocation;
    }
    if (trainingInstances != null) {
      _json["trainingInstances"] = trainingInstances.map((value) => (value).toJson()).toList();
    }
    if (utility != null) {
      _json["utility"] = utility;
    }
    return _json;
  }
}

/** Model metadata. */
class Insert2ModelInfo {
  /**
   * Estimated accuracy of model taking utility weights into account
   * (Categorical models only).
   */
  core.String classWeightedAccuracy;
  /**
   * A number between 0.0 and 1.0, where 1.0 is 100% accurate. This is an
   * estimate, based on the amount and quality of the training data, of the
   * estimated prediction accuracy. You can use this is a guide to decide
   * whether the results are accurate enough for your needs. This estimate will
   * be more reliable if your real input data is similar to your training data
   * (Categorical models only).
   */
  core.String classificationAccuracy;
  /**
   * An estimated mean squared error. The can be used to measure the quality of
   * the predicted model (Regression models only).
   */
  core.String meanSquaredError;
  /** Type of predictive model (CLASSIFICATION or REGRESSION). */
  core.String modelType;
  /** Number of valid data instances used in the trained model. */
  core.String numberInstances;
  /** Number of class labels in the trained model (Categorical models only). */
  core.String numberLabels;

  Insert2ModelInfo();

  Insert2ModelInfo.fromJson(core.Map _json) {
    if (_json.containsKey("classWeightedAccuracy")) {
      classWeightedAccuracy = _json["classWeightedAccuracy"];
    }
    if (_json.containsKey("classificationAccuracy")) {
      classificationAccuracy = _json["classificationAccuracy"];
    }
    if (_json.containsKey("meanSquaredError")) {
      meanSquaredError = _json["meanSquaredError"];
    }
    if (_json.containsKey("modelType")) {
      modelType = _json["modelType"];
    }
    if (_json.containsKey("numberInstances")) {
      numberInstances = _json["numberInstances"];
    }
    if (_json.containsKey("numberLabels")) {
      numberLabels = _json["numberLabels"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (classWeightedAccuracy != null) {
      _json["classWeightedAccuracy"] = classWeightedAccuracy;
    }
    if (classificationAccuracy != null) {
      _json["classificationAccuracy"] = classificationAccuracy;
    }
    if (meanSquaredError != null) {
      _json["meanSquaredError"] = meanSquaredError;
    }
    if (modelType != null) {
      _json["modelType"] = modelType;
    }
    if (numberInstances != null) {
      _json["numberInstances"] = numberInstances;
    }
    if (numberLabels != null) {
      _json["numberLabels"] = numberLabels;
    }
    return _json;
  }
}

class Insert2 {
  /** Insert time of the model (as a RFC 3339 timestamp). */
  core.DateTime created;
  /** The unique name for the predictive model. */
  core.String id;
  /** What kind of resource this is. */
  core.String kind;
  /** Model metadata. */
  Insert2ModelInfo modelInfo;
  /** Type of predictive model (CLASSIFICATION or REGRESSION). */
  core.String modelType;
  /** A URL to re-request this resource. */
  core.String selfLink;
  /** Google storage location of the training data file. */
  core.String storageDataLocation;
  /** Google storage location of the preprocessing pmml file. */
  core.String storagePMMLLocation;
  /** Google storage location of the pmml model file. */
  core.String storagePMMLModelLocation;
  /** Training completion time (as a RFC 3339 timestamp). */
  core.DateTime trainingComplete;
  /**
   * The current status of the training job. This can be one of following:
   * RUNNING; DONE; ERROR; ERROR: TRAINING JOB NOT FOUND
   */
  core.String trainingStatus;

  Insert2();

  Insert2.fromJson(core.Map _json) {
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("modelInfo")) {
      modelInfo = new Insert2ModelInfo.fromJson(_json["modelInfo"]);
    }
    if (_json.containsKey("modelType")) {
      modelType = _json["modelType"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("storageDataLocation")) {
      storageDataLocation = _json["storageDataLocation"];
    }
    if (_json.containsKey("storagePMMLLocation")) {
      storagePMMLLocation = _json["storagePMMLLocation"];
    }
    if (_json.containsKey("storagePMMLModelLocation")) {
      storagePMMLModelLocation = _json["storagePMMLModelLocation"];
    }
    if (_json.containsKey("trainingComplete")) {
      trainingComplete = core.DateTime.parse(_json["trainingComplete"]);
    }
    if (_json.containsKey("trainingStatus")) {
      trainingStatus = _json["trainingStatus"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (modelInfo != null) {
      _json["modelInfo"] = (modelInfo).toJson();
    }
    if (modelType != null) {
      _json["modelType"] = modelType;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (storageDataLocation != null) {
      _json["storageDataLocation"] = storageDataLocation;
    }
    if (storagePMMLLocation != null) {
      _json["storagePMMLLocation"] = storagePMMLLocation;
    }
    if (storagePMMLModelLocation != null) {
      _json["storagePMMLModelLocation"] = storagePMMLModelLocation;
    }
    if (trainingComplete != null) {
      _json["trainingComplete"] = (trainingComplete).toIso8601String();
    }
    if (trainingStatus != null) {
      _json["trainingStatus"] = trainingStatus;
    }
    return _json;
  }
}

class List {
  /** List of models. */
  core.List<Insert2> items;
  /** What kind of resource this is. */
  core.String kind;
  /** Pagination token to fetch the next page, if one exists. */
  core.String nextPageToken;
  /** A URL to re-request this resource. */
  core.String selfLink;

  List();

  List.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Insert2.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

class OutputOutputMulti {
  /** The class label. */
  core.String label;
  /** The probability of the class label. */
  core.String score;

  OutputOutputMulti();

  OutputOutputMulti.fromJson(core.Map _json) {
    if (_json.containsKey("label")) {
      label = _json["label"];
    }
    if (_json.containsKey("score")) {
      score = _json["score"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (label != null) {
      _json["label"] = label;
    }
    if (score != null) {
      _json["score"] = score;
    }
    return _json;
  }
}

class Output {
  /** The unique name for the predictive model. */
  core.String id;
  /** What kind of resource this is. */
  core.String kind;
  /** The most likely class label (Categorical models only). */
  core.String outputLabel;
  /**
   * A list of class labels with their estimated probabilities (Categorical
   * models only).
   */
  core.List<OutputOutputMulti> outputMulti;
  /** The estimated regression value (Regression models only). */
  core.String outputValue;
  /** A URL to re-request this resource. */
  core.String selfLink;

  Output();

  Output.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("outputLabel")) {
      outputLabel = _json["outputLabel"];
    }
    if (_json.containsKey("outputMulti")) {
      outputMulti = _json["outputMulti"].map((value) => new OutputOutputMulti.fromJson(value)).toList();
    }
    if (_json.containsKey("outputValue")) {
      outputValue = _json["outputValue"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (outputLabel != null) {
      _json["outputLabel"] = outputLabel;
    }
    if (outputMulti != null) {
      _json["outputMulti"] = outputMulti.map((value) => (value).toJson()).toList();
    }
    if (outputValue != null) {
      _json["outputValue"] = outputValue;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

class Update {
  /**
   * The input features for this instance.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Object> csvInstance;
  /** The generic output value - could be regression or class label. */
  core.String output;

  Update();

  Update.fromJson(core.Map _json) {
    if (_json.containsKey("csvInstance")) {
      csvInstance = _json["csvInstance"];
    }
    if (_json.containsKey("output")) {
      output = _json["output"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (csvInstance != null) {
      _json["csvInstance"] = csvInstance;
    }
    if (output != null) {
      _json["output"] = output;
    }
    return _json;
  }
}
